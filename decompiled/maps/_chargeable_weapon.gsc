// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_charged_shot()
{
    level._effect["charged_shot_tracer_low"] = loadfx( "vfx/trail/charged_shot_1_trail" );
    level._effect["charged_shot_tracer_med"] = loadfx( "vfx/trail/charged_shot_2_trail" );
    level._effect["charged_shot_tracer_high"] = loadfx( "vfx/trail/charged_shot_3_trail" );
    level._effect["charged_shot_impact_low"] = loadfx( "vfx/weaponimpact/charged_shot_impact_1" );
    level._effect["charged_shot_impact_med"] = loadfx( "vfx/weaponimpact/charged_shot_impact_2" );
    level._effect["charged_shot_impact_high"] = loadfx( "vfx/weaponimpact/charged_shot_impact_3" );
    level._effect["charged_shot_character_smoke"] = loadfx( "vfx/smoke/charged_shot_character_smoke" );
    soundscripts\_snd::snd_message( "wpn_deam160_init" );
    precacherumble( "steady_rumble" );

    foreach ( var_1 in level.players )
    {
        var_1 thread monitor_charge_time();
        var_1 thread player_handle_charged_shot();
    }
}

cleanup()
{
    player_cleanup_rumble();
    player_cleanup_reticle();
    player_cleanup_charge_indicator();
    player_cleanup_sound();
}

get_max_charge_time()
{
    var_0 = _func_239( self _meth_8311() );
    var_1 = _func_23A( self _meth_8311() );
    var_2 = _func_23B( self _meth_8311() );
    var_3 = var_0 + var_1 * var_2;
    return var_3;
}

monitor_player_death()
{
    self waittill( "death" );
    cleanup();
}

monitor_charge_time()
{
    self endon( "death" );
    player_init_rumble();
    player_init_reticle();
    player_init_charge_indicator();
    player_init_sound();
    thread monitor_player_death();
    var_0 = 0;
    var_1 = 1;

    for (;;)
    {
        var_2 = _func_23C( self _meth_8311() );
        var_3 = var_2 && !self _meth_812C() && !self _meth_8336() && !self _meth_812E() && !self ismantling();
        var_4 = level.player _meth_83AA();

        if ( var_3 )
        {
            var_5 = var_0 == 0 && var_4 > 0;
            var_6 = var_0 > 0 && var_4 == 0;
            var_7 = _func_239( self _meth_8311() );
            var_8 = get_max_charge_time();
            var_1 = 0;
            player_do_rumble( var_4, var_7, var_8 );
            player_do_reticle( var_4, var_7, var_8 );
            player_do_charge_indicator( var_4, var_7, var_8, var_0 );
            player_do_sound( var_4, var_5, var_6 );
            player_do_camera_shake( var_4, var_7, var_8 );
        }
        else if ( !var_1 )
        {
            cleanup();
            var_1 = 1;
        }

        var_0 = var_4;
        wait 0.05;
    }
}

player_handle_charged_shot()
{
    self endon( "death" );

    for (;;)
    {
        level.player waittill( "energy_fire", var_0 );
        var_1 = _func_239( level.player _meth_8311() );
        var_2 = level.player get_max_charge_time();
        thread player_charged_shot( var_0, var_1, var_2 );
    }
}

set_default_hud_parameters()
{
    self.alignx = "left";
    self.aligny = "top";
    self.horzalign = "center";
    self.vertalign = "middle";
    self.hidewhendead = 0;
    self.hidewheninmenu = 0;
    self.sort = 205;
    self.foreground = 1;
    self.alpha = 0.65;
}

player_init_sound()
{
    if ( isdefined( self.charged_shot_soundent ) )
        self.charged_shot_soundent delete();

    self.charged_shot_soundent = common_scripts\utility::spawn_tag_origin();
}

player_do_sound( var_0, var_1, var_2 )
{
    self.charged_shot_soundent.origin = self.origin;
    self.charged_shot_soundent.angles = self.angles;

    if ( var_1 )
        soundscripts\_snd::snd_message( "wpn_deam160_charge" );

    if ( var_2 )
        level notify( "aud_deam160_charge_break" );
}

player_cleanup_sound()
{
    self.charged_shot_soundent _meth_80AB();
}

