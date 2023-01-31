// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_scientist" );
    self attach( "head_m_gen_afr_rice_hardhat", "", 1 );
    self.headmodel = "head_m_gen_afr_rice_hardhat";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_scientist" );
    precachemodel( "head_m_gen_afr_rice_hardhat" );
}
