// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

give_exo_cloak()
{
    var_0 = get_exo_cloak_weapon();

    if ( self _meth_8314( var_0 ) )
        return;

    self _meth_830E( var_0 );
    self _meth_84A6( var_0, 1.0 );
    self.exo_cloak_on = 0;
    self.exo_cloak_off_time = undefined;

    if ( self _meth_831A() == var_0 )
    {
        self _meth_82FB( "ui_exo_battery_level0", self _meth_84A2( var_0 ) );
        self _meth_82FB( "exo_ability_nrg_req0", _func_298( var_0 ) );
        self _meth_82FB( "exo_ability_nrg_total0", self _meth_84A5( var_0 ) );
    }
    else if ( self _meth_8345() == var_0 )
    {
        self _meth_82FB( "ui_exo_battery_level1", self _meth_84A2( var_0 ) );
        self _meth_82FB( "exo_ability_nrg_req1", _func_298( var_0 ) );
        self _meth_82FB( "exo_ability_nrg_total1", self _meth_84A5( var_0 ) );
    }

    if ( !isdefined( self.exocloak ) )
        self.exocloak = spawnstruct();

    self.exocloak.costume = [];
    self.exocloak.costume["viewmodel"] = self _meth_82ED();
    self.exocloak.costume["body"] = self _meth_83B8();
    self notify( "exo_cloak_reset" );
    thread wait_for_exocloak_cancel();
    thread wait_for_exocloak_pressed();
    thread wait_for_player_death();
    thread wait_for_game_end();
}

wait_for_exocloak_pressed()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self endon( "exo_cloak_reset" );

    for (;;)
    {
        self waittill( "exo_ability_activate", var_0 );

        if ( var_0 == level.cloakweapon )
        {
            if ( !self _meth_84F8() )
                thread handle_exocloak();
            else
                active_cloaking_disable( 1 );

            continue;
        }

        if ( !maps\mp\_utility::is_exo_ability_weapon( var_0 ) )
            active_cloaking_disable( 1 );
    }
}

wait_for_exocloak_cancel()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self endon( "exo_cloak_reset" );

    for (;;)
    {
        common_scripts\utility::waittill_any( "using_remote", "weapon_fired", "melee_fired", "ground_slam", "grenade_fire" );
        active_cloaking_disable( 1 );
    }
}

wait_for_player_death()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "exo_cloak_reset" );
    common_scripts\utility::waittill_any( "death", "faux_spawn", "joined_team" );
    active_cloaking_disable( 1 );
}

handle_exocloak()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self endon( "exo_cloak_disabled" );
    self endon( "exo_cloak_reset" );

    if ( self _meth_84A2( level.cloakweapon ) > 0 )
    {
        active_cloaking_enable();

        while ( self _meth_84A2( level.cloakweapon ) > 0 )
            wait 0.05;

        active_cloaking_disable( 1 );
    }
}

active_cloaking_enable()
{
    self.exo_cloak_on = 1;
    self.exo_cloak_off_time = undefined;
    self _meth_844B();
    hideattachmentswhilecloaked();
    self _meth_849F( level.cloakweapon );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( level.cloakweapon, "ui_exo_battery_toggle", 1 );
    thread maps\mp\_exo_battery::update_exo_battery_hud( level.cloakweapon );
    maps\mp\_snd_common_mp::snd_message( "mp_exo_cloak_activate" );
    self.pers["numberOfTimesCloakingUsed"]++;

    if ( isdefined( level.ishorde ) )
    {
        wait 2;
        self.ignoreme = 1;
    }
}

active_cloaking_disable( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( !self _meth_84F8() )
        return;

    self.exo_cloak_on = 0;
    self.exo_cloak_off_time = gettime();
    self _meth_844C();
    showattachmentsaftercloak();

    if ( isdefined( level.ishorde ) )
        self.ignoreme = 0;

    self _meth_84A0( level.cloakweapon );
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar( level.cloakweapon, "ui_exo_battery_toggle", 0 );

    if ( var_0 )
        maps\mp\_snd_common_mp::snd_message( "mp_exo_cloak_deactivate" );

    self notify( "exo_cloak_disabled" );
}

