// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_recovery_precache::main();
    maps\createart\mp_recovery_art::main();
    maps\mp\mp_recovery_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_recovery_lighting::main();
    maps\mp\mp_recovery_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_recovery" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.missilefx = loadfx( "vfx/test/hms_fireball_explosion_xlrg" );
    thread dynamic_ents();
    thread handle_teleport();
    thread dynamic_pathing_main();
    var_0 = level.gametype;

    if ( !isdefined( level.ishorde ) )
    {
        if ( !( var_0 == "twar" || var_0 == "sd" || var_0 == "sr" ) )
            level thread maps\mp\_dynamic_events::dynamicevent( ::recovery_dynamic_event );
    }

    level thread onplayerconnect();
    thread spawnsetup();
    level.dynamiceventstatus = "before";
    level.hp_pause_for_dynamic_event = 0;
    level.orbitalsupportoverridefunc = ::recoverycustomospfunc;
    level.ospvisionset = "mp_recovery_b";
    level.osplightset = "mp_recovery_osp";
    level.dronevisionset = "mp_recovery_b";
    level.dronelightset = "mp_recovery";
    thread scriptpatchclip();
}

scriptpatchclip()
{
    thread patchclipcentersmallrock();
    thread patchclipsecondsidedoorrocks01();
    thread patchclipsecondsidegoliathrock();
}

patchclipcentersmallrock()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -511, 1131, 162 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -499, 1145, 162 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -499, 1157, 162 ), ( 0, 0, 0 ) );
}

patchclipsecondsidedoorrocks01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( -208, 3304, 140 ), ( 0, 336, 0 ) );
}

patchclipsecondsidegoliathrock()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -147, 4352.5, 170.5 ), ( 0, 26.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -124, 4366, 170.5 ), ( 0, 45, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -101.5, 4343.5, 170.5 ), ( 0, 45, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -101.5, 4343.5, 138.5 ), ( 0, 45, 0 ) );
}

recoverycustomospfunc()
{
    level.orbitalsupportoverrides.spawnheight = 9324;
    level.orbitalsupportoverrides.spawnanglemin = 290;
    level.orbitalsupportoverrides.spawnanglemax = 370;
    level.orbitalsupportoverrides.toparc = -45;
    thread recoveryeventcustomospfunc();
}

recoveryeventcustomospfunc()
{
    level waittill( "Gas_Cloud_Start" );
    level.orbitalsupportoverrides.spawnanglemin = 120;
    level.orbitalsupportoverrides.spawnanglemax = 180;
    level.orbitalsupportoverrides.turretpitch = 55;
    level.orbitalsupportoverrides.toparc = -40;
    level.orbitalsupportoverrides.bottomarc = 65;
}

spawnsetup()
{
    level.dynamichangarspawns = 0;
    level.dynamicspawns = ::getlistofgoodspawnpoints;
}

set_lighting_values()
{
    if ( isusinghdr() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1" );
        }
    }
}

dynamic_ents()
{
    var_0 = getent( "mp_recovery_signage", "targetname" );
    wait 0.05;
    var_0 common_scripts\utility::hide_notsolid();
    flickerlights();
    var_1 = getentarray( "hangar_door_right", "targetname" );
    var_2 = getentarray( "hangar_door_left", "targetname" );
    var_3 = getentarray( "chemical_missile", "targetname" );
    var_4 = getentarray( "chemical_missile2", "targetname" );
    var_5 = getentarray( "chemical_missile3", "targetname" );
    var_6 = getentarray( "chemical_missile4", "targetname" );
    var_7 = getentarray( "chemical_missile5", "targetname" );
    var_8 = getentarray( "chemical_missile6", "targetname" );
    var_9 = getentarray( "chemical_missile7", "targetname" );
    var_10 = getentarray( "chemical_missile8", "targetname" );
    var_11 = getentarray( "chemical_missile9", "targetname" );
    var_12 = getentarray( "chemical_missile10", "targetname" );
    var_13 = getentarray( "deathTrig_1", "targetname" );
    var_14 = getentarray( "deathTrig_2", "targetname" );
    var_15 = getentarray( "deathTrig_3", "targetname" );

    foreach ( var_17 in var_13 )
    {
        var_17 dontinterpolate();
        var_17.origin += ( 0, 0, -10000 );
    }

    foreach ( var_20 in var_14 )
    {
        var_20 dontinterpolate();
        var_20.origin += ( 0, 0, -10000 );
    }

    foreach ( var_23 in var_15 )
    {
        var_23 dontinterpolate();
        var_23.origin += ( 0, 0, -10000 );
    }

    level waittill( "Missile_Wave2_ended" );
    level.dynamichangarspawns = 1;
    level.dynamiceventstatus = "after";
    wait 5;

    foreach ( var_17 in var_13 )
    {
        var_17 dontinterpolate();
        var_17.origin += ( 0, 0, 10000 );
    }

    wait 5;

    foreach ( var_20 in var_14 )
    {
        var_20 dontinterpolate();
        var_20.origin += ( 0, 0, 10000 );
    }

    wait 5;

    foreach ( var_23 in var_15 )
    {
        var_23 dontinterpolate();
        var_23.origin += ( 0, 0, 10000 );
    }
}

