// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_door_shield()
{
    precachefx();
    precacheitem( "weapon_suv_door_shield_fl" );
    precacheitem( "weapon_suv_door_shield_fr" );
    precacheitem( "weapon_boxtruck_door_shield_fl" );
    precacheitem( "weapon_boxtruck_door_shield_fr" );

    if ( !1 )
        precachemodel( "npc_atlas_suv_door_fl" );

    precachemodel( "vm_atlas_suv_door_fr" );
    precachemodel( "vm_atlas_suv_door_fl" );
    precachemodel( "vm_civ_boxtruck_door_fr" );
    precachemodel( "vm_civ_boxtruck_door_fl" );
    _func_0D3( "r_hudoutlineenable", 1 );
    _func_0D3( "r_hudoutlinewidth", 1 );
    _func_0D3( "r_hudoutlinepostmode", 4 );
    _func_0D3( "r_hudoutlinecloaklumscale", 3 );
    _func_0D3( "r_hudoutlinecloakblurradius", 0.35 );
    maps\_utility::add_control_based_hint_strings( "hint_door_throw", &"_CAR_DOOR_SHIELD_THROW_HINT", ::should_break_on_throw );

    if ( !player_anims() )
        return;

    common_scripts\utility::flag_init( "player_has_cardoor" );
    common_scripts\utility::flag_init( "player_pulling_cardoor" );
    var_0 = getentarray( "trig_door_shield", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "struct_vb_anim_org", "targetname" );
    doors_intialize( var_0, var_1 );
    thread monitor_interaction_toggle_player_has_door( var_0 );
    thread handle_car_door_throw_hint();
}

doors_intialize( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( level.player _meth_834E() )
            var_3 _meth_80DB( &"_CAR_DOOR_SHIELD_INTERACT" );
        else
            var_3 _meth_80DB( &"_CAR_DOOR_SHIELD_INTERACT_PC" );

        var_3.vb_anim_org = var_3 get_closest_scene( var_1 );
        var_3 thread door_shield_think();
    }
}

precachefx()
{
    level._effect["car_door_shield_ripoff"] = loadfx( "vfx/sparks/car_door_ripoff_sparks" );
    level._effect["large_glass_1"] = loadfx( "vfx/weaponimpact/large_glass_1" );
    level._effect["seo_suv_doorshield_hit"] = loadfx( "vfx/map/seoul/seo_suv_doorshield_hit" );
    level._effect["seo_suv_doorshield_hit_break"] = loadfx( "vfx/map/seoul/seo_suv_doorshield_hit_break" );
}

get_closest_scene( var_0 )
{
    return common_scripts\utility::getclosest( self.origin, var_0, 160 );
}

monitor_interaction_toggle_player_has_door( var_0 )
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "player_has_cardoor" );
        common_scripts\utility::flag_clear( "player_pulling_cardoor" );
        var_0 = common_scripts\utility::array_removeundefined( var_0 );

        foreach ( var_2 in var_0 )
        {
            var_2 common_scripts\utility::trigger_off();
            var_2 thread button_hint_disable();
        }

        common_scripts\utility::flag_waitopen( "player_has_cardoor" );
        var_0 = common_scripts\utility::array_removeundefined( var_0 );

        foreach ( var_2 in var_0 )
        {
            var_2 common_scripts\utility::trigger_on();
            var_2 thread button_hint_display();
        }

        waitframe();
    }
}

