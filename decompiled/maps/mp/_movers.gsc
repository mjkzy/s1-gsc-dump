// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
        return;

    level._id_7A48 = [];
    level._id_7A48["move_time"] = 5;
    level._id_7A48["accel_time"] = 0;
    level._id_7A48["decel_time"] = 0;
    level._id_7A48["wait_time"] = 0;
    level._id_7A48["delay_time"] = 0;
    level._id_7A48["usable"] = 0;
    level._id_7A48["hintstring"] = "activate";
    _id_7A3E( "activate", &"MP_ACTIVATE_MOVER" );
    _id_7A3F( "none", "" );
    level._id_7A58 = [];
    level._id_7A43 = [];
    waitframe();
    var_0 = [];
    var_1 = _id_7A45();

    foreach ( var_3 in var_1 )
        var_0 = common_scripts\utility::array_combine( var_0, getentarray( var_3, "classname" ) );

    common_scripts\utility::array_thread( var_0, ::_id_7A50 );
}

_id_7A45()
{
    return [ "script_model_mover", "script_brushmodel_mover" ];
}

_id_7A54()
{
    if ( isdefined( self._id_7A3C ) )
        return self._id_7A3C;

    var_0 = _id_7A45();

    foreach ( var_2 in var_0 )
    {
        if ( self.classname == var_2 )
        {
            self._id_7A3C = 1;
            return 1;
        }
    }

    return 0;
}

_id_7A3E( var_0, var_1 )
{
    if ( !isdefined( level._id_7A4F ) )
        level._id_7A4F = [];

    level._id_7A4F[var_0] = var_1;
}

_id_7A3F( var_0, var_1 )
{
    if ( !isdefined( level._id_7A5B ) )
        level._id_7A5B = [];

    level._id_7A5B[var_0] = var_1;
}

_id_7A3D( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level._id_7A43 ) )
        level._id_7A43 = [];

    if ( !isdefined( var_3 ) )
        var_3 = "default";

    if ( !isdefined( level._id_7A43[var_0] ) )
        level._id_7A43[var_0] = [];

    var_4 = spawnstruct();
    var_4._id_0C72 = var_1;
    var_4._id_0C79 = var_2;
    level._id_7A43[var_0][var_3] = var_4;
}

_id_7A50()
{
    self._id_7A3C = 1;
    self._id_5F9B = 0;
    self._id_6590 = self;
    self._id_9BE4 = [];
    self._id_5785 = [];
    var_0 = [];

    if ( isdefined( self.target ) )
        var_0 = common_scripts\utility::getstructarray( self.target, "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            continue;

        switch ( var_2.script_noteworthy )
        {
            case "origin":
                if ( !isdefined( var_2.angles ) )
                    var_2.angles = ( 0.0, 0.0, 0.0 );

                self._id_6590 = spawn( "script_model", var_2.origin );
                self._id_6590.angles = var_2.angles;
                self._id_6590 setmodel( "tag_origin" );
                self._id_6590 linkto( self );
                continue;
            case "scripted_node":
            case "scene_node":
                if ( !isdefined( var_2.angles ) )
                    var_2.angles = ( 0.0, 0.0, 0.0 );

                self._id_7B33 = var_2;
                continue;
            default:
                continue;
        }
    }

    var_4 = [];

    if ( isdefined( self.target ) )
        var_4 = getentarray( self.target, "targetname" );

    foreach ( var_2 in var_4 )
    {
        if ( !isdefined( var_2.script_noteworthy ) )
            continue;

        var_6 = strtok( var_2.script_noteworthy, ";" );

        foreach ( var_8 in var_6 )
        {
            switch ( var_8 )
            {
                case "use_trigger_link":
                    var_2 enablelinkto();
                    var_2 linkto( self );
                case "use_trigger":
                    var_2 _id_7A5F();
                    thread _id_7A6E( var_2 );
                    self._id_9BE4[self._id_9BE4.size] = var_2;
                    continue;
                case "link":
                    var_2 linkto( self );
                    self._id_5785[self._id_5785.size] = var_2;
                    continue;
                default:
                    continue;
            }
        }
    }

    thread _id_7A5F();
    thread _id_7A51();
    thread _id_7A63();
    thread _id_7A64();
    thread _id_7A44( self );
    thread _id_7A62();
    _id_7A69();

    foreach ( var_12 in self._id_9BE4 )
        _id_7A66( var_12, 1 );

    self._id_7A50 = 1;
    self notify( "script_mover_init" );
}

