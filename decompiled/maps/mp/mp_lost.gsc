// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::lost_callbackstartgametype;
    maps\mp\mp_lost_precache::main();
    maps\createart\mp_lost_art::main();
    maps\mp\mp_lost_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_lost_lighting::main();
    maps\mp\mp_lost_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_lost" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_5985 = ::lostcustomkillstreakfunc;
    _id_A75F::init();
    level._id_6573 = ::lostpaladinoverrides;
    level._id_65AB = "mp_lost_osp";
    level._id_65A9 = "mp_lost_osp";

    if ( level.currentgen )
        level.warbirdzoffset = 575;

    thread _id_2E21();
    thread sandcrawler_anims();
    thread core_watersheeting();
    var_0 = getent( "lost_reactor_core_machine_mid", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 delete();

    thread kill_triggers();
    thread patchclipfixes();
}

patchclipfixes()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3120.0, -1784.0, -48.0 ), ( 0.0, 30.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3120.0, -1784.0, 208.0 ), ( 0.0, 30.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3120.0, -1784.0, 464.0 ), ( 0.0, 30.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3120.0, -1784.0, 720.0 ), ( 0.0, 30.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3120.0, -1784.0, 976.0 ), ( 0.0, 30.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3120.0, -1784.0, 1232.0 ), ( 0.0, 30.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2200.0, -1352.0, 224.0 ), ( 0.0, 135.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2200.0, -1352.0, 480.0 ), ( 0.0, 135.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2200.0, -1352.0, 736.0 ), ( 0.0, 135.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2200.0, -1352.0, 992.0 ), ( 0.0, 135.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2376.0, -1528.0, 224.0 ), ( 0.0, 135.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2376.0, -1528.0, 480.0 ), ( 0.0, 135.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2376.0, -1528.0, 736.0 ), ( 0.0, 135.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2376.0, -1528.0, 992.0 ), ( 0.0, 135.0, 0.0 ) );
}

kill_triggers()
{
    var_0 = 300;
    var_1 = 300;
    var_2 = [];
    var_2[var_2.size] = spawn( "trigger_radius", ( 2160.0, -1216.0, 88.0 ), 0, var_0, var_1 );
    var_2[var_2.size] = spawn( "trigger_radius", ( 2160.0, -544.0, 88.0 ), 0, var_0, var_1 );
    var_2[var_2.size] = spawn( "trigger_radius", ( 2112.0, 48.0, 88.0 ), 0, var_0, var_1 );
    var_2[var_2.size] = spawn( "trigger_radius", ( 2048.0, 592.0, 72.0 ), 0, var_0, var_1 );
    var_2[var_2.size] = spawn( "trigger_radius", ( 2136.0, 1056.0, 72.0 ), 0, 64, var_1 );
    var_2[var_2.size] = spawn( "trigger_radius", ( 2008.0, 1324.0, 72.0 ), 0, 64, var_1 );

    foreach ( var_4 in var_2 )
        var_4 thread _id_4B09();

    var_6 = getentarray( "trigger_hurt", "classname" );
    var_7 = 8;

    foreach ( var_4 in var_6 )
    {
        if ( distance( var_4.origin, ( -2036.0, -2428.0, 80.0 ) ) <= var_7 )
        {
            var_4.origin += ( 0.0, 0.0, 32.0 );
            continue;
        }

        if ( distance( var_4.origin, ( -2968.0, -168.0, 80.0 ) ) <= var_7 )
            var_4.origin += ( 32.0, 0.0, 32.0 );
    }

    var_4 = spawn( "trigger_radius", ( -1776.0, 1016.0, -64.0 ), 0, var_0, var_1 );
    var_4 thread _id_4B09();

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        level.hordekilltriggers = [];

        foreach ( var_11 in var_2 )
            level.hordekilltriggers[level.hordekilltriggers.size] = var_11;

        level.hordekilltriggers[level.hordekilltriggers.size] = var_4;
    }
}

