// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_A257()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    if ( !isdefined( level._id_94EB ) )
        _id_94E8();

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        var_2 = maps\mp\_utility::strip_suffix( var_1, "_lefthand" );

        if ( var_2 == "tracking_drone_mp" )
        {
            var_0 thread _id_28CD();
            wait 0.5;

            if ( !_func_294( var_0 ) && isdefined( var_0 ) )
            {
                self._id_94ED = var_0.origin;
                self._id_94EC = var_0.angles;
                var_0 _id_2870();

                if ( !_id_6F4E( self._id_94ED ) )
                    _id_98CA( var_1 );
            }
        }
    }
}

_id_94E8()
{
    level._id_94E9 = 1;
    level._id_94EB = spawnstruct();
    level._id_94EB._id_9364 = 20.0;
    level._id_94EB._id_3580 = 30.0;
    level._id_94EB.health = 999999;
    level._id_94EB.maxhealth = 60;
    level._id_94EB._id_9D6D = "vehicle_tracking_drone_mp";
    level._id_94EB._id_5D3A = "npc_drone_tracking";
    level._id_94EB._id_3BAF = loadfx( "vfx/sparks/direct_hack_stun" );
    level._id_94EB._id_3BAB = loadfx( "vfx/lights/tracking_drone_laser_blue" );
    level._id_94EB._id_3BA9 = loadfx( "vfx/explosion/tracking_drone_explosion" );
    level._id_94EB._id_3BAD = loadfx( "vfx/explosion/frag_grenade_default" );
    level._id_94EB._id_3BB2 = loadfx( "vfx/lights/light_tracking_drone_blink_warning" );
    level._id_94EB._id_3BA7 = loadfx( "vfx/lights/light_tracking_drone_blink_enemy" );
    level._id_94EB._id_3BAA = loadfx( "vfx/lights/light_tracking_drone_blink_friendly" );
    level._id_94EB._id_3BB0 = loadfx( "vfx/distortion/tracking_drone_distortion_down" );
    level._id_94EB._id_3BB1 = loadfx( "vfx/distortion/tracking_drone_distortion_up" );
    level._id_94EB._id_3BA8 = loadfx( "vfx/distortion/tracking_drone_distortion_hemi" );
    level._id_94EB._id_8898 = "veh_tracking_drone_explode";
    level._id_94EB._id_889A = "veh_tracking_drone_lock_lp";
    level.trackingdrones = [];

    foreach ( var_1 in level.players )
        var_1.is_being_tracked = 0;

    level thread _id_64EF();
    level._id_94EE = level._id_94EB._id_9364;
    level._id_3576 = level._id_94EB._id_3580;
    level._id_94E3 = 0;
    level._id_94E4 = 65;
    level._id_94E5 = 0;
}

