// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::liberty_callbackstartgametype;
    maps\mp\mp_liberty_precache::main();
    maps\createart\mp_liberty_art::main();
    maps\mp\mp_liberty_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_liberty_lighting::main();
    maps\mp\mp_liberty_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_liberty" );
    thread setupdynamicevent();
    thread dynamictraversals();
    thread aud_pa_map_event_1min();
    thread aud_pa_system_announcements_decon();
    thread aud_pa_system_announcements_vessel();
    thread aud_pa_system_announcements_medzone();
    maps\mp\_water::init();
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.ospvisionset = "mp_liberty_osp";
    level.osplightset = "mp_liberty_osp";
    level.dronevisionset = "mp_liberty_drone";
    level.dronelightset = "mp_liberty_drone";
    level.warbirdvisionset = "mp_liberty_warbird";
    level.warbirdlightset = "mp_liberty_warbird";
    level.skip_bot_node_checks = 1;
    level.monkeytriggerplayers = [];
    level.monkeytriggerplayers2 = [];
    level thread monkeysmonitorshooting();
    level thread monkeysmonitorshooting2();
    level thread monkeys();
    level thread monkeys2();

    if ( level.nextgen )
        level thread patchclip();
}

liberty_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

patchclip()
{

}

setupdynamicevent()
{
    level thread maps\mp\_dynamic_events::dynamicevent( ::dynamiceventstartfunc, undefined, ::dynamiceventendfunc );
}

dynamiceventstartfunc()
{
    level thread common_scripts\_exploder::activate_clientside_exploder( 2 );
    playsoundatpos( ( 0, 0, 0 ), "mp_liberty_alarm_start" );
    wait 6;
    level notify( "doors opening" );
    var_0 = getent( "ape_door", "targetname" );
    var_1 = getent( "ape_door2", "targetname" );
    var_2 = getent( "physicsJolt", "targetname" );
    physicsjolt( var_2.origin, 512, 256, ( 0, -0.4, 0.1 ) );
    var_3 = var_0 common_scripts\utility::spawn_tag_origin();
    var_3 _meth_804D( var_0 );
    var_3 show();
    playfxontag( common_scripts\utility::getfx( "lib_hatchet_doors_open" ), var_3, "tag_origin" );
    var_4 = var_1 common_scripts\utility::spawn_tag_origin();
    var_4 _meth_804D( var_1 );
    var_4 show();
    playfxontag( common_scripts\utility::getfx( "lib_hatchet_doors_open_2" ), var_4, "tag_origin" );
    thread maps\mp\mp_liberty_fx::dynamic_door_dust_effect();
    thread disconnectnodes();
    var_5 = getentarray( "ape_door_sfx", "targetname" );

    foreach ( var_7 in var_5 )
    {

    }

    level thread common_scripts\_exploder::activate_clientside_exploder( 2 );
    var_0 _meth_82B5( ( 0, 0, -80 ), 15, 4, 4 );
    var_1 _meth_82B5( ( 0, 0, 80 ), 15, 4, 4 );
    var_9 = var_0 _meth_8436();
    var_9 = common_scripts\utility::array_combine( var_9, var_1 _meth_8436() );

    for ( var_10 = 0; var_10 < var_9.size; var_10++ )
    {
        if ( isdefined( var_9[var_10].targetname ) && var_9[var_10].targetname == "care_package" )
            var_9[var_10] maps\mp\killstreaks\_airdrop::deletecrate();

        if ( isdefined( var_9[var_10].classname ) && var_9[var_10].classname == "misc_turret" )
            var_9[var_10] notify( "death" );
    }

    thread maps\mp\_audio::snd_play_in_space( "mp_lib_monkey_doors_full", var_0.origin );
    thread maps\mp\_audio::snd_play_in_space( "mp_lib_monkey_doors_bed", var_0.origin );
    thread maps\mp\_audio::snd_play_in_space( "dynwarn_liberty_doors_opening", ( 216, 179, 545 ) );
    wait 12;
    var_11 = getent( "physicsJolt2", "targetname" );
    physicsjolt( var_11.origin, 512, 256, ( 0, -0.4, 0.1 ) );
    maps\mp\_audio::snd_play_in_space( "dynwarn_liberty_doors_open", ( 216, 179, 545 ) );
    wait 2;
}

dynamiceventendfunc()
{
    level notify( "doors opening" );
    var_0 = getent( "ape_door", "targetname" );
    var_1 = getent( "ape_door2", "targetname" );
    var_0 _meth_82B5( ( 0, 0, -80 ), 1 );
    var_1 _meth_82B5( ( 0, 0, 80 ), 1 );
    thread disconnectnodes();
}

