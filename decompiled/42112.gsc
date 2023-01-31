// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_hero_cormack_marine_damage" );
    self attach( "head_hero_cormack_marines_damage", "", 1 );
    self.headmodel = "head_hero_cormack_marines_damage";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_cormack_marine_damage" );
    precachemodel( "head_hero_cormack_marines_damage" );
}