_id_98CA( var_0 )
{
    var_1 = 1;

    if ( maps\mp\_utility::isusingremote() )
        return 0;
    else if ( _id_33E2() )
    {
        self iclientprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( !isdefined( self._id_94E2 ) )
        self._id_94E2 = [];

    if ( self._id_94E2.size )
    {
        self._id_94E2 = common_scripts\utility::array_removeundefined( self._id_94E2 );

        if ( self._id_94E2.size >= level._id_94E9 )
        {
            if ( isdefined( self._id_94E2[0] ) )
                self._id_94E2[0] thread trackingdrone_leave();
        }
    }

    maps\mp\_utility::incrementfauxvehiclecount();
    var_2 = _id_2448( var_0 );

    if ( !isdefined( var_2 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    var_2.weaponname = var_0;
    self._id_94E2[self._id_94E2.size] = var_2;
    level.trackingdrones = common_scripts\utility::array_removeundefined( level.trackingdrones );
    level.trackingdrones[level.trackingdrones.size] = var_2;
    thread _id_8D3E( var_2 );
    return 1;
}

_id_2448( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !var_1 )
    {
        var_5 = self geteye();
        var_6 = anglestoforward( self getangles() );
        var_7 = self getangles();
        var_6 = anglestoforward( var_7 );
        var_8 = anglestoright( var_7 );
        var_9 = var_6 * 50;
        var_10 = var_8 * 0;
        var_11 = 80;

        switch ( self getstance() )
        {
            case "stand":
                var_11 = 80;
                break;
            case "crouch":
                var_11 = 65;
                break;
            case "prone":
                var_11 = 37;
                break;
        }

        var_12 = ( 0, 0, var_11 );
        var_12 += var_10;
        var_12 += var_9;

        if ( isdefined( self._id_94ED ) && isdefined( self._id_94EC ) )
        {
            var_13 = self._id_94ED;
            var_7 = self._id_94EC;
        }
        else
            var_13 = self.origin + var_12;
    }
    else
    {
        var_13 = var_2;
        var_14 = var_2;
        var_7 = var_3;
    }

    var_15 = self;

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_15 = level.player;

    var_16 = spawnhelicopter( var_15, var_13, var_7, level._id_94EB._id_9D6D, level._id_94EB._id_5D3A );

    if ( !isdefined( var_16 ) )
        return;

    if ( isdefined( var_4 ) )
    {
        var_16.type = "explosive_drone";
        var_16 setmodel( "vehicle_pdrone" );
    }
    else
        var_16.type = "tracking_drone";

    var_16 common_scripts\utility::make_entity_sentient_mp( self.team );
    var_16 _meth_83F3( 1 );
    var_16 _id_0854();
    var_16 thread _id_73AE();
    var_16.health = level._id_94EB.health;
    var_16.maxhealth = level._id_94EB.maxhealth;
    var_16.damagetaken = 0;
    var_16._id_03E3 = 20;
    var_16._id_3978 = 20;
    var_16.owner = self;
    var_16.team = self.team;
    var_16 _meth_8283( var_16._id_03E3, 10, 10 );
    var_16 _meth_8292( 120, 90 );
    var_16 _meth_825A( 64 );
    var_16 _meth_8253( 4, 5, 5 );
    var_16._id_3B88 = undefined;

    if ( isdefined( var_16.type ) )
    {
        if ( var_16.type == "tracking_drone" )
            var_16._id_3B88 = "fx_joint_0";
        else if ( var_16.type == "explosive_drone" )
            var_16._id_3B88 = "TAG_EYE";
    }

    if ( level.teambased )
        var_16 maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0.0, 0.0, 25.0 ), var_16._id_3B88 );
    else
        var_16 maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0.0, 0.0, 25.0 ), var_16._id_3B88 );

    var_16._id_5A54 = 2000;
    var_16._id_5A3A = 300;
    var_16._id_94B6 = undefined;
    var_17 = 45;
    var_18 = 45;
    var_16 _meth_8294( var_17, var_18 );
    var_16._id_91D1 = var_13;
    var_16._id_0E53 = 10000;
    var_16._id_0E52 = 150;
    var_16._id_0E54 = missile_createattractorent( var_16, var_16._id_0E53, var_16._id_0E52 );
    var_16._id_4724 = 0;
    var_16.stunned = 0;
    var_16._id_4C0E = 0;
    var_16 thread maps\mp\gametypes\_damage::setentitydamagecallback( var_16.maxhealth, undefined, ::_id_64EE, undefined, 0 );
    var_16 thread _id_94DA();
    var_16 thread _id_94D9();
    var_16 thread _id_94DE();
    var_16 thread _id_94DD();
    var_16 thread _id_94DF();
    var_16 thread _id_94DC();

    if ( !isdefined( level.ishorde ) )
        var_16 thread _id_94E1();

    if ( var_16.type == "tracking_drone" )
    {
        var_16 thread _id_94CE();
        var_16 thread _id_94D0();
        var_16 thread _id_2EDE();
    }

    return var_16;
}

_id_4B82( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_1 = anglestoforward( self.angles );

    for (;;)
    {
        if ( maps\mp\_utility::isreallyalive( self ) && !maps\mp\_utility::isusingremote() && anglestoforward( self.angles ) != var_1 )
        {
            var_1 = anglestoforward( self.angles );
            var_2 = self.origin + var_1 * -100 + ( 0.0, 0.0, 40.0 );
            var_0 moveto( var_2, 0.5 );
        }

        wait 0.5;
    }
}

