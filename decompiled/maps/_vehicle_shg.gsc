// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

set_player_rig_spawn_function( var_0 )
{
    level.player_rig_spawn_function = var_0;
}

#using_animtree("player");

spawn_player_rig()
{
    var_0 = undefined;

    if ( isdefined( level.player_rig_spawn_function ) )
    {
        var_0 = [[ level.player_rig_spawn_function ]]();
        var_0.animname = "_vehicle_player_rig";
    }
    else
    {
        var_0 = spawn( "script_model", ( 0, 0, 0 ) );
        var_0.animname = "_vehicle_player_rig";
        var_0 useanimtree( #animtree );
        var_0 setmodel( "viewbody_generic_s1" );
    }

    return var_0;
}

add_vehicle_anim( var_0, var_1, var_2 )
{
    if ( !isdefined( level.vehicle_anims ) )
        level.vehicle_anims = [];

    if ( !isdefined( level.vehicle_anims[var_0] ) )
        level.vehicle_anims[var_0] = [];

    level.vehicle_anims[var_0][var_1] = var_2;
}

add_vehicle_player_anim( var_0, var_1, var_2 )
{
    level.scr_anim["_vehicle_player_rig"][var_1] = var_2;
}

get_vehicle_anim( var_0 )
{
    return level.vehicle_anims[self.classname][var_0];
}

get_vehicle_player_anim( var_0 )
{
    return level.scr_anim["_vehicle_player_rig"][var_0];
}

wait_for_vehicle_mount()
{
    self endon( "guy_entered" );
    self waittill( "vehicle_mount", var_0 );
    self.player_driver = var_0;
}

wait_for_vehicle_dismount()
{
    self waittill( "vehicle_dismount", var_0 );

    if ( isdefined( var_0 ) )
        var_0.drivingvehicle = undefined;

    self.player_driver = undefined;
}
