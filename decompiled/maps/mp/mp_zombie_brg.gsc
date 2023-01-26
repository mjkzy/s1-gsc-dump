// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_zombie_brg_precache::main();
    maps\createart\mp_zombie_brg_art::main();
    maps\mp\mp_zombie_brg_fx::main();
    level.zmbaudioattractorwait = 8;
    level.numkitingconversations = 0;
    maps\mp\_load::main();
    maps\mp\mp_zombie_brg_lighting::main();
    maps\mp\mp_zombie_brg_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_zombie_brg" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.zombiehostinit = maps\mp\zombies\zombie_host::init;
    level.zombiedoginit = maps\mp\zombies\zombie_dog::init;
    level.dlcleaderboardnumber = 2;
    level._id_0A9D = 0;
    level.disable_water_weapon_swap = 1;
    level.laststandinwaterfunc = ::laststandinwater;
    level thread _id_A75F::init();
    thread disablepronevolumecheck();
    level.enabledzonepickupdrop = 1;
    level.zombies_using_civilians = 1;
    level.civ_extract = spawnstruct();
    level.civrounds = 0;
    level.firstcivilianround = 6;
    level.onstartgametypelevelfunc = ::onzombieburgertownstartgame;
    maps\mp\zombies\_zombies_rewards::init();
    precacheburgertown();
    level.zombielevelinit = ::initburgertown;
    level.zombieroundstartupdate = ::roundstartupdate;
    level.calculateroundtypeoverridefunc = ::calculateroundtype;
    level.specialmutatorstartingroundoverridefunc = ::getspecialmutatorstartinground;
    level.spawnzombiekilledfxfunc = ::spawnzombiekilledfx;
    level.noflashemzfunc = ::noflashemzhitfx;
    level.noemzflashzones = [ "sewermain_vol", "sewertrans_vol", "sewerpit_vol", "sewertunnel_vol", "sewerexit_vol", "sewercave_vol" ];
    level.mutatortablesetupfunc = ::buildmutatortable;
    level.shouldspecialmutatorapplyfunc = ::shouldapplyspecialmutator;
    level.zombieinfectedvisionset = "mp_zombie_lab_infected";
    level.zombieinfectedlightset = "mp_zombie_lab_infected";
    level.allowzombierecycle = 1;
    level.wavecycleoverride = 6;
    level.burgertownspecialroundcounter = 0;
    thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
    level.usezoneconnectiontombstonescoring = 1;
    thread initmutators();
    thread initzones();
    thread initextractions();
    thread initcharactermodels();
    thread upcomingcivilianroundmonitor();
    thread inittoxiczones();
    thread sewerscurestationdisablespawning();
    initweapons();
    thread initrollupdoors();

    if ( level.nextgen )
        thread spinningpitbullwheel();

    thread maps\mp\mp_zombie_brg_sq::init_sidequest();
    thread warbirdintro();
    level.spawnanimationnotetrackhandlerassigner = ::spawnanimationnotetrackhandlerassigner;
    level.zombiespawnfxcount = 0;
    precacheminimapicon( "hud_waypoint_survivor" );
    thread laddertriggersetup();
    thread exploittrigger();
    thread enablespecialweaponlevelbox();
    thread flyoverbink();
    thread updateburgertowndoorcosts();
    thread updateburgertowntrapcosts();

    if ( level.currentgen )
        thread setstaticscriptmodels();

    if ( level.nextgen )
    {
        thread spawnpatchclipfixes();
        thread windowexploitledgelogic();
        thread shoveplayer();
    }

    if ( level.currentgen )
    {
        var_0 = getentarray( "cg_window_ledge", "targetname" );

        foreach ( var_2 in var_0 )
            var_2 thread windowexploitledgelogicthink();
    }

    thread fixstuckzombie01();
    thread destroypatioglass();
}

fixstuckzombie01()
{
    var_0 = getnodesinradius( ( 1800.0, -1526.0, 240.0 ), 10, 0 );
    disconnectnodepair( var_0[0], getnode( var_0[0].target, "targetname" ) );
}

laststandinwater()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( isdefined( self._id_4FAA ) && self._id_4FAA == 1 && isdefined( self._id_519C ) && self._id_519C == 1 )
        {
            self stopshellshock();
            self._id_519C = 0;
        }

        wait 0.05;
    }
}

laddertriggersetup()
{
    var_0 = getentarray( "ladder_check_volume", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread laddermonitor();
}

laddermonitor()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) )
        {
            if ( isdefined( var_0.laddercheck ) )
                continue;
            else if ( var_0 isonladder() )
            {
                var_0.laddercheck = 1;
                ladderdisablethink( var_0 );
            }
        }
    }
}

ladderdisablethink( var_0 )
{
    level endon( "game_ended" );
    var_1 = self;
    var_2 = gettime() + 5000;

    while ( gettime() < var_2 )
    {
        wait 0.2;

        if ( !var_0 isonladder() )
        {
            var_0.laddercheck = undefined;
            return;
        }

        var_3 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );
        var_4 = 1;

        foreach ( var_6 in var_3 )
        {
            if ( var_6 istouching( var_1 ) && var_0 isonladder() )
            {
                var_4 = 0;
                break;
            }
        }

        if ( var_4 == 1 )
        {
            var_0 _meth_8302( 1 );
            var_0.laddercheck = undefined;
            return;
        }
    }

    var_0 _meth_8302( 0 );
    var_0 thread ladderenablethink();
}

ladderenablethink()
{
    level endon( "game_ended" );
    wait 10.0;
    self _meth_8302( 1 );
    self.laddercheck = undefined;
}

disablepronevolumecheck()
{
    level endon( "game_ended" );
    var_0 = getentarray( "sewers_water_no_prone", "targetname" );

    foreach ( var_2 in var_0 )
    {
        for (;;)
        {
            var_2 waittill( "trigger", var_3 );

            if ( isplayer( var_3 ) )
                var_3 thread disableprone( var_2 );
        }
    }
}

disableprone( var_0 )
{
    self notify( "noprone" );
    self endon( "noprone" );
    self endon( "disconnect" );

    while ( self istouching( var_0 ) )
    {
        self _meth_811A( 0 );
        wait 0.5;
    }

    self _meth_811A( 1 );
}

setstaticscriptmodels()
{
    var_0 = getentarray( "static_entity", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8560();
}

updateburgertowndoorcosts()
{
    var_0 = "mp/dlc2CostTable.csv";
    var_1 = 0;
    var_2 = 1;
    var_3 = common_scripts\utility::getstructarray( "door", "targetname" );
    wait 5;

    foreach ( var_5 in var_3 )
    {
        if ( !isdefined( var_5._id_79CE ) )
            continue;

        var_5.cost = int( tablelookup( var_0, var_1, var_5._id_79CE, var_2 ) );

        if ( var_5 thread maps\mp\zombies\_doors::door_requires_power() )
            continue;

        foreach ( var_7 in var_5.triggers )
            var_7 _meth_80DC( maps\mp\zombies\_util::getcoststring( var_5.cost ) );
    }
}

updateburgertowntrapcosts()
{
    var_0 = "mp/dlc2CostTable.csv";
    var_1 = 0;
    var_2 = 1;
    wait 5;

    foreach ( var_4 in level.traps )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        var_4.cost = int( tablelookup( var_0, var_1, var_4.script_noteworthy, var_2 ) );
    }
}

initextractions()
{
    maps\mp\zombies\_civilians::registerextractioninitevent( "warbird", maps\mp\zombies\_extraction::warbirdextractioninit );
    maps\mp\zombies\_civilians::registerextractionescortevent( "warbird", maps\mp\zombies\_extraction::warbirdextractionescort );
    maps\mp\zombies\_civilians::registerextractionevent( "warbird", maps\mp\zombies\_extraction::warbirdextraction );
}

warbirdintro()
{
    wait 2;
    var_0 = common_scripts\utility::getstructarray( "warbird_intro", "targetname" );
    var_1 = common_scripts\utility::random( var_0 );
    var_2 = spawnhelicopter( level.players[0], var_1.origin, var_1.angles, "warbird_player_mp", "vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak" );
    var_2 _meth_828B();
    var_2 scalevolume( 0 );
    var_2 playloopsound( "veh_warbird_fly_over" );
    var_2 scalevolume( 1, 5 );
    wait 3;
    var_2 thread warbirdintroflightpath( var_1 );
}

warbirdintroflightpath( var_0 )
{
    self endon( "death" );
    var_1 = var_0;

    for (;;)
    {
        var_1 = common_scripts\utility::getstruct( var_1.target, "targetname" );
        maps\mp\zombies\_extraction::_id_A18F( self, var_1, 25 );

        if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "warbird_exit" )
            self delete();

        wait 0.05;
    }
}

initmutators()
{
    maps\mp\zombies\_mutators::initexplodermutator();
    maps\mp\zombies\_mutators::initemzmutator();
    maps\mp\zombies\_mutators_spiked::initspikedmutator();
    maps\mp\zombies\_mutators_acid::initacidmutator();
    maps\mp\zombies\_mutators_armor::initarmormutator();
}

buildmutatortable()
{
    for (;;)
    {
        level.special_mutators = [];
        var_0 = getburgertownrandommutators();
        var_1 = 1;
        var_2 = 1;
        level waittill( "zombie_round_countdown_started" );

        if ( level.wavecounter >= 8 )
            var_2 = 2;

        for ( var_3 = 0; var_3 < var_2; var_3++ )
        {
            var_4 = common_scripts\utility::random( var_0 );
            var_0 = common_scripts\utility::array_remove( var_0, var_4 );

            if ( var_4 == "acid" )
            {
                level.special_mutators[var_4] = [ ::shouldapplyacidmutator, var_1 ];
                continue;
            }

            level.special_mutators[var_4] = [ ::shouldapplymutator, var_1 ];
        }

        if ( level.wavecounter >= 5 )
        {
            if ( level.wavecounter >= 12 )
                var_1 = 2;
            else
                var_1 = 1;

            level.special_mutators["emz"] = [ ::shouldapplymutator, var_1 ];
        }

        level waittill( "zombie_wave_ended" );
    }
}

