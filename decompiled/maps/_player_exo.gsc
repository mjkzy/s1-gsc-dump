// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    if ( isdefined( var_0 ) )
    {
        var_0 = tolower( var_0 );

        if ( var_0 != "assault" && var_0 != "specialist" )
            var_0 = undefined;
    }

    player_exo_init( var_0, var_1 );
    level thread maps\_upgrade_system::init();

    if ( !isdefined( var_2 ) || var_2 == 1 )
        player_exo_activate();
}

player_exo_init( var_0, var_1 )
{
    precacheshader( "objective_onscreen" );
    precacheshader( "ui_circle" );
    precacheshader( "dpad_icon_overdrive" );
    precacheshader( "dpad_icon_overdrive_off" );
    level._effect["grenade_indicator_danger"] = loadfx( "vfx/ui/grenade_indicator_danger" );
    precacheshader( "dpad_icon_stim" );
    precacheshader( "dpad_icon_stim_off" );
    level._effect["exo_stim"] = loadfx( "vfx/ui/ui_exo_health_overlay_sp" );
    precacheshellshock( "wb_player_boost" );
    precacheshader( "ugv_vignette_overlay" );
    precachestring( &"update_overdrive" );
    level.player maps\_utility::playerallowalternatemelee( 0 );
    thread handle_weaponhud_visibility();
    maps\_sonicaoe::initsonicaoe();
    setsaveddvar( "high_jump_double_tap", "1" );
    thread maps\_player_high_jump::main();

    if ( !isdefined( level.player.exclusive ) )
        level.player.exclusive = [];

    if ( !isdefined( level.player.exo_old_values ) )
        level.player.exo_old_values = [];

    level.exosetfuncs = [];
    level.exounsetfuncs = [];
    level.player.exclusive["show_grenades"] = 0;
    level.exosetfuncs["show_grenades"] = ::setshowgrenades;
    level.exounsetfuncs["show_grenades"] = ::unsetshowgrenades;
    level.player.exclusive["friendly_detection"] = 1;
    level.exosetfuncs["friendly_detection"] = ::setfriendlydetection;
    level.exounsetfuncs["friendly_detection"] = ::unsetfriendlydetection;
    level.player.exclusive["enemy_detection"] = 0;
    level.exosetfuncs["enemy_detection"] = ::setenemydetection;
    level.exounsetfuncs["enemy_detection"] = ::unsetenemydetection;
    level.player.exclusive["move_speed_increase"] = 0;
    level.exosetfuncs["move_speed_increase"] = ::setmovespeedincrease;
    level.exounsetfuncs["move_speed_increase"] = ::unsetmovespeedincrease;
    level.player.exclusive["jump_increase"] = 0;
    level.exosetfuncs["jump_increase"] = ::setjumpincrease;
    level.exounsetfuncs["jump_increase"] = ::unsetjumpincrease;
    level.player.exclusive["boost_dash"] = 1;
    level.exosetfuncs["boost_dash"] = ::setboostdash;
    level.exounsetfuncs["boost_dash"] = ::unsetboostdash;
    level.player.exclusive["overdrive"] = 0;
    overdrive_initialize_params();
    level.exosetfuncs["overdrive"] = ::setoverdrive;
    level.exounsetfuncs["overdrive"] = ::unsetoverdrive;
    level.player.exclusive["intel_mode"] = 1;
    level.exosetfuncs["intel_mode"] = ::setintelmode;
    level.exounsetfuncs["intel_mode"] = ::unsetintelmode;
    level.player.exclusive["exo_melee"] = 1;
    level.exosetfuncs["exo_melee"] = ::setexomelee;
    level.exounsetfuncs["exo_melee"] = ::unsetexomelee;
    level.player.exclusive["exo_slide"] = 1;
    level.exosetfuncs["exo_slide"] = ::setexoslide;
    level.exounsetfuncs["exo_slide"] = ::unsetexoslide;
    level.player.exclusive["exo_slam"] = 0;
    init_ground_slam();
    level.exosetfuncs["exo_slam"] = ::setexoslam;
    level.exounsetfuncs["exo_slam"] = ::unsetexoslam;
    level.player.exclusive["sonic_blast"] = 0;
    level.exosetfuncs["sonic_blast"] = ::setsonicblast;
    level.exounsetfuncs["sonic_blast"] = ::unsetsonicblast;
    level.player.exclusive["high_jump"] = 0;
    level.exosetfuncs["high_jump"] = ::sethighjump;
    level.exounsetfuncs["high_jump"] = ::unsethighjump;
    level.player.exclusive["exo_stim"] = 0;
    level.exosetfuncs["exo_stim"] = ::setstim;
    level.exounsetfuncs["exo_stim"] = ::unsetstim;
    level.player.exclusive["shield"] = 0;
    maps\_exo_shield_sp::init();
    level.exosetfuncs["shield"] = ::setshield;
    level.exounsetfuncs["shield"] = ::unsetshield;
    level.player.exobatteryabilities = [ "overdrive", "sonic_blast" ];
    level.player.exospeedscalars = [];
    batteryinit();
    level.player.exo_active = 0;
    level.player.exoactivated = [];

    if ( isdefined( var_0 ) )
    {
        if ( var_0 == "assault" )
        {
            level.player.exclusive["high_jump"] = 1;
            level.player.exclusive["exo_slam"] = 1;
            level.player.exclusive["sonic_blast"] = 1;
        }
        else if ( var_0 == "specialist" )
        {
            level.player.exclusive["overdrive"] = 1;
            level.player.exclusive["shield"] = 1;
        }
    }

    if ( isdefined( var_1 ) && var_1 )
        level.player.exclusive["exo_stim"] = 1;
}

player_exo_activate_single_internal( var_0 )
{
    if ( !isdefined( level.player.exoactivated[var_0] ) && isdefined( level.exosetfuncs[var_0] ) )
    {
        if ( common_scripts\utility::array_contains( level.player.exobatteryabilities, var_0 ) )
            batterymetervisible( var_0, 1 );

        level.player thread [[ level.exosetfuncs[var_0] ]]();
        level.player.exoactivated[var_0] = 1;
    }
}

