// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

setuphumanoidstate()
{
    self._id_0E47 = 26 + self.radius;
    self.meleesectortype = "normal";
    self.meleesectorupdatetime = 50;
    self._id_0E4E = 54;
    self._id_0E4F = -64;
    self.damagedradiussq = 2250000;
    self._id_01FD = 1;
    self.moveratescale = 1.0;
    self.nonmoveratescale = 1.0;
    self.traverseratescale = 1.0;
    self.generalspeedratescale = 1.0;
    self._id_1432 = 0;
    self._id_1434 = 1;
    self._id_9361 = 0;
    self._id_0030 = 1;
    self.meleecheckheight = 40;
    self.meleeradiusbase = 60;
    self.meleeradiusbasesq = squared( self.meleeradiusbase );
    maps\mp\zombies\_util::setmeleeradius( self.meleeradiusbase );
    self.defaultgoalradius = self.radius + 1;
    self _meth_8394( self.defaultgoalradius );
    self.meleedot = 0.5;
}

init()
{
    self._id_0C69 = spawnstruct();
    self._id_0C69._id_648C = [];
    self._id_0C69._id_648C["idle"] = maps\mp\agents\humanoid\_humanoid_idle::main;
    self._id_0C69._id_648C["move"] = maps\mp\agents\humanoid\_humanoid_move::main;
    self._id_0C69._id_648C["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::main;
    self._id_0C69._id_648C["melee"] = maps\mp\agents\humanoid\_humanoid_melee::main;
    self._id_0C69._id_648C["scripted"] = ::onscriptedbegin;
    self._id_0C69._id_64A2 = [];
    self._id_0C69._id_64A2["idle"] = maps\mp\agents\humanoid\_humanoid_idle::_id_0140;
    self._id_0C69._id_64A2["move"] = maps\mp\agents\humanoid\_humanoid_move::_id_0140;
    self._id_0C69._id_64A2["melee"] = maps\mp\agents\humanoid\_humanoid_melee::_id_0140;
    self._id_0C69._id_64A2["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::_id_0140;
    self._id_0C69._id_64A2["scripted"] = ::onscriptedend;
    self._id_0C69._id_6461 = [];
    self._id_0C69._id_6461["move"] = maps\mp\agents\humanoid\_humanoid_move::_id_6461;
    self._id_09A3 = "idle";
    self._id_02A6 = "walk";
    self._id_03C0 = 100;
    self.radius = 15;
    self.height = 40;
}

onscriptedbegin()
{
    self.isscripted = 1;
}

onscriptedend()
{
    self.isscripted = undefined;
}

spawn_humanoid( var_0, var_1, var_2, var_3 )
{
    self setmodel( "tag_origin" );
    self._id_8A3A = "humanoid";
    self._id_648D = maps\mp\agents\_scripted_agent_anim_util::_id_648D;

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        var_4 = var_1;
        var_5 = var_2;
    }
    else
    {
        var_6 = self [[ level.getspawnpoint ]]();
        var_4 = var_6.origin;
        var_5 = var_6.angles;
    }

    maps\mp\agents\_agent_utility::_id_070B();
    self.spawntime = gettime();
    self.lastspawntime = gettime();
    init();
    var_7 = 15;
    var_8 = 60;

    if ( isdefined( level.getradiusandheight ) && isdefined( level.getradiusandheight[self.agent_type] ) )
        [ var_7, var_8 ] = [[ level.getradiusandheight[self.agent_type] ]]();

    self _meth_838A( var_4, var_5, var_0, var_7, var_8, var_3 );
    level notify( "spawned_agent", self );
    maps\mp\agents\_agent_common::set_agent_health( 100 );

    if ( isdefined( var_3 ) )
        maps\mp\agents\_agent_utility::_id_7DAB( var_3.team, var_3 );

    self takeallweapons();
    self _meth_853C( "human" );
    self _meth_853E( 1 );
    self _meth_8541( 0 );
    self _meth_8543( 0 );
    self _meth_8544( 0 );
    self _meth_8545( 1 );
    self _meth_8542( 1 );
    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();
}

_id_2A49()
{
    if ( isdefined( self._id_55BB ) && isdefined( self._id_55BA ) && _func_220( self._id_24C6.origin, self._id_55BB ) < 4 && distancesquared( self.origin, self._id_55BA ) < 2500 )
        return 1;

    return 0;
}

didpastlungemeleefail()
{
    if ( isdefined( self.lastlungemeleefailedpos ) && isdefined( self.lastlungemeleefailedmypos ) && _func_220( self._id_24C6.origin, self.lastlungemeleefailedpos ) < 4 && distancesquared( self.origin, self.lastlungemeleefailedmypos ) < 2500 )
        return 1;

    return 0;
}

_id_5208( var_0 )
{
    var_1 = 0;
    var_2 = var_0[2] - self.origin[2];
    var_1 = var_2 <= self._id_0E4E && var_2 >= self._id_0E4F;

    if ( !var_1 && isplayer( self._id_24C6 ) && maps\mp\zombies\_util::_id_508F( self._id_24C6.isinexploitspot ) )
    {
        if ( length( self getvelocity() ) < 5 )
            var_1 = var_2 <= self._id_0E4E * 2 && var_2 >= self._id_0E4F;
    }

    return var_1;
}

_id_A14D()
{
    if ( maps\mp\agents\humanoid\_humanoid_util::isentstandingonme( self._id_24C6 ) )
        return 0;

    return !_id_5208( self._id_24C6.origin ) && _func_220( self.origin, self._id_24C6.origin ) < maps\mp\agents\humanoid\_humanoid_util::getmeleeradiussq() * 0.75 * 0.75;
}

_id_71E3( var_0 )
{
    if ( !isdefined( self._id_24C6 ) )
        return 0;

    if ( !maps\mp\_utility::isreallyalive( self._id_24C6 ) )
        return 0;

    if ( self._id_09A3 == "traverse" )
        return 0;

    if ( !maps\mp\agents\humanoid\_humanoid_util::isentstandingonme( self._id_24C6 ) )
    {
        if ( !_id_5208( self._id_24C6.origin ) )
            return 0;

        if ( var_0 == "normal" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradius() )
            return 0;
        else if ( var_0 == "base" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase() )
            return 0;
    }

    if ( maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked() )
        return 0;

    return 1;
}

getmeleeattackpoint( var_0 )
{
    if ( !isdefined( self.meleeattackpoint ) )
        self.meleeattackpoint = spawnstruct();

    if ( maps\mp\agents\humanoid\_humanoid_util::isentunreachabledrone( var_0 ) && !maps\mp\agents\humanoid\_humanoid_util::hascalculatednearestnodetounreachabledrone() )
        maps\mp\agents\humanoid\_humanoid_util::calculatenearestnodetounreachabledrone();

    var_1 = maps\mp\agents\humanoid\_humanoid_util::getoriginformeleesectors( var_0 );
    self.meleeattackpoint.enemysectororigin = var_1;
    var_2 = maps\mp\agents\humanoid\_humanoid_util::getmeleetargetpoint( var_0, var_1 );

    if ( isdefined( var_2 ) )
    {
        self.meleeattackpoint._id_9C3B = 1;
        self.meleeattackpoint.origin = var_2;
    }
    else
    {
        self.meleeattackpoint._id_9C3B = 0;
        self.meleeattackpoint.origin = var_1;

        if ( isdefined( self.distractiondrone ) )
        {
            if ( !isdefined( maps\mp\agents\humanoid\_humanoid_util::dropsectorpostoground( self.meleeattackpoint.origin, 15, 55 ) ) )
            {
                if ( !isdefined( self.random_sector_order ) )
                {
                    self.random_sector_order = [];

                    for ( var_3 = 0; var_3 < maps\mp\agents\humanoid\_humanoid_util::getnummeleesectors(); var_3++ )
                        self.random_sector_order[self.random_sector_order.size] = var_3;

                    self.random_sector_order = common_scripts\utility::array_randomize( self.random_sector_order );
                }

                foreach ( var_5 in self.random_sector_order )
                {
                    var_6 = var_0 maps\mp\agents\humanoid\_humanoid_util::getmeleesectors( self.meleesectortype );
                    var_7 = var_6[var_5];

                    if ( isdefined( var_7.origin ) )
                    {
                        self.meleeattackpoint.origin = var_7.origin;
                        break;
                    }
                }
            }
        }
    }

    return self.meleeattackpoint;
}

_id_A214()
{
    self notify( "watchFavoriteEnemyDeath" );
    self endon( "watchFavoriteEnemyDeath" );
    self endon( "death" );
    self endon( "disconnect" );
    self._id_017C common_scripts\utility::waittill_any_timeout( 5.0, "death", "disconnect" );
    maps\mp\agents\humanoid\_humanoid_util::setfavoriteenemy( undefined );
}

dostophitreaction( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );

    if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
        return;

    if ( maps\mp\agents\humanoid\_humanoid_util::_id_50EA() )
        return;

    self _meth_839D( 1 );
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "DoStopHitReaction" );
    self.inpain = 1;
    var_5 = "pain_stand";

    if ( isdefined( var_1 ) && var_1 == "head" )
        var_5 = "pain_stand_head";

    var_6 = 0;
    var_7 = angleclamp180( var_0 - self.angles[1] );

    if ( isdefined( var_2 ) && var_2 == "boost_slam_mp" )
    {
        if ( var_4 / self.maxhealth > 0.2 )
        {
            if ( abs( var_7 ) < 45 )
                var_5 = "pain_knockback_front";
            else if ( abs( var_7 ) > 135 )
                var_5 = "pain_knockback_back";
            else if ( var_7 > 0 )
                var_5 = "pain_knockback_right";
            else
                var_5 = "pain_knockback_left";
        }
        else
            var_5 = "pain_stun";

        var_8 = self _meth_83D6( var_5 );
        var_6 = randomint( var_8 );
    }
    else if ( isdefined( var_2 ) && var_2 == "iw5_linegundamagezm_mp" )
    {
        if ( abs( var_7 ) < 45 )
            var_5 = "pain_knockback_front";
        else if ( abs( var_7 ) > 135 )
            var_5 = "pain_knockback_back";
        else if ( var_7 > 0 )
            var_5 = "pain_knockback_right";
        else
            var_5 = "pain_knockback_left";

        var_8 = self _meth_83D6( var_5 );
        var_6 = randomint( var_8 );
    }
    else
    {
        var_8 = self _meth_83D6( var_5 );
        var_6 = maps\mp\agents\humanoid\_humanoid_util::getpainangleindexvariable( var_7, var_8 );
    }

    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", self.angles );
    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_5, var_6, self.nonmoveratescale, "pain_anim" );
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "DoStopHitReaction" );
    self.inpain = undefined;
    self _meth_839D( 0 );
}

