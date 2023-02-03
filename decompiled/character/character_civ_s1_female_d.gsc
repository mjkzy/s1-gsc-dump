// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_female_body_b_blue" );
    self attach( "head_f_gen_cau_peterson", "", 1 );
    self.headmodel = "head_f_gen_cau_peterson";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_body_b_blue" );
    precachemodel( "head_f_gen_cau_peterson" );
}
