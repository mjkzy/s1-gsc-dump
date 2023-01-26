// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_27DA( var_0, var_1, var_2 )
{
    wait(var_0);
    self notify( "luinotifyserver", var_1, var_2 );
}

_id_806D()
{
    var_0 = spawnstruct();
    var_0._id_91D5 = 40;
    var_0._id_1304 = 0.25;
    var_0._id_92F5 = var_0._id_1304;
    var_0._id_06D3 = 0.01;
    var_0._id_2878 = 0;
    var_0._id_1303 = 0.5;
    var_0._id_0B97 = 0.01;
    var_0._id_92F4 = var_0._id_1303;
    var_0._id_25F2 = 0;
    var_0._id_5A45 = 60;
    var_0._id_5C80 = 60;
    var_0._id_5A46 = 120;
    var_0._id_0B93 = 0;
    var_0.dist = 120;
    var_0._id_2C73 = 12;
    var_0._id_35B3 = -10;
    var_0.caotolobbyframedelay = 3;
    var_0.caotolobbyframetimer = 0;
    var_0._id_3BEF = 0.0;
    var_0._id_3BEE = 45;
    var_0._id_3BF0 = 50;
    var_0._id_3BEC = 6;
    var_0._id_3BED = 6;
    var_0.gamelobbygroup_camera_upclosez = 513;
    var_0.gamelobbygroup_camera_normalz = 507;
    var_0.gamelobbygroup_camera_crouchz = 483;
    var_0.gamelobbygroup_camera_hunchz = 502;
    var_0.gamelobbygroup_camera_closedistance = 71.5;
    var_0.gamelobbygroup_camera_normaldistance = 96.8;
    var_0.gamelobbygroup_camera_crouchdistance = 96.8;
    var_0.gamelobbygroup_camera_hunchdistance = 96.8;
    var_0.gamelobbygroup_camera_crouchthreshold = 490;
    var_0.gamelobbygroup_camera_hunchthreshold = 504.5;
    var_0.gamelobbygroup_camera_normalthreshold = 509.5;
    var_0.gamelobbygroup_movespeed_modifier = 0.95;
    var_0._id_197A = 0.0;
    var_0._id_1979 = 7;
    var_0._id_1991 = 13;
    var_0._id_1976 = 0;
    var_0._id_1977 = 0;
    var_0._id_1A31 = 0.1;
    var_0._id_198E = 0.2;
    var_0._id_197D = 0;
    var_0._id_1978 = 17;
    var_0._id_1990 = 14.5;
    var_0._id_197C = 69;
    var_0._id_1993 = 8;
    var_0._id_1995 = 0;
    var_0._id_1996 = 0;
    var_0._id_1997 = 0;
    var_0._id_1998 = 0;
    var_0.cacweapondelaytime = 0.35;
    var_0.cacweaponanimdelaytime = 0.1;
    var_0.cacweaponattachdelaytime = 0.05;
    var_0._id_3BEA = 150;
    var_0._id_3BE9 = 0.2;
    var_0._id_3BE8 = 45;
    var_0._id_3BEB = 55;
    var_0._id_3BE5 = 16;
    var_0._id_3BE7 = 24;
    var_0._id_3BE6 = 0.5;
    var_0.goal = "avatar";
    var_0._id_3BE1 = 0.005;
    var_0._id_3BE3 = 0;
    var_0._id_3BE2 = 64;
    var_0._id_3BE4 = 0;
    var_0._id_92F2 = var_0._id_1A34;
    var_0._id_24B9 = var_0._id_92F2;
    var_0._id_197B = 0;
    var_0._id_1992 = ( -0.02, 0.0, -0.08 );
    var_0._id_1994 = ( 0.05, 0.0, -0.06 );
    var_0._id_1A33 = 0.25;
    var_0._id_1A45 = 10;
    var_0._id_5F71 = 150;
    var_0._id_0BA4 = 800;
    var_0._id_6F03 = 0;
    var_1 = self _meth_844D();
    var_0._id_63DD = var_1[0];
    var_0._id_63DE = var_1[1];
    var_0._id_A3F0 = 0.5;
    var_0._id_75E7 = 0.5;
    var_0._id_3A0D = 0;
    var_0._id_6EA8 = 4;
    var_0._id_27D5 = 0;
    var_0._id_2C63 = 0;
    var_0._id_2C62 = 0;
    var_0._id_2C50 = 159.8;
    var_0._id_2C4F = 205.59;
    var_0._id_2C61 = 7.5;
    var_0._id_2C4E = 2;
    var_0._id_6592 = ( 0.0, 0.0, 40.0 );
    var_0._id_6EFE = 300;
    var_0._id_6F02 = 10;
    var_0._id_6F01 = 42;
    var_0._id_6EFF = 40;
    var_0._id_6EFD = 200;
    var_0._id_6EFB = 0;
    var_0._id_6EFC = 20;
    var_0._id_6EFA = 0.325;
    var_0._id_6F00 = 0.2;
    var_0._id_1A32 = -0.1;
    var_0._id_1A34 = 0.19;
    var_0._id_1A35 = -1;
    var_0._id_1C49 = 36;
    var_0._id_1C4A = 42;
    var_0._id_970D = 0;
    var_0._id_1B1A = 10;
    var_0._id_1B19 = 31;
    var_0._id_1B12 = 40;
    var_0._id_1B0B = 200;
    var_0._id_1B08 = 0;
    var_0._id_1B09 = 20;
    var_0._id_1B07 = 0.77;
    var_0._id_1B13 = 0.2;
    var_0._id_1B0A = 0.25;
    var_2 = getdvarint( "virtualLobbyMode", 0 );

    if ( var_2 == 0 )
    {
        var_0._id_5D32 = "game_lobby";
        _id_8C45();
        setdvar( "virtualLobbyReady", "0" );
    }
    else
    {
        var_0._id_5D32 = "transition";
        var_0._id_92F2 = var_0._id_1A32;
        var_0._id_24B9 = var_0._id_92F2;
        _id_8BF6();

        if ( getdvarint( "virtualLobbyReady", 0 ) == 0 )
            setdvar( "virtualLobbyReady", "1" );

        if ( var_2 == 2 )
            thread _id_27DA( 0.1, "cac", 0 );
        else if ( var_2 == 3 )
            thread _id_27DA( 0.1, "cao", 0 );
    }

    var_0._id_60B0 = var_0._id_5D32;
    level._id_1A3E = var_0;
}

_id_9AA1( var_0 )
{
    if ( isdefined( self._id_2569 ) )
        var_0._id_24B9 = var_0._id_92F2;
    else
    {
        var_1 = var_0._id_92F2 - var_0._id_24B9;

        if ( var_1 < -1 * var_0._id_1A33 )
            var_1 = -1 * var_0._id_1A33;
        else if ( var_1 > var_0._id_1A33 )
            var_1 = var_0._id_1A33;

        var_0._id_24B9 += var_1;
    }
}

_id_9EA7()
{
    var_0 = self;

    if ( isdefined( level._id_9E9E ) )
        var_0 [[ level._id_9E9E ]]();
    else
    {
        var_0 _meth_84A9();
        var_0 _meth_84AB( 0.613159, 89.8318, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 );
    }
}

_id_7DD5()
{
    if ( isdefined( level._id_1A3E.goal ) )
    {
        if ( level._id_1A3E.goal == "moving" || level._id_1A3E.goal == "finding_new_position" || level._id_9EA2[level._id_9E99] != level._id_9EA2[level._id_63BB] )
            return;
    }

    if ( isdefined( level._id_1A3E.camera._id_2569 ) && level._id_1A3E.camera._id_2569 == 1 )
        return;

    var_0 = self;

    if ( isdefined( level._id_1A3E.camera.goal_location ) )
        var_1 = level._id_1A3E.camera.goal_location;
    else
    {
        var_2 = level._id_9EA2[level._id_63BB];
        var_3 = var_2 gettagorigin( "TAG_STOWED_BACK" );
        var_4 = distance2d( var_3, var_2.avatar_spawnpoint.origin );
        var_5 = var_2.avatar_spawnpoint.origin + anglestoforward( var_2.avatar_spawnpoint.angles ) * var_4;
        var_1 = ( var_5[0], var_5[1], var_3[2] );
    }

    var_6 = _id_1CF6( level._id_1A3E.camera, var_1, 1.5 );

    if ( var_6 == 1 )
        var_7 = var_1;
    else
        var_7 = level._id_1A3E.camera.origin;

    var_8 = distance( level._id_9EA2[level._id_63BB] gettagorigin( "j_spine4" ), var_7 );
    var_0 _id_9EA5( var_8 + level._id_1A3E._id_35B3 );
}

_id_9EA5( var_0 )
{
    if ( var_0 <= 0.0 )
        return;

    var_1 = self;
    var_2 = level._id_1A3E._id_2C73;

    if ( isdefined( level._id_9E98 ) )
        var_1 [[ level._id_9E98 ]]( var_0 );
    else
    {
        var_3 = var_0;
        var_1 = self;
        var_4 = 0.025;
        var_5 = 0.65;
        var_6 = 0.613159;
        var_7 = 94.9504;
        var_8 = ( var_7 - var_3 ) * var_4;
        var_9 = var_6 + var_8 + var_8 * var_5;

        if ( var_9 < 0.125 )
            var_9 = 0.125;
        else if ( var_9 > 128 )
            var_9 = 128;

        var_1 _meth_84AB( var_9, var_3, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 * 2 );
    }
}

_id_9EA6( var_0, var_1, var_2 )
{
    var_3 = self;

    if ( isdefined( level._id_9E9C ) )
        var_3 [[ level._id_9E9C ]]( var_0, var_1, var_2 );
    else
    {
        if ( var_0 == "cac" )
            var_3 _id_7F47();
        else if ( var_0 == "cao" )
        {

        }

        if ( var_1 == "cac" )
        {
            var_3 visionsetnakedforplayer( "mp_vlobby_refraction_cac", 0 );
            var_3 lightsetforplayer( "mp_vl_create_a_class" );
        }
        else if ( var_1 == "cao" )
            var_3 _meth_84AB( 1.53, 130, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 );
        else if ( var_1 == "clanprofile" )
            var_3 _id_7F44();
        else if ( var_1 == "prelobby" )
            var_3 _id_7F47();
        else
        {
            if ( var_0 == "prelobby_members" )
                return;

            if ( var_0 == "prelobby_loadout" )
                return;

            if ( var_0 == "prelobby_loot" )
                return;

            if ( var_1 == "game_lobby" )
                var_3 _id_7F47();
            else
            {
                if ( var_0 == "startmenu" )
                    return;

                if ( var_0 == "transition" )
                    return;

                return;
                return;
                return;
                return;
            }
        }
    }
}

_id_7F47()
{
    var_0 = self;
    var_0 visionsetnakedforplayer( "mp_vlobby_room", 0 );
    var_0 lightsetforplayer( "mp_vlobby_room" );
}

_id_7F44()
{
    var_0 = self;
    var_0 _meth_84AB( 0.613159, 89.8318, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 );
}

_id_382B()
{
    if ( !isdefined( level._id_9EA2[level._id_9E99] ) )
    {
        foreach ( var_2, var_1 in level._id_9EA2 )
        {
            level._id_9E99 = var_2;
            break;
        }
    }

    if ( !isdefined( level._id_9EA2[level._id_9E9F] ) )
        level._id_9E9F = level._id_9E99;
}

