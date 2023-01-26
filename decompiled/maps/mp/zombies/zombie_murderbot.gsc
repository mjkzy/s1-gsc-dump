// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_0897["zombie_murderbot"] = level._id_0897["zombie"];
    level._id_0897["zombie_murderbot"]["think"] = ::zombie_murderbot_think;
    level._id_0897["zombie_murderbot"]["on_killed"] = ::onmurderbotkilled;
    level._id_0897["zombie_murderbot"]["on_damaged"] = ::onmurderbotdamaged;
    var_0[0] = [ "murderbot_dlc" ];
    var_1 = spawnstruct();
    var_1.agent_type = "zombie_murderbot";
    var_1.animclass = "zombie_murderbot_animclass";
    var_1.model_bodies = var_0;
    var_1._id_4780 = 3.0;
    var_1._id_5B83 = 1000;
    maps\mp\zombies\_util::agentclassregister( var_1, "zombie_murderbot" );
    level.movemodefunc["zombie_murderbot"] = ::murderbotcalculatemovemode;
    level.moveratescalefunc["zombie_murderbot"] = ::murderbotcalculatemoveratescale;
    level.nonmoveratescalefunc["zombie_murderbot"] = ::murderbotcalculatenonmoveratescale;
    level.traverseratescalefunc["zombie_murderbot"] = ::murderbotcalculatetraverseratescale;
    level._effect["murderbot_eyes"] = loadfx( "vfx/gameplay/mp/zombie/murderbot_eyes" );
    level._effect["murderbot_melee_sparks"] = loadfx( "vfx/trail/dlc_murderbot_melee_sparks" );
    level._effect["murderbot_deactivation"] = loadfx( "vfx/map/mp_zombie_brg/dlc_murderbot_deactivation" );
}

kill_random_zombies( var_0 )
{
    waitframe();
    var_1 = sortbydistance( level.agentarray, var_0 );
    var_2 = var_1.size - 1;
    var_3 = 0;

    for ( var_2 = var_1.size - 1; var_2 >= 0; var_2-- )
    {
        var_4 = var_1[var_2];

        if ( !isdefined( var_4 ) || !isdefined( var_4.agent_type ) || var_4.agent_type == "zombie_melee_goliath" || var_4.agent_type == "zombie_murderbot" )
            continue;

        if ( isplayer( var_4 ) )
            continue;

        var_4 suicide();
        var_3++;

        if ( var_3 >= 2 )
            break;
    }
}

spawnmurderbot( var_0, var_1, var_2 )
{
    level endon( "zombie_wave_interrupt" );
    var_3 = maps\mp\zombies\_util::agentclassget( "zombie_murderbot" );
    var_0.script_animation = "activation";
    var_0._id_79F8 = "ignoreRealign";
    thread kill_random_zombies( var_0.origin );
    var_4 = maps\mp\zombies\_util::spawnscriptagent( var_0, var_3, level._id_6D6C );

    if ( !isdefined( var_4 ) )
        return;

    var_1 hide();
    var_2 hide();
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "murderbot_eyes" ), var_4, "tag_eye" );
    var_4 maps\mp\agents\_agent_common::set_agent_health( var_3.roundhealth );
    var_4._id_5B83 = var_3._id_5B83;
    var_4 maps\mp\zombies\_util::zombies_make_objective( "compass_objpoint_ammo_friendly" );
    var_4.hastraversed = 1;
    var_4 attachmurderbotweapons();
    var_4 thread lifetimemonitor();
    var_4 thread killenemymonitor();
    var_4 _meth_853C( "civilian" );
    return var_4;
}

lifetimemonitor()
{
    level endon( "game_ended" );
    self endon( "death" );

    while ( isdefined( self.inspawnanim ) && self.inspawnanim )
        waitframe();

    var_0 = gettime() + 120000;

    while ( gettime() < var_0 )
        waitframe();

    while ( self._id_09A3 == "traverse" || self._id_09A3 == "melee" )
        waitframe();

    self _meth_839D( 1 );
    waitframe();
    maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe( "deactivation", 0, "scripted_anim" );
    self playsound( "zmb_murderbot_death_destruct" );
    self suicide();
}

