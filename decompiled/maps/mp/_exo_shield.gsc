// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

exo_shield_think()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_shield_taken" );
    self notify( "exo_shield_think_end" );
    self endon( "exo_shield_think_end" );
    var_0 = get_exo_shield_weapon();

    if ( !self _meth_8314( var_0 ) )
        return;

    self _meth_84A6( var_0, 1.0 );
    var_1 = _func_297( var_0 );
    var_2 = self _meth_84A5( var_0 );

    if ( self _meth_831A() == var_0 )
    {
        self _meth_82FB( "ui_exo_battery_level0", var_2 );
        self _meth_82FB( "exo_ability_nrg_req0", var_1 );
        self _meth_82FB( "exo_ability_nrg_total0", var_2 );
    }
    else if ( self _meth_8345() == var_0 )
    {
        self _meth_82FB( "ui_exo_battery_level1", var_2 );
        self _meth_82FB( "exo_ability_nrg_req1", var_1 );
        self _meth_82FB( "exo_ability_nrg_total1", var_2 );
    }

    thread wait_for_player_death( var_0 );

    for (;;)
    {
        self waittillmatch( "grenade_pullback", var_0 );
        maps\mp\_snd_common_mp::snd_message( "mp_exo_shield_activate" );
        self.pers["numberOfTimesShieldUsed"]++;
        maps\mp\_exo_battery::set_exo_ability_hud_omnvar( var_0, "ui_exo_battery_toggle", 1 );
        self.exo_shield_on = 1;

        if ( !isagent( self ) )
            thread maps\mp\_exo_battery::update_exo_battery_hud( var_0 );

        if ( self _meth_84A8( var_0 ) == 1 )
            self waittillmatch( "battery_discharge_end", var_0 );

        maps\mp\_snd_common_mp::snd_message( "mp_exo_shield_deactivate" );
        maps\mp\_exo_battery::set_exo_ability_hud_omnvar( var_0, "ui_exo_battery_toggle", 0 );
        self.exo_shield_on = 0;
    }
}

take_exo_shield()
{
    self notify( "kill_battery" );
    self notify( "exo_shield_taken" );
    self _meth_830F( get_exo_shield_weapon() );
}

give_exo_shield()
{
    self _meth_830E( get_exo_shield_weapon() );
    thread exo_shield_think();
}

get_exo_shield_weapon()
{
    if ( isdefined( level.exoshieldweapon ) )
        return level.exoshieldweapon;

    level.exoshieldweapon = "exoshield_equipment_mp";

    if ( isdefined( level.ishorde ) )
        level.exoshieldweapon = "exoshieldhorde_equipment_mp";

    return level.exoshieldweapon;
}

wait_for_player_death( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "death", "joined_team", "faux_spawn", "exo_shield_taken" );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( var_0, "ui_exo_battery_toggle", 0 );
    self.exo_shield_on = 0;
    self _meth_84C6();
}
