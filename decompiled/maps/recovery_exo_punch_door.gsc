// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

exo_door_init()
{
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinewidth", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 4 );
    setsaveddvar( "r_hudoutlinecloaklumscale", 0.5 );
    setsaveddvar( "r_hudoutlineAlpha0", 1 );
    setsaveddvar( "r_hudoutlineAlpha1", 0 );
    setsaveddvar( "r_hudoutlinecloakblurradius", 0.45 );
    setsaveddvar( "r_hudoutlinecloakDarkenscale", 1 );
    setsaveddvar( "r_hudoutlinecloaklumscale", 1 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 1 );
    setsaveddvar( "r_hudoutlinehalodarkenscale", 1 );
    setsaveddvar( "r_hudoutlinehaloLumscale", 1 );
    level.broken_door = 0;
    var_0 = [];
    var_1 = getentarray( "door_exo_punch_intact", "targetname" );
    var_1 = common_scripts\utility::array_add( var_1, getent( "door_exo_punch_intact", "script_noteworthy" ) );
    var_0 = getscriptablearray( "door_exo_punch_breakable", "targetname" );
    var_2 = getentarray( "exo_punch_door_trigger", "targetname" );
    var_3 = getentarray( "exo_punch_door_clip", "targetname" );
    var_4 = getentarray( "exo_punch_door_usetrigger", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 sethintstring( &"RECOVERY_PROMPT_MELEE_BREACH" );

    if ( common_scripts\utility::flag( "training_round_2" ) == 0 )
    {
        foreach ( var_9 in var_1 )
        {
            var_9.trig = common_scripts\utility::getclosest( var_9.origin, var_2, 100 );
            var_9.broken = common_scripts\utility::getclosest( var_9.origin, var_0, 100 );
            var_9.clip = common_scripts\utility::getclosest( var_9.origin, var_3, 100 );
            var_9.usetrig = common_scripts\utility::getclosest( var_9.origin, var_4, 100 );
            var_9.broken hide();
            var_9.clip notsolid();
            var_9.clip common_scripts\utility::delaycall( 2, ::connectpaths );
        }

        common_scripts\utility::array_thread( var_1, common_scripts\utility::hide_notsolid );
        common_scripts\utility::flag_wait( "training_round_2" );
        common_scripts\utility::flag_wait( "flag_obj_rescue2_living_room" );

        foreach ( var_9 in var_1 )
        {
            var_9.clip solid();
            var_9.clip common_scripts\utility::delaycall( 2, ::disconnectpaths );
            var_9 thread monitor_door_punch();

            if ( isdefined( var_9.usetrig ) )
                var_9.button = var_9.usetrig maps\_shg_utility::hint_button_trigger( "rs", 300 );
        }

        common_scripts\utility::array_thread( var_1, common_scripts\utility::show_solid );
    }
    else
    {
        common_scripts\utility::flag_wait( "flag_obj_rescue2_living_room" );

        foreach ( var_9 in var_1 )
        {
            var_9.trig = common_scripts\utility::getclosest( var_9.origin, var_2, 100 );
            var_9.broken = common_scripts\utility::getclosest( var_9.origin, var_0, 100 );
            var_9.clip = common_scripts\utility::getclosest( var_9.origin, var_3, 100 );
            var_9.usetrig = common_scripts\utility::getclosest( var_9.origin, var_4, 100 );
            var_9 thread monitor_door_punch();

            if ( isdefined( var_9.usetrig ) )
                var_9.button = var_9.usetrig maps\_shg_utility::hint_button_trigger( "rs", 300 );
        }
    }

    var_15 = getentarray( "front_door_clip", "targetname" );
    common_scripts\utility::array_call( var_15, ::notsolid );
    var_16 = getentarray( "front_door", "targetname" );

    foreach ( var_9 in var_16 )
        var_9 common_scripts\utility::hide_notsolid();

    foreach ( var_20 in var_15 )
        var_20 common_scripts\utility::delaycall( 2, ::connectpaths );

    var_22 = getent( "living_room_door_clip", "targetname" );
    var_22 notsolid();
    var_23 = getent( "training_s1_flash_door", "targetname" );
    var_23 common_scripts\utility::hide_notsolid();
    var_22 common_scripts\utility::delaycall( 2, ::connectpaths );
    var_24 = getent( "french_door_clip", "targetname" );
    var_24 notsolid();
    var_25 = getent( "french_door", "targetname" );
    var_25 common_scripts\utility::hide_notsolid();
    var_24 common_scripts\utility::delaycall( 2, ::connectpaths );
    level.player thread monitor_last_weapon();
    edi_anims();
    common_scripts\utility::flag_wait( "training_s2_gideon_smash_french_door" );

    foreach ( var_9 in var_1 )
    {
        if ( isdefined( var_9.script_noteworthy ) && var_9.script_noteworthy == "door_exo_punch_intact" )
        {
            if ( level.broken_door == 0 )
                var_9.button thread maps\_shg_utility::hint_button_clear();
        }
    }
}

exo_door_logic()
{

}

monitor_last_weapon()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = self getcurrentweapon();

        if ( var_0 != "none" && isdefined( var_0 ) )
            self.old_weapon = var_0;

        waitframe();
    }
}

