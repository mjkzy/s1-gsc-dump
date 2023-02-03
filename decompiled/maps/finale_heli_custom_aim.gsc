// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

start_heli_custom_aim( var_0 )
{
    thread select_target_think( var_0 );
    thread aim_additives_think( var_0 );
}

select_target_think( var_0 )
{
    self endon( "death" );
    self endon( var_0 );
    var_1 = getaiarray( "axis" );
    var_2 = 0;
    self.enemy_custom = var_1[var_2];
    var_3 = 0.25;
    var_4 = self.enemy_custom;

    for (;;)
    {
        if ( !isalive( var_4 ) )
        {
            self.enemy_custom = undefined;
            self.enemy_custom_fire_ok_time = gettime() + randomfloatrange( 0.15, 0.35 ) * 1000;
        }

        var_5 = getaiarray( "axis" );
        var_6 = maps\_utility::getvehiclearray();

        foreach ( var_8 in var_6 )
        {
            if ( isdefined( var_8.script_team ) && var_8.script_team == "axis" )
                var_5[var_5.size] = var_8;
        }

        var_5 = maps\_utility::array_removedead( var_5 );
        var_10 = [];

        for ( var_11 = 0; var_11 < var_5.size; var_11++ )
        {
            var_12 = var_5[var_11];

            if ( isdefined( var_12.vehicle_position ) )
                continue;

            if ( distancesquared( self.origin, var_12.origin ) > 5000000 )
                continue;

            if ( !self canshoot( var_12 getcentroid() ) )
                continue;

            if ( !within_angle( var_12, self.rightaimlimit, self.leftaimlimit, self.upaimlimit, self.downaimlimit ) )
                continue;

            var_10[var_10.size] = var_12;
        }

        var_13 = -1;
        var_14 = 9999999;

        for ( var_11 = 0; var_11 < var_10.size; var_11++ )
        {
            if ( length( self.origin - var_10[var_11].origin ) < var_14 )
            {
                var_13 = var_11;
                var_14 = length( self.origin - var_10[var_11].origin );
            }
        }

        if ( var_13 > -1 )
            self.enemy_custom = var_10[var_13];

        var_4 = self.enemy_custom;
        wait(var_3);
    }
}

within_angle( var_0, var_1, var_2, var_3, var_4 )
{
    [var_6, var_7] = get_diff_angles_from_facing( var_0 );

    if ( var_7 >= var_1 && var_7 <= var_2 && var_6 >= var_3 && var_6 <= var_4 )
        return 1;
    else
        return 0;
}

gettagangles_c( var_0 )
{
    var_1 = self gettagangles( var_0 );

    if ( var_0 == "TAG_SYNC" )
        var_1 = combineangles( var_1, ( 0, 180, 0 ) );

    return var_1;
}

get_world_pitch_yaw_between_vectors( var_0, var_1 )
{
    var_0 = vectornormalize( var_0 );
    var_2 = angleclamp360( var_0[0], var_0[1] );
    var_3 = asin( var_0[2] );
    var_1 = vectornormalize( var_1 );
    var_4 = angleclamp360( var_1[0], var_1[1] );
    var_5 = asin( var_1[2] );
    var_6 = var_1 - var_0;
    var_7 = angleclamp360( var_6[0], var_6[1] );
    var_8 = asin( var_6[2] );
    return [ var_5 - var_3, var_4 - var_2 ];
}

get_diff_angles_from_facing( var_0, var_1 )
{
    return get_diff_angles_from_tag_to_guy( "J_gun", "TAG_SYNC", var_0, var_1 );
}

get_diff_angles_from_gun( var_0, var_1 )
{
    return get_diff_angles_from_tag_to_guy( "TAG_FLASH", "TAG_FLASH", var_0, var_1 );
}