_id_7A69()
{
    if ( _id_7A52() )
        thread _id_7A42();
    else
        thread _id_7A57();
}

_id_7A62()
{
    self._id_5F69 = self.origin;
    self._id_5F68 = self.angles;
}

_id_7A61( var_0 )
{
    self notify( "mover_reset" );

    if ( _id_7A52() )
        self _meth_827A();

    self.origin = self._id_5F69;
    self.angles = self._id_5F68;
    self notify( "new_path" );
    waitframe();
    _id_7A69();
}

_id_7A6E( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_0 waittill( "trigger" );

        if ( var_0._id_4250.size > 0 )
        {
            self notify( "new_path" );
            thread _id_7A57( var_0 );
            continue;
        }

        self notify( "trigger" );
    }
}

_id_7A56( var_0 )
{
    if ( isdefined( level._id_7A58[var_0] ) )
    {
        self notify( "new_path" );
        self._id_4250 = level._id_7A58[var_0];
        thread _id_7A57();
    }
}

_id_0B9F( var_0 )
{
    return ( angleclamp180( var_0[0] ), angleclamp180( var_0[1] ), angleclamp180( var_0[2] ) );
}

_id_7A5F()
{
    if ( isdefined( self._id_6694 ) && self._id_6694 )
        return;

    self._id_6694 = 1;
    self._id_4250 = [];
    self._id_5F6C = [];
    var_0 = [];
    var_1 = [];

    if ( isdefined( self.target ) )
    {
        var_0 = common_scripts\utility::getstructarray( self.target, "targetname" );
        var_1 = getentarray( self.target, "targetname" );
    }

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_0[var_2];

        if ( !isdefined( var_3.script_noteworthy ) )
            var_3.script_noteworthy = "goal";

        switch ( var_3.script_noteworthy )
        {
            case "ignore":
                if ( isdefined( var_3.target ) )
                {
                    var_4 = common_scripts\utility::getstructarray( var_3.target, "targetname" );

                    foreach ( var_6 in var_4 )
                        var_0[var_0.size] = var_6;
                }

                continue;
            case "goal":
                var_3 _id_7A51();
                var_3 _id_7A5F();
                self._id_4250[self._id_4250.size] = var_3;

                if ( isdefined( var_3._id_6680["name"] ) )
                {
                    if ( !isdefined( level._id_7A58[var_3._id_6680["name"]] ) )
                        level._id_7A58[var_3._id_6680["name"]] = [];

                    var_8 = level._id_7A58[var_3._id_6680["name"]].size;
                    level._id_7A58[var_3._id_6680["name"]][var_8] = var_3;
                }

                continue;
            default:
                continue;
        }
    }

    foreach ( var_10 in var_1 )
    {
        if ( var_10 _id_7A54() )
            self._id_5F6C[self._id_5F6C.size] = var_10;

        thread _id_7A5C( var_10 );
    }
}

_id_7A5C( var_0 )
{
    if ( !isdefined( var_0.script_noteworthy ) )
        return;

    if ( var_0 _id_7A54() && !isdefined( var_0._id_7A50 ) )
        var_0 waittill( "script_mover_init" );

    var_1 = strtok( var_0.script_noteworthy, ";" );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "_" );

        if ( var_4.size < 3 || var_4[1] != "on" )
            continue;

        var_5 = tolower( var_4[0] );
        var_6 = var_4[2];

        for ( var_7 = 3; var_7 < var_4.size; var_7++ )
            var_6 = var_6 + "_" + var_4[var_7];

        switch ( var_5 )
        {
            case "connectpaths":
                thread _id_7A4C( var_0, var_6, ::_id_7A47, ::_id_7A4B );
                continue;
            case "disconnectpaths":
                thread _id_7A4C( var_0, var_6, ::_id_7A4B, ::_id_7A47 );
                continue;
            case "solid":
                var_0 notsolid();
                thread _id_7A4C( var_0, var_6, ::_id_7A68, ::_id_7A5A );
                continue;
            case "notsolid":
                thread _id_7A4C( var_0, var_6, ::_id_7A5A, ::_id_7A68 );
                continue;
            case "delete":
                thread _id_7A4C( var_0, var_6, ::_id_7A4A );
                continue;
            case "hide":
                thread _id_7A4C( var_0, var_6, ::_id_7A4E, ::_id_7A67 );
                continue;
            case "show":
                var_0 hide();
                thread _id_7A4C( var_0, var_6, ::_id_7A67, ::_id_7A4E );
                continue;
            case "triggerhide":
                thread _id_7A4C( var_0, var_6, ::_id_7A6B, ::_id_7A6C );
                continue;
            case "triggershow":
                var_0 common_scripts\utility::trigger_off();
                thread _id_7A4C( var_0, var_6, ::_id_7A6C, ::_id_7A6B );
                continue;
            case "trigger":
                thread _id_7A4C( var_0, var_6, ::_id_7A6A, ::_id_7A61 );
                continue;
            default:
                continue;
        }
    }
}

