// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    _id_4DEA();
    _id_4DEB();
    _id_4DE8();
    _id_4DE9();
    level.killstreakfuncs["mp_laser2"] = ::_id_98AF;
    level.mapkillstreak = "mp_laser2";
    level._id_598A = &"MP_LASER2_MAP_KILLSTREAK_PICKUP";
    level.mapkillstreakdamagefeedbacksound = ::_id_4652;
    level._id_5387 = 0;
    level._id_5984 = ::_id_82FA;
}

_id_82FA()
{
    level thread maps\mp\bots\_bots_ks::_id_16CC( "mp_laser2", maps\mp\bots\_bots_ks::_id_167B );
}

_id_4DEA()
{
    level._id_54C9["beahm"] = loadfx( "vfx/muzzleflash/laser_wv_mp_laser" );
    level._id_54C9["beahm_smoke"] = loadfx( "vfx/muzzleflash/laser_wv_mp_laser_smoke" );
    level._id_54C9["laser_field1"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl1" );
    level._id_54C9["laser_field1_cheap"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl1_cheap" );
    level._id_54C9["laser_field2"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl2" );
    level._id_54C9["laser_field2_cheap"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl2_cheap" );
    level._id_54C9["laser_field3"] = loadfx( "vfx/map/mp_laser2/laser_core_lvl3" );
    level._id_54C9["laser_field2_up"] = loadfx( "vfx/map/mp_laser2/laser_core_up_lvl2" );
    level._id_54C9["laser_field3_up"] = loadfx( "vfx/map/mp_laser2/laser_core_up_lvl3" );
    level._id_54C9["laser_field1_up_slow"] = loadfx( "vfx/map/mp_laser2/laser_core_up_slow_lvl1" );
    level._id_54C9["laser_field2_down"] = loadfx( "vfx/map/mp_laser2/laser_core_down_lvl2" );
    level._id_54C9["laser_field3_down"] = loadfx( "vfx/map/mp_laser2/laser_core_down_lvl3" );
    level._id_54C9["laser_field1_down_slow"] = loadfx( "vfx/map/mp_laser2/laser_core_down_slow_lvl1" );
    level._id_54C9["laser_charge1"] = loadfx( "vfx/map/mp_laser2/laser_energy_fire_lvl1" );
    level._id_54C9["laser_beam_done1"] = loadfx( "vfx/map/mp_laser2/laser_energy_beam_done_lvl1" );
    level._id_54C9["hatch_light"] = loadfx( "vfx/lights/mp_laser2/light_lasercore_glow" );
    level._id_54C9["hatch_light_close"] = loadfx( "vfx/lights/mp_laser2/light_lasercore_glow_close" );
    level._id_54C9["laser_steam"] = loadfx( "vfx/map/mp_laser2/laser_core_steam" );
    level._id_54C9["laser_movement_sparks"] = loadfx( "vfx/sparks/machinery_scrape_sparks_looping" );
}

_id_4DEB()
{
    game["dialog"]["laser_deactivated"] = "laser_deactivated";
    game["dialog"]["laser_offline"] = "laser_offline";
    game["dialog"]["laser_strength"] = "laser_strength";
}

_id_4DE8()
{
    var_0 = spawnstruct();
    var_0.health = 999999;
    var_0.maxhealth = 1000;
    var_0._id_1933 = 20;
    var_0._id_1932 = 120;
    var_0._id_6721 = 0.15;
    var_0._id_6720 = 0.35;
    var_0._id_7CC4 = "sentry_manual";
    var_0._id_7CC3 = "sentry_offline";
    var_0._id_9364 = 45.0;
    var_0._id_8A5D = 0.05;
    var_0._id_65F2 = 8.0;
    var_0._id_21B4 = 0.1;
    var_0._id_3BBD = 0.3;
    var_0.streakname = "sky_laser_turret";
    var_0._id_051C = "sky_laser_mp";
    var_0._id_9C15 = "killstreak_laser2_mp";
    var_0._id_5D3A = "mp_sky_laser_turret_head";
    var_0._id_5D3C = "mp_sky_laser_turret_head";
    var_0.headicon = 1;
    var_0._id_91FB = "used_mp_laser2";
    var_0._id_84AA = 0;
    var_0._id_9F28 = "laser_deactivated";
    var_0._id_9F39 = "laser_offline";
    var_0._id_9F3A = "laser_strength";
    var_0._id_21DE = "default";

    if ( !isdefined( level._id_7CC5 ) )
        level._id_7CC5 = [];

    level._id_7CC5["sky_laser_turret"] = var_0;
    level.killstreakwieldweapons["mp_laser2_core"] = "mp_laser2";
}

_id_4DE9()
{
    var_0 = "sky_laser_turret";
    precacheitem( "mp_laser2_core" );
    precachemodel( "lsr_laser_button_01_obj" );
    var_1 = getent( "lasergun", "targetname" );
    var_1 hide();
    var_1 _id_54F5();
    var_1._id_3BA2 = var_1 _id_54CF();
    var_1._id_6383 = var_1 _id_54D1();
    var_1._id_56F9 = getent( "laser_animated_prop", "targetname" );
    var_1._id_56F9._id_66A4 = getentarray( "lsr_animated_parts", "targetname" );
    var_1._id_56F9 _id_54F5();
    var_1._id_5F5F = var_1._id_56F9 _id_54D0();
    var_1._id_56F9._id_0C8F = "lsr_laser_turret_up";
    var_1._id_56F9._id_0C6B = "lsr_laser_turret_down";
    var_1._id_56F9._id_0C70 = "lsr_laser_turret_idle_down";
    var_1._id_56F9._id_0C71 = "lsr_laser_turret_idle_up";
    var_1._id_3C87 = getent( "generator_hat", "targetname" );
    var_1._id_3C87._id_0C45 = "laser_button_on";
    var_1._id_3C87._id_0BBB = "laser_button_off";
    var_1._id_3C87._id_0BD8 = "laser_button_idle_on";
    var_1._id_3C87._id_0BD7 = "laser_button_idle_off";
    var_1._id_21DC = getent( "trig_lasercore_damage", "targetname" );
    var_1._id_21DD = getent( "trig_lasercore_death", "targetname" );
    var_1._id_3800 = getent( "trig_laserfire_damage", "targetname" );
    var_1.ownerlist = [];
    var_1._id_202E = spawnstruct();
    var_1._id_202E._id_2009 = getent( "laser_collision_base", "targetname" );
    var_1._id_202E._id_200D = getent( "laser_collision_head", "targetname" );
    var_1._id_388C = getentarray( "lsr_flap_top", "targetname" );
    var_1._id_0053 = getentarray( "lsr_geo_attach", "targetname" );
    var_1._id_56F9 _id_5790( var_1, 1 );
    var_2 = getentarray( "lsr_flap_bottom", "targetname" );
    var_1._id_388B = common_scripts\utility::array_combine( var_1._id_388C, var_2 );

    foreach ( var_4 in var_1._id_388B )
    {
        var_4._id_2009 = getent( var_4.target, "targetname" );

        if ( isdefined( var_4._id_2009 ) )
            var_4._id_2009._id_9A53 = 1;

        var_4._id_2012 = getent( var_4._id_2009.target, "targetname" );

        if ( isdefined( var_4._id_2012 ) )
            var_4._id_2012._id_9A53 = 1;

        var_4._id_2009 linktosynchronizedparent( var_4, "mainFlapBase" );
        var_4._id_2012 linktosynchronizedparent( var_4, "mainFlap_T" );
    }

    var_1._id_3887 = "lsr_energy_hatch_close";
    var_1._id_3888 = "lsr_energy_hatch_close_idle";
    var_1._id_388A = "lsr_energy_hatch_open";
    var_1._id_3889 = "lsr_energy_hatch_open_idle";
    level.sentrygun = var_1;
    level.sentrygun _id_54D2( var_0 );
}

_id_5790( var_0, var_1 )
{
    if ( var_1 == 0 )
    {
        var_0._id_202E._id_2009 unlink();
        var_0._id_202E._id_200D unlink();

        foreach ( var_3 in var_0._id_388C )
            var_3 unlink();

        foreach ( var_6 in var_0._id_0053 )
            var_6 unlink();

        foreach ( var_9 in var_0._id_56F9._id_66A4 )
            var_9 unlink();
    }
    else if ( var_1 == 1 )
    {
        var_0._id_202E._id_2009 linkto( self, "tag_origin" );
        var_0._id_202E._id_200D linkto( self, "tag_aim_pivot" );

        foreach ( var_3 in var_0._id_388C )
            var_3 linktosynchronizedparent( self );

        foreach ( var_6 in var_0._id_0053 )
            var_6 linktosynchronizedparent( self );

        foreach ( var_9 in var_0._id_56F9._id_66A4 )
            var_9 linktosynchronizedparent( self );
    }
}

_id_54D0()
{
    var_0 = common_scripts\utility::getstruct( "laser_lifter_top_loc", "targetname" );
    var_1 = common_scripts\utility::getstruct( "laser_lifter_bottom_loc", "targetname" );
    var_2 = var_0.origin - var_1.origin;
    var_3 = [];
    var_3["bottom"] = self.origin;
    var_3["top"] = self.origin + var_2;
    return var_3;
}

_id_54CF()
{
    var_0 = undefined;
    var_1 = common_scripts\utility::getstruct( "laser_core_fx_pos", "targetname" );
    var_0 = var_1 common_scripts\utility::spawn_tag_origin();
    var_0 show();
    var_2 = [];
    var_2["charge_up"] = var_0;
    return var_2;
}

_id_54D1()
{
    var_0 = getent( "laser_use_trig", "targetname" );
    var_1 = getent( "laser_switch", "targetname" );
    var_2 = [];
    var_3 = spawn( "script_model", var_1.origin );
    var_3.angles = var_1.angles;
    var_3 setmodel( "lsr_laser_button_01_obj" );
    var_3 hide();
    var_4 = [ var_3 ];
    var_5 = maps\mp\gametypes\_gameobjects::createuseobject( "none", var_0, var_4, ( 0.0, 0.0, 64.0 ) );
    var_5 maps\mp\gametypes\_gameobjects::allowuse( "none" );
    var_5 maps\mp\gametypes\_gameobjects::setusetime( 5 );
    var_5 maps\mp\gametypes\_gameobjects::setusetext( &"MP_LASERTURRET_HACKING" );
    var_5 maps\mp\gametypes\_gameobjects::setusehinttext( &"MP_LASERTURRET_HACK" );
    var_5.onbeginuse = ::_id_54D3;
    var_5.onenduse = ::_id_54D5;
    var_5.onuse = ::_id_54D6;
    var_5.oncantuse = ::_id_54D4;
    var_5.useweapon = "search_dstry_bomb_mp";
    var_2 = [];
    var_2["switch_obj"] = var_3;
    var_2["use_zone"] = var_5;
    return var_2;
}

_id_54D3( var_0 )
{

}

_id_54D5( var_0, var_1, var_2 )
{

}

_id_54D6( var_0 )
{
    level.sentrygun endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( level.sentrygun.owner ) )
        level.sentrygun.owner thread maps\mp\_utility::leaderdialogonplayer( level._id_7CC5[level.sentrygun.sentrytype]._id_9F28 );

    var_0 playsound( "mp_bomb_plant" );
    var_1 = level._id_7CC5["sky_laser_turret"].maxhealth;
    level.sentrygun notify( "damage", var_1, var_0, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ), "MOD_UNKNOWN", undefined, undefined, undefined, undefined, "none" );
}

_id_54D4( var_0 )
{

}

_id_54D2( var_0 )
{
    self.sentrytype = var_0;
    self setmodel( level._id_7CC5[self.sentrytype]._id_5D3A );
    self._id_84AA = 1;
    self setcandamage( 0 );
    self _meth_8138();
    self _meth_8156( 180 );
    self _meth_8155( 180 );
    self _meth_8157( 80 );
    self _meth_815A( -10 );
    self._id_54D7 = 0;
    self._id_56F9 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C70 );

    foreach ( var_2 in self._id_56F9._id_66A4 )
        var_2 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C70 );

    var_4 = spawn( "script_model", self gettagorigin( "tag_laser" ) );
    var_4 linkto( self );
    self.killcament = var_4;
    self.killcament setscriptmoverkillcam( "explosive" );
    maps\mp\killstreaks\_autosentry::_id_7CB0();
    self _meth_817A( 1 );
    _id_54D9();
    thread _id_54CA();
    thread _id_54CB();
    thread maps\mp\killstreaks\_autosentry::_id_7CA3();
}

