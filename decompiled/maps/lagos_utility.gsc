// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

drone_lookat_ent( var_0, var_1, var_2, var_3 )
{
    self endon( "fly_drone_done" );
    self notify( "start_new_drone_lookat" );
    self endon( "start_new_drone_lookat" );

    if ( !isdefined( var_3 ) )
        var_3 = ( 0, 0, 0 );

    var_4 = getent( var_0, "targetname" );
    var_5 = vectortoangles( var_4.origin - self.origin );

    if ( !isdefined( var_1 ) || var_1 == 0 )
        self.angles = var_5;
    else
    {
        self rotateto( var_5 + var_3, var_1, var_1 / 5, var_1 / 5 );
        self waittill( "rotatedone" );
        self notify( "drone_lookat_done" );
    }

    if ( isdefined( var_2 ) && var_2 )
    {
        for (;;)
        {
            var_5 = vectortoangles( var_4.origin - self.origin ) + var_3;
            self rotateto( var_5, 0.1, 0, 0 );
            wait 0.1;
        }
    }
}

drone_moveto_ent( var_0, var_1, var_2, var_3 )
{
    var_4 = getent( var_0, "targetname" );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    self moveto( var_4.origin, var_1, var_2, var_3 );
    self waittill( "movedone" );
    self notify( "drone_moveto_done" );
}

drone_view_shake( var_0 )
{
    self notify( "start_new_intro_shake" );
    self endon( "start_new_intro_shake" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "fly_drone_done" ) )
            break;

        earthquake( var_0, 0.1, level.player.origin, 200 );
        wait 0.1;
    }
}

showstatic( var_0 )
{
    level.overlaystatic = newhudelem( level.player );
    level.overlaystatic.x = 0;
    level.overlaystatic.y = 0;
    level.overlaystatic.alpha = 1;
    level.overlaystatic.horzalign = "fullscreen";
    level.overlaystatic.vertalign = "fullscreen";
    level.overlaystatic.sort = 4;
    level.overlaystatic setshader( "overlay_static_digital", 640, 480 );
    wait(var_0);
    level.overlaystatic destroy();
}

fly_drone_ui_on()
{
    setomnvar( "ui_lagosflydrone", 1 );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingame( "flydrone_UI" );
    common_scripts\utility::flag_wait( "drone_fly_anim_done" );
    fly_drone_ui_off();
}

fly_drone_ui_off()
{
    stopcinematicingame();
    setomnvar( "ui_lagosflydrone", 0 );
    wait 40.5;
    fly_drone_transition_on();
}

fly_drone_transition_on()
{
    setomnvar( "ui_lagosflydrone", 1 );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingame( "fly_drone_shut_down" );
    wait 1;
    thread maps\_introscreen::introscreen_generic_black_fade_in( 1, 0.89, 0.1 );
    level.player.overlay["black"].sort = -1;
    level.player.overlay["black"].foreground = 0;
    wait 5;
    fly_drone_transition_off();
}

fly_drone_transition_off()
{
    stopcinematicingame();
    setomnvar( "ui_lagosflydrone", 0 );
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

calculateleftstickdeadzone()
{
    var_0 = level.player getnormalizedmovement();
    var_0 = ( scalestickinput( var_0[0] ), scalestickinput( var_0[1] ), var_0[2] );
    return var_0;
}

stickinputindeadzone( var_0, var_1 )
{
    return abs( var_0 ) < var_1;
}

scalestickinput( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.25;

    if ( stickinputindeadzone( var_0, var_1 ) )
        return 0;

    return var_0 * ( abs( var_0 ) - var_1 ) / ( 1 - var_1 );
}

drone_panic_spawn( var_0 )
{
    var_1 = var_0 maps\_utility::spawn_ai();
    var_1.goalradius = 32;
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1.animname = "civilian_run";
    var_2 = randomintrange( 1, 6 );
    var_1 maps\_utility::set_run_anim( "civ_run_panic_" + var_2, 1 );
    var_1.run_override_weights = undefined;
    var_1.alertlevelint = 2;
    var_1 thread drone_panic_delete();
}

drone_panic_delete()
{
    self waittill( "goal" );
    self delete();
}

populate_drone_civilians( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        var_5 = var_0 maps\_utility::dronespawn();
        var_2 = common_scripts\utility::array_add( var_2, var_5 );
        var_0.count = 1;
        var_5.origin = var_4.origin;
        var_5.angles = var_4.angles;
        var_5.allowdeath = 0;
        var_5 thread civilian_drone_runner_collision();
        waitframe();

        if ( isdefined( var_4.script_squadname ) )
            var_5 thread civilian_anim_setup( var_4 );
        else
            var_5 thread loopingidleanimation( var_4 );

        if ( isdefined( var_4.script_noteworthy ) )
            var_5 thread stop_loop_and_react( var_4 );
    }

    return var_2;
}

civilian_drone_runner_collision()
{
    self endon( "goal" );
    self endon( "death" );

    while ( isdefined( self ) )
    {
        while ( distance( self.origin, level.player.origin ) > 100 )
            wait 0.1;

        var_0 = self setcontents( 0 );

        while ( distance( self.origin, level.player.origin ) <= 100 )
            wait 0.1;

        self setcontents( var_0 );
    }
}

populate_ai_civilians( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    foreach ( var_6 in var_1 )
    {
        var_7 = var_0 maps\_utility::spawn_ai();
        var_4 = common_scripts\utility::array_add( var_4, var_7 );
        var_0.count = 1;
        var_8 = spawn( "script_origin", var_6.origin );

        if ( isdefined( var_6.angles ) )
            var_8.angles = var_6.angles;

        var_8.animation = var_6.animation;
        var_8.script_noteworthy = var_6.script_noteworthy;
        var_8.script_parameters = var_6.script_parameters;
        var_8.script_index = var_6.script_index;
        var_8.script_squadname = var_6.script_squadname;
        var_8.script_nodestate = var_6.script_nodestate;
        var_7 immune_sonic_blast();
        var_7 teleport( var_8.origin, var_8.angles );
        waitframe();

        if ( isdefined( var_2 ) && var_2 == 1 )
        {
            if ( isdefined( var_8.script_squadname ) )
                var_7 thread civilian_anim_setup( var_8, var_3 );
            else
            {
                var_7 thread loopingidleanimation( var_8 );
                var_7 thread stop_loop_and_react( var_8 );
            }

            continue;
        }

        var_7 thread loopingidleanimation( var_8 );
    }

    return var_4;
}

civilian_anim_setup( var_0, var_1 )
{
    self endon( "death" );
    var_2 = float( var_0.script_index );
    var_3 = var_0.script_nodestate;
    var_4 = var_0.animation;
    var_5 = var_0.script_noteworthy;
    var_6 = var_0.script_parameters;
    var_7 = var_0.script_squadname;
    thread special_loopingidleanimation( var_0, var_4 );
    self.alertlevelint = 0;

    if ( isdefined( var_3 ) )
    {
        common_scripts\utility::flag_wait( var_3 );
        wait(randomfloatrange( 0.1, 0.75 ));
        var_0 notify( "stop_loop" );
        self.alertlevelint = 2;
        waitframe();
    }
    else
    {
        while ( self.alertlevelint < 2 )
        {
            wait 0.1;

            if ( !isdefined( self ) )
                return;

            foreach ( var_9 in level.alpha_squad_and_player )
            {
                if ( distance( self.origin, var_9.origin ) < var_2 )
                {
                    var_0 notify( "stop_loop" );
                    self.alertlevelint = 2;
                    waitframe();
                }
            }
        }
    }

    if ( isdefined( var_6 ) )
    {
        if ( issubstr( var_6, "panic" ) )
            self.animname = "civilian_react_move_back";
        else if ( issubstr( var_6, "run" ) )
            self.animname = "civilian_react_then_run";

        var_0 maps\_anim::anim_single_solo( self, var_6 );
        var_0.origin = self.origin;
        var_0.angles = self.angles;
    }

    if ( isdefined( var_5 ) )
    {
        self.animname = "civilian_react";
        var_0 thread maps\_anim::anim_loop_solo( self, var_5, "stop_loop" );
        common_scripts\utility::flag_wait( var_1 );
        wait(randomfloatrange( 0.1, 0.5 ));
        var_0 notify( "stop_loop" );
    }

    self setgoalvolumeauto( getent( var_7, "targetname" ) );
    thread cleanup_on_goal();
    var_0 delete();
}

