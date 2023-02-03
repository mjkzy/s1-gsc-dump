// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

precachedooranimations()
{
    level.scr_anim["DoorOpenNPC"]["door_kick_in"] = %door_kick_in;
    level.scr_anim["DoorOpenNPC"]["slow_door_open"] = %hunted_open_barndoor;
    level.scr_anim["DoorOpenNPC"]["charge_door_open"] = %africa_soap_shoulder_charge_door;
    level.scr_anim["DoorOpenNPC"]["shoot_hinge_door_open"] = %shotgunbreach_v1_shoot_hinge_runin;
    level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_breach_idle_start"][0] = %hms_greece_cc_meeting_breach_idle_start_npc;
    level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_breach"] = %hms_greece_cc_meeting_breach_npc;
    level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_breach_idle_hold"][0] = %hms_greece_cc_meeting_breach_idle_hold_npc;
    level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_bodycheck"] = %hms_greece_cc_meeting_bodycheck_npc;
    level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_breach_idle_start"][0] = %hms_greece_cc_meeting_breach_idle_start_npc1;
    level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_breach"] = %hms_greece_cc_meeting_breach_npc1;
    level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_breach_idle_hold"][0] = %hms_greece_cc_meeting_breach_idle_hold_npc1;
    level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_bodycheck"] = %hms_greece_cc_meeting_bodycheck_npc1;
}

opendoor( var_0, var_1, var_2 )
{
    if ( var_1 != "pop" && var_1 != "fast" && !isdefined( var_2 ) )
    {

    }

    if ( isdefined( var_2 ) )
    {
        foreach ( var_4 in var_2 )
        {
            if ( !isai( var_4 ) )
            {

            }
        }
    }

    var_6 = common_scripts\utility::getstruct( var_0, "targetname" );
    var_7 = var_6.target;
    var_8 = getentarray( var_6.target, "targetname" );

    foreach ( var_10 in var_8 )
    {
        if ( var_10.script_noteworthy == "door" )
        {
            var_11 = var_10;
            var_8 = common_scripts\utility::array_remove( var_8, var_11 );

            if ( !isdefined( var_11.state ) )
                var_11.state = "closed";

            if ( var_1 == "pop" )
                var_11 thread _popopen();
            else if ( var_1 == "fast" )
                var_11 thread _fastopen( 0 );
            else if ( isdefined( var_2 ) && isarray( var_2 ) )
                thread _setupdooranimstyle( var_11, var_8, var_1, var_2 );
            else
                _setupdooranimstyle( var_11, var_8, var_1 );

            return var_11;
        }
    }
}

_setupdooranimstyle( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) || !isstring( var_2 ) )
        var_2 = "slow";

    switch ( var_2 )
    {
        case "slow":
            var_4 = "slow_door_open";
            var_5 = _returnanimorigin( var_1, var_2 );
            thread _startdooropen( var_0, var_5, var_4, var_2 );
            break;
        case "kick":
            var_4 = "door_kick_in";
            var_5 = _returnanimorigin( var_1, var_2 );
            thread _startdooropen( var_0, var_5, var_4, var_2 );
            break;
        case "charge":
            var_4 = "charge_door_open";
            var_5 = _returnanimorigin( var_1, var_2 );
            thread _startdooropen( var_0, var_5, var_4, var_2 );
            break;
        case "hinge":
            var_4 = "shoot_hinge_door_open";
            var_5 = _returnanimorigin( var_1, var_2 );
            thread _startdooropen( var_0, var_5, var_4, var_2 );
            break;
        case "cc_breach":
            var_5 = _returnanimorigin( var_1, var_2 );
            thread _squaddoorbreach( var_0, var_5, var_3 );
            break;
    }
}

_returnanimorigin( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( var_1 == var_3.script_noteworthy )
        {
            var_4 = var_3;
            return var_4;
        }
    }
}

