// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precacheshader( "dpad_laser_designator" );
    precacheshader( "laser_designator_overlay_lr" );
    precacheshader( "nightvision_overlay_goggles" );
    common_scripts\utility::flag_init( "player_firing_mob_turret" );
    common_scripts\utility::flag_init( "laser_firing" );
}

is_player_using_laser()
{
    return isdefined( level.player.laser_on ) && level.player.laser_on;
}

vision_set_override()
{
    wait 0.25;
    visionsetnaked( "sanfran_b_arclight_explosion", 1.25 );
    wait 0.75;
    visionsetnaked( "sanfran_b_arclight_explosion_dark", 1 );
    wait 0.5;
    visionsetnaked( "sanfran_b_bridge", 1 );
}

test_lines( var_0 )
{
    for ( var_1 = 0; var_1 < var_0; var_1 += 0.05 )
        wait 0.05;
}

stop_fx_on_death( var_0 )
{
    self waittill( "death" );
}

draw_final_line( var_0 )
{
    var_1 = 0;

    while ( var_1 < var_0 )
    {
        var_1 += 0.05;
        wait 0.05;
    }
}

manage_laser_beams( var_0, var_1 )
{
    var_2 = 2048;
    var_3 = 5;
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = var_0.origin;
    var_4.angles = ( 0, 0, 0 );
    var_4 _meth_804D( var_0 );
    var_5 = 360 / var_3;
    var_6 = 0;

    for ( var_7 = []; var_6 < var_3; var_6++ )
    {
        var_8 = common_scripts\utility::spawn_tag_origin();
        var_8 _meth_804D( var_4 );
        var_9 = var_6 * var_5;
        var_4.angles = ( 0, var_9, 0 );
        var_8.origin = var_4.origin + vectornormalize( anglestoforward( var_4.angles ) ) * var_2;
        var_7[var_7.size] = var_8;
    }

    foreach ( var_11 in var_7 )
        var_11 thread move_child_beams( var_4, var_1 );

    wait(var_1);
    return var_4;
}

move_child_beams( var_0, var_1 )
{
    self endon( "stop_drawing_child_beam_fx" );
    var_2 = 0;

    while ( var_2 < var_1 )
    {
        var_3 = var_0.origin - self.origin;
        self.origin += var_3 * var_2 / var_1;
        var_2 += 0.05;
        wait 0.05;
    }
}

aim_hud_on()
{
    if ( !isdefined( level.aim_hud ) )
        level.aim_hud = [];

    level.aim_hud[0] = create_hud_static_overlay( "laser_designator_overlay_lr", 1, 1 );
    level.aim_hud[1] = create_hud_static_overlay( "nightvision_overlay_goggles", 0, 0.2 );
}

destroy_aim_hud()
{
    if ( !isdefined( level.aim_hud ) )
        return;

    foreach ( var_1 in level.aim_hud )
    {
        if ( isdefined( var_1 ) )
            var_1 destroy();
    }

    level.aim_hud = undefined;
}

create_hud_static_overlay( var_0, var_1, var_2 )
{
    var_3 = newhudelem();
    var_3.x = 0;
    var_3.y = 0;
    var_3.sort = var_1;
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "fullscreen";
    var_3.alpha = var_2;
    var_3 _meth_80CC( var_0, 640, 480 );
    return var_3;
}

manage_aim_cursor()
{
    level.player endon( "death" );
    level.player endon( "laser_off" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    level.player.laser_aim_pos = var_0;
    var_0 thread wait_to_kill_aim_cursor();

    for (;;)
    {
        var_1 = level.player _meth_80A8();
        var_2 = var_1 + anglestoforward( level.player getangles() ) * 50000;
        var_3 = bullettrace( var_1, var_2, 1, level.player, 1 );

        if ( isdefined( var_3["position"] ) )
        {
            var_4 = undefined;
            var_0.origin = var_3["position"];

            if ( isdefined( var_3["normal"] ) )
                var_4 = vectortoangles( var_3["normal"] );
            else
                var_4 = vectortoangles( ( 0, 0, 1 ) );

            var_0 _meth_82B5( var_4, 0.2 );
        }

        wait 0.05;
    }
}

wait_to_kill_aim_cursor()
{
    level.player endon( "death" );
    level.player waittill( "laser_off" );
    level.player.laser_aim_pos = undefined;
    self delete();
}

tag_progress_bar( var_0, var_1 )
{
    level endon( "missionfailed" );
    self endon( "drone_finished_exiting" );
    self endon( "tag_interrupted" );
    var_2 = maps\_hud_util::createclientfontstring( "default", 1.2 );
    var_2 maps\_hud_util::setpoint( "CENTER", undefined, 0, 75 );
    var_2 settext( var_1 );
    var_3 = maps\_hud_util::createclientprogressbar( self, 90, "white", "black", 100, 5 );
    var_2 thread tag_bar_end_early();
    var_3 thread tag_bar_end_early();
    var_3 update_reloading_progress_bar( var_0 );

    if ( isdefined( var_2 ) )
        var_2 destroyhudelem();

    if ( isdefined( var_3 ) )
        var_3 destroyhudelem();
}

update_reloading_progress_bar( var_0 )
{
    var_1 = 20 * var_0;
    var_2 = 0;

    while ( var_2 < var_1 && isdefined( self ) )
    {
        maps\_hud_util::updatebar( var_2 / var_1 );
        var_2++;
        wait 0.05;
    }
}

tag_bar_end_early()
{
    thread wait_for_mission_fail();
    thread wait_for_drone_finished();
    thread wait_for_interrupted();
    self waittill( "destroy_early_bar" );
    destroyhudelem();
}

wait_for_mission_fail()
{
    level.player endon( "laser_off" );
    level.player endon( "tag_interrupted" );
    level waittill( "missionfailed" );
    self notify( "destroy_early_bar" );
}

wait_for_drone_finished()
{
    level endon( "missionfailed" );
    level.player endon( "tag_interrupted" );
    level.player waittill( "laser_off" );
    self notify( "destroy_early_bar" );
}

wait_for_interrupted()
{
    level endon( "missionfailed" );
    level.player endon( "laser_off" );
    level.player waittill( "tag_interrupted" );
    self notify( "destroy_early_bar" );
}

destroyhudelem()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < self.children.size; var_1++ )
        var_0[var_1] = self.children[var_1];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] maps\_hud_util::setparent( maps\_hud_util::getparent() );

    if ( isdefined( self.elemtype ) && self.elemtype == "bar" )
        self.bar destroy();

    if ( isdefined( self ) )
        self destroy();
}
