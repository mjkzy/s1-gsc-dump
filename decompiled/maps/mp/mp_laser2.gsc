// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_laser2_precache::main();
    maps\createart\mp_laser2_art::main();
    maps\mp\mp_laser2_fx::main();
    thread aud_init();
    maps\mp\_load::main();
    maps\mp\mp_laser2_lighting::main();
    maps\mp\mp_laser2_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_laser2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.aerial_pathnode_offset = 450;
    thread set_lighting_values();
    thread set_umbra_values();
    level.ospvisionset = "mp_laser2_osp";

    if ( level.nextgen == 1 )
        level thread rotateradar();

    level.ospvisionset = "mp_laser2_osp";
    level.osplightset = "mp_laser2_streak";
    level.mapcustomkillstreakfunc = ::laser2customkillstreakfunc;
    level.orbitalsupportoverridefunc = ::laser2customospfunc;
    level.orbitallaseroverridefunc = ::laser2customorbitallaserfunc;
    thread laser2customairstrike();
    level.anim_laserbuoy = "laser_buoy_loop";
    level.waterline_offset = 2;
    maps\mp\_water::setshallowwaterweapon( "iw5_underwater_mp" );
    level thread maps\mp\_water::init();
    precacherumble( "damage_light" );
    level dynamicevent_init_sound();
    level dynamicevent_init();
    level thread maps\mp\_dynamic_events::dynamicevent( ::handlemovingwater, undefined, ::handleendwater );
    level.alarmsystem = spawnstruct();
    level.alarmsystem.spinnerarray = getentarray( "horizonal_spinner", "targetname" );

    foreach ( var_1 in level.alarmsystem.spinnerarray )
        var_1 hide();

    level thread handleclouds();
    thread spawnsetup();
}

dynamicevent_init_sound()
{
    level.tsunami_alarm = "mp_laser2_typhoon_alarm";
    level.tsunami_vo_int = "mp_laser2_vo_tsunami_warning_int";
    level.tsunami_vo_ext = "mp_laser2_vo_tsunami_warning_ext";
}

laser2customkillstreakfunc()
{
    level.killstreakweildweapons["mp_laser2_core"] = 1;
    level thread maps\mp\killstreaks\streak_mp_laser2::init();
}

laser2customospfunc()
{
    level.orbitalsupportoverrides.spawnanglemin = 30;
    level.orbitalsupportoverrides.spawnanglemax = 90;
    level.orbitalsupportoverrides.spawnheight = 9541;

    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.leftarc = 20;
        level.orbitalsupportoverrides.rightarc = 20;
        level.orbitalsupportoverrides.toparc = -30;
        level.orbitalsupportoverrides.bottomarc = 60;
    }
}

laser2customorbitallaserfunc()
{
    level.orbitallaseroverrides.spawnheight = 3300;
}

laser2customairstrike()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 1750;
}

set_lighting_values()
{
    if ( isusinghdr() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "2" );
        }
    }
}

set_umbra_values()
{
    setdvar( "r_umbraAccurateOcclusionThreshold", 256 );
}

handleclouds()
{
    var_0 = 122;
    activatepersistentclientexploder( var_0 );
    level thread handlecloudsaerialjoin();
    level thread handlecloudsaerialleave();
}

enablecloudsexploder( var_0 )
{
    var_1 = 122;
    var_2 = 0;
    var_3 = [];

    if ( isdefined( var_0 ) )
    {
        var_2 = 1;
        var_3[var_3.size] = var_0;

        if ( isdefined( var_0.disablecloudscount ) )
        {
            var_0.disablecloudscount--;

            if ( var_0.disablecloudscount <= 0 )
                var_0.disablecloudscount = 0;
        }
    }
    else
    {
        foreach ( var_5 in level.players )
        {
            if ( isdefined( var_5.disablecloudscount ) )
            {
                var_5.disablecloudscount--;

                if ( var_5.disablecloudscount > 0 )
                    var_2 = 1;
                else
                    var_5.disablecloudscount = 0;

                var_3[var_3.size] = var_5;
            }
        }
    }

    if ( var_2 )
        activatepersistentclientexploder( var_1, var_3 );
    else
        activatepersistentclientexploder( var_1 );
}

