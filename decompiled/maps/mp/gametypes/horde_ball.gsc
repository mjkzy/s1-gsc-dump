// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_8039()
{
    level.ball_starts = [];
    level.goal_starts = [];
    level.balls = [];
    level._id_4250 = [];
    ball_create_goals();
    ball_create_ball_starts();
    ball_init_map_min_max();
    level._effect["ball_trail"] = loadfx( "vfx/trail/vfx_uplink_ball_trl" );
    level._effect["ball_idle"] = loadfx( "vfx/unique/vfx_uplink_ball_idle" );
    level._effect["ball_download"] = loadfx( "vfx/trail/vfx_uplink_ball_trl2" );
    level._effect["ball_download_end"] = loadfx( "vfx/unique/vfx_uplink_ball_impact" );
    level._effect["ball_goal_enemy"] = loadfx( "vfx/unique/vfx_uplink_goal" );
    level._effect["ball_goal_friendly"] = loadfx( "vfx/unique/vfx_uplink_goal_friendly" );
    level._effect["ball_goal_activated_enemy"] = loadfx( "vfx/unique/vfx_uplink_ball_score" );
    level._effect["ball_goal_activated_friendly"] = loadfx( "vfx/unique/vfx_uplink_ball_score_friendly" );
    level._effect["ball_teleport"] = loadfx( "vfx/unique/vfx_uplink_ball_glow" );
    level._effect["ball_physics_impact"] = loadfx( "vfx/treadfx/footstep_dust" );
    level.horde_ball_score_count = 5;
    level.horde_ball_score = 0;
    setomnvar( "ui_uplink_num_balls", 1 );
}

ball_create_ball_starts()
{
    var_0 = common_scripts\utility::getstructarray( "ball_start", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, common_scripts\utility::getstructarray( "ball_start_non_augmented", "targetname" ) );
    var_0 = common_scripts\utility::array_combine( var_0, common_scripts\utility::getstructarray( "horde_collect", "targetname" ) );

    foreach ( var_2 in var_0 )
        ball_add_start( var_2.origin );
}

ball_add_start( var_0 )
{
    var_1 = 30;
    var_2 = spawnstruct();
    var_2.origin = var_0 + ( 0, 0, var_1 );
    var_2.in_use = 0;
    var_3 = undefined;
    var_4 = -1;

    foreach ( var_6 in level.goal_starts )
    {
        var_7 = 99999999;
        var_7 = min( var_7, _func_220( var_2.origin, var_6.origin ) );

        if ( var_7 > var_4 )
        {
            var_4 = var_7;
            var_3 = var_6;
        }
    }

    var_2.preferred_goal = var_3;
    level.ball_starts[level.ball_starts.size] = var_2;
}

ball_init_map_min_max()
{
    level.ball_mins = ( 1000.0, 1000.0, 1000.0 );
    level.ball_maxs = ( -1000.0, -1000.0, -1000.0 );
    var_0 = getallnodes();

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
        {
            level.ball_mins = maps\mp\gametypes\_spawnlogic::expandmins( level.ball_mins, var_2.origin );
            level.ball_maxs = maps\mp\gametypes\_spawnlogic::expandmaxs( level.ball_maxs, var_2.origin );
        }
    }
    else
    {
        level.ball_mins = level.spawnmins;
        level.ball_maxs = level.spawnmaxs;
    }
}

ball_create_goals()
{
    var_0 = common_scripts\utility::getstructarray( "ball_goal_allies", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, common_scripts\utility::getstructarray( "ball_goal_axis", "targetname" ) );

    foreach ( var_2 in var_0 )
    {
        var_2.radius = 70;
        var_2.team = "axis";
        var_2.ball_in_goal = 0;
    }

    level.goal_starts = var_0;
}

run_horde_ball()
{
    level endon( "uplink_completed" );
    level.horde_ball_score = 0;
    var_0 = 0;

    while ( level.horde_ball_score < level.horde_ball_score_count )
    {
        level notify( "next_horde_ball" );
        ball_spawn( var_0 );
        var_0 = 1;
        level waittill( "horde_ball_scored" );
        horde_ball_cleanup();
        wait 1.0;
    }
}

ball_spawn( var_0 )
{
    var_1 = common_scripts\utility::random( level.ball_starts );
    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( "prop_drone_sphere" );
    var_2 thread physics_impact_watch();
    var_3 = 24;
    var_4 = getent( "ball_pickup_1", "targetname" );

    if ( isdefined( var_4 ) )
        var_4.origin = var_2.origin;
    else
        var_4 = spawn( "trigger_radius", var_2.origin - ( 0, 0, var_3 / 2 ), 0, var_3, var_3 );

    if ( !isdefined( var_4.linkto_on ) )
    {
        var_4 enablelinkto();
        var_4.linkto_on = 1;
    }

    var_4 linkto( var_2 );
    var_4.no_moving_platfrom_unlink = 1;
    var_5 = maps\mp\gametypes\_gameobjects::createcarryobject( "any", var_4, [ var_2 ], ( 0.0, 0.0, 32.0 ) );
    var_5.objectiveonvisuals = 1;
    var_5 maps\mp\gametypes\_gameobjects::allowcarry( "any" );
    var_5 ball_waypoint_neutral();
    var_5 maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
    var_5.objidpingenemy = 1;
    var_5.objpingdelay = 1.0;
    var_5.allowweapons = 0;
    var_5.carryweapon = "iw5_carrydrone_mp";
    var_5.keepcarryweapon = 1;
    var_5.waterbadtrigger = 0;
    var_5.visualgroundoffset = ( 0.0, 0.0, 30.0 );
    var_5.canuseobject = ::ball_can_pickup;
    var_5.onpickup = ::ball_on_pickup;
    var_5.setdropped = ::ball_set_dropped;
    var_5.onreset = ::ball_on_reset;
    var_5.carryweaponthink = ::ball_pass_shoot_watch;
    var_5.in_goal = 0;
    var_5.lastcarrierscored = 0;
    var_5.requireslos = 1;
    var_5 ball_assign_start( var_1 );
    level.balls = [ var_5 ];
    var_5 ball_fx_start();

    if ( var_0 )
        thread _id_A793::_id_49A7( "coop_gdn_satellite_incoming", "horde", 1, 1 );

    var_5 ball_on_reset( 1 );
    level goal_spawn( var_1 );
    var_5 thread ball_location_hud( 0 );
}

