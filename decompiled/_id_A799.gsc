// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4E31()
{
    precacherumble( "dna_carpet_bomb" );
    level._id_A3D3 = getentarray( "zombie_weapon", "targetname" );

    foreach ( var_1 in level._id_A3D3 )
    {
        var_1 hide();
        var_1 makeunusable();
    }
}

_id_76CF()
{
    level._id_A3D0 = 1;
    level._id_4985 = "vehicle_atlas_assault_drone";
    level._id_2BAF = common_scripts\utility::getstructarray( "dna_locs", "targetname" );
    level._id_4EBC = getentarray( "dna_drone_interior", "targetname" );
    level._id_2BB1 = [];
    level._id_2F25 = 0;
    thread zombiespatchclip();

    foreach ( var_1 in level.players )
    {
        level thread _id_A3C8( var_1 );
        var_1 setdemigod( 1 );
    }

    wait 3;
    _id_2B16();

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.changingweapon ) && maps\mp\_utility::iskillstreakweapon( var_1.changingweapon ) )
        {
            if ( var_1.changingweapon == "killstreak_predator_missile_mp" || var_1.changingweapon == "orbital_laser_fov_mp" )
            {
                while ( !var_1 maps\mp\_utility::isusingremote() )
                    waitframe();
            }
            else
                var_1 switchtoweapon( var_1._id_4964[var_1 getclientomnvar( "ui_horde_player_class" )]["primary"] );
        }

        if ( isdefined( var_1.enteringgoliath ) )
        {
            while ( isdefined( var_1.enteringgoliath ) )
                wait 0.05;
        }

        if ( isdefined( var_1.iscarrying ) && var_1.iscarrying )
            var_1 notify( "force_cancel_placement" );
    }

    foreach ( var_6 in level._id_49C1 )
    {
        if ( isdefined( var_6 ) )
            var_6 notify( "death" );
    }

    foreach ( var_9 in level.carepackages )
        var_9 maps\mp\killstreaks\_airdrop::_id_2847();

    thread _id_A3CD();
    thread _id_A3CC();

    foreach ( var_1 in level.players )
        var_1 setclientomnvar( "ui_hide_hints_hud", 1 );

    level thread _id_A3CF();
    level thread _id_4978();
    _func_2A9( "coop_outro" );
    level thread _id_5E60();
}

_id_2B16()
{
    foreach ( var_1 in level.players )
    {
        for ( var_2 = 1; var_2 <= var_1._id_2518.size; var_2++ )
        {
            if ( var_1.pers["killstreaks"][var_2].available == 1 )
                var_1 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak( var_1._id_2518[var_2], var_1, var_1._id_55B1, var_2, 0 );
        }

        var_3 = 5;

        if ( level.console || var_1 common_scripts\utility::is_player_gamepad_enabled() )
            var_3 = 1;

        for ( var_2 = 0; var_2 < var_3; var_2++ )
        {
            var_1 maps\mp\_utility::_setactionslot( var_2 + 4, "" );
            var_1.actionslotenabled[var_2] = 0;
        }

        var_1 setclientomnvar( "ks_count1", 0 );
        var_1 setclientomnvar( "ks_count_updated", 1 );
    }
}

_id_5E60()
{
    level waittill( "game_ended" );
    _func_2AA( "coop_outro" );
}

