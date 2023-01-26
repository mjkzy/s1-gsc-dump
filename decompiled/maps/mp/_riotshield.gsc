// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_752B = [];
    level._id_752B[level._id_752B.size] = "riotshield_mp";
    level._id_752B[level._id_752B.size] = "iw5_riotshieldt6_mp";
    level._id_752B[level._id_752B.size] = "iw5_riotshieldt6loot0_mp";
    level._id_752B[level._id_752B.size] = "iw5_riotshieldt6loot1_mp";
    level._id_752B[level._id_752B.size] = "iw5_riotshieldt6loot2_mp";
    level._id_752B[level._id_752B.size] = "iw5_riotshieldt6loot3_mp";
    level._id_752B[level._id_752B.size] = "iw5_riotshieldjugg_mp";
    _id_6ED1();
    level._id_752A = getent( "riot_shield_collision", "targetname" );
    level._effect["riot_shield_shock_fx"] = loadfx( "vfx/explosion/riotshield_stun" );
    level._effect["riot_shield_deploy_smoke"] = loadfx( "vfx/smoke/riotshield_deploy_smoke" );
    level._effect["riot_shield_deploy_lights"] = loadfx( "vfx/lights/riotshield_deploy_lights" );
}

_id_6ED1()
{
    map_restart( "npc_deployable_riotshield_stand_deploy" );
    map_restart( "npc_deployable_riotshield_stand_destroyed" );
    map_restart( "npc_deployable_riotshield_stand_shot" );
    map_restart( "npc_deployable_riotshield_stand_shot_back" );
    map_restart( "npc_deployable_riotshield_stand_melee_front" );
    map_restart( "npc_deployable_riotshield_stand_melee_back" );
}

_id_473D()
{
    return isdefined( self.frontshieldmodel ) || isdefined( self.backshieldmodel );
}

hasriotshieldequipped()
{
    return isdefined( self.frontshieldmodel );
}

weaponisriotshield( var_0 )
{
    if ( !isdefined( level._id_752B ) )
        return 0;

    var_1 = getweaponbasename( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    foreach ( var_3 in level._id_752B )
    {
        if ( var_3 == var_1 )
            return 1;
    }

    return 0;
}

_id_A2D2( var_0 )
{
    if ( !weaponisriotshield( var_0 ) )
        return 0;

    return issubstr( var_0, "shockplant" );
}

_id_4064( var_0 )
{
    var_1 = 0;
    var_2 = self getweaponslistprimaries();

    foreach ( var_4 in var_2 )
    {
        if ( weaponisriotshield( var_4 ) )
        {
            if ( var_4 == var_0 && !var_1 )
            {
                var_1 = 1;
                continue;
            }

            return var_4;
        }
    }

    return undefined;
}

_id_9B16( var_0 )
{
    self.frontshieldmodel = undefined;
    self.backshieldmodel = undefined;

    if ( !isdefined( var_0 ) )
        var_0 = self getcurrentprimaryweapon();

    if ( weaponisriotshield( var_0 ) )
        self.frontshieldmodel = getweaponmodel( var_0 );

    var_1 = _id_4064( var_0 );

    if ( isdefined( var_1 ) )
        self.backshieldmodel = getweaponmodel( var_1 );

    self refreshshieldmodels( var_0 );
}

riotshield_clear()
{
    self.frontshieldmodel = undefined;
    self.backshieldmodel = undefined;
}

_id_330B()
{
    if ( !self islinked() )
        return 0;

    var_0 = self _meth_8531();

    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "tag_inhand":
        case "tag_weapon_left":
        case "tag_shield_back":
            return 1;
    }

    return 0;
}

watchriotshielduse()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    thread _id_9505();

    for (;;)
    {
        self waittill( "raise_riotshield" );
        thread _id_8D34();
    }
}

_id_7547()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "riotshield_change_weapon" );
    var_0 = undefined;
    self waittill( "weapon_change", var_0 );
    self notify( "riotshield_change_weapon", var_0 );
}

_id_754B()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "riotshield_change_weapon" );
    var_0 = undefined;

    for (;;)
    {
        self waittill( "weapon_switch_started", var_0 );

        if ( self isonladder() )
        {
            thread _id_754A();
            break;
        }

        if ( isdefined( self.frontshieldmodel ) && isdefined( self.backshieldmodel ) )
        {
            wait 0.5;
            break;
        }
    }

    self notify( "riotshield_change_weapon", var_0 );
}

