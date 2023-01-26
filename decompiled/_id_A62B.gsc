// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    precachemodel( var_0 );
    _id_A59A::set_console_status();
    _id_8252( var_2 );
    level._effect["pdrone_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["pdrone_large_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_large_explosion" );
    level._effect["pdrone_emp_death"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["emp_drone_damage"] = loadfx( "vfx/sparks/emp_drone_damage" );
    level._effect["pdrone_smoke_trail"] = loadfx( "vfx/trail/trail_drone_fire_smk_sm_runner_1" );
    level._effect["drone_muzzle_flash"] = loadfx( "vfx/muzzleflash/pdrone_flash_wv" );
    level._effect["drone_fan_distortion"] = loadfx( "vfx/distortion/drone_fan_distortion" );
    level._effect["drone_fan_distortion_large"] = loadfx( "vfx/distortion/drone_fan_distortion_large" );
    level._effect["drone_thruster_distortion"] = loadfx( "vfx/distortion/drone_thruster_distortion" );
    level._effect["drone_beacon_red"] = loadfx( "vfx/lights/light_drone_beacon_red" );
    level._effect["drone_beacon_red_fast"] = loadfx( "vfx/lights/light_drone_beacon_red_fast" );
    level._effect["drone_beacon_blue_fast"] = loadfx( "vfx/lights/light_drone_beacon_blue_fast" );
    level._effect["drone_beacon_red_slow_nolight"] = loadfx( "vfx/lights/light_drone_beacon_red_slow_nolight" );
    level._effect["drone_beacon_blue_slow_nolight"] = loadfx( "vfx/lights/light_drone_beacon_blue_slow_nolight" );
    level._effect["drone_beacon_red_sm_nolight"] = loadfx( "vfx/lights/light_drone_beacon_red_sm_nolight" );
    level._id_78AE["personal_drone"] = #animtree;
    level._id_78B2["personal_drone"] = var_0;
    level._id_78A9["personal_drone"]["drone_deploy_crouch_to_crouch"] = %drone_deploy_crouch_to_crouch;
    level._id_78A9["personal_drone"]["drone_deploy_crouch_to_run"] = %drone_deploy_crouch_to_run;
    level._id_78A9["personal_drone"]["drone_deploy_run_to_run"] = %drone_deploy_run_to_run;
    level._id_78A9["personal_drone"]["drone_deploy_run_to_stand"] = %drone_deploy_run_to_stand;
    level._id_78A9["personal_drone"]["personal_drone_folded_idle"][0] = %personal_drone_folded_idle;
    _id_8066();
    var_3 = "pdrone";

    if ( isdefined( var_1 ) )
        var_3 = var_1;

    _id_A59E::_id_186C( var_3, var_0, var_1, var_2 );
    _id_A59E::_id_1859( ::_id_4D0D );
    _id_A59E::_id_1849( %atlas_assault_drone_lage_rotors, undefined, 0 );
    _id_A59E::_id_1846( 0.4, 0.8, 1024 );
    _id_A59E::_id_1856( level._id_678B[var_2]["health"] );
    _id_A59E::_id_186A( "allies" );
    _id_A59E::_id_185A();
    var_4 = randomfloatrange( 0, 1 );
    var_5 = var_2;
    _id_A59E::_id_1855();
}

#using_animtree("generic_human");

_id_8066()
{
    level._id_78A9["generic"]["drone_deploy_crouch_to_crouch"] = %drone_deploy_crouch_to_crouch_guy;
    level._id_78A9["generic"]["drone_deploy_crouch_to_run"] = %drone_deploy_crouch_to_run_guy;
    level._id_78A9["generic"]["drone_deploy_run_to_run"] = %drone_deploy_run_to_run_guy;
    level._id_78A9["generic"]["drone_deploy_run_to_stand"] = %drone_deploy_run_to_stand_guy;
}

_id_8252( var_0 )
{
    if ( !isdefined( level._id_678B ) )
        level._id_678B = [];

    if ( isdefined( level._id_678B[var_0] ) )
        return;

    level._id_678B[var_0] = [];
    level._id_678B[var_0]["health"] = 110;
    level._id_678B[var_0]["speed"] = 45;
    level._id_678B[var_0]["accel"] = 50;
    level._id_678B[var_0]["decel"] = 50;
    level._id_678B[var_0]["hover_radius"] = 0;
    level._id_678B[var_0]["hover_speed"] = 0;
    level._id_678B[var_0]["hover_accel"] = 0;
    level._id_678B[var_0]["pitchmax"] = 60;
    level._id_678B[var_0]["rollmax"] = 60;
    level._id_678B[var_0]["angle_vel_pitch"] = 90;
    level._id_678B[var_0]["angle_vel_yaw"] = 120;
    level._id_678B[var_0]["angle_vel_roll"] = 90;
    level._id_678B[var_0]["angle_accel"] = 400;
    level._id_678B[var_0]["yaw_speed"] = 180;
    level._id_678B[var_0]["yaw_accel"] = 250;
    level._id_678B[var_0]["yaw_decel"] = 100;
    level._id_678B[var_0]["yaw_over"] = 0.1;
    level._id_678B[var_0]["axial_move"] = 0;
    level._id_678B[var_0]["weap_fire_tags"] = [ "tag_flash" ];
    level._id_678B[var_0]["clear_look"] = 1;
}

_id_2E9C( var_0 )
{
    return level._id_678B[self.classname][var_0];
}

_id_4CC1( var_0, var_1, var_2 )
{
    self _meth_8253( _id_2E9C( "hover_radius" ), _id_2E9C( "hover_speed" ), _id_2E9C( "hover_accel" ) );
    self _meth_8294( _id_2E9C( "pitchmax" ), _id_2E9C( "rollmax" ) );
    var_3 = _id_2E9C( "speed" );
    var_4 = _id_2E9C( "accel" );
    var_5 = _id_2E9C( "decel" );

    if ( isdefined( var_0 ) )
        var_3 = var_0;

    if ( isdefined( var_1 ) )
        var_4 = var_1;

    if ( isdefined( var_2 ) )
        var_5 = var_2;

    self _meth_8283( var_3, var_4, var_5 );
    self _meth_84B1( _id_2E9C( "angle_vel_pitch" ), _id_2E9C( "angle_vel_yaw" ), _id_2E9C( "angle_vel_roll" ) );
    self _meth_84B2( _id_2E9C( "angle_accel" ) );
    self _meth_825A( 5 );
    self _meth_8292( _id_2E9C( "yaw_speed" ), _id_2E9C( "yaw_accel" ), _id_2E9C( "yaw_decel" ), _id_2E9C( "yaw_over" ) );
    self _meth_84E4( _id_2E9C( "axial_move" ) );
}

_id_4D0D()
{
    self endon( "death" );
    self._id_65A4 = distance( self gettagorigin( "tag_origin" ), self gettagorigin( "tag_ground" ) );
    self._id_7953 = 0;
    self._id_2D2F = 1;
    self._id_9CDA = ::_id_4CC1;

    if ( _id_90AB() )
        _id_4CC1();

    if ( self._id_7AE9 == "allies" )
    {
        thread _id_A59E::_id_9CFA( "friendly" );
        self._id_2161 = self setcontents( 0 );
    }
    else
    {
        thread _id_A59E::_id_9CFA( "hostile" );
        self._id_4B9E = 1;
        self._id_797B = "pdrone";
    }

    _id_A59A::_id_32DC( "sentient_controlled" );
    _id_A59A::_id_32DC( "fire_disabled" );

    if ( _id_90AB() )
    {
        self._id_9347 = 0;
        self._id_9346 = 0;
        self._id_0E0E = 0;
        self._id_38E7 = ( 0.0, 0.0, 0.0 );
        self._id_38E6 = ( 0.0, 0.0, 0.0 );
    }

    self._id_8F6D = 0;
    self._id_6DAD = 0;

    if ( _id_846C() )
        _id_8251();

    _id_A632::_id_186D();
    waittillframeend;
    self._id_3068 = ::_id_6777;
    _id_A59A::_id_0749( ::_id_6771 );
    thread _id_A51A::_id_5E3C();
    self._id_253C = ::_id_4541;
    var_0 = 0;

    if ( isdefined( self.script_parameters ) && self.script_parameters == "expendable" )
        var_0 = 1;

    if ( self._id_7AE9 != "allies" )
    {
        self enableaimassist();
        thread _id_A571::_id_591C();
    }

    if ( isdefined( self.script_parameters ) && self.script_parameters == "diveboat_weapon_target" )
    {
        _func_09A( self, ( 0.0, 0.0, 0.0 ) );
        _func_0A6( self, level.player );
    }
    else if ( self.classname != "script_vehicle_pdrone_kva" )
    {
        _func_09A( self, ( 0.0, 0.0, 0.0 ) );
        _func_0A5( self, 1 );
    }

    thread _id_6760( var_0 );
    thread _id_677C();
    self notify( "stop_kicking_up_dust" );
    thread _id_45D7();
}

_id_45D7()
{
    self endon( "death" );
    var_0 = spawnstruct();
    var_0._id_6F1E = "pdrone_atlas";
    var_1 = _id_A62C::_id_871D;

    if ( issubstr( self.classname, "pdrone_atlas_large" ) )
    {
        var_0._id_6F1E = "pdrone_atlas";
        var_1 = _id_A62C::_id_871D;
    }
    else if ( issubstr( self.classname, "pdrone_atlas" ) )
    {
        var_0._id_6F1E = "pdrone_atlas";
        var_1 = _id_A62C::_id_871D;
    }
    else if ( isdefined( level.script ) && level.script == "greece" )
    {
        var_0._id_6F1E = "pdrone_swarm";
        var_1 = _id_A62C::_id_8722;
    }

    _id_A5DE::snd_message( "snd_register_vehicle", var_0._id_6F1E, var_1 );
    _id_A5DE::snd_message( "snd_start_vehicle", var_0 );
}

_id_6760( var_0 )
{
    self endon( "death" );
    self _meth_8139( self._id_7AE9, var_0 );
    self _meth_8294( _id_2E9C( "pitchmax" ), _id_2E9C( "rollmax" ) );

    if ( isdefined( self.owner ) )
    {
        thread _id_6785();
        thread _id_0E23();
    }

    thread _id_A632::_id_67B3();
    thread _id_67B2();
}

_id_677C()
{
    self endon( "death" );
    var_0 = 0.3;

    if ( self.classname == "script_vehicle_pdrone_atlas" || self.classname == "script_vehicle_pdrone_atlas_lab" )
    {
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion" ), self, "TAG_FX_FAN_L" );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion" ), self, "TAG_FX_FAN_R" );
    }

    if ( self.classname == "script_vehicle_pdrone_atlas_large" )
    {
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion_large" ), self, "TAG_FX_FAN_L" );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion_large" ), self, "TAG_FX_FAN_R" );
    }

    if ( self.classname != "script_vehicle_pdrone_atlas" && self.classname != "script_vehicle_pdrone_atlas_lab" )
    {
        playfxontag( common_scripts\utility::getfx( "drone_thruster_distortion" ), self, "TAG_FX_THRUSTER_L" );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "drone_thruster_distortion" ), self, "TAG_FX_THRUSTER_R" );
    }

    if ( self._id_7AE9 == "axis" )
    {
        if ( self.classname == "script_vehicle_pdrone_atlas_lab" )
        {
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red_sm_nolight" ), self, "TAG_FX_BEACON_0" );
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red_sm_nolight" ), self, "TAG_FX_BEACON_1" );
        }
        else
        {
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_0" );
            wait(var_0);
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_1" );
            wait(var_0);
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_2" );
        }
    }
}

