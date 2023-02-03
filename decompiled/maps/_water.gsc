// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init( var_0 )
{
    precacheshellshock( "underwater" );
    level._effect["water_bubbles"] = loadfx( "vfx/water/player_bubbles_underwater" );
    level._effect["water_vm_gasping_breath"] = loadfx( "vfx/water/underwater_bubble_vm_gasping_breath_lt" );
    level._effect["water_splash_emerge"] = loadfx( "vfx/water/body_splash_exit" );
    level._effect["water_screen_plunge"] = loadfx( "vfx/water/screen_fx_plunge" );
    level._effect["water_screen_emerge"] = loadfx( "vfx/water/screen_fx_emerge" );
    level._effect["water_wake"] = loadfx( "vfx/treadfx/body_wake_water" );
    level._effect["water_wake_stationary"] = loadfx( "vfx/treadfx/body_wake_water_stationary" );
    level._effect["water_splash_enter"] = loadfx( "vfx/water/body_splash" );
    level._effect["water_wake_ai"] = loadfx( "vfx/treadfx/body_wake_water" );
    level._effect["water_wake_stationary_ai"] = loadfx( "vfx/treadfx/body_wake_water_stationary" );
    level._effect["water_splash_enter_ai"] = loadfx( "vfx/water/body_splash" );
    var_1 = getentarray( "trigger_underwater", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_3 thread watchplayerenterwater();
        level thread water_trigger_register( var_3 );
    }

    level.dofunderwater = [];
    level.dofunderwater["nearStart"] = 0;
    level.dofunderwater["nearEnd"] = 1;
    level.dofunderwater["farStart"] = 30;
    level.dofunderwater["farEnd"] = 210;
    level.dofunderwater["nearBlur"] = 4;
    level.dofunderwater["farBlur"] = 4;
    level.underwater_visionset_callback = ::water_default_vision_set_enabled;
    level.underwater_sound_ent = spawn( "script_origin", level.player.origin );
    maps\_swim_player::init_player_swim( var_0 );
    setdvarifuninitialized( "underwater_walk_speed_scale_ai", 0.6 );
    setdvarifuninitialized( "underwater_wading_speed_factor", 1.0 );
}

water_trigger_register( var_0 )
{
    if ( !isdefined( level.underwatertriggers ) )
        level.underwatertriggers = [ var_0 ];
    else
        level.underwatertriggers[level.underwatertriggers.size] = var_0;
}

disable_swim_or_underwater_walk()
{
    if ( isdefined( self.swimming ) )
        maps\_swim_player::disable_player_swim();
    else if ( isdefined( self.underwater_walk ) )
        maps\_swim_player::disable_player_underwater_walk();
}

watchplayerenterwater()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( !isplayer( var_0 ) )
            continue;

        if ( !isalive( var_0 ) )
            continue;

        if ( !isdefined( var_0.inwater ) || !var_0.inwater )
        {
            var_0.inwater = 1;

            if ( !isdefined( var_0.water_trigger_current ) )
                var_0 thread playerinwater( self );
        }
    }
}

water_depth_below( var_0 )
{
    var_1 = level getwaterline( var_0 );
    var_2 = ( self.origin[0], self.origin[1], var_1 + 1.0 );
    var_3 = var_2;

    if ( isplayer( self ) )
        var_3 = playerphysicstrace( var_2, var_2 - ( 0, 0, 1000 ), self );
    else
        var_3 = self aiphysicstrace( var_2, var_2 - ( 0, 0, 1000 ), 15, 60, 1 );

    return var_2[2] - var_3[2] - 1.0;
}