_id_9EA8()
{
    self endon( "disconnect" );
    wait 0.05;
    var_0 = self;
    var_0 setclientomnvar( "ui_vlobby_round_state", 0 );
    var_0 setclientomnvar( "ui_vlobby_round_timer", 0 );
    var_0 _id_42ED();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
    var_3 = var_1 - ( 0.0, 0.0, 30.0 );
    var_0 _id_806D();
    var_0 _id_9EA7();
    var_4 = anglestoforward( var_0.angles );
    var_5 = anglestoright( var_0.angles );
    var_6 = var_4;
    var_7 = getgroundposition( var_1, 20, 512, 120 );
    var_8 = var_0 getxuid();
    var_9 = var_8 == "";
    var_10 = undefined;
    level._id_6079 = 1;
    level._id_9E99 = 0;
    level._id_9E9F = 0;
    var_0.team = "spectator";
    var_11 = "iw5_hbra3_mp";
    var_12 = "iw5_hbra3";

    if ( isdefined( var_0.loadouts["customClasses"][0]["primary"] ) && var_0.loadouts["customClasses"][0]["primary"] != "none" )
    {
        var_13 = var_0.loadouts["customClasses"][0]["primary"];
        var_14 = var_0.loadouts["customClasses"][0]["primaryAttachment1"];
        var_15 = var_0.loadouts["customClasses"][0]["primaryAttachment2"];
        var_16 = var_0.loadouts["customClasses"][0]["primaryAttachment3"];
        var_17 = var_0.loadouts["customClasses"][0]["primaryCamo"];
        var_18 = var_0.loadouts["customClasses"][0]["primaryReticule"];

        if ( isdefined( var_17 ) )
            var_17 = int( tablelookup( "mp/camoTable.csv", 1, var_17, 0 ) );
        else
            var_17 = undefined;

        if ( isdefined( var_18 ) )
            var_18 = int( tablelookup( "mp/reticleTable.csv", 1, var_18, 0 ) );
        else
            var_18 = undefined;

        var_11 = maps\mp\gametypes\_class::buildweaponname( var_13, var_14, var_15, var_16, var_17, var_18 );
        var_12 = var_0.loadouts["customClasses"][0]["primary"];
    }
    else if ( isdefined( var_0.primaryweapon ) )
    {
        var_11 = var_0.primaryweapon;
        var_12 = var_0.pers["primaryWeapon"];
    }

    var_19 = getent( "cao_spawnpoint", "targetname" );

    if ( !var_9 )
    {
        _id_A75B::vlprintln( "adding xuid " + var_8 + "from vlobby_player" );
        var_20 = _id_A75B::_id_0735( var_8 );
        var_0 _id_88C8( var_0.avatar_spawnpoint, var_11, var_0.secondaryweapon, var_12, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.sessioncostume, var_0.name, var_20, 0 );
        getchallengerewarditem( level._id_9EA2[var_20], var_8 );
        thread _id_834B();
    }
    else
        level._id_6085 = 1;

    setdvar( "virtuallobbymembers", level._id_A3A7.size );
    var_0._id_1B06 = var_0 _id_88C8( var_19, var_11, var_0.secondaryweapon, var_12, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.sessioncostume, var_0.name, 0, 1 );
    getchallengerewarditem( var_0._id_1B06, var_8 );
    _id_483F( var_0._id_1B06 );
    var_0.clan_agents = [];
    var_21 = [ 0, 1, 4 ];

    for ( var_22 = 0; var_22 < 3; var_22++ )
    {
        var_23 = maps\mp\gametypes\vlobby::getspawnpoint( var_21[var_22] );
        var_0.clan_agents[var_22] = var_0 _id_88C8( var_23, var_11, var_0.secondaryweapon, var_12, var_0.loadoutequipment, var_0.loadoutoffhand, var_0.perks, var_0.sessioncostume, var_0.name, 0, 0, 1 );
        _id_483F( var_0.clan_agents[var_22] );
    }

    var_0 thread _id_5D75( 0 );

    if ( !var_9 )
    {
        var_10 = level._id_9EA2[level._id_9E99];
        var_10._id_5BA4 = gettime();
        var_10._id_2522 = var_0._id_2522;
        var_10.player = var_0;
        var_10.sessioncostume = var_10.costume;
        _id_9E4C( 0, "lobby" + ( var_10._id_2522 + 1 ), 1 );
    }

    thread _id_5D7E( var_0, level._id_1A3E );
    var_24 = ( -70.7675, -691.293, 507.472 );
    var_25 = var_0.avatar_spawnpoint.origin - var_24;
    var_26 = ( 0.0, 87.0, 0.0 );
    var_25 = vectornormalize( var_25 );
    var_27 = spawn( "script_model", var_24 );
    var_27.angles = var_26;
    var_27 setmodel( "tag_player" );
    var_27._id_8D2D = var_24;
    var_27._id_8CF9 = var_26;
    var_27._id_7817 = ( 0.0, 0.0, 0.0 );
    var_27._id_1A0D = 0;
    var_27._id_473C = 1;
    var_27._id_1A11 = 1;
    var_27._id_2569 = 1;
    var_27._id_3C07 = 0;
    var_27._id_3794 = 1;
    var_27.goal_location = var_24;
    _id_8F0C( var_27 );
    var_28 = 400;
    var_0.camera = var_27;
    var_27.player = var_0;
    var_0._id_4748 = 0;
    var_29 = ( 0.0, 90.0, 0.0 );
    var_27._id_5FA6 = "starting";
    level._id_9EA3 = var_27;
    var_0 setorigin( var_27.origin );
    var_0 playerlinkto( var_27, "tag_player" );
    var_0 cameralinkto( var_27, "tag_player" );
    level._id_4C00 = 0;
    var_0 _meth_8131( 0 );
    var_0 _id_A75B::_id_6F0C( var_0._id_8999, var_0._id_8999._id_88CA );
    var_0 _id_A75B::_id_6F0C( var_0._id_1B06, var_0._id_1B06._id_88CA );
    var_0 _id_A75B::_id_6F0C( var_0.clan_agents[0], var_0.clan_agents[0]._id_88CA );
    var_0 _id_A75B::_id_6F0C( var_0.clan_agents[1], var_0.clan_agents[1]._id_88CA );
    var_0 _id_A75B::_id_6F0C( var_0.clan_agents[2], var_0.clan_agents[2]._id_88CA );
    maps\mp\_utility::updatesessionstate( "spectator" );
    var_30 = level._id_1A3E;
    var_30.camera = var_27;
    _id_4D20( var_27 );
    var_31 = 300;
    level._id_63BB = level._id_9E99;
    var_28 = 1000;
    var_32 = anglestoforward( var_27.angles );
    var_33 = undefined;
    var_34 = undefined;
    var_35 = undefined;
    var_36 = undefined;
    level._id_1A3E._id_3A0D = level._id_1A3E._id_6EA8;
    thread _id_5DE9();
    thread _id_5E18();
    var_37 = 0;
    var_38 = 0;
    var_0 setclientdvar( "cg_fovscale", "0.6153" );
    var_0 notify( "fade_in" );

    for (;;)
    {
        _id_A75B::_id_1178();

        if ( level._id_9EA2.size == 0 )
        {
            if ( var_30._id_5D32 == "game_lobby" || var_30._id_5D32 == "prelobby_loot" )
            {
                _id_483F( var_0._id_1B06 );

                for ( var_22 = 0; var_22 < 3; var_22++ )
                    _id_483F( var_0.clan_agents[var_22] );

                var_27._id_2569 = 1;
                var_0.avatar_spawnpoint = maps\mp\gametypes\vlobby::getspawnpoint( 0 );
                _id_57E9( var_27, undefined, var_30, var_0.avatar_spawnpoint );
                _id_9EA9( 1, "ac130_overlay_pip_vignette_vlobby" );
            }

            wait 0.05;
            continue;
        }

        var_10 = level._id_9EA2[level._id_9E99];

        if ( var_38 )
        {
            var_38 = 0;
            var_0 thread _id_26B2();
        }

        if ( getdvarint( "scr_vl_debugfly" ) > 0 )
        {
            if ( !var_37 )
            {
                var_37 = 1;
                setdvar( "lui_enabled", "0" );
                level._id_2698 = undefined;
                var_0 _meth_8131( 1 );
            }

            var_0 _id_2698( var_27 );
        }
        else if ( var_37 )
        {
            setdvar( "lui_enabled", "1" );
            var_37 = 0;
            var_27.origin = var_27._id_8D2D;
            var_27.angles = var_27._id_8CF9;
            var_0 _meth_8131( 0 );
        }

        if ( !level._id_4C00 )
        {
            if ( level._id_9E99 != level._id_63BB )
            {
                var_0 _id_A75B::_id_6F0C( level._id_9EA2[level._id_9E99], level._id_9EA2[level._id_9E99].angles );

                if ( var_30._id_5D32 != "game_lobby" )
                    var_30._id_60B0 = "transition";

                level._id_63BB = level._id_9E99;
                var_30._id_970D = 1;
            }

            if ( isdefined( level._id_9E96 ) || isdefined( level._id_7046 ) )
            {
                if ( !isdefined( level._id_9E96 ) )
                {
                    var_30._id_60B0 = var_30._id_705C;
                    level._id_7046 = undefined;
                }
                else if ( !isdefined( level._id_7046 ) )
                {
                    var_30._id_60B0 = "cao";
                    var_30._id_705C = var_30._id_5D32;
                    level._id_7046 = level._id_9E96;
                }
                else if ( level._id_9E96 != level._id_7046 )
                    level._id_7046 = level._id_9E96;
            }

            if ( isdefined( level._id_1975 ) || isdefined( level._id_7044 ) )
            {
                if ( !isdefined( level._id_1975 ) )
                {
                    var_30._id_60B0 = var_30._id_705C;
                    level._id_7044 = undefined;
                    level._id_7045 = "none";
                }
                else if ( !isdefined( level._id_7044 ) )
                {
                    var_30._id_60B0 = "cac";
                    var_30._id_705C = var_30._id_5D32;
                    level._id_7044 = level._id_1975;
                }
            }

            if ( isdefined( level._id_9E97 ) || isdefined( level.prv_vl_clanprofile_focus ) )
            {
                if ( !isdefined( level._id_9E97 ) )
                {
                    var_30._id_60B0 = var_30._id_705C;
                    level.prv_vl_clanprofile_focus = undefined;
                }
                else if ( !isdefined( level.prv_vl_clanprofile_focus ) )
                {
                    var_30._id_60B0 = "clanprofile";
                    var_30._id_705C = var_30._id_5D32;
                    level.prv_vl_clanprofile_focus = level._id_9E97;
                }
                else if ( level._id_9E97 != level.prv_vl_clanprofile_focus )
                {
                    level.prv_vl_clanprofile_focus = level._id_9E97;
                    var_0 _id_A75B::_id_6F0C( var_0.clan_agents[level._id_9E97], var_0.clan_agents[level._id_9E97].angles );
                }
            }

            if ( level._id_9EA2.size == 0 )
                continue;

            _id_382B();
            var_10 = level._id_9EA2[level._id_9E99];

            if ( var_30._id_60B0 != var_30._id_5D32 )
            {
                var_0 _id_9EA6( var_30._id_5D32, var_30._id_60B0, var_30 );

                if ( var_30._id_60B0 == "cac" )
                {
                    _id_483F( var_0._id_1B06 );

                    for ( var_22 = 0; var_22 < 3; var_22++ )
                        _id_483F( var_0.clan_agents[var_22] );

                    var_0._id_4748 = 0;
                    var_30._id_5D32 = var_30._id_60B0;
                    var_30._id_92F2 = var_30._id_197A;
                    var_10 = level._id_9EA2[level._id_9E99];
                    var_0 _id_A75B::_id_6F0C( var_10, var_10.angles );
                }
                else if ( var_30._id_5D32 == "cac" )
                {
                    _id_A75B::_id_84DF();
                    var_10 = level._id_9EA2[level._id_9E99];
                    var_0._id_4748 = 0;
                }

                if ( var_30._id_60B0 == "cao" )
                {
                    if ( isdefined( level._id_9E9F ) && isdefined( level._id_9EA2[level._id_9E9F] ) )
                    {
                        var_39 = level._id_9EA2[level._id_9E9F];
                        level.players[0].costume = var_39.costume;
                        var_40 = level.players[0] maps\mp\gametypes\_teams::playercostume();
                        var_40 = var_39 maps\mp\gametypes\_teams::playercostume();
                        var_41 = level.players[0]._id_1B06;
                        _id_9E94( var_41, var_39.costume );
                        var_40 = var_41 maps\mp\gametypes\_teams::playercostume();

                        foreach ( var_8, var_43 in level._id_A3A7 )
                        {
                            if ( var_43 == level._id_9E9F )
                            {
                                if ( isdefined( level.cao_xuid ) && level.cao_xuid != var_8 )
                                    getchallengerewarditem( var_41, level.cao_xuid, 1 );

                                getchallengerewarditem( var_41, var_8 );
                                level.cao_xuid = var_8;
                                break;
                            }
                        }
                    }

                    _id_84B9( var_0._id_1B06 );
                    var_0._id_1B06 _id_44E6( var_0._id_1B06._id_88CA );
                    _id_4844();

                    for ( var_22 = 0; var_22 < 3; var_22++ )
                        _id_483F( var_0.clan_agents[var_22] );

                    var_10 = var_0._id_1B06;
                    var_0 _id_A75B::_id_6F0C( var_0._id_1B06, var_0._id_1B06.angles );
                    _id_8B53();
                    var_30._id_5D32 = var_30._id_60B0;
                    var_27._id_2569 = 1;
                    var_0 setorigin( var_10.origin );
                }
                else if ( var_30._id_60B0 == "clanprofile" )
                {
                    _id_483F( var_0._id_1B06 );
                    _id_4844();

                    for ( var_22 = 0; var_22 < 3; var_22++ )
                    {
                        var_0.clan_agents[var_22] _id_44E6( var_0.clan_agents[var_22]._id_88CA );
                        var_0 _id_A75B::_id_6F0C( var_0.clan_agents[var_22], var_0.clan_agents[var_22].angles );
                    }

                    var_10 = var_0.clan_agents[0];
                    var_30._id_5D32 = var_30._id_60B0;
                    var_0 setorigin( var_10.origin );
                }
                else if ( var_30._id_60B0 == "prelobby_loot" )
                    var_27._id_2569 = 1;
                else if ( var_30._id_60B0 == "transition" )
                    var_30._id_60B0 = "game_lobby";

                if ( var_30._id_60B0 == "game_lobby" )
                {
                    _id_382B();

                    if ( var_30._id_5D32 == "cac" && isdefined( level._id_9E99 ) )
                        var_44 = level._id_9E99;
                    else
                    {
                        var_44 = 0;

                        foreach ( var_43, var_46 in level._id_9EA2 )
                        {
                            var_44 = var_43;
                            break;
                        }
                    }

                    if ( var_30._id_5D32 == "cao" || var_30._id_5D32 == "cac" || var_30._id_5D32 == "clanprofile" )
                    {
                        var_27._id_3794 = 1;

                        if ( isdefined( level._id_9E96 ) )
                        {
                            level._id_9E9F = var_44;
                            var_44 = _id_3F9C( level._id_9E96 );
                        }
                        else if ( isdefined( level._id_9E97 ) )
                        {
                            level._id_9E9F = var_44;
                            var_44 = _id_3F9C( level._id_9E97 );
                        }
                        else
                            level._id_9E9F = var_44;
                    }

                    if ( isdefined( level._id_9EA2 ) && isdefined( level._id_63BB ) && isdefined( level._id_9EA2[level._id_63BB] ) )
                        var_0 _id_A75B::_id_6F0C( level._id_9EA2[level._id_63BB], level._id_9EA2[level._id_63BB].angles );

                    var_30.goal = "waiting";

                    if ( var_30._id_5D32 != "cac" )
                        _id_84BA();

                    level._id_9E99 = var_44;
                    level._id_63BB = var_44;
                    var_10 = level._id_9EA2[var_44];

                    if ( var_30._id_5D32 != "cac" )
                        var_27._id_2569 = 1;
                    else if ( var_30._id_5D32 == "cac" && isdefined( var_27.avatar_spawnpoint ) && var_27.avatar_spawnpoint != var_10.avatar_spawnpoint )
                        var_27._id_2569 = 1;

                    _id_8BF6();
                    var_27._id_5508 = var_10.avatar_spawnpoint;
                    var_27.avatar_spawnpoint = var_10.avatar_spawnpoint;
                    var_0 _id_A75B::_id_6F0C( var_10, var_10.angles );
                    var_27._id_5FA6 = "starting";
                    var_0 setorigin( var_10.origin );
                }

                var_30._id_5D32 = var_30._id_60B0;
            }

            if ( var_30._id_5D32 == "startmenu" )
                _id_8C05( var_27, var_30 );
            else if ( var_30._id_5D32 == "cao" )
            {
                var_10 = var_0._id_1B06;
                _id_1B1B( var_27, var_10, var_30 );
                _id_9EA9( 1, "ac130_overlay_pip_vignette_vlobby_cao" );
            }
            else if ( var_30._id_5D32 == "clanprofile" )
            {
                var_10 = var_0.clan_agents[level._id_9E97];
                _id_1E2C( var_27, var_10, var_30 );
                _id_9EA9( 1, "ac130_overlay_pip_vignette_vlobby" );
            }
            else if ( var_30._id_5D32 == "cac" )
                _id_57E9( var_27, level._id_9EA2[level._id_9E99], var_30, var_0.avatar_spawnpoint );
            else if ( var_30._id_5D32 == "transition" )
                var_30._id_60B0 = "game_lobby";
            else if ( var_30.caotolobbyframetimer <= 0 )
            {
                _id_483F( var_0._id_1B06 );

                for ( var_22 = 0; var_22 < 3; var_22++ )
                    _id_483F( var_0.clan_agents[var_22] );

                _id_57E9( var_27, var_10, var_30, var_0.avatar_spawnpoint );
                _id_9EA9( 1, "ac130_overlay_pip_vignette_vlobby" );
            }
            else
                var_30.caotolobbyframetimer -= 1;
        }

        if ( level._id_4C00 )
            _id_9EA9( 0, "ac130_overlay_pip_vignette_vlobby" );

        wait 0.05;
    }
}

_id_90A6( var_0, var_1, var_2 )
{
    var_3 = float( tablelookup( "mp/vlobby_cac_offsets.csv", var_1, var_0, var_2 ) );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    return var_3;
}

_id_8F0C( var_0 )
{
    var_1 = getentarray( "player_pos", "targetname" );
    var_0._id_1A2E = [];

    foreach ( var_3 in var_1 )
        var_0._id_1A2E[var_0._id_1A2E.size] = var_3;

    foreach ( var_3 in var_1 )
    {
        var_6 = getent( var_3.target, "targetname" );

        if ( var_6.script_noteworthy == "camera_target" )
            var_3._id_1A18 = var_6;

        var_7 = getent( var_6.target, "targetname" );

        if ( var_7.script_noteworthy == "camera" )
        {
            var_3._id_1A17 = var_7;
            var_7._id_1A16 = var_3;
            var_7._id_1A18 = var_3._id_1A18;
        }

        if ( var_3.script_noteworthy == "0" )
            level._id_1A3E._id_550F = var_3._id_1A17;

        var_8 = int( var_3.script_noteworthy );
        var_0._id_1A2E[var_8] = var_3;
    }
}

_id_19C2( var_0, var_1, var_2 )
{
    var_3 = var_1 - var_0;
    var_4 = length2d( var_3 );
    var_5 = var_4 / sqrt( 1 + var_2._id_24B9 * var_2._id_24B9 );
    var_6 = var_3[0] - var_2._id_24B9 * var_3[1];
    var_7 = var_2._id_24B9 * var_3[0] + var_3[1];
    var_8 = var_5 * vectornormalize( ( var_6, var_7, 0 ) );
    var_8 += ( 0, 0, var_3[2] );
    return var_8;
}

_id_44E8( var_0, var_1 )
{
    var_2 = var_1 - var_0._id_63DD;

    if ( var_2 < -180 )
        var_2 = 360 + var_2;
    else if ( var_2 > 180 )
        var_2 = 360 - var_2;

    var_0._id_63DD = var_1;
    return var_2;
}

_id_44E9( var_0, var_1 )
{
    var_2 = var_1 - var_0._id_63DE;

    if ( var_2 < -180 )
        var_2 = -1;
    else if ( var_2 > 180 )
        var_2 = 1;
    else
        var_2 = 0;

    var_0._id_63DE = var_1;
    return var_2;
}

_id_1A30( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self._id_2569 ) )
        self.origin = var_0;
    else
        self moveto( var_0, var_1, var_2, var_3 );
}

_id_1A44( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self._id_2569 ) )
        self.angles = var_0;
    else
        self _meth_82B5( var_0, var_1, var_2, var_3 );
}

_id_75F6( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_2 = spawnstruct();
        var_2._id_1A25 = ( -70.8, -691.3, 502.2 );
        var_2._id_1A24 = ( 0.0, 87.0, 0.0 );
        return var_2;
    }

    var_3 = var_0 gettagorigin( "TAG_STOWED_BACK" );
    var_4 = var_0 gettagangles( "TAG_STOWED_BACK" );
    var_5 = var_0._id_88CA[1] - var_0.angles[1];
    var_6 = ( 0.0, 0.0, 1.0 );
    var_7 = var_3 - var_0.origin;
    var_8 = rotatepointaroundvector( var_6, var_7, var_5 );
    var_9 = var_0.origin + var_8;
    var_0._id_1A25 = var_9;
    var_0._id_1A24 = ( var_4[0], angleclamp( var_4[1] + var_5 ), var_4[2] );
    var_2 = spawnstruct();
    var_2._id_1A25 = var_0._id_1A25;
    var_2._id_1A24 = var_0._id_1A24;
    return var_2;
}

_id_1CF6( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 2;

    var_3 = distance( var_1, var_0.origin );

    if ( var_3 >= var_2 )
        return 1;
    else
        return 0;
}