_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self._id_9361 = gettime();

    if ( isdefined( self.owner ) )
        self._id_2598 = vectornormalize( self.origin - self.owner.origin );

    if ( shouldplaystophitreaction( var_2, var_5, var_4, var_8 ) )
        thread dostophitreaction( maps\mp\agents\humanoid\_humanoid_util::damagehitangle( var_6, var_7 ), var_8, var_5, var_4, var_2 );
    else if ( isdefined( self._id_0C69._id_6461[self._id_09A3] ) )
        self [[ self._id_0C69._id_6461[self._id_09A3] ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

shouldplaystophitreaction( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_1 ) && ( maps\mp\zombies\_util::iszombiednagrenade( var_1 ) || var_1 == "trap_zm_mp" || var_1 == "zombie_water_trap_mp" ) )
        return 0;

    if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
        return 0;

    if ( self._id_09A3 == "traverse" )
        return 0;

    if ( isdefined( var_3 ) && var_3 == "head" && ( !isdefined( self.lastheadshot ) || gettime() - self.lastheadshot > 10000 ) )
    {
        if ( !maps\mp\zombies\_util::_id_508F( self.noheadshotpainreaction ) )
        {
            self.lastheadshot = gettime();
            return 1;
        }
    }

    if ( shouldboostslamhitreaction( var_1 ) )
        return 1;

    if ( shouldrepulsorhitreaction( var_1 ) && var_0 < self.health )
        return 1;

    if ( shouldlinegunhitreaction( var_1 ) && var_0 < self.health )
        return 1;

    if ( !maps\mp\zombies\_zombies::shouldplayhitreactionpainsensor() )
        return 0;

    if ( isdefined( var_1 ) && weaponclass( var_1 ) == "sniper" )
        return 1;

    if ( isdefined( var_2 ) && isexplosivedamagemod( var_2 ) && var_0 >= 10 )
        return 1;

    if ( isdefined( var_2 ) && var_2 == "MOD_MELEE" )
        return 1;

    if ( isdefined( var_1 ) && var_1 == "concussion_grenade_mp" )
        return 1;

    if ( isdefined( self.shouldplaystophitreactionfunc ) && [[ self.shouldplaystophitreactionfunc ]]() )
        return 1;

    return 0;
}

shouldboostslamhitreaction( var_0 )
{
    if ( maps\mp\zombies\_util::nohitreactions() )
        return 0;

    if ( isdefined( var_0 ) && var_0 == "boost_slam_mp" )
        return 1;

    return 0;
}

shouldrepulsorhitreaction( var_0 )
{
    if ( maps\mp\zombies\_util::nohitreactions() )
        return 0;

    if ( isdefined( var_0 ) && var_0 == "repulsor_zombie_mp" )
        return 1;

    return 0;
}

shouldlinegunhitreaction( var_0 )
{
    if ( maps\mp\zombies\_util::nohitreactions() )
        return 0;

    if ( isdefined( var_0 ) && var_0 == "iw5_linegundamagezm_mp" )
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

        if ( !maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
            _id_64AA();
    }
}

_id_64AA( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    dostophitreaction( self.angles[1] + 180 );
}
