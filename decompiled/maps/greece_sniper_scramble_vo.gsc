// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread sniperscrambleintrodialogue();
    thread sniperscramblehoteldialogue();
    thread sniperscrambledronesdialogue();
    thread sniperscramblefinaledialogue();
}

sniperscrambleintrodialogue()
{
    common_scripts\utility::flag_wait_all( "FlagTriggerSniperScrambleStart", "FlagAlleysPipComplete", "FlagAlleysIlanaReadyToExit" );
    wait 1;
    common_scripts\utility::flag_set( "FlagScrambleIlanaBeginOpenIntroDoor" );
    level waittill( "ScrambleHeKnowsVO" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleWindmill" );
    wait 1;
    common_scripts\utility::flag_set( "FlagScrambleObjSniperPos" );
    level waittill( "ScramblePoppinSmokeVO" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleSmoke" );
    soundscripts\_snd::snd_message( "start_sniper_scramble_music" );
    level waittill( "ScrambleSmokeWontLastVO" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleSmokeWontLast" );
    common_scripts\utility::flag_wait( "FlagScrambleIlanaEndOpenIntroDoor" );
    thread scrambleintrothroughdoorreminderdialogue();
    common_scripts\utility::flag_set( "FlagScrambleObjGapJumpPos" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearFirstJump" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleJump" );
    wait 1;
    thread scrambleintrogapjumpreminderdialogue();
}

scrambleintrothroughdoorreminderdialogue()
{
    wait 20;

    while ( !common_scripts\utility::flag( "FlagTriggerScramblePlayerExitAlleys" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleReminderMove", undefined, undefined, undefined, 1 );
        wait 15;
    }
}

scrambleintrogapjumpreminderdialogue()
{
    wait 20;

    while ( !common_scripts\utility::flag( "FlagScrambleGapJumpStarted" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleReminderJump", undefined, undefined, undefined, 1 );
        wait 15;
    }
}

sniperscramblehoteldialogue()
{
    common_scripts\utility::flag_wait_either( "FlagScrambleStartHotel", "FlagScrambleIlanaGapJumpCompleted" );
    common_scripts\utility::flag_wait( "FlagScrambleBeginHothall" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleWindows" );
    wait 1;
    common_scripts\utility::flag_wait_all( "FlagTriggerScramblePlayerNearSecondJump", "FlagScrambleEndHothall" );

    if ( !common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) )
    {
        thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleOpenGround" );
        wait 1;
        thread scramblehotelsuppressorrunreminderdialogue();
    }

    common_scripts\utility::flag_set( "FlagScrambleObjSuppressSniper" );
    common_scripts\utility::flag_set( "FlagScrambleCheckPlayerDecision" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) )
        {
            scramblehotelilanafirstdialogue();
            break;
        }
        else if ( common_scripts\utility::flag( "FlagScrambleHotelJumpStarted" ) )
        {
            scramblehotelplayerfirstdialogue();
            break;
        }

        waitframe();
    }

    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleStreetDirect" );
    wait 1;
    thread scramblehoteljumpdownreminderdialogue();
}

scramblehotelilanafirstdialogue()
{
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScramblePlayerSuppress" );
    wait 1;
    thread scramblehotelilanahitdialogue();
    common_scripts\utility::flag_wait( "FlagScrambleHotelIlanaReachedGoal" );
    level notify( "ScrambleIlanaReachedGoal" );

    if ( !common_scripts\utility::flag( "FlagScrambleHotelJumpStarted" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleIlanaClear" );
        wait 1;
        thread maps\_hms_utility::playdialog( level.dialogtable, "ScramblePlayerMove" );
        wait 1;
        common_scripts\utility::flag_set( "FlagScrambleObjPoolCafePos" );
        thread scramblehotelplayerrunreminderdialogue();
        common_scripts\utility::flag_wait( "FlagScrambleHotelJumpCompleted" );
        maps\_hms_utility::playdialog( level.dialogtable, "ScramblePlayerGo" );
        wait 1;
    }

    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );
}

scramblehotelplayerfirstdialogue()
{
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScramblePlayerSprint" );
    wait 1;
    common_scripts\utility::flag_set( "FlagScrambleObjPoolCafePos" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );
    level.sniper_scramble_data.suppression_time = 0;
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScramblePlayerCover" );
    wait 1;
    thread scramblehotelsuppresssniperreminderdialogue();
    common_scripts\utility::flag_wait( "FlagScrambleSniperSuppressed" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScramblePlayerCover2" );
    wait 1;
    thread scramblehotelilanahitdialogue();
    common_scripts\utility::flag_wait( "FlagScrambleHotelIlanaReachedGoal" );
    level notify( "ScrambleIlanaReachedGoal" );
    maps\_hms_utility::playdialog( level.dialogtable, "ScrambleIlanaClear2" );
    wait 1;
}

scramblehotelleapfrogcompletedialogue()
{
    if ( common_scripts\utility::flag( "FlagScrambleHotelBadLeapfrog" ) )
    {
        thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleIlanaBitch" );
        wait 1;
    }
    else
    {
        thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleIlanaPraise" );
        wait 1;
    }
}

scramblehotelsuppressorrunreminderdialogue()
{
    wait 10;
    var_0 = 0;

    while ( !common_scripts\utility::flag( "FlagScrambleHotelPlayerHasDecided" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleReminderDecide", undefined, undefined, undefined, 1 );

        if ( var_0 == 0 )
        {
            var_0 = 1;
            thread maps\_utility::display_hint( "scramble_suppress_sniper_2" );
        }

        wait 15;
    }
}

scramblehotelsuppresssniperreminderdialogue()
{
    level endon( "ScrambleSniperSuppressed" );
    wait 10;
    var_0 = 0;

    while ( !common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleReminderSuppress", undefined, undefined, undefined, 1 );

        if ( var_0 == 0 )
        {
            var_0 = 1;
            thread maps\_utility::display_hint( "scramble_suppress_sniper_1" );
        }

        wait 15;
    }
}

scramblehotelplayerrunreminderdialogue()
{
    wait 10;
    var_0 = 0;

    while ( !common_scripts\utility::flag( "FlagScrambleHotelJumpStarted" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleReminderMove", undefined, undefined, undefined, 1 );

        if ( var_0 == 0 )
        {
            var_0 = 1;
            thread maps\_utility::display_hint( "scramble_advance_to_ilona" );
        }

        wait 15;
    }
}

scramblehotelilanahitdialogue()
{
    level endon( "ScrambleIlanaReachedGoal" );
    level.allies["Ilona"] waittill( "damage" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleIlanaHit" );
    common_scripts\utility::flag_set( "FlagScrambleHotelBadLeapfrog" );
}

scramblefailplayerleftilanadialogue()
{
    maps\_utility::radio_dialogue_stop();
    waitframe();
    maps\_hms_utility::playdialog( level.dialogtable, "ScrambleTooFar" );
}

scramblehoteljumpdownreminderdialogue()
{
    wait 10;

    while ( !common_scripts\utility::flag( "FlagScrambleCafeJumpStarted" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleReminderJump", undefined, undefined, undefined, 1 );
        wait 15;
    }
}

sniperscrambledronesdialogue()
{
    common_scripts\utility::flag_wait( "FlagScrambleStartDrones" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleMoreDrones" );
    wait 1;
    level notify( "audio_kva_drones_inbound" );
    thread scrambledronesfightreminderdialogue();
    common_scripts\utility::flag_wait( "FlagScrambleDronesAdead" );
    wait 1;
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleDronesDead" );
    wait 1;
    level notify( "audio_kva_drones_dead" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerAlmostNearRestaurant" );
    thread maps\greece_sniper_scramble::scramblecivrestaurant();
    wait 1.0;
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleRestaurant" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerInRestaurant" );
    thread scrambledronesplayerrestaurantreminderdialogue();
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerMidRestaurant" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleLobby" );
    wait 1;
    common_scripts\utility::flag_set( "FlagScrambleStartFinale" );
}

scrambledronesfightreminderdialogue()
{
    wait 30;

    while ( !common_scripts\utility::flag( "FlagScrambleDronesAdead" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "RooftopsDroneReminder", undefined, undefined, undefined, 1 );
        wait 20;
    }
}

scrambledronesplayerrestaurantreminderdialogue()
{
    wait 10;

    while ( !common_scripts\utility::flag( "FlagTriggerScramblePlayerMidRestaurant" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleReminderLag", undefined, undefined, undefined, 1 );
        wait 15;
    }
}

sniperscramblefinaledialogue()
{
    common_scripts\utility::flag_wait( "FlagScrambleStartFinale" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerAlmostNearWoundedSoldier" );
    common_scripts\utility::flag_set( "FlagScrambleObjWoundedSoldierPos" );
    maps\_hms_utility::playdialog( level.dialogtable, "ScrambleSanchez" );
    common_scripts\utility::flag_set( "FlagScrambleReadyForWoundedSoldier" );
    level waittill( "ScrambleWoundedSoldierVO" );
    maps\_hms_utility::playdialog( level.dialogtable, "ScrambleRPG" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerOnStreet" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleDroneReturn" );
    wait 1;
    common_scripts\utility::flag_set( "FlagScrambleObjRPGPos" );
    common_scripts\utility::flag_wait( "FlagScrambleGetRPG" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleDroneDeadJohnson" );
    thread scramblefinaleplayeruserpgreminderdialogue();
    thread scramblefinalealldronesdeaddialogue();
    thread scramblefinalesuppresssniperdialogue();
    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
    level waittill( "ScrambleSniperWinVO" );
    thread maps\_hms_utility::playdialog( level.dialogtable, "ScrambleSniperWin" );
    soundscripts\_snd::snd_message( "start_finale_transition_music" );
    common_scripts\utility::flag_wait( "FlagScrambleIlanaStartMoveTruck" );
    wait 1;
    thread maps\_hms_utility::playdialog( level.dialogtable, "AlleysTruck" );
    wait 1;
    thread scramblefinaleplayermovetruckreminderdialogue();
    thread maps\greece_sniper_scramble::monitormovetruckinteract();
    common_scripts\utility::flag_set( "FlagScrambleObjMoveTruckPos" );
    common_scripts\utility::flag_wait( "FlagScramblePlayerEndMoveTruck" );
    maps\_hms_utility::playdialog( level.dialogtable, "AlleysTruckSuccess" );
    wait 1;
    common_scripts\utility::flag_set( "FlagEndingStart" );
}

scramblefinalealldronesdeaddialogue()
{
    level endon( "ScrambleSniperKilled" );
    common_scripts\utility::flag_wait( "FlagScrambleDronesBdead" );
    wait 1;

    if ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        if ( level.player _meth_8314( "iw5_stingerm7greece_sp" ) )
        {
            common_scripts\utility::flag_set( "FlagDelayRPGReminderDialogue" );
            maps\_hms_utility::playdialog( level.dialogtable, "ScrambleRemindwithRPG" );
            wait 10;
            common_scripts\utility::flag_clear( "FlagDelayRPGReminderDialogue" );
        }
        else
        {
            common_scripts\utility::flag_set( "FlagDelayRPGReminderDialogue" );
            maps\_hms_utility::playdialog( level.dialogtable, "ScrambleRemindGetRPG" );
            wait 10;
            common_scripts\utility::flag_clear( "FlagDelayRPGReminderDialogue" );
        }
    }
}

scramblefinaleplayeruserpgreminderdialogue()
{
    level endon( "ScrambleFinalePlayerHasRPG" );
    wait 30;

    while ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        if ( common_scripts\utility::flag( "FlagDelayRPGReminderDialogue" ) )
        {
            wait 1.0;
            continue;
        }

        if ( level.player _meth_8314( "iw5_stingerm7greece_sp" ) )
        {
            level notify( "ScrambleFinalePlayerHasRPG" );
            maps\_hms_utility::playdialog( level.dialogtable, "ScrambleRemindGetSniper", undefined, undefined, undefined, 1 );
            wait 15;
            continue;
        }

        maps\_hms_utility::playdialog( level.dialogtable, "ScrambleRemindNoRPG", undefined, undefined, undefined, 1 );
        wait 20;
    }
}

scramblefinalesuppresssniperdialogue()
{
    level endon( "ScrambleFinalePlayerHasRPG" );
    level endon( "ScrambleSniperKilled" );
    wait 20;

    while ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        level.player waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( !isdefined( var_9 ) )
            continue;

        if ( var_9 == "hms_rail_sniper" && isdefined( level.sniperpos ) )
        {
            common_scripts\utility::flag_set( "FlagDelayRPGReminderDialogue" );
            maps\_hms_utility::playdialog( level.dialogtable, "SniperSupressionAlt", undefined, undefined, undefined, 1 );
            wait 10;
            common_scripts\utility::flag_clear( "FlagDelayRPGReminderDialogue" );
            wait 15;
        }

        wait 1.0;
    }
}

scramblefinaleplayermovetruckreminderdialogue()
{
    wait 20;

    while ( !common_scripts\utility::flag( "FlagScramblePlayerStartMoveTruck" ) )
    {
        maps\_hms_utility::playdialog( level.dialogtable, "AlleysTruckerRemind", undefined, undefined, undefined, 1 );
        wait 15;
    }
}