_id_4978()
{
    level endon( "game_ended" );
    level thread _id_8D0E();

    foreach ( var_1 in level._id_4EBC )
        level thread _id_8D21( var_1 );

    wait 2;

    foreach ( var_4 in level.players )
        level thread _id_2F30( var_4 );

    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_sensorsareshowingmanticore", level.players, "horde" );
    wait 3;
    level waittill( "dna_explode" );

    for ( var_6 = 1; var_6 < level._id_2BB1.size + 1; var_6++ )
        level thread _id_8D03( level._id_2BB1[var_6] );

    wait 3;
    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_hitthedeck", level.players, "horde" );

    for ( var_6 = 1; var_6 < level._id_2BB1.size + 1; var_6++ )
        level thread _id_8EDC( level._id_2BB1[var_6] );

    wait 0.5;
    thread _id_2BB2();
    wait 1;
    thread _id_2BAC();

    foreach ( var_4 in level.players )
    {
        var_4 thread _id_2BAB();
        var_4 maps\mp\_utility::playerallowdodge( 1, "class" );
        var_4 maps\mp\_utility::playerallowhighjumpdrop( 1, "class" );
        var_4 maps\mp\_utility::playerallowhighjump( 1, "class" );
        var_4 maps\mp\_utility::playerallowpowerslide( 1, "class" );
        var_4 maps\mp\_utility::playerallowdodge( 0, "zombie" );
        var_4 maps\mp\_utility::playerallowhighjumpdrop( 0, "zombie" );
        var_4 maps\mp\_utility::playerallowhighjump( 0, "zombie" );
        var_4 maps\mp\_utility::playerallowpowerslide( 0, "zombie" );
        var_4._id_A2CE = 1;
        var_4 maps\mp\_utility::_clearperks();
        var_4._id_4948 = [];
        var_4._id_55C6 = [];
        var_4 maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );
        var_4 maps\mp\_utility::giveperk( "specialty_horde_dualprimary", 1, 1 );
    }

    level.players[0] thread _id_6899();
    level waittill( "blackout_done" );

    foreach ( var_10 in level._id_A3D3 )
    {
        var_10 show();
        var_10 makeusable();
        var_10 _meth_83FA( 4, 1 );
        var_10 thread _id_A3D2();
    }

    _func_222( 60 );

    foreach ( var_13 in level._id_497B )
        var_13 hide();

    foreach ( var_4 in level.players )
    {
        var_4 takeallweapons();
        var_4 setclientomnvar( "ui_horde_zombie_hud", 1 );
        var_4 setclientomnvar( "ui_hide_hints_hud", 0 );

        if ( isdefined( var_4.hasselfrevive ) )
            var_4.hasselfrevive = 0;

        var_4 setdemigod( 0 );
        var_4.maxhealth = var_4._id_1E3A["support"]["classhealth"];
        var_4.health = var_4.maxhealth;
        var_4.movespeedscaler = 1.1;
    }

    level notify( "zombie_go_night" );
    wait 2.2;
    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_teamreportstatus", level.players, "horde" );
    wait 6;
    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_alliedforcesthisisgideon", level.players, "horde" );
    wait 5;
    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_isanyoneoutthere", level.players, "horde" );
    wait 8;
    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_welcomebackteam", level.players, "horde" );
    thread _id_4136();
    thread _id_A793::_id_A3C3();
    thread _id_A3D1();
    thread _id_A3C6();
}

_id_8D21( var_0 )
{
    level endon( "game_ended" );
    wait 5;
    playfxontag( level._effect["bagh_dna_bomb_drone_loop"], var_0, "tag_origin" );
    wait 0.25;
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_0 moveto( var_1.origin, 1, 0.2, 0.5 );
    var_0 thread _id_2BB0( var_1 );
    var_2 = int( var_0.script_parameters );
    level._id_2BB1[var_2][level._id_2BB1[var_2].size] = var_0;
}

_id_8D0E()
{
    level endon( "game_ended" );

    foreach ( var_1 in level._id_2BAF )
    {
        var_2 = spawn( "script_model", var_1.origin + ( 0.0, 0.0, 6000.0 ) );
        var_2 setmodel( "sentinel_survey_drone_sphere_ai_swarm" );
        var_2._id_2EE5 = randomfloatrange( 7.5, 9.0 );
        var_2 moveto( var_1.origin, var_2._id_2EE5, 0.5, 0.2 );
        var_2 thread _id_2BB0( var_1 );
        var_3 = int( var_1.script_parameters );
        var_4 = bullettrace( var_1.origin, var_1.origin + ( 0.0, 0.0, 6001.0 ), 0, undefined, 0, 0, 0, 0, 1 );

        if ( isdefined( var_4["glass"] ) )
        {
            var_5 = _id_19C8( var_2, var_4["position"] );
            thread _id_2BAD( var_5, var_4["glass"] );
        }

        if ( !isdefined( level._id_2BB1[var_3] ) )
            level._id_2BB1[var_3] = [];

        level._id_2BB1[var_3][level._id_2BB1[var_3].size] = var_2;
    }
}

_id_8D03( var_0 )
{
    level endon( "game_ended" );

    foreach ( var_2 in var_0 )
        playfxontag( level._effect["bagh_dna_bomb_drone_loop"], var_2, "tag_origin" );
}

