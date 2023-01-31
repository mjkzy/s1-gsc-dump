// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

initsonicaoe()
{
    if ( !isdefined( level.sonicaoeready ) )
    {
        precacherumble( "damage_heavy" );
        precacheshader( "dpad_icon_sonic_blast" );
        precacheshader( "dpad_icon_sonic_blast_off" );
        precachestring( &"SONICAOE_READY" );
        precachestring( &"SONICAOE_NOTREADY" );
        maps\_utility::add_hint_string( "Sonic_AOE_Ready", &"SONICAOE_READY", ::_sonicaoenotready );
        maps\_utility::add_hint_string( "Sonic_AOE_NotReady", &"SONICAOE_NOTREADY" );
        level._effect["sonic_blast"] = loadfx( "vfx/map/greece/greece_sonic_charge_burst" );
        level.sonicaoeready = 0;
        level.sonicaoeactive = 0;
    }
}

enablesonicaoe( var_0 )
{
    level notify( "DisableSonicAoE" );
    level endon( "DisableSonicAoE" );

    if ( !isdefined( var_0 ) )
        var_0 = 2;

    level.player _meth_82DD( "flash_aoe", "+actionslot " + var_0 );

    for (;;)
    {
        var_1 = 0;
        update_sonic_aoe_icon();
        level.sonicaoeready = 1;

        while ( !var_1 )
        {
            level.player waittill( "flash_aoe" );
            var_1 = maps\_player_exo::batteryspend( 1 );

            if ( !var_1 )
                wait 0.5;
        }

        level.player _meth_8309( 0.45 );
        level.player _meth_821B( "actionslot" + var_0, "dpad_icon_sonic_blast_off" );
        soundscripts\_snd::snd_message( "start_sonic_attack_mix" );
        level notify( "SonicAoEStarted" );
        soundscripts\_snd::snd_message( "sonic_blast" );
        level.sonicaoeactive = 1;
        earthquake( 0.65, 0.6, level.player.origin, 128 );
        physicsexplosionsphere( level.player.origin, 512, 512, 1 );
        level.player _meth_80AD( "damage_heavy" );
        level.player thread _stunassaultdrones();

        for ( var_2 = 0; var_2 < 7; var_2++ )
        {
            earthquake( 0.25, 0.3, level.player.origin, 128 );
            var_3 = level.player.origin + ( 0, 0, 24 ) + anglestoforward( level.player.angles ) * 64;
            playfx( level._effect["sonic_blast"], var_3, anglestoforward( level.player.angles ), anglestoup( level.player.angles ) );
            soundscripts\_snd::snd_message( "sonic_blast_aftershock" );
            glassradiusdamage( level.player.origin, 512, 100, 100 );
            var_4 = getentarray( "SonicAoECanDamage", "script_noteworthy" );
            var_5 = maps\_utility::get_within_range( level.player.origin, var_4, 512 );

            foreach ( var_7 in var_5 )
                var_7 notify( "SonicAoEDamage" );

            var_9 = [];
            var_9 = _func_0D6( "axis", "neutral" );
            var_10 = common_scripts\utility::get_array_of_closest( level.player.origin, var_9, undefined, undefined, 512, 0 );

            if ( var_10.size > 0 )
            {
                foreach ( var_12 in var_10 )
                {
                    if ( !isdefined( var_12 ) )
                        continue;

                    if ( !isalive( var_12 ) )
                        continue;

                    if ( isdefined( var_12.ignoresonicaoe ) )
                        continue;

                    if ( !isdefined( var_12.isinsonicstun ) )
                        var_12 thread track_loud_enough_achievement();

                    var_13 = var_12 get_stun_thread_for_ai();

                    if ( isdefined( var_13 ) )
                        var_12 thread [[ var_13 ]]();

                    wait(randomfloatrange( 0.05, 0.09 ));
                }
            }

            wait(randomfloatrange( 1, 1.25 ));
        }

        soundscripts\_snd::snd_message( "sonic_blast_done" );
        level.player _meth_8309( 1 );
        level.sonicaoeactive = 0;
        level.sonicaoeready = 0;
        wait 0.5;
    }
}

track_loud_enough_achievement()
{
    if ( !isdefined( self.isinsonicstun ) )
        self.isinsonicstun = 1;

    wait 4;
    self.isinsonicstun = undefined;
}

get_stun_thread_for_ai()
{
    if ( isdefined( self.sonic_aoe_thread ) )
        return self.sonic_aoe_thread;
    else if ( self.team == "axis" )
        return ::_stunenemies;

    return ::_stuncivilians;
}

