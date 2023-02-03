// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level.pipes_init ) )
        return;

    level.pipes_init = 1;
    var_0 = getentarray( "pipe_shootable", "targetname" );

    if ( !var_0.size )
        return;

    level._pipes = spawnstruct();
    level._pipes.num_pipe_fx = 0;
    level._pipes.last_fx_time_ms = 0;
    var_0 thread precachefx();
    var_0 thread methodsinit();
    thread post_load( var_0 );
}

post_load( var_0 )
{
    waittillframeend;

    if ( level.createfx_enabled )
        return;

    common_scripts\utility::array_thread( var_0, ::pipesetup );
}

pipesetup()
{
    self setcandamage( 1 );
    self setcanradiusdamage( 0 );
    self.pipe_fx_array = [];
    var_0 = undefined;

    if ( isdefined( self.target ) )
    {
        var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
        self.a = var_0.origin;
        var_1 = anglestoforward( var_0.angles );
        var_1 *= 128;
        self.b = self.a + var_1;
    }
    else
    {
        var_1 = anglestoforward( self.angles );
        var_2 = var_1 * 64;
        self.a = self.origin + var_2;
        var_2 = var_1 * -64;
        self.b = self.origin + var_2;
    }

    thread pipe_wait_loop();
}

pipe_wait_loop()
{
    var_0 = ( 0, 0, 0 );
    var_1 = 0;
    var_2 = 4;

    for (;;)
    {
        self waittill( "damage", var_3, var_4, var_5, var_0, var_6 );

        if ( var_1 )
        {
            if ( randomint( 100 ) >= 67 )
                continue;
        }

        var_1 = 1;
        var_7 = pipe_logic( var_5, var_0, var_6, var_4 );

        if ( var_7 )
            var_2--;

        if ( var_2 <= 0 )
            break;
    }

    self setcandamage( 0 );
}

pipe_logic( var_0, var_1, var_2, var_3 )
{
    if ( level._pipes.num_pipe_fx > 8 )
        return 0;

    var_4 = gettime();

    if ( var_4 < level._pipes.last_fx_time_ms + 100 )
        return 0;

    if ( !isdefined( level._pipes._pipe_methods[var_2] ) )
        var_1 = pipe_calc_nofx( var_1, var_2 );
    else
        var_1 = self [[ level._pipes._pipe_methods[var_2] ]]( var_1, var_2 );

    if ( !isdefined( var_1 ) )
        return 0;

    if ( isdefined( var_3.classname ) && var_3.classname == "worldspawn" )
        return 0;

    foreach ( var_6 in self.pipe_fx_array )
    {
        if ( distancesquared( var_1, var_6.origin ) < 25 )
            return 0;
    }

    var_8 = undefined;

    if ( isai( var_3 ) )
        var_8 = var_3 geteye();
    else
        var_8 = var_3.origin;

    var_9 = var_1 - var_8;
    var_10 = undefined;

    if ( isdefined( level.pipes_use_simple_normal ) )
        var_10 = vectorfromlinetopoint( self.a, self.b, var_1 );
    else
    {
        var_11 = bullettrace( var_8, var_8 + 1.5 * var_9, 0, var_3, 0 );

        if ( isdefined( var_11["normal"] ) && isdefined( var_11["entity"] ) && var_11["entity"] == self )
            var_10 = var_11["normal"];
    }

    if ( isdefined( var_10 ) )
    {
        level._pipes.last_fx_time_ms = var_4;
        thread pipefx( var_1, var_10, var_3 );
        return 1;
    }

    return 0;
}

