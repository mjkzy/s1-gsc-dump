// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakwieldweapons["killstreak_comeback_mp"] = "mp_comeback";
    level.killstreakfuncs["mp_comeback"] = ::_id_98AC;
    level.mapkillstreak = "mp_comeback";
    level._id_598A = &"MP_COMEBACK_MAP_KILLSTREAK_PICKUP";
    level._id_5984 = ::_id_82FA;
    level._id_538E = [];
    level._id_538F = getentarray( "walker_tank", "targetname" );
    common_scripts\utility::array_thread( level._id_538F, ::_id_4D63 );
    level._id_538E = common_scripts\utility::array_randomize( level._id_538E );
    level._id_85C1 = [];
    var_0 = getallnodes();

    foreach ( var_2 in var_0 )
    {
        if ( _func_20C( var_2, 1 ) )
            level._id_85C1[level._id_85C1.size] = var_2;
    }

    level._id_5CA3 = 20;
    map_restart( "mp_comeback_spider_tank_idle" );
    map_restart( "mp_comeback_spider_tank_fire" );
}

_id_82FA()
{
    level thread maps\mp\bots\_bots_ks::_id_16CC( "mp_comeback", maps\mp\bots\_bots_ks::_id_167B );
}

_id_98AC( var_0, var_1 )
{
    var_2 = undefined;

    foreach ( var_4 in level._id_538E )
    {
        var_5 = !isdefined( var_2 ) || var_4._id_554E < var_2._id_554E;

        if ( !var_4._id_0014 && var_5 )
            var_2 = var_4;
    }

    if ( !isdefined( var_2 ) )
    {
        iprintlnbold( &"MP_COMEBACK_MAP_KILLSTREAK_NOT_AVAILABLE" );
        return 0;
    }

    var_2 thread _id_4430( self );
    return 1;
}

_id_4D63()
{
    self._id_8C1A = self.origin;
    self._id_8B2C = self.angles;
    self._id_6309 = [];
    var_0 = [ "allies", "axis" ];

    foreach ( var_2 in var_0 )
    {
        self._id_6309[var_2] = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( self._id_6309[var_2], "invisible", ( 0.0, 0.0, 0.0 ) );
        objective_icon( self._id_6309[var_2], common_scripts\utility::ter_op( var_2 == "allies", "compass_objpoint_tank_friendly", "compass_objpoint_tank_enemy" ) );
    }

    self._id_4417 = self.script_noteworthy;

    if ( !isdefined( self._id_4417 ) )
        self._id_4417 = "default";

    if ( !isdefined( level._id_538E[self._id_4417] ) )
        level._id_538E[self._id_4417] = _id_4D1B();

    var_4 = level._id_538E[self._id_4417]._id_918B.size;
    level._id_538E[self._id_4417]._id_918B[var_4] = self;
    _id_9164( self );
}

_id_4D1B()
{
    var_0 = spawnstruct();
    var_0._id_0014 = 0;
    var_0._id_918B = [];
    var_0._id_554E = 0;
    return var_0;
}

_id_4430( var_0 )
{
    self._id_0014 = 1;
    self._id_662F = var_0.team;
    self.owner = var_0;
    self._id_554E = gettime();
    self._id_9149 = self._id_918B.size;

    foreach ( var_2 in self._id_918B )
        thread _id_9174( var_2 );

    self waittill( "all_tanks_done" );
    self._id_0014 = 0;
}

_id_9174( var_0, var_1 )
{
    _id_917A( var_0 );
    _id_9134( var_0 );
    _id_9164( var_0 );
    _id_914E( var_0 );
}

_id_917A( var_0 )
{
    foreach ( var_3, var_2 in var_0._id_6309 )
    {
        objective_state( var_2, "active" );

        if ( var_3 == "allies" )
            objective_playerteam( var_2, self.owner getentitynumber() );
        else
            objective_playerenemyteam( var_2, self.owner getentitynumber() );

        objective_onentitywithrotation( var_2, var_0 );
    }
}

_id_9163( var_0 )
{
    foreach ( var_3, var_2 in var_0._id_6309 )
        objective_state( var_2, "invisible" );
}

_id_9164( var_0 )
{
    var_0 scriptmodelplayanimdeltamotion( "mp_comeback_spider_tank_idle" );
}

_id_9134( var_0 )
{
    self.owner endon( "disconnect" );
    var_0 endon( "tank_destroyed" );
    var_0 playsound( "walker_start" );
    var_0 scriptmodelplayanimdeltamotion( "mp_comeback_spider_tank_fire", "comeback_tank" );
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        var_0 waittill( "comeback_tank", var_3 );

        switch ( var_3 )
        {
            case "fire_right":
                var_1++;
                var_4 = "tag_missile_" + var_1 + "_r";
                _id_915C( var_0, var_4 );
                continue;
            case "fire_left":
                var_2++;
                var_4 = "tag_missile_" + var_2 + "_l";
                _id_915C( var_0, var_4 );
                continue;
            case "end":
                return;
        }
    }
}

_id_915C( var_0, var_1 )
{
    var_2 = var_0 gettagorigin( var_1 );
    var_3 = var_0 gettagangles( var_1 );
    var_4 = anglestoforward( var_3 );
    var_5 = var_2 + var_4 * level._id_5CA3;
    var_6 = var_5 + var_4;
    var_7 = magicbullet( "killstreak_comeback_mp", var_5, var_6, self.owner );
    thread _id_9166( var_7 );
}

_id_9166( var_0 )
{
    var_0 endon( "death" );
    wait(randomfloatrange( 0.2, 0.4 ));
    var_1 = undefined;
    var_2 = randomfloatrange( 0.5, 1.0 );
    var_3 = gettime() + var_2 * 1000;
    var_4 = maps\mp\_utility::getotherteam( self._id_662F );

    while ( gettime() < var_3 && !isdefined( var_1 ) )
    {
        var_5 = common_scripts\utility::array_randomize( level.players );

        foreach ( var_7 in var_5 )
        {
            if ( var_7.team != var_4 )
                continue;

            if ( !maps\mp\_utility::isreallyalive( var_7 ) )
                continue;

            if ( isdefined( var_7._id_9167 ) && var_7._id_9167 > gettime() )
                continue;

            if ( isdefined( var_7.spawntime ) && var_7.spawntime + 3000 > gettime() )
                continue;

            if ( sighttracepassed( var_0.origin, var_7.origin + ( 0.0, 0.0, 40.0 ), 0, var_0, var_7, 0 ) )
            {
                var_1 = var_7;
                break;
            }
        }

        wait 0.05;
    }

    if ( isdefined( var_1 ) )
    {
        var_1._id_9167 = gettime() + 3000;
        var_0 missile_settargetent( var_1 );
    }
    else
    {
        var_9 = 250;
        var_10 = var_9 * var_9;
        var_11 = common_scripts\utility::random( level._id_85C1 );

        if ( isdefined( self.owner ) )
        {
            for ( var_12 = 0; var_12 < 10 && distancesquared( var_11.origin, self.owner.origin ) < var_10; var_12++ )
                var_11 = common_scripts\utility::random( level._id_85C1 );
        }

        var_0 _meth_81DA( var_11.origin );
    }
}

_id_914E( var_0 )
{
    _id_9163( var_0 );
    self._id_9149--;

    if ( self._id_9149 == 0 )
        self notify( "all_tanks_done" );
}