disablecloudsexploder( var_0, var_1 )
{
    var_2 = 122;
    var_3 = [];
    level thread common_scripts\_exploder::deactivate_clientside_exploder( var_2, var_0, var_1 );

    if ( isdefined( var_0 ) )
        var_3[var_3.size] = var_0;
    else
        var_3 = level.players;

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5.disablecloudscount ) )
        {
            var_5.disablecloudscount++;
            continue;
        }

        var_5.disablecloudscount = 1;
    }
}

handlecloudsaerialjoin()
{
    for (;;)
    {
        level waittill( "player_start_aerial_view", var_0 );
        level disablecloudsexploder( var_0, 1 );
    }
}

handlecloudsaerialleave()
{
    for (;;)
    {
        level waittill( "player_stop_aerial_view", var_0 );
        level enablecloudsexploder( var_0 );
    }
}

rotateradar()
{
    wait 0.05;
    var_0 = getent( "radar_dish01_rotate", "targetname" );
    maps\mp\_audio::scriptmodelplayanimwithnotify( var_0, "lsr_radar_dish_loop", "ps_emt_satellite_dish_rotate", "emt_satellite_dish_rotate", "laser2_custom_end_notify", "laser2_custom_ent_end_notify", "laser2_custom_ent2_end_notify" );
}

handlepropattachments( var_0 )
{
    if ( isdefined( self.target ) )
    {
        var_1 = getentarray( self.target, "targetname" );

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_0 ) )
            {
                var_3 vehicle_jetbikesethoverforcescale( var_0 );
                continue;
            }

            var_3 vehicle_jetbikesethoverforcescale( self );
        }
    }
}

dynamicevent_init()
{
    level endon( "game_ended" );
    level.water_warning = undefined;
    level.ocean = undefined;
    var_0 = getentarray( "ocean_water", "targetname" );

    if ( isdefined( var_0 ) )
    {
        level.ocean = var_0[0];

        if ( var_0.size > 0 )
        {
            level.ocean_pieces = common_scripts\utility::array_remove( var_0, level.ocean );
            common_scripts\utility::array_thread( level.ocean_pieces, ::linktoent, level.ocean );
        }
    }

    level.ocean.warning_time = 30;
    level.ocean.origin -= ( 0, 0, 132 );
    var_1 = getent( "ocean_water_underside", "targetname" );
    var_2 = getentarray( "trigger_underwater", "targetname" );
    var_3 = getentarray( "ocean_moving_prop", "targetname" );
    var_4 = getentarray( "buoy", "targetname" );
    var_5 = [];
    level.moving_buoys = [];
    var_6 = getentarray( "water_clip", "targetname" );
    level.post_event_geo = getentarray( "post_event_geo", "targetname" );
    level.end_state_geo = getentarray( "end_state_geo", "targetname" );
    level.post_event_nodes = getnodearray( "post_event_node", "targetname" );
    level.pre_event_nodes = getnodearray( "pre_event_node", "targetname" );
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    level.drop_pod_bad_places = getentarray( "drop_pod_bad_place", "targetname" );
    level.post_event_pathing_blockers = getentarray( "post_event_pathing_blocker", "targetname" );
    level.pre_event_pathing_blockers = getentarray( "pre_event_pathing_blocker", "targetname" );
    level handle_event_geo_off();
    level thread handle_pathing_pre_event();

    foreach ( var_8 in var_3 )
    {
        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "has_collision" )
            var_5[var_5.size] = var_8;
    }

    foreach ( var_11 in var_4 )
    {
        if ( isdefined( var_11.script_noteworthy ) && var_11.script_noteworthy == "moving" )
            level.moving_buoys[level.moving_buoys.size] = var_11;
    }

    var_13 = common_scripts\utility::array_combine( var_3, level.moving_buoys );
    thread maps\mp\mp_laser2_fx::setupwaves( level.ocean );
    thread maps\mp\mp_laser2_fx::setupoceanfoam( level.ocean );

    if ( isdefined( level.waterline_ents ) )
        common_scripts\utility::array_thread( level.waterline_ents, ::linktoent, level.ocean );

    if ( level.nextgen )
        var_1 linktoent( level.ocean );

    if ( isdefined( var_6 ) && var_6.size > 0 )
        common_scripts\utility::array_thread( var_6, ::linktoent, level.ocean );

    if ( isdefined( var_13 ) && var_13.size > 0 )
        common_scripts\utility::array_thread( var_13, ::linktoent, level.ocean );

    if ( isdefined( var_2 ) && var_2.size > 0 && isdefined( level.ocean ) )
    {
        foreach ( var_15 in var_2 )
            var_15 thread handlewatertriggermovement( level.ocean );
    }

    if ( isdefined( level.goliath_bad_landing_volumes ) && level.goliath_bad_landing_volumes.size > 0 && isdefined( level.ocean ) )
    {
        foreach ( var_15 in level.goliath_bad_landing_volumes )
        {
            if ( isdefined( var_15.script_noteworthy ) && var_15.script_noteworthy == "dont_move_me" )
                continue;
            else
                var_15 thread handlewatertriggermovement( level.ocean );
        }
    }

    if ( isdefined( var_5 ) && var_5.size > 0 )
        common_scripts\utility::array_thread( var_5, ::handlepropattachments, level.ocean );

    if ( isdefined( var_4 ) && var_4.size > 0 )
        common_scripts\utility::array_thread( var_4, ::playbuoylights );

    if ( isdefined( level.moving_buoys ) && level.moving_buoys.size > 0 )
    {
        common_scripts\utility::array_thread( level.moving_buoys, ::playpropanim, level.anim_laserbuoy );
        common_scripts\utility::array_thread( level.moving_buoys, ::handlepropattachments, level.ocean );
    }

    var_19 = getent( "tidal_wave", "targetname" );
    var_19 hide();
    common_scripts\utility::trigger_off( "trig_kill_00", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_01", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_02", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_03", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_04", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_drone_vista", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_00", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_01", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_02", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_03", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_04", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_drone_vista", "targetname" );
    thread maps\mp\mp_laser2_fx::playwaves( "end_initial_waves", 4, 6, "breaking_wave_01" );
    level setoceansinvalueslowtide();
}

