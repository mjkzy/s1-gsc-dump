// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( getdvar( "scr_elevator_disabled" ) == "1" )
        return;

    var_0 = getentarray( "elevator_group", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !var_0.size )
        return;

    precachestring( &"ELEVATOR_CALL_HINT" );
    precachestring( &"ELEVATOR_USE_HINT" );
    precachestring( &"ELEVATOR_FLOOR_SELECT_HINT" );
    precachemenu( "elevator_floor_selector" );
    thread _id_3057();
    level._id_305A = [];
    level._id_3032 = _id_303C( "scr_elevator_callbutton_link_v", "96" );
    level._id_3031 = _id_303C( "scr_elevator_callbutton_link_h", "256" );
    _id_184A();
    _id_6E59();
    _id_3030();

    if ( !level._id_305A.size )
        return;

    foreach ( var_2 in level._id_305A )
    {
        var_2 thread _id_3054();
        var_2 thread _id_3050();
    }

    thread _id_3035();
}

_id_3057()
{
    for (;;)
    {
        level._id_3029 = _id_303B( "scr_elevator_accel", "0.2" );
        level._id_3036 = _id_303B( "scr_elevator_decel", "0.2" );
        level._id_3043 = _id_303C( "scr_elevator_music", "1" );
        level._id_3051 = _id_303C( "scr_elevator_speed", "96" );
        level._id_303D = _id_303C( "scr_elevator_innerdoorspeed", "14" );
        level._id_3045 = _id_303C( "scr_elevator_outterdoorspeed", "16" );
        level._id_304A = _id_303C( "scr_elevator_return", "0" );
        level._id_3058 = _id_303C( "scr_elevator_waittime", "6" );
        level._id_302A = _id_303C( "scr_elevator_aggressive_call", "0" );
        level._id_3035 = _id_303C( "debug_elevator", "0" );

        if ( common_scripts\utility::issp() )
            level._id_3041 = _id_303C( "scr_elevator_motion_detection", "0" );
        else
            level._id_3041 = _id_303C( "scr_elevator_motion_detection", "1" );

        wait 1;
    }
}

_id_3054()
{
    _id_303A( "[A]" );
}

_id_3030()
{
    foreach ( var_1 in level._id_3033 )
        var_1 thread _id_5D69();
}

_id_38F3( var_0 )
{
    self endon( "elevator_moving" );
    self._id_38F3 = 0;
    self._id_6627 = undefined;

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );
        self._id_38F3 = 1;
        self._id_6627 = var_1;
        break;
    }

    self notify( "floor_override" );
}

_id_303A( var_0 )
{
    self._id_3385 = var_0;
    var_1 = _id_3D96();
    var_2 = _id_3D97();

    for (;;)
    {
        if ( self._id_3385 == "[A]" )
        {
            if ( level._id_304A && _id_3D1D() != _id_3DAA() )
            {
                self._id_5F8E = _id_3DAA();
                thread _id_38F3( var_2 );
                _id_A09E( "floor_override", level._id_3058 );

                if ( self._id_38F3 && isdefined( self._id_6627 ) && isplayer( self._id_6627 ) )
                    _id_3D71( self._id_6627 );

                self._id_3385 = "[B]";
                continue;
            }

            for (;;)
            {
                if ( self._id_5F8E == _id_3D1D() )
                    var_3 = var_2 _id_2B3A( "trigger" );
                else
                    var_3 = "elevator_called";

                if ( isstring( var_3 ) && var_3 == "elevator_called" && self._id_5F8E != _id_3D1D() )
                {
                    self._id_3385 = "[B]";
                    break;
                }

                if ( isdefined( var_3 ) && isplayer( var_3 ) && isalive( var_3 ) )
                {
                    var_4 = var_3 istouching( var_2 );
                    var_5 = isdefined( var_2._id_5EF1 ) && var_3 istouching( var_2._id_5EF1 );
                    var_6 = var_4 || var_5;

                    if ( var_6 )
                    {
                        var_7 = var_3;
                        _id_3D71( var_7 );

                        if ( self._id_5F8E == _id_3D1D() )
                            continue;

                        self._id_3385 = "[B]";
                        break;
                    }
                }
            }
        }

        if ( self._id_3385 == "[B]" )
        {
            thread _id_303E( var_1 );
            var_8 = _id_3D1D();
            thread _id_1FD0();
            thread _id_1FD3( var_8 );
            common_scripts\utility::waittill_any( "closed_inner_doors", "interrupted" );

            if ( self._id_303F )
            {
                self._id_3385 = "[C]";
                continue;
            }

            self._id_3385 = "[D]";
            continue;
        }

        if ( self._id_3385 == "[C]" )
        {
            var_8 = _id_3D1D();
            thread _id_6510();
            thread _id_6513( var_8 );
            self waittill( "opened_floor_" + var_8 + "_outer_doors" );

            if ( self._id_303F )
            {
                self._id_3385 = "[B]";
                continue;
            }

            self._id_3385 = "[A]";
            continue;
        }

        if ( self._id_3385 == "[D]" )
        {
            if ( self._id_5F8E != _id_3D1D() )
            {
                thread _id_3042( self._id_5F8E );
                self waittill( "elevator_moved" );
            }

            self._id_3385 = "[C]";
            continue;
        }
    }
}