_id_54CA()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self.health = level._id_7CC5[self.sentrytype].health;
        self.maxhealth = level._id_7CC5[self.sentrytype].maxhealth;
        self.damagetaken = 0;
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) )
            continue;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        switch ( var_9 )
        {
            case "artillery_mp":
            case "stealth_bomb_mp":
                var_0 *= 4;
                break;
            case "bomb_site_mp":
                var_0 = self.maxhealth;
                break;
        }

        if ( var_4 == "MOD_MELEE" )
            self.damagetaken += self.maxhealth;

        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

            if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                var_10 = var_0 * level.armorpiercingmod;
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

        if ( isdefined( var_9 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_11 )
            {
                case "remotemissile_projectile_mp":
                case "stinger_mp":
                case "ac130_105mm_mp":
                case "ac130_40mm_mp":
                    self.largeprojectiledamage = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "artillery_mp":
                case "stealth_bomb_mp":
                    self.largeprojectiledamage = 0;
                    var_10 += var_0 * 4;
                    break;
                case "bomb_site_mp":
                case "emp_grenade_mp":
                case "emp_grenade_var_mp":
                    self.largeprojectiledamage = 0;
                    var_10 = self.maxhealth + 1;
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

            self notify( "fakedeath" );
        }
    }
}

_id_54CB()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "fakedeath" );
        _id_54D9();
        self.ownerlist = [];
        self _meth_8103( undefined );
        self._id_77E4 = undefined;

        if ( level.teambased )
            self.team = undefined;

        if ( isdefined( self._id_6638 ) )
            self._id_6638 delete();

        self playsound( "sentry_explode" );

        if ( isdefined( self._id_4F93 ) )
        {
            self._id_4F93._id_9976 maps\mp\gametypes\_hud_util::destroyelem();
            self._id_4F93 maps\mp\killstreaks\_autosentry::_id_74AA();
            self._id_4F93 maps\mp\killstreaks\_autosentry::_id_74B2();
            self notify( "deleting" );
            wait 1.0;
            continue;
        }

        wait 1.5;
        self playsound( "sentry_explode_smoke" );

        for ( var_0 = 8; var_0 > 0; var_0 -= 0.4 )
            wait 0.4;
    }
}

