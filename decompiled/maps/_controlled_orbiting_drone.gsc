// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precacheassets_and_initflags()
{
    precacheshader( "white_multiply" );
    precachestring( &"LAGOS_FLY_DRONE_CONTROL" );
    common_scripts\utility::flag_init( "FlagPlayerEndDroneControl" );
    common_scripts\utility::flag_init( "FlagPlayerEndDroneStatic" );
    common_scripts\utility::flag_init( "FlagSniperDroneAnimating" );
    common_scripts\utility::flag_init( "FlagSniperDroneLookAt" );
    common_scripts\utility::flag_init( "FlagForcePlayerADS" );
    common_scripts\utility::flag_init( "FlagHadesVehicleDriveStart" );
}

initializesniperdronedata()
{
    var_0 = spawnstruct();
    var_0.droneangularvelocity = 0;
    var_0.droneverticalvelocity = 0;
    var_0.calculatenewhoverdestination = 1;
    var_0.dronehoverdirection = ( 0, 0, -1 );
    var_0.hoverspeed = 0.5;
    var_0.lasthoveroffset = ( 0, 0, 0 );
    var_0.hoverbounceconeangle = 10;
    var_0.currentvelocity = ( 0, 0, 0 );
    var_0.targetangularacceleration = 0;
    var_0.stickhorizontalinputlength = 0;
    var_0.brakingcurrenttime = 0;
    var_0.bodyrollvelocity = ( 0, 0, 0 );
    var_0.framerollacceleration = ( 0, 0, 0 );
    var_0.barrelrollacceleration = ( 0, 0, 0 );
    var_0.frameviewmodeloffset = ( 0, 0, 0 );
    var_0.barrelviewmodeloffset = ( 0, 0, 0 );
    var_0.horizontaloffsetstrafe = 0;
    var_0.verticaloffsetstrafe = 0;
    var_0.horizontaloffsetlook = 0;
    var_0.verticaloffsetlook = 0;
    return var_0;
}

initdroneflyinturnrate()
{
    _func_0D3( "aim_turnrate_pitch", 30 );
    _func_0D3( "aim_turnrate_pitch_ads", 25 );
    _func_0D3( "aim_turnrate_yaw", 60 );
    _func_0D3( "aim_turnrate_yaw_ads", 40 );
    _func_0D3( "aim_accel_turnrate_lerp", 300 );
}

initdroneturnrate()
{
    _func_0D3( "aim_turnrate_pitch", 70 );
    _func_0D3( "aim_turnrate_pitch_ads", 55 );
    _func_0D3( "aim_turnrate_yaw", 125 );
    _func_0D3( "aim_turnrate_yaw_ads", 90 );
    _func_0D3( "aim_accel_turnrate_lerp", 600 );
}

savedefaultturnrate()
{
    self.aim_turnrate_pitch = getdvarint( "aim_turnrate_pitch" );
    self.aim_turnrate_pitch_ads = getdvarint( "aim_turnrate_pitch_ads" );
    self.aim_turnrate_yaw = getdvarint( "aim_turnrate_yaw" );
    self.aim_turnrate_yaw_ads = getdvarint( "aim_turnrate_yaw_ads" );
    self.aim_accel_turnrate_lerp = getdvarint( "aim_accel_turnrate_lerp" );
}

restoredefaultturnrate()
{
    _func_0D3( "aim_turnrate_pitch", self.aim_turnrate_pitch );
    _func_0D3( "aim_turnrate_pitch_ads", self.aim_turnrate_pitch_ads );
    _func_0D3( "aim_turnrate_yaw", self.aim_turnrate_yaw );
    _func_0D3( "aim_turnrate_yaw_ads", self.aim_turnrate_yaw_ads );
    _func_0D3( "aim_accel_turnrate_lerp", self.aim_accel_turnrate_lerp );
}

