// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_prison_precache::main();
    maps\createart\mp_prison_art::main();
    maps\mp\mp_prison_fx::main();
    maps\mp\mp_prison_lighting::main();
    maps\mp\_load::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_prison" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.mapcustomkillstreakfunc = ::prisoncustomkillstreakfunc;
    level.orbitalsupportoverridefunc = ::prisonpaladinoverrides;
    thread goliathvolumes();
    level.dronevisionset = "mp_instinct_osp";
    level.dronelightset = "mp_prison_drone";
    thread ambientanimation();
}

goliathvolumes()
{
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
}

prisoncustomkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_prison::init();
}

set_lighting_values()
{
    if ( isusinghdr() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0" );
        }
    }
}

prisonpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnheight = 7500;
    level.orbitalsupportoverrides.spawnradius = 4500;
    level.orbitalsupportoverrides.leftarc = 40;
    level.orbitalsupportoverrides.rightarc = 40;
    level.orbitalsupportoverrides.toparc = -38;
    level.orbitalsupportoverrides.bottomarc = 78;
}

ambientanimation()
{
    var_0 = getentarray( "guard_tower_radar", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread rotateradar();
}

rotateradar()
{
    if ( !isdefined( level.rotatetime ) )
        level.rotatetime = 20;

    for (;;)
    {
        self rotatevelocity( ( 0, -100, 0 ), level.rotatetime );
        wait(level.rotatetime);
    }
}

setupriotsuppresionsystem()
{
    precachelocationselector( "map_artillery_selector" );
    precachestring( &"KILLSTREAKS_MP_PRISON" );
    precacheshellshock( "mp_prison_gas" );
    level.gasedvisionset = "mp_prison_gas";
    level.gas_alarm_sfx_alias = "mp_prison_gas_on_siren";
    level.gate_spark_fx = "gate_sparks";
    level._effect[level.gate_spark_fx] = loadfx( "vfx/sparks/electrical_sparks_oneshot" );
    var_0 = getentarray( "gas_trigger", "targetname" );
    thread gasfieldsoff();

    if ( var_0.size > 0 )
    {
        precacheshellshock( "mp_prison_gas" );

        foreach ( var_2 in var_0 )
            var_2 thread common_scripts\_dynamic_world::triggertouchthink( ::playerenterarea, ::playerleavearea );

        thread onplayerconnect();
    }

    thread gasvisualssetup();
    thread setupgates();
    thread monitorriotsuppressionsystem();
}

monitorriotsuppressionsystem()
{
    level endon( "debug_mp_prison_gas" );
    level.dynamiceventcount = 3;
    var_0 = 2;
    var_1 = maps\mp\_utility::gettimelimit();
    var_2 = gettime() + var_0 * 1000;
    var_3 = var_1 / level.dynamiceventcount * 60 * 1000;

    for ( var_4 = 1; var_4 < level.dynamiceventcount; var_4++ )
    {
        if ( var_1 > 0 )
            var_2 = gettime() + var_3;
        else
            var_2 = gettime() + var_0 * 1000;

        while ( gettime() < var_2 )
            wait 1;

        startriotsuppressionsystem();
    }
}

startriotsuppressionsystem()
{
    var_0 = 20;
    thread gasvisualswarningstart();
    thread movegates();
    thread rotategates();
    thread rotategatesconstant();
    thread gas_alarm_on_vo();
    wait 5;
    thread gasvisualsstart();
    thread aud_gas_sfx();
    gasfieldson();
    wait(var_0);
    level notify( "stop_gas_sfx" );
    thread resetgates();
    thread resetrotategates();
    thread resetrotategateconstant();
    thread gas_alarm_off_vo();
    gasfieldsoff();
}

aud_gas_sfx()
{
    var_0 = ( -2666, 1305, 828 );
    var_1 = ( -2282, 1305, 840 );
    var_2 = ( -2026, 1305, 840 );
    var_3 = ( -1557, 1305, 840 );
    var_4 = ( -1512, 903, 840 );
    var_5 = ( -2024, 903, 840 );
    var_6 = ( -2411, 903, 840 );
    var_7 = ( -2666, 903, 840 );
    var_8 = [ var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 ];

    foreach ( var_10 in var_8 )
    {
        thread maps\mp\_audio::snd_play_in_space( "mp_prison_gas_valve_start", var_10 );
        thread maps\mp\_audio::snd_play_loop_in_space( "mp_prison_gas_lp", var_10, "stop_gas_sfx", 2.2 );
    }
}

gas_alarm_on_vo()
{
    var_0 = spawn( "script_origin", ( -2143, 1108, 946 ) );
    var_0 playsound( "mp_prison_gas_on" );
}

gas_alarm_off_vo()
{
    var_0 = spawn( "script_origin", ( -2143, 1108, 946 ) );
    var_0 playsound( "mp_prison_gas_off_02" );
}

gasvisualssetup()
{
    if ( !isdefined( level.mp_prison_killstreak ) )
        level.mp_prison_killstreak = spawnstruct();

    if ( !isdefined( level.mp_prison_killstreak.gas_tags ) )
    {
        var_0 = common_scripts\utility::getstructarray( "gas_org", "targetname" );
        level.mp_prison_killstreak.gas_tags = [];

        foreach ( var_2 in var_0 )
        {
            var_3 = var_2 common_scripts\utility::spawn_tag_origin();
            var_3 show();
            level.mp_prison_killstreak.gas_tags[level.mp_prison_killstreak.gas_tags.size] = var_3;
        }
    }

    if ( !isdefined( level.mp_prison_killstreak.gas_warning_light_tags ) )
    {
        var_0 = common_scripts\utility::getstructarray( "flashing_red_light", "targetname" );
        level.mp_prison_killstreak.gas_warning_light_tags = [];

        foreach ( var_2 in var_0 )
        {
            var_3 = var_2 common_scripts\utility::spawn_tag_origin();
            var_3 show();
            level.mp_prison_killstreak.gas_warning_light_tags[level.mp_prison_killstreak.gas_warning_light_tags.size] = var_3;
        }
    }
}

gasvisualswarningstart()
{
    foreach ( var_1 in level.mp_prison_killstreak.gas_warning_light_tags )
        var_1 thread playloopingsoundonorigin();

    activateclientexploder( 10 );
}

setupgates()
{
    var_0 = getentarray( "moving_gate", "targetname" );
    level.mp_prison_killstreak.gates = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_2.originalpos = var_2.origin;
        var_3.gate = var_2;
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        var_3.dest = var_4;
        var_5 = getent( var_4.target, "targetname" );
        var_5.originalpos = var_5.origin;
        var_3.collision = var_5;
        var_6 = common_scripts\utility::getstruct( var_5.target, "targetname" );
        var_7 = var_6 common_scripts\utility::spawn_tag_origin();
        var_7 show();
        var_7 linkto( var_2 );
        var_8 = common_scripts\utility::getstruct( var_6.target, "targetname" );
        var_9 = var_8 common_scripts\utility::spawn_tag_origin();
        var_9 show();
        var_9 linkto( var_2 );
        var_3.sparks = [ var_7, var_9 ];
        level.mp_prison_killstreak.gates[level.mp_prison_killstreak.gates.size] = var_3;
    }

    var_0 = getentarray( "rotating_gate", "targetname" );
    level.mp_prison_killstreak.rotating_gates = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_2.originalpos = var_2.origin;
        var_2.originalrot = var_2.angles;
        var_3.gate = var_2;
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        var_3.dest = var_4;
        var_5 = getent( var_4.target, "targetname" );
        var_5.originalpos = var_5.origin;
        var_5.angles = var_2.angles + ( 0, -90, 0 );
        var_5.originalrot = var_5.angles;
        var_3.collision = var_5;
        var_6 = common_scripts\utility::getstruct( var_5.target, "targetname" );
        var_7 = var_6 common_scripts\utility::spawn_tag_origin();
        var_7 show();
        var_7 linkto( var_2 );
        var_8 = common_scripts\utility::getstruct( var_6.target, "targetname" );
        var_9 = var_8 common_scripts\utility::spawn_tag_origin();
        var_9 show();
        var_9 linkto( var_2 );
        var_3.sparks = [ var_7, var_9 ];

        if ( isdefined( var_8.target ) )
        {
            var_12 = getent( var_8.target, "targetname" );
            var_3.kill_vol = var_12;
            var_3.kill_vol common_scripts\utility::trigger_off_proc();
        }

        level.mp_prison_killstreak.rotating_gates[level.mp_prison_killstreak.rotating_gates.size] = var_3;
    }

    var_0 = getentarray( "rotating_gate_constant", "targetname" );
    level.mp_prison_killstreak.rotating_gate_constant = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_2.originalpos = var_2.origin;
        var_2.originalrot = var_2.angles;
        var_3.gate = var_2;
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        var_3.dest = var_4;
        var_6 = common_scripts\utility::getstruct( var_4.target, "targetname" );

        if ( !isdefined( var_6 ) )
            continue;

        var_7 = var_6 common_scripts\utility::spawn_tag_origin();
        var_7 show();
        var_7 linkto( var_2 );
        var_8 = common_scripts\utility::getstruct( var_6.target, "targetname" );

        if ( !isdefined( var_8 ) )
        {
            var_7 delete();
            continue;
        }

        var_9 = var_8 common_scripts\utility::spawn_tag_origin();
        var_9 show();
        var_9 linkto( var_2 );
        var_3.sparks = [ var_7, var_9 ];
        level.mp_prison_killstreak.rotating_gate_constant[level.mp_prison_killstreak.rotating_gate_constant.size] = var_3;
    }
}