_id_57E9( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
    {
        level._id_1A3E._id_3A0D = level._id_1A3E._id_6EA8;
        var_4 = var_0._id_8CF9;

        if ( isdefined( var_3 ) )
            var_4 = ( 0, var_3.angles[1] + 180, 0 );

        var_5 = var_0._id_8D2D;
        var_6 = distance( var_0.origin, var_5 );
        var_7 = var_6 / var_2._id_6EFE;

        if ( var_7 < 0.1 )
            var_7 = 0.1;

        var_0 _id_1A30( var_5, var_7, var_7 * 0.5, var_7 * 0.5 );
        var_0 _id_1A44( var_4, var_7, var_7 * 0.5, var_7 * 0.5 );
    }
    else
    {
        if ( level._id_1A3E._id_3A0D == level._id_1A3E._id_6EA8 )
            _id_A75B::_id_6F0C( var_1, var_1.angles );

        var_4 = ( 0.0, 87.0, 0.0 );

        if ( isdefined( var_1.avatar_spawnpoint ) )
            var_4 = ( 0, var_1.avatar_spawnpoint.angles[1] + 180, 0 );

        var_8 = var_1 gettagorigin( "TAG_STOWED_BACK" );

        if ( !isdefined( var_1.camera_state ) )
            var_1.camera_state = "stand";

        if ( var_1.camera_state == "crouch" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_crouchdistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_crouchz );
        }
        else if ( var_1.camera_state == "hunch" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_hunchdistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_hunchz );
        }
        else if ( var_1.camera_state == "stand" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_normaldistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_normalz );
        }
        else if ( var_1.camera_state == "zoom_high" )
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_closedistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_upclosez );
        }
        else
        {
            var_9 = var_1.avatar_spawnpoint.origin + anglestoforward( var_1.avatar_spawnpoint.angles ) * var_2.gamelobbygroup_camera_normaldistance;
            var_10 = ( var_9[0], var_9[1], var_2.gamelobbygroup_camera_normalz );
        }

        var_0.goal_location = var_10;
        var_11 = 0;

        if ( level._id_1A3E._id_3A0D == 0 )
            var_11 = _id_1CF6( var_0, var_10, 1.5 );

        var_2._id_24B9 = var_2._id_3BEF;
        var_2._id_92F2 = var_2._id_3BEF;
        var_0 _id_9AA1( var_2 );
        var_12 = 0;
        var_13 = 0;
        var_6 = distance( var_0.origin, var_10 );
        var_7 = var_6 / var_2._id_3BEA;

        if ( var_7 < 0.1 )
            var_7 = 0.1;

        var_14 = var_6 / var_2._id_3BEA * level._id_1A3E.gamelobbygroup_movespeed_modifier;

        if ( var_14 < 0.1 )
            var_14 = 0.1;

        var_15 = 1;
        var_16 = getdvarint( "virtualLobbyMode", 0 );

        if ( var_16 != 2 && var_16 != 4 && var_16 != 3 )
            _id_A75B::_id_7525( var_1, 0.5 );
        else if ( var_16 == 4 || var_16 == 3 )
        {
            _id_A75B::_id_6F0C( var_1, var_1.angles );
            var_0._id_2569 = 1;
        }
        else if ( var_16 == 2 )
            _id_A75B::_id_6F0C( var_1, var_1.angles );

        if ( level._id_1A3E._id_3A0D > 0 )
            level._id_1A3E._id_3A0D -= 1;

        if ( isdefined( var_1.avatar_spawnpoint ) && isdefined( var_0.avatar_spawnpoint ) && var_1.avatar_spawnpoint != var_0.avatar_spawnpoint )
        {
            var_0._id_5576 = var_0.avatar_spawnpoint;
            var_0.avatar_spawnpoint = var_1.avatar_spawnpoint;
            var_2.goal = "finding_new_position";
            var_11 = 1;
            var_0._id_3794 = 0;
        }
        else if ( var_11 == 1 )
            var_2.goal = "moving";

        if ( var_2.goal == "waiting" )
        {
            if ( var_11 == 1 )
            {
                var_2.goal = "moving";
                var_0._id_3794 = 1;
            }

            var_0._id_5508 = var_1.avatar_spawnpoint;
        }

        if ( var_2.goal == "finding_new_position" )
        {
            if ( var_11 == 1 )
            {
                var_0._id_5576 = var_0.avatar_spawnpoint;
                var_0.avatar_spawnpoint = var_1.avatar_spawnpoint;
                var_0._id_632A = [];
                var_17 = 16;

                foreach ( var_19 in level._id_9EA2 )
                {
                    var_20 = [];
                    var_20["center"] = var_19.avatar_spawnpoint.origin;
                    var_20["radius"] = var_17;
                    var_0._id_632A[var_0._id_632A.size] = var_20;
                }

                _id_1860( var_0, var_2, var_0.origin, var_10, var_4 );
                var_0._id_3A03 = _id_19BD( var_1 );
                var_0._id_919D = _id_3E89( var_1 );
                var_2.goal = "moving";
            }

            var_2.goal = "moving";
        }

        if ( var_2.goal == "moving" )
        {
            if ( level._id_1A3E._id_3A0D <= 0 )
            {
                level._id_1A3E._id_3A0D = 0;

                if ( var_0._id_3794 == 0 )
                {
                    if ( isdefined( var_0._id_2569 ) )
                    {
                        var_0 _id_1A30( var_10, var_7, var_12, var_13 );
                        var_0 _id_1A44( var_4, var_15, var_15 * 0.5, var_15 * 0.5 );
                        var_0._id_3794 = 1;
                    }
                    else
                        var_0._id_3794 = _id_9AA0( var_0, var_2 );
                }

                if ( var_0._id_3794 )
                {
                    var_0 _id_1A30( var_10, var_14, var_14 * 0.5, var_14 * 0.5 );
                    var_0 _id_1A44( var_4, var_14, var_14 * 0.5, var_14 * 0.5 );
                    var_2.goal = "waiting";
                }
            }
        }

        level.players[0] _id_7DD5();
    }

    if ( isdefined( var_0._id_2569 ) )
    {
        var_0 dontinterpolate();
        var_0._id_2569 = undefined;
    }

    if ( getdvarint( "virtualLobbyReady", 0 ) == 0 )
    {
        wait 1.0;
        setdvar( "virtualLobbyReady", "1" );
        thread _id_834B();
    }
}

_id_834B()
{
    level notify( "cancel_vlp" );
    level endon( "cancel_vlp" );

    if ( level._id_9EA2.size > 0 && isdefined( level._id_9EA2[0] ) && isdefined( level._id_9EA2[0].primaryweapon ) && isweaponloaded( level._id_9EA2[0].primaryweapon ) )
    {
        level._id_6085 = undefined;
        wait 0.5;
        setdvar( "virtualLobbyPresentable", "1" );
    }
    else
        level._id_6085 = 1;
}

_id_7464()
{
    level notify( "cancel_vlp" );
    level endon( "cancel_vlp" );
    level._id_6085 = undefined;
    wait 0.25;
    setdvar( "virtualLobbyPresentable", "0" );
}

_id_5F64( var_0 )
{
    var_1 = level.players[0];
    var_2 = var_1 geteye();
    var_3 = var_2 - var_1.origin;
    var_1 setorigin( var_0.origin - var_3, 0 );
    var_1 setangles( ( var_1.angles[0], var_0.angles[1], var_1.angles[2] ) );
}

_id_3F05()
{
    var_0 = spawnstruct();
    var_1 = getdvar( "r_mode", "1280x720 [16:9]" );
    var_2 = strtok( var_1, " " );
    var_3 = strtok( var_2[0], "x" );
    var_0.width = maps\mp\_utility::stringtofloat( var_3[0] );
    var_0.height = maps\mp\_utility::stringtofloat( var_3[1] );
    var_0._id_004C = maps\mp\_utility::rounddecimalplaces( var_0.width / var_0.height, 3 );
    return var_0;
}

_id_4025( var_0, var_1, var_2 )
{
    if ( abs( var_1 - var_0._id_760D ) > 100 )
    {
        if ( var_1 >= 270 )
        {
            var_0._id_0845 += -360 * var_2;

            if ( var_0._id_0845 == -360 )
                var_0._id_0845 = 0;
        }

        if ( var_1 <= 100 )
        {
            var_0._id_0845 += 360 * var_2;

            if ( var_0._id_0845 == 360 )
                var_0._id_0845 = 0;
        }
    }

    var_0._id_760D = var_1;
    var_3 = var_1 * var_2 + var_0._id_0845;
    return var_3;
}

_id_1B1B( var_0, var_1, var_2 )
{
    _id_A75B::_id_7525( var_1, 0.5 );
    var_2.caotolobbyframetimer = var_2.caotolobbyframedelay;
    var_3 = var_1.origin + ( 0.0, 0.0, -20.0 ) + anglestoforward( var_1._id_88CA ) * 120;
    var_2._id_A3F0 = var_2._id_1B07;
    var_2.dist = var_2._id_1B12 + ( var_2._id_1B0B - var_2._id_1B12 ) * var_2._id_A3F0;
    var_4 = var_2._id_1B08 + var_2._id_1B09 * var_2._id_A3F0;
    var_5 = var_2._id_1B19 + var_2._id_1B1A * ( 1 - var_2._id_A3F0 );
    var_2._id_92F2 = var_2._id_1B0A + var_2._id_6F00 * ( var_2._id_A3F0 - 1 );
    var_0 _id_9AA1( var_2 );
    var_6 = var_2._id_1C4A + ( var_2._id_1C49 - var_2._id_1C4A ) * var_2._id_A3F0;
    var_7 = var_1.origin + ( 0, 0, var_5 );
    var_8 = var_7 - var_3 + var_2._id_6592;
    var_8 = var_2.dist * vectornormalize( var_8 );
    var_8 = ( var_8[0], var_8[1], -1 * var_4 );
    var_8 = var_2.dist * vectornormalize( var_8 );
    var_9 = var_7 - var_8;

    if ( isdefined( level._id_1B1C ) )
    {
        var_7 += level._id_1B1C;
        var_9 += level._id_1B1C;
    }

    var_10 = -1 * var_8;
    var_11 = vectortoangles( var_10 );
    var_2._id_0B93 = var_11[1] - var_1._id_8CF9[1];
    var_12 = distance( var_0.origin, var_9 );
    var_13 = var_12 / var_2._id_6EFE;

    if ( var_13 < 0.1 )
        var_13 = 0.1;

    var_0 _id_1A30( var_9, var_13, var_13 * 0.5, var_13 * 0.5 );
    var_14 = _id_19C2( var_9, var_7, var_2 );
    var_15 = vectortoangles( var_14 );
    var_0 _id_1A44( var_15, var_13, var_13 * 0.5, var_13 * 0.5 );

    if ( isdefined( var_0._id_2569 ) )
    {
        var_0 dontinterpolate();
        var_0._id_2569 = undefined;
    }
}

_id_8C05( var_0, var_1 )
{

}

_id_1E2C( var_0, var_1, var_2 )
{
    var_3 = ( 0.0, 87.0, 0.0 );

    if ( isdefined( var_1.avatar_spawnpoint ) )
        var_3 = ( 0, var_1.avatar_spawnpoint.angles[1] + 180, 0 );

    var_0 _id_9AA1( var_2 );
    var_4 = ( 14.0, 0.0, 0.0 );
    var_5 = var_1.origin + var_4 + anglestoforward( var_1.avatar_spawnpoint.angles ) * 110;
    var_6 = ( var_5[0], var_5[1], var_2.gamelobbygroup_camera_normalz );
    var_0.goal_location = var_6;
    var_7 = distance( var_0.origin, var_6 );
    var_8 = max( var_7 / var_2._id_3BEA, 0.1 );
    var_9 = 0.2;
    var_0 _id_1A30( var_6, var_8, 0, 0 );
    var_0 _id_1A44( var_3, var_9, 0, 0 );
    _id_A75B::_id_7525( var_1, 0.5 );
}

_id_5E18()
{
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = getdvarint( "virtualLobbyMode", 0 );

        if ( level._id_1A3E._id_5D32 != "cao" )
        {
            if ( level._id_1A3E._id_5D32 != "prelobby" && var_0 == 0 )
                level._id_1A3E._id_60B0 = "game_lobby";

            if ( common_scripts\utility::string_find( level._id_1A3E._id_5D32, "prelobby" ) >= 0 && var_0 == 1 )
                level._id_1A3E._id_60B0 = "game_lobby";
        }

        wait 0.05;
    }
}

_id_3784()
{
    var_0 = self.script_noteworthy;
    var_0 = int( var_0 );
    return var_0;
}

_id_5DE9()
{
    self waittill( "disconnect" );
    self.camera delete();
    _id_A75B::vlprint( "remove all ownerIds due to disconnect\\n" );

    foreach ( var_2, var_1 in level._id_A3A7 )
        _id_732F( var_1 );
}

_id_7DAC( var_0, var_1 )
{
    maps\mp\agents\_agent_utility::_id_7DAB( var_0 );
    self.agent_gameparticipant = 0;
    self.isactive = 1;
    self.spawntime = gettime();
    self.issniper = 0;
    self.sessionteam = var_1;
}

_id_15F9()
{
    self._id_2ADC = 1;
    self._id_90A8 = [];
}

_id_9FD3( var_0 )
{
    if ( isalive( var_0 ) )
    {
        var_1 = isdefined( level._id_1975 );
        var_2 = getdvarint( "practiceroundgame" ) && var_0._id_6631 != 0;

        if ( !var_1 && !var_2 )
            _id_84B9( var_0 );
    }
}

_id_9FD4( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "wait_load_costume" );
    var_1 endon( "death" );
    wait(var_0);
    _id_9FD3( var_1 );
    var_1 notify( "wait_load_costume" );
}

_id_9FD2( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 notify( "wait_load_costume" );
    var_0 endon( "wait_load_costume" );
    var_0 endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    _id_483F( var_0 );
    thread _id_9FD4( 5.0, var_0 );

    for ( var_2 = self _meth_84EF( var_0.costume, var_0.team ); !var_2; var_2 = self _meth_84EF( var_0.costume, var_0.team ) )
        wait 0.1;

    if ( var_1 )
        _id_9FD3( var_0 );

    var_0 notify( "wait_load_costume" );
}

_id_88C8( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( var_10 ) )
        var_10 = 0;

    if ( !isdefined( var_11 ) )
        var_11 = 0;

    var_12 = !var_11;
    var_13 = "spectator";
    var_14 = "none";
    var_15 = _id_A75B::alloc_avatar();
    var_0._id_8999 = var_15;
    var_15.avatar_spawnpoint = var_0;
    var_15.costume = var_7;
    var_15._id_0015 = 0;
    var_15._id_760B = 0;
    var_15 _id_7DAC( var_13, var_14 );
    var_16 = getgroundposition( var_15.avatar_spawnpoint.origin, 20, 512, 120 );
    var_15._id_88CA = ( var_0.angles[0], var_0.angles[1] + var_15._id_760B, var_0.angles[2] );
    var_15.angles = var_15._id_88CA;

    if ( !var_11 )
        var_15 show();

    var_15._id_6631 = var_9;
    var_15 setangles( var_15._id_88CA );
    var_15 setorigin( var_16, 1 );
    var_15.angles = var_15._id_88CA;
    var_15._id_8CF9 = var_15._id_88CA;
    var_15._id_8F14 = var_15.angles[1];
    var_15.mouserot = 0;
    var_15._id_8F15 = 0;
    var_15._id_760D = 0;
    var_15._id_0845 = 0;
    var_15._id_760C = spawn( "script_origin", var_15.origin );
    var_15._id_1A15 = 1;
    var_15._id_1A25 = ( 0.0, 0.0, 0.0 );
    var_15._id_1A24 = ( 0.0, 0.0, 0.0 );
    var_15 _meth_83FC();

    if ( !isdefined( self._id_8999 ) )
        self._id_8999 = var_15;

    var_15 _meth_83D1( 1 );

    if ( var_10 == 1 )
    {
        var_15._id_5006 = 1;
        var_1 = undefined;
        var_15.primaryweapon = undefined;
        var_3 = undefined;
        var_15 _id_9BC9( "cao_01", 1, "lobby_idle" );
    }
    else if ( var_11 == 1 )
    {
        var_1 = undefined;
        var_15.primaryweapon = undefined;
        var_3 = undefined;
        var_15 _id_9BC9( "cao_01", 1, "lobby_idle" );
    }
    else
    {
        level._id_9EA2[var_9] = var_15;
        var_17 = var_15 _id_3EF9( var_3 );
        var_15 _id_9BC9( var_17._id_09D6, 1, var_17._id_0C8C );
        var_15 thread _id_1D27( var_1 );
    }

    var_15 maps\mp\gametypes\_spawnlogic::addtocharactersarray();

    if ( isalive( var_15 ) )
    {
        _id_9E95( undefined, var_9, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_15 );

        if ( level.players.size > 0 )
            level.players[0] thread _id_9FD2( var_15, var_12 );
    }

    if ( isdefined( level._id_1975 ) )
    {

    }

    if ( getdvarint( "practiceroundgame" ) && var_9 != 0 || var_11 )
        _id_483F( var_15 );
    else
        _id_84B9( var_15 );

    return var_15;
}

