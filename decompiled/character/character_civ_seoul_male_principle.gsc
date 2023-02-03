// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_seoul_male_body_f" );
    self attach( "civ_seoul_male_head_c", "", 1 );
    self.headmodel = "civ_seoul_male_head_c";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_seoul_male_body_f" );
    precachemodel( "civ_seoul_male_head_c" );
}
