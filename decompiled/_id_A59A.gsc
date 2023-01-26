// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_7E55( var_0, var_1 )
{
    var_2 = undefined;
    var_0 = tolower( var_0 );
    var_3["friendly"] = 3;
    var_3["enemy"] = 4;
    var_3["objective"] = 5;
    var_3["neutral"] = 0;
    var_2 = var_3[var_0];
    self _meth_83FA( var_2, var_1 );
}

_id_5009()
{
    if ( issplitscreen() || getdvar( "coop" ) == "1" )
        return 1;

    return 0;
}

_id_500A()
{
    if ( issplitscreen() )
        return 0;

    if ( !_id_5009() )
        return 0;

    return 1;
}

_id_505F( var_0 )
{
    if ( var_0 _id_32DB( "laststand_downed" ) )
        return var_0 _id_32D7( "laststand_downed" );

    if ( isdefined( var_0.laststand ) )
        return var_0.laststand;

    return !isalive( var_0 );
}

_id_5060( var_0 )
{
    if ( !isdefined( var_0._id_2D90 ) )
        return 0;

    return var_0._id_2D90;
}

_id_5369( var_0 )
{
    if ( _id_55DE() )
    {
        if ( isdefined( level._id_55DF ) )
            return var_0 [[ level._id_55DF ]]();
    }

    return 0;
}

_id_5084()
{
    return _id_5080() && getdvarint( "so_survival" ) > 0;
}

_id_55DE()
{
    return isdefined( level._id_55E1 ) && level._id_55E1 > 0;
}

_id_5080()
{
    return getdvarint( "specialops" ) >= 1;
}

_id_21A3( var_0, var_1 )
{
    var_2 = "";

    if ( var_0 < 0 )
        var_2 += "-";

    var_0 = _id_760F( var_0, 1, 0 );
    var_3 = var_0 * 100;
    var_3 = int( var_3 );
    var_3 = abs( var_3 );
    var_4 = var_3 / 6000;
    var_4 = int( var_4 );
    var_2 += var_4;
    var_5 = var_3 / 100;
    var_5 = int( var_5 );
    var_5 -= var_4 * 60;

    if ( var_5 < 10 )
        var_2 += ( ":0" + var_5 );
    else
        var_2 += ( ":" + var_5 );

    if ( isdefined( var_1 ) && var_1 )
    {
        var_6 = var_3;
        var_6 -= var_4 * 6000;
        var_6 -= var_5 * 100;
        var_6 = int( var_6 / 10 );
        var_2 += ( "." + var_6 );
    }

    return var_2;
}

_id_760F( var_0, var_1, var_2 )
{
    var_1 = int( var_1 );

    if ( var_1 < 0 || var_1 > 4 )
        return var_0;

    var_3 = 1;

    for ( var_4 = 1; var_4 <= var_1; var_4++ )
        var_3 *= 10;

    var_5 = var_0 * var_3;

    if ( !isdefined( var_2 ) || var_2 )
        var_5 = floor( var_5 );
    else
        var_5 = ceil( var_5 );

    var_0 = var_5 / var_3;
    return var_0;
}

_id_7610( var_0, var_1, var_2 )
{
    var_3 = var_0 / 1000;
    var_3 = _id_760F( var_3, var_1, var_2 );
    var_0 = var_3 * 1000;
    return int( var_0 );
}

_id_7EFA( var_0, var_1 )
{
    if ( _id_A59B::_id_4D71( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    visionsetnaked( var_0, var_1 );
    setdvar( "vision_set_current", var_0 );
}

_id_7EFB( var_0, var_1 )
{
    if ( _id_A59B::_id_4D71( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    self visionsetnakedforplayer( var_0, var_1 );
}

_id_8FB0( var_0, var_1, var_2 )
{
    var_2 = int( var_2 * 20 );
    var_3 = [];

    for ( var_4 = 0; var_4 < 3; var_4++ )
        var_3[var_4] = ( var_0[var_4] - var_1[var_4] ) / var_2;

    var_5 = [];

    for ( var_4 = 0; var_4 < var_2; var_4++ )
    {
        wait 0.05;

        for ( var_6 = 0; var_6 < 3; var_6++ )
            var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;

        setsunlight( var_5[0], var_5[1], var_5[2] );
    }

    setsunlight( var_1[0], var_1[1], var_1[2] );
}

_id_32DF( var_0 )
{
    while ( isdefined( self ) && !self._id_32D7[var_0] )
        self waittill( var_0 );
}

_id_32E2( var_0 )
{
    while ( isdefined( self ) && !self._id_32D7[var_0] )
        self waittill( var_0 );
}

_id_32E0( var_0, var_1 )
{
    while ( isdefined( self ) )
    {
        if ( _id_32D7( var_0 ) )
            return;

        if ( _id_32D7( var_1 ) )
            return;

        common_scripts\utility::waittill_either( var_0, var_1 );
    }
}

_id_32E1( var_0, var_1 )
{
    var_2 = gettime();

    while ( isdefined( self ) )
    {
        if ( self._id_32D7[var_0] )
            break;

        if ( gettime() >= var_2 + var_1 * 1000 )
            break;

        _id_A59B::_id_32EC( var_0, var_1 );
    }
}

_id_32E3( var_0 )
{
    while ( isdefined( self ) && self._id_32D7[var_0] )
        self waittill( var_0 );
}

_id_32D8( var_0 )
{

}

_id_32E4( var_0, var_1 )
{
    while ( isdefined( self ) )
    {
        if ( !_id_32D7( var_0 ) )
            return;

        if ( !_id_32D7( var_1 ) )
            return;

        common_scripts\utility::waittill_either( var_0, var_1 );
    }
}

_id_32DC( var_0 )
{
    if ( !isdefined( self._id_32D7 ) )
    {
        self._id_32D7 = [];
        self._id_32E5 = [];
    }

    self._id_32D7[var_0] = 0;
}

_id_32DB( var_0 )
{
    if ( isdefined( self._id_32D7 ) && isdefined( self._id_32D7[var_0] ) )
        return 1;

    return 0;
}

_id_32DE( var_0, var_1 )
{
    self endon( "death" );
    wait(var_1);
    _id_32DD( var_0 );
}

_id_32DD( var_0 )
{
    self._id_32D7[var_0] = 1;
    self notify( var_0 );
}

_id_32D9( var_0, var_1 )
{
    if ( self._id_32D7[var_0] )
    {
        self._id_32D7[var_0] = 0;
        self notify( var_0 );
    }

    if ( isdefined( var_1 ) && var_1 )
        self._id_32D7[var_0] = undefined;
}

_id_32DA( var_0, var_1 )
{
    wait(var_1);
    _id_32D9( var_0 );
}

_id_32D7( var_0 )
{
    return self._id_32D7[var_0];
}

_id_3D04( var_0, var_1, var_2, var_3 )
{
    if ( !var_0.size )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = level.player;

    if ( !isdefined( var_3 ) )
        var_3 = -1;

    var_4 = var_1.origin;

    if ( isdefined( var_2 ) && var_2 )
        var_4 = var_1 geteye();

    var_5 = undefined;
    var_6 = var_1 getangles();
    var_7 = anglestoforward( var_6 );
    var_8 = -1;

    foreach ( var_10 in var_0 )
    {
        var_11 = vectortoangles( var_10.origin - var_4 );
        var_12 = anglestoforward( var_11 );
        var_13 = vectordot( var_7, var_12 );

        if ( var_13 < var_8 )
            continue;

        if ( var_13 < var_3 )
            continue;

        var_8 = var_13;
        var_5 = var_10;
    }

    return var_5;
}

_id_3CF7( var_0, var_1, var_2 )
{
    if ( !var_0.size )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = level.player;

    var_3 = var_1.origin;

    if ( isdefined( var_2 ) && var_2 )
        var_3 = var_1 geteye();

    var_4 = undefined;
    var_5 = var_1 getangles();
    var_6 = anglestoforward( var_5 );
    var_7 = -1;

    for ( var_8 = 0; var_8 < var_0.size; var_8++ )
    {
        var_9 = vectortoangles( var_0[var_8].origin - var_3 );
        var_10 = anglestoforward( var_9 );
        var_11 = vectordot( var_6, var_10 );

        if ( var_11 < var_7 )
            continue;

        var_7 = var_11;
        var_4 = var_8;
    }

    return var_4;
}

_id_3845( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_init( var_0 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_1 thread _id_A59B::_id_05AE( var_0, var_2 );
    return var_1;
}

_id_3846( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_init( var_0 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
        var_1[var_3] thread _id_A59B::_id_05AE( var_0, 0 );

    return var_1;
}

_id_383E( var_0, var_1 )
{
    wait(var_1);
    common_scripts\utility::flag_set( var_0 );
}

_id_3830( var_0, var_1 )
{
    wait(var_1);
    common_scripts\utility::flag_clear( var_0 );
}

_id_56BD()
{
    if ( _id_0CC3() )
        return;

    if ( level._id_5CDB )
        return;

    if ( common_scripts\utility::flag( "game_saving" ) )
        return;

    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
    {
        var_1 = level.players[var_0];

        if ( !isalive( var_1 ) )
            return;
    }

    common_scripts\utility::flag_set( "game_saving" );
    var_2 = "levelshots / autosave / autosave_" + level.script + "end";
    _func_083( "levelend", &"AUTOSAVE_AUTOSAVE", var_2, 1, 1 );
    common_scripts\utility::flag_clear( "game_saving" );
}

_id_075D( var_0, var_1, var_2 )
{
    level._id_05A7[var_0] = [];
    level._id_05A7[var_0]["func"] = var_1;
    level._id_05A7[var_0]["msg"] = var_2;
}

_id_7346( var_0 )
{
    level._id_05A7[var_0] = undefined;
}

_id_1154()
{
    thread _id_1145( "autosave_stealth", 8, 1 );
}

_id_1156()
{
    thread _id_1145( "autosave_stealth", 8, 1, 1 );
}

_id_1158()
{
    _id_A59B::_id_115D();
    thread _id_A59B::_id_115C();
}

_id_1143( var_0 )
{
    thread _id_1145( var_0 );
}

_id_1144( var_0 )
{
    thread _id_1145( var_0, undefined, undefined, 1 );
}

_id_1145( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level._id_24C2 ) )
        level._id_24C2 = 1;

    var_4 = "levelshots/autosave/autosave_" + level.script + level._id_24C2;
    var_5 = level _id_A50A::_id_988E( level._id_24C2, "autosave", var_4, var_1, var_2, var_3 );

    if ( isdefined( var_5 ) && var_5 )
        level._id_24C2++;
}

_id_1151( var_0, var_1 )
{
    thread _id_1145( var_0, var_1 );
}

_id_26AC( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 5;

    if ( isdefined( var_3 ) )
    {
        var_3 endon( "death" );
        var_1 = var_3.origin;
    }

    for ( var_4 = 0; var_4 < var_2 * 20; var_4++ )
    {
        if ( !isdefined( var_3 ) )
        {

        }
        else
        {

        }

        wait 0.05;
    }
}

_id_26AD( var_0, var_1 )
{
    self notify( "debug_message_ai" );
    self endon( "debug_message_ai" );
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 5;

    for ( var_2 = 0; var_2 < var_1 * 20; var_2++ )
        wait 0.05;
}

_id_26AE( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
    {
        level notify( var_0 + var_3 );
        level endon( var_0 + var_3 );
    }
    else
    {
        level notify( var_0 );
        level endon( var_0 );
    }

    if ( !isdefined( var_2 ) )
        var_2 = 5;

    for ( var_4 = 0; var_4 < var_2 * 20; var_4++ )
        wait 0.05;
}

_id_0331( var_0 )
{
    var_1 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_1.origin = level.player getorigin();
    var_1 setmodel( var_0 );
    var_1 delete();
}

_id_1FDF( var_0, var_1 )
{
    return var_0 >= var_1;
}

_id_366E( var_0, var_1 )
{
    return var_0 <= var_1;
}

_id_3F37( var_0, var_1, var_2 )
{
    return _id_A59B::_id_20CB( var_0, var_1, var_2, ::_id_1FDF );
}

_id_3CFE( var_0, var_1, var_2 )
{
    var_3 = var_1[0];
    var_4 = distance( var_0, var_3 );

    for ( var_5 = 0; var_5 < var_1.size; var_5++ )
    {
        var_6 = distance( var_0, var_1[var_5] );

        if ( var_6 >= var_4 )
            continue;

        var_4 = var_6;
        var_3 = var_1[var_5];
    }

    if ( !isdefined( var_2 ) || var_4 <= var_2 )
        return var_3;

    return undefined;
}

_id_3D67( var_0, var_1 )
{
    if ( var_1.size < 1 )
        return;

    var_2 = distance( var_1[0] getorigin(), var_0 );
    var_3 = var_1[0];

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        var_5 = distance( var_1[var_4] getorigin(), var_0 );

        if ( var_5 < var_2 )
            continue;

        var_2 = var_5;
        var_3 = var_1[var_4];
    }

    return var_3;
}

_id_3ECD( var_0, var_1, var_2 )
{
    var_3 = [];

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        if ( distance( var_1[var_4].origin, var_0 ) <= var_2 )
            var_3[var_3.size] = var_1[var_4];
    }

    return var_3;
}

_id_3E10( var_0, var_1, var_2 )
{
    var_3 = [];

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        if ( distance( var_1[var_4].origin, var_0 ) > var_2 )
            var_3[var_3.size] = var_1[var_4];
    }

    return var_3;
}

_id_3CF8( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 9999999;

    if ( var_1.size < 1 )
        return;

    var_3 = undefined;

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        if ( !isalive( var_1[var_4] ) )
            continue;

        var_5 = distance( var_1[var_4].origin, var_0 );

        if ( var_5 >= var_2 )
            continue;

        var_2 = var_5;
        var_3 = var_1[var_4];
    }

    return var_3;
}

_id_3D93( var_0, var_1, var_2 )
{
    if ( !var_2.size )
        return;

    var_3 = undefined;
    var_4 = vectortoangles( var_1 - var_0 );
    var_5 = anglestoforward( var_4 );
    var_6 = -1;

    foreach ( var_8 in var_2 )
    {
        var_4 = vectortoangles( var_8.origin - var_0 );
        var_9 = anglestoforward( var_4 );
        var_10 = vectordot( var_5, var_9 );

        if ( var_10 < var_6 )
            continue;

        var_6 = var_10;
        var_3 = var_8;
    }

    return var_3;
}

_id_3CF6( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 9999999;

    if ( var_1.size < 1 )
        return;

    var_3 = undefined;

    foreach ( var_7, var_5 in var_1 )
    {
        var_6 = distance( var_5.origin, var_0 );

        if ( var_6 >= var_2 )
            continue;

        var_2 = var_6;
        var_3 = var_7;
    }

    return var_3;
}

_id_3CF4( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        return undefined;

    var_3 = 0;

    if ( isdefined( var_2 ) && var_2.size )
    {
        var_4 = [];

        for ( var_5 = 0; var_5 < var_1.size; var_5++ )
            var_4[var_5] = 0;

        for ( var_5 = 0; var_5 < var_1.size; var_5++ )
        {
            for ( var_6 = 0; var_6 < var_2.size; var_6++ )
            {
                if ( var_1[var_5] == var_2[var_6] )
                    var_4[var_5] = 1;
            }
        }

        var_7 = 0;

        for ( var_5 = 0; var_5 < var_1.size; var_5++ )
        {
            if ( !var_4[var_5] && isdefined( var_1[var_5] ) )
            {
                var_7 = 1;
                var_3 = distance( var_0, var_1[var_5].origin );
                var_8 = var_5;
                var_5 = var_1.size + 1;
            }
        }

        if ( !var_7 )
            return undefined;
    }
    else
    {
        for ( var_5 = 0; var_5 < var_1.size; var_5++ )
        {
            if ( isdefined( var_1[var_5] ) )
            {
                var_3 = distance( var_0, var_1[0].origin );
                var_8 = var_5;
                var_5 = var_1.size + 1;
            }
        }
    }

    var_8 = undefined;

    for ( var_5 = 0; var_5 < var_1.size; var_5++ )
    {
        if ( isdefined( var_1[var_5] ) )
        {
            var_4 = 0;

            if ( isdefined( var_2 ) )
            {
                for ( var_6 = 0; var_6 < var_2.size; var_6++ )
                {
                    if ( var_1[var_5] == var_2[var_6] )
                        var_4 = 1;
                }
            }

            if ( !var_4 )
            {
                var_9 = distance( var_0, var_1[var_5].origin );

                if ( var_9 <= var_3 )
                {
                    var_3 = var_9;
                    var_8 = var_5;
                }
            }
        }
    }

    if ( isdefined( var_8 ) )
        return var_1[var_8];
    else
        return undefined;
}

_id_3CFC( var_0 )
{
    if ( level.players.size == 1 )
        return level.player;

    var_1 = common_scripts\utility::getclosest( var_0, level.players );
    return var_1;
}

_id_3CFD( var_0 )
{
    if ( level.players.size == 1 )
        return level.player;

    var_1 = _id_3E31();
    var_2 = common_scripts\utility::getclosest( var_0, var_1 );
    return var_2;
}

_id_3E31()
{
    var_0 = [];

    foreach ( var_2 in level.players )
    {
        if ( _id_505F( var_2 ) )
            continue;

        var_0[var_0.size] = var_2;
    }

    return var_0;
}

_id_3CEC( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
        var_3 = _func_0D6( var_1 );
    else
        var_3 = _func_0D6();

    if ( var_3.size == 0 )
        return undefined;

    if ( isdefined( var_2 ) )
        var_3 = common_scripts\utility::array_remove_array( var_3, var_2 );

    return common_scripts\utility::getclosest( var_0, var_3 );
}

_id_3CED( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
        var_3 = _func_0D6( var_1 );
    else
        var_3 = _func_0D6();

    if ( var_3.size == 0 )
        return undefined;

    return _id_3CF4( var_0, var_3, var_2 );
}

_id_3E3B( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = distance( var_0, var_1 );

    var_3 = max( 0.01, var_3 );
    var_4 = vectornormalize( var_1 - var_0 );
    var_5 = var_2 - var_0;
    var_6 = vectordot( var_5, var_4 );
    var_6 /= var_3;
    var_6 = clamp( var_6, 0, 1 );
    return var_6;
}

_id_1A4F( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !_id_6E18( var_0 ) )
        return 0;

    if ( !sighttracepassed( self geteye(), var_0, var_1, self ) )
        return 0;

    return 1;
}

_id_6E18( var_0 )
{
    var_1 = anglestoforward( self.angles );
    var_2 = vectornormalize( var_0 - self.origin );
    var_3 = vectordot( var_1, var_2 );
    return var_3 > 0.766;
}

_id_8E9E()
{
    self notify( "stop_magic_bullet_shield" );

    if ( isai( self ) )
        self._id_0056 = 1;

    self._id_58D4 = undefined;
    self._id_0101 = 0;
    self notify( "internal_stop_magic_bullet_shield" );
}

_id_58D2()
{

}

_id_58D4( var_0 )
{
    if ( isai( self ) )
    {

    }
    else
        self.health = 100000;

    self endon( "internal_stop_magic_bullet_shield" );

    if ( isai( self ) )
        self._id_0056 = 0.1;

    self notify( "magic_bullet_shield" );
    self._id_58D4 = 1;
    self._id_0101 = 1;
    self._id_6156 = 1;
}

_id_2AB0()
{
    self._id_0007._id_2B17 = 1;
}

_id_30CE()
{
    self._id_0007._id_2B17 = 0;
}

_id_30A3()
{
    self._id_85B3 = undefined;
}

_id_2A7E()
{
    self._id_85B3 = 1;
}

_id_27F1()
{
    _id_58D4( 1 );
}

_id_3DA3()
{
    return self.ignoreme;
}

_id_7E58( var_0 )
{
    self.ignoreme = var_0;
}

_id_7E57( var_0 )
{
    self._id_01FC = var_0;
}

_id_7E59( var_0 )
{
    self._id_4BB8 = var_0;
}

_id_7E1A( var_0 )
{
    self._id_017C = var_0;
}

_id_3E14()
{
    return self._id_02EA;
}

_id_7E8B( var_0 )
{
    self._id_02EA = var_0;
}

_id_4BA3( var_0 )
{
    self notify( "new_ignore_me_timer" );
    self endon( "new_ignore_me_timer" );
    self endon( "death" );

    if ( !isdefined( self._id_4BA4 ) )
        self._id_4BA4 = self.ignoreme;

    var_1 = _func_0D6( "bad_guys" );

    foreach ( var_3 in var_1 )
    {
        if ( !isalive( var_3._id_0143 ) )
            continue;

        if ( var_3._id_0143 != self )
            continue;

        var_3 _meth_8166();
    }

    self.ignoreme = 1;
    wait(var_0);
    self.ignoreme = self._id_4BA4;
    self._id_4BA4 = undefined;
}

_id_280C( var_0 )
{
    common_scripts\_exploder::_id_280D( var_0 );
}

_id_484C( var_0 )
{
    common_scripts\_exploder::_id_484D( var_0 );
}

_id_84C8( var_0 )
{
    common_scripts\_exploder::_id_84C9( var_0 );
}

_id_8E78( var_0 )
{
    common_scripts\_exploder::_id_8E79( var_0 );
}

_id_3D5D( var_0 )
{
    return common_scripts\_exploder::_id_3D5E( var_0 );
}

_id_38ED( var_0 )
{
    _id_A577::_id_38EF( var_0 );
}

_id_7DB3( var_0, var_1 )
{
    _id_A5DD::_id_123A( var_0, var_1 );
}

_id_3990( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 4;

    thread _id_3991( var_0, var_1, var_2, var_3 );
}

#using_animtree("generic_human");

_id_6611()
{
    if ( isdefined( self._id_0007._id_253B ) )
    {
        self._id_0007._id_0CD8["crawl"] = self._id_0007._id_253B["crawl"];
        self._id_0007._id_0CD8["death"] = self._id_0007._id_253B["death"];
        self._id_0007._id_238A = self._id_0007._id_253B["blood_fx_rate"];

        if ( isdefined( self._id_0007._id_253B["blood_fx"] ) )
            self._id_0007._id_2389 = self._id_0007._id_253B["blood_fx"];
    }

    self._id_0007._id_0CD8["stand_2_crawl"] = [];
    self._id_0007._id_0CD8["stand_2_crawl"][0] = %dying_stand_2_crawl_v3;

    if ( isdefined( self._id_613F ) )
        self._id_0007._id_6E57 = "prone";

    self _meth_818F( "face angle", self._id_0007._id_398F );
    self._id_0007._id_398F = undefined;
}

_id_3991( var_0, var_1, var_2, var_3 )
{
    self._id_39C0 = 1;
    self._id_0007._id_399B = var_1;
    self._id_6156 = 1;
    self._id_613F = var_3;
    self._id_0007._id_253B = var_2;
    self._id_238F = ::_id_6611;
    self.maxhealth = 100000;
    self.health = 100000;
    _id_30CE();

    if ( !isdefined( var_3 ) || var_3 == 0 )
        self._id_0007._id_398F = var_0 + 181.02;
    else
    {
        self._id_0007._id_398F = var_0;
        thread animscripts\notetracks::_id_61DB();
    }
}

_id_608F()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = self ishighjumping();

        if ( var_0 )
        {
            var_1 = common_scripts\utility::waittill_any_return( "exo_dodge", "player_boost_land", "disable_high_jump" );

            if ( !isdefined( var_1 ) || var_1 == "player_boost_land" || var_1 == "disable_high_jump" )
                continue;

            if ( !isdefined( self._id_608F ) )
                self._id_608F = 1;

            common_scripts\utility::waittill_any( "player_boost_land", "disable_high_jump" );
            waitframe();
            self._id_608F = undefined;
        }

        waitframe();
    }
}

_id_1CD4()
{
    if ( getdvar( "mapname", "undefined" ) != "sanfran_b" )
        return;

    if ( !isdefined( level.player._id_594A ) || !level.player._id_594A )
        level.player._id_594A = 1;

    wait 2.0;
    level.player._id_594A = undefined;
}

_id_5DA6( var_0, var_1, var_2 )
{
    if ( var_1 != "MOD_GRENADE" )
    {
        var_0._id_3CA9 = undefined;
        return;
    }

    if ( !isdefined( var_0._id_3CA9 ) )
        var_0._id_3CA9 = 1;
    else
        var_0._id_3CA9++;

    if ( var_0._id_3CA9 == 4 )
        _id_41DA( "SMART_GRENADE_KILL" );

    wait 0.1;
    var_0._id_3CA9 = undefined;
}

_id_8C09()
{
    _id_0761( "axis", ::_id_5D95 );
    common_scripts\utility::array_thread( _func_0D6( "axis" ), ::_id_5D95 );
    level._id_43E7 = 0;
    level.player._id_334F = [];
}

_id_5D95()
{
    for (;;)
    {
        var_0 = undefined;
        self waittill( "grenade_fire", var_0, var_1 );
        var_0.unique_id = level._id_43E7;
        level._id_43E7++;
        var_0.owner = self.unique_id;
        var_0 thread _id_3350();
        var_0 thread _id_334F();
    }
}

_id_3350()
{
    var_0 = level.player;
    var_1 = self.unique_id;

    while ( isdefined( self ) )
    {
        var_2 = var_0.origin - self.origin;
        var_3 = _func_209( "fraggrenade" ) + 23;
        var_4 = squared( var_3 );
        var_5 = lengthsquared( var_2 );

        if ( var_5 > var_4 )
        {
            if ( isdefined( var_0._id_334F[self.unique_id] ) )
                var_0._id_334F[self.unique_id] = undefined;
        }
        else if ( !isdefined( var_0._id_334F[self.unique_id] ) )
        {
            if ( isdefined( self.owner ) )
                var_0._id_334F[self.unique_id] = 1;
        }

        waitframe();
    }

    if ( isdefined( var_0._id_334F[var_1] ) )
        var_0._id_334F[var_1] = undefined;
}

_id_334F()
{
    var_0 = level.player;

    while ( isdefined( self ) )
    {
        if ( isdefined( var_0._id_334F[self.unique_id] ) )
        {
            var_1 = level.player common_scripts\utility::waittill_any_timeout( 4, "exo_dodge" );

            if ( isdefined( var_1 ) && var_1 == "exo_dodge" )
                thread _id_1CC2();

            continue;
        }

        waitframe();
    }
}

_id_1CC2()
{
    level.player endon( "death" );

    while ( isdefined( self ) )
    {
        var_0 = level.player _id_A07B( 1, "damage" );

        if ( isdefined( var_0 ) && isarray( var_0 ) )
        {
            if ( var_0[5] == "MOD_GRENADE_SPLASH" && !isdefined( level.player._id_3351 ) )
            {
                if ( var_0[2].unique_id == self.owner && isdefined( level.player._id_334F[self.unique_id] ) )
                    level.player._id_3351 = 1;
            }

            continue;
        }

        waitframe();
    }

    if ( !isdefined( level.player._id_3351 ) )
        level.player _id_3352();
    else
        level.player._id_3351 = undefined;
}

_id_3352()
{
    var_0 = self _meth_820E( "ach_escapeArtist" ) + 1;

    if ( var_0 == 20 )
        _id_41DA( "GRENADE_DODGE" );

    self _meth_820F( "ach_escapeArtist", var_0 );
}

_id_A07B( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 != "death" )
        self endon( "death" );

    var_2 = spawnstruct();

    if ( isdefined( var_1 ) )
        childthread common_scripts\utility::waittill_string_parms( var_1, var_2 );

    var_2 childthread common_scripts\utility::_timeout( var_0 );
    var_2 waittill( "returned", var_3 );
    var_2 notify( "die" );
    return var_3;
}

_id_83CA()
{
    precacheshellshock( "default" );
    self waittill( "death" );

    if ( isdefined( self._id_8A25 ) )
        return;

    if ( getdvar( "r_texturebits" ) == "16" )
        return;

    self shellshock( "default", 3 );
}

_id_6D88()
{
    self endon( "death" );
    self endon( "stop_unresolved_collision_script" );
    _id_7439();
    childthread _id_6D89();

    for (;;)
    {
        if ( self._id_04DE )
        {
            self._id_04DE = 0;

            if ( self._id_9A50 >= 20 )
            {
                if ( isdefined( self._id_462F ) )
                    self [[ self._id_462F ]]();
                else
                    _id_278F();
            }
        }
        else
            _id_7439();

        wait 0.05;
    }
}

_id_6D89()
{
    for (;;)
    {
        self waittill( "unresolved_collision" );
        self._id_04DE = 1;
        self._id_9A50++;
    }
}

_id_7439()
{
    self._id_04DE = 0;
    self._id_9A50 = 0;
}

_id_278F()
{
    var_0 = getnodesinradiussorted( self.origin, 300, 0, 200, "Path" );

    if ( var_0.size )
    {
        self _meth_8439();
        self dontinterpolate();
        self setorigin( var_0[0].origin );
        _id_7439();
    }
    else
        self _meth_8052();
}

_id_8EA9()
{
    self notify( "stop_unresolved_collision_script" );
    _id_7439();
}

