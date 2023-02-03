// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "atlas_suv", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_atlas_suv", "vehicle_atlas_suv_dstrypv" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner", "Tag_death_fx", "car_explode", undefined, undefined, undefined, 0 );

    if ( var_2 == "script_vehicle_atlas_suv_physics_explode" )
        maps\_vehicle::build_radiusdamage( ( 0, 0, 53 ), 256, 300, 20, 1, 0 );

    maps\_vehicle::build_drive( %sf_suv_driving_idle_forward, %sf_suv_driving_idle_backward, 10 );
    maps\_vehicle::build_deathquake( 1, 1.6, 500 );
    maps\_vehicle::build_life( 750 );
    maps\_vehicle::build_team( "axis" );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/tread_dust_default" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_unload_groups( ::unload_groups );
}

init_local()
{
    maps\_utility::ent_flag_init( "lrear_window_open" );
    maps\_utility::ent_flag_init( "rrear_window_open" );
    maps\_utility::ent_flag_init( "rear_window_open" );
    thread clear_anim_on_death();
    soundscripts\_snd::snd_message( "atlas_van_explode", level.player_pitbull );

    if ( !isdefined( self.script_allow_rider_deaths ) )
        self.script_allow_rider_deaths = 1;

    if ( !isdefined( self.script_allow_driver_death ) )
        self.script_allow_driver_death = 1;
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %atlas_suv_dismount_frontl_door;
    var_0[1].vehicle_getoutanim = %atlas_suv_dismount_frontr_door;
    var_0[2].vehicle_getoutanim = %atlas_suv_dismount_backl_door;
    var_0[3].vehicle_getoutanim = %atlas_suv_dismount_backr_door;
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 9; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_driver";
    var_0[0].idle = %atlas_suv_idle_frontl;
    var_0[0].getout = %atlas_suv_dismount_frontl;
    var_0[0].death = %sf_suv_lrear_death;
    var_0[0].death_no_ragdoll = 1;
    var_0[0].death_flop_dir = ( 0, 2500, 0 );
    var_0[0].min_unload_frac_to_flop = 0.55;
    var_0[1].sittag = "tag_passenger";
    var_0[1].idle = %atlas_suv_idle_frontr;
    var_0[1].getout = %atlas_suv_dismount_frontr;
    var_0[1].death = %sf_suv_rrear_death;
    var_0[1].death_no_ragdoll = 1;
    var_0[1].death_flop_dir = ( 0, -2500, 0 );
    var_0[1].min_unload_frac_to_flop = 0.55;
    var_0[2].sittag = "tag_guy0";
    var_0[2].idle = %atlas_suv_idle_backl;
    var_0[2].getout = %atlas_suv_dismount_backl;
    var_0[2].death = %sf_suv_lrear_death;
    var_0[2].death_no_ragdoll = 1;
    var_0[2].rider_func = ::atlas_suv_rider_think;
    var_0[2].death_flop_dir = ( 0, 2500, 0 );
    var_0[2].min_unload_frac_to_flop = 0.6;
    var_0[3].sittag = "tag_guy1";
    var_0[3].idle = %atlas_suv_idle_backr;
    var_0[3].getout = %atlas_suv_dismount_backr;
    var_0[3].death = %sf_suv_rrear_death;
    var_0[3].death_no_ragdoll = 1;
    var_0[3].rider_func = ::atlas_suv_rider_think;
    var_0[3].death_flop_dir = ( 0, -2500, 0 );
    var_0[3].min_unload_frac_to_flop = 0.6;
    var_0[4].sittag = "tag_guy2";
    var_0[4].idle = %suburban_idle_backr;
    var_0[4].death = %sf_suv_rear_death;
    var_0[4].death_no_ragdoll = 1;
    var_0[4].rider_func = ::atlas_suv_rider_think;
    var_0[4].customunloadfunc = ::do_nothing;
    var_0[4].death_flop_dir = ( 0, -2500, 0 );
    return var_0;
}

unload_groups()
{
    var_0 = [];
    var_0["passengers"] = [];
    var_0["all"] = [];
    var_1 = "passengers";
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0[var_1][var_0[var_1].size] = 4;
    var_1 = "all";
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0[var_1][var_0[var_1].size] = 4;
    var_0["default"] = var_0["all"];
    return var_0;
}

do_nothing( var_0, var_1 )
{

}