recovery_dynamic_event()
{
    var_0 = getent( "hologram_signs", "targetname" );
    var_0 common_scripts\utility::hide_notsolid();
    var_1 = getent( "mp_recovery_signage", "targetname" );
    var_1 show();
    thread killlights();
    thread spawnhangardoors();
    thread volcanostarteruption();
    thread gascloudstart();
}

handle_teleport()
{
    var_0 = level.gametype;

    if ( !( var_0 == "dom" || var_0 == "ctf" || var_0 == "hp" || var_0 == "ball" ) )
        return;

    if ( var_0 == "hp" )
        level waittill( "dynamic_event_starting" );
    else
        level waittill( "hangar_doors_opening" );

    level.hp_pause_for_dynamic_event = 1;
    maps\mp\_teleport::teleport_to_zone( "zone_0", 1 );
    level.usestartspawns = 0;
}

dynamic_pathing_main()
{
    var_0 = getentarray( "hangar_door_right", "targetname" );
    level waittill( "hangar_doors_opening" );
    wait 3;

    foreach ( var_2 in var_0 )
    {
        if ( var_2.classname == "script_brushmodel" )
            var_2 connectpaths();
    }

    var_4 = getnodearray( "escape_gas_dest_node", "targetname" );
    var_5 = getentarray( "escape_gas_dest_trigger", "targetname" );

    foreach ( var_7 in level.participants )
    {
        if ( isai( var_7 ) )
        {
            var_7 maps\mp\bots\_bots_strategy::bot_defend_stop();

            switch ( level.gametype )
            {
                case "dm":
                case "infect":
                case "conf":
                case "war":
                    var_7 thread escape_gas( var_4, var_5 );
                    break;
                default:
                    break;
            }
        }
    }

    level waittill( "hangar_doors_closed" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.classname == "script_brushmodel" )
            var_2 disconnectpaths();
    }
}

get_escape_gas_dest_node( var_0 )
{
    var_1 = randomint( var_0.size );
    var_2 = var_0[var_1];
    return var_2;
}

clear_script_goal_on_gas_end()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level waittill( "hangar_doors_closed" );
    wait 0.05;
    self botclearscriptgoal();
}

escape_gas( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "hangar_doors_closed" );
    self endon( "disconnect" );
    thread clear_script_goal_on_gas_end();

    for (;;)
    {
        var_2 = get_escape_gas_dest_node( var_0 );
        self botsetscriptgoal( var_2.origin, 512, "critical" );
        var_3 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "death" );

        if ( var_3 == "goal" )
        {
            self botclearscriptgoal();
            wait 5.0;
            continue;
        }

        wait 1.0;
    }
}

