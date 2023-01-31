// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

delayed_luinotifyserver( var_0, var_1, var_2 )
{
    wait(var_0);
    self notify( "luinotifyserver", var_1, var_2 );
}

setup_camparams()
{
    var_0 = spawnstruct();
    var_0.targetzoff = 40;
    var_0.basedelta = 0.25;
    var_0.tgtdelta = var_0.basedelta;
    var_0.accel = 0.01;
    var_0.delta = 0;
    var_0.basedangle = 0.5;
    var_0.angleaccel = 0.01;
    var_0.tgtdangle = var_0.basedangle;
    var_0.dangle = 0;
    var_0.maxorbitangle = 60;
    var_0.minorbitdist = 60;
    var_0.maxorbitdist = 120;
    var_0.angle = 0;
    var_0.dist = 120;
    var_0.dof_time = 12;
    var_0.face_dof_mod = -10;
    var_0.caotolobbyframedelay = 3;
    var_0.caotolobbyframetimer = 0;
    var_0.gamelobbygroup_camoffset_angle_ratio = 0.0;
    var_0.gamelobbygroup_camerazoff_zoom = 45;
    var_0.gamelobbygroup_targetzoff_zoom = 50;
    var_0.gamelobbygroup_camera_offset = 6;
    var_0.gamelobbygroup_camera_targetoffset = 6;
    var_0.gamelobbygroup_camera_upclosez = 513;
    var_0.gamelobbygroup_camera_normalz = 507;
    var_0.gamelobbygroup_camera_crouchz = 483;
    var_0.gamelobbygroup_camera_hunchz = 502;
    var_0.gamelobbygroup_camera_closedistance = 71.5;
    var_0.gamelobbygroup_camera_normaldistance = 96.8;
    var_0.gamelobbygroup_camera_crouchdistance = 96.8;
    var_0.gamelobbygroup_camera_hunchdistance = 96.8;
    var_0.gamelobbygroup_camera_crouchthreshold = 490;
    var_0.gamelobbygroup_camera_hunchthreshold = 504.5;
    var_0.gamelobbygroup_camera_normalthreshold = 509.5;
    var_0.gamelobbygroup_movespeed_modifier = 0.95;
    var_0.cac_camoffset_angle_ratio = 0.0;
    var_0.cac_camerazoff_zoom = 7;
    var_0.cac_targetzoff_zoom = 13;
    var_0.cac_camera_offset = 0;
    var_0.cac_camera_targetoffset = 0;
    var_0.camoffset_ratio_cac = 0.1;
    var_0.cac_ratio_zoom = 0.2;
    var_0.cac_framedelay = 0;
    var_0.cac_camerazoff = 17;
    var_0.cac_targetzoff = 14.5;
    var_0.cac_dist = 69;
    var_0.cac_weap_offset = 8;
    var_0.cac_weap_tuning = 0;
    var_0.cac_weap_tuning_camoffset = 0;
    var_0.cac_weap_tuning_weap_sideoffset = 0;
    var_0.cac_weap_tuning_weap_zoffset = 0;
    var_0.cacweapondelaytime = 0.35;
    var_0.cacweaponanimdelaytime = 0.1;
    var_0.cacweaponattachdelaytime = 0.05;
    var_0.gamelobby_movespeed = 150;
    var_0.gamelobby_camoffset_angle_ratio = 0.2;
    var_0.gamelobby_camerazoff_zoom = 45;
    var_0.gamelobby_targetzoff_zoom = 55;
    var_0.gamelobby_camera_offset = 16;
    var_0.gamelobby_camera_targetoffset = 24;
    var_0.gamelobby_camera_rotation_speed = 0.5;
    var_0.goal = "avatar";
    var_0.gamelobby_camera_curve_modify = 0.005;
    var_0.gamelobby_camera_curve_storedy = 0;
    var_0.gamelobby_camera_curve_movex = 64;
    var_0.gamelobby_camera_depth_scaler = 0;
    var_0.tgt_camoffset_ratio = var_0.camoffset_ratio_prelobby;
    var_0.cur_camoffset_ratio = var_0.tgt_camoffset_ratio;
    var_0.cac_camoffset_ratio = 0;
    var_0.cac_weap_loot_offset = ( -0.02, 0, -0.08 );
    var_0.cac_weap_screen_offset = ( 0.05, 0, -0.06 );
    var_0.camoffset_ratio_maxspeed = 0.25;
    var_0.camzoff = 10;
    var_0.movespeed = 150;
    var_0.angspeed = 800;
    var_0.prelobbyzoom = 0;
    var_1 = self _meth_844D();
    var_0.oldrotx = var_1[0];
    var_0.oldroty = var_1[1];
    var_0.zoom = 0.5;
    var_0.rotate = 0.5;
    var_0.framedelay = 0;
    var_0.pre_lobby_framedelay = 4;
    var_0.delayed_cut = 0;
    var_0.dof_near_start = 0;
    var_0.dof_near_end = 0;
    var_0.dof_far_start = 159.8;
    var_0.dof_far_end = 205.59;
    var_0.dof_near_blur = 7.5;
    var_0.dof_far_blur = 2;
    var_0.origin_offset = ( 0, 0, 40 );
    var_0.prelobby_movespeed = 300;
    var_0.prelobby_targetzoff_zoom = 10;
    var_0.prelobby_targetzoff = 42;
    var_0.prelobby_neardist = 40;
    var_0.prelobby_fardist = 200;
    var_0.prelobby_camerazoff = 0;
    var_0.prelobby_camerazoff_zoom = 20;
    var_0.prelobby_camera_ratio = 0.325;
    var_0.prelobby_ratio_zoom = 0.2;
    var_0.camoffset_ratio_lobby = -0.1;
    var_0.camoffset_ratio_prelobby = 0.19;
    var_0.camoffset_ratio_prelobby_loot = -1;
    var_0.ch_cyl_zoff_far = 36;
    var_0.ch_cyl_zoff_near = 42;
    var_0.transitioning = 0;
    var_0.cao_targetzoff_zoom = 10;
    var_0.cao_targetzoff = 31;
    var_0.cao_neardist = 40;
    var_0.cao_fardist = 200;
    var_0.cao_camerazoff = 0;
    var_0.cao_camerazoff_zoom = 20;
    var_0.cao_camera_ratio = 0.77;
    var_0.cao_ratio_zoom = 0.2;
    var_0.cao_camoffset_ratio = 0.25;
    var_2 = getdvarint( "virtualLobbyMode", 0 );

    if ( var_2 == 0 )
    {
        var_0.mode = "game_lobby";
        start_prelobby_anims();
        setdvar( "virtualLobbyReady", "0" );
    }
    else
    {
        var_0.mode = "transition";
        var_0.tgt_camoffset_ratio = var_0.camoffset_ratio_lobby;
        var_0.cur_camoffset_ratio = var_0.tgt_camoffset_ratio;
        start_lobby_anims();

        if ( getdvarint( "virtualLobbyReady", 0 ) == 0 )
            setdvar( "virtualLobbyReady", "1" );

        if ( var_2 == 2 )
            thread delayed_luinotifyserver( 0.1, "cac", 0 );
        else if ( var_2 == 3 )
            thread delayed_luinotifyserver( 0.1, "cao", 0 );
    }

    var_0.newmode = var_0.mode;
    level.camparams = var_0;
}

update_camera_params_ratio( var_0 )
{
    if ( isdefined( self.cut ) )
        var_0.cur_camoffset_ratio = var_0.tgt_camoffset_ratio;
    else
    {
        var_1 = var_0.tgt_camoffset_ratio - var_0.cur_camoffset_ratio;

        if ( var_1 < -1 * var_0.camoffset_ratio_maxspeed )
            var_1 = -1 * var_0.camoffset_ratio_maxspeed;
        else if ( var_1 > var_0.camoffset_ratio_maxspeed )
            var_1 = var_0.camoffset_ratio_maxspeed;

        var_0.cur_camoffset_ratio += var_1;
    }
}

vlobby_lighting_setup()
{
    var_0 = self;

    if ( isdefined( level.vl_lighting_setup ) )
        var_0 [[ level.vl_lighting_setup ]]();
    else
    {
        var_0 _meth_84A9();
        var_0 _meth_84AB( 0.613159, 89.8318, level.camparams.dof_time, level.camparams.dof_time );
    }
}

set_avatar_dof()
{
    if ( isdefined( level.camparams.goal ) )
    {
        if ( level.camparams.goal == "moving" || level.camparams.goal == "finding_new_position" || level.vlavatars[level.vl_focus] != level.vlavatars[level.old_vl_focus] )
            return;
    }

    if ( isdefined( level.camparams.camera.cut ) && level.camparams.camera.cut == 1 )
        return;

    var_0 = self;

    if ( isdefined( level.camparams.camera.goal_location ) )
        var_1 = level.camparams.camera.goal_location;
    else
    {
        var_2 = level.vlavatars[level.old_vl_focus];
        var_3 = var_2 gettagorigin( "TAG_STOWED_BACK" );
        var_4 = distance2d( var_3, var_2.avatar_spawnpoint.origin );
        var_5 = var_2.avatar_spawnpoint.origin + anglestoforward( var_2.avatar_spawnpoint.angles ) * var_4;
        var_1 = ( var_5[0], var_5[1], var_3[2] );
    }

    var_6 = checkcamposition( level.camparams.camera, var_1, 1.5 );

    if ( var_6 == 1 )
        var_7 = var_1;
    else
        var_7 = level.camparams.camera.origin;

    var_8 = distance( level.vlavatars[level.old_vl_focus] gettagorigin( "j_spine4" ), var_7 );
    var_0 vlobby_dof_based_on_focus( var_8 + level.camparams.face_dof_mod );
}

vlobby_dof_based_on_focus( var_0 )
{
    if ( var_0 <= 0.0 )
        return;

    var_1 = self;
    var_2 = level.camparams.dof_time;

    if ( isdefined( level.vl_dof_based_on_focus ) )
        var_1 [[ level.vl_dof_based_on_focus ]]( var_0 );
    else
    {
        var_3 = var_0;
        var_1 = self;
        var_4 = 0.025;
        var_5 = 0.65;
        var_6 = 0.613159;
        var_7 = 94.9504;
        var_8 = ( var_7 - var_3 ) * var_4;
        var_9 = var_6 + var_8 + var_8 * var_5;

        if ( var_9 < 0.125 )
            var_9 = 0.125;
        else if ( var_9 > 128 )
            var_9 = 128;

        var_1 _meth_84AB( var_9, var_3, level.camparams.dof_time, level.camparams.dof_time * 2 );
    }
}

vlobby_handle_mode_change( var_0, var_1, var_2 )
{
    var_3 = self;

    if ( isdefined( level.vl_handle_mode_change ) )
        var_3 [[ level.vl_handle_mode_change ]]( var_0, var_1, var_2 );
    else
    {
        if ( var_0 == "cac" )
            var_3 setdefaultpostfx();
        else if ( var_0 == "cao" )
        {

        }

        if ( var_1 == "cac" )
        {
            var_3 _meth_82D4( "mp_vlobby_refraction_cac", 0 );
            var_3 _meth_83C0( "mp_vl_create_a_class" );
        }
        else if ( var_1 == "cao" )
            var_3 _meth_84AB( 1.53, 130, level.camparams.dof_time, level.camparams.dof_time );
        else if ( var_1 == "clanprofile" )
            var_3 setdefaultdof();
        else if ( var_1 == "prelobby" )
            var_3 setdefaultpostfx();
        else
        {
            if ( var_0 == "prelobby_members" )
                return;

            if ( var_0 == "prelobby_loadout" )
                return;

            if ( var_0 == "prelobby_loot" )
                return;

            if ( var_1 == "game_lobby" )
                var_3 setdefaultpostfx();
            else
            {
                if ( var_0 == "startmenu" )
                    return;

                if ( var_0 == "transition" )
                    return;

                return;
                return;
                return;
                return;
            }
        }
    }
}

setdefaultpostfx()
{
    var_0 = self;
    var_0 _meth_82D4( "mp_vlobby_room", 0 );
    var_0 _meth_83C0( "mp_vlobby_room" );
}

setdefaultdof()
{
    var_0 = self;
    var_0 _meth_84AB( 0.613159, 89.8318, level.camparams.dof_time, level.camparams.dof_time );
}

fixlocalfocus()
{
    if ( !isdefined( level.vlavatars[level.vl_focus] ) )
    {
        foreach ( var_2, var_1 in level.vlavatars )
        {
            level.vl_focus = var_2;
            break;
        }
    }

    if ( !isdefined( level.vlavatars[level.vl_local_focus] ) )
        level.vl_local_focus = level.vl_focus;
}

