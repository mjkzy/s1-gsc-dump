// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_body_noexo" );
    self attach( "npc_exo_armor_atlas_head_captured", "", 1 );
    self.headmodel = "npc_exo_armor_atlas_head_captured";
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_body_noexo" );
    precachemodel( "npc_exo_armor_atlas_head_captured" );
}
