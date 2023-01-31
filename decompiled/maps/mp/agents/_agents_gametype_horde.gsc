// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    level thread runroundspawning();

    if ( maps\mp\_utility::getmapname() == "mp_detroit" )
        level.goliathexploittrigger = spawn( "trigger_radius", ( -1662, -72, 582.5 ), 0, 86, 64 );
}

setup_callbacks()
{
    level.agent_funcs["player"]["onAIConnect"] = ::onaiconnect;
    level.agent_funcs["player"]["think"] = ::enemyagentthink;
    level.agent_funcs["player"]["on_killed"] = ::onagentkilled;
    level.agent_funcs["squadmate"]["onAIConnect"] = ::onaiconnect;
    level.agent_funcs["squadmate"]["think"] = ::allyagentthink;
    level.agent_funcs["dog"]["onAIConnect"] = ::onaiconnect;
    level.agent_funcs["dog"]["think"] = ::agentdogthink;
    level.agent_funcs["dog"]["on_killed"] = ::ondogkilled;
}

onaiconnect()
{
    self.gamemodefirstspawn = 1;
    self.agentname = &"HORDE_GRUNT";
    self.horde_type = "";
}

runroundspawning()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "start_round" );
        wait 2;

        if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber > 10 )
        {
            runzombieround();
            continue;
        }

        runnormalround();
    }
}

runnormalround()
{
    level childthread highlightlastenemies();

    while ( level.currentenemycount < level.maxenemycount )
    {
        while ( level.currentaliveenemycount < level.maxaliveenemycount )
        {
            createenemy();

            if ( level.currentenemycount == level.maxenemycount )
                break;
        }

        level.wavefirstspawn = 0;
        level waittill( "enemy_death" );
    }
}

runzombieround()
{
    level.zombiesdead = 0;
    level waittill( "beginZombieSpawn" );

    while ( level.currentenemycount < level.maxenemycount )
    {
        while ( level.currentaliveenemycount < level.maxaliveenemycount )
        {
            createenemy();
            wait 0.1;
        }

        level.wavefirstspawn = 0;
        level common_scripts\utility::waittill_any( "enemy_death", "go_zombie" );
        level.zombiesdead++;
    }
}

createenemy()
{
    if ( level.maxdogcount > 1 && level.dogsalive < level.maxdogcount )
        createdogenemy();
    else if ( level.maxwarbirdcount > 0 )
    {
        foreach ( var_1 in level.players )
        {
            if ( maps\mp\gametypes\_horde_util::isonhumanteam( var_1 ) && isalive( var_1 ) )
            {
                level.maxwarbirdcount--;
                var_1 createwarbirdenemy();
                break;
            }
        }
    }
    else if ( level.maxdronecount > 0 )
    {
        createdroneenemy();
        level.maxdronecount--;
    }
    else
        createhumanoidenemy();
}

createhumanoidenemy()
{
    var_0 = undefined;

    while ( !isdefined( var_0 ) )
    {
        var_0 = maps\mp\agents\_agents::add_humanoid_agent( "player", level.enemyteam, "class1" );

        if ( isdefined( var_0 ) )
        {
            level.currentenemycount++;
            level.currentaliveenemycount++;
        }

        waitframe();
    }
}

createdogenemy()
{
    var_0 = undefined;

    while ( !isdefined( var_0 ) )
    {
        var_0 = maps\mp\agents\_agent_common::connectnewagent( "dog", level.enemyteam );

        if ( isdefined( var_0 ) )
        {
            var_0 thread [[ var_0 maps\mp\agents\_agent_utility::agentfunc( "spawn" ) ]]();
            var_0.awardpoints = 100;
            level.currentenemycount++;
            level.currentaliveenemycount++;
            level.dogsalive++;
        }

        waitframe();
    }
}

createdroneenemy()
{
    thread waitingtospawndrone();
    level.currentenemycount++;
    level.currentaliveenemycount++;
}

