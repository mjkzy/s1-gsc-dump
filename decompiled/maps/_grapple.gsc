// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1 )
{
    _func_0D3( "use_new_sva_system", 1 );

    if ( !isdefined( var_0 ) )
        var_0 = "viewbody_generic_s1";

    level.grapple_defaultscriptedbodymodel = var_0;

    if ( !isdefined( var_1 ) )
        var_1 = "viewmodel_base_viewhands";

    level.grapple_defaultviewhandsmodel = var_1;
    level thread grapple_init();
}

grapple_give( var_0, var_1 )
{
    self notify( "grapple_give" );
    self endon( "death" );
    thread grapple_quick_fire_listener();
    self.grapple["enabled"] = 1;
    self.grapple["grappling"] = 0;

    if ( isdefined( var_0 ) )
        self.grapple["model_body"] _meth_80B1( var_0 );
    else if ( isdefined( level.grapple_defaultscriptedbodymodel ) )
        self.grapple["model_body"] _meth_80B1( level.grapple_defaultscriptedbodymodel );

    if ( isdefined( var_1 ) )
        self.grapple["model_hands"] _meth_80B1( var_1 );
    else if ( isdefined( level.grapple_defaultviewhandsmodel ) )
        self.grapple["model_hands"] _meth_80B1( level.grapple_defaultviewhandsmodel );

    self _meth_84BF();
    thread grapple_enabled_listener();
}

grapple_take()
{
    self notify( "grapple_take" );
    grapple_switch( 0 );
    self.grapple["enabled"] = 0;
    grapple_set_hint( "" );
    grapple_update_preview( 0, 0 );
    self _meth_84C0();
}

grapple_switch( var_0, var_1, var_2 )
{
    var_3 = self _meth_8311();
    var_4 = var_3;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !var_0 )
    {
        if ( var_3 != "none" && var_3 != self.grapple["weapon"] )
            return;

        if ( isdefined( self.grapple["weapon_prev"] ) && self _meth_8314( self.grapple["weapon_prev"] ) )
            var_4 = self.grapple["weapon_prev"];
        else
        {
            var_5 = self _meth_830C();
            var_6 = var_4;

            foreach ( var_8 in var_5 )
            {
                if ( var_8 != self.grapple["weapon"] )
                {
                    if ( self _meth_82F8( var_8 ) > 0 )
                    {
                        var_4 = var_8;
                        break;
                    }
                    else
                        var_6 = var_8;
                }
            }

            if ( var_4 == var_3 )
                var_4 = var_6;
        }

        grapple_set_hint( "" );
        self.grapple["ready_time"] = max( gettime() + 1000, self.grapple["ready_time"] );
    }
    else
    {
        if ( var_3 == self.grapple["weapon"] )
            return;

        self.grapple["weapon_prev"] = var_3;
        self _meth_830E( self.grapple["weapon"] );
        var_4 = self.grapple["weapon"];
        self.grapple["ready_time"] = max( gettime() + 250, self.grapple["ready_time"] );
        self.grapple["switching_to_grapple"] = 1;
    }

    if ( var_3 != var_4 || self.grapple["quick_fire_up"] )
    {
        if ( var_4 == self.grapple["weapon"] )
        {
            self.grapple["ammoCounterHide"] = 1;
            _func_0D3( "ammoCounterHide", 1 );
            self _meth_8300( 0 );
            self _meth_8304( 0 );
            self _meth_832A();
            self.grapple["useReticle"] = var_2;
            _func_0D3( "cg_drawCrosshair", var_2 );

            if ( isdefined( self.exo_active ) && self.exo_active )
            {
                thread maps\_player_exo::player_exo_deactivate();
                self.grapple["exo_deactivated"] = 1;
            }
        }
        else
        {
            self.grapple["ammoCounterHide"] = 0;
            self.grapple["useReticle"] = 1;
            self _meth_832B();

            if ( self.grapple["exo_deactivated"] )
            {
                if ( isdefined( self.exo_active ) && !self.exo_active && !self.grapple["no_enable_exo"] )
                    thread maps\_player_exo::player_exo_activate();

                self.grapple["exo_deactivated"] = 0;
                self.grapple["no_enable_exo"] = 0;
            }
        }

        if ( isdefined( var_1 ) && var_1 )
            self _meth_8316( var_4 );
        else
            self _meth_8315( var_4 );
    }
}

grapple_magnet_register( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    if ( !isdefined( var_1 ) )
        var_1 = "";

    var_1 = tolower( var_1 );

    if ( !isdefined( var_2 ) )
        var_2 = ( 0, 0, 0 );

    if ( isdefined( var_5 ) && !isdefined( var_5.type ) )
        var_5.type = "";

    if ( !isdefined( var_6 ) )
    {
        if ( isdefined( var_5 ) && isdefined( var_5.afterlandanim ) )
            var_6 = var_5.afterlandanim;
        else
            var_6 = var_0.afterlandanim;
    }

    var_7 = undefined;

    foreach ( var_10, var_9 in level.grapple_magnets )
    {
        if ( !isdefined( var_7 ) && !isdefined( var_9.object ) )
        {
            var_7 = var_10;
            continue;
        }

        if ( isdefined( var_9.object ) && var_9.object == var_0 && var_9.tag == var_1 && var_9.tag_offset == var_2 )
        {
            level.grapple_magnets[var_10].specialstruct = var_5;
            level.grapple_magnets[var_10].notifyname = var_3;
            level.grapple_magnets[var_10].afterlandanim = var_6;
            return level.grapple_magnets[var_10];
        }
    }

    if ( !isdefined( var_7 ) )
        var_7 = level.grapple_magnets.size;

    var_9 = spawnstruct();
    var_9.object = var_0;
    var_9.tag = var_1;
    var_9.tag_offset = var_2;
    var_9.static = !isdefined( var_0.classname ) || var_0.classname == "script_struct";
    var_9.is_ai = isai( var_0 );
    var_9.specialstruct = var_5;
    var_9.notifyname = var_3;
    var_9.afterlandanim = var_6;
    level.grapple_magnets[var_7] = var_9;

    if ( isdefined( var_4 ) )
        var_9.next = var_4;
    else if ( isdefined( var_0.target ) && ( var_1 == "" || var_1 == "tag_origin" ) )
    {
        var_4 = getent( var_0.target, "targetname" );

        if ( !isdefined( var_4 ) )
            var_4 = common_scripts\utility::getstruct( var_0.target, "targetname" );

        if ( isdefined( var_4 ) )
            var_9.next = grapple_magnet_register( var_4 );
    }

    if ( var_9.static )
    {
        var_9.static_origin = grapple_magnet_origin( var_9 );

        if ( isdefined( var_9.next ) && var_9.next.static )
        {
            var_11 = grapple_magnet_origin( var_9.next );
            var_9.static_length = distance( var_9.static_origin, var_11 );
            var_9.static_sphere_radius = var_9.static_length * 0.5;
            var_9.static_sphere_center = vectorlerp( var_9.static_origin, var_11, 0.5 );
        }
    }

    if ( !isdefined( var_0.grapple_magnets ) )
        var_0.grapple_magnets = [ var_9 ];
    else
        var_0.grapple_magnets[var_0.grapple_magnets.size] = var_9;

    if ( isai( var_0 ) && !isdefined( var_0.grapple_death_styles ) )
        var_0.grapple_death_styles = level.grapple_death_styles;

    return var_9;
}

grapple_magnet_unregister( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = "";

    var_1 = tolower( var_1 );

    foreach ( var_7, var_3 in level.grapple_magnets )
    {
        if ( isdefined( var_3 ) && isdefined( var_3.object ) && var_3.object == var_0 && var_3.tag == var_1 )
        {
            level.grapple_magnets[var_7].object = undefined;
            grapple_validate_magnets( level.grapple_magnets[var_7] );

            foreach ( var_6, var_5 in var_0.grapple_magnets )
            {
                if ( isdefined( var_5 ) && var_5 == level.grapple_magnets[var_7] )
                {
                    var_0.grapple_magnets[var_6] = undefined;
                    break;
                }
            }
        }
    }

    if ( isdefined( var_0.grapple_magnets ) && var_0.grapple_magnets.size == 0 )
    {
        var_0.grapple_magnets = undefined;
        var_0.grapple_death_styles = undefined;
    }
}

grapple_init()
{
    maps\_grapple_anim::grapple_init_anims_player();
    maps\_grapple_anim::grapple_init_anims_props();
    grapple_init_anims_weapon();
    maps\_grapple_anim::grapple_init_anims_actors();
    grapple_precache();
    grapple_register_snd_messages();
    grapple_init_magnets();
    grapple_init_death_styles();
    maps\_utility::add_extra_autosave_check( "grappling", ::grapple_autosave_grappling_check, "grappling." );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( !isdefined( var_1.grapple_initialized ) )
            {
                var_1 grapple_init_player();
                var_1.grapple_initialized = 1;
            }

            var_2 = _func_085();

            if ( var_2 && !var_1.grapple["recent_load_reset"] )
            {
                if ( var_1.grapple["grappled_count"] > 1 )
                    var_1.grapple["grappled_count"] = 1;

                var_1 grapple_switch( 0, 1 );

                if ( var_1.grapple["enabled"] )
                {
                    var_1 thread grapple_quick_fire_listener();
                    var_1 thread grapple_enabled_listener();
                    var_1.grapple["grappling"] = 0;
                }

                var_1.grapple["recent_load_reset"] = 1;
                continue;
            }

            if ( !var_2 )
                var_1.grapple["recent_load_reset"] = 0;
        }

        wait 0.25;
    }
}

grapple_init_magnets()
{
    level.grapple_magnets = [];
    var_0 = common_scripts\utility::getstructarray( "grapple_magnet", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        grapple_magnet_register( var_2 );

    var_0 = getentarray( "grapple_magnet", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        grapple_magnet_register( var_2 );

    if ( common_scripts\utility::issp() )
        thread grapple_magnet_actor_monitor();
}

grapple_magnet_actor_monitor()
{
    for (;;)
    {
        wait 0.5;
        var_0 = _func_0D6( "axis" );

        foreach ( var_2 in var_0 )
        {
            if ( isdefined( var_2 ) && var_2 grapple_ai_alive() && !isdefined( var_2.grapple_magnets ) )
            {
                grapple_magnet_register( var_2, "J_SpineUpper" );
                var_2 thread grapple_magnet_unregister_on_death( "J_SpineUpper" );
            }
        }
    }
}

grapple_magnet_unregister_on_death( var_0 )
{
    self notify( "grapple_unregister_on_death" );
    self endon( "grapple_unregister_on_death" );
    self waittill( "death" );

    if ( isdefined( self ) )
        grapple_magnet_unregister( self, var_0 );
}

grapple_notify_players_magnet_unregister( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2.grapple ) && isdefined( var_2.grapple["magnet_current"] ) )
        {
            if ( isdefined( var_2.grapple["magnet_current"].magnet ) && var_2.grapple["magnet_current"].magnet == var_0 )
            {
                var_2.grapple["magnet_current"].valid = 0;
                var_2.grapple["magnet_current"].magnet = undefined;
                var_2.grapple["magnet_current"].origin = undefined;
            }
        }
    }
}

grapple_precache()
{
    level._effect["grapple_cam"] = loadfx( "vfx/map/irons_estate/grapple_cam" );
    precachemodel( "vm_spydeco" );
    grapple_model_precache( "model_player_from", "tag_origin" );
    grapple_model_precache( "model_player_to", "tag_origin" );
    grapple_model_precache( "model_player_trans", "tag_origin" );
    grapple_model_precache( "model_preview", "tag_origin" );
    grapple_model_precache( "model_preview_hint", "tag_origin" );
    grapple_model_precache( "model_rope_attach_world", "tag_origin" );
    grapple_model_precache( "model_player_move_tag", "tag_origin" );
    grapple_model_precache( "model_player_move_lerp", "tag_origin" );
    grapple_model_precache( "model_rope_attach_player", "tag_origin" );
    grapple_model_precache( "model_attach_world", "tag_origin" );
    grapple_model_precache( "model_ai_link", "tag_origin" );
    grapple_model_precache( "model_rope_fire", "grapple_rope" );
    grapple_model_precache( "model_rope_idle", "grapple_rope_stretch" );
    grapple_model_precache( "model_hands", "grapple_hands" );
    grapple_model_precache( "model_body", "grapple_body" );
    precacheitem( "s1_grapple" );
    precacheitem( "s1_grapple_impact" );
    precacherumble( "subtle_tank_rumble" );
    precacherumble( "heavygun_fire" );
    precacherumble( "falling_land" );
    precacherumble( "damage_light" );
    precacheshader( "grapple_reticle_indicator" );
    precacheshader( "grapple_reticle_indicator_small" );
    setdvarifuninitialized( "grapple_enabled", 1 );
    setdvarifuninitialized( "grapple_tutorial", 1 );
    setdvarifuninitialized( "grapple_hint_always", 1 );
    setdvarifuninitialized( "grapple_hint_button_always", 1 );
    setdvarifuninitialized( "grapple_magnet_fov", 48 );
    setdvarifuninitialized( "grapple_magnet_fov_ai", 5 );
    setdvarifuninitialized( "grapple_magnet_enabled", 1 );
    setdvarifuninitialized( "grapple_magnet_required", 1 );
    setdvarifuninitialized( "grapple_magnet_show_offset", 0 );
    setdvarifuninitialized( "grapple_magnet_lines", 1 );
    setdvarifuninitialized( "grapple_mantle_reach", 64 );
    setdvarifuninitialized( "grapple_mantle_kill_radius", 75.0 );
    setdvarifuninitialized( "grapple_mantle_required", 1 );
    setdvarifuninitialized( "grapple_lerp_velocity", 1 );
    setdvarifuninitialized( "grapple_status_text", 0 );
    setdvarifuninitialized( "grapple_ai_priority", 0.02 );
    setdvarifuninitialized( "grapple_concealed_kill_range_min", 100 );
    setdvarifuninitialized( "grapple_concealed_kill_range", 400 );
    setdvarifuninitialized( "grapple_concealed_kill_range_z", 80 );
    setdvarifuninitialized( "grapple_concealed_kill", 1 );
    grapple_register_hint( "grapple_input_tutorial", &"GRAPPLE_INPUT_TUTORIAL", &"GRAPPLE_INPUT_TUTORIAL", ::grapple_hint_hide_tutorial );
    grapple_register_hint( "grapple_kill", &"GRAPPLE_KILL", &"GRAPPLE_KILL", ::grapple_hint_hide_kill );
    grapple_register_hint( "grapple_kill_pull", &"GRAPPLE_KILL_PULL", &"GRAPPLE_KILL_PULL", ::grapple_hint_hide_kill_pull );
}

grapple_register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "aud_grapple_launch", ::aud_grapple_launch );
    level.grapple_snd_pain = [ "ie_as1_quietpain1", "ie_as1_quietpain2", "ie_as2_quietpain1", "ie_as2_quietpain2", "ie_as3_quietpain1", "ie_as3_quietpain2" ];
    level.grapple_snd_death = [ "ie_as1_quietdeath1", "ie_as1_quietdeath2", "ie_as2_quietdeath1", "ie_as2_quietdeath2", "ie_as3_quietdeath1", "ie_as3_quietdeath2" ];
}

aud_grapple_launch()
{
    if ( common_scripts\utility::issp() )
    {
        if ( isai( self ) )
        {
            snd_play_linked_notify_on_ent( "linelauncher_fire", "stop_grapplesound_npc", 0.2 );
            snd_play_linked_notify_on_ent( "linelauncher_move", "stop_grapplesound_npc", 0.1 );
        }
        else
        {
            soundscripts\_snd_playsound::snd_play_2d( "linelauncher_fire_player" );
            soundscripts\_snd_playsound::snd_play_2d( "linelauncher_cable_fly_player", "stop_grapplesound", undefined, 0.2 );
        }
    }
    else
    {

    }
}

snd_play_linked_notify_on_ent( var_0, var_1, var_2 )
{
    thread snd_play_linked_notify_on_ent_thread( var_0, var_1, var_2 );
}

snd_play_linked_notify_on_ent_thread( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", self.origin );
    var_3 _meth_804D( self );
    var_3 playsound( var_0 );
    self waittill( var_1 );
    var_3 _meth_806F( 0, var_2 );
    wait(var_2);
    var_3 _meth_80AC();
    waitframe();
    var_3 delete();
}

grapple_after_land_anim()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_entity ) && isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.afterlandanim ) && var_0.land_magnet.tag != "" )
    {
        var_1 = var_0.land_magnet.afterlandanim;
        grapple_setup_rope_attached_player( self, self, 0 );
        grapple_rope_state( 2 );
        var_2 = self.grapple["model_body"];
        var_2 _meth_804F();
        var_2 _meth_804D( var_0.land_entity, var_0.land_magnet.tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_2 _meth_8092();
        var_3 = var_0.land_entity gettagorigin( var_0.land_magnet.tag );
        var_4 = var_0.land_entity gettagangles( var_0.land_magnet.tag );
        var_2 show();
        var_2 _meth_813E( "grapple_after_land_anim", var_3, var_4, var_1, undefined, undefined, 0.2 );
        self _meth_804F();
        self _meth_8080( var_2, "tag_player", 0.2 );
        grapple_disable_weapon();
        self notify( "grapple_land_anim" );
        wait(getanimlength( var_1 ));
        var_2 hide();
        var_5 = self.grapple["model_player_from"];
        var_5 _meth_804F();
        var_5.origin = self.origin;

        if ( isdefined( var_5.land_entity ) )
        {
            if ( isdefined( var_5.land_magnet ) && var_5.land_magnet.tag != "" )
                var_5 _meth_804D( var_5.land_entity, var_5.land_magnet.tag );
            else
                var_5 _meth_804D( var_5.land_entity );
        }

        return 1;
    }

    return 0;
}

#using_animtree("animated_props");

