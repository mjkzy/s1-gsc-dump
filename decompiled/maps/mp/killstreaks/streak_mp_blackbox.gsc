// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

streak_init()
{
    precacheitem( "iw5_dlcgun12loot4_mp" );
    precacheshader( "dpad_killstreak_lost_static" );
    precacheshader( "overlay_blackbox_killstreak" );
    level.killstreakfuncs["mp_blackbox"] = ::tryusempblackbox;
    level.mapkillstreak = "mp_blackbox";
    level.mapkillstreakpickupstring = &"MP_BLACKBOX_MAP_KILLSTREAK_PICKUP";
    level.killstreakoverlay = "overlay_blackbox_killstreak";
    level.killstreak_trail_fx = loadfx( "vfx/map/mp_blackbox/trail_on_character" );
    level.killstreak_chest_fx = loadfx( "vfx/map/mp_blackbox/killstreak_chest_vfx" );
}

test_give_players_map_killstreak()
{
    wait 60;

    for (;;)
    {
        if ( isdefined( level.players ) && level.players.size > 0 )
        {
            var_0 = level.players[randomintrange( 0, level.players.size )];

            if ( isdefined( var_0 ) && var_0.team != "spectator" && isdefined( var_0.killstreakmodules ) && !var_0 _meth_8314( "iw5_dlcgun12loot4_mp" ) && !isbot( var_0 ) && !isagent( var_0 ) )
            {
                if ( !isdefined( var_0.map_killstreak_active ) || !var_0.map_killstreak_active )
                {
                    if ( !isdefined( var_0.given_map_killstreak ) || !var_0.given_map_killstreak )
                    {
                        var_0.given_map_killstreak = 1;
                        var_0 maps\mp\killstreaks\_killstreaks::givekillstreak( level.mapkillstreak );
                    }
                }
            }
        }

        wait 20;
    }
}

tryusempblackbox( var_0, var_1 )
{
    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    if ( maps\mp\_utility::isjuggernaut() )
        return 0;

    if ( isdefined( self.map_killstreak_active ) && self.map_killstreak_active )
        return 0;

    thread enable_alien_mode();
    return 1;
}

setcreature()
{
    self.radar_highlight = newclienthudelem( self );
    self.radar_highlight.color = ( 1, 0.015, 0.015 );
    self.radar_highlight.alpha = 1.0;
    self.radar_highlight _meth_83A4( 60 );
}

unsetcreature()
{
    if ( isdefined( self.radar_highlight ) )
        self.radar_highlight destroy();
}

enable_alien_mode()
{
    self playsound( "ks_blackbox_spore_use" );
    level.perksetfuncs["specialty_exo_creature"] = ::setcreature;
    level.perkunsetfuncs["specialty_exo_creature"] = ::unsetcreature;
    self.map_killstreak_active = 1;
    disable_exo_usage();
    alien_mode_abilities( 0 );
    enable_clientfx();
    enable_fx();
    thread alien_mode_reapply_on_death();
    alien_mode_timer();
    self notify( "notify_end_killstreak_mode" );
    self.map_killstreak_active = 0;
    disable_alien_mode();
    disable_clientfx();
    disable_fx();
    reenable_exo_usage();
    level.perksetfuncs["specialty_exo_creature"] = undefined;
    level.perkunsetfuncs["specialty_exo_creature"] = undefined;
}

disable_alien_mode()
{
    alien_mode_overdrive_off();
    alien_extra_health_off();
    self _meth_8304( 0 );
    wait 0.1;
    remove_alien_perks();
    self _meth_8304( 1 );
    self notify( "stop_exo_repulsor" );
    self.killstreaksdisabled = undefined;
}

