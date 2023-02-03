// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    sniperscrambleprecache();
    sniperscrambleflaginit();
    sniperscrambleglobalvars();
    sniperscrambleglobalsetup();
    maps\greece_sniper_scramble_fx::main();
    maps\greece_sniper_scramble_anim::main();
    maps\greece_sniper_scramble_vo::main();
    thread vehicle_scripts\_pdrone_tactical_picker::main();
    maps\_stingerm7_greece::init();
}

sniperscrambleprecache()
{
    precacheshellshock( "iw5_hmr9_sp" );
    precacheshellshock( "iw5_hmr9_sp_variablereddot" );
    precacheshellshock( "iw5_bal27_sp" );
    precacheshellshock( "iw5_bal27_sp_silencer01_variablereddot" );
    precacheshellshock( "iw5_sn6_sp" );
    precacheshellshock( "fraggrenade" );
    precacheshellshock( "flash_grenade" );
    precacheshellshock( "hms_rail_sniper" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "iw5_titan45_sp_opticsreddot_silencerpistol" );
    precacherumble( "silencer_fire" );
    precacherumble( "damage_light" );
    precacherumble( "damage_heavy" );
    precacherumble( "artillery_rumble" );
    precacherumble( "tank_rumble" );
    precacherumble( "subtle_tank_rumble" );
    precachemodel( "viewhands_atlas_military" );
    precachemodel( "vb_civilian_mitchell" );
    precachemodel( "npc_variable_grenade_nonlethal" );
    precacheshader( "damage_feedback" );
    precachemodel( "greece_sniper_tower_des" );
    precachemodel( "greece_sniper_tower_des_01" );
    precachemodel( "greece_sniper_tower_des_02" );
    precachemodel( "greece_sniper_tower_des_03" );
    precachemodel( "greece_sniper_tower_des_04" );
    precachemodel( "greece_sniper_tower_des_05" );
    precachemodel( "greece_sniper_tower_des_06" );
    precachemodel( "greece_sniper_tower_des_07" );
    precachemodel( "greece_cable_car_rigged" );
    precachestring( &"GREECE_HINT_MOVE_TRUCK" );
    precachestring( &"GREECE_HINT_MOVE_TRUCK_KB" );
    precachestring( &"GREECE_FAIL_SCRAMBLE_LEFT_ILONA" );
    precachestring( &"GREECE_FAIL_SCRAMBLE_SUPPRESS_SNIPER" );
    precachestring( &"GREECE_OBJ_SCRAMBLE_SUPPRESS" );
    precachestring( &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    precachestring( &"GREECE_OBJ_SCRAMBLE_DESTROY" );
    precachestring( &"GREECE_OBJ_SCRAMBLE_ELIMINATE_SNIPER" );
    precachestring( &"GREECE_OBJ_INTERCEPT_HADES" );
    precachestring( &"GREECE_OBJ_SCRAMBLE_PICKUPSTINGER" );
    precachestring( &"GREECE_OBJ_SCRAMBLE_PUSHTRUCK" );
    maps\_utility::add_hint_string( "scramble_suppress_sniper_1", &"GREECE_HINT_SCRAMBLE_SUPPRESS", ::hintscramblesuppress1off );
    maps\_utility::add_hint_string( "scramble_suppress_sniper_2", &"GREECE_HINT_SCRAMBLE_SUPPRESS", ::hintscramblesuppress2off );
    maps\_utility::add_hint_string( "scramble_advance_to_ilona", &"GREECE_HINT_SCRAMBLE_ADVANCE", ::hintscrambleadvanceoff );
    maps\_hms_door_interact::precachedooranimations();
}

sniperscrambleflaginit()
{
    common_scripts\utility::flag_init( "FlagAlleysPipComplete" );
    common_scripts\utility::flag_init( "FlagAlleysIlanaReadyToExit" );
    common_scripts\utility::flag_init( "FlagScrambleSniperSuppressed" );
    common_scripts\utility::flag_init( "FlagScrambleIlanaBeginOpenIntroDoor" );
    common_scripts\utility::flag_init( "FlagScrambleIlanaEndOpenIntroDoor" );
    common_scripts\utility::flag_init( "FlagScrambleStartIntro" );
    common_scripts\utility::flag_init( "FlagScrambleStartHotel" );
    common_scripts\utility::flag_init( "FlagScrambleStartDrones" );
    common_scripts\utility::flag_init( "FlagScrambleStartFinale" );
    common_scripts\utility::flag_init( "FlagScrambleHotelIlanaStartRun" );
    common_scripts\utility::flag_init( "FlagScrambleHotelIlanaReachedGoal" );
    common_scripts\utility::flag_init( "FlagScrambleHotelIlanaJumpDown" );
    common_scripts\utility::flag_init( "FlagScrambleHotelBadLeapfrog" );
    common_scripts\utility::flag_init( "FlagScrambleHotelPlayerHasDecided" );
    common_scripts\utility::flag_init( "FlagScrambleCheckPlayerDecision" );
    common_scripts\utility::flag_init( "FlagScrambleReadyForWoundedSoldier" );
    common_scripts\utility::flag_init( "FlagScrambleDestroyFishTank" );
    common_scripts\utility::flag_init( "FlagScrambleWoundedSoldierKilled" );
    common_scripts\utility::flag_init( "FlagScrambleSniperKilled" );
    common_scripts\utility::flag_init( "FlagScramblePlayerJumping" );
    common_scripts\utility::flag_init( "FlagScrambleGapJumpStarted" );
    common_scripts\utility::flag_init( "FlagScrambleGapJumpCompleted" );
    common_scripts\utility::flag_init( "FlagScrambleIlanaGapJumpCompleted" );
    common_scripts\utility::flag_init( "FlagScrambleHotelJumpStarted" );
    common_scripts\utility::flag_init( "FlagScrambleHotelJumpCompleted" );
    common_scripts\utility::flag_init( "FlagScrambleCafeJumpStarted" );
    common_scripts\utility::flag_init( "FlagScrambleCafeJumpCompleted" );
    common_scripts\utility::flag_init( "FlagScrambleGetRPG" );
    common_scripts\utility::flag_init( "FlagScramblePlayerFireMissile" );
    common_scripts\utility::flag_init( "FlagScrambleObjSniperPos" );
    common_scripts\utility::flag_init( "FlagScrambleObjGapJumpPos" );
    common_scripts\utility::flag_init( "FlagScrambleObjSuppressSniper" );
    common_scripts\utility::flag_init( "FlagScrambleObjPoolCafePos" );
    common_scripts\utility::flag_init( "FlagScrambleObjWoundedSoldierPos" );
    common_scripts\utility::flag_init( "FlagScrambleObjRPGPos" );
    common_scripts\utility::flag_init( "FlagScrambleObjMoveTruckPos" );
    common_scripts\utility::flag_init( "FlagScrambleObjDestroyTower" );
    common_scripts\utility::flag_init( "FlagScramblePlayerHasStinger" );
    common_scripts\utility::flag_init( "FlagScrambleIlanaStartMoveTruck" );
    common_scripts\utility::flag_init( "FlagScrambleIlanaEndMoveTruck" );
    common_scripts\utility::flag_init( "FlagScramblePlayerStartMoveTruck" );
    common_scripts\utility::flag_init( "FlagScramblePlayerEndMoveTruck" );
    common_scripts\utility::flag_init( "FlagScrambleBeginHothall" );
    common_scripts\utility::flag_init( "FlagScrambleEndHothall" );
    common_scripts\utility::flag_init( "FlagDelayRPGReminderDialogue" );
}

sniperscramblegameskillmultiplier()
{
    var_0 = level.player maps\_utility::get_player_gameskill();
    var_1[0] = 1.25;
    var_1[1] = 1;
    var_1[2] = 0.75;
    var_1[3] = 0.5;
    var_2 = var_1[var_0];

    if ( level.player hasweapon( "iw5_stingerm7greece_sp" ) )
        var_2 *= 0.75;

    return var_2;
}

sniperscrambleglobalvars()
{
    level.showdebugtoggle = 0;
    level.dialogtable = "sp/greece_dialog.csv";
    level.sniperpos = getent( "SniperEnemyPos", "targetname" );
    level.sniperpos.bsniperenabled = 0;
    level.snipertargetent = undefined;
    level.sniperalltargets = getentarray( "SniperTargetPos", "targetname" );
    level.snipervisibletargets = [];
    var_0 = spawnstruct();
    var_0.sniper_fx_base = common_scripts\utility::spawn_tag_origin();
    var_0.sniper_fx_base.origin = level.sniperpos.origin;
    var_0.player_visible_duration = 0;
    var_0.sniper_target_location = undefined;
    var_0.suppression_time = 0;
    var_0.shot_delay = 0;
    var_0.draw_debug = 0;
    var_0.debug_hud_elem = setup_sniper_debug_hud_elem();
    var_0.requires_player_los = 1;
    var_0.sniper_finale = 0;
    var_0.player_in_disable_sniper_volume = 0;
    var_0.minburstfireinterval = 0.8;
    var_0.maxburstfireinterval = 1.6;
    var_0.minburstdelay = 1.5;
    var_0.maxburstdelay = 2.0;
    level.sniper_scramble_data = var_0;
}

sniperscrambleglobalsetup()
{
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    thread sniperscramblebegin();
    thread sniperscrambleobjectivesetup();
    thread maps\greece_code::setdefaulthudoutlinedvars();
}

sniperscramblestartpoints()
{
    maps\_utility::add_start( "start_sniper_scramble_intro", ::initsniperscrambleintro );
    maps\_utility::add_start( "start_sniper_scramble_hotel", ::initsniperscramblehotel );
    maps\_utility::add_start( "start_sniper_scramble_drones", ::initsniperscrambledrones );
    maps\_utility::add_start( "start_sniper_scramble_finale", ::initsniperscramblefinale );
    maps\greece_starts::add_greece_starts( "sniper_scramble" );
}

initsniperscrambleintro()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartScrambleIntro", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartScrambleIntro", 1, 1, "IlanaSniperScramble" );
    thread ilanascrambleinit();
    thread gondolaanimation();
    thread scramblemodifyplayerviewkick();
    thread scramblevisitorcentergateopen();
    common_scripts\utility::flag_set( "FlagSniperScrambleStart" );
    common_scripts\utility::flag_set( "FlagAlleysPipComplete" );
    common_scripts\utility::flag_set( "FlagAlleysIlanaReadyToExit" );
    common_scripts\utility::flag_set( "init_sniper_scramble_finale_lighting" );
    soundscripts\_snd::snd_message( "start_sniper_scramble_intro_checkpoint" );
}

initsniperscramblehotel()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartScrambleHotel", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartScrambleHotel", 1, 1, "IlanaSniperScramble" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyStartScrambleHotelCover" );
    thread scramblesetupexittruck();
    thread torresblood();
    thread sniperscrambleinit();
    snipersettargetent( undefined );
    thread monitorsupersafevol();
    thread updatesnipershooting();
    thread snipershootnearhotelciv();
    thread scramblecivhotel();
    thread scramblecivhothall();
    thread scramblecivpool();
    thread gondolaanimation();
    level.allies["Ilona"] thread ilanascramblemovement();
    level.player thread initsniperscramblesuppressionfeedback();
    thread scramblemodifyplayerviewkick();
    thread scrambledestroycafewall();
    common_scripts\utility::flag_set( "FlagScrambleStartHotel" );
    common_scripts\utility::flag_set( "init_sniper_scramble_hotel_lighting" );
    soundscripts\_snd::snd_message( "start_sniper_scramble_hotel_checkpoint" );
}

initsniperscrambledrones()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartScrambleDrones", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartScrambleDrones", 1, 1, "IlanaSniperScramble" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyStartScrambleDronesCover" );
    thread scramblesetupexittruck();
    thread torresblood();
    thread sniperscrambleinit();
    snipersettargetent( undefined );
    thread monitorsupersafevol();
    thread updatesnipershooting();
    thread scramblecivdrones();
    thread gondolaanimation();
    level.allies["Ilona"] thread ilanascramblemovement();
    level.player thread initsniperscramblesuppressionfeedback();
    thread scramblemodifyplayerviewkick();
    common_scripts\utility::flag_set( "FlagScrambleStartDrones" );
    common_scripts\utility::flag_set( "init_sniper_scramble_drones_lighting" );
    soundscripts\_snd::snd_message( "start_sniper_scramble_drones_checkpoint" );
}

initsniperscramblefinale()
{
    maps\_utility::teleport_player( common_scripts\utility::getstruct( "PlayerStartScrambleFinale", "targetname" ) );
    maps\_hms_utility::setupplayerinventory( "iw5_titan45_sp_opticsreddot_silencerpistol", "iw5_hmr9_sp_variablereddot", "fraggrenade", "flash_grenade", "iw5_hmr9_sp_variablereddot" );
    maps\_variable_grenade::give_player_variable_grenade();
    thread maps\_player_exo::player_exo_activate();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
    {
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
        maps\greece_conf_center_fx::confcenterresidualsmoke();
        maps\greece_safehouse_fx::ambientcloudskill();
    }

    maps\_hms_utility::spawnandinitnamedally( "Ilona", "AllyStartScrambleFinale", 1, 1, "IlanaSniperScramble" );
    thread scramblesetupexittruck();
    thread torresblood();
    thread sniperscrambleinit();
    snipersettargetent( undefined );
    thread monitorsupersafevol();
    thread updatesnipershooting();
    thread scramblefinaleallies();
    thread gondolaanimation();
    thread pitbulldestroyedanimation();
    level.allies["Ilona"] thread ilanascramblemovement();
    level.player thread initsniperscramblesuppressionfeedback();
    thread scramblemodifyplayerviewkick();
    common_scripts\utility::flag_set( "FlagScrambleStartFinale" );
    common_scripts\utility::flag_set( "init_sniper_scramble_finale_lighting" );
    soundscripts\_snd::snd_message( "start_sniper_scramble_finale_checkpoint" );
}

sniperscrambleobjectivesetup()
{
    waittillframeend;
    thread objscramblekillsniper();
    sniperscramblesetcompletedobjflags();
}

sniperscramblesetcompletedobjflags()
{
    var_0 = level.start_point;

    if ( !common_scripts\utility::string_starts_with( var_0, "start_sniper_scramble_" ) )
        return;

    if ( var_0 == "start_sniper_scramble_intro" )
        return;

    common_scripts\utility::flag_set( "FlagScrambleObjSniperPos" );

    if ( var_0 == "start_sniper_scramble_hotel" )
        return;

    if ( var_0 == "start_sniper_scramble_drones" )
        return;

    if ( var_0 == "start_sniper_scramble_finale" )
        return;
}

objscramblekillsniper()
{
    common_scripts\utility::flag_wait( "FlagScrambleObjSniperPos" );
    var_0 = getent( "ScrambleSniperObj", "targetname" );
    thread objscramblegapjump();
    thread objscramblesuppress( var_0 );
    thread objscramblepoolcafe();
    thread objscramblejumpdown();
    thread objscramblefollowilana();
    thread objscramblewoundedsoldier();
    thread objscramblerpg();
    thread objscramblesnipertower( var_0 );
    var_1 = getentarray( "ScrambleSniperWindowTarget", "targetname" );

    for (;;)
    {
        if ( level.player hasweapon( "iw5_stingerm7greece_sp" ) )
            break;

        wait 0.5;
    }

    common_scripts\utility::flag_set( "FlagScrambleObjDestroyTower" );

    foreach ( var_3 in var_1 )
        var_3 hudoutlineenable( 1, 0 );

    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );

    foreach ( var_3 in var_1 )
    {
        var_3 hudoutlinedisable();
        var_3 delete();
    }

    var_7 = getent( "ScrambleSniperWindowTargetBack", "targetname" );
    var_7 delete();
    thread objscramblemovetruck();
}

objscramblegapjump()
{
    common_scripts\utility::flag_wait( "FlagScrambleObjGapJumpPos" );
    var_0 = getent( "ScrambleGapJumpObj", "targetname" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, var_0.origin );
    common_scripts\utility::flag_wait( "FlagScrambleGapJumpStarted" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, ( 0, 0, 0 ) );
}

objscramblesuppress( var_0 )
{
    common_scripts\utility::flag_wait( "FlagScrambleObjSuppressSniper" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SCRAMBLE_SUPPRESS" );
    thread objscramblesuppressdisplay();
    thread objscrambleplayerrunfirst( var_0 );
    common_scripts\utility::flag_wait( "FlagScrambleHotelIlanaReachedGoal" );
    level notify( "EndObjScrambleSuppress" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), "" );
}

objscrambleplayerrunfirst( var_0 )
{
    common_scripts\utility::flag_wait( "FlagScrambleObjPoolCafePos" );
    level notify( "EndObjScrambleSuppress" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), "" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );

    if ( !common_scripts\utility::flag( "FlagScrambleHotelIlanaReachedGoal" ) )
    {
        objective_position( maps\_utility::obj( "InterceptHades" ), var_0.origin );
        objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SCRAMBLE_SUPPRESS" );
        thread objscramblesuppressdisplay();
    }
}