grapple_rope_length_thread( var_0, var_1, var_2 )
{
    self notify( "grapple_rope_length_thread" );
    self endon( "grapple_rope_length_thread" );
    var_0 endon( "death" );
    self endon( "death" );

    if ( var_1 == 0 )
        return;

    if ( !isdefined( var_2 ) )
        var_2 = 0.0;

    var_3 = 2000.0;
    self _meth_8115( #animtree );
    var_4 = %vm_grapple_idle_rope;
    self _meth_814B( var_4, 1, 0, 0 );

    while ( isdefined( var_0 ) && isdefined( self ) )
    {
        var_5 = distance( self.origin, var_0.origin );

        if ( var_1 == 1 )
            var_5 -= 253.0;

        var_5 += var_2;
        var_6 = clamp( var_5 / var_3, 0.00001, 0.99999 );
        self _meth_8117( var_4, var_6 );
        wait 0.05;
    }
}

grapple_rope_state( var_0, var_1, var_2 )
{
    var_3 = self.grapple["model_rope_fire"];
    var_4 = self.grapple["model_rope_idle"];
    self.grapple["rope_state"] = var_0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    switch ( var_0 )
    {
        case 0:
            var_3 hide();
            var_3 _meth_848C( undefined );
            var_4 hide();
            var_4 _meth_848C( undefined );
            var_4 notify( "grapple_rope_length_thread" );
            break;
        case 1:
            var_3 show();
            var_3 _meth_8092();
            var_3.angles = self getangles();

            if ( var_2 )
                var_3 _meth_848C( undefined );
            else
                var_3 _meth_848C( self.grapple["model_rope_attach_world"] );

            var_4 show();
            var_4.angles = vectortoangles( self.grapple["model_rope_attach_player"].origin - var_3.origin );

            if ( var_2 )
                var_4 _meth_848C( undefined );
            else
                var_4 _meth_848C( self.grapple["model_rope_attach_player"] );

            var_4 thread grapple_rope_length_thread( self.grapple["model_rope_attach_player"], var_0, var_1 );
            break;
        case 2:
            var_3 hide();
            var_3 _meth_848C( undefined );
            var_4 show();
            var_4 _meth_8092();
            var_4.angles = vectortoangles( self.grapple["model_rope_attach_player"].origin - var_4.origin );

            if ( var_2 )
                var_4 _meth_848C( undefined );
            else
                var_4 _meth_848C( self.grapple["model_rope_attach_player"] );

            var_4 thread grapple_rope_length_thread( self.grapple["model_rope_attach_player"], var_0, var_1 );
            break;
    }
}

grapple_init_anims_weapon()
{
    level.grapple_weapon_anim = [];
    level.grapple_weapon_anim["fire"] = "fire";
    level.grapple_weapon_anim["travel"] = "reload";
    level.grapple_weapon_anim["ready"] = "raise";
}

grapple_init_death_style( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0.7;

    var_9 = spawnstruct();
    var_9.name = var_0;
    var_9.normal = var_1;
    var_9.dot = var_2;
    var_9.hint = var_3;
    var_9.validator = var_4;
    var_9.handler = var_5;
    var_9.handler_parm1 = var_6;
    var_9.handler_parm2 = var_7;
    var_9.handler_parm3 = var_8;
    level.grapple_death_styles[var_9.name] = var_9;
    return var_9;
}

grapple_init_death_styles()
{
    level.grapple_death_styles = [];
    grapple_init_death_style( "death_grapple_pull_back_obs", ( 1, 0, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed_obs, ::grapple_death_pull, "_obs", "death_grapple_back" );
    grapple_init_death_style( "death_grapple_pull_front_obs", ( -1, 0, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed_obs, ::grapple_death_pull, "_obs", "death_grapple_front" );
    grapple_init_death_style( "death_grapple_pull_right_obs", ( 0, 1, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed_obs, ::grapple_death_pull, "_obs", "death_grapple_right" );
    grapple_init_death_style( "death_grapple_pull_left_obs", ( 0, -1, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed_obs, ::grapple_death_pull, "_obs", "death_grapple_left" );
    grapple_init_death_style( "grapple_death_pull_above_obs", ( 0, 0, -1 ), cos( 30 ), "grapple_kill_pull", ::grapple_death_valid_pull_obs, ::grapple_death_pull, "_above_obs" );
    grapple_init_death_style( "grapple_death_pull_above_obs_45", ( 0, 0, -1 ), cos( 60 ), "grapple_kill_pull", ::grapple_death_valid_pull_obs, ::grapple_death_pull, "_above_obs_45" );
    grapple_init_death_style( "death_grapple_pull_back", ( 1, 0, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed, ::grapple_death_pull, "", "death_grapple_back" );
    grapple_init_death_style( "death_grapple_pull_front", ( -1, 0, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed, ::grapple_death_pull, "", "death_grapple_front" );
    grapple_init_death_style( "death_grapple_pull_right", ( 0, 1, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed, ::grapple_death_pull, "", "death_grapple_right" );
    grapple_init_death_style( "death_grapple_pull_left", ( 0, -1, 0 ), cos( 46 ), "grapple_kill_pull", ::grapple_death_valid_pull_concealed, ::grapple_death_pull, "", "death_grapple_left" );
    grapple_init_death_style( "grapple_death_pull_above", ( 0, 0, -1 ), cos( 30 ), "grapple_kill_pull", ::grapple_death_valid_pull, ::grapple_death_pull, "_above" );
    grapple_init_death_style( "grapple_death_pull_above_45", ( 0, 0, -1 ), cos( 60 ), "grapple_kill_pull", ::grapple_death_valid_pull, ::grapple_death_pull, "_above_45" );
    level.grapple_death_styles["default"] = level.grapple_death_styles["death_grapple_back"];
}

grapple_anim_length( var_0, var_1 )
{
    if ( isdefined( level.scr_anim[var_0] ) && isdefined( level.scr_anim[var_0][var_1] ) )
        return getanimlength( level.scr_anim[var_0][var_1] );

    return 0;
}

grapple_anim_anim( var_0, var_1 )
{
    if ( isdefined( level.scr_anim[var_0] ) && isdefined( level.scr_anim[var_0][var_1] ) )
        return level.scr_anim[var_0][var_1];

    return undefined;
}

grapple_anim_tree( var_0 )
{
    return level.scr_animtree[var_0];
}

grapple_shutdown()
{
    foreach ( var_1 in level.players )
        var_1 grapple_shutdown_player();

    level.grapple = undefined;
}

grapple_init_player()
{
    grapple_shutdown_player();
    self.grapple = [];
    grapple_models_init_player();
    self.grapple["preview_visible"] = 0;
    self.grapple["preview_good"] = 0;
    grapple_setup_rope_attached();
    grapple_setup_rope_fire();
    grapple_update_preview( 0, 0 );
    self.grapple["ready_time"] = 0;
    self.grapple["ready_weapon"] = 0;
    self.grapple["allowed"] = 0;
    self.grapple["grappling"] = 0;
    self.grapple["connected"] = 0;
    self.grapple["aborted"] = 0;
    self.grapple["mantle"] = undefined;
    self.grapple["listening"] = 0;
    self.grapple["in_range_min"] = 0;
    self.grapple["in_range_max"] = 0;
    self.grapple["weapon"] = "s1_grapple";
    self.grapple["weapon_prev"] = undefined;
    thread grapple_quick_fire_listener();
    self.grapple["dist_min"] = 100;
    self.grapple["dist_max"] = 1500;
    self.grapple["dist_max_2d"] = 1500;
    self.grapple["dist_max_kill"] = 800;
    self.grapple["speed"] = 600;
    self.grapple["mantle_kills"] = 1;
    self.grapple["ammoCounterHide"] = 0;
    self.grapple["useReticle"] = 1;
    self.grapple["exo_deactivated"] = 0;
    self.grapple["no_enable_exo"] = 0;
    self.grapple["no_enable_weapon"] = 0;
    self.grapple["weapon_enabled"] = 1;
    self.grapple["concealed"] = 0;
    self.grapple["style"] = undefined;
    self.grapple["hint_scale"] = 1.0;
    self.grapple["hint"] = undefined;
    self.grapple["hintText"] = undefined;
    self.grapple["poll_velocity"] = ( 0, 0, 0 );
    self.grapple["grapple_while_falling"] = 1;
    self.grapple["grappled_count"] = 0;
    self.grapple["linked_hands"] = 0;
    self.grapple["kill_obstructed_clear"] = 0;
    self.grapple["recent_load_reset"] = 0;
    self.grapple["enabled"] = 0;
    self.grapple["magnet_current"] = spawnstruct();
    self.grapple["magnet_test"] = spawnstruct();
    grapple_magnet_state( self.grapple["magnet_current"] );
    grapple_magnet_state( self.grapple["magnet_test"] );
    thread grapple_weapon_listener();
    thread grapple_start_listener();
    thread grapple_projectile_listener();
    thread grapple_death_listener();
    self.grapple["model_hands"] _meth_808E();
    self.grapple["model_body"] _meth_808E();
    self.grapple["model_rope_fire"] _meth_808E();
    self.grapple["model_rope_idle"] _meth_808E();
    grapple_give();
}

grapple_grappling_stealth_getstance()
{
    return "crouch";
}

grapple_grappling_stealth_getinshadow()
{
    return 1;
}

grapple_set_grappling( var_0 )
{
    if ( !isdefined( self.grapple ) )
        return;

    if ( self.grapple["grappling"] == var_0 )
        return;

    if ( !var_0 )
        grapple_motion_blur_disable();

    if ( isdefined( self._stealth ) )
    {
        if ( var_0 )
        {
            self.grapple["stealth_orig_stance"] = self._stealth.logic.getstance_func;
            self._stealth.logic.getstance_func = ::grapple_grappling_stealth_getstance;

            if ( isdefined( self._stealth.logic.getinshadow_func ) )
                self.grapple["stealth_orig_shadow"] = self._stealth.logic.getinshadow_func;

            self._stealth.logic.getinshadow_func = ::grapple_grappling_stealth_getinshadow;
        }
        else
        {
            if ( isdefined( self.grapple["stealth_orig_stance"] ) )
                self._stealth.logic.getstance_func = self.grapple["stealth_orig_stance"];

            if ( isdefined( self.grapple["stealth_orig_shadow"] ) )
                self._stealth.logic.getinshadow_func = self.grapple["stealth_orig_shadow"];

            self.grapple["stealth_orig_stance"] = undefined;
            self.grapple["stealth_orig_shadow"] = undefined;
        }
    }

    self.grapple["grappling"] = var_0;
}

grapple_autosave_grappling_check()
{
    if ( isdefined( level.player.grapple ) && level.player.grapple["grappling"] )
        return 0;

    return 1;
}

grapple_setup_rope_attached_player( var_0, var_1, var_2, var_3 )
{
    var_4 = self.grapple["model_rope_attach_player"];
    var_4 _meth_804F();
    var_5 = ( -3, 6, -2 );

    if ( isdefined( var_2 ) && var_2 )
    {
        if ( self.grapple["style"] == "ceiling" )
            var_5 = ( -5, 0, 3 );
        else
            var_5 = ( -3, 0, -6.6 );
    }

    if ( isplayer( var_1 ) )
    {
        var_4.origin = self.origin + ( 0, 0, 60 );
        var_4.angles = self getangles();
    }
    else
    {
        var_4.origin = var_1.origin;
        var_4.angles = var_1.angles;
    }

    if ( isdefined( var_3 ) )
        var_4 _meth_804D( var_0, var_3, var_5 + ( 0, 0, 60 ), ( 0, 0, 0 ) );
    else
    {
        var_4.origin += rotatevector( var_5, var_4.angles );
        var_4 _meth_804D( var_0 );
    }

    var_4 _meth_8092();
    var_6 = self.grapple["model_rope_idle"];
    var_6 _meth_8092();
}

grapple_setup_rope_attached( var_0 )
{
    if ( !isdefined( self.grapple["rope_state"] ) )
        self.grapple["rope_state"] = 0;

    var_1 = self.grapple["model_attach_world"];
    var_2 = self.grapple["model_rope_attach_world"];
    var_3 = self.grapple["model_rope_attach_player"];
    var_4 = self.grapple["model_rope_idle"];
    var_5 = self.grapple["model_player_move_tag"];
    var_6 = self.grapple["model_player_move_lerp"];
    var_2 _meth_804F();
    var_2.origin = var_1.origin + rotatevector( ( 0, 0, 0 ), var_1.angles );
    var_2.angles = var_1.angles;
    var_2 _meth_804D( var_1 );
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_6.origin = var_5.origin;
    var_6.angles = var_5.angles;
    var_6 _meth_8092();
    var_6 _meth_804D( var_5 );
    grapple_setup_rope_attached_player( var_6, self, var_0 );
    var_4 _meth_804F();
    var_4.origin = var_2.origin;
    var_4.angles = var_2.angles;
    var_4 _meth_804D( var_2 );
    var_4 thread grapple_rope_length_thread( var_3, self.grapple["rope_state"] );
    var_4 _meth_8092();
    var_5 _meth_8092();
    var_2 _meth_8092();
}

grapple_setup_rope_fire()
{
    var_0 = self.grapple["model_rope_attach_world"];
    var_1 = self.grapple["model_rope_fire"];
    var_2 = self.grapple["model_player_move_tag"];
    var_3 = self.grapple["model_player_move_lerp"];
    var_1 _meth_804F();
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_1.origin = self.origin + ( 0, 0, 60 );
    var_1.origin += rotatevector( ( 0, 0, 0 ), self getangles() );
    var_1.angles = self getangles();
    var_1 _meth_804D( var_3 );
    var_1 _meth_8092();
    var_2 _meth_8092();
}

grapple_models_init_player()
{
    foreach ( var_3, var_1 in level.grapple["models"] )
    {
        var_2 = undefined;

        if ( isdefined( level.scr_model[var_1] ) )
            var_2 = maps\_utility::spawn_anim_model( var_1, ( 0, 0, 0 ) );
        else
        {
            var_2 = spawn( "script_model", ( 0, 0, 0 ) );

            if ( isdefined( var_2 ) )
                var_2 _meth_80B1( var_1 );
        }

        if ( isdefined( var_2 ) )
        {
            var_2 _meth_82BF();
            var_2 setcontents( 0 );
            var_2 hide();
        }
        else
        {

        }

        self.grapple[var_3] = var_2;
    }
}

grapple_model_precache( var_0, var_1, var_2 )
{
    var_3 = var_1;

    if ( isdefined( level.scr_model[var_1] ) )
        var_3 = level.scr_model[var_1];

    precachemodel( var_3 );

    if ( !isdefined( level.grapple ) )
        level.grapple = [];

    if ( !isdefined( level.grapple["models"] ) )
        level.grapple["models"] = [];

    level.grapple["models"][var_0] = var_1;
}

grapple_shutdown_player()
{
    self notify( "grapple_shutdown_player" );

    if ( isdefined( self.grapple ) && isdefined( self.grapple["weapon"] ) )
        grapple_take();

    if ( isdefined( self.grapple ) )
    {
        grapple_update_preview( 0, 0 );
        grapple_set_status( "" );

        foreach ( var_2, var_1 in level.grapple["models"] )
        {
            if ( isdefined( self.grapple[var_2] ) )
                self.grapple[var_2] delete();
        }

        grapple_set_grappling( 0 );
        self.grapple = undefined;
        self.grapple_victim_landanim = undefined;
    }

    self _meth_8131( 1 );
}

grapple_weapon_listener()
{
    self endon( "death" );
    self endon( "grapple_shutdown_player" );
    level endon( "missionfailed" );

    for (;;)
    {
        var_0 = self _meth_8311();
        var_1 = var_0 == self.grapple["weapon"];

        if ( !var_1 || var_1 != self.grapple["ready_weapon"] )
            self.grapple["ready_time"] = max( gettime() + 250, self.grapple["ready_time"] );

        if ( self.grapple["quick_fire_down"] && self.grapple["weapon_enabled"] )
            self.grapple["ready_time"] = gettime();

        self.grapple["ready_weapon"] = var_1;

        if ( !var_1 && var_0 != "none" && self _meth_8314( self.grapple["weapon"] ) && !self _meth_8337() )
        {
            if ( !isdefined( self.grapple["switching_to_grapple"] ) || !self.grapple["switching_to_grapple"] )
                grapple_take_weapon();
        }

        if ( !self.grapple["enabled"] )
        {
            wait 0.05;
            continue;
        }

        if ( !var_1 && var_0 != "none" )
            _func_0D3( "cg_drawCrosshair", self.grapple["useReticle"] && !self.grapple["grappling"] );

        if ( var_1 )
        {
            self.grapple["switching_to_grapple"] = 0;
            self _meth_8131( 0 );
        }
        else
        {
            self _meth_8131( 1 );
            _func_0D3( "ammoCounterHide", self.grapple["ammoCounterHide"] );
            self _meth_8300( !self.grapple["ammoCounterHide"] );
            self _meth_8304( !self.grapple["ammoCounterHide"] );
        }

        self.grapple["kill_obstructed_clear"] = 0;

        if ( self.grapple["magnet_current"].valid && isdefined( self.grapple["magnet_current"].magnet ) && isai( self.grapple["magnet_current"].magnet.object ) )
        {
            var_2 = self.origin + anglestoforward( self.angles ) * 16 + ( 0, 0, 10 );
            var_3 = playerphysicstrace( self.origin, var_2, self );

            if ( distancesquared( var_3, var_2 ) > 0.01 )
            {
                var_2 = self.origin + anglestoforward( self.angles ) * -48 + ( 0, 0, 10 );
                var_3 = playerphysicstrace( self.origin, var_2, self );

                if ( distancesquared( var_3, var_2 ) < 0.01 )
                    self.grapple["kill_obstructed_clear"] = 1;
            }
        }

        wait 0.05;
    }
}

grapple_enabled()
{
    if ( !getdvarint( "grapple_enabled" ) )
        return 0;

    if ( !isdefined( self.grapple ) )
        return 0;

    if ( !self.grapple["enabled"] )
        return 0;

    if ( isdefined( self.tagging ) && isdefined( self.tagging["tagging_mode"] ) && self.tagging["tagging_mode"] )
        return 0;

    if ( isdefined( self.using_ammo_cache ) && self.using_ammo_cache )
        return 0;

    if ( self _meth_812E() )
        return 0;

    if ( self _meth_812C() || self _meth_83AD() )
        return 0;

    if ( self ismantling() )
        return 0;

    var_0 = weaponclass( self _meth_8311() );

    if ( var_0 == "item" || var_0 == "shield" )
        return 0;

    if ( common_scripts\utility::flag_exist( "player_has_cardoor" ) && common_scripts\utility::flag( "player_has_cardoor" ) )
        return 0;

    if ( common_scripts\utility::flag_exist( "player_pulling_cardoor" ) && common_scripts\utility::flag( "player_pulling_cardoor" ) )
        return 0;

    if ( !self.grapple["grapple_while_falling"] && !self _meth_8068() && !self _meth_8341() )
        return 0;

    if ( isdefined( self.underwater ) )
        return 0;

    return 1;
}

grapple_hint_hide_unusable()
{
    if ( !isdefined( self.grapple ) )
        return 1;

    if ( !isdefined( self.grapple["allowed"] ) )
        return 1;

    if ( !self.grapple["allowed"] )
        return 1;

    if ( !grapple_enabled() )
        return 1;

    if ( maps\_utility::isads() )
        return 1;

    return 0;
}

grapple_hint_hide_tutorial()
{
    if ( grapple_hint_hide_unusable() )
        return 1;

    if ( !getdvarint( "grapple_hint_button_always" ) )
    {
        if ( self.grapple["grappled_count"] >= 2 )
            return 1;
    }

    return 0;
}

grapple_hint_hide_kill()
{
    if ( grapple_hint_hide_unusable() )
        return 1;

    if ( !isdefined( grapple_special_hint() ) && ( !isdefined( self.grapple["mantle"] ) || !isdefined( self.grapple["mantle"]["victim"] ) ) )
        return 1;

    return 0;
}

grapple_hint_hide_kill_pull()
{
    if ( grapple_hint_hide_unusable() )
        return 1;

    if ( !isdefined( self.grapple["deathstyle"] ) || !isdefined( self.grapple["deathstyle"].hint ) )
        return 1;

    return 0;
}

grapple_not_connected()
{
    if ( !isdefined( self.grapple ) )
        return 1;

    if ( !isdefined( self.grapple["connected"] ) )
        return 1;

    if ( !self.grapple["connected"] )
        return 1;

    if ( !grapple_enabled() )
        return 1;

    return 0;
}

grapple_register_hint( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level.grapple_hints ) )
        level.grapple_hints = [];

    if ( !isdefined( var_1 ) )
        var_1 = var_2;

    if ( !isdefined( var_2 ) )
        var_2 = var_1;

    level.grapple_hints[var_0] = 1;
    maps\_utility::add_hint_string( var_0 + "_gamepad", var_1, var_3 );
    maps\_utility::add_hint_string( var_0 + "_pc", var_2, var_3 );
}

grapple_set_hint( var_0 )
{
    if ( isdefined( self.grapple["hintText"] ) && self.grapple["hintText"] == var_0 )
        return;

    if ( var_0 == "grapple_kill_pull" && getdvarint( "grapple_concealed_kill" ) == 2 )
        return;

    if ( isdefined( self.grapple["hint"] ) )
    {
        self.grapple["hint"] maps\_utility::hint_delete();
        self.grapple["hint"] = undefined;
        self.grapple["hintText"] = undefined;
    }

    if ( isdefined( var_0 ) && var_0 != "" )
    {
        if ( isdefined( level.grapple_hints[var_0] ) )
        {
            if ( self _meth_834E() )
                maps\_utility::display_hint( var_0 + "_gamepad" );
            else
                maps\_utility::display_hint( var_0 + "_pc" );
        }
        else
        {
            self.grapple["hint"] = maps\_utility::hint_create( var_0 );
            self.grapple["hintText"] = var_0;

            if ( isdefined( self.grapple["hint"] ) )
            {
                self.grapple["hint"].elm.aligny = "bottom";
                self.grapple["hint"].elm.vertalign = "bottom";

                if ( isdefined( self.grapple["hint"].bg ) )
                {
                    self.grapple["hint"].bg.aligny = "bottom";
                    self.grapple["hint"].bg.vertalign = "bottom";
                }
            }

            return self.grapple["hint"];
        }
    }
}

grapple_text_compare( var_0, var_1 )
{
    if ( isdefined( var_0 ) && !isdefined( var_1 ) )
        return 1;

    if ( !isdefined( var_0 ) && isdefined( var_1 ) )
        return 1;

    if ( !isdefined( var_0 ) && !isdefined( var_1 ) )
        return 0;

    if ( isstring( var_0 ) && isstring( var_1 ) && var_0 == var_1 )
        return 0;

    if ( !isstring( var_0 ) && !isstring( var_1 ) && var_0 == var_1 )
        return 0;

    return 1;
}

grapple_status_text_show( var_0, var_1, var_2, var_3 )
{
    if ( !getdvarint( "grapple_status_text" ) )
        return;

    self notify( "grapple_status_text_show_" + var_1 );
    self endon( "grapple_status_text_show_" + var_1 );
    var_4 = gettime();
    var_5 = "status_text_" + var_1;
    var_6 = var_5 + "_last";
    var_7 = var_5 + "_hint";
    var_8 = var_5 + "_dim";
    self.grapple[var_8] = 0;
    var_9 = self.grapple[var_5];

    while ( gettime() - var_4 <= var_0 )
    {
        if ( isdefined( var_9 ) && ( !isstring( var_9 ) || var_9 != "" ) )
        {
            if ( grapple_text_compare( var_9, self.grapple[var_6] ) )
            {
                if ( isdefined( self.grapple[var_7] ) )
                    self.grapple[var_7] maps\_utility::hint_delete();

                self.grapple[var_7] = maps\_utility::hint_create( var_9 );

                if ( getdvarint( "grapple_hint_always" ) )
                    self.grapple[var_7].elm.color = ( 1, 1, 1 );
                else
                    self.grapple[var_7].elm.color = ( 1, 0, 0 );

                self.grapple[var_7].elm.y = var_3;
                self.grapple[var_7].elm.x = var_2;
                self.grapple[var_6] = var_9;
            }

            if ( isdefined( self.grapple[var_7] ) && !self.grapple[var_8] )
            {
                if ( self.grapple["allowed"] || gettime() - var_4 >= var_0 * 0.95 || !isdefined( self.grapple[var_5] ) || isstring( self.grapple[var_5] ) != isstring( var_9 ) || self.grapple[var_5] != var_9 )
                {
                    self.grapple[var_7].elm.alpha *= 0.5;
                    self.grapple[var_8] = 1;
                }
            }
        }
        else if ( isdefined( self.grapple[var_7] ) )
            break;

        wait 0.05;
    }

    if ( isdefined( self.grapple[var_7] ) )
    {
        self.grapple[var_7] maps\_utility::hint_delete();
        self.grapple[var_7] = undefined;
        self.grapple[var_6] = undefined;
        self.grapple[var_8] = undefined;
    }
}

grapple_commit_status()
{
    self notify( "grapple_commit_status" );

    if ( !isdefined( self.grapple ) )
        return;

    var_0 = self.grapple["icon_name_desired"];
    var_1 = self.grapple["icon_allowed_desired"];
    var_2 = self.grapple["icon_entity_style"];

    if ( !isdefined( var_0 ) )
        var_0 = "";

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = "";

    if ( !isalive( self ) )
        var_0 = "";

    if ( !grapple_enabled() )
        var_0 = "";

    if ( maps\_utility::isads() )
        var_0 = "";

    if ( var_0 != "" )
    {
        if ( getdvarint( "grapple_hint_always" ) == 0 )
        {
            if ( self.grapple["ready_time"] > gettime() )
                var_0 = "";
        }
        else if ( !var_1 )
            var_0 = "";
    }

    var_0 = "";
    var_3 = var_0 + "_" + var_1 + "_" + var_2;
    var_4 = undefined;
    var_5 = self.grapple["weapon_enabled"] && self _meth_8311() == self.grapple["weapon"];

    if ( getdvarint( "grapple_hint_always" ) == 0 )
        grapple_commit_reticles( ( 1, 0, 0 ), var_0 != "" );
    else
        grapple_commit_reticles( ( 1, 1, 1 ), var_0 != "" );

    var_6 = ( 1, 1, 1 );

    if ( getdvarint( "grapple_hint_always" ) == 0 )
    {
        if ( var_1 )
            var_6 = ( 0, 1, 0 );
        else
            var_6 = ( 1, 0, 0 );
    }

    if ( var_2 == "kill" )
        var_6 = ( 1, 0.5, 0 );

    if ( !isdefined( self.grapple["icon_name"] ) || self.grapple["icon_name"] != var_3 )
    {
        self.grapple["icon_name"] = var_3;

        if ( var_0 == "" )
        {
            if ( isdefined( self.grapple["icon"] ) )
            {
                self.grapple["icon"] destroy();
                self.grapple["icon"] = undefined;
            }

            return;
        }

        if ( isdefined( self.grapple["icon"] ) )
            var_4 = self.grapple["icon"];
        else
            var_4 = newhudelem();

        var_4.x = 0;
        var_4.sort = 999;
        var_4.alignx = "center";
        var_4.aligny = "middle";
        var_4.horzalign = "center";
        var_4.vertalign = "middle";
        var_4.fontscale = 2.5;
        var_4.hidewheninmenu = 1;
        var_4 settext( "^3[{+smoke}]^7 Grapple" );
        var_4.y = 100;

        if ( getdvarint( "grapple_hint_always" ) != 0 )
            var_4.alpha = 1;

        self.grapple["icon"] = var_4;
    }

    if ( isdefined( self.grapple["icon"] ) )
        self.grapple["icon"].color = var_6;

    grapple_commit_reticles( var_6, 0 );
}

grapple_commit_reticles( var_0, var_1 )
{
    var_2 = [ "grapple_reticle_indicator" ];
    var_3 = [ var_1 ];

    foreach ( var_7, var_5 in var_2 )
    {
        if ( var_3[var_7] && !isdefined( self.grapple[var_5] ) )
        {
            var_6 = newhudelem();
            var_6.x = 0;
            var_6.y = 0;
            var_6.sort = 999;
            var_6.alignx = "center";
            var_6.aligny = "middle";
            var_6.horzalign = "center";
            var_6.vertalign = "middle";
            var_6.hidewheninmenu = 1;
            var_6 _meth_80CC( var_5, 128, 128 );
            self.grapple[var_5] = var_6;
        }
        else if ( !var_3[var_7] && isdefined( self.grapple[var_5] ) )
        {
            self.grapple[var_5] destroy();
            self.grapple[var_5] = undefined;
        }

        if ( var_3[var_7] && isdefined( self.grapple[var_5] ) )
            self.grapple[var_5].color = var_0;
    }
}

grapple_set_status( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "";

    self.grapple["icon_name_desired"] = var_0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    self.grapple["icon_allowed_desired"] = var_2;

    if ( !isdefined( var_1 ) )
        var_1 = "";

    self.grapple["icon_entity_style"] = var_1;

    if ( !isdefined( var_3 ) )
        var_3 = "";

    self.grapple["status_text_reason"] = var_3;
    thread grapple_commit_status();
}

grapple_update_preview( var_0, var_1 )
{
    var_2 = 1.5;

    if ( level.ps3 )
        var_2 = 1.2;
    else if ( level.xenon )
        var_2 = 0.8;

    if ( !isdefined( self.grapple ) )
        return;

    if ( var_0 && !maps\_utility::isads() && isdefined( self.grapple["model_preview_hint"] ) )
    {
        var_3 = self.grapple["grappled_count"] < 2 || getdvarint( "grapple_hint_button_always" );

        if ( getdvarint( "grapple_tutorial" ) && var_3 && !isdefined( self.grapple["quick_hint_text"] ) )
        {
            if ( !self.grapple["magnet_current"].valid )
                grapple_set_hint( "grapple_input_tutorial" );
            else
            {
                var_4 = newhudelem();
                var_4 settext( "^3[{+smoke}]^7" );
                var_4.alignx = "center";
                var_4.aligny = "middle";
                var_4.horzalign = "center";
                var_4.vertalign = "middle";
                var_4.positioninworld = 1;
                var_4.fontscale = var_2;
                var_4.alpha = 1;
                var_4.vistime = gettime();
                var_4.hidewheninmenu = 1;
                self.grapple["model_preview"] _meth_8092();
                self.grapple["model_preview_hint"] _meth_8092();
                var_4 _meth_80CD( self.grapple["model_preview_hint"], "tag_origin" );
                self.grapple["quick_hint_text"] = var_4;
            }
        }

        if ( !getdvarint( "grapple_hint_button_always" ) && self.grapple["grappled_count"] && getdvarint( "grapple_tutorial" ) && isdefined( self.grapple["quick_hint_text"] ) && gettime() - self.grapple["quick_hint_text"].vistime > 1000 && self.grapple["quick_hint_text"].alpha > 0 )
            self.grapple["quick_hint_text"].alpha -= 0.05;

        if ( isdefined( grapple_special_hint() ) )
            grapple_set_hint( grapple_special_hint() );
        else if ( isdefined( self.grapple["deathstyle"] ) )
            grapple_set_hint( self.grapple["deathstyle"].hint );
        else if ( isdefined( self.grapple["mantle"] ) && isdefined( self.grapple["mantle"]["victim"] ) )
            grapple_set_hint( "grapple_kill" );

        if ( !isdefined( self.grapple["quick_hint_icon"] ) )
        {
            var_4 = newhudelem();
            var_4.x = 0;
            var_4.y = 0;
            var_4.z = 0;
            var_4.alignx = "center";
            var_4.aligny = "middle";
            var_4.horzalign = "center";
            var_4.vertalign = "middle";
            var_4.positioninworld = 1;
            var_4.hidewheninmenu = 1;
            self.grapple["model_preview"] _meth_8092();
            var_4 _meth_80CD( self.grapple["model_preview_hint"], "tag_origin" );
            self.grapple["quick_hint_icon"] = var_4;
        }

        if ( !var_1 )
        {
            if ( isdefined( self.grapple["quick_hint_mantle"] ) )
                self.grapple["quick_hint_mantle"] destroy();
        }

        if ( self.grapple["magnet_current"].valid )
        {
            self.grapple["quick_hint_icon"] _meth_80CC( "grapple_reticle_indicator_small", 32, 32 );
            self.grapple["quick_hint_icon"].positioninworld = 1;
            self.grapple["quick_hint_icon"] _meth_80CD( self.grapple["model_preview_hint"], "tag_origin" );
        }
        else
        {
            self.grapple["quick_hint_icon"] _meth_80CC( "grapple_reticle_indicator", 128, 128 );
            self.grapple["quick_hint_icon"].positioninworld = 0;
        }

        if ( self.grapple["magnet_current"].valid && isdefined( self.grapple["magnet_current"].magnet ) && isai( self.grapple["magnet_current"].magnet.object ) )
        {
            if ( isdefined( self.grapple["quick_hint_icon"] ) )
                self.grapple["quick_hint_icon"].color = ( 1, 0.5, 0 );

            if ( isdefined( self.grapple["quick_hint_text"] ) )
            {
                self.grapple["quick_hint_text"].color = ( 1, 0.5, 0 );
                return;
            }

            return;
        }

        if ( isdefined( self.grapple["quick_hint_icon"] ) )
            self.grapple["quick_hint_icon"].color = ( 1, 1, 1 );

        if ( isdefined( self.grapple["quick_hint_text"] ) )
        {
            self.grapple["quick_hint_text"].color = ( 1, 1, 1 );
            return;
        }

        return;
    }
    else
    {
        if ( isdefined( self.grapple["quick_hint_text"] ) )
            self.grapple["quick_hint_text"] destroy();

        if ( isdefined( self.grapple["quick_hint_icon"] ) )
            self.grapple["quick_hint_icon"] destroy();

        if ( isdefined( self.grapple["quick_hint_icon"] ) )
            self.grapple["quick_hint_icon"] destroy();

        if ( isdefined( self.grapple["quick_hint_mantle"] ) )
            self.grapple["quick_hint_mantle"] destroy();
    }
}

grapple_update_preview_position( var_0, var_1, var_2 )
{
    var_3 = self.grapple["model_preview"];
    var_4 = self.grapple["model_preview_hint"];

    if ( isdefined( var_3.linked_entity ) && isdefined( var_2.land_entity ) && isdefined( var_3.linked_magnet ) && isdefined( var_2.land_magnet ) && var_3.linked_entity == var_2.land_entity && var_3.linked_magnet == var_2.land_magnet && !isdefined( var_2.land_magnet.next ) )
        return;

    var_3 _meth_804F();
    var_3.linked_entity = undefined;
    var_3.linked_magnet = undefined;
    var_3.origin = var_0;
    var_3.angles = var_1;

    if ( isdefined( var_2.land_entity ) )
    {
        if ( isdefined( var_2.land_magnet ) && var_2.land_magnet.tag != "" )
        {
            var_3.origin = var_2.land_magnet.object gettagorigin( var_2.land_magnet.tag );
            var_3.angles = var_2.land_magnet.object gettagangles( var_2.land_magnet.tag );
            var_3.origin += rotatevector( var_2.land_magnet.tag_offset, self.angles );
            var_3 _meth_804D( var_2.land_entity, var_2.land_magnet.tag );
        }
        else
            var_3 _meth_804D( var_2.land_entity );

        var_3.linked_entity = var_2.land_entity;
        var_3.linked_magnet = var_2.land_magnet;
    }

    if ( self.grapple["magnet_current"].valid && ( !isdefined( self.grapple["magnet_current"].magnet ) || self.grapple["magnet_current"].magnet.tag == "" ) )
    {
        if ( isdefined( self.grapple["mantle"] ) )
            var_4.origin = ( var_3.origin[0], var_3.origin[1], self.grapple["mantle"]["ledge"][2] );
        else
            var_4.origin = var_3.origin + ( 0, 0, 8 );

        var_5 = grapple_special_indicator_offset();
        var_4.origin += var_5;
        var_4 _meth_804D( var_3 );
    }
    else
    {
        var_4.origin = var_3 gettagorigin( "tag_origin" );
        var_5 = grapple_special_indicator_offset();
        var_4.origin += var_5;
        var_4 _meth_804D( var_3 );
    }
}

grapple_quick_fire_listener()
{
    self notify( "grapple_quick_fire_listener" );
    self endon( "death" );
    self endon( "grapple_shutdown_player" );
    self endon( "grapple_take" );
    self endon( "grapple_quick_fire_listener" );
    self.grapple["quick_fire_action"] = "smoke";
    self _meth_82DD( "quickFireDown", "+" + self.grapple["quick_fire_action"] );
    self _meth_82DD( "quickFireUp", "-" + self.grapple["quick_fire_action"] );
    childthread grapple_quick_fire_wait_and_set( "quickFireDown", "quick_fire_button_down", 1, 0 );
    childthread grapple_quick_fire_wait_and_set( "quickFireUp", "quick_fire_button_up", 1, 1 );
    self.grapple["quick_fire_down"] = 0;
    self.grapple["quick_fire_up"] = 0;
    self.grapple["quick_fire_button_down"] = 0;
    self.grapple["quick_fire_button_up"] = 0;
    self.grapple["quick_fire_executed"] = 0;
    self.grapple["quick_firing"] = 0;
    var_0 = 0;

    for (;;)
    {
        var_0 += 1;

        if ( var_0 >= 2 )
            self.grapple["quick_firing"] = 0;

        if ( self.grapple["quick_fire_button_up"] )
        {
            if ( self.grapple["quick_fire_down"] && !self.grapple["quick_fire_up"] )
            {
                self.grapple["quick_fire_button_up"] = 0;
                self.grapple["quick_fire_up"] = 1;
                self.grapple["quick_firing"] = 1;

                if ( self _meth_8311() == self.grapple["weapon"] )
                    self.grapple["quick_fire_trace"] = undefined;

                while ( self.grapple["allowed"] && self _meth_8311() != self.grapple["weapon"] )
                    wait 0.05;

                self _meth_8322();

                if ( self.grapple["allowed"] )
                    grapple_start( "grapple_quick" );
                else
                    grapple_switch( 0 );

                self.grapple["quick_fire_down"] = 0;
                self.grapple["quick_fire_up"] = 0;
            }
            else
                self.grapple["quick_fire_button_down"] = 0;
        }

        if ( !self.grapple["quick_fire_down"] && !self.grapple["quick_fire_button_down"] )
            self.grapple["quick_fire_button_up"] = 0;

        if ( !self.grapple["quick_fire_down"] && self.grapple["quick_fire_button_down"] )
        {
            if ( self _meth_8311() != self.grapple["weapon"] && getdvarint( "grapple_hint_always" ) && ( !self.grapple["allowed"] || maps\_utility::isads() ) )
            {
                thread grapple_status_text_show( 1000, "reason", 0, 90 );
                wait 0.05;
                continue;
            }

            if ( isdefined( self.tagging ) && isdefined( self.tagging["drone"] ) )
            {
                wait 0.05;
                continue;
            }

            self.grapple["quick_fire_button_down"] = 0;

            if ( self _meth_8311() == self.grapple["weapon"] || !self _meth_82EE() )
            {
                if ( self _meth_8311() != self.grapple["weapon"] )
                {
                    var_1 = self.grapple["model_player_to"];

                    if ( grapple_special() == "callback" )
                    {
                        self.grapple["ready_time"] = gettime();
                        grapple_start( "grapple_quick" );
                    }
                    else
                    {
                        self.grapple["quick_fire_down"] = 1;
                        self.grapple["quick_firing"] = 1;
                        var_2 = grapple_trace_parms();
                        self.grapple["quick_fire_trace"] = _func_291( var_2["start"], var_2["end"], self );

                        if ( isdefined( self.grapple["quick_fire_trace"]["entity"] ) )
                        {
                            var_3 = self.grapple["quick_fire_trace"]["entity"];
                            var_4 = self.grapple["quick_fire_trace"]["position"] - var_3.origin;
                            var_4 = rotatevector( var_4, var_3.angles * -1 );
                            self.grapple["quick_fire_trace"]["local_position"] = var_4;
                        }

                        var_0 = 0;
                        grapple_switch( 1, 1 );
                        self _meth_8321();
                    }
                }
                else
                    grapple_start( "grapple" );
            }
        }

        wait 0.05;
    }
}

grapple_quick_fire_wait_and_set( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        self waittill( var_0 );

        if ( self.grapple["listening"] )
            self.grapple[var_1] = var_2;
        else
            self.grapple[var_1] = var_3;

        wait 0.05;
    }
}

grapple_enabled_listener_flag()
{
    self notify( "grapple_enabled_listener_flag" );
    self endon( "grapple_enabled_listener_flag" );
    self.grapple["listening"] = 1;
    common_scripts\utility::waittill_any( "death", "grapple_started", "grapple_shutdown_player" );

    if ( isdefined( self ) && isdefined( self.grapple ) )
        self.grapple["listening"] = 0;
}

grapple_enabled_listener()
{
    self notify( "grapple_enabled_listener" );
    self endon( "grapple_enabled_listener" );
    self endon( "death" );
    self endon( "grapple_started" );
    self endon( "grapple_shutdown_player" );
    thread grapple_enabled_listener_flag();
    var_0 = self.grapple["model_player_to"];

    for (;;)
    {
        var_1 = "grapple_invalid";
        var_2 = "";
        var_3 = &"GRAPPLE_NO_FOOTING";
        var_4 = self.grapple["ready_time"] <= gettime();
        var_5 = grapple_enabled();

        if ( self.grapple["quick_firing"] || self.grapple["grappling"] )
        {
            if ( !var_5 )
            {
                grapple_update_preview( 0, 0 );
                grapple_set_status( var_1, var_2, 0, var_3 );
            }

            wait 0.05;
            continue;
        }

        self.grapple["allowed"] = 0;
        self.grapple["in_range_min"] = 0;
        self.grapple["in_range_max"] = 0;
        self.grapple["mantle"] = undefined;

        if ( !var_5 )
        {
            grapple_update_preview( 0, 0 );
            grapple_set_status( var_1, var_2, self.grapple["allowed"], var_3 );
            wait 0.05;
            continue;
        }

        grapple_magnet_update();
        var_6 = undefined;

        if ( self.grapple["magnet_current"].valid && isdefined( self.grapple["magnet_current"].tracevalidation ) )
            var_6 = self.grapple["magnet_current"].tracevalidation;
        else if ( getdvarint( "grapple_magnet_required" ) && self.grapple["magnet_current"].possible )
            var_3 = self.grapple["magnet_current"].tracevalidation["reason"];
        else if ( !getdvarint( "grapple_magnet_required" ) )
        {
            var_7 = grapple_trace_parms();
            var_8 = _func_291( var_7["start"], var_7["end"], self, 0 );
            var_6 = grapple_trace_validate( var_8, var_7["dist"], var_7["forward"], var_7["angles"] );
        }

        var_6 = grapple_trace_validate_mantle( var_6, self.grapple["magnet_current"] );

        if ( isdefined( var_6 ) && !isdefined( self.grapple["magnet_current"].magnet ) && getdvarint( "grapple_mantle_required" ) && !isdefined( var_6["mantle"] ) )
            var_6 = undefined;

        if ( !isdefined( var_6 ) )
        {
            grapple_update_preview( 0, 0 );
            grapple_set_status( var_1, var_2, self.grapple["allowed"], var_3 );
            wait 0.05;
            continue;
        }

        var_0.land_entity = undefined;
        var_0.land_tag = undefined;
        var_0 _meth_804F();
        self.grapple["allowed"] = var_6["allowed"];
        self.grapple["style"] = var_6["style"];
        self.grapple["in_range_max"] = var_6["in_range_max"];
        self.grapple["in_range_min"] = var_6["in_range_min"];
        self.grapple["mantle"] = var_6["mantle"];
        self.grapple["surface_trace"] = var_6["surface_trace"];
        self.grapple["deathstyle"] = var_6["deathstyle"];
        var_0.land_entity = var_6["land_entity"];
        var_0.land_magnet = var_6["land_magnet"];
        var_0.origin = var_6["tag_origin"];
        var_0.angles = var_6["tag_angles"];
        var_0.style = var_6["style"];
        var_3 = var_6["reason"];
        var_9 = var_6["valid_surface"];
        var_10 = self.grapple["dist_min"];

        if ( isdefined( var_6["dist_min"] ) )
            var_10 = var_6["dist_min"];

        if ( isdefined( var_0.land_entity ) )
        {
            if ( isdefined( var_0.land_magnet ) && var_0.land_magnet.tag != "" )
                var_0 _meth_804D( var_0.land_entity, var_0.land_magnet.tag );
            else
                var_0 _meth_804D( var_0.land_entity );
        }

        var_0 _meth_8092();
        var_11 = self.grapple["model_preview"];
        var_12 = var_6["surface_trace"]["normal"];
        var_13 = vectordot( var_12, ( 0, 0, 1 ) );

        if ( abs( var_13 ) > 0.99999 )
            var_14 = vectorcross( anglestoforward( self getangles() ), var_12 );
        else
            var_14 = vectorcross( ( 0, 0, 1 ), var_12 );

        var_15 = vectorcross( var_12, var_14 );
        grapple_update_preview_position( var_6["surface_trace"]["position"], axistoangles( var_15, var_14, var_12 ), var_0 );
        var_16 = 0;

        if ( var_9 && distancesquared( var_0.origin, self.origin ) > var_10 * var_10 )
            var_16 = 1;

        if ( !var_9 && self.grapple["in_range_max"] && self.grapple["in_range_min"] )
        {
            var_3 = &"GRAPPLE_INVALID_SURFACE";
            self.grapple["allowed"] = 0;
        }
        else if ( !self.grapple["in_range_max"] )
        {
            var_3 = &"GRAPPLE_TOO_FAR";
            self.grapple["allowed"] = 0;
        }
        else if ( !self.grapple["in_range_min"] )
        {
            var_3 = &"GRAPPLE_TOO_CLOSE";
            self.grapple["allowed"] = 0;
        }

        if ( self.grapple["allowed"] )
        {
            var_1 = "grapple_valid";
            var_2 = "";
            var_3 = "";
        }

        var_2 = grapple_entity_style( self.grapple["surface_trace"]["entity"], var_6["land_magnet"] );

        if ( isdefined( var_2 ) )
        {
            var_1 = "grapple_valid";
            self.grapple["allowed"] = self.grapple["in_range_max"];
        }
        else if ( self _meth_817C() == "prone" )
        {
            var_1 = "grapple_invalid";
            var_3 = &"GRAPPLE_NO_FOOTING";
            self.grapple["allowed"] = 0;
        }

        grapple_update_preview( self.grapple["allowed"], isdefined( self.grapple["mantle"] ) );
        grapple_set_status( var_1, var_2, self.grapple["allowed"], var_3 );
        wait 0.05;
    }
}

grapple_trace_validate( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    var_5["allowed"] = 0;
    var_5["in_range_min"] = 0;
    var_5["in_range_max"] = 0;
    var_5["mantle"] = undefined;
    var_5["surface_trace"] = var_0;
    var_5["valid_surface"] = grapple_check_surface_type( var_0, var_4 );
    var_5["deathstyle"] = undefined;
    var_6 = self _meth_80A8();
    var_7 = distancesquared( ( var_0["position"][0], var_0["position"][1], 0 ), ( var_6[0], var_6[1], 0 ) );
    var_8 = var_0["fraction"] * var_1;
    var_9 = var_0["normal"];
    var_10 = undefined;

    if ( isdefined( var_4 ) )
        var_10 = var_4.magnet;

    if ( isdefined( var_10 ) && isdefined( var_10.specialstruct ) && isdefined( var_10.specialstruct.forcestyle ) )
        var_5["style"] = var_10.specialstruct.forcestyle;
    else
        var_5["style"] = grapple_get_style( var_0["position"], var_9 );

    var_11 = var_0["normal"] * -1;
    var_12 = "";
    var_13 = var_0["position"];

    if ( isdefined( var_10 ) && isdefined( var_10.object ) && var_10.tag != "" )
    {
        var_12 = var_10.tag;
        var_13 = var_10.object gettagorigin( var_12 );
        var_13 += rotatevector( var_10.tag_offset, var_10.object gettagangles( var_12 ) );
    }

    if ( var_5["style"] == "ceiling" )
    {
        var_5["tag_origin"] = var_13 + ( 0, 0, -75 );
        var_5["tag_angles"] = var_3;
    }
    else if ( var_5["style"] == "floor" )
    {
        var_5["tag_origin"] = var_13;
        var_5["tag_angles"] = var_3;
    }
    else
    {
        var_5["tag_origin"] = var_13 + ( 0, 0, -30 );
        var_5["tag_angles"] = vectortoangles( var_11 );
    }

    var_5["reason"] = &"GRAPPLE_TOO_FAR";
    var_14 = self.grapple["dist_max"];
    var_15 = self.grapple["dist_max_2d"];
    var_16 = self.grapple["dist_min"];

    if ( isdefined( var_10 ) && isdefined( var_10.specialstruct ) )
    {
        if ( isdefined( var_10.specialstruct.distmin ) )
        {
            var_16 = var_10.specialstruct.distmin;
            var_5["dist_min"] = var_16;
        }

        if ( isdefined( var_10.specialstruct.distmax ) )
        {
            var_14 = var_10.specialstruct.distmax;
            var_5["dist_max"] = var_14;
        }
    }

    if ( var_8 <= var_14 && var_7 <= var_15 * var_15 && var_0["fraction"] < 1.0 )
    {
        var_5["in_range_max"] = 1;
        var_5["reason"] = &"GRAPPLE_TOO_CLOSE";

        if ( var_8 >= var_16 )
        {
            var_5["in_range_min"] = 1;
            var_17 = vectordot( var_9, var_2 * -1 );

            if ( var_5["style"] == "wall" )
            {
                var_18 = vectornormalize( ( var_2[0], var_2[1], min( 0, var_2[2] ) ) );
                var_17 = vectordot( var_9, var_18 * -1 );
            }

            var_19 = getdvarfloat( "grapple_surface_dot_limit" );
            var_5["reason"] = &"GRAPPLE_TOO_SHARP";

            if ( var_17 >= var_19 || var_5["style"] == "floor" )
            {
                if ( var_12 == "" )
                {
                    var_20 = _func_238( var_5["tag_origin"] + var_9 * 50, var_13 + var_9 * -50, self );
                    var_5["tag_origin"] = var_20["position"] + var_9;
                    var_5["tag_angles"] = ( 0, var_5["tag_angles"][1], 0 );
                }

                var_21 = _func_238( var_5["tag_origin"], var_5["tag_origin"] + var_9 * 0.1, self );
                var_5["reason"] = &"GRAPPLE_NO_SPACE";

                if ( var_12 != "" )
                    var_5["allowed"] = 1;
                else if ( var_5["valid_surface"] && isdefined( var_21["fraction"] ) && var_21["fraction"] == 1.0 && grapple_abort_trace_passed( var_5["tag_origin"] ) )
                    var_5["allowed"] = 1;

                var_5["land_entity"] = var_0["entity"];
                var_5["land_magnet"] = undefined;

                if ( isdefined( var_10 ) && isdefined( var_10.object ) )
                {
                    var_5["land_magnet"] = var_10;

                    if ( !var_10.static )
                        var_5["land_entity"] = var_10.object;

                    if ( var_12 != "" && isdefined( var_10.afterlandanim ) && isdefined( var_5["land_entity"] ) )
                    {
                        var_22 = self.grapple["model_body"];
                        var_22 _meth_804F();
                        var_22 _meth_804D( var_5["land_entity"], var_12, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                        var_22 _meth_8092();
                        var_22 _meth_8145( var_10.afterlandanim, 1, 0, 0 );
                        var_5["tag_origin"] = var_22 gettagorigin( "tag_player" );
                        var_5["tag_angles"] = var_22 gettagangles( "tag_player" );
                    }
                }

                if ( var_5["allowed"] && !isdefined( var_5["mantle"] ) )
                {
                    var_5["reason"] = &"GRAPPLE_NO_FOOTING";
                    var_5["allowed"] = grapple_check_footing( var_5 );
                }
            }
        }
    }

    var_23 = grapple_entity_style( var_0["entity"], var_10 );

    if ( isdefined( var_23 ) )
    {
        var_5["allowed"] = var_5["in_range_max"];
        var_5["deathstyle"] = grapple_death_style( var_0["entity"] );
    }

    return var_5;
}

grapple_trace_validate_mantle( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_2 = undefined;
    var_3 = "";

    if ( isdefined( var_1 ) && var_1.valid )
        var_2 = var_1.magnet;

    if ( isdefined( var_2 ) && isdefined( var_2.object ) && var_2.tag != "" )
        var_3 = var_2.tag;

    if ( var_0["style"] == "wall" && var_3 == "" )
    {
        var_4 = self _meth_849D( var_0["tag_origin"], var_0["tag_angles"], 0, getdvarint( "grapple_mantle_reach" ), 1 );

        if ( isdefined( var_4["valid"] ) && var_4["valid"] )
        {
            var_4["victim"] = grapple_mantle_find_victim( var_4 );
            var_5 = self.grapple["model_player_to"];
            var_4["position_local"] = _func_24D( var_4["position"] - var_5.origin, var_5.angles );
            var_4["ledge_local"] = _func_24D( var_4["ledge"] - var_5.origin, var_5.angles );
            var_0["mantle"] = var_4;

            if ( isdefined( var_4["over"] ) && var_4["over"] )
                var_0["tag_origin"] = ( var_0["tag_origin"][0], var_0["tag_origin"][1], var_4["ledge"][2] + -32 );
            else
                var_0["tag_origin"] = ( var_0["tag_origin"][0], var_0["tag_origin"][1], var_4["ledge"][2] + -64 );
        }
    }

    return var_0;
}

grapple_mantle_find_victim( var_0 )
{
    var_1 = getdvarfloat( "grapple_mantle_kill_radius" );
    var_1 *= var_1;

    if ( self.grapple["mantle_kills"] )
    {
        var_2 = var_0["position"];
        var_3 = _func_0D6( "axis" );

        foreach ( var_5 in var_3 )
        {
            if ( !var_5 grapple_ai_alive() )
                continue;

            if ( distancesquared( var_5.origin, var_2 ) > var_1 )
                continue;

            if ( issubstr( var_5.classname, "mech" ) )
                continue;

            return var_5;
        }
    }

    return undefined;
}

grapple_mantle_victim( var_0, var_1 )
{
    self notify( "grapple_mantle_victim" );
    self endon( "grapple_mantle_victim" );

    if ( !isdefined( self.animname ) )
        self.animname = "generic";

    childthread grapple_mantle_victim_ignore_thread( var_1 );
    self endon( "death" );
    var_2 = "";

    if ( var_1.grapple["mantle"]["over"] )
        var_3 = "land_mantle_kill_over";
    else
        var_3 = "land_mantle_kill_up";

    if ( common_scripts\utility::cointoss() )
        var_2 = "_2";

    var_3 += var_2;

    if ( isdefined( self.grapple_death_rig ) )
        self.grapple_death_rig delete();

    self.grapple_death_rig = common_scripts\utility::spawn_tag_origin();
    self.grapple_death_rig thread grapple_mantle_victim_rig_cleanup( self );
    self.grapple_death_rig.origin = var_1.grapple["mantle"]["position"];
    self.grapple_death_rig.angles = var_1.grapple["model_player_to"].angles;
    self.grapple_death_rig _meth_8092();
    var_1.grapple_victim_landanim = var_3;
    self.grapple_death_rig thread maps\_anim::anim_reach_solo( self, var_3 );
    self waittill( "grapple_landing_anim" );
    animscripts\shared::dropallaiweapons();

    if ( var_3 == "land_mantle_kill_up" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "grapple_mantle_kill_throw" );
        thread aud_fall_scream();
    }
    else
        soundscripts\_snd_playsound::snd_play_2d( "grapple_mantle_kill_kick" );

    self.grapple_death_rig maps\_anim::anim_single_solo( self, var_3 );
}

aud_fall_scream()
{
    wait 2;
    soundscripts\_snd_playsound::snd_play_2d( "grapple_kill_falling_scream" );
}

grapple_mantle_victim_rig_cleanup( var_0 )
{
    self notify( "grapple_mantle_victim_rig_cleanup" );
    self endon( "grapple_mantle_victim_rig_cleanup" );
    var_0 waittill( "death" );

    if ( isdefined( self ) )
        self delete();
}

grapple_mantle_victim_ignore_thread( var_0 )
{
    grapple_ai_prep_for_kill( 0 );
    var_0 waittill( "grapple_abort" );

    if ( isdefined( self ) )
    {
        maps\_utility::ai_unignore_everything();
        self notify( "grapple_mantle_victim" );
    }
}

grapple_trace_parms()
{
    var_0 = [];
    var_0["dist"] = self.grapple["dist_max"];
    var_0["angles"] = self getangles();
    var_0["start"] = self _meth_80A8();

    if ( self.grapple["magnet_current"].valid )
    {
        var_1 = self.grapple["magnet_current"].origin;
        var_0["angles"] = vectortoangles( var_1 - self _meth_80A8() );
    }
    else if ( self.grapple["quick_fire_up"] && isdefined( self.grapple["quick_fire_trace"] ) && self.grapple["quick_fire_trace"]["fraction"] < 1.0 )
    {
        var_1 = self.grapple["quick_fire_trace"]["position"];

        if ( isdefined( self.grapple["quick_fire_trace"]["entity"] ) )
        {
            var_2 = self.grapple["quick_fire_trace"]["entity"];
            var_1 = self.grapple["quick_fire_trace"]["local_position"];
            var_1 = rotatevector( var_1, var_2.angles );
            var_1 = var_2.origin + var_1;
        }

        var_0["angles"] = vectortoangles( var_1 - self _meth_80A8() );
    }

    var_0["forward"] = anglestoforward( var_0["angles"] );
    var_0["right"] = vectorcross( var_0["forward"], ( 0, 0, 1 ) );
    var_0["end"] = var_0["start"] + var_0["forward"] * var_0["dist"];
    return var_0;
}

grapple_magnets_dynamic( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 0;
    var_6 = self.grapple["magnet_test"];
    var_7 = [];

    foreach ( var_24, var_9 in level.grapple_magnets )
    {
        if ( !isdefined( var_9 ) )
        {
            var_5 = 1;
            continue;
        }

        if ( !isdefined( var_9.object ) )
        {
            var_5 = 1;
            continue;
        }

        var_10 = grapple_magnet_origin( var_9 );

        if ( !grapple_valid_magnet_angle( var_6, var_9, var_10, var_0 ) )
            continue;

        if ( isdefined( var_9.next ) )
        {
            if ( !getdvarint( "grapple_magnet_lines" ) )
                continue;

            var_11 = grapple_magnet_origin( var_9.next );
            var_12 = ( var_0[0], var_0[1], var_10[2] );
            var_13 = var_0 + var_1 * var_2;
            var_13 = ( var_13[0], var_13[1], var_10[2] );
            var_14 = 0;
            var_15 = distance( var_10, var_11 );

            if ( var_15 > 0 )
                var_14 = min( 0.5, 16.0 / var_15 );

            var_16 = _func_293( var_10, var_11, var_12, var_13 );
            var_10 = vectorlerp( var_10, var_11, clamp( var_16[0], var_14, 1.0 - var_14 ) );
        }

        var_17 = var_3;
        var_18 = 0;

        if ( var_9.is_ai )
        {
            var_19 = "";

            if ( isdefined( var_9.specialstruct ) && isdefined( var_9.specialstruct.type ) )
                var_19 = var_9.specialstruct.type;

            if ( !issubstr( var_19, "callback" ) && !isdefined( grapple_death_style( var_9.object ) ) )
                var_17 = 2;
            else if ( self _meth_812B( var_9.object ) )
                var_18 = 1;
            else
            {
                var_20 = 300;
                var_21 = clamp( distance( var_10, var_0 ), 0, var_20 );
                var_22 = var_21 / var_20;

                if ( isdefined( self.grapple["magnet_current"].magnet ) && self.grapple["magnet_current"].magnet == var_9 )
                    var_22 = 0;

                var_17 = var_3 + ( var_4 - var_3 ) * var_22;
            }
        }

        var_23 = grapple_magnet_state( var_6, var_10, var_0, var_1, var_2, var_17 );

        if ( var_23 || var_18 && var_6.dot >= 0 )
        {
            if ( var_18 )
            {
                var_6.dot = 1;
                var_6.possible = 1;
            }

            var_9.grapple_origin = var_10;
            var_7[var_7.size] = var_9;
        }
    }

    if ( var_5 )
    {
        var_25 = [];

        foreach ( var_9 in level.grapple_magnets )
        {
            if ( isdefined( var_9 ) && isdefined( var_9.object ) )
                var_25[var_25.size] = var_9;
        }

        level.grapple_magnets = var_25;
    }

    return var_7;
}

grapple_validate_magnets( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 grapple_magnet_validate_current( var_0 );
}

grapple_magnet_validate_current( var_0 )
{
    var_1 = self.grapple["magnet_current"];

    if ( isdefined( var_1 ) )
    {
        var_2 = 0;

        if ( isdefined( var_1.magnet ) && !isdefined( var_1.magnet.object ) )
            var_2 = 1;

        if ( isdefined( var_0 ) && isdefined( var_1.magnet ) && var_0 == var_1.magnet )
            var_2 = 1;

        if ( var_2 )
        {
            if ( var_1.valid )
                grapple_update_preview( 0, 0 );

            var_1.magnet = undefined;
            var_1.origin = undefined;
            var_1.valid = 0;
            return;
        }

        if ( !isdefined( var_0 ) )
        {
            var_3 = self _meth_80A8();
            var_4 = anglestoforward( self getangles() );
            var_5 = self.grapple["dist_max"];
            var_6 = getdvarfloat( "grapple_magnet_fov" );
            var_7 = cos( var_6 * 0.5 );

            if ( isdefined( var_1.magnet ) )
                var_1.origin = grapple_magnet_origin( var_1.magnet );

            grapple_magnet_state( var_1, var_1.origin, var_3, var_4, var_5, var_7 );

            if ( var_1.possible )
                grapple_magnet_trace_validate( var_1, var_1.origin, var_3, var_4 );
        }
    }
}

grapple_magnet_update()
{
    self.grapple["ai_targeted"] = undefined;

    if ( self.grapple["magnet_current"].valid && isdefined( self.grapple["magnet_current"].magnet ) && isai( self.grapple["magnet_current"].magnet.object ) )
        self.grapple["ai_targeted"] = self.grapple["magnet_current"].magnet.object;

    self.grapple["magnet_current"].valid = 0;

    if ( !getdvarint( "grapple_magnet_enabled" ) )
        return;

    var_0 = self _meth_80A8();
    var_1 = anglestoforward( self getangles() );
    var_2 = self.grapple["dist_max"];
    var_3 = getdvarfloat( "grapple_magnet_fov" );
    var_4 = cos( var_3 * 0.5 );
    var_5 = getdvarfloat( "grapple_magnet_fov_ai" );
    var_6 = cos( var_5 * 0.5 );
    var_7 = undefined;
    var_8 = grapple_magnets_dynamic( var_0, var_1, var_2, var_4, var_6 );

    foreach ( var_10 in var_8 )
        var_7 = grapple_magnet_evaluate( var_10, var_10.grapple_origin, var_0, var_1, var_7 );

    var_12 = _func_29A( var_0, var_1, var_2, var_3 );

    foreach ( var_14 in var_12 )
        var_7 = grapple_magnet_evaluate( undefined, var_14, var_0, var_1, var_7 );
}

grapple_magnet_evaluate( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = self.grapple["magnet_current"];
    var_6 = self.grapple["magnet_test"];
    var_6.magnet = var_0;
    grapple_magnet_state_basics( var_6, var_1, var_2, var_3 );
    var_7 = !var_5.valid;
    var_8 = var_5.dot;
    var_9 = var_6.dot;

    if ( !var_7 && isdefined( var_6.magnet ) && isai( var_6.magnet.object ) && self _meth_812B( var_6.magnet.object ) )
    {
        var_7 = 1;
        var_4 = var_6.magnet.object;
    }

    if ( isdefined( self.grapple["ai_targeted"] ) && self.grapple["ai_targeted"] grapple_ai_alive() )
    {
        if ( isdefined( var_6.magnet ) && isai( var_6.magnet.object ) && var_6.magnet.object == self.grapple["ai_targeted"] )
            var_9 = clamp( var_9 + getdvarfloat( "grapple_ai_priority" ), 0, max( var_9, 0.9999 ) );
        else if ( !isdefined( var_6.magnet ) || !isai( var_6.magnet.object ) )
            var_9 -= getdvarfloat( "grapple_ai_priority" );
    }

    if ( !grapple_magnet_validate_ground( var_0 ) )
    {
        var_9 = -1;
        var_7 = 0;
    }

    if ( !var_7 && var_9 > var_8 && ( !isdefined( var_4 ) || isdefined( var_6.magnet ) && isdefined( var_6.magnet.object ) && var_6.magnet.object == var_4 ) )
        var_7 = 1;

    if ( var_7 )
    {
        if ( grapple_magnet_trace_validate( var_6, var_1, var_2, var_3 ) || !self.grapple["magnet_current"].valid )
        {
            self.grapple["surface_trace"] = var_6.tracevalidation["surface_trace"];
            var_10 = var_5;
            self.grapple["magnet_current"] = var_6;
            self.grapple["magnet_test"] = var_10;
        }
    }

    return var_4;
}

grapple_magnet_origin( var_0 )
{
    if ( isdefined( var_0.static_origin ) )
        return var_0.static_origin;

    var_1 = var_0.object.origin;

    if ( var_0.tag != "" )
        var_1 = var_0.object gettagorigin( var_0.tag );

    if ( isdefined( var_0.tag_offset ) && lengthsquared( var_0.tag_offset ) > 0 )
    {
        if ( var_0.tag != "" )
            var_2 = rotatevector( var_0.tag_offset, var_0.object gettagangles( var_0.tag ) );
        else if ( isdefined( var_0.object.angles ) )
            var_2 = rotatevector( var_0.tag_offset, var_0.object.angles );
        else
            var_2 = var_0.tag_offset;

        var_1 += var_2;
    }

    return var_1;
}

grapple_magnet_state_basics( var_0, var_1, var_2, var_3 )
{
    var_0.origin = var_1;

    if ( isdefined( var_0.origin ) )
    {
        var_4 = var_0.origin - var_2;
        var_0.dot = vectordot( vectornormalize( var_4 ), var_3 );

        if ( isdefined( level.grapple_void_points ) && level.grapple_void_points.size > 0 )
        {
            var_5 = gettime();
            var_6 = 0;

            foreach ( var_8 in level.grapple_void_points )
            {
                if ( var_8.endtime > var_5 )
                {
                    var_6 = 1;

                    if ( distancesquared( var_0.origin, var_8.origin ) <= var_8.radiussq )
                    {
                        var_0.dot = -1;
                        break;
                    }
                }
            }

            if ( !var_6 )
            {
                level.grapple_void_points = [];
                return;
            }

            return;
        }
    }
    else
        var_0.dot = -1;
}

grapple_magnet_state( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    grapple_magnet_state_basics( var_0, var_1, var_2, var_3 );
    var_0.valid = 0;
    var_0.possible = 0;
    var_0.tracevalidation = [];
    var_0.tracevalidation["reason"] = "";

    if ( !grapple_valid_magnet_angle( var_0, var_0.magnet, var_0.origin, var_2 ) )
        return var_0.possible;

    if ( isdefined( var_0.origin ) )
    {
        var_6 = var_0.origin - var_2;

        if ( lengthsquared( var_6 ) <= var_4 * var_4 )
        {
            if ( var_0.dot >= var_5 )
                var_0.possible = 1;
        }
    }

    if ( !var_0.possible )
        var_0.dot = -1;

    return var_0.possible;
}

grapple_valid_magnet_angle( var_0, var_1, var_2, var_3 )
{
    var_0.anglevalid = 1;

    if ( !isdefined( var_1 ) )
        return 1;

    if ( isdefined( var_1.specialstruct ) && isdefined( var_1.tag ) && ( isdefined( var_1.specialstruct.dotlimitmin ) || isdefined( var_1.specialstruct.dotlimitmax ) ) )
    {
        if ( !isdefined( var_2 ) || !isdefined( var_1.object ) )
            return 0;

        var_4 = ( 1, 0, 0 );

        if ( isdefined( var_1.specialstruct.dotlimittagfwd ) )
            var_4 = var_1.specialstruct.dotlimittagfwd;

        var_5 = rotatevector( var_4, var_1.object gettagangles( var_1.tag ) );
        var_6 = vectornormalize( var_2 - var_3 );
        var_7 = vectordot( var_6, var_5 );

        if ( isdefined( var_1.specialstruct.dotlimitmin ) && var_7 < var_1.specialstruct.dotlimitmin )
        {
            var_0.anglevalid = 0;
            return 0;
        }

        if ( isdefined( var_1.specialstruct.dotlimitmax ) && var_7 > var_1.specialstruct.dotlimitmax )
        {
            var_0.anglevalid = 0;
            return 0;
        }
    }

    return 1;
}

grapple_magnet_trace_validate( var_0, var_1, var_2, var_3 )
{
    var_0.valid = 0;
    var_4 = 2;
    var_5 = var_4 * 2 * ( var_4 * 2 );
    var_6 = var_2;
    var_7 = var_1;
    var_8 = vectornormalize( var_7 - var_6 );
    var_7 += var_8 * var_4;

    if ( isdefined( var_0.magnet ) && isai( var_0.magnet.object ) )
    {
        if ( !isdefined( grapple_entity_style( var_0.magnet.object, var_0.magnet ) ) )
        {
            var_0.valid = 0;
            return var_0.valid;
        }
    }

    if ( isdefined( var_0.magnet ) && isdefined( var_0.magnet.specialstruct ) && isdefined( var_0.magnet.specialstruct.ignorecollision ) && var_0.magnet.specialstruct.ignorecollision )
    {
        var_9 = [];
        var_9["fraction"] = 0.99999;
        var_9["position"] = var_1;
        var_9["normal"] = var_8 * -1;
        var_9["entity"] = var_0.magnet.object;
        var_9["valid"] = 1;
    }
    else
    {
        var_10 = 0;

        if ( isdefined( var_0.magnet ) && isdefined( var_0.magnet.object ) && var_0.magnet.tag != "" )
            var_10 = 1;

        var_9 = _func_291( var_6, var_7, self, 0, var_10 );
    }

    if ( var_9["fraction"] < 1 )
    {
        if ( isdefined( var_9["entity"] ) && isdefined( var_9["entity"].grapple_magnets ) )
        {
            if ( isdefined( var_0.magnet ) && isdefined( var_0.magnet.object ) && var_0.magnet.object != var_9["entity"] )
                return var_0.valid;
        }

        if ( isai( var_9["entity"] ) || distancesquared( var_9["position"], var_7 ) <= var_5 )
        {
            var_0.tracevalidation = grapple_trace_validate( var_9, distance( var_6, var_7 ), var_8, vectortoangles( var_8 ), var_0 );
            var_0.valid = var_0.tracevalidation["allowed"];

            if ( var_0.valid )
                var_0.tracevalidation["surface_trace"]["valid"] = 1;
        }
        else
        {

        }
    }
    else
    {

    }

    return var_0.valid;
}

grapple_check_footing( var_0 )
{
    var_1 = var_0["surface_trace"]["entity"];

    if ( isdefined( var_1 ) && isdefined( var_1.grapple_magnets ) && var_1.grapple_magnets.size > 0 && !isdefined( var_0["land_magnet"] ) )
        return 0;

    return 1;
}

grapple_check_surface_type( var_0, var_1 )
{
    if ( var_0["fraction"] >= 1.0 )
        return 0;

    if ( !isdefined( var_0["valid"] ) || var_0["valid"] == 0 )
        return 0;

    if ( isdefined( var_0["entity"] ) && isai( var_0["entity"] ) )
    {
        if ( isdefined( var_1 ) && isdefined( var_1.magnet ) && isdefined( var_1.magnet.specialstruct ) && issubstr( var_1.magnet.specialstruct.type, "callback" ) )
            return 1;

        if ( isdefined( var_1 ) && isdefined( var_1.magnet ) && isai( var_1.magnet.object ) && var_1.magnet.object == var_0["entity"] )
            return 1;

        return 0;
    }

    if ( isdefined( var_0["entity"] ) && common_scripts\utility::string_find( var_0["entity"].classname, "drone" ) != -1 )
        return 0;

    return 1;
}

grapple_break_glass()
{
    var_0 = grapple_trace_parms();
    _func_291( var_0["start"], var_0["end"], self, 1 );
}

grapple_death_listener()
{
    self notify( "grapple_death_listener" );
    self endon( "grapple_death_listener" );
    self endon( "grapple_shutdown_player" );
    self waittill( "death" );

    if ( isdefined( self.grapple ) )
    {
        if ( isdefined( self.grapple["model_hands"] ) )
            self.grapple["model_hands"] hide();

        if ( isdefined( self.grapple["model_body"] ) )
            self.grapple["model_body"] hide();
    }
}

grapple_projectile_listener()
{
    self endon( "grapple_shutdown_player" );

    for (;;)
    {
        self waittill( "missile_fire", var_0 );

        if ( self _meth_8311() == self.grapple["weapon"] )
            var_0 delete();
    }
}

grapple_start_listener()
{
    self endon( "grapple_shutdown_player" );

    for (;;)
    {
        var_0 = common_scripts\utility::waittill_any_return( "grapple_quick" );

        if ( !isdefined( var_0 ) )
            continue;

        grapple_start( var_0 );
    }
}

grapple_notify_magnet()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) )
    {
        if ( isdefined( var_0.land_magnet.notifyname ) && var_0.land_magnet.notifyname != "" )
        {
            var_1 = var_0.land_magnet.object;

            if ( isdefined( var_0.land_entity ) )
                var_0.land_entity notify( var_0.land_magnet.notifyname, self );

            self notify( var_0.land_magnet.notifyname, var_0.land_entity, var_1 );
        }
    }
}

grapple_start( var_0 )
{
    self.grapple["landing_view_anim"] = undefined;
    self.grapple["no_enable_weapon"] = 0;
    self.grapple["no_disable_invulnerability"] = 0;
    self.grapple["start_stance"] = self _meth_817C();
    var_1 = self.grapple["model_player_to"];

    if ( !grapple_enabled() || self.grapple["ready_time"] > gettime() || !isdefined( self.grapple["surface_trace"] ) || !grapple_magnet_validate_ground( var_1.land_magnet ) )
    {
        if ( var_0 == "grapple_quick" )
            grapple_quick_fire_switch_back( 0 );

        return;
    }

    self notify( "grapple_started", var_1.land_magnet );

    if ( grapple_special() == "callback" )
    {
        [[ var_1.land_magnet.specialstruct.callback ]]( self, var_1.land_entity, var_1.land_magnet );
        thread grapple_enabled_listener();
        return;
    }

    self.grapple["grappled_count"]++;
    var_2 = grapple_entity_style( self.grapple["surface_trace"]["entity"], self.grapple["magnet_current"].magnet );

    if ( !isdefined( var_2 ) && isai( self.grapple["surface_trace"]["entity"] ) )
        self.grapple["allowed"] = 0;

    if ( self.grapple["allowed"] )
        thread grapple_break_glass();

    self _meth_80EF();

    if ( self.grapple["allowed"] && isdefined( var_2 ) )
    {
        if ( var_0 == "grapple_quick" )
            self.grapple["quick_fire_executed"] = 1;

        grapple_entity( self.grapple["surface_trace"]["entity"] );

        if ( var_0 == "grapple_quick" )
            grapple_quick_fire_switch_back( 0 );

        if ( !self.grapple["no_disable_invulnerability"] )
            self _meth_80F0();

        return;
    }
    else if ( !self.grapple["allowed"] )
    {
        thread grapple_status_text_show( 1000, "reason", 0, 90 );

        if ( var_0 == "grapple_quick" )
            grapple_quick_fire_switch_back( 0 );

        thread grapple_enabled_listener();

        if ( !self.grapple["no_disable_invulnerability"] )
            self _meth_80F0();

        return;
    }

    if ( var_0 == "grapple_quick" )
        self.grapple["quick_fire_executed"] = 1;

    grapple_set_hint( "" );
    grapple_set_status( "" );
    self.grapple["allowed"] = 0;
    self.grapple["connected"] = 0;
    grapple_enable_normal_mantle_hint( 0 );
    var_3 = self.grapple["model_attach_world"];
    var_3 _meth_804F();

    if ( isdefined( self.grapple["mantle"] ) )
    {
        if ( isdefined( self.grapple["mantle"]["victim"] ) )
            self.grapple["mantle"]["victim"] thread grapple_mantle_victim( self.grapple["mantle"], self );
    }

    self.grapple["no_enable_weapon"] = grapple_special_no_enable_weapon();

    if ( grapple_special_no_enable_exo() )
        self.grapple["no_enable_exo"] = grapple_special_no_enable_exo();

    var_4 = grapple_to_position( var_1 );

    if ( isdefined( var_4 ) && var_4 )
    {
        self.grapple["connected"] = 1;
        thread grapple_sync_attach_rotation();

        if ( isdefined( var_1.land_entity ) )
        {
            var_5 = self.grapple["model_player_move_tag"];
            var_6 = self.grapple["model_player_from"];
            var_5 _meth_804F();
            var_5.origin = self.origin;
            var_5.angles = ( 0, self.angles[1], 0 );
            var_5 _meth_804D( var_6 );
        }
    }

    self notify( "grapple_finished", var_1.land_entity );

    if ( !self.grapple["aborted"] )
        grapple_notify_magnet();

    wait 0.25;
    grapple_enable_weapon();

    if ( isdefined( self.grapple["quick_fire_executed"] ) && self.grapple["quick_fire_executed"] )
    {
        if ( self _meth_8336() || self ismantling() )
            grapple_quick_fire_switch_back( 1 );
        else
            grapple_quick_fire_switch_back( 0 );
    }
    else if ( !isdefined( self.grapple["mantle"] ) )
        self _meth_80F3( self _meth_8311(), "raise" );

    wait 0.25;
    grapple_set_grappling( 0 );
    grapple_enable_normal_mantle_hint( 1 );

    if ( !self.grapple["connected"] )
        grapple_rope_state( 0 );

    thread grapple_enabled_listener();

    if ( !self.grapple["no_disable_invulnerability"] )
        self _meth_80F0();
}

grapple_death_style( var_0 )
{
    var_1 = self _meth_80A8();
    var_2 = clamp( var_1[2], var_0.origin[2] + 30, var_0 _meth_80A8()[2] );
    var_3 = ( var_0.origin[0], var_0.origin[1], var_2 );
    var_4 = vectornormalize( var_3 - var_1 );
    var_5 = undefined;

    if ( isdefined( var_0.grapple_death_styles ) )
    {
        foreach ( var_7 in var_0.grapple_death_styles )
        {
            var_8 = rotatevector( var_7.normal, var_0.angles );
            var_9 = vectordot( var_4, var_8 );

            if ( var_9 >= var_7.dot )
            {
                if ( !isdefined( var_7.validator ) || self [[ var_7.validator ]]( var_0 ) )
                    return var_7;
            }
        }
    }

    return var_5;
}

grapple_ai_death_play( var_0, var_1 )
{
    var_2 = var_0 grapple_death_style( var_1 );

    if ( isdefined( var_2 ) && isdefined( var_2.handler ) )
    {
        if ( !isdefined( var_1.animname ) )
            var_1.animname = "generic";

        if ( isdefined( var_2.handler_parm3 ) )
            var_0 [[ var_2.handler ]]( var_2, var_0, var_1, var_2.handler_parm1, var_2.handler_parm2, var_2.handler_parm3 );
        else if ( isdefined( var_2.handler_parm2 ) )
            var_0 [[ var_2.handler ]]( var_2, var_0, var_1, var_2.handler_parm1, var_2.handler_parm2 );
        else if ( isdefined( var_2.handler_parm1 ) )
            var_0 [[ var_2.handler ]]( var_2, var_0, var_1, var_2.handler_parm1 );
        else
            var_0 [[ var_2.handler ]]( var_2, var_0, var_1 );
    }
}

grapple_ai_alive()
{
    return isalive( self ) && !maps\_utility::doinglongdeath();
}

grapple_kill( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !var_0 grapple_ai_alive() )
        return;

    maps\_upgrade_challenge::give_player_challenge_kill( 1 );
    var_0 _meth_804F();
    var_0 notify( "tagged_death" );

    while ( isdefined( var_0.grapple_magnets ) && var_0.grapple_magnets.size > 0 )
        grapple_magnet_unregister( var_0, var_0.grapple_magnets[0].tag );

    var_0.diequietly = 1;
    var_0.allowdeath = 1;

    if ( !var_1 )
        var_0.a.nodeath = 1;

    if ( isdefined( self.ent_flag["_stealth_in_shadow"] ) && self.ent_flag["_stealth_in_shadow"] )
        var_0.target = "ignore_corpse";

    var_0.dodamagetoall = 1;

    if ( !var_1 && !isdefined( var_0.grapple_ragdolled ) )
    {
        var_0 _meth_8023();
        var_0.grapple_ragdolled = 1;
    }

    grapple_kills_increment();
    var_0 _meth_8052( var_0.origin, var_0, var_0 );
}

grapple_kills_increment()
{
    if ( !isdefined( level.grapple_kill_count ) )
        level.grapple_kill_count = 0;

    level.grapple_kill_count += 1;

    if ( getdvar( "mapname" ) == "irons_estate" && level.grapple_kill_count >= 20 )
        maps\_utility::player_giveachievement_wrapper( "LEVEL_8A" );
}

grapple_death_valid_standard( var_0 )
{
    if ( !isplayer( self ) )
        return 0;

    if ( !self _meth_8341() && !self _meth_8068() )
        return 0;

    return 1;
}

grapple_death_handler_standard( var_0, var_1, var_2 )
{
    grapple_fire_rope( "grapple_death" );
    var_2 grapple_ai_prep_for_kill();
    var_2 soundscripts\_snd_playsound::snd_play_linked( common_scripts\utility::random( level.grapple_snd_pain ) );
    grapple_notify_closest_ai( "witness_kill", var_2 _meth_80A8(), 300, 1 );
    var_3 = anglestoforward( var_1 getangles() );
    var_4 = ( var_0.normal[0], var_0.normal[1], 0 );

    if ( length2dsquared( var_4 ) > 0 )
    {
        var_5 = ( var_3[0], var_3[1], 0 );
        var_6 = vectortoangles( _func_24D( var_5, vectortoangles( var_4 ) ) );
        var_2 _meth_81C6( var_2.origin, var_6 );
    }

    var_2 maps\_utility::set_deathanim( var_0.name );
    var_1 grapple_kill( var_2, 1 );
    var_1 waittill( "grapple_fire_rope_finished" );

    if ( common_scripts\utility::issp() )
        soundscripts\_snd_playsound::snd_play_2d( common_scripts\utility::random( level.grapple_snd_death ) );
    else
        var_2 soundscripts\_snd_playsound::snd_play_linked( common_scripts\utility::random( level.grapple_snd_death ) );

    var_1 thread maps\_utility::play_sound_on_entity( "rappel_clipout" );
    var_1 _meth_80AD( "heavygun_fire" );
    var_1 _meth_83FE( 5.0, 5.0, 3.0, 0.5, 0, 0.25, 128, 3, 3, 3, 1 );
}

grapple_death_valid_pull_concealed_obs( var_0 )
{
    if ( !self.grapple["kill_obstructed_clear"] )
        return 0;

    return grapple_death_valid_pull_concealed( var_0 );
}

grapple_death_valid_pull_concealed( var_0 )
{
    if ( !grapple_death_valid_pull( var_0 ) )
        return 0;

    var_1 = distancesquared( self.origin, var_0.origin );
    var_2 = getdvarfloat( "grapple_concealed_kill_range" );

    if ( var_1 > var_2 * var_2 )
        return 0;

    var_3 = getdvarfloat( "grapple_concealed_kill_range_min" );

    if ( var_1 < var_3 * var_3 )
        return 0;

    if ( abs( self.origin[2] - var_0.origin[2] ) > getdvarfloat( "grapple_concealed_kill_range_z" ) )
        return 0;

    if ( getdvarint( "grapple_concealed_kill" ) == 1 && ( ( !isdefined( self.ent_flag["_stealth_in_shadow"] ) || !self.ent_flag["_stealth_in_shadow"] ) && !self.grapple["concealed"] ) )
        return 0;

    return 1;
}

grapple_death_valid_pull_obs( var_0 )
{
    if ( !self.grapple["kill_obstructed_clear"] )
        return 0;

    return grapple_death_valid_pull( var_0 );
}

grapple_can_stand()
{
    if ( !isdefined( self.grapple["last_stand_check"] ) || gettime() - self.grapple["last_stand_check"] >= 50 )
    {
        self.grapple["can_stand"] = distancesquared( playerphysicstrace( self.origin + ( 0, 0, 1 ), self.origin ), self.origin ) < 0.0001;
        self.grapple["last_stand_check"] = gettime();
    }

    return self.grapple["can_stand"];
}

grapple_death_valid_pull( var_0 )
{
    if ( getdvarint( "grapple_concealed_kill" ) == 0 )
        return 0;

    var_1 = distancesquared( self.origin, var_0.origin );
    var_2 = getdvarfloat( "grapple_concealed_kill_range_min" );

    if ( var_1 < var_2 * var_2 )
        return 0;

    if ( !isplayer( self ) )
        return 0;

    if ( self _meth_8068() )
        return 0;

    if ( !self _meth_8341() )
        return 0;

    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_1 > self.grapple["dist_max_kill"] * self.grapple["dist_max_kill"] )
        return 0;

    if ( !grapple_can_stand() )
        return 0;

    return 1;
}