movegates()
{
    var_0 = 0.5;

    foreach ( var_2 in level.mp_prison_killstreak.gates )
    {
        var_2.gate moveto( var_2.dest.origin, var_0, 0.1, 0.2 );
        var_2.collision moveto( var_2.dest.origin, var_0, 0.1, 0.2 );
        var_2 thread bouncegate( var_0 );
    }
}

rotategates()
{
    var_0 = 0.5;

    foreach ( var_2 in level.mp_prison_killstreak.rotating_gates )
    {
        var_2 thread gatefxon();
        var_2.gate moveto( var_2.dest.origin, var_0, 0.1, 0.2 );
        var_2.gate rotateto( var_2.dest.angles, var_0, 0.1, 0.2 );
        var_2.collision rotateto( var_2.dest.angles - ( 0, 90, 0 ), var_0, 0.1, 0.2 );
        var_2.collision moveto( var_2.dest.origin, var_0, 0.1, 0.2 );
    }

    wait(var_0);

    foreach ( var_2 in level.mp_prison_killstreak.rotating_gates )
        var_2 thread gatefxoff();
}

rotategatesconstant()
{
    foreach ( var_1 in level.mp_prison_killstreak.rotating_gate_constant )
        var_1 thread rotategatebounce();
}

rotategatebounce()
{
    self endon( "stop_bounce" );

    for (;;)
    {
        var_0 = randomfloatrange( 0.1, 0.5 );
        thread gatefxon();
        self.gate moveto( self.dest.origin, var_0, 0.05, 0.05 );
        self.gate rotateto( self.dest.angles, var_0, 0.05, 0.05 );
        wait(var_0);
        self.gate moveto( self.gate.originalpos, var_0, 0.05, 0.05 );
        self.gate rotateto( self.gate.originalrot, var_0, 0.05, 0.05 );
        thread gatefxoff();
        wait(randomfloatrange( 0.1, 1 ));
    }
}