objscramblesuppressdisplay()
{
    level endon( "EndObjScrambleSuppress" );

    for (;;)
    {
        wait 0.1;

        if ( common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) )
        {
            objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), " " );
            continue;
        }

        objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SCRAMBLE_SUPPRESS" );
    }
}

objscramblepoolcafe()
{
    common_scripts\utility::flag_wait( "FlagScrambleObjPoolCafePos" );
    var_0 = getent( "ScramblePoolCafeObj", "targetname" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), "" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, ( 0, 0, 0 ) );
}

objscramblejumpdown()
{
    common_scripts\utility::flag_wait( "FlagScrambleHotelIlanaJumpDown" );
    var_0 = getent( "ScrambleJumpDownObj", "targetname" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, var_0.origin );
    common_scripts\utility::flag_wait( "FlagScrambleCafeJumpStarted" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, ( 0, 0, 0 ) );
}

objscramblefollowilana()
{
    common_scripts\utility::flag_wait( "FlagScrambleDronesAdead" );
    objective_onentity( maps\_utility::obj( "InterceptHades" ), level.allies["Ilona"] );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SAFEHOUSE_FOLLOW" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerAlmostNearWoundedSoldier" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), "" );
}

objscrambledrones()
{
    var_0 = getent( "ScrambleSniperObj", "targetname" );
    common_scripts\utility::flag_wait( "FlagScrambleStartDrones" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "FlagScrambleDronesAdead" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_0.origin );
}

objscramblewoundedsoldier()
{
    common_scripts\utility::flag_wait( "FlagScrambleObjWoundedSoldierPos" );
    var_0 = getent( "ScrambleWoundedSoldierObj", "targetname" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, var_0.origin );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearWoundedSoldier" );
    objective_additionalposition( maps\_utility::obj( "InterceptHades" ), 1, ( 0, 0, 0 ) );
}

objscramblerpg()
{
    common_scripts\utility::flag_wait( "FlagScrambleObjRPGPos" );
    var_0 = getent( "ScrambleRPGObj", "targetname" );
    var_1 = getent( "ScrambleStairs1Obj", "targetname" );
    var_2 = getent( "ScrambleStairs2Obj", "targetname" );
    objective_add( maps\_utility::obj( "InterceptHades" ), "active", &"GREECE_OBJ_SCRAMBLE_ELIMINATE_SNIPER", ( 0, 0, 0 ) );
    objective_current( maps\_utility::obj( "InterceptHades" ) );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_1.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), " " );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerOnStairs" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_2.origin );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearRPG" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SCRAMBLE_PICKUPSTINGER" );
    var_3 = getent( "ScrambleStingerPickup", "targetname" );
    var_3 hudoutlineenable( 3 );
}

objscramblesnipertower( var_0 )
{
    common_scripts\utility::flag_wait( "FlagScrambleObjDestroyTower" );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SCRAMBLE_DESTROY" );
    common_scripts\utility::flag_wait( "FlagScramblePlayerFireMissile" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), "" );
}

objscramblemovetruck()
{
    common_scripts\utility::flag_wait( "FlagScrambleObjMoveTruckPos" );
    var_0 = getent( "ScrambleMoveTruckObj", "targetname" );
    objective_add( maps\_utility::obj( "InterceptHades" ), "active", &"GREECE_OBJ_INTERCEPT_HADES", ( 0, 0, 0 ) );
    objective_current( maps\_utility::obj( "InterceptHades" ) );
    objective_position( maps\_utility::obj( "InterceptHades" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), &"GREECE_OBJ_SCRAMBLE_PUSHTRUCK" );
    var_1 = getent( "ScrambleExitTruck", "targetname" );
    var_1 hudoutlineenable( 3 );
    common_scripts\utility::flag_wait( "FlagScramblePlayerStartMoveTruck" );
    objective_position( maps\_utility::obj( "InterceptHades" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "InterceptHades" ), " " );
    var_1 hudoutlinedisable();
}

sniperscrambleinit()
{
    thread ilanascrambleinit();
    thread snipersetupglass();
    thread monitorphysicschairs();
    thread monitormantlevols();
    level.player thread monitorlastweapon();
    level.player thread stingerpronestatemonitor();

    if ( level.nextgen || istransientloaded( "greece_middle_tr" ) )
        thread scramblestartdoorinit();

    thread scramblemodifyplayerviewkick();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
}

scramblemodifyplayerviewkick()
{
    var_0 = level.player getviewkickscale();
    level.player setviewkickscale( 0.15 );
    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
    level.player setviewkickscale( var_0 );
    killfxontag( common_scripts\utility::getfx( "railgun_sniper_glint" ), level.sniper_scramble_data.sniper_fx_base, "tag_origin" );
}

sniperscramblebegin()
{
    common_scripts\utility::flag_wait( "FlagSniperScrambleStart" );
    thread sniperscrambleinit();
    thread scrambledestroycafewall();
    level.player thread initsniperscramblesuppressionfeedback();
    thread sniperintro();
    thread scrambleplayergapjump();
    thread scramblesetupexittruck();
    thread torresblood();
    thread gondolaanimation();

    if ( !isdefined( level.map_without_loadout ) || level.map_without_loadout == 0 )
        thread maps\greece_code::blimp_animation( "blimpOrg", "market_intro_blimp" );
}

sniperintro()
{
    common_scripts\utility::flag_set( "FlagScrambleStartIntro" );
    thread scramblecivpatio();
    thread ilanascrambleopenstartdoor();
    thread snipershootintrodoor();
    thread snipershootfirstcivilian();
}

snipershootintrodoor()
{
    level.sniperpos.bsniperenabled = 0;
    level waittill( "ScrambleSniperFireFirstShot" );
    var_0 = common_scripts\utility::getstruct( "SniperFirstTargetPos", "script_noteworthy" );
    snipershoot( var_0.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_0.origin );
    level waittill( "ScrambleSniperFireSecondShot" );
    var_1 = common_scripts\utility::getstruct( "SniperSecondTargetPos", "script_noteworthy" );
    snipershoot( var_1.origin, 1.25, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_1.origin );
    level waittill( "ScrambleSniperFireThirdShot" );
    var_2 = common_scripts\utility::getstruct( "SniperThirdTargetPos", "script_noteworthy" );
    snipershoot( var_2.origin, 1.25, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_2.origin );
}

snipershoothothall()
{
    level.sniperpos.bsniperenabled = 0;
    level waittill( "hothall_sniper_shot" );
    var_0 = common_scripts\utility::getstruct( "HothallSniperTarget1", "script_noteworthy" );
    snipershoot( var_0.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_0.origin );
    level waittill( "hothall_sniper_shot" );
    var_1 = maps\_utility::get_living_ai( "HothallSniperTarget2", "script_noteworthy" );
    var_2 = var_1 snipertargetgettagpos();
    snipershoot( var_2, 1.25, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_1.origin );
    level waittill( "hothall_sniper_shot" );
    var_3 = common_scripts\utility::getstruct( "HothallSniperTarget1", "script_noteworthy" );
    snipershoot( var_3.origin, 1.25, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_3.origin );
    level waittill( "hothall_sniper_shot" );
    var_4 = maps\_utility::get_living_ai( "HothallSniperTarget4", "script_noteworthy" );
    var_5 = var_4 snipertargetgettagpos();
    snipershoot( var_5, 1.25, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_4.origin );
    level.sniperpos.bsniperenabled = 1;
}

updatescopeglintwarning()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = 2;
    var_4 = var_3 * 2;
    var_5 = 10;
    var_6 = var_5 / 2;
    var_7 = level.player geteye();

    for (;;)
    {
        wait 0.05;

        if ( level.sniper_scramble_data.player_visible_duration <= 0 )
        {
            if ( var_0 )
            {
                killfxontag( common_scripts\utility::getfx( "railgun_sniper_glint" ), level.sniper_scramble_data.sniper_fx_base, "tag_origin" );
                var_0 = 0;
            }

            continue;
        }

        if ( !var_0 )
        {
            playfxontag( common_scripts\utility::getfx( "railgun_sniper_glint" ), level.sniper_scramble_data.sniper_fx_base, "tag_origin" );
            var_0 = 1;
            var_8 = level.player.origin - level.sniperpos.origin;
            level.sniper_scramble_data.sniper_fx_base.angles = vectortoangles( var_8 );
        }

        var_1 += var_3;
        var_1 = common_scripts\utility::mod( var_1, 360 + var_3 );
        var_9 = sin( var_1 );
        var_2 += var_4;
        var_2 = common_scripts\utility::mod( var_2, 360 + var_4 );
        var_10 = sin( var_2 );
        var_11 = vectorcross( vectornormalize( level.player geteye() - level.sniperpos.origin ), ( 0, 0, 1 ) );
        var_12 = var_11 * var_9 * var_5;
        var_12 = ( var_12[0], var_12[1], var_10 * var_6 );
        var_7 = vectorlerp( var_7, level.player geteye() + var_12, 0.5 );
        var_13 = var_7 - level.sniperpos.origin;
        level.sniper_scramble_data.sniper_fx_base.angles = vectortoangles( var_13 );
    }
}

snipershoot( var_0, var_1, var_2 )
{
    level endon( "ScrambleSniperKilled" );

    if ( !isdefined( var_1 ) )
        var_1 = 1.0;

    if ( isdefined( var_2 ) && level.sniper_scramble_data.shot_delay < 2 )
        level.sniper_scramble_data.shot_delay = 2;

    var_3 = level.sniperpos.origin;
    var_4 = vectornormalize( var_0 - var_3 );
    playfx( common_scripts\utility::getfx( "railgun_sniper_tracer" ), var_3, var_4, ( 0, 0, 1 ) );
    magicbullet( "hms_rail_sniper", var_3, var_0 );
    thread snipernearshotshake( var_0, var_1 );
    level.sniperpos.lastshottime = gettime();

    if ( level.sniper_scramble_data.draw_debug == 1 )
    {
        thread common_scripts\utility::draw_line_for_time( level.sniperpos.origin, var_0, 1, 1, 1, 0.5 );
        thread maps\_utility::draw_circle_for_time( var_0, 32, 1, 0, 0, 1.0 );
    }
}

snipernearshotshake( var_0, var_1 )
{
    wait 0.05;

    if ( !isdefined( var_1 ) )
        var_1 = 1.0;

    var_2 = vectorfromlinetopoint( level.sniperpos.origin, var_0, level.player.origin );
    var_3 = length( var_2 );

    if ( var_3 > 500 * var_1 )
        return;

    var_4 = 100 * var_1;
    var_5 = 200 * var_1;
    var_6 = undefined;
    var_7 = undefined;

    if ( var_3 <= var_4 )
    {
        level.player playrumbleonentity( "damage_light" );
        var_6 = randomfloatrange( 0.4, 0.5 ) * var_1;
        var_7 = randomfloatrange( 0.6, 0.8 );
        thread maps\_utility::dirt_on_screen_from_position( var_0 );
    }
    else if ( var_3 <= var_5 )
    {
        level.player playrumbleonentity( "damage_light" );
        var_6 = randomfloatrange( 0.2, 0.4 ) * var_1;
        var_7 = randomfloatrange( 0.4, 0.6 );
    }
    else
    {
        var_6 = randomfloatrange( 0.1, 0.3 ) * var_1;
        var_7 = randomfloatrange( 0.2, 0.4 );
    }

    earthquake( var_6, var_7, level.player.origin, 100 );
}

updatesnipersuppression()
{
    level endon( "ScrambleSniperKilled" );
    var_0 = getent( "ScrambleSniperWindow", "targetname" );
    var_0 thread monitorsnipertowersuppressiondamage();
    thread updatesuppressionduration( var_0 );

    while ( isdefined( var_0 ) )
    {
        var_0 waittill( "bullethit" );
        level.sniper_scramble_data.suppression_time = 4.0;
        wait 0.05;
    }
}

updatesuppressionduration( var_0 )
{
    level endon( "ScrambleSniperKilled" );
    var_1 = 0;

    while ( isdefined( var_0 ) )
    {
        wait 0.05;

        if ( level.sniper_scramble_data.suppression_time > 0 )
        {
            if ( !var_1 )
            {
                var_1 = 1;
                level notify( "ScrambleSniperSuppressed" );
                common_scripts\utility::flag_set( "FlagScrambleSniperSuppressed" );
            }

            level.sniper_scramble_data.suppression_time -= 0.05;
            continue;
        }

        if ( var_1 )
        {
            var_1 = 0;
            common_scripts\utility::flag_clear( "FlagScrambleSniperSuppressed" );
        }
    }
}

sniperissuppressed()
{
    return level.sniper_scramble_data.suppression_time > 0;
}

snipersettargetent( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        level notify( "StopSniperTargetSearch" );
        level.snipertargetent = var_0;
        return;
    }

    thread updatesnipertargeting();
}

updatesnipershooting()
{
    childthread updatesnipersuppression();
    childthread updatescopeglintwarning();
    level.sniperpos.bsniperenabled = 1;

    while ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        wait 0.05;

        if ( isshotdelayed() || !shouldfireattarget() )
            continue;

        var_1 = snipergettargetpos();
        soundscripts\_snd::snd_message( "windmill_sniper_shot_multi", var_1 );
        snipershoot( var_1 );
        var_2 = randomfloatrange( level.sniper_scramble_data.minburstdelay, level.sniper_scramble_data.maxburstdelay );

        if ( isdefined( level.snipertargetent ) && isplayer( level.snipertargetent ) )
            var_2 *= sniperscramblegameskillmultiplier();

        wait(var_2);
    }
}

isshotdelayed()
{
    if ( sniperissuppressed() )
        return 1;

    if ( level.sniperpos.bsniperenabled == 0 )
        return 1;

    return level.sniper_scramble_data.shot_delay > 0;
}

shouldfireattarget()
{
    if ( level.sniper_scramble_data.player_in_disable_sniper_volume )
        return 0;

    if ( sniperissuppressed() )
        return 0;

    if ( level.sniperpos.bsniperenabled == 0 )
        return 0;

    return isdefined( level.snipertargetent ) || isdefined( level.sniper_scramble_data.sniper_target_location );
}

snipergettargetpos()
{
    if ( isdefined( level.snipertargetent ) )
        return getentitytargetlocationwithspread( level.snipertargetent );

    return level.sniper_scramble_data.sniper_target_location;
}

calculate_lateral_move_accuracy( var_0 )
{
    var_1 = ( var_0.origin - level.sniperpos.origin ) * ( 1, 1, 0 );
    var_1 = vectornormalize( var_1 );
    var_1 = ( var_1[1], var_1[0] * -1, 0 );
    var_2 = abs( vectordot( var_1, var_0 getvelocity() ) );
    var_2 = clamp( var_2, 0, 250 ) / 250;
    var_2 = 1 - var_2;
    var_2 = clamp( var_2, 0.3, 1 );
    return var_2;
}

calculate_stance_accuracy( var_0 )
{
    if ( var_0 getstance() == "crouch" )
        return 0.75;
    else if ( var_0 getstance() == "prone" )
        return 0.5;

    return 1;
}

calculate_sprinting_jumping_accuracy( var_0 )
{
    if ( var_0 issprinting() || var_0 isjumping() )
        return 0.5;

    return 1;
}

getentitytargetlocationwithspread( var_0 )
{
    var_1 = var_0 geteye();
    var_2 = var_0 geteye() - var_0.origin;
    var_3 = ( 0, 0, var_2[2] * 0.85 );
    var_4 = 0.3;
    var_5 = var_0.origin - level.sniperpos.origin;
    var_5 *= ( 1, 1, 0 );
    var_5 = vectornormalize( var_5 );

    if ( isplayer( var_0 ) )
    {
        var_4 = 1;

        if ( level.sniper_scramble_data.sniper_finale )
        {
            var_4 *= calculate_lateral_move_accuracy( level.player );
            var_4 *= calculate_stance_accuracy( level.player );
            var_4 *= calculate_sprinting_jumping_accuracy( level.player );

            if ( level.player hasweapon( "iw5_stingerm7greece_sp" ) )
            {
                var_4 *= 0.5;
                var_4 = clamp( var_4, 0.5, 1 );
            }
        }
    }

    var_6 = vectorcross( ( 0, 0, 1 ), var_5 );
    var_7 = var_6 * 8 / var_4 * randomfloatrange( -1, 1 );
    var_8 = ( 0, 0, 4 ) / var_4 * randomfloatrange( -1, 1 );
    var_9 = var_7 + var_8;
    var_10 = var_0.origin + var_3 + var_9;
    return var_10;
}

targetinsafevolume( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        if ( var_3.bisactivated == 1 && var_0 istouching( var_3 ) )
            return 1;
    }

    return 0;
}