connect_paths()
{
    if ( isdefined( self ) )
        self connectpaths();
}

disconnect_paths()
{
    if ( isdefined( self ) )
        self disconnectpaths();
}

connect_nodes()
{
    if ( isdefined( self ) )
        self connectnode();
}

disconnect_nodes()
{
    if ( isdefined( self ) )
        self disconnectnode();
}

hidegeo()
{
    if ( isdefined( self ) && !isdefined( self.ishidden ) )
    {
        self.ishidden = 1;
        common_scripts\utility::trigger_off();
    }
}

showgeo()
{
    if ( isdefined( self ) && isdefined( self.ishidden ) )
    {
        self.ishidden = undefined;
        common_scripts\utility::trigger_on();
    }
}

oceansinmovement( var_0 )
{
    level endon( "game_ended" );
    level endon( "end_initial_waves" );
    self notify( "ocean_sin_movement" );
    self endon( "ocean_sin_movement" );

    for (;;)
    {
        self moveto( ( 0, level.oceansinamplitude, level.oceansinamplitude ) + var_0, level.oceansinperiod / 2, level.oceansinperiod * 0.25, level.oceansinperiod * 0.25 );
        wait(level.oceansinperiod / 2);
        self moveto( -1 * ( 0, level.oceansinamplitude, level.oceansinamplitude ) + var_0, level.oceansinperiod / 2, level.oceansinperiod * 0.25, level.oceansinperiod * 0.25 );
        wait(level.oceansinperiod / 2);
    }
}

setoceansinvalueslowtide()
{
    if ( level.nextgen )
    {
        level.oceansinamplitude = 12;
        level.oceansinperiod = 10;
    }
    else
    {
        level.oceansinamplitude = 16;
        level.oceansinperiod = 20;
    }
}

setoceansinvalueshightide()
{
    level.oceansinamplitude = 6;
    level.oceansinperiod = 10;
}

linktoent( var_0 )
{
    var_1 = self;
    var_1 vehicle_jetbikesethoverforcescale( var_0 );
}

handlebuoydings( var_0, var_1 )
{
    level endon( "game_ended" );

    for (;;)
    {
        wait(randomfloatrange( 0.05, 0.5 ));

        while ( !isdefined( level.water_warning ) || level.water_warning != 1 )
        {
            maps\mp\_utility::play_sound_on_tag( var_1, "tag_origin" );
            wait(randomfloatrange( 3, 7 ));
        }

        while ( level.water_warning == 1 )
        {
            maps\mp\_utility::play_sound_on_tag( var_0, "tag_origin" );
            wait(randomfloatrange( 1.5, 4.5 ));
        }
    }
}

