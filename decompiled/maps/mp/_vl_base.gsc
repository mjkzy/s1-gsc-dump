// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

vlprint( var_0 )
{

}

vlprintln( var_0 )
{

}

vl_init()
{
    level.vl_onspawnplayer = ::onspawnplayer;
    vl_main();
}

vl_main()
{
    setdvar( "r_dof_physical_enable", 1 );
    setdvar( "r_dof_physical_bokehEnable", 1 );
    setdvar( "r_adaptiveSubdiv", 0 );
    setdvar( "r_eyePupil", 0.15 );
    setdvar( "r_uiblurdstmode", 3 );
    setdvar( "r_blurdstgaussianblurradius", 1.5 );
    _func_2D5();
    level.partymembers_cb = maps\mp\_vl_camera::party_members;
    level.vlavatars = [];
    level.xuid2ownerid = [];
    level.vl_focus = 0;
    level.avatarinfo = [];
    level.vfx_setbonus_crouch_01 = loadfx( "vfx/ui/complete_set_crouching" );
    level.vfx_setbonus_stand_01 = loadfx( "vfx/ui/complete_set_standing" );
    var_0 = 18;

    if ( level.ps3 || level.xenon )
        var_0 = 12;

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        level.avatarinfo[var_1] = spawnstruct();
        level.avatarinfo[var_1].timetodelete = 0;
        level.avatarinfo[var_1].xuid = "";
    }

    level.maxavatars = var_0;
    thread maps\mp\_vl_camera::monitor_member_class_changes();
    thread maps\mp\_vl_camera::monitor_member_timeouts();
    setdvar( "virtuallobbymembers", 0 );
    level.num_lobby_idles = 4;
    maps\mp\_vl_firingrange::init_firingrange();
    maps\mp\_vl_selfiebooth::init_selfiebooth();
}

