// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    var_0 = common_scripts\utility::getstructarray( "zombie_tube", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = getentarray( var_2.target, "targetname" );
        var_4 = common_scripts\utility::getstructarray( var_2.target, "targetname" );
        var_5 = common_scripts\utility::array_combine( var_3, var_4 );

        foreach ( var_7 in var_5 )
        {
            var_8 = var_7.script_noteworthy;

            if ( !isdefined( var_8 ) )
                continue;

            switch ( var_8 )
            {
                case "door_rotate":
                    var_2.door = var_7;
                    var_2.door linktargets();
                    var_2.door.closeangles = var_7.angles;
                    var_2.door.openangles = var_7.angles + ( 0, 180, 0 );
                    break;
                case "trigger":
                    var_2.trigger = var_7;
                    break;
                case "start":
                    var_2.start = var_7;
                    var_2.startend = common_scripts\utility::getstruct( var_2.start.target, "targetname" );
                    var_2.endstart = common_scripts\utility::getstruct( var_2.startend.target, "targetname" );
                    var_2.end = common_scripts\utility::getstruct( var_2.endstart.target, "targetname" );
                    break;
                default:
                    break;
            }
        }

        var_2 thread runtube();
    }
}

linktargets()
{
    if ( !isdefined( self.target ) )
        return;

    var_0 = getentarray( self.target, "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_804D( self );
}

runtube()
{
    var_0 = 0.3;
    var_1 = 200;

    if ( isdefined( self.script_flag_true ) )
        common_scripts\utility::flag_wait( self.script_flag_true );

    if ( isdefined( self.door ) )
    {
        var_2 = 0.5;
        self.door _meth_82B5( self.door.openangles, var_2 );
        wait(var_2);
    }

    for (;;)
    {
        self.trigger _meth_80DB( &"ZOMBIE_H2O_USE_TUBE" );
        self.trigger _meth_80DA( "HINT_NOICON" );
        self.trigger waittill( "trigger", var_3 );
        self.trigger _meth_80DB( "" );
        var_3 _meth_817D( "stand" );
        var_3.inteleport = 1;

        if ( isdefined( self.door ) )
            self.door _meth_82B5( self.door.closeangles, var_0 );

        var_4 = spawn( "script_model", var_3.origin );
        var_4.angles = ( 0, var_3.angles[1], 0 );
        var_4 _meth_80B1( "tag_origin" );
        var_3 _meth_807C( var_4, "tag_origin", var_0 );
        thread maps\mp\mp_zombie_h2o_aud::sndtubestart( var_4, var_3 );
        var_4 _meth_82AE( self.start.origin, var_0 );
        wait(var_0);
        var_5 = distance( var_4.origin, self.startend.origin ) / var_1;
        var_4 _meth_82AE( self.startend.origin, var_5, var_5, 0 );
        var_6 = anglesdelta( var_4.angles, self.startend.angles );

        if ( var_6 > 0 )
            var_4 _meth_82B5( self.startend.angles, var_5 );

        var_3 thread playertubevo();
        wait(var_5);

        if ( isdefined( self.door ) )
            self.door _meth_82B5( self.door.openangles, var_0 );

        thread endtube( var_4, var_3, var_1 );
    }
}

endtube( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
        var_1 _meth_8092();

    var_0 _meth_8092();
    var_0.origin = self.endstart.origin;
    var_0.angles = self.endstart.angles;
    var_3 = distance( var_0.origin, self.end.origin ) / var_2;
    var_0 _meth_82AE( self.end.origin, var_3, var_3, 0 );
    thread maps\mp\mp_zombie_h2o_aud::sndtubeend( self.end.origin, var_1 );
    var_4 = anglesdelta( var_0.angles, self.end.angles );

    if ( var_4 > 0 )
        var_0 _meth_82B5( self.end.angles, var_3 );

    wait(var_3);

    if ( isdefined( var_1 ) )
    {
        var_1 _meth_804F();
        var_1.inteleport = 0;
    }

    var_0 delete();
}

playertubevo()
{
    thread maps\mp\zombies\_zombies_audio::create_and_play_dialog_delay( "monologue", "tube", undefined, undefined, undefined, 0.5 );
}
