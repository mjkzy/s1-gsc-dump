// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    build_technical( var_0, var_1, var_2, "vehicle_civ_full_size_technical_turret", "50cal_turret_technical_lagos" );
}

#using_animtree("vehicles");

build_technical( var_0, var_1, var_2, var_3, var_4 )
{
    maps\_vehicle::build_template( "civ_full_size_technical", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_drive( %technical_driving_idle_forward, %technical_driving_idle_backward, 10 );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/tread_dust_default" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "axis" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_small_runner", "TAG_DEATH_FX", undefined, undefined, undefined, undefined, 0 );

    if ( issubstr( var_2, "script_vehicle_civ_full_size_technical_turret" ) )
        maps\_vehicle::build_turret( var_4, "tag_turret", var_3, undefined, "auto_ai", 0.5, 20, -14 );

    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
}

init_local()
{
    soundscripts\_snd::snd_message( "atlas_van_explode" );

    if ( !isdefined( self.script_allow_rider_deaths ) )
        self.script_allow_rider_deaths = 1;
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %technical_exit_driver_technical;
    var_0[1].vehicle_turret_fire = %technical_fire_turret;
    var_0[2].vehicle_getoutanim = %technical_exit_passenger_technical;
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = 3;
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0; var_2++ )
        var_1[var_2] = spawnstruct();

    var_1[0].sittag = "tag_driver";
    var_1[0].idle = %technical_idle_driver;
    var_1[0].getout = %technical_exit_driver;
    var_1[1].sittag = "tag_guy_turret_gun";
    var_1[1].sittag_on_turret = 1;
    var_1[1].death = %technical_death_gunner;
    var_1[1].idle = %technical_idle_gunner;
    var_1[1].mgturret = 0;
    var_1[1].death_no_ragdoll = 1;
    var_1[2].sittag = "tag_passenger";
    var_1[2].idle = %technical_passenger_idle;
    var_1[2].getout = %technical_exit_passenger;
    return var_1;
}