getburgertownrandommutators()
{
    var_0 = [];

    if ( level.wavecounter < 6 )
        var_0 = [ "armor", "acid", "spiked" ];
    else if ( level.wavecounter >= 6 )
        var_0 = [ "armor", "exploder", "acid", "spiked" ];
    else if ( level.wavecounter >= 12 )
        var_0 = [ "exploder", "acid", "spiked" ];

    return var_0;
}

shouldapplyacidmutator( var_0 )
{
    if ( level.activeacidzombies >= level.maxacidzombies )
        return 0;

    return 1;
}

shouldapplymutator( var_0 )
{
    if ( level.wavecounter < 3 )
        return 0;

    if ( level.special_mutators.size == 0 )
        return 0;

    return 1;
}

shouldapplyspecialmutator( var_0 )
{
    if ( self.agent_type == "zombie_dog" && level.wavecounter < 15 )
        return 0;
    else if ( self.agent_type == "zombie_dog" && level.wavecounter > 25 )
        return 1;

    return undefined;
}

precacheburgertown()
{
    maps\mp\zombies\_civilians::precachestrings();
}

initburgertown()
{
    maps\mp\zombies\zombie_melee_goliath::init();
    maps\mp\zombies\zombie_murderbot::init();
    level.roundspawndelayfunc["normal"] = ::calculatenormalroundspawndelay;
    level.roundspawndelayfunc["civilian"] = ::calculatecivilianroundspawndelay;
    level.candroppickupsfunc["normal"] = ::burgertowncandroppickups;
    level.candroppickupsfunc["civilian"] = ::burgertowncancivilianrounddroppickups;
    level.nummaxenemiesthisroundfunc["civilian"] = ::civilianroundmaxnumenemies;
    level.spawnzombiesoverridefunc = maps\mp\zombies\_zombies_burgertown_spawning::spawnzombies;
    maps\mp\zombies\_zombies_burgertown_spawning::init();
    maps\mp\zombies\_civilians::init();
    level.assignzombiemeshoverridefunc = ::assignzombiemesh;
    common_scripts\utility::flag_init( "no_more_burgertown_employees" );
    level thread burgertownemployeemonitor();
    level.mutatorfunc["zombie_generic"] = ::applyburgertownzombiemutator;
}

burgertownemployeemonitor()
{
    level endon( "game_ended" );
    common_scripts\utility::flag_wait( "no_more_burgertown_employees" );

    if ( !common_scripts\utility::flag( "sewer_to_burgertown" ) )
        common_scripts\utility::flag_wait( "sewer_to_burgertown" );

    var_0 = maps\mp\zombies\_util::agentclassget( "zombie_generic" );
    var_0.model_heads[var_0.model_heads.size] = [ "zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b" ];
    var_0.model_bodies[var_0.model_bodies.size] = [ "zom_civ_brg_employee_torso_slice" ];
    var_1["right_leg"] = [ "zom_civ_ruban_male_r_leg_slice" ];
    var_1["left_leg"] = [ "zom_civ_ruban_male_l_leg_slice" ];
    var_1["right_arm"] = [ "zom_civ_brg_employee_r_arm_slice" ];
    var_1["left_arm"] = [ "zom_civ_brg_employee_l_arm_slice" ];
    var_0.model_limbs[var_0.model_limbs.size] = var_1;
    level.exobodyparts["zom_civ_brg_employee_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_civ_brg_employee_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_civ_brg_employee_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_civ_brg_employee_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_civ_brg_employee_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
}

assignzombiemesh()
{
    if ( !isdefined( self.agent_type ) || self.agent_type != "zombie_generic" )
        return 0;

    if ( common_scripts\utility::flag( "sewer_to_burgertown" ) && shouldbeburgertownzombie() )
    {
        var_0 = [ "zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b" ];
        self setmodel( "zom_civ_brg_employee_torso_slice" );
        var_1 = common_scripts\utility::random( var_0 );
        self attach( var_1 );
        thread burgertownemployeeattachhat();
        self attach( "zom_civ_ruban_male_r_leg_slice" );
        self attach( "zom_civ_ruban_male_l_leg_slice" );
        self attach( "zom_civ_brg_employee_r_arm_slice" );
        self attach( "zom_civ_brg_employee_l_arm_slice" );
        self.burgertownemployee = 1;
        level.burgertownzombiesthisround++;
        return 1;
    }

    return 0;
}

burgertownemployeeattachhat()
{
    self attach( "brg_hat_01", "J_helmet" );
}

applyburgertownzombiemutator( var_0 )
{
    if ( !isdefined( var_0.burgertownemployee ) )
        maps\mp\zombies\zombies_spawn_manager::applyzombiemutator( var_0 );
}

shouldbeburgertownzombie()
{
    if ( common_scripts\utility::flag( "no_more_burgertown_employees" ) )
        return 0;

    var_0 = 6;
    var_1 = 3;
    var_2 = 6;

    if ( level.wavecounter < var_2 )
        return 0;

    var_3 = int( ( level.wavecounter - var_2 ) * 0.25 );
    var_4 = max( var_1, var_0 - var_3 );

    if ( level.burgertownzombiesthisround >= var_4 )
        return 0;

    var_5 = 0.25;
    return randomfloat( 1.0 ) < var_5;
}

civilianroundmaxnumenemies( var_0 )
{
    return var_0 - 1;
}

roundstartupdate()
{
    level.burgertownzombiesthisround = 0;
}

calculateroundtype()
{
    if ( !isdefined( level.nextcivilianround ) )
    {
        calculatenextcivilianround();
        calculatenextspecialround();
    }

    if ( level.wavecounter < 12 )
        var_0 = getscriptedroundtype();
    else
        var_0 = calculatenextroundtype();

    if ( var_0 == "civilian" )
        level thread activatecivilianround();
    else
        level.spawnzombiesoverridefunc = maps\mp\zombies\_zombies_burgertown_spawning::spawnzombies;

    return var_0;
}

getscriptedroundtype()
{
    if ( level.wavecounter == level.firstcivilianround )
        return "civilian";

    if ( level.wavecounter == 8 )
        return "zombie_host";

    if ( level.wavecounter == 10 )
        return "zombie_melee_goliath";

    return "normal";
}

calculatenextroundtype()
{
    if ( level.wavecounter == level.nextcivilianround )
    {
        calculatenextcivilianround();
        return "civilian";
    }

    if ( level.wavecounter == level.nextspecialround )
    {
        calculatenextspecialround();
        return getspecialroundtype();
    }

    level.spawnzombiesoverridefunc = maps\mp\zombies\_zombies_burgertown_spawning::spawnzombies;
    return "normal";
}

getspecialroundtype()
{
    var_0 = [ "zombie_host", "zombie_melee_goliath" ];
    var_1 = common_scripts\utility::mod( level.burgertownspecialroundcounter, var_0.size );

    switch ( var_1 )
    {
        case 0:
            var_1 = "zombie_host";
            break;
        case 1:
            var_1 = "zombie_melee_goliath";
            break;
        default:
            var_1 = var_0[0];
            break;
    }

    level.burgertownspecialroundcounter++;
    return var_1;
}

upcomingcivilianroundmonitor()
{
    level endon( "game_ended" );

    for (;;)
        level waittill( "upcoming_civilian_round" );
}

activatecivilianround()
{
    level endon( "game_ended" );
    level.civrounds++;
    updatecivilianextractionpoints();
    level thread maps\mp\zombies\_civilians::spawncivilian( "zombie_civilian" );
    level.shouldwaveendoverridefunc = ::shouldcivilianroundend;
    level.spawnzombiesoverridefunc = maps\mp\zombies\_zombies_burgertown_spawning::spawnzombiescivilianround;
    playsoundatpos( ( 0.0, 0.0, 0.0 ), "zmb_civ_extract_rnd_start" );
    level waittill( "zombie_wave_ended" );
    level.shouldwaveendoverridefunc = undefined;
}

shouldcivilianroundend( var_0, var_1 )
{
    if ( level.numberofalivecivilians > 0 || isdefined( level.waitingforcivilianspawn ) )
        return 0;

    return var_0 >= var_1;
}

calculatenextcivilianround()
{
    var_0 = 12;
    var_1 = 5;

    if ( !isdefined( level.nextcivilianround ) )
        level.nextcivilianround = var_0;
    else
        level.nextcivilianround += var_1;
}

calculatenextextractionpointreset()
{
    level.resetextractionpointround = level.wavecounter + 20;
}

calculatenextspecialround()
{
    var_0 = 2;
    var_1 = 3;
    level.nextspecialround = level.nextcivilianround + randomintrange( var_0, var_1 );
}

calculatenormalroundspawndelay( var_0, var_1 )
{
    return maps\mp\zombies\zombies_spawn_manager::calculatespawndelay();
}

calculatecivilianroundspawndelay( var_0, var_1 )
{
    var_2 = 2.0;
    return maps\mp\zombies\zombies_spawn_manager::calculatespawndelay( var_2 );
}

getspecialmutatorstartinground()
{
    return 3;
}

calculatenexttoxicgasround()
{
    var_0 = 11;

    if ( !isdefined( level.nexttoxicgasround ) )
        level.nexttoxicgasround = var_0;
    else
        level.nexttoxicgasround += randomintrange( 3, 5 );
}

initzones()
{
    maps\mp\zombies\_zombies_zone_manager::init();
    maps\mp\zombies\_zombies_zone_manager::initializezone( "warehouse_office_vol", 1 );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "warehouse_atlas_vol", 1 );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "warehouse_gas_vol", 1 );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "gas_station_pit_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "gas_station_bldg_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "gas_station_pumps_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "gas_station_awning_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "atlas_north_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "atlas_center_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "atlas_south_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "atlas_pit_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "atlas_command_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "atlas_surplus_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "burgertown_trench_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "burgertown_parking_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "burgertown_roof_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "burgertown_int_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "burgertown_east_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "burgertown_west_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "sewermain_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "sewertrans_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "sewerpit_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "sewertunnel_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "sewerexit_vol" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "sewercave_vol" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "warehouse_gas_vol", "gas_station_pumps_vol", "warehouse_to_gas_station" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "warehouse_atlas_vol", "atlas_center_vol", "warehouse_to_atlas" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "gas_station_pit_vol", "sewertrans_vol", "gas_station_to_sewer" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_pit_vol", "sewermain_vol", "atlas_to_sewer" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "sewertrans_vol", "sewertunnel_vol", "sewertrans_to_sewertunnel", 1 );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "sewertunnel_vol", "sewerexit_vol", "sewertrans_to_sewertunnel" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "sewermain_vol", "sewercave_vol", "sewermain_to_sewercave", 1 );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "sewerexit_vol", "burgertown_trench_vol", "sewer_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_south_vol", "atlas_command_vol", "atlas_command", 1 );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_pit_vol", "atlas_command_vol", "atlas_command", 1 );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "warehouse_office_vol", "warehouse_atlas_vol", "warehouse_start" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "warehouse_office_vol", "warehouse_gas_vol", "warehouse_start" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "warehouse_atlas_vol", "warehouse_gas_vol", "warehouse_start" );
    common_scripts\utility::flag_set( "warehouse_start" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "sewermain_vol", "sewertrans_vol", "any_zone_to_sewer" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "sewermain_vol", "sewerpit_vol", "any_zone_to_sewer" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "sewertrans_vol", "sewerpit_vol", "any_zone_to_sewer" );
    maps\mp\zombies\_util::flag_link( "atlas_to_sewer", "any_zone_to_sewer" );
    maps\mp\zombies\_util::flag_link( "gas_station_to_sewer", "any_zone_to_sewer" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "gas_station_pumps_vol", "gas_station_pit_vol", "any_zone_to_gas_station" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "gas_station_pumps_vol", "gas_station_bldg_vol", "any_zone_to_gas_station" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "gas_station_pumps_vol", "gas_station_awning_vol", "any_zone_to_gas_station" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "gas_station_pit_vol", "gas_station_bldg_vol", "any_zone_to_gas_station" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "gas_station_pit_vol", "gas_station_awning_vol", "any_zone_to_gas_station" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "gas_station_bldg_vol", "gas_station_awning_vol", "any_zone_to_gas_station" );
    maps\mp\zombies\_util::flag_link( "warehouse_to_gas_station", "any_zone_to_gas_station" );
    maps\mp\zombies\_util::flag_link( "gas_station_to_sewer", "any_zone_to_gas_station" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_center_vol", "atlas_north_vol", "any_zone_to_atlas" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_center_vol", "atlas_south_vol", "any_zone_to_atlas" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_center_vol", "atlas_pit_vol", "any_zone_to_atlas" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_center_vol", "atlas_surplus_vol", "any_zone_to_atlas" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_north_vol", "atlas_surplus_vol", "any_zone_to_atlas" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atlas_south_vol", "atlas_pit_vol", "any_zone_to_atlas" );
    maps\mp\zombies\_util::flag_link( "warehouse_to_atlas", "any_zone_to_atlas" );
    maps\mp\zombies\_util::flag_link( "atlas_to_sewer", "any_zone_to_atlas" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_roof_vol", "burgertown_int_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_roof_vol", "burgertown_east_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_roof_vol", "burgertown_west_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_roof_vol", "burgertown_trench_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_roof_vol", "burgertown_parking_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_parking_vol", "burgertown_int_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_parking_vol", "burgertown_east_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_parking_vol", "burgertown_trench_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_int_vol", "burgertown_east_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_int_vol", "burgertown_west_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_east_vol", "burgertown_west_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "burgertown_west_vol", "burgertown_trench_vol", "any_zone_to_burgertown" );
    maps\mp\zombies\_util::flag_link( "sewer_to_burgertown", "any_zone_to_burgertown" );
    maps\mp\zombies\_zombies_zone_manager::activate( maps\mp\zombies\_zombies_zone_manager::calculateweightedspawnpoint );
    level.doorbitmaskarray = [];
    level.doorbitmaskarray["warehouse_to_gas_station"] = 1;
    level.doorbitmaskarray["warehouse_to_atlas"] = 2;
    level.doorbitmaskarray["gas_station_interior"] = 4;
    level.doorbitmaskarray["gas_station_to_sewer"] = 8;
    level.doorbitmaskarray["atlas_command"] = 16;
    level.doorbitmaskarray["atlas_to_sewer"] = 32;
    level.doorbitmaskarray["sewertrans_to_sewertunnel"] = 64;
    level.doorbitmaskarray["sewermain_to_sewercave"] = 128;
    level.doorbitmaskarray["sewer_to_burgertown"] = 256;
    level.doorbitmaskarray["burgertown_storage"] = 512;
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_WAREHOUSE", "warehouse_to_gas_station", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_GAS_STATION", "warehouse_to_gas_station", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_ATLAS", "warehouse_to_atlas", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_WAREHOUSE", "warehouse_to_atlas", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_SEWER", "gas_station_to_sewer", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_GAS_STATION", "gas_station_to_sewer", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_SEWER_JUNC", "atlas_to_sewer", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_ATLAS", "atlas_to_sewer", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_SEWER", "sewer_to_burgertown", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_BURGERTOWN", "sewer_to_burgertown", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_SEWER_TUNNELS", "sewertrans_to_sewertunnel", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_SEWER_JUNC", "sewertrans_to_sewertunnel", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_SEWER_JUNC", "sewermain_to_sewercave", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_SEWER_CAVE", "sewermain_to_sewercave", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_BURGER_STORAGE", "burgertown_storage", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_BURGER_STORAGE", "burgertown_storage", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_GAS_INTERIOR", "gas_station_interior", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_GAS_INTERIOR", "gas_station_interior", 1 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_ATLAS_COMMAND", "atlas_command", 0 );
    thread maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_BRG_DOOR_TO_ATLAS_COMMAND", "atlas_command", 1 );
    thread initgranulardoors( "burgertown_storage", 0.1 );
    thread initgranulardoors( "gas_station_interior", 0.1 );
    thread initgranulardoors( "atlas_command", 1.0 );
    thread initgranulardoors( "atlas_to_sewer", 1.0, "warehouse_to_atlas" );
    thread initgranulardoors( "gas_station_to_sewer", 1.0, "warehouse_to_gas_station" );
}

