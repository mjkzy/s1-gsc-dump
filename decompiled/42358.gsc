// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    _func_2A7( "sp/sp_matchdata.def" );
    _func_2A3( "level_name", level.script );
    _func_2A3( "timestamp_start", level.player _meth_8504() );
    _func_2A3( "xuid", level.player _meth_8297() );
    _func_2A3( "dwid", level.player _meth_8528() );
    level.player _meth_8529();
    _func_2A3( "challenges", "upgrade_challenge_stage_0", int( level.player _meth_820E( "sp_upgradeChallengeStage_0" ) ) );
    _func_2A3( "challenges", "upgrade_challenge_progress_0", int( level.player _meth_820E( "sp_upgradeChallengeProgress_0" ) ) );
    _func_2A3( "challenges", "upgrade_challenge_stage_1", int( level.player _meth_820E( "sp_upgradeChallengeStage_1" ) ) );
    _func_2A3( "challenges", "upgrade_challenge_progress_1", int( level.player _meth_820E( "sp_upgradeChallengeProgress_1" ) ) );
    _func_2A3( "challenges", "upgrade_challenge_stage_2", int( level.player _meth_820E( "sp_upgradeChallengeStage_2" ) ) );
    _func_2A3( "challenges", "upgrade_challenge_progress_2", int( level.player _meth_820E( "sp_upgradeChallengeProgress_2" ) ) );
    _func_2A3( "challenges", "upgrade_challenge_stage_3", int( level.player _meth_820E( "sp_upgradeChallengeStage_3" ) ) );
    _func_2A3( "challenges", "upgrade_challenge_progress_3", int( level.player _meth_820E( "sp_upgradeChallengeProgress_3" ) ) );
    _func_2A3( "career", "intel_collected", level.player _meth_820E( "cheatPoints" ) );
    _func_2A3( "career", "kills_total", level.player _meth_820E( "sp_career_kills_total" ) );
    _func_2A3( "career", "deaths_total", level.player _meth_820E( "sp_career_deaths_total" ) );
    level.player thread register_sp_perks();
    level.player thread register_boost_dodge();
}

increment_kill( var_0, var_1 )
{
    var_0 = getweaponbasename( var_0 );
    var_2 = self;
    var_3 = int( _func_2A4( "career", "kills_total" ) ) + 1;
    _func_2A3( "career", "kills_total", var_3 );
    set_weapon_data( var_0, "kills_total" );
    level.player _meth_820F( "sp_career_deaths_total", var_3 );
    var_4 = _func_2A4( "checkpoints", 0, "kills_total" ) + 1;
    _func_2A3( "checkpoints", 0, "kills_total", var_4 );

    if ( var_1 )
    {
        var_5 = _func_2A4( "checkpoints", 0, "headshots_total" ) + 1;
        _func_2A3( "checkpoints", 0, "headshots_total", var_5 );
        set_weapon_data( var_0, "headshots_total" );
    }
}

shots_fired( var_0 )
{
    set_weapon_data( getweaponbasename( var_0 ), "shots_total" );
    var_1 = _func_2A4( "checkpoints", 0, "shots_total" ) + 1;
    _func_2A3( "checkpoints", 0, "shots_total", var_1 );
}

increment_hit( var_0 )
{
    set_weapon_data( getweaponbasename( var_0 ), "shots_hit" );
    var_1 = _func_2A4( "checkpoints", 0, "hits_total" ) + 1;
    _func_2A3( "checkpoints", 0, "hits_total", var_1 );
}

register_death( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        var_0 = getweaponbasename( var_0 );

        if ( !cause_is_explosive( var_1 ) )
            set_weapon_data( var_0, "deaths_total" );
    }

    var_2 = _func_2A4( "checkpoints", 0, "deaths_total" ) + 1;
    _func_2A3( "checkpoints", 0, "deaths_total", var_2 );
    var_3 = level.player _meth_820E( "sp_career_deaths_total" ) + 1;
    level.player _meth_820F( "sp_career_deaths_total", var_3 );
    _func_2A3( "career", "deaths_total", var_3 );
    var_4 = level.player _meth_820D( "gameskill" );
    var_5 = level.difficultytype[int( var_4 )];
    _func_2A3( "final_difficulty", var_5 );
    var_6 = level.player _meth_820E( "sp_duration_total_seconds" ) + int( gettime() / 1000 );
    level.player _meth_820F( "sp_duration_total_seconds", int( var_6 ) );
}

