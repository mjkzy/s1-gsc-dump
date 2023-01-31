// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.mp_prison_killstreak_duration = 25;
    precachelocationselector( "map_artillery_selector" );
    precachestring( &"KILLSTREAKS_MP_PRISON" );
    precacheitem( "prison_turret_mp" );
    _func_251( "prison_laser" );
    level.mp_prison_inuse = 0;
    level.prison_turrets_alive = 0;
    level.prison_turret_alarm_sfx = "mp_prison_ks_alarm";
    level.prison_turret_burn_sfx = "orbital_laser";
    level.prison_turret_warning_light_friendly = loadfx( "vfx/lights/light_tracking_prison_blink_friendly" );
    level.prison_turret_warning_light_enemy = loadfx( "vfx/lights/light_tracking_prison_blink_enemy" );
    level.prison_turret_laser_glow = loadfx( "vfx/lights/prison_tracking_laser_blue" );
    level.killstreakfuncs["mp_prison"] = ::tryusempprison;
    level.mapkillstreak = "mp_prison";

    if ( !isdefined( level.sentrysettings ) )
        level.sentrysettings = [];

    level.sentrysettings["prison_turret"] = spawnstruct();
    level.sentrysettings["prison_turret"].health = 999999;
    level.sentrysettings["prison_turret"].maxhealth = 1000;
    level.sentrysettings["prison_turret"].burstmin = 20;
    level.sentrysettings["prison_turret"].burstmax = 120;
    level.sentrysettings["prison_turret"].pausemin = 0.15;
    level.sentrysettings["prison_turret"].pausemax = 0.35;
    level.sentrysettings["prison_turret"].sentrymodeon = "sentry";
    level.sentrysettings["prison_turret"].sentrymodeoff = "sentry_offline";
    level.sentrysettings["prison_turret"].timeout = 90.0;
    level.sentrysettings["prison_turret"].spinuptime = 0.05;
    level.sentrysettings["prison_turret"].overheattime = 8.0;
    level.sentrysettings["prison_turret"].cooldowntime = 0.1;
    level.sentrysettings["prison_turret"].fxtime = 0.3;
    level.sentrysettings["prison_turret"].streakname = "sentry";
    level.sentrysettings["prison_turret"].weaponinfo = "prison_turret_mp";
    level.sentrysettings["prison_turret"].modelbase = "prison_security_laser";
    level.sentrysettings["prison_turret"].modelplacement = "sentry_minigun_weak_obj";
    level.sentrysettings["prison_turret"].modelplacementfailed = "sentry_minigun_weak_obj_red";
    level.sentrysettings["prison_turret"].modeldestroyed = "sentry_minigun_weak_destroyed";
    level.sentrysettings["prison_turret"].hintstring = &"MP_PRISON_SENSOR_PICKUP";
    level.sentrysettings["prison_turret"].headicon = 1;
    level.sentrysettings["prison_turret"].teamsplash = "used_sentry";
    level.sentrysettings["prison_turret"].shouldsplash = 0;
    level.sentrysettings["prison_turret"].vodestroyed = "sentry_destroyed";
    level.mapkillstreakpickupstring = level.sentrysettings["prison_turret"].hintstring;
    level thread onprisonplayerconnect();
    level.prison_turrets = setupprisonturrets();
}

tryusempprison( var_0, var_1 )
{
    if ( level.mp_prison_inuse )
    {
        self iclientprintlnbold( &"MP_PRISON_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    var_2 = setprisonturretplayer( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_prison", self.origin );

    return var_2;
}

setupprisonturrets()
{
    var_0 = getentarray( "prison_turret", "targetname" );
    var_1 = "prison_turret";

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_0[var_2].spawned_turret = spawnturret( "misc_turret", var_0[var_2].origin, level.sentrysettings[var_1].weaponinfo, 0 );
        var_0[var_2].spawned_turret _meth_8136();
        var_0[var_2].spawned_turret sentry_initsentry( var_1 );
        var_0[var_2].spawned_turret.angles = var_0[var_2].angles;
        var_0[var_2].spawned_turret.alarm_on = 0;
        var_0[var_2].spawned_turret.burn_on = 0;
        var_0[var_2].spawned_turret.proxy_alarm_on = 0;
        var_0[var_2].spawned_turret.prison_turret_active = 0;
    }

    return var_0;
}