initcharactermodels()
{
    maps\mp\zombies\_util::initializecharactermodel( "security", "security_guard_body_dlc2", "viewhands_security_guard", [ "security_guard_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "exec", "executive_body_dlc2", "viewhands_executive", [ "executive_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "it", "lilith_body_dlc2", "viewhands_lilith", [ "lilith_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "janitor", "janitor_body_dlc2", "viewhands_janitor", [ "janitor_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "security_exo", "security_guard_body_exo_dlc2", "viewhands_security_guard_exo", [ "security_guard_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "exec_exo", "executive_body_exo_dlc2", "viewhands_executive_exo", [ "executive_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "it_exo", "lilith_body_exo_dlc2", "viewhands_lilith_exo", [ "lilith_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "janitor_exo", "janitor_body_exo_dlc2", "viewhands_janitor_exo", [ "janitor_head_dlc2" ] );
    maps\mp\zombies\_util::initializecharactermodel( "security_host", "security_guard_body_dlc2", undefined, [ "security_guard_head_z" ] );
    maps\mp\zombies\_util::initializecharactermodel( "exec_host", "executive_body_dlc2", undefined, [ "executive_head_z" ] );
    maps\mp\zombies\_util::initializecharactermodel( "it_host", "lilith_body_dlc2", undefined, [ "lilith_head_z" ] );
    maps\mp\zombies\_util::initializecharactermodel( "janitor_host", "janitor_body_dlc2", undefined, [ "janitor_head_z" ] );
}

initgranulardoors( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = common_scripts\utility::getstructarray( "door", "targetname" );

    if ( !isdefined( var_1 ) )
        var_1 = 0.5;

    if ( !common_scripts\utility::flag_exist( var_0 ) )
        common_scripts\utility::flag_init( var_0 );

    if ( !isdefined( var_2 ) )
        var_2 = var_0;
    else if ( !common_scripts\utility::flag_exist( var_2 ) )
        common_scripts\utility::flag_init( var_2 );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6._id_79CE ) && var_6._id_79CE == var_2 )
            var_3 = common_scripts\utility::add_to_array( var_3, var_6 );
    }

    common_scripts\utility::flag_wait( var_0 );

    foreach ( var_6 in var_3 )
    {
        wait(randomfloat( var_1 ));
        var_6 notify( "open" );
    }
}

initweapons()
{
    level.zombieweaponinitfunc = ::burgertownzombieweaponinit;
    level.zombieweapononplayerspawnedfunc = ::burgertownzombieweapononplayerspawned;
    level.initmagicboxweaponsfunc = ::burgertownzombieinitmagicboxweapons;
    level.playerammolowfunc = ::burgertownplayerammolow;
    level.activatemaxammofunc = ::burgertownactivatemaxammo;
    level.setweaponlevelfunc = ::burgertownsetweaponlevel;
    level.givemaxscriptedammofunc = ::burgertowngivemaxscriptedammo;
    level.givepointsforkillshotfunc = ::burgertowngivepointsforkillshot;
    level.playercanawardpointsfordamagefunc = ::burgertownplayercanawardpointsfordamage;
    level.onzombiekilledfunc = ::burgertownonzombiekilled;
    level.nearestnodetounreachabledronesearchheight = 128;
}

burgertownzombieweaponinit()
{
    maps\mp\zombies\weapons\_zombie_microwave_gun::init();
}

burgertownzombieweapononplayerspawned()
{
    thread maps\mp\zombies\weapons\_zombie_microwave_gun::onplayerspawn();
}

burgertownzombieinitmagicboxweapons()
{
    maps\mp\zombies\_wall_buys::addmagicboxweapon( "iw5_microwavezm", "dlc_npc_microwave_gun_holo", &"ZOMBIES_MWG", "none", "none", "none", 1 );
}

burgertownplayerammolow( var_0 )
{
    if ( issubstr( var_0, "iw5_microwavezm_mp" ) && maps\mp\zombies\weapons\_zombie_microwave_gun::playerhasmicrowaveammoinfo() )
    {
        var_1 = maps\mp\zombies\weapons\_zombie_microwave_gun::playergetmicrowaveammo();
        var_2 = maps\mp\zombies\weapons\_zombie_microwave_gun::getmicrowavemaxammo();
        return var_1 / var_2 < 0.05;
    }

    return undefined;
}

burgertowncancivilianrounddroppickups( var_0 )
{
    return 0;
}

burgertowncandroppickups( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.agent_type ) && var_0.agent_type == "zombie_melee_goliath" )
        return 0;

    return 1;
}

