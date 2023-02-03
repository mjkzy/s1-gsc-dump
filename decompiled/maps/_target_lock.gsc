// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.target_lock_targets = [];
}

register_target_lock_change_func( var_0 )
{
    level.target_lock_change_func = var_0;
}

add_lock_target( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    target_set( var_0 );

    if ( isdefined( level.target_lock_change_func ) )
        self [[ level.target_lock_change_func ]]( "Added", var_0 );

    level.target_lock_targets = common_scripts\utility::array_add( level.target_lock_targets, var_0 );
    level thread remove_from_targets_on_death( var_0 );
}

remove_lock_target( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( level.target_lock_change_func ) )
        self [[ level.target_lock_change_func ]]( "Removed", var_0 );

    level.target_lock_targets = common_scripts\utility::array_remove( level.target_lock_targets, var_0 );
}

get_best_lock_target( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level.target_lock_targets )
    {
        if ( is_viable_lock_target( var_4, var_0, var_1 ) )
            var_2[var_2.size] = var_4;
    }

    var_6 = bullettrace( self geteye(), self geteye() + anglestoforward( self getangles() ) * 100000, 1, self );
    var_2 = sortbydistance( var_2, var_6["position"] );

    if ( !var_2.size )
        return undefined;

    return var_2[0];
}

is_viable_lock_target( var_0, var_1, var_2 )
{
    if ( !target_istarget( var_0 ) )
        return 0;

    var_3 = target_isinrect( var_0, self, get_fov_for_player( self ), var_1, var_1 );

    if ( !var_3 )
        return 0;

    var_4 = bullettrace( self geteye(), var_0.origin, 0, var_0 );
    return bullettracepassed( self geteye(), var_0.origin, 0, var_0 );
}

remove_from_targets_on_death( var_0 )
{
    var_0 waittill( "death" );
    level remove_lock_target( var_0 );
}

get_fov_for_player( var_0 )
{
    var_1 = getdvarint( "cg_fov" );
    var_2 = getdvarfloat( "cg_playerFovScale0" );

    if ( isdefined( level.player2 ) && var_0 == level.player2 )
        var_2 = getdvarfloat( "cg_playerFovScale1" );

    return var_1 * var_2;
}
