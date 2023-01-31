// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    alleysprecache();
    alleysflaginit();
    alleysglobalvars();
    alleysglobalsetup();
    maps\greece_alleys_anim::main();
    maps\greece_alleys_vo::main();
    maps\_drone_civilian::init();
}

alleysprecache()
{
    precachemodel( "viewhands_atlas_military" );
    precachemodel( "vb_civilian_mitchell" );
    precachemodel( "viewbody_atlas_military" );
    precacheitem( "iw5_hmr9_sp" );
    precacheitem( "iw5_hmr9_sp_variablereddot" );
    precacheitem( "iw5_bal27_sp" );
    precacheitem( "iw5_bal27_sp_silencer01_variablereddot" );
    precacheitem( "iw5_sn6_sp" );
    precacheitem( "fraggrenade" );
    precacheitem( "flash_grenade" );
    precacheitem( "iw5_kf5_sp" );
    precacheitem( "iw5_kf5_sp_opticsthermal" );
    precacheitem( "iw5_maul_sp" );
    precacheitem( "iw5_maul_sp_opticsreddot" );
    precacheitem( "iw5_ak12_sp" );
    precacheitem( "iw5_ak12_sp_opticstargetenhancer" );
    precacheitem( "iw5_hbra3_sp" );
    precacheitem( "iw5_hbra3_sp_opticsacog2" );
    precacheitem( "iw5_mahemstraight_sp" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    precacheitem( "iw5_arx160_sp" );
    precacherumble( "silencer_fire" );
    precacheshellshock( "greece_drone_slowview" );
    precachestring( &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    precachestring( &"GREECE_OBJ_ENDING_HADESVEHICLE" );
    precachestring( &"GREECE_OBJ_INTERCEPT_HADES" );
    precachestring( &"GREECE_ALLEYS_GATERIP_PROMPT" );
    precachestring( &"GREECE_ALLEYS_GATERIP_PROMPT_KB" );
    precachemodel( "kva_heavy_head" );
    precachemodel( "kva_heavy_body" );
    precacheitem( "iw5_maul_sp" );
    maps\_hms_door_interact::precachedooranimations();
}

alleysflaginit()
{
    common_scripts\utility::flag_init( "FlagSetObjRooftops" );
    common_scripts\utility::flag_init( "FlagSafehouseGapJumpCompleted" );
    common_scripts\utility::flag_init( "FlagSafehouseExitGateOpen" );
    common_scripts\utility::flag_init( "FlagDeleteAlleyCivilians" );
    common_scripts\utility::flag_init( "FlagStartMantoss" );
    common_scripts\utility::flag_init( "FlagTrans2AlleysAllExecutionersDead" );
    common_scripts\utility::flag_init( "Trans2AlleysSquadADead" );
    common_scripts\utility::flag_init( "FlagAlleysDeleteAI" );
    common_scripts\utility::flag_init( "FlagAlleysCombatBeginEnemyRetreat" );
    common_scripts\utility::flag_init( "FlagAlleysFinalBldgClear" );
    common_scripts\utility::flag_init( "FlagSniperScrambleStart" );
    common_scripts\utility::flag_init( "FlagAlleysPipComplete" );
    common_scripts\utility::flag_init( "AlleysVisitorGateIsOpen" );
    common_scripts\utility::flag_init( "AlleysGateRipStarted" );
    common_scripts\utility::flag_init( "FlagAlleysIlanaReadyToExit" );
    common_scripts\utility::flag_init( "FlagAlleysEnemySpawnsVO" );
    common_scripts\utility::flag_init( "FlagAlleysIlanaMoveToExit" );
    common_scripts\utility::flag_init( "FlagAlleysAllEnemiesDead" );
}

alleysglobalvars()
{
    level.dialogtable = "sp/greece_dialog.csv";
}

alleysglobalsetup()
{
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    thread trans2alleysbegin();
    thread alleysbegin();
}

alleysstartpoints()
{
    maps\_utility::add_start( "start_alleys_transition", ::initalleystransition );
    maps\_utility::add_start( "start_alleys", ::initalleys );
    maps\_utility::add_start( "start_alleys_art", ::initalleysart );
    maps\_utility::add_start( "start_alleys_end", ::initalleysend );
    maps\greece_starts::add_greece_starts( "alley" );
}

initalleystransition()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartAlleysTransition", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartAlleysTransition", 1, 1, "IlanaAlleysTransition" );
    common_scripts\utility::flag_set( "FlagAlleysTransitionStart" );
    common_scripts\utility::flag_set( "init_alleys_transition_start_lighting" );
    thread maps\greece_safehouse::safehousetranstoalleygatesetup();
    soundscripts\_snd::snd_message( "start_alleys_transition_checkpoint" );
    common_scripts\utility::flag_set( "FlagKickSafehouseExitGate" );
}

initalleys()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartAlleys", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartAlleys", 1, 1, "IlanaAlleys" );
    thread ilanaalleybehavior();
    soundscripts\_snd::snd_message( "start_alleys_checkpoint" );
    common_scripts\utility::flag_set( "FlagAlleysStart" );
    common_scripts\utility::flag_set( "init_alleys_lighting" );
}

initalleysart()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartAlleysArt", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    soundscripts\_snd::snd_message( "start_alleys_checkpoint" );
    common_scripts\utility::flag_set( "FlagAlleysArtStart" );
    common_scripts\utility::flag_set( "init_alleys_lighting" );
}

initalleysend()
{
    var_0 = common_scripts\utility::getstructarray( "PlayerStartAlleysEnd", "targetname" );
    var_1 = common_scripts\utility::random( var_0 );
    maps\_utility::teleport_player( var_1 );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    maps\_hms_utility::spawnandinitnamedally( "Ilona", var_1.target, 1, 1, "IlanaAlleys" );
    thread ilanaalleybehavior();
    soundscripts\_snd::snd_message( "start_alleys_checkpoint" );
    common_scripts\utility::flag_set( "FlagAlleysEndStart" );
}

trans2alleysobjectivesetup()
{
    waittillframeend;
    thread objtransitiontoalleys();
    alleyssetcompletedobjflags();
}

alleysobjectivesetup()
{
    waittillframeend;
    alleyssetcompletedobjflags();
}

alleyssetcompletedobjflags()
{
    var_0 = level.start_point;

    if ( !common_scripts\utility::string_starts_with( var_0, "start_alleys" ) )
        return;

    if ( var_0 == "start_alleys_transition" )
        return;

    if ( var_0 == "start_alleys" )
    {
        common_scripts\utility::flag_set( "FlagAlleysTransitionStart" );
        common_scripts\utility::flag_set( "FlagTrans2AlleysAllExecutionersDead" );
        common_scripts\utility::flag_set( "ObjTriggerFlagTransitionToAlleys" );
        return;
    }

    if ( var_0 == "start_alleys_end" )
    {
        common_scripts\utility::flag_set( "FlagAlleysTransitionStart" );
        common_scripts\utility::flag_set( "ObjTriggerFlagTransitionToAlleys" );
        return;
    }
}

objtransitiontoalleys()
{
    common_scripts\utility::flag_wait( "FlagAlleysTransitionStart" );
    objective_add( maps\_utility::obj( "InterceptHades" ), "active", &"GREECE_OBJ_INTERCEPT_HADES" );
    objective_onentity( maps\_utility::obj( "InterceptHades" ), level.allies["Ilona"] );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    objective_current( maps\_utility::obj( "InterceptHades" ) );
    common_scripts\utility::flag_wait( "ObjTriggerFlagTransitionToAlleys" );
    var_0 = getent( "AlleysVisitorCenterGateObj", "targetname" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), "" );
    common_scripts\utility::flag_set( "FlagAlleysStart" );
    level waittill( "AlleysAllEnemiesDead" );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_ENDING_HADESVEHICLE" );
    common_scripts\utility::flag_wait( "AlleysGateRipStarted" );
    var_1 = getent( "ObjMarkerRooftopsStart", "targetname" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), "" );
    common_scripts\utility::flag_wait( "AlleysVisitorGateIsOpen" );
    objective_onentity( maps\_utility::obj( "InterceptHades" ), level.allies["Ilona"] );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    common_scripts\utility::flag_wait( "FlagTriggerSniperScrambleStart" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), " " );
}

trans2alleysbegin()
{
    common_scripts\utility::flag_wait( "FlagAlleysTransitionStart" );
    trans2alleysobjectivesetup();
    thread trans2alleyscivilians();
    thread trans2alleysilanagatebash();
    thread alleysallymovement();
    thread trans2alleyscombat();
}

