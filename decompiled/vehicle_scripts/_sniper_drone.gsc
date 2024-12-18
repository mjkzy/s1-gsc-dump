// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    precachemodel( var_0 );
    level._effect["drone_fan_distortion"] = loadfx( "vfx/distortion/sniper_drone_runner" );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/heli_dust_default" );
    maps\_vehicle::build_template( "sniper_drone", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_life( 499 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_is_helicopter();
}

set_vehicle_anims( var_0 )
{
    return var_0;
}

set_ai_anims()
{
    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].sittag = "tag_player";
    var_0[0].bhasgunwhileriding = 1;
    return var_0;
}

init_local()
{
    thread pdrone_flying_fx();
    thread start_sniper_drone_audio();
}

pdrone_flying_fx()
{
    self endon( "death" );

    if ( self.classname == "script_vehicle_sniper_drone" )
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion" ), self, "TAG_ORIGIN" );
}

start_sniper_drone_audio()
{
    var_0 = spawnstruct();
    var_0.preset_name = "sniper_drone";
    var_1 = vehicle_scripts\_sniper_drone_aud::snd_sniper_drone_constructor;
    soundscripts\_snd::snd_message( "snd_register_vehicle", var_0.preset_name, var_1 );
    soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );
}