grapple_ai_prep_for_kill( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 )
        animscripts\shared::dropallaiweapons();

    self notify( "death" );
    maps\_utility::ai_ignore_everything();
    maps\_utility::anim_stopanimscripted();
    self notify( "stop_animmode" );
    self notify( "stop_sound" );
    self _meth_80AC();
}

grapple_death_pull( var_0, var_1, var_2, var_3, var_4 )
{
    var_1.grapple["grappling"] = 1;
    var_5 = var_1.grapple["model_rope_fire"];
    var_6 = var_1.grapple["model_rope_idle"];
    var_7 = var_1.grapple["model_ai_link"];
    var_2 grapple_ai_prep_for_kill();
    var_1 grapple_stand_and_lock_stances();
    var_1 grapple_fire_rope( "grapple_pull_death_start" + var_3 );
    var_1 childthread grapple_death_pull_rope_state();
    var_2 soundscripts\_snd_playsound::snd_play_linked( "grapple_kill_cloth" );
    var_1 soundscripts\_snd_playsound::snd_play_2d( "grapple_kill_pull", "stop_grapple_kill_pull_sound", undefined, 0.5 );
    var_1 soundscripts\_snd_playsound::snd_play_2d( "grapple_kill_pull_lyr2", "stop_grapple_kill_pull_sound", undefined, 0.1 );
    var_2 soundscripts\_snd_playsound::snd_play_linked( common_scripts\utility::random( level.grapple_snd_pain ) );

    if ( isdefined( level._stealth ) )
    {
        var_1 grapple_notify_closest_ai( "witness_kill", var_2 _meth_80A8(), 300, 1 );
        var_1 grapple_notify_ai_capsule( "gunshot_teammate", level.player _meth_80A8(), var_2 _meth_80A8(), 100, 1 );
    }

    var_2 notify( "tagged_death" );

    if ( isdefined( var_4 ) && var_4 != "" )
    {
        var_8 = anglestoforward( var_1 getangles() );
        var_9 = ( var_0.normal[0], var_0.normal[1], 0 );

        if ( length2dsquared( var_9 ) > 0 )
        {
            var_10 = ( var_8[0], var_8[1], 0 );
            var_11 = vectortoangles( _func_24D( var_10, vectortoangles( var_9 ) ) );
            var_2 _meth_81C6( var_2.origin, var_11 );
        }

        var_2 thread maps\_anim::anim_single_solo( var_2, var_4 );
    }
    else
    {
        var_4 = "grapple_pull_death_start" + var_3;
        var_2 thread maps\_anim::anim_single_solo( var_2, var_4 );
    }

    var_1 childthread grapple_view_model_hands_hide_show( "grapple_fire_rope_finished" );
    var_2 thread _waittillmatch_notify( "single anim", "pull", "pull" );
    var_12 = var_2 common_scripts\utility::waittill_any_timeout( getanimlength( level.scr_anim["generic"][var_4] ), "pull" );
    var_1 grapple_rope_state( 1 );
    var_2 soundscripts\_snd_playsound::snd_play_linked( "ie_as1_quietyank1" );
    var_1 _meth_80AD( "heavygun_fire" );
    var_1 _meth_83FE( 5.0, 5.0, 3.0, 0.5, 0, 0.25, 128, 3, 3, 3, 1 );
    var_13 = self.grapple["model_body"];
    var_13 _meth_804F();
    var_13 hide();
    var_13.origin = var_1.origin;
    var_13.angles = var_1.angles;
    var_13 _meth_8092();
    var_13.end_anim_name = "grapple_pull_death_end" + var_3;
    var_14 = common_scripts\utility::random( level.grapple_death_pull_suffixes );
    var_13.end_anim_name += var_14;
    var_13 maps\_anim::anim_first_frame_solo( var_13, var_13.end_anim_name );
    var_15 = getstartorigin( level.player.origin, level.player.angles, level.scr_anim["generic"][var_13.end_anim_name] );
    var_16 = getstartangles( level.player.origin, level.player.angles, level.scr_anim["generic"][var_13.end_anim_name] );
    var_2.loopanims = [];
    var_2.loops = 0;
    var_2 thread maps\_anim::anim_loop_solo( var_2, "grapple_pull_death_loop" + var_3 );
    var_7 _meth_804F();
    var_7.origin = var_2 gettagorigin( "tag_origin" );
    var_7.angles = var_2 gettagangles( "tag_origin" );
    var_2 _meth_804D( var_7 );
    var_17 = getdvarfloat( "grapple_pull_speed" );
    var_18 = distance( var_15, var_2.origin );
    var_19 = var_18 / var_17;
    var_1 _meth_80AE( "subtle_tank_rumble" );

    if ( var_19 >= 0.1 )
        var_1 _meth_83FE( 2.0, 2.0, 1.0, var_19, 0, min( var_19 - 0.05, 0.25 ), 128, 3, 3, 3, 1 );

    var_7 childthread grapple_rope_pull_lerp( var_15, var_19 );
    var_20 = min( 0.1, var_19 );
    var_7 _meth_82B5( var_16, var_20, min( var_20, 0.05 ), 0 );
    var_21 = 0.2;
    var_22 = var_19 - var_21;

    if ( var_22 > 0 )
        wait(var_22);
    else
        var_21 = max( 0, var_21 + var_22 );

    var_1 notify( "grapple_loop_viewmodel_anim" );
    var_1 thread maps\_utility::play_sound_on_entity( "rappel_clipout" );
    var_1 grapple_switch( 0, 1 );
    var_1 _meth_83FE( 5.0, 5.0, 3.0, 0.5, 0, 0.25, 128, 3, 3, 3, 1 );
    var_1 _meth_8080( var_13, "tag_player", var_21 );

    if ( var_21 > 0 )
        wait(var_21);

    var_1 _meth_80AF( "subtle_tank_rumble" );
    var_1 _meth_80AD( "heavygun_fire" );
    var_2 _meth_804F();
    var_13 show();
    var_23 = [ var_2, var_13 ];
    var_24 = undefined;

    if ( isdefined( level.scr_anim["grapple_rope"][var_13.end_anim_name] ) )
    {
        var_24 = maps\_utility::spawn_anim_model( "grapple_rope" );
        var_1.grapple["model_rope_fire"] hide();
        var_1.grapple["model_rope_idle"] hide();
        var_23[var_23.size] = var_24;
    }
    else
    {
        var_13 attach( "vm_spydeco", "tag_weapon_left" );
        var_13.knife_attached = 1;
    }

    var_2.a.nodeath = 1;
    var_2.allowdeath = 1;
    var_13 thread maps\_anim::anim_single( var_23, var_13.end_anim_name );
    var_25 = getanimlength( level.scr_anim["generic"][var_13.end_anim_name] );
    var_13 grapple_setup_death_event_handlers( "single anim", var_1, var_2, var_25 );
    var_13 waittillmatch( "single anim", "end" );
    var_13 hide();

    if ( isdefined( var_24 ) )
        var_24 delete();

    var_1 _meth_804F();
    var_1 grapple_unlock_stances();
    var_1 notify( "grapple_death_pull_complete" );
    var_1.grapple["grappling"] = 0;
}

