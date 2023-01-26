// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::kremlin_callbackstartgametype;
    maps\mp\mp_kremlin_precache::main();
    maps\createart\mp_kremlin_art::main();
    maps\mp\mp_kremlin_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_kremlin_lighting::main();
    maps\mp\mp_kremlin_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_kremlin" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_65AB = "mp_kremlin_osp";
    level._id_65A9 = "mp_kremlin_osp";
    level._id_2F3B = "mp_kremlin_drone";
    level._id_2F12 = "mp_kremlin_drone";
    level._id_A197 = "mp_kremlin_warbird";
    level._id_A18C = "mp_kremlin_warbird";
    map_restart( "krem_killstreak_mine_close" );
    map_restart( "krem_killstreak_mine_closed_idle" );
    map_restart( "krem_killstreak_mine_open" );
    map_restart( "krem_killstreak_mine_open_idle" );
    level._id_6573 = ::kremlinpaladinoverrides;
    thread mine_init();
    level _id_2FE8();
    level _id_2FE7();
    level thread maps\mp\_dynamic_events::_id_2FE6( ::startdynamicevent, ::resetdynamicevent, ::enddynamicevent );

    if ( level.nextgen )
        thread set_walker_tank_anims();

    level thread resetuplinkballoutofbounds();
    level._id_099D = spawnstruct();
    level._id_099D._id_89DC = 600;

    if ( level.nextgen )
        thread scriptpatchclip();
}

kremlin_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

kremlinpaladinoverrides()
{
    level._id_6574._id_898B = 30;
    level._id_6574._id_898A = 120;
    level._id_6574._id_89DC = 7000;
    level._id_6574._id_8A00 = 5000;
    level._id_6574._id_0252 = 45;
    level._id_6574._id_0380 = 45;
    level._id_6574._id_04BD = -32;
    level._id_6574._id_0089 = 80;
}

set_walker_tank_anims()
{
    var_0 = getent( "walker_tank_south_1", "targetname" );
    var_0._id_0C72 = "krem_walker_tank_south01";
    var_0.animtime = 54.2;
    var_1 = getent( "walker_tank_north_1", "targetname" );
    var_1._id_0C72 = "krem_walker_tank_north01";
    var_1.animtime = 93.36;
    var_2 = getent( "walker_tank_north_2", "targetname" );
    var_2._id_0C72 = "krem_walker_tank_north02";
    var_2.animtime = 93.36;
    var_3 = getent( "walker_tank_west_1", "targetname" );
    var_3._id_0C72 = "krem_walker_tank_west01";
    var_3.animtime = 111;
    var_4 = [ var_0, var_1, var_2, var_3 ];

    foreach ( var_6 in var_4 )
        var_6 hide();

    var_1 thread sequence_walker_tank_anims();
    wait 10;
    var_3 thread sequence_walker_tank_anims();
}

sequence_walker_tank_anims()
{
    level endon( "game_ended" );

    for (;;)
    {
        play_walker_tank_anims();
        wait 10;
    }
}

play_walker_tank_anims()
{
    self scriptmodelplayanim( self._id_0C72 );
    self show();
    wait(self.animtime);
    self hide();
}

mine_init()
{
    level.minesettings = [];
    level.minesettings["mine"] = spawnstruct();
    level.minesettings["mine"]._id_051C = "iw5_dlcgun12loot1_mp";
    level.minesettings["mine"]._id_5D3A = "krm_mine";
    level.minesettings["mine"].animationactivate = "krem_killstreak_mine_open";
    level.minesettings["mine"].animationdeactivate = "krem_killstreak_mine_close";
    level.minesettings["mine"].animationidleactive = "krem_killstreak_mine_open_idle";
    level.minesettings["mine"].animationidleinactive = "krem_killstreak_mine_closed_idle";
    level.minesettings["mine"]._id_56F5 = 90.0;
    level.minesettings["mine"].graceperiod = 0.2;
    level.minesettings["mine"].modelexplosive = "ims_scorpion_explosive_iw6";
    level.minesettings["mine"].tagexplosive1 = "tag_explosive1";
    level.minesettings["mine"].team = "neutral";
    level.minesettings["mine"].eventstartcountdown = 6;
    level.minesettings["mine"]._id_33D9 = 60;
    level.minesettings["mine"].eventdisableduration = 1;
    level.minesettings["mine"].attackcooldown = 2;
    level.minesettings["mine"].empdisableduration = 10;

    if ( level.currentgen )
        level.minesettings["mine"]._id_202E = getent( "mineField_mineCollision", "targetname" );

    level.minekillcamoffset = ( 0.0, 0.0, 12.0 );
    level._effect["mine_antenna_light_mp"] = loadfx( "vfx/map/mp_kremlin/krem_light_detonator_blink" );
    level._effect["mine_emp_disable_fx"] = loadfx( "vfx/sparks/emp_drone_damage" );
}