dynamictraversals()
{
    var_0 = getnodearray( "dynamic_traversal_add", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8059();

    level waittill( "doors opening" );

    foreach ( var_2 in var_0 )
        var_2 _meth_805A();
}

disconnectnodes()
{
    var_0 = getnodearray( "dynamic_node_delete", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8059();

    var_4 = getnodearray( "dynamic_traversal_delete", "script_noteworthy" );

    foreach ( var_6 in var_4 )
        var_6 _meth_8059();
}

monkeys()
{
    level.monkeytriggers = getent( "monkey_trigger", "targetname" );
    level.monkeys = getentarray( "caged_monkey", "targetname" );
    level.monkeyanimvariants = [ "a", "a2", "b", "b2" ];
    level.monkeyanimsubvariants = [ "", "2" ];

    foreach ( var_1 in level.monkeys )
        var_1 thread startdefaultanim();

    level.monkeytriggers thread monkeytriggerthink();
}

startdefaultanim()
{
    var_0 = randomfloatrange( 0.5, 5 );
    wait(var_0);
    var_1 = common_scripts\utility::random( level.monkeyanimvariants );
    var_2 = common_scripts\utility::random( level.monkeyanimsubvariants );

    if ( var_1 == "a" )
        var_2 = "";
    else if ( var_1 == "a2" )
        var_2 = "2";
    else if ( var_1 == "b" )
        var_2 = "";
    else if ( var_1 == "b2" )
        var_2 = "2";

    self _meth_8279( "liberty_monkey_calm_idle_" + var_1 + var_2 );
    self.freakoutstate = "calm";
}

monkeytriggerthink()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) && !common_scripts\utility::array_contains( level.monkeytriggerplayers, var_0 ) )
        {
            level.monkeytriggerplayers = common_scripts\utility::array_add( level.monkeytriggerplayers, var_0 );
            var_0 thread monitormonkeytriggerexit( self );
        }
    }
}

monkeysmonitorshooting()
{
    for (;;)
    {
        foreach ( var_1 in level.monkeytriggerplayers )
        {
            if ( isplayer( var_1 ) && var_1 _meth_812D() )
            {
                foreach ( var_3 in level.monkeys )
                {
                    if ( var_3.freakoutstate == "calm" )
                        var_3 thread monkeyfreakout();
                }

                wait 1.0;
            }
        }

        wait 0.05;
    }
}

monitormonkeytriggerexit( var_0 )
{
    while ( isdefined( self ) && self _meth_80A9( var_0 ) )
        wait 0.05;

    if ( common_scripts\utility::array_contains( level.monkeytriggerplayers, self ) )
        level.monkeytriggerplayers = common_scripts\utility::array_remove( level.monkeytriggerplayers, self );
}

monkeyfreakout()
{
    self.freakoutstate = "freaking_out";
    thread aud_monkey_freakout();
    var_0 = randomfloatrange( 0.1, 2.5 );
    wait(var_0);
    var_1 = common_scripts\utility::random( level.monkeyanimvariants );
    var_2 = common_scripts\utility::random( level.monkeyanimsubvariants );

    if ( var_1 == "a" )
        var_2 = "";
    else if ( var_1 == "a2" )
        var_2 = "2";
    else if ( var_1 == "b" )
        var_2 = "";
    else if ( var_1 == "b2" )
        var_2 = "2";

    self _meth_827A();
    self _meth_8279( "liberty_monkey_calm_2_freak_" + var_1 + var_2, "freak_out" );
    self waittillmatch( "freak_out", "end" );
    self _meth_827A();
    self _meth_8279( "liberty_monkey_freak_idle_" + var_1 + var_2, "freak_idle" );
    self.freakoutstate = "freaking_out";
    self waittillmatch( "freak_idle", "end" );
    self _meth_827A();
    self endon( "cancel_calmdown" );
    self.freakoutstate = "calm";
    self _meth_8279( "liberty_monkey_freak_2_calm_" + var_1 + var_2, "freak_2_calm" );
    self waittillmatch( "freak_2_calm", "end" );
    self _meth_827A();
    restartdefaultanim( var_1 );
}

aud_monkey_freakout()
{
    var_0 = randomfloatrange( 1, 2.5 );
    wait(var_0);
    self playsound( "mp_lib_monkey_yells" );
    wait(var_0);
    self playsound( "mp_lib_monkey_yells" );
}

restartdefaultanim( var_0 )
{
    self _meth_8279( "liberty_monkey_calm_idle_" + var_0 );
    self.freakoutstate = "calm";
}