spawnhangardoors()
{
    var_0 = getentarray( "hangar_door_right", "targetname" );
    var_1 = 12;
    var_2 = 12;
    level waittill( "Gas_Cloud_Start" );
    level.dynamiceventstatus = "event_in_progress";

    foreach ( var_4 in var_0 )
    {
        var_5 = getent( var_4.target, "targetname" );
        var_4 moveto( var_5.origin, var_1 );
    }

    thread notify_doors_open( var_1 );
    var_7 = getentarray( "hangar_open_sfx", "targetname" );

    foreach ( var_9 in var_7 )
        maps\mp\_audio::snd_play_in_space( "mp_recovery_hangar_door_open", var_9.origin );

    level waittill( "close_doors" );

    foreach ( var_4 in var_0 )
    {
        var_4.unresolved_collision_kill = 1;
        var_5 = getent( var_4.target, "targetname" );
        var_12 = getent( var_5.target, "targetname" );
        var_4 moveto( var_12.origin, var_2 );
        level thread maps\mp\mp_recovery_fx::sulfur_door_fx();
    }

    thread notify_doors_close( var_2, var_0 );
    var_7 = getentarray( "hangar_open_sfx", "targetname" );

    foreach ( var_9 in var_7 )
        maps\mp\_audio::snd_play_in_space( "mp_recovery_hangar_door_close", var_9.origin );
}

notify_doors_close( var_0, var_1 )
{
    level notify( "hangar_doors_closing" );
    playsoundatpos( ( 0, 0, 0 ), "mp_recovery_doors_closing" );
    wait(var_0);
    level notify( "hangar_doors_closed" );
    wait 2;
    playsoundatpos( ( 0, 0, 0 ), "mp_recovery_doors_sealed" );

    foreach ( var_3 in var_1 )
        var_3.unresolved_collision_kill = 0;
}

notify_doors_open( var_0 )
{
    level notify( "hangar_doors_opening" );
    playsoundatpos( ( 0, 0, 0 ), "mp_recovery_doors_opening" );
    thread side_b_visionset_reset();
    level.hp_pause_for_dynamic_event = 0;
    level notify( "ready_for_next_hp_zone" );
    wait(var_0);
    level notify( "hangar_doors_opened" );
}

volcanostarteruption()
{
    thread aud_dyanmic_event();
    earthquake( 0.6, 2, ( 0, 0, 0 ), 5000 );

    foreach ( var_1 in level.players )
        var_1 thread play_earthquake_rumble( 0.75 );

    level.gas_cloud_origin = getent( "gas_cloud_origin", "targetname" );
    stopclientexploder( 200 );

    if ( isdefined( level.panoramicfx ) )
        level.panoramicfx delete();

    level thread common_scripts\_exploder::activate_clientside_exploder( 100 );
    wait 8;
    thread boulderbarrage( 15, 2.0, 10, 19 );
    wait 5;

    foreach ( var_1 in level.players )
        var_1 setclienttriggervisionset( "mp_recovery_post", 10.0 );

    level notify( "Gas_Cloud_Start" );
}

aud_dyanmic_event()
{
    playsoundatpos( ( 2067, -2296, 186 ), "emt_event_volcano_erupt" );
    thread aud_handle_alarms();
    wait 4;
    playsoundatpos( ( 0, 0, 0 ), "mp_recovery_volcanic_activity" );
}

aud_handle_alarms()
{
    level endon( "hangar_doors_closed" );

    for (;;)
    {
        playsoundatpos( ( 0, 0, 0 ), "mp_recovery_alarms" );
        wait 4;
    }
}

gascloudstart()
{
    level waittill( "Gas_Cloud_Start" );
    wait 5;
    level.gas_cloud_origin = getent( "gas_cloud_origin", "targetname" );
    playfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level.gas_cloud_origin, "tag_origin" );
    wait 5;
    thread boulderbarrage( 15, 2.0, 20, 29 );
    maps\mp\_utility::delaythread( 15, ::boulderbarrage, 15, 1.5, 30, 39 );
    level.dynamichangarspawns = 1;
    var_0 = 40;
    var_1 = 12;
    level.gas_cloud_origin moveto( level.gas_cloud_origin.origin + ( 0, 3912, 0 ), var_0 );
    level.gas_cloud_origin thread killplayersincloud( var_0 + var_1, 7.5 );
    var_2 = var_0 - var_1 / 2;
    thread setup_poison_gas_death();
    wait(var_2);
    level notify( "close_doors" );
    wait(var_1);
    stopfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level.gas_cloud_origin, "tag_origin" );
    level.gas_cloud_origin thread instantkillplayersincloud();
    level thread common_scripts\_exploder::activate_clientside_exploder( 102 );
    wait 0.05;
    level notify( "gas_cloud_finished" );
    stopclientexploder( 40 );
}

