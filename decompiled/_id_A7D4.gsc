// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["mp_instinct"] = ::_id_98AE;
    level.mapkillstreak = "mp_instinct";
    level._id_4E8D = [];
    precachemodel( "animal_iw6_dog_a" );
    level.killstreakwieldweapons["killstreak_instinct_mp"] = "mp_instinct";
    level._id_4E8E = [];
    var_0 = getnodearray( "InstinctDogSpawnPoint", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_3.spawnpoint = var_2;
        var_3._id_0522 = 0;
        level._id_4E8E = common_scripts\utility::add_to_array( level._id_4E8E, var_3 );
    }

    onplayerconnect();
}

_id_98AE( var_0, var_1 )
{
    return _id_89E1();
}

_id_7FB3( var_0 )
{
    level._id_5FBD = var_0;
    thread maps\mp\_utility::teamplayercardsplash( "used_mp_instinct", var_0 );
    return 1;
}

onplayerconnect()
{
    var_0 = 0;

    for (;;)
    {
        level waittill( "connected", var_1 );

        if ( var_0 == 0 )
        {
            if ( !isdefined( level.ishorde ) || !level.ishorde )
            {
                level._id_0897["dog"]["think"] = maps\mp\agents\dog\_instinct_dog_think::main;
                level._id_0897["dog"]["on_killed"] = ::_id_6435;
            }
        }

        var_0++;
        var_1 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    thread _id_5E72();
}

_id_89E1()
{
    if ( maps\mp\agents\_agent_utility::_id_4052( "dog" ) >= 3 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_TOO_MANY_DOGS" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::_id_4055( self, "dog" ) >= 3 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_ALREADY_HAVE_DOG" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::_id_4054( self ) >= 3 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_0 = isagent();

    if ( maps\mp\agents\_agent_utility::_id_4052() >= var_0 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    if ( !maps\mp\_utility::isreallyalive( self ) )
        return 0;

    _id_2147();
    return 1;
}

_id_888F()
{
    foreach ( var_1 in level._id_4E8E )
    {
        var_1._id_0522 = 0;
        var_2 = distance( var_1.spawnpoint.origin, self.origin );

        if ( var_2 < 1500 )
            var_1._id_0522 = 1;
        else if ( var_2 > 1500 && var_2 < 2000 )
            var_1._id_0522 = 2;
        else if ( var_2 > 2000 && var_2 < 2500 )
            var_1._id_0522 = 3;
        else if ( var_2 > 2500 )
            var_1._id_0522 = 4;

        foreach ( var_4 in level.players )
        {
            var_5 = var_1.spawnpoint.origin;
            var_6 = var_4.origin;
            var_7 = sighttracepassed( var_5, var_6, 0, var_4 );

            if ( var_7 )
                var_1._id_0522--;

            var_2 = distance( var_1.spawnpoint.origin, var_4.origin );

            if ( var_2 < 256 )
                var_1._id_0522--;
        }
    }

    level._id_4E8E = common_scripts\utility::array_sort_with_func( level._id_4E8E, ::_id_517C );
}

_id_6809()
{
    var_0 = level._id_4E8E[0];
    level._id_4E8E = common_scripts\utility::array_remove( level._id_4E8E, level._id_4E8E[0] );
    return var_0;
}

_id_517C( var_0, var_1 )
{
    return var_0._id_0522 > var_1._id_0522;
}

_id_A036()
{
    common_scripts\utility::waittill_any_timeout( 60, "KillCountMet" );
    self notify( "retreat" );
    var_0 = getnodearray( "DeletePoint", "targetname" );
    var_1 = common_scripts\utility::getclosest( self.origin, var_0 );
    self notify( "timeoutRetreat" );
    self _meth_8390( var_1.origin );
    common_scripts\utility::waittill_any_timeout( 20, "stop_soon" );
    self suicide();
    self notify( "death" );
}

_id_2147()
{
    _id_888F();

    for ( var_0 = 0; var_0 < 3; var_0++ )
    {
        var_1 = _id_6809();

        if ( !isdefined( var_1 ) )
            return 0;

        var_2 = maps\mp\agents\_agent_common::_id_214C( "dog", self.team );

        if ( !isdefined( var_2 ) )
            return 0;

        var_3 = self.health;
        var_4 = 25;
        self._id_001B = var_4;
        self.health = var_4;
        self.maxhealth = var_4;
        level._id_4E8D = common_scripts\utility::array_add( level._id_4E8D, var_2 );
        var_2 thread _id_A011( var_1 );
        var_2 maps\mp\agents\_agent_utility::_id_7DAB( self.team, self );
        var_5 = var_1.spawnpoint.origin;
        var_6 = vectortoangles( self.origin - var_1.spawnpoint.origin );
        var_2 thread [[ var_2 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_5, var_6, self );

        if ( isdefined( self.balldrone ) && self.balldrone._id_12D7 == "ball_drone_backup" )
            maps\mp\gametypes\_missions::processchallenge( "ch_twiceasdeadly" );

        var_2 thread _id_A036();
    }
}

_id_A011( var_0 )
{
    common_scripts\utility::waittill_any( "death", "retreat" );
    level._id_4E8E = common_scripts\utility::array_add( level._id_4E8E, var_0 );
    level._id_4E8D = common_scripts\utility::array_remove( level._id_4E8D, self );
}

_id_5E72()
{
    for (;;)
    {
        self waittill( "death", var_0 );

        foreach ( var_2 in level._id_4E8D )
        {
            if ( var_0 == var_2 )
            {
                if ( !isdefined( var_2._id_32B1 ) )
                    var_2._id_32B1 = 0;

                var_2._id_32B1++;

                if ( var_2._id_32B1 >= 2 )
                    var_2 notify( "KillCountMet" );
            }
        }
    }
}

_id_6435( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.isactive = 0;
    self._id_4723 = 0;
    var_1._id_55AD = gettime();

    if ( isdefined( self._id_0C69._id_64A2[self._id_09A3] ) )
        self [[ self._id_0C69._id_64A2[self._id_09A3] ]]();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
    {
        self.owner maps\mp\_utility::leaderdialogonplayer( "dog_kia_mp_instinct" );
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_guard_dog" );

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_missions::processchallenge( "ch_notsobestfriend" );

            if ( !self isonground() )
                var_1 maps\mp\gametypes\_missions::processchallenge( "ch_hoopla" );
        }
    }

    self _meth_83D2( "death" );
    var_9 = self _meth_83D3();
    var_10 = getanimlength( var_9 );
    var_8 = int( var_10 * 1000 );
    self.body = self _meth_838D( var_8 );
    self playsound( "anml_dog_shot_death" );
    maps\mp\agents\_agent_utility::_id_2630();
    self notify( "killanimscript" );
}
