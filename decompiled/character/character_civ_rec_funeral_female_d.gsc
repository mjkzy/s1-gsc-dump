// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_funeral_female_body_a" );
    self attach( "head_f_gen_asi_kwok_base", "", 1 );
    self.headmodel = "head_f_gen_asi_kwok_base";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_funeral_female_body_a" );
    precachemodel( "head_f_gen_asi_kwok_base" );
}
