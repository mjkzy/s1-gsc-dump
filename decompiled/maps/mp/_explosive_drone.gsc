// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_A20F()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    if ( !isdefined( level._id_3575 ) )
        _id_3570();

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        var_2 = maps\mp\_utility::strip_suffix( var_1, "_lefthand" );

        if ( var_2 == "explosive_drone_mp" )
        {
            var_0.team = self.team;

            if ( !isdefined( var_0.owner ) )
                var_0.owner = self;

            if ( !isdefined( var_0.weaponname ) )
                var_0.weaponname = var_1;

            var_0 thread _id_3571();
        }
    }
}

_id_3571()
{
    thread _id_A221();
    wait 0.1;

    if ( isdefined( self ) )
    {
        self.explosivedrone = spawn( "script_model", self.origin );
        self.explosivedrone.targetname = "explosive_drone_head_model";
        self.explosivedrone setmodel( level._id_3575._id_5D3A );
        self.explosivedrone.oldcontents = self.explosivedrone setcontents( 0 );
        self.explosivedrone linkto( self, "tag_spike", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
        self.explosivedrone.owner = self.owner;
        var_0 = self.explosivedrone;
        var_0 thread cleanup_on_grenade_death( self );
        thread _id_5EC5();
        thread _id_5E6B();
    }
}

cleanup_on_grenade_death( var_0 )
{
    var_0 waittill( "death" );

    if ( isdefined( self ) )
        self delete();
}

explosivegrenadedeath( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self ) )
    {
        self notify( "death" );

        if ( isdefined( self.explosivedrone ) )
            self.explosivedrone _id_2850();

        self delete();
    }
}

_id_357A( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self ) )
        self delete();
}

_id_3570()
{
    level._id_3572 = 1;
    level._id_3575 = spawnstruct();
    level._id_3575._id_9364 = 20.0;
    level._id_3575._id_3580 = 30.0;
    level._id_3575.health = 60;
    level._id_3575.maxhealth = 60;
    level._id_3575._id_9D6D = "vehicle_tracking_drone_mp";
    level._id_3575._id_5D3A = "npc_drone_explosive_main";
    level._id_3575._id_3BAF = loadfx( "vfx/sparks/direct_hack_stun" );
    level._id_3575._id_3BAB = loadfx( "vfx/lights/tracking_drone_laser_blue" );
    level._id_3575._id_3BA9 = loadfx( "vfx/explosion/explosive_drone_explosion" );
    level._id_3575._id_3BAD = loadfx( "vfx/explosion/explosive_drone_explosion" );
    level._id_3575._id_3BA7 = loadfx( "vfx/lights/light_explosive_drone_beacon_enemy" );
    level._id_3575._id_3BAA = loadfx( "vfx/lights/light_explosive_drone_beacon_friendly" );
    level._id_3575._id_3BA8 = loadfx( "vfx/distortion/tracking_drone_distortion_hemi" );
    level._id_3575._id_3BAC = loadfx( "vfx/trail/explosive_drone_thruster_large" );
    level._id_3575._id_3BAE = loadfx( "vfx/trail/explosive_drone_thruster_small" );
    level._id_3575._id_8898 = "wpn_explosive_drone_exp";
    level._id_3575._id_889A = "wpn_explosive_drone_lock";
    level._id_3575._id_8899 = "wpn_explosive_drone_open";

    foreach ( var_1 in level.players )
        var_1.is_being_tracked = 0;

    level thread _id_64A8();
    level._id_3576 = level._id_3575._id_9364;
    level._id_3576 = level._id_3575._id_3580;
    level._id_356A = 0;
    level._id_356B = 0;
    level._id_356C = 0;
}