_id_0E23()
{
    self endon( "death" );
    self.owner waittill( "death", var_0 );

    if ( !isdefined( var_0 ) )
    {
        self delete();
        return;
    }

    thread _id_3926();
}

_id_6785()
{
    self.owner endon( "pdrone_returning" );
    self.owner endon( "death" );
    self endon( "death" );

    if ( self._id_7AE9 == "allies" )
    {
        self _meth_8253( 20, 20, 20 );
        self._id_01C7 = 64;
    }
    else
    {
        self _meth_8253( 0, 0, 0.05 );
        self._id_01C7 = 8;
    }

    self _meth_8283( 20, 20, 20 );
    self _meth_8293( "faster" );
    thread _id_6784();

    for (;;)
    {
        self.owner waittill( "pdrone_defend_point", var_0 );
        thread _id_6786( var_0 );
    }
}

_id_6784()
{
    self notify( "change_movement_type" );
    self endon( "change_movement_type" );
    self.owner endon( "pdrone_returning" );
    self.owner endon( "death" );
    self endon( "death" );
    var_0 = 0.2;

    if ( isplayer( self.owner ) )
    {
        var_1 = ( 1.0, 5.0, 3.0 );
        var_2 = ( -50.0, 130.0, 90.0 );
    }
    else
    {
        var_1 = ( 1.0, 64.0, 10.0 );
        var_2 = ( -60.0, 0.0, 95.0 );
    }

    wait(randomfloat( var_0 ));
    var_3 = 0;
    var_4 = self.origin;
    var_5 = self.origin;
    var_6 = self.origin;
    var_7 = 0;
    var_8 = ( 0.0, 0.0, 0.0 );
    var_9 = 0;
    var_10 = 0;
    var_11 = self.origin;
    var_12 = 0.05;

    if ( level.currentgen )
        var_12 = 0.25;

    for (;;)
    {
        var_9 += var_12;
        var_7 += var_12;

        if ( var_7 > 2 )
        {
            var_7 = 0;
            var_8 = ( randomfloatrange( -0.5, 0.5 ) * var_1[0], randomfloatrange( -0.5, 0.5 ) * var_1[1], randomfloatrange( -0.5, 0.5 ) * var_1[2] );
        }

        var_6 = transformmove( self.owner.origin, self.owner.angles, ( 0.0, 0.0, 0.0 ), ( 0, var_3, 0 ), var_2 + var_8, ( 0.0, 0.0, 0.0 ) )["origin"];

        if ( distance( var_6, var_5 ) > 16 )
        {
            if ( var_9 > var_0 )
            {
                if ( var_10 > 0.5 && common_scripts\utility::cointoss() )
                {
                    var_13 = 1;
                    var_14 = vectornormalize( self.owner.origin - self.origin );
                    var_15 = vectorcross( var_14, ( 0.0, 0.0, 1.0 ) );
                    var_16 = self.origin + var_15 * ( randomfloatrange( -1, 1 ) * 256 );
                }
                else
                {
                    var_13 = 0;
                    var_16 = var_6;
                }

                if ( _id_6763( self.origin, var_16 ) && _id_6764( var_16 ) )
                {
                    var_10 = 0;
                    var_5 = var_16;
                    var_4 = var_16;
                }
                else
                {
                    var_10 += var_9;
                    var_17 = randomfloat( 1 ) + randomfloat( 1 ) - 1;
                    var_3 = angleclamp( angleclamp180( var_3 ) * 0.5 + var_17 * 250 );
                }

                var_9 = 0;
            }
        }
        else
        {
            var_4 = var_6;
            var_10 = 0;
        }

        if ( var_10 > 3 )
        {
            if ( !level.player _id_A59A::_id_6E18( var_6 ) && !level.player _id_A59A::_id_6E18( self.origin ) && _id_6764( var_6 ) && _id_6765( var_6 ) )
            {
                self _meth_827C( var_6, self.angles );
                var_4 = var_6;
                var_5 = var_6;
            }
        }

        self _meth_825B( var_4, 1 );
        wait(var_12);
    }
}