_id_2825( var_0, var_1 )
{
    var_0 endon( "death" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
    {
        if ( var_0 _meth_8079() )
            var_0 waittill( var_1 );

        var_0 delete();
    }
}

_id_5011()
{
    return issentient( self ) && !isalive( self );
}

play_sound_on_tag( var_0, var_1, var_2, var_3, var_4 )
{
    if ( _id_5011() )
        return;

    if ( !soundexists( var_0 ) )
        return;

    var_5 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_5 endon( "death" );
    thread _id_2825( var_5, "sounddone" );

    if ( isdefined( var_1 ) )
        var_5 linkto( self, var_1, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    else
    {
        var_5.origin = self.origin;
        var_5.angles = self.angles;
        var_5 linkto( self );
    }

    var_5 playsound( var_0, "sounddone" );

    if ( isdefined( var_2 ) )
    {
        if ( !isdefined( _id_A59B::_id_9FB4( var_5 ) ) )
            var_5 stopsounds();

        wait 0.05;
    }
    else
        var_5 waittill( "sounddone" );

    if ( isdefined( var_3 ) )
        self notify( var_3 );

    var_5 delete();
}

_id_69C3( var_0, var_1 )
{
    play_sound_on_tag( var_0, var_1, 1 );
}

_id_69C1( var_0, var_1 )
{
    play_sound_on_tag( var_0, undefined, undefined, var_1 );
}

_id_6973( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_4 endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( var_2 )
        thread common_scripts\utility::delete_on_death( var_4 );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( var_3 )
        thread _id_282B( var_4 );

    if ( isdefined( var_1 ) )
        var_4 linkto( self, var_1, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    else
    {
        var_4.origin = self.origin;
        var_4.angles = self.angles;
        var_4 linkto( self );
    }

    var_4 playloopsound( var_0 );
    self waittill( "stop sound" + var_0 );
    var_4 stoploopsound( var_0 );
    var_4 delete();
}

_id_282B( var_0 )
{
    var_0 endon( "death" );

    while ( isdefined( self ) )
        wait 0.05;

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_id_7802()
{
    var_0 = _func_0D6( "allies" );
    var_1 = 0;

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( isdefined( var_0[var_2]._id_79E9 ) )
            continue;

        game["character" + var_1] = var_0[var_2] codescripts\character::_id_77FF();
        var_1++;
    }

    game["total characters"] = var_1;
}

_id_88EB( var_0 )
{
    if ( !isalive( var_0 ) )
        return 1;

    if ( !isdefined( var_0._id_3795 ) )
        var_0 common_scripts\utility::waittill_either( "finished spawning", "death" );

    if ( isalive( var_0 ) )
        return 0;

    return 1;
}

_id_8947( var_0 )
{
    codescripts\character::_id_0331( var_0 );
    self waittill( "spawned", var_1 );

    if ( _id_88EB( var_1 ) )
        return;

    var_1 codescripts\character::_id_6096();
    var_1 codescripts\character::_id_57BA( var_0 );
}

_id_52E2( var_0, var_1 )
{
    iprintlnbold( var_0, var_1["key1"] );
}

_id_9E0C( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        _id_A51C::_id_2DE6( var_0 );
        wait 0.05;
    }
}

_id_0D61( var_0 )
{
    if ( isdefined( var_0 ) )
        self._id_0C72 = var_0;

    self _meth_8115( level._id_78AE[self._id_0C72] );
}

_id_0D68()
{
    if ( isarray( level._id_78B2[self._id_0C72] ) )
    {
        var_0 = randomint( level._id_78B2[self._id_0C72].size );
        self setmodel( level._id_78B2[self._id_0C72][var_0] );
    }
    else
        self setmodel( level._id_78B2[self._id_0C72] );
}

_id_88CB( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0.0, 0.0, 0.0 );

    var_3 = spawn( "script_model", var_1 );
    var_3._id_0C72 = var_0;
    var_3 _id_0D61();
    var_3 _id_0D68();

    if ( isdefined( var_2 ) )
        var_3.angles = var_2;

    return var_3;
}

_id_9805( var_0, var_1 )
{
    var_2 = getent( var_0, var_1 );

    if ( !isdefined( var_2 ) )
        return;

    var_2 waittill( "trigger", var_3 );
    level notify( var_0, var_3 );
    return var_3;
}

_id_9806( var_0 )
{
    return _id_9805( var_0, "targetname" );
}

_id_7E21( var_0, var_1 )
{
    thread _id_7E24( var_0, var_1, ::_id_A075, "set_flag_on_dead" );
}

_id_7E22( var_0, var_1 )
{
    thread _id_7E24( var_0, var_1, ::_id_A076, "set_flag_on_dead_or_dying" );
}

_id_7E25( var_0, var_1 )
{
    thread _id_7E24( var_0, var_1, ::_id_3091, "set_flag_on_spawned" );
}

_id_3091( var_0 )
{
    return;
}

_id_7E26( var_0, var_1 )
{
    self waittill( "spawned", var_2 );

    if ( _id_88EB( var_2 ) )
        return;

    var_0._id_08B4[var_0._id_08B4.size] = var_2;
    _id_32DD( var_1 );
}

_id_7E24( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4._id_08B4 = [];

    foreach ( var_7, var_6 in var_0 )
        var_6 _id_32DC( var_3 );

    common_scripts\utility::array_thread( var_0, ::_id_7E26, var_4, var_3 );

    foreach ( var_7, var_6 in var_0 )
        var_6 _id_32DF( var_3 );

    [[ var_2 ]]( var_4._id_08B4 );
    common_scripts\utility::flag_set( var_1 );
}

_id_7E28( var_0, var_1 )
{
    if ( !common_scripts\utility::flag( var_1 ) )
    {
        var_0 waittill( "trigger", var_2 );
        common_scripts\utility::flag_set( var_1 );
        return var_2;
    }
}

_id_7E27( var_0 )
{
    if ( common_scripts\utility::flag( var_0 ) )
        return;

    var_1 = getent( var_0, "targetname" );
    var_1 waittill( "trigger" );
    common_scripts\utility::flag_set( var_0 );
}

_id_5038( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_0[var_2] == var_1 )
            return 1;
    }

    return 0;
}

_id_A075( var_0, var_1, var_2 )
{
    var_10 = spawnstruct();

    if ( isdefined( var_2 ) )
    {
        var_10 endon( "thread_timed_out" );
        var_10 thread _id_A079( var_2 );
    }

    var_10.count = var_0.size;

    if ( isdefined( var_1 ) && var_1 < var_10.count )
        var_10.count = var_1;

    common_scripts\utility::array_thread( var_0, ::_id_A078, var_10 );

    while ( var_10.count > 0 )
        var_10 waittill( "waittill_dead guy died" );
}

_id_A076( var_0, var_1, var_2 )
{
    var_3 = [];

    foreach ( var_5 in var_0 )
    {
        if ( isalive( var_5 ) && !var_5._id_01FF )
            var_3[var_3.size] = var_5;
    }

    var_0 = var_3;
    var_7 = spawnstruct();

    if ( isdefined( var_2 ) )
    {
        var_7 endon( "thread_timed_out" );
        var_7 thread _id_A079( var_2 );
    }

    var_7.count = var_0.size;

    if ( isdefined( var_1 ) && var_1 < var_7.count )
        var_7.count = var_1;

    common_scripts\utility::array_thread( var_0, ::_id_A077, var_7 );

    while ( var_7.count > 0 )
        var_7 waittill( "waittill_dead_guy_dead_or_dying" );
}

_id_A078( var_0 )
{
    self waittill( "death" );
    var_0.count--;
    var_0 notify( "waittill_dead guy died" );
}

_id_A077( var_0 )
{
    common_scripts\utility::waittill_either( "death", "pain_death" );
    var_0.count--;
    var_0 notify( "waittill_dead_guy_dead_or_dying" );
}

_id_A079( var_0 )
{
    wait(var_0);
    self notify( "thread_timed_out" );
}

_id_A05D( var_0 )
{
    while ( level._id_054A[var_0]._id_89C6 || level._id_054A[var_0]._id_0949 )
        wait 0.25;
}

_id_A05E( var_0, var_1 )
{
    while ( level._id_054A[var_0]._id_89C6 + level._id_054A[var_0]._id_0949 > var_1 )
        wait 0.25;
}

_id_3CB3( var_0 )
{
    return level._id_054A[var_0]._id_89C6 + level._id_054A[var_0]._id_0949;
}

_id_3CB4( var_0 )
{
    return level._id_054A[var_0]._id_0949;
}

_id_3CB2( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level._id_054A[var_0]._id_08B4.size; var_2++ )
    {
        if ( !isalive( level._id_054A[var_0]._id_08B4[var_2] ) )
            continue;

        var_1[var_1.size] = level._id_054A[var_0]._id_08B4[var_2];
    }

    return var_1;
}

_id_A093( var_0 )
{
    self endon( "damage" );
    self endon( "death" );
    self waittillmatch( "single anim", var_0 );
}

_id_3DC3( var_0, var_1 )
{
    var_2 = _id_3DC4( var_0, var_1 );

    if ( var_2.size > 1 )
        return undefined;

    return var_2[0];
}

_id_3DC4( var_0, var_1 )
{
    var_2 = _func_0D7( "all", "all" );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( !isalive( var_5 ) )
            continue;

        switch ( var_1 )
        {
            case "targetname":
                if ( isdefined( var_5.targetname ) && var_5.targetname == var_0 )
                    var_3[var_3.size] = var_5;

                continue;
            case "script_noteworthy":
                if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == var_0 )
                    var_3[var_3.size] = var_5;

                continue;
        }
    }

    return var_3;
}

_id_3EB0( var_0, var_1 )
{
    var_2 = _id_3EB4( var_0, var_1 );

    if ( !var_2.size )
        return undefined;

    return var_2[0];
}

_id_3EB4( var_0, var_1 )
{
    var_2 = getentarray( var_0, var_1 );
    var_3 = [];
    var_4 = [];

    foreach ( var_6 in var_2 )
    {
        if ( var_6.code_classname != "script_vehicle" )
            continue;

        var_4[0] = var_6;

        if ( isspawner( var_6 ) )
        {
            if ( isdefined( var_6._id_5559 ) )
            {
                var_4[0] = var_6._id_5559;
                var_3 = _id_0CF2( var_3, var_4 );
            }

            continue;
        }

        var_3 = _id_0CF2( var_3, var_4 );
    }

    return var_3;
}

_id_3DC5( var_0, var_1, var_2 )
{
    var_3 = _id_3DC6( var_0, var_1, var_2 );

    if ( var_3.size > 1 )
        return undefined;

    return var_3[0];
}

_id_3DC6( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "all";

    var_3 = _func_0D7( "allies", var_2 );
    var_3 = common_scripts\utility::array_combine( var_3, _func_0D7( "axis", var_2 ) );
    var_4 = [];

    for ( var_5 = 0; var_5 < var_3.size; var_5++ )
    {
        switch ( var_1 )
        {
            case "targetname":
                if ( isdefined( var_3[var_5].targetname ) && var_3[var_5].targetname == var_0 )
                    var_4[var_4.size] = var_3[var_5];

                continue;
            case "script_noteworthy":
                if ( isdefined( var_3[var_5].script_noteworthy ) && var_3[var_5].script_noteworthy == var_0 )
                    var_4[var_4.size] = var_3[var_5];

                continue;
        }
    }

    return var_4;
}

_id_3C5C( var_0, var_1 )
{
    if ( isdefined( level._id_3C5B[var_0] ) )
    {
        if ( level._id_3C5B[var_0] )
        {
            wait 0.05;

            if ( isalive( self ) )
                self notify( "gather_delay_finished" + var_0 + var_1 );

            return;
        }

        level waittill( var_0 );

        if ( isalive( self ) )
            self notify( "gather_delay_finished" + var_0 + var_1 );

        return;
    }

    level._id_3C5B[var_0] = 0;
    wait(var_1);
    level._id_3C5B[var_0] = 1;
    level notify( var_0 );

    if ( isalive( self ) )
        self notify( "gat    her_delay_finished" + var_0 + var_1 );
}

_id_3C5B( var_0, var_1 )
{
    thread _id_3C5C( var_0, var_1 );
    self waittill( "gather_delay_finished" + var_0 + var_1 );
}

_id_264E( var_0 )
{
    self waittill( "death" );
    level notify( var_0 );
}

_id_3F2C( var_0 )
{
    if ( var_0 == 0 )
        return "0";

    if ( var_0 == 1 )
        return "1";

    if ( var_0 == 2 )
        return "2";

    if ( var_0 == 3 )
        return "3";

    if ( var_0 == 4 )
        return "4";

    if ( var_0 == 5 )
        return "5";

    if ( var_0 == 6 )
        return "6";

    if ( var_0 == 7 )
        return "7";

    if ( var_0 == 8 )
        return "8";

    if ( var_0 == 9 )
        return "9";
}

_id_4004( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3];
        var_5 = var_4.script_linkname;

        if ( !isdefined( var_5 ) )
            continue;

        if ( !isdefined( var_1[var_5] ) )
            continue;

        var_2[var_2.size] = var_4;
    }

    return var_2;
}

_id_0CF3( var_0, var_1 )
{
    if ( !var_0.size )
        return var_1;

    if ( !var_1.size )
        return var_0;

    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3];
        var_2[var_4.script_linkname] = 1;
    }

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_4 = var_1[var_3];

        if ( isdefined( var_2[var_4.script_linkname] ) )
            continue;

        var_2[var_4.script_linkname] = 1;
        var_0[var_0.size] = var_4;
    }

    return var_0;
}

_id_0CF2( var_0, var_1 )
{
    if ( var_0.size == 0 )
        return var_1;

    if ( var_1.size == 0 )
        return var_0;

    var_2 = var_0;

    foreach ( var_4 in var_1 )
    {
        var_5 = 0;

        foreach ( var_7 in var_0 )
        {
            if ( var_7 == var_4 )
            {
                var_5 = 1;
                break;
            }
        }

        if ( var_5 )
            continue;
        else
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

_id_0CE7( var_0, var_1 )
{
    var_2 = var_0;

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( _id_5038( var_0, var_1[var_3] ) )
            var_2 = common_scripts\utility::array_remove( var_2, var_1[var_3] );
    }

    return var_2;
}

_id_0CE3( var_0, var_1 )
{
    if ( var_0.size != var_1.size )
        return 0;

    foreach ( var_5, var_3 in var_0 )
    {
        if ( !isdefined( var_1[var_5] ) )
            return 0;

        var_4 = var_1[var_5];

        if ( var_4 != var_3 )
            return 0;
    }

    return 1;
}

_id_4003()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = common_scripts\utility::get_links();

        foreach ( var_3 in var_1 )
        {
            var_4 = getvehiclenodearray( var_3, "script_linkname" );
            var_0 = common_scripts\utility::array_combine( var_0, var_4 );
        }
    }

    return var_0;
}

_id_2DB6( var_0, var_1, var_2, var_3, var_4 )
{
    for (;;)
        wait 0.05;
}

_id_2DBD( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_5 = gettime() + var_5 * 1000;

    while ( gettime() < var_5 )
    {
        wait 0.05;

        if ( !isdefined( var_1 ) || !isdefined( var_1.origin ) )
            return;
    }
}

_id_2DB8( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    _id_2DBD( var_1, var_0, var_2, var_3, var_4, var_5 );
}

_id_2DB9( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_5 = gettime() + var_5 * 1000;

    while ( gettime() < var_5 )
        wait 0.05;
}

_id_2DBA( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_5 endon( var_6 );

    for (;;)
        wait 0.05;
}

draw_line_until_notify( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_5 endon( var_6 );

    for (;;)
        common_scripts\utility::draw_line_for_time( var_0, var_1, var_2, var_3, var_4, 0.05 );
}

_id_2DBB( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_6 = gettime() + var_6 * 1000;
    var_1 *= var_2;

    while ( gettime() < var_6 )
    {
        wait 0.05;

        if ( !isdefined( var_0 ) || !isdefined( var_0.origin ) )
            return;
    }
}

draw_circle_until_notify( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( var_7 ) )
        var_8 = var_7;
    else
        var_8 = 16;

    var_9 = 360 / var_8;
    var_10 = [];

    for ( var_11 = 0; var_11 < var_8; var_11++ )
    {
        var_12 = var_9 * var_11;
        var_13 = cos( var_12 ) * var_1;
        var_14 = sin( var_12 ) * var_1;
        var_15 = var_0[0] + var_13;
        var_16 = var_0[1] + var_14;
        var_17 = var_0[2];
        var_10[var_10.size] = ( var_15, var_16, var_17 );
    }

    thread _id_2DA3( var_10, var_2, var_3, var_4, var_5, var_6 );
}

draw_circle_for_time( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 16;
    var_7 = 360 / var_6;
    var_8 = [];

    for ( var_9 = 0; var_9 < var_6; var_9++ )
    {
        var_10 = var_7 * var_9;
        var_11 = cos( var_10 ) * var_1;
        var_12 = sin( var_10 ) * var_1;
        var_13 = var_0[0] + var_11;
        var_14 = var_0[1] + var_12;
        var_15 = var_0[2];
        var_8[var_8.size] = ( var_13, var_14, var_15 );
    }

    thread _id_2DA2( var_8, var_2, var_3, var_4, var_5 );
}

_id_2DA2( var_0, var_1, var_2, var_3, var_4 )
{
    for ( var_5 = 0; var_5 < var_0.size; var_5++ )
    {
        var_6 = var_0[var_5];

        if ( var_5 + 1 >= var_0.size )
            var_7 = var_0[0];
        else
            var_7 = var_0[var_5 + 1];

        thread common_scripts\utility::draw_line_for_time( var_6, var_7, var_1, var_2, var_3, var_4 );
    }
}

_id_2DA3( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    for ( var_6 = 0; var_6 < var_0.size; var_6++ )
    {
        var_7 = var_0[var_6];

        if ( var_6 + 1 >= var_0.size )
            var_8 = var_0[0];
        else
            var_8 = var_0[var_6 + 1];

        thread draw_line_until_notify( var_7, var_8, var_1, var_2, var_3, var_4, var_5 );
    }
}

_id_1EB4()
{
    self notify( "enemy" );
    self _meth_8166();
}

_id_1332( var_0 )
{
    level notify( "battlechatter_off_thread" );
    _id_A51B::_id_2600( var_0 );
    animscripts\battlechatter::_id_134F();

    if ( isdefined( var_0 ) )
    {
        _id_7DDA( var_0, 0 );
        var_1 = _func_0D6( var_0 );
    }
    else
    {
        foreach ( var_0 in anim._id_91F9 )
            _id_7DDA( var_0, 0 );

        var_1 = _func_0D6();
    }

    if ( !isdefined( anim._id_1CA5 ) || !anim._id_1CA5 )
        return;

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
        var_1[var_4]._id_132D = 0;

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        var_5 = var_1[var_4];

        if ( !isalive( var_5 ) )
            continue;

        if ( !var_5._id_1CA5 )
            continue;

        if ( !var_5._id_51B0 )
            continue;

        var_5 _id_A59B::_id_9FF1();
    }

    var_6 = gettime() - anim._id_55FF["allies"];

    if ( var_6 < 1500 )
        wait(var_6 / 1000);

    if ( isdefined( var_0 ) )
        level notify( var_0 + " done speaking" );
    else
        level notify( "done speaking" );
}

_id_1333( var_0 )
{
    thread _id_1334( var_0 );
    _id_A51B::_id_2602( var_0 );
}

_id_1334( var_0 )
{
    level endon( "battlechatter_off_thread" );
    animscripts\battlechatter::_id_134F();

    while ( !isdefined( anim._id_1CA5 ) )
        wait 0.05;

    common_scripts\utility::flag_set( "battlechatter_on_thread_waiting" );
    wait 1.5;
    common_scripts\utility::flag_clear( "battlechatter_on_thread_waiting" );

    if ( isdefined( var_0 ) )
    {
        _id_7DDA( var_0, 1 );
        var_1 = _func_0D6( var_0 );
    }
    else
    {
        foreach ( var_0 in anim._id_91F9 )
            _id_7DDA( var_0, 1 );

        var_1 = _func_0D6();
    }

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
        var_1[var_4] _id_7DD9( 1 );
}

_id_7DD9( var_0 )
{
    _id_2605( !var_0 );

    if ( !isdefined( anim._id_1CA5 ) || !anim._id_1CA5 )
        return;

    if ( self.type == "dog" )
        return;

    if ( var_0 )
    {
        if ( isdefined( self._id_7958 ) && !self._id_7958 )
            self._id_132D = 0;
        else
            self._id_132D = 1;
    }
    else
    {
        self._id_132D = 0;

        if ( isdefined( self._id_51B0 ) && self._id_51B0 )
            self waittill( "done speaking" );
    }
}

_id_7ECC( var_0, var_1 )
{
    if ( !anim._id_1CA5 )
        return;

    var_2 = getarraykeys( anim._id_2244 );
    var_3 = common_scripts\utility::array_contains( var_2, var_1 );

    if ( !var_3 )
        return;

    var_4 = _func_0D6( var_0 );

    foreach ( var_6 in var_4 )
    {
        var_6 _id_7DAE( var_1 );
        waitframe();
    }
}

_id_7DAE( var_0 )
{
    if ( !anim._id_1CA5 )
        return;

    var_1 = getarraykeys( anim._id_2244 );
    var_2 = common_scripts\utility::array_contains( var_1, var_0 );

    if ( !var_2 )
        return;

    if ( self.type == "dog" )
        return;

    if ( isdefined( self._id_51B0 ) && self._id_51B0 )
    {
        self waittill( "done speaking" );
        wait 0.1;
    }

    animscripts\battlechatter_ai::_id_73AB();
    waittillframeend;
    self.voice = var_0;
    animscripts\battlechatter_ai::_id_0850();
}

_id_38CB( var_0 )
{
    thread _id_7E2D( 1, var_0 );
}

_id_38CA( var_0 )
{
    thread _id_7E2D( 0, var_0 );
}

_id_7E2D( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "allies";

    if ( !anim._id_1CA5 )
        return;

    wait 1.5;
    level._id_38C9[var_1] = var_0;
    var_2 = [];
    var_2 = _func_0D6( var_1 );
    common_scripts\utility::array_thread( var_2, ::_id_7E2C, var_0 );
}

_id_7E2C( var_0 )
{
    self._id_38C9 = var_0;
}

_id_3AA1()
{
    var_0 = _func_0D6( "allies" );

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
            var_2 _id_7E3B( 0 );
    }

    level._id_3A9F = 0;
}

_id_3AA2()
{
    var_0 = _func_0D6( "allies" );

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
            var_2 _id_7E3B( 1 );
    }

    level._id_3A9F = 1;
}

_id_7E3B( var_0 )
{
    if ( var_0 )
        self._id_3AA0 = undefined;
    else
        self._id_3AA0 = 1;
}

_id_261E( var_0 )
{
    if ( !isplayer( self ) )
        return;

    switch ( var_0 )
    {
        case "mason":
        case "hudson":
        case "reznov":
            level._id_25F9._id_6AA1 = getsubstr( var_0, 0, 3 );
            break;
        default:
            level._id_25F9._id_6AA1 = "mas";
            break;
    }

    self._id_25FB = level._id_25F9._id_6AA1;
}

_id_2605( var_0 )
{
    if ( isai( self ) && isalive( self ) )
    {
        if ( var_0 )
            self._id_2600 = 1;
        else
            self._id_2600 = 0;
    }
    else
    {

    }
}

_id_3DFB( var_0 )
{
    var_1 = getentarray( "objective", "targetname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2].script_noteworthy == var_0 )
            return var_1[var_2].origin;
    }
}

_id_3DFA( var_0 )
{
    var_1 = getentarray( "objective_event", "targetname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2].script_noteworthy == var_0 )
            return var_1[var_2];
    }
}

_id_A09B()
{
    _id_A59B::_id_A09D( 1 );
}

_id_A09C()
{
    _id_A59B::_id_A09D( 0 );
}

_id_272B()
{
    self notify( "Debug origin" );
    self endon( "Debug origin" );
    self endon( "death" );

    for (;;)
    {
        var_0 = anglestoforward( self.angles );
        var_1 = var_0 * 30;
        var_2 = var_0 * 20;
        var_3 = anglestoright( self.angles );
        var_4 = var_3 * -10;
        var_3 *= 10;
        wait 0.05;
    }
}

_id_3DBE()
{
    var_0 = [];

    if ( isdefined( self.script_linkto ) )
    {
        var_1 = common_scripts\utility::get_links();

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = common_scripts\utility::getstruct( var_1[var_2], "script_linkname" );

            if ( isdefined( var_3 ) )
                var_0[var_0.size] = var_3;
        }
    }

    return var_0;
}

_id_3DAF( var_0 )
{
    var_1 = self;

    while ( isdefined( var_1.target ) )
    {
        wait 0.05;

        if ( isdefined( var_1.target ) )
        {
            switch ( var_0 )
            {
                case "vehiclenode":
                    var_1 = getvehiclenode( var_1.target, "targetname" );
                    break;
                case "pathnode":
                    var_1 = getnode( var_1.target, "targetname" );
                    break;
                case "ent":
                    var_1 = getent( var_1.target, "targetname" );
                    break;
                case "struct":
                    var_1 = common_scripts\utility::getstruct( var_1.target, "targetname" );
                    break;
                default:
            }

            continue;
        }

        break;
    }

    var_2 = var_1;
    return var_2;
}

_id_6BF9( var_0 )
{
    var_1 = spawn( "script_origin", level.player.origin );
    var_1 linkto( level.player );

    if ( isdefined( var_0 ) )
        thread _id_9364( var_0 );

    self _meth_81A7( var_1 );

    if ( !isdefined( self._id_63C9 ) )
        self._id_63C9 = self._id_01C7;

    self._id_01C7 = 300;
    common_scripts\utility::waittill_any( "goal", "timeout" );

    if ( isdefined( self._id_63C9 ) )
    {
        self._id_01C7 = self._id_63C9;
        self._id_63C9 = undefined;
    }

    var_1 delete();
}

_id_9364( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self notify( "timeout" );
}

_id_7E39()
{
    if ( isdefined( self._id_7E38 ) )
        return;

    self._id_63C7 = self._id_02FB;
    self._id_63D4 = self._id_02FC;
    self._id_63D5 = self._id_0277;
    self._id_02FB = 8;
    self._id_02FC = 8;
    self._id_0277 = 1;
    self._id_7E38 = 1;
}

_id_9A59()
{
    if ( !isdefined( self._id_7E38 ) )
        return;

    self._id_02FB = self._id_63C7;
    self._id_02FC = self._id_63D4;
    self._id_0277 = self._id_63D5;
    self._id_7E38 = undefined;
}

_id_0CFE( var_0 )
{
    var_1 = [];
    var_2 = getarraykeys( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( !isalive( var_0[var_4] ) )
            continue;

        var_1[var_4] = var_0[var_4];
    }

    return var_1;
}

_id_0CFD( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isalive( var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_0CFF( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isalive( var_3 ) )
            continue;

        if ( var_3 _id_2CE6() )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_0CFB( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( var_0[var_3] != var_1 )
            var_2[var_2.size] = var_0[var_3];
    }

    return var_2;
}

_id_0CFA( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size - 1; var_2++ )
    {
        if ( var_2 == var_1 )
        {
            var_0[var_2] = var_0[var_2 + 1];
            var_1++;
        }
    }

    var_0[var_0.size - 1] = undefined;
    return var_0;
}

_id_0CF4( var_0, var_1, var_2 )
{
    foreach ( var_5, var_4 in var_0 )
        var_4 notify( var_1, var_2 );
}

_id_8F5C()
{
    var_0 = spawnstruct();
    var_0._id_0CD8 = [];
    var_0._id_55AB = 0;
    return var_0;
}

_id_8F5F( var_0, var_1 )
{
    var_0._id_0CD8[var_0._id_55AB] = var_1;
    var_1._id_8F5B = var_0._id_55AB;
    var_0._id_55AB++;
}

_id_8F60( var_0, var_1 )
{
    _id_8F65( var_0, var_1 );
    var_0._id_0CD8[var_0._id_55AB - 1] = undefined;
    var_0._id_55AB--;
}

_id_8F61( var_0, var_1 )
{
    if ( isdefined( var_0._id_0CD8[var_0._id_55AB - 1] ) )
    {
        var_0._id_0CD8[var_1] = var_0._id_0CD8[var_0._id_55AB - 1];
        var_0._id_0CD8[var_1]._id_8F5B = var_1;
        var_0._id_0CD8[var_0._id_55AB - 1] = undefined;
        var_0._id_55AB = var_0._id_0CD8.size;
    }
    else
    {
        var_0._id_0CD8[var_1] = undefined;
        _id_8F62( var_0 );
    }
}

_id_8F62( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0._id_0CD8 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    var_0._id_0CD8 = var_1;

    foreach ( var_6, var_3 in var_0._id_0CD8 )
        var_3._id_8F5B = var_6;

    var_0._id_55AB = var_0._id_0CD8.size;
}

_id_8F65( var_0, var_1 )
{
    var_0 _id_A59B::_id_8F64( var_0._id_0CD8[var_0._id_55AB - 1], var_1 );
}

_id_8F63( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1; var_2++ )
        var_0 _id_A59B::_id_8F64( var_0._id_0CD8[var_2], var_0._id_0CD8[randomint( var_0._id_55AB )] );
}

_id_3EAE()
{
    if ( level.console )
        return " + usereload";
    else
        return " + activate";
}

_id_2534( var_0 )
{
    return animscripts\battlechatter_ai::_id_2536( var_0 );
}

_id_3E73( var_0, var_1 )
{
    var_2 = newhudelem();

    if ( level.console )
    {
        var_2.x = 68;
        var_2.y = 35;
    }
    else
    {
        var_2.x = 58;
        var_2.y = 95;
    }

    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "left";
    var_2.vertalign = "middle";

    if ( isdefined( var_1 ) )
        var_3 = var_1;
    else
        var_3 = level._id_357E;

    var_2 _meth_80D5( var_3, var_0, "hudStopwatch", 64, 64 );
    return var_2;
}

_id_62ED( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < level._id_071A.size; var_2++ )
    {
        if ( level._id_071A[var_2] != var_0 )
            continue;

        var_1 = 1;
        break;
    }

    return var_1;
}

_id_62EE( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < level._id_4C0F.size; var_2++ )
    {
        if ( level._id_4C0F[var_2] != var_0 )
            continue;

        var_1 = 1;
        break;
    }

    return var_1;
}

_id_7E82( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level._id_071A.size; var_2++ )
    {
        if ( level._id_071A[var_2] == var_0 )
            continue;

        var_1[var_1.size] = level._id_071A[var_2];
    }

    level._id_071A = var_1;
    var_3 = 0;

    for ( var_2 = 0; var_2 < level._id_4C0F.size; var_2++ )
    {
        if ( level._id_4C0F[var_2] != var_0 )
            continue;

        var_3 = 1;
    }

    if ( !var_3 )
        level._id_4C0F[level._id_4C0F.size] = var_0;
}

_id_7E81( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level._id_4C0F.size; var_2++ )
    {
        if ( level._id_4C0F[var_2] == var_0 )
            continue;

        var_1[var_1.size] = level._id_4C0F[var_2];
    }

    level._id_4C0F = var_1;
    var_3 = 0;

    for ( var_2 = 0; var_2 < level._id_071A.size; var_2++ )
    {
        if ( level._id_071A[var_2] != var_0 )
            continue;

        var_3 = 1;
    }

    if ( !var_3 )
        level._id_071A[level._id_071A.size] = var_0;
}

_id_5CDC()
{
    if ( level._id_5CDB )
        return;

    if ( isdefined( level._id_60D3 ) )
        return;

    _func_0D3( "ammoCounterHide", 1 );
    level._id_5CDB = 1;
    common_scripts\utility::flag_set( "missionfailed" );

    if ( _id_0CC3() )
        return;

    if ( getdvar( "failure_disabled" ) == "1" )
        return;

    if ( isdefined( level._id_5CCE ) )
    {
        thread [[ level._id_5CCE ]]();
        return;
    }

    _id_A59B::_id_5CD4( 0 );
    _func_055();
}

_id_7E77( var_0 )
{
    level._id_5CCE = var_0;
}

script_delay()
{
    if ( isdefined( self.script_delay ) )
    {
        wait(self.script_delay);
        return 1;
    }
    else if ( isdefined( self._id_7989 ) && isdefined( self._id_7988 ) )
    {
        wait(randomfloatrange( self._id_7989, self._id_7988 ));
        return 1;
    }

    return 0;
}

_id_7B1A()
{
    var_0 = gettime();

    if ( isdefined( self._id_7B1A ) )
    {
        wait(self._id_7B1A);

        if ( isdefined( self._id_7B1B ) )
            self._id_7B1A += self._id_7B1B;
    }
    else if ( isdefined( self._id_7B1D ) && isdefined( self._id_7B1C ) )
    {
        wait(randomfloatrange( self._id_7B1D, self._id_7B1C ));

        if ( isdefined( self._id_7B1B ) )
        {
            self._id_7B1D += self._id_7B1B;
            self._id_7B1C += self._id_7B1B;
        }
    }

    return gettime() - var_0;
}

