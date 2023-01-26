// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_2F0A( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 50;

    var_1 = 75;
    var_2 = 23;
    var_3 = var_2 * 2;
    var_4 = self.origin + ( 0, 0, var_0 );
    var_5 = self getangles();
    var_6 = anglestoforward( common_scripts\utility::flat_angle( var_5 ) );
    var_7 = var_4 + var_6 * var_1;
    var_8 = var_7;
    var_9 = self.angles;
    var_10 = 1;
    var_11 = _id_40CE( var_8 + ( 0.0, 0.0, -30.0 ) );

    if ( isdefined( var_11 ) && var_11 > 0 )
    {
        var_8 += ( 0, 0, var_11 );
        var_4 += ( 0, 0, var_11 );
    }
    else if ( !isdefined( var_11 ) )
        var_10 = 0;

    if ( var_10 && !sighttracepassed( var_4, var_7, 1, self ) )
        var_10 = 0;

    if ( var_10 )
    {
        var_12 = bullettrace( var_4, var_7, 1, self, 1, 0, 1, 1, 1 );

        if ( var_12["fraction"] < 1 )
            var_10 = 0;
    }

    if ( var_10 )
    {
        var_13 = var_4 + ( 0, 0, var_3 * -0.5 );
        var_7 += ( 0, 0, var_3 * -0.5 );
        var_12 = self _meth_83E5( var_13, var_7, var_2, var_3, 0, 1 );

        if ( var_12["fraction"] < 1 )
            var_10 = 0;
    }

    var_14 = spawnstruct();
    var_14._id_6862 = var_10;
    var_14.origin = var_8;
    var_14.angles = var_9;
    return var_14;
}

_id_40CE( var_0 )
{
    var_1 = getentarray( "trigger_underwater", "targetname" );

    if ( var_1.size == 0 )
        return 0;

    var_2 = 200;
    var_3 = 0;
    var_4 = spawn( "script_origin", var_0 );
    var_5 = 0;

    while ( var_3 < var_2 )
    {
        if ( _id_9405( var_4, var_1 ) )
        {
            var_3 += 10;
            var_4.origin += ( 0.0, 0.0, 10.0 );
            continue;
        }

        break;
    }

    var_4 delete();

    if ( var_3 >= var_2 )
        return undefined;
    else
        return var_3;
}

_id_9405( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];

        if ( var_0 istouching( var_3 ) )
            return 1;
    }

    return 0;
}

_id_2EF4( var_0 )
{
    level.ugvs[var_0] = self;
}

_id_2F17( var_0 )
{
    level.ugvs[var_0] = undefined;
}

_id_2F0F()
{

}

_id_2F27( var_0, var_1 )
{
    var_0 endon( "death" );
    _id_2F0F();
    var_0._id_1FC7 = 0;
    var_0._id_1FBB = 0;
    _id_2EFE( var_0, 1, 1 );
    maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();

    if ( isdefined( var_1 ) && var_1 )
    {
        thread _id_2F14( var_0 );
        self setclientomnvar( "ui_drone_cloak", 2 );
        var_2 = 10000;
        var_3 = gettime() + var_2;
        self setclientomnvar( "ui_drone_cloak_time", var_3 );
        var_0._id_1FBB = 5;
        thread _id_1FBB( var_0 );
        thread _id_2F00( var_0 );
    }
    else
    {
        var_0 playsound( "recon_drn_cloak_deactivate" );
        _id_2EFE( var_0, 0 );
    }
}

_id_2F10( var_0 )
{
    return var_0._id_4721 && var_0._id_1FC7 >= 0;
}

_id_2EFF( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( isdefined( var_1 ) && var_1 )
    {
        thread _id_2EFC( var_0 );
        self waittill( "CloakCharged" );
    }

    for (;;)
    {
        self setclientomnvar( "ui_drone_cloak", 1 );
        thread _id_2EFB( var_0 );
        thread _id_2EFC( var_0 );

        if ( var_0._id_1FBB != 0 )
        {
            self setclientomnvar( "ui_drone_cloak", 3 );
            wait(var_0._id_1FBB);
        }

        if ( var_0._id_4721 )
            self setclientomnvar( "ui_drone_cloak", 1 );

        var_0 waittill( "Cloak" );
        var_0 notify( "ActivateCloak" );
        var_0 playsound( "recon_drn_cloak_activate" );
        self waittill( "CloakCharged" );
    }
}

_id_2EFB( var_0 )
{
    var_0 endon( "death" );
    var_0 waittill( "ActivateCloak" );
    thread _id_2EFE( var_0, 1 );
    thread _id_2F14( var_0 );
    var_1 = 10000;
    var_2 = gettime() + var_1;
    self setclientomnvar( "ui_drone_cloak_time", var_2 );
    self setclientomnvar( "ui_drone_cloak", 2 );
    var_0._id_1FBB = 5;
    thread _id_1FBB( var_0 );
    thread _id_2F00( var_0 );
}

_id_2EFC( var_0 )
{
    var_0 endon( "death" );
    self waittill( "UnCloak" );
    var_0 playsound( "recon_drn_cloak_deactivate" );
    thread _id_2EFE( var_0, 0 );
    self setclientomnvar( "ui_drone_cloak", 3 );
    thread _id_2EFD( var_0 );
}

