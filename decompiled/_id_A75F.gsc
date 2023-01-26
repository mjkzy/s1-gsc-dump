// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._effect["water_wake"] = loadfx( "vfx/treadfx/body_wake_water" );
    level._effect["water_wake_stationary"] = loadfx( "vfx/treadfx/body_wake_water_stationary" );
    level._effect["water_splash_emerge"] = loadfx( "vfx/water/body_splash_exit" );
    level._effect["water_splash_enter"] = loadfx( "vfx/water/body_splash" );
    precacheshellshock( "underwater" );

    if ( !isdefined( level._id_A291 ) )
        level._id_A291 = [];

    if ( !isdefined( level._id_A292 ) )
        level._id_A292 = 0;

    if ( !isdefined( level.shallow_water_weapon ) )
        _id_8000( "iw5_combatknife_mp" );

    if ( !isdefined( level.deep_water_weapon ) )
        _id_7F3F( "iw5_underwater_mp" );

    if ( !isdefined( level._id_0A9D ) )
        level._id_0A9D = 1;

    if ( level.deep_water_weapon == level.shallow_water_weapon )
        level._id_0A9D = 0;

    if ( !isdefined( level._id_906E ) )
        level._id_906E = 48;

    var_0 = getentarray( "trigger_underwater", "targetname" );
    level._id_A284 = var_0;

    foreach ( var_2 in var_0 )
    {
        var_2 _id_23A5();
        var_2 thread _id_A245();
        level thread _id_1F0E( var_2 );
    }

    level thread _id_64CA();
}

_id_6C02( var_0 )
{
    if ( var_0 )
    {
        self._id_4FAA = 1;

        if ( maps\mp\_utility::isaigameparticipant( self ) )
            self _meth_8351( "in_water", 1 );
    }
    else
    {
        self._id_4FAA = undefined;

        if ( maps\mp\_utility::isaigameparticipant( self ) )
            self _meth_8351( "in_water", 0 );
    }
}

watchforhostmigration()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "player_migrated" );

        foreach ( var_1 in level._id_A291 )
            self _meth_84EA( var_1.script_noteworthy, var_1 );
    }
}

_id_64CA()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread watchforhostmigration();

        foreach ( var_2 in level._id_A291 )
            var_0 _meth_84EA( var_2.script_noteworthy, var_2 );
    }
}

_id_23A5()
{
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_0.origin += ( 0, 0, level._id_A292 );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_1 show();

    if ( isdefined( self.script_noteworthy ) )
    {
        var_1.script_noteworthy = self.script_noteworthy;
        level._id_A291 = common_scripts\utility::array_add( level._id_A291, var_1 );
    }
}

_id_1F0E( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned", var_1 );

        if ( !var_1 istouching( var_0 ) )
        {
            var_1 _id_6C02( 0 );
            var_1.underwater = undefined;
            var_1._id_4EBF = undefined;
            var_1._id_51C1 = undefined;
            var_1._id_51FE = undefined;
            var_1.water_last_weapon = undefined;
            var_1._id_519C = undefined;
            var_1 notify( "out_of_water" );
        }
    }
}

_id_A245()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isdefined( level.ishorde ) && level.ishorde && isagent( var_0 ) && isdefined( var_0._id_4949 ) && var_0._id_4949 == "Quad" && !isdefined( var_0._id_4FAA ) )
            var_0 thread _id_4979( self );

        if ( !isplayer( var_0 ) && !isai( var_0 ) )
            continue;

        if ( !isalive( var_0 ) )
            continue;

        if ( !isdefined( var_0._id_4FAA ) )
        {
            var_0 _id_6C02( 1 );
            var_0 thread _id_6CCE( self );
        }
    }
}

_id_4979( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    _id_6C02( 1 );

    for (;;)
    {
        if ( !_id_4E82( var_0, 40 ) )
        {
            wait 2.5;

            if ( !_id_4E82( var_0, 20 ) )
                self dodamage( self.health, self.origin );
        }

        waitframe();
    }
}