walking_civilian_react()
{
    self endon( "death" );
    var_0 = getnode( self.target, "targetname" );
    var_1 = var_0.script_nodestate;
    var_2 = float( var_0.script_index );
    var_3 = var_0.script_noteworthy;
    var_4 = var_0.script_parameters;
    var_5 = var_0.script_squadname;
    self.alertlevelint = 0;

    if ( isdefined( var_1 ) )
    {
        common_scripts\utility::flag_wait( var_1 );
        self.alertlevelint = 2;
        waitframe();
    }
    else
    {
        while ( self.alertlevelint < 2 )
        {
            wait 0.1;

            if ( !isdefined( self ) )
                return;

            foreach ( var_7 in level.alpha_squad_and_player )
            {
                if ( distance( self.origin, var_7.origin ) < var_2 )
                {
                    self.alertlevelint = 2;
                    waitframe();
                }
            }
        }
    }

    wait(randomfloatrange( 0.1, 0.75 ));
    var_0 = spawn( "script_origin", self.origin );
    var_0.angles = self.angles;

    if ( isdefined( var_4 ) )
    {
        if ( issubstr( var_4, "panic" ) )
            self.animname = "civilian_react_move_back";
        else if ( issubstr( var_4, "run" ) )
            self.animname = "civilian_react_then_run";

        var_0 maps\_anim::anim_single_solo( self, var_4 );
        var_0.origin = self.origin;
        var_0.angles = self.angles;
    }

    if ( isdefined( var_3 ) )
    {
        self.animname = "civilian_react";
        var_0 thread maps\_anim::anim_loop_solo( self, var_3, "stop_loop" );
        common_scripts\utility::flag_wait( "flag_Roundabout_Civilians_Flee" );
        wait(randomfloatrange( 0.1, 0.75 ));
        var_0 notify( "stop_loop" );
    }

    self setgoalvolumeauto( getent( var_5, "targetname" ) );
    thread cleanup_on_goal();
    var_0 delete();
}

randomidleanimation( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_1 = common_scripts\utility::random( level.randomidleanims );
        var_0 maps\_anim::anim_generic( self, var_1 );
        waitframe();
    }
}

loopingidleanimation( var_0 )
{
    self.animname = "generic";
    var_1 = var_0.animation;
    var_0 thread maps\_anim::anim_generic_loop( self, var_1, "stop_loop" );
    var_2 = attachprops( var_1 );
    common_scripts\utility::waittill_either( "stop_loop", "death" );

    if ( isdefined( var_2 ) )
        var_2 delete();
}

attachprops( var_0 )
{
    if ( isdefined( self.hasattachedprops ) )
        return;

    initcivilianprops();
    var_1 = anim.civilianprops[var_0];

    if ( isdefined( var_1 ) )
    {
        self.attachedpropmodel = var_1;
        self.attachedproptag = "tag_inhand";
        var_2 = self attach( self.attachedpropmodel, self.attachedproptag, 1 );
        self.hasattachedprops = 1;
        return var_2;
    }
}

initcivilianprops()
{
    if ( isdefined( anim.civilianprops ) )
        return;

    anim.civilianprops = [];
    anim.civilianprops["civilian_texting_standing"] = "electronics_pda";
    anim.civilianprops["civilian_texting_sitting"] = "electronics_pda";
    anim.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_smoking_A"] = "prop_cigarette";
    anim.civilianprops["civilian_smoking_B"] = "prop_cigarette";
    anim.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
    anim.civilianprops["oilrig_balcony_smoke_idle"] = "prop_cigarette";
    anim.civilianprops["guardB_sit_drinker_idle"] = "cs_coffeemug02";
    anim.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_reader_1"] = "lab_tablet_flat_on";
    anim.civilianprops["civilian_reader_2"] = "lab_tablet_flat_on";
    anim.civilianprops["civilian_briefcase_walk"] = "hjk_metal_briefcase";
    anim.civilianprops["civilian_crazy_walk"] = "electronics_pda";
    anim.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
    anim.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
    anim.civilianprops["civilian_paper_walk"] = "paper_memo";
    anim.civilianprops["civilian_coffee_walk"] = "cs_coffeemug02";
    anim.civilianprops["civilian_pda_walk"] = "electronics_pda";
}

stop_loop_and_react( var_0 )
{
    switch ( var_0.script_noteworthy )
    {
        case "location_rb_lobby_exit":
            common_scripts\utility::flag_wait( "flag_roundabout_move_1" );
            break;
        case "location_rb_lobby_exit_stairs":
            common_scripts\utility::flag_wait( "flag_roundabout_move_1" );
            break;
        case "location_rb_lobby_exit_sidewalk":
            common_scripts\utility::flag_wait( "flag_roundabout_move_2" );
            break;
        case "location_rb_street_northwest":
            common_scripts\utility::flag_wait( "flag_roundabout_move_3" );
            break;
        case "location_rb_street_middle":
            common_scripts\utility::flag_wait( "roundabout_combat_begin" );
            break;
        default:
            common_scripts\utility::flag_wait( "flag_roundabout_move_5" );
            break;
    }

    if ( isdefined( self ) )
    {
        wait(randomfloatrange( 0.1, 0.75 ));
        var_0 notify( "stop_loop" );
        self.animname = "civilian_react";
        var_1 = randomintrange( 1, 5 );
        var_2 = "civ_idle_panic_" + var_1;
        var_0 thread maps\_anim::anim_loop_solo( self, var_2, "stop_loop" );
        common_scripts\utility::flag_wait( "flag_Roundabout_Civilians_Flee" );
        level.rb_flee_goal_pick++;
        var_3 = randomintrange( 1, 8 );
        var_0 notify( "stop_loop" );
        wait(randomfloatrange( 0.1, 0.75 ));
        civilain_flee_to_goal();
    }

    var_0 delete();
}

