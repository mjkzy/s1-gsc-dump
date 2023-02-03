// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    set_level_lighting_values();
}

set_level_lighting_values()
{
    if ( isusinghdr() )
        setdvar( "r_disablelightsets", 0 );
}
