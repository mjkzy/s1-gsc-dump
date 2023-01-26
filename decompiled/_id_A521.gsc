// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

initglobals()
{
    if ( getdvar( "debug_drones" ) == "" )
        setdvar( "debug_drones", "0" );

    if ( !isdefined( level._id_5852 ) )
        level._id_2E89 = 200;

    if ( !isdefined( level._id_59FC ) )
        level._id_59FC = [];

    if ( !isdefined( level._id_59FC["allies"] ) )
        level._id_59FC["allies"] = 99999;

    if ( !isdefined( level._id_59FC["axis"] ) )
        level._id_59FC["axis"] = 99999;

    if ( !isdefined( level._id_59FC["team3"] ) )
        level._id_59FC["team3"] = 99999;

    if ( !isdefined( level._id_59FC["neutral"] ) )
        level._id_59FC["neutral"] = 99999;

    if ( !isdefined( level._id_2F19 ) )
        level._id_2F19 = [];

    if ( !isdefined( level._id_2F19["allies"] ) )
        level._id_2F19["allies"] = _id_A59A::_id_8F5C();

    if ( !isdefined( level._id_2F19["axis"] ) )
        level._id_2F19["axis"] = _id_A59A::_id_8F5C();

    if ( !isdefined( level._id_2F19["team3"] ) )
        level._id_2F19["team3"] = _id_A59A::_id_8F5C();

    if ( !isdefined( level._id_2F19["neutral"] ) )
        level._id_2F19["neutral"] = _id_A59A::_id_8F5C();

    level._id_2EBF = ::_id_2E60;
}

_id_2E60()
{
    if ( level._id_2F19[self.team]._id_0CD8.size >= level._id_59FC[self.team] )
    {
        self delete();
        return;
    }

    thread _id_2E25( self );
    level notify( "new_drone" );
    self setcandamage( 1 );
    _id_A523::_id_2E57();

    if ( isdefined( self._id_79A9 ) )
        return;

    thread _id_2E92();
    thread _id_2E3A();

    if ( isdefined( self.target ) )
    {
        if ( !isdefined( self._id_7A3A ) )
            thread _id_2E94();
        else
            thread _id_2EEE();
    }

    if ( isdefined( self._id_7A24 ) && self._id_7A24 == 0 )
        return;

    thread _id_2E5B();
}

_id_2E25( var_0 )
{
    _id_A59A::_id_8F5F( level._id_2F19[var_0.team], var_0 );
    var_1 = var_0.team;
    var_0 waittill( "death" );

    if ( isdefined( var_0 ) && isdefined( var_0._id_8F5B ) )
        _id_A59A::_id_8F61( level._id_2F19[var_1], var_0._id_8F5B );
    else
        _id_A59A::_id_8F62( level._id_2F19[var_1] );
}

_id_2E3A()
{
    _id_2EED();

    if ( !isdefined( self ) )
        return;

    var_0 = "stand";

    if ( isdefined( self._id_0C80 ) && isdefined( level._id_2E21[self.team][self._id_0C80] ) && isdefined( level._id_2E21[self.team][self._id_0C80]["death"] ) )
        var_0 = self._id_0C80;

    var_1 = level._id_2E21[self.team][var_0]["death"];

    if ( isdefined( self._id_2651 ) )
        var_1 = self._id_2651;

    self notify( "death" );

    if ( isdefined( level._id_2E39 ) )
    {
        self thread [[ level._id_2E39 ]]( var_1 );
        return;
    }

    if ( !( isdefined( self._id_6156 ) && isdefined( self._id_85B4 ) ) )
    {
        if ( isdefined( self._id_6156 ) )
            _id_2E9F( var_1, "deathplant" );
        else if ( isdefined( self._id_85B4 ) )
        {
            self startragdoll();
            _id_2E9F( var_1, "deathplant" );
        }
        else
        {
            _id_2E9F( var_1, "deathplant" );
            self startragdoll();
        }
    }

    self notsolid();
    thread _id_2EDC( 2 );

    if ( isdefined( self ) && isdefined( self._id_611C ) )
        return;

    wait 10;

    while ( isdefined( self ) )
    {
        if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, self.origin, 0.5 ) )
            self delete();

        wait 5;
    }
}

_id_2E92()
{
    self endon( "death" );

    for (;;)
    {
        while ( !isdefined( self._id_0101 ) || !self._id_0101 )
            wait 0.05;

        var_0 = self.health;
        self.health = 100000;

        while ( isdefined( self._id_0101 ) && self._id_0101 )
            wait 0.05;

        self.health = var_0;
        wait 0.05;
    }
}

