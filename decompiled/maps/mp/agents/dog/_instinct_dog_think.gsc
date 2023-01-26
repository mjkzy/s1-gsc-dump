// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_830A();
    thread _id_9305();
    thread _id_A23A();
    thread _id_A23B();
    thread _id_A23D();
    thread _id_A008();
    thread _id_A01E();
}

_id_830A()
{
    self._id_14B3 = 0;
    self._id_6634 = 65536;
    self._id_5B8B = 16384;
    self._id_0E47 = 25 + self.radius;
    self._id_0E49 = 9437184;
    self._id_A1AB = 302500;
    self._id_A1AC = 96.0;
    self._id_0E4E = 54;
    self._id_0E4F = -64;
    self._id_6630 = 2250000;
    self._id_2CC3 = 2250000;
    self._id_52DF = 9000000;
    self._id_6EF1 = 256;
    self._id_5C7F = 50;
    self._id_39AA = 0;
    self._id_01FD = 1;
    self._id_02A6 = "run";
    self._id_310E = 1;
    self._id_0E4A = "idle";
    self._id_5F7B = "idle";
    self._id_1432 = 0;
    self._id_9361 = 0;
    self._id_0030 = 1;
    self _meth_8394( 24 );
}

init()
{
    self._id_0C69 = spawnstruct();
    self._id_0C69._id_648C = [];
    self._id_0C69._id_648C["idle"] = maps\mp\agents\dog\_dog_idle::main;
    self._id_0C69._id_648C["move"] = maps\mp\agents\dog\_dog_move::main;
    self._id_0C69._id_648C["traverse"] = maps\mp\agents\dog\_dog_traverse::main;
    self._id_0C69._id_648C["melee"] = maps\mp\agents\dog\_dog_melee::main;
    self._id_0C69._id_64A2 = [];
    self._id_0C69._id_64A2["idle"] = maps\mp\agents\dog\_dog_idle::_id_0140;
    self._id_0C69._id_64A2["move"] = maps\mp\agents\dog\_dog_move::_id_0140;
    self._id_0C69._id_64A2["melee"] = maps\mp\agents\dog\_dog_melee::_id_0140;
    self._id_0C69._id_64A2["traverse"] = maps\mp\agents\dog\_dog_traverse::_id_0140;
    self._id_A1F7 = ::_id_A1F6;
    self._id_09A3 = "idle";
    self._id_02A6 = "fastwalk";
    self.radius = 15;
    self.height = 40;
}

_id_648D( var_0, var_1 )
{
    self notify( "killanimscript" );

    if ( !isdefined( self._id_0C69._id_648C[var_1] ) )
        return;

    if ( var_0 == var_1 && var_1 != "traverse" )
        return;

    if ( isdefined( self._id_0C69._id_64A2[var_0] ) )
        self [[ self._id_0C69._id_64A2[var_0] ]]();

    _id_343E( self._id_09A3 );
    self._id_09A3 = var_1;
    _id_3304( var_1 );
    self [[ self._id_0C69._id_648C[var_1] ]]();
}

_id_9305()
{
    self endon( "timeoutRetreat" );
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self.owner ) )
    {
        self endon( "owner_disconnect" );
        thread _id_28EF( self.owner );
    }

    self thread [[ self._id_A1F7 ]]();
    thread monitorflash();

    for (;;)
    {
        if ( self._id_09A3 != "melee" && !self._id_03FC && _id_71E3() && !_id_2A49() )
            self _meth_839C( self._id_24C6 );

        switch ( self._id_09A3 )
        {
            case "idle":
                _id_9B22();
                break;
            case "move":
                _id_9B32();
                break;
            case "melee":
                _id_9B2D();
                break;
        }

        wait 0.05;
    }
}

_id_2A4A( var_0 )
{
    if ( isdefined( self._id_24C6 ) && var_0 != self._id_24C6 )
        return 0;

    if ( !isdefined( self._id_55CC ) || !isdefined( self._id_55CB ) )
        return 0;

    if ( _func_220( var_0.origin, self._id_55CC ) > 4 )
        return 0;

    if ( self._id_1494 )
        return 1;

    if ( distancesquared( self.origin, self._id_55CB ) > 4096 && gettime() - self._id_55CD > 2000 )
        return 0;

    return 1;
}

