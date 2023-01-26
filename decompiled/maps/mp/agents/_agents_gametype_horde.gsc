// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    level thread _id_76E5();

    if ( maps\mp\_utility::getmapname() == "mp_detroit" )
        level.goliathexploittrigger = spawn( "trigger_radius", ( -1662.0, -72.0, 582.5 ), 0, 86, 64 );
}

_id_806C()
{
    level._id_0897["player"]["onAIConnect"] = ::_id_644A;
    level._id_0897["player"]["think"] = ::_id_32A0;
    level._id_0897["player"]["on_killed"] = ::_id_6448;
    level._id_0897["squadmate"]["onAIConnect"] = ::_id_644A;
    level._id_0897["squadmate"]["think"] = ::_id_0AD8;
    level._id_0897["dog"]["onAIConnect"] = ::_id_644A;
    level._id_0897["dog"]["think"] = ::_id_08A5;
    level._id_0897["dog"]["on_killed"] = ::_id_646B;
}

_id_644A()
{
    self._id_3BF2 = 1;
    self.agentname = &"HORDE_GRUNT";
    self._id_4949 = "";
}

_id_76E5()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "start_round" );
        wait 2;

        if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level._id_2520 > 10 )
        {
            _id_76E8();
            continue;
        }

        _id_76E2();
    }
}

_id_76E2()
{
    level childthread _id_4893();

    while ( level._id_2514 < level._id_5A32 )
    {
        while ( level._id_2509 < level._id_5A1E )
        {
            _id_23FD();

            if ( level._id_2514 == level._id_5A32 )
                break;
        }

        level._id_A2A3 = 0;
        level waittill( "enemy_death" );
    }
}

_id_76E8()
{
    level._id_A3CB = 0;
    level waittill( "beginZombieSpawn" );

    while ( level._id_2514 < level._id_5A32 )
    {
        while ( level._id_2509 < level._id_5A1E )
        {
            _id_23FD();
            wait 0.1;
        }

        level._id_A2A3 = 0;
        level common_scripts\utility::waittill_any( "enemy_death", "go_zombie" );
        level._id_A3CB++;
    }
}

_id_23FD()
{
    if ( level._id_5A30 > 1 && level._id_2CD9 < level._id_5A30 )
        _id_23F5();
    else if ( level.maxwarbirdcount > 0 )
    {
        foreach ( var_1 in level.players )
        {
            if ( _id_A798::_id_5164( var_1 ) && isalive( var_1 ) )
            {
                level.maxwarbirdcount--;
                var_1 createwarbirdenemy();
                break;
            }
        }
    }
    else if ( level._id_5A31 > 0 )
    {
        _id_23F8();
        level._id_5A31--;
    }
    else
        _id_241F();
}

_id_241F()
{
    var_0 = undefined;

    while ( !isdefined( var_0 ) )
    {
        var_0 = maps\mp\agents\_agents::add_humanoid_agent( "player", level._id_32C5, "class1" );

        if ( isdefined( var_0 ) )
        {
            level._id_2514++;
            level._id_2509++;
        }

        waitframe();
    }
}