_id_8EDC( var_0 )
{
    level endon( "game_ended" );

    foreach ( var_2 in var_0 )
        killfxontag( level._effect["bagh_dna_bomb_drone_loop"], var_2, "tag_origin" );
}

_id_4136()
{
    level endon( "game_ended" );
    level._id_35A6 = getent( "zombie_extraction", "targetname" );
    var_0 = getent( "zombie_outro", "targetname" );
    level waittill( "start_extraction" );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_hide_hud", 0 );

    maps\mp\gametypes\horde::_id_7F86( "escape_time", 40 );

    if ( getdvarint( "horde_nozombieoutro" ) < 1 )
        var_0 thread _id_49CC();

    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_iaminboundwithanextraction", level.players, "horde" );
    thread _id_A793::_id_35A5();
    var_4 = maps\mp\gametypes\_gameobjects::getnextobjid();
    level._id_35A6.objid = var_4;
    objective_add( var_4, "active", level._id_35A6.origin );

    foreach ( var_2 in level.players )
        level._id_35A6.headicon = level._id_35A6 maps\mp\_entityheadicons::setheadicon( var_2, "waypoint_extraction", ( 0.0, 0.0, 0.0 ), 4, 4, undefined, undefined, 0, 1, undefined, 0 );

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 40 );
    maps\mp\gametypes\horde::_id_1EEF();

    if ( !isdefined( level.zombiescompleted ) )
        _id_A795::_id_498A( "extraction_failed" );
}

_id_A3D1()
{
    level endon( "game_ended" );

    while ( level._id_31D4 > 85 )
        wait 0.25;

    wait(randomfloatrange( 1, 3 ));
    maps\mp\_utility::leaderdialogonplayers( "coop_gdn_exosarebackupuseboostjump", level.players, "horde" );

    foreach ( var_1 in level.players )
    {
        var_1 maps\mp\_utility::playerallowdodge( 1, "zombie" );
        var_1 maps\mp\_utility::playerallowhighjumpdrop( 1, "zombie" );
        var_1 maps\mp\_utility::playerallowhighjump( 1, "zombie" );
        var_1 maps\mp\_utility::playerallowpowerslide( 1, "zombie" );
    }

    while ( level._id_31D4 > 60 )
        wait 0.25;

    level notify( "start_extraction" );
}

_id_A3C6()
{
    level endon( "game_ended" );
    level endon( "start_extraction" );

    for (;;)
    {
        wait 20;
        level notify( "go_zombie" );
        level._id_5A1E = min( 20, level._id_5A1E + 2 );
    }
}

_id_2BB0( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );

    while ( distance( self.origin, var_0.origin ) > 16 )
        wait 0.1;

    level._id_2F25++;

    if ( level._id_2F25 == level._id_2BAF.size )
        level notify( "dna_explode" );

    var_1 = self.origin;

    for (;;)
    {
        var_2 = ( 0, 0, randomintrange( 16, 24 ) );
        var_3 = ( 0, 0, randomintrange( -24, -16 ) );
        self moveto( var_1 + var_2, 1, 0.3, 0.3 );
        wait 1;
        self moveto( var_1 + var_3, 1, 0.3, 0.3 );
        wait 1;
    }
}

_id_2BB2()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        var_1 playsound( "bagh_dna_bombs_main" );
        var_1 playsound( "dna_bomb_gas_start" );
        var_1 playrumbleonentity( "dna_carpet_bomb" );
        var_1 setclienttriggervisionset( "mp_prison_z_zombiefog", 1.0 );
        level thread _id_2BB3( var_1 );
    }

    for ( var_3 = 1; var_3 < level._id_2BB1.size + 1; var_3++ )
        level thread _id_2BAE( level._id_2BB1[var_3] );
}

_id_2BAE( var_0 )
{
    level endon( "game_ended" );

    foreach ( var_2 in var_0 )
    {
        wait(randomfloatrange( 0.1, 0.2 ));
        playfx( level._effect["bagh_dna_bomb_explode"], var_2.origin );
        var_2 delete();
    }
}

_id_2BB3( var_0 )
{
    earthquake( 1, 1, var_0.origin, 9999 );
    wait 1.2;
    earthquake( 0.7, 1, var_0.origin, 9999 );
    wait 1.4;
    earthquake( 0.5, 1, var_0.origin, 9999 );
}