burgertownactivatemaxammo()
{
    maps\mp\zombies\weapons\_zombie_microwave_gun::playersetmicrowavemaxammo();
}

burgertownsetweaponlevel( var_0, var_1 )
{
    if ( issubstr( var_0, "iw5_microwavezm_mp" ) )
    {
        maps\mp\zombies\weapons\_zombie_microwave_gun::setmicrowaveweaponlevel( var_1 );
        maps\mp\zombies\weapons\_zombie_microwave_gun::playersetmicrowavemaxammo();
    }
}

burgertowngivemaxscriptedammo( var_0 )
{
    if ( issubstr( var_0, "iw5_microwavezm_mp" ) )
        maps\mp\zombies\weapons\_zombie_microwave_gun::playersetmicrowavemaxammo();
}

burgertowngivepointsforkillshot( var_0, var_1 )
{
    if ( issubstr( var_1, "iw5_microwavezm_mp" ) )
        return "kill_head";

    return var_0;
}

burgertownplayercanawardpointsfordamage( var_0, var_1 )
{
    if ( isdefined( var_1 ) && issubstr( var_0, "iw5_microwavezm_mp" ) )
    {
        if ( isdefined( var_1.nextmicrowavepointstime ) && gettime() < var_1.nextmicrowavepointstime )
            return 0;

        var_1.nextmicrowavepointstime = gettime() + maps\mp\zombies\weapons\_zombie_microwave_gun::getmicrowavepointstimesec() * 1000;
    }

    return 1;
}

burgertownonzombiekilled( var_0, var_1 )
{
    maps\mp\zombies\_terminals::givecurestationachievement();
    maps\mp\zombies\weapons\_zombie_microwave_gun::givezombiescookedachievement( var_0, var_1 );
    giveburgertowntrapachievement( var_1 );
}

inittraps()
{
    precachestring( &"ZOMBIE_BRG_AMBULANCE_TRAP_READY" );
    precachestring( &"ZOMBIE_BRG_AMBULANCE_TRAP_COOLDOWN" );
    precachestring( &"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_READY" );
    precachestring( &"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_COOLDOWN" );
    precachestring( &"ZOMBIE_BRG_SNIPER_TRAP_READY" );
    precachestring( &"ZOMBIE_BRG_SNIPER_TRAP_COOLDOWN" );
    precachestring( &"ZOMBIE_BRG_GATOR_TRAP_READY" );
    precachestring( &"ZOMBIE_BRG_GATOR_TRAP_COOLDOWN" );
    precachestring( &"ZOMBIE_BRG_STEAM_TRAP_READY" );
    precachestring( &"ZOMBIE_BRG_STEAM_TRAP_COOLDOWN" );
    precachestring( &"ZOMBIE_BRG_AIRSTRIKE_TRAP_READY" );
    precachestring( &"ZOMBIE_BRG_AIRSTRIKE_TRAP_COOLDOWN" );
    level.trappickupdisabled = 1;
    level.modplayertrapdmg = 1;
    maps\mp\zombies\traps\_trap_sniper::init();
    maps\mp\zombies\traps\_trap_airstrike::init();
    maps\mp\zombies\_traps::register_trap_state_models( "dlc2_wall_interact_off", "dlc2_wall_interact_on", "dlc2_wall_interact_active", "dlc2_wall_interact_cooldown" );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_snipers", "active", ::trap_snipers );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_gators", "active", ::trap_gators );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_airstrike", "active", ::trap_airstrike );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_electric_floor", "active", ::trap_electric_floor );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_sewer_steam", "active", ::trap_sewer_gas );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_ambulance", "active", ::trap_ambulance );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_snipers", "ready", ::trap_console_audio );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_gators", "ready", ::trap_console_audio );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_airstrike", "ready", ::trap_console_audio );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_electric_floor", "ready", ::trap_console_audio );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_sewer_steam", "ready", ::trap_console_audio );
    thread maps\mp\zombies\_traps::trap_setup_custom_function( "trap_ambulance", "ready", ::trap_console_audio );
    maps\mp\zombies\_traps::trap_setup_custom_hints( "trap_ambulance", &"ZOMBIE_BRG_AMBULANCE_TRAP_READY", &"ZOMBIE_BRG_AMBULANCE_TRAP_COOLDOWN" );
    maps\mp\zombies\_traps::trap_setup_custom_hints( "trap_electric_floor", &"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_READY", &"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_COOLDOWN" );
    maps\mp\zombies\_traps::trap_setup_custom_hints( "trap_snipers", &"ZOMBIE_BRG_SNIPER_TRAP_READY", &"ZOMBIE_BRG_SNIPER_TRAP_COOLDOWN" );
    maps\mp\zombies\_traps::trap_setup_custom_hints( "trap_gators", &"ZOMBIE_BRG_GATOR_TRAP_READY", &"ZOMBIE_BRG_GATOR_TRAP_COOLDOWN" );
    maps\mp\zombies\_traps::trap_setup_custom_hints( "trap_sewer_steam", &"ZOMBIE_BRG_STEAM_TRAP_READY", &"ZOMBIE_BRG_STEAM_TRAP_COOLDOWN" );
    maps\mp\zombies\_traps::trap_setup_custom_hints( "trap_airstrike", &"ZOMBIE_BRG_AIRSTRIKE_TRAP_READY", &"ZOMBIE_BRG_AIRSTRIKE_TRAP_COOLDOWN" );
}

trap_console_audio( var_0 )
{
    var_1 = getentarray( var_0.target, "targetname" );
    var_2 = common_scripts\utility::getstructarray( var_0.target, "targetname" );
    var_3 = common_scripts\utility::array_combine( var_1, var_2 );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "activate_model" )
            var_0 thread trap_console_audio_think( var_5 );
    }
}

trap_console_audio_think( var_0 )
{
    var_0 playloopsound( "trap_module_on" );

    for (;;)
    {
        self waittill( "trap_state_change", var_1 );

        if ( var_1 == "no_power" || var_1 == "deactivate" )
        {
            waitframe();
            var_0 stoploopsound();
            break;
        }
    }
}

trap_snipers( var_0 )
{
    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            continue;

        if ( var_3.script_noteworthy == "sniper_laser" )
        {
            var_4 = thread maps\mp\zombies\traps\_trap_sniper::spawnsniperent( var_3, var_0 );
            var_4 thread trap_snipers_cleanup( var_0 );
        }
    }
}

trap_snipers_cleanup( var_0 )
{
    for (;;)
    {
        var_0 waittill( "trap_state_change", var_1 );

        if ( var_1 == "cooldown" || var_1 == "no_power" || var_1 == "deactivate" )
        {
            self delete();
            break;
        }
    }

    var_0 notify( "snipers_off" );
}

trap_gators( var_0 )
{
    if ( !isdefined( var_0.pitfallcounter ) )
        var_0.pitfallcounter = 1;
    else
        var_0.pitfallcounter++;

    if ( var_0.pitfallcounter >= 5 )
        var_0 thread maps\mp\zombies\traps\_trap_gator::trap_gator_pitfall_audio();

    var_1 = getent( "gator_coll", "targetname" );
    var_1._id_8C1A = var_1.origin;
    var_1._id_8B2C = var_1.angles;
    var_1.gator_killed = undefined;

    if ( isdefined( level.gator_kills_active ) && level.gator_kills_active == 1 )
    {
        var_1 thread maps\mp\gametypes\_damage::setentitydamagecallback( 999999, undefined, ::trap_gator_death );
        var_1 thread trap_gator_track_damage( var_0 );
    }

    var_0 maps\mp\zombies\traps\_trap_gator::trap_gator_enter( var_1 );
    var_2 = getentarray( var_0.target, "targetname" );

    foreach ( var_4 in var_2 )
    {
        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        if ( var_4.script_noteworthy == "gator_water" )
        {
            var_0 thread maps\mp\zombies\traps\_trap_gator::trap_gator_trigger_watch( var_4, var_1 );
            waitframe();
        }
    }

    var_0 thread trap_gators_cleanup();
}

trap_gators_cleanup()
{
    for (;;)
    {
        self waittill( "trap_state_change", var_0 );

        if ( var_0 == "cooldown" || var_0 == "no_power" || var_0 == "deactivate" )
        {
            playsoundatpos( ( 2763.0, -2137.0, -116.0 ), "gator_leave_vox" );
            self.usepitfallaudio = 0;
            break;
        }
    }
}

trap_gator_track_damage( var_0 )
{
    self.gator_killed = 0;

    for (;;)
    {
        if ( self.damagetaken > 1500 )
        {
            self.gator_killed = 1;
            level notify( "gator_killed" );
            break;
        }

        wait 0.05;
    }

    var_0 thread maps\mp\zombies\_traps::trap_set_state( "cooldown" );
}

trap_gator_death( var_0, var_1, var_2, var_3 )
{
    self notify( "death" );
}

trap_airstrike( var_0 )
{
    playsoundatpos( ( 1801.0, -3294.0, 752.0 ), "airstrike_start_alert" );
    var_0 maps\mp\zombies\traps\_trap_airstrike::trap_airstrike_begin();
}

trap_electric_floor( var_0 )
{
    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            continue;

        if ( var_3.script_noteworthy == "damage_over_time" )
        {
            var_0 thread maps\mp\zombies\traps\_trap_electrofloor::trap_electrofloor_trigger_watch( var_3 );
            var_0 thread maps\mp\zombies\traps\_trap_electrofloor::trap_electrofloor_player_watch( var_3 );
            waitframe();
        }
    }

    thread trap_electric_floor_audio( var_0 );
}

