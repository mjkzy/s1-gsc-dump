// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setupplayerinventory( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( level.map_without_loadout ) || isdefined( level.map_without_loadout ) && level.map_without_loadout == 0 )
    {
        if ( maps\_utility::is_default_start() )
            return;
    }

    level.player _meth_8310();

    if ( isdefined( var_0 ) )
        level.player _meth_830E( var_0 );

    if ( isdefined( var_1 ) )
        level.player _meth_830E( var_1 );

    if ( isdefined( var_2 ) )
    {
        level.player _meth_8344( var_2 );
        level.player _meth_830E( var_2 );
    }

    if ( isdefined( var_3 ) )
    {
        level.player _meth_8319( var_3 );
        level.player _meth_830E( var_3 );
    }

    if ( isdefined( var_4 ) )
    {
        if ( var_4 == var_0 || var_4 == var_1 )
            level.player _meth_8315( var_4 );
        else
            level.player _meth_8315( var_0 );
    }
}

initializeallyarray()
{
    level.allies = [];
}

spawnandinitnamedally( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( level.allies ) )
        initializeallyarray();

    if ( !isdefined( level.allies[var_0] ) )
    {
        if ( isdefined( var_4 ) )
            var_5 = maps\_utility::spawn_targetname( var_4, 1 );
        else
            var_5 = maps\_utility::spawn_targetname( var_0, 1 );

        var_5.name = var_0;
        var_5.animname = var_0;
        var_5.script_friendname = var_0;
        var_5.script_parameters = var_0;

        if ( isdefined( var_2 ) )
        {
            if ( var_2 == 1 )
                var_5 thread maps\_utility::disable_surprise();
        }

        if ( isdefined( var_3 ) )
        {
            if ( var_3 == 1 )
                var_5 thread maps\_utility::deletable_magic_bullet_shield();
        }

        level.allies[var_0] = var_5;
    }

    if ( isdefined( var_1 ) )
    {
        var_6 = common_scripts\utility::getstruct( var_1, "targetname" );

        if ( isdefined( var_6 ) )
            level.allies[var_0] _meth_81C6( var_6.origin, var_6.angles );
    }
}

getnamedally( var_0 )
{
    var_1 = level.allies[var_0];
    return var_1;
}

updatenamedally( var_0, var_1 )
{
    level.allies[var_0] = var_1;
}

getdialogai( var_0, var_1 )
{
    var_2 = filteraiarray( var_0, var_1 );

    if ( var_2.size > 1 )
        return undefined;

    return var_2[0];
}

filteraiarray( var_0, var_1 )
{
    var_2 = _func_0D7( "all", "all" );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( !isalive( var_5 ) )
            continue;

        switch ( var_1 )
        {
            case "script_parameters":
                if ( isdefined( var_5.script_parameters ) && var_5.script_parameters == var_0 )
                    var_3[var_3.size] = var_5;

                break;
        }
    }

    return var_3;
}

allyredirectgotonode( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( level.allies[var_0].goalradius > 64 )
        level.allies[var_0].goalradius = 64;

    var_8 = getnode( var_1, "targetname" );
    level.allies[var_0] maps\_utility::enable_ai_color();
    level.allies[var_0] maps\_utility::set_goal_node( var_8 );

    if ( isdefined( var_3 ) )
        executefunction( var_2, var_3, var_4, var_5, var_6, var_7 );
}

spawnsquadfunc( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getentarray( var_0, "targetname" );
    maps\_utility::array_spawn_function( var_6, var_1, var_2, var_3, var_4, var_5 );
    maps\_utility::array_spawn( var_6, 1 );
}

flagmonitor( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    common_scripts\utility::flag_wait( var_0 );
    executefunction( var_1, var_2, var_3, var_4, var_5, var_6 );
}

executefunction( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 0;

    if ( isdefined( var_5 ) )
        var_6 = 4;
    else if ( isdefined( var_4 ) )
        var_6 = 3;
    else if ( isdefined( var_3 ) )
        var_6 = 2;
    else if ( isdefined( var_2 ) )
        var_6 = 1;

    if ( var_0 == 1 )
    {
        switch ( var_6 )
        {
            case 0:
                thread [[ var_1 ]]();
                break;
            case 1:
                thread [[ var_1 ]]( var_2 );
                break;
            case 2:
                thread [[ var_1 ]]( var_2, var_3 );
                break;
            case 3:
                thread [[ var_1 ]]( var_2, var_3, var_4 );
                break;
            case 4:
                thread [[ var_1 ]]( var_2, var_3, var_4, var_5 );
                break;
        }
    }
    else
    {
        switch ( var_6 )
        {
            case 0:
                [[ var_1 ]]();
                break;
            case 1:
                [[ var_1 ]]( var_2 );
                break;
            case 2:
                [[ var_1 ]]( var_2, var_3 );
                break;
            case 3:
                [[ var_1 ]]( var_2, var_3, var_4 );
                break;
            case 4:
                [[ var_1 ]]( var_2, var_3, var_4, var_5 );
                break;
        }
    }
}

