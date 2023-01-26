// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.customzombiemusicstates = ::customzombiemusicstates;
    thread onplayerconnectedaudio();
    thread h2o_lobby_music();
}

onplayerconnectedaudio()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 _meth_84D7( "master_mix" );
    }
}

h2o_lobby_music()
{
    wait 10;

    for (;;)
    {
        playsoundatpos( ( -1021.0, 1613.0, 206.0 ), "h2o_lobby_music_loc1" );
        playsoundatpos( ( 1008.0, 2095.0, 243.0 ), "h2o_lobby_music_loc2" );
        wait 50;
    }
}

customzombiemusicstates()
{
    level thread maps\mp\zombies\_zombies_music::setupmusicstate( 0, "round_start_hard_mode", "zmb_mus_nightmare_01", 0, 0, 0.5, 0 );
    level thread maps\mp\zombies\_zombies_music::setupmusicstate( 1, "round_zombie_boss_oz_stage1", [ "zmb_mus_bossfight_01" ], 0, 1, 1, 1 );
    level thread maps\mp\zombies\_zombies_music::setupmusicstate( 1, "round_zombie_boss_oz_stage2", [ "zmb_mus_bossfight_02" ], 0, 1, 1, 1 );
    level thread maps\mp\zombies\_zombies_music::setupmusicstate( 1, "ee_bus_end", [ "zmb_mus_postround" ], 0, 1, 1, 0 );
}

sndbossozstartstage1()
{
    foreach ( var_1 in level.players )
        var_1 _meth_84D7( "boss_oz" );

    level waittill( "teleport_players_back" );

    foreach ( var_1 in level.players )
        var_1 _meth_84D8( "boss_oz" );
}

sndbossozstartstage2()
{
    foreach ( var_1 in level.players )
        var_1 _meth_84D7( "boss_oz_2" );

    level waittill( "boss_oz_killed" );

    foreach ( var_1 in level.players )
        var_1 _meth_84D8( "boss_oz_2" );
}

sndbossozfire( var_0 )
{
    var_1 = spawn( "script_origin", var_0 );
    var_1 playloopsound( "boss_fire_large" );
}

sndtubestart( var_0, var_1 )
{
    var_1 playlocalsound( "evt_transit_tube_plr" );
    var_2 = spawn( "script_origin", var_0.origin );
    var_2 playsoundtoteam( "evt_transit_tube_start_npc", "allies", var_1 );
    wait 4;
    var_2 delete();
}

sndtubeend( var_0, var_1 )
{
    var_2 = spawn( "script_origin", var_0 );
    wait 0.5;
    var_2 playsoundtoteam( "evt_transit_tube_stop_npc", "allies", var_1 );
    wait 4;
    var_2 delete();
}

sndvalvelight( var_0 )
{
    var_1 = var_0 + ( 0.0, 0.0, 20.0 );
    playsoundatpos( var_1, "ee_marker_light_off" );
    var_2 = spawn( "script_origin", var_1 );
    var_2 playloopsound( "ee_lightbulb_buzz_int_lp" );
}

sndcomputerloop()
{
    var_0 = spawn( "script_origin", ( -1781.0, 5415.0, 448.0 ) );
    var_0 playloopsound( "ee_computer_loop" );
}

sndcomputeracknowledge( var_0 )
{
    playsoundatpos( var_0, "ee_pad_activated" );
}

sndcomputerfail( var_0 )
{
    playsoundatpos( var_0, "ee_computer_negative" );
}

snddepressurizeloopstart( var_0 )
{
    var_0 endon( "depressurize_cancelled" );
    playsoundatpos( var_0.origin, "ee_depressurize_start" );
    wait 1;
    var_0 playloopsound( "ee_depressurize_loop" );
}

snddepressurizeloopend( var_0 )
{
    var_0 notify( "depressurize_cancelled" );
    var_0 stoploopsound( "ee_depressurize_loop" );
    playsoundatpos( var_0.origin, "ee_depressurize_loop_end" );
}

snddepressurizecomplete( var_0 )
{
    playsoundatpos( var_0.origin, "ee_depressurize_loop_end" );
    playsoundatpos( var_0.origin, "ee_depressurize_end" );
}

