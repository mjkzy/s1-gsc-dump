// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

spawn_player_checkpoint()
{
    var_0 = level.start_point + "_start";
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );

    if ( isdefined( var_1 ) )
    {
        level.player setorigin( var_1.origin );

        if ( isdefined( var_1.angles ) )
            level.player setangles( var_1.angles );
        else
            iprintlnbold( "Your script_struct " + level.start_point + "_start has no angles! Set some." );
    }
    else
    {

    }

    level.player maps\irons_estate_stealth::irons_estate_stealth_custom();
}

spawn_allies()
{
    level.allies = [];

    if ( level.start_point_scripted == "briefing" )
    {
        level.allies[0] = spawn_ally( "cormack_briefing" );
        level.allies[0].animname = "cormack";
        level.allies[0] thread set_helmet_open();
        level.allies[1] = spawn_ally( "ilana_briefing" );
        level.allies[1].animname = "ilana";
        level.allies[2] = spawn_ally( "knox_briefing" );
        level.allies[2].animname = "knox";
        level.allies[2] thread set_helmet_open();
    }
    else
    {
        if ( level.start_point_scripted == "intro" || level.start_point_scripted == "grapple" || level.start_point_scripted == "recon" || level.start_point_scripted == "intel" || level.start_point_scripted == "infil_hangar" || level.start_point_scripted == "hangar" || level.start_point_scripted == "plant_tracker" )
        {
            level.allies[0] = spawn_ally( "cormack" );
            level.allies[0].animname = "cormack";
            level.allies[0] thread set_helmet_open();
        }

        if ( level.start_point_scripted == "intro" || level.start_point_scripted == "grapple" || level.start_point_scripted == "recon" )
        {
            level.allies[1] = spawn_ally( "ilana" );
            level.allies[1].animname = "ilana";
        }

        if ( level.start_point_scripted == "intro" || level.start_point_scripted == "grapple" || level.start_point_scripted == "recon" || level.start_point_scripted == "infil" )
        {
            level.allies[2] = spawn_ally( "knox" );
            level.allies[2].animname = "knox";
            level.allies[2] thread set_helmet_open();
        }
    }
}

spawn_ally( var_0, var_1 )
{
    var_2 = undefined;

    if ( !isdefined( var_1 ) )
        var_2 = level.start_point_scripted + "_" + var_0;
    else
        var_2 = var_1 + "_" + var_0;

    var_3 = spawn_targetname_at_struct_targetname( var_0, var_2 );

    if ( !isdefined( var_3 ) )
        return undefined;

    var_3 maps\_utility::make_hero();

    if ( !isdefined( var_3.magic_bullet_shield ) )
        var_3 maps\_utility::magic_bullet_shield();

    var_3.grenadeammo = 0;
    var_3 pushplayer( 1 );
    var_3 pathabilityadd( "grapple" );
    return var_3;
}

helmet_open( var_0 )
{
    var_0 thread set_helmet_open();
}

helmet_close( var_0 )
{
    var_0 thread set_helmet_closed();
}

#using_animtree("generic_human");

set_helmet_open( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.2;

    self setanimknobrestart( %sentinel_halo_helmet_open, 1, var_0 );
    self.helmet_open = 1;
}

set_helmet_closed( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.2;

    self setanimrestart( %sentinel_halo_helmet_close, 1, var_0 );
    self.helmet_open = 0;
}

clear_additive_helmet_anim( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    self clearanim( %s1_halo_helmet, 0 );
}

spawn_targetname_at_struct_targetname( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = common_scripts\utility::getstruct( var_1, "targetname" );

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
    {
        var_2.origin = var_3.origin;

        if ( isdefined( var_3.angles ) )
            var_2.angles = var_3.angles;

        var_4 = var_2 maps\_utility::spawn_ai( 1 );
        return var_4;
    }

    if ( isdefined( var_2 ) )
    {
        var_4 = var_2 maps\_utility::spawn_ai( 1 );
        iprintlnbold( "Add a script struct called: " + var_1 + " to spawn him in the correct location." );
        var_4 teleport( level.player.origin, level.player.angles );
        return var_4;
    }

    iprintlnbold( "failed to spawn " + var_0 + " at " + var_1 );
    return undefined;
}

handle_objective_marker( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 50;

    var_4 = var_0 maps\_shg_utility::hint_button_trigger( "x", var_3 );
    common_scripts\utility::flag_wait( var_2 );
    var_4 maps\_shg_utility::hint_button_clear();
}

irons_estate_trigger_saves( var_0, var_1 )
{
    level endon( var_0 );
    common_scripts\utility::flag_wait( var_1 );
    maps\_utility::autosave_stealth();
}

corpse_cleanup()
{
    waitframe();
    var_0 = getcorpsearray();

    foreach ( var_2 in var_0 )
    {
        if ( distancesquared( var_2.origin, level.player.origin ) > 4000000 )
            var_2 delete();
    }
}

temp_dialogue( var_0, var_1, var_2 )
{
    level notify( "temp_dialogue", var_0, var_1, var_2 );
    level endon( "temp_dialogue" );

    if ( !isdefined( var_2 ) )
        var_2 = 4;

    if ( isdefined( level.tmp_subtitle ) )
    {
        level.tmp_subtitle destroy();
        level.tmp_subtitle = undefined;
    }

    level.tmp_subtitle = newhudelem();
    level.tmp_subtitle.x = 0;
    level.tmp_subtitle.y = -90;
    level.tmp_subtitle settext( "^2" + var_0 + ": ^7" + var_1 );
    level.tmp_subtitle.fontscale = 1.46;
    level.tmp_subtitle.alignx = "center";
    level.tmp_subtitle.aligny = "middle";
    level.tmp_subtitle.horzalign = "center";
    level.tmp_subtitle.vertalign = "bottom";
    level.tmp_subtitle.sort = 1;
    wait(var_2);
    thread temp_dialogue_fade();
}

temp_dialogue_fade()
{
    level endon( "temp_dialogue" );

    for ( var_0 = 1.0; var_0 > 0.0; var_0 -= 0.1 )
    {
        level.tmp_subtitle.alpha = var_0;
        wait 0.05;
    }

    level.tmp_subtitle destroy();
}

generic_enemy_vo_chatter( var_0 )
{
    level endon( var_0 );
    var_1 = [];
    var_1[0] = "ie_as1_sectorclear1";
    var_1[1] = "ie_as2_zeroactivity1";
    var_1[2] = "ie_as3_shiftchange";
    var_1[3] = "ie_as1_whatssitrep1";
    var_1[4] = "ie_as2_headingthere";
    var_1[5] = "ie_as3_barnesisoff";
    var_1[6] = "ie_as1_deltacheckingin";
    var_1[7] = "ie_as2_rodgersonhisway";
    var_1[8] = "ie_as3_statusgreen";
    var_1[9] = "ie_as1_sendingescort";
    var_1[10] = "ie_as2_rendesvousin10";
    var_1[11] = "ie_as1_cough1";
    var_1[12] = "ie_as1_cough2";
    var_1[13] = "ie_as1_throat1";
    var_1[14] = "ie_as1_throat2";
    var_1[15] = "ie_as2_cough1";
    var_1[16] = "ie_as2_cough2";
    var_1[17] = "ie_as2_throat1";
    var_1[18] = "ie_as2_throat2";
    var_1[19] = "ie_as3_cough1";
    var_1[20] = "ie_as3_cough2";
    var_1[21] = "ie_as3_throat1";
    var_1[22] = "ie_as3_throat2";
    level.enemy_vo_array_one_off = [];
    var_1[23] = "ie_as1_eastlawn";
    level.enemy_vo_array_one_off[0] = var_1[23];
    var_1[24] = "ie_as2_allsquiet";
    level.enemy_vo_array_one_off[1] = var_1[24];
    var_1[25] = "ie_as3_aircraft";
    level.enemy_vo_array_one_off[2] = var_1[25];
    var_1[26] = "ie_as1_partguests";
    level.enemy_vo_array_one_off[3] = var_1[26];
    level.enemy_vo_array_conversation_1 = [];
    level.enemy_vo_array_conversation_2 = [];
    var_1[27] = "ie_as3_stausofparty";
    level.enemy_vo_array_conversation_1[0] = var_1[27];
    level.enemy_vo_array_conversation_2[0] = "ie_as1_behaving";
    var_1[28] = "ie_as2_droneglitching";
    level.enemy_vo_array_conversation_1[1] = var_1[28];
    level.enemy_vo_array_conversation_2[1] = "ie_as1_onhisway";
    var_1[29] = "ie_as1_ironsassistant";
    level.enemy_vo_array_conversation_1[2] = var_1[29];
    level.enemy_vo_array_conversation_2[2] = "ie_as3_expectingher";
    var_1[30] = "ie_as3_southwestgate";
    level.enemy_vo_array_conversation_1[3] = var_1[30];
    level.enemy_vo_array_conversation_2[3] = "ie_as1_allclear1";
    var_2 = -1;
    var_3 = undefined;

    for (;;)
    {
        wait 0.05;
        var_4 = getaiarray( "axis" );

        foreach ( var_6 in var_4 )
        {
            if ( isdefined( var_6.stop_generic_vo_chatter ) )
                var_6 = common_scripts\utility::array_remove( var_4, var_6 );
        }

        var_4 = maps\_utility::remove_dead_from_array( var_4 );

        if ( var_4.size == 0 )
            return;

        var_6 = maps\_utility::get_closest_living( level.player.origin, var_4 );

        if ( !isdefined( var_6.vo_chatter_death ) )
        {
            var_6 endon( "death" );
            var_6.vo_chatter_death = 1;
        }

        if ( distancesquared( var_6.origin, level.player.origin ) > 360000 )
            continue;

        if ( isdefined( level.last_enemy_chatter_vo ) )
        {
            var_8 = gettime() - level.last_enemy_chatter_vo;

            if ( var_8 < 15000 )
                continue;
        }

        if ( common_scripts\utility::flag( "_stealth_spotted" ) )
            continue;

        if ( isdefined( var_6.alerted ) )
        {
            var_6.last_alert_time = gettime();
            continue;
        }

        if ( var_6.alertlevel == "alert" || isdefined( var_6.event_type ) )
        {
            var_6.last_alert_time = gettime();
            continue;
        }

        if ( var_6.alertlevel == "noncombat" || !isdefined( var_6.event_type || !isdefined( var_6.alerted ) ) )
        {
            if ( isdefined( var_6.last_alert_time ) )
            {
                var_8 = gettime() - var_6.last_alert_time;

                if ( var_8 < 15000 )
                    continue;
            }
        }

        if ( isdefined( var_6.isbeinggrappled ) )
            continue;

        var_9 = randomint( var_1.size );

        if ( var_9 == var_2 )
        {
            var_9++;

            if ( var_9 >= var_1.size )
                var_9 = 0;
        }

        var_10 = var_1[var_9];

        if ( !isdefined( var_6.animname ) )
            var_6.animname = "generic";

        thread check_vo_type( var_10 );
        level waittill( "vo_type_defined", var_11 );

        if ( var_11 == "one_off" )
        {
            var_6 maps\_utility::play_sound_on_entity( var_10 );
            var_1 = common_scripts\utility::array_remove( var_1, var_10 );
        }
        else if ( var_11 == "conversation" )
        {
            var_6 maps\_utility::play_sound_on_entity( var_10 );
            var_1 = common_scripts\utility::array_remove( var_1, var_10 );
            var_6 maps\_utility::play_sound_on_entity( level.conversation_response );
        }
        else
        {
            var_6.saying_vo = 1;
            var_6 thread stop_generic_enemy_vo_chatter();
            var_6 maps\_utility::smart_dialogue( var_10 );
            var_6.saying_vo = undefined;
        }

        var_2 = var_9;
        var_3 = var_6;
        level.last_enemy_chatter_vo = gettime();
    }
}

