// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precacheshader( "black" );
    var_0 = 0;
    level thread game_messages();
    common_scripts\utility::flag_wait( "start_is_set" );

    if ( !isdefined( level.introscreen ) || !maps\_utility::is_default_start() || var_0 )
        maps\_utility::delaythread( 0.05, common_scripts\utility::flag_set, "introscreen_complete" );
    else
    {
        if ( isdefined( level.introscreen.customfunc ) )
        {
            [[ level.introscreen.customfunc ]]();
            return;
        }

        introscreen();
    }
}

introscreen_feed_lines()
{
    if ( !isdefined( level.introscreen ) )
        return 0;

    var_0 = level.introscreen.lines;
    var_1 = getarraykeys( var_0 );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];
        var_4 = 1;
        var_5 = var_2 * var_4 + 1;
        maps\_utility::delaythread( var_5, ::introscreen_corner_line, var_0[var_3], var_0.size - var_2 - 1, var_4, var_3 );
    }

    return 1;
}

introscreen_generic_black_fade_in( var_0, var_1, var_2 )
{
    introscreen_generic_fade_in( "black", var_0, var_1, var_2 );
}

introscreen_generic_fade_in( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1.5;

    if ( !isdefined( var_3 ) )
        maps\_hud_util::start_overlay( var_0 );
    else
        maps\_hud_util::fade_out( var_3, var_0 );

    wait(var_1);
    maps\_hud_util::fade_in( var_2, var_0 );
    wait(var_2);
    _func_0D3( "com_cinematicEndInWhite", 0 );
}

introscreen_corner_line( var_0, var_1, var_2, var_3 )
{
    level notify( "new_introscreen_element" );

    if ( !isdefined( level.intro_offset ) )
        level.intro_offset = 0;
    else
        level.intro_offset++;

    var_4 = cornerline_height();
    var_5 = newhudelem();
    var_5.x = 20;
    var_5.y = var_4;
    var_5.alignx = "left";
    var_5.aligny = "bottom";
    var_5.horzalign = "left";
    var_5.vertalign = "bottom";
    var_5.sort = 1;
    var_5.foreground = 1;
    var_5 settext( var_0 );
    var_5.alpha = 0;
    var_5 fadeovertime( 0.2 );
    var_5.alpha = 1;
    var_5.hidewheninmenu = 1;
    var_5.fontscale = 2.0;
    var_5.color = ( 0.8, 1, 0.8 );
    var_5.font = "default";
    var_5.glowcolor = ( 0.3, 0.6, 0.3 );
    var_5.glowalpha = 1;
    var_6 = int( var_1 * var_2 * 1000 + 4000 );
    var_5 setpulsefx( 30, var_6, 700 );
    thread hudelem_destroy( var_5 );
}

cornerline_height()
{
    return level.intro_offset * 20 - 82;
}

hudelem_destroy( var_0 )
{
    wait 16;
    var_0 notify( "destroying" );
    level.intro_offse = undefined;
    var_1 = 0.5;
    var_0 fadeovertime( var_1 );
    var_0.alpha = 0;
    wait(var_1);
    var_0 notify( "destroy" );
    var_0 destroy();
}

old_introscreen_default()
{
    level.player freezecontrols( 1 );
    thread introscreen_generic_black_fade_in( level.introscreen.completed_delay, level.introscreen.fade_out_time, level.introscreen.fade_in_time );

    if ( !introscreen_feed_lines() )
        wait 0.05;

    wait(level.introscreen.completed_delay);
    common_scripts\utility::flag_set( "introscreen_complete" );
    level.player freezecontrols( 0 );
}

center_screen_lines( var_0 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    var_1 = 3;
    var_2 = 1;
    var_3 = [];

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        var_3[var_3.size] = center_screen_line( var_0[var_4], var_4, var_1 + var_0.size - var_4 );
        wait 1;
    }

    wait(var_1);

    foreach ( var_6 in var_3 )
        var_6 thread maps\_hud_util::fade_over_time( 0, var_2 );

    wait(var_2);

    foreach ( var_6 in var_3 )
        var_6 destroy();
}

