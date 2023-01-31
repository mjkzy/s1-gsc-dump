// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_worker" );
    codescripts\character::attachhead( "alias_civ_worker_hardhat_s1_heads", xmodelalias\alias_civ_worker_hardhat_s1_heads::main() );
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_worker" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_worker_hardhat_s1_heads::main() );
}
