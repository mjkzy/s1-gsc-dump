// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

cloudfastinit( var_0, var_1, var_2, var_3 )
{
    level.fastcloud_rumble_ent = level.player maps\_utility::get_rumble_ent();
    level._effect["fast_cloud_0"] = loadfx( "fx/misc/blank" );
    level._effect["fast_cloud_1"] = loadfx( "vfx/map/crash/wind_streaks_fast_1" );
    level._effect["fast_cloud_2"] = loadfx( "vfx/map/crash/wind_streaks_fast_2" );
    level._effect["fast_cloud_3"] = loadfx( "vfx/map/crash/wind_streaks_fast_3" );
    level._effect["fast_cloud_4"] = loadfx( "vfx/map/crash/wind_streaks_fast_4" );
    level._effect["fast_cloud_5"] = loadfx( "vfx/map/crash/wind_streaks_fast_5" );
    level._effect["fast_cloud_6"] = loadfx( "vfx/map/crash/wind_streaks_fast_6" );
    level._effect["fast_cloud_7"] = loadfx( "vfx/map/crash/wind_streaks_fast_7" );
    level._effect["fast_cloud_8"] = loadfx( "vfx/map/crash/wind_streaks_fast_8" );
    level._effect["fast_cloud_9"] = loadfx( "vfx/map/crash/wind_streaks_fast_9" );
    level._effect["fast_cloud_10"] = loadfx( "vfx/map/crash/wind_streaks_fast10" );
    level._effect["screen_splash_drops_0"] = loadfx( "fx/misc/blank" );
    level._effect["screen_splash_drops_1"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lght" );
    level._effect["screen_splash_drops_2"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lght" );
    level._effect["screen_splash_drops_3"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lght" );
    level._effect["screen_splash_drops_4"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lght" );
    level._effect["screen_splash_drops_5"] = loadfx( "vfx/map/crash/screen_splash_drops_fast" );
    level._effect["screen_splash_drops_6"] = loadfx( "vfx/map/crash/screen_splash_drops_fast" );
    level._effect["screen_splash_drops_7"] = loadfx( "vfx/map/crash/screen_splash_drops_fast" );
    level._effect["screen_splash_drops_8"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_hvy" );
    level._effect["screen_splash_drops_9"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_hvy" );
    level._effect["screen_splash_drops_10"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_hvy" );
    level._effect["lf_screen_splash_drops_0"] = loadfx( "fx/misc/blank" );
    level._effect["lf_screen_splash_drops_1"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs_lght" );
    level._effect["lf_screen_splash_drops_2"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs_lght" );
    level._effect["lf_screen_splash_drops_3"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs_lght" );
    level._effect["lf_screen_splash_drops_4"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs_lght" );
    level._effect["lf_screen_splash_drops_5"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs" );
    level._effect["lf_screen_splash_drops_6"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs" );
    level._effect["lf_screen_splash_drops_7"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs" );
    level._effect["lf_screen_splash_drops_8"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs" );
    level._effect["lf_screen_splash_drops_9"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs" );
    level._effect["lf_screen_splash_drops_10"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_lhs" );
    level._effect["rt_screen_splash_drops_0"] = loadfx( "fx/misc/blank" );
    level._effect["rt_screen_splash_drops_1"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs_lght" );
    level._effect["rt_screen_splash_drops_2"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs_lght" );
    level._effect["rt_screen_splash_drops_3"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs_lght" );
    level._effect["rt_screen_splash_drops_4"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs_lght" );
    level._effect["rt_screen_splash_drops_5"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs" );
    level._effect["rt_screen_splash_drops_6"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs" );
    level._effect["rt_screen_splash_drops_7"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs" );
    level._effect["rt_screen_splash_drops_8"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs" );
    level._effect["rt_screen_splash_drops_9"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs" );
    level._effect["rt_screen_splash_drops_10"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rhs" );
    level._effect["rear_screen_splash_drops"] = loadfx( "vfx/map/crash/screen_splash_drops_fast_rear" );

    if ( var_0 == "none" )
    {
        level.fastcloudlevel = 0;
        level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
        level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
        level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
        level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
        level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
        level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity( level.fastcloudrumble );
        cloudfastnone( 0.1 );
    }
    else if ( var_0 == "light" )
    {
        level.fastcloudlevel = 1;
        level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
        level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
        level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
        level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
        level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
        level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity( level.fastcloudrumble );
        cloudfastlight( 0.1 );
    }
    else if ( var_0 == "medium" )
    {
        level.fastcloudlevel = 5;
        level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
        level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
        level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
        level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
        level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
        level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity( level.fastcloudrumble );
        cloudfastmedium( 0.1 );
    }
    else
    {
        level.fastcloudlevel = 10;
        level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
        level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
        level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
        level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
        level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
        level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity( level.fastcloudrumble );
        cloudfastheavy( 0.1 );
    }

    if ( !isdefined( var_1 ) )
        level.wind_dir = ( 0, 0, 0 );
    else
        level.wind_dir = var_1;

    level.default_sun_light = getmapsunlight();
    thread cloudfastplayer( var_2 );

    if ( !isdefined( var_3 ) )
        thread cloudsunflicker();
}

cloudfastheavy( var_0 )
{
    level notify( "fast_cloud_change", "heavy", var_0 );
    level thread cloudfasteffectchange( 10, var_0 );
    wait(var_0);
}

cloudfastmedium( var_0 )
{
    level notify( "fast_cloud_change", "medium", var_0 );
    level thread cloudfasteffectchange( 8, var_0 );
    wait(var_0);
}

cloudfastlight( var_0 )
{
    level notify( "fast_cloud_change", "light", var_0 );
    level thread cloudfasteffectchange( 5, var_0 );
    wait(var_0);
}

cloudfastnone( var_0 )
{
    level notify( "fast_cloud_change", "none", var_0 );
    level thread cloudfasteffectchange( 0, var_0 );
    wait(var_0);
}

cloudfastplayer( var_0 )
{
    level endon( "stop_fast_clouds" );
    var_1 = getentarray( "player", "classname" )[0];

    if ( isdefined( var_0 ) && var_0 >= 0 )
        var_1 thread cloudpushplayer( var_0, 1 );

    for (;;)
    {
        var_2 = level.wind_dir;

        if ( level.fastcloudlevel > 5 )
            screenshake( level.player.origin, level.fastcloudlevel * 0.1 * 0.09, 0, 0, 0.3, 0, 0, 500, 15, 1, 1 );
        else
            screenshake( level.player.origin, level.fastcloudlevel * 0.1 * 0.15, 0, 0, 0.3, 0, 0, 500, 15, 1, 1 );

        playfx( level._effect["fast_clouds"], var_1.origin + ( 0, 0, 16 ), ( var_2[0], var_2[1] + 90, var_2[2] ) );
        var_3 = level.player.angles;

        if ( level.player islinked() )
            var_3 += ( 0, level.player getlinkedparent().angles[1], 0 );

        var_4 = anglestoforward( ( 0, var_2[1], 0 ) );
        var_5 = anglestoforward( var_3 );
        var_6 = vectordot( var_4, var_5 );
        var_7 = vectorcross( ( 0, 0, 1 ), var_4 );
        var_8 = vectordot( var_7, var_5 );

        if ( var_6 >= 0.87 )
            playfx( level._effect["screen_splash_drops"], var_1.origin );
        else if ( var_6 <= -0.87 )
            playfx( level._effect["rear_screen_splash_drops"], var_1.origin );
        else if ( var_8 >= 0.0 )
            playfx( level._effect["lf_screen_splash_drops"], var_1.origin );
        else
            playfx( level._effect["rt_screen_splash_drops"], var_1.origin );

        wait 0.3;
    }
}

cloudsunflicker()
{
    level endon( "stop_sun_flicker" );

    for (;;)
    {
        setsunlight( level.default_sun_light[0] + level.fastcloudlevel * -0.055, level.default_sun_light[1] + level.fastcloudlevel * -0.04, level.default_sun_light[2] + level.fastcloudlevel * -0.02 );
        wait 0.3;
    }
}

cloudsunreset()
{
    level notify( "stop_sun_flicker" );
    wait 0.3;
    resetsunlight();
}

cloudfasteffectchange( var_0, var_1 )
{
    level notify( "fast_cloud_level_change" );
    level endon( "fast_cloud_level_change" );

    if ( !isdefined( var_1 ) || var_1 == 0 )
    {

    }

    if ( level.fastcloudlevel > var_0 )
    {
        var_2 = level.fastcloudlevel - var_0;
        var_1 /= var_2;

        for ( var_3 = 0; var_3 < var_2; var_3++ )
        {
            wait(var_1);
            level.fastcloudlevel--;
            level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
            level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
            level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
            level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];

            if ( level.fastcloudlevel > 4 )
            {
                level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
                level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to( level.fastcloudrumble, var_1 );
                continue;
            }

            level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to( 0, var_1 );
        }
    }

    if ( level.fastcloudlevel < var_0 )
    {
        var_2 = var_0 - level.fastcloudlevel;
        var_1 /= var_2;

        for ( var_3 = 0; var_3 < var_2; var_3++ )
        {
            wait(var_1);
            level.fastcloudlevel++;
            level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
            level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
            level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
            level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];

            if ( level.fastcloudlevel > 4 )
            {
                level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
                level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to( level.fastcloudrumble, var_1 );
                continue;
            }

            level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to( 0, var_1 );
        }
    }
}

cloudpushplayer( var_0, var_1 )
{
    level endon( "stop_fast_clouds" );
    var_2 = level.wind_dir;
    var_3 = anglestoforward( ( 0, 180 - var_2[1], 0 ) );
    var_4 = ( 0, 0, 0 );

    for (;;)
    {
        if ( level.fastcloudlevel >= var_0 )
            var_4 = vectorlerp( var_4, var_3 * ( level.fastcloudlevel - var_0 + 1 ) * 100.0 * 0.05, 0.5 );
        else
            var_4 = vectorlerp( var_4, ( 0, 0, 0 ), 0.25 );

        if ( !isdefined( var_1 ) || !var_1 || !self attackbuttonpressed() )
            self pushplayervector( var_4, 1 );
        else
            self pushplayervector( ( 0, 0, 0 ), 1 );

        wait 0.05;
    }
}
