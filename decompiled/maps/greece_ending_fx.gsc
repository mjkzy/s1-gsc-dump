// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread precachefx();
}

precachefx()
{
    level._effect["vehicle_explosion_technical"] = loadfx( "vfx/map/greece/greece_vehicle_explo_med" );
    level._effect["small_vehicle_explosion"] = loadfx( "vfx/map/greece/greece_vehicle_explo_charge" );
    level._effect["vehicle_engine_smoke_1"] = loadfx( "vfx/map/greece/greece_veh_engine_damage_smk_1" );
    level._effect["vehicle_engine_smoke_2"] = loadfx( "vfx/map/greece/greece_veh_engine_damage_smk_2" );
    level._effect["vehicle_engine_smoke_3"] = loadfx( "vfx/map/greece/greece_veh_engine_damage_smk_3" );
    level._effect["vehicle_tire_smoke_1"] = loadfx( "vfx/map/greece/greece_veh_tire_damage_smk_1" );
    level._effect["vehicle_tire_smoke_1a"] = loadfx( "vfx/map/greece/greece_veh_tire_damage_smk_1a" );
    level._effect["vehicle_tire_smoke_2"] = loadfx( "vfx/map/greece/greece_veh_tire_damage_smk_2" );
    level._effect["fruit_table_impact_lrg_x"] = loadfx( "vfx/food/fruit_table_impact_lrg_x" );
    level._effect["ending_hades_throat_slash"] = loadfx( "vfx/map/greece/greece_flesh_throat_blood_slash" );
    level._effect["ending_ilana_throat_slash"] = loadfx( "vfx/map/greece/greece_flesh_throat_blood_slash2" );
    level._effect["ending_ilana_stabbed"] = loadfx( "vfx/map/greece/greece_flesh_throat_blood_spurt" );
    level._effect["ending_ilana_stabbed_takeout"] = loadfx( "vfx/map/greece/greece_flesh_throat_blood_spurt2" );
    level._effect["ending_vm_arm_cut"] = loadfx( "vfx/map/greece/greece_flesh_prosthetic_sparks" );
    level._effect["ending_hades_stabbed_takeout"] = loadfx( "vfx/map/greece/greece_flesh_throat_blood_fall_rnr" );
    level._effect["ending_hades_stabbed_takeout2"] = loadfx( "vfx/map/greece/greece_flesh_throat_blood_fall2_rnr" );
}

endingambushbreachexplosionfx()
{
    var_0 = common_scripts\utility::getstruct( "AmbushBreachFX", "targetname" );
    playfx( common_scripts\utility::getfx( "small_vehicle_explosion" ), var_0.origin );
    earthquake( 0.5, 0.3, level.player.origin, 1000 );
    level.player _meth_80AD( "damage_heavy" );
}

