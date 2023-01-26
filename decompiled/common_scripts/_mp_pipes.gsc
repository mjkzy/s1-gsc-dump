// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level._id_682A ) )
        return;

    level._id_682A = 1;
    var_0 = getentarray( "pipe_shootable", "targetname" );

    if ( !var_0.size )
        return;

    level._id_0610 = spawnstruct();
    level._id_0610._id_6286 = 0;
    level._id_0610.last_fx_time_ms = 0;
    var_0 thread _id_6ED8();
    var_0 thread _id_5BBB();
    thread _id_6E76( var_0 );
}

_id_6E76( var_0 )
{
    waittillframeend;

    if ( level.createfx_enabled )
        return;

    common_scripts\utility::array_thread( var_0, ::_id_682C );
}

_id_682C()
{
    self setcandamage( 1 );
    self setcanradiusdamage( 0 );
    self._id_6826 = [];
    var_0 = undefined;

    if ( isdefined( self.target ) )
    {
        var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
        self._id_0007 = var_0.origin;
        var_1 = anglestoforward( var_0.angles );
        var_1 *= 128;
        self._id_0061 = self._id_0007 + var_1;
    }
    else
    {
        var_1 = anglestoforward( self.angles );
        var_2 = var_1 * 64;
        self._id_0007 = self.origin + var_2;
        var_2 = var_1 * -64;
        self._id_0061 = self.origin + var_2;
    }

    thread _id_6828();
}

_id_6828()
{
    var_0 = ( 0.0, 0.0, 0.0 );
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
        var_7 = _id_6827( var_5, var_0, var_6, var_4 );

        if ( var_7 )
            var_2--;

        if ( var_2 <= 0 )
            break;
    }

    self setcandamage( 0 );
}

_id_6827( var_0, var_1, var_2, var_3 )
{
    if ( level._id_0610._id_6286 > 8 )
        return 0;

    var_4 = gettime();

    if ( var_4 < level._id_0610.last_fx_time_ms + 100 )
        return 0;

    if ( !isdefined( level._id_0610._id_060F[var_2] ) )
        var_1 = _id_6823( var_1, var_2 );
    else
        var_1 = self [[ level._id_0610._id_060F[var_2] ]]( var_1, var_2 );

    if ( !isdefined( var_1 ) )
        return 0;

    if ( isdefined( var_3.classname ) && var_3.classname == "worldspawn" )
        return 0;

    foreach ( var_6 in self._id_6826 )
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
        var_10 = vectorfromlinetopoint( self._id_0007, self._id_0061, var_1 );
    else
    {
        var_11 = bullettrace( var_8, var_8 + 1.5 * var_9, 0, var_3, 0 );

        if ( isdefined( var_11["normal"] ) && isdefined( var_11["entity"] ) && var_11["entity"] == self )
            var_10 = var_11["normal"];
    }

    if ( isdefined( var_10 ) )
    {
        level._id_0610.last_fx_time_ms = var_4;
        thread _id_6829( var_1, var_10, var_3 );
        return 1;
    }

    return 0;
}