_id_2BAB()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "leftTrigger" );

    if ( !isdefined( self._id_148D ) )
    {
        self._id_148D = newclienthudelem( self );
        self._id_148D.x = 0;
        self._id_148D.y = 0;
        self._id_148D setshader( "black", 640, 480 );
        self._id_148D.alignx = "left";
        self._id_148D.aligny = "top";
        self._id_148D.horzalign = "fullscreen";
        self._id_148D.vertalign = "fullscreen";
        self._id_148D.alpha = 0;
    }

    wait 1;
    self freezecontrols( 1 );
    self disableweapons();
    self disableoffhandweapons();
    self _meth_84BF();
    self setstance( "prone" );
    self _meth_8118( 0 );
    self _meth_8119( 0 );
    self allowmelee( 0 );
    self _meth_8304( 0 );
    thread _id_6898();
    self._id_148D _id_498D( 2, 1 );
    level notify( "blackout_done" );
    wait 16;
    self._id_148D thread _id_498E( 5, 0 );
    self freezecontrols( 0 );
    wait 4;
    self allowmelee( 1 );
    self _meth_8118( 1 );
    self _meth_8119( 1 );
    self setstance( "stand" );
    wait 0.65;
    self _meth_8304( 1 );
    self enableweapons();
    self giveweapon( "iw5_titan45_mp_xmags" );
    self switchtoweaponimmediate( "iw5_titan45_mp_xmags" );
    thread _id_A3C5();
    wait 0.5;
    level notify( "end_blackout_sounds" );
}

_id_3716( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    var_0._id_148D _id_498D( 1, 1 );
    var_0 freezecontrols( 1 );
    var_0 setdemigod( 1 );
    var_0 setclientomnvar( "ui_hide_hud", 1 );
}

_id_6899()
{
    maps\mp\_audio::_id_873B( "zombie_fadeout_heartbeat", self.origin, "end_blackout_sounds", 2 );
}

_id_6898()
{
    level endon( "end_blackout_sounds" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 = _id_1CDE();
    var_1 = undefined;

    if ( maps\mp\killstreaks\_juggernaut::get_is_in_mech() )
        return;

    switch ( var_0 )
    {
        case 0:
            var_1 = "deaths_door_mp_male";
            break;
        case 1:
            var_1 = "deaths_door_mp_female";
            break;
        default:
            break;
    }

    for (;;)
    {
        self playsoundtoplayer( var_1, self );
        wait 1.6;
    }
}

_id_49CC()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( _id_A798::_id_5164( var_0 ) && isplayer( var_0 ) )
        {
            foreach ( var_2 in level.players )
                level thread _id_3716( var_2 );

            maps\mp\_utility::_objective_delete( level._id_35A6.objid );
            level.zombiescompleted = 1;
            setdvar( "cg_drawCrosshair", 0 );
            level notify( "zombies_ended" );
            wait 1;

            foreach ( var_2 in level.players )
                level._id_35A6 maps\mp\_entityheadicons::setheadicon( "none", "", ( 0.0, 0.0, 0.0 ) );

            if ( isdefined( level._id_35A6.headicon ) )
                level._id_35A6.headicon destroy();

            foreach ( var_2 in level.players )
                var_2.ignoreme = 1;

            wait 1;
            thread _id_65C9();
            _func_2A8( "coop_outro", 1 );

            foreach ( var_2 in level.players )
                var_2 _meth_80F9( "COOP_UNDEAD_SURVIVOR" );

            break;
        }

        wait 0.05;
    }

    wait 55;
    _func_2AA( "coop_outro" );

    foreach ( var_2 in level.players )
    {
        if ( !var_2 _meth_8525( "requirement_beatenZombies" ) )
        {
            var_2 _meth_8526( "requirement_beatenZombies", 1 );
            var_2 setclientomnvar( "ui_hide_hud", 0 );
            var_2 setclientomnvar( "ui_horde_zombie_hud", 1 );
            var_2 setclientomnvar( "ui_horde_loot_unlocked", 1 );
        }
    }

    wait 3;
    _id_A795::_id_498A( "zombies_completed" );
}

_id_498D( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}

_id_498E( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}

_id_A3C5()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 5;
        self givemaxammo( "iw5_titan45_mp_xmags", 1 );
    }
}

_id_49E6()
{
    thread _id_49E2();
    thread _id_49E3();
    thread _id_49E4();
}