door_shield_think()
{
    var_0 = getent( self.target, "targetname" );
    var_1 = getent( var_0.target, "targetname" );
    var_1.normal_stencil = 1;
    var_1 thread stecil_when_in_view();

    if ( isdefined( level.template_script ) && level.template_script != "seoul" )
        thread button_hint_display();
    else if ( !isdefined( level.template_script ) )
        thread button_hint_display();

    var_2 = get_door_anime( var_1.model );

    if ( isdefined( self.vb_anim_org ) )
    {
        var_3 = spawn_player_rig_for_carshield( "player_rig", self.vb_anim_org.origin );
        var_3 hide();
        self.vb_anim_org maps\_anim::anim_first_frame_solo( var_3, var_2 );
        var_1.origin = var_3 gettagorigin( "tag_weapon_left" );
        var_1.angles = var_3 gettagangles( "tag_weapon_left" );
        var_3 delete();
    }
    else
        iprintlnbold( "self.vb_anim_org  not defined, skipping door pull anims" );

    var_4 = get_broken_state_tags( var_1.model );

    for ( var_5 = 1; var_5 < var_4.size; var_5++ )
        var_1 _meth_8048( var_4[var_5], var_1.model );

    var_6 = 0;

    while ( !var_6 )
    {
        self waittill( "trigger" );

        if ( isdefined( level.player.grapple ) && ( level.player.grapple["quick_firing"] || level.player.grapple["grappling"] ) )
            continue;

        var_6 = 1;
    }

    self _meth_80DB( "" );
    self delete();
    level.player notify( "car_door_pulled" );
    level.player common_scripts\utility::flag_set( "player_pulling_cardoor" );
    check_for_door( var_1 );
    var_0 common_scripts\utility::delaycall( 0.9, ::delete );
}

button_hint_display()
{
    self.button = maps\_shg_utility::hint_button_trigger( "x" );
    self waittill( "trigger" );
    button_hint_disable();
}

button_hint_disable()
{
    if ( isdefined( self.button ) )
        self.button maps\_shg_utility::hint_button_clear();
}

stecil_when_in_view()
{
    self endon( "death" );
    self endon( "end_hud_outline" );
    self endon( "door_weapon_removed" );
    _func_09A( self );
    _func_0A6( self, level.player );

    while ( isdefined( self ) )
    {
        while ( !self.normal_stencil )
            waitframe();

        var_0 = distance( level.player.origin, self.origin );

        if ( var_0 < 200 && _func_09F( self, level.player, 65, 150 ) )
            self _meth_83FA( 6, 1 );
        else
            self _meth_83FB();

        wait 0.05;
    }
}

check_for_door( var_0 )
{
    var_1 = level.player _meth_830B();

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "door" ) )
        {
            level.player _meth_830F( var_3 );
            break;
        }
    }

    thread equip_new_door( var_0, isdefined( self.vb_anim_org ) );

    if ( isdefined( self.vb_anim_org ) )
        level.player play_vb_cardoor_anim( self.vb_anim_org, var_0 );
}

play_vb_cardoor_anim( var_0, var_1 )
{
    var_2 = get_door_anime( var_1.model );
    var_3 = spawn_player_rig_for_carshield( "player_rig", var_0.origin );
    var_3 hide();
    thread car_door_ripoff_fx( var_1 );
    self freezecontrols( 1 );
    var_4 = 0.4;
    var_0 thread maps\_anim::anim_first_frame_solo( var_3, var_2 );
    get_cardoor_in_players_hands( var_3, var_1 );
    self _meth_8080( var_3, "tag_player", var_4 );
    maps\_shg_utility::setup_player_for_scene( 1 );
    thread delete_nearest_car_door_vehicle_collision();
    var_3 show();
    level.player _meth_80EF();
    soundscripts\_snd::snd_message( "doorshield_ripoff" );
    var_0 maps\_anim::anim_single_solo( var_3, var_2 );
    level.player _meth_80F0();
    self _meth_804F();
    var_3 delete();
    maps\_shg_utility::setup_player_for_gameplay();
    self freezecontrols( 0 );
    self notify( "player_has_cardoor" );
}

car_door_ripoff_fx( var_0 )
{
    if ( issubstr( var_0.model, "fr" ) )
    {
        wait 1.6;
        var_1 = common_scripts\utility::spawn_tag_origin();
        var_1 _meth_804D( var_0, "tag_flash", ( 0, 35, 0 ), ( 0, 0, 0 ) );
        playfxontag( common_scripts\utility::getfx( "car_door_shield_ripoff" ), var_1, "tag_origin" );
        wait 2;
        var_1 delete();
    }
    else
    {
        wait 1.6;
        var_2 = common_scripts\utility::spawn_tag_origin();
        var_2 _meth_804D( var_0, "tag_flash", ( 0, -35, 0 ), ( 0, 0, 0 ) );
        playfxontag( common_scripts\utility::getfx( "car_door_shield_ripoff" ), var_2, "tag_origin" );
        wait 2;
        var_2 delete();
    }
}