_stunenemies()
{
    var_0 = common_scripts\utility::isflashed();

    if ( !var_0 )
    {
        if ( isdefined( self.sonic_stop_scripted_anim ) )
            self _meth_8141();

        maps\_utility::flashbangstart( 4 );
    }
}

_stuncivilians()
{
    self endon( "death" );
    self.iscivilianflashed = 1;
    self _meth_8141();
    wait(randomfloatrange( 0.1, 0.2 ));
    thread _findfleelocation();
}

_findfleelocation()
{
    self endon( "death" );
    var_0 = getnodesinradiussorted( self.origin, 256, 128, 32 );

    foreach ( var_2 in var_0 )
    {
        if ( maps\_utility::players_within_distance( 256, var_2.origin ) )
            var_0 = common_scripts\utility::array_remove( var_0, var_2 );
    }

    var_4 = var_0[var_0.size - 1];

    if ( isdefined( var_4 ) )
    {
        maps\_utility::set_goal_node( var_4 );
        self waittill( "goal" );
    }
}

_stunassaultdrones()
{
    level notify( "_StunAssaultDrones" );
    level endon( "_StunAssaultDrones" );
    self endon( "death" );

    while ( level.sonicaoeactive )
    {
        wait 0.05;

        if ( !isdefined( level.flying_attack_drones ) || level.flying_attack_drones.size == 0 )
            continue;

        foreach ( var_1 in level.flying_attack_drones )
        {
            if ( !isdefined( var_1 ) || _func_220( var_1.origin, level.player.origin ) > squared( 1024 ) )
                continue;

            var_1 notify( "stun_drone" );
        }
    }
}

_sonicaoeanim()
{
    level.player _meth_831D();
    level.player waittill( "weapon_change" );
    var_0 = maps\_utility::spawn_anim_model( "player_rig", level.player.origin );
    var_0 _meth_80A6( level.player, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    level.player maps\_anim::anim_single_solo( var_0, "SonicAoE_On" );
    level.player _meth_831E();
    var_0 _meth_804F();
    var_0 delete();
}

displaysonicaoecontextualhints()
{
    thread _displayhelpertext();
    thread _displayrechargehelpertext();
}

_displayhelpertext()
{
    level endon( "DisableSonicAoE" );
    level endon( "DisableSonicAoEHints" );

    for (;;)
    {
        wait 0.05;
        wait 30;

        if ( level.sonicaoeready == 0 || level.sonicaoeactive == 1 )
            continue;

        var_0 = _func_0D6( "axis" );
        var_0 = maps\_utility::array_removedead_or_dying( var_0 );

        if ( isdefined( level.flying_attack_drones ) && level.flying_attack_drones.size > 0 )
            var_0 = maps\_utility::array_merge( var_0, level.flying_attack_drones );

        var_1 = common_scripts\utility::getclosest( level.player.origin, var_0, 512 );

        if ( isdefined( var_1 ) )
            maps\_utility::display_hint_timeout( "Sonic_AOE_Ready", 10, undefined, undefined, undefined, 200 );
    }
}

_sonicaoenotready()
{
    return level.sonicaoeactive;
}

_displayrechargehelpertext()
{
    level endon( "DisableSonicAoE" );
    level endon( "DisableSonicAoEHints" );

    for (;;)
    {
        level.player waittill( "flash_aoe" );

        if ( level.sonicaoeready == 0 )
            maps\_utility::display_hint( "Sonic_AOE_NotReady", undefined, undefined, undefined, 200 );

        wait 0.05;
    }
}

disablesonicaoe( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 2;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    level notify( "DisableSonicAoE" );

    if ( var_1 == 1 )
        level.player _meth_821B( "actionslot" + var_0, "dpad_icon_sonic_blast_off" );
    else
        level.player _meth_821B( "actionslot" + var_0, "dpad_icon_sonic_blast_off" );
}

update_sonic_aoe_icon( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 2;

    if ( !maps\_player_exo::player_exo_is_active() )
        level.player _meth_821B( "actionslot" + var_0, "none" );
    else if ( maps\_player_exo::get_exo_battery_percent() > 0 )
        level.player _meth_821B( "actionslot" + var_0, "dpad_icon_sonic_blast" );
    else
        level.player _meth_821B( "actionslot" + var_0, "dpad_icon_sonic_blast_off" );
}