waitingtospawndrone()
{
    level.numdroneswaitingtospawn++;

    while ( maps\mp\_utility::currentactivevehiclecount( 2 ) >= maps\mp\_utility::maxvehiclesallowed() )
        wait 1;

    level.numdroneswaitingtospawn--;
    waitframe();
    var_0 = maps\mp\gametypes\_horde_drones::hordecreatedrone( level.players[0], "assault_uav_horde", level.hordedronemodel );
    var_0 _meth_83FA( level.enemyoutlinecolor, 1 );
    var_0.droneturret _meth_83FA( level.enemyoutlinecolor, 1 );
    var_0.outlinecolor = level.enemyoutlinecolor;
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

    while ( !isdefined( level.spawnedwarbirds ) )
        waitframe();

    level.spawnedwarbirds[0] endon( "death" );
    level.spawnedwarbirds[0] endon( "crashing" );
    wait 30;
}

playaispawneffect()
{
    playfx( level._effect["spawn_effect"], self.origin );
}

highlightlastenemies()
{
    level endon( "round_ended" );

    for (;;)
    {
        level waittill( "enemy_death" );

        if ( level.currentenemycount != level.maxenemycount )
            continue;

        if ( level.currentaliveenemycount < 3 )
        {
            foreach ( var_1 in level.flying_attack_drones )
            {
                var_1 _meth_83FA( level.enemyoutlinecolor, 0 );
                var_1.droneturret _meth_83FA( level.enemyoutlinecolor, 0 );
                var_1.lasttwoenemies = 1;
            }

            foreach ( var_4 in level.spawnedwarbirds )
            {
                if ( isdefined( var_4.team ) && var_4.team == "axis" && !( isdefined( var_4.iscrashing ) && var_4.iscrashing ) )
                {
                    var_4 _meth_83FA( level.enemyoutlinecolor, 0 );
                    var_4.warbirdturret _meth_83FA( level.enemyoutlinecolor, 0 );
                    var_4.lasttwoenemies = 1;
                }
            }

            foreach ( var_7 in level.characters )
            {
                if ( maps\mp\gametypes\_horde_util::isonhumanteam( var_7 ) )
                    continue;

                if ( maps\mp\_utility::isreallyalive( var_7 ) && !var_7 _meth_84F8() )
                {
                    var_7 _meth_83FA( level.enemyoutlinecolor, 0 );
                    var_7.outlinecolor = level.enemyoutlinecolor;
                }
            }

            setdvar( "bg_compassShowEnemies", 1 );
            break;
        }
    }
}

onagentkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
        hordeenemykilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    self _meth_83FB();
    maps\mp\agents\_agents::on_humanoid_agent_killed_common( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
    maps\mp\agents\_agent_utility::deactivateagent();
}

ondogkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
        hordeenemykilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    self _meth_83FB();
    maps\mp\killstreaks\_dog_killstreak::on_agent_dog_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

hordeenemykilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    level.currentaliveenemycount--;
    level.killssinceinteldrop++;
    level.killssinceammodrop++;

    if ( level.objdefend )
        maps\mp\gametypes\horde::checkdefendkill( self, var_1 );

    trackintelkills( var_4, var_3 );
    level thread maps\mp\gametypes\horde::chancetospawnpickup( self );
    level notify( "enemy_death", var_1, self );
    level.enemiesleft--;

    if ( !level.zombiesstarted )
        setomnvar( "ui_horde_enemies_left", level.enemiesleft );

    if ( isplayer( var_1 ) && !level.zombiesstarted )
    {
        maps\mp\gametypes\_horde_util::awardhordekill( var_1 );
        var_1 thread maps\mp\gametypes\_rank::xppointspopup( "kill", self.awardpoints );
        level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_1, self.awardpoints );

        if ( var_1 maps\mp\_utility::_hasperk( "specialty_triggerhappy" ) )
        {

        }
    }

    if ( isdefined( var_1 ) && isdefined( var_1.owner ) && isplayer( var_1.owner ) && isdefined( var_1.owner.killz ) )
    {
        maps\mp\gametypes\_horde_util::awardhordekill( var_1.owner );
        var_1.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", self.awardpoints );
        level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_1.owner, self.awardpoints );
    }
}