_id_1D27( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "free_avatar" );

    if ( !isdefined( self.primaryweapon ) )
        self.primaryweapon = var_0;

    self._id_8F12 = self.primaryweapon;
    var_1 = undefined;

    for (;;)
    {
        if ( !isdefined( self._id_6F8C ) || !isdefined( self._id_09AE ) )
        {
            wait 0.05;
            continue;
        }

        if ( isdefined( self ) && isdefined( self.primaryweapon ) && isalive( self ) )
        {
            var_2 = strtok( self.primaryweapon, "_" );

            if ( ( issubstr( var_2[1], "dlcgun3" ) || var_2[1] == "dlcgun10loot5" || var_2[1] == "dlcgun5loot5" ) && common_scripts\utility::array_contains( var_2, "akimbo" ) )
                var_1 = var_2[0] + "_" + var_2[1] + "_akimbo";
            else
                var_1 = var_2[0] + "_" + var_2[1];
        }

        var_3 = self _meth_83D3();
        var_4 = self _meth_83D3( "lobby_idle", "cao_01" );
        var_5 = _id_3EF9( var_1 );
        var_6 = self _meth_83D3( var_5._id_0C8C, var_5._id_09D6 );

        if ( isdefined( level._id_1A3E._id_5D32 ) )
        {
            if ( level._id_1A3E._id_60B0 != "cao" && level._id_1A3E._id_5D32 != "cao" )
            {
                if ( isdefined( self ) && isdefined( var_1 ) && isalive( self ) )
                {
                    var_9 = isweaponloaded( self.primaryweapon );
                    var_10 = self._id_8F12 != self.primaryweapon;
                    var_11 = var_10 || var_3 != var_6;
                    var_12 = getweaponbasename( self._id_8F12 ) != getweaponbasename( self.primaryweapon );

                    if ( var_11 )
                    {
                        if ( var_9 )
                        {
                            if ( var_12 )
                            {
                                _id_4841( self );
                                _id_4840( self );
                                thread attachweapondelayed( self );
                                thread _id_8522( self );
                            }

                            self._id_6F8C _meth_8483( self.primaryweapon );
                            self._id_09AE _meth_8483( self.primaryweapon );

                            if ( issubstr( self.primaryweapon, "akimbo" ) || issubstr( self.primaryweapon, "akimboxmg" ) )
                            {
                                if ( var_12 )
                                    thread _id_84F6( self );
                            }
                            else
                            {
                                self._id_09AE hide();
                                self._id_09AE _meth_804A();
                            }

                            self._id_8F12 = self.primaryweapon;
                            var_5 = _id_3EF9( var_1 );
                            self.camera_state = var_5.camera_state;
                            thread animdelayed( var_5._id_09D6, var_5._id_0C8C );
                            thread vl_vfx_for_avatar();
                        }
                        else
                        {

                        }
                    }
                }
            }
        }

        wait 0.5;
    }
}

isweaponloaded( var_0 )
{
    var_1 = 0;

    if ( level.players.size > 0 )
    {
        var_1 = level.players[0] _meth_8535( var_0 );

        if ( !var_1 )
            level.players[0] loadweapons( var_0 );
    }

    return var_1;
}

attachweapondelayed( var_0 )
{
    wait(level._id_1A3E.cacweaponattachdelaytime);
    attachprimaryweapon( var_0 );
}

animdelayed( var_0, var_1 )
{
    wait(level._id_1A3E.cacweaponanimdelaytime);
    _id_9BC9( var_0, undefined, var_1 );
}

_id_3EF9( var_0 )
{
    var_1 = spawnstruct();
    var_1._id_09D6 = var_0;

    if ( isdefined( var_0 ) && var_0 != "" && var_0 != "none" )
    {
        var_1._id_0C8C = tablelookup( "mp/vlobby_cac_offsets.csv", 0, var_0, 5 );
        var_1.camera_state = tablelookup( "mp/vlobby_cac_offsets.csv", 0, var_0, 6 );

        if ( isdefined( var_1.camera_state ) )
            self.camera_state = var_1.camera_state;
    }

    if ( !isdefined( var_1._id_0C8C ) || var_1._id_0C8C == "" )
    {
        var_1._id_0C8C = "lobby_idle";
        var_1._id_09D6 = "cao_01";
        var_1.camera_state = "stand";
    }

    self _meth_83D0( "vlobby_animclass" );

    if ( !isdefined( var_1.camera_state ) )
        var_1.camera_state = "stand";

    if ( !isdefined( self.camera_state ) )
        self.camera_state = var_1.camera_state;

    return var_1;
}

_id_9E9A( var_0, var_1 )
{
    if ( var_1.isfree )
        return;

    _id_07FA( var_1 );

    if ( !isdefined( var_1.primaryweapon ) )
        return;

    if ( !isdefined( var_1._id_0C4C ) )
        return;

    if ( var_1.primaryweapon != "none" )
    {
        if ( !isdefined( var_1._id_6F8C ) )
        {
            var_2 = spawn( "weapon_" + var_1.primaryweapon, ( 0.0, 0.0, 0.0 ) );
            var_3 = get_xuid_for_avatar( var_1 );
            getchallengerewarditem( var_2, var_3 );
            var_1._id_6F8C = var_2;
            var_2.primaryweapon = var_1.primaryweapon;
            var_1._id_6F8C show();
            var_1._id_6F8C _meth_804C();
            var_1._id_6F8C _meth_8483( var_1.primaryweapon );
            attachprimaryweapon( var_1 );
        }
        else if ( var_1._id_6F8C.primaryweapon != var_1.primaryweapon )
            var_1._id_6F8C.primaryweapon = var_1.primaryweapon;

        if ( !isdefined( var_1._id_09AE ) )
        {
            var_4 = spawn( "weapon_" + var_1.primaryweapon, ( 0.0, 0.0, 0.0 ) );
            var_3 = get_xuid_for_avatar( var_1 );
            getchallengerewarditem( var_4, var_3 );
            var_1._id_09AE = var_4;
            var_4.primaryweapon = var_1.primaryweapon;
        }
        else if ( var_1._id_09AE.primaryweapon != var_1.primaryweapon )
            var_1._id_09AE.primaryweapon = var_1.primaryweapon;

        var_5 = "tag_weapon_left";

        if ( issubstr( var_1._id_09AE.primaryweapon, "combatknife" ) )
            var_5 = "tag_inhand";

        if ( issubstr( var_1._id_09AE.primaryweapon, "riotshield" ) )
            var_5 = "tag_weapon_left";

        var_1._id_09AE unlink();
        var_1._id_09AE.origin = var_1 gettagorigin( var_5 );
        var_1._id_09AE.angles = var_1 gettagangles( var_5 );
        var_1._id_09AE linktosynchronizedparent( var_1, var_5 );
        var_1._id_09AE _meth_8530( var_0 );

        if ( issubstr( var_1._id_6F8C.primaryweapon, "akimbo" ) || issubstr( var_1._id_6F8C.primaryweapon, "akimboxmg" ) )
            thread _id_84F6( var_1 );
        else if ( !isdefined( var_1._id_8F12 ) )
        {
            var_1._id_09AE hide();
            var_1._id_09AE _meth_804A();
        }
    }

    if ( var_1.secondaryweapon != "none" )
    {
        if ( issubstr( var_1.secondaryweapon, "combatknife" ) )
        {
            if ( isdefined( var_1._id_7BF7 ) )
            {
                if ( var_1._id_7BF7 islinked() )
                    var_1._id_7BF7 unlink();

                var_1._id_7BF7 delete();
            }
        }
        else
        {
            if ( !isdefined( var_1._id_7BF7 ) )
            {
                var_6 = spawn( "weapon_" + var_1.secondaryweapon, ( 0.0, 0.0, 0.0 ) );
                var_3 = get_xuid_for_avatar( var_1 );
                getchallengerewarditem( var_6, var_3 );
                var_1._id_7BF7 = var_6;
                var_6.secondaryweapon = var_1.secondaryweapon;
            }
            else if ( var_1._id_7BF7.secondaryweapon != var_1.secondaryweapon )
            {
                var_1._id_7BF7 _meth_8483( var_1.secondaryweapon );
                var_1._id_7BF7.secondaryweapon = var_1.secondaryweapon;
            }

            var_7 = "tag_stowed_back";
            var_1._id_7BF7 unlink();
            var_1._id_7BF7.origin = var_1 gettagorigin( var_7 );
            var_1._id_7BF7.angles = var_1 gettagangles( var_7 );
            var_1._id_7BF7 linktosynchronizedparent( var_1, var_7 );
            var_1._id_7BF7 _meth_804C();
            var_1._id_7BF7 _meth_8530( var_0 );
        }
    }
    else
    {

    }
}

attachprimaryweapon( var_0 )
{
    var_1 = undefined;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;

    var_2 = "tag_weapon_right";

    if ( issubstr( var_0._id_6F8C.primaryweapon, "combatknife" ) )
        var_2 = "tag_inhand";

    if ( issubstr( var_0._id_6F8C.primaryweapon, "riotshield" ) )
        var_2 = "tag_weapon_left";

    var_0._id_6F8C unlink();
    var_0._id_6F8C.origin = var_0 gettagorigin( var_2 );
    var_0._id_6F8C.angles = var_0 gettagangles( var_2 );
    var_0._id_6F8C linktosynchronizedparent( var_0, var_2 );
    var_0._id_6F8C _meth_8530( var_1 );
}

_id_07FA( var_0 )
{
    var_0 detach( "npc_exo_arm_launcher_R", "J_Elbow_RI", 0 );
    var_0 detach( "npc_exo_arm_launcher_L", "J_Elbow_LE", 0 );

    if ( isdefined( var_0._id_0253 ) && var_0._id_0253 != "specialty_null" )
    {
        if ( !var_0 maps\mp\_utility::_hasperk( "specialty_wildcard_dualtacticals" ) )
            var_0 attach( "npc_exo_arm_launcher_R", "J_Elbow_RI", 1 );
        else
        {

        }
    }

    if ( isdefined( var_0._id_0428 ) && var_0._id_0428 != "specialty_null" )
    {
        if ( var_0 maps\mp\_utility::_hasperk( "specialty_wildcard_duallethals" ) )
            var_0 attach( "npc_exo_arm_launcher_L", "J_Elbow_LE", 1 );
        else
        {

        }
    }
}

_id_84F6( var_0 )
{
    var_0 endon( "death" );
    var_0._id_6F8C endon( "death" );
    var_0 endon( "hide_akimbo_weapon" );
    wait(level._id_1A3E.cacweapondelaytime);

    if ( level._id_1A3E._id_60B0 != "cao" && level._id_1A3E._id_5D32 != "cao" )
    {
        if ( issubstr( var_0._id_6F8C.primaryweapon, "akimbo" ) || issubstr( var_0._id_6F8C.primaryweapon, "akimboxmg" ) )
        {
            var_0._id_09AE show();
            var_0._id_09AE _meth_804C();
        }
    }
}

_id_8522( var_0 )
{
    var_0 endon( "death" );
    var_0._id_6F8C endon( "death" );
    var_0 endon( "hide_primary_weapon" );
    wait(level._id_1A3E.cacweapondelaytime);

    if ( var_0.isfree )
        return;

    var_1 = getdvarint( "practiceroundgame" ) && var_0._id_6631 != 0;

    if ( level._id_1A3E._id_60B0 != "cao" && level._id_1A3E._id_5D32 != "cao" && !var_1 )
    {
        var_0._id_6F8C show();
        var_0._id_6F8C _meth_804C();
    }
}

_id_9E94( var_0, var_1, var_2 )
{
    var_0 takeallweapons();
    var_0 detachall();
    var_0.headmodel = undefined;

    if ( isdefined( var_1 ) )
        var_0.costume = var_1;

    if ( !isdefined( var_0.costume ) || !maps\mp\gametypes\_teams::validcostume( var_0.costume ) )
    {
        if ( isdefined( var_0.sessioncostume ) && maps\mp\gametypes\_teams::validcostume( var_0.sessioncostume ) )
            var_0.costume = var_0.sessioncostume;
        else
        {
            var_0.costume = maps\mp\gametypes\_teams::getdefaultcostume();
            var_0.sessioncostume = var_0.costume;
        }
    }

    if ( isdefined( var_2 ) && var_2 )
    {
        level.players[0].costume = var_0.costume;
        var_3 = level.players[0] maps\mp\gametypes\_teams::playercostume();
        var_3 = var_0 maps\mp\gametypes\_teams::playercostume();
        var_4 = level.players[0]._id_1B06;
        _id_9E94( var_4, var_0.costume );
        var_3 = var_4 maps\mp\gametypes\_teams::playercostume();
    }
}

_id_9E95( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_9 ) )
        var_9 = level._id_9EA2[var_1];

    var_10 = 0;

    if ( isdefined( var_9.loadout ) && var_9.loadout._id_031E >= 0 )
        var_10 = 1;

    _id_9E94( var_9, var_8 );
    var_9 maps\mp\gametypes\_teams::playermodelforweapon( var_4, maps\mp\_utility::getbaseweaponname( var_3 ) );

    if ( var_10 && isdefined( level.players[0] ) )
        level.players[0] setcostumemodels( var_9.costume );

    var_9.primaryweapon = var_2;
    var_9.secondaryweapon = "none";
    var_9._id_0428 = var_6;
    var_9._id_0253 = var_5;
    var_9.perks = var_7;
    _id_9E9A( var_0, var_9 );
    var_9 thread vl_vfx_for_avatar();
}

_id_5D75( var_0 )
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_1, var_2 );

        if ( ( var_1 == "classpreview" || var_1 == "classpreview_postcopy" ) && isdefined( var_2 ) )
        {
            if ( var_2 >= 0 )
            {
                var_3 = var_2 & 15;
                var_4 = int( var_2 / 16 );
                _id_A75B::vlprint( "classpreview " + var_1 + " controller=" + var_3 + "  class=" + var_4 );

                if ( var_4 > 0 )
                {
                    level._id_1975 = 1;
                    self._id_2522 = var_4 - 1;
                }

                var_0 = _id_3F9C( var_3 );
                var_5 = var_1 == "classpreview_postcopy";
                var_6 = level._id_9EA2[var_0];

                if ( isdefined( var_6 ) )
                {
                    level._id_9E99 = var_0;
                    level._id_9E9F = var_0;
                    _id_9E4C( var_0, "lobby" + ( self._id_2522 + 1 ), !var_5 );
                    level._id_1999 = var_6.primaryweapon;
                }

                level._id_39AB = var_5;
                continue;
            }

            level._id_1975 = undefined;
        }
    }
}

_id_5D68( var_0, var_1 )
{
    var_2 = "";

    if ( var_1 != "current" && var_1 != "none" && var_2 == "" )
    {
        var_3 = tablelookup( "mp/statstable.csv", 4, var_1, 40 );

        if ( var_3 == "" )
            var_3 = "none";

        var_4 = maps\mp\gametypes\_class::buildweaponname( var_1, var_3, "none", "none" );
    }
    else if ( var_1 == "none" )
        var_4 = "none";
    else
    {
        var_5 = level._id_9EA2[var_0];
        var_4 = var_5.primaryweapon;
    }

    level._id_1999 = var_4;
}

has_suffix( var_0, var_1 )
{
    if ( var_0.size >= var_1.size )
    {
        if ( getsubstr( var_0, var_0.size - var_1.size, var_0.size ) == var_1 )
            return 1;
    }

    return 0;
}

_id_5D79( var_0 )
{
    self endon( "disconnect" );
    var_1 = [];

    while ( !isdefined( level._id_1A3E ) )
    {
        self waittill( "luinotifyserver", var_2, var_3 );

        if ( isdefined( var_3 ) )
        {
            var_1[var_1.size] = [ var_2, var_3 ];
            continue;
        }

        var_1[var_1.size] = [ var_2 ];
    }

    for (;;)
    {
        if ( var_1.size > 0 )
        {
            var_4 = var_1[0];
            var_5 = [];

            for ( var_6 = 1; var_6 < var_1.size; var_6++ )
                var_5[var_5.size] = var_1[var_6];

            var_1 = var_5;
            var_2 = var_4[0];

            if ( var_4.size > 1 )
                var_3 = var_4[1];
            else
                var_3 = undefined;
        }
        else
            self waittill( "luinotifyserver", var_2, var_3 );

        if ( var_2 == "cac" && isdefined( var_3 ) )
        {
            if ( var_3 == 0 )
                level._id_1975 = undefined;
            else
                level._id_1975 = 1;

            level._id_9E96 = undefined;
            continue;
        }

        if ( var_2 == "weapon_highlighted" && isdefined( var_3 ) )
        {
            if ( issubstr( var_3, "stream:" ) )
            {
                var_7 = strtok( var_3, ":" );

                if ( var_7.size > 1 )
                {
                    var_8 = var_7[var_7.size - 1];

                    if ( !has_suffix( var_8, "_mp" ) )
                        var_8 += "_mp";

                    _id_A75B::vlprintln( "weapon_stream: " + var_8 );
                    var_9 = [ var_8 ];
                    self loadweapons( var_9 );
                }

                _id_5D68( var_0, "none" );
            }
            else
            {
                _id_A75B::vlprintln( "weapon_highlighted  " + var_3 );
                _id_5D68( var_0, var_3 );
            }

            continue;
        }

        if ( var_2 == "lootscreen_weapon_highlighted" && isdefined( var_3 ) )
        {
            if ( var_3 == "none" )
                level._id_1975 = undefined;
            else if ( var_3 == "reset" )
                level._id_1975 = 1;
            else
                level._id_1975 = 1;

            level._id_9E96 = undefined;
            continue;
        }

        var_10 = 0;

        if ( var_2 == "preview_attach1" )
            var_10 = 1;
        else if ( var_2 == "preview_attach2" )
            var_10 = 2;
        else if ( var_2 == "preview_attach3" )
            var_10 = 3;

        if ( var_10 > 0 && isdefined( var_3 ) )
        {
            var_11 = level._id_9EA2[var_0];
            var_12 = var_11.loadout;
            var_13 = tablelookup( "mp/statstable.csv", 0, var_12.primary, 4 );
            var_14 = tablelookup( "mp/attachmenttable.csv", 0, var_12._id_033C, 3 );
            var_15 = tablelookup( "mp/attachmenttable.csv", 0, var_12.primaryattachment2, 3 );
            var_16 = tablelookup( "mp/attachmenttable.csv", 0, var_12.primaryattachment3, 3 );
            var_17 = var_12.primarycamo;

            if ( var_3 != "current" )
            {
                if ( var_10 == 1 )
                    var_14 = var_3;
                else if ( var_10 == 2 )
                    var_15 = var_3;
                else if ( var_10 == 3 )
                    var_16 = var_3;
            }

            level._id_1999 = maps\mp\gametypes\_class::buildweaponname( var_13, var_14, var_15, var_16, var_17, undefined );
        }
    }
}