_id_4490( var_0 )
{
    _id_A59F::_id_448F( var_0 );
}

_id_44AA( var_0, var_1 )
{
    _id_A59F::_id_44A9( var_0, var_1 );
}

_id_3D78( var_0, var_1 )
{
    var_2 = _func_0D6( var_0 );
    var_3 = [];

    for ( var_4 = 0; var_4 < var_2.size; var_4++ )
    {
        var_5 = var_2[var_4];

        if ( !isdefined( var_5._id_79E1 ) )
            continue;

        if ( var_5._id_79E1 != var_1 )
            continue;

        var_3[var_3.size] = var_5;
    }

    return var_3;
}

_id_3CBC()
{
    var_0 = _func_0D6( "allies" );
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_0[var_2];

        if ( !isdefined( var_3._id_79E1 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_3CBE( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = self.target;

    var_1 = [];
    var_2 = getentarray( var_0, "targetname" );
    var_1 = common_scripts\utility::array_combine( var_1, var_2 );
    var_2 = getnodearray( var_0, "targetname" );
    var_1 = common_scripts\utility::array_combine( var_1, var_2 );
    var_2 = common_scripts\utility::getstructarray( var_0, "targetname" );
    var_1 = common_scripts\utility::array_combine( var_1, var_2 );
    var_2 = getvehiclenodearray( var_0, "targetname" );
    var_1 = common_scripts\utility::array_combine( var_1, var_2 );
    return var_1;
}

_id_3099()
{
    if ( isdefined( self._id_79E1 ) )
        return;

    if ( !isdefined( self._id_639E ) )
        return;

    _id_7E32( self._id_639E );
    self._id_639E = undefined;
}

_id_309A()
{
    self._id_2D2D = 1;
    _id_3099();
}

_id_2A73()
{
    if ( isdefined( self._id_6099 ) )
    {
        self endon( "death" );
        self waittill( "done_setting_new_color" );
    }

    self _meth_815E();

    if ( !isdefined( self._id_79E1 ) )
        return;

    self._id_639E = self._id_79E1;
    _id_A512::_id_7328();
}

_id_1EB8()
{
    _id_2A73();
}

_id_1CC0( var_0 )
{
    var_1 = level._id_2048[tolower( var_0 )];

    if ( isdefined( self._id_79E1 ) && var_1 == self._id_79E1 )
        return 1;
    else
        return 0;
}

_id_3D77()
{
    var_0 = self._id_79E1;
    return var_0;
}

_id_7E32( var_0 )
{
    var_1 = _id_A512::_id_0730( var_0 );
}

_id_51BB( var_0, var_1 )
{
    _id_A512::_id_51BC( var_0, var_1 );
}

_id_1EA5( var_0, var_1 )
{
    _id_A512::_id_1EA6( var_0, var_1 );
}

_id_1E95( var_0 )
{
    foreach ( var_2 in level._id_204D )
        _id_A512::_id_1EA6( var_2, var_0 );
}

_id_73FF()
{
    thread _id_A512::_id_2050();
}

_id_2ACB()
{
    self._id_73FF = undefined;
    self notify( "_disable_reinforcement" );
}

_id_8EB3()
{
    self notify( "_disable_reinforcement" );
}

_id_8E5B( var_0, var_1 )
{
    thread _id_A512::_id_2056( var_0, var_1 );
}

_id_893E( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = "allies";

    thread _id_A512::_id_2055( var_3, var_0, var_1, var_2 );
}

_id_1ECF()
{
    _id_A512::_id_204E();
}

_id_7E9C( var_0, var_1 )
{
    _id_A512::_id_2052( var_0, var_1 );
}

_id_7E13( var_0 )
{
    _id_A512::_id_2051( var_0 );
}

_id_46E5()
{
    if ( _id_A512::_id_3E8D() == "axis" )
        return isdefined( self._id_7972 ) || isdefined( self._id_79E1 );

    return isdefined( self._id_7971 ) || isdefined( self._id_79E1 );
}

_id_3D0C()
{
    return _id_A512::_id_3D0D();
}

_id_3D08()
{
    return _id_A512::_id_3D09();
}

_id_38C3( var_0 )
{
    var_1 = gettime() + var_0 * 1000;

    while ( gettime() < var_1 )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

_id_38C0( var_0 )
{
    self endon( "death" );
    self endon( "flashed" );
    wait 0.2;
    self _meth_8132( 0 );
    wait(var_0 + 2);
    self _meth_8132( 1 );
}

_id_60EA( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [ 0.8, 0.7, 0.7, 0.6 ];
    var_6 = [ 1.0, 0.8, 0.6, 0.6 ];

    foreach ( var_12, var_8 in var_6 )
    {
        var_9 = ( var_1 - 0.85 ) / 0.15;

        if ( var_9 > var_2 )
            var_2 = var_9;

        if ( var_2 < 0.25 )
            var_2 = 0.25;

        var_10 = 0.3;

        if ( var_1 > 1 - var_10 )
            var_1 = 1.0;
        else
            var_1 /= ( 1 - var_10 );

        if ( var_4 != self.team )
            var_11 = var_1 * var_2 * 6.0;
        else
            var_11 = var_1 * var_2 * 3.0;

        if ( var_11 < 0.25 )
            continue;

        var_11 = var_8 * var_11;

        if ( isdefined( self._id_5A35 ) && var_11 > self._id_5A35 )
            var_11 = self._id_5A35;

        self._id_38B4 = var_4;
        self notify( "flashed" );
        self.flashendtime = gettime() + var_11 * 1000;
        self shellshock( "flashbang", var_11 );
        common_scripts\utility::flag_set( "player_flashed" );

        if ( var_1 * var_2 > 0.5 )
            thread _id_38C0( var_11 );

        wait(var_5[var_12]);
    }

    thread _id_A59B::_id_9A1D( 0.05 );
}

_id_38BF()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "flashbang", var_0, var_1, var_2, var_3, var_4 );

        if ( "1" == getdvar( "noflash" ) )
            continue;

        if ( _id_505F( self ) )
            continue;

        if ( isdefined( self._id_932F ) )
        {
            var_5 = 0.8;
            var_6 = 1.0 - var_5;
            self._id_932F = undefined;

            if ( var_1 < var_6 )
                continue;

            var_1 = ( var_1 - var_6 ) / var_5;
        }

        var_7 = ( var_1 - 0.85 ) / 0.15;

        if ( var_7 > var_2 )
            var_2 = var_7;

        if ( var_2 < 0.25 )
            var_2 = 0.25;

        var_8 = 0.3;

        if ( var_1 > 1 - var_8 )
            var_1 = 1.0;
        else
            var_1 /= ( 1 - var_8 );

        if ( var_4 != self.team )
            var_9 = var_1 * var_2 * 6.0;
        else
            var_9 = var_1 * var_2 * 3.0;

        if ( var_9 < 0.25 )
            continue;

        if ( isdefined( self._id_5A35 ) && var_9 > self._id_5A35 )
            var_9 = self._id_5A35;

        self._id_38B4 = var_4;
        self notify( "flashed" );
        self.flashendtime = gettime() + var_9 * 1000;
        self shellshock( "flashbang", var_9 );
        self lightsetoverrideenableforplayer( "flashed", 0.1 );
        common_scripts\utility::flag_set( "player_flashed" );
        thread _id_A59B::_id_9A1D( var_9 );
        wait 0.1;
        self lightsetoverridedisableforplayer( var_9 - 0.1 );

        if ( var_1 * var_2 > 0.5 )
            thread _id_38C0( var_9 );

        if ( var_9 > 2 )
            thread _id_38C3( 0.75 );
        else
            thread _id_38C3( 0.25 );

        if ( var_4 != "allies" )
            thread _id_38C1( var_9, var_4 );
    }
}

_id_38C1( var_0, var_1 )
{
    wait 0.05;
    var_2 = _func_0D6( "allies" );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( distancesquared( var_2[var_3].origin, self.origin ) < 122500 )
        {
            var_4 = var_0 + randomfloatrange( -1000, 1500 );

            if ( var_4 > 4.5 )
                var_4 = 4.5;
            else if ( var_4 < 0.25 )
                continue;

            var_5 = gettime() + var_4 * 1000;

            if ( !isdefined( var_2[var_3].flashendtime ) || var_2[var_3].flashendtime < var_5 )
            {
                var_2[var_3]._id_38B4 = var_1;
                var_2[var_3] _id_38A9( var_4 );
            }
        }
    }
}

_id_748A()
{
    common_scripts\_createfx::_id_7487();
}

_id_671D( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
    {
        var_1 = level._id_241A[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
                var_3 common_scripts\utility::pauseeffect();

            return;
        }
    }
    else
    {
        foreach ( var_6 in level._id_2417 )
        {
            if ( !isdefined( var_6.v["exploder"] ) )
                continue;

            if ( var_6.v["exploder"] != var_0 )
                continue;

            var_6 common_scripts\utility::pauseeffect();
        }
    }
}

_id_748B( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
    {
        var_1 = level._id_241A[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
                var_3 _id_748A();

            return;
        }
    }
    else
    {
        foreach ( var_6 in level._id_2417 )
        {
            if ( !isdefined( var_6.v["exploder"] ) )
                continue;

            if ( var_6.v["exploder"] != var_0 )
                continue;

            var_6 _id_748A();
        }
    }
}

_id_3FA7( var_0 )
{
    var_1 = [];

    if ( isdefined( level._id_2415 ) )
    {
        var_2 = level._id_2415[var_0];

        if ( isdefined( var_2 ) )
            var_1 = var_2;
    }
    else
    {
        for ( var_3 = 0; var_3 < level._id_2417.size; var_3++ )
        {
            if ( level._id_2417[var_3].v["fxid"] == var_0 )
                var_1[var_1.size] = level._id_2417[var_3];
        }
    }

    return var_1;
}

_id_4BAD( var_0 )
{
    self notify( "ignoreAllEnemies_threaded" );
    self endon( "ignoreAllEnemies_threaded" );

    if ( var_0 )
    {
        self._id_63B4 = self _meth_8178();
        var_1 = undefined;
        createthreatbiasgroup( "ignore_everybody" );
        self setthreatbiasgroup( "ignore_everybody" );
        var_2 = [];
        var_2["axis"] = "allies";
        var_2["allies"] = "axis";
        var_3 = _func_0D6( var_2[self.team] );
        var_4 = [];

        for ( var_5 = 0; var_5 < var_3.size; var_5++ )
            var_4[var_3[var_5] _meth_8178()] = 1;

        var_6 = getarraykeys( var_4 );

        for ( var_5 = 0; var_5 < var_6.size; var_5++ )
            setthreatbias( var_6[var_5], "ignore_everybody", 0 );
    }
    else
    {
        var_1 = undefined;

        if ( self._id_63B4 != "" )
            self setthreatbiasgroup( self._id_63B4 );

        self._id_63B4 = undefined;
    }
}

_id_9CAB()
{
    _id_A5A0::_id_9D0E();
}

_id_9D17()
{
    thread _id_A5A0::_id_9D18();
}

_id_9CED( var_0 )
{
    _id_A5A0::_id_9CEF( var_0 );
}

_id_9CF4( var_0 )
{
    _id_A5A0::_id_9CF5( var_0 );
}

_id_9CB7( var_0, var_1 )
{
    _id_A59E::_id_9D0F( var_0, var_1 );
}

_id_4414( var_0 )
{
    return bullettrace( var_0, var_0 + ( 0.0, 0.0, -100000.0 ), 0, self )["position"];
}

_id_1C72( var_0 )
{
    self._id_6B4B += var_0;
    self notify( "update_health_packets" );

    if ( self._id_6B4B >= 3 )
        self._id_6B4B = 3;
}

_id_4152( var_0 )
{
    var_1 = _id_4153( var_0 );
    return var_1[0];
}

_id_4153( var_0 )
{
    return _id_A5A0::_id_05BE( var_0 );
}

_id_28AF( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    _id_079D();

    if ( !isdefined( level._id_8B7D ) )
        level._id_8B7D = [];

    level._id_8B7D[var_0] = _id_079E( var_0, var_1, var_2, var_3, [ var_4 ], var_5 );
}

_id_079C( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    _id_079D();
    var_0 = tolower( var_0 );

    if ( isdefined( var_4 ) )
    {
        if ( var_4.size > 2 )
        {
            var_6 = [];
            var_6[0] = var_4[0];
            var_6[1] = var_4[1];
            var_4 = var_6;
        }

        if ( !isdefined( level._id_8CD8 ) )
            level._id_8CD8 = [];

        foreach ( var_8 in var_4 )
        {
            if ( !common_scripts\utility::array_contains( level._id_8CD8, var_8 ) )
                level._id_8CD8[level._id_8CD8.size] = var_8;
        }
    }

    if ( isdefined( level._id_8B7D ) && isdefined( level._id_8B7D[var_0] ) )
        var_11 = level._id_8B7D[var_0];
    else
        var_11 = _id_079E( var_0, var_1, var_2, var_3, var_4, var_5 );

    if ( !isdefined( var_1 ) )
    {
        if ( !isdefined( level._id_8B7D ) )
        {

        }
        else if ( !issubstr( var_0, "no_game" ) )
        {
            if ( !isdefined( level._id_8B7D[var_0] ) )
                return;
        }
    }

    level._id_8BAF[level._id_8BAF.size] = var_11;
    level._id_8B2E[var_0] = var_11;
}

_id_7EBE( var_0, var_1 )
{
    if ( !isdefined( level._id_8B2E ) )
        return;

    if ( !isdefined( level._id_8B2E[var_0] ) )
        return;

    var_0 = tolower( var_0 );

    if ( var_1.size > 2 )
    {
        var_2 = [];
        var_2[0] = var_1[0];
        var_2[1] = var_1[1];
        var_1 = var_2;
    }

    if ( !isdefined( level._id_8CD8 ) )
        level._id_8CD8 = [];

    foreach ( var_4 in var_1 )
    {
        if ( !common_scripts\utility::array_contains( level._id_8CD8, var_4 ) )
            level._id_8CD8[level._id_8CD8.size] = var_4;
    }

    level._id_8B2E[var_0]["transients_to_load"] = var_1;
}

_id_5053()
{
    return issubstr( level._id_8C30, "no_game" );
}

_id_079E( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = [];
    var_6["name"] = var_0;
    var_6["start_func"] = var_1;
    var_6["start_loc_string"] = var_2;
    var_6["logic_func"] = var_3;
    var_6["transients_to_load"] = var_4;
    var_6["catchup_function"] = var_5;
    return var_6;
}

_id_079D()
{
    if ( !isdefined( level._id_8BAF ) )
        level._id_8BAF = [];
}

_id_56BF()
{
    return level._id_8BAF.size > 1;
}

_id_7E06( var_0 )
{
    level._id_278B = var_0;
}

_id_278A( var_0 )
{
    level._id_278A = var_0;
}

_id_5774( var_0, var_1, var_2, var_3 )
{
    thread _id_A59B::_id_5775( var_0, var_1, var_2, var_3 );
}

_id_A33F( var_0, var_1, var_2, var_3 )
{
    var_4 = vectornormalize( ( var_2[0], var_2[1], 0 ) - ( var_0[0], var_0[1], 0 ) );
    var_5 = anglestoforward( ( 0, var_1[1], 0 ) );
    return vectordot( var_5, var_4 ) >= var_3;
}

_id_3D44( var_0, var_1, var_2 )
{
    var_3 = vectornormalize( var_2 - var_0 );
    var_4 = anglestoforward( var_1 );
    var_5 = vectordot( var_4, var_3 );
    return var_5;
}

_id_A340( var_0, var_1 )
{
    var_2 = undefined;

    for ( var_3 = 0; var_3 < level.players.size; var_3++ )
    {
        var_4 = level.players[var_3] geteye();
        var_2 = common_scripts\utility::within_fov( var_4, level.players[var_3] getangles(), var_0, var_1 );

        if ( !var_2 )
            return 0;
    }

    return 1;
}

_id_9F83( var_0, var_1 )
{
    var_2 = var_1 * 1000 - ( gettime() - var_0 );
    var_2 *= 0.001;

    if ( var_2 > 0 )
        wait(var_2);
}

_id_134E()
{
    anim._id_7B3A = gettime();
}

_id_2A31( var_0 )
{
    var_1 = _func_28C( var_0, "squelchname" );

    if ( self == level || var_1 != "" )
    {
        _id_70BA( var_0, undefined, var_1 );
        return;
    }

    _id_134E();
    _id_A506::_id_0C21( self, var_0 );
}

_id_3C8B( var_0, var_1 )
{
    _id_134E();
    _id_A506::_id_0BCF( self, var_0, undefined, undefined, var_1 );
}

_id_70BA( var_0, var_1, var_2 )
{
    if ( !isdefined( level._id_6BCA ) )
    {
        var_3 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
        var_3 linkto( level.player, "", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
        level._id_6BCA = var_3;
    }

    _id_134E();

    if ( !isdefined( var_1 ) )
        return level._id_6BCA _id_3AF0( ::_id_70C0, var_0, var_2 );
    else
        return level._id_6BCA _id_3AF6( var_1, ::_id_70C0, var_0, var_2 );
}

_id_70C0( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "none";

    level._id_6BCC = 0;

    if ( var_1 != "none" && isdefined( level._id_78B6["squelches"][var_1] ) )
        play_sound_on_tag( level._id_78B6["squelches"][var_1]["on"], undefined, 1 );

    var_2 = 0;

    if ( isdefined( level._id_78B6[var_0] ) )
        var_2 = play_sound_on_tag( level._id_78B6[var_0], undefined, 1 );
    else
        var_2 = play_sound_on_tag( var_0, undefined, 1 );

    if ( var_1 != "none" && isdefined( level._id_78B6["squelches"][var_1] ) )
        thread _id_70C9( var_1 );

    return var_2;
}

_id_70BE( var_0 )
{
    if ( !isdefined( level._id_6BCB ) )
        level._id_6BCB = [];

    var_1 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    level._id_6BCB[level._id_6BCB.size] = var_1;
    var_1 endon( "death" );
    thread _id_2825( var_1, "sounddone" );
    var_1.origin = level._id_6BCA.origin;
    var_1.angles = level._id_6BCA.angles;
    var_1 linkto( level._id_6BCA );
    var_1 playsound( level._id_78B6[var_0], "sounddone" );

    if ( !isdefined( _id_A59B::_id_9FB4( var_1 ) ) )
        var_1 stopsounds();

    wait 0.05;
    level._id_6BCB = common_scripts\utility::array_remove( level._id_6BCB, var_1 );
    var_1 delete();
}

_id_70C6()
{
    if ( !isdefined( level._id_6BCA ) )
        return;

    level._id_6BCA delete();
}

_id_70BF()
{
    if ( !isdefined( level._id_6BCB ) )
        return;

    foreach ( var_1 in level._id_6BCB )
    {
        if ( isdefined( var_1 ) )
        {
            var_1 stopsounds();
            wait 0.05;
            var_1 delete();
        }
    }

    level._id_6BCB = undefined;
}

_id_70BB()
{
    if ( !isdefined( level._id_6BCA ) )
        return;

    level._id_6BCA _id_3AF2();
}

_id_70C4( var_0 )
{
    if ( !isdefined( level._id_6BCA ) )
        return;

    if ( !isdefined( level._id_6BCA._id_3AF0 ) )
        return;

    var_1 = [];
    var_2 = 0;
    var_3 = level._id_6BCA._id_3AF0.size;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        if ( var_4 == 0 && isdefined( level._id_6BCA._id_3AF0[0]._id_3AF3 ) && isdefined( level._id_6BCA._id_3AF0[0]._id_3AF3 ) )
        {
            var_1[var_1.size] = level._id_6BCA._id_3AF0[var_4];
            continue;
        }

        if ( isdefined( level._id_6BCA._id_3AF0[var_4]._id_667F ) && level._id_6BCA._id_3AF0[var_4]._id_667F == var_0 )
        {
            level._id_6BCA._id_3AF0[var_4] notify( "death" );
            level._id_6BCA._id_3AF0[var_4] = undefined;
            var_2 = 1;
            continue;
        }

        var_1[var_1.size] = level._id_6BCA._id_3AF0[var_4];
    }

    if ( var_2 )
        level._id_6BCA._id_3AF0 = var_1;
}

_id_70BC( var_0 )
{
    if ( !isdefined( level._id_6BCA ) )
    {
        var_1 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
        var_1 linkto( level.player, "", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
        level._id_6BCA = var_1;
    }

    level._id_6BCA play_sound_on_tag( level._id_78B6[var_0], undefined, 1 );
}

_id_70C5( var_0 )
{
    return _id_70BA( var_0, 0.05 );
}

_id_8666( var_0, var_1 )
{
    var_2 = _func_28C( var_0, "squelchname" );
    _id_A59B::_id_07AF( var_0 );
    _id_70BA( var_0, var_1, var_2 );
}

_id_8667( var_0 )
{
    _id_A59B::_id_07AF( var_0 );
    _id_70C6();
    _id_70BC( var_0 );
}

_id_8669( var_0 )
{
    _id_A59B::_id_07AF( var_0 );
    _id_70BE( var_0 );
}

_id_8657( var_0 )
{
    _id_A59B::_id_07A9( var_0 );
    _id_2A31( var_0 );
}

_id_8658( var_0 )
{
    _id_A59B::_id_07AA( var_0 );
    _id_3C8B( var_0 );
}

_id_70C9( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 0.1;

    level._id_6BCC = 1;
    wait(var_1);

    if ( isdefined( level._id_6BCA ) && level._id_6BCC == 1 )
        level._id_6BCA _id_3AF0( ::play_sound_on_tag, level._id_78B6["squelches"][var_0]["off"], undefined, 1 );
}

_id_70C1( var_0, var_1 )
{
    _id_70BA( var_0, undefined, var_1 );
}

_id_48C3( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();

    if ( isdefined( var_1 ) && var_1 == 1 )
        var_3._id_141D = newhudelem();

    var_3._id_305E = newhudelem();
    var_3 _id_48D7( var_2 );
    var_3._id_305E settext( var_0 );
    return var_3;
}

_id_48C6()
{
    self notify( "death" );

    if ( isdefined( self._id_305E ) )
        self._id_305E destroy();

    if ( isdefined( self._id_141D ) )
        self._id_141D destroy();
}

_id_48D7( var_0 )
{
    if ( level.console )
        self._id_305E.fontscale = 2;
    else
        self._id_305E.fontscale = 1.6;

    self._id_305E.x = 0;
    self._id_305E.y = -40;
    self._id_305E.alignx = "center";
    self._id_305E.aligny = "bottom";
    self._id_305E.horzalign = "center";
    self._id_305E.vertalign = "middle";
    self._id_305E.sort = 1;
    self._id_305E.alpha = 0.8;

    if ( !isdefined( self._id_141D ) )
        return;

    self._id_141D.x = 0;
    self._id_141D.y = -40;
    self._id_141D.alignx = "center";
    self._id_141D.aligny = "middle";
    self._id_141D.horzalign = "center";
    self._id_141D.vertalign = "middle";
    self._id_141D.sort = -1;

    if ( level.console )
        self._id_141D setshader( "popmenu_bg", 650, 52 );
    else
        self._id_141D setshader( "popmenu_bg", 650, 42 );

    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    self._id_141D.alpha = var_0;
}

_id_8F4D( var_0 )
{
    return "" + var_0;
}

_id_5083( var_0 )
{
    var_1 = float( var_0 );
    return _id_8F4D( var_1 ) == var_0;
}

_id_4BB0( var_0, var_1 )
{
    setignoremegroup( var_0, var_1 );
    setignoremegroup( var_1, var_0 );
}

_id_0761( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    var_5["function"] = var_1;
    var_5["param1"] = var_2;
    var_5["param2"] = var_3;
    var_5["param3"] = var_4;
    level._id_88F8[var_0][level._id_88F8[var_0].size] = var_5;
}

_id_7358( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < level._id_88F8[var_0].size; var_3++ )
    {
        if ( level._id_88F8[var_0][var_3]["function"] != var_1 )
            var_2[var_2.size] = level._id_88F8[var_0][var_3];
    }

    level._id_88F8[var_0] = var_2;
}

_id_3414( var_0, var_1 )
{
    if ( !isdefined( level._id_88F8 ) )
        return 0;

    for ( var_2 = 0; var_2 < level._id_88F8[var_0].size; var_2++ )
    {
        if ( level._id_88F8[var_0][var_2]["function"] == var_1 )
            return 1;
    }

    return 0;
}

_id_737D( var_0 )
{
    var_1 = [];

    foreach ( var_3 in self._id_88FA )
    {
        if ( var_3["function"] == var_0 )
            continue;

        var_1[var_1.size] = var_3;
    }

    self._id_88FA = var_1;
}

_id_0798( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    foreach ( var_7 in self._id_88FA )
    {
        if ( var_7["function"] == var_0 )
            return;
    }

    var_9 = [];
    var_9["function"] = var_0;
    var_9["param1"] = var_1;
    var_9["param2"] = var_2;
    var_9["param3"] = var_3;
    var_9["param4"] = var_4;
    var_9["param5"] = var_5;
    self._id_88FA[self._id_88FA.size] = var_9;
}

_id_0CE5( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] delete();
}

_id_0CEE( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] _meth_8052();
}

_id_4BA9( var_0 )
{
    self endon( "death" );
    self._id_0203 = 1;

    if ( isdefined( var_0 ) )
        wait(var_0);
    else
        wait 0.5;

    self._id_0203 = 0;
}

_id_070A( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_1 _id_0706();
}

_id_0709( var_0 )
{
    var_1 = getent( var_0, "script_noteworthy" );
    var_1 _id_0706();
}

_id_2AE7( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_1 common_scripts\utility::trigger_off();
}

_id_2AE6( var_0 )
{
    var_1 = getent( var_0, "script_noteworthy" );
    var_1 common_scripts\utility::trigger_off();
}

_id_3100( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_1 common_scripts\utility::trigger_on();
}

_id_30FF( var_0 )
{
    var_1 = getent( var_0, "script_noteworthy" );
    var_1 common_scripts\utility::trigger_on();
}

_id_5033()
{
    return isdefined( level._id_4837[_id_3CB5()] );
}

_id_3CB5()
{
    if ( !isdefined( self.unique_id ) )
        _id_7DAF();

    return self.unique_id;
}

_id_7DAF()
{
    self.unique_id = "ai" + level._id_0908;
    level._id_0908++;
}

_id_5923()
{
    level._id_4837[self.unique_id] = 1;
}

_id_9A43()
{
    level._id_4837[self.unique_id] = undefined;
}

_id_3D92()
{
    var_0 = [];
    var_1 = _func_0D6( "allies" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2] _id_5033() )
            var_0[var_0.size] = var_1[var_2];
    }

    return var_0;
}

_id_7ECD( var_0, var_1 )
{
    var_2 = _func_0D6( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        var_2[var_3]._id_02EA = var_1;
}

_id_733C( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isalive( var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_735B( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_0[var_2] _id_5033() )
            continue;

        var_1[var_1.size] = var_0[var_2];
    }

    return var_1;
}

_id_7336( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3];

        if ( !isdefined( var_4._id_79E1 ) )
            continue;

        if ( var_4._id_79E1 == var_1 )
            continue;

        var_2[var_2.size] = var_4;
    }

    return var_2;
}

_id_736F( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3];

        if ( !isdefined( var_4.script_noteworthy ) )
            continue;

        if ( var_4.script_noteworthy == var_1 )
            continue;

        var_2[var_2.size] = var_4;
    }

    return var_2;
}

_id_3CF2( var_0, var_1 )
{
    var_2 = _id_3D78( "allies", var_0 );
    var_2 = _id_735B( var_2 );

    if ( !isdefined( var_1 ) )
        var_3 = level.player.origin;
    else
        var_3 = var_1;

    return common_scripts\utility::getclosest( var_3, var_2 );
}

_id_738C( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !issubstr( var_0[var_3].classname, var_1 ) )
            continue;

        var_2[var_2.size] = var_0[var_3];
    }

    return var_2;
}

_id_738D( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !issubstr( var_0[var_3].model, var_1 ) )
            continue;

        var_2[var_2.size] = var_0[var_3];
    }

    return var_2;
}

_id_3CF3( var_0, var_1, var_2 )
{
    var_3 = _id_3D78( "allies", var_0 );
    var_3 = _id_735B( var_3 );

    if ( !isdefined( var_2 ) )
        var_4 = level.player.origin;
    else
        var_4 = var_2;

    var_3 = _id_738C( var_3, var_1 );
    return common_scripts\utility::getclosest( var_4, var_3 );
}

_id_7013( var_0, var_1 )
{
    for (;;)
    {
        var_2 = _id_3CF2( var_0 );

        if ( !isalive( var_2 ) )
        {
            wait 1;
            continue;
        }

        var_2 _id_7E32( var_1 );
        return;
    }
}

_id_4E87( var_0, var_1 )
{
    for (;;)
    {
        var_2 = _id_3CF2( var_0 );

        if ( !isalive( var_2 ) )
            return;

        var_2 _id_7E32( var_1 );
        return;
    }
}

_id_4E88( var_0, var_1, var_2 )
{
    for (;;)
    {
        var_3 = _id_3CF3( var_0, var_2 );

        if ( !isalive( var_3 ) )
            return;

        var_3 _id_7E32( var_1 );
        return;
    }
}

_id_7014( var_0, var_1, var_2 )
{
    for (;;)
    {
        var_3 = _id_3CF3( var_0, var_2 );

        if ( !isalive( var_3 ) )
        {
            wait 1;
            continue;
        }

        var_3 _id_7E32( var_1 );
        return;
    }
}

_id_753D( var_0 )
{
    self _meth_818F( "face angle", var_0 );
    self._id_0258 = 1;
}

_id_7546()
{
    self._id_0258 = 0;
}

_id_4E8A( var_0, var_1, var_2 )
{
    var_3 = 0;
    var_4 = [];

    for ( var_5 = 0; var_5 < var_0.size; var_5++ )
    {
        var_6 = var_0[var_5];

        if ( var_3 || !issubstr( var_6.classname, var_2 ) )
        {
            var_4[var_4.size] = var_6;
            continue;
        }

        var_3 = 1;
        var_6 _id_7E32( var_1 );
    }

    return var_4;
}

_id_4E89( var_0, var_1 )
{
    var_2 = 0;
    var_3 = [];

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( var_2 )
        {
            var_3[var_3.size] = var_5;
            continue;
        }

        var_2 = 1;
        var_5 _id_7E32( var_1 );
    }

    return var_3;
}

_id_9FB2( var_0 )
{
    _id_A59B::_id_9FBA( var_0, "script_noteworthy" );
}

_id_9FB7( var_0 )
{
    _id_A59B::_id_9FBA( var_0, "targetname" );
}

_id_9F98( var_0, var_1 )
{
    if ( common_scripts\utility::flag( var_0 ) )
        return;

    level endon( var_0 );
    wait(var_1);
}

_id_9FAA( var_0, var_1 )
{
    self endon( var_0 );
    wait(var_1);
}

_id_9FBF( var_0 )
{
    self endon( "trigger" );
    wait(var_0);
}

