// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

grapple_traverse( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level.grapple_traverse_init ) )
        grapple_traverse_init();

    self.desired_anim_pose = "stand";
    animscripts\utility::updateanimpose();
    self.istraversing = 1;
    self.grapple_end_anim = var_3;
    self.grapple_target_ent = var_1;
    self.grapple_end_events = [ "death", "killgrapple", "traverse_finish" ];

    if ( !isdefined( var_1 ) )
        self.grapple_end_events[self.grapple_end_events.size] = "killanimscript";

    foreach ( var_5 in self.grapple_end_events )
        self endon( var_5 );

    self traversemode( "nogravity" );
    self traversemode( "noclip" );

    if ( !isdefined( var_1 ) )
    {
        self.traversestartnode = self getnegotiationstartnode();
        self.traverseendnode = self getnegotiationendnode();
    }

    thread grapple_traverse_cleanup( self.traverseendnode );
    var_7 = ( 0, 0, 0 );
    var_8 = ( 0, 0, 0 );
    var_9 = ( 1, 0, 0 );

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        var_7 = var_1 gettagorigin( var_2 );
        var_9 = var_7 - self.origin;
    }
    else if ( isdefined( var_1 ) )
    {
        var_7 = var_1.origin;
        var_9 = var_7 - self.origin;
    }
    else
    {
        var_7 = trace_end_position( self.traversestartnode, self.traverseendnode );
        var_9 = self.traverseendnode.origin - var_7;
    }

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
        var_8 = var_1 gettagangles( var_2 );
    else if ( isdefined( var_1 ) )
        var_8 = var_1.angles;
    else
    {
        var_8 = self.traverseendnode.origin - var_7;
        var_8 = ( var_8[0], var_8[1], 0 );
        var_8 = vectortoangles( var_8 );
    }

    self.grapple_end_ent = common_scripts\utility::spawn_tag_origin();
    self.grapple_end_ent.origin = var_7;
    self.grapple_end_ent.angles = var_8;

    if ( isdefined( var_1 ) )
        self.grapple_end_ent linkto( var_1 );

    self.grapple_end_ent thread grapple_delete_monitor( self );
    var_10 = self.origin;
    grapple_add_void_point( self.grapple_end_ent.origin, 64, grapple_travel_time( var_10, self.grapple_end_ent.origin ) + 2.0 );
    self orientmode( "face angle", vectortoyaw( self.grapple_end_ent.origin - var_10 ) );

    if ( isdefined( var_0 ) )
        self.grapple_config = level.grapple_traverse_configs[var_0];
    else
    {
        var_11 = angleclamp180( vectortoangles( self.grapple_end_ent.origin - var_10 )[0] );

        foreach ( var_13 in level.grapple_traverse_configs )
        {
            if ( var_11 > var_13[0] && var_11 <= var_13[1] )
            {
                self.grapple_config = var_13;
                break;
            }
        }

        if ( !isdefined( self.grapple_config ) )
            self.grapple_config = level.grapple_traverse_configs[0];
    }

    var_9 = vectornormalize( ( var_9[0], var_9[1], 0 ) );
    grapple_fire( var_9 );
    grapple_travel( self.origin, self.angles );
    grapple_land();
    self notify( "traverse_finish" );
}

grapple_delete_monitor( var_0 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) && isdefined( var_0.grapple_end_events ) )
        var_0 common_scripts\utility::waittill_any( var_0.grapple_end_events[0], var_0.grapple_end_events[1], var_0.grapple_end_events[2], var_0.grapple_end_events[3], var_0.grapple_end_events[4], var_0.grapple_end_events[5] );

    self delete();
}

grapple_traverse_cleanup( var_0 )
{
    var_1 = common_scripts\utility::waittill_any_return( self.grapple_end_events[0], self.grapple_end_events[1], self.grapple_end_events[2], self.grapple_end_events[3], self.grapple_end_events[4], self.grapple_end_events[5] );

    if ( isdefined( var_0 ) && var_1 == "killanimscript" )
        self forceteleport( var_0.origin, self.angles, 10000 );

    if ( isdefined( self ) )
    {
        self.istraversing = undefined;
        self.grapple_land_over = undefined;
        self.grapple_config = undefined;
        self.grapple_end_anim = undefined;
        self.grapple_end_ent = undefined;
        self.grapple_target_ent = undefined;
        self.grapple_end_events = undefined;
    }
}

#using_animtree("generic_human");

