// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

hud_precache()
{
    precacheshader( "sentinel_drone_overlay" );
    precacheshader( "sentinel_drone_scanlines" );
    precacheshader( "sentinel_drone_target" );
    precacheshader( "sentinel_drone_cam_name_1" );
    precacheshader( "sentinel_drone_cam_name_2" );
    precacheshader( "sentinel_drone_reticle" );
    precacheshader( "cinematic_screen" );
    precacheshader( "white" );
    level._effect["drone_cam_distortion"] = loadfx( "vfx/code/drone_cam_distortion" );
    common_scripts\utility::flag_init( "drone_cam_on" );
}

hud_start( var_0, var_1, var_2 )
{
    setsaveddvar( "compass", "0" );
    setsaveddvar( "g_friendlynamedist", 0 );
    setsaveddvar( "ammoCounterHide", "1" );
    setsaveddvar( "hud_showStance", "0" );
    hud_init( var_0, var_1, var_2 );
}

hud_end()
{
    setsaveddvar( "compass", "1" );
    setsaveddvar( "g_friendlynamedist", 15000 );
    setsaveddvar( "ammoCounterHide", "0" );
    setsaveddvar( "hud_showStance", "1" );
}

hud_init( var_0, var_1, var_2 )
{
    level.dronehud = [];
    level.dronetarget = [];
    create_hud_drone_overlay( var_0, var_1, var_2 );
    wait 0.5;
    common_scripts\utility::flag_set( "drone_cam_on" );
    thread drone_cam_timer();
    thread attachdistortionfx( var_0 );
}

destroy_sentinel_drone_hud()
{
    foreach ( var_1 in level.dronehud )
    {
        if ( isdefined( var_1 ) )
            var_1 destroy();
    }

    level.dronehudfx delete();
    common_scripts\utility::flag_clear( "drone_cam_on" );
}

create_hud_drone_overlay( var_0, var_1, var_2 )
{
    var_3 = ( 1, 1, 1 );
    var_4 = 1;

    if ( var_2 == 1 )
    {
        var_5 = newhudelem();
        var_5 setshader( "sentinel_drone_cam_name_1", 256, 32 );
        var_5.horzalign = "left";
        var_5.vertalign = "top";
        var_5.alpha = var_4;
        var_5.color = ( 1, 1, 1 );
        var_5.x = -56;
        var_5.y = -32;
        var_5.sort = -4;
        level.dronehud["camName"] = var_5;
    }
    else if ( var_2 == 2 )
    {
        var_5 = newhudelem();
        var_5 setshader( "sentinel_drone_cam_name_2", 256, 32 );
        var_5.horzalign = "left";
        var_5.vertalign = "top";
        var_5.alpha = var_4;
        var_5.color = ( 1, 1, 1 );
        var_5.x = -56;
        var_5.y = -32;
        var_5.sort = -4;
        level.dronehud["camName"] = var_5;
    }

    var_6 = newhudelem();
    var_6 setshader( "sentinel_drone_scanlines", 640, 480 );
    var_6.horzalign = "fullscreen";
    var_6.vertalign = "fullscreen";
    var_6.alpha = 0.1;
    var_6.color = ( 1, 1, 1 );
    var_6.sort = 2;
    level.dronehud["scanlines"] = var_6;
    var_7 = newhudelem();
    var_7 setshader( "sentinel_drone_text_scroll", 128, 256 );
    var_7.horzalign = "left";
    var_7.vertalign = "top";
    var_7.alpha = var_4;
    var_7.color = ( 1, 1, 1 );
    var_7.x = 0;
    var_7.y = 32;
    var_7.sort = -4;
    level.dronehud["text_scroll"] = var_7;
    var_8 = newhudelem();
    var_8 setshader( "sentinel_drone_text_scroll", 128, 256 );
    var_8.horzalign = "left";
    var_8.vertalign = "bottom";
    var_8.alpha = var_4;
    var_8.color = ( 1, 1, 1 );
    var_8.x = 0;
    var_8.y = -64;
    var_8.sort = -4;
    level.dronehud["text_scroll2"] = var_8;
    level.dronehud["timer"] = newhudelem();
    level.dronehud["timer"].x = -64;
    level.dronehud["timer"].y = -64;
    level.dronehud["timer"].color = var_3;
    level.dronehud["timer"].horzalign = "center";
    level.dronehud["timer"].vertalign = "bottom";
    level.dronehud["timer"].fontscale = 2.25;
    level.dronehud["timer"] settext( "00:00:00" );
    level.dronehud["timer"].alpha = 1;
    level.dronehud["timer"].font = "default";
    level.dronehud["timer"].glowcolor = ( 1, 1, 1 );
    level.dronehud["timer"].glowalpha = 1;
    var_9 = newhudelem();
    var_9 setshader( "sentinel_drone_reticle", 512, 512 );
    var_9.horzalign = "center";
    var_9.vertalign = "middle";
    var_9.alpha = var_4;
    var_9.x = -256;
    var_9.y = -256;
    var_9.sort = 2;
    level.dronehud["reticule"] = var_9;
    var_10 = -128;
    var_11 = 0;
    var_12 = newhudelem();
    var_12 setshader( "sentinel_drone_pip", 128, 256 );
    var_12.horzalign = "right";
    var_12.vertalign = "top";
    var_12.alpha = 0.5;
    var_12.x = var_10;
    var_12.y = var_11;
    var_12.sort = 1;
    level.dronehud["pip_movie_bg"] = var_12;
    var_13 = newhudelem();
    var_13 setshader( "cinematic_screen", 128, 256 );
    var_13.horzalign = "right";
    var_13.vertalign = "top";
    var_13.alpha = var_4;
    var_13.x = var_10;
    var_13.y = var_11;
    var_13.sort = 2;
    level.dronehud["pip_movie"] = var_13;
    var_14 = newhudelem();
    var_14 setshader( "sentinel_drone_pip_overlay", 128, 256 );
    var_14.horzalign = "right";
    var_14.vertalign = "top";
    var_14.alpha = var_4;
    var_14.x = var_10;
    var_14.y = var_11;
    var_14.sort = 2;
    level.dronehud["pip_overlay"] = var_14;
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloopresident( "sentinel_drone_pip_black_bg" );
}

