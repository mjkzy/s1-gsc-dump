// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_code()
{
    precacheshellshock( "sam_dogfight" );
    precacheshellshock( "s19_cannon_ground_turret" );
}

radio_dialog_add_and_go( var_0, var_1 )
{
    maps\_utility::radio_add( var_0 );
    maps\_utility::radio_dialogue( var_0, var_1 );
}

char_dialog_add_and_go( var_0 )
{
    level.scr_sound[self.animname][var_0] = var_0;
    maps\_utility::dialogue_queue( var_0 );
}

ai_array_killcount_flag_set( var_0, var_1, var_2, var_3 )
{
    waittill_vehicles_dead( var_0, var_1, var_3 );
    common_scripts\utility::flag_set( var_2 );
}

waittill_vehicles_dead( var_0, var_1, var_2 )
{
    var_3 = [];

    foreach ( var_5 in var_0 )
    {
        if ( isalive( var_5 ) )
            var_3[var_3.size] = var_5;
    }

    var_0 = var_3;
    var_7 = spawnstruct();

    if ( isdefined( var_2 ) )
    {
        var_7 endon( "thread_timed_out" );
        var_7 thread maps\_utility::waittill_dead_timeout( var_2 );
    }

    var_7.count = var_0.size;

    if ( isdefined( var_1 ) && var_1 < var_7.count )
        var_7.count = var_1;

    common_scripts\utility::array_thread( var_0, maps\_utility::waittill_dead_thread, var_7 );

    while ( var_7.count > 0 )
        var_7 waittill( "waittill_dead guy died" );
}

plane_in_formation( var_0, var_1, var_2 )
{
    var_2 *= var_2;

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_4 = distancesquared( var_0.origin, var_1[var_3].origin );

        if ( var_4 < var_2 )
        {
            if ( vectordot( anglestoforward( var_0.angles ), anglestoforward( var_1[var_3].angles ) ) > 0 )
                return 1;
        }
    }

    return 0;
}

wait_for_formation( var_0, var_1, var_2 )
{
    var_3 = gettime() + var_2 * 1000;
    var_4 = plane_in_formation( self, var_0, var_1 );

    while ( gettime() < var_3 || !var_4 )
    {
        wait 0.1;
        var_4 = plane_in_formation( self, var_0, var_1 );

        if ( !var_4 )
            var_3 = gettime() + var_2 * 1000;
    }

    self notify( "in_formation" );
}

wait_for_formation_break( var_0, var_1, var_2 )
{
    level endon( "ignore_formation" );
    var_3 = gettime() + var_2 * 1000;
    var_4 = plane_in_formation( self, var_0, var_1 );

    while ( gettime() < var_3 || var_4 )
    {
        wait 0.1;
        var_4 = plane_in_formation( self, var_0, var_1 );

        if ( var_4 )
            var_3 = gettime() + var_2 * 1000;
    }

    self notify( "broke_formation" );
}

shoot_sam_missiles( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        thread shoot_sam_missile( var_2 );
        wait 0.2;
    }
}

shoot_sam_missile( var_0, var_1 )
{
    if ( maps\_utility::hastag( self.model, "tag_flash" ) )
    {
        var_2 = self gettagorigin( "tag_flash" );
        var_3 = var_2 + ( 0, 0, 100 );
    }
    else
    {
        var_3 = maps\df_fly_flight_code::offset_position_from_tag( "forward", "tag_origin", 200 );
        var_3 += ( 0, 0, 100 );
        var_2 = maps\df_fly_flight_code::offset_position_from_tag( "forward", "tag_origin", 50 );
    }

    if ( !isdefined( var_1 ) )
    {
        var_1 = self.origin + ( 0, 0, 12000 );
        var_1 += var_0.origin;
        var_1 /= 2;
    }

    var_4 = vectornormalize( var_1 - self.origin );
    var_5 = self.origin + var_4 * 2000;
    var_6 = magicbullet( "sam_dogfight", var_3, var_1 + ( randomfloatrange( -1000, 1000 ), randomfloatrange( -1000, 1000 ), randomfloatrange( -1000, 1000 ) ) );
    playfx( common_scripts\utility::getfx( "turret_gun_muzzle" ), var_2, vectornormalize( var_1 - var_2 ) );
    self playsound( "canyon_missile_fire_npc" );
    wait 0.25;

    if ( isdefined( var_6 ) && isvalidmissile( var_6 ) && isdefined( var_0 ) )
    {
        var_6 missile_settargetent( var_0 );
        var_6 thread maps\df_fly_flight_code::monitor_missile_death( 1, self, undefined, var_0 );
        wait 2;
    }
    else
        var_7 = 1;
}