center_screen_line( var_0, var_1, var_2 )
{
    var_3 = newhudelem();
    var_3.alignx = "center";
    var_3.aligny = "top";
    var_3.horzalign = "center";
    var_3.vertalign = "middle";
    var_3.x = 0;
    var_3.font = "objective";
    var_3.foreground = 1;
    var_3.hidewheninmenu = 1;
    var_3.hidewhendead = 1;
    var_3.sort = 2;
    var_3.color = ( 0.99, 0.99, 0.88 );
    var_3.glowcolor = ( 0, 0, 0 );
    var_3.glowalpha = 1;
    var_4 = getdvarint( "loc_language", 0 );

    if ( var_4 != 16 )
        var_3 setpulsefx( 100, 900000, 700 );

    var_5 = -70;

    switch ( var_1 )
    {
        case 0:
            var_3.fontscale = 3;
            var_3.y = var_5;
            break;
        default:
            var_3.fontscale = 1.15;
            var_3.y = var_5 + 20 + 15 * var_1;
            break;
    }

    var_3.label = var_0;
    return var_3;
}

introscreen( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_0 = 0;
        var_2 = 1;
    }

    if ( isdefined( var_1 ) )
    {
        var_0 = 1;
        maps\_hud_util::start_overlay();
        level.player freezecontrols( 1 );
        level.player common_scripts\utility::delaycall( var_1, ::freezecontrols, 0 );
        maps\_utility::delaythread( var_1, maps\_hud_util::fade_in, 2 );
    }

    level.chyron = spawnstruct();
    level.chyron.huds = [];
    level.chyron.strips = [];
    level.chyron.last_strips = [];
    level.chyron.artifacts = [];
    level.chyron.text_x = 20;
    level.chyron.text_y = -82;
    level.chyron.text_incoming = 0;
    level.chyron.strips_disabled = 0;
    level.chyron.sound_org = spawn( "script_origin", level.player.origin );
    level.chyron.sound_org _meth_804D( level.player );
    level.chyron.no_bg = var_0;

    if ( !var_0 )
    {
        level.player freezecontrols( 1 );
        maps\_hud_util::start_overlay();
    }

    var_3 = 0.4;
    thread quick_cursor( 0, var_3 );
    wait(var_3);
    title_line( level.introscreen.lines[0] );
    sub_line( level.introscreen.lines[1], 0 );
    wait 2;
    var_4 = sub_line( level.introscreen.lines[2], 1, "default", 1, 1 );
    var_4.color = ( 0.87, 0.79, 0.45 );
    var_5 = undefined;

    if ( isdefined( level.introscreen.lines[3] ) )
    {
        var_5 = sub_line( level.introscreen.lines[3], 2, "default", 1, 1 );
        var_5.color = ( 0.87, 0.79, 0.45 );
        level.chyron.huds = common_scripts\utility::array_remove( level.chyron.huds, var_5 );
    }

    wait 1;
    level.chyron.strips_disabled = 1;
    wait 2;
    level.chyron.strips_disabled = 0;
    wait 1;
    faze_out( 0, 1 );

    if ( !var_0 )
    {
        chyron_sound( 0, "ui_chyron_off" );
        thread maps\_hud_util::fade_in( 2 );
        level.player freezecontrols( 0 );
    }

    common_scripts\utility::flag_set( "introscreen_complete" );
    level notify( "stop_chyron" );
    level.chyron.sound_org delete();
    level.chyron = undefined;
}

name_drift()
{
    var_0 = self.color;
    var_1 = self.alpha;
    self notify( "stop_quick_pulse" );
    var_2 = 2;
    self.glowalpha = 1;
    self.glowcolor = ( 1, 1, 1 );
    thread fade_glow( ( 0.10875, 0.09875, 0.05625 ), 0.1, var_2 );
    self.color = ( 1, 1, 1 );
    self.alpha = 1;
    self fadeovertime( var_2 );
    self.color = var_0;
    self.alpha = 0.8;
    var_2 = 4;
    self moveovertime( var_2 * 3 );
    self _meth_808B( var_2 * 1.5 );
    self.x += randomintrange( 5, 10 );
    self.y -= randomintrange( 3, 12 );
    self.fontscale *= randomfloatrange( 1.2, 1.3 );
    wait(var_2);
    self fadeovertime( 2 );
    self.alpha = 0;
    wait 2;
    self destroy();
}