create_hud_drone_target( var_0 )
{
    self endon( "death" );
    var_1 = ( 0.25, 0.25, 0.25 );
    var_2 = newhudelem();
    var_2 setshader( "sentinel_drone_target", 64, 64 );
    var_2.color = var_1;
    var_2.alpha = 1;
    var_2.sort = 2;
    var_2 setwaypoint( 0, 0 );
    var_2 settargetent( self );
    level.dronetarget[level.dronetarget.size + 1] = var_2;
    return;
}

remove_hud_drone_target()
{
    foreach ( var_1 in level.dronetarget )
    {
        if ( isdefined( var_1 ) )
        {
            var_1 fadeovertime( 0.25 );
            var_1.alpha = 0;
        }
    }

    wait 0.25;

    foreach ( var_1 in level.dronetarget )
    {
        if ( isdefined( var_1 ) )
            var_1 destroy();
    }

    level notify( "remove_hud_drone_target" );
}

drone_cam_timer()
{
    level.drone_cam_timer = [];
    level.drone_cam_timer["seconds"] = 0;
    level.drone_cam_timer["minutes"] = 0;
    level.drone_cam_timer["hours"] = 0;

    while ( common_scripts\utility::flag( "drone_cam_on" ) )
    {
        level.drone_cam_timer["seconds"]++;

        if ( level.drone_cam_timer["seconds"] == 60 )
        {
            level.drone_cam_timer["seconds"] = 0;
            level.drone_cam_timer["minutes"]++;
        }

        if ( level.drone_cam_timer["minutes"] == 60 )
        {
            level.drone_cam_timer["minutes"] = 0;
            level.drone_cam_timer["hours"]++;
        }

        var_0 = maps\_utility::string( level.drone_cam_timer["hours"] );

        if ( var_0.size == 1 )
            var_0 = "0" + var_0;

        var_1 = maps\_utility::string( level.drone_cam_timer["minutes"] );

        if ( var_1.size == 1 )
            var_1 = "0" + var_1;

        var_2 = maps\_utility::string( level.drone_cam_timer["seconds"] );

        if ( var_2.size == 1 )
            var_2 = "0" + var_2;

        var_3 = var_0 + ":" + var_1 + ":" + var_2;
        level.dronehud["timer"] settext( var_3 );
        wait 1.0;
    }
}

attachdistortionfx( var_0 )
{
    level.dronehudfx = common_scripts\utility::spawn_tag_origin();
    level.dronehudfx.origin = var_0.origin;
    level.dronehudfx.angles = var_0.angles;
    level.dronehudfx linkto( var_0 );
    playfxontag( common_scripts\utility::getfx( "drone_cam_distortion" ), level.dronehudfx, "tag_origin" );
}
