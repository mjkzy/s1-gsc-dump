// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::lair_callbackstartgametype;
    maps\mp\mp_lair_precache::main();
    maps\createart\mp_lair_art::main();
    maps\mp\mp_lair_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_lair_lighting::main();
    maps\mp\mp_lair_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_lair" );
    maps\mp\_water::init();
    level.osplightset = "mp_lair_osp";
    level.warbirdlightset = "mp_lair_warbird";
    level.vulcanlightset = "mp_lair_osp";
    level.zone_height = 90;
    thread overridevulcanheight();
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    precacheitem( "iw5_dlcgun12loot8_mp" );
    level dynamicevent_init();
    level thread maps\mp\_dynamic_events::dynamicevent( ::startdynamicevent, ::enddynamicevent, ::enddynamicevent );
    level.orbitalsupportoverridefunc = ::lairpaladinoverrides;
    level thread onplayerconnect();
    thread aud_handle_fireworks_sfx();
    thread clip_fixes();
}

clip_fixes()
{
    thread office_clip_01();
    thread office_clip_02();
    thread east_tower_clip_01();
    thread west_tower_clip_01();
    thread dance_floor_clip_01();
}

lair_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

dynamicevent_init()
{
    level endon( "game_ended" );

    if ( level.gametype == "infect" )
        maps\mp\_dynamic_events::setdynamiceventstartpercent( 0.2 );
    else if ( level.gametype == "twar" )
        maps\mp\_dynamic_events::setdynamiceventstartpercent( 0.25 );
    else if ( level.gametype == "gun" )
        maps\mp\_dynamic_events::setdynamiceventstartpercent( 0.3 );
    else
        maps\mp\_dynamic_events::setdynamiceventstartpercent( 0.4 );

    setdvar( "scr_dynamic_event_start_perc", level.dynamicevent["start_percent"] );
    thread init_towers();
}

startdynamicevent()
{
    level endon( "game_ended" );
    thread monitor_towers();

    foreach ( var_1 in level.players )
    {
        if ( var_1.team == "axis" )
        {
            var_1 playlocalsound( "at_anr0_ks_lair_plasma_activate" );
            continue;
        }

        if ( var_1.team == "allies" )
            var_1 playlocalsound( "se_anr0_ks_lair_plasma_activate" );
    }

    wait 15;
    level.teslacoilsactivated = 1;
    thread maps\mp\mp_lair_fx::start_vista_vfx();
    wait 0.8;

    foreach ( var_1 in level.players )
    {
        if ( var_1.team == "axis" )
        {
            var_1 playlocalsound( "at_anr0_ks_lair_plasma_on" );
            continue;
        }

        if ( var_1.team == "allies" )
            var_1 playlocalsound( "se_anr0_ks_lair_plasma_on" );
    }
}

enddynamicevent()
{
    foreach ( var_1 in level.tesla_towers )
    {
        var_1 notify( "end_dynamic_event" );
        level notify( "aud_stop_dynamic_event_loops" );
        var_1 _meth_82C0( 0 );
        var_1.chargingfx hide();
    }
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawned();
        var_0 thread onplayerslam();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        thread detectshockdeath();
    }
}

onplayerslam()
{
    self endon( "Disconnect" );

    for (;;)
    {
        self waittill( "ground_slam", var_0 );
        var_1 = getdvarfloat( "ground_slam_min_height", maps\mp\_exo_suit::getgroundslamminheight() );
        var_2 = getdvarfloat( "ground_slam_max_height", maps\mp\_exo_suit::getgroundslammaxheight() );
        var_3 = getdvarfloat( "ground_slam_min_radius", maps\mp\_exo_suit::getgroundslamminradius() );
        var_4 = getdvarfloat( "ground_slam_max_radius", maps\mp\_exo_suit::getgroundslammaxradius() );

        if ( var_0 < var_1 )
            continue;

        var_5 = ( var_0 - var_1 ) / ( var_2 - var_1 );
        var_5 = clamp( var_5, 0.0, 1.0 );
        var_6 = ( var_4 - var_3 ) * var_5 + var_3;

        foreach ( var_8 in level.tesla_towers )
        {
            if ( _func_220( var_8.origin, self.origin ) <= var_6 * var_6 )
            {
                if ( var_8.script_noteworthy == "lamp_08" )
                {
                    var_9 = var_8.origin + ( 0, 0, 65 );
                    var_10 = self gettagorigin( "J_SPINELOWER" );

                    if ( sighttracepassed( var_9, var_10, 0, var_8, self, 0 ) )
                        var_8 _meth_8051( 1, self.origin, self, self, "MOD_TRIGGER_HURT", "boost_slam_mp" );
                }
                else
                    var_8 _meth_8051( 1, self.origin, self, self, "MOD_TRIGGER_HURT", "boost_slam_mp" );

                break;
            }
        }
    }
}

