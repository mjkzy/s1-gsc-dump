// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "gaz_tigr_turret", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_unload_groups( ::unload_groups );
    maps\_vehicle::build_drive( %humvee_50cal_driving_idle_forward, %humvee_50cal_driving_idle_backward, 10 );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "axis" );

    if ( issubstr( var_2, "turret" ) )
    {
        maps\_vehicle::build_aianims( ::setanims_turret, ::set_vehicle_anims );
        maps\_vehicle::build_turret( "dshk_gaz", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14 );
    }
    else
        maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );

    build_gaz_death( var_2 );
    maps\_vehicle::build_light( var_2, "headlight_L", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_R", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_L", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_R", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_L", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_R", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_L", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_R", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz", "headlights", 0.0 );
}

init_local()
{
    thread handle_audio();
}

handle_audio()
{
    self endon( "death" );
    var_0 = 0;
    var_1 = 6000;
    var_2 = 1.0;
    vehicle_scripts\_gaz_dshk_aud::snd_init_gaz();
    thread monitor_death_stop_sounds();
    self.snd_disable_vehicle_system = self.script_disablevehicleaudio;

    for (;;)
    {
        if ( !isdefined( self.script_disablevehicleaudio ) || !self.script_disablevehicleaudio )
        {
            var_3 = distance( self.origin, level.player.origin );

            if ( var_0 && var_3 > var_1 )
            {
                vehicle_scripts\_gaz_dshk_aud::snd_stop_gaz( var_2 );
                var_0 = 0;
                wait 0.1;
            }
            else if ( !var_0 && var_3 < var_1 )
            {
                vehicle_scripts\_gaz_dshk_aud::snd_start_gaz();
                var_0 = 1;
            }
        }
        else if ( var_0 )
        {
            vehicle_scripts\_gaz_dshk_aud::snd_stop_gaz( 1.0 );
            var_0 = 0;
        }

        wait 0.1;
    }
}

monitor_death_stop_sounds()
{
    self waittill( "death" );
    var_0 = 1;
    vehicle_scripts\_gaz_dshk_aud::snd_stop_gaz( var_0 );
}

unload_groups()
{
    var_0 = [];
    var_1 = "passengers";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_1 = "all_but_gunner";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_1 = "rear_driver_side";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 2;
    var_1 = "gunner";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 3;
    var_1 = "all";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0["default"] = var_0["all"];
    return var_0;
}

build_gaz_death( var_0 )
{
    level._effect["gazfire"] = loadfx( "vfx/fire/fire_lp_s_no_light" );
    level._effect["gazexplode"] = loadfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner" );
    level._effect["gazsmfire"] = loadfx( "vfx/fire/fire_lp_xs_no_light" );
    maps\_vehicle::build_deathmodel( "vehicle_gaz_tigr_base", "vehicle_gaz_tigr_harbor_destroyed" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner", "tag_deathfx", "veh_gaz_expl_3d", undefined, undefined, undefined, undefined, undefined, undefined );
    maps\_vehicle::build_deathfx( "vfx/fire/fire_lp_s_no_light", "tag_cab_fx", "veh_gaz_fire_lp", undefined, undefined, 1, 0 );
    maps\_vehicle::build_deathfx( "vfx/fire/firelp_small", "tag_trunk_fx", undefined, undefined, undefined, 1, 3 );
    maps\_vehicle::build_deathquake( 1, 1.6, 500 );
    maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 0, 0 );
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %gaz_dismount_frontl_door;
    var_0[1].vehicle_getoutanim = %gaz_dismount_frontr_door;
    var_0[2].vehicle_getoutanim = %gaz_dismount_backl_door;
    var_0[3].vehicle_getoutanim = %gaz_dismount_backr_door;
    var_0[0].vehicle_getinanim = %gaz_mount_frontl_door;
    var_0[1].vehicle_getinanim = %gaz_mount_frontr_door;
    var_0[2].vehicle_getinanim = %gaz_enter_back_door;
    var_0[3].vehicle_getinanim = %gaz_enter_back_door;
    var_0[0].vehicle_getoutsound = "gaz_door_open";
    var_0[1].vehicle_getoutsound = "gaz_door_open";
    var_0[2].vehicle_getoutsound = "gaz_door_open";
    var_0[3].vehicle_getoutsound = "gaz_door_open";
    var_0[0].vehicle_getinsound = "gaz_door_close";
    var_0[1].vehicle_getinsound = "gaz_door_close";
    var_0[2].vehicle_getinsound = "gaz_door_close";
    var_0[3].vehicle_getinsound = "gaz_door_close";
    return var_0;
}

set_vehicle_anims_turret( var_0 )
{
    var_0[3].vehicle_getoutanim = %gaz_turret_getout_gaz;
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
    var_0[0].death = %gaz_dismount_frontl;
    var_0[0].death_no_ragdoll = 1;
    var_0[0].idle = %gaz_idle_frontl;
    var_0[1].idle = %gaz_idle_frontr;
    var_0[2].idle = %gaz_idle_backl;
    var_0[3].idle = %gaz_idle_backr;
    var_0[0].getout = %gaz_dismount_frontl;
    var_0[1].getout = %gaz_dismount_frontr;
    var_0[2].getout = %gaz_dismount_backl;
    var_0[3].getout = %gaz_dismount_backr;
    var_0[0].getin = %gaz_mount_frontl;
    var_0[1].getin = %gaz_mount_frontr;
    var_0[2].getin = %gaz_enter_backr;
    var_0[3].getin = %gaz_enter_backl;
    return var_0;
}

setanims_turret()
{
    var_0 = setanims();
    var_0[3].mgturret = 0;
    var_0[3].passenger_2_turret_func = ::gaz_turret_guy_gettin_func;
    var_0[3].sittag = "tag_guy_turret";
    var_0[3].getout = %gaz_turret_getout_guy1;
    var_0 = set_vehicle_anims_turret( var_0 );
    return var_0;
}

gaz_turret_guy_gettin_func( var_0, var_1, var_2, var_3 )
{

}
