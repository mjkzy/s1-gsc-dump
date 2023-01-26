// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::mpsector17callbackstartgametype;
    maps\mp\mp_sector17_precache::main();
    maps\createart\mp_sector17_art::main();
    maps\mp\mp_sector17_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_sector17_lighting::main();
    maps\mp\mp_sector17_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_sector17" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_0A9D = 0;
    level thread _id_A75F::init();
    level thread runloudspeakers();
    level thread killstreakoverrides();
    level.isoutofboundscustomfunc = ::isoutofboundscustomfunc;

    if ( level.nextgen )
        level thread patchcollision();
}

patchcollision()
{

}

mpsector17callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

runloudspeakers()
{
    level endon( "game_ended" );
    level.sector17voice = "gid";

    if ( common_scripts\utility::cointoss() )
        level.sector17voice = "cor";

    level.sector17aliases = [];
    level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_01";
    level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_02";
    level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_03";
    level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_04";
    level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_05";
    level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_06";
    level.sector17aliases = common_scripts\utility::array_randomize( level.sector17aliases );
    level.sector17aliasindex = 0;
    level waittill( "prematch_done" );

    for (;;)
    {
        wait(randomfloatrange( 90, 120 ));
        level notify( "stopOnPlayerConnectedSector17" );
        var_0 = getnextalias();
        var_1 = playloudspeakermessage( var_0 );

        if ( var_1 )
            incrementaliasindex();
    }
}

onplayerconnectedsector17()
{
    level endon( "stopOnPlayerConnectedSector17" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread playerdostartmessage();
    }
}

playerdostartmessage()
{
    self endon( "disconnect" );
    level endon( "stopOnPlayerConnectedSector17" );
    self waittill( "spawned_player" );
    self waittill( "playLeaderDialogOnPlayer" );
    self waittill( "playLeaderDialogOnPlayer" );
    wait 5;
    thread playerdoloudspeakerannouncement( "mp_sec17_amb_" + level.sector17voice + "_07" );
}

playloudspeakermessage( var_0 )
{
    var_1 = 0;
    var_0 = getnextalias();

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3.leaderdialogactive ) && var_3.leaderdialogactive != "" )
            continue;

        if ( isdefined( var_3.leaderdialogqueue ) && var_3.leaderdialogqueue.size > 0 )
            continue;

        var_1 = 1;
        var_3 thread playerdoloudspeakerannouncement( var_0 );
    }

    return var_1;
}

getnextalias()
{
    return level.sector17aliases[level.sector17aliasindex];
}

incrementaliasindex()
{
    level.sector17aliasindex++;

    if ( level.sector17aliasindex >= level.sector17aliases.size )
    {
        level.sector17aliases = common_scripts\utility::array_randomize( level.sector17aliases );
        level.sector17aliasindex = 0;
    }
}

playerdoloudspeakerannouncement( var_0 )
{
    self.leaderdialoglocalsound = "scripted";
    self.leaderdialogactive = "scripted";
    self.leaderdialoggroup = "scripted";
    self playlocalsound( var_0 );
    wait 5;
    thread restartleaderdialog();
}

restartleaderdialog()
{
    self.leaderdialoglocalsound = "";
    self.leaderdialogactive = "";
    self.leaderdialoggroup = "";
    var_0 = self.pers["team"];

    if ( self.leaderdialogqueue.size > 0 )
    {
        var_1 = self.leaderdialogqueue[0];
        var_2 = self.leaderdialoglocqueue[0];

        for ( var_3 = 1; var_3 < self.leaderdialogqueue.size; var_3++ )
            self.leaderdialogqueue[var_3 - 1] = self.leaderdialogqueue[var_3];

        for ( var_3 = 1; var_3 < self.leaderdialoglocqueue.size; var_3++ )
            self.leaderdialoglocqueue[var_3 - 1] = self.leaderdialoglocqueue[var_3];

        self.leaderdialogqueue[var_3 - 1] = undefined;
        self.leaderdialoglocqueue[var_3 - 1] = undefined;
        thread maps\mp\_utility::leaderdialogonplayer_internal( var_1, var_0, var_2 );
    }
}

killstreakoverrides()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 1400;
}

isoutofboundscustomfunc( var_0, var_1, var_2 )
{
    var_3 = 0;

    if ( isdefined( var_0.vehicletype ) && var_0.vehicletype == "orbital_strike" && isdefined( var_2[0].targetname ) && var_2[0].targetname == "remote_heli_range" )
    {
        if ( var_0.origin[0] < -2496 || var_0.origin[0] > 2416 || var_0.origin[1] < -1640 || var_0.origin[1] > 4272 )
            var_3 = 1;
    }
    else
        var_3 = var_0 maps\mp\killstreaks\_aerial_utility::_id_9D75( var_2 );

    return var_3;
}
