// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_female_body_a_mde" );
    self attach( "head_f_gen_mde_halabi", "", 1 );
    self.headmodel = "head_f_gen_mde_halabi";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_body_a_mde" );
    precachemodel( "head_f_gen_mde_halabi" );
}
