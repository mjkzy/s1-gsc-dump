// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.tweakfile = 1;
    level.player = getentarray( "player", "classname" )[0];

    if ( _func_235() )
        maps\createart\crash_fog_hdr::main();
    else
        maps\createart\crash_fog::main();
}
