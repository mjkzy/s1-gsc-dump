// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

cg_spawn_perf_monitor( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( var_0 );

    if ( isdefined( var_1 ) )
        cg_spawn_perf_monitor_setup( var_1 );

    if ( isdefined( var_4 ) )
        cg_never_delete_setup( var_4 );

    var_5 = maps\_sarray::sarray_spawn();

    if ( isdefined( var_3 ) && var_3 == 1 )
        thread debug_draw_living_ai( var_0 );

    for (;;)
    {
        wait 0.2;
        var_5 maps\_sarray::sarray_clear();
        var_6 = getaiarray();

        foreach ( var_8 in var_6 )
        {
            if ( !isdefined( var_8.neverdelete ) && var_8.team == "allies" )
                var_8.neverdelete = 1;

            if ( !isdefined( var_8.neverdelete ) && var_8.team != "allies" )
                var_8.neverdelete = 0;

            if ( isdefined( var_8.neverdelete ) && var_8.neverdelete == 0 )
                var_5 maps\_sarray::sarray_push( var_8 );
        }

        var_10 = var_6.size;

        if ( var_10 > var_2 )
        {
            score_and_sort_current_spawns( var_5 );
            var_11 = var_10 - var_2;

            foreach ( var_13 in var_5.array )
            {
                if ( var_11 == 0 )
                    break;

                if ( isalive( var_13 ) && isdefined( var_13.magic_bullet_shield ) )
                    var_13 maps\_utility::stop_magic_bullet_shield();

                if ( var_13.deleteme == 1 )
                    var_13 delete();
                else
                    var_13 kill();

                var_11--;
                wait 0.05;
            }
        }
    }
}

cg_spawn_perf_monitor_setup( var_0 )
{
    foreach ( var_2 in var_0 )
        maps\_utility::array_spawn_function_noteworthy( var_2, ::trackailifespawn );
}

cg_never_delete_setup( var_0 )
{
    foreach ( var_2 in var_0 )
        maps\_utility::array_spawn_function_noteworthy( var_2, ::settoneverdelete );
}

score_and_sort_current_spawns( var_0 )
{
    foreach ( var_2 in var_0.array )
    {
        var_2.killnowscore = 0;

        if ( !isdefined( var_2.lifetimer ) )
            var_2.lifetimer = 0;

        if ( !isdefined( var_2.deleteme ) )
            var_2 thread trackkillordelete();

        var_2.killnowscore += var_2.lifetimer;

        if ( !checktargetisinfrontofplayer( level.player, var_2 ) )
            var_2.killnowscore += 10;

        var_3 = level.player geteye();

        if ( var_2 sightconetrace( var_3 ) == 0 )
            var_2.killnowscore += 10;
        else
            var_2.killnowscore -= var_2.lifetimer;

        var_4 = distance( var_2.origin, level.player.origin );

        if ( var_4 > 1024 )
            var_2.killnowscore += 10;
    }

    maps\_sarray::sarray_sort_by_handler( var_0, maps\_sarray::sarray_create_func_obj( ::compare_killnow_score ) );
}

trackailifespawn()
{
    self endon( "death" );
    self.lifetimer = 0;

    for (;;)
    {
        wait 0.5;
        self.lifetimer += 0.5;
    }
}

trackkillordelete()
{
    self endon( "death" );
    self.deleteme = 1;

    for (;;)
    {
        var_0 = level.player geteye();

        if ( self sightconetrace( var_0 ) == 1 )
        {
            self.deleteme = 0;
            return;
        }

        wait 0.2;
    }
}

compare_time_since_birth( var_0, var_1 )
{
    if ( !isdefined( var_0.lifetimer ) )
        var_0.lifetimer = 0;

    if ( !isdefined( var_1.lifetimer ) )
        var_1.lifetimer = 0;

    return var_0.lifetimer > var_1.lifetimer;
}

compare_killnow_score( var_0, var_1 )
{
    return var_0.killnowscore > var_1.killnowscore;
}

checktargetisinfrontofplayer( var_0, var_1 )
{
    var_2 = anglestoforward( var_0.angles );
    var_3 = var_1.origin - var_0.origin;
    var_4 = vectordot( var_2, var_3 );
    return var_4 > 0;
}

settoneverdelete()
{
    self.neverdelete = 1;
}

debug_draw_living_ai( var_0 )
{
    level endon( var_0 );
    var_1 = setupdebughudelem();
    thread deletedebughudelem( var_0, var_1 );

    for (;;)
    {
        wait 0.05;
        var_2 = getaiarray();
        var_1 settext( "" + var_2.size );

        foreach ( var_4 in var_2 )
        {
            var_5 = ( 0, 1, 0 );

            if ( isdefined( var_4.team ) && var_4.team != "allies" )
                var_5 = ( 1, 0, 0 );
        }
    }
}

deletedebughudelem( var_0, var_1 )
{
    level waittill( var_0 );
    var_1 destroy();
}

setupdebughudelem()
{
    var_0 = newhudelem();
    var_0.alignx = "left";
    var_0.aligny = "top";
    var_0.x = 40;
    var_0.y = 40;
    var_0.alpha = 0.6;
    var_0.fontscale = 1.5;
    var_0.foreground = 1;
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    return var_0;
}