_id_2EED()
{
    self endon( "death" );

    while ( isdefined( self ) )
    {
        self waittill( "damage" );

        if ( isdefined( self._id_0101 ) && self._id_0101 )
        {
            self.health = 100000;
            continue;
        }

        if ( self.health <= 0 )
            break;
    }
}

_id_2EDC( var_0 )
{
    wait(var_0);

    if ( isdefined( self ) )
        self thermaldrawdisable();
}

#using_animtree("generic_human");

_id_2E9E( var_0, var_1 )
{
    if ( isdefined( self._id_2E8B ) )
        self [[ self._id_2E8C ]]( var_0, var_1 );
    else
    {
        self _meth_8142( %body, 0.2 );
        self _meth_8141();
        self _meth_8110( "drone_anim", var_0, %body, 1, 0.2, var_1 );
        self._id_2EF6 = var_0;
    }
}

_id_2E9F( var_0, var_1 )
{
    if ( self.type == "human" )
        self _meth_8142( %body, 0.2 );

    self _meth_8141();
    var_2 = "normal";

    if ( isdefined( var_1 ) )
        var_2 = "deathplant";

    var_3 = "drone_anim";
    self _meth_813E( var_3, self.origin, self.angles, var_0, var_2 );
    self waittillmatch( "drone_anim", "end" );
}

_id_2E42()
{
    if ( !isdefined( self ) )
        return;

    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    var_0 = getweaponmodel( self.weapon );
    var_1 = self.weapon;

    if ( isdefined( var_0 ) )
    {
        _id_A59A::_id_2974( self.weapon );
        self detach( var_0, "tag_weapon_right" );
        var_2 = self gettagorigin( "tag_weapon_right" );
        var_3 = self gettagangles( "tag_weapon_right" );
        var_4 = spawn( "weapon_" + var_1, ( 0.0, 0.0, 0.0 ) );
        var_4.angles = var_3;
        var_4.origin = var_2;
    }
}

_id_2EB6( var_0 )
{
    if ( isdefined( anim._id_0CCA[var_0] ) )
    {
        var_1 = anim._id_0CCA[var_0]["idle"]["stand"][0];
        var_1 = common_scripts\utility::array_combine( var_1, anim._id_0CCA[var_0]["idle"]["stand"][1] );
        var_2 = anim._id_0CCA[var_0]["idle"]["stand"][0][0];
        self._id_2E22 = var_2;
        self._id_2E23 = var_1;
        self._id_2E5C = 1;
        self._id_2E5D = ::_id_2E24;
        thread _id_2E5B( undefined, undefined );
    }
}

_id_2E24()
{
    self endon( "death" );
    var_0 = 10;

    if ( !isdefined( self._id_2E23 ) || !isarray( self._id_2E23 ) )
        return;

    self _meth_8142( %body, 0.2 );
    self _meth_8141();
    var_1 = 1;
    animscripts\face::_id_6D98( undefined, "idle", undefined );

    for (;;)
    {
        var_2 = common_scripts\utility::random( self._id_2E23 );

        if ( randomint( 100 ) < var_0 || var_1 )
        {
            self _meth_8110( "drone_anim", var_2, %body, 1, 0.2, 1 );
            var_1 = 0;
        }

        self waittillmatch( "drone_anim", "end" );
        self _meth_8110( "drone_anim", self._id_2E22, %body, 1, 0.2, 1 );
    }
}

_id_2E5B( var_0, var_1 )
{
    if ( isdefined( self._id_2E5C ) )
        [[ self._id_2E5D ]]();
    else if ( isdefined( var_0 ) && isdefined( var_0["script_noteworthy"] ) && isdefined( level._id_2E21[self.team][var_0["script_noteworthy"]] ) )
        thread _id_2E49( var_0["script_noteworthy"], var_0, var_1 );
    else
    {
        if ( isdefined( self._id_4B76 ) )
        {
            _id_2E9E( self._id_4B76, 1 );
            return;
        }

        _id_2E9E( level._id_2E21[self.team]["stand"]["idle"], 1 );
    }
}

