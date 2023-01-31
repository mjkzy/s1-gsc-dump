// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_reflectionprobefog", "1" );
    setdvar( "r_lightGridEnableTweaks", "1" );
    setdvar( "r_lightGridIntensity", "1.33" );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );

    if ( level.currentgen )
    {
        setdvar( "r_intensity", 1.15 );
        setdvar( "r_brightness", getdvar( "r_brightness" ) + 0.07 );
    }
}