_id_754A()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "weapon_change" );

    while ( self isonladder() )
        waitframe();

    self notify( "riotshield_change_weapon", self getcurrentprimaryweapon() );
}

_id_7548()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "riotshield_change_weapon" );
    var_0 = undefined;
    var_1 = maps\mp\_exo_shield::get_exo_shield_weapon();
    self waittillmatch( "grenade_pullback", var_1 );

    while ( !isdefined( self.exo_shield_on ) || !self.exo_shield_on )
        waitframe();

    self notify( "riotshield_change_weapon", var_1 );
}

_id_7549()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "riotshield_change_weapon" );

    if ( !isdefined( self.exo_shield_on ) || !self.exo_shield_on )
        return;

    var_0 = undefined;
    var_1 = maps\mp\_exo_shield::get_exo_shield_weapon();
    self waittillmatch( "battery_discharge_end", var_1 );

    while ( isdefined( self.exo_shield_on ) && self.exo_shield_on )
        waitframe();

    self notify( "riotshield_change_weapon", self getcurrentweapon() );
}

watchriotshieldloadout()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "track_riot_shield" );
    self waittill( "applyLoadout" );
    _id_9B16( self getcurrentweapon() );
}

_id_9505()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self notify( "track_riot_shield" );
    self endon( "track_riot_shield" );
    _id_9B16( self.currentweaponatspawn );
    thread watchriotshieldloadout();
    self._id_55C2 = "none";

    for (;;)
    {
        thread _id_A249();
        var_0 = self getcurrentweapon();

        if ( isdefined( self.exo_shield_on ) && self.exo_shield_on )
            var_0 = maps\mp\_exo_shield::get_exo_shield_weapon();

        thread _id_7547();
        thread _id_754B();
        thread _id_7548();
        thread _id_7549();
        self waittill( "riotshield_change_weapon", var_1 );

        if ( weaponisriotshield( var_1 ) )
        {
            if ( _id_473D() )
            {
                if ( isdefined( self._id_7553 ) )
                {
                    self takeweapon( self._id_7553 );
                    self._id_7553 = undefined;
                }
            }

            if ( _id_51EE( var_0 ) )
                self._id_55C2 = var_0;
        }

        _id_9B52( var_1 );
    }
}

_id_9B52( var_0 )
{
    if ( self ismantling() && var_0 == "none" )
        return;

    _id_9B16( var_0 );
}

_id_A249()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "track_riot_shield" );
    self notify( "watch_riotshield_pickup" );
    self endon( "watch_riotshield_pickup" );
    self waittill( "pickup_riotshield" );
    self endon( "weapon_change" );
    wait 0.5;
    _id_9B52( self getcurrentweapon() );
}

_id_51EE( var_0 )
{
    if ( maps\mp\_utility::iskillstreakweapon( var_0 ) )
        return 0;

    if ( var_0 == "none" )
        return 0;

    if ( maps\mp\gametypes\_class::isvalidequipment( var_0, 1 ) || maps\mp\gametypes\_class::isvalidequipment( var_0, 0 ) )
        return 0;

    if ( weaponisriotshield( var_0 ) )
        return 0;

    if ( weaponclass( var_0 ) == "ball" )
        return 0;

    return 1;
}

_id_8D34()
{
    thread _id_A248();
}

_id_4676()
{
    var_0 = self.riotshieldentity;
    var_1 = 10;
    var_2 = 50;
    var_3 = 150;
    var_4 = var_3 * var_3;
    var_5 = self.riotshieldentity.origin + ( 0.0, 0.0, -25.0 );
    self entityradiusdamage( var_5, var_3, var_2, var_1, self, "MOD_EXPLOSIVE" );
    playfx( level._effect["riot_shield_shock_fx"], var_5, anglestoforward( self.riotshieldentity.angles + ( -90.0, 0.0, 0.0 ) ) );

    foreach ( var_7 in level.players )
    {
        if ( maps\mp\_utility::isreallyalive( var_7 ) && !_func_285( var_7, self ) )
        {
            if ( distancesquared( var_5, var_7.origin ) < var_4 )
                var_7 shellshock( "concussion_grenade_mp", 1 );
        }
    }
}

