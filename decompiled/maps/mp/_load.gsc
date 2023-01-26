// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level._id_05E5 ) )
        return;

    level._id_05E5 = 1;
    level.virtuallobbyactive = getdvarint( "virtualLobbyActive", 0 );
    maps\mp\_utility::set_console_status();
    level.createfx_enabled = getdvar( "createfx" ) != "";
    common_scripts\utility::struct_class_init();
    maps\mp\_utility::initgameflags();
    maps\mp\_utility::initlevelflags();
    maps\mp\_utility::initglobals();
    level.generic_index = 0;
    level.flag_struct = spawnstruct();
    level.flag_struct common_scripts\utility::assign_unique_id();

    if ( !isdefined( level.flag ) )
    {
        level.flag = [];
        level.flags_lock = [];
    }

    level._id_7409 = getdvarfloat( "scr_RequiredMapAspectratio", 1 );
    level._id_23EE = maps\mp\gametypes\_hud_util::createfontstring;
    level._id_4AFA = maps\mp\gametypes\_hud_util::setpoint;
    level.leaderdialogonplayer_func = maps\mp\_utility::leaderdialogonplayer;
    thread maps\mp\gametypes\_tweakables::init();

    if ( !isdefined( level.func ) )
        level.func = [];

    level.func["precacheMpAnim"] = ::map_restart;
    level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
    level.func["scriptModelClearAnim"] = ::_meth_827A;

    if ( !level.createfx_enabled )
    {
        thread maps\mp\_movers::init();
        thread maps\mp\_shutter::main();
        thread maps\mp\_destructables::init();
        thread _id_A4EC::init();
        thread maps\mp\_dynamic_world::init();
        thread common_scripts\_destructible::init();
    }

    game["thermal_vision"] = "default";
    visionsetnaked( "", 0 );
    visionsetnight( "default_night_mp" );
    visionsetmissilecam( "orbital_strike" );
    visionsetthermal( game["thermal_vision"] );
    visionsetpain( "near_death_mp", 0 );
    var_0 = getentarray( "lantern_glowFX_origin", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] thread _id_54BA();

    maps\mp\_audio::_id_4CB3();
    maps\mp\_art::main();
    _id_830D();
    thread _id_A4EE::_id_4DBC();

    if ( level.createfx_enabled )
    {
        maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
        maps\mp\_createfx::_id_2402();
    }

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
    {
        _id_284C();
        maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
        maps\mp\_global_fx::main();
        level waittill( "eternity" );
    }

    thread maps\mp\_global_fx::main();

    for ( var_2 = 0; var_2 < 6; var_2++ )
    {
        switch ( var_2 )
        {
            case 0:
                var_3 = "trigger_multiple";
                break;
            case 1:
                var_3 = "trigger_once";
                break;
            case 2:
                var_3 = "trigger_use";
                break;
            case 3:
                var_3 = "trigger_radius";
                break;
            case 4:
                var_3 = "trigger_lookat";
                break;
            default:
                var_3 = "trigger_damage";
                break;
        }

        var_4 = getentarray( var_3, "classname" );

        for ( var_1 = 0; var_1 < var_4.size; var_1++ )
        {
            if ( isdefined( var_4[var_1]._id_7AA0 ) )
                var_4[var_1].script_exploder = var_4[var_1]._id_7AA0;

            if ( isdefined( var_4[var_1].script_exploder ) )
                level thread _id_352D( var_4[var_1] );
        }
    }

    var_5 = getentarray( "trigger_hurt", "classname" );

    foreach ( var_7 in var_5 )
    {
        if ( isdefined( level.hurttriggerfunc ) )
        {
            var_7 thread [[ level.hurttriggerfunc ]]();
            continue;
        }

        var_7 thread _id_4B09();
    }

    thread maps\mp\_animatedmodels::main();
    level.func["damagefeedback"] = maps\mp\gametypes\_damagefeedback::updatedamagefeedback;
    level.func["setTeamHeadIcon"] = maps\mp\_entityheadicons::setteamheadicon;
    level._id_54F9 = ::laseron;
    level._id_54F6 = ::laseroff;
    level._id_214E = ::connectpaths;
    level._id_2B38 = ::disconnectpaths;
    setdvar( "sm_spotLightScoreModelScale", 0.1 );
    setdvar( "sm_spotShadowFadeTime", 1.0 );
    setdvar( "r_specularcolorscale", 2.5 );
    setdvar( "r_diffusecolorscale", 1 );
    setdvar( "r_lightGridEnableTweaks", 0 );
    setdvar( "r_lightGridIntensity", 1 );
    setdvar( "r_lightGridContrast", 0 );
    setdvar( "r_dof_physical_enable", 1 );
    setdvar( "r_volumeLightScatter", 0 );
    setdvar( "r_uiblurdstmode", 0 );
    setdvar( "r_blurdstgaussianblurradius", 1 );
    setdvar( "r_dof_physical_bokehEnable", 0 );

    if ( level.nextgen )
        setdvar( "sm_polygonOffsetPreset", 0 );

    _id_8308();

    if ( level.virtuallobbyactive == 0 && !( isdefined( level.iszombiegame ) && level.iszombiegame ) )
        precacheitem( "bomb_site_mp" );

    level.fauxvehiclecount = 0;
    _id_57BF();
}