get_diff_angles_from_tag_to_guy( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 1;

    var_4 = ( 0.3, 0, 0 );
    var_5 = ( 1, 0, 0 );
    var_6 = var_2 quarter_up_position();
    var_7 = self gettagorigin( var_0 );
    var_8 = gettagangles_c( var_1 );
    var_9 = anglestoforward( var_8 );
    var_10 = var_6 - var_7;
    var_11 = vectortoangles( var_10 );
    var_12 = rotatevectorinverted( var_9, var_11 );
    var_13 = anglestoforward( ( 0, 0, 0 ) );
    [var_15, var_16] = get_world_pitch_yaw_between_vectors( var_13, var_12 );
    return [ var_15, var_16 ];
}

ender_cleanup( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self waittill( var_5 );
    self clearanim( var_0, 0 );
    self clearanim( var_1, 0 );
    self clearanim( var_2, 0 );
    self clearanim( var_3, 0 );
    self clearanim( var_4, 0 );
}

rotate_to_goal( var_0, var_1, var_2, var_3 )
{
    if ( var_1 > var_0 + 0.5 )
        var_0 += 0.5;
    else if ( var_1 < var_0 - 0.5 )
        var_0 -= 0.5;
    else
        var_0 = var_1;

    if ( var_3 > var_2 + 0.5 )
        var_2 += 0.5;
    else if ( var_3 < var_2 - 0.5 )
        var_2 -= 0.5;
    else
        var_2 = var_3;

    return [ var_0, var_2 ];
}

rotate_until_no_diff( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;
    var_5 = 0;

    if ( abs( var_3 ) < 5 )
    {
        if ( var_1 > 0 )
            var_4 = var_1 * 0.1;
        else
            var_4 = var_1 * 0.1;

        var_0 += var_4;
    }

    if ( var_3 > 0 )
        var_5 = var_3 * 0.1;
    else
        var_5 = var_3 * 0.1;

    var_2 += var_5;

    if ( var_0 < self.upaimlimit )
        var_0 = self.upaimlimit;

    if ( var_0 > self.downaimlimit )
        var_0 = self.downaimlimit;

    if ( var_2 > self.leftaimlimit )
        var_2 = self.leftaimlimit;

    if ( var_2 < self.rightaimlimit )
        var_2 = self.rightaimlimit;

    return [ var_0, var_2 ];
}

quarter_up_position()
{
    var_0 = self getcentroid()[2] - self.origin[2];
    return ( self.origin[0], self.origin[1], self.origin[2] + var_0 * 0.5 );
}

get_shoot_pos_with_offset()
{
    var_0 = quarter_up_position();

    if ( isdefined( self.vehicletype ) && self.vehicletype == "diveboat_ai" )
    {
        var_1 = randomfloatrange( -70, -50 );
        var_2 = randomfloatrange( -70, -50 );
        var_3 = 0.0;
        var_0 += ( var_1, var_2, var_3 );
    }

    return var_0;
}

heli_custom_fireuntiloutofammo( var_0, var_1, var_2 )
{
    self.heli_action_status = 1;
    self setanimlimited( var_0, 1, 0 );
    self.shootstyle = "full";
    self.shootpos = self.enemy_custom get_shoot_pos_with_offset();
    self.fastburst = 0;
    self.shootent = undefined;
    animscripts\combat_utility::fireuntiloutofammo( var_1, 0, 100 );
    self clearanim( var_1, 0 );

    if ( need_to_reload() )
        heli_custom_reload( var_0, var_2 );

    self.heli_action_status = 0;
}

need_to_reload()
{
    if ( self.bulletsinclip <= 0 )
        return 1;

    var_0 = self.bulletsinclip / weaponclipsize( self.weapon );
    var_1 = weaponclipsize( self.weapon ) - self.bulletsinclip;
    var_2 = getdvarfloat( "cg_fov" );

    if ( var_0 < 0.75 || var_1 > 50 && randomfloat( 100 ) < 100 - min( 100, var_1 ) && level.player worldpointinreticle_circle( self.origin, var_2, 250 ) )
        return 1;
    else
        return 0;
}

