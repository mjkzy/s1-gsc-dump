// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    while ( !isdefined( level.struct_class_names ) )
        wait 0.05;

    level.gibshotgunrange = 128;
    level.gibexplosivedamagetypes = [ "weapon_grenade", "weapon_projectile", "killstreak" ];
    level._id_0897["zombie"] = level._id_0897["player"];
    level._id_0897["zombie"]["onAIConnect"] = maps\mp\zombies\_util::_id_644A;
    level._id_0897["zombie"]["on_killed"] = ::onzombiekilled;
    level._id_0897["zombie"]["on_damaged"] = ::onzombiedamaged;
    level._id_0897["zombie"]["on_damaged_finished"] = ::onzombiedamagefinished;
    level._id_0897["zombie"]["spawn"] = maps\mp\zombies\_util::onspawnscriptagenthumanoid;
    level._id_0897["zombie"]["think"] = maps\mp\zombies\_util::agentemptythink;
    createthreatbiasgroup( "zombies" );
    maps\mp\zombies\zombie_generic::init();

    if ( isdefined( level.zombiedoginit ) )
        [[ level.zombiedoginit ]]();

    if ( isdefined( level.zombiehostinit ) )
        [[ level.zombiehostinit ]]();

    if ( isdefined( level.zombielevelinit ) )
        [[ level.zombielevelinit ]]();

    if ( !isdefined( level.zombies_spawners_zombie ) )
        level.zombies_spawners_zombie = [];

    level.zombies_spawners_zombie = common_scripts\utility::array_combine( level.zombies_spawners_zombie, common_scripts\utility::getstructarray( "zombie_spawner", "targetname" ) );
    level.zombies_spawners_zombie = common_scripts\utility::array_combine( level.zombies_spawners_zombie, common_scripts\utility::getstructarray( "Spawner_A", "targetname" ) );
    level thread markpathnodezombiezones();
    level thread monitorplayerzone();
    level thread monitorplayerinexploitvolume();
}

markpathnodezombiezones()
{
    var_0 = getallnodes();
    var_1 = 0;

    while ( var_0.size > 0 )
    {
        var_2 = var_0[var_0.size - 1];

        if ( isdefined( level.zone_data ) )
        {
            var_3 = maps\mp\zombies\_zombies_zone_manager::getlocationzone( var_2.origin );

            if ( !isdefined( var_3 ) && maps\mp\zombies\_util::getzombieslevelnum() >= 3 )
            {
                var_3 = maps\mp\zombies\_zombies_zone_manager::getlocationzone( var_2.origin + ( 1.0, 0.0, 0.0 ) );

                if ( !isdefined( var_3 ) )
                    var_3 = maps\mp\zombies\_zombies_zone_manager::getlocationzone( var_2.origin + ( 0.0, 1.0, 0.0 ) );
            }

            if ( isdefined( var_3 ) )
                var_2.zombieszone = var_3;
        }

        var_0[var_0.size - 1] = undefined;
        var_1++;

        if ( var_1 % 20 == 0 )
            wait 0.05;
    }

    level.closetpathnodescalculated = 1;
}

monitorplayerzone()
{
    level endon( "game_ended" );

    if ( !isdefined( level.zone_data ) )
        return;

    var_0 = 0.05;
    var_1 = 0;

    for (;;)
    {
        var_2 = 0;

        foreach ( var_4 in level.players )
        {
            if ( !isalive( var_4 ) )
                continue;

            if ( var_4.sessionstate != "spectator" && var_4.sessionstate != "intermission" )
            {
                var_5 = var_4 maps\mp\zombies\_zombies_zone_manager::getplayerzone();

                if ( isdefined( var_5 ) )
                    var_4.currentzone = var_5;
                else
                    var_4.currentzone = undefined;

                wait(var_0);
                var_2 += var_0;
            }
        }

        if ( var_2 == 0 )
            wait(var_0);
    }
}