_id_9F8B( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_3 = [];
    var_3 = common_scripts\utility::array_combine( var_3, getentarray( var_0, "targetname" ) );
    var_3 = common_scripts\utility::array_combine( var_3, getentarray( var_1, "targetname" ) );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        var_2 thread _id_A59B::_id_32ED( var_3[var_4] );

    var_2 waittill( "done" );
}

_id_2F29( var_0 )
{
    var_1 = _id_A577::_id_89BB( var_0 );
    return var_1;
}

_id_2F28( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = self;

    var_1 = _id_A577::_id_89BB( var_0 );
    var_1 [[ level._id_2EBF ]]();
    var_1._id_88F8 = var_0._id_88FA;
    var_1 thread _id_A577::_id_76B3();
    var_1._id_03DA = var_0;
    return var_1;
}

_id_8FFC( var_0 )
{
    return _id_A577::_id_89C2( var_0 );
}

_id_9001( var_0 )
{
    return _id_A577::_id_89C3( var_0 );
}

_id_3EA1()
{
    if ( isdefined( self._id_79CE ) )
        return self._id_79CE;

    if ( isdefined( self.script_noteworthy ) )
        return self.script_noteworthy;
}

_id_7E05()
{
    self._id_02FC = 192;
    self._id_02FB = 192;
}

_id_22DA( var_0 )
{
    if ( var_0 == "on" )
        _id_30AF();
    else
        _id_2A8C();
}

_id_30AF( var_0 )
{
    if ( self.type == "dog" )
        return;

    if ( !isdefined( var_0 ) )
        self._id_22DD = 1;

    self._id_22E0 = 1;
    self._id_04CB = 0.2;
    level thread animscripts\cqb::_id_377C();
}

_id_2A8C()
{
    if ( self.type == "dog" )
        return;

    self._id_22E0 = undefined;
    self._id_22DD = undefined;
    self._id_04CB = 0.3;
    self._id_22D6 = undefined;
}

_id_30EA()
{
    self._id_1944 = 1;
}

_id_2ACA()
{
    self._id_1944 = undefined;
}

_id_22CF( var_0 )
{
    if ( !isdefined( var_0 ) )
        self._id_22D8 = undefined;
    else
    {
        self._id_22D8 = var_0;

        if ( !isdefined( var_0.origin ) )
            return;
    }
}

_id_7E34( var_0 )
{
    if ( isdefined( var_0 ) && var_0 )
        self._id_39CB = 1;
    else
        self._id_39CB = undefined;
}

_id_2BC2( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_1 ) )
        [[ var_0 ]]( var_1 );
    else
        [[ var_0 ]]();

    if ( isdefined( var_3 ) )
        [[ var_2 ]]( var_3 );
    else
        [[ var_2 ]]();
}

_id_7C7C( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        self notify( var_0, var_1 );
    else
        self notify( var_0 );
}

_id_A08F( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3 endon( "complete" );
    var_3 delaythread( var_2, ::_id_7C7C, "complete" );
    self waittillmatch( var_0, var_1 );
}

_id_284D( var_0 )
{
    var_0 notify( "deleted" );
    var_0 delete();
}

_id_3813( var_0 )
{
    if ( !isdefined( self._id_93FE ) )
        self._id_93FE = [];

    if ( isdefined( self._id_93FE[var_0.unique_id] ) )
        return 0;

    self._id_93FE[var_0.unique_id] = 1;
    return 1;
}

_id_3EF3( var_0 )
{
    return level._id_78A9[self._id_0C72][var_0];
}

_id_4715( var_0 )
{
    return isdefined( level._id_78A9[self._id_0C72][var_0] );
}

_id_3EF4( var_0, var_1 )
{
    return level._id_78A9[var_1][var_0];
}

_id_3EF5( var_0 )
{
    return level._id_78A9["generic"][var_0];
}

_id_0764( var_0, var_1, var_2 )
{
    if ( !isdefined( level._id_97A1 ) )
    {
        level._id_97A1 = [];
        level._id_97A0 = [];
    }

    level._id_97A1[var_0] = var_1;
    precachestring( var_1 );

    if ( isdefined( var_2 ) )
        level._id_97A0[var_0] = var_2;
}

_id_84D5( var_0 )
{
    thread _id_A59B::_id_850E( var_0 );
}

_id_4854( var_0 )
{
    var_0._id_9364 = 1;
}

_id_37BF( var_0, var_1 )
{
    var_2 = spawn( "trigger_radius", var_0, 0, var_1, 48 );

    for (;;)
    {
        var_2 waittill( "trigger", var_3 );
        level.player dodamage( 5, var_0 );
    }
}

_id_1F0B( var_0, var_1 )
{
    setthreatbias( var_0, var_1, 0 );
    setthreatbias( var_1, var_0, 0 );
}

_id_9334()
{
    animscripts\combat_utility::_id_9335();
}

_id_0CDF( var_0, var_1 )
{
    if ( !var_0.size )
        return var_1;

    var_2 = getarraykeys( var_1 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        var_0[var_2[var_3]] = var_1[var_2[var_3]];

    return var_0;
}

_id_7E5A( var_0 )
{
    self._id_0202 = var_0;
}

_id_7E4A( var_0 )
{
    self._id_01C7 = var_0;
}

_id_9883()
{
    var_0 = self._id_3582;

    for (;;)
    {
        var_1 = self _meth_8093();

        if ( _id_88EB( var_1 ) )
        {
            wait 1;
            continue;
        }

        return var_1;
    }
}

_id_7DB2( var_0 )
{
    self._id_0031 = var_0;
}

_id_7EA5( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        self._id_0B0D = var_1;
    else
        self._id_0B0D = 1;

    _id_2AE9();
    self._id_76AC = level._id_78A9[self._id_0C72][var_0];
    self._id_A0FF = self._id_76AC;
}

_id_7E0F()
{
    self._id_0007._id_5F58 = "walk";
    self._id_2AF2 = 1;
    self._id_2B0D = 1;
    self._id_7A73 = 1;
}

_id_7DEA( var_0, var_1, var_2, var_3 )
{
    animscripts\animset::_id_4C82( var_0, var_1, var_2, var_3 );
}

_id_7E7A( var_0, var_1, var_2 )
{
    var_3 = animscripts\utility::_id_5861( var_0 );

    if ( isarray( var_1 ) )
    {
        var_3["straight"] = var_1[0];
        var_3["move_f"] = var_1[0];
        var_3["move_l"] = var_1[1];
        var_3["move_r"] = var_1[2];
        var_3["move_b"] = var_1[3];
    }
    else
    {
        var_3["straight"] = var_1;
        var_3["move_f"] = var_1;
    }

    if ( isdefined( var_2 ) )
        var_3["sprint"] = var_2;

    self._id_2562[var_0] = var_3;
}

_id_7E3E( var_0 )
{
    var_1 = level._id_78A9["generic"][var_0];

    if ( isarray( var_1 ) )
        self._id_8A29 = var_1;
    else
        self._id_8A29[0] = var_1;
}

_id_7E56( var_0 )
{
    var_1 = level._id_78A9[self._id_0C72][var_0];

    if ( isarray( var_1 ) )
        self._id_8A29 = var_1;
    else
        self._id_8A29[0] = var_1;
}

_id_1EBA()
{
    self._id_8A29 = undefined;
    self notify( "stop_specialidle" );
}

_id_7E3F( var_0, var_1 )
{
    _id_7E40( var_0, undefined, var_1 );
}

_id_1EBB()
{
    self notify( "movemode" );
    _id_3101();
    self._id_76AC = undefined;
    self._id_A0FF = undefined;
}

_id_7E40( var_0, var_1, var_2 )
{
    self notify( "movemode" );

    if ( !isdefined( var_2 ) || var_2 )
        self._id_0B0D = 1;
    else
        self._id_0B0D = undefined;

    _id_2AE9();
    self._id_76AC = level._id_78A9["generic"][var_0];
    self._id_A0FF = self._id_76AC;

    if ( isdefined( var_1 ) )
    {
        self._id_76AB = level._id_78A9["generic"][var_1];
        self._id_A0FE = self._id_76AB;
    }
    else
    {
        self._id_76AB = undefined;
        self._id_A0FE = undefined;
    }
}

_id_7EA6( var_0, var_1, var_2 )
{
    self notify( "movemode" );

    if ( !isdefined( var_2 ) || var_2 )
        self._id_0B0D = 1;
    else
        self._id_0B0D = undefined;

    _id_2AE9();
    self._id_76AC = level._id_78A9[self._id_0C72][var_0];
    self._id_A0FF = self._id_76AC;

    if ( isdefined( var_1 ) )
    {
        self._id_76AB = level._id_78A9[self._id_0C72][var_1];
        self._id_A0FE = self._id_76AB;
    }
    else
    {
        self._id_76AB = undefined;
        self._id_A0FE = undefined;
    }
}

_id_1ED1()
{
    self notify( "clear_run_anim" );
    self notify( "movemode" );

    if ( self.type == "dog" )
    {
        self._id_0007._id_5F58 = "run";
        self._id_2AF2 = 0;
        self._id_2B0D = 0;
        self._id_7A73 = undefined;
        return;
    }

    if ( !isdefined( self._id_1BC4 ) )
        _id_3101();

    self._id_0B0D = undefined;
    self._id_76AC = undefined;
    self._id_A0FF = undefined;
    self._id_76AB = undefined;
    self._id_A0FE = undefined;
}

_id_273A( var_0, var_1 )
{
    setdvarifuninitialized( var_0, var_1 );
    return getdvarfloat( var_0 );
}

_id_67FF( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "stop_physicsjolt" );

    if ( !isdefined( var_0 ) || !isdefined( var_1 ) || !isdefined( var_2 ) )
    {
        var_0 = 400;
        var_1 = 256;
        var_2 = ( 0.0, 0.0, 0.075 );
    }

    var_3 = var_0 * var_0;
    var_4 = 3;
    var_5 = var_2;

    for (;;)
    {
        wait 0.1;
        var_2 = var_5;

        if ( self.code_classname == "script_vehicle" )
        {
            var_6 = self _meth_8286();

            if ( var_6 < var_4 )
            {
                var_7 = var_6 / var_4;
                var_2 = var_5 * var_7;
            }
        }

        var_8 = distancesquared( self.origin, level.player.origin );
        var_7 = var_3 / var_8;

        if ( var_7 > 1 )
            var_7 = 1;

        var_2 *= var_7;
        var_9 = var_2[0] + var_2[1] + var_2[2];

        if ( var_9 > 0.025 )
            physicsjitter( self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0 );
    }
}

_id_7E42( var_0 )
{
    self _meth_81A7( var_0 );
}

_id_0706( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        _id_0707( var_2 );
    else
        common_scripts\utility::array_thread( getentarray( var_0, var_1 ), ::_id_0707, var_2 );
}

_id_0707( var_0 )
{
    self notify( "trigger", var_0 );
}

_id_7C6B()
{
    self delete();
}

_id_736C( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_0[var_2];

        if ( var_3 _id_46E5() )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_1EA7()
{
    _id_1EDA( "axis" );
    _id_1EDA( "allies" );
}

_id_1EDA( var_0 )
{
    level._id_250D[var_0]["r"] = undefined;
    level._id_250D[var_0]["b"] = undefined;
    level._id_250D[var_0]["c"] = undefined;
    level._id_250D[var_0]["y"] = undefined;
    level._id_250D[var_0]["p"] = undefined;
    level._id_250D[var_0]["o"] = undefined;
    level._id_250D[var_0]["g"] = undefined;
}

_id_3E58()
{
    var_0 = [];
    var_0["r"] = ( 1.0, 0.0, 0.0 );
    var_0["o"] = ( 1.0, 0.5, 0.0 );
    var_0["y"] = ( 1.0, 1.0, 0.0 );
    var_0["g"] = ( 0.0, 1.0, 0.0 );
    var_0["c"] = ( 0.0, 1.0, 1.0 );
    var_0["b"] = ( 0.0, 0.0, 1.0 );
    var_0["p"] = ( 1.0, 0.0, 1.0 );
    return var_0;
}

_id_61FA( var_0, var_1 )
{
    self endon( "death" );

    if ( var_1 > 0 )
        wait(var_1);

    if ( !isdefined( self ) )
        return;

    self notify( var_0 );
}

_id_445F()
{
    if ( isai( self ) )
        animscripts\shared::_id_6866( self.weapon, "none" );
    else
    {
        _id_2974( self.weapon );
        self detach( getweaponmodel( self.weapon ), "tag_weapon_right" );
    }
}

_id_445E()
{
    if ( isai( self ) )
        animscripts\shared::_id_6866( self.weapon, "right" );
    else
    {
        self attach( getweaponmodel( self.weapon ), "tag_weapon_right" );
        _id_9AE6( self.weapon );
    }
}

_id_9AE6( var_0 )
{
    if ( isdefined( var_0 ) && var_0 != "none" )
    {
        var_1 = _func_2B4( var_0 );
        var_2 = _id_0CFA( var_1, 0 );

        foreach ( var_4 in var_2 )
            self attach( var_4["worldModel"], var_4["attachTag"] );

        self _meth_8509( var_0 );
    }
}

_id_2974( var_0 )
{
    if ( isdefined( var_0 ) && var_0 != "none" )
    {
        var_1 = _func_2B4( var_0 );
        var_2 = _id_0CFA( var_1, 0 );

        foreach ( var_4 in var_2 )
            self detach( var_4["worldModel"], var_4["attachTag"], 0 );
    }
}

_id_0DEC( var_0 )
{
    var_1 = level.player getcurrentweapon();
    var_2 = _func_2B4( var_1 );
    var_3 = var_2[0]["weapon"];
    var_4 = _id_0CFA( var_2, 0 );
    var_0 attach( var_3, "TAG_WEAPON_RIGHT", 1 );

    foreach ( var_6 in var_4 )
        var_0 attach( var_6["attachment"], var_6["attachTag"] );

    var_0 _meth_8509( var_1 );
}

_id_685A( var_0, var_1 )
{
    if ( !animscripts\utility::_id_095B( var_0 ) )
        animscripts\init::_id_4E2F( var_0 );

    animscripts\shared::_id_6866( var_0, var_1 );
}

_id_39CE( var_0, var_1 )
{
    if ( !animscripts\init::_id_5205( var_0 ) )
        animscripts\init::_id_4E2F( var_0 );

    var_2 = self.weapon != "none";
    var_3 = animscripts\utility::_id_9C32();
    var_4 = var_1 == "sidearm";
    var_5 = var_1 == "secondary";

    if ( var_2 && var_3 != var_4 )
    {
        if ( var_3 )
            var_6 = "none";
        else if ( var_5 )
            var_6 = "back";
        else
            var_6 = "chest";

        animscripts\shared::_id_6866( self.weapon, var_6 );
        self._id_560C = self.weapon;
    }
    else
        self._id_560C = var_0;

    animscripts\shared::_id_6866( var_0, "right" );

    if ( var_4 )
        self._id_8557 = var_0;
    else if ( var_5 )
        self.secondaryweapon = var_0;
    else
        self.primaryweapon = var_0;

    self.weapon = var_0;
    self._id_18B0 = weaponclipsize( self.weapon );
    self notify( "weapon_switch_done" );
}

_id_5693( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    _id_A59B::_id_5695( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0 );
}

_id_5694( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    _id_A59B::_id_5695( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1 );
}

_id_5690( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_9 = _id_3E23();
    var_10 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_10.origin = var_9.origin;
    var_10.angles = var_9 getangles();

    if ( isdefined( var_8 ) && var_8 )
        var_9 playerlinkto( var_10, "", var_3, var_4, var_5, var_6, var_7, var_8 );
    else if ( isdefined( var_4 ) )
        var_9 playerlinkto( var_10, "", var_3, var_4, var_5, var_6, var_7 );
    else if ( isdefined( var_3 ) )
        var_9 playerlinkto( var_10, "", var_3 );
    else
        var_9 playerlinkto( var_10 );

    var_10 moveto( var_0, var_2, var_2 * 0.25 );
    var_10 _meth_82B5( var_1, var_2, var_2 * 0.25 );
    wait(var_2);
    var_10 delete();
}

_id_5696( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    _id_A59B::_id_5697( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0 );
}

_id_5692( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = _id_3E23();
    var_10 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_10.origin = var_9 _id_3E22();
    var_10.angles = var_9 getangles();

    if ( isdefined( var_8 ) )
        var_9 _meth_807D( var_10, "", var_3, var_4, var_5, var_6, var_7, var_8 );
    else if ( isdefined( var_4 ) )
        var_9 _meth_807D( var_10, "", var_3, var_4, var_5, var_6, var_7 );
    else if ( isdefined( var_3 ) )
        var_9 _meth_807D( var_10, "", var_3 );
    else
        var_9 _meth_807D( var_10 );

    var_10 moveto( var_0, var_2, var_2 * 0.25 );
    var_10 _meth_82B5( var_1, var_2, var_2 * 0.25 );
    wait(var_2);
    var_10 delete();
}

_id_6BA4( var_0 )
{
    var_1 = level.player.origin;

    for (;;)
    {
        if ( distance( var_1, level.player.origin ) > var_0 )
            break;

        wait 0.05;
    }
}

_id_A080( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    thread _id_A59B::_id_A081( var_4, var_0, var_1 );
    thread _id_A59B::_id_A081( var_4, var_2, var_3 );
    var_4 waittill( "done" );
}

_id_A090( var_0 )
{
    self waittill( var_0 );
}

_id_2B49( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = _id_3E23();

    if ( isdefined( level._id_97A0[var_0] ) )
    {
        if ( var_5 [[ level._id_97A0[var_0] ]]() )
            return;

        var_5 thread _id_A59B::_id_490A( level._id_97A1[var_0], level._id_97A0[var_0], var_1, var_2, var_3, undefined, undefined, var_4 );
    }
    else
        var_5 thread _id_A59B::_id_490A( level._id_97A1[var_0], undefined, undefined, undefined, undefined, undefined, undefined, var_4 );
}

_id_48F6( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    _id_A59B::_id_48F7( var_0 );

    if ( !isdefined( var_1 ) )
        _id_2B49( var_0, var_2, var_3, var_4, var_5 );
    else
        _id_2B4E( var_0, var_1, var_2, var_3, var_4, var_5 );
}

_id_48F9( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = _id_3E23();

    if ( var_6 [[ level._id_97A0[var_0] ]]() )
        return;

    _id_A59B::_id_48F7( var_0 );
    var_6 thread _id_A59B::_id_490A( level._id_97A1[var_0], level._id_97A0[var_0], var_3, var_4, var_5, var_1, var_2 );
}

_id_0746( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( level._id_97A1 ) )
    {
        level._id_97A1 = [];
        level._id_97A0 = [];
    }

    level._id_97A1[var_0] = var_1;
    level._id_48CF[var_0]["gamepad"] = var_1;
    level._id_48CF[var_0]["pc"] = var_3;
    level._id_48CF[var_0]["southpaw"] = var_4;
    precachestring( var_1 );

    if ( isdefined( var_3 ) )
        precachestring( var_3 );

    if ( isdefined( var_4 ) )
        precachestring( var_4 );

    if ( isdefined( var_2 ) )
        level._id_97A0[var_0] = var_2;
}

_id_4686()
{
    if ( !isdefined( level._id_48E8 ) )
        level._id_48E8 = [];

    for (;;)
    {
        level._id_48E8 = common_scripts\utility::array_removeundefined( level._id_48E8 );

        if ( isdefined( level._id_48E8 ) && isdefined( level.player ) )
        {
            foreach ( var_1 in level._id_48E8 )
            {
                if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
                {
                    var_1 sethintstring( var_1._id_42DD );
                    continue;
                }

                var_1 sethintstring( var_1._id_6738 );
            }
        }

        wait 0.1;
    }
}

_id_07E4( var_0, var_1 )
{
    if ( !isdefined( level._id_48E8 ) )
    {
        thread _id_4686();
        level._id_48E8 = [];
    }

    var_2 = 0;

    foreach ( var_4 in level._id_48E8 )
    {
        if ( self == var_4 )
        {
            var_4._id_42DD = var_0;
            var_4._id_6738 = var_1;
            var_2 = 1;
            break;
        }
    }

    if ( !var_2 )
    {
        self._id_42DD = var_0;
        self._id_6738 = var_1;
        level._id_48E8 = common_scripts\utility::array_add( level._id_48E8, self );
    }
}

_id_2B4E( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = _id_3E23();

    if ( var_6 [[ level._id_97A0[var_0] ]]() )
        return;

    var_6 thread _id_A59B::_id_490A( level._id_97A1[var_0], level._id_97A0[var_0], var_2, var_3, var_4, var_1, undefined, var_5 );
}

_id_2B4F( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = _id_3E23();

    if ( var_6 [[ level._id_97A0[var_0] ]]() )
        return;

    var_6 thread _id_A59B::_id_490A( level._id_97A1[var_0], level._id_97A0[var_0], var_3, var_4, var_5, var_1, var_2 );
}

_id_2B4B( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_6 ) )
        var_6 = 0;

    var_10 = _id_A59B::_id_48DF( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
    thread _id_2B49( var_10, var_7, var_8, var_9 );
    thread _id_A59B::_id_48E0( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
}

_id_2B4C( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( !isdefined( var_7 ) )
        var_7 = 0;

    var_11 = _id_A59B::_id_48DF( var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
    thread _id_2B4E( var_11, var_1, var_8, var_9, var_10 );
    thread _id_A59B::_id_48E0( var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

_id_2B4D( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( var_8 ) )
        var_8 = 0;

    var_12 = _id_A59B::_id_48DF( var_0, var_3, var_4, var_5, var_6, var_7, var_8 );
    thread _id_2B4F( var_12, var_1, var_2, var_9, var_10, var_11 );
    thread _id_A59B::_id_48E0( var_0, var_3, var_4, var_5, var_6, var_7, var_8 );
}

_id_1CC6( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
        return [[ level._id_97A0[var_0] ]]( var_1, var_2, var_3 );

    if ( isdefined( var_2 ) )
        return [[ level._id_97A0[var_0] ]]( var_1, var_2 );

    if ( isdefined( var_1 ) )
        return [[ level._id_97A0[var_0] ]]( var_1 );

    return [[ level._id_97A0[var_0] ]]();
}

_id_3FAA( var_0 )
{
    return level._id_78A9["generic"][var_0];
}

_id_30A9()
{
    self._id_7968 = 1;
}

_id_2A85()
{
    self._id_7968 = 0;
    self notify( "stop_being_careful" );
}

_id_30F0()
{
    self._id_8AA2 = 1;
}

_id_2AD1()
{
    self._id_8AA2 = undefined;
}

_id_2A84()
{
    self._id_2AF6 = 1;
}

_id_30A8()
{
    self._id_2AF6 = undefined;
}

_id_1EB2( var_0 )
{
    setdvar( var_0, "" );
}

_id_7E1E()
{
    self._id_0180 = 1;
}

_id_7E1D()
{
    self._id_0180 = 0;
}

_id_88BD( var_0, var_1 )
{
    if ( isdefined( self._id_798B ) )
    {
        self endon( "death" );
        wait(self._id_798B);
    }

    var_2 = undefined;
    var_3 = isdefined( self._id_7ADB ) && common_scripts\utility::flag( "_stealth_enabled" ) && !common_scripts\utility::flag( "_stealth_spotted" );

    if ( isdefined( self._id_79E6 ) || isdefined( var_0 ) )
    {
        if ( !isdefined( self._id_79A8 ) )
            var_2 = self _meth_8094( var_3 );
        else
            var_2 = _id_2F28( self );
    }
    else if ( !isdefined( self._id_79A8 ) )
        var_2 = self _meth_8093( var_3 );
    else
        var_2 = _id_2F28( self );

    if ( isdefined( var_1 ) && var_1 && isalive( var_2 ) )
        var_2 _id_58D4();

    if ( !isdefined( self._id_79A8 ) )
        _id_88EB( var_2 );

    if ( isdefined( self._id_7AC7 ) )
        self delete();

    if ( isdefined( var_2 ) )
        var_2._id_03DA = self;

    if ( isdefined( var_2 ) && !isdefined( var_2.targetname ) )
    {
        if ( isdefined( self.targetname ) )
            var_2.targetname = self.targetname + "_AI";
    }

    return var_2;
}

_id_3AF0( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6 thread _id_A59B::_id_3AF4( self, var_0, var_1, var_2, var_3, var_4, var_5 );
    return _id_A59B::_id_3AF8( var_6 );
}

_id_3AF6( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = spawnstruct();
    var_7 thread _id_A59B::_id_3AF4( self, var_1, var_2, var_3, var_4, var_5, var_6 );

    if ( isdefined( var_7._id_3AF3 ) || var_7 common_scripts\utility::waittill_any_timeout( var_0, "function_stack_func_begun" ) != "timeout" )
        return _id_A59B::_id_3AF8( var_7 );
    else
    {
        var_7 notify( "death" );
        return 0;
    }
}

_id_3AF2()
{
    var_0 = [];

    if ( isdefined( self._id_3AF0[0] ) && isdefined( self._id_3AF0[0]._id_3AF3 ) )
        var_0[0] = self._id_3AF0[0];

    self._id_3AF0 = undefined;
    self notify( "clear_function_stack" );
    waittillframeend;

    if ( !var_0.size )
        return;

    if ( !var_0[0]._id_3AF3 )
        return;

    self._id_3AF0 = var_0;
}

_id_3CAB()
{
    if ( isdefined( self._id_3CAB ) )
        return;

    self.realorigin = self getorigin();
    self moveto( self.realorigin + ( 0.0, 0.0, -10000.0 ), 0.2 );
    self._id_3CAB = 1;
}

_id_3CAC()
{
    if ( !isdefined( self._id_3CAB ) )
        return;

    self moveto( self.realorigin, 0.2 );
    self waittill( "movedone" );
    self._id_3CAB = undefined;
}

_id_2A9C()
{
    self._id_2B0D = 1;
}

_id_30BC()
{
    self._id_2B0D = undefined;
}

_id_2AE9()
{
    self._id_623C = 1;
}

_id_3101()
{
    self._id_623C = undefined;
}

_id_2A79()
{
    self._id_2AF2 = 1;
}

_id_30A0()
{
    self endon( "death" );
    waittillframeend;
    self._id_2AF2 = undefined;
}

_id_7DDC( var_0, var_1 )
{
    magicgrenademanual( var_0, var_1 );
}

_id_7E48( var_0 )
{
    self._id_01C7 = var_0;
}

_id_7E45( var_0 )
{
    self._id_5555 = var_0;
    self._id_5556 = undefined;
    self._id_5554 = undefined;
    self _meth_81A5( var_0 );
}

_id_7E46( var_0 )
{
    var_1 = getnode( var_0, "targetname" );
    _id_7E45( var_1 );
}

_id_7E47( var_0 )
{
    self._id_5555 = undefined;
    self._id_5556 = var_0;
    self._id_5554 = undefined;
    self _meth_81A6( var_0 );
}

_id_7E41( var_0 )
{
    _id_7E47( var_0.origin );
    self._id_5554 = var_0;
}

_id_62E9( var_0 )
{
    _id_A59B::_id_62F1( var_0 );
    objective_state( var_0, "done" );
    level notify( "objective_complete" + var_0 );
}

_id_4694( var_0, var_1, var_2, var_3 )
{
    var_4 = 1;

    if ( isdefined( var_1 ) )
        var_4 = !var_1;

    if ( isdefined( var_2 ) )
        level endon( var_2 );

    if ( isdefined( var_3 ) )
        level waittill( var_3 );

    var_5 = "signal_" + var_0;

    if ( self._id_0007._id_6E57 == "crouch" )
        var_5 += "_crouch";
    else if ( self.script == "cover_right" || self.script == "cover_multi" && self._id_00DA._id_8D50 == "right" )
        var_5 += "_coverR";
    else if ( animscripts\utility::_id_50E6() )
        var_5 += "_cqb";

    if ( var_4 )
        self _meth_814D( _id_3FAA( var_5 ), 1, 0, 1.1 );
    else
        _id_A506::_id_0BC9( self, var_5 );
}

_id_0D08( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = [];

    foreach ( var_5 in var_0 )
    {
        var_5.count = 1;

        if ( getsubstr( var_5.classname, 7, 10 ) == "veh" )
        {
            var_6 = var_5 _id_896F();

            if ( isdefined( var_6.target ) && !isdefined( var_6._id_7A3A ) )
                var_6 thread _id_A59E::_id_4277();

            var_3[var_3.size] = var_6;
            continue;
        }

        var_6 = var_5 _id_88BD( var_1 );

        if ( !var_2 )
        {

        }

        var_3[var_3.size] = var_6;
    }

    if ( !var_2 )
    {

    }

    return var_3;
}

_id_0D0A( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_4 = [];

    foreach ( var_6 in var_0 )
    {
        var_6.count = 1;

        if ( getsubstr( var_6.classname, 7, 10 ) == "veh" )
        {
            var_7 = var_6 _id_896F();

            if ( isdefined( var_7.target ) && !isdefined( var_7._id_7A3A ) )
                var_7 thread _id_A59E::_id_4277();

            var_4[var_4.size] = var_7;
            continue;
        }

        var_7 = var_6 _id_88BD( 1 );
        var_4 = common_scripts\utility::array_add( var_4, var_7 );

        if ( isdefined( var_3 ) )
        {
            wait(var_3);
            continue;
        }

        waitframe();
    }

    if ( !var_2 )
    {

    }

    return var_4;
}

_id_0D0F( var_0, var_1, var_2, var_3 )
{
    var_4 = getentarray( var_0, "targetname" );

    if ( isdefined( level._id_8938 ) )
    {
        var_5 = common_scripts\utility::getstructarray( var_0, "targetname" );

        if ( isdefined( var_3 ) && var_3 )
            _id_286E( var_5 );

        var_6 = _id_A577::_id_3E33( var_5 );
        var_4 = common_scripts\utility::array_combine( var_4, var_6 );
    }

    return _id_0D08( var_4, var_1, var_2 );
}

_id_0D11( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getentarray( var_0, "targetname" );

    if ( isdefined( level._id_8938 ) )
    {
        var_6 = common_scripts\utility::getstructarray( var_0, "targetname" );

        if ( isdefined( var_4 ) && var_4 )
            _id_286E( var_6 );

        var_7 = _id_A577::_id_3E33( var_6 );
        var_5 = common_scripts\utility::array_combine( var_5, var_7 );
    }

    return _id_0D0A( var_5, var_1, var_3, var_2 );
}

_id_0D0E( var_0, var_1, var_2, var_3 )
{
    var_4 = getentarray( var_0, "script_noteworthy" );

    if ( isdefined( level._id_8938 ) )
    {
        var_5 = common_scripts\utility::getstructarray( var_0, "script_noteworthy" );

        if ( isdefined( var_3 ) && var_3 )
            _id_286E( var_5 );

        var_6 = _id_A577::_id_3E33( var_5 );
        var_4 = common_scripts\utility::array_combine( var_4, var_6 );
    }

    return _id_0D08( var_4, var_1, var_2 );
}

_id_8945( var_0, var_1 )
{
    var_2 = getent( var_0, "script_noteworthy" );
    var_3 = var_2 _id_88BD( var_1 );
    return var_3;
}

_id_8957( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_3 = var_2 _id_88BD( var_1 );
    return var_3;
}

_id_0757( var_0, var_1, var_2 )
{
    if ( getdvarint( "loc_warnings", 0 ) )
        return;

    if ( !isdefined( level._id_2A17 ) )
        level._id_2A17 = [];

    var_3 = 0;

    for (;;)
    {
        if ( !isdefined( level._id_2A17[var_3] ) )
            break;

        var_3++;
    }

    var_4 = "^3";

    if ( isdefined( var_2 ) )
    {
        switch ( var_2 )
        {
            case "r":
            case "red":
                var_4 = "^1";
                break;
            case "g":
            case "green":
                var_4 = "^2";
                break;
            case "y":
            case "yellow":
                var_4 = "^3";
                break;
            case "b":
            case "blue":
                var_4 = "^4";
                break;
            case "c":
            case "cyan":
                var_4 = "^5";
                break;
            case "p":
            case "purple":
                var_4 = "^6";
                break;
            case "w":
            case "white":
                var_4 = "^7";
                break;
            case "black":
            case "bl":
                var_4 = "^8";
                break;
        }
    }

    level._id_2A17[var_3] = 1;
    var_5 = _id_A53C::createfontstring( "default", 1.5 );
    var_5.location = 0;
    var_5.alignx = "left";
    var_5.aligny = "top";
    var_5.foreground = 1;
    var_5.sort = 20;
    var_5.alpha = 0;
    var_5 fadeovertime( 0.5 );
    var_5.alpha = 1;
    var_5.x = 40;
    var_5.y = 260 + var_3 * 18;
    var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
    var_5.color = ( 1.0, 1.0, 1.0 );
    wait 2;
    var_6 = 40;
    var_5 fadeovertime( 6 );
    var_5.alpha = 0;

    for ( var_7 = 0; var_7 < var_6; var_7++ )
    {
        var_5.color = ( 1, 1, 0 / ( var_6 - var_7 ) );
        wait 0.05;
    }

    wait 4;
    var_5 destroy();
    level._id_2A17[var_3] = undefined;
}

_id_290A()
{
    common_scripts\_destructible::_id_2AA0();
}

_id_290E()
{
    common_scripts\_destructible::_id_3993();
}

_id_7E4C( var_0 )
{
    self._id_01D3 = var_0;
}

_id_3E22()
{
    var_0 = self.origin;
    var_1 = anglestoup( self getangles() );
    var_2 = self _meth_82F2();
    var_3 = var_0 + ( 0, 0, var_2 );
    var_4 = var_0 + var_1 * var_2;
    var_5 = var_3 - var_4;
    var_6 = var_0 + var_5;
    return var_6;
}

_id_7DD7( var_0 )
{
    self._id_1300 = var_0;
}

set_console_status()
{
    if ( !isdefined( level.console ) )
        level.console = getdvar( "consoleGame" ) == "true";
    else
    {

    }

    if ( !isdefined( level.xenon ) )
        level.xenon = getdvar( "xenonGame" ) == "true";
    else
    {

    }

    if ( !isdefined( level.ps3 ) )
        level.ps3 = getdvar( "ps3Game" ) == "true";
    else
    {

    }

    if ( !isdefined( level._id_0524 ) )
        level._id_0524 = getdvar( "wiiuGame" ) == "true";
    else
    {

    }

    if ( !isdefined( level._id_0301 ) )
        level._id_0301 = getdvar( "pccgGame" ) == "true";
    else
    {

    }

    if ( !isdefined( level.xb3 ) )
        level.xb3 = getdvar( "xb3Game" ) == "true";
    else
    {

    }

    if ( !isdefined( level.ps4 ) )
        level.ps4 = getdvar( "ps4Game" ) == "true";
    else
    {

    }

    if ( !isdefined( level._id_0300 ) )
        level._id_0300 = !level.console && !level._id_0301;
    else
    {

    }

    if ( !isdefined( level.currentgen ) )
        level.currentgen = level.ps3 || level._id_0301 || level.xenon || level._id_0524;
    else
    {

    }

    if ( !isdefined( level.nextgen ) )
        level.nextgen = level._id_0300 || level.ps4 || level.xb3;
    else
    {

    }
}

is_gen4()
{
    return level.nextgen;
}

_id_114E( var_0 )
{
    return _id_A50A::_id_055C( var_0 );
}

_id_114F()
{
    return _id_A50A::_id_055C( 1 );
}

_id_7E3D( var_0 )
{
    self._id_2651 = _id_3FAA( var_0 );
}

_id_7E00( var_0 )
{
    self._id_2651 = _id_3EF3( var_0 );
}

_id_1EAB()
{
    self._id_2651 = undefined;
}

_id_4B06( var_0 )
{
    wait 1.75;

    if ( isdefined( var_0 ) )
        self playsound( var_0 );
    else
        self playsound( "door_wood_slow_open" );

    self _meth_82B5( self.angles + ( 0.0, 70.0, 0.0 ), 2, 0.5, 0 );
    self connectpaths();
    self waittill( "rotatedone" );
    self _meth_82B5( self.angles + ( 0.0, 40.0, 0.0 ), 2, 0, 2 );
}

_id_6663( var_0 )
{
    wait 1.35;

    if ( isdefined( var_0 ) )
        self playsound( var_0 );
    else
        self playsound( "door_wood_slow_open" );

    self _meth_82B5( self.angles + ( 0.0, 70.0, 0.0 ), 2, 0.5, 0 );
    self connectpaths();
    self waittill( "rotatedone" );
    self _meth_82B5( self.angles + ( 0.0, 40.0, 0.0 ), 2, 0, 2 );
}

_id_5686( var_0, var_1 )
{
    foreach ( var_3 in level.players )
        var_3 _meth_8031( var_1, var_0 );

    wait(var_0);
}

_id_5688( var_0, var_1 )
{
    var_2 = getdvarfloat( "cg_fovscale" );
    var_3 = int( var_0 / 0.05 );
    var_4 = ( var_1 - var_2 ) / var_3;
    var_5 = var_2;

    for ( var_6 = 0; var_6 < var_3; var_6++ )
    {
        var_5 += var_4;
        _func_0D3( "cg_fovscale", var_5 );
        wait 0.05;
    }

    _func_0D3( "cg_fovscale", var_1 );
}

_id_7062()
{
    animscripts\shared::_id_6866( self.weapon, "none" );
    self.weapon = "none";
}

_id_0CA2()
{
    _id_A509::_id_7E2F( 0 );
}

_id_0CA1()
{
    _id_A509::_id_7E2F( 1 );
}

_id_0C3D()
{
    self _meth_8141();
    self notify( "stop_loop" );
    self notify( "single anim", "end" );
    self notify( "looping anim", "end" );
}

_id_2AC1()
{
    self._id_0007._id_2B1F = 1;
    self._id_0034 = 0;
}

_id_30D8()
{
    self._id_0007._id_2B1F = 0;
    self._id_0034 = 1;
}

_id_057D()
{
    self delete();
}

_id_05D9()
{
    self _meth_8052();
}

_id_5343()
{
    if ( isplayer( self ) )
    {
        if ( common_scripts\utility::flag_exist( "special_op_terminated" ) && common_scripts\utility::flag( "special_op_terminated" ) )
            return 0;

        if ( _id_505F( self ) )
            self _meth_80F0();
    }

    self _meth_80EC( 0 );
    self _meth_8052();
    return 1;
}

_id_0635( var_0 )
{
    self _meth_8167( var_0 );
}

_id_056A()
{
    self _meth_8168();
}

_id_0679()
{
    self unlink();
}

_id_2ABF( var_0 )
{
    var_1 = getarraykeys( level._id_05C3[var_0] );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        level._id_05C3[var_0][var_1[var_2]]._id_5878 delete();
        level._id_05C3[var_0][var_1[var_2]] = undefined;
    }
}

_id_0639( var_0 )
{
    self _meth_81DF( var_0 );
}

_id_05E1( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
    {
        self linkto( var_0, var_1, var_2, var_3 );
        return;
    }

    if ( isdefined( var_2 ) )
    {
        self linkto( var_0, var_1, var_2 );
        return;
    }

    if ( isdefined( var_1 ) )
    {
        self linkto( var_0, var_1 );
        return;
    }

    self linkto( var_0 );
}

_id_0D18( var_0, var_1, var_2 )
{
    var_3 = getarraykeys( var_0 );
    var_4 = [];

    for ( var_5 = 0; var_5 < var_3.size; var_5++ )
        var_6 = var_3[var_5];

    for ( var_5 = 0; var_5 < var_3.size; var_5++ )
    {
        var_6 = var_3[var_5];
        var_4[var_6] = spawnstruct();
        var_4[var_6]._id_0558 = 1;
        var_4[var_6] thread _id_A59B::_id_0D19( var_0[var_6], var_1, var_2 );
    }

    for ( var_5 = 0; var_5 < var_3.size; var_5++ )
    {
        var_6 = var_3[var_5];

        if ( isdefined( var_0[var_6] ) && var_4[var_6]._id_0558 )
            var_4[var_6] waittill( "_array_wait" );
    }
}

_id_2A50()
{
    self _meth_8052( ( 0.0, 0.0, 0.0 ) );
}

_id_4024( var_0 )
{
    return level._id_78B2[var_0];
}

_id_50A6()
{
    return self playerads() > 0.5;
}

_id_A0A3( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_5 ) )
        var_5 = level.player;

    var_6 = spawnstruct();

    if ( isdefined( var_3 ) )
        var_6 thread _id_61FA( "timeout", var_3 );

    var_6 endon( "timeout" );

    if ( !isdefined( var_0 ) )
        var_0 = 0.92;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_7 = int( var_1 * 20 );
    var_8 = var_7;
    self endon( "death" );
    var_9 = isai( self );
    var_10 = undefined;

    for (;;)
    {
        if ( var_9 )
            var_10 = self geteye();
        else
            var_10 = self.origin;

        if ( var_5 _id_6B8E( var_10, var_0, var_2, var_4 ) )
        {
            var_8--;

            if ( var_8 <= 0 )
                return 1;
        }
        else
            var_8 = var_7;

        wait 0.05;
    }
}