playbuoylights()
{
    self notify( "stop_buoy_lights" );
    self endon( "stop_buoy_lights" );
    playfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
    wait(randomfloat( 4 ));
    stopfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
}

playpropanim( var_0 )
{
    wait(randomfloatrange( 0.1, 1 ));
    self scriptmodelplayanim( var_0 );
}

oceanmover_init( var_0 )
{
    level endon( "game_ended" );
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return undefined;

    var_1.warning_time = 30;
    return var_1;
}

oceanobjectmover_init( var_0 )
{
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1.targetname = "OceanObjectMover";
    var_1.dist_prop = ( 0, 352, 0 );
    return var_1;
}

moving_water_init()
{
    level endon( "game_ended" );
    thread maps\mp\mp_laser2_fx::playwaves( "end_initial_waves", 4, 6, "breaking_wave_01" );
}

handleendwater()
{
    level.ocean.origin += ( 0, 0, 72 );
    level notify( "end_initial_waves" );
    thread maps\mp\mp_laser2_fx::playwaves( undefined, 6, 8, "breaking_wave_01" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 201 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 202 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 203 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 204 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 205 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 206 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 207 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 208 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 209 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 121 );

    if ( isdefined( level.end_state_geo ) )
        common_scripts\utility::array_thread( level.end_state_geo, ::showgeo );

    level handle_event_geo_on();
    level maps\mp\_utility::delaythread( 0.05, ::handle_pathing_post_event );
}

handlemovingwater()
{
    level endon( "game_ended" );
    level disablecloudsexploder( undefined, 0 );
    level.skipoceanspawns = 1;
    var_0 = level.ocean;
    var_1 = getent( "tidal_wave", "targetname" );
    var_1 show();
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.targetname = "ocean_tag_origin";
    var_2 show();
    var_3 = getent( "lsr_tidal_wave_car", "targetname" );
    var_4 = getent( "lsr_tidal_wave_shipping_container_closed", "targetname" );
    var_5 = getent( "lsr_tidal_wave_shipping_container_open", "targetname" );
    create_bot_badplaces();

    foreach ( var_7 in level.water_triggers )
        var_7 thread killobjectsunderwater();

    level thread addposteventgeotocratebadplacearray();
    level thread killplayersusingremotestreaks();
    wait 0.05;
    level.water_warning = 1;
    level notify( "end_initial_waves" );
    thread maps\mp\mp_laser2_aud::start_rough_tide();
    var_9 = 2;
    earthquake( 0.3, var_9, ( 0, 0, 0 ), 5000 );
    thread aud_dynamic_event_startup( var_9 );
    thread play_earthquake_rumble_for_all_players( 0.75 );
    level maps\mp\_utility::delaythread( 3, ::handletsunamiwarningsounds );
    var_10 = 26.667;
    var_11 = 36.7;
    var_12 = var_11;

    if ( var_10 > var_11 )
        var_12 = var_10;

    if ( var_0.warning_time > var_12 )
        wait(var_0.warning_time - var_12);
    else
        wait 2;

    var_1 thread tidal_wave_notetracks();
    var_1 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_mesh_anim", "tidal_wave_notetrack" );
    var_0 linkto( var_2 );
    var_2 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_ocean_anim" );

    if ( isdefined( var_3 ) )
        var_3 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_car" );

    var_4 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_shipping_container_closed" );
    var_5 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_shipping_container_open" );

    foreach ( var_14 in level.moving_buoys )
    {
        if ( isdefined( var_14.animation ) )
        {
            var_14 scriptmodelclearanim();
            var_14 unlink();
            var_14 scriptmodelplayanimdeltamotion( var_14.animation );
            var_14 thread playbuoylights();
            var_14 maps\mp\_utility::delaythread( var_11, ::buoys_return_to_bobbing );
        }
    }

    level maps\mp\_utility::delaythread( var_10 - 3, ::stop_water_warning );
    level maps\mp\_utility::delaythread( var_10 - 2.9, ::play_earthquake_rumble_for_all_players, 0.75 );
    var_1 common_scripts\utility::delaycall( var_10, ::hide );
    var_2 common_scripts\utility::delaycall( var_11, ::hide );
    var_0 common_scripts\utility::delaycall( var_11, ::unlink );
    wait(var_12);
    var_16 = getnodearray( "water_nodes", "targetname" );

    foreach ( var_18 in var_16 )
        nodesetnotusable( var_18, 1 );

    delete_bot_badplaces();
    level.skipoceanspawns = 0;
    wait 2;
    thread maps\mp\mp_laser2_fx::playwaves( undefined, 6, 8, "breaking_wave_01" );
    level notify( "dynamic_event_complete" );
}

