// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_body_noexo" );
    self attach( "npc_exo_armor_atlas_head_captured", "", 1 );
    self.headmodel = "npc_exo_armor_atlas_head_captured";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_body_noexo" );
    precachemodel( "npc_exo_armor_atlas_head_captured" );
}