_id_94D3( var_0, var_1 )
{
    var_1 endon( "disconnect" );
    playfxontagforclients( var_0, self, "fx_light_1", var_1 );
    wait 0.05;
    playfxontagforclients( var_0, self, "fx_light_2", var_1 );
    wait 0.05;
    playfxontagforclients( var_0, self, "fx_light_3", var_1 );
    wait 0.05;
    playfxontagforclients( var_0, self, "fx_light_4", var_1 );
}

_id_94CE()
{
    self endon( "death" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team != self.team )
        {
            childthread _id_94D3( level._id_94EB._id_3BA7, var_1 );
            wait 0.2;
        }
    }
}

_id_94D0()
{
    self endon( "death" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team == self.team )
        {
            childthread _id_94D3( level._id_94EB._id_3BAA, var_1 );
            wait 0.2;
        }
    }

    thread _id_A202();
    thread _id_A22D();
}

_id_2EDE()
{
    self endon( "death" );

    foreach ( var_1 in level.players )
    {
        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_F", var_1 );

        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_K", var_1 );

        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_L", var_1 );

        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_R", var_1 );

        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BA8 ) )
            playfxontagforclients( level._id_94EB._id_3BA8, self, "TAG_WEAPON", var_1 );

        wait 0.25;
    }

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 waittill( "spawned_player" );
        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_F", var_1 );

        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_K", var_1 );

        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_L", var_1 );

        wait 0.1;

        if ( isdefined( var_1 ) && isdefined( self ) && isdefined( level._id_94EB._id_3BB0 ) )
            playfxontagforclients( level._id_94EB._id_3BB0, self, "fx_thruster_down_R", var_1 );

        wait 0.1;
        playfxontagforclients( level._id_94EB._id_3BA8, self, "TAG_WEAPON", var_1 );
        wait 0.25;
    }
}

_id_A202()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            childthread _id_94D3( level._id_94EB._id_3BAA, var_0 );
            wait 0.2;
        }
    }
}

_id_A22D()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "joined_team", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            childthread _id_94D3( level._id_94EB._id_3BAA, var_0 );
            wait 0.2;
        }
    }
}

_id_8D3E( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 thread _id_94CF();
    var_0 thread _id_0EE6();

    if ( isdefined( var_0.type ) )
    {
        if ( var_0.type == "explosive_drone" )
            var_0 thread _id_1D02();
        else if ( var_0.type == "tracking_drone" && !isdefined( level.ishorde ) )
            var_0 thread _id_94D1();
    }
}

_id_1D02()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );

    for (;;)
    {
        common_scripts\utility::waittill_any( "goal", "near_goal", "hit_goal" );

        if ( self._id_94B6 != self.owner && maps\mp\_utility::isreallyalive( self._id_94B6 ) )
        {
            var_0 = distancesquared( self._id_94B6.origin, self.origin );

            if ( var_0 <= 16384 )
            {
                self notify( "exploding" );
                thread _id_14C3();
                break;
            }
        }
    }
}

