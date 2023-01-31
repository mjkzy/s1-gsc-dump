// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::clowntown3_callbackstartgametype;
    maps\mp\mp_clowntown3_precache::main();
    maps\createart\mp_clowntown3_art::main();
    maps\mp\mp_clowntown3_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_clowntown3_lighting::main();
    maps\mp\mp_clowntown3_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_clowntown3" );
    maps\mp\_water::init();
    precacheitem( "iw5_dlcgun12loot9_mp" );
    precacheitem( "iw5_dlcgun12loot8_mp" );
    map_restart( "ct_motel_sign_idle" );
    map_restart( "ct_motel_sign_hat_off" );
    map_restart( "ct_motel_sign_hat_off_idle" );
    map_restart( "ct_motel_sign_hat_on" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    thread aud_event_sign_mech_idle();

    if ( level.nextgen )
    {
        thread ct_vista_cars();
        thread delete_ct_vista_cars();
    }

    sign_init();
    bombs_init();
    thread rotating_bed_setup();
    thread rotating_fans_setup();
    thread clowntownclippatch();
    var_0 = level.gametype;

    if ( !( var_0 == "twar" || var_0 == "sd" || var_0 == "sr" ) )
        level thread maps\mp\_dynamic_events::dynamicevent( ::clowntown_dynamic_event );

    setdvar( "sm_minSpotLightScore", 0.0007 );
    level.ospvisionset = "mp_clowntown3_osp";
    level.osplightset = "mp_clowntown3_osp";
    level.warbirdvisionset = "mp_clowntown3_osp";
    level.warbirdlightset = "mp_clowntown3_osp";
    level.vulcanvisionset = "mp_clowntown3_osp";
    level.vulcanlightset = "mp_clowntown3_osp";
    level thread clowntowncustomairstrike();
    level thread clowntowncustomosp();
    level thread getclownlights();
    level thread resetuplinkballoutofbounds();

    if ( var_0 == "ctf" )
    {
        while ( !isdefined( level.teamflags["allies"] ) || !isdefined( level.teamflags["axis"] ) )
            wait 0.5;

        foreach ( var_2 in level.teamflags )
        {
            if ( isdefined( var_2 ) )
                var_2.onpickupfailed = ::customresetflag;
        }
    }

    if ( isdefined( level.gametype ) )
    {
        if ( level.gametype == "sd" || level.gametype == "sr" )
            level thread movebombsitea();
    }
}

movebombsitea()
{
    var_0 = 15;
    var_1 = 0;
    var_2 = 0;
    var_3 = 5;
    var_4 = getentarray( "bombzone", "targetname" );
    var_5 = [];

    foreach ( var_7 in var_4 )
    {
        if ( isdefined( var_7.script_label ) && var_7.script_label == "_a" )
        {
            var_5[var_5.size] = var_7;
            var_8 = getent( var_7.target, "targetname" );
            var_5[var_5.size] = var_8;
            var_5[var_5.size] = getent( var_8.target, "targetname" );
            break;
        }
    }

    var_10 = getentarray( "exploder", "targetname" );

    foreach ( var_12 in var_10 )
    {
        if ( isdefined( var_12.script_gameobjectname ) && var_12.script_gameobjectname == "bombzone" )
        {
            if ( isdefined( var_12.script_exploder ) && issubstr( var_12.script_exploder, "_1" ) )
            {
                var_5[var_5.size] = var_12;
                break;
            }
        }
    }

    var_14 = getentarray( "script_brushmodel", "classname" );

    foreach ( var_16 in var_14 )
    {
        if ( isdefined( var_16.script_gameobjectname ) && var_16.script_gameobjectname == "bombzone" )
        {
            if ( isdefined( var_16.script_label ) && var_16.script_label == "bombzone_a" )
            {
                var_5[var_5.size] = var_16;
                break;
            }
        }
    }

    foreach ( var_19 in var_5 )
    {
        var_19.origin += ( 0, 0, var_0 );
        var_19.angles += ( var_1, var_2, var_3 );
    }
}

resetuplinkballoutofbounds()
{
    level endon( "game_ended" );

    if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread watchcarryobjects();
    }
}

watchcarryobjects()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "dropped" );
        wait 0.1;
        thread monitorballstate();
        var_0 = common_scripts\utility::waittill_any_return( "pickup_object", "reset" );
    }
}