endingcrashtruckexplosionfx()
{
    var_0 = common_scripts\utility::getstruct( "CrashTruckFX", "targetname" );
    var_1 = common_scripts\utility::getstruct( "CrashTruckWindows", "targetname" );
    playfx( common_scripts\utility::getfx( "vehicle_explosion_technical" ), var_0.origin );
    soundscripts\_snd::snd_message( "convoy_truck_explosion", var_0 );
    var_2 = getentarray( "EndingShopDoor1", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 delete();

    glassradiusdamage( var_0.origin, 100, 1000, 100 );
    glassradiusdamage( var_1.origin, 200, 1000, 100 );
    radiusdamage( var_0.origin, 200, 100, 10 );
    physicsexplosionsphere( var_0.origin, 300, 0, randomfloatrange( 2, 5 ) );
    earthquake( 0.5, 0.3, var_0.origin, 800 );
    level.player _meth_80AD( "damage_light" );
    common_scripts\utility::flag_set( "FlagEndingTruckExplode" );
    var_6 = getent( "convoy_vehicle_3", "targetname" );
    var_6.animname = "convoy_vehicle_3";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_3" ), var_6, "TAG_ORIGIN" );
    thread maps\greece_ending::endingtruckfiredamagevol();
}

endingvehicledamagefx()
{
    var_0 = getent( "hades_vehicle", "targetname" );
    var_0.animname = "hades_vehicle";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_1" ), var_0, "TAG_ORIGIN" );
    playfxontag( common_scripts\utility::getfx( "vehicle_tire_smoke_1" ), var_0, "TAG_ORIGIN" );
    var_1 = getent( "convoy_vehicle_2", "targetname" );
    var_1.animname = "convoy_vehicle_2";
    playfxontag( common_scripts\utility::getfx( "vehicle_tire_smoke_1a" ), var_1, "TAG_ORIGIN" );
    var_2 = getent( "convoy_vehicle_3", "targetname" );
    var_2.animname = "convoy_vehicle_3";
    playfxontag( common_scripts\utility::getfx( "vehicle_tire_smoke_1a" ), var_2, "TAG_ORIGIN" );
    wait 4.0;
    var_1 = getent( "convoy_vehicle_2", "targetname" );
    var_1.animname = "convoy_vehicle_2";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_1" ), var_1, "TAG_ORIGIN" );
    var_2 = getent( "convoy_vehicle_3", "targetname" );
    var_2.animname = "convoy_vehicle_3";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_2" ), var_2, "TAG_ORIGIN" );
}

endingvehicledamageresidualfx()
{
    var_0 = getent( "hades_vehicle", "targetname" );
    var_0.animname = "hades_vehicle";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_1" ), var_0, "TAG_ORIGIN" );
    var_1 = getent( "convoy_vehicle_2", "targetname" );
    var_1.animname = "convoy_vehicle_2";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_1" ), var_1, "TAG_ORIGIN" );
    var_2 = getent( "convoy_vehicle_3", "targetname" );
    var_2.animname = "convoy_vehicle_3";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_2" ), var_2, "TAG_ORIGIN" );
}

stumbleonfirefx()
{
    playfxontag( common_scripts\utility::getfx( "character_fire_torso2" ), self, "J_SpineUpper" );
    soundscripts\_snd::snd_message( "enemy_on_fire" );
}

endingshopcrashfx()
{
    common_scripts\_exploder::exploder( 220 );
}

endingfirehydrantfx()
{
    common_scripts\_exploder::exploder( 221 );
}

endingplayercarpinnedfx()
{
    wait 1.5;
    common_scripts\_exploder::exploder( 222 );
    var_0 = getent( "enemy_vehicle", "targetname" );
    var_0.animname = "enemy_vehicle";
    playfxontag( common_scripts\utility::getfx( "vehicle_tire_smoke_2" ), var_0, "TAG_ORIGIN" );
    wait 8.75;
    var_0 = getent( "enemy_vehicle", "targetname" );
    var_0.animname = "enemy_vehicle";
    playfxontag( common_scripts\utility::getfx( "vehicle_engine_smoke_1" ), var_0, "TAG_ORIGIN" );
}

hadesthroatslashfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "ending_hades_throat_slash" ), var_0, "J_Neck" );
    soundscripts\_snd::snd_message( "hades_throat_slash" );
    earthquake( 0.1, 0.1, level.player.origin, 128 );
    wait 5.0;
    common_scripts\_exploder::exploder( 224 );
}

ilanahitwallfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "safehouse_character_dust_impact3" ), var_0, "J_SpineUpper" );
    common_scripts\_exploder::exploder( 228 );
    wait 1.1;
    playfxontag( common_scripts\utility::getfx( "knife_block_sparks" ), var_0, "J_WristTwist_RI" );
}

ilanahitcarfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "safehouse_character_dust_impact3" ), var_0, "J_SpineUpper" );
}

ilanathroatslashfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "ending_ilana_throat_slash" ), var_0, "J_Head" );
}

ilanastabbedfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "ending_ilana_stabbed_takeout" ), var_0, "J_SpineUpper" );
    wait 2.0;
    common_scripts\_exploder::exploder( 227 );
}

ilanastabbedtakeoutfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "ending_ilana_stabbed_takeout" ), var_0, "J_SpineUpper" );
}

hadesstabbedtakeoutfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "ending_hades_stabbed_takeout" ), var_0, "J_WristTwist_RI" );
}

vmstabbedfacefx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "ending_hades_stabbed_takeout2" ), var_0, "J_WristTwist_RI" );
}

vmknifeblockfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "ending_vm_arm_cut" ), var_0, "J_WristTwist_LE" );
}
