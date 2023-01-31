// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

humvee_turret_init( var_0, var_1 )
{
    self endon( "killanimscript" );
    animscripts\utility::initialize( var_1 );
    self.no_ai = 1;
    self.nodrop = 1;
    self.a.movement = "stop";
    self.a.special = var_1;
    self.a.usingturret = var_0;
    self.ignoreme = 1;

    if ( isdefined( self.minigun_ignoreme ) )
        self.ignoreme = self.minigun_ignoreme;

    self.iscustomanimating = 0;
    self _meth_8193( self.primaryturretanim );
    self _meth_8145( self.primaryturretanim, 1, 0.2, 1 );

    if ( isdefined( self.weapon ) )
        animscripts\shared::placeweaponon( self.weapon, "none" );

    self.getoffvehiclefunc = ::turret_cleanup_on_unload;
    self notify( "guy_man_turret_stop" );
    var_0 notify( "stop_burst_fire_unmanned" );
    var_0.turretstate = "start";
    var_0.aiowner = self;
    var_0.firetime = 0;
    var_0 _meth_8065( "sentry" );
    var_0 _meth_8103( self );
    var_0 _meth_815A( 0 );
    var_0 _meth_802F( 0 );
    gunner_pain_init();
    level thread handle_gunner_pain( self, var_0 );
    level thread handle_gunner_death( self, var_0 );
    var_0 thread turret_track_rotatedirection( self );
    var_0.dofiring = 0;
    thread firedirector( var_0 );
    wait 0.05;

    if ( isalive( self ) )
        thread gunner_turning_anims( var_0 );
}

gunner_pain_init()
{
    self.allowpain = 0;
    maps\_utility::setflashbangimmunity( 1 );
    self.og_health = self.health;
    self.health = 200;
}

gunner_pain_reset()
{
    self.allowpain = 1;
    maps\_utility::setflashbangimmunity( 0 );
    self.health = self.og_health;
}

handle_gunner_pain( var_0, var_1 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_0 endon( "dismount" );
    var_0 endon( "jumping_out" );

    for (;;)
    {
        var_2 = "flashbang";
        var_3 = var_0 common_scripts\utility::waittill_any_return( "damage", var_2 );
        var_4 = common_scripts\utility::random( var_0.turretpainanims );

        if ( var_3 == var_2 )
        {
            var_4 = var_0.turretflashbangedanim;
            var_0 animscripts\face::saygenericdialogue( "flashbang" );
        }

        var_0 docustomanim( var_1, var_4, 0 );
        var_1 notify( "pain_done" );
    }
}

turret_recenter()
{
    turret_aim_straight();
    self waittill( "pain_done" );
    turret_aim_restore();
}

handle_gunner_death( var_0, var_1 )
{
    var_0 endon( "dismount" );
    var_1 endon( "turret_cleanup" );
    var_0.deathanim = var_0.turretdeathanim;
    var_0.nomeleedeathorient = 1;
    var_0.noragdoll = 1;
    var_0 waittill( "death" );
    level thread turret_cleanup( var_0, var_1 );
}

turret_cleanup_on_unload()
{
    var_0 = self.ridingvehicle.mgturret[0];

    if ( isalive( self ) )
    {
        self.no_ai = undefined;
        self.nodrop = undefined;
        self.ignoreme = 0;
        self.a.special = "none";
        self.a.usingturret = undefined;
        self.deathanim = undefined;
        gunner_pain_reset();
        self.iscustomanimating = undefined;
        self.turretspecialanims = undefined;
        self.turretpainanims = undefined;
        self.getoffvehiclefunc = undefined;
        self _meth_818B();

        if ( isdefined( self.weapon ) )
            animscripts\shared::placeweaponon( self.weapon, "right" );
    }

    level thread turret_cleanup( self, var_0 );
}

turret_cleanup( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        return;

    var_1 notify( "kill_fireController" );
    var_1 notify( "turret_cleanup" );
    var_1 _meth_8065( "manual" );
    var_1 _meth_8108();
    var_1 _meth_815A( var_1.default_drop_pitch );

    if ( isdefined( var_0 ) )
    {
        var_0 _meth_8142( var_0.additiveusegunroot, 0 );
        var_0 _meth_8142( var_0.additiverotateroot, 0 );
        var_0 _meth_8142( var_0.turretspecialanimsroot, 0 );
    }

    var_1.fireinterval = undefined;
    var_1.closeenoughaimdegrees = undefined;
    var_1.firecontrollerfunc = undefined;
    var_1.turretstate = "free";
    var_1.aiowner = undefined;
    var_1.firetime = undefined;

    if ( isdefined( var_1.specialcleanupfunc ) )
        level [[ var_1.specialcleanupfunc ]]( var_0, var_1 );
}