player_init_reticle()
{
    precacheshader( "charged_shot_reticle" );
    precacheshader( "charged_shot_reticle_corner_tl" );
    precacheshader( "charged_shot_reticle_corner_bl" );
    precacheshader( "charged_shot_reticle_corner_tr" );
    precacheshader( "charged_shot_reticle_corner_br" );
    self.charged_shot_reticle_corners = [];
    self.charged_shot_reticle = maps\_hud_util::createicon( "charged_shot_reticle", 16, 16 );
    self.charged_shot_reticle set_default_hud_parameters();
    self.charged_shot_reticle.alignx = "center";
    self.charged_shot_reticle.aligny = "middle";
    self.charged_shot_reticle_corners["tl"] = maps\_hud_util::createicon( "charged_shot_reticle_corner_tl", 16, 16 );
    self.charged_shot_reticle_corners["tl"] set_default_hud_parameters();
    self.charged_shot_reticle_corners["tl"].alignx = "right";
    self.charged_shot_reticle_corners["tl"].aligny = "bottom";
    self.charged_shot_reticle_corners["tr"] = maps\_hud_util::createicon( "charged_shot_reticle_corner_tr", 16, 16 );
    self.charged_shot_reticle_corners["tr"] set_default_hud_parameters();
    self.charged_shot_reticle_corners["tr"].alignx = "left";
    self.charged_shot_reticle_corners["tr"].aligny = "bottom";
    self.charged_shot_reticle_corners["bl"] = maps\_hud_util::createicon( "charged_shot_reticle_corner_bl", 16, 16 );
    self.charged_shot_reticle_corners["bl"] set_default_hud_parameters();
    self.charged_shot_reticle_corners["bl"].alignx = "right";
    self.charged_shot_reticle_corners["bl"].aligny = "top";
    self.charged_shot_reticle_corners["br"] = maps\_hud_util::createicon( "charged_shot_reticle_corner_br", 16, 16 );
    self.charged_shot_reticle_corners["br"] set_default_hud_parameters();
    self.charged_shot_reticle_corners["br"].alignx = "left";
    self.charged_shot_reticle_corners["br"].aligny = "top";
    player_cleanup_reticle();
}

player_do_reticle( var_0, var_1, var_2 )
{
    if ( var_0 > var_1 )
    {
        var_3 = compute_spread( var_0, var_1, var_2 );
        var_4 = tan( var_3 );
        var_5 = var_4 * 620;
        var_6 = var_4 * 620;
        self.charged_shot_reticle.alpha = 1;
        self.charged_shot_reticle _meth_80CC( "charged_shot_reticle", int( var_6 ), int( var_6 ) );
        var_7 = var_4 * 320;
        var_8 = var_4 * 320;
        var_5 = clamp( var_4, 16, 32 );
        var_6 = clamp( var_4, 16, 24 );
        self.charged_shot_reticle_corners["tl"].x = -2 - var_7;
        self.charged_shot_reticle_corners["tl"].y = -2 - var_8;
        self.charged_shot_reticle_corners["tl"].alpha = 1;
        self.charged_shot_reticle_corners["tl"] _meth_80CC( "charged_shot_reticle_corner_tl", int( var_5 ), int( var_6 ) );
        self.charged_shot_reticle_corners["tr"].x = 2 + var_7;
        self.charged_shot_reticle_corners["tr"].y = -2 - var_8;
        self.charged_shot_reticle_corners["tr"].alpha = 1;
        self.charged_shot_reticle_corners["tr"] _meth_80CC( "charged_shot_reticle_corner_tr", int( var_5 ), int( var_6 ) );
        self.charged_shot_reticle_corners["bl"].x = -2 - var_7;
        self.charged_shot_reticle_corners["bl"].y = 2 + var_8;
        self.charged_shot_reticle_corners["bl"].alpha = 1;
        self.charged_shot_reticle_corners["bl"] _meth_80CC( "charged_shot_reticle_corner_bl", int( var_5 ), int( var_6 ) );
        self.charged_shot_reticle_corners["br"].x = 2 + var_7;
        self.charged_shot_reticle_corners["br"].y = 2 + var_8;
        self.charged_shot_reticle_corners["br"].alpha = 1;
        self.charged_shot_reticle_corners["br"] _meth_80CC( "charged_shot_reticle_corner_br", int( var_5 ), int( var_6 ) );
        player_set_all_reticle_colors( ( 1, 1, 1 ) );
    }
    else
        player_restore_reticle();
}