_id_3F9C( var_0 )
{
    foreach ( var_3, var_2 in level._id_9EA2 )
    {
        if ( isdefined( var_2.loadout ) && isdefined( var_2.loadout._id_031E ) && var_2.loadout._id_031E == var_0 )
            return var_3;
    }

    _id_A75B::vlprintln( "unable to find avatar for controller " + var_0 );
    return -1;
}

_id_9E4C( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( self.pers["class"] ) && self.pers["class"] == var_1 && ( !isdefined( var_3 ) || !var_3 ) )
        return;

    self.pers["class"] = var_1;
    self.class = var_1;
    maps\mp\gametypes\_class::setclass( self.pers["class"] );
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    maps\mp\gametypes\_class::giveandapplyloadout( self.pers["team"], self.pers["class"] );

    if ( var_2 )
    {
        _id_9E95( self, var_0, self.primaryweapon, self.secondaryweapon, self.pers["primaryWeapon"], self.loadoutequipment, self.loadoutoffhand, self.perks, self.costume );

        if ( isdefined( self._id_1B06 ) )
            _id_9E95( self, var_0, undefined, self.secondaryweapon, self.pers["primaryWeapon"], self.loadoutequipment, self.loadoutoffhand, self.perks, self.costume, self._id_1B06 );
    }
}

_id_42ED()
{
    var_0 = [ "privateMatchCustomClasses", "customClasses" ];
    var_1 = [ 60, 60 ];
    var_2 = 0;
    self.loadouts = [];
    self._id_2522 = 0;

    foreach ( var_4 in var_0 )
    {
        level.forcecustomclassloc = var_4;
        self.loadouts[var_4] = [];
        var_5 = var_1[var_2];
        var_2++;

        for ( var_6 = 0; var_6 < var_5; var_6++ )
        {
            var_7 = [];
            var_7["primary"] = maps\mp\gametypes\_class::cac_getweapon( var_6, 0 );
            var_7["primaryAttachment1"] = maps\mp\gametypes\_class::cac_getweaponattachment( var_6, 0 );
            var_7["primaryAttachment2"] = maps\mp\gametypes\_class::cac_getweaponattachmenttwo( var_6, 0 );
            var_7["primaryAttachment3"] = maps\mp\gametypes\_class::cac_getweaponattachmentthree( var_6, 0 );
            var_7["primaryCamo"] = maps\mp\gametypes\_class::cac_getweaponcamo( var_6, 0 );
            var_7["primaryReticle"] = maps\mp\gametypes\_class::cac_getweaponreticle( var_6, 0 );

            for ( var_8 = 0; var_8 < 6; var_8++ )
                var_7["perk" + var_8] = maps\mp\gametypes\_class::cac_getperk( var_6, var_8 );

            for ( var_8 = 0; var_8 < 3; var_8++ )
                var_7["wildcard" + var_8] = maps\mp\gametypes\_class::cac_getwildcard( var_6, var_8 );

            var_7["secondary"] = maps\mp\gametypes\_class::cac_getweapon( var_6, 1 );
            var_7["secondaryAttachment1"] = maps\mp\gametypes\_class::cac_getweaponattachment( var_6, 1 );
            var_7["secondaryAttachment2"] = maps\mp\gametypes\_class::cac_getweaponattachmenttwo( var_6, 1 );
            var_7["secondaryAttachment3"] = maps\mp\gametypes\_class::cac_getweaponattachmentthree( var_6, 1 );
            var_7["secondaryCamo"] = maps\mp\gametypes\_class::cac_getweaponcamo( var_6, 1 );
            var_7["secondaryReticle"] = maps\mp\gametypes\_class::cac_getweaponreticle( var_6, 1 );
            var_7["equipment"] = maps\mp\gametypes\_class::cac_getequipment( var_6, 0 );
            var_7["offhand"] = maps\mp\gametypes\_class::cac_getequipment( var_6, 1 );
            self.loadouts[var_4][var_6] = var_7;
        }
    }

    level.forcecustomclassloc = undefined;
}

_id_9ABC( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21 )
{
    var_22 = int( self._id_2522 );
    var_23 = maps\mp\_utility::cac_getcustomclassloc();
    self.loadouts[var_23][var_22]["primary"] = var_0;
    self.loadouts[var_23][var_22]["primaryAttachment1"] = var_1;
    self.loadouts[var_23][var_22]["primaryAttachment2"] = var_2;
    self.loadouts[var_23][var_22]["primaryAttachment3"] = var_3;
    self.loadouts[var_23][var_22]["primaryCamo"] = var_4;
    self.loadouts[var_23][var_22]["primaryReticle"] = var_5;
    self.loadouts[var_23][var_22]["secondary"] = var_6;
    self.loadouts[var_23][var_22]["secondaryAttachment1"] = var_7;
    self.loadouts[var_23][var_22]["secondaryAttachment2"] = var_8;
    self.loadouts[var_23][var_22]["secondaryCamo"] = var_9;
    self.loadouts[var_23][var_22]["secondaryReticle"] = var_10;
    self.loadouts[var_23][var_22]["equipment"] = var_11;
    self.loadouts[var_23][var_22]["lethal"] = var_11;
    self.loadouts[var_23][var_22]["offhand"] = var_12;
    self.loadouts[var_23][var_22]["tactical"] = var_12;
    self.loadouts[var_23][var_22]["wildcard0"] = var_13;
    self.loadouts[var_23][var_22]["wildcard1"] = var_14;
    self.loadouts[var_23][var_22]["wildcard2"] = var_15;
    self.loadouts[var_23][var_22]["perk0"] = var_16;
    self.loadouts[var_23][var_22]["perk1"] = var_17;
    self.loadouts[var_23][var_22]["perk2"] = var_18;
    self.loadouts[var_23][var_22]["perk3"] = var_19;
    self.loadouts[var_23][var_22]["perk4"] = var_20;
    self.loadouts[var_23][var_22]["perk5"] = var_21;
}

_id_57D4( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( var_0.primary != var_1.primary )
        return 1;

    if ( var_0._id_033C != var_1._id_033C )
        return 1;

    if ( var_0.primaryattachment2 != var_1.primaryattachment2 )
        return 1;

    if ( var_0.primaryattachment3 != var_1.primaryattachment3 )
        return 1;

    if ( var_0.primarycamo != var_1.primarycamo )
        return 1;

    if ( var_0.secondary != var_1.secondary )
        return 1;

    if ( var_0._id_03AD != var_1._id_03AD )
        return 1;

    if ( var_0.secondaryattachment2 != var_1.secondaryattachment2 )
        return 1;

    if ( var_0.secondarycamo != var_1.secondarycamo )
        return 1;

    if ( var_0._id_0428 != var_1._id_0428 )
        return 1;

    if ( var_0._id_0253 != var_1._id_0253 )
        return 1;

    return 0;
}

_id_2237( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        if ( !isdefined( var_1 ) )
            return 0;

        return 1;
    }

    if ( var_0.size != var_1.size )
        return 1;

    if ( !maps\mp\gametypes\_teams::validcostume( var_1 ) )
        return 0;

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2] < 0 )
            return 0;

        if ( var_0[var_2] != var_1[var_2] )
            return 1;
    }

    return 0;
}

_id_7F43( var_0 )
{
    if ( var_0[level._id_2238["head"]] == 0 )
        var_0[level._id_2238["head"]] = 1;

    if ( !var_0[level._id_2238["shirt"]] )
        var_0[level._id_2238["shirt"]] = 1;

    if ( !var_0[level._id_2238["pants"]] )
        var_0[level._id_2238["pants"]] = 1;

    if ( !var_0[level._id_2238["gloves"]] )
        var_0[level._id_2238["gloves"]] = 1;

    if ( !var_0[level._id_2238["shoes"]] )
        var_0[level._id_2238["shoes"]] = 1;

    if ( !var_0[level._id_2238["gear"]] )
        var_0[level._id_2238["gear"]] = 1;

    if ( !var_0[level._id_2238["exo"]] )
        var_0[level._id_2238["exo"]] = 1;

    return var_0;
}

_id_5DB8()
{
    level._id_5A76 = [];

    for (;;)
    {
        while ( !isdefined( level.players ) || level.players.size == 0 || !isdefined( level._id_1A3E ) )
            wait 0.05;

        while ( isdefined( level.players ) && level.players.size > 0 )
        {
            foreach ( var_1 in level._id_5A76 )
            {
                var_2 = tablelookup( "mp/statstable.csv", 0, var_1.primary, 4 );
                var_3 = tablelookup( "mp/attachmenttable.csv", 0, var_1._id_033C, 3 );
                var_4 = tablelookup( "mp/attachmenttable.csv", 0, var_1.primaryattachment2, 3 );
                var_5 = tablelookup( "mp/attachmenttable.csv", 0, var_1.primaryattachment3, 3 );
                var_6 = var_1.primarycamo;
                var_7 = tablelookup( "mp/camoTable.csv", 0, var_1.primarycamo, 1 );
                var_8 = var_1.primaryreticle;
                var_9 = tablelookup( "mp/reticleTable.csv", 0, var_1.primaryreticle, 1 );
                var_10 = tablelookup( "mp/statstable.csv", 0, var_1.secondary, 4 );
                var_11 = tablelookup( "mp/attachmenttable.csv", 0, var_1._id_03AD, 3 );
                var_12 = tablelookup( "mp/attachmenttable.csv", 0, var_1.secondaryattachment2, 3 );
                var_13 = "none";
                var_14 = var_1.secondarycamo;
                var_15 = tablelookup( "mp/camoTable.csv", 0, var_1.secondarycamo, 1 );
                var_16 = var_1.secondaryreticle;
                var_17 = tablelookup( "mp/reticleTable.csv", 0, var_1.secondaryreticle, 1 );
                var_18 = tablelookup( "mp/perktable.csv", 0, var_1._id_0253, 1 );
                var_19 = tablelookup( "mp/perktable.csv", 0, var_1._id_0428, 1 );
                var_20 = tablelookup( "mp/perktable.csv", 0, var_1._id_0525, 1 );
                var_21 = tablelookup( "mp/perktable.csv", 0, var_1._id_0526, 1 );
                var_22 = tablelookup( "mp/perktable.csv", 0, var_1._id_0527, 1 );
                var_23 = tablelookup( "mp/perktable.csv", 0, var_1._id_0303, 1 );
                var_24 = tablelookup( "mp/perktable.csv", 0, var_1._id_0304, 1 );
                var_25 = tablelookup( "mp/perktable.csv", 0, var_1._id_0305, 1 );
                var_26 = tablelookup( "mp/perktable.csv", 0, var_1._id_0306, 1 );
                var_27 = tablelookup( "mp/perktable.csv", 0, var_1._id_0307, 1 );
                var_28 = tablelookup( "mp/perktable.csv", 0, var_1._id_0308, 1 );
                var_29 = maps\mp\gametypes\_class::buildweaponname( var_2, var_3, var_4, var_5, var_6, var_8 );
                var_30 = maps\mp\gametypes\_class::buildweaponname( var_10, var_11, var_12, var_13, var_14, var_16 );
                var_31 = maps\mp\_utility::getbaseweaponname( var_29 );
                var_32 = [];
                var_32[level._id_2238["gender"]] = var_1._id_01B7;
                var_32[level._id_2238["shirt"]] = var_1._id_03C2;
                var_32[level._id_2238["head"]] = var_1._id_01E3;
                var_32[level._id_2238["pants"]] = var_1._id_02ED;
                var_32[level._id_2238["eyewear"]] = var_1._id_016B;
                var_32[level._id_2238["hat"]] = var_1._id_01E2;
                var_32[level._id_2238["kneepads"]] = var_1._id_0241;
                var_32[level._id_2238["gloves"]] = var_1._id_01BE;
                var_32[level._id_2238["shoes"]] = var_1._id_03C3;
                var_32[level._id_2238["gear"]] = var_1._id_01B6;
                var_32[level._id_2238["exo"]] = var_1._id_015A;
                var_33 = [];

                if ( isdefined( var_20 ) )
                    var_33[var_20] = 1;

                if ( isdefined( var_21 ) )
                    var_33[var_21] = 1;

                if ( isdefined( var_22 ) )
                    var_33[var_22] = 1;

                if ( !isdefined( level._id_A3A7[var_1.xuid] ) && _id_A75B::_id_09DF() )
                    _id_A75B::_id_74E0( var_1.xuid );

                if ( !isdefined( level._id_A3A7[var_1.xuid] ) )
                {
                    var_34 = _id_A75B::_id_0735( var_1.xuid );
                    _id_A75B::vlprint( "PartyMemberClassChange " + var_1.xuid + " : " + var_29 + "," + var_30 + "," + var_18 + "," + var_19 + "\\n" );
                    setdvar( "virtuallobbymembers", level._id_A3A7.size );
                    var_35 = maps\mp\gametypes\vlobby::getspawnpoint( var_34 );
                    _id_88C8( var_35, var_29, var_30, var_31, var_18, var_19, var_33, var_32, var_1.name, var_34, 0 );
                    _id_A75B::_id_1178( var_34 );
                    getchallengerewarditem( level._id_9EA2[var_34], var_1.xuid );
                    level._id_9EA2[var_34].loadout = var_1;
                    level._id_9EA2[var_34]._id_5BA4 = gettime() + 4000;

                    if ( level._id_9EA2.size == 1 )
                    {
                        var_36 = level.players[0]._id_1B06;
                        _id_9E94( var_36, level._id_9EA2[var_34].costume );
                        var_37 = var_36 maps\mp\gametypes\_teams::playercostume();
                    }

                    if ( isdefined( level._id_9E97 ) )
                        _id_483F( level._id_9EA2[var_34] );

                    continue;
                }

                var_34 = level._id_A3A7[var_1.xuid];
                var_38 = level._id_9EA2[var_34];

                if ( var_1._id_031E >= 0 )
                {
                    if ( level._id_9E9F == var_34 )
                        level.players[0] _id_9ABC( var_2, var_3, var_4, var_5, var_7, var_9, var_10, var_11, var_12, var_15, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28 );

                    if ( isdefined( var_38._id_6F51 ) )
                    {
                        if ( isdefined( var_38._id_00D8 ) && isdefined( var_38._id_00D8[var_38._id_6F51] ) )
                            var_32 = var_38._id_00D8[var_38._id_6F51];
                        else
                            var_32 = level.players[0] maps\mp\gametypes\_class::cao_getcostumebyindex( var_38._id_6F51 );

                        var_32 = _id_7F43( var_32 );

                        if ( !isdefined( var_38._id_00D8 ) )
                            var_38._id_00D8 = [];

                        var_38._id_00D8[var_38._id_6F51] = var_32;

                        if ( var_38._id_6F52 != "none" )
                        {
                            var_39 = level._id_2238[var_38._id_6F52];
                            var_32[var_39] = var_38._id_6F53;
                        }
                    }
                }

                if ( _id_57D4( var_38.loadout, var_1 ) || _id_2237( var_38.costume, var_32 ) || isdefined( level._id_39AB ) && level._id_39AB )
                {
                    _id_A75B::vlprint( "Updating xuid " + var_1.xuid + " with ownerId=" + var_34 + "\\n" );
                    _id_A75B::vlprint( "PartyMemberClassChange " + var_1.xuid + " : " + var_29 + "," + var_30 + "," + var_18 + "," + var_19 + "\\n" );

                    if ( isdefined( var_38.player ) )
                        var_38.player.costume = var_32;

                    _id_9E95( var_38.player, var_34, var_29, var_30, var_31, var_18, var_19, var_33, var_32 );

                    if ( var_1._id_031E >= 0 )
                        _id_9E95( var_38.player, var_34, undefined, var_30, var_31, var_18, var_19, var_33, var_32, level.players[0]._id_1B06 );

                    var_38.loadout = var_1;
                    level._id_39AB = 0;
                }
            }

            level._id_5A76 = [];
            _id_A75B::_id_9A97();
            wait 0.05;
        }
    }
}

