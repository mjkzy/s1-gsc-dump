// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

build_threat_data()
{
    var_0 = spawnstruct();
    var_0.threat = undefined;
    var_0.threat_visible_time = 0;
    self.drone_threat_data = var_0;
}

pdrone_update_threat_sensor()
{
    self notify( "pdrone_update_threat_sensor" );
    self endon( "pdrone_update_threat_sensor" );
    self endon( "death" );
    self endon( "emp_death" );
    var_0 = "allies";

    if ( self.script_team == "allies" )
        var_0 = "axis";

    for (;;)
    {
        wait 0.05;

        if ( maps\_utility::ent_flag( "fire_disabled" ) || isdefined( self.pacifist ) && self.pacifist || isdefined( self.ignoreall ) && self.ignoreall )
        {
            self.drone_threat_data.threat = undefined;
            continue;
        }

        if ( isdefined( self.favoriteenemy ) )
        {
            self.drone_threat_data.threat = self.favoriteenemy;
            continue;
        }

        var_1 = _func_0D6( var_0 );

        if ( self.script_team == "axis" )
            var_1 = common_scripts\utility::array_add( var_1, level.player );

        var_2 = undefined;
        var_3 = -1;

        foreach ( var_5 in var_1 )
        {
            wait 0.05;
            var_6 = calculate_threat_level( self.drone_threat_data, var_5 );

            if ( var_6 > var_3 )
            {
                var_3 = var_6;
                var_2 = var_5;
            }
        }

        self.drone_threat_data.threat = var_2;
    }
}

calculate_threat_level( var_0, var_1 )
{
    var_2 = 0;
    var_3[0] = ::evaluate_threat_valid_threat;
    var_3[1] = ::evaluate_threat_range;
    var_3[2] = ::evaluate_threat_player;
    var_3[3] = ::evaluate_threat_avoid_friendly_fire;
    var_3[4] = ::evaluate_threat_los;

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        var_5 = self [[ var_3[var_4] ]]( var_1 );

        if ( var_5 < 0 )
            return -1;

        var_2 += var_5;
    }

    return var_2 / var_3.size;
}

evaluate_threat_valid_threat( var_0 )
{
    if ( !isdefined( var_0 ) || !isalive( var_0 ) )
        return -1;

    if ( isdefined( var_0.ignoreme ) && var_0.ignoreme == 1 )
        return -1;

    return 1;
}

evaluate_threat_los( var_0 )
{
    if ( self.script_team == "allies" )
        return 1;

    var_1 = self.origin;

    if ( self _meth_8442( "tag_flash" ) != -1 )
        var_1 = self gettagorigin( "tag_flash" );

    if ( trace_to_enemy( var_1, var_0, undefined ) )
    {
        if ( var_0 == level.player )
            self.drone_threat_data.threat_visible_time += 0.05;

        return 1;
    }

    if ( var_0 == level.player )
        self.drone_threat_data.threat_visible_time = 0;

    return -1;
}

evaluate_threat_range( var_0 )
{
    var_1 = length( var_0.origin - self.origin );
    var_2 = max( 1 - var_1 / 3000, 0 );
    return var_2;
}

evaluate_threat_player( var_0 )
{
    if ( !isplayer( var_0 ) )
        return 0.8;

    return 1;
}

evaluate_threat_avoid_friendly_fire( var_0 )
{
    if ( self.script_team == "axis" )
        return 1;

    if ( maps\_utility::shot_endangers_any_player( self.origin, var_0.origin ) )
        return -1;

    return 1;
}

trace_to_enemy( var_0, var_1, var_2 )
{
    var_3 = bullettrace( var_0, var_1 _meth_80A8(), 0, var_2, 0, 0, 0, 0, 0 );

    if ( isdefined( var_3["entity"] ) && var_3["entity"] maps\_vehicle::isvehicle() )
    {
        if ( isdefined( var_3["entity"].vehicletype ) && var_3["entity"].vehicletype == "pdrone" )
            return 1;

        var_4 = var_3["entity"] _meth_8257();

        if ( isdefined( var_4 ) && var_4 == var_1 )
            return 1;
    }

    return var_3["fraction"] == 1;
}
