// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

draw_point( var_0, var_1, var_2, var_3 )
{

}

draw_axis( var_0, var_1, var_2, var_3 )
{

}

draw_debug_sphere( var_0, var_1, var_2, var_3, var_4 )
{

}

create_debug_text_hud( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 2.0;

    if ( isdefined( var_5 ) )
        var_6 = var_5;

    var_7 = level.player maps\_hud_util::createclientfontstring( "default", var_6 );
    var_7.x = var_1;
    var_7.y = var_2;
    var_7.sort = 1;
    var_7.horzalign = "fullscreen";
    var_7.vertalign = "fullscreen";
    var_7.alpha = 1.0;

    if ( !isdefined( var_3 ) )
        var_3 = ( 1, 1, 1 );

    var_7.color = var_3;

    if ( isdefined( var_4 ) )
        var_7.label = var_4;

    level.debug_text_hud[var_0] = var_7;
}

print_debug_text_hud( var_0, var_1 )
{
    level.debug_text_hud[var_0] setvalue( var_1 );
}

print_debug_text_string_hud( var_0, var_1 )
{
    level.debug_text_hud[var_0] settext( var_1 );
}

change_debug_text_hud_color( var_0, var_1 )
{
    level.debug_text_hud[var_0].color = var_1;
}

delete_debug_text_hud( var_0 )
{
    level.debug_text_hud[var_0] destroy();
    level.debug_text_hud[var_0] = undefined;
}
