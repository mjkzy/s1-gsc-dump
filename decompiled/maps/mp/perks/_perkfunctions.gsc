// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setcrouchmovement()
{
    thread crouchstatelistener();
    crouchmovementsetspeed();
}

crouchstatelistener()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unsetCrouchMovement" );
    self _meth_82DD( "adjustedStance", "+stance" );
    self _meth_82DD( "adjustedStance", "+goStand" );

    for (;;)
    {
        common_scripts\utility::waittill_any( "adjustedStance", "sprint_begin", "weapon_change" );
        wait 0.5;
        crouchmovementsetspeed();
    }
}

crouchmovementsetspeed()
{
    self.stancecrouchmovement = self _meth_817C();
    var_0 = 0;

    if ( isdefined( self.adrenaline_speed_scalar ) )
        var_0 = self.adrenaline_speed_scalar;
    else if ( self.stancecrouchmovement == "crouch" )
        var_0 = self.crouch_speed_scalar;
    else if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        var_0 = maps\mp\_utility::lightweightscalar();

    self.movespeedscaler = var_0;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

unsetcrouchmovement()
{
    self notify( "unsetCrouchMovement" );
    var_0 = 1;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        var_0 = maps\mp\_utility::lightweightscalar();

    self.movespeedscaler = var_0;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

setpersonaluav()
{
    var_0 = spawn( "script_model", self.origin );
    var_0.team = self.team;
    var_0 makeportableradar( self );
    self.personalradar = var_0;
    thread radarmover( var_0 );
}

radarmover( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "personal_uav_remove" );
    self endon( "personal_uav_removed" );

    for (;;)
    {
        var_0 _meth_82AE( self.origin, 0.05 );
        wait 0.05;
    }
}

unsetpersonaluav()
{
    if ( isdefined( self.personalradar ) )
    {
        self notify( "personal_uav_removed" );
        level maps\mp\gametypes\_portable_radar::deleteportableradar( self.personalradar );
        self.personalradar = undefined;
    }
}

setoverkillpro()
{

}

unsetoverkillpro()
{

}

setempimmune()
{

}

unsetempimmune()
{

}

setautospot()
{
    autospotadswatcher();
    autospotdeathwatcher();
}

autospotdeathwatcher()
{
    self waittill( "death" );
    self endon( "disconnect" );
    self endon( "endAutoSpotAdsWatcher" );
    level endon( "game_ended" );
    self autospotoverlayoff();
}

unsetautospot()
{
    self notify( "endAutoSpotAdsWatcher" );
    self autospotoverlayoff();
}

autospotadswatcher()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "endAutoSpotAdsWatcher" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        wait 0.05;

        if ( self _meth_8342() )
        {
            self autospotoverlayoff();
            continue;
        }

        var_1 = self _meth_8340();

        if ( var_1 < 1 && var_0 )
        {
            var_0 = 0;
            self autospotoverlayoff();
        }

        if ( var_1 < 1 && !var_0 )
            continue;

        if ( var_1 == 1 && !var_0 )
        {
            var_0 = 1;
            self autospotoverlayon();
        }
    }
}

setregenspeed()
{

}

unsetregenspeed()
{

}

setsharpfocus()
{
    self _meth_8309( 0.5 );
}

unsetsharpfocus()
{
    self _meth_8309( 1 );
}

setdoubleload()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "endDoubleLoad" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "reload" );
        var_0 = self _meth_82D1( "primary" );

        foreach ( var_2 in var_0 )
        {
            var_3 = self _meth_82F8( var_2 );
            var_4 = weaponclipsize( var_2 );
            var_5 = var_4 - var_3;
            var_6 = self _meth_82F9( var_2 );

            if ( var_3 != var_4 && var_6 > 0 )
            {
                if ( var_3 + var_6 >= var_4 )
                {
                    self _meth_82F6( var_2, var_4 );
                    self _meth_82F7( var_2, var_6 - var_5 );
                    continue;
                }

                self _meth_82F6( var_2, var_3 + var_6 );

                if ( var_6 - var_5 > 0 )
                {
                    self _meth_82F7( var_2, var_6 - var_5 );
                    continue;
                }

                self _meth_82F7( var_2, 0 );
            }
        }
    }
}