civilain_flee_to_goal()
{
    self endon( "death" );
    var_0 = level.roundabout_flee_goals;
    var_1 = 0;

    while ( !var_1 )
    {
        foreach ( var_3 in var_0 )
            var_3.distance_to_goalvol_sq = distancesquared( self.origin, var_3.origin );

        var_0 = common_scripts\utility::array_sort_with_func( var_0, ::closer_to_goal_vol );
        self setgoalvolumeauto( var_0[0] );
        thread cleanup_on_goal();
        var_5 = common_scripts\utility::waittill_any_return( "bad_path", "goal" );

        if ( var_5 == "goal" )
            var_1 = 1;
        else if ( var_5 == "bad_path" )
            var_0 = common_scripts\utility::array_remove( var_0, var_0[0] );

        if ( var_0.size < 1 )
        {
            if ( isdefined( self ) && isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
                maps\_utility::stop_magic_bullet_shield();

            maps\_shg_design_tools::delete_auto();
            return;
        }
    }
}

closer_to_goal_vol( var_0, var_1 )
{
    return var_0.distance_to_goalvol_sq < var_1.distance_to_goalvol_sq;
}

farther_to_goal_vol( var_0, var_1 )
{
    return var_0.distance_to_goalvol_sq > var_1.distance_to_goalvol_sq;
}

special_loopingidleanimation( var_0, var_1 )
{
    self.animname = "generic";
    var_2 = var_1;
    var_0 thread maps\_anim::anim_generic_loop( self, var_2, "stop_loop" );
    var_3 = attachprops( var_2 );
    self waittill( "death" );

    if ( isdefined( var_3 ) )
        var_3 delete();
}

delete_at_path_end()
{
    self waittill( "reached_path_end" );
    self.allowdeath = 1;

    if ( isalive( self ) )
        self kill();

    wait 0.1;

    if ( isdefined( self ) )
        self delete();
}

#using_animtree("generic_human");

bike_rider( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = getent( var_2.target, "targetname" );
    var_4 = spawn( "script_model", var_2.origin );
    var_4 setmodel( "com_bike_animated" );
    var_4 useanimtree( level.scr_animtree["bike"] );
    var_5 = spawn( "script_model", var_4.origin );
    var_5 useanimtree( #animtree );

    if ( !isdefined( level.spawned_bike_rider ) )
    {
        level.spawned_bike_rider = 1;
        var_5 character\character_civilian_slum_male_aa::main();
    }
    else
        var_5 character\character_civilian_slum_male_ab::main();

    var_5.origin = var_4 gettagorigin( "j_frame" );
    var_5.origin += ( -12, 0, -30 );
    var_5.angles = var_4 gettagangles( "j_frame" );
    var_5.angles += ( 0, 180, 0 );
    var_5 linkto( var_4, "j_frame" );
    var_6 = vectortoangles( var_2.origin - var_3.origin );
    var_4.angles = ( 0, var_6[1], 0 );
    var_4 setanim( level.scr_anim["bike"]["pedal"] );
    var_5 setanim( level.scr_anim["generic"]["bike_rider"] );
    var_4 moveto( var_3.origin, var_1, 0, 0 );
    wait(var_1);
    var_5 delete();
    var_4 delete();
}

civilian_get_out_of_car_setup( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = get_civilian_car( var_0 );

    if ( isdefined( var_5 ) )
    {
        var_6 = undefined;

        if ( issubstr( var_1, "drone" ) )
            var_6 = get_civilian_drone( var_1, var_5.animname );
        else
            var_6 = get_civilian_ai( var_1, var_5.animname );

        if ( issubstr( var_5.vehicle_spawner.targetname, "roundabout_lobby" ) )
            var_6["ai"].target = var_5.vehicle_spawner.targetname + "_target";

        level thread civilian_in_car_get_out( var_5, var_6, var_2, var_3, var_4 );
    }
}

#using_animtree("vehicles");

get_civilian_car( var_0 )
{
    var_1 = maps\_utility::get_vehicle( var_0, "targetname" );

    if ( issubstr( var_1.model, "sedan" ) )
    {
        var_1.animname = "sedan";
        var_1 useanimtree( #animtree );
    }
    else if ( issubstr( var_1.model, "compact" ) )
    {
        var_1.animname = "compact";
        var_1 useanimtree( #animtree );
    }
    else if ( issubstr( var_1.model, "truck" ) )
    {
        var_1.animname = "truck";
        var_1 useanimtree( #animtree );
    }
    else
        var_1 = undefined;

    return var_1;
}

get_civilian_ai( var_0, var_1 )
{
    var_2 = [];
    var_3 = getent( var_0, "targetname" );

    if ( !isdefined( var_3.count ) || var_3.count < 1 )
        var_3.count = 1;

    var_2["ai"] = var_3 maps\_utility::spawn_ai( 1, 0 );
    var_2["ai"] immune_sonic_blast();
    var_2["ai"].ignoreall = 1;
    var_2["ai"].animname = var_1 + "_driver";

    if ( isdefined( var_3.target ) )
        var_2["goal"] = getnode( var_3.target, "targetname" );

    return var_2;
}

get_civilian_drone( var_0, var_1 )
{
    var_2 = [];
    var_3 = getent( var_0, "targetname" );

    if ( !isdefined( var_3.count ) || var_3.count < 1 )
        var_3.count = 1;

    var_2["ai"] = var_3 maps\_utility::dronespawn();
    var_2["ai"].ignoreall = 1;
    var_2["ai"].animname = var_1 + "_driver";
    var_2["ai"].allowdeath = 0;
    var_2["ai"].damageshield = 1;
    var_2["ai"] thread civilian_drone_runner_collision();
    return var_2;
}

civilian_in_car_get_out( var_0, var_1, var_2, var_3, var_4 )
{
    level.player endon( "death" );
    var_1["ai"] endon( "death" );
    var_5 = randomintrange( 1, 3 );
    var_1["ai"] linkto( var_0, "tag_driver" );
    var_0 thread maps\_anim::anim_loop_solo( var_1["ai"], "loop_0" + var_5, "stop_driver_loop", "tag_driver" );

    if ( isdefined( var_1["ai"] ) )
    {
        level waittill( var_2 );
        wait(randomfloatrange( 0.1, 0.6 ));
        var_1["ai"] unlink();
        var_1["ai"] maps\_utility::set_run_anim( "run_0" + var_5, 1 );
        var_1["ai"].run_override_weights = undefined;
        var_0 notify( "stop_driver_loop" );
        var_0 thread maps\_anim::anim_single_solo( var_0, "get_out_0" + var_5 );
        var_0 maps\_anim::anim_single_solo_run( var_1["ai"], "get_out_0" + var_5, "tag_driver" );

        if ( isdefined( var_1["ai"].script_moveoverride ) )
            var_1["ai"] thread maps\_drone::drone_move();
        else
            var_1["ai"] civilain_flee_to_goal();

        if ( isdefined( var_1["ai"] ) && isalive( var_1["ai"] ) )
            var_1["ai"] thread cleanup_on_goal();
    }
}

roundabout_civilian_flee_path_and_run_select()
{
    level.rb_flee_goal_pick++;
    var_0 = randomintrange( 1, 8 );

    if ( isdefined( self ) && isalive( self ) )
    {
        self.animname = "civilian_run";
        maps\_utility::set_run_anim( "civ_run_panic_" + var_0 );
        civilain_flee_to_goal();
    }
}

cleanup_on_goal()
{
    self endon( "death" );

    if ( isdefined( self ) )
    {
        self waittill( "goal" );

        if ( isdefined( self ) && isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
            maps\_utility::stop_magic_bullet_shield();

        maps\_shg_design_tools::delete_auto();
    }
}

civilian_loop_setup( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = getent( var_0, "targetname" );
    var_3[0] = var_4 maps\_utility::spawn_ai( 1, 0 );

    if ( !isdefined( var_3[0] ) )
        return;

    var_3[0].animname = "civilian";
    var_3[0].ignoreall = 1;

    if ( isdefined( var_1 ) )
    {
        var_5 = getent( var_1, "targetname" );
        var_3[1] = var_5 maps\_utility::spawn_ai( 1, 0 );

        if ( !isdefined( var_3[1] ) )
            var_3[0].script_noteworthy = "seated";
        else
        {
            var_3[1].animname = "civilian_b";
            var_3[1].ignoreall = 1;
        }
    }

    level thread start_civilian_loop_anims( var_3, var_2 );

    foreach ( var_7 in var_3 )
        var_7 thread no_civilian_friendly_fire_until_seen();
}

no_civilian_friendly_fire_until_seen()
{
    self endon( "death" );
    self.no_friendly_fire_penalty = 1;
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0.5;

    for (;;)
    {
        if ( maps\_utility::player_can_see_ai( self ) )
            break;

        if ( player_can_see_civ( self ) )
            break;

        wait(var_0);
    }

    self.no_friendly_fire_penalty = undefined;
}

player_can_see_civ( var_0 )
{
    if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_0.origin, 0.743 ) )
        return 0;

    var_1 = level.player geteye();
    var_2 = undefined;

    for ( var_3 = 0; var_3 < 2; var_3++ )
    {
        var_4 = var_0.origin;
        var_5 = var_0 geteye();
        var_6 = ( var_5 + var_4 ) * 0.5;
        var_7 = bullettrace( var_1, var_6, 0, var_2 );

        if ( var_7["fraction"] < 0.99 )
        {
            if ( isdefined( var_7["entity"] ) && isai( var_7["entity"] ) && var_7["entity"] != var_0 )
                var_2 = var_7["entity"];
        }
        else
            return 1;

        if ( !isdefined( var_2 ) )
            break;
    }

    return 0;
}

start_civilian_loop_anims( var_0, var_1 )
{
    wait(randomfloatrange( 0.0, 0.25 ));

    if ( isalive( var_0[0] ) && !isalive( var_0[1] ) )
    {
        if ( var_0[0].script_noteworthy == "paired" )
            var_0[0].script_noteworthy = "seated";
    }
    else if ( !isalive( var_0[0] ) && isalive( var_0[1] ) )
    {
        var_0[0] = var_0[1];
        var_0[1] = undefined;
        var_0[0].script_noteworthy = "seated";
    }
    else if ( !isalive( var_0[0] ) && !isalive( var_0[1] ) )
        return;

    if ( !isdefined( var_0[0].script_noteworthy ) )
        return;

    if ( var_0[0].script_noteworthy == "laying" )
    {
        if ( randomint( 100 ) < 50 )
            var_2 = "laying_1";
        else
            var_2 = "laying_2";

        var_0[0] thread maps\_anim::anim_loop_solo( var_0[0], var_2, var_1 );
    }
    else if ( var_0[0].script_noteworthy == "seated" )
    {
        var_3 = randomint( 100 );

        if ( var_3 < 33 )
            var_2 = "seated_1";
        else if ( var_3 < 66 )
            var_2 = "seated_2";
        else
            var_2 = "seated_3";

        var_0[0] thread maps\_anim::anim_loop_solo( var_0[0], var_2, var_1 );
    }
    else if ( var_0[0].script_noteworthy == "paired" )
    {
        if ( randomint( 100 ) < 50 )
            var_2 = "paired_1";
        else
            var_2 = "paired_2";

        var_0[0] thread maps\_anim::anim_loop( var_0, var_2, var_1 );
    }
    else
    {

    }

    level thread civilian_clean_up( var_0, var_1 );
}

civilian_clean_up( var_0, var_1 )
{
    level waittill( var_1 );
    wait 1.0;

    foreach ( var_3 in var_0 )
    {
        if ( isalive( var_3 ) )
        {
            var_3 notify( var_1 );
            var_3 delete();
        }
    }
}

ignore_all_until_path_end()
{
    self endon( "death" );
    self.ignoreall = 1;
    self waittill( "reached_path_end" );
    self.ignoreall = 0;
}

delete_civilian_at_trigger()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( var_0.team == "neutral" )
            var_0 delete();

        wait 0.1;
    }
}

start_vehicle_traffic_highway_traverse()
{
    var_0 = getvehiclenodearray( "highway_path_player_side_1", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.do_pathbased_avoidance = 1;
        var_2.dont_spawn_over_obstacles = 1;
        var_2.lagoshack = 1;
        var_2.vehicle_easy_crash_die = 1;
    }

    maps\_vehicle_traffic::mark_nodes_near_spawnnodes_and_startnodes( "highway_path_player_side_1" );
    maps\_vehicle_traffic::traffic_set_traffic_tuning_lagos_highway();
    wait 0.25;
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "highway_path_other_side", "highway_damageable_vehicle_spawner", 1, level.player, 10, 1, 1 );
    thread start_vehicle_traffic_highway_traverse_player_side();
}

start_vehicle_traffic_highway_traverse_player_side()
{
    if ( common_scripts\utility::flag( "flag_player_jump2" ) )
        return;

    change_spawn_chance_highway_path_player_side( [ "1", "2", "3", "4" ], 100 );
    change_spawn_dist_highway_path_player_side( [ "1", "2", "3", "4" ], 4000 );
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "highway_path_player_side", "highway_damageable_vehicle_spawner", 1, level.player, 20, 1, 1, 0 );
    common_scripts\utility::flag_wait( "flag_highway_ledge_climb_started" );
    thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 1 );
    thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 2 );
    thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 3 );
    thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 4 );

    if ( level.currentgen )
    {
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 5 );
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 6 );
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 7 );
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 8 );
    }

    set_force_script_models_highway_path_player_side( [ "1", "2", "3", "4" ], 0 );
    common_scripts\utility::delay_script_call( 0.0, ::disable_highway_path_player_side, [ "1" ] );
    common_scripts\utility::delay_script_call( 5, ::disable_highway_path_player_side, [ "3" ] );
    common_scripts\utility::delay_script_call( 7, ::enable_highway_path_player_side, [ "1" ] );
    level.player waittill( "traffic_traverse_start_player" );

    if ( level.nextgen )
    {
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 5 );
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 6 );
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 7 );
        thread maps\lagos_code::destroy_all_frogger_vehicles_lane( 8 );
    }

    change_spawn_dist_highway_path_player_side( [ "1", "2", "3", "4" ], 2600 );
    wait 2;
    change_spawn_dist_highway_path_player_side( [ "1", "2", "3", "4" ], 10000 );
    change_spawn_chance_highway_path_player_side( [ "1", "2", "3", "4" ], 10 );
}

