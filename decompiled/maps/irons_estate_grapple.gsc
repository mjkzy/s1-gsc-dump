// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

grapple_start()
{
    level.start_point_scripted = "grapple";
    level.start_point_grapple = 1;
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    level.player maps\_grapple::grapple_take();
    level.player maps\_tagging::tagging_set_enabled( 0 );
    thread maps\irons_estate_code::player_kill_trigger( "waterfall_bottom_kill_trigger" );
    soundscripts\_snd::snd_message( "start_grapple" );
    thread maps\irons_estate_intro::intro_cave_rumble();
    waitframe();
}

grapple_main()
{
    level.start_point_scripted = "grapple";
    common_scripts\utility::flag_set( "grapple_begin" );
    thread grapple_begin();
    common_scripts\utility::flag_wait( "spawn_infil_enemies" );
    common_scripts\utility::flag_set( "ie_west_poolhouse_trees" );
    thread maps\irons_estate_infil::poolhouse_enemies();
    thread maps\irons_estate_code::tennis_court_floor( 1 );
    common_scripts\utility::flag_wait( "grapple_end" );
    var_0 = getent( "waterfall_top_trigger", "targetname" );
    var_0 thread maps\irons_estate_code::waterfall_save( "recon_end" );
}

grapple_begin()
{
    common_scripts\utility::flag_init( "GRAPPLE" );
    common_scripts\utility::flag_init( "HINT_GRAPPLE_STOP" );
    thread handle_grapple();
    level.allies[0] thread grapple_allies();
    level.allies[1] thread grapple_allies();
    level.allies[2] thread grapple_allies();
    thread grapple_vo();
}

handle_grapple()
{
    objective_add( maps\_utility::obj( "grapple_waterfall" ), "current", &"IRONS_ESTATE_OBJ_GRAPPLE_WATERFALL" );
    objective_onentity( maps\_utility::obj( "grapple_waterfall" ), level.allies[0] );
    wait 1;
    thread watch_player_grapple();
    thread player_grapple_hint();
    level.player.grapple["dist_max"] = 1500;
    level.player maps\_grapple::grapple_give();
    common_scripts\utility::flag_wait( "jump_grapple_top" );
    maps\_utility::objective_complete( maps\_utility::obj( "grapple_waterfall" ) );
    common_scripts\utility::flag_set( "grapple_end" );
}

watch_player_grapple()
{
    while ( level.player.grapple["grappling"] != 1 )
        wait 0.05;

    common_scripts\utility::flag_set( "GRAPPLE" );
}

player_grapple_hint()
{
    level endon( "GRAPPLE" );
    level.grapple_hint = undefined;

    for (;;)
    {
        if ( isdefined( level.player.grapple["quick_hint_text"] ) )
        {
            if ( !isdefined( level.grapple_hint ) )
            {
                common_scripts\utility::flag_clear( "HINT_GRAPPLE_STOP" );
                thread maps\_utility::display_hint( "HINT_GRAPPLE" );
                level.grapple_hint = 1;
            }
        }
        else
        {
            common_scripts\utility::flag_set( "HINT_GRAPPLE_STOP" );

            if ( isdefined( level.grapple_hint ) )
                level.grapple_hint = undefined;
        }

        waitframe();
    }
}

grapple_allies()
{
    var_0 = getnode( self.animname + "_pre_grapple_node", "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self setgoalnode( var_0 );
    thread grapple_allies_movement();
}

grapple_allies_movement()
{
    level endon( "jump_grapple_top" );

    if ( self.animname == "cormack" )
        wait 1.0;

    if ( self.animname == "ilana" )
        wait 1.0;

    var_0 = getnode( self.animname + "_grapple_1_node", "targetname" );
    maps\_utility::set_goal_radius( 32 );
    self setgoalnode( var_0 );
    var_0 = getnode( self.animname + "_platform_1_node", "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "allies_move_to_grapple_2" );

    if ( self.animname == "ilana" )
        wait 1;

    var_0 = getnode( self.animname + "_grapple_2_node", "targetname" );
    maps\_utility::set_goal_radius( 64 );
    self setgoalnode( var_0 );
    var_0 = getnode( self.animname + "_platform_2_node", "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "allies_move_to_grapple_3" );

    if ( self.animname == "ilana" )
        wait 1;

    if ( self.animname == "cormack" )
    {
        var_0 = getnode( self.animname + "_platform_2a_node", "targetname" );
        maps\_utility::set_goal_radius( 16 );
        self setgoalnode( var_0 );
        self waittill( "goal" );
        common_scripts\utility::flag_wait( "cormack_to_grapple_3" );
    }

    var_0 = getnode( self.animname + "_grapple_3_node", "targetname" );
    maps\_utility::set_goal_radius( 32 );
    self setgoalnode( var_0 );
    var_0 = getnode( self.animname + "_platform_3_node", "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "allies_move_to_grapple_4" );

    if ( self.animname == "ilana" )
        wait 1;

    var_0 = getnode( self.animname + "_grapple_4_node", "targetname" );
    maps\_utility::set_goal_radius( 64 );
    self setgoalnode( var_0 );
    var_0 = getnode( self.animname + "_platform_4_node", "targetname" );
    maps\_utility::set_goal_radius( 100 );
    self setgoalnode( var_0 );
    self waittill( "goal" );
    level.recon_anim_struct = common_scripts\utility::getstruct( "recon_anim_struct", "targetname" );
    level.recon_anim_struct maps\_anim::anim_first_frame_solo( self, "recon_enter" );
}

grapple_vo()
{
    thread grapple_nags();
    common_scripts\utility::flag_wait( "allies_move_to_grapple_3" );
    wait 0.5;
    maps\_utility::smart_radio_dialogue( "ie_crmk_keepmoving" );
}

grapple_nags()
{
    level endon( "GRAPPLE" );
    wait 8;
    maps\_utility::smart_radio_dialogue( "ie_crmk_timeistight" );
}
