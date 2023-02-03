// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    init_variable_grenade();
    give_player_variable_grenade();
}

init_variable_grenade()
{
    if ( isdefined( level.player.variable_grenade ) )
        return;

    var_0["normal"][0] = "tracking_grenade_var";
    var_0["normal"][1] = "contact_grenade_var";
    var_0["normal"][2] = "frag_grenade_var";
    var_0["special"][0] = "paint_grenade_var";
    var_0["special"][1] = "flash_grenade_var";
    var_0["special"][2] = "emp_grenade_var";
    level.player.variable_grenade = var_0;
    var_1 = [];
    var_1["frag_grenade_var"] = 1;
    var_1["contact_grenade_var"] = 2;
    var_1["tracking_grenade_var"] = 3;
    var_1["paint_grenade_var"] = 4;
    var_1["flash_grenade_var"] = 5;
    var_1["emp_grenade_var"] = 6;
    level.player.variable_grenade_ui_type = var_1;
    common_scripts\utility::flag_init( "variable_grenade_switch" );
    level.player.detection_grenade_range = 1000;
    level.player.detection_grenade_sweep_time = 1.75;
    level.player.detection_grenade_duration = 15;
    level.player.threat_detection_style = "enhanceable";

    foreach ( var_3 in [ "normal", "special" ] )
    {
        foreach ( var_5 in var_0[var_3] )
            precacheshellshock( var_5 );
    }

    precacheshellshock( "smart_grenade" );
    precachemodel( "npc_variable_grenade_lethal" );
    var_8 = getspawnerteamarray( "axis" );

    if ( var_8.size > 0 )
        maps\_utility::array_spawn_function( var_8, ::handle_detection );

    handle_detection_spawners();
    init_grenade_hints();
    precache_var_grenade_fx();
    level.player thread target_enhancer_think();
}

handle_detection_spawners()
{
    var_0 = vehicle_getspawnerarray();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_team ) && var_3.script_team == "axis" )
        {
            if ( isdefined( var_3.script_parameters ) && issubstr( var_3.script_parameters, "threat_detectable" ) )
            {
                var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
                continue;
            }

            if ( issubstr( var_3.classname, "pdrone" ) )
                var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
        }
    }

    if ( var_1.size > 0 )
        maps\_utility::array_spawn_function( var_1, ::handle_detection );

    var_5 = getentarray( "script_vehicle_pdrone_kva", "classname" );

    if ( var_5.size > 0 )
        maps\_utility::array_spawn_function( var_5, ::handle_detection );

    var_6 = getentarray( "enemy_walker", "targetname" );

    if ( var_6.size > 0 )
        maps\_utility::array_spawn_function_targetname( "enemy_walker", ::handle_detection );

    foreach ( var_8 in getentarray( "actor_enemy_dog", "classname" ) )
    {
        if ( isspawner( var_8 ) )
        {
            var_8 maps\_utility::add_spawn_function( ::handle_detection );
            continue;
        }

        var_8 thread handle_detection();
    }
}

give_player_variable_grenade()
{
    init_variable_grenade();
    var_0 = 0;
    var_1 = level.player getweaponslistoffhands();

    if ( !isdefined( var_1 ) || var_1.size == 0 )
        var_0 = 1;
    else
    {
        foreach ( var_3 in var_1 )
        {
            if ( !isdefined( level.player get_index_for_weapon_name( var_3 ) ) )
            {
                var_0 = 1;
                break;
            }
        }
    }

    if ( var_0 )
    {
        foreach ( var_3 in level.player getweaponslistoffhands() )
            level.player takeweapon( var_3 );

        level.player setlethalweapon( level.player.variable_grenade["normal"][0] );
        level.player giveweapon( level.player.variable_grenade["normal"][0] );
        level.player settacticalweapon( level.player.variable_grenade["special"][0] );
        level.player giveweapon( level.player.variable_grenade["special"][0] );
    }

    common_scripts\utility::flag_set( "variable_grenade_switch" );
    level.player thread monitor_grenade_fire();
    level.player thread monitor_offhand_cycle();
}

set_variable_grenades_with_no_switch( var_0, var_1 )
{
    foreach ( var_3 in level.player getweaponslistoffhands() )
        level.player takeweapon( var_3 );

    level.player setlethalweapon( var_0 );
    level.player giveweapon( var_0 );
    level.player settacticalweapon( var_1 );
    level.player giveweapon( var_1 );
    common_scripts\utility::flag_clear( "variable_grenade_switch" );
}

get_mode_for_weapon_name( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_1 = undefined;

    foreach ( var_3 in [ "normal", "special" ] )
    {
        if ( common_scripts\utility::array_contains( self.variable_grenade[var_3], var_0 ) )
        {
            var_1 = var_3;
            break;
        }
    }

    return var_1;
}

get_index_for_weapon_name( var_0 )
{
    var_1 = get_mode_for_weapon_name( var_0 );

    if ( !isdefined( var_1 ) )
        return undefined;

    foreach ( var_4, var_3 in self.variable_grenade[var_1] )
    {
        if ( var_3 == var_0 )
            return var_4;
    }
}

monitor_grenade_fire()
{
    self endon( "death" );
    self notify( "new_monitor_grenade_fire" );
    self endon( "new_monitor_grenade_fire" );

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        var_2 = get_mode_for_weapon_name( var_1 );

        if ( !isdefined( var_2 ) )
        {
            waitframe();
            continue;
        }

        foreach ( var_4 in [ "normal", "special" ] )
        {
            if ( common_scripts\utility::array_contains( self.variable_grenade[var_4], var_1 ) )
                thread hide_grenade_hints();
        }

        if ( issubstr( var_1, "emp_grenade_var" ) )
        {
            var_0 thread emp_grenade_think( self );
            continue;
        }

        if ( issubstr( var_1, "paint_grenade_var" ) )
        {
            var_0 thread detection_grenade_think( self );
            continue;
        }

        if ( issubstr( var_1, "tracking_grenade_var" ) )
            var_0 thread tracking_grenade_think( self );
    }
}

