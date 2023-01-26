// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level._effect["vlobby_dust"] = loadfx( "vfx/map/mp_vlobby_room/vlobby_dust" );
    level._effect["vlobby_steam"] = loadfx( "vfx/map/mp_vlobby_room/vlobby_steam" );
    level._effect["expround_asphalt_1"] = loadfx( "vfx/weaponimpact/expround_asphalt_1" );
    level._effect["recovery_scoring_add1"] = loadfx( "vfx/map/recovery/recovery_scoring_add1" );
    level._effect["recovery_scoring_add2"] = loadfx( "vfx/map/recovery/recovery_scoring_add2" );
    level._effect["recovery_scoring_add25"] = loadfx( "vfx/map/recovery/recovery_scoring_add25" );
    level._effect["recovery_scoring_add50"] = loadfx( "vfx/map/recovery/recovery_scoring_add50" );
    level._effect["recovery_scoring_add75"] = loadfx( "vfx/map/recovery/recovery_scoring_add75" );
    level._effect["recovery_scoring_add100"] = loadfx( "vfx/map/recovery/recovery_scoring_add100" );
    level._effect["recovery_scoring_minus1"] = loadfx( "vfx/map/recovery/recovery_scoring_minus1" );
    level._effect["recovery_scoring_minus2"] = loadfx( "vfx/map/recovery/recovery_scoring_minus2" );
    level._effect["recovery_scoring_minus25"] = loadfx( "vfx/map/recovery/recovery_scoring_minus25" );
    level._effect["recovery_scoring_minus50"] = loadfx( "vfx/map/recovery/recovery_scoring_minus50" );
    level._effect["recovery_scoring_minus75"] = loadfx( "vfx/map/recovery/recovery_scoring_minus75" );
    level._effect["recovery_scoring_minus100"] = loadfx( "vfx/map/recovery/recovery_scoring_minus100" );
    level._effect["recovery_scoring_target_shutter_enemy"] = loadfx( "vfx/map/recovery/recovery_scoring_target_shutter" );
    level._effect["recovery_scoring_target_shutter_friendly"] = loadfx( "vfx/map/recovery/recovery_scoring_hostage_shutter" );
    level._effect["mp_ref_elev_rain_inner"] = loadfx( "vfx/map/mp_refraction/mp_ref_elev_rain_inner" );
    level._effect["steam_cylinder_lrg"] = loadfx( "vfx/steam/steam_cylinder_lrg" );
    level._effect["electrical_sparks_runner"] = loadfx( "vfx/explosion/electrical_sparks_runner" );
    level._effect["emergency_lt_red_off"] = loadfx( "vfx/lights/emergency_lt_red_off" );
    level._effect["emergency_lt_red_on"] = loadfx( "vfx/lights/emergency_lt_red_on" );
    level._effect["sparks_burst_b"] = loadfx( "vfx/explosion/sparks_burst_b" );
    level._effect["emergency_lt_red_pulse_lp"] = loadfx( "vfx/lights/emergency_lt_red_pulse_lp" );
    level._effect["vlobby_spt_shadow"] = loadfx( "vfx/lights/mp_vlobby_refraction/vlobby_spt_shadow" );
    thread _id_3048();
    thread _id_3053();
    thread _id_5732();
    maps\mp\_utility::delaythread( 0.1, ::_id_A1A6 );
}

_id_302C()
{
    wait 1;
    level thread common_scripts\_exploder::_id_06F5( 213 );
}

_id_3048()
{
    wait 1;
    level._id_70F4 = common_scripts\utility::spawn_tag_origin();
    level._id_70F4 show();
    wait 1;
    level._id_70F4.origin = ( 24.0, 1144.0, 6459.0 );
    level._id_70F4.angles = ( 270.0, 0.0, 0.0 );
    playfxontag( common_scripts\utility::getfx( "mp_ref_elev_rain_inner" ), level._id_70F4, "tag_origin" );
}

_id_3047()
{
    wait 8;
    stopfxontag( common_scripts\utility::getfx( "mp_ref_elev_rain_inner" ), level._id_70F4, "tag_origin" );
    level._id_70F4 delete();
}

