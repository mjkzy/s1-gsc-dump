// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

recon_start()
{
    level.start_point_scripted = "recon";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    level.player maps\_tagging::tagging_set_enabled( 0 );
    thread maps\irons_estate_infil::poolhouse_enemies();
    thread maps\irons_estate_code::tennis_court_floor( 1 );
    level.recon_anim_struct = common_scripts\utility::getstruct( "recon_anim_struct", "targetname" );
    thread maps\irons_estate_code::player_kill_trigger( "waterfall_bottom_kill_trigger" );
    soundscripts\_snd::snd_message( "start_recon" );
    maps\_utility::stop_exploder( 7900 );
}

recon_main()
{
    level.start_point_scripted = "recon";
    level.stealth_fail_fast = 1;
    thread recon_begin();
    common_scripts\utility::flag_wait( "recon_end" );
    var_0 = getent( "waterfall_top_trigger", "targetname" );
    var_0 thread maps\irons_estate_code::waterfall_save( "player_in_estate" );
}

recon_begin()
{
    common_scripts\utility::flag_init( "enable_recon" );
    common_scripts\utility::flag_init( "player_started_recon" );
    common_scripts\utility::flag_init( "target_tracking_online" );
    waitframe();
    thread handle_recon();
    level.allies[0] thread recon_allies();
    level.allies[1] thread recon_allies();
    level.allies[2] thread recon_allies();
    thread recon_vo();
    soundscripts\_snd::snd_message( "aud_recon_foley" );
}

handle_recon()
{
    thread maps\irons_estate_code::player_kill_trigger( "waterfall_top_kill_trigger" );
    common_scripts\utility::flag_wait( "enable_recon" );
    common_scripts\utility::flag_wait( "target_tracking_online" );
    thread maps\_utility::hintdisplayhandler( "HINT_TAGGING" );
    level.enemy_tagged = undefined;
    var_0 = _func_0D6( "axis" );
    common_scripts\utility::array_thread( var_0, ::enemies_tagged );
    common_scripts\utility::flag_wait( "target_tracking_online" );
    level.player maps\_tagging::tagging_set_enabled( 1 );
    level.player maps\_tagging::tagging_set_marking_enabled( 1 );
    level.player.tagging["tagging_fade_max"] = 4100;
    level waittill( "enemy_tagged" );
    common_scripts\utility::flag_set( "ENTITY_TAGGED" );
}

enemies_tagged()
{
    level endon( "enemy_tagged" );

    while ( !isdefined( self.tagged ) )
        wait 0.05;

    level notify( "enemy_tagged" );
}

recon_allies()
{
    self.ignoreall = 1;

    if ( self.animname == "knox" )
    {
        level.knox_pda = spawn( "script_model", ( 0, 0, 0 ) );
        level.knox_pda _meth_80B1( "greece_drone_control_pad" );
        level.knox_pda _meth_804D( self, "tag_weapon_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }

    if ( !isdefined( level.recon_anim_struct ) )
        level.recon_anim_struct = common_scripts\utility::getstruct( "recon_anim_struct", "targetname" );

    if ( self.animname != "knox" )
    {
        var_0 = getnode( self.animname + "_infil_grapple_node_1", "targetname" );
        maps\_utility::set_goal_radius( 16 );
        self _meth_81A5( var_0 );
        level.recon_anim_struct maps\_anim::anim_single_solo( self, "recon_enter" );
        thread cormack_ilana_infil();
    }
    else
    {
        level.recon_anim_struct thread maps\_anim::anim_single_solo( self, "recon_enter" );
        wait 18.5;
        playfxontag( level._effect["ie_light_teal_recon_knox"], level.knox_pda, "tag_origin" );
        self waittillmatch( "single anim", "end" );
        common_scripts\utility::flag_set( "enable_recon" );
        level.recon_anim_struct thread maps\_anim::anim_loop_solo( self, "recon_idle", "stop_loop" );
        level waittill( "ar_optics_done" );
        level.recon_anim_struct notify( "stop_loop" );
        level.recon_anim_struct maps\_anim::anim_single_solo( self, "recon_exit" );
        level.recon_anim_struct thread maps\_anim::anim_loop_solo( self, "recon_exit_idle", "stop_loop" );
        self.is_looping = 1;
    }
}

cormack_ilana_infil()
{
    level.player endon( "overlook_balcony_land" );
    level endon( "player_in_estate" );
    thread cormack_ilana_cleanup();
    self.dontavoidplayer = 1;
    self.nododgemove = 1;

    if ( self.animname == "ilana" )
        wait 0.75;

    var_0 = getnode( self.animname + "_infil_grapple_node_1", "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self _meth_81A5( var_0 );
    self waittill( "goal" );
    var_0 = getnode( self.animname + "_infil_grapple_node_2", "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self _meth_81A5( var_0 );
    self waittill( "goal" );

    if ( self.animname == "ilana" )
        wait 0.5;

    var_0 = getnode( self.animname + "_infil_grapple_node_3", "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self _meth_81A5( var_0 );
    self waittill( "goal" );

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    self delete();
}

cormack_ilana_cleanup()
{
    level.player waittill( "overlook_balcony_land" );

    if ( isdefined( self ) )
    {
        if ( isdefined( self.magic_bullet_shield ) )
            maps\_utility::stop_magic_bullet_shield();

        self delete();
    }
}

recon_vo()
{
    level endon( "_stealth_spotted" );
    common_scripts\utility::flag_wait( "enable_recon" );
    level.allies[2] maps\_utility::smart_dialogue( "ie_nox_targettracking" );
    level.allies[2] maps\_utility::smart_dialogue( "ie_nox_tagetasset" );
    common_scripts\utility::flag_set( "target_tracking_online" );
    common_scripts\utility::flag_wait( "ENTITY_TAGGED" );
    wait 0.5;
    level.allies[2] maps\_utility::smart_dialogue( "ie_nox_opticscheckout" );
    level.allies[2] maps\_utility::smart_dialogue( "ie_nox_syncingar" );
    level notify( "ar_optics_done" );
    wait 1;
    level.allies[2] maps\_utility::smart_dialogue( "ie_nox_gettocenter" );
    wait 1;
    common_scripts\utility::flag_set( "recon_end" );
}
