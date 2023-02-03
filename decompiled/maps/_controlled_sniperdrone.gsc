// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precacheassets()
{
    precacheshader( "white_multiply" );
    precacheshader( "overlay_static_digital" );
    precacheshader( "sentinel_drone_scanlines" );
    precacheshader( "sentinel_drone_overlay_distort" );
    precacheshader( "ugv_vignette_overlay" );
    precacheshader( "remote_chopper_overlay_scratches" );
    precacheshader( "wasp_screencrack" );
    precacheshellshock( "hms_sniperdrone" );
    precacheshellshock( "barrett" );
    precachestring( &"sniper_drone_hud" );
    precachestring( &"sniper_drone_hud_update" );
    maps\_utility::add_control_based_hint_strings( "drone_move", &"GREECE_HINT_DRONE_MOVE", ::hintdronemoveoff, &"GREECE_HINT_DRONE_MOVE_KB", &"GREECE_HINT_DRONE_MOVE_SP" );
    maps\_utility::add_control_based_hint_strings( "drone_shoot", &"GREECE_HINT_DRONE_JUSTSHOOT", ::hintdroneshootoff );
    precachestring( &"GREECE_WARN_DRONE_DRYFIRE" );
    precachestring( &"GREECE_WARN_INCOMING_MISSILE" );
    precachemodel( "vehicle_sniper_drone_outerparts" );
    precachemodel( "vehicle_sniper_drone_outerparts_cloak" );
    precachemodel( "vehicle_vm_sniper_drone" );
    precachemodel( "vehicle_vm_sniper_drone_cloak" );
    precachemodel( "vehicle_sniper_drone_hud_glass" );
    precachemodel( "vehicle_sniper_drone_hud_glass_break" );
}

initializesniperdronedata()
{
    var_0 = spawnstruct();
    var_0.droneangularvelocity = 0;
    var_0.droneverticalvelocity = 0;
    var_0.calculatenewhoverdestination = 1;
    var_0.dronehoverdirection = ( 0, 0, -1 );
    var_0.hoverspeed = 1;
    var_0.lasthoveroffset = ( 0, 0, 0 );
    var_0.hoverbounceconeangle = 120;
    var_0.lastrecoiloffset = ( 0, 0, 0 );
    var_0.recoildirection = ( 0, 0, 0 );
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
    var_0.dronesattackspeedmultiplier = 0.9;
    return var_0;
}

alerthighlighthudeffect( var_0 )
{
    level.player notify( "AlertHudEffect" );
    level.player endon( "AlertHudEffect" );
    var_1 = newclienthudelem( level.player );
    var_1.color = ( 1, 0.05, 0.025 );
    var_1.alpha = 1.0;
    var_1 setradarhighlight( var_0 );
    return var_1;
}

initdroneflyinturnrate()
{
    setsaveddvar( "aim_turnrate_pitch", 30 );
    setsaveddvar( "aim_turnrate_pitch_ads", 25 );
    setsaveddvar( "aim_turnrate_yaw", 60 );
    setsaveddvar( "aim_turnrate_yaw_ads", 40 );
    setsaveddvar( "aim_accel_turnrate_lerp", 300 );
}

initdroneturnrate()
{
    setsaveddvar( "aim_turnrate_pitch", 70 );
    setsaveddvar( "aim_turnrate_pitch_ads", 55 );
    setsaveddvar( "aim_turnrate_yaw", 125 );
    setsaveddvar( "aim_turnrate_yaw_ads", 90 );
    setsaveddvar( "aim_accel_turnrate_lerp", 600 );
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
    setsaveddvar( "aim_turnrate_pitch", self.aim_turnrate_pitch );
    setsaveddvar( "aim_turnrate_pitch_ads", self.aim_turnrate_pitch_ads );
    setsaveddvar( "aim_turnrate_yaw", self.aim_turnrate_yaw );
    setsaveddvar( "aim_turnrate_yaw_ads", self.aim_turnrate_yaw_ads );
    setsaveddvar( "aim_accel_turnrate_lerp", self.aim_accel_turnrate_lerp );
}

#using_animtree("vehicles");

