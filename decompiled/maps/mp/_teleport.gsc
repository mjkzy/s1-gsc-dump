// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    thread _id_5903();
}

_id_5903()
{
    var_0 = common_scripts\utility::getstructarray( "teleport_world_origin", "targetname" );
    var_1 = level.gametype;

    if ( !var_0.size || !( var_1 == "dom" || var_1 == "ctf" || var_1 == "hp" || var_1 == "ball" ) )
        return;

    common_scripts\utility::flag_init( "teleport_setup_complete" );
    level._id_9222 = [];
    level._id_9209 = 1;
    level._id_9248 = 0;
    level._id_9247 = 0;
    level._id_921C = 0;
    level._id_921E = 0;
    level._id_9215 = undefined;
    level._id_923A = [];
    level._id_9239 = [];
    level._id_9223 = [];
    level._id_9235 = [];
    level._id_922B = level.onstartgametype;
    level.onstartgametype = ::_id_922B;
    level._id_9255 = ::_id_9216;
    level._id_9256 = ::_id_9217;
}

_id_921F()
{
    level._id_9245 = [];
    var_0 = common_scripts\utility::getstructarray( "teleport_world_origin", "targetname" );

    if ( !var_0.size )
        return;

    level._id_9253 = [];

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            var_2.script_noteworthy = "zone_" + level._id_9253.size;

        var_2.name = var_2.script_noteworthy;
        _id_9234( var_2 );
        level._id_9223[var_2.name] = [];
        level._id_9235[var_2.name] = [];
        level._id_9253[var_2.script_noteworthy] = var_2;
    }

    var_4 = getallnodes();

    foreach ( var_6 in var_4 )
    {
        var_2 = _id_920E( var_6.origin );
        level._id_9223[var_2.name][level._id_9223[var_2.name].size] = var_6;
    }

    for ( var_8 = 0; var_8 < _func_201(); var_8++ )
    {
        var_2 = _id_920E( _func_205( var_8 ) );
        level._id_9235[var_2.name][level._id_9235[var_2.name].size] = var_8;
    }

    if ( !isdefined( level._id_9252 ) )
    {
        if ( isdefined( level._id_9253["start"] ) )
            _id_9241( "start" );
        else
        {
            foreach ( var_11, var_10 in level._id_9253 )
            {
                _id_9241( var_11 );
                break;
            }
        }
    }
}

_id_922B()
{
    _id_921F();
    var_0 = undefined;
    var_1 = undefined;

    switch ( level.gametype )
    {
        case "dom":
            var_1 = ::_id_9228;
            break;
        case "ctf":
            var_1 = ::_id_9227;
            break;
        case "hp":
            var_1 = ::_id_922A;
            break;
        case "ball":
            var_1 = ::_id_9225;
            break;
        default:
            break;
    }

    if ( isdefined( var_0 ) )
        level [[ var_0 ]]();

    level [[ level._id_922B ]]();

    if ( isdefined( var_1 ) )
        level [[ var_1 ]]();

    common_scripts\utility::flag_set( "teleport_setup_complete" );
}

_id_923D()
{
    _id_923C();
}

_id_923B()
{
    _id_923C();
}

_id_923C()
{
    foreach ( var_1 in level._id_9253 )
    {
        var_1._id_7B6A = [];
        var_1._id_7B4C = [];
        var_1._id_7B4D = [];
    }

    var_3 = getentarray( "sd_bomb_pickup_trig", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = _id_920E( var_5.origin );

        if ( isdefined( var_6 ) )
        {
            var_6._id_7B6A[var_6._id_7B6A.size] = var_5;
            _id_920D( var_5, var_6.name );
        }
    }

    var_8 = getentarray( "sd_bomb", "targetname" );

    foreach ( var_10 in var_8 )
    {
        var_6 = _id_920E( var_10.origin );

        if ( isdefined( var_6 ) )
        {
            var_6._id_7B4C[var_6._id_7B4C.size] = var_10;
            _id_920D( var_10, var_6.name );
        }
    }

    var_12 = getentarray( "bombzone", "targetname" );

    foreach ( var_14 in var_12 )
    {
        var_6 = _id_920E( var_14.origin );

        if ( isdefined( var_6 ) )
        {
            var_6._id_7B4D[var_6._id_7B4D.size] = var_14;
            _id_920D( var_14, var_6.name );
        }
    }

    var_16 = [];

    foreach ( var_1 in level._id_9253 )
    {
        if ( var_1._id_7B6A.size && var_1._id_7B6A.size && var_1._id_7B6A.size )
            var_16[var_16.size] = var_1.name;
    }

    _id_9214( var_16 );
    var_19 = level._id_9253[level._id_9252];
    _id_923E( var_19._id_7B6A );
    _id_923E( var_19._id_7B4C );
    _id_923E( var_19._id_7B4D );
}

