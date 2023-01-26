// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

monitor_exocrossbow_launch()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    level._effect["exocrossbow_sticky_explosion"] = loadfx( "vfx/explosion/frag_grenade_default" );
    level._effect["exocrossbow_sticky_blinking"] = loadfx( "vfx/lights/light_beacon_crossbow" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );
        var_2 = 0;

        if ( issubstr( var_1, "iw5_exocrossbow" ) )
            var_2 = 1;
        else if ( issubstr( var_1, "dlcgun11loot0" ) )
            var_2 = 1;

        if ( !var_2 )
            continue;

        var_0 setotherent( self );
        var_0.ch_crossbow_player_jumping = self ishighjumping();
        thread wait_for_stuck( var_0 );
    }
}

wait_for_stuck( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    var_0 endon( "death" );
    var_0 waittill( "missile_stuck", var_1 );
    var_0 thread _id_29A4( self, var_1 );
}

_id_29A4( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "faux_spawn" );

    if ( !isdefined( self ) )
        return;

    if ( isdefined( var_1 ) && !maps\mp\_utility::invirtuallobby() && isplayer( var_1 ) )
    {
        self.ch_crossbow_victim_jumping = var_1 ishighjumping();

        if ( var_0 maps\mp\gametypes\_weapons::isstucktofriendly( var_1 ) )
            self.isstuck = "friendly";
        else
        {
            self.isstuck = "enemy";
            self.stuckenemyentity = var_1;
            var_0 maps\mp\_events::crossbowstickevent( var_1 );
            var_0 notify( "process", "ch_bullseye" );
        }
    }

    thread _id_8E2D( var_0 );
    thread _id_8E2B( var_0 );
    thread _id_737F( var_0 );
    thread _id_1E86();
    thread maps\mp\gametypes\_weapons::stickyhandlemovers( "detonate" );
}

_id_8E2D( var_0 )
{
    self endon( "death" );
    wait 1.5;
    self notify( "exocrossbow_exploded" );
}

_id_8E2B( var_0 )
{
    self endon( "exocrossbow_exploded" );
    self endon( "death" );
    self._id_3B75 = common_scripts\utility::spawn_tag_origin();
    self._id_3B75.origin = self.origin;
    self._id_3B75.angles = self.angles;
    self._id_3B75 show();
    self._id_3B75 linkto( self );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "exocrossbow_sticky_blinking" ), self._id_3B75, "tag_origin" );
    self playsound( "exocrossbow_warning" );
}

_id_737F( var_0 )
{
    self endon( "death" );
    self waittill( "exocrossbow_exploded" );
    _id_1E85();
}

_id_1E86()
{
    self endon( "exocrossbow_exploded" );
    self waittill( "death" );
    _id_1E85();
}

_id_1E85()
{
    stopfxontag( common_scripts\utility::getfx( "exocrossbow_sticky_blinking" ), self._id_3B75, "tag_origin" );
    self._id_3B75 delete();
}