turret_track_rotatedirection( var_0 )
{
    self endon( "turret_cleanup" );
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "detach" );
    var_1 = "tag_aim";
    var_2 = self gettagangles( var_1 );
    turret_update_rotatedirection( "none" );

    for (;;)
    {
        var_3 = self gettagangles( var_1 );
        var_4 = anglestoright( var_2 );
        var_5 = anglestoforward( var_3 );
        var_6 = vectordot( var_4, var_5 );

        if ( var_6 == 0 )
            turret_update_rotatedirection( "none" );
        else if ( var_6 > 0 )
            turret_update_rotatedirection( "right" );
        else
            turret_update_rotatedirection( "left" );

        var_2 = self gettagangles( var_1 );
        wait 0.05;
    }
}

turret_update_rotatedirection( var_0 )
{
    if ( !isdefined( self.rotatedirection ) || self.rotatedirection != var_0 )
        self.rotatedirection = var_0;
}

gunner_turning_anims( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    self endon( "dismount" );
    var_0 endon( "turret_cleanup" );
    var_1 = 0.3;
    var_2 = 0.3;

    for (;;)
    {
        var_0 waittill( "new_fireTarget" );
        wait 0.05;

        if ( !isdefined( var_0.firetarget ) || self.iscustomanimating )
            continue;

        var_3 = undefined;

        if ( !var_0 turret_aiming_near_target( var_0.firetarget, var_0.closeenoughaimdegrees ) )
        {
            if ( var_0.rotatedirection == "right" )
                var_3 = self.additiveturretrotateright;
            else if ( var_0.rotatedirection == "left" )
                var_3 = self.additiveturretrotateleft;

            if ( isdefined( var_3 ) )
            {
                self _meth_814C( self.additiverotateroot, 1, var_1, 1 );
                self _meth_8144( var_3, 1, 0, 1 );

                while ( isdefined( var_0.firetarget ) && !var_0 turret_aiming_near_target( var_0.firetarget, var_0.closeenoughaimdegrees ) )
                {
                    if ( self.iscustomanimating )
                        break;

                    wait 0.05;
                }

                self _meth_8142( self.additiverotateroot, var_2 );
            }
        }
    }
}

vehicle_passenger_2_turret( var_0, var_1, var_2, var_3 )
{
    var_0.usedpositions[self.vehicle_position] = 0;
    maps\_vehicle_aianim::guy_cleanup_vehiclevars();
    guy_gets_on_turret( var_0, var_1, var_2, var_3 );
}

guy_goes_directly_to_turret( var_0, var_1, var_2, var_3 )
{
    guy_gets_on_turret( var_0, var_1, var_2, var_3 );
}

#using_animtree("generic_human");

guy_gets_on_turret( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_2 endon( "death" );
    self _meth_8141();
    self notify( "newanim" );
    self.drivingvehicle = undefined;
    self.no_ai = 1;
    var_3 = %humvee_passenger_2_turret;

    if ( !isdefined( var_3 ) )
        var_3 = self.passenger_2_turret_anim;

    var_4 = maps\_vehicle_aianim::anim_pos( var_0, var_1 );
    var_5 = var_0 gettagorigin( var_4.sittag );
    var_6 = var_0 gettagangles( var_4.sittag );
    var_2 _meth_815A( 0 );
    var_2 thread turret_animate( var_2.passenger2turret_anime );
    self _meth_813E( "passenger2turret", var_5, var_6, var_3 );
    wait(getanimlength( var_3 ));
    self _meth_8141();
    var_2 turret_aim_restore();
    self _meth_818A( var_2 );
}

turret_animate( var_0 )
{
    if ( isdefined( self.idleanim ) )
    {
        self _meth_8142( self.idleanim, 0 );
        self.idleanim = undefined;
    }

    self _meth_810D( "minigun_turret", var_0, 1, 0, 1 );
    self waittillmatch( "minigun_turret", "end" );
    self _meth_8142( var_0, 0 );
}

turret_animfirstframe( var_0 )
{
    self _meth_8145( var_0, 1, 0, 0 );
    self.idleanim = var_0;
}

