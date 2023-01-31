// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

briefing_start()
{
    level.start_point_scripted = "briefing";
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    level.player maps\_grapple::grapple_take();
    level.player maps\_tagging::tagging_set_enabled( 0 );
}

briefing_main()
{
    level.start_point_scripted = "briefing";
    thread briefing_begin();
    soundscripts\_snd::snd_message( "aud_briefing" );
    common_scripts\utility::flag_wait( "briefing_end" );
    maps\_utility::autosave_stealth();
}

briefing_begin()
{
    level.briefing_anim_struct = common_scripts\utility::getstruct( "briefing_anim_struct_new", "targetname" );
    thread handle_briefing();
    level.allies[0] thread briefing_allies();
    level.allies[1] thread briefing_allies();
    level.allies[2] thread briefing_allies();
    level.allies[0] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify( "player_can_move" );
    level.allies[1] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify( "player_can_move" );
    level.allies[2] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify( "player_can_move" );
    thread briefing_ambient_allies();
    thread brief_fx();
}

handle_briefing()
{
    thread briefing_player();
    thread introscreen();
    common_scripts\utility::flag_wait( "introscreen1_complete" );
    thread briefing_obj();
    level waittill( "player_can_move" );
    wait 1;
    thread maps\_utility::center_screen_text( &"IRONS_ESTATE_CENTER_SCREEN_TEXT1" );
    level.allies[0] waittillmatch( "single anim", "fade_start" );
    thread maps\_hud_util::fade_out( 2, "black" );
    wait 2.0;
    common_scripts\utility::flag_set( "teleport_to_base" );
    wait 3.0;
    common_scripts\utility::flag_set( "briefing_end" );
}

