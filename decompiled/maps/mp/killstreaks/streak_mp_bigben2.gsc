// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    precacheshellshock( "iw5_dlcgun12loot5_mp" );
    precacherumble( "tank_rumble" );
    precacherumble( "heavygun_fire" );
    precacherumble( "smg_fire" );
    level.killstreakwieldweapons["iw5_dlcgun12loot5_mp"] = "mp_bigben2";

    if ( level.console )
        level.skylight_fire_fx = loadfx( "vfx/map/mp_bigben/mp_bigb_killstreak_screen_fire" );
    else
        level.skylight_fire_fx = loadfx( "vfx/map/mp_bigben/mp_bigb_killstreak_screen_fire_pc" );

    var_0 = getent( "rocket_startorg", "targetname" );
    var_1 = getent( "rocket_endorg", "targetname" );
    var_2 = getent( "camera_startorg", "targetname" );
    var_3 = getent( "camera_endorg", "targetname" );
    level.rocket_start = var_0.origin;
    level.rocket_start_angles = ( 270, 0, 0 );
    level.rocket_end = var_1.origin;
    level.camera_start = var_2.origin;
    level.camera_end = var_3.origin;
    level.skylight_actual_rocket = getent( "actual_rocket", "targetname" );
    level.skylight_camera_link = getent( "camera_linkto_main", "targetname" );
    level.skylight_actual_rocket.origin = level.rocket_start;
    level.skylight_actual_rocket.angles = level.rocket_start_angles;
    level.skylight_camera_link.origin = level.camera_start;
    level.skylight_camera_link setmodel( "tag_player" );
    level.skylight_rocket_fx_tag = spawn( "script_model", ( 0, 0, 0 ) );
    level.skylight_rocket_fx_tag setmodel( "tag_origin" );
    level.skylight_rocket_fx_tag linkto( level.skylight_actual_rocket, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.missileflighttime = 10;
    level.skylight_real_missile_number = 30;
    level.skylight_fx_missile_chance = 100;
    level.skylight_fx_missile_max = 30;
    level.skylight_missile_min_time = 0.2;
    level.skylight_missile_max_time = 0.4;

    if ( level.currentgen )
        level.skylight_fx_missile_chance = 0;

    level.killstreakfuncs["mp_bigben2"] = ::tryuseskylight;
    level.mapkillstreak = "mp_bigben2";
    level.mapkillstreakpickupstring = &"MP_BIGBEN2_MAP_KILLSTREAK_PICKUP";
    level.skylight_available = 1;
}