sentry_initsentry( var_0 )
{
    self.sentrytype = var_0;
    self.canbeplaced = 1;
    self _meth_80B1( level.sentrysettings[self.sentrytype].modelbase );
    self _meth_8138();
    self _meth_815A( 0.0 );
    self _meth_817A( 1 );
    maps\mp\killstreaks\_autosentry::sentry_setinactive();
    thread maps\mp\killstreaks\_autosentry::sentry_handleuse();
}

setprisonturretplayer( var_0 )
{
    if ( level.mp_prison_inuse )
        return 0;

    level.mp_prison_inuse = 1;

    for ( var_1 = 0; var_1 < level.prison_turrets.size; var_1++ )
    {
        level.prison_turrets_alive++;
        level.prison_turrets[var_1].spawned_turret sentry_setowner( var_0 );
        level.prison_turrets[var_1].spawned_turret.shouldsplash = 0;
        level.prison_turrets[var_1].spawned_turret.carriedby = var_0;
        level.prison_turrets[var_1].spawned_turret sentry_setplaced();
        level.prison_turrets[var_1].spawned_turret _meth_82C0( 1 );
        level.prison_turrets[var_1].spawned_turret _meth_82C1( 1 );
        level.prison_turrets[var_1].spawned_turret thread sentry_handledamage();
        level.prison_turrets[var_1].spawned_turret thread sentry_handledeath();
        level.prison_turrets[var_1].spawned_turret.alarm_on = 0;
        level.prison_turrets[var_1].spawned_turret.burn_on = 0;
        level.prison_turrets[var_1].spawned_turret.proxy_alarm_on = 0;
        level.prison_turrets[var_1].spawned_turret.shocking_target = 0;
        level.prison_turrets[var_1].spawned_turret.prison_turret_active = 1;
        level.prison_turrets[var_1].spawned_turret.numnearbyplayers = 0;
        level.prison_turrets[var_1].spawned_turret thread prisonturretportableradar();
        level.prison_turrets[var_1].spawned_turret thread repeatoneshotprisonalarm();
        level.prison_turrets[var_1].spawned_turret thread aud_play_announcer_warning();
    }

    level thread prisonturrettimer();
    level thread monitorprisonkillstreakownership();
    level thread applyprisonturretradararrow();
    return 1;
}

prisonturrettimer()
{
    level endon( "game_ended" );
    var_0 = level.mp_prison_killstreak_duration;

    while ( var_0 > 0 )
    {
        wait 1;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
        var_0--;

        if ( level.mp_prison_inuse == 0 )
            return;
    }

    for ( var_1 = 0; var_1 < level.prison_turrets.size; var_1++ )
        level.prison_turrets[var_1].spawned_turret notify( "fake_prison_death" );
}

sentry_setowner( var_0 )
{
    self.owner = var_0;
    self _meth_8103( self.owner );

    if ( level.teambased && isdefined( var_0 ) )
    {
        self.team = self.owner.team;
        self _meth_8135( self.team );
    }

    thread sentry_handleownerdisconnect();
}

sentry_setplaced()
{
    self _meth_8104( undefined );
    self.carriedby _meth_80DE();
    self.carriedby = undefined;

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    sentry_setactive();
    self playsound( "sentry_gun_plant" );
    self notify( "placed" );
}

