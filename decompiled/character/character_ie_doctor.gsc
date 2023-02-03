// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_male_body_g" );
    self attach( "dr_pas_head", "", 1 );
    self.headmodel = "dr_pas_head";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_g" );
    precachemodel( "dr_pas_head" );
}
