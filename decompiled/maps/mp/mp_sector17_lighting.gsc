// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( level.nextgen )
    {
        level.ospvisionset = "mp_sector17_osp";
        level.osplightset = "mp_sector17_osp";
        level.dronevisionset = "mp_sector17_drone";
        level.dronelightset = "mp_sector17_drone";
        level.warbirdvisionset = "mp_sector17_warbird";
        level.warbirdlightset = "mp_sector17_warbird";
    }
}