killenemymonitor()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.killarray = [];

    for (;;)
    {
        if ( self.killarray.size > 0 )
        {
            foreach ( var_1 in self.killarray )
            {
                collidewithagent( var_1["enemy"], var_1["direction"] );

                if ( !isalive( var_1["enemy"] ) )
                {
                    foreach ( var_3 in level.players )
                        var_3 maps\mp\gametypes\zombies::_id_41FB( var_1["event"] );
                }
            }

            self.killarray = [];
        }

        waitframe();
    }
}

attachmurderbotweapons()
{
    var_0[0] = "dlc_melee_speaker";
    var_1 = spawn( "script_model", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
    var_1.angles = self gettagangles( "TAG_WEAPON_RIGHT" );
    var_2 = randomint( var_0.size );
    var_1 setmodel( var_0[var_2] );
    var_1 linkto( self, "TAG_WEAPON_RIGHT", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "murderbot_melee_sparks" ), var_1, "tag_sparks" );
    self.murderbotweapon = var_1;
}

setupmurderbotstate()
{
    self._id_0E4E = 54;
    self._id_0E4F = -64;
    self.damagedradiussq = 2250000;
    self._id_01FD = 1;
    self.moveratescale = 1;
    self.nonmoveratescale = 1;
    self.traverseratescale = 1;
    self._id_1432 = 0;
    self._id_1434 = 1;
    self._id_9361 = 0;
    self._id_0030 = 1;
    self.meleecheckheight = 40;
    self.meleeradiusbase = 60;
    self.meleeradiusbasesq = squared( self.meleeradiusbase );
    self.defaultgoalradius = self.radius + 1;
    self _meth_8394( self.defaultgoalradius );
    self.meleedot = 0.5;
    maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate( 1.0, self.meleeradiusbase * 2, self.meleeradiusbase * 1.5, "attack_lunge_boost", level._effect["boost_lunge"] );
    maps\mp\agents\humanoid\_humanoid_util::lungemeleeenable();
    self._id_0C69._id_648C["melee"] = ::murderbot_melee;
    self.boostfxtag = "no_boost_fx";
    self._id_04C3 = 50;
    self.lungeattackready = 1;
    self.lungelast = 0;
}

zombie_murderbot_think()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
    setupmurderbotstate();
    thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
    thread maps\mp\zombies\_util::_id_A008();
    thread maps\mp\zombies\zombie_generic::zombie_generic_moan();
    thread maps\mp\zombies\zombie_generic::zombie_audio_monitor();
    thread maps\mp\zombies\_zombies::updatebuffs();
    thread maps\mp\zombies\_zombies::updatepainsensor();
    thread updatemurderbotlungecooldown();

    for (;;)
    {
        if ( isdefined( self.isscripted ) )
        {
            wait 0.05;
            continue;
        }

        if ( self._id_09A3 == "traverse" )
        {
            wait 0.05;
            continue;
        }

        if ( murderbot_do_sync_attack() )
        {
            wait 0.05;
            continue;
        }

        if ( murderbot_begin_melee() )
        {
            wait 0.05;
            continue;
        }

        if ( maps\mp\zombies\_behavior::humanoid_seek_enemy_melee() )
        {
            wait 0.05;
            continue;
        }

        if ( maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known() )
        {
            wait 0.05;
            continue;
        }

        maps\mp\zombies\_behavior::humanoid_seek_random_loc();
        wait 0.05;
    }
}

murderbot_do_sync_attack()
{
    if ( !canbeginmelee() )
        return 0;

    if ( isdefined( self._id_24C6.agent_type ) && self._id_24C6.agent_type == "zombie_melee_goliath" )
    {
        if ( self._id_24C6._id_09A3 == "traverse" )
            return 0;

        if ( distancesquared( self.origin, self._id_24C6.origin ) < 40000 )
        {
            murderbotmeleegoliathattack( self._id_24C6 );
            return 1;
        }
    }

    return 0;
}

