// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level thread _id_804D();
    level._id_0FEA = [];
    level._id_0FEA[1] = spawn( "script_origin", ( 249.0, -2260.0, 1418.0 ) );
    level._id_0FEA[2] = spawn( "script_origin", ( 249.0, -1996.0, 1418.0 ) );
    level._id_0FEA[3] = spawn( "script_origin", ( -225.0, -1996.0, 1418.0 ) );
    level._id_0FEA[4] = spawn( "script_origin", ( -225.0, -2260.0, 1418.0 ) );
}

_id_804D()
{

}

_id_33C1( var_0 )
{
    playsoundatpos( ( 0.0, -2225.0, 1311.0 ), "mp_levity_hanger_door_verb" );
    playsoundatpos( ( 0.0, -2225.0, 1311.0 ), "mp_levity_hanger_door" );
}