start_middle_takedown_highway_path_player_side()
{
    delete_highway_player_side();
}

post_middle_takedown_highway_path_player_side()
{
    if ( !isdefined( level.post_middle_takedown_traffic_done ) )
        level.post_middle_takedown_traffic_done = 1;
    else
        return;

    waitframe();
    reset_highway_path_player_side( [ "2", "3", "4" ], 10, 8000.0 );
    wait 2;
    enable_highway_path_player_side( [ "1" ] );
}

start_end_takedown_highway_path_player_side()
{
    if ( !isdefined( level.start_end_takedown_traffic_done ) )
        level.start_end_takedown_traffic_done = 1;
    else
        return;

    delete_highway_player_side();
}

set_force_script_models_highway_path_player_side( var_0, var_1 )
{
    var_2 = getvehiclenodearray( "highway_path_player_side_1", "targetname" );

    foreach ( var_4 in var_2 )
    {
        foreach ( var_6 in var_0 )
        {
            if ( isdefined( var_4.script_noteworthy ) && var_4.script_noteworthy == var_6 )
                var_4.traffic_force_script_models_only = var_1;
        }
    }
}

enable_highway_path_player_side( var_0, var_1 )
{
    disable_highway_path_player_side( var_0, 0 );
}

disable_highway_path_player_side( var_0, var_1 )
{
    var_2 = getvehiclenodearray( "highway_path_player_side_1", "targetname" );

    foreach ( var_4 in var_2 )
    {
        foreach ( var_6 in var_0 )
        {
            if ( isdefined( var_4.script_noteworthy ) && var_4.script_noteworthy == var_6 )
            {
                if ( !isdefined( var_1 ) || var_1 )
                {
                    var_4.nospawn = 1;
                    continue;
                }

                var_4.nospawn = 0;
            }
        }
    }
}

change_spawn_dist_highway_path_player_side( var_0, var_1 )
{
    var_2 = getvehiclenodearray( "highway_path_player_side_1", "targetname" );

    foreach ( var_4 in var_2 )
    {
        foreach ( var_6 in var_0 )
        {
            if ( isdefined( var_4.script_noteworthy ) && var_4.script_noteworthy == var_6 )
            {
                if ( isdefined( var_1 ) )
                    var_4.despawn_dist_sq = float( var_1 ) * float( var_1 );
            }
        }
    }
}

change_spawn_chance_highway_path_player_side( var_0, var_1 )
{
    var_2 = getvehiclenodearray( "highway_path_player_side_1", "targetname" );

    foreach ( var_4 in var_2 )
    {
        foreach ( var_6 in var_0 )
        {
            if ( isdefined( var_4.script_noteworthy ) && var_4.script_noteworthy == var_6 )
            {
                if ( isdefined( var_1 ) )
                    var_4.spawn_chance_override = var_1;
            }
        }
    }
}

reset_highway_path_player_side( var_0, var_1, var_2, var_3 )
{
    delete_highway_player_side();
    var_4 = undefined;
    var_5 = getvehiclenodearray( "highway_path_player_side_1", "targetname" );

    foreach ( var_7 in var_5 )
    {
        var_7.nospawn = 1;
        var_7.despawn_dist_sq = float( var_2 ) * float( var_2 );
    }

    foreach ( var_7 in var_5 )
    {
        foreach ( var_11 in var_0 )
        {
            if ( isdefined( var_7.script_noteworthy ) && var_7.script_noteworthy == var_11 )
            {
                var_7.nospawn = 0;

                if ( isdefined( var_1 ) )
                    var_7.spawn_chance_override = var_1;
            }
        }
    }

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    level.traffic_tune_no_spawn = undefined;
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "highway_path_player_side", "highway_damageable_vehicle_spawner", 1, level.player, 20, 1, var_3, 0, var_4 );
}

delete_highway_player_side()
{
    level.traffic_tune_no_spawn = "highway_path_player_side";
    thread maps\_vehicle_traffic::delete_traffic_path( "highway_path_player_side" );
}

start_vehicle_traffic_roundabout_straightways()
{
    wait 0.25;
    maps\_vehicle_traffic::traffic_set_traffic_tuning( 1 );
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "east_lane_inner", "roundabout_damageable_vehicle_spawner", 1, undefined, 10, 1, 1 );
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "east_lane_outer", "roundabout_damageable_vehicle_spawner", 1, undefined, 10, 1, 1 );
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "east_lane_split", "roundabout_damageable_vehicle_spawner", 0, undefined, 10, 1, 1 );
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "west_lane", "roundabout_damageable_vehicle_spawner", 1, undefined, 10, 1, 1 );
    thread maps\_vehicle_traffic::setup_traffic_path_with_options( "highway_westward", "roundabout_damageable_vehicle_spawner", 1, undefined, 10, 1, 1 );
    thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam( "west_lane" );
    thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam( "highway_westward" );
    thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam( "west_lane" );
    thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam( "east_lane_outer" );
}

resume_vehicle_traffic_roundabout_straightways()
{
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_inner", 0 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_outer", 0 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_split", 0 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "west_lane", 0 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "highway_westward", 0 );
    var_0 = getvehiclenode( "pf2_auto4204", "targetname" );
    var_0.is_blockage = undefined;
    var_0 = getvehiclenode( "pf2_auto4205", "targetname" );
    var_0.is_blockage = undefined;
    var_1 = 0;
}

delete_vehicle_traffic_roundabout_straightways()
{
    thread maps\_vehicle_traffic::delete_traffic_path( "east_lane_inner" );
    thread maps\_vehicle_traffic::delete_traffic_path( "east_lane_outer" );
    thread maps\_vehicle_traffic::delete_traffic_path( "east_lane_split" );
    thread maps\_vehicle_traffic::delete_traffic_path( "west_lane" );
    thread maps\_vehicle_traffic::delete_traffic_path( "highway_westward" );
    var_0 = getvehiclenode( "pf2_auto4204", "targetname" );
    var_0.is_blockage = undefined;
    var_0 = getvehiclenode( "pf2_auto4205", "targetname" );
    var_0.is_blockage = undefined;
}