ball_assign_start( var_0 )
{
    foreach ( var_2 in self.visuals )
        var_2.baseorigin = var_0.origin;

    self.trigger.baseorigin = var_0.origin;

    if ( isdefined( self.current_start ) )
        self.current_start.in_use = 0;

    self.current_start = var_0;
    var_0.in_use = 1;
}

ball_location_hud( var_0 )
{
    self endon( "death" );
    level endon( "next_horde_ball" );

    if ( var_0 > 4 || var_0 < 0 )
        return;

    for (;;)
    {
        var_1 = common_scripts\utility::waittill_any_return( "pickup_object", "dropped", "reset" );

        switch ( var_1 )
        {
            case "pickup_object":
                if ( isplayer( self.carrier ) )
                    setomnvar( "ui_uplink_ball_carrier" + ( var_0 + 1 ), self.carrier getentitynumber() );

                continue;
            case "dropped":
                setomnvar( "ui_uplink_ball_carrier" + ( var_0 + 1 ), -2 );
                continue;
            case "reset":
                setomnvar( "ui_uplink_ball_carrier" + ( var_0 + 1 ), -1 );
                continue;
            default:
                continue;
        }
    }
}

ball_fx_active()
{
    return isdefined( self.ball_fx_active ) && self.ball_fx_active;
}

ball_fx_start()
{
    if ( !ball_fx_active() )
    {
        var_0 = self.visuals[0];
        playfxontag( common_scripts\utility::getfx( "ball_trail" ), var_0, "tag_origin" );
        playfxontag( common_scripts\utility::getfx( "ball_idle" ), var_0, "tag_origin" );
        self.ball_fx_active = 1;
    }
}

ball_fx_stop()
{
    if ( ball_fx_active() )
    {
        var_0 = self.visuals[0];
        stopfxontag( common_scripts\utility::getfx( "ball_trail" ), var_0, "tag_origin" );
        killfxontag( common_scripts\utility::getfx( "ball_idle" ), var_0, "tag_origin" );
    }

    self.ball_fx_active = 0;
}

goal_spawn( var_0 )
{
    var_1 = var_0.preferred_goal;
    var_1 set_goal_useobject();
    var_1 start_goal_fx();
    level._id_4250 = [ var_1 ];
}

set_goal_useobject()
{
    self.trigger = spawn( "trigger_radius", self.origin - ( 0, 0, self.radius ), 0, self.radius, self.radius * 2 );
    self.useobject = maps\mp\gametypes\_gameobjects::createuseobject( self.team, self.trigger, [], ( 0, 0, self.radius * 2.1 ) );
    self.useobject.goal = self;
    self.useobject maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "waypoint_ball_goal" );
    self.useobject maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_ball_goal" );
    self.useobject maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
    self.useobject maps\mp\gametypes\_gameobjects::allowuse( "enemy" );
    self.useobject maps\mp\gametypes\_gameobjects::setkeyobject( level.balls );
    self.useobject maps\mp\gametypes\_gameobjects::setusetime( 0 );
    self.useobject.onuse = ::ball_carrier_touched_goal;
    self.useobject.canuseobject = ::ball_goal_can_use;
}

start_goal_fx()
{
    self.score_fx["friendly"] = spawnfx( common_scripts\utility::getfx( "ball_goal_activated_friendly" ), self.origin, ( 1.0, 0.0, 0.0 ) );
    self.score_fx["enemy"] = spawnfx( common_scripts\utility::getfx( "ball_goal_activated_enemy" ), self.origin, ( 1.0, 0.0, 0.0 ) );
    thread ball_play_fx_joined_team();

    foreach ( var_1 in level.players )
        ball_goal_fx_for_player( var_1 );
}

ball_play_fx_joined_team()
{
    level endon( "next_horde_ball" );
    level endon( "uplink_completed" );

    for (;;)
    {
        level waittill( "joined_team", var_0 );
        ball_goal_fx_for_player( var_0 );
    }
}

ball_goal_fx_for_player( var_0 )
{
    var_1 = ball_get_view_team( var_0 );
    var_0 player_delete_ball_goal_fx();
    var_2 = common_scripts\utility::ter_op( self.team == var_1, "ball_goal_friendly", "ball_goal_enemy" );
    var_3 = _func_272( common_scripts\utility::getfx( var_2 ), self.origin, var_0, ( 1.0, 0.0, 0.0 ) );
    setwinningteam( var_3, 1 );
    var_0.ball_goal_fx[var_2] = var_3;
    triggerfx( var_3 );
}