stop_generic_enemy_vo_chatter()
{
    self endon( "death" );

    while ( isdefined( self.saying_vo ) )
    {
        if ( isdefined( self.isbeinggrappled ) || common_scripts\utility::flag( "_stealth_spotted" ) || isdefined( self.alerted ) )
        {
            self notify( "stop_sound" );
            self stopsounds();
            break;
        }

        waitframe();
    }
}

check_vo_type( var_0 )
{
    waitframe();

    if ( common_scripts\utility::array_contains( level.enemy_vo_array_one_off, var_0 ) )
    {
        var_1 = "one_off";
        level notify( "vo_type_defined", var_1 );
    }
    else if ( common_scripts\utility::array_contains( level.enemy_vo_array_conversation_1, var_0 ) )
    {
        level.conversation_index = undefined;
        level.conversation_response = undefined;

        for ( var_2 = 0; var_2 < level.enemy_vo_array_conversation_1.size; var_2++ )
        {
            if ( level.enemy_vo_array_conversation_1[var_2] == var_0 )
            {
                level.conversation_index = var_2;
                break;
            }
        }

        for ( var_2 = 0; var_2 < level.enemy_vo_array_conversation_2.size; var_2++ )
        {
            if ( var_2 == level.conversation_index )
            {
                level.conversation_response = level.enemy_vo_array_conversation_2[var_2];
                break;
            }
        }

        var_1 = "conversation";
        level notify( "vo_type_defined", var_1 );
    }
    else
    {
        var_1 = "normal";
        level notify( "vo_type_defined", var_1 );
    }
}

enemy_callout_vo_setup( var_0 )
{
    level.enemy_left = [];
    level.enemy_left[0] = spawnstruct();
    level.enemy_left[0].vo = "ie_" + var_0 + "_tangoleft1";
    level.enemy_left[0].vo_priority = 1;
    level.enemy_left[1] = spawnstruct();
    level.enemy_left[1].vo = "ie_" + var_0 + "_targetleft1";
    level.enemy_left[1].vo_priority = 1;
    level.civilian_left = [];
    level.civilian_left[0] = spawnstruct();
    level.civilian_left[0].vo = "ie_" + var_0 + "_civleft";
    level.civilian_left[0].vo_priority = 1;
    level.enemies_left[0] = spawnstruct();
    level.enemies_left[0].vo = "ie_" + var_0 + "_tangosleft1";
    level.enemies_left[0].vo_priority = 1;
    level.enemies_left[1] = spawnstruct();
    level.enemies_left[1].vo = "ie_" + var_0 + "_targetsleft1";
    level.enemies_left[1].vo_priority = 1;
    level.civilians_left = [];
    level.civilians_left[0] = spawnstruct();
    level.civilians_left[0].vo = "ie_" + var_0 + "_civsleft";
    level.civilians_left[0].vo_priority = 1;
    level.enemy_right = [];
    level.enemy_right[0] = spawnstruct();
    level.enemy_right[0].vo = "ie_" + var_0 + "_tangoright1";
    level.enemy_right[0].vo_priority = 1;
    level.enemy_right[1] = spawnstruct();
    level.enemy_right[1].vo = "ie_" + var_0 + "_targetright1";
    level.enemy_right[1].vo_priority = 1;
    level.civilian_right = [];
    level.civilian_right[0] = spawnstruct();
    level.civilian_right[0].vo = "ie_" + var_0 + "_civright";
    level.civilian_right[0].vo_priority = 1;
    level.enemies_right[0] = spawnstruct();
    level.enemies_right[0].vo = "ie_" + var_0 + "_tangosright1";
    level.enemies_right[0].vo_priority = 1;
    level.enemies_right[1] = spawnstruct();
    level.enemies_right[1].vo = "ie_" + var_0 + "_targetsright1";
    level.enemies_right[1].vo_priority = 1;
    level.civilians_right = [];
    level.civilians_right[0] = spawnstruct();
    level.civilians_right[0].vo = "ie_" + var_0 + "_civsright";
    level.civilians_right[0].vo_priority = 1;
    level.enemy_below = [];
    level.enemy_below[0] = spawnstruct();
    level.enemy_below[0].vo = "ie_" + var_0 + "_tangobelow1";
    level.enemy_below[0].vo_priority = 1;
    level.enemy_below[1] = spawnstruct();
    level.enemy_below[1].vo = "ie_" + var_0 + "_hostilebelow1";
    level.enemy_below[1].vo_priority = 1;
    level.civilian_below = [];
    level.civilian_below[0] = spawnstruct();
    level.civilian_below[0].vo = "ie_" + var_0 + "_civbelow";
    level.civilian_below[0].vo_priority = 1;
    level.enemies_below = [];
    level.enemies_below[0] = spawnstruct();
    level.enemies_below[0].vo = "ie_" + var_0 + "_tangosbelow1";
    level.enemies_below[0].vo_priority = 1;
    level.enemies_below[1] = spawnstruct();
    level.enemies_below[1].vo = "ie_" + var_0 + "_hostilesbelow1";
    level.enemies_below[1].vo_priority = 1;
    level.civilians_below = [];
    level.civilians_below[0] = spawnstruct();
    level.civilians_below[0].vo = "ie_" + var_0 + "_civsbelow";
    level.civilians_below[0].vo_priority = 1;
}