grenade_ui_on( var_0 )
{
    if ( isdefined( level.player.variable_grenade_ui_enabled ) )
        return;

    level.player.variable_grenade_ui_enabled = 1;
    setomnvar( "ui_grenade_screen", 1 );

    if ( common_scripts\utility::flag( "variable_grenade_switch" ) )
        thread show_grenade_hint( var_0 );
}

grenade_ui_off()
{
    if ( !isdefined( level.player.variable_grenade_ui_enabled ) )
        return;

    level.player.variable_grenade_ui_enabled = undefined;
    setomnvar( "ui_grenade_screen", 0 );

    if ( common_scripts\utility::flag( "variable_grenade_switch" ) )
        thread hide_grenade_hints();
}

monitor_offhand_cycle()
{
    self endon( "death" );
    self notify( "new_monitor_offhand_cycle" );
    self endon( "new_monitor_offhand_cycle" );
    var_0 = [ "current", "previous" ];
    var_0["previous"] = spawnstruct();
    var_0["current"] = spawnstruct();
    var_0["current"].is_switching = 0;
    var_0["current"].is_holding = 0;
    var_0["current"].is_prepping = 0;
    childthread monitor_cycle_direction();
    childthread monitor_speech_action();

    for (;;)
    {
        var_1 = var_0["previous"];
        var_0["previous"] = var_0["current"];
        var_0["current"] = var_1;
        var_2 = self getcurrentoffhand();
        var_3 = get_mode_for_weapon_name( var_2 );

        if ( !isdefined( var_3 ) )
        {
            grenade_ui_off();
            waitframe();
            continue;
        }

        var_0["current"].is_prepping = self ispreparinggrenade();
        var_0["current"].is_holding = self isholdinggrenade() || self ispreparinggrenade() || self isswitchinggrenade();
        var_0["current"].is_switching = var_0["current"].is_holding && ( self usebuttonpressed() || self.grenade_cycle_next );
        var_4 = var_0["current"].is_prepping && !var_0["previous"].is_prepping;
        var_5 = var_0["current"].is_switching && !var_0["previous"].is_switching;
        var_6 = var_0["current"].is_holding && !var_0["previous"].is_holding;
        var_7 = !var_0["current"].is_holding && var_0["previous"].is_holding;

        if ( common_scripts\utility::flag( "variable_grenade_switch" ) && var_0["current"].is_holding && var_5 )
            cycle_offhand_grenade();

        self.grenade_cycle_next = 0;

        if ( var_4 )
            grenade_ui_on( var_3 );
        else if ( var_7 )
            grenade_ui_off();

        if ( var_4 || var_6 || var_5 )
        {
            var_2 = self getcurrentoffhand();
            var_8 = level.player.variable_grenade_ui_type[var_2];
            setomnvar( "ui_grenade_type", var_8 );
        }

        waitframe();
    }
}

monitor_cycle_direction()
{
    self.grenade_cycle_next = 0;

    if ( isdefined( level.ps4 ) && level.ps4 )
    {
        for (;;)
        {
            var_0 = self getnormalizedflick();

            if ( lengthsquared( var_0 ) > 0 )
            {
                if ( abs( var_0[0] ) > abs( var_0[1] ) )
                {
                    if ( var_0[0] < 0 )
                        self.grenade_cycle_next = 1;
                    else
                        self.grenade_cycle_next = 4;
                }
                else if ( var_0[1] < 0 )
                    self.grenade_cycle_next = 3;
                else
                    self.grenade_cycle_next = 2;

                waitframe();
            }

            waitframe();
        }
    }
}

monitor_speech_action()
{
    if ( isdefined( level.xb3 ) && level.xb3 )
    {
        for (;;)
        {
            self waittill( "speechCommand", var_0, var_1 );

            if ( var_0 > 0.7 && ( self isholdinggrenade() || self ispreparinggrenade() || self isswitchinggrenade() ) )
            {
                var_2 = undefined;
                var_3 = undefined;
                var_4 = undefined;
                var_5 = self getcurrentoffhand();

                if ( !isdefined( var_5 ) )
                    continue;

                var_6 = get_mode_for_weapon_name( var_5 );

                if ( !isdefined( var_6 ) )
                    continue;

                switch ( var_1 )
                {
                    case "next_var":
                        var_2 = var_6;
                        var_7 = get_index_for_weapon_name( var_5 );
                        var_3 = ( var_7 + 1 ) % self.variable_grenade[var_6].size;
                        var_8 = self.variable_grenade[var_6][var_3];
                        var_4 = level.player.variable_grenade_ui_type[var_8];
                        break;
                    case "previous_var":
                        var_2 = var_6;
                        var_7 = get_index_for_weapon_name( var_5 );
                        var_3 = var_7 - 1;

                        if ( var_3 < 0 )
                            var_3 = self.variable_grenade[var_6].size - 1;

                        var_8 = self.variable_grenade[var_6][var_3];
                        var_4 = level.player.variable_grenade_ui_type[var_8];
                        break;
                    case "frag_var":
                        var_2 = get_mode_for_weapon_name( "frag_grenade_var" );
                        var_3 = get_index_for_weapon_name( "frag_grenade_var" );
                        var_4 = level.player.variable_grenade_ui_type["frag_grenade_var"];
                        break;
                    case "smart_var":
                        var_2 = get_mode_for_weapon_name( "tracking_grenade_var" );
                        var_3 = get_index_for_weapon_name( "tracking_grenade_var" );
                        var_4 = level.player.variable_grenade_ui_type["tracking_grenade_var"];
                        break;
                    case "emp_var":
                        var_2 = get_mode_for_weapon_name( "emp_grenade_var" );
                        var_3 = get_index_for_weapon_name( "emp_grenade_var" );
                        var_4 = level.player.variable_grenade_ui_type["emp_grenade_var"];
                        break;
                    case "contact_var":
                        var_2 = get_mode_for_weapon_name( "contact_grenade_var" );
                        var_3 = get_index_for_weapon_name( "contact_grenade_var" );
                        var_4 = level.player.variable_grenade_ui_type["contact_grenade_var"];
                        break;
                    case "flash_var":
                        var_2 = get_mode_for_weapon_name( "flash_grenade_var" );
                        var_3 = get_index_for_weapon_name( "flash_grenade_var" );
                        var_4 = level.player.variable_grenade_ui_type["flash_grenade_var"];
                        break;
                    case "threat_var":
                        var_2 = get_mode_for_weapon_name( "paint_grenade_var" );
                        var_3 = get_index_for_weapon_name( "paint_grenade_var" );
                        var_4 = level.player.variable_grenade_ui_type["paint_grenade_var"];
                        break;
                }

                if ( isdefined( var_2 ) && var_2 == var_6 )
                {
                    if ( isdefined( var_3 ) )
                    {
                        handle_weapon_switch( var_2, var_3 );
                        soundscripts\_snd::snd_message( "variable_grenade_type_switch", var_3 );
                    }

                    if ( isdefined( var_4 ) )
                        setomnvar( "ui_grenade_type", var_4 );
                }
            }
        }
    }
}