_id_98AF( var_0, var_1 )
{
    if ( !_id_6C68() )
    {
        self iclientprintlnbold( &"MP_LASERTURRET_ENEMY" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    if ( isdefined( level.sentrygun._id_5806 ) && level.sentrygun._id_5806 == 1 )
    {
        self iclientprintlnbold( &"MP_LASERTURRET_BUSY" );
        return 0;
    }

    maps\mp\_matchdata::logkillstreakevent( "mp_laser2", self.origin );
    level.sentrygun _id_54DA( self );
    var_2 = level.sentrygun _meth_8066();

    if ( ( !isdefined( level.sentrygun._id_5D32 ) || level.sentrygun._id_5D32 == "off" ) && ( !isdefined( level.sentrygun._id_5F9B ) || level.sentrygun._id_5F9B == 0 ) )
        _id_54DC( level.sentrygun, level.sentrygun.sentrytype );

    return 1;
}

_id_6C68()
{
    if ( !isdefined( level.sentrygun ) )
        return 0;

    if ( level.teambased )
    {
        if ( isdefined( level.sentrygun.team ) && level.sentrygun.team != self.team )
            return 0;
    }
    else
    {
        foreach ( var_1 in level.sentrygun.ownerlist )
        {
            if ( isdefined( var_1 ) && var_1 != self )
                return 0;
        }
    }

    return 1;
}

_id_54DA( var_0 )
{
    self.owner = var_0;
    self.ownerlist = common_scripts\utility::array_add( self.ownerlist, var_0 );
    self _meth_8103( self.owner );
    self _meth_8105( 1, "sam_turret" );

    if ( level.teambased )
    {
        self.team = self.owner.team;
        self _meth_8135( self.team );
    }

    thread _id_54CE( var_0 );
    thread _id_6BFF( var_0 );

    if ( self.ownerlist.size > 1 )
        thread _id_6DB9();
}

_id_54CE( var_0 )
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    var_0 common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self.ownerlist = common_scripts\utility::array_remove( self.ownerlist, var_0 );

    if ( var_0 != self.owner )
        thread _id_8EEC();
    else if ( var_0 == self.owner )
    {
        var_1 = _id_4040( self.ownerlist );

        if ( isdefined( var_1 ) )
            _id_54DA( var_1 );
        else
            self notify( "fakedeath" );
    }
}

_id_0D00( var_0, var_1 )
{
    var_2 = [];
    var_3 = undefined;

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( var_0[var_4] == var_1 )
            var_2[var_2.size] = var_4;
    }

    var_3 = var_2[var_2.size - 1];
    var_5 = [];

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( var_4 != var_3 )
            var_5[var_5.size] = var_0[var_4];
    }

    return var_5;
}

