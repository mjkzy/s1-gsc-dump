// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level thread tracking_init();
}

tagging_set_enabled( var_0, var_1 )
{
    if ( !isdefined( self.tagging ) )
        tagging_init_player();

    if ( !isdefined( var_1 ) )
        var_1 = 4;

    self.tagging["enabled"] = var_0;
    self.tagging["action_slot"] = var_1;
    tagging_set_marking_enabled( var_0 );

    if ( !self.tagging["enabled"] )
    {
        self notify( "unsync" );
        tagging_highlight_hud_effect_remove( self );
    }
    else
        tagging_highlight_hud_effect_apply( self, -1 );

    thread tagging_set_binocs_enabled( self.tagging["enabled"] );
}

tagging_set_binocs_enabled( var_0 )
{
    return;
}

tagging_set_marking_enabled( var_0 )
{
    if ( !isdefined( self.tagging ) )
        tagging_init_player();

    self.tagging["marking_enabled"] = var_0;
    var_1 = tagging_enemy_list();

    if ( !self.tagging["marking_enabled"] )
    {
        foreach ( var_3 in var_1 )
        {
            var_3 tag_trace_update( "none", self );
            var_3 notify( "tagged_enemy_death_cleanup" );
            var_3 tagged_status_hide();
        }
    }
    else
    {
        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3.tagged ) && isdefined( var_3.tagged[self _meth_81B1()] ) )
                var_3 tag_enemy( self );
        }
    }
}

tagging_set_forced_mode( var_0, var_1 )
{
    if ( !isdefined( self.tagging ) )
        tagging_init_player();

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    self.tagging["forced_mode_fov"] = var_0;
    self.tagging["forced_mode_weap"] = var_1;
    self notify( "tagging_mode" );
}

tracking_init()
{
    precacheshader( "dpad_ar_visor" );
    precacheshader( "dpad_ar_visor_inactive" );
    precacheshader( "hud_ar_visor_arc" );
    precacheshader( "hud_ar_visor_large_focus_ring" );
    precacheshader( "hud_ar_visor_overlay" );
    precacheshader( "hud_ar_visor_sentinel_logo" );
    precacheshader( "hud_ar_visor_small_focus_ring" );
    precacheshader( "hud_ar_visor_spinner" );
    precacheshader( "hud_ar_visor_zoom_gauge" );
    setdvarifuninitialized( "tagging_ads_cone_range", 3000 );
    setdvarifuninitialized( "tagging_ads_cone_angle", 10.0 );
    setdvarifuninitialized( "tagging_normal_pulse_rate", 50 );
    setdvarifuninitialized( "tagging_normal_prep_time", 250 );
    setdvarifuninitialized( "tagging_normal_track_time", 500 );
    setdvarifuninitialized( "tagging_slow_pulse_rate", 100 );
    setdvarifuninitialized( "tagging_slow_prep_time", 500 );
    setdvarifuninitialized( "tagging_slow_track_time", 1000 );
    setdvarifuninitialized( "tagging_scan_fov_min", 55.0 );
    setdvarifuninitialized( "tagging_scan_fov_max", 25.0 );
    setdvarifuninitialized( "tagging_scan_range_min", 1500.0 );
    setdvarifuninitialized( "tagging_scan_range_max", 3000.0 );
    setdvarifuninitialized( "tagging_foliage", 0 );
    setdvarifuninitialized( "tagging_vehicle_ride", 0 );
    tagging_set_hud_outline_style();

    foreach ( var_1 in level.players )
        var_1 tagging_init_player();
}

tagging_set_hud_outline_style()
{
    _func_0D3( "r_hudoutlineenable", 1 );
    _func_0D3( "r_hudoutlinewidth", 1 );
    _func_0D3( "r_hudoutlinealpha0", 0.75 );
    _func_0D3( "r_hudoutlinepostmode", 2 );
    _func_0D3( "r_hudoutlinewhen", "after_colorize" );
}

tagging_init_player()
{
    self.tagging = [];
    self.tagging["enabled"] = 1;
    self.tagging["marking_enabled"] = 1;
    self.tagging["outline_enabled"] = 1;
    self.tagging["tagging_mode"] = 0;
    self.tagging["hint"] = undefined;
    self.tagging["hintText"] = undefined;
    self.tagging["last_tag_start"] = 0;
    self.tagging["action_slot"] = 4;
    self.tagging["tagging_fade_min"] = 500.0;
    self.tagging["tagging_fade_max"] = 3000.0;
    thread tagging_think();
    thread tagging_mode_watcher();
    tagging_set_enabled( 1 );
}

tagging_shutdown_player()
{
    self notify( "tagging_shutdown" );
    tagging_set_enabled( 0 );

    if ( isdefined( self.tagging ) && isdefined( self.tagging["camera"] ) )
        self.tagging["camera"] delete();

    self.tagging = undefined;
}

