// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    _id_4D65();
    _id_4CC2();
    _id_4CBA();
    _id_4CBD();
    _id_4CBC();
    _id_4CBB();
    level._id_16A3 = [];
    level._id_1695 = 1;
}

_id_4CC2()
{
    var_0 = "mp/botClassTable.csv";
    level._id_1741 = [];
    var_1 = _id_168C();
    var_2 = 0;

    for (;;)
    {
        var_2++;
        var_3 = tablelookup( var_0, 0, "botPersonalities", var_2 );
        var_4 = tablelookup( var_0, 0, "botDifficulties", var_2 );

        if ( !isdefined( var_3 ) || var_3 == "" )
            break;

        if ( !isdefined( var_4 ) || var_4 == "" )
            break;

        var_5 = [];

        foreach ( var_7 in var_1 )
            var_5[var_7] = tablelookup( var_0, 0, var_7, var_2 );

        var_9 = strtok( var_3, "| " );
        var_10 = strtok( var_4, "| " );

        foreach ( var_12 in var_9 )
        {
            foreach ( var_14 in var_10 )
            {
                var_15 = _id_1691( var_12, var_14, 1 );
                var_16 = spawnstruct();
                var_16._id_57E4 = var_5;
                var_15.loadouts[var_15.loadouts.size] = var_16;
            }
        }
    }
}

_id_4D65()
{
    var_0 = "mp/botTemplateTable.csv";
    level._id_1742 = [];
    var_1 = _id_168C();
    var_2 = 0;

    for (;;)
    {
        var_2++;
        var_3 = tablelookup( var_0, 0, "template_", var_2 );

        if ( !isdefined( var_3 ) || var_3 == "" )
            break;

        var_4 = "template_" + var_3;
        level._id_1742[var_4] = [];

        foreach ( var_6 in var_1 )
        {
            var_7 = tablelookup( var_0, 0, var_6, var_2 );

            if ( isdefined( var_7 ) && var_7 != "" )
                level._id_1742[var_4][var_6] = var_7;
        }
    }
}

_id_15E8()
{
    if ( isusingmatchrulesdata() && !getmatchrulesdata( "commonOption", "allowCustomClasses" ) )
        return 0;

    return 1;
}

_id_168E( var_0, var_1, var_2 )
{
    if ( !isusingmatchrulesdata() )
        return 1;

    if ( !_id_15E8() )
        return 0;

    if ( var_1 == "specialty_null" )
        return 1;

    if ( var_1 == "none" )
        return 1;

    var_3 = var_0 + "Restricted";
    var_4 = var_0 + "ClassRestricted";
    var_5 = "";

    switch ( var_0 )
    {
        case "weapon":
            var_5 = maps\mp\_utility::getweaponclass( var_1 );
            break;
        case "attachment":
            var_5 = maps\mp\_utility::getattachmenttype( var_1 );
            break;
        case "killstreak":
            if ( getmatchrulesdata( "commonOption", "allStreaksRestricted" ) )
                return 0;

            break;
        case "module":
            var_5 = maps\mp\killstreaks\_killstreaks::getstreakmodulebasekillstreak( var_1 );

            if ( getsubstr( var_5, 0, 3 ) == "zm_" )
                return 0;

            break;
        case "perk":
            var_5 = var_2;
            break;
        default:
            return 0;
    }

    if ( getmatchrulesdata( "commonOption", var_3, var_1 ) )
        return 0;

    if ( var_5 != "" && getmatchrulesdata( "commonOption", var_4, var_5 ) )
        return 0;

    return 1;
}

_id_1682( var_0 )
{
    var_1 = "none";
    var_2 = [ "veteran", "hardened", "regular", "recruit" ];
    var_2 = common_scripts\utility::array_randomize( var_2 );

    foreach ( var_4 in var_2 )
    {
        var_1 = _id_1689( "weap_statstable", var_0, "loadoutPrimary", self._id_67DC, var_4 );

        if ( var_1 != "none" )
            return var_1;
    }

    if ( isdefined( level._id_16B1 ) )
    {
        var_6 = common_scripts\utility::array_randomize( level._id_16B1 );

        foreach ( var_8 in var_6 )
        {
            foreach ( var_4 in var_2 )
            {
                var_1 = _id_1689( "weap_statstable", var_0, "loadoutPrimary", var_8, var_4 );

                if ( var_1 != "none" )
                {
                    self._id_1609 = var_8;
                    return var_1;
                }
            }
        }
    }

    if ( isusingmatchrulesdata() )
    {
        var_12 = 0.0;
        var_13 = 0;

        for ( var_14 = "none"; var_13 < 6; var_13++ )
        {
            if ( getmatchrulesdata( "defaultClasses", _id_1693(), var_13, "class", "inUse" ) )
            {
                var_1 = _id_1685( var_13, "loadoutPrimary" );

                if ( var_1 != "none" )
                {
                    var_12 += 1.0;

                    if ( randomfloat( 1.0 ) >= 1.0 / var_12 )
                        var_14 = var_1;
                }
            }
        }

        if ( var_14 != "none" )
        {
            self._id_1609 = "weapon";
            return var_14;
        }
    }

    self._id_1609 = "weapon";
    return level._id_160A;
}

_id_1693()
{
    if ( !isdefined( level.teambased ) || !level.teambased )
        return "allies";

    return maps\mp\bots\_bots::_id_163A();
}

_id_15EA()
{
    var_0 = [ "class1", "class2", "class3", "class4", "class5" ];

    if ( isusingmatchrulesdata() )
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        {
            if ( getmatchrulesdata( "defaultClasses", _id_1693(), var_1, "class", "inUse" ) )
                var_0[var_1] = var_1;
        }
    }

    var_2 = common_scripts\utility::random( var_0 );
    var_3 = [];

    foreach ( var_5 in level._id_168C )
    {
        if ( isstring( var_2 ) )
        {
            var_3[var_5] = _id_1686( var_2, var_5 );
            continue;
        }

        var_3[var_5] = _id_1685( var_2, var_5 );
    }

    return var_3;
}

