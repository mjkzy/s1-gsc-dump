// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachemodel( "weapon_javelin_tactics_friendly" );
    precachemodel( "weapon_smaw_tactics_friendly" );
    precachemodel( "vehicle_gaz_tigr_base_tactics_enemy" );
    precachemodel( "vehicle_x4walker_wheels_tactics_friendly" );
    precachemodel( "weapon_dshk_turret_tactics_enemy" );
    precachemodel( "vehicle_pdrone_tactics_friendly" );
    precachemodel( "vehicle_walker_tank_tactics_enemy" );
    precachemodel( "weapon_rpg7_tactics_friendly" );
    common_scripts\utility::flag_init( "tactics_mode_on" );
    level.tactics_objects = [];
    level.tactics_objectives = [];
    level.tactics_tools = [];
    maps\_utility::add_global_spawn_function( "axis", ::monitor_rpg_drop );
}

add_object_to_tactics_system( var_0 )
{
    if ( !isdefined( level.tactics_objects ) )
        return;

    if ( issubstr( var_0.classname, "vehicle" ) )
        var_0 thread remove_vehicle_from_tactics_array_on_death();

    if ( issubstr( var_0.classname, "x4walker" ) )
        var_0 thread remove_turret_on_mount();

    level.tactics_objects[level.tactics_objects.size] = var_0;
}

remove_object_from_tactics_system( var_0 )
{
    var_0 remove_from_arrays();
}

monitor_tactics_mode()
{
    level.player endon( "death" );
    level.player endon( "end_tactics_mode" );
    level.player thread monitor_player_rpg_drop();

    for (;;)
    {
        if ( level.player _meth_824C( "DPAD_UP" ) )
        {
            foreach ( var_1 in level.tactics_objects )
            {
                if ( !isdefined( var_1 ) )
                    continue;

                if ( var_1.tactics_type == "objective" && !maps\_utility::is_in_array( level.tactics_objectives, var_1 ) )
                {
                    level.tactics_objectives[level.tactics_objectives.size] = var_1;
                    continue;
                }

                if ( var_1.tactics_type == "tool" && !maps\_utility::is_in_array( level.tactics_tools, var_1 ) )
                    level.tactics_tools[level.tactics_tools.size] = var_1;
            }

            if ( !common_scripts\utility::flag( "tactics_mode_on" ) )
            {
                level.player notify( "start_tactics_mode" );
                thread change_to_tactics_models();
                thread draw_text_hud( level.player, level.tactics_objectives, level.tactics_tools );
            }

            common_scripts\utility::flag_set( "tactics_mode_on" );
        }
        else
        {
            if ( common_scripts\utility::flag( "tactics_mode_on" ) )
            {
                level.player notify( "stop_tactics_mode" );
                thread change_to_original_models();
            }

            common_scripts\utility::flag_clear( "tactics_mode_on" );
        }

        wait 0.05;
    }
}

change_to_tactics_models()
{
    foreach ( var_1 in level.tactics_objects )
    {
        if ( isdefined( var_1 ) )
            var_1 _meth_80B1( var_1.tactics_model );
    }
}

change_to_original_models()
{
    foreach ( var_1 in level.tactics_objects )
    {
        if ( isdefined( var_1 ) )
            var_1 _meth_80B1( var_1.original_model );
    }
}

draw_tactics_lines( var_0, var_1 )
{
    level.player endon( "stop_tactics_mode" );
    level.player endon( "death" );

    for (;;)
    {
        foreach ( var_3 in var_0 )
        {
            foreach ( var_5 in var_1 )
            {
                if ( !isdefined( var_5 ) || isdefined( var_5.no_line ) && var_5.no_line )
                    continue;
            }
        }

        wait 0.05;
    }
}

draw_text_hud( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_1 )
        var_4 thread draw_text_hud_objective( var_0 );

    foreach ( var_7 in var_2 )
        var_7 thread draw_text_hud_tool( var_0 );
}

draw_text_hud_objective( var_0 )
{
    if ( !isdefined( self.description ) )
        return;

    self.drawing_warzone_hud = 1;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto_with_world_offset( self, undefined, ( 0, 0, 72 ) );
    var_2 = newclienthudelem( var_0 );
    var_2 _meth_80CD( var_1 );
    var_2.positioninworld = 1;
    var_2 settext( self.description );
    var_2.color = ( 1, 0.44, 0.39 );
    var_2.alpha = 1;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2 thread scale_3d_hud_elem( var_1, var_0 );
    var_2 setpulsefx( 60, 999999, 0 );
    wait_till_should_stop_drawing( var_0 );
    var_2 destroy();
    var_1 delete();

    if ( isdefined( self ) )
        self.drawing_warzone_hud = undefined;
}

draw_text_hud_tool( var_0 )
{
    if ( !isdefined( self.description ) )
        return;

    self.drawing_warzone_hud = 1;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto_with_world_offset( self, undefined, ( 0, 0, 72 ) );
    var_2 = newclienthudelem( var_0 );
    var_2 _meth_80CD( var_1 );
    var_2.positioninworld = 1;
    var_2 settext( self.description );
    var_2.color = ( 0.3, 1, 0.6 );
    var_2.alpha = 0.5;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.z = -0.5;
    var_2 thread scale_3d_hud_elem( var_1, var_0 );
    var_2 setpulsefx( 60, 999999, 0 );
    var_3 = newclienthudelem( var_0 );
    var_3 _meth_80CD( var_1 );
    var_3.positioninworld = 1;
    var_3.color = ( 0.3, 1, 0.6 );
    var_3.alpha = 0.5;
    var_3.alignx = "center";
    var_3.aligny = "middle";
    var_3.z = 0.5;
    var_3 thread scale_3d_hud_elem( var_1, var_0 );
    var_3 thread hud_elem_update_distance( var_1, var_0 );
    wait_till_should_stop_drawing( var_0 );
    var_2 destroy();
    var_3 destroy();
    var_1 delete();

    if ( isdefined( self ) )
        self.drawing_warzone_hud = undefined;
}

