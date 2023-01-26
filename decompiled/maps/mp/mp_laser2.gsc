// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A76C::main();
    _id_A6D4::main();
    _id_A76B::main();
    thread _id_0F91();
    maps\mp\_load::main();
    maps\mp\mp_laser2_lighting::main();
    maps\mp\mp_laser2_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_laser2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_088B = 450;
    thread _id_7E66();
    thread _id_7EE0();
    level._id_65AB = "mp_laser2_osp";

    if ( level.nextgen == 1 )
        level thread _id_7601();

    level._id_65AB = "mp_laser2_osp";
    level._id_65A9 = "mp_laser2_streak";
    level._id_5985 = ::_id_54E8;
    level._id_6573 = ::_id_54EA;
    level._id_655B = ::_id_54E9;
    thread _id_54E7();
    level._id_0BDA = "laser_buoy_loop";
    level._id_A292 = 2;
    _id_A75F::_id_8000( "iw5_underwater_mp" );
    level thread _id_A75F::init();
    precacherumble( "damage_light" );
    level _id_2FE8();
    level _id_2FE7();
    level thread maps\mp\_dynamic_events::_id_2FE6( ::_id_4667, undefined, ::_id_465B );
    level._id_09C1 = spawnstruct();
    level._id_09C1._id_8A5A = getentarray( "horizonal_spinner", "targetname" );

    foreach ( var_1 in level._id_09C1._id_8A5A )
        var_1 hide();

    level thread _id_464C();
    thread _id_8A06();
}

_id_2FE8()
{
    level._id_98CF = "mp_laser2_typhoon_alarm";
    level._id_98D1 = "mp_laser2_vo_tsunami_warning_int";
    level._id_98D0 = "mp_laser2_vo_tsunami_warning_ext";
}

_id_54E8()
{
    level._id_53AB["mp_laser2_core"] = 1;
    level thread _id_A7D5::init();
}

_id_54EA()
{
    level._id_6574._id_898B = 30;
    level._id_6574._id_898A = 90;
    level._id_6574._id_89DC = 9541;

    if ( level.currentgen )
    {
        level._id_6574._id_0252 = 20;
        level._id_6574._id_0380 = 20;
        level._id_6574._id_04BD = -30;
        level._id_6574._id_0089 = 60;
    }
}

_id_54E9()
{
    level._id_655C._id_89DC = 3300;
}

_id_54E7()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 1750;
}

_id_7E66()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "2" );
        }
    }
}

_id_7EE0()
{
    setdvar( "r_umbraAccurateOcclusionThreshold", 256 );
}

_id_464C()
{
    var_0 = 122;
    _func_29C( var_0 );
    level thread _id_464D();
    level thread _id_464E();
}

_id_310A( var_0 )
{
    var_1 = 122;
    var_2 = 0;
    var_3 = [];

    if ( isdefined( var_0 ) )
    {
        var_2 = 1;
        var_3[var_3.size] = var_0;

        if ( isdefined( var_0._id_2AF8 ) )
        {
            var_0._id_2AF8--;

            if ( var_0._id_2AF8 <= 0 )
                var_0._id_2AF8 = 0;
        }
    }
    else
    {
        foreach ( var_5 in level.players )
        {
            if ( isdefined( var_5._id_2AF8 ) )
            {
                var_5._id_2AF8--;

                if ( var_5._id_2AF8 > 0 )
                    var_2 = 1;
                else
                    var_5._id_2AF8 = 0;

                var_3[var_3.size] = var_5;
            }
        }
    }

    if ( var_2 )
        _func_29C( var_1, var_3 );
    else
        _func_29C( var_1 );
}

_id_2AF9( var_0, var_1 )
{
    var_2 = 122;
    var_3 = [];
    level thread common_scripts\_exploder::_id_262A( var_2, var_0, var_1 );

    if ( isdefined( var_0 ) )
        var_3[var_3.size] = var_0;
    else
        var_3 = level.players;

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5._id_2AF8 ) )
        {
            var_5._id_2AF8++;
            continue;
        }

        var_5._id_2AF8 = 1;
    }
}