updatesnipertargeting()
{
    level notify( "UpdateSniperTargeting" );
    level endon( "UpdateSniperTargeting" );
    var_0 = getentarray( "TriggerScrambleSafeVol", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.bisactivated = 1;

    for (;;)
    {
        wait 0.05;
        level.sniper_scramble_data.shot_delay -= 0.05;
        level.sniper_scramble_data.shot_delay = max( level.sniper_scramble_data.shot_delay, 0 );

        if ( !common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) && updatesnipertargetentitylocation( var_0 ) )
            continue;

        level.snipertargetent = undefined;
        level.sniper_scramble_data.player_visible_duration = 0;
        updatesnipertargetlocation();
    }
}

updatesnipertargetentitylocation( var_0 )
{
    var_1 = undefined;

    if ( level.sniper_scramble_data.requires_player_los && !level.player ismantling() && !targetinsafevolume( level.player, var_0 ) )
        var_1 = bullettrace( level.sniperpos.origin, level.player geteye(), 0, level.player, 0, 0, 0, 0, 0 );

    if ( isdefined( var_1 ) && var_1["fraction"] == 1 || !level.sniper_scramble_data.requires_player_los )
    {
        level.sniper_scramble_data.player_visible_duration += 0.05;

        if ( level.sniper_scramble_data.player_visible_duration < 2.0 )
            return 1;

        level.snipertargetent = level.player;
        return 1;
    }

    var_1 = undefined;

    if ( !targetinsafevolume( level.allies["Ilona"], var_0 ) )
        var_1 = bullettrace( level.sniperpos.origin, level.player geteye(), 0, level.allies["Ilona"], 0, 0, 0, 0, 0 );

    if ( isdefined( var_1 ) && var_1["fraction"] == 1 )
    {
        level.snipertargetent = level.allies["Ilona"];
        level.sniper_scramble_data.player_visible_duration = 0;
        return 1;
    }

    return 0;
}

updatesnipertargetlocation()
{
    var_0 = 48;
    var_1 = 216;
    var_2 = 2000;

    if ( findsnipertargetnearactor( var_1, var_2 ) )
        return;

    if ( findrandomlocationneartarget( var_0, var_1 ) )
        return;

    level.sniper_scramble_data.sniper_target_location = undefined;
}

findsnipertargetnearactor( var_0, var_1 )
{
    var_2 = squared( var_0 );
    level.sniperalltargets = maps\_utility::array_removedead_or_dying( level.sniperalltargets );

    foreach ( var_4 in level.sniperalltargets )
    {
        if ( isdefined( var_4.lasttime ) && gettime() - var_4.lasttime < var_1 )
            continue;

        if ( distance2dsquared( level.player.origin, var_4.origin ) > var_2 )
            continue;

        if ( level.player maps\_utility::point_in_fov( var_4.origin ) == 0 )
            continue;

        if ( isai( var_4 ) )
        {
            var_4.lasttime = gettime();
            var_5 = var_4 snipertargetgettagpos();
        }
        else
            var_5 = var_4.origin;

        level.sniper_scramble_data.sniper_target_location = var_5;
        return 1;
    }

    return 0;
}

findrandomlocationneartarget( var_0, var_1 )
{
    var_2 = level.player;

    if ( isdefined( level.snipertargetent ) )
        var_2 = level.snipertargetent;

    for ( var_3 = 0; var_3 <= 5; var_3++ )
    {
        if ( common_scripts\utility::cointoss() )
        {
            var_4 = ( var_2.angles[0], var_2.angles[1] + randomintrange( -45, 45 ), var_2.angles[2] );
            var_5 = anglestoforward( var_4 );
            var_6 = var_2.origin + var_5 * randomfloatrange( var_0, var_1 );

            if ( !bullettracepassed( level.sniperpos.origin, var_6, 0, undefined ) )
                continue;
        }
        else
        {
            var_4 = ( var_2.angles[0], var_2.angles[1] + randomintrange( -15, 15 ), var_2.angles[2] + randomintrange( -45, 45 ) );
            var_7 = anglestoright( var_4 );

            if ( common_scripts\utility::cointoss() )
                var_6 = var_2 geteye() + var_7 * randomfloatrange( var_0, var_1 );
            else
                var_6 = var_2 geteye() - var_7 * randomfloatrange( var_0, var_1 );
        }

        level.sniper_scramble_data.sniper_target_location = var_6;
        return 1;
    }

    return 0;
}

setup_sniper_debug_hud_elem()
{
    var_0 = newhudelem();
    var_0.alignx = "left";
    var_0.aligny = "top";
    var_0.x = 40;
    var_0.y = 40;
    var_0.alpha = 0.6;
    var_0.fontscale = 1.5;
    var_0.foreground = 1;
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    return var_0;
}

snipersetupglass()
{
    level endon( "ScrambleSniperKilled" );
    var_0 = getentarray( "ScrambleGlassTrigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread sniperdestroyglass();
}

sniperdestroyglass()
{
    level endon( "ScrambleSniperKilled" );
    self waittill( "trigger" );
    glassradiusdamage( self.origin, 48, 1000, 1000 );
}

snipershootfirstcivilian()
{
    level waittill( "ScramblePatioCivShot" );
    var_0 = maps\_utility::get_living_ai( "PatioFlee01", "script_noteworthy" );

    if ( isdefined( var_0 ) )
    {
        var_1 = var_0 geteye();
        soundscripts\_snd::snd_message( "windmill_sniper_shot", var_1 );
        thread snipershoot( var_1, 1.0, 1 );
        playfx( common_scripts\utility::getfx( "scramble_blood_impact_splat" ), var_1 );
    }

    wait 1;
    level.sniperpos.bsniperenabled = 1;
    snipersettargetent( undefined );
    thread monitorsupersafevol();
    thread updatesnipershooting();
}

snipershootcafewall()
{
    var_0 = common_scripts\utility::getstruct( "ShootCafeWallOrg", "targetname" );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_0.origin );
    soundscripts\_snd::snd_message( "mhunt_snpr_dest_cafe_wall", var_0 );
    thread snipershoot( var_0.origin, 1.5, 1 );
    thread maps\greece_sniper_scramble_fx::snipercafewallburstfx();
    wait 0.45;
    physicsexplosionsphere( var_0.origin, 100, 10, 0.5 );
}

snipershootilana()
{
    level.sniperpos.bsniperenabled = 0;
    level waittill( "ScrambleRestaurantIlanaShot" );
    var_0 = common_scripts\utility::getstruct( "ScrambleIlanaTarget1", "targetname" );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_0.origin );
    thread snipershoot( var_0.origin, 1.0, 1 );
    level waittill( "ScrambleRestaurantIlanaShot" );
    wait 0.2;
    var_1 = common_scripts\utility::getstruct( "ScrambleIlanaTarget2", "targetname" );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_1.origin );
    thread snipershoot( var_1.origin, 1.0, 1 );
    level waittill( "ScrambleRestaurantCivShot" );
    var_2 = maps\_utility::get_living_ai( "ScrambleCivRestaurantDoorOpener_AI", "targetname" );

    if ( isdefined( var_2 ) )
    {
        var_3 = var_2 gettagorigin( "J_Spine4" );
        soundscripts\_snd::snd_message( "windmill_sniper_shot", var_3 );
        thread snipershoot( var_3, 1.0, 1 );
        playfx( common_scripts\utility::getfx( "scramble_blood_impact_splat" ), var_3 );
        soundscripts\_snd::snd_message( "restaurant_door_civ_killed", var_2 );
    }

    level.sniperpos.bsniperenabled = 1;
    snipersettargetent( level.player );
}

openrestaurantdoor( var_0 )
{
    self rotateto( self.angles + ( 0, var_0, 0 ), 0.35, 0, 0.35 );
    earthquake( 0.25, 0.2, self.origin, 256 );
}

snipershootrestaurantfishtank()
{
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerInRestaurant" );
    level.sniperpos.bsniperenabled = 0;
    snipersettargetent( undefined );
    maps\_utility::trigger_wait_targetname( "TrigFishTankDestruction" );
    level.player allowsprint( 0 );
    level.player allowdodge( 0 );
    var_0 = getent( "ScrambleFishTankShootOrg", "script_noteworthy" );
    soundscripts\_snd::snd_message( "restaurant_fish_tank_destruct", var_0 );
    thread snipershoot( var_0.origin, 1.5, 1 );
    common_scripts\utility::flag_set( "FlagScrambleDestroyFishTank" );
    maps\_hms_utility::printlnscreenandconsole( "FFFFFIIIIIIISSSSSSSHHHHHHHH!!!!" );
    wait 1.0;
    level.sniperpos.bsniperenabled = 1;
    snipersettargetent( undefined );
    thread monitorrestaurantglassfrenzyvol();
}

snipershootnearhotelciv()
{
    level.sniperpos.bsniperenabled = 0;
    wait 1;
    var_0 = getent( "ScrambleHotelNearCiv", "script_noteworthy" );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_0.origin );
    thread snipershoot( var_0.origin, 1.5, 1 );
}

snipershootstingerpot()
{
    maps\_utility::trigger_wait_targetname( "FinaleAlly02Trig" );
    wait 1.0;
    var_0 = common_scripts\utility::getstruct( "SniperStingerTargetPos", "targetname" );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_0.origin );
    thread snipershoot( var_0.origin, 1.5, 1 );
    physicsexplosionsphere( var_0.origin, 100, 10, 0.5 );
}

monitorplayerapproachfishtank()
{
    var_0 = getent( "ScrambleFishTankLookAtOrg", "script_noteworthy" );
    var_1 = getent( "TrigFishTankDestruction", "targetname" );

    for (;;)
    {
        waitframe();

        if ( maps\_utility::players_within_distance( 300, var_0.origin ) && maps\_utility::within_fov_of_players( var_0.origin, cos( 120 ) ) )
            return 1;

        if ( level.player istouching( var_1 ) )
            return 0;
    }
}

scrambleplayerfishtankstumble()
{
    var_0 = getent( "ScrambleFishTankLookAtOrg", "script_noteworthy" );
    var_1 = vectortoangles( var_0.origin - level.player.origin );
    var_2 = "fishtank_stumble";
    var_3 = maps\_utility::spawn_anim_model( "player_scramble_rig", level.player.origin, level.player.angles );
    var_3 hide();
    level.player thread maps\_shg_utility::setup_player_for_scene();
    level.player setmovespeedscale( 0.5 );
    var_3 linkto( level.player );
    var_3 show();
    level.player maps\_anim::anim_single_solo( var_3, var_2 );
    var_3 unlink();
    var_3 delete();
    level.player allowprone( 1 );
    level.player allowcrouch( 1 );
    level.player allowstand( 1 );
    level.player enableoffhandweapons();
    level.player enableweapons();
    level.player allowmelee( 1 );
    level.player maps\_utility::blend_movespeedscale( 0.8, 2.0 );
    wait 3.0;
    level.player allowdodge( 1 );
    level.player allowsprint( 1 );
    level.player maps\_utility::blend_movespeedscale_default( 2.0 );
}

spawnrestaurantfishswimming()
{
    var_0 = getent( "restaurant_fish_org", "targetname" );
    var_1 = getent( "restaurant_fish_tank_glass", "targetname" );
    var_2 = getent( "restaurant_fish_org", "targetname" );
    var_3 = getent( "restaurant_fish_tank_glass", "targetname" );
    var_4 = maps\_utility::spawn_anim_model( "fish_a_01" );
    var_5 = maps\_utility::spawn_anim_model( "fish_a_02" );
    var_6 = maps\_utility::spawn_anim_model( "fish_a_03" );
    var_7 = maps\_utility::spawn_anim_model( "fish_a_04" );
    var_8 = maps\_utility::spawn_anim_model( "fish_a_05" );
    var_9 = maps\_utility::spawn_anim_model( "fish_a_06" );
    level.fish_a = [ var_4, var_5, var_6, var_7, var_8, var_9 ];
    var_10 = maps\_utility::spawn_anim_model( "fish_b_01" );
    var_11 = maps\_utility::spawn_anim_model( "fish_b_02" );
    var_12 = maps\_utility::spawn_anim_model( "fish_b_03" );
    level.fish_b = [ var_10, var_11, var_12 ];
    var_13 = common_scripts\utility::array_combine( level.fish_a, level.fish_b );
    var_0 thread maps\_anim::anim_loop( level.fish_a, "fish_a_swimming" );
    var_0 thread maps\_anim::anim_loop( level.fish_b, "fish_b_swimming" );
    thread maps\greece_sniper_scramble_fx::fishbubblesfx();
    common_scripts\utility::flag_wait( "FlagScrambleDestroyFishTank" );
    maps\_hms_utility::printlnscreenandconsole( "Fish Tank Destruction triggered! =D" );
    var_3 delete();
    thread maps\greece_sniper_scramble_fx::killfishbubblesfx();
    playfx( level._effect["restaurant_fish_tank_water_splash"], var_2.origin );
    var_14 = common_scripts\utility::getstruct( "fishfall_01_org", "targetname" );
    var_15 = common_scripts\utility::getstruct( "fishfall_02_org", "targetname" );
    var_16 = common_scripts\utility::getstruct( "fishfall_03_org", "targetname" );
    var_17 = common_scripts\utility::getstruct( "fishfall_04_org", "targetname" );
    var_18 = common_scripts\utility::getstruct( "fishfall_05_org", "targetname" );
    var_19 = common_scripts\utility::getstruct( "fishfall_06_org", "targetname" );
    var_20 = common_scripts\utility::getstruct( "fishfall_07_org", "targetname" );
    var_21 = common_scripts\utility::getstruct( "fishfall_08_org", "targetname" );
    var_22 = common_scripts\utility::getstruct( "fishfall_09_org", "targetname" );
    var_14 thread maps\_anim::anim_single_solo( var_4, "fish_falling" );
    var_15 thread maps\_anim::anim_single_solo( var_5, "fish_falling" );
    var_16 thread maps\_anim::anim_single_solo( var_6, "fish_falling" );
    var_17 thread maps\_anim::anim_single_solo( var_7, "fish_falling" );
    var_18 thread maps\_anim::anim_single_solo( var_8, "fish_falling" );
    var_19 thread maps\_anim::anim_single_solo( var_9, "fish_falling" );
    var_20 thread maps\_anim::anim_single_solo( var_10, "fish_falling" );
    var_21 thread maps\_anim::anim_single_solo( var_11, "fish_falling" );
    var_22 thread maps\_anim::anim_single_solo( var_12, "fish_falling" );
    thread fish_animloop( var_4, "fish_deathflop_a", level.fish_a );
    thread fish_animloop( var_10, "fish_deathflop_b", level.fish_b );
}

fish_animloop( var_0, var_1, var_2 )
{
    var_3 = var_0 maps\_utility::getanim( var_1 )[0];
    var_4 = getanimlength( var_3 );

    for (;;)
    {
        for ( var_5 = 0; var_5 < var_2.size; var_5++ )
        {
            wait(randomfloatrange( 0.1, 1 ));
            var_2[var_5] setanimrestart( var_3 );
        }

        wait(var_4);
    }
}

snipershootwoundedsoldier()
{
    var_0 = maps\_utility::get_living_ai( "FinaleAlly01", "script_noteworthy" );
    level.sniperpos.bsniperenabled = 0;
    level waittill( "ScrambleSniperShootWoundedSoldier" );

    if ( isdefined( var_0 ) )
    {
        var_1 = var_0 snipertargetgettagpos();
        soundscripts\_snd::snd_message( "windmill_sniper_shot", var_1 );
        thread snipershoot( var_1, 1.5, 1 );
        wait 0.05;
        var_2 = var_0 gettagorigin( "TAG_EYE" );
        playfx( common_scripts\utility::getfx( "scramble_blood_impact_splat" ), var_2 );
    }

    common_scripts\utility::flag_set( "FlagScrambleWoundedSoldierKilled" );
    wait 1.0;
    level.sniperpos.bsniperenabled = 1;
    thread scramblerestaurantexitclip( 0 );
    level.player allowdodge( 1 );
    level.player allowsprint( 1 );
}

scramblegapjumpslomo()
{
    wait 0.85;
    setslowmotion( 1.0, 0.2, 0.5 );
    wait 0.4;
    setslowmotion( 0.2, 1.0, 0.3 );
}

snipershootgapjump()
{
    level.sniperpos.bsniperenabled = 0;
    level waittill( "ScrambleSniperShootGapJump" );
    var_0 = common_scripts\utility::getstruct( "ScrambleGapJumpTarget1", "targetname" );
    snipershoot( var_0.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_0.origin );
    level waittill( "ScrambleSniperShootGapJump" );
    var_1 = common_scripts\utility::getstruct( "ScrambleGapJumpTarget2", "targetname" );
    snipershoot( var_1.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_1.origin );
    level waittill( "ScrambleSniperShootGapJump" );
    var_2 = common_scripts\utility::getstruct( "ScrambleGapJumpTarget3", "targetname" );
    snipershoot( var_2.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_2.origin );
    common_scripts\utility::flag_wait( "FlagScrambleGapJumpCompleted" );
    thread snipershootnearhotelciv();
}

