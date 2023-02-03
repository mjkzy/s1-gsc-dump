// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_scientist" );
    self attach( "head_m_gen_afr_rice_hardhat", "", 1 );
    self.headmodel = "head_m_gen_afr_rice_hardhat";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_scientist" );
    precachemodel( "head_m_gen_afr_rice_hardhat" );
}