_id_464D()
{
    for (;;)
    {
        level waittill( "player_start_aerial_view", var_0 );
        level _id_2AF9( var_0, 1 );
    }
}

_id_464E()
{
    for (;;)
    {
        level waittill( "player_stop_aerial_view", var_0 );
        level _id_310A( var_0 );
    }
}

_id_7601()
{
    wait 0.05;
    var_0 = getent( "radar_dish01_rotate", "targetname" );
    maps\mp\_audio::_id_7B3D( var_0, "lsr_radar_dish_loop", "ps_emt_satellite_dish_rotate", "emt_satellite_dish_rotate", "laser2_custom_end_notify", "laser2_custom_ent_end_notify", "laser2_custom_ent2_end_notify" );
}

_id_466E( var_0 )
{
    if ( isdefined( self.target ) )
    {
        var_1 = getentarray( self.target, "targetname" );

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_0 ) )
            {
                var_3 linktosynchronizedparent( var_0 );
                continue;
            }

            var_3 linktosynchronizedparent( self );
        }
    }
}

_id_2FE7()
{
    level endon( "game_ended" );
    level._id_A28C = undefined;
    level._id_6336 = undefined;
    var_0 = getentarray( "ocean_water", "targetname" );

    if ( isdefined( var_0 ) )
    {
        level._id_6336 = var_0[0];

        if ( var_0.size > 0 )
        {
            level._id_6337 = common_scripts\utility::array_remove( var_0, level._id_6336 );
            common_scripts\utility::array_thread( level._id_6337, ::_id_579B, level._id_6336 );
        }
    }

    level._id_6336._id_A1A8 = 30;
    level._id_6336.origin -= ( 0.0, 0.0, 132.0 );
    var_1 = getent( "ocean_water_underside", "targetname" );
    var_2 = getentarray( "trigger_underwater", "targetname" );
    var_3 = getentarray( "ocean_moving_prop", "targetname" );
    var_4 = getentarray( "buoy", "targetname" );
    var_5 = [];
    level._id_5F9C = [];
    var_6 = getentarray( "water_clip", "targetname" );
    level._id_6E6B = getentarray( "post_event_geo", "targetname" );
    level._id_3149 = getentarray( "end_state_geo", "targetname" );
    level._id_6E6D = getnodearray( "post_event_node", "targetname" );
    level._id_6E9E = getnodearray( "pre_event_node", "targetname" );
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    level._id_2F48 = getentarray( "drop_pod_bad_place", "targetname" );
    level._id_6E6E = getentarray( "post_event_pathing_blocker", "targetname" );
    level._id_6E9F = getentarray( "pre_event_pathing_blocker", "targetname" );
    level _id_4573();
    level thread _id_45D6();

    foreach ( var_8 in var_3 )
    {
        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "has_collision" )
            var_5[var_5.size] = var_8;
    }

    foreach ( var_11 in var_4 )
    {
        if ( isdefined( var_11.script_noteworthy ) && var_11.script_noteworthy == "moving" )
            level._id_5F9C[level._id_5F9C.size] = var_11;
    }

    var_13 = common_scripts\utility::array_combine( var_3, level._id_5F9C );
    thread _id_A76B::_id_8341( level._id_6336 );
    thread _id_A76B::_id_8321( level._id_6336 );

    if ( isdefined( level._id_A291 ) )
        common_scripts\utility::array_thread( level._id_A291, ::_id_579B, level._id_6336 );

    if ( level.nextgen )
        var_1 _id_579B( level._id_6336 );

    if ( isdefined( var_6 ) && var_6.size > 0 )
        common_scripts\utility::array_thread( var_6, ::_id_579B, level._id_6336 );

    if ( isdefined( var_13 ) && var_13.size > 0 )
        common_scripts\utility::array_thread( var_13, ::_id_579B, level._id_6336 );

    if ( isdefined( var_2 ) && var_2.size > 0 && isdefined( level._id_6336 ) )
    {
        foreach ( var_15 in var_2 )
            var_15 thread _id_468C( level._id_6336 );
    }

    if ( isdefined( level.goliath_bad_landing_volumes ) && level.goliath_bad_landing_volumes.size > 0 && isdefined( level._id_6336 ) )
    {
        foreach ( var_15 in level.goliath_bad_landing_volumes )
        {
            if ( isdefined( var_15.script_noteworthy ) && var_15.script_noteworthy == "dont_move_me" )
                continue;
            else
                var_15 thread _id_468C( level._id_6336 );
        }
    }

    if ( isdefined( var_5 ) && var_5.size > 0 )
        common_scripts\utility::array_thread( var_5, ::_id_466E, level._id_6336 );

    if ( isdefined( var_4 ) && var_4.size > 0 )
        common_scripts\utility::array_thread( var_4, ::_id_6A31 );

    if ( isdefined( level._id_5F9C ) && level._id_5F9C.size > 0 )
    {
        common_scripts\utility::array_thread( level._id_5F9C, ::_id_6DCE, level._id_0BDA );
        common_scripts\utility::array_thread( level._id_5F9C, ::_id_466E, level._id_6336 );
    }

    var_19 = getent( "tidal_wave", "targetname" );
    var_19 hide();
    common_scripts\utility::trigger_off( "trig_kill_00", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_01", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_02", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_03", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_04", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_drone_vista", "targetname" );
    maps\mp\killstreaks\_aerial_utility::_id_8157( "trig_kill_00", "targetname" );
    maps\mp\killstreaks\_aerial_utility::_id_8157( "trig_kill_01", "targetname" );
    maps\mp\killstreaks\_aerial_utility::_id_8157( "trig_kill_02", "targetname" );
    maps\mp\killstreaks\_aerial_utility::_id_8157( "trig_kill_03", "targetname" );
    maps\mp\killstreaks\_aerial_utility::_id_8157( "trig_kill_04", "targetname" );
    maps\mp\killstreaks\_aerial_utility::_id_8157( "trig_kill_drone_vista", "targetname" );
    thread _id_A76B::_id_6DEB( "end_initial_waves", 4, 6, "breaking_wave_01" );
    level _id_7FC7();
}

