// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

s3_escape_gun_action( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( "s3_escape_get_weapon_marker", "targetname" );
    var_1 = var_2.origin;
    var_3 = maps\_shg_utility::hint_button_position( "use", var_1, 72 );
    var_0 waittill( "trigger" );
    level notify( "captured_action_complete" );
    var_3 maps\_shg_utility::hint_button_clear();
}

s3_escape_hack_action( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( "s3_escape_console_use_marker", "targetname" );
    var_1 = var_2.origin;
    level.script_button = maps\_shg_utility::hint_button_position( "use", var_1, 10 );
    s3_escape_hack_action_switcher( var_0, var_1 );
    level notify( "captured_action_complete" );

    if ( !_func_294( level.script_button ) )
        level.script_button maps\_shg_utility::hint_button_clear();
}

s3_escape_hack_action_switcher( var_0, var_1 )
{
    var_0 endon( "trigger" );

    for (;;)
    {
        if ( !common_scripts\utility::flag( "flag_s3_escape_at_console" ) )
        {
            var_0 makeunusable();
            level.script_button maps\_shg_utility::hint_button_clear();
            level.script_button = maps\_shg_utility::hint_button_position( "use", var_1, 10 );
        }

        common_scripts\utility::flag_wait( "flag_s3_escape_at_console" );
        var_0 makeusable();
        level.script_button maps\_shg_utility::hint_button_clear();
        level.script_button = maps\_shg_utility::hint_button_position( "use", var_1, 50 );
        common_scripts\utility::flag_waitopen( "flag_s3_escape_at_console" );
    }
}

s3_escape_console_gun_action( var_0, var_1, var_2 )
{
    var_0 endon( "s3escape_console_ender" );
    level.player _meth_8310();
    level.player _meth_82CC();
    level.player _meth_831E();
    level.player waittill( "pickup" );
    _func_0D3( "ammoCounterHide", "1" );
    level.player _meth_8482();
    common_scripts\utility::flag_set( "s3_player_pickedup_console_gun" );
    level.player notify( "captured_action_complete" );
    var_0 maps\_anim::anim_single_solo( var_1, "s3escape_console_end" );
    _func_0D3( "g_friendlyNameDist", level.friendlynamedist );
    level.player _meth_804F();
    var_1 delete();
    var_2 delete();
    level.player _meth_8131( 1 );
    level.player _meth_8481();
    level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_titan45pickup_sp_xmags" );
    level.player _meth_82F6( "iw5_titan45_sp", 0 );
    level.player _meth_8316( "iw5_titan45_sp" );
    level.player _meth_8130( 1 );
    level.player _meth_8304( 1 );
    level.player _meth_8119( 1 );
    level.player _meth_8301( 1 );
    level.player _meth_811A( 1 );
}

autopsy_door_action( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( "struct_vign_autopsy_doctor_door", "targetname" );
    var_3 = var_2.origin + ( 0, -14, 51 );
    var_4 = maps\_shg_utility::hint_button_position( "use", var_3, 80 );
    var_0 waittill( "trigger" );
    level notify( "captured_action_complete" );
    var_4 maps\_shg_utility::hint_button_clear();
}

incinerator_push_action( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( "struct_anim_incinerator", "targetname" );
    var_1 = var_2.origin + ( -40, 20, -20 );
    var_3 = maps\_shg_utility::hint_button_position( "use", var_1, 60 );
    var_0 waittill( "trigger" );
    level notify( "captured_action_complete" );
    var_3 maps\_shg_utility::hint_button_clear();
}

mech_entry_action()
{
    var_0 = common_scripts\utility::getstruct( "struct_prompt_mechenter", "targetname" );
    var_1 = var_0.origin;
    var_2 = maps\_shg_utility::hint_button_position( "use", var_1, 72 );
    level waittill( "captured_action_complete" );
    level.player _meth_84F1();
    var_2 maps\_shg_utility::hint_button_clear();
}

prompt_show_hide( var_0, var_1 )
{
    level endon( var_1 );

    if ( !common_scripts\utility::flag_exist( var_0 ) )
        common_scripts\utility::flag_init( var_0 );

    var_2 = 0;

    for (;;)
    {
        if ( !var_2 && common_scripts\utility::flag( var_0 ) )
        {
            common_scripts\utility::trigger_on();
            var_2 = 1;
        }
        else if ( !common_scripts\utility::flag( var_0 ) && var_2 )
        {
            common_scripts\utility::trigger_off();
            var_2 = 0;
        }

        wait 0.05;
    }
}

captured_hint_display( var_0, var_1 )
{
    captured_hint_range_check( var_0, var_1 ) common_scripts\utility::flag_set( "flag_display_hint" );
}

captured_hint_range_check( var_0, var_1 )
{
    level endon( "captured_hint_ender" );

    for (;;)
    {
        level.player maps\_utility::waittill_in_range( self.origin, var_1 );
        common_scripts\utility::flag_clear( "flag_display_hint" );
        maps\_utility::hintdisplayhandler( var_0 );
        level.player maps\_utility::waittill_entity_out_of_range( self, var_1 );
        common_scripts\utility::flag_set( "flag_display_hint" );
    }
}

captured_hint_ender_function()
{
    if ( common_scripts\utility::flag( "flag_display_hit" ) )
        return 1;
}

captured_use_console()
{

}

captured_push_cart()
{

}

captured_open_door()
{

}

captured_take_exo()
{

}

captured_enter_exo()
{

}

captured_break_lock()
{

}
