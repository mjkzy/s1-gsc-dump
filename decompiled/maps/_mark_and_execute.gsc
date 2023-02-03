// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precacheshader( "dpad_laser_designator" );
    precacheshellshock( "rsass_silenced" );
}

mark_and_execute_on( var_0 )
{
    level.hud_mark = set_temp_hud_text( "default", 1.0, &"IRONS_ESTATE_MARK", -398, -52 );
    level.hud_execute = set_temp_hud_text( "default", 1.0, &"IRONS_ESTATE_EXECUTE", -365, -35 );
    level.hud_execute.color = ( 1, 0, 0 );
    self notifyonplayercommand( "mark", "+actionslot 3" );
    self notifyonplayercommand( "execute", "+actionslot 2" );
    level.executer = var_0;
    thread mark_monitor();
    thread execute_monitor();
    setup_generic_target_acquired_vo();
    setup_generic_no_shot_vo();
    setup_generic_target_down_vo();
    setup_generic_taking_the_shot_vo();
    setup_player_blocking_shot_vo();
}

mark_and_execute_off()
{
    self notify( "mark_and_execute_off" );
    wait 0.05;

    if ( isdefined( level.hud_mark ) )
        level.hud_mark destroy();

    if ( isdefined( level.hud_execute ) )
        level.hud_execute destroy();
}

set_temp_hud_text( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\_hud_util::createfontstring( var_0, var_1 );
    var_5 settext( var_2 );
    var_5 maps\_hud_util::setpoint( "CENTER", "BOTTOM", var_3, var_4 );
    return var_5;
}

mark_monitor()
{
    self endon( "death" );
    self endon( "mark_and_execute_off" );
    level.marked_enemy = undefined;

    for (;;)
    {
        self waittill( "mark" );
        var_0 = bullettrace( self geteye(), self geteye() + anglestoforward( self getangles() ) * 50000, 1, self, 0, 0, 0, 0, 0 );

        if ( isdefined( var_0["entity"] ) )
        {
            var_1 = var_0["entity"];

            if ( isai( var_1 ) && isenemyteam( var_1.team, self.team ) && isalive( var_1 ) )
            {
                common_scripts\utility::flag_set( "marked_enemy" );
                attempt_mark_enemy( var_1 );
            }
        }

        wait 0.05;
    }
}

attempt_mark_enemy( var_0 )
{
    level.player endon( "death" );
    level.player endon( "mark_and_execute_off" );

    if ( isdefined( level.marked_enemy ) && level.marked_enemy == var_0 )
        level.marked_enemy unmark_enemy();
    else if ( isdefined( level.marked_enemy ) && level.marked_enemy != var_0 )
    {
        level.marked_enemy unmark_enemy();
        var_0 mark_enemy();
    }
    else if ( !isdefined( level.marked_enemy ) )
        var_0 mark_enemy();
}

mark_enemy()
{
    self endon( "death" );
    self endon( "mark_and_execute_off" );
    self notify( "marked" );
    level notify( "new_enemy_marked" );
    thread maps\_tagging::tag_enemy( level.player );
    level.marked_enemy = self;
    thread marked_enemy_death_cleanup();
    thread marked_enemy_marker();
    thread can_shoot_enemy_monitor();
}

unmark_enemy()
{
    self endon( "death" );
    self endon( "mark_and_execute_off" );
    self notify( "unmarked" );
    level.executer.can_shoot_enemy = undefined;
    level.marked_enemy = undefined;
}

execute_monitor()
{
    self endon( "death" );
    self endon( "mark_and_execute_off" );

    for (;;)
    {
        var_0 = common_scripts\utility::waittill_any_return( "execute", "weapon_fired" );

        if ( var_0 == "weapon_fired" )
        {
            var_1 = bullettrace( self geteye(), self geteye() + anglestoforward( self getangles() ) * 50000, 1, self, 0, 0, 0, 0, 0 );

            if ( isdefined( var_1["entity"] ) )
            {
                var_2 = var_1["entity"];

                if ( isai( var_2 ) && isenemyteam( var_2.team, self.team ) )
                    attempt_execute();
            }
        }
        else if ( var_0 == "execute" )
            attempt_execute();

        wait 0.05;
    }
}