fade_glow( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = var_2 * 20;
    var_4 = ( var_0 - self.glowcolor ) / var_3;
    var_5 = ( var_1 - self.glowalpha ) / var_3;

    for ( var_6 = 0; var_6 < var_3; var_6++ )
    {
        self.glowcolor += var_4;
        self.glowalpha += var_5;
        wait 0.05;
    }

    self.glowcolor = var_0;
    self.glowalpha = var_1;
}

chyron_sound( var_0, var_1 )
{
    if ( !soundexists( var_1 ) )
        return;

    if ( var_0 == 0 )
        level.chyron.sound_org playsound( var_1 );
    else
        level.game_messages.sound_org playsound( var_1 );
}

hud_destroy( var_0 )
{
    self endon( "death" );
    self fadeovertime( var_0 );
    self.alpha = 0;
    wait(var_0);
    self destroy();
}

quick_cursor( var_0, var_1 )
{
    wait 0.5;
    var_2 = newhudelem();

    if ( var_0 == 0 )
    {
        var_2.x = level.chyron.text_x - 5;
        var_2.y = level.chyron.text_y;
        var_2.vertalign = "bottom";
    }
    else
    {
        var_2.x = level.game_messages.text_x - 5;
        var_2.y = level.game_messages.text_y;
        var_2.vertalign = "top";
    }

    var_2.fontscale = 3;
    var_2.horzalign = "left";
    var_2.sort = 1;
    var_2.foreground = 1;
    var_2.hidewheninmenu = 1;
    var_2.alpha = 0.8;
    var_2 _meth_80CC( "white", 1, 35 );
    var_2.color = ( 0.87, 0.79, 0.45 );
    var_2 moveovertime( var_1 );
    var_2 fadeovertime( var_1 * 0.5 );
    var_2.alpha = 0;
    var_2.x += 300;
    wait 0.4;
    var_2 destroy();
}

artifacts( var_0 )
{
    if ( var_0 == 0 )
        level endon( "chyron_faze_out_text_intro" );
    else
        level endon( "chyron_faze_out_text_gamenotify" );

    var_1 = [ ".", "-", "_", "|", "+" ];
    var_2 = 0.7;

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_4 = create_chyron_text( "" );
        var_4.fontscale = var_2;
        var_4.alpha = 0;
        var_4.sort = 2;
        var_4.color = ( 0.75, 0.83, 0.89 );
        var_4.pulse = 0;
        level.chyron.artifacts[level.chyron.artifacts.size] = var_4;
    }

    level.chyron.artifacts_fade = 0;
    thread artifact_pulse( var_0 );
    var_5 = 0;
    var_6 = level.chyron.text_y - 10;

    for (;;)
    {
        var_7 = 0;
        var_1 = common_scripts\utility::array_randomize( var_1 );

        foreach ( var_4 in level.chyron.artifacts )
        {
            var_4.fontscale = var_2;

            if ( var_1[var_7] == "+" )
                var_4.fontscale = 0.55;

            var_4 settext( var_1[var_7] );
            var_4.x = var_5 + randomint( 200 );
            var_4.y = var_6 + randomint( 60 );
            var_4.pulse = 1;
            var_7++;
            wait(randomfloatrange( 0.05, 0.1 ));
        }

        wait(randomfloatrange( 4, 7 ));
        level.chyron.artifacts_fade = 1;
        level waittill( "chyron_artifact_faded" );
    }
}