playerinwater( var_0 )
{
    self notify( "playerInWater" );
    self endon( "playerInWater" );
    self endon( "death" );
    thread inwaterwake();
    thread playerwaterclearwait();

    if ( isdefined( var_0 ) )
        self.water_trigger_current = var_0;

    var_1 = water_depth_below( self.water_trigger_current );

    if ( !isdefined( self.water_lastemerge ) )
        self.water_lastemerge = 0;

    if ( !isdefined( self.ent_flag ) || !isdefined( self.ent_flag["water_trigger_paused"] ) )
        maps\_utility::ent_flag_init( "water_trigger_paused" );

    for (;;)
    {
        maps\_utility::ent_flag_waitopen( "water_trigger_paused" );
        var_2 = 0;

        if ( isdefined( var_0 ) && self istouching( var_0 ) )
            var_2 = 1;
        else
        {
            foreach ( var_4 in level.underwatertriggers )
            {
                if ( ( !isdefined( var_0 ) || var_4 != var_0 ) && self istouching( var_4 ) )
                {
                    var_2 = 1;
                    self.water_touching = var_2;
                    var_0 = var_4;
                    self.water_trigger_current = var_4;
                    setsaveddvar( "player_swimWaterSurface", getwaterline( var_0 ) );
                    break;
                }
            }
        }

        self.water_touching = var_2;
        var_6 = self.origin[2];

        if ( isdefined( var_0 ) )
            var_6 = getwaterline( var_0 );

        if ( var_2 && !isdefined( self.underwater ) && !isabovewaterline( var_0 ) && gettime() - self.water_lastemerge > 700 )
        {
            if ( !isdefined( self.grapple ) || !self.grapple["grappling"] )
            {
                water_set_depth( 1000 );
                under_water_set( 1, getwaterline( var_0 ) );
            }
        }

        if ( isdefined( self.underwater ) && ( isabovewaterline( var_0 ) || !var_2 ) )
        {
            water_set_depth( water_depth_below( var_0 ) );
            under_water_set( 0, getwaterline( var_0 ) );
            var_7 = self getvelocity();
            self setvelocity( ( var_7[0], var_7[1], min( 0, var_7[2] ) ) );
        }

        if ( var_2 && !isdefined( self.underwater ) )
        {
            if ( self isonground() )
                var_1 = level getwaterline( var_0 ) - self.origin[2];
            else
                var_1 = water_depth_below( var_0 );

            water_set_depth( var_1 );

            if ( isdefined( self.swimming ) )
            {
                var_8 = water_depth_state( self.water_depth );
                var_6 = getwaterline( var_0 );

                if ( player_can_stop_swimming( var_6 ) && var_8 != "chest" )
                {
                    self.water_lastemerge = gettime();
                    maps\_swim_player::disable_player_swim();
                }
            }
        }

        if ( !var_2 && ( self ismantling() || player_can_stop_swimming( var_6 ) ) )
        {
            self.inwater = undefined;
            self.water_trigger_current = undefined;
            self.water_touching = undefined;

            if ( !isdefined( self.underwater ) && water_depth_state( self.water_depth ) != "puddle" )
                self playlocalsound( "underwater_exit" );

            water_set_depth( 0 );
            under_water_set( 0 );
            disable_swim_or_underwater_walk();
            self notify( "out_of_water" );
            break;
        }

        wait 0.05;
    }
}

under_water_set( var_0, var_1 )
{
    if ( var_0 && ( !isdefined( self.underwater ) || !self.underwater ) )
    {
        self.underwater = 1;
        thread playerunderwater();
        water_vision_set_enabled( 1 );

        if ( !isdefined( self.mechdata ) || !self.mechdata.active )
            maps\_swim_player::enable_player_swim( 0, 0, var_1 );
        else
            maps\_swim_player::enable_player_underwater_walk( 0, 0, var_1 );
    }
    else if ( !var_0 && isdefined( self.underwater ) && self.underwater )
    {
        self.underwater = undefined;
        self.water_lastemerge = gettime();
        self notify( "above_water" );
        water_vision_set_enabled( 0 );

        if ( isdefined( self.swimming ) )
        {
            if ( player_can_stop_swimming( var_1 ) )
                maps\_swim_player::disable_player_swim();
            else
                maps\_swim_player::player_set_swimming( "surface", 0, 0, var_1 );
        }
        else if ( isdefined( self.underwater_walk ) )
        {
            if ( self isonground() || !isdefined( var_1 ) || !player_in_deep_water() )
                maps\_swim_player::disable_player_underwater_walk();
        }

        self stopshellshock();
    }
}

player_in_deep_water()
{
    return isdefined( self.water_depth ) && water_depth_state( self.water_depth ) == "deep";
}

player_can_stop_swimming( var_0 )
{
    if ( !isdefined( self.swimming ) )
        return 1;

    if ( !isdefined( self.water_touching ) || !self.water_touching || self isonground() || !isdefined( var_0 ) || !player_in_deep_water() )
    {
        var_1 = self.origin + ( 0, 0, -1 );
        var_2 = playerphysicstrace( var_1, self.origin );

        if ( distancesquared( var_2, self.origin ) < 0.001 )
            return 1;
    }

    return 0;
}

water_vision_set_enabled( var_0 )
{
    [[ level.underwater_visionset_callback ]]( var_0 );
}

