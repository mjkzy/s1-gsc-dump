// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("dog");

main()
{
    self endon( "killanimscript" );
    thread animscripts\dog\dog_move::handlefootstepnotetracks();
    self _meth_8142( %dog_move, 0.2 );
    self _meth_8110( "dog_stop", self.dogarrivalanim, %body, 1, 0.2, self.moveplaybackrate );
    animscripts\shared::donotetracks( "dog_stop" );
    self.dogarrivalanim = undefined;
}