trap_electric_floor_audio( var_0 )
{
    var_1 = spawn( "script_origin", ( 1958.0, -1739.0, 383.0 ) );
    playsoundatpos( var_1.origin, "electric_floor_start" );
    var_1 playloopsound( "electric_floor_loop" );

    for (;;)
    {
        var_0 waittill( "trap_state_change", var_2 );

        if ( var_2 == "cooldown" || var_2 == "no_power" || var_2 == "deactivate" )
        {
            playsoundatpos( var_1.origin, "electric_floor_stop" );
            var_1 scalevolume( 0, 0.25 );
            wait 0.25;
            var_1 stoploopsound();
            waitframe();
            var_1 delete();
            break;
        }
    }
}

trap_sewer_gas( var_0 )
{
    var_1 = getentarray( var_0.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.script_noteworthy ) )
            continue;

        if ( var_3.script_noteworthy == "damage_over_time" )
        {
            var_0 thread maps\mp\zombies\traps\_trap_sewergas::trap_sewergas_trigger_watch( var_3 );
            var_0 thread maps\mp\zombies\traps\_trap_sewergas::trap_sewergas_player_watch( var_3 );
            waitframe();
        }
    }
}

trap_ambulance( var_0 )
{
    thread trap_ambulance_audio( var_0 );
}

trap_ambulance_audio( var_0 )
{
    var_1 = spawn( "script_origin", var_0.origin );
    playsoundatpos( var_1.origin, "ambulance_start" );
    wait 0.3;
    var_1 scalevolume( 0 );
    var_1 playloopsound( "ambulance_loop" );
    var_1 scalevolume( 1, 0.35 );

    for (;;)
    {
        var_0 waittill( "trap_state_change", var_2 );

        if ( var_2 == "cooldown" || var_2 == "no_power" || var_2 == "deactivate" )
        {
            playsoundatpos( var_1.origin, "ambulance_stop" );
            var_1 scalevolume( 0, 0.25 );
            wait 0.25;
            var_1 stoploopsound();
            waitframe();
            var_1 delete();
            break;
        }
    }
}

trap_carwash( var_0 )
{
    thread trap_carwash_audio( var_0 );
}

trap_carwash_audio( var_0 )
{
    var_1 = spawn( "script_origin", ( 456.0, -421.0, 233.0 ) );
    playsoundatpos( var_1.origin, "carwash_start" );
    var_1 playloopsound( "carwash_loop" );

    for (;;)
    {
        var_0 waittill( "trap_state_change", var_2 );

        if ( var_2 == "cooldown" || var_2 == "no_power" || var_2 == "deactivate" )
        {
            playsoundatpos( var_1.origin, "carwash_stop" );
            var_1 scalevolume( 0, 0.25 );
            wait 0.25;
            var_1 stoploopsound();
            waitframe();
            var_1 delete();
            break;
        }
    }
}

giveburgertowntrapachievement( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( level.numtrapkills ) )
        level.numtrapkills = 0;

    switch ( var_0 )
    {
        case "trap_zm_mp":
        case "trap_missile_zm_mp":
        case "trap_sniper_zm_mp":
            level.numtrapkills++;
            break;
        default:
            return;
    }

    if ( level.numtrapkills == 100 )
        maps\mp\gametypes\zombies::giveplayerszombieachievement( "DLC2_ZOMBIE_INDIRECTFIRE" );
}

spawnzombiekilledfx( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return 0;

    if ( self.agent_type == "zombie_melee_goliath" )
        return 1;

    if ( var_0 == "MOD_EXPLOSIVE" && var_1 == "iw5_microwavezm_mp" )
    {
        maps\mp\zombies\weapons\_zombie_microwave_gun::playzombiekilledmicrowavefx();
        return 1;
    }

    return 0;
}

enablespecialweaponlevelbox()
{
    wait 1.0;
    level notify( "special_weapon_box_unlocked" );
}

initrollupdoors()
{
    var_0 = "dlc_rollup_door_metal_open";
    map_restart( var_0 );
    wait 1.0;
    var_1 = getentarray( "rollup_door", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 thread rollupdoorthink( var_0 );
}

rollupdoorthink( var_0 )
{
    var_1 = self._id_79CE;
    common_scripts\utility::flag_wait( var_1 );
    self scriptmodelplayanim( var_0 );
}

spinningpitbullwheel()
{
    var_0 = "hms_greece_sniperscramble_pitbull_destroyed_veh";
    map_restart( var_0 );
    wait 1;
    var_1 = getent( "pitbull_veh", "targetname" );
    var_1 scriptmodelplayanim( var_0 );
}

flyoverbink()
{

}

setupflyoveranimation( var_0, var_1, var_2, var_3 )
{
    var_4 = common_scripts\utility::getstruct( "env_bink_anim_node", "targetname" );

    if ( !isdefined( var_4 ) )
    {
        var_4 = spawnstruct();
        var_4.origin = ( 0.0, 3584.0, 88.0 );
    }

    if ( !isdefined( var_4.angles ) )
        var_4.angles = ( 0.0, 0.0, 0.0 );

    if ( !isdefined( var_2 ) )
        var_2 = [];

    while ( getdvarint( var_3, 0 ) == 0 )
        waitframe();

    setdvar( "lui_enabled", 0 );
    level.zombiegamepaused = 1;
    wait 1.0;
    var_5 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_5 setmodel( "genericprop_x3" );
    var_6 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_6 setmodel( "tag_player" );
    var_6 linktosynchronizedparent( var_5, var_1, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );

    for (;;)
    {
        while ( getdvarint( var_3, 0 ) == 0 )
            waitframe();

        level.player _meth_807E( var_6, "tag_player", 1, 0, 0, 0, 0, 1 );
        level.player _meth_80A0( 0 );
        level.player hide();
        var_5 _meth_848B( var_0, var_4.origin, var_4.angles, "camera_notetrack" );

        foreach ( var_8 in var_2 )
            level thread donotetrack( var_5, "camera_notetrack", var_8 );

        wait 1;

        while ( getdvarint( var_3, 0 ) == 1 )
            waitframe();

        var_5 notify( "notetrackDone" );
        level.player show();
        level.player unlink();
        var_5 _meth_827A();
        wait 1;
    }
}

donotetrack( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "notetrackDone" );
    var_0 waittillmatch( var_1, var_2 );

    if ( var_2 == "trigger_gater" )
    {

    }
    else if ( var_2 == "water_fx" )
    {
        var_4 = common_scripts\utility::getstruct( "gator_water_level", "script_noteworthy" );
        var_5 = var_4.origin;
        var_6 = ( 0.0, 0.0, 90.0 );
        playfx( common_scripts\utility::getfx( "trap_gator_enter_splash" ), var_5, var_6 );
        playsoundatpos( var_5, "gator_spawn_splash" );
    }

    level notify( var_2 );
}

setupscriptmodelanimation( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = common_scripts\utility::getstruct( "env_bink_anim_node", "targetname" );

    if ( !isdefined( var_5 ) )
    {
        var_5 = spawnstruct();
        var_5.origin = ( 0.0, 3584.0, 88.0 );
    }

    if ( !isdefined( var_5.angles ) )
        var_5.angles = ( 0.0, 0.0, 0.0 );

    if ( !isdefined( var_3 ) )
        var_3 = [];

    var_6 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_6 setmodel( var_1 );

    for (;;)
    {
        while ( getdvarint( var_4, 0 ) == 0 )
            waitframe();

        if ( isdefined( var_2 ) )
            level waittill( var_2 );

        var_6 _meth_848B( var_0, var_5.origin, var_5.angles, "ent_notetrack" );

        foreach ( var_8 in var_3 )
            level thread donotetrack( var_6, "ent_notetrack", var_8 );

        wait 1;

        while ( getdvarint( var_4, 0 ) == 1 )
            waitframe();

        var_6 notify( "notetrackDone" );
        var_6 _meth_827A();
        wait 1;
    }
}

inittoxiczones()
{
    calculatenexttoxicgasround();
    precachestring( &"ZOMBIE_BRG_TOXIC_EVENT_START" );
    precachestring( &"ZOMBIE_BRG_TOXIC_EVENT_STOP" );
    precachestring( &"ZOMBIE_BRG_ATLAS_ZONE" );
    precachestring( &"ZOMBIE_BRG_BURGER_TOWN_ZONE" );
    precachestring( &"ZOMBIE_BRG_GAS_ZONE" );
    level._effect["Toxic_Gas_Burst"] = loadfx( "vfx/gameplay/mp/zombie/dlc2_host_cloud_burst" );
    level._effect["Toxic_Gas_Cloud"] = loadfx( "vfx/gameplay/mp/zombie/dlc2_host_cloud_large" );
    level._effect["Toxic_Gas_Jets"] = loadfx( "vfx/gameplay/mp/zombie/dlc2_host_cloud_jets" );
    level._effect["Toxic_Gas_Doorways"] = loadfx( "vfx/gameplay/mp/zombie/dlc2_host_cloud_doorway" );
    level.toxiczones = [];
    level.toxiczones["Atlas"] = spawnstruct();
    level.toxiczones["BurgerTown"] = spawnstruct();
    level.toxiczones["GasStation"] = spawnstruct();
    level.toxiczones["Atlas"].zonename = "Atlas";
    level.toxiczones["BurgerTown"].zonename = "BurgerTown";
    level.toxiczones["GasStation"].zonename = "GasStation";
    level.toxiczones["Atlas"].zones = [ "atlas_north_vol", "atlas_center_vol", "atlas_south_vol" ];
    level.toxiczones["BurgerTown"].zones = [ "burgertown_trench_vol", "burgertown_parking_vol", "burgertown_roof_vol", "burgertown_int_vol", "burgertown_east_vol", "burgertown_west_vol" ];
    level.toxiczones["GasStation"].zones = [ "gas_station_pit_vol", "gas_station_bldg_vol", "gas_station_pumps_vol" ];
    thread toxicgaszoneevent();
}

