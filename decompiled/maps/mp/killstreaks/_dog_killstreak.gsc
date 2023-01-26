// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    precachemodel( "animal_dobernan" );
    level.killstreakfuncs["guard_dog"] = ::_id_98A6;
}

_id_806C()
{
    level._id_0897["dog"] = level._id_0897["player"];
    level._id_0897["dog"]["spawn"] = ::_id_88DF;
    level._id_0897["dog"]["on_killed"] = ::_id_6435;
    level._id_0897["dog"]["on_damaged"] = maps\mp\agents\_agents::_id_6436;
    level._id_0897["dog"]["on_damaged_finished"] = ::_id_643E;
    level._id_0897["dog"]["think"] = maps\mp\agents\dog\_dog_think::main;
    level.killstreakwieldweapons["agent_mp"] = "agent_mp";
}

_id_98A6( var_0, var_1 )
{
    return _id_9BF4();
}

_id_9BF4()
{
    if ( maps\mp\agents\_agent_utility::_id_4052( "dog" ) >= 5 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_TOO_MANY_DOGS" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::_id_4055( self, "dog" ) >= 1 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_ALREADY_HAVE_DOG" );
        return 0;
    }

    if ( maps\mp\agents\_agent_utility::_id_4054( self ) >= 2 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_AGENT_MAX" );
        return 0;
    }

    var_0 = isagent();

    if ( maps\mp\agents\_agent_utility::_id_4052() >= var_0 )
    {
        self iclientprintlnbold( &"KILLSTREAKS_UNAVAILABLE" );
        return 0;
    }

    if ( !maps\mp\_utility::isreallyalive( self ) )
        return 0;

    var_1 = maps\mp\agents\_agent_utility::_id_414A( 1 );

    if ( !isdefined( var_1 ) )
        return 0;

    var_2 = maps\mp\agents\_agent_common::_id_214C( "dog", self.team );

    if ( !isdefined( var_2 ) )
        return 0;

    var_2 maps\mp\agents\_agent_utility::_id_7DAB( self.team, self );
    var_3 = var_1.origin;
    var_4 = vectortoangles( self.origin - var_1.origin );
    var_2 thread [[ var_2 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]( var_3, var_4, self );
    var_2 maps\mp\_utility::_setnameplatematerial( "player_name_bg_green_dog", "player_name_bg_red_dog" );

    if ( isdefined( self.balldrone ) && self.balldrone._id_12D7 == "ball_drone_backup" )
        maps\mp\gametypes\_missions::processchallenge( "ch_twiceasdeadly" );

    return 1;
}

_id_6435( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.isactive = 0;
    self._id_4723 = 0;
    var_1._id_55AD = gettime();

    if ( isdefined( self._id_0C69._id_64A2[self._id_09A3] ) )
        self [[ self._id_0C69._id_64A2[self._id_09A3] ]]();

    if ( isplayer( var_1 ) && isdefined( self.owner ) && var_1 != self.owner )
    {
        self.owner maps\mp\_utility::leaderdialogonplayer( "dog_killed" );
        maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_4, var_3, var_2, "destroyed_guard_dog" );

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_missions::processchallenge( "ch_notsobestfriend" );

            if ( !self isonground() )
                var_1 maps\mp\gametypes\_missions::processchallenge( "ch_hoopla" );
        }
    }

    self _meth_83D2( "death" );
    var_9 = self _meth_83D3();
    var_10 = getanimlength( var_9 );
    var_8 = int( var_10 * 1000 );
    self.body = self _meth_838D( var_8 );
    self playsound( "anml_doberman_death" );
    maps\mp\agents\_agent_utility::_id_2630();
    self notify( "killanimscript" );
}

_id_643E( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( self._id_6DB0 ) )
        thread _id_6987( 2.5 );

    var_10 = var_2;

    if ( isdefined( var_8 ) && var_8 == "head" && level.gametype != "horde" )
    {
        var_10 = int( var_10 * 0.6 );

        if ( var_2 > 0 && var_10 <= 0 )
            var_10 = 1;
    }

    if ( self.health - var_10 > 0 )
        maps\mp\agents\dog\_dog_think::_id_6461( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( isplayer( var_1 ) )
    {
        if ( isdefined( self._id_0E4A ) && self._id_0E4A != "attacking" )
        {
            if ( distancesquared( self.origin, var_1.origin ) <= self._id_2CC3 )
            {
                self._id_017C = var_1;
                self._id_39AA = 1;
                thread maps\mp\agents\dog\_dog_think::_id_A214();
            }
        }
    }

    maps\mp\agents\_agents::_id_0896( var_0, var_1, var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

_id_6987( var_0 )
{
    self endon( "death" );
    self playsound( "anml_doberman_pain" );
    self._id_6DB0 = 1;
    wait(var_0);
    self._id_6DB0 = undefined;
}

_id_88DF( var_0, var_1, var_2 )
{
    if ( _func_282() )
        self setmodel( "animal_dobernan" );
    else
        self setmodel( "animal_dobernan" );

    self._id_8A3A = "dog";
    self._id_648D = maps\mp\agents\dog\_dog_think::_id_648D;

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_3 = var_0;
        var_4 = var_1;
    }
    else
    {
        var_5 = self [[ level.getspawnpoint ]]();
        var_3 = var_5.origin;
        var_4 = var_5.angles;
    }

    maps\mp\agents\_agent_utility::_id_070B();
    self.spawntime = gettime();
    self.lastspawntime = gettime();
    maps\mp\agents\dog\_dog_think::init();
    self _meth_838A( var_3, var_4, "dog_animclass", 15, 40, var_2 );
    level notify( "spawned_agent", self );
    maps\mp\agents\_agent_common::set_agent_health( 250 );

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::_id_7DAB( var_2.team, var_2 );

    self setthreatbiasgroup( "Dogs" );
    self takeallweapons();

    if ( isdefined( self.owner ) )
    {
        self hide();
        wait 1.0;

        if ( !isalive( self ) )
            return;

        self show();
        wait 0.1;
    }

    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();
    wait 0.1;

    if ( _func_282() )
        playfxontag( level._id_3B0C, self, "tag_origin" );
}
