// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_49C2()
{
    level._id_49C3 = getentarray( "horde_sentry", "targetname" );
    level._id_49C1 = [];

    if ( maps\mp\_utility::getmapname() == "mp_recovery" )
    {
        foreach ( var_1 in level._id_49C3 )
        {
            if ( distancesquared( var_1.origin, ( -2099.0, 719.9, 120.0 ) ) < 4096 )
                level._id_49C3 = common_scripts\utility::array_remove( level._id_49C3, var_1 );
        }
    }
}

_id_49CA( var_0, var_1 )
{
    var_2 = spawnturret( "misc_turret", var_1.origin, var_0 );
    var_2.angles = var_1.angles;
    var_2.owner = undefined;
    var_2.health = 500;
    var_2.maxhealth = 500;
    var_2._id_99BD = "mg_turret";
    var_2.stunned = 0;
    var_2._id_2A6A = 0;
    var_2._id_8F70 = 5.0;
    var_2.issentry = 1;
    var_2._id_051C = var_0;
    var_2._id_32CD = 0;
    var_2._id_7593 = 0;
    var_2._id_4448 = 0;
    var_2._id_511C = 1;
    var_2.isalive = 1;
    var_2 setmodel( "npc_sentry_energy_turret_base" );
    var_2 _meth_8065( "sentry" );
    var_2 _meth_8135( "axis" );
    var_2 _meth_8103( undefined );
    var_2 _meth_8105( 1, var_0 );
    var_2 _meth_8156( 360 );
    var_2 _meth_8155( 360 );
    var_2 _meth_8158( 90 );
    var_2 _meth_815A( -89.0 );
    var_2 setcandamage( 1 );
    var_2._id_259B = 1.0;
    var_2 thread _id_49D4();
    var_2 thread _id_49D5();
    var_2 thread _id_49D1();
    var_2 thread maps\mp\killstreaks\_remoteturret::_id_9999();
    level._id_49C1[level._id_49C1.size] = var_2;
    playfx( level._effect["spawn_effect"], var_2.origin );
    return var_2;
}

_id_49D5()
{
    self endon( "death" );
    self endon( "deleting" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 0.05;

        if ( isdefined( self._id_91D0 ) && ( isplayer( self._id_91D0 ) && self._id_91D0.ignoreme ) )
            continue;

        if ( isdefined( self._id_91D0 ) )
        {
            if ( isdefined( self _meth_8109( 1 ) ) )
            {
                var_0 = randomintrange( 25, 50 );

                for ( var_1 = 0; var_1 < var_0; var_1++ )
                {
                    self _meth_80EA();
                    wait 0.1;
                }

                wait(randomintrange( 3, 5 ));
                continue;
            }

            wait(randomintrange( 1, 3 ));
        }
    }
}

_id_49D4()
{
    self endon( "death" );
    self endon( "deleting" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = _id_A798::hordegetclosehealthyenemyforturret( self );

        if ( !self.stunned && !isdefined( self._id_A042 ) && isdefined( var_0 ) )
        {
            if ( isdefined( var_0.isaerialassaultdrone ) && var_0.isaerialassaultdrone )
                self _meth_8106( var_0, ( 0.0, 0.0, -20.0 ) );
            else
                self _meth_8106( var_0 );

            self._id_91D0 = var_0;
        }
        else
        {
            self _meth_8108();
            self._id_91D0 = undefined;
        }

        wait 0.1;
    }
}

_id_49D1()
{
    self endon( "death" );
    self _meth_815A( 0.0 );
    self makeunusable();
    self _meth_8136();
    self.team = "axis";
    self _meth_8135( "axis" );
    thread _id_49D0();
    thread _id_49D3();
}

_id_49D0()
{
    var_0 = self getentitynumber();
    self waittill( "death", var_1, var_2, var_3 );
    self.isalive = 0;

    if ( isdefined( var_1 ) )
    {
        if ( isplayer( var_1 ) )
        {
            _id_A798::_id_120A( var_1 );
            var_1 thread maps\mp\gametypes\_rank::xppointspopup( "kill", 200 );
            level thread _id_A798::_id_49D8( var_1, 200 );
        }
        else if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        {
            _id_A798::_id_120A( var_1.owner );
            var_1.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", 200 );
            level thread _id_A798::_id_49D8( var_1.owner, 200 );
        }
    }

    level._id_49C1 = common_scripts\utility::array_remove( level._id_49C1, self );
    self.damagecallback = undefined;
    self setcandamage( 0 );
    self setdamagecallbackon( 0 );
    self freeentitysentient();

    if ( !isdefined( self ) )
        return;

    _id_49D2();
    self _meth_815A( 35 );
    self _meth_8103( undefined );
    self _meth_8105( 0 );
    var_4 = self.owner;
    self._id_A042 = 1;
    self playsound( "sentry_explode" );
    playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_aim" );
    playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
    self playsound( "sentry_explode_smoke" );
    wait 1.5;
    self notify( "deleting" );

    if ( isdefined( self._id_9199 ) )
        self._id_9199 delete();

    if ( isdefined( self._id_6638 ) )
        self._id_6638 delete();

    if ( isdefined( self._id_6811 ) )
        self._id_6811 delete();

    if ( isdefined( self._id_7321 ) )
        self._id_7321 delete();

    self delete();
}

_id_49D3()
{
    self.damagecallback = ::_id_49CF;
    self setcandamage( 1 );
    self setdamagecallbackon( 1 );
}

_id_49CF( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( ( !isdefined( var_1 ) || var_1.classname == "worldspawn" ) && isdefined( var_5 ) && ( var_5 == "killstreak_strike_missile_gas_mp" || var_5 == "warbird_missile_mp" ) )
        return;

    var_12 = var_2;

    if ( maps\mp\_utility::ismeleemod( var_4 ) )
        var_12 += self.maxhealth;

    if ( isdefined( var_3 ) && var_3 & level.idflags_penetration )
        self.wasdamagedfrombulletpenetration = 1;

    self.wasdamaged = 1;
    self._id_259B = 0.0;

    if ( isplayer( var_1 ) )
    {
        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "remote_turret" );

        if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
            var_12 *= level.armorpiercingmod;
    }

    if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        var_1.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "remote_turret" );

    if ( isdefined( var_5 ) )
    {
        var_13 = maps\mp\_utility::strip_suffix( var_5, "_lefthand" );

        switch ( var_13 )
        {
            case "remotemissile_projectile_mp":
            case "stinger_mp":
            case "ac130_105mm_mp":
            case "ac130_40mm_mp":
                self.largeprojectiledamage = 1;
                var_12 = self.maxhealth + 1;
                break;
            case "artillery_mp":
            case "stealth_bomb_mp":
                self.largeprojectiledamage = 0;
                var_12 += var_2 * 4;
                break;
            case "bomb_site_mp":
            case "emp_grenade_mp":
            case "emp_grenade_var_mp":
            case "emp_grenade_killstreak_mp":
                self.largeprojectiledamage = 0;
                var_12 = self.maxhealth + 1;
                break;
            case "frag_grenade_horde_mp":
            case "semtex_horde_mp":
                var_12 = int( self.maxhealth / 2 + 1 );
                break;
        }
    }

    self finishentitydamage( var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
}

_id_49D2()
{
    self _meth_8065( "sentry_offline" );
}