_id_49E2()
{
    self endon( "death" );
    level endon( "game_ended" );
    level endon( "zombies_ended" );

    for (;;)
    {
        while ( !isdefined( self._id_0143 ) )
            wait 0.25;

        while ( isdefined( self._id_0143 ) && distance( self.origin, self._id_0143.origin ) > 200 )
        {
            wait(randomfloatrange( 4, 8 ));
            self playsound( "zombie_screech" );
        }

        wait 0.05;
    }
}

_id_49E4()
{
    level endon( "game_ended" );
    level endon( "zombies_ended" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage" );

        if ( !isdefined( self._id_6DB0 ) )
            childthread _id_49E5( 1.5 );

        wait 0.05;
    }
}

_id_49E3()
{
    level endon( "game_ended" );
    level endon( "zombies_ended" );
    self waittill( "death" );
    waittillframeend;
    self playsound( "zombie_death" );
}

_id_49E5( var_0 )
{
    self playsound( "zombie_pain" );
    self._id_6DB0 = 1;
    wait(var_0);
    self._id_6DB0 = undefined;
}

_id_A3D2()
{
    level endon( "game_ended" );
    self waittill( "trigger", var_0 );

    if ( isdefined( self.script_parameters ) )
    {
        var_1 = weaponclipsize( self.script_parameters );
        var_0 setweaponammostock( self.script_parameters, 500 );
        var_0 setweaponammoclip( self.script_parameters, var_1 );
    }
}

_id_A3CD()
{
    level endon( "game_ended" );

    foreach ( var_1 in level._id_4958 )
    {
        foreach ( var_3 in level.players )
        {
            var_1 maps\mp\_entityheadicons::setheadicon( "none", "", ( 0.0, 0.0, 0.0 ) );
            var_3 setclientomnvar( "ui_horde_show_armory", 0 );
            var_3 enableusability();
        }

        if ( isdefined( var_1.headicon ) )
            var_1.headicon destroy();

        maps\mp\_utility::_objective_delete( var_1._id_62FB );
        var_1 _meth_83FB();

        foreach ( var_6 in var_1._id_5EB7 )
            var_6 _meth_83FB();

        var_1 makeunusable();
    }
}

_id_A3CC()
{
    level endon( "game_ended" );
    var_0 = "MOD_EXPLOSIVE";
    var_1 = "killstreak_emp_mp";
    var_2 = 5000;
    var_3 = level.players[0];

    foreach ( var_5 in level._id_654F )
    {
        var_5 notify( "death", var_3, var_0, var_1 );
        wait 0.05;
    }

    var_7 = common_scripts\utility::array_combine( level.ugvs, level.uavmodels["allies"] );
    var_7 = common_scripts\utility::array_combine( var_7, level.turrets );
    var_7 = common_scripts\utility::array_combine( var_7, level.helis );
    var_7 = common_scripts\utility::array_combine( var_7, level.planes );
    var_7 = common_scripts\utility::array_combine( var_7, level.littlebirds );

    if ( isdefined( level.orbitalsupport_planemodel ) )
        var_7[var_7.size] = level.orbitalsupport_planemodel;

    foreach ( var_9 in var_7 )
    {
        var_2 = var_9.maxhealth + 1;
        var_9 dodamage( var_2, var_9.origin, var_3, var_3, var_0, var_1 );
        wait 0.05;
    }

    foreach ( var_12 in level.players )
    {
        if ( isdefined( var_12.missileweapon ) && isdefined( var_12.rocket ) )
        {
            var_12.rocket setdamagecallbackon( 0 );
            var_12.missileweapon notify( "ms_early_exit" );
            var_12.rocket maps\mp\killstreaks\_missile_strike::_id_5CC5( var_3, var_1, var_0, var_2 );
            var_12.missileweapon = undefined;
            var_12.rocket = undefined;
        }
    }

    foreach ( var_12 in level.players )
    {
        if ( isdefined( var_12.isjuggernaut ) && var_12.isjuggernaut )
        {
            var_12 maps\mp\_snd_common_mp::snd_message( "goliath_self_destruct" );
            playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), var_12.origin, anglestoup( var_12.angles ) );
            wait 0.05;
            var_12.hideondeath = 1;
            var_12._id_52A5 = 1;
            var_12 thread [[ level.hordehandlejuggdeath ]]();
        }
    }
}

_id_2F30( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 playsound( "bagh_dna_drone_swarm_layer" );
    wait 5.66;
    var_0 playsound( "bagh_dna_drone_flyby_01" );
}

