// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

dronegetspawnpoint( var_0 )
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
    var_11 = getspawninwateroffset( var_8 + ( 0, 0, -30 ) );

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
    var_14.placementok = var_10;
    var_14.origin = var_8;
    var_14.angles = var_9;
    return var_14;
}

getspawninwateroffset( var_0 )
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
        if ( touchingwatertriggers( var_4, var_1 ) )
        {
            var_3 += 10;
            var_4.origin += ( 0, 0, 10 );
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

touchingwatertriggers( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        var_3 = var_1[var_2];

        if ( var_0 _meth_80A9( var_3 ) )
            return 1;
    }

    return 0;
}

droneaddtogloballist( var_0 )
{
    level.ugvs[var_0] = self;
}

droneremovefromgloballist( var_0 )
{
    level.ugvs[var_0] = undefined;
}

droneinitcloakomnvars()
{

}

dronesetupcloaking( var_0, var_1 )
{
    var_0 endon( "death" );
    droneinitcloakomnvars();
    var_0.cloakstate = 0;
    var_0.cloakcooldown = 0;
    dronecloakingtransition( var_0, 1, 1 );
    maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();

    if ( isdefined( var_1 ) && var_1 )
    {
        thread dronemonitordamagewhilecloaking( var_0 );
        self _meth_82FB( "ui_drone_cloak", 2 );
        var_2 = 10000;
        var_3 = gettime() + var_2;
        self _meth_82FB( "ui_drone_cloak_time", var_3 );
        var_0.cloakcooldown = 5;
        thread cloakcooldown( var_0 );
        thread dronecloakwaitforexit( var_0 );
    }
    else
    {
        var_0 playsound( "recon_drn_cloak_deactivate" );
        dronecloakingtransition( var_0, 0 );
    }
}

droneiscloaked( var_0 )
{
    return var_0.hascloak && var_0.cloakstate >= 0;
}

dronecloakready( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( isdefined( var_1 ) && var_1 )
    {
        thread dronecloakcooldown( var_0 );
        self waittill( "CloakCharged" );
    }

    for (;;)
    {
        self _meth_82FB( "ui_drone_cloak", 1 );
        thread dronecloakactivated( var_0 );
        thread dronecloakcooldown( var_0 );

        if ( var_0.cloakcooldown != 0 )
        {
            self _meth_82FB( "ui_drone_cloak", 3 );
            wait(var_0.cloakcooldown);
        }

        if ( var_0.hascloak )
            self _meth_82FB( "ui_drone_cloak", 1 );

        var_0 waittill( "Cloak" );
        var_0 notify( "ActivateCloak" );
        var_0 playsound( "recon_drn_cloak_activate" );
        self waittill( "CloakCharged" );
    }
}

dronecloakactivated( var_0 )
{
    var_0 endon( "death" );
    var_0 waittill( "ActivateCloak" );
    thread dronecloakingtransition( var_0, 1 );
    thread dronemonitordamagewhilecloaking( var_0 );
    var_1 = 10000;
    var_2 = gettime() + var_1;
    self _meth_82FB( "ui_drone_cloak_time", var_2 );
    self _meth_82FB( "ui_drone_cloak", 2 );
    var_0.cloakcooldown = 5;
    thread cloakcooldown( var_0 );
    thread dronecloakwaitforexit( var_0 );
}

dronecloakcooldown( var_0 )
{
    var_0 endon( "death" );
    self waittill( "UnCloak" );
    var_0 playsound( "recon_drn_cloak_deactivate" );
    thread dronecloakingtransition( var_0, 0 );
    self _meth_82FB( "ui_drone_cloak", 3 );
    thread dronecloakdeactivateddialog( var_0 );
}

cloakcooldown( var_0 )
{
    var_0 endon( "death" );
    self waittill( "UnCloak" );

    while ( var_0.cloakcooldown > 0 )
    {
        var_0.cloakcooldown -= 0.5;
        wait 0.5;
    }

    var_0.cloakcooldown = 0;
    self notify( "CloakCharged" );
}

dronecloakwaitforexit( var_0 )
{
    var_0 endon( "death" );
    var_1 = gettime();
    common_scripts\utility::waittill_any_timeout_no_endon_death( 10, "ForceUncloak", "Cloak" );
    var_2 = gettime();
    var_3 = max( var_2 - var_1, 5000 );
    var_0.cloakcooldown = var_3 / 1000;
    var_4 = gettime() + var_3;
    self _meth_82FB( "ui_drone_cloak_cooldown", var_4 );
    self notify( "UnCloak" );
}

