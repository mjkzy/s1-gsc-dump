// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakwieldweapons["killstreak_terrace_mp"] = "mp_terrace";
    level.killstreakfuncs["mp_terrace"] = ::tryusekillstreak;
    level.mapkillstreak = "mp_terrace";
    level.mapkillstreakpickupstring = &"MP_TERRACE_MAP_KILLSTREAK_PICKUP";
}

tryusekillstreak( var_0, var_1 )
{
    var_1 = [ "mp_terrace" ];
    return maps\mp\killstreaks\_drone_assault::tryuseassaultdrone( var_0, var_1 );
}