canbeginmelee()
{
    if ( self._id_01FC )
        return 0;

    if ( !isdefined( self._id_24C6 ) )
        return 0;

    if ( self._id_09A3 == "melee" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
        return 0;

    if ( !maps\mp\zombies\_util::has_entered_game() )
        return 0;

    if ( maps\mp\agents\humanoid\_humanoid::_id_A14D() )
        return 0;

    if ( maps\mp\agents\humanoid\_humanoid::_id_2A49() )
        return 0;

    return 1;
}

murderbot_begin_melee()
{
    if ( !canbeginmelee() )
        return 0;

    var_0 = maps\mp\zombies\_util::_id_508F( self.lungemeleeenabled ) && isdefined( self.lungelast ) && gettime() - self.lungelast <= self.lungedebouncems;

    if ( maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_0 )
    {
        if ( !murderbotreadytomeleetarget( "base" ) )
            return 0;
    }
    else if ( !murderbotreadytomeleetarget( "normal" ) )
        return 0;

    if ( isdefined( self.meleedebouncetime ) )
    {
        var_1 = gettime() - self.lastmeleefinishtime;

        if ( var_1 < self.meleedebouncetime * 1000 )
            return 0;
    }

    if ( isdefined( self.lastmeleepos ) )
        var_2 = distancesquared( self.lastmeleepos, self.origin );

    if ( !isdefined( self.lastmeleepos ) || distancesquared( self.lastmeleepos, self.origin ) > 256 )
        self.meleemovemode = self._id_02A6;

    self _meth_839C( self._id_24C6 );
    return 1;
}

murderbotreadytomeleetarget( var_0 )
{
    if ( !isdefined( self._id_24C6 ) )
        return 0;

    if ( !maps\mp\_utility::isreallyalive( self._id_24C6 ) )
        return 0;

    if ( self._id_09A3 == "traverse" )
        return 0;

    if ( !maps\mp\agents\humanoid\_humanoid_util::isentstandingonme( self._id_24C6 ) )
    {
        if ( !maps\mp\agents\humanoid\_humanoid::_id_5208( self._id_24C6.origin ) )
            return 0;
    }

    if ( distancesquared( self.origin, self._id_24C6.origin ) > squared( 250 ) )
        return 0;

    if ( maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked() )
        return 0;

    return 1;
}

murderbot_melee()
{
    self endon( "death" );
    self endon( "killanimscript" );
    self._id_24C6 endon( "disconnect" );
    var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( self._id_24C6 );

    if ( maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked() )
        return maps\mp\agents\humanoid\_humanoid_melee::_id_5B84();

    if ( maps\mp\zombies\_util::_id_508F( self.lungemeleeenabled ) && var_0._id_9C3B )
    {
        if ( isdefined( self.meleemovemode ) && self.lungeattackready )
        {
            var_1 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint( self.origin, var_0.origin );

            if ( var_1 )
            {
                self.lungelast = gettime();
                murderbotattacklunge( self._id_24C6, var_0.origin );
                return;
            }
        }
    }

    murderbotattackstandard( self._id_24C6, var_0.origin );
}

murderbotmeleegoliathattack( var_0 )
{
    var_0 _meth_839D( 1 );
    var_0 maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "SynchronizedAnim" );
    var_0 _meth_8398( "noclip" );
    self _meth_839D( 1 );
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "SynchronizedAnim" );
    self _meth_8398( "noclip" );
    var_0 _meth_8561( 0.5, 0.1, self, "tag_sync", "tag_sync" );
    var_0.deathanimstateoverride = "death_by_murderbot";
    thread playmurderbotimpactfx( var_0 );
    thread maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe( "murderbot_kills_goliath", 0, "scripted_anim" );
    var_0 maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe( "murderbot_kills_goliath", 0, "scripted_anim", "death_gib" );
    killgoliath( var_0, 10000000, "MOD_MELEE", "kill_head" );
    maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe( "scripted_anim", "end" );
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "SynchronizedAnim" );
    self _meth_839D( 0 );
}