vlobby_player()
{
    self endon( "disconnect" );
    wait 0.05;
    var_0 = self;
    var_0 _meth_82FB( "ui_vlobby_round_state", 0 );
    var_0 _meth_82FB( "ui_vlobby_round_timer", 0 );
    var_0 grab_players_classes();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
    var_3 = var_1 - ( 0, 0, 30 );
    var_0 setup_camparams();
    var_0 vlobby_lighting_setup();
    var_4 = anglestoforward( var_0.angles );
    var_5 = anglestoright( var_0.angles );
    var_6 = var_4;
    var_7 = getgroundposition( var_1, 20, 512, 120 );
    var_8 = var_0 _meth_8297();
    var_9 = var_8 == "";
    var_10 = undefined;
    level.needlocalmemberid = 1;
    level.vl_focus = 0;
    level.vl_local_focus = 0;
    var_0.team = "spectator";
    var_11 = "iw5_hbra3_mp";
    var_12 = "iw5_hbra3";

    if ( isdefined( var_0.loadouts["customClasses"][0]["primary"] ) && var_0.loadouts["customClasses"][0]["primary"] != "none" )
    {
        var_13 = var_0.loadouts["customClasses"][0]["primary"];
        var_14 = var_0.loadouts["customClasses"][0]["primaryAttachment1"];
        var_15 = var_0.loadouts["customClasses"][0]["primaryAttachment2"];
        var_16 = var_0.loadouts["customClasses"][0]["primaryAttachment3"];
        var_17 = var_0.loadouts["customClasses"][0]["primaryCamo"];
        var_18 = var_0.loadouts["customClasses"][0]["primaryReticule"];

        if ( isdefined( var_17 ) )
            var_17 = int( tablelookup( "mp/camoTable.csv", 1, var_17, 0 ) );
        else
            var_17 = undefined;

        if ( isdefined( var_18 ) )
            var_18 = int( tablelookup( "mp/reticleTable.csv", 1, var_18, 0 ) );
        else
            var_18 = undefined;

        var_11 = maps\mp\gametypes\_class::buildweaponname( var_13, var_14, var_15, var_16, var_17, var_18 );
        var_12 = var_0.loadouts["customClasses"][0]["primary"];
    }
    else if ( isdefined( var_0.primaryweapon ) )
    {
        var_11 = var_0.primaryweapon;
        var_12 = var_0.pers["primaryWeapon"];
    }

    var_19 = getent( "cao_spawnpoint", "targetname" );

    if ( !var_9 )
    {
        maps\mp\_vl_base::vlprintln( "adding xuid " + var_8 + "from vlobby_player" );
        var_20 = maps\mp\_vl_base::add_avatar( var_8 );
        var_0 spawn_an_avatar( var_0.avatar_spawnpoint, var_11, var_0.secondaryweapon, var_12, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.sessioncostume, var_0.name, var_20, 0 );
        _func_2D4( level.vlavatars[var_20], var_8 );
        thread setvirtuallobbypresentable();
    }
    else
        level.needtopresent = 1;

    setdvar( "virtuallobbymembers", level.xuid2ownerid.size );
    var_0.cao_agent = var_0 spawn_an_avatar( var_19, var_11, var_0.secondaryweapon, var_12, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.sessioncostume, var_0.name, 0, 1 );
    _func_2D4( var_0.cao_agent, var_8 );
    hide_avatar( var_0.cao_agent );
    var_0.clan_agents = [];
    var_21 = [ 0, 1, 4 ];

    for ( var_22 = 0; var_22 < 3; var_22++ )
    {
        var_23 = maps\mp\gametypes\vlobby::getspawnpoint( var_21[var_22] );
        var_0.clan_agents[var_22] = var_0 spawn_an_avatar( var_23, var_11, var_0.secondaryweapon, var_12, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.sessioncostume, var_0.name, 0, 0, 1 );
        hide_avatar( var_0.clan_agents[var_22] );
    }

    var_0 thread monitor_class_select_or_weapon_change( 0 );

    if ( !var_9 )
    {
        var_10 = level.vlavatars[level.vl_focus];
        var_10.membertimeout = gettime();
        var_10.currentselectedclass = var_0.currentselectedclass;
        var_10.player = var_0;
        var_10.sessioncostume = var_10.costume;
        virtual_lobby_set_class( 0, "lobby" + ( var_10.currentselectedclass + 1 ), 1 );
    }

    thread monitor_debug_addfakemembers( var_0, level.camparams );
    var_24 = ( -70.7675, -691.293, 507.472 );
    var_25 = var_0.avatar_spawnpoint.origin - var_24;
    var_26 = ( 0, 87, 0 );
    var_25 = vectornormalize( var_25 );
    var_27 = spawn( "script_model", var_24 );
    var_27.angles = var_26;
    var_27 _meth_80B1( "tag_player" );
    var_27.startorigin = var_24;
    var_27.startangles = var_26;
    var_27.savedorigin = ( 0, 0, 0 );
    var_27.cam_percent_away = 0;
    var_27.hasreachedfinalpos = 1;
    var_27.camdirectionforward = 1;
    var_27.cut = 1;
    var_27.gap = 0;
    var_27.finished = 1;
    var_27.goal_location = var_24;
    storecameratargets( var_27 );
    var_28 = 400;
    var_0.camera = var_27;
    var_27.player = var_0;
    var_0.hastouchedstick = 0;
    var_29 = ( 0, 90, 0 );
    var_27.movingstate = "starting";
    level.vlcamera = var_27;
    var_0 setorigin( var_27.origin );
    var_0 _meth_807C( var_27, "tag_player" );
    var_0 _meth_81E2( var_27, "tag_player" );
    level.in_firingrange = 0;
    var_0 _meth_8131( 0 );
    var_0 maps\mp\_vl_base::prep_for_controls( var_0.spawned_avatar, var_0.spawned_avatar.spawn_angles );
    var_0 maps\mp\_vl_base::prep_for_controls( var_0.cao_agent, var_0.cao_agent.spawn_angles );
    var_0 maps\mp\_vl_base::prep_for_controls( var_0.clan_agents[0], var_0.clan_agents[0].spawn_angles );
    var_0 maps\mp\_vl_base::prep_for_controls( var_0.clan_agents[1], var_0.clan_agents[1].spawn_angles );
    var_0 maps\mp\_vl_base::prep_for_controls( var_0.clan_agents[2], var_0.clan_agents[2].spawn_angles );
    maps\mp\_utility::updatesessionstate( "spectator" );
    var_30 = level.camparams;
    var_30.camera = var_27;
    init_path_constants( var_27 );
    var_31 = 300;
    level.old_vl_focus = level.vl_focus;
    var_28 = 1000;
    var_32 = anglestoforward( var_27.angles );
    var_33 = undefined;
    var_34 = undefined;
    var_35 = undefined;
    var_36 = undefined;
    level.camparams.framedelay = level.camparams.pre_lobby_framedelay;
    thread monitor_player_removed();
    thread monitor_vl_mode_change();
    var_37 = 0;
    var_38 = 0;
    var_0 _meth_82FC( "cg_fovscale", "0.6153" );
    var_0 notify( "fade_in" );

    for (;;)
    {
        maps\mp\_vl_base::avatar_after_spawn();

        if ( level.vlavatars.size == 0 )
        {
            if ( var_30.mode == "game_lobby" || var_30.mode == "prelobby_loot" )
            {
                hide_avatar( var_0.cao_agent );

                for ( var_22 = 0; var_22 < 3; var_22++ )
                    hide_avatar( var_0.clan_agents[var_22] );

                var_27.cut = 1;
                var_0.avatar_spawnpoint = maps\mp\gametypes\vlobby::getspawnpoint( 0 );
                lobby_update_group_new( var_27, undefined, var_30, var_0.avatar_spawnpoint );
                vlobby_vegnette( 1, "ac130_overlay_pip_vignette_vlobby" );
            }

            wait 0.05;
            continue;
        }

        var_10 = level.vlavatars[level.vl_focus];

        if ( var_38 )
        {
            var_38 = 0;
            var_0 thread debug_pathing();
        }

        if ( getdvarint( "scr_vl_debugfly" ) > 0 )
        {
            if ( !var_37 )
            {
                var_37 = 1;
                setdvar( "lui_enabled", "0" );
                level.debug_fly = undefined;
                var_0 _meth_8131( 1 );
            }

            var_0 debug_fly( var_27 );
        }
        else if ( var_37 )
        {
            setdvar( "lui_enabled", "1" );
            var_37 = 0;
            var_27.origin = var_27.startorigin;
            var_27.angles = var_27.startangles;
            var_0 _meth_8131( 0 );
        }

        if ( !level.in_firingrange )
        {
            if ( level.vl_focus != level.old_vl_focus )
            {
                var_0 maps\mp\_vl_base::prep_for_controls( level.vlavatars[level.vl_focus], level.vlavatars[level.vl_focus].angles );

                if ( var_30.mode != "game_lobby" )
                    var_30.newmode = "transition";

                level.old_vl_focus = level.vl_focus;
                var_30.transitioning = 1;
            }

            if ( isdefined( level.vl_cao_focus ) || isdefined( level.prv_vl_cao_focus ) )
            {
                if ( !isdefined( level.vl_cao_focus ) )
                {
                    var_30.newmode = var_30.pushmode;
                    level.prv_vl_cao_focus = undefined;
                }
                else if ( !isdefined( level.prv_vl_cao_focus ) )
                {
                    var_30.newmode = "cao";
                    var_30.pushmode = var_30.mode;
                    level.prv_vl_cao_focus = level.vl_cao_focus;
                }
                else if ( level.vl_cao_focus != level.prv_vl_cao_focus )
                    level.prv_vl_cao_focus = level.vl_cao_focus;
            }

            if ( isdefined( level.cac ) || isdefined( level.prv_cac ) )
            {
                if ( !isdefined( level.cac ) )
                {
                    var_30.newmode = var_30.pushmode;
                    level.prv_cac = undefined;
                    level.prv_cac_weapon = "none";
                }
                else if ( !isdefined( level.prv_cac ) )
                {
                    var_30.newmode = "cac";
                    var_30.pushmode = var_30.mode;
                    level.prv_cac = level.cac;
                }
            }

            if ( isdefined( level.vl_clanprofile_focus ) || isdefined( level.prv_vl_clanprofile_focus ) )
            {
                if ( !isdefined( level.vl_clanprofile_focus ) )
                {
                    var_30.newmode = var_30.pushmode;
                    level.prv_vl_clanprofile_focus = undefined;
                }
                else if ( !isdefined( level.prv_vl_clanprofile_focus ) )
                {
                    var_30.newmode = "clanprofile";
                    var_30.pushmode = var_30.mode;
                    level.prv_vl_clanprofile_focus = level.vl_clanprofile_focus;
                }
                else if ( level.vl_clanprofile_focus != level.prv_vl_clanprofile_focus )
                {
                    level.prv_vl_clanprofile_focus = level.vl_clanprofile_focus;
                    var_0 maps\mp\_vl_base::prep_for_controls( var_0.clan_agents[level.vl_clanprofile_focus], var_0.clan_agents[level.vl_clanprofile_focus].angles );
                }
            }

            if ( level.vlavatars.size == 0 )
                continue;

            fixlocalfocus();
            var_10 = level.vlavatars[level.vl_focus];

            if ( var_30.newmode != var_30.mode )
            {
                var_0 vlobby_handle_mode_change( var_30.mode, var_30.newmode, var_30 );

                if ( var_30.newmode == "cac" )
                {
                    hide_avatar( var_0.cao_agent );

                    for ( var_22 = 0; var_22 < 3; var_22++ )
                        hide_avatar( var_0.clan_agents[var_22] );

                    var_0.hastouchedstick = 0;
                    var_30.mode = var_30.newmode;
                    var_30.tgt_camoffset_ratio = var_30.cac_camoffset_angle_ratio;
                    var_10 = level.vlavatars[level.vl_focus];
                    var_0 maps\mp\_vl_base::prep_for_controls( var_10, var_10.angles );
                }
                else if ( var_30.mode == "cac" )
                {
                    maps\mp\_vl_base::show_non_owner_avatars();
                    var_10 = level.vlavatars[level.vl_focus];
                    var_0.hastouchedstick = 0;
                }

                if ( var_30.newmode == "cao" )
                {
                    if ( isdefined( level.vl_local_focus ) && isdefined( level.vlavatars[level.vl_local_focus] ) )
                    {
                        var_39 = level.vlavatars[level.vl_local_focus];
                        level.players[0].costume = var_39.costume;
                        var_40 = level.players[0] maps\mp\gametypes\_teams::playercostume();
                        var_40 = var_39 maps\mp\gametypes\_teams::playercostume();
                        var_41 = level.players[0].cao_agent;
                        vl_avatar_costume( var_41, var_39.costume );
                        var_40 = var_41 maps\mp\gametypes\_teams::playercostume();

                        foreach ( var_8, var_43 in level.xuid2ownerid )
                        {
                            if ( var_43 == level.vl_local_focus )
                            {
                                if ( isdefined( level.cao_xuid ) && level.cao_xuid != var_8 )
                                    _func_2D4( var_41, level.cao_xuid, 1 );

                                _func_2D4( var_41, var_8 );
                                level.cao_xuid = var_8;
                                break;
                            }
                        }
                    }

                    show_avatar( var_0.cao_agent );
                    var_0.cao_agent hackagentangles( var_0.cao_agent.spawn_angles );
                    hide_avatars();

                    for ( var_22 = 0; var_22 < 3; var_22++ )
                        hide_avatar( var_0.clan_agents[var_22] );

                    var_10 = var_0.cao_agent;
                    var_0 maps\mp\_vl_base::prep_for_controls( var_0.cao_agent, var_0.cao_agent.angles );
                    start_cao_anims();
                    var_30.mode = var_30.newmode;
                    var_27.cut = 1;
                    var_0 setorigin( var_10.origin );
                }
                else if ( var_30.newmode == "clanprofile" )
                {
                    hide_avatar( var_0.cao_agent );
                    hide_avatars();

                    for ( var_22 = 0; var_22 < 3; var_22++ )
                    {
                        var_0.clan_agents[var_22] hackagentangles( var_0.clan_agents[var_22].spawn_angles );
                        var_0 maps\mp\_vl_base::prep_for_controls( var_0.clan_agents[var_22], var_0.clan_agents[var_22].angles );
                    }

                    var_10 = var_0.clan_agents[0];
                    var_30.mode = var_30.newmode;
                    var_0 setorigin( var_10.origin );
                }
                else if ( var_30.newmode == "prelobby_loot" )
                    var_27.cut = 1;
                else if ( var_30.newmode == "transition" )
                    var_30.newmode = "game_lobby";

                if ( var_30.newmode == "game_lobby" )
                {
                    fixlocalfocus();

                    if ( var_30.mode == "cac" && isdefined( level.vl_focus ) )
                        var_44 = level.vl_focus;
                    else
                    {
                        var_44 = 0;

                        foreach ( var_43, var_46 in level.vlavatars )
                        {
                            var_44 = var_43;
                            break;
                        }
                    }

                    if ( var_30.mode == "cao" || var_30.mode == "cac" || var_30.mode == "clanprofile" )
                    {
                        var_27.finished = 1;

                        if ( isdefined( level.vl_cao_focus ) )
                        {
                            level.vl_local_focus = var_44;
                            var_44 = getfocusfromcontroller( level.vl_cao_focus );
                        }
                        else if ( isdefined( level.vl_clanprofile_focus ) )
                        {
                            level.vl_local_focus = var_44;
                            var_44 = getfocusfromcontroller( level.vl_clanprofile_focus );
                        }
                        else
                            level.vl_local_focus = var_44;
                    }

                    if ( isdefined( level.vlavatars ) && isdefined( level.old_vl_focus ) && isdefined( level.vlavatars[level.old_vl_focus] ) )
                        var_0 maps\mp\_vl_base::prep_for_controls( level.vlavatars[level.old_vl_focus], level.vlavatars[level.old_vl_focus].angles );

                    var_30.goal = "waiting";

                    if ( var_30.mode != "cac" )
                        show_avatars();

                    level.vl_focus = var_44;
                    level.old_vl_focus = var_44;
                    var_10 = level.vlavatars[var_44];

                    if ( var_30.mode != "cac" )
                        var_27.cut = 1;
                    else if ( var_30.mode == "cac" && isdefined( var_27.avatar_spawnpoint ) && var_27.avatar_spawnpoint != var_10.avatar_spawnpoint )
                        var_27.cut = 1;

                    start_lobby_anims();
                    var_27.last_avatar_position = var_10.avatar_spawnpoint;
                    var_27.avatar_spawnpoint = var_10.avatar_spawnpoint;
                    var_0 maps\mp\_vl_base::prep_for_controls( var_10, var_10.angles );
                    var_27.movingstate = "starting";
                    var_0 setorigin( var_10.origin );
                }

                var_30.mode = var_30.newmode;
            }

            if ( var_30.mode == "startmenu" )
                start_menu_update( var_27, var_30 );
            else if ( var_30.mode == "cao" )
            {
                var_10 = var_0.cao_agent;
                cao_update( var_27, var_10, var_30 );
                vlobby_vegnette( 1, "ac130_overlay_pip_vignette_vlobby_cao" );
            }
            else if ( var_30.mode == "clanprofile" )
            {
                var_10 = var_0.clan_agents[level.vl_clanprofile_focus];
                clan_profile_update( var_27, var_10, var_30 );
                vlobby_vegnette( 1, "ac130_overlay_pip_vignette_vlobby" );
            }
            else if ( var_30.mode == "cac" )
                lobby_update_group_new( var_27, level.vlavatars[level.vl_focus], var_30, var_0.avatar_spawnpoint );
            else if ( var_30.mode == "transition" )
                var_30.newmode = "game_lobby";
            else if ( var_30.caotolobbyframetimer <= 0 )
            {
                hide_avatar( var_0.cao_agent );

                for ( var_22 = 0; var_22 < 3; var_22++ )
                    hide_avatar( var_0.clan_agents[var_22] );

                lobby_update_group_new( var_27, var_10, var_30, var_0.avatar_spawnpoint );
                vlobby_vegnette( 1, "ac130_overlay_pip_vignette_vlobby" );
            }
            else
                var_30.caotolobbyframetimer -= 1;
        }

        if ( level.in_firingrange )
            vlobby_vegnette( 0, "ac130_overlay_pip_vignette_vlobby" );

        wait 0.05;
    }
}

tablelookupweaponoffsets( var_0, var_1, var_2 )
{
    var_3 = float( tablelookup( "mp/vlobby_cac_offsets.csv", var_1, var_0, var_2 ) );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    return var_3;
}

storecameratargets( var_0 )
{
    var_1 = getentarray( "player_pos", "targetname" );
    var_0.camerhelperarray = [];

    foreach ( var_3 in var_1 )
        var_0.camerhelperarray[var_0.camerhelperarray.size] = var_3;

    foreach ( var_3 in var_1 )
    {
        var_6 = getent( var_3.target, "targetname" );

        if ( var_6.script_noteworthy == "camera_target" )
            var_3.camera_lookat = var_6;

        var_7 = getent( var_6.target, "targetname" );

        if ( var_7.script_noteworthy == "camera" )
        {
            var_3.camera_helper = var_7;
            var_7.camera_goal = var_3;
            var_7.camera_lookat = var_3.camera_lookat;
        }

        if ( var_3.script_noteworthy == "0" )
            level.camparams.last_camera_helper = var_3.camera_helper;

        var_8 = int( var_3.script_noteworthy );
        var_0.camerhelperarray[var_8] = var_3;
    }
}

calc_target_dir( var_0, var_1, var_2 )
{
    var_3 = var_1 - var_0;
    var_4 = length2d( var_3 );
    var_5 = var_4 / sqrt( 1 + var_2.cur_camoffset_ratio * var_2.cur_camoffset_ratio );
    var_6 = var_3[0] - var_2.cur_camoffset_ratio * var_3[1];
    var_7 = var_2.cur_camoffset_ratio * var_3[0] + var_3[1];
    var_8 = var_5 * vectornormalize( ( var_6, var_7, 0 ) );
    var_8 += ( 0, 0, var_3[2] );
    return var_8;
}

hacky_get_delta_xrot( var_0, var_1 )
{
    var_2 = var_1 - var_0.oldrotx;

    if ( var_2 < -180 )
        var_2 = 360 + var_2;
    else if ( var_2 > 180 )
        var_2 = 360 - var_2;

    var_0.oldrotx = var_1;
    return var_2;
}

hacky_get_delta_yrot( var_0, var_1 )
{
    var_2 = var_1 - var_0.oldroty;

    if ( var_2 < -180 )
        var_2 = -1;
    else if ( var_2 > 180 )
        var_2 = 1;
    else
        var_2 = 0;

    var_0.oldroty = var_1;
    return var_2;
}

cammove( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.cut ) )
        self.origin = var_0;
    else
        self _meth_82AE( var_0, var_1, var_2, var_3 );
}

camrotate( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.cut ) )
        self.angles = var_0;
    else
        self _meth_82B5( var_0, var_1, var_2, var_3 );
}

rotateavatartagcamera( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_2 = spawnstruct();
        var_2.camera_tag_origin = ( -70.8, -691.3, 502.2 );
        var_2.camera_tag_angles = ( 0, 87, 0 );
        return var_2;
    }

    var_3 = var_0 gettagorigin( "TAG_STOWED_BACK" );
    var_4 = var_0 gettagangles( "TAG_STOWED_BACK" );
    var_5 = var_0.spawn_angles[1] - var_0.angles[1];
    var_6 = ( 0, 0, 1 );
    var_7 = var_3 - var_0.origin;
    var_8 = rotatepointaroundvector( var_6, var_7, var_5 );
    var_9 = var_0.origin + var_8;
    var_0.camera_tag_origin = var_9;
    var_0.camera_tag_angles = ( var_4[0], angleclamp( var_4[1] + var_5 ), var_4[2] );
    var_2 = spawnstruct();
    var_2.camera_tag_origin = var_0.camera_tag_origin;
    var_2.camera_tag_angles = var_0.camera_tag_angles;
    return var_2;
}

checkcamposition( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 2;

    var_3 = distance( var_1, var_0.origin );

    if ( var_3 >= var_2 )
        return 1;
    else
        return 0;
}