_id_23F5()
{
    var_0 = undefined;

    while ( !isdefined( var_0 ) )
    {
        var_0 = maps\mp\agents\_agent_common::_id_214C( "dog", level._id_32C5 );

        if ( isdefined( var_0 ) )
        {
            var_0 thread [[ var_0 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]();
            var_0._id_120E = 100;
            level._id_2514++;
            level._id_2509++;
            level._id_2CD9++;
        }

        waitframe();
    }
}

_id_23F8()
{
    thread _id_A046();
    level._id_2514++;
    level._id_2509++;
}

_id_A046()
{
    level._id_6298++;

    while ( maps\mp\_utility::currentactivevehiclecount( 2 ) >= maps\mp\_utility::maxvehiclesallowed() )
        wait 1;

    level._id_6298--;
    waitframe();
    var_0 = _id_A794::_id_4969( level.players[0], "assault_uav_horde", level._id_4980 );
    var_0 _meth_83FA( level._id_32B6, 1 );
    var_0._id_2F34 _meth_83FA( level._id_32B6, 1 );
    var_0._id_65C2 = level._id_32B6;
}

createwarbirdenemy()
{
    thread maps\mp\gametypes\_horde_warbird::hordecreatewarbird();
    handle_first_warbird();
}

handle_first_warbird()
{
    if ( !isdefined( level.first_warbird_spawned ) )
        level.first_warbird_spawned = 1;
    else
        return;

    while ( !isdefined( level._id_89A1 ) )
        waitframe();

    level._id_89A1[0] endon( "death" );
    level._id_89A1[0] endon( "crashing" );
    wait 30;
}

_id_6A20()
{
    playfx( level._effect["spawn_effect"], self.origin );
}

_id_4893()
{
    level endon( "round_ended" );

    for (;;)
    {
        level waittill( "enemy_death" );

        if ( level._id_2514 != level._id_5A32 )
            continue;

        if ( level._id_2509 < 3 )
        {
            foreach ( var_1 in level.flying_attack_drones )
            {
                var_1 _meth_83FA( level._id_32B6, 0 );
                var_1._id_2F34 _meth_83FA( level._id_32B6, 0 );
                var_1._id_5605 = 1;
            }

            foreach ( var_4 in level._id_89A1 )
            {
                if ( isdefined( var_4.team ) && var_4.team == "axis" && !( isdefined( var_4.iscrashing ) && var_4.iscrashing ) )
                {
                    var_4 _meth_83FA( level._id_32B6, 0 );
                    var_4._id_A196 _meth_83FA( level._id_32B6, 0 );
                    var_4._id_5605 = 1;
                }
            }

            foreach ( var_7 in level.characters )
            {
                if ( _id_A798::_id_5164( var_7 ) )
                    continue;

                if ( maps\mp\_utility::isreallyalive( var_7 ) && !var_7 iscloaked() )
                {
                    var_7 _meth_83FA( level._id_32B6, 0 );
                    var_7._id_65C2 = level._id_32B6;
                }
            }

            setdvar( "bg_compassShowEnemies", 1 );
            break;
        }
    }
}

_id_6448( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !_id_A798::_id_5164( self ) )
        _id_498B( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    self _meth_83FB();
    maps\mp\agents\_agents::_id_643F( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
    maps\mp\agents\_agent_utility::_id_2630();
}

_id_646B( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !_id_A798::_id_5164( self ) )
        _id_498B( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    self _meth_83FB();
    maps\mp\killstreaks\_dog_killstreak::_id_6435( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

_id_498B( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    level._id_2509--;
    level._id_537C++;
    level._id_537B++;

    if ( level._id_62DC )
        maps\mp\gametypes\horde::checkdefendkill( self, var_1 );

    _id_94F7( var_4, var_3 );
    level thread maps\mp\gametypes\horde::_id_1C67( self );
    level notify( "enemy_death", var_1, self );
    level._id_31D4--;

    if ( !level._id_A3D0 )
        setomnvar( "ui_horde_enemies_left", level._id_31D4 );

    if ( isplayer( var_1 ) && !level._id_A3D0 )
    {
        _id_A798::_id_120A( var_1 );
        var_1 thread maps\mp\gametypes\_rank::xppointspopup( "kill", self._id_120E );
        level thread _id_A798::_id_49D8( var_1, self._id_120E );

        if ( var_1 maps\mp\_utility::_hasperk( "specialty_triggerhappy" ) )
        {

        }
    }

    if ( isdefined( var_1 ) && isdefined( var_1.owner ) && isplayer( var_1.owner ) && isdefined( var_1.owner._id_53B5 ) )
    {
        _id_A798::_id_120A( var_1.owner );
        var_1.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", self._id_120E );
        level thread _id_A798::_id_49D8( var_1.owner, self._id_120E );
    }
}

_id_94F7( var_0, var_1 )
{
    if ( level._id_51CA )
        return;

    if ( var_0 == "none" )
        return;

    if ( maps\mp\_utility::ismeleemod( var_1 ) )
        level._id_62A4++;

    if ( !maps\mp\_utility::iskillstreakweapon( var_0 ) && var_1 == "MOD_HEAD_SHOT" )
        level._id_62A1++;

    if ( maps\mp\_utility::iskillstreakweapon( var_0 ) && var_0 != level._id_4E9A )
        level._id_62A3++;

    if ( maps\mp\gametypes\_class::isvalidequipment( var_0, 0 ) || maps\mp\gametypes\_class::isvalidoffhand( var_0, 0 ) )
        level._id_629B++;
}

_id_32A0()
{
    self endon( "death" );
    level endon( "game_ended" );
    self _meth_8351( "no_enemy_search", 1 );
    thread _id_5E2D();
    thread _id_57F0();
}

_id_5E2D()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = gettime();

    for (;;)
    {
        wait 5.0;

        if ( !maps\mp\bots\_bots_util::_id_1650( 120000 ) )
        {
            if ( !maps\mp\bots\_bots_util::_id_1650( 240000 ) )
                break;
        }

        if ( _id_1CFD( var_0, 240, 480 ) )
            break;
    }
}

_id_5E2C()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = gettime();
    var_1 = self.origin;
    var_2 = var_0;

    for (;;)
    {
        wait 5.0;
        var_3 = distancesquared( self.origin, var_1 );
        var_4 = ( gettime() - var_2 ) / 1000;

        if ( var_3 > 16384 )
        {
            var_1 = self.origin;
            var_2 = gettime();
        }
        else if ( var_4 > 25 )
        {
            if ( var_4 > 55 )
                break;
        }

        if ( _id_1CFD( var_0, 120, 240 ) )
            break;
    }

    maps\mp\agents\_agent_utility::_id_5346( self );
}

_id_1CFD( var_0, var_1, var_2 )
{
    var_3 = ( gettime() - var_0 ) / 1000;

    if ( var_3 > var_1 )
    {
        if ( var_3 > var_2 )
            return 1;
    }

    return 0;
}

_id_0AD8()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    self _meth_8351( "force_sprint", 1 );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        if ( float( self.owner.health ) / self.owner.maxhealth < 0.5 && gettime() > var_1 )
        {
            var_2 = getnodesinradiussorted( self.owner.origin, 256, 0 );

            if ( var_2.size >= 2 )
            {
                self._id_27B0 = var_2[1];
                self notify( "defend_force_node_recalculation" );
                var_1 = gettime() + 1000;
            }
        }
        else if ( float( self.health ) / self.maxhealth >= 0.6 )
            var_0 = 0;
        else if ( !var_0 )
        {
            var_3 = maps\mp\bots\_bots_util::_id_1615( self.owner.origin, 350, 1 );

            if ( isdefined( var_3 ) )
            {
                self._id_27B0 = var_3;
                self notify( "defend_force_node_recalculation" );
                var_0 = 1;
            }
        }

        if ( !maps\mp\bots\_bots_util::_id_165F( self.owner ) )
        {
            var_4["override_goal_type"] = "critical";
            var_4["min_goal_time"] = 20;
            var_4["max_goal_time"] = 30;
            maps\mp\bots\_bots_strategy::_id_1646( self.owner, 350, var_4 );
        }

        wait 0.05;
    }
}