tagging_set_hint( var_0 )
{
    if ( isdefined( self.tagging["hintText"] ) && isdefined( var_0 ) && self.tagging["hintText"] == var_0 )
        return;

    if ( isdefined( self.tagging["hint"] ) )
    {
        self.tagging["hint"] maps\_utility::hint_delete();
        self.tagging["hint"] = undefined;
        self.tagging["hintText"] = undefined;
    }

    if ( isdefined( var_0 ) )
    {
        self.tagging["hint"] = maps\_utility::hint_create( var_0 );
        self.tagging["hintText"] = var_0;

        if ( isdefined( self.tagging["hint"] ) )
        {
            self.tagging["hint"].elm.aligny = "bottom";
            self.tagging["hint"].elm.vertalign = "bottom";

            if ( isdefined( self.tagging["hint"].bg ) )
            {
                self.tagging["hint"].bg.aligny = "bottom";
                self.tagging["hint"].bg.vertalign = "bottom";
            }
        }

        return self.tagging["hint"];
    }
}

tagging_highlight_hud_effect_apply( var_0, var_1 )
{
    if ( !isdefined( var_0.detection_highlight_hud_effect ) )
    {
        var_0.detection_highlight_hud_effect = newclienthudelem( var_0 );
        var_0.detection_highlight_hud_effect.color = ( 0.012, 0.0025, 0 );
        var_0.detection_highlight_hud_effect.alpha = 0.005;
    }

    var_0.detection_highlight_hud_effect _meth_83A4( var_1 );
}

tagging_highlight_hud_effect_remove( var_0 )
{
    if ( isdefined( var_0.detection_highlight_hud_effect ) )
    {
        var_0.detection_highlight_hud_effect destroy();
        var_0.detection_highlight_hud_effect = undefined;
    }
}

tagging_enemy_list()
{
    var_0 = _func_0D6( "axis", "neutral" );

    if ( isdefined( level.active_drones ) )
        var_0 = common_scripts\utility::array_combine( var_0, level.active_drones );

    return var_0;
}

tagging_think()
{
    self notify( "tagging_think" );
    self endon( "tagging_think" );

    for (;;)
    {
        tag_update_enemy_in_sights();
        wait 0.05;
    }
}

tagging_mode_watcher()
{
    self notify( "tagging_mode_watcher" );
    self endon( "tagging_mode_watcher" );

    for (;;)
    {
        self waittill( "tagging_mode" );

        if ( isdefined( self.grapple ) && isdefined( self.grapple["grappling"] ) && self.grapple["grappling"] )
            continue;

        if ( isdefined( self.tagging["forced_mode_fov"] ) )
        {
            if ( !self.tagging["tagging_mode"] )
                tagging_mode_begin();

            tagging_set_hint( undefined );
            continue;
        }

        if ( self.tagging["tagging_mode"] )
        {
            tagging_mode_end();
            continue;
        }

        tagging_mode_begin();
    }
}

tagging_mode_begin()
{
    self notify( "tagging_on" );
    self endon( "tagging_off" );
    self endon( "tagging_on" );
    self.tagging["tagging_mode"] = 1;
    self playsound( "drone_tag_start" );

    if ( !isdefined( self.tagging["forced_mode_weap"] ) || !self.tagging["forced_mode_weap"] )
    {
        common_scripts\utility::_disableoffhandweapons();
        common_scripts\utility::_disableweapon();
        common_scripts\utility::_disableweaponswitch();
    }

    self.tagging["forced_mode_weap"] = undefined;
    _func_0D3( "cg_drawMantleHint", "0" );
    wait 0.5;
    tagging_hud_show_all();

    if ( !isdefined( self.tagging["forced_mode_fov"] ) )
        tagging_set_hint( &"GRAPPLE_ZOOM_HINT" );

    thread tagging_zoom_monitor();
    thread tag_monitor();
}

tagging_mode_end()
{
    self notify( "tagging_off" );
    self notify( "zoom_monitor" );
    self endon( "tagging_off" );
    self endon( "tagging_on" );
    self.tagging["tagging_mode"] = 0;

    if ( isdefined( self.tagging["zoom"] ) )
        self.tagging["zoom"] = 0;

    self playsound( "drone_tag_stop" );
    thread tagging_hud_show_none();
    tagging_set_hint( undefined );

    if ( !isdefined( self.tagging["forced_mode_weap"] ) || self.tagging["forced_mode_weap"] )
    {
        common_scripts\utility::_enableoffhandweapons();
        common_scripts\utility::_enableweapon();
        common_scripts\utility::_enableweaponswitch();
    }

    self.tagging["forced_mode_weap"] = undefined;
    self _meth_8031( 65, 0.25 );
    wait 0.5;
    _func_0D3( "cg_drawMantleHint", "1" );
    var_0 = tagging_enemy_list();

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.tagged ) && isdefined( var_2.tagged[self _meth_81B1()] ) )
            continue;

        var_2 tag_trace_update( "none", self );
    }
}

