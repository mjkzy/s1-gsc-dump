// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{
    precachemodel( "vehicle_mil_v32_razorback" );

    if ( level.currentgen )
        precachemodel( "vehicle_mil_cargo_truck_captured_cghi_ai" );
}

post_load()
{

}

start( var_0, var_1 )
{
    _func_0D3( "g_friendlyNameDist", 0 );
    level.player maps\captured_util::warp_to_start( var_0 );
    level.allies maps\captured_util::warp_allies( var_1, 1 );
    level._exit.final_player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level._exit.final_player_rig hide();
}

main_end_escape()
{
    if ( maps\captured_util::start_point_is_before( "end_escape" ) )
        maps\_playermech_code::playermech_end();

    if ( !isalive( level.allies[1] ) )
    {
        var_0 = getent( "ally_1", "targetname" );
        var_0.count = 1;
        var_1 = var_0 maps\_utility::spawn_ai( 1 );
        var_1 maps\captured_util::ignore_everything();
        var_1.animname = "ally_1";
        level.allies = common_scripts\utility::array_add( level.allies, var_1 );
    }

    common_scripts\utility::array_thread( level.allies, maps\_utility::gun_remove );
    var_2 = common_scripts\utility::getstructarray( "ee_rpg_start", "targetname" );
    var_3 = maps\_utility::spawn_anim_model( "exit_truck" );
    var_4 = level._exit.final_player_rig;
    var_5 = [ var_4, var_3, level.allies[0], level.allies[1] ];

    for ( var_6 = 0; var_6 < 7; var_6++ )
        var_5 = common_scripts\utility::array_add( var_5, maps\_utility::spawn_anim_model( "exit_helo_" + maps\_utility::string( var_6 ), level.player.origin ) );

    level.player freezecontrols( 1 );
    level.player _meth_8118( 1 );
    level.player _meth_8119( 0 );
    level.player _meth_811A( 0 );
    level.player _meth_8301( 0 );
    level.player _meth_8304( 0 );
    level.player _meth_8130( 0 );
    level.player _meth_831D();
    level.player _meth_8481();
    level notify( "truck_dof" );
    common_scripts\utility::array_thread( common_scripts\utility::getstructarray( "ee_rpg_end", "targetname" ), ::ee_rpg_fire, var_2 );
    thread maps\captured_fx::fx_end_amb_fx();
    level.player common_scripts\utility::delaycall( 1.15, ::_meth_80AD, "light_1s" );
    level.player common_scripts\utility::delaycall( 9.75, ::_meth_80AD, "light_1s" );
    level.player common_scripts\utility::delaycall( 10.2, ::_meth_80AD, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 11.0, ::_meth_80AD, "heavy_3s" );
    level.player common_scripts\utility::delaycall( 32.5, ::_meth_80AD, "light_2s" );
    level.player _meth_807D( var_4, "tag_player", 1, 0, 0, 0, 0, 1 );
    var_4 show();
    level._exit.node maps\_anim::anim_single( var_5, "end_escape" );
    common_scripts\utility::flag_set( "flag_end_escape_end" );
}

ee_rpg_fire( var_0 )
{
    var_1 = common_scripts\utility::getclosest( self.origin, var_0 );
    wait(self.script_wait);
    magicbullet( "iw5_mahemcaptured", var_1.origin, self.origin );
}

end_fade_to_black( var_0 )
{
    wait 0.5;
    var_1 = maps\_hud_util::create_client_overlay( "black", 0, level.player );
    var_1 fadeovertime( 2 );
    var_1.alpha = 1;
}

end_change_fov( var_0 )
{
    level.player _meth_8031( 50, 3 );
}