get_cardoor_in_players_hands( var_0, var_1 )
{
    var_1 _meth_804D( var_0, "tag_weapon_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

spawn_player_rig_for_carshield( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "player_rig";

    if ( !isdefined( var_1 ) )
        var_1 = level.player.origin;

    var_2 = maps\_utility::spawn_anim_model( var_0 );
    return var_2;
}

equip_new_door( var_0, var_1 )
{
    var_2 = get_weapon_model( var_0.model );
    var_3 = get_door_model( var_0.model );
    give_door_shield_weapon( var_0, var_2, var_3, var_1 );
    level notify( "player_owns_cardoor_shield" );
    common_scripts\utility::flag_set( "player_has_cardoor" );
}

get_door_model( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "atlas_suv_door_03_gj":
        case "vm_atlas_suv_door_fl":
            var_1 = "vm_atlas_suv_door_fl";
            break;
        case "atlas_suv_door_04_gj":
        case "atlas_suv_door_02_gj":
        case "vm_atlas_suv_door_fr":
            var_1 = "vm_atlas_suv_door_fr";
            break;
        case "npc_civ_boxtruck_door_fl":
            var_1 = "vm_civ_boxtruck_door_fl";
            break;
        case "npc_civ_boxtruck_door_fr":
            var_1 = "vm_civ_boxtruck_door_fr";
            break;
    }

    return var_1;
}

get_weapon_model( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "atlas_suv_door_03_gj":
        case "vm_atlas_suv_door_fl":
            var_1 = "weapon_suv_door_shield_fl";
            break;
        case "atlas_suv_door_04_gj":
        case "atlas_suv_door_02_gj":
        case "vm_atlas_suv_door_fr":
            var_1 = "weapon_suv_door_shield_fr";
            break;
        case "npc_civ_boxtruck_door_fl":
            var_1 = "weapon_boxtruck_door_shield_fl";
            break;
        case "npc_civ_boxtruck_door_fr":
            var_1 = "weapon_boxtruck_door_shield_fr";
            break;
    }

    return var_1;
}

get_door_anime( var_0 )
{
    var_1 = undefined;

    if ( issubstr( var_0, "boxtruck" ) )
    {
        var_1 = "doorshield_bt_ripoff";

        if ( issubstr( var_0, "fr" ) )
            var_1 = "doorshield_bt_ripoff_r";
    }
    else
    {
        var_1 = "doorshield_ripoff";

        if ( issubstr( var_0, "fr" ) )
            var_1 = "doorshield_ripoff_r";
    }

    return var_1;
}

get_yaw_offset_if_vm_model( var_0 )
{
    if ( var_0 == "vm_atlas_suv_door_fr" || var_0 == "vm_atlas_suv_door_fl" || var_0 == "vm_civ_boxtruck_door_fr" || var_0 == "vm_civ_boxtruck_door_fl" )
        return -90;

    return 0;
}

give_door_shield_weapon( var_0, var_1, var_2, var_3 )
{
    var_0 notify( "end_hud_outline" );
    var_0 _meth_83FB();
    level.player.cardoor_old_weapon = level.player _meth_8311();
    level.player.cardoor_weapon = var_1;
    level.player _meth_830E( var_1 );
    level.player _meth_8315( var_1 );

    if ( isdefined( var_3 ) && var_3 )
        level.player waittill( "player_has_cardoor" );

    if ( var_0.model != var_2 )
        var_0 _meth_80B1( var_2 );

    var_0 _meth_80A6( level.player, "TAG_WEAPON_LEFT", ( 0, 0, 0 ), ( 0, get_yaw_offset_if_vm_model( var_2 ), 0 ), 1 );
    level.player thread delete_weapon_on_notify( var_0, var_1 );
    thread weapon_pickups_disable( var_0 );
    thread monitor_door_state( var_0, level.player );
    thread monitor_throw_door( var_0 );
    thread monitor_grenades( var_0 );
    thread monitor_weapon_switch( var_0 );
    thread monitor_door_broken( var_0 );
    thread monitor_weapon_remove( var_0, var_1 );
}

