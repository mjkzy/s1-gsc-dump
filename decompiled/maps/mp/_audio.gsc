// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4CB3()
{
    if ( !isdefined( level._id_10F0 ) )
        level._id_10F0 = spawnstruct();

    _id_4D35();
    _id_4D75();
    level.onplayerconnectaudioinit = ::onplayerconnectaudioinit;
}

onplayerconnectaudioinit()
{
    _id_0CA7( "default" );
}

_id_4D35()
{
    _id_078C( "default", "generic", 0.15, 0.9, 2 );
}

_id_078C( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    _id_5075( var_1 );
    var_5["roomtype"] = var_1;
    var_5["wetlevel"] = var_2;
    var_5["drylevel"] = var_3;
    var_5["fadetime"] = var_4;
    level._id_10F0._id_74EE[var_0] = var_5;
}

_id_5075( var_0 )
{

}

_id_0CA7( var_0 )
{
    if ( !isdefined( level._id_10F0._id_74EE[var_0] ) )
        var_1 = level._id_10F0._id_74EE["default"];
    else
        var_1 = level._id_10F0._id_74EE[var_0];

    self _meth_832E( "snd_enveffectsprio_level", var_1["roomtype"], var_1["drylevel"], var_1["wetlevel"], var_1["fadetime"] );
}

_id_4D75()
{
    level._id_10F0._id_A30C = [];
    _id_7F04( 15.0, 30.0, 50.0 );
    _id_7F05( 150.0, 250.0, 350.0 );
}

_id_7F04( var_0, var_1, var_2 )
{
    level._id_10F0._id_A30C["radius"] = [ var_0, var_1, var_2 ];
}

_id_7F05( var_0, var_1, var_2 )
{
    level._id_10F0._id_A30C["spread"] = [ var_0, var_1, var_2 ];
}

_id_0CA9()
{
    var_0 = level._id_10F0._id_A30C;
    var_1 = var_0["spread"];
    var_2 = var_0["radius"];
    self _meth_832C( var_1[0], var_1[1], var_1[2] );
    self _meth_832D( var_2[0], var_2[1], var_2[2] );
}

snd_play_team_splash( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "null";

    if ( !isdefined( var_1 ) )
        var_1 = "null";

    if ( level.teambased )
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3 ) && issentient( var_3 ) && issentient( self ) && var_3.team != self.team )
            {
                if ( soundexists( var_1 ) )
                    var_3 playlocalsound( var_1 );

                continue;
            }

            if ( isdefined( var_3 ) && issentient( var_3 ) && issentient( self ) && var_3.team == self.team )
            {
                if ( soundexists( var_0 ) )
                    var_3 playlocalsound( var_0 );
            }
        }
    }
}

_id_873E( var_0, var_1, var_2, var_3 )
{

}

_id_873D( var_0, var_1, var_2 )
{
    self endon( "stop_sequencing_notetracks" );
    self endon( "death" );
    _id_87B1( var_0, var_1, var_2 );
}

_id_87B1( var_0, var_1, var_2 )
{
    for (;;)
    {
        self waittill( var_1, var_3 );

        if ( isdefined( var_3 ) && var_3 != "end" )
        {
            if ( isarray( var_0 ) )
            {
                var_4 = var_0[var_3];

                if ( isdefined( var_4 ) )
                    self playsound( var_4 );

                continue;
            }

            if ( var_1 == var_3 )
                self playsound( var_0 );
        }
    }
}

_id_7B3D( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_4 ) )
        level endon( var_4 );

    var_0 scriptmodelplayanimdeltamotion( var_1, var_2 );
    thread _id_7B3E( var_0, var_2, var_3, var_4, var_5, var_6 );
}

_id_7B3E( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_3 ) )
        level endon( var_3 );

    if ( isdefined( var_4 ) )
        var_0 endon( var_4 );

    if ( isdefined( var_5 ) )
        var_0 endon( var_5 );

    var_0 endon( "death" );

    for (;;)
    {
        var_0 waittill( var_1, var_6 );

        if ( isdefined( var_6 ) && var_6 == var_1 )
            var_0 playsound( var_2 );
    }
}