init_avatars()
{
    var_0 = 4;
    var_1 = level.maxavatars + var_0;
    level.vlavatarpool = [];

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = maps\mp\agents\_agent_utility::getfreeagent();
        level.vlavatarpool[var_2] = var_3;
        var_3 _meth_838A( ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_3 maps\mp\_vl_camera::set_agent_values( "spectator", "none" );
        var_3 maps\mp\agents\_agent_common::set_agent_health( 100 );
        var_3 _meth_8358();
        var_3 _meth_8356();
        var_3 maps\mp\_vl_camera::bot_disable_tactical_goals();
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
    level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
    thread maps\mp\_vl_camera::vlobby_player();
    level.playerstatus[0] = 3;
    thread maps\mp\_vl_camera::monitor_member_focus_change();
    thread maps\mp\_vl_camera::monitor_create_an_operator( 0 );
    thread maps\mp\_vl_camera::monitor_create_a_class( 0 );
    thread maps\mp\_vl_camera::monitor_clans();
    thread monitor_move_btn_fr_vl( self );
    disable_player_controls();
    self setdemigod( 1 );
    self _meth_8506( 0 );
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
        if ( isdefined( var_0.storedrightsticky ) )
            var_0.fakeangle = var_0.storedrightsticky;
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

prep_for_controls( var_0, var_1 )
{
    var_0.storedrightsticky = player_get_right_stick_y( var_0 );
    var_0.rotation_total = 0;
    var_0.storedangley = var_0.angles[1];
    var_0.mouserot = 0;
    var_0.positivewrap = 0;
    var_0.negativewrap = 0;
    var_0.addtobaseangle = 0;
    var_1 = ( 0, var_1[1], 0 );

    if ( isdefined( var_1 ) )
    {
        if ( isagent( var_0 ) )
            var_0 maps\mp\_vl_camera::hackagentangles( var_1 );
        else
            var_0.angles = var_1;
    }
}

avatar_scheduled_for_removal( var_0 )
{
    return level.avatarinfo[var_0].timetodelete > 0;
}

schedule_remove_avatar( var_0, var_1 )
{
    maps\mp\_vl_camera::remove_avatar( var_0 );
}

all_avatars_scheduled_for_delete()
{
    if ( level.vlavatars.size == 0 )
        return 0;

    foreach ( var_2, var_1 in level.avatarinfo )
    {
        if ( !isdefined( level.vlavatars[var_2] ) )
            continue;

        if ( var_1.timetodelete == 0 )
            return 0;
    }

    return 1;
}

reuse_avatar( var_0 )
{
    var_1 = undefined;

    foreach ( var_4, var_3 in level.xuid2ownerid )
    {
        var_1 = level.vlavatars[var_3];
        level.vlavatars[var_3] = undefined;
        _func_2D4( var_1, var_4, 1 );
        level.xuid2ownerid[var_4] = undefined;
    }

    level.xuid2ownerid[var_0] = 0;
    level.avatarinfo[0].timetodelete = 0;
    level.avatarinfo[0].xuid = var_0;

    if ( isdefined( var_1 ) )
    {
        _func_2D4( var_1, var_0 );
        level.vlavatars[0] = var_1;
    }
}

add_avatar( var_0 )
{
    var_1 = -1;
    var_2 = -1;

    while ( var_2 == var_1 )
    {
        var_1++;

        foreach ( var_2 in level.xuid2ownerid )
        {
            if ( var_2 == var_1 )
                break;
        }
    }

    vlprint( "Adding new xuid " + var_0 + " with ownerId=" + var_1 + "\\n" );
    level.xuid2ownerid[var_0] = var_1;
    level.avatarinfo[var_1].xuid = var_0;
    level.avatarinfo[var_1].timetodelete = 0;
    return var_1;
}

avatar_after_spawn( var_0 )
{
    if ( isdefined( level.needtopresent ) )
        thread maps\mp\_vl_camera::setvirtuallobbypresentable();
}

update_avatars()
{
    var_0 = 0;

    foreach ( var_3, var_2 in level.avatarinfo )
    {
        if ( var_2.timetodelete > 0 && gettime() > var_2.timetodelete )
        {
            vlprint( "update_avatars removing ownerId" + var_3 + "\\n" );
            maps\mp\_vl_camera::remove_avatar( var_3 );
            var_0 = 1;
        }
    }

    if ( var_0 )
        wait 0.1;
}

hide_non_owner_avatars()
{
    foreach ( var_2, var_1 in level.vlavatars )
    {
        if ( var_2 == 0 )
            continue;

        maps\mp\_vl_camera::hide_avatar( var_1 );
    }

    if ( level.camparams.mode != "prelobby" )
        level.camparams.camera.cut = 1;

    level.vl_focus = 0;
    level.old_vl_focus = level.vl_focus;
}

show_non_owner_avatars()
{
    foreach ( var_2, var_1 in level.vlavatars )
    {
        if ( var_2 == 0 )
            continue;

        maps\mp\_vl_camera::show_avatar( var_1 );
    }
}

rightstickrotateavatar( var_0, var_1 )
{
    var_2 = player_update_right_stick_y( var_0 );
    var_3 = angleclamp( var_2 - var_0.storedrightsticky );
    var_4 = getdvarfloat( "ui_mouse_char_rot", 0 );

    if ( var_4 != 0 )
    {
        var_0.mouserot = angleclamp( var_0.mouserot + var_4 );
        setdynamicdvar( "ui_mouse_char_rot", 0 );
    }

    var_5 = maps\mp\_vl_camera::getmodifiedrotationangle( var_0, var_3, var_1 );
    var_5 *= -1;
    var_6 = angleclamp( var_0.storedangley + var_5 + var_0.mouserot );
    var_7 = ( 0, var_6, 0 );

    if ( isagent( var_0 ) )
        var_0 setangles( var_7 );
    else
        var_0.angles = var_7;
}

playerhastouchedstick( var_0 )
{
    var_1 = player_get_right_stick_y( var_0 );
    var_2 = angleclamp( var_1 - var_0.storedrightsticky );

    if ( self.hastouchedstick == 0 )
    {
        if ( abs( var_2 ) >= 1 )
        {
            var_0.storedangley = var_0.angles[1];
            return 1;
        }
        else
            return 0;
    }
    else
        return 1;
}

disable_player_controls()
{
    self notify( "kill_enable_weapons" );
    self _meth_8131( 0 );
}

enable_player_controls()
{
    self endon( "enter_lobby" );
    self endon( "kill_enable_weapons" );
    var_0 = getdvarint( "virtualLobbyInFiringRange", 0 );

    if ( var_0 == 1 && level.in_firingrange == 1 )
        self _meth_8131( 1 );
}

enter_vlobby( var_0 )
{
    maps\mp\_vl_firingrange::deactivate_targets();
    var_1 = var_0.camera;
    var_0 setorigin( var_1.origin );
    var_0 _meth_807C( var_1, "tag_player" );
    var_0 _meth_81E2( var_1, "tag_player" );
    var_0 _meth_82FC( "cg_fovscale", "0.6153" );
    var_0 _meth_82D4( "mp_virtual_lobby_cac", 0 );

    if ( isdefined( level.vlavatars ) && isdefined( level.old_vl_focus ) && isdefined( level.vlavatars[level.old_vl_focus] ) )
        var_0 prep_for_controls( level.vlavatars[level.old_vl_focus], level.vlavatars[level.old_vl_focus].angles );

    level.in_firingrange = 0;
    var_0 _meth_8131( 0 );
    maps\mp\_utility::updatesessionstate( "spectator" );
}

monitor_move_btn_fr_vl( var_0 )
{
    for (;;)
    {
        if ( isdefined( level.in_firingrange ) )
        {
            var_1 = getdvarint( "virtualLobbyInFiringRange", 0 );

            if ( var_1 == 1 && !level.in_firingrange )
            {
                var_2 = maps\mp\_utility::getclassindex( "lobby" + ( var_0.currentselectedclass + 1 ) );
                var_3 = maps\mp\_utility::cac_getcustomclassloc();
                var_4 = var_0.loadouts[var_3][var_2];
                var_5 = var_4["primary"];
                var_6 = var_4["secondary"];

                if ( isdefined( level.vlavatars ) && isdefined( level.old_vl_focus ) && isdefined( level.vlavatars[level.old_vl_focus] ) )
                    var_0 prep_for_controls( level.vlavatars[level.old_vl_focus], level.vlavatars[level.old_vl_focus].angles );

                var_7 = [];

                if ( isdefined( var_5 ) && var_5 != "specialty_null" )
                    var_7[var_7.size] = maps\mp\gametypes\_class::buildweaponname( var_5, var_4["primaryAttachment1"], var_4["primaryAttachment2"], var_4["primaryAttachment3"], 0, 0 );

                if ( isdefined( var_6 ) && var_6 != "specialty_null" )
                    var_7[var_7.size] = maps\mp\gametypes\_class::buildweaponname( var_6, var_4["secondaryAttachment1"], var_4["secondaryAttachment2"], var_4["secondaryAttachment3"], 0, 0 );

                while ( var_7.size > 0 )
                {
                    var_8 = var_0 _meth_8511( var_7 );

                    if ( var_8 == 1 )
                        break;

                    wait 0.05;
                }

                var_0 _meth_8481();
                maps\mp\_vl_firingrange::enter_firingrange( var_0 );
                var_0 _meth_84D8( "mp_no_foley", 1 );
                setdvar( "r_dof_physical_bokehEnable", 0 );
                setdvar( "r_dof_physical_enable", 0 );
                setdvar( "r_uiblurdstmode", 0 );
                setdvar( "r_blurdstgaussianblurradius", 1 );
            }
            else if ( var_1 == 0 && level.in_firingrange )
            {
                var_0 _meth_8482();
                var_0 firingrangecleanup();
                var_0 disable_player_controls();

                if ( isdefined( var_0.primaryweapon ) )
                    var_0 _meth_8315( var_0.primaryweapon );

                var_0 notify( "enter_lobby" );
                enter_vlobby( var_0 );
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

firingrangecleanup()
{
    var_0 = self;
    var_0 maps\mp\_vl_firingrange::grenadecleanup();
    var_0 thread maps\mp\_vl_firingrange::riotshieldcleanup();
    var_1 = var_0 _meth_82CE();

    foreach ( var_3 in var_1 )
        var_0 maps\mp\gametypes\_class::takeoffhand( var_3 );
}