cycle_offhand_grenade()
{
    var_0 = self getcurrentoffhand();

    if ( isdefined( var_0 ) )
    {
        var_1 = get_mode_for_weapon_name( var_0 );
        var_2 = get_index_for_weapon_name( var_0 );

        if ( isdefined( var_1 ) && isdefined( var_2 ) )
        {
            var_3 = var_2;

            if ( self.grenade_cycle_next > 0 && self.grenade_cycle_next - 1 < self.variable_grenade[var_1].size )
                var_3 = self.grenade_cycle_next - 1;
            else if ( self.grenade_cycle_next == 0 )
                var_3 = ( var_2 + 1 ) % self.variable_grenade[var_1].size;

            if ( var_3 != var_2 )
            {
                handle_weapon_switch( var_1, var_3 );
                soundscripts\_snd::snd_message( "variable_grenade_type_switch", var_3 );
                return;
            }

            return;
        }

        return;
    }
    else
    {

    }
}

handle_weapon_switch( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in self getweaponslistoffhands() )
    {
        if ( common_scripts\utility::array_contains( self.variable_grenade[var_0], var_4 ) )
        {
            var_2 = int( max( var_2, self setweaponammostock( var_4 ) ) );
            self takeweapon( var_4 );
        }
    }

    if ( var_0 == "special" )
        self settacticalweapon( self.variable_grenade[var_0][var_1] );
    else
        self setlethalweapon( self.variable_grenade[var_0][var_1] );

    self giveweapon( self.variable_grenade[var_0][var_1] );
    self setweaponammostock( self.variable_grenade[var_0][var_1], var_2 );
}

init_grenade_hints()
{
    precachestring( &"VARIABLE_GRENADE_HINT_CYCLE_LETHAL" );
    precachestring( &"VARIABLE_GRENADE_HINT_CYCLE_TACTICAL" );
}

show_grenade_hint( var_0 )
{
    level.player notify( "show_grenade_hint_stop" );

    if ( isdefined( level.player.grenadecyclehint ) )
        level.player.grenadecyclehint destroy();

    level.player endon( "show_grenade_hint_stop" );
    level.player endon( "death" );
    var_1 = 1.0;
    var_2 = 0.75;
    var_3 = 0.95;
    var_4 = 0.4;
    var_5 = maps\_hud_util::createclientfontstring( "objective", 2 );
    level.player.grenadecyclehint = var_5;
    level.player.grenadecyclehint endon( "stop_hint" );
    var_5.alpha = 0.9;
    var_5.x = 225;
    var_5.y = 150;
    var_5.alignx = "center";
    var_5.aligny = "middle";
    var_5.horzalign = "center";
    var_5.vertalign = "middle";
    var_5.foreground = 0;
    var_5.hidewhendead = 1;
    var_6 = &"VARIABLE_GRENADE_HINT_CYCLE_LETHAL";

    if ( var_0 == "special" )
        var_6 = &"VARIABLE_GRENADE_HINT_CYCLE_TACTICAL";

    var_5 settext( var_6 );
    var_5.alpha = 0;
    var_5 fadeovertime( var_1 );
    var_5.alpha = var_3;
    wait(var_1);

    for (;;)
    {
        var_5 fadeovertime( var_2 );
        var_5.alpha = var_4;
        wait(var_2);
        var_5 fadeovertime( var_2 );
        var_5.alpha = var_3;
        wait(var_2);
    }
}

hide_grenade_hints()
{
    level.player notify( "show_grenade_hint_stop" );

    if ( !isdefined( level.player.grenadecyclehint ) || isremovedentity( level.player.grenadecyclehint ) )
        return;

    level.player.grenadecyclehint destroy();
}