playmurderbotimpactfx( var_0 )
{
    for (;;)
    {
        var_0 waittill( "scripted_anim", var_1 );

        if ( var_1 == "end" )
            break;

        switch ( var_1 )
        {
            case "fx_hit":
                maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "gib_full_body" ), var_0, "J_Spine4" );
                continue;
        }
    }
}

killgoliath( var_0, var_1, var_2, var_3 )
{
    maps\mp\agents\humanoid\_humanoid_melee::_id_2CF2( var_0, var_1, var_2 );

    if ( !isalive( var_0 ) )
    {
        foreach ( var_5 in level.players )
            var_5 maps\mp\gametypes\zombies::_id_41FB( var_3 );
    }
}

killenemy( var_0, var_1 )
{
    var_2 = vectornormalize( ( self.origin - var_0.origin ) * ( 1.0, 1.0, 0.0 ) );
    var_3["enemy"] = var_0;
    var_3["direction"] = var_2;
    var_3["event"] = var_1;
    self.killarray[self.killarray.size] = var_3;
}

murderbotattackstandard( var_0, var_1 )
{
    if ( isdefined( self.meleemovemode ) )
    {
        var_2 = "attack_" + self.meleemovemode;
        self.meleemovemode = undefined;
        murderbotdoattack( var_0, var_1, var_2, 1, 1, 1.5 );
    }
    else
        murderbotdoattack( var_0, var_1, "attack_stand", 0, 0, 1.5 );
}

murderbotattacklunge( var_0, var_1 )
{
    murderbotdoattack( var_0, var_1, self.lungeanimstate, 1, 1, 1.25 );
}

murderbotdoattack( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self._id_55BA = undefined;
    self._id_55BB = undefined;
    var_6 = randomint( self _meth_83D6( var_2 ) );
    var_7 = self _meth_83D3( var_2, var_6 );
    var_8 = getanimlength( var_7 );
    var_9 = getnotetracktimes( var_7, "hit" );
    var_10 = getnotetracktimes( var_7, "hit_right" );
    var_11 = gethittime( var_8, var_5, var_9, var_10 );
    self _meth_8398( "gravity" );

    if ( var_4 )
        self _meth_8396( "face enemy" );
    else
        self _meth_8396( "face angle abs", ( 0, vectortoyaw( var_0.origin - self.origin ), 0 ) );

    self _meth_8397( "anim deltas" );
    maps\mp\agents\_scripted_agent_anim_util::set_anim_state( var_2, var_6, var_5 );
    var_12 = undefined;

    if ( var_3 && var_2 != "attack_lunge_boost" )
        var_12 = 100;

    if ( var_3 )
    {
        self _meth_8395( 0, 1 );
        self _meth_839F( self.origin, var_1, var_11 );
        childthread updatemurderbotlerppos( var_0, var_11, 1, var_12 );
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "DoAttack" );
    }
    else
        self _meth_8395( 1, 1 );

    updatemeleesweeper( var_7, var_8, var_5, var_9 );
    updatemeleesweeper( var_7, var_8, var_5, var_10, self.murderbotweapon );
    wait(var_11);
    self notify( "cancel_updatelerppos" );
    self _meth_8397( "anim deltas" );
    self _meth_8395( 1, 1 );

    if ( var_3 )
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "DoAttack" );

    self.lastmeleepos = self.origin;
    var_13 = var_8 / var_5 - var_11;

    if ( var_13 > 0 )
        maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe( "attack_anim", "end", var_13 );

    self notify( "cancel_updatelerppos" );
    self _meth_8397( "anim deltas" );
    self _meth_8395( 1, 1 );

    if ( var_3 )
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "DoAttack" );

    if ( var_2 == "attack_lunge_boost" )
    {
        self.lastlungelocation = self.origin;
        self.lungeattackready = 0;
    }

    self.lastmeleefinishtime = gettime();
}

gethittime( var_0, var_1, var_2, var_3 )
{
    if ( var_2.size <= 0 && var_3.size <= 0 )
        return var_0 / var_1 * 0.33;

    var_4 = 1;

    if ( isdefined( var_2 ) && var_2.size > 0 )
        var_4 = var_0 / var_1 * var_2[0];

    var_5 = 1;

    if ( isdefined( var_3 ) && var_3.size > 0 )
        var_5 = var_0 / var_1 * var_3[0];

    return min( var_4, var_5 );
}

