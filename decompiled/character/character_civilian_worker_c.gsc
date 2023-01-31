// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_work_civ_male_c" );
    codescripts\character::attachhead( "alias_civilian_worker_heads", xmodelalias\alias_civilian_worker_heads::main() );
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_work_civ_male_c" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civilian_worker_heads::main() );
}