scriptmodelplayanimwithnotify_uniquename( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( var_5 ) )
        level endon( var_5 );

    var_0 scriptmodelplayanimdeltamotion( var_1, var_2 );
    thread scriptmodelplayanimwithnotify_notetracks_uniquename( var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

scriptmodelplayanimwithnotify_notetracks_uniquename( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_4 ) )
        level endon( var_4 );

    if ( isdefined( var_5 ) )
        var_0 endon( var_5 );

    if ( isdefined( var_6 ) )
        var_0 endon( var_6 );

    var_0 endon( "death" );

    if ( isarray( var_2 ) )
    {
        var_7 = var_2.size;

        for (;;)
        {
            var_0 waittill( var_1, var_8 );

            if ( isdefined( var_8 ) )
            {
                for ( var_9 = 0; var_9 < var_7; var_9++ )
                {
                    if ( var_8 == var_2[var_9] )
                        var_0 playsound( var_3[var_9] );
                }
            }
        }
    }
    else
    {
        for (;;)
        {
            var_0 waittill( var_1, var_8 );

            if ( isdefined( var_8 ) && var_8 == var_2 )
                var_0 playsound( var_3 );
        }
    }
}

_id_8778( var_0, var_1, var_2 )
{
    var_3 = self;
    var_4 = [ var_0, var_1, var_2 ];
    var_5[0] = spawn( "script_origin", var_3.origin );
    var_5[0] linktosynchronizedparent( var_3 );
    var_5[0] playloopsound( var_0 );
    var_5[1] = spawn( "script_origin", var_3.origin );
    var_5[1] linktosynchronizedparent( var_3 );
    var_5[1] playloopsound( var_1 );
    var_5[2] = spawn( "script_origin", var_3.origin );
    var_5[2] linktosynchronizedparent( var_3 );
    var_5[2] playloopsound( var_2 );
    var_3 waittill( "death" );

    foreach ( var_7 in var_5 )
    {
        if ( isdefined( var_7 ) )
        {
            wait 0.06;
            var_7 delete();
        }
    }
}

_id_2898( var_0, var_1 )
{
    var_2 = 0.0;
    var_3 = var_1.size;
    var_4 = var_1[0];

    for ( var_5 = 1; var_5 < var_1.size; var_5++ )
    {
        var_6 = var_1[var_5];

        if ( var_0 >= var_4[0] && var_0 <= var_6[0] )
        {
            var_7 = var_4[0];
            var_8 = var_6[0];
            var_9 = var_4[1];
            var_10 = var_6[1];
            var_11 = ( var_0 - var_7 ) / ( var_8 - var_7 );
            var_2 = var_9 + var_11 * ( var_10 - var_9 );
            break;
        }
        else
            var_4 = var_6;
    }

    return var_2;
}

_id_873B( var_0, var_1, var_2, var_3 )
{
    var_4 = 0.2;

    if ( isdefined( var_3 ) )
        var_4 = var_3;

    var_5 = spawn( "script_origin", var_1 );
    var_5 playloopsound( var_0 );
    thread _id_87B0( var_5, var_2, var_4 );
    return var_5;
}

_id_87B0( var_0, var_1, var_2 )
{
    level waittill( var_1 );

    if ( isdefined( var_0 ) )
    {
        var_0 scalevolume( 0, var_2 );
        wait(var_2 + 0.05);
        var_0 delete();
    }
}

_id_874A( var_0 )
{
    level._id_936F = 0;

    if ( !isdefined( var_0 ) )
        var_0 = 0.1;

    for (;;)
    {
        iprintln( level._id_936F );
        wait(var_0);
        level._id_936F += var_0;
    }
}

_id_8730( var_0, var_1, var_2, var_3 )
{
    var_4 = 9;
    var_5 = 0.75;
    var_6 = spawn( "script_origin", var_1 );
    var_6 playsound( var_0 );
    var_6 thread _id_87AD( var_4, var_5 );
    return var_6;
}