_id_14C3()
{
    var_0 = 2;
    var_1 = undefined;

    if ( isdefined( self.owner ) )
        var_1 = self.owner;

    if ( isdefined( self ) )
    {
        thread _id_992D();
        self playsound( "drone_warning_beap" );
    }

    wait(var_0);

    if ( isdefined( self ) )
    {
        self playsound( "drone_bomb_explosion" );
        var_2 = anglestoup( self.angles );
        var_3 = anglestoforward( self.angles );
        playfx( level._id_94EB._id_3BAD, self.origin, var_3, var_2 );

        if ( isdefined( var_1 ) )
            self entityradiusdamage( self.origin, 256, 1000, 25, var_1, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp" );
        else
            self entityradiusdamage( self.origin, 256, 1000, 25, undefined, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp" );

        self notify( "death" );
    }
}

_id_992D()
{
    if ( isdefined( self ) )
    {
        stopfxontag( level._id_94EB._id_3BA7, self, "tag_fx_beacon_0" );
        stopfxontag( level._id_94EB._id_3BA7, self, "tag_fx_beacon_1" );
        stopfxontag( level._id_94EB._id_3BA7, self, "tag_fx_beacon_2" );
        stopfxontag( level._id_94EB._id_3BAA, self, "tag_fx_beacon_0" );
        stopfxontag( level._id_94EB._id_3BAA, self, "tag_fx_beacon_1" );
        stopfxontag( level._id_94EB._id_3BAA, self, "tag_fx_beacon_2" );
    }

    wait 0.05;

    if ( isdefined( self ) )
    {
        playfxontag( level._id_94EB._id_3BB2, self, "tag_fx_beacon_0" );
        playfxontag( level._id_94EB._id_3BB2, self, "tag_fx_beacon_1" );
    }

    wait 0.15;

    if ( isdefined( self ) )
        playfxontag( level._id_94EB._id_3BB2, self, "tag_fx_beacon_2" );
}

_id_94CF()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "exploding" );

    if ( !isdefined( self.owner ) )
    {
        thread trackingdrone_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self _meth_8283( self._id_3978, 10, 10 );
    self._id_6F66 = self.owner;
    self._id_94B6 = undefined;

    if ( isdefined( level.ishorde ) && level.ishorde )
        self._id_94B6 = self.owner;

    for (;;)
    {
        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.5;
            continue;
        }

        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            var_0 = self._id_5A54 * self._id_5A54;
            var_1 = var_0;

            if ( !isdefined( level.ishorde ) )
            {
                if ( !isdefined( self._id_94B6 ) || self._id_94B6 == self.owner )
                {
                    foreach ( var_3 in level.players )
                    {
                        if ( isdefined( var_3 ) && isalive( var_3 ) && var_3.team != self.team && !var_3 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                        {
                            var_4 = distancesquared( self.origin, var_3.origin );

                            if ( var_4 < var_1 )
                            {
                                var_1 = var_4;
                                self._id_94B6 = var_3;
                                thread _id_A242( var_3 );
                            }
                        }
                    }
                }
            }

            if ( !isdefined( self._id_94B6 ) )
                self._id_94B6 = self.owner;

            if ( isdefined( self._id_94B6 ) )
                _id_94D4( self._id_94B6 );

            if ( self._id_94B6 != self._id_6F66 )
            {
                _id_8EE8( self._id_6F66 );
                self._id_6F66 = self._id_94B6;
            }
        }

        wait 1;
    }
}

_id_A242( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "exploding" );
    var_0 common_scripts\utility::waittill_any( "death", "disconnect", "faux_spawn", "joined_team" );

    if ( isdefined( var_0 ) )
    {
        if ( var_0.is_being_tracked == 1 )
        {
            if ( !isalive( var_0 ) )
                var_0.died_being_tracked = 1;

            thread trackingdrone_leave();
        }
        else
            self._id_94B6 = undefined;
    }
}

_id_94D4( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "trackingDrone_moveToPlayer" );
    self endon( "trackingDrone_moveToPlayer" );
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_1 = 0;
        var_2 = 30;

        switch ( var_0 getstance() )
        {
            case "stand":
                var_3 = 105;
                break;
            case "crouch":
                var_3 = 75;
                break;
            case "prone":
                var_3 = 45;
                break;
        }
    }
    else
    {
        var_1 = -65;
        var_2 = 0;

        switch ( var_0 getstance() )
        {
            case "stand":
                var_3 = 65;
                break;
            case "crouch":
                var_3 = 50;
                break;
            case "prone":
                var_3 = 22;
                break;
        }
    }

    var_4 = ( var_2, var_1, var_3 );
    self _meth_83F9( var_0, var_4 );
    self._id_4EC1 = 1;
    thread _id_94DB();
    thread _id_94E0();
}

_id_94D5()
{
    self _meth_825B( self.origin, 1 );
    self._id_4EC1 = 0;
    self._id_4C0E = 1;
}

