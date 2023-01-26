// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_5FCA = 25;
    level._id_5FC9 = 0;
    level._id_72B6 = 0;
    level._id_72B7 = 0;
    level._id_5FCB = undefined;
    level.killstreakfuncs["mp_refraction"] = ::_id_98B2;
    level.mapkillstreak = "mp_refraction";
    level._id_598A = &"MP_REFRACTION_MAP_KILLSTREAK_PICKUP";
    level.killstreakwieldweapons["refraction_turret_mp"] = "refraction_turret_mp";

    if ( !isdefined( level._id_7CC5 ) )
        level._id_7CC5 = [];

    level._id_7CC5["refraction_turret"] = spawnstruct();
    level._id_7CC5["refraction_turret"].health = 999999;
    level._id_7CC5["refraction_turret"].maxhealth = 1000;
    level._id_7CC5["refraction_turret"]._id_1933 = 20;
    level._id_7CC5["refraction_turret"]._id_1932 = 120;
    level._id_7CC5["refraction_turret"]._id_6721 = 0.15;
    level._id_7CC5["refraction_turret"]._id_6720 = 0.35;
    level._id_7CC5["refraction_turret"]._id_7CC4 = "sentry";
    level._id_7CC5["refraction_turret"]._id_7CC3 = "sentry_offline";
    level._id_7CC5["refraction_turret"]._id_9364 = 90.0;
    level._id_7CC5["refraction_turret"]._id_8A5D = 0.05;
    level._id_7CC5["refraction_turret"]._id_65F2 = 8.0;
    level._id_7CC5["refraction_turret"]._id_21B4 = 0.1;
    level._id_7CC5["refraction_turret"]._id_3BBD = 0.3;
    level._id_7CC5["refraction_turret"].streakname = "sentry";
    level._id_7CC5["refraction_turret"]._id_051C = "refraction_turret_mp";
    level._id_7CC5["refraction_turret"]._id_5D3A = "ref_turret_01";
    level._id_7CC5["refraction_turret"].sentrytype = "refraction_turret";
    level._id_7CC5["refraction_turret"]._id_5D40 = "sentry_minigun_weak_obj";
    level._id_7CC5["refraction_turret"]._id_5D41 = "sentry_minigun_weak_obj_red";
    level._id_7CC5["refraction_turret"]._id_5D3C = "sentry_minigun_weak_destroyed";
    level._id_7CC5["refraction_turret"]._id_01F2 = &"SENTRY_PICKUP";
    level._id_7CC5["refraction_turret"].headicon = 1;
    level._id_7CC5["refraction_turret"]._id_91FB = "used_sentry";
    level._id_7CC5["refraction_turret"]._id_84AA = 0;
    level._id_7CC5["refraction_turret"]._id_9F28 = "sentry_destroyed";
    level._id_72B5 = _id_9984();
    level._id_996E = "mp_refraction_turret_movement1";
    level._id_996F = "mp_refraction_turret_movement2";
    level._id_9970 = "mp_refraction_turret_movement3";
}

