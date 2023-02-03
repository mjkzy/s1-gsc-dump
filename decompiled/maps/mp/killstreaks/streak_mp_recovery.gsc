// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.mp_recovery_killstreak = spawnstruct();
    level.mp_recovery_killstreak.killstreak_inuse = 0;
    level.mp_recovery_killstreak.killstreak_duration = 25;
    level.mp_recovery_killstreak.speed_scale = 1.25;
    level.mp_recovery_killstreak.health_scale = 1.75;
    level.mp_recovery_killstreak.max_health_amplify_object = 1500;
    level.mp_recovery_killstreak.exo_super_vfx = loadfx( "vfx/lights/air_light_exosuper_yellow" );
    level.mp_recovery_killstreak.amplify_vfx = loadfx( "vfx/lights/air_light_amplifymachine_yellow" );
    var_0 = getent( "damage_ring_01", "targetname" );
    var_1 = getent( "damage_ring_02", "targetname" );
    level.mp_recovery_killstreak.damageringsarray = [ var_0, var_1 ];

    foreach ( var_3 in level.mp_recovery_killstreak.damageringsarray )
    {
        var_3 hudoutlineenable( 1, 1 );
        var_3 setcandamage( 1 );
        var_3 setcanradiusdamage( 1 );
        var_3.max_fake_health = level.mp_recovery_killstreak.max_health_amplify_object;
        var_3.health = var_3.max_fake_health;
        var_3.maxhealth = var_3.max_fake_health;
        var_3.fakehealth = var_3.max_fake_health;
        var_4 = common_scripts\utility::getstructarray( var_3.target, "targetname" );
        var_3.tag_array = [];

        foreach ( var_6 in var_4 )
        {
            var_7 = common_scripts\utility::spawn_tag_origin();
            var_7.origin = var_6.origin;
            var_7 show();
            var_3.tag_array[var_3.tag_array.size] = var_7;
        }
    }

    precachestring( &"KILLSTREAKS_MP_RECOVERY" );
    level.killstreakfuncs["mp_recovery"] = ::tryusemprecovery;
    level.mapkillstreak = "mp_recovery";
    level thread onrecoveryplayerconnect();
}

tryusemprecovery( var_0, var_1 )
{
    if ( level.mp_recovery_killstreak.killstreak_inuse )
    {
        self iprintlnbold( &"MP_RECOVERY_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    var_2 = exoteambuffsetup( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_recovery", self.origin );

    return var_2;
}

exoteambuffsetup( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        level.mp_recovery_killstreak.killstreak_inuse = 1;
        level.mp_recovery_killstreak.owner = var_0;
        level.mp_recovery_killstreak.killstreak_team = var_0.team;
    }
    else
        return 0;

    var_1 = var_0.team;
    thread startexorecoverykillstreak( var_0, var_1 );
    return 1;
}

startexorecoverykillstreak( var_0, var_1 )
{
    setupamplifierdamagemonitor( var_0, var_1 );
    sortplayersandgivepowers( var_0, var_1 );
    thread setmapkillstreaktimer();
    level common_scripts\utility::waittill_any( "time_up", "amplifier_destroyed" );
    shutoffamplifyobjectvfx();
    shutoffallplayersexobuffs();
    level notify( "recovery_streak_over" );
    wait 0.25;
    level.mp_recovery_killstreak.killstreak_inuse = 0;
}

setmapkillstreaktimer()
{
    level endon( "recovery_streak_over" );
    wait(level.mp_recovery_killstreak.killstreak_duration);
    level notify( "time_up" );
}

setupamplifierdamagemonitor( var_0, var_1 )
{
    var_2 = "atlas";
    var_3 = "axis";

    if ( var_1 == "axis" )
    {
        var_2 = "atlas";
        var_3 = "allies";
    }
    else if ( var_1 == "allies" )
    {
        var_2 = "sentinel";
        var_3 = "axis";
    }

    var_4 = "faction_128_" + var_2;

    foreach ( var_6 in level.mp_recovery_killstreak.damageringsarray )
    {
        var_6 setcandamage( 1 );
        var_6 setcanradiusdamage( 1 );
        var_6.health = var_6.max_fake_health;
        var_6.maxhealth = var_6.max_fake_health;
        var_6.fakehealth = var_6.max_fake_health;
        var_6 thread startamplifyobjectvfx();
        var_6 thread monitoramplifierdamage( var_0, var_1 );

        if ( level.dynamiceventstatus == "before" && var_6.targetname == "damage_ring_02" )
            continue;
        else if ( level.dynamiceventstatus == "after" && var_6.targetname == "damage_ring_01" )
            continue;

        if ( level.teambased == 0 )
        {
            foreach ( var_8 in level.players )
            {
                if ( var_8 != var_0 )
                    var_6 maps\mp\_entityheadicons::setheadicon( var_8, var_4, ( 0, 0, 0 ), 18, 18, undefined, undefined, undefined, 1, 0, 0 );
            }

            continue;
        }

        if ( level.teambased == 1 )
            var_6 maps\mp\_entityheadicons::setheadicon( var_3, var_4, ( 0, 0, 0 ), 18, 18, undefined, undefined, undefined, 1, 0, 0 );
    }
}