alleysbegin()
{
    common_scripts\utility::flag_wait_any( "FlagAlleysStart", "FlagAlleysArtStart", "FlagAlleysEndStart" );
    alleysobjectivesetup();
    thread alleysspawnrpgenemies();
    thread alleyscombat();
    thread alleysvisitorcentergate();
    thread alleysvideolog();
    thread alleysvehiclemonitor();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
}

monitormantlevols()
{
    while ( !common_scripts\utility::flag( "FlagSniperScrambleStart" ) )
    {
        if ( level.player ismantling() )
        {
            glassradiusdamage( level.player.origin, 32, 1000, 100 );
            wait 1.0;
        }

        wait 0.05;
    }
}

alleysallymovement()
{
    common_scripts\utility::flag_wait( "FlagSafehouseExitGateOpen" );
    thread ilanaalleytransbehavior();
}

trans2alleysilanagatebash()
{
    var_0 = getent( "alley_gate_collision", "targetname" );
    var_1 = common_scripts\utility::getstruct( "gateOrg", "targetname" );
    var_2 = getent( "greece_alley_gate", "targetname" );
    var_2 maps\_utility::assign_animtree( "alley_gate" );
    var_2.animname = "alley_gate";
    var_3 = level.allies["Ilona"];
    var_3.animname = "Ilona";
    common_scripts\utility::flag_wait( "FlagKickSafehouseExitGate" );
    var_1 maps\_anim::anim_reach_solo( var_3, "safehouse_gate_bash" );
    var_1 thread maps\_anim::anim_single_solo_run( var_3, "safehouse_gate_bash" );
    level waittill( "GateAnimStart" );
    thread trans2alleysunblockplayer();
    var_1 thread maps\_anim::anim_single_solo( var_2, "safehouse_gate_bash" );
    var_0 _meth_82B1( -128, 0.1 );
    var_0 _meth_8058();
    common_scripts\utility::flag_set( "FlagSafehouseExitGateOpen" );
    maps\greece_safehouse_fx::safehousegatebashfx();
    soundscripts\_snd::snd_music_message( "start_safehouse_gate_bash" );
    soundscripts\_snd::snd_message( "start_trans_to_alleys_panic" );

    if ( level.currentgen )
        thread trans2alleysslowplayer();
}

trans2alleysunblockplayer()
{
    var_0 = getent( "alley_gate_collision_player", "targetname" );
    wait 1;

    if ( level.currentgen )
        wait 1;

    var_0 _meth_82B1( -128, 0.1 );
    var_0 _meth_8058();
}

trans2alleysslowplayer()
{
    level.player _meth_8304( 0 );
    level.player _meth_848D( 0 );
    common_scripts\utility::flag_wait( "FlagTrigTrans2AlleyIlanaAdvance" );
    level.player _meth_8304( 1 );
    level.player _meth_848D( 1 );
}

