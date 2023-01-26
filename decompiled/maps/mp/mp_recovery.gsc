// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A774::main();
    _id_A6E0::main();
    _id_A773::main();
    maps\mp\_load::main();
    maps\mp\mp_recovery_lighting::main();
    maps\mp\mp_recovery_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_recovery" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_5CB9 = loadfx( "vfx/test/hms_fireball_explosion_xlrg" );
    thread _id_2FDD();
    thread _id_461F();
    thread _id_2FDF();
    var_0 = level.gametype;

    if ( !isdefined( level.ishorde ) )
    {
        if ( !( var_0 == "twar" || var_0 == "sd" || var_0 == "sr" ) )
            level thread maps\mp\_dynamic_events::_id_2FE6( ::_id_7290 );
    }

    level thread onplayerconnect();
    thread _id_8A06();
    level._id_2FEC = "before";
    level.hp_pause_for_dynamic_event = 0;
    level._id_6573 = ::_id_7293;
    level._id_65AB = "mp_recovery_b";
    level._id_65A9 = "mp_recovery_osp";
    level._id_2F3B = "mp_recovery_b";
    level._id_2F12 = "mp_recovery";
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
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -511.0, 1131.0, 162.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -499.0, 1145.0, 162.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -499.0, 1157.0, 162.0 ), ( 0.0, 0.0, 0.0 ) );
}

patchclipsecondsidedoorrocks01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( -208.0, 3304.0, 140.0 ), ( 0.0, 336.0, 0.0 ) );
}

patchclipsecondsidegoliathrock()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -147.0, 4352.5, 170.5 ), ( 0.0, 26.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -124.0, 4366.0, 170.5 ), ( 0.0, 45.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -101.5, 4343.5, 170.5 ), ( 0.0, 45.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -101.5, 4343.5, 138.5 ), ( 0.0, 45.0, 0.0 ) );
}

_id_7293()
{
    level._id_6574._id_89DC = 9324;
    level._id_6574._id_898B = 290;
    level._id_6574._id_898A = 370;
    level._id_6574._id_04BD = -45;
    thread _id_7294();
}

_id_7294()
{
    level waittill( "Gas_Cloud_Start" );
    level._id_6574._id_898B = 120;
    level._id_6574._id_898A = 180;
    level._id_6574._id_99B1 = 55;
    level._id_6574._id_04BD = -40;
    level._id_6574._id_0089 = 65;
}

_id_8A06()
{
    level._id_2FEE = 0;
    level.dynamicspawns = ::_id_4005;
}

_id_7E66()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1" );
        }
    }
}

_id_2FDD()
{
    var_0 = getent( "mp_recovery_signage", "targetname" );
    wait 0.05;
    var_0 common_scripts\utility::hide_notsolid();
    _id_38D8();
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
        var_17.origin += ( 0.0, 0.0, -10000.0 );
    }

    foreach ( var_20 in var_14 )
    {
        var_20 dontinterpolate();
        var_20.origin += ( 0.0, 0.0, -10000.0 );
    }

    foreach ( var_23 in var_15 )
    {
        var_23 dontinterpolate();
        var_23.origin += ( 0.0, 0.0, -10000.0 );
    }

    level waittill( "Missile_Wave2_ended" );
    level._id_2FEE = 1;
    level._id_2FEC = "after";
    wait 5;

    foreach ( var_17 in var_13 )
    {
        var_17 dontinterpolate();
        var_17.origin += ( 0.0, 0.0, 10000.0 );
    }

    wait 5;

    foreach ( var_20 in var_14 )
    {
        var_20 dontinterpolate();
        var_20.origin += ( 0.0, 0.0, 10000.0 );
    }

    wait 5;

    foreach ( var_23 in var_15 )
    {
        var_23 dontinterpolate();
        var_23.origin += ( 0.0, 0.0, 10000.0 );
    }
}

_id_7290()
{
    var_0 = getent( "hologram_signs", "targetname" );
    var_0 common_scripts\utility::hide_notsolid();
    var_1 = getent( "mp_recovery_signage", "targetname" );
    var_1 show();
    thread _id_536A();
    thread _id_89DB();
    thread _id_9F31();
    thread _id_3C19();
}