tagging_create_hud()
{
    if ( !isdefined( self.tagging["hud"] ) )
    {
        self.tagging["hud"] = [];
        self.tagging["hud"]["overlay"] = maps\_hud_util::create_client_overlay( "hud_ar_visor_overlay", 1.0 );
        self.tagging["hud"]["overlay"].hidewheninmenu = 1;
        self.tagging["hud"]["top_arc"] = maps\_hud_util::createicon( "hud_ar_visor_arc", 576, 18 );
        self.tagging["hud"]["top_arc"].hidewheninmenu = 1;
        self.tagging["hud"]["top_arc"].x = 0;
        self.tagging["hud"]["top_arc"].y = 13;
        self.tagging["hud"]["top_arc"].alignx = "center";
        self.tagging["hud"]["top_arc"].aligny = "top";
        self.tagging["hud"]["top_arc"].horzalign = "center";
        self.tagging["hud"]["top_arc"].vertalign = "top";
        self.tagging["hud"]["top_arc"].color = ( 1, 1, 1 );
        self.tagging["hud"]["top_arc"].alpha = 1.0;
        self.tagging["hud"]["bottom_arc"] = maps\_hud_util::createicon( "hud_ar_visor_arc", 576, 18 );
        self.tagging["hud"]["bottom_arc"].hidewheninmenu = 1;
        self.tagging["hud"]["bottom_arc"].x = 0;
        self.tagging["hud"]["bottom_arc"].y = -23;
        self.tagging["hud"]["bottom_arc"].alignx = "center";
        self.tagging["hud"]["bottom_arc"].aligny = "bottom";
        self.tagging["hud"]["bottom_arc"].horzalign = "center";
        self.tagging["hud"]["bottom_arc"].vertalign = "bottom";
        self.tagging["hud"]["bottom_arc"].color = ( 1, 1, 1 );
        self.tagging["hud"]["bottom_arc"].alpha = 1.0;
        self.tagging["hud"]["bottom_arc"].rotation = 180;
        self.tagging["hud"]["small_ring"] = maps\_hud_util::createicon( "hud_ar_visor_small_focus_ring", 160, 160 );
        self.tagging["hud"]["small_ring"].hidewheninmenu = 1;
        self.tagging["hud"]["small_ring"].x = 0;
        self.tagging["hud"]["small_ring"].y = 0;
        self.tagging["hud"]["small_ring"].alignx = "center";
        self.tagging["hud"]["small_ring"].aligny = "middle";
        self.tagging["hud"]["small_ring"].horzalign = "center";
        self.tagging["hud"]["small_ring"].vertalign = "middle";
        self.tagging["hud"]["small_ring"].color = ( 1, 1, 1 );
        self.tagging["hud"]["small_ring"].alpha = 1.0;
        self.tagging["hud"]["small_spinner"] = maps\_hud_util::createicon( "hud_ar_visor_spinner", 160, 160 );
        self.tagging["hud"]["small_spinner"].hidewheninmenu = 1;
        self.tagging["hud"]["small_spinner"].x = 0;
        self.tagging["hud"]["small_spinner"].y = 0;
        self.tagging["hud"]["small_spinner"].alignx = "center";
        self.tagging["hud"]["small_spinner"].aligny = "middle";
        self.tagging["hud"]["small_spinner"].horzalign = "center";
        self.tagging["hud"]["small_spinner"].vertalign = "middle";
        self.tagging["hud"]["small_spinner"].color = ( 1, 1, 1 );
        self.tagging["hud"]["small_spinner"].alpha = 1.0;
        self.tagging["hud"]["small_spinner"].rotation = 90;
        self.tagging["hud"]["large_ring"] = maps\_hud_util::createicon( "hud_ar_visor_large_focus_ring", 300, 300 );
        self.tagging["hud"]["large_ring"].hidewheninmenu = 1;
        self.tagging["hud"]["large_ring"].x = 0;
        self.tagging["hud"]["large_ring"].y = 0;
        self.tagging["hud"]["large_ring"].alignx = "center";
        self.tagging["hud"]["large_ring"].aligny = "middle";
        self.tagging["hud"]["large_ring"].horzalign = "center";
        self.tagging["hud"]["large_ring"].vertalign = "middle";
        self.tagging["hud"]["large_ring"].color = ( 1, 1, 1 );
        self.tagging["hud"]["large_ring"].alpha = 1.0;
        self.tagging["hud"]["large_spinner"] = maps\_hud_util::createicon( "hud_ar_visor_spinner", 300, 300 );
        self.tagging["hud"]["large_spinner"].hidewheninmenu = 1;
        self.tagging["hud"]["large_spinner"].x = 0;
        self.tagging["hud"]["large_spinner"].y = 0;
        self.tagging["hud"]["large_spinner"].alignx = "center";
        self.tagging["hud"]["large_spinner"].aligny = "middle";
        self.tagging["hud"]["large_spinner"].horzalign = "center";
        self.tagging["hud"]["large_spinner"].vertalign = "middle";
        self.tagging["hud"]["large_spinner"].color = ( 1, 1, 1 );
        self.tagging["hud"]["large_spinner"].alpha = 1.0;
        self.tagging["hud"]["large_spinner"] _meth_84E8( 0.5 );
        self.tagging["hud"]["large_spinner"].rotation = -360;
        self.tagging["hud"]["logo"] = maps\_hud_util::createicon( "hud_ar_visor_sentinel_logo", 116, 29 );
        self.tagging["hud"]["logo"].hidewheninmenu = 1;
        self.tagging["hud"]["logo"].x = -20;
        self.tagging["hud"]["logo"].y = 35;
        self.tagging["hud"]["logo"].alignx = "right";
        self.tagging["hud"]["logo"].aligny = "top";
        self.tagging["hud"]["logo"].horzalign = "right";
        self.tagging["hud"]["logo"].vertalign = "top";
        self.tagging["hud"]["logo"].color = ( 1, 1, 1 );
        self.tagging["hud"]["logo"].alpha = 1.0;
        self.tagging["hud"]["zoom_guage"] = maps\_hud_util::createicon( "hud_ar_visor_zoom_gauge", 112, 448 );
        self.tagging["hud"]["zoom_guage"].hidewheninmenu = 1;
        self.tagging["hud"]["zoom_guage"].x = -307;
        self.tagging["hud"]["zoom_guage"].y = 0;
        self.tagging["hud"]["zoom_guage"].alignx = "left";
        self.tagging["hud"]["zoom_guage"].aligny = "middle";
        self.tagging["hud"]["zoom_guage"].horzalign = "center";
        self.tagging["hud"]["zoom_guage"].vertalign = "middle";
        self.tagging["hud"]["zoom_guage"].color = ( 1, 1, 1 );
        self.tagging["hud"]["zoom_guage"].alpha = 1.0;
        self.tagging["hud"]["zoom_guage_indicator"] = maps\_hud_util::createicon( "white", 4, 4 );
        self.tagging["hud"]["zoom_guage_indicator"].hidewheninmenu = 1;
        self.tagging["hud"]["zoom_guage_indicator"].x = -249;
        self.tagging["hud"]["zoom_guage_indicator"].y = 154;
        self.tagging["hud"]["zoom_guage_indicator"].alignx = "left";
        self.tagging["hud"]["zoom_guage_indicator"].aligny = "middle";
        self.tagging["hud"]["zoom_guage_indicator"].horzalign = "center";
        self.tagging["hud"]["zoom_guage_indicator"].vertalign = "middle";
        self.tagging["hud"]["zoom_guage_indicator"].color = ( 1, 1, 1 );
        self.tagging["hud"]["zoom_guage_indicator"].alpha = 1.0;
        self.tagging["hud"]["zoom_guage_indicator"].rotation = -25;
        self.tagging["hud"]["zoom_guage_indicator"].bottom = 154;
        self.tagging["hud"]["zoom_guage_indicator"].top = -154;
        self.tagging["hud"]["zoom_guage_indicator"].left = -289;
        self.tagging["hud"]["zoom_guage_indicator"].right = -249;
        self.tagging["hud"]["zoom_guage_indicator"].rot_bot = -25;
        self.tagging["hud"]["zoom_guage_indicator"].rot_top = 25;
        self.tagging["hud"]["zoom_guage_text"] = maps\_hud_util::createfontstring( "default", 0.75 );
        self.tagging["hud"]["zoom_guage_text"].hidewheninmenu = 1;
        self.tagging["hud"]["zoom_guage_text"].x = -246;
        self.tagging["hud"]["zoom_guage_text"].y = 0;
        self.tagging["hud"]["zoom_guage_text"].alignx = "center";
        self.tagging["hud"]["zoom_guage_text"].aligny = "middle";
        self.tagging["hud"]["zoom_guage_text"].horzalign = "center";
        self.tagging["hud"]["zoom_guage_text"].vertalign = "middle";
        self.tagging["hud"]["zoom_guage_text"].color = ( 1, 1, 1 );
        self.tagging["hud"]["zoom_guage_text"].alpha = 1.0;
    }
}