firedirector( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    self endon( "dismount" );
    var_0 endon( "kill_fireController" );
    var_0 thread turret_target_updater( self );
    wait 0.05;
    self thread [[ var_0.firecontrollerfunc ]]( var_0 );
    var_1 = undefined;

    for (;;)
    {
        var_1 = var_0.firetarget;

        while ( var_0 target_confirm( var_1 ) )
        {
            if ( var_0 turret_aiming_near_target( var_1, var_0.closeenoughaimdegrees ) )
                break;

            wait 0.05;
        }

        if ( var_0 target_confirm( var_1 ) && !self.ignoreall )
            var_0.dofiring = 1;

        while ( var_0 target_confirm( var_1 ) && !self.ignoreall && !self.iscustomanimating )
            wait 0.05;

        if ( var_0.dofiring || self.ignoreall )
            var_0.dofiring = 0;

        wait 0.05;
    }
}

target_confirm( var_0 )
{
    if ( isdefined( self.dontshoot ) )
        return 0;

    if ( !isdefined( self.firetarget ) )
        return 0;

    if ( !turret_target_validate( var_0 ) )
        return 0;

    if ( var_0 != self.firetarget )
        return 0;

    return 1;
}

turret_target_updater( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    var_0 endon( "dismount" );
    self endon( "kill_fireController" );
    self.firetarget = undefined;
    var_1 = undefined;
    var_2 = undefined;

    for (;;)
    {
        var_1 = self _meth_8109( 0 );
        var_3 = 0;

        if ( turret_target_validate( var_1 ) || !isdefined( var_1 ) )
        {
            if ( !isdefined( var_1 ) && isdefined( var_2 ) )
                var_3 = 1;
            else if ( isdefined( var_1 ) && !isdefined( var_2 ) )
                var_3 = 1;
            else if ( isdefined( var_1 ) && var_1 != var_2 )
                var_3 = 1;

            if ( var_3 )
            {
                self.firetarget = var_1;
                var_2 = var_1;
                self notify( "new_fireTarget" );
            }
        }

        wait 0.05;
    }
}

turret_target_validate( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isdefined( var_0.ignoreme ) && var_0.ignoreme )
        return 0;

    if ( issubstr( var_0.code_classname, "actor" ) && !isalive( var_0 ) )
        return 0;

    return 1;
}

set_manual_target( var_0, var_1, var_2, var_3 )
{
    self endon( "turret_cleanup" );
    var_4 = self _meth_8066();

    if ( var_4 != "manual" )
        self _meth_8065( "manual" );

    if ( !isdefined( var_1 ) && !isdefined( var_2 ) )
    {
        var_1 = 1.5;
        var_2 = 3;
    }

    custom_anim_wait();
    self _meth_8106( var_0 );
    self waittill( "turret_on_target" );

    if ( isdefined( var_3 ) )
        self waittill( var_3 );
    else if ( isdefined( var_2 ) )
        wait(randomfloatrange( var_1, var_2 ));
    else
        wait(var_1);

    custom_anim_wait();
    self _meth_8108( var_0 );

    if ( isdefined( var_4 ) )
        self _meth_8065( var_4 );
}

doshoot( var_0 )
{
    self notify( "doshoot_starting" );
    self _meth_814C( self.additiveusegunroot, 1, 0.1 );
    self _meth_8144( self.additiveturretfire, 1, 0.1 );
    var_0.turretstate = "fire";
    var_0 thread fire( self );
}

fire( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    var_0 endon( "dismount" );
    self endon( "kill_fireController" );
    self endon( "stopfiring" );
    self endon( "custom_anim" );

    for (;;)
    {
        self _meth_80EA();
        wait(self.fireinterval);
    }
}

doaim( var_0 )
{
    var_0.turretstate = "aim";
    var_0 notify( "stopfiring" );
    thread doaim_idle_think( var_0 );
}

doaim_idle_think( var_0 )
{
    self notify( "doaim_idle_think" );
    self endon( "doaim_idle_think" );
    self endon( "custom_anim" );
    self endon( "doshoot_starting" );
    self endon( "death" );
    var_0 endon( "death" );
    var_1 = var_0.ownervehicle;
    var_2 = -1;

    for (;;)
    {
        if ( var_1 _meth_8286() < 1 && var_2 )
        {
            self _meth_814C( self.additiveusegunroot, 1, 0.1 );
            self _meth_8144( self.additiveturretidle, 1, 0.1 );
            var_2 = 0;
        }
        else if ( var_1 _meth_8286() >= 1 && !var_2 )
        {
            self _meth_814C( self.additiveusegunroot, 1, 0.1 );
            self _meth_8144( self.additiveturretdriveidle, 1, 0.1 );
            var_2 = 1;
        }

        wait 0.05;
    }
}