monitorplayerinexploitvolume()
{
    level endon( "game_ended" );

    if ( !isdefined( level.zone_data ) )
        return;

    var_0 = 0.5;
    var_1 = getentarray( "zombie_ledge_exploit", "targetname" );
    var_2 = [];

    foreach ( var_8, var_4 in level.zone_data.zones )
    {
        var_2[var_8] = [];

        foreach ( var_6 in var_1 )
        {
            if ( var_6.script_noteworthy == var_8 )
                var_2[var_8][var_2[var_8].size] = var_6;
        }
    }

    for (;;)
    {
        var_9 = 0;

        foreach ( var_11 in level.players )
        {
            if ( !isalive( var_11 ) )
                continue;

            var_11.isinexploitspot = 0;
            var_11.validnotmoving = 0;

            if ( var_11.sessionstate != "spectator" && var_11.sessionstate != "intermission" )
            {
                if ( isdefined( var_11.currentzone ) && length( var_11 getvelocity() ) < 5 )
                {
                    var_11.validnotmoving = 1;

                    foreach ( var_6 in var_2[var_11.currentzone] )
                    {
                        if ( var_11 istouching( var_6 ) )
                        {
                            var_11.isinexploitspot = 1;
                            break;
                        }
                    }
                }
            }

            if ( isdefined( level.zmpatchshovefunc ) )
                var_11 [[ level.zmpatchshovefunc ]]( var_11.isinexploitspot, var_11.validnotmoving );

            wait(var_0);
            var_9 += var_0;
        }

        if ( var_9 == 0 )
            wait(var_0);
    }
}

spawnzombie( var_0, var_1, var_2 )
{
    var_3 = maps\mp\zombies\_util::agentclassget( var_0 );

    if ( isdefined( var_1 ) )
        var_4 = var_1;
    else
        var_4 = getspawnpoint( var_0, isdefined( var_3.spawnparameter ) );

    if ( !isdefined( var_4 ) )
        return;

    if ( !isdefined( var_3 ) )
        return;

    if ( isdefined( var_3.isbotagent ) && var_3.isbotagent )
        var_5 = maps\mp\zombies\_util::spawnbotagent( var_4, var_3, level._id_32C5 );
    else
        var_5 = maps\mp\zombies\_util::spawnscriptagent( var_4, var_3, level._id_32C5 );

    if ( !isdefined( var_5 ) )
        return;

    if ( !isdefined( var_3.roundhealth ) )
        var_3.roundhealth = maps\mp\gametypes\zombies::calculatezombiehealth( var_3 );

    var_5._id_5B83 = var_3._id_5B83;
    var_5.maxhealth = var_3.roundhealth;
    var_5.health = var_5.maxhealth;
    var_5.missingbodyparts = 0;
    var_5.dismember_crawl = 0;
    var_5._id_03DA = var_4;
    var_5 updatemeleechargeforcurrenthealth();

    if ( _func_2D9( var_5 ) )
    {
        if ( isdefined( var_2 ) )
            var_5 thread maps\mp\zombies\_util::zombie_set_eyes( var_2 );
        else
            var_5 thread setdefaulteyes();
    }

    var_5 setthreatbiasgroup( "zombies" );
    var_5 thread domoveloopeffects();

    if ( _func_2D9( var_5 ) )
        var_5 _meth_8556( var_0 );

    if ( isdefined( level.onzombiespawnfuncs ) )
    {
        foreach ( var_7 in level.onzombiespawnfuncs )
            var_5 thread [[ var_7 ]]();
    }

    return var_5;
}

updatemeleechargeforcurrenthealth()
{
    if ( maps\mp\zombies\_util::isinstakill() )
    {
        self _meth_8549( 1 );
        self _meth_854E( 1 );
    }
    else
    {
        if ( self.health <= level.playermeleedamage )
            self _meth_8549( 1 );
        else
            self _meth_8549( 0 );

        if ( self.health <= level.playerexomeleedamage )
        {
            self _meth_854E( 1 );
            return;
        }

        self _meth_854E( 0 );
    }
}

setdefaulteyes()
{
    self endon( "death" );
    wait 0.25;

    if ( !isdefined( self.eyefxactive ) || !self.eyefxactive )
    {
        if ( self._id_8A3A == "dog" )
            maps\mp\zombies\_util::zombie_set_eyes( "zombie_dog_eye_base" );
        else if ( self.agent_type == "zombie_host" )
            maps\mp\zombies\_util::zombie_set_eyes( "zombie_eye_host" );
        else
        {
            var_0 = maps\mp\gametypes\zombies::geteyeeffectforzombie( "vanilla", self.headmodel );
            maps\mp\zombies\_util::zombie_set_eyes( var_0 );
        }
    }
}

getspawnpoint( var_0, var_1 )
{
    var_2 = maps\mp\zombies\_zombies_zone_manager::getspawnpoint( var_0, var_1 );

    if ( isdefined( var_2 ) )
        return var_2;

    var_2 = getproximityspawnpoint();

    if ( isdefined( var_2 ) )
        return var_2;

    return getrandomspawnpoint();
}