disable_exo_usage()
{
    if ( self _meth_8314( "adrenaline_mp" ) )
    {
        self.has_overclock_ability = 1;
        self.overclock_battery_charge = self _meth_84A2( "adrenaline_mp" );
        self _meth_84A3( "adrenaline_mp", 0 );
    }

    if ( self _meth_8314( "extra_health_mp" ) )
    {
        self.has_stim_ability = 1;
        self.stim_battery_charge = self _meth_84A2( "extra_health_mp" );
        self _meth_84A3( "extra_health_mp", 0 );
    }

    if ( isdefined( level.cloakweapon ) && self _meth_8314( level.cloakweapon ) )
    {
        self.has_cloak_ability = 1;
        self.cloak_battery_charge = self _meth_84A2( maps\mp\_exo_cloak::get_exo_cloak_weapon() );
        self _meth_84A3( maps\mp\_exo_cloak::get_exo_cloak_weapon(), 0 );
    }

    if ( isdefined( level.hoverweapon ) && self _meth_8314( level.hoverweapon ) )
    {
        self.has_hover_ability = 1;
        self.hover_battery_charge = self _meth_84A2( level.hoverweapon );
        self _meth_84A3( level.hoverweapon, 0 );
    }

    if ( self _meth_8314( "exomute_equipment_mp" ) )
    {
        self.has_mute_ability = 1;
        self.mute_battery_charge = self _meth_84A2( "exomute_equipment_mp" );
        self _meth_84A3( "exomute_equipment_mp", 0 );
    }

    if ( self _meth_8314( "exoping_equipment_mp" ) )
    {
        self.has_ping_ability = 1;
        self.ping_battery_charge = self _meth_84A2( "exoping_equipment_mp" );
        self _meth_84A3( "exoping_equipment_mp", 0 );
    }

    if ( self _meth_8314( "exorepulsor_equipment_mp" ) )
    {
        self.has_trophy_ability = 1;
        self.trophy_battery_charge = self _meth_84A2( "exorepulsor_equipment_mp" );
        self _meth_84A3( "exorepulsor_equipment_mp", 0 );
    }

    if ( isdefined( level.exoshieldweapon ) && self _meth_8314( level.exoshieldweapon ) )
    {
        self.has_shield_ability = 1;
        self.shield_battery_charge = self _meth_84A2( maps\mp\_exo_shield::get_exo_shield_weapon() );
        self _meth_84A3( maps\mp\_exo_shield::get_exo_shield_weapon(), 0 );
    }
}

reenable_exo_usage()
{
    if ( isdefined( self.has_overclock_ability ) && self.has_overclock_ability == 1 )
        self _meth_84A3( "adrenaline_mp", self.overclock_battery_charge );

    if ( isdefined( self.has_stim_ability ) && self.has_stim_ability == 1 )
        self _meth_84A3( "extra_health_mp", self.stim_battery_charge );

    if ( isdefined( self.has_cloak_ability ) && self.has_cloak_ability == 1 )
        self _meth_84A3( maps\mp\_exo_cloak::get_exo_cloak_weapon(), self.cloak_battery_charge );

    if ( isdefined( self.has_hover_ability ) && self.has_hover_ability == 1 )
        self _meth_84A3( level.hoverweapon, self.hover_battery_charge );

    if ( isdefined( self.has_mute_ability ) && self.has_mute_ability == 1 )
        self _meth_84A3( "exomute_equipment_mp", self.mute_battery_charge );

    if ( isdefined( self.has_ping_ability ) && self.has_ping_ability == 1 )
        self _meth_84A3( "exoping_equipment_mp", self.ping_battery_charge );

    if ( isdefined( self.has_trophy_ability ) && self.has_trophy_ability == 1 )
        self _meth_84A3( "exorepulsor_equipment_mp", self.trophy_battery_charge );

    if ( isdefined( self.has_shield_ability ) && self.has_shield_ability == 1 )
        self _meth_84A3( maps\mp\_exo_shield::get_exo_shield_weapon(), self.shield_battery_charge );
}

alien_mode_abilities( var_0 )
{
    alien_mode_overdrive_on();
    thread alien_extra_health_on( var_0 );
    give_alien_perks();
    self.killstreaksdisabled = 1;
    thread alien_mode_exo_repulsor_on();
    thread alien_mode_unlimited_ammo();
}