monitorballstate()
{
    self endon( "pickup_object" );
    self endon( "reset" );

    for (;;)
    {
        if ( isoutofbounds() )
        {
            thread maps\mp\gametypes\_gameobjects::returnhome();
            return;
        }

        wait 0.05;
    }
}

isoutofbounds()
{
    var_0 = getentarray( "object_out_of_bounds", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !self.visuals[0] _meth_80A9( var_0[var_1] ) )
            continue;

        return 1;
    }

    return 0;
}

getclownlights()
{
    level.clownlightson = getentarray( "lights_on", "targetname" );
    level.clownlightsoff = getentarray( "lights_off", "targetname" );

    foreach ( var_1 in level.clownlightson )
        var_1 hide();
}

clowntowncustomosp()
{
    level.orbitalsupportoverrides.spawnheight = 6500;
    level.orbitalsupportoverrides.spawnradius = 6500;
}

clowntowncustomairstrike()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 750;
}

clowntown3_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

rotating_bed_setup()
{
    var_0 = getentarray( "bed_collision", "targetname" );
    var_1 = getent( "bed_model", "targetname" );
    var_2 = 10000;
    thread aud_bed_sfx( var_1 );

    foreach ( var_4 in var_0 )
        var_4 _meth_804D( var_1 );

    var_1 _meth_82BD( ( 0, -10, 0 ), var_2 );
}

rotating_fans_setup()
{
    level.fans = getentarray( "ceilingfan_01", "targetname" );

    foreach ( var_3, var_1 in level.fans )
    {
        var_2 = common_scripts\utility::mod( var_3, 3 ) + 1;
        var_1 _meth_8279( "ct_ceiling_fan_idle_" + var_2 );
        wait 0.2;
    }
}

clowntown_dynamic_event()
{
    level endon( "dynamic_event_starting" );
    wait 8;
    sign_startup_sequence();
    wait 5;

    for (;;)
    {
        cannon_firing_event();

        while ( level.bombsonstandby.size <= level.bomb_count_min )
            waitframe();

        if ( isdefined( level.ishorde ) && level.ishorde )
        {
            wait(randomintrange( 300, 360 ));

            while ( level.currentaliveenemycount < 1 )
                wait 10;

            continue;
        }

        wait(randomintrange( 20, 30 ));
    }
}

sign_init()
{
    level.anim_sign = getent( "clown_sign", "targetname" );
    level.sign_off = getent( "clown_sign_off", "targetname" );
    level.sign_on = getent( "clown_sign_on_static", "targetname" );
    level.anim_sign hide();
    level.sign_on hide();
}

sign_startup_sequence()
{
    thread aud_clowntown_sign_startup_sequence();

    if ( isdefined( level.clownlightsoff ) && isdefined( level.clownlightson ) )
    {
        foreach ( var_1 in level.clownlightsoff )
            var_1 hide();

        foreach ( var_1 in level.clownlightson )
            var_1 show();
    }

    sign_on();
    wait 0.5;
    sign_off();
    wait 0.3;
    sign_on();
    wait 0.3;
    sign_off();
    wait 0.5;
    sign_on();
    wait 0.5;
    sign_off();
    wait 0.3;
    sign_on();
    wait 1;
    level.sign_on hide();
    level.anim_sign show();
    thread scriptmodelplayanimwithnotifycheap( level.anim_sign, "ct_motel_sign_idle", "motel_sign_idle_notify", "ct_motel_sign_idle_start", "ct3_cannon_idle_mech", "aud_stop_01", "aud_stop_02", "aud_stop_03" );
}

sign_off()
{
    level.sign_on _meth_8510();
    level.sign_off show();
}

sign_on()
{
    level.sign_on show();
    level.sign_off _meth_8510();
}

