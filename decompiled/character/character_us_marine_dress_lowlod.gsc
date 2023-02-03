// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "marine_dress_body_a_lowlod" );
    self attach( "marine_dress_head_a_lowlod", "", 1 );
    self.headmodel = "marine_dress_head_a_lowlod";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "marine_dress_body_a_lowlod" );
    precachemodel( "marine_dress_head_a_lowlod" );
}
