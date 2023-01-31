// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

exo_hover_think()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_hover_taken" );

    if ( !self _meth_8314( level.hoverweapon ) )
        return;

    exo_hover_init();

    for (;;)
    {
        if ( self _meth_84A8( level.hoverweapon ) == 0 )
            self waittillmatch( "battery_discharge_begin", level.hoverweapon );

        self.exo_hover_on = 1;
        maps\mp\gametypes\_gamelogic::sethasdonecombat( self, 1 );
        self.pers["numberOfTimesHoveringUsed"]++;
        maps\mp\_exo_battery::set_exo_ability_hud_omnvar( level.hoverweapon, "ui_exo_battery_toggle", 1 );
        thread maps\mp\_exo_battery::update_exo_battery_hud( level.hoverweapon );
        thread exo_hover_update();
        thread play_exo_hover_vfx();

        if ( maps\mp\_utility::_hasperk( "specialty_exo_blastsuppressor" ) )
            maps\mp\_snd_common_mp::snd_message( "mp_suppressed_exo_hover" );
        else
            maps\mp\_snd_common_mp::snd_message( "mp_regular_exo_hover" );

        thread end_exo_hover_on_notifies();

        if ( self _meth_84A8( level.hoverweapon ) == 1 )
            self waittillmatch( "battery_discharge_end", level.hoverweapon );

        maps\mp\_exo_battery::set_exo_ability_hud_omnvar( level.hoverweapon, "ui_exo_battery_toggle", 0 );
        self.exo_hover_on = 0;
        self notify( "stop_exo_hover_effects" );
    }
}

exo_hover_init()
{
    self _meth_84A6( level.hoverweapon, 1.0 );
    var_0 = self _meth_84A5( level.hoverweapon );

    if ( self _meth_831A() == level.hoverweapon )
    {
        self _meth_82FB( "exo_ability_nrg_req0", 0 );
        self _meth_82FB( "exo_ability_nrg_total0", var_0 );
        self _meth_82FB( "ui_exo_battery_level0", var_0 );
    }
    else if ( self _meth_8345() == level.hoverweapon )
    {
        self _meth_82FB( "exo_ability_nrg_req1", 0 );
        self _meth_82FB( "exo_ability_nrg_total1", var_0 );
        self _meth_82FB( "ui_exo_battery_level1", var_0 );
    }

    if ( !isdefined( level.regular_exo_hover_vfx ) )
        level.regular_exo_hover_vfx = loadfx( "vfx/smoke/exohover_exhaust_continuous" );

    if ( !isdefined( level.suppressed_exo_hover_vfx ) )
        level.suppressed_exo_hover_vfx = loadfx( "vfx/smoke/exohover_exhaust_continuous_suppressed" );

    if ( level.gametype == "horde" )
        setdynamicdvar( "hover_max_travel_distance", 1000 );
    else
        setdynamicdvar( "hover_max_travel_distance", 350 );
}

end_exo_hover_on_notifies()
{
    self endon( "stop_exo_hover_effects" );
    common_scripts\utility::waittill_any( "death", "disconnect", "joined_team", "faux_spawn", "exo_hover_taken" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( level.hoverweapon, "ui_exo_battery_toggle", 0 );
    self.exo_hover_on = 0;
    self notify( "stop_exo_hover_effects" );
}

take_exo_hover()
{
    level.hoverweapon = "exohover_equipment_mp";

    if ( isdefined( level.ishorde ) )
        level.hoverweapon = "exohoverhorde_equipment_mp";

    self notify( "kill_battery" );
    self notify( "exo_hover_taken" );
    self _meth_830F( level.hoverweapon );
}

give_exo_hover()
{
    level.hoverweapon = "exohover_equipment_mp";

    if ( isdefined( level.ishorde ) )
        level.hoverweapon = "exohoverhorde_equipment_mp";

    self _meth_830E( level.hoverweapon );
    thread exo_hover_think();
}

exo_hover_update()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_hover_taken" );
    self endon( "stop_exo_hover_effects" );
    var_0 = self _meth_84A7( level.hoverweapon );
    var_1 = self _meth_84A5( level.hoverweapon );

    for (;;)
    {
        self _meth_80AD( "damage_heavy" );
        var_2 = self getvelocity();
        var_3 = length2d( var_2 );
        var_4 = 1.0;

        if ( level.gametype == "horde" )
        {
            if ( isdefined( self.hordeexobattery ) )
                var_4 = 1.0 + self.hordeexobattery * -0.1;
        }

        self _meth_84A6( level.hoverweapon, max( var_4, var_1 * var_3 / getdvarint( "hover_max_travel_distance", 350 ) * var_0 ) );
        wait 0.1;
    }
}

play_exo_hover_vfx()
{
    level endon( "game_ended" );
    var_0 = 0;

    if ( maps\mp\_utility::_hasperk( "specialty_exo_blastsuppressor" ) )
    {
        var_0 = 1;
        var_1 = _func_2C1( level.suppressed_exo_hover_vfx, self, "tag_jetpack" );
    }
    else
        var_1 = _func_2C1( level.regular_exo_hover_vfx, self, "tag_jetpack" );

    triggerfx( var_1 );
    common_scripts\utility::waittill_any( "disconnect", "death", "joined_team", "faux_spawn", "exo_hover_taken", "stop_exo_hover_effects" );

    if ( isdefined( var_1 ) )
        var_1 delete();
}
