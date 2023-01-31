// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "pitbull", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );

    if ( var_0 == "vehicle_pitbull" )
    {
        maps\_vehicle::build_deathmodel( "vehicle_pitbull", "vehicle_pitbull_dstrypv" );
        var_3 = [];
        var_3["vehicle_pitbull"] = "vfx/explosion/vehicle_civ_ai_explo_med_runner";
        maps\_vehicle::build_deathfx( var_3[var_0], "tag_death_fx", "car_explode" );
        maps\_vehicle::build_drive( %humvee_50cal_driving_idle_forward, %humvee_50cal_driving_idle_backward, 50 );
        maps\_vehicle::build_light( var_2, "brakelight_set", "tag_origin", "vfx/lights/veh_pitbull_stop_light", "brakelights" );
    }

    if ( var_2 == "script_vehicle_mil_avt_ai" )
        maps\_vehicle::build_drive( %humvee_50cal_driving_idle_forward, %humvee_50cal_driving_idle_backward, 50 );
    else if ( var_2 == "script_vehicle_pitbull_physics_alt" )
        maps\_vehicle::build_turret( "pitbull_turret_bullet", "tag_turret", "weapon_pitbull_turret", undefined, "manual", 0.2, 10, -14 );
    else
        maps\_vehicle::build_turret( "pitbull_turret", "tag_turret", "weapon_pitbull_turret", undefined, "manual", 0.2, 10, -14 );

    maps\_vehicle::build_unload_groups( ::unload_groups );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/tread_dust_default" );
    maps\_vehicle::build_life( 999, 500, 1500 );
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

    if ( self.model == "vehicle_vm_pitbull" )
    {
        self _meth_8048( "TAG_WINDSHIELD1" );
        self _meth_8048( "TAG_WINDSHIELD2" );
        self _meth_8048( "TAG_WINDSHIELD3" );
    }
}

handle_pitbull_audio()
{
    soundscripts\_snd::snd_message( "snd_register_vehicle", "pitbull", vehicle_scripts\_pitbull_aud::snd_pitbull_constructor );
    soundscripts\_snd::snd_message( "snd_start_vehicle", "pitbull" );
}

unload_groups()
{
    var_0 = [];
    return var_0;
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %uaz_driver_exit_into_run_door;
    var_0[1].vehicle_getoutanim = %uaz_rear_driver_exit_into_run_door;
    var_0[2].vehicle_getoutanim = %uaz_passenger_exit_into_run_door;
    var_0[3].vehicle_getoutanim = %uaz_passenger2_exit_into_run_door;
    var_0[0].vehicle_getinanim = %humvee_mount_frontl_door;
    var_0[1].vehicle_getinanim = %humvee_mount_frontr_door;
    var_0[2].vehicle_getinanim = %humvee_mount_backl_door;
    var_0[3].vehicle_getinanim = %humvee_mount_backr_door;
    var_0[0].vehicle_getoutsound = "hummer_door_open";
    var_0[1].vehicle_getoutsound = "hummer_door_open";
    var_0[2].vehicle_getoutsound = "hummer_door_open";
    var_0[3].vehicle_getoutsound = "hummer_door_open";
    var_0[0].vehicle_getinsound = "hummer_door_close";
    var_0[1].vehicle_getinsound = "hummer_door_close";
    var_0[2].vehicle_getinsound = "hummer_door_close";
    var_0[3].vehicle_getinsound = "hummer_door_close";
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 4; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_driver";
    var_0[1].sittag = "tag_passenger";
    var_0[2].sittag = "tag_guy0";
    var_0[3].sittag = "tag_guy1";
    var_0[0].bhasgunwhileriding = 0;
    var_0[0].idle = %humvee_idle_frontl;
    var_0[1].idle = %humvee_idle_frontr;
    var_0[2].idle = %humvee_idle_backl;
    var_0[3].idle = %humvee_idle_backr;
    var_0[0].getout = %humvee_driver_climb_out;
    var_0[1].getout = %humvee_passenger_out_r;
    var_0[2].getout = %humvee_passenger_out_l;
    var_0[3].getout = %humvee_passenger_out_r;
    var_0[0].getin = %humvee_mount_frontl;
    var_0[1].getin = %humvee_mount_frontr;
    var_0[2].getin = %humvee_mount_backl;
    var_0[3].getin = %humvee_mount_backr;
    return var_0;
}
