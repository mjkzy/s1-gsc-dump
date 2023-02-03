// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    init_microwave_grenade();
}

init_microwave_grenade()
{
    precacheshellshock( "microwave_grenade" );
    precacheshellshock( "flashbang" );
    precache_microwave_grenade_fx();
    precache_microwave_anims();
    start_monitor_microwave_grenades();
}

precache_microwave_grenade_fx()
{
    level._effect["microwave_grenade"] = loadfx( "vfx/explosion/microwave_grenade_exp" );
    level._effect["microwave_grenade_sparks_1"] = loadfx( "vfx/sparks/microwave_grenade_sparks_1" );
    level._effect["microwave_grenade_sparks_char_1"] = loadfx( "vfx/sparks/microwave_grenade_sparks_char_1" );
}

#using_animtree("generic_human");

precache_microwave_anims()
{
    level.scr_anim["generic"]["microwave_react1"] = %teargas_react_1;
    level.scr_anim["generic"]["microwave_react2"] = %teargas_react_2;
    level.scr_anim["generic"]["microwave_react3"] = %teargas_react_3;
    level.scr_anim["generic"]["microwave_run1"][0] = %teargas_run_6;
    level.scr_anim["generic"]["microwave_run2"][0] = %teargas_run_7;
    level.scr_anim["generic"]["microwave_run3"][0] = %teargas_run_8;
}

start_monitor_microwave_grenades()
{
    maps\_utility::add_global_spawn_function( "axis", ::monitor_microwave_grenades );
    maps\_utility::add_global_spawn_function( "allies", ::monitor_microwave_grenades );

    foreach ( var_1 in level.players )
        var_1 thread monitor_microwave_grenades();
}

monitor_microwave_grenades()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = undefined;
        var_1 = undefined;
        self waittill( "grenade_fire", var_0, var_1 );

        if ( isdefined( var_0 ) )
        {
            if ( isdefined( var_1 ) )
            {
                if ( var_1 == "microwave_grenade" )
                {
                    var_0.team = self.team;
                    var_0 thread microwave_grenade_explode_wait();
                }
            }
        }
    }
}

microwave_grenade_explode_wait()
{
    self waittill( "explode", var_0 );

    if ( isdefined( self.team ) )
        maps\_dds::dds_notify( "react_microwave", self.team != "allies" );
    else
        maps\_dds::dds_notify( "react_microwave", 1 );

    thread soundscripts\_snd_common::aud_microwave_grenade();
    playfx( common_scripts\utility::getfx( "microwave_grenade" ), self.origin );
    thread play_microwave_sparkfx( self.origin );
    thread play_microwave_physics( self.origin );
    thread player_screen_flash( 1.5 );
    thread microwave_grenade_ai_flee_pulse();
}

microwave_grenade_ai_flee_pulse()
{
    self endon( "death" );
    var_0 = 90000;
    badplace_cylinder( "", 7.5, self.origin, 300, 300, "axis", "allies", "neutral" );
}

microwave_claim_safe_node( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_1 = getnodesinradius( var_0.origin, 600, 350 );
    var_1 = sortbydistance( var_1, self.origin );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.mw_claimed ) || gettime() > var_3.mw_claimed )
        {
            var_3.mw_claimed = gettime() + 10000;
            return var_3;
        }
    }

    return undefined;
}

microwave_set_safe_goal( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        maps\_utility::set_goalradius( 20 );
        self setgoalnode( var_0 );
    }
    else
    {
        maps\_utility::set_goalradius( 50 );
        self setgoalentity( level.player );
    }
}

ai_flee_from_microwave( var_0, var_1 )
{
    self notify( "ai_flee_from_microwave" );
    self endon( "ai_flee_from_microwave" );
    self endon( "death" );

    if ( isdefined( self ) == 0 || isalive( self ) == 0 || maps\_utility::doinglongdeath() )
        return;

    maps\_utility::set_ignoresuppression( 1 );
    self.mw_old_goalradius = self.goalradius;
    self.mw_old_animname = self.animname;
    self.mw_grenade = var_0;
    self.animname = "generic";
    self clearenemy();
    self.mw_old_badplace_awareness = self.badplaceawareness;
    self.badplaceawareness = 0;
    self.ignoreall = 1;
    self.allowdeath = 1;
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.a.disablepain = 1;
    self.script_forcegoal = 0;
    self.disabledamagefeedbacksnd = 1;
    thread handle_microwaved_ai( self );
    var_2 = "microwave_react" + ( 1 + randomint( 3 ) );

    if ( check_melee_interaction_active() )
    {
        cleanup_microwave_on_exit();
        return;
    }

    if ( !isdefined( self.mech ) )
        childthread maps\_anim::anim_custom_animmode_solo( self, "gravity", var_2 );

    if ( check_melee_interaction_active() )
    {
        cleanup_microwave_on_exit();
        return;
    }

    if ( !isdefined( self.mech ) )
    {
        var_3 = "microwave_run" + ( 1 + randomint( 3 ) );
        maps\_utility::set_run_anim( var_3 );
    }

    microwave_set_safe_goal( var_1 );

    for (;;)
    {
        var_4 = common_scripts\utility::waittill_any_timeout( 0.2, "goal" );
        var_5 = gettime() - self.microwaved > 300;

        if ( var_4 == "goal" || var_5 )
        {
            if ( var_5 )
            {
                cleanup_microwave_on_exit();
                return;
            }
            else
            {
                var_6 = microwave_claim_safe_node( self.mw_grenade );
                microwave_set_safe_goal( var_6 );
            }
        }
    }
}

