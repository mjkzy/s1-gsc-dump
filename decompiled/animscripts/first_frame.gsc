// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self endon( "death" );
    self endon( "stop_first_frame" );
    self notify( "killanimscript" );
    self.pushable = 0;
    self _meth_8142( self.root_anim, 0.3 );
    self _meth_818F( "face angle", self.angles[1] );
    self _meth_814B( level.scr_anim[self._animname][self._first_frame_anim], 1, 0, 0 );
    self._first_frame_anim = undefined;
    self waittill( "killanimscript" );
}
