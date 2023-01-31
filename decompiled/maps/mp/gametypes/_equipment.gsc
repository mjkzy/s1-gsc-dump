// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

watchtrophyusage()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self.trophyarray = [];

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );

        if ( var_1 == "trophy" || var_1 == "trophy_mp" )
        {
            if ( !isalive( self ) )
            {
                var_0 delete();
                return;
            }

            var_0 hide();
            var_0 waittill( "missile_stuck" );
            var_2 = 40;

            if ( var_2 * var_2 < distancesquared( var_0.origin, self.origin ) )
            {
                var_3 = bullettrace( self.origin, self.origin - ( 0, 0, var_2 ), 0, self );

                if ( var_3["fraction"] == 1 )
                {
                    var_0 delete();
                    self _meth_82F7( "trophy_mp", self _meth_82F9( "trophy_mp" ) + 1 );
                    continue;
                }

                var_0.origin = var_3["position"];
            }

            var_0 show();
            self.trophyarray = common_scripts\utility::array_removeundefined( self.trophyarray );

            if ( self.trophyarray.size >= level.maxperplayerexplosives )
                self.trophyarray[0] thread trophybreak();

            var_4 = spawn( "script_model", var_0.origin );
            var_4 _meth_80B1( "mp_trophy_system" );
            var_4 thread maps\mp\gametypes\_weapons::createbombsquadmodel( "mp_trophy_system_bombsquad", "tag_origin", self );
            var_4.angles = var_0.angles;
            self.trophyarray[self.trophyarray.size] = var_4;
            var_4.owner = self;
            var_4.team = self.team;
            var_4.weaponname = var_1;
            var_4.stunned = 0;
            level.trophies[level.trophies.size] = var_4;

            if ( isdefined( self.trophyremainingammo ) && self.trophyremainingammo > 0 )
                var_4.ammo = self.trophyremainingammo;
            else
                var_4.ammo = 2;

            var_4.trigger = spawn( "script_origin", var_4.origin );
            var_4 thread trophydamage( self );
            var_4 thread trophyactive( self );
            var_4 thread trophydisconnectwaiter( self );
            var_4 thread trophyplayerspawnwaiter( self );
            var_4 thread trophyuselistener( self );
            var_4 thread maps\mp\gametypes\_weapons::c4empkillstreakwait();

            if ( level.teambased )
                var_4 maps\mp\_entityheadicons::setteamheadicon( var_4.team, ( 0, 0, 65 ) );
            else
                var_4 maps\mp\_entityheadicons::setplayerheadicon( var_4.owner, ( 0, 0, 65 ) );

            wait 0.05;

            if ( isdefined( var_0 ) )
                var_0 delete();
        }
    }
}

trophystunbegin()
{
    if ( self.stunned )
        return;

    self.stunned = 1;
    playfxontag( common_scripts\utility::getfx( "mine_stunned" ), self, "tag_origin" );
}

trophystunend()
{
    self.stunned = 0;
    stopfxontag( common_scripts\utility::getfx( "mine_stunned" ), self, "tag_origin" );
}

trophychangeowner( var_0 )
{
    if ( isdefined( self.entityheadicon ) )
        self.entityheadicon destroy();

    self notify( "change_owner" );
    self.owner = var_0;
    self.team = var_0.team;
    var_0.trophyarray[var_0.trophyarray.size] = self;

    if ( level.teambased )
        maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0, 0, 65 ) );
    else
        maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0, 0, 65 ) );

    thread trophydamage( var_0 );
    thread trophyactive( var_0 );
    thread trophydisconnectwaiter( var_0 );
    thread trophyplayerspawnwaiter( var_0 );
}

trophyuselistener( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    self.trigger _meth_80DA( "HINT_NOICON" );
    self.trigger _meth_80DB( &"MP_PICKUP_TROPHY" );
    self.trigger maps\mp\_utility::setselfusable( var_0 );
    self.trigger thread maps\mp\_utility::notusableforjoiningplayers( var_0 );

    for (;;)
    {
        self.trigger waittill( "trigger", var_0 );
        var_0 playlocalsound( "scavenger_pack_pickup" );
        var_1 = var_0 _meth_82F8( "trophy_mp" );
        var_0 _meth_82F6( "trophy_mp", var_1 + 1 );
        var_0.trophyremainingammo = self.ammo;
        self.trigger delete();
        self delete();
        self notify( "death" );
    }
}

