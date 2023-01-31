// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.tweakfile = 1;

    if ( _func_235() )
        maps\createart\mp_laser2_fog_hdr::setupfog();
    else
        maps\createart\mp_laser2_fog::setupfog();

    visionsetnaked( "mp_laser2", 0 );
}