tryuseskylight( var_0, var_1 )
{
    if ( !skylight_available() )
    {
        self iprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    level.skylight_available = 0;
    var_2 = maps\mp\killstreaks\_killstreaks::initridekillstreak();

    if ( var_2 != "success" )
    {
        level.skylight_available = 1;
        return 0;
    }

    maps\mp\_utility::setusingremote( "mp_bigben2" );
    var_2 = setupskylightrocketstrike();
    maps\mp\_matchdata::logkillstreakevent( "dlc_streak4", self.origin );
    return var_2;
}

setupskylightrocketstrike()
{
    level notify( "skylight_start" );
    thread monitor_player_disconnect();
    thread monitor_player_team_change();
    thread monitor_game_ended();
    playeraddnotifycommands();
    thread skylight_rocket_control();
    thread skylight_monitor_timeout();
    thread skylight_play_rumble();
    thread skylight_cleanup_player();
    thread skylight_cleanup_rocket();
    thread skylight_rocket_animate();
    thread maps\mp\mp_bigben2_fx::stop_vista_vfx();
    thread skylight_monitor_fire();
    thread skylight_monitor_cancel();
    return 1;
}

monitor_player_disconnect()
{
    self endon( "skylight_cancel" );
    self endon( "skylight_payload_complete" );
    self waittill( "disconnect" );
    self notify( "skylight_cancel" );
}

monitor_player_team_change()
{
    self endon( "skylight_cancel" );
    self endon( "skylight_payload_complete" );
    common_scripts\utility::waittill_either( "joined_team", "joined_spectators" );
    self notify( "skylight_cancel" );
}

monitor_game_ended()
{
    self endon( "skylight_cancel" );
    self endon( "skylight_payload_complete" );
    level waittill( "game_ended" );
    self notify( "skylight_cancel" );
}

skylight_monitor_cancel()
{
    self endon( "skylight_control_over" );
    self endon( "skylight_cancel" );
    wait 0.3;
    var_0 = 5;

    for (;;)
    {
        self waittill( "ToggleControlState" );
        thread cancel_button_monitor();
        self.holdingleavebutton = 1;

        for ( var_1 = 0; var_1 <= var_0; var_1++ )
        {
            wait 0.1;

            if ( self.holdingleavebutton == 1 && var_1 == var_0 )
            {
                self notify( "skylight_cancel" );
                return;
            }
            else if ( self.holdingleavebutton == 0 )
                break;
        }
    }
}

cancel_button_monitor()
{
    self endon( "skylight_control_over" );
    self endon( "skylight_cancel" );
    self waittill( "ToggleControlCancel" );
    self.holdingleavebutton = 0;
}

skylight_monitor_timeout()
{
    self endon( "skylight_control_over" );
    self endon( "skylight_cancel" );
    wait(level.missileflighttime);
    self notify( "skylight_fire_timeout" );
}

skylight_monitor_fire()
{
    self endon( "skylight_cancel" );
    wait 0.3;
    common_scripts\utility::waittill_any( "StartFire", "skylight_fire_timeout" );
    self playlocalsound( "bb_missile_launch_pod_midair_exp" );
    var_0 = self getangles();
    var_1 = anglestoforward( var_0 );
    var_2 = level.skylight_camera_link.origin;
    var_3 = var_2 + var_1 * 12000;
    var_4 = bullettrace( var_2, var_3, 0, level.skylight_actual_rocket );
    var_5 = var_4["position"];
    self playrumbleonentity( "heavygun_fire" );
    earthquake( 0.4, 1, level.skylight_camera_link.origin, 2000, self );
    wait 0.2;
    self notify( "skylight_control_over" );
    thread fire_missiles( var_5 );
}

skylight_cleanup_player()
{
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "skylight_control_over", "skylight_cancel" );
    playerremovenotifycommands();
    self enableweaponswitch();
    self unlink();
    self setclientomnvar( "fov_scale", 1.0 );
    self disableslowaim();
    self setclientomnvar( "ui_solar_beam", 0 );
    self thermalvisionfofoverlayoff();
    level.skylight_fire_fx_ent delete();

    if ( maps\mp\_utility::isusingremote() )
        maps\mp\_utility::clearusingremote();

    thread removeskylightvisionandlightsetpermap( 0.5 );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::setthirdpersondof( 1 );

    maps\mp\_utility::playerrestoreangles();
}

skylight_cleanup_rocket()
{
    common_scripts\utility::waittill_any( "skylight_cancel", "skylight_payload_complete" );
    wait 0.1;
    playfx( common_scripts\utility::getfx( "mp_bigb_killstreak_rocket_explosion" ), level.skylight_actual_rocket.origin );
    stopfxontag( common_scripts\utility::getfx( "mp_bigb_killstreak_rockettrail" ), level.skylight_rocket_fx_tag, "tag_origin" );
    level.skylight_actual_rocket scriptmodelclearanim();
    wait 0.1;
    level.skylight_actual_rocket.origin = level.rocket_start;
    level.skylight_actual_rocket.angles = level.rocket_start_angles;
    level.skylight_camera_link.origin = level.camera_start;
    level.skylight_available = 1;
}

skylight_available()
{
    return level.skylight_available;
}