grapple_death_pull_rope_state()
{
    if ( self.grapple["start_stance"] != "stand" )
        grapple_rope_state( 1 );
    else
        grapple_rope_state( 1, undefined, 1 );
}

grapple_rope_pull_lerp( var_0, var_1 )
{
    var_2 = gettime();
    var_3 = self.origin;
    var_4 = 0;

    while ( var_4 <= var_1 )
    {
        var_4 = float( gettime() - var_2 ) / 1000.0;
        var_5 = clamp( var_4 / var_1, 0.0, 1.0 );
        var_6 = clamp( var_5 * ( var_5 * 1.25 ), 0.0, 1.0 );
        var_7 = clamp( var_5 * ( var_5 * 1.0 ), 0.0, 1.0 );
        var_8 = vectorlerp( var_3, var_0, var_6 );
        var_9 = vectorlerp( var_3, var_0, var_7 );
        self.origin = ( var_8[0], var_8[1], var_9[2] );
        wait 0.05;
    }
}

grapple_setup_death_event_handlers( var_0, var_1, var_2, var_3 )
{
    self notify( "grapple_setup_death_event_handlers" );
    self endon( "grapple_setup_death_event_handlers" );
    childthread grapple_death_pull_event( var_0, var_1, var_2, var_3, "grab" );
    childthread grapple_death_pull_event( var_0, var_1, var_2, var_3, "impact" );
    childthread grapple_death_pull_event( var_0, var_1, var_2, var_3, "weapon_up" );
    childthread grapple_death_pull_event( var_0, var_1, var_2, var_3, "start_ragdoll" );
    childthread grapple_death_pull_event( var_0, var_1, var_2, var_3, "end" );
    childthread grapple_death_pull_event_sounds( var_0, "start_stab_neck_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_stab_neck_pull_sound", "grapple_kill_pull_end" );
    childthread grapple_death_pull_event_sounds( var_0, "stab_neck_kill_sound", "grapple_kill_stab_neck", 0.35 );
    childthread grapple_death_pull_event_sounds( var_0, "finish_stab_neck_sound" );
    childthread grapple_death_pull_event_sounds( var_0, "start_stab_neck_above_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_stab_neck_above_pull_sound", "grapple_kill_pull_end" );
    childthread grapple_death_pull_event_sounds( var_0, "stab_neck_above_kill_sound", "grapple_kill_stab_neck", 0.35 );
    childthread grapple_death_pull_event_sounds( var_0, "finish_stab_neck_above_sound" );
    childthread grapple_death_pull_event_sounds( var_0, "start_knife_chest_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_knife_chest_pull_sound", "grapple_kill_pull_end" );
    childthread grapple_death_pull_event_sounds( var_0, "knife_chest_kill_sound", "grapple_kill_knife_chest" );
    childthread grapple_death_pull_event_sounds( var_0, "finish_knife_chest_sound", "grapple_kill_body_drop", undefined, var_2 );
    childthread grapple_death_pull_event_sounds( var_0, "start_neck_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_neck_pull_sound", "grapple_kill_pull_end" );
    childthread grapple_death_pull_event_sounds( var_0, "neck_kill_sound", "grapple_kill_neck", 0.1 );
    childthread grapple_death_pull_event_sounds( var_0, "finish_neck_sound", "grapple_kill_body_drop", 1, var_2 );
    childthread grapple_death_pull_event_sounds( var_0, "start_above_knife_chest_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_above_knife_chest_pull_sound", "grapple_kill_pull_end" );
    childthread grapple_death_pull_event_sounds( var_0, "above_knife_chest_kill_sound", "grapple_kill_knife_chest" );
    childthread grapple_death_pull_event_sounds( var_0, "finish_above_knife_chest_sound", "grapple_kill_body_drop", 0.5, var_2 );
    childthread grapple_death_pull_event_sounds( var_0, "start_above_neck_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_above_neck_pull_sound", "grapple_kill_pull_end" );
    childthread grapple_death_pull_event_sounds( var_0, "above_neck_kill_sound", "grapple_kill_neck", 0.1 );
    childthread grapple_death_pull_event_sounds( var_0, "finish_above_neck_sound", "grapple_kill_body_drop", 1, var_2 );
    childthread grapple_death_pull_event_sounds( var_0, "start_choke_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_choke_pull_sound", "grapple_kill_pull_end", 0.05 );
    childthread grapple_death_pull_event_sounds( var_0, "choke_kill_sound", "grapple_kill_choke" );
    childthread grapple_death_pull_event_sounds( var_0, "finish_choke_sound", "grapple_kill_body_drop", 0.1, var_2 );
    childthread grapple_death_pull_event_sounds( var_0, "start_above_choke_sound", "grapple_kill_pull_whoosh" );
    childthread grapple_death_pull_event_sounds( var_0, "end_above_choke_pull_sound", "grapple_kill_pull_end", 0.05 );
    childthread grapple_death_pull_event_sounds( var_0, "above_choke_kill_sound", "grapple_kill_choke" );
    childthread grapple_death_pull_event_sounds( var_0, "finish_above_choke_sound", "grapple_kill_body_drop", 0.1, var_2 );
    childthread grapple_death_pull_event_sounds( var_0, "grapple_kill_low_start", "grapple_kill_low_start" );
    childthread grapple_death_pull_event_sounds( var_0, "grapple_kill_low_end" );
}