attempt_execute()
{
    level.player endon( "death" );
    level.player endon( "mark_and_execute_off" );
    level endon( "new_enemy_marked" );
    level notify( "new_execute_attempted" );
    level endon( "new_execute_attempted" );

    if ( isdefined( level.marked_enemy ) && isalive( level.marked_enemy ) && isdefined( level.executer ) )
    {
        if ( isdefined( level.executer.can_shoot_enemy ) && level.executer.can_shoot_enemy == 1 && isdefined( level.executer.shoot_tag ) )
        {
            var_0 = level.marked_enemy;
            level.marked_enemy.health = 1;
            magicbullet( "rsass_silenced", level.executer.origin, var_0 gettagorigin( level.executer.shoot_tag ) );
            wait 0.1;

            if ( isdefined( var_0 ) && isalive( var_0 ) )
                var_0 kill( level.executer.origin );

            wait 0.1;
            var_1 = common_scripts\utility::random( level.generic_target_down_vo_lines );
            thread mark_and_execute_vo_controller( var_1 );
        }
        else if ( isdefined( level.player_blocking_shot ) && level.player_blocking_shot == 1 )
        {
            var_1 = common_scripts\utility::random( level.player_blocking_shot_vo_lines );
            thread mark_and_execute_vo_controller( var_1 );
        }
        else
        {
            var_1 = common_scripts\utility::random( level.generic_no_shot_vo_lines );
            thread mark_and_execute_vo_controller( var_1 );
        }
    }
}

can_shoot_enemy_monitor()
{
    self endon( "death" );
    self endon( "unmarked" );
    level.player endon( "death" );
    level.player endon( "mark_and_execute_off" );
    var_0 = common_scripts\utility::random( level.generic_target_acquired_vo_lines );
    thread mark_and_execute_vo_controller( var_0 );

    for (;;)
    {
        if ( isdefined( level.marked_enemy ) && isalive( level.marked_enemy ) )
        {
            var_1 = bullettrace( level.executer.origin, level.marked_enemy gettagorigin( "j_head" ), 1, level.executer, 0, 1, 1, 0, 0 );

            if ( isdefined( var_1["entity"] ) && var_1["entity"] == level.marked_enemy )
            {
                level.hud_execute.color = ( 0, 1, 0 );
                level.executer.can_shoot_enemy = 1;
                level.executer.shoot_tag = "j_head";
                level.player_blocking_shot = 0;
            }
            else if ( isdefined( var_1["entity"] ) && var_1["entity"] == level.player )
            {
                level.player_blocking_shot = 1;
                level.hud_execute.color = ( 1, 0, 0 );
                level.executer.can_shoot_enemy = undefined;
                level.executer.shoot_tag = undefined;
            }
            else
            {
                var_1 = bullettrace( level.executer.origin, level.marked_enemy gettagorigin( "j_SpineUpper" ), 1, level.executer, 0, 1, 1, 0, 0 );

                if ( isdefined( var_1["entity"] ) && var_1["entity"] == level.marked_enemy )
                {
                    level.hud_execute.color = ( 0, 1, 0 );
                    level.executer.can_shoot_enemy = 1;
                    level.executer.shoot_tag = "j_SpineUpper";
                    level.player_blocking_shot = 0;
                }
                else if ( isdefined( var_1["entity"] ) && var_1["entity"] == level.player )
                {
                    level.player_blocking_shot = 1;
                    level.hud_execute.color = ( 1, 0, 0 );
                    level.executer.can_shoot_enemy = undefined;
                    level.executer.shoot_tag = undefined;
                }
                else
                {
                    var_1 = bullettrace( level.executer.origin, level.marked_enemy gettagorigin( "J_SpineLower" ), 1, level.executer, 0, 1, 1, 0, 0 );

                    if ( isdefined( var_1["entity"] ) && var_1["entity"] == level.marked_enemy )
                    {
                        level.hud_execute.color = ( 0, 1, 0 );
                        level.executer.can_shoot_enemy = 1;
                        level.executer.shoot_tag = "J_SpineLower";
                        level.player_blocking_shot = 0;
                    }
                    else if ( isdefined( var_1["entity"] ) && var_1["entity"] == level.player )
                    {
                        level.player_blocking_shot = 1;
                        level.hud_execute.color = ( 1, 0, 0 );
                        level.executer.can_shoot_enemy = undefined;
                        level.executer.shoot_tag = undefined;
                    }
                    else
                    {
                        level.hud_execute.color = ( 1, 0, 0 );
                        level.executer.can_shoot_enemy = undefined;
                        level.executer.shoot_tag = undefined;
                    }
                }
            }
        }

        wait 0.05;
    }
}

