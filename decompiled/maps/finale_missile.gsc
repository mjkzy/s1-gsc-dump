// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_complete_missile_prefab( var_0, var_1 )
{
    var_2 = [];
    setup_main_missile( var_0, var_1 );

    for ( var_3 = 1; var_3 <= 6; var_3++ )
    {
        var_4 = "side_missile_breakable_0" + var_3;
        var_5 = getentarray( var_4, "targetname" );
        var_6 = setup_side_missile_prefab( var_5, var_1 );
        var_2[var_2.size] = var_6;
    }

    waitframe();

    foreach ( var_6 in var_2 )
        var_6 _meth_804D( var_0, "missile" );

    thread custom_health_think( var_1, var_0 );
}

setup_complete_missile_not_prefab( var_0, var_1 )
{
    setup_main_missile( var_0 );
    var_2 = getentarray( "side_missile_01", "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_4 _meth_80B1( "fin_side_missile_02" );
        var_4 attach_or_link( "fin_side_missile_white_panel_top_r_01", "dyna_White_panel_top_R_01" );
        var_4 attach_or_link( "fin_side_missile_white_panel_top_l_01", "dyna_White_panel_top_L_01" );
        var_4 attach_or_link( "fin_side_missile_white_panel_bottom_r_01", "dyna_White_panel_bottom_R_01" );
        var_4 attach_or_link( "fin_side_missile_white_panel_bottom_l_01", "dyna_White_panel_bottom_L_01" );
        var_4 attach_or_link( "fin_side_missile_engine_nozzel_piece_01", "dyna_Engine_nozzel_piece_01" );
        var_4 attach_or_link( "fin_side_missile_engine_nozzel_piece_02", "dyna_Engine_nozzel_piece_02" );
        var_4 attach_or_link( "fin_side_missile_engine_brace_piece_01", "dyna_Engine_brace_piece_01" );
        var_4 attach_or_link( "fin_side_missile_side_box_piece_r_01", "dyna_Black_R_side_box_piece_01" );
        var_4 attach_or_link( "fin_side_missile_side_box_piece_l_01", "dyna_Black_L_side_box_piece_02" );
        var_4 _meth_804D( var_0, "missile" );
        var_5 = undefined;
        thread clip_missle_damage_think( var_5, 4000, var_1 );
    }
}

clip_missle_damage_think( var_0, var_1, var_2 )
{
    var_0 _meth_82C0( 1 );
    var_0.maxhealth = var_1;
    var_0 _meth_8050( var_0.maxhealth );
    var_3 = var_0.maxhealth * 0.5;
    var_4 = 0;
    var_5 = 0;

    while ( var_0.health > 0 )
    {
        var_0 waittill( "damage", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15 );

        if ( var_0.health < var_3 )
        {
            if ( isdefined( var_0.assigned_model_b ) && var_0.assigned_model_b != var_0.assigned_parent && !var_4 )
            {
                playfx( common_scripts\utility::getfx( "fin_rocket_silo_explosion" ), var_9 );
                soundscripts\_snd::snd_message( "aud_fin_rocket_damage_vfx" );
                var_0.assigned_model_b hide();
                var_4 = 1;
            }
        }

        if ( isdefined( var_2 ) )
            var_2 _meth_8051( 1, var_9, var_7, var_7, var_10, var_15 );

        if ( var_0.health < 0 )
        {
            if ( isdefined( var_0.assigned_model ) && var_0.assigned_model != var_0.assigned_parent && !var_5 )
            {
                var_0.assigned_model hide();
                playfx( common_scripts\utility::getfx( "fin_rocket_silo_explosion" ), var_9 );
                soundscripts\_snd::snd_message( "aud_fin_rocket_damage_vfx" );
                var_5 = 1;

                if ( var_0.classname == "script_brushmodel" )
                {
                    var_0 _meth_82BF();
                    return;
                }
            }

            var_0 _meth_8050( 99999 );
        }

        waitframe();
    }
}