_id_6829( var_0, var_1, var_2 )
{
    var_3 = level._id_0610._id_3B8B[self.script_noteworthy];
    var_4 = level._id_0610._id_060E[self.script_noteworthy];
    var_5 = int( var_4 / var_3 );
    var_6 = 30;
    var_7 = level._id_0610._id_0662[self.script_noteworthy + "_hit"];
    var_8 = level._id_0610._id_0662[self.script_noteworthy + "_loop"];
    var_9 = level._id_0610._id_0662[self.script_noteworthy + "_end"];
    var_10 = spawn( "script_origin", var_0 );
    var_10 setmodel( "tag_origin" );
    var_10.angles = vectortoangles( var_1 );
    var_10 _meth_8438( var_7 );
    var_10 playloopsound( var_8 );
    wait 0.1;
    self._id_6826[self._id_6826.size] = var_10;

    if ( common_scripts\utility::issp() || self.script_noteworthy != "steam" )
        thread _id_6825( var_0, var_1, var_2, var_10 );

    if ( self.script_noteworthy == "oil_leak" )
    {
        var_11 = spawn( "script_model", var_0 );
        var_11 setmodel( "tag_origin" );
        var_11.angles = vectortoangles( var_1 );
        playfxontag( level._id_0610._effect[self.script_noteworthy], var_11, "tag_origin" );
        level._id_0610._id_6286++;
        var_11 _meth_82B6( 90, var_3, 1, 1 );
        wait(var_3);
        stopfxontag( level._id_0610._effect[self.script_noteworthy], var_11, "tag_origin" );
        var_5--;
    }
    else
    {
        playfxontag( level._id_0610._effect[self.script_noteworthy], var_10, "tag_origin" );
        level._id_0610._id_6286++;
        wait(var_3);
        var_5--;
    }

    while ( level._id_0610._id_6286 <= 8 && var_5 > 0 )
    {
        waittillframeend;

        if ( gettime() < level._id_0610.last_fx_time_ms + 100 )
        {
            wait 0.1;
            continue;
        }

        if ( self.script_noteworthy == "oil_leak" )
        {
            var_11 = spawn( "script_model", var_0 );
            var_11 setmodel( "tag_origin" );
            var_11.angles = vectortoangles( var_1 );
            playfxontag( level._id_0610._effect[self.script_noteworthy], var_11, "tag_origin" );
            level._id_0610._id_6286++;
            var_11 _meth_82B6( 90, var_3, 1, 1 );
            wait(var_3);
            stopfxontag( level._id_0610._effect[self.script_noteworthy], var_11, "tag_origin" );
            continue;
        }

        playfxontag( level._id_0610._effect[self.script_noteworthy], var_10, "tag_origin" );
        wait(var_3);
        var_5--;
    }

    var_10 _meth_8438( var_9 );
    wait 0.5;
    var_10 stoploopsound( var_8 );
    var_10 delete();
    self._id_6826 = common_scripts\utility::array_removeundefined( self._id_6826 );
    level._id_0610._id_6286--;
}

_id_6825( var_0, var_1, var_2, var_3 )
{
    if ( !_id_0A97() )
        return;

    var_3 endon( "death" );
    var_4 = var_3.origin + vectornormalize( var_1 ) * 40;
    var_5 = level._id_0610._id_058B[self.script_noteworthy];

    for (;;)
    {
        if ( !isdefined( self._id_25A8 ) )
            self entityradiusdamage( var_4, 36, var_5, var_5 * 0.75, undefined, "MOD_TRIGGER_HURT" );
        else
            self entityradiusdamage( var_4, 36, var_5, var_5 * 0.75, var_2, "MOD_TRIGGER_HURT" );

        wait 0.4;
    }
}

_id_0A97()
{
    if ( !common_scripts\utility::issp() )
        return 0;

    if ( !isdefined( level._id_682B ) )
        return 1;

    return level._id_682B;
}

_id_5BBB()
{
    level._id_0610._id_060F = [];
    level._id_0610._id_060F["MOD_UNKNOWN"] = ::_id_6824;
    level._id_0610._id_060F["MOD_PISTOL_BULLET"] = ::_id_6822;
    level._id_0610._id_060F["MOD_RIFLE_BULLET"] = ::_id_6822;
    level._id_0610._id_060F["MOD_GRENADE"] = ::_id_6824;
    level._id_0610._id_060F["MOD_GRENADE_SPLASH"] = ::_id_6824;
    level._id_0610._id_060F["MOD_PROJECTILE"] = ::_id_6824;
    level._id_0610._id_060F["MOD_PROJECTILE_SPLASH"] = ::_id_6824;
    level._id_0610._id_060F["MOD_TRIGGER_HURT"] = ::_id_6824;
    level._id_0610._id_060F["MOD_EXPLOSIVE"] = ::_id_6824;
    level._id_0610._id_060F["MOD_EXPLOSIVE_BULLET"] = ::_id_6824;
}