_id_4040( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_0 = common_scripts\utility::array_reverse( var_0 );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && isplayer( var_2 ) && isalive( var_2 ) )
            return var_2;
    }

    return undefined;
}

_id_54DC( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = self;

    if ( !var_2 maps\mp\_utility::validateusestreak() )
        return 0;

    var_2._id_5553 = var_1;
    var_0 _id_54DB( self );
    return 1;
}

_id_54DB( var_0 )
{
    if ( self _meth_8066() == "manual" )
    {
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );
        self._id_5D32 = "off";
    }

    self _meth_8104( undefined );
    self setcandamage( 1 );

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    thread _id_54D8( var_0 );
    thread _id_6DBA();
    thread _id_6DB8();
    self playsound( "sentry_gun_plant" );
    self notify( "placed" );
}

_id_6DBA()
{
    wait 2.0;
    playfxontag( level._id_54C9["laser_steam"], self._id_3BA2["charge_up"], "tag_origin" );
}

_id_8EED()
{
    wait 4;
    stopfxontag( level._id_54C9["laser_steam"], self._id_3BA2["charge_up"], "tag_origin" );
    level common_scripts\utility::noself_delaycall( 3.5, ::_func_29C, 200 );
}

_id_8D22()
{
    var_0 = _func_231( "laser_light", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_a", "laser_on_a" );

    var_0 = _func_231( "laser_light_b", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_b", "laser_on_b" );

    var_0 = _func_231( "laser_point_lights", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part1", "warning" );
}

_id_8EEE()
{
    var_0 = _func_231( "laser_light", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_a", "laser_off_a" );

    var_0 = _func_231( "laser_light_b", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "lsr_part_b", "laser_off_b" );

    var_0 = _func_231( "laser_point_lights", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part1", "healthy" );
}

_id_6DB8()
{
    level._id_5387 = 1;
    _func_292( 200 );
    playfxontag( level._id_54C9["hatch_light"], self._id_3BA2["charge_up"], "tag_origin" );
    playfxontag( level._id_54C9["hatch_light"], level.sentrygun._id_56F9, "tag_origin" );
    wait 5.33;
    _id_8D22();
    playfxontag( level._id_54C9["laser_field1_up_slow"], self._id_3BA2["charge_up"], "tag_origin" );
    wait 1.0;
    playfxontag( level._id_54C9["laser_field1"], self._id_3BA2["charge_up"], "tag_origin" );
}

_id_6DB9()
{
    if ( !isdefined( self.ownerlist ) || self.ownerlist.size < 1 )
        return;

    level._id_5387 = self.ownerlist.size;
    var_0 = level._id_5387;

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            stopfxontag( level._id_54C9["laser_field1"], self._id_3BA2["charge_up"], "tag_origin" );
            playfxontag( level._id_54C9["laser_field1_cheap"], self._id_3BA2["charge_up"], "tag_origin" );
            playfxontag( level._id_54C9["laser_field2_up"], self._id_3BA2["charge_up"], "tag_origin" );
            wait 1.0;
            var_1 = _func_231( "laser_light", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_a", "laser_on_02_a" );

            var_5 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_7 in var_5 )
                var_7 _meth_83F6( "lsr_part_b", "laser_on_02_b" );

            playfxontag( level._id_54C9["laser_field2"], self._id_3BA2["charge_up"], "tag_origin" );
            break;
        case 3:
            stopfxontag( level._id_54C9["laser_field2"], self._id_3BA2["charge_up"], "tag_origin" );
            playfxontag( level._id_54C9["laser_field2_cheap"], self._id_3BA2["charge_up"], "tag_origin" );
            playfxontag( level._id_54C9["laser_field3_up"], self._id_3BA2["charge_up"], "tag_origin" );
            wait 1.0;
            var_9 = _func_231( "laser_light", "targetname" );

            foreach ( var_11 in var_9 )
                var_11 _meth_83F6( "lsr_part_a", "laser_on_03_a" );

            var_5 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_7 in var_5 )
                var_7 _meth_83F6( "lsr_part_b", "laser_on_03_b" );

            playfxontag( level._id_54C9["laser_field3"], self._id_3BA2["charge_up"], "tag_origin" );
            break;
        default:
            break;
    }
}

_id_8EEC()
{
    if ( !isdefined( level._id_5387 ) )
        return;

    var_0 = level._id_5387;
    level._id_5387 = self.ownerlist.size;
    wait 1.0;

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            playfxontag( level._id_54C9["laser_field2_down"], self._id_3BA2["charge_up"], "tag_origin" );
            stopfxontag( level._id_54C9["laser_field2"], self._id_3BA2["charge_up"], "tag_origin" );
            stopfxontag( level._id_54C9["laser_field1_cheap"], self._id_3BA2["charge_up"], "tag_origin" );
            playfxontag( level._id_54C9["laser_field1"], self._id_3BA2["charge_up"], "tag_origin" );
            var_1 = _func_231( "laser_light", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_a", "laser_on_a" );

            var_1 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_b", "laser_on_b" );

            break;
        case 3:
            playfxontag( level._id_54C9["laser_field3_down"], self._id_3BA2["charge_up"], "tag_origin" );
            stopfxontag( level._id_54C9["laser_field3"], self._id_3BA2["charge_up"], "tag_origin" );
            stopfxontag( level._id_54C9["laser_field2_cheap"], self._id_3BA2["charge_up"], "tag_origin" );
            playfxontag( level._id_54C9["laser_field2"], self._id_3BA2["charge_up"], "tag_origin" );
            var_1 = _func_231( "laser_light", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_a", "laser_on_02_a" );

            var_1 = _func_231( "laser_light_b", "targetname" );

            foreach ( var_3 in var_1 )
                var_3 _meth_83F6( "lsr_part_b", "laser_on_02_b" );

            break;
        default:
            break;
    }
}

_id_8EEB()
{
    if ( !isdefined( level._id_5387 ) )
        return;

    var_0 = level._id_5387;
    level._id_5387 = 0;
    wait 1.6;

    switch ( var_0 )
    {
        case 0:
            break;
        case 1:
            playfxontag( level._id_54C9["laser_field1_down_slow"], self._id_3BA2["charge_up"], "tag_origin" );
            killfxontag( level._id_54C9["laser_field1"], self._id_3BA2["charge_up"], "tag_origin" );
            _id_8EEE();
            wait 1.5;
            playfxontag( level._id_54C9["hatch_light_close"], self._id_3BA2["charge_up"], "tag_origin" );
            playfxontag( level._id_54C9["hatch_light_close"], level.sentrygun._id_56F9, "tag_origin" );
            break;
        default:
            break;
    }
}

_id_54D9()
{
    self._id_77E4 = undefined;
    self _meth_8108();
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );
    self._id_5D32 = "off";
    var_0 = self getentitynumber();
    maps\mp\killstreaks\_autosentry::_id_73AF( var_0 );

    if ( level.teambased )
        _id_8023( "none", ( 0.0, 0.0, 0.0 ) );
    else if ( isdefined( self.owner ) )
        _id_8023( "none", ( 0.0, 0.0, 0.0 ) );

    self _meth_815A( -10 );
    level.sentrygun _meth_8105( 0 );
    self _meth_8105( 0 );
    self setcandamage( 0 );
    _id_54C3( self._id_21DC );
    _id_54C3( self._id_21DD );

    if ( self._id_56F9.origin != self._id_5F5F["bottom"] )
    {
        _id_54E2();
        thread _id_8EED();
        thread _id_8EEB();
        thread _id_54CC();
    }
}

_id_54CC()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );

    foreach ( var_1 in self._id_56F9._id_66A4 )
    {

    }

    self._id_5806 = 1;
    self._id_5F9B = 1;
    wait 1;
    _id_5790( self, 0 );
    self._id_56F9 show();
    self._id_56F9 _id_5790( self, 1 );
    self hide();
    var_3 = [];
    var_3["laser_xform_down_sec1_start"] = "laser_xform_down_sec1_start";
    var_3["laser_xform_down_sec1_end"] = "laser_xform_down_sec1_end";
    var_3["laser_xform_down_sec2_start"] = "laser_xform_down_sec2_start";
    var_3["laser_xform_down_sec2_end"] = "laser_xform_down_sec2_end";
    self._id_56F9 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C6B, "laser_xform_down_sec1_start" );

    foreach ( var_1 in self._id_56F9._id_66A4 )
        var_1 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C6B, "laser_xform_down_sec1_start" );

    self._id_56F9 thread maps\mp\_audio::_id_873D( var_3, "laser_xform_down_sec1_start" );

    foreach ( var_7 in self._id_388B )
    {
        if ( isdefined( var_7.targetname ) && var_7.targetname == "lsr_flap_bottom" )
        {
            var_7 scriptmodelplayanimdeltamotion( self._id_3887 );
            continue;
        }

        var_7 scriptmodelplayanim( self._id_3887 );
    }

    self._id_56F9 thread _id_0FF2( 6 );
    self._id_56F9 thread _id_6DC5( 2.5 );
    self._id_56F9 maps\mp\_utility::delaythread( 6, ::_id_8EF5 );
    wait 7.8;
    self._id_5F9B = 0;
    self._id_5806 = 0;
}