snipershoothoteljump( var_0 )
{
    level.sniperpos.bsniperenabled = 0;
    var_1 = "_right";

    if ( var_0 == 1 )
        var_1 = "_left";

    level waittill( "ScrambleSniperShootHotelJump" );
    var_2 = "HotelJumpSniperTarget1" + var_1;
    var_3 = common_scripts\utility::getstruct( var_2, "targetname" );
    snipershoot( var_3.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_3.origin );
    level waittill( "ScrambleSniperShootHotelJump" );
    var_4 = "HotelJumpSniperTarget2" + var_1;
    var_5 = common_scripts\utility::getstruct( var_4, "targetname" );
    snipershoot( var_5.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_5.origin );
    wait 1.0;
    level.sniperpos.bsniperenabled = 1;
}

snipershootcafejump( var_0 )
{
    level.sniperpos.bsniperenabled = 0;
    var_1 = "_right";

    if ( var_0 == 1 )
        var_1 = "_left";

    level waittill( "ScrambleSniperShootCafeJump" );
    var_2 = "CafeJumpSniperTarget1" + var_1;
    var_3 = common_scripts\utility::getstruct( var_2, "targetname" );
    snipershoot( var_3.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_3.origin );
    level waittill( "ScrambleSniperShootCafeJump" );
    var_4 = "CafeJumpSniperTarget2" + var_1;
    var_5 = common_scripts\utility::getstruct( var_4, "targetname" );
    snipershoot( var_5.origin, 1.5, 1 );
    soundscripts\_snd::snd_message( "windmill_sniper_shot", var_5.origin );
}

ilanascrambleinit()
{
    var_0 = level.allies["Ilona"];
    var_0 maps\_utility::enable_bulletwhizbyreaction();
    var_0 maps\_utility::enable_pain();
    common_scripts\utility::flag_set( "init_sniper_scramble_lighting" );
    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
}

ilanascrambleopenstartdoor()
{
    var_0 = common_scripts\utility::getstruct( "SniperScrambleStartDoorOrg", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.allies["Ilona"], "scramble_intro_door_in" );
    var_0 maps\_anim::anim_single_solo( level.allies["Ilona"], "scramble_intro_door_in" );
    var_0 thread maps\_anim::anim_loop_solo( level.allies["Ilona"], "scramble_intro_door_loop", "ScrambleIlanaOpenIntroDoor" );
    common_scripts\utility::flag_wait( "FlagScrambleIlanaBeginOpenIntroDoor" );
    soundscripts\_snd::snd_message( "stop_alleys_emergency_audio" );
    var_0 notify( "ScrambleIlanaOpenIntroDoor" );
    wait 0.05;
    thread maps\_utility::autosave_by_name( "scramble_intro_start" );
    thread ilanasmokescreen( var_0 );
    var_1 = getent( "ScrambleIntroDoor", "targetname" );
    var_2 = getent( "ScrambleIntroDoorClip", "targetname" );
    thread scramblestartdoorshots( var_1 );
    var_0 thread maps\_anim::anim_single_solo( var_1, "scramble_intro_door_out" );
    var_0 maps\_anim::anim_single_solo_run( level.allies["Ilona"], "scramble_intro_door_out" );
    var_2 delete();
    common_scripts\utility::flag_set( "FlagScrambleIlanaEndOpenIntroDoor" );
    level notify( "ScrambleSniperShootFirstCivilian" );
    level.allies["Ilona"] thread ilanascramblemovement();
}

scramblestartdoorshots( var_0 )
{
    level waittill( "ScrambleSniperFireFirstShot" );
    var_0 showpart( "tag_destroyed1", "greece_door_interior" );
    var_0 showpart( "tag_door_handle_destroyed1", "greece_door_interior" );
    var_0 showpart( "tag_door_handle_base_destroyed1", "greece_door_interior" );
    var_0 hidepart( "tag_intact", "greece_door_interior" );
    var_0 hidepart( "tag_door_handle", "greece_door_interior" );
    level waittill( "ScrambleSniperFireSecondShot" );
    var_0 hidepart( "tag_door_handle_destroyed1", "greece_door_interior" );
    var_0 hidepart( "tag_door_handle_base_destroyed1", "greece_door_interior" );
    var_0 hidepart( "tag_destroyed1", "greece_door_interior" );
    var_0 showpart( "tag_destroyed2", "greece_door_interior" );
    var_0 showpart( "tag_door_handle_base_destroyed2", "greece_door_interior" );
    var_0 showpart( "tag_door_handle_destroyed2", "greece_door_interior" );
}

scramblestartdoorinit()
{
    var_0 = getent( "ScrambleIntroDoor", "targetname" );
    var_0.animname = "sniper_intro_door";
    var_0 maps\_utility::assign_animtree( "sniper_intro_door" );
    var_1 = common_scripts\utility::getstruct( "SniperScrambleStartDoorOrg", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "scramble_intro_door_out" );
    var_0 hidepart( "tag_destroyed1", "greece_door_interior" );
    var_0 hidepart( "tag_door_handle_destroyed1", "greece_door_interior" );
    var_0 hidepart( "tag_door_handle_base_destroyed1", "greece_door_interior" );
    var_0 hidepart( "tag_destroyed2", "greece_door_interior" );
    var_0 hidepart( "tag_door_handle_destroyed2", "greece_door_interior" );
    var_0 hidepart( "tag_door_handle_base_destroyed2", "greece_door_interior" );
}

ilanasmokescreen( var_0 )
{
    var_1 = maps\_utility::spawn_anim_model( "smoke_grenade" );
    var_0 maps\_anim::anim_single_solo( var_1, "scramble_intro_door_out" );
    var_1 delete();
    var_2 = common_scripts\utility::getstruct( "ScrambleSmokeScreenOrg", "targetname" );
    playfx( common_scripts\utility::getfx( "smoke_screen" ), var_2.origin );
    thread maps\greece_sniper_scramble_fx::smokescreenemitterfx();
    var_3 = getent( "ScrambleSmokeSafeVol", "script_noteworthy" );
    var_3.bisactivated = 1;
    wait 15.0;
    var_3.bisactivated = 0;
}

ilanatogglesnipersuppression( var_0 )
{
    var_1 = getent( "ScrambleSniperWindow", "targetname" );

    if ( var_0 == 1 )
        level.allies["Ilona"] setentitytarget( var_1 );
    else
    {
        level.allies["Ilona"] clearentitytarget( var_1 );
        level notify( "StopIlanaSuppression" );
    }
}

ilanasuppresspos( var_0 )
{
    level endon( "StopIlanaSuppression" );

    for (;;)
    {
        magicbullet( "iw5_hmr9_sp", level.allies["Ilona"] geteye(), var_0.origin );
        wait(randomfloatrange( 0.1, 0.5 ));
    }
}

ilanascramblemovement()
{
    var_0 = level.start_point;
    maps\_hms_ai_utility::playerleashdisable();
    maps\_utility::set_battlechatter( 0 );
    self.oldgrenadeammo = self.grenadeammo;
    self.grenadeammo = 0;
    maps\_utility::set_force_color( "g" );
    wait 0.05;

    if ( var_0 == "start_sniper_scramble_hotel" )
    {
        maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigThird" );
        thread ilanascramblehotel();
    }
    else if ( var_0 == "start_sniper_scramble_drones" )
    {
        maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigSixth" );
        thread ilanascrambledrones();
    }
    else if ( var_0 == "start_sniper_scramble_finale" )
    {
        maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigEleventh" );
        thread ilanascramblefinale();
    }
    else
    {
        maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigFirst" );
        thread ilanascrambleintro();
    }
}

ilanascrambleintro()
{
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerExitAlleys" );
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigSecond" );
    common_scripts\utility::flag_wait( "FlagScrambleGapJumpCompleted" );
    thread ilanascramblehotel();
}

ilanascramblehotel()
{
    thread monitorslidesafevol();
    thread scrambleplayerhoteljump();
    level.sniperpos.bsniperenabled = 0;
    level.player allowsprint( 0 );
    level.player allowdodge( 0 );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerMovingThroughHotel" );
    var_0 = getent( "hothall_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.allies["Ilona"], "scram_hothall" );
    common_scripts\utility::flag_set( "FlagScrambleBeginHothall" );
    thread snipershoothothall();
    var_0 maps\_anim::anim_single_solo( level.allies["Ilona"], "scram_hothall" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyStartScrambleWindowCover" );
    waitframe();
    level.allies["Ilona"] waittill( "goal" );
    level.allies["Ilona"] maps\_utility::enable_sprint();
    common_scripts\utility::flag_set( "FlagScrambleEndHothall" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearSecondJump" );
    thread maps\_utility::autosave_by_name( "scramble_hotel_jump_start" );
    common_scripts\utility::flag_wait( "FlagScrambleCheckPlayerDecision" );
    level.allies["Ilona"] pushplayer( 1 );

    for (;;)
    {
        if ( common_scripts\utility::flag( "FlagScrambleHotelJumpStarted" ) )
        {
            level notify( "ScrambleHotelPlayerJumpedFirst" );
            common_scripts\utility::flag_set( "FlagScrambleHotelPlayerHasDecided" );
            sniperhoteltargetplayerfirst();
            break;
        }
        else if ( common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) )
        {
            level notify( "ScrambleHotelPlayerSuppressedFirst" );
            common_scripts\utility::flag_set( "FlagScrambleHotelPlayerHasDecided" );
            sniperhoteltargetilanafirst();
            break;
        }

        wait 0.05;
    }

    thread scramblecivdrones();
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );
    thread maps\_utility::autosave_by_name( "scramble_cafe_jump_start" );
    wait 1.0;
    level.sniper_scramble_data.suppression_time = 0;
    ilanatogglesnipersuppression( 0 );
    snipersettargetent( undefined );
    var_1 = common_scripts\utility::getstruct( "cafeWindowOrg", "targetname" );
    var_2 = "cafe_traversal";
    var_3 = distance( level.allies["Ilona"].origin, var_1.origin );

    if ( var_3 > 64.0 )
    {
        var_1 = common_scripts\utility::getstruct( "cafeWindowOrgAlt", "targetname" );
        var_2 = "cafe_traversal_alt";
    }

    var_1 maps\_anim::anim_reach_solo( level.allies["Ilona"], var_2 );
    common_scripts\utility::flag_set( "FlagScrambleHotelIlanaJumpDown" );
    var_1 thread maps\_anim::anim_single_solo_run( level.allies["Ilona"], var_2 );
    wait 1.0;
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigFiftyFifth" );
    level.allies["Ilona"] pushplayer( 0 );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerCompletedThirdJump" );
    wait 1;
    common_scripts\utility::flag_set( "FlagScrambleStartDrones" );
    thread ilanascrambledrones();
}

sniperhoteltargetilanafirst()
{
    maps\_hms_utility::printlnscreenandconsole( "Player is suppressing sniper - Ilana is running!" );
    thread monitorhotelilanaleapfrog();
    common_scripts\utility::flag_wait_either( "FlagScrambleHotelJumpCompleted", "FlagScrambleHotelJumpStarted" );
    thread monitorhotelplayerleapfrog();
    snipersettargetent( level.player );
    ilanatogglesnipersuppression( 1 );
    maps\_hms_utility::printlnscreenandconsole( "Player jumped down - Ilana is suppressing!" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );
    level.player notify( "ScramblePlayerCompletedLeapfrog" );
    ilanatogglesnipersuppression( 0 );
    snipersettargetent( undefined );
    maps\_hms_utility::printlnscreenandconsole( "Player at end - HOTEL COMPLETE!" );
}

sniperhoteltargetplayerfirst()
{
    thread monitorhotelplayerleapfrog();
    snipersettargetent( level.player );
    ilanatogglesnipersuppression( 1 );
    maps\_hms_utility::printlnscreenandconsole( "Player jumped down - Ilana is suppressing!" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );
    level.player notify( "ScramblePlayerCompletedLeapfrog" );
    ilanatogglesnipersuppression( 0 );
    snipersettargetent( undefined );
    maps\_hms_utility::printlnscreenandconsole( "Player at end - Ilana is waiting for suppression..." );
    level.sniper_scramble_data.suppression_time = 0;
    wait 1.0;
    common_scripts\utility::flag_wait( "FlagScrambleSniperSuppressed" );
    maps\_hms_utility::printlnscreenandconsole( "Player is suppressing sniper - Ilana is running!" );
    thread monitorhotelilanaleapfrog();
    common_scripts\utility::flag_wait( "FlagScrambleHotelIlanaReachedGoal" );
    maps\_hms_utility::printlnscreenandconsole( "Ilana at end - HOTEL COMPLETE!" );
}

hintscramblesuppress1off()
{
    if ( common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) || common_scripts\utility::flag( "FlagScrambleHotelIlanaStartRun" ) )
        return 1;

    return 0;
}

hintscramblesuppress2off()
{
    if ( common_scripts\utility::flag( "FlagScrambleSniperSuppressed" ) || common_scripts\utility::flag( "FlagScrambleHotelIlanaStartRun" ) || common_scripts\utility::flag( "FlagScrambleHotelJumpStarted" ) )
        return 1;

    return 0;
}

hintscrambleadvanceoff()
{
    return common_scripts\utility::flag( "FlagScrambleHotelJumpStarted" );
}

monitorhotelplayerleapfrog()
{
    level.player endon( "ScramblePlayerCompletedLeapfrog" );
    level.player waittill( "damage" );
    common_scripts\utility::flag_set( "FlagScrambleHotelBadLeapfrog" );
}

monitorhotelilanaleapfrog()
{
    common_scripts\utility::flag_set( "FlagScrambleHotelIlanaStartRun" );
    level.allies["Ilona"] maps\_utility::enable_sprint();
    snipersettargetent( level.allies["Ilona"] );
    thread maps\greece_sniper_scramble_fx::windowhoteljumpglassshatter( 0.5 );
    var_0 = getent( "ScrambleIlanaCornerClip", "targetname" );
    var_0 delete();
    var_1 = common_scripts\utility::getstruct( "hotelWindowOrg", "targetname" );
    var_1 maps\_anim::anim_single_solo_run( level.allies["Ilona"], "hotel_traversal" );
    level.allies["Ilona"] maps\_utility::enable_ai_color();
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyStartScrambleCafeCover" );
    thread ilanaleapfrogadjustgoal();
    maps\_utility::trigger_wait_targetname( "SniperScrambleHotelIlanaAtGoal" );
    level.allies["Ilona"] maps\_utility::disable_sprint();
    level notify( "IlanaLeapfrogGoal" );
    common_scripts\utility::flag_set( "FlagScrambleHotelIlanaReachedGoal" );
    maps\_hms_utility::printlnscreenandconsole( "Ilana at goal" );

    if ( !common_scripts\utility::flag( "FlagScrambleHotelJumpCompleted" ) )
        snipersettargetent( undefined );
}

ilanaleapfrogadjustgoal()
{
    level endon( "IlanaLeapfrogGoal" );
    var_0 = getnode( "AllyStartScrambleCafeCover", "targetname" );
    var_1 = undefined;

    for (;;)
    {
        waitframe();

        if ( !maps\_utility::players_within_distance( 64, var_0.origin ) )
            continue;

        var_1 = ilanaleapfroggetgoal();

        if ( isdefined( var_1 ) )
        {
            level.allies["Ilona"] maps\_utility::set_goal_node( var_1 );
            var_0 = var_1;
        }
    }
}

ilanaleapfroggetgoal()
{
    var_0 = undefined;
    var_1 = getnodearray( "ilana_leapfrog", "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        if ( maps\_utility::players_within_distance( 64, var_3.origin ) )
            continue;
        else
            var_0 = var_3;
    }

    return var_0;
}