player_delete_ball_goal_fx()
{
    if ( !isdefined( self.ball_goal_fx ) )
        return;

    foreach ( var_1 in self.ball_goal_fx )
    {
        if ( isdefined( var_1 ) )
            var_1 delete();
    }
}

horde_ball_cleanup()
{
    level notify( "stop_horde_ball" );

    foreach ( var_1 in level.balls )
    {
        if ( isdefined( var_1.carrier ) )
            var_1 ball_set_dropped( 1 );

        var_1 thread delete_horde_ball();
    }

    level.balls = [];

    foreach ( var_4 in level._id_4250 )
    {
        var_4.useobject maps\mp\gametypes\_gameobjects::set2dicon( "enemy", undefined );
        var_4.useobject maps\mp\gametypes\_gameobjects::set3dicon( "enemy", undefined );
        var_4.useobject maps\mp\gametypes\_gameobjects::deleteuseobject();
    }

    foreach ( var_7 in level.players )
        var_7 player_delete_ball_goal_fx();

    level._id_4250 = [];
}

delete_horde_ball()
{
    while ( isdefined( self.in_goal ) && self.in_goal == 1 )
        wait 0.05;

    if ( isdefined( self.projectile ) )
        self.projectile delete();

    ball_fx_stop();
    ball_waypoint_clear();
    maps\mp\gametypes\_gameobjects::deletecarryobject();
}

ball_waypoint_neutral()
{
    maps\mp\gametypes\_gameobjects::set2dicon( "friendly", "waypoint_ball" );
    maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "waypoint_ball" );
    maps\mp\gametypes\_gameobjects::set3dicon( "friendly", "waypoint_ball" );
    maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_ball" );
}

ball_waypoint_held()
{
    maps\mp\gametypes\_gameobjects::set2dicon( "friendly", "waypoint_ball_friendly" );
    maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "waypoint_ball_enemy" );
    maps\mp\gametypes\_gameobjects::set3dicon( "friendly", "waypoint_ball_friendly" );
    maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_ball_enemy" );
}

ball_waypoint_upload()
{
    maps\mp\gametypes\_gameobjects::set2dicon( "friendly", "waypoint_ball_upload" );
    maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "waypoint_ball_upload" );
    maps\mp\gametypes\_gameobjects::set3dicon( "friendly", "waypoint_ball_upload" );
    maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_ball_upload" );
}

ball_waypoint_download()
{
    maps\mp\gametypes\_gameobjects::set2dicon( "friendly", "waypoint_ball_download" );
    maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "waypoint_ball_download" );
    maps\mp\gametypes\_gameobjects::set3dicon( "friendly", "waypoint_ball_download" );
    maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_ball_download" );
}

ball_waypoint_clear()
{
    maps\mp\gametypes\_gameobjects::set2dicon( "friendly", undefined );
    maps\mp\gametypes\_gameobjects::set2dicon( "enemy", undefined );
    maps\mp\gametypes\_gameobjects::set3dicon( "friendly", undefined );
    maps\mp\gametypes\_gameobjects::set3dicon( "enemy", undefined );
}

ball_play_local_team_sound( var_0, var_1, var_2 )
{
    var_3 = maps\mp\_utility::getotherteam( var_0 );

    foreach ( var_5 in level.players )
    {
        if ( var_5.team == var_0 )
        {
            var_5 playlocalsound( var_1 );
            continue;
        }

        if ( var_5.team == var_3 )
            var_5 playlocalsound( var_2 );
    }
}

ball_score_sound( var_0 )
{
    ball_play_local_team_sound( var_0, "mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg" );
}

physics_impact_watch()
{
    self endon( "death" );
    level endon( "uplink_completed" );

    for (;;)
    {
        self waittill( "physics_impact", var_0, var_1, var_2, var_3 );
        var_4 = level._effect["ball_physics_impact"];

        if ( isdefined( var_3 ) && isdefined( level._effect["ball_physics_impact_" + var_3] ) )
            var_4 = level._effect["ball_physics_impact_" + var_3];

        playfx( var_4, var_0, var_1 );
        wait 0.3;
    }
}

ball_can_pickup( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isdefined( var_0.underwater ) && var_0.underwater )
        return 0;

    if ( isdefined( self.droptime ) && self.droptime >= gettime() )
        return 0;

    if ( isdefined( var_0.agent_type ) && var_0.agent_type == "dog" )
        return 0;

    if ( !var_0 common_scripts\utility::isweaponenabled() )
        return 0;

    if ( var_0 isusingturret() )
        return 0;

    if ( isdefined( var_0.manuallyjoiningkillstreak ) && var_0.manuallyjoiningkillstreak )
        return 0;

    if ( isdefined( var_0.using_remote_turret ) && var_0.using_remote_turret )
        return 0;

    if ( isdefined( var_0.inlaststand ) && var_0.inlaststand )
        return 0;

    if ( isdefined( var_0.usingarmory ) && var_0.usingarmory )
        return 0;

    var_1 = var_0 getcurrentweapon();

    if ( isdefined( var_1 ) )
    {
        if ( !valid_ball_pickup_weapon( var_1 ) )
            return 0;
    }

    var_2 = var_0.changingweapon;

    if ( isdefined( var_2 ) && var_0 isswitchingweapon() )
    {
        if ( !valid_ball_pickup_weapon( var_2 ) )
            return 0;
    }

    if ( isdefined( var_0.exo_shield_on ) && var_0.exo_shield_on == 1 )
        return 0;

    if ( var_0 maps\mp\_utility::isjuggernaut() )
        return 0;

    if ( var_0 player_no_pickup_time() )
        return 0;

    return 1;
}