_id_54CD()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );

    foreach ( var_1 in self._id_56F9._id_66A4 )
    {

    }

    self._id_5F9B = 1;
    var_3 = [];
    var_3["laser_xform_up_sec1_start"] = "laser_xform_up_sec1_start";
    var_3["laser_xform_up_sec1_end"] = "laser_xform_up_sec1_end";
    var_3["laser_xform_up_sec2_start"] = "laser_xform_up_sec2_start";
    var_3["laser_xform_up_sec2_end"] = "laser_xform_up_sec2_end";
    self._id_56F9 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C8F, "laser_xform_up_sec1_start" );

    foreach ( var_1 in self._id_56F9._id_66A4 )
        var_1 scriptmodelplayanimdeltamotion( self._id_56F9._id_0C8F, "laser_xform_up_sec1_start" );

    self._id_56F9 thread maps\mp\_audio::_id_873D( var_3, "laser_xform_up_sec1_start" );

    foreach ( var_7 in self._id_388B )
    {
        if ( isdefined( var_7.targetname ) && var_7.targetname == "lsr_flap_bottom" )
        {
            var_7 scriptmodelplayanimdeltamotion( self._id_388A );
            continue;
        }

        var_7 scriptmodelplayanim( self._id_388A );
    }

    self._id_56F9 thread _id_0FF3( 5.0 );
    self._id_56F9 thread _id_6DC5( 1.5 );
    self._id_56F9 maps\mp\_utility::delaythread( 5.0, ::_id_8EF5 );
    wait 8;
    self._id_56F9 _id_5790( self, 0 );
    self show();
    _id_5790( self, 1 );
    self._id_56F9 hide();
    waittillframeend;
    self._id_5F9B = 0;
}

