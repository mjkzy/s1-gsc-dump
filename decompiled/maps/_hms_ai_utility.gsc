// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

gototogoal( var_0, var_1, var_2 )
{
    self endon( "death" );
    self.goalradius = 64;

    if ( !isdefined( var_1 ) || !isstring( var_1 ) )
        var_1 = "default";

    switch ( var_1 )
    {
        case "default":
            self.enablesprint = 0;
            self.enablecqb = 0;
            break;
        case "sprint":
            self.enablesprint = 1;
            self.enablecqb = 0;
            break;
        case "cqb":
            self.enablecqb = 1;
            self.enablesprint = 0;
            break;
    }

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( var_2 == 1 )
        playerleashdisable();

    if ( self.enablesprint == 1 && distance( self.origin, var_0.origin ) >= 512 )
    {
        maps\_utility::enable_sprint();
        maps\_utility::disable_pain();
    }

    if ( self.enablecqb == 1 )
        maps\_utility::enable_cqbwalk();

    self notify( "newgoal" );
    maps\_utility::set_goal_node( var_0 );
    waitframe();
    _waittillgoalornewgoal();

    if ( isdefined( self.sprint ) && self.sprint == 1 )
    {
        maps\_utility::disable_sprint();
        maps\_utility::enable_pain();
    }

    if ( self.enablecqb == 1 )
        maps\_utility::disable_cqbwalk();
}

_waittillgoalornewgoal()
{
    self endon( "newgoal" );
    self waittill( "goal" );
}

playerleashbehavior( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "disable_leash_behavior" );

    if ( isdefined( self.bplayerleash ) && self.bplayerleash == 1 )
        return;

    self.bplayerleash = 1;
    common_scripts\utility::create_dvar( "AI_Leash_Debug", 0 );
    common_scripts\utility::create_dvar( "AI_Score_Debug", 0 );
    common_scripts\utility::create_dvar( "AI_Teleport_Debug", 0 );
    self.goalradius = 16;
    self.fixednodesaferadius = 64;
    self.script_careful = 1;
    self.disablelongpain = 1;
    self.ignoresuppression = 1;

    if ( isdefined( self.bestcovernode ) )
        self.bestcovernode = undefined;

    self.leashplayerdistancetether = 400;

    if ( isdefined( var_0 ) )
        self.leashplayerdistancetether = var_0;

    self.leashcoversearchradius = 400;

    if ( isdefined( var_1 ) )
        self.leashcoversearchradius = var_1;

    self.leashcoversearchradiusmin = 64;
    self.leashsearchoffset = 128;

    if ( isdefined( var_2 ) )
        self.leashsearchoffset = var_2;

    var_4 = self.leashsearchoffset * 2;
    self.leashheightoffset = 32;

    if ( isdefined( var_3 ) )
        self.leashheightoffset = var_3;

    thread _teleportleashbehavior();
    childthread _updateenemygroupdirection();
    childthread _updatebuddycovernodes();
    var_5 = randomfloatrange( 8, 15 );

    for (;;)
    {
        wait 0.05;
        var_5 -= 0.05;

        if ( var_5 < 0 || !maps\_utility::players_within_distance( self.leashplayerdistancetether, self.origin ) )
        {
            if ( common_scripts\utility::cointoss() )
            {
                movetocovernearplayer();
                self waittill( "goal" );
            }

            var_5 = randomfloatrange( 3, 6 );
        }
    }
}

playerleashdisable()
{
    self.bplayerleash = 0;
    self notify( "disable_leash_behavior" );
}

_updateenemygroupdirection()
{
    self endon( "death" );
    self endon( "disable_leash_behavior" );
    level notify( "UpdateEnemyGroupDirection" );
    level endon( "UpdateEnemyGroupDirection" );
    var_0 = _func_0D6( "axis" );
    self.enemydirection = undefined;

    for (;;)
    {
        wait 0.05;
        var_0 = _func_0D6( "axis" );

        if ( var_0.size == 0 )
        {
            self.enemydirection = undefined;
            continue;
        }

        var_1 = ( 0, 0, 0 );

        foreach ( var_3 in var_0 )
            var_1 += vectornormalize( var_3.origin - self.origin );

        var_1 = ( var_1[0], var_1[1], 0 );
        var_1 /= var_0.size;
        self.enemydirection = vectornormalize( var_1 );
    }
}