turret_ai()
{
    var_0 = 3;
    var_1 = 0.4;
    var_2 = 3;
    var_3 = 50000.0;
    self endon( "death" );
    var_4 = isdefined( self.script_parameters ) && self.script_parameters == "missiles";
    var_5 = isdefined( self.script_parameters ) && self.script_parameters == "missiles_only";
    var_6 = isdefined( self.script_parameters ) && self.script_parameters == "none";

    if ( var_6 )
        return;

    if ( var_5 )
        var_4 = 1;

    if ( !isdefined( level.last_turret_missile_time ) )
        level.last_turret_missile_time = 0;

    while ( isalive( self ) )
    {
        var_7 = gettime();

        if ( var_4 && var_7 >= level.last_turret_missile_time + var_2 * 1000 )
            var_8 = turret_choose_targets( 5000, var_3 );
        else
            var_8 = turret_choose_targets( 0, var_3 );

        if ( var_8.size > 0 && !isremovedentity( var_8[0] ) )
        {
            var_9 = var_8[0];

            if ( var_4 && var_7 >= level.last_turret_missile_time + var_2 * 1000 && var_8.size >= 2 )
            {
                if ( var_5 )
                {
                    var_10 = [];

                    for ( var_11 = 0; var_11 < var_8.size && var_11 <= 4; var_11++ )
                        var_10[var_10.size] = var_8[var_11];

                    shoot_sam_missiles( var_10 );
                }
                else
                    shoot_sam_missiles( maps\_utility::make_array( var_8[0] ) );

                level.last_turret_missile_time = var_7;
                wait 0.2;
            }

            if ( var_5 )
            {
                wait 0.05;
                continue;
            }

            var_12 = var_7 + ( var_0 + randomfloatrange( -0.5, 0.5 ) ) * 1000;
            var_13 = vectortoangles( var_9.origin - self.origin );
            self playloopsound( "ground_turret_mgun_lp_npc" );
            self rotateto( var_13, var_12 - 1 );

            while ( var_7 < var_12 && !isremovedentity( var_9 ) )
            {
                var_14 = var_9.origin;

                if ( maps\_utility::hastag( self.model, "tag_flash" ) )
                {
                    var_15 = self gettagorigin( "tag_flash" );
                    var_16 = var_15;
                    var_17 = undefined;
                    var_18 = vectornormalize( var_14 - var_15 );
                    var_16 += var_18 * 100;
                }
                else
                {
                    var_16 = maps\df_fly_flight_code::offset_position_from_tag( "right", "tag_origin", 100 ) + ( 0, 0, 100 );
                    var_17 = maps\df_fly_flight_code::offset_position_from_tag( "left", "tag_origin", 100 ) + ( 0, 0, 100 );
                    var_15 = maps\df_fly_flight_code::offset_position_from_tag( "forward", "tag_origin", 50 ) + ( 0, 0, 100 );
                    var_18 = vectornormalize( var_14 - var_15 );
                }

                playfx( common_scripts\utility::getfx( "turret_gun_muzzle" ), var_15, var_18 );
                var_19 = magicbullet( "s19_cannon_ground_turret", var_16, var_14 );

                if ( isdefined( var_17 ) )
                {
                    wait 0.1;
                    var_19 = magicbullet( "s19_cannon_ground_turret", var_17, var_14 );
                }

                wait 0.2;
                var_7 = gettime();
            }

            self stoploopsound();
            self playsound( "ground_turret_mgun_end_npc" );
            wait(randomfloatrange( 0.2, 0.4 ));
            continue;
        }

        wait 0.2;
    }
}

turret_choose_targets( var_0, var_1 )
{
    var_0 = float( var_0 * var_0 );
    var_1 = float( var_1 * var_1 );
    var_2 = level.plane;
    var_3 = distancesquared( self.origin, level.plane.origin );
    var_4 = [ var_2 ];
    var_5 = common_scripts\utility::array_combine( level.allies, level.friend_jets );

    foreach ( var_7 in var_5 )
    {
        if ( isalive( var_7 ) )
        {
            var_8 = distancesquared( self.origin, var_7.origin );

            if ( var_8 <= var_1 && var_8 >= var_0 )
            {
                if ( var_8 < var_3 )
                {
                    var_3 = var_8;
                    var_2 = var_7;
                    var_4 = common_scripts\utility::array_insert( var_4, var_2, 0 );
                }
                else
                    var_4 = common_scripts\utility::array_add( var_4, var_2 );
            }
        }
    }

    if ( var_3 > var_1 )
    {
        var_2 = undefined;
        var_4 = [];
    }

    return var_4;
}

