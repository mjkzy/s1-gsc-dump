// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    precachemodel( "mp_dam_large_caliber_turret" );
    maps\mp\mp_dam_precache::main();
    maps\createart\mp_dam_art::main();
    maps\mp\mp_dam_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_dam_lighting::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_dam" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_088B = 600;
    level._id_5985 = ::damcustomkillstreakfunc;
    level._id_6573 = ::damcustomospfunc;
    setdvar( "r_mpRimColor", "1 1 1" );
    setdvar( "r_mpRimStrength", "1" );
    setdvar( "r_mpRimDiffuseTint", "1 1 1" );
    thread rotategenerators();
    thread crane1movement();
    thread crane2movement();
    thread setupkillstreakturrets();
    thread _id_458C();
    thread damcustomairstrike();
    thread dampatchclip();
    thread removebadtriggerhurtthatguyplacedwrong();
}

removebadtriggerhurtthatguyplacedwrong()
{
    var_0 = ( -467.0, 1256.0, 510.0 );
    var_1 = getentarray( "trigger_hurt", "classname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = distance( var_0, var_3.origin );

        if ( var_4 < 32 )
        {
            var_3 dontinterpolate();
            var_3.origin += ( 0.0, 0.0, -10000.0 );
        }
    }
}

dampatchclip()
{
    thread uppertreeclip();
    thread constructionclip();
    thread droneexteriorclip();
    thread loungeclip();
}

loungeclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -732.0, 524.0, 207.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -675.0, 528.0, 207.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -676.0, 482.0, 207.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -737.0, 452.0, 212.0 ), ( 0.0, 0.0, 0.0 ) );
}

droneexteriorclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2455.0, -223.0, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2495.3, -344.9, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2534.91, -466.64, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2574.46, -588.38, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2455.8, -223.2, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2495.4, -344.9, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2534.9, -466.6, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2574.5, -588.4, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2455.8, -223.2, -62.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2495.4, -344.9, -62.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2534.9, -466.6, -62.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2574.5, -588.4, -62.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2577.54, -183.62, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2617.09, -305.35, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2656.64, -427.09, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2696.2, -548.82, 194.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2577.5, -183.6, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2617.1, -305.4, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2656.6, -427.1, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2696.2, -548.8, 66.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2577.5, -183.6, -62.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2617.1, -305.4, -62.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2656.6, -427.1, -62.0 ), ( 0.0, 18.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2696.2, -548.8, -62.0 ), ( 0.0, 18.0, 0.0 ) );
}

uppertreeclip()
{
    var_0 = ( 0.0, 344.0, 0.0 );
    var_1 = ( -20.0, -2700.0, 302.0 );
    var_2 = 0;

    for ( var_3 = 0; var_3 < 8; var_3++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", var_1 + ( 0, 0, var_2 ), var_0 );
        var_2 += 128;
    }
}

constructionclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894.0, -704.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150.0, -704.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406.0, -704.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662.0, -704.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774.0, -840.0, 766.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774.0, -1096.0, 766.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802.0, -840.0, 766.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802.0, -1096.0, 766.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894.0, -704.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1252.0, -908.0, 766.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150.0, -704.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406.0, -704.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894.0, -790.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150.0, -790.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406.0, -790.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662.0, -790.0, 766.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662.0, -704.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774.0, -840.0, 1022.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774.0, -1096.0, 1022.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802.0, -840.0, 1022.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802.0, -1096.0, 1022.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1252.0, -908.0, 1022.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894.0, -790.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150.0, -790.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406.0, -790.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662.0, -790.0, 1022.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894.0, -704.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150.0, -704.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406.0, -704.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662.0, -704.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774.0, -840.0, 1278.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774.0, -1096.0, 1278.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802.0, -840.0, 1278.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802.0, -1096.0, 1278.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1252.0, -908.0, 1278.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894.0, -790.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150.0, -790.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406.0, -790.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662.0, -790.0, 1278.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1544.0, -726.0, 572.0 ), ( 0.0, 262.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1292.0, -708.0, 572.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1156.0, -708.0, 572.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 904.0, -726.0, 572.0 ), ( 0.0, 278.0, 0.0 ) );
}

damcustomairstrike()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 1750;
}

damcustomkillstreakfunc()
{
    level._id_53AB["mp_dam_railgun"] = 1;
    level._id_53AB["dam_turret_mp"] = 1;
    level thread maps\mp\killstreaks\streak_mp_dam::init();
}

