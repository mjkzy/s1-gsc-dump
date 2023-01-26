// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

agentfunc( var_0 )
{
    return level._id_0897[self.agent_type][var_0];
}

_id_7DAB( var_0, var_1 )
{
    self.team = var_0;
    self._id_001D = var_0;
    self.pers["team"] = var_0;
    self.owner = var_1;
    self setotherent( var_1 );
    self setentityowner( var_1 );
}

_id_4D7C()
{
    self.agent_type = "player";
    self.pers = [];
    self._id_4723 = 0;
    self.isactive = 0;
    self._id_50A8 = 1;
    self.wasti = 0;
    self.issniper = 0;
    self.spawntime = 0;
    self.entity_number = self getentitynumber();
    self.agent_teamparticipant = 0;
    self.agent_gameparticipant = 0;
    self.canperformclienttraces = 0;
    self.agentname = undefined;
    self._id_01FC = 0;
    self.ignoreme = 0;
    self detachall();
    _id_4DFC( 0 );
}

_id_4DFC( var_0 )
{
    if ( !var_0 )
    {
        self.class = undefined;
        self.lastclass = undefined;
        self.movespeedscaler = undefined;
        self.avoidkillstreakonspawntimer = undefined;
        self.guid = undefined;
        self.name = undefined;
        self.saved_actionslotdata = undefined;
        self.perks = undefined;
        self.weaponlist = undefined;
        self.omaclasschanged = undefined;
        self.objectivescaler = undefined;
        self.touchtriggers = undefined;
        self.carryobject = undefined;
        self.claimtrigger = undefined;
        self.canpickupobject = undefined;
        self.killedinuse = undefined;
        self.sessionteam = undefined;
        self.sessionstate = undefined;
        self.lastspawntime = undefined;
        self.lastspawnpoint = undefined;
        self.disabledweapon = undefined;
        self.disabledweaponswitch = undefined;
        self.disabledoffhandweapons = undefined;
        self.disabledusability = undefined;
        self.shielddamage = undefined;
        self.shieldbullethits = undefined;
    }
    else
    {
        self.movespeedscaler = level.baseplayermovescale;
        self.avoidkillstreakonspawntimer = 5;
        self.guid = maps\mp\_utility::getuniqueid();
        self.name = self.guid;
        self.sessionteam = self.team;
        self.sessionstate = "playing";
        self.shielddamage = 0;
        self.shieldbullethits = 0;
        self.agent_gameparticipant = 1;
        maps\mp\gametypes\_playerlogic::setupsavedactionslots();
        thread maps\mp\perks\_perks::onplayerspawned();

        if ( maps\mp\_utility::isgameparticipant( self ) )
        {
            self.objectivescaler = 1;
            maps\mp\gametypes\_gameobjects::init_player_gameobjects();
            self.disabledweapon = 0;
            self.disabledweaponswitch = 0;
            self.disabledoffhandweapons = 0;
        }
    }

    self.disabledusability = 1;
}

_id_3FA0( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level.agentarray ) )
    {
        foreach ( var_3 in level.agentarray )
        {
            if ( ( !isdefined( var_3.isactive ) || !var_3.isactive ) && ( !isdefined( var_3._id_518A ) || !var_3._id_518A ) )
            {
                if ( isdefined( var_3._id_A041 ) && var_3._id_A041 )
                    continue;

                if ( isdefined( level.despawning_agents ) && common_scripts\utility::array_contains( level.despawning_agents, var_3 ) )
                    continue;

                var_1 = var_3;
                var_1 _id_4D7C();

                if ( isdefined( var_0 ) )
                    var_1.agent_type = var_0;

                break;
            }
        }
    }

    return var_1;
}

_id_070B()
{
    self.isactive = 1;
}

_id_2630()
{
    thread _id_2631();
}

_id_2631()
{
    self notify( "deactivateAgentDelayed" );
    self endon( "deactivateAgentDelayed" );

    if ( !isdefined( level.despawning_agents ) )
        level.despawning_agents = [];

    if ( !common_scripts\utility::array_contains( level.despawning_agents, self ) )
        level.despawning_agents = common_scripts\utility::array_add( level.despawning_agents, self );

    if ( maps\mp\_utility::isgameparticipant( self ) )
        maps\mp\gametypes\_spawnlogic::removefromparticipantsarray();

    maps\mp\gametypes\_spawnlogic::removefromcharactersarray();
    wait 0.05;
    self.isactive = 0;
    self._id_4723 = 0;
    self.owner = undefined;
    self.connecttime = undefined;
    self._id_A041 = undefined;

    foreach ( var_1 in level.characters )
    {
        if ( isdefined( var_1.attackers ) )
        {
            foreach ( var_4, var_3 in var_1.attackers )
            {
                if ( var_3 == self )
                    var_1.attackers[var_4] = undefined;
            }
        }
    }

    self.headmodel = undefined;
    self detachall();
    self notify( "disconnect" );
    self _meth_848A();
    level.despawning_agents = common_scripts\utility::array_remove( level.despawning_agents, self );
}