enemy_callout_vo( var_0 )
{
    level endon( "poolyard_save" );
    level endon( "bedroom_start" );
    enemy_callout_vo_setup( var_0 );
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 15;
    var_6 = 10000;
    var_7 = 60;
    var_8 = undefined;
    var_9 = 0;

    for (;;)
    {
        for (;;)
        {
            wait 0.5;
            var_10 = getaiarray( "axis" );
            level.active_civilians = maps\_utility::remove_dead_from_array( level.active_civilians );
            var_11 = common_scripts\utility::array_combine( level.active_civilians, var_10 );
            var_12 = maps\_utility::get_closest_living( level.player.origin, var_11, 500 );

            if ( !isdefined( var_12 ) )
                continue;

            if ( var_12.classname == "actor_enemy_atlas_bodyguard_smg" || var_12.classname == "actor_enemy_atlas_pmc_estate_smg" )
                var_13 = "enemy";
            else
                var_13 = "civilian";

            if ( isdefined( var_8 ) && var_12 == var_8 )
                continue;

            if ( isdefined( var_12.isbeinggrappled ) )
                continue;

            if ( !isdefined( level.play_ally_callout_vo ) )
                continue;

            if ( !check_player_in_stop_enemy_callout_vo_volume() )
                continue;

            if ( level.player.grapple["grappling"] == 1 )
                continue;

            if ( isdefined( var_12.alerted ) )
                continue;

            if ( common_scripts\utility::flag( "_stealth_spotted" ) )
                continue;

            if ( player_can_see_ai_through_foliage( var_12 ) && !isdefined( var_12.hasbeencalledout ) )
            {
                var_9++;

                if ( var_9 == 2 )
                {
                    if ( var_13 == "enemy" )
                    {
                        var_12.hasbeencalledout = 1;
                        var_12 thread entity_has_been_called_out_timer( var_7 );
                    }
                    else if ( isdefined( var_12.script_aigroup ) )
                    {
                        var_14 = maps\_utility::get_ai_group_ai( var_12.script_aigroup );

                        foreach ( var_16 in var_14 )
                        {
                            if ( !isdefined( var_16.hasbeencalledout ) )
                            {
                                var_16.hasbeencalledout = 1;
                                var_16 thread entity_has_been_called_out_timer( var_7 );
                            }
                        }
                    }
                    else
                    {
                        var_12.hasbeencalledout = 1;
                        var_12 thread entity_has_been_called_out_timer( var_7 );
                    }

                    var_9 = 0;
                }
                else
                {
                    wait 0.5;
                    continue;
                }
            }
            else
                var_9 = 0;

            if ( isdefined( var_12.hasbeencalledout ) )
                continue;

            var_18 = level.player.origin;
            var_19 = level.player.angles;
            var_20 = var_12.origin;
            var_21 = vectornormalize( var_20 - var_18 );
            var_22 = anglestoforward( var_19 );
            var_23 = vectordot( var_22, var_21 );
            var_24 = gettime();

            if ( var_23 >= 0.77 )
            {
                if ( var_24 > var_1 + var_6 )
                {
                    var_25 = level.player.origin[2] - var_12.origin[2];

                    if ( var_25 > 100 )
                    {
                        if ( var_12.origin[2] > level.player.origin[2] )
                            continue;
                        else
                        {
                            if ( isdefined( var_12.no_below_vo ) )
                                continue;

                            if ( var_13 == "enemy" )
                            {
                                var_26 = [];
                                var_26 = common_scripts\utility::array_combine( var_26, var_10 );
                                var_26 = common_scripts\utility::array_remove( var_26, var_12 );
                                var_27 = level.enemy_below;
                                var_28 = level.enemies_below;
                            }
                            else
                            {
                                var_26 = [];
                                var_26 = common_scripts\utility::array_combine( var_26, level.active_civilians );
                                var_26 = common_scripts\utility::array_remove( var_26, var_12 );
                                var_27 = level.civilian_below;
                                var_28 = level.civilians_below;
                            }

                            var_29 = maps\_utility::get_closest_living( var_12.origin, var_26, 500 );

                            if ( isdefined( var_29 ) )
                            {
                                if ( var_13 == "enemy" )
                                {
                                    var_29.hasbeencalledout = 1;
                                    var_29 thread entity_has_been_called_out_timer( var_7 );
                                }
                                else if ( isdefined( var_12.script_aigroup ) )
                                {
                                    var_14 = maps\_utility::get_ai_group_ai( var_12.script_aigroup );

                                    foreach ( var_16 in var_14 )
                                    {
                                        if ( !isdefined( var_16.hasbeencalledout ) )
                                        {
                                            var_16.hasbeencalledout = 1;
                                            var_16 thread entity_has_been_called_out_timer( var_7 );
                                        }
                                    }
                                }
                                else
                                {
                                    var_29.hasbeencalledout = 1;
                                    var_29 thread entity_has_been_called_out_timer( var_7 );
                                }

                                var_32 = var_28[randomint( var_28.size )];
                            }
                            else
                                var_32 = var_27[randomint( var_27.size )];

                            thread ally_vo_controller( var_32 );
                            var_12.hasbeencalledout = 1;
                            var_12 thread entity_has_been_called_out_timer( var_7 );
                        }
                    }
                    else
                        continue;

                    var_1 = var_24;
                    wait(var_5);
                    var_8 = var_12;
                    break;
                }
                else
                    continue;
            }

            if ( var_23 < -0.77 )
                continue;

            var_33 = anglestoright( var_19 );
            var_34 = vectordot( var_33, var_21 );

            if ( var_34 < 0 )
            {
                if ( var_24 > var_2 + var_6 )
                {
                    var_25 = level.player.origin[2] - var_12.origin[2];

                    if ( var_25 > 100 )
                        continue;
                    else
                    {
                        var_35 = level.player geteye();
                        var_36 = var_12 gettagorigin( "tag_eye" );
                        var_37 = bullettrace( var_35, var_36, 1, level.player );
                        var_38 = var_37["entity"];
                        var_39 = isdefined( var_38 ) && var_38 == var_12;

                        if ( var_39 )
                        {
                            if ( var_13 == "enemy" )
                            {
                                var_26 = [];
                                var_26 = common_scripts\utility::array_combine( var_26, var_10 );
                                var_26 = common_scripts\utility::array_remove( var_26, var_12 );
                                var_40 = level.enemy_left;
                                var_41 = level.enemies_left;
                            }
                            else
                            {
                                var_26 = [];
                                var_26 = common_scripts\utility::array_combine( var_26, level.active_civilians );
                                var_26 = common_scripts\utility::array_remove( var_26, var_12 );
                                var_40 = level.civilian_left;
                                var_41 = level.civilians_left;
                            }

                            var_29 = maps\_utility::get_closest_living( var_12.origin, var_26, 500 );

                            if ( isdefined( var_29 ) )
                            {
                                if ( var_13 == "enemy" )
                                {
                                    var_29.hasbeencalledout = 1;
                                    var_29 thread entity_has_been_called_out_timer( var_7 );
                                }
                                else if ( isdefined( var_12.script_aigroup ) )
                                {
                                    var_14 = maps\_utility::get_ai_group_ai( var_12.script_aigroup );

                                    foreach ( var_16 in var_14 )
                                    {
                                        if ( !isdefined( var_16.hasbeencalledout ) )
                                        {
                                            var_16.hasbeencalledout = 1;
                                            var_16 thread entity_has_been_called_out_timer( var_7 );
                                        }
                                    }
                                }
                                else
                                {
                                    var_29.hasbeencalledout = 1;
                                    var_29 thread entity_has_been_called_out_timer( var_7 );
                                }

                                var_32 = var_41[randomint( var_41.size )];
                            }
                            else
                                var_32 = var_40[randomint( var_40.size )];

                            thread ally_vo_controller( var_32 );

                            if ( !isdefined( var_12.hasbeencalledout ) )
                            {
                                var_12.hasbeencalledout = 1;
                                var_12 thread entity_has_been_called_out_timer( var_7 );
                            }

                            var_2 = var_24;
                            wait(var_5);
                            var_8 = var_12;
                            break;
                        }
                        else
                            continue;
                    }
                }
                else
                    continue;

                continue;
            }

            if ( var_24 > var_3 + var_6 )
            {
                var_25 = level.player.origin[2] - var_12.origin[2];

                if ( var_25 > 100 )
                    continue;
                else
                {
                    var_35 = level.player geteye();
                    var_36 = var_12 gettagorigin( "tag_eye" );
                    var_37 = bullettrace( var_35, var_36, 1, level.player );
                    var_38 = var_37["entity"];
                    var_39 = isdefined( var_38 ) && var_38 == var_12;

                    if ( var_39 )
                    {
                        if ( var_13 == "enemy" )
                        {
                            var_26 = [];
                            var_26 = common_scripts\utility::array_combine( var_26, var_10 );
                            var_26 = common_scripts\utility::array_remove( var_26, var_12 );
                            var_44 = level.enemy_right;
                            var_45 = level.enemies_right;
                        }
                        else
                        {
                            var_26 = [];
                            var_26 = common_scripts\utility::array_combine( var_26, level.active_civilians );
                            var_26 = common_scripts\utility::array_remove( var_26, var_12 );
                            var_44 = level.civilian_right;
                            var_45 = level.civilians_right;
                        }

                        var_29 = maps\_utility::get_closest_living( var_12.origin, var_26, 500 );

                        if ( isdefined( var_29 ) )
                        {
                            if ( var_13 == "enemy" )
                            {
                                var_29.hasbeencalledout = 1;
                                var_29 thread entity_has_been_called_out_timer( var_7 );
                            }
                            else if ( isdefined( var_12.script_aigroup ) )
                            {
                                var_14 = maps\_utility::get_ai_group_ai( var_12.script_aigroup );

                                foreach ( var_16 in var_14 )
                                {
                                    if ( !isdefined( var_16.hasbeencalledout ) )
                                    {
                                        var_16.hasbeencalledout = 1;
                                        var_16 thread entity_has_been_called_out_timer( var_7 );
                                    }
                                }
                            }
                            else
                            {
                                var_29.hasbeencalledout = 1;
                                var_29 thread entity_has_been_called_out_timer( var_7 );
                            }

                            var_32 = var_45[randomint( var_45.size )];
                        }
                        else
                            var_32 = var_44[randomint( var_44.size )];

                        thread ally_vo_controller( var_32 );

                        if ( !isdefined( var_12.hasbeencalledout ) )
                        {
                            var_12.hasbeencalledout = 1;
                            var_12 thread entity_has_been_called_out_timer( var_7 );
                        }

                        var_3 = var_24;
                        wait(var_5);
                        var_8 = var_12;
                        break;
                    }
                    else
                        continue;
                }

                continue;
            }

            continue;
        }
    }
}

entity_has_been_called_out_timer( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self.hasbeencalledout = undefined;
}

player_can_see_ai_through_foliage( var_0, var_1 )
{
    var_2 = gettime();

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( isdefined( var_0.playerseesmetime ) && var_0.playerseesmetime + var_1 >= var_2 )
        return var_0.playerseesme;

    var_0.playerseesmetime = var_2;

    if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_0.origin, 0.766 ) )
    {
        var_0.playerseesme = 0;
        return 0;
    }

    var_3 = level.player geteye();
    var_4 = var_0.origin;

    if ( sighttracepassed( var_3, var_4, 1, level.player, var_0, 0 ) )
    {
        var_0.playerseesme = 1;
        return 1;
    }

    var_5 = var_0 geteye();

    if ( sighttracepassed( var_3, var_5, 1, level.player, var_0, 0 ) )
    {
        var_0.playerseesme = 1;
        return 1;
    }

    var_6 = ( var_5 + var_4 ) * 0.5;

    if ( sighttracepassed( var_3, var_6, 1, level.player, var_0, 0 ) )
    {
        var_0.playerseesme = 1;
        return 1;
    }

    var_0.playerseesme = 0;
    return 0;
}

check_player_in_stop_enemy_callout_vo_volume()
{
    var_0 = getentarray( "stop_enemy_callout_vo", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( level.player istouching( var_2 ) )
            return 0;
    }

    return 1;
}

clean_kill_vo_setup( var_0 )
{
    level.clean_kill_vo = [];
    level.sloppy_kill_vo = [];

    if ( var_0 == "iln" )
    {
        level.clean_kill_vo[0] = spawnstruct();
        level.clean_kill_vo[0].vo = "ie_iln_goodkill1";
        level.clean_kill_vo[0].vo_priority = 2;
        level.clean_kill_vo[1] = spawnstruct();
        level.clean_kill_vo[1].vo = "ie_iln_cleankill1";
        level.clean_kill_vo[1].vo_priority = 2;
        level.sloppy_kill_vo[0] = spawnstruct();
        level.sloppy_kill_vo[0].vo = "ie_iln_close3";
        level.sloppy_kill_vo[0].vo_priority = 2;
        level.sloppy_kill_vo[1] = spawnstruct();
        level.sloppy_kill_vo[1].vo = "ie_iln_goodsave";
        level.sloppy_kill_vo[1].vo_priority = 2;
    }
    else
    {
        level.clean_kill_vo[0] = spawnstruct();
        level.clean_kill_vo[0].vo = "ie_nox_cleankill2";
        level.clean_kill_vo[0].vo_priority = 2;
        level.clean_kill_vo[1] = spawnstruct();
        level.clean_kill_vo[1].vo = "ie_nox_gooddrop";
        level.clean_kill_vo[1].vo_priority = 2;
        level.sloppy_kill_vo[0] = spawnstruct();
        level.sloppy_kill_vo[0].vo = "ie_nox_closeone2";
        level.sloppy_kill_vo[0].vo_priority = 2;
        level.sloppy_kill_vo[1] = spawnstruct();
        level.sloppy_kill_vo[1].vo = "ie_nox_nicecleanup";
        level.sloppy_kill_vo[1].vo_priority = 2;
    }
}