_id_2A49()
{
    if ( isdefined( self._id_55BB ) && isdefined( self._id_55BA ) && _func_220( self._id_24C6.origin, self._id_55BB ) < 4 && distancesquared( self.origin, self._id_55BA ) < 2500 )
        return 1;

    if ( _id_A14D( 0 ) )
        return 1;

    return 0;
}

_id_3304( var_0 )
{
    _id_343E( self._id_09A3 );
    self._id_09A3 = var_0;

    switch ( var_0 )
    {
        case "idle":
            self._id_5F7B = "idle";
            self._id_1432 = 0;
            break;
        case "move":
            self._id_5F7B = "follow";
            break;
        case "melee":
            break;
        default:
            break;
    }
}

_id_343E( var_0 )
{
    switch ( var_0 )
    {
        case "move":
            self._id_6633 = undefined;
            break;
        default:
            break;
    }
}

_id_9B22()
{
    _id_9B36();
}

_id_9B32()
{
    _id_9B36();
}

_id_9B2D()
{
    self endon( "timeoutRetreat" );
    self _meth_8390( self.origin );
}

_id_9B36()
{
    self endon( "timeoutRetreat" );

    if ( self._id_14B3 )
        return;

    self._id_6F6D = self._id_5F7B;
    var_0 = undefined;
    var_1 = 0;
    var_2 = 0;
    var_3 = 500;

    if ( self._id_1432 && gettime() - self._id_5579 < var_3 )
    {
        self._id_5F7B = "follow";
        var_1 = 1;
    }
    else
        self._id_5F7B = _id_402D();

    if ( self._id_5F7B == "pursuit" )
    {
        var_0 = _id_3F0A( self._id_0143 );
        var_4 = 0;

        if ( isdefined( self._id_5579 ) && gettime() - self._id_5579 < 3000 )
        {
            if ( _func_220( var_0, self._id_5577 ) < 16 )
                var_4 = 1;
            else if ( isdefined( self._id_5578 ) && self._id_5578 == "pursuit" && _func_220( self._id_557A, self._id_0143.origin ) < 16 )
                var_4 = 1;
        }

        if ( var_4 )
        {
            self._id_5F7B = "follow";
            var_2 = 1;
        }
        else if ( _id_A14D( 1 ) )
        {
            self._id_5F7B = "follow";
            var_2 = 1;
        }
        else if ( _id_2A4A( self._id_0143 ) )
        {
            self._id_5F7B = "follow";
            var_2 = 1;
        }
    }

    _id_7FD7( var_2 );

    if ( self._id_5F7B == "follow" )
    {
        self._id_24C6 = undefined;
        self._id_02A6 = _id_3F9D( self._id_02A6 );
        self._id_12EE = 1;
        var_5 = self _meth_83E1();

        if ( !isdefined( var_5 ) )
            var_5 = self.origin;

        if ( isdefined( self.owner ) && self.owner.sessionstate == "spectator" )
            return;

        if ( gettime() - self._id_9361 < 5000 )
            var_1 = 1;

        var_6 = self.owner getstance();

        if ( !isdefined( self.owner._id_6F74 ) && isdefined( self.owner ) )
            self.owner._id_6F74 = var_6;

        var_7 = !isdefined( self._id_6633 ) || _func_220( self._id_6633, self.owner.origin ) > 100;

        if ( var_7 )
            self._id_6633 = self.owner.origin;

        var_8 = _func_220( var_5, self.owner.origin );

        if ( var_1 || var_8 > self._id_6634 && var_7 || self.owner._id_6F74 != var_6 || self._id_6F6D != "idle" && self._id_6F6D != self._id_5F7B )
        {
            var_9 = 1;
            var_10 = _id_3783();
            var_11 = spawn( "trigger_radius", self.owner.origin, 0, 256, 256 );
            var_12 = _func_1FE( var_11 );
            var_12 = sortbydistance( var_12, self.owner.origin );

            while ( var_9 == 1 )
            {
                var_9 = 0;

                foreach ( var_14 in level._id_4E8D )
                {
                    if ( var_9 == 0 )
                    {
                        var_15 = var_14 _meth_8391();
                        var_16 = distance( var_10, var_15 );

                        if ( var_16 < 60 )
                            var_9 = 1;
                    }
                }

                if ( var_9 == 1 )
                {
                    if ( var_12.size > 0 )
                    {
                        for ( var_18 = 0; var_18 < var_12.size; var_18++ )
                        {
                            var_19 = 1;

                            foreach ( var_14 in level._id_4E8D )
                            {
                                if ( var_19 == 1 )
                                {
                                    var_15 = var_14 _meth_8391();
                                    var_16 = distance( var_12[var_18].origin, var_15 );
                                    var_21 = distance( var_12[var_18].origin, self.owner.origin );

                                    if ( var_16 < 60 || var_21 < 128 )
                                        var_19 = 0;
                                }
                            }

                            if ( var_19 == 1 )
                            {
                                self _meth_8390( var_12[var_18].origin );
                                var_9 = 0;
                                break;
                            }
                        }
                    }
                    else
                    {
                        var_23 = istestclient( self.owner.origin, self.owner.angles );
                        self _meth_8390( var_23.origin );
                        var_9 = 0;
                    }
                }
                else
                    self _meth_8390( var_10 );

                waitframe();
            }

            self.owner._id_6F74 = var_6;
            var_11 delete();
            return;
        }
    }
    else if ( self._id_5F7B == "pursuit" )
    {
        self._id_24C6 = self._id_0143;
        self._id_02A6 = "sprint";
        self._id_12EE = 0;
        self _meth_8390( var_0 );
    }
}