getproximityspawnpoint()
{
    var_0 = common_scripts\utility::array_randomize( level.players );
    var_1 = 1048576;
    var_2 = 262144;
    var_3 = [];

    foreach ( var_5 in var_0 )
    {
        if ( !isalive( var_5 ) )
            continue;

        foreach ( var_7 in level.zombies_spawners_zombie )
        {
            var_8 = distancesquared( var_7.origin, var_5.origin );

            if ( var_8 < var_1 && var_8 > var_2 )
                var_3[var_3.size] = var_7;
        }

        if ( var_3.size > 0 )
            break;
    }

    if ( var_3.size > 0 )
        return common_scripts\utility::random( var_3 );
}

getrandomspawnpoint()
{
    var_0 = [];

    foreach ( var_2 in level.zombies_spawners_zombie )
    {
        if ( level.zone_data.zones[var_2.zone_name]._id_501B )
            var_0[var_0.size] = var_2;
    }

    return common_scripts\utility::random( var_0 );
}

deathgibmonitor()
{
    self waittill( "death", var_0, var_1, var_2 );

    if ( !isplayer( var_0 ) )
        return;

    var_3 = var_0 getcurrentweapon();
    var_4 = maps\mp\_utility::getweaponclass( var_3 );
    var_5 = distance( var_0.origin, self.origin );

    if ( var_5 < level.gibshotgunrange && var_4 == "weapon_shotgun" )
        deathgibs( var_0 );
    else if ( common_scripts\utility::array_contains( level.gibexplosivedamagetypes, var_4 ) )
        deathragdoll();
}

deathgibs( var_0 )
{
    var_1 = self.origin + ( 0.0, 0.0, 32.0 );
    playfx( common_scripts\utility::getfx( "mutant_gib_death" ), var_1 );
    earthquake( 0.45, 0.35, var_1, 350 );

    if ( !isdefined( var_0 ) )
        return;

    var_0 setblurforplayer( 3.25, 0.1 );
    wait 0.1;
    var_0 setblurforplayer( 0, 0.1 );
}

deathragdoll()
{
    var_0 = self.origin + ( 0.0, 0.0, 8.0 );
    self.body startragdoll();
    wait 0.1;
    physicsexplosionsphere( var_0, 128, 0, 5, 0 );
}

deathbloodpool()
{
    self waittill( "death" );

    if ( common_scripts\utility::cointoss() )
        playfx( common_scripts\utility::getfx( "mutant_blood_pool" ), self.origin );
}

zombieaimonitorthreads()
{
    thread monitorbadzombieai();
    thread monitorinitialtraversal();
    thread monitorstuckintraversal();
    thread zombie_speed_monitor();
}

monitorbadzombieai()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = gettime();
    var_1 = self.origin;
    var_2 = var_0;
    var_3 = 0;
    var_4 = 5.0;

    for (;;)
    {
        wait(var_4);
        var_5 = distancesquared( self.origin, var_1 );
        var_6 = ( gettime() - var_2 ) / 1000;
        var_7 = var_5 > 16384;
        var_8 = _func_2D9( self ) && self._id_09A3 == "melee" && isdefined( self._id_24C6 ) && distancesquared( self._id_24C6.origin, self.origin ) < 6400;

        if ( var_7 || var_8 )
        {
            var_1 = self.origin;
            var_2 = gettime();
        }
        else if ( var_6 > 35 )
        {
            if ( var_6 > 55 )
            {
                var_3 = 1;
                break;
            }
        }

        if ( maps\mp\zombies\_util::_id_1CFD( var_0, 180, 240 ) )
            break;
    }

    if ( !var_3 && maps\mp\zombies\_util::_id_508F( level.recyclefullhealthzombies ) && self.health >= self.maxhealth )
        var_3 = 1;

    if ( var_3 && shouldrecycle() && !maps\mp\zombies\_util::_id_508F( self.ignorezombierecycling ) )
        thread recyclezombie( self.agent_type );

    maps\mp\agents\_agent_utility::_id_5346( self );
}

shouldrecycle()
{
    if ( !isdefined( level.allowzombierecycle ) )
        return 0;

    return maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() > 1;
}