_id_2146()
{
    if ( isdefined( self ) )
        self connectpaths();
}

_id_2B33()
{
    if ( isdefined( self ) )
        self disconnectpaths();
}

_id_2145()
{
    if ( isdefined( self ) )
        self _meth_805A();
}

_id_2B32()
{
    if ( isdefined( self ) )
        self _meth_8059();
}

_id_4873()
{
    if ( isdefined( self ) && !isdefined( self._id_5116 ) )
    {
        self._id_5116 = 1;
        common_scripts\utility::trigger_off();
    }
}

_id_850B()
{
    if ( isdefined( self ) && isdefined( self._id_5116 ) )
    {
        self._id_5116 = undefined;
        common_scripts\utility::trigger_on();
    }
}

_id_633C( var_0 )
{
    level endon( "game_ended" );
    level endon( "end_initial_waves" );
    self notify( "ocean_sin_movement" );
    self endon( "ocean_sin_movement" );

    for (;;)
    {
        self moveto( ( 0, level._id_633B, level._id_633B ) + var_0, level._id_633D / 2, level._id_633D * 0.25, level._id_633D * 0.25 );
        wait(level._id_633D / 2);
        self moveto( -1 * ( 0, level._id_633B, level._id_633B ) + var_0, level._id_633D / 2, level._id_633D * 0.25, level._id_633D * 0.25 );
        wait(level._id_633D / 2);
    }
}

_id_7FC7()
{
    if ( level.nextgen )
    {
        level._id_633B = 12;
        level._id_633D = 10;
    }
    else
    {
        level._id_633B = 16;
        level._id_633D = 20;
    }
}

