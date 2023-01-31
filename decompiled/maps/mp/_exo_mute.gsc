// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

exo_mute_think()
{
    self notify( "exo_mute_taken" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_mute_taken" );

    if ( !self _meth_8314( "exomute_equipment_mp" ) )
        return;

    exo_mute_init();
    thread monitor_player_death();
    thread wait_for_game_end();

    for (;;)
    {
        self waittill( "exo_ability_activate", var_0 );

        if ( var_0 == "exomute_equipment_mp" )
            thread try_use_exo_mute();
    }
}

exo_mute_init()
{
    self.mute_on = 0;
    self _meth_84A6( "exomute_equipment_mp", 1.0 );
    var_0 = self _meth_84A5( "exomute_equipment_mp" );

    if ( self _meth_831A() == "exomute_equipment_mp" )
    {
        self _meth_82FB( "exo_ability_nrg_req0", 0 );
        self _meth_82FB( "exo_ability_nrg_total0", var_0 );
        self _meth_82FB( "ui_exo_battery_level0", var_0 );
    }
    else if ( self _meth_8345() == "exomute_equipment_mp" )
    {
        self _meth_82FB( "exo_ability_nrg_req1", 0 );
        self _meth_82FB( "exo_ability_nrg_total1", var_0 );
        self _meth_82FB( "ui_exo_battery_level1", var_0 );
    }

    if ( !isdefined( level.exo_mute_3p ) )
        level.exo_mute_3p = loadfx( "vfx/unique/exo_mute_3p" );

    wait 0.05;

    if ( !maps\mp\_utility::invirtuallobby() )
        return;
}

try_use_exo_mute()
{
    self endon( "exo_mute_taken" );

    if ( self.mute_on == 1 )
        thread stop_exo_mute( 1 );
    else
        thread start_exo_mute();
}

killmutefx()
{
    if ( isdefined( self.mute_fx ) )
    {
        self.mute_fx delete();
        self.mute_fx = undefined;
    }
}

start_exo_mute()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_mute_taken" );
    self endon( "end_exo_mute" );
    self.mute_on = 1;
    maps\mp\_utility::giveperk( "specialty_quieter", 0 );
    self _meth_849F( "exomute_equipment_mp" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( "exomute_equipment_mp", "ui_exo_battery_toggle", 1 );
    thread maps\mp\_exo_battery::update_exo_battery_hud( "exomute_equipment_mp" );
    thread monitor_mute_battery_charge();
    maps\mp\_snd_common_mp::snd_message( "mp_exo_mute_activate" );
    wait 0.05;

    if ( !self.mute_on )
        return;

    if ( !isdefined( self.exo_cloak_on ) || self.exo_cloak_on == 0 )
    {
        self.mute_fx = _func_2C1( level.exo_mute_3p, self, "TAG_ORIGIN" );
        triggerfx( self.mute_fx );
    }
}

stop_exo_mute( var_0 )
{
    if ( !isdefined( self.mute_on ) || !self.mute_on )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    self notify( "end_exo_mute" );
    self.mute_on = 0;
    self _meth_82A9( "specialty_quieter", 1 );
    self _meth_84A0( "exomute_equipment_mp" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( "exomute_equipment_mp", "ui_exo_battery_toggle", 0 );
    killmutefx();

    if ( var_0 == 1 )
    {
        maps\mp\_snd_common_mp::snd_message( "mp_exo_mute_deactivate" );
        wait 0.05;

        if ( !isdefined( self.exo_cloak_on ) || self.exo_cloak_on == 0 )
            return;
    }
}

monitor_player_death()
{
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "death", "joined_team", "faux_spawn", "exo_mute_taken" );
    thread stop_exo_mute( 0 );
}

monitor_mute_battery_charge()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_mute_taken" );
    self endon( "end_exo_mute" );

    while ( self.mute_on == 1 )
    {
        if ( self _meth_84A2( "exomute_equipment_mp" ) <= 0 )
            thread stop_exo_mute( 1 );

        wait 0.05;
    }
}

take_exo_mute()
{
    self notify( "kill_battery" );
    self notify( "exo_mute_taken" );
    self _meth_830F( "exomute_equipment_mp" );
}

give_exo_mute()
{
    self _meth_830E( "exomute_equipment_mp" );
    thread exo_mute_think();
}

wait_for_game_end()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_mute_taken" );
    level waittill( "game_ended" );
    thread stop_exo_mute( 0 );
}
