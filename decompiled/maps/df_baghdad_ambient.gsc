// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

a10_precache()
{

}

a10_spawn_funcs()
{
    thread a10_gun_dives();
    thread mig29_gun_dives();
    thread a10_missile_dives();
    thread mig29_missile_dives();
}

a10_gun_dives()
{
    maps\_utility::array_spawn_function_noteworthy( "a10_gun", ::setup_a10_waits );
}

mig29_gun_dives()
{

}

a10_missile_dives()
{
    maps\_utility::array_spawn_function_noteworthy( "a10_missile", ::setup_a10_waits );
}

mig29_missile_dives()
{
    maps\_utility::array_spawn_function_noteworthy( "mig29_missile", ::setup_mig29_waits );
}

setup_a10_waits()
{
    maps\_vehicle::godon();
    self setcontents( 0 );

    if ( isdefined( self.script_noteworthy ) )
    {
        thread wait_kill_me();

        if ( self.script_noteworthy == "a10_gun" )
        {
            thread a10_wait_start_firing();
            thread a10_wait_stop_firing();
        }
        else if ( self.script_noteworthy == "a10_missile" )
            thread a10_wait_fire_missile();
    }
}

setup_mig29_waits()
{
    maps\_vehicle::godon();
    self setcontents( 0 );

    if ( isdefined( self.script_noteworthy ) )
    {
        thread wait_kill_me( "mig29" );

        if ( self.script_noteworthy == "mig29_gun" )
        {
            thread mig29_wait_start_firing();
            thread mig29_wait_stop_firing();
        }
        else if ( self.script_noteworthy == "mig29_missile" )
            thread mig29_wait_fire_missile();
    }
}

a10_wait_start_firing()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "start_firing" );
    maps\_utility::ent_flag_wait( "start_firing" );
    maps\_utility::ent_flag_clear( "start_firing" );
    thread a10_30mm_fire();
}

mig29_wait_start_firing()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "start_firing" );
    maps\_utility::ent_flag_wait( "start_firing" );
    maps\_utility::ent_flag_clear( "start_firing" );
    thread mig29_fire();
}

a10_wait_stop_firing()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "stop_firing" );
    maps\_utility::ent_flag_wait( "stop_firing" );
    maps\_utility::ent_flag_clear( "stop_firing" );
}

mig29_wait_stop_firing()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "stop_firing" );
    maps\_utility::ent_flag_wait( "stop_firing" );
    maps\_utility::ent_flag_clear( "stop_firing" );
}

a10_wait_fire_missile()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "fire_missile" );
    maps\_utility::ent_flag_wait( "fire_missile" );

    if ( isdefined( self.script_parameters ) )
    {
        if ( self.script_parameters == "sat_array_a10_missile_dive_1" )
        {
            foreach ( var_1 in level.enemytanks )
            {
                if ( isdefined( var_1.script_noteworthy ) && !var_1 maps\_vehicle_code::is_corpse() && var_1.script_noteworthy == "sat_array_enemy_01" )
                {
                    thread a10_fire_missiles( var_1, 1 );
                    wait 0.2;
                }
            }
        }
        else if ( self.script_parameters == "crash_site_a10_missile_dive_1" )
        {
            foreach ( var_1 in level.crash_site_background_enemies )
            {
                if ( isdefined( var_1.script_noteworthy ) && !var_1 maps\_vehicle_code::is_corpse() && ( var_1.script_noteworthy == "crash_site_background_enemy_01" || var_1.script_noteworthy == "crash_site_background_enemy_02" ) )
                {
                    thread a10_fire_missiles( var_1, 1 );
                    wait 0.2;
                }
            }
        }
    }
    else
        thread a10_fire_missiles();

    maps\_utility::ent_flag_clear( "fire_missile" );
}

