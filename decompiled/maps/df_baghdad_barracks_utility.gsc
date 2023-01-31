// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

ilana_keeps_up()
{
    self.oldwalkdist = self.walkdist;
    self.old_moveplaybackrate = self.moveplaybackrate;
    self.run_speed_state = "run";
    var_0 = int( squared( 512 ) );
    common_scripts\utility::flag_wait( "ilana_alterspeed" );
    maps\_utility::disable_careful();
    self.moveplaybackrate = 1.1;
    self.walkdist = 32;
    maps\_utility::set_ignoresuppression( 1 );
    var_1 = maps\_utility::get_living_ai( "mech4_streets", "script_noteworthy" );

    for (;;)
    {
        waitframe();

        if ( !isalive( var_1 ) || _func_294( var_1 ) )
        {
            self.moveplaybackrate = self.old_moveplaybackrate;
            self.walkdist = self.oldwalkdist;
            maps\_utility::enable_careful();
            break;
        }

        if ( distancesquared( self.origin, var_1.origin ) < var_0 )
        {
            self.moveplaybackrate = self.old_moveplaybackrate;
            self.walkdist = self.oldwalkdist;
            maps\_utility::enable_careful();
            maps\_utility::set_ignoresuppression( 0 );
            break;
        }
    }
}

cleanup_tower_enemies()
{
    var_0 = getent( "vol_cleanup_snipertower", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    if ( !var_1.size )
        return;

    waitframe();

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) && isdefined( var_3.script_noteworthy ) )
        {
            switch ( var_3.script_noteworthy )
            {
                case "barracks_approach_left_guys":
                    break;
                case "barracks_approach_left_guys_balcony":
                    break;
                case "mech1_streets":
                    break;
                case "mech3_streets":
                    break;
                case "barracks_approach_left_guys_rear":
                    break;
                case "barracks_approach_monster_spawns":
                    break;
                default:
                    var_3 thread bloody_death( 2 );
                    break;
            }
        }
    }

    var_1 = maps\_utility::get_living_ai_array( "cleanup_guys_snipers_finished", "script_noteworthy" );

    if ( var_1.size )
    {
        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3 ) )
                var_3 thread bloody_death( 2 );
        }
    }
}