water_default_vision_set_enabled( var_0 )
{
    if ( var_0 )
    {
        var_1 = 1;
        var_2 = "generic_underwater";

        if ( isdefined( level.visionset_underwater ) )
            var_2 = level.visionset_underwater;

        self setclienttriggervisionset( var_2, var_1 );
        self visionsetnakedforplayer( var_2, var_1 );
        maps\_utility::vision_set_fog_changes( var_2, var_1 );

        if ( isdefined( level.clut_underwater ) )
            self setclutforplayer( level.clut_underwater, 0 );

        if ( isdefined( level.underwater_lightset ) )
            set_light_set_for_player( level.underwater_lightset );

        if ( isdefined( level.dofunderwater ) )
            thread setdof( level.dofunderwater );

        playfx( common_scripts\utility::getfx( "water_screen_plunge" ), self.origin );
        self setwatersheeting( 0 );
        setunderwateraudiozone();
        self playlocalsound( "underwater_enter" );
    }
    else
    {
        revertvisionsetforplayer( 0 );

        if ( isdefined( level.lightset_previous ) )
            set_light_set_for_player( level.lightset_previous );

        if ( isdefined( level.clut_previous ) )
            self setclutforplayer( level.clut_previous, 1 );

        if ( isdefined( level.dofdefault ) )
            thread setdof( level.dofdefault );

        playfx( common_scripts\utility::getfx( "water_screen_emerge" ), self.origin );
        self setwatersheeting( 1, 1 );
        clearunderwateraudiozone();
        self playlocalsound( "breathing_better" );
        self playlocalsound( "underwater_exit" );
        var_3 = undefined;

        if ( isdefined( self.water_trigger_current ) )
            var_3 = getwaterline( self.water_trigger_current );

        if ( isdefined( var_3 ) )
        {
            var_4 = ( self.origin[0], self.origin[1], var_3 );
            playfx( level._effect["water_splash_emerge"], var_4, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270, 180, 0 ) ) );
        }
    }
}

water_set_depth( var_0 )
{
    var_1 = water_depth_state( var_0 );
    var_2 = "none";

    if ( isdefined( self.water_depth ) )
        var_2 = water_depth_state( self.water_depth );

    if ( var_0 > 0 )
        self.water_depth = var_0;
    else
        self.water_depth = undefined;

    if ( isdefined( self.mechdata ) && self.mechdata.active )
        return;

    if ( var_2 != var_1 )
    {
        switch ( var_1 )
        {
            case "puddle":
                thread wading_footsteps( 0.0, 1.0 );
                water_set_control_options( 1, 1, 1 );
                thread aud_water_footsteps_override( "" );
                soundscripts\_audio_mix_manager::mm_add_submix( "mute_footsteps" );
                break;
            case "ankle":
                thread wading_footsteps( 0.25, 0.75, "_ankle" );
                thread aud_water_footsteps_override( "_ankle" );
                soundscripts\_audio_mix_manager::mm_add_submix( "mute_footsteps" );
                water_set_control_options( 1, 0, 0 );
                break;
            case "knee":
                thread wading_footsteps( 0.6, 0.55, "_knee" );
                thread aud_water_footsteps_override( "_knee" );
                soundscripts\_audio_mix_manager::mm_add_submix( "mute_footsteps" );
                water_set_control_options( 1, 0, 1 );
                break;
            case "thigh":
                thread wading_footsteps( 1.0, 0.45, "_waist" );
                thread aud_water_footsteps_override( "_waist" );
                soundscripts\_audio_mix_manager::mm_add_submix( "mute_footsteps" );
                water_set_control_options( 0, 0, 1 );
                break;
            case "chest":
                thread wading_footsteps( 0.5, 0.33, "_waist" );
                thread aud_water_footsteps_override( "_waist" );
                soundscripts\_audio_mix_manager::mm_add_submix( "mute_footsteps" );
                water_set_control_options( 0, 0, 1 );
                break;
            case "deep":
                thread wading_footsteps( 0.0, 1.0 );
                water_set_control_options( 0, 1, 1 );
                break;
            default:
                thread wading_footsteps( 0.0, 1.0 );
                self notify( "override_footsteps" );
                soundscripts\_audio_mix_manager::mm_clear_submix( "mute_footsteps", 0.2 );
                water_set_control_options( 1, 1, 1 );
                break;
        }
    }
}

water_set_control_options( var_0, var_1, var_2 )
{
    if ( var_0 && isdefined( level.water_allow_jump ) && !level.water_allow_jump )
        var_0 = 0;

    if ( var_1 && isdefined( level.water_allow_sprint ) && !level.water_allow_sprint )
        var_1 = 0;

    if ( var_2 && isdefined( level.water_allow_prone ) && !level.water_allow_prone )
        var_2 = 0;

    self allowjump( var_0 );
    self allowsprint( var_1 );
    self allowprone( var_2 );
}

