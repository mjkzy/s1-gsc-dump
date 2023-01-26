// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["mp_dam"] = ::tryusedamkillstreak;
    level.mapkillstreak = "mp_dam";
    level._id_598A = &"MP_DAM_MAP_KILLSTREAK_PICKUP";
    level.dam_killstreak_duration = 30;
    precacheshader( "s1_railgun_hud_reticle_center" );
    precacheshader( "s1_railgun_hud_reticle_meter_circ" );
    precacheshader( "s1_railgun_hud_inner_frame_edge" );
    precacheshader( "s1_railgun_hud_inner_frame_edge_right" );
    precacheitem( "killstreak_dam_mp" );
    precachemodel( "mp_dam_large_caliber_turret" );
    level._id_4AE9 = [];
}

tryusedamkillstreak( var_0, var_1 )
{
    if ( isdefined( level.mp_dam_player ) )
    {
        self iclientprintlnbold( &"MP_DAM_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    if ( isdefined( self._id_219A ) && self._id_219A == 1 )
    {
        self iclientprintlnbold( &"MP_WARBIRD_ACTIVE" );
        return 0;
    }

    var_2 = maps\mp\killstreaks\_killstreaks::initridekillstreak();

    if ( var_2 != "success" )
        return 0;

    maps\mp\_utility::setusingremote( "mp_dam" );
    var_2 = setmpdamplayer( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_dam", self.origin );
    else if ( maps\mp\_utility::isusingremote() )
        maps\mp\_utility::clearusingremote();

    return var_2;
}

setmpdamplayer( var_0 )
{
    self endon( "mp_dam_player_removed" );

    if ( isdefined( level.mp_dam_player ) )
        return 0;

    level.mp_dam_player = var_0;
    var_0 notifyonplayercommand( "SwitchTurret", "weapnext" );
    var_0 notifyonplayercommand( "SwitchVisionMode", "+actionslot 1" );
    thread maps\mp\_utility::teamplayercardsplash( "used_mp_dam", var_0 );
    var_0 thread _id_A051( 1.0 );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::setthirdpersondof( 0 );

    var_0 thread cycleturretcontrol();
    var_0 thread removempdamplayeraftertime( level.dam_killstreak_duration );
    var_0 thread removempdamplayerondisconnect();
    var_0 thread removempdamplayeronchangeteams();
    var_0 thread removempdamplayeronspectate();
    var_0 thread removempdamplayerongamecleanup();
    var_0 thread removempdamplayeroncommand();
    return 1;
}

cycleturretcontrol()
{
    self endon( "mp_dam_player_removed" );
    var_0 = self;

    if ( isdefined( level.damturrets ) )
    {
        var_0 _meth_80FE( 0.2, 0.2 );

        for (;;)
        {
            for ( var_1 = 0; var_1 < level.damturrets.size; var_1++ )
            {
                var_2 = level.damturrets[var_1];
                var_2.owner = var_0;
                var_2.team = var_0.team;
                var_2.pers["team"] = var_0.team;

                if ( level.teambased )
                    var_2 _meth_8135( var_0.team );

                var_0.turret = var_2;
                var_2 _meth_8065( "sentry_manual" );
                var_2 _meth_8103( var_0 );
                var_0 thread _id_8439( var_2 );

                if ( var_1 == 0 )
                    var_0 _meth_807E( var_2, "tag_player", 0, 60, 30, 5, 58, 0 );
                else
                    var_0 _meth_807E( var_2, "tag_player", 0, 40, 50, 5, 58, 0 );

                var_0 _meth_80A1( 1 );
                var_0 _meth_80E8( var_2, 40 );

                if ( !isdefined( var_2.killcament ) )
                {
                    var_3 = ( -142.0, 0.0, 562.0 );
                    var_2.killcament = spawn( "script_model", var_2 gettagorigin( "tag_player" ) + var_3 );
                    var_2.killcament setscriptmoverkillcam( "explosive" );
                    var_2.killcament linkto( var_2 );
                    var_2.killcament setcontents( 0 );
                }

                wait 0.5;

                if ( isdefined( self.damthermal ) && self.damthermal == 1 )
                    self thermalvisionon();

                self setclientomnvar( "ui_damturret_toggle", 1 );
                self waittill( "SwitchTurret" );

                if ( isdefined( self.damthermal ) && self.damthermal == 1 )
                    self thermalvisionoff();

                self setclientomnvar( "ui_damturret_toggle", 0 );

                if ( isdefined( var_2.killcament ) )
                    var_2.killcament delete();

                var_0 transitionturret();
                var_0 unlink();
                var_0 _meth_80E9( var_2 );
                var_2 _meth_8065( "manual" );
                var_2 _meth_8106( level.damdefaultaiment );
            }
        }
    }
}

transitionturret()
{
    self visionsetnakedforplayer( "black_bw", 0.75 );
    wait 0.8;
    revertvisionsetforturretplayer( 0.5 );
}

revertvisionsetforturretplayer( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( isdefined( level.nukedetonated ) && isdefined( level.nukevisionset ) )
        self visionsetnakedforplayer( level.nukevisionset, var_0 );
    else if ( isdefined( self.usingremote ) && isdefined( self.ridevisionset ) )
        self visionsetnakedforplayer( self.ridevisionset, var_0 );
    else
        self visionsetnakedforplayer( "", var_0 );
}

_id_A051( var_0 )
{
    self endon( "disconnect" );
    level endon( "mp_dam_player_removed" );
    wait(var_0);
    self visionsetthermalforplayer( game["thermal_vision"], 0 );
    self thermalvisionfofoverlayon();
    self setblurforplayer( 1.1, 0 );
}

_id_92FD()
{
    self endon( "mp_dam_player_removed" );

    for (;;)
    {
        self.damthermal = 0;
        self waittill( "SwitchVisionMode" );
        self thermalvisionon();
        self.damthermal = 1;
        self waittill( "SwitchVisionMode" );
        self thermalvisionoff();
    }
}

creatempdamkillstreakclock()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "mp_dam_player_removed" );
    self.dam_clock = maps\mp\gametypes\_hud_util::createtimer( "hudsmall", 0.9 );
    self.dam_clock maps\mp\gametypes\_hud_util::setpoint( "CENTER", "CENTER", 0, -145 );
    self.dam_clock settimer( level.dam_killstreak_duration );
    self.dam_clock.color = ( 1.0, 1.0, 1.0 );
    self.dam_clock.archived = 0;
    self.dam_clock.foreground = 1;
    thread destroympdamkillstreakclock();
}

destroympdamkillstreakclock()
{
    self waittill( "mp_dam_player_removed" );

    if ( isdefined( self.dam_clock ) )
        self.dam_clock destroy();
}

removempdamplayeroncommand()
{
    self endon( "mp_dam_player_removed" );

    for (;;)
    {
        var_0 = 0;

        while ( self usebuttonpressed() )
        {
            var_0 += 0.05;

            if ( var_0 > 0.75 )
            {
                level thread removempdamplayer( self, 0 );
                return;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

removempdamplayerongamecleanup()
{
    self endon( "mp_dam_player_removed" );
    level waittill( "game_cleanup" );
    level thread removempdamplayer( self, 0 );
}

removempdamplayerondeath()
{
    self endon( "mp_dam_player_removed" );
    self waittill( "death" );
    level thread removempdamplayer( self, 0 );
}

removempdamplayerondisconnect()
{
    self endon( "mp_dam_player_removed" );
    self waittill( "disconnect" );
    level thread removempdamplayer( self, 1 );
}

removempdamplayeronchangeteams()
{
    self endon( "mp_dam_player_removed" );
    self waittill( "joined_team" );
    level thread removempdamplayer( self, 0 );
}

removempdamplayeronspectate()
{
    self endon( "mp_dam_player_removed" );
    common_scripts\utility::waittill_any( "joined_spectators", "spawned" );
    level thread removempdamplayer( self, 0 );
}

removempdamplayeraftertime( var_0 )
{
    self endon( "mp_dam_player_removed" );

    if ( maps\mp\_utility::_hasperk( "specialty_blackbox" ) && isdefined( self._id_8A32 ) )
        var_0 *= self._id_8A32;

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    level thread removempdamplayer( self, 0 );
}

removempdamplayer( var_0, var_1 )
{
    var_0 notify( "mp_dam_player_removed" );
    level notify( "mp_dam_player_removed" );
    waittillframeend;

    if ( !var_1 )
    {
        var_0 setclientomnvar( "ui_damturret_toggle", 0 );
        var_0 setblurforplayer( 0, 0 );
        var_0 thermalvisionoff();
        var_0 thermalvisionfofoverlayoff();
        var_0 _meth_80E9( var_0.turret );
        var_0 unlink();
        var_0 maps\mp\_utility::clearusingremote();
        var_0 maps\mp\_utility::revertvisionsetforplayer( 0.5 );
        var_0 _meth_80FF();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::setthirdpersondof( 1 );

        if ( isdefined( var_0._id_25F3 ) )
            var_0._id_25F3 destroy();

        foreach ( var_3 in level.damturrets )
        {
            var_3 _meth_8065( "manual" );
            var_3 _meth_8106( level.damdefaultaiment );

            if ( isdefined( var_3.killcament ) )
                var_3.killcament delete();
        }

        var_0.turret = undefined;
    }

    level.mp_dam_player = undefined;
}

overlay( var_0 )
{
    level._id_4AE9["thermal_vision"] = newclienthudelem( var_0 );
    level._id_4AE9["thermal_vision"].x = 200;
    level._id_4AE9["thermal_vision"].y = 0;
    level._id_4AE9["thermal_vision"].alignx = "left";
    level._id_4AE9["thermal_vision"].aligny = "top";
    level._id_4AE9["thermal_vision"].horzalign = "left";
    level._id_4AE9["thermal_vision"].vertalign = "top";
    level._id_4AE9["thermal_vision"].fontscale = 2.5;
    level._id_4AE9["thermal_vision"] settext( &"AC130_HUD_FLIR" );
    level._id_4AE9["thermal_vision"].alpha = 1.0;
    level._id_4AE9["enhanced_vision"] = newclienthudelem( var_0 );
    level._id_4AE9["enhanced_vision"].x = -200;
    level._id_4AE9["enhanced_vision"].y = 0;
    level._id_4AE9["enhanced_vision"].alignx = "right";
    level._id_4AE9["enhanced_vision"].aligny = "top";
    level._id_4AE9["enhanced_vision"].horzalign = "right";
    level._id_4AE9["enhanced_vision"].vertalign = "top";
    level._id_4AE9["enhanced_vision"].fontscale = 2.5;
    level._id_4AE9["enhanced_vision"] settext( &"AC130_HUD_OPTICS" );
    level._id_4AE9["enhanced_vision"].alpha = 1.0;
    var_0 setblurforplayer( 1.2, 0 );
}

_id_8439( var_0 )
{
    self endon( "mp_dam_player_removed" );
    self endon( "SwitchTurret" );

    for (;;)
    {
        var_0 waittill( "turret_fire" );
        earthquake( 0.25, 1.0, var_0.origin, 3500 );
        playrumbleonposition( "artillery_rumble", var_0.origin );
        thread shotfireddarkscreenoverlay();
        wait 0.05;
    }
}

shotfireddarkscreenoverlay()
{
    self endon( "mp_dam_player_removed" );
    self notify( "darkScreenOverlay" );
    self endon( "darkScreenOverlay" );

    if ( !isdefined( self._id_25F3 ) )
    {
        self._id_25F3 = newclienthudelem( self );
        self._id_25F3.x = 0;
        self._id_25F3.y = 0;
        self._id_25F3.alignx = "left";
        self._id_25F3.aligny = "top";
        self._id_25F3.horzalign = "fullscreen";
        self._id_25F3.vertalign = "fullscreen";
        self._id_25F3 setshader( "black", 640, 480 );
        self._id_25F3.sort = -10;
        self._id_25F3.alpha = 0.0;
    }

    self._id_25F3.alpha = 0.0;
    self._id_25F3 fadeovertime( 0.05 );
    self._id_25F3.alpha = 0.2;
    wait 0.4;
    self._id_25F3 fadeovertime( 0.8 );
    self._id_25F3.alpha = 0.0;
}

movementaudio( var_0 )
{
    self endon( "mp_dam_player_removed" );
    self endon( "SwitchTurret" );

    if ( !isdefined( level._id_0E57 ) )
        level._id_0E57 = spawnstruct();

    thread movementaudiocleanup();

    for (;;)
    {
        var_1 = var_0 _meth_8478();
        var_1 = abs( var_1 );
        var_2 = var_0 _meth_8479();
        var_2 = abs( var_2 );

        if ( var_1 > 0.1 )
        {
            if ( !isdefined( level._id_0E57.turretyawlp ) )
            {
                level._id_0E57.turretyawlp = spawn( "script_origin", var_0.origin );
                level._id_0E57.turretyawlp playloopsound( "wpn_railgun_dam_lat_move_lp" );
            }
        }
        else if ( isdefined( level._id_0E57.turretyawlp ) )
        {
            level._id_0E57.turretyawlp stoploopsound();
            level._id_0E57.turretyawlp delete();
            level._id_0E57.turretyawlp = undefined;
            var_0 playsound( "wpn_railgun_dam_lat_stop" );
        }

        if ( var_2 > 0.1 )
        {
            if ( !isdefined( level._id_0E57.turretpitchlp ) )
            {
                level._id_0E57.turretpitchlp = spawn( "script_origin", var_0.origin );
                level._id_0E57.turretpitchlp playloopsound( "wpn_railgun_dam_vert_move_lp" );
            }
        }
        else if ( isdefined( level._id_0E57.turretpitchlp ) )
        {
            level._id_0E57.turretpitchlp stoploopsound();
            level._id_0E57.turretpitchlp delete();
            level._id_0E57.turretpitchlp = undefined;
            var_0 playsound( "wpn_railgun_dam_vert_stop" );
        }

        wait 0.05;
    }
}

movementaudiocleanup()
{
    self waittill( "mp_dam_player_removed" );

    if ( isdefined( level._id_0E57.turretyawlp ) )
    {
        level._id_0E57.turretyawlp stoploopsound();
        level._id_0E57.turretyawlp delete();
        level._id_0E57.turretyawlp = undefined;
    }

    if ( isdefined( level._id_0E57.turretpitchlp ) )
    {
        level._id_0E57.turretpitchlp stoploopsound();
        level._id_0E57.turretpitchlp delete();
        level._id_0E57.turretpitchlp = undefined;
    }
}
