// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4D55()
{
    var_0 = getent( "selfie_player_pos", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = getent( var_0.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    level._id_7C72 = spawnstruct();
    level._id_7C72._id_6BBE = var_0;
    level._id_7C72.camera_pos = var_2;
    setdvarifuninitialized( "scr_vlobby_selfie_correction_y", 32.0 );
    setdvarifuninitialized( "scr_vlobby_selfie_collision_z", 10.0 );
    level thread _id_76B2();
}

_id_76B2()
{
    while ( !isdefined( level.player ) )
        waitframe();

    level.player spawnselfieavatar();
    wait 5;

    for (;;)
    {
        waitframe();

        if ( isonlinegame() || !_func_2BB() || getdvarint( "practiceroundgame" ) )
            continue;

        if ( !_id_847A() )
            continue;

        _id_9115();
    }
}

spawnselfieavatar()
{
    while ( !isdefined( level.player._id_8999 ) || !isdefined( level.player._id_8999.costume ) )
        waitframe();

    var_0 = level._id_7C72._id_6BBE.origin;
    var_1 = getdvarfloat( "scr_vlobby_selfie_collision_z", 0.0 );
    var_2 = getdvarfloat( "scr_vlobby_selfie_correction_y", 0.0 );
    var_3 = ( 0, var_2, var_1 );
    var_0 += var_3;
    var_4 = level._id_7C72._id_6BBE.angles;
    var_5 = maps\mp\agents\_agent_utility::_id_3FA0( "selfie_clone" );
    var_5.isactive = 1;
    var_5 _meth_838A( var_0, var_4, undefined, undefined, undefined, undefined, 1 );
    var_6 = level.player getxuid();
    getchallengerewarditem( var_5, var_6 );
    var_5 _meth_83D1( 1 );
    var_5 _meth_83D0( "vlobby_animclass" );
    var_5 _meth_83D2( "lobby_idle", "selfie_01", 1.0 );
    var_5 setcostumemodels( level.player._id_8999.costume );
    var_5 linkto( level._id_7C72._id_6BBE );
    level._id_7C72.clone = var_5;
    self.selfie_clone = var_5;
}

_id_847A()
{
    if ( !isdefined( level.player ) )
        return 0;

    if ( !isdefined( level.player._id_8999 ) || !isdefined( level.player._id_8999.costume ) )
        return 0;

    if ( !level.player _meth_84FE() )
        return 0;

    if ( level.player _meth_84FD() )
        return 0;

    return 1;
}

_id_9115()
{
    if ( !isdefined( level._id_7C72.clone ) )
        return;

    if ( !isdefined( level.player ) )
        return;

    if ( !isdefined( level.player._id_8999 ) )
        return;

    if ( !isdefined( level.player._id_8999.costume ) )
        return;

    var_0 = level._id_7C72.clone.origin;
    var_1 = level._id_7C72.clone geteye();
    level._id_7C72.clone setcostumemodels( level.player._id_8999.costume );
    waitframe();

    if ( !level.player _meth_853A( level._id_7C72.camera_pos.origin, var_0, var_1[2] - var_0[2], 0, 0 ) )
        return;

    while ( isdefined( level.player ) && !level.player _meth_8501() )
        waitframe();
}