_id_A0A4( var_0, var_1, var_2, var_3 )
{
    _id_A0A3( var_1, var_0, var_2, undefined, var_3 );
}

_id_6B8E( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.8;

    var_4 = _id_3E23();
    var_5 = var_4 geteye();
    var_6 = vectortoangles( var_0 - var_5 );
    var_7 = anglestoforward( var_6 );
    var_8 = var_4 getangles();
    var_9 = anglestoforward( var_8 );
    var_10 = vectordot( var_7, var_9 );

    if ( var_10 < var_1 )
        return 0;

    if ( isdefined( var_2 ) )
        return 1;

    var_11 = bullettrace( var_0, var_5, 0, var_3 );
    return var_11["fraction"] == 1;
}

_id_3020( var_0, var_1, var_2, var_3 )
{
    for ( var_4 = 0; var_4 < level.players.size; var_4++ )
    {
        if ( level.players[var_4] _id_6B8E( var_0, var_1, var_2, var_3 ) )
            return 1;
    }

    return 0;
}

_id_6A95( var_0, var_1 )
{
    var_2 = gettime();

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( isdefined( var_0._id_6D43 ) && var_0._id_6D43 + var_1 >= var_2 )
        return var_0._id_6D42;

    var_0._id_6D43 = var_2;

    if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_0.origin, 0.766 ) )
    {
        var_0._id_6D42 = 0;
        return 0;
    }

    var_3 = level.player geteye();
    var_4 = var_0.origin;

    if ( sighttracepassed( var_3, var_4, 1, level.player, var_0 ) )
    {
        var_0._id_6D42 = 1;
        return 1;
    }

    var_5 = var_0 geteye();

    if ( sighttracepassed( var_3, var_5, 1, level.player, var_0 ) )
    {
        var_0._id_6D42 = 1;
        return 1;
    }

    var_6 = ( var_5 + var_4 ) * 0.5;

    if ( sighttracepassed( var_3, var_6, 1, level.player, var_0 ) )
    {
        var_0._id_6D42 = 1;
        return 1;
    }

    var_0._id_6D42 = 0;
    return 0;
}

_id_6D3A( var_0, var_1 )
{
    var_2 = var_0 * var_0;

    for ( var_3 = 0; var_3 < level.players.size; var_3++ )
    {
        if ( distancesquared( var_1, level.players[var_3].origin ) < var_2 )
            return 1;
    }

    return 0;
}

_id_08D6( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_2 = 0.75;

    if ( issplitscreen() )
        var_2 = 0.65;

    while ( var_0.size > 0 )
    {
        wait 1;

        for ( var_3 = 0; var_3 < var_0.size; var_3++ )
        {
            if ( !isdefined( var_0[var_3] ) || !isalive( var_0[var_3] ) )
            {
                var_0 = common_scripts\utility::array_remove( var_0, var_0[var_3] );
                continue;
            }

            if ( _id_6D3A( var_1, var_0[var_3].origin ) )
                continue;

            if ( _id_3020( var_0[var_3].origin + ( 0.0, 0.0, 48.0 ), var_2, 1 ) )
                continue;

            if ( isdefined( var_0[var_3]._id_58D4 ) )
                var_0[var_3] _id_8E9E();

            var_0[var_3] delete();
            var_0 = common_scripts\utility::array_remove( var_0, var_0[var_3] );
        }
    }
}

_id_07BE( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4._id_1A08 = self;
    var_4.func = var_0;
    var_4._id_6692 = [];

    if ( isdefined( var_1 ) )
        var_4._id_6692[var_4._id_6692.size] = var_1;

    if ( isdefined( var_2 ) )
        var_4._id_6692[var_4._id_6692.size] = var_2;

    if ( isdefined( var_3 ) )
        var_4._id_6692[var_4._id_6692.size] = var_3;

    level._id_9F7A[level._id_9F7A.size] = var_4;
}

_id_072E( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4._id_1A08 = self;
    var_4.func = var_0;
    var_4._id_6692 = [];

    if ( isdefined( var_1 ) )
        var_4._id_6692[var_4._id_6692.size] = var_1;

    if ( isdefined( var_2 ) )
        var_4._id_6692[var_4._id_6692.size] = var_2;

    if ( isdefined( var_3 ) )
        var_4._id_6692[var_4._id_6692.size] = var_3;

    level._id_06BD[level._id_06BD.size] = var_4;
}

_id_075F( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6._id_1A08 = self;
    var_6.func = var_0;
    var_6._id_6692 = [];

    if ( isdefined( var_1 ) )
        var_6._id_6692[var_6._id_6692.size] = var_1;

    if ( isdefined( var_2 ) )
        var_6._id_6692[var_6._id_6692.size] = var_2;

    if ( isdefined( var_3 ) )
        var_6._id_6692[var_6._id_6692.size] = var_3;

    if ( isdefined( var_4 ) )
        var_6._id_6692[var_6._id_6692.size] = var_4;

    if ( isdefined( var_5 ) )
        var_6._id_6692[var_6._id_6692.size] = var_5;

    level._id_76A8[level._id_76A8.size] = var_6;
}

_id_073C( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6._id_1A08 = self;
    var_6.func = var_0;
    var_6._id_6692 = [];

    if ( isdefined( var_1 ) )
        var_6._id_6692[var_6._id_6692.size] = var_1;

    if ( isdefined( var_2 ) )
        var_6._id_6692[var_6._id_6692.size] = var_2;

    if ( isdefined( var_3 ) )
        var_6._id_6692[var_6._id_6692.size] = var_3;

    if ( isdefined( var_4 ) )
        var_6._id_6692[var_6._id_6692.size] = var_4;

    if ( isdefined( var_5 ) )
        var_6._id_6692[var_6._id_6692.size] = var_5;

    level._id_76A4[level._id_76A4.size] = var_6;
}

_id_077B( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6.func = var_0;
    var_6._id_6692 = [];

    if ( isdefined( var_1 ) )
        var_6._id_6692[var_6._id_6692.size] = var_1;

    if ( isdefined( var_2 ) )
        var_6._id_6692[var_6._id_6692.size] = var_2;

    if ( isdefined( var_3 ) )
        var_6._id_6692[var_6._id_6692.size] = var_3;

    if ( isdefined( var_4 ) )
        var_6._id_6692[var_6._id_6692.size] = var_4;

    if ( isdefined( var_5 ) )
        var_6._id_6692[var_6._id_6692.size] = var_5;

    level._id_76AA[level._id_76AA.size] = var_6;
}

_id_075B( var_0 )
{
    var_1 = spawnstruct();
    var_1._id_1A08 = self;
    var_1._id_315A = var_0;
    level._id_2BDD[level._id_2BDD.size] = var_1;
}

_id_2BDC()
{
    _id_2BDB( level._id_9F7A.size - 1 );
}

_id_2BDB( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = spawnstruct();
    var_2 = level._id_9F7A;
    var_3 = level._id_2BDD;
    var_4 = level._id_76A8;
    var_5 = level._id_76A4;
    var_6 = level._id_76AA;
    var_7 = level._id_06BD;
    level._id_9F7A = [];
    level._id_76A8 = [];
    level._id_2BDD = [];
    level._id_06BD = [];
    level._id_76A4 = [];
    level._id_76AA = [];
    var_1.count = var_2.size;
    var_1 common_scripts\utility::array_levelthread( var_2, _id_A59B::_id_A088, var_3 );
    var_1 thread _id_A59B::_id_2BB4( var_7 );
    var_1 endon( "any_funcs_aborted" );

    for (;;)
    {
        if ( var_1.count <= var_0 )
            break;

        var_1 waittill( "func_ended" );
    }

    var_1 notify( "all_funcs_ended" );
    common_scripts\utility::array_levelthread( var_4, _id_A59B::_id_33EA, [] );
    common_scripts\utility::array_levelthread( var_5, _id_A59B::_id_33E8 );
    common_scripts\utility::array_levelthread( var_6, _id_A59B::_id_33E9 );
}

_id_2BC0()
{
    var_0 = spawnstruct();
    var_1 = level._id_76A8;
    level._id_76A8 = [];

    foreach ( var_3 in var_1 )
        level _id_A59B::_id_33EA( var_3, [] );

    var_0 notify( "all_funcs_ended" );
}

_id_5013()
{
    if ( isdefined( level._id_39B4 ) && level._id_39B4 == 1 )
        return 0;

    if ( isdefined( level._id_278B ) && level._id_278B == level._id_8C30 )
        return 1;

    if ( isdefined( level._id_278A ) )
        return level._id_8C30 == "default";

    if ( _id_56BF() )
        return level._id_8C30 == level._id_8BAF[0]["name"];

    return level._id_8C30 == "default";
}

_id_39A4()
{
    level._id_39B4 = 1;
}

_id_5027()
{
    if ( !_id_56BF() )
        return 1;

    return level._id_8C30 == level._id_8BAF[0]["name"];
}

_id_4FF9( var_0 )
{
    var_1 = 0;

    if ( level._id_8C30 == var_0 )
        return 0;

    for ( var_2 = 0; var_2 < level._id_8BAF.size; var_2++ )
    {
        if ( level._id_8BAF[var_2]["name"] == var_0 )
        {
            var_1 = 1;
            continue;
        }

        if ( level._id_8BAF[var_2]["name"] == level._id_8C30 )
            return var_1;
    }
}

_id_058E( var_0, var_1, var_2, var_3 )
{
    earthquake( var_0, var_1, var_2, var_3 );
}

_id_A290( var_0, var_1 )
{
    self endon( "death" );
    var_2 = 0;

    if ( isdefined( var_1 ) )
        var_2 = 1;

    if ( isdefined( var_0 ) )
    {
        common_scripts\utility::flag_assert( var_0 );
        level endon( var_0 );
    }

    for (;;)
    {
        wait(randomfloatrange( 0.15, 0.3 ));
        var_3 = self.origin + ( 0.0, 0.0, 150.0 );
        var_4 = self.origin - ( 0.0, 0.0, 150.0 );
        var_5 = bullettrace( var_3, var_4, 0, undefined );

        if ( !issubstr( var_5["surfacetype"], "water" ) )
            continue;

        var_6 = "water_movement";

        if ( isplayer( self ) )
        {
            if ( distance( self getvelocity(), ( 0.0, 0.0, 0.0 ) ) < 5 )
                var_6 = "water_stop";
        }
        else if ( isdefined( level._effect["water_" + self._id_0007._id_5F58] ) )
            var_6 = "water_" + self._id_0007._id_5F58;

        var_7 = common_scripts\utility::getfx( var_6 );
        var_3 = var_5["position"];
        var_8 = ( 0, self.angles[1], 0 );
        var_9 = anglestoforward( var_8 );
        var_10 = anglestoup( var_8 );
        playfx( var_7, var_3, var_10, var_9 );

        if ( var_6 != "water_stop" && var_2 )
            thread common_scripts\utility::play_sound_in_space( var_1, var_3 );
    }
}

_id_6D57( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        common_scripts\utility::flag_assert( var_0 );
        level endon( var_0 );
    }

    for (;;)
    {
        wait(randomfloatrange( 0.25, 0.5 ));
        var_1 = self.origin + ( 0.0, 0.0, 0.0 );
        var_2 = self.origin - ( 0.0, 0.0, 5.0 );
        var_3 = bullettrace( var_1, var_2, 0, undefined );
        var_4 = anglestoforward( self.angles );
        var_5 = distance( self getvelocity(), ( 0.0, 0.0, 0.0 ) );

        if ( isdefined( self.vehicle ) )
            continue;

        if ( var_3["surfacetype"] != "snow" )
            continue;

        if ( var_5 <= 10 )
            continue;

        var_6 = "snow_movement";

        if ( distance( self getvelocity(), ( 0.0, 0.0, 0.0 ) ) <= 154 )
            playfx( common_scripts\utility::getfx( "footstep_snow_small" ), var_3["position"], var_3["normal"], var_4 );

        if ( distance( self getvelocity(), ( 0.0, 0.0, 0.0 ) ) > 154 )
            playfx( common_scripts\utility::getfx( "footstep_snow" ), var_3["position"], var_3["normal"], var_4 );
    }
}

_id_5CE9( var_0 )
{
    var_1 = 60;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        self _meth_803B( var_0, var_0 + "_off", ( var_1 - var_2 ) / var_1 );
        wait 0.05;
    }
}

_id_5CE7( var_0 )
{
    var_1 = 60;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        self _meth_803B( var_0, var_0 + "_off", var_2 / var_1 );
        wait 0.05;
    }
}

_id_596F( var_0, var_1 )
{
    var_0 endon( "death" );
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = ( 0.0, 0.0, 0.0 );

    for (;;)
    {
        self.origin = var_0.origin + var_1;
        self.angles = var_0.angles;
        wait 0.05;
    }
}

_id_60D3()
{
    _id_A59B::_id_5CD4();
    _id_A526::_id_05FF();
}

_id_590C( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    var_5[var_5.size] = var_0;

    if ( isdefined( var_1 ) )
        var_5[var_5.size] = var_1;

    if ( isdefined( var_2 ) )
        var_5[var_5.size] = var_2;

    if ( isdefined( var_3 ) )
        var_5[var_5.size] = var_3;

    if ( isdefined( var_4 ) )
        var_5[var_5.size] = var_4;

    return var_5;
}

_id_35FF()
{
    level._id_3618 = 1;
}

_id_6159()
{
    level._id_3618 = 0;
}

_id_4086()
{
    var_0 = self getweaponslistall();
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_0[var_2];
        var_1[var_3] = self getweaponammoclip( var_3 );
    }

    var_4 = 0;

    if ( isdefined( var_1["claymore"] ) && var_1["claymore"] > 0 )
        var_4 = var_1["claymore"];

    return var_4;
}

_id_0694( var_0 )
{
    wait(var_0);
}

_id_0696( var_0, var_1 )
{
    self waittillmatch( var_0, var_1 );
}

_id_063E( var_0, var_1 )
{
    _func_0D3( var_0, var_1 );
}

_id_5699( var_0, var_1, var_2 )
{
    var_3 = getdvarfloat( var_0 );
    level notify( var_0 + "_lerp_savedDvar" );
    level endon( var_0 + "_lerp_savedDvar" );
    var_4 = var_1 - var_3;
    var_5 = 0.05;
    var_6 = int( var_2 / var_5 );

    for ( var_7 = var_4 / var_6; var_6; var_6-- )
    {
        var_3 += var_7;
        _func_0D3( var_0, var_3 );
        wait(var_5);
    }

    _func_0D3( var_0, var_1 );
}

_id_569A( var_0, var_1, var_2, var_3 )
{
    if ( is_gen4() )
        _id_5699( var_0, var_2, var_3 );
    else
        _id_5699( var_0, var_1, var_3 );
}

_id_41DA( var_0 )
{
    if ( _id_5014() )
        return;

    foreach ( var_2 in level.players )
        var_2 _meth_80F9( var_0 );

    _func_2A3( "achievements_completed", var_0, 1 );
}

_id_6B2A( var_0 )
{
    if ( _id_5014() )
        return;

    self _meth_80F9( var_0 );
}

_id_076A( var_0 )
{
    var_1 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_1 setcontents( 0 );
    var_1 setmodel( "weapon_javelin_obj" );
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    _id_07BE( ::_id_2827 );

    if ( isdefined( var_0 ) )
    {
        common_scripts\utility::flag_assert( var_0 );
        _id_07BE( common_scripts\utility::flag_wait, var_0 );
    }

    _id_2BDC();
    var_1 delete();
}

_id_073B( var_0 )
{
    var_1 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_1 setcontents( 0 );
    var_1 setmodel( "weapon_c4_obj" );
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    _id_07BE( ::_id_2827 );

    if ( isdefined( var_0 ) )
    {
        common_scripts\utility::flag_assert( var_0 );
        _id_07BE( common_scripts\utility::flag_wait, var_0 );
    }

    _id_2BDC();
    var_1 delete();
}

_id_2827()
{
    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        wait 0.05;
    }
}

_id_8642()
{

}

_id_8638()
{

}

_id_8640( var_0 )
{
    level._id_8631._id_8A50 = var_0;
}

_id_863F( var_0 )
{
    level._id_8631._id_8A4D = var_0;
}

_id_863D( var_0 )
{
    level._id_8631._id_56A6 = var_0;
}

_id_863E( var_0 )
{
    level._id_8631._id_56A7 = var_0;
}

_id_863A()
{
    if ( isdefined( level._id_610B ) && level._id_610B )
        return;

    setslowmotion( level._id_8631._id_8A4D, level._id_8631._id_8A50, level._id_8631._id_56A6 );
}

_id_863B()
{
    if ( isdefined( level._id_610B ) && level._id_610B )
        return;

    setslowmotion( level._id_8631._id_8A50, level._id_8631._id_8A4D, level._id_8631._id_56A7 );
}

_id_075A( var_0, var_1, var_2, var_3 )
{
    level.earthquake[var_0]["magnitude"] = var_1;
    level.earthquake[var_0]["duration"] = var_2;
    level.earthquake[var_0]["radius"] = var_3;
}

_id_0CC3()
{
    return getdvar( "arcademode" ) == "1";
}

_id_0CC5()
{
    if ( !isdefined( level._id_0CC4 ) )
        return;

    level notify( "arcadeMode_remove_timer" );
    level._id_0CC6 = gettime();
    level._id_0CC4 destroy();
    level._id_0CC4 = undefined;
}

_id_6005( var_0, var_1, var_2 )
{
    level._id_055B._id_5558 = var_0;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    _func_074( 0 );
    _func_073( var_0, 0, 1.0, 1, var_2 );
}

_id_5FFB( var_0, var_1, var_2, var_3, var_4 )
{
    thread _id_A59B::_id_5FFC( var_0, var_1, var_2, var_3, var_4 );
}

_id_5FFE( var_0, var_1, var_2, var_3, var_4 )
{
    thread _id_A59B::_id_5FFC( var_0, var_1, var_2, var_3, var_4, 1 );
}

_id_6000( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_1 ) && var_1 > 0 )
    {
        thread _id_A59B::_id_6001( var_0, var_1, var_2, var_3 );
        return;
    }

    _id_6002();
    _id_6005( var_0, var_2, var_3 );
}

_id_5FF9( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( isdefined( level._id_055B._id_5558 ) )
        _func_074( var_1, level._id_055B._id_5558, var_3 );
    else
        iprintln( "^3WARNING!  script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything" );

    level._id_055B._id_5558 = var_0;
    _func_073( var_0, var_1, var_2, 0, var_3 );
    level endon( "stop_music" );
    wait(var_1);
    level notify( "done_crossfading" );
}

_id_6002( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 <= 0 )
        _func_074();
    else
        _func_074( var_0 );

    level notify( "stop_music" );
}

_id_6B6C()
{
    var_0 = getentarray( "grenade", "classname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = var_0[var_1];

        if ( var_2.model == "weapon_claymore" )
            continue;

        for ( var_3 = 0; var_3 < level.players.size; var_3++ )
        {
            var_4 = level.players[var_3];

            if ( distancesquared( var_2.origin, var_4.origin ) < 75625 )
                return 1;
        }
    }

    return 0;
}

_id_6AC8()
{
    return getdvarint( "player_died_recently", "0" ) > 0;
}

_id_09E3( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !var_2 istouching( var_0 ) )
            return 0;
    }

    return 1;
}

_id_0C95( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_2 istouching( var_0 ) )
            return 1;
    }

    return 0;
}

_id_3F56()
{
    if ( level._id_3BFC < 1 )
        return "easy";

    if ( level._id_3BFC < 2 )
        return "medium";

    if ( level._id_3BFC < 3 )
        return "hard";

    return "fu";
}

_id_3F0C()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;

    foreach ( var_4 in level.players )
    {
        var_0 += var_4.origin[0];
        var_1 += var_4.origin[1];
        var_2 += var_4.origin[2];
    }

    var_0 /= level.players.size;
    var_1 /= level.players.size;
    var_2 /= level.players.size;
    return ( var_0, var_1, var_2 );
}

_id_3CCF( var_0 )
{
    var_1 = ( 0.0, 0.0, 0.0 );

    foreach ( var_3 in var_0 )
        var_1 += var_3.origin;

    return var_1 * 1.0 / var_0.size;
}

