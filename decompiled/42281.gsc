// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    precacheitem( "s1_exo_shield_sp" );
    precacheshader( "dpad_icon_shield" );
    precacheshader( "dpad_icon_shield_off" );
    level.player maps\_utility::set_unstorable_weapon( "s1_exo_shield_sp" );
    precachestring( &"GAME_CROUCH_BLOCKED_WEAPON" );
    maps\_utility::add_hint_string( "EXO_SHIELD_CROUCH_BLOCKED_WEAPON", &"GAME_CROUCH_BLOCKED_WEAPON" );

    if ( !isdefined( level.player.exoparams ) )
        level.player.exoparams = [];

    level.player.exoparams["shield"] = spawnstruct();
    var_0 = level.player.exoparams["shield"];
    var_0.weapon_name = "s1_exo_shield_sp";
    var_0.activation_cost = 1;
    var_0.state = "disabled";
    var_0.return_after_offhand = 1;
    var_0.duration = 15;
    level.player thread monitor_unauthorized_shield();
    level.player thread monitor_failed_switchback();

    if ( !level.player maps\_utility::ent_flag_exist( "exo_shield_on" ) )
        level.player maps\_utility::ent_flag_init( "exo_shield_on" );
}

get_exo_shield_params()
{
    return level.player.exoparams["shield"];
}

state_change( var_0 )
{
    var_1 = get_exo_shield_params();
    var_2 = is_shield_up_state( var_1.state );
    var_3 = is_shield_up_state( var_0 );
    var_1.state = var_0;

    if ( !var_2 && var_3 )
        on_shield_up();
    else if ( var_2 && !var_3 )
        on_shield_down();
}

is_shield_up_state( var_0 )
{
    return isdefined( var_0 ) && var_0 == "raised";
}

on_shield_up()
{
    var_0 = get_exo_shield_params();
    level.player maps\_utility::playerallowalternatemelee( 0, "exo_shield" );
    level.player.forcealtmeleedeaths = 1;
}

on_shield_down()
{
    var_0 = get_exo_shield_params();
    level.player maps\_utility::playerallowalternatemelee( 1, "exo_shield" );
    level.player.forcealtmeleedeaths = undefined;
}

enable_shield_ability()
{
    level.player endon( "exo_shield_disabled" );
    level.player notify( "exo_shield_enabled" );
    state_change( "idle" );
    var_0 = get_exo_shield_params();
    update_exo_shield_icon();
    level.player _meth_82DD( "exo_shield_toggle", "+actionslot 2" );

    for (;;)
    {
        level.player waittill( "exo_shield_toggle" );

        switch ( var_0.state )
        {
            case "equipping":
            case "raised":
                lower_shield();
                break;
            case "idle":
                thread try_raise_shield();
                break;
        }
    }
}

disable_shield_ability()
{
    var_0 = get_exo_shield_params();
    level.player _meth_821B( "actionslot2", "dpad_icon_shield_off" );

    switch ( var_0.state )
    {
        case "equipping":
        case "raised":
            lower_shield();
            break;
    }

    level.player notify( "exo_shield_disabled" );

    if ( level.player _meth_8314( var_0.weapon_name ) )
    {
        level.player endon( "exo_shield_enabled" );
        level.player waittill( "exo_shield_removed" );
    }

    state_change( "disabled" );
}

try_raise_shield()
{
    var_0 = get_exo_shield_params();
    var_1 = 0;

    if ( level.player _meth_817C() == "prone" )
        level.player _meth_817D( "crouch" );

    if ( level.player _meth_817C() == "prone" )
    {
        maps\_utility::display_hint( "EXO_SHIELD_CROUCH_BLOCKED_WEAPON", undefined, undefined, undefined, 200 );
        var_1 = 1;
    }
    else if ( level.player _meth_812C() || level.player isonladder() )
        var_1 = 1;
    else if ( maps\_player_exo::batteryspend( var_0.activation_cost ) )
        raise_shield();

    if ( var_1 )
        maps\_player_exo::exofailfx();
}

raise_shield()
{
    level.player endon( "exo_shield_disabled" );
    level.player endon( "exo_shield_lower" );
    level.player endon( "exo_shield_removed" );
    level.player maps\_utility::ent_flag_set( "exo_shield_on" );
    var_0 = get_exo_shield_params();
    state_change( "equipping" );
    var_0.previous_weapon = level.player _meth_8312();
    level.player _meth_830E( var_0.weapon_name );
    soundscripts\_snd::snd_message( "exo_raise_shield" );
    level.player thread monitor_equip_interrupt();
    level.player _meth_8315( var_0.weapon_name );
    var_1 = undefined;

    for ( var_2 = level.player _meth_8311( 1 ); !isdefined( var_1 ) || var_1 || var_2 == "none"; var_2 = level.player _meth_8311( 1 ) )
    {
        level.player waittill( "weapon_change" );
        var_1 = level.player isonladder();
    }

    var_3 = level.player _meth_8311( 0 ) == var_0.weapon_name;

    if ( !var_3 )
    {
        var_2 = level.player _meth_8311();

        if ( var_2 == var_0.weapon_name || var_2 == "none" )
            switch_to_previous_weapon();

        _remove_shield();
        return;
    }

    level.player notify( "exo_shield_equipped" );
    state_change( "raised" );
    thread monitor_shield_switchout();
    thread monitor_shield_timeout();
}

