// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

hordecreatedrone( var_0, var_1, var_2 )
{
    var_3 = hordegetdronespawn();
    var_4 = ( randomfloatrange( 0.1, 5 ), randomfloatrange( 0.1, 5 ), randomfloatrange( 0.1, 5 ) );
    var_5 = spawnhelicopter( var_0, var_3.origin + var_4, ( 0, 0, 0 ), var_1, var_2 );
    var_5.current_air_space = getent( var_3.target, "targetname" );
    var_5.maxhealth = level.dronehealth;
    var_5.damagetaken = 0;
    var_5.fx_tag0 = "TAG_EYE";
    var_5.speed = 20;
    var_5.followspeed = 20;
    var_5.owner = var_0;
    var_5.team = "axis";
    var_5.ishordedrone = 1;
    var_5.maxtrackingrange = 2000;
    var_5.maxlaserrange = 300;
    var_5.trackedplayer = undefined;
    var_5 sethoverparams( 0, 0, 0 );
    var_5 setmaxpitchroll( 90, 90 );
    var_5 vehicle_setspeed( 40, 40, 40 );
    var_5 vehicle_helicoptersetmaxangularvelocity( 90, 180, 90 );
    var_5 vehicle_helicoptersetmaxangularacceleration( 1000 );
    var_5 setneargoalnotifydist( 5 );
    var_5 setyawspeed( 1000, 250, 100, 0.1 );
    var_5 thread horde_drone_flying_fx();
    var_5 thread hordedrone_handledamage();
    var_5 thread hordedrone_watchdeath();
    var_5.droneturret = var_5 hordespawndroneturret( level.droneweapon, "vehicle_xh9_warbird_turret_coop", "TAG_EYE" );
    var_5 thread hordedroneshoot();
    self.currenttarget = common_scripts\utility::random( level.players );
    var_5 thread flying_attack_drone_logic();
    return var_5;
}

hordegetdronespawn()
{
    var_0 = common_scripts\utility::array_randomize( level.hordedronespawns );

    foreach ( var_2 in var_0 )
    {
        var_3 = 1;

        foreach ( var_5 in level.players )
        {
            if ( spawnsighttrace( var_2, var_2.origin, var_5.origin, 0 ) )
            {
                var_3 = 0;
                break;
            }
        }

        if ( var_3 )
            return var_2;
    }

    return common_scripts\utility::random( level.hordedronespawns );
}

hordedroneshoot()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.targetenemy ) )
        {
            if ( isdefined( self.targetenemy.isaerialassaultdrone ) && self.targetenemy.isaerialassaultdrone )
                self.droneturret settargetentity( self.targetenemy, ( 0, 0, -20 ) );
            else
                self.droneturret settargetentity( self.targetenemy );

            if ( isdefined( self.droneturret getturrettarget( 0 ) ) )
            {
                var_0 = randomintrange( 5, 10 );

                for ( var_1 = 0; var_1 < var_0; var_1++ )
                {
                    self.droneturret shootturret();
                    wait 0.08;
                }

                wait(randomintrange( 3, 5 ));
            }
            else
                wait(randomintrange( 1, 3 ));
        }

        wait 0.05;
    }
}

