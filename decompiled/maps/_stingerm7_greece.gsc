// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    precacheshellshock( "iw5_stingerm7greece_sp" );
    precacheshader( "bls_ui_turret_targetacquired" );
    precacheshader( "bls_ui_turret_targetlock_white" );

    foreach ( var_1 in level.players )
    {
        var_1 thread stingerm7_targeting();
        var_1 thread stingerm7_monitor_fire();
    }
}

remove_bad_locked_targets()
{
    var_0 = [];

    foreach ( var_2 in level.player.stingerm7_info.locked_targets )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( var_2 != level.player.stingerm7_info.level_stinger_lock_target && !isalive( var_2 ) )
            continue;

        var_0[var_0.size] = var_2;
    }

    return var_0;
}

stingerm7_targeting()
{
    self endon( "death" );
    self.stingerm7_info = spawnstruct();
    self.stingerm7_info.locked_targets = [];
    self.stingerm7_info.locking_time = 0;
    waitframe();
    self.stingerm7_info.level_stinger_lock_target = getent( "stinger_lock_target", "targetname" );
    self.stingerm7_info.level_stinger_missile_targets = getentarray( "stinger_missile_target", "targetname" );

    for (;;)
    {
        if ( self getcurrentweapon() == "iw5_stingerm7greece_sp" && self playerads() > 0.99 )
        {
            self.stingerm7_info.locked_targets = remove_bad_locked_targets();

            if ( isdefined( self.stingerm7_info.locking_target ) )
            {
                if ( !target_still_valid( self.stingerm7_info.locking_target ) )
                {
                    target_remove( self.stingerm7_info.locking_target );
                    self.stingerm7_info.locking_target = undefined;
                }
            }

            if ( isdefined( self.stingerm7_info.locking_target ) )
                self.stingerm7_info.locking_time += 0.05;
            else
            {
                self.stingerm7_info.locking_time = 0;

                if ( self.stingerm7_info.locked_targets.size < 4 )
                {
                    self.stingerm7_info.locking_target = get_best_locking_target();

                    if ( isdefined( self.stingerm7_info.locking_target ) )
                    {
                        var_0 = self.stingerm7_info.locking_target.origin;
                        target_set( self.stingerm7_info.locking_target, var_0 );
                        target_setshader( self.stingerm7_info.locking_target, "bls_ui_turret_targetacquired" );
                    }
                }
            }

            if ( self.stingerm7_info.locking_time >= 0.5 && isdefined( self.stingerm7_info.locking_target ) && self.stingerm7_info.locked_targets.size < 4 )
            {
                self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = self.stingerm7_info.locking_target;
                self.stingerm7_info.locking_target thread locked_target_think( self );
                self.stingerm7_info.locking_target = undefined;
            }

            if ( self.stingerm7_info.locked_targets.size > 0 )
                self weaponlockfinalize( self.stingerm7_info.locked_targets[0] );
            else
                self weaponlockfree();
        }
        else
        {
            foreach ( var_2 in self.stingerm7_info.locked_targets )
                target_remove( var_2 );

            self.stingerm7_info.locked_targets = [];

            if ( isdefined( self.stingerm7_info.locking_target ) )
            {
                target_remove( self.stingerm7_info.locking_target );
                self.stingerm7_info.locking_target = undefined;
            }

            self.stingerm7_info.locking_time = 0;
            self weaponlockfree();
        }

        waitframe();
    }
}

stingerm7_monitor_fire()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( var_1 == "iw5_stingerm7greece_sp" )
            stinger_fire( self, var_0 );
    }
}

stinger_fire( var_0, var_1 )
{
    var_2 = var_1.origin;
    var_3 = var_1.angles;
    var_1 delete();
    var_4 = remove_bad_locked_targets();

    if ( var_4.size > 0 )
    {
        var_4 = common_scripts\utility::array_combine( var_4, var_0.stingerm7_info.level_stinger_missile_targets );
        firemangarockets( var_4[0] );
        soundscripts\_snd::snd_message( "stingerm7_shoot_tower" );
        var_0 setweaponammoclip( "iw5_stingerm7greece_sp", 0 );
    }
    else
        var_0 setweaponammoclip( "iw5_stingerm7greece_sp", 4 );

    swaptolastweapon();
}