_id_3C8A()
{
    self._id_257D = [];
    self endon( "entitydeleted" );
    self endon( "stop_generic_damage_think" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6 );

        foreach ( var_8 in self._id_257D )
            thread [[ var_8 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
    }
}

_id_0749( var_0 )
{
    self._id_257D[self._id_257D.size] = var_0;
}

_id_7339( var_0 )
{
    var_1 = [];

    foreach ( var_3 in self._id_257D )
    {
        if ( var_3 == var_0 )
            continue;

        var_1[var_1.size] = var_3;
    }

    self._id_257D = var_1;
}

_id_420D( var_0, var_1 )
{
    if ( isdefined( level._id_A398 ) && level._id_A398 && isdefined( level._id_A399 ) )
        self [[ level._id_A399 ]]( var_0, var_1 );
}

_id_6DBD( var_0 )
{
    self playlocalsound( var_0 );
}

_id_3115( var_0 )
{
    if ( level.players.size < 1 )
        return;

    foreach ( var_2 in level.players )
    {
        if ( var_0 == 1 )
        {
            var_2 enableweapons();
            continue;
        }

        var_2 disableweapons();
    }
}

_id_9238( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;

    foreach ( var_5 in var_0 )
    {
        if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "player1" )
        {
            var_1 = var_5;
            continue;
        }

        if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "player2" )
        {
            var_2 = var_5;
            continue;
        }

        if ( !isdefined( var_1 ) )
            var_1 = var_5;

        if ( !isdefined( var_2 ) )
            var_2 = var_5;
    }

    foreach ( var_8 in level.players )
    {
        if ( var_8 == level.player )
            var_3 = var_1;
        else if ( var_8 == level._id_6C58 )
            var_3 = var_2;

        var_8 setorigin( var_3.origin );
        var_8 setangles( var_3.angles );
    }
}

_id_9237( var_0 )
{
    level.player setorigin( var_0.origin );

    if ( isdefined( var_0.angles ) )
        level.player setangles( var_0.angles );
}

_id_971C()
{
    var_0 = [];

    if ( isdefined( self._id_330C ) )
        var_0 = self._id_330C;

    if ( isdefined( self.entity ) )
        var_0[var_0.size] = self.entity;

    common_scripts\utility::array_levelthread( var_0, _id_A59B::_id_971D );
}

_id_651A( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    level.player endon( "stop_opening_fov" );
    wait(var_0);
    level.player _meth_807D( var_1, var_2, 1, var_3, var_4, var_5, var_6, 1 );
}

_id_3CB6( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "all";

    if ( !isdefined( var_1 ) )
        var_1 = "all";

    var_3 = _func_0D7( var_0, var_1 );
    var_4 = [];

    foreach ( var_6 in var_3 )
    {
        if ( var_6 istouching( self ) )
            var_4[var_4.size] = var_6;
    }

    return var_4;
}

_id_3D47( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "all";

    var_1 = [];

    if ( var_0 == "all" )
    {
        var_1 = _id_0CF2( level._id_2F19["allies"]._id_0CD8, level._id_2F19["axis"]._id_0CD8 );
        var_1 = _id_0CF2( var_1, level._id_2F19["neutral"]._id_0CD8 );
    }
    else
        var_1 = level._id_2F19[var_0]._id_0CD8;

    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( !isdefined( var_4 ) )
            continue;

        if ( var_4 istouching( self ) )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

_id_3D48( var_0 )
{
    var_1 = _id_0CF2( level._id_2F19["allies"]._id_0CD8, level._id_2F19["axis"]._id_0CD8 );
    var_1 = _id_0CF2( var_1, level._id_2F19["neutral"]._id_0CD8 );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( !isdefined( var_4 ) )
            continue;

        if ( isdefined( var_4.targetname ) && var_4.targetname == var_0 )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

_id_3E05( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_0 == var_2 )
            continue;

        return var_2;
    }
}

_id_7DF2( var_0 )
{
    self.count = var_0;
}

_id_3968( var_0, var_1, var_2, var_3 )
{
    self notify( "_utility::follow_path" );
    self endon( "_utility::follow_path" );
    self endon( "death" );
    var_4 = undefined;

    if ( !isdefined( var_0.classname ) )
    {
        if ( !isdefined( var_0.type ) )
            var_4 = "struct";
        else
            var_4 = "node";
    }
    else
        var_4 = "entity";

    if ( !isdefined( var_1 ) )
        var_1 = 300;

    var_5 = self._id_79E4;
    self._id_79E4 = 1;
    _id_A577::_id_423E( var_0, var_4, var_2, var_1, var_3 );
    self._id_79E4 = var_5;
}

_id_30BB( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 250;

    if ( !isdefined( var_1 ) )
        var_1 = 100;

    if ( !isdefined( var_2 ) )
        var_2 = var_0 * 2;

    if ( !isdefined( var_3 ) )
        var_3 = var_0 * 1.25;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    self._id_2D2B = var_5;
    thread _id_A59B::_id_2FE3( var_0, var_1, var_2, var_3, var_4 );
}

_id_2A9A()
{
    self notify( "stop_dynamic_run_speed" );
}

_id_6BFB()
{
    self endon( "death" );
    self endon( "stop_player_seek" );
    var_0 = 1200;

    if ( _id_46FB() )
        var_0 = 250;

    var_1 = distance( self.origin, level.player.origin );

    for (;;)
    {
        wait 2;
        self._id_01C7 = var_1;
        var_2 = _id_3CFC( self.origin );
        self _meth_81A7( var_2 );
        var_1 -= 175;

        if ( var_1 < var_0 )
        {
            var_1 = var_0;
            return;
        }
    }
}

_id_6BFA()
{
    self notify( "stop_player_seek" );
}

_id_A085( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 5;

    var_3 = gettime() + var_2 * 1000;

    while ( isdefined( var_0 ) )
    {
        if ( distance( var_0.origin, self.origin ) <= var_1 )
            break;

        if ( gettime() > var_3 )
            break;

        wait 0.1;
    }
}

_id_A084( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "death" );

    while ( isdefined( var_0 ) )
    {
        if ( distance( var_0.origin, self.origin ) <= var_1 )
            break;

        wait 0.1;
    }
}

_id_A086( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "death" );

    while ( isdefined( var_0 ) )
    {
        if ( distance( var_0.origin, self.origin ) > var_1 )
            break;

        wait 0.1;
    }
}

_id_46FB()
{
    self endon( "death" );

    if ( !isdefined( self.weapon ) )
        return 0;

    if ( weaponclass( self.weapon ) == "spread" )
        return 1;

    return 0;
}

isprimaryweapon( var_0 )
{
    if ( var_0 == "none" )
        return 0;

    if ( objective_current( var_0 ) != "primary" )
        return 0;

    switch ( weaponclass( var_0 ) )
    {
        case "sniper":
        case "rifle":
        case "pistol":
        case "mg":
        case "smg":
        case "spread":
        case "rocketlauncher":
            return 1;
        default:
            return 0;
    }
}

_id_6B47()
{
    var_0 = self getweaponslistall();

    if ( !isdefined( var_0 ) )
        return 0;

    foreach ( var_2 in var_0 )
    {
        if ( issubstr( var_2, "thermal" ) )
            return 1;
    }

    return 0;
}

_id_A0BB( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = self._id_01C7;

    for (;;)
    {
        self waittill( "goal" );

        if ( distance( self.origin, var_0 ) < var_1 + 10 )
            break;
    }
}

_id_6C1D( var_0, var_1 )
{
    var_2 = int( getdvar( "g_speed" ) );

    if ( !isdefined( level.player._id_3BC2 ) )
        level.player._id_3BC2 = var_2;

    var_3 = int( level.player._id_3BC2 * var_0 * 0.01 );
    level.player _id_6C1F( var_3, var_1 );
}

_id_149D( var_0, var_1 )
{
    var_2 = self;

    if ( !isplayer( var_2 ) )
        var_2 = level.player;

    if ( !isdefined( var_2._id_5F77 ) )
        var_2._id_5F77 = 1.0;

    var_3 = var_0 * 0.01;
    var_2 _id_149B( var_3, var_1 );
}

_id_6C1F( var_0, var_1 )
{
    var_2 = int( getdvar( "g_speed" ) );

    if ( !isdefined( level.player._id_3BC2 ) )
        level.player._id_3BC2 = var_2;

    var_3 = _id_A59B::_id_3BC3;
    var_4 = _id_A59B::_id_3BC4;
    level.player thread _id_6C1E( var_0, var_1, var_3, var_4, "player_speed_set" );
}

_id_6A77( var_0, var_1 )
{
    var_2 = _id_A59B::_id_3BBF;
    var_3 = _id_A59B::_id_3BC0;
    level.player thread _id_6C1E( var_0, var_1, var_2, var_3, "player_bob_scale_set" );
}

_id_149B( var_0, var_1 )
{
    var_2 = self;

    if ( !isplayer( var_2 ) )
        var_2 = level.player;

    if ( !isdefined( var_2._id_5F77 ) )
        var_2._id_5F77 = 1.0;

    var_3 = _id_A59B::_id_5F72;
    var_4 = _id_A59B::_id_5F76;
    var_2 thread _id_6C1E( var_0, var_1, var_3, var_4, "blend_movespeedscale" );
}

_id_6C1E( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( var_4 );
    self endon( var_4 );
    var_5 = [[ var_2 ]]();
    var_6 = var_0;

    if ( isdefined( var_1 ) )
    {
        var_7 = var_6 - var_5;
        var_8 = 0.05;
        var_9 = var_1 / var_8;
        var_10 = var_7 / var_9;

        while ( abs( var_6 - var_5 ) > abs( var_10 * 1.1 ) )
        {
            var_5 += var_10;
            [[ var_3 ]]( var_5 );
            wait(var_8);
        }
    }

    [[ var_3 ]]( var_6 );
}

_id_6C1A( var_0 )
{
    if ( !isdefined( level.player._id_3BC2 ) )
        return;

    level.player _id_6C1F( level.player._id_3BC2, var_0 );
    waittillframeend;
    level.player._id_3BC2 = undefined;
}

_id_149C( var_0 )
{
    var_1 = self;

    if ( !isplayer( var_1 ) )
        var_1 = level.player;

    if ( !isdefined( var_1._id_5F77 ) )
        return;

    var_1 _id_149B( 1.0, var_0 );
    waittillframeend;
    var_1._id_5F77 = undefined;
}

_id_9212( var_0 )
{
    if ( isplayer( self ) )
    {
        self setorigin( var_0.origin );
        self setangles( var_0.angles );
    }
    else
        self _meth_81C6( var_0.origin, var_0.angles );
}

_id_9246( var_0, var_1 )
{
    var_2 = var_0 gettagorigin( var_1 );
    var_3 = var_0 gettagangles( var_1 );
    self dontinterpolate();

    if ( isplayer( self ) )
    {
        self setorigin( var_2 );
        self setangles( var_3 );
    }
    else if ( isai( self ) )
        self _meth_81C6( var_2, var_3 );
    else
    {
        self.origin = var_2;
        self.angles = var_3;
    }
}

_id_9207( var_0 )
{
    self _meth_81C6( var_0.origin, var_0.angles );
    self _meth_81A6( self.origin );
    self _meth_81A5( var_0 );
}

_id_5EFD( var_0 )
{
    foreach ( var_2 in level._id_2417 )
        var_2.v["origin"] += var_0;
}

_id_51A7()
{
    return isdefined( self._id_8620 );
}

_id_139F( var_0, var_1, var_2 )
{
    var_3 = self;
    var_3 thread _id_69C1( "foot_slide_plr_start" );

    if ( soundexists( "foot_slide_plr_loop" ) )
        var_3 thread _id_6973( "foot_slide_plr_loop" );

    var_4 = isdefined( level._id_254B );

    if ( !isdefined( var_0 ) )
        var_0 = var_3 getvelocity() + ( 0.0, 0.0, -10.0 );

    if ( !isdefined( var_1 ) )
        var_1 = 10;

    if ( !isdefined( var_2 ) )
    {
        if ( isdefined( level._id_861B ) )
            var_2 = level._id_861B;
        else
            var_2 = 0.035;
    }

    var_5 = spawn( "script_origin", var_3.origin );
    var_5.angles = var_3.angles;
    var_3._id_8620 = var_5;
    var_5 _meth_82B3( ( 0.0, 0.0, 15.0 ), 15, var_0 );

    if ( var_4 )
        var_3 _meth_8080( var_5, undefined, 1 );
    else
        var_3 playerlinkto( var_5 );

    var_3 disableweapons();
    var_3 _meth_811A( 0 );
    var_3 _meth_8119( 1 );
    var_3 _meth_8118( 0 );
    var_3 thread _id_A59B::_id_2D7A( var_5, var_1, var_2 );
}

_id_31C6()
{
    var_0 = self;
    var_0 notify( "stop soundfoot_slide_plr_loop" );
    var_0 thread _id_69C1( "foot_slide_plr_end" );
    var_0 unlink();
    var_0 _meth_82F1( var_0._id_8620._id_03CC );
    var_0._id_8620 delete();
    var_0 enableweapons();
    var_0 _meth_811A( 1 );
    var_0 _meth_8119( 1 );
    var_0 _meth_8118( 1 );
    var_0 notify( "stop_sliding" );
}

_id_896F()
{
    return _id_A59E::_id_9D39( self );
}

_id_3F87( var_0 )
{
    var_1 = _id_A594::_id_3DC8();
    var_2 = [];

    foreach ( var_6, var_4 in var_1 )
    {
        if ( !issubstr( var_6, "flag" ) )
            continue;

        var_5 = getentarray( var_6, "classname" );
        var_2 = common_scripts\utility::array_combine( var_2, var_5 );
    }

    var_7 = _id_A594::_id_3DC9();

    foreach ( var_9, var_4 in var_7 )
    {
        if ( !issubstr( var_9, "flag" ) )
            continue;

        var_5 = getentarray( var_9, "targetname" );
        var_2 = common_scripts\utility::array_combine( var_2, var_5 );
    }

    var_10 = undefined;

    foreach ( var_12 in var_2 )
    {
        if ( var_12._id_79CE == var_0 )
            return var_12;
    }
}

_id_3F82( var_0 )
{
    var_1 = _id_A594::_id_3DC8();
    var_2 = [];

    foreach ( var_6, var_4 in var_1 )
    {
        if ( !issubstr( var_6, "flag" ) )
            continue;

        var_5 = getentarray( var_6, "classname" );
        var_2 = common_scripts\utility::array_combine( var_2, var_5 );
    }

    var_7 = _id_A594::_id_3DC9();

    foreach ( var_9, var_4 in var_7 )
    {
        if ( !issubstr( var_9, "flag" ) )
            continue;

        var_5 = getentarray( var_9, "targetname" );
        var_2 = common_scripts\utility::array_combine( var_2, var_5 );
    }

    var_10 = [];

    foreach ( var_12 in var_2 )
    {
        if ( var_12._id_79CE == var_0 )
            var_10[var_10.size] = var_12;
    }

    return var_10;
}

_id_7F09( var_0, var_1 )
{
    return ( var_0[0], var_0[1], var_1 );
}

_id_07C2( var_0, var_1 )
{
    return ( var_0[0], var_0[1], var_0[2] + var_1 );
}

_id_7F08( var_0, var_1 )
{
    return ( var_0[0], var_1, var_0[2] );
}

_id_7F07( var_0, var_1 )
{
    return ( var_1, var_0[1], var_0[2] );
}

_id_6C4B()
{
    var_0 = self getcurrentweapon();

    if ( !isdefined( var_0 ) )
        return 0;

    if ( issubstr( tolower( var_0 ), "rpg" ) )
        return 1;

    if ( issubstr( tolower( var_0 ), "stinger" ) )
        return 1;

    if ( issubstr( tolower( var_0 ), "at4" ) )
        return 1;

    if ( issubstr( tolower( var_0 ), "javelin" ) )
        return 1;

    return 0;
}

_id_2CE6()
{
    return isdefined( self._id_0007._id_2CE6 );
}

_id_3E56( var_0, var_1 )
{
    if ( _id_5009() )
    {

    }

    var_2 = _id_3E23();

    if ( !isdefined( var_0 ) )
        var_0 = "steady_rumble";

    var_3 = spawn( "script_origin", var_2 geteye() );

    if ( !isdefined( var_1 ) || !_func_2BA( var_1 ) )
        var_3._id_4E9B = 1;
    else
        var_3._id_4E9B = var_1;

    var_3 thread _id_A59B::_id_9AD0( var_2, var_0 );
    return var_3;
}

_id_7EA4( var_0 )
{
    self._id_4E9B = var_0;
}

_id_768C( var_0 )
{
    thread _id_768D( 1, var_0 );
}

_id_768B( var_0 )
{
    thread _id_768D( 0, var_0 );
}

_id_768D( var_0, var_1 )
{
    self notify( "new_ramp" );
    self endon( "new_ramp" );
    self endon( "death" );
    var_2 = var_1 * 20;
    var_3 = var_0 - self._id_4E9B;
    var_4 = var_3 / var_2;

    for ( var_5 = 0; var_5 < var_2; var_5++ )
    {
        self._id_4E9B += var_4;
        wait 0.05;
    }

    self._id_4E9B = var_0;
}

_id_3E23()
{
    if ( isdefined( self ) )
    {
        if ( !_id_5038( level.players, self ) )
            return level.player;
        else
            return self;
    }
    else
        return level.player;
}

_id_3E24()
{
    return int( self _meth_820D( "gameskill" ) );
}

_id_4233( var_0 )
{
    if ( isdefined( self._id_614A ) )
        return;

    self._id_614A = self.model;

    if ( !isdefined( var_0 ) )
        var_0 = self.model + "_obj";

    self setmodel( var_0 );
}

_id_8EE6( var_0 )
{
    if ( !isdefined( self._id_614A ) )
        return;

    self setmodel( self._id_614A );
    self._id_614A = undefined;
}

_id_0CE6( var_0, var_1, var_2 )
{
    var_3 = [];
    var_1 = var_2 - var_1;

    foreach ( var_5 in var_0 )
    {
        var_3[var_3.size] = var_5;

        if ( var_3.size == var_2 )
        {
            var_3 = common_scripts\utility::array_randomize( var_3 );

            for ( var_6 = var_1; var_6 < var_3.size; var_6++ )
                var_3[var_6] delete();

            var_3 = [];
        }
    }

    var_8 = [];

    foreach ( var_5 in var_0 )
    {
        if ( !isdefined( var_5 ) )
            continue;

        var_8[var_8.size] = var_5;
    }

    return var_8;
}

_id_A08C( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0.5;

    self endon( "death" );

    while ( isdefined( self ) )
    {
        if ( distance( var_0, self.origin ) <= var_1 )
            break;

        wait(var_2);
    }
}

_id_07B3( var_0 )
{
    var_1 = spawnstruct();
    var_1 thread _id_A59B::_id_07B4( var_0 );
    return var_1;
}

_id_9492( var_0, var_1, var_2 )
{
    var_3 = self gettagorigin( var_1 );
    var_4 = self gettagangles( var_1 );
    _id_9491( var_0, var_3, var_4, var_2 );
}

_id_9491( var_0, var_1, var_2, var_3 )
{
    var_4 = anglestoforward( var_2 );
    var_5 = bullettrace( var_1, var_1 + var_4 * var_3, 0, undefined );

    if ( var_5["fraction"] >= 1 )
        return;

    var_6 = var_5["surfacetype"];

    if ( !isdefined( level._id_948A[var_0][var_6] ) )
        var_6 = "default";

    var_7 = level._id_948A[var_0][var_6];

    if ( isdefined( var_7["fx"] ) )
        playfx( var_7["fx"], var_5["position"], var_5["normal"] );

    if ( isdefined( var_7["fx_array"] ) )
    {
        foreach ( var_9 in var_7["fx_array"] )
            playfx( var_9, var_5["position"], var_5["normal"] );
    }

    if ( isdefined( var_7["sound"] ) )
        level thread common_scripts\utility::play_sound_in_space( var_7["sound"], var_5["position"] );

    if ( isdefined( var_7["rumble"] ) )
    {
        var_11 = _id_3E23();
        var_11 playrumbleonentity( var_7["rumble"] );
    }
}

_id_2AD9()
{
    self._id_02B1 = 0;
}

_id_30F6()
{
    self._id_02B1 = squared( 512 );
}

_id_30C8( var_0 )
{
    self._id_4792 = 1;
    self._id_6106 = 1;
    self._id_04E7 = 1;

    if ( !isdefined( var_0 ) || !var_0 )
    {
        self._id_2D3A = 1;
        self._id_0274 = 64;
        self._id_02FC = 2048;
        _id_2AD9();
    }

    self._id_8A2F = animscripts\animset::_id_4794;
    self._id_2562["run"] = animscripts\utility::_id_5861( "heat_run" );
}

_id_2AAA()
{
    self._id_4792 = undefined;
    self._id_6106 = undefined;
    self._id_2D3A = undefined;
    self._id_04E7 = 0;
    self._id_0274 = 512;
    self._id_8A2F = undefined;
    self._id_2562 = undefined;
}

_id_4150()
{
    return vehicle_getarray();
}

_id_48AD( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = 0.5;
    level endon( "clearing_hints" );

    if ( isdefined( level._id_4900 ) )
        level._id_4900 _id_A53C::destroyelem();

    level._id_4900 = _id_A53C::createfontstring( "default", 1.5 );
    level._id_4900 _id_A53C::setpoint( "MIDDLE", undefined, 0, 30 + var_2 );
    level._id_4900.color = ( 1.0, 1.0, 1.0 );
    level._id_4900 settext( var_0 );
    level._id_4900.alpha = 0;
    level._id_4900 fadeovertime( 0.5 );
    level._id_4900.alpha = 1;
    wait 0.5;
    level._id_4900 endon( "death" );

    if ( isdefined( var_1 ) )
        wait(var_1);
    else
        return;

    level._id_4900 fadeovertime( var_3 );
    level._id_4900.alpha = 0;
    wait(var_3);
    level._id_4900 _id_A53C::destroyelem();
}

_id_48C8()
{
    var_0 = 1;

    if ( isdefined( level._id_4900 ) )
    {
        level notify( "clearing_hints" );
        level._id_4900 fadeovertime( var_0 );
        level._id_4900.alpha = 0;
        wait(var_0);
    }
}

_id_5303( var_0, var_1, var_2 )
{
    if ( !isdefined( level.flag[var_0] ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    foreach ( var_4 in level._id_265A[var_0] )
    {
        foreach ( var_6 in var_4 )
        {
            if ( isalive( var_6 ) )
            {
                var_6 thread _id_A59B::_id_5304( var_1, var_2 );
                continue;
            }

            var_6 delete();
        }
    }
}

_id_3E2C( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = "player_view_controller";

    if ( !isdefined( var_2 ) )
        var_2 = ( 0.0, 0.0, 0.0 );

    var_4 = var_0 gettagorigin( var_1 );
    var_5 = spawnturret( "misc_turret", var_4, var_3 );
    var_5.angles = var_0 gettagangles( var_1 );
    var_5 setmodel( "tag_turret" );
    var_5 linkto( var_0, var_1, var_2, ( 0.0, 0.0, 0.0 ) );
    var_5 makeunusable();
    var_5 hide();
    var_5 _meth_8065( "manual" );
    return var_5;
}

_id_239F( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4 childthread _id_A59B::_id_6FDC( var_0, self, var_1, var_2, var_3 );
    return var_4;
}

_id_7EE1( var_0, var_1 )
{
    if ( isdefined( self._id_9A8F ) )
        self._id_9A8F = [];

    if ( !isdefined( var_1 ) || var_1 )
        self._id_9A8F[var_0] = 1;
    else
        self._id_9A8F[var_0] = undefined;
}

_id_5093( var_0 )
{
    if ( !isdefined( self._id_9A8F ) )
        return 0;

    return isdefined( self._id_9A8F[var_0] );
}

_id_8F0A( var_0 )
{
    if ( !isdefined( self._id_8F13 ) )
        self._id_8F13 = [];

    if ( !isdefined( self._id_9A8F ) )
        self._id_9A8F = [];

    var_1 = [];
    var_2 = self getweaponslistall();
    var_3 = self getcurrentweapon();

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( self._id_9A8F[var_5] ) )
            continue;

        var_1[var_5] = [];
        var_1[var_5]["clip_left"] = self getweaponammoclip( var_5, "left" );
        var_1[var_5]["clip_right"] = self getweaponammoclip( var_5, "right" );
        var_1[var_5]["stock"] = self getweaponammostock( var_5 );
    }

    if ( !isdefined( var_0 ) )
        var_0 = "default";

    self._id_8F13[var_0] = [];

    if ( isdefined( self._id_9A8F[var_3] ) )
    {
        var_7 = self getweaponslistprimaries();

        foreach ( var_5 in var_7 )
        {
            if ( !isdefined( self._id_9A8F[var_5] ) )
            {
                var_3 = var_5;
                break;
            }
        }
    }

    self._id_8F13[var_0]["current_weapon"] = var_3;
    self._id_8F13[var_0]["inventory"] = var_1;
}

_id_749D( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "default";

    if ( !isdefined( self._id_8F13 ) || !isdefined( self._id_8F13[var_0] ) )
        return;

    self takeallweapons();

    foreach ( var_3, var_2 in self._id_8F13[var_0]["inventory"] )
    {
        if ( objective_current( var_3 ) != "altmode" )
            self giveweapon( var_3 );

        self setweaponammoclip( var_3, var_2["clip_left"], "left" );
        self setweaponammoclip( var_3, var_2["clip_right"], "right" );
        self setweaponammostock( var_3, var_2["stock"] );
    }

    var_4 = self._id_8F13[var_0]["current_weapon"];

    if ( var_4 != "none" )
        self switchtoweapon( var_4 );
}

_id_3E76()
{
    var_0 = self getweaponslistall();

    if ( isdefined( self._id_9A8F ) )
    {
        foreach ( var_2 in var_0 )
        {
            if ( isdefined( self._id_9A8F[var_2] ) )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );
        }
    }

    return var_0;
}

_id_3E77()
{
    var_0 = self getweaponslistprimaries();

    if ( isdefined( self._id_9A8F ) )
    {
        foreach ( var_2 in var_0 )
        {
            if ( isdefined( self._id_9A8F[var_2] ) )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );
        }
    }

    return var_0;
}

_id_3E75()
{
    var_0 = self getcurrentprimaryweapon();

    if ( isdefined( self._id_9A8F ) && isdefined( self._id_9A8F[var_0] ) )
        var_0 = _id_3D6A();

    return var_0;
}

_id_3E74()
{
    var_0 = self getcurrentweapon();

    if ( isdefined( self._id_9A8F ) && isdefined( self._id_9A8F[var_0] ) )
        var_0 = _id_3D6A();

    return var_0;
}

_id_3D6A()
{
    var_0 = _id_3E77();

    if ( var_0.size > 0 )
        var_1 = var_0[0];
    else
        var_1 = "none";

    return var_1;
}

_id_484A()
{
    switch ( self.code_classname )
    {
        case "script_model":
        case "script_vehicle":
        case "light_spot":
            self hide();
            break;
        case "script_brushmodel":
            self hide();
            self notsolid();

            if ( self._id_03DB & 1 )
                self connectpaths();

            break;
        case "trigger_radius":
        case "trigger_multiple":
        case "trigger_use":
        case "trigger_use_touch":
        case "trigger_multiple_flag_set":
        case "trigger_multiple_breachIcon":
        case "trigger_multiple_flag_lookat":
        case "trigger_multiple_flag_looking":
            common_scripts\utility::trigger_off();
            break;
        default:
    }
}

_id_84C4()
{
    switch ( self.code_classname )
    {
        case "script_model":
        case "script_vehicle":
        case "light_spot":
            self show();
            break;
        case "script_brushmodel":
            self show();
            self solid();

            if ( self._id_03DB & 1 )
                self disconnectpaths();

            break;
        case "trigger_radius":
        case "trigger_multiple":
        case "trigger_use":
        case "trigger_use_touch":
        case "trigger_multiple_flag_set":
        case "trigger_multiple_breachIcon":
        case "trigger_multiple_flag_lookat":
        case "trigger_multiple_flag_looking":
            common_scripts\utility::trigger_on();
            break;
        default:
    }
}

_id_062B( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
        self rotateyaw( var_0, var_1, var_2, var_3 );
    else if ( isdefined( var_2 ) )
        self rotateyaw( var_0, var_1, var_2 );
    else
        self rotateyaw( var_0, var_1 );
}

_id_7E7B( var_0, var_1, var_2 )
{
    self notify( "set_moveplaybackrate" );
    self endon( "set_moveplaybackrate" );

    if ( isdefined( var_2 ) && var_2 )
        thread _id_7E7C( var_0, var_1 );

    if ( !isdefined( self._id_5F63 ) )
        self._id_5F63 = self._id_5F62;

    if ( isdefined( var_1 ) )
    {
        var_3 = var_0 - self._id_5F62;
        var_4 = 0.05;
        var_5 = var_1 / var_4;
        var_6 = var_3 / var_5;

        while ( abs( var_0 - self._id_5F62 ) > abs( var_6 * 1.1 ) )
        {
            self._id_5F62 += var_6;
            wait(var_4);
        }
    }

    self._id_5F62 = var_0;
}

_id_749B( var_0, var_1 )
{
    self notify( "set_moveplaybackrate" );
    self endon( "set_moveplaybackrate" );

    if ( isdefined( var_1 ) && var_1 )
        thread _id_749C( var_0 );

    _id_7E7B( self._id_5F63, var_0, 0 );
    self._id_5F63 = undefined;
}

_id_7E7C( var_0, var_1 )
{
    self notify( "set_moveplaybackrate" );
    self endon( "set_moveplaybackrate" );

    if ( !isdefined( self._id_5F95 ) )
        self._id_5F95 = self._id_5F94;

    if ( isdefined( var_1 ) )
    {
        var_2 = var_0 - self._id_5F94;
        var_3 = 0.05;
        var_4 = var_1 / var_3;
        var_5 = var_2 / var_4;

        while ( abs( var_0 - self._id_5F94 ) > abs( var_5 * 1.1 ) )
        {
            self._id_5F94 += var_5;
            wait(var_3);
        }
    }

    self._id_5F94 = var_0;
}

_id_749C( var_0 )
{
    self notify( "set_moveplaybackrate" );
    self endon( "set_moveplaybackrate" );
    _id_7E7C( self._id_5F95, var_0 );
    self._id_5F95 = undefined;
}

_id_0D0B( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    foreach ( var_7 in var_0 )
        var_7 thread _id_0798( var_1, var_2, var_3, var_4, var_5 );
}

_id_0D0D( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getentarray( var_0, "targetname" );
    _id_0D0B( var_6, var_1, var_2, var_3, var_4, var_5 );
}

_id_0D0C( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getentarray( var_0, "script_noteworthy" );
    _id_0D0B( var_6, var_1, var_2, var_3, var_4, var_5 );
}

_id_30B9()
{
    self._id_2D33 = 1;
}

_id_2A99()
{
    self._id_2D33 = undefined;
}

_id_23DB( var_0 )
{
    if ( !isdefined( level._id_8FC8 ) )
        level._id_8FC8 = [];

    var_1 = spawnstruct();
    var_1.name = var_0;
    level._id_8FC8[var_0] = var_1;
    return var_1;
}

create_vision_set_fog( var_0 )
{
    if ( !isdefined( level.vision_set_fog ) )
        level.vision_set_fog = [];

    var_1 = spawnstruct();
    var_1.name = var_0;
    var_1.skyfogintensity = 0;
    var_1.skyfogminangle = 0;
    var_1.skyfogmaxangle = 0;
    var_1.heightfogenabled = 0;
    var_1.heightfogbaseheight = 0;
    var_1.heightfoghalfplanedistance = 1000;
    level.vision_set_fog[tolower( var_0 )] = var_1;
    return var_1;
}

