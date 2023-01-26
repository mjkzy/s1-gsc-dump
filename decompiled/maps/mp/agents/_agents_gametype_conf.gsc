// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
}

_id_806C()
{
    level._id_0897["squadmate"]["gametype_update"] = ::_id_089D;
    level._id_0897["player"]["think"] = ::_id_089A;
}

_id_089A()
{
    thread maps\mp\bots\_bots_gametype_conf::_id_15DE();
}

_id_089D()
{
    if ( !isdefined( self._id_9101 ) )
        self._id_9101 = [];

    if ( !isdefined( self._id_60BF ) )
        self._id_60BF = gettime() + 500;

    if ( gettime() > self._id_60BF )
    {
        self._id_60BF = gettime() + 500;
        var_0 = 0.78;
        var_1 = self.owner _meth_8387();

        if ( isdefined( var_1 ) )
        {
            var_2 = self.owner maps\mp\bots\_bots_gametype_conf::_id_1617( 1, var_1, var_0 );
            self._id_9101 = maps\mp\bots\_bots_gametype_conf::_id_15DD( var_2, self._id_9101 );
        }
    }

    self._id_9101 = maps\mp\bots\_bots_gametype_conf::_id_16CE( self._id_9101 );
    var_3 = maps\mp\bots\_bots_gametype_conf::_id_1610( self._id_9101, 0 );

    if ( isdefined( var_3 ) )
    {
        if ( !isdefined( self._id_90B7 ) || distancesquared( var_3.curorigin, self._id_90B7.curorigin ) > 1 )
        {
            self._id_90B7 = var_3;
            maps\mp\bots\_bots_strategy::_id_15EF();
            self botsetscriptgoal( self._id_90B7.curorigin, 0, "objective", undefined, level._id_170A );
        }

        return 1;
    }
    else if ( isdefined( self._id_90B7 ) )
    {
        self _meth_8356();
        self._id_90B7 = undefined;
    }

    return 0;
}