player_restore_reticle()
{
    self.charged_shot_reticle.alpha = 1;
    self.charged_shot_reticle_corners["tl"].alpha = 1;
    self.charged_shot_reticle_corners["tr"].alpha = 1;
    self.charged_shot_reticle_corners["bl"].alpha = 1;
    self.charged_shot_reticle_corners["br"].alpha = 1;
    self.charged_shot_reticle_corners["tl"].x = -2;
    self.charged_shot_reticle_corners["tl"].y = -2;
    self.charged_shot_reticle_corners["tr"].x = 2;
    self.charged_shot_reticle_corners["tr"].y = -2;
    self.charged_shot_reticle_corners["bl"].x = -2;
    self.charged_shot_reticle_corners["bl"].y = 2;
    self.charged_shot_reticle_corners["br"].x = 2;
    self.charged_shot_reticle_corners["br"].y = 2;
    self.charged_shot_reticle _meth_80CC( "charged_shot_reticle", 16, 16 );
    self.charged_shot_reticle_corners["tl"] _meth_80CC( "charged_shot_reticle_corner_tl", 16, 16 );
    self.charged_shot_reticle_corners["bl"] _meth_80CC( "charged_shot_reticle_corner_bl", 16, 16 );
    self.charged_shot_reticle_corners["tr"] _meth_80CC( "charged_shot_reticle_corner_tr", 16, 16 );
    self.charged_shot_reticle_corners["br"] _meth_80CC( "charged_shot_reticle_corner_br", 16, 16 );
    player_set_all_reticle_colors( ( 1, 1, 1 ) );
}

player_cleanup_reticle()
{
    self.charged_shot_reticle.alpha = 0;
    self.charged_shot_reticle_corners["tl"].alpha = 0;
    self.charged_shot_reticle_corners["tr"].alpha = 0;
    self.charged_shot_reticle_corners["bl"].alpha = 0;
    self.charged_shot_reticle_corners["br"].alpha = 0;
}

player_init_rumble()
{
    self.charged_shot_rumble_ent = common_scripts\utility::spawn_tag_origin();
}

player_do_rumble( var_0, var_1, var_2 )
{
    var_3 = maps\_shg_utility::linear_map_clamp( var_0, var_1, var_2, 0, 0.1 );

    if ( var_3 > 0 )
    {
        if ( !isdefined( self.charged_shot_rumble_ent.rumbling ) )
        {
            self.charged_shot_rumble_ent.rumbling = 1;
            self.charged_shot_rumble_ent _meth_80AE( "steady_rumble" );
        }

        self.charged_shot_rumble_ent.origin = self.origin + ( 0, 0, ( 1 - clamp( var_3, 0, 1 ) ) * 1000 );
    }
    else
        player_cleanup_rumble();
}

player_cleanup_rumble()
{
    if ( isdefined( self.charged_shot_rumble_ent.rumbling ) )
    {
        self.charged_shot_rumble_ent _meth_80AF( "steady_rumble" );
        self.charged_shot_rumble_ent.rumbling = undefined;
    }
}

player_init_charge_indicator()
{
    for ( var_0 = 1; var_0 <= 4; var_0++ )
        precacheshader( "charged_shot_reticle_pip" + var_0 );

    self.charge_indicator_hud = maps\_hud_util::createicon( "charged_shot_reticle_pip1", 32, 32 );
    self.charge_indicator_hud set_default_hud_parameters();
    self.charge_indicator_hud.sort = 1;
    self.charge_indicator_hud.horzalign = "fullscreen";
    self.charge_indicator_hud.alignx = "center";
    self.charge_indicator_hud.vertalign = "fullscreen";
    self.charge_indicator_hud.x = 320;
    self.charge_indicator_hud.y = 170;
    self.charge_indicator_hud.color = ( 1, 1, 1 );
    self.charge_indicator_hud.alpha = 0;
}

player_set_all_reticle_colors( var_0 )
{
    self.charge_indicator_hud.color = var_0;
    self.charged_shot_reticle.color = var_0;
    self.charged_shot_reticle_corners["tl"].color = var_0;
    self.charged_shot_reticle_corners["tr"].color = var_0;
    self.charged_shot_reticle_corners["bl"].color = var_0;
    self.charged_shot_reticle_corners["br"].color = var_0;
}

player_color_pulse( var_0 )
{
    var_1 = var_0;
    var_2 = 25;
    soundscripts\_snd::snd_message( "wpn_deam160_full_charge" );

    while ( level.player _meth_83AA() >= get_max_charge_time() )
    {
        var_1 += var_2;
        var_3 = ( sin( var_1 - var_0 ) + 1.0 ) * 0.5;
        self.charge_indicator_hud.color = ( var_3, var_3, var_3 );
        var_2 = min( 45, var_2 + 0.5 );
        waitframe();
    }

    self.charge_indicator_hud.color = ( 1, 1, 1 );
    level notify( "aud_deam160_charge_break" );
}