precache_var_grenade_fx()
{
    level._effect["paint_grenade"] = loadfx( "vfx/explosion/paint_grenade" );
    level._effect["emp_grenade"] = loadfx( "vfx/explosion/emp_grenade_explosion" );
    level._effect["tracking_grenade_spray_large"] = loadfx( "vfx/trail/tracking_grenade_hovering" );
    level._effect["tracking_grenade_spray_small"] = loadfx( "vfx/trail/tracking_grenade_spay_small" );
    level._effect["tracking_grenade_spray_large_homing"] = loadfx( "vfx/trail/tracking_grenade_trail" );
    level._effect["tracking_grenade_homing"] = loadfx( "vfx/trail/tracking_grenade_geotrail" );
    level._effect["tracking_grenade_impact"] = loadfx( "vfx/explosion/smart_grenade_explosion" );
    level._effect["tracking_grenade_water_impact_0"] = loadfx( "vfx/explosion/smart_grenade_water_impact_01" );
    level._effect["tracking_grenade_water_impact_1"] = loadfx( "vfx/explosion/smart_grenade_water_impact_02" );
    level._effect["tracking_grenade_water_impact_2"] = loadfx( "vfx/explosion/smart_grenade_water_impact_03" );
    level._effect["tracking_grenade_default_impact_0"] = loadfx( "vfx/explosion/smart_grenade_default_impact_01" );
    level._effect["tracking_grenade_default_impact_1"] = loadfx( "vfx/explosion/smart_grenade_default_impact_02" );
    level._effect["tracking_grenade_default_impact_2"] = loadfx( "vfx/explosion/smart_grenade_default_impact_03" );
}

emp_notify_on_target_hit( var_0, var_1 )
{
    for (;;)
    {
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( var_6 == "MOD_IMPACT" && isplayer( var_3 ) && var_11 == "emp_grenade_var" )
        {
            var_0 notify( var_1 );
            break;
        }
    }
}

emp_wait_till_contact_or_timeout( var_0 )
{
    var_1 = "wait_till_contact_or_timeout_stop";
    self endon( var_1 );
    self endon( "death" );
    var_2 = level.emp_vulnerable_list;

    if ( isdefined( var_2 ) && var_2.size > 0 )
    {
        foreach ( var_4 in level.emp_vulnerable_list )
        {
            if ( isdefined( var_4 ) )
                var_4 childthread emp_notify_on_target_hit( self, var_1 );
        }
    }

    wait(var_0);
    self notify( var_1 );
}

emp_grenade_think( var_0 )
{
    self endon( "death" );
    emp_wait_till_contact_or_timeout( 1 );
    var_1 = 500;
    var_2 = self.origin;
    var_3 = 500;
    playfx( common_scripts\utility::getfx( "emp_grenade" ), var_2 );
    soundscripts\_snd::snd_message( "emp_grenade_detonate" );

    if ( isdefined( var_0.team ) )
        maps\_dds::dds_notify( "react_emp", var_0.team != "allies" );

    if ( !isdefined( level.emp_vulnerable_list ) )
    {
        self delete();
        return;
    }

    var_4 = level.emp_vulnerable_list;

    foreach ( var_6 in var_4 )
    {
        if ( !isdefined( var_6 ) )
            continue;

        if ( var_6 damageconetrace( var_2, self ) )
        {
            if ( distancesquared( var_6.origin, var_2 ) < var_1 * var_1 )
            {
                if ( isdefined( var_6.mech ) && var_6.mech )
                    maps\_utility::giveachievement_wrapper( "EMP_AST" );

                if ( isdefined( var_6.emp_death_function ) && !isdefined( var_6.processing_emp_death_function ) )
                {
                    if ( isdefined( var_6.vehicletype ) && var_6.vehicletype == "pdrone" )
                    {
                        if ( isplayer( var_0 ) )
                            var_0 maps\_player_stats::register_kill( self, "emp_grenade", "emp_grenade_var" );

                        var_7 = level.player getlocalplayerprofiledata( "ach_flySwatter" ) + 1;
                        level.player setlocalplayerprofiledata( "ach_flySwatter", var_7 );

                        if ( var_7 == 25 )
                            maps\_utility::giveachievement_wrapper( "EMP_DRONE" );
                    }

                    var_6.processing_emp_death_function = 1;
                    var_6 thread [[ var_6.emp_death_function ]]();
                    continue;
                }

                var_6 dodamage( var_3, var_2, var_0 );
            }
        }
    }

    self delete();
}

detection_grenade_think( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = level.player.detection_grenade_range;

    if ( !isdefined( var_2 ) )
        var_2 = level.player.detection_grenade_sweep_time;

    if ( !isdefined( var_3 ) )
    {
        if ( isdefined( level.player.detection_grenade_duration_bonus ) )
            var_3 = level.player.detection_grenade_duration + level.player.detection_grenade_duration_bonus;
        else
            var_3 = level.player.detection_grenade_duration;
    }

    wait 1;

    if ( isdefined( var_0 ) )
    {
        thread detection_grenade_hud_effect( var_0, var_1, var_2 );
        thread detection_highlight_hud_effect( var_0, var_3 );
    }

    playfx( common_scripts\utility::getfx( "paint_grenade" ), self.origin );
    soundscripts\_snd::snd_message( "paint_grenade_detonate" );
    self.enemies = getaiarray( "axis" );
    self.enemies = common_scripts\utility::array_combine( self.enemies, get_threat_detectables() );
    var_4 = "grenade";
    var_5 = 0;

    foreach ( var_7 in self.enemies )
    {
        if ( !isdefined( var_7 ) )
            continue;
        else if ( !isalive( var_7 ) )
        {
            if ( !var_7 is_valid_non_human_paint_target() )
                continue;
        }

        if ( distance( var_7.origin, self.origin ) < var_1 )
        {
            var_5++;
            self.detected[var_4] = 0;
            var_8 = distance( var_7.origin, self.origin ) * var_2 / var_1;
            var_7 maps\_utility::delaythread( var_8, ::handle_marking_guy, var_4, var_3 - var_8 );
        }
    }

    if ( var_5 >= 10 )
        maps\_utility::giveachievement_wrapper( "THREAT_GRENADE_KILL" );

    level.player notify( "threat_grenade_marking_started", self );
    waitframe();
    self delete();
}