grapple_death_pull_event( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "grapple_death_pull_event_" + var_4 );
    self endon( "grapple_death_pull_event_" + var_4 );
    thread _waittillmatch_notify( var_0, var_4, var_4 );
    var_5 = common_scripts\utility::waittill_any_timeout( var_3, var_4 );
    var_1 notify( "death_pull_event", var_4 );
    var_6 = 0;

    if ( isdefined( var_1.grapple["mantle"] ) && isdefined( var_1.grapple["mantle"]["victim"] ) )
        var_6 = 1;

    switch ( var_4 )
    {
        case "grab":
            if ( !isdefined( self.end_anim_name ) || !isdefined( level.scr_anim["grapple_rope"][self.end_anim_name] ) )
                var_1 grapple_rope_state( 0 );

            var_1 _meth_80AD( "heavygun_fire" );
            break;
        case "impact":
            var_1 _meth_80AD( "heavygun_fire" );

            if ( isdefined( var_2 ) )
                var_2 soundscripts\_snd_playsound::snd_play_linked( common_scripts\utility::random( level.grapple_snd_death ) );

            break;
        case "weapon_up":
            var_1 grapple_enable_weapon();
            var_1 grapple_switch( 0, 1, 0 );

            if ( isdefined( self.knife_attached ) )
                self detach( "vm_spydeco", "tag_weapon_left" );

            self.knife_attached = undefined;
            break;
        case "start_ragdoll":
            if ( isdefined( var_2 ) )
            {
                var_2 _meth_804F();

                if ( !isdefined( var_2.grapple_ragdolled ) )
                {
                    var_2 _meth_8023();
                    var_2.grapple_ragdolled = 1;
                }

                if ( var_6 )
                    var_1 grapple_kill( var_2, 0 );
            }

            break;
        case "end":
            if ( isdefined( var_2 ) )
            {
                if ( !var_6 )
                {
                    var_2 maps\_utility::anim_stopanimscripted();
                    var_7 = self.origin + ( 0, 0, 30 );
                    var_8 = var_2 _meth_83E5( var_7, var_7 + anglestoforward( self.angles ) * -60 );
                    var_9 = var_2 _meth_83E5( var_8, var_8 - ( 0, 0, 60 ) );
                    var_2 _meth_804F();
                    var_2 _meth_81C6( ( var_9[0], var_9[1], var_9[2] + 30 ), var_2.angles, 1000 );
                }

                var_1 grapple_kill( var_2, 0 );
            }

            break;
    }
}

