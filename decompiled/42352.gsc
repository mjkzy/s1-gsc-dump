// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_shg_fx()
{
    level.createfxexploders = [];

    foreach ( var_1 in level.createfxent )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1.v["type"] != "exploder" )
            continue;

        if ( !isdefined( var_1.v["exploder"] ) )
            continue;

        var_2 = var_1.v["exploder"];

        if ( !isdefined( level.createfxexploders[var_2] ) )
            level.createfxexploders[var_2] = [];

        level.createfxexploders[var_2][level.createfxexploders[var_2].size] = var_1;
    }

    level.createfxbyfxid = [];

    foreach ( var_1 in level.createfxent )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( !isdefined( var_1.v["fxid"] ) )
            continue;

        var_5 = var_1.v["fxid"];

        if ( !isdefined( level.createfxbyfxid[var_5] ) )
            level.createfxbyfxid[var_5] = [];

        level.createfxbyfxid[var_5][level.createfxbyfxid[var_5].size] = var_1;
    }

    thread setup_wake_volumes();
    thread setup_flipbook_models();
    level.fx_zone_messages = 0;
}

getentsbyfxid( var_0 )
{
    var_0 = maps\_utility::string( var_0 );

    if ( isdefined( level.createfxbyfxid ) )
        return level.createfxbyfxid[var_0];

    var_1 = [];

    foreach ( var_3 in level.createfxent )
    {
        if ( !isdefined( var_3 ) )
            continue;

        if ( var_3.v["fxid"] == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

pauseexploders( var_0 )
{
    var_1 = common_scripts\_exploder::getexploders( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
            var_3 common_scripts\utility::pauseeffect();
    }
}

pausefxid( var_0 )
{
    var_1 = getentsbyfxid( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
            var_3 common_scripts\utility::pauseeffect();
    }
}

restartfxid( var_0, var_1 )
{
    var_2 = getentsbyfxid( var_0 );

    if ( isdefined( var_2 ) )
    {
        foreach ( var_4 in var_2 )
        {
            if ( isdefined( var_1 ) && var_4.v["type"] == var_1 )
                continue;

            var_4 maps\_utility::restarteffect();
        }
    }
}

matrix33( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.cols[0] = vectornormalize( var_0 );
    var_3.cols[1] = vectornormalize( var_1 );
    var_3.cols[2] = vectornormalize( var_2 );
}

vec3_mult_matrix33( var_0, var_1 )
{
    var_0 = vectornormalize( var_0 );
    var_2 = vectordot( var_0, var_1.cols[0] );
    var_3 = vectordot( var_0, var_1.cols[0] );
    var_4 = vectordot( var_0, var_1.cols[0] );
    return ( var_2, var_3, var_4 );
}

screenshakefade( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = var_1 * 10;
    var_5 = var_2 * 10;

    if ( var_5 > 0 )
        var_6 = var_0 / var_5;
    else
        var_6 = var_0;

    var_7 = var_3 * 10;
    var_8 = var_4 - var_7;

    if ( var_7 > 0 )
        var_9 = var_0 / var_7;
    else
        var_9 = var_0;

    var_10 = 0.1;
    var_0 = 0;

    for ( var_11 = 0; var_11 < var_4; var_11++ )
    {
        if ( var_11 <= var_5 )
            var_0 += var_6;

        if ( var_11 > var_8 )
            var_0 -= var_9;

        earthquake( var_0, var_10, level.player.origin, 500 );
        wait(var_10);
    }
}

fx_bombshakes( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( level.createfx_enabled )
        return 0;

    var_8 = common_scripts\utility::spawn_tag_origin();
    var_9 = 1200;
    var_8.origin = level.player getorigin();
    var_10 = bullettrace( level.player.origin + ( 0, 0, 12 ), level.player.origin + ( 0, 0, 1200 ), 0, undefined );
    var_11 = distance( var_8.origin, var_10["position"] );
    var_12 = 0.125;
    var_13 = 2;
    var_14 = 0.3;
    var_15 = 0.5;

    if ( isdefined( var_2 ) )
        var_12 = var_2;

    if ( isdefined( var_3 ) )
        var_13 = var_3;

    if ( isdefined( var_4 ) )
        var_14 = var_4;

    if ( isdefined( var_5 ) )
        var_15 = var_5;

    if ( isdefined( var_7 ) && var_7 == 1 )
        var_11 = 1;

    if ( var_11 < 300 )
    {
        if ( isdefined( var_1 ) )
            level.player _meth_80AD( var_1 );

        level thread screenshakefade( var_12, var_13, var_14, var_15 );

        if ( isdefined( var_6 ) && var_6 == 1 )
            level thread fx_bombshakes_physics_jitter( var_8.origin, var_13, var_12 );

        if ( isdefined( var_0 ) )
        {
            for ( var_16 = 0; var_16 < 6; var_16++ )
            {
                wait 0.1;
                var_17 = vectornormalize( anglestoforward( level.player getangles() ) + ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), 0.5 ) ) * 1000;
                var_18 = bullettrace( level.player.origin + ( 0, 0, 12 ), level.player.origin + ( 0, 0, 12 ) + var_17, 0, undefined );
                var_19 = distance( level.player.origin, var_18["position"] );
                var_20 = vectordot( ( 0, 0, -1 ), vectornormalize( var_10["normal"] ) );

                if ( var_19 < 450 && var_20 > 0.75 )
                    playfx( common_scripts\utility::getfx( var_0 ), var_18["position"] );
            }
        }
    }

    var_8 delete();
}

fx_bombshakes_physics_jitter( var_0, var_1, var_2 )
{
    var_3 = 0;

    while ( var_3 < var_1 )
    {
        physicsjitter( var_0, 1000, 250, 0, var_2 );
        var_3 += 0.1;
        wait 0.1;
    }
}

spawn_exp_tendril( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_0;
    var_3.angles = var_1;
    var_4 = playfxontag( common_scripts\utility::getfx( var_2 ), var_3, "tag_origin" );
    var_5 = 500 + randomfloat( 1500 );
    var_6 = 10 + randomint( 20 );
    var_7 = 200;
    var_8 = vectornormalize( anglestoforward( var_1 ) );
    var_9 = vectornormalize( common_scripts\utility::randomvector( 2 ) );
    var_3.origin += var_7 * ( var_9[0], var_9[1], 0 );
    var_10 = randomfloat( 75 );
    var_11 = min( 1.0, max( 0.0, var_10 / 90.0 ) );
    var_12 = vectornormalize( var_8 * ( 1 - var_11 ) + ( var_9[0], var_9[1], 0 ) * var_11 );
    var_13 = var_12 * var_5 * 0.05;
    var_14 = ( 0, 0, -3 );

    for ( var_15 = 0; var_15 < var_6; var_15++ )
    {
        var_3.origin += var_13;
        var_13 += var_14;
        waitframe();
    }

    stopfxontag( common_scripts\utility::getfx( var_2 ), var_3, "tag_origin" );
    var_3 delete();
}

spawn_tendril( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = common_scripts\utility::spawn_tag_origin();
    var_10.origin = var_0;
    var_10.angles = var_1;
    var_11 = playfxontag( common_scripts\utility::getfx( var_2 ), var_10, "tag_origin" );
    var_12 = var_3 + randomfloat( var_4 - var_3 );
    var_13 = var_5 + randomint( var_6 - var_5 );
    var_14 = var_7;
    var_15 = vectornormalize( anglestoforward( var_1 ) );
    var_16 = vectornormalize( common_scripts\utility::randomvector( 2 ) );
    var_10.origin += var_14 * ( var_16[0], var_16[1], 0 );
    var_17 = randomfloat( var_8 );
    var_18 = min( 1.0, max( 0.0, var_17 / 90.0 ) );
    var_19 = vectornormalize( var_15 * ( 1 - var_18 ) + ( var_16[0], var_16[1], 0 ) * var_18 );
    var_20 = var_19 * var_12 * 0.05;
    var_21 = ( 0, 0, var_9 * -1 ) * 0.05 * 0.05;

    for ( var_22 = 0; var_22 < var_13; var_22++ )
    {
        var_10.origin += var_20;
        var_20 += var_21;
        waitframe();
    }

    stopfxontag( common_scripts\utility::getfx( var_2 ), var_10, "tag_origin" );
    var_10 delete();
}

shg_exploder_tendrils( var_0, var_1 )
{
    waittillframeend;
    waittillframeend;
    waittillframeend;

    for (;;)
    {
        level waittill( "exploding_" + var_0 );
        var_2 = common_scripts\_exploder::getexploders( var_0 );

        if ( isdefined( var_2 ) )
        {
            foreach ( var_4 in var_2 )
            {
                for ( var_5 = 0; var_5 < 6; var_5++ )
                    thread spawn_exp_tendril( var_4.v["origin"], var_4.v["angles"], var_1 );
            }
        }
    }
}

shg_spawn_tendrils( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    waittillframeend;
    waittillframeend;
    waittillframeend;

    for (;;)
    {
        level waittill( "exploding_" + var_0 );
        var_10 = common_scripts\_exploder::getexploders( var_0 );

        if ( isdefined( var_10 ) )
        {
            foreach ( var_12 in var_10 )
            {
                if ( !isdefined( var_12.v["origin"] ) )
                    continue;

                for ( var_13 = 0; var_13 < int( var_2 ); var_13++ )
                    thread spawn_tendril( var_12.v["origin"], var_12.v["angles"], var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
            }
        }
    }
}

check_zkey_press()
{
    if ( level.player _meth_824C( "z" ) == 1 )
        return 1;
    else
        return 0;
}

convertoneshot()
{

}

vision_zone_watcherb( var_0, var_1, var_2, var_3 )
{
    waittillframeend;
    common_scripts\utility::flag_init( var_1 );
    var_4 = spawnstruct();

    if ( !isdefined( level.g_visionvols ) )
    {
        level.g_visionvols = [];
        level.g_visionexit = getdvar( "vision_set_current" );

        if ( level.g_visionexit == "" )
            level.g_visionexit = "default";

        level.g_visiondefault = level.g_visionexit;
        level.g_visionblend = 1.0;

        if ( !common_scripts\utility::flag_exist( "start_vision_watcher_manager" ) )
            common_scripts\utility::flag_init( "vision_watcher_changed" );

        level thread vision_zone_manager();
    }

    if ( var_3 == undefined )
        var_3 = level.g_visiondefault;

    var_4.v["vision_set"] = var_0;
    var_4.v["vision_set_exit"] = var_3;
    var_4.v["blendtime"] = var_2;
    var_4.v["active"] = 0;
    var_4.v["prime"] = 0;
    var_4.v["flag"] = var_1;
    level.g_visionvols[level.g_visionvols.size] = var_4;

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );

        if ( var_4.v["active"] == 0 )
        {
            for ( var_5 = 0; var_5 < level.g_visionvols.size; var_5++ )
                level.g_visionvols[var_5].v["prime"] = 0;

            var_4.v["prime"] = 1;
        }

        var_4.v["active"] = 1;
        level.g_visionblend = var_2;
        common_scripts\utility::flag_set( "vision_watcher_changed" );
        wait(var_2);
        common_scripts\utility::flag_waitopen( var_1 );
        var_4.v["prime"] = 0;
        var_4.v["active"] = 0;
        level.g_visionexit = var_4.v["vision_set_exit"];
        level.g_visionblend = var_2;
        common_scripts\utility::flag_set( "vision_watcher_changed" );
        wait(var_2);
    }
}