onplayerconnect()
{
    var_0 = getent( "safe_from_gas", "targetname" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 thread swapfogandfx( var_0 );
    }
}

swapfogandfx( var_0 )
{
    level endon( "gas_cloud_finished" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( !isdefined( var_0 ) || !isdefined( self ) )
            break;

        if ( level.dynamiceventstatus == "event_in_progress" && isalive( self ) )
        {
            if ( !self istouching( var_0 ) && isdefined( self.onnopoisonside ) )
            {
                self setclienttriggervisionset( "mp_recovery_post", 5.0 );
                stopfxontag( common_scripts\utility::getfx( "pyroclastic_flow_2" ), level.gas_cloud_origin, "tag_origin" );
                playfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level.gas_cloud_origin, "tag_origin" );
                self.onnopoisonside = undefined;
            }
            else if ( self istouching( var_0 ) && !isdefined( self.onnopoisonside ) )
            {
                self setclienttriggervisionset( "", 5.0 );
                stopfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level.gas_cloud_origin, "tag_origin" );
                playfxontag( common_scripts\utility::getfx( "pyroclastic_flow_2" ), level.gas_cloud_origin, "tag_origin" );
                self.onnopoisonside = 1;
            }

            wait 0.2;
            continue;
        }

        wait 1.0;
    }
}