_id_87AD( var_0, var_1 )
{
    var_2 = 9;
    var_3 = 0.05;
    var_4 = self;

    if ( isdefined( var_0 ) )
        var_2 = var_0;

    if ( isdefined( var_1 ) )
        var_3 = var_1;

    wait(var_2);

    if ( isdefined( var_4 ) )
    {
        var_4 scalevolume( 0, var_3 );
        wait(var_3 + 0.05);

        if ( isdefined( var_4 ) )
            var_4 delete();
    }
}

_id_8731( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 9;
    var_6 = 0.75;
    var_7 = spawn( "script_origin", var_1 );
    var_7 thread _id_87AC( var_0, var_2, var_3, var_4 );
    return var_7;
}

_id_87AC( var_0, var_1, var_2, var_3 )
{
    wait(var_1);
    var_4 = 9;
    var_5 = 0.05;
    var_6 = self;
    var_6 playsound( var_0 );

    if ( isdefined( var_2 ) )
        var_4 = var_2;

    if ( isdefined( var_3 ) )
        var_5 = var_3;

    wait(var_4);

    if ( isdefined( var_6 ) )
    {
        var_6 scalevolume( 0, var_5 );
        wait(var_5 + 0.05);

        if ( isdefined( var_6 ) )
            var_6 delete();
    }
}

snd_play_linked( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_origin", var_1.origin );
    var_4 linkto( var_1 );
    var_4 thread _id_87AE( var_0, var_1, var_2, var_3 );
    return var_4;
}

_id_87AE( var_0, var_1, var_2, var_3 )
{
    var_4 = 9;
    var_5 = 0.05;
    var_6 = self;
    var_6 playsound( var_0 );

    if ( isdefined( var_2 ) )
        var_4 = var_2;

    if ( isdefined( var_3 ) )
        var_5 = var_3;

    wait(var_4);

    if ( isdefined( var_6 ) )
    {
        var_6 scalevolume( 0, var_5 );
        wait(var_5 + 0.05);
        var_6 delete();
    }
}

snd_play_linked_loop( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", var_1.origin );
    var_3 linkto( var_1 );
    var_3 thread _id_87AF( var_0, var_1, var_2 );
    return var_3;
}

_id_87AF( var_0, var_1, var_2 )
{
    var_3 = 0.05;
    var_4 = self;
    var_4 playloopsound( var_0 );

    if ( isdefined( var_2 ) )
        var_3 = var_2;

    var_1 waittill( "death" );

    if ( isdefined( var_4 ) )
    {
        var_4 scalevolume( 0, var_3 );
        wait(var_3 + 0.05);
        var_4 delete();
    }
}

_id_1029( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( self ) )
    {
        var_5 = ( 1.0, 1.0, 1.0 );
        var_6 = ( 1.0, 0.0, 0.0 );
        var_7 = ( 0.0, 1.0, 0.0 );
        var_8 = ( 0.0, 1.0, 1.0 );
        var_9 = 5;
        var_10 = var_5;

        if ( isdefined( var_1 ) )
            var_9 = var_1;

        if ( isdefined( var_2 ) )
        {
            var_10 = var_2;

            switch ( var_10 )
            {
                case "red":
                    var_10 = var_6;
                    break;
                case "white":
                    var_10 = var_5;
                    break;
                case "blue":
                    var_10 = var_8;
                    break;
                case "green":
                    var_10 = var_7;
                    break;
                default:
                    var_10 = var_5;
            }
        }

        if ( isdefined( var_4 ) )
            thread _id_1117( var_4 );

        self endon( "death" );
        self endon( "aud_stop_3D_print" );

        while ( isdefined( self ) )
        {
            var_11 = var_0;

            if ( isdefined( var_3 ) )
                var_11 += self [[ var_3 ]]();

            wait 0.05;
        }
    }
}

_id_1117( var_0 )
{
    self endon( "death" );
    wait(var_0);

    if ( isdefined( self ) )
        self notify( "aud_stop_3D_print" );
}

_id_8779()
{

}