player_exo_deactivate_single_internal( var_0 )
{
    if ( isdefined( level.player.exoactivated[var_0] ) && isdefined( level.exosetfuncs[var_0] ) )
    {
        if ( common_scripts\utility::array_contains( level.player.exobatteryabilities, var_0 ) )
            batterymetervisible( var_0, 0 );

        level.player thread [[ level.exounsetfuncs[var_0] ]]();
        level.player.exoactivated[var_0] = undefined;
    }
}

player_exo_is_active_single( var_0 )
{
    return level.player.exclusive[var_0] == 1;
}

player_exo_is_active_single_internal( var_0 )
{
    return isdefined( level.player.exoactivated[var_0] );
}

player_exo_is_active()
{
    return level.player.exo_active;
}

player_exo_activate()
{
    level.player.exo_active = 1;
    var_0 = getarraykeys( level.player.exclusive );

    foreach ( var_2 in var_0 )
    {
        if ( level.player.exclusive[var_2] )
            player_exo_activate_single_internal( var_2 );
    }
}

player_exo_deactivate()
{
    level.player.exo_active = 0;
    var_0 = getarraykeys( level.player.exclusive );

    foreach ( var_2 in var_0 )
        player_exo_deactivate_single_internal( var_2 );
}

player_exo_add_single( var_0 )
{
    level.player.exclusive[var_0] = 1;

    if ( level.player.exo_active )
        player_exo_activate_single_internal( var_0 );
}

player_exo_remove_single( var_0 )
{
    if ( player_exo_is_active_single( var_0 ) )
    {
        level.player.exclusive[var_0] = 0;
        player_exo_deactivate_single_internal( var_0 );
    }
}

