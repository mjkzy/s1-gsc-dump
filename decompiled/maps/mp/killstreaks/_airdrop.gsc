// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( getdvarint( "virtuallobbyactive", 0 ) )
        return;

    level._effect["airdrop_crate_destroy"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["airdrop_crate_trap_explode"] = loadfx( "vfx/explosion/frag_grenade_default" );
    _id_7F13( "airdrop_crate" );
    _id_7F13( "care_package" );
    level._id_6299 = 0;
    level._id_2385 = [];
    level.killstreakwieldweapons["airdrop_trap_explosive_mp"] = "airdrop_assault";
    level.killstreakfuncs["airdrop_reinforcement_common"] = ::_id_98BB;
    level.killstreakfuncs["airdrop_reinforcement_uncommon"] = ::_id_98BE;
    level.killstreakfuncs["airdrop_reinforcement_rare"] = ::_id_98BD;
    level.killstreakfuncs["airdrop_reinforcement_practice"] = ::_id_98BC;
    _id_07DD();
    level._id_7BF5 = [];
    level._id_7BF5["specialty_extended_battery"] = &"PERKS_EXO_BATTERY";
    level._id_7BF5["specialty_class_lowprofile"] = &"PERKS_LOWPROFILE";
    level._id_7BF5["specialty_class_flakjacket"] = &"PERKS_FLAKJACKET";
    level._id_7BF5["specialty_class_lightweight"] = &"PERKS_LIGHTWEIGHT";
    level._id_7BF5["specialty_class_blindeye"] = &"PERKS_BLINDEYE";
    level._id_7BF5["specialty_class_coldblooded"] = &"PERKS_COLDBLOODED";
    level._id_7BF5["specialty_class_peripherals"] = &"PERKS_PERIPHERALS";
    level._id_7BF5["specialty_class_fasthands"] = &"PERKS_FASTHANDS";
    level._id_7BF5["specialty_class_dexterity"] = &"PERKS_DEXTERITY";
    level._id_7BF5["specialty_exo_blastsuppressor"] = &"PERKS_EXO_BLASTSUPPRESSOR";
    level._id_7BF5["specialty_class_hardwired"] = &"PERKS_HARDWIRED";
    level._id_7BF5["specialty_class_toughness"] = &"PERKS_TOUGHNESS";
    level._id_7BF5["specialty_class_scavenger"] = &"PERKS_SCAVENGER";
    level._id_7BF5["specialty_class_hardline"] = &"PERKS_HARDLINE";

    if ( isdefined( level._id_2559 ) )
        [[ level._id_2559 ]]();

    _id_3C83();
    level._id_5987 = randomint( 4 );
}

