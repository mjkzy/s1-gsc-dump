// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "mp_body_ally_ghillie_urban_sniper" );
    self attach( "head_ally_delta_sniper", "", 1 );
    self.headmodel = "head_ally_delta_sniper";
    self setviewmodel( "viewhands_iw5_ghillie_urban" );
    self.voice = "delta";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "mp_body_ally_ghillie_urban_sniper" );
    precachemodel( "head_ally_delta_sniper" );
    precachemodel( "viewhands_iw5_ghillie_urban" );
}