vision_zone_watcher( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_init( var_1 );
    var_3 = getdvar( "vision_set_current" );

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );
        visionsetnaked( var_0, var_2 );
        wait 1.0;
        common_scripts\utility::flag_waitopen( var_1 );
        visionsetnaked( var_3, var_2 );
        wait 1.0;
    }
}

vision_zone_manager()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "vision_watcher_changed" );
        var_0 = -1;
        var_1 = -1;
        var_2 = 0.0;

        for ( var_3 = 0; var_3 < level.g_visionvols.size; var_3++ )
        {
            if ( level.g_visionvols[var_3].v["prime"] == 1 )
            {
                var_4 = getdvar( "vision_set_current" );

                if ( var_4 != level.g_visionvols[var_3].v["vision_set"] )
                    maps\_utility::vision_set_fog_changes( level.g_visionvols[var_3].v["vision_set"], level.g_visionblend );

                var_0 = var_3;
            }

            if ( level.g_visionvols[var_3].v["active"] == 1 )
                var_1 = 1;
        }

        for ( var_3 = 0; var_3 < level.g_visionvols.size; var_3++ )
        {
            if ( level.g_visionvols[var_3].v["active"] == 1 && var_0 == -1 )
            {
                maps\_utility::vision_set_fog_changes( level.g_visionvols[var_3].v["vision_set"], level.g_visionvols[var_3].v["blendtime"] );
                level.g_visionvols[var_3].v["prime"] = 1;
                var_0 = var_3;
                var_3 = 100000;
                common_scripts\utility::flag_clear( "vision_watcher_changed" );
                wait(level.g_visionblend);
                continue;
            }
        }

        if ( var_1 != 1 )
            maps\_utility::vision_set_fog_changes( level.g_visionexit, level.g_visionblend );

        common_scripts\utility::flag_clear( "vision_watcher_changed" );
        wait(level.g_visionblend);
    }
}

