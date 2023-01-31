// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    self.desired_anim_pose = "stand";
    animscripts\utility::updateanimpose();
    self endon( "killanimscript" );
    self _meth_818D( "nogravity" );
    self _meth_818D( "noclip" );
    var_0 = self _meth_819D();
    self _meth_818F( "face angle", var_0.angles[1] );
    self _meth_8110( "jumpanim", %gulag_pipe_traverse, %body, 1, 0.1, 1 );
    self waittillmatch( "jumpanim", "finish" );
    self _meth_818D( "gravity" );
    animscripts\shared::donotetracks( "jumpanim" );
}