_id_2E55( var_0, var_1 )
{
    var_2 = var_1["script_noteworthy"];

    if ( !isdefined( level._id_2E21[self.team][var_2]["arrival"] ) )
        return var_0;

    var_3 = getmovedelta( level._id_2E21[self.team][var_2]["arrival"], 0, 1 );
    var_3 = length( var_3 );
    var_0 -= var_3;
    return var_0;
}

_id_2E49( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "stop_drone_fighting" );
    self._id_0C80 = var_0;
    self._id_A2E1 = undefined;
    var_3 = randomintrange( 1, 4 );

    if ( self.team == "axis" )
    {
        if ( var_3 == 1 )
            self._id_A2E1 = "weap_m9_fire_npc";
        else if ( var_3 == 2 )
            self._id_A2E1 = "weap_usp45sd_fire_npc";

        if ( var_3 == 3 )
            self._id_A2E1 = "weap_pecheneg_fire_npc";
    }
    else
    {
        if ( var_3 == 1 )
            self._id_A2E1 = "weap_m9_fire_npc";
        else if ( var_3 == 2 )
            self._id_A2E1 = "weap_usp45sd_fire_npc";

        if ( var_3 == 3 )
            self._id_A2E1 = "weap_pecheneg_fire_npc";
    }

    self.angles = ( 0, self.angles[1], self.angles[2] );

    if ( var_0 == "coverprone" )
        self moveto( self.origin + ( 0.0, 0.0, 8.0 ), 0.05 );

    self._id_6156 = 1;
    var_4 = level._id_2E21[self.team][var_0];
    self._id_2651 = var_4["death"];

    while ( isdefined( self ) )
    {
        _id_2E9F( var_4["idle"][randomint( var_4["idle"].size )] );

        if ( common_scripts\utility::cointoss() && !isdefined( self._id_01FC ) )
        {
            var_5 = 1;

            if ( isdefined( var_4["pop_up_chance"] ) )
                var_5 = var_4["pop_up_chance"];

            var_5 *= 100;
            var_6 = 1;

            if ( randomfloat( 100 ) > var_5 )
                var_6 = 0;

            if ( var_6 == 1 )
            {
                _id_2E9F( var_4["hide_2_aim"] );
                wait(getanimlength( var_4["hide_2_aim"] ) - 0.5);
            }

            if ( isdefined( var_4["fire"] ) )
            {
                if ( var_0 == "coverprone" && var_6 == 1 )
                    thread _id_2E9E( var_4["fire_exposed"], 1 );
                else
                    thread _id_2E9E( var_4["fire"], 1 );

                _id_2E4E();
            }
            else
            {
                _id_2EB9();
                wait 0.15;
                _id_2EB9();
                wait 0.15;
                _id_2EB9();
                wait 0.15;
                _id_2EB9();
            }

            if ( var_6 == 1 )
                _id_2E9F( var_4["aim_2_hide"] );

            _id_2E9F( var_4["reload"] );
        }
    }
}

_id_2E4E()
{
    self endon( "death" );

    if ( common_scripts\utility::cointoss() )
    {
        _id_2EB9();
        wait 0.1;
        _id_2EB9();
        wait 0.1;
        _id_2EB9();

        if ( common_scripts\utility::cointoss() )
        {
            wait 0.1;
            _id_2EB9();
        }

        if ( common_scripts\utility::cointoss() )
        {
            wait 0.1;
            _id_2EB9();
            wait 0.1;
            _id_2EB9();
            wait 0.1;
        }

        if ( common_scripts\utility::cointoss() )
            wait(randomfloatrange( 1, 2 ));
    }
    else
    {
        _id_2EB9();
        wait(randomfloatrange( 0.25, 0.75 ));
        _id_2EB9();
        wait(randomfloatrange( 0.15, 0.75 ));
        _id_2EB9();
        wait(randomfloatrange( 0.15, 0.75 ));
        _id_2EB9();
        wait(randomfloatrange( 0.15, 0.75 ));
    }
}

_id_2EB9()
{
    self endon( "death" );
    self notify( "firing" );
    self endon( "firing" );
    _id_2EBC();
    var_0 = %exposed_crouch_shoot_auto_v2;
    self _meth_8145( var_0, 1, 0.2, 1.0 );
    common_scripts\utility::delaycall( 0.25, ::_meth_8142, var_0, 0 );
}

_id_2EBC()
{
    var_0 = common_scripts\utility::getfx( "pdrone_flash_wv" );

    if ( self.team == "allies" )
        var_0 = common_scripts\utility::getfx( "pdrone_flash_wv" );

    if ( isdefined( self._id_6020 ) )
        var_0 = common_scripts\utility::getfx( self._id_6020 );

    if ( !isdefined( self._id_613B ) )
        thread _id_2EA0( self._id_A2E1 );

    playfxontag( var_0, self, "tag_flash" );
}