_id_352D( var_0 )
{
    level endon( "killexplodertridgers" + var_0.script_exploder );
    var_0 waittill( "trigger" );

    if ( isdefined( var_0._id_796A ) && randomfloat( 1 ) > var_0._id_796A )
    {
        if ( isdefined( var_0.script_delay ) )
            wait(var_0.script_delay);
        else
            wait 4;

        level thread _id_352D( var_0 );
        return;
    }

    common_scripts\_exploder::exploder( var_0.script_exploder );
    level notify( "killexplodertridgers" + var_0.script_exploder );
}

_id_830D()
{
    var_0 = getentarray( "script_brushmodel", "classname" );
    var_1 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_0[var_0.size] = var_1[var_2];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( isdefined( var_0[var_2]._id_7AA0 ) )
            var_0[var_2].script_exploder = var_0[var_2]._id_7AA0;

        if ( isdefined( var_0[var_2].script_exploder ) )
        {
            if ( var_0[var_2].model == "fx" && ( !isdefined( var_0[var_2].targetname ) || var_0[var_2].targetname != "exploderchunk" ) )
            {
                var_0[var_2] hide();
                continue;
            }

            if ( isdefined( var_0[var_2].targetname ) && var_0[var_2].targetname == "exploder" )
            {
                var_0[var_2] hide();
                var_0[var_2] notsolid();
                continue;
            }

            if ( isdefined( var_0[var_2].targetname ) && var_0[var_2].targetname == "exploderchunk" )
            {
                var_0[var_2] hide();
                var_0[var_2] notsolid();
            }
        }
    }

    var_3 = [];
    var_4 = getentarray( "script_brushmodel", "classname" );

    for ( var_2 = 0; var_2 < var_4.size; var_2++ )
    {
        if ( isdefined( var_4[var_2]._id_7AA0 ) )
            var_4[var_2].script_exploder = var_4[var_2]._id_7AA0;

        if ( isdefined( var_4[var_2].script_exploder ) )
            var_3[var_3.size] = var_4[var_2];
    }

    var_4 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_4.size; var_2++ )
    {
        if ( isdefined( var_4[var_2]._id_7AA0 ) )
            var_4[var_2].script_exploder = var_4[var_2]._id_7AA0;

        if ( isdefined( var_4[var_2].script_exploder ) )
            var_3[var_3.size] = var_4[var_2];
    }

    var_4 = getentarray( "item_health", "classname" );

    for ( var_2 = 0; var_2 < var_4.size; var_2++ )
    {
        if ( isdefined( var_4[var_2]._id_7AA0 ) )
            var_4[var_2].script_exploder = var_4[var_2]._id_7AA0;

        if ( isdefined( var_4[var_2].script_exploder ) )
            var_3[var_3.size] = var_4[var_2];
    }

    if ( !isdefined( level._id_2417 ) )
        level._id_2417 = [];

    var_5 = [];
    var_5["exploderchunk visible"] = 1;
    var_5["exploderchunk"] = 1;
    var_5["exploder"] = 1;

    for ( var_2 = 0; var_2 < var_3.size; var_2++ )
    {
        var_6 = var_3[var_2];
        var_7 = common_scripts\utility::createexploder( var_6._id_79EC );
        var_7.v = [];
        var_7.v["origin"] = var_6.origin;
        var_7.v["angles"] = var_6.angles;
        var_7.v["delay"] = var_6.script_delay;
        var_7.v["firefx"] = var_6._id_79C6;
        var_7.v["firefxdelay"] = var_6._id_79C7;
        var_7.v["firefxsound"] = var_6._id_79C8;
        var_7.v["firefxtimeout"] = var_6._id_79C9;
        var_7.v["earthquake"] = var_6._id_79B0;
        var_7.v["damage"] = var_6._id_797C;
        var_7.v["damage_radius"] = var_6._id_7AAC;
        var_7.v["soundalias"] = var_6._id_7AC5;
        var_7.v["repeat"] = var_6._id_7AB0;
        var_7.v["delay_min"] = var_6._id_7989;
        var_7.v["delay_max"] = var_6._id_7988;
        var_7.v["target"] = var_6.target;
        var_7.v["ender"] = var_6._id_79B3;
        var_7.v["type"] = "exploder";

        if ( !isdefined( var_6._id_79EC ) )
            var_7.v["fxid"] = "No FX";
        else
            var_7.v["fxid"] = var_6._id_79EC;

        var_7.v["exploder"] = var_6.script_exploder;

        if ( !isdefined( var_7.v["delay"] ) )
            var_7.v["delay"] = 0;

        if ( isdefined( var_6.target ) )
        {
            var_8 = getentarray( var_7.v["target"], "targetname" )[0];

            if ( isdefined( var_8 ) )
            {
                var_9 = var_8.origin;
                var_7.v["angles"] = vectortoangles( var_9 - var_7.v["origin"] );
            }
            else
            {
                var_8 = common_scripts\utility::get_target_ent( var_7.v["target"] );

                if ( isdefined( var_8 ) )
                {
                    var_9 = var_8.origin;
                    var_7.v["angles"] = vectortoangles( var_9 - var_7.v["origin"] );
                }
            }
        }

        if ( var_6.classname == "script_brushmodel" || isdefined( var_6.model ) )
        {
            var_7.model = var_6;
            var_7.model._id_2B33 = var_6._id_799B;
        }

        if ( isdefined( var_6.targetname ) && isdefined( var_5[var_6.targetname] ) )
            var_7.v["exploder_type"] = var_6.targetname;
        else
            var_7.v["exploder_type"] = "normal";

        var_7 common_scripts\_createfx::_id_6E6A();
    }
}