recyclezombie( var_0 )
{
    if ( !isdefined( level.recyclezombierequestspending ) )
        level.recyclezombierequestspending = 0;

    level.recyclezombierequestspending++;

    while ( maps\mp\agents\_agent_utility::_id_4052() >= level._id_5A32 || isdefined( level.recyclingzombie ) )
        waitframe();

    level.recyclingzombie = 1;
    maps\mp\zombies\zombies_spawn_manager::spawnzombietype( var_0 );
    wait 0.2;
    level.recyclingzombie = undefined;
    level.recyclezombierequestspending--;

    if ( level.recyclezombierequestspending < 0 )
        level.recyclezombierequestspending = 0;
}

monitorinitialtraversal()
{
    self endon( "death" );
    level endon( "game_ended" );
}

monitorstuckintraversal()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.velocity_zero_time = 0;

    for (;;)
    {
        if ( length( self getvelocity() ) == 0 && self._id_09A3 == "move" )
            self.velocity_zero_time += 0.05;
        else
            self.velocity_zero_time = 0;

        if ( self.velocity_zero_time > 2.0 )
        {
            var_0 = undefined;
            var_1 = self _meth_819D();

            if ( isdefined( var_1 ) )
            {
                var_2 = distancesquared( self.origin, var_1.origin );

                if ( var_2 < squared( 15 ) )
                    var_0 = var_1.origin;
            }

            if ( !isdefined( var_0 ) && maps\mp\zombies\_util::getzombieslevelnum() >= 3 )
            {
                var_3 = self _meth_83E1();

                if ( isdefined( var_3 ) && distancesquared( self.origin, var_3 ) > 120 )
                {
                    var_4 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );
                    var_5 = [];

                    foreach ( var_7 in var_4 )
                    {
                        if ( var_7 != self && distancesquared( var_7.origin, self.origin ) < squared( self.radius * 3 ) )
                            var_5[var_5.size] = var_7;
                    }

                    var_9 = 0;

                    foreach ( var_7 in var_5 )
                    {
                        if ( isdefined( var_7.velocity_zero_time ) && var_7.velocity_zero_time > 2.0 )
                            var_9++;
                    }

                    if ( var_9 >= 2 )
                    {
                        var_12 = self _meth_8551();

                        if ( var_12.size > 0 )
                            var_0 = var_12[0].origin;
                    }
                }
            }

            if ( isdefined( var_0 ) )
                self setorigin( var_0, 0 );
        }

        wait 0.05;
    }
}

onzombiekilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !maps\mp\zombies\_util::_id_5164( self ) )
    {
        giveburgleachievement( var_1 );
        giveexomeleeachievement( var_1, var_3 );
        giveteleportgrenadeachievement( var_1, var_4 );
        givegoliathmeleeachievement( var_1, var_3, var_4 );
        givetrickshotachievement( var_1, var_3, var_4 );
        maps\mp\zombies\_util::enemykilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

        if ( isdefined( level.onzombiekilledfunc ) )
            [[ level.onzombiekilledfunc ]]( var_1, var_4 );
    }

    thread maps\mp\zombies\_mutators::onkilledmutators( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    self _meth_83FB();
    maps\mp\zombies\_util::onscriptagentkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    spawnzombiekilledfx( self.activemutators, var_3, var_4 );
}

giveburgleachievement( var_0 )
{
    if ( !isdefined( self.distractiondrone ) || !isdefined( var_0 ) || !isplayer( var_0 ) )
        return;

    if ( isdefined( self.distractiondrone.owner ) && self.distractiondrone.owner == var_0 )
        return;

    if ( !isdefined( var_0.stolenkills ) )
        var_0.stolenkills = 0;

    var_0.stolenkills++;

    if ( var_0.stolenkills >= 10 )
        var_0 maps\mp\gametypes\zombies::givezombieachievement( "DLC1_ZOMBIE_BURGLE" );
}

giveboostslamachievement( var_0, var_1 )
{
    if ( var_1 != "boost_slam_mp" || !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.zombieslamhits ) || !isdefined( var_0.lastzombieslamtime ) )
    {
        var_0.zombieslamhits = 0;
        var_0.lastzombieslamtime = 0;
    }

    if ( gettime() - var_0.lastzombieslamtime > 300 )
        var_0.zombieslamhits = 0;

    var_0.zombieslamhits++;
    var_0.lastzombieslamtime = gettime();

    if ( var_0.zombieslamhits >= 10 )
        var_0 maps\mp\gametypes\zombies::givezombieachievement( "DLC1_ZOMBIE_COMEONANDSLAM" );
}