artifact_pulse( var_0 )
{
    if ( var_0 == 0 )
        level endon( "chyron_faze_out_text_intro" );
    else
        level endon( "chyron_faze_out_text_gamenotify" );

    var_1 = 0.6;
    var_2 = 1;

    for (;;)
    {
        if ( level.chyron.artifacts_fade )
            var_1 -= 0.07;
        else
        {
            if ( var_1 < 0.15 || var_1 > 0.6 )
                var_2 *= -1;

            var_1 += ( 0.02 + randomfloat( 0.04 ) ) * var_2;
        }

        var_1 = max( var_1, 0 );

        foreach ( var_4 in level.chyron.artifacts )
        {
            if ( var_4.pulse )
            {
                if ( var_1 == 0 )
                {
                    var_4.alpha = 0;
                    continue;
                }

                var_4.alpha = randomfloatrange( var_1 * 0.6, var_1 );
            }
        }

        if ( var_1 == 0 )
        {
            level notify( "chyron_artifact_faded" );
            var_1 = 0.8;
            level.chyron.artifacts_fade = 0;

            foreach ( var_4 in level.chyron.artifacts )
                var_4.pulse = 0;
        }

        wait 0.05;
    }
}

strips( var_0 )
{
    if ( var_0 == 0 )
        level endon( "chyron_faze_out_text_intro" );
    else
        level endon( "chyron_faze_out_text_gamenotify" );

    var_1 = 5;
    var_2 = 0;
    var_3 = 1;

    for (;;)
    {
        if ( var_0 == 0 && level.chyron.strips_disabled || var_0 == 1 && level.game_messages.strips_disabled )
        {
            wait 0.05;
            continue;
        }

        var_2++;
        var_4 = int( min( var_2, var_1 ) );

        for ( var_5 = 0; var_5 < var_4; var_5++ )
        {
            thread create_strip( var_0 );
            wait(randomfloatrange( 0, 0.1 ));
        }

        if ( var_0 == 0 && level.chyron.text_incoming || var_0 == 1 && level.game_messages.text_incoming )
        {
            wait 0.05;
            continue;
        }

        wait(randomfloatrange( var_3 * 0.5, var_3 ));
        var_3 -= 0.05;
        var_3 = max( var_3, 0.2 );
    }
}

title_line( var_0, var_1 )
{
    var_2 = create_chyron_text( var_0 );
    level.chyron.text_incoming_x = var_2.x;
    level.chyron.text_incoming_y = var_2.y;
    level.chyron.text_incoming = 1;
    wait 0.5;
    level.chyron.text_incoming = 0;
    var_3 = dupe_hud( var_2, 1 );
    var_4 = 4;
    var_3[0] thread location_dupes_thread( var_4 );
    var_2.glowalpha = 0.05;
    var_2.glowcolor = ( 0.435, 0.395, 0.225 ) * glowcolor_mult();
    var_5 = 0.3;
    var_6 = 0.5;
    var_6 -= var_5;
    wait(var_5);
    var_2.alpha = 1;
    wait(var_6);
}

offset_thread( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = randomintrange( 1, 2 );

    for ( var_7 = 0; var_7 < var_6; var_7++ )
    {
        var_8 = randomintrange_limit( var_0, var_1, var_2 );
        var_9 = randomintrange_limit( var_3, var_4, var_5 );
        var_10[0] = [ var_8, var_9 ];
        var_10[1] = [ var_8 - 10, var_9 ];
        thread hud_offset( var_10 );
        wait(randomfloatrange( 0.5, 1 ));
    }
}

faze_out( var_0, var_1 )
{
    var_2 = undefined;

    if ( !var_1 )
    {
        var_2 = newhudelem();

        if ( var_0 == 0 )
        {
            var_2.x = level.chyron.text_x + 60;
            var_2.y = level.chyron.text_y + 30;
            var_2.vertalign = "bottom";
        }
        else
        {
            var_2.x = level.game_messages.text_x + 60;
            var_2.y = level.game_messages.text_y + 10;
            var_2.vertalign = "top";
        }

        var_2.alignx = "center";
        var_2.aligny = "middle";
        var_2.horzalign = "left";
        var_2.sort = 1;
        var_2.foreground = 1;
        var_2.hidewheninmenu = 1;
        var_2.alpha = 0;
        var_2 _meth_80CC( "white", 1, 60 );
        var_2.color = ( 0.87, 0.79, 0.45 );
        var_2 fadeovertime( 0.25 );
        var_2.alpha = 0.1;
        var_2 scaleovertime( 0.1, 2000, 60 );
    }

    wait 0.5;
    var_3 = 0.15;
    fade_out_text( var_0, var_3 );

    if ( !var_1 )
    {
        var_2 fadeovertime( 0.25 );
        var_2.alpha = 0.2;
        var_2.color = ( 1, 1, 1 );
        var_2 scaleovertime( var_3, 2000, 2 );
        wait(var_3);
        var_3 = 0.15;
        var_2 scaleovertime( var_3, 2, 2 );
        var_2 thread faze_out_finish( var_3 );
    }
    else
        wait(var_3);
}