_id_4B09()
{
    level endon( "game_ended" );
    wait(randomfloat( 1.0 ));

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( var_1 istouching( self ) && maps\mp\_utility::isreallyalive( var_1 ) )
            {
                if ( isdefined( level.ishorde ) && level.ishorde )
                {
                    var_1 dodamage( 10000, var_1.origin, undefined, undefined, "MOD_TRIGGER_HURT", "none", "none" );
                    continue;
                }

                var_1 maps\mp\_utility::_suicide();
            }
        }

        wait 0.5;
    }
}

core_watersheeting()
{
    level endon( "game_ended" );
    var_0 = getentarray( "core_watersheeting", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread watch_player_inwatersheeting();
}

watch_player_inwatersheeting()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( !isplayer( var_0 ) && !isai( var_0 ) )
            continue;

        if ( !isalive( var_0 ) )
            continue;

        if ( var_0 maps\mp\_utility::isusingremote() )
            continue;

        if ( !isdefined( var_0.inwatersheeting ) )
            var_0 thread player_inwatersheeting( self );
    }
}

player_inwatersheeting( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );

    for (;;)
    {
        if ( !self istouching( var_0 ) )
        {
            player_end_watersheeting( 1, 0.5 );
            return 0;
        }

        if ( isdefined( self.inwatersheeting ) && maps\mp\_utility::isusingremote() )
        {
            player_end_watersheeting();
            return 0;
        }
        else if ( !isdefined( self.inwatersheeting ) )
        {
            self.inwatersheeting = 1;
            thread player_loop_watersheeting();
            thread player_watch_disconnect();
        }

        wait 0.1;
    }
}

player_end_watersheeting( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( isdefined( self ) && isplayer( self ) )
    {
        self.inwatersheeting = undefined;
        self notify( "end_watersheeting" );

        if ( isdefined( var_1 ) )
            self _meth_8218( var_0, var_1 );
        else
            self _meth_8218( var_0 );
    }
}

player_loop_watersheeting()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "end_watersheeting" );
    self endon( "joined_team" );

    while ( isdefined( self.inwatersheeting ) )
    {
        self _meth_8218( 1, 20 );
        wait 10.367;
    }
}

player_watch_disconnect()
{
    level endon( "game_ended" );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators", "death" );
    player_end_watersheeting();
}

lostpaladinoverrides()
{
    level._id_6574._id_89DC = 9553;
}

lost_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

lostcustomkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_lost::init();
}

