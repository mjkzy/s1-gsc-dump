// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

delicate_flower()
{
    self endon( "death" );
    var_0 = 0;

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5 );
        var_0 += var_1;

        if ( var_5 == "MOD_IMPACT" )
            continue;

        if ( var_0 < 5 )
            continue;

        if ( isplayer( var_2 ) )
            break;
    }

    if ( self.damageshield )
        maps\_utility::stop_magic_bullet_shield();

    setdvar( "ui_deadquote", &"RECOVERY_PRESIDENT_MURDERED" );
    thread maps\_utility::missionfailedwrapper();
    self kill();
}

#using_animtree("generic_human");

set_president_anims()
{
    if ( isdefined( self.ispresident ) )
        return;

    self.ispresident = 1;
    self.team = "allies";
    self.type = "human";
    self.alertlevel = "noncombat";
    self.alertlevelint = 0;
    self.a.disablepain = 1;
    self pushplayer( 1 );
    thread delicate_flower();
    maps\_utility::gun_remove();
    var_0 = [ "exposed", "exposed_crouch" ];
    var_1[1] = %rec_president_walk_arrive_1;
    var_1[2] = %rec_president_walk_arrive_2;
    var_1[3] = %rec_president_walk_arrive_3;
    var_1[4] = %rec_president_walk_arrive_4;
    var_1[6] = %rec_president_walk_arrive_6;
    var_1[7] = %rec_president_walk_arrive_7;
    var_1[8] = %rec_president_walk_arrive_8;
    var_1[9] = %rec_president_walk_arrive_9;
    var_2[1] = %rec_president_walk_exit_1;
    var_2[2] = %rec_president_walk_exit_2;
    var_2[3] = %rec_president_walk_exit_3;
    var_2[4] = %rec_president_walk_exit_4;
    var_2[6] = %rec_president_walk_exit_6;
    var_2[7] = %rec_president_walk_exit_7;
    var_2[8] = %rec_president_walk_exit_8;
    var_2[9] = %rec_president_walk_exit_9;
    var_3[0] = %rec_president_run_turn_2;
    var_3[1] = %rec_president_run_turn_1;
    var_3[2] = %rec_president_run_turn_4;
    var_3[3] = %rec_president_run_turn_7;
    var_3[5] = %rec_president_run_turn_9;
    var_3[6] = %rec_president_run_turn_6;
    var_3[7] = %rec_president_run_turn_3;
    var_3[8] = %rec_president_run_turn_2;
    var_4["stairs_down"] = %rec_stairs_run_down;
    var_4["stairs_down_in"] = %rec_stairs_run_down_in;
    var_4["stairs_down_out"] = %rec_stairs_run_down_out;
    maps\_utility::set_npc_anims( "president", %rec_president_run, %rec_president_run, [ %rec_president_crouch_idle ], var_1, var_2, var_0, var_3, var_3, var_4 );
}

clear_president_anims()
{
    maps\_utility::clear_npc_anims( "president" );
}