_id_461F()
{
    var_0 = level.gametype;

    if ( !( var_0 == "dom" || var_0 == "ctf" || var_0 == "hp" || var_0 == "ball" ) )
        return;

    if ( var_0 == "hp" )
        level waittill( "dynamic_event_starting" );
    else
        level waittill( "hangar_doors_opening" );

    level.hp_pause_for_dynamic_event = 1;
    maps\mp\_teleport::_id_924B( "zone_0", 1 );
    level.usestartspawns = 0;
}

_id_2FDF()
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
            var_7 maps\mp\bots\_bots_strategy::_id_15EF();

            switch ( level.gametype )
            {
                case "war":
                case "conf":
                case "infect":
                case "dm":
                    var_7 thread _id_3357( var_4, var_5 );
                    continue;
                default:
                    continue;
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

_id_3D56( var_0 )
{
    var_1 = randomint( var_0.size );
    var_2 = var_0[var_1];
    return var_2;
}

_id_1ED3()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level waittill( "hangar_doors_closed" );
    wait 0.05;
    self _meth_8356();
}

_id_3357( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "hangar_doors_closed" );
    self endon( "disconnect" );
    thread _id_1ED3();

    for (;;)
    {
        var_2 = _id_3D56( var_0 );
        self botsetscriptgoal( var_2.origin, 512, "critical" );
        var_3 = maps\mp\bots\_bots_util::_id_172E( undefined, "death" );

        if ( var_3 == "goal" )
        {
            self _meth_8356();
            wait 5.0;
            continue;
        }

        wait 1.0;
    }
}

_id_89DB()
{
    var_0 = getentarray( "hangar_door_right", "targetname" );
    var_1 = 12;
    var_2 = 12;
    level waittill( "Gas_Cloud_Start" );
    level._id_2FEC = "event_in_progress";

    foreach ( var_4 in var_0 )
    {
        var_5 = getent( var_4.target, "targetname" );
        var_4 moveto( var_5.origin, var_1 );
    }

    thread _id_61FF( var_1 );
    var_7 = getentarray( "hangar_open_sfx", "targetname" );

    foreach ( var_9 in var_7 )
        maps\mp\_audio::_id_8730( "mp_recovery_hangar_door_open", var_9.origin );

    level waittill( "close_doors" );

    foreach ( var_4 in var_0 )
    {
        var_4._id_9A53 = 1;
        var_5 = getent( var_4.target, "targetname" );
        var_12 = getent( var_5.target, "targetname" );
        var_4 moveto( var_12.origin, var_2 );
        level thread _id_A773::_id_8FAB();
    }

    thread _id_61FE( var_2, var_0 );
    var_7 = getentarray( "hangar_open_sfx", "targetname" );

    foreach ( var_9 in var_7 )
        maps\mp\_audio::_id_8730( "mp_recovery_hangar_door_close", var_9.origin );
}

_id_61FE( var_0, var_1 )
{
    level notify( "hangar_doors_closing" );
    playsoundatpos( ( 0.0, 0.0, 0.0 ), "mp_recovery_doors_closing" );
    wait(var_0);
    level notify( "hangar_doors_closed" );
    wait 2;
    playsoundatpos( ( 0.0, 0.0, 0.0 ), "mp_recovery_doors_sealed" );

    foreach ( var_3 in var_1 )
        var_3._id_9A53 = 0;
}

_id_61FF( var_0 )
{
    level notify( "hangar_doors_opening" );
    playsoundatpos( ( 0.0, 0.0, 0.0 ), "mp_recovery_doors_opening" );
    thread _id_8556();
    level.hp_pause_for_dynamic_event = 0;
    level notify( "ready_for_next_hp_zone" );
    wait(var_0);
    level notify( "hangar_doors_opened" );
}

_id_9F31()
{
    thread _id_0EEE();
    earthquake( 0.6, 2, ( 0.0, 0.0, 0.0 ), 5000 );

    foreach ( var_1 in level.players )
        var_1 thread _id_6925( 0.75 );

    level._id_3C15 = getent( "gas_cloud_origin", "targetname" );
    _func_292( 200 );

    if ( isdefined( level._id_6671 ) )
        level._id_6671 delete();

    level thread common_scripts\_exploder::_id_06F5( 100 );
    wait 8;
    thread _id_1752( 15, 2.0, 10, 19 );
    wait 5;

    foreach ( var_1 in level.players )
        var_1 setclienttriggervisionset( "mp_recovery_post", 10.0 );

    level notify( "Gas_Cloud_Start" );
}