_id_2E21()
{
    var_0 = getent( "drone_cleaner_01", "targetname" );
    var_1 = getent( "drone_cleaner_02", "targetname" );
    var_2 = getent( "drone_cleaner_03", "targetname" );
    var_3 = var_1.origin;
    var_4 = var_1.angles;
    var_0 willneverchange( 0 );
    var_1 willneverchange( 0 );
    var_2 willneverchange( 0 );
    var_5 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_5 setmodel( "lost_repair_drone_01" );
    var_5.origin = var_0.origin;
    var_5.angles = var_0.angles;
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_5, "lost_repair_drone_standby_idle01", "drone_cleaner_01_notify", "aud_lost_drone_idle_01", "mp_lost_drone_idle_01", "aud_drone_01_end_01", "aud_drone_01_end_02", "aud_drone_01_end_03" );
    var_5 thread maps\mp\mp_lost_fx::play_jackhammer_robot_concrete_fx();
    var_6 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_6 setmodel( "lost_repair_drone_01" );
    var_6.origin = var_1.origin - ( 0.0, 0.0, 25.0 );
    var_6.angles = var_1.angles;
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_6, "lost_repair_drone_standby_idle02", "drone_cleaner_02_notify", "aud_lost_drone_idle_02", "mp_lost_drone_idle_02", "aud_drone_02_end_01", "aud_drone_02_end_02", "aud_drone_02_end_03" );
    var_6 thread maps\mp\mp_lost_fx::play_poking_robot_concrete_fx();
    var_7 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_7 setmodel( "lost_repair_drone_01" );
    var_7.origin = var_2.origin;
    var_7.angles = var_2.angles;
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_7, "lost_repair_drone_standby_idle03", "drone_cleaner_03_notify", "aud_lost_drone_idle_03", "mp_lost_drone_idle_03", "aud_drone_03_end_01", "aud_drone_03_end_02", "aud_drone_03_end_03" );
    var_7 thread maps\mp\mp_lost_fx::play_jackhammer_robot_fx();
    var_0 delete();
    var_1 delete();
    var_2 delete();
    var_8 = getent( "drone_cleaner_02_sign", "targetname" );
    var_9 = spawn( "script_model", var_3 );
    var_9 setmodel( "genericprop" );
    var_9.angles = var_4;
    var_8.origin = var_3;
    var_8.angles = var_4;
    var_8 linkto( var_9, "tag_origin_animated" );
    var_9 scriptmodelplayanim( "lost_repair_drone_standby_idle02_sign" );
    var_10 = getent( "drone_cleaner_02_sign02", "targetname" );
    var_11 = spawn( "script_model", var_3 );
    var_11 setmodel( "genericprop" );
    var_11.angles = var_4;
    var_10.origin = var_3;
    var_10.angles = var_4;
    var_10 linkto( var_11, "tag_origin_animated" );
    var_11 scriptmodelplayanim( "lost_repair_drone_standby_idle02_sign02" );
    wait 0.05;
    var_12 = [ "ps_mp_lost_drone_walk_pt_01", "ps_mp_lost_drone_walk_pt_02", "ps_mp_lost_drone_walk_pt_03", "ps_mp_lost_drone_walk_pt_04", "ps_mp_lost_drone_drill_01", "ps_mp_lost_drone_walk_pt_05", "ps_mp_lost_drone_walk_pt_06", "ps_mp_lost_drone_walk_pt_07", "ps_mp_lost_drone_walk_pt_08", "ps_mp_lost_drone_drill_02" ];
    var_13 = [ "mp_lost_drone_walk_pt_01", "mp_lost_drone_walk_pt_02", "mp_lost_drone_walk_pt_03", "mp_lost_drone_walk_pt_04", "mp_lost_drone_walk_drill_01", "mp_lost_drone_walk_pt_05", "mp_lost_drone_walk_pt_06", "mp_lost_drone_walk_pt_07", "mp_lost_drone_walk_pt_08", "mp_lost_drone_walk_drill_02" ];
    var_14 = getent( "drone_cleaner_04", "targetname" );
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_14, "lost_canal_drone01_walk_to_idle02", "drone_cleaner_04_notify", var_12, var_13, "aud_drone_04_end_01", "aud_drone_04_end_02", "aud_drone_04_end_03" );
    var_14 thread maps\mp\mp_lost_fx::play_cleaner_walk_fx();
    var_15 = getent( "lost_canal_drone_04_collision", "targetname" );
    var_15 linkto( var_14, "tag_origin" );
    var_15 solid();
    wait 3;
    var_16 = getent( "drone_cleaner_05", "targetname" );
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_16, "lost_canal_drone01_walk_to_idle02", "drone_cleaner_05_notify", var_12, var_13, "aud_drone_05_end_01", "aud_drone_05_end_02", "aud_drone_05_end_03" );
    var_16 thread maps\mp\mp_lost_fx::play_cleaner_walk_fx();
    var_17 = getent( "lost_canal_drone_05_collision", "targetname" );
    var_17 linkto( var_16, "tag_origin" );
    var_17 solid();
}

sandcrawler_anims()
{
    level endon( "game_ended" );
    var_0 = getentarray( "lost_sandcrawler", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 scriptmodelplayanim( "lost_sand_crawler_idle01" );
}
