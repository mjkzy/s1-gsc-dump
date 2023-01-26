// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "mp_body_opforce_ghillie_urban_sniper" );
    self attach( "head_opforce_russian_urban_sniper", "", 1 );
    self.headmodel = "head_opforce_russian_urban_sniper";
    self setviewmodel( "viewhands_iw5_ghillie_urban" );
    self.voice = "russian";
    self setclothtype( "vestlight" );
}

_id_0331()
{
    precachemodel( "mp_body_opforce_ghillie_urban_sniper" );
    precachemodel( "head_opforce_russian_urban_sniper" );
    precachemodel( "viewhands_iw5_ghillie_urban" );
}