_id_98A7( var_0 )
{
    var_1 = 1;

    if ( maps\mp\_utility::isusingremote() )
        return 0;
    else if ( _id_33E0() )
    {
        self iclientprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }
    else if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( !isdefined( self._id_3569 ) )
        self._id_3569 = [];

    if ( self._id_3569.size )
    {
        self._id_3569 = common_scripts\utility::array_removeundefined( self._id_3569 );

        if ( self._id_3569.size >= level._id_3572 )
        {
            if ( isdefined( self._id_3569[0] ) )
                self._id_3569[0] thread _id_355A();
        }
    }

    maps\mp\_utility::incrementfauxvehiclecount();
    var_2 = var_0 _id_2400();

    if ( !isdefined( var_2 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    self playsound( level._id_3575._id_8899 );
    self playsound( level._id_3575._id_889A );
    self._id_3569[self._id_3569.size] = var_2;
    thread _id_8D0D( var_2 );
    playfxontag( level._id_3575._id_3BAC, var_2, "TAG_THRUSTER_BTM" );
    var_0 notify( "mine_selfdestruct" );
    return var_2;
}

_id_2400( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !var_0 )
    {
        var_4 = self.angles;
        var_5 = anglestoforward( var_4 );
        var_6 = anglestoright( var_4 );
        var_7 = var_5 * 50;
        var_8 = var_6 * 0;
        var_9 = 80;

        if ( isdefined( self.explosivedrone ) )
        {
            var_11 = self.explosivedrone.origin;
            var_4 = self.explosivedrone.angles;
            self.explosivedrone _id_2850();
            _id_0849();
        }
        else
            var_11 = self.origin;
    }
    else
    {
        var_11 = var_1;
        var_12 = var_1;
        var_4 = var_2;
    }

    var_13 = anglestoup( self.angles );
    var_11 += var_13 * 10;
    var_14 = spawnhelicopter( self.owner, var_11, var_4, level._id_3575._id_9D6D, level._id_3575._id_5D3A );

    if ( !isdefined( var_14 ) )
        return;

    var_14.type = "explosive_drone";
    var_14 common_scripts\utility::make_entity_sentient_mp( self.owner.team );
    var_14 _meth_83F3( 1 );
    var_14 _id_084A();
    var_14 thread _id_73A5();
    var_14.health = level._id_3575.health;
    var_14.maxhealth = level._id_3575.maxhealth;
    var_14.damagetaken = 0;
    var_14._id_03E3 = 20;
    var_14._id_3978 = 20;
    var_14.owner = self.owner;
    var_14.team = self.owner.team;
    var_14 _meth_8283( var_14._id_03E3, 10, 10 );
    var_14 _meth_8292( 120, 90 );
    var_14 _meth_825A( 64 );
    var_14 _meth_8253( 20, 5, 5 );
    var_14._id_3B88 = undefined;

    if ( isdefined( var_14.type ) )
    {
        if ( var_14.type == "explosive_drone" )
        {

        }
    }

    var_14._id_5A54 = 2000;
    var_14._id_5A3A = 300;
    var_14._id_94B6 = undefined;
    var_15 = 45;
    var_16 = 45;
    var_14 _meth_8294( var_15, var_16 );
    var_14._id_91D1 = var_11;
    var_14._id_0E53 = 10000;
    var_14._id_0E52 = 150;
    var_14._id_0E54 = missile_createattractorent( var_14, var_14._id_0E53, var_14._id_0E52 );
    var_14._id_4724 = 0;
    var_14.stunned = 0;
    var_14._id_4C0E = 0;
    var_14 thread maps\mp\gametypes\_damage::setentitydamagecallback( var_14.maxhealth, undefined, ::_id_64A7, undefined, 0 );
    var_14 thread _id_3561();
    var_14 thread _id_3560();
    var_14 thread _id_3568();
    var_14 thread _id_3565();
    var_14 thread _id_3564();
    var_14 thread _id_3566();
    var_14 thread _id_3563();
    var_14 thread _id_3552();
    var_14 thread _id_3554();
    var_14 thread _id_2EE1();
    return var_14;
}

_id_0849()
{
    var_0 = 5;

    if ( !isdefined( level._id_8A56 ) )
    {
        level._id_8A56 = [];
        level._id_8A57 = 0;
    }

    if ( level._id_8A56.size >= var_0 )
    {
        if ( isdefined( level._id_8A56[level._id_8A57] ) )
            level._id_8A56[level._id_8A57] delete();
    }

    level._id_8A56[level._id_8A57] = self;
    level._id_8A57 = ( level._id_8A57 + 1 ) % var_0;
}

_id_4B83( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_1 = anglestoforward( self.angles );

    for (;;)
    {
        if ( maps\mp\_utility::isreallyalive( self ) && !maps\mp\_utility::isusingremote() && anglestoforward( self.angles ) != var_1 )
        {
            var_1 = anglestoforward( self.angles );
            var_2 = self.origin + var_1 * -100 + ( 0.0, 0.0, 40.0 );
            var_0 moveto( var_2, 0.5 );
        }

        wait 0.5;
    }
}

_id_3552()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team != self.team )
        {
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
        }
    }
}