_id_16B5( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_1 = level._id_1738[var_0];

        if ( isdefined( var_1 ) )
        {
            var_2 = strtok( var_1, "| " );

            if ( var_2.size > 0 )
                maps\mp\bots\_bots_util::_id_16ED( common_scripts\utility::random( var_2 ) );
        }
    }
}

_id_1692( var_0, var_1 )
{
    if ( var_0["loadoutWildcard1"] == var_1 )
        return 1;

    if ( var_0["loadoutWildcard2"] == var_1 )
        return 1;

    if ( var_0["loadoutWildcard3"] == var_1 )
        return 1;

    return 0;
}

_id_168C()
{
    var_0 = "mp/botClassTable.csv";

    if ( !isdefined( level._id_168C ) )
    {
        level._id_168C = [];
        level._id_168C[0] = "loadoutWildcard1";
        level._id_168C[1] = "loadoutWildcard2";
        level._id_168C[2] = "loadoutWildcard3";
        var_1 = 2;

        for (;;)
        {
            var_2 = tablelookupbyrow( var_0, var_1, 0 );

            if ( var_2 == "" )
                break;

            if ( !issubstr( var_2, "Wildcard" ) )
                level._id_168C[level._id_168C.size] = var_2;

            var_1++;
        }
    }

    return level._id_168C;
}

_id_1691( var_0, var_1, var_2 )
{
    var_3 = var_1 + "_" + var_0;

    if ( !isdefined( level._id_1741 ) )
        level._id_1741 = [];

    if ( !isdefined( level._id_1741[var_3] ) && var_2 )
    {
        level._id_1741[var_3] = spawnstruct();
        level._id_1741[var_3].loadouts = [];
    }

    if ( isdefined( level._id_1741[var_3] ) )
        return level._id_1741[var_3];
}

_id_1690( var_0, var_1 )
{
    var_2 = _id_1691( var_0, var_1, 0 );

    if ( isdefined( var_2 ) && isdefined( var_2.loadouts ) && var_2.loadouts.size > 0 )
    {
        var_3 = randomint( var_2.loadouts.size );
        return var_2.loadouts[var_3]._id_57E4;
    }
}

_id_1728( var_0, var_1, var_2, var_3 )
{
    var_4 = [];
    var_5 = 0;

    if ( isdefined( level._id_1737[var_0] ) && level._id_1737[var_0] != "none" )
    {
        var_4[var_4.size] = level._id_1737[var_0];
        var_5++;
    }

    if ( isdefined( var_1 ) && var_1 != "none" )
        var_4[var_4.size] = var_1;

    if ( isdefined( var_2 ) && var_2 != "none" )
        var_4[var_4.size] = var_2;

    if ( isdefined( var_3 ) && var_3 != "none" )
        var_4[var_4.size] = var_3;

    var_6 = maps\mp\_utility::getweaponattachmentarrayfromstats( var_0 );

    for ( var_7 = var_5; var_7 < var_4.size; var_7++ )
    {
        var_8 = maps\mp\_utility::attachmentmap_tobase( var_4[var_7] );

        if ( var_8 != var_4[var_7] )
            return 0;

        if ( !_id_168E( "attachment", var_4[var_7], undefined ) )
            return 0;

        if ( !common_scripts\utility::array_contains( var_6, var_4[var_7] ) )
            return 0;

        var_9 = 0;

        for ( var_10 = var_7 - 1; var_10 >= 0; var_10-- )
        {
            if ( var_4[var_7] == var_4[var_10] )
            {
                var_9++;

                if ( var_9 == 1 )
                {
                    if ( !isdefined( level._id_0A9F[var_4[var_7]] ) )
                        return 0;
                }
                else if ( var_9 > 1 )
                    return 0;
            }
            else if ( isdefined( level._id_1658[var_4[var_7]] ) )
            {
                if ( isdefined( level._id_1658[var_4[var_7]][var_4[var_10]] ) )
                    return 0;
            }
        }
    }

    return 1;
}

_id_1727( var_0, var_1, var_2 )
{
    if ( !maps\mp\gametypes\_class::isvalidreticle( var_2, 1 ) )
        return 0;

    var_3 = [ "Attachment", "Attachment2", "Attachment3" ];

    foreach ( var_5 in var_3 )
    {
        var_6 = var_0 + var_5;
        var_7 = var_1[var_6];

        if ( isdefined( var_7 ) && isdefined( level._id_15AE[var_7] ) )
            return 1;
    }

    return 0;
}

_id_4CBD()
{
    var_0 = "mp/statstable.csv";
    var_1 = 4;
    var_2 = 57;
    var_3 = 58;
    var_4 = 40;
    level._id_1739 = [];
    level._id_1738 = [];
    level._id_1737 = [];
    level._id_1738["iw5_combatknife"] = "cqb";
    var_5 = 1;

    for (;;)
    {
        var_6 = tablelookupbyrow( var_0, var_5, 0 );

        if ( var_6 == "" )
            break;

        var_7 = tablelookupbyrow( var_0, var_5, var_1 );
        var_8 = tablelookupbyrow( var_0, var_5, var_3 );
        var_9 = tablelookupbyrow( var_0, var_5, var_2 );

        if ( var_7 != "" && var_9 != "" )
            level._id_1738[var_7] = var_9;

        if ( var_8 != "" && var_7 != "" && var_9 != "" )
        {
            var_10 = var_7;

            if ( maps\mp\_utility::islootweapon( var_7 ) )
                var_10 = maps\mp\gametypes\_class::getbasefromlootversion( var_7 );

            var_11 = "loadoutPrimary";

            if ( maps\mp\gametypes\_class::isvalidsecondary( var_10, 0 ) )
                var_11 = "loadoutSecondary";
            else if ( !maps\mp\gametypes\_class::isvalidprimary( var_10 ) )
            {
                var_5++;
                continue;
            }

            if ( !isdefined( level._id_1739[var_11] ) )
                level._id_1739[var_11] = [];

            var_17 = strtok( var_9, "| " );
            var_18 = strtok( var_8, "| " );

            foreach ( var_20 in var_17 )
            {
                if ( !isdefined( level._id_1739[var_11][var_20] ) )
                    level._id_1739[var_11][var_20] = [];

                foreach ( var_22 in var_18 )
                {
                    if ( !isdefined( level._id_1739[var_11][var_20][var_22] ) )
                        level._id_1739[var_11][var_20][var_22] = [];

                    var_23 = level._id_1739[var_11][var_20][var_22].size;
                    level._id_1739[var_11][var_20][var_22][var_23] = var_7;
                }
            }

            var_26 = tablelookupbyrow( var_0, var_5, var_4 );

            if ( var_26 != "" )
                level._id_1737[var_7] = var_26;
        }

        var_5++;
    }
}