faze_out_finish( var_0 )
{
    self fadeovertime( var_0 );
    self.alpha = 0;
    wait(var_0);
    self destroy();
}

fade_out_text( var_0, var_1 )
{
    if ( var_0 == 0 )
    {
        level notify( "chyron_faze_out_text_intro" );

        foreach ( var_3 in level.chyron.huds )
        {
            if ( !isdefined( var_3 ) )
                continue;

            var_3 thread hud_destroy( var_1 );
        }

        foreach ( var_3 in level.chyron.strips )
            var_3 thread hud_destroy( var_1 );
    }
    else
    {
        level notify( "chyron_faze_out_text_gamenotify" );

        foreach ( var_3 in level.game_messages.huds )
        {
            if ( !isdefined( var_3 ) )
                continue;

            var_3 thread hud_destroy( var_1 );
        }

        foreach ( var_3 in level.game_messages.strips )
            var_3 thread hud_destroy( var_1 );
    }
}

sub_line( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = create_chyron_text( var_0 );
    var_5.y += ( 20 + var_1 * 15 );

    if ( isdefined( var_2 ) )
        var_5.font = var_2;

    var_5.fontscale = 1;

    if ( isdefined( var_3 ) )
        var_5.fontscale = var_3;

    level.chyron.text_incoming_x = var_5.x;
    level.chyron.text_incoming_y = var_5.y;
    level.chyron.text_incoming = 1;
    wait 0.5;
    var_5.glowalpha = 0.05;
    var_5.glowcolor = ( 0.435, 0.395, 0.225 ) * glowcolor_mult();
    var_5.alpha = 1;

    if ( isdefined( var_4 ) )
        var_5.alpha = var_4;

    var_5 setpulsefx( 30, 50000, 700 );
    level.chyron.text_incoming = 0;
    return var_5;
}

glowcolor_mult()
{
    var_0 = 1;

    if ( isdefined( level.chyron ) && level.chyron.no_bg )
        var_0 = 0.3;

    return var_0;
}

hud_offset( var_0 )
{
    var_1 = self.x;
    var_2 = self.y;

    foreach ( var_4 in var_0 )
    {
        self.x = var_1 + var_4[0];
        self.y = var_2 + var_4[1];
        wait(randomfloatrange( 0.05, 0.2 ));
    }

    self.x = var_1;
    self.y = var_2;
}

quick_pulse( var_0, var_1 )
{
    self endon( "death" );
    self endon( "stop_quick_pulse" );

    if ( var_0 == 0 )
        level endon( "chyron_faze_out_text_intro" );
    else
        level endon( "chyron_faze_out_text_gamenotify" );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    for (;;)
    {
        wait 0.05;
        self.alpha = randomfloatrange( var_1 * 0.7, var_1 );
    }
}

location_dupes_thread( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    self endon( "death" );
    var_2 = self.x;
    var_3 = self.y;
    var_4 = 0.15;

    if ( !var_1 )
    {
        self.x += randomintrange( -30, -10 );
        self.y += randomintrange( 10, 20 );
        self moveovertime( var_4 );
        self.x = var_2;
        self.y = var_3;
        self fadeovertime( var_4 );
        self.alpha = 0.1;
        wait(var_4);
    }

    self moveovertime( var_0 );
    self.x += randomintrange( 15, 20 );
    self.y += randomintrange( -4, 4 );
    wait(var_0);
    var_4 = 0.05;
    self moveovertime( var_4 );
    self.x = var_2;
    self.y = var_3;
    wait(var_4);
    self fadeovertime( var_4 );
    self.alpha = 0;
}

randomintrange_limit( var_0, var_1, var_2 )
{
    var_3 = randomintrange( var_0, var_1 );
    var_4 = 1;

    if ( var_3 < 0 )
        var_4 = -1;

    var_3 = max( abs( var_3 ), var_2 );
    return var_3 * var_4;
}

