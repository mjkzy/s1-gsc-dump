// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._threatdetection = spawnstruct();
    level._threatdetection._id_278C = "stencil_outline";
    level._threatdetection._id_0723 = getdvar( "threat_detection_highlight_style", level._threatdetection._id_278C );
    level thread onplayerconnect();
    level thread _id_A1F3();
}

_id_1C84( var_0 )
{
    if ( var_0 == level._threatdetection._id_0723 )
        return;

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2._threatdetection._id_5996 ) )
            var_2._threatdetection._id_5996 delete();

        if ( isdefined( var_2._threatdetection._id_5997 ) )
            var_2._threatdetection._id_5997 delete();

        if ( isdefined( var_2._id_5998 ) && isdefined( var_2._id_5998._id_3B32 ) )
        {
            foreach ( var_5, var_4 in var_2._id_5998._id_3B32 )
            {
                if ( isdefined( var_4._id_32B3 ) )
                    var_4._id_32B3 delete();

                if ( isdefined( var_4._id_3AB5 ) )
                    var_4._id_3AB5 delete();

                if ( isdefined( var_4._id_32B2 ) )
                    var_4._id_32B2 delete();

                if ( isdefined( var_4._id_3AB4 ) )
                    var_4._id_3AB4 delete();
            }
        }
    }

    foreach ( var_2 in level.players )
        var_2 _id_9317( var_0 );

    level._threatdetection._id_0723 = var_0;
}

_id_4124()
{
    var_0 = getdvar( "threat_detection_highlight_style", level._threatdetection._id_278C );

    if ( var_0 != level._threatdetection._id_0723 )
        _id_1C84( var_0 );

    return var_0;
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawned();
    }
}

_id_A1F3()
{
    for (;;)
    {
        level waittill( "spawned_agent", var_0 );
        var_0._threatdetection = spawnstruct();
        var_0._threatdetection.showlist = [];
        var_0 thread _id_6449();
    }
}

_id_6449()
{
    self endon( "death" );
    childthread _id_5ED2();
    childthread _id_1E8D();
}

onplayerspawned()
{
    self endon( "disconnect" );
    self._threatdetection = spawnstruct();
    self._threatdetection.showlist = [];
    self waittill( "spawned_player" );
    childthread _id_5ED2();
    childthread _id_1E8D();
    childthread _id_5ED3();

    for (;;)
    {
        self waittill( "spawned_player" );
        var_0 = _id_4124();

        if ( var_0 == "attached_glow" )
            _id_9E76( ::_id_9E7B, ::_id_3FCC, undefined );
    }
}

_id_5ED3()
{
    var_0 = newclienthudelem( self );
    var_0.x = 0;
    var_0.y = 0;
    var_0.alignx = "left";
    var_0.aligny = "top";
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    var_0 setshader( "paint_overlay", 640, 480 );
    var_0.alpha = 0.0;
    var_0.color = ( 0.0, 0.0, 0.0 );
    var_0.sort = -3;
    var_0.hidden = 1;
    var_1 = 0.5;
    var_2 = 0.3;

    for (;;)
    {
        if ( self._threatdetection.showlist.size != 0 )
        {
            if ( var_0.hidden )
            {
                var_0.hidden = 0;
                var_0 childthread _id_9329( var_1, var_2 );
            }
        }
        else if ( !var_0.hidden )
        {
            var_0.hidden = 1;
            var_0 notify( "stop_overlay_flash" );

            if ( var_0.alpha > 0.0 )
            {
                var_0 fadeovertime( var_2 );
                var_0.color = ( 0.0, 0.0, 0.0 );
                var_0.alpha = 0.0;
                wait(var_2);
            }
        }

        wait 0.05;
    }
}

_id_9329( var_0, var_1 )
{
    self endon( "stop_overlay_flash" );
    self fadeovertime( var_0 );
    self.color = ( 1.0, 1.0, 1.0 );
    self.alpha = 1.0;
}

_id_2725()
{
    for (;;)
    {
        var_0 = distance( self.origin, level.players[0].origin );
        thread common_scripts\utility::draw_line_for_time( level.players[0].origin, self.origin, 1, 1, 1, 0.3 );

        if ( isdefined( self._threatdetection._id_5996 ) )
            thread common_scripts\utility::draw_line_for_time( level.players[0].origin, self._threatdetection._id_5996.origin, 1, 1, 1, 0.3 );

        wait 0.3;
    }
}

_id_1E8D()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "death" );
        _id_73DE();
    }
}