_id_6CCE( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    thread _id_4FAB( var_0 );
    thread _id_6D8F();
    self._id_35B1 = 0;
    self._id_35B0 = 0;

    for (;;)
    {
        if ( maps\mp\_utility::isusingremote() )
        {
            if ( isdefined( self.underwater ) && isdefined( self._id_519C ) )
            {
                self stopshellshock();
                self._id_519C = undefined;
            }
        }
        else if ( isdefined( self.underwater ) && !isdefined( self._id_519C ) )
        {
            self shellshock( "underwater", 19 );
            self._id_519C = 1;
        }

        if ( !self istouching( var_0 ) )
        {
            _id_6C02( 0 );
            self.underwater = undefined;
            self._id_4EBF = undefined;
            self._id_51C1 = undefined;
            self.movespeedscaler = level.baseplayermovescale;
            maps\mp\gametypes\_weapons::updatemovespeedscale();
            self notify( "out_of_water" );
            break;
        }

        if ( isdefined( self._id_4EBF ) && _id_4E82( var_0, 32 ) )
        {
            self._id_4EBF = undefined;
            self.movespeedscaler = level.baseplayermovescale;
            maps\mp\gametypes\_weapons::updatemovespeedscale();
        }

        if ( !isdefined( self._id_4EBF ) && !_id_4E82( var_0, 32 ) )
        {
            self._id_4EBF = 1;
            self.movespeedscaler = 0.7 * level.baseplayermovescale;
            maps\mp\gametypes\_weapons::updatemovespeedscale();
        }

        if ( !isdefined( self.underwater ) && !_id_50A2( var_0, 0 ) )
        {
            self.underwater = 1;
            thread _id_6CB6();

            if ( maps\mp\_utility::isaugmentedgamemode() )
                _id_2B0E();

            if ( !maps\mp\_utility::isusingremote() )
            {
                self shellshock( "underwater", 19 );
                self._id_519C = 1;
            }

            var_1 = self getcurrentweapon();

            if ( var_1 != "none" )
            {
                var_2 = objective_current( var_1 );

                if ( var_2 == "primary" || var_2 == "altmode" )
                    self.water_last_weapon = var_1;
            }

            if ( isdefined( level.gamemodeonunderwater ) )
                self [[ level.gamemodeonunderwater ]]( var_0 );

            maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
        }

        if ( isdefined( self.underwater ) && ( isdefined( self._id_51C1 ) || !isdefined( self._id_51FE ) ) && ( _id_4E82( var_0, level._id_906E ) || self getstance() == "prone" || !level._id_0A9D ) )
        {
            self._id_51FE = 1;
            self._id_51C1 = undefined;
            _id_6C8A();

            if ( isdefined( self.isjuggernaut ) && self.isjuggernaut == 1 )
            {
                _id_6C97( "none" );
                self _meth_8131( 0 );
                self _meth_84BF();
            }
            else
                _id_6C97( "shallow" );
        }

        if ( isdefined( self.underwater ) && ( isdefined( self._id_51FE ) || !isdefined( self._id_51C1 ) ) && ( !_id_4E82( var_0, level._id_906E ) && self getstance() != "prone" && level._id_0A9D ) )
        {
            self._id_51C1 = 1;
            self._id_51FE = undefined;
            _id_6C8A();

            if ( isdefined( self.isjuggernaut ) && self.isjuggernaut == 1 )
            {
                _id_6C97( "none" );
                self _meth_8131( 0 );
                self _meth_84BF();
            }
            else
                _id_6C97( "deep" );
        }

        if ( isdefined( self.underwater ) && _id_50A2( var_0, 0 ) )
        {
            self.underwater = undefined;
            self._id_51C1 = undefined;
            self._id_51FE = undefined;
            self notify( "above_water" );
            var_3 = distance( self getvelocity(), ( 0.0, 0.0, 0.0 ) );
            var_4 = ( self.origin[0], self.origin[1], _id_415C( var_0 ) );
            playfx( level._effect["water_splash_emerge"], var_4, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270.0, 180.0, 0.0 ) ) );

            if ( !maps\mp\_utility::isusingremote() )
            {
                self stopshellshock();
                self._id_519C = undefined;
            }

            _id_6C8A();

            if ( maps\mp\_utility::isaugmentedgamemode() )
                _id_310D();

            maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
        }

        wait 0.05;
    }
}

