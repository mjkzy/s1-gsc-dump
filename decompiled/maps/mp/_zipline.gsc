// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    var_0 = [];
    var_1 = getentarray( "zipline", "targetname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = maps\mp\gametypes\_gameobjects::createuseobject( "neutral", var_1[var_2], var_0, ( 0.0, 0.0, 0.0 ) );
        var_3 maps\mp\gametypes\_gameobjects::allowuse( "any" );
        var_3 maps\mp\gametypes\_gameobjects::setusetime( 0.25 );
        var_3 maps\mp\gametypes\_gameobjects::setusetext( &"MP_ZIPLINE_USE" );
        var_3 maps\mp\gametypes\_gameobjects::setusehinttext( &"MP_ZIPLINE_USE" );
        var_3 maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
        var_3.onbeginuse = ::onbeginuse;
        var_3.onuse = ::onuse;
        var_4 = [];
        var_5 = getent( var_1[var_2].target, "targetname" );

        if ( !isdefined( var_5 ) )
        {

        }

        while ( isdefined( var_5 ) )
        {
            var_4[var_4.size] = var_5;

            if ( isdefined( var_5.target ) )
            {
                var_5 = getent( var_5.target, "targetname" );
                continue;
            }

            break;
        }

        var_3._id_91D2 = var_4;
    }

    precachemodel( "tag_player" );
    _id_4CE3();
}

onbeginuse( var_0 )
{
    var_0 playsound( "scrambler_pullout_lift_plr" );
}

onuse( var_0 )
{
    var_0 thread _id_A3B6( self );
}

_id_A3B6( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "zipline_drop" );
    level endon( "game_ended" );
    var_1 = spawn( "script_origin", var_0.trigger.origin );
    var_1.origin = var_0.trigger.origin;
    var_1.angles = self.angles;
    var_1 setmodel( "tag_player" );
    self _meth_807D( var_1, "tag_player", 1, 180, 180, 180, 180 );
    thread _id_A206( var_1 );
    thread _id_A20A( var_1 );
    var_2 = var_0._id_91D2;

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = distance( var_1.origin, var_2[var_3].origin ) / 600;
        var_5 = 0.0;

        if ( var_3 == 0 )
            var_5 = var_4 * 0.2;

        var_1 moveto( var_2[var_3].origin, var_4, var_5 );

        if ( var_1.angles != var_2[var_3].angles )
            var_1 _meth_82B5( var_2[var_3].angles, var_4 * 0.8 );

        wait(var_4);
    }

    self notify( "destination" );
    self unlink();
    var_1 delete();
}

_id_A20A( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "destination" );
    level endon( "game_ended" );
    self notifyonplayercommand( "zipline_drop", "+gostand" );
    self waittill( "zipline_drop" );
    self unlink();
    var_0 delete();
}

_id_A206( var_0 )
{
    self endon( "disconnect" );
    self endon( "destination" );
    self endon( "zipline_drop" );
    level endon( "game_ended" );
    self waittill( "death" );
    self unlink();
    var_0 delete();
}

_id_4CE3()
{
    var_0 = [];
    var_1 = getentarray( "elevator_button", "targetname" );
    level._id_3028 = spawnstruct();
    level._id_3028.location = "floor1";
    level._id_3028._id_8D61 = [];
    level._id_3028._id_8D61["elevator"] = "closed";
    level._id_3028._id_28BD = [];

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = maps\mp\gametypes\_gameobjects::createuseobject( "neutral", var_1[var_2], var_0, ( 0.0, 0.0, 0.0 ) );
        var_3 maps\mp\gametypes\_gameobjects::allowuse( "any" );
        var_3 maps\mp\gametypes\_gameobjects::setusetime( 0.25 );
        var_3 maps\mp\gametypes\_gameobjects::setusetext( &"MP_ZIPLINE_USE" );
        var_3 maps\mp\gametypes\_gameobjects::setusehinttext( &"MP_ZIPLINE_USE" );
        var_3 maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
        var_3.onbeginuse = ::_id_6452;
        var_3.onuse = ::_id_64F6;
        var_3.location = var_1[var_2].script_label;
        level._id_3028._id_8D61[var_1[var_2].script_label] = "closed";

        if ( isdefined( var_1[var_2].target ) )
        {
            var_4 = common_scripts\utility::getstruct( var_1[var_2].target, "targetname" );

            if ( isdefined( var_4 ) )
                level._id_3028._id_28BD[var_1[var_2].script_label] = var_4;
        }
    }
}

_id_6452( var_0 )
{

}