startdronecontrol( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level endon( "drone_control_complete" );
    maps\_shg_utility::hide_player_hud();
    var_6 = distance2d( var_0.origin, var_1.origin );
    var_7 = vectortoangles( var_1.origin - var_0.origin );
    level.player _meth_831D();
    level.player _meth_8321();
    level.player _meth_831F();
    level.player _meth_8119( 0 );
    var_8 = initializesniperdronedata();
    var_9 = common_scripts\utility::spawn_tag_origin();
    level.player.sniperdronelink = var_9;
    level.player.sniperdronedata = var_8;
    initorbitlowerbounds( var_0.origin, var_5 );
    var_10 = sniperdroneoverlays();
    childthread updateflyinscopeoverlay( var_10["scope"], var_1.origin[2] );
    level.player.sniperdronelink savedefaultturnrate();

    if ( var_3 )
    {
        var_9 initdroneflyinturnrate();
        common_scripts\utility::flag_wait( "drone_fly_anim_done" );
    }
    else
        level.player setangles( vectortoangles( var_2.origin - var_1.origin ) );

    initdroneturnrate();
    calculateinitialposition( var_1, var_0, var_7, var_6 );
    thread hintsniperdronemove();
    soundscripts\_snd::snd_message( "fly_drone_camera_start_2", var_9, level.player );
    var_11 = var_9.origin;
    var_12 = 0;
    var_13 = 0;
    level.fly_drone_rumbling = 0;
    var_14 = 1;

    while ( isdefined( level.player.sniperdronelink ) )
    {
        if ( common_scripts\utility::flag( "FlagPlayerEndDroneStatic" ) || common_scripts\utility::flag( "FlagSniperDroneAnimating" ) || common_scripts\utility::flag( "FlagSniperDroneLookAt" ) )
        {
            waitframe();
            continue;
        }

        var_8.droneangularvelocity = updatehorizontalvelocity();
        var_8.droneverticalvelocity = updateverticalvelocity();
        var_15 = angleclamp( var_12 + var_8.droneangularvelocity * 0.05 );
        var_16 = combineangles( ( 0, var_15, 0 ), var_7 );
        var_17 = var_13 + var_8.droneverticalvelocity * 0.05;
        var_17 = clamp( var_17, -15.0, 15 );
        var_18 = var_11;
        var_19 = var_0.origin + ( 0, 0, var_17 );
        var_11 = var_19 + anglestoforward( var_16 ) * var_6;
        var_20 = clamppositiontolowerbounds( var_11, var_0.origin );
        var_11 = ( var_11[0], var_11[1], var_11[2] + var_20 );
        var_17 += var_20;
        var_15 = clampyaworbitoffset( var_11, var_0.origin, var_7 );
        var_9.origin = var_11;
        var_8.currentvelocity = var_11 - var_18;

        if ( length( var_8.currentvelocity ) <= 0.6 )
            level notify( "fly_drone_not_moving" );
        else if ( level.fly_drone_rumbling == 0 )
            thread maps\lagos_utility::rumble_flydrone_control();

        var_21 = vectortoangles( var_19 - var_11 );
        var_21 *= ( 0, 1, 0 );
        var_9.angles = var_21;
        var_12 = var_15;
        var_13 = var_17;

        if ( var_14 )
        {
            var_22 = 0.75;
            level.player _meth_804F();
            var_23 = level.player getorigin();
            var_24 = level.player getangles();
            var_25 = 0;

            for ( var_26 = level.player common_scripts\utility::spawn_tag_origin(); var_25 <= var_22; var_25 += 0.05 )
            {
                var_27 = var_25 / var_22;
                var_26.origin = vectorlerp( var_23, var_9.origin, var_27 );
                var_26.angles = vectorlerp( var_24, var_9.angles, var_27 );
                level.player _meth_807D( var_26, "tag_origin", 1, 10, 10, 10, 30, 1 );
                waitframe();
            }

            level.player _meth_807D( var_9, "tag_origin", 1, 10, 10, 10, 30, 1 );
            var_14 = 0;
        }

        waitframe();
    }
}

