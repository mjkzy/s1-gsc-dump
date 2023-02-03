// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    var_0 = [];

    if ( animscripts\traverse\shared::getnextfootdown() == "Right" )
        var_0["traverseAnim"] = %lag_unstable_jump_a_short_l;
    else
        var_0["traverseAnim"] = %lag_unstable_jump_a_short_r;

    var_0["traverseNotetrackFunc"] = animscripts\traverse\shared::handletraversenotetracks;
    animscripts\traverse\shared::dotraverse( var_0 );
    self setflaggedanimknoballrestart( "traverse_align", %lag_unstable_jumparrive_8, %body, 1, 0.2, 1 );
    animscripts\shared::donotetracks( "traverse_align", animscripts\traverse\shared::handletraversenotetracks );
}
