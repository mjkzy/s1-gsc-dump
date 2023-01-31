// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_flashlight_cheap::cheap_flashlight_init();
    maps\_patrol_anims_creepwalk::main();
    maps\_patrol_anims_patroljog::main();
    maps\_patrol_anims_active::main();
    maps\_patrol_anims_casualkiller::main();
    maps\_patrol_anims::main();
    extended_idle_anims();
}

force_patrol_anim_set( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    self.patrol_walk_twitch = undefined;
    self.patrol_walk_anim = undefined;
    self.script_animation = var_0;

    if ( var_2 )
        maps\_patrol::patrol();

    maps\_patrol::set_patrol_run_anim_array();
    self.goalradius = 32;
    self _meth_81CA( "stand" );
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.allowdeath = 1;
    maps\_utility::disable_cqbwalk();
    self.patrol_anim_set = var_0;

    if ( isdefined( var_1 ) && var_1 )
    {
        self.enable_flashlight_callback = maps\_flashlight_cheap::add_cheap_flashlight;
        maps\_flashlight_cheap::add_cheap_flashlight( "flashlight", undefined, var_3 );
    }
}

#using_animtree("generic_human");

extended_idle_anims()
{
    maps\_idle::idle_main();
    level.idle_animation_list_func = ::_extended_patrol_idle_animation_list_func;
    level.scr_anim["generic"]["flashlight_high_idle"][0] = %so_hijack_search_flashlight_high_loop;
    level.scr_anim["generic"]["flashlight_high_react"] = %so_hijack_search_flashlight_high_reaction;
    level.scr_anim["generic"]["flashlight_low_idle"][0] = %so_hijack_search_flashlight_low_loop;
    level.scr_anim["generic"]["flashlight_low_react"] = %so_hijack_search_flashlight_low_reaction;
    level.scr_anim["generic"]["flashlight_high2_into_idle"] = %patrol_flashlight_high_stop;
    level.scr_anim["generic"]["flashlight_high2_idle"][0] = %patrol_flashlight_high_idle_v1;
    level.scr_anim["generic"]["flashlight_high2_react"] = %patrol_flashlight_high_putaway;
    maps\_anim::addnotetrack_customfunction( "generic", "flashlight_hide", maps\_flashlight_cheap::cheap_flashlight_hide, "flashlight_high2_react" );
    level.scr_anim["generic"]["flashlight_high2_takeout"] = %patrol_flashlight_high_takeout;
    maps\_anim::addnotetrack_customfunction( "generic", "flashlight_show", maps\_flashlight_cheap::cheap_flashlight_show, "flashlight_high2_takeout" );
}

_extended_patrol_idle_animation_list_func( var_0 )
{
    var_0[var_0.size] = "flashlight_high";
    var_0[var_0.size] = "flashlight_low";
    var_0[var_0.size] = "flashlight_high2";
    return var_0;
}