sniperdroneoverlays()
{
    var_0 = [];
    var_0["scope"] = createoverlay( "white_multiply", 0.0 );
    return var_0;
}

initorbitlowerbounds( var_0, var_1 )
{
    level.player.sniperdronedata.orbitlowerbounds = maps\_sarray::sarray_spawn();

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( !isdefined( var_1[var_2] ) )
            continue;

        var_3 = vectortoangles( var_0 - var_1[var_2].origin );
        var_1[var_2].orbitangle = var_3[1];
        level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_push( var_1[var_2] );
    }

    maps\_sarray::sarray_sort_by_handler( level.player.sniperdronedata.orbitlowerbounds, maps\_sarray::sarray_create_func_obj( ::compareorbitangle ) );
}

calculateinitialposition( var_0, var_1, var_2, var_3 )
{
    level.player.sniperdronelink.angles = vectortoangles( var_1.origin - var_0.origin ) * ( 0, 1, 0 );
}

clamplookangle( var_0 )
{
    if ( var_0 > 180 )
        return var_0 - 360;

    if ( var_0 < -180 )
        return var_0 + 360;

    return var_0;
}

getlookpitch()
{
    var_0 = level.player getangles();
    return clamplookangle( var_0[0] );
}

getlookyaw()
{
    var_0 = level.player getangles();
    return clamplookangle( var_0[1] ) - clamplookangle( level.player.sniperdronelink.angles[1] );
}

clearmovementparameters()
{
    level.player.sniperdronedata.bodyrollvelocity = ( 0, 0, 0 );
    level.player.sniperdronedata.bodyrollvelocity = ( 0, 0, 0 );
    level.player.sniperdronedata.framerollacceleration = ( 0, 0, 0 );
    level.player.sniperdronedata.barrelrollacceleration = ( 0, 0, 0 );
    level.player.sniperdronedata.targetangularacceleration = 0;
    level.player.sniperdronedata.droneangularvelocity = 0;
    level.player.sniperdronedata.droneverticalvelocity = 0;
}

lerpplayerlook( var_0 )
{
    var_1 = level.player getangles();
    var_2 = 0;

    while ( var_2 <= 1 )
    {
        var_3 = euler_lerp( var_1, var_0, var_2 );
        level.player setangles( var_3 );
        var_2 += 0.1;
        wait 0.05;
    }
}

updateflyinscopeoverlay( var_0, var_1 )
{
    while ( isdefined( level.player.sniperdronelink ) )
    {
        var_2 = level.player.sniperdronelink.angles;
        wait 0.05;

        if ( !common_scripts\utility::flag( "FlagSniperDroneAnimating" ) && !common_scripts\utility::flag( "FlagSniperDroneLookAt" ) )
            continue;

        var_3 = level.player.sniperdronelink.origin[2] - var_1;
        var_4 = var_2[1] - level.player.sniperdronelink.angles[1];
        var_4 = clamp( var_4, -1, 1 );
        var_5 = level.player.sniperdronelink.angles[0];

        if ( common_scripts\utility::flag( "FlagSniperDroneLookAt" ) )
            var_5 = getlookpitch();
    }
}

hintsniperdronemove()
{
    wait 1;
    thread notifyonplayermovingsniperdrone();
    maps\_utility::hintdisplayhandler( "move_fly_drone", 5 );
}

move_fly_drone_check()
{
    level.player endon( "death" );

    if ( level.player _meth_82F3() != 0 )
        return 1;
    else
        return 0;
}

notifyonplayermovingsniperdrone()
{
    for (;;)
    {
        var_0 = level.player _meth_82F3();

        if ( length( var_0 ) != 0 )
        {
            level.player notify( "sniperdrone_moving" );
            break;
        }

        wait 0.05;
    }
}

