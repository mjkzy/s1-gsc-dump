// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    var_0 = [];
    var_1 = undefined;
    var_2 = undefined;
    var_3 = randomfloat( 100.0 );
    var_4 = undefined;

    if ( var_3 < 33.0 )
        var_4 = "a";
    else if ( var_3 < 66.0 )
        var_4 = "b";
    else if ( var_3 < 100.0 )
        var_4 = "c";

    if ( var_4 == "a" )
    {
        var_0["traverseAnim"] = %seo_jumpdown_assist_start_jump_a;
        var_1 = %seo_jumpdown_assist_falling_idle_a;
    }
    else if ( var_4 == "b" )
    {
        var_0["traverseAnim"] = %seo_jumpdown_assist_start_jump_b;
        var_1 = %seo_jumpdown_assist_falling_idle_b;
    }
    else if ( var_4 == "c" )
    {
        var_0["traverseAnim"] = %seo_jumpdown_assist_start_jump_c;
        var_1 = %seo_jumpdown_assist_falling_idle_c;
    }

    var_0["traverseNotetrackFunc"] = animscripts\traverse\boost::handletraversenotetrackslandassist;
    var_5 = get_post_landing_dir( self.node );
    var_6 = undefined;

    if ( var_5 == 1 )
        var_6 = %seo_jumpdown_assist_landing_1;
    else if ( var_5 == 2 )
        var_6 = %seo_jumpdown_assist_landing_2;
    else if ( var_5 == 3 )
        var_6 = %seo_jumpdown_assist_landing_3;
    else if ( var_5 == 4 )
        var_6 = %seo_jumpdown_assist_landing_4;
    else if ( var_5 == 6 )
        var_6 = %seo_jumpdown_assist_landing_6;
    else if ( var_5 == 7 )
        var_6 = %seo_jumpdown_assist_landing_7;
    else if ( var_5 == 8 )
        var_6 = %seo_jumpdown_assist_landing_8;
    else if ( var_5 == 9 )
        var_6 = %seo_jumpdown_assist_landing_9;

    var_7 = 0.0;

    if ( isdefined( var_6 ) )
        var_7 = getmovedelta( var_6, 0.0, 1.0 )[2];

    animscripts\traverse\shared::dotraverse( var_0 );
    var_8 = self.origin + ( 0, 0, 32 );

    if ( isdefined( self getnegotiationendnode() ) )
        var_2 = ( var_8[0], var_8[1], self getnegotiationendnode().origin[2] );
    else
        var_2 = physicstrace( var_8, self.origin + ( 0, 0, -5120 ) );

    var_9 = distance( var_8, var_2 );
    var_10 = var_9 - 32 - 0.5 + var_7;
    play_loop_until_drop_distance( var_1, var_10, var_7 );
    self setflaggedanimknoballrestart( "traverse_align", var_6, %body, 1, 0.2, 1 );
    animscripts\shared::donotetracks( "traverse_align", animscripts\traverse\boost::handletraversenotetrackslandassist );
}

play_loop_until_drop_distance( var_0, var_1, var_2 )
{
    var_3 = self.origin[2];
    var_4 = animscripts\utility::get_trajectory_time_given_x( 0.0, var_1, self.velocity[2], getdvarfloat( "g_gravity" ) );
    self setflaggedanimknoballrestart( "idle", var_0, %body, 1, 0.1, 1 );
    self animmode( "gravity_noclip" );
    var_5 = -1.0;
    var_6 = 0;

    while ( var_5 <= var_1 )
    {
        var_5 = var_3 - self.origin[2];
        var_6 += 0.05;
        var_7 = animscripts\utility::get_trajectory_x_given_time( 0.0, self.velocity[2], -1.0 * getdvarfloat( "g_gravity" ), 0.05 );

        if ( var_7 < var_5 - var_1 )
            self animmode( "gravity" );

        if ( var_6 > var_4 + 1.0 )
        {
            self forceteleport( self getnegotiationendnode().origin + ( 0, 0, var_2 ) );
            break;
        }

        wait 0.05;
    }

    self clearanim( var_0, 0.2 );
}

get_post_landing_dir( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;

    if ( !isdefined( var_1 ) )
    {
        var_2 = self getnegotiationendnode().origin;
        var_3 = self getnegotiationnextnode();
    }
    else
    {
        var_2 = var_1;
        var_4 = getnodesonpath( var_2, var_0.origin, 1, undefined, var_0 );
        var_3 = undefined;

        foreach ( var_3 in var_4 )
        {
            if ( var_3.type != "End" && ( isdefined( var_3.radius ) && distance2d( var_1, var_3.origin ) > var_3.radius || !isdefined( var_3.radius ) && distance2d( var_1, var_3.origin ) > self.goalradius ) )
                break;
        }
    }

    if ( !isdefined( var_3 ) || !isdefined( var_3 ) )
        return 5;

    var_7 = self.angles[1];
    var_8 = "exposed";
    var_9 = var_2 - var_3.origin;
    var_9 = ( var_9[0], var_9[1], 0.0 );
    var_10 = 9;
    var_11 = -1;
    var_12 = spawnstruct();
    animscripts\exit_node::calculatenodetransitionangles( var_12, var_8, 1, var_7, var_9, var_10, var_11 );
    animscripts\exit_node::sortnodetransitionangles( var_12, var_10 );
    return var_12.transindex[1];
}

find_landing_node_along_path( var_0 )
{
    var_1 = getnodesonpath( self.origin, var_0.origin );
    var_2 = undefined;
    var_3 = undefined;

    foreach ( var_5 in var_1 )
    {
        if ( !isdefined( var_2 ) )
        {
            if ( isdefined( var_5.animscript ) && var_5.animscript == "seoul_jump_landassist" )
                var_2 = var_5;

            continue;
        }

        var_3 = var_5;
        break;
    }

    return [ var_2, var_3 ];
}
