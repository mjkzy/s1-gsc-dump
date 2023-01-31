// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setupalleysvo();
    thread startalleysdialoguethreads();
}

setupalleysvo()
{
    level.dialogdangerzone = 0;
}

startalleysdialoguethreads()
{
    thread alleysintrotransitiondialogue();
    thread alleysgatebash();
    thread alleysstreettransitiondialogue();
    thread alleyskvaintrodialogue();
    thread alleysbegincombatdialog();
    thread alleysenemyrpg();
    thread alleysmidpointreminder();
    thread alleyscombatenterbuilding();
    thread alleysilanaleadstheway();
    thread alleysvisitorcentergate();
    thread alleyssniperpip();
    thread alleysenemyspawns();
}

alleysintrotransitiondialogue()
{
    common_scripts\utility::flag_wait( "FlagSafehouseExitGateOpen" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysTransitionIntro" );
}

alleysgatebash()
{
    common_scripts\utility::flag_wait( "FlagKickSafehouseExitGate" );
    wait 2;
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysThroughGate" );
}

alleysstreettransitiondialogue()
{
    common_scripts\utility::flag_wait( "FlagTriggerAlleysTransitionStreet" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysTransitionStreet" );
    soundscripts\_snd::snd_message( "start_alleys_combat_music" );
}

alleyskvaintrodialogue()
{
    common_scripts\utility::flag_wait( "FlagTrigTrans2AlleyCivBattle" );
    level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysBeginCombat" );
    level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
}

alleysbegincombatdialog()
{
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineShowySpawns" );
    level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysEnemyNote" );
    level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
}

alleysenemyrpg()
{
    common_scripts\utility::flag_wait( "FlagTriggerAlleysEnemyRPGs" );
    wait 1;
    level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysEnemyRocket" );
    level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
}

alleysmidpointreminder()
{
    common_scripts\utility::flag_wait( "FlagTrigAlleysBackLineSpawns" );
    level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysEnemyReminderAgain" );
    level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
}

alleysenemyspawns()
{
    level endon( "AlleysAllEnemiesDead" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "FlagAlleysEnemySpawnsVO" );

        if ( common_scripts\utility::cointoss() )
        {
            level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
            maps\_hms_utility::playdialog( level.dialogtable, "AlleysEnemySpawn", undefined, undefined, undefined, 1 );
            level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
        }

        wait(randomfloatrange( 5.0, 15.0 ));
        common_scripts\utility::flag_clear( "FlagAlleysEnemySpawnsVO" );
    }
}

alleysenemyretreat()
{
    if ( level.dialogdangerzone == 0 )
    {
        if ( maps\_hms_utility::cointossweighted( 25 ) )
        {
            level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
            maps\_hms_utility::playdialog( level.dialogtable, "AlleysEnemyRetreat", undefined, undefined, undefined, 1 );
            level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
        }
    }
}

alleysdialogtimer()
{
    level.dialogdangerzone = 1;
    wait 10;
    level.dialogdangerzone = 0;
}

alleyscombatenterbuilding()
{
    var_0 = getentarray( "AlleysFrontLineUniqueTrig", "targetname" );
    var_1 = getentarray( "AlleysBackLineUniqueTrig", "targetname" );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_4 in var_2 )
    {
        var_4 waittill( "trigger", var_5 );
        level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
        thread maps\_hms_utility::playdialog( level.dialogtable, "AlleysEnemyEnterBuilding", undefined, undefined, undefined, 1 );
        level.allies["Ilona"] maps\_utility::set_battlechatter( 1 );
    }
}

alleysilanaleadstheway()
{
    common_scripts\utility::flag_wait( "AlleysVisitorGateIsOpen" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysEnemyIlonaLeads", undefined, undefined, undefined, 1 );
}

alleysvisitorcentergate()
{
    level waittill( "AlleysAllEnemiesDead" );
    level.allies["Ilona"] maps\_hms_utility::waittillbcsdone( "Ilona" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysGateRipIntro", undefined, undefined, undefined, 1 );
    thread alleysvisitorcentergatereminder();
}

alleysvisitorcentergatereminder()
{
    level endon( "NotifyAlleysGateRipStarted" );
    wait 20;

    while ( !common_scripts\utility::flag( "AlleysGateRipStarted" ) )
    {
        wait(randomfloatrange( 10, 15 ));
        maps\_hms_utility::playdialog( level.dialogtable, "AlleysPickup", undefined, undefined, undefined, 1 );
    }
}

alleyssniperpip()
{
    common_scripts\utility::flag_wait( "AlleysVisitorGateIsOpen" );
    level.player _meth_8304( 0 );
    level.player _meth_848D( 0 );
    wait 2;
    soundscripts\_snd::snd_message( "alleys_music_end" );
    maps\_hms_utility::playdialog( level.dialogtable, "VideoLog" );
    level.player _meth_8304( 1 );
    level.player _meth_848D( 1 );
    common_scripts\utility::flag_set( "FlagAlleysPipComplete" );
}