get_threat_detectables()
{
    var_0 = [];
    var_0 = common_scripts\utility::array_combine( var_0, getentarray( "script_vehicle_pdrone_kva", "classname" ) );
    var_0 = common_scripts\utility::array_combine( var_0, getentarray( "script_vehicle_walker_tank", "classname" ) );
    var_0 = common_scripts\utility::array_combine( var_0, getentarray( "actor_enemy_dog", "classname" ) );
    var_1 = maps\_utility::getvehiclearray();

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.script_team ) && var_3.script_team == "axis" )
        {
            if ( isdefined( var_3.script_parameters ) && issubstr( var_3.script_parameters, "threat_detectable" ) )
                var_0 = common_scripts\utility::add_to_array( var_0, var_3 );
            else if ( issubstr( var_3.classname, "pdrone" ) )
                var_0 = common_scripts\utility::add_to_array( var_0, var_3 );

            if ( isdefined( var_3.mgturret ) )
            {
                foreach ( var_5 in var_3.mgturret )
                    var_0 = common_scripts\utility::add_to_array( var_0, var_5 );
            }
        }
    }

    return var_0;
}

detection_highlight_hud_effect_apply( var_0, var_1 )
{
    if ( !isdefined( var_0.detection_highlight_hud_effect ) )
    {
        var_0.detection_highlight_hud_effect = newclienthudelem( var_0 );
        var_0.detection_highlight_hud_effect.color = ( 0.2, 0.01, 0.01 );
        var_0.detection_highlight_hud_effect.alpha = 1.0;
    }

    var_0.detection_highlight_hud_effect setradarhighlight( var_1 );
}

detection_highlight_hud_effect_remove( var_0 )
{
    if ( isdefined( var_0.detection_highlight_hud_effect ) )
    {
        var_0.detection_highlight_hud_effect destroy();
        var_0.detection_highlight_hud_effect = undefined;
    }
}

change_threat_detection_style( var_0 )
{
    level.player.threat_detection_style = var_0;
    var_1 = getaiarray( "axis" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.pdrone_marked_state ) && !isdefined( var_3.pretending_to_be_dead ) )
            var_3 setthreatdetection( var_0 );
    }
}

detection_highlight_hud_effect( var_0, var_1 )
{
    var_0 notify( "detection_highlight_hud_effect" );
    var_0 endon( "detection_highlight_hud_effect" );
    detection_highlight_hud_effect_apply( var_0, var_1 );
    wait(var_1);
    detection_highlight_hud_effect_remove( var_0 );
}

detection_grenade_hud_effect( var_0, var_1, var_2 )
{
    var_3 = newclienthudelem( var_0 );
    var_3.x = self.origin[0];
    var_3.y = self.origin[1];
    var_3.z = self.origin[2];
    var_3.color = ( 0.2, 0.01, 0.01 );
    var_3.alpha = 0.1;
    var_4 = 500;
    var_3 setradarping( int( var_1 + var_4 / 2 ), int( var_4 ), var_2 + 0.05 );
    wait(var_2);
    var_3 destroy();
}

handle_detection()
{
    self notify( "handle_detection" );
    self endon( "handle_detection" );
    self endon( "death" );

    if ( maps\_vehicle::isvehicle() && isdefined( self.mgturret ) )
    {
        foreach ( var_1 in self.mgturret )
            var_1 thread handle_detection();
    }

    thread handle_detection_death();
    self.detected = [];
    var_3 = self.noragdoll;
    unmark_guy_fx();

    for (;;)
    {
        self waittill( "detected" );
        var_4 = 0;

        foreach ( var_6 in self.detected )
        {
            if ( var_6 )
                var_4++;
        }

        if ( var_4 == 1 )
        {
            var_3 = self.noragdoll;
            self.noragdoll = 1;
            mark_guy_fx();
        }

        var_8 = 1;

        while ( var_8 )
        {
            self waittill( "no_longer_detected" );
            var_8 = 0;

            if ( self.detected.size == 0 )
            {
                unmark_guy_fx();
                self.mark_fx = undefined;
                self.noragdoll = var_3;
                continue;
            }

            var_8 = 1;
        }
    }
}

handle_marking_guy( var_0, var_1 )
{
    self endon( "death" );
    self notify( "marking_" + var_0 );
    self endon( "marking_" + var_0 );
    self.detected[var_0] = 1;
    self notify( "detected" );

    if ( isdefined( var_1 ) )
    {
        wait(var_1);
        unmark_guy( var_0 );
    }
}

unmark_guy( var_0 )
{
    self.detected[var_0] = undefined;
    self notify( "no_longer_detected" );
}

mark_guy_fx()
{
    if ( isdefined( self.pretending_to_be_dead ) )
        return;

    self.pdrone_marked_state = "marked";
    self setthreatdetection( "detected" );
}

unmark_guy_fx()
{
    if ( isdefined( self ) )
    {
        if ( isalive( self ) )
        {
            self.pdrone_marked_state = undefined;
            self setthreatdetection( level.player.threat_detection_style );
        }
        else
            self setthreatdetection( "disabled" );
    }
}

clear_guy_fx()
{
    if ( isdefined( self ) )
        self setthreatdetection( "disable" );
}

handle_detection_death()
{
    common_scripts\utility::waittill_any( "death", "emp_death" );
    var_0 = undefined;
    clear_guy_fx();
}

is_valid_non_human_paint_target()
{
    return self.code_classname == "script_vehicle";
}