marked_enemy_death_cleanup()
{
    level.player endon( "death" );
    level.player endon( "mark_and_execute_off" );
    self endon( "unmarked" );
    self waittill( "death" );
    level.hud_execute.color = ( 1, 0, 0 );
    level.executer.can_shoot_enemy = undefined;
    level.executer.shoot_tag = undefined;
}

marked_enemy_marker()
{
    level.player endon( "death" );
    level.player endon( "mark_and_execute_off" );
    self endon( "unmarked" );
    self endon( "death" );

    while ( isdefined( self ) && isalive( self ) )
    {
        var_0 = distance( level.player.origin, self.origin );
        var_1 = 1500;
        var_2 = 0;
        var_3 = 0.25;
        var_4 = 3.0;
        var_5 = var_1 - var_2;
        var_0 = clamp( var_0 - var_2, 0, var_5 );
        var_6 = var_3 + var_0 / var_5 * ( var_4 - var_3 );
        wait 0.05;
    }
}

setup_generic_target_acquired_vo()
{
    level.generic_target_acquired_vo_lines = [];
    level.generic_target_acquired_vo_lines[0] = spawnstruct();
    level.generic_target_acquired_vo_lines[0].vo = "ie_iln_targetacquired";
    level.generic_target_acquired_vo_lines[0].vo_priority = 1;
    level.generic_target_acquired_vo_lines[1] = spawnstruct();
    level.generic_target_acquired_vo_lines[1].vo = "ie_iln_gothim";
    level.generic_target_acquired_vo_lines[1].vo_priority = 1;
    level.generic_target_acquired_vo_lines[2] = spawnstruct();
    level.generic_target_acquired_vo_lines[2].vo = "ie_iln_trackingtarget";
    level.generic_target_acquired_vo_lines[2].vo_priority = 1;
    level.generic_target_acquired_vo_lines[3] = spawnstruct();
    level.generic_target_acquired_vo_lines[3].vo = "ie_iln_watchyingtarget";
    level.generic_target_acquired_vo_lines[3].vo_priority = 1;
}

setup_generic_no_shot_vo()
{
    level.generic_no_shot_vo_lines = [];
    level.generic_no_shot_vo_lines[0] = spawnstruct();
    level.generic_no_shot_vo_lines[0].vo = "ie_iln_noshot";
    level.generic_no_shot_vo_lines[0].vo_priority = 2;
    level.generic_no_shot_vo_lines[1] = spawnstruct();
    level.generic_no_shot_vo_lines[1].vo = "ie_iln_idonthaveashot";
    level.generic_no_shot_vo_lines[1].vo_priority = 2;
    level.generic_no_shot_vo_lines[2] = spawnstruct();
    level.generic_no_shot_vo_lines[2].vo = "ie_iln_donthaveashot";
    level.generic_no_shot_vo_lines[2].vo_priority = 2;
    level.generic_no_shot_vo_lines[3] = spawnstruct();
    level.generic_no_shot_vo_lines[3].vo = "ie_iln_donthavehim";
    level.generic_no_shot_vo_lines[3].vo_priority = 2;
    level.generic_no_shot_vo_lines[4] = spawnstruct();
    level.generic_no_shot_vo_lines[4].vo = "ie_iln_targetobstructed";
    level.generic_no_shot_vo_lines[4].vo_priority = 2;
    level.generic_no_shot_vo_lines[5] = spawnstruct();
    level.generic_no_shot_vo_lines[5].vo = "ie_iln_noclearshot";
    level.generic_no_shot_vo_lines[5].vo_priority = 2;
    level.generic_no_shot_vo_lines[6] = spawnstruct();
    level.generic_no_shot_vo_lines[6].vo = "ie_iln_outofsight";
    level.generic_no_shot_vo_lines[6].vo_priority = 2;
    level.generic_no_shot_vo_lines[7] = spawnstruct();
    level.generic_no_shot_vo_lines[7].vo = "ie_iln_outofview";
    level.generic_no_shot_vo_lines[7].vo_priority = 2;
}

