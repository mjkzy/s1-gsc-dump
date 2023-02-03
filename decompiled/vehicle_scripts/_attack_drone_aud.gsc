// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

attack_drone_queen_audio()
{
    var_0 = 0.1;
    var_1 = 3.0;
    var_2 = 5.0;
    var_3 = 0.05;
    var_4 = 0.85;
    var_5 = 1.2;

    if ( !isdefined( level._snd ) )
        level._snd = spawnstruct();

    if ( !isdefined( level._snd.queen_count ) )
        level._snd.queen_count = 0;

    if ( level._snd.queen_count > var_1 )
    {
        attack_drone_queen_1shot_handler( var_1 );
        return;
    }

    if ( !issubstr( self.classname, "queen" ) )
        return;

    level._snd.queen_count += 1;
    var_6 = self;
    var_7 = 20;
    var_8 = [ [ 0, var_4 ], [ var_7, var_5 ] ];
    var_9 = [ "attack_drone_queen_lp_near", "attack_drone_queen_lp_med", "attack_drone_queen_lp_dist" ];
    var_10 = [];
    var_11 = "attack_drone_queen_audio_stop_notify" + soundscripts\_snd::snd_new_guid();
    var_12 = 0;

    foreach ( var_14 in var_9 )
        var_10[var_14] = var_6 soundscripts\_snd_playsound::snd_play_loop_linked( var_14, var_11, var_2, var_2 );

    while ( isdefined( var_6 ) && var_6.classname != "script_vehicle_corpse" )
    {
        var_16 = var_6 vehicle_getspeed();

        if ( var_16 > var_7 )
        {
            var_7 = var_16;
            var_8[var_8.size - 1][0] = var_7;
        }

        var_16 = soundscripts\_audio::aud_smooth( var_12, var_16, var_3 );
        var_12 = var_16;
        var_17 = soundscripts\_snd::snd_map( var_16, var_8 );

        foreach ( var_19 in var_10 )
        {
            if ( isdefined( var_19 ) && !isremovedentity( var_19 ) )
                var_19 scalepitch( var_17, var_0 );
        }

        wait(var_0);
    }

    level notify( var_11 );
    level._snd.queen_count -= 1;
}

attack_drone_kamikaze_audio()
{
    soundscripts\_snd_playsound::snd_play_linked( "attack_drone_kamikazi", "drone_kamikaze_crash" );

    for (;;)
    {
        level waittill( "drone_kamikaze_crash", var_0 );

        if ( isremovedentity( self ) )
            break;
    }

    if ( level.player getcurrentweapon() == "weapon_suv_door_shield_fl" )
        soundscripts\_snd_playsound::snd_play_at( "seo_drone_suicide_door", var_0 );
}

attack_drone_queen_1shot_handler( var_0 )
{
    if ( !isdefined( level._snd.drone_swarm_queen ) )
    {
        var_1 = var_0 + 1;
        thread attack_drone_queen_flybys_audio( var_1 );
    }
    else
    {
        var_1 = level._snd.drone_swarm_queen + 1;

        if ( randomint( 100 ) > 75 )
            thread attack_drone_queen_flybys_audio( var_1 );
    }

    level._snd.drone_swarm_queen = var_1;
}

attack_drone_queen_flybys_audio( var_0 )
{
    var_1 = "Q-" + var_0 + ":  ";
    var_2 = "drone_swarm_flyby";
    var_3 = [];
    var_3[0] = 500;
    var_3[1] = 1500;
    var_4 = [];
    var_4[0] = 20;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, undefined, var_3, var_4, 1, undefined, undefined, 3, 2 );
}