firemangarockets( var_0 )
{
    var_1 = 10;
    var_2 = 1;
    var_3 = 500;
    var_4 = 450;

    for ( var_5 = 0; var_5 < 7; var_5++ )
    {
        var_6 = common_scripts\utility::mod( var_5 * 360 / var_1 + randomint( 30 ), 360 );
        var_7 = randomfloatrange( 2.5, 3.5 );
        var_8 = randomfloatrange( 3.6, 6.0 );
        var_9 = randomfloatrange( 49, 50 );
        var_10 = 0;

        if ( var_5 == 0 )
        {
            var_7 = 3;
            var_10 = 1;
        }

        thread mangarocketparentupdate( var_0, var_2, var_3, var_4, var_10, var_7, var_6, var_8, var_9 );
    }
}

mangarocketparentupdate( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = var_0.origin - level.player geteye();
    var_10 = vectornormalize( var_9 );
    var_11 = vectorcross( var_10, ( 0, 0, 1 ) );

    if ( var_1 )
        var_11 *= -1;

    var_12 = level.player geteye();
    var_13 = level.player geteye() + var_9 * 0.5 + var_11 * var_2 + ( 0, 0, var_3 );
    var_14 = var_0.origin;
    var_15 = level.player common_scripts\utility::spawn_tag_origin();
    var_15.parentorigin = level.player geteye();
    playfxontag( common_scripts\utility::getfx( "manga_rocket_trail" ), var_15, "tag_origin" );
    soundscripts\_snd::snd_message( "manga_rocket_trail", var_15 );
    thread mangarocketupdate( var_0, var_15, var_6, var_7, var_8 );
    var_16 = 0;
    var_17 = 1 / var_5 * 20;
    var_18 = 0;

    while ( var_18 <= 1 )
    {
        wait 0.05;
        var_19 = squared( 1 - var_16 ) * var_12 + 2 * var_16 * ( 1 - var_16 ) * var_13 + squared( var_16 ) * var_14;
        var_15.parentorigin = var_19;
        var_18 += var_17;

        if ( var_4 )
        {
            var_16 = pow( var_18, 3 );
            continue;
        }

        var_16 = squared( var_18 );
    }

    stopfxontag( common_scripts\utility::getfx( "manga_rocket_trail" ), var_15, "tag_origin" );
    playfx( common_scripts\utility::getfx( "manga_rocket_explosion" ), var_15.origin, ( 1, 0, 0 ), ( 0, 0, 1 ) );
    soundscripts\_snd::snd_message( "manga_rocket_explosion", var_15 );
    var_15 notify( "MangaRocketUpdate" );
    var_15 delete();
    wait 0.3;
    maps\greece_sniper_scramble::sniperdeathinternal();
}

mangarocketupdate( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 endon( "MangaRocketUpdate" );
    var_5 = vectornormalize( var_0.origin - level.player geteye() );
    var_6 = vectortoangles( var_5 );
    var_7 = var_2;
    var_8 = ( 0, 0, 0 );

    if ( common_scripts\utility::cointoss() )
        var_3 *= -1;

    var_9 = var_4 / 5;
    var_10 = 0;

    for (;;)
    {
        wait 0.05;
        var_7 += var_3;
        var_8 = ( 1, 0, 0 ) * var_10;
        var_11 = transformmove( var_1.parentorigin, combineangles( var_6, ( 90, 0, 0 ) ), ( 0, 0, 0 ), ( 0, var_7, 0 ), var_8, ( 0, 0, 0 ) );
        var_8 = var_11["origin"];
        var_1.origin = vectorlerp( var_1.origin, var_8, 0.5 );
        var_10 += var_9;
        var_10 = clamp( var_10, 0, var_4 );
    }
}