clean_kill_vo( var_0 )
{
    level endon( "emp_detonated" );
    level endon( "bedroom_end" );
    clean_kill_vo_setup( var_0 );
    var_1 = 20;

    for (;;)
    {
        common_scripts\utility::flag_wait_either( "clean_kill", "sloppy_kill" );

        if ( common_scripts\utility::flag( "clean_kill" ) )
        {
            if ( isdefined( level.clean_kill_vo ) )
            {
                var_2 = common_scripts\utility::random( level.clean_kill_vo );
                thread ally_vo_controller( var_2 );
            }
        }
        else if ( isdefined( level.sloppy_kill_vo ) )
        {
            var_2 = common_scripts\utility::random( level.sloppy_kill_vo );
            thread ally_vo_controller( var_2 );
        }

        wait(var_1);
        common_scripts\utility::flag_clear( "clean_kill" );
        common_scripts\utility::flag_clear( "sloppy_kill" );
        waitframe();
    }
}

watch_for_death()
{
    self waittill( "death", var_0 );

    if ( isdefined( self ) && isdefined( var_0 ) )
    {
        var_1 = self geteye();
        var_2 = getaiarray( "axis", "neutral" );
        var_2 = common_scripts\utility::get_array_of_closest( var_1, var_2, undefined, undefined, 500, undefined );

        foreach ( var_4 in var_2 )
        {
            if ( var_4.ignoreall )
                continue;

            if ( var_4.team == "neutral" && !var_4 maps\irons_estate_stealth::witness_kill_valid( var_1 ) )
                continue;

            var_4 notify( "witness_kill", var_1 );
        }
    }

    if ( isdefined( self.script_parameters ) && self.script_parameters == "exposed_group" || isdefined( self.script_noteworthy ) && self.script_noteworthy == "exposed_group" )
    {
        var_6 = maps\_stealth_shared_utilities::group_get_ai_in_group( self.script_stealthgroup );

        foreach ( var_8 in var_6 )
        {
            if ( isdefined( var_8.script_parameters ) && var_8.script_parameters == "exposed_group" )
                var_8.script_parameters = undefined;
            else if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "exposed_group" )
                var_8.script_noteworthy = undefined;

            var_8.was_in_exposed_group = 1;
        }

        if ( !common_scripts\utility::flag( "HINT_DECOY_STOP" ) )
        {
            common_scripts\utility::flag_set( "HINT_DECOY_STOP" );
            var_10 = undefined;
        }
    }

    if ( isdefined( var_0 ) && var_0 == level.player || isdefined( self.isbeinggrappled ) )
    {
        level.death_counter++;

        if ( isdefined( self.was_in_exposed_group ) )
            return;

        wait 1.0;

        if ( !common_scripts\utility::flag( "someone_became_alert" ) && !common_scripts\utility::flag( "_stealth_spotted" ) && check_enemies_for_alert() && !common_scripts\utility::flag( "drones_investigating" ) )
        {
            if ( isdefined( level.play_ally_callout_vo ) )
            {
                if ( !common_scripts\utility::flag( "clean_kill" ) )
                    common_scripts\utility::flag_set( "clean_kill" );
            }
        }
        else if ( ( common_scripts\utility::flag( "someone_became_alert" ) || common_scripts\utility::flag( "_stealth_spotted" ) ) && check_enemies_for_alert() && !common_scripts\utility::flag( "drones_investigating" ) )
        {
            if ( isdefined( level.play_ally_callout_vo ) )
            {
                if ( !common_scripts\utility::flag( "sloppy_kill" ) )
                    common_scripts\utility::flag_set( "sloppy_kill" );
            }
        }
    }
}

check_enemies_for_alert()
{
    var_0 = getaiarray( "axis" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.alerted ) )
            return 0;
    }

    return 1;
}

dont_shoot_warning_vo_setup( var_0 )
{
    level.drone_warning_vo = [];
    level.civilian_warning_vo = [];
    level.exposed_guard_warning_vo = [];

    if ( var_0 == "iln" )
    {
        level.drone_warning_vo[0] = spawnstruct();
        level.drone_warning_vo[0].vo = "ie_iln_alertdrones";
        level.drone_warning_vo[0].vo_priority = 2;
        level.drone_warning_vo[1] = spawnstruct();
        level.drone_warning_vo[1].vo = "ie_iln_dontshoot5";
        level.drone_warning_vo[1].vo_priority = 2;
        level.civilian_warning_vo[0] = spawnstruct();
        level.civilian_warning_vo[0].vo = "ie_iln_civiliancasualties";
        level.civilian_warning_vo[0].vo_priority = 2;

        if ( level.start_point_scripted == "meet_cormack" )
        {
            level.exposed_guard_warning_vo[0] = spawnstruct();
            level.exposed_guard_warning_vo[0].vo = "ie_iln_hesopen";
            level.exposed_guard_warning_vo[0].vo_priority = 2;
        }
        else
        {
            level.exposed_guard_warning_vo[0] = spawnstruct();
            level.exposed_guard_warning_vo[0].vo = "ie_iln_hesopen";
            level.exposed_guard_warning_vo[0].vo_priority = 2;
            level.exposed_guard_warning_vo[1] = spawnstruct();
            level.exposed_guard_warning_vo[1].vo = "ie_iln_holdfire";
            level.exposed_guard_warning_vo[1].vo_priority = 2;
            level.exposed_guard_warning_vo[2] = spawnstruct();
            level.exposed_guard_warning_vo[2].vo = "ie_iln_dontengage";
            level.exposed_guard_warning_vo[2].vo_priority = 2;
            level.exposed_guard_warning_vo[3] = spawnstruct();
            level.exposed_guard_warning_vo[3].vo = "ie_iln_targetexposed";
            level.exposed_guard_warning_vo[3].vo_priority = 2;
        }
    }
    else
    {
        level.drone_warning_vo[0] = spawnstruct();
        level.drone_warning_vo[0].vo = "ie_nox_dontengagedrone";
        level.drone_warning_vo[0].vo_priority = 2;
        level.drone_warning_vo[1] = spawnstruct();
        level.drone_warning_vo[1].vo = "ie_nox_avoiddrone";
        level.drone_warning_vo[1].vo_priority = 2;
        level.civilian_warning_vo[0] = spawnstruct();
        level.civilian_warning_vo[0].vo = "ie_nox_civiliancasualties";
        level.civilian_warning_vo[0].vo_priority = 2;
        level.exposed_guard_warning_vo[0] = spawnstruct();
        level.exposed_guard_warning_vo[0].vo = "ie_nox_outinopen";
        level.exposed_guard_warning_vo[0].vo_priority = 2;
    }
}

dont_shoot_warning_vo( var_0, var_1 )
{
    level endon( "poolyard_save" );
    level endon( "bedroom_start" );
    level endon( "meet_cormack_end" );
    dont_shoot_warning_vo_setup( var_0 );

    for (;;)
    {
        var_2 = !( isdefined( level.drone_warning_given ) && isdefined( level.civilian_warning_given ) && isdefined( level.exposed_guard_warning_given ) );

        if ( var_2 )
        {
            level.player childthread dont_shoot_warning_vo_player_thread( var_0 );
            level waittill( "dont_shoot_vo_warning", var_3 );

            if ( var_3 == "drone" )
            {
                if ( !isdefined( level.drone_warning_given ) )
                {
                    var_4 = common_scripts\utility::random( level.drone_warning_vo );
                    thread ally_vo_controller( var_4 );

                    if ( !isdefined( var_1 ) )
                        level.drone_warning_given = 1;
                }
            }
            else if ( var_3 == "guard" )
            {
                if ( !isdefined( level.exposed_guard_warning_given ) )
                {
                    var_4 = common_scripts\utility::random( level.exposed_guard_warning_vo );
                    thread ally_vo_controller( var_4 );

                    if ( !isdefined( var_1 ) )
                        level.exposed_guard_warning_given = 1;
                }
            }
            else if ( !isdefined( level.civilian_warning_given ) )
            {
                var_4 = common_scripts\utility::random( level.civilian_warning_vo );
                thread ally_vo_controller( var_4 );

                if ( !isdefined( var_1 ) )
                    level.civilian_warning_given = 1;
            }
        }
        else
            break;

        wait 5;
    }
}

dont_shoot_warning_vo_player_thread( var_0 )
{
    self notify( "drone_warning_vo_player_thread" );
    self endon( "drone_warning_vo_player_thread" );
    self endon( "death" );

    for (;;)
    {
        waitframe();
        level.active_civilians = maps\_utility::remove_dead_from_array( level.active_civilians );

        if ( level.player maps\_utility::isads() )
        {
            var_1 = level.player geteye();
            var_2 = anglestoforward( level.player getangles() );

            if ( !isdefined( level.play_ally_callout_vo ) )
                continue;

            if ( !isdefined( level.play_ally_warning_vo ) )
                continue;

            if ( !check_player_in_stop_enemy_callout_vo_volume() )
                continue;

            var_3 = bullettrace( var_1, var_1 + var_2 * 15000, 1, level.player );
            var_4 = var_3["entity"];
            var_5 = getaiarray( "axis" );
            var_5 = maps\_utility::remove_dead_from_array( var_5 );

            if ( isdefined( level.active_drones ) )
            {
                var_3 = isdefined( var_4 ) && ( common_scripts\utility::array_contains( level.active_drones, var_4 ) || common_scripts\utility::array_contains( level.active_civilians, var_4 ) || common_scripts\utility::array_contains( var_5, var_4 ) );

                if ( var_3 )
                {
                    if ( var_4.classname == "script_vehicle_pdrone_security" )
                        var_6 = "drone";
                    else if ( var_4.classname == "actor_enemy_atlas_bodyguard_smg" || var_4.classname == "actor_enemy_atlas_pmc_estate_smg" )
                    {
                        if ( isdefined( var_4.script_parameters ) && var_4.script_parameters == "exposed" || isdefined( var_4.script_noteworthy ) && var_4.script_noteworthy == "exposed" )
                            var_6 = "guard";
                        else
                            continue;
                    }
                    else
                        var_6 = "civilian";

                    level notify( "dont_shoot_vo_warning", var_6 );
                    return;
                }
            }
        }
    }
}

