// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread precachefx();
    common_scripts\utility::flag_init( "SniperDashFXTrigger1" );
    thread sniperdashburstfx1();
    common_scripts\utility::flag_init( "SniperDashFXTrigger2" );
    thread sniperdashburstfx2();
    common_scripts\utility::flag_init( "SniperDashFXTrigger3" );
    thread sniperdashburstfx3();
    common_scripts\utility::flag_init( "SniperDashFXTrigger4" );
    thread sniperdashburstfx4();
    common_scripts\utility::flag_init( "SniperDashFXTrigger5" );
    thread sniperdashburstfx5();
    common_scripts\utility::flag_init( "SniperDashFXTrigger6" );
    thread sniperdashburstfx6();
}

precachefx()
{
    level._effect["smoke_screen"] = loadfx( "vfx/map/greece/greece_smoke_screen_wind_15sec" );
    level._effect["railgun_sniper_tracer"] = loadfx( "vfx/muzzleflash/sniper_railgun_tracer" );
    level._effect["railgun_sniper_glint"] = loadfx( "vfx/lensflare/scope_glint2_greece" );
    level._effect["bottles_misc1_destruct"] = loadfx( "fx/props/bottles_misc1_destruct" );
    level._effect["bottles_misc2_destruct"] = loadfx( "fx/props/bottles_misc2_destruct" );
    level._effect["bottles_misc3_destruct"] = loadfx( "fx/props/bottles_misc3_destruct" );
    level._effect["bottles_misc4_destruct"] = loadfx( "fx/props/bottles_misc4_destruct" );
    level._effect["bottles_misc5_destruct"] = loadfx( "fx/props/bottles_misc5_destruct" );
    level._effect["stinger_rocket_explosion"] = loadfx( "vfx/map/greece/greece_rocket_explosion_default" );
    level._effect["scramble_blood_impact_splat"] = loadfx( "vfx/map/greece/greece_flesh_impact_blood_splat2" );
    level._effect["restaurant_fish_tank_water_splash"] = loadfx( "vfx/water/greece_fishtank_splash_des" );
    level._effect["restaurant_fish_tank_bubbles"] = loadfx( "vfx/water/greece_fishtank_bubbles" );
    level._effect["manga_rocket_trail"] = loadfx( "vfx/trail/smoketrail_rpg_greece" );
    level._effect["manga_rocket_explosion"] = loadfx( "vfx/map/greece/greece_explosion_sniper_tower_burst" );
    level._effect["vehicle_tire_smoke_3"] = loadfx( "vfx/map/greece/greece_veh_tire_damage_smk_3" );
    level._effect["move_truck_fire"] = loadfx( "vfx/map/greece/greece_vehicle_move_truck_fire" );
}

sniperdoorhitfx1( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "sniper_door_hit" ), var_0, "tag_hole1" );
}

sniperdoorhitfx2( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "sniper_door_hit" ), var_0, "tag_hole2" );
}

smokescreenemitterfx()
{
    common_scripts\_exploder::exploder( 145 );
}

windowgapjumpglassshatter()
{
    common_scripts\_exploder::exploder( 150 );
    var_0 = common_scripts\utility::getstruct( "ScramblePlayerGapJumpGlassRef", "targetname" );
    level waittill( "ScramblePlayerBreakWindowGapJump" );
    glassradiusdamage( var_0.origin, 64, 1000, 1000 );
    level.player playrumbleonentity( "damage_light" );
    earthquake( 0.6, 0.4, var_0.origin, 40 );
    screenshake( var_0.origin, 0.2, 0.2, 0.2, 0.4, 0, -1, 40 );
}

windowhoteljumpglassshatter( var_0 )
{
    wait(var_0);
    var_1 = getent( "ScramblePlayerHotelJumpRef", "targetname" );
    glassradiusdamage( var_1.origin, 64, 1000, 1000 );
    var_2 = getglass( "ScrambleHotelGlass" );

    if ( !isglassdestroyed( var_2 ) )
    {
        earthquake( 0.2, 0.2, var_2.origin, 20 );
        screenshake( var_2.origin, 0.1, 0.1, 0.1, 0.2, 0, -1, 20 );
    }
}

sniperdashburstfx1()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "SniperDashFXTrigger1" );
        common_scripts\_exploder::exploder( "151" );
        common_scripts\utility::flag_waitopen( "SniperDashFXTrigger1" );
    }

    wait 5.0;
}

sniperdashburstfx2()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "SniperDashFXTrigger2" );
        common_scripts\_exploder::exploder( "152" );
        common_scripts\utility::flag_waitopen( "SniperDashFXTrigger2" );
    }

    wait 5.0;
}

sniperdashburstfx3()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "SniperDashFXTrigger3" );
        common_scripts\_exploder::exploder( "153" );
        common_scripts\utility::flag_waitopen( "SniperDashFXTrigger3" );
    }

    wait 5.0;
}

sniperdashburstfx4()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "SniperDashFXTrigger4" );
        common_scripts\_exploder::exploder( "154" );
        common_scripts\utility::flag_waitopen( "SniperDashFXTrigger4" );
    }

    wait 5.0;
}

sniperdashburstfx5()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "SniperDashFXTrigger5" );
        common_scripts\_exploder::exploder( "155" );
        common_scripts\utility::flag_waitopen( "SniperDashFXTrigger5" );
    }

    wait 5.0;
}

sniperdashburstfx6()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "SniperDashFXTrigger6" );
        common_scripts\_exploder::exploder( "156" );
        common_scripts\utility::flag_waitopen( "SniperDashFXTrigger6" );
    }

    wait 5.0;
}

snipercafewallburstfx()
{
    common_scripts\_exploder::exploder( 160 );
}

snipertowerexplosionfx()
{
    common_scripts\_exploder::exploder( 200 );
}

snipertowerresidualfx()
{
    common_scripts\_exploder::exploder( 201 );
}

ragdollonfirefx()
{
    playfxontag( common_scripts\utility::getfx( "character_fire_torso" ), self, "J_SpineUpper" );
}

movetruckfirefx()
{
    var_0 = getent( "ScrambleExitTruck", "targetname" );
    var_0.animname = "exit_truck";
    playfxontag( common_scripts\utility::getfx( "move_truck_fire" ), var_0, "TAG_ORIGIN" );
    soundscripts\_snd::snd_message( "exit_truck_fire", var_0 );
}

movetrucktiresmokefx()
{
    var_0 = getent( "ScrambleExitTruck", "targetname" );
    var_0.animname = "exit_truck";
    playfxontag( common_scripts\utility::getfx( "vehicle_tire_smoke_3" ), var_0, "TAG_ORIGIN" );
}

fishbubblesfx()
{
    common_scripts\_exploder::exploder( 999 );
}

killfishbubblesfx()
{
    common_scripts\_exploder::kill_exploder( 999 );
}
