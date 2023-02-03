// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

car_alarm_main( var_0, var_1 )
{
    var_2 = getentarray( var_0, "targetname" );
    var_2 = maps\_utility::remove_without_classname( var_2, "trigger_multiple" );

    foreach ( var_4 in var_2 )
    {
        var_5 = getent( var_4.script_linkto, "script_linkname" );
        var_5 setcandamage( 1 );
        var_5 setcanradiusdamage( 1 );
        var_5.health = 99999999;
        var_4 thread car_alarm_setup( var_5, var_1 );
    }
}

car_alarm_setup( var_0, var_1 )
{
    level endon( "car_alarm_triggered" );
    thread player_touched_car_watcher( var_0, var_1 );
    var_0 thread player_damaged_car_watcher( var_1 );
    var_2 = var_0 common_scripts\utility::waittill_any_return( "player_touched", "player_damaged", "remotely_hacked" );

    if ( isdefined( var_2 ) )
    {
        if ( var_2 == "player_touched" )
            var_0 thread start_car_alarm( "player_touched" );
        else if ( var_2 == "player_damaged" )
            var_0 thread start_car_alarm( "player_damaged" );
        else if ( var_2 == "remotely_hacked" )
            var_0 thread start_car_alarm( "remotely_hacked" );
    }

    level notify( "stop_all_player_touched_car_watchers" );
    level notify( "stop_all_player_damaged_car_watchers" );
    level notify( "car_alarm_triggered" );
}

player_touched_car_watcher( var_0, var_1 )
{
    self endon( var_1 );
    level endon( "stop_all_player_touched_car_watchers" );
    var_0 endon( "player_touched" );
    var_0 endon( "player_damaged" );
    self waittill( "trigger" );
    var_0 notify( "player_touched" );
}

player_damaged_car_watcher( var_0 )
{
    self endon( var_0 );
    level endon( "stop_all_player_damaged_car_watchers" );
    self endon( "player_touched" );
    self endon( "player_damaged" );

    for (;;)
    {
        self waittill( "damage", var_1, var_2 );

        if ( isdefined( var_2 ) && var_2 == level.player )
        {
            self notify( "player_damaged" );
            continue;
        }

        wait 0.05;
    }
}

start_car_alarm( var_0 )
{
    self endon( "death" );
    var_1[0] = spawnstruct();
    var_1[0].vo = "ie_iln_getout6";
    var_1[0].vo_priority = 4;
    var_1[1] = spawnstruct();
    var_1[1].vo = "ie_lin_stayout4";
    var_1[1].vo_priority = 4;
    thread maps\irons_estate_code::notifyaftertime( "stop_car_alarm", "stop_car_alarm", 10.0 );
    thread car_alarm_sound();

    if ( !common_scripts\utility::flag( "_stealth_spotted" ) )
    {
        if ( isdefined( var_0 ) && !common_scripts\utility::flag( "meet_cormack_start" ) )
        {
            if ( var_0 == "player_touched" )
                thread maps\irons_estate_code::ally_vo_controller( var_1[0] );
            else if ( var_0 == "player_damaged" )
                thread maps\irons_estate_code::ally_vo_controller( var_1[1] );
        }

        wait 0.25;
        var_2 = getaiarray( "axis" );

        foreach ( var_4 in var_2 )
        {
            if ( isdefined( var_4.script_parameters ) && var_4.script_parameters == "ignore_car_alarm" || isdefined( var_4.script_noteworthy ) && var_4.script_noteworthy == "ignore_car_alarm" )
                var_2 = common_scripts\utility::array_remove( var_2, var_4 );
        }

        var_6 = common_scripts\utility::get_array_of_closest( self.origin, var_2, undefined, undefined, 1024, undefined );

        if ( isdefined( var_6 ) )
        {
            foreach ( var_8 in var_6 )
            {
                wait 0.1;

                if ( !common_scripts\utility::flag( "_stealth_spotted" ) && isalive( var_8 ) && isdefined( var_8._stealth ) )
                {
                    var_8 notify( "reaction_generic", self.origin );
                    var_9 = maps\_stealth_shared_utilities::group_get_ai_in_group( var_8.script_stealthgroup );

                    if ( isdefined( var_9 ) )
                    {
                        foreach ( var_11, var_4 in var_9 )
                        {
                            if ( var_4 == self )
                                continue;

                            if ( isdefined( var_4.enemy ) || isdefined( var_4.favoriteenemy ) )
                                continue;

                            var_4 thread maps\irons_estate_code::notify_delay_param( "reaction_generic", randomfloatrange( 0.1, 0.5 ), self.origin );
                        }

                        break;
                    }
                }
            }
        }
    }
}

car_alarm_sound()
{
    self endon( "death" );
    self endon( "stop_car_alarm" );
    thread turn_off_car_alarm();

    for (;;)
    {
        self playsound( "car_alarm_horn_01" );
        wait 1.08;
    }
}

turn_off_car_alarm()
{
    self endon( "death" );
    self waittill( "stop_car_alarm" );
    self stopsounds();
    wait 0.05;
    self playsound( "car_alarm_horn_chirp" );
}