giveexomeleeachievement( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || var_1 != "MOD_MELEE" )
        return;

    if ( !var_0 maps\mp\zombies\_terminals::hasexosuit() )
        return;

    if ( !isdefined( var_0.zombieexomeleekills ) )
        var_0.zombieexomeleekills = [];

    var_0.zombieexomeleekills[var_0.zombieexomeleekills.size] = gettime();
    var_2 = [];

    foreach ( var_4 in var_0.zombieexomeleekills )
    {
        var_5 = gettime() - var_4;

        if ( gettime() - var_4 > 30000 )
            continue;

        var_2[var_2.size] = var_4;
    }

    var_0.zombieexomeleekills = var_2;

    if ( var_0.zombieexomeleekills.size == 10 )
        var_0 maps\mp\gametypes\zombies::givezombieachievement( "DLC1_ZOMBIE_DOYOUEVENEXO" );
}

giveteleportgrenadeachievement( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) || var_1 != "teleport_zombies_mp" )
        return;

    if ( !isdefined( var_0.teleportgrenadekills ) )
        var_0.teleportgrenadekills = 0;

    var_0.teleportgrenadekills++;

    if ( var_0.teleportgrenadekills == 50 )
        var_0 maps\mp\gametypes\zombies::givezombieachievement( "DLC3_ZOMBIE_TELEFRAG" );
}

givegoliathmeleeachievement( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_2 ) || var_2 != "iw5_exominigunzm_mp" )
        return;

    if ( !isdefined( var_1 ) || var_1 != "MOD_MELEE_ALT" )
        return;

    if ( !isdefined( var_0.goliathmeleekills ) )
        var_0.goliathmeleekills = 0;

    var_0.goliathmeleekills++;

    if ( var_0.goliathmeleekills == 20 )
        var_0 maps\mp\gametypes\zombies::givezombieachievement( "DLC4_ZOMBIE_REALSTEEL" );
}

givetrickshotachievement( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) || !isplayer( var_0 ) || !isdefined( var_2 ) )
        return;

    var_3 = getweaponbasename( var_2 );

    if ( var_3 != "iw5_tridentzm_mp" )
        return;

    if ( isdefined( var_1 ) && var_1 == "MOD_MELEE" )
        return;

    var_4 = self.origin;
    var_5 = var_0.origin;
    var_6 = vectornormalize( var_4 - var_5 );
    var_7 = anglestoforward( var_0 getangles() );

    if ( vectordot( var_6, var_7 ) >= 0 )
        return;

    if ( !isdefined( var_0.trickshotkills ) )
        var_0.trickshotkills = 0;

    var_0.trickshotkills++;

    if ( var_0.trickshotkills == 100 )
        var_0 maps\mp\gametypes\zombies::givezombieachievement( "DLC4_ZOMBIE_TRICKSHOT" );
}

spawnzombiekilledfx( var_0, var_1, var_2 )
{
    if ( !isdefined( self.body ) )
        return;

    if ( isdefined( level.spawnzombiekilledfxfunc ) )
    {
        var_3 = self [[ level.spawnzombiekilledfxfunc ]]( var_1, var_2 );

        if ( var_3 )
            return;
    }

    var_4 = self.recentlylostlimbs;

    if ( !isdefined( var_4 ) )
        return;

    if ( maps\mp\zombies\_util::countlimbs( var_4 ) >= 3 )
    {
        thread spawncorpsefullbodygib( var_0 );
        return;
    }

    while ( var_4 > 0 )
    {
        var_5 = var_4 & 0 - var_4;
        thread spawncorpsebleedingfx( var_5, var_0 );
        var_4 -= var_5;
    }
}

spawncorpsebleedingfx( var_0, var_1 )
{
    var_2 = level.dismemberment[var_0]["torsoFX"];

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_1["emz"] ) )
            var_2 += "_emz";
        else if ( isdefined( var_1["exploder"] ) )
            var_2 += "_exp";
        else if ( isdefined( var_1["fast"] ) )
            var_2 += "_ovr";
    }

    playfxontag( common_scripts\utility::getfx( var_2 ), self.body, level.dismemberment[var_0]["fxTagName"] );
    wait 10;

    if ( isdefined( self.body ) )
        stopfxontag( common_scripts\utility::getfx( var_2 ), self.body, level.dismemberment[var_0]["fxTagName"] );
}