vl_vfx_for_avatar()
{
    if ( isdefined( self ) && !_func_294( self ) )
    {
        maps\mp\gametypes\_class::checkforcostumeset();

        if ( isdefined( self.costumebonus ) && isdefined( self.costumebonus["xp"] ) )
        {
            self.set_bonus_vfx = 1;

            if ( !isdefined( self.camera_state ) || self.camera_state != "crouch" || self == level.players[0]._id_1B06 )
            {
                if ( !isdefined( self.spawned_vfx_setbonus_stand ) || _func_294( self.spawned_vfx_setbonus_stand ) )
                {
                    if ( isdefined( self.spawned_vfx_setbonus_crouch ) && !_func_294( self.spawned_vfx_setbonus_crouch ) )
                        self.spawned_vfx_setbonus_crouch delete();

                    self.spawned_vfx_setbonus_stand = spawnfx( level.vfx_setbonus_stand_01, self.origin );
                    setwinningteam( self.spawned_vfx_setbonus_stand, 1 );
                    triggerfx( self.spawned_vfx_setbonus_stand, -6 );
                }
            }
            else if ( !isdefined( self.spawned_vfx_setbonus_crouch ) || _func_294( self.spawned_vfx_setbonus_crouch ) )
            {
                if ( isdefined( self.spawned_vfx_setbonus_stand ) && !_func_294( self.spawned_vfx_setbonus_stand ) )
                    self.spawned_vfx_setbonus_stand delete();

                self.spawned_vfx_setbonus_crouch = spawnfx( level.vfx_setbonus_crouch_01, self.origin );
                setwinningteam( self.spawned_vfx_setbonus_crouch, 1 );
                triggerfx( self.spawned_vfx_setbonus_crouch, -6 );
            }
        }
        else
        {
            self.set_bonus_vfx = 0;

            if ( isdefined( self.spawned_vfx_setbonus_crouch ) && !_func_294( self.spawned_vfx_setbonus_crouch ) )
                self.spawned_vfx_setbonus_crouch delete();

            if ( isdefined( self.spawned_vfx_setbonus_stand ) && !_func_294( self.spawned_vfx_setbonus_stand ) )
                self.spawned_vfx_setbonus_stand delete();
        }
    }
}

_id_661E( var_0 )
{
    if ( !isdefined( level.practice_round_costume ) )
    {
        level.practice_round_max_costumes = tablegetrowcount( level.practiceroundcostumetablename ) - 1;
        level.practice_round_costume = randomint( level.practice_round_max_costumes );
    }

    if ( !isdefined( level.practice_round_class ) )
    {
        var_1 = tablegetrowcount( level.practiceroundclasstablename ) - 1;
        level.practice_round_class = randomint( var_1 );
    }

    var_4 = var_0;
    var_5 = getcodanywherecurrentplatform( level.practiceroundcostumetablename, level.practice_round_costume + 1 );
    var_4._id_01B7 = var_5[level._id_2238["gender"]];
    var_4._id_03C2 = var_5[level._id_2238["shirt"]];
    var_4._id_01E3 = var_5[level._id_2238["head"]];
    var_4._id_02ED = var_5[level._id_2238["pants"]];
    var_4._id_016B = var_5[level._id_2238["eyewear"]];
    var_4._id_01E2 = var_5[level._id_2238["hat"]];
    var_4._id_01B6 = var_5[level._id_2238["gear"]];
    var_4._id_0241 = var_5[level._id_2238["kneepads"]];
    var_4._id_01BE = var_5[level._id_2238["gloves"]];
    var_4._id_03C3 = var_5[level._id_2238["shoes"]];
    var_4._id_015A = var_5[level._id_2238["exo"]];
    var_6 = level.practice_round_class;
    var_7 = var_6 + 1;
    var_8 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimary", var_7 );
    var_9 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment", var_7 );
    var_10 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment2", var_7 );
    var_11 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryAttachment3", var_7 );
    var_12 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryCamo", var_7 );
    var_13 = tablelookup( level.practiceroundclasstablename, 0, "loadoutPrimaryReticle", var_7 );
    var_4.primary = int( tablelookup( "mp/statstable.csv", 4, var_8, 0 ) );
    var_4._id_033C = int( tablelookup( "mp/attachmenttable.csv", 3, var_9, 0 ) );
    var_4.primaryattachment2 = int( tablelookup( "mp/attachmenttable.csv", 3, var_10, 0 ) );
    var_4.primaryattachment3 = int( tablelookup( "mp/attachmenttable.csv", 3, var_11, 0 ) );
    var_4.primarycamo = int( tablelookup( "mp/camoTable.csv", 1, var_12, 0 ) );
    var_4.primaryreticle = int( tablelookup( "mp/reticleTable.csv", 1, var_13, 0 ) );
    var_14 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondary", var_7 );
    var_15 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment", var_7 );
    var_16 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryAttachment2", var_7 );
    var_17 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryCamo", var_7 );
    var_18 = tablelookup( level.practiceroundclasstablename, 0, "loadoutSecondaryReticle", var_7 );
    var_4.secondary = int( tablelookup( "mp/statstable.csv", 4, var_14, 0 ) );
    var_4._id_03AD = int( tablelookup( "mp/attachmenttable.csv", 3, var_15, 0 ) );
    var_4.secondaryattachment2 = int( tablelookup( "mp/attachmenttable.csv", 3, var_16, 0 ) );
    var_4.secondarycamo = int( tablelookup( "mp/camoTable.csv", 1, var_17, 0 ) );
    var_4.secondaryreticle = int( tablelookup( "mp/reticleTable.csv", 1, var_18, 0 ) );
    var_19 = tablelookup( level.practiceroundclasstablename, 0, "loadoutWildcard1", var_7 );
    var_20 = tablelookup( level.practiceroundclasstablename, 0, "loadoutWildcard2", var_7 );
    var_21 = tablelookup( level.practiceroundclasstablename, 0, "loadoutWildcard3", var_7 );
    var_4._id_0525 = int( tablelookup( "mp/perktable.csv", 1, var_19, 0 ) );
    var_4._id_0526 = int( tablelookup( "mp/perktable.csv", 1, var_20, 0 ) );
    var_4._id_0527 = int( tablelookup( "mp/perktable.csv", 1, var_21, 0 ) );
    return var_4;
}

_id_0782( var_0 )
{
    if ( getdvarint( "practiceroundgame" ) )
        var_0 = _id_661E( var_0 );

    for ( var_1 = 0; var_1 < level._id_5A76.size; var_1++ )
    {
        if ( level._id_5A76[var_1].xuid == var_0.xuid )
        {
            level._id_5A76[var_1] = var_0;
            var_0 = undefined;
            break;
        }
    }

    if ( isdefined( var_0 ) )
        level._id_5A76[level._id_5A76.size] = var_0;
}

_id_66A5( var_0 )
{
    if ( !isdefined( level._id_A3A7 ) )
        return;

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2.xuid;
        var_4 = level._id_A3A7[var_3];

        if ( isdefined( var_4 ) )
        {
            var_5 = level._id_9EA2[var_4];

            if ( isdefined( var_5 ) )
            {
                var_5._id_5BA4 = gettime() + 2000;
                var_5._id_5B9F = undefined;
            }
        }

        if ( var_2.primary >= 0 )
            _id_0782( var_2 );
    }
}

_id_5DBA()
{
    for (;;)
    {
        var_0 = getdvarint( "splitscreen", 0 );
        var_1 = _func_2BB();
        var_2 = isonlinegame();

        foreach ( var_5, var_4 in level._id_9EA2 )
        {
            if ( _id_A75B::_id_1179( var_5 ) )
                continue;

            if ( var_4._id_5BA4 >= 0 )
            {
                if ( var_4._id_5BA4 < gettime() )
                {
                    if ( var_5 == 0 && !isdefined( var_4._id_5B9F ) )
                    {
                        var_4._id_5BA4 = gettime() + 2000;
                        var_4._id_5B9F = 1;
                        continue;
                    }

                    _id_A75B::vlprint( "Schedule removal of ownerId " + var_5 + " from timeout\\n" );
                    _id_A75B::_id_7862( var_5 );
                }
            }
        }

        wait 0.05;
    }
}

_id_3D4A( var_0 )
{
    var_1 = "mp/E3CostumeTable.csv";
    var_2 = [];

    for ( var_3 = 0; var_3 < level._id_2238.size; var_3++ )
        var_2[var_3] = int( tablelookupbyrow( var_1, var_3 + 1, var_0 + 1 ) );

    return var_2;
}

_id_5D7E( var_0, var_1 )
{

}

_id_5DB9()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_0, var_1 );

        if ( var_0 == "member_select" )
        {
            level._id_9E99 = level._id_A3A7[var_1];

            if ( !isdefined( level._id_9E99 ) )
            {
                _id_A75B::vlprint( "vl_focus undefined, setting to 0\\n" );
                level._id_9E99 = 0;
            }

            _id_A75B::vlprint( "selected member " + var_1 + " ownerId=" + level._id_9E99 + "\\n" );
        }

        if ( var_0 == "vlpresentable" )
        {
            _id_A75B::vlprint( "in main menu\\n" );
            thread _id_834B();
        }

        if ( var_0 == "leave_lobby" )
        {
            _id_A75B::vlprint( "leave_lobby xuid=" + var_1 + "\\n" );

            if ( var_1 == "0" )
            {
                foreach ( var_1, var_3 in level._id_A3A7 )
                {
                    _id_A75B::vlprint( "Schedule removal of ownerId " + var_3 + "\\n" );
                    _id_A75B::_id_7862( var_3, 0.25 );
                }
            }
            else
            {
                var_3 = level._id_A3A7[var_1];

                if ( isdefined( var_3 ) )
                {
                    _id_A75B::vlprint( "Schedule removal of ownerId " + var_3 + "\\n" );
                    _id_A75B::_id_7862( var_3, 0.25 );
                }
            }

            thread _id_7464();
        }
    }
}

_id_5D6A( var_0 )
{
    if ( var_0 < 0 )
        level._id_9E96 = undefined;
    else
    {
        level._id_9E9F = _id_3F9C( var_0 );
        level._id_9E96 = 1;
        _id_A75B::vlprint( "cao ctrl = " + var_0 + " focus = " + level._id_9E9F + "\\n" );
    }
}

_id_1B14( var_0 )
{
    _id_A75B::vlprintln( "Cao set costumes from lua:" + var_0 );
    var_1 = strtok( var_0, "#" );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "|" );

        if ( var_4.size > 0 )
        {
            var_5 = int( var_4[0] );
            var_6 = _id_3F9C( var_5 );
            var_7 = level._id_9EA2[var_6];

            if ( isdefined( var_7 ) )
            {
                var_7._id_0015 = int( var_4[1] );

                for ( var_8 = 2; var_8 < var_4.size; var_8++ )
                {
                    var_9 = strtok( var_4[var_8], "," );
                    var_10 = [];

                    for ( var_11 = 1; var_11 < var_9.size; var_11++ )
                        var_10[var_10.size] = int( var_9[var_11] );

                    if ( !isdefined( var_7._id_00D8 ) )
                        var_7._id_00D8 = [];

                    var_7._id_00D8[int( var_9[0] )] = var_10;
                }
            }
        }
    }
}

_id_5D6B( var_0 )
{
    var_1 = strtok( var_0, ":" );
    var_2 = int( var_1[0] );
    var_3 = strtok( var_1[1], "," );
    var_4 = _id_3F9C( var_2 );
    level._id_9E9F = var_4;
    var_5 = level._id_9EA2[var_4];

    if ( isdefined( var_5 ) )
    {
        var_5._id_6F51 = int( var_3[0] );
        var_5._id_6F52 = var_3[1];
        var_5._id_6F53 = int( var_3[2] );
    }

    return var_5;
}

_id_5D7A( var_0 )
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_1, var_2 );

        if ( var_1 == "cao" )
        {
            _id_5D6A( var_2 );
            level._id_1B1C = undefined;

            if ( isdefined( level._id_9E9F ) )
                var_3 = level._id_9EA2[level._id_9E9F];
            else
                var_3 = level._id_9EA2[var_0];

            if ( var_2 < 0 && isdefined( var_3 ) )
            {
                var_3._id_6F52 = undefined;
                var_3._id_6F53 = undefined;
                var_3._id_6F51 = undefined;

                if ( isdefined( var_3._id_00D8 ) )
                    _id_9E94( var_3, var_3._id_00D8[var_3._id_0015], 1 );
            }

            continue;
        }

        if ( var_1 == "lootscreen_gear_highlighted" )
        {
            level._id_1975 = undefined;
            _id_5D6A( var_2 );

            if ( isdefined( level._id_9E96 ) )
                level._id_1B1C = ( 56.0, 0.0, 5.0 );
            else
                level._id_1B1C = undefined;

            level._id_1A3E._id_705C = "prelobby_loot";
            continue;
        }

        if ( var_1 == "costumes" )
        {
            _id_1B14( var_2 );
            continue;
        }

        if ( var_1 == "costume_preview" )
        {
            _id_5D6B( var_2 );
            continue;
        }

        if ( var_1 == "costume_apply" )
        {
            var_3 = _id_5D6B( var_2 );

            if ( isdefined( var_3 ) )
            {
                var_4 = level._id_2238[var_3._id_6F52];

                if ( isdefined( var_3._id_00D8 ) && isdefined( var_3._id_00D8[var_3._id_6F51] ) )
                {
                    var_3._id_00D8[var_3._id_6F51][var_4] = var_3._id_6F53;

                    if ( var_3._id_6F51 == var_3._id_0015 )
                        var_3 setcostumemodels( var_3._id_00D8[var_3._id_6F51] );
                }
            }

            continue;
        }

        if ( var_1 == "costume_set_apply" )
        {
            var_5 = strtok( var_2, ":" );
            var_6 = int( var_5[0] );
            var_7 = int( var_5[1] );
            var_0 = _id_3F9C( var_6 );
            var_3 = level._id_9EA2[var_0];

            if ( !isdefined( var_3._id_00D8 ) || !isdefined( var_3._id_00D8[var_7] ) )
            {
                var_8 = level.players[0] maps\mp\gametypes\_class::cao_getcostumebyindex( var_7 );
                var_8 = _id_7F43( var_8 );

                if ( !isdefined( var_3._id_00D8 ) )
                    var_3._id_00D8 = [];

                var_3._id_00D8[var_7] = var_8;
            }

            var_9 = strtok( var_5[2], "|" );

            foreach ( var_11 in var_9 )
            {
                var_12 = strtok( var_11, "," );
                var_13 = var_12[0];
                var_14 = int( var_12[1] );
                var_4 = level._id_2238[var_13];
                var_3._id_00D8[var_7][var_4] = var_14;
            }

            var_3 setcostumemodels( var_3._id_00D8[var_7] );
        }
    }
}

clans_set_highlight_gear_from_lua( var_0 )
{
    setdvar( "vl_clan_models_loaded", 0 );
    var_1 = strtok( var_0, "#" );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "|" );

        if ( var_4.size > 0 )
        {
            var_5 = int( var_4[0] );
            var_6 = level.players[0].clan_agents[var_5];

            if ( isdefined( var_6 ) )
            {
                var_6._id_0015 = 0;
                var_6.isvalidhighlight = int( var_4[1] ) > 0;

                for ( var_7 = 2; var_7 < var_4.size; var_7++ )
                {
                    var_8 = strtok( var_4[var_7], "," );
                    var_9 = [];

                    for ( var_10 = 1; var_10 < var_8.size; var_10++ )
                        var_9[var_9.size] = int( var_8[var_10] );

                    if ( !isdefined( var_6._id_00D8 ) )
                        var_6._id_00D8 = [];

                    var_6._id_00D8[int( var_8[0] )] = var_9;
                    _id_9E94( var_6, var_9, 1 );

                    if ( var_6.isvalidhighlight )
                    {
                        _id_9FD2( var_6 );
                        continue;
                    }

                    _id_483F( var_6 );
                }
            }
        }
    }

    setdvar( "vl_clan_models_loaded", 1 );
}

_id_5D74()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_0, var_1 );

        if ( var_0 == "clanprofile" )
        {
            _id_A75B::vlprint( "Using clan profile VL settings\\n" );

            if ( var_1 < 0 )
                level._id_9E97 = undefined;
            else
                level._id_9E97 = var_1;

            continue;
        }

        if ( var_0 == "clan_highlight_data" )
        {
            _id_A75B::vlprint( "Handling clan highlight information\\n" );
            clans_set_highlight_gear_from_lua( var_1 );
        }
    }
}

_id_483F( var_0 )
{
    var_0 hide();
    var_0 _meth_804A();

    if ( isdefined( var_0.spawned_vfx_setbonus_crouch ) && !_func_294( var_0.spawned_vfx_setbonus_crouch ) )
        var_0.spawned_vfx_setbonus_crouch delete();

    if ( isdefined( var_0.spawned_vfx_setbonus_stand ) && !_func_294( var_0.spawned_vfx_setbonus_stand ) )
        var_0.spawned_vfx_setbonus_stand delete();

    _id_4843( var_0 );
}