_id_7FC6()
{
    level._id_633B = 6;
    level._id_633D = 10;
}

_id_579B( var_0 )
{
    var_1 = self;
    var_1 linktosynchronizedparent( var_0 );
}

_id_464A( var_0, var_1 )
{
    level endon( "game_ended" );

    for (;;)
    {
        wait(randomfloatrange( 0.05, 0.5 ));

        while ( !isdefined( level._id_A28C ) || level._id_A28C != 1 )
        {
            maps\mp\_utility::play_sound_on_tag( var_1, "tag_origin" );
            wait(randomfloatrange( 3, 7 ));
        }

        while ( level._id_A28C == 1 )
        {
            maps\mp\_utility::play_sound_on_tag( var_0, "tag_origin" );
            wait(randomfloatrange( 1.5, 4.5 ));
        }
    }
}

_id_6A31()
{
    self notify( "stop_buoy_lights" );
    self endon( "stop_buoy_lights" );
    playfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
    wait(randomfloat( 4 ));
    stopfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
}

_id_6DCE( var_0 )
{
    wait(randomfloatrange( 0.1, 1 ));
    self scriptmodelplayanim( var_0 );
}

_id_6338( var_0 )
{
    level endon( "game_ended" );
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return undefined;

    var_1._id_A1A8 = 30;
    return var_1;
}

_id_6339( var_0 )
{
    var_1 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_1.targetname = "OceanObjectMover";
    var_1._id_2B6D = ( 0.0, 352.0, 0.0 );
    return var_1;
}

_id_5FA3()
{
    level endon( "game_ended" );
    thread _id_A76B::_id_6DEB( "end_initial_waves", 4, 6, "breaking_wave_01" );
}

_id_465B()
{
    level._id_6336.origin += ( 0.0, 0.0, 72.0 );
    level notify( "end_initial_waves" );
    thread _id_A76B::_id_6DEB( undefined, 6, 8, "breaking_wave_01" );
    level thread common_scripts\_exploder::_id_06F5( 201 );
    level thread common_scripts\_exploder::_id_06F5( 202 );
    level thread common_scripts\_exploder::_id_06F5( 203 );
    level thread common_scripts\_exploder::_id_06F5( 204 );
    level thread common_scripts\_exploder::_id_06F5( 205 );
    level thread common_scripts\_exploder::_id_06F5( 206 );
    level thread common_scripts\_exploder::_id_06F5( 207 );
    level thread common_scripts\_exploder::_id_06F5( 208 );
    level thread common_scripts\_exploder::_id_06F5( 209 );
    level thread common_scripts\_exploder::_id_06F5( 121 );

    if ( isdefined( level._id_3149 ) )
        common_scripts\utility::array_thread( level._id_3149, ::_id_850B );

    level _id_4574();
    level maps\mp\_utility::delaythread( 0.05, ::_id_45D5 );
}