unsetdoubleload()
{
    self notify( "endDoubleLoad" );
}

setmarksman( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( var_0 ) )
        var_0 = 10;
    else
        var_0 = int( var_0 ) * 2;

    maps\mp\_utility::setrecoilscale( var_0 );
    self.recoilscale = var_0;
}

unsetmarksman()
{
    maps\mp\_utility::setrecoilscale( 0 );
    self.recoilscale = 0;
}

setstunresistance( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( var_0 ) )
        self.stunscaler = 0.5;
    else
        self.stunscaler = int( var_0 ) / 10;
}

unsetstunresistance()
{
    self.stunscaler = 1;
}

setsteadyaimpro()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self _meth_8307( 0.5 );
}

unsetsteadyaimpro()
{
    self notify( "end_SteadyAimPro" );
    self _meth_8307( 1.0 );
}

blastshieldusetracker( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "end_perkUseTracker" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "empty_offhand" );

        if ( !common_scripts\utility::isoffhandweaponenabled() )
            continue;

        self [[ var_1 ]]( maps\mp\_utility::_hasperk( "_specialty_blastshield" ) );
    }
}

perkusedeathtracker()
{
    self endon( "disconnect" );
    self waittill( "death" );
    self._useperkenabled = undefined;
}

setrearview()
{

}

unsetrearview()
{
    self notify( "end_perkUseTracker" );
}

setendgame()
{
    if ( isdefined( self.endgame ) )
        return;

    self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue( "player", "maxhealth" ) * 4;
    self.health = self.maxhealth;
    self.endgame = 1;
    self.attackertable[0] = "";
    self _meth_82D4( "end_game", 5 );
    thread endgamedeath( 7 );
    self.hasdonecombat = 1;
}

unsetendgame()
{
    self notify( "stopEndGame" );
    self.endgame = undefined;
    maps\mp\_utility::revertvisionsetforplayer();

    if ( !isdefined( self.endgametimer ) )
        return;

    self.endgametimer maps\mp\gametypes\_hud_util::destroyelem();
    self.endgameicon maps\mp\gametypes\_hud_util::destroyelem();
}

endgamedeath( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self endon( "stopEndGame" );
    wait(var_0 + 1);
    maps\mp\_utility::_suicide();
}

stancestatelistener()
{
    self endon( "death" );
    self endon( "disconnect" );
    self _meth_82DD( "adjustedStance", "+stance" );

    for (;;)
    {
        self waittill( "adjustedStance" );

        if ( self.movespeedscaler != 0 )
            continue;

        unsetsiege();
    }
}

jumpstatelistener()
{
    self endon( "death" );
    self endon( "disconnect" );
    self _meth_82DD( "jumped", "+goStand" );

    for (;;)
    {
        self waittill( "jumped" );

        if ( self.movespeedscaler != 0 )
            continue;

        unsetsiege();
    }
}

unsetsiege()
{
    self.movespeedscaler = level.baseplayermovescale;
    self _meth_8306();
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    self playerrecoilscaleoff();
    self _meth_8301( 1 );
}

setsaboteur()
{
    self.objectivescaler = 2;
}

unsetsaboteur()
{
    self.objectivescaler = 1;
}