_id_98B2( var_0, var_1 )
{
    if ( isdefined( level._id_5FCB ) || level._id_5FC9 )
    {
        self iclientprintlnbold( &"MP_REFRACTION_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    var_2 = _id_7FF7( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_refraction", self.origin );

    return var_2;
}

_id_72BA()
{
    self endon( "game_ended" );
    var_0 = level._id_5FCA;

    if ( level._id_5FCB maps\mp\_utility::_hasperk( "specialty_blackbox" ) && isdefined( level._id_5FCB._id_8A32 ) )
        var_0 *= level._id_5FCB._id_8A32;

    while ( var_0 > 0 )
    {
        wait 1;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
        var_0 -= 1.0;

        if ( level._id_5FC9 == 0 )
            return;
    }

    for ( var_1 = 0; var_1 < level._id_72B5.size; var_1++ )
        level._id_72B5[var_1] notify( "fake_refraction_death" );
}

_id_5EB3()
{
    level endon( "game_ended" );

    while ( level._id_72B6 > 0 || level._id_72B7 < level._id_72B5.size )
        wait 0.05;

    _id_9A7F();
}

_id_7FF7( var_0 )
{
    if ( isdefined( level._id_5FCB ) )
        return 0;

    level._id_5FC9 = 1;
    level._id_5FCB = var_0;
    thread maps\mp\_utility::teamplayercardsplash( "used_mp_refraction", var_0 );
    var_1 = "refraction_turret";

    for ( var_2 = 0; var_2 < level._id_72B5.size; var_2++ )
    {
        level._id_72B6++;
        level._id_72B7 = 0;
        level._id_72B5[var_2] _id_7CBA( var_0 );
        level._id_72B5[var_2] _meth_8156( 45 );
        level._id_72B5[var_2] _meth_8155( 45 );
        level._id_72B5[var_2] _meth_8157( 10 );
        level._id_72B5[var_2]._id_84AA = 0;
        level._id_72B5[var_2]._id_1BAA = var_0;
        level._id_72B5[var_2] _id_7CBB();
        level._id_72B5[var_2] thread _id_7CA8();
        level._id_72B5[var_2] thread _id_7CA9();
        level._id_72B5[var_2] thread _id_7CAE();
        level._id_72B5[var_2] thread _id_10D1();
    }

    level thread _id_72BA();
    level thread _id_5EB3();
    return 1;
}

_id_10D1()
{
    thread maps\mp\_audio::_id_8730( "turret_cover_explode", self.origin );
    thread maps\mp\_audio::_id_8730( "turret_rise_start", self.origin );
}

_id_9A7F()
{
    level._id_5FCB = undefined;
    level._id_5FC9 = 0;
}

_id_9984()
{
    var_0 = getentarray( "turret_killer", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = undefined;

        if ( isdefined( var_2.target ) )
            var_3 = getentarray( var_2.target, "targetname" );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "turret_lifter" )
            {
                var_2._id_56F9 = var_5;
                continue;
            }
            else if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "hatch" )
            {
                var_2._id_474C = var_5;
                continue;
            }
            else
            {

            }
        }

        var_2._id_56F9._id_0C8F = "ref_turret_gun_raise";
        var_2._id_56F9._id_0C6B = "ref_turret_gun_lower";
        var_2._id_56F9._id_4B86 = "ref_turret_gun_idle_up";
        var_2._id_56F9._id_4B78 = "ref_turret_gun_idle_down";
        var_2._id_474C._id_0C8F = "ref_turret_hatch_raise";
        var_2._id_474C._id_0C6B = "ref_turret_hatch_lower";
        var_2._id_474C._id_4B86 = "ref_turret_hatch_idle_up";
        var_2._id_474C._id_4B78 = "ref_turret_hatch_idle_down";
        var_2._id_202E = spawnstruct();
        var_7 = undefined;

        if ( isdefined( var_2._id_56F9.target ) )
            var_7 = getentarray( var_2._id_56F9.target, "targetname" );

        foreach ( var_9 in var_7 )
        {
            if ( isdefined( var_9.script_noteworthy ) )
            {
                switch ( var_9.script_noteworthy )
                {
                    case "ref_turret_body_col":
                        var_2._id_202E._id_200A = var_9;
                        continue;
                    case "ref_turret_head_col":
                        var_2._id_202E._id_200D = var_9;
                        continue;
                    case "ref_turret_leg_r_col":
                        var_2._id_202E._id_200F = var_9;
                        continue;
                    case "ref_turret_leg_l_col":
                        var_2._id_202E._id_200E = var_9;
                        continue;
                    case "ref_turret_gun_col":
                        var_2._id_202E._id_200C = var_9;
                        continue;
                }
            }
        }

        var_2._id_88A1 = common_scripts\utility::spawn_tag_origin();
        var_2._id_88A1.origin = var_2.origin + ( 0.0, 0.0, 24.0 );
        var_2 _meth_815A( 0 );
        var_11 = level._id_7CC5["refraction_turret"].sentrytype;
        var_2 _id_7CAD( var_11 );
        var_2 _meth_8136();
        var_2 hide();
        var_2._id_54DD = spawn( "script_model", var_2.origin );
        var_2._id_54DD setmodel( "tag_laser" );
    }

    return var_0;
}

