// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::torqued_callbackstartgametype;
    maps\mp\mp_torqued_precache::main();
    maps\createart\mp_torqued_art::main();
    maps\mp\mp_torqued_fx::main();
    torqued_set_lighting_state_patched( 1, 0 );
    maps\mp\_load::main();
    maps\mp\mp_torqued_lighting::main();
    maps\mp\mp_torqued_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_torqued" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if ( level.nextgen || _func_27A() && getdvar( "g_gametype" ) != "ball" )
        thread torqued_avalanche_setup();
    else
        thread torqued_avalanche_disable();

    maps\mp\_water::init();
    level.ospvisionset = "mp_torqued_osp";
    level.osplightset = "mp_torqued_osp";
    level.warbirdvisionset = "mp_torqued_osp";
    level.warbirdlightset = "mp_torqued_osp";
    level.vulcanvisionset = "mp_torqued_osp";
    level.vulcanlightset = "mp_torqued_osp";
    level.skip_bot_node_checks = 1;
    common_scripts\utility::flag_init( "event_fatal_damage" );
    precacherumble( "tank_rumble" );
    precacherumble( "damage_light" );
    precacheshellshock( "default" );

    if ( level.nextgen )
    {
        map_restart( "trq_gondola_car_swing_01" );
        map_restart( "trq_gondola_car_swing_02" );
        map_restart( "trq_gondola_car_swing_03" );
        map_restart( "trq_gondola_car_swinghard_01" );
        map_restart( "trq_avalanche_pine_tree01" );
        map_restart( "trq_avalanche_pine_tree02" );
    }

    map_restart( "trq_hanglights_02_swing_calm_light00" );
    map_restart( "trq_hanglights_02_swing_calm_light01" );
    map_restart( "trq_hanglights_02_swing_calm_light02" );
    map_restart( "trq_hanglights_02_swing_calm_light03" );
    map_restart( "trq_hanglights_02_swing_calm_light04" );
    map_restart( "trq_hanglights_02_swing_calm_light05" );
    map_restart( "trq_hanglights_02_swing_calm_light06" );
    map_restart( "trq_hanglights_02_swing_hard_light00" );
    map_restart( "trq_hanglights_02_swing_hard_light01" );
    map_restart( "trq_hanglights_02_swing_hard_light02" );
    map_restart( "trq_hanglights_02_swing_hard_light03" );
    map_restart( "trq_hanglights_02_swing_hard_light04" );
    map_restart( "trq_hanglights_02_swing_hard_light05" );
    map_restart( "trq_hanglights_02_swing_hard_light06" );
    map_restart( "trq_hanglights_03_swing_calm_light00" );
    map_restart( "trq_hanglights_03_swing_calm_light01" );
    map_restart( "trq_hanglights_03_swing_calm_light02" );
    map_restart( "trq_hanglights_03_swing_calm_light03" );
    map_restart( "trq_hanglights_03_swing_hard_light00" );
    map_restart( "trq_hanglights_03_swing_hard_light01" );
    map_restart( "trq_hanglights_03_swing_hard_light02" );
    map_restart( "trq_hanglights_03_swing_hard_light03" );
    map_restart( "trq_hanglights_04_swing_calm_light00" );
    map_restart( "trq_hanglights_04_swing_calm_light01" );
    map_restart( "trq_hanglights_04_swing_calm_light02" );
    map_restart( "trq_hanglights_04_swing_calm_light03" );
    map_restart( "trq_hanglights_04_swing_calm_light04" );
    map_restart( "trq_hanglights_04_swing_calm_light05" );
    map_restart( "trq_hanglights_04_swing_hard_light00" );
    map_restart( "trq_hanglights_04_swing_hard_light01" );
    map_restart( "trq_hanglights_04_swing_hard_light02" );
    map_restart( "trq_hanglights_04_swing_hard_light03" );
    map_restart( "trq_hanglights_04_swing_hard_light04" );
    map_restart( "trq_hanglights_04_swing_hard_light05" );
    level.orbitalsupportoverridefunc = ::torquedpaladinoverrides;
    thread torquedairstrieoverrides();
    thread scriptpatchclip();
    thread scriptkilltrigger();
    thread movewarbirdspawn();

    if ( level.nextgen )
    {
        thread merry_go_round_setup();
        thread gondola_anims();
        thread tree_anims();
    }
    else
    {
        if ( _func_27A() )
            thread merry_go_round_setup();
        else
            thread merry_go_round_disable();

        thread gondola_anims_disable();
        thread tree_anims_disable();
    }

    thread christmas_light_anims();
    thread event_path_swap();
    thread event_bcs_trigger_swap();
    thread scorestreak_blockers();

    if ( level.currentgen )
    {
        level.prevragdollstartvalue = getdvar( "r_ragdollStartHeight" );
        setdvar( "r_ragdollStartHeight", 600 );
        thread setcgragdolldvar( level.prevragdollstartvalue );
    }
}

scriptkilltrigger()
{
    thread spawnkilltriggerthink( ( -876, -2008, 641.379 ), 128, 128 );
}

spawnkilltriggerthink( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = spawn( "trigger_radius", var_0, 0, var_1, var_2 );

    if ( !isdefined( var_3 ) )
        return;

    for (;;)
    {
        var_3 waittill( "trigger", var_4 );

        if ( isdefined( var_4 ) && isdefined( var_4.health ) )
        {
            if ( isplayer( var_4 ) || isbot( var_4 ) )
                var_4 _meth_8051( var_4.health + 999, var_3.origin );
        }
    }
}

