// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precacheshader( "nightvision_overlay_goggles" );
    precacheshader( "dpad_icon_nvg" );
}

monitor_vision_use()
{
    self endon( "death" );

    for (;;)
    {
        level.player waittill( "sonar_vision" );

        if ( is_sonar_vision_on() )
            level.player thread sonar_vision_off();
        else
            level.player thread sonar_vision_on();

        wait 1;
    }
}

sonar_vision_on()
{
    level.player endon( "death" );
    level.player endon( "sonar_vision_off" );
    level.player notify( "sonar_vision_on" );
    level.player.sonar_vision = 1;

    for (;;)
    {
        thread detection_highlight_hud_effect( level.player );
        thread detect_enemies();
        wait 6;
        level notify( "end_sonar_threads" );
    }
}

sonar_vision_off()
{
    level.player notify( "sonar_vision_off" );
    level.player.sonar_vision = undefined;
    level notify( "end_sonar_threads" );
}

is_sonar_vision_on()
{
    return isdefined( level.player.sonar_vision ) && level.player.sonar_vision;
}

detect_enemies()
{
    level endon( "end_sonar_threads" );
    level.player endon( "death" );
    level.player endon( "sonar_vision_off" );
    var_0 = _func_0D6( "axis" );

    foreach ( var_2 in var_0 )
    {
        if ( distance( var_2.origin, self.origin ) < 5000 )
            var_2 thread maps\_variable_grenade::handle_marking_guy( "sonar_vision", 5 );
    }
}

detection_highlight_hud_effect( var_0 )
{
    level endon( "end_sonar_threads" );
    level.player endon( "death" );
    level.player endon( "sonar_vision_off" );
    var_1 = newclienthudelem( var_0 );
    var_1.color = ( 0.025, 0.05, 1 );
    var_1.alpha = 0.01;
    var_2 = 5;
    var_1 _meth_83A4( var_2 );
    var_1 thread destroy_radar_hud_elem_early();
    wait(var_2);
    var_1 destroy();
}

detection_grenade_hud_effect( var_0 )
{
    level endon( "end_sonar_threads" );
    level.player endon( "death" );
    level.player endon( "sonar_vision_off" );
    var_1 = newclienthudelem( var_0 );
    var_1.x = var_0.origin[0];
    var_1.y = var_0.origin[1];
    var_1.z = var_0.origin[2];
    var_1.color = ( 0.025, 0.05, 1 );
    var_1.alpha = 0.1;
    var_2 = 2;
    var_3 = 5000;
    var_4 = 1500;
    var_1 _meth_83A3( int( var_3 + var_4 / 2 ), int( var_4 ), var_2 + 0.05 );
    var_1 thread destroy_radar_hud_elem_early();
    wait(var_2);
    var_1 destroy();
}

destroy_radar_hud_elem_early()
{
    level.player endon( "death" );
    self endon( "death" );
    level.player waittill( "sonar_vision_off" );
    self destroy();
}

create_nvg_overlay( var_0, var_1, var_2 )
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

wait_to_destroy_nvg_overlay()
{
    level.player endon( "death" );
    level.player waittill( "sonar_vision_off" );

    if ( isdefined( self ) )
        self destroy();
}
