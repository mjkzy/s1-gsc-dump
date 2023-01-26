// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_reflectionprobefog", "1" );
    setdvar( "r_lightGridEnableTweaks", "1" );
    setdvar( "r_lightGridIntensity", "1.33" );
    setdvar( "r_volumeLightScatter", "0" );
    setdvar( "r_volumeLightScatterUseTweaks", "1" );
    setdvar( "r_volumeLightScatterAngularAtten", ".34" );
    setdvar( "r_volumeLightScatterColor", "0 0 0" );
    setdvar( "r_volumeLightScatterLinearAtten", "1" );
    setdvar( "r_volumeLightScatterEV", "1" );
    setdvar( "r_volumeLightScatterBackgroundDistance", "200000" );
    setdvar( "r_mpRimColor", ".75 0.8 0.8" );
    setdvar( "r_mpRimStrength", "9" );
    setdvar( "r_mpRimDiffuseTint", ".7 .7 .7" );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );

    if ( level.currentgen )
    {
        setdvar( "r_intensity", 1.15 );
        setdvar( "r_brightness", getdvar( "r_brightness" ) + 0.07 );
    }
}