_id_84B9( var_0 )
{
    if ( var_0.isfree )
        return;

    _id_07FA( var_0 );
    var_0 show();
    var_0 _meth_804C();

    if ( isdefined( var_0._id_6F8C ) )
    {
        var_0._id_6F8C show();
        var_0._id_6F8C _meth_804C();
    }

    if ( isdefined( var_0._id_7BF7 ) )
    {
        var_0._id_7BF7 show();
        var_0._id_7BF7 _meth_804C();
    }

    if ( isdefined( var_0._id_09AE ) && isdefined( var_0._id_09AE.primaryweapon ) )
    {
        if ( issubstr( var_0._id_09AE.primaryweapon, "akimbo" ) || issubstr( var_0._id_09AE.primaryweapon, "akimboxmg" ) )
        {
            var_0._id_09AE show();
            var_0._id_09AE _meth_804C();
        }
    }

    var_0 thread vl_vfx_for_avatar();
}

_id_4841( var_0 )
{
    if ( isdefined( var_0._id_6F8C ) )
    {
        var_0 notify( "hide_primary_weapon" );
        var_0._id_6F8C hide();
        var_0._id_6F8C _meth_804A();
    }
}

_id_4842( var_0 )
{
    if ( isdefined( var_0._id_7BF7 ) )
    {
        var_0 notify( "hide_secondary_weapon" );
        var_0._id_7BF7 hide();
        var_0._id_7BF7 _meth_804A();
    }
}

_id_4840( var_0 )
{
    if ( isdefined( var_0._id_09AE ) )
    {
        var_0 notify( "hide_akimbo_weapon" );
        var_0._id_09AE hide();
        var_0._id_09AE _meth_804A();
    }
}

_id_4843( var_0 )
{
    _id_4841( var_0 );
    _id_4842( var_0 );
    _id_4840( var_0 );
}

_id_4844()
{
    foreach ( var_1 in level._id_9EA2 )
        _id_483F( var_1 );
}

_id_84BA()
{
    foreach ( var_1 in level._id_9EA2 )
        _id_84B9( var_1 );
}

get_xuid_for_avatar( var_0 )
{
    foreach ( var_3, var_2 in level._id_A3A7 )
    {
        if ( isdefined( level._id_9EA2[var_2] ) && level._id_9EA2[var_2] == var_0 )
            return var_3;
    }

    return "";
}

_id_732F( var_0 )
{
    var_1 = -1;

    foreach ( var_3, var_1 in level._id_A3A7 )
    {
        if ( var_1 == var_0 )
            break;
    }

    _id_A75B::vlprint( "Removing xuid " + var_3 + " for ownerId " + var_0 + "\\n" );
    getchallengerewarditem( level._id_9EA2[var_0], var_3, 1 );
    level._id_A3A7[var_3] = undefined;
    level._id_117B[var_0]._id_9379 = 0;
    level._id_117B[var_0]._id_1177 = undefined;
    setdvar( "virtuallobbymembers", level._id_A3A7.size );
    var_4 = level._id_9EA2[var_0];
    level._id_9EA2[var_0] = undefined;

    if ( level._id_9E99 == var_0 )
    {
        if ( level._id_9EA2.size > 0 )
        {
            foreach ( var_7, var_6 in level._id_9EA2 )
            {
                level._id_9E99 = var_7;
                break;
            }
        }
    }

    _id_483F( var_4 );
    var_4 takeallweapons();
    var_4 detachall();
    var_4.headmodel = undefined;
    var_4 _meth_804A();

    if ( isdefined( var_4.avatar_spawnpoint._id_8999 ) )
        var_4.avatar_spawnpoint._id_8999 = undefined;

    if ( isdefined( var_4._id_6F8C ) )
    {
        getchallengerewarditem( var_4._id_6F8C, var_3, 1 );
        var_4._id_6F8C delete();
        var_4._id_6F8C = undefined;
    }

    if ( isdefined( var_4._id_7BF7 ) )
    {
        getchallengerewarditem( var_4._id_7BF7, var_3, 1 );
        var_4._id_7BF7 delete();
        var_4._id_7BF7 = undefined;
    }

    if ( isdefined( var_4._id_09AE ) )
    {
        getchallengerewarditem( var_4._id_09AE, var_3, 1 );
        var_4._id_09AE delete();
        var_4._id_09AE = undefined;
    }

    var_4.primaryweapon = undefined;
    var_4._id_8F12 = undefined;
    _id_A75B::free_avatar( var_4 );

    if ( level._id_9E99 == var_0 )
        level._id_9E99 = 0;
}

_id_7421()
{
    level notify( "stop_reset_bot_settings" );
    level endon( "stop_reset_bot_settings" );

    for ( var_0 = 0; var_0 < 2; var_0++ )
    {
        maps\mp\agents\_agent_common::set_agent_health( 100 );
        self _meth_8358();
        self _meth_8356();
        _id_15F9();
        self _meth_8351( "disable_movement", 1 );
        self _meth_8351( "disable_rotation", 1 );
        wait 0.05;
    }
}

_id_44E6( var_0 )
{
    self setangles( var_0 );
}

_id_9BC9( var_0, var_1, var_2 )
{
    var_3 = randomfloatrange( 0.85, 1.15 );
    var_4 = 0;

    if ( !isdefined( self._id_0C4C ) )
    {
        self _meth_83D0( "vlobby_animclass" );
        var_4 = 1;
        level notify( "stop_reset_bot_settings" );
        _id_44E6( self._id_88CA );
    }

    if ( !isdefined( var_2 ) )
    {
        var_2 = "lobby_idle";
        var_0 = "assault_pose_06";
    }

    self._id_0C4C = var_0;
    self._id_0C8C = var_2;
    self _meth_83D2( var_2, var_0, var_3 );

    if ( !isdefined( var_1 ) || !var_1 )
    {
        self._id_0C4C = var_0;

        if ( var_4 )
            _id_9E9A( self );
    }
}

_id_8B2D()
{
    if ( isdefined( level._id_1A3E ) && isdefined( level._id_1A3E._id_5D32 ) )
    {
        switch ( level._id_1A3E._id_5D32 )
        {
            case "prelobby":
            case "prelobby_loot":
                var_0 = 0;

                if ( isdefined( level._id_9EA2 ) )
                {
                    foreach ( var_2 in level._id_9EA2 )
                    {
                        if ( !isdefined( var_2._id_0C4C ) )
                        {
                            var_3 = var_2.avatar_spawnpoint _id_3784();

                            if ( isdefined( self._id_6631 ) && self._id_6631 == 0 )
                                var_0 = 8;
                            else if ( var_3 < level._id_6280 )
                                var_0 = var_3;
                            else
                            {
                                var_0++;

                                if ( var_0 >= level._id_6280 )
                                    var_0 = 0;
                            }

                            var_4 = "lobby_idle";
                            _id_9BC9( var_0, undefined, var_4 );
                        }
                    }
                }

                break;
            case "game_lobby":
            case "transition":
            case "cac":
                var_0 = 0;

                if ( isdefined( level._id_9EA2 ) )
                {
                    foreach ( var_2 in level._id_9EA2 )
                    {
                        if ( !isdefined( var_2._id_0C4C ) )
                        {
                            var_3 = var_2.avatar_spawnpoint _id_3784();

                            if ( isdefined( self._id_6631 ) && self._id_6631 == 0 )
                                var_0 = 8;
                            else if ( var_3 < level._id_6280 )
                                var_0 = var_3;
                            else
                            {
                                var_0++;

                                if ( var_0 >= level._id_6280 )
                                    var_0 = 0;
                            }

                            var_4 = "lobby_idle";
                            _id_9BC9( var_0, undefined, var_4 );
                        }
                    }
                }

                break;
            case "cao":
            case "clanprofile":
                if ( !isdefined( self._id_0C4C ) )
                {
                    if ( isdefined( self._id_6631 ) && self._id_6631 == 0 )
                        var_0 = 8;
                    else
                        var_0 = randomintrange( 0, level._id_6280 - 1 );

                    var_4 = "lobby_idle";
                    _id_9BC9( var_0, undefined, var_4 );
                }

                break;
            default:
                if ( !isdefined( self._id_0C4C ) )
                {
                    if ( isdefined( self._id_6631 ) && self._id_6631 == 0 )
                        var_0 = 8;
                    else
                        var_0 = randomintrange( 0, level._id_6280 - 1 );

                    var_4 = "lobby_idle";
                    _id_9BC9( var_0, undefined, var_4 );
                }

                break;
        }
    }
}

_id_8C45()
{
    if ( !isdefined( level._id_9EA2 ) )
        return;

    foreach ( var_1 in level._id_9EA2 )
    {
        if ( !isdefined( var_1._id_0C4C ) || !isdefined( var_1._id_0C8C ) )
        {
            var_2 = var_1 _id_3EF9( var_1.primaryweapon );
            var_1 _id_9BC9( var_2._id_09D6, undefined, var_2._id_0C8C );
        }
    }
}

_id_8BF6()
{
    if ( !isdefined( level._id_9EA2 ) )
        return;

    foreach ( var_1 in level._id_9EA2 )
    {
        if ( !isdefined( var_1._id_0C4C ) || !isdefined( var_1._id_0C8C ) )
        {
            var_2 = var_1 _id_3EF9( var_1.primaryweapon );
            var_1 _id_9BC9( var_2._id_09D6, undefined, var_2._id_0C8C );
        }
    }
}

_id_8B53()
{
    if ( !isdefined( level._id_9EA2 ) )
        return;

    foreach ( var_1 in level._id_9EA2 )
    {
        if ( !isdefined( var_1._id_0C4C ) || !isdefined( var_1._id_0C8C ) )
        {
            var_2 = var_1 _id_3EF9( var_1.primaryweapon );
            var_1 _id_9BC9( var_2._id_09D6, undefined, var_2._id_0C8C );
        }
    }
}

_id_3752( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    var_3[1] = var_1;
    var_4 = 20;

    for ( var_5 = 1; var_5 && var_4 > 0; var_3 = var_6 )
    {
        var_4--;
        var_5 = 0;
        var_6 = [];
        var_6[var_6.size] = var_3[0];
        var_7 = 0;
        var_8 = 0;

        for ( var_9 = 0; var_9 < var_3.size - 1 && !var_7; var_9++ )
        {
            var_10 = 1;
            var_11 = var_3[var_9];
            var_12 = var_3[var_9 + 1];

            while ( var_10 )
            {
                var_10 = 0;
                var_13 = undefined;
                var_14 = undefined;

                foreach ( var_16 in var_2 )
                {
                    var_17 = _id_948E( var_11, var_12, var_16 );

                    if ( var_17["intersect"] )
                    {
                        if ( distance2d( var_6[var_6.size - 1], var_17["closestpoint"] ) > 0.1 && distance2d( var_12, var_17["closestpoint"] ) > 0.1 )
                        {
                            var_10 = 1;

                            if ( !isdefined( var_14 ) || var_14["radratio"] > var_17["radratio"] )
                            {
                                var_13 = var_16;
                                var_14 = var_17;
                            }
                        }
                    }
                }

                if ( var_10 )
                {
                    var_5 = 1;

                    if ( length2d( var_11, var_13["center"] ) < var_13["radius"] )
                    {
                        var_11 = _id_5F1A( var_11, var_13 );
                        var_6[var_6.size - 1] = var_11;
                        var_10 = 0;
                        var_7 = 1;
                        var_8 = var_9 + 1;
                    }
                    else if ( length2d( var_12, var_13["center"] ) < var_13["radius"] )
                    {
                        var_12 = _id_5F1A( var_12, var_13 );
                        var_6[var_6.size] = var_12;
                        var_10 = 0;
                        var_7 = 1;
                        var_8 = var_9 + 2;
                    }
                    else
                    {
                        var_6[var_6.size] = var_14["closestpoint"];
                        var_6[var_6.size] = var_12;
                        var_10 = 0;
                    }

                    continue;
                }

                var_6[var_6.size] = var_12;
            }
        }

        if ( var_7 )
        {
            for ( var_9 = var_8; var_9 < var_3.size; var_9++ )
                var_6[var_6.size] = var_3[var_9];
        }
    }

    return var_3;
}

_id_5F1A( var_0, var_1 )
{
    var_2 = var_1["center"];
    var_3 = var_1["radius"];
    var_4 = vectornormalize( ( var_0[0] - var_2[0], var_0[1] - var_2[1], 0 ) );
    var_0 = ( var_2[0] + var_3 * var_4[0], var_2[1] + var_3 * var_4[1], var_0[2] );
    return var_0;
}

_id_948E( var_0, var_1, var_2 )
{
    var_3 = 5;
    var_4 = var_2["center"];
    var_5 = var_2["radius"];
    var_6 = var_5 + var_3;
    var_7 = ( var_1[0] - var_0[0], var_1[1] - var_0[1], 0 );
    var_8 = vectornormalize( var_7 );
    var_9 = length2d( var_7 );
    var_10 = ( var_4[0] - var_0[0], var_4[1] - var_0[1], 0 );
    var_11 = vectordot( var_8, var_10 );

    if ( var_11 < 0 )
        var_11 = 0.0;
    else if ( var_11 > var_9 )
        var_11 = var_9;

    var_12 = ( var_0[0] + var_11 * var_8[0], var_0[1] + var_11 * var_8[1], 0 );
    var_13 = var_11 / var_9;
    var_14 = ( var_12[0] - var_4[0], var_12[1] - var_4[1], 0 );
    var_9 = length2d( var_14 );
    var_15 = 0;
    var_16 = 1.0;

    if ( var_9 < var_5 )
    {
        var_15 = 1;
        var_14 = vectornormalize( var_14 );
        var_12 = ( var_4[0] + var_6 * var_14[0], var_4[1] + var_6 * var_14[1], var_0[2] + var_13 * ( var_1[2] - var_0[2] ) );
        var_16 = var_9 / var_5;
    }

    var_17 = [];
    var_17["intersect"] = var_15;
    var_17["fraction"] = var_13;
    var_17["closestpoint"] = var_12;
    var_17["radratio"] = var_16;
    return var_17;
}

_id_19C1( var_0, var_1, var_2 )
{
    var_3 = distance( var_0, var_2 );

    if ( var_3 > var_1 )
    {
        var_4 = vectornormalize( var_2 - var_0 );
        var_2 = var_0 + var_1 * var_4;
    }

    return var_2;
}

_id_5851( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_4[var_0];

    if ( var_0 + 1 >= var_4.size )
        return [ var_0, _id_19C1( var_1, var_2, var_4[var_0] ) ];

    var_6 = var_4[var_0 + 1];
    var_7 = distance( var_5, var_6 );
    var_8 = vectornormalize( var_6 - var_5 );
    var_9 = vectordot( var_8, var_1 - var_5 );

    if ( var_9 < 0 )
        var_9 = 0;

    if ( var_9 > var_7 )
        var_9 = var_7;

    var_10 = var_5 + var_9 * var_8;
    var_11 = var_3;
    var_12 = var_7 - var_9;
    var_13 = var_4[var_4.size - 1];

    while ( var_11 > 0 )
    {
        if ( var_12 > var_11 )
        {
            var_13 = var_10 + var_11 * var_8;
            var_11 = 0;
            continue;
        }

        if ( var_0 + 1 >= var_4.size )
        {
            var_13 = var_4[var_0];
            var_11 = 0;
        }

        var_11 -= var_12;
        var_0++;
        var_10 = var_4[var_0];
    }

    return [ var_0, _id_19C1( var_1, var_2, var_13 ) ];
}

_id_4D21( var_0 )
{
    var_0._id_2B7A = 0;
    var_0._id_66D9 = 0;
    var_0._id_2B7F = 0;
    var_0._id_66EE = 0;
    var_1 = var_0._id_66DF / var_0._id_66C5;

    if ( var_1 < var_0._id_66C8 )
        var_1 = var_0._id_66C8;

    if ( var_1 > var_0._id_66C6 )
        var_1 = var_0._id_66C6;

    var_0._id_66CF = 0.05 * var_1 / var_0._id_66BB;
    var_0._id_66D8 = 0.05 * var_1 / var_0._id_66BD;
    var_0._id_66F0 = var_1;
    var_0._id_66D0 = 1;
    var_0._id_66E5 = 0;
    var_0._id_66E6 = var_0._id_66C5;
    var_2 = var_0._id_66BD / 0.05;
    var_3 = 0;
    var_4 = var_1;

    for ( var_5 = 0; var_5 < var_2; var_5++ )
    {
        var_4 -= var_0._id_66D8;

        if ( var_4 < var_0._id_66C7 )
            var_4 = var_0._id_66C7;

        var_3 += var_4;
    }

    var_0._id_66EF = var_0._id_66DF - var_3;
    var_0._id_6851 = var_0._id_66E3;
}

_id_9AC8( var_0 )
{
    if ( var_0._id_2B7A < var_0._id_66EF )
    {
        var_0._id_66EE += var_0._id_66CF;

        if ( var_0._id_66EE > var_0._id_66F0 )
            var_0._id_66EE = var_0._id_66F0;
    }
    else
    {
        var_0._id_66EE -= var_0._id_66D8;

        if ( var_0._id_66EE < var_0._id_66C7 )
            var_0._id_66EE = var_0._id_66C7;
    }
}

