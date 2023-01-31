// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

manhuntintroscreen()
{
    level.player _meth_831D();
    var_0 = newclienthudelem( level.player );
    var_0 _meth_80CC( "black", 1280, 720 );
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    var_0.alpha = 1;
    var_0.foreground = 0;
    common_scripts\utility::flag_set( "FlagSafeHouseIntro" );
    wait 1.0;
    common_scripts\utility::flag_set( "introscreen_complete" );
    var_0 fadeovertime( 2 );
    var_0.alpha = 0;
    common_scripts\utility::flag_set( "FlagIntroScreenComplete" );
    wait 2.0;
    var_0 destroy();
}

debugplayerteleport( var_0 )
{
    var_1 = "PlayerTeleport" + var_0;
    var_2 = getent( var_1, "targetname" );
    var_3 = "PlayerStart" + var_0;
    var_4 = common_scripts\utility::getstruct( var_3, "targetname" );
    maps\_utility::trigger_wait_targetname( var_1 );
    maps\_utility::teleport_player( var_4 );
    iprintln( "Teleporting player to " + var_0 );
}

settargetandshader( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;

    if ( !_func_0A3( var_0 ) )
        var_4 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 48;

    if ( var_4 )
        _func_098( var_0, ( 0, 0, var_3 ) );

    if ( isdefined( var_1 ) )
        _func_09C( var_0, var_1 );

    if ( isdefined( var_2 ) )
        _func_09D( var_0, var_2 );

    if ( var_4 )
        _func_099( var_0 );
}

killfloodspawnersonflag( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_wait_either( var_1, var_2 );
    else
        common_scripts\utility::flag_wait( var_1 );

    maps\_spawner::killspawner( var_0 );
}

waittillneargoal( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 50;

    while ( distance( self.origin, var_0.origin ) > var_1 )
        wait 0.05;

    self notify( "goal" );
}

getinchesinfeet( var_0 )
{
    return var_0 * 12;
}

checkvehicleturretuserstatus( var_0, var_1 )
{
    var_0 endon( "death" );
    self waittill( "death" );
    wait(randomfloatrange( 1.0, 5.0 ));
    thread _findnewvehicleturretuser( var_0, var_1 );
}

_findnewvehicleturretuser( var_0, var_1 )
{
    var_2 = maps\_utility::get_living_ai_array( var_1, "script_noteworthy" );

    if ( var_2.size > 0 )
    {
        var_3 = common_scripts\utility::random( var_2 );
        var_3 _assignnewvehicleturretuser( var_0, var_1 );
    }
}

_assignnewvehicleturretuser( var_0, var_1 )
{
    self endon( "death" );
    self endon( "dying" );
    var_0 endon( "death" );
    wait(randomfloatrange( 1.0, 5.0 ));
    self.script_startingposition = 6;
    var_0 maps\_utility::guy_enter_vehicle( self );
    maps\_hms_utility::printlnscreenandconsole( var_1 + " is now moving to the gunner seat in Turret Vehicle" );
    thread checkvehicleturretuserstatus( var_0, var_1 );
    thread _vehicleturretreenable( var_0 );
}

_vehicleturretreenable( var_0 )
{
    var_0 endon( "death" );

    foreach ( var_2 in var_0.mgturret )
    {
        while ( !_func_097( var_2 ) )
            wait 1;

        level notify( "TurretInUse" );
        var_2 _meth_8179();
    }
}

waittillaineargoal( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = 50;

    if ( !isdefined( var_1 ) )
        var_1 = "goal";

    self waittill( var_1 );

    if ( isdefined( self.name ) )
        maps\_hms_utility::printlnscreenandconsole( self.name + " is now " + var_1 );
}

waittillaiarrayneargoal( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "goal";

    var_2 = spawnstruct();
    var_2.threads = 0;

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4 ) )
        {
            var_4 thread common_scripts\utility::waittill_string( var_1, var_2 );
            var_2.threads++;
        }
    }

    while ( var_2.threads )
    {
        var_2 waittill( "returned" );
        var_2.threads--;
    }
}

waittillplayeristouchinganytrigger( var_0 )
{
    var_1 = spawnstruct();

    foreach ( var_3 in var_0 )
        var_3 thread common_scripts\utility::waittill_string( "trigger", var_1 );

    var_1 waittill( "returned" );
}

kill_no_react( var_0, var_1 )
{
    self.a.nodeath = 1;

    if ( isdefined( var_1 ) )
        thread kill_with_delay( var_0, var_1 );
    else
        thread kill_with_delay( var_0 );
}

kill_with_delay( var_0, var_1 )
{
    if ( !isalive( self ) )
        return;

    if ( isdefined( var_0 ) )
        wait(var_0);

    self.allowdeath = 1;
    thread maps\_utility::set_battlechatter( 0 );

    if ( isdefined( var_1 ) )
        self _meth_8052( self.origin, var_1 );
    else
        self _meth_8052();
}

