// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakwieldweapons["killstreak_terrace_mp"] = "mp_terrace";
    level.killstreakfuncs["mp_terrace"] = ::_id_98AC;
    level.mapkillstreak = "mp_terrace";
    level._id_598A = &"MP_TERRACE_MAP_KILLSTREAK_PICKUP";
}

_id_98AC( var_0, var_1 )
{
    var_1 = [ "mp_terrace" ];
    return maps\mp\killstreaks\_drone_assault::_id_98A3( var_0, var_1 );
}