_id_4D20( var_0 )
{
    var_0._id_66C6 = 15.0;
    var_0._id_66C8 = 1.8;
    var_0._id_66C7 = 0.3;
    var_0._id_66C5 = 0.5;
    var_0._id_66BB = 0.15 * var_0._id_66C5;
    var_0._id_66BD = 0.15 * var_0._id_66C5;
    var_0._id_66EA = 4.5;
    var_0._id_66E9 = 4.5;
}

_id_1860( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = _id_3752( var_0.origin, var_3, var_0._id_632A );
    var_0.path = var_5;
    var_6 = 0;

    foreach ( var_9, var_8 in var_0.path )
    {
        if ( var_9 > 0 )
            var_6 += distance( var_0.path[var_9], var_0.path[var_9 - 1] );
    }

    var_0._id_66E5 = 0;
    var_0._id_66E6 = var_0._id_66C5;
    var_0._id_66DF = var_6;
    var_0._id_66E2 = anglestoforward( var_0.angles );
    var_0._id_66DC = anglestoforward( var_4 );
    var_0._id_66E3 = angleclamp180( var_0.angles[0] );
    var_0._id_66DA = var_0._id_66E3;
    var_0._id_66DD = angleclamp180( var_4[0] );
    var_0._id_66E4 = angleclamp180( var_0.angles[1] );
    var_0._id_66DE = angleclamp180( var_4[1] );
    var_0._id_66E1 = var_2;
    var_0._id_66DB = var_3;
    var_0._id_66E7 = ( 0.0, 0.0, 0.0 );
    var_10 = vectornormalize( var_0._id_66DB - var_0._id_66E1 );
    var_11 = vectordot( var_10, var_0._id_66E2 );
    var_12 = vectordot( var_10, var_0._id_66DC );
    var_13 = 0;

    if ( var_12 < -0.707 && var_11 < -0.707 )
        var_13 = 1;

    var_0._id_66E0 = var_13;
    _id_4D21( var_0 );
}

_id_3782( var_0, var_1, var_2 )
{
    var_3 = anglestoforward( var_0 );
    var_4 = var_2 - var_1;
    var_5 = vectordot( var_4, var_3 );
    var_6 = var_1 + var_3 * var_5;
    return var_6;
}

_id_8566( var_0, var_1 )
{
    var_2 = -0.5;
    var_0 += var_2;
    var_0 *= ( 2 * var_1 );
    var_3 = sqrt( 1 + var_1 * var_1 ) / 2 * var_1;
    var_4 = 0.5;
    var_5 = var_3 * var_0 / sqrt( 1 + var_0 * var_0 ) + var_4;
    return var_5;
}

_id_56AA( var_0, var_1 )
{
    var_2 = angleclamp180( var_1[0] );
    var_3 = angleclamp180( var_0.angles[0] );
    var_4 = angleclamp180( var_1[1] - var_0.angles[1] );
    var_5 = angleclamp180( var_2 - var_3 );

    if ( var_4 < -1 * var_0._id_66EA )
        var_4 = -1 * var_0._id_66EA;

    if ( var_4 > var_0._id_66EA )
        var_4 = var_0._id_66EA;

    if ( var_5 < -1 * var_0._id_66E9 )
        var_5 = -1 * var_0._id_66E9;

    if ( var_5 > var_0._id_66E9 )
        var_5 = var_0._id_66E9;

    var_6 = ( var_5, var_4, 0 );
    var_0.angles += var_6;

    if ( abs( var_5 ) < 0.1 && abs( var_4 ) < 0.1 )
        return 1;
    else
        return 0;
}

_id_9A9F( var_0, var_1 )
{
    var_2 = var_0._id_66E5 / var_0._id_66E6;
    var_2 = _id_8566( var_2, 2 );
    var_3 = var_0.angles;
    var_4 = var_2 * ( var_0._id_66DD - var_0._id_66E3 ) + var_0._id_66E3;
    var_5 = var_0._id_66E4 + var_2 * ( var_0._id_66DE - var_0._id_66E4 );
    var_6 = var_0.angles[1] + angleclamp180( var_5 - var_0.angles[1] );
    var_3 = ( var_4, var_6, var_3[2] );
    return _id_56AA( var_0, var_3 );
}

_id_9AA2( var_0 )
{
    var_1 = var_0._id_66E5 / var_0._id_66E6;
    var_1 = _id_8566( var_1, 2 );
    var_2 = var_1 * var_0._id_66DF;
    var_0._id_66D9 = 0;
    var_0._id_2B7F = 0;
    var_0._id_2B7A = 0;

    while ( var_2 > 0 )
    {
        var_3 = distance( var_0.path[var_0._id_66D9], var_0.path[var_0._id_66D9 + 1] );
        var_4 = var_3 - var_0._id_2B7F;

        if ( var_4 > var_2 )
        {
            var_0._id_2B7F += var_2;
            var_5 = var_0.path[var_0._id_66D9] + var_0._id_2B7F * vectornormalize( var_0.path[var_0._id_66D9 + 1] - var_0.path[var_0._id_66D9] );
            var_0._id_66E7 = var_5 - var_0.origin;
            var_0.origin = var_5;
            var_0._id_2B7A += var_2;
            var_2 = 0;
            continue;
        }

        var_2 -= var_4;
        var_0._id_66D9++;

        if ( var_0._id_66D9 >= var_0.path.size - 1 )
        {
            if ( var_0._id_66D9 < var_0.path.size )
                var_5 = var_0.path[var_0._id_66D9];
            else
                var_5 = var_0.path[var_0.path.size - 1];

            var_0._id_66E7 = var_5 - var_0.origin;
            var_0.origin = var_5;
            var_0._id_2B7A = var_0._id_66DF;
            var_2 = 0;
            continue;
        }

        var_0._id_2B7A += var_4;
        var_0._id_2B7F = 0;
    }
}

_id_9AA0( var_0, var_1 )
{
    var_2 = 0;
    var_0._id_66E5 += 0.05;

    if ( var_0._id_66E5 >= var_0._id_66E6 )
    {
        var_0._id_66E5 = var_0._id_66E6;
        var_2 = 1;
        var_0._id_66E7 = ( 0.0, 0.0, 0.0 );
    }

    _id_9AA2( var_0 );
    _id_9A9F( var_0, var_1 );
    return var_2;
}

_id_3E89( var_0 )
{
    var_1 = "j_neck";
    var_2 = var_0 gettagorigin( var_1 );
    return var_2;
}

_id_19BD( var_0 )
{
    var_1 = _id_75F6( var_0 );
    var_2 = var_1._id_1A25;
    var_3 = var_1._id_1A24;
    var_4 = _id_3E89( var_0 );
    var_5 = var_2;
    var_6 = var_2 + anglestoforward( var_3 ) * 64;
    return _id_19BC( var_5, var_6, var_4 );
}

_id_19BE( var_0 )
{
    var_1 = var_0.origin;
    var_2 = var_0._id_1A17.origin;
    var_3 = var_0._id_1A18.origin;
    return _id_19BC( var_2, var_3, var_1 );
}

_id_19BC( var_0, var_1, var_2 )
{
    var_3 = var_1;
    var_4 = var_0;
    var_5 = var_2;
    var_6 = [];
    var_7 = vectornormalize( vectorcross( var_3 - var_4, ( 0.0, 0.0, 1.0 ) ) );
    var_8 = vectornormalize( vectorcross( var_7, var_3 - var_4 ) );
    var_9 = var_5 - var_4;
    var_10 = var_5 - vectordot( var_8, var_9 ) * var_8;
    var_11 = var_5 - vectordot( var_7, var_9 ) * var_7;
    var_12 = distance( var_10, var_3 );
    var_13 = distance( var_10, var_4 );
    var_14 = var_12 / var_13;
    var_15 = 1;

    if ( vectordot( var_9, var_7 ) < 0 )
        var_15 = -1;

    var_6["fx"] = var_14;
    var_6["sx"] = var_15;
    var_16 = distance( var_11, var_3 );
    var_17 = distance( var_11, var_4 );
    var_18 = var_16 / var_17;
    var_19 = 1;

    if ( vectordot( var_9, var_8 ) < 0 )
        var_19 = -1;

    var_6["fz"] = var_18;
    var_6["sz"] = var_19;
    return var_6;
}

_id_19BF( var_0, var_1 )
{
    var_2 = getdvarfloat( "cg_fov", 45 ) * getdvarfloat( "cg_fovScale", 1.0 );
    var_3 = 1.0;
    var_4 = tan( var_2 );
    var_5 = [];
    var_6 = var_4 * abs( var_0 );
    var_7 = 1;

    if ( var_0 < 0 )
        var_7 = -1;

    var_8 = var_6 / sqrt( 1 - var_6 * var_6 );
    var_5["sx"] = var_7;
    var_5["fx"] = var_8;
    var_9 = var_3 * var_4 * abs( var_1 );
    var_10 = 1;

    if ( var_1 < 0 )
        var_10 = -1;

    var_11 = var_9 / sqrt( 1 - var_9 * var_9 );
    var_5["sz"] = var_10;
    var_5["fz"] = var_11;
    return var_5;
}

_id_19BB( var_0, var_1, var_2 )
{
    var_3 = var_1;
    var_4 = var_2;
    var_5 = var_4 - var_3;
    var_6 = vectornormalize( vectorcross( var_5, ( 0.0, 0.0, 1.0 ) ) );
    var_7 = vectornormalize( vectorcross( var_6, var_5 ) );
    var_8 = var_5 - vectordot( var_5, var_7 ) * var_7;
    var_9 = length( var_8 );
    var_10 = var_0["fx"];
    var_11 = var_0["sx"];
    var_12 = var_9 * var_10;
    var_9 = var_9 * var_10 * var_10;
    var_13 = var_9 * var_10 * sqrt( 1 - var_10 * var_10 );
    var_14 = var_9 * var_8 + var_13 * var_6;
    var_15 = var_5 - vectordot( var_5, var_6 ) * var_6;
    var_16 = length( var_15 );
    var_17 = var_0["fz"];
    var_18 = var_0["sz"];
    var_19 = var_16 * var_17;
    var_16 = var_16 * var_17 * var_17;
    var_20 = var_16 * var_17 * sqrt( 1 - var_17 * var_17 );
    var_21 = var_16 * var_15 + var_20 * var_7;
    var_22 = var_4 + var_11 * var_14 + var_18 * var_21;
    return var_22;
}

_id_2690( var_0 )
{
    var_1 = ( 1.0, 1.0, 1.0 );
    var_2 = var_0[0];
    var_3 = var_2;
    var_4 = 0;
    var_5 = 10;
    var_6 = 30;

    if ( level._id_9BD7 )
    {
        for (;;)
        {
            var_7 = _id_5851( var_4, var_2, var_5, var_6, var_0 );
            var_4 = var_7[0];
            var_3 = var_7[1];

            if ( distance( var_2, var_3 ) < 0.1 )
                break;

            var_2 = var_3;

            if ( var_4 >= var_0.size )
                break;
        }
    }
    else
    {
        for ( var_8 = 0; var_8 < var_0.size - 1; var_8++ )
        {

        }
    }
}

_id_268F( var_0 )
{
    var_1 = ( 1.0, 0.5, 0.0 );

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3["center"];
        var_5 = var_3["radius"];
    }
}

_id_268B( var_0 )
{
    var_1 = 1;
    var_2 = var_1;
    var_3 = 36;
    _id_4D21( var_0 );
    var_0._id_919D = _id_3E89( var_0._id_91BC );

    while ( !_id_9AA0( var_0 ) )
    {
        var_4 = var_0._id_919D;
        var_5 = _id_19BB( var_0._id_3A03, var_0.origin, var_4 );
        var_2--;

        if ( var_2 <= 0 )
            var_2 = var_1;
    }

    var_0.angles = ( angleclamp180( var_0.angles[0] ), angleclamp180( var_0.angles[1] ), angleclamp180( var_0.angles[2] ) );
    var_0 dontinterpolate();
}

_id_92A2( var_0, var_1, var_2, var_3 )
{
    level notify( "stop_test_pathing" );
    level endon( "stop_test_pathing" );
    var_4 = getentarray( "player_pos", "targetname" );
    var_5 = var_2._id_8999;
    var_6 = _id_75F6( var_5 );
    var_7 = var_6._id_1A25;
    var_8 = var_6._id_1A24;
    var_9 = var_7;
    var_10 = var_8;
    var_11 = var_0.origin;
    var_12 = var_11 + anglestoforward( var_0.angles ) * 64;
    var_13 = var_9 + anglestoforward( var_10 ) * 64;
    var_0.origin = var_11;
    var_0.angles = var_10;
    var_0._id_632A = var_3;
    _id_4D20( var_0 );
    _id_1860( var_0, undefined, var_0.origin, var_9, var_10 );
    var_0._id_3A03 = _id_19BD( var_5 );
    var_0._id_91BC = var_5;

    for (;;)
    {
        var_0.origin = var_11;
        var_0.angles = var_10;
        _id_2690( var_0.path );
        _id_268F( var_0._id_632A );
        _id_268B( var_0 );
        wait 0.05;
    }
}

_id_26B2()
{
    var_0 = 0;
    var_1 = getentarray( "player_pos", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = getent( var_3.target, "targetname" );

        if ( var_4.script_noteworthy == "camera_target" )
            var_3._id_1A18 = var_4;

        var_5 = getent( var_4.target, "targetname" );

        if ( var_5.script_noteworthy == "camera" )
        {
            var_3._id_1A17 = var_5;
            var_5._id_1A16 = var_3;
            var_5._id_1A18 = var_3._id_1A18;
        }
    }

    var_7 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_7 setmodel( "tag_player" );
    level._id_9BD7 = 0;
    var_8 = 0;
    var_9 = 1;
    var_10 = "111111111111111111";
    var_11 = 16;

    for (;;)
    {
        if ( self fragbuttonpressed() )
        {
            while ( self fragbuttonpressed() )
                wait 0.05;

            var_9++;

            if ( var_9 >= 12 )
                var_9 = 0;

            if ( var_9 == var_8 )
            {
                var_9++;

                if ( var_9 >= 12 )
                    var_9 = 0;
            }

            var_0 = 1;
        }

        if ( self secondaryoffhandbuttonpressed() )
        {
            while ( self secondaryoffhandbuttonpressed() )
                wait 0.05;

            var_8++;

            if ( var_8 >= 12 )
                var_8 = 0;

            if ( var_9 == var_8 )
            {
                var_8++;

                if ( var_8 >= 12 )
                    var_8 = 0;
            }

            var_0 = 1;
        }

        if ( var_0 )
        {
            var_0 = 0;
            var_12 = [];
            var_13 = undefined;
            var_14 = undefined;

            foreach ( var_18, var_16 in var_1 )
            {
                if ( getsubstr( var_10, var_18, var_18 + 1 ) == "0" )
                    continue;

                var_17 = [];
                var_17["center"] = var_16.origin;
                var_17["radius"] = var_11;
                var_12[var_12.size] = var_17;

                if ( var_16.script_noteworthy == "" + var_8 )
                    var_13 = var_16;

                if ( var_16.script_noteworthy == "" + var_9 )
                    var_14 = var_16;
            }

            thread _id_92A2( var_7, var_13, var_14, var_12 );
        }

        wait 0.2;
    }
}

_id_2698( var_0 )
{
    level._id_2698 = 1;
    var_1 = 30;
    var_2 = 10;
    var_3 = 10;
    var_4 = self _meth_844D();
    var_5 = self _meth_82F3();
    var_6 = anglestoforward( var_4 );
    var_7 = anglestoup( var_4 );
    var_8 = anglestoright( var_4 );
    var_9 = 0;

    if ( self adsbuttonpressed() )
        var_9 = -1;
    else if ( self attackbuttonpressed() )
        var_9 = 1;

    if ( self secondaryoffhandbuttonpressed() )
    {
        var_1 *= 0.1;
        var_2 *= 0.1;
        var_3 *= 0.1;
    }

    var_0.angles = var_4;
    var_0.origin = var_0.origin + var_5[0] * var_1 * var_6 + var_5[1] * var_2 * var_8 + var_9 * var_3 * var_7;
}

_id_9EA9( var_0, var_1 )
{
    if ( !isdefined( self._id_9C6B ) )
    {
        self._id_9C6B = newclienthudelem( self );
        self._id_9C6B.x = 0;
        self._id_9C6B.y = 0;
        self._id_9C6B setshader( var_1, 640, 480 );
        self._id_9C6B.alignx = "left";
        self._id_9C6B.aligny = "top";
        self._id_9C6B.horzalign = "fullscreen";
        self._id_9C6B.vertalign = "fullscreen";
        self._id_9C6B.alpha = var_0;
    }

    if ( isdefined( self._id_9C6B ) && self._id_9C6B.alpha > 0 && var_0 == 0 )
    {
        self._id_9C6B setshader( var_1, 640, 480 );
        self._id_9C6B.alpha = 0;
    }

    if ( isdefined( self._id_9C6B ) && self._id_9C6B.alpha < 1 && var_0 == 1 )
    {
        self._id_9C6B setshader( var_1, 640, 480 );
        self._id_9C6B.alpha = 1;
    }
}