_id_4052( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "all";

    var_1 = _id_3ED7( var_0 );
    return var_1.size;
}

_id_3ED7( var_0 )
{
    var_1 = [];

    if ( !isdefined( level.agentarray ) )
        return var_1;

    foreach ( var_3 in level.agentarray )
    {
        if ( isdefined( var_3.isactive ) && var_3.isactive )
        {
            if ( var_0 == "all" || var_3.agent_type == var_0 )
                var_1[var_1.size] = var_3;
        }
    }

    return var_1;
}

_id_4054( var_0 )
{
    return _id_4055( var_0, "all" );
}

_id_4055( var_0, var_1 )
{
    var_2 = 0;

    if ( !isdefined( level.agentarray ) )
        return var_2;

    foreach ( var_4 in level.agentarray )
    {
        if ( isdefined( var_4.isactive ) && var_4.isactive )
        {
            if ( isdefined( var_4.owner ) && var_4.owner == var_0 )
            {
                if ( var_1 == "all" || var_4.agent_type == var_1 )
                    var_2++;
            }
        }
    }

    return var_2;
}

_id_414A( var_0, var_1 )
{
    var_2 = getnodesinradius( self.origin, 350, 64, 128, "Path" );

    if ( !isdefined( var_2 ) || var_2.size == 0 )
        return undefined;

    if ( isdefined( level._id_A28E ) && isdefined( level._id_981A ) )
    {
        var_3 = var_2;
        var_2 = [];

        foreach ( var_5 in var_3 )
        {
            if ( var_5.origin[2] > level._id_A28E || !_func_22A( var_5.origin, level._id_981A ) )
                var_2[var_2.size] = var_5;
        }
    }

    var_7 = anglestoforward( self.angles );
    var_8 = -10;
    var_9 = maps\mp\gametypes\_spawnlogic::getplayertraceheight( self );
    var_10 = ( 0, 0, var_9 );

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_11 = [];
    var_12 = [];

    foreach ( var_14 in var_2 )
    {
        if ( !var_14 _meth_8035( "stand" ) )
            continue;

        var_15 = vectornormalize( var_14.origin - self.origin );
        var_16 = vectordot( var_7, var_15 );

        for ( var_17 = 0; var_17 < var_12.size; var_17++ )
        {
            if ( var_16 > var_12[var_17] )
            {
                for ( var_18 = var_12.size; var_18 > var_17; var_18-- )
                {
                    var_12[var_18] = var_12[var_18 - 1];
                    var_11[var_18] = var_11[var_18 - 1];
                }

                break;
            }
        }

        var_11[var_17] = var_14;
        var_12[var_17] = var_16;
    }

    for ( var_17 = 0; var_17 < var_11.size; var_17++ )
    {
        var_14 = var_11[var_17];
        var_20 = self.origin + var_10;
        var_21 = var_14.origin + var_10;

        if ( var_17 > 0 )
            wait 0.05;

        if ( !sighttracepassed( var_20, var_21, 0, self ) )
            continue;

        if ( var_1 )
        {
            if ( var_17 > 0 )
                wait 0.05;

            var_22 = playerphysicstrace( var_14.origin + var_10, var_14.origin );

            if ( distancesquared( var_22, var_14.origin ) > 1 )
                continue;
        }

        if ( var_0 )
        {
            if ( var_17 > 0 )
                wait 0.05;

            var_22 = physicstrace( var_20, var_21 );

            if ( distancesquared( var_22, var_21 ) > 1 )
                continue;
        }

        return var_14;
    }

    if ( var_11.size > 0 && isdefined( level.ishorde ) )
        return var_11[0];
}

_id_5346( var_0 )
{
    var_0 dodamage( var_0.health + 500000, var_0.origin );
}

_id_5357()
{
    self [[ agentfunc( "on_damaged" ) ]]( level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ), "none", 0 );
}