_id_4667()
{
    level endon( "game_ended" );
    level _id_2AF9( undefined, 0 );
    level._id_85B8 = 1;
    var_0 = level._id_6336;
    var_1 = getent( "tidal_wave", "targetname" );
    var_1 show();
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.targetname = "ocean_tag_origin";
    var_2 show();
    var_3 = getent( "lsr_tidal_wave_car", "targetname" );
    var_4 = getent( "lsr_tidal_wave_shipping_container_closed", "targetname" );
    var_5 = getent( "lsr_tidal_wave_shipping_container_open", "targetname" );
    _id_23A0();

    foreach ( var_7 in level._id_A284 )
        var_7 thread _id_536D();

    level thread _id_0820();
    level thread _id_5373();
    wait 0.05;
    level._id_A28C = 1;
    level notify( "end_initial_waves" );
    thread maps\mp\mp_laser2_aud::_id_8C53();
    var_9 = 2;
    earthquake( 0.3, var_9, ( 0.0, 0.0, 0.0 ), 5000 );
    thread _id_0EEF( var_9 );
    thread _id_6926( 0.75 );
    level maps\mp\_utility::delaythread( 3, ::_id_4687 );
    var_10 = 26.667;
    var_11 = 36.7;
    var_12 = var_11;

    if ( var_10 > var_11 )
        var_12 = var_10;

    if ( var_0._id_A1A8 > var_12 )
        wait(var_0._id_A1A8 - var_12);
    else
        wait 2;

    var_1 thread _id_9340();
    var_1 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_mesh_anim", "tidal_wave_notetrack" );
    var_0 linkto( var_2 );
    var_2 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_ocean_anim" );

    if ( isdefined( var_3 ) )
        var_3 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_car" );

    var_4 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_shipping_container_closed" );
    var_5 scriptmodelplayanimdeltamotion( "lsr_tidal_wave_shipping_container_open" );

    foreach ( var_14 in level._id_5F9C )
    {
        if ( isdefined( var_14._id_0046 ) )
        {
            var_14 _meth_827A();
            var_14 unlink();
            var_14 scriptmodelplayanimdeltamotion( var_14._id_0046 );
            var_14 thread _id_6A31();
            var_14 maps\mp\_utility::delaythread( var_11, ::_id_18BF );
        }
    }

    level maps\mp\_utility::delaythread( var_10 - 3, ::_id_8ED3 );
    level maps\mp\_utility::delaythread( var_10 - 2.9, ::_id_6926, 0.75 );
    var_1 common_scripts\utility::delaycall( var_10, ::hide );
    var_2 common_scripts\utility::delaycall( var_11, ::hide );
    var_0 common_scripts\utility::delaycall( var_11, ::unlink );
    wait(var_12);
    var_16 = getnodearray( "water_nodes", "targetname" );

    foreach ( var_18 in var_16 )
        _func_2C0( var_18, 1 );

    _id_2801();
    level._id_85B8 = 0;
    wait 2;
    thread _id_A76B::_id_6DEB( undefined, 6, 8, "breaking_wave_01" );
    level notify( "dynamic_event_complete" );
}

_id_23A0()
{
    badplace_cylinder( "badplace_1", -1, ( -1096.0, -688.0, 229.5 ), 300, 200 );
    badplace_cylinder( "badplace_2", -1, ( -544.0, -1104.0, 158.0 ), 500, 200 );
    badplace_cylinder( "badplace_3", -1, ( 0.0, -1024.0, 154.286 ), 500, 200 );
    badplace_cylinder( "badplace_4", -1, ( 608.0, -1152.0, 153.195 ), 500, 200 );
    badplace_cylinder( "badplace_5", -1, ( 1360.0, -832.0, 203.4 ), 500, 200 );
    badplace_cylinder( "badplace_6", -1, ( 2128.0, -416.0, 159.325 ), 500, 200 );
    badplace_cylinder( "badplace_7", -1, ( 2464.0, 176.0, 128.0 ), 500, 200 );
}

_id_2801()
{
    badplace_delete( "badplace_1" );
    badplace_delete( "badplace_2" );
    badplace_delete( "badplace_3" );
    badplace_delete( "badplace_4" );
    badplace_delete( "badplace_5" );
    badplace_delete( "badplace_6" );
    badplace_delete( "badplace_7" );
}

_id_536D()
{
    level endon( "game_ended" );
    level endon( "dynamic_event_complete" );

    for (;;)
    {
        if ( isdefined( level.turrets ) )
        {
            foreach ( var_1 in level.turrets )
            {
                if ( var_1 istouching( self ) )
                    var_1 notify( "death" );
            }
        }

        if ( isdefined( level.carepackages ) )
        {
            foreach ( var_4 in level.carepackages )
            {
                if ( isdefined( var_4 ) && !_func_294( var_4 ) && var_4 _id_50D6() )
                {
                    if ( isdefined( var_4._id_2383 ) && var_4._id_2383 != "juggernaut" )
                    {
                        var_4 maps\mp\killstreaks\_airdrop::_id_2847( 1, 1 );
                        continue;
                    }

                    if ( isdefined( var_4._id_2383 ) && var_4._id_2383 == "juggernaut" )
                        var_4 maps\mp\killstreaks\_juggernaut::_id_2851( 1, 1 );
                }
            }
        }

        wait 0.05;
    }
}