resetrotategateconstant()
{
    var_0 = 0.5;

    foreach ( var_2 in level.mp_prison_killstreak.rotating_gate_constant )
        var_2 notify( "stop_bounce" );

    wait 0.5;

    foreach ( var_2 in level.mp_prison_killstreak.rotating_gate_constant )
    {
        var_2 thread gatefxon();
        var_2.gate moveto( var_2.gate.originalpos, var_0, 0.05, 0.05 );
        var_2.gate rotateto( var_2.gate.originalrot, var_0, 0.05, 0.05 );
    }

    wait(var_0);

    foreach ( var_2 in level.mp_prison_killstreak.rotating_gate_constant )
        var_2 thread gatefxoff();
}

resetrotategates()
{
    var_0 = 0.5;

    foreach ( var_2 in level.mp_prison_killstreak.rotating_gates )
    {
        var_2 thread gatefxon();

        if ( isdefined( var_2.kill_vol ) )
            var_2.kill_vol common_scripts\utility::trigger_on_proc();

        var_2.gate moveto( var_2.gate.originalpos, var_0, 0.1, 0.2 );
        var_2.gate rotateto( var_2.gate.originalrot, var_0, 0.1, 0.2 );
        var_2.collision rotateto( var_2.collision.originalrot, var_0, 0.1, 0.2 );
        var_2.collision moveto( var_2.collision.originalpos, var_0, 0.1, 0.2 );
    }

    wait(var_0);

    foreach ( var_2 in level.mp_prison_killstreak.rotating_gates )
    {
        if ( isdefined( var_2.kill_vol ) )
            var_2.kill_vol common_scripts\utility::trigger_off_proc();

        var_2 thread gatefxoff();
    }
}

