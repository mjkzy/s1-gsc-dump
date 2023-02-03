// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachemodel( "mp_dam_large_caliber_turret" );
    maps\mp\mp_dam_precache::main();
    maps\createart\mp_dam_art::main();
    maps\mp\mp_dam_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_dam_lighting::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_dam" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.aerial_pathnode_offset = 600;
    level.mapcustomkillstreakfunc = ::damcustomkillstreakfunc;
    level.orbitalsupportoverridefunc = ::damcustomospfunc;
    setdvar( "r_mpRimColor", "1 1 1" );
    setdvar( "r_mpRimStrength", "1" );
    setdvar( "r_mpRimDiffuseTint", "1 1 1" );
    thread rotategenerators();
    thread crane1movement();
    thread crane2movement();
    thread setupkillstreakturrets();
    thread handle_glass_pathing();
    thread damcustomairstrike();
    thread dampatchclip();
    thread removebadtriggerhurtthatguyplacedwrong();
}

removebadtriggerhurtthatguyplacedwrong()
{
    var_0 = ( -467, 1256, 510 );
    var_1 = getentarray( "trigger_hurt", "classname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = distance( var_0, var_3.origin );

        if ( var_4 < 32 )
        {
            var_3 dontinterpolate();
            var_3.origin += ( 0, 0, -10000 );
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
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -732, 524, 207 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -675, 528, 207 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -676, 482, 207 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -737, 452, 212 ), ( 0, 0, 0 ) );
}

droneexteriorclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2455, -223, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2495.3, -344.9, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2534.91, -466.64, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2574.46, -588.38, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2455.8, -223.2, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2495.4, -344.9, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2534.9, -466.6, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2574.5, -588.4, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2455.8, -223.2, -62 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2495.4, -344.9, -62 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2534.9, -466.6, -62 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2574.5, -588.4, -62 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2577.54, -183.62, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2617.09, -305.35, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2656.64, -427.09, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2696.2, -548.82, 194 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2577.5, -183.6, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2617.1, -305.4, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2656.6, -427.1, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2696.2, -548.8, 66 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2577.5, -183.6, -62 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2617.1, -305.4, -62 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2656.6, -427.1, -62 ), ( 0, 18, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 2696.2, -548.8, -62 ), ( 0, 18, 0 ) );
}

uppertreeclip()
{
    var_0 = ( 0, 344, 0 );
    var_1 = ( -20, -2700, 302 );
    var_2 = 0;

    for ( var_3 = 0; var_3 < 8; var_3++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", var_1 + ( 0, 0, var_2 ), var_0 );
        var_2 += 128;
    }
}

constructionclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894, -704, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150, -704, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406, -704, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662, -704, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774, -840, 766 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774, -1096, 766 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802, -840, 766 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802, -1096, 766 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894, -704, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1252, -908, 766 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150, -704, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406, -704, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894, -790, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150, -790, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406, -790, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662, -790, 766 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662, -704, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774, -840, 1022 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774, -1096, 1022 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802, -840, 1022 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802, -1096, 1022 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1252, -908, 1022 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894, -790, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150, -790, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406, -790, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662, -790, 1022 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894, -704, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150, -704, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406, -704, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662, -704, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774, -840, 1278 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 774, -1096, 1278 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802, -840, 1278 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 802, -1096, 1278 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1252, -908, 1278 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 894, -790, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1150, -790, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1406, -790, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1662, -790, 1278 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1544, -726, 572 ), ( 0, 262, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1292, -708, 572 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1156, -708, 572 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 904, -726, 572 ), ( 0, 278, 0 ) );
}

damcustomairstrike()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 1750;
}

damcustomkillstreakfunc()
{
    level.killstreakweildweapons["mp_dam_railgun"] = 1;
    level.killstreakweildweapons["dam_turret_mp"] = 1;
    level thread maps\mp\killstreaks\streak_mp_dam::init();
}

damcustomospfunc()
{
    level.orbitalsupportoverrides.spawnorigin = ( 1544, 1016, 200 );
    level.orbitalsupportoverrides.spawnangle = 120;
    level.orbitalsupportoverrides.spawnradius = undefined;
    level.orbitalsupportoverrides.spawnheight = undefined;
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
    var_3 setdefaultdroppitch( 45.0 );
    var_3.health = 99999;
    var_3.maxhealth = 1000;
    var_3.damagetaken = 0;
    var_3.stunned = 0;
    var_3.stunnedtime = 0.0;
    var_3 setcandamage( 0 );
    var_3 setcanradiusdamage( 0 );
    var_3 setmode( "manual" );
    level.damdefaultaiment = getent( "DamTurretDefaultTarget", "targetname" );
    var_3 settargetentity( level.damdefaultaiment );
    return var_3;
}