monitor_equip_interrupt()
{
    level.player endon( "exo_shield_equipped" );
    level.player endon( "exo_shield_removed" );
    level.player childthread monitor_shield_stolen();
    level.player common_scripts\utility::waittill_any( "exo_shield_disabled", "exo_shield_lower" );
    _remove_shield();
}

monitor_shield_stolen()
{
    level.player endon( "exo_shield_disabled" );
    level.player endon( "exo_shield_lower" );
    var_0 = get_exo_shield_params();

    for (;;)
    {
        level.player waittill( "weapon_taken", var_1 );

        if ( issubstr( var_1, var_0.weapon_name ) )
        {
            state_change( "idle" );
            level.player notify( "exo_shield_removed" );
        }
    }
}

lower_shield( var_0 )
{
    var_1 = get_exo_shield_params();
    level.player notify( "exo_shield_lower" );
    soundscripts\_snd::snd_message( "exo_lower_shield" );
    level.player maps\_utility::ent_flag_clear( "exo_shield_on" );
    var_2 = level.player _meth_8311();

    if ( var_2 == "none" || var_2 == var_1.weapon_name || var_1.state == "equipping" )
        switch_to_previous_weapon( var_0 );
}

_remove_shield()
{
    var_0 = get_exo_shield_params();
    level.player _meth_830F( var_0.weapon_name );
    state_change( "idle" );
    level.player notify( "exo_shield_removed" );
}

switch_to_previous_weapon( var_0 )
{
    var_1 = get_exo_shield_params();
    var_2 = undefined;

    if ( isdefined( var_1.previous_weapon ) && level.player _meth_8314( var_1.previous_weapon ) )
        var_2 = var_1.previous_weapon;
    else
        var_2 = level.player maps\_utility::get_first_storable_weapon();

    if ( !( isdefined( var_2 ) && var_2 != "none" ) )
    {

    }

    if ( isdefined( var_2 ) )
    {
        if ( isdefined( var_0 ) && var_0 )
            level.player _meth_8316( var_2 );
        else
            level.player _meth_8315( var_2 );
    }
}

monitor_shield_timeout()
{
    var_0 = get_exo_shield_params();
    level.player endon( "exo_shield_removed" );
    var_0.start_time = gettime();
    wait(var_0.duration);

    if ( var_0.state == "raised" )
    {
        if ( level.player _meth_84E0() )
            offhand_switchout();
        else
        {
            var_2 = level.player _meth_8311( 0 ) == var_0.weapon_name;
            lower_shield( !var_2 );
        }
    }
}

monitor_shield_switchout()
{
    var_0 = get_exo_shield_params();
    level.player endon( "exo_shield_removed" );
    var_1 = 0;

    while ( !var_1 )
    {
        level.player common_scripts\utility::waittill_any( "weapon_switch_started", "weapon_change", "exo_shield_toggle" );
        var_2 = level.player _meth_8311( 0 ) == var_0.weapon_name;
        var_3 = !var_2 && level.player _meth_8311( 1 ) == var_0.weapon_name;
        var_4 = level.player _meth_84E0() || level.player _meth_812C();
        var_5 = level.player _meth_8314( var_0.weapon_name );
        var_6 = !var_3 && var_5 && level.player isonladder();

        switch ( var_0.state )
        {
            case "raised":
                if ( !var_2 && !var_6 )
                {
                    if ( var_5 )
                    {
                        if ( var_3 )
                            lower_shield( 1 );

                        level.player _meth_830F( var_0.weapon_name );
                    }

                    state_change( "idle" );
                    var_1 = 1;
                }
                else if ( var_4 && !var_0.return_after_offhand )
                {
                    offhand_switchout();
                    var_1 = 1;
                }

                break;
            default:
                break;
        }
    }

    level.player notify( "exo_shield_removed" );
}

monitor_failed_switchback()
{
    var_0 = get_exo_shield_params();
    level.player endon( "death" );

    for (;;)
    {
        level.player waittill( "weapon_switch_invalid", var_1, var_2 );

        if ( isdefined( var_1 ) && var_1 == var_0.weapon_name )
            switch_to_previous_weapon( var_2 );
    }
}

monitor_unauthorized_shield()
{
    var_0 = get_exo_shield_params();
    level.player endon( "death" );

    for (;;)
    {
        level.player waittill( "weapon_switch_started", var_1 );

        if ( ( var_0.state == "disabled" || var_0.state == "idle" ) && level.player _meth_8314( var_0.weapon_name ) )
        {
            level.player _meth_830F( var_0.weapon_name );

            if ( isdefined( var_1 ) && var_1 == var_0.weapon_name )
                switch_to_previous_weapon( 0 );
        }
    }
}

offhand_switchout()
{
    var_0 = get_exo_shield_params();

    for ( var_1 = level.player _meth_84E0(); !var_1; var_1 = level.player _meth_84E0() )
        waitframe();

    lower_shield( 1 );
    _remove_shield();
}

update_exo_shield_icon()
{
    if ( !maps\_player_exo::player_exo_is_active() )
        level.player _meth_821B( "actionslot2", "none" );
    else if ( maps\_player_exo::get_exo_battery_percent() > 0 )
        level.player _meth_821B( "actionslot2", "dpad_icon_shield" );
    else
        level.player _meth_821B( "actionslot2", "dpad_icon_shield_off" );
}
