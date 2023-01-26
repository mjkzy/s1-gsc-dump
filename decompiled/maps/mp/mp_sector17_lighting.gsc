// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( level.nextgen )
    {
        level._id_65AB = "mp_sector17_osp";
        level._id_65A9 = "mp_sector17_osp";
        level._id_2F3B = "mp_sector17_drone";
        level._id_2F12 = "mp_sector17_drone";
        level._id_A197 = "mp_sector17_warbird";
        level._id_A18C = "mp_sector17_warbird";
    }
}