_id_3554()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team == self.team )
        {
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_1 );
        }
    }

    thread _id_A203();
    thread _id_A22E();
}

_id_2EE1()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.owner endon( "faux_spawn" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            thread _id_2EDF( var_1 );
            thread _id_2EE0( var_1 );
        }

        wait 1.1;
    }
}

_id_2EE0( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_X_nY_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_X_nY_nZ", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_nX_nY_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_nX_nY_nZ", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_nX_Y_nZ", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_nX_Y_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_X_Y_Z", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUST_SIDE_X_Y_nZ", var_0 );
}

_id_2EDF( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BA8 ) )
        playfxontagforclients( level._id_3575._id_3BA8, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BA8 ) )
        playfxontagforclients( level._id_3575._id_3BA8, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BA8 ) )
        playfxontagforclients( level._id_3575._id_3BA8, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BA8 ) )
        playfxontagforclients( level._id_3575._id_3BA8, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BA8 ) )
        playfxontagforclients( level._id_3575._id_3BA8, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BAE ) )
        playfxontagforclients( level._id_3575._id_3BAE, self, "TAG_THRUSTER_BTM", var_0 );

    wait 0.1;

    if ( isdefined( var_0 ) && isdefined( self ) && isdefined( level._id_3575._id_3BA8 ) )
        playfxontagforclients( level._id_3575._id_3BA8, self, "TAG_THRUSTER_BTM", var_0 );
}

_id_A203()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
        }
    }
}

_id_A22E()
{
    self endon( "death" );
    self.owner endon( "faux_spawn" );

    for (;;)
    {
        level waittill( "joined_team", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BAA, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
            wait 0.15;
            playfxontagforclients( level._id_3575._id_3BA7, self, "TAG_BEACON", var_0 );
        }
    }
}

_id_8D0D( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 thread _id_3553();
    var_0 thread createkillcamentity();

    if ( isdefined( var_0.type ) )
    {
        if ( var_0.type == "explosive_drone" )
            var_0 thread _id_1D03();
    }
}

_id_1D03()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    var_0 = gettime();
    thread _id_14C2( var_0 );
}

_id_14C2( var_0 )
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );

    while ( gettime() - var_0 < 3000 )
        waitframe();

    if ( isdefined( self ) )
    {
        self notify( "exploding" );
        thread _id_14C4();
    }
}

_id_14C4()
{
    var_0 = undefined;

    if ( isdefined( self ) )
    {
        if ( isdefined( self.owner ) )
            var_0 = self.owner;

        self playsound( level._id_3575._id_889A );
        wait 0.5;
    }

    if ( isdefined( self ) )
    {
        self playsound( "wpn_explosive_drone_exp" );
        var_1 = anglestoup( self.angles );
        var_2 = anglestoforward( self.angles );
        playfx( level._id_3575._id_3BAD, self.origin, var_2, var_1 );

        if ( isdefined( var_0 ) )
            self entityradiusdamage( self.origin, 256, 130, 55, var_0, "MOD_EXPLOSIVE", "explosive_drone_mp" );
        else
            self entityradiusdamage( self.origin, 256, 130, 55, undefined, "MOD_EXPLOSIVE", "explosive_drone_mp" );

        self notify( "death" );
    }
}