detectshockdeath()
{
    self endon( "disconnect" );
    self waittill( "death", var_0, var_1, var_2 );

    if ( isdefined( var_2 ) && var_2 == "iw5_dlcgun12loot8_mp" )
        thread playshockdeathfx();
}

playshockdeathfx()
{
    playfx( common_scripts\utility::getfx( "lightning_bolt_impact" ), self.body gettagorigin( "J_SpineUpper" ), anglestoforward( self.body gettagangles( "J_SpineUpper" ) ), anglestoup( self.body gettagangles( "J_SpineUpper" ) ) );
    playfxontag( common_scripts\utility::getfx( "shocked_corpse" ), self.body, "j_spineupper" );
}

init_towers()
{
    level.tesla_towers = getentarray( "tesla_tower", "targetname" );

    foreach ( var_1 in level.tesla_towers )
    {
        var_1.chargingfx = spawnfx( common_scripts\utility::getfx( "tesla_coil_charging" ), var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );
        var_1.chargingfx hide();
        var_1.dischargingfx = spawnfx( common_scripts\utility::getfx( "tesla_coil_discharging" ), var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );
        var_1.dischargingfx hide();
        var_1 _meth_8495( 1 );
        var_1.damagecallback = ::tower_processdamagetaken;
    }
}

tower_processdamagetaken( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    self notify( "tower_damage", var_0, var_1, var_5, var_4 );
}

monitor_towers()
{
    foreach ( var_1 in level.tesla_towers )
    {
        var_1 thread tower_lifetime();
        wait 0.1;
    }
}