dronecloakingtransition( var_0, var_1, var_2 )
{
    var_0 notify( "cloaking_transition" );
    var_0 endon( "cloaking_transition" );
    var_0 endon( "death" );

    if ( var_1 )
    {
        if ( var_0.cloakstate == -2 )
            return;

        var_0.cloakstate = -1;
        var_0 _meth_844B();

        if ( isdefined( var_0.mgturret ) )
            var_0.mgturret _meth_844B();

        var_0 _meth_848F( 0 );

        if ( !isdefined( var_2 ) || !var_2 )
            wait 2.2;
        else
            wait 1.5;

        var_0 show();

        if ( isdefined( var_0.mgturret ) )
            var_0.mgturret show();

        var_0.cloakstate = -2;
    }
    else
    {
        if ( var_0.cloakstate == 2 )
            return;

        var_0.cloakstate = 1;
        var_0 _meth_844C();
        var_0 _meth_848F( 1 );

        if ( isdefined( var_0.mgturret ) )
            var_0.mgturret _meth_844C();

        wait 2.2;
        var_0.cloakstate = 2;
    }
}

dronecloakdeactivateddialog( var_0 )
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

dronemonitordamagewhilecloaking( var_0 )
{
    var_0 endon( "death" );
    self endon( "UnCloak" );
    wait 1;
    var_0 waittill( "damage" );
    self notify( "ForceUncloak" );
}

updateshootinglocation( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "stopShootLocationUpdate" );
    var_0.targetent = spawn( "script_model", ( 0, 0, 0 ) );
    var_0.targetent _meth_80B1( "tag_origin" );
    var_0.targetent.angles = ( -90, 0, 0 );

    if ( isdefined( var_0.mgturret ) && ( !isdefined( var_2 ) || !var_2 ) )
    {
        var_0.mgturret _meth_8106( var_0.targetent );
        var_0.mgturret _meth_8508( var_0.targetent );
    }
    else
        var_0 _meth_8383( var_0.targetent );

    thread _cleanupshootinglocationondeath( var_0, var_1 );

    if ( isdefined( var_1 ) )
        maps\mp\zombies\_util::playfxontagnetwork( var_1, var_0.targetent, "tag_origin" );

    if ( isdefined( var_0.hasaioption ) && var_0.hasaioption )
        return;

    for (;;)
    {
        var_3 = self _meth_845C();
        var_4 = self getangles();
        var_5 = anglestoforward( var_4 );
        var_6 = var_3 + var_5 * 8000;
        var_7 = bullettrace( var_3, var_6, 0, var_0 );
        var_0.targetent.origin = var_7["position"];
        waitframe();
    }
}

_cleanupshootinglocationondeath( var_0, var_1 )
{
    var_0 common_scripts\utility::waittill_any( "death", "stopShootLocationUpdate" );

    if ( isdefined( var_0.targetent ) )
    {
        var_2 = var_0.targetent;

        if ( isdefined( var_1 ) )
            maps\mp\zombies\_util::stopfxontagnetwork( var_1, var_2, "tag_origin" );

        waitframe();
        var_2 delete();
    }
}

playerhandleexhaustfx( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );

    if ( isdefined( var_3 ) )
        self endon( var_3 );

    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
    thread playerdeleteexhaustfxonvehicledeath( var_0, var_1, var_2 );

    if ( !var_0.hascloak )
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

playerdeleteexhaustfxonvehicledeath( var_0, var_1, var_2 )
{
    var_0 waittill( "death" );
    maps\mp\zombies\_util::killfxontagnetwork( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
}

setdronevisionandlightsetpermap( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "death" );
    wait(var_0);

    if ( isdefined( level.dronevisionset ) )
        self _meth_847A( level.dronevisionset, 0 );

    if ( isdefined( level.dronelightset ) )
        self _meth_83C0( level.dronelightset );
}

removedronevisionandlightsetpermap( var_0 )
{
    self _meth_847A( "", var_0 );
    self _meth_83C0( "" );
}

playerwatchfordroneemp( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    self endon( "assaultDroneHunterKiller" );
    var_0 waittill( "emp_damage" );
    var_0 notify( "death" );
}
