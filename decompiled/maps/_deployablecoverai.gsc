// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

battle_deployable_cover_setup()
{
    deployable_cover_anims();
    level.deployablecover = [];
    var_0 = common_scripts\utility::getstructarray( "deployable_cover_animnode", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = getent( var_2.target, "targetname" );
        var_3.contents = var_3 setcontents( 0 );
        var_3 hide();
        var_4 = getent( var_3.target, "targetname" );
        var_4 notsolid();
        var_4 connectpaths();
        var_5 = getentarray( var_4.target, "targetname" );

        foreach ( var_7 in var_5 )
            var_7 disconnectnode();

        level.deployablecover[level.deployablecover.size] = var_2;
    }
}

handle_deployable_cover( var_0, var_1 )
{
    thread deployable_cover_think();

    if ( isdefined( var_1 ) )
        common_scripts\utility::flag_wait( var_1 );

    if ( !isdefined( level.deployablecoverinuse ) )
        level.deployablecoverinuse = 0;
    else
    {
        level.deployablecoverinuse++;

        if ( level.deployablecoverinuse >= level.deployablecover.size )
            level.deployablecoverinuse = 0;
    }

    var_2 = 0;

    if ( isdefined( var_0 ) )
    {
        for (;;)
        {
            var_3 = getent( var_0, "targetname" );

            if ( isdefined( var_3 ) && ispointinvolume( level.deployablecover[level.deployablecoverinuse].origin, var_3 ) && !isdefined( level.deployablecover[level.deployablecoverinuse].isused ) )
                break;
            else
            {
                level.deployablecoverinuse++;

                if ( level.deployablecoverinuse >= level.deployablecover.size )
                {
                    level.deployablecoverinuse = 0;
                    var_2++;
                    wait 5;

                    if ( var_2 > 3 )
                        return;
                }
            }

            wait 0.25;

            if ( !isalive( self ) )
                return;
        }
    }

    if ( isalive( self ) && isdefined( level.deployablecover[level.deployablecoverinuse].isused ) )
    {
        handle_deployable_cover( var_0, var_1 );
        return;
    }

    var_4 = level.deployablecoverinuse;
    level.deployablecover[var_4].isused = 1;
    var_5 = level.deployablecover[var_4];
    var_6 = getent( var_5.target, "targetname" );
    var_7 = getent( var_6.target, "targetname" );
    var_8 = getentarray( var_7.target, "targetname" );

    if ( isalive( self ) )
    {
        self.animname = "generic";
        self.ignoreme = 1;
        self.ignoresuppression = 1;
        thread deployable_cover_focus_goal();
        thread deployable_cover_watch_death( var_4 );
        var_5 maps\_anim::anim_reach_solo( self, "deployable_cover_deploy" );
    }

    var_9 = maps\_utility::spawn_anim_model( "deployable_cover", ( 0, 0, 0 ) );
    var_9 show();

    if ( isalive( self ) )
    {
        thread deployable_cover_kill( var_9 );
        thread deployable_cover_cleanup( var_9, var_6, var_7, var_8, var_4 );
        self notify( "placing_deployable_cover" );
        var_10 = [ self, var_9 ];
        var_5 thread maps\_anim::anim_single( var_10, "deployable_cover_deploy" );
    }

    if ( isalive( self ) )
        wait 2.3;

    if ( isalive( self ) )
        self notify( "deployable_start" );

    if ( isalive( self ) )
        wait 2.5;

    if ( isdefined( var_9 ) )
    {
        var_9.set = 1;
        var_9 waittillmatch( "single anim", "end" );
    }

    if ( isdefined( self ) )
    {
        self notify( "deployable_cleanup" );
        self notify( "deployable_finished" );
    }
}

deployable_cover_think()
{
    var_0 = spawn( "script_model", self gettagorigin( "j_SpineUpper" ) + ( 0, 0, 0 ) );
    var_0.angles = self gettagangles( "j_SpineUpper" ) + ( 0, 0, 0 );
    var_0.animname = "deployable_cover";
    var_0 setmodel( "deployable_cover" );
    var_0 maps\_anim::setanimtree();
    var_0 maps\_anim::anim_first_frame_solo( var_0, "deployable_cover_closed_idle" );
    var_0 linkto( self, "j_SpineUpper" );
    self waittill( "placing_deployable_cover" );
    var_0 delete();
}

deployable_cover_focus_goal()
{
    self endon( "death" );
    self endon( "placing_deployable_cover" );

    for (;;)
    {
        self.goalradius = 16;
        waitframe();
    }
}

deployable_cover_watch_death( var_0 )
{
    self endon( "placing_deployable_cover" );
    self waittill( "damage" );
    level.deployablecover[var_0].isused = undefined;
}

deployable_cover_kill( var_0 )
{
    self endon( "deployable_finished" );
    self endon( "deployable_double" );
    self waittill( "damage" );

    if ( isdefined( self ) && isalive( self ) )
    {
        maps\_utility::anim_stopanimscripted();
        self kill();
    }

    var_0 maps\_utility::anim_stopanimscripted();
    self notify( "deployable_cleanup" );
}

deployable_cover_cleanup( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "deployable_double" );
    common_scripts\utility::waittill_any( "deployable_start", "death" );
    waitframe();

    if ( isalive( self ) )
    {
        var_2 solid();
        var_2 disconnectpaths();
    }

    if ( isalive( self ) )
        common_scripts\utility::waittill_any( "deployable_cleanup", "death" );

    if ( isalive( self ) || isdefined( var_0.set ) )
    {
        var_1 setcontents( var_1.contents );
        var_1 show();

        foreach ( var_6 in var_3 )
            var_6 connectnode();
    }
    else
    {
        var_2 notsolid();
        var_2 connectpaths();
        level.deployablecover[var_4].isused = undefined;
    }

    waitframe();
    self notify( "goal" );
    var_0 delete();
}

deployable_cover_anims()
{
    deployable_cover_ai();
    deployable_cover_model();
}

#using_animtree("generic_human");

deployable_cover_ai()
{
    level.scr_anim["generic"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_carter_enter;
    level.scr_anim["generic"]["deployable_cover_deploy_idle"][0] = %fusion_lift_deploy_cover_carter_idle;
}

#using_animtree("script_model");

deployable_cover_model()
{
    level.scr_animtree["deployable_cover"] = #animtree;
    level.scr_model["deployable_cover"] = "deployable_cover";
    level.scr_anim["deployable_cover"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_deployable_cover_prop_enter;
    level.scr_anim["deployable_cover"]["deployable_cover_closed_idle"] = %fusion_lift_deploy_cover_idle_closed;
    level.scr_anim["deployable_cover"]["deployable_cover_open_idle"] = %fusion_lift_deploy_cover_idle_opened;
}

print3d_over_target()
{
    self endon( "death" );

    for (;;)
        wait 1;
}
