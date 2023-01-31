// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "warrior_atlas", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_drive( %humvee_50cal_driving_idle_forward, %humvee_50cal_driving_idle_backward, 10 );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
}

init_local()
{
    if ( issubstr( self.vehicletype, "physics" ) )
    {
        var_0 = [];
        var_0["idle"] = %humvee_antennas_idle_movement;
        var_0["rot_l"] = %humvee_antenna_l_rotate_360;
        var_0["rot_r"] = %humvee_antenna_r_rotate_360;
        thread maps\_vehicle_code::humvee_antenna_animates( var_0 );
    }
}

build_humvee_anims()
{
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
}

set_vehicle_anims( var_0 )
{
    return var_0;
}

setanims()
{

}

unload_groups()
{

}
