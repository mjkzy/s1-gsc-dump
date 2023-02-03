// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

multiple_dialogue_queue( var_0 )
{
    maps\_utility::bcs_scripted_dialogue_start();

    if ( isdefined( self.last_queue_time ) )
        maps\_utility::wait_for_buffer_time_to_pass( self.last_queue_time, 0.5 );

    var_1 = [];
    var_1[0] = [ self, 0 ];
    maps\_utility::function_stack( ::anim_single_end_early, var_1, var_0 );

    if ( isalive( self ) )
        self.last_queue_time = gettime();
}

anim_single_end_early( var_0, var_1, var_2 )
{
    var_3 = self;
    var_4 = [];

    foreach ( var_7, var_6 in var_0 )
        var_4[var_7] = var_6[0];

    foreach ( var_9 in var_4 )
    {
        if ( !isdefined( var_9 ) )
            continue;

        if ( !isdefined( var_9._animactive ) )
            var_9._animactive = 0;

        var_9._animactive++;
    }

    var_11 = maps\_anim::get_anim_position( var_2 );
    var_12 = var_11["origin"];
    var_13 = var_11["angles"];
    var_14 = "single anim";
    var_15 = spawnstruct();
    var_16 = 0;

    foreach ( var_7, var_9 in var_4 )
    {
        var_18 = 0;
        var_19 = 0;
        var_20 = 0;
        var_21 = 0;
        var_22 = undefined;
        var_23 = undefined;
        var_24 = var_9.animname;

        if ( isdefined( level.scr_face[var_24] ) && isdefined( level.scr_face[var_24][var_1] ) )
        {
            var_18 = 1;
            var_23 = level.scr_face[var_24][var_1];
        }

        if ( isdefined( level.scr_sound[var_24] ) && isdefined( level.scr_sound[var_24][var_1] ) )
        {
            var_19 = 1;
            var_22 = level.scr_sound[var_24][var_1];
        }

        if ( isdefined( level.scr_anim[var_24] ) && isdefined( level.scr_anim[var_24][var_1] ) && ( !isai( var_9 ) || !var_9 maps\_utility::doinglongdeath() ) )
            var_20 = 1;

        if ( isdefined( level.scr_animsound[var_24] ) && isdefined( level.scr_animsound[var_24][var_1] ) )
            var_9 playsound( level.scr_animsound[var_24][var_1] );

        if ( var_20 )
        {
            var_9 maps\_anim::last_anim_time_check();

            if ( isplayer( var_9 ) )
            {
                var_25 = level.scr_anim[var_24]["root"];
                var_9 setanim( var_25, 0, 0.2 );
                var_26 = level.scr_anim[var_24][var_1];
                var_9 setflaggedanim( var_14, var_26, 1, 0.2 );
            }
            else if ( var_9.code_classname == "misc_turret" )
            {
                var_26 = level.scr_anim[var_24][var_1];
                var_9 setflaggedanim( var_14, var_26, 1, 0.2 );
            }
            else
                var_9 animscripted( var_14, var_12, var_13, level.scr_anim[var_24][var_1] );

            thread maps\_anim::start_notetrack_wait( var_9, var_14, var_1, var_24, level.scr_anim[var_24][var_1] );
            thread maps\_anim::animscriptdonotetracksthread( var_9, var_14, var_1 );
        }

        if ( var_18 || var_19 )
        {
            if ( var_18 )
            {
                if ( var_19 )
                    var_9 thread dofacialdialogue( var_1, var_18, var_22, level.scr_face[var_24][var_1] );

                thread maps\_anim::anim_facialanim( var_9, var_1, level.scr_face[var_24][var_1] );
            }
            else if ( isai( var_9 ) )
            {
                if ( var_20 )
                    var_9 animscripts\face::sayspecificdialogue( var_23, var_22, 1.0 );
                else
                {
                    var_9 thread maps\_anim::anim_facialfiller( "single dialogue" );
                    var_9 animscripts\face::sayspecificdialogue( var_23, var_22, 1.0, "single dialogue" );
                }
            }
            else
                var_9 thread maps\_utility::play_sound_on_entity( var_22, "single dialogue" );
        }

        if ( var_20 )
        {
            var_27 = getanimlength( level.scr_anim[var_24][var_1] );
            var_15 thread anim_end_early_deathnotify( var_9, var_1 );
            var_15 thread anim_end_early_animationendnotify( var_9, var_1, var_27, var_0[var_7][1] );
            var_16++;
            continue;
        }

        if ( var_18 )
        {
            var_15 thread anim_end_early_deathnotify( var_9, var_1 );
            var_15 thread anim_end_early_facialendnotify( var_9, var_1, var_23 );
            var_16++;
            continue;
        }

        if ( var_19 )
        {
            var_15 thread anim_end_early_deathnotify( var_9, var_1 );
            var_15 thread anim_end_early_dialogueendnotify( var_9, var_1 );
            var_16++;
        }
    }

    while ( var_16 > 0 )
    {
        var_15 waittill( var_1, var_9 );
        var_16--;

        if ( !isdefined( var_9 ) )
            continue;

        if ( isplayer( var_9 ) )
        {
            var_24 = var_9.animname;

            if ( isdefined( level.scr_anim[var_24][var_1] ) )
            {
                var_25 = level.scr_anim[var_24]["root"];
                var_9 setanim( var_25, 1, 0.2 );
                var_26 = level.scr_anim[var_24][var_1];
                var_9 clearanim( var_26, 0.2 );
            }
        }

        var_9._animactive--;
        var_9._lastanimtime = gettime();
    }

    self notify( var_1 );
}