_id_5D69()
{
    for (;;)
    {
        var_0 = _id_2B3A( "trigger" );
        var_1 = undefined;
        var_2 = [];

        foreach ( var_5, var_4 in self._id_2FF3 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }

        var_6 = 0;

        foreach ( var_8 in var_2 )
        {
            var_9 = var_8 _id_3039();

            if ( !level._id_302A && !var_9 )
            {
                if ( var_8 _id_3D1D() == var_1 )
                {
                    var_6 = 1;
                    var_2 = [];
                    break;
                }
            }
        }

        foreach ( var_8 in var_2 )
        {
            if ( var_8._id_3385 == "[A]" )
            {
                var_8 _id_19E8( var_1 );
                var_6 = 1;

                if ( !level._id_302A )
                    break;
            }
        }

        if ( var_6 )
            self playsound( "elev_bell_ding" );
    }
}

_id_19E8( var_0 )
{
    self._id_5F8E = var_0;
    var_1 = _id_3D97();
    var_1 notify( "trigger", "elevator_called" );

    if ( level._id_3041 )
        var_1._id_5EF1 notify( "trigger", "elevator_called" );
}

_id_3D71( var_0 )
{
    var_1 = _id_3E0B();

    if ( var_1.size == 2 )
    {
        var_2 = _id_3D1D();
        self._id_5F8E = !var_2;
        return;
    }

    var_0 openpopupmenu( "elevator_floor_selector" );
    var_0 setclientdvar( "player_current_floor", _id_3D1D() );

    for (;;)
    {
        var_0 waittill( "menuresponse", var_3, var_4 );

        if ( var_3 == "elevator_floor_selector" )
        {
            if ( var_4 != "none" )
                self._id_5F8E = int( var_4 );

            break;
        }
    }
}

_id_303E( var_0 )
{
    self notify( "interrupt_watch" );
    level notify( "elevator_interior_button_pressed" );
    self endon( "interrupt_watch" );
    self endon( "elevator_moving" );
    self._id_303F = 0;
    wait 0.5;
    var_0 waittill( "trigger", var_1 );
    self notify( "interrupted" );
    self._id_303F = 1;
}

_id_3039()
{
    var_0 = _id_3D9A();
    var_1 = var_0.origin;
    var_2 = 1;

    foreach ( var_6, var_4 in _id_3E0B() )
    {
        var_5 = self._id_2FF3["floor" + var_6 + "_pos"];

        if ( var_1 == var_5 )
        {
            self._id_2FF3["current_floor"] = var_6;
            var_2 = 0;
        }
    }

    return var_2;
}

_id_3050()
{
    var_0 = _id_3D9C();

    if ( level._id_3043 && isdefined( var_0 ) )
        var_0 playloopsound( "elev_musak_loop" );

    thread _id_579C( "closing_inner_doors" );
    thread _id_579C( "opening_inner_doors" );
    thread _id_579C( "closed_inner_doors" );
    thread _id_579C( "opened_inner_doors" );

    foreach ( var_3, var_2 in _id_3E0B() )
    {
        thread _id_579C( "closing_floor_" + var_3 + "_outer_doors" );
        thread _id_579C( "opening_floor_" + var_3 + "_outer_doors" );
        thread _id_579C( "closed_floor_" + var_3 + "_outer_doors" );
        thread _id_579C( "opened_floor_" + var_3 + "_outer_doors" );
    }

    thread _id_579C( "interrupted" );
    thread _id_579C( "elevator_moving" );
    thread _id_579C( "elevator_moved" );
}