_id_73DE()
{
    foreach ( var_1 in level.players )
    {
        foreach ( var_3 in var_1._threatdetection.showlist )
        {
            if ( var_3.player == self )
                var_3.endtime = 0;
        }
    }

    var_6 = _id_4124();

    if ( var_6 == "attached_glow" )
        _id_9E76( ::_id_9E7A, ::_id_3FCC, undefined );
}

detection_highlight_hud_effect_on( var_0, var_1, var_2 )
{
    var_3 = newclienthudelem( var_0 );

    if ( isdefined( var_2 ) && var_2 )
        var_3.color = ( 0.1, 0.0015, 0.0015 );
    else
        var_3.color = ( 1.0, 0.015, 0.015 );

    var_3.alpha = 1.0;
    var_3 _meth_83A4( var_1 );
    return var_3;
}

detection_highlight_hud_effect_off( var_0 )
{
    if ( isdefined( var_0 ) )
        var_0 destroy();
}

detection_highlight_hud_effect( var_0, var_1, var_2, var_3 )
{
    var_4 = detection_highlight_hud_effect_on( var_0, var_1, var_2 );

    if ( isdefined( var_3 ) )
        var_0 common_scripts\utility::waittill_notify_or_timeout( var_3, var_1 );
    else
        wait(var_1);

    detection_highlight_hud_effect_off( var_4 );
}

detection_grenade_hud_effect( var_0, var_1, var_2, var_3 )
{
    var_4 = newhudelem();
    var_4.x = var_1[0];
    var_4.y = var_1[1];
    var_4.z = var_1[2];
    var_4.color = ( getdvarfloat( "scr_paintexplosionred" ), getdvarfloat( "scr_paintexplosiongreen" ), getdvarfloat( "scr_paintexplosionblue" ) );
    var_4.alpha = getdvarfloat( "scr_paintexplosionalpha" );
    var_5 = getdvarint( "paintexplosionwidth" );
    var_4 _meth_83A3( int( var_3 + var_5 / 2 ), int( var_5 ), var_2 + 0.05 );
    wait(var_2);

    if ( isdefined( var_4 ) )
        var_4 destroy();
}

_id_34B1( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;

    if ( isdefined( var_3 ) )
        var_5 = newclienthudelem( var_3 );
    else
        var_5 = newhudelem();

    var_5.x = var_0[0];
    var_5.y = var_0[1];
    var_5.z = var_0[2];

    if ( isdefined( var_4 ) && var_4 )
        var_5.color = ( 0.05, 0.05, 0.05 );
    else
        var_5.color = ( 0.8, 0.8, 0.8 );

    var_5.alpha = 0.05;
    var_6 = getdvarint( "scr_exopingwidth", 100 );
    var_5 _meth_83A3( int( var_2 ), int( var_6 ), var_1 + 0.05 );
    wait(var_1);

    if ( isdefined( var_5 ) )
        var_5 destroy();
}

addthreatevent( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isalive( self ) )
        return;

    var_6 = gettime();
    var_7 = var_6 + var_1 * 1000;
    var_8 = var_7 - 9 * ( var_1 * 1000 ) / 10;
    var_9 = _id_4124();

    if ( var_7 - var_8 < 250 )
        var_8 = 250 + var_6;

    if ( var_9 == "model" )
        var_8 = var_6;
    else if ( var_9 == "vfx_model" )
        var_8 = var_6;
    else if ( var_9 == "attached_glow" )
        var_8 = var_7;
    else if ( var_9 == "stencil_outline" )
        var_8 = var_7;

    foreach ( var_11 in var_0 )
    {
        var_12 = 0;

        foreach ( var_14 in self._threatdetection.showlist )
        {
            if ( var_14.player == var_11 )
            {
                if ( var_7 > var_14.endtime )
                {
                    var_14.endtime = var_7;
                    var_14._id_5894 = var_8;
                    var_14.eventtype = var_2;
                }

                var_12 = 1;
                break;
            }
        }

        if ( !var_12 )
        {
            var_16 = self._threatdetection.showlist.size;
            self._threatdetection.showlist[var_16] = spawnstruct();
            self._threatdetection.showlist[var_16].player = var_11;
            self._threatdetection.showlist[var_16].endtime = var_7;
            self._threatdetection.showlist[var_16]._id_5894 = var_8;
            self._threatdetection.showlist[var_16].eventtype = var_2;

            if ( isplayer( self ) )
            {
                if ( !isdefined( var_5 ) || var_5 )
                    self playlocalsound( "flag_spawned" );
            }
        }
    }

    if ( isplayer( self ) )
    {
        if ( var_4 )
            _id_9E76( ::_id_9E7F, ::_id_3FA2, undefined );

        if ( var_3 )
            _id_9E76( ::_id_9E7F, ::_id_3FCC, undefined );
    }
}

