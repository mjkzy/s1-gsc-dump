// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level._effect["test_effect"] = loadfx( "vfx/test/test_fx" );

    if ( !getdvarint( "r_reflectionProbeGenerate" ) )
        maps\createfx\credits_s1_fx::main();
}
