// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "marine_dress_body_a_lowlod" );
    self attach( "marine_dress_head_a_lowlod", "", 1 );
    self.headmodel = "marine_dress_head_a_lowlod";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "marine_dress_body_a_lowlod" );
    precachemodel( "marine_dress_head_a_lowlod" );
}