_id_2FE8()
{
    level.minesoundactivatealarm = "mp_kre_mine_warning";
    level.minesoundactivatemine = "mp_kre_mine_activate";
    level.minesoundlaunchmine = "mp_kre_mine_popup";
}

_id_2FE7()
{
    level endon( "game_ended" );
    maps\mp\_dynamic_events::_id_7F59( 0.5 );
    setdvar( "scr_dynamic_event_start_perc", level._id_2FE6["start_percent"] );
    level.minetype = "mine";
    thread minefielddeploy();
    level.cancelbadminefieldspawns = 0;
    level.mineeventcomplete = 0;
}

minefielddeploy()
{
    level endon( "game_ended" );
    level.minelist = [];
    level.minespawnlist = common_scripts\utility::getstructarray( "mineField_mineLoc", "targetname" );
    common_scripts\utility::array_randomize( level.minespawnlist );

    foreach ( var_1 in level.minespawnlist )
        createmine( var_1 );
}

startdynamicevent()
{
    level endon( "game_ended" );
    level notify( "minefield_beginActivation" );
    thread handleminefieldsettimer();
    thread minefieldsetactive();
    thread minefieldsetinactive();
    thread minefieldareafx();
}

resetdynamicevent()
{
    if ( !isdefined( level.mineeventcomplete ) || !level.mineeventcomplete )
        level waittill( "minefield_complete" );

    wait 1;
    level.cancelbadminefieldspawns = 0;
    level.mineeventcomplete = 0;
}

debugmineactivatewarning()
{
    level endon( "game_ended" );
    iprintlnbold( "Warning: Mine Field Active in 5 seconds..." );
    wait 2;
    iprintlnbold( "4..." );
    wait 1;
    iprintlnbold( "3..." );
    wait 1;
    iprintlnbold( "2..." );
    wait 1;
    iprintlnbold( "1..." );
    wait 1;
    iprintlnbold( "Mine Field Active" );
}

debugminedectivatewarning()
{
    level endon( "game_ended" );
    iprintlnbold( "Kremlin Defense Field is now deactive" );
}

enddynamicevent()
{
    level endon( "game_ended" );
    thread minefieldsetinactive();
}