grapple_death_pull_event_sounds( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "grapple_death_pull_event_sounds" + var_1 );
    self endon( "grapple_death_pull_event_sounds" + var_1 );
    self waittillmatch( var_0, var_1 );

    if ( isdefined( var_3 ) )
        wait(var_3);

    if ( isdefined( var_2 ) )
    {
        if ( var_2 != "grapple_kill_body_drop" )
            soundscripts\_snd_playsound::snd_play_2d( var_2 );
        else
            var_4 soundscripts\_snd_playsound::snd_play_linked( var_2 );

        if ( var_2 == "grapple_kill_pull_whoosh" )
        {
            soundscripts\_snd::snd_message( "aud_grapple_kill_foliage" );

            if ( var_1 != "start_stab_neck_sound" && var_1 != "start_stab_neck_above_sound" )
            {
                level notify( "stop_grapple_kill_pull_sound" );
                soundscripts\_snd::snd_message( "aud_stealth_melee" );
            }
        }

        if ( var_1 == "finish_stab_neck_sound" || var_1 == "finish_stab_neck_sound" )
            soundscripts\_snd::snd_message( "aud_stealth_melee" );
    }
}

grapple_view_model_hands_hide_show( var_0 )
{
    if ( isdefined( var_0 ) )
        self waittill( var_0 );

    self _meth_8482();

    for (;;)
    {
        if ( self _meth_8311() != self.grapple["weapon"] )
        {
            self _meth_8481();
            return;
        }

        wait 0.05;
    }
}

_waittillmatch_notify( var_0, var_1, var_2 )
{
    self waittillmatch( var_0, var_1 );
    self notify( var_2 );
}

grapple_loop_viewmodel_anim( var_0, var_1 )
{
    self notify( "grapple_loop_viewmodel_anim" );
    self endon( "grapple_loop_viewmodel_anim" );
    self endon( "death" );

    for (;;)
    {
        self _meth_84B5( level.scr_viewanim[var_1] );
        var_2 = 0.0;

        if ( isarray( level.scr_anim[var_0][var_1] ) )
            var_2 = getanimlength( level.scr_anim[var_0][var_1][0] ) - 0.2;
        else
            var_2 = getanimlength( level.scr_anim[var_0][var_1] ) - 0.2;

        wait(var_2);
    }
}

grapple_entity( var_0 )
{
    self endon( "grapple_abort" );
    var_1 = grapple_entity_style( var_0, self.grapple["magnet_current"].magnet );

    if ( isdefined( var_1 ) )
    {
        self notify( "grapple_started" );
        self.grapple["allowed"] = 0;
        grapple_notify_magnet();
        grapple_set_hint( "" );
        grapple_set_status( "" );
        grapple_update_preview( 0, 0 );

        if ( isai( var_0 ) )
            grapple_attach_bolt( var_0, "J_SpineUpper" );
        else
            grapple_attach_bolt( var_0, "tag_origin" );

        if ( grapple_special() == "callback_fired" )
        {
            grapple_fire_rope();
            self waittill( "grapple_rope_impact" );
            var_2 = self.grapple["model_player_to"];
            [[ var_2.land_magnet.specialstruct.callback ]]( self, var_2.land_entity, var_2.land_magnet );
            thread grapple_enabled_listener();
            return;
        }

        switch ( var_1 )
        {
            case "kill":
                var_0.isbeinggrappled = 1;
                grapple_ai_death_play( self, var_0 );
                break;
        }

        self.grapple["ready_time"] = max( gettime() + 600, self.grapple["ready_time"] );
        self notify( "grapple_entity_finished" );
        self freezecontrols( 0 );
        grapple_enable_weapon();
        grapple_rope_state( 0 );
        self.grapple["model_attach_world"] hide();

        if ( isdefined( self.grapple["quick_fire_executed"] ) && self.grapple["quick_fire_executed"] )
            grapple_quick_fire_switch_back( 1 );
        else if ( !isdefined( self.grapple["mantle"] ) )
            self _meth_80F3( self _meth_8311(), "raise" );

        thread grapple_enabled_listener();
    }
}

grapple_entity_style( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        if ( isai( var_0 ) && var_0 grapple_ai_alive() )
        {
            if ( isdefined( var_1 ) && isdefined( var_1.specialstruct ) && issubstr( var_1.specialstruct.type, "callback" ) )
                return "callback";
            else if ( var_0.team != self.team && isdefined( grapple_death_style( var_0 ) ) )
                return "kill";
        }
    }

    return undefined;
}

grapple_take_weapon()
{
    self _meth_8499();
    self _meth_830F( self.grapple["weapon"] );
}

grapple_disconnect()
{
    self notify( "grapple_disconnect" );
    grapple_set_hint( "" );
    grapple_rope_state( 0 );
    thread maps\_utility::play_sound_on_entity( "rappel_clipout" );
    self _meth_80AF( "subtle_tank_rumble" );
    grapple_take_weapon();
    self freezecontrols( 0 );
    grapple_unlock_stances();
}

grapple_sync_attach_rotation()
{
    self endon( "death" );
    self endon( "grapple_shutdown_player" );
    self endon( "grapple_disconnect" );
    self endon( "grapple_started" );
    self notify( "grapple_sync_attach_rotation" );
    self endon( "grapple_sync_attach_rotation" );
    var_0 = self.grapple["model_player_move_tag"];
    var_1 = self.grapple["model_player_from"];

    for (;;)
    {
        var_0 _meth_804F();
        var_0.angles = ( 0, self.angles[1], 0 );
        var_0 _meth_804D( var_1 );
        wait 0.05;
    }
}

grapple_get_style( var_0, var_1 )
{
    var_2 = vectordot( var_1, ( 0, 0, 1 ) );

    if ( var_2 > cos( 45 ) )
        return "floor";
    else if ( var_2 < 0 - cos( 45 ) )
        return "ceiling";
    else
        return "wall";
}

grapple_wait_for_ads_timeout( var_0 )
{
    var_1 = gettime();

    while ( gettime() - var_1 < var_0 * 1000 )
    {
        if ( self adsbuttonpressed() )
            return;

        wait 0.05;
    }
}

grapple_velocity_monitor()
{
    self notify( "grapple_velocity_monitor" );
    self endon( "death" );
    self endon( "grapple_shutdown_player" );
    self endon( "grapple_velocity_monitor" );
    var_0 = self.origin;

    for (;;)
    {
        wait 0.05;
        self.grapple["poll_velocity"] = ( self.origin - var_0 ) * 20.0;
        var_0 = self.origin;
    }
}

grapple_abort_trace_passed( var_0 )
{
    var_1 = self _meth_80A8();
    var_2 = var_0 + ( 0, 0, var_1[2] - self.origin[2] );
    var_3 = vectornormalize( var_2 - var_1 );
    var_1 += var_3 * 30;
    var_2 -= var_3 * 30;
    var_4 = _func_291( var_1, var_2, self, 0 );

    if ( isdefined( var_4["fraction"] ) && var_4["fraction"] < 1.0 )
    {
        if ( isai( var_4["entity"] ) && var_4["entity"].team == self.team )
            return 1;

        return 0;
    }

    return 1;
}