fx_zone_watcher( var_0, var_1, var_2, var_3 )
{
    common_scripts\utility::flag_init( var_1 );
    common_scripts\utility::flag_init( "fx_zone_" + var_0 + "_active" );

    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_init( var_2 );

    if ( isdefined( var_3 ) )
    {
        if ( !common_scripts\utility::flag_exist( var_3 ) )
            common_scripts\utility::flag_init( var_3 );
    }

    waitframe();

    if ( isdefined( var_3 ) )
        thread fx_zone_watcher_either_off_killthread( var_0, var_3, var_1, var_2 );

    thread fx_zone_watcher_either( var_0, var_1, var_2 );
}

fx_zone_watcher_both( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_init( var_1 );
    common_scripts\utility::flag_init( "fx_zone_" + var_0 + "_active" );

    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_init( var_2 );

    waitframe();
    thread fx_zone_watcher_all( var_0, var_1, var_2 );
}

flag_waitopen_both( var_0, var_1 )
{
    while ( common_scripts\utility::flag( var_0 ) || common_scripts\utility::flag( var_1 ) )
        level common_scripts\utility::waittill_either( var_0, var_1 );
}

send_activate_zone_msg( var_0 )
{
    level notify( "fx_zone_" + var_0 + "_activating" );
    common_scripts\utility::flag_set( "fx_zone_" + var_0 + "_active" );
}

