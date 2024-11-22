// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

irons_estate_vehicle_guy_stealth_setup( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = maps\_vehicle::spawn_vehicle_from_targetname( var_0 );
    var_7 maps\_vehicle::godon();
    var_7.vehicle_driver = maps\_utility::spawn_targetname( var_1, 1 );
    var_8["reset"] = ::irons_estate_vehicle_passenger_normal;
    var_8["normal"] = ::irons_estate_vehicle_passenger_normal;
    var_7.vehicle_driver maps\_stealth_utility::stealth_threat_behavior_custom( var_8 );
    var_7 maps\irons_estate_stealth::stealth_ai_idle_and_react_custom( var_7.vehicle_driver, var_3, var_4, var_2, var_5 );

    if ( isdefined( var_6 ) )
        var_7 thread irons_estate_vehicle_open_door_anim( var_7.vehicle_driver, var_6 );

    var_7 thread irons_estate_vehicle_damaged_watcher();
}

irons_estate_vehicle_open_door_anim( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_0 maps\_utility::ent_flag_waitopen( "_stealth_normal" );
    maps\_vehicle_aianim::setanimrestart_once( var_1, 1 );
}

irons_estate_vehicle_damaged_watcher()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3 );

        if ( isdefined( var_1 ) && var_1 == level.player )
            break;

        wait 0.05;
    }

    if ( isdefined( self.vehicle_driver ) && isalive( self.vehicle_driver ) && !common_scripts\utility::flag( "_stealth_spotted" ) && isdefined( self.vehicle_driver._stealth ) )
    {
        self.vehicle_driver endon( "death" );

        if ( isdefined( var_3 ) )
            self.vehicle_driver notify( "vehicle_damaged", var_3 );
        else
            self.vehicle_driver notify( "vehicle_damaged", self.origin );

        var_4 = maps\_stealth_shared_utilities::group_get_ai_in_group( self.vehicle_driver.script_stealthgroup );

        if ( isdefined( var_4 ) )
        {
            foreach ( var_7, var_6 in var_4 )
            {
                if ( var_6 == self )
                    continue;

                if ( isdefined( var_6.enemy ) || isdefined( var_6.favoriteenemy ) )
                    continue;

                var_6 thread maps\irons_estate_code::notify_delay_param( "vehicle_damaged", randomfloatrange( 0.25, 1.5 ), self.origin );
            }
        }
    }
}

irons_estate_vehicle_passenger_normal()
{
    thread maps\_stealth_shared_utilities::enemy_announce_hmph();
    irons_estate_vehicle_passenger_go_back();
}

irons_estate_vehicle_passenger_go_back()
{
    self notify( "going_back" );
    self endon( "death" );
    self notify( "stop_loop" );

    if ( !isdefined( self.script_patroller ) )
        self.script_patroller = 1;

    self._stealth.debug_state = "Going Back";

    if ( isdefined( self._stealth.behavior.goback_startfunc ) )
        self [[ self._stealth.behavior.goback_startfunc ]]();

    var_0 = self._stealth.behavior.last_spot;

    if ( isdefined( var_0 ) && self.type != "dog" && !isdefined( self.custommovetransition ) && !isdefined( self.mech ) )
        self.custommovetransition = maps\_patrol::patrol_resume_move_start_func;

    if ( isdefined( self.custommovetransition ) && isdefined( self.pathgoalpos ) )
    {
        self setgoalpos( self.origin );
        wait 0.05;
    }

    if ( isdefined( self.script_patroller ) )
    {
        var_1 = common_scripts\utility::getstructarray( self.script_parameters, "script_noteworthy" );
        var_2 = common_scripts\utility::getclosest( self.origin, var_1 );
        var_3 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        self.target = var_3.targetname;
        thread maps\_patrol::patrol();
    }
    else if ( isalive( self.patrol_master ) )
    {
        thread maps\_patrol::pet_patrol();
        maps\_utility::set_dog_walk_anim();
        self.script_growl = undefined;
    }
    else if ( isdefined( var_0 ) )
    {
        if ( self.type != "dog" )
            maps\_stealth_shared_utilities::stealth_set_run_anim( "_stealth_patrol_walk", 1 );
        else
        {
            maps\_utility::set_dog_walk_anim();
            self.script_growl = undefined;
        }

        self.disablearrivals = 1;
        self.disableexits = 1;
        self setgoalpos( var_0 );
        self.goalradius = 40;
    }

    waittillframeend;
    maps\_utility::ent_flag_clear( "_stealth_override_goalpos" );

    if ( isdefined( var_0 ) )
        thread maps\_stealth_shared_utilities::enemy_go_back_clear_lastspot( var_0 );
}

irons_estate_vehicle_passenger_death_watcher()
{

}
