// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_coop_cloaked_static" );
    codescripts\character::attachhead( "alias_coop_cloaked_static_heads", xmodelalias\alias_coop_cloaked_static_heads::main() );
    self.voice = "russian";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_coop_cloaked_static" );
    codescripts\character::precachemodelarray( xmodelalias\alias_coop_cloaked_static_heads::main() );
}
