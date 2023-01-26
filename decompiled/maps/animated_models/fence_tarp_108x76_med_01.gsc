// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

#using_animtree("animated_props");

main()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_0 = "fence_tarp_108x76";

    if ( common_scripts\utility::issp() )
        level.anim_prop_models[var_0]["wind"] = %fence_tarp_108x76_med_01;
    else
        level.anim_prop_models[var_0]["wind"] = "fence_tarp_108x76_med_01";
}