_id_A3C8( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 loadweapons( [ "iw5_em1_mp", "iw5_sn6_mp", "iw5_maul_mp", "iw5_lsat_mp" ] );
    wait 3;
    var_0 loadweapons( [ "iw5_hbra3_mp", "iw5_asm1_mp", "iw5_uts19_mp" ] );
}

_id_A3CE( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = 0.2;

    while ( var_1 < var_0._id_1E3A["light"]["speed"] )
    {
        var_0.movespeedscaler = var_1;
        var_1 += 0.05;
        wait 1;
    }
}

_id_49C7( var_0 )
{
    var_1 = [ "zombies_body_afr_a", "zombies_body_afr_b", "zombies_body_afr_c", "zombies_body_afr_d" ];
    var_2 = [ "zombies_head_afr_a", "zombies_head_afr_b", "zombies_head_afr_c", "zombies_head_afr_c" ];
    var_3 = [ "zombies_body_cau_a", "zombies_body_cau_b", "zombies_body_cau_c", "zombies_body_cau_d" ];
    var_4 = [ "zombies_head_cau_a", "zombies_head_cau_b", "zombies_head_cau_c", "zombies_head_shg_b" ];
    var_5 = [ "zombies_body_civ_cau_a", "zombies_body_civ_cau_b", "zombies_body_civ_cau_c", "zombies_body_civ_cau_d" ];
    var_6 = [ "zombies_body_civ_afr_a", "zombies_body_civ_afr_b", "zombies_body_civ_afr_c", "zombies_body_civ_afr_d" ];
    var_7[0] = var_1;
    var_7[1] = var_3;
    var_7[2] = var_6;
    var_7[3] = var_5;
    var_8[0] = var_2;
    var_8[1] = var_4;
    var_8[2] = var_2;
    var_8[3] = var_4;
    var_9 = randomintrange( 0, 4 );
    var_10 = randomintrange( 0, 4 );
    var_11 = randomintrange( 0, 4 );
    var_12 = var_7[var_9][var_10];
    var_13 = var_8[var_9][var_11];
    self detachall();
    self setmodel( var_12 );
    self.headmodel = var_13;
    self attach( self.headmodel, "", 1 );
}

_id_A3CF()
{
    level endon( "game_ended" );
    level waittill( "blackout_done" );
    maps\mp\_audio::_id_873B( "det_mus_horror_lp_01", level.players[0].origin, "beginZombieSpawn", 3 );
    level waittill( "beginZombieSpawn" );
    maps\mp\_audio::_id_873B( "det_mus_horror_lp_02", level.players[0].origin, "stopZombieMusic", 3 );
    wait 60;
    level notify( "stopZombieMusic" );
    level waittill( "start_extraction" );
    maps\mp\_audio::_id_873B( "det_mus_high_tension1", level.players[0].origin, "zombies_ended", 1 );
}

_id_65C9()
{
    foreach ( var_1 in level.agentarray )
        maps\mp\agents\_agent_utility::_id_5346( var_1 );
}

_id_2BAD( var_0, var_1 )
{
    wait(var_0);
    destroyglass( var_1 );
}

_id_19C8( var_0, var_1 )
{
    var_2 = 6000;
    var_3 = distance( var_0.origin, var_1 );
    var_4 = var_0._id_2EE5;
    var_5 = var_3 * var_4 / var_2;
    return var_5;
}

_id_1CDE()
{
    if ( isdefined( self.costume ) )
        return self.costume[0];
    else
        return 0;
}

_id_2BAC()
{
    var_0 = getentarray( "org_zombie_player_start_point", "targetname" );
    common_scripts\utility::array_randomize( var_0 );
    level waittill( "blackout_done" );

    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
    {
        level.players[var_1] setorigin( var_0[var_1].origin );
        wait 0.5;
        level.players[var_1] setangles( var_0[var_1].angles );
    }
}

zombiespatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1407.27, 2567.11, 704.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1407.27, 2567.11, 960.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1407.27, 2567.11, 1216.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1185.79, 2695.5, 704.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1185.79, 2695.5, 960.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1185.79, 2695.5, 1216.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -964.314, 2823.89, 704.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -964.314, 2823.89, 960.0 ), ( 0.0, 300.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -964.314, 2823.89, 1216.0 ), ( 0.0, 300.1, 0.0 ) );
}
