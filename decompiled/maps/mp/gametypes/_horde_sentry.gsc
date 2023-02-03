// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

hordesentryinit()
{
    level.hordesentryspawns = getentarray( "horde_sentry", "targetname" );
    level.hordesentryarray = [];

    if ( maps\mp\_utility::getmapname() == "mp_recovery" )
    {
        foreach ( var_1 in level.hordesentryspawns )
        {
            if ( distancesquared( var_1.origin, ( -2099, 719.9, 120 ) ) < 4096 )
                level.hordesentryspawns = common_scripts\utility::array_remove( level.hordesentryspawns, var_1 );
        }
    }
}

hordespawnenemyturret( var_0, var_1 )
{
    var_2 = spawnturret( "misc_turret", var_1.origin, var_0 );
    var_2.angles = var_1.angles;
    var_2.owner = undefined;
    var_2.health = 500;
    var_2.maxhealth = 500;
    var_2.turrettype = "mg_turret";
    var_2.stunned = 0;
    var_2.directhacked = 0;
    var_2.stunnedtime = 5.0;
    var_2.issentry = 1;
    var_2.weaponinfo = var_0;
    var_2.energyturret = 0;
    var_2.rocketturret = 0;
    var_2.guardian = 0;
    var_2.ishordeenemysentry = 1;
    var_2.isalive = 1;
    var_2 setmodel( "npc_sentry_energy_turret_base" );
    var_2 setmode( "sentry" );
    var_2 setturretteam( "axis" );
    var_2 setsentryowner( undefined );
    var_2 setturretminimapvisible( 1, var_0 );
    var_2 setleftarc( 360 );
    var_2 setrightarc( 360 );
    var_2 setbottomarc( 90 );
    var_2 setdefaultdroppitch( -89.0 );
    var_2 setcandamage( 1 );
    var_2.damagefade = 1.0;
    var_2 thread hordeturretpicktarget();
    var_2 thread hordeturretshoot();
    var_2 thread hordeturret_setactive();
    var_2 thread maps\mp\killstreaks\_remoteturret::turret_watchdisabled();
    level.hordesentryarray[level.hordesentryarray.size] = var_2;
    playfx( level._effect["spawn_effect"], var_2.origin );
    return var_2;
}

hordeturretshoot()
{
    self endon( "death" );
    self endon( "deleting" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 0.05;

        if ( isdefined( self.targetplayer ) && ( isplayer( self.targetplayer ) && self.targetplayer.ignoreme ) )
            continue;

        if ( isdefined( self.targetplayer ) )
        {
            if ( isdefined( self getturrettarget( 1 ) ) )
            {
                var_0 = randomintrange( 25, 50 );

                for ( var_1 = 0; var_1 < var_0; var_1++ )
                {
                    self shootturret();
                    wait 0.1;
                }

                wait(randomintrange( 3, 5 ));
                continue;
            }

            wait(randomintrange( 1, 3 ));
        }
    }
}

hordeturretpicktarget()
{
    self endon( "death" );
    self endon( "deleting" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = maps\mp\gametypes\_horde_util::hordegetclosehealthyenemyforturret( self );

        if ( !self.stunned && !isdefined( self.waitingtodie ) && isdefined( var_0 ) )
        {
            if ( isdefined( var_0.isaerialassaultdrone ) && var_0.isaerialassaultdrone )
                self settargetentity( var_0, ( 0, 0, -20 ) );
            else
                self settargetentity( var_0 );

            self.targetplayer = var_0;
        }
        else
        {
            self cleartargetentity();
            self.targetplayer = undefined;
        }

        wait 0.1;
    }
}

hordeturret_setactive()
{
    self endon( "death" );
    self setdefaultdroppitch( 0.0 );
    self makeunusable();
    self maketurretsolid();
    self.team = "axis";
    self setturretteam( "axis" );
    thread hordeturret_handledeath();
    thread hordeturret_setupdamagecallback();
}

hordeturret_handledeath()
{
    var_0 = self getentitynumber();
    self waittill( "death", var_1, var_2, var_3 );
    self.isalive = 0;

    if ( isdefined( var_1 ) )
    {
        if ( isplayer( var_1 ) )
        {
            maps\mp\gametypes\_horde_util::awardhordekill( var_1 );
            var_1 thread maps\mp\gametypes\_rank::xppointspopup( "kill", 200 );
            level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_1, 200 );
        }
        else if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
        {
            maps\mp\gametypes\_horde_util::awardhordekill( var_1.owner );
            var_1.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", 200 );
            level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_1.owner, 200 );
        }
    }

    level.hordesentryarray = common_scripts\utility::array_remove( level.hordesentryarray, self );
    self.damagecallback = undefined;
    self setcandamage( 0 );
    self setdamagecallbackon( 0 );
    self freeentitysentient();

    if ( !isdefined( self ) )
        return;

    hordeturret_setinactive();
    self setdefaultdroppitch( 35 );
    self setsentryowner( undefined );
    self setturretminimapvisible( 0 );
    var_4 = self.owner;
    self.waitingtodie = 1;
    self playsound( "sentry_explode" );
    playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_aim" );
    playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
    self playsound( "sentry_explode_smoke" );
    wait 1.5;
    self notify( "deleting" );

    if ( isdefined( self.target_ent ) )
        self.target_ent delete();

    if ( isdefined( self.ownertrigger ) )
        self.ownertrigger delete();

    if ( isdefined( self.pickupent ) )
        self.pickupent delete();

    if ( isdefined( self.remoteent ) )
        self.remoteent delete();

    self delete();
}

hordeturret_setupdamagecallback()
{
    self.damagecallback = ::hordeturret_handledamagecallback;
    self setcandamage( 1 );
    self setdamagecallbackon( 1 );
}

hordeturret_handledamagecallback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( ( !isdefined( var_1 ) || var_1.classname == "worldspawn" ) && isdefined( var_5 ) && ( var_5 == "killstreak_strike_missile_gas_mp" || var_5 == "warbird_missile_mp" ) )
        return;

    var_12 = var_2;

    if ( maps\mp\_utility::ismeleemod( var_4 ) )
        var_12 += self.maxhealth;

    if ( isdefined( var_3 ) && var_3 & level.idflags_penetration )
        self.wasdamagedfrombulletpenetration = 1;

    self.wasdamaged = 1;
    self.damagefade = 0.0;

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
            case "ac130_40mm_mp":
            case "ac130_105mm_mp":
            case "stinger_mp":
            case "remotemissile_projectile_mp":
                self.largeprojectiledamage = 1;
                var_12 = self.maxhealth + 1;
                break;
            case "stealth_bomb_mp":
            case "artillery_mp":
                self.largeprojectiledamage = 0;
                var_12 += var_2 * 4;
                break;
            case "emp_grenade_killstreak_mp":
            case "emp_grenade_var_mp":
            case "emp_grenade_mp":
            case "bomb_site_mp":
                self.largeprojectiledamage = 0;
                var_12 = self.maxhealth + 1;
                break;
            case "semtex_horde_mp":
            case "frag_grenade_horde_mp":
                var_12 = int( self.maxhealth / 2 + 1 );
                break;
        }
    }

    self finishentitydamage( var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
}

hordeturret_setinactive()
{
    self setmode( "sentry_offline" );
}