_id_0FF3( var_0 )
{
    thread maps\mp\_audio::_id_8731( "laser_beam_power_up", ( 15.0, 382.0, 902.0 ), 5.2 );
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_up_start", self );
    thread _id_0FB6();
    thread maps\mp\_audio::_id_873B( "laser_platform_move_alarm_lp", ( -1.0, 355.0, 945.0 ), "aud_stop_laser_alarm", 2 );
    wait(var_0);
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_up_end", self );
    level notify( "aud_stop_laser_alarm" );
}

_id_0FF2( var_0 )
{
    thread maps\mp\_audio::_id_8731( "laser_beam_power_down", ( 15.0, 382.0, 902.0 ), 1.25 );
    thread _id_0FB7();
    wait 2.5;
    var_1 = thread maps\mp\_audio::snd_play_linked( "laser_platform_move_down_start", self );
    wait 3;
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_down_legs_fold", self );
    var_1 scalevolume( 0.0, 0.05 );
    var_1 stopsounds();
    level notify( "aud_laser_energy_lp_off" );
    wait 0.7;
    thread maps\mp\_audio::snd_play_linked( "laser_platform_move_down_end", self );
}

_id_0FB7()
{
    wait 1;
    var_0 = thread maps\mp\_audio::snd_play_linked( "laser_platform_pre_move_down", self );
}

_id_0FB6()
{
    thread maps\mp\_audio::_id_873B( "laser_base_pulse_energy_lp", ( -13.0, 393.0, 352.0 ), "aud_laser_energy_lp_off", 2 );
    thread maps\mp\_audio::_id_873B( "laser_base_pulse_low_lp", ( -13.0, 393.0, 352.0 ), "aud_laser_energy_lp_off", 2 );
    thread maps\mp\_audio::_id_873B( "laser_base_pulse_motor_lp", ( -13.0, 393.0, 352.0 ), "aud_laser_energy_lp_off", 2 );
}

_id_6DC5( var_0 )
{
    wait(var_0);

    foreach ( var_2 in self._id_66A4 )
    {
        if ( var_2.model == "mp_sky_laser_turret_lega" )
            playfxontag( level._id_54C9["laser_movement_sparks"], var_2, "fx_joint_0" );
    }
}

_id_8EF5()
{
    foreach ( var_1 in self._id_66A4 )
    {
        if ( var_1.model == "mp_sky_laser_turret_lega" )
            stopfxontag( level._id_54C9["laser_movement_sparks"], var_1, "fx_joint_0" );
    }
}

_id_6BFF( var_0 )
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );

    for ( var_1 = level._id_7CC5[self.sentrytype]._id_9364; var_1; var_1 = max( 0, var_1 - 1.0 ) )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }

    if ( isdefined( var_0 ) )
    {
        self.ownerlist = _id_0D00( self.ownerlist, var_0 );

        if ( self.ownerlist.size != 0 )
        {
            var_0 thread maps\mp\_utility::leaderdialogonplayer( level._id_7CC5[level.sentrygun.sentrytype]._id_9F3A );
            thread _id_8EEC();
        }
        else
        {
            var_0 thread maps\mp\_utility::leaderdialogonplayer( level._id_7CC5[level.sentrygun.sentrytype]._id_9F39 );
            self notify( "fakedeath" );
        }
    }
}

_id_54D8( var_0 )
{
    foreach ( var_0 in level.players )
    {
        var_2 = self getentitynumber();
        maps\mp\killstreaks\_autosentry::_id_0855( var_2 );
    }

    if ( self._id_84AA )
    {
        level thread maps\mp\_utility::teamplayercardsplash( level._id_7CC5[self.sentrytype]._id_91FB, self.owner, self.owner.team );
        self._id_84AA = 0;
    }

    _id_54C2( self._id_21DC );
    _id_54C2( self._id_21DD, 1 );
    _id_54CD();
    self _meth_815A( 5 );
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
    self._id_5D32 = "on";
    _id_54E3();

    if ( level._id_7CC5[self.sentrytype].headicon )
    {
        if ( level.teambased )
            _id_8023( self.team, ( 0.0, 0.0, 400.0 ) );
        else
            _id_8023( self.team, ( 0.0, 0.0, 400.0 ) );
    }

    thread _id_54C1();
    thread _id_54E4();
}

_id_54E2()
{
    self._id_3C87 scriptmodelplayanim( self._id_3C87._id_0BBB );
    level.sentrygun._id_6383["use_zone"] maps\mp\gametypes\_gameobjects::disableobject();
    level.sentrygun._id_6383["switch_obj"] hide();
}

_id_54E3()
{
    var_0 = "none";

    if ( isdefined( level.sentrygun.owner ) && isdefined( level.sentrygun.owner.team ) )
        var_0 = level.sentrygun.owner.team;

    self._id_3C87 scriptmodelplayanim( self._id_3C87._id_0C45 );
    level.sentrygun._id_6383["use_zone"].interactteam = "enemy";
    level.sentrygun._id_6383["use_zone"] maps\mp\gametypes\_gameobjects::setownerteam( var_0 );

    foreach ( var_2 in level.players )
    {
        if ( var_2.team != var_0 && var_0 != "none" )
        {
            var_2._id_54F7 = 1;
            level.sentrygun._id_6383["switch_obj"] showtoplayer( var_2 );
        }
    }
}