enddronecontrol()
{
    level.player.sniperdronelink restoredefaultturnrate();
    wait 0.75;
    level notify( "drone_control_complete" );
    level.player.sniperdronelink = undefined;
    wait 0.25;
}

iscontrollingdrone()
{
    return isdefined( level.player.sniperdronelink );
}

createoverlay( var_0, var_1 )
{
    var_2 = newclienthudelem( level.player );
    var_2.x = 0;
    var_2.y = 0;
    var_2.alignx = "left";
    var_2.aligny = "top";
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2 _meth_80CC( var_0, 640, 480 );
    var_2.alpha = var_1;
    var_2.sort = -3;
    return var_2;
}

compareorbitangle( var_0, var_1 )
{
    return var_0.orbitangle < var_1.orbitangle;
}

settargetangularacceleration( var_0 )
{
    if ( abs( level.player.sniperdronedata.targetangularacceleration ) > abs( var_0 ) )
        return;

    level.player.sniperdronedata.targetangularacceleration = var_0;
}

updatetargetangularacceleration()
{
    if ( !isdefined( level.player.sniperdronedata ) )
        return;

    level.player.sniperdronedata.targetangularacceleration *= 0.95;
}

updatevelocity( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = clamp( abs( var_1 ), 0, 1 );
    var_10 = 0;

    if ( var_2 * var_1 < 0 )
    {
        if ( level.player adsbuttonpressed() || common_scripts\utility::flag( "FlagForcePlayerADS" ) )
            var_10 = var_8 * var_1;
        else
            var_10 = var_7 * var_1;
    }

    var_2 = var_2 + var_3 * var_1 + var_10;
    var_2 = clamp( var_2, -1.0 * var_4, var_4 );

    if ( isdefined( var_0 ) )
    {
        updatetargetangularacceleration();
        var_0.stickhorizontalinputlength = var_9;

        if ( var_9 > 0 )
        {
            var_0.targetangularacceleration = var_3 * var_1;
            var_0.brakingcurrenttime = 0;
        }
    }

    if ( var_9 == 0 )
    {
        var_11 = var_2;

        if ( level.player adsbuttonpressed() || common_scripts\utility::flag( "FlagForcePlayerADS" ) )
            var_2 *= var_6;
        else
            var_2 *= var_5;

        if ( isdefined( var_0 ) )
            settargetangularacceleration( ( var_11 - var_2 ) * -1 );
    }

    return var_2;
}

scalevelocity( var_0 )
{
    if ( level.player adsbuttonpressed() || common_scripts\utility::flag( "FlagForcePlayerADS" ) )
        var_0 *= 0.85;

    if ( level.player adsbuttonpressed() && level.player _meth_8471() )
        var_0 *= 0.85;

    return var_0;
}

updatehorizontalvelocity()
{
    var_0 = maps\lagos_utility::calculateleftstickdeadzone();
    var_1 = updatevelocity( level.player.sniperdronedata, var_0[1], level.player.sniperdronedata.droneangularvelocity, 1.25, 35, 0.9, 0.4, 10, 8 );
    return scalevelocity( var_1 );
}

updateverticalvelocity()
{
    var_0 = maps\lagos_utility::calculateleftstickdeadzone();
    var_1 = updatevelocity( undefined, var_0[0], level.player.sniperdronedata.droneverticalvelocity, 5, 10, 0.75, 0.4, 150, 125 );
    return scalevelocity( var_1 );
}

clamppositiontolowerbounds( var_0, var_1 )
{
    var_2 = vectortoangles( var_1 - var_0 );
    var_3 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_length() - 1;
    var_4 = 0;

    for ( var_4 = 0; var_4 < level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_length(); var_4++ )
    {
        if ( var_2[1] < level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get( var_4 ).orbitangle )
            break;

        var_3 = var_4;
    }

    var_4 %= level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_length();
    var_5 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get( var_3 ).orbitangle;
    var_6 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get( var_4 ).orbitangle;

    if ( var_5 > var_6 )
        var_5 -= 360;

    var_7 = abs( var_2[1] - var_5 ) / abs( var_6 - var_5 );
    var_8 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get( var_3 ).origin;
    var_9 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get( var_4 ).origin;
    var_10 = var_8[2] + ( var_9[2] - var_8[2] ) * var_7;

    if ( var_0[2] < var_10 )
        return var_10 - var_0[2];

    return 0;
}