trophyplayerspawnwaiter( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "change_owner" );
    var_0 waittill( "spawned" );
    thread trophybreak();
}

trophydisconnectwaiter( var_0 )
{
    self endon( "death" );
    self endon( "change_owner" );
    var_0 waittill( "disconnect" );
    thread trophybreak();
}

trophyactive( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "disconnect" );
    self endon( "death" );
    self endon( "change_owner" );
    self endon( "trophyDisabled" );

    if ( !isdefined( var_1 ) )
        var_1 = 384;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = "exorepulsor_equipment_mp";

    var_4 = var_1 * var_1;

    for (;;)
    {
        if ( !isdefined( level.grenades ) || level.grenades.size < 1 && level.missiles.size < 1 && level.trackingdrones.size < 1 || isdefined( self.disabled ) || self.stunned == 1 )
        {
            wait 0.05;
            continue;
        }

        var_5 = common_scripts\utility::array_combine( level.grenades, level.missiles );
        var_5 = common_scripts\utility::array_combine( var_5, level.trackingdrones );

        if ( var_5.size < 1 )
        {
            wait 0.05;
            continue;
        }

        foreach ( var_7 in var_5 )
        {
            wait 0.05;

            if ( !isdefined( var_7 ) )
                continue;

            if ( var_7 == self )
                continue;

            if ( isdefined( var_7.weaponname ) )
            {
                switch ( var_7.weaponname )
                {
                    case "orbital_carepackage_droppod_mp":
                    case "orbital_carepackage_pod_mp":
                    case "claymore_mp":
                        continue;
                }
            }

            switch ( var_7.model )
            {
                case "mp_trophy_system":
                case "weapon_radar":
                case "weapon_jammer":
                case "weapon_parabolic_knife":
                    continue;
            }

            if ( !isdefined( var_7.owner ) )
                var_7.owner = getmissileowner( var_7 );

            if ( isdefined( var_7.owner ) && level.teambased && var_7.owner.team == var_0.team )
                continue;

            if ( isdefined( var_7.owner ) && var_7.owner == var_0 )
                continue;

            if ( !trophywithinmindot( var_7 ) )
                continue;

            var_8 = distancesquared( var_7.origin, self.origin );

            if ( var_8 < var_4 )
            {
                if ( bullettracepassed( var_7.origin, self.origin, 0, self ) )
                {
                    var_9 = self.origin + ( 0, 0, 32 );

                    if ( isdefined( self.laserent ) )
                        var_9 = self.laserent.origin;

                    playfx( level.sentry_fire, var_9, var_7.origin - self.origin, anglestoup( self.angles ) );
                    thread trophyhandlelaser( var_0, var_7 );
                    self playsound( "trophy_detect_projectile" );

                    if ( isdefined( var_7.classname ) && var_7.classname == "rocket" && ( isdefined( var_7.type ) && var_7.type == "remote" ) )
                    {
                        if ( isdefined( var_7.type ) && var_7.type == "remote" )
                        {
                            level thread maps\mp\gametypes\_missions::vehiclekilled( var_7.owner, var_0, undefined, var_0, undefined, "MOD_EXPLOSIVE", var_3 );
                            level thread maps\mp\_utility::teamplayercardsplash( "callout_destroyed_predator_missile", var_0 );
                            level thread maps\mp\gametypes\_rank::awardgameevent( "kill", var_0, var_3, undefined, "MOD_EXPLOSIVE" );
                            var_0 notify( "destroyed_killstreak", var_3 );
                        }

                        if ( isdefined( level.chopper_fx["explode"]["medium"] ) )
                            playfx( level.chopper_fx["explode"]["medium"], var_7.origin );

                        if ( isdefined( level.barrelexpsound ) )
                            var_7 playsound( level.barrelexpsound );
                    }

                    if ( isdefined( var_7.type ) && var_7.type == "tracking_drone" )
                        var_7 thread maps\mp\_tracking_drone::trackingdrone_leave();
                    else
                    {
                        var_0 thread projectileexplode( var_7, self );
                        var_0 maps\mp\gametypes\_missions::processchallenge( "ch_noboomforyou" );
                    }

                    if ( !var_2 )
                        self.ammo--;

                    if ( self.ammo <= 0 )
                        thread trophybreak();
                }
            }
        }
    }
}

