// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "irons_suit" );
    self attach( "head_hero_irons_blend", "", 1 );
    self.headmodel = "head_hero_irons_blend";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "irons_suit" );
    precachemodel( "head_hero_irons_blend" );
}