flickerlights()
{
    var_0 = getscriptablearray( "stairlgt_die_3", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 setscriptablepartstate( 0, 1 );

    var_4 = getscriptablearray( "die_2", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 setscriptablepartstate( 0, 1 );
}

killlights()
{
    var_0 = getscriptablearray( "killed_lights", "targetname" );

    foreach ( var_2 in var_0 )
    {
        wait 0.1;
        var_2 setscriptablepartstate( 0, 1 );
    }

    var_4 = getscriptablearray( "danger_red", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 setscriptablepartstate( 0, 1 );

    var_8 = getscriptablearray( "die", "targetname" );

    foreach ( var_10 in var_8 )
    {
        var_10 setscriptablepartstate( 0, 2 );
        wait 0.1;
        var_10 setscriptablepartstate( 0, 3 );
    }

    var_12 = getscriptablearray( "die_2", "targetname" );

    foreach ( var_14 in var_12 )
        var_14 setscriptablepartstate( 0, 3 );

    var_16 = getscriptablearray( "stairlgt_die_3", "targetname" );

    foreach ( var_18 in var_16 )
        var_18 setscriptablepartstate( 0, 3 );

    var_20 = getscriptablearray( "stairlgt_die", "targetname" );

    foreach ( var_22 in var_20 )
    {
        wait 0.1;
        var_22 setscriptablepartstate( 0, 1 );
        wait 0.15;
        var_22 setscriptablepartstate( 0, 3 );
    }

    var_24 = getscriptablearray( "stairlgt_die_2", "targetname" );

    foreach ( var_26 in var_24 )
    {
        var_26 setscriptablepartstate( 0, 3 );
        wait 0.2;
        var_26 setscriptablepartstate( 0, 1 );
    }

    var_28 = getscriptablearray( "evacuate_lights", "targetname" );

    foreach ( var_30 in var_28 )
        var_30 setscriptablepartstate( 0, 1 );

    var_32 = getscriptablearray( "evacuate_pill_lights", "targetname" );

    foreach ( var_34 in var_32 )
        var_34 setscriptablepartstate( 0, 1 );

    var_36 = getscriptablearray( "hologram_lgt", "targetname" );

    foreach ( var_38 in var_36 )
        var_38 setscriptablepartstate( 0, 2 );

    var_40 = getscriptablearray( "cave_kill", "targetname" );

    foreach ( var_42 in var_40 )
    {
        var_42 setscriptablepartstate( 0, 1 );
        wait 0.2;
        var_42 setscriptablepartstate( 0, 2 );
    }
}

boulderbarrage( var_0, var_1, var_2, var_3 )
{
    var_4 = gettime() + var_0 * 1000;
    var_5 = 0;
    var_6 = 0;

    while ( gettime() < var_4 )
    {
        wait(randomfloatrange( var_1 / 2, var_1 ));

        while ( var_5 == 0 )
        {
            var_5 = randomintrange( var_2, var_3 );

            if ( var_5 == var_6 )
                var_5 = 0;
            else
            {
                var_6 = var_5;
                level thread common_scripts\_exploder::activate_clientside_exploder( var_5 );
                level thread maps\mp\mp_recovery_fx::setup_boulder_audio( var_5 );
                var_5 = 0;
                break;
            }

            wait 0.05;
        }
    }
}

killplayersincloud( var_0, var_1 )
{
    var_2 = 800;
    var_3 = getent( "safe_from_gas", "targetname" );
    var_4 = gettime() + var_0 * 1000;

    foreach ( var_6 in level.players )
        var_6.isingas = 0;

    while ( gettime() < var_4 )
    {
        foreach ( var_6 in level.players )
        {
            var_9 = var_6 getvieworigin();

            if ( var_6.origin[1] < self.origin[1] - 500 && !var_6 istouching( var_3 ) )
            {
                var_6 dodamage( var_1, var_6.origin );

                if ( !var_6 maps\mp\_utility::isusingremote() && var_9[1] < self.origin[1] && var_9[2] < var_2 )
                {
                    var_6 setclienttriggervisionset( "poison_gas", 1.5 );
                    var_6 shellshock( "mp_lab_gas", 1, 1, 1, 0 );
                }

                var_6.isingas = 1;
                continue;
            }

            if ( !var_6 maps\mp\_utility::isusingremote() )
            {
                if ( var_6.isingas == 1 )
                {
                    if ( var_6 istouching( var_3 ) )
                        var_6 maps\mp\_utility::revertvisionsetforplayer( 1.5 );
                    else
                        var_6 setclienttriggervisionset( "mp_recovery_post", 1.5 );

                    var_6.isingas = 0;
                }
            }
        }

        if ( level.gametype == "ctf" )
        {
            foreach ( var_12 in level.teamflags )
            {
                if ( var_12.curorigin[1] < self.origin[1] && !var_12.visuals[0] istouching( var_3 ) )
                    var_12 maps\mp\gametypes\ctf::returnflag();
            }
        }

        wait 0.25;
    }
}

instantkillplayersincloud()
{
    var_0 = getent( "safe_from_gas", "targetname" );

    foreach ( var_2 in level.players )
    {
        if ( !var_2 istouching( var_0 ) )
            var_2 dodamage( 10000, var_2.origin );
    }
}

side_b_visionset_reset()
{
    level endon( "game_ended" );
    level endon( "hangar_doors_closed" );
    var_0 = getent( "safe_from_gas", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( isdefined( var_1 ) && isplayer( var_1 ) && !isdefined( var_1.safefromgas ) )
        {
            var_1 maps\mp\_utility::revertvisionsetforplayer( 3.0 );
            var_1.safefromgas = 1;
        }
    }
}

setup_poison_gas_death()
{
    foreach ( var_1 in level.players )
        var_1 thread onplayerdeath();
}

onplayerdeath()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "spawned" );
    maps\mp\_utility::revertvisionsetforplayer( 0 );
}

shockthink()
{
    if ( !isdefined( self.ingas ) )
        self shellshock( "mp_lab_gas", 1 );
}

play_event_music()
{

}

play_earthquake_rumble( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for ( var_1 = var_0 * 20; var_1 >= 0; var_1 -= 2 )
    {
        self playrumbleonentity( "damage_light" );
        wait 0.1;
    }
}

getlistofgoodspawnpoints( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" )
        {
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
            continue;
        }

        if ( var_3 getvalidspawns() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

getvalidspawns()
{
    if ( level.dynamichangarspawns == 0 )
    {
        if ( self.targetname == "first_map_spawns" )
            return 1;
    }
    else if ( level.dynamichangarspawns == 1 )
    {
        if ( self.targetname == "second_map_spawns" )
            return 1;
    }

    return 0;
}