_id_579C( var_0 )
{
    for (;;)
    {
        self waittill( var_0 );
        var_1 = _id_3D9A();

        if ( issubstr( var_0, "closing_" ) )
            var_1 playsound( "elev_door_close" );

        if ( issubstr( var_0, "opening_" ) )
            var_1 playsound( "elev_door_open" );

        if ( var_0 == "elevator_moving" )
        {
            var_1 playsound( "elev_run_start" );
            var_1 playloopsound( "elev_run_loop" );
        }

        if ( var_0 == "interrupted" )
            var_1 playsound( "elev_door_interupt" );

        if ( var_0 == "elevator_moved" )
        {
            var_1 stoploopsound( "elev_run_loop" );
            var_1 playsound( "elev_run_end" );
            var_1 playsound( "elev_bell_ding" );
        }
    }
}

_id_6E59()
{
    foreach ( var_5, var_1 in level._id_305A )
    {
        var_1._id_5F8E = var_1 _id_3D1D();

        foreach ( var_4, var_3 in var_1 _id_3E0B() )
        {
            if ( var_1 _id_3D1D() != var_4 )
                var_1 thread _id_1FD3( var_4 );
        }
    }
}

_id_3042( var_0 )
{
    self notify( "elevator_moving" );
    self endon( "elevator_moving" );
    var_1 = _id_3D9A();
    var_2 = self._id_2FF3["floor" + var_0 + "_pos"] - var_1.origin;
    var_3 = level._id_3051;
    var_4 = abs( distance( self._id_2FF3["floor" + var_0 + "_pos"], var_1.origin ) );
    var_5 = var_4 / var_3;
    var_1 moveto( var_1.origin + var_2, var_5, var_5 * level._id_3029, var_5 * level._id_3036 );

    foreach ( var_7 in _id_3D94() )
    {
        var_8 = var_7.origin + var_2;

        if ( !issubstr( var_7.classname, "trigger_" ) )
        {
            var_7 moveto( var_8, var_5, var_5 * level._id_3029, var_5 * level._id_3036 );
            continue;
        }

        var_7.origin = var_8;
    }

    _id_A087( var_1, self._id_2FF3["floor" + var_0 + "_pos"] );
    self notify( "elevator_moved" );
}

_id_1FD0()
{
    self notify( "closing_inner_doors" );
    self endon( "closing_inner_doors" );
    self endon( "opening_inner_doors" );
    var_0 = _id_3D98();
    var_1 = _id_3D9E();
    var_2 = _id_3D9A();
    var_3 = _id_3D95();
    var_4 = ( var_3[0], var_3[1], var_2.origin[2] );
    var_5 = level._id_303D;
    var_6 = abs( distance( var_0.origin, var_4 ) );
    var_7 = var_6 / var_5;
    var_0 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    var_1 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    _id_A087( var_0, var_4, var_1, var_4 );
    self notify( "closed_inner_doors" );
}

_id_6510()
{
    self notify( "opening_inner_doors" );
    self endon( "opening_inner_doors" );
    var_0 = _id_3D98();
    var_1 = _id_3D9E();
    var_2 = _id_3D9A();
    var_3 = _id_3D99();
    var_4 = _id_3D9F();
    var_5 = ( var_3[0], var_3[1], var_2.origin[2] );
    var_6 = ( var_4[0], var_4[1], var_2.origin[2] );
    var_7 = level._id_303D;
    var_8 = abs( distance( var_5, var_6 ) * 0.5 );
    var_9 = var_8 / var_7 * 0.5;
    var_0 moveto( var_5, var_9, var_9 * 0.1, var_9 * 0.25 );
    var_1 moveto( var_6, var_9, var_9 * 0.1, var_9 * 0.25 );
    _id_A087( var_0, var_5, var_1, var_6 );
    self notify( "opened_inner_doors" );
}