_id_3EBD( var_0 )
{
    if ( !isdefined( level.vision_set_fog ) )
        level.vision_set_fog = [];

    var_1 = level.vision_set_fog[tolower( var_0 )];

    if ( _id_9C19() && isdefined( var_1 ) && isdefined( var_1._id_4772 ) )
        var_1 = level.vision_set_fog[tolower( var_1._id_4772 )];

    return var_1;
}

_id_23B6( var_0 )
{
    if ( !isdefined( level._id_395B ) )
        level._id_395B = [];

    var_1 = spawnstruct();
    var_1.name = var_0;
    level._id_395B[tolower( var_0 )] = var_1;
    return var_1;
}

get_fog( var_0 )
{
    if ( !isdefined( level._id_395B ) )
        level._id_395B = [];

    var_1 = level._id_395B[tolower( var_0 )];
    return var_1;
}

_id_4D53()
{
    if ( !isdefined( self.fog_transition_ent ) )
    {
        self.fog_transition_ent = spawnstruct();
        self.fog_transition_ent.fogset = "";
        self.fog_transition_ent.time = 0;
    }
}

_id_9C19()
{
    if ( !isdefined( level.console ) )
        set_console_status();

    return is_gen4();
}

_id_395C( var_0, var_1 )
{
    if ( !isplayer( self ) )
        _id_A509::init_fog_transition();
    else
        _id_4D53();

    if ( !isdefined( level._id_395B ) )
        level._id_395B = [];

    var_2 = level._id_395B[tolower( var_0 )];

    if ( !isdefined( var_2 ) )
        var_2 = level.vision_set_fog[tolower( var_0 )];

    if ( isdefined( var_2 ) && isdefined( var_2._id_4772 ) && _id_9C19() )
    {
        if ( isdefined( level._id_395B[tolower( var_2._id_4772 )] ) )
            var_2 = level._id_395B[tolower( var_2._id_4772 )];
        else if ( isdefined( level.vision_set_fog ) )
            var_2 = level.vision_set_fog[tolower( var_2._id_4772 )];
    }

    if ( !isdefined( var_1 ) )
        var_1 = var_2.transitiontime;

    if ( !isplayer( self ) )
    {
        common_scripts\utility::set_fog_to_ent_values( var_2, var_1 );
        level.fog_transition_ent.fogset = var_0;
        level.fog_transition_ent.time = var_1;
    }
    else
    {
        if ( var_0 != "" && self.fog_transition_ent.fogset == var_0 && self.fog_transition_ent.time == var_1 )
            return;

        common_scripts\utility::set_fog_to_ent_values( var_2, var_1 );
        self.fog_transition_ent.fogset = var_0;
        self.fog_transition_ent.time = var_1;
    }
}

_id_9E65( var_0, var_1 )
{
    var_2 = _id_9E63( var_0, var_1 );

    if ( var_2 )
    {
        if ( level.currentgen && isdefined( _id_3EBD( var_0 + "_cg" ) ) )
            _id_395C( var_0 + "_cg", var_1 );
        else if ( isdefined( _id_3EBD( var_0 ) ) )
            _id_395C( var_0, var_1 );
        else
            _func_232( var_1 );
    }
}

_id_4D54()
{
    if ( !isdefined( self.vision_set_transition_ent ) )
    {
        self.vision_set_transition_ent = spawnstruct();
        self.vision_set_transition_ent.vision_set = "";
        self.vision_set_transition_ent.time = 0;
    }
}

_id_9E63( var_0, var_1 )
{
    if ( !isplayer( self ) )
    {
        var_2 = 1;

        if ( !isdefined( level.vision_set_transition_ent ) )
        {
            level.vision_set_transition_ent = spawnstruct();
            level.vision_set_transition_ent.vision_set = "";
            level.vision_set_transition_ent.time = 0;
            var_2 = 0;
        }

        if ( var_0 != "" && level.vision_set_transition_ent.vision_set == var_0 && level.vision_set_transition_ent.time == var_1 )
            return 0;

        level.vision_set_transition_ent.vision_set = var_0;
        level.vision_set_transition_ent.time = var_1;

        if ( var_2 && getdvarint( "scr_art_tweak" ) != 0 )
        {

        }
        else
            visionsetnaked( var_0, var_1 );

        level._id_58B9 = var_0;
        setdvar( "vision_set_current", var_0 );
    }
    else
    {
        _id_4D54();

        if ( var_0 != "" && self.vision_set_transition_ent.vision_set == var_0 && self.vision_set_transition_ent.time == var_1 )
            return 0;

        self.vision_set_transition_ent.vision_set = var_0;
        self.vision_set_transition_ent.time = var_1;
        self visionsetnakedforplayer( var_0, var_1 );
    }

    return 1;
}

_id_30F9()
{
    thread _id_30FA();
}

_id_30FA()
{
    self endon( "death" );

    for (;;)
    {
        self._id_91EA = 1;
        wait 0.05;
    }
}

_id_2ADE()
{
    self._id_91EA = undefined;
}

_id_061D( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        radiusdamage( var_0, var_1, var_2, var_3 );
    else
        radiusdamage( var_0, var_1, var_2, var_3, var_4 );
}

_id_59D0( var_0 )
{
    var_1 = getentarray( "destructible_toy", "targetname" );
    var_2 = getentarray( "destructible_vehicle", "targetname" );
    var_3 = common_scripts\utility::array_combine( var_1, var_2 );

    foreach ( var_5 in var_0 )
        var_5.destructibles = [];

    foreach ( var_8 in var_3 )
    {
        foreach ( var_5 in var_0 )
        {
            if ( !var_5 istouching( var_8 ) )
                continue;

            var_5 _id_A59B::_id_7061( var_8 );
            break;
        }
    }
}

_id_4EA4()
{
    var_0 = [];
    var_0[0] = [ "interactive_birds", "targetname" ];
    var_0[1] = [ "interactive_vulture", "targetname" ];
    var_0[2] = [ "interactive_fish", "script_noteworthy" ];
    return var_0;
}

_id_59D2( var_0 )
{
    var_1 = _id_4EA4();
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        var_5 = getentarray( var_4[0], var_4[1] );
        var_2 = common_scripts\utility::array_combine( var_2, var_5 );
    }

    foreach ( var_8 in var_2 )
    {
        if ( !isdefined( level._id_05D3[var_8._id_4EA2]._id_781C ) )
            continue;

        foreach ( var_11 in var_0 )
        {
            if ( !var_11 istouching( var_8 ) )
                continue;

            if ( !isdefined( var_11._id_4EA5 ) )
                var_11._id_4EA5 = [];

            var_11._id_4EA5[var_11._id_4EA5.size] = var_8 [[ level._id_05D3[var_8._id_4EA2]._id_781C ]]();
        }
    }
}

_id_06FF()
{
    if ( !isdefined( self._id_4EA5 ) )
        return;

    foreach ( var_1 in self._id_4EA5 )
        var_1 [[ level._id_05D3[var_1._id_4EA2]._id_57D2 ]]();

    self._id_4EA5 = undefined;
}

_id_2814( var_0 )
{
    _id_59D2( var_0 );

    foreach ( var_2 in var_0 )
        var_2._id_4EA5 = undefined;
}

_id_59D1( var_0 )
{
    if ( getdvar( "createfx" ) != "" )
        return;

    var_1 = getentarray( "script_brushmodel", "classname" );
    var_2 = getentarray( "script_model", "classname" );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
        var_1[var_1.size] = var_2[var_3];

    foreach ( var_5 in var_0 )
    {
        foreach ( var_7 in var_1 )
        {
            if ( isdefined( var_7._id_7AA0 ) )
                var_7.script_exploder = var_7._id_7AA0;

            if ( !isdefined( var_7.script_exploder ) )
                continue;

            if ( !isdefined( var_7.model ) )
                continue;

            if ( var_7.code_classname != "script_model" )
                continue;

            if ( !var_7 istouching( var_5 ) )
                continue;

            var_7._id_59D3 = 1;
        }
    }
}

_id_06FA()
{
    var_0 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );

    foreach ( var_2 in level._id_2417 )
    {
        if ( !isdefined( var_2.v["masked_exploder"] ) )
            continue;

        var_0.origin = var_2.v["origin"];
        var_0.angles = var_2.v["angles"];

        if ( !var_0 istouching( self ) )
            continue;

        var_3 = var_2.v["masked_exploder"];
        var_4 = var_2.v["masked_exploder_spawnflags"];
        var_5 = var_2.v["masked_exploder_script_disconnectpaths"];
        var_6 = spawn( "script_model", ( 0.0, 0.0, 0.0 ), var_4 );
        var_6 setmodel( var_3 );
        var_6.origin = var_2.v["origin"];
        var_6.angles = var_2.v["angles"];
        var_2.v["masked_exploder"] = undefined;
        var_2.v["masked_exploder_spawnflags"] = undefined;
        var_2.v["masked_exploder_script_disconnectpaths"] = undefined;
        var_6._id_2B33 = var_5;
        var_6.script_exploder = var_2.v["exploder"];
        common_scripts\_exploder::_id_8149( var_6 );
        var_2.model = var_6;
    }

    var_0 delete();
}

_id_6EB7( var_0 )
{
    var_1 = common_scripts\_destructible::_id_2918( var_0 );

    if ( var_1 != -1 )
        return;

    if ( !isdefined( level.destructible_functions ) )
        level.destructible_functions = [];

    var_2 = spawnstruct();
    var_2._id_2938 = common_scripts\_destructible::_id_2919( var_0 );
    var_2 thread common_scripts\_destructible::_id_6EB8();
    var_2 thread common_scripts\_destructible::_id_0753();
}

_id_2808( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
        var_3.destructibles = [];

    var_5 = [ "destructible_toy", "destructible_vehicle" ];
    var_6 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    foreach ( var_8 in var_5 )
    {
        var_9 = getentarray( var_8, "targetname" );

        foreach ( var_11 in var_9 )
        {
            foreach ( var_3 in var_0 )
            {
                if ( var_1 )
                {
                    var_6++;
                    var_6 %= 5;

                    if ( var_6 == 1 )
                        wait 0.05;
                }

                if ( !var_3 istouching( var_11 ) )
                    continue;

                var_11 delete();
                break;
            }
        }
    }
}

_id_280E( var_0, var_1 )
{
    var_2 = getentarray( "script_brushmodel", "classname" );
    var_3 = getentarray( "script_model", "classname" );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        var_2[var_2.size] = var_3[var_4];

    var_5 = [];
    var_6 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_7 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    foreach ( var_9 in var_0 )
    {
        foreach ( var_11 in var_2 )
        {
            if ( !isdefined( var_11.script_exploder ) )
                continue;

            var_6.origin = var_11 getorigin();

            if ( !var_9 istouching( var_6 ) )
                continue;

            var_5[var_5.size] = var_11;
        }
    }

    _id_0CE5( var_5 );
    var_6 delete();
}

_id_06F7()
{
    if ( !isdefined( self.destructibles ) )
        return;

    foreach ( var_1 in self.destructibles )
    {
        var_2 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
        var_2 setmodel( var_1._id_9485 );
        var_2.origin = var_1.origin;
        var_2.angles = var_1.angles;
        var_2.script_noteworthy = var_1.script_noteworthy;
        var_2.targetname = var_1.targetname;
        var_2.target = var_1.target;
        var_2.script_linkto = var_1.script_linkto;
        var_2.destructible_type = var_1.destructible_type;
        var_2._id_7A78 = var_1._id_7A78;
        var_2 common_scripts\_destructible::_id_80AB( 1 );
    }

    self.destructibles = [];
}

_id_7F6B( var_0 )
{
    self._id_38A6 = var_0;
}

_id_38A5()
{
    var_0 = self.flashendtime - gettime();

    if ( var_0 < 0 )
        return 0;

    return var_0 * 0.001;
}

_id_38A7()
{
    return _id_38A5() > 0;
}

_id_38A9( var_0 )
{
    if ( isdefined( self._id_38A6 ) && self._id_38A6 )
        return;

    var_1 = gettime() + var_0 * 1000.0;

    if ( isdefined( self.flashendtime ) )
        self.flashendtime = max( self.flashendtime, var_1 );
    else
        self.flashendtime = var_1;

    self notify( "flashed" );
    self _meth_816B( 1 );
}

_id_A0BE()
{
    for (;;)
    {
        var_0 = _func_0D7( "axis", "all" );
        var_1 = 0;

        foreach ( var_3 in var_0 )
        {
            if ( !isalive( var_3 ) )
                continue;

            if ( var_3 istouching( self ) )
            {
                var_1 = 1;
                break;
            }

            wait 0.0125;
        }

        if ( !var_1 )
        {
            var_5 = _id_3CB6( "axis" );

            if ( !var_5.size )
                break;
        }

        wait 0.05;
    }
}

_id_A0BF()
{
    var_0 = 0;

    for (;;)
    {
        var_1 = _func_0D7( "axis", "all" );
        var_2 = 0;

        foreach ( var_4 in var_1 )
        {
            if ( !isalive( var_4 ) )
                continue;

            if ( var_4 istouching( self ) )
            {
                if ( var_4 _id_2CE6() )
                    continue;

                var_2 = 1;
                var_0 = 1;
                break;
            }

            wait 0.0125;
        }

        if ( !var_2 )
        {
            var_6 = _id_3CB6( "axis" );

            if ( !var_6.size )
                break;
            else
                var_0 = 1;
        }

        wait 0.05;
    }

    return var_0;
}

_id_A0C0( var_0 )
{
    _id_A0BE();
    common_scripts\utility::flag_set( var_0 );
}

_id_A0B4( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    var_2 _id_A0C0( var_1 );
}

_id_6A93()
{
    level.player _id_32D9( "player_zero_attacker_accuracy" );
    level.player._id_0201 = 0;
    level.player _id_A52D::_id_9ACB();
}

_id_6A9E()
{
    level.player _id_32DD( "player_zero_attacker_accuracy" );
    level.player._id_0056 = 0;
    level.player._id_0201 = 1;
}

_id_7E92( var_0 )
{
    var_1 = _id_3E23();
    var_1._id_443E._id_6A61 = var_0;
    var_1 _id_A52D::_id_9ACB();
}

_id_0CEB( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
        var_1[var_3.script_parameters] = var_3;

    return var_1;
}

_id_0CEA( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
        var_1[var_3.classname] = var_3;

    return var_1;
}

_id_0CEC( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3.script_index;

        if ( isdefined( var_4 ) )
            var_1[var_4] = var_3;
    }

    return var_1;
}

_id_07A3( var_0 )
{
    if ( isdefined( var_0 ) )
        self._id_6857 = var_0;
    else
        self._id_6857 = getent( self.target, "targetname" );

    self linkto( self._id_6857 );
}

_id_38AA()
{
    self.flashendtime = undefined;
    self _meth_816B( 0 );
}

_id_3F80( var_0, var_1 )
{
    var_2 = getent( var_0, var_1 );

    if ( isdefined( var_2 ) )
        return var_2;

    return common_scripts\utility::getstruct( var_0, var_1 );
}

grenade_earthquake()
{
    thread endondeath();
    self endon( "end_explode" );
    self waittill( "explode", var_0 );
    _id_2A6D( var_0 );
}

endondeath()
{
    self waittill( "death" );
    waittillframeend;
    self notify( "end_explode" );
}

_id_2A6D( var_0 )
{
    playrumbleonposition( "grenade_rumble", var_0 );
    earthquake( 0.3, 0.5, var_0, 400 );

    foreach ( var_2 in level.players )
    {
        if ( distance( var_0, var_2.origin ) > 600 )
            continue;

        if ( var_2 damageconetrace( var_0 ) )
            var_2 thread dirteffect( var_0 );
    }
}

_id_6BE2( var_0, var_1, var_2, var_3 )
{
    return _id_6BE0( "shotgun", level.player, var_0, var_1, var_2, var_3 );
}

_id_6BE0( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level.player;

    var_1 _meth_8119( 0 );
    var_1 _meth_811A( 0 );
    var_1 disableweapons();
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6 linkto( self, "tag_passenger", _id_6BE1( var_0 ), ( 0.0, 0.0, 0.0 ) );
    var_6._id_6ACB = common_scripts\utility::spawn_tag_origin();
    var_6._id_6ACB linkto( self, "tag_body", _id_6BDF( var_0 ), ( 0.0, 0.0, 0.0 ) );

    if ( !isdefined( var_2 ) )
        var_2 = 90;

    if ( !isdefined( var_3 ) )
        var_3 = 90;

    if ( !isdefined( var_4 ) )
        var_4 = 40;

    if ( !isdefined( var_5 ) )
        var_5 = 40;

    var_1 disableweapons();
    var_1 playerlinkto( var_6, "tag_origin", 0.8, var_2, var_3, var_4, var_5 );
    var_1._id_4B03 = var_6;
    return var_6;
}

_id_6BE1( var_0 )
{
    switch ( var_0 )
    {
        case "shotgun":
            return ( -5.0, 10.0, -34.0 );
        case "backleft":
            return ( -45.0, 45.0, -34.0 );
        case "backright":
            return ( -45.0, 5.0, -34.0 );
    }
}

_id_6BDF( var_0 )
{
    switch ( var_0 )
    {
        case "shotgun":
            return ( -8.0, -90.0, -12.6 );
        case "backleft":
            return ( -58.0, 85.0, -12.6 );
        case "backright":
            return ( -58.0, -95.0, -12.6 );
    }
}

_id_6B84( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = self;
    var_2 = level.player;

    if ( isplayer( self ) )
    {
        var_2 = self;
        var_1 = var_2._id_4B03;
    }

    var_1 unlink();

    if ( !var_0 )
    {
        var_3 = 0.6;
        var_1 moveto( var_1._id_6ACB.origin, var_3, var_3 * 0.5, var_3 * 0.5 );
        wait(var_3);
    }

    var_2 unlink();
    var_2 enableweapons();
    var_2 _meth_8119( 1 );
    var_2 _meth_811A( 1 );
    var_2._id_4B03 = undefined;
    var_1._id_6ACB delete();
    var_1 delete();
}

dirteffect( var_0, var_1 )
{
    var_2 = _id_791A( var_0 );

    foreach ( var_5, var_4 in var_2 )
        thread _id_A52D::_id_43E4( var_5 );
}

_id_14BA( var_0 )
{
    if ( !isdefined( self._id_258C ) )
        return;

    var_1 = _id_791A( self._id_258C.origin );

    foreach ( var_4, var_3 in var_1 )
        thread _id_A52D::_id_14B6( var_4 );
}

_id_791A( var_0 )
{
    var_1 = vectornormalize( anglestoforward( self.angles ) );
    var_2 = vectornormalize( anglestoright( self.angles ) );
    var_3 = vectornormalize( var_0 - self.origin );
    var_4 = vectordot( var_3, var_1 );
    var_5 = vectordot( var_3, var_2 );
    var_6 = [];
    var_7 = self getcurrentweapon();

    if ( var_4 > 0 && var_4 > 0.5 && weapontype( var_7 ) != "riotshield" )
        var_6["bottom"] = 1;

    if ( abs( var_4 ) < 0.866 )
    {
        if ( var_5 > 0 )
            var_6["right"] = 1;
        else
            var_6["left"] = 1;
    }

    return var_6;
}

_id_66EC( var_0 )
{
    if ( !isdefined( self._id_63B1 ) )
        self._id_63B1 = self._id_02FF;

    self._id_02FF = var_0;
}

_id_66ED()
{
    if ( isdefined( self._id_63B1 ) )
        return;

    self._id_63B1 = self._id_02FF;
    self._id_02FF = 0;
}

_id_66EB()
{
    self._id_02FF = self._id_63B1;
    self._id_63B1 = undefined;
}

_id_A104()
{
    if ( isdefined( self._id_63BD ) )
        return;

    self._id_63BC = self._id_050E;
    self._id_63BD = self._id_050F;
    self._id_050E = 0;
    self._id_050F = 0;
}

_id_A102()
{
    if ( !isdefined( self._id_63BD ) )
    {
        self._id_63BC = self._id_050E;
        self._id_63BD = self._id_050F;
    }

    self._id_050E = 999999999;
    self._id_050F = 999999999;
}

_id_509D()
{
    return isdefined( self._id_63BD ) || isdefined( self._id_63BC );
}

_id_A103()
{
    self._id_050E = self._id_63BC;
    self._id_050F = self._id_63BD;
    self._id_63BC = undefined;
    self._id_63BD = undefined;
}

_id_30CB()
{
    thread _id_4BB5();
}

_id_4BB5()
{
    self endon( "disable_ignorerandombulletdamage_drone" );
    self endon( "death" );
    self._id_0201 = 1;
    self._id_3650 = self.health;
    self.health = 1000000;

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );

        if ( !isplayer( var_1 ) && issentient( var_1 ) )
        {
            if ( isdefined( var_1._id_0143 ) && var_1._id_0143 != self )
                continue;
        }

        self._id_3650 -= var_0;

        if ( self._id_3650 <= 0 )
            break;
    }

    self _meth_8052();
}

_id_7DDE( var_0 )
{
    self._id_04EE = var_0;
}

_id_2AAD()
{
    if ( !isalive( self ) )
        return;

    if ( !isdefined( self._id_0201 ) )
        return;

    self notify( "disable_ignorerandombulletdamage_drone" );
    self._id_0201 = undefined;
    self.health = self._id_3650;
}

_id_9367( var_0 )
{
    var_1 = spawnstruct();
    var_1 delaythread( var_0, ::_id_7C7C, "timeout" );
    return var_1;
}

delaythread( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    thread _id_A59B::delaythread_proc( var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

_id_27CE( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    childthread _id_A59B::_id_27CF( var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

_id_386D( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "death" );

    if ( !isarray( var_0 ) )
        var_0 = [ var_0, 0 ];

    thread _id_A59B::_id_386E( var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

_id_A0EC( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "death" );

    if ( !isarray( var_0 ) )
        var_0 = [ var_0, 0 ];

    thread _id_A59B::_id_A0ED( var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

_id_30B3( var_0 )
{
    var_0 *= 1000;
    self._id_0128 = 1;
    self._id_0105 = var_0;
    self._id_6094 = undefined;
}

_id_2A8F()
{
    self._id_0128 = 0;
    self._id_6094 = 1;
}

_id_7E4E( var_0, var_1 )
{
    level._id_0885 = var_0;
    level._id_0884 = var_1;
}

_id_742C( var_0 )
{
    level._id_5571[var_0] = gettime();
}

_id_7DF6( var_0 )
{
    level._id_2545 = var_0;
    thread _id_A52D::_id_7459();
}

_id_1EA9()
{
    level._id_2545 = undefined;
    thread _id_A52D::_id_7459();
}

_id_7F06( var_0, var_1, var_2 )
{
    _id_A507::_id_4D76();

    if ( isdefined( var_2 ) )
        level._id_A323._id_9C5D = var_2;

    level._id_A323._id_0358 = var_1;
    level._id_A323._id_0522 = var_0;
    level notify( "windchange", "strong" );
}

_id_8F50( var_0 )
{
    if ( var_0.size > 1 )
        return 0;

    var_1 = [];
    var_1["0"] = 1;
    var_1["1"] = 1;
    var_1["2"] = 1;
    var_1["3"] = 1;
    var_1["4"] = 1;
    var_1["5"] = 1;
    var_1["6"] = 1;
    var_1["7"] = 1;
    var_1["8"] = 1;
    var_1["9"] = 1;

    if ( isdefined( var_1[var_0] ) )
        return 1;

    return 0;
}

_id_7DDA( var_0, var_1 )
{
    level._id_132D[var_0] = var_1;
    _id_A59B::_id_9A99();
}

_id_62E8( var_0 )
{
    for ( var_1 = 0; var_1 < 8; var_1++ )
        objective_additionalposition( var_0, var_1, ( 0.0, 0.0, 0.0 ) );
}

_id_3DD9( var_0 )
{
    var_1 = [];
    var_1["minutes"] = 0;

    for ( var_1["seconds"] = int( var_0 / 1000 ); var_1["seconds"] >= 60; var_1["seconds"] -= 60 )
        var_1["minutes"]++;

    if ( var_1["seconds"] < 10 )
        var_1["seconds"] = "0" + var_1["seconds"];

    return var_1;
}

_id_6B48( var_0 )
{
    var_1 = level.player getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
            return 1;
    }

    return 0;
}

_id_62AE( var_0 )
{
    if ( !isdefined( level._id_62AF ) )
        level._id_62AF = [];

    if ( !isdefined( level._id_62AF[var_0] ) )
        level._id_62AF[var_0] = level._id_62AF.size + 1;

    return level._id_62AF[var_0];
}

_id_62BE( var_0 )
{
    return isdefined( level._id_62AF ) && isdefined( level._id_62AF[var_0] );
}

_id_6B9F( var_0 )
{
    self _meth_80FC( var_0 );
    self._id_2E17 = var_0;
}

_id_6ACE()
{
    self _meth_80FD();
    self._id_2E17 = undefined;
}

_id_42FB( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_4 - var_2;
    var_6 = var_3 - var_1;
    var_7 = var_5 / var_6;
    var_0 -= var_3;
    var_0 = var_7 * var_0;
    var_0 += var_4;
    return var_0;
}

_id_3096()
{
    self._id_713F = 1;
}

_id_2A71()
{
    self._id_713F = undefined;
}

_id_3097( var_0 )
{
    var_0 _id_3096();
}

_id_2A72( var_0 )
{
    var_0 _id_2A71();
}

_id_6004( var_0 )
{
    var_1 = tablelookup( "sound/soundlength.csv", 0, var_0, 1 );

    if ( !isdefined( var_1 ) || var_1 == "" )
        return -1;

    var_1 = int( var_1 );
    var_1 *= 0.001;
    return var_1;
}

_id_5007( var_0 )
{
    var_1 = _func_0DD( var_0 );
    return var_1["count"];
}

_id_5768( var_0, var_1, var_2 )
{
    var_3 = var_2 - var_1;
    var_4 = var_0 * var_3;
    var_5 = var_1 + var_4;
    return var_5;
}

_id_27B7( var_0 )
{
    level.loadout = var_0;
}

_id_9274( var_0 )
{
    _id_27B7( var_0 );
    level.template_script = var_0;
}

_id_9276( var_0 )
{
    level._id_110D = var_0;
}

_id_3B8F( var_0, var_1 )
{
    thread _id_3B90( var_0, var_1 );
}

_id_3B90( var_0, var_1 )
{
    var_2 = getent( var_0, "script_noteworthy" );
    var_2 notify( "new_volume_command" );
    var_2 endon( "new_volume_command" );
    wait 0.05;
    _id_3B8E( var_2, var_1 );
}

_id_3B8E( var_0, var_1 )
{
    var_0._id_3B76 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( var_1 )
        _id_0D14( var_0._id_3B21, common_scripts\utility::pauseeffect );
    else
        common_scripts\utility::array_thread( var_0._id_3B21, common_scripts\utility::pauseeffect );
}

_id_0D14( var_0, var_1, var_2 )
{
    var_3 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 5;

    var_4 = [];

    foreach ( var_6 in var_0 )
    {
        var_4[var_4.size] = var_6;
        var_3++;
        var_3 %= var_2;

        if ( var_2 == 0 )
        {
            common_scripts\utility::array_thread( var_4, var_1 );
            wait 0.05;
            var_4 = [];
        }
    }
}

_id_3B92( var_0 )
{
    thread _id_3B93( var_0 );
}

_id_3B93( var_0 )
{
    var_1 = getent( var_0, "script_noteworthy" );
    var_1 notify( "new_volume_command" );
    var_1 endon( "new_volume_command" );
    wait 0.05;

    if ( !isdefined( var_1._id_3B76 ) )
        return;

    var_1._id_3B76 = undefined;
    _id_3B91( var_1 );
}

_id_3B91( var_0 )
{
    common_scripts\utility::array_thread( var_0._id_3B21, ::_id_748A );
}

_id_3834( var_0 )
{
    if ( !isdefined( level._id_3832 ) )
        level._id_3832 = [];

    if ( !isdefined( level._id_3832[var_0] ) )
        level._id_3832[var_0] = 1;
    else
        level._id_3832[var_0]++;
}

_id_3833( var_0 )
{
    level._id_3832[var_0]--;
    level._id_3832[var_0] = int( max( 0, level._id_3832[var_0] ) );

    if ( level._id_3832[var_0] )
        return;

    common_scripts\utility::flag_set( var_0 );
}

_id_3835( var_0, var_1 )
{
    level._id_3832[var_0] = var_1;
}

_id_0741( var_0, var_1 )
{
    if ( !isdefined( level._id_1E6A ) )
        level._id_1E6A = [];

    if ( !isdefined( level._id_1E6A[var_1] ) )
        level._id_1E6A[var_1] = [];

    level._id_1E6A[var_1][level._id_1E6A[var_1].size] = var_0;
}

_id_1E6A( var_0 )
{
    var_1 = level._id_1E6A[var_0];
    var_1 = common_scripts\utility::array_removeundefined( var_1 );
    _id_0CE5( var_1 );
    level._id_1E6A[var_0] = undefined;
}

_id_1E6B( var_0 )
{
    if ( !isdefined( level._id_1E6A ) )
        return;

    if ( !isdefined( level._id_1E6A[var_0] ) )
        return;

    var_1 = level._id_1E6A[var_0];
    var_1 = common_scripts\utility::array_removeundefined( var_1 );

    foreach ( var_3 in var_1 )
    {
        if ( !isai( var_3 ) )
            continue;

        if ( !isalive( var_3 ) )
            continue;

        if ( !isdefined( var_3._id_58D4 ) )
            continue;

        if ( !var_3._id_58D4 )
            continue;

        var_3 _id_8E9E();
    }

    _id_0CE5( var_1 );
    level._id_1E6A[var_0] = undefined;
}

_id_07B6( var_0 )
{
    if ( !isdefined( self._id_9799 ) )
        thread _id_A59B::_id_07B5();

    self._id_9799[self._id_9799.size] = var_0;
}

_id_3EEA()
{
    var_0 = [];
    var_1 = getentarray();

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.classname ) )
            continue;

        if ( issubstr( var_3.classname, "weapon_" ) )
            var_0[var_0.size] = var_3;
    }

    return var_0;
}

_id_70B7( var_0 )
{
    level._id_78B6[var_0] = var_0;
}

_id_5F3F( var_0, var_1, var_2 )
{
    self notify( "newmove" );
    self endon( "newmove" );

    if ( !isdefined( var_2 ) )
        var_2 = 200;

    var_3 = distance( self.origin, var_0 );
    var_4 = var_3 / var_2;
    var_5 = vectornormalize( var_0 - self.origin );
    self moveto( var_0, var_4, 0, 0 );
    self _meth_82B5( var_1, var_4, 0, 0 );
    wait(var_4);

    if ( !isdefined( self ) )
        return;

    self._id_04FF = var_5 * var_3 / var_4;
}

_id_383C( var_0 )
{
    level endon( var_0 );
    self waittill( "death" );
    common_scripts\utility::flag_set( var_0 );
}

_id_30B1()
{
    level._id_259E = 1;
}

_id_2A8D()
{
    level._id_259E = 0;
}

_id_500E()
{
    return isdefined( level._id_259E ) && level._id_259E;
}

_id_30B2()
{
    level._id_259F = 1;
}

_id_2A8E()
{
    level._id_259F = 0;
}

_id_500F()
{
    return isdefined( level._id_259F ) && level._id_259F;
}

_id_074C()
{
    _id_A51A::_id_5E3C();
}

_id_733A()
{
    _id_A51A::_id_8EF3();
}

_id_5014()
{
    if ( getdvar( "e3demo" ) == "1" )
        return 1;

    return 0;
}

_id_286D( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstructarray( var_0, var_1 );
    _id_286E( var_3, var_2 );
}

_id_286C( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = var_0.script_linkname;

    if ( isdefined( var_1 ) && isdefined( level.struct_class_names["script_linkname"] ) && isdefined( level.struct_class_names["script_linkname"][var_1] ) )
    {
        foreach ( var_4, var_3 in level.struct_class_names["script_linkname"][var_1] )
        {
            if ( isdefined( var_3 ) && var_0 == var_3 )
                level.struct_class_names["script_linkname"][var_1][var_4] = undefined;
        }

        if ( level.struct_class_names["script_linkname"][var_1].size == 0 )
            level.struct_class_names["script_linkname"][var_1] = undefined;
    }

    var_1 = var_0.script_noteworthy;

    if ( isdefined( var_1 ) && isdefined( level.struct_class_names["script_noteworthy"] ) && isdefined( level.struct_class_names["script_noteworthy"][var_1] ) )
    {
        foreach ( var_4, var_3 in level.struct_class_names["script_noteworthy"][var_1] )
        {
            if ( isdefined( var_3 ) && var_0 == var_3 )
                level.struct_class_names["script_noteworthy"][var_1][var_4] = undefined;
        }

        if ( level.struct_class_names["script_noteworthy"][var_1].size == 0 )
            level.struct_class_names["script_noteworthy"][var_1] = undefined;
    }

    var_1 = var_0.target;

    if ( isdefined( var_1 ) && isdefined( level.struct_class_names["target"] ) && isdefined( level.struct_class_names["target"][var_1] ) )
    {
        foreach ( var_4, var_3 in level.struct_class_names["target"][var_1] )
        {
            if ( isdefined( var_3 ) && var_0 == var_3 )
                level.struct_class_names["target"][var_1][var_4] = undefined;
        }

        if ( level.struct_class_names["target"][var_1].size == 0 )
            level.struct_class_names["target"][var_1] = undefined;
    }

    var_1 = var_0.targetname;

    if ( isdefined( var_1 ) && isdefined( level.struct_class_names["targetname"] ) && isdefined( level.struct_class_names["targetname"][var_1] ) )
    {
        foreach ( var_4, var_3 in level.struct_class_names["targetname"][var_1] )
        {
            if ( isdefined( var_3 ) && var_0 == var_3 )
                level.struct_class_names["targetname"][var_1][var_4] = undefined;
        }

        if ( level.struct_class_names["targetname"][var_1].size == 0 )
            level.struct_class_names["targetname"][var_1] = undefined;
    }

    if ( isdefined( level.struct ) )
    {
        foreach ( var_4, var_3 in level.struct )
        {
            if ( var_0 == var_3 )
                level.struct[var_4] = undefined;
        }
    }
}

_id_286E( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isarray( var_0 ) || var_0.size == 0 )
        return;

    var_1 = common_scripts\utility::ter_op( isdefined( var_1 ), var_1, 0 );
    var_1 = common_scripts\utility::ter_op( var_1 > 0, var_1, 0 );

    if ( var_1 > 0 )
    {
        foreach ( var_3 in var_0 )
        {
            _id_286C( var_3 );
            wait(var_1);
        }
    }
    else
    {
        foreach ( var_3 in var_0 )
            _id_286C( var_3 );
    }
}

_id_40FA( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( var_0, var_1 );
    _id_286C( var_2 );
    return var_2;
}

_id_40FC( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstructarray( var_0, var_1 );
    _id_286E( var_3, var_2 );
    return var_3;
}

_id_3F81( var_0, var_1 )
{
    var_2 = _id_3F80( var_0, var_1 );

    if ( !isdefined( var_2 ) )
        var_2 = getnode( var_0, var_1 );

    if ( !isdefined( var_2 ) )
        var_2 = getvehiclenode( var_0, var_1 );

    return var_2;
}

_id_7F60( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_3 ) )
        self._id_3317 = var_3;
    else
        self._id_3317 = ( 0.0, 0.0, 0.0 );

    if ( isdefined( var_4 ) )
        self._id_3318 = var_4;

    self notify( "new_head_icon" );
    var_5 = newhudelem();
    var_5.archived = 1;
    var_5.alpha = 0.8;
    var_5 setshader( var_0, var_1, var_2 );
    var_5 setwaypoint( 0, 0, 0, 1 );
    self.entityheadicon = var_5;
    _id_9B10();
    thread _id_9B0F();
    thread _id_28EA();
}

