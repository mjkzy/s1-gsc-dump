// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level._id_7CC5 ) )
        level._id_7CC5 = [];

    level._id_7CC5["zombies_trap"] = spawnstruct();
    level._id_7CC5["zombies_trap"].health = 999999;
    level._id_7CC5["zombies_trap"].maxhealth = 1000;
    level._id_7CC5["zombies_trap"]._id_1933 = 20;
    level._id_7CC5["zombies_trap"]._id_1932 = 120;
    level._id_7CC5["zombies_trap"]._id_6721 = 0.15;
    level._id_7CC5["zombies_trap"]._id_6720 = 0.35;
    level._id_7CC5["zombies_trap"]._id_7CC4 = "sentry";
    level._id_7CC5["zombies_trap"]._id_7CC3 = "sentry_offline";
    level._id_7CC5["zombies_trap"]._id_9364 = 90.0;
    level._id_7CC5["zombies_trap"]._id_8A5D = 0.05;
    level._id_7CC5["zombies_trap"]._id_65F2 = 8.0;
    level._id_7CC5["zombies_trap"]._id_21B4 = 0.1;
    level._id_7CC5["zombies_trap"]._id_3BBD = 0.3;
    level._id_7CC5["zombies_trap"].streakname = "sentry";
    level._id_7CC5["zombies_trap"]._id_051C = "zombie_trap_turret_mp";
    level._id_7CC5["zombies_trap"]._id_5D3A = "zark_trap_turret";
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
            var_5 _id_7CAD( "zombies_trap" );
    }
}

begintrap( var_0 )
{
    var_1 = "zombies_trap";
    var_2 = var_0 trapgetturrets();

    foreach ( var_4 in var_2 )
    {
        var_4 _id_7CBA( var_0.owner );
        var_4 _id_7CB6();
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

_id_7CB6()
{
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
}

_id_7CAD( var_0 )
{
    self.sentrytype = var_0;
    self _meth_8156( 180 );
    self _meth_8155( 180 );
    self _meth_8157( 89 );
    self _meth_8158( 89 );
    self setmodel( level._id_7CC5[self.sentrytype]._id_5D3A );
    self _meth_8138();
    self _meth_815A( 0 );
    self setcandamage( 0 );
    self setcanradiusdamage( 0 );
    self _meth_817A( 1 );
    maps\mp\killstreaks\_autosentry::_id_7CB9();
    thread _id_7CA2();
}

_id_7CA2()
{
    self endon( "death" );
    level endon( "game_ended" );
    self._id_5D59 = 0;
    self._id_4795 = 0;
    self._id_65F1 = 0;

    for (;;)
    {
        common_scripts\utility::waittill_either( "turretstatechange", "cooled" );

        if ( self _meth_80E4() )
        {
            thread maps\mp\killstreaks\_autosentry::_id_7CA4();
            continue;
        }

        maps\mp\killstreaks\_autosentry::_id_7CBC();
        thread maps\mp\killstreaks\_autosentry::_id_7CA5();
    }
}

sentry_handlecomplete()
{
    self waittill( "timeout" );

    if ( !isdefined( self ) )
        return;

    maps\mp\killstreaks\_autosentry::_id_7CB9();
    self _meth_8103( undefined );
    self _meth_8105( 0 );
}

_id_7CBA( var_0 )
{
    self.owner = var_0;
    self _meth_8103( self.owner );
    self _meth_8105( 1, self.sentrytype );
    self.team = self.owner.team;
    self _meth_8135( self.team );
}