tower_lifetime()
{
    self endon( "end_dynamic_event" );
    var_0 = 15.0;
    self.chargingfx show();
    triggerfx( self.chargingfx );
    wait(var_0);

    for (;;)
    {
        thread maps\mp\_audio::snd_play_linked( "mp_lair_murder_spark_powered_up", self );
        var_1 = maps\mp\_audio::snd_play_loop_in_space( "mp_lair_murder_lamp_lp", self.origin, "aud_stop_dynamic_event_loops" );
        var_2 = maps\mp\_audio::snd_play_loop_in_space( "mp_lair_murder_lamp_lp_hi", self.origin, "aud_stop_dynamic_event_loops" );
        self _meth_82C0( 1 );
        self.health = 99999;
        self waittill( "tower_damage", var_3, var_4, var_5, var_6 );

        if ( isdefined( var_5 ) )
        {
            switch ( var_5 )
            {
                case "killstreakmahem_mp":
                    if ( isdefined( var_4 ) && isdefined( var_4.turret ) )
                        self.killcament = var_4.turret;

                    break;
                case "killstreak_strike_missile_gas_mp":
                case "remote_energy_turret_mp":
                case "sentry_minigun_mp":
                    if ( isdefined( var_3 ) )
                        self.killcament = var_3;

                    break;
                case "drone_assault_remote_turret_mp":
                    if ( isdefined( var_3.owner ) )
                        var_4 = var_3.owner;
                case "orbital_carepackage_droppod_mp":
                case "orbital_carepackage_pod_plane_mp":
                case "stealth_bomb_mp":
                case "warbird_missile_mp":
                case "warbird_remote_turret_mp":
                case "ugv_missile_mp":
                    if ( isdefined( var_3 ) && isdefined( var_3.killcament ) )
                        self.killcament = var_3.killcament;

                    break;
                case "stun_grenade_var_mp_lefthand":
                case "emp_grenade_var_mp_lefthand":
                case "stun_grenade_mp_lefthand":
                case "emp_grenade_mp_lefthand":
                case "semtex_mp_lefthand":
                case "frag_grenade_mp_lefthand":
                case "stun_grenade_var_mp":
                case "emp_grenade_var_mp":
                case "stun_grenade_mp":
                case "emp_grenade_mp":
                case "semtex_mp":
                case "frag_grenade_mp":
                case "iw5_microdronelauncher_mp":
                    if ( isdefined( var_6 ) && var_6 == "MOD_IMPACT" )
                        continue;

                    break;
                case "smoke_grenade_var_mp_lefthand":
                case "smoke_grenade_var_mp":
                case "smoke_grenade_mp_lefthand":
                case "smoke_grenade_mp":
                case "paint_grenade_var_mp_lefthand":
                case "paint_grenade_var_mp":
                case "paint_grenade_mp_lefthand":
                case "paint_grenade_mp":
                case "paint_missile_killstreak_mp":
                case "paint_grenade_killstreak_mp":
                    continue;
                default:
                    break;
            }
        }

        self _meth_82C0( 0 );
        thread aud_murder_zap_seq();
        self playsound( "mp_lair_murder_spark_zap" );
        self playsound( "mp_lair_murder_lamp_sweeps" );

        if ( isdefined( var_1 ) )
        {
            var_1 _meth_80AC();
            wait 0.05;
            var_1 delete();
        }

        if ( isdefined( var_2 ) )
        {
            var_2 _meth_80AC();
            wait 0.05;
            var_2 delete();
        }

        self.chargingfx hide();
        thread start_shock( var_4 );
        self waittill( "tower_shock_done" );
        self.chargingfx show();
        triggerfx( self.chargingfx );
        wait(var_0);
    }
}

aud_murder_zap_seq()
{
    var_0 = randomfloatrange( 0.1, 0.3 );
    var_1 = randomintrange( 7, 10 );

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        self playsound( "mp_lair_murder_spark_zap" );
        wait(var_0);
    }
}