create_chyron_text( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level.chyron.text_x;

    if ( !isdefined( var_2 ) )
        var_2 = level.chyron.text_y;

    var_3 = newhudelem();
    var_3.x = var_1;
    var_3.y = var_2;
    var_3.horzalign = "left";
    var_3.vertalign = "bottom";
    var_3.aligny = "bottom";
    var_3.sort = 3;
    var_3.foreground = 1;
    var_3 settext( var_0 );
    var_3.text = var_0;
    var_3.alpha = 0;
    var_3.hidewheninmenu = 1;
    var_3.fontscale = 1.4;

    if ( level.console )
        var_3.fontscale = 1.2;

    var_3.color = ( 0.87, 0.79, 0.45 );
    var_3.font = "default";

    if ( isdefined( level.chyron ) )
        level.chyron.huds[level.chyron.huds.size] = var_3;

    return var_3;
}

get_strip_settings( var_0 )
{
    var_1 = spawnstruct();
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    if ( var_0 == 0 )
    {
        var_5 = -85;
        var_2 = level.chyron.text_incoming;
        var_3 = level.chyron.text_incoming_x;
        var_4 = level.chyron.text_incoming_y;
    }
    else
    {
        var_5 = 0;
        var_2 = level.game_messages.text_incoming;
        var_3 = level.game_messages.text_incoming_x;
        var_4 = level.game_messages.text_incoming_y;
    }

    var_6 = 200;
    var_7 = 60;
    var_1.width = randomintrange( 20, var_6 );
    var_8 = [ 5, 10, 15 ];
    var_1.height = var_8[randomint( var_8.size )];
    var_1.x = randomintrange( 0, var_6 - var_1.width );
    var_1.y = var_5 + randomint( var_7 - var_1.height );
    var_1.alpha = randomfloatrange( 0.3, 0.7 );
    var_1.color = get_strip_color();
    var_1.time = randomfloatrange( 0.05, 0.1 );

    if ( var_2 )
    {
        var_1.x = int( var_3 + randomintrange( -1, 1 ) );
        var_1.y = int( var_4 + randomintrange( 0, 7 ) );
        var_1.width = randomintrange( 100, var_6 );
        var_1.height = randomintrange( 10, 15 );
        var_1.color = ( 0.87, 0.79, 0.45 ) * randomfloatrange( 0.2, 0.4 );
    }

    return var_1;
}

get_strip_color()
{
    var_0 = [];
    var_0[var_0.size] = ( 0.15, 0.14, 0.22 );
    var_0[var_0.size] = ( 0.09, 0.11, 0.13 );
    var_0[var_0.size] = ( 0.34, 0.22, 0.22 );
    var_0[var_0.size] = ( 0.29, 0.34, 0.22 );
    return var_0[randomint( var_0.size )];
}