_id_7A6B( var_0 )
{
    self dontinterpolate();
    common_scripts\utility::trigger_off();
}

_id_7A6C( var_0 )
{
    self dontinterpolate();
    common_scripts\utility::trigger_on();
}

_id_7A59( var_0, var_1 )
{
    var_0 notify( var_1 );
}

_id_7A55( var_0, var_1 )
{
    level notify( var_1 );
}

_id_7A47( var_0 )
{
    self connectpaths();
}

_id_7A4B( var_0 )
{
    self disconnectpaths( var_0 );
}

_id_7A68( var_0 )
{
    self solid();
}

_id_7A5A( var_0 )
{
    self notsolid();
}

_id_7A4A( var_0 )
{
    self delete();
}

_id_7A4E( var_0 )
{
    self hide();
}

_id_7A67( var_0 )
{
    self show();
}

_id_7A6A( var_0 )
{
    self notify( "trigger" );
}

_id_7A4C( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        self waittill( var_1, var_4 );
        var_0 [[ var_2 ]]( var_4 );

        if ( isdefined( var_3 ) && isdefined( var_4 ) )
        {
            var_4 _id_7A6F( var_0, var_3 );
            continue;
        }

        break;
    }
}

_id_7A6D()
{
    var_0 = [];

    if ( _id_7A53() )
        var_0[var_0.size] = self;

    foreach ( var_2 in self._id_5785 )
    {
        if ( var_2 _id_7A53() )
            var_0[var_0.size] = var_2;
    }

    if ( var_0.size == 0 )
        return;

    for (;;)
    {
        foreach ( var_5 in var_0 )
            var_5 _id_7A4B();

        self waittill( "move_start" );

        foreach ( var_5 in var_0 )
            var_5 _id_7A47();

        self waittill( "move_end" );
    }
}

_id_7A42()
{
    childthread _id_7A6D();
    var_0 = self._id_6680["animation"];

    if ( isdefined( level._id_7A43[var_0]["idle"] ) )
        _id_7A60( level._id_7A43[var_0]["idle"], 0 );

    _id_7A49();
    self notify( "move_start" );
    self notify( "start", self );
    var_1 = level._id_7A43[var_0]["default"];

    if ( isdefined( var_1 ) )
    {
        _id_7A60( var_1, 1 );
        self waittill( "end" );
    }

    self notify( "move_end" );
}

_id_7A60( var_0, var_1 )
{
    self notify( "play_animation" );

    if ( var_1 )
        thread _id_7A4D();

    if ( isdefined( self._id_7B33 ) )
        self _meth_848B( var_0._id_0C72, self._id_7B33.origin, self._id_7B33.angles, "script_mover_anim" );
    else
        self scriptmodelplayanimdeltamotion( var_0._id_0C72, "script_mover_anim" );
}

_id_7A4D()
{
    self endon( "play_animation" );
    self endon( "mover_reset" );

    for (;;)
    {
        self waittill( "script_mover_anim", var_0 );
        self notify( var_0, self );
    }
}

_id_7A49()
{
    if ( isdefined( self._id_6680["delay_till"] ) )
        level waittill( self._id_6680["delay_till"] );

    if ( isdefined( self._id_6680["delay_till_trigger"] ) && self._id_6680["delay_till_trigger"] )
        self waittill( "trigger" );

    if ( self._id_6680["delay_time"] > 0 )
        wait(self._id_6680["delay_time"]);
}