player_exo_get_owned_array( var_0 )
{
    var_1 = getarraykeys( level.player.exclusive );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( level.player.exclusive[var_4] && ( !isdefined( var_0 ) || common_scripts\utility::array_contains( var_0, var_4 ) ) )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

player_exo_get_unowned_array( var_0 )
{
    var_1 = getarraykeys( level.player.exclusive );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( !level.player.exclusive[var_4] && ( !isdefined( var_0 ) || common_scripts\utility::array_contains( var_0, var_4 ) ) )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

player_exo_set_owned_array( var_0 )
{
    var_1 = getarraykeys( level.player.exclusive );

    foreach ( var_3 in var_1 )
    {
        if ( common_scripts\utility::array_contains( var_0, var_3 ) )
        {
            player_exo_add_single( var_3 );
            continue;
        }

        player_exo_remove_single( var_3 );
    }
}

player_exo_add_array( var_0 )
{
    foreach ( var_2 in var_0 )
        player_exo_add_single( var_2 );
}

player_exo_remove_array( var_0 )
{
    foreach ( var_2 in var_0 )
        player_exo_remove_single( var_2 );
}

setshowgrenades()
{
    maps\_utility::add_global_spawn_function( "axis", ::monitor_grenades );
    common_scripts\utility::array_thread( getaiarray( "axis" ), ::monitor_grenades );
    maps\_utility::add_global_spawn_function( "allies", ::monitor_grenades );
    common_scripts\utility::array_thread( getaiarray( "allies" ), ::monitor_grenades );

    foreach ( var_1 in level.players )
        var_1 thread monitor_grenades();
}

unsetshowgrenades()
{
    level notify( "stop_monitoring_grenades" );
    maps\_utility::remove_global_spawn_function( "axis", ::monitor_grenades );
    maps\_utility::remove_global_spawn_function( "allies", ::monitor_grenades );
}

monitor_grenades()
{
    self endon( "death" );
    level endon( "stop_monitoring_grenades" );

    for (;;)
    {
        var_0 = undefined;
        var_1 = 0;

        if ( isplayer( self ) )
        {
            self waittill( "grenade_pullback", var_2 );

            if ( var_2 == "fraggrenade" )
                var_1 = gettime();
            else
                var_1 = undefined;

            self waittill( "grenade_fire", var_0, var_2 );

            if ( !isdefined( var_1 ) )
                var_1 = gettime();

            var_0.spawn_time = var_1;
            var_0 thread grenade_tracking( 1, var_2 );
            continue;
        }

        self waittill( "grenade_fire", var_0, var_2 );
        var_0.spawn_time = gettime();
        var_0 thread grenade_tracking( 0, var_2 );
    }
}

grenade_tracking( var_0, var_1 )
{
    thread grenade_display_time_remaining( var_0, var_1 );
}

grenade_display_time_remaining( var_0, var_1 )
{
    self endon( "death" );
    level endon( "stop_monitoring_grenades" );
    thread grenade_indicator_fx();
}

grenade_indicator_fx()
{
    level endon( "stop_monitoring_grenades" );
    wait 0.5;

    if ( !isdefined( self ) )
        return;

    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = self.origin;
    var_0.angles = ( -90, 0, 0 );
    playfxontag( common_scripts\utility::getfx( "grenade_indicator_danger" ), var_0, "tag_origin" );

    while ( isdefined( self ) )
    {
        var_1 = bullettrace( self.origin, self.origin - ( 0, 0, 1000 ), 0, self, 0, 0 );
        var_0.origin = var_1["position"] + ( 0, 0, 2 );
        wait 0.05;
    }

    killfxontag( common_scripts\utility::getfx( "grenade_indicator_danger" ), var_0, "tag_origin" );
    wait 0.05;
    var_0 delete();
}

setdefaulthudoutlinestyle()
{
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinewidth", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 2 );
    setsaveddvar( "r_hudoutlinehalolumscale", 1.5 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 0.35 );
}

setharmonicbreachhudoutlinestyle()
{
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinecurvywidth", 1 );
    setsaveddvar( "r_hudoutlinecurvywhen", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 3 );
    setsaveddvar( "r_hudoutlinecurvylumscale", 2 );
    setsaveddvar( "r_hudoutlinecurvydarkenscale", 0.25 );
    setsaveddvar( "r_hudoutlinecurvyblurradius", 0.5 );
    setsaveddvar( "r_hudoutlinecurvydepth", 0.8 );
}

setfriendlydetection()
{
    var_0 = 3;
    common_scripts\utility::array_thread( getaiarray( "allies" ), ::ai_detection, var_0 );
    maps\_utility::add_global_spawn_function( "allies", ::ai_detection, var_0 );
    setdefaulthudoutlinestyle();
    thread monitor_ai_detection();
}

unsetfriendlydetection()
{
    level notify( "stop_ai_detection" );
    maps\_utility::remove_global_spawn_function( "allies", ::ai_detection );
}

setenemydetection()
{
    var_0 = 1;
    common_scripts\utility::array_thread( getaiarray( "axis" ), ::ai_detection, var_0 );
    maps\_utility::add_global_spawn_function( "axis", ::ai_detection, var_0 );
    setdefaulthudoutlinestyle();
    thread monitor_ai_detection();
}

unsetenemydetection()
{
    level notify( "stop_ai_detection" );
    maps\_utility::remove_global_spawn_function( "axis", ::ai_detection );
}

ai_detection( var_0 )
{
    level endon( "stop_ai_detection" );
    self endon( "death" );
    self.highlight_on = 0;
    var_1 = 0;
    thread clear_ai_detection_on_death();

    for (;;)
    {
        if ( ( !isdefined( self.cloak ) || self.cloak == "off" ) && ( !isdefined( self.subclass ) || self.subclass != "mech" ) )
        {
            if ( !isdefined( level.player.sonar_vision ) || !level.player.sonar_vision )
            {
                if ( self.highlight_on != var_1 )
                {
                    if ( self.highlight_on )
                        self hudoutlineenable( var_0, 1 );
                    else
                        self hudoutlinedisable();

                    var_1 = self.highlight_on;
                }
            }
        }

        wait 0.05;
    }
}

clear_ai_detection_on_death()
{
    common_scripts\utility::waittill_any_ents( self, "death", level, "stop_ai_detection" );

    if ( isdefined( self ) )
    {
        if ( ( !isdefined( self.cloak ) || self.cloak == "off" ) && ( !isdefined( self.subclass ) || self.subclass != "mech" ) )
        {
            self.highlight_on = 0;
            self hudoutlinedisable();
        }
    }
}

monitor_ai_detection()
{
    level endon( "stop_ai_detection" );
    var_0 = 1024;

    for (;;)
    {
        if ( self playerads() > 0.1 )
        {
            var_1 = bullettrace( self geteye(), self geteye() + anglestoforward( self getgunangles() ) * var_0, 1, self );
            var_2 = var_1["entity"];

            if ( isdefined( var_2 ) && isai( var_2 ) )
            {
                var_2.highlight_on = 1;
                var_2 thread ai_detection_timeout();
            }
        }

        wait 0.05;
    }
}

ai_detection_timeout()
{
    self notify( "new_highlight" );
    self endon( "new_highlight" );
    self endon( "death" );
    wait 0.1;
    self.highlight_on = 0;
}

setmovespeedincrease()
{
    level.player.exospeedscalars["move_speed_increase"] = 1.25;
    exo_move_speed_update();
}

unsetmovespeedincrease()
{
    level.player.exospeedscalars["move_speed_increase"] = undefined;
    exo_move_speed_update();
}

setjumpincrease()
{
    self.exo_old_values["jump_height"] = getdvarint( "jump_height" );
    setsaveddvar( "jump_height", "60" );
}

unsetjumpincrease()
{
    setsaveddvar( "jump_height", self.exo_old_values["jump_height"] );
}

setboostdash()
{
    level.player allowdodge( 1 );
}

unsetboostdash()
{
    level.player allowdodge( 0 );
}

boost_dash_track_player_movement()
{
    self endon( "death" );
    self endon( "disable_boost_dash" );

    if ( !isdefined( self.boost["stick_input"] ) )
        self.boost["stick_input"] = ( 0, 0, 0 );

    if ( !isdefined( self.boost["stick_global"] ) )
        self.boost["stick_global"] = ( 0, 0, 0 );

    for (;;)
    {
        var_0 = self getnormalizedmovement();
        var_0 = ( var_0[0], var_0[1] * -1, 0 );
        var_1 = self.angles;
        var_2 = vectortoangles( var_0 );
        var_3 = common_scripts\utility::flat_angle( combineangles( var_1, var_2 ) );
        var_4 = anglestoforward( var_3 ) * length( var_0 );
        self.boost["stick_input"] = var_2;
        self.boost["stick_global"] = var_4;
        wait 0.05;
    }
}

boost_dash_track_player_velocity()
{
    self endon( "death" );
    self endon( "disable_boost_dash" );

    if ( !isdefined( self.boost["player_vel"] ) )
        self.boost["player_vel"] = ( 0, 0, 0 );

    for (;;)
    {
        self.boost["player_vel"] = self getvelocity();
        wait 0.05;
    }
}

boost_dash_think()
{
    self endon( "death" );
    self endon( "disable_boost_dash" );
    var_0 = 400;
    var_1 = ( 0, 0, 250 );
    var_2 = 10;
    var_3 = 500;
    var_4 = 1;

    for (;;)
    {
        waittill_dash_button_pressed();
        var_5 = 0;

        if ( self isonground() && !self adsbuttonpressed() && level.player getstance() != "prone" )
        {
            if ( self.boost["stick_input"][0] > 0 )
            {

            }
            else if ( self.boost["stick_input"][1] > 315 || self.boost["stick_input"][1] < 45 )
            {

            }
            else
            {
                thread boost_dash( var_0, var_1, var_2, var_4, var_3 );
                var_5 = 1;
            }
        }

        waittill_dash_button_released( var_5 );
    }
}

enable_boost_attack()
{
    self endon( "mode_switch" );
    self endon( "death" );
    var_0 = 300;
    var_1 = 1000;
    var_2 = ( 0, 0, 350 );
    var_3 = 0.5;
    var_4 = 1;
    var_5 = 1;

    for (;;)
    {
        if ( self sprintbuttonpressed() && self meleebuttonpressed() )
        {
            if ( self.boost["stick_input"][1] > 315 || self.boost["stick_input"][1] < 45 )
            {
                boost_attack( var_0, var_2, var_3, var_4, var_1 );
                wait 1;
            }
        }

        wait 0.05;
    }
}

boost_dash( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "mode_switch" );
    self endon( "death" );
    level.player soundscripts\_snd::snd_message( "boost_dodge_activate_plr" );
    self.boost["inboost"] = 1;
    var_6 = self.boost["stick_global"];
    var_7 = self.boost["player_vel"] * var_2;

    if ( var_7[2] > 0 )
        var_7 = ( var_7[0], var_7[1], 0 );

    var_8 = var_7 + var_6 * var_0 + var_1;

    if ( isdefined( var_3 ) && var_3 )
    {
        if ( !isdefined( var_4 ) )
            var_9 = var_1[2];

        var_10 = var_8;
        var_8 = vectornormalize( var_8 ) * var_4;
        var_8 = ( var_8[0], var_8[1], var_10[2] );

        if ( var_6[2] == 0 )
        {
            var_11 = 0.7;
            var_8 = ( var_8[0], var_8[1], var_8[2] * var_11 );
        }
    }

    var_12 = 2;

    if ( isdefined( var_5 ) && var_5 )
    {
        var_13 = 0;
        var_14 = self.boost["player_vel"];
        var_15 = var_8;
        var_16 = var_15 - var_14;

        for ( var_17 = var_16 / var_12; var_13 <= var_12; var_13++ )
        {
            self setvelocity( var_14 + var_17 );
            wait 0.05;
        }
    }

    self setvelocity( var_8 );
}

boost_attack( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "mode_switch" );
    self endon( "death" );
    thread boost_attack_deal_damage();
    self.boost["inboost"] = 1;
    var_6 = self.boost["stick_global"];
    var_7 = self.boost["player_vel"] * var_2;

    if ( var_7[2] > 0 )
        var_7 = ( var_7[0], var_7[1], 0 );

    var_8 = var_7 + var_6 * var_0 + var_1;

    if ( isdefined( var_3 ) && var_3 )
    {
        if ( !isdefined( var_4 ) )
            var_9 = var_1[2];

        var_10 = var_8;
        var_8 = vectornormalize( var_8 ) * var_4;
        var_8 = ( var_8[0], var_8[1], var_10[2] );

        if ( var_6[2] == 0 )
        {
            var_11 = 0.7;
            var_8 = ( var_8[0], var_8[1], var_8[2] * var_11 );
        }
    }

    var_12 = 2;

    if ( isdefined( var_5 ) && var_5 )
    {
        var_13 = 0;
        var_14 = self.boost["player_vel"];
        var_15 = var_8;
        var_16 = var_15 - var_14;

        for ( var_17 = var_16 / var_12; var_13 <= var_12; var_13++ )
        {
            self setvelocity( var_14 + var_17 );
            wait 0.05;
        }
    }

    self setvelocity( var_8 );
}