send_deactivate_zone_msg( var_0 )
{
    level notify( "fx_zone_" + var_0 + "_deactivating" );
    common_scripts\utility::flag_clear( "fx_zone_" + var_0 + "_active" );
}

fx_zone_watcher_either( var_0, var_1, var_2 )
{
    for (;;)
    {
        if ( !isdefined( var_2 ) )
            var_2 = var_1;

        common_scripts\utility::flag_wait_either( var_1, var_2 );
        send_activate_zone_msg( var_0 );
        common_scripts\_exploder::exploder( var_0 );
        flag_waitopen_both( var_1, var_2 );
        send_deactivate_zone_msg( var_0 );
        pauseexploders( var_0 );
        wait 2.0;
    }
}

fx_zone_watcher_either_off_killthread( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        if ( !isdefined( var_3 ) )
            var_3 = var_2;

        common_scripts\utility::flag_wait( var_1 );
        send_deactivate_zone_msg( var_0 );
        pauseexploders( var_0 );
        send_deactivate_zone_msg( var_0 );
        common_scripts\utility::flag_waitopen( var_1 );

        if ( common_scripts\utility::flag( var_2 ) || common_scripts\utility::flag( var_3 ) )
        {
            send_activate_zone_msg( var_0 );
            common_scripts\_exploder::exploder( var_0 );
        }
    }
}

fx_zone_watcher_all( var_0, var_1, var_2 )
{
    for (;;)
    {
        if ( !isdefined( var_2 ) )
            var_2 = var_1;

        common_scripts\utility::flag_wait_all( var_1, var_2 );
        send_activate_zone_msg( var_0 );
        common_scripts\_exploder::exploder( var_0 );
        flag_waitopen_both( var_1, var_2 );
        send_deactivate_zone_msg( var_0 );
        pauseexploders( var_0 );
        wait 2.0;
    }
}

fx_zone_watcher_waitopen( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        common_scripts\utility::flag_init( var_1 );

    common_scripts\utility::flag_init( "fx_zone_" + var_0 + "_active" );
    waitframe();

    for (;;)
    {
        wait 0.1;
        common_scripts\utility::flag_waitopen( var_1 );
        send_activate_zone_msg( var_0 );
        common_scripts\_exploder::exploder( var_0 );
        common_scripts\utility::flag_wait( var_1 );
        send_deactivate_zone_msg( var_0 );
        pauseexploders( var_0 );
        wait 2.0;
    }
}

pause_oneshot( var_0 )
{
    var_1 = getentsbyfxid( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
        {
            if ( var_3.v["type"] == "exploder" )
                continue;

            var_3 common_scripts\utility::pauseeffect();
        }
    }
}

kill_oneshot( var_0 )
{
    var_1 = getentsbyfxid( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
        {
            if ( var_3.v["type"] == "exploder" )
                continue;

            if ( isdefined( var_3.looper ) )
                setwinningteam( var_3.looper, 1 );

            waitframe();
        }

        foreach ( var_3 in var_1 )
        {
            if ( var_3.v["type"] == "exploder" )
                continue;

            var_3 common_scripts\utility::pauseeffect();
        }
    }
}

fx_zone_watcher_late( var_0, var_1 )
{
    common_scripts\utility::flag_init( "fx_zone_" + var_0 + "_active" );

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );
        send_activate_zone_msg( var_0 );
        common_scripts\_exploder::exploder( var_0 );
        common_scripts\utility::flag_waitopen( var_1 );
        send_deactivate_zone_msg( var_0 );
        var_2 = common_scripts\_exploder::getexploders( var_0 );

        if ( isdefined( var_2 ) )
        {
            foreach ( var_4 in var_2 )
                var_4 common_scripts\utility::pauseeffect();
        }

        wait 2.0;
    }
}

get_exploder_ent( var_0 )
{
    var_1 = undefined;
    var_2 = common_scripts\_exploder::getexploders( var_0 );

    if ( isdefined( var_2 ) )
    {
        foreach ( var_4 in var_2 )
            var_1 = var_4;
    }

    return var_1;
}

get_exploder_entarray( var_0 )
{
    var_1 = [];
    var_2 = common_scripts\_exploder::getexploders( var_0 );

    if ( isdefined( var_2 ) )
        var_1 = var_2;

    return var_1;
}