_id_992E()
{
    if ( isdefined( self ) )
    {

    }

    wait 0.05;

    if ( isdefined( self ) )
    {

    }

    wait 0.15;

    if ( isdefined( self ) )
        return;
}

_id_3553()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "exploding" );

    if ( !isdefined( self.owner ) )
    {
        thread _id_355A();
        return;
    }

    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self _meth_8283( self._id_3978, 10, 10 );
    self._id_6F66 = self.owner;
    self._id_94B6 = undefined;

    for (;;)
    {
        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.5;
            continue;
        }

        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            var_0 = self._id_5A54 * self._id_5A54;
            var_1 = var_0;

            if ( !isdefined( self._id_94B6 ) || self._id_94B6 == self.owner )
            {
                foreach ( var_3 in level.players )
                {
                    if ( isdefined( var_3 ) && isalive( var_3 ) && var_3 != self.owner && ( !level.teambased || var_3.team != self.team ) && !var_3 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                    {
                        var_4 = distancesquared( self.origin, var_3.origin );

                        if ( var_4 < var_1 )
                        {
                            var_1 = var_4;
                            self._id_94B6 = var_3;
                            thread _id_A243( var_3 );
                        }
                    }
                }
            }

            if ( !isdefined( self._id_94B6 ) )
                thread _id_356F();

            if ( isdefined( self._id_94B6 ) )
                _id_355B( self._id_94B6 );

            if ( self._id_94B6 != self._id_6F66 )
            {
                _id_8EE9( self._id_6F66 );
                self._id_6F66 = self._id_94B6;
            }
        }

        wait 1;
    }
}

_id_A243( var_0 )
{
    var_0 common_scripts\utility::waittill_any( "death", "disconnect", "faux_spawn", "joined_team" );

    if ( var_0.is_being_tracked == 1 )
        thread _id_355A();
    else
        self._id_94B6 = undefined;
}

_id_355B( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "explosiveDrone_moveToPlayer" );
    self endon( "explosiveDrone_moveToPlayer" );
    var_1 = 0;
    var_2 = 0;
    var_3 = 65;

    switch ( var_0 getstance() )
    {
        case "stand":
            var_3 = 65;
            break;
        case "crouch":
            var_3 = 50;
            break;
        case "prone":
            var_3 = 22;
            break;
    }

    var_4 = ( var_2, var_1, var_3 );
    self _meth_83F9( var_0, var_4 );
    self._id_4EC1 = 1;
    thread _id_3562();
    thread _id_3567();
}

_id_355C()
{
    self _meth_825B( self.origin, 1 );
    self._id_4EC1 = 0;
    self._id_4C0E = 1;
}