array_spawn_targetname_stagger( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 = getentarray( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 0.25;

    if ( !isdefined( var_5 ) )
        var_5 = 1;

    var_0 = common_scripts\utility::array_randomize( var_0 );
    var_6 = [];

    foreach ( var_10, var_8 in var_0 )
    {
        var_9 = var_8 maps\_utility::spawn_ai( var_3 );
        var_6[var_6.size] = var_9;

        if ( var_2 )
        {
            if ( var_10 != var_0.size - 1 )
                wait(randomfloatrange( var_4, var_5 ));
        }
    }

    if ( var_1 )
    {

    }

    return var_6;
}

shoot_player_if_facing( var_0 )
{
    self endon( "death" );
    self endon( "removed" );

    if ( !isdefined( var_0 ) )
        var_0 = 0.25;

    self.old_base = self.baseaccuracy;
    self.is_lowered = 0;
    waitframe();

    for (;;)
    {
        if ( isdefined( self.enemy ) && isplayer( self.enemy ) )
        {
            if ( !maps\_utility::player_can_see_ai( self ) )
            {
                if ( isdefined( self ) )
                {
                    self.baseaccuracy = var_0;
                    self.is_lowered = 1;
                }
            }
            else
            {
                self.baseaccuracy = self.old_base;
                wait 0.1;
            }
        }
        else
            waitframe();

        waitframe();
    }
}

cleanup_ai_with_script_noteworthy( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 512;

    var_2 = [];

    foreach ( var_4 in getentarray( var_0, "script_noteworthy" ) )
    {
        if ( isspawner( var_4 ) )
        {
            var_4 delete();
            continue;
        }

        var_2[var_2.size] = var_4;
    }

    thread maps\_utility::ai_delete_when_out_of_sight( var_2, var_1 );
}

get_guys_in_vols_and_kill( var_0 )
{
    var_0 = getent( var_0, "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_3 in var_1 )
    {
        if ( isalive( var_3 ) && issentient( var_3 ) )
            var_3 thread bloody_death();
    }
}

bloody_death( var_0 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_1 = [];
    var_1[0] = "j_hip_le";
    var_1[1] = "j_hip_ri";
    var_1[2] = "j_head";
    var_1[3] = "j_spine4";
    var_1[4] = "j_elbow_le";
    var_1[5] = "j_elbow_ri";
    var_1[6] = "j_clavicle_le";
    var_1[7] = "j_clavicle_ri";

    for ( var_2 = 0; var_2 < 3 + randomint( 5 ); var_2++ )
    {
        var_3 = randomintrange( 0, var_1.size );
        thread bloody_death_fx( var_1[var_3], undefined );
        wait(randomfloat( 0.1 ));
    }

    self _meth_8051( self.health + 50, self.origin );
}

bloody_death_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

disable_grenades()
{
    if ( isdefined( self.grenadeammo ) && !isdefined( self.oldgrenadeammo ) )
        self.oldgrenadeammo = self.grenadeammo;

    self.grenadeammo = 0;
}

lower_accuracy_by_percent( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.25;

    if ( !isdefined( var_1 ) )
        self.already_set = 0;
    else
        self.already_set = 1;

    if ( self.already_set != 1 )
    {
        self.old_base = self.baseaccuracy;
        var_2 = self.old_base * var_0;
        self.old_acc = self.accuracy;
        var_3 = self.old_acc * var_0;
    }
    else
    {
        if ( !isdefined( self.old_base ) )
            self.old_base = self.baseaccuracy;

        if ( !isdefined( self.old_acc ) )
            self.old_acc = self.accuracy;

        var_2 = self.old_base * var_0;
        var_3 = self.old_acc * var_0;
    }

    if ( isalive( self ) && issentient( self ) )
    {
        self.baseaccuracy = var_2;
        self.accuracy = var_3;
    }
}

cleanup_extra_ai()
{
    self endon( "death" );
    self endon( "removed" );
    var_0 = getnode( self.script_parameters, "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    self _meth_81A5( var_0 );
    self waittill( "goal" );
    self delete();
}

magic_threat_grenade( var_0, var_1, var_2 )
{
    level endon( "player_jumped_the_gun" );
    var_3 = _func_070( "paint_grenade_var", var_0.origin, var_1.origin, var_2 );

    if ( isdefined( var_3 ) )
        var_3 thread maps\_variable_grenade::detection_grenade_think( level.player );
}

magic_smoke_grenade( var_0, var_1, var_2 )
{
    level endon( "player_jumped_the_gun" );
    var_3 = _func_070( "smoke_grenade_american", var_0.origin, var_1.origin, var_2 );
}

magic_emp_grenade( var_0, var_1, var_2 )
{
    var_3 = _func_070( "emp_grenade_var", var_0, var_1, var_2 );

    if ( isdefined( var_3 ) )
        var_3 thread maps\_variable_grenade::emp_grenade_think( self );
}

retreat_from_vol_to_vol( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
        var_4 = 1;

    if ( !isdefined( var_2 ) )
    {
        var_5 = getent( var_0, "targetname" );
        var_6 = var_5 maps\_utility::get_ai_touching_volume( "axis" );
        var_7 = getent( var_1, "targetname" );
        var_8 = getnode( var_7.target, "targetname" );

        if ( var_6.size <= 0 )
            return;

        foreach ( var_10 in var_6 )
        {
            wait(randomfloat( 0.5 ));

            if ( isdefined( var_10 ) && isalive( var_10 ) )
            {
                var_10.forcegoal = 0;
                var_10.fixednode = 0;
                var_10.pathrandompercent = randomintrange( 75, 100 );
                var_10 _meth_81A5( var_8 );
                var_10 _meth_81A9( var_7 );
            }
        }

        return var_6;
    }
    else
    {
        var_12 = maps\_utility::get_living_ai_array( var_2, "script_noteworthy" );
        var_13 = getent( var_1, "targetname" );

        if ( var_12.size )
        {
            foreach ( var_15 in var_12 )
            {
                wait(randomfloat( 0.5 ));

                if ( isalive( var_15 ) && isdefined( var_15 ) )
                {
                    var_15.forcegoal = 0;
                    var_15.fixednode = 0;
                    var_15.pathrandompercent = randomintrange( 75, 100 );
                    var_15 _meth_81A5( getnode( var_13.target, "targetname" ) );
                    var_15 _meth_81A9( var_13 );
                }
            }
        }

        if ( isdefined( var_3 ) )
        {
            if ( level.nextgen )
                var_3 = maps\_utility::array_spawn_targetname( var_3, 1 );
            else
                var_3 = maps\_utility::array_spawn_targetname_cg( var_3, 1, 0.1 );

            if ( var_4 && var_12.size )
                var_12 = common_scripts\utility::array_combine( var_12, var_3 );
        }

        return var_12;
    }
}

ai_array_killcount_flag_set( var_0, var_1, var_2, var_3 )
{
    maps\_utility::waittill_dead_or_dying( var_0, var_1, var_3 );
    common_scripts\utility::flag_set( var_2 );
}

debug_print_guys_in_volume( var_0 )
{
    var_0 = getent( var_0, "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );
    iprintlnbold( var_1.size );
}

spawn_func_respawn_on_death( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        var_0 = 1;
    else
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 16384;
    else
        var_1 *= var_1;

    var_2 = self.spawner;
    var_2.count = 99;

    if ( isdefined( var_2 ) && isdefined( var_2.script_parameters ) )
        level endon( var_2.script_parameters );

    common_scripts\utility::waittill_either( "death", "pain_death" );
    wait 1;
    var_3 = undefined;

    while ( !isdefined( var_3 ) && isdefined( var_2 ) && isdefined( var_2.count ) && var_2.count > 0 )
    {
        waitframe();

        if ( var_0 == 1 )
        {
            if ( distancesquared( level.player.origin, var_2.origin ) > var_1 )
            {
                var_3 = var_2 maps\_utility::spawn_ai();
                wait 1;
            }

            continue;
        }

        var_3 = var_2 maps\_utility::spawn_ai();
        wait 1;
    }
}

handle_triggers_off( var_0 )
{
    level waittill( "load_finished" );
    var_1 = getentarray( var_0, "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 common_scripts\utility::trigger_off();
}

handle_triggers_on( var_0 )
{
    var_1 = getentarray( var_0, "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 common_scripts\utility::trigger_on();
}

temp_dialogue( var_0, var_1, var_2 )
{
    level notify( "temp_dialogue", var_0, var_1, var_2 );
    level endon( "temp_dialogue" );

    if ( !isdefined( var_2 ) )
        var_2 = 4;

    if ( isdefined( level.tmp_subtitle ) )
    {
        level.tmp_subtitle destroy();
        level.tmp_subtitle = undefined;
    }

    level.tmp_subtitle = newhudelem();
    level.tmp_subtitle.x = 0;
    level.tmp_subtitle.y = -64;
    level.tmp_subtitle settext( "^2" + var_0 + ": ^7" + var_1 );
    level.tmp_subtitle.fontscale = 1.46;
    level.tmp_subtitle.alignx = "center";
    level.tmp_subtitle.aligny = "middle";
    level.tmp_subtitle.horzalign = "center";
    level.tmp_subtitle.vertalign = "bottom";
    level.tmp_subtitle.sort = 1;
    wait(var_2);
    thread temp_dialogue_fade();
}

temp_dialogue_fade()
{
    level endon( "temp_dialogue" );

    for ( var_0 = 1.0; var_0 > 0.0; var_0 -= 0.1 )
    {
        level.tmp_subtitle.alpha = var_0;
        wait 0.05;
    }

    level.tmp_subtitle destroy();
}