_id_739E()
{
    if ( !isdefined( self.entityheadicon ) )
        return;

    self.entityheadicon destroy();
}

_id_9B0F()
{
    self endon( "new_head_icon" );
    self endon( "death" );
    var_0 = self.origin;

    for (;;)
    {
        if ( var_0 != self.origin )
        {
            _id_9B10();
            var_0 = self.origin;
        }

        wait 0.05;
    }
}

_id_9B10()
{
    if ( isdefined( self._id_3318 ) )
    {
        var_0 = self [[ self._id_3318 ]]();

        if ( isdefined( var_0 ) )
        {
            self.entityheadicon.x = self._id_3317[0] + var_0[0];
            self.entityheadicon.y = self._id_3317[1] + var_0[1];
            self.entityheadicon.z = self._id_3317[2] + var_0[2];
            return;
        }
    }

    self.entityheadicon.x = self.origin[0] + self._id_3317[0];
    self.entityheadicon.y = self.origin[1] + self._id_3317[1];
    self.entityheadicon.z = self.origin[2] + self._id_3317[2];
}

_id_28EA()
{
    self endon( "new_head_icon" );
    self waittill( "death" );

    if ( !isdefined( self.entityheadicon ) )
        return;

    self.entityheadicon destroy();
}

_id_A348( var_0 )
{
    var_1 = var_0 - self.origin;
    return ( vectordot( var_1, anglestoforward( self.angles ) ), -1.0 * vectordot( var_1, anglestoright( self.angles ) ), vectordot( var_1, anglestoup( self.angles ) ) );
}

_id_4F68( var_0, var_1, var_2, var_3, var_4 )
{
    level._id_4F89 = spawnstruct();
    level._id_4F89._id_20D2 = 3;
    level._id_4F89._id_35E4 = 1.5;
    level._id_4F89._id_35DF = undefined;

    if ( isdefined( var_3 ) )
        level._id_4F89._id_5771 = [ var_0, var_1, var_2, var_3 ];
    else
        level._id_4F89._id_5771 = [ var_0, var_1, var_2 ];

    common_scripts\utility::noself_array_call( level._id_4F89._id_5771, ::precachestring );
}

_id_4F69( var_0 )
{
    level._id_4F89._id_255A = var_0;
}

_id_4F6A( var_0, var_1, var_2 )
{
    level._id_4F89._id_20D2 = var_0;
    level._id_4F89._id_35E4 = var_1;
    level._id_4F89._id_35DF = var_2;
}

_id_7E7F( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( var_1 ) )
        self._id_76AC = var_1;

    if ( isdefined( var_2 ) )
        self._id_A0FF = var_2;

    if ( isdefined( var_3 ) )
        self._id_8A29 = var_3;

    self._id_0C4D = var_0;
    var_10 = [];

    if ( isdefined( var_4 ) && isdefined( var_5 ) )
    {
        var_11 = [];

        foreach ( var_13 in var_6 )
            var_11[var_13] = var_4;

        var_10["cover_trans"] = var_11;
        var_15 = [];

        foreach ( var_13 in var_6 )
            var_15[var_13] = var_5;

        var_10["cover_exit"] = var_15;
    }
    else if ( isdefined( var_4 ) || isdefined( var_5 ) )
    {

    }

    if ( isdefined( var_7 ) )
    {
        if ( isdefined( var_8 ) )
        {

        }

        var_10["run_turn"] = var_7;
        var_10["walk_turn"] = var_8;
        self._id_623C = undefined;
    }
    else if ( isdefined( var_8 ) )
    {

    }
    else
        self._id_623C = 1;

    if ( isdefined( var_9 ) )
    {
        var_18 = [];
        var_18["stairs_up"] = var_9["stairs_up"];
        var_18["stairs_down"] = var_9["stairs_down"];
        var_18["stairs_up_in"] = var_9["stairs_up_in"];
        var_18["stairs_down_in"] = var_9["stairs_down_in"];
        var_18["stairs_up_out"] = var_9["stairs_up_out"];
        var_18["stairs_down_out"] = var_9["stairs_down_out"];
        var_10["walk"] = var_18;
        var_10["run"] = var_18;
        self._id_76AD = 1;
    }
    else
        self._id_76AD = undefined;

    anim._id_0CCA[var_0] = var_10;
    animscripts\init_move_transitions::_id_4E2C( var_0 );
}

_id_1EC7( var_0 )
{
    self._id_0C4D = undefined;
    anim._id_0CCA[var_0] = undefined;
    self._id_76AC = undefined;
    self._id_76AD = undefined;
    self._id_A0FF = undefined;
    self._id_8A29 = undefined;
}

_id_72D3( var_0, var_1, var_2 )
{
    animscripts\animset::_id_72EA( var_0, var_1, var_2 );
}

_id_0CC7( var_0 )
{
    return animscripts\animset::_id_0CC9( var_0 );
}

_id_7DD2( var_0 )
{
    self._id_0C4D = var_0;
    self notify( "move_loop_restart" );

    if ( var_0 == "creepwalk" )
        self._id_03BF = 72;
}

_id_1E9B()
{
    if ( isdefined( self._id_0C4D ) && self._id_0C4D == "creepwalk" )
        self._id_03BF = 30;

    self._id_0C4D = undefined;
    self notify( "move_loop_restart" );
}

_id_8436( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( var_3 _id_8437( var_0, var_1 ) )
            return 1;
    }

    return 0;
}

_id_8437( var_0, var_1 )
{
    var_2 = self getpointinbounds( 0, 0, 0 );
    var_3 = var_2 - var_0;
    var_4 = length( var_3 );
    var_5 = asin( clamp( 60 / var_4, 0, 1 ) );

    if ( vectordot( vectornormalize( var_3 ), vectornormalize( var_1 - var_0 ) ) > cos( var_5 ) )
        return 1;

    return 0;
}

_id_96F0( var_0 )
{
    _func_218( var_0 );

    while ( !_func_21E( var_0 ) )
        wait 0.1;

    common_scripts\utility::flag_set( var_0 + "_loaded" );
}

_id_9702( var_0 )
{
    _func_219( var_0 );

    while ( _func_21E( var_0 ) )
        wait 0.1;

    common_scripts\utility::flag_clear( var_0 + "_loaded" );
}

_id_96ED( var_0 )
{
    common_scripts\utility::flag_init( var_0 + "_loaded" );
}

_id_96FA( var_0, var_1 )
{
    if ( common_scripts\utility::flag( var_0 + "_loaded" ) )
        _id_9702( var_0 );

    if ( !common_scripts\utility::flag( var_1 + "_loaded" ) )
        _id_96F0( var_1 );
}

_id_9703( var_0 )
{
    _func_21A();
    _id_96F0( var_0 );
}

_id_2761( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
    {
        foreach ( var_4 in var_0 )
        {
            if ( isdefined( var_4 ) )
            {
                if ( isarray( var_4 ) )
                {
                    _id_2761( var_4, var_1 );
                    continue;
                }

                var_4 call [[ var_1 ]]();
            }
        }
    }
    else
    {
        switch ( var_2.size )
        {
            case 0:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2761( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 call [[ var_1 ]]();
                    }
                }

                break;
            case 1:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2761( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 call [[ var_1 ]]( var_2[0] );
                    }
                }

                break;
            case 2:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2761( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 call [[ var_1 ]]( var_2[0], var_2[1] );
                    }
                }

                break;
            case 3:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2761( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 call [[ var_1 ]]( var_2[0], var_2[1], var_2[2] );
                    }
                }

                break;
            case 4:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2761( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 call [[ var_1 ]]( var_2[0], var_2[1], var_2[2], var_2[3] );
                    }
                }

                break;
            case 5:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2761( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 call [[ var_1 ]]( var_2[0], var_2[1], var_2[2], var_2[3], var_2[4] );
                    }
                }

                break;
        }
    }
}

_id_2762( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
    {
        foreach ( var_4 in var_0 )
        {
            if ( isdefined( var_4 ) )
            {
                if ( isarray( var_4 ) )
                {
                    _id_2762( var_4, var_1, var_2 );
                    continue;
                }

                var_4 thread [[ var_1 ]]();
            }
        }
    }
    else
    {
        switch ( var_2.size )
        {
            case 0:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2762( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 thread [[ var_1 ]]();
                    }
                }

                break;
            case 1:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2762( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 thread [[ var_1 ]]( var_2[0] );
                    }
                }

                break;
            case 2:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2762( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 thread [[ var_1 ]]( var_2[0], var_2[1] );
                    }
                }

                break;
            case 3:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2762( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 thread [[ var_1 ]]( var_2[0], var_2[1], var_2[2] );
                    }
                }

                break;
            case 4:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2762( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 thread [[ var_1 ]]( var_2[0], var_2[1], var_2[2], var_2[3] );
                    }
                }

                break;
            case 5:
                foreach ( var_4 in var_0 )
                {
                    if ( isdefined( var_4 ) )
                    {
                        if ( isarray( var_4 ) )
                        {
                            _id_2762( var_4, var_1, var_2 );
                            continue;
                        }

                        var_4 thread [[ var_1 ]]( var_2[0], var_2[1], var_2[2], var_2[3], var_2[4] );
                    }
                }

                break;
        }
    }
}

setdvar_cg_ng( var_0, var_1, var_2 )
{
    if ( !isdefined( level.console ) )
        set_console_status();

    if ( is_gen4() )
        setdvar( var_0, var_2 );
    else
        setdvar( var_0, var_1 );
}

_id_7FFD( var_0, var_1, var_2 )
{
    if ( !isdefined( level.console ) )
        set_console_status();

    if ( is_gen4() )
        _func_0D3( var_0, var_2 );
    else
        _func_0D3( var_0, var_1 );
}

_id_3969( var_0, var_1 )
{
    self endon( "death" );
    self endon( "stop_path" );
    self notify( "stop_going_to_node" );
    self notify( "follow_path" );
    self endon( "follow_path" );
    wait 0.1;
    var_2 = var_0;
    var_3 = undefined;
    var_4 = undefined;

    if ( !isdefined( var_1 ) )
        var_1 = 300;

    self._id_24E6 = var_2;
    var_2 script_delay();

    while ( isdefined( var_2 ) )
    {
        self._id_24E6 = var_2;

        if ( isdefined( var_2._id_025B ) )
            break;

        if ( isdefined( level.struct_class_names["targetname"][var_2.targetname] ) )
            var_4 = ::_id_396C;
        else if ( isdefined( var_2.classname ) )
            var_4 = ::_id_396A;
        else
            var_4 = ::_id_396B;

        if ( isdefined( var_2.radius ) && var_2.radius != 0 )
            self._id_01C7 = var_2.radius;

        if ( self._id_01C7 < 16 )
            self._id_01C7 = 16;

        if ( isdefined( var_2.height ) && var_2.height != 0 )
            self._id_01C5 = var_2.height;

        var_5 = self._id_01C7;
        self childthread [[ var_4 ]]( var_2 );

        if ( isdefined( var_2._id_0046 ) )
            var_2 waittill( var_2._id_0046 );
        else
        {
            for (;;)
            {
                self waittill( "goal" );

                if ( distance( var_2.origin, self.origin ) < var_5 + 10 || self.team != "allies" )
                    break;
            }
        }

        var_2 notify( "trigger", self );

        if ( isdefined( var_2._id_79D3 ) )
            common_scripts\utility::flag_set( var_2._id_79D3 );

        if ( isdefined( var_2.script_parameters ) )
        {
            var_6 = strtok( var_2.script_parameters, " " );

            for ( var_7 = 0; var_7 < var_6.size; var_7++ )
            {
                if ( isdefined( level._id_2542 ) )
                    self [[ level._id_2542 ]]( var_6[var_7], var_2 );

                if ( self.type == "dog" )
                    continue;

                switch ( var_6[var_7] )
                {
                    case "enable_cqb":
                        _id_30AF();
                        continue;
                    case "disable_cqb":
                        _id_2A8C();
                        continue;
                    case "deleteme":
                        self delete();
                        return;
                }
            }
        }

        if ( !isdefined( var_2._id_7AB1 ) && var_1 > 0 && self.team == "allies" )
        {
            while ( isalive( level.player ) )
            {
                if ( _id_396D( var_2, var_1 ) )
                    break;

                if ( isdefined( var_2._id_0046 ) )
                {
                    self._id_01C7 = var_5;
                    self _meth_81A6( self.origin );
                }

                wait 0.05;
            }
        }

        if ( !isdefined( var_2.target ) )
            break;

        if ( isdefined( var_2._id_79D5 ) )
            common_scripts\utility::flag_wait( var_2._id_79D5 );

        var_2 script_delay();
        var_2 = var_2 common_scripts\utility::get_target_ent();
    }

    self notify( "path_end_reached" );
}

_id_396D( var_0, var_1 )
{
    if ( distance( level.player.origin, var_0.origin ) < distance( self.origin, var_0.origin ) )
        return 1;

    var_2 = undefined;
    var_2 = anglestoforward( self.angles );
    var_3 = vectornormalize( level.player.origin - self.origin );

    if ( isdefined( var_0.target ) )
    {
        var_4 = common_scripts\utility::get_target_ent( var_0.target );
        var_2 = vectornormalize( var_4.origin - var_0.origin );
    }
    else if ( isdefined( var_0.angles ) )
        var_2 = anglestoforward( var_0.angles );
    else
        var_2 = anglestoforward( self.angles );

    if ( vectordot( var_2, var_3 ) > 0 )
        return 1;

    if ( distance( level.player.origin, self.origin ) < var_1 )
        return 1;

    return 0;
}

_id_396B( var_0 )
{
    self notify( "follow_path_new_goal" );

    if ( isdefined( var_0._id_0046 ) )
    {
        var_0 _id_A506::_id_0BD0( self, var_0._id_0046 );
        self notify( "starting_anim", var_0._id_0046 );

        if ( isdefined( var_0.script_parameters ) && issubstr( var_0.script_parameters, "gravity" ) )
            var_0 _id_A506::_id_0BCD( self, var_0._id_0046 );
        else
            var_0 _id_A506::_id_0BD2( self, var_0._id_0046 );

        self _meth_81A6( self.origin );
    }
    else
        _id_7E45( var_0 );
}

_id_396A( var_0 )
{
    self notify( "follow_path_new_goal" );

    if ( isdefined( var_0._id_0046 ) )
    {
        var_0 _id_A506::_id_0BD0( self, var_0._id_0046 );
        self notify( "starting_anim", var_0._id_0046 );

        if ( isdefined( var_0.script_parameters ) && issubstr( var_0.script_parameters, "gravity" ) )
            var_0 _id_A506::_id_0BCD( self, var_0._id_0046 );
        else
            var_0 _id_A506::_id_0BD2( self, var_0._id_0046 );

        self _meth_81A6( self.origin );
    }
    else
        _id_7E41( var_0 );
}

_id_396C( var_0 )
{
    self notify( "follow_path_new_goal" );

    if ( isdefined( var_0._id_0046 ) )
    {
        var_0 _id_A506::_id_0BD0( self, var_0._id_0046 );
        self notify( "starting_anim", var_0._id_0046 );
        _id_2A9C();

        if ( isdefined( var_0.script_parameters ) && issubstr( var_0.script_parameters, "gravity" ) )
            var_0 _id_A506::_id_0BCD( self, var_0._id_0046 );
        else
            var_0 _id_A506::_id_0BD2( self, var_0._id_0046 );

        delaythread( 0.05, ::_id_30BC );
        self _meth_81A6( self.origin );
    }
    else
        _id_7E47( var_0.origin );
}

_id_6E78( var_0 )
{
    if ( !isdefined( level._id_6E77 ) )
        level._id_6E77 = [];

    level._id_6E77 = common_scripts\utility::array_add( level._id_6E77, var_0 );
}

_id_3BD0()
{
    if ( level.xenon )
        return 1;

    if ( level.ps3 )
        return 1;

    return 0;
}

_id_56AE( var_0, var_1 )
{
    thread _id_56AF( var_0, var_1 );
}

_id_56AF( var_0, var_1 )
{
    self notify( "new_lerp_Fov_Saved" );
    self endon( "new_lerp_Fov_Saved" );
    self _meth_8031( var_0, var_1 );
    wait(var_1);
    _func_0D3( "cg_fov", var_0 );
}

_id_3F71( var_0, var_1 )
{
    var_2 = getdvar( var_0 );

    if ( var_2 != "" )
        return float( var_2 );

    return var_1;
}

_id_3F72( var_0, var_1 )
{
    var_2 = getdvar( var_0 );

    if ( var_2 != "" )
        return int( var_2 );

    return var_1;
}

_id_99E9( var_0 )
{
    var_1 = "ui_actionslot_" + var_0 + "_forceActive";
    setdvar( var_1, "on" );
}

_id_99E8( var_0 )
{
    var_1 = "ui_actionslot_" + var_0 + "_forceActive";
    setdvar( var_1, "turn_off" );
}

_id_99EA( var_0 )
{
    var_1 = "ui_actionslot_" + var_0 + "_forceActive";
    setdvar( var_1, "onetime" );
}

_id_4746( var_0, var_1 )
{
    var_2 = getnumparts( var_0 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        if ( tolower( getpartname( var_0, var_3 ) ) == tolower( var_1 ) )
            return 1;
    }

    return 0;
}

_id_8F73( var_0, var_1, var_2, var_3 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    var_4 = 320;
    var_5 = 200;
    var_6 = [];

    foreach ( var_10, var_8 in var_0 )
    {
        var_9 = _id_A541::_id_8F75( var_8, var_1, var_4, var_5 + var_10 * 20, "center", var_2, var_3 );
        var_6 = common_scripts\utility::array_combine( var_9, var_6 );
    }

    wait(var_1);
    _id_A541::_id_8F74( var_6, var_4, var_5, var_0.size );
}

_id_1C13( var_0 )
{
    thread _id_A541::_id_1C12( var_0 );
}

_id_30EC( var_0 )
{
    if ( !_id_76FC() )
        return;

    if ( isdefined( self._id_5A77 ) && self._id_5A77 )
        return;

    if ( !level.nextgen )
        return;

    if ( isdefined( var_0 ) && var_0 )
    {
        if ( !isdefined( self._id_0C4D ) || self._id_0C4D == "soldier" )
            self._id_0C4D = "s1_soldier";
    }
    else if ( !isdefined( self._id_0C4D ) || self._id_0C4D == "s1_soldier" )
        self._id_0C4D = "soldier";
}

_id_76FC()
{
    if ( level.nextgen )
        return 1;

    return 0;
}

_id_08EB()
{
    if ( isdefined( self._id_79A8 ) )
        return;

    if ( isdefined( self._id_05CF ) )
        _id_0933();

    self._id_05CF = [];
    self._id_0124 = _id_A59B::_id_090F( self._id_0124, "disableplayeradsloscheck", 1 );
    self._id_01FC = _id_A59B::_id_090F( self._id_01FC, "ignoreall", 1 );
    self.ignoreme = _id_A59B::_id_090F( self.ignoreme, "ignoreme", 1 );
    self._id_01D4 = _id_A59B::_id_090F( self._id_01D4, "grenadeawareness", 0 );
    self._id_006B = _id_A59B::_id_090F( self._id_006B, "badplaceawareness", 0 );
    self._id_01FE = _id_A59B::_id_090F( self._id_01FE, "ignoreexplosionevents", 1 );
    self._id_0201 = _id_A59B::_id_090F( self._id_0201, "ignorerandombulletdamage", 1 );
    self._id_0202 = _id_A59B::_id_090F( self._id_0202, "ignoresuppression", 1 );
    self._id_0131 = _id_A59B::_id_090F( self._id_0131, "dontavoidplayer", 1 );
    self._id_02B1 = _id_A59B::_id_090F( self._id_02B1, "newEnemyReactionDistSq", 0 );
    self._id_2AF6 = _id_A59B::_id_090F( self._id_2AF6, "disableBulletWhizbyReaction", 1 );
    self._id_2B11 = _id_A59B::_id_090F( self._id_2B11, "disableFriendlyFireReaction", 1 );
    self._id_2D37 = _id_A59B::_id_090F( self._id_2D37, "dontMelee", 1 );
    self._id_38A6 = _id_A59B::_id_090F( self._id_38A6, "flashBangImmunity", 1 );
    self._id_0128 = _id_A59B::_id_090F( self._id_0128, "doDangerReact", 0 );
    self._id_6094 = _id_A59B::_id_090F( self._id_6094, "neverSprintForVariation", 1 );
    self._id_0007._id_2B1F = _id_A59B::_id_090F( self._id_0007._id_2B1F, "a.disablePain", 1 );
    self._id_0034 = _id_A59B::_id_090F( self._id_0034, "allowPain", 0 );
    self._id_0180 = _id_A59B::_id_090F( self._id_0180, "fixedNode", 1 );
    self._id_79E4 = _id_A59B::_id_090F( self._id_79E4, "script_forcegoal", 1 );
    self._id_01C7 = _id_A59B::_id_090F( self._id_01C7, "goalradius", 5 );
    _id_2A73();
}

_id_0933( var_0 )
{
    if ( isdefined( self._id_79A8 ) )
        return;

    if ( isdefined( var_0 ) && var_0 )
    {
        if ( isdefined( self._id_05CF ) )
            self._id_05CF = undefined;
    }

    self._id_0124 = _id_A59B::_id_090D( "disableplayeradsloscheck", 0 );
    self._id_01FC = _id_A59B::_id_090D( "ignoreall", 0 );
    self.ignoreme = _id_A59B::_id_090D( "ignoreme", 0 );
    self._id_01D4 = _id_A59B::_id_090D( "grenadeawareness", 1 );
    self._id_006B = _id_A59B::_id_090D( "badplaceawareness", 1 );
    self._id_01FE = _id_A59B::_id_090D( "ignoreexplosionevents", 0 );
    self._id_0201 = _id_A59B::_id_090D( "ignorerandombulletdamage", 0 );
    self._id_0202 = _id_A59B::_id_090D( "ignoresuppression", 0 );
    self._id_0131 = _id_A59B::_id_090D( "dontavoidplayer", 0 );
    self._id_02B1 = _id_A59B::_id_090D( "newEnemyReactionDistSq", 262144 );
    self._id_2AF6 = _id_A59B::_id_090D( "disableBulletWhizbyReaction", undefined );
    self._id_2B11 = _id_A59B::_id_090D( "disableFriendlyFireReaction", undefined );
    self._id_2D37 = _id_A59B::_id_090D( "dontMelee", undefined );
    self._id_38A6 = _id_A59B::_id_090D( "flashBangImmunity", undefined );
    self._id_0128 = _id_A59B::_id_090D( "doDangerReact", 1 );
    self._id_6094 = _id_A59B::_id_090D( "neverSprintForVariation", undefined );
    self._id_0007._id_2B1F = _id_A59B::_id_090D( "a.disablePain", 0 );
    self._id_0034 = _id_A59B::_id_090D( "allowPain", 1 );
    self._id_0180 = _id_A59B::_id_090D( "fixedNode", 0 );
    self._id_79E4 = _id_A59B::_id_090D( "script_forcegoal", 0 );
    self._id_01C7 = _id_A59B::_id_090D( "goalradius", 100 );
    _id_3099();
    self._id_05CF = undefined;
}

_id_0DEB( var_0 )
{
    var_1 = level.player getcurrentweapon();
    var_2 = _func_2B4( var_1 );
    var_3 = var_2[0]["weapon"];
    var_4 = _id_0CFA( var_2, 0 );
    self attach( var_3, var_0, 1 );

    foreach ( var_6 in var_4 )
        self attach( var_6["attachment"], var_6["attachTag"] );

    self _meth_8509( var_1 );
}

_id_6C5C( var_0, var_1 )
{
    _playerallow( "altmelee", var_0, var_1, ::_id_054D, 0 );
}

_id_054D( var_0 )
{
    if ( var_0 )
        self _meth_84F2();
    else
        self _meth_84F1();
}

_id_6C62( var_0, var_1 )
{
    _playerallow( "weaponPickup", var_0, var_1, ::_id_054E, 0 );
}

_id_054E( var_0 )
{
    if ( var_0 )
        self enableweaponpickup();
    else
        self disableweaponpickup();
}

_playerallow( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( self.playerdisableabilitytypes ) )
        self.playerdisableabilitytypes = [];

    if ( !isdefined( self.playerdisableabilitytypes[var_0] ) )
        self.playerdisableabilitytypes[var_0] = [];

    if ( !isdefined( var_2 ) )
        var_2 = "default";

    if ( var_1 )
    {
        self.playerdisableabilitytypes[var_0] = common_scripts\utility::array_remove( self.playerdisableabilitytypes[var_0], var_2 );

        if ( !self.playerdisableabilitytypes[var_0].size )
        {
            if ( !isdefined( var_4 ) || var_4 )
                self call [[ var_3 ]]( 1 );
            else
                self [[ var_3 ]]( 1 );
        }
    }
    else
    {
        if ( !isdefined( common_scripts\utility::array_find( self.playerdisableabilitytypes[var_0], var_2 ) ) )
            self.playerdisableabilitytypes[var_0] = common_scripts\utility::array_add( self.playerdisableabilitytypes[var_0], var_2 );

        if ( !isdefined( var_4 ) || var_4 )
            self call [[ var_3 ]]( 0 );
        else
            self [[ var_3 ]]( 0 );
    }
}

_id_6F2E()
{
    if ( !isalive( self ) )
        return;

    self._id_6F2F = 1;
    self _meth_84ED( "disable" );
    self disableaimassist();
    self.ignoreme = 1;
    self._id_4BB8 = 1;
}

_id_92D0()
{
    precacheshader( "loading_animation" );
    common_scripts\utility::flag_init( "tff_sync_complete" );
    _id_A59B::_id_0674();
}

_id_92CE( var_0 )
{
    if ( isdefined( var_0 ) )
        wait(var_0);

    if ( _func_21C() )
    {
        common_scripts\utility::flag_clear( "tff_sync_complete" );
        _func_21B();

        while ( _func_21C() )
            wait 0.05;

        common_scripts\utility::flag_set( "tff_sync_complete" );
    }
}

_id_92CF( var_0, var_1 )
{
    _id_92CE( var_1 );
}

_id_581D()
{
    level.player endon( "death" );

    for (;;)
    {
        var_0 = _func_2B9();
        var_1 = var_0[4];
        var_2 = gettime();
        _func_2D2( level.player, var_1, var_2 );
        wait 2;
    }
}