lobby_update_group_new( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
    {
        level.camparams.framedelay = level.camparams.pre_lobby_framedelay;
        var_4 = var_0.startangles;

        if ( isdefined( var_3 ) )
            var_4 = ( 0, var_3.angles[1] + 180, 0 );

        var_5 = var_0.startorigin;
        var_6 = distance( var_0.origin, var_5 );
        var_7 = var_6 / var_2.prelobby_movespeed;

        if ( var_7 < 0.1 )
            var_7 = 0.1;

        var_0 cammove( var_5, var_7, var_7 * 0.5, var_7 * 0.5 );
        var_0 camrotate( var_4, var_7, var_7 * 0.5, var_7 * 0.5 );
    }
    else
    {
        if ( level.camparams.framedelay == level.camparams.pre_lobby_framedelay )
            maps\mp\_vl_base::prep_for_controls( var_1, var_1.angles );

        var_4 = ( 0, 87, 0 );

        if ( isdefined( var_1.avatar_spawnpoint ) )
            var_4 = ( 0, var_1.avatar_spawnpoint.angles[1] + 180, 0 );

        var_8 = var_1 gettagorigin( "TAG_STOWED_BACK" );

        if ( !isdefined( var_1.camera_state ) )
            var_1.camera_state = "stand";

        if ( var_1.camera_state == "crouch" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_crouchdistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_crouchz );
        }
        else if ( var_1.camera_state == "hunch" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_hunchdistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_hunchz );
        }
        else if ( var_1.camera_state == "stand" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_normaldistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_normalz );
        }
        else if ( var_1.camera_state == "zoom_high" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_closedistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_upclosez );
        }
        else
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_normaldistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_normalz );
        }

        var_0.goal_location = var_10;
        var_11 = 0;

        if ( level.camparams.framedelay == 0 )
            var_11 = checkcamposition( var_0, var_10, 1.5 );

        var_2.cur_camoffset_ratio = var_2.gamelobbygroup_camoffset_angle_ratio;
        var_2.tgt_camoffset_ratio = var_2.gamelobbygroup_camoffset_angle_ratio;
        var_0 update_camera_params_ratio( var_2 );
        var_12 = 0;
        var_13 = 0;
        var_6 = distance( var_0.origin, var_10 );
        var_7 = var_6 / var_2.gamelobby_movespeed;

        if ( var_7 < 0.1 )
            var_7 = 0.1;

        var_14 = var_6 / var_2.gamelobby_movespeed * level.camparams.gamelobbygroup_movespeed_modifier;

        if ( var_14 < 0.1 )
            var_14 = 0.1;

        var_15 = 1;
        var_16 = getdvarint( "virtualLobbyMode", 0 );

        if ( var_16 != 2 && var_16 != 4 && var_16 != 3 )
            maps\mp\_vl_base::rightstickrotateavatar( var_1, 0.5 );
        else if ( var_16 == 4 || var_16 == 3 )
        {
            maps\mp\_vl_base::prep_for_controls( var_1, var_1.angles );
            var_0.cut = 1;
        }
        else if ( var_16 == 2 )
            maps\mp\_vl_base::prep_for_controls( var_1, var_1.angles );

        if ( level.camparams.framedelay > 0 )
            level.camparams.framedelay -= 1;

        if ( isdefined( var_1.avatar_spawnpoint ) && isdefined( var_0.avatar_spawnpoint ) && var_1.avatar_spawnpoint != var_0.avatar_spawnpoint )
        {
            var_0.lastavatarpositionent = var_0.avatar_spawnpoint;
            var_0.avatar_spawnpoint = var_1.avatar_spawnpoint;
            var_2.goal = "finding_new_position";
            var_11 = 1;
            var_0.finished = 0;
        }
        else if ( var_11 == 1 )
            var_2.goal = "moving";

        if ( var_2.goal == "waiting" )
        {
            if ( var_11 == 1 )
            {
                var_2.goal = "moving";
                var_0.finished = 1;
            }

            var_0.last_avatar_position = var_1.avatar_spawnpoint;
        }

        if ( var_2.goal == "finding_new_position" )
        {
            if ( var_11 == 1 )
            {
                var_0.lastavatarpositionent = var_0.avatar_spawnpoint;
                var_0.avatar_spawnpoint = var_1.avatar_spawnpoint;
                var_0.obstacles = [];
                var_17 = 16;

                foreach ( var_19 in level.vlavatars )
                {
                    var_20 = [];
                    var_20["center"] = var_19.avatar_spawnpoint.origin;
                    var_20["radius"] = var_17;
                    var_0.obstacles[var_0.obstacles.size] = var_20;
                }

                build_path_info( var_0, var_2, var_0.origin, var_10, var_4 );
                var_0.fparams = calc_f_from_avatar( var_1 );
                var_0.target_from_avatar = get_target_from_avatar( var_1 );
                var_2.goal = "moving";
            }

            var_2.goal = "moving";
        }

        if ( var_2.goal == "moving" )
        {
            if ( level.camparams.framedelay <= 0 )
            {
                level.camparams.framedelay = 0;

                if ( var_0.finished == 0 )
                {
                    if ( isdefined( var_0.cut ) )
                    {
                        var_0 cammove( var_10, var_7, var_12, var_13 );
                        var_0 camrotate( var_4, var_15, var_15 * 0.5, var_15 * 0.5 );
                        var_0.finished = 1;
                    }
                    else
                        var_0.finished = update_camera_on_path( var_0, var_2 );
                }

                if ( var_0.finished )
                {
                    var_0 cammove( var_10, var_14, var_14 * 0.5, var_14 * 0.5 );
                    var_0 camrotate( var_4, var_14, var_14 * 0.5, var_14 * 0.5 );
                    var_2.goal = "waiting";
                }
            }
        }

        level.players[0] set_avatar_dof();
    }

    if ( isdefined( var_0.cut ) )
    {
        var_0 _meth_8092();
        var_0.cut = undefined;
    }

    if ( getdvarint( "virtualLobbyReady", 0 ) == 0 )
    {
        wait 1.0;
        setdvar( "virtualLobbyReady", "1" );
        thread setvirtuallobbypresentable();
    }
}

setvirtuallobbypresentable()
{
    level notify( "cancel_vlp" );
    level endon( "cancel_vlp" );

    if ( level.vlavatars.size > 0 && isdefined( level.vlavatars[0] ) && isdefined( level.vlavatars[0].primaryweapon ) && isweaponloaded( level.vlavatars[0].primaryweapon ) )
    {
        level.needtopresent = undefined;
        wait 0.5;
        setdvar( "virtualLobbyPresentable", "1" );
    }
    else
        level.needtopresent = 1;
}

resetvirtuallobbypresentable()
{
    level notify( "cancel_vlp" );
    level endon( "cancel_vlp" );
    level.needtopresent = undefined;
    wait 0.25;
    setdvar( "virtualLobbyPresentable", "0" );
}

moveplayereyetocam( var_0 )
{
    var_1 = level.players[0];
    var_2 = var_1 _meth_80A8();
    var_3 = var_2 - var_1.origin;
    var_1 setorigin( var_0.origin - var_3, 0 );
    var_1 setangles( ( var_1.angles[0], var_0.angles[1], var_1.angles[2] ) );
}

getaspectratio()
{
    var_0 = spawnstruct();
    var_1 = getdvar( "r_mode", "1280x720 [16:9]" );
    var_2 = strtok( var_1, " " );
    var_3 = strtok( var_2[0], "x" );
    var_0.width = maps\mp\_utility::stringtofloat( var_3[0] );
    var_0.height = maps\mp\_utility::stringtofloat( var_3[1] );
    var_0.aspectratio = maps\mp\_utility::rounddecimalplaces( var_0.width / var_0.height, 3 );
    return var_0;
}

getmodifiedrotationangle( var_0, var_1, var_2 )
{
    if ( abs( var_1 - var_0.rotation_total ) > 100 )
    {
        if ( var_1 >= 270 )
        {
            var_0.addtobaseangle += -360 * var_2;

            if ( var_0.addtobaseangle == -360 )
                var_0.addtobaseangle = 0;
        }

        if ( var_1 <= 100 )
        {
            var_0.addtobaseangle += 360 * var_2;

            if ( var_0.addtobaseangle == 360 )
                var_0.addtobaseangle = 0;
        }
    }

    var_0.rotation_total = var_1;
    var_3 = var_1 * var_2 + var_0.addtobaseangle;
    return var_3;
}

cao_update( var_0, var_1, var_2 )
{
    maps\mp\_vl_base::rightstickrotateavatar( var_1, 0.5 );
    var_2.caotolobbyframetimer = var_2.caotolobbyframedelay;
    var_3 = var_1.origin + ( 0, 0, -20 ) + anglestoforward( var_1.spawn_angles ) * 120;
    var_2.zoom = var_2.cao_camera_ratio;
    var_2.dist = var_2.cao_neardist + ( var_2.cao_fardist - var_2.cao_neardist ) * var_2.zoom;
    var_4 = var_2.cao_camerazoff + var_2.cao_camerazoff_zoom * var_2.zoom;
    var_5 = var_2.cao_targetzoff + var_2.cao_targetzoff_zoom * ( 1 - var_2.zoom );
    var_2.tgt_camoffset_ratio = var_2.cao_camoffset_ratio + var_2.prelobby_ratio_zoom * ( var_2.zoom - 1 );
    var_0 update_camera_params_ratio( var_2 );
    var_6 = var_2.ch_cyl_zoff_near + ( var_2.ch_cyl_zoff_far - var_2.ch_cyl_zoff_near ) * var_2.zoom;
    var_7 = var_1.origin + ( 0, 0, var_5 );
    var_8 = var_7 - var_3 + var_2.origin_offset;
    var_8 = var_2.dist * vectornormalize( var_8 );
    var_8 = ( var_8[0], var_8[1], -1 * var_4 );
    var_8 = var_2.dist * vectornormalize( var_8 );
    var_9 = var_7 - var_8;

    if ( isdefined( level.caoavatarposoffset ) )
    {
        var_7 += level.caoavatarposoffset;
        var_9 += level.caoavatarposoffset;
    }

    var_10 = -1 * var_8;
    var_11 = vectortoangles( var_10 );
    var_2.angle = var_11[1] - var_1.startangles[1];
    var_12 = distance( var_0.origin, var_9 );
    var_13 = var_12 / var_2.prelobby_movespeed;

    if ( var_13 < 0.1 )
        var_13 = 0.1;

    var_0 cammove( var_9, var_13, var_13 * 0.5, var_13 * 0.5 );
    var_14 = calc_target_dir( var_9, var_7, var_2 );
    var_15 = vectortoangles( var_14 );
    var_0 camrotate( var_15, var_13, var_13 * 0.5, var_13 * 0.5 );

    if ( isdefined( var_0.cut ) )
    {
        var_0 _meth_8092();
        var_0.cut = undefined;
    }
}

start_menu_update( var_0, var_1 )
{

}

clan_profile_update( var_0, var_1, var_2 )
{
    var_3 = ( 0, 87, 0 );

    if ( isdefined( var_1.avatar_spawnpoint ) )
        var_3 = ( 0, var_1.avatar_spawnpoint.angles[1] + 180, 0 );

    var_0 update_camera_params_ratio( var_2 );
    var_4 = ( 14, 0, 0 );
    var_5 = var_1.origin + var_4 + anglestoforward( var_1.avatar_spawnpoint.angles ) * 110;
    var_6 = ( var_5[0], var_5[1], var_2.gamelobbygroup_camera_normalz );
    var_0.goal_location = var_6;
    var_7 = distance( var_0.origin, var_6 );
    var_8 = max( var_7 / var_2.gamelobby_movespeed, 0.1 );
    var_9 = 0.2;
    var_0 cammove( var_6, var_8, 0, 0 );
    var_0 camrotate( var_3, var_9, 0, 0 );
    maps\mp\_vl_base::rightstickrotateavatar( var_1, 0.5 );
}

monitor_vl_mode_change()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = getdvarint( "virtualLobbyMode", 0 );

        if ( level.camparams.mode != "cao" )
        {
            if ( level.camparams.mode != "prelobby" && var_0 == 0 )
                level.camparams.newmode = "game_lobby";

            if ( common_scripts\utility::string_find( level.camparams.mode, "prelobby" ) >= 0 && var_0 == 1 )
                level.camparams.newmode = "game_lobby";
        }

        wait 0.05;
    }
}

findpositionnum()
{
    var_0 = self.script_noteworthy;
    var_0 = int( var_0 );
    return var_0;
}

monitor_player_removed()
{
    self waittill( "disconnect" );
    self.camera delete();
    maps\mp\_vl_base::vlprint( "remove all ownerIds due to disconnect\\n" );

    foreach ( var_2, var_1 in level.xuid2ownerid )
        remove_avatar( var_1 );
}

set_agent_values( var_0, var_1 )
{
    maps\mp\agents\_agent_utility::set_agent_team( var_0 );
    self.agent_gameparticipant = 0;
    self.isactive = 1;
    self.spawntime = gettime();
    self.issniper = 0;
    self.sessionteam = var_1;
}

bot_disable_tactical_goals()
{
    self.disable_tactical_goals = 1;
    self.tactical_goals = [];
}

wait_load_costume_show( var_0 )
{
    if ( isalive( var_0 ) )
    {
        var_1 = isdefined( level.cac );
        var_2 = getdvarint( "practiceroundgame" ) && var_0.ownerid != 0;

        if ( !var_1 && !var_2 )
            show_avatar( var_0 );
    }
}

wait_load_costume_timeout( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "wait_load_costume" );
    var_1 endon( "death" );
    wait(var_0);
    wait_load_costume_show( var_1 );
    var_1 notify( "wait_load_costume" );
}

wait_load_costume( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 notify( "wait_load_costume" );
    var_0 endon( "wait_load_costume" );
    var_0 endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    hide_avatar( var_0 );
    thread wait_load_costume_timeout( 5.0, var_0 );

    for ( var_2 = self _meth_84EF( var_0.costume, var_0.team ); !var_2; var_2 = self _meth_84EF( var_0.costume, var_0.team ) )
        wait 0.1;

    if ( var_1 )
        wait_load_costume_show( var_0 );

    var_0 notify( "wait_load_costume" );
}

spawn_an_avatar( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( var_10 ) )
        var_10 = 0;

    if ( !isdefined( var_11 ) )
        var_11 = 0;

    var_12 = !var_11;
    var_13 = "spectator";
    var_14 = "none";
    var_15 = maps\mp\_vl_base::alloc_avatar();
    var_0.spawned_avatar = var_15;
    var_15.avatar_spawnpoint = var_0;
    var_15.costume = var_7;
    var_15.activecostume = 0;
    var_15.rotation_offset = 0;
    var_15 set_agent_values( var_13, var_14 );
    var_16 = getgroundposition( var_15.avatar_spawnpoint.origin, 20, 512, 120 );
    var_15.spawn_angles = ( var_0.angles[0], var_0.angles[1] + var_15.rotation_offset, var_0.angles[2] );
    var_15.angles = var_15.spawn_angles;

    if ( !var_11 )
        var_15 show();

    var_15.ownerid = var_9;
    var_15 setangles( var_15.spawn_angles );
    var_15 setorigin( var_16, 1 );
    var_15.angles = var_15.spawn_angles;
    var_15.startangles = var_15.spawn_angles;
    var_15.storedangley = var_15.angles[1];
    var_15.mouserot = 0;
    var_15.storedrightsticky = 0;
    var_15.rotation_total = 0;
    var_15.addtobaseangle = 0;
    var_15.rotation_parent = spawn( "script_origin", var_15.origin );
    var_15.camera_cut = 1;
    var_15.camera_tag_origin = ( 0, 0, 0 );
    var_15.camera_tag_angles = ( 0, 0, 0 );
    var_15 _meth_83FC();

    if ( !isdefined( self.spawned_avatar ) )
        self.spawned_avatar = var_15;

    var_15 _meth_83D1( 1 );

    if ( var_10 == 1 )
    {
        var_15.is_cao_agent = 1;
        var_1 = undefined;
        var_15.primaryweapon = undefined;
        var_3 = undefined;
        var_15 use_animstate( "cao_01", 1, "lobby_idle" );
    }
    else if ( var_11 == 1 )
    {
        var_1 = undefined;
        var_15.primaryweapon = undefined;
        var_3 = undefined;
        var_15 use_animstate( "cao_01", 1, "lobby_idle" );
    }
    else
    {
        level.vlavatars[var_9] = var_15;
        var_17 = var_15 getanimdata( var_3 );
        var_15 use_animstate( var_17.alias, 1, var_17.animstate );
        var_15 thread checkweapchange( var_1 );
    }

    var_15 maps\mp\gametypes\_spawnlogic::addtocharactersarray();

    if ( isalive( var_15 ) )
    {
        vl_avatar_loadout( undefined, var_9, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_15 );

        if ( level.players.size > 0 )
            level.players[0] thread wait_load_costume( var_15, var_12 );
    }

    if ( isdefined( level.cac ) )
    {

    }

    if ( getdvarint( "practiceroundgame" ) && var_9 != 0 || var_11 )
        hide_avatar( var_15 );
    else
        show_avatar( var_15 );

    return var_15;
}

