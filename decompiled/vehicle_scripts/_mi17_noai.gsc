// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "mi17_noai", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_mil_mi17" );
    maps\_vehicle::build_deathmodel( "vehicle_mi17_woodland" );
    maps\_vehicle::build_deathmodel( "vehicle_mi17_woodland_fly" );
    maps\_vehicle::build_deathmodel( "vehicle_mi17_woodland_fly_cheap" );
    maps\_vehicle::build_deathmodel( "vehicle_mi17_woodland_landing" );
    var_3 = [];
    var_3["vehicle_mil_mi17"] = "vfx/explosion/vehicle_explosion_heli_piece_impact";
    var_3["vehicle_mi17_woodland"] = "vfx/explosion/vehicle_mi17_explosion_a";
    var_3["vehicle_mi17_woodland_fly"] = "vfx/explosion/vehicle_explosion_heli_piece_impact";
    var_3["vehicle_mi17_woodland_fly_cheap"] = "vfx/explosion/vehicle_mi17_explosion_a";
    var_3["vehicle_mi17_woodland_landing"] = "vfx/explosion/vehicle_mi17_explosion_a";
    var_3["vehicle_mi-28_flying"] = "vfx/explosion/vehicle_mi17_explosion_a";
    var_4 = var_3[var_0];
    maps\_vehicle::build_deathfx( "vfx/trail/trail_fire_smoke_l", "tag_engine_right", "mi17_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1, undefined );
    maps\_vehicle::build_deathfx( "vfx/explosion/helicopter_explosion_secondary_small", "tag_engine_right", "mi17_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1, undefined );
    maps\_vehicle::build_deathfx( "vfx/explosion/helicopter_explosion_secondary_small", "tag_deathfx", "mi17_helicopter_secondary_exp", undefined, undefined, undefined, 4.0, undefined, undefined );
    maps\_vehicle::build_deathfx( var_4, undefined, "mi17_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound" );
    maps\_vehicle::build_drive( %mi17_heli_rotors, undefined, 0 );
    maps\_vehicle::build_deathfx( "vfx/explosion/helicopter_explosion_secondary_small", "tag_engine_left", "mi17_helicopter_impact_explo_3d", undefined, undefined, undefined, 0.2, 1 );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_mi17_explosion_a", "tag_deathfx", undefined, undefined, undefined, undefined, 0.5, 1 );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_rumble( "tank_rumble", 0.15, 4.5, 600, 1, 1 );
    maps\_vehicle::build_team( "axis" );
    maps\_vehicle::build_bulletshield( 1 );
    var_5 = randomfloatrange( 0, 1 );
    maps\_vehicle::build_is_helicopter();
}

init_local()
{
    self.originheightoffset = distance( self gettagorigin( "tag_origin" ), self gettagorigin( "tag_ground" ) );
    self.fastropeoffset = 710;
    self.script_badplace = 0;
    maps\_vehicle::vehicle_lights_on( "running" );
    maps\_vehicle::vehicle_lights_on( "interior" );
}
