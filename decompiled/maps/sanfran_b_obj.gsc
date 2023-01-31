// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

obj_secure_deck()
{
    level waittill( "player_control_enabled" );
    objective_add( maps\_utility::obj( "obj_plant_jammers" ), "current", &"SANFRAN_B_OBJ_PLANT_JAMMERS" );
    objective_onentity( maps\_utility::obj( "obj_plant_jammers" ), level.cormack );
    common_scripts\utility::flag_wait( "obj_track_jammers" );
    var_0 = getent( "jammer_1", "targetname" );
    var_1 = getent( "jammer_2", "targetname" );
    var_2 = ( 0, 0, 16 );
    objective_position( maps\_utility::obj( "obj_plant_jammers" ), var_0.origin + var_2 );
    objective_setpointertextoverride( maps\_utility::obj( "obj_plant_jammers" ), &"SANFRAN_B_OBJ_JAMMER" );
    common_scripts\utility::flag_wait( "planting_jammer_1" );
    objective_position( maps\_utility::obj( "obj_plant_jammers" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "jammer_1_deactivated" );
    objective_position( maps\_utility::obj( "obj_plant_jammers" ), var_1.origin + var_2 );
    objective_setpointertextoverride( maps\_utility::obj( "obj_plant_jammers" ), &"SANFRAN_B_OBJ_JAMMER" );
    common_scripts\utility::flag_wait( "planting_jammer_2" );
    objective_position( maps\_utility::obj( "obj_plant_jammers" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "jammer_2_deactivated" );
    maps\_utility::objective_complete( maps\_utility::obj( "obj_plant_jammers" ) );
    common_scripts\utility::flag_set( "obj_bridge_start" );
}

track_reinforcement_location( var_0, var_1, var_2 )
{
    level endon( var_1 );
    common_scripts\utility::flag_clear( "obj_track_enemies" );
    var_3 = 0;
    var_4 = spawn( "script_model", ( 0, 0, 0 ) );
    var_4 thread clean_up_target_pos_ent( var_0, var_1 );
    objective_onentity( var_0, var_4 );

    for (;;)
    {
        if ( isdefined( var_2 ) && var_2.size > 0 )
        {
            var_5 = ( 0, 0, 0 );
            var_6 = 0;

            foreach ( var_8 in var_2 )
            {
                if ( isdefined( var_8 ) && isalive( var_8 ) )
                {
                    var_5 += var_8.origin;
                    var_6++;
                }
            }

            if ( var_6 > 0 )
            {
                var_5 /= var_6;

                if ( var_3 )
                    var_4 _meth_82AE( var_5, 0.2 );
                else
                {
                    var_3 = 1;
                    var_4.origin = var_5;
                }
            }
        }

        wait 0.2;
    }
}

clean_up_target_pos_ent( var_0, var_1 )
{
    level waittill( var_1 );
    objective_position( var_0, ( 0, 0, 0 ) );
    self delete();
}

obj_bridge_start()
{
    common_scripts\utility::flag_wait( "obj_bridge_start" );
    objective_add( maps\_utility::obj( "obj_bridge" ), "current", &"SANFRAN_B_OBJ_BRIDGE" );
    objective_onentity( maps\_utility::obj( "obj_bridge" ), level.cormack );
    objective_setpointertextoverride( maps\_utility::obj( "obj_bridge" ), "" );
    common_scripts\utility::flag_set( "all_jammers_deactivated" );
    common_scripts\utility::flag_wait( "show_enter_ship_obj_marker" );
    var_0 = getent( "org_enter_ship", "targetname" );
    wait 0.5;
    objective_position( maps\_utility::obj( "obj_bridge" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "obj_bridge" ), "" );
    common_scripts\utility::flag_wait( "flag_player_entered_interior" );
    common_scripts\utility::flag_set( "obj_secure_deck_complete" );
    common_scripts\utility::flag_set( "obj_bridge" );
}

obj_bridge()
{
    common_scripts\utility::flag_wait( "obj_bridge" );
    objective_onentity( maps\_utility::obj( "obj_bridge" ), level.cormack );
    common_scripts\utility::flag_wait( "flag_obj_leave_cafeteria" );
    var_0 = common_scripts\utility::getstruct( "obj_marker_exit_cafeteria", "targetname" );
    objective_position( maps\_utility::obj( "obj_bridge" ), var_0.origin );
    common_scripts\utility::flag_wait( "obj_marker_follow_cormack_to_hanger" );
    objective_onentity( maps\_utility::obj( "obj_bridge" ), level.cormack );
    common_scripts\utility::flag_wait( "flag_obj_enter_hanger" );
    objective_position( maps\_utility::obj( "obj_bridge" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_leave_hanger" );
    objective_onentity( maps\_utility::obj( "obj_bridge" ), level.cormack );
    common_scripts\utility::flag_wait( "cormack_on_console" );
    maps\_utility::objective_complete( maps\_utility::obj( "obj_bridge" ) );
    wait 0.5;
    common_scripts\utility::flag_set( "obj_console" );
}

obj_console()
{
    common_scripts\utility::flag_wait( "obj_console" );
    var_0 = common_scripts\utility::getstruct( "org_obj_console", "targetname" );
    objective_add( maps\_utility::obj( "obj_laser" ), "current", &"SANFRAN_B_OBJ_CONSOLE" );
    objective_position( maps\_utility::obj( "obj_laser" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "obj_laser" ), &"SANFRAN_B_OBJ_USE" );
    var_1 = getent( "trig_use_console", "targetname" );
    var_1 common_scripts\utility::trigger_on();
    var_1 _meth_80DB( &"SANFRAN_B_CONSOLE_HINT" );
    var_1 waittill( "trigger" );
    common_scripts\utility::flag_set( "obj_laser" );
}

obj_laser()
{
    common_scripts\utility::flag_wait( "obj_laser" );
    var_0 = getent( "cargo_ship", "targetname" );
    var_1 = getent( "cargo_ship_2", "targetname" );
    objective_string_nomessage( maps\_utility::obj( "obj_laser" ), &"SANFRAN_B_OBJ_LASER" );
    objective_position( maps\_utility::obj( "obj_laser" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "second_cargo_ship_destroyed" );
    maps\_utility::objective_complete( maps\_utility::obj( "obj_laser" ) );
}

enable_cormack_follow()
{
    common_scripts\utility::flag_wait( "CormackSafe" );
    objective_position( maps\_utility::obj( "obj_bridge" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait_either( "information_center_cleared", "information_center_enemies_killed" );
    objective_onentity( maps\_utility::obj( "obj_bridge" ), level.cormack );
}