_id_50A4( var_0 )
{
    if ( isdefined( var_0.killstreakindexweapon ) )
    {
        var_1 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;

        if ( isdefined( var_1 ) )
        {
            if ( common_scripts\utility::string_find( var_1, "turret" ) > 0 || common_scripts\utility::string_find( var_1, "sentry" ) > 0 )
                return 1;
        }
    }

    return 0;
}

_id_6D8F()
{
    var_0 = common_scripts\utility::waittill_any_return( "death", "out_of_water" );
    self.underwatermotiontype = undefined;
    self._id_2D20 = undefined;
    _id_6C02( 0 );
    self.underwater = undefined;
    self._id_4EBF = undefined;
    self.water_last_weapon = undefined;
    self.movespeedscaler = level.baseplayermovescale;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

_id_4FAB( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "out_of_water" );
    var_1 = distance( self getvelocity(), ( 0.0, 0.0, 0.0 ) );

    if ( var_1 > 90 )
    {
        var_2 = ( self.origin[0], self.origin[1], _id_415C( var_0 ) );
        playfx( level._effect["water_splash_enter"], var_2, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270.0, 180.0, 0.0 ) ) );
    }

    for (;;)
    {
        var_3 = self getvelocity();
        var_1 = distance( var_3, ( 0.0, 0.0, 0.0 ) );

        if ( var_1 > 0 )
            wait(max( 1 - var_1 / 120, 0.1 ));
        else
            wait 0.3;

        if ( var_1 > 5 )
        {
            var_4 = vectornormalize( ( var_3[0], var_3[1], 0 ) );
            var_5 = anglestoforward( vectortoangles( var_4 ) + ( 270.0, 180.0, 0.0 ) );
            var_2 = ( self.origin[0], self.origin[1], _id_415C( var_0 ) ) + var_1 / 4 * var_4;
            playfx( level._effect["water_wake"], var_2, var_5 );
            continue;
        }

        var_2 = ( self.origin[0], self.origin[1], _id_415C( var_0 ) );
        playfx( level._effect["water_wake_stationary"], var_2, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270.0, 180.0, 0.0 ) ) );
    }
}

_id_6CB6()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stopped_using_remote" );
    self endon( "disconnect" );
    self endon( "above_water" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    thread onplayerdeath();
    wait 13;

    for (;;)
    {
        if ( !isdefined( self.isjuggernaut ) || self.isjuggernaut == 0 )
            radiusdamage( self.origin + anglestoforward( self.angles ) * 5, 1, 20, 20, undefined, "MOD_TRIGGER_HURT" );

        wait 1;
    }
}

onplayerdeath()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "above_water" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        common_scripts\utility::waittill_any( "death", "becameSpectator" );
    else
        self waittill( "death" );

    _id_6C02( 0 );
    self.underwater = undefined;
    self._id_4EBF = undefined;
    self._id_51C1 = undefined;
    self._id_51FE = undefined;
    self.water_last_weapon = undefined;
    self.underwatermotiontype = undefined;
    self._id_35B0 = 0;
    self._id_35B1 = 0;
    maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
}

_id_4E82( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 32;

    if ( level _id_415C( var_0 ) - self.origin[2] <= var_1 )
        return 1;

    return 0;
}

_id_50A2( var_0, var_1 )
{
    if ( _id_4088() + var_1 >= level _id_415C( var_0 ) )
        return 1;
    else
        return 0;
}

_id_4088()
{
    var_0 = self geteye();
    self._id_35B0 = var_0[2] - self._id_35B1;
    self._id_35B1 = var_0[2];
    return var_0[2];
}