take_exo_cloak()
{
    var_0 = get_exo_cloak_weapon();
    self notify( "kill_battery" );
    active_cloaking_disable( 0 );
    self _meth_830F( var_0 );
    self notify( "exo_cloak_reset" );
}

wait_for_game_end()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self endon( "exo_cloak_reset" );
    level waittill( "game_ended" );
    active_cloaking_disable( 1 );
}

hideattachmentswhilecloaked()
{
    if ( self _meth_8314( "adrenaline_mp" ) )
    {
        if ( isdefined( self.overclock_on ) && self.overclock_on == 1 )
        {
            killfxontag( level.exo_overclock_vfx_le_active, self, "J_Hip_LE" );
            killfxontag( level.exo_overclock_vfx_ri_active, self, "J_Hip_RI" );
        }
        else
        {
            killfxontag( level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE" );
            killfxontag( level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI" );
        }
    }

    if ( self _meth_8314( "exorepulsor_equipment_mp" ) )
    {
        if ( isdefined( self.repulsoractive ) && self.repulsoractive == 1 )
            killfxontag( level.exo_repulsor_player_vfx_active, self, "TAG_JETPACK" );
        else
            killfxontag( level.exo_repulsor_player_vfx_inactive, self, "TAG_JETPACK" );
    }

    if ( self _meth_8314( "exoping_equipment_mp" ) )
    {
        if ( isdefined( self.exo_ping_on ) && self.exo_ping_on == 1 )
            killfxontag( level.exo_ping_vfx_active, self, "J_SpineUpper" );
        else
            killfxontag( level.exo_ping_vfx_inactive, self, "J_SpineUpper" );
    }

    if ( self _meth_8314( "extra_health_mp" ) )
    {
        if ( isdefined( self.exo_health_on ) && self.exo_health_on == 1 )
        {
            killfxontag( level.exo_health_le_active_vfx, self, "J_Shoulder_LE" );
            killfxontag( level.exo_health_rt_active_vfx, self, "J_Shoulder_RI" );
        }
        else
        {
            killfxontag( level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE" );
            killfxontag( level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI" );
        }
    }
}

showattachmentsaftercloak()
{
    if ( self _meth_8314( "adrenaline_mp" ) )
    {
        if ( isdefined( self.overclock_on ) && self.overclock_on == 1 )
        {
            playfxontag( level.exo_overclock_vfx_le_active, self, "J_Hip_LE" );
            playfxontag( level.exo_overclock_vfx_ri_active, self, "J_Hip_RI" );
        }
        else
        {
            playfxontag( level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE" );
            playfxontag( level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI" );
        }
    }

    if ( self _meth_8314( "exorepulsor_equipment_mp" ) )
    {
        if ( isdefined( self.repulsoractive ) && self.repulsoractive == 1 )
            playfxontag( level.exo_repulsor_player_vfx_active, self, "TAG_JETPACK" );
        else
            playfxontag( level.exo_repulsor_player_vfx_inactive, self, "TAG_JETPACK" );
    }

    if ( self _meth_8314( "exoping_equipment_mp" ) )
    {
        if ( isdefined( self.exo_ping_on ) && self.exo_ping_on == 1 )
            playfxontag( level.exo_ping_vfx_active, self, "J_SpineUpper" );
        else
            playfxontag( level.exo_ping_vfx_inactive, self, "J_SpineUpper" );
    }

    if ( self _meth_8314( "extra_health_mp" ) )
    {
        if ( isdefined( self.exo_health_on ) && self.exo_health_on == 1 )
        {
            playfxontag( level.exo_health_le_active_vfx, self, "J_Shoulder_LE" );
            playfxontag( level.exo_health_rt_active_vfx, self, "J_Shoulder_RI" );
        }
        else
        {
            playfxontag( level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE" );
            playfxontag( level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI" );
        }
    }
}

get_exo_cloak_weapon()
{
    if ( isdefined( level.cloakweapon ) )
        return level.cloakweapon;

    level.cloakweapon = "exocloak_equipment_mp";

    if ( isdefined( level.ishorde ) )
        level.cloakweapon = "exocloakhorde_equipment_mp";

    return level.cloakweapon;
}