_id_8023( var_0, var_1 )
{
    if ( !level.teambased )
        return;

    if ( !isdefined( self._id_331A ) )
    {
        self._id_331A = "none";
        self.entityheadicon = undefined;
    }

    var_2 = game["entity_headicon_" + var_0];
    self._id_331A = var_0;

    if ( isdefined( var_1 ) )
        self._id_3317 = var_1;
    else
        self._id_3317 = ( 0.0, 0.0, 0.0 );

    self notify( "kill_entity_headicon_thread" );

    if ( var_0 == "none" )
    {
        if ( isdefined( self.entityheadicon ) )
            self.entityheadicon destroy();

        return;
    }

    var_3 = newteamhudelem( var_0 );
    var_3.archived = 1;
    var_3.x = self.origin[0] + self._id_3317[0];
    var_3.y = self.origin[1] + self._id_3317[1];
    var_3.z = self.origin[2] + self._id_3317[2];
    var_3.alpha = 1;
    var_3 setshader( var_2, 50, 50 );
    var_3 setwaypoint( 0, 0, 0, 1 );
    self.entityheadicon = var_3;
    thread maps\mp\_entityheadicons::_id_52DB();
    thread maps\mp\_entityheadicons::_id_28EB();
}

_id_7FE0( var_0, var_1 )
{
    if ( level.teambased )
        return;

    if ( !isdefined( self._id_331A ) )
    {
        self._id_331A = "none";
        self.entityheadicon = undefined;
    }

    self notify( "kill_entity_headicon_thread" );

    if ( !isdefined( var_0 ) )
    {
        if ( isdefined( self.entityheadicon ) )
            self.entityheadicon destroy();

        return;
    }

    var_2 = var_0.team;
    self._id_331A = var_2;

    if ( isdefined( var_1 ) )
        self._id_3317 = var_1;
    else
        self._id_3317 = ( 0.0, 0.0, 0.0 );

    var_3 = game["entity_headicon_" + var_2];
    var_4 = newclienthudelem( var_0 );
    var_4.archived = 1;
    var_4.x = self.origin[0] + self._id_3317[0];
    var_4.y = self.origin[1] + self._id_3317[1];
    var_4.z = self.origin[2] + self._id_3317[2];
    var_4.alpha = 1;
    var_4 setshader( var_3, 50, 50 );
    var_4 setwaypoint( 0, 0, 0, 1 );
    self.entityheadicon = var_4;
    thread maps\mp\_entityheadicons::_id_52DB();
    thread maps\mp\_entityheadicons::_id_28EB();
}

_id_54E4()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    self notify( "laser_watchDisabled" );
    self endon( "laser_watchDisabled" );

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_aim" );
        self _meth_815A( -10 );
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );
        self._id_5D32 = "none";
        wait(var_1);
        self _meth_815A( 5 );
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
        self._id_5D32 = "on";
    }
}

_id_54C1()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    self notify( "laser_attackTargets" );
    self endon( "laser_attackTargets" );
    self._id_77E4 = undefined;
    self._id_77E3 = [];

    for (;;)
    {
        self._id_77E4 = maps\mp\killstreaks\_autosentry::_id_77D3();
        _id_54C7();
        wait 0.05;
    }
}

_id_54E5()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait 0.5;

    if ( !isdefined( self.ownerlist ) || self.ownerlist.size < 1 )
        return;

    var_0 = self.ownerlist.size;
    playfxontag( level._id_54C9["laser_charge1"], self._id_3BA2["charge_up"], "tag_origin" );
    playfxontag( level._id_54C9["beahm"], self, "tag_laser" );
    _id_54C2( self._id_3800 );
    var_1 = maps\mp\_audio::snd_play_linked( "wpn_skylaser_fire_startup", self );
    thread common_scripts\utility::play_loop_sound_on_entity( "wpn_skylaser_beam_lp" );
    self laseron( "mp_laser2_laser" );

    while ( isdefined( self._id_77E4 ) && isdefined( self _meth_8109( 1 ) ) && self _meth_8109( 1 ) == self._id_77E4 )
        wait 0.05;

    self laseroff();
    stopfxontag( level._id_54C9["laser_charge1"], self._id_3BA2["charge_up"], "tag_origin" );
    playfxontag( level._id_54C9["laser_beam_done1"], self._id_3BA2["charge_up"], "tag_origin" );
    stopfxontag( level._id_54C9["beahm"], self, "tag_laser" );
    playfxontag( level._id_54C9["beahm_smoke"], self, "tag_laser" );
    _id_54C3( self._id_3800 );
    common_scripts\utility::stop_loop_sound_on_entity( "wpn_skylaser_beam_lp" );
    var_2 = maps\mp\_audio::snd_play_linked( "wpn_skylaser_beam_stop", self );

    if ( isdefined( var_1 ) )
        var_1 stopsounds();
}

_id_54C7()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );

    if ( isdefined( self._id_77E4 ) )
    {
        if ( isdefined( level.orbitalsupport_planemodel ) && self._id_77E4 == level.orbitalsupport_planemodel && !isdefined( level._id_656C ) )
        {
            self._id_77E4 = undefined;
            self _meth_8108();
            return;
        }

        self _meth_8106( self._id_77E4 );
        self waittill( "turret_on_target" );

        if ( !isdefined( self._id_77E4 ) )
            return;

        if ( !self._id_54D7 )
        {
            thread _id_54E5();
            thread maps\mp\killstreaks\_autosentry::_id_77D7();
            thread maps\mp\killstreaks\_autosentry::_id_77D6();
            thread maps\mp\killstreaks\_autosentry::_id_77D8();
            thread maps\mp\killstreaks\_autosentry::_id_77D9();
        }

        wait 0.5;

        if ( !isdefined( self._id_77E4 ) )
            return;

        if ( isdefined( level.orbitalsupport_planemodel ) && self._id_77E4 == level.orbitalsupport_planemodel && !isdefined( level._id_656C ) )
        {
            self._id_77E4 = undefined;
            self _meth_8108();
            return;
        }

        self _meth_80EA();
        _id_37D8();
    }
}