monitoramplifierdamage( var_0, var_1 )
{
    level endon( "recovery_streak_over" );

    while ( level.mp_recovery_killstreak.killstreak_inuse == 1 )
    {
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( !isvalidstreakplayer( var_3, var_0, var_1 ) )
        {
            self.fakehealth += var_2 * -1;

            if ( self.fakehealth <= 0 )
            {
                level notify( "amplifier_destroyed" );
                return;
            }
        }
    }
}

startamplifyobjectvfx()
{
    foreach ( var_1 in level.mp_recovery_killstreak.damageringsarray )
    {
        foreach ( var_3 in var_1.tag_array )
            playfxontag( level.mp_recovery_killstreak.amplify_vfx, var_3, "tag_origin" );
    }
}

shutoffamplifyobjectvfx()
{
    shutoffplayerhudoutline();

    foreach ( var_1 in level.mp_recovery_killstreak.damageringsarray )
    {
        var_1 destroyplayericons();

        foreach ( var_3 in var_1.tag_array )
            stopfxontag( level.mp_recovery_killstreak.amplify_vfx, var_3, "tag_origin" );
    }
}

destroyplayericons()
{
    if ( isdefined( self.entityheadicons ) )
    {
        if ( isdefined( self.entityheadicons["allies"] ) )
        {
            self.entityheadicons["allies"] destroy();
            self.entityheadicons["allies"] = undefined;
        }

        if ( isdefined( self.entityheadicons["axis"] ) )
        {
            self.entityheadicons["axis"] destroy();
            self.entityheadicons["axis"] = undefined;
        }

        foreach ( var_1 in level.players )
        {
            if ( isdefined( self.entityheadicons[var_1.guid] ) )
            {
                self.entityheadicons[var_1.guid] destroy();
                self.entityheadicons[var_1.guid] = undefined;
            }
        }
    }
}

shutoffplayerhudoutline()
{
    foreach ( var_1 in level.players )
    {
        foreach ( var_3 in level.mp_recovery_killstreak.damageringsarray )
            var_3 hudoutlinedisableforclient( var_1 );
    }
}

turnonplayerhudoutline( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( !isvalidstreakplayer( var_3, var_0, var_1 ) )
        {
            foreach ( var_5 in level.mp_recovery_killstreak.damageringsarray )
                var_5 hudoutlineenableforclient( var_3, 1, 1 );
        }
    }
}

sortplayersandgivepowers( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( isvalidstreakplayer( var_3, var_0, var_1 ) == 1 )
        {
            if ( maps\mp\_utility::isreallyalive( var_3 ) )
            {
                var_3 setupsuperexo();
                var_3 thread givesuperexo();
            }
        }

        var_3 thread monitorspawndurringstreak( var_0, var_1 );
    }

    thread monitorconnectedduringstreak( var_0, var_1 );
}

shutoffallplayersexobuffs()
{
    foreach ( var_1 in level.players )
        var_1 shutoffexobuffs();
}

shutoffexobuffs()
{
    if ( isdefined( self.superexosettings ) && isdefined( self.superexosettings.isactive ) )
        self.superexosettings.isactive = 0;

    shutoffspeed();
    shutofffx();
    shutoffhealth();
    shutoffslam();
}

shutoffslam()
{
    if ( isdefined( self.cac_has_slam ) && self.cac_has_slam == 1 )
    {

    }
    else if ( maps\mp\_utility::_hasperk( "specialty_exo_slamboots" ) )
        maps\mp\_utility::_unsetperk( "specialty_exo_slamboots" );

    self.cac_has_slam = undefined;
}