water_depth_state( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 <= 0 )
        return "none";

    if ( var_0 <= 8 )
        return "puddle";
    else if ( var_0 <= 20 )
        return "ankle";
    else if ( var_0 <= 30 )
        return "knee";
    else if ( var_0 <= 50 )
        return "thigh";
    else if ( var_0 <= 60 )
        return "chest";
    else
        return "deep";
}

wading_adjust_angles( var_0 )
{
    var_1 = var_0[0];
    var_2 = var_0[2];
    var_3 = anglestoright( self.angles );
    var_4 = anglestoforward( self.angles );
    var_5 = ( var_3[0], 0, var_3[1] * -1 );
    var_6 = ( var_4[0], 0, var_4[1] * -1 );
    var_7 = var_6 * var_1;
    var_7 += var_5 * var_2;
    return var_7 + ( 0, var_0[1], 0 );
}

wading_footsteps( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( var_1 >= 1.0 )
    {
        thread wading_footsteps_ends();
        return;
    }

    var_1 *= getdvarfloat( "underwater_wading_speed_factor" );
    var_3 = isdefined( self.water_wading_wobble_target );
    self.water_wading_wobble_target = var_0;
    self.water_wading_move_speed_target = var_1;
    self.water_wading_waterdepthtype = var_2;

    if ( !isdefined( self.water_wading_wobble ) )
    {
        self.water_wading_wobble = 0;
        self.water_wading_move_speed = var_1;
    }

    if ( var_3 )
        return;

    self notify( "wading_footsteps" );
    self endon( "wading_footsteps" );

    if ( !isdefined( self.water_ground_ref_ent ) )
    {
        self.water_ground_ref_ent = spawn( "script_model", ( 0, 0, 0 ) );
        self playersetgroundreferenceent( self.water_ground_ref_ent );
    }

    var_4 = 0;
    var_5 = 0.05;
    var_6 = 0;
    var_7 = 0;

    for (;;)
    {
        self.water_wading_wobble += ( self.water_wading_wobble_target - self.water_wading_wobble ) * 0.1;
        self.water_wading_move_speed += ( self.water_wading_move_speed_target - self.water_wading_move_speed ) * 0.1;
        var_8 = 3.0 * self.water_wading_wobble;
        var_9 = 4.0 * self.water_wading_wobble;
        var_10 = 3.0 * self.water_wading_wobble;
        var_1 = self.water_wading_move_speed;

        if ( !isdefined( self.movespeedscale ) || self.movespeedscale == 0.0 )
            maps\_utility::blend_movespeedscale( var_1, 0.25 );

        var_11 = distance( ( 0, 0, 0 ), self getvelocity() );
        var_12 = min( var_11, 200.0 );

        if ( var_12 == 0.0 )
        {
            self.water_ground_ref_ent rotateto( ( 0, 0, 0 ), 0.25, 0.125, 0.125 );
            var_4 = self.water_ground_ref_ent.angles[0];
        }
        else
        {
            var_4 += var_12 * 0.3;

            if ( cos( var_4 ) > 0 )
            {
                var_4 += var_12 * 0.1;

                if ( !var_6 )
                {
                    var_6 = 1;
                    maps\_utility::blend_movespeedscale( var_1, 0.25 );
                }
            }
            else if ( var_6 )
            {
                var_13 = "walk";

                if ( self issprinting() )
                    var_13 = "sprint";
                else if ( self getnormalizedmovement()[0] > 0.5 )
                    var_13 = "run";

                if ( self getstance() != "stand" )
                    var_13 = "crouch" + var_13;

                var_14 = "_r";

                if ( var_7 < 0 )
                    var_14 = "_l";

                aud_water_footsteps_foley( var_13, self.water_wading_waterdepthtype, var_14 );
                var_6 = 0;
                maps\_utility::blend_movespeedscale( max( 0.2, var_1 * 0.75 ), 0.15 );
            }

            var_15 = ( sin( var_4 ) - 0.75 ) * var_8;
            var_16 = sin( var_4 * -0.5 ) * var_9;
            var_7 = sin( var_4 * 0.5 ) * var_10;
            var_17 = wading_adjust_angles( ( var_15, var_16, var_7 ) );
            self.water_ground_ref_ent rotateto( var_17, var_5, var_5 * 0.5, var_5 * 0.5 );
        }

        wait 0.05;
    }
}