give_alien_perks()
{
    self _meth_8309( 0.5 );
    maps\mp\_utility::giveperk( "specialty_exo_slamboots", 0 );
    maps\mp\_utility::giveperk( "specialty_radarimmune", 0 );
    maps\mp\_utility::giveperk( "specialty_exoping_immune", 0 );
    maps\mp\_utility::giveperk( "specialty_hard_shell", 0 );
    maps\mp\_utility::giveperk( "specialty_throwback", 0 );
    maps\mp\_utility::giveperk( "_specialty_blastshield", 0 );
    self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty( "perk_blastShieldScale", 45 ) / 100;

    if ( isdefined( level.hardcoremode ) && level.hardcoremode )
        self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty( "perk_blastShieldScale_HC", 90 ) / 100;

    maps\mp\_utility::giveperk( "specialty_lightweight", 0 );
    maps\mp\_utility::giveperk( "specialty_explosivedamage", 0 );
    maps\mp\_utility::giveperk( "specialty_blindeye", 0 );
    maps\mp\_utility::giveperk( "specialty_plainsight", 0 );
    maps\mp\_utility::giveperk( "specialty_coldblooded", 0 );
    maps\mp\_utility::giveperk( "specialty_spygame", 0 );
    maps\mp\_utility::giveperk( "specialty_heartbreaker", 0 );
    maps\mp\_utility::giveperk( "specialty_moreminimap", 0 );
    maps\mp\_utility::giveperk( "specialty_silentkill", 0 );
    maps\mp\_utility::giveperk( "specialty_quickswap", 0 );
    maps\mp\_utility::giveperk( "specialty_fastoffhand", 0 );
    maps\mp\_utility::giveperk( "specialty_sprintreload", 0 );
    maps\mp\_utility::giveperk( "specialty_sprintfire", 0 );
    maps\mp\_utility::giveperk( "specialty_empimmune", 0 );
    maps\mp\_utility::giveperk( "specialty_stun_resistance", 0 );
    self.stunscaler = 0.1;
    self _meth_8309( 0.2 );
    self.ammopickup_scalar = 0.2;
    maps\mp\_utility::giveperk( "specialty_scavenger", 0 );
    maps\mp\_utility::giveperk( "specialty_bulletresupply", 0 );
    maps\mp\_utility::giveperk( "specialty_extraammo", 0 );
    maps\mp\_utility::giveperk( "specialty_hardline", 0 );
    maps\mp\_utility::giveperk( "specialty_exo_creature", 0 );
}

should_remove_alien_perk( var_0 )
{
    if ( maps\mp\_utility::_hasperk( var_0 ) )
        return 0;

    var_1 = isdefined( self.reinforcementperks ) && isdefined( self.reinforcementperks[var_0] ) && self.reinforcementperks[var_0];

    if ( var_1 )
        return 0;

    return 1;
}

remove_alien_perks()
{
    if ( should_remove_alien_perk( "specialty_extended_battery" ) )
        maps\mp\_utility::_unsetperk( "specialty_exo_slamboots" );

    if ( should_remove_alien_perk( "specialty_class_lowprofile" ) )
    {
        maps\mp\_utility::_unsetperk( "specialty_radarimmune" );
        maps\mp\_utility::_unsetperk( "specialty_exoping_immune" );
    }

    if ( should_remove_alien_perk( "specialty_class_flakjacket" ) )
    {
        maps\mp\_utility::_unsetperk( "specialty_hard_shell" );
        maps\mp\_utility::_unsetperk( "specialty_throwback" );
        maps\mp\_utility::_unsetperk( "_specialty_blastshield" );
    }

    if ( should_remove_alien_perk( "specialty_class_lightweight" ) )
        maps\mp\_utility::_unsetperk( "specialty_lightweight" );

    if ( should_remove_alien_perk( "specialty_class_dangerclose" ) )
        maps\mp\_utility::_unsetperk( "specialty_explosivedamage" );

    if ( should_remove_alien_perk( "specialty_class_blindeye" ) )
    {
        maps\mp\_utility::_unsetperk( "specialty_blindeye" );
        maps\mp\_utility::_unsetperk( "specialty_plainsight" );
    }

    if ( should_remove_alien_perk( "specialty_class_coldblooded" ) )
    {
        maps\mp\_utility::_unsetperk( "specialty_coldblooded" );
        maps\mp\_utility::_unsetperk( "specialty_spygame" );
        maps\mp\_utility::_unsetperk( "specialty_heartbreaker" );
    }

    if ( should_remove_alien_perk( "specialty_class_peripherals" ) || maps\mp\_utility::practiceroundgame() )
    {
        maps\mp\_utility::_unsetperk( "specialty_moreminimap" );
        maps\mp\_utility::_unsetperk( "specialty_silentkill" );
    }

    if ( should_remove_alien_perk( "specialty_class_fasthands" ) )
    {
        maps\mp\_utility::_unsetperk( "specialty_quickswap" );
        maps\mp\_utility::_unsetperk( "specialty_fastoffhand" );
        maps\mp\_utility::_unsetperk( "specialty_sprintreload" );
    }

    if ( should_remove_alien_perk( "specialty_class_dexterity" ) )
        maps\mp\_utility::_unsetperk( "specialty_sprintfire" );

    if ( should_remove_alien_perk( "specialty_class_hardwired" ) )
    {
        maps\mp\_utility::_unsetperk( "specialty_empimmune" );
        maps\mp\_utility::_unsetperk( "specialty_stun_resistance" );
    }

    if ( should_remove_alien_perk( "specialty_class_toughness" ) )
        self _meth_8309( 0.5 );

    if ( should_remove_alien_perk( "specialty_class_scavenger" ) )
    {
        maps\mp\_utility::_unsetperk( "specialty_scavenger" );
        maps\mp\_utility::_unsetperk( "specialty_bulletresupply" );
        maps\mp\_utility::_unsetperk( "specialty_extraammo" );
    }

    if ( should_remove_alien_perk( "specialty_class_hardline" ) )
        maps\mp\_utility::_unsetperk( "specialty_hardline" );

    maps\mp\_utility::_unsetperk( "specialty_exo_creature" );
}