weapon_pickups_disable( var_0 )
{
    level.player maps\_utility::playerallowweaponpickup( 0, "door_shield" );
    var_0 waittill( "door_weapon_removed" );
    level.player maps\_utility::playerallowweaponpickup( 1, "door_shield" );
}

handle_npc_death( var_0 )
{
    var_1 = _func_0D6( "axis" );

    foreach ( var_3 in var_1 )
        var_3 thread kill_npc_on_impact( var_0 );
}

monitor_throw_door( var_0 )
{
    var_0 endon( "door_weapon_removed" );
    level.player endon( "kill_throw_monitor" );
    var_1 = [ "weapon_suv_door_shield_fr", "weapon_suv_door_shield_fl", "weapon_boxtruck_door_shield_fr", "weapon_boxtruck_door_shield_fl" ];

    for (;;)
    {
        while ( !level.player attackbuttonpressed() && !level.player meleebuttonpressed() )
            waitframe();

        var_2 = level.player _meth_8311();

        foreach ( var_4 in var_1 )
        {
            if ( var_2 == var_4 )
            {
                thread play_throw_anim( var_4, var_0, 1 );
                soundscripts\_snd::snd_message( "doorshield_throw" );
                level.player notify( "kill_throw_monitor" );
                break;
            }
        }

        waitframe();
    }
}

play_throw_anim( var_0, var_1, var_2, var_3 )
{
    wait 0.1;
    level.player exo_door_throw( var_1, var_2 );
    level.player _meth_830F( var_0 );

    if ( !isdefined( var_3 ) || var_3 == 1 )
        level.player _meth_8315( level.player.cardoor_old_weapon );

    common_scripts\utility::flag_clear( "player_has_cardoor" );
}

exo_door_throw( var_0, var_1 )
{
    var_2 = undefined;

    if ( !1 )
    {
        var_3 = level.player.origin;
        var_2 = spawn( "script_model", var_3 + ( 0, 0, 48 ) );
        var_2 _meth_80B1( "npc_atlas_suv_door_FL" );
        var_2.origin = var_0.origin;
        var_2.angles = var_0.angles;
        var_0 delete();
    }
    else
    {
        var_2 = var_0;
        var_0 _meth_80A7( level.player );
        var_0 show();
    }

    var_2.original_origin = var_2.origin;
    var_2.angles = ( 0, self.angles[1], self.angles[2] );
    thread handle_npc_death( var_2 );
    var_4 = common_scripts\utility::spawn_tag_origin();
    _func_09A( var_4 );
    _func_0A6( var_4, level.player );
    var_5 = undefined;

    if ( var_1 )
    {
        var_6 = _func_0D6( "axis" );
        var_6 = sortbydistance( var_6, level.player.origin );
        var_7 = undefined;

        foreach ( var_9 in var_6 )
        {
            var_4.origin = var_9 _meth_80A8();

            if ( _func_09F( var_4, level.player, 65, 100 ) )
                var_7 = var_9;
        }

        if ( isdefined( var_7 ) )
            var_5 = var_7;
        else
            var_5 = undefined;
    }

    var_4 delete();
    var_2 soundscripts\_snd::snd_message( "doorshield_throw" );
    var_2 fire_door_shield( var_5, var_1 );
}

fire_door_shield( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = 0;
    var_4 = 0;
    var_5 = 100;

    if ( isdefined( var_0 ) && issentient( var_0 ) && var_1 )
    {
        var_2 = vectornormalize( var_0.origin - self.origin ) * var_5;
        var_6 = distance( self.origin, var_0.origin );
        var_3 = min( 200, var_6 );
        var_4 = min( 250, var_6 ) + var_6 / 5;
    }
    else if ( var_1 )
    {
        var_7 = anglestoforward( level.player _meth_8036() );
        var_8 = self.origin + var_7 * var_5;
        var_2 = var_8 - self.origin;
        var_3 = 200;
        var_4 = 250;
    }
    else
    {
        var_7 = anglestoforward( level.player _meth_8036() );
        var_8 = self.origin + var_7 * var_5;
        var_2 = var_8 - self.origin;
        var_3 = 40;
        var_4 = 41;
    }

    self _meth_8276( self.origin, var_2 * randomfloatrange( var_3, var_4 ), 20000, 1080 );
    level.player notify( "car_door_thrown" );
    self notify( "door_weapon_removed" );
}