sentry_handledamage()
{
    self endon( "fake_prison_death" );
    level endon( "game_ended" );
    self.health = level.sentrysettings[self.sentrytype].health;
    self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) )
            continue;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        var_10 = 0;

        if ( isdefined( var_9 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_11 )
            {
                case "emp_grenade_var_mp":
                case "emp_grenade_mp":
                    self.largeprojectiledamage = 0;
                    var_10 = self.maxhealth + 1;

                    if ( isplayer( var_1 ) )
                        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

                    break;
                default:
                    if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
                        var_10 = var_0 * 3.5;
                    else
                        var_10 = 0;

                    if ( isplayer( var_1 ) )
                        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

                    break;
            }

            maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_9, self );
        }

        self.damagetaken += var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );

            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
            {
                var_1 maps\mp\_utility::incplayerstat( "map_killstreak_destroyed", 1 );
                level thread maps\mp\gametypes\_rank::awardgameevent( "map_killstreak_destroyed", var_1, var_9, undefined, var_4 );
            }

            if ( isdefined( self.owner ) )
                self.owner thread maps\mp\_utility::leaderdialogonplayer( level.sentrysettings[self.sentrytype].vodestroyed, undefined, undefined, self.origin );

            self notify( "fake_prison_death" );
            return;
        }
    }
}

sentry_handledeath()
{
    self waittill( "fake_prison_death" );

    if ( !isdefined( self ) )
        return;

    maps\mp\killstreaks\_autosentry::sentry_setinactive();
    self _meth_8103( undefined );
    self _meth_8105( 0 );

    if ( level.sentrysettings[self.sentrytype].headicon )
    {
        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( "none", ( 0, 0, 0 ) );
        else
            maps\mp\_entityheadicons::setplayerheadicon( "none", ( 0, 0, 0 ) );
    }

    level.prison_turrets_alive--;
    self _meth_82C0( 0 );
    self _meth_82C1( 0 );

    if ( self.alarm_on == 1 )
        self.alarm_on = 0;

    if ( self.burn_on == 1 )
        self.burn_on = 0;

    if ( isdefined( self.previous_turret_target ) )
    {
        self notify( "lost_or_changed_target" );
        self.previous_turret_target = undefined;
    }

    self.shocking_target = 0;
    self.turret_on_target = undefined;

    if ( self.proxy_alarm_on == 1 )
        self.proxy_alarm_on = 0;

    self.prison_turret_active = 0;
}

sentry_setactive()
{
    self _meth_8065( level.sentrysettings[self.sentrytype].sentrymodeon );

    if ( level.sentrysettings[self.sentrytype].headicon )
    {
        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0, 0, 25 ) );
        else
            maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0, 0, 25 ) );
    }
}

sentry_handleownerdisconnect()
{
    level endon( "game_ended" );
    self endon( "fake_prison_death" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "fake_prison_death" );
}

monitorprisonkillstreakownership()
{
    level endon( "game_ended" );

    while ( level.prison_turrets_alive > 0 )
        wait 0.05;

    level.mp_prison_inuse = 0;

    for ( var_0 = 0; var_0 < level.prison_turrets.size; var_0++ )
    {
        if ( level.prison_turrets[var_0].spawned_turret.proxy_alarm_on == 1 )
            level.prison_turrets[var_0].spawned_turret.proxy_alarm_on = 0;

        for ( var_1 = 0; var_1 < level.players.size; var_1++ )
        {
            level.players[var_1].laser_tag_array[var_0] _meth_80B3();
            stopfxontag( level.prison_turret_laser_glow, level.players[var_1].laser_tag_array[var_0], "tag_laser" );
            level.players[var_1].laser_tag_array[var_0] _meth_846B();
            level.players[var_1].laser_tag_array[var_0].laserfxactive = 0;
        }
    }

    for ( var_2 = 0; var_2 < level.players.size; var_2++ )
    {
        level.players[var_2].numnearbyprisonturrets = 0;

        if ( level.players[var_2] _meth_82A7( "specialty_radararrow", 1 ) )
            level.players[var_2] _meth_82A9( "specialty_radararrow", 1 );

        level.players[var_2] notify( "player_not_tracked" );
        level.players[var_2].is_being_tracked = 0;
    }
}

handleprisonturretlights()
{
    playfxontag( level.prison_turret_warning_light_friendly, self, "tag_fx" );
    self waittill( "fake_prison_death" );
    stopfxontag( level.prison_turret_warning_light_friendly, self, "tag_fx" );
}

prisonturretportableradar()
{
    level endon( "game_ended" );
    self.portable_radar = spawn( "script_model", self.origin );
    self.portable_radar.team = self.team;
    self.portable_radar makeportableradar( self.owner );
    self waittill( "fake_prison_death" );
    level maps\mp\gametypes\_portable_radar::deleteportableradar( self.portable_radar );
    self.portable_radar = undefined;
}

