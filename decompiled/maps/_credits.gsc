// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

initcredits( var_0 )
{
    common_scripts\utility::flag_init( "atvi_credits_go" );
    level.linesize = 1.35;
    level.headingsize = 1.75;
    level.linelist = [];
    level.credits_speed = 20.25;
    level.credits_spacing = -120;
    maps\_utility::set_console_status();

    if ( !isdefined( var_0 ) )
        var_0 = "all";

    switch ( var_0 )
    {
        case "iw":
            maps\_credits_autogen::initiw6credits();
            break;
        case "atvi":
            break;
        case "all":
            maps\_credits_autogen::initiw6credits();
            break;
    }

    end_logos();
}

addlefttitle( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "lefttitle";
    var_2.title = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addleftname( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "leftname";
    var_2.name = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addsublefttitle( var_0, var_1 )
{
    addleftname( var_0, var_1 );
}

addsubleftname( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "subleftname";
    var_2.name = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addrighttitle( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "righttitle";
    var_2.title = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addrightname( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "rightname";
    var_2.name = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addcenterheading( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "centerheading";
    var_2.heading = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addcentersubtitle( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "centersubtitle";
    var_2.heading = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addcastname( var_0, var_1, var_2 )
{
    precachestring( var_1 );
    precachestring( var_0 );

    if ( !isdefined( var_2 ) )
        var_2 = level.linesize;

    var_3 = spawnstruct();
    var_3.type = "castname";
    var_3.title = var_1;
    var_3.name = var_0;
    var_3.textscale = var_2;
    level.linelist[level.linelist.size] = var_3;
}

addcentername( var_0, var_1 )
{
    precachestring( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = level.linesize;

    var_2 = spawnstruct();
    var_2.type = "centername";
    var_2.name = var_0;
    var_2.textscale = var_1;
    level.linelist[level.linelist.size] = var_2;
}

addcenternamedouble( var_0, var_1, var_2 )
{
    precachestring( var_0 );
    precachestring( var_1 );

    if ( !isdefined( var_2 ) )
        var_2 = level.linesize;

    var_3 = spawnstruct();
    var_3.type = "centernamedouble";
    var_3.name1 = var_0;
    var_3.name2 = var_1;
    var_3.textscale = var_2;
    level.linelist[level.linelist.size] = var_3;
}

addcenterdual( var_0, var_1, var_2 )
{
    precachestring( var_0 );
    precachestring( var_1 );

    if ( !isdefined( var_2 ) )
        var_2 = level.linesize;

    var_3 = spawnstruct();
    var_3.type = "centerdual";
    var_3.title = var_0;
    var_3.name = var_1;
    var_3.textscale = var_2;
    level.linelist[level.linelist.size] = var_3;
}

addcentertriple( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.type = "centertriple";

    if ( isdefined( var_0 ) )
    {
        precachestring( var_0 );
        var_4.name1 = var_0;
    }
    else
        var_4.name1 = "";

    if ( isdefined( var_1 ) )
    {
        precachestring( var_1 );
        var_4.name2 = var_1;
    }
    else
        var_4.name2 = "";

    if ( isdefined( var_2 ) )
    {
        precachestring( var_2 );
        var_4.name3 = var_2;
    }
    else
        var_4.name3 = "";

    if ( !isdefined( var_3 ) )
        var_3 = level.linesize;

    var_4.textscale = var_3;
    level.linelist[level.linelist.size] = var_4;
}

addspace()
{
    var_0 = spawnstruct();
    var_0.type = "space";
    level.linelist[level.linelist.size] = var_0;
}

addspacesmall()
{
    var_0 = spawnstruct();
    var_0.type = "spacesmall";
    level.linelist[level.linelist.size] = var_0;
}

addcenterimage( var_0, var_1, var_2, var_3 )
{
    precacheshader( var_0 );
    var_4 = spawnstruct();
    var_4.type = "centerimage";
    var_4.image = var_0;
    var_4.width = var_1;
    var_4.height = var_2;
    var_4.sort = 2;

    if ( isdefined( var_3 ) )
        var_4.delay = var_3;

    level.linelist[level.linelist.size] = var_4;
}

playcredits()
{
    level.player endon( "stop_credits" );
    visionsetnaked( "", 0 );
    setsaveddvar( "cl_disable_pause", "1" );
    var_0 = "credits_black";
    soundscripts\_snd::snd_message( "play_credits" );
    var_1 = getdvarint( "loc_language", 0 );
    var_2 = 1.0;

    if ( var_1 == 10 || var_1 == 5 )
        var_2 = 0.75;

    for ( var_3 = 0; var_3 < level.linelist.size; var_3++ )
    {
        var_4 = 0.5;
        var_5 = level.linelist[var_3].type;

        if ( var_5 == "centerimage" )
        {
            if ( isdefined( var_0 ) && var_0 != "credits_black" )
                common_scripts\utility::flag_wait( "atvi_credits_go" );

            var_6 = level.linelist[var_3].image;
            var_7 = level.linelist[var_3].width;
            var_8 = level.linelist[var_3].height;
            var_9 = newhudelem();
            var_9 setshader( var_6, var_7, var_8 );
            var_9.alignx = "center";
            var_9.horzalign = "center";
            var_9.x = 0;
            var_9.y = 480;
            var_9.sort = 2;
            var_9.foreground = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;

            if ( isdefined( level.linelist[var_3].delay ) )
                var_4 = level.linelist[var_3].delay;
            else
                var_4 = 0.037 * var_8;
        }
        else if ( var_5 == "leftimage" )
        {
            var_6 = level.linelist[var_3].image;
            var_7 = level.linelist[var_3].width;
            var_8 = level.linelist[var_3].height;
            var_9 = newhudelem();
            var_9 setshader( var_6, var_7, var_8 );
            var_9.alignx = "center";
            var_9.horzalign = "left";
            var_9.x = 128;
            var_9.y = 480;
            var_9.sort = 2;
            var_9.foreground = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;
            var_4 = 0.037 * var_8;
        }
        else if ( var_5 == "lefttitle" )
        {
            var_10 = level.linelist[var_3].title;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_9 = newhudelem();
            var_9 settext( var_10 );
            var_9.alignx = "left";
            var_9.horzalign = "left";
            var_9.x = 28;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "default";
            else
                var_9.font = "small";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;
            var_9 thread pulse_fx();
        }
        else if ( var_5 == "leftname" )
        {
            var_12 = level.linelist[var_3].name;
            var_11 = level.linelist[var_3].textscale * var_2;

            if ( var_1 == 10 || var_1 == 5 )
                var_11 *= 0.5;

            var_9 = newhudelem();
            var_9 settext( var_12 );
            var_9.alignx = "left";
            var_9.horzalign = "left";
            var_9.x = 60;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "default";
            else
                var_9.font = "small";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;
            var_9 thread pulse_fx();
        }
        else if ( var_5 == "castname" )
        {
            var_10 = level.linelist[var_3].title;
            var_12 = level.linelist[var_3].name;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_13 = newhudelem();
            var_13 settext( var_10 );
            var_13.alignx = "left";
            var_13.horzalign = "left";
            var_13.x = 60;
            var_13.y = 480;

            if ( !level.console )
                var_13.font = "default";
            else
                var_13.font = "small";

            var_13.fontscale = var_11;
            var_13.sort = 2;
            var_13.glowcolor = ( 0.8, 0.8, 0.8 );
            var_13.glowalpha = 1;
            var_14 = newhudelem();
            var_14 settext( var_12 );
            var_14.alignx = "right";
            var_14.horzalign = "left";
            var_14.x = 275;
            var_14.y = 480;

            if ( !level.console )
                var_14.font = "default";
            else
                var_14.font = "small";

            var_14.fontscale = var_11;
            var_14.sort = 2;
            var_14.glowcolor = ( 0.8, 0.8, 0.8 );
            var_14.glowalpha = 1;
            var_13 thread delaydestroy( level.credits_speed );
            var_13 moveovertime( level.credits_speed );
            var_13.y = level.credits_spacing;
            var_14 thread delaydestroy( level.credits_speed );
            var_14 moveovertime( level.credits_speed );
            var_14.y = level.credits_spacing;
            var_13 thread pulse_fx();
            var_14 thread pulse_fx();
        }
        else if ( var_5 == "subleftname" )
        {
            var_12 = level.linelist[var_3].name;
            var_11 = level.linelist[var_3].textscale * var_2;

            if ( var_1 == 10 || var_1 == 5 )
                var_11 *= 0.5;

            var_9 = newhudelem();
            var_9 settext( var_12 );
            var_9.alignx = "left";
            var_9.horzalign = "left";
            var_9.x = 92;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "default";
            else
                var_9.font = "small";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;
            var_9 thread pulse_fx();
        }
        else if ( var_5 == "righttitle" )
        {
            var_10 = level.linelist[var_3].title;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_9 = newhudelem();
            var_9 settext( var_10 );
            var_9.alignx = "left";
            var_9.horzalign = "right";
            var_9.x = -132;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "default";
            else
                var_9.font = "small";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;
        }
        else if ( var_5 == "rightname" )
        {
            var_12 = level.linelist[var_3].name;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_9 = newhudelem();
            var_9 settext( var_12 );
            var_9.alignx = "left";
            var_9.horzalign = "right";
            var_9.x = -100;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "default";
            else
                var_9.font = "small";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;
        }
        else if ( var_5 == "centerheading" )
        {
            var_15 = level.linelist[var_3].heading;
            var_11 = level.linelist[var_3].textscale * 1.2 * var_2;
            var_9 = newhudelem();
            var_9 settext( var_15 );
            var_9.alignx = "center";
            var_9.horzalign = "center";
            var_9.x = 0;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "objective";
            else
                var_9.font = "objective";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.color = ( 1, 0.93, 0.44 );
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 0.5;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9 thread delayfade( level.credits_speed );
            var_9.y = level.credits_spacing;
            var_4 *= 1.2;
        }
        else if ( var_5 == "centersubtitle" )
        {
            var_15 = level.linelist[var_3].heading;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_9 = newhudelem();
            var_9 settext( var_15 );
            var_9.alignx = "center";
            var_9.horzalign = "center";
            var_9.x = 0;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "big";
            else
                var_9.font = "big";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.color = ( 1, 0.93, 0.44 );
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 0.5;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9 thread delayfade( level.credits_speed );
            var_9.y = level.credits_spacing;
            var_4 *= 1.1;
        }
        else if ( var_5 == "centerdual" )
        {
            var_10 = level.linelist[var_3].title;
            var_12 = level.linelist[var_3].name;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_13 = newhudelem();
            var_13 settext( var_10 );
            var_13.alignx = "right";
            var_13.horzalign = "center";
            var_13.x = -4;
            var_13.y = 480;

            if ( !level.console )
                var_13.font = "small";
            else
                var_13.font = "small";

            var_13.fontscale = var_11;
            var_13.sort = 2;
            var_13.glowcolor = ( 0.6, 0.6, 0.6 );
            var_13.glowalpha = 0;
            var_14 = newhudelem();
            var_14 settext( var_12 );
            var_14.alignx = "left";
            var_14.horzalign = "center";
            var_14.x = 4;
            var_14.y = 480;

            if ( !level.console )
                var_14.font = "small";
            else
                var_14.font = "small";

            var_14.fontscale = var_11;
            var_14.sort = 2;
            var_14.glowcolor = ( 0.6, 0.6, 0.6 );
            var_14.glowalpha = 0;
            var_13 thread delaydestroy( level.credits_speed );
            var_13 moveovertime( level.credits_speed );
            var_13 thread delayfade( level.credits_speed - 0.3 );
            var_13.y = level.credits_spacing;
            var_14 thread delaydestroy( level.credits_speed );
            var_14 moveovertime( level.credits_speed );
            var_14 thread delayfade( level.credits_speed );
            var_14.y = level.credits_spacing;
        }
        else if ( var_5 == "centertriple" )
        {
            var_16 = level.linelist[var_3].name1;
            var_17 = level.linelist[var_3].name2;
            var_18 = level.linelist[var_3].name3;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_13 = newhudelem();
            var_13 settext( var_16 );
            var_13.alignx = "left";
            var_13.horzalign = "center";
            var_13.x = -220;
            var_13.y = 480;

            if ( !level.console )
                var_13.font = "small";
            else
                var_13.font = "small";

            var_13.fontscale = var_11;
            var_13.sort = 2;
            var_13.glowcolor = ( 0.6, 0.6, 0.6 );
            var_13.glowalpha = 0;
            var_14 = newhudelem();
            var_14 settext( var_17 );
            var_14.alignx = "center";
            var_14.horzalign = "center";
            var_14.x = 0;
            var_14.y = 480;

            if ( !level.console )
                var_14.font = "small";
            else
                var_14.font = "small";

            var_14.fontscale = var_11;
            var_14.sort = 2;
            var_14.glowcolor = ( 0.6, 0.6, 0.6 );
            var_14.glowalpha = 0;
            var_19 = newhudelem();
            var_19 settext( var_18 );
            var_19.alignx = "right";
            var_19.horzalign = "center";
            var_19.x = 220;
            var_19.y = 480;

            if ( !level.console )
                var_19.font = "small";
            else
                var_19.font = "small";

            var_19.fontscale = var_11;
            var_19.sort = 2;
            var_19.glowcolor = ( 0.6, 0.6, 0.6 );
            var_19.glowalpha = 0;
            var_13 thread delaydestroy( level.credits_speed );
            var_13 moveovertime( level.credits_speed );
            var_13 thread delayfade( level.credits_speed - 0.4 );
            var_13.y = level.credits_spacing;
            var_14 thread delaydestroy( level.credits_speed );
            var_14 moveovertime( level.credits_speed );
            var_14 thread delayfade( level.credits_speed - 0.2 );
            var_14.y = level.credits_spacing;
            var_19 thread delaydestroy( level.credits_speed );
            var_19 moveovertime( level.credits_speed );
            var_19 thread delayfade( level.credits_speed );
            var_19.y = level.credits_spacing;
        }
        else if ( var_5 == "centername" )
        {
            var_12 = level.linelist[var_3].name;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_9 = newhudelem();
            var_9 settext( var_12 );
            var_9.alignx = "left";
            var_9.horzalign = "center";
            var_9.x = 8;
            var_9.y = 480;

            if ( !level.console )
                var_9.font = "default";
            else
                var_9.font = "small";

            var_9.fontscale = var_11;
            var_9.sort = 2;
            var_9.glowcolor = ( 0.8, 0.8, 0.8 );
            var_9.glowalpha = 1;
            var_9 thread delaydestroy( level.credits_speed );
            var_9 moveovertime( level.credits_speed );
            var_9.y = level.credits_spacing;
        }
        else if ( var_5 == "centernamedouble" )
        {
            var_16 = level.linelist[var_3].name1;
            var_17 = level.linelist[var_3].name2;
            var_11 = level.linelist[var_3].textscale * var_2;
            var_13 = newhudelem();
            var_13 settext( var_16 );
            var_13.alignx = "center";
            var_13.horzalign = "center";
            var_13.x = -80;
            var_13.y = 480;

            if ( !level.console )
                var_13.font = "default";
            else
                var_13.font = "small";

            var_13.fontscale = var_11;
            var_13.sort = 2;
            var_13.glowcolor = ( 0.8, 0.8, 0.8 );
            var_13.glowalpha = 1;
            var_14 = newhudelem();
            var_14 settext( var_17 );
            var_14.alignx = "center";
            var_14.horzalign = "center";
            var_14.x = 80;
            var_14.y = 480;

            if ( !level.console )
                var_14.font = "default";
            else
                var_14.font = "small";

            var_14.fontscale = var_11;
            var_14.sort = 2;
            var_14.glowcolor = ( 0.8, 0.8, 0.8 );
            var_14.glowalpha = 1;
            var_13 thread delaydestroy( level.credits_speed );
            var_13 moveovertime( level.credits_speed );
            var_13.y = level.credits_spacing;
            var_14 thread delaydestroy( level.credits_speed );
            var_14 moveovertime( level.credits_speed );
            var_14.y = level.credits_spacing;
        }
        else if ( var_5 == "spacesmall" )
            var_4 = 0.25;
        else
        {

        }

        wait(var_4 * level.credits_speed / 22.5);
    }

    wait 15;
    fade_out_level();
}

delayfade( var_0 )
{
    wait(var_0 - 7);
    self fadeovertime( 1.5 );
    self.alpha = 0;
}

delaydestroy( var_0 )
{
    wait(var_0 - 2);
    self destroy();
}

pulse_fx()
{
    self.alpha = 0;
    wait(level.credits_speed * 0.08);
    self fadeovertime( 0.2 );
    self.alpha = 1;
    self setpulsefx( 50, int( level.credits_speed * 0.6 * 1000 ), 500 );
}

addgap()
{
    addspace();
    addspace();
}

readncolumns( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    for ( var_5 = 0; var_5 < var_3; var_5++ )
        var_4[var_5] = tablelookupbyrow( var_0, var_1, var_2 + var_5 );

    return var_4;
}

readtriple( var_0, var_1, var_2 )
{
    var_3[0] = tablelookupbyrow( var_0, var_1, var_2 );
    var_3[1] = tablelookupbyrow( var_0, var_1, var_2 + 1 );
    var_3[2] = tablelookupbyrow( var_0, var_1, var_2 + 2 );
    return var_3;
}

allow_early_back_out()
{
    level.player notifyonplayercommand( "stop_credits_pressed", "+stance" );

    if ( !level.player common_scripts\utility::is_player_gamepad_enabled() )
        level.player notifyonplayercommand( "stop_credits_pressed", "+gostand" );

    level.player notifyonplayercommand( "show_skip_prompt", "+activate" );
    level.player notifyonplayercommand( "show_skip_prompt", "+gostand" );
    level.player notifyonplayercommand( "show_skip_prompt", "weapnext" );
    level.player notifyonplayercommand( "show_skip_prompt", "+stance" );
    level.player notifyonplayercommand( "show_skip_prompt", "+melee" );
    level.player notifyonplayercommand( "show_skip_prompt", "+sprint" );
    level.player notifyonplayercommand( "show_skip_prompt", "+attack" );
    level.player notifyonplayercommand( "show_skip_prompt", "+frag" );
    level.player notifyonplayercommand( "show_skip_prompt", "+speed_throw" );
    level.player notifyonplayercommand( "show_skip_prompt", "+toggleads_throw" );
    level.player notifyonplayercommand( "show_skip_prompt", "+smoke" );
    level.player notifyonplayercommand( "show_skip_prompt", "pause" );
    level.player notifyonplayercommand( "show_skip_prompt", "+actionslot 1" );
    level.player notifyonplayercommand( "show_skip_prompt", "+actionslot 2" );
    level.player notifyonplayercommand( "show_skip_prompt", "+actionslot 3" );
    level.player notifyonplayercommand( "show_skip_prompt", "+actionslot 4" );

    for (;;)
    {
        level.player waittill( "show_skip_prompt" );
        var_0 = get_stop_credits_button();
        var_0 thread pulse_button_timeout();
        thread end_credits_with_next_press();
        level waittill( "pulse_button_timed_out" );
        var_0 destroy();
    }
}

get_stop_credits_button()
{
    var_0 = newclienthudelem( level.player );
    var_0.x = -20;
    var_0.y = -20;
    var_0.alignx = "right";
    var_0.aligny = "bottom";
    var_0.horzalign = "right";
    var_0.vertalign = "bottom";
    var_0.fontscale = 2;

    if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        var_0 settext( &"CREDITS_UI_SKIP" );
    else
        var_0 settext( &"CREDITS_UI_SKIP_PC" );

    var_0.alpha = 0;
    var_0.foreground = 1;
    var_0.sort = 10;
    var_0.font = "objective";
    return var_0;
}

pulse_button_timeout()
{
    for ( var_0 = 0; var_0 < 5; var_0++ )
    {
        self fadeovertime( 0.8 );
        self.alpha = 1;
        wait 1;

        if ( var_0 == 4 )
            break;

        self fadeovertime( 0.8 );
        self.alpha = 0.5;
        wait 1;
    }

    self fadeovertime( 0.8 );
    self.alpha = 0;
    wait 1;
    level notify( "pulse_button_timed_out" );
}

end_credits_with_next_press()
{
    level endon( "pulse_button_timed_out" );
    wait 0.25;
    level.player waittill( "stop_credits_pressed" );
    level.player notify( "stop_credits" );
}

fade_out_level()
{
    var_0 = maps\_hud_util::create_client_overlay( "black", 0, level.player );
    var_0.sort = 100;
    var_0 fadeovertime( 1 );
    var_0.alpha = 1;
}

end_logos()
{
    addcenterimage( "dolby_havok_logos_01", 384, 48, 3.875 );
}