create_strip( var_0 )
{
    if ( var_0 == 0 )
    {
        level endon( "chyron_faze_out_text_intro" );

        if ( level.chyron.strips.size < 8 )
        {
            var_1 = newhudelem();
            var_1.visible = 0;
            level.chyron.strips[level.chyron.strips.size] = var_1;
        }

        var_2 = undefined;

        foreach ( var_4 in level.chyron.strips )
        {
            if ( var_4.visible )
                continue;

            var_2 = var_4;
        }

        if ( !isdefined( var_2 ) )
            return;

        var_6 = get_strip_settings( var_0 );

        if ( !level.chyron.text_incoming )
        {
            if ( level.chyron.last_strips.size > 0 && level.chyron.last_strips.size < 3 && randomint( 100 ) > 10 )
            {
                var_7 = level.chyron.last_strips[level.chyron.last_strips.size - 1];
                var_6.x = var_7.x;
                var_6.y = var_7.y + var_7.height;

                if ( common_scripts\utility::cointoss() )
                    var_6.y = var_7.y - var_6.height;
            }
            else
                level.chyron.last_strips = [];

            level.chyron.last_strips[level.chyron.last_strips.size] = var_2;
        }
    }
    else
    {
        level endon( "chyron_faze_out_text_gamenotify" );

        if ( level.game_messages.strips.size < 8 )
        {
            var_1 = newhudelem();
            var_1.visible = 0;
            level.game_messages.strips[level.game_messages.strips.size] = var_1;
        }

        var_2 = undefined;

        foreach ( var_4 in level.game_messages.strips )
        {
            if ( var_4.visible )
                continue;

            var_2 = var_4;
        }

        if ( !isdefined( var_2 ) )
            return;

        var_6 = get_strip_settings( var_0 );

        if ( !level.game_messages.text_incoming )
        {
            if ( level.game_messages.last_strips.size > 0 && level.game_messages.last_strips.size < 3 && randomint( 100 ) > 10 )
            {
                var_7 = level.game_messages.last_strips[level.game_messages.last_strips.size - 1];
                var_6.x = var_7.x;
                var_6.y = var_7.y + var_7.height;

                if ( common_scripts\utility::cointoss() )
                    var_6.y = var_7.y - var_6.height;
            }
            else
                level.game_messages.last_strips = [];

            level.game_messages.last_strips[level.game_messages.last_strips.size] = var_2;
        }
    }

    var_2.x = var_6.x;
    var_2.y = var_6.y;
    var_2.width = var_6.width;
    var_2.height = var_6.height;
    var_2 _meth_80CC( "white", var_6.width, var_6.height );
    var_2.alpha = var_6.alpha;
    var_2.color = var_6.color;
    var_2.horzalign = "left";
    var_2.vertalign = "bottom";

    if ( var_0 == 1 )
        var_2.vertalign = "top";

    var_2.sort = 1;
    var_2.foreground = 1;
    var_2.hidewheninmenu = 1;
    var_2.visible = 1;
    wait(var_6.time);
    var_2.alpha = 0;
    var_2.visible = 0;
}

dupe_hud( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1; var_3++ )
        var_2[var_2.size] = create_chyron_text( var_0.text );

    return var_2;
}

game_messages()
{
    level.game_messages = spawnstruct();
    level.game_messages.active = 0;
    level.game_messages.text_list = [];
    level thread game_message_listen( "chyron_message1" );
    level thread game_message_listen( "chyron_message2" );
    level thread game_message_listen( "chyron_message3" );
}

game_message_listen( var_0 )
{
    for (;;)
    {
        level waittill( var_0, var_1, var_2 );
        game_message_append( var_1 );
    }
}

game_message_append( var_0 )
{
    level.game_messages.text_list[level.game_messages.text_list.size] = var_0;

    if ( !level.game_messages.active )
        level thread game_messages_process();
}

game_messages_startup()
{
    level.game_messages.active = 1;
    level.game_messages.text_incoming = 0;
    level.game_messages.strips_disabled = 1;
    level.game_messages.text_x = 6;
    level.game_messages.text_y = 10;
    level.game_messages.huds = [];
    level.game_messages.strips = [];
    level.game_messages.last_strips = [];
    level.game_messages.artifacts = [];
    level.game_messages.sound_org = spawn( "script_origin", level.player.origin );
    level.game_messages.sound_org _meth_804D( level.player );
}

game_messages_shutdown()
{
    level.game_messages.sound_org delete();
    level.game_messages = spawnstruct();
    level.game_messages.active = 0;
    level.game_messages.text_list = [];
}

game_messages_process()
{
    game_messages_startup();
    chyron_sound( 1, "ui_chyron_on" );

    for ( var_0 = 0; level.game_messages.text_list.size; level.game_messages.text_list = maps\_utility::array_remove_index( level.game_messages.text_list, 0 ) )
    {
        level thread game_message_display( level.game_messages.text_list[0], var_0 );
        var_0++;
        wait 0.5;
    }

    chyron_sound( 1, "ui_chyron_off" );
    faze_out( 1, 1 );

    if ( level.game_messages.text_list.size )
    {
        level.game_messages.sound_org delete();
        thread game_messages_process();
        return;
    }

    game_messages_shutdown();
}

game_message_display( var_0, var_1 )
{
    var_2 = create_gamemessage_text( var_0, var_1 );
    level.game_messages.text_incoming_x = var_2.x;
    level.game_messages.text_incoming_y = var_2.y;
    level.game_messages.text_incoming = 1;
    var_2.alpha = 1;
}