_updatebuddycovernodes()
{
    self endon( "death" );
    self endon( "disable_leash_behavior" );
    level notify( "UpdateBuddyCoverNodes" );
    level endon( "UpdateBuddyCoverNodes" );
    var_0 = maps\_sarray::sarray_spawn();

    for (;;)
    {
        wait 0.05;

        if ( !_evaluatebuddycovernodes( var_0 ) )
            continue;

        var_1 = var_0.array[0];

        if ( !isdefined( var_1 ) )
            continue;

        if ( getdvarint( "AI_Score_Debug" ) == 1 )
        {

        }

        self.bestcovernode = var_0.array[0];
    }
}

_evaluatebuddycovernodes( var_0 )
{
    var_1 = anglestoforward( level.player.angles );

    if ( isdefined( self.enemydirection ) )
        var_1 = self.enemydirection;

    var_2 = level.player.origin + var_1 * self.leashsearchoffset;
    var_3 = getnodesinradiussorted( var_2, self.leashcoversearchradius, self.leashcoversearchradiusmin, self.leashheightoffset, "cover" );

    if ( var_3.size == 0 )
        return 0;

    var_0 maps\_sarray::sarray_clear();
    var_4 = getdvarint( "AI_Score_Debug" );

    foreach ( var_6 in var_3 )
    {
        wait 0.05;
        var_6.score = _determineallynodescore( self, var_6, self.leashcoversearchradius );

        if ( var_6.score < 0 )
            continue;

        if ( var_4 == 1 )
        {

        }

        var_0 maps\_sarray::sarray_push( var_6 );
    }

    maps\_sarray::sarray_sort_by_handler( var_0, maps\_sarray::sarray_create_func_obj( ::_sortbyscore ) );
    return 1;
}

movetocovernearplayer()
{
    self endon( "death" );

    if ( !isdefined( self.bestcovernode ) )
    {
        maps\_utility::set_goal_pos( self.origin );
        return;
    }

    self.currentcovernode = self.bestcovernode;
    _advancetogoal( self.bestcovernode );
}

_evaluatenoderangetoplayer( var_0, var_1 )
{
    var_2 = length2d( level.player.origin - var_0.origin );
    return maps\_utility::linear_interpolate( min( var_2 / var_1, 1 ), 0.8, 1 );
}

_evaluatenodeplayervisibility( var_0 )
{
    if ( !sighttracepassed( level.player _meth_80A8(), var_0.origin, 1, level.player ) )
        return 0.75;

    return 1;
}

_determineallynodescore( var_0, var_1, var_2 )
{
    if ( var_1.type == "Exposed" )
        return -1;

    if ( isdefined( var_1.script_team ) && var_1.script_team == "axis" )
        return -1;

    if ( _func_027( var_1 ) )
        return -1;

    if ( distance( var_1.origin, level.player.origin ) > var_0.leashplayerdistancetether )
        return -1;

    if ( var_0 _meth_816E( var_1.origin, 128 ) )
        return -1;

    if ( maps\_utility::players_within_distance( 64, var_1.origin ) )
        return -1;

    var_3 = _evaluatenodeiscover( var_1 );
    var_3 += _evaluatenoderangetoplayer( var_1, var_2 );
    var_3 += _evaluatenodeplayervisibility( var_1 );
    return var_3 / 3;
}

_sortbyscore( var_0, var_1 )
{
    return var_0.score > var_1.score;
}

_advancetogoal( var_0 )
{
    self endon( "death" );
    self endon( "goal" );
    self endon( "goal_blocked" );
    self _meth_8166();
    maps\_utility::set_goal_node( var_0 );
    thread _goalblockedbyplayer( var_0 );
    thread _goalblockedbyai();
    common_scripts\utility::waittill_any_timeout( 10, "goal" );
}

_goalblockedbyplayer( var_0 )
{
    self endon( "goal" );

    for (;;)
    {
        wait 0.05;

        if ( !maps\_utility::players_within_distance( 64, var_0.origin ) )
            continue;

        self notify( "goal_blocked" );
        wait 0.05;
        movetocovernearplayer();
        return;
    }
}

_goalblockedbyai()
{
    self endon( "death" );
    self endon( "goal" );
    self waittill( "node_taken" );
    self notify( "goal_blocked" );
    movetocovernearplayer();
}