alien_extra_health_on( var_0 )
{
    thread maps\mp\perks\_perkfunctions::setlightarmor();
    self.maxhealth = int( self.maxhealth * 3 );
    self.ignoreregendelay = 1;
    self.healthregenlevel = 0.99;

    if ( var_0 )
        self waittill( "playerHealthRegen" );

    self notify( "damage" );
    maps\mp\_extrahealth::killstimfx();
}

alien_extra_health_off()
{
    thread maps\mp\perks\_perkfunctions::unsetlightarmor();

    if ( isdefined( level.ishorde ) )
        self.maxhealth = self.classmaxhealth + self.hordearmor * 40;
    else
        self.maxhealth = int( self.maxhealth / 3 );

    if ( self.health > self.maxhealth )
        self.health = self.maxhealth;

    self.healthregenlevel = undefined;
    maps\mp\_extrahealth::killstimfx();
}

alien_mode_overdrive_on()
{
    if ( isdefined( self.overclock_on ) && self.overclock_on == 1 )
        thread maps\mp\_adrenaline::stopadrenaline( 1 );

    self.adrenaline_speed_scalar = 1.12;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = self.adrenaline_speed_scalar + maps\mp\_utility::lightweightscalar() - 1;
    else
        self.movespeedscaler = self.adrenaline_speed_scalar;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_0 = self _meth_8447( "ui_horde_player_class" );
        self.movespeedscaler = min( level.classsettings[var_0]["speed"] + 0.25, 10 );
    }

    maps\mp\gametypes\_weapons::updatemovespeedscale();
    thread maps\mp\_adrenaline::killoverclockfx();
}

alien_mode_overdrive_off()
{
    self notify( "EndAdrenaline" );

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = maps\mp\_utility::lightweightscalar();
    else
        self.movespeedscaler = level.baseplayermovescale;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_0 = self _meth_8447( "ui_horde_player_class" );
        self.movespeedscaler = level.classsettings[var_0]["speed"];
    }

    maps\mp\gametypes\_weapons::updatemovespeedscale();
    self.adrenaline_speed_scalar = undefined;
}

alien_mode_exo_ping_on()
{
    if ( isdefined( self.exo_ping_on ) && self.exo_ping_on == 1 )
        thread maps\mp\_exo_ping::stop_exo_ping();

    var_0 = 1;
    var_1 = 2;
    thread maps\mp\_threatdetection::detection_highlight_hud_effect( self, 60 + var_0 );

    while ( self.map_killstreak_active )
    {
        foreach ( var_3 in level.players )
        {
            if ( !isdefined( var_3 ) || !isalive( var_3 ) || self.team == var_3.team )
                continue;

            var_4 = var_3;
            var_4 maps\mp\_threatdetection::addthreatevent( [ self ], var_0 + 0.05, "PAINT_KILLSTREAK", 1, 0 );
        }

        wait(var_0);
    }
}