create_gamemessage_text( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = level.game_messages.text_x;
    var_2.y = level.game_messages.text_y + var_1 * 20;
    var_2.horzalign = "left";
    var_2.vertalign = "top";
    var_2.sort = 3;
    var_2.foreground = 1;
    var_2 settext( var_0 );
    var_2.text = var_0;
    var_2.alpha = 0;
    var_2.hidewheninmenu = 1;
    var_2.font = "default";
    var_2.fontscale = 1.25;

    if ( level.console )
        var_2.fontscale = 1;

    var_2.color = ( 0.87, 0.79, 0.45 );
    var_2.glowalpha = 0;
    level.game_messages.huds[level.game_messages.huds.size] = var_2;
    return var_2;
}

stylized_line( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = create_chyron_text( var_0, var_2, var_3 );
    var_7.fontscale = 2;
    var_7.horzalign = "subleft";
    var_7.vertalign = "subtop";
    var_7.aligny = "middle";
    var_7.alignx = "center";
    var_7.alpha = 1;
    var_7.sort = 3;

    if ( isdefined( var_5 ) )
        var_7.glowcolor = var_5;

    if ( !isdefined( var_6 ) )
        var_6 = 20;

    var_7 setpulsefx( var_6, 50000, 700 );
    var_8 = [ var_7 ];
    var_9 = dupe_style_hud( var_7, 2 );

    foreach ( var_11 in var_9 )
    {
        var_11.alpha = 0;
        var_11 thread hud_alpha( randomfloatrange( 0.5, 1.5 ), randomfloatrange( 0.05, 0.2 ), var_1 - 0.5 );
    }

    var_8 = common_scripts\utility::array_combine( var_9, var_8 );
    return var_8;
}

hud_alpha( var_0, var_1, var_2 )
{
    wait(var_0);
    self.alpha = var_1;
    thread location_dupes_thread( var_2 - 0.5, 1 );
}

dupe_style_hud( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        var_4 = newhudelem();
        var_4.x = var_0.x;
        var_4.y = var_0.y;
        var_4.alpha = var_0.alpha;
        var_4.aligny = var_0.aligny;
        var_4.alignx = var_0.alignx;
        var_4.horzalign = var_0.horzalign;
        var_4.vertalign = var_0.vertalign;
        var_4.foreground = var_0.foreground;
        var_4.hidewheninmenu = var_0.hidewheninmenu;
        var_4.fontscale = var_0.fontscale;
        var_4.sort = var_0.sort;
        var_4.color = var_0.color;
        var_4 settext( var_0.text );
        var_2[var_2.size] = var_4;
    }

    return var_2;
}

stylized_fadeout( var_0, var_1, var_2, var_3 )
{
    var_4 = newhudelem();
    var_4.x = var_1;
    var_4.y = var_2 + ( var_3 - 1 ) * 10;
    var_4.alignx = "center";
    var_4.aligny = "middle";
    var_4.horzalign = "subleft";
    var_4.vertalign = "subtop";
    var_4.sort = 1;
    var_4.foreground = 1;
    var_4.hidewheninmenu = 1;
    var_4.alpha = 0;
    var_5 = var_3 * 40 + 20;
    var_4 _meth_80CC( "white", 1, var_5 );
    var_4.color = ( 0.87, 0.79, 0.45 );
    var_4 fadeovertime( 0.25 );
    var_4.alpha = 0.1;
    var_4 scaleovertime( 0.1, 2000, var_5 );
    wait 0.1;
    common_scripts\utility::array_thread( var_0, ::hud_destroy, 0.1 );
    var_6 = 0.15;
    var_4 fadeovertime( 0.25 );
    var_4.alpha = 0.2;
    var_4.color = ( 1, 1, 1 );
    var_4 scaleovertime( var_6, 2000, 2 );
    wait(var_6);
    var_4 scaleovertime( var_6, 2, 2 );
    var_4 fadeovertime( var_6 );
    var_4.alpha = 0;
    wait(var_6);
    var_4 destroy();
}