setupcraneanimations()
{
    precachempanim( "dam_crane01_idle_l" );
    precachempanim( "dam_crane01_idle_r" );
    precachempanim( "dam_crane01_l_2_r" );
    precachempanim( "dam_crane01_r_2_l" );
    precachempanim( "dam_crane02_idle_l" );
    precachempanim( "dam_crane02_idle_r" );
    precachempanim( "dam_crane02_l_2_r" );
    precachempanim( "dam_crane02_r_2_l" );
    precachempanim( "dam_crane01_tag_idle_l" );
    precachempanim( "dam_crane01_tag_idle_r" );
    precachempanim( "dam_crane01_tag_l_2_r" );
    precachempanim( "dam_crane01_tag_r_2_l" );
    precachempanim( "dam_crane02_tag_idle_l" );
    precachempanim( "dam_crane02_tag_idle_r" );
    precachempanim( "dam_crane02_tag_l_2_r" );
    precachempanim( "dam_crane02_tag_r_2_l" );
    precachempanim( "dam_crane01_collisiontest" );
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
    var_2 vehicle_jetbikesethoverforcescale( var_0, "tag_origin" );
    var_3 handle_trigger_updateto( var_2 );
    var_5.angles += ( 0, -249.215, 0 );
    var_5 vehicle_jetbikesethoverforcescale( var_4, "tag_origin" );
    var_6 = 20;
    var_7 = ( 2181, -1069, 1407 );
    thread aud_play_crane_sfx( var_7, var_6, "crane_01" );

    for (;;)
    {
        var_0 scriptmodelclearanim();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 scriptmodelclearanim();
        var_1 scriptmodelplayanimdeltamotion( "dam_crane01_l_2_r" );
        var_0 scriptmodelplayanimdeltamotion( "dam_crane01_tag_l_2_r" );
        var_4 scriptmodelplayanimdeltamotion( "dam_crane01_tag_base_l_2_r" );
        wait(var_6);
        var_0 scriptmodelclearanim();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 scriptmodelclearanim();
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
    var_7 = ( 849, 2315, 1455 );
    thread aud_play_crane_sfx( var_7, var_6, "crane_02" );
    var_2 vehicle_jetbikesethoverforcescale( var_0, "tag_origin" );
    var_3 handle_trigger_updateto( var_2 );
    var_5.angles += ( 0, -117.312, 0 );
    var_5 vehicle_jetbikesethoverforcescale( var_4, "tag_origin" );

    for (;;)
    {
        var_0 scriptmodelclearanim();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 scriptmodelclearanim();
        var_1 scriptmodelplayanimdeltamotion( "dam_crane02_l_2_r" );
        var_0 scriptmodelplayanimdeltamotion( "dam_crane02_tag_l_2_r" );
        var_4 scriptmodelplayanimdeltamotion( "dam_crane02_tag_base_l_2_r" );
        wait(var_6);
        var_0 scriptmodelclearanim();
        var_0.origin = var_1.origin;
        var_0.angles = var_1.angles;
        var_4 scriptmodelclearanim();
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
    childthread movetrig( var_0, var_1, var_2 );
}

movetrig( var_0, var_1, var_2 )
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
        self.cab rotateto( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.platform rotateto( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.pipe rotateto( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.pulley rotateto( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.hook rotateto( ( 0, getdvarint( self.end_angle_dvar, 180 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.heightoscillator moveto( ( 0, 0, getdvarint( self.pipe_end_height_dvar, 0 ) ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.radiusoscillator moveto( ( 0, 0, getdvarint( self.pipe_end_radius_dvar, 0 ) ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        wait(getdvarint( self.time_dvar, 10 ) + 5);
        self.cab rotateto( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.platform rotateto( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.pipe rotateto( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.pulley rotateto( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
        self.hook rotateto( ( 0, getdvarint( self.start_angle_dvar, 130 ), 0 ), getdvarint( self.time_dvar, 10 ), 1, 1 );
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
        self.pipe moveto( var_0, 0.05, 0.025, 0.025 );
        self.pulley moveto( ( var_0[0], var_0[1], self.pulley.origin[2] ), 0.05, 0.025, 0.025 );
        self.hook moveto( var_0 + ( 0, 0, 270 ), 0.05, 0.025, 0.025 );
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

handle_glass_pathing()
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
                var_8.glass_id = var_5;
                break;
            }
        }
    }

    common_scripts\utility::array_thread( var_1, ::handle_pathing_on_glass );
}

handle_pathing_on_glass()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return 0;

    var_0 common_scripts\utility::trigger_off();
    var_0 connectpaths();
    waittill_glass_break( self.glass_id );
    var_0 common_scripts\utility::trigger_on();
    var_0 disconnectpaths();
    var_0 common_scripts\utility::trigger_off();
}

waittill_glass_break( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( isglassdestroyed( var_0 ) )
            return 1;

        wait 0.05;
    }
}