aud_water_footsteps_override( var_0 )
{
    self endon( "death" );
    self notify( "override_footsteps" );
    self endon( "override_footsteps" );
    self playlocalsound( "step_run_plr_water" + var_0 + "_l" );

    for (;;)
    {
        level.player waittill( "foley", var_1, var_2, var_3 );

        if ( isdefined( self.water_ground_ref_ent ) )
        {
            switch ( var_1 )
            {
                case "crouchwalk":
                case "crouchrun":
                case "run":
                case "sprint":
                case "walk":
                    continue;
            }
        }

        var_4 = "_r";

        if ( var_3 )
            var_4 = "_l";

        aud_water_footsteps_foley( var_1, var_0, var_4 );
    }
}

aud_water_footsteps_foley( var_0, var_1, var_2 )
{
    var_3 = "_plr";

    if ( !isplayer( self ) )
        var_3 = "";

    switch ( var_0 )
    {
        case "stationarycrouchscuff":
            aud_water_sound( "step_scrape" + var_3 + "_water" + var_1 );
            aud_water_sound( "step_crchwalk" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "stationaryscuff":
            aud_water_sound( "step_scrape" + var_3 + "_water" + var_1 );
            aud_water_sound( "step_walk" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "crouchscuff":
            aud_water_sound( "step_scrape" + var_3 + "_water" + var_1 );
            aud_water_sound( "step_crchwalk" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "runscuff":
            aud_water_sound( "step_scrape" + var_3 + "_water" + var_1 );
            aud_water_sound( "step_run" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "sprintscuff":
            aud_water_sound( "step_scrape" + var_3 + "_water" + var_1 );
            aud_water_sound( "step_sprint" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "prone":
            aud_water_sound( "step_prone" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "crouchwalk":
            aud_water_sound( "step_crchwalk" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "crouchrun":
            aud_water_sound( "step_crchwalk" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "walk":
            aud_water_sound( "step_walk" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "run":
            aud_water_sound( "step_run" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "sprint":
            aud_water_sound( "step_sprint" + var_3 + "_water" + var_1 + var_2 );
            break;
        case "jump":
            aud_water_sound( "step_jump" + var_3 + "_water" + var_1 );
            break;
        case "lightland":
            aud_water_sound( "step_land" + var_3 + "_lt_water" + var_1 );
            break;
        case "mediumland":
            aud_water_sound( "step_land" + var_3 + "_med_water" + var_1 );
            break;
        case "heavyland":
            aud_water_sound( "step_land" + var_3 + "_hv_water" + var_1 );
            break;
        case "damageland":
            aud_water_sound( "step_land" + var_3 + "_dmg_water" + var_1 );
            break;
        default:
            break;
    }
}

aud_water_sound( var_0 )
{
    if ( isplayer( self ) )
        self playlocalsound( var_0 );
    else
        self playsound( var_0 );
}

wading_footsteps_ends()
{
    self endon( "death" );
    self notify( "wading_footsteps" );
    self endon( "wading_footsteps" );
    self.water_wading_wobble_target = undefined;

    if ( isdefined( self.water_ground_ref_ent ) )
    {
        var_0 = 0.25;
        self.water_ground_ref_ent rotateto( ( 0, 0, 0 ), var_0, var_0 * 0.5, var_0 * 0.5 );
        maps\_utility::blend_movespeedscale( 1.0, var_0 );
        wait(var_0);

        if ( isdefined( self.water_ground_ref_ent ) )
            self.water_ground_ref_ent delete();

        self.water_ground_ref_ent = undefined;
        self.water_wading_wobble = undefined;
        self.water_wading_move_speed_target = undefined;
        self.water_wading_move_speed = undefined;
        self.water_wading_waterdepthtype = undefined;
        self playersetgroundreferenceent( undefined );
        self notify( "blend_movespeedscale" );
        maps\_utility_code::movespeed_set_func( 1.0 );
    }
}

setunderwateraudiozone()
{
    if ( isdefined( level.aud ) && isdefined( level.aud.water ) && isdefined( level.aud.water.enter_water_override ) )
    {
        soundscripts\_snd::snd_message( level.aud.water.enter_water_override );
        return;
    }

    soundscripts\_audio_zone_manager::azm_set_reverb_bypass( 1 );
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 1 );
    level.underwater_sound_ent = soundscripts\_snd_playsound::snd_play_loop_2d( "underwater_bubbles_lp" );
    soundscripts\_snd_filters::snd_set_filter( "underwater", 1, 0 );
    soundscripts\_audio_reverb::rvb_start_preset( "underwater", 1 );
    level.player seteqlerp( 1, 1 );
}

clearunderwateraudiozone()
{
    if ( isdefined( level.aud ) && isdefined( level.aud.water ) && isdefined( level.aud.water.exit_water_override ) )
    {
        soundscripts\_snd::snd_message( level.aud.water.exit_water_override );
        return;
    }

    var_0 = level._audio.zone_mgr.current_zone;
    soundscripts\_audio_zone_manager::azm_set_reverb_bypass( 0 );
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 0 );
    level.underwater_sound_ent soundscripts\_snd_playsound::snd_stop_sound();

    if ( isdefined( level._audio.zone_mgr.zones[var_0] ) )
    {
        var_1 = level._audio.zone_mgr.zones[var_0];
        var_2 = var_1["priority"];
        var_3 = var_1["interrupt_fade"];

        if ( isdefined( var_1["filter"] ) )
        {
            if ( var_1["filter"] != "none" )
            {
                soundscripts\_snd_filters::snd_set_filter( var_1["filter"], 0 );
                soundscripts\_snd_filters::snd_set_filter_lerp( 1 );
            }
        }
        else
        {
            soundscripts\_snd_filters::snd_clear_filter( 1 );
            soundscripts\_audio_reverb::rvb_deactive_reverb();
        }

        if ( isdefined( var_1["reverb"] ) )
        {
            if ( var_1["reverb"] != "none" )
                soundscripts\_audio_reverb::rvb_start_preset( var_1["reverb"] );
        }
        else
        {
            soundscripts\_snd_filters::snd_clear_filter( 1 );
            soundscripts\_audio_reverb::rvb_deactive_reverb();
        }
    }
    else
    {
        soundscripts\_snd_filters::snd_clear_filter( 1 );
        soundscripts\_audio_reverb::rvb_deactive_reverb();
    }

    level.player seteqlerp( 1, 0 );
}

override_deadquote()
{
    wait 0.5;

    if ( ( !isdefined( level.player.failingmission ) || level.player.failingmission == 0 ) && isdefined( level.player.is_drowning ) && level.player.is_drowning )
        maps\_player_death::set_deadquote( self.drowning_deadquote );
}

playerwaterclearwait()
{
    self endon( "playerInWater" );
    var_0 = common_scripts\utility::waittill_any_return( "death", "out_of_water" );

    if ( var_0 == "death" )
    {
        if ( isdefined( self.drowning_deadquote ) )
            thread override_deadquote();
    }
    else
    {
        self.inwater = undefined;
        self.water_trigger_current = undefined;
        under_water_set( 0 );
        water_set_depth( 0 );
        disable_swim_or_underwater_walk();
    }
}

inwaterwake()
{
    self endon( "death" );
    self endon( "playerInWater" );
    self endon( "out_of_water" );

    if ( !isdefined( self.water_wake_speed ) )
        self.water_wake_speed = 50;

    var_0 = "";

    if ( isai( self ) )
        var_0 = "_ai";

    var_1 = ( 0, 0, 0 );

    if ( isplayer( self ) )
        var_1 = self getvelocity();
    else
        var_1 = anglestoforward( self.angles ) * self.water_wake_speed;

    var_2 = distance( var_1, ( 0, 0, 0 ) );

    if ( var_2 > 90 && isdefined( self.water_trigger_current ) )
    {
        var_3 = self.origin;
        var_3 = ( var_3[0], var_3[1], getwaterline( self.water_trigger_current ) );
        var_3 += ( var_1[0], var_1[1], 0 ) * 0.25;
        playfx( level._effect["water_splash_enter" + var_0], var_3, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270, 180, 0 ) ) );
    }

    while ( isdefined( self.water_trigger_current ) )
    {
        var_1 = ( 0, 0, 0 );

        if ( isplayer( self ) )
            var_1 = self getvelocity();
        else
            var_1 = anglestoforward( self.angles ) * self.water_wake_speed;

        var_2 = distance( var_1, ( 0, 0, 0 ) );

        if ( var_2 > 0 )
            wait(max( 1 - var_2 / 120, 0.1 ));
        else
            wait 0.3;

        var_3 = self.origin;

        if ( var_2 > 5 )
        {
            var_4 = vectornormalize( ( var_1[0], var_1[1], 0 ) );
            var_5 = anglestoforward( vectortoangles( var_4 ) + ( 270, 180, 0 ) );
            var_3 = ( var_3[0], var_3[1], getwaterline( self.water_trigger_current ) ) + var_2 / 4 * var_4;
            playfx( level._effect["water_wake" + var_0], var_3, var_5 );
            continue;
        }

        var_3 = ( var_3[0], var_3[1], getwaterline( self.water_trigger_current ) );
        playfx( level._effect["water_wake_stationary" + var_0], var_3, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270, 180, 0 ) ) );
    }
}

playerunderwater()
{
    self endon( "death" );
    self endon( "above_water" );
    childthread player_underwater_shock();
    thread underwaterbubbles();
    thread underwatercloudy();
}

player_underwater_shock()
{
    for (;;)
    {
        self shellshock( "underwater", 60 );
        wait 60;
    }
}

onplayerdeath()
{
    self endon( "above_water" );
    self waittill( "death" );
    self.inwater = undefined;
    self.water_trigger_current = undefined;
    under_water_set( 0 );
    water_set_depth( 0 );
    disable_swim_or_underwater_walk();
}

underwaterbubbles()
{
    self endon( "death" );
    self endon( "above_water" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    waittillframeend;
    var_0 linktoplayerview( level.player, "tag_origin", ( 25, 0, 0 ), ( 0, 0, 0 ), 0 );
    thread delete_vm_underwater_org( var_0 );

    for (;;)
    {
        if ( self.underwater == 1 )
            playfxontag( common_scripts\utility::getfx( "water_bubbles" ), var_0, "tag_origin" );
        else
            killfxontag( common_scripts\utility::getfx( "water_bubbles" ), var_0, "tag_origin" );

        wait 0.25;
    }
}

delete_vm_underwater_org( var_0 )
{
    common_scripts\utility::waittill_any( "above_water", "death" );
    killfxontag( common_scripts\utility::getfx( "water_bubbles" ), var_0, "tag_origin" );
    var_0 unlinkfromplayerview( level.player );
    waitframe();
    var_0 delete();
}

underwatercloudy()
{
    if ( isdefined( level.underwater_cloudy ) )
    {
        var_0 = common_scripts\utility::spawn_tag_origin();
        var_0.angles = ( 0, 0, 0 );
        var_0.origin = level.player geteye() - ( 0, 0, 0 );
        var_0 linktoplayerview( level.player, "tag_origin", ( 70, 0, -1 ), ( -90, 0, 0 ), 0 );
        playfxontag( common_scripts\utility::getfx( level.underwater_cloudy ), var_0, "tag_origin" );
        self waittill( "above_water" );
        killfxontag( common_scripts\utility::getfx( level.underwater_cloudy ), var_0, "tag_origin" );
        var_0 unlinkfromplayerview( level.player );
        var_0 delete();
    }
}

isabovewaterline( var_0 )
{
    if ( getplayereyeheight() > level getwaterline( var_0 ) )
        return 1;
    else
        return 0;
}

getplayereyeheight()
{
    var_0 = self geteye();
    return var_0[2];
}

getwaterline( var_0 )
{
    var_1 = 3;
    var_2 = maps\_utility::getent_or_struct( var_0.target, "targetname" );
    var_3 = var_2.origin[2] + var_1;
    return var_3;
}

setdof( var_0 )
{
    self setdepthoffield( var_0["nearStart"], var_0["nearEnd"], var_0["farStart"], var_0["farEnd"], var_0["nearBlur"], var_0["farBlur"] );
}

set_light_set_for_player( var_0 )
{
    if ( isdefined( level.lightset_current ) )
        level.lightset_previous = level.lightset_current;

    level.lightset_current = var_0;
    self lightsetforplayer( var_0 );
}

revertvisionsetforplayer( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( isdefined( self.ridevisionset ) )
    {
        self setclienttriggervisionset( self.ridevisionset, var_0 );
        self visionsetnakedforplayer( self.ridevisionset, var_0 );
    }

    if ( isdefined( level.visionset_default ) )
    {
        self setclienttriggervisionset( level.visionset_default, var_0 );
        self visionsetnakedforplayer( level.visionset_default, var_0 );
        maps\_utility::vision_set_fog_changes( level.visionset_default, var_0 );
    }
    else
    {
        self setclienttriggervisionset( "", var_0 );
        self visionsetnakedforplayer( "", var_0 );
    }
}

watchaienterwater( var_0 )
{
    var_0 notify( "watchAIEnterWater" );
    var_0 endon( "watchAIEnterWater" );
    var_0 endon( "death" );

    for (;;)
    {
        foreach ( var_2 in level.underwatertriggers )
        {
            if ( ( !isdefined( var_0.inwater ) || !var_0.inwater ) && var_0 istouching( var_2 ) )
            {
                var_0.inwater = 1;

                if ( !isdefined( var_0.water_trigger_current ) )
                    var_0 thread aiinwater( var_2 );
            }
        }

        waitframe();
    }
}

aiinwater( var_0 )
{
    self notify( "aiInWater" );
    self endon( "aiInWater" );
    self endon( "death" );

    if ( isdefined( var_0 ) )
        self.water_trigger_current = var_0;

    if ( !isdefined( self.water_lastemerge ) )
        self.water_lastemerge = 0;

    if ( !isdefined( self.ent_flag ) || !isdefined( self.ent_flag["water_trigger_paused"] ) )
        maps\_utility::ent_flag_init( "water_trigger_paused" );

    if ( !isdefined( self.mechdata ) || !self.mechdata.active )
        thread inwaterwake();

    for (;;)
    {
        maps\_utility::ent_flag_waitopen( "water_trigger_paused" );
        var_1 = 0;

        if ( isdefined( var_0 ) && self istouching( var_0 ) )
            var_1 = 1;
        else
        {
            foreach ( var_3 in level.underwatertriggers )
            {
                if ( ( !isdefined( var_0 ) || var_3 != var_0 ) && self istouching( var_3 ) )
                {
                    var_1 = 1;
                    var_0 = var_3;
                    self.water_trigger_current = var_3;
                    break;
                }
            }
        }

        if ( var_1 && !isdefined( self.underwater ) && !isabovewaterline( var_0 ) && gettime() - self.water_lastemerge > 700 )
            ai_enable_swim_or_underwater_walk();

        if ( isdefined( self.underwater ) && ( isabovewaterline( var_0 ) || !var_1 ) )
        {
            ai_disable_swim_or_underwater_walk();
            self.water_lastemerge = gettime();
        }

        if ( isdefined( self.water_trigger_current ) && var_1 )
            ai_water_set_depth( water_depth_below( self.water_trigger_current ) );
        else
            ai_water_set_depth( 0 );

        if ( !var_1 )
        {
            self.inwater = undefined;
            self.water_trigger_current = undefined;
            ai_disable_swim_or_underwater_walk();
            self notify( "out_of_water" );
            break;
        }

        wait 0.05;
    }
}

ai_water_set_depth( var_0 )
{
    var_1 = water_depth_state( var_0 );
    var_2 = "none";

    if ( isdefined( self.water_depth ) )
        var_2 = water_depth_state( self.water_depth );

    if ( var_0 > 0 )
        self.water_depth = var_0;
    else
        self.water_depth = undefined;

    if ( isdefined( self.mechdata ) && self.mechdata.active )
        return;

    if ( var_2 != var_1 )
    {
        switch ( var_1 )
        {
            case "ankle":
                thread ai_wading_footsteps( "_ankle" );
                break;
            case "knee":
                thread ai_wading_footsteps( "_knee" );
                break;
            case "thigh":
            case "chest":
                thread ai_wading_footsteps( "_waist" );
                break;
            case "deep":
            case "puddle":
            default:
                thread ai_wading_footsteps();
                break;
        }
    }
}

ai_wading_footsteps( var_0 )
{
    self notify( "ai_wading_footsteps" );
    self endon( "ai_wading_footsteps" );
    self endon( "death" );
    self.playfootstepoverride = undefined;

    if ( isdefined( var_0 ) )
    {
        self.playfootstepoverride = ::ai_water_footstep;
        self.water_foley_type = var_0;
    }
}

ai_water_footstep( var_0, var_1 )
{
    self notify( "ai_water_footstep" );
    self endon( "ai_water_footstep" );
    self endon( "death" );
    self.water_step = animscripts\notetracks::get_notetrack_movement();
    aud_water_footsteps_foley( self.water_step, self.water_foley_type, "" );
    self.water_wake_speed = 100;

    if ( self.water_step == "run" )
        self.water_wake_speed = 75;
    else if ( self.water_step == "walk" )
        self.water_wake_speed = 50;

    wait 2;
    self.water_wake_speed = 0;
}

get_underwater_walk_speed_scale_ai()
{
    var_0 = getdvarfloat( "underwater_walk_speed_scale_ai" );
    return var_0;
}

ai_enable_swim_or_underwater_walk()
{
    self.underwater = 1;

    if ( !isdefined( self.mech ) || !self.mech )
        self.swimming = 1;
    else
        self.underwater_walk = 1;

    if ( isdefined( self.swimming ) )
        return;

    if ( isdefined( self.underwater_walk ) )
    {
        maps\_utility::set_moveplaybackrate( get_underwater_walk_speed_scale_ai(), undefined, 1 );
        maps\_utility::walkdist_force_walk();
    }
    else
    {

    }
}

ai_disable_swim_or_underwater_walk()
{
    self.underwater = 0;

    if ( isdefined( self.swimming ) )
        self.swimming = undefined;
    else if ( isdefined( self.underwater_walk ) )
    {
        maps\_utility::walkdist_reset();
        maps\_utility::restore_moveplaybackrate( 1.0, 1 );
        self.underwater_walk = undefined;
    }
}