_id_3053()
{
    wait 1;
    level._id_8E17 = common_scripts\utility::spawn_tag_origin();
    level._id_8E17 show();
    wait 1;
    level._id_8E17.origin = ( -10.0, 1150.0, 1482.0 );
    level._id_8E17.angles = ( 270.0, 0.0, 0.0 );
    playfxontag( common_scripts\utility::getfx( "steam_cylinder_lrg" ), level._id_8E17, "tag_origin" );
}

_id_3052()
{
    wait 8;
    stopfxontag( common_scripts\utility::getfx( "steam_cylinder_lrg" ), level._id_8E17, "tag_origin" );
    level._id_8E17 delete();
}

_id_3037()
{
    wait 7;
    level thread common_scripts\_exploder::_id_06F5( 201 );
}

_id_302F()
{
    wait 2;
    level thread common_scripts\_exploder::_id_06F5( 202 );
}

_id_3034()
{
    wait 1;
    level thread common_scripts\_exploder::_id_06F5( 203 );
}

_id_3059()
{
    wait 13;
    level thread common_scripts\_exploder::_id_06F5( 204 );
}

_id_304D()
{
    wait 10;
    level thread common_scripts\_exploder::_id_06F5( 205 );
}

_id_302B()
{
    wait 10;
    level thread common_scripts\_exploder::_id_06F5( 206 );
}

_id_3044()
{
    wait 9;
    level thread common_scripts\_exploder::_id_06F5( 207 );
}

_id_304F()
{
    wait 7.5;
    level thread common_scripts\_exploder::_id_06F5( 211 );
}

_id_8E19()
{
    wait 12;
    level thread common_scripts\_exploder::_id_06F5( 214 );
}

_id_0DE3()
{
    wait 1;
    var_0 = getent( "elevator_lock_b", "targetname" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT1" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT2" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT3" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT4" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT5" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT6" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT7" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_off" ), var_0, "TAG_VFX_LIGHT8" );
}

_id_6698()
{
    wait 6;
    var_0 = getent( "elevator_lock_b", "targetname" );
    level thread common_scripts\_exploder::_id_06F5( 212 );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT7" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT6" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT2" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT3" );
    wait 0.55;
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT8" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT5" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT4" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT1" );
}

_id_6697()
{
    wait 1;
    var_0 = getent( "elevator_lock_b", "targetname" );
    wait 2;
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT1" );
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT2" );
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT3" );
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT4" );
    wait 0.55;
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT5" );
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT6" );
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT7" );
    stopfxontag( common_scripts\utility::getfx( "emergency_lt_red_pulse_lp" ), var_0, "TAG_VFX_LIGHT8" );
    wait 8;
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_on" ), var_0, "TAG_VFX_LIGHT1" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_on" ), var_0, "TAG_VFX_LIGHT8" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_on" ), var_0, "TAG_VFX_LIGHT2" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_on" ), var_0, "TAG_VFX_LIGHT7" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "sparks_burst_b" ), var_0, "TAG_VFX_LIGHT3" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_on" ), var_0, "TAG_VFX_LIGHT6" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_on" ), var_0, "TAG_VFX_LIGHT4" );
    playfxontag( common_scripts\utility::getfx( "emergency_lt_red_on" ), var_0, "TAG_VFX_LIGHT5" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "electrical_sparks_runner" ), var_0, "TAG_VFX_LIGHT3" );
}

_id_3040()
{
    wait 10.2;
    level thread common_scripts\_exploder::_id_06F5( 208 );
}

_id_A1A6()
{
    var_0 = getentarray( "warning_signs", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();
}

_id_A1A7()
{
    var_0 = getentarray( "warning_signs", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 show();

    level thread common_scripts\_exploder::_id_06F5( 210 );
}

_id_5732()
{
    for (;;)
    {
        wait(randomfloatrange( 2, 6 ));
        var_0 = 220 + randomint( 8 );
        _func_222( var_0 );
    }
}