updatemurderbotlerppos( var_0, var_1, var_2, var_3 )
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "cancel_updatelerppos" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    var_4 = self.origin;
    var_5 = var_1;
    var_6 = 0.05;

    for (;;)
    {
        wait(var_6);
        var_5 -= var_6;

        if ( var_5 <= 0 )
            break;

        var_7 = maps\mp\agents\humanoid\_humanoid_melee::_id_4145( var_0, var_2 );

        if ( !isdefined( var_7 ) )
            break;

        if ( isdefined( var_3 ) )
        {
            var_8 = var_3;
            var_9 = var_7 - var_4;

            if ( lengthsquared( var_9 ) > var_8 * var_8 )
                var_7 = var_4 + vectornormalize( var_9 ) * var_8;
        }

        self _meth_8396( "face enemy" );
        self _meth_839F( self.origin, var_7, var_5 );
    }
}

updatemeleesweeper( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( var_3.size == 0 )
        return;

    if ( common_scripts\utility::mod( var_3.size, 2 ) != 0 )
    {

    }

    var_5 = var_1 / var_2 * var_3[0];
    var_6 = var_1 / var_2 * var_3[1];
    var_7 = 0;
    var_8 = 0.05;
    self.hitzombies = [];
    wait(var_5);
    var_9 = var_6 - var_5;

    while ( var_7 <= var_9 )
    {
        wait(var_8);
        var_7 += var_8;
        checkmeleesweeperhit( var_4 );
    }
}

getzombiesinrange( var_0 )
{
    var_1 = [];
    var_2 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );
    var_3 = var_0 * var_0;

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( var_5._id_001D ) && var_5._id_001D == level._id_6D6C )
            continue;

        if ( distancesquared( var_5.origin, self.origin ) > var_3 )
            continue;

        var_1[var_1.size] = var_5;
    }

    return var_1;
}

checkmeleesweeperhit( var_0 )
{
    var_1 = undefined;

    if ( isdefined( var_0 ) )
        var_1 = var_0 gettagorigin( "tag_fx" );
    else
        var_1 = self gettagorigin( "TAG_WEAPON_LEFT" );

    var_2 = ( var_1 - self.origin ) * ( 1.0, 1.0, 0.0 );
    var_3 = squared( length( var_2 ) + 40 );
    var_4 = self.murderbotweapon gettagangles( "tag_fx" );
    var_5 = getzombiesinrange( 256 );

    foreach ( var_7 in var_5 )
    {
        if ( !isdefined( var_7 ) || !isalive( var_7 ) || var_7 == self )
            continue;

        if ( isdefined( var_7.agent_type ) && var_7.agent_type == "zombie_melee_goliath" )
            continue;

        if ( common_scripts\utility::array_contains( self.hitzombies, var_7 ) )
            continue;

        if ( !checkmeleeheight( var_7, var_1[2] ) )
            continue;

        var_8 = ( var_7.origin - self.origin ) * ( 1.0, 1.0, 0.0 );
        var_9 = lengthsquared( var_8 );

        if ( var_9 > var_3 )
            continue;

        if ( vectordot( var_8, var_2 ) < 0.707 )
            continue;

        killenemy( var_7, "kill_trap" );
        self.hitzombies[self.hitzombies.size] = var_7;
    }
}

checkmeleeheight( var_0, var_1 )
{
    var_2 = self.origin[2] + 80;
    var_3 = max( var_2, var_1 );
    var_4 = self.origin[2] - 30;
    var_5 = var_0 geteye()[2] + 30;
    var_6 = var_0.origin[2];

    if ( var_5 >= var_4 && var_5 <= var_3 )
        return 1;

    if ( var_6 >= var_4 && var_6 <= var_3 )
        return 1;

    return 0;
}

murderbotcalculatemovemode()
{
    return "run";
}