_id_9229()
{
    foreach ( var_1 in level._id_9253 )
        var_1._id_4947 = [];

    var_3 = common_scripts\utility::getstructarray( "horde_drop", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = _id_920E( var_5.origin );

        if ( isdefined( var_6 ) )
            var_6._id_4947[var_6._id_4947.size] = var_5;
    }

    var_8 = [];

    foreach ( var_1 in level._id_9253 )
    {
        if ( var_1._id_4947.size )
            var_8[var_8.size] = var_1.name;
    }

    _id_9214( var_8 );
    var_11 = level._id_9253[level._id_9252];
    level.struct_class_names["targetname"]["horde_drop"] = var_11._id_4947;
}

_id_920D( var_0, var_1 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    if ( !isdefined( var_1 ) )
        var_1 = "hide_from_getEnt";

    foreach ( var_3 in var_0 )
    {
        var_3._id_7812 = var_3.targetname;
        var_3.targetname = var_3.targetname + "_" + var_1;
    }
}

_id_9214( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = getarraykeys( level._id_9253 );

    var_1 = game["teleport_zone_dom"];

    if ( !isdefined( var_1 ) )
    {
        var_1 = common_scripts\utility::random( var_0 );
        game["teleport_zone_dom"] = var_1;
    }

    _id_924B( var_1, 0 );
    level._id_9209 = 0;
}

_id_923E( var_0 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2._id_7812 ) )
            var_2.targetname = var_2._id_7812;
    }
}

_id_9227()
{
    level._id_9215 = ::_id_922E;
}

_id_922A()
{
    if ( !isdefined( level._id_628D ) )
        level._id_628D = 5;

    level._id_6E9D = [];
    level._id_6E6C = [];
    level.all_hp_zones = level.zones;

    foreach ( var_1 in level.zones )
    {
        if ( var_1.script_index > level._id_628D )
        {
            level._id_6E6C[level._id_6E6C.size] = var_1;
            continue;
        }

        level._id_6E9D[level._id_6E9D.size] = var_1;
    }

    level.zones = level._id_6E9D;
    level._id_9215 = ::_id_9230;
}

_id_9225()
{
    level._id_9215 = ::_id_922C;
}