boost_attack_deal_damage()
{
    while ( self isonground() )
        wait 0.05;

    while ( !self isonground() )
    {
        var_0 = getaiarray( "axis" );

        foreach ( var_2 in var_0 )
        {
            if ( isalive( var_2 ) )
            {
                if ( distance2d( self.origin, var_2.origin ) < 40 )
                    var_2 dodamage( var_2.health + 1, self.origin, self, self, "MOD_MELEE" );
            }
        }

        wait 0.05;
    }
}

waittill_dash_button_pressed()
{
    self endon( "death" );

    while ( !self sprintbuttonpressed() )
        wait 0.05;

    return 1;
}

waittill_dash_button_released( var_0 )
{
    var_1 = gettime();
    self endon( "death" );

    while ( self sprintbuttonpressed() )
        wait 0.05;

    if ( isdefined( var_0 ) )
    {
        if ( gettime() - var_1 < var_0 * 1000 )
            wait(var_0 - ( gettime() - var_1 ) / 1000);
    }

    return 1;
}

getdefaultoverdrivespeedscale()
{
    return 1.2;
}

setoverdrive()
{
    update_overdrive_icon();
    childthread overdrive_think();
    setomnvar( "ui_overdrive_effects", 1 );
}

unsetoverdrive()
{
    overdrive_disable();
    level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_overdrive_off" );
    setomnvar( "ui_overdrive_effects", 0 );
}

overdrive_updatebar( var_0 )
{
    setomnvar( "ui_overdrive_value", int( var_0 * 100 ) );
}

overdrive_initialize_params()
{
    if ( !isdefined( level.player.exoparams ) )
        level.player.exoparams = [];

    if ( !isdefined( level.player.exoparams["overdrive"] ) )
        level.player.exoparams["overdrive"] = spawnstruct();

    var_0 = level.player.exoparams["overdrive"];
    var_0.duration = 5;
    var_0.kick_in_duration = 0.5;
    var_0.kick_out_duration = 1;
    var_0.fail_duration = 0.5;
    var_0.cool_down_duration = 1;
    var_0.speed_scale = 1.2;
    var_0.action_slot_num = 1;
    var_0.battery_cost = 1;
    var_0.cooldownstate = spawnstruct();
    var_0.cooldownstate.currenttime = 1;
    var_0.cooldownstate.totaltime = 1;
    var_0.cooldownstate.state = "none";
}

