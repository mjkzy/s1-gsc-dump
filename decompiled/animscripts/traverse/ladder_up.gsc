// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    if ( isdefined( self.type ) && self.type == "dog" )
        return;

    animscripts\traverse\shared::dovariablelengthtraverse( undefined, %ladder_climbup, %ladder_climboff, "noclip", "crouch", "run" );
}