_startdooropen( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "dying" );
    var_4 = self.goalradius;
    self.goalradius = 32;
    var_5 = self.animname;
    self.animname = "DoorOpenNPC";
    var_1 maps\_anim::anim_reach_solo( self, var_2 );

    if ( var_3 == "kick" )
        var_0 thread _fastopen( 2.15 );
    else if ( var_3 == "slow" )
        var_0 thread _slowopen( 1.8 );
    else if ( var_3 == "charge" )
        var_0 thread _fastopen( 2.45 );
    else if ( var_3 == "hinge" )
        var_0 thread _fastopen( 1.82 );

    var_1 maps\_anim::anim_single_solo_run( self, var_2 );
    self.animname = var_5;
    self.goalradius = var_4;
    var_0 notify( "Open" );
}

_squaddoorbreach( var_0, var_1, var_2 )
{
    var_3 = 1;

    foreach ( var_5 in var_2 )
    {
        var_5.oldgoalradius = var_5.goalradius;
        var_5.previousgoalnode = var_5.last_set_goalnode;
        var_5.oldgrenadeawareness = var_5.grenadeawareness;
        var_5.goalradius = 32;
        var_5.oldanimname = var_5.animname;
        var_5.animname = "BreachGuy" + var_3;
        var_5 maps\_utility::setflashbangimmunity( 1 );
        var_5.grenadeawareness = 0;
        var_3++;
    }

    var_7 = "hms_greece_cc_meeting_breach_idle_start";
    var_8 = "hms_greece_cc_meeting_breach";
    var_9 = "hms_greece_cc_meeting_breach_idle_hold";
    var_10 = "hms_greece_cc_meeting_bodycheck";
    var_1 thread maps\_anim::anim_loop( var_2, var_7, "stop_idle_start" );
    level waittill( "cc_final_breach" );
    var_1 notify( "stop_idle_start" );
    var_0 thread _fastopen( 0.96 );
    thread _handlebreachgrenade( var_0, var_1, var_2 );
    var_1 maps\_anim::anim_single( var_2, var_8 );
    var_1 thread maps\_anim::anim_loop( var_2, var_9, "stop_idle_hold" );
    level waittill( "cc_bodycheck" );
    var_1 notify( "stop_idle_hold" );
    var_1 maps\_anim::anim_single_run( var_2, var_10 );

    foreach ( var_5 in var_2 )
    {
        var_5.animname = var_5.oldanimname;
        var_5.goalradius = var_5.oldgoalradius;
        var_5 maps\_utility::setflashbangimmunity( 0 );
        var_5.grenadeawareness = var_5.oldgrenadeawareness;
    }
}

_handlebreachgrenade( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_2 )
    {
        if ( var_4.animname == "BreachGuy2" )
        {
            var_5 = anglestoright( var_1.angles );
            var_6 = var_1.origin;
            var_7 = var_6 + var_5 * 256;
            var_8 = var_4 _delaygrenadethrow( 2.1, var_7 );
            var_8 waittill( "death" );
            var_0 notify( "flashbang_done" );
        }
    }
}

_delaygrenadethrow( var_0, var_1 )
{
    var_2 = "tag_eye";

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        wait(var_0);
        var_3 = self gettagorigin( var_2 );
        var_4 = self gettagangles( var_2 );
        var_5 = anglestoforward( var_4 );
        var_6 = var_3 + var_5 * 16;
        var_7 = magicgrenade( "flash_grenade", var_6, var_1, 1.5 );
        return var_7;
    }
}

_fastopen( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 120;

    if ( isdefined( var_0 ) && var_0 > 0 )
        wait(var_0);

    self rotateto( self.angles + ( 0, var_1, 0 ), 0.35, 0, 0.35 );
    earthquake( 0.25, 0.2, self.origin, 256 );

    if ( self.classname != "script_model" )
        self connectpaths();

    self.state = "open";
    self notify( "Open" );
}

_slowopen( var_0 )
{
    if ( isdefined( var_0 ) && var_0 > 0 )
        wait(var_0);

    self rotateto( self.angles + ( 0, 100, 0 ), 2, 0.5, 0 );

    if ( self.classname != "script_model" )
        self connectpaths();

    self.state = "open";
    self notify( "Open" );
}

_popopen()
{
    if ( self.state == "closed" )
    {
        self rotateto( self.angles + ( 0, 100, 0 ), 0.1, 0, 0 );

        if ( self.classname != "script_model" )
            self connectpaths();

        self.state = "open";
    }

    self notify( "Open" );
}