_id_37D8()
{
    self endon( "death" );
    self endon( "fakedeath" );
    level endon( "game_ended" );
    var_0 = self gettagorigin( "tag_laser" );
    var_1 = anglestoforward( self gettagangles( "tag_laser" ) );
    var_2 = var_0 + 15000 * var_1;
    var_3 = bullettrace( var_0, var_2, 1, self );

    if ( isdefined( level.orbitalsupport_planemodel ) && self._id_77E4 == level.orbitalsupport_planemodel && isdefined( level._id_656C ) )
        radiusdamage( level.orbitalsupport_planemodel.origin, 512, 100, 100, self.owner, "MOD_EXPLOSIVE", "killstreak_laser2_mp" );
    else if ( isdefined( self._id_77E4._id_517B ) && self._id_77E4._id_517B )
        self._id_77E4 notify( "damage", 1000, self.owner, undefined, undefined, "mod_explosive", undefined, undefined, undefined, undefined, "killstreak_laser2_mp" );
    else
        radiusdamage( var_3["position"], 512, 200, 200, self.owner, "MOD_EXPLOSIVE", "killstreak_laser2_mp" );
}

_id_54C2( var_0, var_1 )
{
    level endon( "game_ended" );
    thread _id_A244( var_0, var_1 );
    var_0 common_scripts\utility::trigger_on();
}

_id_54C3( var_0 )
{
    level endon( "game_ended" );
    var_0 notify( "laser_coreDamage_deactivated" );
    var_0 common_scripts\utility::trigger_off();
}

_id_A244( var_0, var_1 )
{
    level endon( "game_ended" );
    var_0 endon( "laser_coreDamage_deactivated" );

    for (;;)
    {
        var_0 waittill( "trigger", var_2 );

        if ( !isplayer( var_2 ) )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        if ( isdefined( var_2._id_54ED ) && isdefined( var_2._id_54ED[var_0.targetname] ) && var_2._id_54ED[var_0.targetname] == 1 )
            continue;
        else
        {
            if ( !isdefined( var_2._id_54ED ) )
                var_2._id_54ED = [];

            var_2._id_54ED[var_0.targetname] = 1;
            var_2 thread _id_6B81( var_0, var_1 );

            if ( isalive( var_2 ) )
            {
                var_2 thread _id_6C56( var_0 );
                var_2 thread _id_6C55( var_0 );
                continue;
            }

            var_2._id_54ED[var_0.targetname] = 0;
        }
    }
}

_id_6C56( var_0 )
{
    level endon( "game_ended" );
    self endon( "player_leftLaserCoreTrigger" + var_0.targetname );
    self endon( "stop_watching_trig" );

    while ( self istouching( var_0 ) )
        wait 0.05;

    if ( isdefined( self._id_54ED ) )
        self._id_54ED[var_0.targetname] = 0;

    _id_6BDC();
    self notify( "player_leftLaserCoreTrigger" + var_0.targetname );
}

_id_6B81( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "player_leftLaserCoreTrigger" + var_0.targetname );
    self endon( "stop_watching_trig" );

    if ( isdefined( var_1 ) && var_1 )
    {
        maps\mp\_utility::_suicide();
        return;
    }

    self.poison = 0;
    var_2 = level._id_7CC5[level.sentrygun.sentrytype]._id_21DE;

    if ( !isdefined( self.usingremote ) && !isdefined( self.ridevisionset ) )
    {
        self visionsetnakedforplayer( "aftermath", 0.5 );
        self shellshock( var_2, 60 );
    }
    else
        self._id_54EE = 1;

    for (;;)
    {
        self.poison++;

        switch ( self.poison )
        {
            case 1:
                self _meth_81AF( 1, self.origin );
                break;
            case 2:
                self _meth_81AF( 3, self.origin );
                _id_6ADB( 15 );
                break;
            case 3:
                self _meth_81AF( 15, self.origin );
                _id_6ADB( 15 );
                break;
            case 4:
                self _meth_81AF( 75, self.origin );
                maps\mp\_utility::_suicide();
                return;
        }

        wait 1;
    }
}

_id_6C55( var_0 )
{
    level endon( "game_ended" );
    self endon( "player_leftLaserCoreTrigger" + var_0.targetname );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators", "death" );
    self._id_54ED = undefined;
    _id_6BDC();
    self notify( "stop_watching_trig" );
}

_id_6BDC()
{
    if ( !isdefined( self._id_54EE ) )
    {
        self stopshellshock();
        thread maps\mp\_utility::revertvisionsetforplayer( 0.5 );
    }

    self._id_54EE = undefined;
}

_id_54F5()
{
    playfxontag( common_scripts\utility::getfx( "light_laser_fill" ), self, "tag_origin" );
}

_id_6ADB( var_0 )
{
    if ( !isdefined( level.sentrygun.owner ) )
        return;

    self thread [[ level.callbackplayerdamage ]]( self, level.sentrygun.owner, var_0, 0, "MOD_TRIGGER_HURT", "mp_laser2_core", self.origin, ( 0.0, 0.0, 0.0 ) - self.origin, "none", 0 );
}

_id_4652( var_0 )
{

}