cannon_firing_event()
{
    var_0 = level.bombsonstandby.size;
    level.bomb_targets = common_scripts\utility::array_randomize( level.bomb_targets );
    level.anim_sign waittillmatch( "motel_sign_idle_notify", "ct_motel_sign_idle_start" );
    level.anim_sign _meth_827A();
    level.anim_sign _meth_8279( "ct_motel_sign_hat_off", "anim_end" );
    var_1 = 20;
    aud_event_sign_hat_off( var_1 );
    wait 6.96;

    for ( var_2 = 0; var_2 < var_0; var_2++ )
    {
        if ( isdefined( level.bombsonstandby[0] ) )
        {
            level.bombsonstandby[0] bomb_fires( var_2 );
            level.anim_sign _meth_827A();
            level.anim_sign _meth_8279( "ct_motel_sign_hat_off_idle", "anim_end" );
            wait 4;
        }
    }

    level.anim_sign _meth_827A();
    level.anim_sign _meth_8279( "ct_motel_sign_hat_on", "anim_end" );
    aud_event_sign_hat_on( var_1 );
    wait 7.7;
    scriptmodelplayanimwithnotifycheap( level.anim_sign, "ct_motel_sign_idle", "motel_sign_idle_notify", "ct_motel_sign_idle_start", "ct3_cannon_idle_mech", "aud_stop_01", "aud_stop_02", "aud_stop_03" );
    wait 1;
}

bombs_init()
{
    wait 1;
    level.bombsonstandby = [];
    level.launch_point = getent( "org_bomb_launch", "targetname" );
    level.bomb_targets = getentarray( "org_bomb_targets", "targetname" );
    level.bomb_count_max = 6;
    level.bomb_count_min = 2;

    for ( var_0 = 0; var_0 < level.bomb_count_max; var_0++ )
    {
        var_1 = spawn( "script_model", ( 0, 0, -10 ) );
        var_1 _meth_80B1( "npc_bomb_clown" );
        var_1 thread bomb_physics_impact_watch();
        var_2 = 24;
        var_3 = getent( "bomb_pickup_" + ( var_0 + 1 ), "targetname" );

        if ( isdefined( var_3 ) )
            var_3.origin = var_1.origin;
        else
            var_3 = spawn( "trigger_radius", var_1.origin - ( 0, 0, var_2 / 2 ), 0, var_2, var_2 );

        var_3 _meth_8069();
        var_3 _meth_804D( var_1 );
        var_3.no_moving_platfrom_unlink = 1;
        var_4 = [ var_1 ];
        var_5 = maps\mp\gametypes\_gameobjects::createcarryobject( "any", var_3, var_4, ( 0, 0, 32 ) );
        var_5 maps\mp\gametypes\_gameobjects::allowcarry( "any" );
        var_5 maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
        var_5.objidpingenemy = 1;
        var_5.objpingdelay = 1.0;
        var_5.allowweapons = 0;
        var_5.carryweapon = "iw5_dlcgun12loot9_mp";
        var_5.keepcarryweapon = 1;
        var_5.waterbadtrigger = 0;
        var_5.visualgroundoffset = ( 0, 0, 30 );
        var_5.canuseobject = ::bomb_can_pickup;
        var_5.onpickup = ::bomb_on_pickup;
        var_5.setdropped = ::bomb_set_dropped;
        var_5.carryweaponthink = ::bomb_throw;
        var_5.requireslos = 1;
        maps\mp\_utility::_objective_delete( var_5.objidallies );
        maps\mp\_utility::_objective_delete( var_5.objidaxis );
        maps\mp\_utility::_objective_delete( var_5.objidmlgspectator );
        var_5.compassicons = undefined;
        var_5.objidallies = undefined;
        var_5.objidaxis = undefined;
        var_5.objidmlgspectator = undefined;
        level.bombsonstandby[level.bombsonstandby.size] = var_5;
        waitframe();
    }
}

bomb_fires( var_0 )
{
    var_1 = level.bomb_targets[var_0];
    var_2 = self.visuals[0];
    var_2 show();
    var_2 _meth_8092();
    self.bomb_fx_active = 0;
    var_2 _meth_84E1();
    var_2.origin = level.launch_point.origin;
    level.mines[level.mines.size] = var_2;
    var_3 = var_1.origin + ( randomfloatrange( -10, 10 ), randomfloatrange( -10, 10 ), randomfloatrange( -10, 10 ) );
    var_4 = ( var_3 - var_2.origin ) * 2;
    var_5 = ( 0, 0, 0 );
    var_2 _meth_8276( var_2.origin + var_5, var_4 );
    aud_event_fire_bomb();
    thread bomb_fuse_default();
    level.bombsonstandby = common_scripts\utility::array_remove( level.bombsonstandby, self );
    bomb_fx_start();
    radiusdamage( level.launch_point.origin + ( 0, 0, 20 ), 20, 50, 40 );
    playfx( common_scripts\utility::getfx( "cannon_firing" ), level.launch_point.origin + ( 0, 0, 35 ) );
    var_6 = anglestoforward( level.launch_point.origin );
    var_7 = anglestoup( level.launch_point.origin );
}

