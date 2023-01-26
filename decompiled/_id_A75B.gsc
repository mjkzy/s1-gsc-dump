// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

vlprint( var_0 )
{

}

vlprintln( var_0 )
{

}

_id_9E9D()
{
    level.vl_onspawnplayer = ::onspawnplayer;
    _id_9EA0();
}

_id_9EA0()
{
    setdvar( "r_dof_physical_enable", 1 );
    setdvar( "r_dof_physical_bokehEnable", 1 );
    setdvar( "r_adaptiveSubdiv", 0 );
    setdvar( "r_eyePupil", 0.15 );
    setdvar( "r_uiblurdstmode", 3 );
    setdvar( "r_blurdstgaussianblurradius", 1.5 );
    _func_2D5();
    level.partymembers_cb = maps\mp\_vl_camera::_id_66A5;
    level._id_9EA2 = [];
    level._id_A3A7 = [];
    level._id_9E99 = 0;
    level._id_117B = [];
    level.vfx_setbonus_crouch_01 = loadfx( "vfx/ui/complete_set_crouching" );
    level.vfx_setbonus_stand_01 = loadfx( "vfx/ui/complete_set_standing" );
    var_0 = 18;

    if ( level.ps3 || level.xenon )
        var_0 = 12;

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        level._id_117B[var_1] = spawnstruct();
        level._id_117B[var_1]._id_9379 = 0;
        level._id_117B[var_1].xuid = "";
    }

    level.maxavatars = var_0;
    thread maps\mp\_vl_camera::_id_5DB8();
    thread maps\mp\_vl_camera::_id_5DBA();
    setdvar( "virtuallobbymembers", 0 );
    level._id_6280 = 4;
    maps\mp\_vl_firingrange::_id_4CEC();
    maps\mp\_vl_selfiebooth::_id_4D55();
}

init_avatars()
{
    var_0 = 4;
    var_1 = level.maxavatars + var_0;
    level.vlavatarpool = [];

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = maps\mp\agents\_agent_utility::_id_3FA0();
        level.vlavatarpool[var_2] = var_3;
        var_3 _meth_838A( ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
        var_3 maps\mp\_vl_camera::_id_7DAC( "spectator", "none" );
        var_3 maps\mp\agents\_agent_common::set_agent_health( 100 );
        var_3 _meth_8358();
        var_3 _meth_8356();
        var_3 maps\mp\_vl_camera::_id_15F9();
        var_3 _meth_8351( "disable_movement", 1 );
        var_3 _meth_8351( "disable_rotation", 1 );
        var_3.isfree = 1;
    }
}

alloc_avatar()
{
    if ( !isdefined( level.vlavatarpool ) )
        init_avatars();

    foreach ( var_1 in level.vlavatarpool )
    {
        if ( var_1.isfree )
        {
            var_1.isfree = 0;
            return var_1;
        }
    }
}

free_avatar( var_0 )
{
    var_0 notify( "free_avatar" );
    var_0.isfree = 1;
}

onspawnplayer()
{
    level._id_0897["player"]["on_killed"] = ::on_agent_player_killed;
    thread maps\mp\_vl_camera::_id_9EA8();
    level._id_6D63[0] = 3;
    thread maps\mp\_vl_camera::_id_5DB9();
    thread maps\mp\_vl_camera::_id_5D7A( 0 );
    thread maps\mp\_vl_camera::_id_5D79( 0 );
    thread maps\mp\_vl_camera::_id_5D74();
    thread _id_5DC7( self );
    _id_2AC4();
    self setdemigod( 1 );
    self setmlgspectator( 0 );
}

on_agent_player_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{

}

