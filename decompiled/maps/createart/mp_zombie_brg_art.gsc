// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.tweakfile = 1;

    if ( _func_235() )
        maps\createart\mp_zombie_brg_fog_hdr::setupfog();
    else
        maps\createart\mp_zombie_brg_fog::setupfog();

    visionsetnaked( "mp_zombie_brg", 0 );
}