toxicgaszoneevent()
{
    var_0 = [ "Atlas", "BurgerTown", "GasStation" ];

    for (;;)
    {
        level waittill( "zombie_round_countdown_started" );

        if ( level.roundtype == "civilian" )
            continue;

        if ( level.wavecounter >= level.nexttoxicgasround )
        {
            var_1 = [];
            var_2 = maps\mp\zombies\_zombies_zone_manager::getcurrentplayeroccupiedzones();

            if ( var_2.size <= 0 )
                continue;

            foreach ( var_4 in var_2 )
            {
                foreach ( var_6 in var_0 )
                {
                    if ( !common_scripts\utility::array_contains( level.toxiczones[var_6].zones, var_4 ) )
                        continue;

                    if ( !common_scripts\utility::array_contains( var_1, level.toxiczones[var_6].zonename ) )
                        var_1 = common_scripts\utility::array_add( var_1, level.toxiczones[var_6].zonename );
                }
            }

            thread activatetoxiczones( var_1, var_0 );

            if ( level.wavecounter >= 30 )
                level.special_mutators["emz"][1] = 1;

            calculatenexttoxicgasround();
        }
    }
}

activatetoxiczones( var_0, var_1 )
{
    if ( level.wavecounter >= 30 )
        var_2 = 3;
    else if ( level.wavecounter >= 20 )
        var_2 = 2;
    else
        var_2 = 1;

    var_0 = common_scripts\utility::array_randomize( var_0 );
    var_3 = 0;

    for ( var_4 = 0; var_4 < var_2 && var_4 < var_0.size; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( !var_3 )
        {
            level thread maps\mp\zombies\_zombies_audio_dlc2::zmaudiotoxiczonesvo( level.toxiczones[var_5].zones );
            var_3 = 1;
        }

        thread toxicgaszonefx( var_5 );
        thread toxicgaszonefillfx( var_5 );
        wait 2;
        var_1 = common_scripts\utility::array_remove( var_1, var_5 );
    }

    if ( var_4 == var_2 )
        return;

    var_1 = common_scripts\utility::array_randomize( var_1 );
    var_6 = var_4;

    for ( var_4 = 0; var_6 < var_2 && var_4 < var_1.size > 0; var_4++ )
    {
        thread toxicgaszonefx( var_1[var_4] );
        var_6++;
        wait 2;
    }
}

toxicgaszonefx( var_0 )
{
    level endon( "game_ended" );
    level notify( "toxic_gas_started" );
    var_1 = level.toxiczones[var_0].zones;
    var_2 = toxicgaszonelocstringreturn( var_0 );
    var_3 = common_scripts\utility::getstruct( var_0 + "_ToxicGas", "script_noteworthy" );
    var_4 = spawn( "script_model", var_3.origin );
    var_4 setmodel( "tag_origin" );
    var_4.angles = ( 270.0, 0.0, 0.0 );
    thread toxicgasstartaudio( var_3 );
    thread toxicgascanfx( var_4 );
    iprintlnbold( var_2 );
    wait 5;
    maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog( "global_priority", "gas_warning", undefined, 1, 1 );
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "Toxic_Gas_Burst" ), var_4, "tag_origin" );
    wait 5;
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "Toxic_Gas_Cloud" ), var_4, "tag_origin" );

    foreach ( var_6 in var_1 )
        thread toxicgaszoneinfectiontrigger( var_6 );

    thread toxicgascleanupfx( var_4 );
    level waittill( "zombie_wave_ended" );
    level notify( "toxic_gas_ended" );
    iprintlnbold( &"ZOMBIE_BRG_TOXIC_EVENT_STOP" );
    thread toxicgasallclearaudio();
}

toxicgaszonefillfx( var_0 )
{
    var_1 = common_scripts\utility::getstructarray( var_0 + "_ToxicFillGas", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = spawn( "script_model", var_3.origin );
        var_4 setmodel( "tag_origin" );
        var_4.angles = var_3.angles;
        maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "Toxic_Gas_Doorways" ), var_4, "tag_origin" );
        thread toxicgascleanupfx( var_4 );
    }
}

toxicgaszonelocstringreturn( var_0 )
{
    switch ( var_0 )
    {
        case "Atlas":
            return &"ZOMBIE_BRG_ATLAS_ZONE";
        case "BurgerTown":
            return &"ZOMBIE_BRG_BURGER_TOWN_ZONE";
        case "GasStation":
            return &"ZOMBIE_BRG_GAS_ZONE";
    }

    return undefined;
}

toxicgascleanupfx( var_0 )
{
    level endon( "game_ended" );
    level waittill( "zombie_wave_ended" );
    var_0 delete();
}

toxicgascanfx( var_0 )
{
    level endon( "game_ended" );
    level endon( "toxic_gas_ended" );
    var_0 endon( "death" );

    for (;;)
    {
        earthquake( 0.35, 5, var_0.origin, 1024 );
        thread audioscreenshake();
        maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "Toxic_Gas_Jets" ), var_0, "tag_origin" );
        wait 30;
    }
}

toxicgaszoneinfectiontrigger( var_0 )
{
    level endon( "game_ended" );
    level endon( "zombie_wave_ended" );
    var_1 = 5000;

    for (;;)
    {
        foreach ( var_3 in level.players )
        {
            if ( !isalive( var_3 ) )
                continue;

            if ( maps\mp\zombies\_util::_id_5175( var_3 ) )
                continue;

            if ( var_3 maps\mp\zombies\_zombies_zone_manager::getplayerzone() != var_0 )
                continue;

            if ( maps\mp\zombies\_util::isplayerinfected( var_3 ) )
            {
                var_3 dodamage( 25, var_3.origin, undefined, undefined, "MOD_TRIGGER_HURT" );
                continue;
            }

            var_3 thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
        }

        wait 2.5;
    }
}

toxicgasstartaudio( var_0 )
{
    thread toxicgasspewaudio( var_0 );

    if ( isdefined( level.toxic_alarm_aud ) && level.toxic_alarm_aud )
        return;
    else
    {
        level.toxic_alarm_aud = 1;

        for ( var_1 = 0; var_1 < 5; var_1 += 1 )
        {
            maps\mp\_audio::_id_8730( "event_gas_alert_front", ( 0.0, 0.0, 0.0 ) );
            wait 2.5;
        }

        level.toxic_alarm_aud = 0;
    }
}

audioscreenshake()
{
    maps\mp\_audio::_id_8730( "event_gas_screen_shake_front", ( 0.0, 0.0, 0.0 ) );
}

toxicgasallclearaudio()
{
    for ( var_0 = 0; var_0 < 3; var_0 += 1 )
    {
        maps\mp\_audio::_id_8730( "event_gas_all_clear_front", ( 0.0, 0.0, 0.0 ) );
        wait 1.5;
    }
}

toxicgasspewaudio( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    wait 0.35;
    playsoundatpos( var_1.origin, "event_gas_steam_active" );
    wait 4.9;
    playsoundatpos( var_1.origin, "event_gas_steam_2nd_burst" );
    wait 0.25;
    var_1 playloopsound( "event_gas_steam_active_lp" );
    var_1 scalevolume( 0 );
    waitframe();
    var_1 scalevolume( 1, 0.5 );
    level waittill( "zombie_wave_ended" );
    var_1 scalevolume( 0, 5 );
    wait 5;
    var_1 stoploopsound( "event_gas_steam_active_lp" );
}

spawnanimationnotetrackhandlerassigner( var_0 )
{
    if ( isdefined( var_0._id_7B20 ) )
    {
        var_1 = var_0.target;
        self.spawnfxloc = common_scripts\utility::getstruct( var_1, "targetname" );

        switch ( var_0._id_7B20 )
        {
            case "spawn_dirt":
                return ::dirtspawnnotetrackhandler;
            case "spawn_concrete":
                return ::concretespawnnotetrackhandler;
            case "spawn_mud":
                return ::mudspawnnotetrackhandler;
            case "spawn_garbage":
                return ::garbagespawnnotetrackhandler;
            case "spawn_manhole":
                return ::manholespawnnotetrackhandler;
            case "spawn_water":
                return ::waterspawnnotetrackhandler;
            case "spawn_goliath_dirt":
                return ::goliathdirtspawnnotetrackhandler;
            case "spawn_goliath_water":
                return ::goliathwaterspawnnotetrackhandler;
            case "spawn_goliath_concrete":
                return ::goliathconcretespawnnotetrackhandler;
            case "spawn_goliath_mud":
                return ::goliathmudspawnnotetrackhandler;
            case "spawn_goliath_metal":
                return ::goliathmetalspawnnotetrackhandler;
        }
    }
}

dirtspawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
    {
        thread zombiespawnfx( "spawn_dirt" );
        self playsound( "zmb_spawn_dirt" );
    }
}

mudspawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
    {
        thread zombiespawnfx( "spawn_mud" );
        self playsound( "zmb_spawn_mud" );
    }
}

concretespawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
    {
        thread zombiespawnfx( "spawn_concrete" );
        self playsound( "zmb_spawn_concrete" );
    }
}

garbagespawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
    {
        thread zombiespawnfx( "spawn_garbage" );
        self playsound( "zmb_spawn_garbage" );
    }
}

manholespawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
    {
        thread zombiespawnfx( "spawn_manhole" );
        thread zombiedripfx( "spawn_water" );
        self playsound( "zmb_spawn_manhole" );
    }
}

waterspawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
    {
        thread zombiespawnfx( "spawn_water" );
        thread zombiedripfx( "spawn_water" );
        self playsound( "zmb_spawn_water" );
    }
}

zombiedripfx( var_0 )
{
    if ( !level.nextgen )
        return;

    if ( level.wavecounter >= 20 )
        return;

    if ( isdefined( self.activemutators ) )
        return;

    var_1 = "spawn_water_drip";

    if ( isdefined( var_0 ) )
        var_1 = var_0 + "_drip";

    var_2 = [];

    if ( isdefined( self.agent_type ) && self.agent_type == "zombie_dog" )
        var_2 = [ "J_Spine4", "J_Head" ];
    else
        var_2 = [ "J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head" ];

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( self gettagorigin( var_4 ) ) )
            maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( var_1 ), self, var_4 );
    }

    zombiedripfxcleanup( var_2, var_1 );
}

zombiedripfxcleanup( var_0, var_1 )
{
    self endon( "death" );

    while ( isdefined( self ) && isalive( self ) )
    {
        wait 0.1;

        if ( !isdefined( self.inspawnanim ) || !self.inspawnanim )
            break;
    }

    wait(randomfloatrange( 5.0, 15.0 ));

    if ( !isdefined( self ) || !isalive( self ) )
        return;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( self gettagorigin( var_3 ) ) )
            maps\mp\zombies\_util::stopfxontagnetwork( common_scripts\utility::getfx( var_1 ), self, var_3 );
    }
}

