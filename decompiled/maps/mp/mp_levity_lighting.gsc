// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

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
        level._id_65AB = "mp_levity_osp";
        level._id_65A9 = "mp_levity_osp";
        level._id_A197 = "mp_levity_warbird";
        level._id_A18C = "mp_levity_warbird";
        level._id_2F3B = "mp_levity_drone";
        level._id_2F12 = "mp_levity_drone";
    }
}