objsetupdefault( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getent( var_0, "targetname" );

    if ( !isdefined( var_5 ) )
        var_5 = ( 0, 0, 0 );

    common_scripts\utility::flag_wait( var_2 );
    objective_add( maps\_utility::obj( var_0 ), "active", var_1, var_5.origin );
    objective_current( maps\_utility::obj( var_0 ) );

    if ( isdefined( var_4 ) )
        objective_setpointertextoverride( maps\_utility::obj( var_0 ), var_4 );

    common_scripts\utility::flag_wait( var_3 );
    maps\_utility::objective_complete( maps\_utility::obj( var_0 ) );
}

objsetupentity( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    common_scripts\utility::flag_wait( var_3 );
    objective_add( maps\_utility::obj( var_0 ), "active", var_2, ( 0, 0, 0 ) );

    if ( isdefined( var_1 ) )
        objective_onentity( maps\_utility::obj( var_0 ), var_1 );

    objective_current( maps\_utility::obj( var_0 ) );

    if ( isdefined( var_5 ) )
        objective_setpointertextoverride( maps\_utility::obj( var_0 ), var_5 );

    common_scripts\utility::flag_wait( var_4 );
    maps\_utility::objective_complete( maps\_utility::obj( var_0 ) );
}

aideleteonflag( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3 = common_scripts\utility::add_to_array( var_3, self );
    thread aiarraydeleteonflag( var_3, var_0, var_1, var_2 );
}

aiarraydeleteonflag( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 2048;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    common_scripts\utility::flag_wait( var_1 );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );

    if ( var_3 == 1 )
        maps\_utility::array_delete( var_0 );
    else
        thread maps\_utility::ai_delete_when_out_of_sight( var_0, var_2 );
}

aiarrayfallbackonflag( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 = maps\_utility::remove_dead_from_array( var_0 );

    for ( var_5 = 0; var_5 < var_0.size; var_5++ )
        var_0[var_5] thread aifallbackonflag( var_1, var_2, var_3, var_4 );
}