_id_9228()
{
    foreach ( var_1 in level._id_9253 )
    {
        var_1.flags = [];
        var_1.domflags = [];
    }

    level._id_09E0 = level.flags;

    foreach ( var_4 in level.flags )
    {
        var_5 = _id_920E( var_4.origin );

        if ( isdefined( var_5 ) )
        {
            var_4._id_9251 = var_5.name;
            var_5.flags[var_5.flags.size] = var_4;
            var_5.domflags[var_5.domflags.size] = var_4.useobj;
        }
    }

    level._id_2CEE = [];

    foreach ( var_1 in level._id_9253 )
    {
        foreach ( var_9 in var_1.flags )
        {
            var_10 = spawnstruct();
            var_10._id_97C8 = var_9.origin;
            var_10._id_9E91 = var_9.useobj.visuals[0].origin;
            var_10.baseeffectpos = var_9.useobj.baseeffectpos;
            var_10.baseeffectforward = var_9.useobj.baseeffectforward;
            var_10.baseeffectright = var_9.useobj.baseeffectright;
            var_10._id_62CC = var_9.useobj.curorigin;
            var_10._id_62DA = [];

            foreach ( var_12 in level.teamnamelist )
            {
                var_13 = "objpoint_" + var_12 + "_" + var_9.useobj.entnum;
                var_14 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_13 );

                if ( isdefined( var_14 ) )
                    var_10._id_62DA[var_12] = ( var_14.x, var_14.y, var_14.z );
            }

            var_13 = "objpoint_mlg_" + var_9.useobj.entnum;
            var_14 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_13 );

            if ( isdefined( var_14 ) )
                var_10._id_62DA["mlg"] = ( var_14.x, var_14.y, var_14.z );

            level._id_2CEE[var_1.name][var_9.useobj.label] = var_10;
        }
    }

    level.flags = level._id_9253[level._id_9252].flags;
    level.domflags = level._id_9253[level._id_9252].domflags;

    foreach ( var_1 in level._id_9253 )
    {
        foreach ( var_4 in var_1.flags )
        {
            if ( var_1.name == level._id_9252 )
                continue;

            var_4.useobj.visuals[0] delete();
            var_4.useobj maps\mp\gametypes\_gameobjects::deleteuseobject();
        }
    }

    level._id_9215 = ::_id_922F;
    _id_922F( level._id_9252 );
    level._id_9210 = 1;
    level thread _id_9211();
}

_id_9211()
{
    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    foreach ( var_1 in level._id_9253 )
    {
        foreach ( var_3 in var_1.flags )
        {
            var_4 = level._id_2CEE[var_1.name][var_3.useobj.label];
            var_4._id_6136 = var_3._id_6136;

            if ( var_1.name != level._id_9252 )
                var_3 delete();
        }
    }
}

_id_9226()
{
    level._id_9215 = ::_id_922D;
}

_id_922F( var_0 )
{
    var_1 = level._id_9253[level._id_9252];
    var_2 = level._id_9253[var_0];

    if ( var_0 == level._id_9252 )
        return;

    foreach ( var_4 in level.domflags )
    {
        var_4 maps\mp\gametypes\_gameobjects::setownerteam( "neutral" );
        var_4 maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "waypoint_captureneutral" + var_4.label );
        var_4 maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_captureneutral" + var_4.label );
        var_4 maps\mp\gametypes\_gameobjects::set2dicon( "friendly", "waypoint_captureneutral" + var_4.label );
        var_4 maps\mp\gametypes\_gameobjects::set3dicon( "friendly", "waypoint_captureneutral" + var_4.label );
        var_4 maps\mp\gametypes\_gameobjects::set2dicon( "mlg", "waypoint_esports_dom_white" + var_4.label );
        var_4 maps\mp\gametypes\_gameobjects::set3dicon( "mlg", "waypoint_esports_dom_white" + var_4.label );
        var_4.firstcapture = 1;
    }

    foreach ( var_4 in level.flags )
    {
        var_7 = level._id_2CEE[var_0][var_4.useobj.label];
        var_4.origin = var_7._id_97C8;
        var_4.useobj.visuals[0].origin = var_7._id_9E91;
        var_4.useobj.baseeffectpos = var_7.baseeffectpos;
        var_4.useobj.baseeffectforward = var_7.baseeffectforward;
        var_4.useobj maps\mp\gametypes\dom::updatevisuals();
        var_4._id_9251 = var_0;
        var_4._id_6136 = var_7._id_6136;

        if ( isdefined( var_4.useobj.objidallies ) )
            objective_position( var_4.useobj.objidallies, var_7._id_62CC );

        if ( isdefined( var_4.useobj.objidaxis ) )
            objective_position( var_4.useobj.objidaxis, var_7._id_62CC );

        if ( isdefined( var_4.useobj.objidmlgspectator ) )
            objective_position( var_4.useobj.objidmlgspectator, var_7._id_62CC );

        foreach ( var_9 in level.teamnamelist )
        {
            var_10 = "objpoint_" + var_9 + "_" + var_4.useobj.entnum;
            var_11 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_10 );
            var_11.x = var_7._id_62DA[var_9][0];
            var_11.y = var_7._id_62DA[var_9][1];
            var_11.z = var_7._id_62DA[var_9][2];
        }

        var_10 = "objpoint_mlg_" + var_4.useobj.entnum;
        var_11 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_10 );
        var_11.x = var_7._id_62DA["mlg"][0];
        var_11.y = var_7._id_62DA["mlg"][1];
        var_11.z = var_7._id_62DA["mlg"][2];
    }

    maps\mp\gametypes\dom::flagsetup();

    foreach ( var_15 in level.domflags )
    {
        var_16 = var_15.label;

        foreach ( var_18 in level._id_9253["start"].domflags )
        {
            if ( var_18.label == var_16 )
                var_15.levelflag = var_18.levelflag;
        }
    }

    foreach ( var_15 in level.flags )
    {
        var_16 = var_15.label;

        foreach ( var_23 in level._id_9253["start"].flags )
        {
            if ( var_23.label == var_16 )
                var_15.levelflag = var_23.levelflag;
        }
    }
}