_id_49C6()
{
    self._id_310E = 0;
    self.agentname = &"HORDE_QUAD";
    self._id_4949 = "Quad";
    thread maps\mp\gametypes\horde::_id_4955();
    self._id_5500 = ( 0.0, 0.0, 0.0 );
    self._id_1434 = 0;
    self._id_7128 = 0;
    self.maxhealth = 60;
    self.health = self.maxhealth;
}

_id_08A5()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    maps\mp\agents\dog\_dog_think::_id_830A();
    _id_49C6();
    thread _id_57F0();
    self thread [[ self._id_A1F7 ]]();
    thread _id_A009();
    thread _id_5E2C();
    thread _id_08A4();

    for (;;)
    {
        if ( self._id_09A3 != "melee" && !self._id_03FC && maps\mp\agents\dog\_dog_think::_id_71E3() && !maps\mp\agents\dog\_dog_think::_id_2A49() )
            self _meth_839C( self._id_24C6 );

        if ( self._id_7128 > gettime() )
        {
            wait 0.05;
            continue;
        }

        if ( !isdefined( self._id_0143 ) || self._id_1434 )
        {
            var_0 = getnodesinradiussorted( self.origin, 1024, 256, 128, "Path" );

            if ( var_0.size > 0 )
            {
                var_1 = randomintrange( int( var_0.size * 0.9 ), var_0.size );
                self _meth_8390( var_0[var_1].origin );
                self._id_1434 = 0;
                self._id_7128 = gettime() + 2500;
            }
        }
        else
        {
            var_2 = maps\mp\agents\dog\_dog_think::_id_3F0A( self._id_0143 );
            self._id_24C6 = self._id_0143;
            self._id_02A6 = "sprint";
            self._id_12EE = 0;

            if ( distancesquared( var_2, self._id_5500 ) > 4096 )
            {
                self _meth_8390( var_2 );
                self._id_5500 = var_2;
            }
        }

        wait 0.05;
    }
}