_id_5781( var_0, var_1 )
{
    if ( var_1 == 0 )
    {
        if ( isdefined( var_0._id_202E._id_200A ) )
            var_0._id_202E._id_200A unlink();

        if ( isdefined( var_0._id_202E._id_200D ) )
            var_0._id_202E._id_200D unlink();

        if ( isdefined( var_0._id_202E._id_200F ) )
            var_0._id_202E._id_200F unlink();

        if ( isdefined( var_0._id_202E._id_200E ) )
            var_0._id_202E._id_200E unlink();

        if ( isdefined( var_0._id_202E._id_200C ) )
            var_0._id_202E._id_200C unlink();
    }
    else if ( var_1 == 1 )
    {
        if ( isdefined( var_0._id_202E._id_200A ) )
            var_0._id_202E._id_200A linkto( self, "tag_origin" );

        if ( isdefined( var_0._id_202E._id_200D ) )
            var_0._id_202E._id_200D linkto( self, "tag_aim_animated" );

        if ( isdefined( var_0._id_202E._id_200F ) )
            var_0._id_202E._id_200F linkto( self, "arm_r" );

        if ( isdefined( var_0._id_202E._id_200E ) )
            var_0._id_202E._id_200E linkto( self, "arm_l" );

        if ( isdefined( var_0._id_202E._id_200C ) )
            var_0._id_202E._id_200C linkto( self, "tag_barrel" );
    }
}

_id_7CAE()
{
    level endon( "game_ended" );
    self waittill( "refraction_turret_moved_up" );
    self._id_54DD laseron();
    self._id_54DD.origin = self gettagorigin( "tag_flash" );
    self._id_54DD.angles = self gettagangles( "tag_flash" );
    self._id_54DD linkto( self, "tag_flash" );
    self waittill( "fake_refraction_death" );
    self._id_54DD laseroff();
}

_id_9971()
{
    wait(randomfloatrange( 1, 1.5 ));
    self.killcament = spawn( "script_model", self gettagorigin( "tag_player" ) );
    self.killcament setscriptmoverkillcam( "explosive" );
    self._id_56F9 _id_5781( self, 1 );
    var_0 = [];
    var_0["ref_turret_raise_doors_start"] = "ref_turret_raise_doors_start";
    var_0["ref_turret_raise_doors_end"] = "ref_turret_raise_doors_end";
    var_0["ref_turret_down_start"] = "ref_turret_down_start";
    var_0["ref_turret_down_end"] = "ref_turret_down_end";
    var_0["ref_turret_doors_close_start"] = "ref_turret_doors_close_start";
    var_0["ref_turret_doors_close_end"] = "ref_turret_doors_close_end";
    var_0["ref_turret_barrell_ext_start"] = "ref_turret_barrell_ext_start";
    var_0["ref_turret_barrell_ext_end"] = "ref_turret_barrell_ext_end";
    self._id_474C scriptmodelplayanimdeltamotion( self._id_474C._id_0C8F );
    self._id_56F9 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C8F, "ref_turret_raise_doors_start" );
    self._id_56F9 thread maps\mp\_audio::_id_873D( var_0, "ref_turret_raise_doors_start" );
    thread _id_6DA4();
    thread _id_6A29();
    wait 4.17;
    self._id_56F9 _id_5781( self, 0 );
    self show();
    self._id_56F9 hide();
    self notify( "refraction_turret_moved_up" );
}

_id_6DA4()
{
    level thread common_scripts\_exploder::_id_06F5( 1 );
    level thread common_scripts\_exploder::_id_06F5( 2 );
    level thread common_scripts\_exploder::_id_06F5( 3 );
    level thread common_scripts\_exploder::_id_06F5( 4 );
    level thread common_scripts\_exploder::_id_06F5( 5 );
    level thread common_scripts\_exploder::_id_06F5( 6 );
    level thread common_scripts\_exploder::_id_06F5( 7 );
    level thread common_scripts\_exploder::_id_06F5( 8 );
}

_id_6A29()
{
    self._id_88A1 thread maps\mp\_utility::play_sound_on_tag( level._id_996E, "tag_origin" );
    wait 1;
    self._id_88A1 thread maps\mp\_utility::play_sound_on_tag( level._id_996F, "tag_origin" );
    wait 1;
    self._id_88A1 thread maps\mp\_utility::play_sound_on_tag( level._id_9970, "tag_origin" );
}

