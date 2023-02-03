// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_african_male_body_d" );
    self attach( "head_male_mp_sykes", "", 1 );
    self.headmodel = "head_male_mp_sykes";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_african_male_body_d" );
    precachemodel( "head_male_mp_sykes" );
}
