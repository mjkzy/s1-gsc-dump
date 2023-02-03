// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    waittillframeend;
    waittillframeend;
    setup_free_run_move_anims();
    setup_free_run_cover_crouch_anims();
    setup_free_run_transition_anims();
}

#using_animtree("generic_human");

setup_free_run_move_anims()
{
    var_0 = [];
    var_0["sprint"] = %freerunnerb_loop;
    var_0["move_f"] = %freerunnerb_loop;
    var_0["move_l"] = %freerunnerb_loop;
    var_0["move_r"] = %freerunnerb_loop;
    var_0["move_b"] = %freerunnerb_loop;
    anim.archetypes["soldier"]["free_run_move"] = var_0;
}

setup_free_run_cover_crouch_anims()
{
    var_0 = [];
    var_0["hide_idle"] = %unarmed_covercrouch_hide_idle;
    var_0["hide_idle_twitch"] = animscripts\utility::array( %unarmed_covercrouch_twitch_1, %unarmed_covercrouch_twitch_2, %unarmed_covercrouch_twitch_3, %unarmed_covercrouch_twitch_4 );
    var_0["look"] = animscripts\utility::array( %unarmed_covercrouch_hide_look );
    var_0["add_aim_up"] = %covercrouch_aim8_add;
    var_0["add_aim_down"] = %covercrouch_aim2_add;
    var_0["add_aim_left"] = %covercrouch_aim4_add;
    var_0["add_aim_right"] = %covercrouch_aim6_add;
    var_0["straight_level"] = %covercrouch_aim5;
    var_0["hide_idle_flinch"] = animscripts\utility::array();
    var_0["hide_2_crouch"] = %covercrouch_hide_2_aim;
    var_0["hide_2_stand"] = %covercrouch_hide_2_stand;
    var_0["hide_2_lean"] = %covercrouch_hide_2_lean;
    var_0["hide_2_right"] = %covercrouch_hide_2_right;
    var_0["hide_2_left"] = %covercrouch_hide_2_left;
    var_0["crouch_2_hide"] = %covercrouch_aim_2_hide;
    var_0["stand_2_hide"] = %covercrouch_stand_2_hide;
    var_0["lean_2_hide"] = %covercrouch_lean_2_hide;
    var_0["right_2_hide"] = %covercrouch_right_2_hide;
    var_0["left_2_hide"] = %covercrouch_left_2_hide;
    var_0["smg_hide_2_stand"] = %smg_covercrouch_hide_2_stand;
    var_0["smg_stand_2_hide"] = %smg_covercrouch_stand_2_hide;
    var_0["crouch_aim"] = %covercrouch_aim5;
    var_0["stand_aim"] = %exposed_aim_5;
    var_0["lean_aim"] = %covercrouch_lean_aim5;
    var_0["fire"] = %exposed_shoot_auto_v2;
    var_0["semi2"] = %exposed_shoot_semi2;
    var_0["semi3"] = %exposed_shoot_semi3;
    var_0["semi4"] = %exposed_shoot_semi4;
    var_0["semi5"] = %exposed_shoot_semi5;
    var_0["single"] = [ %exposed_shoot_semi1 ];
    var_0["burst2"] = %exposed_shoot_burst3;
    var_0["burst3"] = %exposed_shoot_burst3;
    var_0["burst4"] = %exposed_shoot_burst4;
    var_0["burst5"] = %exposed_shoot_burst5;
    var_0["burst6"] = %exposed_shoot_burst6;
    var_0["blind_fire"] = animscripts\utility::array( %covercrouch_blindfire_1, %covercrouch_blindfire_2, %covercrouch_blindfire_3, %covercrouch_blindfire_4 );
    var_0["reload"] = %covercrouch_reload_hide;
    var_0["grenade_safe"] = animscripts\utility::array( %covercrouch_grenadea, %covercrouch_grenadeb );
    var_0["grenade_exposed"] = animscripts\utility::array( %covercrouch_grenadea, %covercrouch_grenadeb );
    var_0["exposed_idle"] = animscripts\utility::array( %exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3 );
    anim.archetypes["soldier"]["free_run_cover_crouch"] = var_0;
}

