// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level thread setup_audio();
    level.aud_piston_ent = [];
    level.aud_piston_ent[1] = spawn( "script_origin", ( 249, -2260, 1418 ) );
    level.aud_piston_ent[2] = spawn( "script_origin", ( 249, -1996, 1418 ) );
    level.aud_piston_ent[3] = spawn( "script_origin", ( -225, -1996, 1418 ) );
    level.aud_piston_ent[4] = spawn( "script_origin", ( -225, -2260, 1418 ) );
}

setup_audio()
{

}

event_aud( var_0 )
{
    playsoundatpos( ( 0, -2225, 1311 ), "mp_levity_hanger_door_verb" );
    playsoundatpos( ( 0, -2225, 1311 ), "mp_levity_hanger_door" );
}
