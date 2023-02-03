// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_funeral_female_irons_body" );
    self attach( "head_f_act_cau_atias_funeral", "", 1 );
    self.headmodel = "head_f_act_cau_atias_funeral";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_funeral_female_irons_body" );
    precachemodel( "head_f_act_cau_atias_funeral" );
}