_id_1689( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";

    if ( var_3 == "default" )
        var_3 = "run_and_gun";

    var_6 = var_2;

    if ( var_6 == "loadoutSecondary" && _id_1692( var_1, "specialty_wildcard_dualprimaries" ) )
    {
        var_6 = "loadoutPrimary";

        if ( var_3 == "camper" || var_3 == "run_and_gun" )
            var_3 = "cqb";
        else if ( var_3 == "cqb" )
            var_3 = "run_and_gun";
    }

    if ( !isdefined( level._id_1739 ) )
        return var_5;

    if ( !isdefined( level._id_1739[var_6] ) )
        return var_5;

    if ( !isdefined( level._id_1739[var_6][var_3] ) )
        return var_5;

    if ( !isdefined( level._id_1739[var_6][var_3][var_4] ) )
        return var_5;

    var_5 = _id_1688( level._id_1739[var_6][var_3][var_4], var_0, var_1, var_2 );
    return var_5;
}

_id_1726( var_0, var_1, var_2 )
{
    var_3 = "Perk_Slot1";

    if ( var_1 == "loadoutPerk3" || var_1 == "loadoutPerk4" )
        var_3 = "Perk_Slot2";
    else if ( var_1 == "loadoutPerk5" || var_1 == "loadoutPerk6" )
        var_3 = "Perk_Slot3";

    if ( !_id_168E( "perk", var_0, var_3 ) )
        return 0;

    var_4 = int( getsubstr( var_1, 11 ) );
    var_5 = "";

    if ( var_4 == 2 )
        var_5 = "specialty_wildcard_perkslot1";
    else if ( var_4 == 4 )
        var_5 = "specialty_wildcard_perkslot2";
    else if ( var_4 == 6 )
        var_5 = "specialty_wildcard_perkslot3";

    if ( var_5 != "" )
    {
        if ( !_id_1692( var_2, var_5 ) )
            return 0;
    }

    for ( var_6 = var_4 - 1; var_6 > 0; var_6-- )
    {
        var_7 = "loadoutPerk" + var_6;

        if ( var_2[var_7] == "none" || var_2[var_7] == "specialty_null" )
            continue;

        if ( var_0 == var_2[var_7] )
            return 0;
    }

    return 1;
}

_id_1686( var_0, var_1 )
{
    var_2 = int( getsubstr( var_0, 5, 6 ) ) - 1;

    switch ( var_1 )
    {
        case "loadoutPrimary":
            return maps\mp\gametypes\_class::table_getweapon( level.classtablename, var_2, 0 );
        case "loadoutPrimaryAttachment":
            return maps\mp\gametypes\_class::table_getweaponattachment( level.classtablename, var_2, 0, 0 );
        case "loadoutPrimaryAttachment2":
            return maps\mp\gametypes\_class::table_getweaponattachment( level.classtablename, var_2, 0, 1 );
        case "loadoutPrimaryAttachment3":
            return maps\mp\gametypes\_class::table_getweaponattachment( level.classtablename, var_2, 0, 2 );
        case "loadoutPrimaryCamo":
            return maps\mp\gametypes\_class::table_getweaponcamo( level.classtablename, var_2, 0 );
        case "loadoutPrimaryReticle":
            return maps\mp\gametypes\_class::table_getweaponreticle( level.classtablename, var_2, 0 );
        case "loadoutSecondary":
            return maps\mp\gametypes\_class::table_getweapon( level.classtablename, var_2, 1 );
        case "loadoutSecondaryAttachment":
            return maps\mp\gametypes\_class::table_getweaponattachment( level.classtablename, var_2, 1, 0 );
        case "loadoutSecondaryAttachment2":
            return maps\mp\gametypes\_class::table_getweaponattachment( level.classtablename, var_2, 1, 1 );
        case "loadoutSecondaryAttachment3":
            return maps\mp\gametypes\_class::table_getweaponattachment( level.classtablename, var_2, 1, 2 );
        case "loadoutSecondaryCamo":
            return maps\mp\gametypes\_class::table_getweaponcamo( level.classtablename, var_2, 1 );
        case "loadoutSecondaryReticle":
            return maps\mp\gametypes\_class::table_getweaponreticle( level.classtablename, var_2, 1 );
        case "loadoutEquipment":
            return maps\mp\gametypes\_class::table_getequipment( level.classtablename, var_2 );
        case "loadoutEquipment2":
            return tablelookup( level.classtablename, 0, "loadoutEquipment2", var_2 + 1 );
        case "loadoutOffhand":
            return maps\mp\gametypes\_class::table_getoffhand( level.classtablename, var_2 );
        case "loadoutOffhand2":
            if ( maps\mp\gametypes\_class::table_getoffhandextra( level.classtablename, var_2 ) )
                return maps\mp\gametypes\_class::table_getoffhand( level.classtablename, var_2 );
            else
                return "specialty_null";
        case "loadoutStreak1":
            return maps\mp\gametypes\_class::table_getkillstreak( level.classtablename, var_2, 0 );
        case "loadoutStreakModule1a":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 0, 0 );
        case "loadoutStreakModule1b":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 0, 1 );
        case "loadoutStreakModule1c":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 0, 2 );
        case "loadoutStreak2":
            return maps\mp\gametypes\_class::table_getkillstreak( level.classtablename, var_2, 1 );
        case "loadoutStreakModule2a":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 1, 0 );
        case "loadoutStreakModule2b":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 1, 1 );
        case "loadoutStreakModule2c":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 1, 2 );
        case "loadoutStreak3":
            return maps\mp\gametypes\_class::table_getkillstreak( level.classtablename, var_2, 2 );
        case "loadoutStreakModule3a":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 2, 0 );
        case "loadoutStreakModule3b":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 2, 1 );
        case "loadoutStreakModule3c":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 2, 2 );
        case "loadoutStreak4":
            return maps\mp\gametypes\_class::table_getkillstreak( level.classtablename, var_2, 3 );
        case "loadoutStreakModule4a":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 3, 0 );
        case "loadoutStreakModule4b":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 3, 1 );
        case "loadoutStreakModule4c":
            return maps\mp\gametypes\_class::table_getkillstreakmodule( level.classtablename, var_2, 3, 2 );
        case "loadoutPerk3":
        case "loadoutPerk4":
        case "loadoutPerk5":
        case "loadoutPerk6":
        case "loadoutPerk1":
        case "loadoutPerk2":
            var_3 = int( getsubstr( var_1, 11 ) ) - 1;
            var_4 = maps\mp\gametypes\_class::table_getperk( level.classtablename, var_2, var_3 );

            if ( var_4 == "" )
                return "specialty_null";

            return var_4;
        case "loadoutWildcard1":
            return maps\mp\gametypes\_class::table_getwildcard( level.classtablename, var_2, 0 );
        case "loadoutWildcard2":
            return maps\mp\gametypes\_class::table_getwildcard( level.classtablename, var_2, 1 );
        case "loadoutWildcard3":
            return maps\mp\gametypes\_class::table_getwildcard( level.classtablename, var_2, 2 );
    }

    return var_0;
}

