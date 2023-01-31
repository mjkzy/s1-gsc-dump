// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

initialize()
{
    _func_0D3( "vehHelicopterControlsAltitude", 1 );
    precachemodel( "tag_laser" );
    precacheitem( "pdrone_weapon" );
    precacheitem( "pdrone_weapon_bullet" );
    precacheshader( "dpad_killstreak_remote_uav" );
    precacheshader( "dpad_laser_designator" );
}

give_player_pdrone( var_0 )
{
    self.pdroneactive = 0;
    self.pdronereturning = 0;
    self _meth_821B( "actionslot4", "dpad_killstreak_remote_uav" );
    self _meth_82DD( "use_pdrone", "+actionslot 4" );

    for (;;)
    {
        self waittill( "use_pdrone" );

        if ( self _meth_812C() )
            continue;

        if ( !self.pdroneactive )
        {
            self _meth_8131( 0 );
            var_1 = self _meth_8312();
            self _meth_830F( var_1 );
            self _meth_830E( "pdrone_weapon_bullet" );
            self _meth_8316( "pdrone_weapon_bullet" );
            self _meth_8332( "pdrone_weapon_bullet" );
            wait_til_pdrone_launched();
            self _meth_8131( 1 );

            if ( isdefined( self.pdrone_launched ) && self.pdrone_launched )
            {
                self _meth_8321();
                self _meth_831F();
                wait 1.75;
                pdrone_launch( var_0 );
                self.pdrone_launched = undefined;
                wait 0.25;
                self _meth_8320();
                self _meth_8322();
            }

            self _meth_830F( "pdrone_weapon_bullet" );
            self _meth_830E( var_1 );
            self _meth_8316( var_1 );
            continue;
        }

        pdrone_return();
    }
}

pdrone_return()
{
    var_0 = self;
    var_1 = var_0.pdrone;
    var_1 maps\_utility::ent_flag_clear( "sentient_controlled" );
    var_0 notify( "pdrone_returning" );
    var_1 thread pdrone_return_pathing();
    var_1 waittill( "goal" );
    var_1 delete();
    var_0 notify( "pdrone_returned" );
}

pdrone_return_pathing()
{
    self endon( "goal" );
    self.goalradius = 40;
    self _meth_8283( 20, 20, 20 );
    self _meth_8265( self.owner );

    for (;;)
    {
        self _meth_825B( self.owner.origin + ( 0, 0, 84 ), 0 );
        wait 0.05;
    }
}

wait_til_pdrone_launched()
{
    self endon( "death" );
    self endon( "use_pdrone" );
    self endon( "weapon_switch_started" );
    self _meth_82DD( "launch_pdrone", "+attack" );
    self waittill( "launch_pdrone" );
    self.pdrone_launched = 1;
}

pdrone_launch( var_0 )
{
    self.pdroneactive = 1;
    var_1 = spawn_pdrone( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_1 _meth_8139( self.team );
        var_1.team = self.team;
        var_1.pov_mode = 0;
        var_1.owner = self;

        if ( self.team == "allies" )
            var_1 maps\_vehicle::godon();

        self.pdrone = var_1;
        self notify( "pdrone_launched" );
        self.pdrone = var_1;
        var_1 thread pdrone_monitor_death();
    }
}

spawn_pdrone( var_0 )
{
    while ( isdefined( var_0.available ) && !var_0.available )
        wait 0.05;

    if ( !isdefined( self ) )
        return undefined;

    var_0.available = 0;
    var_0.script_team = self.team;

    if ( isplayer( self ) )
        var_1 = self getangles();
    else
        var_1 = self.angles;

    var_2 = anglestoforward( var_1 );
    var_3 = anglestoup( var_1 );
    var_4 = var_2 * 24 + var_3 * 100;

    if ( var_4[2] < 80 )
        var_4 += ( 0, 0, 80 - var_4[2] );

    var_0.origin = self.origin + var_4;
    var_0.angles = self.angles;
    waittillframeend;
    var_0.available = 1;

    if ( isdefined( self ) && isalive( self ) )
        return var_0 maps\_utility::spawn_vehicle();
    else
        return undefined;
}

pdrone_monitor_death()
{
    self waittill( "death" );

    if ( isdefined( self ) )
    {
        if ( isdefined( self.owner ) )
            self.owner.pdroneactive = 0;
    }
}

pd_laser_targeting_device( var_0 )
{
    var_0 endon( "remove_laser_targeting_device" );
    var_0.lastusedweapon = undefined;
    var_0.laserforceon = 0;
    var_0 _meth_821B( "actionslot4", "dpad_laser_designator" );
    var_0 _meth_82DD( "use_laser", "+actionslot 4" );
    var_0 _meth_82DD( "fired_laser", "+attack" );
    var_0 childthread pd_monitorlaseroff();

    for (;;)
    {
        var_0 waittill( "use_laser" );

        if ( var_0.laserforceon || var_0 pd_shouldforcedisablelaser() )
        {
            var_0 notify( "cancel_laser" );
            var_0 _meth_80B3();
            var_0.laserforceon = 0;
            wait 0.2;
            var_0 _meth_8131( 1 );
        }
        else
        {
            var_0 _meth_80B2();
            var_0 _meth_8131( 0 );
            var_0.laserforceon = 1;
            var_0 thread pd_laser_designate_target();
        }

        wait 0.05;
    }
}

pd_shouldforcedisablelaser()
{
    var_0 = self _meth_8311();

    if ( var_0 == "rpg" )
        return 1;

    if ( var_0 == "c4" )
        return 1;

    if ( common_scripts\utility::string_starts_with( var_0, "gl" ) )
        return 1;

    if ( var_0 == "pdrone_weapon_bullet" )
        return 1;

    if ( isdefined( level.laser_designator_disable_list ) && isarray( level.laser_designator_disable_list ) )
    {
        foreach ( var_2 in level.laser_designator_disable_list )
        {
            if ( var_0 == var_2 )
                return 1;
        }
    }

    if ( self _meth_8336() )
        return 1;

    if ( self _meth_812C() )
        return 1;

    return 0;
}

pd_monitorlaseroff()
{
    for (;;)
    {
        if ( pd_shouldforcedisablelaser() && isdefined( self.laserforceon ) && self.laserforceon )
        {
            self notify( "use_laser" );
            wait 2.0;
        }

        wait 0.05;
    }
}

pd_laser_designate_target()
{
    self endon( "cancel_laser" );
    self waittill( "fired_laser" );
    var_0 = pd_get_laser_designated_trace();
    var_1 = var_0["position"];
    var_2 = var_0["entity"];

    if ( distance( self.origin, var_1 ) < 100000 )
        self notify( "pdrone_defend_point", var_0 );
    else
        iprintln( "too far" );

    wait 0.05;
    self notify( "use_laser" );
}

pd_get_laser_designated_trace()
{
    var_0 = self _meth_80A8();
    var_1 = self getangles();
    var_2 = anglestoforward( var_1 );
    var_3 = var_0 + var_2 * 7000;
    var_4 = bullettrace( var_0, var_3, 0, self );
    var_5 = var_4["entity"];

    if ( isdefined( var_5 ) )
        var_4["position"] = var_5.origin;

    return var_4;
}