setlightweight( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 10;

    self.movespeedscaler = maps\mp\_utility::lightweightscalar( var_0 );
    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

unsetlightweight()
{
    self.movespeedscaler = level.baseplayermovescale;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

setblackbox()
{
    self.killstreakscaler = 1.5;
}

unsetblackbox()
{
    self.killstreakscaler = 1;
}

setsteelnerves()
{
    maps\mp\_utility::giveperk( "specialty_bulletaccuracy", 1 );
    maps\mp\_utility::giveperk( "specialty_holdbreath", 0 );
}

unsetsteelnerves()
{
    maps\mp\_utility::_unsetperk( "specialty_bulletaccuracy" );
    maps\mp\_utility::_unsetperk( "specialty_holdbreath" );
}

setdelaymine()
{

}

unsetdelaymine()
{

}

setlocaljammer()
{
    if ( !maps\mp\_utility::isemped() )
        self _meth_8212( 0 );
}

unsetlocaljammer()
{
    self _meth_8212( 1 );
}

setthermal()
{
    self thermalvisionon();
}

unsetthermal()
{
    self thermalvisionoff();
}

setonemanarmy()
{
    thread onemanarmyweaponchangetracker();
}

unsetonemanarmy()
{
    self notify( "stop_oneManArmyTracker" );
}

onemanarmyweaponchangetracker()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "stop_oneManArmyTracker" );

    for (;;)
    {
        self waittill( "weapon_change", var_0 );

        if ( var_0 != "onemanarmy_mp" )
            continue;

        thread selectonemanarmyclass();
    }
}

isonemanarmymenu( var_0 )
{
    if ( var_0 == game["menu_onemanarmy"] )
        return 1;

    if ( isdefined( game["menu_onemanarmy_defaults_splitscreen"] ) && var_0 == game["menu_onemanarmy_defaults_splitscreen"] )
        return 1;

    if ( isdefined( game["menu_onemanarmy_custom_splitscreen"] ) && var_0 == game["menu_onemanarmy_custom_splitscreen"] )
        return 1;

    return 0;
}

selectonemanarmyclass()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    common_scripts\utility::_disableweaponswitch();
    common_scripts\utility::_disableoffhandweapons();
    common_scripts\utility::_disableusability();
    self _meth_8323( game["menu_onemanarmy"] );
    thread closeomamenuondeath();
    self waittill( "menuresponse", var_0, var_1 );
    common_scripts\utility::_enableweaponswitch();
    common_scripts\utility::_enableoffhandweapons();
    common_scripts\utility::_enableusability();

    if ( var_1 == "back" || !isonemanarmymenu( var_0 ) || maps\mp\_utility::isusingremote() )
    {
        if ( self _meth_8311() == "onemanarmy_mp" )
        {
            common_scripts\utility::_disableweaponswitch();
            common_scripts\utility::_disableoffhandweapons();
            common_scripts\utility::_disableusability();
            self _meth_8315( common_scripts\utility::getlastweapon() );
            self waittill( "weapon_change" );
            common_scripts\utility::_enableweaponswitch();
            common_scripts\utility::_enableoffhandweapons();
            common_scripts\utility::_enableusability();
        }

        return;
    }

    thread giveonemanarmyclass( var_1 );
}