_id_921A( var_0, var_1 )
{
    foreach ( var_3 in level._id_9253[var_1].flags )
    {
        if ( var_0.useobj.label == var_3.useobj.label )
            return var_3;
    }

    return undefined;
}

_id_922E( var_0 )
{
    if ( game["switchedsides"] )
    {
        level._id_24AF["axis"] = getent( "post_event_capzone_allies", "targetname" );
        level._id_24AF["allies"] = getent( "post_event_capzone_axis", "targetname" );
    }
    else
    {
        level._id_24AF["allies"] = getent( "post_event_capzone_allies", "targetname" );
        level._id_24AF["axis"] = getent( "post_event_capzone_axis", "targetname" );
    }

    var_1 = [];
    var_1["allies"] = level.capzones["allies"];
    var_1["axis"] = level.capzones["axis"];
    var_2["allies"] = level.teamflags["allies"];
    var_2["axis"] = level.teamflags["axis"];
    var_3["allies"] = level._id_24AF["allies"].origin;
    var_3["axis"] = level._id_24AF["axis"].origin;

    foreach ( var_5 in var_1 )
    {
        var_5 maps\mp\gametypes\_gameobjects::move_use_object( var_3[var_5.ownerteam], ( 0.0, 0.0, 85.0 ) );
        var_5.trigger common_scripts\utility::trigger_off();
    }

    foreach ( var_8 in level.teamflags )
    {
        var_8 maps\mp\gametypes\_gameobjects::move_use_object( var_3[var_8.ownerteam], ( 0.0, 0.0, 85.0 ) );

        if ( isdefined( var_8.carrier ) )
        {
            var_8 maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
            var_8 maps\mp\gametypes\_gameobjects::set2dicon( "friendly", level.iconkill2d );
            var_8 maps\mp\gametypes\_gameobjects::set3dicon( "friendly", level.iconkill3d );
            var_8 maps\mp\gametypes\_gameobjects::set2dicon( "enemy", level.iconescort2d );
            var_8 maps\mp\gametypes\_gameobjects::set3dicon( "enemy", level.iconescort3d );
            level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::allowuse( "none" );
            level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::setvisibleteam( "friendly" );
            level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set2dicon( "friendly", level.iconwaitforflag2d );
            level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set3dicon( "friendly", level.iconwaitforflag3d );

            if ( var_8.ownerteam == "allies" )
            {
                level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set2dicon( "mlg", level.iconmissingblue );
                level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set3dicon( "mlg", level.iconmissingblue );
                continue;
            }

            level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set2dicon( "mlg", level.iconmissingred );
            level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set3dicon( "mlg", level.iconmissingred );
        }
    }

    maps\mp\gametypes\ctf::capturezone_reset_base_effects();
    maps\mp\gametypes\ctf::reassign_ctf_team_spawns();

    foreach ( var_5 in var_1 )
        var_5.trigger common_scripts\utility::trigger_on();
}