exposed_group_logic()
{
    level endon( "player_on_security_center_rooftop" );
    level endon( "bedroom_start" );
    common_scripts\utility::flag_clear( "HINT_DECOY" );
    common_scripts\utility::flag_clear( "HINT_DECOY_STOP" );
    var_0 = undefined;
    var_1 = 0;

    for (;;)
    {
        waitframe();
        var_2 = getaiarray( "axis" );
        var_2 = maps\_utility::remove_dead_from_array( var_2 );
        var_3 = [];

        foreach ( var_5 in var_2 )
        {
            if ( isdefined( var_5.script_parameters ) && var_5.script_parameters == "exposed_group" || isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "exposed_group" )
                var_3 = common_scripts\utility::add_to_array( var_3, var_5 );
        }

        if ( var_3.size == 0 )
            return;

        var_5 = maps\_utility::get_closest_living( level.player.origin, var_3 );

        if ( !isdefined( var_5 ) )
            continue;

        var_7 = isdefined( level.player.ent_flag["_stealth_in_shadow"] ) && level.player.ent_flag["_stealth_in_shadow"];
        var_8 = distancesquared( var_5.origin, level.player.origin ) < 490000;

        if ( var_7 && var_8 )
        {
            var_9 = level.player geteye();
            var_10 = anglestoforward( level.player getangles() );
            var_11 = bullettrace( var_9, var_9 + var_10 * 15000, 1, level.player );
            var_12 = var_11["entity"];
            var_11 = isdefined( var_12 ) && common_scripts\utility::array_contains( var_3, var_12 );

            if ( var_11 )
            {
                var_1 += 0.05;

                if ( var_1 == 0.5 )
                {
                    if ( !isdefined( var_12.exposed_vo_said ) )
                    {
                        if ( !isdefined( level.play_ally_warning_vo ) && !check_player_in_stop_enemy_callout_vo_volume() )
                        {
                            var_13 = common_scripts\utility::random( level.exposed_guard_warning_vo );
                            thread ally_vo_controller( var_13 );
                            var_14 = maps\_stealth_shared_utilities::group_get_ai_in_group( var_12.script_stealthgroup );

                            foreach ( var_16 in var_14 )
                                var_16.exposed_vo_said = 1;
                        }
                    }

                    if ( !isdefined( var_0 ) && !isdefined( var_12.whistle_hint_used ) )
                    {
                        common_scripts\utility::flag_clear( "HINT_DECOY_STOP" );
                        var_12 thread handle_whistle_hint();
                        var_0 = 1;
                    }
                }
            }
            else
            {
                var_1 = 0;

                if ( isdefined( var_0 ) )
                {
                    common_scripts\utility::flag_set( "HINT_DECOY_STOP" );
                    var_0 = undefined;
                }
            }

            continue;
        }

        var_1 = 0;

        if ( isdefined( var_0 ) )
        {
            common_scripts\utility::flag_set( "HINT_DECOY_STOP" );
            var_0 = undefined;
        }
    }
}

handle_whistle_hint()
{
    level endon( "HINT_DECOY_STOP" );
    common_scripts\utility::flag_clear( "HINT_DECOY" );
    level.player thread maps\_utility::display_hint_timeout( "HINT_DECOY_EXPOSED_GROUP" );
    level.player notifyonplayercommand( "whistle", "+actionslot " + level.action_slot_whistle );
    level.player waittill( "whistle" );
    common_scripts\utility::flag_set( "HINT_DECOY" );

    if ( isdefined( self.script_stealthgroup ) )
    {
        var_0 = maps\_stealth_shared_utilities::group_get_ai_in_group( self.script_stealthgroup );

        foreach ( var_2 in var_0 )
            var_2.whistle_hint_used = 1;
    }
}

enemy_alert_vo_setup( var_0 )
{
    level.enemy_alert_vo = [];
    level.enemy_return_to_normal_vo = [];

    if ( var_0 == "iln" )
    {
        level.enemy_alert_vo[0] = spawnstruct();
        level.enemy_alert_vo[0].vo = "ie_iln_hidemitch2";
        level.enemy_alert_vo[0].vo_priority = 5;
        level.enemy_alert_vo[1] = spawnstruct();
        level.enemy_alert_vo[1].vo = "ie_iln_outofsight2";
        level.enemy_alert_vo[1].vo_priority = 5;
        level.enemy_alert_vo[2] = spawnstruct();
        level.enemy_alert_vo[2].vo = "ie_iln_quickhide";
        level.enemy_alert_vo[2].vo_priority = 5;
        level.enemy_return_to_normal_vo[0] = spawnstruct();
        level.enemy_return_to_normal_vo[0].vo = "ie_iln_allclearmitch";
        level.enemy_return_to_normal_vo[0].vo_priority = 3;
        level.enemy_return_to_normal_vo[1] = spawnstruct();
        level.enemy_return_to_normal_vo[1].vo = "ie_iln_movingback";
        level.enemy_return_to_normal_vo[1].vo_priority = 3;
        level.enemy_return_to_normal_vo[2] = spawnstruct();
        level.enemy_return_to_normal_vo[2].vo = "ie_iln_youreclear";
        level.enemy_return_to_normal_vo[2].vo_priority = 3;
    }
    else
    {
        level.enemy_alert_vo[0] = spawnstruct();
        level.enemy_alert_vo[0].vo = "ie_nox_hide1";
        level.enemy_alert_vo[0].vo_priority = 5;
        level.enemy_alert_vo[1] = spawnstruct();
        level.enemy_alert_vo[1].vo = "ie_nox_getout1";
        level.enemy_alert_vo[1].vo_priority = 5;
        level.enemy_alert_vo[2] = spawnstruct();
        level.enemy_alert_vo[2].vo = "ie_nox_tangoincoming1";
        level.enemy_alert_vo[2].vo_priority = 5;
        level.enemy_return_to_normal_vo[0] = spawnstruct();
        level.enemy_return_to_normal_vo[0].vo = "ie_nox_youresafe";
        level.enemy_return_to_normal_vo[0].vo_priority = 3;
        level.enemy_return_to_normal_vo[1] = spawnstruct();
        level.enemy_return_to_normal_vo[1].vo = "ie_nox_looksclear";
        level.enemy_return_to_normal_vo[1].vo_priority = 3;
        level.enemy_return_to_normal_vo[2] = spawnstruct();
        level.enemy_return_to_normal_vo[2].vo = "ie_nox_noalerts";
        level.enemy_return_to_normal_vo[2].vo_priority = 3;
    }
}

enemy_alert_vo()
{
    level endon( "missionfailed" );
    level.player endon( "death" );
    self endon( "death" );
    level endon( "bedroom_end" );

    for (;;)
    {
        maps\_utility::ent_flag_waitopen( "_stealth_normal" );
        self.alerted = 1;
        waitframe();

        if ( isdefined( self.event_type ) && ( self.event_type == "whistle" || self.event_type == "reaction_generic" ) || maps\_utility::ent_flag( "_stealth_saw_corpse" ) || maps\_utility::ent_flag( "_stealth_found_corpse" ) )
        {
            if ( ( maps\_utility::ent_flag( "_stealth_saw_corpse" ) || maps\_utility::ent_flag( "_stealth_found_corpse" ) ) && !isdefined( self.alerted_by_corpse ) )
                self.alerted_by_corpse = 1;

            thread maps\irons_estate_stealth::wait_till_every_thing_stealth_normal_for( 3 );
        }
        else if ( !common_scripts\utility::flag( "someone_became_alert" ) )
        {
            common_scripts\utility::flag_set( "someone_became_alert" );
            level maps\_utility::add_wait( maps\irons_estate_stealth::wait_till_every_thing_stealth_normal_for, 3 );
            level maps\_utility::add_func( common_scripts\utility::flag_clear, "someone_became_alert" );
            thread maps\_utility::do_wait();
            wait 1.0;

            if ( common_scripts\utility::flag( "_stealth_spotted" ) )
                continue;

            if ( isdefined( level.enemy_alert_vo ) )
            {
                var_0 = common_scripts\utility::random( level.enemy_alert_vo );
                thread ally_vo_controller( var_0 );
            }
        }

        maps\_utility::ent_flag_wait( "_stealth_normal" );

        if ( isdefined( self.isbeinggrappled ) )
            continue;

        self.alerted = undefined;

        if ( common_scripts\utility::flag( "drones_investigating" ) )
            continue;

        if ( common_scripts\utility::flag( "_stealth_spotted" ) )
            continue;

        if ( isdefined( self.alerted_by_corpse ) )
        {
            maps\_utility::ent_flag_waitopen( "_stealth_saw_corpse" );
            maps\_utility::ent_flag_waitopen( "_stealth_found_corpse" );
            self.alerted_by_corpse = undefined;
            continue;
        }

        if ( distancesquared( level.player.origin, self.origin ) < 250000 )
        {
            if ( isdefined( level.enemy_return_to_normal_vo ) )
            {
                var_0 = common_scripts\utility::random( level.enemy_return_to_normal_vo );
                thread ally_vo_controller( var_0 );
            }
        }
    }
}

