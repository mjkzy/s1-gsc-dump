// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.tweakfile = 1;

    if ( _func_235() )
        maps\createart\mp_vlobby_room_fog_hdr::setupfog();
    else
        maps\createart\mp_vlobby_room_fog::setupfog();

    visionsetnaked( "mp_vlobby_room", 0 );
}