_id_50D6()
{
    if ( isdefined( level._id_2F48 ) )
    {
        foreach ( var_1 in level._id_2F48 )
        {
            if ( _func_22A( self.origin, var_1 ) )
                return 1;
        }
    }

    return 0;
}

_id_0820()
{
    level waittill( "post_event_geo_on" );

    foreach ( var_1 in level._id_2F48 )
        level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_1;
}

_id_5373()
{
    level endon( "game_ended" );
    level endon( "dynamic_event_complete" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1 ) && isdefined( var_1._id_4FAA ) && var_1 maps\mp\_utility::isusingremote() )
                var_1 maps\mp\_utility::_suicide();
        }

        wait 0.05;
    }
}

_id_18BF()
{
    _id_579B( level._id_6336 );
    self _meth_827A();
    wait(randomfloatrange( 0.1, 1 ));
    self scriptmodelplayanim( level._id_0BDA );
    thread _id_6A31();
}

_id_6926( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 thread _id_6925( var_0 );
}

_id_6925( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for ( var_1 = var_0 * 20; var_1 >= 0; var_1 -= 2 )
    {
        self playrumbleonentity( "damage_light" );
        wait 0.1;
    }
}

_id_8ED3()
{
    level._id_A28C = 0;
    common_scripts\utility::array_thread( level._id_09C1._id_8A5A, ::_id_8A59 );
}

_id_9340()
{
    thread _id_33CA();
    thread _id_33CC();
    thread _id_33CB();
}