fx_spot_lens_flare_tag( var_0 )
{
    var_1 = level.player getangles();
    var_2 = vectornormalize( anglestoforward( var_1 ) );
}

fx_spot_lens_flare_dir( var_0, var_1, var_2 )
{
    if ( !common_scripts\utility::flag_exist( "fx_spot_flare_kill" ) )
        common_scripts\utility::flag_init( "fx_spot_flare_kill" );

    if ( !isdefined( var_1 ) )
        var_1 = ( -90, 0, 0 );

    if ( !isdefined( var_2 ) )
        var_2 = 10000;

    var_3 = common_scripts\utility::spawn_tag_origin();
    var_4 = level.player.origin;
    var_5 = level.player getangles();
    var_6 = vectornormalize( anglestoforward( var_1 * -1 ) );
    var_7 = var_6 * -1 * var_2 + var_4;
    var_3.origin = var_7;
    var_8 = vectornormalize( anglestoforward( var_5 ) );
    var_9 = min( 1, max( 0.001, vectordot( var_8, var_6 * -1 ) ) );
    var_9 /= var_9;
    var_10 = vectornormalize( var_8 * var_9 + var_6 * 2 );
    var_11 = vectornormalize( var_10 - var_6 ) * var_9;
    var_12 = vectortoangles( vectornormalize( var_10 + var_11 ) );
    var_3.angles = var_12;
    playfxontag( common_scripts\utility::getfx( var_0 ), var_3, "tag_origin" );

    while ( !common_scripts\utility::flag( "fx_spot_flare_kill" ) )
    {
        var_4 = level.player.origin;
        var_5 = level.player getangles();
        var_6 = vectornormalize( anglestoforward( var_1 ) );
        var_7 = var_6 * var_2 + var_4;
        var_3.origin = var_7;
        var_8 = vectornormalize( anglestoforward( var_5 ) );
        var_9 = min( 1.0, max( 0.001, vectordot( var_8, var_6 ) ) );
        var_9 = var_9 * var_9 * var_9 * var_9;
        var_9 = 1.0 - var_9;
        var_10 = vectornormalize( var_8 * var_9 + var_6 * 2 );
        var_11 = vectornormalize( var_10 - var_6 ) * var_9;
        var_12 = vectortoangles( vectornormalize( var_10 + var_11 * 2 ) );
        var_3.angles = var_12;
        waitframe();
    }

    stopfxontag( common_scripts\utility::getfx( var_0 ), var_3, "tag_origin" );
    var_3 delete();
}

get_exploder_pos( var_0, var_1, var_2 )
{

}

create_exploders_fromlist()
{
    return 0;
}

get_fx_chain( var_0, var_1, var_2 )
{
    var_3 = [];

    if ( !isdefined( var_1 ) )
        var_1 = "default";

    var_4 = spawnstruct();
    var_4.v["default"] = spawnstruct();
    var_4.v["default"].v["l_arm"] = [ "j_shoulder_le", "j_elbow_le", "j_wrist_le" ];
    var_4.v["default"].v["r_arm"] = [ "j_shoulder_ri", "j_elbow_ri", "j_wrist_ri" ];
    var_4.v["default"].v["l_leg"] = [ "j_hip_le", "j_knee_le", "j_ankle_le" ];
    var_4.v["default"].v["r_leg"] = [ "j_hip_ri", "j_knee_ri", "j_ankle_ri" ];
    var_4.v["default"].v["torso"] = [ "j_mainroot", "j_spine4", "j_neck" ];
    var_4.v["default"].v["head"] = [ "j_neck", "j_head" ];

    if ( isdefined( var_2 ) )
    {
        var_5 = "override";

        if ( isdefined( var_2.v["name"] ) )
            var_5 = var_2.v["name"];

        var_4.v[var_5] = var_2;
    }

    foreach ( var_7 in var_4.v[var_1].v[var_0] )
        var_3[var_3.size] = var_7;

    return var_3;
}

setup_fx_chain( var_0 )
{
    if ( !isdefined( var_0.v["ent"] ) )
        return 1;

    if ( isdefined( var_0.v["chain"] ) )
        var_0.v["bones"] = get_fx_chain( var_0.v["chain"], var_0.v["chainset_name"], var_0.v["chainset_override"] );
    else
        return 1;

    var_0.v["tags"] = [];
    var_0.v["tag_lens"] = [];

    for ( var_1 = 0; var_1 < var_0.v["bones"].size - 1; var_1++ )
    {
        var_2 = var_0.v["ent"] gettagorigin( var_0.v["bones"][var_1] );
        var_3 = var_0.v["ent"] gettagangles( var_0.v["bones"][var_1] );
        var_4 = var_0.v["ent"] gettagorigin( var_0.v["bones"][var_1 + 1] );

        if ( isdefined( var_2 ) && isdefined( var_4 ) )
        {
            var_5 = var_4 - var_2;
            var_6 = length( var_5 );
            var_7 = common_scripts\utility::spawn_tag_origin();
            var_7.origin = var_2;
            var_7.angles = vectortoangles( var_5 );
            var_7 _meth_804D( var_0.v["ent"], var_0.v["bones"][var_1] );
            var_0.v["tags"][var_0.v["tags"].size] = var_7;
            var_0.v["tag_lens"][var_0.v["tag_lens"].size] = var_6;
        }
    }
}