closeomamenuondeath()
{
    self endon( "menuresponse" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    common_scripts\utility::_enableweaponswitch();
    common_scripts\utility::_enableoffhandweapons();
    common_scripts\utility::_enableusability();
    self _meth_8325();
}

giveonemanarmyclass( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( maps\mp\_utility::_hasperk( "specialty_omaquickchange" ) )
    {
        var_1 = 3.0;
        self playlocalsound( "foly_onemanarmy_bag3_plr" );
        self playsoundtoteam( "foly_onemanarmy_bag3_npc", "allies", self );
        self playsoundtoteam( "foly_onemanarmy_bag3_npc", "axis", self );
    }
    else
    {
        var_1 = 6.0;
        self playlocalsound( "foly_onemanarmy_bag6_plr" );
        self playsoundtoteam( "foly_onemanarmy_bag6_npc", "allies", self );
        self playsoundtoteam( "foly_onemanarmy_bag6_npc", "axis", self );
    }

    thread omausebar( var_1 );
    common_scripts\utility::_disableweapon();
    common_scripts\utility::_disableoffhandweapons();
    common_scripts\utility::_disableusability();
    wait(var_1);
    common_scripts\utility::_enableweapon();
    common_scripts\utility::_enableoffhandweapons();
    common_scripts\utility::_enableusability();
    self.omaclasschanged = 1;
    maps\mp\gametypes\_class::giveandapplyloadout( self.pers["team"], var_0, 0 );

    if ( isdefined( self.carryflag ) )
        self attach( self.carryflag, "J_spine4", 1 );

    self notify( "changed_kit" );
    level notify( "changed_kit" );
}

omausebar( var_0 )
{
    self endon( "disconnect" );
    var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbar( 0, -25 );
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext( 0, -25 );
    var_2 settext( &"MPUI_CHANGING_KIT" );
    var_1 maps\mp\gametypes\_hud_util::updatebar( 0, 1 / var_0 );

    for ( var_3 = 0; var_3 < var_0 && isalive( self ) && !level.gameended; var_3 += 0.05 )
        wait 0.05;

    var_1 maps\mp\gametypes\_hud_util::destroyelem();
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
}

setblastshield()
{
    self _meth_821B( "primaryoffhand", "specialty_s1_temp" );
}

unsetblastshield()
{
    self _meth_821B( "primaryoffhand", "none" );
}

setfreefall()
{

}

unsetfreefall()
{

}

settacticalinsertion()
{
    maps\mp\_utility::_giveweapon( "s1_tactical_insertion_device_mp", 0 );
    self _meth_8331( "s1_tactical_insertion_device_mp" );
    thread monitortiuse();
}

clearprevioustispawnpoint()
{
    self notify( "clearPreviousTISpawnpointStarted" );
    self endon( "clearPreviousTISpawnpointStarted" );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );

    if ( isdefined( self.setspawnpoint ) )
        deleteti( self.setspawnpoint );
}

updatetispawnposition()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );

    while ( maps\mp\_utility::isreallyalive( self ) )
    {
        if ( isvalidtispawnposition() )
            self.tispawnposition = self.origin;

        wait 0.05;
    }
}

isvalidtispawnposition()
{
    if ( precachestatusicon( self.origin ) && self _meth_8341() )
        return 1;
    else
        return 0;
}

monitortiuse()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    level endon( "game_ended" );
    thread clearprevioustispawnpoint();
    thread updatetispawnposition();
    thread monitorthirdpersonmodel();

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );

        if ( var_1 != "s1_tactical_insertion_device_mp" )
            continue;

        if ( isdefined( self.setspawnpoint ) )
            deleteti( self.setspawnpoint );

        if ( !isdefined( self.tispawnposition ) )
            continue;

        if ( maps\mp\_utility::touchingbadtrigger() )
            continue;

        var_2 = playerphysicstrace( self.tispawnposition + ( 0, 0, 16 ), self.tispawnposition - ( 0, 0, 2048 ) ) + ( 0, 0, 1 );
        var_3 = spawn( "script_model", var_2 );
        var_3.angles = self.angles;
        var_3.team = self.team;
        var_3.owner = self;
        var_3.enemytrigger = spawn( "script_origin", var_2 );
        var_3 thread glowsticksetupandwaitfordeath( self );
        var_3.playerspawnpos = self.tispawnposition;
        var_3 _meth_8383( self );
        var_3 common_scripts\utility::make_entity_sentient_mp( self.team, 1 );
        var_3 _meth_8075( "tac_insert_spark_lp" );
        self.setspawnpoint = var_3;
        return;
    }
}

