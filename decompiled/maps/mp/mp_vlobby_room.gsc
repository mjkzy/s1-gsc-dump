// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    precachemodel( "archery_target_fr" );
    precachemodel( "bc_target_dummy_base" );
    precachemodel( "training_target_opfor1" );
    precachemodel( "training_target_civ1" );
    precacheshader( "ac130_overlay_pip_vignette_vlobby" );
    precacheshader( "ac130_overlay_pip_vignette_vlobby_cao" );
    _id_A77E::main();
    maps\createart\mp_vlobby_room_art::main();
    _id_A77D::main();
    maps\mp\_load::main();
    maps\mp\mp_vlobby_room_lighting::main();
    maps\mp\mp_vlobby_room_aud::main();
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_9E98 = ::_id_9E98;
    level._id_9E9C = ::_id_9E9C;
    level._id_9E9E = ::_id_9E9E;
    thread _id_9E9B();
    _id_A75B::_id_9E9D();
    level._id_2C75 = spawnstruct();
    level._id_2C75._id_3ADB = 0.25;
    level._id_2C75._id_7830 = -0.3;
    level._id_2C75._id_3ADA = 3;
    thread _id_35D8();
}

_id_35D8()
{
    level waittill( "connected", var_0 );
    var_0 waittill( "fade_in" );
    var_0 _meth_84D7( "mp_no_foley", 1 );
}

_id_9E9B()
{
    var_0 = getent( "teleport_from", "targetname" );
    var_1 = getent( "teleport_to", "targetname" );
    var_2 = getentarray( "vlobby_floor_b", "targetname" );

    foreach ( var_4 in var_2 )
        var_4.origin += var_1.origin - var_0.origin;

    var_6 = getentarray( "vlobby_floor_a", "targetname" );

    foreach ( var_8 in var_6 )
        var_8 hide();
}

_id_9E9E()
{
    var_0 = self;
    var_0 _meth_84A9();

    if ( level.nextgen )
        var_0 _meth_84AB( 0.613159, 89.8318, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 * 2 );
    else
        var_0 _meth_84AB( 4.01284, 95.2875, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 * 2 );
}

_id_9E98( var_0 )
{
    var_1 = level._id_1A3E._id_2C73;
    var_2 = self;
    var_3 = var_0;
    var_2 = self;
    var_4 = level._id_2C75._id_3ADB;
    var_5 = level._id_2C75._id_7830;
    var_6 = level._id_2C75._id_3ADA;

    if ( level.currentgen )
        var_6 += 2;

    var_7 = 104;
    var_8 = ( var_7 - var_3 ) * var_4;
    var_9 = var_6 + var_8 + var_8 * var_5;

    if ( var_9 < 0.125 )
        var_9 = 0.125;
    else if ( var_9 > 128 )
        var_9 = 128;

    var_2 _meth_84AB( var_9, var_3, var_1, var_1 * 2 );
}

_id_9E9C( var_0, var_1, var_2 )
{
    var_3 = self;

    if ( var_0 == "cac" )
        var_3 _id_7F47();
    else if ( var_0 == "cao" )
    {

    }

    if ( var_1 == "cac" )
    {
        var_3 visionsetnakedforplayer( "mp_vlobby_room_cac", 0 );
        var_3 lightsetforplayer( "mp_vl_create_a_class" );
    }
    else if ( var_1 == "cao" )
    {
        if ( level.nextgen )
            var_3 _meth_84AB( 1.223, 156.419, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 );
        else
            var_3 _meth_84AB( 3.223, 156.419, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 );
    }
    else if ( var_1 == "clanprofile" )
    {
        var_3 _id_7F47();
        var_3 maps\mp\_vl_camera::_id_7DD5();
    }
    else if ( var_1 == "prelobby" )
    {
        var_3 _id_7F44();
        var_3 _id_7F47();
    }
    else
    {
        if ( var_0 == "prelobby_members" )
            return;

        if ( var_0 == "prelobby_loadout" )
            return;

        if ( var_0 == "prelobby_loot" )
            return;

        if ( var_1 == "game_lobby" )
        {
            var_3 _id_7F47();
            var_3 maps\mp\_vl_camera::_id_7DD5();
        }
        else
        {
            if ( var_0 == "startmenu" )
                return;

            if ( var_0 == "transition" )
                return;

            if ( var_1 == "clanprofile" )
            {
                var_3 _id_7F44();
                var_3 _id_7F47();
            }
            else
            {
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

    if ( level.nextgen )
        var_0 _meth_84AB( 0.613159, 89.8318, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 );
    else
        var_0 _meth_84AB( 4.01284, 95.2875, level._id_1A3E._id_2C73, level._id_1A3E._id_2C73 );
}