play_fx_on_chain( var_0 )
{
    level endon( var_0.v["kill_notify"] );

    for (;;)
    {
        for ( var_1 = 0; var_1 < var_0.v["tags"].size; var_1++ )
        {
            var_2 = var_0.v["tags"][var_1];
            var_3 = var_0.v["tag_lens"][var_1];
            var_4 = anglestoforward( var_2.angles );
            var_5 = var_2.origin + var_4 * var_3 * randomfloat( 1.0 );
            playfx( var_0.v["fx"], var_5, var_4, anglestoup( var_2.angles ) );
        }

        wait(var_0.v["looptime"]);
    }
}

play_fx_attached_to_chain( var_0 )
{
    level endon( var_0.v["kill_notify"] );
    var_1 = [];

    for ( var_2 = 0; var_2 < 15; var_2++ )
        var_1[var_2] = common_scripts\utility::spawn_tag_origin();

    var_3 = 0;

    for (;;)
    {
        for ( var_4 = 0; var_4 < var_0.v["tags"].size; var_4++ )
        {
            if ( var_3 == 15 )
                var_3 = 0;

            var_5 = var_0.v["tags"][var_4];
            var_6 = var_0.v["tag_lens"][var_4];
            var_7 = anglestoforward( var_5.angles );
            var_8 = var_1[var_3];
            var_8 _meth_804D( var_5, "tag_origin", var_7 * var_6 * randomfloat( 1.0 ), ( 0, 0, 0 ) );
            playfxontag( var_0.v["fx"], var_8, "tag_origin" );
            var_3++;
        }

        wait(var_0.v["looptime"]);
    }
}

kill_fx_on_chain( var_0 )
{
    level waittill( var_0.v["kill_notify"] );

    for ( var_1 = 0; var_1 < var_0.v["tags"].size; var_1++ )
        var_0.v["tags"][var_1] delete();

    var_0.v["tags"] = [];
}

kill_fx_attached_to_chain( var_0 )
{
    level waittill( var_0.v["kill_notify"] );

    for ( var_1 = 0; var_1 < var_0.v["tags"].size; var_1++ )
        var_0.v["tags"][var_1] delete();

    var_0.v["tags"] = [];
}

play_fx_on_actor( var_0 )
{
    var_1 = var_0.v["ent"];
    var_2 = var_0.v["fx"];
    var_3 = var_0.v["chain"];
    var_4 = var_0.v["looptime"];
    var_5 = var_0.v["chainset_name"];
    var_6 = var_0.v["chainset_override"];

    if ( !isdefined( var_1 ) )
        return undefined;

    if ( !isdefined( var_2 ) )
        return undefined;

    if ( !isdefined( var_3 ) )
        var_3 = "all";

    if ( !isdefined( var_4 ) )
        var_4 = 1.0;

    if ( !isdefined( var_5 ) )
        var_5 = "default";

    if ( !isdefined( var_6 ) )
        var_6 = undefined;

    var_7 = [];

    if ( var_3 == "all" )
    {
        var_7[var_7.size] = "head";
        var_7[var_7.size] = "r_arm";
        var_7[var_7.size] = "l_arm";
        var_7[var_7.size] = "r_leg";
        var_7[var_7.size] = "l_leg";
        var_7[var_7.size] = "torso";
    }
    else
        var_7[0] = var_3;

    var_8 = var_1.model + "kill_fx_onactor";
    var_9 = [];

    foreach ( var_11 in var_7 )
    {
        var_12 = spawnstruct();
        var_12.v["ent"] = var_1;
        var_12.v["chain"] = var_11;
        var_12.v["fx"] = var_2;
        var_12.v["looptime"] = var_4;
        var_12.v["kill_notify"] = var_8;
        var_12.v["chainset_name"] = var_5;
        var_12.v["chainset_override"] = var_6;
        setup_fx_chain( var_12 );
        thread play_fx_on_chain( var_12 );
        thread kill_fx_on_chain( var_12 );
        var_9[var_9.size] = var_12;
    }

    return var_8;
}