setup_side_missile( var_0 )
{
    var_0 attach_or_link( "fin_side_missile_white_panel_top_r_01", "dyna_White_panel_top_R_01" );
    var_0 attach_or_link( "fin_side_missile_white_panel_top_l_01", "dyna_White_panel_top_L_01" );
    var_0 attach_or_link( "fin_side_missile_white_panel_bottom_r_01", "dyna_White_panel_bottom_R_01" );
    var_0 attach_or_link( "fin_side_missile_white_panel_bottom_l_01", "dyna_White_panel_bottom_L_01" );
    var_0 attach_or_link( "fin_side_missile_engine_nozzel_piece_01", "dyna_Engine_nozzel_piece_01" );
    var_0 attach_or_link( "fin_side_missile_engine_nozzel_piece_02", "dyna_Engine_nozzel_piece_02" );
    var_0 attach_or_link( "fin_side_missile_engine_brace_piece_01", "dyna_Engine_brace_piece_01" );
    var_0 attach_or_link( "fin_side_missile_side_box_piece_r_01", "dyna_Black_R_side_box_piece_01" );
    var_0 attach_or_link( "fin_side_missile_side_box_piece_l_01", "dyna_Black_L_side_box_piece_02" );
}

attach_or_link( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( var_2 )
        self attach( var_0, var_1 );
    else
    {
        var_3 = self gettagorigin( var_1 );
        var_4 = spawn( "script_model", var_3 );
        var_5 = self gettagangles( var_1 );
        var_4.angles = var_5;
        var_4.target = self.targetname;
    }
}

setup_main_missile( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        var_1 _meth_82C0( 1 );
        var_1.maxhealth = 40000;
        var_1 _meth_8050( var_1.maxhealth );
        var_1.healthcustom = 20.0;
        var_1.count_swarm = 0;
        var_1.count_rocket = 0;
        var_1.count_bullet = 0;
    }

    var_0.animname = "missile_main";
    var_0 maps\_utility::assign_animtree();
    var_2 = getentarray( var_0.targetname, "target" );

    foreach ( var_4 in var_2 )
    {
        var_4 _meth_804D( var_0, "missile" );
        thread clip_missle_damage_think( var_4, 9999999, var_1 );
    }

    thread clip_missle_damage_think( var_0, 9999999, var_1 );
}

setup_side_missile_prefab( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = [];
    var_4 = [];

    foreach ( var_6 in var_0 )
    {
        if ( var_6.classname == "script_brushmodel" )
            var_3[var_3.size] = var_6;
    }

    foreach ( var_6 in var_0 )
    {
        if ( var_6.classname == "script_model" )
            var_4[var_4.size] = var_6;

        if ( var_6.model == "fin_side_missile_02" )
            var_2 = var_6;
    }

    foreach ( var_11 in var_3 )
    {
        foreach ( var_13 in var_4 )
        {
            if ( isdefined( var_11.script_noteworthy ) && var_11.script_noteworthy == var_13.model )
            {
                var_11.assigned_model = var_13;
                var_13.assigned_brush = var_11;
            }

            if ( isdefined( var_11.script_parameters ) && var_11.script_parameters == var_13.model )
            {
                var_11.assigned_model_b = var_13;
                var_13.assigned_brush = var_11;
            }
        }
    }

    foreach ( var_11 in var_3 )
    {
        var_11.assigned_parent = var_2;
        var_17 = 4000;

        if ( var_11.assigned_model == var_2 )
            var_17 = 99999999;

        thread clip_missle_damage_think( var_11, var_17, var_1 );
    }

    foreach ( var_13 in var_4 )
    {
        if ( !isdefined( var_13.assigned_brush ) )
        {
            var_13.assigned_model = var_13;
            var_17 = 4000;

            if ( var_13.assigned_model == var_2 )
                var_17 = 99999999;

            thread clip_missle_damage_think( var_13, var_17, var_1 );
        }

        if ( var_13 != var_2 )
        {
            var_13.assigned_parent = var_2;
            var_13 _meth_804D( var_2 );
        }
    }

    return var_2;
}