sndairlockdoorinteract( var_0 )
{
    playsoundatpos( var_0, "ee_door_locked" );
}

sndfillwithwater()
{
    wait 0.5;
    playsoundatpos( ( 2435.0, 2183.0, 86.0 ), "ee_depressurize_room_fill" );
}

snddrainwater()
{
    wait 0.65;
    playsoundatpos( ( 2435.0, 2183.0, 86.0 ), "ee_depressurize_room_drain" );
}

sndunderwaterenter( var_0 )
{
    var_0 _meth_8426( "underwater", "underwater", 0 );
    var_0 playlocalsound( "ee_underwater_enter" );
}

sndunderwaterexit( var_0 )
{
    if ( isalive( var_0 ) )
        var_0 playlocalsound( "ee_underwater_exit" );

    var_0 _meth_83F1( 0 );
}

sndunderwaterpanelaccessed( var_0 )
{
    playsoundatpos( var_0, "ee_underwater_panel" );
}

sndbouncingenergypuzzlesuccess( var_0 )
{
    playsoundatpos( var_0, "sentry_explode" );
}

sndcapacitorcoverblownoff( var_0 )
{
    playsoundatpos( var_0, "ee_capacitor_cover_blown" );
}

sndcapacitorcharging( var_0 )
{
    wait 0.3;
    playsoundatpos( ( -796.0, 2631.0, -64.0 ), "ee_capacitor_charging_" + var_0 );
}

sndcapacitorchargedsuccess( var_0 )
{
    playsoundatpos( var_0.origin, "ee_capacitor_charged" );
    wait 1.5;
    thread common_scripts\utility::play_loopsound_in_space( "ee_capacitor_electricity_loop", var_0.origin );
}

sndjumpingpuzzlesucess( var_0 )
{
    wait 0.5;
    var_0 playlocalsound( "ee_step_success" );
}

sndjumpingpuzzleplatformlock( var_0 )
{
    playsoundatpos( var_0, "ee_jumping_platform_lock" );
}

sndjumpingpuzzleplatformwhoosh()
{
    playsoundatpos( ( -1203.0, 75.0, 842.0 ), "ee_jumping_platform_whoosh" );
}

sndjumpingpuzzleplayerwhoosh()
{
    self playsoundtoplayer( "ee_jumping_platform_player_whoosh", self );
}

sndlightpuzzle( var_0, var_1 )
{
    playsoundatpos( var_0, var_1 );
}

sndlightpuzzlefail()
{
    playsoundatpos( ( 617.0, 367.0, 290.0 ), "ee_puzzle_beep_fail" );
}

sndlightpuzzlesuccess()
{
    playsoundatpos( ( 617.0, 367.0, 290.0 ), "ee_puzzle_beep_success" );

    foreach ( var_1 in level.players )
        var_1 playlocalsound( "ee_step_success" );
}

sndcounterdigitflip( var_0 )
{
    playsoundatpos( var_0, "ee_counter_flip" );
}

sndcounterdigitsuccess()
{
    foreach ( var_1 in level.players )
        var_1 playlocalsound( "ee_step_success" );
}

sndusememorymachine( var_0 )
{
    playsoundatpos( var_0.origin, "ee_computer_use" );
    maps\mp\zombies\_zombies_music::disablemusicstatechanges();
}

sndteleporttobuszone()
{
    self endon( "disconnect" );
    self _meth_8426( "mp_zombie_h2o_bus_sequence", "mp_zombie_h2o_bus_sequence", 0 );
    level waittill( "sq_teleport_players_back" );
    self _meth_83F1();
}

sndbusmusic()
{
    var_0 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    level waittill( "sq_player_teleport_to_bus_zone" );
    wait 0.5;
    var_0 playloopsound( "zmb_mus_memory_bus" );
    level waittill( "sq_teleport_players_back" );
    maps\mp\zombies\_zombies_music::enablemusicstatechanges();
    wait 5.7;
    maps\mp\zombies\_zombies_music::changezombiemusic( "ee_bus_end" );
    var_0 scalevolume( 0, 2 );
    wait 2.3;
    var_0 delete();
}
