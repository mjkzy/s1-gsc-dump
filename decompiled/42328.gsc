// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    humans();
    dogs();
}

#using_animtree("generic_human");

humans()
{
    level.scr_anim["generic"]["_stealth_patrol_walk_casualkiller"] = %casual_killer_jog_b;
    level.scr_anim["generic"]["patrol_walk_casualkiller"] = %casual_killer_jog_b;
    level.scr_anim["generic"]["patrol_idle_casualkiller"][0] = %casual_stand_idle;
    level.scr_anim["generic"]["patrol_stop_casualkiller"] = %casual_killer_walk_stop;
    level.scr_anim["generic"]["patrol_start_casualkiller"] = %casual_killer_walk_start;
}

dogs()
{

}

enable_casualkiller()
{
    self.script_animation = "casualkiller";

    if ( isdefined( self.script_patroller ) && self.script_patroller )
        maps\_patrol::set_patrol_run_anim_array();
}

init_casualkiller_archetype()
{
    if ( isdefined( anim.archetypes ) && maps\_utility::archetype_exists( "casualkiller" ) )
        return;

    var_0 = [];
    var_0["cover_trans_angles"]["casualkiller"][1] = 45;
    var_0["cover_trans_angles"]["casualkiller"][2] = 0;
    var_0["cover_trans_angles"]["casualkiller"][3] = -45;
    var_0["cover_trans_angles"]["casualkiller"][4] = 90;
    var_0["cover_trans_angles"]["casualkiller"][6] = -90;
    var_0["cover_trans_angles"]["casualkiller"][8] = 180;
    var_0["run"]["straight"] = %casual_killer_jog_b;
    var_0["run"]["move_f"] = %casual_killer_jog_b;
    var_0["run"]["straight_twitch"] = [ %casual_killer_walk_f_weapon_swap, %casual_killer_walk_wave, %casual_killer_walk_point ];
    maps\_utility::register_archetype( "casualkiller", var_0 );
}
