// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("destructibles");

main()
{
    common_scripts\_destructible::destructible_create( "vehicle_suv_atlas_destpv", "tag_origin", 600 );
    common_scripts\_destructible::destructible_loopfx( "tag_death_fx", "vfx/destructible/veh_suv_dmg_stage_1", 0.25 );
    common_scripts\_destructible::destructible_state( undefined, undefined, 200 );
    common_scripts\_destructible::destructible_loopfx( "tag_death_fx", "vfx/destructible/veh_suv_dmg_stage_2", 1 );
    common_scripts\_destructible::destructible_state( undefined, undefined, 200 );
    common_scripts\_destructible::destructible_healthdrain( 10, 1, 200 );
    common_scripts\_destructible::destructible_loopfx( "tag_death_fx", "vfx/destructible/veh_suv_dmg_stage_3", 0.3 );
    common_scripts\_destructible::destructible_state( undefined, undefined, 600 );
    common_scripts\_destructible::destructible_explode( 14000, 16000, 200, 250, 50, 300, undefined, undefined, 0.3, 1000, undefined, undefined, 2500, 3000 );
    common_scripts\_destructible::destructible_fx( "tag_death_fx", "vfx/destructible/veh_atlas_suv_explo_1", 1 );
    common_scripts\_destructible::destructible_anim( %civ_domestic_sedan_police_destroy, #animtree, "setanimknob" );
    common_scripts\_destructible::destructible_fx( "tag_death_fx", "vfx/destructible/veh_suv_fire_1", 1 );
    common_scripts\_destructible::destructible_state( undefined, "vehicle_atlas_suv_dstrypv" );
    common_scripts\_destructible::destructible_part( "tag_glass_front", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_front_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_front_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_glass_back", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_back_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_back_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_glass_left_front", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_left_front_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_left_front_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_glass_right_front", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_right_front_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_right_front_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_glass_left_back", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_left_back_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_left_back_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_glass_right_back", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_right_back_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_right_back_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_door_left_front", undefined, 1600, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_part( "tag_door_right_front", undefined, 1600, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_part( "tag_door_left_rear", undefined, 1600, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_part( "tag_door_right_rear", undefined, 1600, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_part( "tag_door_glass_left_back", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_door_glass_left_back_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_door_glass_left_back_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_door_glass_right_back", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_door_glass_right_back_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_door_glass_right_back_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_glass_up_back", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_up_back_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_up_back_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "tag_glass_up_front", undefined, 50, undefined, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_state( "tag_glass_up_front_d", undefined, 50, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_glass_up_front_fx", "vfx/glass/car_window_shatter_01", 1 );
    common_scripts\_destructible::destructible_state();
    common_scripts\_destructible::destructible_part( "right_wheel_02_jnt", "vehicle_atlas_suv_wheel_part_dstrypv", 1600, undefined, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_physics();
}