drone_incoming_vo_setup( var_0 )
{
    level.drones_sent_vo = [];

    if ( var_0 == "iln" )
    {
        level.drones_sent_vo[0] = spawnstruct();
        level.drones_sent_vo[0].vo = "ie_iln_sendingindrones";
        level.drones_sent_vo[0].vo_priority = 3;
        level.drones_sent_vo[1] = spawnstruct();
        level.drones_sent_vo[1].vo = "ie_iln_droneincoming";
        level.drones_sent_vo[1].vo_priority = 3;
        level.drones_sent_vo[2] = spawnstruct();
        level.drones_sent_vo[2].vo = "ie_iln_droneontheway";
        level.drones_sent_vo[2].vo_priority = 3;
    }
    else
    {
        level.drones_sent_vo[0] = spawnstruct();
        level.drones_sent_vo[0].vo = "ie_nox_sendingindrones";
        level.drones_sent_vo[0].vo_priority = 3;
        level.drones_sent_vo[1] = spawnstruct();
        level.drones_sent_vo[1].vo = "ie_nox_droneincoming";
        level.drones_sent_vo[1].vo_priority = 3;
        level.drones_sent_vo[2] = spawnstruct();
        level.drones_sent_vo[2].vo = "ie_nox_droneontheway";
        level.drones_sent_vo[2].vo_priority = 3;
    }
}

drone_incoming_vo( var_0 )
{
    level endon( "emp_detonated" );
    level endon( "bedroom_end" );
    drone_incoming_vo_setup( var_0 );

    while ( !common_scripts\utility::flag( "mission_failing" ) )
    {
        common_scripts\utility::flag_wait( "drones_investigating" );

        if ( !isdefined( level.drone_investigating_has_happened_once ) )
            level.drone_investigating_has_happened_once = 1;

        if ( common_scripts\utility::flag( "drone_investigate_triggered" ) )
        {
            var_1 = [];
            var_1[0] = level.drones_sent_vo[1];
            var_1[1] = level.drones_sent_vo[2];
            var_2 = common_scripts\utility::random( var_1 );
        }
        else
            var_2 = common_scripts\utility::random( level.drones_sent_vo );

        thread ally_vo_controller( var_2 );
        common_scripts\utility::flag_waitopen( "drones_investigating" );
        waitframe();
    }
}

failed_vo_setup( var_0 )
{
    level.failed_vo = [];

    if ( var_0 == "iln" )
    {
        level.failed_vo[0] = spawnstruct();
        level.failed_vo[0].vo = "ie_iln_abortmission";
        level.failed_vo[0].vo_priority = 6;
        level.failed_vo[1] = spawnstruct();
        level.failed_vo[1].vo = "ie_iln_alertedthem1";
        level.failed_vo[1].vo_priority = 6;
    }
    else
    {
        level.failed_vo[0] = spawnstruct();
        level.failed_vo[0].vo = "ie_nox_compromised1";
        level.failed_vo[0].vo_priority = 6;
        level.failed_vo[1] = spawnstruct();
        level.failed_vo[1].vo = "ie_nox_ontous1";
        level.failed_vo[1].vo_priority = 6;
    }
}

failed_vo( var_0 )
{
    level.player endon( "death" );
    level endon( "emp_detonated" );
    level endon( "bedroom_end" );
    failed_vo_setup( var_0 );
    common_scripts\utility::flag_wait( "mission_failing" );
    level.failed_vo = common_scripts\utility::array_randomize( level.failed_vo );
    var_1 = level.failed_vo[0];
    thread ally_vo_controller( var_1 );
}

ally_vo_controller( var_0 )
{
    level.player endon( "death" );
    level endon( "bedroom_end" );

    if ( isdefined( level.play_ally_warning_vo ) && level.play_ally_warning_vo == 1 )
    {
        if ( isdefined( level.current_vo ) && isdefined( var_0.vo_priority ) && var_0.vo_priority > level.current_vo.vo_priority )
        {
            level.ally_vo_org stopsounds();
            wait 0.05;
            level.current_vo = var_0;
            level.ally_vo_org playsound( var_0.vo, "sounddone", 1 );
            level.ally_vo_org waittill( "sounddone" );
            wait 0.5;
            level.current_vo = undefined;
        }
        else if ( !isdefined( level.current_vo ) )
        {
            level.current_vo = var_0;
            level.ally_vo_org playsound( var_0.vo, "sounddone", 1 );
            level.ally_vo_org waittill( "sounddone" );
            wait 0.5;
            level.current_vo = undefined;
        }
    }
}

irons_estate_animated_trees_setup()
{
    thread handle_irons_estate_animated_trees();

    switch ( level.start_point )
    {
        case "infil":
        case "recon":
            common_scripts\utility::flag_set( "ie_west_poolhouse_trees" );
            break;
        case "hack_security":
        case "security_center":
            common_scripts\utility::flag_set( "ie_west_poolhouse_trees" );
            common_scripts\utility::flag_set( "ie_west_central_garden_trees" );
            break;
        case "intel":
        case "penthouse":
        case "meet_cormack":
            common_scripts\utility::flag_set( "ie_west_poolhouse_trees" );
            common_scripts\utility::flag_set( "ie_west_central_garden_trees" );
            common_scripts\utility::flag_set( "ie_west_driveway_trees" );
            break;
        case "plant_tracker":
        case "hangar":
        case "infil_hangar":
            common_scripts\utility::flag_set( "remove_pre_penthouse_trees" );
            common_scripts\utility::flag_set( "ie_west_poolhouse_trees" );
            common_scripts\utility::flag_set( "ie_west_central_garden_trees" );
            common_scripts\utility::flag_set( "ie_west_driveway_trees" );
            common_scripts\utility::flag_set( "post_penthouse_trees" );
        default:
            break;
    }
}

handle_irons_estate_animated_trees()
{
    common_scripts\utility::flag_wait( "ie_west_poolhouse_trees" );

    if ( !common_scripts\utility::flag( "remove_pre_penthouse_trees" ) )
        spawn_struct_array( "ie_west_poolhouse_trees", "targetname" );

    common_scripts\utility::flag_wait( "ie_west_central_garden_trees" );

    if ( !common_scripts\utility::flag( "remove_pre_penthouse_trees" ) )
        spawn_struct_array( "ie_west_central_garden_trees", "targetname" );

    common_scripts\utility::flag_wait( "ie_west_driveway_trees" );

    if ( !common_scripts\utility::flag( "remove_pre_penthouse_trees" ) )
        spawn_struct_array( "ie_west_driveway_trees", "targetname" );

    common_scripts\utility::flag_wait( "post_penthouse_trees" );

    if ( !common_scripts\utility::flag( "remove_pre_penthouse_trees" ) )
        thread remove_pre_penthouse_trees();

    spawn_struct_array( "post_penthouse_trees", "targetname" );
}

remove_pre_penthouse_trees()
{
    var_0 = getentarray( "ie_west_poolhouse_trees", "targetname" );
    var_1 = getentarray( "ie_west_central_garden_trees", "targetname" );
    var_2 = getentarray( "ie_west_driveway_trees", "targetname" );
    var_3 = common_scripts\utility::array_combine( var_0, var_1 );
    var_3 = common_scripts\utility::array_combine( var_3, var_2 );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5 ) )
            var_5 delete();
    }

    common_scripts\utility::flag_set( "remove_pre_penthouse_trees" );
}

spawn_struct_array( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstructarray( var_0, var_1 );
    var_3 = [];
    var_3[0] = "palm_tree_02";
    var_3[1] = "palm_tree_03";

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "foliage_fan_palm_tree_01_anim" )
        {
            spawn_model_from_struct( var_5, "palm_tree_01" );
            continue;
        }

        if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "foliage_fan_palm_tree_02_anim" )
        {
            var_6 = common_scripts\utility::random( var_3 );
            spawn_model_from_struct( var_5, var_6 );
        }
    }
}

spawn_model_from_struct( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );

    if ( isdefined( var_0.script_noteworthy ) )
    {
        if ( var_0.script_noteworthy == "foliage_fan_palm_tree_01_anim" )
            var_0.angles = ( 0, 30, 0 );

        if ( var_0.script_noteworthy == "foliage_fan_palm_tree_02_anim" )
        {
            if ( var_1 == "palm_tree_02" )
                var_0.angles = ( 0, 180, 0 );
            else
                var_0.angles = ( 0, 0, 0 );
        }

        var_2.angles = var_0.angles;
    }

    var_2 setmodel( var_0.script_noteworthy );

    if ( level.nextgen )
    {
        var_2.animname = var_1;
        var_2 useanimtree( level.scr_animtree[var_2.animname] );
    }

    var_2.script_noteworthy = var_0.script_noteworthy;
    var_2.targetname = var_0.targetname;
    var_2.target = var_0.target;

    if ( level.nextgen )
        var_2 thread irons_estate_animated_trees( var_1 );
}

irons_estate_animated_trees( var_0 )
{
    wait(randomfloatrange( 0.25, 1.5 ));
    thread maps\_anim::anim_loop_solo( self, var_0 );
}

delay_scripting_if_stealth_broken( var_0, var_1, var_2, var_3 )
{
    level endon( var_1 );

    for (;;)
    {
        if ( !common_scripts\utility::flag( "_stealth_spotted" ) && !common_scripts\utility::flag( "someone_became_alert" ) && !common_scripts\utility::flag( "drones_investigating" ) )
            common_scripts\utility::flag_wait_any( "_stealth_spotted", "someone_became_alert", "drones_investigating" );

        var_0 common_scripts\utility::trigger_off();

        if ( isdefined( var_2 ) )
            var_2 hide();

        common_scripts\utility::flag_waitopen( "someone_became_alert" );
        common_scripts\utility::flag_waitopen( "drones_investigating" );
        common_scripts\utility::flag_waitopen( "_stealth_spotted" );

        while ( level.stealth_spotted_drones.size > 0 )
            wait 0.05;

        if ( isdefined( var_2 ) )
            var_2 show();

        var_0 common_scripts\utility::trigger_on();
        thread [[ var_3 ]]();
        wait 0.05;
    }
}

player_kill_trigger( var_0 )
{
    level endon( "intel_begin" );
    common_scripts\utility::flag_wait( var_0 );
    level.player disableinvulnerability();
    level.player kill();
}

waterfall_save( var_0 )
{
    level endon( var_0 );

    for (;;)
    {
        if ( level.player istouching( self ) && level.player isonground() )
        {
            maps\_utility::autosave_stealth();
            break;
        }

        wait 1;
    }
}