_id_0EEE()
{
    playsoundatpos( ( 2067.0, -2296.0, 186.0 ), "emt_event_volcano_erupt" );
    thread _id_0F50();
    wait 4;
    playsoundatpos( ( 0.0, 0.0, 0.0 ), "mp_recovery_volcanic_activity" );
}

_id_0F50()
{
    level endon( "hangar_doors_closed" );

    for (;;)
    {
        playsoundatpos( ( 0.0, 0.0, 0.0 ), "mp_recovery_alarms" );
        wait 4;
    }
}

_id_3C19()
{
    level waittill( "Gas_Cloud_Start" );
    wait 5;
    level._id_3C15 = getent( "gas_cloud_origin", "targetname" );
    playfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level._id_3C15, "tag_origin" );
    wait 5;
    thread _id_1752( 15, 2.0, 20, 29 );
    maps\mp\_utility::delaythread( 15, ::_id_1752, 15, 1.5, 30, 39 );
    level._id_2FEE = 1;
    var_0 = 40;
    var_1 = 12;
    level._id_3C15 moveto( level._id_3C15.origin + ( 0.0, 3912.0, 0.0 ), var_0 );
    level._id_3C15 thread _id_5372( var_0 + var_1, 7.5 );
    var_2 = var_0 - var_1 / 2;
    thread _id_8267();
    wait(var_2);
    level notify( "close_doors" );
    wait(var_1);
    stopfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level._id_3C15, "tag_origin" );
    level._id_3C15 thread _id_4E86();
    level thread common_scripts\_exploder::_id_06F5( 102 );
    wait 0.05;
    level notify( "gas_cloud_finished" );
    _func_292( 40 );
}

onplayerconnect()
{
    var_0 = getent( "safe_from_gas", "targetname" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 thread _id_900A( var_0 );
    }
}

_id_900A( var_0 )
{
    level endon( "gas_cloud_finished" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( !isdefined( var_0 ) || !isdefined( self ) )
            break;

        if ( level._id_2FEC == "event_in_progress" && isalive( self ) )
        {
            if ( !self istouching( var_0 ) && isdefined( self._id_64BB ) )
            {
                self setclienttriggervisionset( "mp_recovery_post", 5.0 );
                stopfxontag( common_scripts\utility::getfx( "pyroclastic_flow_2" ), level._id_3C15, "tag_origin" );
                playfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level._id_3C15, "tag_origin" );
                self._id_64BB = undefined;
            }
            else if ( self istouching( var_0 ) && !isdefined( self._id_64BB ) )
            {
                self setclienttriggervisionset( "", 5.0 );
                stopfxontag( common_scripts\utility::getfx( "pyroclastic_flow_1" ), level._id_3C15, "tag_origin" );
                playfxontag( common_scripts\utility::getfx( "pyroclastic_flow_2" ), level._id_3C15, "tag_origin" );
                self._id_64BB = 1;
            }

            wait 0.2;
            continue;
        }

        wait 1.0;
    }
}