clampyaworbitoffset( var_0, var_1, var_2 )
{
    var_3 = vectortoangles( ( var_0 - var_1 ) * ( 1, 1, 0 ) );
    var_3 -= var_2;
    return var_3[1];
}

calculatehoverlocation( var_0, var_1 )
{
    level endon( "drone_control_complete" );
    var_2 = var_0 + level.player.sniperdronedata.dronehoverdirection * 2;
    return vectornormalize( var_2 - level.player.sniperdronelink.origin ) * level.player.sniperdronedata.hoverspeed;
}

updatehoverspeed( var_0 )
{
    level endon( "drone_control_complete" );
    var_1 = var_0 + level.player.sniperdronedata.dronehoverdirection * 2;
    var_2 = 10;
    var_3 = length( var_1 - level.player.sniperdronelink.origin );

    if ( var_3 > var_2 )
    {
        level.player.sniperdronedata.hoverspeed += 0.5;
        level.player.sniperdronedata.hoverspeed = clamp( level.player.sniperdronedata.hoverspeed, -0.5, 0.5 );
        return;
    }

    var_4 = maps\_shg_utility::linear_map_clamp( var_3, 0, var_2, 0, 1 );
    level.player.sniperdronedata.hoverspeed = maps\_utility::linear_interpolate( var_4, 0.25, 0.5 );
}

updatehoveridle( var_0 )
{
    level endon( "drone_control_complete" );

    if ( level.player maps\_utility::isads() )
        level.player.sniperdronedata.calculatenewhoverdestination = 1;
    else if ( abs( level.player.sniperdronedata.droneangularvelocity ) > 0.05 || abs( level.player.sniperdronedata.droneverticalvelocity ) > 0.05 )
    {
        level.player.sniperdronedata.calculatenewhoverdestination = 1;
        level.player.sniperdronedata.hoverbounceconeangle = 5;
        level.player.sniperdronedata.dronehoverdirection = vectornormalize( level.player.sniperdronedata.currentvelocity ) * -1;
    }
    else if ( level.player.sniperdronedata.calculatenewhoverdestination )
    {
        level.player.sniperdronedata.calculatenewhoverdestination = 0;
        level.player.sniperdronedata.dronehoverdirection = common_scripts\utility::randomvectorincone( level.player.sniperdronedata.dronehoverdirection * -1, level.player.sniperdronedata.hoverbounceconeangle );
        level.player.sniperdronedata.dronehoverdirection = vectornormalize( level.player.sniperdronedata.dronehoverdirection );
        level.player.sniperdronedata.hoverbounceconeangle = 10;
        level.player.sniperdronedata.hoverspeed = 0;
        return calculatehoverlocation( var_0 );
    }
    else
    {
        updatehoverspeed( var_0 );
        var_1 = var_0 + level.player.sniperdronedata.dronehoverdirection * 2;

        if ( lengthsquared( level.player.sniperdronelink.origin - var_1 ) < squared( 3 ) )
            level.player.sniperdronedata.calculatenewhoverdestination = 1;

        return calculatehoverlocation( var_0 );
    }

    return ( 0, 0, 0 );
}

angle_lerp( var_0, var_1, var_2 )
{
    return angleclamp( var_0 + angleclamp180( var_1 - var_0 ) * var_2 );
}

euler_lerp( var_0, var_1, var_2 )
{
    return ( angle_lerp( var_0[0], var_1[0], var_2 ), angle_lerp( var_0[1], var_1[1], var_2 ), angle_lerp( var_0[2], var_1[2], var_2 ) );
}