createmine( var_0 )
{
    var_1 = level.minetype;
    var_2 = spawn( "script_model", var_0.origin );
    var_2 setmodel( level.minesettings[var_1]._id_5D3A );
    var_2._id_782A = 3;
    var_2.health = 1000;
    var_2.angles = ( 0.0, 0.0, 0.0 );

    if ( isdefined( var_0.angles ) )
        var_2.angles = var_0.angles;

    var_2.minetype = level.minetype;
    var_2.team = level.minesettings["mine"].team;
    var_2._id_84AA = 0;
    var_2._id_0E48 = var_0.radius;
    var_2.attackheight = var_0.height;

    if ( var_0.origin == ( -204.3, 893.5, 122.9 ) )
        var_2.attackheight = 80;

    var_2.animationactivate = level.minesettings[var_2.minetype].animationactivate;
    var_2.animationdeactivate = level.minesettings[var_2.minetype].animationdeactivate;
    var_2.animationidleactive = level.minesettings[var_2.minetype].animationidleactive;
    var_2.animationidleinactive = level.minesettings[var_2.minetype].animationidleinactive;

    if ( isdefined( var_2.animationidleinactive ) )
        var_2 scriptmodelplayanim( var_2.animationidleinactive );

    if ( level.nextgen )
    {
        var_3 = var_0.target;
        var_2.minecollision = getent( var_3, "targetname" );
    }

    var_2.explosive = spawn( "script_model", var_2 gettagorigin( level.minesettings[var_2.minetype].tagexplosive1 ) );
    var_2.explosive setmodel( level.minesettings[var_2.minetype].modelexplosive );
    var_2.explosive._id_0429 = level.minesettings[var_2.minetype].tagexplosive1;
    var_2.explosive linkto( var_2 );
    var_2.explosive.isenvironmentweapon = 1;
    var_2._id_7ADA = 1;

    if ( level.nextgen )
    {
        var_2.explosive.killcament = spawn( "script_model", var_2.explosive.origin + level.minekillcamoffset );
        var_2.explosive.killcament setscriptmoverkillcam( "explosive" );
    }

    var_2 setcandamage( 0 );
    level.minelist = common_scripts\utility::add_to_array( level.minelist, var_2 );
    var_2.activateoffsettime = level.minelist.size * 0.1;
    return var_2;
}

reload_mine()
{
    if ( isdefined( self.explosive ) )
    {
        self.explosive.fired = undefined;
        self.explosive.origin = self gettagorigin( level.minesettings[self.minetype].tagexplosive1 );
        self.explosive.angles = ( 0.0, 0.0, 0.0 );
        self.explosive linkto( self );

        if ( level.nextgen )
            self.explosive.killcament.origin = self.explosive.origin + level.minekillcamoffset;

        self.explosive show();
    }

    if ( level.currentgen && isdefined( self._id_91D0 ) )
        self._id_91D0 = undefined;
}

handleminefieldsettimer()
{
    level endon( "game_ended" );
    level waittill( "minefield_active" );

    if ( isdefined( level.minesettings["mine"].eventdisableduration ) && level.minesettings["mine"].eventdisableduration == 1 )
        return;

    wait(level.minesettings[level.minetype]._id_33D9);
    level notify( "minefield_beginDisable" );
}

minefieldsetactive()
{
    level endon( "game_ended" );
    level endon( "minefield_deactiavte_begin" );
    var_0 = getentarray( "mine_field_trigger", "targetname" );
    thread handleminefieldwarningsound();
    thread disconnectnodesslowly();

    if ( isdefined( level.minelist ) )
    {
        foreach ( var_2 in level.minelist )
            var_2 thread activateminewithdelay();
    }

    if ( level.currentgen )
        thread cg_minecollisionmoveup();

    level notify( "minefield_active" );
}

cg_minecollisionmoveup()
{
    var_0 = level.minelist.size * 0.1 + 2.2;
    wait(var_0);

    if ( isdefined( level.minesettings["mine"]._id_202E ) )
        level.minesettings["mine"]._id_202E moveto( level.minesettings["mine"]._id_202E.origin + ( 0.0, 0.0, 30.0 ), 0.5 );
}

cg_minecollisionmovedown()
{
    if ( isdefined( level.minesettings["mine"]._id_202E ) )
        level.minesettings["mine"]._id_202E moveto( level.minesettings["mine"]._id_202E.origin + ( 0.0, 0.0, -30.0 ), 0.5 );
}

activateminewithdelay()
{
    var_0 = level.minesettings[self.minetype].eventstartcountdown;

    if ( isdefined( self.activateoffsettime ) )
        wait(self.activateoffsettime);

    thread play_mine_open_anim();
    thread play_mine_fx();
    wait(var_0);
    thread mine_setactive();
}

