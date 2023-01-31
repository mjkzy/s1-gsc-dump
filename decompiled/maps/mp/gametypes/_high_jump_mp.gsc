// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    if ( !maps\mp\_utility::isaugmentedgamemode() )
        return;

    level.map_border_trig_array = getentarray( "boost_jump_border_trig", "targetname" );
    high_jump_enable();
    thread high_jump_host_migration();
    thread high_jump_on_player_spawn();
}

high_jump_enable()
{

}

high_jump_on_player_spawn()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned", var_0 );
        var_0 thread map_border_hud_updater();
        var_0 maps\mp\_utility::playerallowhighjump( 1 );
        var_0 maps\mp\_utility::playerallowhighjumpdrop( 1 );
        var_0 maps\mp\_utility::playerallowboostjump( 1 );
        var_0 maps\mp\_utility::playerallowpowerslide( 1 );
        var_0 maps\mp\_utility::playerallowdodge( 1 );
        var_0 thread exo_dodge_think();
        var_0 _meth_82FB( "ui_border_warning_toggle", 0 );
    }
}

high_jump_host_migration()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        high_jump_enable();
    }
}

map_border_hud_updater()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self.touching_border = undefined;

    for (;;)
    {
        if ( isdefined( level.map_border_trig_array ) )
        {
            var_0 = 0;

            foreach ( var_2 in level.map_border_trig_array )
            {
                var_3 = self _meth_80A9( var_2 );

                if ( var_3 )
                {
                    var_0 = 1;
                    break;
                }
            }

            if ( !isdefined( self.touching_border ) || self.touching_border != var_0 )
            {
                if ( var_0 )
                    self _meth_82FB( "ui_border_warning_toggle", 1 );
                else
                    self _meth_82FB( "ui_border_warning_toggle", 0 );

                self.touching_border = var_0;
            }
        }

        wait 0.05;
    }
}

exo_dodge_think()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "exo_dodge" );
        var_0 = getdvarfloat( "dodge_cooldown_time_sec", 0.2 );
        thread exo_dodge_cooldown();
        maps\mp\_exo_suit::exo_power_cooldown( var_0 );
        var_1 = gettime();

        if ( isdefined( self.lastdamagedtime ) && var_1 - self.lastdamagedtime < 1000 )
            maps\mp\gametypes\_missions::processchallengedaily( 38, undefined, undefined );
    }
}

exo_dodge_cooldown()
{
    var_0 = getdvarfloat( "dodge_weapon_enable", 1 );

    if ( !var_0 )
    {
        var_1 = getdvarint( "exo_dodge_weapon_disable_time", 0.2 );
        common_scripts\utility::_disableweapon();
        wait(var_1);
        common_scripts\utility::_enableweapon();
    }
}