tagging_hud_show_all()
{
    tagging_create_hud();
    self.tagging["hud"]["overlay"].alpha = 1.0;
    self.tagging["hud"]["large_ring"].alpha = 1.0;
    self.tagging["hud"]["small_ring"].alpha = 1.0;
    self.tagging["hud"]["large_spinner"].alpha = 1.0;
    self.tagging["hud"]["small_spinner"].alpha = 1.0;
    self.tagging["hud"]["zoom_guage"].alpha = 1.0;
    self.tagging["hud"]["zoom_guage_indicator"].alpha = 1.0;
    self.tagging["hud"]["zoom_guage_text"].alpha = 1.0;
    self.tagging["hud"]["top_arc"].alpha = 1.0;
    self.tagging["hud"]["bottom_arc"].alpha = 1.0;
    self.tagging["hud"]["logo"].alpha = 1.0;
}

tagging_hud_show_minimal()
{
    tagging_create_hud();
    self.tagging["hud"]["overlay"].alpha = 0.0;
    self.tagging["hud"]["large_ring"].alpha = 0.0;
    self.tagging["hud"]["small_ring"].alpha = 0.0;
    self.tagging["hud"]["large_spinner"].alpha = 0.0;
    self.tagging["hud"]["small_spinner"].alpha = 0.0;
    self.tagging["hud"]["zoom_guage"].alpha = 0.0;
    self.tagging["hud"]["zoom_guage_indicator"].alpha = 0.0;
    self.tagging["hud"]["zoom_guage_text"].alpha = 0.0;
}