grapple_traverse_init()
{
    level.grapple_traverse_init = 1;
    var_0 = [];
    var_0[var_0.size] = [ -180, -80, %grapple_traverse_vert_enter, %grapple_traverse_vert_loop, %grapple_traverse_up_exit, %grapple_traverse_over_exit ];
    var_0[var_0.size] = [ -80, -55, %grapple_traverse_up_enter, %grapple_traverse_up_loop, %grapple_traverse_up_exit, %grapple_traverse_over_exit ];
    var_0[var_0.size] = [ -55, -15, %grapple_traverse_up_enter_45, %grapple_traverse_up_loop_45, %grapple_traverse_up_exit_45, %grapple_traverse_over_exit_45 ];
    var_0[var_0.size] = [ -15, 15, %grapple_traverse_horiz_enter, %grapple_traverse_horiz_loop, %grapple_traverse_horiz_exit, %grapple_traverse_horiz_over_exit ];
    var_0[var_0.size] = [ 15, 180, %grapple_traverse_horiz_enter, %grapple_traverse_horiz_loop, %grapple_traverse_horiz_exit, %grapple_traverse_horiz_over_exit ];
    level.grapple_traverse_configs = var_0;
}

grapple_animate( var_0, var_1, var_2 )
{
    foreach ( var_4 in self.grapple_end_events )
        self endon( var_4 );

    if ( !isdefined( self.grapple_config ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 0.0;

    var_6 = 0.0;

    if ( isdefined( var_2 ) )
        var_6 = var_2;

    self.traverseanim = var_0;

    if ( isdefined( self.grapple_target_ent ) )
        self animscripted( "grappleanim", self.origin, vectortoangles( self.grapple_end_ent.origin - self.origin ), var_0 );
    else
        self setflaggedanimknoball( "grappleanim", var_0, %body, 1, var_6, 1 );

    self setanimtime( var_0, 0 );
    thread animscripts\shared::donotetracks( "grappleanim" );
    wait(max( getanimlength( var_0 ) - var_1, 0 ));
}

grapple_anim_lerp( var_0, var_1, var_2 )
{
    foreach ( var_4 in self.grapple_end_events )
        self endon( var_4 );

    self endon( var_2 );
    var_6 = distance( var_1, self.grapple_end_ent.origin );

    if ( var_6 <= 0 )
        return;

    for (;;)
    {
        var_7 = distance( self.origin, self.grapple_end_ent.origin );
        var_8 = clamp( 1.0 - var_7 / var_6, 0.0001, 0.9999 );
        self setanimtime( var_0, var_8 );
        wait 0.05;
    }
}

grapple_fire( var_0 )
{
    if ( !isdefined( self.grapple_config ) )
        return;

    var_1 = self.grapple_end_ent.origin - ( 0, 0, 8 );

    if ( isdefined( self.grapple_target_ent ) )
    {
        var_1 = self.grapple_end_ent.origin;
        self.grapple_surface_type = "metal";
    }
    else
    {
        var_2 = bullettrace( var_1, var_1 + var_0 * 60, 0 );
        var_1 = var_2["position"];
        self.grapple_surface_type = var_2["surfacetype"];
    }

    thread grapple_fire_rope_thread( var_1, var_0 );
    grapple_animate( self.grapple_config[2], 0, 0.2 );
    self notify( "traverse_grapple_fired" );
}

grapple_fire_rope_thread( var_0, var_1 )
{
    self endon( "death" );
    self waittillmatch( "grappleanim", "grapple_fire" );
    maps\_grapple::aud_grapple_launch();
    magicbullet( "s1_grapple_impact", var_0 + var_1 * -1.0, var_0 + var_1, level.player );
    var_2 = maps\_utility::spawn_anim_model( "grapple_rope", self gettagorigin( "tag_weapon_left" ) );
    var_2 linkto( self, "tag_weapon_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_2 thread maps\_anim::anim_single_solo( var_2, "fire_third_person" );
    var_2 show();
    var_3 = maps\_utility::spawn_anim_model( "grapple_rope_stretch", var_0 );
    var_3 show();

    if ( isdefined( self.grapple_target_ent ) )
        var_3 linkto( self.grapple_target_ent );

    var_2 drawfacingentity( var_3 );
    var_3 drawfacingentity( var_2 );

    if ( distancesquared( var_0, self gettagorigin( "tag_weapon_left" ) ) > 64009.0 )
        var_3 thread maps\_grapple::grapple_rope_length_thread( var_2, 1 );
    else
    {
        var_3 thread maps\_grapple::grapple_rope_length_thread( var_2, 2 );
        var_2 hide();
    }

    var_3 thread grapple_delete_monitor( self );
    var_2 thread grapple_delete_monitor( self );
    self waittill( "traverse_grapple_fired" );

    if ( isdefined( var_2 ) )
        var_2 hide();

    if ( isdefined( var_3 ) )
        var_3 thread maps\_grapple::grapple_rope_length_thread( var_2, 2 );

    self waittill( "traverse_grapple_traveled" );

    if ( isdefined( var_3 ) )
        var_3 delete();

    if ( isdefined( var_2 ) )
        var_2 delete();
}

grapple_travel_time( var_0, var_1 )
{
    var_2 = distance( var_0, var_1 ) / 600.0;
    return var_2;
}

grapple_travel( var_0, var_1 )
{
    if ( !isdefined( self.grapple_config ) )
        return;

    self endon( "death" );
    self.grapple_end_ent endon( "death" );
    var_2 = grapple_end_anim();
    self setanimtime( var_2, 0 );
    var_3 = getstartorigin( self.grapple_end_ent.origin, self.grapple_end_ent.angles, var_2 );
    var_4 = getstartangles( self.grapple_end_ent.origin, self.grapple_end_ent.angles, var_2 );
    var_5 = vectortoyaw( self.grapple_end_ent.origin - var_0 );
    var_6 = grapple_travel_time( var_0, var_3 );
    var_7 = self.grapple_config[3];
    thread grapple_animate( var_7 );
    thread grapple_anim_lerp( var_7, var_0, "traverse_grapple_traveled" );
    var_8 = common_scripts\utility::spawn_tag_origin();
    var_8.origin = var_0;
    var_8.angles = var_1;
    self linkto( var_8, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );

    if ( var_6 > 0 )
        var_8 moveto( var_3, var_6, 0, 0, self.grapple_end_ent );

    var_8 thread grapple_delete_monitor( self );

    while ( var_6 >= 0 )
    {
        self orientmode( "face angle", var_5 );
        var_6 -= 0.05;
        wait 0.05;
    }

    wait 0.05;
    self unlink();
    self orientmode( "face angle", getstartangles( self.grapple_end_ent.origin, self.grapple_end_ent.angles, var_2 )[1] );
    self notify( "traverse_grapple_traveled" );
}

grapple_land()
{
    if ( !isdefined( self.grapple_config ) )
        return;

    self endon( "death" );
    maps\_grapple::grapple_landing_sound( self.grapple_surface_type );
    self notify( "stop_grapplesound_npc" );
    var_0 = grapple_end_anim();
    self.traverseanim = var_0;
    self.traverseanimroot = %animscript_root;

    if ( isdefined( self.grapple_target_ent ) )
    {
        self linkto( self.grapple_target_ent );
        self animscripted( "grappleanim", self.grapple_end_ent.origin, self.grapple_end_ent.angles, var_0 );
    }
    else
        self setflaggedanimknoballrestart( "grappleanim", var_0, %animscript_root, 1, 0, 1 );

    childthread animscripts\shared::donotetracks( "grappleanim", animscripts\traverse\shared::handletraversenotetracks );
    wait(getanimlength( var_0 ));
    self notify( "grappleanim", "end" );
    self notify( "traverse_grapple_landed" );
}

grapple_end_anim()
{
    if ( isdefined( self.grapple_end_anim ) )
        return self.grapple_end_anim;
    else if ( isdefined( self.grapple_land_over ) && self.grapple_land_over )
        return self.grapple_config[5];
    else
        return self.grapple_config[4];
}

trace_end_position( var_0, var_1 )
{
    var_2 = 32.5;
    var_3 = var_1.origin;
    var_4 = self aiphysicstrace( var_3, var_3 - ( 0, 0, 50 ), undefined, undefined, 1, 1, 1 );

    if ( var_4["fraction"] < 1.0 )
        var_3 = var_4["position"];

    var_5 = self.origin - var_3;
    var_6 = vectornormalize( ( var_5[0], var_5[1], 0 ) );

    if ( isdefined( var_1.angles ) )
        var_6 = anglestoforward( var_1.angles ) * -1.0;

    var_3 += var_6 * 100;
    var_3 -= ( 0, 0, 5 );
    var_4 = self aiphysicstrace( var_3, ( var_1.origin[0], var_1.origin[1], var_3[2] ), undefined, undefined, 1, 1, 1 );

    if ( var_4["fraction"] < 1.0 )
        var_3 = var_4["position"];
    else
        var_3 += var_6 * 60;

    var_7 = var_1.origin[2] - var_2;
    var_8 = ( var_3[0], var_3[1], var_1.origin[2] ) + ( 0, 0, 70 ) + var_6 * -10;
    var_4 = self aiphysicstrace( var_8, var_8 + ( 0, 0, -100 ), undefined, undefined, 1, 1, 1 );

    if ( var_4["fraction"] < 1.0 )
        var_7 = var_4["position"][2];

    var_7 += 0.5;
    var_3 = ( var_3[0], var_3[1], var_7 );
    var_3 += var_6 * -15.0;

    if ( vectordot( var_1.origin - var_3, var_6 ) > 0 )
        var_3 = ( var_1.origin[0], var_1.origin[1], var_3[2] ) + var_6;

    self.grapple_land_over = var_7 - 16.0 > var_1.origin[2];
    return var_3;
}

grapple_add_void_point( var_0, var_1, var_2 )
{
    if ( !isdefined( level.grapple_void_points ) )
        level.grapple_void_points = [];

    var_3 = spawnstruct();
    var_3.origin = var_0;
    var_3.radiussq = var_1 * var_1;
    var_3.endtime = gettime() + var_2 * 1000.0;
    var_4 = gettime();

    foreach ( var_7, var_6 in level.grapple_void_points )
    {
        if ( var_6.endtime <= var_4 )
        {
            level.grapple_void_points[var_7] = var_3;
            return;
        }
    }

    level.grapple_void_points[level.grapple_void_points.size] = var_3;
}