shutoffspeed()
{
    self.movespeedscaler = level.baseplayermovescale;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = maps\mp\_utility::lightweightscalar();

    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

shutoffhealth()
{
    self.maxhealth = int( self.maxhealth / level.mp_recovery_killstreak.health_scale );

    if ( self.health > self.maxhealth )
        self.health = self.maxhealth;

    self.healthregenlevel = undefined;
}

shutofffx()
{
    if ( isdefined( self.superexosettings ) && isdefined( self.superexosettings.overlay ) )
        self.superexosettings.overlay destroy();

    if ( isdefined( level.mp_recovery_killstreak.exo_super_vfx ) )
    {
        if ( maps\mp\_utility::isreallyalive( self ) )
        {
            stopfxontag( level.mp_recovery_killstreak.exo_super_vfx, self, "tag_shield_back" );
            stopfxontag( level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_le" );
            stopfxontag( level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_ri" );
        }
    }
}

givesuperexo()
{
    setupsuperexo();
    self.superexosettings.isactive = 1;
    givesuperspeed();
    givesuperhealth();
    givesuperstomp();
    givesuperpunch();
    givesuperrepulse();
    turnonsuperfx();
    thread watchfordeath();
}

watchfordeath()
{
    level endon( "game_ended" );
    level endon( "recovery_streak_over" );
    self endon( "disconnect" );
    self waittill( "death" );

    if ( level.mp_recovery_killstreak.killstreak_inuse == 1 )
        shutoffexobuffs();
}

givesuperspeed()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self.movespeedscaler = level.mp_recovery_killstreak.speed_scale;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

givesuperhealth()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self.maxhealth = int( self.maxhealth * level.mp_recovery_killstreak.health_scale );
    self.ignoreregendelay = 1;
    self.healthregenlevel = 0.99;
    self notify( "damage" );
}

givesuperstomp()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self.cac_has_slam = undefined;

    if ( maps\mp\_utility::_hasperk( "specialty_exo_slamboots" ) )
        self.cac_has_slam = 1;
    else
    {
        maps\mp\_utility::giveperk( "specialty_exo_slamboots", 0 );
        self.cac_has_slam = 0;
    }
}

givesuperpunch()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
}

givesuperrepulse()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    thread maps\mp\_exo_repulsor::do_exo_repulsor();
}

turnonsuperfx()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );

    if ( !isdefined( self.superexosettings.overlay ) )
    {
        self.superexosettings.overlay = newclienthudelem( self );
        self.superexosettings.overlay.x = 0;
        self.superexosettings.overlay.y = 0;
        self.superexosettings.overlay.horzalign = "fullscreen";
        self.superexosettings.overlay.vertalign = "fullscreen";
        self.superexosettings.overlay setshader( "exo_hud_cloak_overlay", 640, 480 );
        self.superexosettings.overlay.archive = 1;
        self.superexosettings.overlay.alpha = 1.0;
    }

    if ( isdefined( level.mp_recovery_killstreak.exo_super_vfx ) )
    {
        playfxontag( level.mp_recovery_killstreak.exo_super_vfx, self, "tag_shield_back" );
        playfxontag( level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_le" );
        playfxontag( level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_ri" );
    }
}

setupsuperexo()
{
    if ( !isdefined( self.superexosettings ) )
        self.superexosettings = spawnstruct();

    if ( !isdefined( level.mp_recovery_killstreak.exo_super_vfx ) )
        level.mp_recovery_killstreak.exo_super_vfx = loadfx( "vfx/lights/air_light_exosuper_yellow" );

    self.superexosettings.isactive = 0;
}

isvalidstreakplayer( var_0, var_1, var_2 )
{
    if ( level.teambased == 0 && isdefined( var_1 ) && var_0 == var_1 )
        return 1;
    else if ( level.teambased == 1 && var_0.team == var_2 )
        return 1;
    else
        return 0;
}

monitorspawndurringstreak( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "recovery_streak_over" );

    while ( level.mp_recovery_killstreak.killstreak_inuse == 1 )
    {
        self waittill( "spawned_player" );

        if ( isvalidstreakplayer( self, var_0, var_1 ) == 1 )
        {
            wait 0.25;

            if ( level.mp_recovery_killstreak.killstreak_inuse == 1 )
            {
                setupsuperexo();
                thread givesuperexo();
            }
        }
    }
}

monitorconnectedduringstreak( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "recovery_streak_over" );

    while ( level.mp_recovery_killstreak.killstreak_inuse == 1 )
    {
        level waittill( "connected", var_2 );
        var_2 monitorspawndurringstreak( var_0, var_1 );
    }
}

onrecoveryplayerconnect()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );

        foreach ( var_2 in level.mp_recovery_killstreak.damageringsarray )
            var_2 hudoutlinedisableforclient( var_0 );

        var_0 thread onrecoveryplayerdisconnect();
    }
}

onrecoveryplayerdisconnect()
{
    level endon( "game_ended" );
    self waittill( "disconnect" );
}