start_shock( var_0 )
{
    level.shock_time = 2.2;
    var_1 = 0.2;
    var_2 = self.radius * self.radius;
    var_3 = self.origin + ( 0, 0, 115 );
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = var_3;
    var_4.angles = ( 270, 0, 0 );
    var_4 show();
    playfxontag( common_scripts\utility::getfx( "tesla_lightning_loop" ), var_4, "tag_origin" );
    self.dischargingfx show();
    triggerfx( self.dischargingfx );
    thread maps\mp\_audio::snd_play_linked( "mp_lair_murder_spark_zap", self );

    for ( var_5 = 0; var_5 < level.shock_time; var_5 += var_1 )
    {
        var_6 = [];
        var_7 = [];
        var_8 = [];

        foreach ( var_10 in level.players )
        {
            if ( isdefined( var_0.team ) && var_10.team != var_0.team || var_10 == var_0 )
            {
                if ( var_10.health > 0 && distancesquared( var_10.origin, self.origin ) <= var_2 )
                    var_6[var_6.size] = var_10;
            }
        }

        if ( isdefined( level.ugvs ) )
        {
            foreach ( var_13 in level.ugvs )
            {
                if ( var_13.team != var_0.team || var_13.owner == var_0 )
                {
                    if ( var_13.damagetaken < var_13.maxhealth && distancesquared( var_13.origin, self.origin ) <= var_2 )
                        var_7[var_7.size] = var_13;
                }
            }
        }

        if ( isdefined( level.trackingdrones ) )
        {
            foreach ( var_13 in level.trackingdrones )
            {
                if ( var_13.team != var_0.team || var_13.owner == var_0 )
                {
                    if ( var_13.damagetaken < var_13.maxhealth && distancesquared( var_13.origin, self.origin ) <= var_2 )
                        var_7[var_7.size] = var_13;
                }
            }
        }

        if ( isdefined( level.turrets ) )
        {
            foreach ( var_18 in level.turrets )
            {
                if ( var_18.team != var_0.team || var_18.owner == var_0 )
                {
                    if ( var_18.health > 0 && distancesquared( var_18.origin, self.origin ) <= var_2 )
                        var_8[var_8.size] = var_18;
                }
            }
        }

        foreach ( var_21 in var_6 )
        {
            var_22 = var_21 gettagorigin( "j_neck" );

            if ( sighttracepassed( var_3, var_22, 0, self, var_21, 0 ) )
                var_21 _meth_8051( 1000, var_3, var_0, self, "MOD_EXPLOSIVE", "iw5_dlcgun12loot8_mp", "none" );
        }

        foreach ( var_13 in var_7 )
        {
            var_22 = var_13.origin;
            var_25 = var_13.angles;

            if ( sighttracepassed( var_3, var_22, 0, self, var_13, 0 ) )
            {
                playfx( common_scripts\utility::getfx( "lightning_bolt_impact" ), var_22, anglestoforward( var_25 ), anglestoup( var_25 ) );
                var_13 _meth_8051( 1000, var_3, var_0, self, "MOD_EXPLOSIVE", "iw5_dlcgun12loot8_mp", "none" );
            }
        }

        foreach ( var_18 in var_8 )
        {
            var_22 = var_18 gettagorigin( "tag_aim_animated" );
            var_25 = var_18 gettagangles( "tag_aim_animated" );

            if ( sighttracepassed( var_3, var_22, 0, self, var_18, 0 ) )
            {
                var_18 _meth_8051( 1000, var_3, var_0, self, "MOD_EXPLOSIVE", "iw5_dlcgun12loot8_mp", "none" );
                playfx( common_scripts\utility::getfx( "lightning_bolt_impact" ), var_22, anglestoforward( var_25 ), anglestoup( var_25 ) );
                playfxontag( common_scripts\utility::getfx( "shocked_corpse" ), var_18, "tag_aim_animated" );
            }
        }

        wait(var_1);
    }

    wait 0.1;
    var_4 delete();
    self.dischargingfx hide();
    self notify( "tower_shock_done" );
}

lairpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnheight = 9200;
    level.orbitalsupportoverrides.spawnradius = 8000;
    level.orbitalsupportoverrides.spawnangle = 182;
}

overridevulcanheight()
{
    wait 1;

    if ( !isdefined( level.orbitallaseroverrides ) )
        level.orbitallaseroverrides = spawnstruct();

    level.orbitallaseroverrides.spawnheight = 2800;
}

disconnect_lamp_nodes( var_0 )
{
    var_1 = getnodearray( var_0, "script_noteworthy" );
    var_2 = getnodearray( var_0, "script_noteworthy" );

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
        var_1[var_3] _meth_8059();

    waitframe();

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        var_2[var_3] _meth_8059();

    waitframe();
    wait(level.shock_time);

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
        var_1[var_3] _meth_805A();

    waitframe();

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        var_2[var_3] _meth_805A();
}

aud_handle_fireworks_sfx()
{
    level waittill( "aud_fireworks" );
    var_0 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_0 _meth_8075( "amb_mp_lair_fworks" );
}

office_clip_01()
{
    var_0 = 1008;

    for ( var_1 = 0; var_1 < 8; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 2481, -145, var_0 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 2458, -145, var_0 ), ( 0, 270, 0 ) );
        var_0 += 256;
    }
}

office_clip_02()
{
    var_0 = 968;

    for ( var_1 = 0; var_1 < 8; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 2440, -151, var_0 ), ( 0, 270, 0 ) );
        var_0 += 256;
    }
}

east_tower_clip_01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -439.5, -337.5, 839.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -217.5, -337.5, 839.5 ), ( 0, 270, 0 ) );
}

west_tower_clip_01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( 199.5, 480, 895.5 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( 441, 479.5, 895.5 ), ( 0, 270, 0 ) );
}

dance_floor_clip_01()
{
    var_0 = 576;

    for ( var_1 = 0; var_1 < 10; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1664, 2512, var_0 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1408, 2512, var_0 ), ( 0, 270, 0 ) );
        var_0 += 256;
    }
}
