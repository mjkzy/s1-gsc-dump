// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    upgrade_init_perks_tables();
    upgrade_init_perks_players();
    level thread upgrade_change_monitor();
}

upgrade_init_perks_tables()
{
    level.upgrade_perk_active = [];
    level.upgrade_ref = [];
    level.upgrade_ref_index = [];
    level.upgrade_perk_code = [];
    level.upgrade_perk_dvar = [];
    level.upgrade_perk_dvar_origval = [];
    level.upgrade_perk_dvar_newval = [];
    level.upgrade_perk_code_2 = [];
    level.upgrade_perk_dvar_2 = [];
    level.upgrade_perk_dvar_origval_2 = [];
    level.upgrade_perk_dvar_newval_2 = [];
    var_0 = 0;

    for (;;)
    {
        var_1 = tablelookupbyrow( "sp/upgrade_table.csv", var_0, 0 );

        if ( var_1 == "" )
            break;

        var_2 = int( var_1 );
        var_3 = tablelookupbyrow( "sp/upgrade_table.csv", var_0, 1 );
        var_4 = tablelookupbyrow( "sp/upgrade_table.csv", var_0, 5 );

        if ( var_3 == "" || var_4 == "" )
        {

        }
        else
        {
            level.upgrade_ref_index[var_3] = var_2;
            level.upgrade_ref[var_2] = var_3;
            level.upgrade_perk_code[var_2] = var_4;
            var_5 = tablelookupbyrow( "sp/upgrade_table.csv", var_0, 6 );
            var_6 = float( tablelookupbyrow( "sp/upgrade_table.csv", var_0, 7 ) );
            var_7 = float( tablelookupbyrow( "sp/upgrade_table.csv", var_0, 8 ) );

            if ( isdefined( var_5 ) && var_5 != "" && isdefined( var_6 ) && isdefined( var_7 ) )
            {
                level.upgrade_perk_dvar[var_2] = var_5;
                level.upgrade_perk_dvar_origval[var_2] = var_6;
                level.upgrade_perk_dvar_newval[var_2] = var_7;
            }

            var_8 = tablelookupbyrow( "sp/upgrade_table.csv", var_0, 9 );

            if ( var_8 != "" )
            {
                level.upgrade_perk_code_2[var_2] = var_8;
                var_9 = tablelookupbyrow( "sp/upgrade_table.csv", var_0, 10 );
                var_10 = float( tablelookupbyrow( "sp/upgrade_table.csv", var_0, 11 ) );
                var_11 = float( tablelookupbyrow( "sp/upgrade_table.csv", var_0, 12 ) );

                if ( isdefined( var_9 ) && var_9 != "" && isdefined( var_10 ) && isdefined( var_11 ) )
                {
                    level.upgrade_perk_dvar_2[var_2] = var_9;
                    level.upgrade_perk_dvar_origval_2[var_2] = var_10;
                    level.upgrade_perk_dvar_newval_2[var_2] = var_11;
                }
            }

            if ( var_4 != "" )
                level.upgrade_perk_active[var_2] = ::upgrade_perk_active_code;
        }

        var_0++;
    }
}

upgrade_change_monitor()
{
    self notify( "upgrade_change_monitor" );
    self endon( "upgrade_change_monitor" );
    setdvarifuninitialized( "upgrades_changed", 0 );

    for (;;)
    {
        if ( getdvarint( "upgrades_changed" ) )
        {
            setdvar( "upgrades_changed", 0 );
            upgrade_init_perks_players();
        }

        wait 0.25;
    }
}

upgrade_init_perks_players()
{
    foreach ( var_1 in level.players )
        var_1 thread upgrade_init_perks_player();
}

upgrade_init_perks_player()
{
    foreach ( var_1 in level.upgrade_ref_index )
        upgrade_take_perk( level.upgrade_ref[var_1] );

    foreach ( var_1 in level.upgrade_ref_index )
    {
        if ( maps\_upgrade_system::upgrade_is_purchased( var_1 ) )
            upgrade_give_perk( level.upgrade_ref[var_1] );
    }
}

upgrade_perk_script_code( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "specialty_detectexplosive":
            level.player.exclusive["show_grenades"] = var_1;
            break;
        case "specialty_detectintel":
            level.player.exclusive["intel_mode"] = var_1;
            break;
        case "specialty_extended_battery":
            if ( var_1 )
                maps\_player_exo::batteryinit( 1 );
            else
                maps\_player_exo::batteryinit();

            break;
        case "specialty_extended_battery2":
            if ( var_1 )
                maps\_player_exo::batteryinit( 2 );
            else
                maps\_player_exo::batteryinit();

            break;
        case "specialty_extendeddetectgren":
            if ( var_1 )
                level.player.detection_grenade_duration_bonus = 5;
            else
                level.player.detection_grenade_duration_bonus = 0;

            break;
    }
}

upgrade_perk_active_code( var_0, var_1 )
{
    if ( var_1 )
    {
        upgrade_perk_script_code( level.upgrade_perk_code[var_0], 1 );
        self setperk( level.upgrade_perk_code[var_0], 1, 0 );

        if ( isdefined( level.upgrade_perk_dvar[var_0] ) )
            setsaveddvar( level.upgrade_perk_dvar[var_0], level.upgrade_perk_dvar_newval[var_0] );

        if ( isdefined( level.upgrade_perk_code_2[var_0] ) )
        {
            self setperk( level.upgrade_perk_code_2[var_0], 1, 0 );

            if ( isdefined( level.upgrade_perk_dvar_2[var_0] ) )
                setsaveddvar( level.upgrade_perk_dvar_2[var_0], level.upgrade_perk_dvar_newval_2[var_0] );
        }
    }
    else
    {
        upgrade_perk_script_code( level.upgrade_perk_code[var_0], 0 );
        self unsetperk( level.upgrade_perk_code[var_0], 1 );

        if ( isdefined( level.upgrade_perk_dvar[var_0] ) )
            setsaveddvar( level.upgrade_perk_dvar[var_0], level.upgrade_perk_dvar_origval[var_0] );

        if ( isdefined( level.upgrade_perk_code_2[var_0] ) )
        {
            self unsetperk( level.upgrade_perk_code_2[var_0], 1 );

            if ( isdefined( level.upgrade_perk_dvar_2[var_0] ) )
                setsaveddvar( level.upgrade_perk_dvar_2[var_0], level.upgrade_perk_dvar_origval_2[var_0] );
        }
    }
}

upgrade_give_perk( var_0 )
{
    var_1 = level.upgrade_ref_index[var_0];

    if ( isdefined( level.upgrade_perk_active[var_1] ) )
        self [[ level.upgrade_perk_active[var_1] ]]( var_1, 1 );

    self notify( "give_perk", var_0 );
}

upgrade_take_perk( var_0 )
{
    var_1 = level.upgrade_ref_index[var_0];

    if ( isdefined( level.upgrade_perk_active[var_1] ) )
        self [[ level.upgrade_perk_active[var_1] ]]( var_1, 0 );

    self notify( "take_perk", var_0 );
}