bomb_fuse_default()
{
    self endon( "stop_fuse" );
    self endon( "pickup_object" );
    var_0 = 15;
    var_1 = self.visuals[0];
    playfxontag( common_scripts\utility::getfx( "mp_clowntown_bomb_fuse" ), var_1, "tag_fx" );

    while ( var_0 > 0 )
    {
        if ( isdefined( self ) && var_0 < 4 )
            playfx( common_scripts\utility::getfx( "ball_flash" ), self.visuals[0].origin );

        wait 1;
        var_0 -= 1;
    }

    _func_071( "iw5_dlcgun12loot8_mp", self.visuals[0].origin, ( 0, 0, 0 ), 0 );
    thread bomb_cleanup();
}

bomb_fuse_short()
{
    self endon( "stop_fuse" );
    self endon( "pickup_object" );

    for ( var_0 = 3; var_0 > 0; var_0 -= 1 )
    {
        if ( isdefined( self ) && var_0 < 4 )
            playfx( common_scripts\utility::getfx( "ball_flash" ), self.visuals[0].origin );

        wait 1;
    }

    _func_071( "iw5_dlcgun12loot8_mp", self.visuals[0].origin, ( 0, 0, 0 ), 0 );
    thread bomb_cleanup();
}

bomb_can_pickup( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isdefined( var_0.underwater ) && var_0.underwater )
        return 0;

    if ( isdefined( self.droptime ) && self.droptime >= gettime() )
        return 0;

    if ( !var_0 common_scripts\utility::isweaponenabled() )
        return 0;

    if ( var_0 _meth_8342() )
        return 0;

    if ( isdefined( var_0.manuallyjoiningkillstreak ) && var_0.manuallyjoiningkillstreak )
        return 0;

    var_1 = var_0 _meth_8311();

    if ( isdefined( var_1 ) )
    {
        if ( !valid_bomb_pickup_weapon( var_1 ) )
            return 0;
    }

    var_2 = var_0.changingweapon;

    if ( isdefined( var_2 ) && var_0 _meth_8337() )
    {
        if ( !valid_bomb_pickup_weapon( var_2 ) )
            return 0;
    }

    if ( isdefined( var_0.exo_shield_on ) && var_0.exo_shield_on == 1 )
        return 0;

    if ( var_0 maps\mp\_utility::isjuggernaut() )
        return 0;

    if ( isbot( var_0 ) || isagent( var_0 ) )
        return 0;

    if ( var_0 player_no_pickup_time() )
        return 0;

    return 1;
}

valid_bomb_pickup_weapon( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    if ( var_0 == "iw5_dlcgun12loot9_mp" )
        return 0;

    if ( maps\mp\_utility::iskillstreakweapon( var_0 ) )
        return 0;

    if ( var_0 == "iw5_combatknifegoliath_mp" )
        return 0;

    return 1;
}

player_no_pickup_time()
{
    return isdefined( self.nopickuptime ) && self.nopickuptime > gettime();
}

bomb_on_pickup( var_0 )
{
    level.usestartspawns = 0;
    self notify( "pickup_object" );
    level.mines = common_scripts\utility::array_remove( level.mines, self.visuals[0] );
    var_1 = self.visuals[0] _meth_83EC();

    if ( isdefined( var_1 ) )
        self.visuals[0] _meth_804F();

    self.visuals[0] _meth_84E1();
    self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
    self.visuals[0] show();
    self.visuals[0] _meth_8510();
    self.trigger maps\mp\_movers::stop_handling_moving_platforms();
    bomb_fx_stop();
    var_0 _meth_82F6( "iw5_dlcgun12loot9_mp", 1 );
    var_0 maps\mp\_utility::giveperk( "specialty_ballcarrier", 0 );
    var_0 common_scripts\utility::_disableusability();
    var_0 maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
}