applyprisonturretradararrow()
{
    level endon( "game_ended" );

    while ( level.mp_prison_inuse )
    {
        if ( isdefined( level.prison_turrets ) && isdefined( level.players ) )
        {
            for ( var_0 = 0; var_0 < level.prison_turrets.size; var_0++ )
            {
                if ( level.prison_turrets[var_0].spawned_turret.prison_turret_active != 1 )
                {
                    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
                    {
                        if ( level.players[var_1].laser_tag_array[var_0].laserfxactive == 1 )
                        {
                            level.players[var_1].laser_tag_array[var_0] _meth_80B3();
                            level.players[var_1].laser_tag_array[var_0] _meth_846B();
                            level.players[var_1].laser_tag_array[var_0].laserfxactive = 0;
                        }
                    }

                    continue;
                }

                level.prison_turrets[var_0].spawned_turret.numnearbyplayers = 0;

                for ( var_1 = 0; var_1 < level.players.size; var_1++ )
                {
                    var_2 = 0;
                    var_3 = 10;
                    var_4 = ( randomfloat( var_3 ), randomfloat( var_3 ), randomfloat( var_3 ) ) - ( 5, 5, 5 );

                    if ( level.players[var_1] _meth_817C() == "stand" )
                        var_5 = ( 0, 0, 50 ) + var_4;
                    else if ( level.players[var_1] _meth_817C() == "crouch" )
                        var_5 = ( 0, 0, 35 ) + var_4;
                    else
                        var_5 = ( 0, 0, 10 ) + var_4;

                    if ( isdefined( level.players[var_1] ) && isalive( level.players[var_1] ) && ( level.teambased && level.players[var_1].team != level.prison_turrets[var_0].spawned_turret.team || !level.teambased && level.players[var_1] != level.prison_turrets[var_0].spawned_turret.owner ) )
                    {
                        var_6 = distancesquared( level.players[var_1].origin, level.prison_turrets[var_0].spawned_turret.origin );

                        if ( var_6 < 3610000 )
                        {
                            if ( sighttracepassed( level.prison_turrets[var_0].spawned_turret.origin, level.players[var_1].origin + var_5, 0, undefined ) )
                                var_2 = 1;
                        }
                    }

                    if ( var_2 )
                    {
                        if ( level.players[var_1].laser_tag_array[var_0].laserfxactive == 0 )
                        {
                            level.players[var_1].laser_tag_array[var_0].laserfxactive = 1;
                            level.players[var_1].laser_tag_array[var_0] _meth_80B2( "prison_laser" );
                            playfxontag( level.prison_turret_laser_glow, level.players[var_1].laser_tag_array[var_0], "tag_laser" );
                            level.players[var_1].laser_tag_array[var_0] _meth_846A( level.players[var_1], "bone", "tag_eye", "randomoffset" );
                        }

                        level.players[var_1].numnearbyprisonturrets++;
                        level.prison_turrets[var_0].spawned_turret.numnearbyplayers++;
                        continue;
                    }

                    if ( level.players[var_1].laser_tag_array[var_0].laserfxactive == 1 )
                    {
                        level.players[var_1].laser_tag_array[var_0].laserfxactive = 0;
                        level.players[var_1].laser_tag_array[var_0] _meth_80B3();
                        stopfxontag( level.prison_turret_laser_glow, level.players[var_1].laser_tag_array[var_0], "tag_laser" );
                        level.players[var_1].laser_tag_array[var_0] _meth_846B();
                    }
                }

                if ( level.prison_turrets[var_0].spawned_turret.numnearbyplayers > 0 )
                {
                    if ( level.prison_turrets[var_0].spawned_turret.proxy_alarm_on == 0 )
                        level.prison_turrets[var_0].spawned_turret.proxy_alarm_on = 1;

                    continue;
                }

                if ( level.prison_turrets[var_0].spawned_turret.proxy_alarm_on == 1 )
                    level.prison_turrets[var_0].spawned_turret.proxy_alarm_on = 0;
            }

            for ( var_7 = 0; var_7 < level.players.size; var_7++ )
            {
                if ( level.players[var_7].numnearbyprisonturrets > 0 )
                {
                    level.players[var_7] _meth_82A6( "specialty_radararrow", 1, 0 );

                    if ( level.players[var_7].is_being_tracked == 0 )
                        level.players[var_7].is_being_tracked = 1;
                }
                else
                {
                    if ( level.players[var_7] _meth_82A7( "specialty_radararrow", 1 ) )
                        level.players[var_7] _meth_82A9( "specialty_radararrow", 1 );

                    level.players[var_7] notify( "player_not_tracked" );
                    level.players[var_7].is_being_tracked = 0;
                }

                level.players[var_7].numnearbyprisonturrets = 0;
            }
        }

        wait 0.1;
    }
}