_id_7A57( var_0 )
{
    self endon( "death" );
    self endon( "new_path" );
    childthread _id_7A6D();

    if ( !isdefined( var_0 ) )
        var_0 = self;

    while ( var_0._id_4250.size != 0 )
    {
        var_1 = common_scripts\utility::random( var_0._id_4250 );
        var_2 = self;
        var_2 _id_7A44( var_1 );
        var_2 _id_7A49();
        var_3 = var_2._id_6680["move_time"];
        var_4 = var_2._id_6680["accel_time"];
        var_5 = var_2._id_6680["decel_time"];
        var_6 = 0;
        var_7 = 0;
        var_8 = transformmove( var_1.origin, var_1.angles, self._id_6590.origin, self._id_6590.angles, self.origin, self.angles );

        if ( var_2.origin != var_1.origin )
        {
            if ( isdefined( var_2._id_6680["move_speed"] ) )
            {
                var_9 = distance( var_2.origin, var_1.origin );
                var_3 = var_9 / var_2._id_6680["move_speed"];
            }

            if ( isdefined( var_2._id_6680["accel_frac"] ) )
                var_4 = var_2._id_6680["accel_frac"] * var_3;

            if ( isdefined( var_2._id_6680["decel_frac"] ) )
                var_5 = var_2._id_6680["decel_frac"] * var_3;

            if ( var_3 <= 0 )
            {
                var_2 dontinterpolate();
                var_2.origin = var_8["origin"];
            }
            else
                var_2 moveto( var_8["origin"], var_3, var_4, var_5 );

            var_6 = 1;
        }

        if ( _id_0B9F( var_8["angles"] ) != _id_0B9F( var_2.angles ) )
        {
            if ( var_3 <= 0 )
            {
                var_2 dontinterpolate();
                var_2.angles = var_8["angles"];
            }
            else
                var_2 _meth_82B5( var_8["angles"], var_3, var_4, var_5 );

            var_7 = 1;
        }

        foreach ( var_11 in var_2._id_5F6C )
        {
            var_11 notify( "trigger" );
            _id_7A6F( var_11, ::_id_7A61 );
        }

        var_2 notify( "move_start" );
        var_0 notify( "depart", var_2 );

        if ( isdefined( var_2._id_6680["name"] ) )
        {
            var_13 = "mover_depart_" + var_2._id_6680["name"];
            var_2 notify( var_13 );
            level notify( var_13, var_2 );
        }

        var_2 _id_7A41( 0 );

        if ( var_3 <= 0 )
        {

        }
        else if ( var_6 )
            var_2 waittill( "movedone" );
        else if ( var_7 )
            var_2 waittill( "rotatedone" );
        else
            wait(var_3);

        var_2 notify( "move_end" );
        var_1 notify( "arrive", var_2 );

        if ( isdefined( var_2._id_6680["name"] ) )
        {
            var_13 = "mover_arrive_" + var_2._id_6680["name"];
            var_2 notify( var_13 );
            level notify( var_13, var_2 );
        }

        if ( isdefined( var_2._id_6680["solid"] ) )
        {
            if ( var_2._id_6680["solid"] )
                var_2 solid();
            else
                var_2 notsolid();
        }

        foreach ( var_11 in var_1._id_5F6C )
        {
            var_11 notify( "trigger" );
            _id_7A6F( var_11, ::_id_7A61 );
        }

        if ( isdefined( var_2._id_6680["wait_till"] ) )
            level waittill( var_2._id_6680["wait_till"] );

        if ( var_2._id_6680["wait_time"] > 0 )
            wait(var_2._id_6680["wait_time"]);

        var_2 _id_7A41( 1 );
        var_0 = var_1;
    }
}

_id_7A6F( var_0, var_1 )
{
    thread _id_7A4C( var_0, "mover_reset", var_1 );
}

_id_7A51()
{
    self._id_6680 = [];

    if ( !isdefined( self.angles ) )
        self.angles = ( 0.0, 0.0, 0.0 );

    self.angles = _id_0B9F( self.angles );
    _id_7A5D( self.script_parameters );
}

_id_7A5D( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "";

    var_1 = strtok( var_0, ";" );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "=" );

        if ( var_4.size != 2 )
            continue;

        if ( var_4[1] == "undefined" || var_4[1] == "default" )
        {
            self._id_6680[var_4[0]] = "<undefined>";
            continue;
        }

        switch ( var_4[0] )
        {
            case "move_time":
            case "accel_time":
            case "decel_time":
            case "wait_time":
            case "delay_time":
            case "move_speed":
            case "accel_frac":
            case "decel_frac":
                self._id_6680[var_4[0]] = _id_7A5E( var_4[1] );
                continue;
            case "name":
            case "animation":
            case "hintstring":
            case "delay_till":
            case "wait_till":
                self._id_6680[var_4[0]] = var_4[1];
                continue;
            case "solid":
            case "usable":
            case "delay_till_trigger":
                self._id_6680[var_4[0]] = int( var_4[1] );
                continue;
            case "script_params":
                var_5 = var_4[1];
                var_6 = level._id_7A5B[var_5];

                if ( isdefined( var_6 ) )
                    _id_7A5D( var_6 );

                continue;
            default:
                continue;
        }
    }
}