mig29_wait_fire_missile()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "fire_missile" );
    maps\_utility::ent_flag_wait( "fire_missile" );

    if ( isdefined( self.script_parameters ) )
    {
        if ( self.script_parameters == "crash_site_mig29_gun_dive_1" )
        {
            foreach ( var_1 in level.allytanks )
            {
                if ( isdefined( var_1.script_friendname ) && !var_1 maps\_vehicle_code::is_corpse() && ( var_1.script_friendname == "Boa" || var_1.script_friendname == "Banshee" || var_1.script_friendname == "Bullfrog" ) )
                {
                    thread mig29_fire_missiles( var_1 );
                    wait 0.2;
                }
            }
        }
        else if ( self.script_parameters == "crash_site_mig29_gun_dive_2" )
        {
            if ( isdefined( level.crash_site_a10_missile_dive_1 ) && !level.crash_site_a10_missile_dive_1 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.crash_site_a10_missile_dive_1, 1 );
            }
        }
        else if ( self.script_parameters == "crash_site_mig29_gun_dive_3" )
        {
            if ( isdefined( level.crash_site_a10_gun_dive_1 ) && !level.crash_site_a10_gun_dive_1 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.crash_site_a10_gun_dive_1, 1 );
            }
        }
        else if ( self.script_parameters == "intro_mig29_missile_c17_01" )
        {
            if ( isdefined( level.crashedc17_missile_org ) )
                thread mig29_fire_missiles( level.crashedc17_missile_org, 1 );
        }
        else if ( self.script_parameters == "intro_mig29_missile_c17_02" )
        {
            foreach ( var_1 in level.intro_allies_killed_by_mig )
            {
                thread mig29_fire_missiles( var_1 );
                wait 0.2;
            }
        }
        else if ( self.script_parameters == "air_strip_ambient_mig29_missile_dive_1" )
        {
            if ( isdefined( level.air_strip_ambient_a10_gun_dive_1 ) && !level.air_strip_ambient_a10_gun_dive_1 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.air_strip_ambient_a10_gun_dive_1, 1 );
            }
        }
        else if ( self.script_parameters == "air_strip_ambient_mig29_missile_dive_2" )
        {
            if ( isdefined( level.air_strip_ambient_a10_gun_dive_2 ) && !level.air_strip_ambient_a10_gun_dive_2 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.air_strip_ambient_a10_gun_dive_2, 1 );
            }
        }
        else if ( self.script_parameters == "air_strip_ambient_mig29_missile_dive_3" )
        {
            if ( isdefined( level.air_strip_ambient_a10_gun_dive_3 ) && !level.air_strip_ambient_a10_gun_dive_3 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.air_strip_ambient_a10_gun_dive_3, 1 );
            }
        }
        else if ( self.script_parameters == "base_array_ambient_mig29_missile_dive_1" )
        {
            if ( isdefined( level.base_array_ambient_a10_gun_dive_1 ) && !level.base_array_ambient_a10_gun_dive_1 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.base_array_ambient_a10_gun_dive_1, 1 );
            }
        }
        else if ( self.script_parameters == "base_array_ambient_mig29_missile_dive_2" )
        {
            if ( isdefined( level.base_array_ambient_a10_gun_dive_2 ) && !level.base_array_ambient_a10_gun_dive_2 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.base_array_ambient_a10_gun_dive_2, 1 );
            }
        }
        else if ( self.script_parameters == "base_array_ambient_mig29_missile_dive_3" )
        {
            if ( isdefined( level.base_array_ambient_a10_gun_dive_3 ) && !level.base_array_ambient_a10_gun_dive_3 maps\_vehicle_code::is_corpse() )
            {
                self.kill_target = 1;
                thread mig29_fire_missiles( level.base_array_ambient_a10_gun_dive_3, 1 );
            }
        }
    }
    else
        thread mig29_fire_missiles();

    maps\_utility::ent_flag_clear( "fire_missile" );
}

a10_missile_set_target( var_0 )
{
    var_0 endon( "death" );
    wait 0.2;
    self _meth_81D9( var_0 );

    if ( !var_0 istank() && isdefined( var_0.godmode ) && var_0.godmode == 1 )
        var_0 maps\_vehicle::godoff();

    self waittill( "death" );

    if ( isdefined( var_0 ) && var_0 istank() )
        var_0 thread handle_tank_death();
}

mig29_missile_set_target( var_0 )
{
    var_0 endon( "death" );
    wait 0.2;
    self _meth_81D9( var_0 );

    if ( !var_0 istank() && isdefined( var_0.godmode ) && var_0.godmode == 1 )
        var_0 maps\_vehicle::godoff();

    self waittill( "death" );

    if ( isdefined( var_0 ) && var_0 istank() )
        var_0 thread handle_tank_death();
}

a10_fire_missiles( var_0, var_1 )
{
    var_0 endon( "death" );
    var_2 = self gettagorigin( "tag_origin" );
    var_3 = var_2 + anglestoforward( self gettagangles( "tag_origin" ) + ( 0, 0, 30 ) ) * 100;
    var_4 = magicbullet( "f15_missile", var_2, var_3 );
    var_4.angles = self gettagangles( "tag_origin" );
    var_5 = self;

    if ( isdefined( var_0 ) )
    {
        var_4 thread a10_missile_set_target( var_0 );

        if ( isdefined( var_1 ) )
            var_4 thread monitor_missile_distance( 14400, var_0, var_5 );
    }
}

