// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "sidewinder_scripted", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_sidewinder_scripted" );
    maps\_vehicle::build_treadfx();
    level._effect["engineeffect"] = loadfx( "vfx/trail/jet_thruster_far" );
    level._effect["afterburner"] = loadfx( "vfx/fire/jet_afterburner_ignite" );
    level._effect["contrail"] = loadfx( "vfx/trail/jet_contrail" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_generic_ai_explo_lrg_runner", undefined, "explo_metal_rand" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_is_airplane();
}

init_local()
{
    thread playthrustereffects();
}

playthrustereffects()
{
    self endon( "death" );
    self endon( "stop_engineeffects" );
    var_0 = common_scripts\utility::getfx( "contrail" );
    playfxontag( var_0, self, "tag_origin" );
}

stop_sound( var_0 )
{
    self notify( "stop sound" + var_0 );
}