tagging_hud_show_none()
{
    tagging_hud_show_minimal();
    self.tagging["hud"]["top_arc"].alpha = 0.0;
    self.tagging["hud"]["bottom_arc"].alpha = 0.0;
    self.tagging["hud"]["logo"].alpha = 0.0;
}

tagging_hud_shutdown()
{
    if ( !isdefined( self.tagging ) )
        return;

    if ( !isdefined( self.tagging["hud"] ) )
        return;

    foreach ( var_1 in self.tagging["hud"] )
        var_1 destroy();

    self.tagging["hud"] = undefined;
}

tagging_create_hud_crosshair()
{
    var_0 = newhudelem();
    var_0.x = 320;
    var_0.y = 240;
    var_0.sort = 997;
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0 _meth_80CC( "hud_ar_visor_arc", 920, 480 );
    return var_0;
}

tagging_zoom_monitor()
{
    self notify( "zoom_monitor" );
    self endon( "death" );
    self endon( "zoom_monitor" );
    var_0 = [ getdvarint( "tagging_scan_fov_min" ), getdvarint( "tagging_scan_fov_max" ) ];
    var_1 = [ getdvarint( "tagging_scan_range_min" ), getdvarint( "tagging_scan_range_max" ) ];

    if ( !isdefined( self.tagging["zoom"] ) )
    {
        self.tagging["zoom"] = 0;
        self.tagging["fov"] = var_0[self.tagging["zoom"]];
        self.tagging["range"] = var_1[self.tagging["zoom"]];
    }

    if ( isdefined( self.tagging["forced_mode_fov"] ) )
        self.tagging["fov"] = self.tagging["forced_mode_fov"];

    var_2 = 0;
    var_3 = 0.33;
    var_4 = 1;

    for (;;)
    {
        var_5 = self adsbuttonpressed() || isdefined( self.tagging["forced_mode_fov"] );
        var_6 = isdefined( self.tagging["forced_mode_fov"] ) && self.tagging["forced_mode_fov"] != self.tagging["fov"];

        if ( var_4 || var_2 != var_5 || var_6 )
        {
            if ( !isdefined( self.tagging["forced_mode_fov"] ) && !var_4 )
            {
                if ( var_5 )
                    self.tagging["zoom"] = 1;
                else
                    self.tagging["zoom"] = 0;
            }

            var_7 = var_0[self.tagging["zoom"]];
            var_8 = var_1[self.tagging["zoom"]];

            if ( isdefined( self.tagging["forced_mode_fov"] ) )
                var_7 = self.tagging["forced_mode_fov"];

            self _meth_8031( var_7, var_3 );
            thread tagging_zoom_transition( self.tagging["fov"], self.tagging["range"], var_7, var_8, var_3 );
            tagging_zoom_sound( self.tagging["zoom"], var_3 );
            var_2 = var_5;
            var_4 = 0;
        }

        wait 0.05;
    }
}

tagging_zoom_sound( var_0, var_1 )
{
    common_scripts\utility::stop_loop_sound_on_entity( "drone_tag_zoom_in_loop" );
    common_scripts\utility::stop_loop_sound_on_entity( "drone_tag_zoom_out_loop" );
    self notify( "zoom_sound" );
    self endon( "zoom_sound" );

    if ( var_1 <= 0 )
        return;

    self playsound( "drone_tag_zoom_start" );

    if ( var_0 )
        var_2 = "drone_tag_zoom_in_loop";
    else
        var_2 = "drone_tag_zoom_out_loop";

    thread common_scripts\utility::play_loop_sound_on_entity( var_2 );
    wait(var_1);
    common_scripts\utility::stop_loop_sound_on_entity( var_2 );
    self playsound( "drone_tag_zoom_stop" );
}