alien_mode_exo_repulsor_on()
{
    if ( !isdefined( level.exo_repulsor_impact ) )
        level.exo_repulsor_impact = loadfx( "vfx/explosion/exo_repulsor_impact" );

    if ( !isdefined( level.exo_repulsor_activate_vfx ) )
        level.exo_repulsor_activate_vfx = loadfx( "vfx/unique/repulsor_bubble" );

    if ( !isdefined( level.exo_repulsor_deactivate_vfx ) )
        level.exo_repulsor_deactivate_vfx = loadfx( "vfx/unique/repulsor_bubble_deactivate" );

    if ( !isdefined( level.exo_repulsor_player_vfx_active ) )
        level.exo_repulsor_player_vfx_active = loadfx( "vfx/unique/exo_repulsor_emitter" );

    if ( !isdefined( level.exo_repulsor_player_vfx_inactive ) )
        level.exo_repulsor_player_vfx_inactive = loadfx( "vfx/unique/exo_repulsor_inactive" );

    if ( isdefined( self.repulsoractive ) && self.repulsoractive == 1 )
        thread maps\mp\_exo_repulsor::stop_repulsor( 1 );

    thread alien_mode_repulsor_on();
}

alien_mode_repulsor_on()
{
    level endon( "game_ended" );
    self endon( "stop_exo_repulsor" );
    maps\mp\_exo_repulsor::exorepulsorinit();

    for (;;)
    {
        for ( var_0 = 0; var_0 < level.grenades.size; var_0++ )
        {
            var_1 = level.grenades[var_0];

            if ( !isdefined( var_1.weaponname ) )
                continue;

            if ( isdefined( var_1.weaponname ) && maps\mp\_utility::is_exo_ability_weapon( var_1.weaponname ) )
                continue;

            if ( !isdefined( var_1.owner ) )
                continue;

            if ( isdefined( var_1.owner ) && var_1.owner == self )
                continue;

            if ( level.teambased && isdefined( var_1.owner.team ) && var_1.owner.team == self.team )
                continue;

            var_2 = distance( var_1.origin, self.origin );

            if ( var_2 < 385 )
            {
                if ( sighttracepassed( self _meth_80A8(), var_1.origin, 0, self ) )
                {
                    var_3 = var_1.origin - self.origin;
                    var_4 = vectortoangles( var_3 );
                    var_5 = anglestoup( var_4 );
                    var_6 = anglestoforward( var_4 );
                    var_7 = vectornormalize( var_6 );
                    var_8 = var_1.origin - 0.2 * var_2 * var_7;
                    playfx( level.exo_repulsor_impact, var_8, var_7, var_5 );
                    var_1 maps\mp\_snd_common_mp::snd_message( "mp_exo_repulsor_repel" );

                    if ( var_1.weaponname == "explosive_drone_mp" )
                    {
                        var_1 notify( "mp_exo_repulsor_repel" );
                        var_1 thread maps\mp\_explosive_drone::explosivegrenadedeath();
                    }
                    else
                        var_1 delete();

                    self.projectilesstopped++;
                    maps\mp\gametypes\_missions::processchallenge( "ch_exoability_repulser" );
                }
            }
        }

        for ( var_0 = 0; var_0 < level.missiles.size; var_0++ )
        {
            var_9 = level.missiles[var_0];

            if ( !isdefined( var_9.owner ) )
                continue;

            if ( isdefined( var_9.owner ) && var_9.owner == self )
                continue;

            if ( level.teambased && isdefined( var_9.owner.team ) && var_9.owner.team == self.team )
                continue;

            var_10 = distance( var_9.origin, self.origin );

            if ( var_10 < 385 )
            {
                if ( sighttracepassed( self _meth_80A8(), var_9.origin, 0, self ) )
                {
                    var_11 = var_9.origin - self.origin;
                    var_12 = vectortoangles( var_11 );
                    var_13 = anglestoup( var_12 );
                    var_14 = anglestoforward( var_12 );
                    var_15 = vectornormalize( var_14 );
                    var_8 = var_9.origin - 0.2 * var_10 * var_15;
                    playfx( level.exo_repulsor_impact, var_8, var_15, var_13 );
                    var_9 maps\mp\_snd_common_mp::snd_message( "mp_exo_repulsor_repel" );

                    if ( isdefined( var_9.weaponname ) && var_9.weaponname == "iw5_exocrossbow_mp" )
                        stopfxontag( common_scripts\utility::getfx( "exocrossbow_sticky_blinking" ), var_9.fx_origin, "tag_origin" );

                    var_9 delete();
                    self.projectilesstopped++;
                    maps\mp\gametypes\_missions::processchallenge( "ch_exoability_repulser" );
                }
            }
        }

        for ( var_0 = 0; var_0 < level.explosivedrones.size; var_0++ )
        {
            var_16 = level.explosivedrones[var_0];

            if ( isdefined( var_16 ) )
            {
                if ( !isdefined( var_16.owner ) )
                    continue;

                if ( isdefined( var_16.owner ) && var_16.owner == self )
                    continue;

                if ( level.teambased && isdefined( var_16.owner.team ) && var_16.owner.team == self.team )
                    continue;

                var_17 = distance( var_16.origin, self.origin );

                if ( var_17 < 385 )
                {
                    if ( sighttracepassed( self _meth_80A8(), var_16.origin, 0, self ) )
                    {
                        var_18 = var_16.origin - self.origin;
                        var_19 = vectortoangles( var_18 );
                        var_20 = anglestoup( var_19 );
                        var_21 = anglestoforward( var_19 );
                        var_22 = vectornormalize( var_21 );
                        var_8 = var_16.origin - 0.2 * var_17 * var_22;
                        playfx( level.exo_repulsor_impact, var_8, var_22, var_20 );
                        var_16 maps\mp\_snd_common_mp::snd_message( "mp_exo_repulsor_repel" );

                        if ( isdefined( var_16.explosivedrone ) )
                            var_16.explosivedrone delete();

                        var_16 delete();
                        self.projectilesstopped++;
                        maps\mp\gametypes\_missions::processchallenge( "ch_exoability_repulser" );
                    }
                }
            }
        }

        foreach ( var_24 in level.trackingdrones )
        {
            if ( !isdefined( var_24.owner ) )
                continue;

            if ( isdefined( var_24.owner ) && var_24.owner == self )
                continue;

            if ( level.teambased && isdefined( var_24.owner.team ) && var_24.owner.team == self.team )
                continue;

            var_25 = distance( var_24.origin, self.origin );

            if ( var_25 < 385 )
            {
                if ( sighttracepassed( self _meth_80A8(), var_24.origin, 0, self ) )
                {
                    var_26 = var_24.origin - self.origin;
                    var_27 = vectortoangles( var_26 );
                    var_28 = anglestoup( var_27 );
                    var_29 = anglestoforward( var_27 );
                    var_30 = vectornormalize( var_29 );
                    var_8 = var_24.origin - 0.2 * var_25 * var_30;
                    playfx( level.exo_repulsor_impact, var_8, var_30, var_28 );
                    var_24 maps\mp\_snd_common_mp::snd_message( "mp_exo_repulsor_repel" );

                    if ( !_func_294( var_24 ) && isdefined( var_24 ) )
                    {
                        var_24 notify( "death" );
                        maps\mp\_utility::decrementfauxvehiclecount();
                    }

                    self.projectilesstopped++;
                    maps\mp\gametypes\_missions::processchallenge( "ch_exoability_repulser" );
                }
            }
        }

        if ( self.projectilesstopped >= 2 )
        {
            if ( !isdefined( level.ishorde ) )
                thread maps\mp\_events::fourplayevent();

            self.projectilesstopped -= 2;
        }

        wait 0.05;
    }

    thread maps\mp\_exo_repulsor::stop_repulsor( 1 );
}

