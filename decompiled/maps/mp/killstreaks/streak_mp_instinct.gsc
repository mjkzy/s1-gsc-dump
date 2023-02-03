// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["mp_instinct"] = ::tryusempinstinct;
    level.mapkillstreak = "mp_instinct";
    level.instinctdogs = [];
    precachemodel( "animal_iw6_dog_a" );
    level.killstreakwieldweapons["killstreak_instinct_mp"] = "mp_instinct";
    level.instinctdogspawnpoints = [];
    var_0 = getnodearray( "InstinctDogSpawnPoint", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_3.spawnpoint = var_2;
        var_3.weight = 0;
        level.instinctdogspawnpoints = common_scripts\utility::add_to_array( level.instinctdogspawnpoints, var_3 );
    }

    onplayerconnect();
}

tryusempinstinct( var_0, var_1 )
{
    return spawninstinctdogs();
}

setmpinstinctplayer( var_0 )
{
    level.mp_instinct_owner = var_0;
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
                level.agent_funcs["dog"]["think"] = maps\mp\agents\dog\_instinct_dog_think::main;
                level.agent_funcs["dog"]["on_killed"] = ::on_agent_dog_killed;
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
    thread monitorkills();
}

spawninstinctdogs()
{
    if ( maps\mp\agents\_agent_utility::getnumactiveagents( "dog" ) >= 3 )
    {
        self iprintlnbold( &"KILLSTREAKS_TOO_MANY_DOGS" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagentsbytype( self, "dog" ) >= 3 )
    {
        self iprintlnbold( &"KILLSTREAKS_ALREADY_HAVE_DOG" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::getnumownedactiveagents( self ) >= 3 )
    {
        self iprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_0 = getmaxagents();

    if ( maps\mp\agents\_agent_utility::getnumactiveagents() >= var_0 )
    {
        self iprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    if ( !maps\mp\_utility::isreallyalive( self ) )
        return 0;

    connectandspawninstinctdogpack();
    return 1;
}

sortinstinctdogspawnpoints()
{
    foreach ( var_1 in level.instinctdogspawnpoints )
    {
        var_1.weight = 0;
        var_2 = distance( var_1.spawnpoint.origin, self.origin );

        if ( var_2 < 1500 )
            var_1.weight = 1;
        else if ( var_2 > 1500 && var_2 < 2000 )
            var_1.weight = 2;
        else if ( var_2 > 2000 && var_2 < 2500 )
            var_1.weight = 3;
        else if ( var_2 > 2500 )
            var_1.weight = 4;

        foreach ( var_4 in level.players )
        {
            var_5 = var_1.spawnpoint.origin;
            var_6 = var_4.origin;
            var_7 = sighttracepassed( var_5, var_6, 0, var_4 );

            if ( var_7 )
                var_1.weight--;

            var_2 = distance( var_1.spawnpoint.origin, var_4.origin );

            if ( var_2 < 256 )
                var_1.weight--;
        }
    }

    level.instinctdogspawnpoints = common_scripts\utility::array_sort_with_func( level.instinctdogspawnpoints, ::ispointascoredhigherthanb );
}

pickinstinctdogspawnpoint()
{
    var_0 = level.instinctdogspawnpoints[0];
    level.instinctdogspawnpoints = common_scripts\utility::array_remove( level.instinctdogspawnpoints, level.instinctdogspawnpoints[0] );
    return var_0;
}

ispointascoredhigherthanb( var_0, var_1 )
{
    return var_0.weight > var_1.weight;
}

waitfortimeout()
{
    common_scripts\utility::waittill_any_timeout( 60, "KillCountMet" );
    self notify( "retreat" );
    var_0 = getnodearray( "DeletePoint", "targetname" );
    var_1 = common_scripts\utility::getclosest( self.origin, var_0 );
    self notify( "timeoutRetreat" );
    self scragentsetgoalpos( var_1.origin );
    common_scripts\utility::waittill_any_timeout( 20, "stop_soon" );
    self suicide();
    self notify( "death" );
}

connectandspawninstinctdogpack()
{
    sortinstinctdogspawnpoints();

    for ( var_0 = 0; var_0 < 3; var_0++ )
    {
        var_1 = pickinstinctdogspawnpoint();

        if ( !isdefined( var_1 ) )
            return 0;

        var_2 = maps\mp\agents\_agent_common::connectnewagent( "dog", self.team );

        if ( !isdefined( var_2 ) )
            return 0;

        var_3 = self.health;
        var_4 = 25;
        self.agenthealth = var_4;
        self.health = var_4;
        self.maxhealth = var_4;
        level.instinctdogs = common_scripts\utility::array_add( level.instinctdogs, var_2 );
        var_2 thread waitfordeath( var_1 );
        var_2 maps\mp\agents\_agent_utility::set_agent_team( self.team, self );
        var_5 = var_1.spawnpoint.origin;
        var_6 = vectortoangles( self.origin - var_1.spawnpoint.origin );
        var_2 thread [[ var_2 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_5, var_6, self );

        if ( isdefined( self.balldrone ) && self.balldrone.balldronetype == "ball_drone_backup" )
            maps\mp\gametypes\_missions::processchallenge( "ch_twiceasdeadly" );

        var_2 thread waitfortimeout();
    }
}

waitfordeath( var_0 )
{
    common_scripts\utility::waittill_any( "death", "retreat" );
    level.instinctdogspawnpoints = common_scripts\utility::array_add( level.instinctdogspawnpoints, var_0 );
    level.instinctdogs = common_scripts\utility::array_remove( level.instinctdogs, self );
}

monitorkills()
{
    for (;;)
    {
        self waittill( "death", var_0 );

        foreach ( var_2 in level.instinctdogs )
        {
            if ( var_0 == var_2 )
            {
                if ( !isdefined( var_2.enemykills ) )
                    var_2.enemykills = 0;

                var_2.enemykills++;

                if ( var_2.enemykills >= 2 )
                    var_2 notify( "KillCountMet" );
            }
        }
    }
}

on_agent_dog_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.isactive = 0;
    self.hasdied = 0;
    var_1.lastkilldogtime = gettime();

    if ( isdefined( self.animcbs.onexit[self.aistate] ) )
        self [[ self.animcbs.onexit[self.aistate] ]]();

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

    self setanimstate( "death" );
    var_9 = self getanimentry();
    var_10 = getanimlength( var_9 );
    var_8 = int( var_10 * 1000 );
    self.body = self finishagentdamage( var_8 );
    self playsound( "anml_dog_shot_death" );
    maps\mp\agents\_agent_utility::deactivateagent();
    self notify( "killanimscript" );
}