handle_turrets( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_wait( var_1 );
    var_3 = getentarray( var_0, "targetname" );

    if ( !isdefined( level.enemy_units ) )
        level.enemy_units = [];

    foreach ( var_5 in var_3 )
    {
        var_5 setcandamage( 1 );
        var_5 setcanradiusdamage( 1 );
        var_5.default_hud = "hud_fofbox_hostile_obstructed";
        var_5.health = 10000;
        var_5.ground_target = 1;
        level.enemy_units[level.enemy_units.size] = var_5;
        var_5 thread maps\df_fly_flight_code::hud_target_think( 500 );
        var_5 thread turret_ai();
        var_5 thread wait_for_damage();

        if ( isdefined( var_5.animation ) )
        {
            var_5.animname = "turret";
            var_5 useanimtree( level.scr_animtree[var_5.animname] );

            if ( isarray( level.scr_anim["turret"][var_5.animation] ) )
            {
                var_5 thread maps\_anim::anim_loop_solo( var_5, var_5.animation );
                continue;
            }

            var_5 playloopsound( "canyon_hover_drone_lp" );

            if ( isdefined( var_5.script_delay ) )
            {
                var_5 maps\_utility::delaythread( var_5.script_delay, maps\_anim::anim_single_solo, var_5, var_5.animation );
                continue;
            }

            var_5 thread maps\_anim::anim_single_solo( var_5, var_5.animation );
        }
    }

    common_scripts\utility::flag_wait( var_2 );
    level.enemy_units = common_scripts\utility::array_remove_array( level.enemy_units, var_3 );
    array_safe_delete( var_3 );
}

handle_flak_cannons( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_wait( var_1 );
    var_3 = getentarray( var_0, "targetname" );

    if ( !isdefined( level.enemy_units ) )
        level.enemy_units = [];

    foreach ( var_5 in var_3 )
    {
        var_5.default_hud = "hud_fofbox_hostile_obstructed";
        var_5 setcandamage( 1 );
        var_5 setcanradiusdamage( 1 );
        var_5.health = 10000;
        var_5.ground_target = 1;
        level.enemy_units[level.enemy_units.size] = var_5;
        var_5 thread maps\df_fly_flight_code::hud_target_think();
        var_5 thread wait_for_damage();
    }

    common_scripts\utility::flag_wait( var_2 );
    var_3 = maps\_utility::remove_dead_from_array( var_3 );
    level.enemy_units = common_scripts\utility::array_remove_array( level.enemy_units, var_3 );
    array_safe_delete( var_3 );
}

wait_for_damage()
{
    var_0 = 0;
    var_1 = self;

    while ( var_0 < 10 && var_1 != level.player )
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( var_1 == level.player )
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );

    if ( !isdefined( self ) )
        return;

    self notify( "kill_target_think" );

    if ( target_istarget( self ) )
    {
        target_hidefromplayer( self, level.player );
        target_remove( self );
    }

    if ( isdefined( self.animation ) && ( self.animation == "dogfight_canyon_mwp_hover" || !isarray( level.scr_anim["turret"][self.animation] ) ) )
    {
        playfx( common_scripts\utility::getfx( "bagh_aircraft_explosion_midair" ), self.origin );
        self stoploopsound();

        if ( maps\_utility::hastag( self.model, "tag_origin" ) )
            var_5 = playfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_trail_huge" ), self, "tag_origin" );
        else
            var_5 = playfx( common_scripts\utility::getfx( "bagh_aircraft_damage_trail_huge" ), self.origin );

        maps\_anim::anim_single_solo( self, "crash" );

        if ( isdefined( self ) && maps\_utility::hastag( self.model, "tag_origin" ) )
            stopfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_trail_huge" ), self, "tag_origin" );
    }
    else
        playfx( common_scripts\utility::getfx( "canyon_jet_impact" ), self.origin );

    if ( isdefined( self ) )
        self delete();
}

setup_destructibles()
{
    var_0 = getentarray( "canyon_destructible", "script_noteworthy" );
    common_scripts\utility::array_thread( var_0, ::handle_canyon_destructible );
    var_0 = getentarray( "canyon_destructible_clip", "targetname" );
    common_scripts\utility::array_thread( var_0, ::handle_canyon_destructible_clips );
    var_0 = getentarray( "canyon_turret_clip", "targetname" );
    common_scripts\utility::array_thread( var_0, ::handle_canyon_turret_clips );
}

handle_canyon_turret_clips()
{
    if ( isdefined( self.target ) && isdefined( self.script_noteworthy ) )
    {
        var_0 = getent( self.target, "script_noteworthy" );
        self linkto( var_0, self.script_noteworthy );
    }
}

handle_canyon_destructible_clips()
{
    if ( isdefined( self.target ) && isdefined( self.script_parameters ) )
    {
        var_0 = getent( self.target, "targetname" );
        self linkto( var_0, self.script_parameters );
    }
}