ilanascrambledrones()
{
    thread scramblespawndronesa();
    thread spawnrestaurantfishswimming();
    thread scramblecivrestaurantdooropener();
    var_0 = getentarray( "ScrambleDronesToRestaurantTrig", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();

    level.allies["Ilona"] maps\_utility::enable_ai_color();
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigSixth" );
    common_scripts\utility::flag_wait( "FlagScrambleDronesAdead" );
    maps\_utility::disable_trigger_with_targetname( "SniperScrambleColorTrigSixth" );
    maps\_utility::disable_trigger_with_targetname( "SniperScrambleColorTrigSeventh" );
    wait 0.05;
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigEighth" );
    thread maps\_utility::autosave_by_name( "scramble_drone_fight_end" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();

    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerUnderBridge" );
    level.allies["Ilona"] maps\_utility::enable_sprint();
    var_6 = common_scripts\utility::getstruct( "RestaurantDoorOpenOrg", "script_noteworthy" );
    thread snipershootilana();
    var_6 maps\_anim::anim_reach_solo( level.allies["Ilona"], "RestaurantOpenDoor" );
    thread scramblerestaurantcivexit();
    thread scramblerestaurantdoorsopen();
    var_6 maps\_anim::anim_single_solo( level.allies["Ilona"], "RestaurantOpenDoor" );
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigTenth" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerMidRestaurant" );
    thread scramblefinaleallies();
    thread pitbulldestroyedanimation();
    thread ilanascramblefinale();
}

scramblerestaurantcivexit()
{
    var_0 = common_scripts\utility::getstruct( "RestaurantDoorOpenOrg", "script_noteworthy" );
    var_1 = maps\_utility::get_living_ai( "ScrambleCivRestaurantDoorOpener_AI", "targetname" );
    var_0 notify( "scramble_open_restaurant" );
    var_0 maps\_anim::anim_single_solo( var_1, "RestaurantOpenDoor" );
    var_1 maps\greece_code::kill_no_react( 0.0 );
}

scramblerestaurantdoorsopen()
{
    var_0 = common_scripts\utility::getstruct( "RestaurantDoorOpenOrg", "script_noteworthy" );
    var_1 = getent( "ScrambleRestaurantDoors", "targetname" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "RestaurantOpenDoor" );
    level waittill( "ScrambleRestaurantDoorsOpen" );
    soundscripts\_snd::snd_message( "restaurant_doors_open", var_1 );
    var_2 = getent( "ScrambleRestaurantDoorClip", "targetname" );
    var_2 delete();
    var_3 = getent( "ScrambleRestaurantDoorOpenClip", "targetname" );
    var_3 movez( 128, 0.1 );
}

monitorrestaurantglassfrenzyvol()
{
    var_0 = getent( "SniperScrambleRestaurantFrenzy", "targetname" );
    var_1 = getentarray( "ScrambleRestaurantGlass", "script_noteworthy" );

    while ( !common_scripts\utility::flag( "FlagTriggerScramblePlayerAlmostNearWoundedSoldier" ) )
    {
        if ( level.player istouching( var_0 ) )
        {
            var_1 = sortbydistance( var_1, level.player.origin );

            if ( isdefined( var_1[0] ) && maps\_utility::players_within_distance( 256, var_1[0].origin ) )
            {
                var_2 = var_1[0];
                level.sniperpos.bsniperenabled = 0;
                snipershoot( var_2.origin );
                soundscripts\_snd::snd_message( "windmill_sniper_shot_multi", var_2.origin );
                var_1 = common_scripts\utility::array_remove( var_1, var_2 );
                wait(randomfloatrange( 0.5, 1.5 ));
            }
            else
            {
                level.sniperpos.bsniperenabled = 1;
                level.sniper_scramble_data.requires_player_los = 0;
                snipersettargetent( level.player );
            }
        }
        else
        {
            level.sniper_scramble_data.requires_player_los = 1;
            level.snipertargetent = undefined;
        }

        wait 0.05;
    }

    level.sniperpos.bsniperenabled = 0;
    level.sniper_scramble_data.requires_player_los = 1;
}

monitorsupersafevol()
{
    level endon( "ScrambleSniperKilled" );
    var_0 = getentarray( "ScrambleSuperSafeVol", "script_noteworthy" );
    var_1 = 0;

    for (;;)
    {
        wait 0.5;

        if ( targetinsafevolume( level.player, var_0 ) )
        {
            level.sniper_scramble_data.player_in_disable_sniper_volume = 1;
            continue;
        }

        level.sniper_scramble_data.player_in_disable_sniper_volume = 0;
    }
}

monitorslidesafevol()
{
    level endon( "ScrambleSniperKilled" );
    var_0 = getent( "ScrambleSlideSafeVol", "script_noteworthy" );
    var_0.bisactivated = 0;

    while ( !common_scripts\utility::flag( "FlagScrambleHotelIlanaReachedGoal" ) )
    {
        if ( level.player istouching( var_0 ) )
        {
            snipersettargetent( level.player );
            soundscripts\_snd::snd_message( "windmill_sniper_shot", level.player geteye() );
            snipershoot( level.player geteye(), 1.5, 1 );
            wait 0.05;
            maps\_hms_utility::printlnscreenandconsole( "*** FORCE KILL PLAYER ***" );
            level.player stopanimscripted();
            level.player kill();
            level notify( "ScramblePlayerLeftIlana" );
            maps\greece_sniper_scramble_vo::scramblefailplayerleftilanadialogue();
            wait 1;
            setdvar( "ui_deadquote", &"GREECE_FAIL_SCRAMBLE_LEFT_ILONA" );
            maps\_utility::missionfailedwrapper();
            return;
        }

        wait 0.05;
    }

    var_0.bisactivated = 1;
}

ilanascramblefinale()
{
    thread sniperdeath();
    thread snipershootwoundedsoldier();
    thread scramblecivfinale();
    thread scramblefiredamagemonitor();
    thread scramblerestaurantexitclip( 1 );
    thread destroydroppedgun();
    level.player allowsprint( 0 );
    level.player allowdodge( 0 );
    var_0 = level.allies["Ilona"];
    var_1 = common_scripts\utility::getstruct( "ScrambleIlanaLookAllyOrg", "targetname" );
    var_1 maps\_anim::anim_reach_solo( var_0, "scramble_check_ally_enter" );
    var_1 maps\_anim::anim_single_solo( var_0, "scramble_check_ally_enter" );
    var_1 thread maps\_anim::anim_loop_solo( var_0, "scramble_check_ally_idle", "wounded_loop_end" );
    var_0 maps\_utility::disable_sprint();
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearWoundedSoldier" );
    thread maps\_utility::autosave_by_name( "scramble_finale_start" );
    common_scripts\utility::flag_wait( "FlagScrambleReadyForWoundedSoldier" );
    thread playerscramblefinale();
    var_1 notify( "wounded_loop_end" );
    thread woundedsoldierdeath( var_1 );
    var_1 maps\_anim::anim_single_solo_run( var_0, "scramble_check_ally_exit" );
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigTwelfth" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerLeavingRestaurant" );
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigThirteenth" );
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerOnStreet" );
    level.allies["Ilona"] maps\_utility::set_ignoresuppression( 1 );
    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigSixteenth" );

    for (;;)
    {
        if ( level.player hasweapon( "iw5_stingerm7greece_sp" ) )
            break;

        wait 0.1;
    }

    thread maps\_utility::autosave_by_name( "scramble_finale_stinger" );
    var_2 = getentarray( "ScrambleFinaleColorTrig", "script_noteworthy" );

    foreach ( var_4 in var_2 )
        var_4 common_scripts\utility::trigger_off();

    maps\_utility::activate_trigger_with_targetname( "SniperScrambleColorTrigSeventeenth" );
    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
    level.allies["Ilona"] maps\_utility::disable_ai_color();
    maps\_utility::clear_color_order( "g", "allies" );
    level.allies["Ilona"] maps\_utility::set_ignoresuppression( 0 );
    level.allies["Ilona"].grenadeammo = level.allies["Ilona"].oldgrenadeammo;
    level.allies["Ilona"] maps\_utility::set_battlechatter( 0 );
    thread maps\_utility::autosave_by_name( "scramble_finale_end" );
    thread ilanasetupmovetruck();
}

playerscramblefinale()
{
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerOnStreet" );
    thread scramblespawndronesb();
    level.sniper_scramble_data.sniper_finale = 1;
    level.sniper_scramble_data.minburstdelay = 1.0;
    level.sniper_scramble_data.maxburstdelay = 3.0;
    thread monitorplayerfirerpgattower();
    thread scrambleatlasrpg();
}

scramblesniperkillplayerfailmsg()
{
    level endon( "ScrambleSniperKilled" );
    level.player waittill( "death", var_0, var_1, var_2 );

    if ( level.player hasweapon( "iw5_stingerm7greece_sp" ) )
        return;

    if ( isdefined( var_1 ) && var_1 == "MOD_EXPLOSIVE" )
        return;

    if ( isdefined( var_0 ) && var_0.classname == "script_vehicle_pdrone_kva" )
        return;
    else
        setdvar( "ui_deadquote", &"GREECE_FAIL_SCRAMBLE_SUPPRESS_SNIPER" );
}

woundedsoldierdeath( var_0 )
{
    var_1 = maps\_utility::get_living_ai( "FinaleAlly01", "script_noteworthy" );
    var_0 maps\_anim::anim_single_solo( var_1, "sanchez_wounded_death" );
    var_1 maps\greece_code::kill_no_react();
}

ilanascramblefinalemoveandsuppress()
{
    level endon( "ScrambleSniperKilled" );
    level.allies["Ilona"].bissuppressingsniper = 0;
    var_0 = getnodearray( "ScrambleIlanaFinaleSuppressSniper", "script_noteworthy" );

    while ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        var_1 = level.allies["Ilona"] getcovernode();

        if ( isdefined( var_1 ) && maps\_utility::is_in_array( var_0, var_1 ) && level.allies["Ilona"].bissuppressingsniper == 0 )
        {
            ilanatogglesnipersuppression( 1 );
            snipersettargetent( level.allies["Ilona"] );
            level.allies["Ilona"].bissuppressingsniper = 1;
            maps\_hms_utility::printlnscreenandconsole( "*** Ilana IS suppressing sniper ***" );
        }
        else
        {
            ilanatogglesnipersuppression( 0 );
            snipersettargetent( undefined );
            level.allies["Ilona"].bissuppressingsniper = 0;
        }

        wait 0.1;
    }

    ilanatogglesnipersuppression( 0 );
    level.allies["Ilona"].bissuppressingsniper = 0;
    maps\_hms_utility::printlnscreenandconsole( "*** Ilana IS NOT suppressing sniper ***" );
}

ilanasetupmovetruck()
{
    var_0 = common_scripts\utility::getstruct( "ScramblePlayerExitOrg", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.allies["Ilona"], "run_to_truck" );
    var_0 maps\_anim::anim_single_solo( level.allies["Ilona"], "run_to_truck" );
    var_0 thread maps\_anim::anim_loop_solo( level.allies["Ilona"], "move_truck_idle", "ilana_move_truck_end" );
    common_scripts\utility::flag_set( "FlagScrambleIlanaStartMoveTruck" );
}

ilanamovetruck()
{
    var_0 = common_scripts\utility::getstruct( "ScramblePlayerExitOrg", "targetname" );
    var_0 notify( "ilana_move_truck_end" );
    level.allies["Ilona"] maps\_utility::anim_stopanimscripted();
    var_0 thread maps\_anim::anim_single_solo_run( level.allies["Ilona"], "move_truck" );
    wait 1;
    var_1 = getnode( "AllyEndingStartCover", "targetname" );
    level.allies["Ilona"] maps\_utility::set_goal_node( var_1 );
    wait 5;
    level.allies["Ilona"] maps\_utility::gun_recall();
}

scramblesnipertowerdestruction()
{
    var_0 = getent( "sniper_tower_org", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "greece_sniper_tower_des" );
    var_2 = [];
    var_2[0] = maps\_utility::spawn_anim_model( "greece_sniper_tower_des_01", var_0.origin );
    var_2[0].animname = "greece_sniper_tower_des_01";
    var_2[0] maps\_anim::setanimtree();
    var_2[1] = maps\_utility::spawn_anim_model( "greece_sniper_tower_des_02", var_0.origin );
    var_2[1].animname = "greece_sniper_tower_des_02";
    var_2[1] maps\_anim::setanimtree();
    var_2[2] = maps\_utility::spawn_anim_model( "greece_sniper_tower_des_03", var_0.origin );
    var_2[2].animname = "greece_sniper_tower_des_03";
    var_2[2] maps\_anim::setanimtree();
    var_2[3] = maps\_utility::spawn_anim_model( "greece_sniper_tower_des_04", var_0.origin );
    var_2[3].animname = "greece_sniper_tower_des_04";
    var_2[3] maps\_anim::setanimtree();
    var_2[4] = maps\_utility::spawn_anim_model( "greece_sniper_tower_des_05", var_0.origin );
    var_2[4].animname = "greece_sniper_tower_des_05";
    var_2[4] maps\_anim::setanimtree();
    var_2[5] = maps\_utility::spawn_anim_model( "greece_sniper_tower_des_06", var_0.origin );
    var_2[5].animname = "greece_sniper_tower_des_06";
    var_2[5] maps\_anim::setanimtree();
    var_2[6] = maps\_utility::spawn_anim_model( "greece_sniper_tower_des_07", var_0.origin );
    var_2[6].animname = "greece_sniper_tower_des_07";
    var_2[6] maps\_anim::setanimtree();
    var_0 maps\_anim::anim_first_frame( var_2, "windmill_explode" );
    var_0 thread maps\_anim::anim_single( var_2, "windmill_explode" );
    common_scripts\utility::flag_wait( "FlagScramblePlayerStartMoveTruck" );
    maps\_utility::array_delete( var_2 );
}

scramblesnipertowerdestructionshake()
{
    level.player playrumbleonentity( "tank_rumble" );
    earthquake( 0.6, 0.25, level.player.origin, 128 );
    wait 0.5;
    level.player playrumbleonentity( "subtle_tank_rumble" );
    earthquake( 0.2, 10.0, level.player.origin, 128 );
}

scramblesniperragdoll()
{
    var_0 = maps\_utility::array_spawn_targetname( "ScrambleSniperRagdoll", 1 );

    foreach ( var_2 in var_0 )
    {
        var_2.animname = "generic";
        var_3 = var_2.script_noteworthy + "Org";
        var_4 = common_scripts\utility::getstruct( var_3, "targetname" );
        var_5 = var_4.animation;
        var_2 maps\_utility::gun_remove();
        var_2 thread sniperscrambleragdollkill( var_4, var_5 );
    }
}

sniperscrambleragdollkill( var_0, var_1 )
{
    thread maps\greece_sniper_scramble_fx::ragdollonfirefx();
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    self kill();
    wait 3.0;

    if ( isdefined( self ) && self isragdoll() )
        self delete();
}

sniperdeath()
{
    var_0 = getent( "SniperDeathDamageTrigger", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    common_scripts\utility::flag_wait( "FlagScramblePlayerHasStinger" );
    level.sniper_scramble_data.shot_delay = 3;
    var_0 common_scripts\utility::trigger_on();
    var_0 waittill( "trigger" );
    level notify( "ScrambleSniperKilled" );
    common_scripts\utility::flag_set( "FlagScrambleSniperKilled" );
    soundscripts\_snd::snd_message( "mhunt_snpr_tower_collapse" );
    thread scramblesnipertowerdestructionshake();
    thread maps\greece_sniper_scramble_fx::snipertowerexplosionfx();
    thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
    thread maps\greece_sniper_scramble_fx::movetruckfirefx();
    wait 0.15;
    var_1 = getent( "sniper_tower", "targetname" );
    var_1 delete();
    thread scramblesnipertowerdestruction();
    thread scramblesniperragdoll();
}

sniperdeathinternal()
{
    if ( common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
        return;

    level notify( "ScrambleSniperKilled" );
    common_scripts\utility::flag_set( "FlagScrambleSniperKilled" );
    soundscripts\_snd::snd_message( "mhunt_snpr_tower_collapse" );
    thread scramblesnipertowerdestructionshake();
    thread maps\greece_sniper_scramble_fx::snipertowerexplosionfx();
    thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
    thread maps\greece_sniper_scramble_fx::movetruckfirefx();
    wait 0.15;
    var_0 = getent( "sniper_tower", "targetname" );
    var_0 delete();
    thread scramblesnipertowerdestruction();
    thread scramblesniperragdoll();
}

setdronehealth( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 maps\_vehicle::vehicle_set_health( 100 );
}

scramblespawndronesa()
{
    wait 0.05;
    thread maps\_utility::autosave_by_name( "scramble_drone_fight_A" );

    if ( level.currentgen )
        wait 2;

    soundscripts\_snd::snd_message( "start_swarm_drones_context" );
    var_0 = vehicle_scripts\_pdrone::start_flying_attack_drones( "ScrambleDroneA" );
    maps\_hms_utility::printlnscreenandconsole( "Drones A: spawning " + var_0.size + " drones" );
    common_scripts\utility::array_thread( var_0, ::droneflyinshooting, 6.0 );
}

scramblespawndronesb()
{
    wait 0.05;
    thread maps\_utility::autosave_by_name( "scramble_drone_fight_B" );

    if ( level.currentgen )
        wait 2;

    soundscripts\_snd::snd_message( "start_swarm_drones_context" );
    var_0 = vehicle_scripts\_pdrone::start_flying_attack_drones( "ScrambleDroneB" );
    maps\_hms_utility::printlnscreenandconsole( "Drones B: spawning " + var_0.size + " drones" );
    common_scripts\utility::array_thread( var_0, ::droneflyinshooting, 6.0 );
    thread monitorfinalesafevol();
    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
    soundscripts\_snd::snd_message( "stop_swarm_drones_context" );
    var_0 = maps\_utility::array_removedead( var_0 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            var_2 maps\_utility::ent_flag_set( "fire_disabled" );
            var_2.pacifist = 1;
            var_2 vehicle_scripts\_pdrone::pdrone_emp_death();
        }

        wait(randomfloat( 0.1 ));
    }
}

scrambleatlasrpg()
{
    wait 1.0;
    level.numberofdronestokill = 3;
    var_0 = getent( "Atlas_RPG_Origin", "targetname" );
    var_1 = getentarray( "Atlas_RPG_Target", "targetname" );

    for ( var_2 = 0; var_2 < 8; var_2++ )
    {
        var_3 = common_scripts\utility::random( var_1 );
        var_4 = magicbullet( "iw5_stingerm7greece_sp", var_0.origin, var_3.origin );
        var_4 thread maps\_stingerm7_greece::_randommissilemovement( var_3 );
        var_4 thread _destroyprojectileafterdelay( randomfloatrange( 1, 2 ) );
        soundscripts\_snd::snd_message( "ally_shoot_rpg_at_drones", var_0 );
        wait(randomfloatrange( 0.15, 0.25 ));
    }

    common_scripts\utility::flag_set( "FlagScrambleGetRPG" );
}

_destroyprojectileafterdelay( var_0 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
        wait(var_0);

    if ( isdefined( self ) )
    {
        var_1 = self.origin;
        var_2 = self.angles;
        playfx( common_scripts\utility::getfx( "stinger_rocket_explosion" ), var_1, anglestoforward( var_2 ), anglestoup( var_2 ) );

        if ( level.numberofdronestokill != 0 )
        {
            var_3 = common_scripts\utility::getclosest( self.origin, level.flying_attack_drones );

            if ( isdefined( var_3 ) && var_3.health > 0 )
                var_3 dodamage( var_3.health, level.player.origin );

            level.numberofdronestokill--;
        }

        self delete();
    }
}

monitorfinalesafevol()
{
    level endon( "ScrambleSniperKilled" );
    var_0 = getent( "ScrambleFinaleSafeVol", "script_noteworthy" );
    var_0.bisactivated = 1;

    for (;;)
    {
        if ( common_scripts\utility::flag( "FlagScrambleDronesBdead" ) || level.player hasweapon( "iw5_stingerm7greece_sp" ) )
            break;

        wait 0.5;
    }

    snipersettargetent( undefined );
    var_0.bisactivated = 0;

    for (;;)
    {
        if ( level.player hasweapon( "iw5_stingerm7greece_sp" ) )
            break;

        wait 0.1;
    }

    level.sniperpos.bsniperenabled = 0;
    wait 5.0;
    level.sniperpos.bsniperenabled = 1;
    snipersettargetent( level.player );
    level.sniper_scramble_data.requires_player_los = 0;
}

droneflyinshooting( var_0 )
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    self laseron();
    thread monitordeaddrones();
    maps\_utility::ent_flag_set( "fire_disabled" );
    self.pacifist = 1;
    var_1 = self.script_noteworthy + "Target";
    var_2 = getent( var_1, "targetname" );
    var_3 = var_0 - 3.0;

    if ( var_3 < 1.0 )
        var_3 = 1.0;

    var_4 = var_0 + 3.0;
    var_5 = randomfloatrange( var_3, var_4 );

    if ( isdefined( var_2 ) )
    {
        thread dronetargetmove( var_2, var_5 );
        thread dronefireatscriptedtarget( var_2, "pdrone_end_flyin" );
    }

    wait(var_5);
    self notify( "pdrone_end_flyin" );
    maps\_utility::ent_flag_clear( "fire_disabled" );

    if ( common_scripts\utility::cointoss() )
        self.favoriteenemy = level.player;

    self.pacifist = 0;
}