_id_8EFF( var_0 )
{
    foreach ( var_2 in self._threatdetection.showlist )
    {
        if ( var_2.eventtype == var_0 )
            var_2.endtime = 0;
    }

    var_4 = _id_4124();

    if ( var_4 == "attached_glow" )
        _id_9E76( ::_id_9E7A, ::_id_3FCC, undefined );
}

_id_9E76( var_0, var_1, var_2 )
{
    var_3 = _id_4124();

    if ( var_3 == "glow" )
    {
        foreach ( var_6, var_5 in self._id_5998._id_3B32 )
            [[ var_0 ]]( [[ var_1 ]]( var_5 ), var_2, level._threatdetection._id_3B2C[var_6][0] );
    }
    else if ( var_3 == "model" )
        [[ var_0 ]]( [[ var_1 ]]( self._threatdetection ), var_2, "tag_origin" );
    else if ( var_3 == "vfx_model" )
        [[ var_0 ]]( [[ var_1 ]]( self._threatdetection ), var_2, "tag_origin" );
    else if ( var_3 == "attached_glow" )
    {
        foreach ( var_6, var_5 in self._id_5998._id_3B32 )
            [[ var_0 ]]( [[ var_1 ]]( var_5 ), var_2, level._threatdetection._id_3B2C[var_6][0] );
    }
    else if ( var_3 == "stencil_outline" )
        [[ var_0 ]]( self, var_2, "tag_origin" );
    else
    {

    }
}

_id_9E7B( var_0, var_1, var_2 )
{
    var_0 unlink();
    var_0.origin = self gettagorigin( var_2 );
    var_0.angles = self gettagangles( var_2 );
    var_0 linkto( self, var_2 );
    wait 0.05;
    playfxontag( var_0._id_3B21, var_0, "tag_origin" );
}

_id_9E7A( var_0, var_1, var_2 )
{
    var_3 = _id_4124();

    if ( var_3 == "attached_glow" )
        stopfxontag( var_0._id_3B21, var_0, "tag_origin" );
}

_id_9E7F( var_0, var_1, var_2 )
{
    var_3 = _id_4124();
    var_0.origin = self gettagorigin( var_2 );
    var_0.angles = self gettagangles( var_2 );

    if ( var_3 == "glow" )
        triggerfx( var_0 );
    else if ( var_3 == "model" )
    {
        var_4 = "mp_hud_" + self getstance() + "_char";
        var_5 = var_0 != self._threatdetection._id_5997;

        if ( var_5 )
            var_4 += "_hostile";

        var_6 = var_0.model;

        if ( var_4 != var_6 )
        {
            var_0 setmodel( var_4 );
            return;
        }
    }
    else if ( var_3 == "vfx_model" )
    {
        switch ( self getstance() )
        {
            case "prone":
                var_4 = "threat_detect_model_prone";
                break;
            case "crouch":
                var_4 = "threat_detect_model_crouch";
                break;
            case "stand":
            default:
                var_4 = "threat_detect_model_stand";
                break;
        }

        var_5 = var_0 != self._threatdetection._id_5997;
        var_6 = self._threatdetection._id_3A77;

        if ( var_5 )
        {
            var_4 += "_hostile";
            var_6 = self._threatdetection._id_4A30;
        }

        if ( var_6 != var_4 )
        {
            var_7 = anglestoforward( self.angles );
            var_8 = anglestoup( self.angles );

            if ( var_5 )
            {
                self._threatdetection._id_5996 delete();
                self._threatdetection._id_5996 = spawnfx( common_scripts\utility::getfx( var_4 ), self.origin, var_7, var_8 );
                self._threatdetection._id_5996 hide();
                self._threatdetection._id_4A30 = var_4;
            }
            else
            {
                self._threatdetection._id_5997 delete();
                self._threatdetection._id_5997 = spawnfx( common_scripts\utility::getfx( var_4 ), self.origin, var_7, var_8 );
                self._threatdetection._id_5997 hide();
                self._threatdetection._id_3A77 = var_4;
            }
        }

        if ( var_5 )
        {
            triggerfx( self._threatdetection._id_5996 );
            return;
        }

        triggerfx( self._threatdetection._id_5997 );
        return;
    }
    else
    {
        if ( var_3 == "attached_glow" )
            return;

        if ( var_3 == "stencil_outline" )
            return;

        return;
        return;
    }
}