trophysetmindot( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    self.mindot = var_0;
    self.trophyangleoffset = var_1;
}

trophywithinmindot( var_0 )
{
    if ( !isdefined( self.mindot ) )
        return 1;

    var_1 = anglestoforward( self.angles + self.trophyangleoffset );
    var_2 = vectornormalize( var_0.origin - self.origin );
    var_3 = vectordot( var_1, var_2 );
    return var_3 > self.mindot;
}

trophyhandlelaser( var_0, var_1 )
{
    if ( !isdefined( self.laserent ) )
        return;

    var_0 endon( "disconnect" );
    self endon( "death" );
    self endon( "change_owner" );
    self endon( "trophyDisabled" );
    self.laserent endon( "death" );
    self notify( "trophyDelayClearLaser" );
    self endon( "trophyDelayClearLaser" );
    self.laserent.angles = vectortoangles( var_1.origin - self.laserent.origin );
    self.laserent _meth_80B2( "tracking_drone_laser" );
    wait 0.7;
    self.laserent _meth_80B3();
}

trophyaddlaser( var_0, var_1 )
{
    self.laserent = spawn( "script_model", self.origin );
    self.laserent _meth_80B1( "tag_laser" );
    self.laserent.angles = self.angles;
    self.laserent.laseroriginoffset = var_0;
    self.laserent.laserforwardangles = var_1;
    thread trophyupdatelaser();
}

trophyupdatelaser()
{
    self endon( "death" );
    self endon( "change_owner" );
    self endon( "trophyDisabled" );
    self.laserent endon( "death" );

    for (;;)
    {
        var_0 = anglestoforward( self.angles + self.laserent.laserforwardangles );
        self.laserent.origin = self.origin + var_0 * self.laserent.laseroriginoffset;
        waitframe();
    }
}

projectileexplode( var_0, var_1 )
{
    self endon( "death" );
    var_2 = var_0.origin;
    var_3 = var_0.model;
    var_4 = var_0.angles;

    if ( var_3 == "weapon_light_marker" )
    {
        playfx( level.empgrenadeexplode, var_2, anglestoforward( var_4 ), anglestoup( var_4 ) );
        var_1 thread trophybreak();
        var_0 delete();
        return;
    }

    var_0 delete();
    var_1 playsound( "trophy_fire" );
    playfx( level.mine_explode, var_2, anglestoforward( var_4 ), anglestoup( var_4 ) );
    radiusdamage( var_2, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp" );
}

trophydamage( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    self endon( "change_owner" );
    self _meth_82C0( 1 );
    self.health = 999999;
    self.maxhealth = 100;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( !isplayer( var_2 ) )
            continue;

        if ( !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_2 ) )
            continue;

        if ( isdefined( var_10 ) )
            var_11 = maps\mp\_utility::strip_suffix( var_10, "_lefthand" );
        else
            var_11 = undefined;

        if ( isdefined( var_11 ) )
        {
            switch ( var_11 )
            {
                case "smoke_grenade_var_mp":
                case "stun_grenade_var_mp":
                case "smoke_grenade_mp":
                case "stun_grenade_mp":
                case "concussion_grenade_mp":
                case "flash_grenade_mp":
                    continue;
            }
        }

        if ( !isdefined( self ) )
            return;

        if ( maps\mp\_utility::ismeleemod( var_5 ) )
            self.damagetaken += self.maxhealth;

        if ( isdefined( var_9 ) && var_9 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        self.wasdamaged = 1;

        if ( isdefined( var_11 ) && ( var_11 == "emp_grenade_mp" || var_11 == "emp_grenade_var_mp" || var_11 == "emp_grenade_killstreak_mp" ) )
            self.damagetaken += self.maxhealth;

        self.damagetaken += var_1;

        if ( isplayer( var_2 ) )
            var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "trophy" );

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isdefined( var_0 ) && var_2 != var_0 )
                var_2 notify( "destroyed_explosive" );

            thread trophybreak();
        }
    }
}

trophybreak()
{
    playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_origin" );
    self playsound( "sentry_explode" );
    self notify( "death" );
    var_0 = self.origin;
    self.trigger makeunusable();

    if ( isdefined( self.laserent ) )
        self.laserent delete();

    wait 3;

    if ( isdefined( self.trigger ) )
        self.trigger delete();

    if ( isdefined( self ) )
        self delete();
}