_id_6763( var_0, var_1 )
{
    var_1 += vectornormalize( var_1 - var_0 ) * 32;
    var_0 += ( 0.0, 0.0, -24.0 );
    var_1 += ( 0.0, 0.0, -24.0 );
    var_2 = playerphysicstrace( var_0, var_1 );
    var_3 = distancesquared( var_2, var_1 ) < 0.01;
    return var_3;
}

_id_6765( var_0 )
{
    var_1 = var_0 + ( 0.0, 0.0, 12.0 );
    var_2 = playerphysicstrace( var_1, var_0 );
    var_3 = distancesquared( var_2, var_0 ) < 0.01;
    return var_3;
}

_id_6764( var_0 )
{
    var_1 = self.owner geteye();
    var_2 = sighttracepassed( var_0, var_1, 0, self );
    return var_2;
}

_id_6786( var_0 )
{
    self notify( "change_movement_type" );
    self endon( "change_movement_type" );
    self.owner endon( "pdrone_returning" );
    self.owner endon( "death" );
    self endon( "death" );
    var_1 = 110;
    var_2 = var_0["position"] + var_1 * var_0["normal"];
    self _meth_825B( var_2, 1 );
    self.owner common_scripts\utility::waittill_any_timeout( 10, "stop_pdrone_pov" );
    thread _id_6784();
}

_id_67B2( var_0 )
{
    self notify( "pdrone_targeting" );
    self endon( "pdrone_targeting" );

    if ( isdefined( self.owner ) )
        self.owner endon( "pdrone_returning" );

    self endon( "death" );
    self endon( "emp_death" );
    var_1 = "axis";

    if ( self._id_7AE9 == "axis" )
    {
        var_1 = "allies";

        if ( isdefined( self._id_5BD2 ) )
        {
            foreach ( var_3 in self._id_5BD2 )
                var_3._id_7AE9 = "axis";
        }
    }

    for (;;)
    {
        wait 0.05;

        if ( isdefined( self._id_2EDD._id_9310 ) )
        {
            self _meth_8265( self._id_2EDD._id_9310 );
            thread _id_6778( self._id_2EDD._id_9310, var_0 );
            self._id_2EDD._id_9310 common_scripts\utility::waittill_any_timeout( 5, "death", "target_lost" );
            continue;
        }

        if ( _id_2E9C( "clear_look" ) )
            self _meth_8266();

        if ( isdefined( self.owner ) )
            self _meth_825E( self.owner.angles[1] );
    }
}

_id_19CD( var_0 )
{
    var_1 = ( var_0.origin - self.origin ) * ( 1.0, 1.0, 0.0 );
    var_1 = vectornormalize( var_1 );
    var_1 = ( var_1[1], var_1[0] * -1, 0 );
    var_2 = abs( vectordot( var_1, var_0 getvelocity() ) );
    var_2 = clamp( var_2, 0, 250 ) / 250;
    var_2 = 1 - var_2;
    var_2 = clamp( var_2, 0.5, 1 );
    return var_2;
}

_id_19D3( var_0 )
{
    if ( var_0 getstance() == "crouch" )
        return 0.75;
    else if ( var_0 getstance() == "prone" )
        return 0.5;

    return 1;
}

_id_19D0( var_0 )
{
    if ( level.player _id_A59A::_id_32D7( "player_has_red_flashing_overlay" ) )
        return 0.5;

    return 1;
}

_id_19C6( var_0, var_1, var_2 )
{
    var_3 = self.origin - var_0.origin;
    var_3 *= ( 1.0, 1.0, 0.0 );
    var_3 = vectornormalize( var_3 );

    if ( isplayer( var_0 ) )
    {
        var_1 *= _id_19CD( var_0 );
        var_1 *= _id_19D3( var_0 );
        var_1 *= _id_19D0( var_0 );
    }

    var_4 = vectorcross( var_3, ( 0.0, 0.0, 1.0 ) );
    var_4 = vectornormalize( var_4 );
    var_5 = var_4 * 8 / var_1 * randomfloatrange( -1, 1 );
    var_6 = ( 0.0, 0.0, 8.0 ) / var_1 * randomfloatrange( -1, 1 );

    if ( isdefined( var_2 ) && var_2 )
    {

    }

    return var_5 + var_6;
}

_id_37A4( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 endon( "death" );
    self endon( "death" );
    self endon( "emp_death" );
    self endon( "pdrone_targeting" );

    while ( var_0 > 0 )
    {
        var_5 = 1;

        if ( isplayer( var_1 ) )
        {
            var_6 = min( self._id_2EDD._id_931E, 15 ) / 15;
            var_5 = _id_A59A::_id_5768( var_6, 0.15, 0.8 );
        }

        if ( isdefined( self._id_0E0D ) )
            var_5 *= self._id_0E0D;

        var_7 = _id_19C6( var_1, var_5, 0 );
        self._id_24D4 = var_7;
        var_8 = var_2 + var_7;
        var_9 = self.origin;

        if ( self _meth_8442( var_3 ) != -1 )
            var_9 = self gettagorigin( var_3 );

        var_10 = var_1.origin + var_8 - var_9;
        var_10 = vectornormalize( var_10 );

        if ( _id_676E( var_9, var_9 + var_10 * 10000 ) )
        {
            var_1 notify( "target_lost" );
            return;
        }

        _id_677B( var_9, var_1.origin + var_8 );
        var_0 -= var_4;
        wait(var_4);
    }
}

