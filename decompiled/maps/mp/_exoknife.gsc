// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._effect["exo_knife_blood"] = loadfx( "vfx/weaponimpact/flesh_impact_head_fatal_exit" );
}

exo_knife_think()
{
    thread _id_34A3();
}

_id_34A3()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        var_2 = maps\mp\_utility::strip_suffix( var_1, "_lefthand" );

        if ( var_2 != "exoknife_mp" && var_2 != "exoknife_jug_mp" )
            continue;

        var_0.manuallydetonatefunc = ::_id_349C;
        var_0._id_3921 = 1;
        var_0.weaponname = var_1;

        if ( !isdefined( var_0.recall ) )
            var_0.recall = 0;

        var_0.owner = self;
        thread _id_349B( var_0 );
        var_0 thread _id_34A4();
        var_0 thread _id_34A1();
        var_0 thread _id_349F();
        var_0 thread _id_349A();
    }
}

_id_349A()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "emp_update" );

        if ( isdefined( level.empequipmentdisabled ) && level.empequipmentdisabled && self.owner maps\mp\_utility::isempedbykillstreak() )
            thread _id_3499();
    }
}

_id_349B( var_0 )
{
    self endon( "disconnect" );

    if ( !isdefined( self._id_3504 ) )
        self._id_3504 = 0;

    if ( !self._id_3504 )
        common_scripts\utility::_enabledetonate( var_0.weaponname, 1 );

    self._id_3504++;
    var_0 waittill( "death" );
    self._id_3504--;

    if ( !self._id_3504 )
        common_scripts\utility::_enabledetonate( var_0.weaponname, 0 );
}

_id_349D()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    self waittill( "missile_passed_target" );
    _id_34A0();
}

_id_34A4()
{
    if ( !isdefined( self.owner ) )
        return;

    self endon( "death" );
    self.owner endon( "disconnect" );
    var_0 = spawn( "trigger_radius", self.origin, 0, 15, 5 );
    var_0 enablelinkto();
    var_0 linkto( self );
    var_0._id_53B7 = self;
    thread common_scripts\utility::delete_on_death( var_0 );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( var_1 != self.owner )
            continue;

        if ( var_1 _meth_8334( self.weaponname ) >= 1.0 )
            continue;

        break;
    }

    _id_34A0();
}

_id_34A0()
{
    self.owner setclientomnvar( "damage_feedback", "throwingknife" );
    self.owner setweaponammostock( self.weaponname, self.owner getweaponammostock( self.weaponname ) + 1 );
    _id_3499();
}

_id_34A1()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "missile_stuck", var_0 );
        var_1 = maps\mp\_riotshield::_id_330B();
        self._id_3921 = 0;
        self.recall = 0;

        if ( isdefined( self.owner ) && isdefined( var_0 ) && ( isdefined( level.ishorde ) && level.ishorde && var_0.model == "animal_dobernan" || maps\mp\_utility::isgameparticipant( var_0 ) ) && !var_1 )
        {
            if ( isdefined( var_0.team ) && isdefined( self.owner.team ) && var_0.team != self.owner.team )
                announcement( self.origin, self.origin - self.owner.origin );

            var_0 maps\mp\_snd_common_mp::snd_message( "exo_knife_player_impact" );
            var_2 = getdvarfloat( "exo_knife_return_delay", 0.5 );
            self.owner thread _id_349E( var_2 );
            continue;
        }

        thread maps\mp\gametypes\_weapons::stickyhandlemovers( undefined, "exo_knife_recall" );
    }
}

exo_knife_recall_stuck_watch()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "missile_stuck", var_0 );

        if ( isdefined( self.owner ) && isdefined( var_0 ) && var_0 maps\mp\_utility::isjuggernaut() )
        {
            if ( !level.teambased || isdefined( self.owner.team ) && isdefined( var_0.team ) && var_0.team != self.owner.team )
                thread _id_3499();
        }
    }
}

_id_349E( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "exo_knife_recall" );

    if ( isdefined( var_0 ) && var_0 > 0 )
        wait(var_0);

    self notify( "exo_knife_recall" );
}

_id_349C( var_0 )
{
    if ( isdefined( var_0 ) && !var_0.recall )
        _id_349E();
}

_id_349F()
{
    self endon( "death" );

    if ( !isdefined( self.owner ) )
        return;

    self.owner endon( "disconnect" );
    self.owner endon( "death" );
    self.owner waittill( "exo_knife_recall" );
    var_0 = self.origin;
    var_1 = self.owner geteye();

    if ( self.owner getstance() != "prone" )
        var_1 -= ( 0.0, 0.0, 20.0 );

    var_2 = getdvarfloat( "exo_knife_speed", 1200.0 );
    var_3 = distance( var_0, var_1 );
    var_4 = var_3 / var_2;
    var_5 = self.owner getvelocity();
    var_1 += var_5 * var_4;
    var_6 = var_1 - var_0;
    var_6 = vectornormalize( var_6 );
    var_7 = 0;

    if ( var_7 != 0 )
        var_0 += var_6 * var_7;

    var_8 = var_6 * var_2;
    var_9 = _func_071( self.weaponname, var_0, var_8, 30, self.owner, 1 );
    var_9.owner = self.owner;
    var_9.recall = 1;
    var_9 missile_settargetent( self.owner );
    var_9 thread exo_knife_recall_stuck_watch();
    var_9 thread _id_349D();
    _id_3499();
}

_id_3498( var_0, var_1, var_2 )
{
    common_scripts\utility::waittill_any_ents( var_1, "disconnect", var_1, "death", var_2, "death", var_2, "missile_stuck" );
    missile_deleteattractor( var_0 );
}

_id_3499()
{
    self delete();
}
