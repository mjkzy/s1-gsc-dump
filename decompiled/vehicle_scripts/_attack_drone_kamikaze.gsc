// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    precachemodel( var_0 );
    maps\_utility::set_console_status();
    level._effect["pdrone_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["pdrone_large_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_large_explosion" );
    level._effect["kamikaze_drone_beacon_attack"] = loadfx( "vfx/lights/light_drone_beacon_attack" );
    maps\_vehicle::build_template( "attack_drone_kamikaze", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathquake( 0.4, 0.8, 1024 );
    maps\_vehicle::build_life( 499 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_is_helicopter();
}

init_local()
{
    self.script_cheap = 1;
    self.script_badplace = 0;
    self.dontdisconnectpaths = 1;
    self.contents = self setcontents( 0 );
    self.ignore_death_fx = 1;
    self.delete_on_death = 1;
    thread vehicle_scripts\_attack_drone_aud::attack_drone_kamikaze_audio();
    thread attack_drone_kamikaze_flying_fx();

    if ( isdefined( self.script_parameters ) && self.script_parameters == "diveboat_weapon_target" )
    {
        self.contents = self setcontents( self.contents );
        self.custom_death_script = ::handle_death;
        target_set( self, ( 0, 0, 0 ) );
        target_hidefromplayer( self, level.player );
    }
}

attack_drone_kamikaze_flying_fx()
{
    playfxontag( common_scripts\utility::getfx( "kamikaze_drone_beacon_attack" ), self, "tag_origin" );
}

handle_death()
{
    if ( !isdefined( self ) )
        return;

    self.crashing = 1;

    if ( self.script_team != "allies" && !isdefined( self.owner ) && isdefined( self.last_damage_attacker ) && randomfloat( 1 ) < 0.33 )
    {
        if ( randomfloat( 1 ) < 0.5 )
            death_crash_nearby_player( self.last_damage_attacker );
        else
            thread death_spiral( self.last_damage_attacker );
    }
    else
        play_death_explosion_fx();

    if ( isdefined( self ) )
    {
        self notify( "crash_done" );
        self delete();
    }
}

play_death_explosion_fx()
{
    if ( self.classname == "script_vehicle_pdrone_atlas_large" )
    {
        playfx( common_scripts\utility::getfx( "pdrone_large_death_explosion" ), self gettagorigin( "tag_origin" ) );
        soundscripts\_snd::snd_message( "pdrone_death_explode" );
    }
    else
    {
        playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), self gettagorigin( "tag_origin" ) );
        soundscripts\_snd::snd_message( "pdrone_death_explode" );
    }
}

death_spiral( var_0 )
{
    var_1 = spawn( "script_model", self.origin );
    var_1.angles = self.angles;

    if ( isdefined( self.death_model_override ) )
        var_1 setmodel( self.death_model_override );
    else
        var_1 setmodel( self.model );

    self hide();
    stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_1, "TAG_ORIGIN" );
    soundscripts\_snd::snd_message( "pdrone_emp_death", var_1 );
    var_2 = ( self.origin[0], self.origin[1], self.origin[2] - 500 );
    var_3 = physicstrace( self.origin, var_2 );
    var_4 = 0;
    var_5 = 5;
    var_6 = var_0.origin - var_1.origin;
    var_6 = vectornormalize( var_6 );
    var_7 = vectorcross( ( 0, 0, 1 ), var_6 );
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
        var_10 += ( 0, 10, 0 ) * var_11;
        var_12 = maps\_utility::linear_interpolate( clamp( var_4 / 3, 0, 1 ), 2, 30 );
        var_9 -= ( 0, 0, var_12 );
        var_13 = var_9 + anglestoforward( var_10 ) * var_8;
        var_14 = physicstrace( var_1.origin, var_13, var_1 );
        var_1.origin = var_13;
        var_1.angles += ( 0, 50, 0 ) * var_11;
        var_15 = length( var_3 - var_1.origin );

        if ( var_15 < 60 || var_1.origin[2] < var_3[2] + 15 || var_14 != var_13 )
            break;
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_1.origin );
    soundscripts\_snd::snd_message( "pdrone_crash_land", var_1.origin );
    var_1 delete();
}

death_crash_nearby_player( var_0 )
{
    self.vehicle_stays_alive = 1;
    var_1 = var_0.origin - self.origin;
    var_1 = vectornormalize( var_1 );
    var_2 = vectorcross( ( 0, 0, 1 ), var_1 );
    var_2 = vectornormalize( var_2 );

    if ( common_scripts\utility::cointoss() )
        var_2 *= -1;

    var_3 = var_0.origin - var_1 * ( 1, 1, 0 ) * 250 + var_2 * 250;
    var_3 = ( var_3[0], var_3[1], self.origin[2] );
    var_4 = common_scripts\utility::randomvectorincone( vectornormalize( var_3 - self.origin ), 15 );
    var_5 = self.origin + var_4 * 250;
    var_3 = physicstrace( self.origin, var_5 );
    self notify( "newpath" );
    self notify( "deathspin" );
    self setneargoalnotifydist( 60 );
    self vehicle_helisetai( var_3, drone_parm( "speed" ) * 0.75, drone_parm( "accel" ), drone_parm( "decel" ), undefined, undefined, 0, 0, 0, 0, 0, 0, 0 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    death_plummet();
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
}

death_plummet()
{
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 setmodel( self.model );
    self hide();

    if ( !issubstr( self.classname, "_security" ) )
        stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );

    var_1 = 0;
    var_2 = self vehicle_getvelocity();
    var_3 = squared( 0.05 );

    for ( var_4 = ( 0, 0, -980 ); var_1 < 5; var_1 += 0.05 )
    {
        wait 0.05;
        var_2 = var_4 * 0.05 + var_2;
        var_2 = vectorclamp( var_2, 1000 );
        var_5 = var_2 * 0.05 + var_4 * var_3 / 2;
        var_6 = var_0.origin + var_5;
        var_7 = physicstrace( var_0.origin, var_6, var_0 );

        if ( var_7 != var_6 )
            break;

        var_0.origin = var_6;
        var_0.angles += ( 0, 5, 0 );
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_0.origin );
    soundscripts\_snd::snd_message( "pdrone_crash_land", var_0.origin );
    var_0 delete();
}

drone_parm( var_0 )
{
    return level.pdrone_parms[self.classname][var_0];
}
