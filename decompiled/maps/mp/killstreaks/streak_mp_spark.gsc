// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["mp_spark"] = ::tryuseremotesentrydisruptor;
    level.killstreakwieldweapons["iw5_dlcgun12loot3_mp"] = "mp_spark";
    level.mapkillstreak = "mp_spark";
    level.mapkillstreakpickupstring = &"MP_SPARK_MAP_KILLSTREAK_PICKUP";
    level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
    level._effect["turret_distortion"] = loadfx( "vfx/muzzleflash/dlc_sentry_disruptor_wave" );
}

tryuseremotesentrydisruptor( var_0, var_1 )
{
    var_2 = getnumdisruptorturrets();

    if ( var_2 >= 12 )
    {
        self iprintlnbold( &"MP_SPARK_MAP_KILLSTREAK_MAX" );
        return 0;
    }

    return maps\mp\killstreaks\_remoteturret::tryuseremotemgsentryturret( var_0, [ "sentry_disruptor" ] );
}

getnumdisruptorturrets()
{
    var_0 = 0;

    foreach ( var_2 in level.turrets )
    {
        if ( isdefined( var_2.model ) && issubstr( var_2.model, "disruptor" ) )
            var_0++;
    }

    return var_0;
}

setupbotsformapkillstreak()
{
    level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func( "mp_spark", maps\mp\bots\_bots_sentry::bot_killstreak_sentry, undefined, "turret" );
}