_id_64F6( var_0 )
{
    switch ( self.location )
    {
        case "floor1":
            if ( level._id_3028._id_8D61["floor1"] == "closed" )
            {
                if ( level._id_3028.location == "floor1" )
                {
                    if ( level._id_3028._id_8D61["elevator"] == "closed" )
                    {
                        level thread _id_6500( "floor1" );
                        level thread _id_6500( "elevator" );
                    }
                }
                else if ( level._id_3028.location == "floor2" )
                {
                    if ( level._id_3028._id_8D61["elevator"] == "opened" )
                    {
                        level notify( "stop_autoClose" );
                        level thread _id_1FCB( "floor2" );
                        level _id_1FCB( "elevator" );
                    }

                    if ( level._id_3028._id_8D61["elevator"] == "closed" )
                    {
                        level _id_5EFB();
                        level thread _id_6500( "floor1" );
                        level thread _id_6500( "elevator" );
                    }
                }
            }

            break;
        case "floor2":
            if ( level._id_3028._id_8D61["floor2"] == "closed" )
            {
                if ( level._id_3028.location == "floor2" )
                {
                    if ( level._id_3028._id_8D61["elevator"] == "closed" )
                    {
                        level thread _id_6500( "floor2" );
                        level thread _id_6500( "elevator" );
                    }
                }
                else if ( level._id_3028.location == "floor1" )
                {
                    if ( level._id_3028._id_8D61["elevator"] == "opened" )
                    {
                        level notify( "stop_autoClose" );
                        level thread _id_1FCB( "floor1" );
                        level _id_1FCB( "elevator" );
                    }

                    if ( level._id_3028._id_8D61["elevator"] == "closed" )
                    {
                        level _id_5EFB();
                        level thread _id_6500( "floor2" );
                        level thread _id_6500( "elevator" );
                    }
                }
            }

            break;
        case "elevator":
            if ( level._id_3028._id_8D61["elevator"] == "opened" )
            {
                level notify( "stop_autoClose" );
                level thread _id_1FCB( level._id_3028.location );
                level _id_1FCB( "elevator" );
            }

            if ( level._id_3028._id_8D61["elevator"] == "closed" )
            {
                level _id_5EFB();
                level thread _id_6500( level._id_3028.location );
                level thread _id_6500( "elevator" );
            }

            break;
    }
}

_id_6500( var_0 )
{
    level._id_3028._id_8D61[var_0] = "opening";
    var_1 = getent( "e_door_" + var_0 + "_left", "targetname" );
    var_2 = getent( "e_door_" + var_0 + "_right", "targetname" );

    if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "fahrenheit" )
    {
        var_1 moveto( var_1.origin - anglestoforward( var_1.angles ) * 35, 2 );
        var_2 moveto( var_2.origin + anglestoforward( var_2.angles ) * 35, 2 );
        var_1 playsound( "elev_door_open" );
    }
    else
    {
        var_1 moveto( var_1.origin - anglestoright( var_1.angles ) * 35, 2 );
        var_2 moveto( var_2.origin + anglestoright( var_2.angles ) * 35, 2 );
    }

    wait 2;
    level._id_3028._id_8D61[var_0] = "opened";

    if ( var_0 == "elevator" )
        level thread _id_112B();
}

_id_1FCB( var_0 )
{
    level._id_3028._id_8D61[var_0] = "closing";
    var_1 = getent( "e_door_" + var_0 + "_left", "targetname" );
    var_2 = getent( "e_door_" + var_0 + "_right", "targetname" );

    if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "fahrenheit" )
    {
        var_1 moveto( var_1.origin + anglestoforward( var_1.angles ) * 35, 2 );
        var_2 moveto( var_2.origin - anglestoforward( var_2.angles ) * 35, 2 );
        var_1 playsound( "elev_door_close" );
    }
    else
    {
        var_1 moveto( var_1.origin + anglestoright( var_1.angles ) * 35, 2 );
        var_2 moveto( var_2.origin - anglestoright( var_2.angles ) * 35, 2 );
    }

    wait 2;
    level._id_3028._id_8D61[var_0] = "closed";
}

_id_112B()
{
    level endon( "stop_autoClose" );
    wait 10;
    level thread _id_1FCB( level._id_3028.location );
    level thread _id_1FCB( "elevator" );
}

_id_5EFB()
{
    level._id_3028._id_8D61["elevator"] = "moving";
    var_0 = getent( "e_door_elevator_left", "targetname" );
    var_1 = getent( "e_door_elevator_right", "targetname" );
    var_2 = getent( "elevator", "targetname" );

    if ( level._id_3028.location == "floor1" )
    {
        level._id_3028.location = "floor2";
        var_3 = var_0.origin[2] - level._id_3028._id_28BD["floor1"].origin[2];
        var_0 moveto( ( var_0.origin[0], var_0.origin[1], level._id_3028._id_28BD["floor2"].origin[2] + var_3 ), 5 );
        var_3 = var_1.origin[2] - level._id_3028._id_28BD["floor1"].origin[2];
        var_1 moveto( ( var_1.origin[0], var_1.origin[1], level._id_3028._id_28BD["floor2"].origin[2] + var_3 ), 5 );
        var_2 moveto( level._id_3028._id_28BD["floor2"].origin, 5 );
    }
    else
    {
        level._id_3028.location = "floor1";
        var_3 = var_0.origin[2] - level._id_3028._id_28BD["floor2"].origin[2];
        var_0 moveto( ( var_0.origin[0], var_0.origin[1], level._id_3028._id_28BD["floor1"].origin[2] + var_3 ), 5 );
        var_3 = var_1.origin[2] - level._id_3028._id_28BD["floor2"].origin[2];
        var_1 moveto( ( var_1.origin[0], var_1.origin[1], level._id_3028._id_28BD["floor1"].origin[2] + var_3 ), 5 );
        var_2 moveto( level._id_3028._id_28BD["floor1"].origin, 5 );
    }

    wait 5;
    var_2 playsound( "elev_bell_ding" );
    level._id_3028._id_8D61["elevator"] = "closed";
}