_id_1685( var_0, var_1 )
{
    var_2 = _id_1693();

    switch ( var_1 )
    {
        case "loadoutPrimary":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "weapon" );
        case "loadoutPrimaryAttachment":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "attachment", 0 );
        case "loadoutPrimaryAttachment2":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "attachment", 1 );
        case "loadoutPrimaryAttachment3":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "attachment", 2 );
        case "loadoutPrimaryCamo":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "camo" );
        case "loadoutPrimaryReticle":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 0, "reticle" );
        case "loadoutSecondary":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "weapon" );
        case "loadoutSecondaryAttachment":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "attachment", 0 );
        case "loadoutSecondaryAttachment2":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "attachment", 1 );
        case "loadoutSecondaryAttachment3":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "attachment", 2 );
        case "loadoutSecondaryCamo":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "camo" );
        case "loadoutSecondaryReticle":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "weaponSetups", 1, "reticle" );
        case "loadoutEquipment":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "equipmentSetups", 0, "equipment" );
        case "loadoutEquipment2":
            if ( getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "equipmentSetups", 0, "extra" ) )
                return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "equipmentSetups", 0, "equipment" );
            else
                return "specialty_null";
        case "loadoutOffhand":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "equipmentSetups", 1, "equipment" );
        case "loadoutOffhand2":
            return "specialty_null";
        case "loadoutStreak1":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "streak" );
        case "loadoutStreakModule1a":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "modules", 0 );
        case "loadoutStreakModule1b":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "modules", 1 );
        case "loadoutStreakModule1c":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 0, "modules", 2 );
        case "loadoutStreak2":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "streak" );
        case "loadoutStreakModule2a":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "modules", 0 );
        case "loadoutStreakModule2b":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "modules", 1 );
        case "loadoutStreakModule2c":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 1, "modules", 2 );
        case "loadoutStreak3":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "streak" );
        case "loadoutStreakModule3a":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "modules", 0 );
        case "loadoutStreakModule3b":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "modules", 1 );
        case "loadoutStreakModule3c":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 2, "modules", 2 );
        case "loadoutStreak4":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "streak" );
        case "loadoutStreakModule4a":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "modules", 0 );
        case "loadoutStreakModule4b":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "modules", 1 );
        case "loadoutStreakModule4c":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "assaultStreaks", 3, "modules", 2 );
        case "loadoutPerk1":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "perkSlots", 0 );
        case "loadoutPerk2":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "perkSlots", 1 );
        case "loadoutPerk3":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "perkSlots", 2 );
        case "loadoutPerk4":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "perkSlots", 3 );
        case "loadoutPerk5":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "perkSlots", 4 );
        case "loadoutPerk6":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "perkSlots", 5 );
        case "loadoutWildcard1":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "wildcardSlots", 0 );
        case "loadoutWildcard2":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "wildcardSlots", 1 );
        case "loadoutWildcard3":
            return getmatchrulesdata( "defaultClasses", var_2, var_0, "class", "wildcardSlots", 2 );
        default:
    }

    return "none";
}