spawncorpsefullbodygib( var_0 )
{
    var_1 = 3;

    if ( isdefined( level.splitscreen ) && level.splitscreen )
        var_1 = 1;

    var_2 = level.fullbodygibcounter < var_1;

    if ( var_2 )
    {
        level.fullbodygibcounter++;
        var_3 = common_scripts\utility::getfx( "gib_full_body" );
    }
    else
        var_3 = common_scripts\utility::getfx( "gib_full_body_cheap" );

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_0["emz"] ) )
            var_3 = common_scripts\utility::getfx( "gib_full_body_emz" );
        else if ( isdefined( var_0["exploder"] ) )
            var_3 = common_scripts\utility::getfx( "gib_full_body_exp" );
        else if ( isdefined( var_0["fast"] ) )
            var_3 = common_scripts\utility::getfx( "gib_full_body_ovr" );
    }

    var_4 = level.dismemberment["full"]["fxTagName"];
    playfxontag( var_3, self.body, var_4 );
    var_5 = maps\mp\zombies\_util::getdismembersoundname();
    self.body _meth_8438( level.dismemberment["full"][var_5] );
    wait 3;

    if ( isdefined( self.body ) )
        stopfxontag( var_3, self.body, var_4 );

    if ( var_2 )
        level.fullbodygibcounter--;
}

