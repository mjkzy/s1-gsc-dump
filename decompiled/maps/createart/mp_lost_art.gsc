// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.tweakfile = 1;

    if ( isusinghdr() )
        maps\createart\mp_lost_fog_hdr::setupfog();
    else
        maps\createart\mp_lost_fog::setupfog();

    visionsetnaked( "mp_lost", 0 );
}