checkweapchange( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "free_avatar" );

    if ( !isdefined( self.primaryweapon ) )
        self.primaryweapon = var_0;

    self.stored_weapon = self.primaryweapon;
    var_1 = undefined;

    for (;;)
    {
        if ( !isdefined( self.primaryweaponent ) || !isdefined( self.akimboweaponent ) )
        {
            wait 0.05;
            continue;
        }

        if ( isdefined( self ) && isdefined( self.primaryweapon ) && isalive( self ) )
        {
            var_2 = strtok( self.primaryweapon, "_" );

            if ( ( issubstr( var_2[1], "dlcgun3" ) || var_2[1] == "dlcgun10loot5" || var_2[1] == "dlcgun5loot5" ) && common_scripts\utility::array_contains( var_2, "akimbo" ) )
                var_1 = var_2[0] + "_" + var_2[1] + "_akimbo";
            else
                var_1 = var_2[0] + "_" + var_2[1];
        }

        var_3 = self _meth_83D3();
        var_4 = self _meth_83D3( "lobby_idle", "cao_01" );
        var_5 = getanimdata( var_1 );
        var_6 = self _meth_83D3( var_5.animstate, var_5.alias );

        if ( isdefined( level.camparams.mode ) )
        {
            if ( level.camparams.newmode != "cao" && level.camparams.mode != "cao" )
            {
                if ( isdefined( self ) && isdefined( var_1 ) && isalive( self ) )
                {
                    var_9 = isweaponloaded( self.primaryweapon );
                    var_10 = self.stored_weapon != self.primaryweapon;
                    var_11 = var_10 || var_3 != var_6;
                    var_12 = getweaponbasename( self.stored_weapon ) != getweaponbasename( self.primaryweapon );

                    if ( var_11 )
                    {
                        if ( var_9 )
                        {
                            if ( var_12 )
                            {
                                hide_avatar_primary_weapon( self );
                                hide_avatar_akimbo_weapon( self );
                                thread attachweapondelayed( self );
                                thread showprimarydelayed( self );
                            }

                            self.primaryweaponent _meth_8483( self.primaryweapon );
                            self.akimboweaponent _meth_8483( self.primaryweapon );

                            if ( issubstr( self.primaryweapon, "akimbo" ) || issubstr( self.primaryweapon, "akimboxmg" ) )
                            {
                                if ( var_12 )
                                    thread showakimbodelayed( self );
                            }
                            else
                            {
                                self.akimboweaponent hide();
                                self.akimboweaponent _meth_804A();
                            }

                            self.stored_weapon = self.primaryweapon;
                            var_5 = getanimdata( var_1 );
                            self.camera_state = var_5.camera_state;
                            thread animdelayed( var_5.alias, var_5.animstate );
                            thread vl_vfx_for_avatar();
                        }
                        else
                        {

                        }
                    }
                }
            }
        }

        wait 0.5;
    }
}

isweaponloaded( var_0 )
{
    var_1 = 0;

    if ( level.players.size > 0 )
    {
        var_1 = level.players[0] _meth_8535( var_0 );

        if ( !var_1 )
            level.players[0] _meth_8511( var_0 );
    }

    return var_1;
}

attachweapondelayed( var_0 )
{
    wait(level.camparams.cacweaponattachdelaytime);
    attachprimaryweapon( var_0 );
}

animdelayed( var_0, var_1 )
{
    wait(level.camparams.cacweaponanimdelaytime);
    use_animstate( var_0, undefined, var_1 );
}

getanimdata( var_0 )
{
    var_1 = spawnstruct();
    var_1.alias = var_0;

    if ( isdefined( var_0 ) && var_0 != "" && var_0 != "none" )
    {
        var_1.animstate = tablelookup( "mp/vlobby_cac_offsets.csv", 0, var_0, 5 );
        var_1.camera_state = tablelookup( "mp/vlobby_cac_offsets.csv", 0, var_0, 6 );

        if ( isdefined( var_1.camera_state ) )
            self.camera_state = var_1.camera_state;
    }

    if ( !isdefined( var_1.animstate ) || var_1.animstate == "" )
    {
        var_1.animstate = "lobby_idle";
        var_1.alias = "cao_01";
        var_1.camera_state = "stand";
    }

    self _meth_83D0( "vlobby_animclass" );

    if ( !isdefined( var_1.camera_state ) )
        var_1.camera_state = "stand";

    if ( !isdefined( self.camera_state ) )
        self.camera_state = var_1.camera_state;

    return var_1;
}

vl_give_weapons( var_0, var_1 )
{
    if ( var_1.isfree )
        return;

    addlaunchers( var_1 );

    if ( !isdefined( var_1.primaryweapon ) )
        return;

    if ( !isdefined( var_1.animalias ) )
        return;

    if ( var_1.primaryweapon != "none" )
    {
        if ( !isdefined( var_1.primaryweaponent ) )
        {
            var_2 = spawn( "weapon_" + var_1.primaryweapon, ( 0, 0, 0 ) );
            var_3 = get_xuid_for_avatar( var_1 );
            _func_2D4( var_2, var_3 );
            var_1.primaryweaponent = var_2;
            var_2.primaryweapon = var_1.primaryweapon;
            var_1.primaryweaponent show();
            var_1.primaryweaponent _meth_804C();
            var_1.primaryweaponent _meth_8483( var_1.primaryweapon );
            attachprimaryweapon( var_1 );
        }
        else if ( var_1.primaryweaponent.primaryweapon != var_1.primaryweapon )
            var_1.primaryweaponent.primaryweapon = var_1.primaryweapon;

        if ( !isdefined( var_1.akimboweaponent ) )
        {
            var_4 = spawn( "weapon_" + var_1.primaryweapon, ( 0, 0, 0 ) );
            var_3 = get_xuid_for_avatar( var_1 );
            _func_2D4( var_4, var_3 );
            var_1.akimboweaponent = var_4;
            var_4.primaryweapon = var_1.primaryweapon;
        }
        else if ( var_1.akimboweaponent.primaryweapon != var_1.primaryweapon )
            var_1.akimboweaponent.primaryweapon = var_1.primaryweapon;

        var_5 = "tag_weapon_left";

        if ( issubstr( var_1.akimboweaponent.primaryweapon, "combatknife" ) )
            var_5 = "tag_inhand";

        if ( issubstr( var_1.akimboweaponent.primaryweapon, "riotshield" ) )
            var_5 = "tag_weapon_left";

        var_1.akimboweaponent _meth_804F();
        var_1.akimboweaponent.origin = var_1 gettagorigin( var_5 );
        var_1.akimboweaponent.angles = var_1 gettagangles( var_5 );
        var_1.akimboweaponent _meth_8446( var_1, var_5 );
        var_1.akimboweaponent _meth_8530( var_0 );

        if ( issubstr( var_1.primaryweaponent.primaryweapon, "akimbo" ) || issubstr( var_1.primaryweaponent.primaryweapon, "akimboxmg" ) )
            thread showakimbodelayed( var_1 );
        else if ( !isdefined( var_1.stored_weapon ) )
        {
            var_1.akimboweaponent hide();
            var_1.akimboweaponent _meth_804A();
        }
    }

    if ( var_1.secondaryweapon != "none" )
    {
        if ( issubstr( var_1.secondaryweapon, "combatknife" ) )
        {
            if ( isdefined( var_1.secondaryweaponent ) )
            {
                if ( var_1.secondaryweaponent _meth_8068() )
                    var_1.secondaryweaponent _meth_804F();

                var_1.secondaryweaponent delete();
            }
        }
        else
        {
            if ( !isdefined( var_1.secondaryweaponent ) )
            {
                var_6 = spawn( "weapon_" + var_1.secondaryweapon, ( 0, 0, 0 ) );
                var_3 = get_xuid_for_avatar( var_1 );
                _func_2D4( var_6, var_3 );
                var_1.secondaryweaponent = var_6;
                var_6.secondaryweapon = var_1.secondaryweapon;
            }
            else if ( var_1.secondaryweaponent.secondaryweapon != var_1.secondaryweapon )
            {
                var_1.secondaryweaponent _meth_8483( var_1.secondaryweapon );
                var_1.secondaryweaponent.secondaryweapon = var_1.secondaryweapon;
            }

            var_7 = "tag_stowed_back";
            var_1.secondaryweaponent _meth_804F();
            var_1.secondaryweaponent.origin = var_1 gettagorigin( var_7 );
            var_1.secondaryweaponent.angles = var_1 gettagangles( var_7 );
            var_1.secondaryweaponent _meth_8446( var_1, var_7 );
            var_1.secondaryweaponent _meth_804C();
            var_1.secondaryweaponent _meth_8530( var_0 );
        }
    }
    else
    {

    }
}

attachprimaryweapon( var_0 )
{
    var_1 = undefined;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;

    var_2 = "tag_weapon_right";

    if ( issubstr( var_0.primaryweaponent.primaryweapon, "combatknife" ) )
        var_2 = "tag_inhand";

    if ( issubstr( var_0.primaryweaponent.primaryweapon, "riotshield" ) )
        var_2 = "tag_weapon_left";

    var_0.primaryweaponent _meth_804F();
    var_0.primaryweaponent.origin = var_0 gettagorigin( var_2 );
    var_0.primaryweaponent.angles = var_0 gettagangles( var_2 );
    var_0.primaryweaponent _meth_8446( var_0, var_2 );
    var_0.primaryweaponent _meth_8530( var_1 );
}

addlaunchers( var_0 )
{
    var_0 detach( "npc_exo_arm_launcher_R", "J_Elbow_RI", 0 );
    var_0 detach( "npc_exo_arm_launcher_L", "J_Elbow_LE", 0 );

    if ( isdefined( var_0.lethal ) && var_0.lethal != "specialty_null" )
    {
        if ( !var_0 maps\mp\_utility::_hasperk( "specialty_wildcard_dualtacticals" ) )
            var_0 attach( "npc_exo_arm_launcher_R", "J_Elbow_RI", 1 );
        else
        {

        }
    }

    if ( isdefined( var_0.tactical ) && var_0.tactical != "specialty_null" )
    {
        if ( var_0 maps\mp\_utility::_hasperk( "specialty_wildcard_duallethals" ) )
            var_0 attach( "npc_exo_arm_launcher_L", "J_Elbow_LE", 1 );
        else
        {

        }
    }
}

showakimbodelayed( var_0 )
{
    var_0 endon( "death" );
    var_0.primaryweaponent endon( "death" );
    var_0 endon( "hide_akimbo_weapon" );
    wait(level.camparams.cacweapondelaytime);

    if ( level.camparams.newmode != "cao" && level.camparams.mode != "cao" )
    {
        if ( issubstr( var_0.primaryweaponent.primaryweapon, "akimbo" ) || issubstr( var_0.primaryweaponent.primaryweapon, "akimboxmg" ) )
        {
            var_0.akimboweaponent show();
            var_0.akimboweaponent _meth_804C();
        }
    }
}

showprimarydelayed( var_0 )
{
    var_0 endon( "death" );
    var_0.primaryweaponent endon( "death" );
    var_0 endon( "hide_primary_weapon" );
    wait(level.camparams.cacweapondelaytime);

    if ( var_0.isfree )
        return;

    var_1 = getdvarint( "practiceroundgame" ) && var_0.ownerid != 0;

    if ( level.camparams.newmode != "cao" && level.camparams.mode != "cao" && !var_1 )
    {
        var_0.primaryweaponent show();
        var_0.primaryweaponent _meth_804C();
    }
}

vl_avatar_costume( var_0, var_1, var_2 )
{
    var_0 _meth_8310();
    var_0 detachall();
    var_0.headmodel = undefined;

    if ( isdefined( var_1 ) )
        var_0.costume = var_1;

    if ( !isdefined( var_0.costume ) || !maps\mp\gametypes\_teams::validcostume( var_0.costume ) )
    {
        if ( isdefined( var_0.sessioncostume ) && maps\mp\gametypes\_teams::validcostume( var_0.sessioncostume ) )
            var_0.costume = var_0.sessioncostume;
        else
        {
            var_0.costume = maps\mp\gametypes\_teams::getdefaultcostume();
            var_0.sessioncostume = var_0.costume;
        }
    }

    if ( isdefined( var_2 ) && var_2 )
    {
        level.players[0].costume = var_0.costume;
        var_3 = level.players[0] maps\mp\gametypes\_teams::playercostume();
        var_3 = var_0 maps\mp\gametypes\_teams::playercostume();
        var_4 = level.players[0].cao_agent;
        vl_avatar_costume( var_4, var_0.costume );
        var_3 = var_4 maps\mp\gametypes\_teams::playercostume();
    }
}

vl_avatar_loadout( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_9 ) )
        var_9 = level.vlavatars[var_1];

    var_10 = 0;

    if ( isdefined( var_9.loadout ) && var_9.loadout.player_controller >= 0 )
        var_10 = 1;

    vl_avatar_costume( var_9, var_8 );
    var_9 maps\mp\gametypes\_teams::playermodelforweapon( var_4, maps\mp\_utility::getbaseweaponname( var_3 ) );

    if ( var_10 && isdefined( level.players[0] ) )
        level.players[0] _meth_84BA( var_9.costume );

    var_9.primaryweapon = var_2;
    var_9.secondaryweapon = "none";
    var_9.tactical = var_6;
    var_9.lethal = var_5;
    var_9.perks = var_7;
    vl_give_weapons( var_0, var_9 );
    var_9 thread vl_vfx_for_avatar();
}

monitor_class_select_or_weapon_change( var_0 )
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_1, var_2 );

        if ( ( var_1 == "classpreview" || var_1 == "classpreview_postcopy" ) && isdefined( var_2 ) )
        {
            if ( var_2 >= 0 )
            {
                var_3 = var_2 & 15;
                var_4 = int( var_2 / 16 );
                maps\mp\_vl_base::vlprint( "classpreview " + var_1 + " controller=" + var_3 + "  class=" + var_4 );

                if ( var_4 > 0 )
                {
                    level.cac = 1;
                    self.currentselectedclass = var_4 - 1;
                }

                var_0 = getfocusfromcontroller( var_3 );
                var_5 = var_1 == "classpreview_postcopy";
                var_6 = level.vlavatars[var_0];

                if ( isdefined( var_6 ) )
                {
                    level.vl_focus = var_0;
                    level.vl_local_focus = var_0;
                    virtual_lobby_set_class( var_0, "lobby" + ( self.currentselectedclass + 1 ), !var_5 );
                    level.cac_weapon = var_6.primaryweapon;
                }

                level.forceavatarrefresh = var_5;
                continue;
            }

            level.cac = undefined;
        }
    }
}

monitor_cac_set_weapon( var_0, var_1 )
{
    var_2 = "";

    if ( var_1 != "current" && var_1 != "none" && var_2 == "" )
    {
        var_3 = tablelookup( "mp/statstable.csv", 4, var_1, 40 );

        if ( var_3 == "" )
            var_3 = "none";

        var_4 = maps\mp\gametypes\_class::buildweaponname( var_1, var_3, "none", "none" );
    }
    else if ( var_1 == "none" )
        var_4 = "none";
    else
    {
        var_5 = level.vlavatars[var_0];
        var_4 = var_5.primaryweapon;
    }

    level.cac_weapon = var_4;
}

has_suffix( var_0, var_1 )
{
    if ( var_0.size >= var_1.size )
    {
        if ( getsubstr( var_0, var_0.size - var_1.size, var_0.size ) == var_1 )
            return 1;
    }

    return 0;
}

monitor_create_a_class( var_0 )
{
    self endon( "disconnect" );
    var_1 = [];

    while ( !isdefined( level.camparams ) )
    {
        self waittill( "luinotifyserver", var_2, var_3 );

        if ( isdefined( var_3 ) )
        {
            var_1[var_1.size] = [ var_2, var_3 ];
            continue;
        }

        var_1[var_1.size] = [ var_2 ];
    }

    for (;;)
    {
        if ( var_1.size > 0 )
        {
            var_4 = var_1[0];
            var_5 = [];

            for ( var_6 = 1; var_6 < var_1.size; var_6++ )
                var_5[var_5.size] = var_1[var_6];

            var_1 = var_5;
            var_2 = var_4[0];

            if ( var_4.size > 1 )
                var_3 = var_4[1];
            else
                var_3 = undefined;
        }
        else
            self waittill( "luinotifyserver", var_2, var_3 );

        if ( var_2 == "cac" && isdefined( var_3 ) )
        {
            if ( var_3 == 0 )
                level.cac = undefined;
            else
                level.cac = 1;

            level.vl_cao_focus = undefined;
            continue;
        }

        if ( var_2 == "weapon_highlighted" && isdefined( var_3 ) )
        {
            if ( issubstr( var_3, "stream:" ) )
            {
                var_7 = strtok( var_3, ":" );

                if ( var_7.size > 1 )
                {
                    var_8 = var_7[var_7.size - 1];

                    if ( !has_suffix( var_8, "_mp" ) )
                        var_8 += "_mp";

                    maps\mp\_vl_base::vlprintln( "weapon_stream: " + var_8 );
                    var_9 = [ var_8 ];
                    self _meth_8511( var_9 );
                }

                monitor_cac_set_weapon( var_0, "none" );
            }
            else
            {
                maps\mp\_vl_base::vlprintln( "weapon_highlighted  " + var_3 );
                monitor_cac_set_weapon( var_0, var_3 );
            }

            continue;
        }

        if ( var_2 == "lootscreen_weapon_highlighted" && isdefined( var_3 ) )
        {
            if ( var_3 == "none" )
                level.cac = undefined;
            else if ( var_3 == "reset" )
                level.cac = 1;
            else
                level.cac = 1;

            level.vl_cao_focus = undefined;
            continue;
        }

        var_10 = 0;

        if ( var_2 == "preview_attach1" )
            var_10 = 1;
        else if ( var_2 == "preview_attach2" )
            var_10 = 2;
        else if ( var_2 == "preview_attach3" )
            var_10 = 3;

        if ( var_10 > 0 && isdefined( var_3 ) )
        {
            var_11 = level.vlavatars[var_0];
            var_12 = var_11.loadout;
            var_13 = tablelookup( "mp/statstable.csv", 0, var_12.primary, 4 );
            var_14 = tablelookup( "mp/attachmenttable.csv", 0, var_12.primaryattachment1, 3 );
            var_15 = tablelookup( "mp/attachmenttable.csv", 0, var_12.primaryattachment2, 3 );
            var_16 = tablelookup( "mp/attachmenttable.csv", 0, var_12.primaryattachment3, 3 );
            var_17 = var_12.primarycamo;

            if ( var_3 != "current" )
            {
                if ( var_10 == 1 )
                    var_14 = var_3;
                else if ( var_10 == 2 )
                    var_15 = var_3;
                else if ( var_10 == 3 )
                    var_16 = var_3;
            }

            level.cac_weapon = maps\mp\gametypes\_class::buildweaponname( var_13, var_14, var_15, var_16, var_17, undefined );
        }
    }
}

