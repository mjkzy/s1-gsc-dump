// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );
}

set_level_lighting_values()
{
    if ( isusinghdr() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1" );
        }
    }
}
