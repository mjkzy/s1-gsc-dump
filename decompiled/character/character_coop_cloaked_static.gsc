// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_coop_cloaked_static" );
    codescripts\character::attachhead( "alias_coop_cloaked_static_heads", xmodelalias\alias_coop_cloaked_static_heads::main() );
    self.voice = "russian";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_coop_cloaked_static" );
    codescripts\character::precachemodelarray( xmodelalias\alias_coop_cloaked_static_heads::main() );
}