zombiespawnfx( var_0 )
{
    if ( level.nextgen && level.zombiespawnfxcount >= 12 )
        return;
    else if ( !level.nextgen && level.zombiespawnfxcount >= 3 )
        return;

    var_1 = self.spawnfxloc;

    if ( !isdefined( var_1 ) )
        var_1 = self;

    var_2 = spawnfx( common_scripts\utility::getfx( var_0 ), var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );
    triggerfx( var_2 );
    level.zombiespawnfxcount++;
    common_scripts\utility::waittill_notify_or_timeout( "death", 3.0 );
    level.zombiespawnfxcount--;
    var_2 delete();
}

goliathdirtspawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
        thread goliathspawntrailfx();
    else if ( var_0 == "goliath_impact" )
        thread goliathspawnfx( "goliath_spawn_dirt" );
}

goliathwaterspawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
        thread goliathspawntrailfx();
    else if ( var_0 == "goliath_impact" )
        thread goliathspawnfx( "goliath_spawn_water" );
}

goliathconcretespawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
        thread goliathspawntrailfx();
    else if ( var_0 == "goliath_impact" )
        thread goliathspawnfx( "goliath_spawn_concrete" );
}

goliathmudspawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
        thread goliathspawntrailfx();
    else if ( var_0 == "goliath_impact" )
        thread goliathspawnfx( "goliath_spawn_mud" );
}

goliathmetalspawnnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == "zom_spawn_event" )
        thread goliathspawntrailfx();
    else if ( var_0 == "goliath_impact" )
        thread goliathspawnfx( "goliath_spawn_metal" );
}

goliathspawnfx( var_0 )
{
    var_1 = self.spawnfxloc;

    if ( !isdefined( var_1 ) )
        var_1 = self;

    var_2 = spawnfx( common_scripts\utility::getfx( var_0 ), var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );
    triggerfx( var_2 );
    self notify( "end_spawn_trail_fx" );
    thread goliathspawnexplosion();
    self playsound( "zmb_gol_spawn_crash_land" );
    level.zombiespawnfxcount++;
    common_scripts\utility::waittill_notify_or_timeout( "death", 3.0 );
    level.zombiespawnfxcount--;
    var_2 delete();
}

goliathspawnexplosion()
{
    var_0 = self.origin;
    thread goliathspawnexplosionradiusdamage( var_0 );
    thread goliathspawndestroydroppods( var_0 );
    physicsexplosionsphere( var_0, 512, 128, randomfloatrange( 2, 5 ) );
    earthquake( 0.5, 1.0, var_0, 1200 );
    playrumbleonposition( "artillery_rumble", var_0 );
}

goliathspawnexplosionradiusdamage( var_0 )
{
    wait 0.05;
    var_1 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );
    var_1 = sortbydistance( var_1, var_0, 64 );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.agent_type ) && var_3.agent_type == "zombie_melee_goliath" )
            continue;
        else
        {
            if ( isplayer( var_3 ) || isdefined( var_3._id_001D ) && var_3._id_001D == level._id_6D6C )
            {
                var_4 = int( var_3.health * 0.5 );
                var_3 dodamage( var_4, var_0 );
                continue;
            }

            var_4 = var_3.health + 10;

            if ( isdefined( var_3.maxhealth ) )
                var_4 = var_3.maxhealth + 10;

            var_3 dodamage( var_4, var_0 );
        }
    }
}

goliathspawntrailfx()
{
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "goliath_spawn_trail" ), self, "J_Spine4" );
    self waittill( "end_spawn_trail_fx" );
    maps\mp\zombies\_util::stopfxontagnetwork( common_scripts\utility::getfx( "goliath_spawn_trail" ), self, "J_Spine4" );
}

goliathspawndestroydroppods( var_0 )
{
    if ( !isdefined( level.carepackages ) )
        return;

    var_1 = level.carepackages;
    var_1 = sortbydistance( var_1, var_0, 64 );

    foreach ( var_3 in var_1 )
        var_3 maps\mp\killstreaks\_airdrop::_id_2847( 1 );
}

onzombieburgertownstartgame()
{
    level thread maps\mp\zombies\_teleport::init();
    level thread maps\mp\zombies\_util::outofboundswatch( 0 );
    thread inittraps();
}

exploittrigger()
{
    var_0 = getentarray( "exploitTrigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread exploittriggermonitor();
}

exploittriggermonitor()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) )
        {
            if ( isdefined( self.script_parameters ) && self.script_parameters == "exploitTriggerDmg" )
                thread exploittriggerdamage( var_0 );

            if ( isdefined( self.script_noteworthy ) && ( self.script_noteworthy == "exploitTriggerUseStructs" || self.script_noteworthy == "exploitTriggerUseZombies" ) )
            {
                var_1 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );

                foreach ( var_3 in var_1 )
                {
                    var_4 = distance( var_0.origin, var_3.origin );

                    if ( var_4 < 100 )
                    {
                        if ( self.script_noteworthy == "exploitTriggerUseStructs" )
                        {
                            var_5 = common_scripts\utility::getstructarray( self.target, "targetname" );
                            var_6 = common_scripts\utility::getclosest( var_0.origin, var_5 );

                            if ( isdefined( var_6 ) )
                                var_7 = vectornormalize( ( var_6.origin - var_0.origin ) * ( 1.0, 1.0, 0.0 ) );
                            else
                                var_7 = vectornormalize( ( var_0.origin - var_3.origin ) * ( 1.0, 1.0, 0.0 ) );
                        }
                        else
                            var_7 = vectornormalize( ( var_3.origin - var_0.origin ) * ( 1.0, 1.0, 0.0 ) );

                        var_0 _meth_82F1( var_7 * 20 );
                        break;
                    }

                    wait 0.1;
                }
            }
        }

        wait 1;
    }
}

exploittriggerdamage( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "begin_last_stand" );
    wait 1;

    if ( var_0 istouching( self ) )
        var_0 dodamage( 10, var_0.origin );
}

zombiespawnhudoutline()
{
    for (;;)
    {
        wait 0.25;
        var_0 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );

        foreach ( var_2 in var_0 )
            var_2 _meth_83FA( 0, 0 );
    }
}

zombiezonedebug( var_0 )
{
    if ( var_0 == 1 )
        thread zombiespawnhudoutline();

    wait 10;
    var_1 = getentarray( "info_volume", "classname" );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.targetname != "burger_tower_vol" )
        {
            var_4 = common_scripts\utility::getstructarray( var_3.target, "targetname" );
            var_3 thread zombiezonedebugplayerlocation( var_4 );
        }
    }
}

zombiezonedebugplayerlocation( var_0 )
{
    for (;;)
    {
        wait 0.05;

        if ( !level.players[0] istouching( self ) )
            continue;

        foreach ( var_2 in var_0 )
        {
            if ( isdefined( var_2.script_animation ) )
            {
                switch ( var_2.script_animation )
                {
                    case "spawn_crawl_left":
                        common_scripts\utility::draw_arrow_time( var_2.origin, var_2.origin + ( 0.0, 0.0, 32.0 ), ( 255.0, 255.0, 0.0 ), 0.05 );
                        break;
                    case "spawn_crawl_right":
                        common_scripts\utility::draw_arrow_time( var_2.origin, var_2.origin + ( 0.0, 0.0, 32.0 ), ( 255.0, 0.0, 0.0 ), 0.05 );
                        break;
                    case "spawn_crawl_up":
                        common_scripts\utility::draw_arrow_time( var_2.origin, var_2.origin + ( 0.0, 0.0, 32.0 ), ( 0.0, 0.0, 255.0 ), 0.05 );
                        break;
                }

                continue;
            }

            common_scripts\utility::draw_arrow_time( var_2.origin, var_2.origin + ( 0.0, 0.0, 32.0 ), ( 255.0, 255.0, 255.0 ), 0.05 );
        }
    }
}

sewerscurestationdisablespawning()
{
    for (;;)
    {
        level waittill( "cure_station_active" );
        var_0 = maps\mp\zombies\_util::_id_4056();

        if ( var_0 == 1 )
            break;

        level.zone_data.zones["sewerpit_vol"].disablespawns = 1;
        level waittill( "cure_station_deactive" );
        level.zone_data.zones["sewerpit_vol"].disablespawns = undefined;
    }
}

updatecivilianextractionpoints()
{
    var_0 = "warehouse_office_vol";
    var_1 = "gas_station_bldg_vol";
    var_2 = "atlas_center_vol";
    var_3 = "sewermain_vol";
    var_4 = "sewertunnel_vol";
    var_5 = "burgertown_roof_vol";
    var_6 = [ var_1, var_2, var_3, var_4, var_5 ];
    var_7 = [];
    var_8 = [];

    if ( !isdefined( level.resetextractionpointround ) )
        calculatenextextractionpointreset();

    if ( level.civrounds <= 3 )
    {
        switch ( level.civrounds )
        {
            case 1:
                var_7 = common_scripts\utility::array_combine( level.zone_data.zones[var_1].civilian_spawners, level.zone_data.zones[var_2].civilian_spawners );
                var_8 = level.zone_data.zones[var_0].civilian_extracts;
                break;
            case 2:
                var_7 = level.zone_data.zones[var_3].civilian_spawners;
                var_8 = common_scripts\utility::array_combine( level.zone_data.zones[var_1].civilian_extracts, level.zone_data.zones[var_2].civilian_extracts );
                break;
            case 3:
                if ( !maps\mp\zombies\_zombies_zone_manager::iszoneenabled( var_5 ) )
                {
                    var_7 = level.zone_data.zones[var_5].civilian_spawners;
                    var_8 = common_scripts\utility::array_combine( level.zone_data.zones[var_1].civilian_extracts, level.zone_data.zones[var_2].civilian_extracts );
                }
                else
                {
                    var_7 = common_scripts\utility::array_combine( level.zone_data.zones[var_1].civilian_spawners, level.zone_data.zones[var_2].civilian_spawners );
                    var_8 = level.zone_data.zones[var_5].civilian_extracts;
                }

                break;
        }
    }
    else
    {
        foreach ( var_10 in var_6 )
        {
            foreach ( var_12 in level.zone_data.zones[var_10].civilian_spawners )
                var_7 = common_scripts\utility::add_to_array( var_7, var_12 );

            foreach ( var_15 in level.zone_data.zones[var_10].civilian_extracts )
            {
                var_8 = common_scripts\utility::add_to_array( var_8, var_15 );

                if ( level.wavecounter >= level.resetextractionpointround )
                    var_15.hasbeenused = undefined;
            }
        }
    }

    var_18 = common_scripts\utility::random( var_7 );

    foreach ( var_15 in var_8 )
    {
        if ( isdefined( var_15.hasbeenused ) && var_15.hasbeenused == 1 || !maps\mp\zombies\_zombies_zone_manager::ispathnodeinenabledzone( var_15 ) )
            var_8 = common_scripts\utility::array_remove( var_8, var_15 );
    }

    var_8 = sortbydistance( var_8, var_18.origin );

    if ( var_8.size > 2 )
        var_21 = var_8[var_8.size - randomintrange( 1, 2 )];
    else if ( var_8.size > 0 )
        var_21 = var_8[var_8.size - 1];
    else
        var_21 = level.zone_data.zones[var_0].civilian_extracts[0];

    level.civ_extract.spawnpoint = var_18;
    level.civ_extract.extractpoint = var_21;
    var_21.hasbeenused = 1;

    if ( level.wavecounter >= level.resetextractionpointround )
        calculatenextextractionpointreset();
}