tagging_zoom_transition( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "zoom_transition" );
    self endon( "zoom_transition" );
    var_5 = var_4 * 1000.0;
    var_6 = var_5 + gettime();
    var_7 = 0;
    var_8 = 0;
    self.tagging["hud"]["small_spinner"] _meth_84E8( var_4 );
    self.tagging["hud"]["large_spinner"] _meth_84E8( var_4 );

    if ( self.tagging["zoom"] )
    {
        self.tagging["hud"]["small_spinner"].rotation += 90;
        self.tagging["hud"]["large_spinner"].rotation -= 90;
    }
    else
    {
        self.tagging["hud"]["small_spinner"].rotation -= 90;
        self.tagging["hud"]["large_spinner"].rotation += 90;
    }

    while ( var_7 < 1.0 && isdefined( self.tagging ) )
    {
        var_7 = clamp( 1.0 - ( var_6 - gettime() ) / var_5, 0.0, 1.0 );
        self.tagging["fov"] = var_0 + ( var_2 - var_0 ) * var_7;
        self.tagging["range"] = var_1 + ( var_3 - var_1 ) * var_7;

        if ( !self.tagging["zoom"] )
            var_8 = 1.0 - var_7;
        else
            var_8 = var_7;

        self.tagging["hud"]["zoom_guage_text"] _meth_80D7( 20 * var_8 );
        var_9 = 21.95;
        var_10 = 551;

        if ( self.tagging["zoom"] )
            var_9 *= -1.0;

        var_11 = rotatevector( ( 0, 0 - var_10, 0 ), ( 0, var_9 * ( var_7 * 2.0 - 1.0 ), 0 ) );
        self.tagging["hud"]["zoom_guage_indicator"].x = var_11[1] + ( var_10 + self.tagging["hud"]["zoom_guage_indicator"].left );
        self.tagging["hud"]["zoom_guage_indicator"].y = var_11[0] * 0.75;
        self.tagging["hud"]["zoom_guage_indicator"].rotation = self.tagging["hud"]["zoom_guage_indicator"].rot_bot + ( self.tagging["hud"]["zoom_guage_indicator"].rot_top - self.tagging["hud"]["zoom_guage_indicator"].rot_bot ) * var_8;
        wait 0.05;
    }
}

tag_update_enemy_in_sights()
{
    var_0 = maps\_utility::isads() && self.tagging["enabled"] && self.tagging["outline_enabled"];

    if ( var_0 )
    {
        var_1 = tagging_enemy_list();
        var_2 = self _meth_80A8();
        var_3 = anglestoforward( self getangles() );
        var_4 = undefined;
        var_5 = max( 0.01, getdvarfloat( "tagging_ads_cone_range" ) );
        var_6 = cos( getdvarfloat( "tagging_ads_cone_angle" ) );
        var_7 = [ 0.0, 0.5, 1.0 ];
        var_8 = bullettrace( var_2, var_2 + var_3 * 32000, 1, self );
        var_4 = var_8["entity"];

        foreach ( var_10 in var_1 )
        {
            if ( isdefined( var_10.tagged ) && isdefined( var_10.tagged[self _meth_81B1()] ) )
                continue;

            if ( !getdvarint( "tagging_vehicle_ride" ) && isdefined( var_10.vehicle_ride ) && var_10.vehicle_ride.veh_speed > 0 )
                continue;

            var_11 = isdefined( var_4 ) && var_4 == var_10;

            if ( !var_11 )
            {
                var_12 = var_10 gettagorigin( "tag_origin" );

                if ( isai( var_10 ) )
                    var_12 = var_10 _meth_80A8();

                var_13 = distance( var_12, var_2 );

                if ( var_13 <= var_5 )
                {
                    var_14 = min( 1.0, var_6 + ( 1.0 - var_6 ) * var_13 / var_5 );

                    foreach ( var_16 in var_7 )
                    {
                        var_17 = vectorlerp( var_10.origin, var_12, var_16 );
                        var_18 = var_17 - var_2;
                        var_19 = vectornormalize( var_18 );
                        var_20 = vectordot( var_19, var_3 );

                        if ( var_20 > var_14 )
                        {
                            if ( enemy_sight_trace_passed( var_10 ) )
                            {
                                var_11 = 1;
                                break;
                            }
                        }
                    }
                }
            }

            if ( var_11 )
            {
                var_10 tag_trace_update( "tracking", self, 1 );
                continue;
            }

            var_10 tag_trace_update( "none", self, 1 );
        }
    }
}

tag_monitor( var_0 )
{
    self notify( "tag_monitor" );
    self endon( "tag_monitor" );
    self endon( "tagging_off" );
    self endon( "unsync" );
    self endon( "death" );

    for (;;)
    {
        tag_scan_update( self _meth_80A8(), self getangles(), self.tagging["fov"], float( self.tagging["fov"] ) * 0.28, self.tagging["range"] );
        wait 0.05;
    }
}