valid_ball_pickup_weapon( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    if ( var_0 == "iw5_carrydrone_mp" )
        return 0;

    if ( maps\mp\_utility::iskillstreakweapon( var_0 ) )
        return 0;

    if ( var_0 == "iw5_combatknifegoliath_mp" )
        return 0;

    return 1;
}

player_no_pickup_time()
{
    return isdefined( self.nopickuptime ) && self.nopickuptime > gettime();
}

ball_on_pickup( var_0 )
{
    var_1 = self.visuals[0] getlinkedparent();

    if ( isdefined( var_1 ) )
        self.visuals[0] unlink();

    self.visuals[0] physicsstop();
    self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
    self.visuals[0] show();
    self.visuals[0] ghost();
    self.trigger maps\mp\_movers::stop_handling_moving_platforms();
    self.current_start.in_use = 0;
    var_2 = 0;

    if ( isdefined( self.projectile ) )
    {
        var_2 = 1;
        self.projectile delete();
    }

    var_3 = var_0.team;
    var_4 = maps\mp\_utility::getotherteam( var_0.team );

    if ( !var_2 )
    {
        if ( isplayer( var_0 ) )
            thread _id_A793::_id_49A7( "coop_gdn_satellite_acquire", "horde", 1, 1 );
        else
            thread _id_A793::_id_49A7( "coop_gdn_satellite_enemy", "horde", 1, 1 );
    }
    else if ( self.lastcarrierteam != var_0.team && isbot( var_0 ) )
        thread _id_A793::_id_49A7( "coop_gdn_satellite_intercept", "horde", 1, 1 );

    var_0 playsound( "mp_ul_ball_catch" );
    ball_play_local_team_sound( var_3, "mp_obj_notify_pos_sml", "mp_obj_notify_neg_sml" );
    ball_fx_stop();
    self.lastcarrierscored = 0;
    self.lastcarrier = var_0;
    self.lastcarrierteam = var_0.team;
    self.ownerteam = var_0.team;
    ball_waypoint_held();
    var_0 setweaponammoclip( "iw5_carrydrone_mp", 1 );
    var_0 maps\mp\_utility::giveperk( "specialty_ballcarrier", 0 );
    var_0.ball_carried = self;
    var_0.objective = 1;
    var_0.hasperksprintfire = var_0 hasperk( "specialty_sprintfire", 1 );
    var_0 maps\mp\_utility::giveperk( "specialty_sprintfire", 0 );
    var_0 common_scripts\utility::_disableusability();
    var_0 maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
    var_0 thread player_update_pass_target( self );
    var_0 thread player_drop_on_last_stand();
    maps\mp\gametypes\_gamelogic::sethasdonecombat( var_0, 1 );
}

player_drop_on_last_stand()
{
    self endon( "death" );
    self.ball_carried endon( "dropped" );
    level endon( "uplink_completed" );
    self waittill( "player_start_last_stand" );

    if ( isdefined( self.ball_carried ) )
    {
        thread _id_A793::_id_49A7( "coop_gdn_satellite_lost", "horde", 1, 1 );
        self.ball_carried thread ball_set_dropped( 1 );
    }
}

player_update_pass_target( var_0 )
{
    self endon( "disconnect" );
    self endon( "cancel_update_pass_target" );
    level endon( "uplink_completed" );

    if ( !isdefined( self ) || isbot( self ) )
        return;

    player_update_pass_target_hudoutline();
    childthread player_joined_update_pass_target_hudoutline();
    var_1 = 0.2;

    for (;;)
    {
        var_2 = undefined;

        if ( !self isonladder() )
        {
            var_3 = anglestoforward( self getangles() );
            var_4 = self geteye();
            var_5 = [];

            foreach ( var_7 in level.players )
            {
                if ( var_7.team != self.team )
                    continue;

                if ( !maps\mp\_utility::isreallyalive( var_7 ) )
                    continue;

                if ( !var_0 ball_can_pickup( var_7 ) )
                    continue;

                var_8 = var_7 geteye();
                var_9 = distancesquared( var_8, var_4 );

                if ( var_9 > 1000000 )
                    continue;

                var_10 = vectornormalize( var_8 - var_4 );
                var_11 = vectordot( var_3, var_10 );

                if ( var_11 > var_1 )
                {
                    var_7.pass_dot = var_11;
                    var_7.pass_origin = var_8;
                    var_5[var_5.size] = var_7;
                }
            }

            var_5 = maps\mp\_utility::quicksort( var_5, ::compare_player_pass_dot );

            foreach ( var_7 in var_5 )
            {
                if ( sighttracepassed( var_4, var_7.pass_origin, 0, self, var_7 ) )
                {
                    var_2 = var_7;
                    break;
                }
            }
        }

        player_set_pass_target( var_2 );
        waitframe();
    }
}

compare_player_pass_dot( var_0, var_1 )
{
    return var_0.pass_dot >= var_1.pass_dot;
}

