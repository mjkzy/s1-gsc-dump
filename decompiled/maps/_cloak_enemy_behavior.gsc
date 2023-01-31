// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

cloak_enemy_reset_behavior()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    wait(randomfloatrange( 1, 7 ));
    self._stealth.logic.threat_level = "reset";
    self._cloak_enemy_state = "default_stealth_state";
    maps\_stealth_threat_enemy::enemy_alert_level_normal();
}

cloak_enemy_reset_behavior_mech()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    wait(randomfloatrange( 1, 7 ));
    self._stealth.logic.threat_level = "reset";
    self._cloak_enemy_state = "default_stealth_state";
    maps\_stealth_threat_enemy::enemy_alert_level_normal();
}

cloak_enemy_warning1_behavior_mech()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self._stealth.logic.threat_level = "warning1";
    thread maps\_stealth_threat_enemy::enemy_announce_alert();

    if ( isdefined( self.enemy ) )
    {
        var_0 = self _meth_81C1( self.enemy );
        maps\_utility::ent_flag_set( "_stealth_override_goalpos" );
        self _meth_81A6( var_0 );
        self.goalradius = 36;
        self._cloak_enemy_state = "Path 2 LKP";
        self waittill( "goal" );
        self._cloak_enemy_state = "Looking around LKP";
        maps\_stealth_threat_enemy::enemy_lookaround_for_time( randomfloatrange( 2, 4 ) );
        self._cloak_enemy_state = "Unknown";
        self.shootposoverride = undefined;
    }
}

cloak_enemy_warning1_behavior()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self._stealth.logic.threat_level = "warning1";
    thread maps\_stealth_threat_enemy::enemy_announce_alert();

    if ( isdefined( self.script_patroller ) )
    {
        var_0 = "a";

        if ( common_scripts\utility::cointoss() )
            var_0 = "b";

        maps\_stealth_shared_utilities::stealth_set_run_anim( "_stealth_patrol_search_" + var_0, 1 );
        self.disablearrivals = 1;
        self.disableexits = 1;
    }

    if ( isdefined( self.enemy ) )
    {
        var_1 = self _meth_81C1( self.enemy );
        maps\_utility::ent_flag_set( "_stealth_override_goalpos" );
        self _meth_81A6( var_1 );
        self.goalradius = 36;
        self._cloak_enemy_state = "Path 2 LKP";
        self waittill( "goal" );
        self._cloak_enemy_state = "Looking around LKP";
        maps\_stealth_threat_enemy::enemy_lookaround_for_time( randomfloatrange( 2, 4 ) );
        self._cloak_enemy_state = "Unknown";
        self.shootposoverride = undefined;
    }
}

cloak_enemy_warning2_behavior()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self._stealth.logic.threat_level = "warning2";
    maps\_stealth_threat_enemy::enemy_alert_level_warning2();
}

_investigate_last_known_position_with_endons()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self.pathrandompercent = 50;
    self.goalradius = 64;
    maps\_utility::ent_flag_set( "_stealth_override_goalpos" );
    self _meth_81A6( level._stealth.logic.lastknownposition );
    self._cloak_enemy_state = "Path 2 LKP";
    self waittill( "goal" );
    self._cloak_enemy_state = "Looking around LKP";
    maps\_stealth_threat_enemy::enemy_lookaround_for_time( randomfloatrange( 2, 4 ) );
}

_investigate_last_known_position_wrapper()
{
    level._stealth.logic.last_known_position_claimed = 1;
    _investigate_last_known_position_with_endons();
    level._stealth.logic.last_known_position_claimed = 0;

    if ( isdefined( self ) )
        self.investigating_last_known_position = 0;
}

cloak_enemy_attack_behavior_mech()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self._stealth.logic.threat_level = "attack";
    self._stealth.logic.has_entered_attack_behavior = 1;
    thread maps\_mech::mech_hunt_stealth_behavior();
}

cloak_enemy_fast_attack_behavior()
{
    var_0 = 10.0;
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self._stealth.logic.threat_level = "attack";
    self._cloak_enemy_state = "fast_attack";
    thread maps\_stealth_shared_utilities::enemy_announce_spotted( self.origin );

    if ( isdefined( self.enemy ) )
    {
        self.enemy_who_surprised_me = self.enemy;
        self.dontmelee = 1;
        self.disablereactionanims = 1;
        animscripts\shoot_behavior::decidewhatandhowtoshoot( "normal" );
        wait(var_0);
        self.disablereactionanims = 0;
        self.dontmelee = undefined;

        if ( isdefined( self.mech ) )
            self.dontmelee = 1;

        self.enemy_who_surprised_me = undefined;
    }

    if ( isdefined( self.script_goalvolume ) )
        thread maps\_spawner::set_goal_volume();
    else
        maps\_stealth_threat_enemy::enemy_close_in_on_target();
}

