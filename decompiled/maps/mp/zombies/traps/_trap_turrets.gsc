// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level.sentrysettings ) )
        level.sentrysettings = [];

    level.sentrysettings["zombies_trap"] = spawnstruct();
    level.sentrysettings["zombies_trap"].health = 999999;
    level.sentrysettings["zombies_trap"].maxhealth = 1000;
    level.sentrysettings["zombies_trap"].burstmin = 20;
    level.sentrysettings["zombies_trap"].burstmax = 120;
    level.sentrysettings["zombies_trap"].pausemin = 0.15;
    level.sentrysettings["zombies_trap"].pausemax = 0.35;
    level.sentrysettings["zombies_trap"].sentrymodeon = "sentry";
    level.sentrysettings["zombies_trap"].sentrymodeoff = "sentry_offline";
    level.sentrysettings["zombies_trap"].timeout = 90.0;
    level.sentrysettings["zombies_trap"].spinuptime = 0.05;
    level.sentrysettings["zombies_trap"].overheattime = 8.0;
    level.sentrysettings["zombies_trap"].cooldowntime = 0.1;
    level.sentrysettings["zombies_trap"].fxtime = 0.3;
    level.sentrysettings["zombies_trap"].streakname = "sentry";
    level.sentrysettings["zombies_trap"].weaponinfo = "zombie_trap_turret_mp";
    level.sentrysettings["zombies_trap"].modelbase = "zark_trap_turret";
    var_0 = common_scripts\utility::getstructarray( "turret_trap", "script_noteworthy" );

    if ( var_0.size > 0 )
    {
        thread maps\mp\zombies\_traps::trap_setup_custom_function( "turret_trap", "active", ::begintrap );
        thread maps\mp\zombies\_traps::trap_setup_custom_hints( "turret_trap", &"ZOMBIES_TRAP_READY", &"ZOMBIES_TRAP_COOLDOWN" );
    }

    foreach ( var_2 in level.traps )
    {
        if ( !isdefined( var_2.script_noteworthy ) || var_2.script_noteworthy != "turret_trap" )
            continue;

        var_3 = var_2 trapgetturrets();

        foreach ( var_5 in var_3 )
            var_5 sentry_initsentry( "zombies_trap" );
    }
}

begintrap( var_0 )
{
    var_1 = "zombies_trap";
    var_2 = var_0 trapgetturrets();

    foreach ( var_4 in var_2 )
    {
        var_4 sentry_setowner( var_0.owner );
        var_4 sentry_setactive();
        var_4 thread sentry_handlecomplete();
    }

    var_0 thread trapturrettimer( var_2 );
    return 1;
}

trapgetturrets()
{
    var_0 = getentarray( self.target, "targetname" );
    var_1 = common_scripts\utility::getstructarray( self.target, "targetname" );
    var_2 = common_scripts\utility::array_combine( var_0, var_1 );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( !isdefined( var_5.script_noteworthy ) )
            continue;

        if ( var_5.script_noteworthy == "turret" )
            var_3[var_3.size] = var_5;
    }

    return var_3;
}

trapturrettimer( var_0 )
{
    self waittill( "cooldown" );

    foreach ( var_2 in var_0 )
        var_2 notify( "timeout" );
}

sentry_setactive()
{
    self _meth_8065( level.sentrysettings[self.sentrytype].sentrymodeon );
}

sentry_initsentry( var_0 )
{
    self.sentrytype = var_0;
    self _meth_8156( 180 );
    self _meth_8155( 180 );
    self _meth_8157( 89 );
    self _meth_8158( 89 );
    self _meth_80B1( level.sentrysettings[self.sentrytype].modelbase );
    self _meth_8138();
    self _meth_815A( 0 );
    self _meth_82C0( 0 );
    self _meth_82C1( 0 );
    self _meth_817A( 1 );
    maps\mp\killstreaks\_autosentry::sentry_setinactive();
    thread sentry_attacktargets();
}

sentry_attacktargets()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.momentum = 0;
    self.heatlevel = 0;
    self.overheated = 0;

    for (;;)
    {
        common_scripts\utility::waittill_either( "turretstatechange", "cooled" );

        if ( self _meth_80E4() )
        {
            thread maps\mp\killstreaks\_autosentry::sentry_burstfirestart();
            continue;
        }

        maps\mp\killstreaks\_autosentry::sentry_spindown();
        thread maps\mp\killstreaks\_autosentry::sentry_burstfirestop();
    }
}

sentry_handlecomplete()
{
    self waittill( "timeout" );

    if ( !isdefined( self ) )
        return;

    maps\mp\killstreaks\_autosentry::sentry_setinactive();
    self _meth_8103( undefined );
    self _meth_8105( 0 );
}

sentry_setowner( var_0 )
{
    self.owner = var_0;
    self _meth_8103( self.owner );
    self _meth_8105( 1, self.sentrytype );
    self.team = self.owner.team;
    self _meth_8135( self.team );
}