monitorthirdpersonmodel()
{
    self notify( "third_person_ti" );
    self endon( "third_person_ti" );

    for (;;)
    {
        if ( isdefined( self.attachmodelti ) )
        {
            self detach( "npc_tactical_insertion_device", "tag_inhand" );
            self.attachmodelti = undefined;
        }

        self waittillmatch( "grenade_pullback", "s1_tactical_insertion_device_mp" );
        self attach( "npc_tactical_insertion_device", "tag_inhand", 1 );
        self.attachmodelti = "npc_tactical_insertion_device";
        maps\mp\_utility::waitfortimeornotify( 3, "death" );
        self detach( "npc_tactical_insertion_device", "tag_inhand" );
        self.attachmodelti = undefined;
    }
}

glowsticksetupandwaitfordeath( var_0 )
{
    self _meth_80B1( level.spawnglowmodel["enemy"] );
    thread maps\mp\gametypes\_damage::setentitydamagecallback( 100, undefined, ::ondeathti, undefined, 0 );
    thread glowstickenemyuselistener( var_0 );
    thread glowstickuselistener( var_0 );
    thread glowstickteamupdater( self.team, level.spawnglow["enemy"], var_0 );
    var_1 = spawn( "script_model", self.origin + ( 0, 0, 0 ) );
    var_1.angles = self.angles;
    var_1 _meth_80B1( level.spawnglowmodel["friendly"] );
    var_1 setcontents( 0 );
    var_1 thread glowstickteamupdater( self.team, level.spawnglow["friendly"], var_0 );
    var_1 _meth_8075( "tac_insert_spark_lp" );
    self waittill( "death" );
    var_1 _meth_80AB();
    var_1 delete();
}

glowstickteamupdater( var_0, var_1, var_2 )
{
    self endon( "death" );
    wait 0.05;
    var_3 = self gettagangles( "tag_fire_fx" );
    var_4 = spawnfx( var_1, self gettagorigin( "tag_fire_fx" ), anglestoforward( var_3 ), anglestoup( var_3 ) );
    triggerfx( var_4 );
    thread perk_deleteondeath( var_4 );

    for (;;)
    {
        self hide();
        var_4 hide();

        foreach ( var_6 in level.players )
        {
            if ( var_6.team == var_0 && level.teambased && var_1 == level.spawnglow["friendly"] )
            {
                self showtoplayer( var_6 );
                var_4 showtoplayer( var_6 );
                continue;
            }

            if ( var_6.team != var_0 && level.teambased && var_1 == level.spawnglow["enemy"] )
            {
                self showtoplayer( var_6 );
                var_4 showtoplayer( var_6 );
                continue;
            }

            if ( !level.teambased && var_6 == var_2 && var_1 == level.spawnglow["friendly"] )
            {
                self showtoplayer( var_6 );
                var_4 showtoplayer( var_6 );
                continue;
            }

            if ( !level.teambased && var_6 != var_2 && var_1 == level.spawnglow["enemy"] )
            {
                self showtoplayer( var_6 );
                var_4 showtoplayer( var_6 );
            }
        }

        level common_scripts\utility::waittill_either( "joined_team", "player_spawned" );
    }
}

perk_deleteondeath( var_0 )
{
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

ondeathti( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.owner ) && var_0 != self.owner )
    {
        var_0 notify( "destroyed_explosive" );
        var_0 thread maps\mp\gametypes\_missions::processchallenge( "ch_darkbringer" );
    }

    playfx( level.spawnfire, self.origin );
    self.owner thread maps\mp\_utility::leaderdialogonplayer( "ti_destroyed", undefined, undefined, self.origin );
    var_0 thread deleteti( self );
}

glowstickuselistener( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    self _meth_80DA( "HINT_NOICON" );
    self _meth_80DB( &"MP_PATCH_PICKUP_TI" );
    thread updateenemyuse( var_0 );

    for (;;)
    {
        self waittill( "trigger", var_1 );
        var_1 playsound( "tac_insert_pickup_plr" );
        var_1 thread settacticalinsertion();
        var_1 thread deleteti( self );
    }
}

updateenemyuse( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        maps\mp\_utility::setselfusable( var_0 );
        level common_scripts\utility::waittill_either( "joined_team", "player_spawned" );
    }
}

