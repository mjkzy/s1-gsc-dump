// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "irons_casual" );
    self attach( "head_hero_irons_holo_blend", "", 1 );
    self.headmodel = "head_hero_irons_holo_blend";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "irons_casual" );
    precachemodel( "head_hero_irons_holo_blend" );
}