clear_set_goal()
{
    self endon( "death" );
    self notify( "new_anim_reach" );
    self notify( "goal" );
    maps\_utility::unset_forcegoal();
    self.last_set_goalnode = undefined;
    self.last_set_goalpos = undefined;
    self.last_set_goalent = undefined;
    maps\_utility::unset_forcegoal();
}

setragdolldeath( var_0, var_1 )
{
    self endon( "delete" );
    self endon( "no_ragdoll" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_1 ) )
            var_1 notify( var_0 );
        else
            level notify( var_0 );
    }

    self.noragdoll = undefined;
    self.a.nodeath = 1;
    animscripts\notetracks::notetrackstartragdoll( "ragdoll" );
    self _meth_8141();
}

clearragdolldeath()
{
    self notify( "no_ragdoll" );
    self.ragdoll_immediate = undefined;
}

shootguy( var_0, var_1, var_2 )
{
    var_3 = self.baseaccuracy;
    maps\_utility::disable_dontevershoot();
    self.ignoreall = 0;
    self.baseaccuracy = 5000;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( isdefined( var_0 ) && isalive( var_0 ) )
    {
        var_0 endon( "death" );

        if ( var_2 == 1 )
            thread shootguytargetmustdie( var_0 );

        if ( !isdefined( var_1 ) )
            var_1 = 1;

        if ( var_1 == 1 )
        {
            if ( isdefined( var_0.magic_bullet_shield ) && var_0.magic_bullet_shield == 1 )
                var_0 maps\_utility::stop_magic_bullet_shield();

            var_0.maxhealth = 1;
            var_0.health = 1;
        }

        var_0 maps\_utility::set_ignoreme( 0 );
        var_0.dontattackme = undefined;
        self.favoriteenemy = var_0;

        if ( var_1 == 1 )
            var_0 waittill( "death" );
        else
            var_0 waittill( "damage" );
    }

    self.baseaccuracy = var_3;
    self.favoriteenemy = undefined;
    self.ignoreall = 1;
    maps\_utility::enable_dontevershoot();
}

shootguytargetmustdie( var_0 )
{
    while ( isalive( var_0 ) )
    {
        self endon( "death" );
        var_0 endon( "death" );
        wait 2;
        magicbullet( "iw5_sn6_sp_silencer01", self gettagorigin( "TAG_WEAPON" ), var_0 _meth_80A8() );
    }
}

disableawareness()
{
    self.ignoreall = 1;
    self.dontmelee = 1;
    self.suppressionwait_old = self.suppressionwait;
    self.suppressionwait = 0;
    maps\_utility::disable_surprise();
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_pain();
    maps\_utility::disable_danger_react();
    self.grenadeawareness = 0;
    self.ignoreme = 1;
    maps\_utility::enable_dontevershoot();
    self.disablefriendlyfirereaction = 1;
}

enableawareness()
{
    self.ignoreall = 0;
    self.dontmelee = undefined;

    if ( isdefined( self.suppressionwait_old ) )
        self.suppressionwait = self.suppressionwait_old;

    self.suppressionwait_old = undefined;
    maps\_utility::enable_surprise();
    self.ignorerandombulletdamage = 0;
    maps\_utility::enable_bulletwhizbyreaction();
    maps\_utility::enable_pain();
    self.grenadeawareness = 1;
    self.ignoreme = 0;
    maps\_utility::disable_dontevershoot();
    self.disablefriendlyfirereaction = undefined;
}

rumbleplayerlight()
{
    level.player _meth_80AD( "damage_light" );
    earthquake( 0.1, 0.2, level.player.origin, 100 );
}

rumbleplayerheavy()
{
    level.player _meth_80AD( "damage_heavy" );
    earthquake( 0.3, 0.2, level.player.origin, 100 );
}

clearstencil()
{
    if ( !isdefined( self ) )
        return;

    common_scripts\utility::waittill_any( "death", "remove_outline" );

    if ( !isdefined( self ) )
        return;

    self _meth_84ED( "enhanceable" );
}

settargetoutline()
{
    if ( isdefined( self.outlinecolor ) && self.outlinecolor == "red" )
        return;

    self _meth_83FA( 5 );
    self.outlinecolor = "yellow";
}

setalertoutline( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    self _meth_83FA( 1, var_0 );
    self.outlinecolor = "red";
}

clearalertoutline()
{
    if ( !isdefined( self ) )
        return;

    common_scripts\utility::waittill_any( "death", "remove_outline" );

    if ( !isdefined( self ) )
        return;

    self _meth_83FB();
}

