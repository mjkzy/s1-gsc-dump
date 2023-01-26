// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_830A();
    thread _id_9305();
    thread maps\mp\zombies\_util::_id_A008();
    thread _id_A01E();
}

_id_830A()
{
    self._id_0E47 = 40 + self.radius;
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
    self._id_1434 = 0;
    self._id_9361 = 0;
    self._id_0030 = 1;
    self.meleecheckheight = 30;
    self.meleeradiusbase = 80;
    self.meleeradiusbasesq = squared( self.meleeradiusbase );
    maps\mp\zombies\_util::setmeleeradius( self.meleeradiusbase );
    self.defaultgoalradius = self.radius + 5;
    self _meth_8394( self.defaultgoalradius );
    self.meleedot = 0.85;
    self.lastmeleefinishtime = 0;
    self.meleedebouncetime = 1.0;
    self.played_damage_for_threshold = [];
}

init()
{
    self._id_0C69 = spawnstruct();
    self._id_0C69._id_648C = [];
    self._id_0C69._id_648C["idle"] = maps\mp\agents\dog\_zombie_dog_idle::main;
    self._id_0C69._id_648C["move"] = maps\mp\agents\dog\_zombie_dog_move::main;
    self._id_0C69._id_648C["traverse"] = maps\mp\agents\dog\_zombie_dog_traverse::main;
    self._id_0C69._id_648C["melee"] = maps\mp\agents\dog\_zombie_dog_melee::main;
    self._id_0C69._id_64A2 = [];
    self._id_0C69._id_64A2["idle"] = maps\mp\agents\dog\_zombie_dog_idle::_id_0140;
    self._id_0C69._id_64A2["move"] = maps\mp\agents\dog\_zombie_dog_move::_id_0140;
    self._id_0C69._id_64A2["melee"] = maps\mp\agents\dog\_zombie_dog_melee::_id_0140;
    self._id_0C69._id_64A2["traverse"] = maps\mp\agents\dog\_zombie_dog_traverse::_id_0140;
    self._id_0C69._id_6461 = [];
    self._id_0C69._id_6461["move"] = maps\mp\agents\dog\_zombie_dog_move::_id_6461;
    self._id_09A3 = "idle";
    self._id_02A6 = "run";
    self.radius = 18;

    if ( maps\mp\zombies\_util::getzombieslevelnum() >= 3 )
        self.radius = 17;

    self.height = 41;
}

_id_9305()
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );
    thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
    thread zombie_dog_moan();
    thread zombie_dog_audio_monitor();
    thread maps\mp\zombies\_zombies::updatebuffs();
    self._id_03C0 = 125;

    for (;;)
    {
        wait 0.05;

        if ( maps\mp\zombies\_behavior::humanoid_begin_melee() )
            continue;

        if ( maps\mp\zombies\_behavior::humanoid_seek_enemy_melee() )
            continue;

        if ( maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known() )
            continue;

        if ( maps\mp\zombies\_behavior::humanoid_seek_random_loc() )
            continue;
    }
}

zombie_dog_moan()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        while ( !isdefined( self._id_24C6 ) )
            wait 0.25;

        while ( isdefined( self._id_24C6 ) && distancesquared( self.origin, self._id_24C6.origin ) > 40000 )
        {
            wait(randomfloatrange( 0, 2 ));
            maps\mp\zombies\_zombies_audio::do_zombies_playvocals( "idle", self.agent_type );
        }

        wait 0.05;
    }
}

zombie_dog_audio_monitor()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = common_scripts\utility::waittill_any_return_parms( "attack_hit", "attack_miss" );

        switch ( var_0[0] )
        {
            case "attack_hit":
                var_1 = var_0[1];

                if ( isdefined( var_1 ) && isplayer( var_1 ) )
                {
                    if ( isalive( var_1 ) )
                        var_1 playlocalsound( "zmb_dog_bite_wound" );
                    else
                        var_1 playsoundtoplayer( "zmb_dog_bite_wound", var_1 );
                }

                continue;
            case "attack_miss":
                maps\mp\zombies\_zombies_audio::do_zombies_playvocals( "attack", self.agent_type );
                continue;
        }
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

_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self._id_9361 = gettime();

    if ( isdefined( self.owner ) )
        self._id_2598 = vectornormalize( self.origin - self.owner.origin );

    if ( isdefined( self._id_0C69._id_6461[self._id_09A3] ) && shouldplaystophitreaction( var_2, var_5, var_4, var_8 ) )
        self [[ self._id_0C69._id_6461[self._id_09A3] ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

shouldplaystophitreaction( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_1 ) && maps\mp\zombies\_util::iszombiednagrenade( var_1 ) )
        return 0;

    if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
        return 0;

    if ( isdefined( var_1 ) && var_1 == "zombie_water_trap_mp" )
        return 1;

    var_4 = self.health - var_0;
    var_5 = [ self.maxhealth * 0.6 ];

    for ( var_6 = 0; var_6 < var_5.size; var_6++ )
    {
        if ( !isdefined( self.played_damage_for_threshold[var_6] ) && var_4 < var_5[var_6] )
        {
            self.played_damage_for_threshold[var_6] = 1;
            return 1;
        }
    }

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
            maps\mp\agents\dog\_zombie_dog_move::_id_64AA();
    }
}