_id_54BA()
{
    _id_A4EE::_id_5879( "lantern_light", self.origin, 0.3, self.origin + ( 0.0, 0.0, 1.0 ) );
}

_id_4B09()
{
    level endon( "game_ended" );
    wait(randomfloat( 1.0 ));

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( var_1 istouching( self ) && maps\mp\_utility::isreallyalive( var_1 ) )
                var_1 maps\mp\_utility::_suicide();
        }

        wait 0.5;
    }
}

_id_8308()
{
    var_0 = getentarray( "destructible_vehicle", "targetname" );

    foreach ( var_2 in var_0 )
    {
        switch ( getdvar( "mapname" ) )
        {
            case "mp_interchange":
                if ( var_2.origin[2] > 150.0 )
                    continue;

                break;
        }

        var_3 = var_2.origin + ( 0.0, 0.0, 5.0 );
        var_4 = var_2.origin + ( 0.0, 0.0, 128.0 );
        var_5 = bullettrace( var_3, var_4, 0, var_2 );
        var_2.killcament = spawn( "script_model", var_5["position"] );
        var_2.killcament.targetname = "killCamEnt_destructible_vehicle";
        var_2.killcament setscriptmoverkillcam( "explosive" );
        var_2 thread _id_284B();
    }

    var_7 = getentarray( "destructible_toy", "targetname" );

    foreach ( var_2 in var_7 )
    {
        var_3 = var_2.origin + ( 0.0, 0.0, 5.0 );
        var_4 = var_2.origin + ( 0.0, 0.0, 128.0 );
        var_5 = bullettrace( var_3, var_4, 0, var_2 );
        var_2.killcament = spawn( "script_model", var_5["position"] );
        var_2.killcament.targetname = "killCamEnt_destructible_toy";
        var_2.killcament setscriptmoverkillcam( "explosive" );
        var_2 thread _id_284B();
    }

    var_10 = getentarray( "explodable_barrel", "targetname" );

    foreach ( var_2 in var_10 )
    {
        var_3 = var_2.origin + ( 0.0, 0.0, 5.0 );
        var_4 = var_2.origin + ( 0.0, 0.0, 128.0 );
        var_5 = bullettrace( var_3, var_4, 0, var_2 );
        var_2.killcament = spawn( "script_model", var_5["position"] );
        var_2.killcament.targetname = "killCamEnt_explodable_barrel";
        var_2.killcament setscriptmoverkillcam( "explosive" );
        var_2 thread _id_284B();
    }
}