_id_415C( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_2 = var_1.origin[2];
    return var_2;
}

_id_6C97( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "end_swimming" );

    if ( !isdefined( var_0 ) )
        var_0 = "shallow";

    if ( var_0 == "shallow" && self hasweapon( level.shallow_water_weapon ) || var_0 == "deep" && self hasweapon( level.deep_water_weapon ) )
        self._id_2D20 = 1;

    switch ( var_0 )
    {
        case "deep":
            _id_41D7( level.deep_water_weapon );
            self switchtoweaponimmediate( level.deep_water_weapon );
            self.underwatermotiontype = "deep";
            break;
        case "shallow":
            _id_41D7( level.shallow_water_weapon );
            self switchtoweaponimmediate( level.shallow_water_weapon );
            self.underwatermotiontype = "shallow";
            break;
        case "none":
            self.underwatermotiontype = "none";
            break;
        default:
            _id_41D7( level.shallow_water_weapon );
            self switchtoweaponimmediate( level.shallow_water_weapon );
            self.underwatermotiontype = "shallow";
            break;
    }

    self disableweaponpickup();
    common_scripts\utility::_disableweaponswitch();
    common_scripts\utility::_disableoffhandweapons();
}

_id_6C8A()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( self.underwatermotiontype ) )
    {
        var_0 = self.underwatermotiontype;
        self notify( "end_swimming" );
        self enableweaponpickup();
        common_scripts\utility::_enableweaponswitch();
        common_scripts\utility::_enableoffhandweapons();

        if ( isdefined( self.isjuggernaut ) && self.isjuggernaut == 1 && isdefined( self._id_4798 ) )
        {
            self _meth_8131( 1 );

            if ( !isdefined( self._id_4798._id_4733 ) || self._id_4798._id_4733 == 0 )
                self disableoffhandweapons();

            if ( !isdefined( self._id_4798._id_473F ) || self._id_4798._id_473F == 0 )
                self _meth_84BF();
            else
                self _meth_84C0();
        }

        if ( isdefined( self.water_last_weapon ) )
            maps\mp\_utility::switch_to_last_weapon( self.water_last_weapon );

        switch ( var_0 )
        {
            case "deep":
                _id_9116( level.deep_water_weapon );
                break;
            case "shallow":
                _id_9116( level.shallow_water_weapon );
                break;
            case "none":
                break;
            default:
                _id_9116( level.shallow_water_weapon );
                break;
        }

        self.underwatermotiontype = undefined;
        self._id_2D20 = undefined;
    }
}

_id_41D7( var_0 )
{
    if ( !isdefined( self._id_2D20 ) || !self._id_2D20 )
        self giveweapon( var_0 );
}

_id_9116( var_0 )
{
    if ( !isdefined( self._id_2D20 ) || !self._id_2D20 )
        self takeweapon( var_0 );
}

_id_310D()
{
    maps\mp\_utility::playerallowhighjump( 1 );
    maps\mp\_utility::playerallowhighjumpdrop( 1 );
    maps\mp\_utility::playerallowboostjump( 1 );
    maps\mp\_utility::playerallowpowerslide( 1 );
    maps\mp\_utility::playerallowdodge( 1 );
}

_id_2B0E()
{
    maps\mp\_utility::playerallowhighjump( 0 );
    maps\mp\_utility::playerallowhighjumpdrop( 0 );
    maps\mp\_utility::playerallowboostjump( 0 );
    maps\mp\_utility::playerallowpowerslide( 0 );
    maps\mp\_utility::playerallowdodge( 0 );
}

_id_8000( var_0 )
{
    level.shallow_water_weapon = var_0;
}

_id_7F3F( var_0 )
{
    level.deep_water_weapon = var_0;
}

_id_51F8( var_0 )
{
    switch ( var_0 )
    {
        case "none":
        case "iw5_combatknife_mp":
        case "iw5_underwater_mp":
            return 1;
        default:
            return 0;
    }
}
