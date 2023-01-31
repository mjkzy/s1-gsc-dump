// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\utility::flag_init( "use_fastzip_hint" );
    common_scripts\utility::flag_init( "flag_zipline_fire_button_pressed" );
    maps\_utility::add_control_based_hint_strings( "hint_use_fastzip", &"FASTZIP_HARPOON_SWITCH", ::should_end_fastzip_hint );
    maps\_utility::add_control_based_hint_strings( "hint_fire_fastzip", &"FASTZIP_FIRE_ZIPLINE", ::should_end_fastzip_fire_hint );
    precacheturret( "zipline_gun_player" );
    load_fx();
    load_model_anims();
    load_player_anims();
}

load_fx()
{
    level._effect["zipline_flash_view"] = loadfx( "vfx/muzzleflash/zipline_flash_view" );
    level._effect["harpoon_dust"] = loadfx( "vfx/trail/harpoon_dust" );
    level._effect["landing_target_valid"] = loadfx( "fx/misc/ui_flagbase_gold" );
    level._effect["landing_target_invalid"] = loadfx( "fx/misc/ui_flagbase_red" );
}

#using_animtree("script_model");

load_model_anims()
{
    level.scr_anim["_turret_fastzip"]["fastzip_aim_idle"] = %fastzip_launcher_ads;
}

#using_animtree("player");

load_player_anims()
{
    level.scr_anim["_player_arms_fastzip"]["fastzip_pullout"] = %fastzip_launcher_pullout_vm;
    level.scr_anim["_player_arms_fastzip"]["fastzip_ads"] = %fastzip_launcher_ads_vm;
    level.scr_anim["_player_arms_fastzip"]["fastzip_putaway"] = %fastzip_launcher_putaway_vm;
    level.scr_anim["_player_arms_fastzip"]["fastzip_land"] = %fastzip_launcher_land_vm;
}

should_end_fastzip_hint()
{
    return common_scripts\utility::flag( "use_fastzip_hint" );
}

should_end_fastzip_fire_hint()
{
    return common_scripts\utility::flag( "flag_zipline_fire_button_pressed" );
}

fire_hint_display()
{
    self endon( "flag_zipline_fire_button_pressed" );
    wait 4;

    if ( !common_scripts\utility::flag( "flag_zipline_fire_button_pressed" ) )
        maps\_utility::hintdisplayhandler( "hint_fire_fastzip" );
}

copy_script_model( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1 maps\_utility::assign_animtree( var_0.animname );
    var_1 _meth_80B1( var_0.model );
    return var_1;
}

fastzip_turret_think( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4 = copy_script_model( var_2 );
    var_4.animname = "_player_arms_fastzip";
    var_4 hide();
    var_5 = getentarray( "valid_landing", "targetname" );
    wait_for_player_switch_to_turret();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    level.player _meth_8301( 0 );
    var_6 = getdvarint( "turret_adsEnabled", 1 );
    _func_0D3( "turret_adsEnabled", 0 );
    waittillframeend;
    self notify( "using_zip" );
    var_7 = var_0.zipline_gun_model[var_1];
    var_8 = vehicle_scripts\_xh9_warbird::setup_zipline_gun( "zipline_gun_player", var_0, var_1, var_7.model, var_7.rope_model, "_turret_fastzip" );
    var_9 = vehicle_scripts\_xh9_warbird::setup_zipline_gun( "zipline_gun_rope", var_0, var_1, var_7.rope_model, undefined, "_turret_fastzip" );
    fastzip_turret_pullout( var_0, var_1, var_4, var_7 );
    var_8 show();
    var_4 hide();
    var_8 makeusable();
    var_8 _meth_8065( "manual" );
    var_9 _meth_8065( "manual" );
    var_8 _meth_8099( self );
    var_8 _meth_815C();
    self _meth_80F4();
    var_8 makeunusable();
    var_8.ground_target = common_scripts\utility::spawn_tag_origin();
    var_9 _meth_8106( var_8.ground_target, ( 0, 0, 0 ) );
    thread fire_hint_display();
    wait_to_fire_rope( var_0, var_8, var_5 );
    self _meth_80AD( "damage_heavy" );
    var_10 = var_9 fire_rope( var_8, var_8.ground_target.origin, var_7 );
    var_8 set_landing_target_fx( undefined );
    var_8 _meth_8099( self );
    var_8 _meth_8106( var_8.ground_target );
    _func_0D3( "turret_adsEnabled", var_6 );
    fastzip_turret_putaway( var_0, var_1, var_4, var_8, var_7 );
    thread player_fastzip( var_9, var_8.ground_target.origin, var_4, var_3 );
    var_11 = maps\_utility::get_rumble_ent( "steady_rumble" );
    var_11.intensity = 0.2;
    self waittill( "fastzip_arrived" );
    stopallrumbles();
    self waittill( "fastzip_landed" );
    var_4 delete();
    self _meth_80AD( "damage_heavy" );
    wait 0.5;
    var_9 retract_rope( var_10, "left" );
    var_9 delete();
    var_8.ground_target delete();
    var_8 delete();
}