_id_3FCC( var_0 )
{
    var_1 = _id_4124();

    if ( var_1 == "glow" )
        return var_0._id_32B3;
    else if ( var_1 == "model" )
        return var_0._id_5996;
    else if ( var_1 == "vfx_model" )
        return var_0._id_5996;
    else if ( var_1 == "attached_glow" )
        return var_0;
    else if ( var_1 == "stencil_outline" )
        return var_0;
    else
    {

    }
}

_id_3FA2( var_0 )
{
    var_1 = _id_4124();

    if ( var_1 == "glow" )
        return var_0._id_3AB5;
    else if ( var_1 == "model" )
        return var_0._id_5997;
    else if ( var_1 == "vfx_model" )
        return var_0._id_5997;
    else
    {

    }
}

_id_3FA1( var_0 )
{
    var_1 = _id_4124();

    if ( var_1 == "glow" )
        return var_0._id_3AB4;
    else if ( var_1 == "model" )
        return var_0._id_5997;
    else if ( var_1 == "vfx_model" )
        return var_0._id_5997;
    else
    {

    }
}

_id_3FCB( var_0 )
{
    var_1 = _id_4124();

    if ( var_1 == "glow" )
        return var_0._id_32B2;
    else if ( var_1 == "model" )
        return var_0._id_5996;
    else if ( var_1 == "vfx_model" )
        return var_0._id_5996;
    else if ( var_1 == "attached_glow" )
        return var_0;
    else if ( var_1 == "stencil_outline" )
        return var_0;
    else
    {

    }
}

_id_9E77( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
        var_4 hide();
}

_id_06D7( var_0 )
{
    return [ var_0._id_3AB5, var_0._id_32B3, var_0._id_3AB4, var_0._id_32B2 ];
}

_id_4051( var_0 )
{
    return vectornormalize( common_scripts\utility::flat_origin( var_0 ) );
}

_id_5ED2()
{
    _id_9317( _id_4124() );
    var_0 = ( 0.0, 0.0, 32.0 );
    var_1 = 0;

    for (;;)
    {
        wait 0.05;
        var_2 = gettime();
        var_3 = 0;

        foreach ( var_5 in self._threatdetection.showlist )
        {
            if ( var_5.endtime >= var_2 )
            {
                if ( !isdefined( var_5.player ) )
                {
                    self._threatdetection.showlist = common_scripts\utility::array_remove( self._threatdetection.showlist, var_5 );
                    continue;
                }

                var_5._id_5893 = 0;
                var_6 = _id_4051( anglestoforward( var_5.player.angles ) );
                var_7 = _id_4051( self.origin - var_5.player.origin );
                var_8 = vectordot( var_7, var_6 );

                if ( var_8 < 0 )
                    continue;

                if ( _id_1CD3( var_5 ) )
                {
                    var_5._id_5893 = 1;

                    if ( var_5._id_5894 <= var_2 )
                    {
                        self._threatdetection.showlist = common_scripts\utility::array_remove( self._threatdetection.showlist, var_5 );
                        continue;
                    }
                }

                var_3 = 1;
                continue;
            }

            self._threatdetection.showlist = common_scripts\utility::array_remove( self._threatdetection.showlist, var_5 );
        }

        var_10 = _id_4124();

        if ( !var_1 )
        {
            var_1 = 1;

            if ( var_10 == "glow" )
            {
                foreach ( var_13, var_12 in self._id_5998._id_3B32 )
                {
                    var_12._id_32B3 hide();
                    var_12._id_3AB5 hide();
                    var_12._id_32B2 hide();
                    var_12._id_3AB4 hide();
                }
            }
            else if ( var_10 == "model" )
            {
                self._threatdetection._id_5997 hide();
                self._threatdetection._id_5996 hide();
            }
            else if ( var_10 == "vfx_model" )
            {
                self._threatdetection._id_5997 hide();
                self._threatdetection._id_5996 hide();
            }
            else if ( var_10 == "attached_glow" )
            {
                foreach ( var_13, var_5 in self._id_5998._id_3B32 )
                {
                    stopfxontag( var_5._id_3B21, var_5, "tag_origin" );
                    var_5 hide();
                }
            }
            else if ( var_10 == "stencil_outline" )
                self clearthreatdetected();
            else
            {

            }
        }

        if ( !var_3 )
            continue;

        foreach ( var_16 in self._threatdetection.showlist )
        {
            if ( var_16._id_5893 )
            {
                _id_852B( var_16.player, ::_id_3FA1, ::_id_3FCB, ::_id_9E7E );
                _id_6F13( var_1, var_10, var_16.player );
                var_1 = 0;
                continue;
            }

            var_17 = bullettrace( var_16.player.origin + var_0, self.origin + var_0, 1, var_16.player );

            if ( var_17["fraction"] < 1 && !isplayer( var_17["entity"] ) )
            {
                _id_852B( var_16.player, ::_id_3FA2, ::_id_3FCC, ::_id_9E7D );
                _id_6F13( var_1, var_10, var_16.player );
                var_1 = 0;
            }
        }
    }
}