movewarbirdspawn()
{
    var_0 = ( 2372, 612, 2164 );
    var_1 = ( 2152, 634, 2164 );
    var_2 = getentarray( "script_origin", "classname" );

    foreach ( var_4 in var_2 )
    {
        var_5 = distance( var_4.origin, var_0 );

        if ( var_5 <= 5 )
        {
            var_4.origin = var_1;
            break;
        }
    }
}

torqued_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

scorestreak_blockers()
{
    waitframe();

    if ( !isdefined( level.goliath_bad_landing_volumes ) )
        level.goliath_bad_landing_volumes = [];

    level.goliath_bad_landing_volumes = getentarray( "no_streak_goliath", "targetname" );
    level.drop_pod_bad_places = getentarray( "drop_pod_bad_place", "targetname" );

    foreach ( var_1 in level.drop_pod_bad_places )
        level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_1;
}

christmas_light_anims()
{
    var_0 = getent( "anim_node_christmas_lights", "targetname" );
    var_1 = getentarray( "lights_02", "targetname" );
    var_2 = getentarray( "lights_03", "targetname" );
    var_3 = getentarray( "lights_04", "targetname" );
    var_4 = [];
    var_4 = common_scripts\utility::array_combine( var_4, var_1 );
    var_4 = common_scripts\utility::array_combine( var_4, var_2 );
    var_4 = common_scripts\utility::array_combine( var_4, var_3 );
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;

    foreach ( var_9 in var_1 )
    {
        var_10 = "trq_hanglights_02_swing_calm_light0" + var_5;
        var_9 _meth_848B( var_10, var_0.origin, var_0.angles );
        var_5++;
        wait 0.15;
    }

    foreach ( var_9 in var_2 )
    {
        var_10 = "trq_hanglights_03_swing_calm_light0" + var_6;
        var_9 _meth_848B( var_10, var_0.origin, var_0.angles );
        var_6++;
        wait 0.15;
    }

    foreach ( var_9 in var_3 )
    {
        var_10 = "trq_hanglights_04_swing_calm_light0" + var_7;
        var_9 _meth_848B( var_10, var_0.origin, var_0.angles );
        var_7++;
        wait 0.15;
    }

    level waittill( "avalanche_start" );

    foreach ( var_9 in var_4 )
    {
        var_9 _meth_827A();
        waitframe();
    }

    var_5 = 0;
    var_6 = 0;
    var_7 = 0;

    foreach ( var_9 in var_1 )
    {
        var_10 = "trq_hanglights_02_swing_hard_light0" + var_5;
        var_9 _meth_848B( var_10, var_0.origin, var_0.angles );
        var_5++;
        wait 0.15;
    }

    foreach ( var_9 in var_2 )
    {
        var_10 = "trq_hanglights_03_swing_hard_light0" + var_6;
        var_9 _meth_848B( var_10, var_0.origin, var_0.angles );
        var_6++;
        wait 0.15;
    }

    foreach ( var_9 in var_3 )
    {
        var_10 = "trq_hanglights_04_swing_hard_light0" + var_7;
        var_9 _meth_848B( var_10, var_0.origin, var_0.angles );
        var_7++;
        wait 0.15;
    }

    level waittill( "avalanche_stop" );

    foreach ( var_9 in var_4 )
    {
        var_9 _meth_827A();
        waitframe();
        var_9 delete();
    }
}