_teleportleashbehavior()
{
    self endon( "death" );
    self endon( "disable_leash_behavior" );
    var_0 = getdvarint( "cg_fov" );

    for (;;)
    {
        wait 0.05;

        if ( maps\_utility::players_within_distance( 768, self.origin ) )
            continue;

        var_1 = getnodesinradius( level.player.origin, 512, 256, 32 );

        if ( !isdefined( var_1 ) )
            continue;

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3.script_team ) && var_3.script_team == "axis" )
                var_1 = common_scripts\utility::array_remove( var_1, var_3 );

            if ( _func_027( var_3 ) || maps\_utility::players_within_distance( 64, var_3.origin ) || maps\_utility::within_fov_of_players( var_3.origin, cos( 120 ) ) || maps\_utility::within_fov_of_players( self.origin, cos( var_0 ) ) )
                var_1 = common_scripts\utility::array_remove( var_1, var_3 );
        }

        if ( var_1.size == 0 )
            continue;

        var_5 = var_1[maps\_utility::get_closest_index( level.player.origin, var_1 )];

        if ( isdefined( var_5 ) )
        {
            self _meth_8166();
            maps\_utility::anim_stopanimscripted();
            maps\_utility::teleport_ai( var_5 );
            wait 0.05;
            movetocovernearplayer();
        }
    }
}

assistplayer()
{
    self endon( "death" );
    self endon( "disable_player_assist" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );

        if ( isdefined( var_1 ) && isai( var_1 ) )
        {
            var_2 = maps\_utility::get_closest_ai( self.origin, "allies" );

            if ( isalive( var_1 ) && isdefined( var_2 ) )
                var_2 _meth_8165( var_1 );
        }

        wait 1.5;
    }
}

adjustallyaccuracyovertime()
{
    self endon( "death" );
    self endon( "disable_accuracy_adjust" );
    self.baseaccuracy = 0;

    for (;;)
    {
        wait 1;
        var_0 = self.enemy;

        if ( isdefined( var_0 ) && var_0 == self.enemy && self.baseaccuracy < 1 )
        {
            self.baseaccuracy += 0.1;
            continue;
        }

        self.baseaccuracy = 0;
    }
}

setupshotgunkva( var_0, var_1 )
{
    if ( !isdefined( level.kvashotgunners ) )
    {
        level.kvashotgunners = [];
        createthreatbiasgroup( "player" );
        createthreatbiasgroup( "kva_shotgunner" );
        level.player _meth_8177( "player" );
        setthreatbias( "player", "kva_shotgunner", 500 );
        level.player.dontmelee = 1;
    }

    common_scripts\utility::create_dvar( "AI_Pain_Debug", 0 );
    common_scripts\utility::create_dvar( "AI_Shotgunner_Score_Debug", 0 );
    var_2 = "iw5_maul_sp";
    maps\_utility::disable_surprise();
    self.disablebulletwhizbyreaction = 1;
    self.grenadeammo = 0;
    self.health = 1000;
    self.combatmode = "no_cover";
    self.a.disablelongdeath = 1;
    self.a.disablelongpain = 1;
    self.aggressivemode = 1;
    self.noruntwitch = 1;
    self.disablereactionanims = 1;
    self.ignoresuppression = 1;
    self.no_pistol_switch = 1;
    self.dontmelee = 1;
    self.meleealwayswin = 1;
    self.currentshotguncovernode = undefined;
    maps\_utility::enable_cqbwalk();
    maps\_utility::forceuseweapon( var_2, "primary" );
    self _meth_80B1( "kva_heavy_body" );
    thread codescripts\character::setheadmodel( "kva_heavy_head" );
    self _meth_818F( "face enemy" );
    self.attackradius = 512;
    self.goalradius = 64;
    maps\_utility::set_battlechatter( 0 );
    level.kvashotgunners = common_scripts\utility::add_to_array( level.kvashotgunners, self );
    self _meth_8177( "kva_shotgunner" );

    if ( !isdefined( var_1 ) )
    {
        thread _pursueenemy();
        thread _updateshotgunnercovernodes();
    }
    else
        thread _defendlocation( var_1 );

    thread painmanagement();
    thread _shotgunnerambience();
    maps\_utility::add_damage_function( ::_shotgunnerdamagefunction );
    thread _shotgunnerdeath();
}