_id_6F13( var_0, var_1, var_2 )
{
    if ( var_0 )
    {
        if ( var_1 == "attached_glow" )
            _id_852B( var_2, ::_id_3FA1, ::_id_3FCB, ::_id_9E7C );
    }
}

_id_9E7C( var_0, var_1, var_2 )
{
    playfxontag( var_0._id_3B21, var_0, "tag_origin" );
}

_id_1CD3( var_0 )
{
    if ( bullettracepassed( var_0.player geteye(), self geteye(), 0, var_0.player ) )
        return 1;

    return 0;
}

_id_9317( var_0 )
{
    var_1 = spawnstruct();
    var_1._id_3B32 = [];

    if ( var_0 == "glow" )
    {
        foreach ( var_5, var_3 in level._threatdetection._id_3B2C )
        {
            var_4 = spawnstruct();
            var_4.origin = self gettagorigin( var_3[0] );
            var_4.angles = self gettagangles( var_3[0] );
            var_4._id_32B3 = spawnfx( var_3[1], var_4.origin );
            triggerfx( var_4._id_32B3 );
            var_4._id_32B3 hide();
            var_4._id_32B2 = spawnfx( var_3[3], var_4.origin );
            triggerfx( var_4._id_32B2 );
            var_4._id_32B2 hide();
            var_4._id_3AB5 = spawnfx( var_3[2], var_4.origin );
            triggerfx( var_4._id_3AB5 );
            var_4._id_3AB5 hide();
            var_4._id_3AB4 = spawnfx( var_3[4], var_4.origin );
            triggerfx( var_4._id_3AB4 );
            var_4._id_3AB4 hide();
            var_1._id_3B32[var_5] = var_4;
        }

        self._id_5998 = var_1;
    }
    else if ( var_0 == "model" )
    {
        var_6 = spawn( "script_model", self.origin );
        var_6.origin = self.origin;
        var_6.angles = self.angles;
        var_6 setmodel( level._threatdetection._id_3AB6 );
        var_6 setcontents( 0 );
        self._threatdetection._id_5997 = var_6;
        var_6 = spawn( "script_model", self.origin );
        var_6.origin = self.origin;
        var_6.angles = self.angles;
        var_6 setmodel( level._threatdetection._id_4A31 );
        var_6 setcontents( 0 );
        self._threatdetection._id_5996 = var_6;
    }
    else if ( var_0 == "vfx_model" )
    {
        self._threatdetection._id_5997 = spawnstruct();
        self._threatdetection._id_5997 = spawnfx( common_scripts\utility::getfx( "threat_detect_model_stand" ), self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
        self._threatdetection._id_3A77 = "threat_detect_model_stand";
        self._threatdetection._id_5996 = spawnstruct();
        self._threatdetection._id_5996 = spawnfx( common_scripts\utility::getfx( "threat_detect_model_stand_hostile" ), self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
        self._threatdetection._id_4A30 = "threat_detect_model_stand_hostile";
    }
    else if ( var_0 == "attached_glow" )
    {
        foreach ( var_5, var_3 in level._threatdetection._id_3B2C )
        {
            var_8 = common_scripts\utility::spawn_tag_origin();
            var_8 show();
            var_8.origin = self gettagorigin( var_3[0] );
            var_8.angles = self gettagangles( var_3[0] );
            var_8 linkto( self, var_3[0] );
            var_8._id_3B21 = var_3[1];
            var_1._id_3B32[var_5] = var_8;
        }

        self._id_5998 = var_1;
    }
    else
    {
        if ( var_0 == "stencil_outline" )
            return;

        return;
    }
}

_id_9E7E( var_0, var_1, var_2 )
{
    _id_9E7F( var_0, var_1, var_2 );
    _id_9E7D( var_0, var_1, var_2 );
}

_id_9E7D( var_0, var_1, var_2 )
{
    var_3 = _id_4124();

    if ( var_3 == "stencil_outline" )
        var_0 threatdetectedtoplayer( var_1 );
    else
        var_0 showtoplayer( var_1 );
}

_id_852B( var_0, var_1, var_2, var_3 )
{
    if ( var_0 == self )
        return;

    var_4 = var_2;

    if ( ( level.teambased || level.multiteambased ) && var_0.team == self.team )
        var_4 = var_1;
    else if ( var_0 == self )
        var_4 = var_1;

    _id_9E76( var_3, var_4, var_0 );
}
