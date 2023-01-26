// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

#using_animtree("destructibles");

main()
{
    common_scripts\_destructible::_id_2905( "toy_locker_double", "tag_origin", 150, undefined, 32, "no_melee" );
    common_scripts\_destructible::_id_28F9( %locker_broken_both_doors_1, #animtree, "setanimknob", undefined, 0, "locker_broken_both_doors_1" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/props/locker_double_des_02_right", undefined, undefined, 0 );
    common_scripts\_destructible::_id_2929( "lockers_fast", undefined, 0 );
    common_scripts\_destructible::_id_28F9( %locker_broken_both_doors_2, #animtree, "setanimknob", undefined, 1, "locker_broken_both_doors_2" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/props/locker_double_des_01_left", undefined, undefined, 1 );
    common_scripts\_destructible::_id_2929( "lockers_fast", undefined, 1 );
    common_scripts\_destructible::_id_28F9( %locker_broken_both_doors_4, #animtree, "setanimknob", undefined, 2, "locker_broken_both_doors_4" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/props/locker_double_des_03_both", undefined, undefined, 2 );
    common_scripts\_destructible::_id_2929( "lockers_double", undefined, 2 );
    common_scripts\_destructible::_id_28F9( %locker_broken_door1_fast, #animtree, "setanimknob", undefined, 3, "locker_broken_door1_fast" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/props/locker_double_des_01_left", undefined, undefined, 3 );
    common_scripts\_destructible::_id_2929( "lockers_fast", undefined, 3 );
    common_scripts\_destructible::_id_28F9( %locker_broken_door2_fast, #animtree, "setanimknob", undefined, 4, "locker_broken_door2_fast" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/props/locker_double_des_02_right", undefined, undefined, 4 );
    common_scripts\_destructible::_id_2929( "lockers_fast", undefined, 4 );
    common_scripts\_destructible::_id_28F9( %locker_broken_both_doors_3, #animtree, "setanimknob", undefined, 5, "locker_broken_both_doors_3" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/misc/no_effect", undefined, undefined, 5 );
    common_scripts\_destructible::_id_2929( "lockers_minor", undefined, 5 );
    common_scripts\_destructible::_id_28F9( %locker_broken_door1_slow, #animtree, "setanimknob", undefined, 6, "locker_broken_door1_slow" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/misc/no_effect", undefined, undefined, 6 );
    common_scripts\_destructible::_id_2929( "lockers_minor", undefined, 6 );
    common_scripts\_destructible::_id_28F9( %locker_broken_door2_slow, #animtree, "setanimknob", undefined, 7, "locker_broken_door2_slow" );
    common_scripts\_destructible::_id_2911( "tag_fx", "fx/misc/no_effect", undefined, undefined, 7 );
    common_scripts\_destructible::_id_2929( "lockers_minor", undefined, 7 );
    common_scripts\_destructible::_id_2930( undefined, "com_locker_double_destroyed", undefined, undefined, "no_melee" );
}