enemy_sight_trace_request()
{
    if ( isdefined( self.tagging_sight_traced_queued ) )
        return;

    if ( !isdefined( self.tagging_sight_trace_passed ) )
        self.tagging_sight_trace_passed = 0;

    if ( !isdefined( level.tagging_sight_trace_queue ) )
    {
        level.tagging_sight_trace_queue = [];
        level thread enemy_sight_trace_process();
    }

    level.tagging_sight_trace_queue = common_scripts\utility::array_add( level.tagging_sight_trace_queue, self );
    self.tagging_sight_traced_queued = 1;
}

enemy_sight_trace_process()
{
    self notify( "enemy_sight_trace_process" );
    self endon( "enemy_sight_trace_process" );
    var_0 = 3;

    for (;;)
    {
        level.tagging_sight_trace_queue = common_scripts\utility::array_removeundefined( level.tagging_sight_trace_queue );

        for ( var_1 = 0; var_1 < min( var_0, level.tagging_sight_trace_queue.size ); var_1++ )
        {
            var_2 = level.tagging_sight_trace_queue[0];
            level.tagging_sight_trace_queue = common_scripts\utility::array_remove( level.tagging_sight_trace_queue, var_2 );
            var_2.tagging_sight_trace_passed = enemy_sight_trace( var_2 );
            var_2.tagging_sight_traced_queued = undefined;
        }

        wait 0.05;
    }
}

enemy_sight_trace_passed( var_0 )
{
    var_0 enemy_sight_trace_request();
    return var_0.tagging_sight_trace_passed;
}

enemy_sight_trace( var_0 )
{
    var_1 = 0;
    var_2 = level.player _meth_80A8();

    if ( isai( var_0 ) )
    {
        if ( !var_1 && sighttracepassed( var_2, var_0 gettagorigin( "j_head" ), 0, var_0.sight_ignore, var_0, 0 ) )
            var_1 = 1;

        if ( !var_1 && sighttracepassed( var_2, var_0 gettagorigin( "j_spinelower" ), 0, var_0.sight_ignore, var_0, 0 ) )
            var_1 = 1;
    }

    if ( !var_1 && sighttracepassed( var_2, var_0.origin, 0, var_0.sight_ignore, var_0, 0 ) )
        var_1 = 1;

    return var_1;
}

tag_scan_update( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = tagging_enemy_list();
    var_6 = cos( float( var_3 ) );
    var_7 = var_4 * var_4;

    foreach ( var_9 in var_5 )
    {
        var_10 = "tracking";
        var_11 = ( 0, 0, 0 );

        if ( isai( var_9 ) )
            var_11 = var_9 _meth_80A8();
        else
            var_11 = var_9 gettagorigin( "tag_origin" );

        if ( isdefined( var_9.tagged ) && isdefined( var_9.tagged[self _meth_81B1()] ) )
            continue;

        if ( !getdvarint( "tagging_vehicle_ride" ) && isdefined( var_9.vehicle_ride ) && var_9.vehicle_ride.veh_speed > 0 )
            continue;

        if ( !self.tagging["outline_enabled"] || !self.tagging["enabled"] )
            continue;

        if ( !common_scripts\utility::within_fov( var_0, var_1, var_11, cos( float( var_2 ) ) ) )
        {
            var_9 tag_trace_update( "none", self );
            continue;
        }

        if ( !common_scripts\utility::within_fov( var_0, var_1, var_11, var_6 ) )
        {
            var_9 tag_trace_update( "none", self );
            continue;
        }

        if ( distancesquared( var_0, var_9.origin ) > var_7 )
            var_10 = "tracking_slow";

        if ( enemy_sight_trace_passed( var_9 ) )
        {
            var_9 tag_trace_update( var_10, self );
            continue;
        }

        var_9 tag_trace_update( "obstructed", self );
    }
}

tag_trace_update( var_0, var_1, var_2 )
{
    var_3 = gettime();

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_4 = getdvarint( "tagging_normal_pulse_rate" );
    var_5 = getdvarint( "tagging_normal_prep_time" );
    var_6 = getdvarint( "tagging_normal_track_time" );
    var_7 = 0;

    if ( !var_1.tagging["marking_enabled"] )
        var_0 = "range";

    switch ( var_0 )
    {
        case "view":
            var_7 = 1;
            self.tag_trace_state = 0;
            self.tag_trace_track = undefined;
            break;
        case "range":
            self.tag_trace_state = 0;
            self.tag_trace_track = undefined;
            break;
        case "tracking_slow":
            var_4 = getdvarint( "tagging_slow_pulse_rate" );
            var_5 = getdvarint( "tagging_slow_prep_time" );
            var_6 = getdvarint( "tagging_slow_track_time" );
        case "tracking":
            if ( !isdefined( self.tag_trace_track ) )
            {
                if ( ( gettime() - var_1.tagging["last_tag_start"] ) / 1000 <= 0.25 )
                    return;

                self.tag_trace_track = var_3;
                var_1.tagging["last_tag_start"] = var_3;
            }

            break;
        case "obstructed":
        case "none":
        default:
            tag_outline_enemy( 0 );
            self.tag_trace_track = undefined;
            self.tag_trace_sound = undefined;
            return;
    }

    var_8 = var_6 + var_5;
    var_9 = 0;

    if ( isdefined( self.tag_trace_track ) )
        var_9 = var_3 - self.tag_trace_track;

    if ( var_9 >= var_8 )
        tag_enemy( var_1 );
}