_id_4CBA()
{
    var_0 = "mp/attachmenttable.csv";
    var_1 = 3;
    var_2 = 15;
    var_3 = 7;
    level._id_15AF = [];
    level._id_15AE = [];
    var_4 = 1;

    for (;;)
    {
        var_5 = tablelookupbyrow( var_0, var_4, var_1 );

        if ( var_5 == "done" )
            break;

        var_6 = tablelookupbyrow( var_0, var_4, var_2 );

        if ( var_5 != "" && var_6 != "" )
        {
            var_7 = tablelookupbyrow( var_0, var_4, var_3 );

            if ( var_7 == "TRUE" )
                level._id_15AE[var_5] = 1;

            var_8 = strtok( var_6, "| " );

            foreach ( var_10 in var_8 )
            {
                if ( !isdefined( level._id_15AF[var_10] ) )
                    level._id_15AF[var_10] = [];

                if ( !common_scripts\utility::array_contains( level._id_15AF[var_10], var_5 ) )
                {
                    var_11 = level._id_15AF[var_10].size;
                    level._id_15AF[var_10][var_11] = var_5;
                }
            }
        }

        var_4++;
    }

    level._id_1658 = [];
    level._id_0A9F = [];
    var_13 = "mp/attachmentcombos.csv";
    var_14 = 0;

    for (;;)
    {
        var_14++;
        var_15 = tablelookupbyrow( var_13, 0, var_14 );

        if ( var_15 == "" )
            break;

        var_4 = 0;

        for (;;)
        {
            var_4++;
            var_16 = tablelookupbyrow( var_13, var_4, 0 );

            if ( var_16 == "" )
                break;

            if ( var_16 == var_15 )
            {
                if ( tablelookupbyrow( var_13, var_4, var_14 ) != "no" )
                    level._id_0A9F[var_16] = 1;

                continue;
            }

            if ( tablelookupbyrow( var_13, var_4, var_14 ) == "no" )
                level._id_1658[var_15][var_16] = 1;
        }
    }
}

_id_1683( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";

    if ( !isdefined( level._id_15AF ) )
        return var_5;

    if ( !isdefined( level._id_15AF[var_4] ) )
        return var_5;

    var_5 = _id_1688( level._id_15AF[var_4], var_0, var_1, var_2 );
    return var_5;
}

_id_4CBC()
{
    var_0 = "mp/reticletable.csv";
    var_1 = 1;
    var_2 = 8;
    level._id_16D1 = [];
    var_3 = 0;

    for (;;)
    {
        var_4 = tablelookupbyrow( var_0, var_3, var_1 );

        if ( !isdefined( var_4 ) || var_4 == "" )
            break;

        var_5 = tablelookupbyrow( var_0, var_3, var_2 );

        if ( isdefined( var_5 ) && int( var_5 ) )
            level._id_16D1[level._id_16D1.size] = var_4;

        var_3++;
    }
}

_id_1687( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";

    if ( !isdefined( level._id_16D1 ) )
        return var_5;

    var_6 = randomint( 100 ) > 50;

    if ( var_6 )
        var_5 = _id_1688( level._id_16D1, var_0, var_1, var_2 );

    return var_5;
}

_id_4CBB()
{
    var_0 = "mp/camotable.csv";
    var_1 = 1;
    var_2 = 8;
    var_3 = 9;
    var_4 = 11;
    level._id_15C2 = [];
    var_5 = 0;

    for (;;)
    {
        var_6 = tablelookupbyrow( var_0, var_5, var_1 );

        if ( !isdefined( var_6 ) || var_6 == "" )
            break;

        var_7 = int( tablelookupbyrow( var_0, var_5, var_4 ) );
        var_8 = tablelookupbyrow( var_0, var_5, var_2 );

        if ( isdefined( var_8 ) && var_8 != "" && !var_7 )
        {
            var_9 = tablelookupbyrow( var_0, var_5, var_3 );

            if ( isdefined( var_9 ) && int( var_9 ) )
                level._id_15C2[level._id_15C2.size] = var_6;
        }

        var_5++;
    }
}

_id_1684( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";

    if ( !isdefined( level._id_15C2 ) )
        return var_5;

    var_6 = randomint( 100 ) > 50;

    if ( var_6 )
        var_5 = _id_1688( level._id_15C2, var_0, var_1, var_2 );

    return var_5;
}

_id_168F( var_0, var_1, var_2 )
{
    if ( !isplayer( self ) )
        return 1;

    if ( !isdefined( level._id_16A3[var_1] ) )
    {
        var_3 = "mp/unlockTable.csv";
        var_4 = tablelookuprownum( var_3, 0, var_1 );
        level._id_16A3[var_1] = int( tablelookupbyrow( var_3, var_4, 2 ) );
    }

    if ( var_0 == "classtable_any" && var_2 == "recruit" )
        return 1;

    if ( !isdefined( self._id_7133 ) )
    {
        if ( var_2 == "recruit" )
            self._id_7133 = 3;
        else
        {
            self._id_7133 = self.pers["rank"];

            if ( !isdefined( self._id_7133 ) )
                self._id_7133 = level._id_16D3[var_2][0];
        }
    }

    if ( level._id_16A3[var_1] <= self._id_7133 )
        return 1;

    return 0;
}

