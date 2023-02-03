// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.tweakfile = 1;

    if ( isusinghdr() )
        maps\createart\mp_dam_fog_hdr::setupfog();
    else
        maps\createart\mp_dam_fog::setupfog();

    visionsetnaked( "mp_dam", 0 );
}