tag_outline_enemy( var_0 )
{
    if ( var_0 )
    {
        tagged_status_show();
        thread tagged_enemy_death_cleanup();
        thread tagged_enemy_update();
    }
    else
    {
        tagged_status_hide();
        self notify( "tagged_enemy_update" );
    }

    tag_threat_detection( var_0 );
}

tagged_enemy_update()
{
    self endon( "death" );
    self notify( "tagged_enemy_update" );
    self endon( "tagged_enemy_update" );

    for (;;)
    {
        if ( !getdvarint( "tagging_vehicle_ride" ) && isdefined( self.vehicle_ride ) && self.vehicle_ride.veh_speed > 0 )
        {
            tag_outline_enemy( 0 );
            self notify( "tagged_enemy_death_cleanup" );
            self.tagged = undefined;
            return;
        }

        var_0 = self gettagorigin( "tag_origin" );

        if ( isai( self ) )
            var_0 = self _meth_80A8();

        var_1 = vectornormalize( var_0 - level.player _meth_80A8() );
        var_2 = anglestoforward( level.player getangles() );

        if ( vectordot( var_1, var_2 ) < cos( 65 ) )
            tag_threat_detection( 0 );
        else if ( enemy_sight_trace_passed( self ) )
            tag_threat_detection( 0 );
        else
            tag_threat_detection( 1 );

        wait 0.05;
    }
}

tag_threat_detection( var_0 )
{
    self _meth_84ED( "disable" );

    if ( var_0 )
    {
        if ( self.team == "axis" )
            self _meth_84ED( "detected" );
    }
}

tag_enemy( var_0 )
{
    if ( !isdefined( self ) || !isalive( self ) )
    {
        if ( isdefined( self ) )
            tag_outline_enemy( 0 );

        return;
    }

    if ( !isdefined( self.tagged ) || !isdefined( self.tagged[var_0 _meth_81B1()] ) || !self.tagged[var_0 _meth_81B1()] )
        soundscripts\_snd_playsound::snd_play_2d( "drone_tag_success" );

    self.tagged[var_0 _meth_81B1()] = 1;
    tag_outline_enemy( 1 );
    self.tag_trace_state = undefined;
    self.tag_trace_pulse = undefined;
    self.tag_trace_track = undefined;
    self.tag_trace_sound = undefined;
    tagged_status_show();
}

tagged_status_show()
{
    tagged_status_hide();
    var_0 = 4;

    if ( self.team != "axis" && self.team != "dead" && self.health > 0 )
        var_0 = 3;

    if ( isdefined( self.tagging_color ) && self.tagging_color == var_0 )
        return;

    self _meth_83FA( var_0, 0 );
    self.tagging_color = var_0;
    thread tagged_status_update();
}

tagged_status_hide()
{
    self notify( "tagged_status_update" );

    if ( isdefined( self.tagging_color ) )
    {
        self _meth_83FB();
        self.tagging_color = undefined;
    }
}

tagged_status_update()
{
    self notify( "tagged_status_update" );
    self endon( "tagged_status_update" );
    self endon( "death" );

    while ( isdefined( self ) )
    {
        var_0 = level.player.tagging["tagging_fade_max"];
        var_1 = var_0 * var_0;
        var_2 = lengthsquared( level.player.origin - self.origin );

        if ( var_2 > var_1 )
            self _meth_83FB();
        else
            self _meth_83FA( self.tagging_color, 0 );

        wait 0.05;
    }
}

tagged_enemy_death_cleanup()
{
    if ( isdefined( self.tagged_enemy_death_cleanup ) )
        return;

    self notify( "tagged_enemy_death_cleanup" );
    self endon( "tagged_enemy_death_cleanup" );
    self.tagged_enemy_death_cleanup = 1;
    common_scripts\utility::waittill_any( "death", "tagged_death" );
    wait 0.1;

    if ( isdefined( self ) && distancesquared( self.origin, level.player.origin ) > 90000 )
    {
        var_0 = gettime();
        var_1 = 1;

        while ( isdefined( self ) && gettime() - var_0 < 1000 )
        {
            if ( var_1 == 0 && randomint( 100 ) < 30 )
            {
                tag_outline_enemy( 1 );
                var_1 = 1;
            }
            else if ( var_1 == 1 )
            {
                tag_outline_enemy( 0 );
                var_1 = 0;
            }

            wait 0.05;
        }
    }

    if ( isdefined( self ) )
        tag_outline_enemy( 0 );

    self.tagged_enemy_death_cleanup = undefined;
}