minefieldsetinactive()
{
    level endon( "game_ended" );
    level waittill( "minefield_beginDisable" );
    var_0 = getentarray( "mine_field_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        thread clearsetupsupportdropvolumes( var_2 );

    thread reconnectnodesslowly();

    if ( isdefined( level.minelist ) )
    {
        foreach ( var_5 in level.minelist )
            var_5 thread mine_setinactive();
    }

    if ( level.currentgen )
        thread cg_minecollisionmovedown();

    level.mineeventcomplete = 1;
    level notify( "minefield_complete" );
}

minefieldareafx()
{
    thread maps\mp\mp_kremlin_fx::laser_grid_a_fx();
    thread maps\mp\mp_kremlin_fx::laser_grid_b_fx();
}

mine_setactive()
{
    thread mine_handledamage();
    self setcandamage( 1 );
    self makeentitynomeleetarget();
    var_0 = ( 0.0, 0.0, 20.0 );
    var_1 = ( 0.0, 0.0, 128.0 );
    var_2 = [];
    var_3 = self gettagorigin( level.minesettings[self.minetype].tagexplosive1 ) + var_0;
    var_2[0] = bullettrace( var_3, var_3 + var_1 - var_0, 0, self );
    var_4 = var_2[0];

    for ( var_5 = 0; var_5 < var_2.size; var_5++ )
    {
        if ( var_2[var_5]["position"][2] < var_4["position"][2] )
            var_4 = var_2[var_5];
    }

    self.attackheightpos = var_4["position"] - ( 0.0, 0.0, 20.0 );
    var_6 = spawn( "trigger_radius", self.origin, 0, self._id_0E48, self.attackheight );
    self.attacktrigger = var_6;
    self.attackmovetime = distance( self.origin, self.attackheightpos ) / 350;
    thread mine_attacktargets();
}

mine_setinactive()
{
    self setcandamage( 0 );
    self freeentitysentient();

    if ( isdefined( self.activateoffsettime ) )
        wait(self.activateoffsettime);

    thread play_mine_close_anim();

    if ( isdefined( self.attacktrigger ) )
        self.attacktrigger delete();

    self notify( "mine_deactivate" );
}

mine_attacktargets()
{
    level endon( "game_ended" );
    self endon( "mine_deactivate" );

    for (;;)
    {
        if ( !isdefined( self.attacktrigger ) )
            break;

        self.attacktrigger waittill( "trigger", var_0 );

        if ( isplayer( var_0 ) )
        {
            if ( isdefined( var_0 ) && var_0 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                continue;

            if ( !maps\mp\_utility::isreallyalive( var_0 ) )
                continue;
        }
        else if ( isdefined( var_0.owner ) )
            continue;

        if ( !sighttracepassed( self.attackheightpos, var_0.origin + ( 0.0, 0.0, 50.0 ), 0, self ) || !sighttracepassed( self gettagorigin( level.minesettings[self.minetype].tagexplosive1 ) + ( 0.0, 0.0, 5.0 ), var_0.origin + ( 0.0, 0.0, 50.0 ), 0, self ) )
            continue;

        if ( level.currentgen )
        {
            self._id_91D0 = var_0;
            var_1 = 0;
            var_2 = common_scripts\utility::array_remove( level.minelist, self );

            foreach ( var_4 in var_2 )
            {
                if ( isdefined( var_4._id_91D0 ) && var_4._id_91D0 == self._id_91D0 )
                {
                    var_1 = 1;
                    self._id_91D0 = undefined;
                    break;
                }
            }

            if ( var_1 == 1 )
                continue;
        }

        if ( isplayer( var_0 ) && var_0 maps\mp\_utility::_hasperk( "specialty_delaymine" ) )
        {
            var_0 notify( "triggered_mine" );
            wait(level.delayminetime);
        }
        else
            wait(level.minesettings[self.minetype].graceperiod);

        self playsound( level.minesoundactivatemine );

        if ( isdefined( self.explosive ) && !isdefined( self.explosive.fired ) )
            fire_sensor( self.explosive );

        wait(level.minesettings[self.minetype].attackcooldown);
        thread reload_mine();
    }
}

fire_sensor( var_0 )
{
    var_0.fired = 1;
    var_0 unlink();
    var_0 rotateyaw( 3600, self.attackmovetime );
    var_0 moveto( self.attackheightpos, self.attackmovetime, self.attackmovetime * 0.25, self.attackmovetime * 0.25 );

    if ( isdefined( var_0.killcament ) )
        var_0.killcament moveto( self.attackheightpos + level.minekillcamoffset, self.attackmovetime, self.attackmovetime * 0.25, self.attackmovetime * 0.25 );

    var_0 playsound( level.minesoundlaunchmine );
    var_0 waittill( "movedone" );
    var_0 _meth_856A( level.minesettings["mine"]._id_051C );
    var_0 hide();
}

mine_handledamage()
{
    self endon( "mine_deactivate" );
    level endon( "game_ended" );
    self.health = 999999;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( isdefined( var_9 ) )
        {
            var_10 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_10 )
            {
                case "emp_grenade_mp":
                case "emp_grenade_var_mp":
                    thread mine_temporary_emp_disable();
                    break;
            }
        }

        self.health = 999999;
    }
}

