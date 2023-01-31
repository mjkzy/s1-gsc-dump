// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_mpRimColor", "0.8 0.6 0.3" );
    setdvar( "r_mpRimStrength", "10" );
    setdvar( "r_mpRimDiffuseTint", "1.5 1.5 1.5" );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );

    if ( level.currentgen )
        setdvar( "r_specularcolorscale", 1.0 );

    maps\mp\_mp_lights::init();
}

fire_flicker()
{
    maps\mp\_mp_lights::play_flickerlight_preset( "fire", "fire_flicker", 3000 );
}