player_update_pass_target_hudoutline()
{
    var_0 = [];
    var_1 = [];

    foreach ( var_3 in level.participants )
    {
        if ( isplayer( var_3 ) )
        {
            var_0 = common_scripts\utility::array_add( var_0, var_3 );
            continue;
        }

        var_1 = common_scripts\utility::array_add( var_1, var_3 );
    }

    foreach ( var_6 in var_0 )
    {
        if ( isplayer( self ) && var_6 != self )
        {
            self hudoutlinedisableforclient( var_6 );

            if ( !isdefined( var_6.inlaststand ) || !var_6.inlaststand )
                var_6 hudoutlinedisableforclient( self );
        }

        if ( var_6 maps\mp\_utility::isjuggernaut() )
            continue;

        if ( level._id_2509 < 3 )
            continue;

        foreach ( var_8 in var_1 )
            var_8 hudoutlinedisableforclient( var_6 );
    }

    if ( isdefined( self.carryobject ) )
    {
        if ( isplayer( self ) )
        {
            foreach ( var_6 in var_0 )
            {
                if ( var_6 == self )
                    continue;

                if ( var_6 maps\mp\_utility::isjuggernaut() )
                    continue;

                if ( isdefined( var_6.inlaststand ) && var_6.inlaststand )
                    continue;

                if ( isdefined( self.pass_target ) && self.pass_target == var_6 )
                {
                    self hudoutlineenableforclient( var_6, 1, 0 );
                    var_6 hudoutlineenableforclient( self, 1, 0 );
                    continue;
                }

                self hudoutlineenableforclient( var_6, 5, 0 );
                var_6 hudoutlineenableforclient( self, 5, 0 );
            }

            if ( level._id_2509 >= 3 )
            {
                foreach ( var_8 in var_1 )
                    var_8 hudoutlineenableforclient( self, 3, 1 );

                return;
            }
        }
        else
        {
            foreach ( var_6 in var_0 )
            {
                if ( var_6 maps\mp\_utility::isjuggernaut() )
                    continue;

                if ( level._id_2509 < 3 )
                    continue;

                self hudoutlineenableforclient( var_6, 0, 0 );
            }
        }
    }
}

player_joined_update_pass_target_hudoutline()
{
    self endon( "cancel_update_pass_target" );
    level endon( "uplink_completed" );

    for (;;)
    {
        level common_scripts\utility::waittill_any( "participant_added", "player_joined", "player_last_stand" );
        player_update_pass_target_hudoutline();
    }
}

player_set_pass_target( var_0 )
{
    if ( isdefined( self.pass_target ) && isdefined( var_0 ) && self.pass_target == var_0 )
        return;

    if ( !isdefined( self.pass_target ) && !_func_294( self.pass_target ) && !isdefined( var_0 ) )
        return;

    player_clear_pass_target();

    if ( isdefined( var_0 ) )
    {
        var_1 = ( 0.0, 0.0, 80.0 );
        self.pass_icon = var_0 maps\mp\_entityheadicons::setheadicon( self, "waypoint_ball_pass", var_1, 10, 10, 0, 0.05, 0, 1, 0, 0, "tag_origin" );
        self.pass_target = var_0;
        self setclientomnvar( "ui_uplink_can_pass", 1 );
        self setballpassallowed( 1 );
    }

    player_update_pass_target_hudoutline();
}

player_clear_pass_target()
{
    if ( isdefined( self.pass_icon ) )
        self.pass_icon destroy();

    self setclientomnvar( "ui_uplink_can_pass", 0 );
    self.pass_target = undefined;
    self setballpassallowed( 0 );
    player_update_pass_target_hudoutline();
}

ball_set_dropped( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    self.isresetting = 1;
    self.droptime = gettime();
    self notify( "dropped" );
    waittillframeend;
    var_1 = self.carrier;

    if ( isdefined( var_1 ) && var_1.team != "spectator" )
        var_2 = var_1.origin;
    else
        var_2 = self.safeorigin;

    var_2 += ( 0.0, 0.0, 40.0 );
    var_3 = ( 0.0, 0.0, 0.0 );

    for ( var_4 = 0; var_4 < self.visuals.size; var_4++ )
    {
        self.visuals[var_4].origin = var_2;
        self.visuals[var_4].angles = var_3;
        self.visuals[var_4] show();
    }

    self.trigger.origin = var_2;
    ball_dont_interpolate();
    self.curorigin = self.trigger.origin;
    ball_carrier_cleanup();
    ball_fx_start();
    self.ownerteam = "any";
    ball_waypoint_neutral();

    if ( isdefined( var_1 ) )
        var_1 player_update_pass_target_hudoutline();

    maps\mp\gametypes\_gameobjects::updatecompassicons();
    maps\mp\gametypes\_gameobjects::updateworldicons();
    self.isresetting = 0;

    if ( !var_0 )
        ball_physics_launch( ( 0.0, 0.0, 80.0 ) );

    var_5 = spawnstruct();
    var_5.carryobject = self;
    var_5.deathoverridecallback = ::ball_overridemovingplatformdeath;
    self.trigger thread maps\mp\_movers::handle_moving_platforms( var_5 );
    return 1;
}

ball_overridemovingplatformdeath( var_0 )
{

}

ball_dont_interpolate()
{
    self.visuals[0] dontinterpolate();
    self.ball_fx_active = 0;
}

ball_carrier_cleanup()
{
    if ( isdefined( self.carrier ) )
    {
        self.carrier.nopickuptime = gettime() + 500;
        self.carrier player_clear_pass_target();
        self.carrier notify( "cancel_update_pass_target" );
        self.carrier setballpassallowed( 0 );
        self.carrier setclientomnvar( "ui_uplink_can_pass", 0 );
        self.carrier maps\mp\_utility::_unsetperk( "specialty_ballcarrier" );

        if ( !self.carrier.hasperksprintfire )
            self.carrier maps\mp\_utility::_unsetperk( "specialty_sprintfire" );

        self.carrier common_scripts\utility::_enableusability();
        self.carrier maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
        self.carrier.objective = 0;
        var_0 = self.carrier;
        maps\mp\gametypes\_gameobjects::clearcarrier();
        var_0.ball_carried = undefined;
    }
}