_id_6778( var_0, var_1 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "emp_death" );
    self endon( "pdrone_targeting" );

    if ( isdefined( self.owner ) )
        self.owner endon( "pdrone_returning" );

    self notify( "new_target" );
    self endon( "new_target" );
    var_2 = var_0 geteye() - var_0.origin;
    var_3 = ( 0, 0, var_2[2] );
    var_4 = 0.095;

    if ( !isdefined( var_1 ) )
        var_1 = 0.25;

    var_5 = var_1 * 0.8;
    var_6 = var_1 * 1.2;

    if ( level.currentgen )
    {
        var_4 = 0.2499;
        var_5 *= 2.5;
        var_6 *= 2.5;
    }

    var_7 = _id_19C6( var_0, 1, 0 );
    var_8 = var_3 + var_7;

    for (;;)
    {
        self _meth_8262( var_0, var_8 );
        var_9 = self.origin;
        var_10 = _id_2E9C( "weap_fire_tags" );
        var_11 = var_10[0];

        if ( self _meth_8442( var_11 ) != -1 )
            var_9 = self gettagorigin( var_11 );

        if ( self._id_6DAD || self._id_8F6D > 0 || _id_676E( var_9, var_0.origin + var_8 ) || !isdefined( self._id_2EDD._id_9310 ) || self._id_2EDD._id_9310 != var_0 )
        {
            var_0 notify( "target_lost" );
            return;
        }

        if ( _id_90AB() )
        {
            if ( isdefined( self._id_0E0E ) && !self._id_0E0E )
            {
                wait 0.05;
                continue;
            }

            if ( length( self _meth_8287() ) > 1 )
            {
                wait 0.05;
                continue;
            }

            if ( isdefined( self._id_0E26 ) && self._id_0E26 && !sighttracepassed( var_9, var_0 geteye(), 0, self, var_0 ) )
            {
                self._id_0E0E = 0;
                wait 0.05;
                continue;
            }
        }

        var_12 = randomfloatrange( 2, 3 );

        while ( var_12 > 0 )
        {
            if ( self._id_6DAD || self._id_8F6D > 0 )
                break;

            var_13 = randomfloatrange( var_5, var_6 );
            var_13 = min( var_13, var_12 );
            _id_37A4( var_13, var_0, var_3, var_11, var_4 );
            var_12 -= var_13;

            if ( _id_90AB() )
            {
                self._id_0E0E = 0;
                wait 0.05;
                break;
            }

            var_14 = randomfloatrange( 0.5, 1 );
            var_14 = min( var_14, var_12 );

            if ( var_14 > 0 )
            {
                var_12 -= var_14;
                wait(var_14);
            }
        }
    }
}

_id_677B( var_0, var_1 )
{
    self notify( "weapon_fired" );
    playfxontag( level._effect["drone_muzzle_flash"], self, "tag_flash" );
    magicbullet( "pdrone_turret", var_0, var_1 );
}

_id_0BA2( var_0, var_1 )
{
    return ( angleclamp180( var_0[0] - var_1[0] ), angleclamp180( var_0[1] - var_1[1] ), angleclamp180( var_0[2] - var_1[2] ) );
}

_id_676E( var_0, var_1 )
{
    if ( self._id_7AE9 == "axis" )
        return 0;
    else
        return _id_A59A::_id_8436( var_0, var_1 );
}

_id_6771( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_1 ) && isdefined( var_1._id_7AE9 ) && self._id_7AE9 == var_1._id_7AE9 )
        return;

    if ( isdefined( var_1 ) && isdefined( var_1.classname ) && var_1.classname == "worldspawn" )
    {
        self.health = int( min( self.maxhealth, self.health + var_0 ) );
        return;
    }

    self._id_5512 = var_1;
    self._id_5513 = var_2;
    self._id_5514 = var_3;

    if ( var_4 == "MOD_ENERGY" )
        self dodamage( var_0 * 4, var_1.origin, var_1 );
    else if ( isalive( self ) && isdefined( var_1 ) && !isplayer( var_1 ) )
        self.health = int( min( self.maxhealth, self.health + var_0 * 0.7 ) );

    if ( _id_846C() )
        _id_695C();
}

_id_68B1()
{
    if ( self.classname == "script_vehicle_pdrone_atlas_large" )
    {
        playfx( common_scripts\utility::getfx( "pdrone_large_death_explosion" ), self gettagorigin( "tag_origin" ) );
        _id_A5DE::snd_message( "pdrone_death_explode" );
    }
    else
    {
        playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), self gettagorigin( "tag_origin" ) );
        _id_A5DE::snd_message( "pdrone_death_explode" );
    }
}

_id_4541()
{
    if ( !isdefined( self ) )
        return;

    self._id_235D = 1;

    if ( self._id_7AE9 != "allies" && !isdefined( self.owner ) && isdefined( self._id_5512 ) && randomfloat( 1 ) < 0.4 )
    {
        var_0 = randomintrange( 0, 3 );

        switch ( var_0 )
        {
            case 0:
                _id_263E( self._id_5512 );
                break;
            case 1:
                thread _id_264B( self._id_5512 );
                break;
            case 2:
                thread _id_2649( self._id_5512 );
                break;
        }
    }
    else
        _id_68B1();

    if ( isdefined( self ) )
    {
        self notify( "crash_done" );
        self delete();
    }
}

_id_6777()
{
    self endon( "death" );
    self endon( "in_air_explosion" );
    self notify( "emp_death" );
    self._id_9D43 = 1;
    var_0 = self _meth_8287();
    var_1 = 60;

    if ( isdefined( level._id_3E19 ) )
        var_2 = [[ level._id_3E19 ]]();
    else
    {
        var_3 = ( self.origin[0] + var_0[0] * 10, self.origin[1] + var_0[1] * 10, self.origin[2] - 2000 );
        var_2 = physicstrace( self.origin, var_3 );
    }

    self notify( "newpath" );
    self notify( "deathspin" );
    thread _id_2E3B();
    var_4 = 60;
    self _meth_8283( var_4, 60, 1000 );
    self _meth_825A( var_1 );
    self _meth_825B( var_2, 0 );
    thread _id_2E43( var_2, var_1, var_4 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
    _id_68B1();
    self delete();
}

#using_animtree("script_model");

_id_2E3B()
{
    level._id_78AE["pdrone_dummy"] = #animtree;
    level._id_78A9["pdrone_dummy"]["roll_left"][0] = %rotate_x_l;
    level._id_78A9["pdrone_dummy"]["roll_right"][0] = %rotate_x_r;
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 linkto( self );

    if ( isdefined( self._id_2644 ) )
        var_0 setmodel( self._id_2644 );
    else
        var_0 setmodel( self.model );

    self hide();
    stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_0, "TAG_ORIGIN" );
    var_0._id_0C72 = "pdrone_dummy";
    var_0 _id_A59A::_id_0D61();

    if ( common_scripts\utility::cointoss() )
        var_1 = "roll_left";
    else
        var_1 = "roll_right";

    var_0 thread _id_A506::_id_0BE1( var_0, var_1 );
    self waittill( "death" );
    var_0 delete();
}