horde_drone_flying_fx()
{
    self endon( "death" );
    var_0 = 0.3;
    var_1 = common_scripts\utility::getfx( "drone_fan_distortion" );

    if ( level.hordedronetype == "drone_large_energy" )
        var_1 = common_scripts\utility::getfx( "drone_fan_distortion_large" );

    foreach ( var_3 in level.players )
    {
        playfxontagforclients( var_1, self, "TAG_FX_FAN_L", var_3 );
        waitframe();
        playfxontagforclients( var_1, self, "TAG_FX_FAN_R", var_3 );
        playfxontagforclients( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_0", var_3 );
        wait(var_0);
        playfxontagforclients( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_1", var_3 );
        wait(var_0);
        playfxontagforclients( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_2", var_3 );
    }
}

hordedrone_handledamage()
{
    self endon( "death" );
    level endon( "game_ended" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( ( !isdefined( var_1 ) || var_1.classname == "worldspawn" ) && isdefined( var_9 ) && ( var_9 == "killstreak_strike_missile_gas_mp" || var_9 == "warbird_missile_mp" ) )
            continue;

        if ( isdefined( var_1.team ) )
        {
            if ( self.team == var_1.team )
                continue;
        }
        else if ( isdefined( var_1.owner ) && isdefined( var_1.owner.team ) )
        {
            if ( self.team == var_1.owner.team )
                continue;
        }

        self.lasttododamage = var_1;

        if ( !isdefined( self ) )
            return;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        self.wasdamaged = 1;
        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "tracking_drone" );

            if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
            {
                if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                    var_10 += var_0 * level.armorpiercingmod;
            }
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "tracking_drone" );

        if ( isdefined( var_9 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_11 )
            {
                case "ac130_40mm_mp":
                case "ac130_105mm_mp":
                case "stinger_mp":
                case "remotemissile_projectile_mp":
                    self.largeprojectiledamage = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "emp_grenade_killstreak_mp":
                case "emp_grenade_var_mp":
                case "emp_grenade_mp":
                    var_10 = self.maxhealth + 1;
                case "stun_grenade_var_mp":
                case "stun_grenade_mp":
                case "flash_grenade_mp":
                case "concussion_grenade_mp":
                    break;
            }

            maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_9, self );
        }

        self.damagetaken += var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( maps\mp\_utility::ismeleemod( var_4 ) || var_4 == "MOD_IMPACT" )
                maps\mp\gametypes\_horde_util::awardhordemeleekills( var_1 );

            self notify( "death" );
            return;
        }
    }
}

hordedrone_watchdeath()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death", var_0 );
    var_0 = self.lasttododamage;
    thread hordedronedestroyed( var_0 );
}

hordedronedestroyed( var_0 )
{
    if ( !isdefined( self ) )
        return;

    level.currentaliveenemycount--;
    level.enemiesleft--;
    setomnvar( "ui_horde_enemies_left", level.enemiesleft );

    if ( level.objdefend )
        maps\mp\gametypes\horde::checkdefendkill( self, var_0 );

    level notify( "enemy_death", var_0, self );
    waitframe();

    if ( isplayer( var_0 ) )
    {
        maps\mp\gametypes\_horde_util::awardhordekill( var_0 );
        var_0 thread maps\mp\gametypes\_rank::xppointspopup( "kill", 100 );
        level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_0, 100 );

        if ( var_0 maps\mp\_utility::_hasperk( "specialty_triggerhappy" ) )
        {

        }
    }

    if ( isdefined( var_0 ) && isdefined( var_0.owner ) && isplayer( var_0.owner ) && isdefined( var_0.owner.killz ) )
    {
        maps\mp\gametypes\_horde_util::awardhordekill( var_0.owner );
        var_0.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", 100 );
        level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_0.owner, 100 );
    }

    maps\mp\_tracking_drone::trackingdrone_stunend();

    if ( isdefined( level.trackingdronesettings.fxid_explode ) )
        playfx( level.trackingdronesettings.fxid_explode, self.origin );

    if ( isdefined( level.trackingdronesettings.sound_explode ) )
        self playsound( "horde_uav_assault_drone_exp" );

    level.currentpointtotal += 100;
    level notify( "pointsEarned" );
    self.droneturret delete();
    self delete();
}

