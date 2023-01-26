// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

boost_jump_wrapper()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    maps\mp\_utility::gameflagwait( "prematch_done" );
    thread play_boost_sound();
}

play_boost_sound()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    var_0 = self isjumping();

    for (;;)
    {
        var_1 = self isjumping();

        if ( var_1 )
        {
            if ( var_1 != var_0 )
            {
                self playrumbleonentity( "damage_heavy" );
                maps\mp\_utility::playsoundinspace( "boost_jump_plr_mp", self.origin );
            }
        }

        var_0 = var_1;
        wait 0.05;
    }
}

playerboostjumpprecaching()
{

}
