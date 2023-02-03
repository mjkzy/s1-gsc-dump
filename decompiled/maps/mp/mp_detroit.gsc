// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_detroit_precache::main();
    maps\createart\mp_detroit_art::main();
    maps\mp\mp_detroit_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_detroit_lighting::main();
    maps\mp\mp_detroit_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_detroit" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    maps\mp\_water::setshallowwaterweapon( "iw5_underwater_mp" );
    maps\mp\_water::init();
    level.ospvisionset = "(mp_detroit_osp)";
    level.osplightset = "(mp_detroit_osp)";
    level.dronevisionset = "(mp_detroit_drone)";
    level.dronelightset = "(mp_detroit_drone)";
    level.warbirdvisionset = "(mp_detroit_warbird)";
    level.warbirdlightset = "(mp_detroit_warbird)";
    level.aerial_pathnode_offset = 425;
    level thread maps\mp\mp_detroit_events::trams();
    level.mapcustomkillstreakfunc = ::detroitcustomkillstreakfunc;
    level.orbitalsupportoverridefunc = ::detroitpaladinoverrides;
    level thread detroitstrikeheightoverrides();
    level thread detroitpatchclip();
    thread set_lighting_values();
}

detroitstrikeheightoverrides()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 2500;
    setdvar( "bg_bombingRunNoMissileClip", 1 );
}

detroitpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnanglemin = 220;
    level.orbitalsupportoverrides.spawnanglemax = 260;

    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.leftarc = 15;
        level.orbitalsupportoverrides.rightarc = 15;
        level.orbitalsupportoverrides.toparc = -35;
        level.orbitalsupportoverrides.bottomarc = 55;
    }
}

detroitcustomkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_detroit::init();
}

detroitpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1440.64, -10.0738, 697.5 ), ( 0, 353.054, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1440.64, -10.0738, 569.5 ), ( 0, 353.054, 0 ) );
}

set_lighting_values()
{
    if ( isusinghdr() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0" );
        }
    }
}
