// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "npc_exo_armor_long_lod_baghdad" );
    self attach( "npc_exo_armor_atlas_head", "", 1 );
    self.headmodel = "npc_exo_armor_atlas_head";
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "npc_exo_armor_long_lod_baghdad" );
    precachemodel( "npc_exo_armor_atlas_head" );
}
