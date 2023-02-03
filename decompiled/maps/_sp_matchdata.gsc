// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    setspmatchdatadef( "sp/sp_matchdata.def" );
    setspmatchdata( "level_name", level.script );
    setspmatchdata( "timestamp_start", level.player getsystemtimesp() );
    setspmatchdata( "xuid", level.player getxuid() );
    setspmatchdata( "dwid", level.player getdwid() );
    level.player setplayerinfospmatchdata();
    setspmatchdata( "challenges", "upgrade_challenge_stage_0", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeStage_0" ) ) );
    setspmatchdata( "challenges", "upgrade_challenge_progress_0", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeProgress_0" ) ) );
    setspmatchdata( "challenges", "upgrade_challenge_stage_1", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeStage_1" ) ) );
    setspmatchdata( "challenges", "upgrade_challenge_progress_1", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeProgress_1" ) ) );
    setspmatchdata( "challenges", "upgrade_challenge_stage_2", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeStage_2" ) ) );
    setspmatchdata( "challenges", "upgrade_challenge_progress_2", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeProgress_2" ) ) );
    setspmatchdata( "challenges", "upgrade_challenge_stage_3", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeStage_3" ) ) );
    setspmatchdata( "challenges", "upgrade_challenge_progress_3", int( level.player getlocalplayerprofiledata( "sp_upgradeChallengeProgress_3" ) ) );
    setspmatchdata( "career", "intel_collected", level.player getlocalplayerprofiledata( "cheatPoints" ) );
    setspmatchdata( "career", "kills_total", level.player getlocalplayerprofiledata( "sp_career_kills_total" ) );
    setspmatchdata( "career", "deaths_total", level.player getlocalplayerprofiledata( "sp_career_deaths_total" ) );
    level.player thread register_sp_perks();
    level.player thread register_boost_dodge();
}

increment_kill( var_0, var_1 )
{
    var_0 = getweaponbasename( var_0 );
    var_2 = self;
    var_3 = int( getspmatchdata( "career", "kills_total" ) ) + 1;
    setspmatchdata( "career", "kills_total", var_3 );
    set_weapon_data( var_0, "kills_total" );
    level.player setlocalplayerprofiledata( "sp_career_deaths_total", var_3 );
    var_4 = getspmatchdata( "checkpoints", 0, "kills_total" ) + 1;
    setspmatchdata( "checkpoints", 0, "kills_total", var_4 );

    if ( var_1 )
    {
        var_5 = getspmatchdata( "checkpoints", 0, "headshots_total" ) + 1;
        setspmatchdata( "checkpoints", 0, "headshots_total", var_5 );
        set_weapon_data( var_0, "headshots_total" );
    }
}

shots_fired( var_0 )
{
    set_weapon_data( getweaponbasename( var_0 ), "shots_total" );
    var_1 = getspmatchdata( "checkpoints", 0, "shots_total" ) + 1;
    setspmatchdata( "checkpoints", 0, "shots_total", var_1 );
}

increment_hit( var_0 )
{
    set_weapon_data( getweaponbasename( var_0 ), "shots_hit" );
    var_1 = getspmatchdata( "checkpoints", 0, "hits_total" ) + 1;
    setspmatchdata( "checkpoints", 0, "hits_total", var_1 );
}

register_death( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        var_0 = getweaponbasename( var_0 );

        if ( !cause_is_explosive( var_1 ) )
            set_weapon_data( var_0, "deaths_total" );
    }

    var_2 = getspmatchdata( "checkpoints", 0, "deaths_total" ) + 1;
    setspmatchdata( "checkpoints", 0, "deaths_total", var_2 );
    var_3 = level.player getlocalplayerprofiledata( "sp_career_deaths_total" ) + 1;
    level.player setlocalplayerprofiledata( "sp_career_deaths_total", var_3 );
    setspmatchdata( "career", "deaths_total", var_3 );
    var_4 = level.player getplayersetting( "gameskill" );
    var_5 = level.difficultytype[int( var_4 )];
    setspmatchdata( "final_difficulty", var_5 );
    var_6 = level.player getlocalplayerprofiledata( "sp_duration_total_seconds" ) + int( gettime() / 1000 );
    level.player setlocalplayerprofiledata( "sp_duration_total_seconds", int( var_6 ) );
}

register_boost_jump()
{
    var_0 = getspmatchdata( "checkpoints", 0, "boosted_total" ) + 1;
    setspmatchdata( "checkpoints", 0, "boosted_total", var_0 );
}

register_boost_slam()
{
    var_0 = getspmatchdata( "checkpoints", 0, "boosted_total" ) + 1;
    setspmatchdata( "checkpoints", 0, "boosted_total", var_0 );
}

register_boost_dodge()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "exo_dodge" );
        var_0 = getspmatchdata( "checkpoints", 0, "dodges_total" ) + 1;
        setspmatchdata( "checkpoints", 0, "boosted_total", var_0 );
    }
}

register_sp_perks()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "give_perk", var_0 );
        setspmatchdata( "perks", var_0, 1 );
    }
}

level_complete( var_0 )
{
    var_1 = level.player getsystemtimesp();
    setspmatchdata( "timestamp_end", var_1 );
    setspmatchdata( "career", "level_completion_timestamp", var_0, var_1 );
    setspmatchdata( "career", "levels_completed", var_0, 1 );
    var_2 = level.player getplayersetting( "gameskill" );
    var_3 = level.difficultytype[int( var_2 )];
    setspmatchdata( "final_difficulty", var_3 );
    var_4 = level.player getlocalplayerprofiledata( "sp_duration_total_seconds" ) + int( gettime() / 1000 );
    level.player setlocalplayerprofiledata( "sp_duration_total_seconds", var_4 );
    setspmatchdata( "career", "duration_total_seconds", var_4 );
    setspmatchdata( "career", "intel_collected", level.player getlocalplayerprofiledata( "cheatPoints" ) );
    sendspmatchdata();
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
        var_2 = int( getspmatchdata( "weapon_stats", var_0, var_1 ) ) + 1;
        setspmatchdata( "weapon_stats", var_0, var_1, var_2 );
    }
    else
    {
        var_2 = int( getspmatchdata( "weapon_stats", "unknown", var_1 ) ) + 1;
        setspmatchdata( "weapon_stats", "unknown", var_1, var_2 );
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