_id_2E43( var_0, var_1, var_2 )
{
    self endon( "crash_done" );
    self _meth_8266();
    self _meth_8294( 180, 180 );
    self _meth_8292( 400, 100, 100 );
    self _meth_8296( 1 );
    var_3 = 1400;
    var_4 = 800;
    var_5 = undefined;
    var_6 = 90 * randomintrange( -2, 3 );

    for (;;)
    {
        if ( !isdefined( self ) )
            break;

        if ( self.origin[2] < var_0[2] + var_1 )
            self notify( "near_goal" );

        if ( common_scripts\utility::cointoss() )
        {
            var_5 = self.angles[1] - 300;
            self _meth_8292( var_3, var_4 );
            self _meth_825E( var_5 );
            self _meth_825E( var_5 );
        }

        wait 0.05;
    }
}

_id_264B( var_0 )
{
    var_1 = spawn( "script_model", self.origin );
    var_1.angles = self.angles;

    if ( isdefined( self._id_2644 ) )
        var_1 setmodel( self._id_2644 );
    else
        var_1 setmodel( self.model );

    self hide();
    stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_1, "TAG_ORIGIN" );
    _id_A5DE::snd_message( "pdrone_emp_death", var_1 );
    var_2 = ( self.origin[0], self.origin[1], self.origin[2] - 500 );
    var_3 = physicstrace( self.origin, var_2 );
    var_4 = 0;
    var_5 = 5;
    var_6 = var_0.origin - var_1.origin;
    var_6 = vectornormalize( var_6 );
    var_7 = vectorcross( ( 0.0, 0.0, 1.0 ), var_6 );
    var_7 = vectornormalize( var_7 );
    var_8 = 100;
    var_9 = var_1.origin + var_7 * var_8;
    var_10 = vectortoangles( var_1.origin - var_9 );
    var_11 = 1;

    if ( common_scripts\utility::cointoss() )
        var_11 = -1;

    while ( var_4 < 5 )
    {
        wait 0.05;
        var_4 += 0.05;
        var_10 += ( 0.0, 10.0, 0.0 ) * var_11;
        var_12 = _id_A59A::_id_5768( clamp( var_4 / 3, 0, 1 ), 2, 30 );
        var_9 -= ( 0, 0, var_12 );
        var_13 = var_9 + anglestoforward( var_10 ) * var_8;
        var_14 = physicstrace( var_1.origin, var_13, var_1 );
        var_1.origin = var_13;
        var_1.angles += ( 0.0, 50.0, 0.0 ) * var_11;
        var_15 = length( var_3 - var_1.origin );

        if ( var_15 < 60 || var_1.origin[2] < var_3[2] + 15 || var_14 != var_13 )
            break;
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_1.origin );
    _id_A5DE::snd_message( "pdrone_crash_land", var_1.origin );
    var_1 delete();
}

_id_263E( var_0 )
{
    self._id_9D43 = 1;
    var_1 = var_0.origin - self.origin;
    var_1 = vectornormalize( var_1 );
    var_2 = vectorcross( ( 0.0, 0.0, 1.0 ), var_1 );
    var_2 = vectornormalize( var_2 );

    if ( common_scripts\utility::cointoss() )
        var_2 *= -1;

    var_3 = var_0.origin - var_1 * ( 1.0, 1.0, 0.0 ) * 250 + var_2 * 250;
    var_3 = ( var_3[0], var_3[1], self.origin[2] );
    var_4 = common_scripts\utility::randomvectorincone( vectornormalize( var_3 - self.origin ), 15 );
    var_5 = self.origin + var_4 * 250;
    var_3 = physicstrace( self.origin, var_5 );
    self notify( "newpath" );
    self notify( "deathspin" );
    self _meth_825A( 60 );
    self _meth_8260( var_3, _id_2E9C( "speed" ) * 0.75, _id_2E9C( "accel" ), _id_2E9C( "decel" ), undefined, undefined, 0, 0, 0, 0, 0, 0, 0 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    _id_2648();
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
}

_id_2648()
{
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 setmodel( self.model );
    self hide();

    if ( !issubstr( self.classname, "_security" ) )
        stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );

    var_1 = 0;
    var_2 = self _meth_8287();
    var_3 = squared( 0.05 );

    for ( var_4 = ( 0.0, 0.0, -980.0 ); var_1 < 5; var_1 += 0.05 )
    {
        wait 0.05;
        var_2 = var_4 * 0.05 + var_2;
        var_2 = _func_284( var_2, 1000 );
        var_5 = var_2 * 0.05 + var_4 * var_3 / 2;
        var_6 = var_0.origin + var_5;
        var_7 = physicstrace( var_0.origin, var_6, var_0 );

        if ( var_7 != var_6 )
            break;

        var_0.origin = var_6;
        var_0.angles += ( 0.0, 5.0, 0.0 );
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_0.origin );
    _id_A5DE::snd_message( "pdrone_crash_land", var_0.origin );
    var_0 delete();
}

