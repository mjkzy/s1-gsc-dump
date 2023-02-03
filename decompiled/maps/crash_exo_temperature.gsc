// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_exo_temperature()
{
    precacheshader( "hud_exo_temp_bg" );
    precacheshader( "hud_exo_temp_warning" );
    precacheshader( "overlay_frozen_2" );
    precachestring( &"temperature_fade_out" );
    precachestring( &"temperature_fade_in" );
    precachestring( &"temperature_warning_blink" );
    precachestring( &"temperature_warning_hide" );
}

create_exo_temperature_hud( var_0 )
{
    setomnvar( "ui_temperaturegauge_hud", 1 );
    level.player setclientomnvar( "ui_temperaturegauge_external", var_0 );
    level.body_temp = 98.6;
    level.exo_temp = var_0 + 25.0;
    level.exo_temperature_hud = [];
    level.exo_temperature_hud["overlay"] = newhudelem();
    level.exo_temperature_hud["overlay"].x = 0;
    level.exo_temperature_hud["overlay"].y = 0;
    level.exo_temperature_hud["overlay"] setshader( "overlay_frozen_2", 640, 480 );
    level.exo_temperature_hud["overlay"].sort = 50;
    level.exo_temperature_hud["overlay"].lowresbackground = 1;
    level.exo_temperature_hud["overlay"].alignx = "left";
    level.exo_temperature_hud["overlay"].aligny = "top";
    level.exo_temperature_hud["overlay"].horzalign = "fullscreen";
    level.exo_temperature_hud["overlay"].vertalign = "fullscreen";
    level.exo_temperature_hud["overlay"].alpha = 0.0;

    foreach ( var_2 in level.exo_temperature_hud )
        var_2.hidewheninmenu = 1;

    thread monitor_temperature();
}

remove_exo_temperature_hud( var_0 )
{
    level notify( "remove_exo_temperature_hud" );

    if ( isdefined( var_0 ) && var_0 > 0.0 )
    {
        luinotifyevent( &"temperature_fade_out", 1, int( var_0 * 1000 ) );

        foreach ( var_2 in level.exo_temperature_hud )
        {
            var_2 fadeovertime( var_0 );
            var_2.alpha = 0.0;
        }

        wait(var_0);
    }

    foreach ( var_2 in level.exo_temperature_hud )
        var_2 destroy();

    level.exo_temperature_hud = undefined;
    setomnvar( "ui_temperaturegauge_hud", 0 );
}

monitor_temperature()
{
    level endon( "remove_exo_temperature_hud" );
    var_0 = 98.6;
    var_1 = 96.0;
    var_2 = 92.5;
    var_3 = 97.0;
    var_4 = 91.5;
    var_5 = 0;

    for (;;)
    {
        level.exo_temperature_hud["overlay"].alpha = 1.0 - clamp( ( level.body_temp - var_4 ) / ( var_3 - var_4 ), 0.0, 1.0 );

        if ( level.body_temp < var_1 && !var_5 )
        {
            luinotifyevent( &"temperature_warning_blink", 1, 500 );
            var_5 = 1;
        }
        else if ( level.body_temp > var_1 && var_5 )
        {
            luinotifyevent( &"temperature_warning_hide", 1, 100 );
            var_5 = 0;
        }

        wait 0.05;
    }
}

activate_heater()
{

}

deactivate_heater()
{

}

set_exo_temperature_over_time( var_0, var_1 )
{
    level notify( "set_exo_temperature" );
    level endon( "set_exo_temperature" );
    level endon( "remove_exo_temperature_hud" );
    var_2 = ( var_0 - level.exo_temp ) / var_1 * 0.05;

    while ( var_1 > 0 )
    {
        level.exo_temp += var_2;
        var_1 -= 0.05;
        wait 0.05;
    }

    level.exo_temp = var_0;
}

set_operator_temperature_over_time( var_0, var_1 )
{
    level notify( "set_operator_temperature" );
    level endon( "set_operator_temperature" );
    level endon( "remove_exo_temperature_hud" );
    var_2 = ( var_0 - level.body_temp ) / var_1 * 0.05;

    while ( var_1 > 0 )
    {
        level.body_temp += var_2;
        var_1 -= 0.05;
        wait 0.05;
    }

    level.body_temp = var_0;
}

set_external_temperature_over_time( var_0, var_1 )
{
    level notify( "set_external_temperature" );
    level endon( "set_external_temperature" );
    level endon( "remove_exo_temperature_hud" );
    var_2 = ( var_0 - level.player getclientomnvar( "ui_temperaturegauge_external" ) ) / var_1 * 0.05;

    while ( var_1 > 0 )
    {
        level.player setclientomnvar( "ui_temperaturegauge_external", level.player getclientomnvar( "ui_temperaturegauge_external" ) + var_2 );
        var_1 -= 0.05;
        wait 0.05;
    }

    level.player setclientomnvar( "ui_temperaturegauge_external", var_0 );
}