fastzip_turret_pullout( var_0, var_1, var_2, var_3 )
{
    var_2 _meth_804D( var_0, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_4 = [];
    var_4[0] = var_2;
    var_4[1] = var_3;
    var_3 clear_script_model_anim( 0 );
    soundscripts\_snd::snd_message( "fastzip_turret_switch_to" );
    var_0 maps\_anim::anim_first_frame( var_4, "fastzip_pullout", var_1 );
    var_5 = 0.15;
    level.player _meth_8080( var_2, "tag_player", var_5 );
    level.player common_scripts\utility::delaycall( var_5, ::_meth_807D, var_2, "tag_player", 1, 0, 0, 0, 0, 1 );
    var_2 common_scripts\utility::delaycall( var_5, ::show );
    maps\_utility::delaythread( 1.2, maps\_utility::lerp_fov_overtime, 2, 55 );
    var_0 maps\_anim::anim_single( var_4, "fastzip_pullout", var_1 );
    var_2 maps\_utility::anim_stopanimscripted();
    var_2 _meth_814B( level.scr_anim["_player_arms_fastzip"]["fastzip_ads"], 1, 0, 1 );
    var_2 _meth_804F();
    var_3 hide();

    if ( isdefined( var_3.attachment ) )
        var_3.attachment hide();

    soundscripts\_snd::snd_message( "fastzip_turret_switch_complete" );
    self _meth_804F();
}

set_landing_target_fx( var_0 )
{
    if ( !isdefined( self.current_landing_fx ) )
    {
        if ( isdefined( var_0 ) )
        {
            self.current_landing_fx = var_0;
            playfxontag( common_scripts\utility::getfx( self.current_landing_fx ), self.ground_target, "tag_origin" );
        }

        return;
    }

    if ( isdefined( self.current_landing_fx ) && !isdefined( var_0 ) )
    {
        stopfxontag( common_scripts\utility::getfx( self.current_landing_fx ), self.ground_target, "tag_origin" );
        self.current_landing_fx = undefined;
        return;
    }

    if ( self.current_landing_fx != var_0 )
    {
        stopfxontag( common_scripts\utility::getfx( self.current_landing_fx ), self.ground_target, "tag_origin" );
        self.current_landing_fx = var_0;
        playfxontag( common_scripts\utility::getfx( self.current_landing_fx ), self.ground_target, "tag_origin" );
    }
}

wait_to_fire_rope( var_0, var_1, var_2 )
{
    var_1.ground_target.angles = ( -90, 0, 0 );
    var_1.current_landing_fx = undefined;

    for (;;)
    {
        var_3 = var_1 gettagorigin( "tag_player" );
        var_4 = var_1 gettagangles( "tag_player" );
        var_5 = vectornormalize( anglestoforward( var_4 ) );
        var_6 = var_3 + var_5 * 100;
        var_7 = var_3 + var_5 * 10000;
        var_8 = 0;
        var_1.ground_target.origin = var_7;
        var_9 = bullettrace( var_6, var_7, 0 );

        if ( isdefined( var_9["position"] ) )
        {
            var_1.ground_target.origin = var_9["position"];

            foreach ( var_11 in var_2 )
            {
                if ( var_1.ground_target _meth_80A9( var_11 ) )
                {
                    var_8 = 1;
                    var_1 set_landing_target_fx( "landing_target_valid" );
                    break;
                }
            }

            if ( var_8 )
            {
                if ( self attackbuttonpressed() )
                {
                    common_scripts\utility::flag_set( "flag_zipline_fire_button_pressed" );
                    soundscripts\_snd::snd_message( "fastzip_turret_fire" );
                    return;
                }
            }
            else
                var_1 set_landing_target_fx( "landing_target_invalid" );
        }
        else
            var_1 set_landing_target_fx( undefined );

        wait 0.05;
    }
}

#using_animtree("script_model");

fire_rope( var_0, var_1, var_2 )
{
    var_3 = 200;
    var_4 = 210;
    var_5 = var_4 / 30;
    var_0 detach( var_2.rope_model );
    var_2 detach( var_2.rope_model );
    self show();
    var_6 = var_0 gettagorigin( "tag_player" );
    var_7 = distance( var_6, var_1 ) / 12;
    var_8 = var_7 / var_3;
    playfxontag( common_scripts\utility::getfx( "harpoon_dust" ), self, "jnt_harpoon" );
    playfxontag( common_scripts\utility::getfx( "zipline_flash_view" ), self, "TAG_FLASH" );
    var_9 = %fastzip_launcher_fire_left;
    var_10 = getanimlength( var_9 );
    var_11 = var_10 / var_5 * var_8;
    self _meth_8143( var_9, 1, 0.2, var_5 );
    var_0 _meth_8143( var_9, 1, 0.2, 1 );
    var_11 -= 0.05;

    if ( var_11 > 0.05 )
        wait(var_11);

    self _meth_814B( var_9, 1, 0, 0 );
    self _meth_8117( var_9, var_8 );
    return var_7;
}

fastzip_turret_putaway( var_0, var_1, var_2, var_3, var_4 )
{
    thread maps\_utility::lerp_fov_overtime( 2, 65 );
    var_3 hide();
    var_4 show();

    if ( isdefined( var_4.attachment ) )
        var_4.attachment show();

    var_5 = [];
    var_5[0] = var_2;
    var_5[1] = var_4;
    var_3 clear_script_model_anim( 0.2 );
    var_0 maps\_anim::anim_first_frame( var_5, "fastzip_putaway", var_1 );
    self _meth_807D( var_2, "tag_player", 1, 0, 0, 0, 0, 1 );
    soundscripts\_snd::snd_message( "fastzip_turret_putaway" );
    self setangles( self getangles() );
    wait 0.2;
    var_2 show();
    var_0 maps\_anim::anim_single( var_5, "fastzip_putaway", var_1 );
    var_4 maps\_utility::anim_stopanimscripted();
    var_4 clear_script_model_anim( 0 );
    var_4 _meth_814B( %fastzip_launcher_folded_idle_left, 1, 0, 1 );
}

player_fastzip( var_0, var_1, var_2, var_3 )
{
    thread player_camera_shake();
    self notify( "fastzip_start" );
    var_4 = %fastzip_launcher_slidedown_left;
    var_0 _meth_814C( %add_slide, 1, 0, 1 );
    var_0 _meth_814C( var_4, 1, 0, 1 );
    self _meth_807D( var_0, "TAG_PLAYER_ATTACH", 1, 20, 20, 20, 20, 1 );
    soundscripts\_snd::snd_message( "fastzip_rappel" );

    if ( isdefined( var_3 ) )
        wait(var_3);
    else
        wait 0.05;

    var_5 = self.origin;
    var_6["fraction"] = 1;
    var_7 = ( 0, 0, 0 );

    for ( var_8 = ( 0, 0, 0 ); var_6["fraction"] == 1; var_5 = var_9 )
    {
        wait 0.05;
        var_9 = self.origin;
        var_8 = var_9 - var_5;
        var_7 = var_8 * 3;
        var_6 = bullettrace( var_9, var_9 + var_7, 0, self );
    }

    self _meth_804F();
    self notify( "kill_camera_shake" );
    thread player_fastzip_land( var_8, var_2 );
    self notify( "fastzip_arrived" );
    var_0 _meth_814C( var_4, 1, 0, 0 );
}

player_fastzip_land( var_0, var_1 )
{
    var_2 = var_0 * 20;
    self _meth_82F1( var_2 );
    thread prevent_look_until_notify( "fastzip_hit_the_ground" );
    var_3 = undefined;

    while ( !self _meth_8341() )
    {
        var_3 = self getvelocity();
        wait 0.05;
    }

    self notify( "fastzip_hit_the_ground" );
    soundscripts\_snd::snd_message( "fastzip_hit_the_ground" );
    var_4 = vectortoangles( var_0 );
    var_5 = spawnstruct();
    var_5.origin = self.origin;
    var_5.angles = ( 0, var_4[1] + 90, 0 );
    var_5 maps\_anim::anim_first_frame_solo( var_1, "fastzip_land" );
    var_6 = getmovedelta( var_1 maps\_utility::getanim( "fastzip_land" ), 0, 1 );
    var_7 = var_1 _meth_81B0( var_6 );
    var_8 = var_7 + ( 0, 0, 24 );
    var_9 = _func_238( var_7, var_8 );

    if ( var_9["fraction"] > 0 )
        var_8 = var_9["position"] - ( 0, 0, 1 );

    var_9 = _func_238( var_8, var_8 - ( 0, 0, 36 ) );

    if ( var_9["fraction"] > 0 )
    {
        if ( var_9["fraction"] < 1 )
        {
            var_10 = var_9["position"];
            var_11 = var_10 - var_7;
            var_5.origin += var_11;
        }

        self _meth_807D( var_1, "tag_player", 1, 20, 20, 20, 20, 1 );
        var_5 maps\_anim::anim_single_solo( var_1, "fastzip_land" );
        self _meth_804F();
    }
    else
    {

    }

    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player _meth_8301( 1 );
    self notify( "fastzip_landed" );
}

prevent_look_until_notify( var_0 )
{
    var_1 = getdvarint( "aim_turnrate_pitch" );
    var_2 = getdvarint( "aim_turnrate_pitch_ads" );
    var_3 = getdvarint( "aim_turnrate_yaw" );
    var_4 = getdvarint( "aim_turnrate_yaw_ads" );
    _func_0D3( "aim_turnrate_pitch", 0 );
    _func_0D3( "aim_turnrate_pitch_ads", 0 );
    _func_0D3( "aim_turnrate_yaw", 0 );
    _func_0D3( "aim_turnrate_yaw_ads", 0 );
    self waittill( var_0 );
    _func_0D3( "aim_turnrate_pitch", var_1 );
    _func_0D3( "aim_turnrate_pitch_ads", var_2 );
    _func_0D3( "aim_turnrate_yaw", var_3 );
    _func_0D3( "aim_turnrate_yaw_ads", var_4 );
}

player_camera_shake()
{
    self endon( "fastzip_arrived" );
    self endon( "kill_camera_shake" );
    var_0 = 0.1;
    var_1 = 0.8;
    var_2 = 0.1;
    var_3 = 0.45;
    var_4 = var_1;

    for (;;)
    {
        earthquake( min( var_0, var_3 ), var_2, self.origin, 100 );
        wait(var_2);
        var_4 -= var_2;

        if ( var_4 < 0 )
        {
            var_0 += 0.1;
            var_4 = var_1;
        }
    }
}

player_camera_shake_land()
{
    self endon( "kill_camera_shake" );
    var_0 = 0.5;

    for ( var_1 = 0.2; var_0 > 0; var_0 -= 0.1 )
    {
        earthquake( var_0, var_1, self.origin, 100 );
        wait(var_1);
    }
}

retract_rope( var_0, var_1 )
{
    var_2 = 200;
    var_3 = var_0 / var_2;
    var_3 = 1 - min( var_3, 1 );
    var_4 = 30;
    var_5 = 1;
    var_6 = %fastzip_launcher_retract_left;

    if ( var_1 == "right" )
        var_6 = %fastzip_launcher_retract_right;

    self _meth_8143( var_6, 1, 0.2, var_5 );
    self _meth_8117( var_6, var_3 );
    var_7 = var_4 * ( 1 - var_3 ) / 30 * var_5;
    wait(var_7 + 0.05);
}

clear_script_model_anim( var_0 )
{
    self _meth_8142( %root, var_0 );
}

#using_animtree("player");

clear_player_anim()
{
    self _meth_8142( %root, 0 );
}

wait_for_player_to_complete_reloading()
{
    while ( level.player _meth_8336() )
        waitframe();
}

wait_for_player_switch_to_turret()
{
    thread display_hint_until_zip_activated();
    var_0 = 0;

    while ( var_0 < 1 )
    {
        var_0 = 0;

        while ( level.player usebuttonpressed() && var_0 < 1 )
        {
            var_0 += 0.1;
            waitframe();
        }

        waitframe();
    }

    common_scripts\utility::flag_set( "use_fastzip_hint" );
}

display_hint_until_zip_activated()
{
    self endon( "using_zip" );

    for (;;)
    {
        maps\_utility::hintdisplayhandler( "hint_use_fastzip" );
        wait 35;
    }
}