getfocusfromcontroller( var_0 )
{
    foreach ( var_3, var_2 in level.vlavatars )
    {
        if ( isdefined( var_2.loadout ) && isdefined( var_2.loadout.player_controller ) && var_2.loadout.player_controller == var_0 )
            return var_3;
    }

    maps\mp\_vl_base::vlprintln( "unable to find avatar for controller " + var_0 );
    return -1;
}

virtual_lobby_set_class( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( self.pers["class"] ) && self.pers["class"] == var_1 && ( !isdefined( var_3 ) || !var_3 ) )
        return;

    self.pers["class"] = var_1;
    self.class = var_1;
    maps\mp\gametypes\_class::setclass( self.pers["class"] );
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    maps\mp\gametypes\_class::giveandapplyloadout( self.pers["team"], self.pers["class"] );

    if ( var_2 )
    {
        vl_avatar_loadout( self, var_0, self.primaryweapon, self.secondaryweapon, self.pers["primaryWeapon"], self.loadoutequipment, self.loadoutoffhand, self.perks, self.costume );

        if ( isdefined( self.cao_agent ) )
            vl_avatar_loadout( self, var_0, undefined, self.secondaryweapon, self.pers["primaryWeapon"], self.loadoutequipment, self.loadoutoffhand, self.perks, self.costume, self.cao_agent );
    }
}

grab_players_classes()
{
    var_0 = [ "privateMatchCustomClasses", "customClasses" ];
    var_1 = [ 60, 60 ];
    var_2 = 0;
    self.loadouts = [];
    self.currentselectedclass = 0;

    foreach ( var_4 in var_0 )
    {
        level.forcecustomclassloc = var_4;
        self.loadouts[var_4] = [];
        var_5 = var_1[var_2];
        var_2++;

        for ( var_6 = 0; var_6 < var_5; var_6++ )
        {
            var_7 = [];
            var_7["primary"] = maps\mp\gametypes\_class::cac_getweapon( var_6, 0 );
            var_7["primaryAttachment1"] = maps\mp\gametypes\_class::cac_getweaponattachment( var_6, 0 );
            var_7["primaryAttachment2"] = maps\mp\gametypes\_class::cac_getweaponattachmenttwo( var_6, 0 );
            var_7["primaryAttachment3"] = maps\mp\gametypes\_class::cac_getweaponattachmentthree( var_6, 0 );
            var_7["primaryCamo"] = maps\mp\gametypes\_class::cac_getweaponcamo( var_6, 0 );
            var_7["primaryReticle"] = maps\mp\gametypes\_class::cac_getweaponreticle( var_6, 0 );

            for ( var_8 = 0; var_8 < 6; var_8++ )
                var_7["perk" + var_8] = maps\mp\gametypes\_class::cac_getperk( var_6, var_8 );

            for ( var_8 = 0; var_8 < 3; var_8++ )
                var_7["wildcard" + var_8] = maps\mp\gametypes\_class::cac_getwildcard( var_6, var_8 );

            var_7["secondary"] = maps\mp\gametypes\_class::cac_getweapon( var_6, 1 );
            var_7["secondaryAttachment1"] = maps\mp\gametypes\_class::cac_getweaponattachment( var_6, 1 );
            var_7["secondaryAttachment2"] = maps\mp\gametypes\_class::cac_getweaponattachmenttwo( var_6, 1 );
            var_7["secondaryAttachment3"] = maps\mp\gametypes\_class::cac_getweaponattachmentthree( var_6, 1 );
            var_7["secondaryCamo"] = maps\mp\gametypes\_class::cac_getweaponcamo( var_6, 1 );
            var_7["secondaryReticle"] = maps\mp\gametypes\_class::cac_getweaponreticle( var_6, 1 );
            var_7["equipment"] = maps\mp\gametypes\_class::cac_getequipment( var_6, 0 );
            var_7["offhand"] = maps\mp\gametypes\_class::cac_getequipment( var_6, 1 );
            self.loadouts[var_4][var_6] = var_7;
        }
    }

    level.forcecustomclassloc = undefined;
}

update_local_class( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21 )
{
    var_22 = int( self.currentselectedclass );
    var_23 = maps\mp\_utility::cac_getcustomclassloc();
    self.loadouts[var_23][var_22]["primary"] = var_0;
    self.loadouts[var_23][var_22]["primaryAttachment1"] = var_1;
    self.loadouts[var_23][var_22]["primaryAttachment2"] = var_2;
    self.loadouts[var_23][var_22]["primaryAttachment3"] = var_3;
    self.loadouts[var_23][var_22]["primaryCamo"] = var_4;
    self.loadouts[var_23][var_22]["primaryReticle"] = var_5;
    self.loadouts[var_23][var_22]["secondary"] = var_6;
    self.loadouts[var_23][var_22]["secondaryAttachment1"] = var_7;
    self.loadouts[var_23][var_22]["secondaryAttachment2"] = var_8;
    self.loadouts[var_23][var_22]["secondaryCamo"] = var_9;
    self.loadouts[var_23][var_22]["secondaryReticle"] = var_10;
    self.loadouts[var_23][var_22]["equipment"] = var_11;
    self.loadouts[var_23][var_22]["lethal"] = var_11;
    self.loadouts[var_23][var_22]["offhand"] = var_12;
    self.loadouts[var_23][var_22]["tactical"] = var_12;
    self.loadouts[var_23][var_22]["wildcard0"] = var_13;
    self.loadouts[var_23][var_22]["wildcard1"] = var_14;
    self.loadouts[var_23][var_22]["wildcard2"] = var_15;
    self.loadouts[var_23][var_22]["perk0"] = var_16;
    self.loadouts[var_23][var_22]["perk1"] = var_17;
    self.loadouts[var_23][var_22]["perk2"] = var_18;
    self.loadouts[var_23][var_22]["perk3"] = var_19;
    self.loadouts[var_23][var_22]["perk4"] = var_20;
    self.loadouts[var_23][var_22]["perk5"] = var_21;
}

loadout_changed( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( var_0.primary != var_1.primary )
        return 1;

    if ( var_0.primaryattachment1 != var_1.primaryattachment1 )
        return 1;

    if ( var_0.primaryattachment2 != var_1.primaryattachment2 )
        return 1;

    if ( var_0.primaryattachment3 != var_1.primaryattachment3 )
        return 1;

    if ( var_0.primarycamo != var_1.primarycamo )
        return 1;

    if ( var_0.secondary != var_1.secondary )
        return 1;

    if ( var_0.secondaryattachment1 != var_1.secondaryattachment1 )
        return 1;

    if ( var_0.secondaryattachment2 != var_1.secondaryattachment2 )
        return 1;

    if ( var_0.secondarycamo != var_1.secondarycamo )
        return 1;

    if ( var_0.tactical != var_1.tactical )
        return 1;

    if ( var_0.lethal != var_1.lethal )
        return 1;

    return 0;
}

costume_changed( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        if ( !isdefined( var_1 ) )
            return 0;

        return 1;
    }

    if ( var_0.size != var_1.size )
        return 1;

    if ( !maps\mp\gametypes\_teams::validcostume( var_1 ) )
        return 0;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2] < 0 )
            return 0;

        if ( var_0[var_2] != var_1[var_2] )
            return 1;
    }

    return 0;
}

setdefaultcostumeifneeded( var_0 )
{
    if ( var_0[level.costumecat2idx["head"]] == 0 )
        var_0[level.costumecat2idx["head"]] = 1;

    if ( !var_0[level.costumecat2idx["shirt"]] )
        var_0[level.costumecat2idx["shirt"]] = 1;

    if ( !var_0[level.costumecat2idx["pants"]] )
        var_0[level.costumecat2idx["pants"]] = 1;

    if ( !var_0[level.costumecat2idx["gloves"]] )
        var_0[level.costumecat2idx["gloves"]] = 1;

    if ( !var_0[level.costumecat2idx["shoes"]] )
        var_0[level.costumecat2idx["shoes"]] = 1;

    if ( !var_0[level.costumecat2idx["gear"]] )
        var_0[level.costumecat2idx["gear"]] = 1;

    if ( !var_0[level.costumecat2idx["exo"]] )
        var_0[level.costumecat2idx["exo"]] = 1;

    return var_0;
}

monitor_member_class_changes()
{
    level.mccqueue = [];

    for (;;)
    {
        while ( !isdefined( level.players ) || level.players.size == 0 || !isdefined( level.camparams ) )
            wait 0.05;

        while ( isdefined( level.players ) && level.players.size > 0 )
        {
            foreach ( var_1 in level.mccqueue )
            {
                var_2 = tablelookup( "mp/statstable.csv", 0, var_1.primary, 4 );
                var_3 = tablelookup( "mp/attachmenttable.csv", 0, var_1.primaryattachment1, 3 );
                var_4 = tablelookup( "mp/attachmenttable.csv", 0, var_1.primaryattachment2, 3 );
                var_5 = tablelookup( "mp/attachmenttable.csv", 0, var_1.primaryattachment3, 3 );
                var_6 = var_1.primarycamo;
                var_7 = tablelookup( "mp/camoTable.csv", 0, var_1.primarycamo, 1 );
                var_8 = var_1.primaryreticle;
                var_9 = tablelookup( "mp/reticleTable.csv", 0, var_1.primaryreticle, 1 );
                var_10 = tablelookup( "mp/statstable.csv", 0, var_1.secondary, 4 );
                var_11 = tablelookup( "mp/attachmenttable.csv", 0, var_1.secondaryattachment1, 3 );
                var_12 = tablelookup( "mp/attachmenttable.csv", 0, var_1.secondaryattachment2, 3 );
                var_13 = "none";
                var_14 = var_1.secondarycamo;
                var_15 = tablelookup( "mp/camoTable.csv", 0, var_1.secondarycamo, 1 );
                var_16 = var_1.secondaryreticle;
                var_17 = tablelookup( "mp/reticleTable.csv", 0, var_1.secondaryreticle, 1 );
                var_18 = tablelookup( "mp/perktable.csv", 0, var_1.lethal, 1 );
                var_19 = tablelookup( "mp/perktable.csv", 0, var_1.tactical, 1 );
                var_20 = tablelookup( "mp/perktable.csv", 0, var_1.wildcard1, 1 );
                var_21 = tablelookup( "mp/perktable.csv", 0, var_1.wildcard2, 1 );
                var_22 = tablelookup( "mp/perktable.csv", 0, var_1.wildcard3, 1 );
                var_23 = tablelookup( "mp/perktable.csv", 0, var_1.perk1, 1 );
                var_24 = tablelookup( "mp/perktable.csv", 0, var_1.perk2, 1 );
                var_25 = tablelookup( "mp/perktable.csv", 0, var_1.perk3, 1 );
                var_26 = tablelookup( "mp/perktable.csv", 0, var_1.perk4, 1 );
                var_27 = tablelookup( "mp/perktable.csv", 0, var_1.perk5, 1 );
                var_28 = tablelookup( "mp/perktable.csv", 0, var_1.perk6, 1 );
                var_29 = maps\mp\gametypes\_class::buildweaponname( var_2, var_3, var_4, var_5, var_6, var_8 );
                var_30 = maps\mp\gametypes\_class::buildweaponname( var_10, var_11, var_12, var_13, var_14, var_16 );
                var_31 = maps\mp\_utility::getbaseweaponname( var_29 );
                var_32 = [];
                var_32[level.costumecat2idx["gender"]] = var_1.gender;
                var_32[level.costumecat2idx["shirt"]] = var_1.shirt;
                var_32[level.costumecat2idx["head"]] = var_1.head;
                var_32[level.costumecat2idx["pants"]] = var_1.pants;
                var_32[level.costumecat2idx["eyewear"]] = var_1.eyewear;
                var_32[level.costumecat2idx["hat"]] = var_1.hat;
                var_32[level.costumecat2idx["kneepads"]] = var_1.kneepads;
                var_32[level.costumecat2idx["gloves"]] = var_1.gloves;
                var_32[level.costumecat2idx["shoes"]] = var_1.shoes;
                var_32[level.costumecat2idx["gear"]] = var_1.gear;
                var_32[level.costumecat2idx["exo"]] = var_1.exclusive;
                var_33 = [];

                if ( isdefined( var_20 ) )
                    var_33[var_20] = 1;

                if ( isdefined( var_21 ) )
                    var_33[var_21] = 1;

                if ( isdefined( var_22 ) )
                    var_33[var_22] = 1;

                if ( !isdefined( level.xuid2ownerid[var_1.xuid] ) && maps\mp\_vl_base::all_avatars_scheduled_for_delete() )
                    maps\mp\_vl_base::reuse_avatar( var_1.xuid );

                if ( !isdefined( level.xuid2ownerid[var_1.xuid] ) )
                {
                    var_34 = maps\mp\_vl_base::add_avatar( var_1.xuid );
                    maps\mp\_vl_base::vlprint( "PartyMemberClassChange " + var_1.xuid + " : " + var_29 + "," + var_30 + "," + var_18 + "," + var_19 + "\\n" );
                    setdvar( "virtuallobbymembers", level.xuid2ownerid.size );
                    var_35 = maps\mp\gametypes\vlobby::getspawnpoint( var_34 );
                    spawn_an_avatar( var_35, var_29, var_30, var_31, var_18, var_19, var_33, var_32, var_1.name, var_34, 0 );
                    maps\mp\_vl_base::avatar_after_spawn( var_34 );
                    _func_2D4( level.vlavatars[var_34], var_1.xuid );
                    level.vlavatars[var_34].loadout = var_1;
                    level.vlavatars[var_34].membertimeout = gettime() + 4000;

                    if ( level.vlavatars.size == 1 )
                    {
                        var_36 = level.players[0].cao_agent;
                        vl_avatar_costume( var_36, level.vlavatars[var_34].costume );
                        var_37 = var_36 maps\mp\gametypes\_teams::playercostume();
                    }

                    if ( isdefined( level.vl_clanprofile_focus ) )
                        hide_avatar( level.vlavatars[var_34] );

                    continue;
                }

                var_34 = level.xuid2ownerid[var_1.xuid];
                var_38 = level.vlavatars[var_34];

                if ( var_1.player_controller >= 0 )
                {
                    if ( level.vl_local_focus == var_34 )
                        level.players[0] update_local_class( var_2, var_3, var_4, var_5, var_7, var_9, var_10, var_11, var_12, var_15, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28 );

                    if ( isdefined( var_38.previewcostume ) )
                    {
                        if ( isdefined( var_38.costumes ) && isdefined( var_38.costumes[var_38.previewcostume] ) )
                            var_32 = var_38.costumes[var_38.previewcostume];
                        else
                            var_32 = level.players[0] maps\mp\gametypes\_class::cao_getcostumebyindex( var_38.previewcostume );

                        var_32 = setdefaultcostumeifneeded( var_32 );

                        if ( !isdefined( var_38.costumes ) )
                            var_38.costumes = [];

                        var_38.costumes[var_38.previewcostume] = var_32;

                        if ( var_38.previewgearcategory != "none" )
                        {
                            var_39 = level.costumecat2idx[var_38.previewgearcategory];
                            var_32[var_39] = var_38.previewgearid;
                        }
                    }
                }

                if ( loadout_changed( var_38.loadout, var_1 ) || costume_changed( var_38.costume, var_32 ) || isdefined( level.forceavatarrefresh ) && level.forceavatarrefresh )
                {
                    maps\mp\_vl_base::vlprint( "Updating xuid " + var_1.xuid + " with ownerId=" + var_34 + "\\n" );
                    maps\mp\_vl_base::vlprint( "PartyMemberClassChange " + var_1.xuid + " : " + var_29 + "," + var_30 + "," + var_18 + "," + var_19 + "\\n" );

                    if ( isdefined( var_38.player ) )
                        var_38.player.costume = var_32;

                    vl_avatar_loadout( var_38.player, var_34, var_29, var_30, var_31, var_18, var_19, var_33, var_32 );

                    if ( var_1.player_controller >= 0 )
                        vl_avatar_loadout( var_38.player, var_34, undefined, var_30, var_31, var_18, var_19, var_33, var_32, level.players[0].cao_agent );

                    var_38.loadout = var_1;
                    level.forceavatarrefresh = 0;
                }
            }

            level.mccqueue = [];
            maps\mp\_vl_base::update_avatars();
            wait 0.05;
        }
    }
}

