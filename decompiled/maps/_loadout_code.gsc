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
    var_3 = level.player getcurrentoffhand();
    var_4 = level.player getlethalweapon();
    var_5 = level.player gettacticalweapon();
    game["weaponstates"][var_0]["offhand"] = var_3;
    game["weaponstates"][var_0]["list"] = [];
    var_6 = common_scripts\utility::array_combine( level.player getweaponslistprimaries(), level.player getweaponslistoffhands() );
    var_7 = 0;

    foreach ( var_9 in var_6 )
    {
        if ( level.player maps\_utility::is_unstorable_weapon( var_9 ) )
            continue;

        game["weaponstates"][var_0]["list"][var_7]["name"] = var_6[var_7];
        var_10 = level.player gethybridsightenabled( var_6[var_7] );
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
            game["weaponstates"][var_0]["list"][var_7]["clip"] = level.player getweaponammoclip( var_6[var_7] );
            game["weaponstates"][var_0]["list"][var_7]["stock"] = level.player setweaponammostock( var_6[var_7] );
        }

        var_7++;
    }
}

restoreplayerweaponstatepersistent( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::ter_op( isdefined( var_2 ) && var_2, ::switchtoweaponimmediate, ::switchtoweapon );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( game["weaponstates"] ) )
        return 0;

    if ( !isdefined( game["weaponstates"][var_0] ) )
        return 0;

    level.player takeallweapons();
    var_4 = [];

    for ( var_5 = 0; var_5 < game["weaponstates"][var_0]["list"].size; var_5++ )
    {
        var_6 = game["weaponstates"][var_0]["list"][var_5]["name"];

        if ( var_6 == "c4" )
            continue;

        if ( var_6 == "claymore" )
            continue;

        if ( game["weaponstates"][var_0]["list"][var_5]["isLethal"] == 1 )
            level.player setlethalweapon( var_6 );

        if ( game["weaponstates"][var_0]["list"][var_5]["isTactical"] == 1 )
            level.player settacticalweapon( var_6 );

        level.player giveweapon( var_6 );
        level.player givemaxammo( var_6 );
        var_7 = game["weaponstates"][var_0]["list"][var_5]["hybrid_sight_enabled"];
        level.player enablehybridsight( var_6, var_7 );

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
        level.player setweaponammoclip( var_10["name"], var_10["clip"] );
        level.player setweaponammostock( var_10["name"], var_10["stock"] );
    }

    level.player switchtooffhand( game["weaponstates"][var_0]["offhand"] );
    level.player call [[ var_3 ]]( game["weaponstates"][var_0]["current"] );
    return 1;
}

setdefaultactionslot()
{
    self setactionslot( 1, "" );
    self setactionslot( 2, "" );
    self setactionslot( 3, "altMode" );
    self setactionslot( 4, "" );
}

init_player()
{
    setdefaultactionslot();
    self takeallweapons();
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
        level.player giveweapon( var_1 );
    }

    if ( isdefined( var_2 ) )
        level.player giveweapon( var_2 );

    if ( isdefined( var_3 ) )
    {
        level.player setlethalweapon( var_3 );
        level.player giveweapon( var_3 );
    }

    if ( isdefined( var_4 ) )
    {
        level.player settacticalweapon( var_4 );
        level.player giveweapon( var_4 );
    }

    level.player switchtoweapon( var_1 );

    if ( isdefined( var_5 ) )
        level.player setviewmodel( var_5 );

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