_id_1FD3( var_0 )
{
    self notify( "closing_floor_" + var_0 + "_outer_doors" );
    self endon( "closing_floor_" + var_0 + "_outer_doors" );
    self endon( "opening_floor_" + var_0 + "_outer_doors" );
    var_1 = _id_3E0C( var_0 );
    var_2 = _id_3E0E( var_0 );
    var_3 = _id_3E0D( var_0 );
    var_4 = _id_3E09( var_0 );
    var_5 = level._id_3045;
    var_6 = abs( distance( var_3, var_4 ) );
    var_7 = var_6 / var_5;
    var_1 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    var_2 moveto( var_4, var_7, var_7 * 0.1, var_7 * 0.25 );
    _id_A087( var_1, var_4, var_2, var_4 );
    self notify( "closed_floor_" + var_0 + "_outer_doors" );
}

_id_6513( var_0 )
{
    level notify( "elevator_doors_opening" );
    self notify( "opening_floor_" + var_0 + "_outer_doors" );
    self endon( "opening_floor_" + var_0 + "_outer_doors" );
    var_1 = _id_3E0C( var_0 );
    var_2 = _id_3E0E( var_0 );
    var_3 = _id_3E0D( var_0 );
    var_4 = _id_3E0F( var_0 );
    var_5 = _id_3E09( var_0 );
    var_6 = level._id_3045;
    var_7 = abs( distance( var_3, var_5 ) );
    var_8 = var_7 / var_6 * 0.5;
    var_1 moveto( var_3, var_8, var_8 * 0.1, var_8 * 0.25 );
    var_2 moveto( var_4, var_8, var_8 * 0.1, var_8 * 0.25 );
    _id_A087( var_1, var_3, var_2, var_4 );
    self notify( "opened_floor_" + var_0 + "_outer_doors" );
}