exo_punch_outline_think()
{
    self endon( "death" );
    self endon( "exo_door_punched" );
    thread exo_door_punch_cleanup();

    for (;;)
    {
        if ( distance( self.origin, level.player.origin ) < 350 )
        {
            if ( !target_istarget( self ) )
            {
                target_set( self );
                target_hidefromplayer( self, level.player );
            }

            if ( target_istarget( self ) && target_isincircle( self, level.player, 65, 120 ) && !isdefined( self.script_noteworthy ) )
                self hudoutlineenable( 6, 1 );
            else if ( !isdefined( self.script_noteworthy ) )
                self hudoutlinedisable();

            if ( isdefined( self.script_noteworthy ) && target_istarget( self ) && target_isincircle( self, level.player, 65, 120 ) && common_scripts\utility::flag( "training_s2_gideon_smash_french_door" ) == 0 )
                self hudoutlineenable( 6, 1 );
            else if ( isdefined( self.script_noteworthy ) )
                self hudoutlinedisable();
        }
        else if ( target_istarget( self ) )
            target_remove( self );

        waitframe();
    }
}

exo_door_punch_cleanup()
{
    self waittill( "exo_door_punched" );
}

monitor_door_punch()
{
    self.broken hide();
    self.clip disconnectpaths();

    for (;;)
    {
        self.trig waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( var_1 == level.player && ( var_4 == "MOD_MELEE_ALT" || var_4 == "MOD_MELEE" ) )
        {
            if ( isdefined( self.button ) )
                self.button thread maps\_shg_utility::hint_button_clear();

            if ( self.trig.script_noteworthy == "kitchen" )
                maps\_utility::delaythread( 1, common_scripts\utility::flag_set, "flag_vo_training_s2_joker_entering_kitchen" );

            if ( self.trig.script_noteworthy == "living_room" )
                maps\_utility::delaythread( 1, common_scripts\utility::flag_set, "flag_vo_training_s2_joker_living_room" );

            if ( self.trig.script_noteworthy == "front_entrance" )
                maps\_utility::delaythread( 1, common_scripts\utility::flag_set, "flag_vo_training_s2_joker_front_entrance" );

            level.player playrumbleonentity( "light_1s" );
            level.player switchtoweaponimmediate( level.player.old_weapon );
            self notify( "exo_door_punched" );
            self.direction = var_2;
            self.land_point = var_3;
            self.original_origin = self.origin;
            var_5 = common_scripts\utility::spawn_tag_origin();

            if ( self.model == "rec_french_door_01_pristine_rig" )
            {
                var_5.angles = self.angles + ( 0, 90, 0 );
                playfxontag( common_scripts\utility::getfx( "recovery_dust_burst_round_french" ), var_5, "tag_origin" );
                var_5 thread clear_door_effect();
            }
            else
            {
                playfxontag( common_scripts\utility::getfx( "recovery_dust_burst_round_high" ), var_5, "tag_origin" );
                var_5 thread clear_door_effect();
            }

            break;
        }

        waitframe();
    }

    common_scripts\utility::flag_set( "training_s2_living_room_alert" );
    var_6 = self.broken;
    var_6 show();
    self hide();
    self.origin -= ( 0, 0, 10000 );
    self.clip.origin -= ( 0, 0, 10000 );
    self.clip connectpaths();
    exo_door_smash();

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "door_exo_punch_intact" )
        level.broken_door = 1;
}

clear_door_effect()
{
    wait 10;
    self delete();
}

exo_door_smash()
{
    var_0 = self.direction;
    var_1 = self.broken;
    var_2 = ( randomintrange( -5, 5 ), randomintrange( -5, 5 ), randomintrange( -10, 10 ) );
    var_1 setscriptablepartstate( "root", "destroyed" );
    wait 0.1;
    physicsexplosionsphere( var_1.origin, 100, 5, 10 );
    level.player notify( "exo_door_punched" );
    var_3 = getaiarray( "axis" );

    foreach ( var_5 in var_3 )
    {
        var_5 thread monitor_door_impact( self );
        var_5 thread monitor_door_react( self );
    }
}

monitor_door_impact( var_0 )
{
    var_1 = var_0;
    self endon( "death" );
    var_1 endon( "physics_finished" );

    while ( distance( self.origin, var_1.origin ) > 80 )
        waitframe();

    var_2 = vectornormalize( self gettagorigin( "tag_eye" ) - var_0.original_origin );
    var_2 = vectornormalize( var_2 + ( randomfloat( 0.5 ), randomfloat( 0.5 ), randomfloat( 0.5 ) ) );
    self startragdollfromimpact( "torso_lower", var_2 * randomintrange( 2400, 2800 ) );
    thread common_scripts\utility::delaycall( 2, ::kill );
}

monitor_door_react( var_0 )
{
    var_1 = var_0;
    self endon( "death" );
    var_1 endon( "physics_finished" );

    while ( distance( self.origin, var_1.origin ) > 200 )
        waitframe();

    maps\_utility::flashbangstart( randomfloatrange( 1, 4 ) );
}

#using_animtree("generic_human");

edi_anims()
{
    level.scr_anim["generic"]["exo_punch_react_1"] = %corner_standr_flinchb;
    level.scr_anim["generic"]["exo_punch_react_2"] = %corner_standr_flinch;
    level.scr_anim["generic"]["exo_punch_react_3"] = %exposed_crouch_pain_flinch;
    level.scr_anim["generic"]["exo_punch_react_4"] = %ny_harbor_bulkhead_door_breach_stunned_guy2;
    level.door_punch_flinches = [ "exo_punch_react_1", "exo_punch_react_2", "exo_punch_react_3", "exo_punch_react_4" ];
}