player_alerted_mission_fail_convoy()
{
    soundscripts\_snd_playsound::snd_play_2d( "irons_guards_alerted_fail" );
    maps\_player_death::set_deadquote( &"IRONS_ESTATE_YOU_FAILED_TO_WAIT_FOR_CORMACK" );
    thread maps\_utility::missionfailedwrapper();
}

player_alerted_mission_fail()
{
    soundscripts\_snd_playsound::snd_play_2d( "irons_guards_alerted_fail" );
    maps\_player_death::set_deadquote( &"IRONS_ESTATE_ALERT_MISSION_FAIL" );
    thread maps\_utility::missionfailedwrapper();
}

player_alerted_mission_fail_meter()
{
    soundscripts\_snd_playsound::snd_play_2d( "irons_guards_alerted_fail" );
    maps\_player_death::set_deadquote( &"IRONS_ESTATE_STEALTH_DETECTION_HINT" );
    thread maps\_utility::missionfailedwrapper();
}

handle_player_abandoned_mission( var_0 )
{
    if ( var_0 == "iln" )
    {
        var_1 = getent( "border_drone_warning_trigger", "targetname" );
        var_1 thread player_abandoned_mission_warning( "bedroom_end", var_0 );
        level endon( "bedroom_end" );
        common_scripts\utility::flag_wait( "border_drone_driveway_trigger" );
        common_scripts\utility::flag_set( "_stealth_spotted" );
        level.border_drone_fail = 1;
        thread player_abandoned_mission_fail();
    }
    else
    {
        var_2 = getent( "abandoning_mission_warning_trigger", "targetname" );
        var_2 thread player_abandoned_mission_warning( "emp_detonated", var_0 );
        level endon( "emp_detonated" );
        common_scripts\utility::flag_wait( "player_entering_ie_west" );
        common_scripts\utility::flag_set( "_stealth_spotted" );
        level.border_drone_fail = 1;
        thread player_abandoned_mission_fail();
    }
}

player_abandoned_mission_warning_vo_setup( var_0 )
{
    if ( var_0 == "iln" )
    {
        level.player_abandoning_mission_vo = [];
        level.player_abandoning_mission_vo[0] = spawnstruct();
        level.player_abandoning_mission_vo[0].vo = "ie_iln_gettooffice";
        level.player_abandoning_mission_vo[0].vo_priority = 4;
        level.player_abandoning_mission_vo[1] = spawnstruct();
        level.player_abandoning_mission_vo[1].vo = "ie_iln_tooclose2";
        level.player_abandoning_mission_vo[1].vo_priority = 4;
        level.player_abandoning_mission_vo[2] = spawnstruct();
        level.player_abandoning_mission_vo[2].vo = "ie_iln_spotyou";
        level.player_abandoning_mission_vo[2].vo_priority = 4;
    }
    else
    {
        level.player_abandoning_mission_vo = [];
        level.player_abandoning_mission_vo[0] = spawnstruct();
        level.player_abandoning_mission_vo[0].vo = "ie_nox_where2";
        level.player_abandoning_mission_vo[0].vo_priority = 4;
        level.player_abandoning_mission_vo[1] = spawnstruct();
        level.player_abandoning_mission_vo[1].vo = "ie_nox_stayonpoint";
        level.player_abandoning_mission_vo[1].vo_priority = 4;
    }
}

player_abandoned_mission_warning( var_0, var_1 )
{
    level endon( var_0 );
    player_abandoned_mission_warning_vo_setup( var_1 );
    var_2 = 0;

    for (;;)
    {
        self waittill( "trigger" );
        var_3 = common_scripts\utility::random( level.player_abandoning_mission_vo );
        thread ally_vo_controller( var_3 );
        var_4 = randomfloatrange( 8, 10 );

        while ( level.player istouching( self ) )
        {
            if ( !isdefined( level.abandon_mission_warning_hint ) )
            {
                common_scripts\utility::flag_clear( "HINT_ABANDON_WARNING_STOP" );
                thread maps\_utility::display_hint( "HINT_ABANDON_WARNING" );
                level.abandon_mission_warning_hint = 1;
            }

            var_2 += 0.05;

            if ( var_2 >= var_4 )
            {
                var_3 = common_scripts\utility::random( level.player_abandoning_mission_vo );
                thread ally_vo_controller( var_3 );
                var_2 = 0;
            }

            wait 0.05;
        }

        var_2 = 0;
        common_scripts\utility::flag_set( "HINT_ABANDON_WARNING_STOP" );

        if ( isdefined( level.abandon_mission_warning_hint ) )
            level.abandon_mission_warning_hint = undefined;

        waitframe();
    }
}

player_abandoned_mission_fail()
{
    maps\_player_death::set_deadquote( &"IRONS_ESTATE_ABANDON_FAIL" );
    thread maps\_utility::missionfailedwrapper();
}

ally_grapple( var_0, var_1, var_2 )
{
    if ( isdefined( self.move_origin ) )
    {
        self unlink();
        self.move_origin delete();
    }

    var_3 = self.origin;
    var_0 = common_scripts\utility::getstruct( var_0, "targetname" );
    maps\_utility::set_goal_radius( 16 );
    self.move_origin = common_scripts\utility::spawn_tag_origin();
    self linkto( self.move_origin, "tag_origin" );
    self.move_origin moveto( var_0.origin, var_1 );
    wait(var_1);
    waitframe();

    if ( !isdefined( var_2 ) )
    {
        self unlink();

        if ( isdefined( self.move_origin ) )
            self.move_origin delete();
    }
}

check_allies_in_volume( var_0, var_1 )
{
    common_scripts\utility::flag_clear( "all_in" );

    for (;;)
    {
        var_2 = 1;

        foreach ( var_4 in var_0 )
        {
            if ( isalive( var_4 ) && !var_4 istouching( var_1 ) )
                var_2 = 0;
        }

        if ( var_2 )
            break;

        wait 0.05;
    }

    common_scripts\utility::flag_set( "all_in" );
}

remove_grapple( var_0 )
{
    common_scripts\utility::flag_clear( "grapple_disabled" );

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_wait( var_0 );

    for (;;)
    {
        if ( level.player.grapple["connected"] == 0 )
        {
            if ( level.player.grapple["grappling"] == 0 )
                break;
        }

        wait 0.05;
    }

    level.player maps\_grapple::grapple_take();
    common_scripts\utility::flag_set( "grapple_disabled" );
}

security_center_lights( var_0, var_1, var_2 )
{
    if ( isdefined( var_0 ) )
    {
        foreach ( var_4 in var_1 )
            var_4 setlightintensity( 0 );
    }
    else
    {
        foreach ( var_4 in var_1 )
            var_4 setlightintensity( var_2 );
    }
}

security_center_script_brushmodels( var_0 )
{
    if ( isdefined( var_0 ) )
        self hide();
    else
        self show();
}

security_center_player_rig_and_hatch_door_setup()
{
    level.security_center_anim_struct = common_scripts\utility::getstruct( "security_center_anim_struct", "targetname" );
    level.hatch_door_middle = getent( "hatch_door_middle", "targetname" );
    level.hatch_door_middle.animname = "hatch_door_middle";
    level.hatch_door_middle useanimtree( level.scr_animtree["hatch_door_middle"] );
    level.player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.player_rig hide();
    level.player_and_hatch_doors = [];
    level.player_and_hatch_doors[0] = level.player_rig;
    level.player_and_hatch_doors[1] = level.hatch_door_middle;

    if ( level.start_point_scripted == "hack_security" )
        level.security_center_anim_struct maps\_anim::anim_last_frame_solo( level.hatch_door_middle, "plant_emp" );
    else
        level.security_center_anim_struct maps\_anim::anim_first_frame( level.player_and_hatch_doors, "plant_emp" );
}

security_center_bink()
{
    waitframe();
    level endon( "hack_security_end" );
    thread security_center_bink_off();
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloop( "atlas_logo_loop" );
    common_scripts\utility::flag_wait( "handprint_start" );
    wait 1.5;
    stopcinematicingame();
    maps\_utility::delaythread( 2, ::security_center_main_screen_bink, 1 );
    cinematicingame( "security_center_table_scan" );
    soundscripts\_snd_playsound::snd_play_2d( "irons_bink_tablescan" );
    wait 0.05;
    level waittill( "security_center_table_bink_done" );
    stopcinematicingame();
    var_0 = getent( "security_center_desk_screen", "targetname" );
    var_0 hide();
    thread security_center_main_screen_bink( undefined );
    soundscripts\_snd::snd_message( "aud_security_main_screen" );
    cinematicingameloop( "security_center_main_screen" );
}

security_center_bink_off()
{
    common_scripts\utility::flag_wait( "hack_security_end" );
    stopcinematicingame();
}

security_center_main_screen_bink( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        var_2 = getent( "security_center_main_screen_model", "targetname" );
        var_2 hide();
        var_3 = getent( "security_center_main_screen_brush", "targetname" );
        var_3 hide();
        var_4 = getent( "security_center_main_screen_off", "targetname" );
        var_4 show();
    }
    else
    {
        if ( isdefined( var_1 ) )
        {
            var_2 = getent( "security_center_main_screen_model", "targetname" );
            var_2 show();
            var_3 = getent( "security_center_main_screen_brush", "targetname" );
            var_3 hide();
        }
        else
        {
            var_3 = getent( "security_center_main_screen_brush", "targetname" );
            var_3 show();
            var_2 = getent( "security_center_main_screen_model", "targetname" );
            var_2 hide();
        }

        var_4 = getent( "security_center_main_screen_off", "targetname" );
        var_4 hide();
    }
}

timer( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_2 ) )
    {
        level endon( var_2 );
        thread maps\_utility::flagwaitthread( var_2, ::killtimer );
    }

    level.hudtimerindex = 20;
    level.timer = maps\_hud_util::get_countdown_hud( -250 );
    level.timer setpulsefx( 30, 900000, 700 );

    if ( isdefined( var_3 ) )
        level.timer.label = var_3;

    level.timer settimer( var_0 );
    level.start_time = gettime();
    var_4 = level.timer;

    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_wait_or_timeout( var_2, var_0 );
    else if ( !isdefined( var_1 ) )
        wait(var_0);
    else
        wait(var_1);

    if ( isdefined( var_4 ) )
        killtimer();
}