damcustomospfunc()
{
    level._id_6574._id_89F2 = ( 1544.0, 1016.0, 200.0 );
    level._id_6574._id_8989 = 120;
    level._id_6574._id_8A00 = undefined;
    level._id_6574._id_89DC = undefined;
}

setupkillstreakturrets()
{
    var_0 = [];
    var_1 = getent( "railgun_attachpoint0", "targetname" );
    var_2 = var_1 spawndamturret( "dam_turret_mp", "mp_dam_large_caliber_turret", "tag_player_mp" );
    var_0 = common_scripts\utility::array_add( var_0, var_2 );
    var_1 = getent( "railgun_attachpoint1", "targetname" );
    var_2 = var_1 spawndamturret( "dam_turret_mp", "mp_dam_large_caliber_turret", "tag_player_mp" );
    var_0 = common_scripts\utility::array_add( var_0, var_2 );
    level.damturrets = var_0;
}

spawndamturret( var_0, var_1, var_2 )
{
    var_3 = spawnturret( "misc_turret", self.origin, var_0, 0 );
    var_3.attachpoint = self;
    var_3.angles = common_scripts\utility::flat_angle( self.angles );
    var_3 setmodel( var_1 );
    var_3 _meth_815A( 45.0 );
    var_3.health = 99999;
    var_3.maxhealth = 1000;
    var_3.damagetaken = 0;
    var_3.stunned = 0;
    var_3._id_8F70 = 0.0;
    var_3 setcandamage( 0 );
    var_3 setcanradiusdamage( 0 );
    var_3 _meth_8065( "manual" );
    level.damdefaultaiment = getent( "DamTurretDefaultTarget", "targetname" );
    var_3 _meth_8106( level.damdefaultaiment );
    return var_3;
}

setupcraneanimations()
{
    map_restart( "dam_crane01_idle_l" );
    map_restart( "dam_crane01_idle_r" );
    map_restart( "dam_crane01_l_2_r" );
    map_restart( "dam_crane01_r_2_l" );
    map_restart( "dam_crane02_idle_l" );
    map_restart( "dam_crane02_idle_r" );
    map_restart( "dam_crane02_l_2_r" );
    map_restart( "dam_crane02_r_2_l" );
    map_restart( "dam_crane01_tag_idle_l" );
    map_restart( "dam_crane01_tag_idle_r" );
    map_restart( "dam_crane01_tag_l_2_r" );
    map_restart( "dam_crane01_tag_r_2_l" );
    map_restart( "dam_crane02_tag_idle_l" );
    map_restart( "dam_crane02_tag_idle_r" );
    map_restart( "dam_crane02_tag_l_2_r" );
    map_restart( "dam_crane02_tag_r_2_l" );
    map_restart( "dam_crane01_collisiontest" );
}

cranecollisiontest()
{
    var_0 = getent( "Crane_02", "targetname" );
    var_1 = getent( "crane2PipeCollision", "targetname" );
    var_1 linkto( var_0, "j_tube_01_c" );

    for (;;)
    {
        var_0 scriptmodelplayanimdeltamotion( "dam_crane01_collisiontest" );
        wait 20;
    }
}

tempcraneidlesetup()
{
    var_0 = getent( "Crane_01", "targetname" );
    var_1 = getent( "crane1PipeCollision", "targetname" );
    var_1 linkto( var_0, "j_tube_01_c" );
    var_2 = getent( "Crane_02", "targetname" );
    var_3 = getent( "crane2PipeCollision", "targetname" );
    var_3 linkto( var_2, "j_tube_01_c" );
    var_0 scriptmodelplayanimdeltamotion( "dam_crane02_idle_l" );
    var_2 scriptmodelplayanimdeltamotion( "dam_crane01_idle_l" );
}

