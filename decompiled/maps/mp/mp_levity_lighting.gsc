// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_mpRimColor", ".7 .9 1" );
    setdvar( "r_mpRimStrength", "7" );
    setdvar( "r_mpRimDiffuseTint", ".77 .85 1.1" );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );

    if ( level.currentgen )
    {
        level.ospvisionset = "mp_levity_osp";
        level.osplightset = "mp_levity_osp";
        level.warbirdvisionset = "mp_levity_warbird";
        level.warbirdlightset = "mp_levity_warbird";
        level.dronevisionset = "mp_levity_drone";
        level.dronelightset = "mp_levity_drone";
    }
}
