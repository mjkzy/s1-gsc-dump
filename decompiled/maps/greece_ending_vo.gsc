// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    thread endingambushdialogue();
    thread endingfightdialogue();
    thread endinghadesdialogue();
}

endingambushdialogue()
{
    level endon( "AmbushTimerExpire" );
    common_scripts\utility::flag_wait( "FlagEndingAmbushStart" );
    wait 1;
    thread maps\_hms_utility::playdialog( level.dialogtable, "AlleysAmbushSee" );
    wait 1;
    thread maps\greece_ending::monitorsetupambushtimer();
    common_scripts\utility::flag_set( "FlagEndingMarkObjSetAmbush" );
    thread endingilanasetupambushdialogue();
    thread endingplayertoofardialogue();
    thread maps\greece_ending::monitorplaceambushinteract();
    common_scripts\utility::flag_wait_any( "FlagTriggerEndingJumpDown", "FlagEndingIlanaWaitingAtAmbushPoint" );
    wait 1;
    thread maps\_hms_utility::playdialog( level.dialogtable, "AlleysAmbushInbound" );
    wait 1;
    thread endingsetupambushreminderdialogue();
    common_scripts\utility::flag_wait( "FlagEndingSetAmbushInteractBegin" );
    common_scripts\utility::flag_wait( "FlagEndingSetAmbushInteractGetToCover" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "AmbushWait" );
    common_scripts\utility::flag_wait( "FlagEndingSetAmbushInteractNow" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "AmbushNow" );
    common_scripts\utility::flag_wait( "FlagEndingSetAmbushInteractComplete" );
    wait 1;
    common_scripts\utility::flag_set( "FlagEndingFightStart" );
    thread maps\greece_ending::endingfightstart();
}

endingplayertoofardialogue()
{
    level endon( "AmbushTimerExpire" );
    level endon( "AmbushTimerFreeze" );
    level endon( "AmbushLeaveMission" );
    common_scripts\utility::flag_wait( "FlagEndingTooFarWarn" );
    maps\_hms_utility::printlnscreenandconsole( "WARN - Player is leaving mission area..." );
    common_scripts\utility::flag_wait( "FlagTriggerEndingTooFarFail" );
    common_scripts\utility::flag_set( "FlagEndingUnMarkObjSetAmbush" );
    thread maps\greece_ending::failsetupambushleavemission();
    level notify( "AmbushLeaveMission" );
}

endingilanasetupambushdialogue()
{
    common_scripts\utility::flag_wait( "FlagEndingIlanaShootIntoAir" );

    if ( !common_scripts\utility::flag( "FlagTriggerEndingJumpDown" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "AlleysAmbushClear" );
        wait 1;
        common_scripts\utility::flag_set( "FlagEndingIlanaWaitingAtAmbushPoint" );
        thread endingjumpdownreminderdialogue();
    }
}

endingjumpdownreminderdialogue()
{
    level endon( "AmbushTimerExpire" );
    level endon( "AmbushTimerFreeze" );
    level endon( "AmbushLeaveMission" );
    wait 10;

    while ( !common_scripts\utility::flag( "FlagTriggerEndingJumpDown" ) && !common_scripts\utility::flag( "FlagEndingIlanaWaitingAtAmbushPoint" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "AmbushRemind", undefined, undefined, undefined, 1 );
        wait 10;
    }
}

endingsetupambushreminderdialogue()
{
    level endon( "AmbushTimerExpire" );
    level endon( "AmbushTimerFreeze" );
    level endon( "AmbushLeaveMission" );
    wait 10;

    while ( !common_scripts\utility::flag( "FlagEndingSetAmbushInteractBegin" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "AmbushChargeRem", undefined, undefined, undefined, 1 );
        wait 10;
    }
}