_id_2649( var_0 )
{
    var_1 = self.origin;
    self hide();
    var_2 = 0;
    var_3 = 1;
    var_4 = 0;
    var_5 = 0;
    var_6 = level.player geteye() - var_1;
    var_7 = self.origin;
    var_8 = level.player.origin - self.origin;
    var_8 = vectornormalize( var_8 );
    var_9 = var_8 * ( 1.0, 1.0, 0.0 );
    var_10 = vectorcross( ( 0.0, 0.0, 1.0 ), var_8 );
    var_10 = vectornormalize( var_10 );
    var_11 = -5;

    if ( common_scripts\utility::cointoss() )
    {
        var_10 *= -1;
        var_11 = 5;
    }

    var_12 = var_10;
    var_13 = var_7 + var_12 * 600 + ( 0.0, 0.0, 250.0 );
    var_14 = var_7 + var_12 * 300 + ( 0.0, 0.0, 500.0 );
    var_15 = common_scripts\utility::spawn_tag_origin();
    var_15.origin = var_7;
    var_15._id_6685 = var_7;
    var_15._id_2F38 = spawn( "script_model", var_7 );
    var_15._id_2F38.angles = self.angles;
    var_15._id_2F38 setmodel( self.model );
    var_15._id_04FF = ( 0.0, 0.0, 0.0 );
    playfxontag( common_scripts\utility::getfx( "pdrone_smoke_trail" ), var_15._id_2F38, "TAG_ORIGIN" );
    thread _id_758F( var_1, level.player, var_15, var_2, var_4, var_5 );
    var_16 = 0;
    var_17 = 1 / var_3 * 20;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;

    while ( var_18 <= 1 )
    {
        wait 0.05;
        var_21 = squared( 1 - var_16 ) * var_7 + 2 * var_16 * ( 1 - var_16 ) * var_14 + squared( var_16 ) * var_13;
        var_22 = var_15._id_6685;
        var_15._id_6685 = var_21;
        var_15._id_04FF = var_15._id_6685 - var_22;
        var_23 = physicstrace( var_22, var_15._id_6685, var_15._id_2F38 );

        if ( var_23 != var_15._id_6685 )
        {
            var_20 = 1;
            break;
        }

        var_24 = _func_247( var_15._id_2F38.angles );
        var_25 = var_24["forward"];
        var_26 = var_24["up"];
        var_27 = var_24["right"];
        var_25 = rotatepointaroundvector( var_9, var_25, var_11 );
        var_26 = rotatepointaroundvector( var_9, var_26, var_11 );
        var_27 = rotatepointaroundvector( var_9, var_27, var_11 );
        var_15._id_2F38.angles = axistoangles( var_25, var_27, var_26 );
        var_18 += var_17;
        var_16 = squared( var_18 );

        if ( var_19 )
            break;

        if ( var_18 > 1 )
        {
            var_18 = 1;
            var_19 = 1;
        }
    }

    var_15 notify( "RocketPositionUpdate" );
    var_28 = 0;
    var_29 = var_15._id_04FF * 20;
    var_30 = squared( 0.05 );

    for ( var_31 = ( 0.0, 0.0, -980.0 ); var_28 < 5 && !var_20; var_28 += 0.05 )
    {
        wait 0.05;
        var_29 = var_31 * 0.05 + var_29;
        var_29 = _func_284( var_29, 1000 );
        var_32 = var_29 * 0.05 + var_31 * var_30 / 2;
        var_33 = var_15._id_2F38.origin + var_32;
        var_23 = physicstrace( var_15._id_2F38.origin, var_33, var_15._id_2F38 );

        if ( var_23 != var_33 )
            break;

        var_15._id_2F38.origin = var_33;
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_15._id_2F38.origin );
    _id_A5DE::snd_message( "pdrone_crash_land", var_15._id_2F38.origin );
    var_15._id_2F38 delete();
    var_15 delete();
}

_id_758F( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_2 endon( "RocketPositionUpdate" );
    var_6 = vectortoangles( var_1.origin - var_0 );
    var_7 = var_3;
    var_8 = ( 0.0, 0.0, 0.0 );

    if ( common_scripts\utility::cointoss() )
        var_4 *= -1;

    var_9 = var_5 / 5;
    var_10 = 0;

    for (;;)
    {
        wait 0.05;
        var_7 += var_4;

        if ( isdefined( var_2._id_912F ) )
            var_6 = vectortoangles( var_2._id_912F );

        var_8 = ( 0.0, 0.0, 1.0 ) * var_10;
        var_11 = transformmove( var_2._id_6685, var_6, ( 0.0, 0.0, 0.0 ), ( 0, 0, var_7 ), var_8, ( 0.0, 0.0, 0.0 ) );
        var_8 = var_11["origin"];
        var_2.origin = vectorlerp( var_2.origin, var_8, 0.5 );
        var_2._id_2F38.origin = var_2.origin;
        var_10 += var_9;
        var_10 = clamp( var_10, 0, var_5 );
    }
}

_id_6761( var_0 )
{
    var_1 = var_0 _id_A59A::_id_88BD( 1 );
    var_1._id_0C72 = "generic";
    var_2 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_3 = spawn( "script_origin", var_2.origin );
    var_3.angles = var_2.angles;
    var_4 = getent( var_2.target, "targetname" );
    var_5 = 0;
    var_6 = undefined;

    switch ( var_2._id_0046 )
    {
        case "drone_deploy_crouch_to_crouch_guy":
            var_6 = "Cover Crouch";
            break;
        case "drone_deploy_crouch_to_run_guy":
            var_5 = 1;
            var_6 = "Cover Crouch";
            break;
        case "drone_deploy_run_to_run_guy":
            var_5 = 1;
            break;
        case "drone_deploy_run_to_stand_guy":
            break;
        default:
            break;
    }

    var_7 = getsubstr( var_2._id_0046, 0, var_2._id_0046.size - 4 );
    var_8 = spawn( "script_model", var_1 gettagorigin( "J_Spine4" ) );
    var_8 setmodel( var_4.model );
    var_9 = var_1 gettagangles( "J_Spine4" );
    var_8.angles = var_9;
    var_8 linkto( var_1, "J_Spine4", ( -3.746, -9.852, -0.08 ), ( 0.0, 0.0, 90.0 ) );
    var_8._id_0C72 = "personal_drone";
    var_8 _meth_8115( level._id_78AE["personal_drone"] );
    var_8 _meth_814B( level._id_78A9["personal_drone"]["personal_drone_folded_idle"][0], 1, 0 );
    var_1._id_01FC = 1;

    if ( isdefined( var_6 ) )
        var_3 _id_A506::_id_0BF5( var_1, var_7, undefined, var_6 );
    else
        var_3 _id_A506::_id_0BD0( var_1, var_7 );

    var_3 _id_A506::_id_0BD0( var_1, var_7 );

    if ( isdefined( var_5 ) && var_5 )
        var_3 thread _id_A506::_id_0BD2( var_1, var_7 );
    else
        var_3 thread _id_A506::_id_0BC9( var_1, var_7 );

    var_4.origin = var_8.origin;
    var_4.angles = var_8.angles;
    var_10 = var_4 _id_A59A::_id_896F();

    if ( isdefined( var_10.target ) )
        var_11 = 0;
    else
    {
        var_11 = 1;
        var_10.owner = var_1;
    }

    var_10._id_02EA = 1;
    var_8 delete();
    var_10._id_0C72 = "personal_drone";
    var_3 _id_A506::_id_0C24( var_10, var_7 );
    var_10._id_02EA = undefined;
    var_1._id_01FC = 0;

    if ( !var_11 )
        var_10 _id_A59E::_id_4277();

    return var_1;
}

_id_28C2()
{
    self endon( "death" );

    for (;;)
    {
        if ( getdvar( "debug_nuke" ) == "on" )
            self dodamage( self.health + 99999, ( 0.0, 0.0, -500.0 ), level.player );

        wait 0.05;
    }
}

_id_392A()
{
    level._id_6C2C = common_scripts\utility::getstructarray( "player_test_point", "targetname" );
    level._id_2E1D = getentarray( "drone_air_space", "script_noteworthy" );

    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];
}

_id_8BA9( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "flying_attack_drone";

    var_1 = _id_A59E::_id_8977( var_0 );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) )
        {
            var_3._id_6030 = var_0;
            var_3 thread _id_3926();
        }
    }

    return var_1;
}

_id_8BA8( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "flying_attack_drone";

    var_1 = _id_A59E::_id_8973( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_1._id_6030 = var_0;
        var_1 thread _id_3926();
    }

    return var_1;
}

_id_4CE0()
{
    if ( _id_90AB() )
        return;

    var_0 = undefined;

    if ( !isdefined( self._id_792D ) )
        var_0 = 40;
    else
        var_0 = self._id_792D;

    self _meth_825A( 30 );
    self _meth_8283( var_0, var_0 / 4, var_0 / 4 );
}