_id_184A()
{
    var_0 = getentarray( "elevator_group", "targetname" );
    var_1 = getentarray( "elevator_housing", "targetname" );
    var_2 = getentarray( "elevator_doorset", "targetname" );

    foreach ( var_4 in var_0 )
    {
        var_5 = getent( var_4.target, "targetname" );
        var_6 = [];
        var_6[0] = min( var_4.origin[0], var_5.origin[0] );
        var_6[1] = max( var_4.origin[0], var_5.origin[0] );
        var_6[2] = min( var_4.origin[1], var_5.origin[1] );
        var_6[3] = max( var_4.origin[1], var_5.origin[1] );
        var_7 = spawnstruct();
        var_7._id_2FF3["id"] = level._id_305A.size;
        var_7._id_2FF3["housing"] = [];
        var_7._id_2FF3["housing"]["mainframe"] = [];

        foreach ( var_9 in var_1 )
        {
            if ( var_9 _id_511E( var_6 ) )
            {
                var_7._id_2FF3["housing"]["mainframe"][var_7._id_2FF3["housing"]["mainframe"].size] = var_9;

                if ( var_9.classname == "script_model" )
                    continue;

                if ( var_9.code_classname == "light" )
                    continue;

                var_10 = getent( var_9.target, "targetname" );
                var_7._id_2FF3["housing"]["left_door"] = var_10;
                var_7._id_2FF3["housing"]["left_door_opened_pos"] = var_10.origin;
                var_11 = getent( var_10.target, "targetname" );
                var_7._id_2FF3["housing"]["right_door"] = var_11;
                var_7._id_2FF3["housing"]["right_door_opened_pos"] = var_11.origin;
                var_12 = ( var_10.origin - var_11.origin ) * ( 0.5, 0.5, 0.5 ) + var_11.origin;
                var_7._id_2FF3["housing"]["door_closed_pos"] = var_12;
                var_13 = getent( var_11.target, "targetname" );
                var_7._id_2FF3["housing"]["door_trigger"] = var_13;
                var_14 = getent( var_13.target, "targetname" );
                var_7._id_2FF3["housing"]["inside_trigger"] = var_14;
                var_14 _id_5914();
                var_14._id_5EF1 = spawn( "trigger_radius", var_9.origin, 0, 64, 128 );
            }
        }

        var_7._id_2FF3["outer_doorset"] = [];

        foreach ( var_17 in var_2 )
        {
            if ( var_17 _id_511E( var_6 ) )
            {
                var_18 = isdefined( var_17.script_noteworthy ) && var_17.script_noteworthy == "closed_for_lighting";
                var_19 = var_7._id_2FF3["outer_doorset"].size;
                var_7._id_2FF3["outer_doorset"][var_19] = [];
                var_7._id_2FF3["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
                var_20 = getent( var_17.target, "targetname" );
                var_7._id_2FF3["outer_doorset"][var_19]["left_door"] = var_20;
                var_7._id_2FF3["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
                var_21 = getent( var_20.target, "targetname" );
                var_7._id_2FF3["outer_doorset"][var_19]["right_door"] = var_21;
                var_7._id_2FF3["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;

                if ( var_18 )
                {
                    var_22 = var_17.origin - var_20.origin;
                    var_17.origin = var_20.origin;
                    var_20.origin += var_22;
                    var_21.origin -= var_22;
                    var_7._id_2FF3["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
                    var_7._id_2FF3["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
                    var_7._id_2FF3["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;
                }
            }
        }

        for ( var_24 = 0; var_24 < var_7._id_2FF3["outer_doorset"].size - 1; var_24++ )
        {
            for ( var_25 = 0; var_25 < var_7._id_2FF3["outer_doorset"].size - 1 - var_24; var_25++ )
            {
                if ( var_7._id_2FF3["outer_doorset"][var_25 + 1]["door_closed_pos"][2] < var_7._id_2FF3["outer_doorset"][var_25]["door_closed_pos"][2] )
                {
                    var_26 = var_7._id_2FF3["outer_doorset"][var_25]["left_door"];
                    var_27 = var_7._id_2FF3["outer_doorset"][var_25]["left_door_opened_pos"];
                    var_28 = var_7._id_2FF3["outer_doorset"][var_25]["right_door"];
                    var_29 = var_7._id_2FF3["outer_doorset"][var_25]["right_door_opened_pos"];
                    var_30 = var_7._id_2FF3["outer_doorset"][var_25]["door_closed_pos"];
                    var_7._id_2FF3["outer_doorset"][var_25]["left_door"] = var_7._id_2FF3["outer_doorset"][var_25 + 1]["left_door"];
                    var_7._id_2FF3["outer_doorset"][var_25]["left_door_opened_pos"] = var_7._id_2FF3["outer_doorset"][var_25 + 1]["left_door_opened_pos"];
                    var_7._id_2FF3["outer_doorset"][var_25]["right_door"] = var_7._id_2FF3["outer_doorset"][var_25 + 1]["right_door"];
                    var_7._id_2FF3["outer_doorset"][var_25]["right_door_opened_pos"] = var_7._id_2FF3["outer_doorset"][var_25 + 1]["right_door_opened_pos"];
                    var_7._id_2FF3["outer_doorset"][var_25]["door_closed_pos"] = var_7._id_2FF3["outer_doorset"][var_25 + 1]["door_closed_pos"];
                    var_7._id_2FF3["outer_doorset"][var_25 + 1]["left_door"] = var_26;
                    var_7._id_2FF3["outer_doorset"][var_25 + 1]["left_door_opened_pos"] = var_27;
                    var_7._id_2FF3["outer_doorset"][var_25 + 1]["right_door"] = var_28;
                    var_7._id_2FF3["outer_doorset"][var_25 + 1]["right_door_opened_pos"] = var_29;
                    var_7._id_2FF3["outer_doorset"][var_25 + 1]["door_closed_pos"] = var_30;
                }
            }
        }

        var_31 = [];

        foreach ( var_24, var_33 in var_7._id_2FF3["outer_doorset"] )
        {
            var_34 = var_7 _id_3D9A();
            var_31 = ( var_34.origin[0], var_34.origin[1], var_33["door_closed_pos"][2] );
            var_7._id_2FF3["floor" + var_24 + "_pos"] = var_31;

            if ( var_34.origin == var_31 )
            {
                var_7._id_2FF3["initial_floor"] = var_24;
                var_7._id_2FF3["current_floor"] = var_24;
            }
        }

        level._id_305A[level._id_305A.size] = var_7;
        var_4 delete();
        var_5 delete();
    }

    foreach ( var_17 in var_2 )
        var_17 delete();

    _id_183D();

    if ( !level._id_3041 )
        _id_813A();

    foreach ( var_39 in level._id_305A )
    {
        var_40 = var_39 _id_3D9D();

        if ( isdefined( var_40 ) && var_40.size )
        {
            foreach ( var_42 in var_40 )
                var_42 _meth_81DF( 0.75 );
        }
    }
}

_id_183D()
{
    level._id_3033 = getentarray( "elevator_call", "targetname" );

    foreach ( var_1 in level._id_3033 )
    {
        var_1._id_2FF3 = [];
        var_2 = ( 0, 0, var_1.origin[2] );
        var_3 = ( var_1.origin[0], var_1.origin[1], 0 );
        var_4 = [];

        foreach ( var_12, var_6 in level._id_305A )
        {
            foreach ( var_11, var_8 in var_6 _id_3E0B() )
            {
                var_9 = ( 0, 0, var_6._id_2FF3["floor" + var_11 + "_pos"][2] );
                var_10 = ( var_6._id_2FF3["floor" + var_11 + "_pos"][0], var_6._id_2FF3["floor" + var_11 + "_pos"][1], 0 );

                if ( abs( distance( var_2, var_9 ) ) <= level._id_3032 )
                {
                    if ( abs( distance( var_3, var_10 ) ) <= level._id_3031 )
                    {
                        var_4[var_4.size] = var_6;
                        var_1._id_2FF3[var_11] = var_4;
                    }
                }
            }
        }

        var_1 _id_5914();
        var_1._id_5EF1 = spawn( "trigger_radius", var_1.origin + ( 0.0, 0.0, -32.0 ), 0, 32, 64 );
    }
}

_id_813A()
{
    foreach ( var_1 in level._id_305A )
    {
        var_2 = var_1 _id_3D97();
        var_3 = var_1 _id_3E0B();
        var_4 = var_3.size;
        var_2 setcursorhint( "HINT_NOICON" );

        if ( var_4 > 2 )
        {
            var_2 sethintstring( &"ELEVATOR_FLOOR_SELECT_HINT" );
            continue;
        }

        var_2 sethintstring( &"ELEVATOR_USE_HINT" );
    }

    foreach ( var_7 in level._id_3033 )
    {
        var_7 setcursorhint( "HINT_NOICON" );
        var_7 sethintstring( &"ELEVATOR_CALL_HINT" );
    }
}

_id_5914()
{
    self.enabled = 1;
    _id_2AE3();
}

_id_2B3A( var_0 )
{
    _id_30FE();

    if ( level._id_3041 )
        self._id_5EF1 waittill( var_0, var_1 );
    else
        self waittill( var_0, var_1 );

    _id_2AE3();
    return var_1;
}

_id_30FE()
{
    if ( !self.enabled )
    {
        self.enabled = 1;
        self.origin += ( 0.0, 0.0, 10000.0 );

        if ( isdefined( self._id_5EF1 ) )
            self._id_5EF1.origin += ( 0.0, 0.0, 10000.0 );
    }
}

_id_2AE3()
{
    self notify( "disable_trigger" );

    if ( self.enabled )
        thread _id_2AE4();
}

_id_2AE4()
{
    self endon( "disable_trigger" );
    self.enabled = 0;
    wait 1.5;
    self.origin += ( 0.0, 0.0, -10000.0 );

    if ( isdefined( self._id_5EF1 ) )
        self._id_5EF1.origin += ( 0.0, 0.0, -10000.0 );
}

_id_3E0A( var_0 )
{
    return self._id_2FF3["outer_doorset"][var_0];
}

_id_3E0B()
{
    return self._id_2FF3["outer_doorset"];
}

_id_3E09( var_0 )
{
    return self._id_2FF3["outer_doorset"][var_0]["door_closed_pos"];
}

_id_3E0C( var_0 )
{
    return self._id_2FF3["outer_doorset"][var_0]["left_door"];
}

_id_3E0E( var_0 )
{
    return self._id_2FF3["outer_doorset"][var_0]["right_door"];
}

_id_3E0D( var_0 )
{
    return self._id_2FF3["outer_doorset"][var_0]["left_door_opened_pos"];
}

_id_3E0F( var_0 )
{
    return self._id_2FF3["outer_doorset"][var_0]["right_door_opened_pos"];
}

_id_3D94()
{
    var_0 = [];
    var_1 = _id_3D96();
    var_2 = _id_3D97();
    var_3 = var_2._id_5EF1;
    var_4 = _id_3D98();
    var_5 = _id_3D9E();
    var_0[var_0.size] = var_1;
    var_0[var_0.size] = var_2;
    var_0[var_0.size] = var_4;
    var_0[var_0.size] = var_5;

    if ( isdefined( var_3 ) )
        var_0[var_0.size] = var_3;

    var_6 = _id_3D9B();

    foreach ( var_8 in var_6 )
        var_0[var_0.size] = var_8;

    var_10 = _id_3D9D();

    foreach ( var_12 in var_10 )
        var_0[var_0.size] = var_12;

    return var_0;
}

_id_3D9A()
{
    var_0 = self._id_2FF3["housing"]["mainframe"];
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname != "script_model" && var_3.code_classname != "light" )
            var_1 = var_3;
    }

    return var_1;
}

_id_3D9B()
{
    var_0 = self._id_2FF3["housing"]["mainframe"];
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_model" )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_3D9D()
{
    var_0 = self._id_2FF3["housing"]["mainframe"];
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.code_classname == "light" )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_3D9C()
{
    var_0 = _id_3D9B();
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "play_musak" )
            var_1 = var_3;
    }

    return var_1;
}

_id_3D96()
{
    return self._id_2FF3["housing"]["door_trigger"];
}

_id_3D97()
{
    return self._id_2FF3["housing"]["inside_trigger"];
}

_id_3D95()
{
    return self._id_2FF3["housing"]["door_closed_pos"];
}

_id_3D98()
{
    return self._id_2FF3["housing"]["left_door"];
}

_id_3D9E()
{
    return self._id_2FF3["housing"]["right_door"];
}

_id_3D99()
{
    return self._id_2FF3["housing"]["left_door_opened_pos"];
}

_id_3D9F()
{
    return self._id_2FF3["housing"]["right_door_opened_pos"];
}

_id_3D1D()
{
    var_0 = _id_3039();
    return self._id_2FF3["current_floor"];
}

_id_3DAA()
{
    return self._id_2FF3["initial_floor"];
}

_id_A087( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) && !isdefined( var_3 ) )
    {
        var_2 = var_0;
        var_3 = var_1;
    }

    for (;;)
    {
        var_4 = var_0.origin;
        var_5 = var_2.origin;

        if ( var_4 == var_1 && var_5 == var_3 )
            break;

        wait 0.05;
    }
}

_id_511E( var_0 )
{
    var_1 = self.origin[0];
    var_2 = self.origin[1];
    var_3 = var_0[0];
    var_4 = var_0[1];
    var_5 = var_0[2];
    var_6 = var_0[3];
    return var_1 >= var_3 && var_1 <= var_4 && var_2 >= var_5 && var_2 <= var_6;
}

_id_5120( var_0 )
{
    var_1 = self.origin[0];
    var_2 = self.origin[1];
    var_3 = var_0[0];
    var_4 = var_0[1];
    var_5 = var_0[2];
    var_6 = var_0[3];
    var_7 = ( var_3 + var_4 ) / 2;
    var_8 = ( var_5 + var_6 ) / 2;
    var_9 = abs( distance( ( var_3, var_5, 0 ), ( var_7, var_8, 0 ) ) );
    return abs( distance( ( var_1, var_2, 0 ), ( var_7, var_8, 0 ) ) ) < var_9;
}

_id_A09E( var_0, var_1 )
{
    self endon( var_0 );
    wait(var_1);
}

_id_303C( var_0, var_1 )
{
    return int( _id_303B( var_0, var_1 ) );
}

_id_303B( var_0, var_1 )
{
    if ( getdvar( var_0 ) != "" )
        return getdvarfloat( var_0 );
    else
    {
        setdvar( var_0, var_1 );
        return var_1;
    }
}

_id_3035()
{
    if ( !level._id_3035 )
        return;

    for (;;)
    {
        if ( level._id_3035 != 2 )
            continue;

        foreach ( var_7, var_1 in level._id_305A )
        {
            var_2 = var_1 _id_3D9A();
            var_3 = var_1 _id_3D9C();

            foreach ( var_6, var_5 in var_1._id_2FF3["outer_doorset"] )
            {

            }
        }

        foreach ( var_9 in level._id_3033 )
        {
            foreach ( var_16, var_5 in var_9._id_2FF3 )
            {
                var_11 = 0;

                foreach ( var_15, var_13 in var_5 )
                {
                    var_11++;
                    var_14 = var_9.origin + ( 0, 0, var_11 * -4 );
                }
            }
        }

        wait 0.05;
    }
}
