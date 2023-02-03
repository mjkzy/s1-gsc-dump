// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "marines_body_smg_lowlod" );
    self attach( "marines_head_b_lowlod", "", 1 );
    self.headmodel = "marines_head_b_lowlod";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_smg_lowlod" );
    precachemodel( "marines_head_b_lowlod" );
}