_shotgunnerdamagefunction( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_1 ) && isdefined( var_1.script_team ) && self.script_team == var_1.script_team )
        return;

    if ( isplayer( var_1 ) )
        self notify( "Took_Damage_From_Player" );

    if ( isalive( self ) && isdefined( var_1 ) && !isplayer( var_1 ) )
        self.health = int( min( self.maxhealth, self.health + var_0 * 0.7 ) );
    else if ( isalive( self ) && isdefined( var_1 ) && isplayer( var_1 ) && isexplosivedamagemod( var_4 ) )
        self _meth_8051( var_0 / 2, self.origin, level.player );
}

_shotgunnerambience()
{
    self endon( "death" );

    for (;;)
    {
        wait(randomfloatrange( 2, 10 ));

        if ( maps\_utility::players_within_distance( 2048, self.origin ) )
        {
            if ( soundexists( "shotgunner_chatter" ) )
                maps\_utility::play_sound_on_entity( "shotgunner_chatter" );
        }
    }
}

_shotgunnerdeath()
{
    self waittill( "death" );
    level.kvashotgunners = maps\_utility::array_removedead_or_dying( level.kvashotgunners );

    if ( soundexists( "shotgunner_death_fx" ) )
    {
        var_0 = spawn( "script_origin", self.origin );
        var_0 thread maps\_utility::play_sound_on_entity( "shotgunner_death_fx", "deathsfx_ended" );
        var_0 waittill( "deathsfx_ended" );
        var_0 delete();
    }
}

_drawdebug()
{
    for (;;)
    {
        wait 0.05;

        if ( getdvarint( "AI_Shotgunner_Score_Debug" ) <= 0 )
            continue;

        if ( isdefined( self ) && isdefined( self.attacknode ) )
        {
            if ( isdefined( self.attacknode.score ) )
            {

            }
        }
    }
}

_defendlocation( var_0 )
{
    self endon( "death" );

    if ( !_func_027( var_0 ) )
    {
        thread maps\_utility::set_goal_node( var_0 );
        thread _abortdefendlocation();
    }
}

_abortdefendlocation()
{
    self endon( "death" );
    common_scripts\utility::waittill_any( "Took_Damage_From_Player", "Abort_Defend_Goal" );
    thread _pursueenemy();
    thread _updateshotgunnercovernodes();
}

_pursueenemy()
{
    self endon( "death" );

    if ( !isdefined( self.attackradius ) )
        self.attackradius = 512;

    for (;;)
    {
        wait 0.05;
        var_0 = level.player;

        if ( isdefined( self.enemy ) )
            var_0 = self.enemy;

        var_1 = distancesquared( var_0.origin, self.origin );

        if ( var_1 < squared( self.attackradius ) || var_1 < squared( 150 ) )
            continue;

        if ( isdefined( self.attacknode ) )
        {
            self notify( "changing_cover" );
            _shotgunneradvance( self.attacknode );
        }
    }
}

_shotgunneradvance( var_0 )
{
    self endon( "death" );
    self endon( "changing_cover" );
    self endon( "node_taken" );
    self.currentshotguncovernode = var_0;
    maps\_utility::set_goal_node( var_0 );
    common_scripts\utility::waittill_any_timeout( 5, "goal" );
}

_updateshotgunnercovernodes()
{
    self endon( "death" );

    for (;;)
    {
        wait 0.05;
        var_0 = level.player;

        if ( isdefined( self.enemy ) )
            var_0 = self.enemy;

        _evaluateshotgunnercovernodes( var_0, self.attackradius );
    }
}

_evaluateshotgunnercovernodes( var_0, var_1 )
{
    self notify( "_EvaluateShotgunnerCoverNodes" );
    self endon( "_EvaluateShotgunnerCoverNodes" );
    self endon( "death" );
    var_2 = -1;

    if ( isdefined( self.attacknode ) )
        var_2 = _determineshotgunnodescore( self, self.attacknode, var_1 );

    var_3 = getnodesinradiussorted( var_0.origin, var_1, var_1 / 2, 64 );

    if ( var_3.size == 0 )
        return;

    var_4 = 0;
    var_5 = var_3.size + 1;
    var_6 = getdvarint( "AI_Shotgunner_Score_Debug" ) > 0;

    foreach ( var_8 in var_3 )
    {
        wait 0.05;

        if ( var_4 > 20 )
            break;

        var_9 = _determineshotgunnodescore( self, var_8, var_1 );

        if ( var_6 )
        {

        }

        if ( var_9 >= 0 && var_9 > var_2 )
        {
            self.attacknode = var_8;
            self.attacknode.score = var_9;
            var_2 = var_9;
        }

        var_4++;
    }
}

