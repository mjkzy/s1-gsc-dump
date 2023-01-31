// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "marines_body_smg_lowlod" );
    self attach( "marines_head_b_lowlod", "", 1 );
    self.headmodel = "marines_head_b_lowlod";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_smg_lowlod" );
    precachemodel( "marines_head_b_lowlod" );
}