setup_rider_anims( var_0 )
{
    self.rider_anims = [];

    if ( var_0 == "tag_guy0" )
    {
        self.rider_anims["idle"] = %sf_suv_lrear_inside_idle;
        self.rider_anims["popout"] = %sf_suv_lrear_popout;
        self.rider_anims["aim_2"] = %sf_suv_lrear_idle_aim_2;
        self.rider_anims["aim_4"] = %sf_suv_lrear_idle_aim_4;
        self.rider_anims["aim_5"] = %sf_suv_lrear_idle_aim_5;
        self.rider_anims["aim_6"] = %sf_suv_lrear_idle_aim_6;
        self.rider_anims["aim_8"] = %sf_suv_lrear_idle_aim_8;
        self.rider_anims["popin"] = %sf_suv_lrear_popin;
        self.rider_anims["react"] = %sf_suv_lrear_react;
        self.rider_anims["death"] = %sf_suv_lrear_death;
        self.rider_anims["fire_1"] = %sf_suv_lrear_fire_1;
        self.rider_anims["fire_2"] = %sf_suv_lrear_fire_2;
        self.rider_anims["fire_3"] = %sf_suv_lrear_fire_3;
        self.rider_anims["fire_4"] = %sf_suv_lrear_fire_4;
        self.rider_anims["fire_5"] = %sf_suv_lrear_fire_5;
    }
    else if ( var_0 == "tag_guy1" )
    {
        self.rider_anims["idle"] = %sf_suv_rrear_inside_idle;
        self.rider_anims["popout"] = %sf_suv_rrear_popout;
        self.rider_anims["aim_2"] = %sf_suv_rrear_idle_aim_2;
        self.rider_anims["aim_4"] = %sf_suv_rrear_idle_aim_4;
        self.rider_anims["aim_5"] = %sf_suv_rrear_idle_aim_5;
        self.rider_anims["aim_6"] = %sf_suv_rrear_idle_aim_6;
        self.rider_anims["aim_8"] = %sf_suv_rrear_idle_aim_8;
        self.rider_anims["popin"] = %sf_suv_rrear_popin;
        self.rider_anims["react"] = %sf_suv_rrear_react;
        self.rider_anims["death"] = %sf_suv_rrear_death;
        self.rider_anims["fire_1"] = %sf_suv_rrear_fire_1;
        self.rider_anims["fire_2"] = %sf_suv_rrear_fire_2;
        self.rider_anims["fire_3"] = %sf_suv_rrear_fire_3;
        self.rider_anims["fire_4"] = %sf_suv_rrear_fire_4;
        self.rider_anims["fire_5"] = %sf_suv_rrear_fire_5;
    }
    else if ( var_0 == "tag_guy2" )
    {
        self.rider_anims["idle"] = %sf_suv_rear_inside_idle;
        self.rider_anims["popout"] = %sf_suv_rear_popout;
        self.rider_anims["aim_2"] = %sf_suv_rear_idle_aim_2;
        self.rider_anims["aim_4"] = %sf_suv_rear_idle_aim_4;
        self.rider_anims["aim_5"] = %sf_suv_rear_idle_aim_5;
        self.rider_anims["aim_6"] = %sf_suv_rear_idle_aim_6;
        self.rider_anims["aim_8"] = %sf_suv_rear_idle_aim_8;
        self.rider_anims["react"] = %sf_suv_rear_react;
        self.rider_anims["death"] = %sf_suv_rear_death;
        self.rider_anims["fire_1"] = %sf_suv_rear_fire_1;
        self.rider_anims["fire_2"] = %sf_suv_rear_fire_2;
        self.rider_anims["fire_3"] = %sf_suv_rear_fire_3;
        self.rider_anims["fire_4"] = %sf_suv_rear_fire_4;
        self.rider_anims["fire_5"] = %sf_suv_rear_fire_5;
    }
    else if ( var_0 == "tag_driver" )
        self.rider_anims["death"] = %sf_suv_lrear_death;
    else if ( var_0 == "tag_passenger" )
        self.rider_anims["death"] = %sf_suv_rrear_death;
}