_id_3551( var_0 )
{
    maps\mp\_utility::incrementfauxvehiclecount();
    var_1 = var_0 _id_2400( 1, self.origin, self.angles );

    if ( !isdefined( var_1 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    if ( !isdefined( var_0._id_3569 ) )
        var_0._id_3569 = [];

    var_0._id_3569[var_0._id_3569.size] = var_1;
    var_0 thread _id_8D0D( var_1 );

    if ( isdefined( level._id_3575._id_3BAF ) )
    {

    }

    _id_739F();
    return 1;
}

_id_3559()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( self.owner ) )
    {
        thread _id_355A();
        return;
    }

    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self._id_54FE = spawn( "script_model", self.origin );
    self._id_54FE setmodel( "tag_laser" );

    for (;;)
    {
        if ( isdefined( self._id_94B6 ) )
        {
            self._id_54FE.origin = self gettagorigin( "tag_weapon" );
            var_0 = 20;
            var_1 = ( randomfloat( var_0 ), randomfloat( var_0 ), randomfloat( var_0 ) ) - ( 10.0, 10.0, 10.0 );
            var_2 = 65;

            switch ( self._id_94B6 getstance() )
            {
                case "stand":
                    var_2 = 65;
                    break;
                case "crouch":
                    var_2 = 50;
                    break;
                case "prone":
                    var_2 = 22;
                    break;
            }

            self._id_54FE.angles = vectortoangles( self._id_94B6.origin + ( 0, 0, var_2 - 20 ) + var_1 - self.origin );
        }

        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.5;
            continue;
        }

        var_3 = undefined;

        if ( isdefined( self._id_94B6 ) )
        {
            var_4 = bullettrace( self.origin, self._id_94B6.origin, 1, self );
            var_3 = var_4["entity"];
        }

        if ( isdefined( self._id_94B6 ) && self._id_94B6 != self.owner && isdefined( var_3 ) && var_3 == self._id_94B6 && distancesquared( self.origin, self._id_94B6.origin ) < self._id_5A3A * self._id_5A3A )
        {
            if ( self._id_94B6.is_being_tracked == 0 )
                _id_8D19( self._id_94B6 );
        }
        else if ( isdefined( self._id_94B6 ) && self._id_94B6.is_being_tracked == 1 )
            _id_8EE9( self._id_94B6 );

        wait 0.05;
    }
}

_id_8D19( var_0 )
{
    self._id_54FE laseron( "explosive_drone_laser" );
    playfxontag( level._id_3575._id_3BAB, self._id_54FE, "tag_laser" );

    if ( isdefined( level._id_3575._id_889A ) )
        self playsound( level._id_3575._id_889A );

    var_0 setperk( "specialty_radararrow", 1, 0 );

    if ( var_0.is_being_tracked == 0 )
    {
        var_0.is_being_tracked = 1;
        var_0.trackedbyplayer = self.owner;
    }
}

_id_8EE9( var_0 )
{
    if ( isdefined( self._id_54FE ) )
    {
        self._id_54FE laseroff();
        stopfxontag( level._id_3575._id_3BAB, self._id_54FE, "tag_laser" );
    }

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( level._id_3575._id_889A ) )
            self stoploopsound();

        if ( var_0 hasperk( "specialty_radararrow", 1 ) )
            var_0 unsetperk( "specialty_radararrow", 1 );

        var_0 notify( "player_not_tracked" );
        var_0.is_being_tracked = 0;
        var_0.trackedbyplayer = undefined;
    }
}

_id_64A8()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.is_being_tracked = 0;

        foreach ( var_0 in level.players )
        {
            if ( !isdefined( var_0.is_being_tracked ) )
                var_0.is_being_tracked = 0;
        }
    }
}

_id_3562()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "explosiveDrone_watchForGoal" );
    self endon( "explosiveDrone_watchForGoal" );
    var_0 = common_scripts\utility::waittill_any_return( "goal", "near_goal", "hit_goal" );
    self._id_4EC1 = 0;
    self._id_4C0E = 0;
    self notify( "hit_goal" );
}

_id_3560()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );
    thread _id_356E();
}

_id_3568()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    var_0 = level._id_3576;

    if ( self.type == "explosive_drone" )
        var_0 = level._id_3576;

    wait(var_0);
    thread _id_355A();
}

_id_3565()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "owner_gone" );
    thread _id_355A();
}

_id_3564()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    for (;;)
    {
        self.owner waittill( "death" );
        thread _id_355A();
    }
}

_id_3567()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "explosiveDrone_watchTargetDisconnect" );
    self endon( "explosiveDrone_watchTargetDisconnect" );
    self._id_94B6 waittill( "disconnect" );
    _id_8EE9( self._id_94B6 );
    _id_355B( self.owner );
}

_id_3566()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level common_scripts\utility::waittill_any( "round_end_finished", "game_ended" );
    thread _id_355A();
}

_id_3563()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level waittill( "host_migration_begin" );
    _id_8EE9( self._id_94B6 );
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    thread _id_3551( self.owner );
}