_id_A248()
{
    self endon( "death" );
    self endon( "disconnect" );
    self notify( "start_riotshield_deploy" );
    self endon( "start_riotshield_deploy" );
    self waittill( "startdeploy_riotshield" );
    self playsound( "wpn_riot_shield_plant_mech" );
    self waittill( "deploy_riotshield", var_0 );

    if ( isdefined( self.riotshieldentity ) )
    {
        self.riotshieldentity thread _id_25B0();
        waitframe();
    }

    var_1 = self getcurrentweapon();
    self _meth_845D( var_1, 0 );
    var_2 = _id_A2D2( var_1 );
    self playsound( "wpn_riot_shield_plant_punch" );

    if ( var_2 )
        self playsound( "wpn_riot_shield_blast_punch" );

    var_3 = 0;

    if ( var_0 )
    {
        var_4 = self _meth_84C1();

        if ( var_4["result"] && _id_754E( var_4["origin"] ) )
        {
            var_5 = 28;
            var_6 = _id_8A03( var_4["origin"] + ( 0, 0, var_5 ), var_4["angles"] );
            var_7 = _id_8A02( var_4["origin"] + ( 0, 0, var_5 ), var_4["angles"], var_6 );
            var_8 = _func_29D( self, var_6 );
            var_9 = self getweaponslistprimaries();
            self._id_7552 = var_8;
            self.riotshieldentity = var_6;
            self._id_754D = var_7;

            if ( var_2 )
                thread _id_4676();
            else
                playfxontag( common_scripts\utility::getfx( "riot_shield_deploy_smoke" ), var_6, "tag_weapon" );

            var_6 scriptmodelplayanimdeltamotion( "npc_deployable_riotshield_stand_deploy" );
            thread _id_8A07( var_6 );
            var_10 = 0;

            if ( self._id_55C2 != "none" && self hasweapon( self._id_55C2 ) )
                self switchtoweaponimmediate( self._id_55C2 );
            else if ( var_9.size > 0 )
                self switchtoweaponimmediate( var_9[0] );
            else
                var_10 = 1;

            if ( !self hasweapon( "iw5_combatknife_mp" ) )
            {
                self giveweapon( "iw5_combatknife_mp" );
                self._id_7553 = "iw5_combatknife_mp";
            }

            if ( var_10 )
                self switchtoweaponimmediate( "iw5_combatknife_mp" );

            var_11 = spawnstruct();
            var_11.deathoverridecallback = ::_id_25B0;
            var_6 thread maps\mp\_movers::handle_moving_platforms( var_11 );
            thread _id_A208();
            thread _id_2868( self._id_7552 );
            thread _id_2869( self._id_7552, self.riotshieldentity );
            thread _id_2867( var_6 );

            if ( isdefined( var_4["entity"] ) )
                thread deleteshieldongrounddelete( var_4["entity"] );

            self.riotshieldentity thread _id_A207();
            level notify( "riotshield_planted", self );
        }
        else
        {
            var_3 = 1;
            var_12 = weaponclipsize( var_1 );
            self setweaponammoclip( var_1, var_12 );
        }
    }
    else
        var_3 = 1;

    if ( var_3 )
        self _meth_84C2();
}

_id_8A07( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    wait 0.6;
    playfxontag( common_scripts\utility::getfx( "riot_shield_deploy_lights" ), var_0, "tag_weapon" );
}

_id_754E( var_0 )
{
    var_1 = getdvarfloat( "riotshield_deploy_limit_radius" );
    var_1 *= var_1;

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3.riotshieldentity ) )
        {
            var_4 = distancesquared( var_3.riotshieldentity.origin, var_0 );

            if ( var_1 > var_4 )
                return 0;
        }
    }

    return 1;
}

_id_8A03( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0 );
    var_2.targetname = "riotshield_mp";
    var_2.angles = var_1;
    var_3 = undefined;
    var_4 = self getcurrentprimaryweapon();

    if ( weaponisriotshield( var_4 ) )
        var_3 = getweaponmodel( var_4 );

    if ( !isdefined( var_3 ) )
        var_3 = "npc_deployable_riot_shield_base";

    var_2 setmodel( var_3 );
    var_2.owner = self;
    var_2.team = self.team;
    return var_2;
}

_id_8A02( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", var_0, 1 );
    var_3.targetname = "riotshield_coll_mp";
    var_3.angles = var_1;
    var_3 setmodel( "tag_origin" );
    var_3.owner = self;
    var_3.team = self.team;
    var_3 clonebrushmodeltoscriptmodel( level._id_752A );
    var_3 disconnectpaths();
    var_3 _meth_8553( 0 );
    return var_3;
}