pipefx( var_0, var_1, var_2 )
{
    var_3 = level._pipes.fx_time[self.script_noteworthy];
    var_4 = level._pipes._pipe_fx_time[self.script_noteworthy];
    var_5 = int( var_4 / var_3 );
    var_6 = 30;
    var_7 = level._pipes._sound[self.script_noteworthy + "_hit"];
    var_8 = level._pipes._sound[self.script_noteworthy + "_loop"];
    var_9 = level._pipes._sound[self.script_noteworthy + "_end"];
    var_10 = spawn( "script_origin", var_0 );
    var_10 setmodel( "tag_origin" );
    var_10.angles = vectortoangles( var_1 );
    var_10 playsoundonmovingent( var_7 );
    var_10 playloopsound( var_8 );
    wait 0.1;
    self.pipe_fx_array[self.pipe_fx_array.size] = var_10;

    if ( common_scripts\utility::issp() || self.script_noteworthy != "steam" )
        thread pipe_damage( var_0, var_1, var_2, var_10 );

    if ( self.script_noteworthy == "oil_leak" )
    {
        var_11 = spawn( "script_model", var_0 );
        var_11 setmodel( "tag_origin" );
        var_11.angles = vectortoangles( var_1 );
        playfxontag( level._pipes._effect[self.script_noteworthy], var_11, "tag_origin" );
        level._pipes.num_pipe_fx++;
        var_11 rotatepitch( 90, var_3, 1, 1 );
        wait(var_3);
        stopfxontag( level._pipes._effect[self.script_noteworthy], var_11, "tag_origin" );
        var_5--;
    }
    else
    {
        playfxontag( level._pipes._effect[self.script_noteworthy], var_10, "tag_origin" );
        level._pipes.num_pipe_fx++;
        wait(var_3);
        var_5--;
    }

    while ( level._pipes.num_pipe_fx <= 8 && var_5 > 0 )
    {
        waittillframeend;

        if ( gettime() < level._pipes.last_fx_time_ms + 100 )
        {
            wait 0.1;
            continue;
        }

        if ( self.script_noteworthy == "oil_leak" )
        {
            var_11 = spawn( "script_model", var_0 );
            var_11 setmodel( "tag_origin" );
            var_11.angles = vectortoangles( var_1 );
            playfxontag( level._pipes._effect[self.script_noteworthy], var_11, "tag_origin" );
            level._pipes.num_pipe_fx++;
            var_11 rotatepitch( 90, var_3, 1, 1 );
            wait(var_3);
            stopfxontag( level._pipes._effect[self.script_noteworthy], var_11, "tag_origin" );
            continue;
        }

        playfxontag( level._pipes._effect[self.script_noteworthy], var_10, "tag_origin" );
        wait(var_3);
        var_5--;
    }

    var_10 playsoundonmovingent( var_9 );
    wait 0.5;
    var_10 stoploopsound( var_8 );
    var_10 delete();
    self.pipe_fx_array = common_scripts\utility::array_removeundefined( self.pipe_fx_array );
    level._pipes.num_pipe_fx--;
}

pipe_damage( var_0, var_1, var_2, var_3 )
{
    if ( !allow_pipe_damage() )
        return;

    var_3 endon( "death" );
    var_4 = var_3.origin + vectornormalize( var_1 ) * 40;
    var_5 = level._pipes._dmg[self.script_noteworthy];

    for (;;)
    {
        if ( !isdefined( self.damageowner ) )
            self radiusdamage( var_4, 36, var_5, var_5 * 0.75, undefined, "MOD_TRIGGER_HURT" );
        else
            self radiusdamage( var_4, 36, var_5, var_5 * 0.75, var_2, "MOD_TRIGGER_HURT" );

        wait 0.4;
    }
}

allow_pipe_damage()
{
    if ( !common_scripts\utility::issp() )
        return 0;

    if ( !isdefined( level.pipesdamage ) )
        return 1;

    return level.pipesdamage;
}

methodsinit()
{
    level._pipes._pipe_methods = [];
    level._pipes._pipe_methods["MOD_UNKNOWN"] = ::pipe_calc_splash;
    level._pipes._pipe_methods["MOD_PISTOL_BULLET"] = ::pipe_calc_ballistic;
    level._pipes._pipe_methods["MOD_RIFLE_BULLET"] = ::pipe_calc_ballistic;
    level._pipes._pipe_methods["MOD_GRENADE"] = ::pipe_calc_splash;
    level._pipes._pipe_methods["MOD_GRENADE_SPLASH"] = ::pipe_calc_splash;
    level._pipes._pipe_methods["MOD_PROJECTILE"] = ::pipe_calc_splash;
    level._pipes._pipe_methods["MOD_PROJECTILE_SPLASH"] = ::pipe_calc_splash;
    level._pipes._pipe_methods["MOD_TRIGGER_HURT"] = ::pipe_calc_splash;
    level._pipes._pipe_methods["MOD_EXPLOSIVE"] = ::pipe_calc_splash;
    level._pipes._pipe_methods["MOD_EXPLOSIVE_BULLET"] = ::pipe_calc_splash;
}