noflashemzhitfx( var_0 )
{
    var_1 = maps\mp\zombies\_zombies_zone_manager::getplayerzone();

    if ( common_scripts\utility::array_contains( level.noemzflashzones, var_1 ) )
        return level._effect["mut_emz_attack_no_flash"];
    else
        return level._effect["mut_emz_attack_sm"];
}

spawnpatchclipfixes()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 51.0, -1714.0, 138.5 ), ( 0.0, 15.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2.5, -1694.0, 236.0 ), ( 29.099, 15.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 19.5, -1757.0, 236.0 ), ( 29.099, 15.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 37.0, -1808.0, 242.0 ), ( 29.099, 15.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 50.0, -1856.5, 242.0 ), ( 29.099, 15.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 82.5006, -1672.0, 235.993 ), ( 30.0996, 195.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 99.4994, -1735.0, 236.007 ), ( 30.0996, 195.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 108.0, -1792.0, 236.0 ), ( 30.0996, 182.5, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 122.5, -1837.0, 242.0 ), ( 30.0996, 195.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 124.0, -1823.5, 138.5 ), ( 0.0, 2.5, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 85.0, -1894.5, 242.0 ), ( 30.0996, 105.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 113.0, -1887.0, 242.0 ), ( 30.0996, 105.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2192.0, -4416.0, 216.0 ), ( 0.0, 45.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2192.0, -4416.0, 344.0 ), ( 0.0, 45.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2192.0, -4416.0, 472.0 ), ( 0.0, 45.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1832.0, -4700.0, 536.0 ), ( 0.0, 315.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1832.0, -4700.0, 280.0 ), ( 0.0, 315.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1360.0, -4350.0, 239.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1420.0, -4350.0, 166.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2613.0, -2048.5, -275.5 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2613.0, -2148.48, -275.523 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2613.0, -2010.0, -347.5 ), ( 0.0, 270.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2741.0, -2010.0, -347.5 ), ( 0.0, 270.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2869.0, -2010.0, -347.5 ), ( 0.0, 270.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2613.0, -2185.5, -347.5 ), ( 0.0, 270.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2741.0, -2185.5, -347.5 ), ( 0.0, 270.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2869.0, -2185.5, -347.5 ), ( 0.0, 270.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2046.0, -2388.0, 165.0 ), ( 90.0, 180.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2046.0, -2324.0, 165.0 ), ( 90.0, 180.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2055.0, -2388.0, 159.0 ), ( 90.0, 180.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2055.0, -2324.0, 159.0 ), ( 90.0, 180.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 148.0, -2896.0, 124.0 ), ( 349.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 148.0, -2640.0, 124.0 ), ( 349.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1864.0, -622.0, 78.0 ), ( 11.0, 37.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1888.0, -716.0, 28.0 ), ( 11.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1375.0, -2634.0, -344.0 ), ( 0.0, 22.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1351.0, -2574.0, -344.0 ), ( 0.0, 12.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2869.0, -2205.5, -335.5 ), ( 0.0, 270.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2846.0, -2249.5, -335.5 ), ( 0.0, 0.0, 90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3007.3, -1934.3, 254.867 ), ( 0.0, 90.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3135.3, -1934.3, 254.9 ), ( 0.0, 90.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 2916.5, -2412.5, 256.5 ), ( 0.0, 90.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 134.0, -4776.0, 278.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 134.0, -4776.0, 534.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 2922.0, -860.0, 518.0 ), ( 356.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1493.5, -1317.0, 52.3 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1493.5, -1573.0, 52.3 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1493.5, -1829.0, 52.3 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1929.5, -1829.0, 52.3 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1929.5, -1573.0, 52.3 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1929.5, -1317.0, 52.3 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 981.0, -1908.0, 528.0 ), ( 0.0, 315.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 981.0, -1908.0, 272.0 ), ( 0.0, 315.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3251.84, -1724.74, 526.326 ), ( 357.2, 324.7, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4132.2, -2064.51, -490.7 ), ( 355.0, 204.4, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4130.7, -2185.5, -490.7 ), ( 355.0, 155.4, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 560.0, -876.0, 410.0 ), ( 0.0, 80.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 560.0, -876.0, 666.0 ), ( 0.0, 80.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 3219.5, -1910.0, 440.0 ), ( 0.0, 315.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 3219.5, -1910.0, 472.0 ), ( 0.0, 315.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3342.0, -2386.0, 624.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 3582.5, -2012.0, 1.0 ), ( 0.0, 316.324, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 3576.0, -2006.0, 65.0 ), ( 338.312, 316.324, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 3534.0, -2033.0, -61.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 3534.0, -2033.0, 3.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1291.0, -4350.0, 280.0 ), ( 0.0, 90.0, 0.0 ) );
}

destroypatioglass()
{
    var_0 = spawn( "trigger_radius", ( 1522.0, -3404.0, 194.0 ), 0, 128, 128 );
    var_0.radius = 128;
    radiusdamage( var_0.origin, 128, 1000, 1000 );
    wait 10;
    var_0 delete();
}

windowexploitledgelogic()
{
    level endon( "game_ended" );
    var_0 = [];
    var_1[0] = ( 922.0, -3589.0, 193.0 );
    var_1[1] = ( 978.0, -3589.0, 193.0 );
    var_1[2] = ( 1036.0, -3589.0, 193.0 );
    var_1[3] = ( 1444.0, -3589.0, 193.0 );
    var_1[4] = ( 1500.0, -3589.0, 193.0 );
    var_1[5] = ( 1558.0, -3589.0, 193.0 );
    var_1[6] = ( 1675.0, -3729.0, 193.0 );
    var_1[7] = ( 1675.0, -3786.0, 193.0 );
    var_1[8] = ( 1675.0, -3842.0, 193.0 );
    var_1[9] = ( 974.0, -4344.0, 200.0 );
    var_1[10] = ( 944.0, -4344.0, 200.0 );

    foreach ( var_3 in var_1 )
    {
        var_4 = spawn( "trigger_radius", var_3, 0, 7, 7 );
        var_0 = common_scripts\utility::array_add( var_0, var_4 );
    }

    foreach ( var_4 in var_0 )
        var_4 thread windowexploitledgelogicthink();
}

windowexploitledgelogicthink()
{
    level endon( "game_ended" );
    self endon( "end_exploit_logic" );

    for (;;)
    {
        self waittill( "trigger", var_0 );
        wait 1.5;

        if ( isplayer( var_0 ) )
        {
            var_1 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );

            foreach ( var_3 in var_1 )
            {
                var_4 = distance( var_0.origin, var_3.origin );

                if ( var_4 < 75 )
                {
                    var_5 = vectornormalize( ( var_3.origin - var_0.origin ) * ( 1.0, 1.0, 0.0 ) );
                    var_0 _meth_82F1( var_5 * 100 );
                    break;
                }
            }
        }
    }
}

alterjumpexploit( var_0 )
{
    level endon( "game_ended" );
    var_1 = spawn( "trigger_radius", var_0.origin, 0, 7, 96 );
    var_1 thread windowexploitledgelogicthink();
    var_0 waittill( "placed", var_2 );
    var_1 notify( "end_exploit_logic" );
    level waittill( "sq_raise_altar" );
    var_1 thread windowexploitledgelogicthink();
}

shoveplayer()
{
    level endon( "game_ended" );
    var_0[0] = ( 1398.46, -3952.36, 372.0 );
    var_1 = spawn( "trigger_radius", var_0[0], 0, 7, 7 );

    for (;;)
    {
        var_1 waittill( "trigger", var_2 );
        wait 1.5;

        if ( isplayer( var_2 ) )
        {
            var_3 = vectornormalize( ( var_2.origin + ( -100.0, 0.0, 0.0 ) - var_2.origin ) * ( 1.0, 1.0, 0.0 ) );
            var_2 _meth_82F1( var_3 * 300 );
        }
    }
}

trapelectricfloorfix()
{
    var_0[0] = ( 1658.76, -2277.19, 150.0 );

    if ( level.nextgen )
        var_1 = spawn( "trigger_radius", var_0[0], 0, 196, 6 );
    else
        var_1 = getent( "elec_trap_trigger", "targetname" );

    var_1.script_noteworthy = "damage_over_time";
    var_1._id_7977 = 5;
    level.elec_trap_triggers = common_scripts\utility::array_add( level.elec_trap_triggers, var_1 );
    level.elec_trap_fix_trigger = var_1;
}

fixtrapfunc( var_0, var_1 )
{
    if ( var_1.script_noteworthy == "trap_electric_floor" )
        var_0 = common_scripts\utility::array_add( var_0, level.elec_trap_fix_trigger );

    return var_0;
}