kill_npc_on_impact( var_0 )
{
    var_0 endon( "physics_finished" );
    self endon( "death" );

    while ( distance( self.origin, var_0.origin ) > 100 )
        waitframe();

    thread maps\_utility::flashbangstart( 2 );

    if ( issubstr( self.classname, "mech" ) )
        return;

    while ( distance( self.origin, var_0.origin ) > 50 )
        waitframe();

    var_1 = vectornormalize( self gettagorigin( "tag_eye" ) - var_0.original_origin );
    var_1 = vectornormalize( var_1 + ( 0, 0, 0.2 ) );
    self _meth_8024( "torso_lower", var_1 * 3400 );
    maps\_utility::giveachievement_wrapper( "CARMA" );
    self _meth_8052();
}

#using_animtree("player");

player_anims( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level.scr_model ) )
    {
        if ( isdefined( level.scr_model["player_rig"] ) )
            var_1 = "player_rig";
    }

    if ( !isdefined( var_1 ) )
        return 0;

    level.scr_anim[var_1]["doorshield_ripoff"] = %vm_doorshield_pullout_viewbody;
    level.scr_anim[var_1]["doorshield_ripoff_r"] = %vm_doorshield_passenger_pullout_viewbody;
    level.scr_anim[var_1]["doorshield_bt_ripoff"] = %vm_doorshield_truck_driver_pullout_viewbody;
    level.scr_anim[var_1]["doorshield_bt_ripoff_r"] = %vm_doorshield_truck_passenger_pullout_viewbody;
    return 1;
}

monitor_grenades( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "door_weapon_removed" );
    level.player endon( "car_door_thrown" );
    var_1 = "none";

    for (;;)
    {
        if ( level.player _meth_812C() )
        {
            var_1 = get_player_grenade_button();
            wait 0.1;
            var_0 hide();

            for (;;)
            {
                wait_for_thrown_grenade( var_0 );

                if ( var_1 == "frag_button" && level.player _meth_82EF() )
                {
                    var_1 = "secondary_offhand_button";
                    continue;
                }

                if ( var_1 == "secondary_offhand_button" && level.player _meth_82EE() )
                {
                    var_1 = "frag_button";
                    continue;
                }

                break;
            }

            var_0 show();

            while ( level.player _meth_812C() )
                waitframe();
        }
        else if ( !is_current_weapon_shield( level.player _meth_8311() ) )
        {
            var_0 hide();

            while ( !is_current_weapon_shield( level.player _meth_8311() ) )
                waitframe();

            var_0 show();
        }

        waitframe();
    }
}

monitor_weapon_switch( var_0 )
{
    var_0 endon( "door_weapon_removed" );
    level.player endon( "car_door_thrown" );

    for (;;)
    {
        level.player waittill( "weapon_switch_started", var_1 );

        if ( issubstr( level.player _meth_8311(), "door" ) )
        {
            var_2 = 1;

            if ( _func_1DF( var_1 ) != "offhand" && var_1 != "none" )
                var_2 = 0;

            thread play_throw_anim( level.player _meth_8311(), var_0, 0, var_2 );
            return;
        }
    }
}

monitor_door_broken( var_0 )
{
    var_0 endon( "door_weapon_removed" );
    level.player endon( "car_door_thrown" );

    for (;;)
    {
        level.player waittill( "car_door_broken" );

        if ( issubstr( level.player _meth_8311(), "door" ) )
        {
            thread play_throw_anim( level.player _meth_8311(), var_0, 0 );
            return;
        }
    }
}