overdrive_think()
{
    var_0 = self.exoparams["overdrive"];
    self endon( "death" );
    self endon( "overdrive_disabled" );
    var_0 = level.player.exoparams["overdrive"];

    if ( !maps\_utility::ent_flag_exist( "overdrive_enabled" ) )
        maps\_utility::ent_flag_init( "overdrive_enabled" );

    if ( !maps\_utility::ent_flag_exist( "overdrive_hot" ) )
        maps\_utility::ent_flag_init( "overdrive_hot" );

    if ( !maps\_utility::ent_flag_exist( "overdrive_on" ) )
        maps\_utility::ent_flag_init( "overdrive_on" );

    overdrive_enable();
    overdrive_updatebar( 1 );

    for (;;)
    {
        self waittill( "overdrive_button_pressed" );

        if ( maps\_utility::ent_flag( "overdrive_enabled" ) )
        {
            if ( maps\_utility::ent_flag( "overdrive_hot" ) )
            {

            }
            else if ( maps\_utility::ent_flag( "overdrive_on" ) )
            {
                childthread overdrive_force_stop( 0.1 );
                wait(var_0.kick_out_duration);
            }
            else if ( batteryspend( var_0.battery_cost ) )
            {
                childthread overdrive_start();
                wait(var_0.kick_in_duration);
            }
            else
                wait(var_0.fail_duration);

            continue;
        }
    }
}

overdrive_enable()
{
    var_0 = self.exoparams["overdrive"];

    if ( !maps\_utility::ent_flag( "overdrive_enabled" ) )
    {
        maps\_utility::ent_flag_set( "overdrive_enabled" );
        self notifyonplayercommand( "overdrive_button_pressed", "+actionslot " + var_0.action_slot_num );
    }
}

overdrive_disable()
{
    var_0 = self.exoparams["overdrive"];

    if ( maps\_utility::ent_flag_exist( "overdrive_enabled" ) && maps\_utility::ent_flag( "overdrive_enabled" ) )
    {
        self notify( "overdrive_disabled" );

        if ( overdrive_is_on() )
            thread overdrive_effects_stop();

        maps\_utility::ent_flag_clear( "overdrive_on" );
        maps\_utility::ent_flag_clear( "overdrive_hot" );
        maps\_utility::ent_flag_clear( "overdrive_enabled" );

        if ( !isdefined( self.exohuditem ) )
            self.exohuditem = [];
        else
            self.exohuditem = common_scripts\utility::array_removeundefined( self.exohuditem );

        maps\_utility::deep_array_thread( self.exohuditem, maps\_hud_util::destroyelem );
        self notifyonplayercommandremove( "overdrive_button_pressed", "+actionslot " + var_0.action_slot_num );
    }
}

overdrive_is_enabled()
{
    return maps\_utility::ent_flag( "overdrive_enabled" );
}

overdrive_is_on()
{
    return maps\_utility::ent_flag( "overdrive_on" );
}

overdrive_force_start()
{
    self notify( "overdrive_button_pressed" );
}

overdrive_start()
{
    self endon( "death" );

    if ( maps\_utility::ent_flag( "overdrive_on" ) )
        return;

    maps\_utility::ent_flag_set( "overdrive_on" );
    childthread overdrive_effects_start();
    overdrive_heatup();
    childthread overdrive_effects_stop();
    maps\_utility::ent_flag_clear( "overdrive_on" );
    overdrive_cooldown();
}

overdrive_manage_fov( var_0, var_1 )
{
    level.player lerpfovscale( var_1, var_0 );
    level.player notifyonplayercommand( "ads_start", "+speed_throw" );
    level.player notifyonplayercommand( "ads_stop", "-speed_throw" );
    var_2 = 0.2;

    for (;;)
    {
        if ( !level.player playerads() > 0.2 )
            level.player waittill( "ads_start" );

        level.player lerpfovscale( 1, var_2 );
        level.player waittill( "ads_stop" );
        level.player lerpfovscale( var_1, var_2 );
    }
}

overdrive_effects_start()
{
    self endon( "overdrive_effects_stop" );
    var_0 = self.exoparams["overdrive"];
    level.player.exospeedscalars["overdrive"] = var_0.speed_scale;
    exo_move_speed_update();
    player_regen_scale( 4 );
    level.vision_default = getdvar( "vision_set_current" );
    level.specular_default = getdvarfloat( "r_specularcolorscale" );
    visionsetoverdrive( "wb_player_boost", var_0.kick_in_duration );
    soundscripts\_snd::snd_message( "overdrive_on" );
    maps\_utility::lerp_saveddvar( "r_specularcolorscale", 4.5, var_0.kick_in_duration );
    childthread overdrive_manage_fov( var_0.kick_in_duration, 1.15 );
    setomnvar( "ui_overdrive_effects_time", var_0.kick_in_duration );
    setomnvar( "ui_overdrive_effects_toggle", 1 );
    settimescale( 0.5 );
    childthread player_heartbeat();
    self playerrecoilscaleon( 60 );
    setsaveddvar( "player_sprintUnlimited", 1 );
    self setviewkickscale( 0.5 );
}

overdrive_effects_stop()
{
    var_0 = self.exoparams["overdrive"];
    self notify( "overdrive_effects_stop" );
    level.player.exospeedscalars["overdrive"] = undefined;
    exo_move_speed_update();
    player_regen_restore();
    visionsetoverdrive( "", 1 );
    soundscripts\_snd::snd_message( "overdrive_off" );
    level.player lerpfovscale( 1, var_0.kick_out_duration );
    setomnvar( "ui_overdrive_effects_time", var_0.kick_out_duration );
    setomnvar( "ui_overdrive_effects_toggle", 0 );
    settimescale( 1 );
    self playerrecoilscaleoff();
    setsaveddvar( "player_sprintUnlimited", 0 );
    self setviewkickscale( 1 );
    maps\_utility::lerp_saveddvar( "r_specularcolorscale", level.specular_default, 2.5 );
}

overdrive_force_cooldown( var_0 )
{
    var_1 = self.exoparams["overdrive"];
    var_2 = var_1.cooldownstate;

    if ( var_2.state == "cooling" && var_2.totaltime - var_2.currenttime > var_0 )
        var_2.currenttime = var_2.totaltime - var_0;
}

overdrive_force_stop( var_0 )
{
    var_1 = self.exoparams["overdrive"];
    var_2 = var_1.cooldownstate;

    if ( var_2.state == "heating" && var_2.totaltime - var_2.currenttime > var_0 )
        var_2.currenttime = var_2.totaltime - var_0;
}

