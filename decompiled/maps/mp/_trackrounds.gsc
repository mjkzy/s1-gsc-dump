// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

trackrounds_think()
{
    if ( getdvar( "mapname" ) == getdvar( "virtualLobbyMap" ) )
        return;

    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self.trackrounds = spawnstruct();
    self.trackrounds._id_46F6 = 0;
    self.trackrounds.has_trackrounds = 0;

    if ( maps\mp\_utility::_hasperk( "specialty_paint_pro" ) )
        self.trackrounds._id_46F6 = 1;

    var_0 = self getcurrentweapon();
    _id_93C7( var_0 );

    for (;;)
    {
        self waittill( "weapon_change", var_0 );

        if ( var_0 == "none" )
        {
            wait 0.4;
            var_0 = self getcurrentweapon();

            if ( var_0 == "none" )
                return;
        }

        _id_93C7( var_0 );
        wait 0.05;
    }
}

_id_93C7( var_0 )
{
    var_1 = undefined;

    if ( isdefined( var_0 ) )
        var_1 = getweaponattachments( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
        {
            if ( var_3 == "trackrounds" )
            {
                self.trackrounds.has_trackrounds = 1;
                maps\mp\_utility::giveperk( "specialty_paint_pro", 0, 0 );
                return;
            }
        }

        self.trackrounds.has_trackrounds = 0;

        if ( !self.trackrounds._id_46F6 )
            maps\mp\_utility::_unsetperk( "specialty_paint_pro" );

        return;
    }
}

set_painted_trackrounds( var_0 )
{
    if ( isplayer( self ) )
    {
        if ( isdefined( self._id_665B ) && self._id_665B )
            return;

        self._id_665B = 1;
        thread _id_9509();
    }
}

_id_9508()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    self._id_665B = 0;
}

_id_9509()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    thread _id_9508();

    for (;;)
    {
        wait 0.1;

        if ( self hasperk( "specialty_radararrow", 1 ) )
            continue;

        if ( self hasperk( "specialty_radarblip", 1 ) )
            continue;

        self setperk( "specialty_radarblip", 1, 0 );
    }
}
