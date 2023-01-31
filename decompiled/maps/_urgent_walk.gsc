// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

set_urgent_walk_anims()
{
    if ( isdefined( self.isurgentwalk ) )
        return;

    maps\_utility::gun_remove();
    self.isurgentwalk = 1;
    self.dynamicturnscaling = 1;
    self.alertlevel = "noncombat";
    self.alertlevelint = 0;
    var_0 = [ "exposed", "exposed_crouch" ];
    var_1[1] = %npc_urgent_walk_arrive_1;
    var_1[2] = %npc_urgent_walk_arrive_2;
    var_1[3] = %npc_urgent_walk_arrive_3;
    var_1[4] = %npc_urgent_walk_arrive_4;
    var_1[6] = %npc_urgent_walk_arrive_6;
    var_1[7] = %npc_urgent_walk_arrive_7;
    var_1[8] = %npc_urgent_walk_arrive_8;
    var_1[9] = %npc_urgent_walk_arrive_9;
    var_2[1] = %npc_urgent_walk_exit_1;
    var_2[2] = %npc_urgent_walk_exit_2;
    var_2[3] = %npc_urgent_walk_exit_3;
    var_2[4] = %npc_urgent_walk_exit_4;
    var_2[6] = %npc_urgent_walk_exit_6;
    var_2[7] = %npc_urgent_walk_exit_7;
    var_2[8] = %npc_urgent_walk_exit_8;
    var_2[9] = %npc_urgent_walk_exit_9;
    var_3[0] = %npc_urgent_walk_turn_2;
    var_3[1] = %npc_urgent_walk_turn_1;
    var_3[2] = %npc_urgent_walk_turn_4;
    var_3[3] = %npc_urgent_walk_turn_7;
    var_3[5] = %npc_urgent_walk_turn_9;
    var_3[6] = %npc_urgent_walk_turn_6;
    var_3[7] = %npc_urgent_walk_turn_3;
    var_3[8] = %npc_urgent_walk_turn_2;
    var_4 = [ %npc_urgent_walk_twitch01_idle, %npc_urgent_walk_twitch02_idle, %npc_urgent_walk_twitch03_idle, %npc_urgent_walk_idle ];
    maps\_utility::set_npc_anims( "urgent_walk", %bet_unarmed_casual_walk01_gideon, %bet_unarmed_casual_walk01_gideon, var_4, var_1, var_2, var_0, var_3, var_3, undefined );
}

clear_urgent_walk_anims()
{
    self.dynamicturnscaling = undefined;
    maps\_utility::clear_npc_anims( "urgent_walk" );
    maps\_utility::gun_recall();
}
