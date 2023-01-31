// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

saveplayerweaponstatepersistent( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    level.player endon( "death" );

    if ( level.player.health == 0 )
        return;

    var_2 = level.player maps\_utility::get_storable_current_weapon_primary();

    if ( !isdefined( var_2 ) || var_2 == "none" )
    {

    }

    game["weaponstates"][var_0]["current"] = var_2;
    var_3 = level.player _meth_8313();
    var_4 = level.player _meth_8345();
    var_5 = level.player _meth_831A();
    game["weaponstates"][var_0]["offhand"] = var_3;
    game["weaponstates"][var_0]["list"] = [];
    var_6 = common_scripts\utility::array_combine( level.player _meth_830C(), level.player _meth_82CE() );
    var_7 = 0;

    foreach ( var_9 in var_6 )
    {
        if ( level.player maps\_utility::is_unstorable_weapon( var_9 ) )
            continue;

        game["weaponstates"][var_0]["list"][var_7]["name"] = var_6[var_7];
        var_10 = level.player _meth_8317( var_6[var_7] );
        game["weaponstates"][var_0]["list"][var_7]["hybrid_sight_enabled"] = var_10;

        if ( var_6[var_7] == var_4 )
            game["weaponstates"][var_0]["list"][var_7]["isLethal"] = 1;
        else
            game["weaponstates"][var_0]["list"][var_7]["isLethal"] = 0;

        if ( var_6[var_7] == var_5 )
            game["weaponstates"][var_0]["list"][var_7]["isTactical"] = 1;
        else
            game["weaponstates"][var_0]["list"][var_7]["isTactical"] = 0;

        if ( var_1 )
        {
            game["weaponstates"][var_0]["list"][var_7]["clip"] = level.player _meth_82F8( var_6[var_7] );
            game["weaponstates"][var_0]["list"][var_7]["stock"] = level.player _meth_82F9( var_6[var_7] );
        }

        var_7++;
    }
}

restoreplayerweaponstatepersistent( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::ter_op( isdefined( var_2 ) && var_2, ::_meth_8316, ::_meth_8315 );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( game["weaponstates"] ) )
        return 0;

    if ( !isdefined( game["weaponstates"][var_0] ) )
        return 0;

    level.player _meth_8310();
    var_4 = [];

    for ( var_5 = 0; var_5 < game["weaponstates"][var_0]["list"].size; var_5++ )
    {
        var_6 = game["weaponstates"][var_0]["list"][var_5]["name"];

        if ( var_6 == "c4" )
            continue;

        if ( var_6 == "claymore" )
            continue;

        if ( game["weaponstates"][var_0]["list"][var_5]["isLethal"] == 1 )
            level.player _meth_8344( var_6 );

        if ( game["weaponstates"][var_0]["list"][var_5]["isTactical"] == 1 )
            level.player _meth_8319( var_6 );

        level.player _meth_830E( var_6 );
        level.player _meth_8332( var_6 );
        var_7 = game["weaponstates"][var_0]["list"][var_5]["hybrid_sight_enabled"];
        level.player _meth_8440( var_6, var_7 );

        if ( var_1 )
        {
            var_8 = var_4.size;
            var_4[var_8]["name"] = var_6;
            var_4[var_8]["clip"] = game["weaponstates"][var_0]["list"][var_5]["clip"];
            var_4[var_8]["stock"] = game["weaponstates"][var_0]["list"][var_5]["stock"];
        }
    }

    foreach ( var_10 in var_4 )
    {
        level.player _meth_82F6( var_10["name"], var_10["clip"] );
        level.player _meth_82F7( var_10["name"], var_10["stock"] );
    }

    level.player _meth_8318( game["weaponstates"][var_0]["offhand"] );
    level.player call [[ var_3 ]]( game["weaponstates"][var_0]["current"] );
    return 1;
}

setdefaultactionslot()
{
    self _meth_8308( 1, "" );
    self _meth_8308( 2, "" );
    self _meth_8308( 3, "altMode" );
    self _meth_8308( 4, "" );
}

init_player()
{
    setdefaultactionslot();
    self _meth_8310();
}

get_loadout()
{
    if ( isdefined( level.loadout ) )
        return level.loadout;

    return level.script;
}

campaign( var_0 )
{
    level._lc = var_0;
}

persist( var_0, var_1 )
{
    var_2 = get_loadout();

    if ( var_0 != var_2 )
        return;

    if ( !isdefined( game["previous_map"] ) )
        return;

    level._lc_persists = 1;
    restoreplayerweaponstatepersistent( var_1, 1 );
    level.has_loadout = 1;
}

loadout( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_0 ) )
    {
        var_6 = get_loadout();

        if ( var_0 != var_6 || isdefined( level._lc_persists ) )
            return;
    }

    if ( isdefined( var_1 ) )
    {
        level.default_weapon = var_1;
        level.player _meth_830E( var_1 );
    }

    if ( isdefined( var_2 ) )
        level.player _meth_830E( var_2 );

    if ( isdefined( var_3 ) )
    {
        level.player _meth_8344( var_3 );
        level.player _meth_830E( var_3 );
    }

    if ( isdefined( var_4 ) )
    {
        level.player _meth_8319( var_4 );
        level.player _meth_830E( var_4 );
    }

    level.player _meth_8315( var_1 );

    if ( isdefined( var_5 ) )
        level.player _meth_8343( var_5 );

    level.campaign = level._lc;
    level._lc = undefined;
    level.has_loadout = 1;
}

loadout_complete()
{
    level.loadoutcomplete = 1;
    level notify( "loadout complete" );
}

default_loadout_if_notset()
{
    if ( level.has_loadout )
        return;

    loadout( undefined, "iw5_sn6_sp", undefined, "fraggrenade", "flash_grenade", "viewmodel_base_viewhands" );
    level.map_without_loadout = 1;
}