create_bot_badplaces()
{
    badplace_cylinder( "badplace_1", -1, ( -1096, -688, 229.5 ), 300, 200 );
    badplace_cylinder( "badplace_2", -1, ( -544, -1104, 158 ), 500, 200 );
    badplace_cylinder( "badplace_3", -1, ( 0, -1024, 154.286 ), 500, 200 );
    badplace_cylinder( "badplace_4", -1, ( 608, -1152, 153.195 ), 500, 200 );
    badplace_cylinder( "badplace_5", -1, ( 1360, -832, 203.4 ), 500, 200 );
    badplace_cylinder( "badplace_6", -1, ( 2128, -416, 159.325 ), 500, 200 );
    badplace_cylinder( "badplace_7", -1, ( 2464, 176, 128 ), 500, 200 );
}

delete_bot_badplaces()
{
    badplace_delete( "badplace_1" );
    badplace_delete( "badplace_2" );
    badplace_delete( "badplace_3" );
    badplace_delete( "badplace_4" );
    badplace_delete( "badplace_5" );
    badplace_delete( "badplace_6" );
    badplace_delete( "badplace_7" );
}

killobjectsunderwater()
{
    level endon( "game_ended" );
    level endon( "dynamic_event_complete" );

    for (;;)
    {
        if ( isdefined( level.turrets ) )
        {
            foreach ( var_1 in level.turrets )
            {
                if ( var_1 istouching( self ) )
                    var_1 notify( "death" );
            }
        }

        if ( isdefined( level.carepackages ) )
        {
            foreach ( var_4 in level.carepackages )
            {
                if ( isdefined( var_4 ) && !isremovedentity( var_4 ) && var_4 iscarepackageinposteventgeo() )
                {
                    if ( isdefined( var_4.cratetype ) && var_4.cratetype != "juggernaut" )
                    {
                        var_4 maps\mp\killstreaks\_airdrop::deletecrate( 1, 1 );
                        continue;
                    }

                    if ( isdefined( var_4.cratetype ) && var_4.cratetype == "juggernaut" )
                        var_4 maps\mp\killstreaks\_juggernaut::deletegoliathpod( 1, 1 );
                }
            }
        }

        wait 0.05;
    }
}

iscarepackageinposteventgeo()
{
    if ( isdefined( level.drop_pod_bad_places ) )
    {
        foreach ( var_1 in level.drop_pod_bad_places )
        {
            if ( ispointinvolume( self.origin, var_1 ) )
                return 1;
        }
    }

    return 0;
}

addposteventgeotocratebadplacearray()
{
    level waittill( "post_event_geo_on" );

    foreach ( var_1 in level.drop_pod_bad_places )
        level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_1;
}

killplayersusingremotestreaks()
{
    level endon( "game_ended" );
    level endon( "dynamic_event_complete" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1 ) && isdefined( var_1.inwater ) && var_1 maps\mp\_utility::isusingremote() )
                var_1 maps\mp\_utility::_suicide();
        }

        wait 0.05;
    }
}

buoys_return_to_bobbing()
{
    linktoent( level.ocean );
    self scriptmodelclearanim();
    wait(randomfloatrange( 0.1, 1 ));
    self scriptmodelplayanim( level.anim_laserbuoy );
    thread playbuoylights();
}

play_earthquake_rumble_for_all_players( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 thread play_earthquake_rumble( var_0 );
}

play_earthquake_rumble( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for ( var_1 = var_0 * 20; var_1 >= 0; var_1 -= 2 )
    {
        self playrumbleonentity( "damage_light" );
        wait 0.1;
    }
}

stop_water_warning()
{
    level.water_warning = 0;
    common_scripts\utility::array_thread( level.alarmsystem.spinnerarray, ::spinalarmsstop );
}

tidal_wave_notetracks()
{
    thread event_fx();
    thread event_killtriggers();
    thread event_geo();
}