resetgates()
{
    var_0 = 0.5;

    foreach ( var_2 in level.mp_prison_killstreak.gates )
        var_2 notify( "stop_bounce" );

    wait 0.5;

    foreach ( var_2 in level.mp_prison_killstreak.gates )
    {
        var_2 thread gatefxon();
        var_2.gate moveto( var_2.gate.originalpos, var_0, 0.1, 0.2 );
        var_2.collision moveto( var_2.collision.originalpos, var_0, 0.1, 0.2 );
    }

    wait(var_0);

    foreach ( var_2 in level.mp_prison_killstreak.gates )
        var_2 thread gatefxoff();
}

bouncegate( var_0 )
{
    self endon( "stop_bounce" );
    thread gatefxon();
    wait(var_0);
    thread gatefxoff();
    var_1 = anglestoforward( vectortoangles( self.dest.origin - self.gate.originalpos ) );
    var_2 = var_1 * 2;

    for (;;)
    {
        var_3 = randomfloatrange( 0.1, 0.5 );
        var_4 = randomfloatrange( 0.1, 0.5 );
        thread gatefxon();
        self.gate moveto( self.gate.origin + var_2, var_3, 0.05, 0.05 );
        wait(var_3);
        self.gate moveto( self.dest.origin, var_4, 0.05, 0.05 );
        wait(var_4);
        thread gatefxoff();
        wait(randomfloat( 2 ));
    }
}

gatefxon()
{
    self endon( "stop_sparks" );

    for (;;)
    {
        foreach ( var_1 in self.sparks )
            playfxontag( common_scripts\utility::getfx( level.gate_spark_fx ), var_1, "tag_origin" );

        wait(randomfloatrange( 0.5, 1.0 ));
    }
}

gatefxoff()
{
    self notify( "stop_sparks" );

    foreach ( var_1 in self.sparks )
        stopfxontag( common_scripts\utility::getfx( level.gate_spark_fx ), var_1, "tag_origin" );
}

gasvisualsstart()
{
    activateclientexploder( 20 );
}

gasvisualsend()
{

}