startdronecontrol( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getdvarfloat( "g_friendlyNameDist" );
    setomnvar( "ui_sniperdrone", 1 );
    maps\_shg_utility::hide_player_hud();
    setsaveddvar( "compass", "1" );
    common_scripts\utility::create_dvar( "SniperDrone_Hide", 0 );
    var_7 = level.player getcurrentweapon();
    var_8 = getdvarint( "cg_fov", 65 ) * getdvarfloat( "cg_playerFovScale0", 1 );
    var_9 = distance2d( var_0.origin, var_1.origin );
    var_10 = vectortoangles( var_1.origin - var_0.origin );
    level.player hideviewmodel();
    level.player disableweaponswitch();
    level.player disableoffhandweapons();
    level.player allowcrouch( 0 );
    var_11 = initializesniperdronedata();
    var_12 = common_scripts\utility::spawn_tag_origin();
    level.player.sniperdronelink = var_12;
    level.player.sniperdronedata = var_11;
    initorbitlowerbounds( var_0.origin, var_5 );
    soundscripts\_snd::snd_message( "start_sniper_drone" );
    level.droneweapon = "hms_sniperdrone";
    level.player giveweapon( level.droneweapon );
    level.player switchtoweaponimmediate( level.droneweapon );
    level.variable_scope_weapons = [ "hms_sniperdrone" ];
    maps\_hms_utility::printlnscreenandconsole( "Drone is now armed with " + level.droneweapon );
    var_11.frameviewmodel = spawn( "script_model", var_12.origin );
    var_11.frameviewmodel setmodel( "vehicle_sniper_drone_outerparts_cloak" );
    var_11.frameviewmodel linktoplayerview( level.player, "tag_origin", ( 13, 0, -3 ), ( 0, 0, 0 ), 1 );
    var_12.frameviewmodel = var_11.frameviewmodel;
    var_11.frameviewmodel childthread viewmodelanimupdate( %sniper_drone_outerparts_idle, %sniper_drone_outerparts_fire );
    var_11.frameviewmodel thread sniperdronecloak();
    var_11.barrelviewmodel = spawn( "script_model", var_12.origin );
    var_11.barrelviewmodel setmodel( "vehicle_vm_sniper_drone_cloak" );
    var_11.barrelviewmodel linktoplayerview( level.player, "tag_origin", ( -1, 0, -1.75 ), ( 0, 0, 0 ), 1 );
    var_12.barrelviewmodel = var_11.barrelviewmodel;
    var_11.barrelviewmodel childthread viewmodelanimupdate( %sniper_drone_vm_idle, %sniper_drone_vm_fire );
    var_11.barrelviewmodel thread sniperdronecloak();

    if ( !level.currentgen )
    {
        var_11.lensviewmodel = spawn( "script_model", var_12.origin );
        var_11.lensviewmodel setmodel( "vehicle_sniper_drone_hud_glass" );
        var_11.lensviewmodel linktoplayerview( level.player, "tag_origin", ( 9, 0, 0 ), ( 0, 0, 0 ), 1 );
        childthread sniperdronelensdamaged();
    }

    playfxontag( common_scripts\utility::getfx( "sniper_drone_thruster_view" ), var_11.barrelviewmodel, "TAG_ORIGIN" );
    playfxontag( common_scripts\utility::getfx( "sniper_drone_wind_marker" ), var_11.barrelviewmodel, "TAG_ORIGIN" );
    setsaveddvar( "cg_drawBreathHint", 0 );
    var_13 = sniperdroneoverlays();
    var_14 = alerthighlighthudeffect( 3600 );
    level.player enableweapons();
    level.player enableinvulnerability();
    childthread dofiringeffects();
    childthread doadsblur( var_4 );
    childthread adjustfov( var_4, var_13["black_sides"], var_13["tech"] );
    childthread adjustshadowcenter( var_4 );
    childthread cameralookatescapevehicle( var_0, var_10, var_9 );
    childthread updateflyinscopeoverlay( var_13["scope"], var_1.origin[2] );
    childthread updateviewmodelvisibility();

    if ( !var_4 )
        thread disabledronefiringatstart( var_3 );

    level.player.sniperdronelink savedefaultturnrate();

    if ( var_3 )
    {
        var_12 initdroneflyinturnrate();
        maps\greece_conf_center::sniperdroneflyin( var_12 );
        level.player playerlinktodelta( var_12, "tag_origin", 0, 90, 90, 20, 60, 1 );
        var_15 = var_12.angles;
        var_16 = vectortoangles( var_0.origin - var_1.origin ) * ( 0, 1, 0 );

        for ( var_17 = 0; var_17 <= 1; var_12.angles = ( var_18[0], var_12.angles[1], var_12.angles[2] ) )
        {
            wait 0.05;
            var_17 += 0.1;
            var_18 = euler_lerp( var_15 * ( 1, 0, 0 ), var_16 * ( 1, 0, 0 ), var_17 ) * ( 1, 0, 0 );
        }

        for ( var_17 = 0; var_17 <= 1; var_12.angles = ( var_12.angles[0], var_19[1], var_12.angles[2] ) )
        {
            wait 0.05;
            var_17 += 0.2;
            var_19 = euler_lerp( var_15 * ( 0, 1, 0 ), var_16 * ( 0, 1, 0 ), var_17 ) * ( 0, 1, 0 );
        }
    }
    else
        level.player setangles( vectortoangles( var_2.origin - var_1.origin ) );

    initdroneturnrate();
    calculateinitialposition( var_1.origin, var_0, var_10, var_9 );
    level.player playerlinktodelta( var_12, "tag_origin", 1, 90, 90, 20, 60, 1 );
    var_20 = var_12.origin;
    var_21 = 0;
    var_22 = 0;
    setsaveddvar( "g_friendlyNameDist", 15000 );

    while ( isdefined( level.player.sniperdronelink ) )
    {
        wait 0.05;

        if ( common_scripts\utility::flag( "FlagPlayerEndDroneStatic" ) || common_scripts\utility::flag( "FlagSniperDroneAnimating" ) || common_scripts\utility::flag( "FlagSniperDroneLookAt" ) )
            continue;

        setomnvar( "ui_sniperdrone", 1 );
        updatescopeoverlay( var_13["scope"], var_22, var_4 );
        updatedronesattackspeedmultiplier();
        var_11.droneangularvelocity = updatehorizontalvelocity();
        var_11.droneverticalvelocity = updateverticalvelocity();
        var_23 = angleclamp( var_21 + var_11.droneangularvelocity * 0.05 );
        var_24 = combineangles( ( 0, var_23, 0 ), var_10 );
        var_25 = var_22 + var_11.droneverticalvelocity * 0.05;
        var_25 = clamp( var_25, -900.0, 900 );
        var_26 = var_20;
        var_27 = var_0.origin + ( 0, 0, var_25 );
        var_20 = var_27 + anglestoforward( var_24 ) * var_9;
        var_28 = clamppositiontolowerbounds( var_20, var_0.origin );
        var_20 = ( var_20[0], var_20[1], var_20[2] + var_28 );
        var_25 += var_28;
        var_23 = clampyaworbitoffset( var_20, var_0.origin, var_10 );
        var_29 = updatehoveridle( var_20 );
        var_11.lasthoveroffset += var_29;
        var_30 = updaterecoiloffset();
        var_12.origin = var_20 + var_11.lasthoveroffset + var_30;
        var_11.currentvelocity = var_20 - var_26;
        var_31 = vectortoangles( var_27 - var_20 );
        var_31 *= ( 0, 1, 0 );
        var_31 = updatebodyroll( var_31 );
        var_12.angles = var_31;
        var_21 = var_23;
        var_22 = var_25;
    }

    setsaveddvar( "sm_sunShadowCenter", "0 0 0" );
    setsaveddvar( "sm_lightScore_eyeProjectDist", 64 );
    setsaveddvar( "sv_znear", "0" );
    common_scripts\utility::flag_set( "init_safehouse_outro_start_lighting" );
    level.player disableinvulnerability();
    level.player enableweaponswitch();
    level.player enableoffhandweapons();
    level.player allowads( 1 );
    level.player allowcrouch( 1 );
    level.player takeweapon( level.droneweapon );
    maps\_shg_utility::show_player_hud();

    foreach ( var_33 in var_13 )
        var_33 destroy();

    var_14 destroy();
    var_11.frameviewmodel unlinkfromplayerview( level.player );
    var_11.barrelviewmodel unlinkfromplayerview( level.player );

    if ( !level.currentgen )
        var_11.damagedlensviewmodel unlinkfromplayerview( level.player );

    level.player unlink();
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartConfCenter", "targetname" ) );
    level.player showviewmodel();
    level.player lerpfov( var_8, 0.5 );
    level.player disablefocus( 2.0 );
    level.player disableaudiozoom( 1.0 );
    setsaveddvar( "cg_drawBreathHint", 1 );
    setsaveddvar( "g_friendlyNameDist", var_6 );
    soundscripts\_snd::snd_message( "stop_sniper_drone" );
    level.player switchtoweaponimmediate( var_7 );
}