ball_on_reset( var_0 )
{
    if ( !( isdefined( var_0 ) && var_0 ) )
    {
        ball_assign_random_start();
        thread _id_A793::_id_49A7( "coop_gdn_satellite_reset", "horde", 1, 1 );
    }

    var_1 = self.visuals[0];
    var_1 maps\mp\_movers::notify_moving_platform_invalid();
    var_2 = var_1 getlinkedparent();

    if ( isdefined( var_2 ) )
        var_1 unlink();

    var_1 physicsstop();
    ball_dont_interpolate();

    if ( isdefined( self.projectile ) )
        self.projectile delete();

    var_3 = "none";
    var_4 = self.lastcarrierteam;

    if ( isdefined( var_4 ) )
        var_3 = maps\mp\_utility::getotherteam( var_4 );

    ball_carrier_cleanup();
    self.trigger maps\mp\_movers::stop_handling_moving_platforms();
    ball_waypoint_download();
    maps\mp\gametypes\_gameobjects::setposition( var_1.baseorigin + ( 0.0, 0.0, 4000.0 ), ( 0.0, 0.0, 0.0 ) );
    var_5 = 3;
    var_1 moveto( var_1.baseorigin, var_5, 0, var_5 );
    var_1 rotatevelocity( ( 0.0, 720.0, 0.0 ), var_5, 0, var_5 );

    if ( !( isdefined( var_0 ) && var_0 ) )
        playsoundatpos( var_1.baseorigin, "uplink_ball_reset" );

    self.ownerteam = "any";
    thread ball_download_fx( var_1, var_5 );
    thread ball_download_wait( var_5 );
}

ball_assign_random_start()
{
    var_0 = undefined;
    var_1 = common_scripts\utility::array_randomize( level.ball_starts );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.in_use )
            continue;

        var_0 = var_3;
        break;
    }

    if ( !isdefined( var_0 ) )
        return;

    ball_assign_start( var_0 );
}

ball_download_fx( var_0, var_1 )
{
    level endon( "uplink_completed" );
    playfxontag( level._effect["ball_download"], var_0, "tag_origin" );
    common_scripts\utility::waittill_notify_or_timeout( "pickup_object", var_1 );
    stopfxontag( level._effect["ball_download"], var_0, "tag_origin" );
}

ball_download_wait( var_0 )
{
    self endon( "pickup_object" );
    level endon( "uplink_completed" );
    wait(var_0);
    playfx( level._effect["ball_download_end"], self.current_start.origin );
    ball_waypoint_neutral();
    ball_fx_start();
}

ball_pass_shoot_watch()
{
    thread ball_pass_watch();
    thread ball_shoot_watch();
}

ball_pass_watch()
{
    self endon( "ball_shoot" );
    level endon( "uplink_completed" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "drop_object" );

    for (;;)
    {
        self waittill( "ball_pass", var_0 );

        if ( var_0 != "iw5_carrydrone_mp" )
            continue;

        break;
    }

    self notify( "ball_pass" );

    if ( isdefined( self.carryobject ) && isdefined( self.pass_target ) )
    {
        thread ball_pass_or_throw_active();
        var_1 = self.pass_target;
        var_2 = self.pass_target.origin;
        wait 0.15;

        if ( isdefined( self.pass_target ) )
            var_1 = self.pass_target;

        self playsound( "mp_ul_ball_throw" );
        self.carryobject thread ball_pass_projectile( self, var_1, var_2 );
    }
}

ball_shoot_watch()
{
    self endon( "ball_pass" );
    level endon( "uplink_completed" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "drop_object" );

    for (;;)
    {
        self waittill( "weapon_fired", var_0 );

        if ( var_0 != "iw5_carrydrone_mp" )
            continue;

        break;
    }

    self notify( "ball_shoot" );

    if ( isdefined( self.carryobject ) )
    {
        var_1 = getdvarfloat( "scr_ball_shoot_extra_pitch", -12 );
        var_2 = getdvarfloat( "scr_ball_shoot_force", 320 );
        var_3 = self getangles();
        var_3 += ( var_1, 0, 0 );
        var_3 = ( clamp( var_3[0], -85, 85 ), var_3[1], var_3[2] );
        var_4 = anglestoforward( var_3 );
        thread ball_pass_or_throw_active();
        wait 0.25;
        self playsound( "mp_ul_ball_throw" );
        self.carryobject thread ball_physics_launch_drop( var_4 * var_2, self );
    }
}

ball_pass_or_throw_active()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "uplink_completed" );
    self.pass_or_throw_active = 1;
    self allowmelee( 0 );

    while ( "iw5_carrydrone_mp" == self getcurrentweapon() )
        waitframe();

    self allowmelee( 1 );
    self.pass_or_throw_active = 0;
}