_id_7A5E( var_0 )
{
    var_1 = 0;
    var_2 = strtok( var_0, "," );

    if ( var_2.size == 1 )
        var_1 = float( var_2[0] );
    else if ( var_2.size == 2 )
    {
        var_3 = float( var_2[0] );
        var_4 = float( var_2[1] );

        if ( var_3 >= var_4 )
            var_1 = var_3;
        else
            var_1 = randomfloatrange( var_3, var_4 );
    }

    return var_1;
}

_id_7A44( var_0 )
{
    foreach ( var_3, var_2 in var_0._id_6680 )
        _id_7A65( var_3, var_2 );

    _id_7A64();
}

_id_7A65( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( var_0 == "usable" && isdefined( var_1 ) )
        _id_7A66( self, var_1 );

    if ( isdefined( var_1 ) && isstring( var_1 ) && var_1 == "<undefined>" )
        var_1 = undefined;

    self._id_6680[var_0] = var_1;
}

_id_7A41( var_0 )
{
    if ( self._id_6680["usable"] )
        _id_7A66( self, var_0 );

    foreach ( var_2 in self._id_9BE4 )
        _id_7A66( var_2, var_0 );
}

_id_7A66( var_0, var_1 )
{
    if ( var_1 )
    {
        var_0 makeusable();
        var_0 setcursorhint( "HINT_ACTIVATE" );
        var_0 sethintstring( level._id_7A4F[self._id_6680["hintstring"]] );
    }
    else
        var_0 makeunusable();
}

_id_7A63()
{
    self._id_6681 = [];

    foreach ( var_2, var_1 in self._id_6680 )
        self._id_6681[var_2] = var_1;
}

_id_7A64()
{
    if ( isdefined( self._id_6681 ) )
    {
        foreach ( var_2, var_1 in self._id_6681 )
        {
            if ( !isdefined( self._id_6680[var_2] ) )
                _id_7A65( var_2, var_1 );
        }
    }

    foreach ( var_2, var_1 in level._id_7A48 )
    {
        if ( !isdefined( self._id_6680[var_2] ) )
            _id_7A65( var_2, var_1 );
    }
}

_id_7A53()
{
    return isdefined( self._id_03DB ) && self._id_03DB & 1;
}

_id_7A52()
{
    return isdefined( self._id_6680["animation"] );
}

init()
{
    level thread _id_7A46();
    level thread _id_7A40();
}

_id_7A46()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread _id_6C41();
    }
}

_id_7A40()
{
    for (;;)
    {
        level waittill( "spawned_agent", var_0 );
        var_0 thread _id_6C41();
    }
}

_id_6C41()
{
    self endon( "disconnect" );

    if ( isagent( self ) )
        self endon( "death" );

    self._id_9A50 = 0;

    for (;;)
    {
        self waittill( "unresolved_collision", var_0 );

        if ( isagent( self ) && isdefined( self.animclass ) )
        {
            if ( self _meth_855A() == "noclip" )
                continue;
        }

        self._id_9A50++;
        thread _id_1EDC();
        var_1 = 3;

        if ( isdefined( var_0 ) && isdefined( var_0._id_9A56 ) )
            var_1 = var_0._id_9A56;

        if ( self._id_9A50 >= var_1 )
        {
            if ( isdefined( var_0 ) )
            {
                if ( isdefined( var_0._id_9A52 ) )
                    var_0 [[ var_0._id_9A52 ]]( self );
                else if ( isdefined( var_0._id_9A53 ) && var_0._id_9A53 )
                    var_0 _id_9A57( self );
                else
                    var_0 _id_9A54( self );
            }
            else
                _id_9A54( self );

            self._id_9A50 = 0;
        }
    }
}

_id_1EDC()
{
    self endon( "unresolved_collision" );
    waitframe();

    if ( isdefined( self ) )
        self._id_9A50 = 0;
}

_id_9A57( var_0 )
{
    var_1 = self;

    if ( !isdefined( var_1.owner ) )
    {
        var_0 _id_5F6A();
        return;
    }

    var_2 = 0;

    if ( level.teambased )
    {
        if ( isdefined( var_1.owner.team ) && var_1.owner.team != var_0.team )
            var_2 = 1;
    }
    else if ( var_0 != var_1.owner )
        var_2 = 1;

    if ( !var_2 )
    {
        var_0 _id_5F6A();
        return;
    }

    var_3 = 1000;

    if ( isdefined( var_1._id_9A51 ) )
        var_3 = var_1._id_9A51;

    var_0 dodamage( var_3, var_1.origin, var_1.owner, var_1, "MOD_CRUSH" );
}