fx_engine_off( var_0, var_1 )
{
    if ( var_0 == 0 )
    {
        soundscripts\_snd::snd_message( "missile_large_thrusters_off" );
        playfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_blue_idle" ), var_1, "missile" );
        stopfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_blue" ), var_1, "missile" );
    }
    else
    {
        soundscripts\_snd::snd_message( "missile_small_thrusters_off" );
        var_2 = "TAG_ATTACH" + var_0;
        playfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_sml_idle" ), var_1, var_2 );
        stopfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_sml" ), var_1, var_2 );
    }
}

fx_engine_on( var_0, var_1 )
{
    if ( var_0 == 0 )
    {
        stopfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_blue_idle" ), var_1, "missile" );
        playfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_blue" ), var_1, "missile" );
    }
    else
    {
        var_2 = "TAG_ATTACH" + var_0;
        stopfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_sml_idle" ), var_1, var_2 );
        playfxontag( common_scripts\utility::getfx( "fin_rocket_thruster_sml" ), var_1, var_2 );
    }
}

custom_regen_think( var_0, var_1 )
{
    var_0 endon( "fakedamage" );
    var_0 endon( "death" );
    var_1 endon( "death" );

    if ( common_scripts\utility::flag( "flag_missile_failed" ) || common_scripts\utility::flag( "flag_missile_damaged" ) )
        return;

    if ( 0 )
        return;

    var_2 = gettime() + 1000.0;

    while ( gettime() < var_2 )
        waitframe();

    while ( var_0.healthcustom < 20.0 )
    {
        if ( common_scripts\utility::flag( "flag_missile_failed" ) || common_scripts\utility::flag( "flag_missile_damaged" ) )
            return;

        var_0.healthcustom += 0.05;

        if ( 0 )
        {
            while ( var_0.tag_current > 0 && var_0.healthcustom > var_0.tag_shutdown_hp_threshold_array[var_0.tag_current] )
            {
                var_3 = var_0.tag_shutdown_order_array[var_0.tag_current];

                if ( isdefined( var_3 ) )
                    fx_engine_on( var_3, var_1 );

                var_0.tag_current--;
            }
        }

        waitframe();
    }

    var_0.healthcustom = 20.0;
}

restore_thrusters_all( var_0, var_1 )
{
    while ( var_1.tag_current >= 0 )
    {
        var_2 = var_1.tag_shutdown_order_array[var_1.tag_current];

        if ( isdefined( var_2 ) )
        {
            fx_engine_on( var_2, var_0 );
            waitframe();
        }

        var_1.tag_current--;
    }
}

custom_health_think( var_0, var_1 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_2 = 0;
    var_0.tag_shutdown_order_array = [ 4, 3, 5, 2, 6, 1, 0 ];
    var_3 = 20.0 / ( var_0.tag_shutdown_order_array.size - 1 );
    var_0.tag_shutdown_hp_threshold_array = [ var_3 * 6, var_3 * 5, var_3 * 4, var_3 * 3, var_3 * 2, var_3 * 1, 0 ];
    var_0.tag_current = 0;

    for (;;)
    {
        var_0 waittill( "damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 );

        if ( gettime() == var_2 )
            continue;

        var_2 = gettime();
        var_14 = 0;

        if ( var_13 == "playermech_rocket_projectile" || var_13 == "playermech_rocket_swarm_finale" )
        {
            var_0.count_swarm++;
            var_14 = 0.5;
        }
        else if ( var_13 == "playermech_rocket_finale" )
        {
            var_0.count_rocket++;
            var_14 = 4.0;
        }
        else
        {
            var_0.count_bullet++;
            var_14 = 0.142857;
        }

        var_0.healthcustom -= var_14;
        var_0 notify( "fakedamage" );

        while ( var_0.tag_current < var_0.tag_shutdown_hp_threshold_array.size && var_0.healthcustom < var_0.tag_shutdown_hp_threshold_array[var_0.tag_current] )
        {
            var_15 = var_0.tag_shutdown_order_array[var_0.tag_current];

            if ( isdefined( var_15 ) )
                fx_engine_off( var_15, var_1 );

            var_0.tag_current++;
        }

        if ( var_0.healthcustom < 0 )
        {
            var_0 _meth_8052();
            continue;
        }

        thread custom_regen_think( var_0, var_1 );
    }
}