overdrive_cooldown()
{
    var_0 = self.exoparams["overdrive"];
    overdrive_cooldown_internal( var_0.cool_down_duration );
    maps\_utility::ent_flag_clear( "overdrive_hot" );
}

overdrive_heatup()
{
    var_0 = self.exoparams["overdrive"];
    var_1 = var_0.duration + var_0.kick_in_duration + var_0.kick_out_duration;
    overdrive_heatup_internal( var_1 );
    maps\_utility::ent_flag_set( "overdrive_hot" );
}

overdrive_heatup_internal( var_0 )
{
    var_1 = self.exoparams["overdrive"];
    var_2 = var_1.cooldownstate;
    var_2.state = "heating";
    var_2.currenttime = 0;
    var_2.totaltime = var_0;
    var_3 = 0.05;

    while ( var_2.currenttime < var_2.totaltime )
    {
        var_4 = 1 - var_2.currenttime / var_2.totaltime;
        overdrive_updatebar( var_4 );
        var_2.currenttime += var_3;
        wait(var_3);
    }

    overdrive_updatebar( 0 );
}

overdrive_cooldown_internal( var_0 )
{
    var_1 = self.exoparams["overdrive"];
    var_2 = var_1.cooldownstate;
    var_2.state = "cooling";
    var_2.currenttime = 0;
    var_2.totaltime = var_0;
    var_3 = 0.05;

    while ( var_2.currenttime < var_2.totaltime )
    {
        var_4 = var_2.currenttime / var_2.totaltime;
        overdrive_updatebar( var_4 );
        var_2.currenttime += var_3;
        wait(var_3);
    }

    overdrive_updatebar( 1 );
}

player_heartbeat()
{
    var_0 = 0.8;
    var_1 = 0.1;
    var_2 = 8;
    self endon( "death" );
    wait 0.25;
    var_3 = gettime();

    while ( maps\_utility::ent_flag( "overdrive_on" ) )
    {
        wait 0.05;
        self playrumbleonentity( "damage_light" );
        wait(maps\_shg_utility::linear_map_clamp( ( gettime() - var_3 ) * 0.001, 0, var_2, var_0, var_1 ));
        wait(0 + randomfloat( 0.1 ));
    }
}

player_regen_scale( var_0 )
{
    self.old_health_regen_delay = self.gs.playerhealth_regularregendelay;
    self.old_health_long_regen_delay = self.gs.longregentime;
    self.gs.playerhealth_regularregendelay /= var_0;
    self.gs.longregentime /= var_0;
}

player_regen_restore()
{
    self.gs.playerhealth_regularregendelay = self.old_health_regen_delay;
    self.gs.longregentime = self.old_health_long_regen_delay;
    self.old_health_regen_delay = undefined;
    self.old_health_long_regen_delay = undefined;
}

setstim()
{
    self endon( "stim_disabled" );
    self endon( "death" );

    if ( isdefined( self.exo_stim_used ) )
        return;

    self notifyonplayercommand( "stim_button_pressed", "+actionslot 4" );
    self setweaponhudiconoverride( "actionslot4", "dpad_icon_stim" );
    self waittill( "stim_button_pressed" );
    self.exo_stim_used = 1;
    self.health = self.maxhealth;
    thread exo_stim_activate();
    self setweaponhudiconoverride( "actionslot4", "dpad_icon_stim_off" );
}

unsetstim()
{
    self notify( "stim_disabled" );
    self notifyonplayercommandremove( "stim_button_pressed", "+actionslot 4" );
    self setweaponhudiconoverride( "actionslot4", "dpad_icon_stim_off" );
}

exo_stim_activate()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = self geteye();
    var_0 linkto( level.player );
    playfxontag( common_scripts\utility::getfx( "exo_stim" ), var_0, "tag_origin" );
    soundscripts\_snd::snd_message( "exo_stim_on" );
    self.exo_stim_active = 1;
    wait 0.1;
    self.exo_stim_active = undefined;
}

setintelmode()
{
    thread player_intel_mode_think();
}

unsetintelmode()
{
    player_intel_mode_disable();
}

player_intel_mode_think()
{
    self endon( "death" );
    self endon( "player_intel_mode_disabled" );
    var_0 = 2;

    for (;;)
    {
        var_1 = level.player getweaponslistoffhands();
        var_2 = 0;

        foreach ( var_4 in var_1 )
        {
            if ( issubstr( var_4, "_grenade_var" ) )
            {
                var_2 = 1;
                break;
            }
        }

        var_6 = 0;

        if ( var_2 )
        {
            var_6 += level.player setweaponammostock( "flash_grenade_var" );
            var_6 += level.player setweaponammostock( "emp_grenade_var" );
            var_6 += level.player setweaponammostock( "paint_grenade_var" );
            var_6 /= 3;
        }

        if ( var_6 != 4 )
            thread player_intel_display_object_array( getentarray( "weapon_flash_grenade_var", "classname" ), var_0, "player_exo_intel_mode_flash_stop" );
        else
            level notify( "player_exo_intel_mode_flash_stop" );

        var_7 = 0;

        if ( var_2 )
        {
            var_7 += level.player setweaponammostock( "frag_grenade_var" );
            var_7 += level.player setweaponammostock( "contact_grenade_var" );
            var_7 += level.player setweaponammostock( "tracking_grenade_var" );
            var_7 /= 3;
        }

        if ( var_7 != 4 )
            thread player_intel_display_object_array( getentarray( "weapon_frag_grenade_var", "classname" ), var_0, "player_exo_intel_mode_frag_stop" );
        else
            level notify( "player_exo_intel_mode_frag_stop" );

        wait 1;
    }
}

player_intel_mode_disable()
{
    self notify( "player_intel_mode_disabled" );
}