hordespawndroneturret( var_0, var_1, var_2 )
{
    var_3 = spawnturret( "misc_turret", self gettagorigin( var_2 ), var_0, 0 );
    var_3.angles = self gettagangles( var_2 );
    var_3 setmodel( var_1 );
    var_3 setdefaultdroppitch( -45.0 );
    var_3 linkto( self, var_2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3.owner = self.owner;
    var_3.health = 10000;
    var_3.maxhealth = 10000;
    var_3.damagetaken = 0;
    var_3.stunned = 0;
    var_3.stunnedtime = 0.0;
    var_3 setcandamage( 1 );
    var_3 setcanradiusdamage( 1 );
    var_3 setbottomarc( 180 );
    var_3.team = self.team;
    var_3.pers["team"] = self.team;

    if ( level.teambased )
        var_3 setturretteam( self.team );

    var_3 setmode( "auto_nonai" );
    var_3 setsentryowner( undefined );
    var_3 setturretminimapvisible( 0 );
    var_3.chopper = self;
    var_3 setleftarc( 180 );
    var_3 setrightarc( 180 );
    var_3 maketurretinoperable();
    var_3 maketurretsolid();
    var_3 makeunusable();
    var_3 thread hordedroneturret_setupdamagecallback();
    return var_3;
}

hordedroneturret_setupdamagecallback()
{
    self.damagecallback = ::hordedroneturret_handledamagecallback;
    self setcandamage( 1 );
    self setdamagecallbackon( 1 );
}

hordedroneturret_handledamagecallback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    self.chopper notify( "damage", var_2, var_1, var_7, var_6, var_4, undefined, undefined, var_11, var_3, var_5 );
}

flying_attack_drone_system_init()
{
    level.drone_air_spaces = [];
    level.flying_attack_drones = [];
    level.hordedronespawns = common_scripts\utility::getstructarray( "horde_drone_spawn", "targetname" );
    level.player_test_points = common_scripts\utility::getstructarray( "player_test_point", "targetname" );
    var_0 = getentarray( "trigger_once", "classname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_noteworthy ) && var_2.script_noteworthy == "drone_air_space" )
            level.drone_air_spaces[level.drone_air_spaces.size] = var_2;
    }

    init_linked_air_spaces();
    init_target_points();

    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];
}

init_drone_motion()
{
    var_0 = undefined;

    if ( !isdefined( self.script_airspeed ) )
        var_0 = 40;
    else
        var_0 = self.script_airspeed;

    self setneargoalnotifydist( 30 );
    self vehicle_setspeed( var_0, var_0 / 4, var_0 / 4 );
}

flying_attack_drone_logic( var_0 )
{
    self notify( "pdrone_flying_attack_drone_logic" );
    self endon( "pdrone_flying_attack_drone_logic" );
    self endon( "death" );
    var_0 = self;
    var_0 thread flying_attack_drone_damage_monitor();
    var_0 thread flying_attack_drone_death_monitor();
    var_0.attack_delay = 1.0;
    var_0.attack_accuracy = 1.0;
    var_0 init_drone_motion();

    if ( isdefined( var_0.target ) )
        var_0 waittill( "reached_dynamic_path_end" );

    var_0 thread flying_attack_drone_move_think();
}

get_target_air_space( var_0 )
{
    var_1 = 500000000;
    var_2 = undefined;

    foreach ( var_4 in level.player_test_points )
    {
        var_5 = distancesquared( var_4.origin, var_0.origin );

        if ( var_5 < var_1 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }
    }

    return var_2.link;
}

get_random_air_space()
{
    var_0 = common_scripts\utility::random( level.player_test_points );
    return var_0.link;
}

flying_attack_drone_move_think()
{
    self endon( "death" );

    if ( !isdefined( level.drone_air_spaces ) )
        return;

    update_flying_attack_drone_goal_pos();
    self waittill( "near_goal" );
    wait 0.05;

    for (;;)
    {
        var_0 = maps\mp\gametypes\_horde_util::hordegetclosesthealthyenemy( self );

        if ( isdefined( var_0 ) )
        {
            self setlookatent( var_0 );
            self.targetenemy = var_0;
            var_1 = get_target_air_space( var_0 );
        }
        else
            var_1 = get_random_air_space();

        if ( var_1 != self.current_air_space )
        {
            var_2 = get_next_air_space( self.current_air_space, var_1, level.drone_air_spaces );

            if ( isdefined( var_2 ) )
                self.current_air_space = var_2;
        }

        update_flying_attack_drone_goal_pos();
        self waittill( "near_goal" );

        if ( var_1 == self.current_air_space )
            wait_in_current_air_space();
    }
}