wait_till_should_stop_drawing( var_0 )
{
    self endon( "death" );
    var_0 endon( "stop_tactics_mode" );
    var_0 endon( "death" );
    level waittill( "forever" );
}

scale_3d_hud_elem( var_0, var_1 )
{
    self endon( "death" );

    for (;;)
    {
        self.fontscale = maps\_shg_utility::linear_map_clamp( distance( var_0.origin, var_1 _meth_80A8() ), 16, 1024, 2.5, 1.5 );
        waitframe();
    }
}

hud_elem_update_distance( var_0, var_1 )
{
    self endon( "death" );
    wait 0.8;

    for (;;)
    {
        var_2 = distance( var_0.origin, var_1 _meth_80A8() ) / 39.3701;
        self settext( int( var_2 + 0.5 ) );
        waitframe();
    }
}

linkto_with_world_offset( var_0, var_1, var_2 )
{
    thread linkto_with_world_offset_internal( var_0, var_1, var_2 );
}

unlinkto_with_world_offset()
{
    self notify( "stop_link_with_world_offset" );
}

linkto_with_world_offset_internal( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 endon( "death" );
    self endon( "stop_link_with_world_offset" );

    for (;;)
    {
        waittillframeend;

        if ( isdefined( var_1 ) )
            self.origin = var_0 gettagorigin( var_1 ) + var_2;
        else
            self.origin = var_0.origin + var_2;

        waitframe();
    }
}

monitor_rpg_drop()
{
    level.player endon( "death" );

    if ( !issubstr( self.classname, "rpg" ) )
        return;

    self waittill( "weapon_dropped", var_0 );

    if ( isdefined( var_0 ) && issubstr( var_0.classname, "rpg" ) )
        var_0 add_rpg_to_tactics_system();
}

add_rpg_to_tactics_system()
{
    self.description = "SMAW";
    self.original_model = self.model;
    self.tactics_model = "weapon_smaw_tactics_friendly";
    self.tactics_type = "tool";
    level.tactics_objects = common_scripts\utility::array_add( level.tactics_objects, self );
    thread remove_from_tactics_array_on_pickup();
    thread remove_from_tactics_array_on_delete();
}

remove_from_tactics_array_on_pickup()
{
    level.player endon( "death" );
    level.player endon( "end_tactics_mode" );

    for (;;)
    {
        level.player waittill( "pickup", var_0 );

        if ( var_0 == self )
            remove_from_arrays();
    }
}

remove_from_tactics_array_on_delete()
{
    level.player endon( "death" );
    level.player endon( "end_tactics_mode" );

    while ( isdefined( self ) )
        wait 0.05;

    remove_from_arrays();
}

monitor_player_rpg_drop()
{
    level.player endon( "death" );
    level.player endon( "end_tactics_mode" );

    for (;;)
    {
        level.player waittill( "pickup", var_0, var_1 );

        if ( isdefined( var_1 ) && issubstr( var_1.classname, "smaw_nolock_fusion" ) )
            var_1 add_rpg_to_tactics_system();
    }
}

remove_vehicle_from_tactics_array_on_death()
{
    level.player endon( "death" );
    level.player endon( "end_tactics_mode" );
    self waittill( "death" );
    level.tactics_objects = common_scripts\utility::array_remove( level.tactics_objects, self );
    level.tactics_tools = common_scripts\utility::array_remove( level.tactics_tools, self );
    level.tactics_objectives = common_scripts\utility::array_remove( level.tactics_objectives, self );

    if ( isdefined( self ) && isdefined( self.mgturret ) && isdefined( self.mgturret[0] ) )
    {
        level.tactics_objects = common_scripts\utility::array_remove( level.tactics_objects, self.mgturret[0] );
        level.tactics_tools = common_scripts\utility::array_remove( level.tactics_tools, self.mgturret[0] );
        level.tactics_objectives = common_scripts\utility::array_remove( level.tactics_objectives, self.mgturret[0] );
    }
}

remove_turret_on_mount()
{
    level.player endon( "death" );
    self endon( "death" );
    level.player endon( "end_tactics_mode" );
    self waittill( "vehicle_mount" );
    thread add_turret_on_dismount();
    remove_from_arrays();
}

add_turret_on_dismount()
{
    level.player endon( "death" );
    self endon( "death" );
    level.player endon( "end_tactics_mode" );
    self waittill( "vehicle_dismount" );
    add_object_to_tactics_system( self );
}

remove_from_arrays()
{
    if ( !isdefined( level.tactics_objects ) )
        return;

    if ( maps\_utility::is_in_array( level.tactics_objects, self ) )
        level.tactics_objects = common_scripts\utility::array_remove( level.tactics_objects, self );

    if ( maps\_utility::is_in_array( level.tactics_tools, self ) )
        level.tactics_tools = common_scripts\utility::array_remove( level.tactics_tools, self );
    else if ( maps\_utility::is_in_array( level.tactics_objectives, self ) )
        level.tactics_objectives = common_scripts\utility::array_remove( level.tactics_objectives, self );
}