createlasertagarray()
{
    if ( !isdefined( self.laser_tag_array ) )
    {
        self.laser_tag_array = [];

        for ( var_0 = 0; var_0 < level.prison_turrets.size; var_0++ )
        {
            var_1 = level.prison_turrets[var_0].spawned_turret.origin;
            self.laser_tag_array[var_0] = spawn( "script_model", var_1 );
            self.laser_tag_array[var_0] _meth_80B1( "tag_laser" );
            self.laser_tag_array[var_0].laserfxactive = 0;
        }
    }
}

deletelasertagarray()
{
    if ( isdefined( self.laser_tag_array ) )
    {
        for ( var_0 = 0; var_0 < level.prison_turrets.size; var_0++ )
        {
            self.laser_tag_array[var_0] _meth_846B();
            self.laser_tag_array[var_0] delete();
        }
    }
}

onprisonplayerconnect()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.is_being_tracked = 0;
        var_0 createlasertagarray();
        var_0.numnearbyprisonturrets = 0;
        var_0 thread onprisonplayerdisconnect();
    }
}

onprisonplayerdisconnect()
{
    level endon( "game_ended" );
    self waittill( "disconnect" );
    deletelasertagarray();
}

createprisonturrettrackingoverlay()
{
    if ( !isdefined( self.prisonturrettrackingoverlay ) )
    {
        self.prisonturrettrackingoverlay = newclienthudelem( self );
        self.prisonturrettrackingoverlay.x = -80;
        self.prisonturrettrackingoverlay.y = -60;
        self.prisonturrettrackingoverlay _meth_80CC( "tracking_drone_targeted_overlay", 800, 600 );
        self.prisonturrettrackingoverlay.alignx = "left";
        self.prisonturrettrackingoverlay.aligny = "top";
        self.prisonturrettrackingoverlay.horzalign = "fullscreen";
        self.prisonturrettrackingoverlay.vertalign = "fullscreen";
        self.prisonturrettrackingoverlay.alpha = 0;
    }
}

fadeinoutprisontrackingoverlay()
{
    level endon( "game_ended" );
    self endon( "player_not_tracked" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );

    for (;;)
    {
        if ( isdefined( self.turrettrackingoverlay ) )
        {
            var_0 = randomfloatrange( 0.25, 1.0 );
            self.prisonturrettrackingoverlay fadeovertime( 0.1 );
            self.prisonturrettrackingoverlay.color = ( var_0, var_0, var_0 );
            self.prisonturrettrackingoverlay.alpha = 1;
            wait 0.1;
        }

        wait 0.05;
    }
}

endprisontrackingoverlay()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self.prisonturrettrackingoverlay fadeovertime( 0.2 );
    self.prisonturrettrackingoverlay.alpha = 0.0;
}

repeatoneshotprisonalarm()
{
    self endon( "fake_prison_death" );

    while ( level.mp_prison_inuse )
    {
        if ( self.proxy_alarm_on == 1 )
            playsoundatpos( self.origin, level.prison_turret_alarm_sfx );

        wait 4;
    }
}

aud_play_announcer_warning()
{
    wait 2.5;
    playsoundatpos( ( 0, 0, 0 ), "mp_prison_anouncer_ext" );
}