mine_temporary_emp_disable()
{
    level endon( "game_ended" );
    self notify( "mine_emp" );
    self endon( "mine_emp" );

    if ( !isdefined( self.empdisable ) || self.empdisable == 0 )
    {
        self.empdisable = 1;

        if ( isdefined( self.attacktrigger ) )
            self.attacktrigger common_scripts\utility::trigger_off();

        playfxontag( common_scripts\utility::getfx( "mine_emp_disable_fx" ), self, "tag_origin" );
    }

    wait_for_emp_disable_done();
    stopfxontag( common_scripts\utility::getfx( "mine_emp_disable_fx" ), self, "tag_origin" );

    if ( isdefined( self.attacktrigger ) )
        self.attacktrigger common_scripts\utility::trigger_on();

    self.empdisable = 0;
    self notify( "emp_Disable_Complete" );
}

wait_for_emp_disable_done()
{
    self endon( "mine_deactivate" );
    var_0 = 0.75;
    wait(level.minesettings[self.minetype].empdisableduration - var_0);
    self notify( "emp_disable_almost_complete" );
    wait(var_0);
}

_id_8A06()
{
    level.dynamicspawns = ::_id_4005;
}

_id_4005( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3 _id_51F4() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

_id_51F4()
{
    if ( level.cancelbadminefieldspawns == 1 && self.targetname == "mineField_spawn" )
        return 0;

    return 1;
}

handleminefieldwarningsound()
{
    level endon( "game_ended" );
    var_0 = common_scripts\utility::getstructarray( "speaker_ent", "targetname" );
    var_1 = 0;

    for (;;)
    {
        if ( isdefined( var_0 ) )
        {
            foreach ( var_3 in var_0 )
                playsoundatpos( var_3.origin, level.minesoundactivatealarm );

            playsoundatpos( ( 0.0, 0.0, 0.0 ), level.minesoundactivatealarm );
        }

        wait 4;
        var_1 += 1;

        if ( var_1 > 2 )
            return;
    }
}

play_mine_open_anim()
{
    wait 2.2;
    thread maps\mp\mp_kremlin_fx::snow_puff_fx();

    if ( isdefined( self.animationactivate ) )
    {
        var_0 = 2.94;
        self scriptmodelplayanim( self.animationactivate );
        wait(var_0);
    }

    if ( level.nextgen )
        self.minecollision thread minecollisionmoveup();

    if ( isdefined( self.animationidleactive ) )
        self scriptmodelplayanim( self.animationidleactive );

    self notify( "mine_opened" );
}

play_mine_close_anim()
{
    if ( isdefined( self.empdisable ) && self.empdisable == 1 )
        self waittill( "emp_Disable_Complete" );

    if ( isdefined( self.animationdeactivate ) )
    {
        var_0 = 5.03;
        self scriptmodelplayanim( self.animationdeactivate );
        wait(var_0);
    }

    if ( level.nextgen )
        self.minecollision thread minecollisionmovedown();

    if ( isdefined( self.animationidleinactive ) )
        self scriptmodelplayanim( self.animationidleinactive );
}

minecollisionmoveup()
{
    self moveto( self.origin + ( 0.0, 0.0, 30.0 ), 0.5 );
}

minecollisionmovedown()
{
    self moveto( self.origin + ( 0.0, 0.0, -30.0 ), 0.5 );
}

play_mine_fx()
{
    level endon( "game_ended" );
    self waittill( "mine_opened" );
    var_0 = 1;
    self.mine_fx_on = 1;
    playfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );

    if ( level.nextgen )
    {
        var_1 = _func_2DF( common_scripts\utility::getfx( "mine_antenna_light_mp" ), self, "tag_fx", var_0, 0 );
        mine_fx_wait_for_end( var_1 );

        if ( isdefined( self.mine_fx_on ) && self.mine_fx_on == 1 )
        {
            killfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );

            if ( isdefined( var_1 ) )
                var_1 delete();

            self.mine_fx_on = 0;
            return;
        }
    }
    else
    {
        mine_fx_wait_for_end();

        if ( isdefined( self.mine_fx_on ) && self.mine_fx_on == 1 )
        {
            killfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );
            self.mine_fx_on = 0;
        }
    }
}