_id_07DD()
{
    var_0 = level.mapkillstreak;

    if ( isdefined( level.mapstreaksdisabled ) && level.mapstreaksdisabled )
        var_0 = undefined;

    _id_07DC( "airdrop_assault", var_0, 168, ::_id_5396, level._id_598A, var_0 );
    _id_07DC( "airdrop_assault", "b", 168, ::_id_5396, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_heavy_resistance" );
    _id_07DC( "airdrop_assault", "c", 168, ::_id_5396, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret" );
    _id_07DC( "airdrop_assault", "d", 168, ::_id_5396, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1" );
    _id_07DC( "airdrop_assault", "e", 168, ::_id_5396, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1" );
    _id_07DC( "airdrop_assault", "f", 168, ::_id_5396, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_cloak", "recon_ugv_assist_points" );
    _id_07DC( "airdrop_assault", "g", 168, ::_id_5396, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points" );
    _id_07DC( "airdrop_assault", "h", 98, ::_id_5396, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam" );
    _id_07DC( "airdrop_assault", "i", 98, ::_id_5396, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration" );
    _id_07DC( "airdrop_assault", "j", 100, ::_id_5396, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit" );
    _id_07DC( "airdrop_assault", "k", 100, ::_id_5396, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline" );
    _id_07DC( "airdrop_assault", "l", 40, ::_id_5396, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive" );
    _id_07DC( "airdrop_assault", "m", 40, ::_id_5396, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time" );
    _id_07DC( "airdrop_assault", "n", 30, ::_id_5396, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets" );
    _id_07DC( "airdrop_assault", "o", 30, ::_id_5396, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets" );
    _id_07DC( "airdrop_assault", "p", 20, ::_id_5396, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo" );
    _id_07DC( "airdrop_assault", "q", 20, ::_id_5396, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time" );
    _id_07DC( "airdrop_assault", "r", 20, ::_id_5396, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_two", "strafing_run_airstrike_flares" );
    _id_07DC( "airdrop_assault", "s", 20, ::_id_5396, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth" );
    _id_07DC( "airdrop_assault", "t", 10, ::_id_5396, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash" );
    _id_07DC( "airdrop_assault", "u", 10, ::_id_5396, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1" );
    _id_07DC( "airdrop_assault", "v", 10, ::_id_5396, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch" );
    _id_07DC( "airdrop_assault", "w", 10, ::_id_5396, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject" );
    _id_07DC( "airdrop_assault_odds", var_0, 136, ::_id_5396, level._id_598A, var_0 );
    _id_07DC( "airdrop_assault_odds", "b", 136, ::_id_5396, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_heavy_resistance" );
    _id_07DC( "airdrop_assault_odds", "c", 136, ::_id_5396, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret" );
    _id_07DC( "airdrop_assault_odds", "d", 136, ::_id_5396, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1" );
    _id_07DC( "airdrop_assault_odds", "e", 136, ::_id_5396, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1" );
    _id_07DC( "airdrop_assault_odds", "f", 136, ::_id_5396, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_cloak", "recon_ugv_assist_points" );
    _id_07DC( "airdrop_assault_odds", "g", 136, ::_id_5396, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points" );
    _id_07DC( "airdrop_assault_odds", "h", 116, ::_id_5396, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam" );
    _id_07DC( "airdrop_assault_odds", "i", 116, ::_id_5396, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration" );
    _id_07DC( "airdrop_assault_odds", "j", 100, ::_id_5396, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit" );
    _id_07DC( "airdrop_assault_odds", "k", 100, ::_id_5396, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline" );
    _id_07DC( "airdrop_assault_odds", "l", 60, ::_id_5396, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive" );
    _id_07DC( "airdrop_assault_odds", "m", 60, ::_id_5396, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time" );
    _id_07DC( "airdrop_assault_odds", "n", 50, ::_id_5396, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets" );
    _id_07DC( "airdrop_assault_odds", "o", 50, ::_id_5396, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets" );
    _id_07DC( "airdrop_assault_odds", "p", 40, ::_id_5396, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo" );
    _id_07DC( "airdrop_assault_odds", "q", 40, ::_id_5396, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time" );
    _id_07DC( "airdrop_assault_odds", "r", 40, ::_id_5396, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_two", "strafing_run_airstrike_flares" );
    _id_07DC( "airdrop_assault_odds", "s", 40, ::_id_5396, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth" );
    _id_07DC( "airdrop_assault_odds", "t", 30, ::_id_5396, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash" );
    _id_07DC( "airdrop_assault_odds", "u", 30, ::_id_5396, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1" );
    _id_07DC( "airdrop_assault_odds", "v", 30, ::_id_5396, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch" );
    _id_07DC( "airdrop_assault_odds", "w", 30, ::_id_5396, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject" );
    _id_07DC( "airdrop_reinforcement_common", "a", 100, ::_id_7302, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian" );
    _id_07DC( "airdrop_reinforcement_common", "b", 100, ::_id_7302, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction" );
    _id_07DC( "airdrop_reinforcement_common", "c", 100, ::_id_7302, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_assist_points" );
    _id_07DC( "airdrop_reinforcement_uncommon", "a", 100, ::_id_7302, &"MP_EMP_PICKUP", "emp" );
    _id_07DC( "airdrop_reinforcement_uncommon", "b", 100, ::_id_7302, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_rockets" );
    _id_07DC( "airdrop_reinforcement_uncommon", "c", 100, ::_id_7302, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret" );
    _id_07DC( "airdrop_reinforcement_uncommon", "d", 100, ::_id_7302, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_chem", "missile_strike_extra_1" );
    _id_07DC( "airdrop_reinforcement_uncommon", "e", 100, ::_id_7302, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time" );
    _id_07DC( "airdrop_reinforcement_uncommon", "f", 100, ::_id_7302, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points" );
    _id_07DC( "airdrop_reinforcement_uncommon", "g", 100, ::_id_7303, &"PERKS_EXO_BATTERY", "specialty_extended_battery" );
    _id_07DC( "airdrop_reinforcement_uncommon", "h", 100, ::_id_7303, &"PERKS_LOWPROFILE", "specialty_class_lowprofile" );
    _id_07DC( "airdrop_reinforcement_uncommon", "j", 100, ::_id_7303, &"PERKS_FLAKJACKET", "specialty_class_flakjacket" );
    _id_07DC( "airdrop_reinforcement_uncommon", "k", 100, ::_id_7303, &"PERKS_LIGHTWEIGHT", "specialty_class_lightweight" );
    _id_07DC( "airdrop_reinforcement_uncommon", "l", 100, ::_id_7303, &"PERKS_BLINDEYE", "specialty_class_blindeye" );
    _id_07DC( "airdrop_reinforcement_uncommon", "m", 100, ::_id_7303, &"PERKS_COLDBLOODED", "specialty_class_coldblooded" );
    _id_07DC( "airdrop_reinforcement_uncommon", "n", 100, ::_id_7303, &"PERKS_PERIPHERALS", "specialty_class_peripherals" );
    _id_07DC( "airdrop_reinforcement_uncommon", "o", 100, ::_id_7303, &"PERKS_FASTHANDS", "specialty_class_fasthands" );
    _id_07DC( "airdrop_reinforcement_uncommon", "p", 100, ::_id_7303, &"PERKS_DEXTERITY", "specialty_class_dexterity" );
    _id_07DC( "airdrop_reinforcement_uncommon", "r", 100, ::_id_7303, &"PERKS_EXO_BLASTSUPPRESSOR", "specialty_exo_blastsuppressor" );
    _id_07DC( "airdrop_reinforcement_uncommon", "s", 100, ::_id_7303, &"PERKS_HARDWIRED", "specialty_class_hardwired" );
    _id_07DC( "airdrop_reinforcement_uncommon", "t", 100, ::_id_7303, &"PERKS_TOUGHNESS", "specialty_class_toughness" );
    _id_07DC( "airdrop_reinforcement_uncommon", "u", 100, ::_id_7303, &"PERKS_SCAVENGER", "specialty_class_scavenger" );
    _id_07DC( "airdrop_reinforcement_uncommon", "v", 100, ::_id_7303, &"PERKS_HARDLINE", "specialty_class_hardline" );
    _id_07DC( "airdrop_reinforcement_rare", "a", 100, ::_id_7302, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar" );
    _id_07DC( "airdrop_reinforcement_rare", "b", 100, ::_id_7302, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret" );
    _id_07DC( "airdrop_reinforcement_rare", "c", 100, ::_id_7302, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_flares" );
    _id_07DC( "airdrop_reinforcement_rare", "d", 100, ::_id_7302, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares" );
    _id_07DC( "airdrop_reinforcement_rare", "e", 100, ::_id_7302, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration" );
    _id_07DC( "airdrop_reinforcement_rare", "f", 100, ::_id_7302, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline" );
    _id_07DC( "airdrop_reinforcement_rare", "g", 100, ::_id_7302, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points", "recon_ugv_stun" );
    _id_07DC( "airdrop_reinforcement_rare", "h", 100, ::_id_7303, &"PERKS_EXO_BATTERY", "specialty_extended_battery" );
    _id_07DC( "airdrop_reinforcement_rare", "i", 100, ::_id_7303, &"PERKS_LOWPROFILE", "specialty_class_lowprofile" );
    _id_07DC( "airdrop_reinforcement_rare", "k", 100, ::_id_7303, &"PERKS_FLAKJACKET", "specialty_class_flakjacket" );
    _id_07DC( "airdrop_reinforcement_rare", "l", 100, ::_id_7303, &"PERKS_LIGHTWEIGHT", "specialty_class_lightweight" );
    _id_07DC( "airdrop_reinforcement_rare", "m", 100, ::_id_7303, &"PERKS_BLINDEYE", "specialty_class_blindeye" );
    _id_07DC( "airdrop_reinforcement_rare", "n", 100, ::_id_7303, &"PERKS_COLDBLOODED", "specialty_class_coldblooded" );
    _id_07DC( "airdrop_reinforcement_rare", "o", 100, ::_id_7303, &"PERKS_PERIPHERALS", "specialty_class_peripherals" );
    _id_07DC( "airdrop_reinforcement_rare", "p", 100, ::_id_7303, &"PERKS_FASTHANDS", "specialty_class_fasthands" );
    _id_07DC( "airdrop_reinforcement_rare", "q", 100, ::_id_7303, &"PERKS_DEXTERITY", "specialty_class_dexterity" );
    _id_07DC( "airdrop_reinforcement_rare", "s", 100, ::_id_7303, &"PERKS_EXO_BLASTSUPPRESSOR", "specialty_exo_blastsuppressor" );
    _id_07DC( "airdrop_reinforcement_rare", "t", 100, ::_id_7303, &"PERKS_HARDWIRED", "specialty_class_hardwired" );
    _id_07DC( "airdrop_reinforcement_rare", "u", 100, ::_id_7303, &"PERKS_TOUGHNESS", "specialty_class_toughness" );
    _id_07DC( "airdrop_reinforcement_rare", "v", 100, ::_id_7303, &"PERKS_SCAVENGER", "specialty_class_scavenger" );
    _id_07DC( "airdrop_reinforcement_rare", "w", 100, ::_id_7303, &"PERKS_HARDLINE", "specialty_class_hardline" );
    _id_07DC( "airdrop_reinforcement_practice", "a", 168, ::_id_7302, &"MP_SENTRY_PICKUP", "remote_mg_sentry_turret", "sentry_guardian", "sentry_rippable", "sentry_rocket_turret" );
    _id_07DC( "airdrop_reinforcement_practice", "b", 168, ::_id_7302, &"MP_MISSILE_STRIKE_PICKUP", "missile_strike", "missile_strike_extra_1" );
    _id_07DC( "airdrop_reinforcement_practice", "c", 168, ::_id_7302, &"MP_RECON_UGV_PICKUP", "recon_ugv", "recon_ugv_paint_grenade", "recon_ugv_assist_points" );
    _id_07DC( "airdrop_reinforcement_practice", "d", 98, ::_id_7302, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_beam" );
    _id_07DC( "airdrop_reinforcement_practice", "e", 98, ::_id_7302, &"MP_ORBITAL_STRIKE_LASER_PICKUP", "orbital_strike_laser", "orbital_strike_laser_width", "orbital_strike_laser_duration" );
    _id_07DC( "airdrop_reinforcement_practice", "f", 100, ::_id_7302, &"MP_UAV_PICKUP", "uav", "uav_enemy_direction", "uav_orbit" );
    _id_07DC( "airdrop_reinforcement_practice", "g", 100, ::_id_7302, &"MP_UAV_PICKUP", "uav", "uav_scrambler", "uav_increased_time", "uav_paint_outline" );
    _id_07DC( "airdrop_reinforcement_practice", "h", 40, ::_id_7302, &"MP_WARBIRD_PICKUP", "warbird", "warbird_rockets", "warbird_coop_offensive" );
    _id_07DC( "airdrop_reinforcement_practice", "i", 40, ::_id_7302, &"MP_WARBIRD_PICKUP", "warbird", "warbird_ai_attack", "warbird_flares", "warbird_time" );
    _id_07DC( "airdrop_reinforcement_practice", "j", 30, ::_id_7302, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_mg", "assault_ugv_rockets" );
    _id_07DC( "airdrop_reinforcement_practice", "k", 30, ::_id_7302, &"MP_GROUND_ASSAULT_DRONE_PICKUP", "assault_ugv", "assault_ugv_ai", "assault_ugv_rockets" );
    _id_07DC( "airdrop_reinforcement_practice", "l", 20, ::_id_7302, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_turret", "orbitalsupport_coop_offensive", "orbitalsupport_ammo" );
    _id_07DC( "airdrop_reinforcement_practice", "m", 20, ::_id_7302, &"MP_ORBITALSUPPORT_PICKUP", "orbitalsupport", "orbitalsupport_rockets", "orbitalsupport_flares", "orbitalsupport_time" );
    _id_07DC( "airdrop_reinforcement_practice", "n", 20, ::_id_7302, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_flares" );
    _id_07DC( "airdrop_reinforcement_practice", "o", 20, ::_id_7302, &"MP_AIRSTRIKE_PICKUP", "strafing_run_airstrike", "strafing_run_airstrike_stealth" );
    _id_07DC( "airdrop_reinforcement_practice", "p", 10, ::_id_7302, &"MP_EMP_PICKUP", "emp", "emp_assist", "emp_flash" );
    _id_07DC( "airdrop_reinforcement_practice", "q", 10, ::_id_7302, &"MP_EMP_PICKUP", "emp", "emp_streak_kill", "emp_equipment_kill", "emp_time_1" );
    _id_07DC( "airdrop_reinforcement_practice", "r", 10, ::_id_7302, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_radar", "heavy_exosuit_punch" );
    _id_07DC( "airdrop_reinforcement_practice", "s", 10, ::_id_7302, &"MP_HEAVY_EXO_PICKUP", "heavy_exosuit", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_eject" );
}

_id_3C83()
{
    foreach ( var_6, var_1 in level._id_2385 )
    {
        level._id_2377[var_6] = 0;

        foreach ( var_3 in var_1 )
        {
            var_4 = var_3.type;

            if ( !level._id_2385[var_6][var_4]._id_7142 )
            {
                level._id_2385[var_6][var_4]._id_0522 = level._id_2385[var_6][var_4]._id_7142;
                continue;
            }

            level._id_2377[var_6] += level._id_2385[var_6][var_4]._id_7142;
            level._id_2385[var_6][var_4]._id_0522 = level._id_2377[var_6];
        }
    }
}

_id_1C7E( var_0, var_1, var_2 )
{
    if ( !isdefined( level._id_2385[var_0] ) || !isdefined( level._id_2385[var_0][var_1] ) )
        return;

    level._id_2385[var_0][var_1]._id_7142 = var_2;
    _id_3C83();
}

_id_7F13( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    if ( !isdefined( var_1 ) || var_1.size == 0 )
        return;

    level._id_0996 = getent( var_1[0].target, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 _id_2847();
}

_id_07DC( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_1 ) )
        return;

    level._id_2385[var_0][var_1] = spawnstruct();
    level._id_2385[var_0][var_1]._id_2F97 = var_0;
    level._id_2385[var_0][var_1].type = var_1;
    level._id_2385[var_0][var_1]._id_7142 = var_2;
    level._id_2385[var_0][var_1]._id_0522 = var_2;
    level._id_2385[var_0][var_1].func = var_3;
    level._id_2385[var_0][var_1]._id_8F23 = var_5;
    level._id_2385[var_0][var_1].modules = [];
    level._id_2385[var_0][var_1].modules[level._id_2385[var_0][var_1].modules.size] = var_6;
    level._id_2385[var_0][var_1].modules[level._id_2385[var_0][var_1].modules.size] = var_7;
    level._id_2385[var_0][var_1].modules[level._id_2385[var_0][var_1].modules.size] = var_8;

    if ( isdefined( var_4 ) )
        game["strings"][var_0 + var_1 + "_hint"] = var_4;
}

_id_40F5( var_0, var_1 )
{
    if ( isdefined( level._id_2385[var_0] ) && isdefined( level._id_2385[var_0][var_1] ) && isdefined( level._id_2385[var_0][var_1]._id_8F23 ) )
        return level._id_2385[var_0][var_1]._id_8F23;

    return var_1;
}

_id_4028( var_0, var_1 )
{
    if ( isdefined( level._id_2560 ) )
        return [[ level._id_2560 ]]( var_0, var_1 );

    return level._id_2385[var_0][var_1].modules;
}

_id_40A3( var_0, var_1 )
{
    if ( getdvar( "g_gametype" ) != "horde" )
    {
        var_7 = isdefined( level.mapkillstreak ) && isdefined( level._id_2385[var_0][level.mapkillstreak] );
        var_8 = isdefined( level._id_5987 ) && level._id_6299 >= level._id_5987;

        if ( var_7 && var_8 )
        {
            level._id_5987 = undefined;
            return level.mapkillstreak;
        }
    }

    var_9 = randomint( level._id_2377[var_0] );
    var_10 = undefined;
    var_11 = level._id_2385[var_0];

    if ( isdefined( var_1 ) )
    {
        var_12 = level._id_2385[var_0];

        foreach ( var_14 in var_12 )
        {
            if ( _id_2384( var_14.type, var_1 ) )
                var_12 = _id_8A15( var_12, var_14 );
        }

        var_11 = var_12;
    }

    foreach ( var_4 in var_11 )
    {
        var_5 = var_4.type;

        if ( !level._id_2385[var_0][var_5]._id_0522 )
            continue;

        var_10 = var_5;

        if ( level._id_2385[var_0][var_5]._id_0522 > var_9 )
            break;
    }

    return var_10;
}

_id_2384( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

_id_8A15( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( var_4 != var_1 )
            var_2[var_4.type] = var_4;
    }

    return var_2;
}

_id_3F3E( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "airdrop_assault":
        case "airdrop_assault_odds":
        default:
            return _id_40A3( var_0, var_1 );
    }
}

_id_285A( var_0 )
{
    self linkto( var_0, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 waittill( "death" );
    self delete();
}

_id_2381()
{
    self endon( "death" );
    self hide();

    foreach ( var_1 in level.players )
    {
        if ( var_1.team != "spectator" )
            self showtoplayer( var_1 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_1 in level.players )
        {
            if ( var_1.team != "spectator" )
                self showtoplayer( var_1 );
        }
    }
}

_id_2379( var_0, var_1 )
{
    self endon( "death" );
    self hide();

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == var_0 || var_1 && var_3.team == "spectator" )
            self showtoplayer( var_3 );
    }

    for (;;)
    {
        level common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
        self hide();

        foreach ( var_3 in level.players )
        {
            if ( var_3.team == var_0 || var_1 && var_3.team == "spectator" )
                self showtoplayer( var_3 );
        }
    }
}

_id_2378( var_0, var_1 )
{
    self endon( "death" );
    self hide();

    foreach ( var_3 in level.players )
    {
        if ( var_1 && isdefined( var_0 ) && var_3 != var_0 )
            continue;

        if ( !var_1 && isdefined( var_0 ) && var_3 == var_0 )
            continue;

        self showtoplayer( var_3 );
    }

    for (;;)
    {
        level waittill( "joined_team" );
        self hide();

        foreach ( var_3 in level.players )
        {
            if ( var_1 && isdefined( var_0 ) && var_3 != var_0 )
                continue;

            if ( !var_1 && isdefined( var_0 ) && var_3 == var_0 )
                continue;

            self showtoplayer( var_3 );
        }
    }
}

_id_2388( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        _id_8343( var_0 );
        level waittill( "joined_team" );
    }
}

_id_2386()
{
    var_0 = _id_40F5( self._id_2F97, self._id_2383 );

    if ( !issubstr( var_0, "juggernaut" ) )
        return;

    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "juggernaut_equipped", var_1 );
        self disableplayeruse( var_1 );
        thread _id_2387( var_1 );
    }
}

_id_2387( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 waittill( "death" );
    self enableplayeruse( var_0 );
}

_id_23E2( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_4 ) )
        var_4 = ( 0.0, 0.0, 0.0 );

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    if ( !isdefined( var_6 ) )
        var_6 = 1;

    var_7 = spawn( "script_model", var_3 );
    var_7.angles = var_4;
    var_7.curprogress = 0;
    var_7.usetime = 0;
    var_7.userate = 0;
    var_7.team = self.team;

    if ( isdefined( var_0 ) )
        var_7.owner = var_0;
    else
        var_7.owner = undefined;

    var_7._id_2383 = var_2;
    var_7._id_2F97 = var_1;
    var_7.targetname = "care_package";
    var_7._id_51D6 = var_5;

    if ( var_7.team == "any" )
    {
        var_7 setmodel( "orbital_carepackage_pod_01_ai" );
        var_7._id_3AB6 = spawn( "script_model", var_7.origin );
        var_7._id_3AB6 setmodel( "tag_origin" );
        var_7._id_3AB6 thread _id_285A( var_7 );
    }
    else if ( isdefined( level.iszombiegame ) && level.iszombiegame )
    {
        var_7 setmodel( "orbital_carepackage_pod_01_logo_atlas" );
        var_7._id_3AB6 = spawn( "script_model", var_7.origin );
        var_7._id_3AB6 setmodel( "orbital_carepackage_pod_01_ai" );
        var_7._id_3AB6._id_6684 = var_7;
        var_7._id_3AB6 notsolid();
        var_7._id_3AB6 thread _id_285A( var_7 );
    }
    else
    {
        var_7 setmodel( maps\mp\gametypes\_teams::getteamcratemodel( var_7.team ) );
        var_7 thread _id_2381();
        var_8 = "orbital_carepackage_pod_01_ai";
        var_9 = "orbital_carepackage_pod_01_clr_01_ai";

        if ( var_2 == "booby_trap" )
        {
            var_8 = "orbital_carepackage_pod_01_logo_trap_ai";
            var_7 thread _id_971F();
        }
        else if ( var_5 )
            var_7 thread _id_971F();

        var_7._id_3AB6 = spawn( "script_model", var_3 );
        var_7._id_3AB6 setmodel( var_8 );
        var_7._id_3AB6._id_6684 = var_7;
        var_7._id_3AB6 notsolid();
        var_7._id_32B4 = spawn( "script_model", var_3 );
        var_7._id_32B4 setmodel( var_9 );
        var_7._id_32B4._id_6684 = var_7;
        var_7._id_32B4 notsolid();
        var_7._id_3AB6 thread _id_285A( var_7 );

        if ( level.teambased )
            var_7._id_3AB6 thread _id_2379( var_7.team, 1 );
        else
            var_7._id_3AB6 thread _id_2378( var_0, 1 );

        var_7._id_32B4 thread _id_285A( var_7 );

        if ( level.teambased )
            var_7._id_32B4 thread _id_2379( level.otherteam[var_7.team], 0 );
        else
            var_7._id_32B4 thread _id_2378( var_0, 0 );
    }

    var_7.inuse = 0;

    if ( var_6 )
        var_7 clonebrushmodeltoscriptmodel( level._id_0996 );

    var_7.killcament = spawn( "script_model", var_7.origin + ( 0.0, 0.0, -200.0 ) );
    var_7.killcament setscriptmoverkillcam( "explosive" );
    var_7.killcament setcontents( 0 );
    var_7.killcament linkto( var_7 );
    level._id_6299++;
    return var_7;
}

_id_971F()
{
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 hide();
    var_0 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater( self.owner );
    var_0 setmodel( "orbital_carepackage_pod_01_ai_bombsquad" );
    var_0 linkto( self );
    var_0 setcontents( 0 );
    self waittill( "death" );
    var_0 delete();
}

_id_2380( var_0, var_1 )
{
    if ( isdefined( var_1 ) && isdefined( self.owner ) )
    {
        self._id_6636 = spawn( "script_model", self.origin + ( 0.0, 0.0, 60.0 ) );
        self._id_6636 setcursorhint( "HINT_NOICON" );
        self._id_6636 sethintstring( var_0 );
        self._id_6636 _meth_80DC( var_1 );
        self._id_65AF = spawn( "script_model", self.origin + ( 0.0, 0.0, 60.0 ) );
        self._id_65AF setcursorhint( "HINT_NOICON" );
        self._id_65AF sethintstring( var_0 );
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
        self sethintstring( var_0 );
    }
}

_id_64CB( var_0, var_1 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );

    for (;;)
    {
        level waittill( "connected", var_2 );
        var_2 thread _id_64D5( var_0, var_1 );
    }
}

_id_64D5( var_0, var_1 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    self waittill( "spawned" );
    var_0 enableplayeruse( self );
    var_1 disableplayeruse( self );
}

_id_237F( var_0, var_1 )
{
    if ( isdefined( level.ishorde ) && level.ishorde )
        self waittill( "drop_pod_cleared" );

    if ( isdefined( self._id_6636 ) )
    {
        self._id_6636 makeusable();
        self._id_65AF makeusable();

        foreach ( var_3 in level.players )
        {
            if ( var_3 != self.owner )
            {
                self._id_6636 disableplayeruse( var_3 );
                self._id_65AF enableplayeruse( var_3 );
                continue;
            }

            self._id_65AF disableplayeruse( var_3 );
            self._id_6636 enableplayeruse( var_3 );
        }

        thread _id_64CB( self._id_65AF, self._id_6636 );
    }
    else
        self makeusable();

    self._id_5D32 = var_0;

    if ( self.team == "any" )
    {
        var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_5, "invisible", ( 0.0, 0.0, 0.0 ) );
        objective_position( var_5, self.origin );
        objective_state( var_5, "active" );
        var_6 = "compass_objpoint_ammo_friendly";
        objective_icon( var_5, var_6 );
        objective_team( var_5, "none" );
        self._id_6305 = var_5;
    }
    else
    {
        if ( level.teambased || isdefined( self.owner ) )
        {
            var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
            objective_add( var_5, "invisible", ( 0.0, 0.0, 0.0 ) );
            objective_position( var_5, self.origin );
            objective_state( var_5, "active" );
            var_6 = "compass_objpoint_ammo_friendly";

            if ( var_0 == "trap" )
                var_6 = "compass_objpoint_trap_friendly";

            objective_icon( var_5, var_6 );

            if ( !level.teambased && isdefined( self.owner ) )
                objective_playerteam( var_5, self.owner getentitynumber() );
            else
                objective_team( var_5, self.team );

            self._id_6305 = var_5;
        }

        if ( !( isdefined( level.ishorde ) && level.ishorde ) )
        {
            if ( !isdefined( self.owner ) || !( isdefined( self._id_5D54 ) && self._id_5D54 ) )
            {
                var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
                objective_add( var_5, "invisible", ( 0.0, 0.0, 0.0 ) );
                objective_position( var_5, self.origin );
                objective_state( var_5, "active" );
                objective_icon( var_5, "compass_objpoint_ammo_enemy" );

                if ( !level.teambased && isdefined( self.owner ) )
                    objective_playerenemyteam( var_5, self.owner getentitynumber() );
                else
                    objective_team( var_5, level.otherteam[self.team] );

                self._id_6304 = var_5;
            }
        }
    }

    if ( self.team == "any" )
    {
        foreach ( var_8 in level.teamnamelist )
        {
            if ( isdefined( var_1 ) && isarray( var_1 ) )
            {
                _id_7F81( var_8, var_1 );
                continue;
            }

            maps\mp\_entityheadicons::setheadicon( var_8, var_1, ( 0.0, 0.0, 60.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
        }
    }
    else if ( var_0 == "trap" )
        thread _id_2388( maps\mp\_utility::getotherteam( self.team ) );
    else
    {
        thread _id_2388();
        var_10 = _id_40F5( self._id_2F97, self._id_2383 );

        if ( issubstr( var_10, "juggernaut" ) )
        {
            foreach ( var_3 in level.players )
            {
                if ( var_3 maps\mp\_utility::isjuggernaut() )
                    thread _id_2387( var_3 );
            }
        }

        if ( level.teambased )
        {
            if ( isdefined( var_1 ) && isarray( var_1 ) )
                _id_7F81( self.team, var_1 );
            else
                maps\mp\_entityheadicons::setheadicon( self.team, var_1, ( 0.0, 0.0, 60.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
        }
        else if ( isdefined( self.owner ) )
        {
            if ( isdefined( var_1 ) && isarray( var_1 ) )
                _id_7F81( self.owner, var_1 );
            else
                maps\mp\_entityheadicons::setheadicon( self.owner, var_1, ( 0.0, 0.0, 60.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
        }
    }

    thread _id_2386();
}

_id_7F81( var_0, var_1 )
{
    var_2 = 10;
    var_3 = 0;
    self._id_4B3E = [];

    foreach ( var_5 in var_1 )
    {
        self._id_4B3E[var_5] = common_scripts\utility::spawn_tag_origin();
        self._id_4B3E[var_5] maps\mp\_entityheadicons::setheadicon( var_0, var_5, ( 0, 0, 55 + var_3 * var_2 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
        var_3++;
    }
}

_id_8343( var_0 )
{
    var_1 = _id_40F5( self._id_2F97, self._id_2383 );

    foreach ( var_3 in level.players )
    {
        if ( issubstr( var_1, "juggernaut" ) && var_3 maps\mp\_utility::isjuggernaut() )
        {
            self disableplayeruse( var_3 );
            continue;
        }

        if ( !level.teambased && self._id_5D32 == "trap" )
        {
            if ( isdefined( self.owner ) && var_3 == self.owner )
                self disableplayeruse( var_3 );
            else
                self enableplayeruse( var_3 );

            continue;
        }

        if ( !isdefined( var_0 ) || var_0 == var_3.team )
        {
            self enableplayeruse( var_3 );
            continue;
        }

        self disableplayeruse( var_3 );
    }
}

_id_6802( var_0, var_1 )
{
    self waittill( "physics_finished" );
    self._id_2F75 = 0;
    self thread [[ level._id_2385[var_0][var_1].func ]]( var_0 );
    level thread _id_2F94( self, self.owner, var_1 );
    var_2 = getentarray( "trigger_hurt", "classname" );

    foreach ( var_4 in var_2 )
    {
        if ( self._id_3AB6 istouching( var_4 ) )
        {
            _id_2847();
            return;
        }
    }

    if ( isdefined( self.owner ) && abs( self.origin[2] - self.owner.origin[2] ) > 4000 )
    {
        _id_2847();
        return;
    }

    if ( isdefined( level.iszombiegame ) && level.iszombiegame )
        self disconnectpaths();
    else if ( isdefined( level.ishorde ) && level.ishorde )
        self disconnectpaths();

    var_6 = spawnstruct();
    var_6.deathoverridecallback = ::_id_5FA4;
    var_6._id_9403 = ::_id_5FA5;
    thread maps\mp\_movers::handle_moving_platforms( var_6 );
}

_id_5FA4( var_0 )
{
    _id_2847( 1, 1 );
}

_id_5FA5( var_0 )
{
    return _id_1B8B( var_0 ) && _id_1B8C( var_0 ) && _id_1B8D( var_0 );
}

_id_1B8C( var_0 )
{
    return !isdefined( self.targetname ) || !isdefined( var_0._id_2383 ) || self.targetname != "care_package" || var_0._id_2383 != "juggernaut";
}

_id_1B8B( var_0 )
{
    return !isdefined( self.targetname ) || !isdefined( var_0.targetname ) || self.targetname != "care_package" || var_0.targetname != "care_package";
}

_id_1B8D( var_0 )
{
    return !isdefined( self.targetname ) || !isdefined( var_0._id_1B9E ) || self.targetname != "care_package" || !var_0._id_1B9E;
}

_id_2F94( var_0, var_1, var_2 )
{
    if ( isdefined( level._id_611D ) && level._id_611D )
        return;

    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( var_0._id_2F97 == "nuke_drop" )
        return;

    var_3 = 90.0;

    if ( var_2 == "supply" )
        var_3 = 20.0;

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_3 );

    while ( var_0.curprogress != 0 )
        wait 1;

    var_0 _id_2847( 1, 1 );
}

_id_237B( var_0 )
{
    self endon( "captured" );
    var_1 = self;

    if ( isdefined( self._id_65AF ) )
        var_1 = self._id_65AF;

    while ( isdefined( self ) )
    {
        var_1 waittill( "trigger", var_2 );

        if ( isdefined( self.owner ) && var_2 == self.owner )
            continue;

        if ( var_2 isjumping() || isdefined( var_2.exo_hover_on ) && var_2.exo_hover_on )
            continue;

        if ( !var_2 isonground() && !_id_A04A( var_2 ) )
            continue;

        if ( !_id_9C45( var_2 ) )
            continue;

        var_2.iscapturingcrate = 1;
        var_3 = _id_244B();
        var_4 = 0;

        if ( self._id_2383 == "booby_trap" )
            var_4 = var_3 useholdthink( var_2, 500, var_0 );
        else
            var_4 = var_3 useholdthink( var_2, undefined, var_0 );

        if ( isdefined( var_3 ) )
            var_3 delete();

        if ( !var_4 )
        {
            if ( isdefined( var_2 ) )
                var_2.iscapturingcrate = 0;

            continue;
        }

        var_2.iscapturingcrate = 0;

        if ( isdefined( level.ishorde ) && level.ishorde )
        {
            if ( self._id_2383 == "juggernaut" && !( isdefined( var_2.laststand ) && var_2.laststand ) )
                var_2 setdemigod( 1 );

            if ( isdefined( var_2.laststand ) && var_2.laststand )
                continue;
        }

        self notify( "captured", var_2 );
    }
}

_id_237C( var_0 )
{
    self endon( "captured" );

    if ( !isdefined( self.owner ) )
        return;

    self.owner endon( "disconnect" );
    var_1 = self;

    if ( isdefined( self._id_6636 ) )
        var_1 = self._id_6636;

    var_2 = 500;

    if ( isdefined( self._id_5D55 ) && self._id_5D55 )
        var_2 = 100;

    while ( isdefined( self ) )
    {
        var_1 waittill( "trigger", var_3 );

        if ( isdefined( self.owner ) && var_3 != self.owner )
            continue;

        if ( var_3 isjumping() || isdefined( var_3.exo_hover_on ) && var_3.exo_hover_on )
            continue;

        if ( !var_3 isonground() && !_id_A04A( var_3 ) )
            continue;

        if ( !_id_9C45( var_3 ) )
            continue;

        var_3.iscapturingcrate = 1;

        if ( !useholdthink( var_3, var_2, var_0 ) )
        {
            var_3.iscapturingcrate = 0;
            continue;
        }

        var_3.iscapturingcrate = 0;

        if ( isdefined( level.ishorde ) && level.ishorde )
        {
            if ( self._id_2383 == "juggernaut" && !( isdefined( var_3.laststand ) && var_3.laststand ) )
                var_3 setdemigod( 1 );

            if ( isdefined( var_3.laststand ) && var_3.laststand )
                continue;
        }

        self notify( "captured", var_3 );
    }
}

_id_A04A( var_0 )
{
    if ( var_0 isonground() )
        return 0;

    var_1 = 200;
    var_2 = var_0.origin;
    var_3 = gettime();

    while ( isdefined( var_0 ) && maps\mp\_utility::isreallyalive( var_0 ) && !var_0 isonground() && var_2 == var_0.origin && var_0 usebuttonpressed() )
    {
        var_4 = gettime() - var_3;

        if ( var_4 >= var_1 )
            return 1;

        waitframe();
    }

    return 0;
}

_id_9C45( var_0 )
{
    var_1 = var_0 getcurrentprimaryweapon();

    if ( issubstr( var_1, "turrethead" ) )
        return 1;

    if ( !var_0 maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon() )
        return 0;

    if ( isdefined( var_0.changingweapon ) && !var_0 maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon() )
        return 0;

    return 1;
}

_id_5396( var_0 )
{
    self endon( "death" );
    var_1 = _id_40F5( var_0, self._id_2383 );
    var_2 = _id_4028( var_0, self._id_2383 );
    var_3 = isdefined( self.owner ) && ( self.owner maps\mp\_utility::_hasperk( "specialty_highroller" ) || isdefined( self._id_5D56 ) && self._id_5D56 );
    var_4 = undefined;

    if ( var_3 )
        var_4 = &"MP_PACKAGE_REROLL";

    var_5 = undefined;

    if ( isdefined( game["strings"][var_0 + self._id_2383 + "_hint"] ) )
        var_5 = game["strings"][var_0 + self._id_2383 + "_hint"];
    else
        var_5 = &"PLATFORM_GET_KILLSTREAK";

    _id_2380( var_5, var_4 );
    _id_237F( "all", maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon( var_1, var_2 ) );

    if ( isdefined( self.owner ) )
        thread _id_237B();

    thread _id_237C();

    if ( var_3 )
        thread _id_237D();

    if ( self._id_51D6 )
        _id_2382();

    for (;;)
    {
        self waittill( "captured", var_6 );
        var_1 = _id_40F5( var_0, self._id_2383 );
        var_2 = _id_4028( var_0, self._id_2383 );

        if ( isdefined( self.owner ) && var_6 != self.owner )
        {
            if ( !level.teambased || var_6.team != self.team )
            {
                if ( self._id_51D6 )
                {
                    var_6 thread _id_29B3( self, self.owner );
                    return;
                }
                else
                    var_6 thread maps\mp\_events::hijackerevent( self.owner );
            }
            else
                self.owner thread maps\mp\_events::sharedevent();
        }

        var_6 playlocalsound( "orbital_pkg_use" );
        var_7 = var_6 maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex( var_1, 0 );
        var_6 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify( var_1, undefined, undefined, var_2, var_7 );
        var_6 thread maps\mp\killstreaks\_killstreaks::givekillstreak( var_1, 0, 0, self.owner, var_2 );

        if ( isdefined( level.mapkillstreak ) && level.mapkillstreak == self._id_2383 )
            var_6 thread maps\mp\_events::mapkillstreakevent();

        var_8 = 1;
        var_9 = var_6 maps\mp\_utility::_hasperk( "specialty_highroller" ) && ( !level.teambased || var_6.team != self.team );
        var_10 = isdefined( self._id_5D58 ) && self._id_5D58;
        var_11 = var_10 && ( self.owner == var_6 || level.teambased && var_6.team == self.team );

        if ( var_9 || var_11 )
        {
            var_12 = var_6 _id_23E2( var_6, "booby_trap", "booby_trap", self.origin, self.angles );

            if ( isdefined( var_12._id_32B4 ) )
                var_12._id_32B4 thread maps\mp\killstreaks\_orbital_carepackage::_id_6559( 1 );

            var_12 thread _id_1565( self );
            level thread _id_2F94( var_12, var_12.owner, var_12._id_2383 );
            var_8 = 0;

            if ( isdefined( var_12._id_3AB6 ) )
                var_12._id_3AB6 solid();

            if ( isdefined( var_12._id_32B4 ) )
                var_12._id_32B4 solid();
        }

        _id_2847( var_8 );
    }
}

_id_29B3( var_0, var_1 )
{
    var_0 endon( "death" );
    var_2 = var_0.origin + ( 0.0, 0.0, 50.0 );

    if ( level.teambased )
        var_0 maps\mp\_entityheadicons::setheadicon( self.team, "specialty_trap_crate", ( 0.0, 0.0, 60.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
    else
        var_0 maps\mp\_entityheadicons::setheadicon( self, "specialty_trap_crate", ( 0.0, 0.0, 60.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );

    thread common_scripts\utility::play_sound_in_space( "orbital_pkg_trap_armed", var_2 );
    wait 1.0;
    var_3 = var_2 + ( 0.0, 0.0, 1.0 ) - var_2;
    playfx( common_scripts\utility::getfx( "airdrop_crate_trap_explode" ), var_2, var_3 );
    thread common_scripts\utility::play_sound_in_space( "orbital_pkg_trap_detonate", var_2 );

    if ( isdefined( var_0._id_3AB6 ) )
        var_0._id_3AB6 notsolid();

    if ( isdefined( var_0._id_32B4 ) )
        var_0._id_32B4 notsolid();

    if ( isdefined( var_1 ) )
        var_0._id_9720 entityradiusdamage( var_2, 400, 300, 50, var_1, "MOD_EXPLOSIVE", "airdrop_trap_explosive_mp" );
    else
        var_0._id_9720 entityradiusdamage( var_2, 400, 300, 50, undefined, "MOD_EXPLOSIVE", "airdrop_trap_explosive_mp" );

    var_0 _id_2847();
}

_id_2847( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( isdefined( self._id_6305 ) )
        maps\mp\_utility::_objective_delete( self._id_6305 );

    if ( isdefined( self._id_6304 ) )
        maps\mp\_utility::_objective_delete( self._id_6304 );

    if ( isdefined( self._id_9720 ) )
        self._id_9720 delete();

    if ( isdefined( self.killcament ) )
        self.killcament delete();

    if ( isdefined( self._id_6636 ) )
        self._id_6636 delete();

    if ( isdefined( self._id_65AF ) )
        self._id_65AF delete();

    if ( isdefined( self._id_2F97 ) )
    {
        if ( var_0 )
            playfx( common_scripts\utility::getfx( "ocp_death" ), self.origin );

        if ( var_1 )
            playsoundatpos( self.origin, "orbital_pkg_self_destruct" );
    }

    if ( isdefined( self._id_4B3E ) )
    {
        foreach ( var_3 in self._id_4B3E )
            var_3 delete();
    }

    self delete();
}

useholdthink( var_0, var_1, var_2 )
{
    if ( isplayer( var_0 ) )
        var_0 playerlinkto( self );
    else
        var_0 linkto( self );

    var_0 playerlinkedoffsetenable();

    if ( !var_0 maps\mp\_utility::isjuggernaut() )
        var_0 common_scripts\utility::_disableweapon();

    thread _id_9BFD( var_0 );
    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 0;

    if ( isdefined( var_1 ) )
    {
        if ( var_0 maps\mp\_utility::_hasperk( "specialty_unwrapper" ) && isdefined( var_0._id_8A39 ) )
            var_1 *= var_0._id_8A39;

        if ( isdefined( level.podcapturetimemodifier ) )
            var_1 *= level.podcapturetimemodifier;

        self.usetime = var_1;
    }
    else if ( var_0 maps\mp\_utility::_hasperk( "specialty_unwrapper" ) && isdefined( var_0._id_8A39 ) )
        self.usetime = 3000 * var_0._id_8A39;
    else
        self.usetime = 3000;

    if ( isplayer( var_0 ) )
        var_0 thread personalusebar( self, var_2 );

    var_3 = useholdthinkloop( var_0 );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( self ) )
        return 0;

    self notify( "useHoldThinkLoopDone" );
    self.inuse = 0;
    self.curprogress = 0;
    return var_3;
}

_id_9BFD( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::waittill_any( "death", "captured", "useHoldThinkLoopDone" );

    if ( isalive( var_0 ) )
    {
        if ( !var_0 maps\mp\_utility::isjuggernaut() )
            var_0 common_scripts\utility::_enableweapon();

        if ( var_0 islinked() )
            var_0 unlink();
    }
}

personalusebar( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( isdefined( var_1 ) )
        iprintlnbold( "Fixme @agersant " + var_1 );

    self setclientomnvar( "ui_use_bar_text", 1 );
    self setclientomnvar( "ui_use_bar_start_time", int( gettime() ) );
    var_2 = -1;

    while ( maps\mp\_utility::isreallyalive( self ) && isdefined( var_0 ) && var_0.inuse && !level.gameended )
    {
        if ( var_2 != var_0.userate )
        {
            if ( var_0.curprogress > var_0.usetime )
                var_0.curprogress = var_0.usetime;

            if ( var_0.userate > 0 )
            {
                var_3 = gettime();
                var_4 = var_0.curprogress / var_0.usetime;
                var_5 = var_3 + ( 1 - var_4 ) * var_0.usetime / var_0.userate;
                self setclientomnvar( "ui_use_bar_end_time", int( var_5 ) );
            }

            var_2 = var_0.userate;
        }

        wait 0.05;
    }

    self setclientomnvar( "ui_use_bar_end_time", 0 );
}

ishordelaststand( var_0 )
{
    return isdefined( level.ishorde ) && level.ishorde && isdefined( var_0.laststand ) && var_0.laststand;
}

useholdthinkloop( var_0 )
{
    var_0 endon( "stop_useHoldThinkLoop" );

    while ( !level.gameended && isdefined( self ) && maps\mp\_utility::isreallyalive( var_0 ) && !ishordelaststand( var_0 ) && var_0 usebuttonpressed() && self.curprogress < self.usetime )
    {
        self.curprogress += 50 * self.userate;

        if ( isdefined( self.objectivescaler ) )
            self.userate = 1 * self.objectivescaler;
        else
            self.userate = 1;

        if ( self.curprogress >= self.usetime )
            return maps\mp\_utility::isreallyalive( var_0 );

        wait 0.05;
    }

    return 0;
}

isairdropmarker( var_0 )
{
    switch ( var_0 )
    {
        case "airdrop_marker_mp":
        case "airdrop_mp":
            return 1;
        default:
            return 0;
    }
}

_id_244B()
{
    var_0 = spawn( "script_origin", self.origin );
    var_0.curprogress = 0;
    var_0.usetime = 0;
    var_0.userate = 3000;
    var_0.inuse = 0;
    var_0 thread _id_2872( self );
    return var_0;
}

_id_2872( var_0 )
{
    self endon( "death" );
    var_0 waittill( "death" );
    self delete();
}

_id_237D()
{
    self._id_6643 = 0;
    self._id_6644 = 0;

    while ( !level.gameended && isdefined( self ) )
    {
        if ( maps\mp\_utility::isreallyalive( self.owner ) && distancesquared( self.origin, self.owner.origin ) < 10000 )
        {
            if ( self.owner usebuttonpressed() )
                self._id_6643++;
            else if ( self._id_6643 > 0 )
            {
                if ( self._id_6643 < 5 )
                {
                    if ( self._id_6644 == 1 )
                    {
                        self notify( "package_double_tap" );
                        var_0 = self._id_2383;

                        for ( var_1 = 0; self._id_2383 == var_0 && var_1 < 100; self._id_2383 = _id_40A3( self._id_2F97 ) )
                            var_1++;

                        var_2 = _id_40F5( self._id_2F97, self._id_2383 );
                        var_3 = _id_4028( self._id_2F97, self._id_2383 );
                        var_4 = game["strings"][self._id_2F97 + self._id_2383 + "_hint"];

                        if ( !isdefined( var_4 ) )
                            var_4 = &"PLATFORM_GET_KILLSTREAK";

                        if ( isdefined( self._id_6636 ) )
                        {
                            self._id_6636 sethintstring( var_4 );
                            self._id_65AF sethintstring( var_4 );
                            self._id_6636 _meth_80DC( "" );
                        }
                        else
                        {
                            self sethintstring( var_4 );
                            self _meth_80DC( "" );
                        }

                        if ( level.teambased )
                            maps\mp\_entityheadicons::setheadicon( self.team, maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon( var_2, var_3 ), ( 0.0, 0.0, 60.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
                        else if ( isdefined( self.owner ) )
                            maps\mp\_entityheadicons::setheadicon( self.owner, maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon( var_2, var_3 ), ( 0.0, 0.0, 60.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );

                        self.owner playlocalsound( "orbital_pkg_reroll" );
                        return 1;
                    }
                    else
                    {
                        self._id_6644 = 1;
                        thread _id_918F();
                    }
                }

                self._id_6643 = 0;
            }
        }

        wait 0.05;
    }
}

_id_918F()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "package_double_tap" );
    wait 0.2;
    self._id_6644 = 0;
}

_id_1565( var_0 )
{
    self endon( "death" );
    var_1 = _id_40F5( var_0._id_2F97, var_0._id_2383 );
    var_2 = _id_4028( var_0._id_2F97, var_0._id_2383 );
    var_3 = maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon( var_1, var_2 );
    var_4 = undefined;

    if ( isdefined( game["strings"][var_0._id_2F97 + var_0._id_2383 + "_hint"] ) )
        var_4 = game["strings"][var_0._id_2F97 + var_0._id_2383 + "_hint"];
    else
        var_4 = &"PLATFORM_GET_KILLSTREAK";

    _id_2380( var_4 );
    _id_237F( "trap", var_3 );
    _id_2382();
    thread _id_237B( var_0 );

    for (;;)
    {
        self waittill( "captured", var_5 );
        var_5 thread _id_29B3( self, self.owner );
    }
}

_id_2382( var_0 )
{
    var_1 = bullettrace( self.origin, self.origin + ( 0.0, 0.0, 90.0 ), 0, self );
    self._id_9720 = spawn( "script_model", var_1["position"] );
    self._id_9720 setcontents( 0 );
    self._id_9720 setscriptmoverkillcam( "large explosive" );
}

_id_98BB( var_0, var_1, var_2 )
{
    return maps\mp\killstreaks\_orbital_carepackage::_id_98B5( var_0, "airdrop_reinforcement_common", var_2 );
}

_id_98BE( var_0, var_1, var_2 )
{
    return maps\mp\killstreaks\_orbital_carepackage::_id_98B5( var_0, "airdrop_reinforcement_uncommon", var_2 );
}

_id_98BD( var_0, var_1, var_2 )
{
    return maps\mp\killstreaks\_orbital_carepackage::_id_98B5( var_0, "airdrop_reinforcement_rare", var_2 );
}

_id_98BC( var_0, var_1, var_2 )
{
    return maps\mp\killstreaks\_orbital_carepackage::_id_98B5( var_0, "airdrop_reinforcement_practice", var_2 );
}

_id_7302( var_0 )
{
    _id_5396( var_0 );
}

_id_7303( var_0 )
{
    self endon( "death" );
    var_1 = _id_407C( var_0, self._id_2383 );
    var_2 = undefined;

    if ( var_0 == "airdrop_reinforcement_rare" )
        var_2 = _id_40C3( var_0 );

    var_3 = undefined;

    if ( isdefined( var_2 ) )
    {
        var_4 = game["strings"][var_0 + self._id_2383 + "_hint"];
        var_5 = _id_40C4( var_2 );

        if ( isdefined( var_4 ) && isdefined( var_5 ) )
            self _meth_8515( var_4, var_5 );
        else
            _id_2380( &"MP_PERK_PICKUP_GENERIC_MULTIPLE" );

        var_3 = [];
        var_3[0] = _id_407B( var_1 );

        if ( !isdefined( var_3[0] ) )
            var_3[0] = "";

        var_3[1] = _id_407B( var_2 );

        if ( !isdefined( var_3[1] ) )
            var_3[1] = "";
    }
    else
    {
        var_4 = game["strings"][var_0 + self._id_2383 + "_hint"];

        if ( isdefined( var_4 ) )
            self _meth_8515( var_4 );
        else
            _id_2380( &"MP_PERK_PICKUP_GENERIC" );

        var_3 = _id_407B( var_1 );

        if ( !isdefined( var_3 ) )
            var_3 = "";
    }

    _id_237F( "all", var_3 );

    if ( isdefined( self.owner ) )
        thread _id_237B();

    thread _id_237C();

    for (;;)
    {
        self waittill( "captured", var_6 );

        if ( isdefined( self.owner ) && var_6 != self.owner )
        {
            if ( !level.teambased || var_6.team != self.team )
                var_6 thread maps\mp\_events::hijackerevent( self.owner );
            else
                self.owner thread maps\mp\_events::sharedevent();
        }

        var_6 playlocalsound( "orbital_pkg_use" );
        var_6 _id_0CA6( var_1 );
        var_7 = int( tablelookuprownum( "mp/perktable.csv", 1, var_1 ) );
        var_6 setclientomnvar( "ui_reinforcement_active_perk_1", var_7 );

        if ( isdefined( var_2 ) )
        {
            var_6 _id_0CA6( var_2 );
            var_7 = int( tablelookuprownum( "mp/perktable.csv", 1, var_2 ) );
            var_6 setclientomnvar( "ui_reinforcement_active_perk_2", var_7 );
        }
        else
            var_6 setclientomnvar( "ui_reinforcement_active_perk_2", -1 );

        _id_2847( 1 );
    }
}

_id_407C( var_0, var_1 )
{
    if ( isdefined( level._id_2385[var_0][var_1]._id_8F23 ) )
        return level._id_2385[var_0][var_1]._id_8F23;

    return var_1;
}

_id_40C3( var_0 )
{
    if ( isdefined( level._id_2385[var_0] ) && isdefined( level._id_2385[var_0][self._id_2383] ) )
    {
        var_1 = [];

        foreach ( var_3 in level._id_2385[var_0] )
        {
            if ( !issubstr( var_3._id_8F23, "specialty_" ) )
                var_1[var_1.size] = var_3.type;
        }

        var_1[var_1.size] = self._id_2383;
        var_5 = _id_40A3( var_0, var_1 );

        if ( isdefined( var_5 ) && isdefined( level._id_2385[var_0][var_5]._id_8F23 ) )
            return level._id_2385[var_0][var_5]._id_8F23;
    }

    return undefined;
}

_id_40C4( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level._id_7BF5[var_0] ) )
        var_1 = level._id_7BF5[var_0];

    return var_1;
}

_id_407B( var_0 )
{
    var_1 = "mp/perktable.csv";
    var_2 = 1;
    var_3 = 11;
    return tablelookup( var_1, var_2, var_0, var_3 );
}

_id_0CA6( var_0 )
{
    self.reinforcementperks[var_0] = 1;

    if ( var_0 == "specialty_extended_battery" )
    {
        maps\mp\_utility::giveperk( "specialty_extended_battery", 0 );
        maps\mp\_utility::giveperk( "specialty_exo_slamboots", 0 );
        return;
    }

    if ( var_0 == "specialty_class_lowprofile" )
    {
        maps\mp\_utility::giveperk( "specialty_radarimmune", 0 );
        maps\mp\_utility::giveperk( "specialty_exoping_immune", 0 );
        return;
    }

    if ( var_0 == "specialty_class_flakjacket" )
    {
        maps\mp\_utility::giveperk( "specialty_hard_shell", 0 );
        maps\mp\_utility::giveperk( "specialty_throwback", 0 );
        maps\mp\_utility::giveperk( "_specialty_blastshield", 0 );
        self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty( "perk_blastShieldScale", 45 ) / 100;

        if ( isdefined( level.hardcoremode ) && level.hardcoremode )
            self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty( "perk_blastShieldScale_HC", 90 ) / 100;

        return;
    }

    if ( var_0 == "specialty_class_lightweight" )
    {
        maps\mp\_utility::giveperk( "specialty_lightweight", 0 );
        return;
    }

    if ( var_0 == "specialty_class_dangerclose" )
    {
        maps\mp\_utility::giveperk( "specialty_explosivedamage", 0 );
        return;
    }

    if ( var_0 == "specialty_class_blindeye" )
    {
        maps\mp\_utility::giveperk( "specialty_blindeye", 0 );
        maps\mp\_utility::giveperk( "specialty_plainsight", 0 );
        return;
    }

    if ( var_0 == "specialty_class_coldblooded" )
    {
        maps\mp\_utility::giveperk( "specialty_coldblooded", 0 );
        maps\mp\_utility::giveperk( "specialty_spygame", 0 );
        maps\mp\_utility::giveperk( "specialty_heartbreaker", 0 );
        return;
    }

    if ( var_0 == "specialty_class_peripherals" )
    {
        maps\mp\_utility::giveperk( "specialty_moreminimap", 0 );
        maps\mp\_utility::giveperk( "specialty_silentkill", 0 );
        return;
    }

    if ( var_0 == "specialty_class_fasthands" )
    {
        maps\mp\_utility::giveperk( "specialty_quickswap", 0 );
        maps\mp\_utility::giveperk( "specialty_fastoffhand", 0 );
        maps\mp\_utility::giveperk( "specialty_sprintreload", 0 );
        return;
    }

    if ( var_0 == "specialty_class_dexterity" )
    {
        maps\mp\_utility::giveperk( "specialty_sprintfire", 0 );
        return;
    }

    if ( var_0 == "specialty_class_hardwired" )
    {
        maps\mp\_utility::giveperk( "specialty_empimmune", 0 );
        maps\mp\_utility::giveperk( "specialty_stun_resistance", 0 );
        self.stunscaler = 0.1;
        return;
    }

    if ( var_0 == "specialty_class_toughness" )
    {
        self setviewkickscale( 0.2 );
        return;
    }

    if ( var_0 == "specialty_class_scavenger" )
    {
        self.ammopickup_scalar = 0.2;
        maps\mp\_utility::giveperk( "specialty_scavenger", 0 );
        maps\mp\_utility::giveperk( "specialty_bulletresupply", 0 );
        maps\mp\_utility::giveperk( "specialty_extraammo", 0 );
        return;
    }

    if ( var_0 == "specialty_class_hardline" )
    {
        maps\mp\_utility::giveperk( "specialty_hardline", 0 );
        maps\mp\killstreaks\_killstreaks::updatestreakcount();
        return;
    }
}