heli_custom_reload( var_0, var_1 )
{
    self.heli_action_status = 2;
    self setanimlimited( var_0, 1, 0 );
    var_2 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
    self setflaggedanimknobrestart( var_2, var_1, 1, 0.2 );
    animscripts\shared::donotetracks( var_2 );
    self notify( "abort_reload" );
    animscripts\weaponlist::refillclip();
    self clearanim( var_1, 0 );
    self.heli_action_status = 0;
}

#using_animtree("generic_human");

aim_additives_think( var_0 )
{
    self endon( "death" );
    self endon( var_0 );
    var_1 = %fin_flying_mech_aim_6;
    var_2 = %fin_flying_mech_firing_right;
    var_3 = %fin_flying_mech_aim_4;
    var_4 = %fin_flying_mech_firing_left;
    var_5 = %fin_flying_mech_aim_8;
    var_6 = %fin_flying_mech_firing_aim_up;
    var_7 = %fin_flying_mech_aim_2;
    var_8 = %fin_flying_mech_firing_down;
    var_9 = %fin_flying_mech_action_root;
    var_10 = %fin_flying_mech_firing_fire_auto;
    var_11 = %fin_flying_mech_firing_reload;
    [var_13, var_14, var_15, var_16] = get_aim_limits( var_1, var_3, var_5, var_7, var_2, var_4, var_6, var_8, 1 );
    self.rightaimlimit = var_13;
    self.leftaimlimit = var_14;
    self.upaimlimit = var_15;
    self.downaimlimit = var_16;
    thread ender_cleanup( var_1, var_3, var_5, var_7, var_9, var_0 );
    self setanim( var_3, 0.01, 0 );
    self setanim( var_4, 1, 0 );
    self setanimtime( var_4, 1.0 );
    self setanim( var_1, 0.01, 0 );
    self setanim( var_2, 1, 0 );
    self setanimtime( var_2, 1.0 );
    self setanim( var_7, 0.01, 0 );
    self setanim( var_8, 1, 0 );
    self setanimtime( var_8, 1.0 );
    self setanim( var_5, 0.01, 0 );
    self setanim( var_6, 1, 0 );
    self setanimtime( var_6, 1.0 );
    var_17 = 0;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
    var_21 = 999;
    var_22 = 999;
    self.heli_action_status = 0;
    self.enemy_custom_fire_ok_time = 0;
    var_23 = 0.1;

    if ( isdefined( self.aimblendtime ) )
        var_23 = self.aimblendtime;

    for (;;)
    {
        if ( isdefined( self.enemy_custom ) )
            [var_21, var_22] = get_diff_angles_from_gun( self.enemy_custom, 0 );
        else
        {
            var_21 = 0;
            var_22 = 0;
        }

        if ( isdefined( self.enemy_custom ) && gettime() > self.enemy_custom_fire_ok_time && abs( var_21 ) < 10.0 && abs( var_22 ) < 10.0 )
        {
            if ( self.heli_action_status == 0 )
                childthread heli_custom_fireuntiloutofammo( var_9, var_10, var_11 );
        }
        else if ( self.heli_action_status == 1 )
        {
            self notify( "enemy" );

            if ( self getanimweight( var_10 ) > 0 )
                self clearanim( var_10, 0 );

            self.heli_action_status = 0;
        }

        if ( self.heli_action_status != 2 )
        {
            if ( abs( var_21 ) > 0 || abs( var_22 ) > 0 )
                [var_20, var_19] = rotate_until_no_diff( var_20, var_21, var_19, var_22 );

            if ( isdefined( var_20 ) )
            {
                if ( var_20 == 0 )
                {
                    self setanim( var_7, 0.001, 0.05, 1, 1 );
                    self setanim( var_5, 0.001, 0.05, 1, 1 );
                }
                else if ( var_20 < 0 )
                {
                    self setanim( var_7, 0.001, 0.05, 1, 1 );
                    self setanim( var_5, absz( var_20 / self.upaimlimit ), 0.05, 1, 1 );
                }
                else
                {
                    self setanim( var_7, absz( var_20 / self.downaimlimit ), 0.05, 1, 1 );
                    self setanim( var_5, 0.001, 0.05, 1, 1 );
                }
            }

            if ( isdefined( var_19 ) )
            {
                if ( var_19 == 0 )
                {
                    self setanim( var_3, 0.001, 0.05, 1, 1 );
                    self setanim( var_1, 0.001, 0.05, 1, 1 );
                }
                else if ( var_19 > 0 )
                {
                    self setanim( var_3, absz( var_19 / self.leftaimlimit ), 0.05, 1, 1 );
                    self setanim( var_1, 0.001, 0.05, 1, 1 );
                }
                else
                {
                    self setanim( var_3, 0.001, 0.05, 1, 1 );
                    self setanim( var_1, absz( var_19 / self.rightaimlimit ), 0.05, 1, 1 );
                }
            }
        }

        self setanimtime( var_2, 1.0 );
        self setanimtime( var_4, 1.0 );
        self setanimtime( var_6, 1.0 );
        self setanimtime( var_8, 1.0 );
        waitframe();
    }
}

