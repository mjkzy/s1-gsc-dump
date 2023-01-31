// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    animscripts\setposemovement::pronerun_begin();
    animscripts\utility::updateanimpose();
    self endon( "killanimscript" );
    self _meth_818D( "noclip" );
    var_0 = self _meth_819D();
    self _meth_818F( "face angle", var_0.angles[1] );
    self _meth_8110( "crawlanim", %prone_crawl, %body, 1, 0.1, 1 );
    animscripts\shared::donotetracks( "crawlanim" );
    self.a.movement = "run";
    self.a.pose = "crouch";
}