tree_anims_disable()
{
    var_0 = getentarray( "tree_ent_01", "targetname" );
    var_1 = getentarray( "tree_ent_02", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 _meth_8560();

    foreach ( var_3 in var_1 )
        var_3 _meth_8560();
}

tree_anims()
{
    var_0 = getentarray( "tree_ent_01", "targetname" );
    var_1 = getentarray( "tree_ent_02", "targetname" );
    var_2 = [];

    foreach ( var_4 in var_0 )
        var_4.anim_event = "trq_avalanche_pine_tree01";

    foreach ( var_4 in var_1 )
        var_4.anim_event = "trq_avalanche_pine_tree02";

    var_2 = common_scripts\utility::array_combine( var_2, var_0 );
    var_2 = common_scripts\utility::array_combine( var_2, var_1 );
    level waittill( "avalanche_start" );

    foreach ( var_4 in var_2 )
    {
        wait 0.15;
        var_4 _meth_8279( var_4.anim_event );
    }
}

gondola_anims_disable()
{
    var_0 = getentarray( "gondola_swing", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8560();
}

gondola_anims()
{
    var_0 = getentarray( "gondola_swing", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread swinggondola();
}

swinggondola()
{
    var_0 = [ "trq_gondola_car_swing_01", "trq_gondola_car_swing_02", "trq_gondola_car_swing_03" ];
    wait(randomfloat( 2.5 ));
    var_1 = randomint( 3 );
    self _meth_8279( var_0[var_1] );
}

setup_audio()
{

}

torqued_avalanche_setup()
{
    precacherumble( "tank_rumble" );
    precacherumble( "damage_light" );
    precacheshellshock( "default" );
    level.snowparticle01 = loadfx( "fx/snow/snow_light_outdoor" );
    level.snowexplosiondebris01 = loadfx( "vfx/test/test_snow_impact_large01_runner" );
    level.snowgustdebris01 = loadfx( "fx/snow/snow_clifftop_jet_blow_runner" );
    level.snowpuffmedium01 = loadfx( "vfx/test/test_snow_puff_medium01_runner" );
    level.snowflakesswirl01 = loadfx( "fx/snow/radar_windy_snow" );
    level.snowmistlarge01 = loadfx( "fx/snow/snow_blizzard_radar" );
    level.dynamicspawns = ::getlistofgoodspawnpoints;

    if ( !isdefined( level.dyneventavalanche ) )
        level.dyneventavalanche = spawnstruct();

    level.dyneventavalanche.debugmode = 0;
    level.dyneventavalanche.avalanchephase1time = 4;
    level.dyneventavalanche.avalanchephase2time = 3;
    level.dyneventavalanche.avalanchephase3time = 4;
    level.dyneventavalanche.meshmovetime = undefined;
    level.dyneventavalanche.mesh1moveunits = 184;
    level.dyneventavalanche.mesh2moveunits = 128;
    level.dyneventavalanche.killgraceperiod = 5;
    level.dyneventavalanche.status = "pre_avalanche";
    level.dyneventavalanche.snowexplosionarray = common_scripts\utility::getstructarray( "avalanche_explosion01", "targetname" );
    level.dyneventavalanche.snowdebrisarray = common_scripts\utility::getstructarray( "avalanche_debris_gust01", "targetname" );
    level.dyneventavalanche.snowpuffmediumarray = common_scripts\utility::getstructarray( "avalanche_street_medium_puff01", "targetname" );
    level.dyneventavalanche.snowflakesswirlarray = common_scripts\utility::getstructarray( "avalanche_flakes01", "targetname" );
    level.dyneventavalanche.snowmistlargearray = common_scripts\utility::getstructarray( "avalanche_mist_large01", "targetname" );
    level.dyneventavalanche.quakearray = common_scripts\utility::getstructarray( "rumble_quake01", "targetname" );
    level.dyneventavalanche.killvolumearray = getentarray( "quake_kill_volume01", "targetname" );
    level.dyneventavalanche.quakesmallarray = common_scripts\utility::getstructarray( "rumble_quake_small01", "targetname" );
    level.dyneventavalanche.snowmesh01 = getent( "snow_ground01", "targetname" );
    level.dyneventavalanche.snowmesh02 = getent( "snow_ground02", "targetname" );
    level.dyneventavalanche.preeventscriptables = _func_231( "pre_event_scriptable", "targetname" );
    level.dyneventavalanche.posteventscriptables = _func_231( "post_event_scriptable", "targetname" );
    level.dyneventavalanche.preeventdynents = getentarray( "pre_event_dynent", "targetname" );
    level.dyneventavalanche.posteventdynents = getentarray( "post_event_dynent", "targetname" );
    level.dyneventavalanche.soundlocations = common_scripts\utility::getstructarray( "avalanche_sound01", "targetname" );
    level thread maps\mp\_dynamic_events::dynamicevent( ::torqued_avalanche_start, ::torqued_avalanche_reset, ::torqued_avalanche_end );
    thread hidepostdestructibles();
}

torqued_avalanche_disable()
{
    var_0 = getentarray( "quake_kill_volume01", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    var_2 = getent( "snow_ground01", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 _meth_8560();

    var_2 = getent( "snow_ground02", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 _meth_8560();

    var_0 = _func_231( "pre_event_scriptable", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8560();

    var_0 = getentarray( "pre_event_scriptable", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.model != "trq_giant_holiday_tree_01" && var_2.model != "trq_giant_holiday_tree_02" && var_2.model != "trq_wooden_door_01" && var_2.model != "rec_safehouse_door_wood_cgdlc1" && var_2.model != "greece_cafepastrydisplay_01" )
            var_2 _meth_8560();
    }

    var_0 = getentarray( "pre_event_dynent", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8560();

    var_0 = _func_231( "post_event_scriptable", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    var_0 = getentarray( "post_event_scriptable", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    var_0 = getentarray( "post_event_dynent", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();
}

getlistofgoodspawnpoints( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3.targetname == "none" )
        {
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
            continue;
        }

        if ( var_3 getavalanchespawns() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

getavalanchespawns()
{
    if ( level.dyneventavalanche.status == "pre_avalanche" )
    {
        if ( self.targetname != "spawner_post_avalanche" )
            return 1;
    }
    else if ( level.dyneventavalanche.status == "post_avalanche" )
    {
        if ( self.targetname != "spawner_pre_avalanche" )
            return 1;
    }
    else if ( level.dyneventavalanche.status == "during_avalanche" )
    {

    }

    return 0;
}

hidepostdestructibles()
{
    foreach ( var_1 in level.dyneventavalanche.posteventscriptables )
        var_1 _meth_83F6( "root_part", "hidden_state" );

    foreach ( var_4 in level.dyneventavalanche.posteventdynents )
        var_4 hide();
}

swapdestructibles()
{
    foreach ( var_1 in level.dyneventavalanche.preeventscriptables )
        var_1 _meth_83F6( "root_part", "hidden_state" );

    foreach ( var_4 in level.dyneventavalanche.preeventdynents )
        var_4 hide();

    foreach ( var_1 in level.dyneventavalanche.posteventscriptables )
        var_1 _meth_83F6( "root_part", "intact_state_01" );

    foreach ( var_4 in level.dyneventavalanche.posteventdynents )
        var_4 show();
}

scriptablelightstatechange()
{
    var_0 = _func_231( "destroy_light", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2 _meth_83F6( 0, 1 );
        wait 5;
        var_2 _meth_83F6( 0, 3 );
    }

    var_4 = _func_231( "damaged_light", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 _meth_83F6( 0, 1 );

    var_8 = _func_231( "damaged_light_2", "targetname" );

    foreach ( var_10 in var_8 )
        var_10 _meth_83F6( 0, 1 );

    var_12 = _func_231( "light_fixture_damaged", "targetname" );

    foreach ( var_14 in var_12 )
        var_14 _meth_83F6( 0, 1 );
}

dropavalanchespawnpointstonewground()
{
    if ( isdefined( level.spawnpoints ) )
    {
        foreach ( var_1 in level.spawnpoints )
        {
            if ( isdefined( var_1.targetname ) )
                var_1.droptoground = 1;
        }
    }
}

movemeshafterstart( var_0 )
{
    self.origin += ( 0, 0, var_0 * -1 );
}

torqued_show_solid()
{
    if ( isdefined( self.oldcontents ) )
        self setcontents( self.oldcontents );

    if ( isdefined( self.lightingstate ) && self.lightingstate == 2 )
    {
        if ( isdefined( self.original_origin ) )
        {
            self _meth_8092();
            self.origin = self.original_origin;
        }
    }

    self show();
}

torqued_hide_notsolid()
{
    if ( !isdefined( self.oldcontents ) )
    {
        self.oldcontents = self setcontents( 0 );
        self _meth_8092();
        self.original_origin = self.origin;
        self.origin += ( 0, 0, -2000 );
    }

    self hide();
}

torqued_set_lighting_state_patched( var_0, var_1 )
{
    var_2 = getentarray();
    setomnvar( "lighting_state", var_0 );

    if ( !getdvarint( "r_reflectionProbeGenerate" ) )
    {
        foreach ( var_4 in var_2 )
        {
            if ( isdefined( var_4.lightingstate ) && ( var_4.classname == "script_brushmodel" || var_4.classname == "script_model" ) )
            {
                if ( var_4.lightingstate == 0 )
                    continue;

                if ( var_4.lightingstate == var_0 )
                {
                    var_4 torqued_show_solid();
                    var_4 _meth_855F();
                    continue;
                }

                if ( isdefined( var_1 ) && var_1 )
                {
                    var_4 hide();
                    var_4 thread delaydelete( 0.1 );
                    continue;
                }

                var_4 torqued_hide_notsolid();
            }
        }
    }
}

delaydelete( var_0 )
{
    wait(var_0);
    self delete();
}

torqued_avalanche_start()
{
    level.dyneventavalanche.status = "during_avalanche";
    level notify( "avalanche_start" );
    thread aud_avalanche_setup();
    thread startquakerumble( level.dyneventavalanche.quakearray, level.dyneventavalanche.quakesmallarray );
    thread avalanchesound( level.dyneventavalanche.soundlocations );
    thread maps\mp\mp_torqued_fx::window_swap_fx();
    thread maps\mp\mp_torqued_fx::avalanche_fx();
    thread maps\mp\mp_torqued_fx::avalanche_impact_fx();
    thread maps\mp\mp_torqued_fx::coffee_window_back_shatter();
    thread maps\mp\mp_torqued_fx::coffee_window_front_shatter();
    thread maps\mp\mp_torqued_fx::trq_window_front_shatter();
    thread maps\mp\mp_torqued_fx::boardstore_window_back_shatter();
    thread maps\mp\mp_torqued_fx::boardstore_window_front_shatter();
    thread maps\mp\mp_torqued_fx::lodge_window_front_shatter();
    thread scriptablelightstatechange();
    thread maps\mp\mp_torqued_fx::roof_falling_snow_chunk_fx();
    thread maps\mp\mp_torqued_fx::snow_edge_runoff_fx();
    thread maps\mp\mp_torqued_fx::snow_edge_runoff_stop_fx();
    wait(level.dyneventavalanche.avalanchephase1time);
    level notify( "rumble_stop" );
    wait 0.05;
    thread rumbleoutro( level.dyneventavalanche.quakearray );
    wait(level.dyneventavalanche.killgraceperiod);
    thread killvolumethink( level.dyneventavalanche.killvolumearray );
    thread maps\mp\mp_torqued_fx::avalanche_treeline_impact_fx();
    thread maps\mp\mp_torqued_fx::alley_snow_fx();
    level.dyneventavalanche.meshmovetime = level.dyneventavalanche.avalanchephase2time;
    wait(level.dyneventavalanche.avalanchephase2time + 2);

    foreach ( var_1 in level.dyneventavalanche.killvolumearray )
    {
        var_1 thread killobjectsundersnow();
        var_1 thread resetspectatorsundersnow();
    }

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        level.hordeavalanche = 1;
        level hordeavalanchekilleverything( level.dyneventavalanche.killvolumearray );
    }

    common_scripts\utility::flag_set( "event_fatal_damage" );

    if ( level.currentgen )
        thread avalanchescreenfade();

    wait 1;
    level notify( "avalanche_stop" );
    level notify( "rumble_stop" );
    wait 0.05;
    thread maps\mp\mp_torqued_fx::avalanche_hide_geo_fx();
    torqued_set_lighting_state_patched( 2, 1 );
    swapdestructibles();
    thread rumbleoutro( level.dyneventavalanche.quakearray );
    thread avalanchesound( level.dyneventavalanche.soundlocations );
    thread maps\mp\mp_torqued_fx::electrical_spark_fx();
    thread maps\mp\mp_torqued_fx::avalanche_snow_linger_fx();
    wait(level.dyneventavalanche.avalanchephase3time);

    foreach ( var_1 in level.dyneventavalanche.killvolumearray )
    {
        var_1 thread killobjectsundersnow();
        var_1 thread resetspectatorsundersnow();
    }

    level notify( "avalanche_stop" );
    level notify( "rumble_stop" );
    level.dyneventavalanche.status = "post_avalanche";
    dropavalanchespawnpointstonewground();
    level notify( "avalanche_over" );
}

avalanchescreenfade()
{
    var_0 = getentarray( "avalanche_screen_fade_zone", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "avalanche_screen_fade_lospoint", "targetname" );

    foreach ( var_3 in level.players )
    {
        var_4 = 0;

        foreach ( var_6 in var_0 )
        {
            if ( var_3 _meth_80A9( var_6 ) )
            {
                var_4 = 1;
                break;
            }
        }

        if ( var_4 )
        {
            var_8 = 0;
            var_9 = var_3 _meth_845C();
            var_10 = anglestoforward( var_3 getangles() );

            foreach ( var_12 in var_1 )
            {
                var_13 = var_12.origin - var_9;

                if ( vectordot( var_13, var_10 ) >= 0.5 && bullettracepassed( var_9, var_12.origin, 0, undefined ) )
                {
                    var_8 = 1;
                    break;
                }
            }

            if ( var_8 )
            {
                var_3 _meth_821F( 0, 350, 0.363177, 0.458081, 0.54287, 9, 0.8, 1.0 );
                var_3 thread avalanchescreenfade_shellshock( 0.75 );
            }
        }
    }

    wait 2.25;
    _func_232( 1.5 );
}

avalanchescreenfade_shellshock( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self shellshock( "stun_grenade_mp", 2, 1, 0, 0 );
}

avalanchesound( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 thread playavalanchesound();
}

playavalanchesound()
{
    level endon( "avalanche_stop" );
    wait(randomfloatrange( 0.1, 0.3 ));

    for (;;)
    {
        maps\mp\_utility::playsoundinspace( "mp_torqued_avalanche01", self.origin );
        wait(randomfloatrange( 1.5, 2.5 ));
    }
}

movesnowmesh( var_0, var_1 )
{
    self _meth_82B1( var_1 * 0.5, var_0 * 0.25 );
    self waittill( "movedone" );
    self _meth_82B1( var_1 * 0.5, var_0 * 0.75 );
    self waittill( "movedone" );
}

hordeavalanchekilleverything( var_0 )
{
    var_1 = getentarray( "trigger_hurt", "classname" );
    var_2 = var_1[0];

    foreach ( var_4 in var_0 )
    {
        foreach ( var_6 in level.players )
        {
            if ( isdefined( var_6.turret ) && !var_6.iscarrying && isdefined( var_6.turret.damagetaken ) && var_6.turret.damagetaken < var_6.turret.maxhealth )
            {
                if ( var_6.turret _meth_80A9( var_4 ) )
                    hordeavalanchekillobject( var_6.turret, var_2 );
            }

            if ( isdefined( var_6.aerialassaultdrone ) )
            {
                if ( var_6.aerialassaultdrone _meth_80A9( var_4 ) )
                    var_6.aerialassaultdrone _meth_8051( 10000, var_6.aerialassaultdrone.origin, var_6, var_6, "MOD_EXPLOSIVE", "killstreak_emp_mp" );
            }
        }

        foreach ( var_9 in level.participants )
        {
            if ( var_9 _meth_80A9( var_4 ) )
                hordeavalanchekillobject( var_9, var_2 );
        }

        foreach ( var_12 in level.flying_attack_drones )
        {
            if ( var_12 _meth_80A9( var_4 ) )
                hordeavalanchekillobject( var_12, var_2 );
        }

        foreach ( var_15 in level.hordesentryarray )
        {
            if ( var_15 _meth_80A9( var_4 ) )
                hordeavalanchekillobject( var_15, var_2 );
        }

        if ( isdefined( level.carepackages ) )
        {
            foreach ( var_18 in level.carepackages )
            {
                if ( _func_22A( var_18.origin, var_4 ) )
                {
                    if ( var_18.cratetype == "juggernaut" )
                        var_18 maps\mp\killstreaks\_juggernaut::deletegoliathpod();
                    else if ( !isdefined( var_18.en_route_in_air ) || !var_18.en_route_in_air )
                        var_18 maps\mp\killstreaks\_airdrop::deletecrate();

                    level.carepackages = common_scripts\utility::array_remove( level.carepackages, var_18 );
                }
            }
        }
    }
}

hordeavalanchekillobject( var_0, var_1 )
{
    var_0 _meth_8051( 10000, var_0.origin, var_1, var_1, "MOD_TRIGGER_HURT", "none" );
}

killvolumethink( var_0 )
{
    level endon( "avalanche_stop" );

    for (;;)
    {
        if ( !isdefined( level.players ) )
        {
            wait 1;
            continue;
        }

        foreach ( var_2 in var_0 )
            var_2 thread volumekill();

        break;
    }
}

volumekill()
{
    level endon( "avalanche_stop" );
    var_0 = 5;
    var_1 = 0;

    for (;;)
    {
        if ( var_1 >= 4 )
            var_0 = 10;

        foreach ( var_3 in level.participants )
        {
            if ( var_3 _meth_80A9( self ) )
            {
                var_3 _meth_8051( var_0, var_3.origin );

                if ( isplayer( var_3 ) )
                    var_3 shellshock( "default", 2 );

                if ( common_scripts\utility::flag( "event_fatal_damage" ) )
                    var_3 _meth_8051( 10000, var_3.origin );
            }
        }

        var_1++;
        wait 0.6;
    }
}

phaseoneavalancheparticles( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_1 )
        var_4 thread particlethink( level.snowgustdebris01 );

    if ( isdefined( var_0 ) )
    {
        foreach ( var_4 in var_0 )
            var_4 thread particlethink( level.snowexplosiondebris01 );
    }

    foreach ( var_4 in var_2 )
        var_4 thread particlethink( level.snowflakesswirl01 );
}

phasetwoavalancheparticles( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
        var_3 thread particlethink( level.snowmistlarge01 );

    wait 3;

    foreach ( var_3 in var_1 )
        var_3 thread particlethink( level.snowpuffmedium01 );
}

particlethink( var_0 )
{
    var_1 = spawnfx( var_0, self.origin );
    var_1.angles = self.angles;
    triggerfx( var_1 );
    level waittill( "avalanche_stop" );
    var_1 delete();
}

rumbleoutro( var_0 )
{
    var_1 = 768;
    var_2 = "tank_rumble";
    var_3 = 0.2;

    foreach ( var_5 in level.players )
        var_5 thread quake_outro_for_player( var_0 );

    thread onplayerconnect( var_2 );
    thread rumblewatch();
}

startquakerumble( var_0, var_1 )
{
    var_2 = "tank_rumble";
    var_3 = "damage_light";

    foreach ( var_5 in level.players )
    {
        var_5 thread quake_for_player( var_0, var_1 );
        var_5 _meth_80AE( var_3 );
        var_5 thread onplayerspawned( var_3 );
    }

    thread onplayerconnect( var_2 );
    thread rumblewatch();
}

quake_outro_for_player( var_0 )
{
    level endon( "avalanche_stop" );
    self endon( "disconnect" );
    var_1 = 1100;
    var_2 = "tank_rumble";
    var_3 = 0.2;

    for (;;)
    {
        while ( !isalive( self ) )
            wait 0.2;

        var_4 = randomfloatrange( 1.0, 1.7 );
        play_closest_quake( var_0, var_3, var_4, var_1, var_2 );
        wait(var_4 - 0.2);
    }
}

quake_for_player( var_0, var_1 )
{
    level endon( "avalanche_stop" );
    self endon( "disconnect" );
    var_2 = 1100;
    var_3 = 1100;
    var_4 = "tank_rumble";
    var_5 = 0.5;
    var_6 = 0.2;

    for (;;)
    {
        while ( !isalive( self ) )
            wait 0.2;

        var_7 = 0;
        var_8 = randomfloatrange( 1.0, 1.7 );
        var_7 = play_closest_quake( var_0, var_5, var_8, var_2, var_4 );

        if ( !var_7 )
            play_closest_quake( var_1, var_6, var_8, var_3, undefined );

        wait(var_8 - 0.2);
    }
}

play_closest_quake( var_0, var_1, var_2, var_3, var_4 )
{
    foreach ( var_6 in var_0 )
    {
        if ( distancesquared( var_6.origin, self.origin ) < var_3 * var_3 )
        {
            earthquake( var_1, var_2, var_6.origin, var_3, self );

            if ( isdefined( var_4 ) )
                playrumblelooponposition( var_4, var_6.origin );

            return 1;
        }
    }

    return 0;
}

rumblewatch()
{
    level notify( "RumbleWatchEnd" );
    level endon( "RumbleWatchEnd" );
    level waittill( "rumble_stop" );
    stopallrumbles();
}

onplayerconnect( var_0 )
{
    level notify( "onPlayerConnectEnd" );
    level endon( "onPlayerConnectEnd" );
    level endon( "rumble_stop" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 thread onplayerspawned( var_0 );
    }
}

onplayerspawned( var_0 )
{
    level endon( "rumble_stop" );

    for (;;)
    {
        self waittill( "spawned_player" );
        self _meth_80AE( var_0 );
        wait 0.05;
    }
}

torqued_avalanche_reset()
{

}

torqued_avalanche_end()
{
    thread scriptablelightstatechange();
    torqued_set_lighting_state_patched( 2, 1 );
    swapdestructibles();
    level notify( "avalanche_stop" );
    level.dyneventavalanche.status = "post_avalanche";
    dropavalanchespawnpointstonewground();
    level notify( "avalanche_over" );
}

torqued_playfxontag( var_0 )
{
    if ( isdefined( level.players ) )
    {
        foreach ( var_2 in level.players )
            playfxontagforclients( level._effect[var_0], self, "TAG_FX_1", var_2 );
    }
}

torqued_floor()
{
    var_0 = getent( "trq_rockslide_floor", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = 0.2;
    var_2 = 40;
    var_0 _meth_82B8( var_2, var_1 );
    wait(var_1);
    var_0 _meth_82BF();
    var_0 hide();
    level waittill( "rocks_reset" );
    var_0 _meth_82BE();
    var_0 show();
    var_0 _meth_82B8( -1 * var_2, 0.1 );
}

torquedpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnanglemin = 30;
    level.orbitalsupportoverrides.spawnanglemax = 120;
    level.orbitalsupportoverrides.spawnheight = 7000;
    level.orbitalsupportoverrides.spawnradius = 5000;
    level.orbitalsupportoverrides.leftarc = 30;
    level.orbitalsupportoverrides.rightarc = 30;
    level.orbitalsupportoverrides.toparc = -32;
    level.orbitalsupportoverrides.bottomarc = 67;
}

torquedairstrieoverrides()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 2000;
}

merry_go_round_disable()
{
    var_0 = getent( "merry_go_round_platform", "targetname" );
    var_1 = getent( "merry_go_round_model", "targetname" );
    var_2 = getentarray( "merry_go_round_cover", "targetname" );
    var_3 = getentarray( "merry_go_round_reindeer", "targetname" );

    foreach ( var_5 in var_2 )
    {

    }

    foreach ( var_5 in var_3 )
    {

    }
}

merry_go_round_setup()
{
    level endon( "game_ended" );
    var_0 = getent( "merry_go_round_platform", "targetname" );
    var_1 = getentarray( "merry_go_round_cover", "targetname" );
    var_2 = getentarray( "merry_go_round_reindeer", "targetname" );
    var_3 = getent( "merry_go_round_model", "targetname" );
    var_4 = 10;

    foreach ( var_6 in var_1 )
        var_6 _meth_804D( var_0 );

    foreach ( var_6 in var_2 )
        var_6 _meth_804D( var_0 );

    var_3 _meth_804D( var_0 );

    for (;;)
    {
        var_0 _meth_82BD( ( 0, -10, 0 ), var_4 );
        wait(var_4);
    }
}

event_path_swap()
{
    waitframe();
    var_0 = getnodearray( "path_event_before", "targetname" );
    var_1 = getnodearray( "path_event_after", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_3 _meth_8059();
        waitframe();
    }

    foreach ( var_3 in var_0 )
    {
        var_3 _meth_805A();
        waitframe();
    }

    level waittill( "avalanche_stop" );

    foreach ( var_3 in var_1 )
    {
        var_3 _meth_805A();
        waitframe();
    }
}

event_bcs_trigger_swap()
{
    var_0 = getentarray( "before_event_bcs", "targetname" );
    var_1 = getentarray( "after_event_bcs", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 common_scripts\utility::trigger_off();

    level waittill( "avalanche_stop" );

    foreach ( var_3 in var_0 )
        var_3 common_scripts\utility::trigger_off();

    foreach ( var_3 in var_1 )
        var_3 common_scripts\utility::trigger_on();
}

killobjectsundersnow()
{
    level endon( "game_ended" );
    level endon( "avalanche_stop" );

    for (;;)
    {
        if ( isdefined( level.turrets ) )
        {
            foreach ( var_1 in level.turrets )
            {
                if ( var_1 _meth_80A9( self ) )
                    var_1 notify( "death" );
            }
        }

        if ( isdefined( level.carepackages ) )
        {
            foreach ( var_4 in level.carepackages )
            {
                if ( isdefined( var_4 ) && !_func_294( var_4 ) && _func_22A( var_4.origin, self ) )
                {
                    if ( isdefined( var_4.cratetype ) && var_4.cratetype != "juggernaut" )
                    {
                        if ( !isdefined( var_4.en_route_in_air ) || !var_4.en_route_in_air )
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

resetspectatorsundersnow()
{
    level endon( "game_ended" );
    level endon( "avalanche_stop" );
    var_0 = getent( "mp_global_intermission", "classname" );

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2.team ) && var_2.team == "spectator" && _func_22A( var_2.origin, self ) )
                var_2 _meth_826F( var_0.origin, var_0.angles );
        }

        wait 0.05;
    }
}

aud_avalanche_setup()
{
    thread aud_avalance_alarm();
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_ty_initial_hit", ( 532, 2030, 1881 ) );
    var_0 = thread maps\mp\_audio::snd_play_loop_in_space( "mp_torqued_rumble_lp", ( 532, 2030, 1881 ), "aud_avalanche_stop" );
    var_1 = thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalance_main", ( 532, 2030, 1881 ) );
    var_2 = thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalanche_bg", ( 532, 2030, 1881 ) );
    var_0 _meth_806F( 0, 0.05 );
    var_1 _meth_806F( 0, 0.05 );
    var_2 _meth_806F( 0, 0.05 );
    wait 0.05;
    var_0 _meth_806F( 0.8, 10 );
    var_1 _meth_806F( 0.8, 5 );
    var_2 _meth_806F( 0.8, 5 );
    level waittill( "avalanche_stop" );
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalanche_wall_crash_01", ( 532, 2030, 1881 ) );
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalanche_rockslide_02", ( 532, 2030, 1881 ) );
    level notify( "aud_avalanche_stop" );
}

aud_avalance_alarm()
{
    var_0 = 2;
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalance_alarm", ( 0, 0, 0 ) );
    wait(var_0);
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalance_alarm", ( 0, 0, 0 ) );
    wait(var_0);
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalance_alarm", ( 0, 0, 0 ) );
    wait(var_0);
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalance_alarm", ( 0, 0, 0 ) );
    wait(var_0);
    thread maps\mp\_audio::snd_play_in_space( "mp_torqued_avalance_alarm", ( 0, 0, 0 ) );
}

scriptpatchclip()
{
    thread nosightclipwall();
    thread vehicleclipdoors();
    thread addpropforbadtreeclip();
    thread playerclipoverhang();
    thread playerclipsnowguard();
    thread playerweirdjitteravalanchearea();
    thread recondronepushplayersthroughwall();
    thread cornercollisionspawngifts();
    thread tourismofficejumpthroughwall();

    if ( level.nextgen )
        thread treetipstuck_makeskypillar();
}

treetipstuck_makeskypillar()
{
    var_0 = 1231;

    for ( var_1 = 0; var_1 < 128; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -987, 1495, var_0 ), ( 0, 0, 0 ) );
        var_0 += 32;
    }
}

tourismofficejumpthroughwall()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1311, -1075, 1016 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1311, -1203, 1016 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -1319, -1038, 968 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -1319, -1070, 968 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -1319, -1102, 968 ), ( 0, 0, 0 ) );
}

cornercollisionspawngifts()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1449.26, -527.981, 908 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1449.26, -527.981, 868 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1436.74, -518.019, 868 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1436.74, -518.019, 908 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -1449.26, -527.981, 908 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -1449.26, -527.981, 868 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -1436.74, -518.019, 868 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -1436.74, -518.019, 908 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -1449.26, -527.981, 908 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -1449.26, -527.981, 868 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -1436.74, -518.019, 868 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -1436.74, -518.019, 908 ), ( 0, 38.4979, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1444.13, -534.904, 956.81 ), ( 0, 38.4979, 26.2994 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1431.03, -524.403, 956.814 ), ( 0, 38.4979, 26.2994 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1432.14, -549.74, 1021.44 ), ( 0, 38.4979, 26.2994 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1419.04, -539.239, 1021.43 ), ( 0, 38.4979, 26.2994 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -1444.13, -534.904, 956.81 ), ( 0, 38.4979, 26.2994 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_64_64", ( -1431.03, -524.403, 956.814 ), ( 0, 38.4979, 26.2994 ) );
    spawngift( "trq_holiday_gift_boxes_01_snow_red", ( -1452, -512, 834 ), ( 0, 37.9999, 0 ) );
    spawngift( "trq_holiday_gift_boxes_01_snow", ( -1449, -515, 870 ), ( 360, 37.9998, -3.80005 ) );
    spawngift( "trq_holiday_gift_boxes_01_snow_red", ( -1449, -515, 905 ), ( 360, 37.9998, -3.80005 ) );

    if ( level.nextgen )
    {
        spawngift( "trq_holiday_gift_boxes_sm_02_red_snow", ( -1449.43, -526.952, 942.026 ), ( 0, 37, 0 ) );
        spawngift( "trq_holiday_gift_boxes_sm_02_red_snow", ( -1449.4, -527, 956 ), ( 0, 37, 0 ) );
        spawngift( "trq_holiday_gift_boxes_sm_02_blue_snow", ( -1447.4, -507, 942 ), ( 0, 217.3, 0 ) );
    }
    else
    {
        spawngift( "trq_holiday_gift_boxes_sm_02", ( -1449.43, -526.952, 942.026 ), ( 0, 37, 0 ) );
        spawngift( "trq_holiday_gift_boxes_sm_02", ( -1449.4, -527, 956 ), ( 0, 37, 0 ) );
        spawngift( "trq_holiday_gift_boxes_sm_02", ( -1447.4, -507, 942 ), ( 0, 217.3, 0 ) );
    }
}

spawngift( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", var_1 );
    var_3.angles = var_2;
    var_3 _meth_80B1( var_0 );
}

recondronepushplayersthroughwall()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1051, -1496, 724 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1051, -1591, 724 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -931, -1567, 746 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -931, -1520, 746 ), ( 0, 180, 0 ) );
}

playerweirdjitteravalanchearea()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -336, 742, 1014 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -336, 998, 1014 ), ( 90, 0, 0 ) );
}