tracking_grenade_think( var_0 )
{
    var_1 = 35;
    var_2 = 20;
    var_3 = 195;
    var_4 = 0.5;
    var_5 = 1.0;
    var_6 = 2.5;
    var_7 = var_0 get_smart_grenade_timer();
    var_8 = var_7 * 0.5;
    var_9 = 0.35;
    var_10 = 88.0;
    var_11 = 7;
    var_12 = 2112.0;
    var_13 = 2;
    var_14 = 0.05;
    var_15 = ( 0, 0, -300 * var_14 );
    var_16 = 3000 * var_14;
    var_17 = 600 * var_14;
    var_18 = 0.2;
    var_19 = 0.6;
    var_20 = 2;
    var_21 = sin( 2 );
    var_22 = 0.05;
    var_23 = make_tracking_grenade( self );
    var_23 thread tracking_grenade_handle_damage( var_0 );
    var_23 thread tracking_grenade_handle_autosave( var_0 );
    var_24 = common_scripts\utility::spawn_tag_origin();
    var_24 linkto( var_23, "", ( 0, 0, 0 ), ( -90, 0, 0 ) );
    var_25 = level.player geteye();
    var_26 = anglestoforward( level.player getgunangles() );
    var_27 = bullettrace( var_25, var_25 + var_26 * 7000, 0, var_23 );
    var_28 = var_27["position"];
    var_29 = ( var_26 + ( 0, 0, 0.2 ) ) * 50 * 17.6;
    var_30 = ( 0, 0, 0 );
    var_31 = undefined;
    var_32 = ( 0, 0, 0 );
    var_33 = ( 0, 0, 0 );
    var_34 = 0;
    var_35 = 0;
    var_36 = 0;
    var_37 = 0;
    soundscripts\_snd::snd_message( "tracking_grenade_hover", var_23 );

    for ( var_38 = 0; var_38 < var_11; var_38 += 0.05 )
    {
        if ( !isdefined( var_31 ) || !isalive( var_31 ) || var_38 <= var_8 )
        {
            var_31 = var_23 tracking_grenade_get_target( var_0 );

            if ( isdefined( var_31 ) && isdefined( var_31.team ) )
                var_31 maps\_dds::dds_notify( "react_smart", var_31.team == "allies" );
        }

        if ( var_38 > var_7 && isdefined( var_31 ) && !var_34 )
        {
            var_34 = 1;
            tracking_grenade_scare_enemies( var_31.origin );
        }

        if ( var_38 > var_8 && isdefined( var_31 ) && !var_35 )
        {
            var_35 = 1;
            soundscripts\_snd::snd_message( "tracking_grenade_beep", var_23 );
        }

        if ( var_38 > var_7 )
        {
            if ( isdefined( var_31 ) )
                var_28 = var_31.origin + var_31 get_npc_center_offset();
        }
        else
        {
            var_25 = level.player geteye();
            var_26 = anglestoforward( level.player getgunangles() );
            var_27 = bullettrace( var_25, var_25 + var_26 * 7000, 0, var_23 );
            var_39 = var_27["position"];

            if ( distancesquared( var_39, var_0.origin ) > distancesquared( var_23.origin, var_0.origin ) )
                var_28 = var_39;
        }

        if ( var_38 > var_7 )
        {
            if ( vectordot( var_28 - var_23.origin, var_28 - var_0.origin ) < 0 )
                break;

            if ( !var_36 )
            {
                var_36 = 1;
                playfxontag( common_scripts\utility::getfx( "tracking_grenade_homing" ), var_24, "tag_origin" );
                soundscripts\_snd::snd_message( "tracking_grenade_jump", var_23 );
            }

            var_40 = maps\_shg_utility::linear_map_clamp( var_38 - var_7 - var_9, 0, var_13, 0, var_12 );
            var_30 = vectornormalize( var_28 - var_23.origin ) * var_40;

            if ( var_38 < var_7 + var_9 && bullettracepassed( var_23.origin, var_23.origin + ( 0, 0, var_10 * var_9 ), 0, undefined ) )
                var_30 = ( 0, 0, var_10 );
            else if ( !var_37 )
            {
                var_37 = 1;
                soundscripts\_snd::snd_message( "tracking_grenade_strike", var_23 );
            }
        }
        else
        {
            var_25 = var_0 geteye();

            if ( var_38 < var_8 || !isdefined( var_31 ) )
                var_41 = var_0 getgunangles();
            else
                var_41 = ( 0, vectortoyaw( var_23.origin - var_25 ), 0 );

            var_26 = anglestoforward( var_41 );
            var_26 = ( var_26[0], var_26[1], var_26[2] * var_4 );
            var_42 = anglestoright( var_41 );
            var_43 = -1 * common_scripts\utility::sign( vectordot( var_25 - var_23.origin, var_42 ) );
            var_44 = var_25 + var_26 * var_3 + ( 0, 0, var_1 ) + var_42 * ( var_43 * var_2 );
            var_45 = var_44 - var_23.origin;

            if ( isplayer( var_0 ) && var_0 fragbuttonpressed() )
                var_46 = var_6;
            else
                var_46 = var_5;

            var_30 = var_45 * var_46;
        }

        var_30 += getsmoothrandomvector( 52.8, 1 );
        var_47 = vectorclamp( ( var_30 - var_29 ) * var_19 - var_15, var_16 );
        var_47 = vectorlerp( var_47, var_32, var_18 );
        var_33 += var_47;
        var_33 += common_scripts\utility::randomvector( var_22 * length( var_33 ) );
        var_48 = length( var_33 );

        if ( var_48 > 0 )
        {
            var_49 = anglestoup( var_23.angles );
            var_23.angles = combineangles( vectortoangles( var_33 ), ( 90, 0, 0 ) );
            var_50 = vectornormalize( var_33 );
            var_51 = vectorcross( var_50, var_49 );
            var_52 = vectorcross( var_50, var_51 );
            var_53 = length( var_52 );

            if ( var_53 > var_21 )
            {
                var_23 tracking_grenade_thrust_effect( var_52, "tracking_grenade_spray_small", var_50 * var_20 );

                if ( var_53 > 2 * var_21 )
                    var_23 tracking_grenade_thrust_effect( -1 * var_52, "tracking_grenade_spray_small", var_50 * ( var_20 * -1 ) );
            }

            if ( var_48 > var_17 )
            {
                if ( var_38 > var_7 )
                    var_54 = "tracking_grenade_spray_large_homing";
                else
                    var_54 = "tracking_grenade_spray_large";

                playfxontag( common_scripts\utility::getfx( var_54 ), var_24, "tag_origin" );
                var_33 = ( 0, 0, 0 );
                var_29 += vectorclamp( var_47, var_16, var_17 );
            }

            var_29 += var_15;
        }

        var_33 = ( 0, 0, 0 );
        var_55 = var_23.origin + var_29 * 0.05;
        var_56 = bullettrace( var_23.origin, var_55, 1, var_0, 0, 1, 0, 0, 1 );

        if ( isdefined( var_56["glass"] ) )
        {
            destroyglass( var_56["glass"], vectornormalize( var_29 ) );
            var_56 = bullettrace( var_23.origin, var_55, 1, var_0, 0, 1, 0, 0, 1 );
        }

        if ( isdefined( var_56["entity"] ) && isdefined( var_56["entity"].linked_player ) && var_56["entity"].linked_player == var_0 )
        {

        }
        else if ( var_56["fraction"] < 1 )
            break;

        var_23.origin = var_55;
        var_32 = var_47;
        wait 0.05;
    }

    var_23 tracking_grenade_detonate( var_0, var_29, var_24 );
}