initfanprops()
{
    common_scripts\utility::array_thread( getentarray( "turbine_blades", "targetname" ), ::_rotateprop, 5, 25, 1 );
    common_scripts\utility::array_thread( getentarray( "ac_fan", "targetname" ), ::_rotateprop, 720, 1000, 1 );
    common_scripts\utility::array_thread( getentarray( "ceiling_fan_blades", "targetname" ), ::_rotateprop, 15, 30, 0, 1 );
    common_scripts\utility::array_thread( getentarray( "ceiling_fan_blades", "targetname" ), ::_attachfanclip );
}

_rotateprop( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 20000;
    var_6 = randomfloatrange( var_0, var_1 );

    for (;;)
    {
        if ( var_2 == 1 )
            self _meth_82BD( ( var_6, 0, 0 ), var_5 );
        else if ( var_3 == 1 )
            self _meth_82BD( ( 0, var_6, 0 ), var_5 );

        wait 0.05;
    }
}

_attachfanclip()
{
    var_0 = getentarray( "ceiling_fan_blades_clip", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_804D( self );
}

bloodsprayexitwoundtrace( var_0, var_1, var_2, var_3 )
{
    self endon( "delete" );
    self endon( "bloodless" );

    if ( !isdefined( var_0 ) )
        var_0 = 1000;

    if ( !isdefined( var_2 ) )
        var_2 = "TAG_WEAPON_CHEST";

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( var_3 == 1 )
        self waittill( "damage", var_5, var_4 );
    else
        self waittill( "death", var_5 );

    if ( !isdefined( var_5 ) || isdefined( var_1 ) && var_1 != var_5 )
        return;

    var_6 = level.player _meth_80A8();
    var_7 = level.player getangles();
    var_8 = anglestoforward( var_7 );
    var_9 = self gettagorigin( var_2 );
    var_10 = var_9 + var_8 * var_0;
    var_11 = bullettrace( var_9, var_10, 0 );

    if ( isdefined( var_11["position"] ) )
    {
        var_12 = var_11["position"];
        playfx( common_scripts\utility::getfx( "blood_impact_splat" ), var_12 );
    }
}

aiarrayidleloop( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    foreach ( var_3 in var_0 )
        var_3 thread aiidleloop( var_1 );
}

aiidleloop( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    var_1 = "Idle" + self.script_noteworthy;
    self.idlepoint = common_scripts\utility::getstruct( var_1, "script_noteworthy" );

    if ( isdefined( self.idlepoint ) )
    {
        self.allowdeath = var_0;
        self.allowpain = var_0;
        self.idlepoint thread maps\_anim::anim_loop_solo( self, self.idlepoint.animation, "stop_loop" );
        self.idlepointreached = 1;
    }
}

aioverridemodelrandom( var_0, var_1 )
{
    var_2 = common_scripts\utility::random( var_1 );
    var_3 = common_scripts\utility::random( var_0 );
    aioverridemodel( var_3, var_2 );
}

aioverridemodel( var_0, var_1 )
{
    thread codescripts\character::setheadmodel( var_1 );
    self _meth_80B1( var_0 );
}

aiarrayoverridemodelrandom( var_0, var_1, var_2 )
{
    var_1 = common_scripts\utility::array_randomize( var_1 );
    var_2 = common_scripts\utility::array_randomize( var_2 );

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
        var_0[var_3] aioverridemodel( var_1[var_3], var_2[var_3] );
}

setdefaulthudoutlinedvars()
{
    _func_0D3( "r_hudoutlineenable", 1 );
    _func_0D3( "r_hudoutlinewidth", 1 );
    _func_0D3( "r_hudoutlinepostmode", 0 );
}

warning( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    var_4 = 1.5 * var_3;
    var_5 = 0.5;
    level endon( "clearing_warnings" );

    if ( isdefined( level.warningelement ) )
        level.warningelement maps\_hud_util::destroyelem();

    level.warningelement = maps\_hud_util::createfontstring( "default", var_4 );
    level.warningelement maps\_hud_util::setpoint( "TOP", undefined, 0, 30 + var_2 );
    level.warningelement.color = ( 1, 0.1, 0.1 );
    level.warningelement settext( var_0 );
    level.warningelement.alpha = 0;
    level.warningelement fadeovertime( 0.5 );
    level.warningelement.alpha = 1;
    wait 0.5;
    level.warningelement endon( "death" );
    childthread warning_pulse();

    if ( isdefined( var_1 ) )
        wait(var_1);
    else
        return;

    level notify( "FadeWarning" );
    level.warningelement fadeovertime( var_5 );
    level.warningelement.alpha = 0;
    wait(var_5);
    level.warningelement maps\_hud_util::destroyelem();
}

warning_pulse()
{
    level endon( "FadeWarning" );

    while ( isdefined( level.warningelement ) )
    {
        wait 0.25;

        for ( var_0 = 0; var_0 < 9; var_0++ )
        {
            var_1 = level.warningelement.alpha - 0.1;
            level.warningelement.alpha = clamp( var_1, 0.1, 1 );
            waitframe();
        }

        waitframe();

        for ( var_0 = 0; var_0 < 9; var_0++ )
        {
            var_1 = level.warningelement.alpha + 0.1;
            level.warningelement.alpha = clamp( var_1, 0.1, 1 );
            waitframe();
        }
    }
}

warning_fade()
{
    var_0 = 1;

    if ( isdefined( level.warningelement ) )
    {
        level notify( "clearing_warnings" );
        level.warningelement fadeovertime( var_0 );
        level.warningelement.alpha = 0;
        wait(var_0);
    }
}

get_farthest_living( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 9999999;

    if ( var_1.size < 1 )
        return;

    var_3 = undefined;

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        if ( !isalive( var_1[var_4] ) )
            continue;

        var_5 = distance( var_1[var_4].origin, var_0 );

        if ( var_5 <= var_2 )
            continue;

        var_2 = var_5;
        var_3 = var_1[var_4];
    }

    return var_3;
}