_id_2EA0( var_0 )
{
    self playsound( var_0 );
}

_id_2EEE()
{
    self endon( "death" );
    self waittill( "move" );
    thread _id_2E94();
}

_id_3CC7( var_0 )
{
    var_1 = 170;
    var_2 = 1;
    var_3 = getanimlength( var_0 );
    var_4 = getmovedelta( var_0, 0, 1 );
    var_5 = length( var_4 );

    if ( var_3 > 0 && var_5 > 0 )
    {
        var_1 = var_5 / var_3;
        var_2 = 0;
    }

    if ( isdefined( self._id_2EA9 ) )
        var_1 = self._id_2EA9;

    var_6 = spawnstruct();
    var_6._id_0C04 = var_2;
    var_6._id_76B4 = var_1;
    var_6._id_0C44 = var_3;
    return var_6;
}

_id_2E54()
{
    var_0 = _id_407A( self.target, self.origin );
    var_1 = var_0[var_0.size - 2]["target"];
    var_2 = getnode( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
    {
        var_3 = _func_200( var_0[var_0.size - 1]["origin"], var_0[var_0.size - 1]["origin"] );
        var_2 = var_3[var_3.size - 1];
    }

    return var_2;
}

_id_2E94()
{
    self endon( "death" );
    self endon( "drone_stop" );
    wait 0.05;
    var_0 = _id_407A( self.target, self.origin );
    var_1 = level._id_2E21[self.team]["stand"]["run"];

    if ( isdefined( self._id_76C1 ) )
        var_1 = self._id_76C1;

    var_2 = _id_3CC7( var_1 );
    var_3 = var_2._id_76B4;
    var_4 = var_2._id_0C04;

    if ( isdefined( self._id_2E95 ) )
    {
        var_2 = [[ self._id_2E95 ]]();

        if ( isdefined( var_2 ) )
        {
            var_1 = var_2._id_76C1;
            var_3 = var_2._id_76B4;
            var_4 = var_2._id_0C04;
        }

        var_2 = undefined;
    }

    if ( !var_4 )
        thread _id_2E97( var_3 );

    _id_2E9E( var_1, self._id_5F62 );
    var_5 = 0.5;
    var_6 = 0;
    self._id_8D0A = 1;
    self._id_24BF = var_0[var_6];
    var_7 = 0;
    var_8 = undefined;

    for (;;)
    {
        if ( !isdefined( var_0[var_6] ) )
            break;

        var_9 = var_0[var_6]["vec"];
        var_10 = self.origin - var_0[var_6]["origin"];
        var_11 = vectordot( vectornormalize( var_9 ), var_10 );

        if ( !isdefined( var_0[var_6]["dist"] ) )
            break;

        var_12 = var_11 + level._id_2E89;

        while ( var_12 > var_0[var_6]["dist"] )
        {
            var_12 -= var_0[var_6]["dist"];
            var_6++;
            self._id_24BF = var_0[var_6];

            if ( isdefined( var_8 ) )
            {
                if ( var_6 == 0 )
                {

                }

                if ( !isdefined( self._id_136C ) )
                    self._id_136C = self._id_2EF6;

                var_13 = level._id_2E21[self.team]["stairs"][var_8];
                _id_2E9E( var_13, self._id_5F62 );
                var_7 = 1;
            }

            if ( !isdefined( var_0[var_6]["dist"] ) )
            {
                self _meth_82B5( vectortoangles( var_0[var_0.size - 1]["vec"] ), var_5 );
                var_14 = distance( self.origin, var_0[var_0.size - 1]["origin"] );
                var_15 = var_14 / var_3 * self._id_5F62;
                var_16 = var_0[var_0.size - 1]["origin"] + ( 0.0, 0.0, 100.0 );
                var_17 = var_0[var_0.size - 1]["origin"] - ( 0.0, 0.0, 100.0 );
                var_18 = physicstrace( var_16, var_17 );

                if ( getdvar( "debug_drones" ) == "1" )
                {
                    thread common_scripts\utility::draw_line_for_time( var_16, var_17, 1, 1, 1, var_5 );
                    thread common_scripts\utility::draw_line_for_time( self.origin, var_18, 0, 0, 1, var_5 );
                }

                self moveto( var_18, var_15 );
                wait(var_15);
                self notify( "goal" );
                thread _id_1CB6();
                thread _id_2E5B( var_0[var_0.size - 1], var_18 );
                return;
            }

            if ( !isdefined( var_0[var_6] ) )
            {
                self notify( "goal" );
                thread _id_2E5B();
                return;
            }
        }

        if ( isdefined( self._id_2E95 ) )
        {
            var_2 = [[ self._id_2E95 ]]();

            if ( isdefined( var_2 ) )
            {
                if ( var_2._id_76C1 != var_1 )
                {
                    var_1 = var_2._id_76C1;
                    var_3 = var_2._id_76B4;
                    var_4 = var_2._id_0C04;

                    if ( !var_4 )
                        thread _id_2E97( var_3 );
                    else
                        self notify( "drone_move_z" );

                    _id_2E9E( var_1, self._id_5F62 );
                }
            }
        }

        self._id_24BF = var_0[var_6];
        var_19 = var_0[var_6]["vec"] * var_12;
        var_19 += var_0[var_6]["origin"];
        var_20 = var_19;
        var_16 = var_20 + ( 0.0, 0.0, 100.0 );
        var_17 = var_20 - ( 0.0, 0.0, 100.0 );
        var_20 = physicstrace( var_16, var_17 );

        if ( !var_4 )
            self._id_2E87 = var_20;

        if ( getdvar( "debug_drones" ) == "1" )
        {
            thread common_scripts\utility::draw_line_for_time( var_16, var_17, 1, 1, 1, var_5 );
            thread _id_2DC0( var_20, 1, 0, 0, 16, var_5 );
        }

        var_21 = vectortoangles( var_20 - self.origin );
        self _meth_82B5( ( 0, var_21[1], 0 ), var_5 );
        var_22 = var_3 * var_5 * self._id_5F62;
        var_23 = vectornormalize( var_20 - self.origin );
        var_19 = var_23 * var_22;
        var_19 += self.origin;

        if ( getdvar( "debug_drones" ) == "1" )
            thread common_scripts\utility::draw_line_for_time( self.origin, var_19, 0, 0, 1, var_5 );

        self moveto( var_19, var_5 );
        wait(var_5);

        if ( isdefined( self._id_24BF["script_noteworthy"] ) && ( self._id_24BF["script_noteworthy"] == "stairs_start_up" || self._id_24BF["script_noteworthy"] == "stairs_start_down" ) )
        {
            var_24 = strtok( self._id_24BF["script_noteworthy"], "_" );
            var_8 = var_24[2];
            continue;
        }

        if ( var_7 == 1 )
        {
            if ( isdefined( self._id_24BF["script_noteworthy"] ) && self._id_24BF["script_noteworthy"] == "stairs_end" )
            {
                var_25 = self._id_136C;
                _id_2E9E( var_25, self._id_5F62 );
                var_7 = 0;
                var_8 = undefined;
            }
        }
    }

    thread _id_2E5B();
}

_id_2E97( var_0 )
{
    self endon( "death" );
    self endon( "drone_stop" );
    self notify( "drone_move_z" );
    self endon( "drone_move_z" );
    var_1 = 0.05;

    for (;;)
    {
        if ( isdefined( self._id_2E87 ) && var_0 > 0 )
        {
            var_2 = self._id_2E87[2] - self.origin[2];
            var_3 = distance2d( self._id_2E87, self.origin );
            var_4 = var_3 / var_0;

            if ( var_4 > 0 && var_2 != 0 )
            {
                var_5 = abs( var_2 ) / var_4;
                var_6 = var_5 * var_1;

                if ( var_2 >= var_5 )
                    self.origin = ( self.origin[0], self.origin[1], self.origin[2] + var_6 );
                else if ( var_2 <= var_5 * -1 )
                    self.origin = ( self.origin[0], self.origin[1], self.origin[2] - var_6 );
            }
        }

        wait(var_1);
    }
}

_id_407A( var_0, var_1 )
{
    var_2 = 1;
    var_3 = [];
    var_3[0]["origin"] = var_1;
    var_3[0]["dist"] = 0;
    var_4 = undefined;
    var_4 = var_0;
    var_5["entity"] = _id_A577::_id_3E88;
    var_5["node"] = _id_A577::_id_3E8A;
    var_5["struct"] = _id_A577::_id_3E8C;
    var_6 = undefined;
    var_7 = [[ var_5["entity"] ]]( var_4 );
    var_8 = [[ var_5["node"] ]]( var_4 );
    var_9 = [[ var_5["struct"] ]]( var_4 );

    if ( var_7.size )
        var_6 = "entity";
    else if ( var_8.size )
        var_6 = "node";
    else if ( var_9.size )
        var_6 = "struct";

    var_10 = var_3.size;

    for (;;)
    {
        var_11 = [[ var_5[var_6] ]]( var_4 );
        var_12 = common_scripts\utility::random( var_11 );

        if ( !isdefined( var_12 ) )
            break;

        var_10 = var_3.size;
        var_13 = var_12.origin;

        if ( isdefined( var_12.radius ) )
        {
            if ( !isdefined( self._id_2F18 ) )
                self._id_2F18 = -1 + randomfloat( 2 );

            if ( !isdefined( var_12.angles ) )
                var_12.angles = ( 0.0, 0.0, 0.0 );

            var_14 = anglestoforward( var_12.angles );
            var_15 = anglestoright( var_12.angles );
            var_16 = anglestoup( var_12.angles );
            var_17 = ( 0, self._id_2F18 * var_12.radius, 0 );
            var_13 += var_14 * var_17[0];
            var_13 += var_15 * var_17[1];
            var_13 += var_16 * var_17[2];
        }

        var_3[var_10]["origin"] = var_13;
        var_3[var_10]["target"] = var_12.target;

        if ( isdefined( self.script_parameters ) && self.script_parameters == "use_last_node_angles" && isdefined( var_12.angles ) )
            var_3[var_10]["angles"] = var_12.angles;

        if ( isdefined( var_12.script_noteworthy ) )
            var_3[var_10]["script_noteworthy"] = var_12.script_noteworthy;

        if ( isdefined( var_12.script_linkname ) )
            var_3[var_10]["script_linkname"] = var_12.script_linkname;

        var_3[var_10 - 1]["dist"] = distance( var_3[var_10]["origin"], var_3[var_10 - 1]["origin"] );
        var_3[var_10 - 1]["vec"] = vectornormalize( var_3[var_10]["origin"] - var_3[var_10 - 1]["origin"] );

        if ( !isdefined( var_3[var_10 - 1]["target"] ) )
            var_3[var_10 - 1]["target"] = var_12.targetname;

        if ( !isdefined( var_3[var_10 - 1]["script_noteworthy"] ) && isdefined( var_12.script_noteworthy ) )
            var_3[var_10 - 1]["script_noteworthy"] = var_12.script_noteworthy;

        if ( !isdefined( var_3[var_10 - 1]["script_linkname"] ) && isdefined( var_12.script_linkname ) )
            var_3[var_10 - 1]["script_linkname"] = var_12.script_linkname;

        if ( !isdefined( var_12.target ) )
            break;

        var_4 = var_12.target;
    }

    if ( isdefined( self.script_parameters ) && self.script_parameters == "use_last_node_angles" && isdefined( var_3[var_10]["angles"] ) )
        var_3[var_10]["vec"] = anglestoforward( var_3[var_10]["angles"] );
    else
        var_3[var_10]["vec"] = var_3[var_10 - 1]["vec"];

    var_12 = undefined;
    return var_3;
}

_id_2DC0( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_0 + ( var_4, 0, 0 );
    var_7 = var_0 - ( var_4, 0, 0 );
    thread common_scripts\utility::draw_line_for_time( var_6, var_7, var_1, var_2, var_3, var_5 );
    var_6 = var_0 + ( 0, var_4, 0 );
    var_7 = var_0 - ( 0, var_4, 0 );
    thread common_scripts\utility::draw_line_for_time( var_6, var_7, var_1, var_2, var_3, var_5 );
    var_6 = var_0 + ( 0, 0, var_4 );
    var_7 = var_0 - ( 0, 0, var_4 );
    thread common_scripts\utility::draw_line_for_time( var_6, var_7, var_1, var_2, var_3, var_5 );
}

_id_1CB6()
{
    if ( !isdefined( self ) )
        return;

    if ( !isdefined( self.script_noteworthy ) )
        return;

    switch ( self.script_noteworthy )
    {
        case "delete_on_goal":
            if ( isdefined( self._id_58D4 ) )
                _id_A59A::_id_8E9E();

            self delete();
            break;
        case "die_on_goal":
            self _meth_8052();
            break;
    }
}
