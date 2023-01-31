// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.spectateoverride["allies"] = spawnstruct();
    level.spectateoverride["axis"] = spawnstruct();
    level thread onplayerconnect();
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onjoinedteam();
        var_0 thread onjoinedspectators();
        var_0 thread onspectatingclient();
    }
}

onjoinedteam()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_team" );
        setspectatepermissions();
    }
}

onjoinedspectators()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_spectators" );
        setspectatepermissions();

        if ( !maps\mp\_utility::invirtuallobby() && ( self _meth_8432() || isdefined( self.pers["mlgSpectator"] ) && self.pers["mlgSpectator"] ) )
        {
            self _meth_8506( 1 );

            if ( game["roundsPlayed"] > 0 )
                self _meth_82FB( "ui_use_mlg_hud", 1 );
        }
    }
}

updatemlgicons()
{
    self endon( "disconnect" );

    if ( self _meth_8432() )
    {
        for (;;)
        {
            level waittill( "player_spawned", var_0 );
            var_1 = var_0.spectatorviewloadout;

            if ( isdefined( var_1 ) )
            {
                if ( isdefined( var_1.primary ) )
                    self _meth_8539( var_1.primary );

                if ( isdefined( var_1.secondary ) )
                    self _meth_8539( var_1.secondary );
            }
        }
    }
}

onspectatingclient()
{
    self endon( "disconnect" );
    thread updatemlgicons();

    for (;;)
    {
        self waittill( "spectating_cycle" );
        var_0 = self _meth_829D();

        if ( isdefined( var_0 ) )
        {
            self _meth_82C5( var_0, 6 );

            if ( self _meth_8432() )
                updatespectatedloadout( var_0 );
        }
    }
}

updatespectatesettings()
{
    level endon( "game_ended" );

    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
        level.players[var_0] setspectatepermissions();
}

setspectatepermissions()
{
    var_0 = self.sessionteam;

    if ( level.gameended && gettime() - level.gameendtime >= 2000 )
    {
        if ( level.multiteambased )
        {
            for ( var_1 = 0; var_1 < level.teamnamelist.size; var_1++ )
                self _meth_8273( level.teamnamelist[var_1], 0 );
        }
        else
        {
            self _meth_8273( "allies", 0 );
            self _meth_8273( "axis", 0 );
        }

        self _meth_8273( "freelook", 0 );
        self _meth_8273( "none", 1 );
        return;
    }

    var_2 = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "spectatetype" );
    var_3 = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "lockspectatepov" );

    if ( self _meth_8432() && !maps\mp\_utility::invirtuallobby() )
        var_2 = 2;

    if ( isdefined( level.iszombiegame ) && level.iszombiegame )
        var_2 = 1;

    switch ( var_2 )
    {
        case 0:
            if ( level.multiteambased )
            {
                for ( var_1 = 0; var_1 < level.teamnamelist.size; var_1++ )
                    self _meth_8273( level.teamnamelist[var_1], 0 );
            }
            else
            {
                self _meth_8273( "allies", 0 );
                self _meth_8273( "axis", 0 );
            }

            self _meth_8273( "freelook", 0 );
            self _meth_8273( "none", 0 );
            break;
        case 1:
            if ( !level.teambased )
            {
                self _meth_8273( "allies", 1 );
                self _meth_8273( "axis", 1 );
                self _meth_8273( "none", 1 );
                self _meth_8273( "freelook", 0 );
            }
            else if ( isdefined( var_0 ) && ( var_0 == "allies" || var_0 == "axis" ) && !level.multiteambased )
            {
                self _meth_8273( var_0, 1 );
                self _meth_8273( maps\mp\_utility::getotherteam( var_0 ), 0 );
                self _meth_8273( "freelook", 0 );
                self _meth_8273( "none", 0 );
            }
            else if ( isdefined( var_0 ) && issubstr( var_0, "team_" ) && level.multiteambased )
            {
                for ( var_1 = 0; var_1 < level.teamnamelist.size; var_1++ )
                {
                    if ( var_0 == level.teamnamelist[var_1] )
                    {
                        self _meth_8273( level.teamnamelist[var_1], 1 );
                        continue;
                    }

                    self _meth_8273( level.teamnamelist[var_1], 0 );
                }

                self _meth_8273( "freelook", 0 );
                self _meth_8273( "none", 0 );
            }
            else
            {
                if ( level.multiteambased )
                {
                    for ( var_1 = 0; var_1 < level.teamnamelist.size; var_1++ )
                        self _meth_8273( level.teamnamelist[var_1], 0 );
                }
                else
                {
                    self _meth_8273( "allies", 0 );
                    self _meth_8273( "axis", 0 );
                }

                self _meth_8273( "freelook", 0 );
                self _meth_8273( "none", 0 );
            }

            break;
        case 2:
            if ( level.multiteambased )
            {
                for ( var_1 = 0; var_1 < level.teamnamelist.size; var_1++ )
                    self _meth_8273( level.teamnamelist[var_1], 1 );
            }
            else
            {
                self _meth_8273( "allies", 1 );
                self _meth_8273( "axis", 1 );
            }

            self _meth_8273( "freelook", 1 );
            self _meth_8273( "none", 1 );
            break;
    }

    var_4 = self _meth_8297();

    if ( !self _meth_8432() )
    {
        switch ( var_3 )
        {
            case 0:
                self _meth_8274( var_4, "freelook" );
                break;
            case 1:
                self _meth_8273( "none", 0 );
                self _meth_8273( "freelook", 0 );
                self _meth_8274( var_4, "first_person" );
                break;
            case 2:
                self _meth_8273( "none", 0 );
                self _meth_8273( "freelook", 0 );
                self _meth_8274( var_4, "third_person" );
                break;
        }
    }

    if ( isdefined( var_0 ) && ( var_0 == "axis" || var_0 == "allies" ) )
    {
        if ( isdefined( level.spectateoverride[var_0].allowfreespectate ) )
            self _meth_8273( "freelook", 1 );

        if ( isdefined( level.spectateoverride[var_0].allowenemyspectate ) )
            self _meth_8273( maps\mp\_utility::getotherteam( var_0 ), 1 );
    }
}