_id_1694( var_0, var_1, var_2, var_3 )
{
    var_4 = 1;

    switch ( var_2 )
    {
        case "loadoutPrimary":
            var_5 = var_3;

            if ( maps\mp\_utility::islootweapon( var_5 ) )
                var_5 = maps\mp\gametypes\_class::getbasefromlootversion( var_5 );

            var_4 = _id_168E( "weapon", var_5, undefined );
            var_4 = var_4 && maps\mp\gametypes\_class::isvalidprimary( var_3 );
            break;
        case "loadoutEquipment":
            var_4 = _id_168E( "perk", var_3, "Lethal" );
            var_4 = var_4 && maps\mp\gametypes\_class::isvalidequipment( var_3, _id_1692( var_1, "specialty_wildcard_dualtacticals" ) );
            var_4 = var_4 && _id_168F( var_0, var_3, self _meth_836B() );
            break;
        case "loadoutEquipment2":
            var_4 = var_3 == "specialty_null" || var_3 == var_1["loadoutEquipment"];
            break;
        case "loadoutOffhand":
            var_4 = _id_168E( "perk", var_3, "Tactical" );
            var_4 = var_4 && maps\mp\gametypes\_class::isvalidoffhand( var_3, _id_1692( var_1, "specialty_wildcard_duallethals" ) );
            var_4 = var_4 && _id_168F( var_0, var_3, self _meth_836B() );
            break;
        case "loadoutOffhand2":
            var_4 = var_3 == "specialty_null";
            break;
        case "loadoutPrimaryAttachment":
            var_4 = _id_1728( var_1["loadoutPrimary"], var_3 );
            break;
        case "loadoutPrimaryAttachment2":
            var_4 = _id_1728( var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_3 );
            break;
        case "loadoutPrimaryAttachment3":
            var_4 = _id_1728( var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_1["loadoutPrimaryAttachment2"], var_3 );
            break;
        case "loadoutPrimaryReticle":
            var_4 = _id_1727( "loadoutPrimary", var_1, var_3 );
            break;
        case "loadoutPrimaryCamo":
            var_4 = !isdefined( self._id_173F ) || var_3 == self._id_173F;
            var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo( var_3 );
            break;
        case "loadoutSecondary":
            var_4 = var_3 != var_1["loadoutPrimary"];
            var_5 = var_3;

            if ( maps\mp\_utility::islootweapon( var_5 ) )
                var_5 = maps\mp\gametypes\_class::getbasefromlootversion( var_5 );

            var_4 = var_4 && _id_168E( "weapon", var_5, undefined );
            var_4 = var_4 && maps\mp\gametypes\_class::isvalidsecondary( var_3, _id_1692( var_1, "specialty_wildcard_dualprimaries" ) );
            break;
        case "loadoutSecondaryAttachment":
            var_4 = _id_1728( var_1["loadoutSecondary"], var_3, "none" );
            break;
        case "loadoutSecondaryAttachment2":
            var_4 = _id_1728( var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_3 );
            break;
        case "loadoutSecondaryAttachment3":
            var_4 = _id_1728( var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_1["loadoutSecondaryAttachment2"], var_3 );
            break;
        case "loadoutSecondaryReticle":
            var_4 = _id_1727( "loadoutSecondary", var_1, var_3 );
            break;
        case "loadoutSecondaryCamo":
            var_4 = !isdefined( self._id_1740 ) || var_3 == self._id_1740;
            var_4 = var_4 && maps\mp\gametypes\_class::isvalidcamo( var_3 );
            break;
        case "loadoutStreak1":
        case "loadoutStreak2":
        case "loadoutStreak3":
        case "loadoutStreak4":
            var_4 = maps\mp\bots\_bots_ks::_id_1675( var_3, "bots", undefined );
            var_4 = var_4 && _id_168E( "killstreak", var_3, undefined );
            break;
        case "loadoutStreakModule1a":
        case "loadoutStreakModule1b":
        case "loadoutStreakModule1c":
        case "loadoutStreakModule2a":
        case "loadoutStreakModule2b":
        case "loadoutStreakModule2c":
        case "loadoutStreakModule3a":
        case "loadoutStreakModule3b":
        case "loadoutStreakModule3c":
        case "loadoutStreakModule4a":
        case "loadoutStreakModule4b":
        case "loadoutStreakModule4c":
            var_4 = _id_168E( "module", var_3, undefined );
            break;
        case "loadoutPerk3":
        case "loadoutPerk4":
        case "loadoutPerk5":
        case "loadoutPerk6":
        case "loadoutPerk1":
        case "loadoutPerk2":
            var_4 = var_3 == "specialty_null" || _id_1726( var_3, var_2, var_1 );
            var_4 = var_4 && _id_168F( var_0, var_3, self _meth_836B() );
            break;
        case "loadoutWildcard1":
        case "loadoutWildcard2":
        case "loadoutWildcard3":
            var_4 = 1;
            break;
        default:
            break;
    }

    return var_4;
}

_id_1688( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "none";
    var_6 = undefined;
    var_7 = 0.0;

    if ( common_scripts\utility::array_contains( var_0, "specialty_null" ) )
        var_5 = "specialty_null";
    else if ( var_3 == "loadoutEquipment" || var_3 == "loadoutOffhand" || common_scripts\utility::string_find( var_3, "Perk" ) >= 0 )
        var_5 = "specialty_null";

    if ( var_1 == "classtable_any" )
    {
        if ( !isdefined( self._id_2778 ) )
            self._id_2778 = common_scripts\utility::random( [ "class1", "class2", "class3", "class4", "class5" ] );

        var_0 = [ self._id_2778 ];
    }

    foreach ( var_9 in var_0 )
    {
        var_10 = undefined;

        if ( getsubstr( var_9, 0, 9 ) == "template_" )
        {
            var_10 = var_9;
            var_11 = level._id_1742[var_9][var_3];
            var_9 = _id_1688( strtok( var_11, "| " ), var_1, var_2, var_3, 1 );

            if ( isdefined( var_10 ) && isdefined( self._id_1D63[var_10] ) )
                return var_9;
        }

        if ( var_9 == "attachmenttable" )
            return _id_1683( var_1, var_2, var_3, self._id_67DC, self._id_2A5E );

        if ( var_9 == "weap_statstable" )
            return _id_1689( var_1, var_2, var_3, self._id_67DC, self._id_2A5E );

        if ( var_9 == "reticletable" )
            return _id_1687( var_1, var_2, var_3, self._id_67DC, self._id_2A5E );

        if ( var_9 == "camotable" )
            return _id_1684( var_1, var_2, var_3, self._id_67DC, self._id_2A5E );

        if ( getsubstr( var_9, 0, 5 ) == "class" && int( getsubstr( var_9, 5, 6 ) ) > 0 )
            var_9 = _id_1686( var_9, var_3 );

        if ( issubstr( var_3, "loadoutStreakModule" ) )
        {
            var_12 = int( getsubstr( var_3, 19, 20 ) );
            var_13 = var_2["loadoutStreak" + var_12];
            var_14 = getsubstr( var_3, 20, 21 );

            switch ( var_13 )
            {
                case "remote_mg_sentry_turret":
                    if ( var_14 == "a" )
                        var_9 = "sentry_guardian";

                    break;
                case "warbird":
                    if ( var_14 == "a" )
                        var_9 = "warbird_ai_attack";

                    break;
                case "assault_ugv":
                    if ( var_14 == "a" )
                        var_9 = "assault_ugv_ai";
                    else if ( var_14 == "b" )
                        var_9 = "assault_ugv_mg";

                    break;
            }
        }

        if ( _id_1694( var_1, var_2, var_3, var_9 ) )
        {
            var_7 += 1.0;

            if ( randomfloat( 1.0 ) <= 1.0 / var_7 )
            {
                var_5 = var_9;
                var_6 = var_10;
            }
        }
    }

    if ( isdefined( var_6 ) )
        self._id_1D63[var_6] = 1;

    return var_5;
}