murderbotcalculatemoveratescale()
{
    return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

murderbotcalculatenonmoveratescale()
{
    return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

murderbotcalculatetraverseratescale()
{
    return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

updatemurderbotlungecooldown()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = 0.05;

    for (;;)
    {
        wait(var_0);

        if ( !isdefined( self.lastlungelocation ) || !isdefined( self._id_24C6 ) )
            continue;

        var_1 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( self._id_24C6 );

        if ( !isdefined( var_1.origin ) )
            continue;

        var_2 = length( var_1.origin - self.lastlungelocation );

        if ( var_2 < 250 )
            continue;

        self.lungeattackready = 1;
    }
}

onmurderbotkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    self.bypasscorpse = 1;
    maps\mp\zombies\_zombies::onzombiekilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    self.murderbotweapon delete();
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "murderbot_deactivation" ), self, "J_Spine4" );
    earthquake( 0.35, 0.95, self.origin, 128 );
    playfx( common_scripts\utility::getfx( "nuke_blast" ), self.origin, anglestoforward( self.angles ), ( 0.0, 0.0, 1.0 ) );
    level thread maps\mp\gametypes\zombies::activatenukepickup( self.origin );
    spawnpickups( self.origin );
}

spawnpickups( var_0 )
{
    var_1 = getnodesinradiussorted( var_0, 300, 100, 128 );
    var_2 = [ "ammo", "insta_kill", "double_points", "fire_sale" ];

    for ( var_3 = 0; var_3 < var_2.size && var_3 < var_1.size; var_3++ )
        maps\mp\gametypes\zombies::createpickup( var_2[var_3], var_1[var_3].origin );
}

onmurderbotdamaged( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{

}

drawdebug()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 0.05;

        if ( isdefined( self._id_24C6 ) )
        {

        }

        if ( isdefined( self._id_24C6 ) )
        {
            var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( self._id_24C6 );

            if ( isdefined( var_0 ) && isdefined( var_0.origin ) )
            {

            }
        }
    }
}

collidewithagent( var_0, var_1 )
{
    if ( randomfloat( 1 ) < 0.5 )
        ragdollagent( var_0, var_1, "MOD_EXPLOSIVE", 2, 3 );
    else
        ragdollagent( var_0, var_1, "MOD_MELEE", 3, 5 );
}

ragdollagent( var_0, var_1, var_2, var_3, var_4 )
{
    var_0.ragdollimmediately = 1;
    var_0 dodamage( var_0.health + 1000, var_0 geteye(), self, undefined, var_2, "murderbotFriendlyFire", "none" );
    var_5 = self.origin - var_1 + ( 0.0, 0.0, 8.0 );
    wait 0.1;
    var_6 = randomfloatrange( 3, 5 );
    physicsexplosionsphere( var_5, 128, 0, var_6, 0 );
}

updateenemyvisibility()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 0.5;

        if ( !isdefined( self._id_0143 ) )
            continue;

        self.haslostoenemy = sighttracepassed( self geteye(), self._id_0143 geteye(), 0, self );
    }
}

_id_19D6( var_0 )
{
    var_1 = 0;
    var_2[0] = ::_id_33AE;
    var_2[1] = ::_id_33AD;
    var_2[2] = ::_id_33AB;

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = self [[ var_2[var_3] ]]( var_0 );

        if ( var_4 < 0 )
            return -1;

        var_1 += var_4;
    }

    return var_1 / var_2.size;
}

_id_33AE( var_0 )
{
    if ( !isdefined( var_0 ) || !isalive( var_0 ) )
        return -1;

    if ( isdefined( var_0.ignoreme ) && var_0.ignoreme == 1 )
        return -1;

    return 1;
}

_id_33AD( var_0 )
{
    var_1 = length( var_0.origin - self.origin );
    var_2 = max( 1 - var_1 / 1500, 0 );
    return var_2;
}

_id_33AB( var_0 )
{
    return -1;
}

_id_948D( var_0, var_1, var_2 )
{
    var_3 = bullettrace( var_0, var_1 geteye(), 0, self.murderbotshield, 0, 0, 0, 0, 0 );
    return var_3["fraction"] == 1;
}