sniperdronecloak()
{
    self drawpostresolve();
    self setmaterialscriptparam( 0.0, 0.0 );
    common_scripts\utility::flag_wait( "FlagSniperDroneCloakOff" );
    self drawpostresolveoff();
    self setmaterialscriptparam( 1.0, 1.0 );
}

sniperdroneoverlays()
{
    var_0 = [];
    var_0["scope"] = createoverlay( "white_multiply", 0.0 );
    var_0["static"] = createoverlay( "overlay_static_digital", 0.01 );
    var_0["scanlines"] = createoverlay( "sentinel_drone_scanlines", 0.0 );
    var_0["distort"] = createoverlay( "sentinel_drone_overlay_distort", 0.0 );
    var_0["scratches"] = createoverlay( "remote_chopper_overlay_scratches", 0.0 );
    childthread flickerstaticoverlay( var_0["static"], "FlagPlayerStartDroneFlight", 0.1, 2.5, 0, 0.1 );
    childthread flickerstaticoverlay( var_0["scanlines"], "FlagSniperDroneFlinch", 0.5, 7.5, 0, 0.25 );
    childthread flickerstaticoverlay( var_0["static"], "FlagSniperDroneFlinch", 0.25, 2.5 );
    childthread adjuststaticoverlay( var_0["scratches"], "FlagSniperDroneFlinch", 1.0, undefined, 0.5 );
    thread sniperdronemissilewarnmsg();
    childthread flickerstaticoverlay( var_0["scanlines"], "FlagSniperDroneHit", 0.75, 5.0, 0, 0.25 );
    childthread flickerstaticoverlay( var_0["static"], "FlagSniperDroneHit", 0.5, 5.0 );
    childthread adjuststaticoverlay( var_0["static"], "FlagPlayerEndDroneStatic", 1.0 );
    childthread flickerstaticoverlay( var_0["scanlines"], "FlagPlayerEndDroneStatic", 0.75, 1.0 );
    return var_0;
}