grapple_abort_monitor( var_0, var_1 )
{
    self endon( "grapple_shutdown_player" );
    self notify( "grapple_abort_monitor" );
    self endon( "grapple_abort_monitor" );

    if ( grapple_special_no_abort() )
        return;

    var_2 = 0;
    var_3 = 0;
    self.grapple["abort_forced"] = 0;
    self.grapple["last_valid_origin"] = self.origin;

    while ( isdefined( self.grapple ) && self.grapple["grappling"] )
    {
        wait 0.05;
        var_4 = ( self.origin[0], self.origin[1], self.grapple["model_player_to"].origin[2] );

        if ( distancesquared( playerphysicstrace( var_4, self.origin ), self.origin ) < 0.0001 )
        {
            if ( distancesquared( playerphysicstrace( self.origin + ( 0, 0, 1 ), self.origin ), self.origin ) < 0.0001 )
                self.grapple["last_valid_origin"] = self.origin;
        }

        var_5 = 1;

        if ( self.grapple["abort_forced"] )
            var_5 = 0;
        else
            var_5 = grapple_abort_trace_passed( var_1.origin );

        if ( !var_5 )
            var_3 += 1;

        if ( !var_5 && ( var_2 || self.grapple["abort_forced"] || var_3 > 4 ) )
            grapple_abort( self.grapple["abort_forced"] );

        if ( var_5 && !var_2 )
            var_2 = 1;
    }
}

grapple_abort( var_0 )
{
    grapple_set_grappling( 0 );
    self.grapple["aborted"] = 1;
    self.grapple["no_enable_exo"] = 0;
    self.grapple["no_enable_weapon"] = 0;
    self notify( "grapple_abort" );
    grapple_disconnect();
    killfxontag( level._effect["grapple_cam"], self.grapple["model_player_to"], "tag_origin" );
    self _meth_804F();
    grapple_enable_normal_mantle_hint( 1 );
    var_1 = self.grapple["poll_velocity"];
    self setorigin( self.grapple["last_valid_origin"] );
    self.origin = self.grapple["last_valid_origin"];
    self _meth_82F1( var_1 );
    self _meth_83FE( 5.0, 5.0, 3.0, 0.5, 0, 0.25, 128, 3, 3, 3, 1 );
    self _meth_80AD( "damage_light" );
    self _meth_8031( 65, 0.2 );

    if ( common_scripts\utility::issp() )
        level notify( "stop_grapplesound" );
    else
        self.grapple["model_player_move_tag"] _meth_80AC();

    self _meth_80F0();
}

grapple_complete_player_move( var_0 )
{
    var_1 = self.grapple["model_player_from"];
    var_2 = self.grapple["model_player_to"];
    var_1 _meth_804F();
    var_1.origin = var_2.origin;
    var_1.angles = var_2.angles;
    var_1.style = var_2.style;
    var_1.land_entity = undefined;
    var_1.land_magnet = undefined;

    if ( isdefined( var_2.land_entity ) )
    {
        var_1.land_entity = var_2.land_entity;

        if ( isdefined( var_2.land_magnet ) && var_2.land_magnet.tag != "" )
            var_1 _meth_804D( var_2.land_entity, var_2.land_magnet.tag );
        else
            var_1 _meth_804D( var_2.land_entity );

        if ( isdefined( var_2.land_magnet ) )
            var_1.land_magnet = var_2.land_magnet;
    }

    var_1 _meth_8092();

    if ( !isdefined( self.grapple["mantle"] ) && !isdefined( grapple_special_landing_anims() ) )
    {
        self _meth_804F();
        self setorigin( var_2.origin );
        self _meth_807D( var_2, "tag_origin", 1.0, 45, 45, 45, 45, 0 );
    }

    grapple_enable_weapon();
    grapple_setup_rope_attached( var_0 );
    self notify( "grapple_complete_player_move" );
}

grapple_to_position( var_0 )
{
    self endon( "grapple_shutdown_player" );
    self endon( "grapple_abort" );
    var_1 = 0;
    grapple_set_grappling( 1 );
    self.grapple["aborted"] = 0;
    var_2 = self.grapple["model_player_move_tag"];
    var_3 = self.grapple["model_player_from"];
    var_0 = self.grapple["model_player_to"];
    grapple_update_preview( 0, 0 );
    grapple_attach_bolt( self.grapple["model_preview"] );
    thread grapple_velocity_monitor();

    if ( grapple_special() == "weapon" )
        grapple_fire_rope( "grapple_hip_fire", ::grapple_fire_finished );
    else
        grapple_fire_rope( undefined, ::grapple_fire_finished );

    thread grapple_abort_monitor( var_2, var_0 );
    grapple_stand_and_lock_stances();
    var_2 _meth_804F();
    var_2.angles = self getangles();
    var_2.origin = self _meth_80A8() - anglestoup( var_2.angles ) * 60;
    var_2 _meth_8092();
    self.grapple["landingParms"] = grapple_landing_prep();
    childthread grapple_lerp_velocity_to_linked( var_2 );
    self _meth_80AE( "subtle_tank_rumble" );

    if ( common_scripts\utility::issp() )
    {
        soundscripts\_snd_playsound::snd_play_2d( "linelauncher_move_player", "stop_grapplesound", undefined, 0.2 );
        soundscripts\_snd_playsound::snd_play_2d( "linelauncher_wind", "stop_grapplesound", undefined, 0.35 );
        level notify( "aud_grapple_start" );
        soundscripts\_snd::snd_message( "aud_grapple_from_foliage" );
    }
    else
        var_2 playsound( "linelauncher_move_player" );

    var_4 = var_2 grapple_move( self, var_0 );
    self _meth_80AF( "subtle_tank_rumble" );

    if ( self.grapple["style"] == "ceiling" )
    {
        var_1 = 1;
        wait(max( 0.05, var_4 ));
        grapple_complete_player_move( 1 );
        grapple_rope_state( 2 );
        self _meth_807D( var_3, "tag_origin", 1.0, 180, 180, 180, 180, 0 );
    }
    else if ( self.grapple["style"] == "wall" )
    {
        wait(max( 0.05, var_4 ) + 0.1);
        grapple_complete_player_move( 1 );

        if ( isdefined( self.grapple["mantle"] ) || isdefined( grapple_special_landing_anims() ) )
        {
            self _meth_8499();
            grapple_disconnect();
            self _meth_804F();
        }
        else
        {
            var_1 = 1;
            grapple_rope_state( 2 );
            self _meth_807D( var_3, "tag_origin", 1.0, 180, 180, 180, 180, 1 );
        }
    }
    else if ( self.grapple["style"] == "floor" )
    {
        wait(max( 0.05, var_4 ));
        grapple_complete_player_move();
        self _meth_804F();
        grapple_disconnect();
        var_1 = 0;
    }

    level notify( "stop_grapplesound" );

    if ( grapple_after_land_anim() )
    {
        var_5 = var_0.land_magnet;

        if ( !isdefined( var_5 ) || !isdefined( var_5.specialstruct ) || !isdefined( var_5.specialstruct.afterlandanimconnected ) || !var_5.specialstruct.afterlandanimconnected )
        {
            self _meth_804F();
            grapple_disconnect();
            var_1 = 0;
        }
        else
            self _meth_807D( var_3, undefined, 1.0, 180, 180, 180, 180, 0 );
    }

    return var_1;
}

grapple_lerp_velocity_to_linked( var_0 )
{
    self endon( "death" );
    self endon( "grapple_disconnect" );
    var_1 = grapple_move_time( self.grapple["model_player_to"] );
    var_2 = self.grapple["velocity_when_fired"];
    var_3 = length( var_2 );
    var_4 = self.grapple["model_player_move_lerp"];
    var_4 _meth_804F();
    var_4.origin = var_0.origin + var_2 * 0.05;
    var_4.angles = var_0.angles;
    var_4 _meth_8092();
    self _meth_807D( var_4, "tag_origin", 1.0, 0, 0, 0, 0, 0 );
    self.grapple["velocity_lerping"] = 0;

    if ( getdvarint( "grapple_lerp_velocity" ) && var_3 > 0 )
    {
        self endon( "grapple_velocity_lerp_end" );
        self.grapple["velocity_lerping"] = 1;
        var_5 = var_1;

        if ( var_5 > 0 )
        {
            var_6 = min( var_3 * 0.01, var_5 * 0.75 );
            var_4 grapple_decelerate_move_to( var_2, var_0.origin, var_0, undefined, var_5, var_6, 1, self.grapple["model_player_to"], ( 0, 0, 60 ) );
        }
    }

    var_4.origin = var_0.origin;
    var_4 _meth_804D( var_0 );
}

grapple_move_time( var_0 )
{
    var_1 = self.grapple["speed"];

    if ( !isdefined( var_1 ) )
        var_1 = 200;

    var_2 = distance( self.origin, var_0.origin );
    var_3 = var_2 / var_1;
    return var_3;
}

grapple_move( var_0, var_1 )
{
    self notify( "newmove" );
    self endon( "newmove" );
    var_0 endon( "death" );
    var_2 = var_0 grapple_move_time( var_1 );
    var_3 = vectornormalize( var_1.origin - self.origin );

    if ( var_0 grapple_special() == "weapon" )
    {
        var_0 grapple_with_weapon_start( var_1.land_magnet.specialstruct );
        var_2 *= 1.0 / var_1.land_magnet.specialstruct.movescale;
    }

    var_4 = var_2 * 0.9;
    var_5 = var_2 * 0.05;
    var_6 = gettime();
    self _meth_82AE( var_1.origin, var_2, var_4, var_5, var_1 );

    if ( var_0 grapple_special() == "weapon" )
        var_0 thread grapple_with_weapon_travel( var_1.land_magnet.specialstruct );

    if ( var_2 > 0.5 )
    {
        wait(var_2 * 0.2);
        playfxontag( level._effect["grapple_cam"], var_0.grapple["model_player_to"], "tag_origin" );
        grapple_motion_blur_enable();

        if ( var_0 grapple_special() != "weapon" )
            var_0 _meth_8031( 85, var_2 * 0.3 );
    }

    var_0 _meth_83FE( 1.5, 1.0, 1.0, var_2, var_2 * 0.8, 0, 128, 3, 1, 1 );
    var_7 = var_0.grapple["landingParms"];
    var_8 = 0;
    var_0 notify( "grapple_moving", var_0.grapple["magnet_current"].magnet );
    var_9 = 0;

    while ( !var_7["anim_started"] || !var_7["trans_started"] || !var_7["fov_lerp_started"] || var_9 > 0 )
    {
        var_8 = max( 0, var_2 - float( gettime() - var_6 ) / 1000.0 );

        if ( !var_7["anim_started"] && var_8 <= var_7["anim_time"] )
        {
            var_0 notify( "grapple_landing_started" );
            var_0 notify( "grapple_landing_anim_started" );
            var_9 = var_0 thread grapple_landing_anim( var_7 );
            var_7["anim_started"] = 1;
        }

        if ( !var_7["trans_started"] && var_8 <= var_7["trans_time"] )
        {
            var_0 notify( "grapple_landing_started" );
            var_0 notify( "grapple_landing_trans_started" );
            var_0 thread grapple_landing_trans( var_7, var_1 );
            var_7["trans_started"] = 1;
        }

        if ( !var_7["fov_lerp_started"] && var_8 <= var_7["fov_lerp_time"] )
        {
            var_0 notify( "grapple_landing_started" );
            var_0 notify( "grapple_landing_fov_started" );

            if ( var_0 grapple_special() != "weapon" )
                var_0 _meth_8031( 65, var_7["fov_lerp_time"] );

            var_7["fov_lerp_started"] = 1;
        }

        if ( !var_7["prep_start_started"] && var_8 <= var_7["prep_start_time"] )
        {
            var_0 notify( "grapple_prep_land" );
            var_0.grapple["landing_prep_started"] = 1;
            var_7["prep_start_started"] = 1;
        }

        var_9 -= 0.05;
        wait 0.05;
    }

    var_0 notify( "grapple_rig_hidden" );

    if ( isdefined( var_0.grapple["model_hands"] ) )
        var_0.grapple["model_hands"] hide();

    if ( isdefined( var_0.grapple["model_body"] ) )
        var_0.grapple["model_body"] hide();

    return max( 0, var_8 );
}

grapple_landing_prep()
{
    var_0 = self getangles();
    var_1 = anglestoforward( var_0 );
    var_2 = grapple_special_landing_anims();
    var_3 = "land_straight";
    var_4 = self.grapple["surface_trace"]["normal"] * -1;

    if ( self.grapple["style"] == "wall" )
    {
        var_5 = vectordot( var_1, var_4 );

        if ( var_5 < 0.87 )
        {
            var_6 = vectorcross( ( 0, 0, 1 ), var_4 );
            var_7 = vectordot( var_1, var_6 );

            if ( var_7 < 0 )
                var_3 = "land_left";
            else
                var_3 = "land_right";
        }
    }

    if ( isdefined( self.grapple["mantle"] ) )
    {
        if ( isdefined( self.grapple["mantle"]["victim"] ) && isdefined( self.grapple_victim_landanim ) )
            var_3 = self.grapple_victim_landanim;
        else if ( self.grapple["mantle"]["over"] )
            var_3 = "land_mantle_over";
        else
            var_3 = "land_mantle_up";
    }

    var_8 = [];
    var_9 = [];
    var_10 = [];
    var_11 = [];
    var_12 = [];
    var_13 = [];
    var_14 = [];
    var_15 = [];
    var_8["hands"] = self.grapple["model_hands"];
    var_9["hands"] = grapple_anim_tree( "grapple_hands" );

    if ( isdefined( var_2 ) )
    {
        var_10["hands"] = var_2[1];
        var_13["hands"] = getanimlength( var_2[1] );
    }
    else
    {
        var_10["hands"] = grapple_anim_anim( "grapple_hands", var_3 );
        var_13["hands"] = grapple_anim_length( "grapple_hands", var_3 );
    }

    var_14["hands"] = isdefined( var_10["hands"] );
    var_8["body"] = self.grapple["model_body"];
    var_9["body"] = grapple_anim_tree( "grapple_body" );

    if ( isdefined( var_2 ) )
    {
        var_10["body"] = var_2[0];
        var_13["body"] = getanimlength( var_2[0] );
    }
    else
    {
        var_10["body"] = grapple_anim_anim( "grapple_body", var_3 );
        var_13["body"] = grapple_anim_length( "grapple_body", var_3 );
    }

    var_14["body"] = isdefined( var_10["body"] );
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_14["hands"] = 0;
    var_14["body"] = 0;

    switch ( self.grapple["style"] )
    {
        case "ceiling":
            var_16 = var_13["hands"] * 0.5;
            var_17 = var_16;
            var_18 = var_13["hands"] * 0.75;
            var_14["hands"] = 1;
            break;
        case "wall":
            var_16 = var_13["hands"] * 0.5;
            var_17 = var_16;
            var_18 = var_13["hands"] * 0.75;
            break;
        default:
            var_16 = 0.2;
            var_17 = var_16;
            var_18 = 0;
            break;
    }

    if ( isdefined( self.grapple["mantle"] ) || isdefined( var_2 ) )
    {
        var_14["hands"] = 1;
        var_14["body"] = 0;
        var_19 = self.grapple["model_player_to"];

        if ( isdefined( var_2 ) )
        {
            if ( isdefined( var_19.land_magnet.tag ) && var_19.land_magnet.tag != "" )
            {
                var_11["body"] = var_19.land_magnet.object gettagorigin( var_19.land_magnet.tag );
                var_12["body"] = var_19.land_magnet.object gettagangles( var_19.land_magnet.tag );
            }
            else
            {
                var_11["body"] = var_19.land_magnet.object.origin;
                var_12["body"] = var_19.land_magnet.object.angles;
            }
        }
        else
        {
            var_11["body"] = self.grapple["mantle"]["position"] + ( 0, 0, 0.5 );
            var_12["body"] = ( 0, vectortoyaw( var_4 ), 0 );
        }

        if ( isdefined( var_11["body"] ) )
        {
            var_11["body"] = _func_24D( var_11["body"] - var_19.origin, var_19.angles );
            var_12["body"] -= var_19.angles;
        }

        var_20 = 0.33;
        var_16 = var_20;
        var_17 = var_20;
        var_18 = var_20;
    }

    if ( isdefined( var_10["hands"] ) && !self.grapple["linked_hands"] )
    {
        var_8["hands"] _meth_80A6( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
        self.grapple["linked_hands"] = 1;
    }

    if ( isdefined( var_8["hands"] ) && isdefined( var_10["hands"] ) && isdefined( var_9["hands"] ) )
    {
        var_8["hands"] _meth_8115( var_9["hands"] );
        var_8["hands"] _meth_814B( var_10["hands"], 1.0, 0.0, 0.0 );
        var_8["hands"] _meth_8117( var_10["hands"], 0.0 );
    }

    if ( isdefined( var_8["body"] ) && isdefined( var_10["body"] ) && isdefined( var_9["body"] ) )
    {
        var_8["body"] _meth_8115( var_9["body"] );
        var_8["body"] _meth_814B( var_10["body"], 1.0, 0.0, 0.0 );
        var_8["body"] _meth_8117( var_10["body"], 0.0 );
    }

    var_21 = [];
    var_21["anim_time"] = var_18;
    var_21["anim_name"] = var_3;
    var_21["anim_ents"] = var_8;
    var_21["anim_ents_tree"] = var_9;
    var_21["anim_ents_anim"] = var_10;
    var_21["anim_ents_view_anim"] = var_15;
    var_21["anim_ents_time"] = var_13;
    var_21["anim_ents_origin"] = var_11;
    var_21["anim_ents_angles"] = var_12;
    var_21["anim_ents_vis"] = var_14;
    var_21["anim_started"] = 0;
    var_21["trans_time"] = var_16;
    var_21["trans_duration"] = var_17;
    var_21["trans_started"] = 0;
    var_21["fov_lerp_time"] = max( var_16, var_18 ) * 1.25;
    var_21["fov_lerp_started"] = 0;
    var_21["prep_start_time"] = max( var_16, var_18 ) + 0.05;
    var_21["prep_start_started"] = 0;
    return var_21;
}

grapple_landing_anim( var_0 )
{
    var_1 = 0;
    var_2 = var_0["anim_ents"];
    var_3 = self.grapple["model_player_to"];

    if ( isdefined( self.grapple["mantle"] ) && isdefined( self.grapple["mantle"]["victim"] ) )
        self.grapple["mantle"]["victim"] notify( "grapple_landing_anim" );

    foreach ( var_11, var_5 in var_2 )
    {
        if ( !isdefined( var_5 ) )
            continue;

        var_6 = var_5.origin;
        var_7 = var_5.angles;

        if ( isdefined( var_0["anim_ents_origin"][var_11] ) )
        {
            var_8 = 0;
            var_5 _meth_804F();
            var_5.origin = var_3.origin + rotatevector( var_0["anim_ents_origin"][var_11], var_3.angles );
            var_6 = var_5.origin;

            if ( isdefined( var_0["anim_ents_angles"][var_11] ) )
            {
                var_5.angles = var_3.angles + var_0["anim_ents_angles"][var_11];
                var_7 = var_5.angles;
            }

            if ( isdefined( self.grapple["model_player_to"].land_entity ) )
                var_5 _meth_804D( self.grapple["model_player_to"].land_entity );

            var_1 = max( var_1, var_0["anim_ents_time"][var_11] );
        }

        if ( !var_0["anim_ents_vis"][var_11] )
            var_5 hide();
        else
        {
            var_5 show();
            var_5 thread grapple_delayed_hide( var_0["anim_ents_time"][var_11] );
        }

        if ( isdefined( var_0["anim_ents_view_anim"][var_11] ) )
        {
            self.grapple["landing_view_anim"] = var_0["anim_ents_view_anim"][var_11];
            self _meth_84B5( level.scr_viewanim[var_0["anim_ents_view_anim"][var_11]] );
        }
        else if ( isdefined( var_0["anim_ents_anim"][var_11] ) && isdefined( var_0["anim_ents_tree"][var_11] ) )
        {
            var_9 = var_0["anim_ents_anim"][var_11];
            var_5 _meth_8115( var_0["anim_ents_tree"][var_11] );
            var_5 _meth_813E( "grapple_landing_anim", var_6, var_7, var_9, undefined, undefined, 0.1 );

            if ( isdefined( var_0["anim_ents_origin"][var_11] ) )
            {
                var_10 = undefined;

                if ( isdefined( self.grapple["mantle"] ) && isdefined( self.grapple["mantle"]["victim"] ) )
                    var_10 = self.grapple["mantle"]["victim"];

                var_5 grapple_setup_death_event_handlers( "grapple_landing_anim", self, var_10, getanimlength( var_9 ) );
            }

            if ( var_11 == "hands" )
                thread grapple_view_model_hands_hide_show();
        }

        var_5 _meth_8092();
    }

    return var_1;
}

grapple_landing_trans( var_0, var_1 )
{
    self endon( "death" );
    self endon( "grapple_disconnect" );
    self notify( "grapple_abort_monitor" );
    var_2 = var_0["trans_time"];
    var_3 = var_0["trans_duration"];
    var_4 = self getangles();
    var_5 = max( 45, var_4[0] );

    if ( self.grapple["style"] == "ceiling" )
        var_5 = min( -45, var_4[0] );

    var_6 = ( var_5, var_1.angles[1], 0 );
    var_7 = var_3 * 0.2;
    var_8 = var_3 * 0.1;
    var_9 = self.grapple["model_player_trans"];
    var_9.origin = self.origin;
    var_9.angles = self getangles();
    var_9 _meth_8092();

    if ( grapple_special_land_hide_rope() )
        grapple_rope_state( 0, 0 );
    else
        grapple_rope_state( 2, 100 );

    if ( isdefined( var_0["anim_ents_origin"]["body"] ) && isdefined( var_0["anim_ents"]["body"] ) )
    {
        grapple_setup_rope_attached_player( self, self, 0 );
        var_10 = var_0["anim_ents"]["body"];
        self _meth_8080( var_10, "tag_player", var_3, var_7, var_8 );
        wait(var_3);
        grapple_landing_landed( undefined, undefined, undefined, undefined );
        wait 0.05;
        self _meth_807D( var_10, "tag_player", 1, 0, 0, 0, 0, 1 );
        self _meth_80F3( self.grapple["weapon"], level.grapple_weapon_anim["travel"] );
        grapple_disable_weapon();
        var_10 show();
        self.grapple["model_hands"] hide();
    }
    else
    {
        grapple_setup_rope_attached_player( var_9, var_9, 0, "tag_player" );
        var_11 = var_3 * 0.75;
        var_12 = var_3 - var_11;
        var_13 = undefined;
        self _meth_807C( var_9, "tag_player", 1, 0, 0, 0, 0 );
        var_14 = var_1.origin + vectornormalize( self.grapple["poll_velocity"] ) * 10;
        var_13 = var_1.origin;
        var_9 _meth_82B5( var_6, var_3, var_7, var_8 );
        var_9 grapple_decelerate_move_to( self.grapple["poll_velocity"], var_14, var_1.land_entity, undefined, var_11, var_11 * 0.75, 0 );
        grapple_landing_landed( var_9, var_13, var_12, var_1 );
    }
}

grapple_landing_landed( var_0, var_1, var_2, var_3 )
{
    if ( !common_scripts\utility::issp() )
        self.grapple["model_player_move_tag"] _meth_80AC();
    else
        level notify( "stop_grapplesound" );

    grapple_landing_sound( self.grapple["surface_trace"]["surfacetype"] );
    grapple_notify_closest_ai( "grapple_impact", self.origin, 250 );
    self _meth_80AD( "falling_land" );
    self _meth_83FE( 2.0, 1.0, 2.0, 0.5, 0, 0.1, 128, 3, 3, 3 );

    if ( isdefined( var_1 ) && isdefined( var_0 ) && isdefined( var_2 ) )
        var_0 _meth_82AE( var_1, var_2, var_2 * 0.25, var_2 * 0.25, var_3 );

    var_4 = self.grapple["model_rope_idle"];
    var_4 hide();
    grapple_setup_rope_attached_player( self, self, 0 );
    killfxontag( level._effect["grapple_cam"], self.grapple["model_player_to"], "tag_origin" );
}

grapple_landing_sound( var_0 )
{
    var_1 = "linelauncher_land_plr_concrete";

    if ( isdefined( var_0 ) )
    {
        if ( getsubstr( var_0, 0, 5 ) == "metal" )
            var_1 = "linelauncher_land_plr_metal";
        else if ( getsubstr( var_0, 0, 4 ) == "wood" )
            var_1 = "linelauncher_land_plr_wood";
        else if ( getsubstr( var_0, 0, 4 ) == "dirt" )
            var_1 = "linelauncher_land_plr_dirt";
        else if ( getsubstr( var_0, 0, 5 ) == "grass" )
            var_1 = "linelauncher_land_plr_grass";
    }

    var_2 = "linelauncher_land_concrete";

    if ( isdefined( var_0 ) )
    {
        if ( getsubstr( var_0, 0, 5 ) == "metal" )
            var_2 = "linelauncher_land_metal";
        else if ( getsubstr( var_0, 0, 4 ) == "wood" )
            var_2 = "linelauncher_land_wood";
        else if ( getsubstr( var_0, 0, 4 ) == "dirt" )
            var_2 = "linelauncher_land_dirt";
        else if ( getsubstr( var_0, 0, 5 ) == "grass" )
            var_2 = "linelauncher_land_grass";
    }

    if ( common_scripts\utility::issp() && isplayer( self ) )
    {
        soundscripts\_snd_playsound::snd_play_2d( var_1 );
        soundscripts\_snd_playsound::snd_play_2d( "linelauncher_plr_mantle" );
        soundscripts\_snd::snd_message( "aud_grapple_land" );
    }
    else if ( isai( self ) )
        self playsound( var_2 );
    else
        self playsound( var_1 );
}

grapple_motion_blur_enable()
{
    if ( common_scripts\utility::issp() && level.nextgen )
    {
        _func_0D3( "r_mbEnable", 2 );
        _func_0D3( "r_mbVelocityScalar", 4 );
    }
}

grapple_motion_blur_disable()
{
    if ( common_scripts\utility::issp() && level.nextgen )
    {
        _func_0D3( "r_mbEnable", 0 );
        _func_0D3( "r_mbVelocityScalar", 1 );
    }
}

grapple_special()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) )
        return var_0.land_magnet.specialstruct.type;

    return "";
}