_id_402D( var_0 )
{
    if ( isdefined( self._id_0143 ) )
    {
        if ( isdefined( self._id_017C ) && self._id_0143 == self._id_017C )
            return "pursuit";

        if ( abs( self.origin[2] - self._id_0143.origin[2] ) < self._id_A1AC && _func_220( self._id_0143.origin, self.origin ) < self._id_0E49 )
            return "pursuit";

        if ( isdefined( self._id_24C6 ) && self._id_24C6 == self._id_0143 )
        {
            if ( _func_220( self._id_24C6.origin, self.origin ) < self._id_52DF )
                return "pursuit";
        }
    }

    return "follow";
}

_id_7FD7( var_0 )
{
    if ( var_0 )
    {
        if ( !isdefined( self._id_55CC ) )
        {
            self._id_55CC = self._id_0143.origin;
            self._id_55CB = self.origin;
            var_1 = maps\mp\agents\_scriptedagents::_id_2F8E( self._id_0143.origin );
            self._id_1494 = !isdefined( var_1 );
            self._id_55CD = gettime();
        }
    }
    else
    {
        self._id_55CC = undefined;
        self._id_55CB = undefined;
        self._id_1494 = undefined;
        self._id_55CD = undefined;
    }
}

_id_A008()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "bad_path", var_0 );
        self._id_1432 = 1;
        self._id_5579 = gettime();
        self._id_5577 = var_0;
        self._id_5578 = self._id_5F7B;

        if ( self._id_5F7B == "follow" && isdefined( self.owner ) )
        {
            self._id_557A = self.owner.origin;
            continue;
        }

        if ( self._id_5F7B == "pursuit" && isdefined( self._id_0143 ) )
            self._id_557A = self._id_0143.origin;
    }
}

_id_A01E()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "path_set" );
        self._id_1432 = 0;
    }
}

_id_3F9D( var_0 )
{
    var_1 = 40000;
    var_2 = 65536;
    var_3 = self _meth_83E1();

    if ( isdefined( var_3 ) )
    {
        var_4 = distancesquared( var_3, self.origin );

        if ( var_0 == "run" || var_0 == "sprint" )
        {
            if ( var_4 < var_1 )
                return "fastwalk";
            else if ( var_0 == "sprint" )
                return "run";
        }
        else if ( var_0 == "fastwalk" )
        {
            if ( var_4 > var_2 )
                return "run";
        }
    }

    return var_0;
}