mig29_fire_missiles( var_0, var_1 )
{
    var_0 endon( "death" );
    var_2 = self gettagorigin( "tag_origin" );
    var_3 = var_2 + anglestoforward( self gettagangles( "tag_origin" ) + ( 0, 0, 30 ) ) * 100;
    var_4 = magicbullet( "f15_missile", var_2, var_3 );
    var_4.angles = self gettagangles( "tag_origin" );
    var_5 = self;

    if ( isdefined( var_0 ) )
    {
        var_4 thread mig29_missile_set_target( var_0 );

        if ( isdefined( var_1 ) )
            var_4 thread monitor_missile_distance( 14400, var_0, var_5 );
    }
}

monitor_missile_distance( var_0, var_1, var_2 )
{
    var_1 endon( "death" );

    while ( isdefined( self ) && isdefined( var_1 ) && distancesquared( self.origin, var_1.origin ) > var_0 )
        wait 0.05;

    if ( !isdefined( var_1 ) )
        return;

    if ( isdefined( self ) )
    {
        waitframe();
        playfx( level._effect["vfx_exp_sraam_no_missiles"], self.origin, anglestoforward( self.angles ) );
        self delete();
        wait 0.1;
    }

    if ( isdefined( var_2.kill_target ) && var_2.kill_target == 1 )
    {
        if ( !isdefined( var_1 ) )
            return;

        if ( var_1 maps\_vehicle::isvehicle() )
        {
            var_1 maps\_vehicle::godoff();

            if ( var_1 istank() )
                var_1 thread handle_tank_death();
            else
                var_1 _meth_8052();
        }

        wait 0.25;

        if ( isdefined( var_1 ) )
            var_1 delete();
    }
    else
    {
        if ( !isdefined( var_1 ) )
            return;

        if ( isdefined( level.crashedc17_missile_org ) && var_1 == level.crashedc17_missile_org )
            return;

        return;
    }
}

a10_30mm_fire()
{
    self endon( "death" );
    self endon( "stop_firing" );
}

mig29_fire()
{
    self endon( "death" );
    self endon( "stop_firing" );

    if ( isdefined( self.script_parameters ) && self.script_parameters == "no_magic_bullet" )
        self.no_magic_bullet = 1;

    for (;;)
    {
        var_0 = anglestoforward( self.angles );
        var_1 = self gettagorigin( "tag_flash" );
        var_2 = var_1 + var_0 * 999999999;
        earthquake( 0.2, 0.05, self.origin, 1000 );
        wait 0.1;
    }
}

mig29_afterburners_node_wait()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "start_afterburners" );
    maps\_utility::ent_flag_wait( "start_afterburners" );
    thread vehicle_scripts\_mig29::playafterburner();
}

wait_kill_me( var_0 )
{
    maps\_utility::ent_flag_init( "kill_me" );
    maps\_utility::ent_flag_wait( "kill_me" );

    if ( !isdefined( self ) )
        return;

    if ( isdefined( var_0 ) && var_0 == "mig29" )
    {
        stopfxontag( level._effect["contrail"], self, "tag_right_wingtip" );
        stopfxontag( level._effect["contrail"], self, "tag_left_wingtip" );
    }

    if ( !isdefined( self ) )
        return;

    if ( maps\_vehicle::isvehicle() )
    {
        maps\_vehicle::godoff();
        self _meth_8052();
    }

    wait 0.05;

    if ( isdefined( self ) )
        self delete();
}