_id_168A( var_0 )
{
    self._id_1D63 = [];

    foreach ( var_6, var_2 in var_0 )
    {
        var_3 = strtok( var_2, "| " );
        var_4 = _id_1688( var_3, var_2, var_0, var_6 );
        var_0[var_6] = var_4;
    }

    if ( self _meth_836B() != "recruit" )
    {
        var_7 = _id_1639( var_0 );

        for ( var_8 = 0; var_7 < level.customclasspickcount && var_8 < 5; var_8++ )
        {
            if ( var_7 == level.customclasspickcount - 1 )
                var_0 = _id_160D( var_0 );
            else if ( var_7 <= level.customclasspickcount - 2 )
                var_0 = _id_160E( var_0 );

            var_7 = _id_1639( var_0 );
        }
    }

    return var_0;
}

_id_160D( var_0 )
{
    if ( var_0["loadoutSecondaryAttachment2"] == "none" )
        var_0["loadoutSecondaryAttachment2"] = _id_1688( [ "attachmenttable" ], "attachmenttable", var_0, "loadoutSecondaryAttachment2" );

    if ( _id_1639( var_0 ) == level.customclasspickcount )
        return var_0;

    var_2 = "add";
    var_3 = var_0["loadoutWildcard1"] != "specialty_null" && var_0["loadoutWildcard2"] != "specialty_null" && var_0["loadoutWildcard3"] != "specialty_null";

    if ( randomint( 100 ) < 50 && !var_3 )
        var_2 = "remove";

    if ( var_2 == "remove" )
    {
        if ( var_0["loadoutEquipment"] != "specialty_null" )
        {
            var_0["loadoutEquipment"] = "specialty_null";

            if ( _id_1639( var_0 ) == level.customclasspickcount - 2 )
                return var_0;
        }
    }
    else if ( var_2 == "add" )
    {
        if ( var_0["loadoutEquipment"] != "specialty_null" && var_0["loadoutEquipment2"] == "specialty_null" )
        {
            var_0["loadoutEquipment2"] = var_0["loadoutEquipment"];

            if ( _id_1639( var_0 ) == level.customclasspickcount )
                return var_0;
        }
    }

    if ( !var_3 )
    {
        var_4 = [ "loadoutSecondaryAttachment2", "loadoutSecondaryAttachment", "loadoutStreak3", "loadoutStreak2", "loadoutStreak1" ];

        foreach ( var_6 in var_4 )
        {
            if ( var_0[var_6] != "none" )
            {
                var_0[var_6] = "none";

                if ( _id_1639( var_0 ) == level.customclasspickcount - 2 )
                    return var_0;
            }
        }
    }

    return var_0;
}

_id_160E( var_0 )
{
    var_1 = [ "loadoutWildcard1", "loadoutWildcard2", "loadoutWildcard3" ];
    var_2 = common_scripts\utility::array_randomize( [ "loadoutPerk2", "loadoutPerk4", "loadoutPerk6" ] );

    foreach ( var_4 in var_2 )
    {
        if ( var_0[var_4] == "specialty_null" )
        {
            var_5 = undefined;

            foreach ( var_7 in var_1 )
            {
                if ( var_0[var_7] == "specialty_null" )
                {
                    var_5 = var_7;
                    break;
                }
            }

            if ( isdefined( var_5 ) )
            {
                var_9 = 0;

                if ( !var_9 )
                {
                    var_11 = int( getsubstr( var_4, 11, 12 ) );
                    var_0[var_5] = "specialty_wildcard_perkslot" + var_11 / 2;
                    var_0[var_4] = _id_1688( [ "template_any" ], "template_any", var_0, var_4 );

                    if ( var_0[var_4] == "specialty_null" )
                    {
                        var_0[var_5] = "specialty_null";
                        continue;
                    }

                    if ( _id_1639( var_0 ) > level.customclasspickcount - 2 )
                        return var_0;
                }
            }
        }
    }

    if ( var_0["loadoutEquipment"] == "specialty_null" )
    {
        var_13 = "template_any_noncamper";

        if ( level._id_16B2[self._id_67DC] == "stationary" )
            var_13 = "template_any_camper";

        var_0["loadoutEquipment"] = _id_1688( [ var_13 ], var_13, var_0, "loadoutEquipment" );
    }

    if ( var_0["loadoutEquipment"] != "specialty_null" && var_0["loadoutEquipment2"] == "specialty_null" )
        var_0["loadoutEquipment2"] = var_0["loadoutEquipment"];

    return var_0;
}

