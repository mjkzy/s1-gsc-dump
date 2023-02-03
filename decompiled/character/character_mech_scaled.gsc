// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "npc_exo_armor_base_scaled" );
    self attach( "npc_exo_armor_atlas_head", "", 1 );
    self.headmodel = "npc_exo_armor_atlas_head";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "npc_exo_armor_base_scaled" );
    precachemodel( "npc_exo_armor_atlas_head" );
}