setup_player_blocking_shot_vo()
{
    level.player_blocking_shot_vo_lines = [];
    level.player_blocking_shot_vo_lines[0] = spawnstruct();
    level.player_blocking_shot_vo_lines[0].vo = "ie_iln_mitchellblockingmyshot";
    level.player_blocking_shot_vo_lines[0].vo_priority = 0;
    level.player_blocking_shot_vo_lines[1] = spawnstruct();
    level.player_blocking_shot_vo_lines[1].vo = "ie_iln_blockingmyshot";
    level.player_blocking_shot_vo_lines[1].vo_priority = 0;
    level.player_blocking_shot_vo_lines[2] = spawnstruct();
    level.player_blocking_shot_vo_lines[2].vo = "ie_iln_moveoutoftheway";
    level.player_blocking_shot_vo_lines[2].vo_priority = 0;
    level.player_blocking_shot_vo_lines[3] = spawnstruct();
    level.player_blocking_shot_vo_lines[3].vo = "ie_iln_getoutoftheway";
    level.player_blocking_shot_vo_lines[3].vo_priority = 0;
}

setup_generic_target_down_vo()
{
    level.generic_target_down_vo_lines = [];
    level.generic_target_down_vo_lines[0] = spawnstruct();
    level.generic_target_down_vo_lines[0].vo = "ie_iln_targetsdown";
    level.generic_target_down_vo_lines[0].vo_priority = 2;
    level.generic_target_down_vo_lines[1] = spawnstruct();
    level.generic_target_down_vo_lines[1].vo = "ie_iln_hesdown";
    level.generic_target_down_vo_lines[1].vo_priority = 2;
    level.generic_target_down_vo_lines[2] = spawnstruct();
    level.generic_target_down_vo_lines[2].vo = "ie_iln_igothim";
    level.generic_target_down_vo_lines[2].vo_priority = 2;
    level.generic_target_down_vo_lines[3] = spawnstruct();
    level.generic_target_down_vo_lines[3].vo = "ie_iln_targetneutralized";
    level.generic_target_down_vo_lines[3].vo_priority = 2;
}

setup_generic_taking_the_shot_vo()
{
    level.generic_taking_the_shot_vo_lines = [];
    level.generic_taking_the_shot_vo_lines[0] = spawnstruct();
    level.generic_taking_the_shot_vo_lines[0].vo = "ie_iln_takingshot";
    level.generic_taking_the_shot_vo_lines[0].vo_priority = 0;
}

mark_and_execute_vo_controller( var_0 )
{
    level.player endon( "death" );
    level.player endon( "mark_and_execute_off" );
    level endon( "meet_cormack_end" );

    if ( isdefined( level.play_ilana_vo ) && level.play_ilana_vo == 1 )
    {
        if ( isdefined( level.current_vo ) && isdefined( var_0.vo_priority ) && var_0.vo_priority > level.current_vo.vo_priority )
        {
            level.ilana_vo_org stopsounds();
            wait 0.05;
            level.current_vo = var_0;
            level.ilana_vo_org playsound( var_0.vo, "sounddone", 1 );
            level.ilana_vo_org waittill( "sounddone" );
            wait 0.5;
            level.current_vo = undefined;
        }
        else if ( !isdefined( level.current_vo ) )
        {
            level.current_vo = var_0;
            level.ilana_vo_org playsound( var_0.vo, "sounddone", 1 );
            level.ilana_vo_org waittill( "sounddone" );
            wait 0.5;
            level.current_vo = undefined;
        }
    }
}