wait_in_current_air_space()
{
    level endon( "pdrone_wait_in_current_air_space" );
    wait(randomfloatrange( 0.5, 1.5 ));
}

calc_flock_goal_pos()
{
    var_0 = self.origin;

    if ( !ispointinvolume( var_0, self.current_air_space ) )
        var_0 = get_random_point_in_air_space( self.current_air_space );
    else
    {
        var_1 = 0;
        var_2 = 0;
        var_3 = ( 0, 0, 0 );
        var_4 = 0;
        var_5 = ( 0, 0, 0 );

        foreach ( var_7 in level.flying_attack_drones )
        {
            if ( self != var_7 && isdefined( self.current_air_space ) && isdefined( var_7.current_air_space ) )
            {
                if ( self.current_air_space == var_7.current_air_space )
                {
                    var_1++;
                    var_8 = var_7.origin - self.origin;
                    var_9 = length( var_8 );

                    if ( var_9 < 90 )
                    {
                        var_2++;
                        var_3 -= 0.5 * ( 90 - var_9 ) * var_8 / var_9;
                    }
                    else if ( var_9 > 150 )
                    {
                        var_4++;
                        var_5 += 0.5 * ( var_9 - 150 ) * var_8 / var_9;
                    }
                }
            }
        }

        if ( var_1 > 0 )
        {
            if ( randomint( 5 ) == 0 )
                var_0 = get_random_point_in_air_space( self.current_air_space );
            else
            {
                if ( var_2 > 0 )
                    var_0 += var_3 / var_2;

                if ( var_4 > 0 )
                    var_0 += var_5 / var_4;
            }
        }
        else
            var_0 = get_random_point_in_air_space( self.current_air_space );
    }

    return var_0;
}

get_tactical_goal_pos()
{
    if ( self.current_air_space != level.drone_tactical_picker_data.target_air_space || !isdefined( self.flock_goal_position ) || !isdefined( self.flock_goal_offset ) )
        return get_random_point_in_air_space( self.current_air_space );

    if ( isdefined( self.dodge_position ) )
        return self.dodge_position;

    return self.flock_goal_position + self.flock_goal_offset;
}

tactical_move_to_goal_pos()
{
    var_0 = get_tactical_goal_pos();
    var_1 = undefined;
    var_2 = self.angles[1];

    if ( !isdefined( self.drone_threat_data ) || !isdefined( self.drone_threat_data.threat ) )
    {
        var_1 = 1;
        var_3 = var_0 - self.origin;

        if ( var_3 != ( 0, 0, 0 ) )
        {
            var_4 = vectortoangles( var_3 );
            var_2 = var_4[1];
        }
    }

    self vehicle_helisetai( var_0, 60, 50, 50, undefined, var_1, var_2, 0, 0, 0, 0, 0, 1 );
}

update_flying_attack_drone_goal_pos()
{
    self setvehgoalpos( calc_flock_goal_pos(), 1 );
}

get_random_point_in_air_space( var_0 )
{
    for ( var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ); !ispointinvolume( var_1, var_0 ); var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) )
    {

    }

    return var_1;
}

flying_attack_drone_damage_monitor()
{
    self endon( "death" );
    self.damagetaken = 0;
    self.istakingdamage = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
            continue;

        self notify( "flying_attack_drone_damaged_by_player" );
        thread flying_attack_drone_damage_update();
    }
}

flying_attack_drone_damage_update()
{
    self notify( "taking damage" );
    self endon( "taking damage" );
    self endon( "death" );
    self.istakingdamage = 1;
    wait 1;
    self.istakingdamage = 0;
}

flying_attack_drone_death_monitor()
{
    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];

    level.flying_attack_drones = common_scripts\utility::array_add( level.flying_attack_drones, self );
    self waittill( "death" );
    level.flying_attack_drones = common_scripts\utility::array_remove( level.flying_attack_drones, self );
    level notify( "flying_attack_drone_destroyed" );
}

