// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "kva_leader_body" );
    self attach( "kva_leader_head", "", 1 );
    self.headmodel = "kva_leader_head";
    self.voice = "kva";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "kva_leader_body" );
    precachemodel( "kva_leader_head" );
}