vl_vfx_for_avatar()
{
    if ( isdefined( self ) && !_func_294( self ) )
    {
        maps\mp\gametypes\_class::checkforcostumeset();

        if ( isdefined( self.costumebonus ) && isdefined( self.costumebonus["xp"] ) )
        {
            self.set_bonus_vfx = 1;

            if ( !isdefined( self.camera_state ) || self.camera_state != "crouch" || self == level.players[0].cao_agent )
            {
                if ( !isdefined( self.spawned_vfx_setbonus_stand ) || _func_294( self.spawned_vfx_setbonus_stand ) )
                {
                    if ( isdefined( self.spawned_vfx_setbonus_crouch ) && !_func_294( self.spawned_vfx_setbonus_crouch ) )
                        self.spawned_vfx_setbonus_crouch delete();

                    self.spawned_vfx_setbonus_stand = spawnfx( level.vfx_setbonus_stand_01, self.origin );
                    setwinningteam( self.spawned_vfx_setbonus_stand, 1 );
                    triggerfx( self.spawned_vfx_setbonus_stand, -6 );
                }
            }
            else if ( !isdefined( self.spawned_vfx_setbonus_crouch ) || _func_294( self.spawned_vfx_setbonus_crouch ) )
            {
                if ( isdefined( self.spawned_vfx_setbonus_stand ) && !_func_294( self.spawned_vfx_setbonus_stand ) )
                    self.spawned_vfx_setbonus_stand delete();

                self.spawned_vfx_setbonus_crouch = spawnfx( level.vfx_setbonus_crouch_01, self.origin );
                setwinningteam( self.spawned_vfx_setbonus_crouch, 1 );
                triggerfx( self.spawned_vfx_setbonus_crouch, -6 );
            }
        }
        else
        {
            self.set_bonus_vfx = 0;

            if ( isdefined( self.spawned_vfx_setbonus_crouch ) && !_func_294( self.spawned_vfx_setbonus_crouch ) )
                self.spawned_vfx_setbonus_crouch delete();

            if ( isdefined( self.spawned_vfx_setbonus_stand ) && !_func_294( self.spawned_vfx_setbonus_stand ) )
                self.spawned_vfx_setbonus_stand delete();
        }
    }
}

override_member_loadout_for_practice_round( var_0 )
{
    if ( !isdefined( level.practice_round_costume ) )
    {
        level.practice_round_max_costumes = _func_296( level.practiceroundcostumetablename ) - 1;
        level.practice_round_costume = randomint( level.practice_round_max_costumes );
    }

    if ( !isdefined( level.practice_round_class ) )
    {
        var_1 = _func_296( level.practiceroundclasstablename ) - 1;
        level.practice_round_class = randomint( var_1 );
    }

    var_4 = var_0;
    var_5 = _func_2CF( level.practiceroundcostumetablename, level.practice_round_costume + 1 );
    var_4.gender = var_5[level.costumecat2idx["gender"]];
    var_4.shirt = var_5[level.costumecat2idx["shirt"]];
    var_4.head = var_5[level.costumecat2idx["head"]];
    var_4.pants = var_5[level.costumecat2idx["pants"]];
    var_4.eyewear = var_5[level.costumecat2idx["eyewear"]];
    var_4.hat = var_5[level.costumecat2idx["hat"]];
    var_4.gear = var_5[level.costumecat2idx["gear"]];
    var_4.kneepads = var_5[level.costumecat2idx["kneepads"]];
    var_4.gloves = var_5[level.costumecat2idx["gloves"]];
    var_4.shoes = var_5[level.costumecat2idx["shoes"]];
    var_4.exclusive = var_5[level.costumecat2idx["exo"]];
    var_6 = level.practice_round_class;
    var_7 = var_6 + 1;
    var_8 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimary", var_7 );
    var_9 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment", var_7 );
    var_10 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment2", var_7 );
    var_11 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment3", var_7 );
    var_12 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryCamo", var_7 );
    var_13 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryReticle", var_7 );
    var_4.primary = int( tablelookup( "mp/statstable.csv", 4, var_8, 0 ) );
    var_4.primaryattachment1 = int( tablelookup( "mp/attachmenttable.csv", 3, var_9, 0 ) );
    var_4.primaryattachment2 = int( tablelookup( "mp/attachmenttable.csv", 3, var_10, 0 ) );
    var_4.primaryattachment3 = int( tablelookup( "mp/attachmenttable.csv", 3, var_11, 0 ) );
    var_4.primarycamo = int( tablelookup( "mp/camoTable.csv", 1, var_12, 0 ) );
    var_4.primaryreticle = int( tablelookup( "mp/reticleTable.csv", 1, var_13, 0 ) );
    var_14 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondary", var_7 );
    var_15 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment", var_7 );
    var_16 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment2", var_7 );
    var_17 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryCamo", var_7 );
    var_18 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryReticle", var_7 );
    var_4.secondary = int( tablelookup( "mp/statstable.csv", 4, var_14, 0 ) );
    var_4.secondaryattachment1 = int( tablelookup( "mp/attachmenttable.csv", 3, var_15, 0 ) );
    var_4.secondaryattachment2 = int( tablelookup( "mp/attachmenttable.csv", 3, var_16, 0 ) );
    var_4.secondarycamo = int( tablelookup( "mp/camoTable.csv", 1, var_17, 0 ) );
    var_4.secondaryreticle = int( tablelookup( "mp/reticleTable.csv", 1, var_18, 0 ) );
    var_19 = tablelookup( level.practiceroundclasstablename, 0, "loadoutWildcard1", var_7 );
    var_20 = tablelookup( level.practiceroundclasstablename, 0, "loadoutWildcard2", var_7 );
    var_21 = tablelookup( level.practiceroundclasstablename, 0, "loadoutWildcard3", var_7 );
    var_4.wildcard1 = int( tablelookup( "mp/perktable.csv", 1, var_19, 0 ) );
    var_4.wildcard2 = int( tablelookup( "mp/perktable.csv", 1, var_20, 0 ) );
    var_4.wildcard3 = int( tablelookup( "mp/perktable.csv", 1, var_21, 0 ) );
    return var_4;
}

add_party_member_class_change( var_0 )
{
    if ( getdvarint( "practiceroundgame" ) )
        var_0 = override_member_loadout_for_practice_round( var_0 );

    for ( var_1 = 0; var_1 < level.mccqueue.size; var_1++ )
    {
        if ( level.mccqueue[var_1].xuid == var_0.xuid )
        {
            level.mccqueue[var_1] = var_0;
            var_0 = undefined;
            break;
        }
    }

    if ( isdefined( var_0 ) )
        level.mccqueue[level.mccqueue.size] = var_0;
}

party_members( var_0 )
{
    if ( !isdefined( level.xuid2ownerid ) )
        return;

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2.xuid;
        var_4 = level.xuid2ownerid[var_3];

        if ( isdefined( var_4 ) )
        {
            var_5 = level.vlavatars[var_4];

            if ( isdefined( var_5 ) )
            {
                var_5.membertimeout = gettime() + 2000;
                var_5.memberhastimedout = undefined;
            }
        }

        if ( var_2.primary >= 0 )
            add_party_member_class_change( var_2 );
    }
}

monitor_member_timeouts()
{
    for (;;)
    {
        var_0 = getdvarint( "splitscreen", 0 );
        var_1 = _func_2BB();
        var_2 = _func_2BC();

        foreach ( var_5, var_4 in level.vlavatars )
        {
            if ( maps\mp\_vl_base::avatar_scheduled_for_removal( var_5 ) )
                continue;

            if ( var_4.membertimeout >= 0 )
            {
                if ( var_4.membertimeout < gettime() )
                {
                    if ( var_5 == 0 && !isdefined( var_4.memberhastimedout ) )
                    {
                        var_4.membertimeout = gettime() + 2000;
                        var_4.memberhastimedout = 1;
                        continue;
                    }

                    maps\mp\_vl_base::vlprint( "Schedule removal of ownerId " + var_5 + " from timeout\\n" );
                    maps\mp\_vl_base::schedule_remove_avatar( var_5 );
                }
            }
        }

        wait 0.05;
    }
}

get_e3_costume( var_0 )
{
    var_1 = "mp/E3CostumeTable.csv";
    var_2 = [];

    for ( var_3 = 0; var_3 < level.costumecat2idx.size; var_3++ )
        var_2[var_3] = int( tablelookupbyrow( var_1, var_3 + 1, var_0 + 1 ) );

    return var_2;
}

monitor_debug_addfakemembers( var_0, var_1 )
{

}

monitor_member_focus_change()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_0, var_1 );

        if ( var_0 == "member_select" )
        {
            level.vl_focus = level.xuid2ownerid[var_1];

            if ( !isdefined( level.vl_focus ) )
            {
                maps\mp\_vl_base::vlprint( "vl_focus undefined, setting to 0\\n" );
                level.vl_focus = 0;
            }

            maps\mp\_vl_base::vlprint( "selected member " + var_1 + " ownerId=" + level.vl_focus + "\\n" );
        }

        if ( var_0 == "vlpresentable" )
        {
            maps\mp\_vl_base::vlprint( "in main menu\\n" );
            thread setvirtuallobbypresentable();
        }

        if ( var_0 == "leave_lobby" )
        {
            maps\mp\_vl_base::vlprint( "leave_lobby xuid=" + var_1 + "\\n" );

            if ( var_1 == "0" )
            {
                foreach ( var_1, var_3 in level.xuid2ownerid )
                {
                    maps\mp\_vl_base::vlprint( "Schedule removal of ownerId " + var_3 + "\\n" );
                    maps\mp\_vl_base::schedule_remove_avatar( var_3, 0.25 );
                }
            }
            else
            {
                var_3 = level.xuid2ownerid[var_1];

                if ( isdefined( var_3 ) )
                {
                    maps\mp\_vl_base::vlprint( "Schedule removal of ownerId " + var_3 + "\\n" );
                    maps\mp\_vl_base::schedule_remove_avatar( var_3, 0.25 );
                }
            }

            thread resetvirtuallobbypresentable();
        }
    }
}

monitor_cao_set_cao_focus( var_0 )
{
    if ( var_0 < 0 )
        level.vl_cao_focus = undefined;
    else
    {
        level.vl_local_focus = getfocusfromcontroller( var_0 );
        level.vl_cao_focus = 1;
        maps\mp\_vl_base::vlprint( "cao ctrl = " + var_0 + " focus = " + level.vl_local_focus + "\\n" );
    }
}

cao_set_costumes_from_lua( var_0 )
{
    maps\mp\_vl_base::vlprintln( "Cao set costumes from lua:" + var_0 );
    var_1 = strtok( var_0, "#" );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "|" );

        if ( var_4.size > 0 )
        {
            var_5 = int( var_4[0] );
            var_6 = getfocusfromcontroller( var_5 );
            var_7 = level.vlavatars[var_6];

            if ( isdefined( var_7 ) )
            {
                var_7.activecostume = int( var_4[1] );

                for ( var_8 = 2; var_8 < var_4.size; var_8++ )
                {
                    var_9 = strtok( var_4[var_8], "," );
                    var_10 = [];

                    for ( var_11 = 1; var_11 < var_9.size; var_11++ )
                        var_10[var_10.size] = int( var_9[var_11] );

                    if ( !isdefined( var_7.costumes ) )
                        var_7.costumes = [];

                    var_7.costumes[int( var_9[0] )] = var_10;
                }
            }
        }
    }
}

monitor_cao_set_costume_preview( var_0 )
{
    var_1 = strtok( var_0, ":" );
    var_2 = int( var_1[0] );
    var_3 = strtok( var_1[1], "," );
    var_4 = getfocusfromcontroller( var_2 );
    level.vl_local_focus = var_4;
    var_5 = level.vlavatars[var_4];

    if ( isdefined( var_5 ) )
    {
        var_5.previewcostume = int( var_3[0] );
        var_5.previewgearcategory = var_3[1];
        var_5.previewgearid = int( var_3[2] );
    }

    return var_5;
}

monitor_create_an_operator( var_0 )
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_1, var_2 );

        if ( var_1 == "cao" )
        {
            monitor_cao_set_cao_focus( var_2 );
            level.caoavatarposoffset = undefined;

            if ( isdefined( level.vl_local_focus ) )
                var_3 = level.vlavatars[level.vl_local_focus];
            else
                var_3 = level.vlavatars[var_0];

            if ( var_2 < 0 && isdefined( var_3 ) )
            {
                var_3.previewgearcategory = undefined;
                var_3.previewgearid = undefined;
                var_3.previewcostume = undefined;

                if ( isdefined( var_3.costumes ) )
                    vl_avatar_costume( var_3, var_3.costumes[var_3.activecostume], 1 );
            }

            continue;
        }

        if ( var_1 == "lootscreen_gear_highlighted" )
        {
            level.cac = undefined;
            monitor_cao_set_cao_focus( var_2 );

            if ( isdefined( level.vl_cao_focus ) )
                level.caoavatarposoffset = ( 56, 0, 5 );
            else
                level.caoavatarposoffset = undefined;

            level.camparams.pushmode = "prelobby_loot";
            continue;
        }

        if ( var_1 == "costumes" )
        {
            cao_set_costumes_from_lua( var_2 );
            continue;
        }

        if ( var_1 == "costume_preview" )
        {
            monitor_cao_set_costume_preview( var_2 );
            continue;
        }

        if ( var_1 == "costume_apply" )
        {
            var_3 = monitor_cao_set_costume_preview( var_2 );

            if ( isdefined( var_3 ) )
            {
                var_4 = level.costumecat2idx[var_3.previewgearcategory];

                if ( isdefined( var_3.costumes ) && isdefined( var_3.costumes[var_3.previewcostume] ) )
                {
                    var_3.costumes[var_3.previewcostume][var_4] = var_3.previewgearid;

                    if ( var_3.previewcostume == var_3.activecostume )
                        var_3 _meth_84BA( var_3.costumes[var_3.previewcostume] );
                }
            }

            continue;
        }

        if ( var_1 == "costume_set_apply" )
        {
            var_5 = strtok( var_2, ":" );
            var_6 = int( var_5[0] );
            var_7 = int( var_5[1] );
            var_0 = getfocusfromcontroller( var_6 );
            var_3 = level.vlavatars[var_0];

            if ( !isdefined( var_3.costumes ) || !isdefined( var_3.costumes[var_7] ) )
            {
                var_8 = level.players[0] maps\mp\gametypes\_class::cao_getcostumebyindex( var_7 );
                var_8 = setdefaultcostumeifneeded( var_8 );

                if ( !isdefined( var_3.costumes ) )
                    var_3.costumes = [];

                var_3.costumes[var_7] = var_8;
            }

            var_9 = strtok( var_5[2], "|" );

            foreach ( var_11 in var_9 )
            {
                var_12 = strtok( var_11, "," );
                var_13 = var_12[0];
                var_14 = int( var_12[1] );
                var_4 = level.costumecat2idx[var_13];
                var_3.costumes[var_7][var_4] = var_14;
            }

            var_3 _meth_84BA( var_3.costumes[var_7] );
        }
    }
}

clans_set_highlight_gear_from_lua( var_0 )
{
    setdvar( "vl_clan_models_loaded", 0 );
    var_1 = strtok( var_0, "#" );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "|" );

        if ( var_4.size > 0 )
        {
            var_5 = int( var_4[0] );
            var_6 = level.players[0].clan_agents[var_5];

            if ( isdefined( var_6 ) )
            {
                var_6.activecostume = 0;
                var_6.isvalidhighlight = int( var_4[1] ) > 0;

                for ( var_7 = 2; var_7 < var_4.size; var_7++ )
                {
                    var_8 = strtok( var_4[var_7], "," );
                    var_9 = [];

                    for ( var_10 = 1; var_10 < var_8.size; var_10++ )
                        var_9[var_9.size] = int( var_8[var_10] );

                    if ( !isdefined( var_6.costumes ) )
                        var_6.costumes = [];

                    var_6.costumes[int( var_8[0] )] = var_9;
                    vl_avatar_costume( var_6, var_9, 1 );

                    if ( var_6.isvalidhighlight )
                    {
                        wait_load_costume( var_6 );
                        continue;
                    }

                    hide_avatar( var_6 );
                }
            }
        }
    }

    setdvar( "vl_clan_models_loaded", 1 );
}

monitor_clans()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_0, var_1 );

        if ( var_0 == "clanprofile" )
        {
            maps\mp\_vl_base::vlprint( "Using clan profile VL settings\\n" );

            if ( var_1 < 0 )
                level.vl_clanprofile_focus = undefined;
            else
                level.vl_clanprofile_focus = var_1;

            continue;
        }

        if ( var_0 == "clan_highlight_data" )
        {
            maps\mp\_vl_base::vlprint( "Handling clan highlight information\\n" );
            clans_set_highlight_gear_from_lua( var_1 );
        }
    }
}

hide_avatar( var_0 )
{
    var_0 hide();
    var_0 _meth_804A();

    if ( isdefined( var_0.spawned_vfx_setbonus_crouch ) && !_func_294( var_0.spawned_vfx_setbonus_crouch ) )
        var_0.spawned_vfx_setbonus_crouch delete();

    if ( isdefined( var_0.spawned_vfx_setbonus_stand ) && !_func_294( var_0.spawned_vfx_setbonus_stand ) )
        var_0.spawned_vfx_setbonus_stand delete();

    hide_avatar_weapons( var_0 );
}