_id_5208( var_0 )
{
    var_1 = var_0[2] - self.origin[2];
    return var_1 <= self._id_0E4E && var_1 >= self._id_0E4F;
}

_id_A14D( var_0 )
{
    if ( !isdefined( self._id_24C6 ) )
        return 0;

    return !_id_5208( self._id_24C6.origin ) && _func_220( self.origin, self._id_24C6.origin ) < self._id_5B8B * 0.75 * 0.75 && ( !var_0 || self _meth_838E( self._id_24C6 ) );
}

_id_71E3()
{
    if ( !isdefined( self._id_24C6 ) )
        return 0;

    if ( !maps\mp\_utility::isreallyalive( self._id_24C6 ) )
        return 0;

    if ( self._id_09A3 == "traverse" )
        return 0;

    if ( _func_220( self.origin, self._id_24C6.origin ) > self._id_5B8B )
        return 0;

    if ( !_id_5208( self._id_24C6.origin ) )
        return 0;

    return 1;
}

_id_A14C()
{
    if ( !isdefined( self._id_0143 ) )
        return 0;

    if ( abs( self.origin[2] - self._id_0143.origin[2] ) <= self._id_A1AC || self _meth_838E( self._id_0143 ) )
    {
        var_0 = _func_220( self.origin, self._id_0143.origin );

        if ( var_0 < self._id_A1AB )
            return 1;
    }

    return 0;
}

_id_3F0A( var_0 )
{
    var_1 = var_0.origin - self.origin;
    var_1 = vectornormalize( var_1 );
    var_2 = self _meth_83E1();
    var_3 = self._id_0E47 + 4;

    if ( isdefined( var_2 ) && _func_220( var_2, var_0.origin ) < var_3 * var_3 && maps\mp\agents\_scriptedagents::_id_1AD2( var_0.origin, var_2 ) )
        return var_2;

    var_4 = var_0.origin - var_1 * self._id_0E47;
    var_4 = maps\mp\agents\_scriptedagents::_id_2F8E( var_4 );

    if ( !isdefined( var_4 ) )
        return var_0.origin;

    if ( !maps\mp\agents\_scriptedagents::_id_1AD2( var_0.origin, var_4 ) )
    {
        var_5 = anglestoforward( var_0.angles );
        var_4 = var_0.origin + var_5 * self._id_0E47;

        if ( !maps\mp\agents\_scriptedagents::_id_1AD2( var_0.origin, var_4 ) )
            return var_0.origin;
    }

    return var_4;
}