player_intel_display_objects()
{
    self endon( "death" );
    self endon( "player_intel_mode_disabled" );
    self endon( "player_intel_mode_deactivated" );
    var_0 = 2;
    var_1 = 1;
    var_2 = getentarray( "script_model", "classname" );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( var_5.destructible_type ) && var_5.destructible_type == "explodable_barrel" )
            var_3[var_3.size] = var_5;
    }

    var_3 = common_scripts\utility::array_removeundefined( var_3 );
    thread player_intel_display_object_array( var_3, var_1, "player_exo_intel_mode_barrel_stop" );

    for (;;)
    {
        var_7 = getweaponarray();
        thread player_intel_display_object_array( var_7, var_0, "player_exo_intel_mode_barrel_stop" );
        wait 0.05;
    }
}

player_intel_display_object_array( var_0, var_1, var_2 )
{
    var_3 = 1024;
    var_4 = var_3 * var_3;

    foreach ( var_6 in var_0 )
    {
        if ( !isdefined( var_6.highlight_on ) )
        {
            if ( distancesquared( var_6.origin, self.origin ) < var_4 )
                var_6 thread player_intel_display_object( var_1, var_2 );
        }
    }
}

player_intel_display_object( var_0, var_1 )
{
    if ( !common_scripts\utility::isdestructible() )
        self endon( "death" );

    self.highlight_on = 1;
    self hudoutlineenable( var_0, 1 );
    common_scripts\utility::waittill_any_ents( level, var_1, self, "stop_highlight", self, "exploded" );

    if ( isdefined( self ) )
    {
        self.highlight_on = undefined;
        self hudoutlinedisable();
    }
}

setexomelee()
{
    level.player maps\_utility::playerallowalternatemelee( 1 );
}

unsetexomelee()
{
    level.player maps\_utility::playerallowalternatemelee( 0 );
}

setexoslide()
{
    level.player allowpowerslide( 1 );
}

unsetexoslide()
{
    level.player allowpowerslide( 0 );
}

setexoslam()
{
    level.player allowhighjumpdrop( 1 );
    level.player thread monitorgroundslam();
    level.player thread monitorgroundslamhitplayer();
}

unsetexoslam()
{
    level.player allowhighjumpdrop( 0 );
    level.player notify( "disallow_ground_slam" );
}

getgroundslamminheight()
{
    return 120;
}

getgroundslammaxheight()
{
    return 380;
}

getgroundslammindamage()
{
    return 200;
}

getgroundslammaxdamage()
{
    return 300;
}

getgroundslamminradius()
{
    return 75;
}

getgroundslammaxradius()
{
    return 150;
}

getgroundslamhitlateralvimpart()
{
    return 0.1;
}

getgroundslamhitverticalvimpart()
{
    return 1;
}

getgroundslamcrushdamage()
{
    return 250;
}

getgroundslamragdolldirscale()
{
    return 0;
}

init_ground_slam()
{
    level._effect["exo_slam_kneeslide_fx"] = loadfx( "vfx/code/slam_jetpack_kneeslide" );
    precacheshellshock( "boost_slam_sp" );
}

monitorgroundslamhitplayer()
{
    self endon( "death" );
    self endon( "disallow_ground_slam" );

    for (;;)
    {
        self waittill( "ground_slam_hit_player", var_0, var_1 );

        if ( var_0 getoldslam( var_1 ) )
            continue;

        var_2 = maps\_shg_utility::get_differentiated_velocity();
        var_3 = getdvarfloat( "high_jump_drop_lateral_v_impart", getgroundslamhitlateralvimpart() );
        var_4 = getdvarfloat( "high_jump_drop_vertical_v_impart", getgroundslamhitverticalvimpart() );
        var_5 = getdvarint( "high_jump_drop_crush_damage", getgroundslamcrushdamage() );
        var_6 = isalive( var_0 );
        var_0.slam_ragdoll_vel = ( var_2[0] * var_3, var_2[1] * var_3, var_2[2] * var_4 );
        var_0 dodamage( var_5, self.origin, self, self, "MOD_CRUSH", "boost_slam_sp", "none" );

        if ( var_6 && !isalive( var_0 ) && var_0 getstompbreakthrough() )
            var_0.deathfunction = ::groundslamcrushdeathfunction;

        var_0 setoldslam( var_1 );
    }
}

setoldslam( var_0 )
{
    if ( !isdefined( self.boost_slam_history ) )
        self.boost_slam_history = [];

    self.boost_slam_history[self.boost_slam_history.size] = var_0;
}

getoldslam( var_0 )
{
    if ( !isdefined( self.boost_slam_history ) )
        return 0;

    foreach ( var_2 in self.boost_slam_history )
    {
        if ( var_0 == var_2 )
            return 1;
    }

    return 0;
}

groundslamcrushdeathfunction()
{
    self.ragdoll_start_vel = self.slam_ragdoll_vel;
    self.ragdoll_immediate = 1;
    self.ragdoll_directionscale = getdvarfloat( "high_jump_drop_ragdoll_dir_scale", getgroundslamragdolldirscale() );
    self notify( "end_ground_slam_death_function" );
    return 0;
}

monitorgroundslam()
{
    self endon( "death" );
    self endon( "disallow_ground_slam" );
    var_0 = 10;
    var_1 = 4;
    var_2 = ( 1, 0, 0 );
    var_3 = ( 0, 1, 0 );
    var_4 = ( 0, 0, 1 );
    var_5 = 16;

    for (;;)
    {
        self waittill( "ground_slam", var_6, var_7 );
        var_8 = getdvarfloat( "high_jump_drop_min_height", getgroundslamminheight() );
        var_9 = getdvarfloat( "high_jump_drop_max_height", getgroundslammaxheight() );
        var_10 = getdvarfloat( "high_jump_drop_min_damage", getgroundslammindamage() );
        var_11 = getdvarfloat( "high_jump_drop_max_damage", getgroundslammaxdamage() );
        var_12 = getdvarfloat( "high_jump_drop_min_radius", getgroundslamminradius() );
        var_13 = getdvarfloat( "high_jump_drop_max_radius", getgroundslammaxradius() );

        if ( var_6 < var_8 )
            continue;

        var_14 = ( var_6 - var_8 ) / ( var_9 - var_8 );
        var_14 = clamp( var_14, 0.0, 1.0 );
        var_15 = ( var_13 - var_12 ) * var_14 + var_12;
        self radiusdamage( self.origin, var_15, var_11, var_10, self, "MOD_PROJECTILE_SPLASH", "boost_slam_sp" );
        maps\_sp_matchdata::register_boost_slam();
        physicsexplosionsphere( self.origin, var_15, 20, 0.9 );
    }
}