mine_fx_wait_for_end( var_0 )
{
    level endon( "minefield_complete" );
    self endon( "mine_deactivate" );

    if ( isdefined( level.mineeventcomplete ) && level.mineeventcomplete == 1 )
        return;

    for (;;)
    {
        if ( !isdefined( self.empdisable ) || self.empdisable == 0 )
            self waittill( "mine_emp" );

        if ( isdefined( var_0 ) )
            var_0 hide();

        killfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );
        self.mine_fx_on = 0;
        self waittill( "emp_disable_almost_complete" );

        if ( isdefined( var_0 ) )
            var_0 show();

        playfxontag( common_scripts\utility::getfx( "krem_mine_laser_origin_main" ), self, "tag_origin" );
        self.mine_fx_on = 1;
        common_scripts\utility::waittill_any( "emp_Disable_Complete", "mine_emp" );
    }
}

disconnectnodesslowly()
{
    var_0 = getnodearray( "minefield_node", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] _meth_8059();

        if ( var_1 % 50 == 0 )
            waitframe();
    }

    waitframe();
    var_2 = getnodearray( "minefield_node", "script_noteworthy" );

    for ( var_1 = 0; var_1 < var_2.size; var_1++ )
    {
        var_2[var_1] _meth_8059();

        if ( var_1 % 50 == 0 )
            waitframe();
    }
}

reconnectnodesslowly()
{
    var_0 = getnodearray( "minefield_node", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] _meth_805A();

        if ( var_1 % 50 == 0 )
            waitframe();
    }

    waitframe();
    var_2 = getnodearray( "minefield_node", "script_noteworthy" );

    for ( var_1 = 0; var_1 < var_2.size; var_1++ )
    {
        var_2[var_1] _meth_805A();

        if ( var_1 % 50 == 0 )
            waitframe();
    }
}

setupsupportdropvolumes( var_0 )
{
    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_0;

    while ( !isdefined( level.goliath_bad_landing_volumes ) )
        waitframe();

    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_0;
}

clearsetupsupportdropvolumes( var_0 )
{
    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    level.orbital_util_covered_volumes = common_scripts\utility::array_remove( level.orbital_util_covered_volumes, var_0 );

    while ( !isdefined( level.goliath_bad_landing_volumes ) )
        waitframe();

    level.goliath_bad_landing_volumes = common_scripts\utility::array_remove( level.goliath_bad_landing_volumes, var_0 );
}

resetuplinkballoutofbounds()
{
    level endon( "game_ended" );

    if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread _id_A200();
    }
}

_id_A200()
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
        if ( _id_5168() )
        {
            thread maps\mp\gametypes\_gameobjects::returnhome();
            return;
        }

        wait 0.05;
    }
}

_id_5168()
{
    var_0 = getentarray( "object_out_of_bounds", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_0[var_1] ) )
            continue;

        return 1;
    }

    return 0;
}

scriptpatchclip()
{
    thread northgallerybigwindow();
    thread atriumsidewallstanding();
    thread westcourtyardvehiclebounds();
    thread bridgeledgewestside();
    thread atriumgrapplegap();
    thread southeasttreeledge();
    thread northwestgrappleintowall();
    thread northwestledgeoutsidetower();
    thread breachhovertowallstand();
}