dronetargetmove( var_0, var_1 )
{
    self endon( "death" );
    self endon( "emp_death" );
    self endon( "pdrone_end_flyin" );
    var_2 = level.player.origin + ( randomfloatrange( -100, 100 ), randomfloatrange( -100, 100 ), 0 );
    var_0 moveto( var_2, var_1 );

    for (;;)
    {
        if ( maps\_hms_utility::cointossweighted( 25 ) )
            physicsexplosionsphere( var_0.origin, 100, 10, 0.5 );

        wait 0.1;
    }
}

dronefireatscriptedtarget( var_0, var_1 )
{
    self endon( "death" );
    self endon( "emp_death" );

    if ( isdefined( self.owner ) )
        self.owner endon( "pdrone_returning" );

    self endon( var_1 );
    var_2 = 0.3;
    var_3 = 0.095;

    if ( level.currentgen )
        var_3 = 0.2499;

    var_4 = -10 / var_2;
    var_5 = 10 / var_2;
    var_6 = -5 / var_2;
    var_7 = 5 / var_2;

    for (;;)
    {
        var_8 = ( randomfloatrange( var_4, var_5 ), randomfloatrange( var_4, var_5 ), randomfloatrange( var_6, var_7 ) );
        self setturrettargetent( var_0, var_8 );
        var_9 = self gettagorigin( "tag_flash" );
        var_10 = self gettagorigin( "tag_flash" );
        self fireweapon();
        wait(var_3);
    }
}

monitordeaddrones()
{
    self waittill( "death" );

    if ( isdefined( self.script_noteworthy ) )
        maps\_hms_utility::printlnscreenandconsole( "Drone destroyed: " + self.script_noteworthy );
    else
        maps\_hms_utility::printlnscreenandconsole( "Drone destroyed!" );
}

monitorphysicschairs()
{
    var_0 = getentarray( "SniperPhysicsDamageTrigger", "targetname" );
    common_scripts\utility::array_thread( var_0, ::snipershotphysicsimpulse );
}

snipershotphysicsimpulse()
{
    level endon( "ScrambleSniperKilled" );

    for (;;)
    {
        self waittill( "trigger" );
        physicsexplosionsphere( self.origin, 100, 10, 0.5 );
        wait 1.0;
    }
}

scrambleplayergapjump()
{
    var_0 = level.player;
    var_1 = level.allies["Ilona"];
    var_2 = getent( "TriggerScrambleGapJumpStart", "targetname" );
    var_3 = getent( "ScramblePlayerGapJumpRef1", "targetname" );
    var_4 = anglestoforward( var_3.angles );
    thread scrambleplayerjumpwatcher( 0 );
    waitforscramblejump( var_2, var_4, 1 );
    level notify( "ScrambleJumpWatcherStop" );
    common_scripts\utility::flag_set( "FlagScrambleGapJumpStarted" );
    soundscripts\_snd::snd_message( "gap_jump_squib_occlusion" );
    thread scramblegapjumpslomo();
    thread snipershootgapjump();
    thread scramblecivhotel();
    thread scramblecivhothall();
    var_5 = "parkour_jump";
    var_6 = common_scripts\utility::getstruct( "ScrambleGapJumpOrg", "targetname" );
    var_7 = common_scripts\utility::getstruct( "ScrambleGapJumpIlonaOrg", "targetname" );
    var_8 = maps\_utility::spawn_anim_model( "player_scramble_rig", var_6.origin, var_6.angles );
    var_8 hide();
    var_6 maps\_anim::anim_first_frame_solo( var_8, var_5 );
    level.player maps\_shg_utility::setup_player_for_scene();
    thread maps\greece_sniper_scramble_fx::windowgapjumpglassshatter();
    soundscripts\_snd::snd_message( "hotel_crowd_panic_walla" );
    thread scrambleilanagapjump( var_7, var_5 );
    level.player playerlinktoblend( var_8, "tag_player", 0.2 );
    wait 0.2;
    thread scramblehideplayergapjump( var_8 );

    if ( level.currentgen )
    {
        thread tff_trans_middle_to_outro();
        thread maps\_utility::tff_sync( 4 );
    }

    var_6 maps\_anim::anim_single_solo( var_8, var_5 );
    level.player unlink();
    level.player thread maps\_shg_utility::setup_player_for_gameplay();
    var_8 delete();
    thread scramblecivpool();
    thread maps\_utility::autosave_by_name( "scramble_gap_jump_end" );
    common_scripts\utility::flag_set( "FlagScrambleGapJumpCompleted" );
    common_scripts\utility::flag_set( "FlagScrambleStartHotel" );
    common_scripts\utility::flag_set( "init_sniper_scramble_hotel_lighting" );
}

scramblehideplayergapjump( var_0 )
{
    wait 0.1;
    var_0 show();
}

tff_trans_middle_to_outro()
{
    level notify( "tff_pre_middle_to_outro" );
    unloadtransient( "greece_middle_tr" );
    loadtransient( "greece_outro_tr" );

    while ( !istransientloaded( "greece_outro_tr" ) )
        wait 0.05;

    level notify( "tff_post_middle_to_outro" );
}

scrambleilanagapjump( var_0, var_1 )
{
    var_2 = level.allies["Ilona"];
    var_0 maps\_anim::anim_single_solo_run( var_2, var_1 );
    common_scripts\utility::flag_set( "FlagScrambleIlanaGapJumpCompleted" );
    thread maps\_hms_utility::allyredirectgotonode( "Ilona", "AllyStartScrambleHotelCover" );
    wait 1;
    level.sniperpos.bsniperenabled = 0;
}

scrambleplayerhoteljump()
{
    common_scripts\utility::flag_wait( "FlagScrambleCheckPlayerDecision" );
    var_0 = level.player;
    var_1 = getent( "TriggerScrambleHotelJumpStart", "targetname" );
    var_2 = getent( "ScramblePlayerHotelJumpRef", "targetname" );
    var_3 = anglestoforward( var_2.angles );
    thread scrambleplayerjumpwatcher( 0 );
    waitforscramblejump( var_1, var_3, 0 );
    level notify( "ScrambleJumpWatcherStop" );
    common_scripts\utility::flag_set( "FlagScrambleHotelJumpStarted" );
    soundscripts\_snd::snd_message( "scramble_amb_siren_loop" );
    soundscripts\_snd::snd_message( "pool_civ_01_cower_setup" );
    var_4 = getent( "ScrambleHotelWindowClip", "targetname" );
    var_4 delete();
    var_5 = "hotel_jump";
    var_6 = getent( "TriggerScrambleHotelJumpStartL", "targetname" );

    if ( level.player istouching( var_6 ) )
    {
        var_7 = common_scripts\utility::getstruct( "ScrambleHotelJumpOrgL", "targetname" );
        var_8 = 1;
    }
    else
    {
        var_7 = common_scripts\utility::getstruct( "ScrambleHotelJumpOrgR", "targetname" );
        var_8 = 0;
    }

    thread snipershoothoteljump( var_8 );
    var_9 = maps\_utility::spawn_anim_model( "player_scramble_rig", var_7.origin, var_7.angles );
    var_9 hide();
    var_7 maps\_anim::anim_first_frame_solo( var_9, var_5 );
    level.player maps\_shg_utility::setup_player_for_scene();
    thread maps\greece_sniper_scramble_fx::windowhoteljumpglassshatter( 0.1 );
    level.player disableweapons();
    level.player playerlinktoblend( var_9, "tag_player", 0.2 );
    wait 0.2;
    var_9 show();
    var_7 maps\_anim::anim_single_solo( var_9, var_5 );
    level.player unlink();
    level.player thread maps\_shg_utility::setup_player_for_gameplay();
    var_9 delete();
    level.player allowsprint( 1 );
    level.player allowdodge( 1 );
    thread maps\_utility::autosave_by_name( "scramble_hotel_jump_end" );
    common_scripts\utility::flag_set( "FlagScrambleHotelJumpCompleted" );
    thread scrambleplayercafejump();
}

scrambleplayercafejump()
{
    level endon( "ScramblePlayerLeftIlana" );
    common_scripts\utility::flag_wait( "FlagScrambleHotelIlanaReachedGoal" );
    var_0 = level.player;
    var_1 = getent( "TriggerScrambleCafeJumpStart", "targetname" );
    var_2 = getent( "ScramblePlayerCafeJumpRef", "targetname" );
    var_3 = getent( "TriggerScrambleCafeJumpStartL", "targetname" );
    var_4 = getent( "TriggerScrambleCafeJumpStartR", "targetname" );
    var_5 = anglestoforward( var_2.angles );
    thread scrambleplayerjumpwatcher( 0 );
    waitforscramblejump( var_1, var_5, 0 );
    level notify( "ScrambleJumpWatcherStop" );
    common_scripts\utility::flag_set( "FlagScrambleCafeJumpStarted" );
    var_6 = getent( "ScrambleCafeWindowClip", "targetname" );
    var_6 delete();
    var_7 = "cafe_jump";

    if ( level.player istouching( var_3 ) )
    {
        var_8 = common_scripts\utility::getstruct( "ScrambleCafeJumpOrgL", "targetname" );
        var_9 = 1;
    }
    else
    {
        var_8 = common_scripts\utility::getstruct( "ScrambleCafeJumpOrgR", "targetname" );
        var_9 = 0;
    }

    thread snipershootcafejump( var_9 );
    var_10 = maps\_utility::spawn_anim_model( "player_scramble_rig", var_8.origin, var_8.angles );
    var_10 hide();
    var_8 maps\_anim::anim_first_frame_solo( var_10, var_7 );
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player playerlinktoblend( var_10, "tag_player", 0.2 );
    wait 0.2;
    var_10 show();
    var_8 maps\_anim::anim_single_solo( var_10, var_7 );
    level.player unlink();
    level.player thread maps\_shg_utility::setup_player_for_gameplay();
    var_10 delete();
    thread maps\_utility::autosave_by_name( "scramble_cafe_jump_end" );
    common_scripts\utility::flag_set( "FlagScrambleCafeJumpCompleted" );
}

scrambleplayerjumpwatcher( var_0 )
{
    level endon( "ScrambleJumpWatcherStop" );
    common_scripts\utility::flag_clear( "FlagScramblePlayerJumping" );

    if ( var_0 )
    {
        notifyoncommand( "playerjump", "+usereload" );
        notifyoncommand( "playerjump", "+gostand" );
        notifyoncommand( "playerjump", "+moveup" );
    }
    else
    {
        notifyoncommand( "playerjump", "+gostand" );
        notifyoncommand( "playerjump", "+moveup" );
    }

    for (;;)
    {
        level.player waittill( "playerjump" );
        common_scripts\utility::flag_set( "FlagScramblePlayerJumping" );
        wait 0.1;

        while ( !level.player isonground() )
            wait 0.05;

        common_scripts\utility::flag_clear( "FlagScramblePlayerJumping" );
    }
}

waitforscramblejump( var_0, var_1, var_2 )
{
    for (;;)
    {
        wait 0.05;

        if ( level.player isreloading() )
            continue;

        if ( isdefined( level.player.using_ammo_cache ) && level.player.using_ammo_cache == 1 )
            continue;

        if ( level.player istouching( var_0 ) && common_scripts\utility::flag( "FlagScramblePlayerJumping" ) && scrambleplayerleaps( var_0, var_1, 0.6, var_2 ) )
            break;
    }
}

scrambleplayerleaps( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0.965;

    if ( level.player getstance() != "stand" )
        return 0;

    var_4 = level.player getangles() * ( 1, 1, 0 );
    var_5 = anglestoforward( var_4 );
    var_1 = vectornormalize( var_1 * ( 1, 1, 0 ) );

    if ( vectordot( var_5, var_1 ) < var_2 )
        return 0;

    if ( var_3 )
    {
        var_6 = maps\greece_code::calculateleftstickdeadzone() * ( 1, -1, 0 );
        var_7 = transformmove( ( 0, 0, 0 ), var_4, ( 0, 0, 0 ), ( 0, 0, 0 ), var_6, ( 0, 0, 0 ) );

        if ( vectordot( var_7["origin"], var_1 ) < 0.2 )
            return 0;
    }

    return 1;
}

scramblecivsetup()
{
    self pushplayer( 0 );
    maps\_utility::set_ignoreall( 1 );
    thread civsniperdamagemonitor();
}

scramblecivpatio()
{
    var_0 = [];
    maps\_utility::array_spawn_function_targetname( "ScrambleCivPatioCower", ::scramblecivsetup );
    var_1 = maps\_utility::array_spawn_targetname( "ScrambleCivPatioCower", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_1 );

    foreach ( var_3 in var_1 )
    {
        var_3 thread scrambleciviliancower();

        if ( var_3.script_noteworthy == "PatioCower01" )
            soundscripts\_snd::snd_message( "patio_civ_01_cower", var_3 );
    }

    maps\_utility::array_spawn_function_targetname( "ScrambleCivPatioFlee", ::scramblecivsetup );
    var_5 = maps\_utility::array_spawn_targetname( "ScrambleCivPatioFlee", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_5 );
    level.sniperalltargets = maps\_utility::array_merge( level.sniperalltargets, var_0 );

    foreach ( var_3 in var_5 )
    {
        if ( var_3.script_noteworthy == "PatioFlee01" )
            var_7 = "FlagScrambleIlanaBeginOpenIntroDoor";
        else if ( var_3.script_noteworthy == "PatioFlee03" )
            var_7 = "FlagScrambleIlanaEndOpenIntroDoor";
        else
            var_7 = "FlagScrambleGapJumpStarted";

        if ( var_3.script_noteworthy == "PatioFlee01" )
        {
            var_8 = 1;
            var_9 = 1;
            var_10 = 1.0;
            var_3 thread maps\_utility::magic_bullet_shield();
        }
        else
        {
            var_10 = 0.0;
            var_8 = 0;
            var_9 = 0;
        }

        if ( var_3.script_noteworthy == "PatioFlee01" )
            soundscripts\_snd::snd_message( "patio_intro_civ_death", var_3 );

        if ( var_3.script_noteworthy == "PatioFlee03" )
            soundscripts\_snd::snd_message( "patio_civ_03_scream", var_3 );

        var_3 thread scramblecivilianflee( var_7, var_9, 0, var_8, var_10 );
    }

    common_scripts\utility::flag_wait( "FlagScrambleGapJumpCompleted" );
    var_0 = maps\_utility::array_removedead( var_0 );
    maps\_utility::array_notify( var_0, "delete" );
    wait 0.05;
    maps\_utility::array_delete( var_0 );
}