_id_94CD( var_0 )
{
    maps\mp\_utility::incrementfauxvehiclecount();
    var_1 = var_0 _id_2448( self.weaponname, 1, self.origin, self.angles );

    if ( !isdefined( var_1 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    if ( !isdefined( var_0._id_94E2 ) )
        var_0._id_94E2 = [];

    var_0._id_94E2[var_0._id_94E2.size] = var_1;
    level.trackingdrones = common_scripts\utility::array_removeundefined( level.trackingdrones );
    level.trackingdrones[level.trackingdrones.size] = var_1;
    var_0 thread _id_8D3E( var_1 );

    if ( isdefined( level._id_94EB._id_3BAF ) )
        stopfxontag( level._id_94EB._id_3BAF, self, self._id_3B88 );

    _id_73E0();
    return 1;
}

_id_94D1()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( self.owner ) )
    {
        thread trackingdrone_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self._id_54FE = spawn( "script_model", self.origin );
    self._id_54FE setmodel( "tag_laser" );

    for (;;)
    {
        if ( isdefined( self._id_94B6 ) )
        {
            self._id_54FE.origin = self gettagorigin( "tag_weapon" );
            var_0 = 20;
            var_1 = ( randomfloat( var_0 ), randomfloat( var_0 ), randomfloat( var_0 ) ) - ( 10.0, 10.0, 10.0 );
            var_2 = 65;

            switch ( self._id_94B6 getstance() )
            {
                case "stand":
                    var_2 = 65;
                    break;
                case "crouch":
                    var_2 = 50;
                    break;
                case "prone":
                    var_2 = 22;
                    break;
            }

            self._id_54FE.angles = vectortoangles( self._id_94B6.origin + ( 0, 0, var_2 - 20 ) + var_1 - self.origin );
        }

        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.5;
            continue;
        }

        var_3 = undefined;

        if ( isdefined( self._id_94B6 ) )
        {
            var_4 = bullettrace( self.origin, self._id_94B6.origin, 1, self );
            var_3 = var_4["entity"];
        }

        if ( isdefined( self._id_94B6 ) && self._id_94B6 != self.owner && isdefined( var_3 ) && var_3 == self._id_94B6 && distancesquared( self.origin, self._id_94B6.origin ) < self._id_5A3A * self._id_5A3A )
        {
            if ( self._id_94B6.is_being_tracked == 0 )
                _id_8D18( self._id_94B6 );
        }
        else if ( isdefined( self._id_94B6 ) && self._id_94B6.is_being_tracked == 1 )
            _id_8EE8( self._id_94B6 );

        wait 0.05;
    }
}

_id_8D18( var_0 )
{
    self._id_54FE laseron( "tracking_drone_laser" );
    playfxontag( level._id_94EB._id_3BAB, self._id_54FE, "tag_laser" );

    if ( isdefined( level._id_94EB._id_889A ) )
        self playloopsound( level._id_94EB._id_889A );

    var_0 setperk( "specialty_radararrow", 1, 0 );

    if ( var_0.is_being_tracked == 0 )
    {
        var_0.is_being_tracked = 1;
        var_0.trackedbyplayer = self.owner;
    }
}

_id_8EE8( var_0 )
{
    if ( isdefined( self._id_54FE ) )
    {
        self._id_54FE laseroff();
        stopfxontag( level._id_94EB._id_3BAB, self._id_54FE, "tag_laser" );
    }

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( level._id_94EB._id_889A ) )
            self stoploopsound();

        if ( var_0 hasperk( "specialty_radararrow", 1 ) )
            var_0 unsetperk( "specialty_radararrow", 1 );

        var_0 notify( "player_not_tracked" );
        var_0.is_being_tracked = 0;
        var_0.trackedbyplayer = undefined;
    }
}

_id_64EF()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.is_being_tracked = 0;

        foreach ( var_0 in level.players )
        {
            if ( !isdefined( var_0.is_being_tracked ) )
                var_0.is_being_tracked = 0;
        }
    }
}

_id_94DB()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "trackingDrone_watchForGoal" );
    self endon( "trackingDrone_watchForGoal" );
    var_0 = common_scripts\utility::waittill_any_return( "goal", "near_goal", "hit_goal" );
    self._id_4EC1 = 0;
    self._id_4C0E = 0;
    self notify( "hit_goal" );
}

_id_94D9()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );
    thread _id_94E6();
}

_id_94E1()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    var_0 = level._id_94EE;

    if ( self.type == "explosive_drone" )
        var_0 = level._id_3576;

    wait(var_0);
    thread trackingdrone_leave();
}

_id_94DE()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "owner_gone" );
    thread trackingdrone_leave();
}

_id_94DD()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    for (;;)
    {
        self.owner waittill( "death" );
        thread trackingdrone_leave();
    }
}