aifallbackonflag( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4 = getent( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 3.0;

    common_scripts\utility::flag_wait( var_0 );

    if ( var_2 == 0 )
        wait(randomfloat( var_3 ));

    self _meth_81AB();
    self _meth_81A9( var_4 );
}

printlnscreenandconsole( var_0 )
{
    if ( isdefined( level.showdebugtoggle ) && level.showdebugtoggle == 1 )
        iprintln( var_0 );
}

debugprint3dcontinuous( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( level.showdebugtoggle == 1 )
    {
        var_1 endon( "death" );

        if ( isdefined( var_5 ) && isdefined( var_6 ) )
            var_5 endon( var_6 );

        if ( !isdefined( var_4 ) )
            var_4 = 600000.0;

        if ( !isdefined( var_3 ) )
            var_3 = 3.0;

        if ( !isdefined( var_2 ) )
            var_2 = "green";

        var_7 = ( 0, 0, 0 );

        switch ( var_2 )
        {
            case "white":
                var_7 = ( 9, 9, 9 );
                break;
            case "black":
                var_7 = ( 0.5, 0.5, 0.5 );
                break;
            case "red":
                var_7 = ( 9, 0.5, 0.5 );
                break;
            case "green":
                var_7 = ( 0.5, 9, 0.5 );
                break;
            case "blue":
                var_7 = ( 0.5, 0.5, 9 );
                break;
            case "yellow":
                var_7 = ( 9, 9, 0.5 );
                break;
            case "purple":
                var_7 = ( 9, 0.5, 9 );
                break;
            case "cyan":
                var_7 = ( 0.5, 9, 9 );
                break;
        }

        for ( var_8 = 0; var_8 < var_4 * 20; var_8++ )
            wait 0.05;
    }
}

transformpointbyentity( var_0, var_1 )
{
    return transformpoint( var_0, var_1.origin, var_1.angles );
}

transformpoint( var_0, var_1, var_2 )
{
    var_3 = length( var_0 );
    var_4 = vectortoangles( var_0 );
    var_5 = combineangles( var_2, var_4 );
    var_6 = anglestoforward( var_5 );
    return var_1 + var_6 * var_3;
}

playdialog( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    common_scripts\utility::create_dvar( "display_placeholderdialog", 0 );

    if ( !isdefined( var_6 ) )
        var_6 = 0;

    if ( isdefined( var_3 ) )
    {
        if ( isdefined( var_4 ) )
            var_4 endon( var_3 );
        else
            level endon( var_3 );
    }

    if ( isdefined( var_4 ) && isalive( var_4 ) )
    {
        var_4 endon( "death" );
        var_4 endon( "dying" );
    }

    if ( !isdefined( var_2 ) )
        var_2 = var_1;

    var_8 = tablelookuprownum( var_0, 2, var_1 + "(Start)" );

    if ( var_8 == -1 )
        var_9 = 1;
    else
        var_9 = 0;

    if ( var_9 == 1 )
    {
        var_8 = tablelookuprownum( var_0, 2, var_1 );
        var_10 = var_8;
    }
    else
        var_10 = tablelookuprownum( var_0, 2, var_1 + "(End)" );

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    if ( var_5 == 1 )
    {
        var_11 = randomintrange( var_8, var_10 + 1 );
        _dialogtablelookup( var_0, var_11, var_3, var_4, var_6, var_7 );
    }
    else
    {
        for ( var_12 = var_8; var_12 <= var_10; var_12++ )
            _dialogtablelookup( var_0, var_12, var_3, var_4, var_6, var_7 );
    }

    level notify( var_2 );
}

_dialogtablelookup( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = tablelookupbyrow( var_0, var_1, 1 );
    var_7 = tablelookupbyrow( var_0, var_1, 4 );
    var_8 = tablelookupbyrow( var_0, var_1, 5 );

    if ( var_8 == "" )
        var_8 = 2;
    else
        var_8 = float( var_8 );

    var_9 = tablelookupbyrow( var_0, var_1, 6 );

    if ( var_9 == "" )
        var_9 = 2;

    var_9 = float( var_9 );
    var_10 = tablelookupbyrow( var_0, var_1, 7 );
    var_11 = tablelookupbyrow( var_0, var_1, 9 );
    var_12 = tablelookupbyrow( var_0, var_1, 8 );

    if ( var_8 == 1 )
        var_8 = "(whispering)";
    else if ( var_8 == 1.5 )
        var_8 = "(intense whispering)";
    else if ( var_8 == 2 )
        var_8 = "";
    else if ( var_8 == 2.5 )
        var_8 = "(loud voice)";
    else if ( var_8 == 3 )
        var_8 = "(shouting)";
    else if ( var_8 == 4 )
        var_8 = "(screaming)";

    if ( var_10 == "" )
        var_10 = "";
    else
        var_10 = "[" + var_10 + "]";

    var_7 = var_10 + var_8 + var_7;
    var_13 = tablelookupbyrow( var_0, var_1, 12 );

    if ( var_12 != "" )
    {
        var_12 = float( var_12 );
        wait(var_12);
    }

    var_14 = getdvarint( "display_placeholderdialog" );

    if ( var_14 == 1 )
        thread maps\_utility::add_dialogue_line( var_6, var_7 );

    if ( var_13 != "" && soundexists( var_13 ) )
    {
        if ( var_10 == "[Radio]" )
        {
            if ( isdefined( var_3 ) && isai( var_3 ) && isalive( var_3 ) )
                var_3 thread _clearradiodialogondeath();

            if ( isdefined( level.scr_radio[var_13] ) )
            {
                if ( var_4 == 1 )
                {
                    if ( isdefined( level.player_radio_emitter ) )
                        maps\_utility::radio_dialogue_overlap( var_13 );
                    else
                        maps\_utility::radio_dialogue( var_13 );
                }
                else
                    maps\_utility::radio_dialogue( var_13 );

                level notify( "RadioDialogFinished" );
            }
        }
        else if ( var_10 == "[World]" )
        {
            var_15 = getent( var_5, "targetname" );

            if ( isdefined( var_2 ) )
                var_15 thread _clearworlddialogonnotify( var_2 );

            if ( isdefined( level.scr_radio[var_13] ) )
                var_15 maps\_utility::play_sound_on_entity( var_13 );

            level notify( "WorldDialogFinished" );
        }
        else
        {
            var_16 = getdialogai( var_6, "script_parameters" );

            if ( isdefined( var_16 ) && isai( var_16 ) )
            {
                var_16 endon( "death" );

                if ( isdefined( var_2 ) )
                    var_16 thread _clearcharacterdialogonnotify( var_2 );

                if ( isdefined( level.scr_sound[var_6][var_13] ) )
                {
                    var_16 thread _clearcharacterdialogondeath();
                    var_16 maps\_utility::dialogue_queue( var_13 );
                }

                level notify( "CharacterDialogFinished" );
            }
        }
    }

    if ( var_13 == "" || !soundexists( var_13 ) )
        wait(var_9);

    if ( var_11 == "" )
        var_11 = "";
    else
        level notify( var_11 );
}

waittillbcsdone( var_0 )
{
    self endon( "death" );
    self endon( "dying" );

    if ( !isdefined( level.dds ) )
        return;

    if ( !isdefined( self.dds_characterid ) )
        return;

    if ( isdefined( self.dds_disable ) && self.dds_disable == 1 )
        return;

    for (;;)
    {
        waitframe();

        if ( maps\_dds::talker_is_talking_currently( self ) )
        {
            wait 0.5;
            continue;
        }
        else
        {
            maps\_utility::set_battlechatter( 0 );
            break;
        }
    }
}

makeavailableforbcs( var_0 )
{
    self endon( "death" );
    self endon( "dying" );

    if ( !isdefined( level.dds ) )
        return;

    if ( !isdefined( self.dds_characterid ) )
        return;

    if ( isdefined( self.dds_disable ) && self.dds_disable == 1 )
    {
        level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;
        return;
    }

    level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;
}

_clearradiodialogondeath()
{
    level endon( "RadioDialogFinished" );
    common_scripts\utility::waittill_either( "death", "pain_death" );
    maps\_utility::radio_dialogue_stop();
}

_clearcharacterdialogondeath()
{
    level endon( "CharacterDialogFinished" );
    common_scripts\utility::waittill_any( "death", "pain_death" );

    if ( isdefined( self ) )
        self _meth_80AC();
}

_clearcharacterdialogonnotify( var_0 )
{
    self endon( "death" );
    self endon( "pain_death" );
    level waittill( var_0 );
    self _meth_80AC();
}

_clearworlddialogonnotify( var_0 )
{
    level endon( "WorldDialogFinished" );
    level waittill( var_0 );
    var_1 = self _meth_8436( 0 );

    if ( !isdefined( var_1 ) )
        return;

    foreach ( var_3 in var_1 )
        var_3 _meth_80AC();
}

displayruleofthirds()
{
    level.player endon( "death" );
    precacheshader( "line_vertical" );
    common_scripts\utility::create_dvar( "ruleofthirds", "1" );
    var_0 = "line_vertical";
    var_1 = [];
    var_1[0] = _createhudline( 213, 0, 1, 480, var_0 );
    var_1[1] = _createhudline( 426, 0, 1, 480, var_0 );
    var_1[2] = _createhudline( 0, 160, 640, 1, var_0 );
    var_1[3] = _createhudline( 0, 320, 640, 1, var_0 );

    for (;;)
    {
        var_2 = getdvarint( "ruleofthirds" );

        if ( var_2 != 1 )
        {
            foreach ( var_4 in var_1 )
                var_4.alpha = 0;
        }
        else if ( var_2 == 1 )
        {
            foreach ( var_4 in var_1 )
                var_4.alpha = 1;
        }

        wait 0.05;
    }
}

_createhudline( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = newclienthudelem( level.player );
    var_7.x = var_0;
    var_7.y = var_1;
    var_7.sort = 1;
    var_7.horzalign = "fullscreen";
    var_7.vertalign = "fullscreen";
    var_7.alpha = 1;
    var_7 _meth_80CC( var_4, var_2, var_3 );
    return var_7;
}

cointossweighted( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 50;

    return randomint( 100 ) <= var_0;
}

_glass_physics_wakeup()
{
    var_0 = getentarray( "glass_phys_wakeup", "targetname" );
    var_1 = 36;

    if ( var_0.size > 0 )
    {
        foreach ( var_3 in var_0 )
        {
            if ( !isdefined( var_3.target ) )
            {

            }

            var_3.glass_id = getglass( var_3.target );

            if ( !isdefined( var_3.glass_id ) )
                continue;

            if ( !isdefined( var_3.origin ) )
                var_3.origin = ( 0, 0, 0 );

            var_3 thread _glass_physics_wakeup_update( var_1 );
        }
    }
}

_glass_physics_wakeup_update( var_0 )
{
    level waittillmatch( "glass_destroyed", self.glass_id );
    var_1 = var_0;

    if ( isdefined( self.radius ) )
        var_1 = self.radius;

    _func_244( self.origin, var_1 );

    if ( getdvarint( "debug_glass_phys_wake", 0 ) )
        iprintln( "Glass physics wakeup occurred for glass " + self.glass_id + " at (" + self.origin[0] + "," + self.origin[1] + "," + self.origin[2] + ")" + " with radius: " + var_1 );
}