atlas_suv_rider_think()
{
    if ( !isdefined( self ) )
        return;

    if ( !isdefined( self.vehicle_position ) )
        return;

    if ( !isdefined( self.ridingvehicle ) )
        return;

    atlas_suv_rider_no_react();
    var_0 = self.ridingvehicle;
    var_1 = maps\_vehicle_aianim::anim_pos( var_0, self.vehicle_position );
    setup_rider_anims( var_1.sittag );
    self setanimknoball( %atlas_suv, %root, 1.0, 0.0 );
    thread rider_think_loop( var_0, var_1.sittag );
}

enable_react_on_unload()
{
    self endon( "death" );
    self waittill( "unload" );

    if ( isdefined( self ) && isalive( self ) )
        atlas_suv_rider_react();
}

atlas_suv_rider_no_react()
{
    thread enable_react_on_unload();
    self.grenadeawareness = 0;
    maps\_utility::disable_surprise();
    self.allowpain = 0;
    self.flashbangimmunity = 1;
    self.disablebulletwhizbyreaction = 1;
}

atlas_suv_rider_react()
{
    self.grenadeawareness = 1;
    maps\_utility::enable_surprise();
    self.allowpain = 1;
    self.flashbangimmunity = 0;
    self.disablebulletwhizbyreaction = undefined;
}

rider_think_loop( var_0, var_1 )
{
    self endon( "death" );
    self endon( "jumpedout" );
    self endon( "jumping_out" );

    for (;;)
    {
        thread play_idle_anim();
        var_2 = find_threat( var_1 );
        play_combat_state( var_0, var_1, var_2 );
    }
}

find_threat( var_0 )
{
    var_1 = self.enemy;

    for (;;)
    {
        if ( isdefined( self.enemy ) )
        {
            var_1 = self.enemy;
            var_2 = var_1 geteye() - self geteye();
            var_3 = vectornormalize( var_2 );
            var_4 = anglestoforward( self.angles );
            var_5 = vectordot( var_3, var_4 );

            if ( var_5 > 0.707 && var_0 == "tag_guy2" )
                break;

            if ( var_5 < 0 )
            {
                var_6 = anglestoright( self.angles );
                var_7 = vectordot( var_3, var_6 );

                if ( var_7 < 0 && var_0 == "tag_guy0" )
                    break;

                if ( var_7 > 0 && var_0 == "tag_guy1" )
                    break;
            }
        }

        wait 0.1;
    }

    return var_1;
}

play_idle_anim()
{
    self endon( "stop_idle_loop" );
    self endon( "death" );
    self endon( "jumpedout" );
    self endon( "jumping_out" );
    var_0 = self.ridingvehicle;
    var_1 = maps\_vehicle_aianim::anim_pos( var_0, self.vehicle_position );

    for (;;)
    {
        self notify( "newanim" );
        var_0 maps\_vehicle_aianim::animontag( self, var_1.sittag, self.rider_anims["idle"] );
    }
}

play_combat_state( var_0, var_1, var_2 )
{
    self endon( "death" );
    self notify( "stop_idle_loop" );
    self notify( "newanim" );
    thread open_window( var_0, var_1 );
    var_0 maps\_vehicle_aianim::animontag( self, var_1, self.rider_anims["popout"] );

    if ( isdefined( var_2 ) )
        play_aim_anim( var_1, var_2 );

    self clearanim( %atlas_suv_aiming, 0.2 );

    if ( isdefined( self.rider_anims["popin"] ) )
        var_0 maps\_vehicle_aianim::animontag( self, var_1, self.rider_anims["popin"] );
}

custom_aim_notetracks( var_0 )
{
    self endon( "killanimscript" );

    for (;;)
    {
        self waittill( var_0, var_1 );

        if ( isdefined( var_1 ) )
            animscripts\notetracks::handlenotetrack( var_1, var_0 );
    }
}

