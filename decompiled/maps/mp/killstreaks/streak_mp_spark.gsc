// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["mp_spark"] = ::tryuseremotesentrydisruptor;
    level.killstreakwieldweapons["iw5_dlcgun12loot3_mp"] = "mp_spark";
    level.mapkillstreak = "mp_spark";
    level._id_598A = &"MP_SPARK_MAP_KILLSTREAK_PICKUP";
    level._id_5984 = ::_id_82FA;
    level._effect["turret_distortion"] = loadfx( "vfx/muzzleflash/dlc_sentry_disruptor_wave" );
}

tryuseremotesentrydisruptor( var_0, var_1 )
{
    var_2 = getnumdisruptorturrets();

    if ( var_2 >= 12 )
    {
        self iclientprintlnbold( &"MP_SPARK_MAP_KILLSTREAK_MAX" );
        return 0;
    }

    return maps\mp\killstreaks\_remoteturret::_id_98BF( var_0, [ "sentry_disruptor" ] );
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

_id_82FA()
{
    level thread maps\mp\bots\_bots_ks::_id_16CC( "mp_spark", maps\mp\bots\_bots_sentry::_id_1679, undefined, "turret" );
}