cloak_enemy_investigative_attack_behavior()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self._stealth.logic.threat_level = "attack";
    self._cloak_enemy_state = "investigative_attack";
    self._stealth.logic.has_entered_attack_behavior = 1;
    thread maps\_stealth_shared_utilities::enemy_announce_spotted( self.origin );

    while ( isdefined( self.enemy ) )
    {
        if ( !isdefined( level._stealth.logic.last_known_position_claimed ) || !level._stealth.logic.last_known_position_claimed )
        {
            foreach ( var_1 in level._stealth.group.groups )
            {
                if ( isdefined( common_scripts\utility::array_find( var_1, self ) ) )
                {
                    level._stealth.logic.lastknownposition = self _meth_81C1( self.enemy );

                    if ( isarray( var_1 ) )
                    {
                        var_1 = maps\_utility::array_removedead( var_1 );
                        var_2 = sortbydistance( var_1, level._stealth.logic.lastknownposition );

                        if ( isdefined( var_2 ) )
                        {
                            var_2[0] thread _investigate_last_known_position_wrapper();
                            var_2[0].investigating_last_known_position = 1;
                        }
                    }
                }
            }

            while ( isdefined( self.investigating_last_known_position ) && self.investigating_last_known_position )
                wait 0.05;

            wait 0.1;
            continue;
        }

        var_5 = getentarray( "info_v_stealth", "targetname" );

        if ( isdefined( var_5 ) )
        {
            foreach ( var_7 in var_5 )
            {
                if ( _func_22A( level._stealth.logic.lastknownposition, var_7 ) )
                {
                    self _meth_81AB();
                    self _meth_81A9( var_7 );
                    wait 1.0;
                    break;
                }
                else
                {
                    self._cloak_enemy_state = "Thinking";
                    wait(randomfloatrange( 0.2, 1 ));
                }
            }
        }
        else
        {

        }

        self._cloak_enemy_state = "Pathing to Cover";
        self waittill( "goal" );
        self._cloak_enemy_state = "In Cover";
        wait 1.0;
    }
}

cloak_enemy_attack_behavior()
{
    var_0 = 180;
    var_1 = 0;

    if ( isdefined( self.enemy ) )
    {
        var_2 = self.enemy.origin;
        var_3 = self.origin;

        if ( _func_220( var_3, var_2 ) < var_0 * var_0 )
            var_1 = 1;
    }

    if ( var_1 )
        cloak_enemy_fast_attack_behavior();
    else if ( isdefined( self.mech ) && self.mech )
    {
        self.goalradius = 1024;
        self _meth_81A6( self _meth_81C1( self.enemy ) );
        wait(randomfloatrange( 0.5, 1.5 ));
        self _meth_81A6( self.origin );
        cloak_enemy_attack_behavior_mech();
    }
    else
    {
        if ( randomfloatrange( 0, 1 ) < 0.33 )
            maps\_utility::enable_cqbwalk();

        cloak_enemy_investigative_attack_behavior();
    }
}

cloak_enemy_normal_behavior_mech()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self notify( "stop_hunting" );
    self._stealth.logic.threat_level = "normal";
    cloak_enemy_reset_behavior_mech();
}

cloak_enemy_normal_behavior()
{
    self endon( "death" );
    self endon( "_stealth_enemy_alert_level_change" );
    self._stealth.logic.threat_level = "normal";
    cloak_enemy_reset_behavior();
}

cloak_enemy_state_hidden()
{
    self.fovcosine = 0.5;
    self.fovcosinebusy = 0.1;
    self.favoriteenemy = undefined;
    self.dontattackme = 1;
    self.dontevershoot = 1;
    thread maps\_utility::set_battlechatter( 0 );
    self.diequietly = 1;
    self _meth_8166();
}

cloak_enemy_state_spotted( var_0 )
{
    self.fovcosine = 0.01;
    self.ignoreall = 0;
    self.dontattackme = undefined;
    self.dontevershoot = undefined;

    if ( isdefined( self.oldfixednode ) )
        self.fixednode = self.oldfixednode;

    thread maps\_utility::set_battlechatter( 1 );
    self.diequietly = 0;

    if ( !isdefined( var_0 ) )
    {
        maps\_utility::clear_run_anim();
        maps\_stealth_shared_utilities::enemy_stop_current_behavior();
    }

    if ( isdefined( var_0 ) )
        return;
}

