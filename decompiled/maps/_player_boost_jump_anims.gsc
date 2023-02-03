// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    player_animations();
}

#using_animtree("player");

player_animations()
{
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = "viewhands_player_delta";
    level.scr_anim["player_rig"]["boost_land"] = %vm_rocket_jump_airbrake;
}