trackintelkills( var_0, var_1 )
{
    if ( level.isteamintelcomplete )
        return;

    if ( var_0 == "none" )
        return;

    if ( maps\mp\_utility::ismeleemod( var_1 ) )
        level.nummeleekillsintel++;

    if ( !maps\mp\_utility::iskillstreakweapon( var_0 ) && var_1 == "MOD_HEAD_SHOT" )
        level.numheadshotsintel++;

    if ( maps\mp\_utility::iskillstreakweapon( var_0 ) && var_0 != level.intelminigun )
        level.numkillstreakkillsintel++;

    if ( maps\mp\gametypes\_class::isvalidequipment( var_0, 0 ) || maps\mp\gametypes\_class::isvalidoffhand( var_0, 0 ) )
        level.numequipmentkillsintel++;
}

enemyagentthink()
{
    self endon( "death" );
    level endon( "game_ended" );
    self _meth_8351( "no_enemy_search", 1 );
    thread monitorbadhumanoidai();
    thread locateenemypositions();
}

monitorbadhumanoidai()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = gettime();

    for (;;)
    {
        wait 5.0;

        if ( !maps\mp\bots\_bots_util::bot_in_combat( 120000 ) )
        {
            if ( !maps\mp\bots\_bots_util::bot_in_combat( 240000 ) )
                break;
        }

        if ( checkexpiretime( var_0, 240, 480 ) )
            break;
    }
}

monitorbaddogai()
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

        if ( checkexpiretime( var_0, 120, 240 ) )
            break;
    }

    maps\mp\agents\_agent_utility::killagent( self );
}

checkexpiretime( var_0, var_1, var_2 )
{
    var_3 = ( gettime() - var_0 ) / 1000;

    if ( var_3 > var_1 )
    {
        if ( var_3 > var_2 )
            return 1;
    }

    return 0;
}

allyagentthink()
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
                self.defense_force_next_node_goal = var_2[1];
                self notify( "defend_force_node_recalculation" );
                var_1 = gettime() + 1000;
            }
        }
        else if ( float( self.health ) / self.maxhealth >= 0.6 )
            var_0 = 0;
        else if ( !var_0 )
        {
            var_3 = maps\mp\bots\_bots_util::bot_find_node_to_guard_player( self.owner.origin, 350, 1 );

            if ( isdefined( var_3 ) )
            {
                self.defense_force_next_node_goal = var_3;
                self notify( "defend_force_node_recalculation" );
                var_0 = 1;
            }
        }

        if ( !maps\mp\bots\_bots_util::bot_is_guarding_player( self.owner ) )
        {
            var_4["override_goal_type"] = "critical";
            var_4["min_goal_time"] = 20;
            var_4["max_goal_time"] = 30;
            maps\mp\bots\_bots_strategy::bot_guard_player( self.owner, 350, var_4 );
        }

        wait 0.05;
    }
}

hordesetupdogstate()
{
    self.enableextendedkill = 0;
    self.agentname = &"HORDE_QUAD";
    self.horde_type = "Quad";
    thread maps\mp\gametypes\horde::hordeapplyaimodifiers();
    self.lassetgoalpos = ( 0, 0, 0 );
    self.bhasnopath = 0;
    self.randompathstoptime = 0;
    self.maxhealth = 60;
    self.health = self.maxhealth;
}

agentdogthink()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    maps\mp\agents\dog\_dog_think::setupdogstate();
    hordesetupdogstate();
    thread locateenemypositions();
    self thread [[ self.watchattackstatefunc ]]();
    thread waitforbadpathhorde();
    thread monitorbaddogai();
    thread agentdogbark();

    for (;;)
    {
        if ( self.aistate != "melee" && !self.statelocked && maps\mp\agents\dog\_dog_think::readytomeleetarget() && !maps\mp\agents\dog\_dog_think::didpastmeleefail() )
            self _meth_839C( self.curmeleetarget );

        if ( self.randompathstoptime > gettime() )
        {
            wait 0.05;
            continue;
        }

        if ( !isdefined( self.enemy ) || self.bhasnopath )
        {
            var_0 = getnodesinradiussorted( self.origin, 1024, 256, 128, "Path" );

            if ( var_0.size > 0 )
            {
                var_1 = randomintrange( int( var_0.size * 0.9 ), var_0.size );
                self _meth_8390( var_0[var_1].origin );
                self.bhasnopath = 0;
                self.randompathstoptime = gettime() + 2500;
            }
        }
        else
        {
            var_2 = maps\mp\agents\dog\_dog_think::getattackpoint( self.enemy );
            self.curmeleetarget = self.enemy;
            self.movemode = "sprint";
            self.barrivalsenabled = 0;

            if ( distancesquared( var_2, self.lassetgoalpos ) > 4096 )
            {
                self _meth_8390( var_2 );
                self.lassetgoalpos = var_2;
            }
        }

        wait 0.05;
    }
}