_id_355A()
{
    self endon( "death" );
    self notify( "leaving" );
    _id_8EE9( self._id_94B6 );
    _id_356F();
}

_id_64A7( var_0, var_1, var_2, var_3 )
{
    self notify( "death" );
}

_id_3558()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    self.stunned = 0;

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        thread _id_3557();
    }
}

_id_3561()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        thread _id_355F();
    }
}

_id_3557()
{
    self notify( "explosiveDrone_stunned" );
    self endon( "explosiveDrone_stunned" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    _id_3555();
    wait 10.0;
    _id_3556();
}

_id_355F()
{
    self notify( "explosiveDrone_stunned" );
    self endon( "explosiveDrone_stunned" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    _id_355D();
    wait 10.0;
    _id_355E();
}

_id_3555()
{
    if ( self.stunned )
        return;

    self.stunned = 1;

    if ( isdefined( level._id_3575._id_3BAF ) )
        playfxontag( level._id_3575._id_3BAF, self, "TAG_BEACON" );
}

_id_355D()
{
    if ( self.stunned )
        return;

    self.stunned = 1;

    if ( isdefined( level._id_3575._id_3BAF ) )
        playfxontag( level._id_3575._id_3BAF, self, "TAG_BEACON" );

    thread _id_8EE9( self._id_94B6 );
    self._id_94B6 = undefined;
    self._id_6F66 = self.owner;
    thread _id_355C();
}

_id_3556()
{
    if ( isdefined( level._id_3575._id_3BAF ) )
        killfxontag( level._id_3575._id_3BAF, self, "TAG_BEACON" );

    self.stunned = 0;
    self._id_4C0E = 0;
}

_id_355E()
{
    if ( isdefined( level._id_3575._id_3BAF ) )
        killfxontag( level._id_3575._id_3BAF, self, "TAG_BEACON" );

    self.stunned = 0;
    self._id_4C0E = 0;
}

_id_356E()
{
    if ( !isdefined( self ) )
        return;

    _id_8EE9( self._id_94B6 );
    _id_355E();
    _id_356F();
}

_id_356F()
{
    if ( isdefined( level._id_3575._id_3BA9 ) )
        playfx( level._id_3575._id_3BA9, self.origin );

    if ( isdefined( level._id_3575._id_8898 ) )
        self playsound( level._id_3575._id_8898 );

    self notify( "exploding" );
    _id_739F();
}

_id_2850()
{
    if ( isdefined( self._id_0E54 ) )
        missile_deleteattractor( self._id_0E54 );

    removekillcamentity();
    self delete();
}

_id_739F()
{
    maps\mp\_utility::decrementfauxvehiclecount();

    if ( isdefined( self.owner ) && isdefined( self.owner.explosivedrone ) )
        self.owner.explosivedrone = undefined;

    _id_2850();
}

_id_084A()
{
    level.explosivedrones[self getentitynumber()] = self;
}

_id_73A5()
{
    var_0 = self getentitynumber();
    self waittill( "death" );
    level.explosivedrones[var_0] = undefined;
    level.explosivedrones = common_scripts\utility::array_removeundefined( level.explosivedrones );
}

_id_33E0()
{
    if ( isdefined( level.explosivedrones ) && level.explosivedrones.size >= maps\mp\_utility::maxvehiclesallowed() )
        return 1;
    else
        return 0;
}

_id_3573()
{
    self endon( "mine_destroyed" );
    self endon( "mine_selfdestruct" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    wait 3;

    if ( isdefined( self ) && isdefined( self.explosivedrone ) )
    {
        var_0 = self.explosivedrone gettagorigin( "TAG_BEACON" ) - self gettagorigin( "TAG_BEACON" ) + ( 0.0, 0.0, 10.0 );

        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( self.owner.team, var_0, "TAG_BEACON" );
        else
            maps\mp\_entityheadicons::setplayerheadicon( self.owner, var_0, "TAG_BEACON" );

        var_1 = spawn( "trigger_radius", self.origin + ( 0.0, 0.0, -96.0 ), 0, 192, 192 );
        var_1.owner = self;
        thread _id_356D( var_1 );
        thread _id_A21F( var_1 );
        var_2 = undefined;

        while ( isdefined( self ) && isdefined( self.explosivedrone ) )
        {
            var_1 waittill( "trigger", var_2 );

            if ( !isdefined( var_2 ) )
            {
                wait 0.1;
                continue;
            }

            if ( var_2 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
            {
                wait 0.1;
                continue;
            }

            if ( isdefined( self.explosivedrone ) && !var_2 sightconetrace( self.explosivedrone gettagorigin( "TAG_BEACON" ), self.explosivedrone ) )
            {
                wait 0.1;
                continue;
            }

            if ( isdefined( self.explosivedrone ) )
            {
                var_3 = self.explosivedrone gettagorigin( "TAG_BEACON" );
                var_4 = var_2 geteye();

                if ( !bullettracepassed( var_3, var_4, 0, self.explosivedrone ) )
                {
                    wait 0.1;
                    continue;
                }
            }

            if ( maps\mp\_utility::isreallyalive( var_2 ) && var_2 != self.owner && ( !level.teambased || var_2.team != self.owner.team ) && !self.stunned )
                var_2 _id_98A7( self );
        }
    }
}

_id_356D( var_0 )
{
    common_scripts\utility::waittill_any( "mine_triggered", "mine_destroyed", "mine_selfdestruct", "death" );

    if ( isdefined( self.entityheadicon ) )
    {
        self notify( "kill_entity_headicon_thread" );
        self.entityheadicon destroy();
    }

    var_0 delete();
}

_id_84FF( var_0 )
{
    var_1 = spawnfx( level._id_3575._id_2CF1, var_0.origin );
    triggerfx( var_1 );
    self waittill( "death" );
    var_1 delete();
}

_id_31B8()
{
    self.owner common_scripts\utility::waittill_any( "spawned_player", "faux_spawn", "delete_explosive_drones" );
    explosivegrenadedeath();
}

_id_5EC5()
{
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    common_scripts\utility::waittill_any( "mine_selfdestruct" );
    explosivegrenadedeath();
}

_id_5E6B()
{
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );

    while ( isdefined( self.explosivedrone ) )
        wait 0.15;

    if ( isdefined( self ) )
    {
        self playsound( "wpn_explosive_drone_exp" );
        var_0 = anglestoup( self.angles );
        var_1 = anglestoforward( self.angles );
        playfx( level._id_3575._id_3BAD, self.origin, var_1, var_0 );
        self entityradiusdamage( self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp" );
        self notify( "death" );
    }

    explosivegrenadedeath();
}

_id_8D14()
{
    self endon( "death" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    var_0 = 0.6;

    while ( isdefined( self.explosivedrone ) )
    {
        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2 ) && issentient( var_2 ) && var_2.team == self.team && isdefined( self.explosivedrone ) )
                thread _id_3B9F( level._id_3575._id_3BAA, self.explosivedrone, "TAG_BEACON", var_2 );

            if ( isdefined( var_2 ) && issentient( var_2 ) && var_2.team != self.team && isdefined( self.explosivedrone ) )
                thread _id_3B9F( level._id_3575._id_3BA7, self.explosivedrone, "TAG_BEACON", var_2 );
        }

        wait(var_0);
    }
}

_id_3B9F( var_0, var_1, var_2, var_3 )
{
    for ( var_4 = 0; var_4 <= 4 && isdefined( var_1 ); var_4++ )
    {
        if ( isdefined( var_3 ) && isdefined( var_1 ) && isdefined( self.stunned ) && !self.stunned )
        {
            playfxontagforclients( var_0, var_1, var_2, var_3 );
            wait 0.15;
        }
    }
}

_id_A221()
{
    self endon( "death" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    var_0 = undefined;
    var_0 = common_scripts\utility::waittill_any_return_parms( "missile_stuck", "mp_exo_repulsor_repel" );

    while ( !isdefined( self.explosivedrone ) )
        waitframe();

    if ( isdefined( var_0[1] ) )
    {
        var_1 = var_0[1]._id_7ADA;

        if ( var_0[1].classname == "script_model" && !( isdefined( var_1 ) && var_1 == 1 ) )
        {
            self playsound( "wpn_explosive_drone_exp" );
            var_2 = anglestoup( self.angles );
            var_3 = anglestoforward( self.angles );
            playfx( level._id_3575._id_3BAD, self.origin, var_3, var_2 );
            self entityradiusdamage( self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp" );
            thread explosivegrenadedeath();
        }
    }

    if ( isdefined( self ) )
    {
        self.explosivedrone setcontents( self.explosivedrone.oldcontents );
        thread _id_3573();
        thread _id_31B8();
        thread _id_3558();
        thread _id_8D14();
        thread maps\mp\gametypes\_damage::setentitydamagecallback( 100, undefined, ::explosivegrenadedeath, undefined, 0 );
        self.explosivedrone thread maps\mp\gametypes\_damage::setentitydamagecallback( 100, undefined, ::_id_357A, undefined, 0 );
        thread maps\mp\gametypes\_weapons::stickyhandlemovers( "mine_selfdestruct" );
    }
}

createkillcamentity()
{
    var_0 = ( 0.0, 0.0, 0.0 );
    self.killcament = spawn( "script_model", self.origin );
    self.killcament setscriptmoverkillcam( "explosive" );
    self.killcament linkto( self, "TAG_THRUSTER_BTM", var_0, ( 0.0, 0.0, 0.0 ) );
    self.killcament setcontents( 0 );
    self.killcament.starttime = gettime();
}

removekillcamentity()
{
    if ( isdefined( self.killcament ) )
        self.killcament delete();
}

_id_A21F( var_0 )
{
    self.owner endon( "disconnect" );
    self.owner endon( "faux_spawn" );
    level endon( "game_ended" );
    self endon( "death" );
    self.owner endon( "death" );
    self.explosivedrone makeusable();
    self.explosivedrone sethintstring( &"MP_PICKUP_EXPLOSIVE_DRONE" );
    self.explosivedrone _meth_849B( 1 );
    var_1 = getdvarfloat( "player_useRadius", 128 );
    var_1 *= var_1;

    for (;;)
    {
        if ( !isdefined( self ) || !isdefined( var_0 ) )
            break;

        var_2 = isdefined( self.explosivedrone ) && distancesquared( self.owner geteye(), self.explosivedrone.origin ) <= var_1;

        if ( self.owner istouching( var_0 ) && var_2 )
        {
            var_3 = 0;

            while ( self.owner usebuttonpressed() )
            {
                if ( !maps\mp\_utility::isreallyalive( self.owner ) )
                    break;

                if ( !self.owner istouching( var_0 ) )
                    break;

                if ( self.owner fragbuttonpressed() || self.owner secondaryoffhandbuttonpressed() || isdefined( self.owner.throwinggrenade ) )
                    break;

                if ( self.owner isusingturret() || self.owner maps\mp\_utility::isusingremote() )
                    break;

                if ( isdefined( self.owner.iscapturingcrate ) && self.owner.iscapturingcrate )
                    break;

                if ( isdefined( self.owner.empgrenaded ) && self.owner.empgrenaded )
                    break;

                if ( isdefined( self.owner.using_remote_turret ) && self.owner.using_remote_turret )
                    break;

                var_3 += 0.05;

                if ( var_3 > 0.75 )
                {
                    self.owner setweaponammostock( self.weaponname, self.owner getweaponammostock( self.weaponname ) + 1 );
                    self.explosivedrone _id_2850();
                    self delete();
                    break;
                }

                waitframe();
            }
        }

        waitframe();
    }
}
