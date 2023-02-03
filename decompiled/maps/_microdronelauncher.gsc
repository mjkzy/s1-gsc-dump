// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    precacheshellshock( "iw5_microdronelauncher_sp" );

    foreach ( var_1 in level.players )
        var_1 thread monitor_microdrone_launch();
}

monitor_microdrone_launch()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( issubstr( var_1, "microdronelauncher" ) )
        {
            if ( issubstr( var_1, "smartgrenade" ) )
            {
                var_0 thread maps\_variable_grenade::tracking_grenade_think( self );
                continue;
            }

            var_0 thread microdrone_think( self );
        }
    }
}

microdrone_think( var_0 )
{
    self endon( "death" );
    var_1 = self.origin;
    maps\_shg_utility::get_differentiated_velocity();
    wait 0.05;
    maps\_shg_utility::get_differentiated_velocity();
    wait 0.05;
    var_2 = 0.1;
    var_3 = maps\_shg_utility::get_differentiated_velocity();

    for (;;)
    {
        var_4 = maps\_shg_utility::get_differentiated_velocity();
        var_5 = 0;

        if ( var_2 >= 0.35 )
        {
            var_6 = microdrone_get_best_target( var_1, vectornormalize( var_3 ), var_4, var_0 );

            if ( isdefined( var_6 ) )
            {
                self missile_settargetpos( microdrone_get_target_pos( var_6 ) );
                var_5 = 1;
                var_3 = var_4;
            }
        }
        else
        {

        }

        if ( !var_5 )
        {
            var_7 = vectornormalize( var_3 + ( 0, 0, -400.0 * squared( var_2 ) ) );
            self missile_settargetpos( self.origin + var_7 * 10000 );
        }

        wait 0.05;
        var_2 += 0.05;
    }
}

microdrone_get_best_target( var_0, var_1, var_2, var_3 )
{
    var_4 = cos( 15 );
    var_5 = undefined;
    var_6 = cos( 15 );

    foreach ( var_8 in common_scripts\utility::array_combine( getaiarray( "axis" ), vehicle_getarray() ) )
    {
        if ( is_enemy_target( var_8, var_3 ) && !isdefined( var_8.pretending_to_be_dead ) )
        {
            var_9 = microdrone_get_target_pos( var_8 );
            var_10 = vectordot( vectornormalize( var_2 ), vectornormalize( var_9 - self.origin ) );

            if ( var_10 > var_6 )
            {
                if ( bullettracepassed( self.origin, var_9, 0, var_8 ) )
                {
                    var_5 = var_8;
                    var_6 = var_10;
                }
                else
                {

                }
            }
        }
    }

    return var_5;
}

is_enemy_target( var_0, var_1 )
{
    var_2 = undefined;

    if ( isai( var_0 ) )
        var_2 = var_0.team;
    else if ( isdefined( var_0.script_team ) )
        var_2 = var_0.script_team;

    return isenemyteam( var_2, var_1.team );
}

microdrone_get_target_pos( var_0 )
{
    return var_0 getshootatpos();
}
