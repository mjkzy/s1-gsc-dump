// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_female_body_f" );
    self attach( "head_f_act_cau_biedermann", "", 1 );
    self.headmodel = "head_f_act_cau_biedermann";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_body_f" );
    precachemodel( "head_f_act_cau_biedermann" );
}