handle_canyon_destructible( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    var_1 = undefined;

    if ( isdefined( self.script_parameters ) )
    {
        var_2 = strtok( self.script_parameters, " " );
        var_1 = int( var_2[0] );

        if ( var_2.size > 1 )
        {
            var_3 = var_2[1];
            thread waitforhoodooflag( var_3 );
        }

        if ( var_2.size > 2 )
            var_0 = var_2[2] != "noshoot";
    }

    self.animname = self.animation;
    self useanimtree( level.scr_animtree[self.animation] );

    if ( var_0 )
    {
        self setcandamage( 1 );
        self setcanradiusdamage( 1 );
        self.health = 100;
        self.maxhealth = 100;
        thread waitforhoodoodamage();
    }

    self waittill( "fall_down" );

    if ( isdefined( var_1 ) && var_1 > 0 )
        common_scripts\_exploder::exploder( var_1 );

    soundscripts\_snd::snd_message( "destructable_destroyed", self );
    thread maps\_anim::anim_single_solo( self, "destroy" );
}

waitforhoodooflag( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    self notify( "fall_down" );
}

waitforhoodoodamage()
{
    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );
        self.health = self.maxhealth;

        if ( var_4 == "mod_projectile" || var_4 == "mod_projectile_splash" )
            continue;

        self notify( "fall_down" );
        break;
    }
}

handle_missile_jet( var_0, var_1, var_2, var_3, var_4 )
{
    common_scripts\utility::flag_wait( var_0 );
    var_5 = getent( var_1, "targetname" );
    var_6 = var_5 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_7 = var_6;
    var_8 = "tag_left_wingtip";
    var_9 = undefined;
    var_10 = common_scripts\utility::getfx( "bagh_aircraft_damage_fire_trail" );

    if ( maps\df_fly_flight_code::is_true( var_4 ) )
    {
        var_9 = maps\_utility::spawn_anim_model( "refueler" );
        var_9.origin = var_6.origin;
        var_9.angles = var_6.angles;
        var_9 linkto( var_6, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_6 hide();
        var_7 = var_9;
        var_8 = "TAG_LT_WING_LIGHT_FX";
        var_10 = common_scripts\utility::getfx( "bagh_tanker_crash" );
    }

    playfxontag( var_10, var_7, var_8 );
    var_6 waittill( "death" );
    var_6 maps\_utility::ent_flag_clear( "engineeffects" );
    stopfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_fire_trail" ), var_7, var_8 );

    if ( isdefined( var_9 ) )
        var_9 delete();

    if ( maps\df_fly_flight_code::is_true( var_3 ) )
        playfx( common_scripts\utility::getfx( "canyon_jet_impact" ), var_6.origin, anglestoforward( var_6.angles ) * -1 );

    if ( isdefined( var_6 ) )
        var_6 delete();

    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_set( var_2 );
}

fake_missile_from_behind_player( var_0, var_1, var_2, var_3, var_4 )
{
    common_scripts\utility::flag_wait( var_0 );

    if ( randomfloat( 1 ) > 0.5 )
        maps\_utility::delaythread( 0.25, ::fake_missile_from_behind_player, var_0, var_1, var_2, var_3 );

    var_5 = getent( var_1, "targetname" );

    if ( !isdefined( var_5 ) )
        return;

    var_6 = undefined;

    if ( isdefined( var_3 ) )
    {
        var_7 = getent( var_3, "targetname" );
        var_6 = var_7.origin;
    }
    else
    {
        var_6 = level.plane maps\df_fly_flight_code::offset_position_from_tag( "backward", "tag_origin", 500 );
        var_6 += ( 0, 0, 200 );
    }

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    var_8 = var_5.origin;
    var_9 = undefined;

    for ( var_10 = 0; var_10 < var_4; var_10++ )
    {
        var_9 = magicbullet( "sidewinder_atlas_jet", var_6, var_8 );
        var_9 missile_settargetent( var_5 );
        var_9 thread maps\df_fly_flight_code::monitor_missile_death( 1, self, undefined, var_5 );
        var_8 = var_5.origin + ( randomintrange( -500, 500 ), randomintrange( -500, 500 ), randomintrange( -500, 500 ) );
    }

    var_9 waittill( "explode", var_11 );

    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_set( var_2 );
}

array_safe_delete( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( !isremovedentity( var_2 ) )
            var_2 delete();
    }
}

adjust_bounce_lookahead( var_0, var_1, var_2 )
{
    var_3 = getdvarfloat( "vehPlaneCollisionLookAheadTime" );
    common_scripts\utility::flag_wait( var_1 );
    setsaveddvar( "vehPlaneCollisionLookAheadTime", var_0 );
    common_scripts\utility::flag_wait( var_2 );
    setsaveddvar( "vehPlaneCollisionLookAheadTime", var_3 );
}
