// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "mp_sentinel_body_nojet_b" );
    codescripts\character::_id_0DFD( "alias_mp_sentinel_heads", _id_A685::main() );
    self setviewmodel( "viewhands_s1_pmc" );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

_id_0331()
{
    precachemodel( "mp_sentinel_body_nojet_b" );
    codescripts\character::_id_6EDE( _id_A685::main() );
    precachemodel( "viewhands_s1_pmc" );
}