monkeys2()
{
    level.monkeytriggers2 = getent( "monkey_trigger2", "targetname" );
    level.monkeys2 = getentarray( "caged_monkey2", "targetname" );
    level.monkeyanimvariants = [ "a", "b" ];
    level.monkeyanimsubvariants = [ "", "2" ];

    foreach ( var_1 in level.monkeys2 )
        var_1 thread startdefaultanim2();

    level.monkeytriggers2 thread monkeytriggerthink2();
}

startdefaultanim2()
{
    var_0 = randomfloatrange( 0.5, 5 );
    wait(var_0);
    var_1 = common_scripts\utility::random( level.monkeyanimvariants );

    if ( var_1 != "b" )
        var_2 = common_scripts\utility::random( level.monkeyanimsubvariants );
    else
        var_2 = "";

    self _meth_8279( "liberty_monkey_calm_idle_" + var_1 + var_2 );
    self.freakoutstate = "calm";
}

monkeytriggerthink2()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) && !common_scripts\utility::array_contains( level.monkeytriggerplayers2, var_0 ) )
        {
            level.monkeytriggerplayers2 = common_scripts\utility::array_add( level.monkeytriggerplayers2, var_0 );
            var_0 thread monitormonkeytriggerexit2( self );
        }
    }
}

monkeysmonitorshooting2()
{
    for (;;)
    {
        foreach ( var_1 in level.monkeytriggerplayers2 )
        {
            if ( isplayer( var_1 ) && var_1 _meth_812D() )
            {
                foreach ( var_3 in level.monkeys2 )
                {
                    if ( var_3.freakoutstate == "calm" )
                        var_3 thread monkeyfreakout2();
                }

                wait 1.0;
            }
        }

        wait 0.05;
    }
}

monitormonkeytriggerexit2( var_0 )
{
    while ( isdefined( self ) && self _meth_80A9( var_0 ) )
        wait 0.05;

    if ( common_scripts\utility::array_contains( level.monkeytriggerplayers2, self ) )
        level.monkeytriggerplayers2 = common_scripts\utility::array_remove( level.monkeytriggerplayers2, self );
}

monkeyfreakout2()
{
    self.freakoutstate = "freaking_out";
    thread aud_monkey_freakout();
    var_0 = randomfloatrange( 0.1, 2.5 );
    wait(var_0);
    var_1 = common_scripts\utility::random( level.monkeyanimvariants );
    var_2 = common_scripts\utility::random( level.monkeyanimsubvariants );
    self _meth_827A();
    self _meth_8279( "liberty_monkey_calm_2_freak_" + var_1 + var_2, "freak_out" );
    self waittillmatch( "freak_out", "end" );
    self _meth_827A();
    self _meth_8279( "liberty_monkey_freak_idle_" + var_1 + var_2, "freak_idle" );
    self.freakoutstate = "freaking_out";
    self waittillmatch( "freak_idle", "end" );
    self _meth_827A();
    self endon( "cancel_calmdown" );
    self.freakoutstate = "calm";
    self _meth_8279( "liberty_monkey_freak_2_calm_" + var_1 + var_2, "freak_2_calm" );
    self waittillmatch( "freak_2_calm", "end" );
    self _meth_827A();
    restartdefaultanim2( var_1 );
}

restartdefaultanim2( var_0 )
{
    self _meth_8279( "liberty_monkey_calm_idle_" + var_0 );
    self.freakoutstate = "calm";
}

aud_pa_map_event_1min()
{
    wait 240.0;
    common_scripts\utility::play_sound_in_space( "dynwarn_liberty_doors_1min", ( 216, 179, 545 ) );
}

aud_pa_system_announcements_decon()
{
    var_0 = randomfloatrange( 40.0, 75.0 );

    for (;;)
    {
        wait(var_0);
        thread common_scripts\utility::play_sound_in_space( "dynwarn_liberty_decon", ( 2149, 28, 347 ) );
        wait 4;
    }
}

aud_pa_system_announcements_vessel()
{
    var_0 = randomfloatrange( 45.0, 60.0 );

    for (;;)
    {
        wait(var_0);
        thread common_scripts\utility::play_sound_in_space( "dynwarn_liberty_vessel", ( -337, 2701, 427 ) );
        wait 7;
    }
}

aud_pa_system_announcements_medzone()
{
    var_0 = randomfloatrange( 35.0, 55.0 );

    for (;;)
    {
        wait(var_0);
        thread common_scripts\utility::play_sound_in_space( "dynwarn_liberty_medzone", ( 286, -681, 439 ) );
        wait 10;
    }
}