monitor_weapon_remove( var_0, var_1 )
{
    var_0 endon( "death" );
    level.player endon( "car_door_thrown" );

    for (;;)
    {
        if ( !level.player _meth_8314( var_1 ) )
        {
            var_0 notify( "door_weapon_removed" );
            waitframe();
            var_2 = getweaponarray();

            foreach ( var_4 in var_2 )
            {
                if ( var_4.classname == "weapon_" + var_1 )
                {
                    thread play_throw_anim( var_1, var_0, 0 );
                    var_4 delete();
                }
            }

            if ( level.player _meth_8311() == "none" )
                level.player _meth_8315( level.player.cardoor_old_weapon );
        }

        waitframe();
    }
}

get_player_grenade_button()
{
    var_0 = level.player _meth_8313();

    if ( isdefined( level.player.variable_grenade ) )
    {
        foreach ( var_2 in level.player.variable_grenade["normal"] )
        {
            if ( var_2 == var_0 )
                return "frag_button";
        }

        foreach ( var_2 in level.player.variable_grenade["special"] )
        {
            if ( var_2 == var_0 )
                return "secondary_offhand_button";
        }
    }
    else if ( var_0 == "frag_grenade_var" || var_0 == "frag_grenade" )
        return "frag_button";
    else if ( var_0 == "flash_grenade_var" || var_0 == "flash_grenade" )
        return "secondary_offhand_button";

    if ( level.player _meth_82EE() )
        return "frag_button";
    else if ( level.player _meth_82EF() )
        return "secondary_offhand_button";

    return "none";
}

is_current_weapon_shield( var_0 )
{
    return var_0 == "weapon_suv_door_shield_fr" || var_0 == "weapon_suv_door_shield_fl" || var_0 == "weapon_boxtruck_door_shield_fr" || var_0 == "weapon_boxtruck_door_shield_fl";
}

wait_for_thrown_grenade( var_0 )
{
    var_0 endon( "death" );
    level.player endon( "car_door_thrown" );
    var_0 endon( "door_weapon_removed" );
    level.player endon( "offhand_end" );

    while ( level.player _meth_812C() )
        waitframe();
}

get_broken_state_tags( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_2[0] = "TAG_GLASS_LEFT_FRONT";
    var_2[1] = "TAG_GLASS_LEFT_FRONT_D1";
    var_2[2] = "TAG_GLASS_LEFT_FRONT_D2";
    var_2[3] = "TAG_GLASS_LEFT_FRONT_D3";
    var_2[4] = "TAG_GLASS_LEFT_FRONT_D4";

    foreach ( var_4 in var_2 )
    {
        if ( maps\_utility::hastag( var_0, var_4 ) )
            var_1[var_1.size] = var_4;
    }

    return var_1;
}

monitor_door_state( var_0, var_1 )
{
    var_0 notify( "kill_duplicate_threads" );
    var_0 endon( "kill_duplicate_threads" );
    var_0 endon( "death" );
    var_0 endon( "door_weapon_removed" );
    var_1 endon( "car_door_thrown" );
    var_0.state_num = 0;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = get_broken_state_tags( var_0.model );

    for ( var_5 = 1; var_5 < var_4.size; var_5++ )
        var_0 _meth_8048( var_4[var_5], var_0.model );

    var_6 = [];
    var_6[0] = 125;
    var_6[1] = 125;
    var_6[2] = 125;
    var_6[3] = 125;
    var_0.door_state_health = var_6[0];
    childthread monitor_player_damage( var_1, var_0, var_4, var_6 );
    childthread monitor_car_door_shield_damage( var_1, var_0, var_4, var_6 );
}

monitor_player_damage( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        var_0 waittill( "riotshield_hit", var_4, var_5 );
        handle_car_door_shield_damage( var_0, var_1, var_2, var_3, var_4, var_5.origin, var_5.angles );
        waitframe();
    }
}

monitor_car_door_shield_damage( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        var_0 waittill( "car_door_shield_damaged", var_4, var_5, var_6 );
        handle_car_door_shield_damage( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
        waitframe();
    }
}