player_do_charge_indicator( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;

    if ( var_2 > 0 )
    {
        var_5 = int( maps\_shg_utility::linear_map_clamp( var_3, 0, var_2, 0, 4 ) );
        var_4 = int( maps\_shg_utility::linear_map_clamp( var_0, 0, var_2, 0, 4 ) );

        if ( var_5 < var_4 )
            soundscripts\_snd::snd_message( "wpn_deam160_charge_dots_increase" );
    }

    if ( var_4 > 0 )
    {
        self.charge_indicator_hud.alpha = 1;
        self.charge_indicator_hud _meth_80CC( "charged_shot_reticle_pip" + var_4, 32, 32 );
    }
    else
        self.charge_indicator_hud.alpha = 0;

    if ( var_0 >= var_2 && var_3 != var_0 )
        thread player_color_pulse( var_0 );
}

player_cleanup_charge_indicator()
{
    self.charge_indicator_hud.alpha = 0;
}

player_do_camera_shake( var_0, var_1, var_2 )
{
    if ( var_0 > var_1 )
    {
        var_3 = maps\_shg_utility::linear_map_clamp( var_0, var_1, var_2, 0.01, 0.1 );
        earthquake( var_3, 0.2, self.origin, 512 );
    }
}

compute_spread( var_0, var_1, var_2 )
{
    return maps\_shg_utility::linear_map_clamp( var_0, var_1, var_2, 1, 5 );
}

play_charged_shot_fx( var_0, var_1, var_2 )
{
    var_3 = var_2 - var_1;
    var_4 = var_1 + var_3 * 0.2;
    var_5 = var_2;
    var_6 = self _meth_8036();
    var_7 = anglestoforward( var_6 );
    var_8 = transformmove( self _meth_80A8(), var_6, ( 0, 0, 0 ), ( 0, 0, 0 ), ( 4, 0, -1 ), ( 0, 0, 0 ) )["origin"];
    var_9 = var_8 + 1000 * var_7;
    var_10 = anglestoup( var_6 );
    var_11 = anglestoright( var_6 );
    var_12 = undefined;
    var_13 = undefined;

    if ( var_0 >= var_5 )
    {
        var_12 = common_scripts\utility::getfx( "charged_shot_impact_high" );
        var_13 = common_scripts\utility::getfx( "charged_shot_tracer_high" );
        soundscripts\_snd::snd_message( "wpn_deam160_shot", "large" );
    }
    else if ( var_0 >= var_4 )
    {
        var_12 = common_scripts\utility::getfx( "charged_shot_impact_med" );
        var_13 = common_scripts\utility::getfx( "charged_shot_tracer_med" );
        soundscripts\_snd::snd_message( "wpn_deam160_shot", "medium" );
    }
    else
    {
        var_12 = common_scripts\utility::getfx( "charged_shot_impact_low" );
        var_13 = common_scripts\utility::getfx( "charged_shot_tracer_low" );
        soundscripts\_snd::snd_message( "wpn_deam160_shot", "small" );
    }

    if ( isdefined( var_13 ) )
        playfx( var_13, var_8, var_7, var_10 );

    if ( isdefined( var_12 ) )
    {
        var_14 = bullettrace( var_8, var_9, 0, self, 0 );

        if ( var_14["fraction"] < 1 )
        {
            var_15 = var_14["position"];
            playfx( var_12, var_15, var_14["normal"] );
        }
    }
}

player_charged_shot( var_0, var_1, var_2 )
{
    var_3 = int( maps\_shg_utility::linear_map_clamp( var_0, var_1, var_2, 1, 5 ) );
    var_4 = maps\_shg_utility::linear_map_clamp( var_0, var_1, var_2, 0.1, 0.6 );
    var_5 = int( ( var_3 - 1 ) * 0.5 );
    thread play_charged_shot_fx( var_0, var_1, var_2 );

    for ( var_6 = 0; var_6 < var_3; var_6++ )
    {
        if ( var_6 == var_5 )
            earthquake( var_4, var_3 * 0.05 * 4, level.player.origin, 100 );

        waitframe();
    }
}

ai_detect_charged_damage()
{
    var_0 = spawnstruct();
    var_0 endon( "end_charged_shot_damage_thread" );
    thread ai_charged_shot_wait_for_death( var_0 );

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5 );

        if ( isdefined( self ) )
        {
            self.last_damage_pos = var_4;

            if ( isdefined( var_5 ) && var_5 == "MOD_ENERGY" )
                playfx( common_scripts\utility::getfx( "charged_shot_character_smoke" ), self.origin );

            if ( self.health <= 0 )
                break;
        }
    }
}

ai_charged_shot_wait_for_death( var_0 )
{
    level.player endon( "death" );
    self waittill( "death" );
    wait 0.05;
    var_0 notify( "end_charged_shot_damage_thread" );
}
