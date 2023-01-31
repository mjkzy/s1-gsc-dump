// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

streak_init()
{
    precacheitem( "iw5_dlcgun12loot2_mp" );
    level.killstreakfuncs["mp_seoul2"] = ::tryusempswarm;
    level.mapkillstreak = "mp_seoul2";
    level.mapkillstreakpickupstring = &"MP_SEOUL2_MAP_KILLSTREAK_PICKUP";
    level.killstreakwieldweapons["iw5_dlcgun12loot2_mp"] = "mp_seoul2";
    level.swarm_use_duration = 40;
    level.swarm_speed = 40;
    var_0 = getentarray( "minimap_corner", "targetname" );
    var_1 = ( 0, 0, 0 );

    if ( var_0.size )
        var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter( var_0[0].origin, var_0[1].origin );

    level.swarmrig = spawn( "script_model", var_1 );
    level.swarmrig _meth_80B1( "c130_zoomrig" );
    level.swarmrig.angles = ( 0, 115, 0 );
    level.swarmrig hide();
    thread rotateswarm( level.swarm_speed );
    level._effect["orbitalsupport_rocket_explode_player"] = loadfx( "vfx/explosion/rocket_explosion_distant" );
    level.swarminuse = 0;
    level._effect["drone_swarm_loop"] = loadfx( "vfx/map/mp_seoul2/drone_swarm_loop" );
    level._effect["drone_swarm_trail"] = loadfx( "vfx/trail/drone_swarm_missile_trail" );
    level._effect["drone_swarm_trail_inair"] = loadfx( "vfx/trail/drone_swarm_missile_trail_inair" );
}

tryusempswarm( var_0, var_1 )
{
    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    if ( maps\mp\_utility::isjuggernaut() )
        return 0;

    if ( isdefined( level.swarm_player ) || level.swarminuse )
    {
        self iclientprintlnbold( &"MP_SEOUL2_SWARM_IN_USE" );
        return 0;
    }

    level.swarminuse = 1;
    thread playerclearswarmonteamchange();
    var_2 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "paladin", 0, undefined, 3.0 );

    if ( var_2 != "success" )
    {
        level.swarminuse = 0;
        return 0;
    }

    maps\mp\_utility::setusingremote( "orbitalplatform" );
    thread setswarmplayer( self );
    maps\mp\_matchdata::logkillstreakevent( "dlc_streak5", self.origin );
    return 1;
}

playerclearswarmonteamchange()
{
    self endon( "rideKillstreakBlack" );
    self waittill( "joined_team" );
    level.swarminuse = 0;
}

setswarmplayer( var_0 )
{
    self endon( "swarm_player_removed" );
    self endon( "disconnect" );
    level.swarm_player = var_0;
    var_0 maps\mp\_utility::playersaveangles();
    var_0 swarm_spawn();
    level.swarm_planemodel.vehicletype = "paladin";
    level.swarm_planemodel.player = var_0;
    level.swarm_planemodel.helitype = "osp";
    var_0 _meth_834A();
    var_0 maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
    var_0 maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();
    var_0 thread waitsetthermal( 1.0 );
    var_0 thread waitdisableshadows( 1.0 );
    var_0 thread setswarmvisionandlightsetpermap( 1.25 );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::setthirdpersondof( 0 );

    var_0 playerswitchtoturret( level.swarm_big_turret );
    var_0.controlled_swarm_turret = "medium";
    var_0.reloading_rocket_swarm_gun = 0;
    var_0 thread removeswarmplayerondisconnect();
    var_0 thread removeswarmplayeronchangeteams();
    var_0 thread removeswarmplayeronspectate();
    var_0 thread removeswarmplayerongamecleanup();
    var_0 thread removeswarmplayeronsystemhack();
    wait 1;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    var_0 _meth_82FB( "ui_solar_beam", 1 );
    var_0 thread waitsetstatic( 0.1 );
    var_1 = level.swarm_use_duration;
    var_0.swarm_endtime = gettime() + var_1 * 1000;
    var_0 _meth_82FB( "ui_warbird_countdown", var_0.swarm_endtime );
    self _meth_82DD( "swarm_fire", "+attack" );
    self _meth_82DD( "swarm_fire", "+attack_akimbo_accessible" );
    var_0 thread firerocketswarmgun();

    if ( isdefined( level.swarm_targetent ) )
        playfxontag( common_scripts\utility::getfx( "vehicle_osp_rocket_marker" ), level.swarm_targetent, "tag_origin" );

    var_0 thread pulseswarmreloadtext();
    var_0 thread showaerialmarker();
    var_0 thread removeswarmplayeraftertime( var_1 );
    var_0 thread removeswarmplayeroncommand();
    level.swarm_planemodel thread swarmexit( var_1 );
    level thread setupplayersduringstreak();
}