_id_996D( var_0 )
{
    wait(randomfloatrange( 1, 1.5 ));
    self._id_56F9 show();
    self._id_56F9 _id_5781( self, 1 );
    self hide();
    var_1 = [];
    var_1["ref_turret_raise_doors_start"] = "ref_turret_raise_doors_start";
    var_1["ref_turret_raise_doors_end"] = "ref_turret_raise_doors_end";
    var_1["ref_turret_down_start"] = "ref_turret_down_start";
    var_1["ref_turret_down_end"] = "ref_turret_down_end";
    var_1["ref_turret_barrell_close_start"] = "ref_turret_barrell_close_start";
    var_1["ref_turret_barrell_close_end"] = "ref_turret_barrell_close_end";
    var_1["ref_turret_doors_close_start"] = "ref_turret_doors_close_start";
    var_1["ref_turret_doors_close_end"] = "ref_turret_doors_close_end";
    var_1["ref_turret_doors_lock_start"] = "ref_turret_doors_lock_start";
    var_1["ref_turret_doors_lock_end"] = "ref_turret_doors_lock_end";
    var_2 = self._id_474C.angles + ( -90.0, 0.0, 0.0 );
    common_scripts\utility::noself_delaycall( 4.1, ::playfx, common_scripts\utility::getfx( "mp_ref_turret_steam_off" ), self._id_474C.origin, anglestoforward( var_2 ), anglestoup( var_2 ) );
    self._id_474C scriptmodelplayanimdeltamotion( self._id_474C._id_0C6B );
    self._id_56F9 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C6B, "ref_turret_down_end" );
    self._id_56F9 thread maps\mp\_audio::_id_873D( var_1, "ref_turret_down_end" );
    wait 4.64;
    waittillframeend;
    self._id_56F9 _id_5781( self, 0 );
    level._id_72B7++;
}

_id_7CBB()
{
    self _meth_8104( undefined );
    self._id_1BAA _meth_80DE();
    self._id_1BAA = undefined;

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    thread _id_7CB6();
    self playsound( "sentry_gun_plant" );
    self notify( "placed" );
}

_id_7CB6()
{
    _id_9971();
    self setcandamage( 1 );
    self setcanradiusdamage( 1 );
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );

    if ( level._id_7CC5[self.sentrytype].headicon )
    {
        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0.0, 0.0, 95.0 ) );
        else
            maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0.0, 0.0, 95.0 ) );
    }
}

_id_7CAD( var_0 )
{
    self.sentrytype = var_0;
    self._id_1AAE = 1;
    self setmodel( level._id_7CC5[self.sentrytype]._id_5D3A );
    self _meth_8138();
    self _meth_815A( 0.0 );
    self _meth_817A( 1 );
    maps\mp\killstreaks\_autosentry::_id_7CB9();
    thread maps\mp\killstreaks\_autosentry::_id_7CAB();
    thread maps\mp\killstreaks\_autosentry::_id_7CA2();
}

_id_7CA9()
{
    self waittill( "fake_refraction_death" );

    if ( !isdefined( self ) )
        return;

    maps\mp\killstreaks\_autosentry::_id_7CB9();
    self _meth_8103( undefined );
    self _meth_8105( 0 );
    self setcandamage( 0 );
    self setcanradiusdamage( 0 );
    self._id_54DD laseroff();
    _id_996D();
    level._id_72B6--;

    if ( isdefined( self.killcament ) )
        self.killcament delete();
}

_id_7CBA( var_0 )
{
    self.owner = var_0;
    self _meth_8103( self.owner );
    self _meth_8105( 1, self.sentrytype );

    if ( level.teambased && isdefined( var_0 ) )
    {
        self.team = self.owner.team;
        self _meth_8135( self.team );
    }

    thread _id_7CAA();
}

_id_7CAA()
{
    level endon( "game_ended" );
    self endon( "fake_refraction_death" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "fake_refraction_death" );
}

_id_7CA8()
{
    self endon( "fake_refraction_death" );
    level endon( "game_ended" );
    self.health = level._id_7CC5[self.sentrytype].health;
    self.maxhealth = level._id_7CC5[self.sentrytype].maxhealth;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) )
            continue;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        var_10 = 0;

        if ( isdefined( var_9 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_11 )
            {
                case "emp_grenade_mp":
                case "emp_grenade_var_mp":
                    self.largeprojectiledamage = 0;
                    var_10 = self.maxhealth + 1;

                    if ( isplayer( var_1 ) )
                        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

                    break;
                default:
                    var_10 = 0;
                    break;
            }

            maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_9, self );
        }

        self.damagetaken += var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );

            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
                level thread maps\mp\gametypes\_rank::awardgameevent( "kill", var_1, var_9, undefined, var_4 );

            if ( isdefined( self.owner ) )
                self.owner thread maps\mp\_utility::leaderdialogonplayer( level._id_7CC5[self.sentrytype]._id_9F28, undefined, undefined, self.origin );

            self notify( "fake_refraction_death" );
            return;
        }
    }
}