register_boost_jump()
{
    var_0 = _func_2A4( "checkpoints", 0, "boosted_total" ) + 1;
    _func_2A3( "checkpoints", 0, "boosted_total", var_0 );
}

register_boost_slam()
{
    var_0 = _func_2A4( "checkpoints", 0, "boosted_total" ) + 1;
    _func_2A3( "checkpoints", 0, "boosted_total", var_0 );
}

register_boost_dodge()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "exo_dodge" );
        var_0 = _func_2A4( "checkpoints", 0, "dodges_total" ) + 1;
        _func_2A3( "checkpoints", 0, "boosted_total", var_0 );
    }
}

register_sp_perks()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "give_perk", var_0 );
        _func_2A3( "perks", var_0, 1 );
    }
}

level_complete( var_0 )
{
    var_1 = level.player _meth_8504();
    _func_2A3( "timestamp_end", var_1 );
    _func_2A3( "career", "level_completion_timestamp", var_0, var_1 );
    _func_2A3( "career", "levels_completed", var_0, 1 );
    var_2 = level.player _meth_820D( "gameskill" );
    var_3 = level.difficultytype[int( var_2 )];
    _func_2A3( "final_difficulty", var_3 );
    var_4 = level.player _meth_820E( "sp_duration_total_seconds" ) + int( gettime() / 1000 );
    level.player _meth_820F( "sp_duration_total_seconds", var_4 );
    _func_2A3( "career", "duration_total_seconds", var_4 );
    _func_2A3( "career", "intel_collected", level.player _meth_820E( "cheatPoints" ) );
    _func_2A5();
}

does_weapon_exist( var_0 )
{
    var_1 = [ "ammo", "iw5_bal27_sp", "iw5_ak12_sp", "iw5_hbra3_sp", "iw5_himar_sp", "iw5_arx160_sp", "iw5_m182spr_sp", "iw5_sn6_sp", "iw5_hmr9_sp", "iw5_mp11_sp", "iw5_sac3_sp", "iw5_asm1_sp", "iw5_kf5_sp", "iw5_mors_sp", "iw5_gm6_sp", "iw5_thor_sp", "iw5_uts19_sp", "iw5_maul_sp", "iw5_rhino_sp", "iw5_lsat_sp", "iw5_asaw_sp", "iw5_em1_sp", "iw5_epm3_sp", "iw5_titan45_sp", "iw5_pbw_sp", "iw5_vbr_sp", "iw5_rw1_sp", "iw5_microdronelauncher_sp", "iw5_stingerm7_sp", "iw5_mahem_sp", "iw5_maaws_sp", "unknown", "" ];
    return common_scripts\utility::array_contains( var_1, var_0 );
}

set_weapon_data( var_0, var_1 )
{
    if ( isdefined( var_0 ) && does_weapon_exist( var_0 ) )
    {
        var_2 = int( _func_2A4( "weapon_stats", var_0, var_1 ) ) + 1;
        _func_2A3( "weapon_stats", var_0, var_1, var_2 );
    }
    else
    {
        var_2 = int( _func_2A4( "weapon_stats", "unknown", var_1 ) ) + 1;
        _func_2A3( "weapon_stats", "unknown", var_1, var_2 );
    }
}

cause_is_explosive( var_0 )
{
    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "splash":
        case "mod_explosive":
        case "mod_projectile_splash":
        case "mod_projectile":
        case "mod_grenade_splash":
        case "mod_grenade":
            return 1;
        default:
            return 0;
    }

    return 0;
}
