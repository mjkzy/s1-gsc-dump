// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_smart_grenade()
{
    precache_var_grenade_fx();
}

monitorsmartgrenade( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 waittill( "grenade_fire", var_1, var_2 );

        if ( issubstr( var_2, "smart" ) )
            var_1 thread tracking_grenade_think( var_0 );
    }
}

precache_var_grenade_fx()
{

}

tracking_grenade_think( var_0 )
{
    var_1 = 40;
    var_2 = 20;
    var_3 = 195;
    var_4 = 1.5;
    var_5 = 2;
    var_6 = 0.35;
    var_7 = 88.0;
    var_8 = 7;
    var_9 = 1056.0;
    var_10 = 2;
    var_11 = 0.05;
    var_12 = ( 0, 0, -300 * var_11 );
    var_13 = 3000 * var_11;
    var_14 = 600 * var_11;
    var_15 = 0.2;
    var_16 = 0.6;
    var_17 = 2;
    var_18 = sin( 2 );
    var_19 = 0.05;
    var_20 = make_tracking_grenade( self );
    var_20 thread tracking_grenade_handle_damage( var_0 );
    var_21 = common_scripts\utility::spawn_tag_origin();
    var_21 _meth_804D( var_20, "", ( 0, 0, 0 ), ( -90, 0, 0 ) );
    var_22 = var_0 _meth_80A8();
    var_23 = anglestoforward( var_0.angles );
    var_24 = bullettrace( var_22, var_22 + var_23 * 7000, 0, var_20 );
    var_25 = var_24["position"];
    var_26 = var_20 tracking_grenade_get_target( var_0 );
    var_27 = ( var_23 + ( 0, 0, 0.2 ) ) * 50 * 17.6;
    var_28 = ( 0, 0, 0 );
    var_26 = undefined;
    var_29 = ( 0, 0, 0 );
    var_30 = ( 0, 0, 0 );
    var_31 = 0;

    for ( var_32 = 0; var_32 < var_8; var_32 += 0.05 )
    {
        if ( !isalive( var_26 ) )
            var_26 = var_20 tracking_grenade_get_target( var_0 );

        if ( var_32 > var_5 && !var_31 )
        {
            var_33 = var_20 tracking_grenade_get_target( var_0 );

            if ( isdefined( var_33 ) )
            {
                var_31 = 1;
                var_26 = var_33;
                tracking_grenade_scare_enemies( var_26.origin );
            }
        }

        if ( var_32 > var_5 )
        {
            if ( isdefined( var_26 ) )
                var_25 = var_26.origin + var_26 get_npc_center_offset();
        }
        else
        {
            var_22 = var_0 _meth_80A8();
            var_23 = anglestoforward( var_0.angles );
            var_24 = bullettrace( var_22, var_22 + var_23 * 7000, 0, var_20 );
            var_34 = var_24["position"];

            if ( distancesquared( var_34, var_0.origin ) > distancesquared( var_20.origin, var_0.origin ) )
                var_25 = var_34;
        }

        if ( vectordot( var_25 - var_20.origin, var_25 - var_0.origin ) < 0 )
            break;

        if ( var_32 > var_5 )
        {
            var_35 = linear_map_clamp( var_32 - var_5 - var_6, 0, var_10, 0, var_9 );
            var_28 = vectornormalize( var_25 - var_20.origin ) * var_35;

            if ( var_32 < var_5 + var_6 )
                var_28 = ( 0, 0, var_7 );
        }
        else
        {
            var_22 = var_0 _meth_80A8();
            var_36 = var_0.angles;
            var_23 = anglestoforward( var_36 );
            var_37 = anglestoright( var_36 );
            var_38 = -1 * common_scripts\utility::sign( vectordot( var_22 - var_20.origin, var_37 ) );
            var_39 = var_22 + var_23 * var_3 + ( 0, 0, var_1 ) + var_37 * ( var_38 * var_2 );
            var_40 = var_39 - var_20.origin;
            var_28 = var_40 * var_4;
        }

        var_41 = _func_284( ( var_28 - var_27 ) * var_16 - var_12, var_13 );
        var_41 = vectorlerp( var_41, var_29, var_15 );
        var_30 += var_41;
        var_30 += common_scripts\utility::randomvector( var_19 * length( var_30 ) );
        var_42 = length( var_30 );

        if ( var_42 > 0 )
        {
            var_43 = anglestoup( var_20.angles );
            var_20.angles = combineangles( vectortoangles( var_30 ), ( 90, 0, 0 ) );
            var_44 = vectornormalize( var_30 );
            var_45 = vectorcross( var_44, var_43 );
            var_46 = vectorcross( var_44, var_45 );
            var_47 = length( var_46 );

            if ( var_47 > var_18 )
            {
                var_20 tracking_grenade_thrust_effect( var_46, "tracking_grenade_spray_small", var_44 * var_17 );

                if ( var_47 > 2 * var_18 )
                    var_20 tracking_grenade_thrust_effect( -1 * var_46, "tracking_grenade_spray_small", var_44 * ( var_17 * -1 ) );
            }

            if ( var_42 > var_14 )
            {
                foreach ( var_49 in level.players )
                    playfxontagforclients( common_scripts\utility::getfx( "tracking_grenade_spray_large" ), var_20, "tag_fx", var_49 );

                var_30 = ( 0, 0, 0 );
                var_27 += _func_284( var_41, var_13, var_14 );
            }

            var_27 += var_12;
        }

        var_30 = ( 0, 0, 0 );
        var_51 = var_20.origin + var_27 * 0.05;
        var_52 = bullettrace( var_20.origin, var_51, 1, var_0 );

        if ( var_52["fraction"] < 1 )
            break;

        var_20.origin = var_51;
        var_29 = var_41;

        if ( var_32 == var_5 )
        {

        }
        else if ( var_32 == var_5 + var_6 )
        {

        }

        wait 0.05;
    }

    var_20 tracking_grenade_detonate( var_0, var_27 );
    var_21 delete();
}