deleteti( var_0 )
{
    if ( isdefined( var_0.enemytrigger ) )
        var_0.enemytrigger delete();

    var_0 _meth_80AB();
    var_0 delete();
}

glowstickenemyuselistener( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    self.enemytrigger _meth_80DA( "HINT_NOICON" );
    self.enemytrigger _meth_80DB( &"MP_PATCH_DESTROY_TI" );
    self.enemytrigger maps\mp\_utility::makeenemyusable( var_0 );

    for (;;)
    {
        self.enemytrigger waittill( "trigger", var_1 );
        thread ondeathti( var_1 );
    }
}

setpainted( var_0 )
{
    if ( isplayer( self ) )
    {
        if ( isdefined( var_0.specialty_paint_time ) && !maps\mp\_utility::_hasperk( "specialty_coldblooded" ) )
        {
            self.painted = 1;
            self _meth_82A6( "specialty_radararrow", 1, 0 );
            thread unsetpainted( var_0.specialty_paint_time );
            thread watchpainteddeath();
        }
    }
}

watchpainteddeath()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "unsetPainted" );
    self waittill( "death" );
    self.painted = 0;
}

unsetpainted( var_0 )
{
    self notify( "painted_again" );
    self endon( "painted_again" );
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self.painted = 0;
    self _meth_82A9( "specialty_radararrow", 1 );
    self notify( "unsetPainted" );
}

ispainted()
{
    return isdefined( self.painted ) && self.painted;
}

setrefillgrenades()
{
    if ( isdefined( self.primarygrenade ) )
        self _meth_8332( self.primarygrenade );

    if ( isdefined( self.secondarygrenade ) )
        self _meth_8332( self.secondarygrenade );
}

setfinalstand()
{
    maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );
}

unsetfinalstand()
{
    maps\mp\_utility::_unsetperk( "specialty_pistoldeath" );
}

setcarepackage()
{
    thread maps\mp\killstreaks\_killstreaks::givekillstreak( "airdrop_assault", 0, 0, self );
}

unsetcarepackage()
{

}

setuav()
{
    thread maps\mp\killstreaks\_killstreaks::givekillstreak( "uav", 0, 0, self );
}

unsetuav()
{

}

setstoppingpower()
{
    maps\mp\_utility::giveperk( "specialty_bulletdamage", 0 );
    thread watchstoppingpowerkill();
}

watchstoppingpowerkill()
{
    self notify( "watchStoppingPowerKill" );
    self endon( "watchStoppingPowerKill" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "killed_enemy" );
    unsetstoppingpower();
}

unsetstoppingpower()
{
    maps\mp\_utility::_unsetperk( "specialty_bulletdamage" );
    self notify( "watchStoppingPowerKill" );
}

setjuiced( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "faux_spawn" );
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    level endon( "end_game" );
    self.isjuiced = 1;

    if ( !isdefined( var_0 ) )
        var_0 = 1.25;

    self.movespeedscaler = var_0;
    maps\mp\gametypes\_weapons::updatemovespeedscale();

    if ( level.splitscreen )
    {
        var_3 = 56;
        var_4 = 21;
    }
    else
    {
        var_3 = 80;
        var_4 = 32;
    }

    if ( !isdefined( var_1 ) )
        var_1 = 7;

    if ( !isdefined( var_2 ) || var_2 == 1 )
    {
        self.juicedtimer = maps\mp\gametypes\_hud_util::createtimer( "hudsmall", 1.0 );
        self.juicedtimer maps\mp\gametypes\_hud_util::setpoint( "CENTER", "CENTER", 0, var_3 );
        self.juicedtimer _meth_80CF( var_1 );
        self.juicedtimer.color = ( 0.8, 0.8, 0 );
        self.juicedtimer.archived = 0;
        self.juicedtimer.foreground = 1;
        self.juicedicon = maps\mp\gametypes\_hud_util::createicon( level.specialty_juiced_icon, var_4, var_4 );
        self.juicedicon.alpha = 0;
        self.juicedicon maps\mp\gametypes\_hud_util::setparent( self.juicedtimer );
        self.juicedicon maps\mp\gametypes\_hud_util::setpoint( "BOTTOM", "TOP" );
        self.juicedicon.archived = 1;
        self.juicedicon.sort = 1;
        self.juicedicon.foreground = 1;
        self.juicedicon fadeovertime( 1.0 );
        self.juicedicon.alpha = 0.85;
    }

    thread unsetjuicedondeath();
    thread unsetjuicedonride();
    wait(var_1 - 2);

    if ( isdefined( self.juicedicon ) )
    {
        self.juicedicon fadeovertime( 2.0 );
        self.juicedicon.alpha = 0.0;
    }

    if ( isdefined( self.juicedtimer ) )
    {
        self.juicedtimer fadeovertime( 2.0 );
        self.juicedtimer.alpha = 0.0;
    }

    wait 2;
    unsetjuiced();
}