_id_3926( var_0 )
{
    self notify( "pdrone_flying_attack_drone_logic" );
    self endon( "pdrone_flying_attack_drone_logic" );
    self endon( "death" );
    var_0 = self;
    var_0 childthread _id_3922();
    var_0 childthread _id_3929();
    var_0 thread _id_3924();
    var_0 _id_4CE0();

    if ( isdefined( var_0.target ) )
        var_0 waittill( "reached_dynamic_path_end" );

    if ( _id_90AB() )
        var_0 childthread _id_9AAD();
    else
        var_0 childthread _id_3928();

    if ( _id_846C() )
        var_0 childthread _id_4B64();
}

_id_8EB9()
{
    self.target = undefined;
    _id_A59A::_id_9CAB();
    thread _id_3926();
}

_id_90AB()
{
    return isdefined( level._id_2ED5 ) && isdefined( level._id_2ED5.enabled );
}

_id_3E86( var_0 )
{
    if ( _id_90AB() )
        return level._id_2ED5._id_9191;

    var_1 = common_scripts\utility::getclosest( var_0.origin, level._id_6C2C );
    return getent( var_1.target, "targetname" );
}

_id_3928()
{
    self endon( "death" );
    self endon( "pdrone_flying_attack_drone_logic" );

    if ( !isdefined( level._id_2E1D ) )
        return;

    self._id_24D5 = common_scripts\utility::getclosest( self.origin, level._id_2E1D );
    _id_9AB6();
    self waittill( "near_goal" );
    wait 0.05;

    for (;;)
    {
        var_0 = _id_A59A::_id_3CFD( self.origin );
        self _meth_8265( var_0 );
        var_1 = _id_3E86( var_0 );

        if ( var_1 != self._id_24D5 )
        {
            var_2 = _id_3DE8( self._id_24D5, var_1, level._id_2E1D );

            if ( isdefined( var_2 ) )
                self._id_24D5 = var_2;
        }

        _id_9AB6();
        self waittill( "near_goal" );

        if ( var_1 == self._id_24D5 )
        {
            _id_9FD0();
            _id_9F9D();
        }
    }
}

_id_9AAD()
{
    self endon( "death" );

    if ( !isdefined( level._id_2E1D ) )
        return;

    self._id_24D5 = common_scripts\utility::getclosest( self.origin, level._id_2E1D );
    _id_9AB6();
    self waittill( "near_goal" );
    wait 0.05;

    for (;;)
    {
        var_0 = _id_A59A::_id_3CFD( self.origin );
        self _meth_8265( var_0 );
        var_1 = level._id_2ED5._id_9191;

        if ( var_1 != self._id_24D5 )
        {
            if ( randomfloat( 1 ) > 0.5 )
                wait(randomfloat( 1 ));

            var_2 = _id_3DE8( self._id_24D5, var_1, level._id_2E1D );

            if ( isdefined( var_2 ) )
                self._id_24D5 = var_2;
        }

        if ( _id_90AA() )
            self waittill( "near_goal" );

        if ( var_1 == self._id_24D5 )
        {
            wait 0.05;
            _id_9F9D();
        }
    }
}

_id_9FD0()
{
    level endon( "pdrone_wait_in_current_air_space" );

    if ( !_id_90AB() )
    {
        wait(randomfloatrange( 0.5, 1.5 ));
        return;
    }

    var_0 = 0;

    if ( _id_90AB() )
    {
        if ( randomfloat( 1 ) < 0.25 )
            var_0 = randomfloatrange( 1, 2.5 );
        else
            var_0 = randomfloatrange( 0, 1 );
    }

    var_1 = 0;

    while ( var_1 < var_0 )
    {
        wait 0.05;
        var_1 += 0.05;

        if ( self._id_24D5 != level._id_2ED5._id_9191 )
            break;
    }
}

_id_9F9D()
{
    self endon( "death" );

    while ( self._id_6DAD || self._id_8F6D > 0 )
    {
        wait 0.05;
        self._id_8F6D -= 0.05;
    }
}

_id_19C0()
{
    var_0 = self.origin;

    if ( !_func_22A( var_0, self._id_24D5 ) )
        var_0 = _id_3E43( self._id_24D5 );
    else
    {
        var_1 = 0;
        var_2 = 0;
        var_3 = ( 0.0, 0.0, 0.0 );
        var_4 = 0;
        var_5 = ( 0.0, 0.0, 0.0 );

        foreach ( var_7 in level.flying_attack_drones )
        {
            if ( self != var_7 && isdefined( self._id_24D5 ) && isdefined( var_7._id_24D5 ) )
            {
                if ( self._id_24D5 == var_7._id_24D5 )
                {
                    var_1++;
                    var_8 = var_7.origin - self.origin;
                    var_9 = length( var_8 );

                    if ( var_9 < 90 )
                    {
                        var_2++;
                        var_3 -= 0.5 * ( 90 - var_9 ) * var_8 / var_9;
                    }
                    else if ( var_9 > 150 )
                    {
                        var_4++;
                        var_5 += 0.5 * ( var_9 - 150 ) * var_8 / var_9;
                    }
                }
            }
        }

        if ( var_1 > 0 )
        {
            if ( randomint( 5 ) == 0 )
                var_0 = _id_3E43( self._id_24D5 );
            else
            {
                if ( var_2 > 0 )
                    var_0 += var_3 / var_2;

                if ( var_4 > 0 )
                    var_0 += var_5 / var_4;
            }
        }
        else
            var_0 = _id_3E43( self._id_24D5 );
    }

    return var_0;
}

_id_3E82()
{
    if ( self._id_24D5 != level._id_2ED5._id_9191 || !isdefined( self._id_24EB ) || !isdefined( self._id_24EA ) )
        return _id_3E43( self._id_24D5 );

    if ( isdefined( self._id_2C28 ) )
        return self._id_2C28;

    var_0 = self._id_24EB + self._id_24EA;

    if ( length( var_0 - self.origin ) < 10 )
        return undefined;

    return var_0;
}

_id_19CF( var_0 )
{
    if ( isdefined( self._id_2E88 ) )
        return vectortoyaw( self._id_2E88.origin - var_0 );

    if ( !isdefined( self._id_2EDD ) || !isdefined( self._id_2EDD._id_9310 ) )
    {
        var_1 = var_0 - self.origin;

        if ( var_1 != ( 0.0, 0.0, 0.0 ) )
            return vectortoyaw( var_1 );

        return self.angles[1];
    }

    return undefined;
}

_id_90AA()
{
    var_0 = _id_3E82();

    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = _id_19CF( var_0 );
    var_2 = undefined;

    if ( isdefined( var_1 ) )
        var_2 = 1;
    else
        var_1 = self.angles[1];

    self _meth_8260( var_0, _id_2E9C( "speed" ), _id_2E9C( "accel" ), _id_2E9C( "decel" ), undefined, var_2, var_1, 0, 0, 0, 0, 0, 1 );
    return 1;
}