_id_9230( var_0 )
{
    level.zones = level._id_6E6C;

    if ( level.randomzonespawn == 0 )
        level.prevzoneindex = level.zones.size - 1;
    else
    {
        level.zonespawnqueue = [];
        maps\mp\gametypes\hp::shufflezones();
    }

    setomnvar( "ui_hardpoint_timer", 0 );
    level notify( "zone_moved" );
}

_id_922C( var_0 )
{
    level._id_12CD = common_scripts\utility::getstructarray( "ball_start_post_event", "targetname" );

    if ( game["switchedsides"] )
    {
        level._id_12A3["allies"] = common_scripts\utility::getstruct( "ball_goal_axis_post_event", "targetname" );
        level._id_12A3["axis"] = common_scripts\utility::getstruct( "ball_goal_allies_post_event", "targetname" );
    }
    else
    {
        level._id_12A3["axis"] = common_scripts\utility::getstruct( "ball_goal_axis_post_event", "targetname" );
        level._id_12A3["allies"] = common_scripts\utility::getstruct( "ball_goal_allies_post_event", "targetname" );
    }

    var_1 = [];
    var_1["allies"] = level.ball_goals["allies"];
    var_1["axis"] = level.ball_goals["axis"];
    var_2 = [];
    var_2["allies"] = level._id_12A3["allies"].origin;
    var_2["axis"] = level._id_12A3["axis"].origin;

    foreach ( var_4 in var_1 )
    {
        var_5 = ( 0, 0, var_4.radius / 2 * 1.1 );
        var_4.useobject maps\mp\gametypes\_gameobjects::move_use_object( var_2[var_4.team], var_5 );
        var_4 maps\mp\gametypes\ball::ball_find_ground();

        foreach ( var_7 in level.players )
            maps\mp\gametypes\ball::ball_goal_fx_for_player( var_7 );
    }

    _id_16F0();
    var_10 = _func_202( level.ball_goals["allies"].origin );

    if ( isdefined( var_10 ) )
        botzonesetteam( var_10, "allies" );

    var_10 = _func_202( level.ball_goals["axis"].origin );

    if ( isdefined( var_10 ) )
        botzonesetteam( var_10, "axis" );

    level.ball_starts = [];

    foreach ( var_12 in level._id_12CD )
        maps\mp\gametypes\ball::ball_add_start( var_12.origin );

    foreach ( var_15 in level.balls )
    {
        var_16 = 0;

        foreach ( var_7 in level.players )
        {
            if ( isdefined( var_7.ball_carried ) && var_7.ball_carried == var_15 )
            {
                var_16 = 1;
                break;
            }
        }

        if ( var_16 != 1 )
            var_15 maps\mp\gametypes\ball::ball_return_home();
    }
}

_id_16F0()
{
    var_0 = 400;
    wait 1.0;
    var_1 = 0;
    var_2 = 10;

    foreach ( var_4 in level.ball_goals )
    {
        var_4._id_12A9 = [];
        var_5 = getnodesinradius( var_4.origin, var_0, 0 );

        foreach ( var_7 in var_5 )
        {
            if ( var_7.type == "End" )
                continue;

            var_1++;

            if ( _id_15B8( var_7.origin, var_4, 1 ) )
                var_4._id_12A9[var_4._id_12A9.size] = var_7;

            if ( var_1 % var_2 == 0 )
                wait 0.05;
        }

        var_9 = 999999999;

        foreach ( var_7 in var_4._id_12A9 )
        {
            var_11 = _func_220( var_7.origin, var_4.origin );

            if ( var_11 < var_9 )
            {
                var_4.nearest_node = var_7;
                var_9 = var_11;
            }
        }

        wait 0.05;
    }
}

_id_15B8( var_0, var_1, var_2 )
{
    var_3 = _id_15BA( var_0, var_1.origin );

    if ( isdefined( var_2 ) && var_2 )
    {
        if ( !var_3 )
        {
            var_4 = var_1.origin - ( 0, 0, var_1.radius * 0.5 );
            var_3 = _id_15BA( var_0, var_4 );
        }

        if ( !var_3 )
        {
            var_4 = var_1.origin + ( 0, 0, var_1.radius * 0.5 );
            var_3 = _id_15BA( var_0, var_4 );
        }
    }

    return var_3;
}