bomb_throw()
{
    self endon( "disconnect" );
    thread bomb_throw_watch();
    self.carryobject waittill( "dropped" );
}

bomb_throw_watch()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "drop_object" );
    var_0 = getdvarfloat( "scr_ball_shoot_extra_pitch", -12 );
    var_1 = getdvarfloat( "scr_ball_shoot_force", 320 );

    for (;;)
    {
        self waittill( "weapon_fired", var_2 );

        if ( var_2 != "iw5_dlcgun12loot9_mp" )
            continue;

        break;
    }

    if ( isdefined( self.carryobject ) )
    {
        var_3 = self getangles();
        var_3 += ( var_0, 0, 0 );
        var_3 = ( clamp( var_3[0], -85, 85 ), var_3[1], var_3[2] );
        var_4 = anglestoforward( var_3 );
        thread bomb_throw_active();
        wait 0.25;
        self playsound( "mp_ul_ball_throw" );
        self.carryobject bomb_create_killcam_ent();
        self.carryobject thread bomb_physics_launch_drop( var_4 * var_1, self );
    }
}

bomb_physics_impact_watch()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "physics_impact", var_0, var_1, var_2, var_3 );
        var_4 = level._effect["ball_physics_impact"];

        if ( isdefined( var_3 ) && isdefined( level._effect["ball_physics_impact_" + var_3] ) )
            var_4 = level._effect["ball_physics_impact_" + var_3];

        playfx( var_4, var_0, var_1 );
        thread aud_play_bomb_bounce();
        wait 0.3;
    }
}

bomb_throw_active()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.pass_or_throw_active = 1;
    self _meth_8130( 0 );

    while ( "iw5_dlcgun12loot9_mp" == self _meth_8311() )
        waitframe();

    self _meth_8130( 1 );
    self.pass_or_throw_active = 0;
}

bomb_physics_launch_drop( var_0, var_1 )
{
    bomb_carrier_cleanup();
    self.ownerteam = "any";
    maps\mp\gametypes\_gameobjects::clearcarrier();
    bomb_physics_launch( var_0, var_1 );
}

bomb_physics_launch( var_0, var_1 )
{
    var_2 = self.visuals[0];
    var_2.origin_prev = undefined;
    bomb_cleanup();
    var_3 = anglestoforward( var_1 getangles() ) * 940 + anglestoup( var_1 getangles() ) * 120;
    var_4 = var_1 _meth_80A8();
    var_5 = _func_071( "iw5_dlcgun12loot8_mp", var_4, var_3, 2, var_1 );
}

bomb_create_killcam_ent()
{
    if ( isdefined( self.killcament ) )
        self.killcament delete();

    self.killcament = spawn( "script_model", self.visuals[0].origin );
    self.killcament _meth_804D( self.visuals[0] );
    self.killcament setcontents( 0 );
    self.killcament _meth_834D( "explosive" );
}

bomb_set_dropped( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    self.isresetting = 1;
    self.droptime = gettime();
    self notify( "dropped" );
    var_1 = self.carrier;

    if ( isdefined( var_1 ) && var_1.team != "spectator" )
        var_2 = var_1.origin;
    else
        var_2 = self.safeorigin;

    var_3 = self.visuals[0];
    var_3.origin = var_2;
    var_3 show();
    var_3 _meth_8276( var_3.origin + ( 0, 1, 0 ) );
    level.mines[level.mines.size] = var_3;
    thread bomb_fuse_short();
    bomb_carrier_cleanup();
    bomb_fx_start();
    self.ownerteam = "any";
    maps\mp\gametypes\_gameobjects::clearcarrier();
    return 1;
}

bomb_carrier_cleanup()
{
    if ( isdefined( self.carrier ) )
    {
        self.carrier.nopickuptime = gettime() + 500;
        self.carrier maps\mp\_utility::_unsetperk( "specialty_ballcarrier" );
        self.carrier common_scripts\utility::_enableusability();
        self.carrier maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
    }
}

bomb_dont_interpolate()
{
    self.visuals[0] _meth_8092();
    self.bomb_fx_active = 0;
}