_evaluatenodeknownenemyinradius( var_0, var_1 )
{
    if ( var_1 _meth_816E( var_0.origin, 128 ) )
        return 0;

    return 1;
}

_evaluatenodeplayerinradius( var_0 )
{
    if ( maps\_utility::players_within_distance( 128, var_0.origin ) )
        return 0.75;

    return 1;
}

_evaluatenodeiscover( var_0 )
{
    if ( var_0.type == "Cover Left" )
        return 0.95;

    if ( var_0.type == "Cover Right" )
        return 0.9;

    if ( var_0.type == "Cover Crouch" )
        return 0.85;

    if ( var_0.type == "Cover Stand" )
        return 0.75;

    return 0;
}

_evaluatenodeisexposed( var_0 )
{
    if ( var_0.type == "Exposed" )
        return 0.75;

    return 0;
}

_evaluatenodeinplayerfov( var_0 )
{
    if ( !maps\_utility::within_fov_of_players( var_0.origin, cos( 35 ) ) )
        return 0.65;

    return 1;
}

_evaluatenodelostoplayer( var_0 )
{
    if ( !sighttracepassed( level.player _meth_80A8(), var_0.origin, 0, level.player ) )
        return 0.85;

    return 1;
}

_evaluatenodeattackradius( var_0, var_1 )
{
    if ( var_1 <= 0 )
        return 1;

    var_2 = distance2d( level.player.origin, var_0.origin );
    return clamp( var_2 / var_1, 0, 1 );
}

_evaluatenodeothershotgunnersbest( var_0, var_1 )
{
    foreach ( var_3 in level.kvashotgunners )
    {
        if ( var_1 == var_3 )
            continue;

        if ( isdefined( var_3.attacknode ) && var_0 == var_3.attacknode )
            return 0.5;
    }

    return 1;
}

_determineshotgunnodescore( var_0, var_1, var_2 )
{
    if ( _func_027( var_1 ) )
        return -1;

    var_3 = _evaluatenodeknownenemyinradius( var_1, var_0 );
    var_3 += _evaluatenodeplayerinradius( var_1 );
    var_3 += _evaluatenodeiscover( var_1 );
    var_3 += _evaluatenodeisexposed( var_1 );
    var_3 += _evaluatenodeinplayerfov( var_1 );
    var_3 += _evaluatenodelostoplayer( var_1 );
    var_3 += _evaluatenodeattackradius( var_1, var_2 );
    var_3 *= _evaluatenodeothershotgunnersbest( var_1, var_0 );
    var_3 /= 7;
    return var_3;
}

painmanagement( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "disable_pain_management" );

    if ( !isdefined( var_0 ) )
        var_0 = 70;

    if ( !isdefined( var_1 ) )
        var_1 = 150;

    if ( !isdefined( var_3 ) )
        var_3 = 5;

    if ( !isdefined( var_2 ) )
        var_2 = 225;

    self.minpaindamage = var_0;
    var_4 = spawnstruct();
    var_4.amount = 0;
    childthread _updatepainamount( var_4 );

    for (;;)
    {
        wait 0.05;
        self.minpaindamage = int( maps\_utility::linear_interpolate( min( var_4.amount / var_2, 1 ), var_0, var_1 ) );
        var_4.amount -= var_3;
        var_4.amount = max( var_4.amount, 0 );
    }
}

_updatepainamount( var_0 )
{
    for (;;)
    {
        self waittill( "damage", var_1 );
        wait 0.05;
        var_0.amount += var_1;
    }
}

_enableexplosivedeath()
{
    maps\_utility::enable_long_death();
    self waittill( "deathanim" );
    var_0 = spawn( "script_origin", self.origin );
    var_0 _meth_804D( self, "TAG_WEAPON_CHEST" );
    var_1 = var_0.origin + ( 0, 0, 16 );

    for ( var_2 = 0; var_2 < 5; var_2++ )
    {
        var_3 = randomfloatrange( 1.5, 3 );
        _func_071( "fraggrenade", var_0.origin, var_1, var_3 );
        wait 0.05;
    }
}

_getindex( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in var_0 )
    {
        if ( var_4 == var_1 )
            return var_2;

        var_2++;
    }
}
