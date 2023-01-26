// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
}

_id_806C()
{
    level._id_0897["squadmate"]["gametype_update"] = ::_id_089E;
    level._id_0897["player"]["think"] = ::_id_089B;
}

_id_089B()
{
    thread maps\mp\bots\_bots_gametype_dom::_id_15FF();
}

_id_089E()
{
    var_0 = undefined;

    foreach ( var_2 in self.owner.touchtriggers )
    {
        if ( var_2.useobj.id == "domFlag" )
            var_0 = var_2;
    }

    if ( isdefined( var_0 ) )
    {
        var_4 = var_0 maps\mp\gametypes\dom::getflagteam();

        if ( var_4 != self.team )
        {
            if ( !maps\mp\bots\_bots_gametype_dom::_id_165B( var_0 ) )
                maps\mp\bots\_bots_gametype_dom::_id_1B47( var_0, "critical", 1 );

            return 1;
        }
    }

    return 0;
}