stop_vehicle_traffic_roundabout_straightways()
{
    var_0 = getvehiclenode( "east_lane_inner_1", "targetname" );
    var_1 = getvehiclenode( "east_lane_outer_1", "targetname" );
    var_0 notify( "stop_traffic_lane" );
    var_1 notify( "stop_traffic_lane" );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "west_lane", 1 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "highway_westward", 1 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_inner", 1 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_outer", 1 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_split", 1 );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4204" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4205" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4206" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4207" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4208" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4209" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4196" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4197" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4198" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4199" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_split", "pf2_highway_path_1" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_split", "pf2_auto4232" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4200" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4202" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_inner", "pf2_auto4210" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4201" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4203" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_outer", "pf2_auto4211" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_split", "pf2_auto4233" );
    thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker( "west_lane", "pf2_auto4083" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "west_lane", "pf2_auto4077" );
    thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker( "west_lane", "pf2_auto4071" );
    thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker( "west_lane", "pf2_auto4090" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "west_lane", "pf2_auto4084" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "west_lane", "pf2_auto4078" );
    thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker( "west_lane", "pf2_auto4072" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_split", "pf2_auto4230" );
    thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node( "east_lane_split", "pf2_auto4231" );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_inner", 1 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_outer", 1 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "east_lane_split", 1 );
    thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop( "west_lane", 1 );
}

rumble_flydrone_animation()
{
    wait 0.75;
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.08 );
    common_scripts\utility::flag_wait( "drone_fly_anim_done" );
    wait 2.5;
    var_0 stoprumble( "steady_rumble" );
    var_0 delete();
}

rumble_flydrone_control()
{
    if ( common_scripts\utility::flag( "intro_playerstart" ) )
        return;

    level.fly_drone_rumbling = 1;
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.08 );
    level waittill( "fly_drone_not_moving" );
    var_0 stoprumble( "steady_rumble" );
    var_0 delete();
    level.fly_drone_rumbling = 0;
}

rumble_roundabout_rpg_car_hit()
{
    if ( distance( self.origin, level.player.origin ) > 500 )
        return;
    else if ( distance( self.origin, level.player.origin ) <= 500 && distance( self.origin, level.player.origin ) >= 250 )
    {
        level.player playrumbleonentity( "damage_heavy" );
        earthquake( 0.5, 0.75, level.player.origin, 1000 );
        return;
    }
    else if ( distance( self.origin, level.player.origin ) < 250 )
    {
        level.player playrumbleonentity( "artillery_rumble" );
        earthquake( 1, 0.75, level.player.origin, 1000 );
        return;
    }
}

rumble_roundabout_tanker()
{
    var_0 = getent( "magicOrg_roundabout_tanker_dest", "targetname" );

    if ( distance( var_0.origin, level.player.origin ) > 1750 )
        return;
    else if ( distance( var_0.origin, level.player.origin ) <= 1750 && distance( var_0.origin, level.player.origin ) >= 1200 )
    {
        level.player playrumbleonentity( "damage_heavy" );
        return;
    }
    else if ( distance( var_0.origin, level.player.origin ) < 1200 )
    {
        level.player playrumbleonentity( "artillery_rumble" );
        return;
    }
}

rumble_frogger_vehicles()
{
    var_0 = level.player maps\_utility::get_rumble_ent( "heavy_1s" );
    var_0 maps\_utility::set_rumble_intensity( 0.01 );
    var_0 maps\_utility::rumble_ramp_to( 1, 0.5 );
    wait 0.5;
    var_0 stoprumble( "heavy_1s" );
    var_0 delete();
}

disable_exo_for_highway()
{
    maps\_player_exo::player_exo_remove_single( "boost_dash" );
}

challenge_point_award()
{
    if ( isdefined( self.damagelocation ) && issubstr( self.damagelocation, "head" ) )
        level.player maps\_upgrade_challenge::give_player_challenge_headshot( 1 );
    else
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
}

challenge_point_award_on_damage()
{
    self waittill( "damage" );
    challenge_point_award();
}

hint_instant( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = 0.5;
    level endon( "clearing_hints" );

    if ( isdefined( level.hintelement ) )
        level.hintelement maps\_hud_util::destroyelem();

    level.hintelement = maps\_hud_util::createfontstring( "default", 1.5 );
    level.hintelement maps\_hud_util::setpoint( "MIDDLE", undefined, 0, 30 + var_2 );
    level.hintelement.color = ( 1, 1, 1 );
    level.hintelement settext( var_0 );
    level.hintelement.alpha = 0;
    level.hintelement.alpha = 1;
    wait 0.5;
    level.hintelement endon( "death" );

    if ( isdefined( var_1 ) )
        wait(var_1);
    else
        return;

    level.hintelement fadeovertime( var_3 );
    level.hintelement.alpha = 0;
    wait(var_3);
    level.hintelement maps\_hud_util::destroyelem();
}

hint_fade_instant()
{
    if ( isdefined( level.hintelement ) )
    {
        level notify( "clearing_hints" );
        level.hintelement.alpha = 0;
    }
}

ignore_until_goal_reached()
{
    self.ignoreall = 1;
    common_scripts\utility::waittill_notify_or_timeout( "goal", 5 );

    if ( isdefined( self ) && isalive( self ) )
        self.ignoreall = 0;
}

ignore_until_timeout( var_0 )
{
    self.ignoreme = 1;
    wait(var_0);

    if ( isdefined( self ) && isalive( self ) )
        self.ignoreme = 0;
}

lagos_custom_laser()
{
    thread animscripts\utility::follow_enemy_with_laser( self, "lag_snipper_laser" );
}

spawn_wave_upkeep_and_flag( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    while ( !common_scripts\utility::flag( var_1 ) )
    {
        var_0 = maps\_utility::array_removedead_or_dying( var_0 );

        if ( var_0.size <= var_2 )
        {
            wait(var_3);
            common_scripts\utility::flag_set( var_1 );
        }

        waitframe();
    }
}

spawn_wave_upkeep_and_block( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    for (;;)
    {
        var_0 = maps\_utility::array_removedead_or_dying( var_0 );

        if ( var_0.size <= var_1 )
        {
            wait(var_2);
            return;
        }

        waitframe();
    }
}

kill_after_timeout( var_0, var_1, var_2 )
{
    wait(var_1);

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4 ) && isalive( var_4 ) )
        {
            var_4 kill();

            if ( isdefined( var_2 ) && var_2 )
                wait(randomfloatrange( 0.75, 1.25 ));
        }
    }
}

timeout_and_flag( var_0, var_1 )
{
    wait(var_1);

    if ( !common_scripts\utility::flag( var_0 ) )
        common_scripts\utility::flag_set( var_0 );
}

notify_on_flag( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_1 );
    self notify( var_0 );
}

vehicle_unload_how_at_end( var_0 )
{
    self waittill( "reached_end_node" );

    if ( isdefined( var_0 ) )
        maps\_vehicle::vehicle_unload( var_0 );
    else
        maps\_vehicle::vehicle_unload();
}

delete_after_wait( var_0, var_1 )
{
    wait(var_1);
    var_0 delete();
}

equip_microwave_grenade()
{
    self.grenadeweapon = "microwave_grenade";
    self.grenadeammo = 2;
}

immune_sonic_blast()
{
    self.ignoresonicaoe = 1;
}

setup_ai_for_bus_sequence()
{
    self allowedstances( "stand" );
    self.a.disablepain = 1;
    self.dontavoidplayer = 1;
    self.nododgemove = 1;
    self.badplaceawareness = 0;
    self.dontmelee = 1;
    self.doorflashchance = 0.05;
    self.aggressivemode = 1;
    self.ignoresuppression = 1;
    self.no_pistol_switch = 1;
    self.norunngun = 1;
    self.disablebulletwhizbyreaction = 1;
    self.nogrenadereturnthrow = 1;
    var_0 = self.grenadeawareness;
    self.grenadeawareness = 0;
}

disable_awareness()
{
    self.ignoreall = 1;
    self.dontmelee = 1;
    self.ignoresuppression = 1;
    self.suppressionwait_old = self.suppressionwait;
    self.suppressionwait = 0;
    maps\_utility::disable_surprise();
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_pain();
    self.grenadeawareness = 0;
    maps\_utility::enable_dontevershoot();
    self.disablefriendlyfirereaction = 1;
    self.dodangerreact = 0;
}

