// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
}

_id_806C()
{
    level._id_0897["player"]["think"] = ::_id_089C;
}

_id_089C()
{
    common_scripts\utility::_enableusability();

    foreach ( var_1 in level.bombzones )
        var_1.trigger enableplayeruse( self );

    thread maps\mp\bots\_bots_gametype_sd::_id_16D8();
}