_id_284B()
{
    level endon( "game_ended" );
    var_0 = self.killcament;
    var_0 endon( "death" );
    self waittill( "death" );
    wait 10;

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_id_284C()
{
    var_0 = getentarray( "boost_jump_border", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    var_0 = getentarray( "mp_recovery_signage", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    var_6 = getentarray( "horde_dome", "targetname" );

    foreach ( var_8 in var_6 )
        var_8 delete();

    var_10 = getentarray( "hp_zone_center", "targetname" );

    foreach ( var_12 in var_10 )
    {
        if ( isdefined( var_12.target ) )
        {
            var_0 = getentarray( var_12.target, "targetname" );

            foreach ( var_2 in var_0 )
                var_2 delete();
        }
    }

    var_16 = getentarray( "orbital_bad_spawn_overlay", "targetname" );

    foreach ( var_18 in var_16 )
        var_18 delete();
}

_id_57BF()
{
    if ( isdefined( level.costumecategories ) )
        return;

    level.costumecategories = [ "gender", "shirt", "head", "pants", "gloves", "shoes", "kneepads", "gear", "hat", "eyewear", "exo" ];
    level._id_2238 = [];

    for ( var_0 = 0; var_0 < level.costumecategories.size; var_0++ )
    {
        var_1 = level.costumecategories[var_0];
        level._id_2238[var_1] = var_0;
    }

    level.costumetypehexids = [];
    level.costumetypehexids["gender"] = "0x61";
    level.costumetypehexids["shirt"] = "0x62";
    level.costumetypehexids["head"] = "0x63";
    level.costumetypehexids["pants"] = "0x64";
    level.costumetypehexids["gloves"] = "0x69";
    level.costumetypehexids["shoes"] = "0x6a";
    level.costumetypehexids["kneepads"] = "0x68";
    level.costumetypehexids["gear"] = "0x67";
    level.costumetypehexids["hat"] = "0x66";
    level.costumetypehexids["eyewear"] = "0x6c";
    level.costumetypehexids["exo"] = "0x6b";
}