_id_15BA( var_0, var_1 )
{
    if ( isdefined( self ) && ( isplayer( self ) || isagent( self ) ) )
        var_2 = playerphysicstrace( var_0, var_1, self );
    else
        var_2 = playerphysicstrace( var_0, var_1 );

    return distancesquared( var_2, var_1 ) < 1;
}

_id_922D( var_0 )
{
    var_1 = _id_3E90( var_0 );

    foreach ( var_3 in level.dogtags )
    {
        var_4 = var_3.curorigin + var_1;
        var_5 = _id_921B( var_4 );

        if ( isdefined( var_5 ) )
        {
            var_5._id_555F = gettime();
            var_6 = var_5.origin - var_3.curorigin;
            var_3.curorigin += var_6;
            var_3.trigger.origin += var_6;
            var_3.visuals[0].origin += var_6;
            var_3.visuals[1].origin += var_6;
            continue;
        }

        var_3 maps\mp\gametypes\conf::resettags();
    }
}

_id_921B( var_0 )
{
    var_1 = gettime();
    var_2 = getnodesinradiussorted( var_0, 300, 0, 200, "Path" );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( isdefined( var_4._id_555F ) && var_4._id_555F == var_1 )
            continue;

        return var_4;
    }

    return undefined;
}

_id_920E( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    foreach ( var_4 in level._id_9253 )
    {
        var_5 = distancesquared( var_4.origin, var_0 );

        if ( !isdefined( var_1 ) || var_5 < var_1 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }
    }

    return var_2;
}

_id_9231( var_0 )
{
    level._id_9247 = var_0;
}

_id_9232( var_0 )
{
    level._id_9248 = var_0;
}

_id_921D( var_0 )
{
    level._id_921C = var_0;
}

_id_9242( var_0, var_1 )
{
    level._id_9222[var_0] = var_1;
}

_id_9244( var_0, var_1 )
{
    level._id_923A[var_1] = var_0;
}

_id_9243( var_0, var_1 )
{
    level._id_9239[var_1] = var_0;
}

_id_9234( var_0 )
{
    if ( isdefined( var_0._id_65A6 ) && var_0._id_65A6 )
        return;

    var_0._id_9233 = [];
    var_0._id_9233["none"] = [];
    var_0._id_9233["allies"] = [];
    var_0._id_9233["axis"] = [];
    var_1 = common_scripts\utility::getstructarray( "teleport_zone_" + var_0.name, "targetname" );

    if ( isdefined( var_0.target ) )
    {
        var_2 = common_scripts\utility::getstructarray( var_0.target, "targetname" );
        var_1 = common_scripts\utility::array_combine( var_2, var_1 );
    }

    foreach ( var_4 in var_1 )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            var_4.script_noteworthy = "teleport_origin";

        switch ( var_4.script_noteworthy )
        {
            case "teleport_origin":
                var_5 = var_4.origin + ( 0.0, 0.0, 1.0 );
                var_6 = var_4.origin - ( 0.0, 0.0, 250.0 );
                var_7 = bullettrace( var_5, var_6, 0 );

                if ( var_7["fraction"] == 1.0 )
                    continue;

                var_4.origin = var_7["position"];
            case "telport_origin_nodrop":
                if ( !isdefined( var_4.script_parameters ) )
                    var_4.script_parameters = "none,axis,allies";

                var_8 = strtok( var_4.script_parameters, ", " );

                foreach ( var_10 in var_8 )
                {
                    if ( !isdefined( var_0._id_9233[var_10] ) )
                        continue;

                    if ( !isdefined( var_4.angles ) )
                        var_4.angles = ( 0.0, 0.0, 0.0 );

                    var_11 = var_0._id_9233[var_10].size;
                    var_0._id_9233[var_10][var_11] = var_4;
                }

                continue;
            default:
                continue;
        }
    }

    var_0._id_65A6 = 1;
}