play_fx_attached_to_actor( var_0 )
{
    var_1 = var_0.v["ent"];
    var_2 = var_0.v["fx"];
    var_3 = var_0.v["chain"];
    var_4 = var_0.v["looptime"];
    var_5 = var_0.v["chainset_name"];
    var_6 = var_0.v["chainset_override"];

    if ( !isdefined( var_1 ) )
        return undefined;

    if ( !isdefined( var_2 ) )
        return undefined;

    if ( !isdefined( var_3 ) )
        var_3 = "all";

    if ( !isdefined( var_4 ) )
        var_4 = 1.0;

    if ( !isdefined( var_5 ) )
        var_5 = "default";

    if ( !isdefined( var_6 ) )
        var_6 = undefined;

    var_7 = [];

    if ( var_3 == "all" )
    {
        var_7[var_7.size] = "head";
        var_7[var_7.size] = "r_arm";
        var_7[var_7.size] = "l_arm";
        var_7[var_7.size] = "r_leg";
        var_7[var_7.size] = "l_leg";
        var_7[var_7.size] = "torso";
    }
    else
        var_7[0] = var_3;

    var_8 = var_1.model + "kill_fx_onactor";
    var_9 = [];

    foreach ( var_11 in var_7 )
    {
        var_12 = spawnstruct();
        var_12.v["ent"] = var_1;
        var_12.v["chain"] = var_11;
        var_12.v["fx"] = var_2;
        var_12.v["looptime"] = var_4;
        var_12.v["kill_notify"] = var_8;
        var_12.v["chainset_name"] = var_5;
        var_12.v["chainset_override"] = var_6;
        setup_fx_chain( var_12 );
        thread play_fx_attached_to_chain( var_12 );
        thread kill_fx_attached_to_chain( var_12 );
        var_9[var_9.size] = var_12;
    }

    return var_8;
}

setup_wake_volumes()
{
    var_0 = getentarray( "wake_volume", "targetname" );

    foreach ( var_2 in var_0 )
        maps\_trigger::trigger_wakevolume_think( var_2 );
}

setup_flipbook_models()
{
    var_0 = getentarray( "flipbook_model", "script_noteworthy" );
    common_scripts\utility::array_thread( var_0, ::flipbook_model );
    var_1 = getentarray( "model_flicker", "script_noteworthy" );
    common_scripts\utility::array_thread( var_1, ::model_flicker );
}

flipbook_model()
{
    var_0 = [];
    var_0[0] = self;
    var_1 = self;

    for (;;)
    {
        var_2 = getent( var_1.target, "targetname" );

        if ( var_2 == self )
            break;

        var_2 hide();

        if ( isdefined( var_2.script_location ) )
        {
            if ( var_2.script_location == "1" )
                var_2.origin = var_2.origin;
            else
                var_2.origin = self.origin;
        }
        else
            var_2.origin = self.origin;

        var_1 = var_2;
    }

    var_1 = self;

    for (;;)
    {
        if ( isdefined( var_1.script_delay ) )
        {
            if ( var_1.script_delay == 0 )
                wait(randomfloatrange( 0.05, 0.35 ));

            if ( var_1.script_delay == 66 )
                wait(randomfloatrange( 0.2, 2.5 ));
            else
                wait(var_1.script_delay);
        }
        else
            wait 1.0;

        var_2 = getent( var_1.target, "targetname" );
        var_1 hide();
        var_2 show();
        var_1 = var_2;
    }
}

model_flicker()
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        var_0 = randomfloatrange( 2, 4 );
        var_1 = randomintrange( 2, 4 );
        wait(var_0);

        for ( var_2 = 0; var_2 < var_1; var_2++ )
        {
            self hide();
            wait(randomfloatrange( 0.1, 0.3 ));
            self show();
            wait(randomfloatrange( 0.05, 0.06 ));
        }

        wait 0.05;
    }
}

vfx_sunflare( var_0 )
{
    thread fx_flare_to_sun_flare( var_0, 50000 );
}

fx_flare_to_sun_flare( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 50000;

    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = level.player.origin + get_sun_direction() * var_1;
    playfxontag( common_scripts\utility::getfx( var_0 ), var_2, "tag_origin" );
    var_3 = 0.1;

    for (;;)
    {
        var_2 _meth_82AE( level.player.origin + get_sun_direction() * var_1, var_3 );
        wait(var_3);
    }
}

set_sun_flare_position( var_0 )
{
    level.sun_flare_position = var_0;
    wait 0.3;
    setsunflareposition( var_0 );
}

get_sun_direction()
{
    if ( isdefined( level.sun_flare_position ) )
        return anglestoforward( level.sun_flare_position );
    else
        return getmapsundirection();
}

exploder_to_array( var_0 )
{

}

kill_fx_by_view_think( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1 * 20; var_2++ )
        wait 0.05;

    var_0 delete();
}