agentdogbark()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        while ( !isdefined( self.curmeleetarget ) )
            wait 0.25;

        while ( isdefined( self.curmeleetarget ) && distance( self.origin, self.curmeleetarget.origin ) > 200 )
        {
            wait(randomfloatrange( 0, 2 ));
            self playsound( "anml_doberman_bark" );
        }

        wait 0.05;
    }
}

waitforbadpathhorde()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "bad_path", var_0 );
        self.bhasnopath = 1;
    }
}

locateenemypositions()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        foreach ( var_1 in level.participants )
        {
            if ( maps\mp\gametypes\_horde_util::isonhumanteam( var_1 ) )
            {
                self _meth_8165( var_1 );

                if ( isdefined( var_1.hordedrone ) )
                    self _meth_8165( var_1.hordedrone );
            }
        }

        wait 0.5;
    }
}

findclosestplayer()
{
    var_0 = undefined;
    var_1 = 1410065408;

    foreach ( var_3 in level.players )
    {
        if ( maps\mp\_utility::isreallyalive( var_3 ) && maps\mp\gametypes\_horde_util::isonhumanteam( var_3 ) && !maps\mp\gametypes\_horde_util::isplayerinlaststand( var_3 ) )
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
        if ( isdefined( self.enemy ) && self.enemy _meth_80A9( level.goliathexploittrigger ) )
        {
            self _meth_8354( ( -1696, -408, 608.5 ), 32, "critical", 200 );

            while ( isdefined( self.enemy ) && maps\mp\_utility::isreallyalive( self.enemy ) && !maps\mp\gametypes\_horde_util::isplayerinlaststand( self.enemy ) && self.enemy _meth_80A9( level.goliathexploittrigger ) )
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

    while ( !isdefined( self.enemy ) || !sighttracepassed( self gettagorigin( "TAG_ROCKET4" ), self.enemy _meth_80A8(), 0, undefined ) )
        wait 0.05;

    wait(randomintrange( 5, 10 ));

    for (;;)
    {
        while ( !isdefined( self.enemy ) || !sighttracepassed( self gettagorigin( "TAG_ROCKET4" ), self.enemy _meth_80A8(), 0, undefined ) )
            wait 0.05;

        var_0 = anglestoforward( self getangles() );
        var_1 = anglestoright( self getangles() );
        var_2 = [ ( 0, 0, 50 ), ( 0, 0, 20 ), ( 10, 0, 0 ), ( 0, 10, 0 ) ];
        var_3 = self gettagorigin( "TAG_ROCKET4" );
        playfxontag( common_scripts\utility::getfx( "swarm_rocket_wv" ), self, "TAG_ROCKET4" );

        for ( var_4 = 0; var_4 < 4; var_4++ )
        {
            var_5 = var_3 + var_0 * 20 + var_1 * -30;
            var_6 = var_0 + maps\mp\killstreaks\_juggernaut::random_vector( 0.2 );
            var_7 = magicbullet( "iw5_juggernautrockets_mp", var_3, self.enemy _meth_80A8(), self );
            var_7 thread rockettargetent( self.enemy, var_2[var_4] );
            var_7 thread maps\mp\killstreaks\_juggernaut::rocketdestroyaftertime( 7 );
            wait 0.1;
        }

        wait(randomintrange( 10, 20 ));
    }
}

rockettargetent( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        self _meth_81D9( var_0, var_1 );
}