setsonicblast()
{
    thread maps\_sonicaoe::enablesonicaoe();
}

unsetsonicblast()
{
    thread maps\_sonicaoe::disablesonicaoe();
}

sethighjump()
{
    level.player maps\_player_high_jump::enable_high_jump();
}

unsethighjump()
{
    level.player maps\_player_high_jump::disable_high_jump();
}

setshield()
{
    level.player maps\_exo_shield_sp::enable_shield_ability();
}

unsetshield()
{
    level.player maps\_exo_shield_sp::disable_shield_ability();
}

exo_shield_is_on()
{
    return maps\_utility::ent_flag( "exo_shield_on" );
}

batteryinit( var_0 )
{
    var_1 = 3;

    if ( isdefined( var_0 ) )
        var_1 = 3 + var_0;

    level.player.exobatterymax = var_1;
    level.player.exobatterylevel = level.player.exobatterymax;
    batteryupdatemeter();
}

batterysetlevel( var_0 )
{
    level.player.exobatterylevel = int( clamp( var_0, 0, level.player.exobatterymax ) );
    batteryupdatemeter();
}

batteryfillmax()
{
    level.player.exobatterylevel = level.player.exobatterymax;
    batteryupdatemeter();
}

batteryupdatemeter()
{
    var_0 = int( level.player.exobatterylevel / level.player.exobatterymax * 100 );
    setomnvar( "ui_exobattery_value", var_0 );
    level.player notify( "exo_battery_update" );
    update_battery_ability_icons( var_0 );
}

batterymetervisible( var_0, var_1 )
{
    if ( !isdefined( level.player.exo_battery_ability_flags ) )
        level.player.exo_battery_ability_flags = [];

    level.player.exo_battery_ability_flags[var_0] = var_1;

    foreach ( var_3 in level.player.exo_battery_ability_flags )
    {
        if ( isdefined( var_3 ) && var_3 )
        {
            setomnvar( "ui_exobattery", 1 );
            batteryupdatemeter();
            return;
        }
    }

    setomnvar( "ui_exobattery", 0 );
}

batteryspend( var_0 )
{
    var_1 = level.player.exobatterylevel;

    if ( var_0 > var_1 )
    {
        exofailfx();
        return 0;
    }

    batterysetlevel( var_1 - var_0 );
    return 1;
}

get_exo_battery_percent()
{
    return int( level.player.exobatterylevel / level.player.exobatterymax * 100 );
}

exofailfx()
{
    var_0 = level.player geteye();
    level.player playsound( "exo_power_not_ready" );
}

waittill_weaponhud_canshow()
{
    level.player endon( "begin_firing" );
    level.player endon( "reload" );
    level.player endon( "x_pressed" );
    level.player endon( "offhand_end" );
    level.player endon( "weaponchange" );
    level.player endon( "dpad_up" );
    level.player endon( "dpad_down" );
    level.player endon( "dpad_left" );
    level.player endon( "dpad_right" );
    level.player endon( "exo_battery_update" );
    level.player waittill( "weapon_switch_started" );
}

show_weaponhud()
{
    level.player notify( "show_weaponhud_stop" );
    level.player endon( "show_weaponhud_stop" );
    setomnvar( "ui_exobattery", 1 );
    setsaveddvar( "actionSlotsHide", 0 );
    wait 3;
    setomnvar( "ui_exobattery", 0 );
    setsaveddvar( "actionSlotsHide", 1 );
}

handle_weaponhud_visibility()
{
    level.player endon( "death" );
    level.player notifyonplayercommand( "dpad_down", "+actionslot 2" );
    level.player notifyonplayercommand( "dpad_left", "+actionslot 3" );
    level.player notifyonplayercommand( "dpad_right", "+actionslot 4" );
    level.player notifyonplayercommand( "dpad_up", "+actionslot 1" );
    level.player notifyonplayercommand( "x_pressed", "+usereload" );
    level.player notifyonplayercommand( "x_pressed", "+reload" );

    for (;;)
    {
        thread show_weaponhud();
        waitframe();
        waittill_weaponhud_canshow();
    }
}

exo_move_speed_update()
{
    var_0 = 1;

    foreach ( var_2 in level.player.exospeedscalars )
    {
        if ( isdefined( var_2 ) )
            var_0 *= var_2;
    }

    maps\_utility::player_speed_percent( int( 100 * var_0 ) );
}

update_battery_ability_icons( var_0 )
{
    var_1 = [];
    var_1[var_1.size] = "overdrive";
    var_1[var_1.size] = "sonic_blast";
    var_1[var_1.size] = "shield";

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( level.player.exclusive[var_3] ) )
            continue;

        if ( player_exo_is_active_single( var_3 ) )
        {
            switch ( var_3 )
            {
                case "overdrive":
                    update_overdrive_icon();
                    break;
                case "sonic_blast":
                    maps\_sonicaoe::update_sonic_aoe_icon();
                    break;
                case "shield":
                    maps\_exo_shield_sp::update_exo_shield_icon();
                    break;
                default:
                    break;
            }
        }
    }
}

update_overdrive_icon( var_0 )
{
    if ( isdefined( var_0 ) && !var_0 )
        level.player setweaponhudiconoverride( "actionslot1", "none" );
    else if ( !player_exo_is_active() )
        level.player setweaponhudiconoverride( "actionslot1", "none" );
    else
    {
        if ( get_exo_battery_percent() > 0 )
        {
            level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_overdrive" );
            return;
        }

        level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_overdrive_off" );
    }
}