playeraddnotifycommands()
{
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "SwitchVisionMode", "+actionslot 1" );
        self notifyonplayercommand( "ToggleControlState", "+activate" );
        self notifyonplayercommand( "ToggleControlCancel", "-activate" );
        self notifyonplayercommand( "ToggleControlState", "+usereload" );
        self notifyonplayercommand( "ToggleControlCancel", "-usereload" );
        self notifyonplayercommand( "StartFire", "+attack" );
        self notifyonplayercommand( "StartFire", "+attack_akimbo_accessible" );
    }
}

playerremovenotifycommands()
{
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "SwitchVisionMode", "+actionslot 1" );
        self notifyonplayercommandremove( "ToggleControlState", "+activate" );
        self notifyonplayercommandremove( "ToggleControlCancel", "-activate" );
        self notifyonplayercommandremove( "ToggleControlState", "+usereload" );
        self notifyonplayercommandremove( "ToggleControlCancel", "-usereload" );
        self notifyonplayercommandremove( "StartFire", "+attack" );
        self notifyonplayercommandremove( "StartFire", "+attack_akimbo_accessible" );
    }
}

setskylightvisionandlightsetpermap( var_0 )
{
    self endon( "skylight_cancel" );
    self endon( "game_ended" );
    self endon( "OrbitalStrikeStreakComplete" );
    wait(var_0);

    if ( isdefined( level.vulcanvisionset ) )
        self setclienttriggervisionset( level.vulcanvisionset, 0 );

    if ( isdefined( level.vulcanlightset ) )
        self lightsetforplayer( level.vulcanlightset );

    maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

removeskylightvisionandlightsetpermap( var_0 )
{
    self setclienttriggervisionset( "", var_0 );
    self lightsetforplayer( "" );
    maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}

skylight_play_rumble()
{
    self endon( "skylight_cancel" );
    self endon( "skylight_control_over" );
    thread skylight_play_rumble_on_all_players();
    wait 0.1;
    earthquake( 0.4, 3, level.skylight_camera_link.origin, 2000, self );
    wait 0.1;
    earthquake( 0.2, 15, ( 4176.5, 14000, 18000 ), 20000, self );
    wait 0.5;
    self playrumbleonentity( "heavygun_fire" );
    thread skylight_loop_rumble( 20 );
}

skylight_play_rumble_on_all_players()
{
    foreach ( var_1 in level.players )
    {
        if ( var_1 != self )
        {
            earthquake( 0.3, 3, level.rocket_start, 3500, var_1 );
            var_1 playrumblelooponentity( "tank_rumble" );
            var_1 thread skylight_end_rumble_loop( 0.8 );

            if ( distancesquared( level.rocket_start, var_1.origin ) < 1000000 )
            {
                var_1 playrumbleonentity( "heavygun_fire" );
                continue;
            }

            if ( distancesquared( level.rocket_start, var_1.origin ) < 4000000 )
                var_1 playrumbleonentity( "smg_fire" );
        }
    }
}

skylight_loop_rumble( var_0 )
{
    self endon( "skylight_cancel" );
    self endon( "skylight_control_over" );

    while ( var_0 > 0.0 )
    {
        self playrumbleonentity( "smg_fire" );
        var_0 -= 0.2;
        wait 0.2;
    }
}

skylight_end_rumble_loop( var_0 )
{
    self endon( "death" );
    level common_scripts\utility::waittill_notify_or_timeout( "game_ended", var_0 );
    self stoprumble( "tank_rumble" );
}

skylight_rocket_control()
{
    self disableweaponswitch();
    self setclientomnvar( "fov_scale", 0.5 );
    self enableslowaim( 0.5, 0.5 );
    self thermalvisionfofoverlayon();
    level.skylight_camera_link moveto( level.camera_end, level.missileflighttime, 1, 0 );
    self playerlinkweaponviewtodelta( level.skylight_camera_link, "tag_player", 1, 60, 60, -30, 75, 1 );
    thread setskylightvisionandlightsetpermap( 0.5 );
    maps\mp\_utility::playersaveangles();
    self setangles( ( 40, 270, 0 ) );
    self setclientomnvar( "ui_solar_beam", 1 );
    var_0 = gettime() + level.missileflighttime * 1000;
    self setclientomnvar( "ui_solar_beam_timer", var_0 );
    level.skylight_fire_fx_ent = spawnlinkedfxforclient( level.skylight_fire_fx, level.skylight_camera_link, "tag_player", self );
    setfxkillondelete( level.skylight_fire_fx_ent, 1 );
    triggerfx( level.skylight_fire_fx_ent );
    thread aud_skylight_launch_sfx();
    thread aud_skylight_launch_sfx_3d();
}

aud_skylight_launch_sfx()
{
    self endon( "disconnect" );
    wait 0.2;
    self playlocalsound( "bb_missile_launch_pod_midair_exp" );
    wait 0.2;
    self playlocalsound( "paladin_toggle_flir_plr" );
    self playlocalsound( "bb_missile_jet_pov_effit" );
    common_scripts\utility::waittill_any( "skylight_control_over", "skylight_cancel" );
    self stopsounds();
}

aud_skylight_launch_sfx_3d()
{
    wait 0.2;
    self playsound( "bb_missile_launch_pod_midair_exp_3d" );
    self playsound( "bb_missile_low_3d" );
    wait 0.2;
    self playsound( "bb_missile_jet_pov_effit_3d" );
    common_scripts\utility::waittill_any( "skylight_control_over", "skylight_cancel" );
    self stopsounds();
}

skylight_rocket_animate()
{
    self endon( "skylight_cancel" );
    wait 0.1;
    level.skylight_actual_rocket scriptmodelplayanimdeltamotion( "bbn_skylight_rocket_launch" );

    foreach ( var_1 in level.players )
    {
        if ( var_1 != self )
            playfxontagforclients( common_scripts\utility::getfx( "mp_bigb_killstreak_rockettrail" ), level.skylight_rocket_fx_tag, "tag_origin", var_1 );
    }
}

fire_missiles( var_0 )
{
    self endon( "skylight_cancel" );
    var_1 = 0;
    wait(randomfloatrange( level.skylight_missile_min_time, level.skylight_missile_max_time ));
    var_2 = magicbullet( "iw5_dlcgun12loot5_mp", level.skylight_actual_rocket.origin, var_0, self );
    wait 0.1;

    if ( randomint( 100 ) <= level.skylight_fx_missile_chance && var_1 < level.skylight_fx_missile_max )
    {
        var_1++;
        var_3 = vectortoangles( level.skylight_actual_rocket.origin - var_0 );
        var_4 = anglestoforward( var_3 );
        playfx( common_scripts\utility::getfx( "mp_bigb_killstreak_curvy_missile" ), level.skylight_actual_rocket.origin, var_4 );
    }

    maps\mp\_audio::snd_play_in_space( "paladin_cannon_snap", level.skylight_actual_rocket.origin );

    for ( var_5 = 1; var_5 < level.skylight_real_missile_number; var_5++ )
    {
        wait(randomfloatrange( level.skylight_missile_min_time - 0.1, level.skylight_missile_max_time - 0.1 ));
        var_6 = randomfloatrange( -400, 400 );
        var_7 = randomfloatrange( -400, 400 );
        var_2 = magicbullet( "iw5_dlcgun12loot5_mp", level.skylight_actual_rocket.origin, var_0 + ( var_6, var_7, 0 ), self );
        wait 0.1;

        if ( randomint( 100 ) <= level.skylight_fx_missile_chance && var_1 < level.skylight_fx_missile_max )
        {
            var_1++;
            var_3 = vectortoangles( level.skylight_actual_rocket.origin - var_0 + ( var_6, var_7, 0 ) );
            var_4 = anglestoforward( var_3 );
            playfx( common_scripts\utility::getfx( "mp_bigb_killstreak_curvy_missile" ), level.skylight_actual_rocket.origin, var_4 );
        }

        maps\mp\_audio::snd_play_in_space( "paladin_cannon_snap", level.skylight_actual_rocket.origin );
    }

    self notify( "skylight_payload_complete" );
}