_id_94E0()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "trackingDrone_watchTargetDisconnect" );
    self endon( "trackingDrone_watchTargetDisconnect" );
    self._id_94B6 waittill( "disconnect" );
    _id_8EE8( self._id_94B6 );
    _id_94D4( self.owner );
}

_id_94DF()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level common_scripts\utility::waittill_any( "round_end_finished", "game_ended" );
    thread trackingdrone_leave();
}

_id_94DC()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level waittill( "host_migration_begin" );
    _id_8EE8( self._id_94B6 );
    _id_94D5();
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    thread _id_94CD( self.owner );
}

trackingdrone_leave()
{
    self endon( "death" );
    self notify( "leaving" );
    _id_8EE8( self._id_94B6 );
    _id_94E7();
}

_id_64EE( var_0, var_1, var_2, var_3 )
{
    self notify( "death" );
}

_id_94DA()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        thread _id_94D8();
    }
}

_id_94D8()
{
    self notify( "trackingDrone_stunned" );
    self endon( "trackingDrone_stunned" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    _id_94D6();
    wait 10.0;
    _id_94D7();
}

_id_94D6()
{
    if ( self.stunned )
        return;

    self.stunned = 1;

    if ( isdefined( level._id_94EB._id_3BAF ) )
        playfxontag( level._id_94EB._id_3BAF, self, self._id_3B88 );

    thread _id_8EE8( self._id_94B6 );
    self._id_94B6 = undefined;
    self._id_6F66 = self.owner;
    thread _id_94D5();
}

_id_94D7()
{
    if ( isdefined( level._id_94EB._id_3BAF ) )
        killfxontag( level._id_94EB._id_3BAF, self, self._id_3B88 );

    self.stunned = 0;
    self._id_4C0E = 0;
}

_id_94E6()
{
    if ( !isdefined( self ) )
        return;

    _id_8EE8( self._id_94B6 );
    _id_94D7();
    _id_94E7();
}

_id_94E7()
{
    if ( isdefined( level._id_94EB._id_3BA9 ) )
        playfx( level._id_94EB._id_3BA9, self.origin );

    if ( isdefined( level._id_94EB._id_8898 ) )
        self playsound( level._id_94EB._id_8898 );

    self notify( "explode" );
    _id_73E0();
}

_id_2870()
{
    if ( !_func_294( self ) && isdefined( self ) )
    {
        if ( isdefined( self._id_0E54 ) )
            missile_deleteattractor( self._id_0E54 );

        self delete();
    }
}

_id_73E0()
{
    maps\mp\_utility::decrementfauxvehiclecount();

    if ( isdefined( self.owner ) && isdefined( self.owner._id_94CC ) )
        self.owner._id_94CC = undefined;

    if ( isdefined( self._id_54FE ) )
        self._id_54FE delete();

    _id_2870();
}

_id_0854()
{
    level.trackingdrones[self getentitynumber()] = self;
}

_id_73AE()
{
    var_0 = self getentitynumber();
    self waittill( "death" );
    level.trackingdrones[var_0] = undefined;
    level.trackingdrones = common_scripts\utility::array_removeundefined( level.trackingdrones );
}

_id_33E2()
{
    if ( level.trackingdrones.size >= maps\mp\_utility::maxvehiclesallowed() )
        return 1;
    else
        return 0;
}

_id_0EE6()
{
    self playloopsound( "veh_tracking_drone_jets_lp" );
}

_id_28CD()
{
    self endon( "death" );

    if ( !isdefined( level._id_A284 ) )
        return;

    for (;;)
    {
        foreach ( var_1 in level._id_A284 )
        {
            if ( self istouching( var_1 ) )
            {
                if ( isdefined( level._id_94EB._id_3BA9 ) )
                    playfx( level._id_94EB._id_3BA9, self.origin );

                if ( isdefined( level._id_94EB._id_8898 ) )
                    self playsound( level._id_94EB._id_8898 );

                _id_2870();
            }
        }

        wait 0.05;
    }
}

_id_6F4E( var_0 )
{
    if ( !isdefined( level._id_A284 ) )
        return 0;

    foreach ( var_2 in level._id_A284 )
    {
        if ( _func_22A( var_0, var_2 ) )
            return 1;
    }

    return 0;
}