get_smart_grenade_timer()
{
    if ( isplayer( self ) )
    {
        var_0 = self getcurrentweapon();

        if ( isdefined( var_0 ) && issubstr( var_0, "microdronelaunchersmartgrenade" ) )
            return 0.1;
    }

    return 1;
}

safe_str( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        if ( isarray( var_0 ) )
        {
            var_1 = "(array ";

            foreach ( var_4, var_3 in var_0 )
                var_1 += ( var_4 + " -> " + safe_str( var_3 ) + "\\n" );

            var_1 += ")";
            return var_1;
        }

        if ( isremovedentity( var_0 ) )
            return "" + var_0;

        if ( isdefined( var_0.code_classname ) )
        {
            var_1 = "(entity $e" + var_0 getentitynumber() + " code_classname: \"" + var_0.code_classname + "\"";

            if ( isspawner( var_0 ) )
                var_1 += " (spawner)";
        }
        else
            var_1 = "(object";

        if ( isdefined( var_0.targetname ) )
            var_1 += ( " targetname: \"" + var_0.targetname + "\"" );

        if ( isdefined( var_0.script_noteworthy ) )
            var_1 += ( " script_noteworthy: \"" + var_0.script_noteworthy + "\"" );

        if ( isdefined( var_0.classname ) )
            var_1 += ( " classname: \"" + var_0.classname + "\"" );

        var_1 += ")";
        return var_1;
    }

    if ( isremovedentity( var_0 ) )
        return "(removed entity)";

    if ( var_0 == undefined )
        return "(undefined)";
}

tracking_grenade_detonate( var_0, var_1, var_2 )
{
    var_3 = 150;
    var_4 = 128;
    var_5 = 1000;
    var_6 = 50;
    self notify( "tracking_grenade_deactivate" );

    if ( distance( var_0.origin, self.origin ) > var_3 )
    {
        radiusdamage( self.origin, var_4, var_5, var_6, var_0, "MOD_GRENADE", "tracking_grenade_var", 1 );
        playfx( common_scripts\utility::getfx( "tracking_grenade_impact" ), self.origin );
        soundscripts\_snd::snd_message( "smart_grenade_detonate" );
        thread play_tracking_grenade_impacts( 300, self.origin );
        var_2 delete();
        self delete();
    }
    else
    {
        self physicslaunchserver( self.origin + common_scripts\utility::randomvector( 10 ), var_1 * 0.1 * 0.25 );
        soundscripts\_snd::snd_message( "tracking_grenade_dud", self );

        for ( var_7 = 0; var_7 < 5; var_7++ )
        {
            playfxontag( common_scripts\utility::getfx( "tracking_grenade_spray_large" ), var_2, "tag_origin" );
            wait(randomfloatrange( 0.05, 0.3 ));
        }

        var_2 delete();
        thread tracking_grenade_pickup( var_0 );
        wait 30;

        if ( isdefined( self ) )
            self delete();
    }
}

tracking_grenade_pickup( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    self endon( "death" );
    var_1 = spawn( "trigger_radius", self.origin, 0, 15, 5 );
    var_1 enablelinkto();
    var_1 linkto( self );
    thread common_scripts\utility::delete_on_death( var_1 );

    for (;;)
    {
        var_1 waittill( "trigger", var_2 );

        if ( var_2 == var_0 && var_2 setweaponammostock( "tracking_grenade_var" ) < weaponmaxammo( "tracking_grenade_var" ) )
            break;
    }

    var_0 setweaponammostock( "tracking_grenade_var", var_0 setweaponammostock( "tracking_grenade_var" ) + 1 );
    self delete();
}

play_tracking_grenade_impacts( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < 20; var_2++ )
    {
        wait 0.01;
        var_3 = "tracking_grenade_water_impact_" + randomintrange( 0, 2 );
        var_4 = "tracking_grenade_default_impact_" + randomintrange( 0, 2 );
        var_5 = ( randomfloat( 2 ) - 1, randomfloat( 2 ) - 1, randomfloat( -1 ) );
        var_6 = 32 * var_5 + var_1;
        var_7 = var_0 * var_5 + var_1;
        var_8 = bullettrace( var_6, var_7, 0, undefined, 0, 0, 1, 0, 0 );

        if ( isdefined( var_8 ) && var_8["surfacetype"] != "none" )
        {
            if ( distance( var_6, var_8["position"] ) > 5 )
            {
                if ( iswatersurface( var_8["surfacetype"] ) )
                {
                    playfx( common_scripts\utility::getfx( var_3 ), var_8["position"], var_8["normal"] );
                    continue;
                }

                playfx( common_scripts\utility::getfx( var_4 ), var_8["position"], var_8["normal"] );
            }
        }
    }
}

tracking_grenade_handle_damage( var_0 )
{
    self endon( "death" );
    self makeentitysentient( var_0.team, 1 );
    self waittill( "damage" );
    tracking_grenade_detonate();
}