turret_gunner_custom_anim( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 endon( "death" );
    self endon( "dismount" );
    self endon( "jumping_out" );
    var_3 = self.turretspecialanims[var_1];
    custom_anim_wait();
    var_4 = var_0 reload_disable_safe();
    docustomanim( var_0, var_3, var_2 );

    if ( var_4 )
        var_0 reload_enable();
}

reload_disable_safe()
{
    var_0 = 0;

    if ( !isdefined( self.disablereload ) || !self.disablereload )
    {
        var_0 = 1;
        self.disablereload = 1;
    }

    return var_0;
}

reload_enable()
{
    self.disablereload = 0;
}

doreload( var_0 )
{
    if ( isdefined( var_0.disablereload ) )
        return;

    self endon( "death" );
    var_0 endon( "death" );
    self endon( "dismount" );
    self endon( "jumping_out" );

    if ( animscripts\battlechatter::bcsenabled() )
    {
        if ( anim.chatinitialized )
            thread maps\_utility::custom_battlechatter( "inform_reloading" );
    }
    else if ( isdefined( self.team ) )
        maps\_dds::dds_notify( "act_reload", self.team == "allies" );

    docustomanim( var_0, self.turretreloadanim, 1 );
}

docustomanim( var_0, var_1, var_2 )
{
    self notify( "do_custom_anim" );
    self endon( "do_custom_anim" );
    self.iscustomanimating = 1;
    self.customanim = var_1;
    var_0.turretstate = "customanim";
    var_0 _meth_815C();

    if ( var_0 _meth_80E7() > 0 )
        var_0 _meth_80E6();

    var_0 notify( "kill_fireController" );
    self notify( "custom_anim" );

    if ( isdefined( var_2 ) && var_2 )
        var_0 turret_aim_straight();

    self _meth_8146( self.turretspecialanimsroot, 1, 0.2 );
    self _meth_810D( "special_anim", var_1, 1, 0, 1 );

    for (;;)
    {
        self waittill( "special_anim", var_3 );

        if ( var_3 == "end" )
            break;
    }

    self _meth_8142( self.turretspecialanimsroot, 0.2 );
    self _meth_814C( self.primaryturretanim, 1 );
    self _meth_814C( self.additiveusegunroot, 1 );

    if ( isdefined( var_2 ) && var_2 )
        var_0 turret_aim_restore();

    self.customanim = undefined;
    self.iscustomanimating = 0;
    var_0 _meth_8179();
    thread firedirector( var_0 );
}

custom_anim_wait()
{
    self endon( "death" );

    if ( !isdefined( self.iscustomanimating ) )
        return;

    while ( self.iscustomanimating )
        wait 0.05;
}

turret_aim_straight( var_0 )
{
    if ( self _meth_8066() == "sentry" )
        return;

    if ( !isdefined( var_0 ) )
    {
        var_1 = self gettagangles( "tag_flash" );
        var_0 = ( 0, var_1[1], var_1[2] );
    }

    self.oldmode = self _meth_8066();
    self _meth_8065( "manual" );
    var_2 = anglestoforward( var_0 );
    var_3 = var_2 * 96;
    var_4 = self gettagorigin( "tag_aim" ) + var_3;
    self.temptarget = spawn( "script_origin", var_4 );
    self.temptarget.ignoreme = 1;
    self.temptarget _meth_804D( self.ownervehicle );
    self _meth_8108();
    self _meth_8106( self.temptarget );
    self waittill( "turret_on_target" );
}

turret_aim_restore()
{
    self _meth_8108();

    if ( isdefined( self.temptarget ) )
    {
        self.temptarget _meth_804F();
        self.temptarget delete();
    }

    if ( isdefined( self.oldmode ) )
    {
        self _meth_8065( self.oldmode );
        self.oldmode = undefined;
    }
}

turret_aiming_near_target( var_0, var_1 )
{
    var_2 = turret_get_angle_to_target( var_0 );

    if ( var_2 <= var_1 )
        return 1;

    return 0;
}

turret_get_angle_to_target( var_0 )
{
    var_1 = vectortoyaw( var_0.origin - self.origin );
    var_2 = self gettagangles( "tag_flash" )[1];
    var_3 = animscripts\utility::absangleclamp180( var_2 - var_1 );
    return var_3;
}

lerp_out_drop_pitch( var_0 )
{
    var_1 = maps\_utility::create_blend( ::blend_droppitch, 20, 0 );
    var_1.time = var_0;
}

blend_droppitch( var_0, var_1, var_2 )
{
    var_3 = var_1 * ( 1 - var_0 ) + var_2 * var_0;
    self _meth_815A( var_3 );
}