_id_33CA()
{
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_mist_start" );
    thread _id_A76B::_id_8CF2();
    self waittillmatch( "tidal_wave_notetrack", "vfx_receding_foam_start" );
    level thread common_scripts\_exploder::_id_06F5( 120 );
    level thread common_scripts\_exploder::_id_06F5( 100 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_rocks1_splash" );
    level thread common_scripts\_exploder::_id_06F5( 101 );
    level thread common_scripts\_exploder::_id_06F5( 201 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 0 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_tower_splash" );
    level thread common_scripts\_exploder::_id_06F5( 102 );
    level thread common_scripts\_exploder::_id_06F5( 202 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 1 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_concrete_chunk1_splash" );
    level thread common_scripts\_exploder::_id_06F5( 103 );
    level thread common_scripts\_exploder::_id_06F5( 203 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 2 );
    thread _id_A76B::_id_8ED4();
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse1_splash" );
    level thread common_scripts\_exploder::_id_06F5( 104 );
    level thread common_scripts\_exploder::_id_06F5( 204 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 3 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse2_splash" );
    level thread common_scripts\_exploder::_id_06F5( 105 );
    level thread common_scripts\_exploder::_id_06F5( 205 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 4 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse3_splash" );
    level thread common_scripts\_exploder::_id_06F5( 106 );
    level thread common_scripts\_exploder::_id_06F5( 206 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 5 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_midbeach_splash" );
    level thread common_scripts\_exploder::_id_06F5( 107 );
    level thread common_scripts\_exploder::_id_06F5( 207 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 6 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_helipad_splash" );
    level thread common_scripts\_exploder::_id_06F5( 108 );
    level thread common_scripts\_exploder::_id_06F5( 208 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 7 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_helipad_splash2" );
    level thread common_scripts\_exploder::_id_06F5( 109 );
    level thread common_scripts\_exploder::_id_06F5( 209 );
    thread _id_A76B::_id_6DC7( "tidal_wave_lingering_foam1", 8 );
    wait 1.0;
    level thread common_scripts\_exploder::_id_06F5( 121 );
    level _id_310A();
}

_id_33CC()
{
    common_scripts\utility::trigger_on( "trig_kill_drone_vista", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_00" );
    common_scripts\utility::trigger_off( "trig_kill_drone_vista", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_00", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_01" );
    common_scripts\utility::trigger_off( "trig_kill_00", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_01", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_02" );
    common_scripts\utility::trigger_off( "trig_kill_01", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_02", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_03" );
    common_scripts\utility::trigger_off( "trig_kill_02", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_03", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_04" );
    common_scripts\utility::trigger_off( "trig_kill_03", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_04", "targetname" );
    maps\mp\_utility::delaythread( 1, common_scripts\utility::trigger_off, "trig_kill_04", "targetname" );
}

_id_33CB()
{
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_04" );
    level _id_4574();
    level _id_45D5();
}

_id_4574()
{
    if ( isdefined( level._id_6E6B ) )
    {
        foreach ( var_1 in level._id_6E6B )
            var_1 _id_850B();

        level notify( "post_event_geo_on" );
    }

    if ( isdefined( level._id_2F48 ) )
    {
        foreach ( var_4 in level._id_2F48 )
            var_4 _id_850B();
    }
}

_id_4573()
{
    if ( isdefined( level._id_6E6B ) )
    {
        foreach ( var_1 in level._id_6E6B )
            var_1 _id_4873();

        level notify( "post_event_geo_off" );
    }

    if ( isdefined( level._id_2F48 ) )
    {
        foreach ( var_4 in level._id_2F48 )
            var_4 _id_4873();
    }

    if ( isdefined( level._id_3149 ) )
        common_scripts\utility::array_thread( level._id_3149, ::_id_4873 );
}

_id_45D6()
{
    if ( getdvar( "scr_dynamic_event_state", "on" ) != "endstate" && ( !isdefined( level.dynamiceventstype ) || level.dynamiceventstype != 2 ) )
        wait 0.05;

    foreach ( var_1 in level._id_6E9F )
    {
        var_1 _id_2B33();
        var_1 _id_4873();
    }

    foreach ( var_1 in level._id_6E6E )
    {
        var_1 _id_4873();
        var_1 _id_2146();
    }
}

_id_45D5()
{
    if ( isdefined( level._id_6E6E ) )
    {
        foreach ( var_1 in level._id_6E6E )
        {
            var_1 _id_850B();
            var_1 _id_2B33();
            var_1 _id_4873();
        }
    }

    if ( isdefined( level._id_6E9F ) )
        common_scripts\utility::array_thread( level._id_6E9F, ::_id_2146 );
}

_id_633A( var_0 )
{
    if ( var_0._id_2A6C == "up" && 0 )
        self.goal = self._id_57EB;
    else if ( var_0._id_2A6C == "down" && 1 )
        self.goal = self._id_57EB;
    else
        self.goal = self._id_57EA;
}

_id_0702( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );

    if ( isdefined( var_1 ) )
    {
        level notify( var_1 );
        level endon( var_1 );
    }

    if ( !isdefined( var_2 ) )
        var_2 = 3;

    if ( !isdefined( var_3 ) )
        var_3 = 5;

    for (;;)
    {
        level thread common_scripts\_exploder::_id_06F5( var_0 );
        wait(randomfloatrange( var_2, var_3 ));
    }
}

_id_468C( var_0 )
{
    level endon( "game_ended" );
    var_1 = undefined;

    if ( isdefined( self.target ) )
        var_1 = common_scripts\utility::getstruct( self.target, "targetname" );

    var_2 = self.origin - var_0.origin;
    childthread _id_5F96( var_0, var_2 );

    if ( isdefined( var_1 ) )
    {
        var_3 = var_1.origin[2] - self.origin[2];
        var_4 = var_2 + ( 0, 0, var_3 );
        var_1 childthread _id_5F96( var_0, var_4 );
    }
}

_id_5F96( var_0, var_1 )
{
    for (;;)
    {
        self.origin = var_0.origin + var_1;
        wait 0.05;
    }
}

_id_8A06()
{
    level._id_85B8 = 0;
    level.dynamicspawns = ::_id_4005;
}

_id_4005( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3 _id_51F4() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

_id_51F4()
{
    if ( level._id_85B8 == 1 && self.targetname == "ocean_spawn" )
        return 0;

    return 1;
}

_id_8A58()
{
    self show();
    self rotatevelocity( ( 0.0, 600.0, 0.0 ), 12 );
    var_0 = _func_231( "tsunami_alarm", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part", "siren_on" );
}

_id_8A59()
{
    self hide();
    var_0 = _func_231( "tsunami_alarm", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part", "siren_off" );
}

_id_0F91()
{

}

_id_0EEF( var_0 )
{
    thread _id_0F53( var_0 );
    thread _id_0F5C();
    thread _id_0F5D();
    thread _id_0F51();
}

_id_0F5C()
{
    wait 2;
    thread maps\mp\_audio::_id_8730( "mp_laser2_vo_tsunami_warn_tide", ( 0.0, 0.0, 0.0 ) );
    wait 5;
    thread maps\mp\_audio::_id_8730( "mp_laser2_vo_tsunami_warn_high_ground", ( 0.0, 0.0, 0.0 ) );
}

_id_0F53( var_0 )
{
    thread maps\mp\_audio::_id_8730( "mp_laser2_ty_initial_hit", ( 0.0, 0.0, 0.0 ) );
}

_id_0F51()
{
    level endon( "aud_kill_dings" );

    for (;;)
    {
        thread maps\mp\_audio::_id_8730( "mp_laser_buoy_ding_event", ( 150.0, -2295.0, 403.0 ) );
        wait 0.5;
        thread maps\mp\_audio::_id_8730( "mp_laser_buoy_ding_event", ( 1026.0, -2381.0, 403.0 ) );
        wait 6;
    }
}

_id_0F5D()
{
    var_0 = thread maps\mp\_audio::_id_873B( "mp_laser2_ty_quake_lp", ( 79.0, -1591.0, 455.0 ), "aud_dynamic_event_end" );
    thread _id_0F5E();
    var_0 scalevolume( 0, 0.05 );
    wait 16.5;
    thread _id_0F55();
    var_0 scalevolume( 0.8, 8 );
}

_id_0F55()
{
    thread maps\mp\_audio::_id_8730( "mp_laser2_ty_incoming", ( 79.0, -1591.0, 455.0 ) );
    wait 4;
    level notify( "aud_kill_dings" );
    earthquake( 0.1, 4, ( 79.0, -1591.0, 455.0 ), 2500 );
    wait 1.2;
    earthquake( 0.2, 4, ( 79.0, -1591.0, 455.0 ), 2500 );
    wait 2;
    earthquake( 0.3, 5.5, ( 79.0, -1591.0, 455.0 ), 2500 );
}

_id_0F5E()
{
    wait 27;
    level notify( "aud_dynamic_event_end" );
    level._id_065D._id_2FDE = 1;

    foreach ( var_1 in level.players )
    {
        var_1 _meth_84D8( "mp_pre_event_mix" );
        wait 0.05;
    }

    wait 0.05;

    foreach ( var_1 in level.players )
    {
        var_1 _meth_84D7( "mp_post_event_mix", 1 );
        wait 0.05;
    }
}

_id_4687()
{
    level endon( "game_ended" );
    var_0 = getentarray( "tsunami_speaker", "targetname" );

    while ( level._id_A28C == 1 )
    {
        if ( isdefined( var_0 ) )
        {
            foreach ( var_2 in var_0 )
                playsoundatpos( var_2.origin, level._id_98CF );

            playsoundatpos( ( 0.0, 0.0, 0.0 ), level._id_98CF );
        }

        common_scripts\utility::array_thread( level._id_09C1._id_8A5A, ::_id_8A58 );
        wait 2;

        if ( !isdefined( level._id_A28C ) || level._id_A28C != 1 )
            return;

        foreach ( var_2 in var_0 )
        {

        }

        wait 3;
    }
}