event_fx()
{
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_mist_start" );
    thread maps\mp\mp_laser2_fx::start_wave_mist_fx();
    self waittillmatch( "tidal_wave_notetrack", "vfx_receding_foam_start" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 120 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 100 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_rocks1_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 101 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 201 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 0 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_tower_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 102 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 202 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 1 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_concrete_chunk1_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 103 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 203 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 2 );
    thread maps\mp\mp_laser2_fx::stop_wave_mist_fx();
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse1_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 104 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 204 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 3 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse2_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 105 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 205 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 4 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse3_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 106 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 206 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 5 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_midbeach_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 107 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 207 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 6 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_helipad_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 108 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 208 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 7 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_helipad_splash2" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 109 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 209 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 8 );
    wait 1.0;
    level thread common_scripts\_exploder::activate_clientside_exploder( 121 );
    level enablecloudsexploder();
}

event_killtriggers()
{
    common_scripts\utility::trigger_on( "trig_kill_drone_vista", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_00" );
    common_scripts\utility::trigger_off( "trig_kill_drone_vista", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_00", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_01" );
    common_scripts\utility::trigger_off( "trig_kill_00", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_01", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_02" );
    common_scripts\utility::trigger_off( "trig_kill_01", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_02", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_03" );
    common_scripts\utility::trigger_off( "trig_kill_02", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_03", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_04" );
    common_scripts\utility::trigger_off( "trig_kill_03", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_04", "targetname" );
    maps\mp\_utility::delaythread( 1, common_scripts\utility::trigger_off, "trig_kill_04", "targetname" );
}

event_geo()
{
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_04" );
    level handle_event_geo_on();
    level handle_pathing_post_event();
}

handle_event_geo_on()
{
    if ( isdefined( level.post_event_geo ) )
    {
        foreach ( var_1 in level.post_event_geo )
            var_1 showgeo();

        level notify( "post_event_geo_on" );
    }

    if ( isdefined( level.drop_pod_bad_places ) )
    {
        foreach ( var_4 in level.drop_pod_bad_places )
            var_4 showgeo();
    }
}

handle_event_geo_off()
{
    if ( isdefined( level.post_event_geo ) )
    {
        foreach ( var_1 in level.post_event_geo )
            var_1 hidegeo();

        level notify( "post_event_geo_off" );
    }

    if ( isdefined( level.drop_pod_bad_places ) )
    {
        foreach ( var_4 in level.drop_pod_bad_places )
            var_4 hidegeo();
    }

    if ( isdefined( level.end_state_geo ) )
        common_scripts\utility::array_thread( level.end_state_geo, ::hidegeo );
}

handle_pathing_pre_event()
{
    if ( getdvar( "scr_dynamic_event_state", "on" ) != "endstate" && ( !isdefined( level.dynamiceventstype ) || level.dynamiceventstype != 2 ) )
        wait 0.05;

    foreach ( var_1 in level.pre_event_pathing_blockers )
    {
        var_1 disconnect_paths();
        var_1 hidegeo();
    }

    foreach ( var_1 in level.post_event_pathing_blockers )
    {
        var_1 hidegeo();
        var_1 connect_paths();
    }
}

handle_pathing_post_event()
{
    if ( isdefined( level.post_event_pathing_blockers ) )
    {
        foreach ( var_1 in level.post_event_pathing_blockers )
        {
            var_1 showgeo();
            var_1 disconnect_paths();
            var_1 hidegeo();
        }
    }

    if ( isdefined( level.pre_event_pathing_blockers ) )
        common_scripts\utility::array_thread( level.pre_event_pathing_blockers, ::connect_paths );
}

oceanobjectmover_set_goal( var_0 )
{
    if ( var_0.direction == "up" && 0 )
        self.goal = self.loc_start;
    else if ( var_0.direction == "down" && 1 )
        self.goal = self.loc_start;
    else
        self.goal = self.loc_end;
}

activate_splashes( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );

    if ( isdefined( var_1 ) )
    {
        level notify( var_1 );
        level endon( var_1 );
    }

    if ( !isdefined( var_2 ) )
        var_2 = 3;

    if ( !isdefined( var_3 ) )
        var_3 = 5;

    for (;;)
    {
        level thread common_scripts\_exploder::activate_clientside_exploder( var_0 );
        wait(randomfloatrange( var_2, var_3 ));
    }
}

handlewatertriggermovement( var_0 )
{
    level endon( "game_ended" );
    var_1 = undefined;

    if ( isdefined( self.target ) )
        var_1 = common_scripts\utility::getstruct( self.target, "targetname" );

    var_2 = self.origin - var_0.origin;
    childthread movetrig( var_0, var_2 );

    if ( isdefined( var_1 ) )
    {
        var_3 = var_1.origin[2] - self.origin[2];
        var_4 = var_2 + ( 0, 0, var_3 );
        var_1 childthread movetrig( var_0, var_4 );
    }
}

movetrig( var_0, var_1 )
{
    for (;;)
    {
        self.origin = var_0.origin + var_1;
        wait 0.05;
    }
}

spawnsetup()
{
    level.skipoceanspawns = 0;
    level.dynamicspawns = ::getlistofgoodspawnpoints;
}

getlistofgoodspawnpoints( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3 isvalidspawn() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

isvalidspawn()
{
    if ( level.skipoceanspawns == 1 && self.targetname == "ocean_spawn" )
        return 0;

    return 1;
}

spinalarmsstart()
{
    self show();
    self rotatevelocity( ( 0, 600, 0 ), 12 );
    var_0 = getscriptablearray( "tsunami_alarm", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 setscriptablepartstate( "static_part", "siren_on" );
}

spinalarmsstop()
{
    self hide();
    var_0 = getscriptablearray( "tsunami_alarm", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 setscriptablepartstate( "static_part", "siren_off" );
}

aud_init()
{

}

aud_dynamic_event_startup( var_0 )
{
    thread aud_handle_earthquake( var_0 );
    thread aud_handle_warning_vo();
    thread aud_handle_wave_incoming();
    thread aud_handle_buoy_sfx();
}

aud_handle_warning_vo()
{
    wait 2;
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_vo_tsunami_warn_tide", ( 0, 0, 0 ) );
    wait 5;
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_vo_tsunami_warn_high_ground", ( 0, 0, 0 ) );
}

aud_handle_earthquake( var_0 )
{
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_ty_initial_hit", ( 0, 0, 0 ) );
}

aud_handle_buoy_sfx()
{
    level endon( "aud_kill_dings" );

    for (;;)
    {
        thread maps\mp\_audio::snd_play_in_space( "mp_laser_buoy_ding_event", ( 150, -2295, 403 ) );
        wait 0.5;
        thread maps\mp\_audio::snd_play_in_space( "mp_laser_buoy_ding_event", ( 1026, -2381, 403 ) );
        wait 6;
    }
}

aud_handle_wave_incoming()
{
    var_0 = thread maps\mp\_audio::snd_play_loop_in_space( "mp_laser2_ty_quake_lp", ( 79, -1591, 455 ), "aud_dynamic_event_end" );
    thread aud_handle_waves_crash();
    var_0 scalevolume( 0, 0.05 );
    wait 16.5;
    thread aud_handle_incoming();
    var_0 scalevolume( 0.8, 8 );
}

aud_handle_incoming()
{
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_ty_incoming", ( 79, -1591, 455 ) );
    wait 4;
    level notify( "aud_kill_dings" );
    earthquake( 0.1, 4, ( 79, -1591, 455 ), 2500 );
    wait 1.2;
    earthquake( 0.2, 4, ( 79, -1591, 455 ), 2500 );
    wait 2;
    earthquake( 0.3, 5.5, ( 79, -1591, 455 ), 2500 );
}

aud_handle_waves_crash()
{
    wait 27;
    level notify( "aud_dynamic_event_end" );
    level._snd.dynamic_event_happened = 1;

    foreach ( var_1 in level.players )
    {
        var_1 clientclearsoundsubmix( "mp_pre_event_mix" );
        wait 0.05;
    }

    wait 0.05;

    foreach ( var_1 in level.players )
    {
        var_1 clientaddsoundsubmix( "mp_post_event_mix", 1 );
        wait 0.05;
    }
}

handletsunamiwarningsounds()
{
    level endon( "game_ended" );
    var_0 = getentarray( "tsunami_speaker", "targetname" );

    while ( level.water_warning == 1 )
    {
        if ( isdefined( var_0 ) )
        {
            foreach ( var_2 in var_0 )
                playsoundatpos( var_2.origin, level.tsunami_alarm );

            playsoundatpos( ( 0, 0, 0 ), level.tsunami_alarm );
        }

        common_scripts\utility::array_thread( level.alarmsystem.spinnerarray, ::spinalarmsstart );
        wait 2;

        if ( !isdefined( level.water_warning ) || level.water_warning != 1 )
            return;

        foreach ( var_2 in var_0 )
        {

        }

        wait 3;
    }
}