_id_1639( var_0 )
{
    var_1 = tablelookup( "mp/statstable.csv", 4, var_0["loadoutPrimary"], 40 );
    var_2 = tablelookup( "mp/statstable.csv", 4, var_0["loadoutSecondary"], 40 );
    var_3 = 0;

    if ( var_0["loadoutPrimary"] != "iw5_combatknife" )
        var_3++;

    if ( var_0["loadoutPrimaryAttachment"] != "none" && var_1 == "" )
        var_3++;

    if ( var_0["loadoutPrimaryAttachment2"] != "none" )
        var_3++;

    if ( var_0["loadoutPrimaryAttachment3"] != "none" )
        var_3++;

    if ( var_0["loadoutSecondary"] != "iw5_combatknife" )
        var_3++;

    if ( var_0["loadoutSecondaryAttachment"] != "none" && var_2 == "" )
        var_3++;

    if ( var_0["loadoutSecondaryAttachment2"] != "none" )
        var_3++;

    if ( var_0["loadoutSecondaryAttachment3"] != "none" )
        var_3++;

    if ( var_0["loadoutEquipment"] != "specialty_null" )
        var_3++;

    if ( var_0["loadoutEquipment2"] != "specialty_null" )
        var_3++;

    if ( var_0["loadoutOffhand"] != "specialty_null" )
        var_3++;

    if ( isdefined( var_0["loadoutOffhandExtra"] ) && var_0["loadoutOffhandExtra"] )
        var_3++;

    for ( var_4 = 1; var_4 <= 6; var_4++ )
    {
        if ( var_0["loadoutPerk" + var_4] != "specialty_null" )
            var_3++;
    }

    for ( var_4 = 1; var_4 <= 3; var_4++ )
    {
        if ( var_0["loadoutWildcard" + var_4] != "specialty_null" )
            var_3++;
    }

    for ( var_4 = 1; var_4 <= 4; var_4++ )
    {
        if ( var_0["loadoutStreak" + var_4] != "none" )
            var_3++;
    }

    return var_3;
}

_id_168D()
{
    var_0 = self _meth_836B();

    if ( var_0 == "default" )
    {
        maps\mp\bots\_bots_util::_id_16EB( "default" );
        var_0 = self _meth_836B();
    }

    return var_0;
}

_id_168B( var_0 )
{
    while ( !isdefined( level._id_1695 ) )
        wait 0.05;

    while ( !isdefined( self._id_67DC ) )
        wait 0.05;

    var_1 = 0;
    var_2 = 0;

    if ( isdefined( var_0 ) && var_0 )
        var_2 = 1;
    else if ( isdefined( self._id_16B4 ) && self._id_16B4 )
    {
        var_1 = 1;
        self._id_16B4 = undefined;
    }

    var_3 = [];
    var_4 = _id_168D();
    self._id_2A5E = var_4;
    var_5 = self _meth_8366();

    if ( !isdefined( self.bot_last_loadout_num ) )
        self.bot_cur_loadout_num = 0;

    self.bot_last_loadout_num = self.bot_cur_loadout_num;

    if ( isdefined( self._id_173C ) && !var_1 )
    {
        if ( var_2 )
            return self._id_173C;

        var_6 = self._id_173D == var_4;
        var_7 = self._id_173E == var_5;

        if ( var_6 && var_7 && ( !isdefined( self._id_4723 ) || self._id_4723 ) && !isdefined( self._id_7474 ) )
        {
            var_8 = randomfloat( 1.0 ) > 0.1;

            if ( var_8 )
                return self._id_173C;
        }
    }

    if ( !_id_15E8() )
    {
        var_3 = _id_15EA();
        _id_16B5( var_3["loadoutPrimary"] );
    }
    else
    {
        var_3 = _id_1690( var_5, var_4 );
        var_3 = _id_168A( var_3 );

        if ( isdefined( level.bot_funcs["gametype_loadout_modify"] ) )
            var_3 = self [[ level.bot_funcs["gametype_loadout_modify"] ]]( var_3 );
    }

    if ( var_3["loadoutPrimary"] == "none" )
    {
        self._id_1609 = undefined;
        var_3["loadoutPrimary"] = _id_1682( var_3 );
        var_3["loadoutPrimaryCamo"] = "none";
        var_3["loadoutPrimaryAttachment"] = "none";
        var_3["loadoutPrimaryAttachment2"] = "none";
        var_3["loadoutPrimaryAttachment3"] = "none";
        var_3["loadoutPrimaryReticle"] = "none";

        if ( isdefined( self._id_1609 ) )
        {
            if ( self._id_1609 == "weapon" )
                _id_16B5( var_3["loadoutPrimary"] );
            else
                maps\mp\bots\_bots_util::_id_16ED( self._id_1609 );

            var_5 = self._id_67DC;
            self._id_1609 = undefined;
        }
    }

    if ( isdefined( var_3["loadoutPrimaryCamo"] ) && var_3["loadoutPrimaryCamo"] != "none" && !isdefined( self._id_173F ) )
        self._id_173F = var_3["loadoutPrimaryCamo"];

    if ( isdefined( var_3["loadoutSecondaryCamo"] ) && var_3["loadoutSecondaryCamo"] != "none" && !isdefined( self._id_1740 ) )
        self._id_1740 = var_3["loadoutSecondaryCamo"];

    if ( isdefined( self._id_7474 ) )
    {
        var_12 = level._id_16CF[self _meth_836B()];

        if ( _id_168E( "weapon", var_12, undefined ) )
        {
            var_3["loadoutSecondary"] = var_12;
            var_3["loadoutSecondaryAttachment"] = "none";
            var_3["loadoutSecondaryAttachment2"] = "none";
            var_3["loadoutSecondaryAttachment3"] = "none";
            self._id_16B4 = 1;
        }

        self._id_7474 = undefined;
    }

    maps\mp\gametypes\_class::isvalidkillstreak( var_3["loadoutStreak1"] );
    maps\mp\gametypes\_class::isvalidkillstreak( var_3["loadoutStreak2"] );
    maps\mp\gametypes\_class::isvalidkillstreak( var_3["loadoutStreak3"] );
    self.bot_cur_loadout_num++;
    self._id_173C = var_3;
    self._id_173D = var_4;
    self._id_173E = var_5;
    return var_3;
}

_id_16F4()
{
    var_0 = self _meth_8366();
    var_1 = _id_168D();
    var_2 = _id_1691( var_0, var_1, 0 );

    if ( isdefined( var_2 ) && isdefined( var_2.loadouts ) && var_2.loadouts.size > 0 )
    {
        self.classcallback = ::_id_168B;
        return 1;
    }

    var_3 = getsubstr( self.name, 0, self.name.size - 10 );
    self.classcallback = undefined;
    return 0;
}