alien_mode_unlimited_ammo()
{
    self endon( "notify_end_killstreak_mode" );

    for (;;)
    {
        var_0 = self _meth_8311();
        self waittill( "reload" );
        self _meth_82F7( var_0, _func_1E0( var_0 ) );
    }
}

alien_mode_reapply_on_death()
{
    self endon( "notify_end_killstreak_mode" );

    for (;;)
    {
        self waittill( "death" );
        disable_alien_mode();
        self waittill( "spawnplayer_giveloadout" );
        alien_mode_abilities( 1 );
        thread aud_play_respawn_squish();
        wait 0.2;
        enable_fx();
    }
}

alien_mode_timer()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    wait 60;
}

enable_clientfx()
{
    self _meth_8491( "clut_mp_blackbox_ks", 0.2 );
}

disable_clientfx()
{
    self _meth_8492( 0.5 );
}

enable_fx()
{
    playfxontag( level.killstreak_chest_fx, self, "j_spine4" );
    playfxontag( level.killstreak_trail_fx, self, "tag_origin" );
}

disable_fx()
{
    stopfxontag( level.killstreak_trail_fx, self, "tag_origin" );
    stopfxontag( level.killstreak_chest_fx, self, "j_spine4" );
}

aud_play_respawn_squish()
{
    wait 0.5;
    self playsound( "ks_blackbox_spore_respawn" );
}