bomb_cleanup()
{
    self notify( "stop_fuse" );
    bomb_fx_stop();
    self.visuals[0] _meth_8092();
    self.bomb_fx_active = 0;
    self.visuals[0] _meth_84E1();
    self.visuals[0].origin = ( 0, 0, 0 );
    level.mines = common_scripts\utility::array_remove( level.mines, self.visuals[0] );
    level.bombsonstandby = common_scripts\utility::array_add( level.bombsonstandby, self );
}

bomb_fx_start()
{
    if ( !bomb_fx_active() )
    {
        var_0 = self.visuals[0];
        playfxontag( common_scripts\utility::getfx( "ball_trail" ), var_0, "body_animate_jnt" );
        playfxontag( common_scripts\utility::getfx( "ball_idle" ), var_0, "body_animate_jnt" );
        var_0 _meth_83FA( 0, 0 );
        self.bomb_fx_active = 1;
        var_0 _meth_8075( "mp_clown_bomb_fuse_lp_world" );
    }
}

bomb_fx_stop()
{
    if ( bomb_fx_active() )
    {
        var_0 = self.visuals[0];
        stopfxontag( common_scripts\utility::getfx( "ball_trail" ), var_0, "body_animate_jnt" );
        killfxontag( common_scripts\utility::getfx( "ball_idle" ), var_0, "body_animate_jnt" );
        killfxontag( common_scripts\utility::getfx( "mp_clowntown_bomb_fuse" ), var_0, "tag_fx" );
        var_0 _meth_83FB();
        var_0 _meth_80AC();
    }

    self.bomb_fx_active = 0;
}

bomb_fx_active()
{
    return isdefined( self.bomb_fx_active ) && self.bomb_fx_active;
}

customresetflag( var_0 )
{
    var_1 = var_0.pers["team"];

    if ( var_1 == "allies" )
        var_2 = "axis";
    else
        var_2 = "allies";

    if ( var_1 == maps\mp\gametypes\_gameobjects::getownerteam() )
    {
        maps\mp\gametypes\ctf::flageffectsstop();
        thread maps\mp\gametypes\ctf::returnflag();
        maps\mp\_utility::leaderdialog( "flag_returned", var_1, "status" );
        maps\mp\_utility::playsoundonplayers( "mp_obj_notify_pos_med", var_1 );
        maps\mp\_utility::leaderdialog( "enemy_flag_returned", var_2, "status" );
        maps\mp\_utility::playsoundonplayers( "mp_obj_notify_neg_med", var_2 );
        var_0 thread maps\mp\_events::flagreturnevent();
        maps\mp\gametypes\ctf::onresetflaghudstatus( var_1 );
    }
}