base_array_ambient_dogfight_1()
{
    level endon( "base_array_end" );
    common_scripts\utility::flag_wait_or_timeout( "intro_flyby", 15 );

    for (;;)
    {
        wait(randomfloatrange( 10.0, 20.0 ));
        level.base_array_ambient_a10_gun_dive_1 = undefined;
        level.base_array_ambient_a10_gun_dive_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_1" );
        level.base_array_ambient_a10_gun_dive_1.alwaysrocketdeath = 1;

        if ( common_scripts\utility::cointoss() )
        {
            var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_1_buddy" );
            var_0.alwaysrocketdeath = 1;
        }

        wait 0.5;
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_1" );
        var_1 thread mig29_afterburners_node_wait();

        if ( common_scripts\utility::cointoss() )
            var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_1_buddy" );

        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

base_array_ambient_dogfight_4()
{
    level endon( "base_array_end" );
    var_0 = 1;
    common_scripts\utility::flag_wait_or_timeout( "intro_flyby", 15 );

    for (;;)
    {
        if ( !var_0 )
            wait(randomfloatrange( 10.0, 20.0 ));

        level.base_array_ambient_a10_gun_dive_4 = undefined;
        level.base_array_ambient_a10_gun_dive_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_4" );
        level.base_array_ambient_a10_gun_dive_4.alwaysrocketdeath = 1;

        if ( var_0 || common_scripts\utility::cointoss() )
        {
            var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_4_buddy" );
            var_1.alwaysrocketdeath = 1;
        }

        wait 0.5;
        var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_4" );
        var_2 thread mig29_afterburners_node_wait();

        if ( var_0 || common_scripts\utility::cointoss() )
            var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_4_buddy" );

        var_0 = 0;
        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

base_array_ambient_dogfight_2()
{
    level endon( "base_array_end" );

    for (;;)
    {
        wait(randomfloatrange( 15.0, 20.0 ));
        level.base_array_ambient_a10_gun_dive_2 = undefined;
        level.base_array_ambient_a10_gun_dive_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_2" );

        if ( common_scripts\utility::cointoss() )
            var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_2_buddy" );

        wait 0.5;
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_2" );
        var_1 thread mig29_afterburners_node_wait();

        if ( common_scripts\utility::cointoss() )
            var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_2_buddy" );

        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

base_array_ambient_dogfight_3()
{
    level endon( "base_array_end" );

    for (;;)
    {
        wait(randomfloatrange( 15.0, 30.0 ));
        level.base_array_ambient_a10_gun_dive_3 = undefined;
        level.base_array_ambient_a10_gun_dive_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_3" );

        if ( common_scripts\utility::cointoss() )
            var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_a10_gun_dive_3_buddy" );

        wait 0.5;
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_3" );
        var_1 thread mig29_afterburners_node_wait();

        if ( common_scripts\utility::cointoss() )
            var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "base_array_ambient_mig29_missile_dive_3_buddy" );

        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

air_strip_ambient_dogfight_1()
{
    level endon( "air_strip_end" );
    var_0 = 1;

    for (;;)
    {
        if ( !var_0 )
            wait(randomfloatrange( 10.0, 20.0 ));

        level.air_strip_ambient_a10_gun_dive_1 = undefined;
        level.air_strip_ambient_a10_gun_dive_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_a10_gun_dive_1" );

        if ( var_0 || common_scripts\utility::cointoss() )
            var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_a10_gun_dive_1_buddy" );

        wait 0.5;
        var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_mig29_missile_dive_1" );
        var_2 thread mig29_afterburners_node_wait();

        if ( var_0 || common_scripts\utility::cointoss() )
            var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_mig29_missile_dive_1_buddy" );

        var_0 = 0;
        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

air_strip_ambient_dogfight_2()
{
    level endon( "air_strip_end" );

    for (;;)
    {
        wait(randomfloatrange( 20.0, 40.0 ));
        level.air_strip_ambient_a10_gun_dive_2 = undefined;
        level.air_strip_ambient_a10_gun_dive_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_a10_gun_dive_2" );

        if ( common_scripts\utility::cointoss() )
            var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_a10_gun_dive_2_buddy" );

        wait 0.5;
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_mig29_missile_dive_2" );
        var_1 thread mig29_afterburners_node_wait();

        if ( common_scripts\utility::cointoss() )
            var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_mig29_missile_dive_2_buddy" );

        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

air_strip_ambient_dogfight_3()
{
    level endon( "air_strip_end" );

    for (;;)
    {
        wait(randomfloatrange( 15.0, 30.0 ));
        level.air_strip_ambient_a10_gun_dive_3 = undefined;
        level.air_strip_ambient_a10_gun_dive_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_a10_gun_dive_3" );

        if ( common_scripts\utility::cointoss() )
            var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_a10_gun_dive_3_buddy" );

        wait 0.5;
        var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_mig29_missile_dive_3" );
        var_1 thread mig29_afterburners_node_wait();

        if ( common_scripts\utility::cointoss() )
            var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "air_strip_ambient_mig29_missile_dive_3_buddy" );

        wait(randomfloatrange( 5.0, 10.0 ));
    }
}

handle_tank_death()
{
    iprintlnbold( "trying to kill  a tank!" );
}

istank()
{
    return 0;
}