_id_9A54( var_0, var_1 )
{
    var_2 = self._id_9A55;

    if ( isdefined( var_2 ) )
        var_2 = sortbydistance( var_2, var_0.origin );
    else
    {
        var_2 = getnodesinradius( var_0.origin, 300, 0, 200 );
        var_2 = sortbydistance( var_2, var_0.origin );
    }

    var_3 = ( 0.0, 0.0, -100.0 );
    var_0 _meth_8439();
    var_0 dontinterpolate();
    var_0 setorigin( var_0.origin + var_3 );

    for ( var_4 = 0; var_4 < var_2.size; var_4++ )
    {
        var_5 = var_2[var_4];
        var_6 = var_5.origin;

        if ( !precachestatusicon( var_6 ) )
            continue;

        if ( getstarttime( var_6 ) )
            continue;

        if ( var_0 getstance() == "prone" )
            var_0 setstance( "crouch" );

        var_0 setorigin( var_6 );
        return;
    }

    var_0 setorigin( var_0.origin - var_3 );

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( var_1 )
        var_0 _id_5F6A();
}

_id_9A58( var_0 )
{

}

_id_5F6A()
{
    if ( isdefined( level.ishorde ) && !isagent( self ) )
        return;

    if ( isdefined( level.moversuicidecustom ) )
        self [[ level.moversuicidecustom ]]();
    else
        maps\mp\_utility::_suicide();
}

_id_6BC9( var_0 )
{
    self endon( "death" );
    self endon( "stop_player_pushed_kill" );

    for (;;)
    {
        self waittill( "player_pushed", var_1, var_2 );

        if ( isplayer( var_1 ) || isagent( var_1 ) )
        {
            var_3 = length( var_2 );

            if ( var_3 >= var_0 )
                _id_9A57( var_1 );
        }
    }
}

_id_8EA6()
{
    self notify( "stop_player_pushed_kill" );
}

notify_moving_platform_invalid()
{
    var_0 = self _meth_8436( 0 );

    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.no_moving_platfrom_unlink ) && var_2.no_moving_platfrom_unlink )
            continue;

        var_2 unlink();
        var_2 notify( "invalid_parent", self );
    }
}

_id_6FEB( var_0, var_1 )
{
    if ( isdefined( var_1 ) && isdefined( var_1._id_6102 ) && var_1._id_6102 )
        return;

    if ( isdefined( var_0._id_6A3B ) )
        playfx( common_scripts\utility::getfx( "airdrop_crate_destroy" ), self.origin );

    if ( isdefined( var_0.deathoverridecallback ) )
        self thread [[ var_0.deathoverridecallback ]]( var_0 );
    else
        self delete();
}

_id_45BB( var_0 )
{
    for (;;)
    {
        self waittill( "touching_platform", var_1 );

        if ( isdefined( var_0._id_9403 ) && !self [[ var_0._id_9403 ]]( var_1 ) )
            continue;

        if ( isdefined( var_0._id_9C43 ) && var_0._id_9C43 )
        {
            if ( !self istouching( var_1 ) )
            {
                wait 0.05;
                continue;
            }
        }

        thread _id_6FEB( var_0, var_1 );
        break;
    }
}

_id_45BA( var_0 )
{
    self waittill( "invalid_parent", var_1 );

    if ( isdefined( var_0._id_4F94 ) )
        self thread [[ var_0._id_4F94 ]]( var_0 );
    else
        thread _id_6FEB( var_0, var_1 );
}

handle_moving_platforms( var_0 )
{
    self notify( "handle_moving_platforms" );
    self endon( "handle_moving_platforms" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stop_handling_moving_platforms" );

    if ( !isdefined( var_0 ) )
        var_0 = spawnstruct();

    if ( isdefined( var_0.endonstring ) )
        self endon( var_0.endonstring );

    if ( isdefined( var_0._id_5791 ) )
        self linkto( var_0._id_5791 );

    childthread _id_45BB( var_0 );
    childthread _id_45BA( var_0 );
}

stop_handling_moving_platforms()
{
    self notify( "stop_handling_moving_platforms" );
}

_id_5FA0( var_0 )
{

}