pipe_calc_ballistic( var_0, var_1 )
{
    return var_0;
}

pipe_calc_splash( var_0, var_1 )
{
    var_2 = vectornormalize( vectorfromlinetopoint( self.a, self.b, var_0 ) );
    var_0 = pointonsegmentnearesttopoint( self.a, self.b, var_0 );
    return var_0 + var_2 * 4;
}

pipe_calc_nofx( var_0, var_1 )
{
    return undefined;
}

precachefx()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    foreach ( var_6 in self )
    {
        if ( var_6.script_noteworthy == "water" )
            var_6.script_noteworthy = "steam";

        if ( var_6.script_noteworthy == "steam" )
        {
            var_6 willneverchange();
            var_0 = 1;
            continue;
        }

        if ( var_6.script_noteworthy == "fire" )
        {
            var_6 willneverchange();
            var_1 = 1;
            continue;
        }

        if ( var_6.script_noteworthy == "steam_small" )
        {
            var_6 willneverchange();
            var_2 = 1;
            continue;
        }

        if ( var_6.script_noteworthy == "oil_leak" )
        {
            var_6 willneverchange();
            var_3 = 1;
            continue;
        }

        if ( var_6.script_noteworthy == "oil_cap" )
        {
            var_6 willneverchange();
            var_4 = 1;
            continue;
        }
    }

    if ( var_0 )
    {
        level._pipes._effect["steam"] = loadfx( "vfx/steam/steam_pipe_impact" );
        level._pipes._sound["steam_hit"] = "mtl_steam_pipe_hit";
        level._pipes._sound["steam_loop"] = "mtl_steam_pipe_hiss_loop";
        level._pipes._sound["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
        level._pipes.fx_time["steam"] = 3;
        level._pipes._dmg["steam"] = 5;
        level._pipes._pipe_fx_time["steam"] = 25;
    }

    if ( var_2 )
    {
        level._pipes._effect["steam_small"] = loadfx( "vfx/steam/steam_pipe_impact_sml" );
        level._pipes._sound["steam_small_hit"] = "mtl_steam_pipe_hit";
        level._pipes._sound["steam_small_loop"] = "mtl_steam_pipe_hiss_loop";
        level._pipes._sound["steam_small_end"] = "mtl_steam_pipe_hiss_loop_end";
        level._pipes.fx_time["steam_small"] = 3;
        level._pipes._dmg["steam_small"] = 5;
        level._pipes._pipe_fx_time["steam_small"] = 25;
    }

    if ( var_1 )
    {
        level._pipes._effect["fire"] = loadfx( "vfx/fire/mp_pipe_gas_fire_leak_runner" );
        level._pipes._sound["fire_hit"] = "mtl_gas_pipe_hit";
        level._pipes._sound["fire_loop"] = "mtl_gas_pipe_flame_loop";
        level._pipes._sound["fire_end"] = "mtl_gas_pipe_flame_end";
        level._pipes.fx_time["fire"] = 3;
        level._pipes._dmg["fire"] = 5;
        level._pipes._pipe_fx_time["fire"] = 25;
    }

    if ( var_3 )
    {
        level._pipes._effect["oil_leak"] = loadfx( "fx/impacts/pipe_oil_barrel_spill" );
        level._pipes._sound["oil_leak_hit"] = "mtl_oil_barrel_hit";
        level._pipes._sound["oil_leak_loop"] = "mtl_oil_barrel_hiss_loop";
        level._pipes._sound["oil_leak_end"] = "mtl_oil_barrel_hiss_loop_end";
        level._pipes.fx_time["oil_leak"] = 6;
        level._pipes._pipe_fx_time["oil_leak"] = 6;
        level._pipes._dmg["oil_leak"] = 5;
    }

    if ( var_4 )
    {
        level._pipes._effect["oil_cap"] = loadfx( "fx/impacts/pipe_oil_barrel_squirt" );
        level._pipes._sound["oil_cap_hit"] = "mtl_steam_pipe_hit";
        level._pipes._sound["oil_cap_loop"] = "mtl_steam_pipe_hiss_loop";
        level._pipes._sound["oil_cap_end"] = "mtl_steam_pipe_hiss_loop_end";
        level._pipes.fx_time["oil_cap"] = 3;
        level._pipes._dmg["oil_cap"] = 5;
        level._pipes._pipe_fx_time["oil_cap"] = 5;
    }
}