crane1movement()
{
    var_0 = getent( "Crane_01_TagProxy", "targetname" );
    var_1 = getent( "Crane_01", "targetname" );
    var_2 = getent( "crane1PipeCollision", "targetname" );
    var_3 = getent( "crane_01_bcs_trigger", "targetname" );
    var_4 = getent( "Crane_01_TagBaseProxy", "targetname" );
    var_5 = getent( "crane1Collision", "targetname" );
    var_2 linktosynchronizedparent( var_0, "tag_origin" );
    var_3 handle_trigger_updateto( var_2 );
    var_5.angles += ( 0.0, -249.215, 0.0 );
    var_5 linktosynchronizedparent( var_4, "tag_origin" );
    var_6 = 20;
    var_7 = ( 2181.0, -1069.0, 1407.0 );
    thread aud_play_crane_sfx( var_7, var_6, "crane_01" );

    for (;;)
    {
        var_0 _meth_827A();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 _meth_827A();
        var_1 scriptmodelplayanimdeltamotion( "dam_crane01_l_2_r" );
        var_0 scriptmodelplayanimdeltamotion( "dam_crane01_tag_l_2_r" );
        var_4 scriptmodelplayanimdeltamotion( "dam_crane01_tag_base_l_2_r" );
        wait(var_6);
        var_0 _meth_827A();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 _meth_827A();
        var_1 scriptmodelplayanimdeltamotion( "dam_crane01_r_2_l" );
        var_0 scriptmodelplayanimdeltamotion( "dam_crane01_tag_r_2_l" );
        var_4 scriptmodelplayanimdeltamotion( "dam_crane01_tag_base_r_2_l" );
        wait(var_6);
    }
}

crane2movement()
{
    var_0 = getent( "Crane_02_TagProxy", "targetname" );
    var_1 = getent( "Crane_02", "targetname" );
    var_2 = getent( "crane2PipeCollision", "targetname" );
    var_3 = getent( "crane_02_bcs_trigger", "targetname" );
    var_4 = getent( "Crane_02_TagBaseProxy", "targetname" );
    var_5 = getent( "crane2Collision", "targetname" );
    var_6 = 20;
    var_7 = ( 849.0, 2315.0, 1455.0 );
    thread aud_play_crane_sfx( var_7, var_6, "crane_02" );
    var_2 linktosynchronizedparent( var_0, "tag_origin" );
    var_3 handle_trigger_updateto( var_2 );
    var_5.angles += ( 0.0, -117.312, 0.0 );
    var_5 linktosynchronizedparent( var_4, "tag_origin" );

    for (;;)
    {
        var_0 _meth_827A();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 _meth_827A();
        var_1 scriptmodelplayanimdeltamotion( "dam_crane02_l_2_r" );
        var_0 scriptmodelplayanimdeltamotion( "dam_crane02_tag_l_2_r" );
        var_4 scriptmodelplayanimdeltamotion( "dam_crane02_tag_base_l_2_r" );
        wait(var_6);
        var_0 _meth_827A();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 _meth_827A();
        var_1 scriptmodelplayanimdeltamotion( "dam_crane02_r_2_l" );
        var_0 scriptmodelplayanimdeltamotion( "dam_crane02_tag_r_2_l" );
        var_4 scriptmodelplayanimdeltamotion( "dam_crane02_tag_base_r_2_l" );
        wait(var_6);
    }
}

handle_trigger_updateto( var_0 )
{
    level endon( "game_ended" );
    var_1 = self.origin - var_0.origin;
    var_2 = self.angles - var_0.angles;
    childthread _id_5F96( var_0, var_1, var_2 );
}

_id_5F96( var_0, var_1, var_2 )
{
    for (;;)
    {
        self.origin = var_0.origin + var_1;
        self.angles = var_0.angles - var_2;
        wait 0.05;
    }
}

aud_play_crane_sfx( var_0, var_1, var_2 )
{
    var_3 = var_0;
    var_4 = spawn( "script_origin", var_3 );
}