playloopingsoundonorigin()
{
    wait 3.5;
    thread maps\mp\_utility::playsoundinspace( level.gas_alarm_sfx_alias, self.origin );
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.numareas = 0;
    }
}

playerenterarea( var_0 )
{
    self.numareas++;

    if ( self.numareas == 1 )
        gaseffect();
}

playerleavearea( var_0 )
{
    self.numareas--;

    if ( self.numareas != 0 )
        return;

    self.poison = 0;
    self notify( "leftTrigger" );

    if ( isdefined( self.gasoverlay ) )
        self.gasoverlay fadeoutblackout( 0.1, 0 );
}

gasfieldson()
{
    var_0 = getentarray( "gas_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();
}

gasfieldsoff()
{
    var_0 = getentarray( "gas_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();
}

soundwatcher( var_0 )
{
    common_scripts\utility::waittill_any( "death", "leftTrigger" );
    self stoploopsound();
}

gaseffect()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "leftTrigger" );
    self.poison = 0;
    thread soundwatcher( self );

    for (;;)
    {
        self.poison++;

        switch ( self.poison )
        {
            case 1:
                self viewkick( 1, self.origin );
                break;
            case 3:
                self shellshock( "mp_prison_gas", 4 );
                self viewkick( 3, self.origin );
                dogasdamage( 25 );
                break;
            case 4:
                self shellshock( "mp_prison_gas", 5 );
                self viewkick( 15, self.origin );
                thread blackout();
                dogasdamage( 45 );
                break;
            case 6:
                self shellshock( "mp_prison_gas", 5 );
                self viewkick( 75, self.origin );
                dogasdamage( 80 );
                break;
            case 8:
                self shellshock( "mp_prison_gas", 5 );
                self viewkick( 127, self.origin );
                dogasdamage( 175 );
                break;
        }

        wait 1;
    }

    wait 5;
}

blackout()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "leftTrigger" );

    if ( !isdefined( self.gasoverlay ) )
    {
        self.gasoverlay = newclienthudelem( self );
        self.gasoverlay.x = 0;
        self.gasoverlay.y = 0;
        self.gasoverlay setshader( "black", 640, 480 );
        self.gasoverlay.alignx = "left";
        self.gasoverlay.aligny = "top";
        self.gasoverlay.horzalign = "fullscreen";
        self.gasoverlay.vertalign = "fullscreen";
        self.gasoverlay.alpha = 0;
    }

    var_0 = 1;
    var_1 = 2;
    var_2 = 0.25;
    var_3 = 1;
    var_4 = 5;
    var_5 = 100;
    var_6 = 0;

    for (;;)
    {
        while ( self.poison > 1 )
        {
            var_7 = var_5 - var_4;
            var_6 = ( self.poison - var_4 ) / var_7;

            if ( var_6 < 0 )
                var_6 = 0;
            else if ( var_6 > 1 )
                var_6 = 1;

            var_8 = var_1 - var_0;
            var_9 = var_0 + var_8 * ( 1 - var_6 );
            var_10 = var_3 - var_2;
            var_11 = var_2 + var_10 * var_6;
            var_12 = var_6 * 0.5;

            if ( var_6 == 1 )
                break;

            var_13 = var_9 / 2;
            self.gasoverlay fadeinblackout( var_13, var_11 );
            self.gasoverlay fadeoutblackout( var_13, var_12 );
            wait(var_6 * 0.5);
        }

        if ( var_6 == 1 )
            break;

        if ( self.gasoverlay.alpha != 0 )
            self.gasoverlay fadeoutblackout( 1, 0 );

        wait 0.05;
    }

    self.gasoverlay fadeinblackout( 2, 0 );
}

dogasdamage( var_0 )
{
    self thread [[ level.callbackplayerdamage ]]( self, self, var_0, 0, "MOD_SUICIDE", "mp_prison_gas", self.origin, ( 0, 0, 0 ) - self.origin, "none", 0 );
}

fadeinblackout( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}

fadeoutblackout( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}