_id_2478( var_0, var_1 )
{
    return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

_id_3783()
{
    var_0 = vectornormalize( self.origin - self.owner.origin );
    var_1 = anglestoforward( self.owner.angles );
    var_1 = ( var_1[0], var_1[1], 0 );
    var_1 = vectornormalize( var_1 );
    var_2 = _id_2478( var_0, var_1 );
    var_3 = getclosestnodeinsight( self.owner.origin );

    if ( !isdefined( var_3 ) )
        return self.origin;

    var_4 = getlinkednodes( var_3 );
    var_5 = 5;
    var_6 = 10;
    var_7 = 15;
    var_8 = -15;
    var_9 = gettime() - self._id_9361 < 5000;
    var_10 = 0;
    var_11 = 0;
    var_4[var_4.size] = var_3;

    foreach ( var_13 in var_4 )
    {
        var_14 = 0;
        var_15 = var_13.origin - self.owner.origin;
        var_16 = length( var_15 );

        if ( var_16 >= self._id_6EF1 )
            var_14 += var_5;
        else if ( var_16 < self._id_5C7F )
        {
            var_17 = 1 - ( self._id_5C7F - var_16 ) / self._id_5C7F;
            var_14 += var_5 * var_17 * var_17;
        }
        else
            var_14 += var_5 * var_16 / self._id_6EF1;

        if ( var_16 == 0 )
            var_16 = 1;

        var_15 /= var_16;
        var_18 = vectordot( var_1, var_15 );
        var_19 = self.owner getstance();

        switch ( var_19 )
        {
            case "stand":
                if ( var_18 < cos( 35 ) && var_18 > cos( 45 ) )
                    var_14 += var_6;

                break;
            case "crouch":
                if ( var_18 < cos( 75 ) && var_18 > cos( 90 ) )
                    var_14 += var_6;

                break;
            case "prone":
                if ( var_18 < cos( 125 ) && var_18 > cos( 135 ) )
                    var_14 += var_6;

                break;
        }

        var_20 = _id_2478( var_15, var_1 );

        if ( var_20 * var_2 > 0 )
            var_14 += var_7;

        if ( var_9 )
        {
            var_21 = vectordot( self._id_2598, var_15 );
            var_14 += var_21 * var_8;
        }

        if ( var_14 > var_10 )
        {
            var_10 = var_14;
            var_11 = var_13;
        }
    }

    if ( !isdefined( var_11 ) )
        return self.origin;

    var_23 = var_11.origin - self.owner.origin;
    var_24 = length( var_23 );

    if ( var_24 > self._id_6EF1 )
    {
        var_25 = var_3.origin - self.owner.origin;

        if ( vectordot( var_25, var_23 / var_24 ) < 0 )
            var_26 = var_11.origin;
        else
        {
            var_27 = vectornormalize( var_11.origin - var_3.origin );
            var_26 = var_3.origin + var_27 * self._id_6EF1;
        }
    }
    else
        var_26 = var_11.origin;

    var_26 = maps\mp\agents\_scriptedagents::_id_2F8E( var_26 );

    if ( !isdefined( var_26 ) )
        return self.origin;

    if ( self._id_1432 && _func_220( var_26, self._id_5577 ) < 4 )
        return self.origin;

    return var_26;
}

_id_28EF( var_0 )
{
    self endon( "death" );
    var_0 common_scripts\utility::waittill_any( "disconnect", "joined_team" );
    self notify( "owner_disconnect" );

    if ( maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() )
        wait 0.05;

    self notify( "killanimscript" );

    if ( isdefined( self._id_0C69._id_64A2[self._id_09A3] ) )
        self [[ self._id_0C69._id_64A2[self._id_09A3] ]]();

    self suicide();
}

_id_A1F6()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( self._id_09A3 == "melee" )
        {
            if ( self._id_0E4A != "melee" )
            {
                self._id_0E4A = "melee";
                _id_800E( undefined );
            }
        }
        else if ( self._id_5F7B == "pursuit" )
        {
            if ( self._id_0E4A != "attacking" )
            {
                self._id_0E4A = "attacking";
                _id_800E( "bark", "attacking" );
            }
        }
        else if ( self._id_0E4A != "warning" )
        {
            if ( _id_A14C() )
            {
                self._id_0E4A = "warning";
                _id_800E( "growl", "warning" );
            }
            else
            {
                self._id_0E4A = self._id_09A3;
                _id_800E( "pant" );
            }
        }
        else if ( !_id_A14C() )
        {
            self._id_0E4A = self._id_09A3;
            _id_800E( "pant" );
        }

        wait 0.05;
    }
}

_id_800E( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        self notify( "end_dog_sound" );
        self._id_88A9 = undefined;
        return;
    }

    if ( !isdefined( self._id_88A9 ) || self._id_88A9 != var_0 )
    {
        self notify( "end_dog_sound" );
        self._id_88A9 = var_0;

        if ( var_0 == "bark" )
            thread _id_6A2A( var_1 );
        else if ( var_0 == "growl" )
            thread _id_6DA5( var_1 );
        else if ( var_0 == "pant" )
            thread _id_6DCC();
        else
        {

        }
    }
}

_id_6A2A( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );

    if ( !isdefined( self._id_12E0 ) )
    {
        self._id_12E0 = 1;
        thread _id_A1F9();
    }
}