_id_6822( var_0, var_1 )
{
    return var_0;
}

_id_6824( var_0, var_1 )
{
    var_2 = vectornormalize( vectorfromlinetopoint( self._id_0007, self._id_0061, var_0 ) );
    var_0 = pointonsegmentnearesttopoint( self._id_0007, self._id_0061, var_0 );
    return var_0 + var_2 * 4;
}

_id_6823( var_0, var_1 )
{
    return undefined;
}

_id_6ED8()
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
        level._id_0610._effect["steam"] = loadfx( "vfx/steam/steam_pipe_impact" );
        level._id_0610._id_0662["steam_hit"] = "mtl_steam_pipe_hit";
        level._id_0610._id_0662["steam_loop"] = "mtl_steam_pipe_hiss_loop";
        level._id_0610._id_0662["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
        level._id_0610._id_3B8B["steam"] = 3;
        level._id_0610._id_058B["steam"] = 5;
        level._id_0610._id_060E["steam"] = 25;
    }

    if ( var_2 )
    {
        level._id_0610._effect["steam_small"] = loadfx( "vfx/steam/steam_pipe_impact_sml" );
        level._id_0610._id_0662["steam_small_hit"] = "mtl_steam_pipe_hit";
        level._id_0610._id_0662["steam_small_loop"] = "mtl_steam_pipe_hiss_loop";
        level._id_0610._id_0662["steam_small_end"] = "mtl_steam_pipe_hiss_loop_end";
        level._id_0610._id_3B8B["steam_small"] = 3;
        level._id_0610._id_058B["steam_small"] = 5;
        level._id_0610._id_060E["steam_small"] = 25;
    }

    if ( var_1 )
    {
        level._id_0610._effect["fire"] = loadfx( "vfx/fire/mp_pipe_gas_fire_leak_runner" );
        level._id_0610._id_0662["fire_hit"] = "mtl_gas_pipe_hit";
        level._id_0610._id_0662["fire_loop"] = "mtl_gas_pipe_flame_loop";
        level._id_0610._id_0662["fire_end"] = "mtl_gas_pipe_flame_end";
        level._id_0610._id_3B8B["fire"] = 3;
        level._id_0610._id_058B["fire"] = 5;
        level._id_0610._id_060E["fire"] = 25;
    }

    if ( var_3 )
    {
        level._id_0610._effect["oil_leak"] = loadfx( "fx/impacts/pipe_oil_barrel_spill" );
        level._id_0610._id_0662["oil_leak_hit"] = "mtl_oil_barrel_hit";
        level._id_0610._id_0662["oil_leak_loop"] = "mtl_oil_barrel_hiss_loop";
        level._id_0610._id_0662["oil_leak_end"] = "mtl_oil_barrel_hiss_loop_end";
        level._id_0610._id_3B8B["oil_leak"] = 6;
        level._id_0610._id_060E["oil_leak"] = 6;
        level._id_0610._id_058B["oil_leak"] = 5;
    }

    if ( var_4 )
    {
        level._id_0610._effect["oil_cap"] = loadfx( "fx/impacts/pipe_oil_barrel_squirt" );
        level._id_0610._id_0662["oil_cap_hit"] = "mtl_steam_pipe_hit";
        level._id_0610._id_0662["oil_cap_loop"] = "mtl_steam_pipe_hiss_loop";
        level._id_0610._id_0662["oil_cap_end"] = "mtl_steam_pipe_hiss_loop_end";
        level._id_0610._id_3B8B["oil_cap"] = 3;
        level._id_0610._id_058B["oil_cap"] = 5;
        level._id_0610._id_060E["oil_cap"] = 5;
    }
}
