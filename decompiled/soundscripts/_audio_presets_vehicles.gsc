// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

audio_presets_vehicles( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "so_paris_jeep":
            var_1["speed"] = [ [ "so_jeep_slow", [ "pitch", "so_jeep_slow_pitch" ], [ "volume", "so_jeep_slow_volume" ] ], [ "so_jeep_fast", [ "pitch", "so_jeep_medium_pitch" ], [ "volume", "so_jeep_medium_volume" ] ], [ "so_jeep_idle", [ "pitch", "so_jeep_idle_pitch" ], [ "volume", "so_jeep_idle_volume" ] ], [ "updaterate", 0.1 ], [ "smooth_up", 0.3 ], [ "smooth_down", 0.1 ], [ "range", 0.0, 25.0 ] ];
            break;
    }

    return var_1;
}

audio_presets_vehicle_maps( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "so_jeep_idle_pitch":
            var_1 = [ [ 0.0, 0.5 ], [ 0.02, 0.65 ], [ 0.1, 0.75 ], [ 0.2, 0.85 ], [ 1.0, 1.0 ] ];
            break;
        case "so_jeep_idle_volume":
            var_1 = [ [ 0.0, 1.0 ], [ 0.05, 0.9 ], [ 0.1, 0.85 ], [ 0.25, 0.45 ], [ 0.3, 0.15 ], [ 0.35, 0.0 ], [ 1.0, 0.0 ] ];
            break;
        case "so_jeep_slow_pitch":
            var_1 = [ [ 0.0, 0.38 ], [ 0.1, 0.4 ], [ 0.4, 0.45 ], [ 0.45, 0.5 ], [ 0.55, 0.55 ], [ 0.7, 0.6 ], [ 1.0, 0.8 ] ];
            break;
        case "so_jeep_slow_volume":
            var_1 = [ [ 0.0, 0.01 ], [ 0.1, 0.5 ], [ 0.35, 0.75 ], [ 0.55, 1.0 ], [ 0.7, 0.6 ], [ 0.8, 0.45 ], [ 1.0, 0.01 ] ];
            break;
        case "so_jeep_medium_pitch":
            var_1 = [ [ 0.0, 0.25 ], [ 0.5, 0.3 ], [ 0.65, 0.35 ], [ 0.75, 0.4 ], [ 0.85, 0.45 ], [ 1.0, 0.5 ] ];
            break;
        case "so_jeep_medium_volume":
            var_1 = [ [ 0.0, 0.0 ], [ 0.4, 0.2 ], [ 0.6, 0.6 ], [ 0.75, 0.9 ], [ 1.0, 1.0 ] ];
            break;
    }

    return var_1;
}
