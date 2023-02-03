// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_us_marine_dress_bodies::main() );
    self attach( "head_m_gen_mde_azzam_marines_dress", "", 1 );
    self.headmodel = "head_m_gen_mde_azzam_marines_dress";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_us_marine_dress_bodies::main() );
    precachemodel( "head_m_gen_mde_azzam_marines_dress" );
}
