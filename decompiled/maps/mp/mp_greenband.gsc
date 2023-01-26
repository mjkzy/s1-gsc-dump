// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A766::main();
    _id_A6CB::main();
    _id_A765::main();
    maps\mp\_load::main();
    thread _id_804D();
    maps\mp\_compass::_id_831E( "compass_map_mp_greenband" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_diffuseColorScale", 1.5 );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );
    level._id_65AB = "(mp_greenband_osp)";
    level._id_65A9 = "(mp_greenband_osp)";
    level._id_2F3B = "(mp_greenband_drone)";
    level._id_2F12 = "(mp_greenband_drone)";
    level._id_A197 = "(mp_greenband_warbird)";
    level._id_A18C = "(mp_greenband_warbird)";
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if ( level.nextgen )
        level._id_088A = 600;

    level thread _id_A75F::init();
    level thread _id_43D6();

    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 2500;
    level._id_6573 = ::_id_43D7;
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    level thread greenbandpatchclip();
}

greenbandpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1722.0, -3380.0, 128.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1722.0, -3380.0, 384.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1722.0, -3380.0, 640.0 ), ( 0.0, 270.0, 0.0 ) );
}

_id_43D7()
{
    level._id_6574._id_89DC = 9279;
    level._id_6574._id_8A00 = 7000;
    level._id_6574._id_99B1 = 50;
    level._id_6574._id_898B = undefined;
    level._id_6574._id_898A = undefined;

    if ( level.currentgen )
        level._id_6574._id_04BD = -40;
}

_id_804D()
{
    ambientplay( "amb_gnb_ext" );
}

_id_43D6()
{
    level._id_2F19 = [];
    level thread _id_0B3C();
    level thread _id_9E89();
    level thread _id_9E8A();
}

_id_8936( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstruct( "event_anim_node", "targetname" );
    var_4 = _id_8935( var_0 );

    if ( isdefined( var_2 ) )
    {
        for (;;)
        {
            var_4.health = 20;
            var_4 setcandamage( 1 );
            var_4 thread _id_6E28( var_1, var_2, var_0, var_3 );
            var_4 waittill( "death" );
            var_4 hide();
            playfx( level._effect["vehicle_pdrone_explosion"], var_4.origin );
            playsoundatpos( var_4.origin, "mp_greenband_drone_exp" );
            var_4 waittillmatch( "event_police_drone", "enter_start" );
            var_4 show();
            var_4 thread _id_6E27();
        }
    }
    else
        var_4 thread _id_6E28( var_1, undefined, var_0, var_3 );
}

_id_6E28( var_0, var_1, var_2, var_3 )
{
    self notify( "police_drone_play_anim" );
    self endon( "police_drone_play_anim" );
    self _meth_827A();

    if ( isdefined( var_1 ) )
    {
        self _meth_848B( var_1, var_3.origin, var_3.angles, "event_police_drone" );
        self waittillmatch( "event_police_drone", "end" );
    }

    self _meth_848B( var_0, var_3.origin, var_3.angles, "event_police_drone" );
}

_id_8935( var_0 )
{
    var_1 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_1.angles = ( 0.0, 0.0, 0.0 );
    var_1.destroyed = 0;
    var_1._id_2F35 = var_0;

    if ( !isdefined( level._id_2F19[var_0] ) )
        level._id_2F19[var_0] = [];

    level._id_2F19[var_0][level._id_2F19[var_0].size] = var_1;

    switch ( var_0 )
    {
        case "test":
        case "ambient":
            var_1._id_56FF = "mp_gb_drone_blink_nt";
            var_1._id_340C = "mp_gb_drone_trail";
            var_1 setmodel( "vehicle_police_drone_01_anim" );
            var_1 playloopsound( "mp_gnb_police_drone_hover_lp" );
            break;
        case "vista":
            var_1._id_56FF = "mp_gb_drone_blink_vista";
            var_1._id_340C = "mp_gb_drone_trail_vista";
            var_1 setmodel( "vehicle_police_drone_01_simple_anim" );
            break;
        case "vista_group":
            var_1._id_56FF = "mp_gb_drone_hd_grp";
            var_1._id_340C = "mp_gb_drone_trail_grp";
            var_1 setmodel( "vehicle_police_drone_01_group_anim" );
            var_1 playloopsound( "mp_gnb_drone_group_flyby" );
            break;
        default:
            break;
    }

    var_1 thread _id_6E27();
    return var_1;
}

_id_6E27()
{
    self endon( "death" );
    thread _id_6E29( self._id_56FF, "tag_lights" );
    thread _id_6E29( self._id_340C, "tag_exhaust" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        thread _id_6E29( self._id_56FF, "tag_lights", var_0 );
        thread _id_6E29( self._id_340C, "tag_exhaust", var_0 );
    }
}

_id_6E29( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_2 ) )
        var_2 endon( "death" );

    waitframe();
    var_3 = [ var_1 ];

    if ( self._id_2F35 == "vista_group" )
    {
        for ( var_4 = 1; var_4 < 5; var_4++ )
            var_3[var_3.size] = var_1 + "" + var_4;
    }

    foreach ( var_6 in var_3 )
    {
        if ( isdefined( var_2 ) )
            playfxontagforclients( level._effect[var_0], self, var_6, var_2 );
        else
            playfxontag( level._effect[var_0], self, var_6 );

        waitframe();
    }
}

_id_9E8A()
{
    level thread _id_8936( "vista_group", "mp_gb_drone_vista_group_01" );
    level thread _id_8936( "vista_group", "mp_gb_drone_vista_group_02" );
}

_id_9E89()
{
    level thread _id_8936( "vista", "mp_gb_drone_vista_01" );
    level thread _id_8936( "vista", "mp_gb_drone_vista_02" );
    level thread _id_8936( "vista", "mp_gb_drone_vista_03" );
    level thread _id_8936( "vista", "mp_gb_drone_vista_04" );
}

_id_0B3C()
{
    level thread _id_8936( "ambient", "mp_gb_drone_circle_01", "mp_gb_drone_circle_01_enter" );
    level thread _id_8936( "ambient", "mp_gb_drone_circle_02", "mp_gb_drone_circle_02_enter" );
    level thread _id_8936( "ambient", "mp_gb_drone_circle_03", "mp_gb_drone_circle_03_enter" );
    level thread _id_8936( "ambient", "mp_gb_drone_circle_04", "mp_gb_drone_circle_04_enter" );
    level thread _id_0B3B();
}

_id_0B3B()
{
    for (;;)
    {
        foreach ( var_1 in level._id_2F19["ambient"] )
        {
            if ( !var_1.destroyed )
            {
                wait(randomfloatrange( 7, 15 ));
                var_1 playsound( "mp_gnb_police_drone_chatter" );
            }
        }

        wait 1;
    }
}