_id_A208()
{
    self waittill( "destroy_riotshield" );

    if ( isdefined( self._id_7552 ) )
        self._id_7552 delete();

    if ( isdefined( self._id_754D ) )
    {
        self._id_754D connectpaths();
        self._id_754D delete();
    }

    if ( isdefined( self.riotshieldentity ) )
        self.riotshieldentity delete();
}

_id_2869( var_0, var_1 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 waittill( "trigger", var_2 );
    _func_2CD( var_2, var_1 );
    self notify( "destroy_riotshield" );
}

_id_2868( var_0 )
{
    level endon( "game_ended" );
    var_0 waittill( "death" );
    self notify( "destroy_riotshield" );
}

_id_2867( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "damageThenDestroyRiotshield" );
    common_scripts\utility::waittill_any( "death", "disconnect", "remove_planted_weapons" );
    var_0 thread _id_25B0();
}

deleteshieldongrounddelete( var_0 )
{
    level endon( "game_ended" );
    var_0 common_scripts\utility::waittill_any( "death", "hidingLightingState" );
    self notify( "destroy_riotshield" );
}

_id_A207()
{
    self endon( "death" );
    var_0 = getdvarint( "riotshield_deployed_health" );
    self.damagetaken = 0;
    var_1 = 0;

    for (;;)
    {
        self.maxhealth = 100000;
        self.health = self.maxhealth;
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( !isdefined( var_3 ) )
            continue;

        if ( isplayer( var_3 ) )
        {
            if ( level.teambased && var_3.team == self.owner.team && var_3 != self.owner )
                continue;
        }

        var_12 = 0;
        var_13 = 0;

        if ( maps\mp\_utility::ismeleemod( var_6 ) )
        {
            var_12 = 1;
            var_2 *= getdvarfloat( "riotshield_melee_damage_scale" );
        }
        else if ( var_6 == "MOD_PISTOL_BULLET" || var_6 == "MOD_RIFLE_BULLET" )
        {
            var_13 = 1;
            var_2 *= getdvarfloat( "riotshield_bullet_damage_scale" );
        }
        else if ( var_6 == "MOD_GRENADE" || var_6 == "MOD_GRENADE_SPLASH" || var_6 == "MOD_EXPLOSIVE" || var_6 == "MOD_EXPLOSIVE_SPLASH" || var_6 == "MOD_PROJECTILE" || var_6 == "MOD_PROJECTILE_SPLASH" )
            var_2 *= getdvarfloat( "riotshield_explosive_damage_scale" );
        else if ( var_6 == "MOD_IMPACT" )
            var_2 *= getdvarfloat( "riotshield_projectile_damage_scale" );
        else if ( var_6 == "MOD_CRUSH" )
            var_2 = var_0;

        self.damagetaken += var_2;

        if ( self.damagetaken >= var_0 )
        {
            thread _id_25B0( var_3, var_11 );
            break;
        }
        else if ( ( var_12 || var_13 ) && gettime() >= var_1 )
        {
            var_1 = gettime() + 500;
            var_14 = 0;
            var_15 = anglestoforward( self.angles );

            if ( vectordot( var_4, var_15 ) > 0 )
                var_14 = 1;

            if ( var_12 )
            {
                if ( var_14 )
                    self scriptmodelplayanimdeltamotion( "npc_deployable_riotshield_stand_melee_back" );
                else
                    self scriptmodelplayanimdeltamotion( "npc_deployable_riotshield_stand_melee_front" );
            }
            else if ( var_14 )
                self scriptmodelplayanimdeltamotion( "npc_deployable_riotshield_stand_shot_back" );
            else
                self scriptmodelplayanimdeltamotion( "npc_deployable_riotshield_stand_shot" );
        }
    }
}

_id_25B0( var_0, var_1 )
{
    self notify( "damageThenDestroyRiotshield" );
    self endon( "death" );

    if ( isdefined( self.owner._id_7552 ) )
        self.owner._id_7552 delete();

    if ( isdefined( self.owner._id_754D ) )
    {
        self.owner._id_754D connectpaths();
        self.owner._id_754D delete();
    }

    self.owner.riotshieldentity = undefined;
    self notsolid();
    self scriptmodelplayanimdeltamotion( "npc_deployable_riotshield_stand_destroyed" );
    wait(getdvarfloat( "riotshield_destroyed_cleanup_time" ));
    self delete();
}

_id_A24A( var_0, var_1 )
{
    var_0 endon( "death" );
    common_scripts\utility::waittill_any( "damageThenDestroyRiotshield", "death", "disconnect", "weapon_change", "deploy_riotshield" );
    var_0 detonate( var_1 );
}