calculateleftstickdeadzone()
{
    var_0 = level.player _meth_82F3();
    var_0 = ( scalestickinput( var_0[0] ), scalestickinput( var_0[1] ), var_0[2] );
    return var_0;
}

stickinputindeadzone( var_0, var_1 )
{
    return abs( var_0 ) < var_1;
}

scalestickinput( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.25;

    if ( stickinputindeadzone( var_0, var_1 ) )
        return 0;

    return var_0 * ( abs( var_0 ) - var_1 ) / ( 1 - var_1 );
}

hint_quick( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0.5;

    level endon( "clearing_hints" );

    if ( isdefined( level.hintelement ) )
        level.hintelement maps\_hud_util::destroyelem();

    level.hintelement = maps\_hud_util::createfontstring( "default", 1.5 );
    level.hintelement maps\_hud_util::setpoint( "MIDDLE", undefined, 0, 30 + var_2 );
    level.hintelement.color = ( 1, 1, 1 );
    level.hintelement settext( var_0 );
    level.hintelement.alpha = 0;
    level.hintelement fadeovertime( var_3 );
    level.hintelement.alpha = 1;
    wait(var_3);
    level.hintelement endon( "death" );

    if ( isdefined( var_1 ) )
        wait(var_1);
    else
        return;

    level.hintelement fadeovertime( var_3 );
    level.hintelement.alpha = 0;
    wait(var_3);
    level.hintelement maps\_hud_util::destroyelem();
}

hint_quickfade( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( isdefined( level.hintelement ) )
    {
        level notify( "clearing_hints" );
        level.hintelement fadeovertime( var_0 );
        level.hintelement.alpha = 0;
        wait(var_0);
    }
}

sneaky_reload()
{
    var_0 = level.player _meth_8311();
    var_1 = level.player getammocount( var_0 );
    var_2 = level.player _meth_82F0();
    var_3 = weaponclipsize( var_0 );
    var_4 = var_3 - var_2;
    level.player _meth_82F6( var_0, var_3 );
    level.player _meth_82F7( var_0, var_1 - var_4 );
}

blimp_animation( var_0, var_1 )
{
    if ( level.nextgen )
    {
        if ( isdefined( level.blimp ) )
            level.blimp delete();

        var_2 = getent( var_0, "targetname" );
        level.blimp = maps\_utility::spawn_anim_model( "greece_blimp" );
        var_2 thread maps\_anim::anim_loop_solo( level.blimp, var_1 );
    }
}

sunflareswap( var_0 )
{
    common_scripts\utility::flag_set( "fx_spot_flare_kill" );
    wait 0.5;
    common_scripts\utility::flag_clear( "fx_spot_flare_kill" );
    thread maps\_shg_fx::fx_spot_lens_flare_dir( var_0, ( -15.2216, 146.493, 0 ), 10000 );
}

tff_cleanup_vehicle( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "intro":
            var_1 = "tff_pre_intro_to_confcenter";
            break;
        case "middle":
            var_1 = "tff_pre_intro_to_middle";
            break;
        case "outro":
            var_1 = "tff_pre_middle_to_outro";
            break;
        case "confcenter":
            var_1 = "tff_pre_confcenter_to_intro";
            break;
        case "hades_fight":
            var_1 = "tff_pre_outro_to_hades_fight";
            break;
    }

    if ( var_1 == "" )
        return;

    level waittill( var_1 );

    if ( isdefined( self ) )
    {
        maps\_vehicle_code::_freevehicle();
        self delete();
    }
}

giveplayerchallengekillpoint()
{
    if ( self.damagelocation == "helmet" || self.damagelocation == "head" )
        level.player maps\_upgrade_challenge::give_player_challenge_headshot( 1 );

    level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
}
