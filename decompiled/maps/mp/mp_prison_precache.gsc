// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\utility::add_destructible_type_function( "toy_locker_double", destructible_scripts\toy_locker_double::main );
    destructible_scripts\toy_locker_double::main();
}