ball_pass_projectile( var_0, var_1, var_2 )
{
    ball_set_dropped( 1 );

    if ( isdefined( var_1 ) )
        var_2 = var_1.origin;

    var_3 = ( 0.0, 0.0, 40.0 );
    var_4 = vectornormalize( var_2 + var_3 - self.visuals[0].origin );
    var_5 = var_4 * 1000;
    self.projectile = _func_071( "gamemode_ball", self.visuals[0].origin, var_5, 30, var_0, 1 );

    if ( isdefined( var_1 ) )
        self.projectile missile_settargetent( var_1 );

    self.visuals[0] linkto( self.projectile );
    ball_dont_interpolate();
    ball_clear_contents();
    thread ball_on_projectile_hit_client();
    thread ball_on_projectile_death();
    thread ball_pass_touch_goal();
}

ball_on_projectile_hit_client()
{
    self endon( "pass_end" );
    level endon( "uplink_completed" );
    self.projectile waittill( "projectile_impact_player", var_0 );
    self.trigger notify( "trigger", var_0 );
}

ball_on_projectile_death()
{
    level endon( "stop_horde_ball" );
    level endon( "uplink_completed" );
    self.projectile waittill( "death" );

    if ( !isdefined( self.carrier ) && !self.in_goal )
        ball_physics_launch( ( 0.0, 0.0, 10.0 ) );

    ball_restore_contents();
    var_0 = self.visuals[0];
    var_0 notify( "pass_end" );
}

ball_pass_touch_goal()
{
    var_0 = self.visuals[0];
    var_0 endon( "pass_end" );
    ball_touch_goal_watch( var_0 );
}

ball_physics_launch_drop( var_0, var_1 )
{
    ball_set_dropped( 1 );
    ball_physics_launch( var_0, var_1 );
}

ball_touch_goal_watch( var_0 )
{
    level endon( "stop_horde_ball" );
    level endon( "uplink_completed" );

    for (;;)
    {
        foreach ( var_2 in level._id_4250 )
        {
            if ( !var_2.useobject ball_goal_can_use() )
                continue;

            var_3 = distance( var_0.origin, var_2.origin );

            if ( var_3 <= var_2.radius )
            {
                thread ball_touched_goal( var_2 );
                return;
            }

            if ( isdefined( var_0.origin_prev ) )
            {
                var_4 = line_interect_sphere( var_0.origin_prev, var_0.origin, var_2.origin, var_2.radius );

                if ( var_4 )
                {
                    thread ball_touched_goal( var_2 );
                    return;
                }
            }
        }

        waitframe();
    }
}

ball_goal_can_use( var_0 )
{
    var_1 = self.goal;

    if ( var_1.ball_in_goal )
        return 0;

    return 1;
}

ball_touched_goal( var_0 )
{
    ball_play_score_fx( var_0 );
    var_1 = var_0.team;
    var_2 = maps\mp\_utility::getotherteam( var_1 );
    ball_score_sound( var_2 );

    if ( isdefined( self.lastcarrier ) )
    {
        self.lastcarrierscored = 1;
        self.lastcarrier thread maps\mp\gametypes\_rank::xppointspopup( "horde_uplink", 300 );
    }

    thread ball_score_event( var_0, 1 );
}

ball_play_score_fx( var_0 )
{
    var_0.score_fx["friendly"] hide();
    var_0.score_fx["enemy"] hide();

    foreach ( var_2 in level.players )
    {
        var_3 = ball_get_view_team( var_2 );

        if ( var_3 == var_0.team )
        {
            var_0.score_fx["friendly"] showtoplayer( var_2 );
            continue;
        }

        var_0.score_fx["enemy"] showtoplayer( var_2 );
    }

    triggerfx( var_0.score_fx["friendly"] );
    triggerfx( var_0.score_fx["enemy"] );
}

ball_score_event( var_0, var_1 )
{
    self notify( "score_event" );
    self.in_goal = 1;
    var_0.ball_in_goal = 1;
    var_2 = self.visuals[0];

    if ( isdefined( self.projectile ) )
        self.projectile delete();

    var_2 physicsstop();
    maps\mp\gametypes\_gameobjects::allowcarry( "none" );
    ball_waypoint_upload();
    level.horde_ball_score += var_1;

    if ( level.horde_ball_score < level.horde_ball_score_count )
    {
        thread _id_A793::_id_49A7( "coop_gdn_satellite_success", "horde", 1, 1 );

        if ( var_1 > 1 )
            level thread _id_A798::_id_852A( "horde_uplink_touchdown" );
        else
            level thread _id_A798::_id_852A( "horde_uplink_fieldgoal" );
    }

    level._id_251F += 300 * var_1;
    level notify( "pointsEarned" );
    var_3 = 0.4;
    var_4 = 1.2;
    var_5 = 1.0;
    var_6 = var_3 + var_5;
    var_7 = var_6 + var_4;
    var_2 moveto( var_0.origin, var_3, 0, var_3 );
    var_2 rotatevelocity( ( 1080.0, 1080.0, 0.0 ), var_7, var_7, 0 );
    wait(var_6);
    var_0.ball_in_goal = 0;
    var_2 movez( 4000, var_4, var_4 * 0.1, 0 );
    wait(var_4);
    maps\mp\gametypes\_gameobjects::allowcarry( "any" );
    self.in_goal = 0;
    level notify( "horde_ball_scored" );
}

ball_carrier_touched_goal( var_0 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0.carryobject ) )
        return;

    var_1 = self.goal.team;
    var_2 = maps\mp\_utility::getotherteam( var_1 );
    ball_score_sound( var_2 );
    ball_play_score_fx( self.goal );

    if ( isdefined( var_0.shoot_charge_bar ) )
        var_0.shoot_charge_bar.inuse = 0;

    var_3 = var_0.carryobject;
    var_3.lastcarrierscored = 1;
    var_3 ball_set_dropped( 1 );
    var_3 thread ball_score_event( self.goal, 2 );
    var_0 thread maps\mp\gametypes\_rank::xppointspopup( "horde_uplink", 600 );
}