tracking_grenade_detonate( var_0, var_1 )
{
    var_2 = 300;

    if ( distance( var_0.origin, self.origin ) > var_2 )
    {
        _func_071( "frag_grenade_mp", self.origin, var_1, 0.05, var_0 );
        self delete();
    }
    else
    {
        self _meth_8276( self.origin, var_1 * 0.1 );
        common_scripts\utility::delaycall( 3, ::delete );
    }
}

tracking_grenade_handle_damage( var_0 )
{
    self endon( "death" );
    self _meth_8139( var_0.team, 1 );
    self waittill( "damage" );
    tracking_grenade_detonate();
}

tracking_grenade_scare_enemies( var_0 )
{
    badplace_cylinder( "", 4, var_0 + ( 0, 0, -64 ), 117, 128, "all" );
}

tracking_grenade_get_target( var_0 )
{
    var_1 = var_0 _meth_80A8();
    var_2 = anglestoforward( var_0.angles );
    var_3 = cos( 20 );
    var_4 = undefined;
    var_5 = [];

    foreach ( var_7 in level.agentarray )
    {
        if ( var_7.team == "axis" )
            var_5[var_5.size] = var_7;
    }

    foreach ( var_10 in var_5 )
    {
        var_11 = var_10 _meth_80A8();
        var_12 = vectordot( vectornormalize( var_11 - var_1 ), var_2 );

        if ( var_12 <= var_3 )
            continue;

        if ( distancesquared( var_11, var_1 ) < distancesquared( self.origin, var_1 ) )
            continue;

        if ( !sighttracepassed( self.origin, var_11, 0, self ) )
            continue;

        if ( isdefined( var_4 ) && !sighttracepassed( self.origin, var_11, 0, self, var_0 ) )
            continue;

        var_3 = var_12;
        var_4 = var_10;
    }

    return var_4;
}

tracking_grenade_thrust_effect( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::spawn_tag_origin();

    if ( isdefined( var_2 ) )
        var_3.origin += var_2;

    var_3.angles = vectortoangles( var_0 );
    var_3 _meth_804D( self );

    foreach ( var_5 in level.players )
        playfxontagforclients( common_scripts\utility::getfx( var_1 ), self, "tag_fx", var_5 );

    var_3 common_scripts\utility::delaycall( 0.3, ::delete );
}

make_tracking_grenade( var_0 )
{
    var_1 = var_0.origin;
    var_0 delete();
    var_2 = spawn( "script_model", var_1 );
    var_2 _meth_80B1( "npc_variable_grenade_lethal" );
    return var_2;
}

get_npc_center_offset()
{
    if ( isai( self ) && isalive( self ) )
    {
        var_0 = self _meth_80A8()[2];
        var_1 = self.origin[2];
        var_2 = var_0 - var_1;
        return ( 0, 0, var_2 );
    }
    else
        return ( 0, 0, 0 );
}

linear_map_clamp( var_0, var_1, var_2, var_3, var_4 )
{
    return clamp( linear_map( var_0, var_1, var_2, var_3, var_4 ), min( var_3, var_4 ), max( var_3, var_4 ) );
}

linear_map( var_0, var_1, var_2, var_3, var_4 )
{
    return var_3 + ( var_0 - var_1 ) * ( var_4 - var_3 ) / ( var_2 - var_1 );
}