enable_awareness()
{
    self.ignoreall = 0;
    self.dontmelee = undefined;
    self.ignoresuppression = 0;

    if ( isdefined( self.suppressionwait_old ) )
        self.suppressionwait = self.suppressionwait_old;

    self.suppressionwait_old = undefined;
    maps\_utility::enable_surprise();
    self.ignorerandombulletdamage = 0;
    maps\_utility::enable_bulletwhizbyreaction();
    maps\_utility::enable_pain();
    self.grenadeawareness = 1;
    self.ignoreme = 0;
    maps\_utility::disable_dontevershoot();
    self.disablefriendlyfirereaction = undefined;
    self.dodangerreact = 1;
}

fake_linkto( var_0, var_1, var_2, var_3 )
{
    thread fake_linkto_internal( var_0, var_1, var_2, var_3 );
}

fake_linkto_internal( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_0 endon( "death" );
    self notify( "fake_unlink" );
    self endon( "fake_unlink" );

    if ( !isdefined( var_2 ) || !isdefined( var_3 ) )
    {
        if ( isdefined( var_1 ) )
        {
            var_4 = var_0 gettagorigin( var_1 );
            var_5 = var_0 gettagangles( var_1 );
        }
        else
        {
            var_4 = var_0.origin;
            var_5 = var_0.angles;
        }

        var_6 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), var_4, var_5, self.origin, self.angles );
        var_2 = var_6["origin"];
        var_3 = var_6["angles"];
    }

    for (;;)
    {
        if ( isdefined( var_1 ) )
        {
            var_4 = var_0 gettagorigin( var_1 );
            var_5 = var_0 gettagangles( var_1 );
        }
        else
        {
            var_4 = var_0.origin;
            var_5 = var_0.angles;
        }

        var_6 = transformmove( var_4, var_5, ( 0, 0, 0 ), ( 0, 0, 0 ), var_2, var_3 );
        self.origin = var_6["origin"];
        self.angles = var_6["angles"];
        waitframe();
    }
}

fake_unlink()
{
    self notify( "fake_unlink" );
}

magic_threat_grenade( var_0, var_1, var_2 )
{
    var_3 = magicgrenade( "paint_grenade_var", var_0.origin, var_1.origin, var_2 );

    if ( isdefined( var_3 ) )
        var_3 thread maps\_variable_grenade::detection_grenade_think( level.player );
}

boost_jump_toggle()
{
    level.player notifyonplayercommand( "use_boost_jump", "+actionslot 1" );

    for (;;)
    {
        level.player waittill( "use_boost_jump" );
        level.player maps\_player_high_jump::enable_high_jump();
        level.player maps\_utility::blend_movespeedscale_percent( 150, 1 );
        level.player waittill( "use_boost_jump" );
        level.player maps\_player_high_jump::disable_high_jump();
        level.player maps\_utility::blend_movespeedscale_percent( 100, 1 );
    }
}

ally_redirect_goto_node( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = undefined;

    foreach ( var_10 in level.alpha_squad )
    {
        if ( isdefined( var_10.script_friendname ) && var_10.script_friendname == var_0 )
            var_8 = var_10;
    }

    var_12 = getnode( var_1, "targetname" );

    if ( isdefined( var_8.node ) )
        var_8.node maps\_utility::script_delay();

    var_8 maps\_utility::enable_ai_color();
    var_8 maps\_utility::set_goal_node( var_12 );

    if ( isdefined( var_3 ) )
        var_8 thread exec_function( var_2, var_3, var_4, var_5, var_6, var_7 );
}

exec_function( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 0;

    if ( isdefined( var_5 ) )
        var_6 = 4;
    else if ( isdefined( var_4 ) )
        var_6 = 3;
    else if ( isdefined( var_3 ) )
        var_6 = 2;
    else if ( isdefined( var_2 ) )
        var_6 = 1;

    if ( var_0 == 1 )
    {
        switch ( var_6 )
        {
            case 0:
                thread [[ var_1 ]]();
                break;
            case 1:
                thread [[ var_1 ]]( var_2 );
                break;
            case 2:
                thread [[ var_1 ]]( var_2, var_3 );
                break;
            case 3:
                thread [[ var_1 ]]( var_2, var_3, var_4 );
                break;
            case 4:
                thread [[ var_1 ]]( var_2, var_3, var_4, var_5 );
                break;
        }
    }
    else
    {
        switch ( var_6 )
        {
            case 0:
                [[ var_1 ]]();
                break;
            case 1:
                [[ var_1 ]]( var_2 );
                break;
            case 2:
                [[ var_1 ]]( var_2, var_3 );
                break;
            case 3:
                [[ var_1 ]]( var_2, var_3, var_4 );
                break;
            case 4:
                [[ var_1 ]]( var_2, var_3, var_4, var_5 );
                break;
        }
    }
}

assign_goal_vol( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        var_2 = getent( var_0, "targetname" );
        self setgoalvolumeauto( var_2 );

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
}

assign_goal_node( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        var_2 = getnode( var_0, "targetname" );
        self setgoalnode( var_2 );

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
}