_id_9241( var_0 )
{
    level._id_9252 = var_0;

    if ( isdefined( level._id_9222[var_0] ) )
        maps\mp\_compass::_id_831E( level._id_9222[var_0] );
}

_id_9213( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._id_9252;

    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4.teleport_label ) )
            var_4.teleport_label = "ent_" + var_4 getentitynumber();

        if ( !isdefined( level._id_9245[var_4.teleport_label] ) )
            _id_9220( var_4 );

        if ( level._id_9245[var_4.teleport_label].zone == var_1 )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

_id_9220( var_0 )
{
    if ( !isdefined( var_0.teleport_label ) )
        var_0.teleport_label = "ent_" + var_0 getentitynumber();

    if ( isdefined( level._id_9245[var_0.teleport_label] ) )
        return;

    var_1 = spawnstruct();
    var_1._id_03DA = var_0;
    var_2 = undefined;

    foreach ( var_4 in level._id_9253 )
    {
        var_5 = distance( var_4.origin, var_0.origin );

        if ( !isdefined( var_2 ) || var_5 < var_2 )
        {
            var_2 = var_5;
            var_1.zone = var_4.name;
        }
    }

    level._id_9245[var_0.teleport_label] = var_1;
}

_id_9221( var_0 )
{
    foreach ( var_3, var_2 in level._id_9253 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

_id_924B( var_0, var_1 )
{
    if ( !level._id_9209 )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = level._id_923A[var_0];

    if ( isdefined( var_2 ) && var_1 )
        [[ var_2 ]]();

    var_3 = level._id_9253[level._id_9252];
    var_4 = level._id_9253[var_0];

    if ( !isdefined( var_3 ) || !isdefined( var_4 ) )
        return;

    if ( level._id_921E )
    {
        _id_924F( var_0 );
        _id_924C( var_0 );
    }

    if ( level._id_921C )
        _id_924E( var_0 );

    if ( isdefined( level._id_9215 ) )
        [[ level._id_9215 ]]( var_0 );

    _id_9241( var_0 );
    level notify( "teleport_to_zone", var_0 );
    var_5 = level._id_9239[var_0];

    if ( isdefined( var_5 ) && var_1 )
        [[ var_5 ]]();

    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["post_teleport"] ) )
        [[ level.bot_funcs["post_teleport"] ]]();
}

_id_924C( var_0 )
{
    var_1 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );

    foreach ( var_3 in var_1 )
        _id_924D( var_0, var_3 );
}

_id_924F( var_0 )
{
    foreach ( var_2 in level.players )
        _id_924D( var_0, var_2 );
}