ball_return_home()
{
    self.in_goal = 0;
    var_0 = self.visuals[0];
    playfx( common_scripts\utility::getfx( "ball_teleport" ), var_0.origin );

    if ( isdefined( self.carrier ) )
        self.carrier maps\mp\_utility::delaythread( 0.05, ::player_update_pass_target_hudoutline );

    thread maps\mp\gametypes\_gameobjects::returnhome();
}

ball_clear_contents()
{
    self.visuals[0].old_contents = self.visuals[0] setcontents( 0 );
}

ball_restore_contents()
{
    if ( isdefined( self.visuals[0].old_contents ) )
    {
        self.visuals[0] setcontents( self.visuals[0].old_contents );
        self.visuals[0].old_contents = undefined;
    }
}

line_interect_sphere( var_0, var_1, var_2, var_3 )
{
    var_4 = vectornormalize( var_1 - var_0 );
    var_5 = vectordot( var_4, var_0 - var_2 );
    var_5 *= var_5;
    var_6 = var_0 - var_2;
    var_6 *= var_6;
    var_7 = var_3 * var_3;
    return var_5 - var_6 + var_7 >= 0;
}

ball_get_view_team( var_0 )
{
    var_1 = var_0.team;

    if ( var_1 != "allies" && var_1 != "axis" )
        var_1 = "allies";

    return var_1;
}

ball_physics_launch( var_0, var_1 )
{
    var_2 = self.visuals[0];
    var_2.origin_prev = undefined;
    ball_fx_start();
    var_2 physicslaunchserver( var_2.origin, var_0 );
    thread ball_physics_touch_cant_pickup_player( var_1 );
    thread ball_physics_out_of_level();
    thread ball_physics_timeout( var_1 );
    thread ball_physics_bad_trigger_watch();
    thread ball_physics_touch_goal();
}

ball_physics_touch_cant_pickup_player( var_0 )
{
    var_1 = self.visuals[0];
    var_2 = self.trigger;
    var_1 endon( "physics_finished" );
    level endon( "uplink_completed" );

    for (;;)
    {
        var_2 waittill( "trigger", var_3 );

        if ( isdefined( var_0 ) && var_0 == var_3 && var_3 player_no_pickup_time() )
            continue;

        if ( self.droptime >= gettime() )
            continue;

        if ( !ball_can_pickup( var_3 ) )
            thread ball_physics_fake_bounce();
    }
}

ball_physics_out_of_level()
{
    level endon( "stop_horde_ball" );
    self endon( "reset" );
    self endon( "pickup_object" );
    level endon( "uplink_completed" );
    var_0 = self.visuals[0];
    var_1[0] = 200;
    var_1[1] = 200;
    var_1[2] = 1000;
    var_2[0] = 200;
    var_2[1] = 200;
    var_2[2] = 200;

    for (;;)
    {
        for ( var_3 = 0; var_3 < 2; var_3++ )
        {
            if ( var_0.origin[var_3] > level.ball_maxs[var_3] + var_1[var_3] )
            {
                ball_return_home();
                return;
            }

            if ( var_0.origin[var_3] < level.ball_mins[var_3] - var_2[var_3] )
            {
                ball_return_home();
                return;
            }
        }

        waitframe();
    }
}

ball_physics_timeout( var_0 )
{
    self endon( "reset" );
    self endon( "pickup_object" );
    self endon( "score_event" );
    level endon( "uplink_completed" );
    var_1 = getdvarfloat( "scr_ball_reset_time", 15 );
    var_2 = 10;
    var_3 = 3;

    if ( var_1 >= var_2 )
    {
        wait(var_3);
        var_1 -= var_3;
    }

    wait(var_1);
    ball_return_home();
}

ball_physics_bad_trigger_watch()
{
    level endon( "uplink_completed" );
    self.visuals[0] endon( "physics_finished" );
    self.visuals[0] endon( "death" );
    thread ball_physics_bad_trigger_at_rest();
    wait 0.1;

    for (;;)
    {
        if ( maps\mp\gametypes\_gameobjects::istouchingbadtrigger() )
        {
            ball_return_home();
            return;
        }

        waitframe();
    }
}

ball_physics_bad_trigger_at_rest()
{
    self endon( "pickup_object" );
    self endon( "reset" );
    self endon( "score_event" );
    level endon( "uplink_completed" );
    var_0 = self.visuals[0];
    var_0 endon( "death" );
    var_0 waittill( "physics_finished" );
    thread _id_A793::_id_49A7( "coop_gdn_satellite_lost", "horde", 1, 1 );

    if ( maps\mp\gametypes\_gameobjects::istouchingbadtrigger() )
    {
        ball_return_home();
        return;
    }
}

ball_physics_fake_bounce()
{
    var_0 = self.visuals[0];

    if ( !var_0 physicsisactive() )
        return;

    var_1 = var_0 physicsgetlinvel();
    var_2 = length( var_1 ) / 10;
    var_3 = -1 * vectornormalize( var_1 );
    var_0 physicsstop();
    var_0 physicslaunchserver( var_0.origin, var_3 * var_2 );
}

ball_physics_touch_goal()
{
    var_0 = self.visuals[0];
    var_0 endon( "physics_finished" );
    ball_touch_goal_watch( var_0 );
}