show_avatar( var_0 )
{
    if ( var_0.isfree )
        return;

    addlaunchers( var_0 );
    var_0 show();
    var_0 _meth_804C();

    if ( isdefined( var_0.primaryweaponent ) )
    {
        var_0.primaryweaponent show();
        var_0.primaryweaponent _meth_804C();
    }

    if ( isdefined( var_0.secondaryweaponent ) )
    {
        var_0.secondaryweaponent show();
        var_0.secondaryweaponent _meth_804C();
    }

    if ( isdefined( var_0.akimboweaponent ) && isdefined( var_0.akimboweaponent.primaryweapon ) )
    {
        if ( issubstr( var_0.akimboweaponent.primaryweapon, "akimbo" ) || issubstr( var_0.akimboweaponent.primaryweapon, "akimboxmg" ) )
        {
            var_0.akimboweaponent show();
            var_0.akimboweaponent _meth_804C();
        }
    }

    var_0 thread vl_vfx_for_avatar();
}

hide_avatar_primary_weapon( var_0 )
{
    if ( isdefined( var_0.primaryweaponent ) )
    {
        var_0 notify( "hide_primary_weapon" );
        var_0.primaryweaponent hide();
        var_0.primaryweaponent _meth_804A();
    }
}

hide_avatar_secondary_weapon( var_0 )
{
    if ( isdefined( var_0.secondaryweaponent ) )
    {
        var_0 notify( "hide_secondary_weapon" );
        var_0.secondaryweaponent hide();
        var_0.secondaryweaponent _meth_804A();
    }
}

hide_avatar_akimbo_weapon( var_0 )
{
    if ( isdefined( var_0.akimboweaponent ) )
    {
        var_0 notify( "hide_akimbo_weapon" );
        var_0.akimboweaponent hide();
        var_0.akimboweaponent _meth_804A();
    }
}

hide_avatar_weapons( var_0 )
{
    hide_avatar_primary_weapon( var_0 );
    hide_avatar_secondary_weapon( var_0 );
    hide_avatar_akimbo_weapon( var_0 );
}

hide_avatars()
{
    foreach ( var_1 in level.vlavatars )
        hide_avatar( var_1 );
}

show_avatars()
{
    foreach ( var_1 in level.vlavatars )
        show_avatar( var_1 );
}

get_xuid_for_avatar( var_0 )
{
    foreach ( var_3, var_2 in level.xuid2ownerid )
    {
        if ( isdefined( level.vlavatars[var_2] ) && level.vlavatars[var_2] == var_0 )
            return var_3;
    }

    return "";
}

remove_avatar( var_0 )
{
    var_1 = -1;

    foreach ( var_3, var_1 in level.xuid2ownerid )
    {
        if ( var_1 == var_0 )
            break;
    }

    maps\mp\_vl_base::vlprint( "Removing xuid " + var_3 + " for ownerId " + var_0 + "\\n" );
    _func_2D4( level.vlavatars[var_0], var_3, 1 );
    level.xuid2ownerid[var_3] = undefined;
    level.avatarinfo[var_0].timetodelete = 0;
    level.avatarinfo[var_0].avatar = undefined;
    setdvar( "virtuallobbymembers", level.xuid2ownerid.size );
    var_4 = level.vlavatars[var_0];
    level.vlavatars[var_0] = undefined;

    if ( level.vl_focus == var_0 )
    {
        if ( level.vlavatars.size > 0 )
        {
            foreach ( var_7, var_6 in level.vlavatars )
            {
                level.vl_focus = var_7;
                break;
            }
        }
    }

    hide_avatar( var_4 );
    var_4 _meth_8310();
    var_4 detachall();
    var_4.headmodel = undefined;
    var_4 _meth_804A();

    if ( isdefined( var_4.avatar_spawnpoint.spawned_avatar ) )
        var_4.avatar_spawnpoint.spawned_avatar = undefined;

    if ( isdefined( var_4.primaryweaponent ) )
    {
        _func_2D4( var_4.primaryweaponent, var_3, 1 );
        var_4.primaryweaponent delete();
        var_4.primaryweaponent = undefined;
    }

    if ( isdefined( var_4.secondaryweaponent ) )
    {
        _func_2D4( var_4.secondaryweaponent, var_3, 1 );
        var_4.secondaryweaponent delete();
        var_4.secondaryweaponent = undefined;
    }

    if ( isdefined( var_4.akimboweaponent ) )
    {
        _func_2D4( var_4.akimboweaponent, var_3, 1 );
        var_4.akimboweaponent delete();
        var_4.akimboweaponent = undefined;
    }

    var_4.primaryweapon = undefined;
    var_4.stored_weapon = undefined;
    maps\mp\_vl_base::free_avatar( var_4 );

    if ( level.vl_focus == var_0 )
        level.vl_focus = 0;
}

reset_bot_settings_for_a_few_frames()
{
    level notify( "stop_reset_bot_settings" );
    level endon( "stop_reset_bot_settings" );

    for ( var_0 = 0; var_0 < 2; var_0++ )
    {
        maps\mp\agents\_agent_common::set_agent_health( 100 );
        self _meth_8358();
        self _meth_8356();
        bot_disable_tactical_goals();
        self _meth_8351( "disable_movement", 1 );
        self _meth_8351( "disable_rotation", 1 );
        wait 0.05;
    }
}

hackagentangles( var_0 )
{
    self setangles( var_0 );
}

use_animstate( var_0, var_1, var_2 )
{
    var_3 = randomfloatrange( 0.85, 1.15 );
    var_4 = 0;

    if ( !isdefined( self.animalias ) )
    {
        self _meth_83D0( "vlobby_animclass" );
        var_4 = 1;
        level notify( "stop_reset_bot_settings" );
        hackagentangles( self.spawn_angles );
    }

    if ( !isdefined( var_2 ) )
    {
        var_2 = "lobby_idle";
        var_0 = "assault_pose_06";
    }

    self.animalias = var_0;
    self.animstate = var_2;
    self _meth_83D2( var_2, var_0, var_3 );

    if ( !isdefined( var_1 ) || !var_1 )
    {
        self.animalias = var_0;

        if ( var_4 )
            vl_give_weapons( self );
    }
}

start_anim()
{
    if ( isdefined( level.camparams ) && isdefined( level.camparams.mode ) )
    {
        switch ( level.camparams.mode )
        {
            case "prelobby_loot":
            case "prelobby":
                var_0 = 0;

                if ( isdefined( level.vlavatars ) )
                {
                    foreach ( var_2 in level.vlavatars )
                    {
                        if ( !isdefined( var_2.animalias ) )
                        {
                            var_3 = var_2.avatar_spawnpoint findpositionnum();

                            if ( isdefined( self.ownerid ) && self.ownerid == 0 )
                                var_0 = 8;
                            else if ( var_3 < level.num_lobby_idles )
                                var_0 = var_3;
                            else
                            {
                                var_0++;

                                if ( var_0 >= level.num_lobby_idles )
                                    var_0 = 0;
                            }

                            var_4 = "lobby_idle";
                            use_animstate( var_0, undefined, var_4 );
                        }
                    }
                }

                break;
            case "cac":
            case "transition":
            case "game_lobby":
                var_0 = 0;

                if ( isdefined( level.vlavatars ) )
                {
                    foreach ( var_2 in level.vlavatars )
                    {
                        if ( !isdefined( var_2.animalias ) )
                        {
                            var_3 = var_2.avatar_spawnpoint findpositionnum();

                            if ( isdefined( self.ownerid ) && self.ownerid == 0 )
                                var_0 = 8;
                            else if ( var_3 < level.num_lobby_idles )
                                var_0 = var_3;
                            else
                            {
                                var_0++;

                                if ( var_0 >= level.num_lobby_idles )
                                    var_0 = 0;
                            }

                            var_4 = "lobby_idle";
                            use_animstate( var_0, undefined, var_4 );
                        }
                    }
                }

                break;
            case "clanprofile":
            case "cao":
                if ( !isdefined( self.animalias ) )
                {
                    if ( isdefined( self.ownerid ) && self.ownerid == 0 )
                        var_0 = 8;
                    else
                        var_0 = randomintrange( 0, level.num_lobby_idles - 1 );

                    var_4 = "lobby_idle";
                    use_animstate( var_0, undefined, var_4 );
                }

                break;
            default:
                if ( !isdefined( self.animalias ) )
                {
                    if ( isdefined( self.ownerid ) && self.ownerid == 0 )
                        var_0 = 8;
                    else
                        var_0 = randomintrange( 0, level.num_lobby_idles - 1 );

                    var_4 = "lobby_idle";
                    use_animstate( var_0, undefined, var_4 );
                }

                break;
        }
    }
}

start_prelobby_anims()
{
    if ( !isdefined( level.vlavatars ) )
        return;

    foreach ( var_1 in level.vlavatars )
    {
        if ( !isdefined( var_1.animalias ) || !isdefined( var_1.animstate ) )
        {
            var_2 = var_1 getanimdata( var_1.primaryweapon );
            var_1 use_animstate( var_2.alias, undefined, var_2.animstate );
        }
    }
}

start_lobby_anims()
{
    if ( !isdefined( level.vlavatars ) )
        return;

    foreach ( var_1 in level.vlavatars )
    {
        if ( !isdefined( var_1.animalias ) || !isdefined( var_1.animstate ) )
        {
            var_2 = var_1 getanimdata( var_1.primaryweapon );
            var_1 use_animstate( var_2.alias, undefined, var_2.animstate );
        }
    }
}

start_cao_anims()
{
    if ( !isdefined( level.vlavatars ) )
        return;

    foreach ( var_1 in level.vlavatars )
    {
        if ( !isdefined( var_1.animalias ) || !isdefined( var_1.animstate ) )
        {
            var_2 = var_1 getanimdata( var_1.primaryweapon );
            var_1 use_animstate( var_2.alias, undefined, var_2.animstate );
        }
    }
}

find_best_cam_path( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    var_3[1] = var_1;
    var_4 = 20;

    for ( var_5 = 1; var_5 && var_4 > 0; var_3 = var_6 )
    {
        var_4--;
        var_5 = 0;
        var_6 = [];
        var_6[var_6.size] = var_3[0];
        var_7 = 0;
        var_8 = 0;

        for ( var_9 = 0; var_9 < var_3.size - 1 && !var_7; var_9++ )
        {
            var_10 = 1;
            var_11 = var_3[var_9];
            var_12 = var_3[var_9 + 1];

            while ( var_10 )
            {
                var_10 = 0;
                var_13 = undefined;
                var_14 = undefined;

                foreach ( var_16 in var_2 )
                {
                    var_17 = trace2d( var_11, var_12, var_16 );

                    if ( var_17["intersect"] )
                    {
                        if ( distance2d( var_6[var_6.size - 1], var_17["closestpoint"] ) > 0.1 && distance2d( var_12, var_17["closestpoint"] ) > 0.1 )
                        {
                            var_10 = 1;

                            if ( !isdefined( var_14 ) || var_14["radratio"] > var_17["radratio"] )
                            {
                                var_13 = var_16;
                                var_14 = var_17;
                            }
                        }
                    }
                }

                if ( var_10 )
                {
                    var_5 = 1;

                    if ( length2d( var_11, var_13["center"] ) < var_13["radius"] )
                    {
                        var_11 = move_outside_circle( var_11, var_13 );
                        var_6[var_6.size - 1] = var_11;
                        var_10 = 0;
                        var_7 = 1;
                        var_8 = var_9 + 1;
                    }
                    else if ( length2d( var_12, var_13["center"] ) < var_13["radius"] )
                    {
                        var_12 = move_outside_circle( var_12, var_13 );
                        var_6[var_6.size] = var_12;
                        var_10 = 0;
                        var_7 = 1;
                        var_8 = var_9 + 2;
                    }
                    else
                    {
                        var_6[var_6.size] = var_14["closestpoint"];
                        var_6[var_6.size] = var_12;
                        var_10 = 0;
                    }

                    continue;
                }

                var_6[var_6.size] = var_12;
            }
        }

        if ( var_7 )
        {
            for ( var_9 = var_8; var_9 < var_3.size; var_9++ )
                var_6[var_6.size] = var_3[var_9];
        }
    }

    return var_3;
}

move_outside_circle( var_0, var_1 )
{
    var_2 = var_1["center"];
    var_3 = var_1["radius"];
    var_4 = vectornormalize( ( var_0[0] - var_2[0], var_0[1] - var_2[1], 0 ) );
    var_0 = ( var_2[0] + var_3 * var_4[0], var_2[1] + var_3 * var_4[1], var_0[2] );
    return var_0;
}

trace2d( var_0, var_1, var_2 )
{
    var_3 = 5;
    var_4 = var_2["center"];
    var_5 = var_2["radius"];
    var_6 = var_5 + var_3;
    var_7 = ( var_1[0] - var_0[0], var_1[1] - var_0[1], 0 );
    var_8 = vectornormalize( var_7 );
    var_9 = length2d( var_7 );
    var_10 = ( var_4[0] - var_0[0], var_4[1] - var_0[1], 0 );
    var_11 = vectordot( var_8, var_10 );

    if ( var_11 < 0 )
        var_11 = 0.0;
    else if ( var_11 > var_9 )
        var_11 = var_9;

    var_12 = ( var_0[0] + var_11 * var_8[0], var_0[1] + var_11 * var_8[1], 0 );
    var_13 = var_11 / var_9;
    var_14 = ( var_12[0] - var_4[0], var_12[1] - var_4[1], 0 );
    var_9 = length2d( var_14 );
    var_15 = 0;
    var_16 = 1.0;

    if ( var_9 < var_5 )
    {
        var_15 = 1;
        var_14 = vectornormalize( var_14 );
        var_12 = ( var_4[0] + var_6 * var_14[0], var_4[1] + var_6 * var_14[1], var_0[2] + var_13 * ( var_1[2] - var_0[2] ) );
        var_16 = var_9 / var_5;
    }

    var_17 = [];
    var_17["intersect"] = var_15;
    var_17["fraction"] = var_13;
    var_17["closestpoint"] = var_12;
    var_17["radratio"] = var_16;
    return var_17;
}

calc_new_pos( var_0, var_1, var_2 )
{
    var_3 = distance( var_0, var_2 );

    if ( var_3 > var_1 )
    {
        var_4 = vectornormalize( var_2 - var_0 );
        var_2 = var_0 + var_1 * var_4;
    }

    return var_2;
}

lookahead_path( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_4[var_0];

    if ( var_0 + 1 >= var_4.size )
        return [ var_0, calc_new_pos( var_1, var_2, var_4[var_0] ) ];

    var_6 = var_4[var_0 + 1];
    var_7 = distance( var_5, var_6 );
    var_8 = vectornormalize( var_6 - var_5 );
    var_9 = vectordot( var_8, var_1 - var_5 );

    if ( var_9 < 0 )
        var_9 = 0;

    if ( var_9 > var_7 )
        var_9 = var_7;

    var_10 = var_5 + var_9 * var_8;
    var_11 = var_3;
    var_12 = var_7 - var_9;
    var_13 = var_4[var_4.size - 1];

    while ( var_11 > 0 )
    {
        if ( var_12 > var_11 )
        {
            var_13 = var_10 + var_11 * var_8;
            var_11 = 0;
            continue;
        }

        if ( var_0 + 1 >= var_4.size )
        {
            var_13 = var_4[var_0];
            var_11 = 0;
        }

        var_11 -= var_12;
        var_0++;
        var_10 = var_4[var_0];
    }

    return [ var_0, calc_new_pos( var_1, var_2, var_13 ) ];
}

init_path_traversal( var_0 )
{
    var_0.distanceonpath = 0;
    var_0.pathidx = 0;
    var_0.distonpathsegment = 0;
    var_0.pathspeed = 0;
    var_1 = var_0.pathinfo_len / var_0.path_idealtime;

    if ( var_1 < var_0.path_minspeed )
        var_1 = var_0.path_minspeed;

    if ( var_1 > var_0.path_maxspeed )
        var_1 = var_0.path_maxspeed;

    var_0.pathaccel = 0.05 * var_1 / var_0.path_accel_time;
    var_0.pathdeccel = 0.05 * var_1 / var_0.path_deccel_time;
    var_0.pathtgtspeed = var_1;
    var_0.pathaccelmode = 1;
    var_0.pathinfo_t = 0;
    var_0.pathinfo_totalt = var_0.path_idealtime;
    var_2 = var_0.path_deccel_time / 0.05;
    var_3 = 0;
    var_4 = var_1;

    for ( var_5 = 0; var_5 < var_2; var_5++ )
    {
        var_4 -= var_0.pathdeccel;

        if ( var_4 < var_0.path_mindeccelspeed )
            var_4 = var_0.path_mindeccelspeed;

        var_3 += var_4;
    }

    var_0.pathstartdecceldist = var_0.pathinfo_len - var_3;
    var_0.pitch = var_0.pathinfo_startpitch;
}

update_path_speed( var_0 )
{
    if ( var_0.distanceonpath < var_0.pathstartdecceldist )
    {
        var_0.pathspeed += var_0.pathaccel;

        if ( var_0.pathspeed > var_0.pathtgtspeed )
            var_0.pathspeed = var_0.pathtgtspeed;
    }
    else
    {
        var_0.pathspeed -= var_0.pathdeccel;

        if ( var_0.pathspeed < var_0.path_mindeccelspeed )
            var_0.pathspeed = var_0.path_mindeccelspeed;
    }
}