absz( var_0 )
{
    var_0 = abs( var_0 );

    if ( var_0 > 1 )
        var_0 = 1;

    if ( var_0 == 0 )
        return 0.001;
    else
        return var_0;
}

get_aim_limits( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = 1;
    var_10 = get_limit_table( var_0, var_4, 1, var_8, var_9 );
    var_11 = get_limit_table( var_1, var_5, 1, var_8, var_9 );
    var_12 = get_limit_table( var_2, var_6, 0, var_8, var_9 );
    var_13 = get_limit_table( var_3, var_7, 0, var_8, var_9 );
    var_14 = float( getfirstarraykey( var_10 ) );
    var_15 = float( getfirstarraykey( var_11 ) );
    var_16 = float( getfirstarraykey( var_12 ) );
    var_17 = float( getfirstarraykey( var_13 ) );
    self.dummy_model delete();
    return [ var_14, var_15, var_16, var_17 ];
}

get_limit( var_0, var_1, var_2, var_3, var_4 )
{
    return get_limit_table( var_0, var_1, var_2, var_3, 1 );
}

get_limit_table( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;

    if ( !isdefined( var_3 ) || var_3 )
    {
        if ( !isdefined( self.dummy_model ) )
        {
            self.dummy_model = maps\_utility::spawn_anim_model( self.animname, ( 0, -300, 0 ), ( 0, 0, 0 ) );

            if ( isdefined( self.weapon ) )
            {
                var_6 = getweaponmodel( self.weapon );
                self.dummy_model attach( var_6, "tag_weapon_right" );
                self.dummy_model maps\_utility::update_weapon_tag_visibility( self.weapon );
            }

            if ( var_4 )
                self.dummy_model hide();

            self.dummy_model thread maps\_anim::anim_first_frame_solo( self.dummy_model, "intro_flyin_idle_test" );
        }

        var_5 = self.dummy_model;
    }
    else
        var_5 = self;

    var_7 = 0.025;
    var_8 = [];
    var_9 = 0;
    var_10 = 1.0;

    if ( !isdefined( var_1 ) || !isdefined( var_0 ) )
    {
        var_8["0"] = 0;
        var_8["1"] = 0;
        return var_8;
    }

    var_5 setanimlimited( var_0, 1.0, 0 );
    var_5 setanimknoblimited( var_1, 1.0, 0 );
    var_5 setanimtime( var_1, 1.0 );

    while ( var_10 >= 0.0 )
    {
        var_5 setanimlimited( var_0, var_10, 0 );
        waitframe();
        var_11 = var_5 gettagangles( "TAG_FLASH" );
        var_12 = var_5.angles;
        var_13 = invertangles( var_12 );
        var_14 = combineangles( var_11, var_13 );
        var_8[maps\_utility::string( angleclamp180( var_14[var_2] ) )] = var_10;
        var_10 = 1.0 - var_9 * var_7;
        var_9++;

        if ( var_4 )
            break;
    }

    var_5 clearanim( var_0, 0 );
    return var_8;
}