_id_1FBB( var_0 )
{
    var_0 endon( "death" );
    self waittill( "UnCloak" );

    while ( var_0._id_1FBB > 0 )
    {
        var_0._id_1FBB -= 0.5;
        wait 0.5;
    }

    var_0._id_1FBB = 0;
    self notify( "CloakCharged" );
}

_id_2F00( var_0 )
{
    var_0 endon( "death" );
    var_1 = gettime();
    common_scripts\utility::waittill_any_timeout_no_endon_death( 10, "ForceUncloak", "Cloak" );
    var_2 = gettime();
    var_3 = max( var_2 - var_1, 5000 );
    var_0._id_1FBB = var_3 / 1000;
    var_4 = gettime() + var_3;
    self setclientomnvar( "ui_drone_cloak_cooldown", var_4 );
    self notify( "UnCloak" );
}

_id_2EFE( var_0, var_1, var_2 )
{
    var_0 notify( "cloaking_transition" );
    var_0 endon( "cloaking_transition" );
    var_0 endon( "death" );

    if ( var_1 )
    {
        if ( var_0._id_1FC7 == -2 )
            return;

        var_0._id_1FC7 = -1;
        var_0 cloakingenable();

        if ( isdefined( var_0._id_5BD2 ) )
            var_0._id_5BD2 cloakingenable();

        var_0 _meth_848F( 0 );

        if ( !isdefined( var_2 ) || !var_2 )
            wait 2.2;
        else
            wait 1.5;

        var_0 show();

        if ( isdefined( var_0._id_5BD2 ) )
            var_0._id_5BD2 show();

        var_0._id_1FC7 = -2;
    }
    else
    {
        if ( var_0._id_1FC7 == 2 )
            return;

        var_0._id_1FC7 = 1;
        var_0 cloakingdisable();
        var_0 _meth_848F( 1 );

        if ( isdefined( var_0._id_5BD2 ) )
            var_0._id_5BD2 cloakingdisable();

        wait 2.2;
        var_0._id_1FC7 = 2;
    }
}

_id_2EFD( var_0 )
{
    var_0 endon( "death" );
    self endon( "CloakCharged" );

    for (;;)
    {
        self waittill( "Cloak" );
        self playlocalsound( "recon_drn_cloak_notready" );
        wait 1;
    }
}

_id_2F14( var_0 )
{
    var_0 endon( "death" );
    self endon( "UnCloak" );
    wait 1;
    var_0 waittill( "damage" );
    self notify( "ForceUncloak" );
}

_id_9B62( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "stopShootLocationUpdate" );
    var_0._id_91C2 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_0._id_91C2 setmodel( "tag_origin" );
    var_0._id_91C2.angles = ( -90.0, 0.0, 0.0 );

    if ( isdefined( var_0._id_5BD2 ) && ( !isdefined( var_2 ) || !var_2 ) )
    {
        var_0._id_5BD2 _meth_8106( var_0._id_91C2 );
        var_0._id_5BD2 _meth_8508( var_0._id_91C2 );
    }
    else
        var_0 setotherent( var_0._id_91C2 );

    thread _id_0565( var_0, var_1 );

    if ( isdefined( var_1 ) )
        maps\mp\zombies\_util::playfxontagnetwork( var_1, var_0._id_91C2, "tag_origin" );

    if ( isdefined( var_0.hasaioption ) && var_0.hasaioption )
        return;

    for (;;)
    {
        var_3 = self _meth_845C();
        var_4 = self getangles();
        var_5 = anglestoforward( var_4 );
        var_6 = var_3 + var_5 * 8000;
        var_7 = bullettrace( var_3, var_6, 0, var_0 );
        var_0._id_91C2.origin = var_7["position"];
        waitframe();
    }
}

_id_0565( var_0, var_1 )
{
    var_0 common_scripts\utility::waittill_any( "death", "stopShootLocationUpdate" );

    if ( isdefined( var_0._id_91C2 ) )
    {
        var_2 = var_0._id_91C2;

        if ( isdefined( var_1 ) )
            maps\mp\zombies\_util::stopfxontagnetwork( var_1, var_2, "tag_origin" );

        waitframe();
        var_2 delete();
    }
}

_id_6CB7( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );

    if ( isdefined( var_3 ) )
        self endon( var_3 );

    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
    thread _id_6C84( var_0, var_1, var_2 );

    if ( !var_0._id_4721 )
        return;

    for (;;)
    {
        self waittill( "Cloak" );
        maps\mp\zombies\_util::stopfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
        waitframe();
        maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
        self waittill( "UnCloak" );
        maps\mp\zombies\_util::stopfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
        waitframe();
        maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
    }
}

_id_6C84( var_0, var_1, var_2 )
{
    var_0 waittill( "death" );
    maps\mp\zombies\_util::killfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
}

_id_7F56( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "death" );
    wait(var_0);

    if ( isdefined( level._id_2F3B ) )
        self setclienttriggervisionset( level._id_2F3B, 0 );

    if ( isdefined( level._id_2F12 ) )
        self lightsetforplayer( level._id_2F12 );
}

_id_739C( var_0 )
{
    self setclienttriggervisionset( "", var_0 );
    self lightsetforplayer( "" );
}

playerwatchfordroneemp( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    self endon( "assaultDroneHunterKiller" );
    var_0 waittill( "emp_damage" );
    var_0 notify( "death" );
}