tracking_grenade_handle_autosave( var_0 )
{
    if ( !isplayer( var_0 ) )
        return;

    if ( !isdefined( var_0.num_active_tracking_grenades ) )
        var_0.num_active_tracking_grenades = 0;

    var_0.num_active_tracking_grenades++;
    maps\_utility::add_extra_autosave_check( "no_tracking_grenades_active", ::no_tracking_grenades_active, "tracking grenades are active" );
    common_scripts\utility::waittill_either( "death", "tracking_grenade_deactivate" );
    wait 1;
    var_0.num_active_tracking_grenades--;
}

no_tracking_grenades_active()
{
    return !isdefined( level.player.num_active_tracking_grenades ) || level.player.num_active_tracking_grenades == 0;
}

tracking_grenade_scare_enemies( var_0 )
{
    badplace_cylinder( "", 4, var_0 + ( 0, 0, -64 ), 117, 128, "all" );
}

tracking_grenade_get_target( var_0 )
{
    var_1 = var_0 geteye();
    var_2 = anglestoforward( var_0 getgunangles() );
    var_3 = cos( 20 );
    var_4 = undefined;
    var_5 = getaispeciesarray( common_scripts\utility::get_enemy_team( var_0.team ), "all" );
    var_5 = common_scripts\utility::array_combine( var_5, getentarray( "tracking_grenade_target", "script_noteworthy" ) );
    var_5 = common_scripts\utility::array_combine( var_5, vehicle_getarray() );

    foreach ( var_7 in var_5 )
    {
        if ( var_7.code_classname == "script_vehicle" && !issentient( var_7 ) )
            continue;

        if ( isdefined( var_7.pretending_to_be_dead ) )
            continue;

        var_8 = undefined;

        if ( isai( var_7 ) )
            var_8 = var_7 geteye();
        else
            var_8 = var_7.origin;

        var_9 = vectordot( vectornormalize( var_8 - var_1 ), var_2 );

        if ( var_9 <= var_3 )
            continue;

        if ( distancesquared( var_8, var_1 ) < distancesquared( self.origin, var_1 ) )
            continue;

        if ( !sighttracepassed( self.origin, var_8, 0, self, var_7 ) )
            continue;

        if ( isdefined( var_4 ) && !sighttracepassed( self.origin, var_8, 0, self, var_7 ) )
            continue;

        var_3 = var_9;
        var_4 = var_7;
    }

    return var_4;
}

tracking_grenade_thrust_effect( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::spawn_tag_origin();

    if ( isdefined( var_2 ) )
        var_3.origin += var_2;

    var_3.angles = vectortoangles( var_0 );
    var_3 linkto( self );
    playfxontag( common_scripts\utility::getfx( var_1 ), var_3, "tag_origin" );
    var_3 common_scripts\utility::delaycall( 0.3, ::delete );
}

getsmoothrandomvector( var_0, var_1 )
{
    var_2 = gettime() * 0.001 * var_1;
    return ( perlinnoise2d( var_2, 10, 1, 1, 1 ) * var_0, perlinnoise2d( var_2, 20, 1, 1, 1 ) * var_0, perlinnoise2d( var_2, 30, 1, 1, 1 ) * var_0 );
}

make_tracking_grenade( var_0 )
{
    var_1 = var_0.origin;
    var_0 delete();
    var_2 = spawn( "script_model", var_1 );
    var_2 setmodel( "npc_variable_grenade_lethal" );
    return var_2;
}

target_valid_targets()
{
    var_0 = getaiarray( "axis" );
    var_1 = [];
    var_2 = common_scripts\utility::spawn_tag_origin();
    target_set( var_2 );
    target_setjavelinonly( var_2, 1 );

    foreach ( var_4 in var_0 )
    {
        var_2.origin = var_4 geteye();

        if ( target_isincircle( var_2, self, 65, 100 ) )
            var_1[var_1.size] = var_4;
    }

    var_2 delete();
    return var_1;
}

get_npc_center_offset()
{
    if ( isai( self ) && isalive( self ) )
    {
        var_0 = self geteye()[2];
        var_1 = self.origin[2];
        var_2 = var_0 - var_1;
        return ( 0, 0, var_2 );
    }
    else
        return ( 0, 0, 0 );
}

iswatersurface( var_0 )
{
    var_1 = [ "water_waist", "water_ankle", "water_knee" ];

    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

target_enhancer_think()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    var_0 = 10;
    var_1 = cos( var_0 );
    var_2 = 0.5;
    var_3 = undefined;

    for (;;)
    {
        var_4 = 0;
        var_5 = getweaponattachments( self getcurrentweapon() );

        if ( isdefined( var_5 ) )
        {
            foreach ( var_7 in var_5 )
            {
                if ( var_7 == "opticstargetenhancer" )
                {
                    var_4 = 1;
                    break;
                }
            }
        }

        while ( var_4 && self playerads() < var_2 )
        {
            if ( isdefined( var_3 ) )
            {
                var_3 destroy();
                var_3 = undefined;
            }

            wait 0.05;
        }

        if ( !var_4 )
        {
            if ( isdefined( var_3 ) )
            {
                var_3 destroy();
                var_3 = undefined;
            }

            wait 0.05;
            continue;
        }

        if ( self isusingturret() )
        {
            if ( isdefined( var_3 ) )
            {
                var_3 destroy();
                var_3 = undefined;
            }

            wait 0.05;
            continue;
        }

        if ( !isdefined( var_3 ) )
            var_3 = player_enable_highlight();

        wait 0.05;
    }
}

player_enable_highlight()
{
    var_0 = newclienthudelem( self );
    var_0.color = ( 0.2, 0.01, 0.01 );
    var_0.alpha = 1.0;
    var_0 setradarhighlight( -1 );
    return var_0;
}