updatespectatedloadoutweapon( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
    {
        var_1 = maps\mp\_utility::strip_suffix( var_1, "_mp" );
        var_1 = tablelookuprownum( "mp/statsTable.csv", 4, var_1 );
    }

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    self _meth_82FB( var_0 + "weapon", var_1 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = undefined;

        if ( isdefined( var_2[var_3] ) )
        {
            var_4 = maps\mp\_utility::attachmentmap_tobase( var_2[var_3] );
            var_4 = tablelookuprownum( "mp/attachmentTable.csv", 3, var_4 );
        }

        if ( !isdefined( var_4 ) )
            var_4 = 0;

        self _meth_82FB( var_0 + "attachment_" + var_3, var_4 );
    }
}

updatespectatedloadout( var_0 )
{
    var_1 = var_0.spectatorviewloadout;
    updatespectatedloadoutweapon( "ui_mlg_loadout_primary_", var_1.primary, [ var_1.primaryattachment, var_1.primaryattachment2, var_1.primaryattachment3 ] );
    updatespectatedloadoutweapon( "ui_mlg_loadout_secondary_", var_1.secondary, [ var_1.secondaryattachment, var_1.secondaryattachment2 ] );
    var_2 = var_1.offhand;

    if ( isdefined( var_2 ) )
        var_2 = tablelookuprownum( "mp/perkTable.csv", 1, var_2 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    self _meth_82FB( "ui_mlg_loadout_equipment_0", var_2 );
    var_3 = var_1.equipment;

    if ( isdefined( var_3 ) )
        var_3 = tablelookuprownum( "mp/perkTable.csv", 1, var_3 );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    self _meth_82FB( "ui_mlg_loadout_equipment_1", var_3 );

    if ( var_1.equipmentextra )
        self _meth_82FB( "ui_mlg_loadout_equipment_2", var_3 );
    else
        self _meth_82FB( "ui_mlg_loadout_equipment_2", -1 );

    var_4 = [ var_1.killstreak1, var_1.killstreak2, var_1.killstreak3, var_1.killstreak4 ];

    for ( var_5 = 0; var_5 < 4; var_5++ )
    {
        var_6 = var_4[var_5];

        if ( isdefined( var_6 ) )
            var_6 = tablelookuprownum( "mp/killstreakTable.csv", 1, var_6 );

        if ( !isdefined( var_6 ) )
            var_7 = 0;

        self _meth_82FB( "ui_mlg_loadout_streak_" + var_5, var_6 );
    }

    for ( var_5 = 0; var_5 < 6; var_5++ )
    {
        var_8 = var_1.perks[var_5];

        if ( isdefined( var_8 ) )
            var_8 = tablelookuprownum( "mp/perkTable.csv", 1, var_8 );

        if ( !isdefined( var_8 ) )
            var_8 = 0;

        self _meth_82FB( "ui_mlg_loadout_perk_" + var_5, var_8 );
    }
}