ilanaalleytransbehavior()
{
    var_0 = maps\_hms_utility::getnamedally( "Ilona" );
    var_0 endon( "ContinueToAlleys" );
    var_1 = getnode( "Trans2AlleysStartNode", "targetname" );
    var_2 = getnode( "AlleyTransCover1", "targetname" );
    var_0 maps\_utility::set_run_anim( "trans_alley_sprint_wpn_ilana", 0 );
    var_0 maps\_hms_ai_utility::gototogoal( var_2, "default" );
    var_0 maps\_utility::clear_run_anim();
    common_scripts\utility::flag_wait( "FlagTrigTrans2AlleyIlanaAdvance" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AlleyTransCover2" );

    if ( level.currentgen )
    {
        _func_08A( 3000 );
        var_3 = [ "AlleysCannotRetreat" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "FlagTrigAlleysFinalBldgInteriorLastRoom", var_3, 18, 0 );
    }

    common_scripts\utility::flag_wait( "FlagTrigTrans2AlleyCivBattle" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AlleyTransCover3" );
    thread ilanaalleybehavior();
}

ilanaalleybehavior()
{
    var_0 = level.start_point;

    if ( var_0 != "start_alleys_end" )
    {
        thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AlleyStartCover" );
        common_scripts\utility::flag_wait( "FlagTrans2AlleysCivCleanup" );
    }

    level.player thread maps\_hms_ai_utility::assistplayer();
    var_1 = maps\_hms_utility::getnamedally( "Ilona" );
    var_1 thread _initalliedaialleycombatbehavior();
    var_1 thread alleyscheckifplayerretreated();
    level waittill( "AlleysShotgunnersAllDead" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysIlanaMoveToCourtyard" );
    var_1 maps\_hms_ai_utility::playerleashdisable();
    waitframe();
    var_2 = getnode( "AlleysIlanaFinalBldgCourtyardNode", "targetname" );
    var_1 maps\_hms_ai_utility::gototogoal( var_2, "default", 1 );
    waitframe();
    common_scripts\utility::flag_set( "FlagAlleysCombatBeginEnemyRetreat" );

    while ( level.alleysremainingenemies.size > 0 )
    {
        level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
        wait 0.1;
    }

    common_scripts\utility::flag_set( "FlagAlleysAllEnemiesDead" );
    level notify( "AlleysAllEnemiesDead" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFinalBldgUpperRetreat" );
    var_1 maps\_utility::set_goal_radius( 64 );
    var_3 = getnode( "AlleysIlanaFinalBldgStairsNode", "targetname" );
    var_1 maps\_hms_ai_utility::gototogoal( var_3, "default", 1 );
    common_scripts\utility::flag_wait( "FlagAlleysIlanaMoveToExit" );
    var_4 = getnode( "AlleysIlanaFinalBldgNearExitNode", "targetname" );
    var_1 maps\_hms_ai_utility::gototogoal( var_4, "default", 1 );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFinalBldgInteriorNearExit" );
    common_scripts\utility::flag_set( "FlagAlleysIlanaReadyToExit" );
}

alleyscheckifplayerretreated()
{
    var_0 = getent( "TrigAlleysPlayerHasRetreated", "targetname" );
    var_1 = getnode( "AlleyTransCover1", "targetname" );
    thread maps\_hms_ai_utility::playerleashbehavior();
    var_2 = 1;

    while ( !common_scripts\utility::flag( "FlagAlleysAllEnemiesDead" ) )
    {
        if ( var_2 == 1 && level.player _meth_80A9( var_0 ) )
        {
            maps\_hms_ai_utility::playerleashdisable();
            waitframe();
            maps\_hms_ai_utility::gototogoal( var_1, "default", 1 );
            var_2 = 0;
        }
        else if ( var_2 == 0 )
        {
            thread maps\_hms_ai_utility::playerleashbehavior();
            var_2 = 1;
        }

        wait 5;
    }

    maps\_hms_ai_utility::playerleashdisable();
}

_initalliedaialleycombatbehavior()
{
    var_0 = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 67108864;
    self.disablebulletwhizbyreaction = 1;
    self.ignoresuppression = 1;
    maps\_utility::disable_surprise();
    var_1 = self.minpaindamage;
    thread maps\_hms_ai_utility::adjustallyaccuracyovertime();
    thread maps\_hms_ai_utility::painmanagement();
    common_scripts\utility::flag_wait_either( "FlagSniperScrambleStart", "FlagAlleysFinalBldgClear" );
    self notify( "disable_accuracy_adjust" );
    self notify( "disable_pain_management" );
    self.maxsightdistsqrd = var_0;
    self.disablebulletwhizbyreaction = 0;
    self.ignoresuppression = 0;
    maps\_utility::enable_surprise();
    self.minpaindamage = var_1;
}

trans2alleyscombat()
{
    var_0 = getentarray( "Trans2AlleysSquadASpawner", "targetname" );
    common_scripts\utility::flag_wait_either( "FlagTrigTrans2AlleysCombat", "FlagTrans2AlleysAllExecutionersDead" );
    var_1 = maps\_utility::array_spawn( var_0 );

    foreach ( var_3 in var_1 )
        level.alleysremainingenemies = common_scripts\utility::add_to_array( level.alleysremainingenemies, var_3 );

    maps\_utility::waittill_dead_or_dying( var_1 );
    common_scripts\utility::flag_set( "Trans2AlleysSquadADead" );
}

alleyscombat()
{
    level.alleysremainingenemies = [];
    thread alleyscombatenemyorders();
    thread alleyscombatfrontlinefloodspawns();
    thread alleyscombatfrontlineleftside();
    thread alleyscombatfrontlineleftbackstairs();
    thread alleyscombatfrontlineleftsideinteriorfloor1();
    thread alleyscombatfrontlinerightside();
    thread alleyscombatfrontlinerightbackatm();
    thread alleyscombatmidlineleftside();
    thread alleyscombatmidlinerightside();
    thread alleyscombatmidlinerightsideinterior();
    thread alleyscombatbacklineleftside();
    thread alleyscombatbacklineleftinteriorfloor1();
    thread alleyscombatbacklinerightside();
    thread alleyscombatbacklinerightinteriorfloor1();
    thread alleyscombatbacklinerightinteriorfloor2();
    thread alleyscombatfinalbuilding();
    thread alleyscombatfinalbuildinginterior();
    thread alleyscombatfinalbuildingshotgunners();
    thread alleyscombattriggertoggles();
    thread alleyscombatinteriorfakebulletssetup();
}

alleysvisitorcentergate()
{
    var_0 = getent( "AlleysVisitorCenterGate", "targetname" );
    var_0.animname = "visitorgate";
    var_0 maps\_utility::assign_animtree( "visitorgate" );
    var_1 = getent( "AlleysVisitorCenterGateCollision", "targetname" );
    var_2 = getent( "AlleysVisitorCenterGateUseTrigger", "targetname" );
    var_2 makeunusable();
    var_3 = common_scripts\utility::getstruct( "AlleysVisitorCenterGateRipOrg", "targetname" );
    var_4 = "alleys_gate_rip";
    wait 0.5;
    var_3 maps\_anim::anim_first_frame_solo( var_0, var_4 );
    level waittill( "AlleysAllEnemiesDead" );
    var_2 makeusable();
    var_2 _meth_80DA( "HINT_NOICON" );
    var_2 maps\_utility::addhinttrigger( &"GREECE_ALLEYS_GATERIP_PROMPT", &"GREECE_ALLEYS_GATERIP_PROMPT_KB" );
    thread alleysmonitorgateriphint();
    var_2 waittill( "trigger", var_5 );
    var_2 delete();
    common_scripts\utility::flag_set( "AlleysGateRipStarted" );
    level notify( "NotifyAlleysGateRipStarted" );
    maps\greece_fx::visitorcentergatebashfx();
    thread maps\greece_sniper_scramble::scramblestartdoorinit();
    level.player _meth_8119( 0 );
    level.player _meth_831D();
    var_6 = maps\_utility::spawn_anim_model( "player_alleys_rig", level.player.origin, level.player.angles );
    var_6 hide();
    var_7 = [ var_6, var_0 ];
    var_3 maps\_anim::anim_first_frame_solo( var_6, var_4 );
    level.player _meth_8080( var_6, "tag_player", 0.4 );
    wait 0.4;
    var_6 show();
    var_3 maps\_anim::anim_single( var_7, var_4 );
    level.player _meth_804F();
    var_6 delete();
    level.player _meth_831E();
    level.player _meth_8119( 1 );
    thread maps\_utility::autosave_now();
    common_scripts\utility::flag_set( "AlleysVisitorGateIsOpen" );
}

alleysgateripunblockpath()
{
    var_0 = getent( "AlleysVisitorCenterGateCollision", "targetname" );
    wait 1.0;
    var_0 _meth_82BF();
    var_0 _meth_8058();
    var_0 delete();
    wait 1.0;
    common_scripts\utility::flag_set( "FlagAlleysIlanaMoveToExit" );
}

alleysmonitorgateriphint()
{
    var_0 = getent( "AlleysVisitorCenterGateObj", "targetname" );
    var_1 = maps\_shg_utility::hint_button_position( "use", var_0.origin, 128 );
    common_scripts\utility::flag_wait( "AlleysGateRipStarted" );
    var_1 maps\_shg_utility::hint_button_clear();
}

alleyscombatinteriorfakebulletssetup()
{
    var_0 = getentarray( "InteriorFakeBulletsTrig", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread alleyscombatinteriorfakebulletsactivate();
}

alleyscombatinteriorfakebulletsactivate()
{
    var_0 = getent( self.target, "targetname" );
    var_1 = getentarray( var_0.target, "targetname" );
    self waittill( "trigger", var_2 );
    var_3 = randomintrange( 17, 23 );

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = common_scripts\utility::random( var_1 );
        magicbullet( "iw5_arx160_sp", var_0.origin, var_5.origin );
        wait(randomfloatrange( 0.09, 0.18 ));
    }
}

alleyscombattriggertoggles()
{
    common_scripts\utility::flag_wait( "FlagTrigAlleysMidLineRightSideSpawns" );
    var_0 = getentarray( "AlleysFrontLineUniqueTrig", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();

    common_scripts\utility::flag_wait( "FlagTrigAlleysMidLineRetreat" );
    var_4 = getentarray( "AlleysMidLineUniqueTrig", "targetname" );

    foreach ( var_2 in var_4 )
        var_2 common_scripts\utility::trigger_off();

    common_scripts\utility::flag_wait( "FlagTriggerAlleysEnemyRPGs" );
    var_7 = getentarray( "AlleysBackLineUniqueTrig", "targetname" );

    foreach ( var_2 in var_7 )
        var_2 common_scripts\utility::trigger_off();
}

alleyscombatenemyorders()
{
    common_scripts\utility::flag_wait_any( "FlagTrigAlleysFrontLineBackSpawns", "FlagAlleysCombatBeginEnemyRetreat", "FlagAlleysEndStart" );
    common_scripts\utility::flag_set( "FlagAlleysDeleteAI" );
    var_0 = getent( "AlleysFrontLineBadPlaceVolume", "targetname" );
    badplace_brush( "", 5, var_0, "axis" );
    level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
    level.alleysremainingenemies alleyscombatenemyretreat( "AlleysGoalVolumeMidPlusBack" );
    wait 0.5;
    common_scripts\utility::flag_clear( "FlagAlleysCombatBeginEnemyRetreat" );
    common_scripts\utility::flag_clear( "FlagAlleysDeleteAI" );
    common_scripts\utility::flag_wait_any( "FlagTrigAlleysMidLineCafeSpawns", "FlagAlleysCombatBeginEnemyRetreat", "FlagAlleysEndStart" );
    common_scripts\utility::flag_set( "FlagAlleysDeleteAI" );
    level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
    level.alleysremainingenemies alleyscombatenemyretreat( "AlleysGoalVolumeMidPlusBack" );
    thread maps\greece_alleys_vo::alleysenemyretreat();
    thread maps\greece_alleys_vo::alleysdialogtimer();
    wait 0.5;
    common_scripts\utility::flag_clear( "FlagAlleysCombatBeginEnemyRetreat" );
    common_scripts\utility::flag_clear( "FlagAlleysDeleteAI" );
    common_scripts\utility::flag_wait_any( "FlagTrigAlleysMidLineRetreat", "FlagAlleysCombatBeginEnemyRetreat", "FlagAlleysEndStart" );
    common_scripts\utility::flag_set( "FlagAlleysDeleteAI" );
    level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
    level.alleysremainingenemies alleyscombatenemyretreat( "AlleysGoalVolumeBackBothBldgs" );
    thread maps\greece_alleys_vo::alleysenemyretreat();
    thread maps\greece_alleys_vo::alleysdialogtimer();
    wait 0.5;
    common_scripts\utility::flag_clear( "FlagAlleysCombatBeginEnemyRetreat" );
    common_scripts\utility::flag_clear( "FlagAlleysDeleteAI" );
    common_scripts\utility::flag_wait_any( "FlagTrigAlleysBackLineRetreat", "FlagAlleysCombatBeginEnemyRetreat", "FlagAlleysEndStart" );
    common_scripts\utility::flag_set( "FlagAlleysDeleteAI" );
    level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
    level.alleysremainingenemies alleyscombatenemyretreat( "AlleysGoalVolumeFinalBldgBottomFloor" );
    thread maps\greece_alleys_vo::alleysenemyretreat();
    thread maps\greece_alleys_vo::alleysdialogtimer();
    wait 0.5;
    common_scripts\utility::flag_clear( "FlagAlleysCombatBeginEnemyRetreat" );
    common_scripts\utility::flag_clear( "FlagAlleysDeleteAI" );
    alleyscombatbacklinefloodspawns();
    common_scripts\utility::flag_wait_any( "FlagTrigAlleysRPGSpawnedRetreat", "FlagAlleysCombatBeginEnemyRetreat", "FlagAlleysEndStart" );
    common_scripts\utility::flag_set( "FlagAlleysDeleteAI" );
    level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
    level.alleysremainingenemies alleyscombatenemyretreat( "AlleysGoalVolumeFinalBldgBottomFloor" );
    thread maps\greece_alleys_vo::alleysenemyretreat();
    thread maps\greece_alleys_vo::alleysdialogtimer();
    wait 0.5;
    common_scripts\utility::flag_clear( "FlagAlleysCombatBeginEnemyRetreat" );
    common_scripts\utility::flag_clear( "FlagAlleysDeleteAI" );
    common_scripts\utility::flag_wait_any( "FlagTrigAlleysFinalBldgUpperRetreat", "FlagAlleysCombatBeginEnemyRetreat", "FlagAlleysEndStart" );
    common_scripts\utility::flag_set( "FlagAlleysDeleteAI" );
    level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
    level.alleysremainingenemies alleyscombatenemyretreat( "AlleysGoalVolumeFinalBldgStairs" );
    thread maps\greece_alleys_vo::alleysenemyretreat();
    thread maps\greece_alleys_vo::alleysdialogtimer();
    wait 0.5;
    common_scripts\utility::flag_clear( "FlagAlleysCombatBeginEnemyRetreat" );
    common_scripts\utility::flag_clear( "FlagAlleysDeleteAI" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFinalBldgInteriorFirstRoom" );
    common_scripts\utility::flag_set( "FlagAlleysDeleteAI" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFinalBldgKillAll" );
    var_1 = _func_0D6( "axis" );
    thread maps\greece_code::sunflareswap( "sunflare" );
    common_scripts\utility::flag_set( "FlagAlleysFinalBldgClear" );
    common_scripts\utility::flag_wait( "FlagAlleysIlanaReadyToExit" );
    waitframe();
    common_scripts\utility::flag_set( "FlagSniperScrambleStart" );
}

alleyscombatenemycountmonitor( var_0 )
{
    while ( level.alleysremainingenemies.size > var_0 )
    {
        level.alleysremainingenemies = maps\_utility::remove_dead_from_array( level.alleysremainingenemies );
        wait 1;
    }

    common_scripts\utility::flag_set( "FlagAlleysCombatBeginEnemyRetreat" );
}

alleyscombatenemyretreat( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_2 = [];

    foreach ( var_4 in self )
    {
        if ( var_4.classname == "actor_enemy_kva_shotgun" )
            continue;

        if ( maps\_hms_utility::cointossweighted( 66 ) )
        {
            var_4 _meth_81AB();
            var_4 _meth_81A9( var_1 );
            continue;
        }

        var_2 = common_scripts\utility::add_to_array( var_2, var_4 );
        thread maps\_utility::ai_delete_when_out_of_sight( var_2, 100 );
    }
}

alleyscombatfrontlinefloodspawns()
{
    var_0 = getentarray( "AlleysFrontLineLeftFloodSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgBothFloors" );
    var_1 = getentarray( "AlleysFrontLineRightUpperFloodSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBldgTopFloors" );
    var_2 = getentarray( "AlleysFrontLineRightBottomFloodSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_2, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBldgJewelryStore" );
    var_3 = maps\_utility::array_merge( var_1, var_2 );
    var_4 = maps\_utility::array_merge( var_3, var_0 );
    common_scripts\utility::flag_wait( "FlagAlleysCombatBeginEnemyRetreat" );

    if ( !common_scripts\utility::flag( "FlagTrigAlleysFrontLineBackSpawns" ) && !common_scripts\utility::flag( "FlagAlleysEndStart" ) )
    {
        wait 1;
        thread maps\_utility::flood_spawn( var_4 );
        thread maps\greece_code::killfloodspawnersonflag( 74, "FlagTrigAlleysFrontLineBackSpawns" );
    }
}

alleyscombatfrontlineleftside()
{
    var_0 = getentarray( "AlleysFrontLineTacSquadASpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor1" );
    var_1 = getentarray( "AlleysFrontLineAssSquadASpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor1" );
    var_2 = getentarray( "AlleysFrontLineInteriorSquadASpawner", "targetname" );
    maps\_utility::array_spawn_function( var_2, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontBothBldgs" );
    var_3 = getent( "AlleysFrontLineBalconyJumperASpawner", "targetname" );
    var_3 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor2" );
    var_4 = getent( "AlleysFrontLineBalconyJumperBSpawner", "targetname" );
    var_4 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor1" );
    var_5 = getent( "AlleysFrontLineLeftCornerSpawner", "targetname" );
    var_5 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor1" );
    var_6 = getent( "AlleysFrontLineLeftRooftopSpawner", "targetname" );
    var_6 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor3" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineSpawns" );
    var_7 = maps\_utility::array_spawn( var_0, 0, 1 );
    var_8 = maps\_utility::array_spawn( var_1, 0, 1 );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineShowySpawns" );
    var_9 = var_3 maps\_utility::spawn_ai();
    var_10 = var_4 maps\_utility::spawn_ai();
    thread alleyscombatenemycountmonitor( 5 );
    common_scripts\utility::flag_wait_either( "FlagTrigAlleysFrontLineLeftCenterStairs", "FlagTrigAlleysFrontLineLeftBackStairs" );
    var_11 = maps\_utility::array_spawn( var_2, 0, 1 );
}

alleyscombatfrontlineleftbackstairs()
{
    var_0 = getent( "AlleysFrontLineLeftBackStairsSpawner", "targetname" );
    var_0 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor1" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLeftBackStairsSpawn" );
    var_1 = var_0 maps\_utility::spawn_ai();
}

alleyscombatfrontlineleftsideinteriorfloor1()
{
    var_0 = getentarray( "AlleysFrontLineLeftInteriorSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontLeftBldgFloor1" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineLeftInterior" );
    var_1 = maps\_utility::array_spawn( var_0, 0, 1 );
}

alleyscombatfrontlinerightside()
{
    var_0 = getentarray( "AlleysFrontLineTacSquadBSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBldgJewelryStore" );
    var_1 = getentarray( "AlleysFrontLineAssSquadBSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBldgTopFloors" );
    var_2 = getentarray( "AlleysFrontLineInteriorSquadBSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_2, ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBldgFloor2" );
    var_3 = getent( "AlleysFrontLineBalconyJumperCSpawner", "targetname" );
    var_3 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBldgTopFloors" );
    var_4 = getent( "AlleysFrontLineRightBackStoreSpawner", "targetname" );
    var_4 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBldgFloor1" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineSpawns" );
    var_5 = maps\_utility::array_spawn( var_0, 0, 1 );
    var_6 = maps\_utility::array_spawn( var_1, 0, 1 );
    var_7 = var_4 maps\_utility::spawn_ai();
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineShowySpawns" );
    var_8 = var_3 maps\_utility::spawn_ai();
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineBackSpawns" );
    var_9 = maps\_utility::array_spawn( var_2, 0, 1 );
}

alleyscombatfrontlinerightbackatm()
{
    var_0 = getent( "AlleysFrontLineRightBackATMSpawner", "targetname" );
    var_0 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeFrontRightBackATM" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFrontLineRightBackATMSpawn" );
    var_1 = var_0 maps\_utility::spawn_ai();
}

alleyscombatmidlineleftside()
{
    var_0 = getentarray( "AlleysMidLineTacSquadASpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeMarket" );
    var_1 = getentarray( "AlleysMidLineAssSquadASpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeMarket" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysMidLineCafeSpawns" );
    var_2 = maps\_utility::array_spawn( var_0, 0, 1 );
    var_3 = maps\_utility::array_spawn( var_1, 0, 1 );
    common_scripts\utility::flag_set( "FlagAlleysEnemySpawnsVO" );
    thread alleyscombatenemycountmonitor( 3 );
}

alleyscombatmidlinerightside()
{
    var_0 = getentarray( "AlleysMidLineTacSquadBSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeJewelryStoreFloor1" );
    var_1 = getent( "AlleysMidLineJewelryStoreRoofSpawner", "targetname" );
    var_1 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeJewelryStoreRoof" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysMidLineRightSideSpawns" );
    var_2 = maps\_utility::array_spawn( var_0, 0, 1 );
    var_3 = var_1 maps\_utility::spawn_ai();
}

alleyscombatmidlinerightsideinterior()
{
    var_0 = getentarray( "AlleysMidLineRightSideInteriorSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeBackRightBldgBottomFloors" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysMidLineRightInteriorSpawns" );
    var_1 = maps\_utility::array_spawn( var_0, 0, 1 );
}

alleyscombatbacklinefloodspawns()
{
    var_0 = getentarray( "AlleysBackLineLeftFloodSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeBackLeftBldgBottomFloors" );
    var_1 = getentarray( "AlleysBackLineRightFloodSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeBackRightBldgBottomFloors" );
    var_2 = maps\_utility::array_merge( var_0, var_1 );
    thread maps\_utility::flood_spawn( var_2 );
    thread maps\greece_code::killfloodspawnersonflag( 75, "FlagTrigAlleysBackLineRetreat" );
}

alleyscombatbacklineleftside()
{
    var_0 = getentarray( "AlleysBackLineTacSquadASpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeBackLeftBldgFloor1" );
    var_1 = getentarray( "AlleysBackLineAssSquadASpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeBackLeftBldgFloor2" );
    var_2 = getent( "AlleysBackLineTowerSpawner", "targetname" );
    var_2 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeBackLeftBldgFloor3" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysBackLineSpawns" );
    var_3 = maps\_utility::array_spawn( var_0, 0, 1 );
    var_4 = maps\_utility::array_spawn( var_1, 0, 1 );
    var_5 = var_2 maps\_utility::spawn_ai( 1 );
    common_scripts\utility::flag_set( "FlagAlleysEnemySpawnsVO" );
    thread alleyscombatenemycountmonitor( 5 );
}

alleyscombatbacklineleftinteriorfloor1()
{
    var_0 = getentarray( "AlleysBackLineLeftInteriorSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeBackLeftBldgFloor1" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysBackLineLeftInterior" );
    var_1 = maps\_utility::array_spawn( var_0, 0, 1 );
}

alleyscombatbacklinerightside()
{
    var_0 = getentarray( "AlleysBackLineTacSquadBSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeBackRightBldgFloor1" );
    var_1 = getentarray( "AlleysBackLineAssSquadBSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeBackRightBldgFloor2" );
    var_2 = getent( "AlleysBackLinePotteryRooftopSpawner", "targetname" );
    var_2 maps\_utility::add_spawn_function( ::alleyscombatenemysetup, "AlleysGoalVolumeBackRightBldgFloor3" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysBackLineSpawns" );
    var_3 = maps\_utility::array_spawn( var_0, 0, 1 );
    var_4 = maps\_utility::array_spawn( var_1, 0, 1 );
    var_5 = var_2 maps\_utility::spawn_ai( 1 );
}

alleyscombatbacklinerightinteriorfloor1()
{
    var_0 = getentarray( "AlleysBackLineRightInteriorSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeBackRightBldgFloor1" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysBackLineRightInterior" );
    var_1 = maps\_utility::array_spawn( var_0, 0, 1 );
}

alleyscombatbacklinerightinteriorfloor2()
{
    var_0 = getentarray( "AlleysBackLineRightInteriorUpperSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeBackRightBldgFloor2" );
    common_scripts\utility::flag_wait_either( "FlagTrigAlleysBackLineRightUpperBackInterior", "FlagTrigAlleysBackLineRightUpperFrontInterior" );
    var_1 = maps\_utility::array_spawn( var_0, 0, 1 );
}

alleyscombatfinalbldgfloodspawns()
{
    var_0 = getentarray( "AlleysFinalBldgFloodSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeFinalBldgFloor2" );
    thread maps\_utility::flood_spawn( var_0 );
    thread maps\greece_code::killfloodspawnersonflag( 76, "FlagTrigAlleysFinalBldgInteriorFirstRoom" );
}

alleyscombatfinalbuilding()
{
    var_0 = getentarray( "AlleysFinalBldgAssSquadSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeFinalBldgTotal" );
    common_scripts\utility::flag_wait( "FlagTriggerAlleysEnemyRPGs" );
    var_1 = maps\_utility::array_spawn( var_0, 0, 1 );
}

alleyscombatfinalbuildingshotgunners()
{
    var_0 = getentarray( "AlleysShotgunnerSpawnTrigs", "targetname" );
    var_1 = getentarray( "AlleysShotgunnerSpawnerLeft", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup );
    var_2 = getentarray( "AlleysShotgunnerSpawnerMiddle", "targetname" );
    maps\_utility::array_spawn_function( var_2, ::alleyscombatenemysetup );
    var_3 = getentarray( "AlleysShotgunnerSpawnerRight", "targetname" );
    maps\_utility::array_spawn_function( var_3, ::alleyscombatenemysetup );
    common_scripts\utility::flag_wait_any( "TrigShotgunnerSpawnLeft", "TrigShotgunnerSpawnMiddle", "TrigShotgunnerSpawnRight" );

    foreach ( var_5 in var_0 )
        var_5 common_scripts\utility::trigger_off();

    if ( common_scripts\utility::flag( "TrigShotgunnerSpawnLeft" ) )
        var_7 = maps\_utility::array_spawn( var_1, 0, 1 );
    else if ( common_scripts\utility::flag( "TrigShotgunnerSpawnMiddle" ) )
        var_7 = maps\_utility::array_spawn( var_2, 0, 1 );
    else
        var_7 = maps\_utility::array_spawn( var_3, 0, 1 );

    maps\_utility::waittill_dead( var_7 );
    level notify( "AlleysShotgunnersAllDead" );
}

alleyscombatfinalbuildinginterior()
{
    var_0 = getentarray( "AlleysFinalBldgInteriorFirstRoomSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::alleyscombatenemysetup, "AlleysGoalVolumeFinalBldgFloor2Left" );
    var_1 = getentarray( "AlleysFinalBldgInteriorLastRoomSpawner", "targetname" );
    maps\_utility::array_spawn_function( var_1, ::alleyscombatenemysetup, "AlleysGoalVolumeFinalBldgBalcony" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFinalBldgInteriorFirstRoom" );
    common_scripts\utility::flag_wait( "FlagTrigAlleysFinalBldgInteriorLastRoom" );
    thread alleyscombatenemycountmonitor( 0 );
}

alleyscombatenemysetup( var_0, var_1 )
{
    level.alleysremainingenemies = common_scripts\utility::add_to_array( level.alleysremainingenemies, self );

    if ( !isdefined( self.script_noteworthy ) )
        self.script_noteworthy = "AlleysCanRetreat";
    else if ( self.script_noteworthy == "AlleysCannotRetreat" )
        maps\_hms_utility::aideleteonflag( "FlagAlleysDeleteAI", 100, 1 );

    if ( self.classname == "actor_enemy_kva_civ_smg" )
        thread maps\_rambo::enable_militia_behavior();

    if ( self.classname == "actor_enemy_kva_shotgun" )
        thread maps\_hms_ai_utility::setupshotgunkva( var_0 );

    if ( self.classname == "actor_enemy_kva_civ_lmg" || self.classname == "actor_enemy_kva_civ_rpg" )
        self.grenadeammo = 0;

    if ( self.classname != "actor_enemy_kva_shotgun" && isdefined( var_0 ) )
    {
        var_2 = getent( var_0, "targetname" );
        self _meth_81A9( var_2 );
    }
}

alleysspawnrpgenemies()
{
    if ( level.start_point == "start_alleys_art" )
        return;

    common_scripts\utility::flag_wait( "FlagTriggerAlleysEnemyRPGs" );
    var_0 = maps\_utility::array_spawn_targetname( "AlleysEnemyRPGguySpawner", 0, 1 );
    level.alleysremainingenemies = common_scripts\utility::add_to_array( level.alleysremainingenemies, self );

    foreach ( var_2 in var_0 )
    {
        var_2.dropweapon = 0;
        level.alleysremainingenemies = common_scripts\utility::add_to_array( level.alleysremainingenemies, var_2 );
    }

    var_4 = getent( "AlleysRPGtriggerLeft", "targetname" );
    var_5 = getent( "AlleysRPGtriggerRight", "targetname" );

    if ( level.player _meth_80A9( var_4 ) )
        var_6 = "RPGleft";
    else if ( level.player _meth_80A9( var_5 ) )
        var_6 = "RPGright";
    else
        var_6 = "RPGcenter";

    var_7 = getnodearray( "RPGguyNode", "targetname" );

    foreach ( var_9 in var_7 )
    {
        if ( var_9.script_noteworthy != var_6 )
            var_7 = common_scripts\utility::array_remove( var_7, var_9 );
    }

    var_11 = common_scripts\utility::get_array_of_farthest( level.player.origin, var_7 );
    var_12 = undefined;

    for ( var_13 = 0; var_13 < var_0.size; var_13++ )
    {
        var_12 = var_11[var_13];
        var_2 = var_0[var_13];

        if ( isdefined( var_12 ) )
        {
            var_2 maps\_utility::set_goal_radius( 64 );
            var_2 maps\_utility::set_goal_node( var_12 );
            maps\_hms_utility::printlnscreenandconsole( var_2.script_noteworthy + " is now moving to " + var_12.origin );
            var_2 thread alleysrpgguyshootfirst( var_12 );
        }
    }
}

alleysrpgguyshootfirst( var_0 )
{
    self endon( "death" );
    self endon( "damage" );
    self waittill( "goal" );

    if ( isdefined( var_0.target ) )
    {
        var_1 = undefined;
        var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );

        if ( isdefined( var_1.dirty ) && var_1.dirty == 1 )
        {
            if ( common_scripts\utility::cointoss() )
            {
                maps\_hms_utility::printlnscreenandconsole( self.script_noteworthy + " is not firing a fake rocket - too dirty!" );
                return;
            }
        }

        var_2 = undefined;
        var_3 = common_scripts\utility::getstructarray( "RPGendPoint", "targetname" );
        var_4 = common_scripts\utility::get_array_of_closest( level.player.origin, var_3 );

        foreach ( var_6 in var_4 )
        {
            if ( sighttracepassed( var_1.origin, var_6.origin, 0, undefined ) )
            {
                var_2 = var_6;
                break;
            }
        }

        if ( isdefined( var_2 ) )
        {
            maps\_hms_utility::printlnscreenandconsole( self.script_noteworthy + " is firing a fake rocket from " + var_1.origin + " to " + var_2.origin );
            magicbullet( "iw5_mahemstraight_sp", var_1.origin, var_2.origin );
            var_8 = common_scripts\utility::getstructarray( "RPGstartPoint", "script_noteworthy" );

            foreach ( var_6 in var_8 )
                var_6.dirty = 1;

            soundscripts\_snd::snd_message( "alleys_rpg_fight_music" );
            wait 1;
            self notify( "clear_target" );
        }
    }

    self.favoriteenemy = level.player;
}

monitordestructiblewalls()
{
    var_0 = getentarray( "AlleysDestRocketWall", "targetname" );
    common_scripts\utility::array_thread( var_0, ::rpgdestroywall );
}

rpgdestroywall()
{
    self _meth_82C0( 1 );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( isdefined( var_4 ) )
        {
            var_4 = tolower( var_4 );

            if ( var_4 == "mod_projectile" || var_4 == "mod_projectile_splash" || var_4 == "mod_explosive" || var_4 == "splash" )
            {
                self notify( "destroyed" );
                self delete();
                return;
            }
        }

        waitframe();
    }
}

alleysvideolog()
{
    common_scripts\utility::flag_wait( "AlleysVisitorGateIsOpen" );
    maps\_shg_utility::play_videolog( "manhunt_videolog", "screen_add" );
}

trans2alleyscivilians()
{
    thread trans2alleysbackdoorciv();
    thread trans2alleystunnelrunners();
    thread trans2alleysdoorpeek();

    if ( level.nextgen )
        thread trans2alleysdoorrunin();

    thread trans2alleyssitsmoke();
    thread trans2alleysbridgecivilians();
    thread trans2alleyscafecivilians();
    thread alleysdronecivilians();
    thread trans2alleysciviliansvskva();
    thread trans2alleyscivwindowpeek();
}

trans2alleysbackdoorciv()
{
    var_0 = common_scripts\utility::getstruct( "PanicOrg", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "backdoor_Civ", 1 );
    var_1.animname = "backdoor_civ";
    var_1.allowpain = 0;
    var_2 = getent( "backdoor", "targetname" );
    var_2.animname = "backdoor";
    var_2 maps\_utility::assign_animtree( "backdoor" );
    var_3 = [ var_1, var_2 ];
    var_0 maps\_anim::anim_first_frame( var_3, "backdoor_panic" );
    common_scripts\utility::flag_wait( "trig_Civs_panic" );
    var_0 maps\_anim::anim_single( var_3, "backdoor_panic" );
    waitframe();

    if ( isdefined( var_1 ) && isalive( var_1 ) )
        var_1 delete();

    common_scripts\utility::flag_wait( "FlagDeleteAlleyCivilians" );
    var_2 delete();
}

trans2alleystunnelrunners()
{
    var_0 = common_scripts\utility::getstructarray( "Trans2AlleysTunnelRunnerGoal", "targetname" );
    common_scripts\utility::flag_wait( "FlagTrigTrans2AlleysTunnelRunners" );
    soundscripts\_snd::snd_message( "tunnel_runner_walla" );
    var_1 = [];
    var_2 = maps\_utility::array_spawn_targetname( "Trans2AlleysTunnelRunnerSpawner" );

    foreach ( var_4 in var_2 )
    {
        var_5 = common_scripts\utility::random( var_0 );
        var_4 maps\_utility::set_goal_pos( var_5.origin );
        var_4.allowpain = 0;
        var_1[var_1.size] = var_4;
    }

    common_scripts\utility::flag_wait( "FlagDeleteAlleyCivilians" );
    maps\_utility::array_delete( var_1 );
}

trans2alleysmagicdisappearingworldevent()
{
    var_0 = getent( "Trans2AlleysStreamingBlockerTruck", "targetname" );
    var_1 = getent( "Trans2AlleysTunnelBlocker", "targetname" );
    var_2 = getent( "Trans2AlleysTunnelGateLeft", "targetname" );
    var_3 = getent( "Trans2AlleysTunnelGateRight", "targetname" );
    var_4 = getentarray( "Trans2AlleysTunnelGateClip", "targetname" );
    var_0 common_scripts\utility::hide_notsolid();
    common_scripts\utility::flag_wait( "FlagTriggerAlleysTransitionStreet" );
    var_0 show();
    var_1 _meth_82B1( 128, 0.5 );
    var_2 _meth_82B7( 150, 0.5 );
    var_3 _meth_82B7( -80, 0.5 );

    foreach ( var_6 in var_4 )
    {
        var_6 _meth_82BF();
        var_6 delete();
    }

    if ( level.currentgen )
    {
        if ( !_func_21E( "greece_middle_tr" ) )
        {
            level notify( "tff_pre_intro_to_middle" );
            _func_219( "greece_intro_tr" );
            _func_218( "greece_middle_tr" );

            while ( !_func_21E( "greece_middle_tr" ) )
                wait 0.05;

            level notify( "tff_post_intro_to_middle" );
        }
    }
}

trans2alleysdoorpeek()
{
    var_0 = getent( "Trans2AlleyDoorPeekSpawner", "targetname" );
    var_1 = var_0 maps\_utility::dronespawn();
    var_1.animname = "generic";
    var_1.allowpain = 0;
    var_2 = common_scripts\utility::getstruct( "Trans2AlleysCivPeekOrg", "targetname" );
    var_3 = getent( "Trans2AlleysCivPeekDoor", "targetname" );
    var_3.animname = "peek_door";
    var_3 maps\_utility::assign_animtree( "peek_door" );
    var_4 = [ var_3, var_1 ];
    var_5 = "trans_alley_civ_doors_peek_idle";
    var_6 = "trans_alley_civ_doors_peek_in";
    var_2 thread maps\_anim::anim_loop( var_4, var_5, "StopDoorPeek" );
    maps\_utility::trigger_wait_targetname( "Trans2AlleyDoorPeekTrig" );
    var_2 notify( "StopDoorPeek" );
    var_2 maps\_anim::anim_single( var_4, var_6 );
    waitframe();

    if ( isdefined( var_1 ) && isalive( var_1 ) )
        var_1 delete();
}

trans2alleyscivwindowpeek()
{
    var_0 = common_scripts\utility::getstruct( "windowOrg", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "windowCiv", 1 );
    var_1.animname = "window_civ";
    var_1.allowpain = 0;
    var_2 = getent( "shutters", "targetname" );
    var_2 maps\_utility::assign_animtree( "window_shutters" );
    var_2.animname = "window_shutters";
    var_3 = [ var_1, var_2 ];
    var_0 maps\_anim::anim_first_frame( var_3, "window_peek_all" );
    maps\_utility::trigger_wait_targetname( "Trans2AlleyDoorRunInTrig" );
    var_0 maps\_anim::anim_single( var_3, "window_peek_all" );
}

trans2alleysdoorrunin()
{
    maps\_utility::trigger_wait_targetname( "Trans2AlleyDoorRunInTrig" );
    var_0 = getent( "Trans2AlleysDoorRunInSpawner", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai();
    var_1.animname = "generic";
    var_1.allowpain = 0;
    soundscripts\_snd::snd_message( "civ_panic_door_run_in", var_1 );
    var_2 = common_scripts\utility::getstruct( "Trans2AlleyDoorRunInOrg", "targetname" );
    var_3 = getent( "Trans2AlleysDoorRunInDoor", "targetname" );
    var_3.animname = "runin_door";
    var_3 maps\_utility::assign_animtree( "runin_door" );
    var_4 = [ var_3, var_1 ];
    var_5 = "trans_alley_civ_doors_runin";
    var_2 maps\_anim::anim_first_frame_solo( var_3, var_5 );
    var_2 maps\_anim::anim_reach_solo( var_1, var_5 );
    var_2 maps\_anim::anim_single( var_4, var_5 );
    waitframe();

    if ( isdefined( var_1 ) && isalive( var_1 ) )
        var_1 delete();
}

trans2alleyssitsmoke()
{
    var_0 = getent( "Trans2AlleysSitSmokeSpawner", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "generic";
    var_1.allowpain = 0;
    var_2 = common_scripts\utility::getstruct( "Trans2AlleySitSmokeOrg", "targetname" );
    var_3 = "hms_greece_trans_alley_sit_smoke_idle";
    var_4 = "hms_greece_trans_alley_sit_smoke_out";
    var_5 = "hms_greece_trans_alley_sit_smoke_scared_loop";
    var_2 thread maps\_anim::anim_loop_solo( var_1, var_3, "StopSitSmoke" );
    maps\_utility::trigger_wait_targetname( "Trans2AlleySitSmokeRunTrig" );
    soundscripts\_snd::snd_message( "smoking_civ_panic", var_1 );
    var_2 notify( "StopSitSmoke" );
    var_2 maps\_anim::anim_single_solo( var_1, var_4 );
    var_2 thread maps\_anim::anim_loop_solo( var_1, var_5 );
    common_scripts\utility::flag_wait( "FlagTrans2AlleysCivCleanup" );

    if ( isdefined( var_1 ) )
        var_1 delete();
}

trans2alleyscafecivilians()
{
    var_0 = maps\_utility::array_spawn_targetname( "AlleysTransCivilianCafeSpawner", 1 );

    foreach ( var_2 in var_0 )
    {
        var_2.animname = var_2.script_noteworthy;
        var_2.allowpain = 0;

        if ( var_2.animname == "cafe1" )
        {
            var_2 thread trans2alleysstandupcivcafe();
            continue;
        }

        var_2 thread trans2alleyscivcafe();
    }

    common_scripts\utility::flag_wait( "FlagTrans2AlleysCivCleanup" );
    var_0 = common_scripts\utility::array_removeundefined( var_0 );
    thread maps\_utility::ai_delete_when_out_of_sight( var_0, 2048 );
    common_scripts\utility::flag_wait( "FlagDeleteAlleyCivilians" );
    var_0 = common_scripts\utility::array_removeundefined( var_0 );
    maps\_utility::array_delete( var_0 );
}

trans2alleyscivcafe()
{
    self endon( "death" );
    maps\_utility::set_ignoreall( 1 );
    self.allowpain = 0;
    var_0 = getent( "AlleysTransCafe2Org", "targetname" );
    var_1 = "hms_greece_trans_alley_cafe_civ_idle";
    var_0 thread maps\_anim::anim_loop_solo( self, var_1, "stop_loop" );
    common_scripts\utility::flag_wait( "FlagTriggerAlleysTransitionCafe" );
    maps\_utility::anim_stopanimscripted();
    var_0 notify( "stop_loop" );
    var_2 = "hms_greece_trans_alley_cafe_civ_exit";
    var_0 maps\_anim::anim_single_solo_run( self, var_2 );
    var_3 = self.script_noteworthy + "goalAlleyTrans";
    var_4 = common_scripts\utility::getstruct( var_3, "targetname" );
    maps\_utility::set_goal_pos( var_4.origin );
}

trans2alleysstandupcivcafe()
{
    self endon( "death" );
    maps\_utility::set_ignoreall( 1 );
    self.allowpain = 0;
    var_0 = getent( "AlleysTransCafe1Org", "targetname" );
    var_1 = "hms_greece_trans_alley_cafe_civ_idle";
    var_0 thread maps\_anim::anim_loop_solo( self, var_1, "stop_loop_1" );
    maps\_utility::trigger_wait_targetname( "Trans2AlleyCivStandUpTrig" );
    maps\_utility::anim_stopanimscripted();
    var_0 notify( "stop_loop_1" );
    var_2 = "hms_greece_trans_alley_cafe_civ_sit2stand_01";
    var_3 = "hms_greece_trans_alley_cafe_civ_stand_idle_01";
    var_0 maps\_anim::anim_single_solo( self, var_2 );
    var_0 thread maps\_anim::anim_loop_solo( self, var_3, "stop_loop_2" );
    common_scripts\utility::flag_wait( "FlagTriggerAlleysTransitionCafe" );
    maps\_utility::anim_stopanimscripted();
    var_0 notify( "stop_loop_2" );
    var_4 = "hms_greece_trans_alley_cafe_civ_exit";
    var_0 maps\_anim::anim_single_solo_run( self, var_4 );
    var_5 = self.script_noteworthy + "goalAlleyTrans";
    var_6 = common_scripts\utility::getstruct( var_5, "targetname" );
    maps\_utility::set_goal_pos( var_6.origin );
}

trans2alleysbridgecivilians()
{
    maps\_utility::trigger_wait_targetname( "Trans2AlleyBridgeTrig" );
    soundscripts\_snd::snd_message( "walla_bridge_runners" );
    var_0 = getent( "AlleysCivBridgeSpawner", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "AlleyCivBridgeOrg", "targetname" );
    var_2 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_1, 0, 1 );
    thread tricklebridgecivilians( var_0, var_1 );
}

tricklebridgecivilians( var_0, var_1 )
{
    var_2 = [];

    for (;;)
    {
        wait(randomfloatrange( 3.0, 9.0 ));

        if ( common_scripts\utility::flag( "FlagTrans2AlleysCivCleanup" ) )
            break;

        var_3 = [];
        var_2 = common_scripts\utility::array_randomize( var_1 );
        var_4 = 25;

        for ( var_5 = 0; var_5 < var_2.size; var_5++ )
        {
            var_3 = common_scripts\utility::array_add( var_3, var_2[var_5] );

            if ( maps\_hms_utility::cointossweighted( var_4 ) )
                break;

            var_4 += 25;
        }

        if ( var_3.size > 0 )
            var_6 = maps\_hms_greece_civilian::populatedronecivilians( var_0, var_3, 0, 1 );
    }
}

alleysdronecivilians()
{
    var_0 = [];
    thread alleysdronegawker();
    var_1 = getent( "AlleysCivCowerSpawner", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "AlleyCivCowerOrg", "targetname" );
    var_3 = maps\_hms_greece_civilian::populatedronecivilians( var_1, var_2 );
    var_0 = maps\_utility::array_merge( var_3, var_0 );
    common_scripts\utility::flag_wait( "FlagDeleteAlleyCivilians" );
    var_0 = common_scripts\utility::array_removeundefined( var_0 );
    thread maps\_utility::ai_delete_when_out_of_sight( var_0, 2048 );
}

alleysdronegawker()
{
    var_0 = [];
    var_1 = getent( "AlleysCivGawkingSpawner", "targetname" );
    var_2 = common_scripts\utility::getstruct( "AlleyCivGawkingOrg", "targetname" );
    var_3 = var_1 maps\_utility::spawn_ai( 1 );
    var_3 endon( "death" );
    var_0 = common_scripts\utility::add_to_array( var_0, var_3 );
    var_3.animname = "generic";
    var_2 thread maps\_anim::anim_loop_solo( var_3, "unarmed_cowerstand_idle", "gawker_flee" );
    maps\_utility::trigger_wait_targetname( "Trans2AlleyCivRunnerTrig" );
    var_2 notify( "gawker_flee" );
    var_2 maps\_anim::anim_single_solo( var_3, "unarmed_cowerstand_react_2_crouch" );
    var_3 thread maps\_anim::anim_loop_solo( var_3, "unarmed_cowercrouch_idle" );
    wait 1;
    thread maps\_utility::ai_delete_when_out_of_sight( var_0, 1024 );
}

trans2alleysciviliansvskva()
{
    maps\_utility::trigger_wait_targetname( "Trans2AlleyCivRunnerTrig" );
    var_0 = [];
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_1 = maps\_utility::array_spawn_targetname( "AlleysTransCivilianRunnerSpawner", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_1 );
    maps\_utility::array_spawn_function_targetname( "AlleysTransCivilianDyingSpawner", ::trans2alleyscivdying );
    var_3 = maps\_utility::array_spawn_targetname( "AlleysTransCivilianDyingSpawner", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_3 );
    var_4 = getent( "AlleysTransIntro1Org", "targetname" );
    var_5 = getent( "AlleysTransIntro1VariantOrg", "targetname" );
    var_6 = "hms_greece_alleys_npc_civtd_civp1";

    foreach ( var_8 in var_1 )
    {
        var_8.allowpain = 0;

        if ( var_8.script_noteworthy == "runner1" )
        {
            var_8 thread trans2alleyscivrunner( var_5, var_6 );
            soundscripts\_snd::snd_message( "trans_civ_01_flee_kva", var_8 );
        }
        else
            var_8 thread trans2alleyscivrunner( var_4, var_6 );

        if ( var_8.script_noteworthy == "runner3" )
            soundscripts\_snd::snd_message( "trans_civ_03_flee_kva", var_8 );
    }

    maps\_utility::trigger_wait_targetname( "Trans2AlleyCivVictimTrig" );
    var_10 = getent( "AlleysTransIntro2Org", "targetname" );
    var_11 = "hms_greece_alleys_npc_civtd_civp2";
    var_2 = maps\_utility::array_spawn_targetname( "AlleysTransCivilianVictimSpawner", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_2 );

    foreach ( var_8 in var_2 )
    {
        var_8.allowpain = 0;
        var_8 thread trans2alleyscivvictim( var_10, var_11 );
    }

    var_14 = maps\_utility::array_spawn_targetname( "AlleysTransExecutionerSpawner", 1 );
    var_14 thread monitorexecutionerdeath();
    var_15 = [];
    var_15[0] = "iw5_kf5_sp_opticsthermal";
    var_15[1] = "iw5_maul_sp_opticsreddot";
    var_15[2] = "iw5_ak12_sp_opticstargetenhancer";
    var_15[3] = "iw5_hbra3_sp_opticsacog2";

    for ( var_16 = 0; var_16 < var_14.size; var_16++ )
        var_14[var_16] thread trans2alleysexecutioner( var_10, var_11, var_15[var_16], var_2 );

    thread monitorexecutionertrigger();
    common_scripts\utility::flag_wait( "FlagTrans2AlleysCivCleanup" );
    var_0 = common_scripts\utility::array_removeundefined( var_0 );
    thread maps\_utility::ai_delete_when_out_of_sight( var_0, 2048 );
    common_scripts\utility::flag_wait( "FlagDeleteAlleyCivilians" );
    var_0 = common_scripts\utility::array_removeundefined( var_0 );
    maps\_utility::array_delete( var_0 );
    var_14 = maps\_utility::array_removedead_or_dying( var_14 );
    thread maps\_utility::ai_delete_when_out_of_sight( var_14, 2048 );
}

trans2alleysexecutioner( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    maps\_utility::disable_long_death();
    maps\_utility::set_ignoresuppression( 1 );
    self.grenadeammo = 0;
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_surprise();
    thread monitorexecutionerdamage();
    self.animname = self.script_noteworthy;
    maps\_utility::forceuseweapon( var_2, "primary" );
    killsomecivilians( var_0, var_1, var_3 );
    maps\_utility::anim_stopanimscripted();

    if ( self.animname == "guard2" )
        thread executioner2standground();
    else
    {
        var_4 = getent( "AlleyTransExecutionerVol2", "targetname" );
        self _meth_81A9( var_4 );
    }

    maps\_utility::set_ignoreme( 0 );
    maps\_utility::set_ignoreall( 0 );
}

monitorexecutionertrigger()
{
    level endon( "Trans2AlleyExecutionersReleased" );
    maps\_utility::trigger_wait_targetname( "Trans2AlleyReleaseExecutionersTrig" );
    level notify( "Trans2AlleyExecutionersReleased" );
}

monitorexecutionerdamage()
{
    level endon( "Trans2AlleyExecutionersReleased" );
    common_scripts\utility::waittill_any( "damage", "death" );
    level notify( "Trans2AlleyExecutionersReleased" );
}

monitorexecutionerdeath()
{
    maps\_utility::waittill_dead_or_dying( self );
    common_scripts\utility::flag_set( "FlagTrans2AlleysAllExecutionersDead" );
}

executioner2standground()
{
    self endon( "death" );
    var_0 = getent( "AlleyTransExecutionerVol1", "targetname" );
    self _meth_81A9( var_0 );
    maps\_utility::trigger_wait_targetname( "Trans2AlleyReleaseExecutionersTrig" );
    var_1 = getent( "AlleyTransExecutionerVol2", "targetname" );
    self _meth_81A9( var_1 );
}

killsomecivilians( var_0, var_1, var_2 )
{
    self endon( "death" );
    level endon( "Trans2AlleyExecutionersReleased" );

    if ( self.animname == "guard3" )
        var_0 = getent( "AlleysTransIntro3Org", "targetname" );

    var_0 maps\_anim::anim_single_solo( self, var_1 );
}

trans2alleyscivrunner( var_0, var_1 )
{
    self endon( "death" );
    maps\_utility::set_ignoreall( 1 );
    self.animname = self.script_noteworthy;
    self.allowpain = 0;
    var_0 thread maps\_anim::anim_single_solo_run( self, var_1 );
    var_2 = self.script_noteworthy + "goalAlleyTrans";
    var_3 = common_scripts\utility::getstruct( var_2, "targetname" );
    maps\_utility::set_goal_pos( var_3.origin );
}

trans2alleyscivdying()
{
    self endon( "death" );
    maps\_utility::set_ignoreall( 1 );
    self.animname = "generic";
    var_0 = self.script_noteworthy + "AlleyTrans";
    var_1 = getent( var_0, "targetname" );
    var_2 = var_1.animation;
    var_1 maps\_anim::anim_single_solo( self, var_2 );
    self _meth_8023();
    maps\greece_code::kill_no_react();
}

trans2alleyscivvictim( var_0, var_1 )
{
    self endon( "death" );
    maps\_utility::set_ignoreall( 1 );
    self.animname = self.script_noteworthy;
    self.allowpain = 0;

    if ( self.animname == "victim1" )
    {
        var_0 maps\_anim::anim_single_solo( self, var_1 );
        self _meth_8023();
        maps\greece_code::kill_no_react();
    }
    else if ( self.animname == "victim2" || self.animname == "victim3" )
    {
        var_0 thread maps\_anim::anim_single_solo_run( self, var_1 );
        var_2 = self.script_noteworthy + "goalAlleyTrans";
        var_3 = common_scripts\utility::getstruct( var_2, "targetname" );
        maps\_utility::set_goal_pos( var_3.origin );
    }
    else if ( self.animname == "victim4" )
    {
        var_4 = "hms_greece_alleys_npc_civtd_civp2_04_idle";
        var_0 maps\_anim::anim_single_solo( self, var_1 );
        var_0 thread maps\_anim::anim_loop_solo( self, var_4 );
    }
    else if ( self.animname == "victim5" )
    {
        var_4 = "hms_greece_alleys_npc_civtd_civp2_05_idle";
        var_0 maps\_anim::anim_single_solo( self, var_1 );
        var_2 = self.script_noteworthy + "goalAlleyTrans";
        var_3 = common_scripts\utility::getstruct( var_2, "targetname" );
        maps\_utility::set_goal_pos( var_3.origin );
    }
    else
    {
        var_0 thread maps\_anim::anim_single_solo( self, var_1 );
        maps\_utility::set_goal_pos( self.origin );
    }
}

alleysvehiclemonitor()
{
    level endon( "ScrambleJumpWatcherStop" );
    var_0 = getent( "AlleysEndCar", "targetname" );
    var_0 thread alleysvehicleexplodeondeath();

    for (;;)
    {
        var_0 waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( isdefined( var_5 ) && isexplosivedamagemod( var_5 ) )
            var_0 _meth_8051( var_1, var_0.origin );

        waitframe();
    }
}

alleysvehicleexplodeondeath()
{
    level endon( "ScrambleJumpWatcherStop" );
    self waittill( "death" );
    radiusdamage( self.origin, 200, 100, 10 );
    physicsexplosionsphere( self.origin, 300, 100, 1.5 );
    earthquake( 0.5, 0.3, self.origin, 600 );
}