setupenemygoalvolumesettings( var_0, var_1 )
{
    var_0 = common_scripts\utility::array_randomize( var_0 );

    if ( level.player istouching( var_0[0] ) )
    {
        self setgoalvolumeauto( var_0[1] );
        waitframe();

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
    else
    {
        self setgoalvolumeauto( var_0[0] );
        waitframe();

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
}

ally_move_dynamic_speed()
{
    self notify( "start_dynamic_run_speed" );
    self endon( "death" );
    self endon( "stop_dynamic_run_speed" );
    self endon( "start_dynamic_run_speed" );

    if ( maps\_utility::ent_flag_exist( "_stealth_custom_anim" ) )
        maps\_utility::ent_flag_waitopen( "_stealth_custom_anim" );

    self.run_speed_state = "";
    ally_reset_dynamic_speed();
    var_0 = 144;
    var_1 = [ "sprint", "run" ];
    var_2 = [];
    var_2["player_sprint"]["sprint"][0] = 225 * var_0;
    var_2["player_sprint"]["sprint"][1] = 900 * var_0;
    var_2["player_sprint"]["run"][0] = 900 * var_0;
    var_2["player_sprint"]["run"][1] = 900 * var_0;
    var_2["player_run"]["sprint"][0] = 225 * var_0;
    var_2["player_run"]["sprint"][1] = 400 * var_0;
    var_2["player_run"]["run"][0] = 400 * var_0;
    var_2["player_run"]["run"][1] = 625 * var_0;
    var_2["player_crouch"]["run"][0] = 4 * var_0;
    var_2["player_crouch"]["run"][1] = 100 * var_0;
    var_3 = 123;
    var_4 = 189;
    var_5 = 283;

    for (;;)
    {
        wait 0.2;

        if ( isdefined( self.force_run_speed_state ) )
        {
            ally_dynamic_run_set( self.force_run_speed_state );
            continue;
        }

        var_6 = vectornormalize( anglestoforward( self.angles ) );
        var_7 = vectornormalize( self.origin - level.player.origin );
        var_8 = vectordot( var_6, var_7 );
        var_9 = distancesquared( self.origin, level.player.origin );

        if ( isdefined( self.cqbwalking ) && self.cqbwalking )
            self.moveplaybackrate = 1;

        if ( common_scripts\utility::flag_exist( "_stealth_spotted" ) && common_scripts\utility::flag( "_stealth_spotted" ) )
        {
            ally_dynamic_run_set( "run" );
            continue;
        }

        if ( var_8 < -0.25 && var_9 > 225 * var_0 )
        {
            ally_dynamic_run_set( "sprint" );
            continue;
        }

        ally_dynamic_run_set( "cqb" );
    }
}

ally_stop_dynamic_speed()
{
    self endon( "death" );
    self notify( "stop_dynamic_run_speed" );
    ally_reset_dynamic_speed();
}

ally_reset_dynamic_speed()
{
    self endon( "death" );
    maps\_utility::disable_cqbwalk();
    self.moveplaybackrate = 1;
    maps\_utility::clear_run_anim();
    self notify( "stop_loop" );
}

ally_dynamic_run_set( var_0 )
{
    if ( self.run_speed_state == var_0 )
        return;

    self.run_speed_state = var_0;

    switch ( var_0 )
    {
        case "sprint":
            if ( isdefined( self.cqbwalking ) && self.cqbwalking )
                self.moveplaybackrate = 1;
            else
                self.moveplaybackrate = 1;

            maps\_utility::set_generic_run_anim( "DRS_sprint" );
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "run":
            self.moveplaybackrate = 1;
            maps\_utility::clear_run_anim();
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "jog":
            self.moveplaybackrate = 1;
            maps\_utility::set_generic_run_anim( "DRS_combat_jog" );
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "cqb":
            self.moveplaybackrate = 1;
            maps\_utility::enable_cqbwalk();
            self notify( "stop_loop" );
            break;
    }
}

right_swing_pressed()
{
    if ( level.console || level.player common_scripts\utility::is_player_gamepad_enabled() )
        return level.player attackbuttonpressed();
    else
        return level.player buttonpressed( "mouse2" );
}

left_swing_pressed()
{
    var_0 = "BUTTON_LTRIG";

    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() )
        var_0 = "mouse1";

    return level.player buttonpressed( var_0 );
}

break_left_climb_hint()
{
    if ( isdefined( level.player.waiting_on_left_swing ) && level.player.waiting_on_left_swing == 0 )
        return 1;
    else
        return 0;
}

break_right_climb_hint()
{
    if ( isdefined( level.player.waiting_on_right_swing ) && level.player.waiting_on_right_swing == 0 )
        return 1;
    else
        return 0;
}

wait_until_right_swing_pressed()
{
    level.player.waiting_on_right_swing = 1;
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = level.player geteye() + anglestoforward( level.player getgunangles() ) * 12 + anglestoright( level.player getgunangles() ) * 6;
    var_0.angles = level.player.angles + ( 0, 180, 0 );
    var_1 = display_hint_button( &"LAGOS_PRESS_CLIMB_RIGHT", var_0, "tag_origin", 0 );

    for (;;)
    {
        if ( right_swing_pressed() && level.player.left_swing_released == 1 )
        {
            level.player.waiting_on_right_swing = 0;
            clear_hint_button( var_1 );
            soundscripts\_snd::snd_message( "exo_climb_right_swing_pressed" );
            return;
        }

        wait 0.05;
    }
}

wait_until_left_swing_pressed()
{
    level.player.waiting_on_left_swing = 1;
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = level.player geteye() + anglestoforward( level.player getgunangles() ) * 12 - anglestoright( level.player getgunangles() ) * 6;
    var_0.angles = level.player.angles + ( 0, 180, 0 );
    var_1 = display_hint_button( &"LAGOS_PRESS_CLIMB_LEFT", var_0, "tag_origin", 0 );

    for (;;)
    {
        if ( left_swing_pressed() && level.player.right_swing_released == 1 )
        {
            level.player.waiting_on_left_swing = 0;
            clear_hint_button( var_1 );
            var_0 delete();
            soundscripts\_snd::snd_message( "exo_climb_left_swing_pressed" );
            return;
        }

        wait 0.05;
    }
}

wait_until_next_right_swing()
{
    level.player.waiting_on_right_swing = 1;
    maps\_utility::display_hint_timeout( "right_climb_hint", 5 );

    for (;;)
    {
        if ( isdefined( level.player.right_swing_released ) && level.player.right_swing_released == 1 && right_swing_pressed() )
        {
            level.player.waiting_on_right_swing = 0;
            return;
        }

        wait 0.05;
    }
}

wait_until_next_left_swing()
{
    level.player.waiting_on_left_swing = 1;
    maps\_utility::display_hint_timeout( "left_climb_hint", 5 );

    for (;;)
    {
        if ( isdefined( level.player.left_swing_released ) && level.player.left_swing_released == 1 && left_swing_pressed() )
        {
            level.player.waiting_on_left_swing = 0;
            return;
        }

        wait 0.05;
    }
}

monitor_right_swing_released()
{
    level.player.right_swing_released = 0;

    for (;;)
    {
        if ( !right_swing_pressed() )
        {
            level.player.right_swing_released = 1;
            return;
        }

        wait 0.05;
    }
}

monitor_left_swing_released()
{
    level.player.left_swing_released = 0;

    for (;;)
    {
        if ( !left_swing_pressed() )
        {
            level.player.left_swing_released = 1;
            return;
        }

        wait 0.05;
    }
}

player_climb_wall_head_sway()
{
    level endon( "stop_player_cam_sway" );

    for (;;)
    {
        screenshake( level.player.origin, 7, 9, 4, 2, 0.2, 0.2, 0, 0.3, 0.375, 0.225 );
        wait 1.0;
    }
}

hint_string_disable_exo_door()
{
    if ( level.player usebuttonpressed() )
        return 1;

    return 0;
}

hint_string_disable_exo_climb()
{
    if ( level.player usebuttonpressed() )
        return 1;

    return 0;
}

hint_string_disable_mute_charge()
{
    if ( level.player usebuttonpressed() )
        return 1;

    return 0;
}

hint_string_disable_place_sensor()
{
    if ( level.player usebuttonpressed() )
        return 1;

    return 0;
}

display_hint_button( var_0, var_1, var_2, var_3 )
{
    var_4 = newclienthudelem( level.player );
    var_4.alignx = "center";
    var_4.aligny = "middle";
    var_4.fontscale = 3;
    var_4.positioninworld = 1;

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_2 ) )
            var_4 settargetent( var_1, var_2 );
        else
            var_4 settargetent( var_1 );
    }

    var_4 settext( var_0 );
    var_4.hidewheninmenu = 1;
    var_4.sort = -1;
    var_4.alpha = 1;
    level.player.hint_button = var_4;
    var_4 thread scale_3d_hud_elem( var_1, var_2, level.player, var_3 );
    return var_4;
}

scale_3d_hud_elem( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );

    if ( !isdefined( var_3 ) )
        var_3 = 40;

    for (;;)
    {
        var_4 = distance( var_0 gettagorigin( var_1 ), var_2 geteye() );
        self.fontscale = maps\_shg_utility::linear_map_clamp( var_4, 16, 1024, 2.5, 1.5 );

        if ( var_3 != 0 && var_4 > var_3 )
            self.alpha = 0.3;
        else
            self.alpha = 1;

        waitframe();
    }
}

clear_hint_button( var_0 )
{
    var_0 destroy();
}

keep_filling_clip_ammo( var_0 )
{
    self endon( "death" );

    while ( !common_scripts\utility::flag( "flag_bus_traverse_5_start_takedown" ) )
    {
        wait(var_0);

        if ( isdefined( self.weapon ) && !issubstr( self.weapon, "rpg" ) )
            self.bulletsinclip = weaponclipsize( self.weapon );
    }
}

give_player_more_ammo( var_0 )
{
    self endon( "death" );

    while ( !common_scripts\utility::flag( "flag_bus_traverse_5_start_takedown" ) )
    {
        wait(var_0);
        var_1 = self getcurrentweapon();

        if ( isdefined( var_1 ) && !issubstr( var_1, "rpg" ) )
            self givemaxammo( var_1 );
    }
}

bloody_death( var_0, var_1 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_2 = [];
    var_2[0] = "j_hip_le";
    var_2[1] = "j_hip_ri";
    var_2[2] = "j_head";
    var_2[3] = "j_spine4";
    var_2[4] = "j_elbow_le";
    var_2[5] = "j_elbow_ri";
    var_2[6] = "j_clavicle_le";
    var_2[7] = "j_clavicle_ri";
    var_3 = getdvarint( "cg_fov" );

    for ( var_4 = 0; var_4 < 3 + randomint( 5 ); var_4++ )
    {
        var_5 = randomintrange( 0, var_2.size );
        thread bloody_death_fx( var_2[var_5], undefined );
        wait(randomfloat( 0.1 ));

        if ( isdefined( var_1 ) && isai( var_1 ) && isalive( var_1 ) )
        {
            if ( !level.player worldpointinreticle_circle( var_1.origin, var_3, 500 ) )
                var_1 shootblank();
        }
    }

    self dodamage( self.health + 50, self.origin );
}

bloody_death_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

alley1_stage3_refill_think()
{
    self endon( "death" );
    var_0 = 256;
    var_1 = 512;
    level.alley1_kva = common_scripts\utility::array_add( level.alley1_kva, self );
    thread assign_goal_vol( "alley1_stage3_vol1" );
    maps\_utility::disable_long_death();
    equip_microwave_grenade();
    self setengagementmaxdist( var_0, var_1 );
}

handle_vehicle_death()
{
    thread vehicle_crash_when_driver_dies();
    thread vehicle_crash_on_death();
}

vehicle_crash_when_driver_dies()
{
    self endon( "death" );
    self.vehicle_keeps_going_after_driver_dies = 1;
    var_0 = vehicle_get_driver();

    if ( !isdefined( var_0 ) )
        return;

    var_0 waittill( "death" );
    var_1 = undefined;

    if ( isdefined( var_0 ) )
        var_1 = var_0.lastattacker;

    vehicle_crash_now( var_1 );
}

vehicle_crash_on_death()
{
    self.vehicle_stays_alive = 1;

    while ( self.health > 0 )
    {
        self waittill( "damage" );
        waittillframeend;

        if ( self.health < self.healthbuffer )
            break;
    }

    vehicle_crash_now( self.attacker );
}