init_linked_air_spaces()
{
    var_0 = level.drone_air_spaces;
    var_1 = [];
    var_2 = 0;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !isdefined( var_0[var_3].script_linkname ) )
        {
            var_1[var_1.size] = var_3;
            continue;
        }

        if ( int( var_0[var_3].script_linkname ) > var_2 )
            var_2 = int( var_0[var_3].script_linkname );
    }

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_2++;
        var_0[var_1[var_3]].script_linkname = var_2;
    }

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !isdefined( var_0[var_3].links ) )
            var_0[var_3].links = [];

        var_4 = [];

        if ( isdefined( var_0[var_3].script_linkto ) )
        {
            var_4 = strtok( var_0[var_3].script_linkto, " " );

            for ( var_5 = 0; var_5 < var_4.size; var_5++ )
            {
                for ( var_6 = 0; var_6 < var_0.size; var_6++ )
                {
                    if ( var_0[var_6].script_linkname == var_4[var_5] )
                    {
                        var_7 = 0;

                        for ( var_8 = 0; var_8 < var_0[var_3].links.size; var_8++ )
                        {
                            if ( var_0[var_3].links[var_8] == var_0[var_6] )
                            {
                                var_7 = 1;
                                break;
                            }
                        }

                        if ( !var_7 )
                            var_0[var_3].links[var_0[var_3].links.size] = var_0[var_6];

                        if ( !isdefined( var_0[var_6].links ) )
                            var_0[var_6].links = [];

                        var_7 = 0;

                        for ( var_8 = 0; var_8 < var_0[var_6].links.size; var_8++ )
                        {
                            if ( var_0[var_6].links[var_8] == var_0[var_3] )
                            {
                                var_7 = 1;
                                break;
                            }
                        }

                        if ( !var_7 )
                            var_0[var_6].links[var_0[var_6].links.size] = var_0[var_3];

                        break;
                    }
                }
            }
        }
    }
}

init_target_points()
{
    for ( var_0 = 0; var_0 < level.player_test_points.size; var_0++ )
        level.player_test_points[var_0].link = getent( level.player_test_points[var_0].target, "targetname" );
}

get_next_air_space( var_0, var_1, var_2 )
{
    var_3 = var_0;
    var_0 = var_1;
    var_1 = var_3;
    var_4 = [];
    var_4[0] = var_0;
    var_5 = [];
    var_0.f_score = distancesquared( var_0.origin, var_1.origin );
    var_0.g_score = 0;

    while ( var_4.size > 0 )
    {
        var_6 = undefined;
        var_7 = 500000000;

        foreach ( var_9 in var_4 )
        {
            if ( var_9.f_score < var_7 )
            {
                var_6 = var_9;
                var_7 = var_9.f_score;
            }
        }

        if ( var_6 == var_1 )
            return var_6.came_from;

        var_4 = common_scripts\utility::array_remove( var_4, var_6 );
        var_5[var_5.size] = var_6;
        var_11 = var_6.links;

        foreach ( var_9 in var_11 )
        {
            if ( common_scripts\utility::array_contains( var_5, var_9 ) )
                continue;

            var_13 = var_6.g_score + distancesquared( var_6.origin, var_9.origin );
            var_14 = common_scripts\utility::array_contains( var_4, var_9 );

            if ( !var_14 )
            {
                var_9.came_from = var_6;
                var_9.g_score = var_13;
                var_9.f_score = var_9.g_score + distancesquared( var_9.origin, var_1.origin );
                var_4[var_4.size] = var_9;
                continue;
            }

            if ( var_13 < var_9.g_score )
            {
                var_9.came_from = var_6;
                var_9.g_score = var_13;
                var_9.f_score = var_9.g_score + distancesquared( var_9.origin, var_1.origin );
            }
        }
    }

    return undefined;
}
