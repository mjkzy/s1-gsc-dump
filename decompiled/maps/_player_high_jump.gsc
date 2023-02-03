// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level._effect["boost_dust"] = loadfx( "vfx/smoke/jetpack_exhaust" );
    level._effect["boost_dust_impact_ground"] = loadfx( "vfx/smoke/jetpack_ground_impact_runner" );
    precacherumble( "damage_light" );
    precacherumble( "damage_heavy" );
}

enable_high_jump()
{
    if ( !isdefined( self.high_jump_enabled ) || self.high_jump_enabled == 0 )
    {
        self allowhighjump( 1 );
        thread apply_jump_fx();
        self.high_jump_enabled = 1;
        soundscripts\_snd::snd_message( "boost_jump_enable" );
        self.bg_falldamageminheight_old = getdvarint( "bg_fallDamageMinHeight", 200 );
        self.bg_falldamagemaxheight_old = getdvarint( "bg_fallDamageMaxHeight", 350 );
        setsaveddvar( "bg_fallDamageMinHeight", getdvarint( "bg_highJumpFallDamageMinHeight", 490 ) );
        setsaveddvar( "bg_fallDamageMaxHeight", getdvarint( "bg_highJumpFallDamageMaxHeight", 640 ) );
    }
}

disable_high_jump()
{
    if ( isdefined( self.high_jump_enabled ) && self.high_jump_enabled )
    {
        self allowhighjump( 0 );
        self notify( "disable_high_jump" );
        self.high_jump_enabled = 0;
        soundscripts\_snd::snd_message( "boost_jump_disable" );
        setsaveddvar( "bg_fallDamageMinHeight", self.bg_falldamageminheight_old );
        setsaveddvar( "bg_fallDamageMaxHeight", self.bg_falldamagemaxheight_old );
    }
}

enable_boost_jump()
{
    enable_high_jump();
    self allowboostjump( 1 );
    self.boost_jump_enabled = 1;
}

disable_boost_jump()
{
    disable_high_jump();
    self allowboostjump( 0 );
    self.boost_jump_enabled = 0;
}

apply_jump_fx()
{
    self endon( "death" );
    self endon( "disable_high_jump" );
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = self ishighjumping();
    var_4 = 0.2;
    var_5 = 0;
    var_6 = 1;
    var_7 = 0;

    for (;;)
    {
        var_8 = self ishighjumping();

        if ( isdefined( self.grapple ) && self.grapple["connected"] )
            var_8 = 0;

        if ( var_8 )
        {
            if ( var_8 != var_3 )
            {
                if ( level.nextgen )
                    thread mb_on();

                var_2 = 1;
                var_5 = 0;
                var_6 = 1;

                if ( !isdefined( self.high_jump_enabled ) || !self.high_jump_enabled )
                {

                }
            }

            if ( isdefined( self.high_jump_enabled ) && self.high_jump_enabled )
            {
                var_6 = var_6 && self jumpbuttonpressed();

                if ( var_6 && !var_7 )
                {
                    playfx( common_scripts\utility::getfx( "boost_dust" ), self.origin, anglestoforward( self.angles + ( -90, 0, 0 ) ), anglestoup( self.angles ) );
                    soundscripts\_snd::snd_message( "boost_jump_player" );
                    maps\_sp_matchdata::register_boost_jump();
                    earthquake( 0.15, 0.3, self.origin, 300 );
                    level.player playrumbleonentity( "damage_light" );
                    thread newhandlespawngroundimpact();
                    var_7 = 1;
                    var_5 += 0.05;
                }
            }
        }

        if ( !self isonground() )
        {
            if ( var_0 == 0 )
                var_1 = self.origin[2];

            var_0++;
        }
        else
        {
            if ( var_0 > 5 && ( isdefined( self.high_jump_enabled ) || self.high_jump_enabled ) )
            {
                var_9 = var_1 - self.origin[2];

                if ( var_7 == 1 )
                {
                    soundscripts\_snd::snd_message( "boost_land_player", var_0 );
                    var_10 = var_9 / 500;
                    var_10 = clamp( var_10, 0.2, 0.4 );
                    earthquake( var_10, 0.6, self.origin, 300 );

                    if ( var_10 > 0.2 )
                        level.player playrumbleonentity( "damage_heavy" );
                    else
                        level.player playrumbleonentity( "damage_light" );

                    self notify( "player_boost_land" );
                    var_7 = 0;
                }
                else if ( var_9 > 200 )
                {
                    soundscripts\_snd::snd_message( "boost_land_player", var_0 );
                    var_10 = var_9 / 500;
                    var_10 = clamp( var_10, 0.2, 0.4 );
                    earthquake( var_10, 0.6, self.origin, 300 );
                    level.player playrumbleonentity( "damage_heavy" );
                }
            }

            var_0 = 0;
        }

        var_3 = var_8;
        var_2 = 0;
        waitframe();
    }
}

mb_on()
{
    if ( level.nextgen )
    {
        var_0 = getdvar( "r_mbenable" );
        var_1 = getdvar( "r_mbVelocityScalar" );
        setsaveddvar( "r_mbEnable", "2" );
        setsaveddvar( "r_mbVelocityScalar", "1" );
        wait 0.5;
        setsaveddvar( "r_mbenable", var_0 );
        setsaveddvar( "r_mbVelocityScalar", var_1 );
    }
}

mb_off()
{
    if ( level.nextgen )
        setsaveddvar( "r_mbEnable", "0" );
}

newhandlespawngroundimpact()
{
    var_0 = self.origin + ( 0, 0, 64 );
    var_1 = self.origin - ( 0, 0, 150 );
    var_2 = bullettrace( var_0, var_1, 0, undefined );
    var_3 = common_scripts\utility::getfx( "boost_dust_impact_ground" );
    var_0 = var_2["position"];
    var_4 = vectortoangles( var_2["normal"] );
    var_4 += ( 90, 0, 0 );
    var_5 = anglestoforward( var_4 );
    var_6 = anglestoup( var_4 );
    playfx( var_3, var_0, var_6, var_5 );
}