_id_38D8()
{
    var_0 = _func_231( "stairlgt_die_3", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( 0, 1 );

    var_4 = _func_231( "die_2", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 _meth_83F6( 0, 1 );
}

_id_536A()
{
    var_0 = _func_231( "killed_lights", "targetname" );

    foreach ( var_2 in var_0 )
    {
        wait 0.1;
        var_2 _meth_83F6( 0, 1 );
    }

    var_4 = _func_231( "danger_red", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 _meth_83F6( 0, 1 );

    var_8 = _func_231( "die", "targetname" );

    foreach ( var_10 in var_8 )
    {
        var_10 _meth_83F6( 0, 2 );
        wait 0.1;
        var_10 _meth_83F6( 0, 3 );
    }

    var_12 = _func_231( "die_2", "targetname" );

    foreach ( var_14 in var_12 )
        var_14 _meth_83F6( 0, 3 );

    var_16 = _func_231( "stairlgt_die_3", "targetname" );

    foreach ( var_18 in var_16 )
        var_18 _meth_83F6( 0, 3 );

    var_20 = _func_231( "stairlgt_die", "targetname" );

    foreach ( var_22 in var_20 )
    {
        wait 0.1;
        var_22 _meth_83F6( 0, 1 );
        wait 0.15;
        var_22 _meth_83F6( 0, 3 );
    }

    var_24 = _func_231( "stairlgt_die_2", "targetname" );

    foreach ( var_26 in var_24 )
    {
        var_26 _meth_83F6( 0, 3 );
        wait 0.2;
        var_26 _meth_83F6( 0, 1 );
    }

    var_28 = _func_231( "evacuate_lights", "targetname" );

    foreach ( var_30 in var_28 )
        var_30 _meth_83F6( 0, 1 );

    var_32 = _func_231( "evacuate_pill_lights", "targetname" );

    foreach ( var_34 in var_32 )
        var_34 _meth_83F6( 0, 1 );

    var_36 = _func_231( "hologram_lgt", "targetname" );

    foreach ( var_38 in var_36 )
        var_38 _meth_83F6( 0, 2 );

    var_40 = _func_231( "cave_kill", "targetname" );

    foreach ( var_42 in var_40 )
    {
        var_42 _meth_83F6( 0, 1 );
        wait 0.2;
        var_42 _meth_83F6( 0, 2 );
    }
}

_id_1752( var_0, var_1, var_2, var_3 )
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
                level thread common_scripts\_exploder::_id_06F5( var_5 );
                level thread _id_A773::_id_805D( var_5 );
                var_5 = 0;
                break;
            }

            wait 0.05;
        }
    }
}

_id_5372( var_0, var_1 )
{
    var_2 = 800;
    var_3 = getent( "safe_from_gas", "targetname" );
    var_4 = gettime() + var_0 * 1000;

    foreach ( var_6 in level.players )
        var_6._id_5124 = 0;

    while ( gettime() < var_4 )
    {
        foreach ( var_6 in level.players )
        {
            var_9 = var_6 _meth_845C();

            if ( var_6.origin[1] < self.origin[1] - 500 && !var_6 istouching( var_3 ) )
            {
                var_6 dodamage( var_1, var_6.origin );

                if ( !var_6 maps\mp\_utility::isusingremote() && var_9[1] < self.origin[1] && var_9[2] < var_2 )
                {
                    var_6 setclienttriggervisionset( "poison_gas", 1.5 );
                    var_6 shellshock( "mp_lab_gas", 1, 1, 1, 0 );
                }

                var_6._id_5124 = 1;
                continue;
            }

            if ( !var_6 maps\mp\_utility::isusingremote() )
            {
                if ( var_6._id_5124 == 1 )
                {
                    if ( var_6 istouching( var_3 ) )
                        var_6 maps\mp\_utility::revertvisionsetforplayer( 1.5 );
                    else
                        var_6 setclienttriggervisionset( "mp_recovery_post", 1.5 );

                    var_6._id_5124 = 0;
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

_id_4E86()
{
    var_0 = getent( "safe_from_gas", "targetname" );

    foreach ( var_2 in level.players )
    {
        if ( !var_2 istouching( var_0 ) )
            var_2 dodamage( 10000, var_2.origin );
    }
}

_id_8556()
{
    level endon( "game_ended" );
    level endon( "hangar_doors_closed" );
    var_0 = getent( "safe_from_gas", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( isdefined( var_1 ) && isplayer( var_1 ) && !isdefined( var_1._id_774C ) )
        {
            var_1 maps\mp\_utility::revertvisionsetforplayer( 3.0 );
            var_1._id_774C = 1;
        }
    }
}

_id_8267()
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

_id_83CC()
{
    if ( !isdefined( self._id_4C69 ) )
        self shellshock( "mp_lab_gas", 1 );
}

_id_692C()
{

}

_id_6925( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for ( var_1 = var_0 * 20; var_1 >= 0; var_1 -= 2 )
    {
        self playrumbleonentity( "damage_light" );
        wait 0.1;
    }
}

_id_4005( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" )
        {
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
            continue;
        }

        if ( var_3 _id_414B() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

_id_414B()
{
    if ( level._id_2FEE == 0 )
    {
        if ( self.targetname == "first_map_spawns" )
            return 1;
    }
    else if ( level._id_2FEE == 1 )
    {
        if ( self.targetname == "second_map_spawns" )
            return 1;
    }

    return 0;
}