player_sticks_in_lefty_config()
{
    if ( common_scripts\utility::is_player_gamepad_enabled() )
    {
        var_0 = self _meth_820E( "gpadSticksConfig" );
        return isdefined( var_0 ) && ( var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacy" );
    }

    return 0;
}

player_setup_lefty_angle( var_0 )
{
    if ( !isdefined( var_0.fakeangle ) )
    {
        if ( isdefined( var_0._id_8F15 ) )
            var_0.fakeangle = var_0._id_8F15;
        else
            var_0.fakeangle = 0;
    }
}

player_get_right_stick_y( var_0 )
{
    if ( player_sticks_in_lefty_config() )
    {
        player_setup_lefty_angle( var_0 );
        return var_0.fakeangle;
    }
    else
    {
        var_1 = self _meth_844D();
        return var_1[1];
    }
}

player_update_right_stick_y( var_0 )
{
    var_1 = 0;

    if ( player_sticks_in_lefty_config() )
    {
        player_setup_lefty_angle( var_0 );
        var_2 = self _meth_82F3();
        var_3 = -12;
        var_4 = var_2[1] * var_3;
        var_0.fakeangle = angleclamp( var_0.fakeangle + var_4 );
        var_1 = var_0.fakeangle;
    }
    else
    {
        var_2 = self _meth_844D();
        var_1 = var_2[1];

        if ( isdefined( var_0.fakeangle ) )
            var_0.fakeangle = undefined;
    }

    return var_1;
}

_id_6F0C( var_0, var_1 )
{
    var_0._id_8F15 = player_get_right_stick_y( var_0 );
    var_0._id_760D = 0;
    var_0._id_8F14 = var_0.angles[1];
    var_0.mouserot = 0;
    var_0._id_6E60 = 0;
    var_0._id_6088 = 0;
    var_0._id_0845 = 0;
    var_1 = ( 0, var_1[1], 0 );

    if ( isdefined( var_1 ) )
    {
        if ( isagent( var_0 ) )
            var_0 maps\mp\_vl_camera::_id_44E6( var_1 );
        else
            var_0.angles = var_1;
    }
}

_id_1179( var_0 )
{
    return level._id_117B[var_0]._id_9379 > 0;
}

_id_7862( var_0, var_1 )
{
    maps\mp\_vl_camera::_id_732F( var_0 );
}

_id_09DF()
{
    if ( level._id_9EA2.size == 0 )
        return 0;

    foreach ( var_2, var_1 in level._id_117B )
    {
        if ( !isdefined( level._id_9EA2[var_2] ) )
            continue;

        if ( var_1._id_9379 == 0 )
            return 0;
    }

    return 1;
}

_id_74E0( var_0 )
{
    var_1 = undefined;

    foreach ( var_4, var_3 in level._id_A3A7 )
    {
        var_1 = level._id_9EA2[var_3];
        level._id_9EA2[var_3] = undefined;
        getchallengerewarditem( var_1, var_4, 1 );
        level._id_A3A7[var_4] = undefined;
    }

    level._id_A3A7[var_0] = 0;
    level._id_117B[0]._id_9379 = 0;
    level._id_117B[0].xuid = var_0;

    if ( isdefined( var_1 ) )
    {
        getchallengerewarditem( var_1, var_0 );
        level._id_9EA2[0] = var_1;
    }
}

_id_0735( var_0 )
{
    var_1 = -1;
    var_2 = -1;

    while ( var_2 == var_1 )
    {
        var_1++;

        foreach ( var_2 in level._id_A3A7 )
        {
            if ( var_2 == var_1 )
                break;
        }
    }

    vlprint( "Adding new xuid " + var_0 + " with ownerId=" + var_1 + "\\n" );
    level._id_A3A7[var_0] = var_1;
    level._id_117B[var_1].xuid = var_0;
    level._id_117B[var_1]._id_9379 = 0;
    return var_1;
}

_id_1178( var_0 )
{
    if ( isdefined( level._id_6085 ) )
        thread maps\mp\_vl_camera::_id_834B();
}

_id_9A97()
{
    var_0 = 0;

    foreach ( var_3, var_2 in level._id_117B )
    {
        if ( var_2._id_9379 > 0 && gettime() > var_2._id_9379 )
        {
            vlprint( "update_avatars removing ownerId" + var_3 + "\\n" );
            maps\mp\_vl_camera::_id_732F( var_3 );
            var_0 = 1;
        }
    }

    if ( var_0 )
        wait 0.1;
}

_id_485A()
{
    foreach ( var_2, var_1 in level._id_9EA2 )
    {
        if ( var_2 == 0 )
            continue;

        maps\mp\_vl_camera::_id_483F( var_1 );
    }

    if ( level._id_1A3E._id_5D32 != "prelobby" )
        level._id_1A3E.camera._id_2569 = 1;

    level._id_9E99 = 0;
    level._id_63BB = level._id_9E99;
}

_id_84DF()
{
    foreach ( var_2, var_1 in level._id_9EA2 )
    {
        if ( var_2 == 0 )
            continue;

        maps\mp\_vl_camera::_id_84B9( var_1 );
    }
}

_id_7525( var_0, var_1 )
{
    var_2 = player_update_right_stick_y( var_0 );
    var_3 = angleclamp( var_2 - var_0._id_8F15 );
    var_4 = getdvarfloat( "ui_mouse_char_rot", 0 );

    if ( var_4 != 0 )
    {
        var_0.mouserot = angleclamp( var_0.mouserot + var_4 );
        setdynamicdvar( "ui_mouse_char_rot", 0 );
    }

    var_5 = maps\mp\_vl_camera::_id_4025( var_0, var_3, var_1 );
    var_5 *= -1;
    var_6 = angleclamp( var_0._id_8F14 + var_5 + var_0.mouserot );
    var_7 = ( 0, var_6, 0 );

    if ( isagent( var_0 ) )
        var_0 setangles( var_7 );
    else
        var_0.angles = var_7;
}

_id_6CBD( var_0 )
{
    var_1 = player_get_right_stick_y( var_0 );
    var_2 = angleclamp( var_1 - var_0._id_8F15 );

    if ( self._id_4748 == 0 )
    {
        if ( abs( var_2 ) >= 1 )
        {
            var_0._id_8F14 = var_0.angles[1];
            return 1;
        }
        else
            return 0;
    }
    else
        return 1;
}

_id_2AC4()
{
    self notify( "kill_enable_weapons" );
    self _meth_8131( 0 );
}

_id_30E4()
{
    self endon( "enter_lobby" );
    self endon( "kill_enable_weapons" );
    var_0 = getdvarint( "virtualLobbyInFiringRange", 0 );

    if ( var_0 == 1 && level._id_4C00 == 1 )
        self _meth_8131( 1 );
}

_id_3300( var_0 )
{
    maps\mp\_vl_firingrange::_id_262F();
    var_1 = var_0.camera;
    var_0 setorigin( var_1.origin );
    var_0 playerlinkto( var_1, "tag_player" );
    var_0 cameralinkto( var_1, "tag_player" );
    var_0 setclientdvar( "cg_fovscale", "0.6153" );
    var_0 visionsetnakedforplayer( "mp_virtual_lobby_cac", 0 );

    if ( isdefined( level._id_9EA2 ) && isdefined( level._id_63BB ) && isdefined( level._id_9EA2[level._id_63BB] ) )
        var_0 _id_6F0C( level._id_9EA2[level._id_63BB], level._id_9EA2[level._id_63BB].angles );

    level._id_4C00 = 0;
    var_0 _meth_8131( 0 );
    maps\mp\_utility::updatesessionstate( "spectator" );
}

_id_5DC7( var_0 )
{
    for (;;)
    {
        if ( isdefined( level._id_4C00 ) )
        {
            var_1 = getdvarint( "virtualLobbyInFiringRange", 0 );

            if ( var_1 == 1 && !level._id_4C00 )
            {
                var_2 = maps\mp\_utility::getclassindex( "lobby" + ( var_0._id_2522 + 1 ) );
                var_3 = maps\mp\_utility::cac_getcustomclassloc();
                var_4 = var_0.loadouts[var_3][var_2];
                var_5 = var_4["primary"];
                var_6 = var_4["secondary"];

                if ( isdefined( level._id_9EA2 ) && isdefined( level._id_63BB ) && isdefined( level._id_9EA2[level._id_63BB] ) )
                    var_0 _id_6F0C( level._id_9EA2[level._id_63BB], level._id_9EA2[level._id_63BB].angles );

                var_7 = [];

                if ( isdefined( var_5 ) && var_5 != "specialty_null" )
                    var_7[var_7.size] = maps\mp\gametypes\_class::buildweaponname( var_5, var_4["primaryAttachment1"], var_4["primaryAttachment2"], var_4["primaryAttachment3"], 0, 0 );

                if ( isdefined( var_6 ) && var_6 != "specialty_null" )
                    var_7[var_7.size] = maps\mp\gametypes\_class::buildweaponname( var_6, var_4["secondaryAttachment1"], var_4["secondaryAttachment2"], var_4["secondaryAttachment3"], 0, 0 );

                while ( var_7.size > 0 )
                {
                    var_8 = var_0 loadweapons( var_7 );

                    if ( var_8 == 1 )
                        break;

                    wait 0.05;
                }

                var_0 showviewmodel();
                maps\mp\_vl_firingrange::_id_32EF( var_0 );
                var_0 _meth_84D8( "mp_no_foley", 1 );
                setdvar( "r_dof_physical_bokehEnable", 0 );
                setdvar( "r_dof_physical_enable", 0 );
                setdvar( "r_uiblurdstmode", 0 );
                setdvar( "r_blurdstgaussianblurradius", 1 );
            }
            else if ( var_1 == 0 && level._id_4C00 )
            {
                var_0 hideviewmodel();
                var_0 _id_3805();
                var_0 _id_2AC4();

                if ( isdefined( var_0.primaryweapon ) )
                    var_0 switchtoweapon( var_0.primaryweapon );

                var_0 notify( "enter_lobby" );
                _id_3300( var_0 );
                var_0 _meth_84D7( "mp_no_foley", 1 );
                setdvar( "r_dof_physical_enable", 1 );
                setdvar( "r_dof_physical_bokehEnable", 1 );
                setdvar( "r_uiblurdstmode", 3 );
                setdvar( "r_blurdstgaussianblurradius", 1.5 );
            }
        }

        wait 0.05;
    }
}

_id_3805()
{
    var_0 = self;
    var_0 maps\mp\_vl_firingrange::_id_43F7();
    var_0 thread maps\mp\_vl_firingrange::_id_754C();
    var_1 = var_0 getweaponslistoffhands();

    foreach ( var_3 in var_1 )
        var_0 maps\mp\gametypes\_class::takeoffhand( var_3 );
}