onzombiedamaged( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    maps\mp\agents\_agents::_id_6436( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

cantrymutilate( var_0, var_1 )
{
    return !maps\mp\zombies\_util::iszombiednagrenade( var_0 ) && !maps\mp\zombies\_util::zombiewaitingfordeath() && var_1 != "MOD_FALLING" && var_0 != "repulsor_zombie_mp" && var_0 != "zombie_water_trap_mp" && var_0 != "zombie_vaporize_mp" && !( var_0 == "iw5_exominigunzm_mp" && var_1 == "MOD_MELEE_ALT" ) && !maps\mp\zombies\_util::_id_508F( self.skipmutilate );
}

onzombiedamagefinished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = self.health;
    var_11 = 0;
    var_12 = cantrymutilate( var_5, var_4 );

    if ( var_12 )
    {
        if ( self.health > 0 )
            var_13 = clamp( var_2 / self.health, 0, 1 );
        else
            var_13 = 1;

        var_11 = maps\mp\zombies\_mutators::trymutilate( var_8, var_5, var_4, var_13, var_1, var_7 );

        if ( var_11 && isdefined( var_1 ) )
            var_2 = self.health + 1;
    }

    if ( isdefined( var_1 ) && isplayer( var_1 ) && !isdefined( self._id_017C ) )
    {
        var_14 = self._id_09A3 != "melee";
        var_15 = isdefined( self._id_24C6 ) && self._id_24C6 == var_1;
        var_16 = isdefined( self._id_24C6 ) && !isplayer( self._id_24C6 );

        if ( var_14 || var_15 || var_16 )
        {
            if ( distancesquared( self.origin, var_1.origin ) <= self.damagedradiussq )
            {
                maps\mp\agents\humanoid\_humanoid_util::setfavoriteenemy( var_1 );
                thread maps\mp\agents\humanoid\_humanoid::_id_A214();
            }
        }
    }

    thread maps\mp\zombies\_mutators::ondamagefinishedmutators( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
    giveboostslamachievement( var_1, var_5 );

    if ( !maps\mp\zombies\_util::candie() && self.health - var_2 <= 0 )
    {
        thread maps\mp\zombies\_util::zombiependingdeath( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        var_2 = int( max( 0, self.health - 1 ) );
    }

    if ( self._id_8A3A == "dog" )
        self [[ level.zombiedogondamage ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
    else
    {
        ondamagepainsensor( var_2, var_4, var_5 );
        maps\mp\agents\humanoid\_humanoid::_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
    }

    maps\mp\zombies\_zombies_audio::do_zombies_playvocals( "pain", self.agent_type );
    level notify( "zombie_damaged", self, var_1 );
    maps\mp\agents\_agents::_id_0896( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( isalive( self ) )
    {
        if ( var_11 && !maps\mp\zombies\_util::ispendingdeath() )
            self suicide();
        else
            updatemeleechargeforcurrenthealth();
    }
}

zombie_speed_monitor()
{
    self endon( "death" );
    level.zombie_move_modes = [ "walk", "run", "sprint" ];

    if ( isdefined( level.wavecycleoverride ) )
        var_0 = level.wavecycleoverride;
    else
        var_0 = 7;

    if ( !isdefined( level.moveratescalemod ) )
    {
        level.moveratescalemod["walk"][0] = 0.65;
        level.moveratescalemod["walk"][1] = 1.5;
        level.moveratescalemod["run"][0] = 0.7;
        level.moveratescalemod["run"][1] = 1.25;
        level.moveratescalemod["sprint"][0] = 0.8;
        level.moveratescalemod["sprint"][1] = 0.9;
    }

    if ( !isdefined( level.nonmoveratescalemod ) )
    {
        level.nonmoveratescalemod["walk"] = 0.9;
        level.nonmoveratescalemod["run"] = 1.0;
        level.nonmoveratescalemod["sprint"] = 1.1;
    }

    if ( !isdefined( level.traverseratescalemod ) )
    {
        level.traverseratescalemod[0] = 0.55;
        level.traverseratescalemod[1] = 1.55;
    }

    if ( !isdefined( level.zombiesharpturndist ) )
    {
        level.zombiesharpturndist["walk"] = 100;
        level.zombiesharpturndist["run"] = 130;
        level.zombiesharpturndist["sprint"] = 130;
    }

    for (;;)
    {
        if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() || self._id_09A3 == "traverse" )
        {
            wait 0.05;
            continue;
        }

        if ( isdefined( level.movemodefunc[self.agent_type] ) )
            self._id_02A6 = [[ level.movemodefunc[self.agent_type] ]]();
        else
            self._id_02A6 = calulatezombiemovemode( var_0 );

        self._id_03C0 = level.zombiesharpturndist[self._id_02A6];

        if ( isdefined( level.moveratescalefunc[self.agent_type] ) )
            self.moveratescale = [[ level.moveratescalefunc[self.agent_type] ]]();
        else
            self.moveratescale = calculatezombiemoveratescale( var_0, level.moveratescalemod[self._id_02A6][0], level.moveratescalemod[self._id_02A6][1] );

        if ( isdefined( level.nonmoveratescalefunc[self.agent_type] ) )
            self.nonmoveratescale = [[ level.nonmoveratescalefunc[self.agent_type] ]]();
        else
            self.nonmoveratescale = calculatezombienonmoveratescale( self._id_02A6 );

        if ( isdefined( level.traverseratescalefunc[self.agent_type] ) )
            self.traverseratescale = [[ level.traverseratescalefunc[self.agent_type] ]]();
        else
            self.traverseratescale = calculatezombietraverseratescale( var_0, level.traverseratescalemod[0], level.traverseratescalemod[1] );

        self.generalspeedratescale = self.traverseratescale;

        if ( maps\mp\agents\humanoid\_humanoid_util::_id_50EA() )
        {
            self._id_03C0 = 100;
            self.moveratescale = self.generalspeedratescale;
        }

        common_scripts\utility::waittill_any_timeout( 1.0, "speed_debuffs_changed" );
    }
}

calulatezombiemovemode( var_0 )
{
    var_1 = calculatezombieroundindex( var_0 );
    var_2 = int( var_1 / var_0 );
    return level.zombie_move_modes[int( clamp( var_2, 0, level.zombie_move_modes.size - 1 ) )];
}

calculatezombiemoveratescale( var_0, var_1, var_2 )
{
    var_3 = calculatezombieroundindex( var_0 );
    var_4 = var_3 % var_0;
    var_5 = float( var_4 ) / float( var_0 - 1 );
    var_6 = maps\mp\zombies\_util::_id_5682( var_5, var_1, var_2 );

    if ( level.wavecounter > 24 )
        var_6 += 0.05;

    if ( level.wavecounter > 29 )
        var_6 += 0.05;

    var_6 *= getbuffspeedmultiplier();
    return var_6;
}

calculatezombienonmoveratescale( var_0 )
{
    var_1 = level.nonmoveratescalemod[var_0];
    var_1 *= getbuffspeedmultiplier();
    return var_1;
}

calculatezombietraverseratescale( var_0, var_1, var_2 )
{
    var_3 = calculatezombieroundindex( var_0 );
    var_4 = var_3 / ( level.zombie_move_modes.size * var_0 - 1.0 );
    var_5 = maps\mp\zombies\_util::_id_5682( var_4, var_1, var_2 );

    if ( level.wavecounter > 24 )
        var_5 += 0.05;

    if ( level.wavecounter > 29 )
        var_5 += 0.05;

    var_5 *= getbuffspeedmultiplier();
    return var_5;
}

calculatezombieroundindex( var_0 )
{
    var_1 = level.wavecounter - 1;

    if ( isdefined( self.moverateroundmod ) )
        var_1 += self.moverateroundmod;

    var_1 = int( clamp( var_1, 0, level.zombie_move_modes.size * var_0 - 1 ) );
    return var_1;
}

domoveloopeffects()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "move_loop", var_0 );

        switch ( var_0 )
        {
            case "fx_blood":
                crawlingfx( "J_MainRoot", "gib_bloodpool" );
                continue;
            case "fx_dust":
                crawlingfx( "J_MainRoot", "crawl_dust" );
                continue;
        }
    }
}

crawlingfx( var_0, var_1 )
{
    var_2 = self gettagorigin( var_0 );
    var_3 = self gettagangles( var_0 );
    playfx( common_scripts\utility::getfx( var_1 ), var_2, anglestoforward( var_3 ), ( 0.0, 0.0, 1.0 ) );
}

addbuff( var_0, var_1 )
{
    self.buffs[var_0] = var_1;
}

getbuff( var_0 )
{
    if ( !isdefined( self.buffs ) || !isdefined( self.buffs[var_0] ) )
        return undefined;

    return self.buffs[var_0];
}

updatebuff( var_0 )
{
    if ( !isdefined( var_0.buffupdate ) )
        return;

    self [[ var_0.buffupdate ]]( var_0 );
}

removebuff( var_0 )
{
    if ( !isdefined( var_0.buffremove ) )
        return;

    self [[ var_0.buffremove ]]( var_0 );
}

getbufftimestep()
{
    return 0.1;
}

updatebuffs()
{
    self notify( "updateBuffs" );
    self endon( "updateBuffs" );
    self endon( "death" );
    var_0 = getbufftimestep();
    var_1 = 0;

    for (;;)
    {
        wait(var_0);

        if ( !isdefined( self.buffs ) )
            continue;

        foreach ( var_4, var_3 in self.buffs )
        {
            updatebuff( var_3 );
            var_3._id_56F5 -= var_0;

            if ( var_3._id_56F5 < 0 )
            {
                removebuff( var_3 );
                self.buffs[var_4] = undefined;
            }
        }

        self.buffs = maps\mp\zombies\_util::arrayremoveundefinedkeephash( self.buffs );
    }
}

getbuffspeedmultiplier()
{
    var_0 = 1;

    if ( !isdefined( self.buffs ) )
        return var_0;

    foreach ( var_3, var_2 in self.buffs )
    {
        if ( !isdefined( var_2.speedmultiplier ) )
            continue;

        var_0 *= var_2.speedmultiplier;
    }

    return var_0;
}

updatepainsensor()
{
    self notify( "updatePainSensor" );
    self endon( "updatePainSensor" );
    self endon( "death" );
    self.painsensor = spawnstruct();
    self.painsensor._id_55C4 = gettime();
    self.painsensor.damage = 0.0;
    var_0 = 0.05;
    var_1 = 5 * var_0;

    for (;;)
    {
        wait(var_0);

        if ( gettime() > self.painsensor._id_55C4 + 2000 )
            self.painsensor.damage -= var_1;

        self.painsensor.damage = max( self.painsensor.damage, 0 );

        if ( isplayinghitreaction() )
            self.painsensor.damage = 0;
    }
}

ondamagepainsensor( var_0, var_1, var_2 )
{
    if ( isdefined( self.ondamagepainsensorfunc ) )
        [[ self.ondamagepainsensorfunc ]]( var_0, var_1, var_2 );

    if ( isdefined( var_2 ) && ( var_2 == "dna_aoe_grenade_zombie_mp" || var_2 == "trap_zm_mp" ) )
        return;

    self.painsensor._id_55C4 = gettime();
    self.painsensor.damage += var_0;
}

gethitreactiondamagethreshold()
{
    if ( isdefined( self.gethitreactiondamagethresholdfunc ) )
        return [[ self.gethitreactiondamagethresholdfunc ]]();

    var_0 = clamp( level.wavecounter / 15, 0, 1 );
    var_1 = maps\mp\zombies\_util::_id_5682( 1 - var_0, 0.1, 0.5 );
    return var_1 * self.maxhealth;
}

shouldplayhitreactionpainsensor()
{
    if ( !isdefined( self.painsensor ) )
        return 1;

    if ( self.painsensor.damage > gethitreactiondamagethreshold() )
        return 1;

    return 0;
}

isplayinghitreaction()
{
    if ( isdefined( self.inpainmoving ) && self.inpainmoving )
        return 1;

    if ( isdefined( self.inpain ) && self.inpain )
        return 1;

    return 0;
}