unsetjuiced( var_0 )
{
    if ( !isdefined( var_0 ) )
    {
        if ( maps\mp\_utility::isjuggernaut() )
        {
            if ( isdefined( self.juggmovespeedscaler ) )
                self.movespeedscaler = self.juggmovespeedscaler;
            else
                self.movespeedscaler = 0.7;
        }
        else
        {
            self.movespeedscaler = level.baseplayermovescale;

            if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
                self.movespeedscaler = maps\mp\_utility::lightweightscalar();
        }

        maps\mp\gametypes\_weapons::updatemovespeedscale();
    }

    if ( isdefined( self.juicedicon ) )
        self.juicedicon destroy();

    if ( isdefined( self.juicedtimer ) )
        self.juicedtimer destroy();

    self.isjuiced = undefined;
    self notify( "unset_juiced" );
}

unsetjuicedonride()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );

    for (;;)
    {
        wait 0.05;

        if ( maps\mp\_utility::isusingremote() )
        {
            thread unsetjuiced();
            break;
        }
    }
}

unsetjuicedondeath()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    common_scripts\utility::waittill_any( "death", "faux_spawn" );
    thread unsetjuiced( 1 );
}

setlightarmorhp( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        self.lightarmorhp = var_0;

        if ( isplayer( self ) && isdefined( self.maxlightarmorhp ) && self.maxlightarmorhp > 0 )
        {
            var_1 = clamp( self.lightarmorhp / self.maxlightarmorhp, 0, 1 );
            self _meth_82FB( "ui_light_armor_percent", var_1 );
        }
    }
    else
    {
        self.lightarmorhp = undefined;
        self.maxlightarmorhp = undefined;
        self _meth_82FB( "ui_light_armor_percent", 0 );
    }
}

setlightarmor( var_0 )
{
    self notify( "give_light_armor" );

    if ( isdefined( self.lightarmorhp ) )
        unsetlightarmor();

    thread removelightarmorondeath();
    thread removelightarmoronmatchend();

    if ( isdefined( var_0 ) )
        self.maxlightarmorhp = var_0;
    else
        self.maxlightarmorhp = 150;

    setlightarmorhp( self.maxlightarmorhp );
}

removelightarmorondeath()
{
    self endon( "disconnect" );
    self endon( "give_light_armor" );
    self endon( "remove_light_armor" );
    self waittill( "death" );
    unsetlightarmor();
}

unsetlightarmor()
{
    setlightarmorhp( undefined );
    self notify( "remove_light_armor" );
}

removelightarmoronmatchend()
{
    self endon( "disconnect" );
    self endon( "remove_light_armor" );
    level common_scripts\utility::waittill_any( "round_end_finished", "game_ended" );
    thread unsetlightarmor();
}

haslightarmor()
{
    return isdefined( self.lightarmorhp ) && self.lightarmorhp > 0;
}