swaptolastweapon()
{
    var_0 = level.player common_scripts\utility::getlastweapon();
    level.player disableweapons();
    wait 5;
    level.player takeweapon( "iw5_stingerm7greece_sp" );
    level.player giveweapon( var_0 );
    level.player switchtoweapon( var_0 );
    level.player givemaxammo( var_0 );
    level.player enableweapons();
    level.player allowprone( 1 );
}

_randommissilemovement( var_0 )
{
    self endon( "death" );
    self endon( "within_closing_distance" );
    var_1 = 0;
    var_2 = 0.25;

    for (;;)
    {
        var_3 = distance( self.origin, var_0.origin );
        var_4 = maps\_utility::linear_interpolate( clamp( var_3 / 2000, 0, 1 ), 0, 1 );
        var_5 = randomintrange( -2500, 2500 ) * var_4;
        var_6 = randomintrange( -500, 500 ) * var_4;
        var_7 = randomintrange( -500, 500 ) * var_4;
        self missile_settargetent( var_0, ( var_5, 0, var_7 ) );
        wait(var_2);
    }
}

_closingdistancecheck( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_1 = distance( self.origin, var_0.origin );

        if ( var_1 < 500 )
        {
            self notify( "within_closing_distance" );
            self missile_settargetent( var_0 );
            break;
        }

        waitframe();
    }
}

_missilemissedtargetcheck( var_0, var_1 )
{
    self endon( "death" );
    var_2 = var_0 - var_1.origin;
    var_2 = vectornormalize( var_2 );

    for (;;)
    {
        waitframe();
        var_3 = self.origin - var_1.origin;
        var_4 = vectordot( var_3, var_2 );

        if ( var_4 < -10 )
            self delete();
    }
}

locked_target_think( var_0 )
{
    self endon( "death" );
    target_setshader( self, "bls_ui_turret_targetlock_white" );
}

get_best_locking_target()
{
    var_0 = [];

    if ( isdefined( self.stingerm7_info.level_stinger_lock_target ) )
        var_0[var_0.size] = self.stingerm7_info.level_stinger_lock_target;

    var_1 = self geteye();
    var_2 = anglestoforward( self getgunangles() );
    var_3 = undefined;
    var_4 = cos( 6 );

    foreach ( var_6 in var_0 )
    {
        if ( !common_scripts\utility::array_contains( self.stingerm7_info.locked_targets, var_6 ) && is_enemy_target( var_6, self ) )
        {
            var_7 = stingerm7_get_target_pos( var_6 );
            var_8 = vectordot( vectornormalize( var_7 - var_1 ), var_2 );

            if ( var_8 > var_4 )
            {
                if ( !1 || bullettracepassed( var_1, var_7, 0, undefined ) )
                {
                    var_3 = var_6;
                    var_4 = var_8;
                }
            }
        }
    }

    return var_3;
}

target_still_valid( var_0 )
{
    var_1 = self geteye();
    var_2 = anglestoforward( self getgunangles() );
    var_3 = stingerm7_get_target_pos( var_0 );

    if ( vectordot( vectornormalize( var_3 - var_1 ), var_2 ) > cos( 6 ) )
    {
        if ( !1 || bullettracepassed( var_1, var_3, 0, undefined ) )
            return 1;
    }

    return 0;
}

is_enemy_target( var_0, var_1 )
{
    var_2 = undefined;

    if ( isai( var_0 ) )
        var_2 = var_0.team;
    else if ( isdefined( var_0.script_team ) )
        var_2 = var_0.script_team;
    else if ( var_0 == var_1.stingerm7_info.level_stinger_lock_target )
        return 1;

    return isenemyteam( var_2, var_1.team );
}

stingerm7_get_target_pos( var_0 )
{
    if ( isai( var_0 ) )
        return var_0 geteye();

    return var_0 getpointinbounds( 0, 0, 0 );
}

stingerm7_get_target_offset( var_0 )
{
    return stingerm7_get_target_pos( var_0 ) - var_0.origin;
}
