// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_00B1()
{
    maps\mp\agents\_agent_utility::_id_4D7C();
    var_0 = "axis";

    if ( level._id_628B % 2 == 0 )
        var_0 = "allies";

    level._id_628B++;
    maps\mp\agents\_agent_utility::_id_7DAB( var_0 );
    level.agentarray[level.agentarray.size] = self;
}

_id_00B2( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_1 = maps\mp\_utility::_validateattacker( var_1 );
    self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_id_00B3( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_1 = maps\mp\_utility::_validateattacker( var_1 );
    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "on_killed" ) ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

init()
{
    _id_4D7B();
    level thread _id_072F();
}

_id_214C( var_0, var_1, var_2 )
{
    var_3 = maps\mp\agents\_agent_utility::_id_3FA0( var_0 );

    if ( isdefined( var_3 ) )
    {
        var_3.connecttime = gettime();

        if ( isdefined( var_1 ) )
            var_3 maps\mp\agents\_agent_utility::_id_7DAB( var_1 );
        else
            var_3 maps\mp\agents\_agent_utility::_id_7DAB( var_3.team );

        if ( isdefined( var_2 ) )
            var_3._id_1E30 = var_2;

        if ( isdefined( level._id_0897[var_0]["onAIConnect"] ) )
            var_3 [[ var_3 maps\mp\agents\_agent_utility::agentfunc( "onAIConnect" ) ]]();

        var_3 maps\mp\gametypes\_spawnlogic::addtocharactersarray();
    }

    return var_3;
}

_id_4D7B()
{
    level.agentarray = [];
    level._id_628B = 0;
}

_id_072F()
{
    level endon( "game_ended" );
    level waittill( "connected", var_0 );
    var_1 = isagent();

    while ( level.agentarray.size < var_1 )
    {
        var_2 = _func_16C();

        if ( !isdefined( var_2 ) )
        {
            waitframe();
            continue;
        }
    }
}

set_agent_health( var_0 )
{
    self._id_001B = var_0;
    self.health = var_0;
    self.maxhealth = var_0;
}