custom_aim_animscript()
{
    self endon( "killanimscript" );
    self clearanim( %atlas_suv_actions, 0.2 );
    self setanim( %atlas_suv_aiming, 1, 0, 1 );
    var_0 = "combat_aim";
    thread custom_aim_notetracks( var_0 );
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    if ( self.animscript_sittag == "tag_guy0" )
    {
        var_1 = 90;
        var_2 = 180;
        var_3 = 135;
    }
    else if ( self.animscript_sittag == "tag_guy1" )
    {
        var_1 = 0;
        var_2 = 90;
        var_3 = 45;
    }
    else if ( self.animscript_sittag == "tag_guy2" )
    {
        var_1 = 45;
        var_2 = 135;
        var_3 = 90;
    }

    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    for (;;)
    {
        if ( !isdefined( self.animscript_target ) )
            self notify( "kill_aim_anim" );

        if ( isdefined( self.animscript_target ) )
        {
            var_7 = self.animscript_target geteye() - self geteye();
            var_8 = vectornormalize( var_7 );
            var_9 = anglestoforward( self.angles );
            var_10 = vectordot( var_8, var_9 );

            if ( self.animscript_sittag == "tag_guy2" )
            {
                if ( var_10 < 0 )
                    self notify( "kill_aim_anim" );
            }
            else if ( var_10 > 0 )
                self notify( "kill_aim_anim" );

            var_11 = anglestoright( self.angles );
            var_12 = vectordot( var_8, var_11 );
            var_13 = acos( var_12 );
            var_13 = angleclamp180( var_13 );
            var_13 = clamp( var_13, var_1, var_2 );

            if ( self.animscript_sittag == "tag_guy1" )
                var_13 = 90 - var_13;
            else if ( self.animscript_sittag == "tag_guy2" )
                var_13 = 180 - var_13;

            var_13 -= var_3;
            var_4 = var_13 / 45;
        }

        var_14 = var_4 - var_5;
        var_14 = clamp( var_14, -0.1, 0.1 );
        var_4 = var_5 + var_14;
        var_5 = var_4;

        if ( var_4 < 0 )
        {
            var_15 = var_4 * -1;
            var_16 = 1 - var_15;
            var_17 = 0;
        }
        else
        {
            var_17 = var_4;
            var_16 = 1 - var_17;
            var_15 = 0;
        }

        var_15 = clamp( var_15, 0, 1 );
        var_16 = clamp( var_16, 0, 1 );
        var_17 = clamp( var_17, 0, 1 );
        update_anim_weight( self.rider_anims["aim_4"], var_15 );
        update_anim_weight( self.rider_anims["aim_5"], var_16 );
        update_anim_weight( self.rider_anims["aim_6"], var_17 );

        if ( isdefined( var_6 ) && var_6 > 0 )
            var_6 -= 0.05;
        else
        {
            var_18 = [ "fire_1", "fire_2", "fire_3", "fire_4", "fire_5" ];
            var_19 = var_18[randomint( var_18.size )];
            var_20 = self.rider_anims[var_19];

            if ( isdefined( var_20 ) )
            {
                var_6 = getanimlength( var_20 );
                var_6 += randomfloatrange( 0, 2 );
                self setflaggedanimknobrestart( var_0, var_20, 1, 0, 1 );
            }
        }

        wait 0.05;
    }
}

#using_animtree("vehicles");

open_window( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;

    if ( var_1 == "tag_guy0" )
    {
        var_2 = "lrear_window_open";
        var_3 = %sf_suv_lrear_window_open;
    }
    else if ( var_1 == "tag_guy1" )
    {
        var_2 = "rrear_window_open";
        var_3 = %sf_suv_rrear_window_open;
    }
    else if ( var_1 == "tag_guy2" )
    {
        var_2 = "rear_window_open";
        var_3 = %sf_suv_rear_window_open;
    }

    if ( isdefined( var_2 ) )
    {
        if ( !var_0 maps\_utility::ent_flag( var_2 ) )
        {
            var_0 setanim( var_3, 1, 0, 1 );
            var_0 maps\_utility::ent_flag_set( var_2 );
        }
    }
}

update_anim_weight( var_0, var_1 )
{
    self setanim( var_0, var_1, 0, 1 );
}

play_aim_anim( var_0, var_1 )
{
    thread notify_kill_aim_anim( var_1 );
    self.animscript_sittag = var_0;
    self.animscript_target = var_1;
    self animcustom( ::custom_aim_animscript );
    wait 0.05;
    self waittill( "kill_aim_anim" );
    self notify( "killanimscript" );
}

notify_on_death( var_0 )
{
    self endon( "kill_aim_anim" );
    var_0 waittill( "death" );
    wait 0.2;
    self notify( "kill_aim_anim" );
}

notify_kill_aim_anim( var_0 )
{
    self endon( "death" );
    self endon( "kill_aim_anim" );

    if ( !isdefined( var_0 ) )
        self notify( "kill_aim_anim" );

    thread notify_on_death( var_0 );
}

clear_anim_on_death()
{
    self waittill( "death_finished" );
    self clearanim( %root, 0 );
}
