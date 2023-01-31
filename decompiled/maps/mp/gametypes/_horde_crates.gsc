// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

createhordecrates()
{
    level.hordeicon["support_drop"] = "specops_ui_airsupport";
    maps\mp\killstreaks\_airdrop::addcratetype( "horde_support_drop", "support_drop", 100, ::hordecratethink, &"HORDE_ARMORY_EXO" );
}

hordecratethink( var_0 )
{
    self endon( "death" );
    self endon( "restarting_physics" );
    var_1 = &"HORDE_HINT_SUPPORT_DROP";
    maps\mp\killstreaks\_airdrop::cratesetupforuse( "all", [ "specops_ui_airsupport" ] );
    maps\mp\killstreaks\_airdrop::cratesetuphintstrings( var_1 );
    childthread crateallcapturethinkhorde( 5 );
    level thread removeonnextairdrop( self );
    self.friendlymodel _meth_83FA( 5, 1 );

    for (;;)
    {
        self waittill( "captured", var_2 );
        maps\mp\gametypes\_horde_util::awardhordesupportdrop( var_2 );
        var_3 = randomintrange( 1, 100 );

        if ( var_3 < 36 )
            var_0 = "perk_armory";
        else if ( isdefined( maps\mp\gametypes\_horde_util::getslotnumber( var_2 ) ) )
            var_0 = "killstreak_armory";
        else
            var_0 = "perk_armory";

        if ( var_0 == var_2.lastdroptype )
            var_2.numsincesamedroptype++;
        else
            var_2.numsincesamedroptype = 0;

        if ( var_2.numsincesamedroptype > 3 )
        {
            if ( var_2.lastdroptype == "perk_armory" && isdefined( maps\mp\gametypes\_horde_util::getslotnumber( var_2 ) ) )
                var_0 = "killstreak_armory";
            else
                var_0 = "perk_armory";
        }

        var_2 _meth_82FB( "ui_horde_armory_type", var_0 );
        var_2.lastdroptype = var_0;
        var_2.usingarmory = 1;
        var_2 _meth_82FB( "ui_horde_show_armory", 1 );
        self.friendlymodel _meth_83FB();
        self playsound( "orbital_pkg_use_self_destruct" );
        maps\mp\killstreaks\_airdrop::deletecrate();
    }
}

crateallcapturethinkhorde( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 500;

    while ( isdefined( self ) )
    {
        self makeusable();
        self waittill( "trigger", var_1 );

        if ( handleagentuse( var_1 ) )
            continue;

        if ( !maps\mp\killstreaks\_airdrop::validateopenconditions( var_1 ) )
            continue;

        self makeunusable();
        var_1.iscapturingcrate = 1;

        if ( !maps\mp\killstreaks\_airdrop::useholdthink( var_1, var_0 ) )
        {
            var_1.iscapturingcrate = 0;
            continue;
        }

        var_1.iscapturingcrate = 0;
        self notify( "captured", var_1 );
    }
}

handleagentuse( var_0 )
{
    if ( !isplayer( var_0 ) )
    {
        if ( isdefined( var_0.disableplayeruseent ) )
            var_0.disableplayeruseent enableplayeruse( var_0 );

        var_0.disableplayeruseent = self;
        self disableplayeruse( var_0 );
        return 1;
    }

    return 0;
}

getfinaldroplocation( var_0 )
{
    if ( !isplayernearlocation( var_0 ) )
        return var_0;

    var_1 = getnodesinradiussorted( var_0, 256, 64, 128, "Path" );

    foreach ( var_3 in var_1 )
    {
        if ( !isplayernearlocation( var_3.origin ) )
            return var_3.origin;
    }

    return undefined;
}

isplayernearlocation( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level.participants )
    {
        var_4 = _func_220( var_3.origin, var_0 );

        if ( var_4 < 4096 )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

removeonnextairdrop( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "restarting_physics" );
    level waittill( "airSupport" );

    while ( isdefined( var_0.inuse ) && var_0.inuse )
        wait 0.05;

    var_0 maps\mp\killstreaks\_airdrop::deletecrate();
}