handle_car_door_shield_damage( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( is_current_weapon_shield( var_0 _meth_8311() ) )
    {
        [var_8, var_9, var_10] = var_1 get_closest_on_glass_plane( var_5 );
        var_11 = 0;

        if ( var_1.state_num < var_2.size - 1 )
        {
            var_1.door_state_health -= var_4;

            if ( var_1.door_state_health <= 0 )
            {
                var_11 = 1;
                var_1.state_num++;

                if ( var_1.state_num != var_2.size - 1 )
                {
                    var_12 = 0.4 + randomfloat( 100 ) * 0.01 * 0.25;
                    var_13 = 0.2 + randomfloat( 100 ) * 0.01 * 0.5;
                    earthquake( var_12, var_13, var_0.origin, 100 );
                    playfx( common_scripts\utility::getfx( "seo_suv_doorshield_hit" ), var_8, var_9, var_10 );
                    level.player notify( "doorshield_hit" );
                }
                else
                {
                    playfx( common_scripts\utility::getfx( "seo_suv_doorshield_hit_break" ), var_8, var_9, var_10 );
                    earthquake( 1.2, 0.75, level.player.origin, 100 );
                    level.player notify( "car_door_broken" );
                    soundscripts\_snd::snd_message( "car_door_broken" );
                }

                foreach ( var_15 in var_2 )
                    var_1 _meth_8048( var_15, var_1.model );

                var_1 _meth_804B( var_2[var_1.state_num], var_1.model );
                var_1.door_state_health = var_3[var_1.state_num];
                waitframe();
            }
        }

        if ( !var_11 )
        {
            var_12 = 0.3 + randomfloat( 100 ) * 0.01 * 0.25;
            var_13 = 0.2 + randomfloat( 100 ) * 0.01 * 0.5;
            earthquake( var_12, var_13, var_0.origin, 100 );
            playfx( common_scripts\utility::getfx( "large_glass_1" ), var_8, var_9, var_10 );
        }
    }
}

get_closest_on_glass_plane( var_0 )
{
    var_1 = var_0;
    var_2 = level.player getangles();
    var_3 = anglestoforward( var_2 );
    var_4 = level.player _meth_80A8();
    var_4 += var_3 * 15;
    var_5 = vectordot( var_3, var_1 - var_4 );
    var_6 = var_1 - var_5 * var_3;
    return [ var_6, var_3, anglestoup( var_2 ) ];
}

get_origin_and_dir_on_glass_plane( var_0, var_1 )
{
    var_2 = level.player getangles();
    var_3 = anglestoforward( var_2 );
    var_4 = level.player _meth_80A8();
    var_4 += var_3 * 15;
    var_5 = var_4 - var_0;
    var_6 = anglestoforward( var_1 );
    var_7 = vectordot( var_6, var_3 );

    if ( var_7 == 0 )
        return [ var_0, var_3, anglestoup( var_2 ) ];

    var_8 = vectordot( var_5, var_3 ) / var_7;
    return [ var_0 + var_6 * var_8, var_3, anglestoup( var_2 ) ];
}

delete_weapon_on_notify( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "door_weapon_removed" );
    self waittill( "remove_car_doors" );

    if ( self _meth_8314( var_1 ) )
        self _meth_830F( var_1 );

    self _meth_8315( self.cardoor_old_weapon );
    var_0 delete();
}

handle_car_door_throw_hint()
{
    level.player endon( "death" );
    level.player endon( "kill_throw_monitor" );
    level.player endon( "donot_show_throw_hint" );
    level waittill( "player_owns_cardoor_shield" );
    maps\_utility::hintdisplaymintimehandler( "hint_door_throw", 5 );
}

should_break_on_throw()
{
    if ( common_scripts\utility::flag( "player_has_cardoor" ) )
        return 0;
    else
        return 1;
}

delete_nearest_car_door_vehicle_collision()
{
    var_0 = getentarray( "car_door_vehicle_clip", "targetname" );
    var_1 = common_scripts\utility::array_sort_by_handler( var_0, ::distance_from_player );

    if ( isdefined( var_1[0] ) )
        var_1[0] delete();
}

distance_from_player()
{
    return distance( level.player.origin, self.origin );
}