init_path_constants( var_0 )
{
    var_0.path_maxspeed = 15.0;
    var_0.path_minspeed = 1.8;
    var_0.path_mindeccelspeed = 0.3;
    var_0.path_idealtime = 0.5;
    var_0.path_accel_time = 0.15 * var_0.path_idealtime;
    var_0.path_deccel_time = 0.15 * var_0.path_idealtime;
    var_0.pathmaxrotz = 4.5;
    var_0.pathmaxrotx = 4.5;
}

build_path_info( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = find_best_cam_path( var_0.origin, var_3, var_0.obstacles );
    var_0.path = var_5;
    var_6 = 0;

    foreach ( var_9, var_8 in var_0.path )
    {
        if ( var_9 > 0 )
            var_6 += distance( var_0.path[var_9], var_0.path[var_9 - 1] );
    }

    var_0.pathinfo_t = 0;
    var_0.pathinfo_totalt = var_0.path_idealtime;
    var_0.pathinfo_len = var_6;
    var_0.pathinfo_startaim = anglestoforward( var_0.angles );
    var_0.pathinfo_endaim = anglestoforward( var_4 );
    var_0.pathinfo_startpitch = angleclamp180( var_0.angles[0] );
    var_0.pathinfo_curstartpitch = var_0.pathinfo_startpitch;
    var_0.pathinfo_endpitch = angleclamp180( var_4[0] );
    var_0.pathinfo_startyaw = angleclamp180( var_0.angles[1] );
    var_0.pathinfo_endyaw = angleclamp180( var_4[1] );
    var_0.pathinfo_start_loc = var_2;
    var_0.pathinfo_end_loc = var_3;
    var_0.pathinfo_velocity = ( 0, 0, 0 );
    var_10 = vectornormalize( var_0.pathinfo_end_loc - var_0.pathinfo_start_loc );
    var_11 = vectordot( var_10, var_0.pathinfo_startaim );
    var_12 = vectordot( var_10, var_0.pathinfo_endaim );
    var_13 = 0;

    if ( var_12 < -0.707 && var_11 < -0.707 )
        var_13 = 1;

    var_0.pathinfo_mode = var_13;
    init_path_traversal( var_0 );
}

findnewtargetpos( var_0, var_1, var_2 )
{
    var_3 = anglestoforward( var_0 );
    var_4 = var_2 - var_1;
    var_5 = vectordot( var_4, var_3 );
    var_6 = var_1 + var_3 * var_5;
    return var_6;
}

sigmoid( var_0, var_1 )
{
    var_2 = -0.5;
    var_0 += var_2;
    var_0 *= ( 2 * var_1 );
    var_3 = sqrt( 1 + var_1 * var_1 ) / 2 * var_1;
    var_4 = 0.5;
    var_5 = var_3 * var_0 / sqrt( 1 + var_0 * var_0 ) + var_4;
    return var_5;
}

lerp_towards_desiredangle( var_0, var_1 )
{
    var_2 = angleclamp180( var_1[0] );
    var_3 = angleclamp180( var_0.angles[0] );
    var_4 = angleclamp180( var_1[1] - var_0.angles[1] );
    var_5 = angleclamp180( var_2 - var_3 );

    if ( var_4 < -1 * var_0.pathmaxrotz )
        var_4 = -1 * var_0.pathmaxrotz;

    if ( var_4 > var_0.pathmaxrotz )
        var_4 = var_0.pathmaxrotz;

    if ( var_5 < -1 * var_0.pathmaxrotx )
        var_5 = -1 * var_0.pathmaxrotx;

    if ( var_5 > var_0.pathmaxrotx )
        var_5 = var_0.pathmaxrotx;

    var_6 = ( var_5, var_4, 0 );
    var_0.angles += var_6;

    if ( abs( var_5 ) < 0.1 && abs( var_4 ) < 0.1 )
        return 1;
    else
        return 0;
}

update_camera_angles_on_path( var_0, var_1 )
{
    var_2 = var_0.pathinfo_t / var_0.pathinfo_totalt;
    var_2 = sigmoid( var_2, 2 );
    var_3 = var_0.angles;
    var_4 = var_2 * ( var_0.pathinfo_endpitch - var_0.pathinfo_startpitch ) + var_0.pathinfo_startpitch;
    var_5 = var_0.pathinfo_startyaw + var_2 * ( var_0.pathinfo_endyaw - var_0.pathinfo_startyaw );
    var_6 = var_0.angles[1] + angleclamp180( var_5 - var_0.angles[1] );
    var_3 = ( var_4, var_6, var_3[2] );
    return lerp_towards_desiredangle( var_0, var_3 );
}

update_camera_position_on_path( var_0 )
{
    var_1 = var_0.pathinfo_t / var_0.pathinfo_totalt;
    var_1 = sigmoid( var_1, 2 );
    var_2 = var_1 * var_0.pathinfo_len;
    var_0.pathidx = 0;
    var_0.distonpathsegment = 0;
    var_0.distanceonpath = 0;

    while ( var_2 > 0 )
    {
        var_3 = distance( var_0.path[var_0.pathidx], var_0.path[var_0.pathidx + 1] );
        var_4 = var_3 - var_0.distonpathsegment;

        if ( var_4 > var_2 )
        {
            var_0.distonpathsegment += var_2;
            var_5 = var_0.path[var_0.pathidx] + var_0.distonpathsegment * vectornormalize( var_0.path[var_0.pathidx + 1] - var_0.path[var_0.pathidx] );
            var_0.pathinfo_velocity = var_5 - var_0.origin;
            var_0.origin = var_5;
            var_0.distanceonpath += var_2;
            var_2 = 0;
            continue;
        }

        var_2 -= var_4;
        var_0.pathidx++;

        if ( var_0.pathidx >= var_0.path.size - 1 )
        {
            if ( var_0.pathidx < var_0.path.size )
                var_5 = var_0.path[var_0.pathidx];
            else
                var_5 = var_0.path[var_0.path.size - 1];

            var_0.pathinfo_velocity = var_5 - var_0.origin;
            var_0.origin = var_5;
            var_0.distanceonpath = var_0.pathinfo_len;
            var_2 = 0;
            continue;
        }

        var_0.distanceonpath += var_4;
        var_0.distonpathsegment = 0;
    }
}

update_camera_on_path( var_0, var_1 )
{
    var_2 = 0;
    var_0.pathinfo_t += 0.05;

    if ( var_0.pathinfo_t >= var_0.pathinfo_totalt )
    {
        var_0.pathinfo_t = var_0.pathinfo_totalt;
        var_2 = 1;
        var_0.pathinfo_velocity = ( 0, 0, 0 );
    }

    update_camera_position_on_path( var_0 );
    update_camera_angles_on_path( var_0, var_1 );
    return var_2;
}

get_target_from_avatar( var_0 )
{
    var_1 = "j_neck";
    var_2 = var_0 gettagorigin( var_1 );
    return var_2;
}

calc_f_from_avatar( var_0 )
{
    var_1 = rotateavatartagcamera( var_0 );
    var_2 = var_1.camera_tag_origin;
    var_3 = var_1.camera_tag_angles;
    var_4 = get_target_from_avatar( var_0 );
    var_5 = var_2;
    var_6 = var_2 + anglestoforward( var_3 ) * 64;
    return calc_f( var_5, var_6, var_4 );
}

calc_f_from_avatar_spawnpoint( var_0 )
{
    var_1 = var_0.origin;
    var_2 = var_0.camera_helper.origin;
    var_3 = var_0.camera_lookat.origin;
    return calc_f( var_2, var_3, var_1 );
}

calc_f( var_0, var_1, var_2 )
{
    var_3 = var_1;
    var_4 = var_0;
    var_5 = var_2;
    var_6 = [];
    var_7 = vectornormalize( vectorcross( var_3 - var_4, ( 0, 0, 1 ) ) );
    var_8 = vectornormalize( vectorcross( var_7, var_3 - var_4 ) );
    var_9 = var_5 - var_4;
    var_10 = var_5 - vectordot( var_8, var_9 ) * var_8;
    var_11 = var_5 - vectordot( var_7, var_9 ) * var_7;
    var_12 = distance( var_10, var_3 );
    var_13 = distance( var_10, var_4 );
    var_14 = var_12 / var_13;
    var_15 = 1;

    if ( vectordot( var_9, var_7 ) < 0 )
        var_15 = -1;

    var_6["fx"] = var_14;
    var_6["sx"] = var_15;
    var_16 = distance( var_11, var_3 );
    var_17 = distance( var_11, var_4 );
    var_18 = var_16 / var_17;
    var_19 = 1;

    if ( vectordot( var_9, var_8 ) < 0 )
        var_19 = -1;

    var_6["fz"] = var_18;
    var_6["sz"] = var_19;
    return var_6;
}

calc_f_fromscreen( var_0, var_1 )
{
    var_2 = getdvarfloat( "cg_fov", 45 ) * getdvarfloat( "cg_fovScale", 1.0 );
    var_3 = 1.0;
    var_4 = tan( var_2 );
    var_5 = [];
    var_6 = var_4 * abs( var_0 );
    var_7 = 1;

    if ( var_0 < 0 )
        var_7 = -1;

    var_8 = var_6 / sqrt( 1 - var_6 * var_6 );
    var_5["sx"] = var_7;
    var_5["fx"] = var_8;
    var_9 = var_3 * var_4 * abs( var_1 );
    var_10 = 1;

    if ( var_1 < 0 )
        var_10 = -1;

    var_11 = var_9 / sqrt( 1 - var_9 * var_9 );
    var_5["sz"] = var_10;
    var_5["fz"] = var_11;
    return var_5;
}

calc_cam_lookat( var_0, var_1, var_2 )
{
    var_3 = var_1;
    var_4 = var_2;
    var_5 = var_4 - var_3;
    var_6 = vectornormalize( vectorcross( var_5, ( 0, 0, 1 ) ) );
    var_7 = vectornormalize( vectorcross( var_6, var_5 ) );
    var_8 = var_5 - vectordot( var_5, var_7 ) * var_7;
    var_9 = length( var_8 );
    var_10 = var_0["fx"];
    var_11 = var_0["sx"];
    var_12 = var_9 * var_10;
    var_9 = var_9 * var_10 * var_10;
    var_13 = var_9 * var_10 * sqrt( 1 - var_10 * var_10 );
    var_14 = var_9 * var_8 + var_13 * var_6;
    var_15 = var_5 - vectordot( var_5, var_6 ) * var_6;
    var_16 = length( var_15 );
    var_17 = var_0["fz"];
    var_18 = var_0["sz"];
    var_19 = var_16 * var_17;
    var_16 = var_16 * var_17 * var_17;
    var_20 = var_16 * var_17 * sqrt( 1 - var_17 * var_17 );
    var_21 = var_16 * var_15 + var_20 * var_7;
    var_22 = var_4 + var_11 * var_14 + var_18 * var_21;
    return var_22;
}

debug_draw_path( var_0 )
{
    var_1 = ( 1, 1, 1 );
    var_2 = var_0[0];
    var_3 = var_2;
    var_4 = 0;
    var_5 = 10;
    var_6 = 30;

    if ( level.use_lookahead )
    {
        for (;;)
        {
            var_7 = lookahead_path( var_4, var_2, var_5, var_6, var_0 );
            var_4 = var_7[0];
            var_3 = var_7[1];

            if ( distance( var_2, var_3 ) < 0.1 )
                break;

            var_2 = var_3;

            if ( var_4 >= var_0.size )
                break;
        }
    }
    else
    {
        for ( var_8 = 0; var_8 < var_0.size - 1; var_8++ )
        {

        }
    }
}

debug_draw_obstacles( var_0 )
{
    var_1 = ( 1, 0.5, 0 );

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3["center"];
        var_5 = var_3["radius"];
    }
}

debug_draw_aim( var_0 )
{
    var_1 = 1;
    var_2 = var_1;
    var_3 = 36;
    init_path_traversal( var_0 );
    var_0.target_from_avatar = get_target_from_avatar( var_0.targetavatar );

    while ( !update_camera_on_path( var_0 ) )
    {
        var_4 = var_0.target_from_avatar;
        var_5 = calc_cam_lookat( var_0.fparams, var_0.origin, var_4 );
        var_2--;

        if ( var_2 <= 0 )
            var_2 = var_1;
    }

    var_0.angles = ( angleclamp180( var_0.angles[0] ), angleclamp180( var_0.angles[1] ), angleclamp180( var_0.angles[2] ) );
    var_0 _meth_8092();
}

test_pathing( var_0, var_1, var_2, var_3 )
{
    level notify( "stop_test_pathing" );
    level endon( "stop_test_pathing" );
    var_4 = getentarray( "player_pos", "targetname" );
    var_5 = var_2.spawned_avatar;
    var_6 = rotateavatartagcamera( var_5 );
    var_7 = var_6.camera_tag_origin;
    var_8 = var_6.camera_tag_angles;
    var_9 = var_7;
    var_10 = var_8;
    var_11 = var_0.origin;
    var_12 = var_11 + anglestoforward( var_0.angles ) * 64;
    var_13 = var_9 + anglestoforward( var_10 ) * 64;
    var_0.origin = var_11;
    var_0.angles = var_10;
    var_0.obstacles = var_3;
    init_path_constants( var_0 );
    build_path_info( var_0, undefined, var_0.origin, var_9, var_10 );
    var_0.fparams = calc_f_from_avatar( var_5 );
    var_0.targetavatar = var_5;

    for (;;)
    {
        var_0.origin = var_11;
        var_0.angles = var_10;
        debug_draw_path( var_0.path );
        debug_draw_obstacles( var_0.obstacles );
        debug_draw_aim( var_0 );
        wait 0.05;
    }
}

debug_pathing()
{
    var_0 = 0;
    var_1 = getentarray( "player_pos", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = getent( var_3.target, "targetname" );

        if ( var_4.script_noteworthy == "camera_target" )
            var_3.camera_lookat = var_4;

        var_5 = getent( var_4.target, "targetname" );

        if ( var_5.script_noteworthy == "camera" )
        {
            var_3.camera_helper = var_5;
            var_5.camera_goal = var_3;
            var_5.camera_lookat = var_3.camera_lookat;
        }
    }

    var_7 = spawn( "script_model", ( 0, 0, 0 ) );
    var_7 _meth_80B1( "tag_player" );
    level.use_lookahead = 0;
    var_8 = 0;
    var_9 = 1;
    var_10 = "111111111111111111";
    var_11 = 16;

    for (;;)
    {
        if ( self _meth_82EE() )
        {
            while ( self _meth_82EE() )
                wait 0.05;

            var_9++;

            if ( var_9 >= 12 )
                var_9 = 0;

            if ( var_9 == var_8 )
            {
                var_9++;

                if ( var_9 >= 12 )
                    var_9 = 0;
            }

            var_0 = 1;
        }

        if ( self _meth_82EF() )
        {
            while ( self _meth_82EF() )
                wait 0.05;

            var_8++;

            if ( var_8 >= 12 )
                var_8 = 0;

            if ( var_9 == var_8 )
            {
                var_8++;

                if ( var_8 >= 12 )
                    var_8 = 0;
            }

            var_0 = 1;
        }

        if ( var_0 )
        {
            var_0 = 0;
            var_12 = [];
            var_13 = undefined;
            var_14 = undefined;

            foreach ( var_18, var_16 in var_1 )
            {
                if ( getsubstr( var_10, var_18, var_18 + 1 ) == "0" )
                    continue;

                var_17 = [];
                var_17["center"] = var_16.origin;
                var_17["radius"] = var_11;
                var_12[var_12.size] = var_17;

                if ( var_16.script_noteworthy == "" + var_8 )
                    var_13 = var_16;

                if ( var_16.script_noteworthy == "" + var_9 )
                    var_14 = var_16;
            }

            thread test_pathing( var_7, var_13, var_14, var_12 );
        }

        wait 0.2;
    }
}

debug_fly( var_0 )
{
    level.debug_fly = 1;
    var_1 = 30;
    var_2 = 10;
    var_3 = 10;
    var_4 = self _meth_844D();
    var_5 = self _meth_82F3();
    var_6 = anglestoforward( var_4 );
    var_7 = anglestoup( var_4 );
    var_8 = anglestoright( var_4 );
    var_9 = 0;

    if ( self adsbuttonpressed() )
        var_9 = -1;
    else if ( self attackbuttonpressed() )
        var_9 = 1;

    if ( self _meth_82EF() )
    {
        var_1 *= 0.1;
        var_2 *= 0.1;
        var_3 *= 0.1;
    }

    var_0.angles = var_4;
    var_0.origin = var_0.origin + var_5[0] * var_1 * var_6 + var_5[1] * var_2 * var_8 + var_9 * var_3 * var_7;
}

vlobby_vegnette( var_0, var_1 )
{
    if ( !isdefined( self.vegnette ) )
    {
        self.vegnette = newclienthudelem( self );
        self.vegnette.x = 0;
        self.vegnette.y = 0;
        self.vegnette _meth_80CC( var_1, 640, 480 );
        self.vegnette.alignx = "left";
        self.vegnette.aligny = "top";
        self.vegnette.horzalign = "fullscreen";
        self.vegnette.vertalign = "fullscreen";
        self.vegnette.alpha = var_0;
    }

    if ( isdefined( self.vegnette ) && self.vegnette.alpha > 0 && var_0 == 0 )
    {
        self.vegnette _meth_80CC( var_1, 640, 480 );
        self.vegnette.alpha = 0;
    }

    if ( isdefined( self.vegnette ) && self.vegnette.alpha < 1 && var_0 == 1 )
    {
        self.vegnette _meth_80CC( var_1, 640, 480 );
        self.vegnette.alpha = 1;
    }
}