scramblecivhotel()
{
    var_0 = [];
    maps\_utility::array_spawn_function_targetname( "ScrambleCivHotelFlee", ::scramblecivsetup );
    var_1 = maps\_utility::array_spawn_targetname( "ScrambleCivHotelFlee", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_1 );
    level.sniperalltargets = maps\_utility::array_merge( level.sniperalltargets, var_0 );

    foreach ( var_3 in var_1 )
    {
        var_4 = undefined;

        if ( var_3.script_noteworthy != "HotelFlee01" )
            var_4 = "FlagScrambleBeginHothall";

        if ( var_3.script_noteworthy == "HotelFlee02" )
            soundscripts\_snd::snd_message( "hotel_civ_04_death", var_3 );

        var_3 thread scramblecivilianflee( var_4, 0 );
    }

    common_scripts\utility::flag_wait( "FlagScrambleHotelJumpCompleted" );
    var_0 = maps\_utility::array_removedead( var_0 );
    maps\_utility::array_notify( var_0, "delete" );
    wait 0.05;
    maps\_utility::array_delete( var_0 );
}

scramblecivhothall()
{
    var_0 = getent( "hothall_org", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "hothall_male01", "targetname" );
    var_1.animname = "hothall_male01";
    var_2 = maps\_utility::spawn_targetname( "hothall_male02", "targetname" );
    var_2.animname = "hothall_male02";
    var_3 = maps\_utility::spawn_targetname( "hothall_female01", "targetname" );
    var_3.animname = "hothall_female01";
    var_4 = maps\_utility::spawn_targetname( "hothall_female02", "targetname" );
    var_4.animname = "hothall_female02";
    var_5 = [ var_1, var_2, var_3, var_4 ];

    foreach ( var_7 in var_5 )
    {
        var_7.ignoresonicaoe = 1;
        var_7 thread scramblecivsetup();
    }

    var_1 thread scramblehothallciv( var_0, 1 );
    var_2 thread scramblehothallciv( var_0, 0 );
    var_3 thread scramblehothallciv( var_0, 1 );
    var_4 thread scramblehothallciv( var_0, 0 );
    soundscripts\_snd::snd_message( "hotel_female_01_hallway", var_3 );
    common_scripts\utility::flag_wait( "FlagScrambleHotelJumpCompleted" );
    var_5 = maps\_utility::array_removedead( var_5 );
    maps\_utility::array_delete( var_5 );
}

scramblehothallciv( var_0, var_1 )
{
    self endon( "death" );
    var_0 thread maps\_anim::anim_loop_solo( self, "scram_hothall_idle", "stop_hothall_idle" );

    if ( var_1 == 0 )
        self.health = 1000000;

    common_scripts\utility::flag_wait( "FlagScrambleBeginHothall" );
    var_0 notify( "stop_hothall_idle" );
    var_0 maps\_anim::anim_single_solo( self, "scram_hothall" );

    if ( var_1 == 1 )
        var_0 thread maps\_anim::anim_loop_solo( self, "scram_hothall_idle_end" );
    else
        maps\greece_code::kill_no_react();
}

scramblecivpool()
{
    var_0 = [];
    maps\_utility::array_spawn_function_targetname( "ScrambleCivPoolCower", ::scramblecivsetup );
    var_1 = maps\_utility::array_spawn_targetname( "ScrambleCivPoolCower", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_1 );

    foreach ( var_3 in var_1 )
    {
        var_3 thread scrambleciviliancower();

        if ( var_3.script_noteworthy == "PoolCower01" )
            soundscripts\_snd::snd_message( "pool_civ_01_cower", var_3 );
    }

    maps\_utility::array_spawn_function_targetname( "ScrambleCivPoolFlee", ::scramblecivsetup );
    var_5 = maps\_utility::array_spawn_targetname( "ScrambleCivPoolFlee", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_5 );
    level.sniperalltargets = maps\_utility::array_merge( level.sniperalltargets, var_0 );

    foreach ( var_3 in var_5 )
    {
        if ( var_3.script_noteworthy == "PoolFlee01" || var_3.script_noteworthy == "PoolFlee02" )
            var_7 = "FlagTriggerScramblePlayerNearSecondJump";
        else
            var_7 = "FlagScrambleHotelJumpCompleted";

        var_8 = 0;
        var_3 thread scramblecivilianflee( var_7, var_8, 1, 0 );
    }

    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerCompletedThirdJump" );
    var_0 = maps\_utility::array_removedead( var_0 );
    maps\_utility::array_notify( var_0, "delete" );
    wait 0.05;
    maps\_utility::array_delete( var_0 );
}

scramblecivdrones()
{
    var_0 = [];
    maps\_utility::array_spawn_function_targetname( "ScrambleCivDronesCower", ::scramblecivsetup );
    var_1 = maps\_utility::array_spawn_targetname( "ScrambleCivDronesCower", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_1 );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.script_noteworthy == "DronesCower01Org" )
            var_4 = 1;
        else
            var_4 = 0;

        var_3 thread scrambleciviliancower( undefined, var_4 );
    }

    maps\_utility::array_spawn_function_targetname( "ScrambleCivDronesFlee", ::scramblecivsetup );
    var_6 = maps\_utility::array_spawn_targetname( "ScrambleCivDronesFlee", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_6 );
    level.sniperalltargets = maps\_utility::array_merge( level.sniperalltargets, var_0 );

    foreach ( var_3 in var_6 )
    {
        if ( var_3.script_noteworthy == "DronesFlee06" || var_3.script_noteworthy == "DronesFlee07" || var_3.script_noteworthy == "DronesFlee08" || var_3.script_noteworthy == "DronesFlee09" )
            var_8 = 1;
        else
            var_8 = 0;

        if ( var_3.script_noteworthy == "DronesFlee02" )
            soundscripts\_snd::snd_message( "drone_civ_02_flee", var_3 );

        var_9 = "FlagScrambleStartDrones";
        var_3 thread scramblecivilianflee( var_9, var_8, 0 );
    }

    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearWoundedSoldier" );
    var_0 = maps\_utility::array_removedead( var_0 );
    maps\_utility::array_notify( var_0, "delete" );
    wait 0.05;
    maps\_utility::array_delete( var_0 );
}

scramblecivrestaurant()
{
    var_0 = [];
    maps\_utility::array_spawn_function_targetname( "ScrambleCivRestaurantCower", ::scramblecivsetup );
    var_1 = maps\_utility::array_spawn_targetname( "ScrambleCivRestaurantCower", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_1 );

    foreach ( var_3 in var_1 )
    {
        var_3 thread scrambleciviliancower();

        if ( var_3.script_noteworthy == "RestaurantCower03" )
            soundscripts\_snd::snd_message( "restaurant_civ_03_cower", var_3 );
    }

    maps\_utility::array_spawn_function_targetname( "ScrambleCivRestaurantFlee", ::scramblecivsetup );
    var_5 = maps\_utility::array_spawn_targetname( "ScrambleCivRestaurantFlee", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_5 );
    level.sniperalltargets = maps\_utility::array_merge( level.sniperalltargets, var_0 );

    foreach ( var_3 in var_5 )
        var_3 thread scramblecivilianflee( "FlagTriggerScramblePlayerInRestaurant", 0, 0 );

    thread snipershootrestaurantfishtank();
    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerLeavingRestaurant" );
    var_0 = maps\_utility::array_removedead( var_0 );
    maps\_utility::array_notify( var_0, "delete" );
    wait 0.05;
    maps\_utility::array_delete( var_0 );
}

scramblecivrestaurantdooropener()
{
    var_0 = common_scripts\utility::getstruct( "RestaurantDoorOpenOrg", "script_noteworthy" );
    maps\_utility::array_spawn_function_targetname( "ScrambleCivRestaurantDoorOpener", ::scramblecivsetup );
    var_1 = maps\_utility::spawn_targetname( "ScrambleCivRestaurantDoorOpener", 1 );
    var_1 pushplayer( 0 );
    var_1.animname = "generic";
    var_1.ignoresonicaoe = 1;
    var_1.health = 9999999;
    var_1 thread sniperbloodsprayexitwoundtrace();
    var_2 = getent( "ScrambleRestaurantDoors", "targetname" );
    var_2.animname = "sniper_restaurant_door";
    var_2 maps\_utility::assign_animtree( "sniper_restaurant_door" );
    var_0 maps\_anim::anim_first_frame_solo( var_2, "RestaurantOpenDoor" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "RestaurantOpenDoor_idle", "scramble_open_restaurant" );
}

scramblecivfinale()
{
    thread scramblefinalecar();
    var_0 = [];
    maps\_utility::array_spawn_function_targetname( "ScrambleCivFinaleCower", ::scramblecivsetup );
    var_1 = maps\_utility::array_spawn_targetname( "ScrambleCivFinaleCower", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_1 );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.script_noteworthy == "FinaleCower04Org" || var_3.script_noteworthy == "FinaleCower05Org" )
            var_4 = 1;
        else
            var_4 = 0;

        var_3 thread scrambleciviliancower( undefined, var_4 );

        if ( var_3.script_noteworthy == "FinaleCower04" )
            soundscripts\_snd::snd_message( "finale_civ_04_cower", var_3 );
    }

    maps\_utility::array_spawn_function_targetname( "ScrambleCivFinaleFlee", ::scramblecivsetup );
    var_6 = maps\_utility::array_spawn_targetname( "ScrambleCivFinaleFlee", 1 );
    var_0 = maps\_utility::array_merge( var_0, var_6 );
    level.sniperalltargets = maps\_utility::array_merge( level.sniperalltargets, var_0 );

    foreach ( var_3 in var_6 )
    {
        if ( var_3.script_noteworthy == "FinaleFlee02" )
            var_8 = 1;
        else
            var_8 = 0;

        var_9 = "FlagTriggerScramblePlayerNearStreet";
        var_3 thread scramblecivilianflee( var_9, var_8, 0 );
    }

    common_scripts\utility::flag_wait( "FlagEndingStart" );
    var_0 = maps\_utility::array_removedead( var_0 );
    maps\_utility::array_notify( var_0, "delete" );
    wait 0.05;
    maps\_utility::array_delete( var_0 );
}

scramblefinalecar()
{
    level endon( "AmbushTimerFreeze" );
    var_0 = getent( "ScrambleFinaleCar", "targetname" );
    var_0 thread scramblevehicleexplodeondeath();

    for (;;)
    {
        var_0 waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( !isdefined( var_10 ) )
            return;

        if ( var_10 == "hms_rail_sniper" && isdefined( level.sniperpos ) )
        {
            var_0 maps\_vehicle::force_kill();
            var_11 = maps\_utility::get_living_ai( "FinaleCower07", "script_noteworthy" );

            if ( isdefined( var_11 ) )
            {
                var_11 maps\greece_code::kill_no_react( 0.0 );
                var_11 animscripts\notetracks::notetrackstartragdoll( "ragdoll" );
            }
        }

        waitframe();
    }
}

scrambleciviliancower( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    self pushplayer( 0 );
    self.allowpain = 0;
    self.animname = "generic";
    self.ignoresonicaoe = 1;
    var_2 = self.script_noteworthy + "Org";
    var_3 = common_scripts\utility::getstruct( var_2, "script_noteworthy" );

    if ( isdefined( var_3.targetname ) && var_3.targetname == "DronesCowerCasual" )
    {
        thread codescripts\character::setheadmodel( "head_f_act_cau_hamilton_base" );
        self setmodel( "civ_urban_female_body_b_olive" );
    }

    if ( var_1 == 1 )
        thread civkillwhennearplayer( 0 );

    var_4 = self.script_noteworthy;
    var_5 = var_4 + "_idle";
    var_6 = var_4 + "_end";
    thread maps\greece_code::setragdolldeath( var_6, var_3 );
    thread sniperbloodsprayexitwoundtrace();
    var_3 thread maps\_anim::anim_loop_solo( self, var_5, var_6 );
    var_7 = var_4 + "_reaction";

    if ( isdefined( var_7 ) && maps\_utility::hasanim( var_7 ) )
    {
        if ( isdefined( var_0 ) )
            common_scripts\utility::flag_wait( var_0 );
        else
        {
            for (;;)
            {
                if ( distancesquared( self.origin, level.player.origin ) < 40000 )
                    break;

                wait 0.1;
            }
        }

        self notify( var_6 );
        var_3 notify( var_6 );
        var_3 maps\_anim::anim_single_solo( self, var_7 );
        var_8 = var_4 + "_newidle";

        if ( isdefined( var_8 ) && maps\_utility::hasanim( var_8 ) )
            var_3 thread maps\_anim::anim_loop_solo( self, var_8, var_6 );
        else
            var_3 thread maps\_anim::anim_loop_solo( self, var_5, var_6 );
    }
}

scramblecivilianflee( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    self pushplayer( 0 );
    self.animname = "generic";
    self.ignoresonicaoe = 1;
    self.allowpain = 0;
    var_5 = self.script_noteworthy + "Org";
    var_6 = common_scripts\utility::getstruct( var_5, "script_noteworthy" );
    thread sniperbloodsprayexitwoundtrace();

    if ( var_3 == 1 )
        thread maps\greece_code::setragdolldeath();
    else
        maps\_hms_utility::printlnscreenandconsole( "No ragdoll death on " + self.script_noteworthy );

    if ( var_2 == 1 )
        thread civkillwhennearplayer();

    var_7 = self.script_noteworthy;
    var_8 = var_7 + "_idle";
    var_9 = var_7 + "_end";
    var_10 = var_7 + "_goal";
    var_11 = common_scripts\utility::getstruct( var_10, "targetname" );

    if ( isdefined( var_0 ) )
    {
        var_6 thread maps\_anim::anim_loop_solo( self, var_8, var_9 );
        common_scripts\utility::flag_wait( var_0 );
    }

    if ( isdefined( var_4 ) )
        wait(var_4);

    waitframe();

    if ( isdefined( self ) )
    {
        self notify( var_9 );
        var_6 notify( var_9 );
        maps\_utility::anim_stopanimscripted();
        var_12 = var_7 + "_reaction";

        if ( isdefined( var_11 ) )
            var_6 maps\_anim::anim_single_solo_run( self, var_12 );
        else
            var_6 maps\_anim::anim_single_solo( self, var_12 );
    }

    if ( isdefined( self ) )
    {
        var_13 = var_7 + "_newidle";

        if ( var_1 == 1 )
        {
            if ( isdefined( self.magic_bullet_shield ) )
                maps\_utility::stop_magic_bullet_shield();

            self.allowdeath = 1;
            self.a.nodeath = 1;
            self kill();
        }
        else if ( isdefined( var_13 ) && maps\_utility::hasanim( var_13 ) )
            var_6 thread maps\_anim::anim_loop_solo( self, var_13, var_9 );
        else
        {
            self.ignoresonicaoe = undefined;
            maps\greece_code::clearragdolldeath();

            if ( isdefined( var_11 ) )
                maps\_utility::set_goal_pos( var_11.origin );
            else
                maps\_utility::set_goal_pos( self.origin );
        }
    }
}

civkillwhennearplayer( var_0 )
{
    level endon( "ScrambleSniperKilled" );
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( var_0 == 1 )
        self endon( "goal" );

    for (;;)
    {
        wait 0.05;

        if ( isshotdelayed() )
            continue;

        var_1 = distancesquared( level.player.origin, self.origin );
        var_2 = randomintrange( 20000, 40000 );

        if ( var_1 <= var_2 )
        {
            if ( isdefined( self.magic_bullet_shield ) )
                maps\_utility::stop_magic_bullet_shield();

            soundscripts\_snd::snd_message( "windmill_sniper_shot_multi", self geteye() );
            var_3 = snipertargetgettagpos();
            snipershoot( var_3, 1.0, 1 );
        }
    }
}