waitsetstatic( var_0 )
{
    self endon( "swarm_player_removed" );
    self endon( "disconnect" );
    wait(var_0);
    maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

waitsetthermal( var_0 )
{
    self endon( "disconnect" );
    level endon( "swarm_player_removed" );
    self endon( "swarm_player_removed" );
    wait(var_0);
    self thermalvisionfofoverlayon();
    var_1 = 3000;
    var_2 = 0.3;
    var_3 = var_1;
    var_4 = 0.3;
    var_5 = var_1 * 0.75;
    var_6 = 20;
    var_7 = 30;
    thread maps\mp\killstreaks\_aerial_utility::thermalvision( "swarm_player_removed", var_2, var_3, var_4, var_5, var_6, var_7 );
}

waitdisableshadows( var_0 )
{
    self endon( "disconnect" );
    level endon( "swarm_player_removed" );
    self endon( "swarm_player_removed" );
    wait(var_0);
    self _meth_851A( 0 );
}

setswarmvisionandlightsetpermap( var_0 )
{
    self endon( "disconnect" );
    level endon( "swarm_player_removed" );
    wait(var_0);

    if ( isdefined( level.swarmvisionset ) )
        self _meth_847A( level.swarmvisionset, 0 );

    if ( isdefined( level.swarmlightset ) )
        self _meth_83C0( level.swarmlightset );

    maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

removeswarmvisionandlightsetpermap( var_0 )
{
    self _meth_847A( "", var_0 );
    self _meth_83C0( "" );
    maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}

removeswarmplayeroncommand()
{
    self endon( "swarm_player_removed" );
    var_0 = 0;

    for (;;)
    {
        if ( self usebuttonpressed() )
        {
            var_0 += 0.05;

            if ( var_0 > 1.0 )
            {
                level thread removeswarmplayer( self, 0 );
                return;
            }
        }
        else
            var_0 = 0;

        wait 0.05;
    }
}

removeswarmplayerongamecleanup()
{
    self endon( "swarm_player_removed" );
    level waittill( "game_ended" );
    level thread removeswarmplayer( self, 0 );
}

removeswarmplayerondisconnect()
{
    self endon( "swarm_player_removed" );
    self waittill( "disconnect" );
    level thread removeswarmplayer( self, 1 );
}

removeswarmplayeronchangeteams()
{
    self endon( "swarm_player_removed" );
    self waittill( "joined_team" );
    level thread removeswarmplayer( self, 0 );
}

removeswarmplayeronspectate()
{
    self endon( "swarm_player_removed" );
    common_scripts\utility::waittill_any( "joined_spectators", "spawned" );
    level thread removeswarmplayer( self, 0 );
}

removeswarmplayeraftertime( var_0 )
{
    self endon( "swarm_player_removed" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    level thread removeswarmplayer( self, 0 );
}

removeswarmplayeronsystemhack()
{
    self endon( "swarm_player_removed" );

    for (;;)
    {
        self waittill( "EMP_Artifacts" );
        wait 0.15;

        if ( level.empstreaksdisabled )
            level thread removeswarmplayer( self, 0 );
    }
}

removeswarmplayer( var_0, var_1 )
{
    var_0 notify( "swarm_player_removed" );
    level notify( "swarm_player_removed" );
    waittillframeend;
    level.swarm_planemodel.player = undefined;

    if ( !var_1 )
    {
        var_0 playerresetswarmomnvars();
        var_0 _meth_849C( "swarm_fire", "+attack" );
        var_0 _meth_849C( "swarm_fire", "+attack_akimbo_accessible" );
        var_0 _meth_80E9( level.swarm_big_turret );
        level.swarm_big_turret hide();
        var_0 _meth_804F();
        var_2 = maps\mp\_utility::getkillstreakweapon( "orbitalsupport" );
        var_0 _meth_830F( var_2 );

        if ( var_0 maps\mp\_utility::isusingremote() )
            var_0 maps\mp\_utility::clearusingremote();

        maps\mp\killstreaks\_aerial_utility::disableorbitalthermal( var_0 );
        var_0 _meth_851A( 1 );
        var_0 thermalvisionfofoverlayoff();
        var_0 setblurforplayer( 0, 0 );
        var_0 removeswarmvisionandlightsetpermap( 1.5 );
        var_0 _meth_834B();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::setthirdpersondof( 1 );

        if ( isdefined( var_0.darkscreenoverlay ) )
            var_0.darkscreenoverlay destroy();

        var_0.reloading_rocket_swarm_gun = undefined;
        var_0 maps\mp\_utility::playerrestoreangles();
    }

    if ( isdefined( level.swarm_targetent ) )
    {
        stopfxontag( common_scripts\utility::getfx( "vehicle_osp_rocket_marker" ), level.swarm_targetent, "tag_origin" );
        level.swarm_targetent delete();
    }

    level.swarm_player = undefined;
    level.swarm_planemodel _meth_80AB();
    level.swarm_planemodel playsound( "paladin_orbit_return" );
}

cleanupswarments()
{
    level.swarm_planemodel _meth_80AB();

    if ( isdefined( level.swarm_planemodel.farflightsound ) )
    {
        level.swarm_planemodel.farflightsound _meth_80AB();
        level.swarm_planemodel.farflightsound delete();
    }

    if ( isdefined( level.swarm_planemodel.closeflightsound ) )
    {
        level.swarm_planemodel.closeflightsound _meth_80AB();
        level.swarm_planemodel.closeflightsound delete();
    }

    if ( isdefined( level.swarm_planemodel.minimapicon ) )
        level.swarm_planemodel.minimapicon delete();
}

swarm_spawn()
{
    var_0 = getentarray( "minimap_corner", "targetname" );
    var_1 = ( 0, 0, 0 );

    if ( var_0.size )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter( var_0[0].origin, var_0[1].origin );
        var_1 = ( var_1[0], var_1[1], 0 );
    }

    level.swarm_planemodel = spawn( "script_model", var_1 );
    level.swarm_planemodel.angles = ( 0, 0, 0 );
    level.swarm_planemodel _meth_80B1( "vehicle_mp_seoul2_killstreak_osp_rig" );
    level.swarm_planemodel.owner = self;
    level.swarm_planemodel common_scripts\utility::make_entity_sentient_mp( self.team );
    level.swarm_planemodel.minimapicon = spawnplane( self, "script_model", var_1, "compass_objpoint_seoul2_swarm_friendly", "compass_objpoint_seoul2_swarm_enemy" );
    level.swarm_planemodel.minimapicon _meth_80B1( "tag_origin" );
    level.swarm_planemodel.minimapicon _meth_8446( level.swarm_planemodel, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.swarm_planemodel.fxent = level.swarm_planemodel common_scripts\utility::spawn_tag_origin();
    level.swarm_planemodel.fxent _meth_8446( level.swarm_planemodel, "tag_origin", ( 0, 0, -800 ), ( 0, 0, 0 ) );
    level.swarm_planemodel.fxent show();
    playfxontag( common_scripts\utility::getfx( "drone_swarm_loop" ), level.swarm_planemodel.fxent, "tag_origin" );
    level.swarm_planemodel _meth_82C0( 1 );
    level.swarm_planemodel _meth_82C1( 1 );
    level.swarm_planemodel.showthreatmarker = 0;
    level.swarm_planemodel setrandomswarmstartposition();
    level.swarm_big_turret = spawnswarmturret( "orbitalsupport_medium_turret_mp", "orbitalsupport_big_turret", "tag_orbitalsupport_biggun" );
    level.swarm_planemodel thread moveswarmtodestination();
}

spawnswarmturret( var_0, var_1, var_2 )
{
    var_3 = spawnturret( "misc_turret", level.swarm_planemodel gettagorigin( var_2 ), var_0, 0 );
    var_3.angles = level.swarm_planemodel gettagangles( var_2 );
    var_3 _meth_80B1( var_1 );
    var_3 _meth_815A( 45 );
    var_3 _meth_804D( level.swarm_planemodel, var_2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3.owner = undefined;
    var_3.health = 99999;
    var_3.maxhealth = 1000;
    var_3.damagetaken = 0;
    var_3.stunned = 0;
    var_3.stunnedtime = 0.0;
    var_3 _meth_82C0( 0 );
    var_3 _meth_82C1( 0 );
    var_3 _meth_815C();
    return var_3;
}

swarmturretspawnsoundent( var_0 )
{
    waitframe();
    self.soundent = spawn( "script_model", self.origin );
    self.soundent _meth_80B1( "tag_origin" );
    self.soundent _meth_804D( level.swarm_planemodel, var_0, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

pulseswarmreloadtext()
{
    level endon( "swarm_player_removed" );
    self endon( "swarm_player_removed" );
    self _meth_82FB( "ui_osp_reload_bitfield", 0 );
    var_0 = 4;

    for (;;)
    {
        var_1 = 0;

        if ( self.reloading_rocket_swarm_gun )
            var_1 += var_0;

        self _meth_82FB( "ui_osp_reload_bitfield", var_1 );
        wait 0.05;
    }
}

playerswitchtoturret( var_0 )
{
    self _meth_804F();
    level thread handleturretsoundent( var_0 );
    var_1 = 75;
    var_2 = 75;
    var_3 = -30;
    var_4 = 360;
    self _meth_807E( var_0, "tag_player", 0, var_1, var_2, var_3, var_4, 1 );
    self _meth_80A1( 1 );
    var_5 = 45;
    self _meth_80E8( var_0, var_5 );
}

handleturretsoundent( var_0 )
{
    var_0 endon( "death" );
    var_0 notify( "startHandleSoundEnt" );
    var_0 endon( "startHandleSoundEnt" );

    if ( isdefined( var_0.soundent ) )
        var_0.soundent hide();

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_0.owner ) && var_0.owner != var_2 )
        {
            if ( isdefined( var_0.soundent ) )
                var_0.soundent showtoplayer( var_2 );
        }
    }

    for (;;)
    {
        level waittill( "connected", var_2 );

        if ( isdefined( var_0.soundent ) )
            var_0.soundent showtoplayer( var_2 );
    }
}

random_vector( var_0 )
{
    return ( randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5 );
}

firerocketswarmgun()
{
    self endon( "swarm_player_removed" );
    var_0 = 3;
    thread updateshootinglocation();

    while ( !isdefined( level.swarm_planemodel.swarmflying ) )
        waitframe();

    for (;;)
    {
        self.reloading_rocket_swarm_gun = 0;

        if ( self attackbuttonpressed() && !isdefined( level.hostmigrationtimer ) )
        {
            earthquake( 0.3, 1, level.swarm_planemodel.origin, 1000, self );
            var_1 = level.swarm_big_turret gettagorigin( "tag_missile1" );
            var_2 = vectornormalize( anglestoforward( self getangles() ) );
            var_3 = vectornormalize( anglestoforward( level.swarm_planemodel gettagangles( "tag_origin" ) ) );

            for ( var_4 = 0; var_4 < 1; var_4++ )
            {
                var_5 = var_2 + ( 0, 0, 0.4 ) + random_vector( 0.5 );
                var_6 = var_1 + common_scripts\utility::randomvectorrange( -1, 1 );
                var_7 = magicbullet( "iw5_dlcgun12loot2_mp", var_1, var_1 + var_5, self );
                var_8 = var_7 common_scripts\utility::spawn_tag_origin();
                var_8 show();
                var_8 _meth_8446( var_7, "tag_fx" );
                var_9 = [];

                foreach ( var_11 in level.players )
                {
                    if ( var_11 != self )
                        var_9[var_9.size] = _func_2C2( common_scripts\utility::getfx( "drone_swarm_trail" ), var_8, "tag_origin", var_11 );
                }

                var_9[var_9.size] = _func_2C2( common_scripts\utility::getfx( "drone_swarm_trail_inair" ), var_8, "tag_origin", self );

                foreach ( var_14 in var_9 )
                {
                    setwinningteam( var_14, 1 );
                    triggerfx( var_14 );
                }

                thread cleanupdronemissilefx( var_7, var_8, var_9 );
                var_7.vehicle_fired_from = level.swarm_planemodel;
                self playlocalsound( "paladin_missile_shot_2d" );
                self _meth_80AD( "ac130_40mm_fire" );
                var_7 _meth_81D9( level.swarm_targetent );
                var_7 _meth_81DC();
                wait 0.1;
            }

            self.reloading_rocket_swarm_gun = 1;
            thread rocketreloadsound( var_0 );
            wait(var_0);
            self notify( "rocketReloadComplete" );
        }

        waitframe();
    }
}

cleanupdronemissilefx( var_0, var_1, var_2 )
{
    var_0 waittill( "death" );

    foreach ( var_4 in var_2 )
        var_4 delete();

    var_1 delete();
}

updateshootinglocation()
{
    self endon( "swarm_player_removed" );
    level.swarm_targetent = spawn( "script_model", ( 0, 0, 0 ) );
    level.swarm_targetent _meth_80B1( "tag_origin" );
    level.swarm_big_turret _meth_8508( level.swarm_targetent );

    for (;;)
    {
        var_0 = level.swarm_big_turret gettagorigin( "tag_player" );
        var_1 = level.swarm_big_turret gettagorigin( "tag_player" ) + anglestoforward( level.swarm_big_turret gettagangles( "tag_player" ) ) * 20000;
        var_2 = bullettrace( var_0, var_1, 0, level.swarm_big_turret );
        var_3 = var_2["position"];
        level.swarm_targetent.origin = var_3;
        waitframe();
    }
}

rocketreloadsound( var_0 )
{
    self endon( "rocketReloadComplete" );
    self endon( "swarm_player_removed" );
    self playlocalsound( "warbird_missile_reload_bed" );
    wait 0.5;
    self playlocalsound( "warbird_missile_reload" );
}

showaerialmarker()
{
    level.swarm_planemodel endon( "death" );

    while ( !isdefined( level.swarm_planemodel.swarmflying ) )
        waitframe();

    level.swarm_planemodel.showthreatmarker = 1;
    level.swarm_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
    level.swarm_planemodel common_scripts\utility::waittill_either( "crashing", "leaving" );
    level.swarm_planemodel.showthreatmarker = 0;
    level.swarm_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
}

setrandomswarmstartposition()
{
    var_0 = level.mapcenter[2] + 3000;
    var_1 = 2000;
    var_2 = ( 0, randomint( 360 ), 0 );
    level.swarm_planemodel.angles = var_2;
    level.swarm_planemodel.origin -= vectornormalize( -1 * anglestoright( level.swarm_planemodel gettagangles( "tag_origin" ) ) ) * var_1;
    level.swarm_planemodel.origin += ( 0, 0, var_0 );
    level.swarm_planemodel.destination2 = spawnstruct();
    level.swarm_planemodel.destination2.origin = level.swarm_planemodel.origin;
    level.swarm_planemodel.destination2.angles = level.swarm_planemodel.angles;
    level.swarm_planemodel.origin += ( 0, 0, 65000 );
}

moveswarmtodestination( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    level endon( "game_ended" );
    level endon( "swarm_player_removed" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    thread rotateswarm( 1, "off" );
    thread playentrysounddelayed();
    level.swarm_planemodel _meth_827B( "mp_seoul2_ks_callin", "paladin_notetrack" );
    level.swarm_planemodel waittillmatch( "paladin_notetrack", "engines_full" );
    level.swarm_planemodel waittillmatch( "paladin_notetrack", "downward_stop" );

    if ( var_0 )
    {
        level.swarm_planemodel _meth_8446( level.swarmrig, "tag_player" );
        thread rotateswarm( level.swarm_speed );
    }

    level.swarm_planemodel waittillmatch( "paladin_notetrack", "end" );
    level.swarm_planemodel _meth_827A();
    level.swarm_planemodel _meth_8279( "paladin_ks_loop", "paladin_notetrack" );

    if ( isdefined( level.swarm_planemodel.owner ) )
    {
        level.swarm_planemodel.closeflightsound = spawn( "script_origin", ( 0, 0, 0 ) );
        level.swarm_planemodel.closeflightsound _meth_8446( level.swarm_planemodel, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.swarm_planemodel.closeflightsound _meth_8075( "paladin_flight_loop_near" );
    }

    level.swarm_planemodel.farflightsound = spawn( "script_origin", ( 0, 0, 0 ) );
    level.swarm_planemodel.farflightsound _meth_8446( level.swarm_planemodel, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.swarm_planemodel.farflightsound _meth_8075( "paladin_flight_loop_dist" );
    setupflightsounds();
    level.swarm_planemodel.swarmflying = 1;
}

setupflightsounds()
{
    if ( isdefined( level.swarm_planemodel.closeflightsound ) )
    {
        level.swarm_planemodel.closeflightsound hide();

        if ( isdefined( level.swarm_planemodel.owner ) )
            level.swarm_planemodel.closeflightsound showtoplayer( level.swarm_planemodel.owner );
    }

    if ( isdefined( level.swarm_planemodel.farflightsound ) )
    {
        level.swarm_planemodel.farflightsound hide();

        foreach ( var_1 in level.players )
        {
            if ( level.splitscreen || isdefined( level.swarm_planemodel.owner ) && bothplayerssplitscreen( level.swarm_planemodel.owner, var_1 ) )
                continue;

            if ( isdefined( level.swarm_planemodel.owner ) && var_1 != level.swarm_planemodel.owner )
                level.swarm_planemodel.farflightsound showtoplayer( var_1 );
        }
    }
}

bothplayerssplitscreen( var_0, var_1 )
{
    return var_0 issplitscreenplayer() && var_1 issplitscreenplayer();
}

playerdelayrumble( var_0 )
{
    self endon( "disconnect" );
    self endon( "swarm_player_removed" );
    wait(var_0);
    self _meth_80AD( "orbital_laser_charge" );
}

playentrysounddelayed()
{
    self endon( "death" );
    self endon( "crashing" );
    level endon( "game_ended" );
    level endon( "swarm_player_removed" );
    wait 1;
    playsoundatpos( level.swarm_planemodel.destination2.origin, "paladin_orbit_drop" );
}

swarmexit( var_0 )
{
    level.swarm_planemodel endon( "crashing" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    level.swarm_planemodel notify( "leaving" );
    level.swarm_planemodel _meth_804F();
    level.swarm_planemodel.fxent _meth_804F();
    level.swarm_planemodel _meth_827B( "paladin_ks_exit", "paladin_notetrack" );
    wait 4.8;
    cleanupswarments();
    level.swarm_planemodel delete();
    level.swarminuse = 0;
}

setupplayersduringstreak()
{
    level.swarm_chatter_timer = 0;

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.team ) && level.swarm_planemodel.owner.team == var_1.team )
            continue;
        else if ( !isdefined( var_1.team ) )
        {
            var_1 onplayerspawnedduringstreak();
            continue;
        }
    }

    level thread onplayerconnectduringstreak();
}

onplayerconnectduringstreak()
{
    level endon( "game_ended" );
    level.swarm_planemodel.owner endon( "swarm_player_removed" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawnedduringstreak();
    }
}

onplayerspawnedduringstreak()
{
    self waittill( "spawned_player" );
    setupflightsounds();
}

turretdeletesoundent()
{
    if ( isdefined( self.soundent ) )
        self.soundent delete();
}

playerresetswarmomnvars()
{
    self _meth_82FB( "ui_killstreak_optic", 0 );
    self _meth_82FB( "ui_osp_reload_bitfield", 0 );
    self _meth_82FB( "ui_solar_beam", 0 );
    maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

rotateswarm( var_0, var_1 )
{
    level notify( "stop_rotateSwarm_thread" );
    level endon( "stop_rotateSwarm_thread" );

    if ( !isdefined( var_1 ) )
        var_1 = "on";

    if ( var_1 == "on" )
    {
        level.swarmrig _meth_82B7( 360, var_0, 0.5 );
        wait(var_0);

        for (;;)
        {
            level.swarmrig _meth_82B7( 360, var_0 );
            wait(var_0);
        }
    }
    else if ( var_1 == "off" )
    {
        var_2 = 10;
        var_3 = var_0 / 360 * var_2;
        level.swarmrig _meth_82B7( level.swarmrig.angles[2] + var_2, var_3, 0, var_3 );
    }
}
