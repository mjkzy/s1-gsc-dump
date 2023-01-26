// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A768::main();
    _id_A6CE::main();
    _id_A767::main();
    maps\mp\_load::main();
    maps\mp\mp_instinct_lighting::main();
    maps\mp\mp_instinct_aud::main();
    level._id_65AB = "mp_instinct_osp";
    level._id_65A9 = "mp_instinct_osp";
    level._id_A197 = "mp_instinct_osp";
    maps\mp\_compass::_id_831E( "compass_map_mp_instinct" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_088B = 350;
    level._id_6573 = ::_id_4E8C;
    precachemodel( "ins_crane_drilling_mechanism" );
    precachemodel( "ins_cave_drill" );
    precachemodel( "ins_generator_engine_01_fan" );
    level._id_755D = getentarray( "river_drill", "targetname" );
    level._id_1BE4 = getentarray( "cave_drill", "targetname" );
    level._id_1BE5 = getentarray( "cave_drill_inside", "targetname" );
    level thread _id_2DED();
    level thread _id_3C86();
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    thread scriptpatchclip();
    setdvar( "r_reactivemotionfrequencyscale", 0.5 );
    setdvar( "r_reactivemotionamplitudescale", 0.5 );
}

scriptpatchclip()
{
    thread treepatchclip();
}

treepatchclip()
{
    var_0 = ( 0.0, 348.0, 0.0 );
    var_1 = ( 1314.0, 60.0, 616.0 );
    var_2 = 0;

    for ( var_3 = 0; var_3 < 16; var_3++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", var_1 + ( 0, 0, var_2 ), var_0 );
        var_2 += 64;
    }
}

_id_4E8C()
{
    level._id_6574._id_89DC = 9615;
    level._id_6574._id_04BD = -35;
    level._id_6574._id_0380 = 18;
    level._id_6574._id_0252 = 18;
}

_id_7E66()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "2", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0" );
        }
    }
}

_id_755C()
{
    level endon( "game_ended" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_3 = common_scripts\utility::spawn_tag_origin();
    wait 0.05;
    var_0 show();
    var_1 show();
    var_2 show();
    var_3 show();
    wait 0.4;
    var_0 linkto( self, "poundee", ( 75.0, 0.0, 400.0 ), ( 0.0, 0.0, 0.0 ) );
    var_1 linkto( self, "poundee", ( 75.0, 0.0, 400.0 ), ( 90.0, 0.0, 90.0 ) );
    var_2 linkto( self, "tag_origin", ( 0.0, 0.0, 100.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3 linkto( self, "tag_origin", ( 0.0, 0.0, -100.0 ), ( 270.0, 180.0, 90.0 ) );
    common_scripts\utility::noself_delaycall( 1, ::playfxontag, common_scripts\utility::getfx( "diesel_drill_smk_loop" ), var_0, "tag_origin" );
    wait 0.1;

    for (;;)
    {
        earthquake( 0.15, 1, var_2.origin, 500 );
        common_scripts\utility::noself_delaycall( 0.4, ::playfxontag, common_scripts\utility::getfx( "drill_impact_dust" ), var_3, "tag_origin" );
        wait 2;
        common_scripts\utility::noself_delaycall( 0.4, ::playfxontag, common_scripts\utility::getfx( "diesel_drill_smk_ring" ), var_1, "tag_origin" );
    }
}

_id_2DED()
{
    level endon( "end_drill_anims" );
    wait 1;
    _id_0C54();
}

_id_0C54()
{
    if ( isdefined( level._id_755D ) )
        common_scripts\utility::array_thread( level._id_755D, ::_id_9ACF );

    if ( isdefined( level._id_1BE4 ) )
        common_scripts\utility::array_thread( level._id_1BE4, ::_id_9AA3 );

    if ( isdefined( level._id_1BE5 ) )
        common_scripts\utility::array_thread( level._id_1BE5, ::_id_9AA4 );
}

_id_9ACF()
{
    level endon( "end_drill_anims" );
    var_0 = randomfloat( 2 );
    wait 0.05;
    wait(var_0);
    maps\mp\_audio::_id_7B3D( self, "ins_drilling_machine", "ps_ins_piledriver_hit", "ins_piledriver_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event" );
    thread _id_755C();
}

_id_9AA3()
{
    var_0 = randomfloat( 2 );
    wait 0.05;
    wait(var_0);
    maps\mp\_audio::_id_7B3D( self, "ins_cave_drill_idle", "ins_piledriver_cave_hit", "ins_piledriver_cave_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event" );

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "impact_fx" )
    {
        wait 0.5;
        thread _id_A767::_id_1BE3();
    }
}

_id_9AA4()
{
    level endon( "end_drill_anims" );
    var_0 = randomfloat( 2 );
    wait(var_0);
    maps\mp\_audio::_id_7B3D( self, "ins_cave_drill_idle", "ins_piledriver_cave_hit", "ins_piledriver_cave_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event" );
}

_id_3C86()
{
    var_0 = getentarray( "generator_fans", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 scriptmodelplayanim( "ins_generator_fan" );
}