scramblefinaleallies()
{
    var_0 = [];
    maps\_utility::array_spawn_function_targetname( "ScrambleFinaleAlly", maps\_utility::set_ignoreall, 1 );
    var_0 = maps\_utility::array_spawn_targetname( "ScrambleFinaleAlly", 1 );
    level.sniperalltargets = maps\_utility::array_merge( level.sniperalltargets, var_0 );

    foreach ( var_2 in var_0 )
    {
        var_2.health = 1;
        var_2.allowdeath = 1;
        var_2 maps\_utility::gun_remove();
        var_2 maps\_utility::set_ignoreall( 1 );
        var_2 maps\_utility::set_ignoreme( 1 );
        var_2 maps\_utility::set_battlechatter( 0 );
        var_2 thread maps\greece_code::setragdolldeath();
    }

    foreach ( var_2 in var_0 )
    {
        if ( var_2.script_noteworthy == "FinaleAlly01" )
        {
            var_2 thread scramblefinalefirstwoundedally();
            var_2 thread sniperbloodsprayexitwoundtrace( 1 );
            continue;
        }

        if ( var_2.script_noteworthy == "FinaleAlly02" )
        {
            var_2.name = "Rivers";
            var_2.animname = "Rivers";
            var_2.script_parameters = "Rivers";
        }
        else
        {
            var_2.name = " ";
            var_2.animname = "generic";
        }

        var_2 thread scramblefinaleextrawoundedally();
        var_2 thread sniperbloodsprayexitwoundtrace();
    }

    thread snipershootstingerpot();
    common_scripts\utility::flag_wait( "FlagEndingStart" );
    var_0 = maps\_utility::array_removedead( var_0 );
    maps\_utility::array_notify( var_0, "delete" );
    wait 0.05;
    maps\_utility::array_delete( var_0 );
}

scramblefinalefirstwoundedally()
{
    var_0 = common_scripts\utility::getstruct( "ScrambleIlanaLookAllyOrg", "targetname" );
    var_1 = "sanchez_wounded_idle";
    self.name = "Torres";
    self.animname = "Torres";
    self.script_parameters = "Torres";
    self.health = 10000;
    self.maxhealth = 10000;
    var_0 thread maps\_anim::anim_loop_solo( self, var_1, "wounded_loop_end" );
}

scramblefinaleextrawoundedally()
{
    self endon( "death" );
    var_0 = self.script_noteworthy + "Org";
    var_1 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
    var_2 = var_1.animation;
    var_1 thread maps\_anim::anim_first_frame_solo( self, var_2 );
    var_3 = self.script_noteworthy + "Trig";
    maps\_utility::trigger_wait_targetname( var_3 );
    var_1 maps\_anim::anim_single_solo( self, var_2 );
    maps\greece_code::kill_no_react( 0.0 );
}

monitorplayerfirerpgattower()
{
    var_0 = getent( "ScrambleSniperWindow", "targetname" );
    level endon( "ScrambleSniperKilled" );
    level.player waittill( "missile_fire", var_1, var_2 );
    thread firestingerrumble();
    common_scripts\utility::flag_set( "FlagScramblePlayerFireMissile" );
    thread slowmotiontowerdestruction();
}

firestingerrumble()
{
    level.player playrumbleonentity( "artillery_rumble" );
    earthquake( 0.5, 0.3, level.player.origin, 100 );
}

slowmotiontowerdestruction()
{
    level.sniperpos.bsniperenabled = 0;
    level.player enableinvulnerability();
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player allowjump( 0 );
    level.player allowsprint( 0 );
    level.player allowdodge( 0 );
    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
    wait 1.5;
    level.player disableinvulnerability();
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player allowjump( 1 );
    level.player allowsprint( 1 );
    level.player allowdodge( 1 );
}

monitormantlevols()
{
    while ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        if ( level.player ismantling() )
        {
            physicsexplosionsphere( level.player.origin, 200, 0, 0.1 );
            glassradiusdamage( level.player.origin, 500, 1000, 100 );
            wait 1.0;
        }

        wait 0.05;
    }
}

monitorlastweapon()
{
    level.player endon( "death" );
    level endon( "missionfailed" );
    wait 0.5;
    self.saved_lastweapon = undefined;

    while ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        var_0 = maps\_utility::get_storable_current_weapon();

        if ( var_0 == "iw5_stingerm7greece_sp" )
        {
            common_scripts\utility::flag_set( "FlagScramblePlayerHasStinger" );
            break;
        }

        if ( isdefined( var_0 ) && var_0 != "none" && var_0 != "c4" )
        {
            if ( !isdefined( self.saved_lastweapon ) || var_0 != self.saved_lastweapon )
                self.saved_lastweapon = var_0;
        }

        wait 0.05;
    }
}

stingerpronestatemonitor()
{
    level.player endon( "death" );
    level endon( "missionfailed" );

    while ( !common_scripts\utility::flag( "FlagScrambleSniperKilled" ) )
    {
        var_0 = self getcurrentweapon();

        if ( var_0 == "iw5_stingerm7greece_sp" )
            level.player allowprone( 0 );
        else
            level.player allowprone( 1 );

        wait 0.05;
    }
}

sniperbloodsprayexitwoundtrace( var_0 )
{
    self endon( "delete" );
    self endon( "bloodless" );
    var_1 = 1000;
    var_2 = "TAG_WEAPON_CHEST";

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( var_0 == 1 )
        self waittill( "damage", var_4, var_12, var_3, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
    else
        self waittill( "death", var_4, var_12, var_13 );

    if ( !isdefined( var_12 ) )
        return;

    if ( var_12 == "hms_rail_sniper" && isdefined( level.sniperpos ) )
    {
        var_14 = self gettagorigin( var_2 );
        var_15 = level.sniperpos.origin;
        var_16 = vectortoangles( var_14 - var_15 );
        var_17 = var_14 + var_16 * var_1;
        var_18 = bullettrace( var_14, var_17, 0 );

        if ( isdefined( var_18["position"] ) )
        {
            var_19 = var_18["position"];
            playfx( common_scripts\utility::getfx( "blood_impact_splat" ), var_19 );
            soundscripts\_snd::snd_message( "mhunt_snpr_blood_impact_splat" );
        }
    }
}

scramblesetupexittruck()
{
    var_0 = common_scripts\utility::getstruct( "ScrambleTruckExitOrg", "targetname" );
    var_1 = getent( "ScrambleExitTruck", "targetname" );
    var_1 maps\_utility::assign_animtree( "exit_truck" );
    var_1.animname = "exit_truck";
    var_0 maps\_anim::anim_first_frame_solo( var_1, "move_truck" );
}

monitormovetruckinteract()
{
    var_0 = getent( "UseTriggerScrambleMoveTruckInteract", "targetname" );
    var_0 makeusable();
    thread scramblemonitormovetruckhint();
    var_0 maps\_utility::addhinttrigger( &"GREECE_HINT_MOVE_TRUCK", &"GREECE_HINT_MOVE_TRUCK_KB" );
    var_0 waittill( "trigger", var_1 );
    var_0 delete();
    level notify( "ScramblePlayerMoveTruck" );
    common_scripts\utility::flag_set( "FlagScramblePlayerStartMoveTruck" );
    thread playermovetruck();
    thread maps\greece_code::sunflareswap( "sunflare_dim" );
}

scramblemonitormovetruckhint()
{
    var_0 = getent( "ScrambleMoveTruckObj", "targetname" );
    var_1 = maps\_shg_utility::hint_button_position( "use", var_0.origin, 128 );
    common_scripts\utility::flag_wait( "FlagScramblePlayerStartMoveTruck" );
    var_1 maps\_shg_utility::hint_button_clear();
}

playermovetruck()
{
    common_scripts\utility::flag_wait( "FlagScramblePlayerStartMoveTruck" );
    var_0 = common_scripts\utility::getstruct( "ScramblePlayerExitOrg", "targetname" );
    soundscripts\_snd::snd_message( "finale_street_crowd" );
    thread maps\greece_ending::endingburningsniper();
    var_1 = maps\_utility::spawn_anim_model( "player_scramble_rig", var_0.origin, var_0.angles );
    var_1 hide();
    var_0 maps\_anim::anim_first_frame_solo( var_1, "move_truck" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    level.player playerlinktoblend( var_1, "tag_player", 0.3 );
    wait 0.3;
    var_1 show();
    thread ilanamovetruck();
    thread truckmovetruck();
    var_0 maps\_anim::anim_single_solo( var_1, "move_truck" );
    level.player unlink();
    level.player thread maps\_shg_utility::setup_player_for_gameplay();
    var_1 delete();

    if ( level.currentgen )
        thread closeendinggatestransition();

    thread maps\_utility::autosave_by_name( "scramble_move_truck_end" );
    common_scripts\utility::flag_set( "FlagScramblePlayerEndMoveTruck" );
}

truckmovetruck()
{
    var_0 = common_scripts\utility::getstruct( "ScrambleTruckExitOrg", "targetname" );
    var_1 = getent( "ScrambleExitTruck", "targetname" );
    var_2 = getent( "ScrambleExitCarClip", "targetname" );
    thread maps\greece_sniper_scramble_fx::movetrucktiresmokefx();
    var_2 delete();
    var_0 maps\_anim::anim_single_solo( var_1, "move_truck" );
}

gondolaanimation()
{
    var_0 = getent( "gondolaOrg", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "gondola_01" );
    var_2 = maps\_utility::spawn_anim_model( "gondola_02" );
    var_3 = maps\_utility::spawn_anim_model( "gondola_03" );
    var_4 = maps\_utility::spawn_anim_model( "gondola_04" );
    var_5 = [ var_1, var_2, var_3, var_4 ];
    wait 2;
    var_0 thread maps\_anim::anim_loop( var_5, "gondola_loop", "stop_gondolas" );
    soundscripts\_snd::snd_message( "gondola_movement_loops", var_5 );
    common_scripts\utility::flag_wait( "FlagScramblePlayerStartMoveTruck" );
    level notify( "stop_gondola_audio" );
    var_0 notify( "stop_gondolas" );
    maps\_utility::array_delete( var_5 );
}

pitbulldestroyedanimation()
{
    var_0 = getent( "pitbull_veh", "targetname" );
    var_0.animname = "pitbull_veh";
    var_0 maps\_utility::assign_animtree( "pitbull_veh" );
    var_0 maps\_anim::anim_loop_solo( var_0, "pitbull_destroyed" );
}

scrambledestroycafewall()
{
    var_0 = getentarray( "cafe_wall_clean", "targetname" );
    var_1 = getentarray( "cafe_wall_destroyed", "targetname" );

    if ( level.nextgen )
    {
        foreach ( var_3 in var_1 )
            var_3 hide();
    }

    common_scripts\utility::flag_wait( "FlagTriggerScramblePlayerNearThirdJump" );
    thread snipershootcafewall();

    foreach ( var_3 in var_1 )
        var_3 show();

    foreach ( var_3 in var_0 )
        var_3 delete();
}

initsniperscramblesuppressionfeedback()
{
    if ( isdefined( self.hud_damagefeedback ) )
        self.saved_hud_damagefeedback = self.hud_damagefeedback;

    self.hud_damagefeedback = newclienthudelem( self );
    self.hud_damagefeedback.horzalign = "center";
    self.hud_damagefeedback.vertalign = "middle";
    self.hud_damagefeedback.x = -12;
    self.hud_damagefeedback.y = -12;
    self.hud_damagefeedback.alpha = 0;
    self.hud_damagefeedback.archived = 1;
    self.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
    level waittill( "ScrambleSniperKilled" );

    if ( isdefined( self.saved_hud_damagefeedback ) )
    {
        self.hud_damagefeedback destroy();
        self.hud_damagefeedback = self.saved_hud_damagefeedback;
    }
}

updatesuppressionfeedback()
{
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime( 1 );
    self.hud_damagefeedback.alpha = 0;
    soundscripts\_snd::snd_message( "sniper_suppression_hit_alert" );
}

monitorsnipertowersuppressiondamage()
{
    level endon( "ScrambleSniperKilled" );
    var_0 = getent( "ScrambleSniperWindow", "targetname" );

    while ( isdefined( var_0 ) )
    {
        var_0 waittill( "bullethit", var_1 );

        if ( isdefined( var_1 ) )
        {
            if ( isplayer( var_1 ) )
                var_1 thread updatesuppressionfeedback();
        }

        waitframe();
    }
}

civsniperdamagemonitor()
{
    self endon( "delete" );
    self waittill( "death", var_0, var_1, var_2 );

    if ( isdefined( var_2 ) && var_2 == "hms_rail_sniper" )
    {
        var_3 = self gettagorigin( "J_Spine4" );
        var_4 = createsniperimpulse( var_3 );
        self.a.nodeath = 1;
        animscripts\notetracks::notetrackstartragdoll( "ragdoll" );
        self stopanimscripted();
        wait 0.1;
        physicsexplosionsphere( var_4, 32, 0, 5 );
    }
}

createsniperimpulse( var_0 )
{
    var_1 = 128;
    var_2 = ( level.sniperpos.origin - var_0 ) * ( 1, 1, 0 );
    var_2 = vectornormalize( var_2 );
    var_3 = var_0 + var_2 * 16;

    if ( level.sniper_scramble_data.draw_debug == 1 )
        thread maps\_utility::draw_circle_for_time( var_3, var_1, 1, 0, 0, 5.0 );

    return var_3;
}

snipertargetgettagpos()
{
    var_0 = undefined;

    if ( common_scripts\utility::cointoss() )
        var_0 = self gettagorigin( "TAG_EYE" );
    else
        var_0 = self gettagorigin( "J_Spine4" );

    return var_0;
}

closeendinggatestransition()
{
    maps\_utility::trigger_wait_targetname( "close_gate_before_hades_fight" );
    thread closeendinggates();
    thread scramblesetupexittruck();
    level notify( "tff_pre_outro_to_hades_fight" );
    unloadtransient( "greece_outro_tr" );
    loadtransient( "greece_hades_fight_tr" );

    while ( !istransientloaded( "greece_hades_fight_tr" ) )
        wait 0.05;

    level notify( "tff_post_outro_to_hades_fight" );
}

closeendinggates()
{
    var_0 = getent( "left_gate_to_close", "targetname" );
    var_1 = getent( "right_gate_to_close", "targetname" );
    var_2 = getent( "block_alley_gate", "targetname" );
    var_2 moveto( ( var_2.origin[0], var_2.origin[1], var_2.origin[2] + 104 ), 0.1 );
    var_0 rotateyaw( -95, 0.6 );
    var_1 rotateyaw( 110, 0.4 );
}

scramblefiredamagemonitor()
{
    var_0 = getent( "ScrambleTruckFire", "targetname" );
    thread scrambletruckfiredamagevol( var_0, "AmbushTimerFreeze" );
    var_1 = getent( "ScrambleTruckFireA", "targetname" );
    thread scrambletruckfiredamagevol( var_1, "ScramblePlayerMoveTruck" );
    common_scripts\utility::flag_wait( "FlagScramblePlayerStartMoveTruck" );
    var_2 = getent( "ScrambleTruckFireB", "targetname" );
    thread scrambletruckfiredamagevol( var_2, "AmbushTimerFreeze" );
}

scrambletruckfiredamagevol( var_0, var_1 )
{
    level endon( var_1 );

    for (;;)
    {
        var_0 waittill( "trigger", var_2 );
        var_2 dodamage( 5, var_0.origin, var_0, var_0, "MOD_CRUSH" );
        wait 0.1;
    }
}

scramblerestaurantexitclip( var_0 )
{
    var_1 = getent( "ScrambleRestaurantExitClipVol", "targetname" );

    if ( var_0 == 1 )
        var_2 = 128;
    else
        var_2 = -128;

    var_3 = var_1.origin;
    var_4 = var_3 + ( -10, 0, var_2 );
    var_1 moveto( var_4, 0.1 );
}

scramblevisitorcentergateopen()
{
    var_0 = getent( "AlleysVisitorCenterGate", "targetname" );
    var_0.animname = "visitorgate";
    var_0 maps\_utility::assign_animtree( "visitorgate" );
    var_1 = getent( "AlleysVisitorCenterGateCollision", "targetname" );
    var_1 linkto( var_0, "jo_gate_door" );
    var_2 = getent( "AlleysVisitorCenterGateUseTrigger", "targetname" );
    var_2 makeunusable();
    var_3 = common_scripts\utility::getstruct( "AlleysVisitorCenterGateRipOrg", "targetname" );
    var_4 = "alleys_gate_rip";
    var_3 maps\_anim::anim_last_frame_solo( var_0, var_4 );
    var_1 connectpaths();
}

torresblood()
{
    var_0 = getent( "TorresBlood", "targetname" );
    var_0 hide();
    common_scripts\utility::flag_wait( "FlagScrambleWoundedSoldierKilled" );
    var_0 show();
    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
    var_0 delete();
}

destroydroppedgun()
{
    level endon( "ScrambleSniperKilled" );

    for (;;)
    {
        level.player waittill( "pickup", var_0, var_1 );

        if ( level.player hasweapon( "iw5_stingerm7greece_sp" ) )
        {
            if ( isdefined( var_1 ) )
            {
                var_1 delete();
                break;
            }
        }

        waitframe();
    }
}

scramblevehicleexplodeondeath()
{
    level endon( "AmbushTimerFreeze" );
    self waittill( "death" );
    radiusdamage( self.origin, 200, 100, 10 );
    physicsexplosionsphere( self.origin, 300, 100, 1.5 );
    earthquake( 0.5, 0.3, self.origin, 600 );
}