cleanup_microwave_on_exit()
{
    maps\_utility::clear_run_anim();
    self.ignoreall = 0;
    self.disablearrivals = 0;
    self.disableexits = 0;
    self.a.disablepain = 0;
    self.disabledamagefeedbacksnd = undefined;
    maps\_utility::set_goalradius( self.mw_old_goalradius );
    self.badplaceawareness = self.mw_old_badplace_awareness;
    maps\_utility::set_ignoresuppression( 0 );

    if ( isdefined( self.animname ) && self.animname == "generic" )
        self.animname = self.mw_old_animname;

    self.microwaved = undefined;
    self.mw_grenade = undefined;
}

check_melee_interaction_active()
{
    if ( isdefined( self.dog_attacking_me ) || isdefined( self.syncedmeleetarget ) || isdefined( self.melee ) && isdefined( self.melee.target ) )
        return 1;

    return 0;
}

handle_microwaved_ai( var_0 )
{
    if ( !isdefined( level.microwaveded_ai ) )
        level.microwaveded_ai = [];

    level.microwaveded_ai[level.microwaveded_ai.size] = var_0;
    var_0 waittill( "death" );
    level.microwaveded_ai = common_scripts\utility::array_remove( level.microwaveded_ai, var_0 );
}

play_microwave_sparkfx( var_0 )
{
    var_1 = 7500.0;
    var_2 = 220;
    var_3 = gettime() + var_1 - 500;
    thread play_environment_microwave_sparks( var_1, var_2, var_0, var_3 );
    thread play_character_microwave_sparks( var_0, var_2, var_3 );
}

play_environment_microwave_sparks( var_0, var_1, var_2, var_3 )
{
    while ( gettime() < var_3 )
    {
        wait 0.1;
        var_4 = ( randomfloat( 2 ) - 1, randomfloat( 2 ) - 1, randomfloat( 1 ) );
        var_5 = 32 * var_4 + var_2;
        var_6 = var_1 * var_4 + var_2;
        var_7 = bullettrace( var_5, var_6, 0, undefined, 0, 0, 1, 0, 0 );

        if ( isdefined( var_7 ) && var_7["surfacetype"] != "none" )
        {
            if ( distance( var_5, var_7["position"] ) > 20 )
            {
                playfx( common_scripts\utility::getfx( "microwave_grenade_sparks_1" ), var_7["position"], var_7["normal"] );
                thread soundscripts\_snd_common::aud_microwave_grenade_sparks_env( var_7["position"] );
            }
        }
    }
}

play_character_microwave_sparks( var_0, var_1, var_2 )
{
    var_3 = [ "TAG_WEAPON_RIGHT", "TAG_WEAPON_LEFT", "J_Head", "J_SpineLower" ];

    while ( gettime() < var_2 )
    {
        wait(randomfloatrange( 0.15, 0.25 ));
        var_4 = getaiarray( "axis", "allies" );
        var_5 = [];

        foreach ( var_7 in var_4 )
        {
            if ( distancesquared( var_7.origin, var_0 ) < var_1 * var_1 )
                var_5[var_5.size] = var_7;
        }

        if ( var_5.size > 0 )
        {
            foreach ( var_10 in var_5 )
            {
                if ( randomint( 2 ) == 1 )
                {
                    playfxontag( common_scripts\utility::getfx( "microwave_grenade_sparks_char_1" ), var_10, var_3[randomint( var_3.size )] );
                    thread soundscripts\_snd_common::aud_microwave_grenade_sparks_dude( var_10 );
                }
            }
        }
    }
}

ismetalsurface( var_0 )
{
    var_1 = [ "metal_debris", "metal_grate", "metal_hollow", "metal_solid", "metal_vehicle", "metal_thin", "metal_wet" ];

    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

play_microwave_physics( var_0 )
{
    var_1 = 0;

    while ( var_1 <= 7.5 )
    {
        physicsexplosionsphere( var_0, 256, 128, 0.5, 0 );
        var_1 += 0.5;
        wait 0.5;
    }
}

player_screen_flash( var_0 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
    {
        while ( isdefined( self ) && isdefined( level.player ) )
        {
            var_1 = distance( self.origin, level.player.origin );

            if ( var_1 >= 220 )
            {

            }
            else
                level.player shellshock( "flashbang", 1.5 );

            wait(var_0);
        }

        wait 0.05;
    }
    else
        return;
}
