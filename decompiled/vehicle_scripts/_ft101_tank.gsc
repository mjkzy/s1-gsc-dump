// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "ft101_tank", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_ft101_tank", "vehicle_ft101_tank_dstrypv" );
    maps\_vehicle::build_shoot_shock( "tankblast" );
    maps\_vehicle::build_exhaust( "vfx/distortion/tank_exhaust" );
    maps\_vehicle::build_deckdust( "vfx/dust/tank_deck_dust" );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_ft101_ai_explo_runner", "TAG_DEATH_FX", "exp_armor_vehicle", undefined, undefined, undefined, 0 );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_rumble( "tank_rumble", 0.15, 4.5, 900, 1, 1 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_mainturret();
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_frontarmor( 0.33 );
    maps\_vehicle::build_light( var_2, "headlight_TOP_L", "TAG_LIGHT_RIGHT_TOP", "vfx/lights/headlight_gaz_yellow", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_TOP_R", "TAG_LIGHT_LEFT_TOP", "vfx/lights/headlight_gaz_yellow", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_L", "TAG_LIGHT_RIGHT", "vfx/lights/headlight_gaz_yellow", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_R", "TAG_LIGHT_LEFT", "vfx/lights/headlight_gaz_yellow", "headlights", 0.0 );
}

init_local()
{
    thread handle_vehicle_ai();
    self.has_unmatching_deathmodel_rig = 1;
}

set_vehicle_anims( var_0 )
{
    return var_0;
}

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 11; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].getout_delete = 1;
    return var_0;
}

handle_vehicle_ai()
{
    if ( isdefined( self.ai_func_override ) )
        self thread [[ self.ai_func_override ]]();
    else
    {
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_target( 1.5 );
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_shoot( 3, 5, 3, 5 );
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
    }
}