setup_free_run_transition_anims()
{
    var_0 = "free_run_into_cover_crouch";
    var_1 = [];
    var_1[1] = %unarmed_covercrouch_arrive_7;
    var_1[2] = %unarmed_covercrouch_arrive_8;
    var_1[3] = %unarmed_covercrouch_arrive_9;
    var_1[4] = %unarmed_covercrouch_arrive_4;
    var_1[6] = %unarmed_covercrouch_arrive_6;
    anim.archetypes["soldier"]["cover_trans"][var_0] = var_1;
    var_2 = "free_run_out_of_cover_crouch";
    var_1 = [];
    var_1[1] = %unarmed_covercrouch_exit_1;
    var_1[2] = %unarmed_covercrouch_exit_2;
    var_1[3] = %unarmed_covercrouch_exit_3;
    var_1[4] = %unarmed_covercrouch_exit_4;
    var_1[6] = %unarmed_covercrouch_exit_6;
    anim.archetypes["soldier"]["cover_exit"][var_2] = var_1;

    for ( var_3 = 1; var_3 <= 6; var_3++ )
    {
        if ( var_3 == 5 )
            continue;

        anim.archetypes["soldier"]["cover_trans_dist"][var_0][var_3] = getmovedelta( anim.archetypes["soldier"]["cover_trans"][var_0][var_3], 0, 1 );
        anim.archetypes["soldier"]["cover_trans_angles"][var_0][var_3] = getangledelta( anim.archetypes["soldier"]["cover_trans"][var_0][var_3], 0, 1 );

        if ( animhasnotetrack( anim.archetypes["soldier"]["cover_exit"][var_2][var_3], "code_move" ) )
            var_4 = getnotetracktimes( anim.archetypes["soldier"]["cover_exit"][var_2][var_3], "code_move" )[0];
        else
            var_4 = 1;

        anim.archetypes["soldier"]["cover_exit_dist"][var_2][var_3] = getmovedelta( anim.archetypes["soldier"]["cover_exit"][var_2][var_3], 0, var_4 );
        anim.archetypes["soldier"]["cover_exit_angles"][var_2][var_3] = getangledelta( anim.archetypes["soldier"]["cover_exit"][var_2][var_3], 0, 1 );
    }

    anim.archetypes["soldier"]["CoverTransLongestDist"][var_0] = 0;

    for ( var_3 = 1; var_3 <= 6; var_3++ )
    {
        if ( var_3 == 5 )
            continue;

        var_5 = lengthsquared( anim.archetypes["soldier"]["cover_trans_dist"][var_0][var_3] );

        if ( anim.archetypes["soldier"]["CoverTransLongestDist"][var_0] < var_5 )
            anim.archetypes["soldier"]["CoverTransLongestDist"][var_0] = var_5;
    }

    anim.arrivalendstance[var_0] = "crouch";
}

move_free_run()
{
    if ( self.a.pose != "stand" )
    {
        self clearanim( %animscript_root, 0.2 );

        if ( self.a.pose == "prone" )
            animscripts\utility::exitpronewrapper( 1 );

        self.a.pose = "stand";
    }

    self.a.movement = self.movemode;
    var_0 = animscripts\utility::lookupanim( "free_run_move", "sprint" );
    var_1 = self.moveplaybackrate;
    var_2 = 0.3;

    if ( self.movemode == "walk" )
        var_1 *= 0.6;

    self setflaggedanimknoball( "runanim", var_0, %walk_and_run_loops, 1, var_2, var_1, 1 );
    animscripts\run::setmovenonforwardanims( animscripts\utility::lookupanim( "free_run_move", "move_b" ), animscripts\utility::lookupanim( "free_run_move", "move_l" ), animscripts\utility::lookupanim( "free_run_move", "move_r" ) );
    thread animscripts\run::setcombatstandmoveanimweights( "free_run_move" );
    animscripts\notetracks::donotetracksfortime( 0.2, "runanim" );
}

enable_free_running( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 == 0 )
    {
        self.free_running_hidden_weapon = self.weapon;
        maps\_utility::gun_remove();
        self.weapon = "none";
    }
    else if ( isdefined( self.free_running_hidden_weapon ) )
        self.free_running_hidden_weapon = undefined;

    self.free_running = 1;
    animscripts\move::register_pluggable_move_loop_override( ::move_free_run );
}

disable_free_running()
{
    if ( isdefined( self.free_running ) )
    {
        if ( isdefined( self.free_running_hidden_weapon ) )
        {
            animscripts\shared::placeweaponon( self.free_running_hidden_weapon, "right" );
            self.free_running_hidden_weapon = undefined;
        }

        self.free_running = undefined;
        animscripts\move::clear_pluggable_move_loop_override();
    }
}
