// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_male_body_b" );
    self attach( "civ_urban_male_head_kanik", "", 1 );
    self.headmodel = "civ_urban_male_head_kanik";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_b" );
    precachemodel( "civ_urban_male_head_kanik" );
}