cloak_enemy_default_setup()
{
    if ( isplayer( self ) )
    {
        maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
        return;
    }

    self._cloak_enemy_state = "default_stealth_state";
    maps\_stealth_utility::stealth_plugin_basic();
    self.pathrandompercent = 0;
    maps\_stealth_utility::stealth_plugin_threat();

    if ( isdefined( self.mech ) )
    {
        var_0["reset"] = ::cloak_enemy_reset_behavior_mech;
        var_0["attack"] = ::cloak_enemy_attack_behavior;
        var_0["normal"] = ::cloak_enemy_normal_behavior_mech;
        var_1 = [];
        var_1["reset"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
        var_1["warning"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
        var_1["attack"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
        maps\_stealth_utility::stealth_threat_behavior_custom( var_0, var_1 );
    }
    else
    {
        var_0["reset"] = ::cloak_enemy_reset_behavior;
        var_0["attack"] = ::cloak_enemy_attack_behavior;
        var_0["normal"] = ::cloak_enemy_normal_behavior;
        var_1 = [];
        var_1["reset"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
        var_1["warning"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
        var_1["attack"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
        maps\_stealth_utility::stealth_threat_behavior_custom( var_0, var_1 );
    }

    maps\_stealth_utility::stealth_enable_seek_player_on_spotted();
    maps\_stealth_utility::stealth_plugin_corpse();
    maps\_stealth_utility::stealth_plugin_event_all();
    maps\_stealth_event_enemy::stealth_event_mod( "heard_alarm", ::heard_alarm_reaction_behavior, maps\_stealth_animation_funcs::enemy_animation_generic );
    self.baseaccuracy = 2;
    self.fovcosine = 0.5;
    self.fovcosinebusy = 0.1;
    var_2 = [];

    if ( isdefined( self.mech ) )
    {
        var_2["hidden"] = ::cloak_enemy_state_hidden;
        var_2["spotted"] = ::cloak_enemy_state_spotted;
    }
    else
    {
        var_2["hidden"] = ::cloak_enemy_state_hidden;
        var_2["spotted"] = ::cloak_enemy_state_spotted;
    }

    maps\_stealth_utility::stealth_basic_states_custom( var_2 );

    if ( !isdefined( level._cloak_enemy_array ) )
        level._cloak_enemy_array = [];

    level._cloak_enemy_array[level._cloak_enemy_array.size] = self;
    self _meth_8177( "cloak_enemy_npcs" );
    maps\_utility::enable_surprise();
}

cqb_investigate_behavior( var_0 )
{
    self endon( "_stealth_enemy_alert_level_change" );
    level endon( "_stealth_spotted" );
    self endon( "_stealth_attack" );
    self endon( "death" );
    self endon( "pain_death" );
    self.disablearrivals = 0;
    self.disableexits = 0;
    var_1 = distance( var_0.origin, self.origin );
    self _meth_81A5( var_0 );
    self.goalradius = var_1 * 0.5;
    wait 0.05;
    maps\_utility::set_generic_run_anim( "_stealth_patrol_cqb" );
    self._stealth.debug_state = "Investigate-CQB";
    self waittill( "goal" );

    if ( !common_scripts\utility::flag( "_stealth_spotted" ) && ( !isdefined( self.enemy ) || !self _meth_81BE( self.enemy ) ) )
        maps\_stealth_shared_utilities::enemy_runto_and_lookaround( var_0 );
}

heard_alarm_reaction_behavior( var_0 )
{
    self endon( "death" );
    self endon( "pain_death" );
    level endon( "_stealth_spotted" );
    self endon( "_stealth_attack" );

    if ( !common_scripts\utility::flag( "_stealth_spotted" ) && !maps\_utility::ent_flag( "_stealth_attack" ) )
    {
        var_1 = self._stealth.logic.event.awareness_param[var_0];
        var_2 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near( var_1, 300, 40 );
        thread maps\_stealth_shared_utilities::enemy_announce_wtf();

        if ( isdefined( var_2 ) )
            thread cqb_investigate_behavior( var_2 );
    }

    var_3 = maps\_stealth_shared_utilities::group_get_flagname( "_stealth_spotted" );

    if ( common_scripts\utility::flag( var_3 ) )
        common_scripts\utility::flag_waitopen( var_3 );
    else
        self waittill( "normal" );
}