_id_08A4()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        while ( !isdefined( self._id_24C6 ) )
            wait 0.25;

        while ( isdefined( self._id_24C6 ) && distance( self.origin, self._id_24C6.origin ) > 200 )
        {
            wait(randomfloatrange( 0, 2 ));
            self playsound( "anml_doberman_bark" );
        }

        wait 0.05;
    }
}

_id_A009()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "bad_path", var_0 );
        self._id_1434 = 1;
    }
}

_id_57F0()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        foreach ( var_1 in level.participants )
        {
            if ( _id_A798::_id_5164( var_1 ) )
            {
                self _meth_8165( var_1 );

                if ( isdefined( var_1._id_497C ) )
                    self _meth_8165( var_1._id_497C );
            }
        }

        wait 0.5;
    }
}

_id_377B()
{
    var_0 = undefined;
    var_1 = 1410065408;

    foreach ( var_3 in level.players )
    {
        if ( maps\mp\_utility::isreallyalive( var_3 ) && _id_A798::_id_5164( var_3 ) && !_id_A798::_id_5175( var_3 ) )
        {
            var_4 = distancesquared( var_3.origin, self.origin );

            if ( var_4 < var_1 )
            {
                var_0 = var_3;
                var_1 = var_4;
            }
        }
    }

    return var_0;
}

handledetroitgoliathtrailerexploit()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait 1;

    for (;;)
    {
        if ( isdefined( self._id_0143 ) && self._id_0143 istouching( level.goliathexploittrigger ) )
        {
            self botsetscriptgoal( ( -1696.0, -408.0, 608.5 ), 32, "critical", 200 );

            while ( isdefined( self._id_0143 ) && maps\mp\_utility::isreallyalive( self._id_0143 ) && !_id_A798::_id_5175( self._id_0143 ) && self._id_0143 istouching( level.goliathexploittrigger ) )
                wait 0.25;

            self _meth_8356();
        }

        wait 1;
    }
}

hordejuggrocketswarmthink()
{
    self endon( "death" );
    level endon( "game_ended" );

    while ( !isdefined( self._id_0143 ) || !sighttracepassed( self gettagorigin( "TAG_ROCKET4" ), self._id_0143 geteye(), 0, undefined ) )
        wait 0.05;

    wait(randomintrange( 5, 10 ));

    for (;;)
    {
        while ( !isdefined( self._id_0143 ) || !sighttracepassed( self gettagorigin( "TAG_ROCKET4" ), self._id_0143 geteye(), 0, undefined ) )
            wait 0.05;

        var_0 = anglestoforward( self getangles() );
        var_1 = anglestoright( self getangles() );
        var_2 = [ ( 0.0, 0.0, 50.0 ), ( 0.0, 0.0, 20.0 ), ( 10.0, 0.0, 0.0 ), ( 0.0, 10.0, 0.0 ) ];
        var_3 = self gettagorigin( "TAG_ROCKET4" );
        playfxontag( common_scripts\utility::getfx( "swarm_rocket_wv" ), self, "TAG_ROCKET4" );

        for ( var_4 = 0; var_4 < 4; var_4++ )
        {
            var_5 = var_3 + var_0 * 20 + var_1 * -30;
            var_6 = var_0 + maps\mp\killstreaks\_juggernaut::_id_7117( 0.2 );
            var_7 = magicbullet( "iw5_juggernautrockets_mp", var_3, self._id_0143 geteye(), self );
            var_7 thread _id_7592( self._id_0143, var_2[var_4] );
            var_7 thread maps\mp\killstreaks\_juggernaut::_id_758C( 7 );
            wait 0.1;
        }

        wait(randomintrange( 10, 20 ));
    }
}

_id_7592( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        self missile_settargetent( var_0, var_1 );
}