_id_924D( var_0, var_1 )
{
    var_2 = level._id_9253[level._id_9252];
    var_3 = level._id_9253[var_0];
    var_4 = gettime();

    if ( isplayer( var_1 ) && ( var_1.sessionstate == "intermission" || var_1.sessionstate == "spectator" ) )
    {
        var_5 = getentarray( "mp_global_intermission", "classname" );
        var_5 = _id_9213( var_5, var_0 );
        var_6 = var_5[0];
        var_1 dontinterpolate();
        var_1 setorigin( var_6.origin );
        var_1 setangles( var_6.angles );
    }
    else
    {
        var_7 = undefined;
        var_8 = var_1.angles;

        if ( isplayer( var_1 ) )
            var_8 = var_1 getangles();

        foreach ( var_14, var_10 in var_3._id_9233 )
        {
            var_3._id_9233[var_14] = common_scripts\utility::array_randomize( var_10 );

            foreach ( var_12 in var_10 )
                var_12._id_1E1D = 0;
        }

        var_15 = [];

        if ( level.teambased )
        {
            if ( isdefined( var_1.team ) && isdefined( var_3._id_9233[var_1.team] ) )
                var_15 = var_3._id_9233[var_1.team];
        }
        else
            var_15 = var_3._id_9233["none"];

        foreach ( var_12 in var_15 )
        {
            if ( !var_12._id_1E1D )
            {
                var_7 = var_12.origin;
                var_8 = var_12.angles;
                var_12._id_1E1D = 1;
                break;
            }
        }

        var_18 = var_3.origin - var_2.origin;
        var_19 = var_1.origin + var_18;

        if ( !isdefined( var_7 ) && level._id_9248 )
        {
            if ( precachestatusicon( var_19 ) && !getstarttime( var_19 ) )
                var_7 = var_19;
        }

        if ( !isdefined( var_7 ) && level._id_9247 )
        {
            var_20 = getnodesinradiussorted( var_19, 300, 0, 200, "Path" );

            for ( var_21 = 0; var_21 < var_20.size; var_21++ )
            {
                var_22 = var_20[var_21];

                if ( isdefined( var_22._id_555F ) && var_22._id_555F == var_4 )
                    continue;

                var_12 = var_22.origin;

                if ( precachestatusicon( var_12 ) && !getstarttime( var_12 ) )
                {
                    var_22._id_555F = var_4;
                    var_7 = var_12;
                    break;
                }
            }
        }

        if ( !isdefined( var_7 ) )
        {
            var_1 maps\mp\_utility::_suicide();
            return;
        }

        var_1 _meth_8439();
        var_1 dontinterpolate();
        var_1 setorigin( var_7 );
        var_1 setangles( var_8 );
        thread _id_9250( var_1 );
    }
}

_id_9250( var_0 )
{
    waitframe();

    if ( isdefined( var_0 ) )
    {
        var_1 = _id_920E( var_0.origin );

        if ( var_1.name != level._id_9252 )
            var_0 maps\mp\_utility::_suicide();
    }
}

_id_3E90( var_0 )
{
    var_1 = level._id_9253[var_0];
    var_2 = level._id_9253[level._id_9252];
    var_3 = var_1.origin - var_2.origin;
    return var_3;
}

_id_924E( var_0 )
{

}

_id_9224()
{
    if ( isdefined( self ) )
        self notify( "death" );
}

_id_0D15( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( !isdefined( var_0 ) )
        return;

    common_scripts\utility::array_thread( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
}

_id_0CF1( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_0 ) )
        return;

    common_scripts\utility::array_levelthread( var_0, var_1, var_2, var_3, var_4 );
}

_id_9218()
{
    return getentarray( "care_package", "targetname" );
}

_id_9219()
{
    var_0 = [];
    var_1 = getentarray( "script_model", "classname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3._id_175D ) )
            var_0[var_0.size] = var_3;
    }

    return var_0;
}

_id_9236( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 300;

    var_2 = var_0.origin;
    var_3 = var_0.origin - ( 0, 0, var_1 );
    var_4 = bullettrace( var_2, var_3, 0, var_0 );

    if ( var_4["fraction"] < 1 )
    {
        var_0.origin = var_4["position"];
        return 1;
    }
    else
        return 0;
}

_id_9205( var_0, var_1 )
{
    if ( _id_920F( var_0 ) )
        return;

    _id_9204( var_0, var_1 );

    if ( isdefined( var_0.target ) )
    {
        var_2 = getentarray( var_0.target, "targetname" );
        var_3 = common_scripts\utility::getstructarray( var_0.target, "targetname" );
        var_4 = common_scripts\utility::array_combine( var_2, var_3 );
        common_scripts\utility::array_levelthread( var_4, ::_id_9205, var_1 );
    }
}

_id_9240( var_0 )
{
    _id_9205( self, var_0 );
}

_id_923F( var_0 )
{
    _id_9204( self, var_0 );
}

_id_9204( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        if ( !_id_920F( var_0 ) )
        {
            var_0.origin += var_1;
            var_0._id_555F = gettime();
        }
    }
}

_id_920F( var_0 )
{
    return isdefined( var_0._id_555F ) && var_0._id_555F == gettime();
}

_id_9216()
{
    return level._id_9223[level._id_9252];
}

_id_9217()
{
    return level._id_9235[level._id_9252];
}
