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
        self _meth_83B2( 1 );
        thread apply_jump_fx();
        self.high_jump_enabled = 1;
        soundscripts\_snd::snd_message( "boost_jump_enable" );
        self.bg_falldamageminheight_old = getdvarint( "bg_fallDamageMinHeight", 200 );
        self.bg_falldamagemaxheight_old = getdvarint( "bg_fallDamageMaxHeight", 350 );
        _func_0D3( "bg_fallDamageMinHeight", getdvarint( "bg_highJumpFallDamageMinHeight", 490 ) );
        _func_0D3( "bg_fallDamageMaxHeight", getdvarint( "bg_highJumpFallDamageMaxHeight", 640 ) );
    }
}

disable_high_jump()
{
    if ( isdefined( self.high_jump_enabled ) && self.high_jump_enabled )
    {
        self _meth_83B2( 0 );
        self notify( "disable_high_jump" );
        self.high_jump_enabled = 0;
        soundscripts\_snd::snd_message( "boost_jump_disable" );
        _func_0D3( "bg_fallDamageMinHeight", self.bg_falldamageminheight_old );
        _func_0D3( "bg_fallDamageMaxHeight", self.bg_falldamagemaxheight_old );
    }
}

enable_boost_jump()
{
    enable_high_jump();
    self _meth_849E( 1 );
    self.boost_jump_enabled = 1;
}

disable_boost_jump()
{
    disable_high_jump();
    self _meth_849E( 0 );
    self.boost_jump_enabled = 0;
}

apply_jump_fx()
{
    self endon( "death" );
    self endon( "disable_high_jump" );
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = self _meth_83B4();
    var_4 = 0.2;
    var_5 = 0;
    var_6 = 1;
    var_7 = 0;

    for (;;)
    {
        var_8 = self _meth_83B4();

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
                var_6 = var_6 && self _meth_83DE();

                if ( var_6 && !var_7 )
                {
                    playfx( common_scripts\utility::getfx( "boost_dust" ), self.origin, anglestoforward( self.angles + ( -90, 0, 0 ) ), anglestoup( self.angles ) );
                    soundscripts\_snd::snd_message( "boost_jump_player" );
                    maps\_sp_matchdata::register_boost_jump();
                    earthquake( 0.15, 0.3, self.origin, 300 );
                    level.player _meth_80AD( "damage_light" );
                    thread newhandlespawngroundimpact();
                    var_7 = 1;
                    var_5 += 0.05;
                }
            }
        }

        if ( !self _meth_8341() )
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
                        level.player _meth_80AD( "damage_heavy" );
                    else
                        level.player _meth_80AD( "damage_light" );

                    self notify( "player_boost_land" );
                    var_7 = 0;
                }
                else if ( var_9 > 200 )
                {
                    soundscripts\_snd::snd_message( "boost_land_player", var_0 );
                    var_10 = var_9 / 500;
                    var_10 = clamp( var_10, 0.2, 0.4 );
                    earthquake( var_10, 0.6, self.origin, 300 );
                    level.player _meth_80AD( "damage_heavy" );
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
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
        wait 0.5;
        _func_0D3( "r_mbenable", var_0 );
        _func_0D3( "r_mbVelocityScalar", var_1 );
    }
}

mb_off()
{
    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );
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