_id_9AB6()
{
    if ( _id_90AB() )
        _id_90AA();
    else
        self _meth_825B( _id_19C0(), 1 );
}

_id_3E43( var_0 )
{
    for ( var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ); !_func_22A( var_1, var_0 ); var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) )
    {

    }

    return var_1;
}

_id_3922()
{
    self endon( "death" );
    self.damagetaken = 0;
    self._id_51C5 = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
            continue;

        self notify( "flying_attack_drone_damaged_by_player" );
        thread _id_3923();
    }
}

_id_3923()
{
    self notify( "taking damage" );
    self endon( "taking damage" );
    self endon( "death" );
    self._id_51C5 = 1;
    wait 1;
    self._id_51C5 = 0;
}

_id_3924()
{
    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];

    level.flying_attack_drones = common_scripts\utility::array_add( level.flying_attack_drones, self );
    common_scripts\utility::waittill_any( "death", "pdrone_flying_attack_drone_logic" );
    level.flying_attack_drones = common_scripts\utility::array_remove( level.flying_attack_drones, self );
    level notify( "flying_attack_drone_destroyed" );
}

_id_3DB9( var_0, var_1 )
{
    var_2 = [];
    var_3 = [];

    if ( isdefined( var_0.script_linkto ) )
        var_3 = strtok( var_0.script_linkto, " " );

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        var_5 = 0;

        if ( isdefined( var_1[var_4].script_linkname ) )
        {
            for ( var_6 = 0; var_6 < var_3.size; var_6++ )
            {
                if ( var_1[var_4].script_linkname == var_3[var_6] )
                {
                    var_2[var_2.size] = var_1[var_4];
                    var_5 = 1;
                    break;
                }
            }
        }

        if ( !var_5 && isdefined( var_1[var_4].script_linkto ) && isdefined( var_0.script_linkname ) )
        {
            var_7 = strtok( var_1[var_4].script_linkto, " " );

            for ( var_6 = 0; var_6 < var_7.size; var_6++ )
            {
                if ( var_0.script_linkname == var_7[var_6] )
                {
                    var_2[var_2.size] = var_1[var_4];
                    break;
                }
            }
        }
    }

    return var_2;
}

_id_3DE8( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    var_4 = [];

    foreach ( var_6 in var_2 )
        var_6._id_3BC1 = 0;

    var_0._id_35B2 = var_0._id_3BC1 + distance( var_0.origin, var_1.origin );

    while ( var_3.size > 0 )
    {
        var_8 = undefined;
        var_9 = 500000;

        foreach ( var_11 in var_3 )
        {
            if ( var_11._id_35B2 < var_9 )
            {
                var_8 = var_11;
                var_9 = var_11._id_35B2;
            }
        }

        if ( var_8 == var_1 )
        {
            for ( var_13 = var_1; var_13._id_1A12 != var_0; var_13 = var_13._id_1A12 )
            {

            }

            return var_13;
        }

        var_3 = common_scripts\utility::array_remove( var_3, var_8 );
        var_4[var_4.size] = var_8;
        var_14 = _id_3DB9( var_8, var_2 );

        foreach ( var_11 in var_14 )
        {
            var_16 = var_8._id_3BC1 + distance( var_8.origin, var_11.origin );

            if ( common_scripts\utility::array_contains( var_4, var_11 ) && var_16 >= var_11._id_3BC1 )
                continue;

            var_17 = common_scripts\utility::array_contains( var_3, var_11 );

            if ( !var_17 || var_16 < var_11._id_3BC1 )
            {
                var_11._id_1A12 = var_8;
                var_11._id_3BC1 = var_16;
                var_11._id_35B2 = var_11._id_3BC1 + distance( var_11.origin, var_1.origin );

                if ( !var_17 )
                    var_3[var_3.size] = var_11;
            }
        }
    }

    return undefined;
}

_id_846C()
{
    return self.classname == "script_vehicle_pdrone_kva" || self.classname == "script_vehicle_pdrone_atlas_large";
}

#using_animtree("vehicles");

_id_8251()
{
    switch ( self.classname )
    {
        case "script_vehicle_pdrone_kva":
            level._id_78A9["personal_drone"]["idle"][0] = %hms_greece_pdrone_idle_01;
            level._id_78A9["personal_drone"]["idle"][1] = %hms_greece_pdrone_idle_02;
            level._id_78A9["personal_drone"]["hit_reaction"][0] = %hms_greece_pdrone_hitreaction_01;
            level._id_78A9["personal_drone"]["hit_reaction"][1] = %hms_greece_pdrone_hitreaction_02;
            level._id_78A9["personal_drone"]["hit_reaction"][2] = %hms_greece_pdrone_hitreaction_03;
            level._id_78A9["personal_drone"]["reload"][1] = %hms_greece_pdrone_reload_01;
            break;
        case "script_vehicle_pdrone_atlas_large":
            level._id_78A9["personal_drone"]["idle"][0] = %atlas_assault_drone_idle_01;
            level._id_78A9["personal_drone"]["idle"][1] = %atlas_assault_drone_idle_02;
            level._id_78A9["personal_drone"]["hit_reaction"][0] = %atlas_assault_drone_hitreaction_01;
            level._id_78A9["personal_drone"]["hit_reaction"][1] = %atlas_assault_drone_hitreaction_02;
            level._id_78A9["personal_drone"]["hit_reaction"][2] = %atlas_assault_drone_hitreaction_03;
            break;
        default:
            break;
    }
}

_id_695C()
{
    if ( !isdefined( level._id_78A9["personal_drone"]["hit_reaction"] ) )
        return;

    self _meth_8115( level._id_78AE["personal_drone"] );
    var_0 = randomint( level._id_78A9["personal_drone"]["hit_reaction"].size );
    var_1 = getanimlength( level._id_78A9["personal_drone"]["hit_reaction"][var_0] );
    self _meth_8145( level._id_78A9["personal_drone"]["hit_reaction"][var_0] );
    self._id_6DAD = 1;
    wait(var_1);

    if ( !isdefined( self ) || !isalive( self ) )
        return;

    self._id_6DAD = 0;
}

_id_4B64()
{
    self endon( "death" );
    self _meth_8115( level._id_78AE["personal_drone"] );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        wait 0.05;

        if ( !var_0 && !self._id_6DAD )
        {
            var_2 = randomint( level._id_78A9["personal_drone"]["idle"].size );
            var_1 = getanimlength( level._id_78A9["personal_drone"]["idle"][var_2] );
            self _meth_8143( level._id_78A9["personal_drone"]["idle"][var_2] );
            var_0 = 1;
        }
        else if ( self._id_6DAD || var_1 <= 0 )
            var_0 = 0;

        var_1 -= 0.05;
    }
}

_id_3929()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "stun_drone" );
        _id_8F6C();
    }
}

_id_8F6C()
{
    self._id_8F6D = 2;

    if ( self._id_6DAD )
        return;

    thread _id_695C();
}
