// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( level.nextgen )
    {
        level.ospvisionset = "mp_urban_osp";
        level.osplightset = "mp_urban_osp";
        level.dronevisionset = "mp_urban_drone";
        level.dronelightset = "mp_urban_drone";
        level.warbirdvisionset = "mp_urban_warbird";
        level.warbirdlightset = "mp_urban_warbird";
    }
}
