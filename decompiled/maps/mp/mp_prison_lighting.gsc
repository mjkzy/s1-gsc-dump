// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

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

_id_37B1()
{
    maps\mp\_mp_lights::_id_6948( "fire", "fire_flicker", 3000 );
}