endingfightdialogue()
{
    common_scripts\utility::flag_wait( "FlagEndingFightStart" );
    wait 1;
    soundscripts\_snd::snd_message( "start_finale_fight_music" );
    maps\_hms_utility::playdialog( level.dialogtable, "AmbushGideon" );
    wait 1;
    common_scripts\utility::flag_wait( "FlagEndingTruckExplode" );
    wait 1;
    level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
    maps\_hms_utility::playdialog( level.dialogtable, "AmbushForward" );
    level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
    thread endingfightprogressdialogue();
    common_scripts\utility::flag_wait_all( "FlagEndingEnemiesAllDead", "FlagEndingSpecialEnemiesDead" );
    level notify( "EndingEnemiesAllDead" );
    wait 1;
    soundscripts\_snd::snd_message( "stop_finale_fight_music" );
    wait 1;
    maps\_hms_utility::playdialog( level.dialogtable, "AmbushClearer" );
    wait 1;
    common_scripts\utility::flag_set( "FlagEndingHadesStart" );
}

endingfightprogressdialogue()
{
    level endon( "EndingEnemiesAllDead" );
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight2" );
    wait 1;
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight3" );
    thread endingfightkvadialogue();
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight4" );
    wait 1;
    thread maps\_hms_utility::playdialog( level.dialogtable, "AmbushEyes" );
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight5" );
    thread endingfightkvadialogue();
    common_scripts\utility::flag_wait( "FlagEndingPlayerAdvanceFight6" );
    wait 1;
    thread maps\_hms_utility::playdialog( level.dialogtable, "AmbushClear" );
}

endinghadesdialogue()
{
    common_scripts\utility::flag_wait( "FlagEndingHadesStart" );
    common_scripts\utility::flag_set( "FlagEndingMarkObjHadesVehicle" );
    wait 1;
    thread maps\_hms_utility::playdialog( level.dialogtable, "AmbushHonor" );
    wait 1;
    thread endinghadesvehiclereminderdialogue();
    thread maps\greece_ending::monitorhadesvehicleinteract();
    common_scripts\utility::flag_wait( "FlagEndingHadesVehicleInteractBegin" );
    wait 5;
    thread maps\_hms_utility::playdialog( level.dialogtable, "AmbushShit" );
    wait 1;
    level notify( "EndingIlanaShootTruck" );
}

endinghadesvehiclereminderdialogue()
{
    wait 10;

    while ( !common_scripts\utility::flag( "FlagEndingHadesVehicleInteractBegin" ) )
    {
        thread maps\_hms_utility::playdialog( level.dialogtable, "AmbushDoor", undefined, undefined, undefined, 1 );
        wait 10;
    }
}

endingfailtimerexpiredialogue()
{
    maps\_utility::radio_dialogue_stop();
    waitframe();
    maps\_hms_utility::playdialog( level.dialogtable, "AmbushFail" );
}

endingfailleavemissiondialogue()
{
    maps\_utility::radio_dialogue_stop();
    waitframe();
    maps\_hms_utility::playdialog( level.dialogtable, "AmbushPlayerLeftFail" );
}

endingfightkvadialogue()
{
    var_0 = endinggetenemyspeaker();

    if ( isdefined( var_0 ) )
    {
        var_0 endon( "death" );
        var_0.animname = "KVA_Soldier";
        var_0.script_parameters = "KVA_Soldier";
        maps\_hms_utility::playdialog( level.dialogtable, "AmbushKVAprotectHades", undefined, undefined, undefined, 1, 1 );
        var_0.script_parameters = undefined;
    }
}

endinggetenemyspeaker()
{
    var_0 = maps\_utility::get_living_ai_array( "EndingCineKVA_AI", "targetname" );
    var_1 = getaiarray( "axis" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) )
        {
            if ( isdefined( var_3.script_parameters ) && var_3.script_parameters == "KVA_Soldier" )
                var_3.script_parameters = undefined;

            if ( isdefined( var_3.iscrawling ) )
                var_0 = common_scripts\utility::array_add( var_0, var_3 );

            if ( var_3.classname == "actor_enemy_kva_shotgun" || var_3.classname == "actor_enemy_kva_civ_rpg" || var_3.classname == "actor_enemy_kva_civ_lmg" )
                var_0 = common_scripts\utility::array_add( var_0, var_3 );
        }
    }

    var_5 = maps\_utility::get_closest_ai_exclude( level.player.origin, "axis", var_0 );
    return var_5;
}