ct_vista_cars()
{
    level endon( "game_ended" );
    var_0 = ( 33, 62, -3 );
    var_1 = ( 33, -105, -3 );
    level.car01 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car02 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car03 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car04 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car05 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car06 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car07 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car08 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car09 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car10 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car11 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car12 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car13 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car14 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car15 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car16 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car17 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car18 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car19 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car20 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car21 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car22 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car23 = spawncar( var_1, ( 0, 252, 0 ) );
    level.car24 = spawncar( var_0, ( 0, 252, 0 ) );
    level.car01 _meth_80B1( "vehicle_ct_civ_vista_cars_01" );
    level.car02 _meth_80B1( "vehicle_ct_civ_vista_cars_02" );
    level.car03 _meth_80B1( "vehicle_ct_civ_vista_cars_03" );
    level.car04 _meth_80B1( "vehicle_ct_civ_vista_cars_04" );
    level.car05 _meth_80B1( "vehicle_ct_civ_vista_cars_05" );
    level.car06 _meth_80B1( "vehicle_ct_civ_vista_cars_06" );
    level.car07 _meth_80B1( "vehicle_ct_civ_vista_cars_06" );
    level.car08 _meth_80B1( "vehicle_ct_civ_vista_cars_05" );
    level.car09 _meth_80B1( "vehicle_ct_civ_vista_cars_04" );
    level.car10 _meth_80B1( "vehicle_ct_civ_vista_cars_03" );
    level.car11 _meth_80B1( "vehicle_ct_civ_vista_cars_02" );
    level.car12 _meth_80B1( "vehicle_ct_civ_vista_cars_01" );
    level.car13 _meth_80B1( "vehicle_ct_civ_vista_cars_03" );
    level.car14 _meth_80B1( "vehicle_ct_civ_vista_cars_01" );
    level.car15 _meth_80B1( "vehicle_ct_civ_vista_cars_02" );
    level.car16 _meth_80B1( "vehicle_ct_civ_vista_cars_06" );
    level.car17 _meth_80B1( "vehicle_ct_civ_vista_cars_04" );
    level.car18 _meth_80B1( "vehicle_ct_civ_vista_cars_05" );
    level.car19 _meth_80B1( "vehicle_ct_civ_vista_cars_02" );
    level.car20 _meth_80B1( "vehicle_ct_civ_vista_cars_04" );
    level.car21 _meth_80B1( "vehicle_ct_civ_vista_cars_06" );
    level.car22 _meth_80B1( "vehicle_ct_civ_vista_cars_01" );
    level.car23 _meth_80B1( "vehicle_ct_civ_vista_cars_03" );
    level.car24 _meth_80B1( "vehicle_ct_civ_vista_cars_05" );
    level.car01 _meth_82BF();
    level.car02 _meth_82BF();
    level.car03 _meth_82BF();
    level.car04 _meth_82BF();
    level.car05 _meth_82BF();
    level.car06 _meth_82BF();
    level.car07 _meth_82BF();
    level.car08 _meth_82BF();
    level.car09 _meth_82BF();
    level.car10 _meth_82BF();
    level.car11 _meth_82BF();
    level.car12 _meth_82BF();
    level.car13 _meth_82BF();
    level.car14 _meth_82BF();
    level.car15 _meth_82BF();
    level.car16 _meth_82BF();
    level.car17 _meth_82BF();
    level.car18 _meth_82BF();
    level.car19 _meth_82BF();
    level.car20 _meth_82BF();
    level.car21 _meth_82BF();
    level.car22 _meth_82BF();
    level.car23 _meth_82BF();
    level.car24 _meth_82BF();
    level.car01 hide();
    level.car02 hide();
    level.car03 hide();
    level.car04 hide();
    level.car05 hide();
    level.car06 hide();
    level.car07 hide();
    level.car08 hide();
    level.car09 hide();
    level.car10 hide();
    level.car11 hide();
    level.car12 hide();
    level.car13 hide();
    level.car14 hide();
    level.car15 hide();
    level.car16 hide();
    level.car17 hide();
    level.car18 hide();
    level.car19 hide();
    level.car20 hide();
    level.car21 hide();
    level.car22 hide();
    level.car23 hide();
    level.car24 hide();
    wait 0.05;
    level.car01 _meth_8279( "ct_vista_car_1" );
    level.car02 _meth_8279( "ct_vista_car_2" );
    level.car03 _meth_8279( "ct_vista_car_3" );
    level.car04 _meth_8279( "ct_vista_car_4" );
    level.car05 _meth_8279( "ct_vista_car_5" );
    level.car06 _meth_8279( "ct_vista_car_6" );
    level.car01 thread unhidecar();
    level.car02 thread unhidecar();
    level.car03 thread unhidecar();
    level.car04 thread unhidecar();
    level.car05 thread unhidecar();
    level.car06 thread unhidecar();
    wait 5;
    level.car07 _meth_8279( "ct_vista_car_1" );
    level.car08 _meth_8279( "ct_vista_car_2" );
    level.car09 _meth_8279( "ct_vista_car_3" );
    level.car10 _meth_8279( "ct_vista_car_4" );
    level.car11 _meth_8279( "ct_vista_car_5" );
    level.car12 _meth_8279( "ct_vista_car_6" );
    level.car07 thread unhidecar();
    level.car08 thread unhidecar();
    level.car09 thread unhidecar();
    level.car10 thread unhidecar();
    level.car11 thread unhidecar();
    level.car12 thread unhidecar();
    wait 5;
    level.car13 _meth_8279( "ct_vista_car_1" );
    level.car14 _meth_8279( "ct_vista_car_2" );
    level.car15 _meth_8279( "ct_vista_car_3" );
    level.car16 _meth_8279( "ct_vista_car_4" );
    level.car17 _meth_8279( "ct_vista_car_5" );
    level.car18 _meth_8279( "ct_vista_car_6" );
    level.car13 thread unhidecar();
    level.car14 thread unhidecar();
    level.car15 thread unhidecar();
    level.car16 thread unhidecar();
    level.car17 thread unhidecar();
    level.car18 thread unhidecar();
    wait 5;
    level.car19 _meth_8279( "ct_vista_car_1" );
    level.car20 _meth_8279( "ct_vista_car_2" );
    level.car21 _meth_8279( "ct_vista_car_3" );
    level.car22 _meth_8279( "ct_vista_car_4" );
    level.car23 _meth_8279( "ct_vista_car_5" );
    level.car24 _meth_8279( "ct_vista_car_6" );
    level.car19 thread unhidecar();
    level.car20 thread unhidecar();
    level.car21 thread unhidecar();
    level.car22 thread unhidecar();
    level.car23 thread unhidecar();
    level.car24 thread unhidecar();
}