breachhovertowallstand()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 2016.0, -862.0, 769.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 = 865;

    for ( var_1 = 0; var_1 < 11; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 1984, -830, var_0 ), ( 0.0, 0.0, 0.0 ) );
        var_0 += 128;
    }
}

northwestledgeoutsidetower()
{
    var_0 = 555.5;

    for ( var_1 = 0; var_1 < 12; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2099, 345, var_0 ), ( 0.0, 0.0, 0.0 ) );
        var_0 += 128;
    }
}

northgallerybigwindow()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1572.0, 1061.0, 736.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1572.0, 1273.0, 736.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1572.0, 1110.0, 728.0 ), ( 0.0, 0.0, -25.9002 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1572.0, 1224.0, 728.0 ), ( 180.0, 0.0, -25.9002 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1572.0, 1167.0, 775.0 ), ( 0.0, 0.0, 0.0 ) );
}

atriumsidewallstanding()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258.0, -374.0, 429.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258.0, -374.0, 685.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258.0, -374.0, 941.0 ), ( 0.0, 270.0, 0.0 ) );
}

westcourtyardvehiclebounds()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( -44.0, 1440.0, 188.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 210.0, 1409.0, 188.0 ), ( 0.0, 256.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 458.0, 1347.0, 188.0 ), ( 0.0, 256.0, 0.0 ) );
}

bridgeledgewestside()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -364.5, 215.0, 209.0 ), ( 5.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -620.5, 217.0, 186.0 ), ( 5.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 236.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 169.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 105.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 41.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -23.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -87.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -151.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -215.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -279.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -343.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -407.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -471.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -535.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -599.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -663.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -727.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -791.0, 208.0, 303.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 105.0, 208.0, 357.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 41.0, 208.0, 352.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -23.0, 208.0, 347.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -87.0, 208.0, 342.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -151.0, 208.0, 336.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -215.0, 208.0, 329.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -279.0, 208.0, 321.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -343.0, 208.0, 315.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -407.0, 208.0, 313.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -471.0, 208.0, 306.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -535.0, 208.0, 298.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -599.0, 208.0, 295.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -663.0, 208.0, 288.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -727.0, 208.0, 282.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -791.0, 208.0, 277.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 256.0, 212.0, 236.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 512.0, 212.0, 236.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 262.344, 212.0, 280.126 ), ( 0.0, 270.0, 5.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 517.156, 212.0, 302.374 ), ( 0.0, 270.0, 5.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 158.0, 212.0, 402.0 ), ( 0.0, 270.0, 5.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 168.5, 212.0, 403.0 ), ( 0.0, 270.0, 5.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -160.0, 209.0, 288.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -144.0, 199.0, 333.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -176.0, 199.0, 333.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -208.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -240.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -272.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -304.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -336.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -368.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -400.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -432.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -464.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -496.0, 199.5, 269.55 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -528.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -560.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -592.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -624.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -656.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -688.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -720.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -752.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -784.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -816.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -848.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -880.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -912.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -944.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -976.0, 199.5, 269.5 ), ( 8.0, 270.0, 0.0 ) );
}

atriumgrapplegap()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1264.0, 260.0, 801.0 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1264.0, 4.0, 801.0 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1264.0, -252.0, 801.0 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1384.0, 260.0, 921.0 ), ( 360.0, 180.0, -180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1384.0, 4.0, 921.0 ), ( 360.0, 180.0, -180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1384.0, -252.0, 921.0 ), ( 360.0, 180.0, -180.0 ) );
}

southeasttreeledge()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 160.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 288.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 416.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 544.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 672.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 800.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 928.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 1056.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 1184.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 1312.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -827.5, -514.0, 1440.0 ), ( 0.0, 324.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 160.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 288.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 416.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 544.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 672.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 800.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 928.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 1056.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 1184.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 1312.0 ), ( 0.0, 290.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -896.0, -566.5, 1440.0 ), ( 0.0, 290.9, 0.0 ) );
}

northwestgrappleintowall()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1698.0, 1823.0, 928.0 ), ( 0.0, 350.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1682.0, 1823.0, 928.0 ), ( 0.0, 350.3, 0.0 ) );
}
