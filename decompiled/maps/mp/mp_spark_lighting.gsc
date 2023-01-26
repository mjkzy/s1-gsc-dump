// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );

    if ( level.nextgen )
    {
        level._id_65AB = "mp_spark_osp";
        level._id_65A9 = "mp_spark_osp";
        level._id_2F3B = "mp_spark_drone";
        level._id_2F12 = "mp_spark_drone";
        level._id_A197 = "mp_spark_warbird";
        level._id_A18C = "mp_spark_warbird";
        level.dnavisionset = "mp_spark_dna";
        setdvar( "r_hemiAoEnable", 0 );
    }
    else
    {
        level._id_65AB = "mp_spark_osp_cg";
        level._id_2F3B = "mp_spark_drone_cg";
        level._id_A197 = "mp_spark_warbird_cg";
        level.dnavisionset = "mp_spark_dna_cg";
        setdvar( "r_hemiAoEnable", 0 );
    }
}