unhidecar()
{
    wait 0.1;
    self show();
}

spawncar( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0 );
    var_2.angles = var_1;
    return var_2;
}

delete_ct_vista_cars()
{
    level waittill( "game_ended" );
    level.car01 delete();
    level.car02 delete();
    level.car03 delete();
    level.car04 delete();
    level.car05 delete();
    level.car06 delete();
    level.car07 delete();
    level.car08 delete();
    level.car09 delete();
    level.car10 delete();
    level.car11 delete();
    level.car12 delete();
    level.car13 delete();
    level.car14 delete();
    level.car15 delete();
    level.car16 delete();
    level.car17 delete();
    level.car18 delete();
    level.car19 delete();
    level.car20 delete();
    level.car21 delete();
    level.car22 delete();
    level.car23 delete();
    level.car24 delete();
}

aud_play_bomb_flash()
{

}

aud_play_bomb_bounce()
{
    if ( isdefined( self ) )
        maps\mp\_audio::snd_play_in_space( "wpn_clown_bomb_bounce", self.origin );
}

aud_bed_sfx( var_0 )
{
    maps\mp\_audio::snd_play_linked_loop( "emt_mp_ct3_bed_music_lp", var_0 );
}

aud_clowntown_sign_startup_sequence()
{
    maps\mp\_audio::snd_play_in_space( "ct3_cannon_shot_music", level.launch_point.origin );
    maps\mp\_audio::snd_play_in_space( "mp_anr_clown_dyn_welcome", level.launch_point.origin );
}

aud_event_sign_mech_idle()
{
    wait 1.5;
    maps\mp\_audio::snd_play_loop_in_space( "ct3_cannon_idle_mech_lp", level.launch_point.origin, "aud_stop_mech_loop" );
}

aud_event_sign_hat_off( var_0 )
{
    maps\mp\_audio::snd_play_in_space( "ct3_cannon_mech_start", level.launch_point.origin, var_0 );
    maps\mp\_audio::snd_play_in_space( "ct3_cannon_shot_fireworks", level.launch_point.origin, var_0 );
    maps\mp\_audio::snd_play_in_space( "ct3_cannon_shot_music", level.launch_point.origin, var_0 );
    maps\mp\_audio::snd_play_in_space( "mp_anr_clown_dyn_carnival", level.launch_point.origin );
}

aud_event_fire_bomb()
{
    maps\mp\_audio::snd_play_in_space( "ct3_cannon_shot", level.launch_point.origin );
}

aud_event_sign_hat_on( var_0 )
{
    maps\mp\_audio::snd_play_in_space_delayed( "ct3_cannon_mech_end", level.launch_point.origin, 0.55, var_0 );
    maps\mp\_audio::snd_play_in_space( "mp_anr_clown_dyn_carnival", level.launch_point.origin );
}

scriptmodelplayanimwithnotifycheap( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( var_5 ) )
        level endon( var_5 );

    var_0 _meth_827B( var_1, var_2 );
    thread scriptmodelplayanimwithnotifycheap_notetracks( var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

scriptmodelplayanimwithnotifycheap_notetracks( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_4 ) )
        level endon( var_4 );

    if ( isdefined( var_5 ) )
        var_0 endon( var_5 );

    if ( isdefined( var_6 ) )
        var_0 endon( var_6 );

    var_0 endon( "death" );

    for (;;)
    {
        var_0 waittillmatch( var_1, var_2 );
        var_0 playsound( var_3 );
    }
}

clowntownclippatch()
{

}