rotategenerators()
{
    var_0 = getentarray( "generator_fan", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread rotatefan();
}

rotatefan()
{
    if ( !isdefined( level.genrotatespeed ) )
        level.genrotatespeed = -180;

    var_0 = 0;

    for (;;)
    {
        if ( var_0 != level.genrotatespeed )
        {
            self rotatevelocity( ( 0, level.genrotatespeed, 0 ), 3600 );
            var_0 = level.genrotatespeed;
        }

        wait 0.5;
    }
}

rotatecrane()
{
    level endon( "game_ended" );

    for (;;)
    {
        self.cab _meth_82B5( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.platform _meth_82B5( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self._id_6821 _meth_82B5( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.pulley _meth_82B5( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.hook _meth_82B5( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.heightoscillator moveto( ( 0, 0, getdvarint( self.pipe_end_height_dvar, 0 ) ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.radiusoscillator moveto( ( 0, 0, getdvarint( self.pipe_end_radius_dvar, 0 ) ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        wait(getdvarint( self.time_dvar, 10 ) + 5);
        self.cab _meth_82B5( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.platform _meth_82B5( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self._id_6821 _meth_82B5( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.pulley _meth_82B5( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.hook _meth_82B5( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.heightoscillator moveto( ( 0, 0, getdvarint( self.pipe_start_height_dvar, 0 ) ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.radiusoscillator moveto( ( 0, 0, getdvarint( self.pipe_start_radius_dvar, 0 ) ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        wait(getdvarint( self.time_dvar, 10 ) + 5);
    }
}

movecranepipe()
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = ( cos( self.platform.angles[1] + 90 ) * self.radiusoscillator.origin[2] + self.cab.origin[0], sin( self.platform.angles[1] + 90 ) * self.radiusoscillator.origin[2] + self.cab.origin[1], self.heightoscillator.origin[2] );
        self._id_6821 moveto( var_0, 0.05, 0.025, 0.025 );
        self.pulley moveto( ( var_0[0], var_0[1], self.pulley.origin[2] ), 0.05, 0.025, 0.025 );
        self.hook moveto( var_0 + ( 0.0, 0.0, 270.0 ), 0.05, 0.025, 0.025 );
        wait 0.05;
    }
}

handlepowersurge()
{
    for (;;)
    {
        wait(getdvarint( "mp_dam_surge_interval", 50 ));

        foreach ( var_1 in level.spark_origin_tags )
            playfxontag( level.mp_dam_fx["dam_surge_sparks"], var_1, "tag_origin" );

        foreach ( var_4 in level.surge_vo_origin_tags )
            var_4 thread maps\mp\_utility::play_sound_on_tag( level.pa_warning0, "tag_origin" );

        wait(getdvarint( "mp_dam_surge_delay", 7 ));
        level.power_surge_active = 1;
        level.genrotatespeed *= 2;

        foreach ( var_1 in level.spark_origin_tags )
            playfxontag( level.mp_dam_fx["dam_surge_arcs"], var_1, "tag_origin" );

        foreach ( var_9 in level.smoke_origin_tags )
        {

        }

        foreach ( var_12 in level.elec_sparks_origin_tags )
            var_12 thread common_scripts\utility::play_loop_sound_on_entity( level.surge_sparks_noise );

        foreach ( var_4 in level.surge_vo_origin_tags )
            var_4 thread maps\mp\_utility::play_sound_on_tag( level.pa_warning1, "tag_origin" );

        wait(getdvarint( "mp_dam_surge_duration", 30 ));
        level.power_surge_active = 0;
        level.genrotatespeed /= 2;

        foreach ( var_1 in level.spark_origin_tags )
        {
            stopfxontag( level.mp_dam_fx["dam_surge_sparks"], var_1, "tag_origin" );
            stopfxontag( level.mp_dam_fx["dam_surge_arcs"], var_1, "tag_origin" );
        }

        foreach ( var_9 in level.smoke_origin_tags )
        {

        }

        foreach ( var_12 in level.elec_sparks_origin_tags )
            var_12 thread common_scripts\utility::stop_loop_sound_on_entity( level.surge_sparks_noise );

        wait 0.05;
    }
}

handlepowersurgedamage()
{
    for (;;)
    {
        if ( level.power_surge_active == 1 )
        {
            foreach ( var_1 in level.players )
            {
                foreach ( var_3 in level.dam_surge_triggers )
                {
                    if ( var_1 istouching( var_3 ) )
                    {
                        var_1 playrumbleonentity( "damage_heavy" );
                        var_1 shellshock( "orbital_laser_mp", 1 );
                        var_1 dodamage( 5, var_1.origin );
                    }
                }
            }
        }

        wait 0.05;
    }
}

_id_458C()
{
    var_0 = getglassarray( "skylights" );
    var_1 = getentarray( "skylights", "targetname" );
    var_2 = getentarray( "glass_pathing", "targetname" );

    if ( !isdefined( var_1 ) )
        return 0;

    var_3 = 8;

    foreach ( var_5 in var_0 )
    {
        var_6 = getglassorigin( var_5 );

        foreach ( var_8 in var_1 )
        {
            if ( distance( var_6, var_8.origin ) <= var_3 )
            {
                var_8._id_421A = var_5;
                break;
            }
        }
    }

    common_scripts\utility::array_thread( var_1, ::_id_45D4 );
}

_id_45D4()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return 0;

    var_0 common_scripts\utility::trigger_off();
    var_0 connectpaths();
    _id_A089( self._id_421A );
    var_0 common_scripts\utility::trigger_on();
    var_0 disconnectpaths();
    var_0 common_scripts\utility::trigger_off();
}

_id_A089( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( isglassdestroyed( var_0 ) )
            return 1;

        wait 0.05;
    }
}