briefing_player()
{
    level.player freezecontrols( 1 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player _meth_8031( 50, 0.05 );
    level.player _meth_830E( "s1_unarmed" );
    level.player _meth_8316( "s1_unarmed" );
    level.player _meth_8321();
    level.player _meth_831D();
    level.player _meth_8130( 0 );
    level.player _meth_8304( 0 );
    level.player _meth_8300( 0 );
    level.player _meth_81E1( 0.5 );
    level.player _meth_817D( "stand" );
    level.player _meth_811A( 0 );
    level.player _meth_8119( 0 );
    level.player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.player_rig hide();
    level.briefing_anim_struct maps\_anim::anim_first_frame_solo( level.player_rig, "briefing_start" );
    level.player _meth_807D( level.player_rig, "tag_player", 0, 0, 0, 0, 0, 1 );
    common_scripts\utility::flag_wait( "introscreen1_complete" );
    thread look_control_on();
    thread lerp_fov_wait();
    level.briefing_anim_struct maps\_anim::anim_single_solo( level.player_rig, "briefing_start" );
    level.player_rig delete();
    level notify( "player_can_move" );
    level.player _meth_804F();
    level.player _meth_831E();
    level.player _meth_811A( 1 );
    level.player _meth_8119( 1 );
    level.player freezecontrols( 0 );
    common_scripts\utility::flag_wait( "teleport_to_base" );
    var_0 = common_scripts\utility::getstruct( "intro_start", "targetname" );
    level.player maps\_utility::teleport_player( var_0 );
    var_0 = common_scripts\utility::getstruct( "intro_start", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 _meth_80B1( "tag_origin" );
    var_1.angles = var_0.angles;
    level.player _meth_807C( var_1, "tag_origin", 0, 0, 0, 0, 0, 0 );
}

lerp_fov_wait()
{
    level.player_rig waittillmatch( "single anim", "fov_lerp_start" );
    level.player _meth_8031( 65, 3.0 );
}

look_control_on()
{
    wait 2.0;
    level.player _meth_80A2( 1.0, 1.0, 1.0, 5, 5, 3, 3 );
}

introscreen()
{
    thread maps\_shg_utility::play_chyron_video( "chyron_text_irons_estate", undefined, 2 );
    common_scripts\utility::flag_wait( "chyron_video_done" );
    common_scripts\utility::flag_set( "introscreen1_complete" );
}

briefing_obj()
{

}

briefing_allies()
{
    self.ignoreall = 1;
    maps\_utility::gun_remove();
    var_0 = undefined;
    level.briefing_anim_struct maps\_anim::anim_first_frame_solo( self, "briefing_start" );

    if ( self == level.allies[2] )
    {
        var_0 = spawn( "script_model", ( 0, 0, 0 ) );
        var_0 _meth_80B1( "greece_drone_control_pad" );
        playfxontag( level._effect["ie_light_teal_briefing_knox"], var_0, "tag_origin" );
        var_0 _meth_804D( self, "tag_weapon_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }

    common_scripts\utility::flag_wait( "introscreen1_complete" );
    level.briefing_anim_struct thread maps\_anim::anim_single_solo( self, "briefing_start" );
    common_scripts\utility::flag_wait( "teleport_to_base" );
    maps\_utility::anim_stopanimscripted();
    maps\_utility::gun_recall();

    if ( self == level.allies[2] )
    {
        killfxontag( level._effect["ie_light_teal_briefing_knox"], var_0, "tag_origin" );
        wait 0.05;
        var_0 delete();
    }

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    self delete();
}

briefing_ambient_allies()
{
    maps\_utility::array_spawn_function_targetname( "briefing_ally_spawner", ::briefing_ambient_ally_setup );
    var_0 = maps\_utility::array_spawn_targetname( "briefing_ally_spawner", 1 );
}

briefing_ambient_ally_setup()
{
    self.ignoreall = 1;
    self.animname = self.script_noteworthy;
    level.briefing_anim_struct maps\_anim::anim_first_frame_solo( self, "briefing_start_" + self.script_noteworthy );

    if ( self.animname == "worker1" || self.animname == "worker2" || self.animname == "worker3" )
        maps\_utility::gun_remove();

    common_scripts\utility::flag_wait( "introscreen1_complete" );
    level.briefing_anim_struct maps\_anim::anim_single_solo( self, "briefing_start_" + self.script_noteworthy );
    common_scripts\utility::flag_wait( "teleport_to_base" );
    self delete();
}

briefing_vignettes()
{
    var_0 = common_scripts\utility::getstructarray( "briefing_vignette", "targetname" );
    var_1 = getent( "briefing_spawner", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_1.count = 1;
        var_4 = var_1 maps\_utility::spawn_ai( 1 );
        var_4 thread briefing_vignette_anims( var_3 );
        thread briefing_vignette_cleanup( var_3, var_4 );
        waitframe();
    }

    var_6 = common_scripts\utility::getstructarray( "briefing_business_male_vignette", "targetname" );
    var_7 = getent( "briefing_business_male_spawner", "targetname" );

    foreach ( var_9 in var_6 )
    {
        var_7.count = 1;
        var_10 = var_7 maps\_utility::spawn_ai( 1 );
        var_10 thread briefing_vignette_anims( var_9 );
        thread briefing_vignette_cleanup( var_9, var_10 );
        waitframe();
    }

    var_12 = common_scripts\utility::getstructarray( "briefing_business_female_vignette", "targetname" );
    var_13 = getent( "briefing_business_female_spawner", "targetname" );

    foreach ( var_15 in var_12 )
    {
        var_13.count = 1;
        var_16 = var_13 maps\_utility::spawn_ai( 1 );
        var_16 thread briefing_vignette_anims( var_15 );
        thread briefing_vignette_cleanup( var_15, var_16 );
        waitframe();
    }
}

briefing_vignette_anims( var_0 )
{
    self.animname = "generic";

    if ( self.classname == "actor_ally_sentinel_bal27" )
        maps\_utility::gun_remove();

    wait(randomfloatrange( 0.05, 0.5 ));
    var_0 thread maps\_anim::anim_loop_solo( self, var_0.animation );
}

briefing_vignette_cleanup( var_0, var_1 )
{
    common_scripts\utility::flag_wait( "teleport_to_base" );
    var_0 notify( "stop_loop" );
    var_1 delete();
}

brief_fx()
{
    common_scripts\_exploder::exploder( 4300 );
    common_scripts\utility::flag_wait( "briefing_end" );
    maps\_utility::stop_exploder( 4300 );
}
