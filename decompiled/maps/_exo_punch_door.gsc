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
    var_0 = getentarray( "door_exo_punch_intact", "targetname" );
    var_1 = getentarray( "door_exo_punch_broken", "targetname" );
    var_2 = getentarray( "exo_punch_door_trigger", "targetname" );
    var_3 = getentarray( "exo_punch_door_clip", "targetname" );
    var_4 = getentarray( "exo_punch_door_usetrigger", "targetname" );

    foreach ( var_6 in var_0 )
    {
        var_6.trig = common_scripts\utility::getclosest( var_6.origin, var_2, 100 );
        var_6.broken = common_scripts\utility::getclosest( var_6.origin, var_1, 50 );
        var_6.clip = common_scripts\utility::getclosest( var_6.origin, var_3, 100 );
        var_6.handles = getentarray( var_6.target, "targetname" );
        var_6.usetrig = common_scripts\utility::getclosest( var_6.origin, var_4, 100 );
        var_6 thread monitor_door_punch();
        var_6 thread exo_punch_outline_think();

        if ( isdefined( var_6.usetrig ) )
        {
            var_6.usetrig sethintstring( &"RECOVERY_PROMPT_MELEE_BREACH" );
            var_6.button = var_6.usetrig maps\_shg_utility::hint_button_trigger( "rs", 300 );
        }
    }

    level.player thread monitor_last_weapon();
    edi_anims();
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

            if ( target_istarget( self ) && target_isincircle( self, level.player, 65, 120 ) )
                self hudoutlineenable( 6, 1 );
            else
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
    self hudoutlinedisable();
}

monitor_door_punch()
{
    self.broken hide();
    self.clip disconnectpaths();

    for (;;)
    {
        self.trig waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( var_1 == level.player && var_4 == "MOD_MELEE_ALT" )
        {
            self.usetrig sethintstring( " " );
            self.button maps\_shg_utility::hint_button_clear();
            level.player switchtoweaponimmediate( level.player.old_weapon );
            self notify( "exo_door_punched" );
            self.direction = var_2;
            self.land_point = var_3;
            self.original_origin = self.origin;
            break;
        }

        waitframe();
    }

    var_5 = self.broken;
    var_5 show();
    self hide();
    self.origin -= ( 0, 0, 10000 );
    common_scripts\utility::array_call( self.handles, ::delete );
    self.clip.origin -= ( 0, 0, 10000 );
    self.clip connectpaths();
    exo_door_smash();
}

exo_door_smash()
{
    var_0 = self.direction;
    var_1 = self.broken;
    var_2 = ( randomintrange( -5, 5 ), randomintrange( -5, 5 ), randomintrange( -10, 10 ) );
    var_1 physicslaunchserver( var_1.origin + var_2, var_0 * randomintrange( 500, 1100 ) );
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
    var_1 = var_0.broken;
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
    var_1 = var_0.broken;
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