grapple_special_landing_anims()
{
    var_0 = self.grapple["model_player_to"];
    var_1 = undefined;

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) )
    {
        if ( isdefined( var_0.land_magnet.specialstruct.landanimbody ) || isdefined( var_0.land_magnet.specialstruct.landanimhands ) )
            var_1 = [ var_0.land_magnet.specialstruct.landanimbody, var_0.land_magnet.specialstruct.landanimhands ];
    }

    return var_1;
}

grapple_special_no_enable_exo()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) && isdefined( var_0.land_magnet.specialstruct.noenableexo ) )
        return var_0.land_magnet.specialstruct.noenableexo;

    return 0;
}

grapple_special_no_enable_weapon()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) && isdefined( var_0.land_magnet.specialstruct.noenableweapon ) )
        return var_0.land_magnet.specialstruct.noenableweapon;

    return 0;
}

grapple_special_hint()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) && isdefined( var_0.land_magnet.specialstruct.hint ) )
        return var_0.land_magnet.specialstruct.hint;

    return undefined;
}

grapple_special_land_hide_rope()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) && isdefined( var_0.land_magnet.specialstruct.landhiderope ) )
        return var_0.land_magnet.specialstruct.landhiderope;

    return 0;
}

grapple_special_indicator_offset()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) && isdefined( var_0.land_magnet.specialstruct.indicatoroffset ) )
        return var_0.land_magnet.specialstruct.indicatoroffset;

    return ( 0, 0, 0 );
}

grapple_special_no_abort()
{
    var_0 = self.grapple["model_player_to"];

    if ( isdefined( var_0.land_magnet ) && isdefined( var_0.land_magnet.specialstruct ) && isdefined( var_0.land_magnet.specialstruct.noabort ) )
        return var_0.land_magnet.specialstruct.noabort;

    return 0;
}

grapple_magnet_validate_ground( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.specialstruct ) && isdefined( var_0.specialstruct.requireonground ) && var_0.specialstruct.requireonground && !self _meth_8341() )
        return 0;

    return 1;
}

grapple_notify_closest_ai( var_0, var_1, var_2, var_3 )
{
    if ( !common_scripts\utility::issp() )
        return;

    var_4 = _func_0D6( "axis" );
    var_4 = common_scripts\utility::get_array_of_closest( var_1, var_4, undefined, undefined, var_2, undefined );

    foreach ( var_6 in var_4 )
    {
        if ( var_6.ignoreall )
            continue;

        var_6 notify( var_0, var_1 );

        if ( !isdefined( var_3 ) || !var_3 )
            break;
    }
}

grapple_notify_ai_capsule( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !common_scripts\utility::issp() )
        return;

    var_5 = var_2 - var_1;
    var_6 = vectornormalize( var_5 );
    var_7 = length( var_5 );
    var_8 = _func_0D6( "axis" );
    var_8 = common_scripts\utility::get_array_of_closest( var_2, var_8, undefined, undefined, var_7 + var_3 * 2, undefined );

    foreach ( var_10 in var_8 )
    {
        if ( var_10.ignoreall )
            continue;

        if ( !isalive( var_10 ) )
            continue;

        var_11 = var_10 _meth_80A8();
        var_12 = var_11 - var_1;
        var_13 = vectordot( var_12, var_6 );

        if ( var_13 > var_3 * -1 && var_13 < var_7 + var_3 )
        {
            var_14 = var_1 + var_6 * var_13;
            var_15 = distance( var_14, var_11 );

            if ( var_15 <= var_3 )
            {
                var_10 notify( var_0, var_2 );

                if ( !isdefined( var_4 ) || !var_4 )
                    break;
            }
        }
    }
}

grapple_decelerate_move_to( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self endon( "death" );
    var_9 = self.origin;
    var_10 = vectornormalize( var_0 );
    var_11 = length( var_0 ) / var_5 * 2;
    var_12 = gettime() - 25;
    var_13 = var_4 * 1000;

    if ( isdefined( var_7 ) && !isdefined( var_8 ) )
        var_8 = ( 0, 0, 0 );

    if ( isdefined( var_2 ) && !isdefined( var_3 ) && isdefined( var_1 ) )
    {
        var_1 -= var_2.origin;
        var_1 = _func_24D( var_1, var_2.angles );
    }

    while ( gettime() - var_12 < var_13 )
    {
        var_14 = float( gettime() - var_12 ) / 1000.0;
        var_15 = min( var_14, var_5 );
        var_16 = var_9 + var_0 * var_15;
        var_17 = var_16 + var_10 * var_11 * -0.5 * var_15 * var_15;
        var_18 = var_14 / var_4;
        var_18 = 1.0 - 0.5 + cos( var_18 * 180 ) * 0.5;
        var_19 = var_1;

        if ( isdefined( var_2 ) && !isdefined( var_3 ) && isdefined( var_1 ) )
            var_19 = var_2.origin + rotatevector( var_1, var_2.angles );
        else if ( isdefined( var_2 ) && isdefined( var_3 ) )
            var_19 = var_2 gettagorigin( var_3 );

        if ( var_6 )
        {
            var_20 = vectorlerp( var_17, var_19, var_18 );
            var_21 = var_18 * var_18;
            var_22 = vectorlerp( var_17, var_19, var_21 );
            var_20 = ( var_20[0], var_20[1], var_22[2] );
        }
        else
            var_20 = vectorlerp( var_17, var_19, var_18 );

        var_23 = playerphysicstrace( self.origin, var_20, level.player );

        if ( distancesquared( var_23, var_20 ) > 0.01 )
            var_20 = ( var_20[0], var_20[1], self.origin[2] );

        self.origin = var_20;

        if ( isdefined( var_7 ) )
            self.angles = vectortoangles( var_7.origin - self.origin + var_8 );

        wait 0.05;
    }
}

grapple_delayed_hide( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self hide();
}

grapple_fire_rope( var_0, var_1 )
{
    self endon( "death" );
    self endon( "grapple_disconnect" );
    self notify( "grapple_fire_rope" );
    self _meth_80AD( "heavygun_fire" );
    self _meth_83FE( 2.0, 1.0, 1.0, 0.5, 0, 0.5, 128, 2, 1, 1 );
    soundscripts\_snd::snd_message( "aud_grapple_launch" );
    var_2 = anglestoup( self.grapple["model_preview"].angles );
    self.grapple["landing_prep_started"] = 0;
    self.grapple["velocity_when_fired"] = self getvelocity();
    var_3 = self.grapple["model_rope_fire"];
    var_4 = self.grapple["model_rope_idle"];
    var_5 = self.grapple["model_attach_world"];
    var_6 = self.grapple["model_player_move_tag"];
    var_7 = self.grapple["model_player_from"];
    self freezecontrols( 1 );
    self setangles( vectortoangles( var_5.origin - self _meth_80A8() ) );
    self.angles = ( 0, self getangles()[1], 0 );
    grapple_setup_rope_attached();
    grapple_setup_rope_fire();
    var_6 _meth_804F();
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_6 _meth_8092();

    if ( self _meth_8068() && isdefined( var_7 ) )
        var_6 _meth_804D( var_7 );
    else if ( self _meth_8341() )
    {
        var_8 = _func_238( self.origin, self.origin + ( 0, 0, -10 ) );

        if ( isdefined( var_8["entity"] ) )
            var_6 _meth_804D( var_8["entity"] );
    }
    else
        var_6.velocity = self getvelocity();

    var_9 = "fire";

    if ( isdefined( var_0 ) )
    {
        self _meth_84B5( level.scr_viewanim[var_0] );
        var_9 = var_0;
    }
    else
        self _meth_80F3( self.grapple["weapon"], level.grapple_weapon_anim["fire"] );

    var_10 = grapple_anim_length( "grapple_rope", var_9 );
    var_3 thread maps\_anim::anim_single_solo( var_3, var_9 );
    grapple_rope_state( 1 );
    thread grapple_fire_rope_impact( 0.15 );
    thread grapple_fire_rope_finish( var_10 - 0.05, var_1 );
}

grapple_fire_rope_impact( var_0 )
{
    var_1 = anglestoup( self.grapple["model_preview"].angles );
    var_2 = self.grapple["model_attach_world"];
    wait(var_0);

    if ( !isai( self.grapple["surface_trace"]["entity"] ) )
    {
        magicbullet( "s1_grapple_impact", var_2.origin + var_1, var_2.origin - var_1 );
        var_2 show();
    }

    self notify( "grapple_rope_impact" );
}

grapple_fire_rope_finish( var_0, var_1 )
{
    self endon( "death" );
    self endon( "grapple_disconnect" );
    self endon( "grapple_fire_rope" );
    self.grapple["fire_rope_finished"] = 0;

    if ( self.grapple["landing_prep_started"] )
    {
        self.grapple["fire_rope_finished"] = 1;
        self notify( "grapple_fire_rope_finished" );

        if ( isdefined( var_1 ) )
            self [[ var_1 ]]();

        return;
    }

    var_2 = common_scripts\utility::waittill_any_timeout( var_0, "grapple_entity_finished", "grapple_complete_player_move", "grapple_prep_land" );

    if ( var_2 == "timeout" || var_2 == "grapple_prep_land" )
    {
        if ( isdefined( var_1 ) )
            self [[ var_1 ]]();

        self.grapple["fire_rope_finished"] = 1;
        self notify( "grapple_fire_rope_finished" );
    }
}

grapple_fire_finished()
{
    self freezecontrols( 0 );

    if ( grapple_special() != "weapon" )
    {
        var_0 = self.grapple["landingParms"];
        var_1 = isdefined( var_0["anim_ents"]["hands"] ) && isdefined( var_0["anim_ents_anim"]["hands"] ) && isdefined( var_0["anim_ents_tree"]["hands"] );
        var_1 |= isdefined( self.grapple["landing_view_anim"] );

        if ( !var_1 )
        {
            self _meth_84B5( level.scr_viewanim["grapple_fire_end"] );
            wait(getanimlength( level.scr_anim["grapple_hands"]["grapple_fire_end"] ) - 0.05);
            self _meth_80F3( self.grapple["weapon"], level.grapple_weapon_anim["travel"] );
        }
    }
}

grapple_attach_bolt( var_0, var_1 )
{
    var_2 = self.grapple["model_attach_world"];
    var_2 _meth_804F();
    var_2 hide();

    if ( var_0 == self.grapple["model_preview"] )
    {
        var_2.origin = self.grapple["model_preview"].origin;
        var_3 = vectortoangles( vectornormalize( var_2.origin - self _meth_80A8() ) );
        var_2.angles = var_3;

        if ( isdefined( self.grapple["model_player_to"].land_entity ) )
        {
            if ( isdefined( self.grapple["model_player_to"].land_magnet ) && self.grapple["model_player_to"].land_magnet.tag != "" )
                var_2 _meth_804D( self.grapple["model_player_to"].land_entity, self.grapple["model_player_to"].land_magnet.tag );
            else
                var_2 _meth_804D( self.grapple["model_player_to"].land_entity );
        }
    }
    else if ( isdefined( var_0 ) )
    {
        var_2.origin = var_0 gettagorigin( var_1 );
        var_3 = vectortoangles( vectornormalize( var_2.origin - self _meth_80A8() ) );
        var_2.angles = var_3;
        var_2 _meth_804D( var_0, var_1 );
    }

    var_2 _meth_8092();
    return var_2;
}

grapple_stand_and_lock_stances()
{
    self _meth_8321();
    maps\_utility::playerallowweaponpickup( 0 );
    self _meth_811A( 0 );
    self _meth_8119( 0 );
    self _meth_8130( 0 );
    self _meth_817D( "stand" );
}

grapple_unlock_stances()
{
    self _meth_8322();
    maps\_utility::playerallowweaponpickup( 1 );
    self _meth_811A( 1 );
    self _meth_8119( 1 );
    self _meth_8130( 1 );
    grapple_enable_weapon();
    grapple_motion_blur_disable();
}

grapple_enable_weapon()
{
    self.grapple["weapon_enabled"] = 1;

    if ( self.grapple["no_enable_weapon"] )
        return;

    self _meth_831E();
}

grapple_disable_weapon()
{
    self.grapple["weapon_enabled"] = 0;
    self _meth_831D();
}

grapple_quick_fire_switch_back( var_0 )
{
    self endon( "death" );

    while ( !var_0 && self.grapple["weapon_enabled"] && self _meth_8337() )
        wait 0.05;

    grapple_switch( 0, var_0 );
    self.grapple["ready_time"] = gettime() + 3000;
    self.grapple["quick_fire_executed"] = 0;

    while ( self _meth_8311() == self.grapple["weapon"] || self _meth_8311() == "none" )
        wait 0.05;
}

grapple_enable_normal_mantle_hint( var_0 )
{
    if ( var_0 )
        _func_0D3( "cg_drawMantleHint", "1" );
    else
        _func_0D3( "cg_drawMantleHint", "0" );
}

grapple_with_weapon_start( var_0 )
{
    wait 0.4;
    var_1 = self.grapple["model_player_move_lerp"];
    self _meth_807D( var_1, "tag_origin", 1.0, var_0.anglelimit, var_0.anglelimit, var_0.anglelimit, var_0.anglelimit, 0 );
    self _meth_8499();
    grapple_setup_rope_attached( 0 );
    grapple_rope_state( 1 );
    thread grapple_with_weapon_turnrates( "end_grapple_with_weapon" );
    thread grapple_with_weapon_infinite_ammo( "end_grapple_with_weapon" );
    self _meth_80EF();
    grapple_enable_weapon();
    self _meth_8316( var_0.weapon );
    self _meth_8321();
    wait 0.6;
}

grapple_with_weapon_travel( var_0 )
{
    if ( isdefined( var_0.slowmodelay ) )
        wait(var_0.slowmodelay);

    if ( !isdefined( var_0.slowmodelta ) )
        var_0.slowmodelta = 0.15;

    setslowmotion( 1, var_0.slowmospeed, var_0.slowmodelta );
    common_scripts\utility::waittill_any( "grapple_landing_trans_started", "grapple_abort", var_0.slowmostop );
    self _meth_8322();
    self _meth_80F0();
    setslowmotion( var_0.slowmospeed, 1, 0.25 );
    self notify( "end_grapple_with_weapon" );
}

grapple_with_weapon_turnrates( var_0 )
{
    self.aim_turnrate_pitch = getdvarint( "aim_turnrate_pitch" );
    self.aim_turnrate_pitch_ads = getdvarint( "aim_turnrate_pitch_ads" );
    self.aim_turnrate_yaw = getdvarint( "aim_turnrate_yaw" );
    self.aim_turnrate_yaw_ads = getdvarint( "aim_turnrate_yaw_ads" );
    self.aim_accel_turnrate_lerp = getdvarint( "aim_accel_turnrate_lerp" );
    _func_0D3( "aim_turnrate_pitch", 180 );
    _func_0D3( "aim_turnrate_pitch_ads", 110 );
    _func_0D3( "aim_turnrate_yaw", 500 );
    _func_0D3( "aim_turnrate_yaw_ads", 250 );
    _func_0D3( "aim_accel_turnrate_lerp", 1200 );
    self waittill( var_0 );
    _func_0D3( "aim_turnrate_pitch", self.aim_turnrate_pitch );
    _func_0D3( "aim_turnrate_pitch_ads", self.aim_turnrate_pitch_ads );
    _func_0D3( "aim_turnrate_yaw", self.aim_turnrate_yaw );
    _func_0D3( "aim_turnrate_yaw_ads", self.aim_turnrate_yaw_ads );
    _func_0D3( "aim_accel_turnrate_lerp", self.aim_accel_turnrate_lerp );
}

grapple_with_weapon_infinite_ammo( var_0 )
{
    self endon( "death" );
    self endon( var_0 );

    while ( isdefined( self.weapon ) )
    {
        if ( isdefined( self.weapon ) && self.weapon == "none" )
            break;

        self.bulletsinclip = weaponclipsize( self.weapon );
        wait 0.5;
    }
}