viewmodelanimupdate( var_0, var_1 )
{
    self useanimtree( #animtree );
    var_2 = getanimlength( var_1 );
    var_3 = 0;

    while ( isdefined( level.player.sniperdronelink ) )
    {
        if ( !var_3 )
        {
            self setanimknob( var_0 );
            level.player waittill( "weapon_fired" );
        }

        self setanimknobrestart( var_1 );
        var_3 = 0;

        if ( !isdefined( waittillplayerfireortime( var_2 ) ) )
            var_3 = 1;
    }
}

waittillplayerfireortime( var_0 )
{
    level.player endon( "weapon_fired" );
    wait(var_0);
    return 1;
}

disabledronefiringatstart( var_0 )
{
    level.player allowfire( 0 );

    if ( var_0 == 1 )
        common_scripts\utility::flag_wait( "FlagPlayerEndDroneFlight" );

    thread sniperdronedryfire( "FlagOkayToShootDrone" );
    wait 1.0;
    hintsniperdronemove();
    common_scripts\utility::flag_wait( "FlagOkayToShootDrone" );
    level notify( "SniperdroneSafetyOff" );
    level.player allowfire( 1 );
    wait 0.05;
    thread maps\greece_code::warning_fade();
    hintsniperdroneshoot();
}

disabledronefiringafterkill()
{
    level.player allowfire( 0 );
    thread sniperdronedryfire( "FlagConfRoomAlliesRecover" );
    common_scripts\utility::flag_wait( "FlagConfRoomAlliesRecover" );
    level notify( "SniperdroneSafetyOff" );
    level.player allowfire( 1 );
    wait 0.05;
    thread maps\greece_code::warning_fade();
}

disabledronefiringduringcrash()
{
    level.player allowfire( 0 );
    level.player allowads( 0 );
    thread sniperdronebadfire();
}

sniperdronedryfire( var_0 )
{
    level endon( "SniperdroneSafetyOff" );

    while ( !common_scripts\utility::flag( var_0 ) )
    {
        if ( level.player attackbuttonpressed() )
        {
            soundscripts\_snd::snd_message( "sniper_drone_dry_fire" );
            thread sniperdronedryfiremsg();
        }

        waitframe();
    }

    thread maps\greece_code::warning_fade();
}

sniperdronedryfiremsg()
{
    thread maps\greece_code::warning( &"GREECE_WARN_DRONE_DRYFIRE" );
    wait 3.0;
    thread maps\greece_code::warning_fade();
}

sniperdronemissilewarnmsg()
{
    common_scripts\utility::flag_wait( "FlagHadesVehicleDroneLaunch" );
    thread maps\greece_code::warning( &"GREECE_WARN_INCOMING_MISSILE", undefined, 60, 2 );
    common_scripts\utility::flag_wait( "FlagSniperDroneHit" );
    thread maps\greece_code::warning_fade();
}

sniperdronebadfire()
{
    level endon( "EndDroneControl" );

    while ( !common_scripts\utility::flag( "FlagPlayerEndDroneControl" ) )
    {
        if ( level.player attackbuttonpressed() )
            soundscripts\_snd::snd_message( "sniper_drone_dmg_fire" );

        waitframe();
    }
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
    level.player.sniperdronelink.origin = var_1.origin + anglestoforward( var_2 ) * var_3;
    level.player.sniperdronelink.angles = vectortoangles( var_1.origin - var_0 ) * ( 0, 1, 0 );
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

updateviewmodelvisibility()
{
    level.player endon( "death" );
    level endon( "end_sniper_drone" );
    var_0 = 0;

    for (;;)
    {
        wait 0.05;

        if ( getdvarint( "SniperDrone_Hide" ) == 1 && !var_0 )
        {
            level.player.sniperdronedata.frameviewmodel hide();
            level.player.sniperdronedata.barrelviewmodel hide();

            if ( isdefined( level.player.sniperdronedata.lensviewmodel ) )
                level.player.sniperdronedata.lensviewmodel hide();

            var_0 = 1;
            continue;
        }

        if ( getdvarint( "SniperDrone_Hide" ) == 0 && var_0 )
        {
            level.player.sniperdronedata.frameviewmodel show();
            level.player.sniperdronedata.barrelviewmodel show();

            if ( isdefined( level.player.sniperdronedata.lensviewmodel ) )
                level.player.sniperdronedata.lensviewmodel show();

            var_0 = 0;
        }
    }
}

cameralookatescapevehicle( var_0, var_1, var_2 )
{
    level.player endon( "death" );
    level endon( "end_sniper_drone" );
    common_scripts\utility::flag_wait( "FlagHadesVehicleDroneLaunch" );
    var_3 = getvehiclenode( "HadesEscapeVehicleStart", "targetname" );
    common_scripts\utility::flag_set( "FlagSniperDroneLookAt" );
    level.player allowads( 0 );
    var_4 = ( 0, 0, 0 );

    foreach ( var_6 in level.allenemyvehicles )
    {
        if ( isdefined( var_6.escapevehicle ) )
            var_4 = var_6.origin;
    }

    var_8 = vectortoangles( var_4 - level.player.sniperdronelink.origin );
    clearmovementparameters();
    lerpplayerlook( var_8 );
    common_scripts\utility::flag_clear( "FlagSniperDroneLookAt" );
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
        updatescopeoverlayalpha( 0, var_0 );
        luinotifyevent( &"sniper_drone_hud_update", 8, int( maps\_utility::round_float( var_4 * 100, 0, 0 ) ), 0, int( var_3 ), 0, 0, int( var_0.alpha * 10 ), 0, gettime() );
        var_5 = level.player.sniperdronelink.angles[0];

        if ( common_scripts\utility::flag( "FlagSniperDroneLookAt" ) )
            var_5 = getlookpitch();

        updateviewmodelpitchoffset( var_5 );
        level.player.sniperdronedata.frameviewmodel unlinkfromplayerview( level.player );
        level.player.sniperdronedata.frameviewmodel linktoplayerview( level.player, "tag_origin", level.player.sniperdronedata.frameviewmodeloffset, ( 0, 0, 0 ), 1 );
        level.player.sniperdronedata.barrelviewmodel unlinkfromplayerview( level.player );
        level.player.sniperdronedata.barrelviewmodel linktoplayerview( level.player, "tag_origin", level.player.sniperdronedata.barrelviewmodeloffset, ( 0, 0, 0 ), 1 );
    }
}

hintsniperdronemove()
{
    thread notifyonplayermovingsniperdrone();
    thread maps\_utility::hintdisplaymintimehandler( "drone_move", 15.0, 5.0 );
}

hintdronemoveoff()
{
    if ( isdefined( level.playermovingdrone ) && level.playermovingdrone == 1 )
        return level.playermovingdrone;
    else if ( common_scripts\utility::flag( "FlagGateGuardsAtAllyVehicle" ) )
        return 1;

    return 0;
}

notifyonplayermovingsniperdrone()
{
    for (;;)
    {
        var_0 = level.player getnormalizedmovement();

        if ( length( var_0 ) != 0 )
        {
            level.playermovingdrone = 1;
            break;
        }

        wait 0.05;
    }
}

hintsniperdroneshoot()
{
    thread maps\_utility::hintdisplaymintimehandler( "drone_shoot", 10.0, 3.0 );
}

hintdroneshootoff()
{
    return level.player attackbuttonpressed();
}

dofiringeffects()
{
    level endon( "end_sniper_drone" );
    level.player endon( "death" );
    var_0 = common_scripts\utility::getfx( "sniper_drone_flash_view" );
    var_1 = common_scripts\utility::getfx( "sniper_drone_tracer" );
    var_2 = level.player common_scripts\utility::spawn_tag_origin();
    var_2 linktoplayerview( level.player, "tag_origin", ( 0, 0, -5 ), ( 0, 0, 0 ), 1 );

    while ( level.droneweapon == "hms_sniperdrone" )
    {
        level.player waittill( "weapon_fired" );
        level.player shellshock( "barrett", 0.3 );
        level.player.sniperdronedata.recoildirection = anglestoforward( level.player getgunangles() ) * -1;
        level.player.sniperdronedata.calculatenewhoverdestination = 1;
        level.player.sniperdronedata.lastrecoiloffset = ( 0, 0, 0 );

        if ( level.player adsbuttonpressed() )
        {
            var_3 = level.player geteye();
            var_4 = anglestoforward( level.player getgunangles() );
            var_5 = var_3 + var_4 * 100;
            var_6 = var_3 + var_4 * 5000;
            var_7 = bullettrace( var_5, var_6, 1, undefined, 0, 1 );
            var_8 = var_3 - ( 0, 0, 5 );
            var_9 = var_7["position"] - var_8;
            playfx( var_1, var_8, var_9, ( 0, 0, 1 ) );
            screenshake( level.player.origin, 0.25, 0, 0, 0.2, 0.1, 0.1, 0, 0.5 );
            continue;
        }

        playfxontag( var_0, level.player.sniperdronedata.barrelviewmodel, "tag_flash" );
        playfxontag( var_1, level.player.sniperdronedata.barrelviewmodel, "tag_flash" );
    }
}

updaterecoiloffset( var_0 )
{
    if ( level.player.sniperdronedata.recoildirection != ( 0, 0, 0 ) )
    {
        var_1 = level.player.sniperdronedata.recoildirection * 250;
        level.player.sniperdronedata.recoildirection = ( 0, 0, 0 );
        level.player.sniperdronedata.lastrecoiloffset = var_1;
        return var_1;
    }

    if ( level.player.sniperdronedata.lastrecoiloffset == ( 0, 0, 0 ) )
        return ( 0, 0, 0 );

    level.player.sniperdronedata.lastrecoiloffset = vectorlerp( level.player.sniperdronedata.lastrecoiloffset, ( 0, 0, 0 ), 0.1 );
    return level.player.sniperdronedata.lastrecoiloffset;
}

isadsenabled( var_0 )
{
    if ( common_scripts\utility::flag( "FlagHadesVehicleDroneLaunch" ) || common_scripts\utility::flag( "FlagConfRoomExplosion" ) )
        return 0;

    if ( !var_0 && !common_scripts\utility::flag( "FlagMonitorZoomOnHades" ) && !common_scripts\utility::flag( "FlagGateGuardsApproachingAllyVehicle" ) && !common_scripts\utility::flag( "FlagConfRoomExplosion" ) && !common_scripts\utility::flag( "FlagHadesVehicleDroneLaunch" ) )
        return 0;

    return 1;
}

doadsblur( var_0 )
{
    level.player endon( "death" );
    level endon( "end_sniper_drone" );
    var_1 = level.player adsbuttonpressed();

    for (;;)
    {
        wait 0.05;

        if ( common_scripts\utility::flag( "FlagForcePlayerADS" ) || !isadsenabled( var_0 ) )
            continue;

        var_2 = level.player adsbuttonpressed();

        if ( !var_1 && var_2 )
        {
            level.player setblurforplayer( 2, 0.1 );
            wait 0.3;
            level.player setblurforplayer( 0, 0.1 );
        }
        else if ( var_1 && !var_2 )
        {
            level.player setblurforplayer( 2, 0.1 );
            wait 0.3;
            level.player setblurforplayer( 0, 0.1 );
        }

        var_1 = var_2;
    }
}

adjustfov( var_0, var_1, var_2 )
{
    level.player endon( "death" );
    level endon( "end_sniper_drone" );
    var_3 = 40;
    var_4 = 7.5;
    var_5 = 0;
    var_6 = 0;
    level.player lerpfov( var_3, 0.5 );
    level.player enablefocus( var_4 / 2.0, var_4, 1.0, 0.0 );

    while ( isdefined( level.player.sniperdronelink ) )
    {
        wait 0.05;

        if ( !isdefined( level.player.sniperdronelink ) )
            break;

        if ( issaverecentlyloaded() && !var_6 )
        {
            var_5 = 1;
            var_6 = 1;
        }
        else if ( !issaverecentlyloaded() )
            var_6 = 0;

        if ( isadsenabled( var_0 ) && level.player adsbuttonpressed() || common_scripts\utility::flag( "FlagForcePlayerADS" ) )
        {
            if ( !var_5 )
            {
                level.player lerpfov( var_4, 0.25 );
                level.player enablefocus( 7.5, 20, 0.125, 1.0 );
                level.player enableaudiozoom( 2.0, 1.0 );
                var_5 = 1;
            }

            continue;
        }

        if ( var_5 )
        {
            level.player lerpfov( var_3, 0.5 );
            level.player enablefocus( 7.5, 20, 1.0, 1.0 );
            level.player disableaudiozoom( 1.0 );
            var_5 = 0;
        }
    }
}

updatesunshadowcenter( var_0, var_1 )
{
    var_2 = anglestoforward( level.player getgunangles() );
    var_3 = var_1;
    var_4 = level.player geteye() + var_2 * 100;
    var_5 = level.player.origin + var_2 * 5000;
    var_6 = bullettrace( var_4, var_5, 1, level.player );

    if ( isdefined( var_6["position"] ) )
    {
        var_7 = distance( var_4, var_6["position"] );
        var_3 = var_0.origin + var_2 * var_7 * 0.9;
    }

    setsaveddvar( "sm_sunShadowCenter", var_3 );
}

adjustshadowcenter( var_0 )
{
    level.player endon( "death" );
    level endon( "end_sniper_drone" );
    var_1 = 0;
    var_2 = getent( "PlayerDroneTargetpoint", "targetname" );

    while ( isdefined( level.player.sniperdronelink ) )
    {
        wait 0.1;

        if ( !isdefined( level.player.sniperdronelink ) )
            break;

        if ( isadsenabled( var_0 ) && level.player adsbuttonpressed() || common_scripts\utility::flag( "FlagForcePlayerADS" ) )
        {
            updatesunshadowcenter( level.player.sniperdronelink, var_2 );

            if ( !var_1 )
            {
                level.player lightsetforplayer( "confcenter_drone_zoom" );
                var_1 = 1;
            }

            continue;
        }

        if ( var_1 )
        {
            setsaveddvar( "sm_sunShadowCenter", "0 0 0" );
            level.player lightsetforplayer( "confcenter_start" );
            var_1 = 0;
        }
    }
}

adjuststaticoverlay( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_0.alpha;
    common_scripts\utility::flag_wait( var_1 );

    if ( isdefined( var_4 ) )
        wait(var_4);

    var_0.alpha = var_2;

    if ( isdefined( var_3 ) )
    {
        wait(var_3);
        var_0.alpha = var_5;
    }
}

flickerstaticoverlay( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_0.alpha;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_7 = 0.01 + var_4;
    var_8 = 0.05 + var_4;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_9 = 0.25 + var_5;
    var_10 = 0.75 + var_5;
    common_scripts\utility::flag_wait( var_1 );
    var_11 = gettime() * 0.001;
    var_12 = 0;

    while ( var_12 < var_3 )
    {
        if ( isdefined( var_0 ) )
            var_0.alpha = var_2;

        wait(randomfloatrange( var_7, var_8 ));
        soundscripts\_snd::snd_message( "start_wasp_flicker" );

        if ( isdefined( var_0 ) )
            var_0.alpha = var_6;

        wait(randomfloatrange( var_9, var_10 ));
        var_13 = gettime() * 0.001;
        var_12 = var_13 - var_11;
        wait 0.05;
    }
}

adjustmissileoverlay( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_wait( var_1 );
    var_0.alpha = 1.0;
    soundscripts\_snd::snd_message( "start_wasp_missile_warning" );
    common_scripts\utility::flag_wait( var_2 );
    var_0.alpha = 0.0;
    soundscripts\_snd::snd_message( "stop_wasp_missile_warning" );
}

sniperdronelensdamaged()
{
    level.player waittill( "kamikaze_damaged_lens" );
    level.player.sniperdronedata.lensviewmodel unlinkfromplayerview( level.player );
    level.player.sniperdronedata.lensviewmodel hide();
    level.player.sniperdronedata.lensviewmodel delete();
    level.player.sniperdronedata.damagedlensviewmodel = spawn( "script_model", level.player.sniperdronelink.origin );
    level.player.sniperdronedata.damagedlensviewmodel setmodel( "vehicle_sniper_drone_hud_glass_break" );
    level.player.sniperdronedata.damagedlensviewmodel linktoplayerview( level.player, "tag_origin", ( 9, 0, 0 ), ( 0, 0, 0 ), 1 );
}

enddronecontrol()
{
    rumblesniperdronetakenout();
    level.player.sniperdronelink restoredefaultturnrate();
    wait 0.75;
    level.player setblurforplayer( 10, 0.5 );
    maps\_hud_util::fade_out( 0.25, "white" );
    level.player.sniperdronelink = undefined;
    setomnvar( "ui_sniperdrone", 0 );
    soundscripts\_snd::snd_message( "stop_drone_death_static" );
    wait 0.25;
    common_scripts\utility::flag_set( "init_safehouse_outro_start_lighting" );
    level.player setblurforplayer( 0, 0.1 );
    common_scripts\utility::flag_set( "FlagSafeHouseOutroStart" );
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
    var_2 setshader( var_0, 640, 480 );
    var_2.alpha = var_1;
    var_2.sort = -3;
    return var_2;
}

createmissileoverlay( var_0, var_1 )
{
    var_2 = newclienthudelem( level.player );
    var_2.x = 320;
    var_2.y = 350;
    var_2.sort = 0;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2 setshader( var_0, 256, 64 );
    var_2.alpha = 0;
    return var_2;
}

updatescopeoverlayalpha( var_0, var_1 )
{
    if ( ( isadsenabled( var_0 ) && level.player adsbuttonpressed() || common_scripts\utility::flag( "FlagForcePlayerADS" ) ) && var_1.alpha < 1.0 )
    {
        var_1.alpha += 0.2;
        soundscripts\_snd::snd_message( "start_sniper_drone_zoom" );
    }
    else if ( !( level.player adsbuttonpressed() || common_scripts\utility::flag( "FlagForcePlayerADS" ) ) && var_1.alpha > 0.0 )
    {
        var_1.alpha -= 0.2;
        soundscripts\_snd::snd_message( "stop_sniper_drone_zoom" );
    }
}

updatescopeoverlay( var_0, var_1, var_2 )
{
    var_3 = level.player getnormalizedmovement();
    var_4 = level.player getnormalizedcameramovements();
    updatescopeoverlayalpha( var_2, var_0 );
    luinotifyevent( &"sniper_drone_hud_update", 8, int( maps\_utility::round_float( var_3[1] * 100, 0, 0 ) ), int( maps\_utility::round_float( var_4[1] * 100, 0, 0 ) ), int( var_1 ), int( getlookpitch() ), int( getlookyaw() ), int( var_0.alpha * 10 ), int( level.player.sniperdronedata.droneangularvelocity ), gettime() );
}

updatedronesattackspeedmultiplier()
{
    if ( !common_scripts\utility::flag( "FlagHadesVehicleDriveStart" ) )
        return;

    level.player.sniperdronedata.dronesattackspeedmultiplier -= 0.015;
    level.player.sniperdronedata.dronesattackspeedmultiplier = clamp( level.player.sniperdronedata.dronesattackspeedmultiplier, 0.75, 1 );
}

setupsniperdebughudelem()
{
    var_0 = newhudelem();
    var_0.alignx = "left";
    var_0.aligny = "top";
    var_0.x = 40;
    var_0.y = 40;
    var_0.alpha = 0.6;
    var_0.fontscale = 1.5;
    var_0.foreground = 1;
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    return var_0;
}

drawsniperdebug( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "yawOrbitOffset " + var_1 + " verticalOffset " + var_2;
    var_0 settext( var_5 );
    common_scripts\utility::draw_arrow_time( var_3, var_4, ( 0, 1, 0 ), 0.05 );
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

    if ( common_scripts\utility::flag( "FlagHadesVehicleDriveStart" ) || common_scripts\utility::flag( "FlagForcePlayerSlowMovement" ) )
        var_0 *= level.player.sniperdronedata.dronesattackspeedmultiplier;

    if ( level.player adsbuttonpressed() && level.player enemyincrosshairs() )
        var_0 *= 0.85;

    return var_0;
}

updatehorizontalvelocity()
{
    var_0 = maps\greece_code::calculateleftstickdeadzone();
    var_1 = updatevelocity( level.player.sniperdronedata, var_0[1], level.player.sniperdronedata.droneangularvelocity, 1.25, 35, 0.9, 0.4, 10, 8 );
    return scalevelocity( var_1 );
}

updateverticalvelocity()
{
    var_0 = maps\greece_code::calculateleftstickdeadzone();
    var_1 = updatevelocity( undefined, var_0[0], level.player.sniperdronedata.droneverticalvelocity, 15, 375, 0.75, 0.4, 150, 125 );
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

calculatehoverlocation( var_0 )
{
    var_1 = var_0 + level.player.sniperdronedata.dronehoverdirection * 50;
    return vectornormalize( var_1 - level.player.sniperdronelink.origin ) * level.player.sniperdronedata.hoverspeed;
}

updatehoverspeed( var_0 )
{
    var_1 = var_0 + level.player.sniperdronedata.dronehoverdirection * 50;
    var_2 = 10;
    var_3 = length( var_1 - level.player.sniperdronelink.origin );

    if ( var_3 > var_2 )
    {
        level.player.sniperdronedata.hoverspeed += 0.5;
        level.player.sniperdronedata.hoverspeed = clamp( level.player.sniperdronedata.hoverspeed, -1.0, 1 );
        return;
    }

    var_4 = maps\_shg_utility::linear_map_clamp( var_3, 0, var_2, 0, 1 );
    level.player.sniperdronedata.hoverspeed = maps\_utility::linear_interpolate( var_4, 0.5, 1 );
}

updatehoveridle( var_0 )
{
    if ( level.player maps\_utility::isads() )
        level.player.sniperdronedata.calculatenewhoverdestination = 1;
    else if ( abs( level.player.sniperdronedata.droneangularvelocity ) > 0.05 || abs( level.player.sniperdronedata.droneverticalvelocity ) > 0.05 )
    {
        level.player.sniperdronedata.calculatenewhoverdestination = 1;
        level.player.sniperdronedata.hoverbounceconeangle = 30;
        level.player.sniperdronedata.dronehoverdirection = vectornormalize( level.player.sniperdronedata.currentvelocity ) * -1;
    }
    else if ( level.player.sniperdronedata.calculatenewhoverdestination )
    {
        level.player.sniperdronedata.calculatenewhoverdestination = 0;
        level.player.sniperdronedata.dronehoverdirection = common_scripts\utility::randomvectorincone( level.player.sniperdronedata.dronehoverdirection * -1, level.player.sniperdronedata.hoverbounceconeangle );
        level.player.sniperdronedata.dronehoverdirection = vectornormalize( level.player.sniperdronedata.dronehoverdirection );
        level.player.sniperdronedata.hoverbounceconeangle = 120;
        level.player.sniperdronedata.hoverspeed = 0;
        return calculatehoverlocation( var_0 );
    }
    else
    {
        updatehoverspeed( var_0 );
        var_1 = var_0 + level.player.sniperdronedata.dronehoverdirection * 50;

        if ( lengthsquared( level.player.sniperdronelink.origin - var_1 ) < squared( 3 ) )
            level.player.sniperdronedata.calculatenewhoverdestination = 1;

        return calculatehoverlocation( var_0 );
    }

    return ( 0, 0, 0 );
}

updateviewmodelacceleration( var_0 )
{
    var_1 = level.player.sniperdronedata;

    if ( level.player maps\_utility::isads() )
    {
        var_1.framerollacceleration = vectorlerp( var_1.framerollacceleration, ( 0, 0, 0 ), 0.1 );
        var_1.barrelrollacceleration = vectorlerp( var_1.barrelrollacceleration, ( 0, 0, 0 ), 0.1 );
    }
    else if ( var_1.stickhorizontalinputlength >= 0.1 )
    {
        var_1.framerollacceleration = vectorlerp( var_1.framerollacceleration, var_0 * var_1.targetangularacceleration, 0.1 );
        var_1.barrelrollacceleration = vectorlerp( var_1.barrelrollacceleration, var_0 * var_1.targetangularacceleration, 0.05 );
    }
    else
    {
        var_2 = 0.4 * squared( var_1.brakingcurrenttime );
        var_3 = 0.9 * squared( var_1.brakingcurrenttime );
        var_1.framerollacceleration = vectorlerp( var_1.framerollacceleration, var_0 * var_1.targetangularacceleration, var_2 );
        var_1.barrelrollacceleration = vectorlerp( var_1.barrelrollacceleration, var_0 * var_1.targetangularacceleration, var_3 );
        var_1.brakingcurrenttime += 0.05;
        var_1.brakingcurrenttime = clamp( var_1.brakingcurrenttime, 0, 1 );
    }
}

updateviewmodellookoffset( var_0 )
{
    if ( level.player maps\_utility::isads() )
    {
        level.player.sniperdronedata.horizontaloffsetlook = maps\_utility::linear_interpolate( 0.1, level.player.sniperdronedata.horizontaloffsetlook, 0 );
        level.player.sniperdronedata.verticaloffsetlook = maps\_utility::linear_interpolate( 0.075, level.player.sniperdronedata.verticaloffsetlook, 0 );
        return;
    }

    var_1 = level.player getnormalizedcameramovements();
    var_2 = 0;

    if ( var_1[1] > 0 )
        var_2 = maps\_utility::linear_interpolate( var_1[1], 0, 1.5 );
    else
        var_2 = maps\_utility::linear_interpolate( -1 * var_1[1], 0, 1.5 ) * -1;

    var_3 = 0;

    if ( var_1[0] > 0 )
        var_3 = maps\_utility::linear_interpolate( var_1[0], 0, 1 ) * -1;
    else
        var_3 = maps\_utility::linear_interpolate( -1 * var_1[0], 0, 1 );

    level.player.sniperdronedata.horizontaloffsetlook = maps\_utility::linear_interpolate( 0.05, level.player.sniperdronedata.horizontaloffsetlook, var_2 );
    level.player.sniperdronedata.verticaloffsetlook = maps\_utility::linear_interpolate( 0.03, level.player.sniperdronedata.verticaloffsetlook, var_3 );
}

getviewmodelrotation( var_0, var_1, var_2, var_3 )
{
    var_4 = ( 0, 0, 1 ) + var_0 * maps\_utility::linear_interpolate( var_1, 0, var_3 );
    var_5 = vectorcross( var_4, var_2 );
    var_2 = vectorcross( var_5, var_4 );
    return axistoangles( var_2, var_5 * -1, var_4 );
}

updateviewmodelpitchoffset( var_0 )
{
    var_0 = clamplookangle( var_0 );
    var_1 = 120;
    var_2 = 1.5;
    var_3 = ( var_0 + 60 ) / var_1;
    var_3 = 1 - clamp( var_3, 0, 1 );
    var_4 = ( 13, 0, -3 )[0];
    var_5 = ( -1, 0, -1.75 )[0];
    var_6 = maps\_utility::linear_interpolate( var_3, var_4 + var_2, var_4 - var_2 );
    var_7 = maps\_utility::linear_interpolate( var_3, var_5 + var_2, var_5 - var_2 );
    level.player.sniperdronedata.frameviewmodeloffset = ( var_6, 0, ( 13, 0, -3 )[2] );
    level.player.sniperdronedata.barrelviewmodeloffset = ( var_7, 0, ( -1, 0, -1.75 )[2] );
}

getviewmodelstrafeoffset()
{
    level.player.sniperdronedata.horizontaloffsetstrafe = maps\_utility::linear_interpolate( 0.2, level.player.sniperdronedata.horizontaloffsetstrafe, level.player.sniperdronedata.droneangularvelocity / 35 );
    level.player.sniperdronedata.verticaloffsetstrafe = maps\_utility::linear_interpolate( 0.2, level.player.sniperdronedata.verticaloffsetstrafe, level.player.sniperdronedata.droneverticalvelocity / 375 );
    return ( 0, level.player.sniperdronedata.horizontaloffsetstrafe * 1.5, level.player.sniperdronedata.verticaloffsetstrafe );
}

updatebodyroll( var_0 )
{
    var_1 = level.player.sniperdronedata;

    if ( level.player maps\_utility::isads() )
        var_1.bodyrollvelocity = vectorlerp( var_1.bodyrollvelocity, ( 0, 0, 0 ), 0.1 );
    else
        var_1.bodyrollvelocity = vectorlerp( var_1.bodyrollvelocity, var_1.currentvelocity * ( 1, 1, 0 ), 0.2 );

    var_2 = anglestoforward( level.player getangles() * ( 0, 1, 0 ) );
    var_2 = vectornormalize( var_2 * ( 1, 1, 0 ) );
    var_3 = anglestoforward( var_0 * ( 0, 1, 0 ) );
    var_4 = vectordot( var_2, var_3 );
    var_4 = clamp( var_4, -1, 1 );
    var_5 = acos( var_4 ) / 90;
    var_6 = clamp( var_5, 0, 1 );
    var_6 = 1 - squared( var_6 );
    var_7 = ( 0, 0, 1 ) + var_1.bodyrollvelocity * maps\_utility::linear_interpolate( var_6, 0.0001, 0.0025 );
    var_8 = vectorcross( var_7, var_3 );
    var_9 = vectorcross( var_8, var_7 );
    var_10 = vectorcross( var_9, ( 0, 0, 1 ) );
    var_10 = vectornormalize( var_10 );
    var_11 = axistoangles( var_9, var_8 * -1, var_7 );
    updateviewmodelacceleration( var_10 );
    updateviewmodellookoffset( var_0 );
    var_1.lastplayerangles = level.player getangles();
    var_12 = getviewmodelrotation( var_1.framerollacceleration, var_6, var_9, 0.125 );
    updateviewmodelpitchoffset( getlookpitch() );
    var_13 = getviewmodelstrafeoffset();
    var_13 = ( 0, var_13[1] + var_1.horizontaloffsetlook, var_13[2] + var_1.verticaloffsetlook );
    var_1.frameviewmodel unlinkfromplayerview( level.player );
    var_1.frameviewmodel linktoplayerview( level.player, "tag_origin", var_1.frameviewmodeloffset + var_13, var_12 * ( 0, 0, 1 ), 1 );
    var_14 = getviewmodelrotation( var_1.barrelrollacceleration, var_6, var_9, 0.125 );
    var_1.barrelviewmodel unlinkfromplayerview( level.player );
    var_1.barrelviewmodel linktoplayerview( level.player, "tag_origin", var_1.barrelviewmodeloffset + var_13 * 0.5, var_14 * ( 0, 0, 1 ), 1 );
    return var_11;
}

angle_lerp( var_0, var_1, var_2 )
{
    return angleclamp( var_0 + angleclamp180( var_1 - var_0 ) * var_2 );
}

euler_lerp( var_0, var_1, var_2 )
{
    return ( angle_lerp( var_0[0], var_1[0], var_2 ), angle_lerp( var_0[1], var_1[1], var_2 ), angle_lerp( var_0[2], var_1[2], var_2 ) );
}

rumblesniperdronefire()
{
    level.player playrumbleonentity( "heavygun_fire" );
    earthquake( 0.1, 0.1, level.player.origin, 100 );
}

rumblesniperdronetakenout()
{
    level.player playrumbleonentity( "damage_heavy" );
    earthquake( 0.5, 1.0, level.player.origin, 100 );
}