start_fx_by_view( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = var_1;
    var_10 = 1.0;
    var_11 = 0.35;
    var_12 = 60.0;
    var_13 = [];
    var_14 = undefined;

    if ( isdefined( var_2 ) )
        var_10 = var_2;

    if ( isdefined( var_3 ) )
        var_11 = clamp( var_3, 0, var_10 );

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    if ( var_5 == 1 )
        var_6 = undefined;

    for ( var_15 = 0; var_15 < var_1.size; var_15++ )
    {
        if ( var_5 == 1 )
        {
            var_13[var_13.size] = ( randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ) );
            continue;
        }

        var_13[var_13.size] = ( 270, 0, 0 );
    }

    if ( isdefined( var_6 ) )
        var_13 = var_6;

    if ( isdefined( var_4 ) )
        var_16 = var_4;

    if ( isdefined( var_7 ) )
        var_14 = var_7;

    if ( isdefined( var_4 ) )
        level endon( var_4 );

    for (;;)
    {
        var_17 = clamp( randomfloatrange( -1 * var_11, var_11 ) + var_10, 0, var_10 + var_11 );
        wait(var_17);
        var_18 = level.player getangles();
        var_19 = vectornormalize( anglestoforward( var_18 ) );
        var_20 = -1;
        var_21 = [];
        var_22 = [];

        for ( var_15 = 0; var_15 < var_9.size; var_15++ )
        {
            var_23 = vectornormalize( var_9[var_15] - level.player.origin );

            if ( vectordot( var_19, var_23 ) > 0.45 )
            {
                var_20 = 1;
                var_21[var_21.size] = var_9[var_15];
                var_22[var_22.size] = var_13[var_15];
            }
        }

        if ( var_20 > 0 )
        {
            var_24 = randomint( var_21.size );

            if ( isdefined( var_24 ) )
            {
                var_25 = var_21[var_24];
                var_26 = var_22[var_24];
                var_27 = anglestoforward( var_26 );
                var_28 = anglestoup( var_26 );
                var_29 = "pre_delay_sound_" + soundscripts\_snd::snd_new_guid();

                if ( isstring( var_8 ) )
                {
                    var_30 = var_8 + "_" + soundscripts\_snd::snd_new_guid();
                    soundscripts\_snd::snd_message( var_14, var_25, var_30 );
                    thread start_fx_by_view_failsafe( var_30, var_29 );
                    level waittill( var_30 );
                }
                else if ( isdefined( var_14 ) )
                    soundscripts\_snd::snd_message( var_14, var_25 );

                level notify( var_29 );
                playfx( common_scripts\utility::getfx( var_0 ), var_25, var_27, var_28 );
            }

            wait 0.05;
        }
    }
}

start_fx_by_view_failsafe( var_0, var_1 )
{
    level endon( var_1 );
    var_2 = 2.5;
    wait(var_2);
    level notify( var_0 );
}

setupledgefx( var_0 )
{
    level.fxreactionset = [];
    var_1 = common_scripts\utility::getstructarray( var_0, "script_noteworthy" );

    if ( var_1.size > 0 )
    {
        foreach ( var_3 in var_1 )
            thread setupvfxgroup( var_3 );
    }
}

setupvfxgroup( var_0 )
{
    var_1 = var_0;
    var_2 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_3 = var_0.script_drones_min;
    var_4 = var_0.script_drones_max;
    var_5 = vectornormalize( var_2.origin - var_1.origin );
    var_6 = vectortoangles( var_5 ) + ( -90, 0, 0 );
    var_7 = randomintrange( var_3, var_4 );
    var_8 = length( var_2.origin - var_1.origin );
    var_9 = [];

    for ( var_10 = 0; var_10 < var_7; var_10++ )
    {
        var_11 = var_1.origin + randomfloat( var_8 ) * var_5;
        var_12 = spawnfx( common_scripts\utility::getfx( var_0.script_fxid ), var_11, anglestoforward( var_6 ), anglestoup( var_6 ) );
        triggerfx( var_12 );
        var_13 = spawnstruct();
        var_13.ent = var_12;
        var_13.fxorigin = var_11;
        var_13.fxangle = var_6;
        var_9[var_9.size] = var_13;
        level.fx_react_group[var_0.targetname] = var_9;
    }
}

swapfx( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in level.fx_react_group[var_0] )
    {
        var_6 = randomfloat( var_3 );
        maps\_utility::delaythread( var_6, ::perelementswap, var_5, var_1, var_2 );
    }
}

perelementswap( var_0, var_1, var_2 )
{
    var_3 = var_0.fxangle + var_2;
    playfx( common_scripts\utility::getfx( var_1 ), var_0.fxorigin, anglestoforward( var_3 ), anglestoup( var_3 ) );
    var_0.ent delete();
}