_id_A1F9()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );
    wait(randomintrange( 5, 10 ));
    self._id_12E0 = undefined;
}

_id_6DA5( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );

    if ( isdefined( self._id_55A5 ) && gettime() - self._id_55A5 < 3000 )
        wait 3;

    for (;;)
    {
        self._id_55A5 = gettime();
        wait(randomintrange( 3, 6 ));
    }
}

_id_6DCC( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "end_dog_sound" );

    if ( isdefined( self._id_55C5 ) && gettime() - self._id_55C5 < 3000 )
        wait 3;

    self._id_55C5 = gettime();

    for (;;)
    {
        if ( self._id_09A3 == "idle" )
        {
            wait 3;
            continue;
        }

        self._id_55C5 = gettime();
        wait(randomintrange( 6, 8 ));
    }
}

_id_A23A()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self.owner ) )
            return;

        self.owner waittill( "damage", var_0, var_1 );

        if ( isplayer( var_1 ) && var_1 != self.owner )
        {
            if ( self._id_0E4A == "attacking" )
                continue;

            if ( distancesquared( self.owner.origin, self.origin ) > self._id_6630 )
                continue;

            if ( distancesquared( self.owner.origin, var_1.origin ) > self._id_6630 )
                continue;

            self._id_017C = var_1;
            self._id_39AA = 1;
            thread _id_A214();
        }
    }
}

_id_A23B()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self.owner ) )
            return;

        self.owner waittill( "death" );

        switch ( level.gametype )
        {
            case "sd":
                maps\mp\agents\_agent_utility::_id_5357();
                continue;
            case "sr":
                var_0 = level common_scripts\utility::waittill_any_return( "sr_player_eliminated", "sr_player_respawned" );

                if ( isdefined( var_0 ) && var_0 == "sr_player_eliminated" )
                    maps\mp\agents\_agent_utility::_id_5357();

                continue;
        }
    }
}

_id_A23D()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( self.owner ) )
            return;

        var_0 = self.owner common_scripts\utility::waittill_any_return_no_endon_death( "joined_team", "joined_spectators" );

        if ( isdefined( var_0 ) && ( var_0 == "joined_team" || var_0 == "joined_spectators" ) )
            maps\mp\agents\_agent_utility::_id_5357();
    }
}

_id_A214()
{
    self notify( "watchFavoriteEnemyDeath" );
    self endon( "watchFavoriteEnemyDeath" );
    self endon( "death" );
    self._id_017C common_scripts\utility::waittill_any_timeout( 5.0, "death", "disconnect" );
    self._id_017C = undefined;
    self._id_39AA = 0;
}

_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self._id_9361 = gettime();

    if ( isdefined( self.owner ) )
        self._id_2598 = vectornormalize( self.origin - self.owner.origin );

    if ( _id_849C( var_2, var_5, var_4 ) )
    {
        switch ( self._id_09A3 )
        {
            case "idle":
                thread maps\mp\agents\dog\_dog_idle::_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
                break;
            case "move":
                thread maps\mp\agents\dog\_dog_move::_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
                break;
        }
    }
}

_id_849C( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) && weaponclass( var_1 ) == "sniper" )
        return 1;

    if ( isdefined( var_2 ) && isexplosivedamagemod( var_2 ) && var_0 >= 10 )
        return 1;

    if ( isdefined( var_2 ) && var_2 == "MOD_MELEE" )
        return 1;

    if ( isdefined( var_1 ) && var_1 == "concussion_grenade_mp" )
        return 1;

    return 0;
}

monitorflash()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "flashbang", var_0, var_1, var_2, var_3, var_4, var_5 );

        if ( isdefined( var_3 ) && var_3 == self.owner )
            continue;

        switch ( self._id_09A3 )
        {
            case "idle":
                maps\mp\agents\dog\_dog_idle::_id_64AA();
                continue;
            case "move":
                maps\mp\agents\dog\_dog_move::_id_64AA();
                continue;
        }
    }
}
