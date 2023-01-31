// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread precachefx();
}

precachefx()
{
    level._effect["foliage_dub_potted_spikey_plant"] = loadfx( "fx/props/foliage_dub_potted_spikey_plant" );
    level._effect["knife_kill_fx"] = loadfx( "fx/maps/warlord/intro_blood_throat_stab" );
    level._effect["sniper_drone_fan_distortion"] = loadfx( "vfx/distortion/sniper_drone_runner" );
    level._effect["paint_grenade"] = loadfx( "vfx/explosion/paint_grenade" );
    level._effect["steam_coffee"] = loadfx( "vfx/steam/steam_coffee_slow" );
}

intro_tablet_touch_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "tablet_touch_green" ), var_0, "body_animate_jnt" );
}

outro_tablet_touch_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "tablet_touch_red" ), var_0, "body_animate_jnt" );
}

intro_drone_tablet_touch_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "tablet_touch_green2" ), var_0, "body_animate_jnt" );
}

outro_drone_tablet_touch_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "tablet_touch_red2" ), var_0, "body_animate_jnt" );
}

broom_sweep_dust_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "broom_sweeping_dust" ), var_0, "TAG_ORIGIN" );
}

guarddustdrag()
{
    common_scripts\_exploder::exploder( 70 );
}

sniperdroneprep()
{
    common_scripts\_exploder::exploder( 100 );
    wait 3.5;
    common_scripts\_exploder::exploder( 101 );
}

dronedraftplants()
{
    common_scripts\_exploder::exploder( 120 );
}

ambientcloudsloadin()
{
    common_scripts\_exploder::exploder( 130 );
}

ambientcloudskill()
{
    common_scripts\_exploder::kill_exploder( 130 );
}

safehousesonicdustfx()
{
    common_scripts\_exploder::exploder( 132 );
}

safehousegatebashfx()
{
    common_scripts\_exploder::exploder( 140 );
}