vehicle_crash_when_blocked()
{
    self endon( "death" );
    var_0 = 24;
    var_1 = 39;
    var_2 = 156;
    var_3 = undefined;

    for (;;)
    {
        var_4 = self localtoworldcoords( ( var_1, 0, var_0 ) );
        var_5 = self localtoworldcoords( ( var_2, 0, var_0 ) );
        var_6 = bullettrace( var_4, var_5, 0, self );
        var_7 = var_6["entity"];

        if ( isdefined( var_7 ) )
        {
            if ( var_7.code_classname == "script_model" || var_7.code_classname == "script_vehicle" && var_7.health <= 0 )
            {
                var_3 = var_7.attacker;
                break;
            }
        }

        if ( isdefined( self.vehicle_crashing_now ) )
            return;

        wait 0.5;
    }

    thread vehicle_crash_now( var_3 );
}

vehicle_crash_now( var_0 )
{
    var_1 = 0.75;
    var_2 = 3;
    var_3 = 60;
    var_4 = 1.5;
    var_5 = 39;
    var_6 = 1.8;

    if ( isdefined( self.vehicle_crashing_now ) )
        return;

    self.vehicle_crashing_now = 1;
    self notify( "vehicle_crashing_now" );
    soundscripts\_snd::snd_message( "bus_chase_suv_lose_control" );
    var_7 = vehicle_get_crash_struct( var_1, var_2, var_3, var_4 );

    if ( isdefined( var_7 ) )
    {
        var_7.used = 1;
        var_8 = spawnstruct();
        var_8.crash_struct = var_7;
        var_8.vehicle = self;
        var_8.vehicle_to_crash_struct = var_8.crash_struct.origin - var_8.vehicle.origin;
        var_8.vehicle_to_crash_struct_dir = vectornormalize( var_8.vehicle_to_crash_struct );
        var_8.right_dir = anglestoright( common_scripts\utility::flat_angle( vectortoangles( var_8.vehicle_to_crash_struct_dir ) ) );
        var_8.goal_pos = var_8.crash_struct.origin + vectornormalize( var_8.vehicle_to_crash_struct ) * var_5;
        var_8.crash_speed_ips = max( self vehicle_getspeed() * 17.6 * var_4, 1 );
        var_8.crash_speed_mph = var_8.crash_speed_ips / 17.6;
        var_8.wait_time = length( var_8.vehicle_to_crash_struct ) / var_8.crash_speed_ips * var_6;
        thread vehicle_crazy_steering( var_8 );
        vehicle_wait_for_crash( var_8 );
    }
    else
    {

    }

    self.vehicle_stays_alive = undefined;

    if ( isdefined( var_0 ) )
        self dodamage( self.health + 2000, self.origin, var_0, self );
    else
        self dodamage( self.health + 2000, self.origin );
}

vehicle_get_driver()
{
    foreach ( var_1 in self.attachedguys )
    {
        if ( isdefined( var_1.drivingvehicle ) && var_1.drivingvehicle )
            return var_1;
    }
}

vehicle_get_crash_struct( var_0, var_1, var_2, var_3 )
{
    var_4 = self vehicle_getspeed() * 17.6 * var_3;
    var_5 = squared( var_4 * var_0 );
    var_6 = squared( var_4 * var_1 );
    var_7 = cos( var_2 );
    var_8 = sortbydistance( common_scripts\utility::getstructarray( "vehicle_crash_struct", "script_noteworthy" ), self.origin );

    foreach ( var_10 in var_8 )
    {
        var_11 = distancesquared( var_10.origin, self.origin );

        if ( var_11 < var_5 )
            continue;

        if ( var_11 > var_6 )
            break;

        if ( isdefined( var_10.used ) )
            continue;

        if ( vectordot( vectornormalize( var_10.origin - self.origin ), anglestoforward( self.angles ) ) < var_7 )
            continue;

        return var_10;
    }

    return undefined;
}

vehicle_wait_for_crash( var_0 )
{
    thread maps\_utility::notify_delay( "max_time", var_0.wait_time );
    thread vehicle_detect_crash( var_0 );
    var_1 = common_scripts\utility::waittill_any_return( "max_time", "veh_collision", "script_vehicle_collision", "detect_crash" );

    if ( !isdefined( var_1 ) )
        var_1 = "unknown";

    self notify( "stop_vehicle_detect_crash" );
}

vehicle_detect_crash( var_0 )
{
    self endon( "stop_vehicle_detect_crash" );
    waittillframeend;
    var_1 = squared( 234 );

    if ( isdefined( level.vehicle_death_radiusdamage[self.classname] ) && isdefined( level.vehicle_death_radiusdamage[self.classname].range ) )
        var_1 = squared( level.vehicle_death_radiusdamage[self.classname].range * 0.75 );

    for (;;)
    {
        if ( abs( angleclamp180( self.angles[0] ) ) > 30 || abs( angleclamp180( self.angles[2] ) ) > 30 )
            break;

        if ( distancesquared( self.origin, level.player.origin ) < var_1 )
            break;

        if ( self vehicle_getspeed() / var_0.crash_speed_mph < 0.25 )
            break;

        if ( vectordot( var_0.goal_pos - self.origin, var_0.vehicle_to_crash_struct_dir ) < 0 )
            break;

        waitframe();
    }

    self notify( "detect_crash" );
    soundscripts\_snd::snd_message( "bus_chase_suv_explode" );
}

vehicle_crazy_steering( var_0 )
{
    var_1 = 20;
    var_2 = 4;
    var_3 = 195;
    var_4 = var_3 * tan( var_1 );
    var_5 = self vehicle_getspeed();
    var_6 = 0;
    self endon( "death" );

    for (;;)
    {
        var_7 = 0;

        if ( vectordot( var_0.crash_struct.origin - self.origin, var_0.right_dir ) < 0 )
            var_7 = 1;

        var_8 = randomfloat( var_4 );

        if ( var_7 )
            var_8 *= -1;

        var_9 = self.origin + var_0.vehicle_to_crash_struct_dir * var_3 + var_0.right_dir * var_8;
        var_10 = clamp( var_6 / var_2, 0, 1 );
        var_11 = maps\_utility::linear_interpolate( var_10, var_5, var_0.crash_speed_mph );
        self vehicledriveto( var_9, var_0.crash_speed_mph );
        var_12 = randomfloatrange( 0.05, 0.2 );
        var_6 += var_12;
        wait(var_12);
    }
}

vehicle_crazy_steering_frogger()
{
    var_0 = 10;
    var_1 = 4;
    var_2 = 195;
    var_3 = var_2 * tan( var_0 );
    var_4 = self vehicle_getspeed();
    var_5 = 0;

    if ( self.lane < 5 )
        var_6 = ( 30, -500, 0 );
    else
        var_6 = ( 30, 500, 0 );

    var_7 = self.origin + var_6;
    var_8 = vectornormalize( var_6 );
    var_9 = anglestoright( common_scripts\utility::flat_angle( vectortoangles( var_8 ) ) );
    self.oldcontents = self setcontents( 0 );
    self endon( "death" );

    while ( var_5 < 2 )
    {
        var_10 = 0;

        if ( vectordot( var_7 - self.origin, var_9 ) < 0 )
            var_10 = 1;

        var_11 = randomfloat( var_3 );

        if ( var_10 )
            var_11 *= -1;

        var_12 = self.origin + var_8 * var_2 + var_9 * var_11;
        self vehicledriveto( var_12, 30 );
        var_13 = randomfloatrange( 0.05, 0.2 );
        var_5 += var_13;
        wait(var_13);
    }

    var_14 = getvehiclenode( "frogger_lane_" + self.lane + "_mid", "targetname" );
    self vehicledriveto( var_14.origin, 70 );
    wait 0.1;
    common_scripts\utility::delaycall( 3, ::setcontents, self.oldcontents );
    thread maps\_vehicle::vehicle_paths( var_14 );
    self startpath( var_14 );
}

vehicle_crazy_steering_frogger_fail_check()
{

}

prep_cinematic( var_0 )
{
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingame( var_0, 1 );
    level.current_cinematic = var_0;
}

play_cinematic( var_0, var_1, var_2 )
{
    if ( isdefined( level.current_cinematic ) )
    {
        pausecinematicingame( 0 );
        setsaveddvar( "cg_cinematicFullScreen", "1" );
        level.current_cinematic = undefined;
    }
    else
        cinematicingame( var_0 );

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "1" );

    wait 1;

    while ( iscinematicplaying() )
        wait 0.05;

    if ( !isdefined( var_2 ) || !var_2 )
        setsaveddvar( "cg_cinematicCanPause", "0" );
}

ending_fade_out( var_0 )
{
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 setshader( "black", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        wait(var_0);
    }

    wait 2;
    var_1 destroy();
}