nosightclipwall()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1082, -534, 932 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1210, -534, 932 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1338, -534, 932 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -1082, -534, 932 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -1210, -534, 932 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -1338, -534, 932 ), ( 0, 270, 0 ) );
}

vehicleclipdoors()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 963, 482, 986 ), ( 0, 299.2, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( -2078, 572, 960 ), ( 0, 351, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( -2118, 319, 960 ), ( 0, 351, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( 980, 498, 1044 ), ( 0, 300, 0 ) );
}

addpropforbadtreeclip()
{
    var_0 = spawn( "script_model", ( -594, 547, 1061 ) );
    var_0 _meth_80B1( "trq_holiday_gift_boxes_01_snow_red" );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_32_32_32", ( -594, 549, 1077 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -604, 533, 1064 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -585, 533, 1064 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -595, 533, 1064 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -594, 549, 1077 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_32_32_32", ( -594, 549, 1077 ), ( 0, 0, 0 ) );
}

playerclipoverhang()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1460, -658, 1312 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1460, -882, 1312 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1288, -520, 1308 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1092, -518, 1308 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1348, -518, 1308 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1468, -638, 1308 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1468, -894, 1308 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -560, 440, 1400 ), ( 0, 45, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -640, 440, 1400 ), ( 0, 135, 0 ) );
}

playerclipsnowguard()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 112, -901, 1316 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 132, -820, 1348 ), ( 0, 315.3, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 132, -820, 1284 ), ( 0, 315.3, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 181, -799, 1348 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 181, -799, 1284 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1056, -520, 1388 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1056, -520, 1644 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1312, -520, 1388 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1312, -520, 1644 ), ( 0, 270, 0 ) );
}

setcgragdolldvar( var_0 )
{
    level waittill( "game_ended" );
    setdvar( "r_ragdollStartHeight", var_0 );
}