anim_end_early_deathnotify( var_0, var_1 )
{
    var_0 endon( "kill_anim_end_notify_" + var_1 );
    var_0 waittill( "death" );
    self notify( var_1, var_0 );
    var_0 notify( "kill_anim_end_notify_" + var_1 );
}

anim_end_early_facialendnotify( var_0, var_1, var_2 )
{
    var_0 endon( "kill_anim_end_notify_" + var_1 );
    var_3 = getanimlength( var_2 );
    wait(var_3);
    self notify( var_1, var_0 );
    var_0 notify( "kill_anim_end_notify_" + var_1 );
}

anim_end_early_dialogueendnotify( var_0, var_1 )
{
    var_0 endon( "kill_anim_end_notify_" + var_1 );
    var_0 waittill( "single dialogue" );
    self notify( var_1, var_0 );
    var_0 notify( "kill_anim_end_notify_" + var_1 );
}

anim_end_early_animationendnotify( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "kill_anim_end_notify_" + var_1 );
    var_2 -= var_3;

    if ( var_3 > 0 && var_2 > 0 )
    {
        var_0 maps\_utility::waittill_match_or_timeout( "single anim", "end", var_2 );
        var_0 stopanimscripted();
    }
    else
        var_0 waittillmatch( "single anim", "end" );

    var_0 notify( "anim_ended" );
    self notify( var_1, var_0 );
    var_0 notify( "kill_anim_end_notify_" + var_1 );
}

dofacialdialogue( var_0, var_1, var_2, var_3 )
{
    if ( var_1 )
    {
        thread notify_facial_anim_end( var_0 );
        thread warn_facial_dialogue_unspoken( var_0 );
        thread warn_facial_dialogue_too_many( var_0 );
        var_4 = [];

        if ( !isarray( var_2 ) )
            var_4[0] = var_2;
        else
            var_4 = var_2;

        foreach ( var_6 in var_4 )
        {
            self waittillmatch( "face_done_" + var_0, "dialogue_line" );
            animscripts\face::sayspecificdialogue( undefined, var_6, 1.0 );
        }

        self notify( "all_facial_lines_done" );
    }
    else
        animscripts\face::sayspecificdialogue( undefined, var_2, 1.0, "single dialogue" );
}

notify_facial_anim_end( var_0 )
{
    self endon( "death" );
    self waittillmatch( "face_done_" + var_0, "end" );
    self notify( "facial_anim_end_" + var_0 );
}

warn_facial_dialogue_unspoken( var_0 )
{
    self endon( "death" );
    self endon( "all_facial_lines_done" );
    self waittill( "facial_anim_end_" + var_0 );
}

warn_facial_dialogue_too_many( var_0 )
{
    self endon( "death" );
    self endon( "facial_anim_end_" + var_0 );
    self waittill( "all_facial_lines_done" );
    self waittillmatch( "face_done_" + var_0, "dialogue_line" );
}