killtimer()
{
    if ( isdefined( level.timer ) )
        level.timer destroy();
}

tennis_court_floor( var_0 )
{
    var_1 = getentarray( "tennis_court_floor_lines", "targetname" );
    var_2 = getentarray( "tennis_court_net", "targetname" );

    if ( isdefined( var_0 ) )
    {
        foreach ( var_4 in var_1 )
            var_4 hide();

        foreach ( var_7 in var_2 )
            var_7 hide();
    }
    else
    {
        foreach ( var_4 in var_1 )
            var_4 show();

        foreach ( var_7 in var_2 )
            var_7 show();
    }
}

notify_delay_param( var_0, var_1, var_2 )
{
    self endon( "_stealth_enemy_alert_level_change" );
    self endon( "enemy_awareness_reaction" );
    self endon( "death" );
    self endon( "pain_death" );

    if ( var_1 > 0 )
        wait(var_1);

    if ( !isdefined( self ) )
        return;

    self notify( var_0, var_2 );
}

notifyaftertime( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( var_1 );
    wait(var_2);
    self notify( var_0 );
}

stopsounds_on_death()
{
    common_scripts\utility::waittill_any( "death", "damage", "_stealth_enemy_alert_level_change", "alert", "attack", "stealth_enemy_endon_alert", "alerted", "spotted_player" );

    if ( isdefined( self ) )
    {
        self notify( "something_alerted_me" );

        if ( isdefined( self.anim_org ) )
            self.anim_org notify( "stop_looping_anim" );

        self notify( "stop_sound" );
        self stopsounds();
    }
}

drone_investigate_triggers_main()
{
    common_scripts\utility::flag_init( "drone_investigate_triggered" );
    var_0 = getentarray( "drone_investigate_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread drone_investigate_trigger();
}

drone_investigate_trigger()
{
    level.player endon( "death" );
    self endon( "death" );
    var_0 = undefined;

    if ( isdefined( self.script_noteworthy ) )
    {
        var_0 = self.script_noteworthy;
        level endon( self.script_noteworthy );
    }

    self waittill( "trigger" );

    if ( isdefined( var_0 ) )
    {
        if ( common_scripts\utility::flag( var_0 ) )
            return;
    }

    if ( isdefined( level.drone_investigating_has_happened_once ) )
        return;

    if ( isdefined( self.script_parameters ) )
        thread maps\_utility::smart_radio_dialogue( self.script_parameters );

    if ( isdefined( self.target ) )
    {
        var_1 = common_scripts\utility::getstruct( self.target, "targetname" );
        var_2 = var_1.origin;
    }
    else
        var_2 = level.player.origin;

    level notify( "drone_investigate", var_2 );
    common_scripts\utility::flag_set( "drone_investigate_triggered" );
    maps\_utility::delaythread( 1, common_scripts\utility::flag_clear, "drone_investigate_triggered" );
}

irons_estate_stealth_disable()
{
    level.player.grapple["dist_max"] = 800;
    level notify( "stop_player_broke_stealth_monitor" );
    level notify( "stealth_alerted_drone_monitor" );
    level notify( "stop_stealth_spotted_drone_monitor" );
    level.stealth_disabled = 1;
}

irons_estate_stealth_enable()
{
    thread maps\irons_estate_stealth::player_broke_stealth();
    thread maps\irons_estate_drone::stealth_alerted_drone_monitor();
    thread maps\irons_estate_drone::stealth_spotted_drone_monitor();
    level.stealth_disabled = undefined;
}

trigger_sprinklervolume_setup()
{
    var_0 = getentarray( "trigger_sprinklervolume", "targetname" );

    foreach ( var_2 in var_0 )
        thread trigger_sprinklervolume_think( var_2 );
}

trigger_sprinklervolume_think( var_0 )
{
    var_0.sprinkler_origin = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_0.sprinkler_origin thread sprinkler_sound_proximity_toggle();
    playfx( level._effect["ie_sprinkler"], var_0.sprinkler_origin.origin );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1 maps\_utility::ent_flag_exist( "in_sprinkler_volume" ) )
        {

        }
        else
            var_1 maps\_utility::ent_flag_init( "in_sprinkler_volume" );

        if ( distancesquared( var_1.origin, level.player.origin ) < 6250000 )
        {
            if ( var_1 maps\_utility::ent_flag( "in_sprinkler_volume" ) )
                continue;

            var_1 thread volume_fallingwaterfx( var_0 );
            var_1 maps\_utility::ent_flag_set( "in_sprinkler_volume" );
        }
    }
}

volume_fallingwaterfx( var_0 )
{
    self endon( "death" );
    var_1 = var_0 getpointinbounds( 1, 1, 0 );
    var_2 = var_0 getpointinbounds( -1, -1, 0 );
    var_3 = ( var_1[0] - var_2[0] ) * ( var_1[1] - var_2[1] );
    var_4 = 3;

    if ( isdefined( var_0.script_duration ) )
        var_4 = var_0.script_duration;

    var_5 = 1;

    if ( isdefined( var_0.script_flowrate ) )
        var_5 = var_0.script_flowrate;

    var_6 = int( var_5 * var_3 / 50 );
    var_7 = "null";

    if ( isdefined( var_0.script_fxid ) )
        var_7 = var_0.script_fxid;

    var_8 = "null";

    if ( isdefined( var_0.script_screen_fxid ) )
        var_8 = var_0.script_screen_fxid;

    var_9 = -1;

    for (;;)
    {
        if ( self istouching( var_0 ) )
        {
            if ( isai( self ) )
            {
                wait 0.05;

                for ( var_10 = 0; var_10 < var_6; var_10++ )
                {
                    if ( var_7 != "null" )
                    {
                        var_11 = var_0.sprinkler_origin.origin;
                        var_12 = self.origin + ( randomfloatrange( 0, 4.0 ), randomfloatrange( 0, 4.0 ), randomfloatrange( 10.0, 50.0 ) );

                        if ( distance2dsquared( var_12, self.origin ) < 900 )
                        {
                            var_13 = bullettrace( var_11, var_12, 1, undefined, 0, 1 );

                            if ( isdefined( var_13["entity"] ) && var_13["entity"] == self )
                            {
                                var_14 = common_scripts\utility::getfx( var_7 );
                                var_11 = var_13["position"];
                                var_15 = vectortoangles( var_13["normal"] + ( 90, 0, 0 ) );
                                var_16 = anglestoforward( var_15 );
                                var_17 = anglestoup( var_15 );
                                playfx( var_14, var_11, var_17, var_16 );
                            }
                        }
                    }
                }
            }

            if ( isplayer( self ) && level.player is_player_looking_at( var_0.sprinkler_origin.origin, cos( 45 ), undefined, level.player ) )
            {
                wait 0.05;
                playfx( level._effect["ie_sprinkler_screen_drops"], level.player.origin );
                var_9 += 0.05;

                if ( ( var_9 > var_4 * 0.2 || var_9 < 0 ) && distancesquared( var_0.sprinkler_origin.origin, level.player geteye() ) < 4096 )
                {
                    self setwatersheeting( 1, var_4 );
                    var_9 = 0;
                }
            }
        }
        else
        {
            maps\_utility::ent_flag_clear( "in_sprinkler_volume" );
            return;
        }

        wait 0.05;
    }
}

is_player_looking_at( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.8;

    var_4 = maps\_utility::get_player_from_self();
    var_5 = var_4 geteye();
    var_6 = vectortoangles( var_0 - var_5 );
    var_7 = anglestoforward( var_6 );
    var_8 = var_4 getangles();
    var_9 = anglestoforward( var_8 );
    var_10 = vectordot( var_7, var_9 );

    if ( var_10 < var_1 )
        return 0;

    if ( isdefined( var_2 ) )
        return 1;

    var_11 = bullettrace( var_0, var_5, 0, var_3 );
    return var_11["fraction"] == 1;
}

sprinkler_sound_proximity_toggle()
{
    var_0 = self.targetname + "_stop_irons_sprinkler_02";
    var_1 = undefined;

    for (;;)
    {
        if ( distancesquared( self.origin, level.player.origin ) < 1000000 )
        {
            if ( !isdefined( var_1 ) )
                var_1 = common_scripts\utility::spawn_tag_origin();

            var_1 soundscripts\_snd_playsound::snd_play_loop_linked( "irons_sprinkler_02", var_0, 1, 1.5 );

            while ( distancesquared( self.origin, level.player.origin ) < 1000000 )
                wait 0.05;

            if ( isdefined( var_1 ) )
                var_1 delete();
        }
        else if ( isdefined( var_1 ) )
            var_1 delete();

        wait 0.05;
    }
}

hide_friendname_until_flag_or_notify( var_0 )
{
    if ( !isdefined( self.name ) )
        return;

    level.player endon( "death" );
    self endon( "death" );
    self.old_name = self.name;
    self.name = " ";
    level waittill( var_0 );
    self.name = self.old_name;
}

force_alert_trigger_setup()
{
    var_0 = getentarray( "force_alert_trigger", "targetname" );
    common_scripts\utility::array_thread( var_0, ::force_alert_trigger_monitor );
}

force_alert_trigger_monitor()
{
    if ( isdefined( self.script_noteworthy ) )
        level endon( self.script_noteworthy );

    self waittill( "trigger", var_0 );
    var_1 = getaiarray( "neutral" );
    var_1 = maps\_utility::remove_dead_from_array( var_1 );

    foreach ( var_3 in var_1 )
    {
        if ( !var_3 istouching( self ) )
            var_1 = common_scripts\utility::array_remove( var_1, var_3 );
    }

    var_1 = sortbydistance( var_1, var_0.origin );

    if ( isdefined( var_1[0] ) )
        var_1[0] notify( "alerted" );
}

tff_cleanup_vehicle( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "cliffs":
            var_1 = "tff_pre_cliffs_to_lower";
            break;
        case "lower":
            var_1 = "tff_pre_lower_to_upper";
            break;
    }

    if ( var_1 == "" )
        return;

    level waittill( var_1 );

    if ( !isdefined( self ) )
        return;

    if ( isremovedentity( self ) )
        return;

    maps\_vehicle_code::_freevehicle();
    self delete();
}
