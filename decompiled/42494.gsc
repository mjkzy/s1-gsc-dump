// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    precachemodel( var_0 );

    if ( level.currentgen )
        precachemodel( "vehicle_mil_attack_drone_static_multi_cg" );

    maps\_utility::set_console_status();
    level._effect["queen_drone_beacon_red"] = loadfx( "vfx/lights/light_drone_beacon_red_single" );
    level._effect["droneswarm_tread"] = loadfx( "vfx/treadfx/droneswarm_tread_dust" );
    level._effect["droneswarm_tread_water"] = loadfx( "vfx/treadfx/droneswarm_tread_water" );
    maps\_vehicle::build_template( "attack_drone_queen", var_0, var_1, var_2 );
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
    thread vehicle_scripts\_attack_drone_aud::attack_drone_queen_audio();
    thread attack_drone_queen_flying_fx();
    self hide();
    self _meth_83F3();
}

attack_drone_queen_flying_fx()
{
    var_0 = 0.15;
    var_1 = squared( 975 );
    var_2 = ( 0, 0, -195 );
    var_3 = 0.2;
    var_4 = anglestoforward( self.angles + ( -90, 0, 0 ) );
    var_5 = anglestoup( self.angles + ( -90, 0, 0 ) );
    self endon( "death" );

    if ( randomfloat( 1 ) > var_0 )
        return;

    wait(randomfloat( var_3 ));

    for (;;)
    {
        if ( distancesquared( self.origin, level.player.origin ) < var_1 )
        {
            var_6 = bullettrace( self.origin, self.origin + var_2, 0 );

            if ( var_6["fraction"] < 1 )
            {
                if ( var_6["surfacetype"] != "water_waist" )
                    playfx( common_scripts\utility::getfx( "droneswarm_tread" ), var_6["position"], var_4, var_5 );
                else
                    playfx( common_scripts\utility::getfx( "droneswarm_tread_water" ), var_6["position"], var_4, var_5 );
            }
        }

        wait(var_3);
    }
}
