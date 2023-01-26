// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4CEC()
{
    var_0 = spawnstruct();
    var_0._id_3A05 = getent( "firingrange_start", "targetname" );
    var_0._id_0AB9 = _id_37FD();
    var_0._id_09EA = _id_37F7();
    var_0._id_970E = [];
    var_0._id_970F = [];
    var_0._id_0ABA = _id_37FE();
    var_0._id_0AB8 = _id_37FB();
    var_0._id_0AB7 = _id_37FA();
    var_0._id_09E6 = _id_37F6();
    var_0._id_0AB6 = _id_37FC();
    var_0._id_0A65 = _id_37F9();
    var_0._id_0ABB = _id_37F8();
    var_0._id_09E5 = _id_37F5();
    var_0._id_10F1 = common_scripts\utility::getstruct( "audio_buzzer_org", "targetname" );
    var_0._id_88A5 = [];
    var_0._id_555D = undefined;
    var_0._id_91A9 = 32;
    var_0._id_91B8 = 256;
    var_0._id_6F22 = 0;
    var_0._id_6F21 = 0;
    var_0._id_7655 = undefined;
    var_0._id_5C82 = undefined;
    var_0._id_5C83 = undefined;
    var_0._id_5A4B = undefined;
    var_0._id_1965 = 0.55;
    var_0._id_1964 = 0;
    var_0._id_42EF = 24;
    var_0._id_2597 = 0;
    var_0._id_7131 = 0;
    var_0._id_8445 = 0;
    var_0._id_8446 = 0;
    var_0._id_67C2 = 0;
    var_0._id_84B4 = 0;
    var_0._id_7611 = 176;
    var_0.time = 0;
    var_0._id_4438 = 5;
    var_0._id_764C = 0;
    var_0._id_51A3 = 0;
    var_0._id_9DFC = loadfx( "vfx/props/holo_target_red_spawn_in" );
    var_0._id_9DFD = loadfx( "vfx/props/holo_target_red_spawn_out" );
    var_0._id_9DFB = loadfx( "vfx/beam/firing_range_edge_glow" );
    common_scripts\utility::array_thread( var_0._id_0ABA, ::_id_97E3 );
    level._id_9194 = ( 1.3, 0.0, 25.0 );
    level._id_91AD = 12;
    level._id_491B = 18;
    level._id_3804 = var_0;
}

_id_37F9()
{
    var_0 = getentarray( "holo_emitter_floor", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2._id_6388 = var_2.origin;
        var_2._id_9A92 = var_2.origin + ( 0.0, 0.0, 4.0 );
    }

    return var_0;
}

_id_37F5()
{
    var_0 = getentarray( "display_3dui_mesh", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();

    return var_0;
}

_id_37FB()
{
    var_0 = common_scripts\utility::getstructarray( "target_track_min", "targetname" );
    return var_0;
}

_id_37FA()
{
    var_0 = common_scripts\utility::getstructarray( "target_track_max", "targetname" );
    return var_0;
}

_id_37F6()
{
    var_0 = common_scripts\utility::getstructarray( "booth_display_01", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "booth_display_02", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "booth_display_03", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "booth_display_04", "targetname" );
    var_4 = common_scripts\utility::getstructarray( "booth_display_05", "targetname" );
    var_5 = common_scripts\utility::getstructarray( "booth_display_06", "targetname" );
    var_6 = [ var_0, var_1, var_2, var_3, var_4, var_5 ];
    return var_6;
}

_id_97E3()
{
    var_0 = self;
    var_0 thread common_scripts\_dynamic_world::triggertouchthink( ::_id_6AE7, ::_id_6B83 );
}

_id_6AE7( var_0 )
{
    level endon( "shutdown_hologram" );

    while ( level._id_3804._id_51A3 == 1 )
        wait 0.1;

    var_1 = self;

    if ( !isdefined( var_0.script_index ) )
        return;

    var_2 = int( var_0.script_index );
    level._id_3804._id_7655 = var_2;

    if ( !isdefined( level._id_3804._id_09EA[var_2] ) )
        return;

    var_1 thread _id_8D36( var_2 );
}

_id_6B83( var_0 )
{
    var_1 = self;

    if ( !isdefined( var_0.script_index ) )
        return;

    var_2 = int( var_0.script_index );
    level._id_3804._id_7655 = var_2;

    if ( !isdefined( level._id_3804._id_09EA[var_2] ) )
        return;

    thread _id_854A( var_2, var_1 );
}

_id_8733( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_origin", var_1.origin );
    var_4 linktosynchronizedparent( var_1 );
    var_4 thread maps\mp\_audio::_id_87AE( var_0, var_1, var_2, var_3 );

    if ( !isdefined( level._id_3804._id_88A5 ) )
        level._id_3804._id_88A5 = [];
    else
        level._id_3804._id_88A5 = common_scripts\utility::add_to_array( level._id_3804._id_88A5, var_4 );

    return var_4;
}

_id_91D4( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = self;
    var_2 = level._id_3804._id_0AB9[var_0][0][0];
    var_2._id_09DC = 1;
    thread maps\mp\_audio::_id_8730( "mp_shooting_range_panels_bell", level._id_3804._id_10F1.origin );
    var_2 _id_8A0A();
    var_2 show();
    var_2 solid();
    var_2 setcandamage( 1 );
    var_2 setdamagecallbackon( 1 );
    var_2.damagecallback = ::monitordamagecallback;
    var_2.health = 9999;
    var_2.maxhealth = 9999;
    var_2 _meth_8029();

    foreach ( var_4 in level._id_3804._id_0AB8 )
    {
        if ( var_4.script_index == level._id_3804._id_7655 )
        {
            level._id_3804._id_5C82 = var_4;
            break;
        }
    }

    foreach ( var_4 in level._id_3804._id_0AB7 )
    {
        if ( var_4.script_index == level._id_3804._id_7655 )
        {
            level._id_3804._id_5A4B = var_4;
            break;
        }
    }

    if ( !isdefined( level._id_3804._id_5C82 ) || !isdefined( level._id_3804._id_5A4B ) )
    {
        thread _id_854A( var_0, var_1 );
        return;
    }

    level._id_3804._id_5C83 = level._id_3804._id_5C82.origin + anglestoforward( level._id_3804._id_5C82.angles ) * -64;
    var_2 thread _id_5E47( var_1, var_2, level._id_3804._id_5C82 );
    thread _id_5EBE( var_1 );
    thread monitorgrenades( var_1 );
    thread _id_5E6C( var_1 );
    thread _id_2B5A( var_1, var_0 );
    var_1 thread _id_6238( var_2 );
}

_id_5E47( var_0, var_1, var_2 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );
    self endon( "death" );
    var_3 = 0.0254;

    for (;;)
    {
        if ( !isdefined( var_1 ) || !isdefined( var_2 ) )
        {
            level._id_3804._id_7131 = 0;
            var_0 setclientomnvar( "ui_vlobby_round_distance", level._id_3804._id_7131 );
        }
        else
        {
            var_4 = distance2d( var_1.origin, var_2.origin );
            var_5 = int( maps\mp\_utility::rounddecimalplaces( var_3 * var_4, 0 ) );

            if ( var_5 != level._id_3804._id_7131 )
            {
                if ( var_5 > 100 )
                    var_5 = 100;
                else if ( var_5 < 0 )
                    var_5 = 0;

                level._id_3804._id_7131 = var_5;
                var_0 setclientomnvar( "ui_vlobby_round_distance", level._id_3804._id_7131 );
            }
        }

        wait 0.05;
    }
}

_id_6238( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );
    self notifyonplayercommand( "toggled_up_pressed", "+actionslot 1" );
    self notifyonplayercommand( "toggled_up_released", "-actionslot 1" );
    self notifyonplayercommand( "toggled_down_pressed", "+actionslot 2" );
    self notifyonplayercommand( "toggled_down_released", "-actionslot 2" );
    thread _id_5ED9( var_0 );
    thread _id_5EDA( var_0 );
    thread _id_5E4A( var_0 );
    thread _id_5E4B( var_0 );
    thread _id_5F7C( var_0, self );
}

_id_5ED9( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_up_pressed" );
        level._id_3804._id_1964 = level._id_3804._id_1965;

        if ( level._id_3804._id_6F22 == 0 )
        {
            level._id_3804._id_6F22 = 1;
            level._id_3804._id_6F21 = 0;
            thread _id_5F51( level._id_3804._id_5A4B.origin, var_0, self );
        }
    }
}

_id_5EDA( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_up_released" );
        var_1 = distance2d( level._id_3804._id_5A4B.origin, var_0.origin );

        if ( var_1 <= 1 )
            var_0 moveto( var_0.origin, 0.05 );
        else
        {
            var_2 = var_0.origin + anglestoforward( level._id_3804._id_0AB7[0].angles ) * level._id_3804._id_42EF * -1;
            var_1 = distance2d( var_2, var_0.origin );
            var_3 = var_1 / level._id_3804._id_91B8;

            if ( var_3 < 0.05 )
                var_3 = 0.05;

            level._id_3804._id_1964 = var_3 + 0.05;
            thread _id_5F51( var_2, var_0, self );
        }

        var_0 waittill( "movedone" );
        level._id_3804._id_6F22 = 0;
    }
}

_id_5E4A( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_down_pressed" );
        level._id_3804._id_1964 = level._id_3804._id_1965;

        if ( level._id_3804._id_6F21 == 0 )
        {
            level._id_3804._id_6F21 = 1;
            level._id_3804._id_6F22 = 0;
            thread _id_5F51( level._id_3804._id_5C83, var_0, self );
        }
    }
}

_id_5E4B( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_down_released" );
        var_1 = distance2d( level._id_3804._id_5C83, var_0.origin );

        if ( var_1 <= 1 )
            var_0 moveto( var_0.origin, 0.05 );
        else
        {
            var_2 = var_0.origin + anglestoforward( level._id_3804._id_0AB7[0].angles ) * level._id_3804._id_42EF;
            var_1 = distance2d( var_2, var_0.origin );
            var_3 = var_1 / level._id_3804._id_91B8;

            if ( var_3 < 0.05 )
                var_3 = 0.05;

            level._id_3804._id_1964 = var_3 + 0.05;
            thread _id_5F51( var_2, var_0, self );
        }

        var_0 waittill( "movedone" );
        level._id_3804._id_6F21 = 0;
    }
}

_id_5F51( var_0, var_1, var_2 )
{
    var_3 = distance2d( var_0, var_1.origin );

    if ( var_3 <= 1 )
    {
        var_1 notify( "movedone" );
        return;
    }
    else
    {
        var_4 = var_3 / level._id_3804._id_91B8;

        if ( var_4 < 0.05 )
            var_4 = 0.05;

        var_1 moveto( var_0, var_4 );
    }
}

_id_5F7C( var_0, var_1 )
{
    var_1 endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        wait 0.05;

        if ( level._id_3804._id_6F21 == 1 || level._id_3804._id_6F22 == 1 )
        {
            if ( level._id_3804._id_1964 > 0 )
            {
                level._id_3804._id_1964 -= 0.05;
                continue;
            }

            var_0 moveto( var_0.origin, 0.05 );
            level._id_3804._id_6F21 = 0;
            level._id_3804._id_6F22 = 0;
        }
    }
}

_id_5E3C( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );
    var_1 = undefined;
    var_2 = var_0;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( level._id_3804._id_7655 == 7 )
            self.health = self.maxhealth;

        var_11 = self gettagorigin( "tag_chest" );
        thread maps\mp\_audio::_id_8730( "mp_shooting_range_red_hit", var_11 );
        var_12 = _id_4026( var_10, var_8, var_0 );
        var_1 = maps\mp\_utility::rounddecimalplaces( float( var_1 ) * var_12, 0 );
        var_1 = int( var_1 );

        if ( var_1 > 999 )
            var_1 = 999;

        if ( var_1 < 0 )
            var_1 = 0;

        level._id_3804._id_2597 = var_1;
        var_13 = level._id_3804._id_8446 + 1;

        if ( var_13 > 9999 )
            level._id_3804._id_8446 = 0;
        else if ( var_13 < 0 )
            level._id_3804._id_8446 = 0;
        else
            level._id_3804._id_8446 = var_13;

        level._id_3804._id_84B4 = 1;
    }
}

monitordamagecallback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( self ) )
        return;

    if ( level._id_3804._id_7655 == 7 )
        self.health = self.maxhealth;

    var_12 = self gettagorigin( "tag_chest" );
    thread maps\mp\_audio::_id_8730( "mp_shooting_range_red_hit", var_12 );
    var_13 = 1;

    if ( isdefined( var_1 ) )
        var_13 = _id_4026( var_5, var_11, var_1 );

    var_2 = maps\mp\_utility::rounddecimalplaces( float( var_2 ) * var_13, 0 );
    var_2 = int( var_2 );

    if ( var_2 > 999 )
        var_2 = 999;

    if ( var_2 < 0 )
        var_2 = 0;

    level._id_3804._id_2597 = var_2;

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_0 ) && var_0 != var_1 )
        {
            if ( !isdefined( var_0.damage_counted ) )
            {
                var_0.damage_counted = 1;
                var_14 = level._id_3804._id_8446 + 1;

                if ( var_14 > 9999 )
                    level._id_3804._id_8446 = 0;
                else if ( var_14 < 0 )
                    level._id_3804._id_8446 = 0;
                else
                    level._id_3804._id_8446 = var_14;

                level._id_3804._id_84B4 = 1;
            }
        }
        else
            var_1 thread countdamagingshots();
    }

    level._id_3804._id_84B4 = 1;
}

countdamagingshots()
{
    level endon( "shutdown_hologram" );
    self endon( "disconnect" );

    if ( !isdefined( self.damagingshot ) )
        self.damagingshot = 1;
    else
        self.damagingshot++;
}

_id_4026( var_0, var_1, var_2 )
{
    var_3 = "none";
    var_4 = 1;
    var_5 = strtok( var_0, "_" );
    var_6 = var_5[0] + "_" + var_5[1];

    if ( var_0 != "specialty_null" && var_0 != "none" && var_0 != "iw5_combatknife_mp" )
    {
        if ( maps\mp\gametypes\_class::isvalidprimary( var_6 ) || maps\mp\gametypes\_class::isvalidsecondary( var_6, 0 ) )
        {
            if ( var_1 == "tag_head" )
                var_3 = "head";
            else if ( var_1 == "tag_chest" )
                var_3 = "torso_upper";
            else if ( var_1 == "tag_arms" )
                var_3 = "right_arm_upper";
            else if ( var_1 == "tag_legs" )
                var_3 = "torso_lower";
            else
                var_3 = "none";

            var_4 = var_2 _meth_850A( var_6 + "_mp", var_3 );
            return var_4;
        }
        else
            return var_4;
    }
    else
        return var_4;
}

waitforweaponfired()
{
    self endon( "disconnect" );
    self endon( "reload" );
    self endon( "weapon_change" );
    var_0 = 0;
    var_1 = self _meth_82F0( "right" );
    var_2 = self _meth_82F0( "left" );
    self waittill( "weapon_fired" );
    var_0 = 1;
    var_3 = self _meth_82F0( "right" );
    var_4 = self _meth_82F0( "left" );
    var_5 = var_1 - var_3 + var_2 - var_4;

    if ( var_5 > 0 )
        var_0 = var_5;

    return var_0;
}

_id_5EBE( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        var_0.damagingshot = 0;
        var_1 = var_0 waitforweaponfired();

        if ( isdefined( var_1 ) )
        {
            var_2 = level._id_3804._id_8445 + var_1;

            if ( var_2 > 9999 )
            {
                level._id_3804._id_8445 = 0;
                level._id_3804._id_8446 = 0;
                level._id_3804._id_67C2 = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level._id_3804._id_8446 );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level._id_3804._id_8445 );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level._id_3804._id_67C2 );
            }
            else if ( var_2 < 0 )
            {
                level._id_3804._id_8445 = 0;
                level._id_3804._id_8446 = 0;
                level._id_3804._id_67C2 = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level._id_3804._id_8446 );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level._id_3804._id_8445 );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level._id_3804._id_67C2 );
            }
            else
            {
                level._id_3804._id_84B4 = 1;
                level._id_3804._id_8445 = var_2;
            }

            if ( isdefined( var_0.damagingshot ) )
            {
                var_3 = var_0.damagingshot;

                if ( var_1 < var_0.damagingshot )
                    var_3 = var_1;

                var_4 = level._id_3804._id_8446 + var_3;

                if ( var_4 > 9999 )
                    level._id_3804._id_8446 = 0;
                else if ( var_4 < 0 )
                    level._id_3804._id_8446 = 0;
                else
                    level._id_3804._id_8446 = var_4;

                var_0.damagingshot = 0;
            }
        }
    }
}

monitorgrenades( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        var_0 waittill( "grenade_fire", var_1 );

        if ( isdefined( var_1 ) )
        {
            waittillframeend;

            if ( isdefined( var_1.recall ) && var_1.recall )
                continue;

            var_2 = level._id_3804._id_8445 + 1;

            if ( var_2 > 9999 )
            {
                level._id_3804._id_8445 = 0;
                level._id_3804._id_8446 = 0;
                level._id_3804._id_67C2 = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level._id_3804._id_8446 );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level._id_3804._id_8445 );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level._id_3804._id_67C2 );
            }
            else if ( var_2 < 0 )
            {
                level._id_3804._id_8445 = 0;
                level._id_3804._id_8446 = 0;
                level._id_3804._id_67C2 = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level._id_3804._id_8446 );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level._id_3804._id_8445 );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level._id_3804._id_67C2 );
            }
            else
            {
                level._id_3804._id_84B4 = 1;
                level._id_3804._id_8445 = var_2;
            }
        }
    }
}

_id_5E6C( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        if ( level._id_3804._id_8445 > 0 )
        {
            var_1 = level._id_3804._id_8446 / level._id_3804._id_8445 * 100;
            var_1 = maps\mp\_utility::rounddecimalplaces( var_1, 0 );

            if ( var_1 != level._id_3804._id_67C2 )
            {
                if ( var_1 > 999 )
                    var_1 = 999;
                else if ( var_1 < 0 )
                    var_1 = 0;

                level._id_3804._id_67C2 = int( var_1 );
                level._id_3804._id_84B4 = 1;
            }
        }

        wait 0.05;
    }
}

_id_2B5A( var_0, var_1 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );
    var_2 = _id_377D( level._id_3804._id_09E5, var_1 );

    if ( isdefined( var_2 ) )
        var_2 show();

    for (;;)
    {
        if ( level._id_3804._id_84B4 == 1 )
        {
            var_0 setclientomnvar( "ui_vlobby_round_damage", level._id_3804._id_2597 );
            var_0 setclientomnvar( "ui_vlobby_round_hits", level._id_3804._id_8446 );
            var_0 setclientomnvar( "ui_vlobby_round_fired", level._id_3804._id_8445 );
            var_0 setclientomnvar( "ui_vlobby_round_accuracy", level._id_3804._id_67C2 );
            level._id_3804._id_84B4 = 0;
        }

        wait 0.2;
    }
}

_id_377D( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_index ) && var_3.script_index == var_1 )
            return var_3;
    }
}

_id_8D36( var_0 )
{
    level endon( "shutdown_hologram" );
    level notify( "start_round" );
    level._id_3804._id_2597 = 0;
    level._id_3804._id_7131 = 0;
    level._id_3804.time = 0;
    level._id_3804._id_764C = 1;
    level._id_3804._id_84B4 = 1;
    self setclientomnvar( "ui_vlobby_round_distance", level._id_3804._id_7131 );
    self setclientomnvar( "ui_vlobby_round_damage", level._id_3804._id_2597 );
    self setclientomnvar( "ui_vlobby_round_hits", level._id_3804._id_8446 );
    self setclientomnvar( "ui_vlobby_round_fired", level._id_3804._id_8445 );
    self setclientomnvar( "ui_vlobby_round_accuracy", level._id_3804._id_67C2 );

    foreach ( var_2 in level._id_3804._id_0AB9[var_0] )
    {
        foreach ( var_4 in var_2 )
        {
            var_4.origin = var_4._id_659E;
            var_4.angles = var_4._id_659C;
        }
    }

    foreach ( var_8 in level._id_3804._id_0A65 )
        var_8 thread _id_5F4D();

    thread _id_8733( "mp_shooting_range_panels_up", self );
    thread _id_569D( "lt_shootingrange_bounce", 0.25, 0.01 );

    if ( level.nextgen )
    {
        thread _id_569E( "lt_shootingrange", 0.25, 0.01 );
        thread _id_569D( "lt_hologram_blue", 0.25, 3000 );
    }
    else
        thread _id_569D( "lt_hologram_blue", 0.25, 60000 );

    wait 0.5;
    var_10 = 0;

    foreach ( var_12 in level._id_3804._id_0ABB[var_0] )
    {
        if ( level.nextgen )
            thread _id_669E( level._id_3804._id_9DFB, var_12.origin, var_12.angles, undefined, 1 );
        else if ( var_10 % 2 == 0 )
            thread _id_669E( level._id_3804._id_9DFB, var_12.origin, var_12.angles, undefined, 1 );

        var_10++;
    }

    if ( level.nextgen )
    {
        _id_8530( var_0 );
        wait 0.1;
        _id_38DA( level._id_3804._id_970E );
        wait 0.1;
        _id_38DA( level._id_3804._id_970E );
        wait 0.1;
        _id_8532( level._id_3804._id_970E );
        _id_487E();
        wait 0.4;
        _id_8524( var_0 );
        wait 0.1;
        _id_2871();
    }
    else
    {
        var_14 = _id_8531( var_0 );
        wait 0.1;
        _id_38DA( level._id_3804._id_09EA[var_0] );
        _id_38DA( level._id_3804._id_09EA[var_0] );
        wait 0.1;
        _id_38DA( level._id_3804._id_09EA[var_0] );
        wait 0.1;
        _id_487F( var_0, var_14 );
        wait 0.1;
        _id_8524( var_0 );
    }

    thread _id_8733( "mp_shooting_range_appear", self );

    if ( var_0 == 7 )
    {
        self setclientomnvar( "ui_vlobby_round_state", 3 );
        thread _id_91D4( var_0 );
    }
    else
    {
        self setclientomnvar( "ui_vlobby_round_state", 1 );
        thread _id_0705( var_0 );
    }
}

_id_8524( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = maps\mp\_utility::rounddecimalplaces( level._id_3804._id_09EA[var_0].size / level._id_3804._id_4438, 0, "up" );
    var_2 = 0;

    foreach ( var_4 in level._id_3804._id_09EA[var_0] )
    {
        var_4 show();
        var_4 solid();
    }
}

_id_8532( var_0 )
{
    level endon( "shutdown_hologram" );
    level._id_3804._id_970F = [];

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !_func_294( var_2 ) && isdefined( var_2.classname ) && var_2.classname == "script_model" )
        {
            if ( isdefined( var_2.model ) && issubstr( var_2.model, "_trans" ) )
            {
                var_3 = var_2.model + "_rev";
                var_4 = spawn( "script_model", var_2.origin );
                level._id_3804._id_970F[level._id_3804._id_970F.size] = var_4;

                if ( isdefined( var_2.angles ) )
                    var_4.angles = var_2.angles;
                else
                    var_4.angles = ( 0.0, 0.0, 0.0 );

                var_4 setmodel( var_3 );
                var_4 notsolid();
            }
        }
    }
}

_id_8530( var_0 )
{
    level endon( "shutdown_hologram" );
    level._id_3804._id_970E = [];

    foreach ( var_2 in level._id_3804._id_09EA[var_0] )
    {
        if ( isdefined( var_2.classname ) && var_2.classname == "script_model" )
        {
            if ( isdefined( var_2.model ) && issubstr( var_2.model, "rec_holo_range" ) )
            {
                var_3 = var_2.model + "_trans";
                var_4 = spawn( "script_model", var_2.origin );
                level._id_3804._id_970E[level._id_3804._id_970E.size] = var_4;

                if ( isdefined( var_2.angles ) )
                    var_4.angles = var_2.angles;
                else
                    var_4.angles = ( 0.0, 0.0, 0.0 );

                var_4 setmodel( var_3 );
                var_4 notsolid();
            }
        }
    }
}

_id_38DA( var_0 )
{
    level endon( "shutdown_hologram" );

    if ( isdefined( var_0 ) && isarray( var_0 ) )
    {
        _id_4877( var_0 );
        wait 0.05;
        _id_8518( var_0 );
        wait 0.05;
    }
}

_id_8518( var_0 )
{
    level endon( "shutdown_hologram" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !_func_294( var_2 ) )
        {
            var_2 show();
            var_2 notsolid();
        }
    }
}

_id_4877( var_0 )
{
    level endon( "shutdown_hologram" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !_func_294( var_2 ) )
        {
            var_2 hide();
            var_2 notsolid();
        }
    }
}

_id_487E()
{
    if ( isarray( level._id_3804._id_970E ) )
    {
        level._id_3804._id_970E = common_scripts\utility::array_remove_duplicates( level._id_3804._id_970E );

        foreach ( var_1 in level._id_3804._id_970E )
        {
            if ( isdefined( var_1 ) && !_func_294( var_1 ) )
            {
                var_1 hide();
                var_1 notsolid();
            }
        }
    }
}

_id_2871()
{
    if ( isarray( level._id_3804._id_970F ) )
    {
        level._id_3804._id_970F = common_scripts\utility::array_remove_duplicates( level._id_3804._id_970F );

        foreach ( var_1 in level._id_3804._id_970F )
        {
            if ( isdefined( var_1 ) && !_func_294( var_1 ) )
                var_1 delete();
        }
    }

    level._id_3804._id_970F = [];
}

_id_73E1()
{
    if ( isarray( level._id_3804._id_970E ) )
    {
        var_0 = common_scripts\utility::array_remove_duplicates( level._id_3804._id_970E );
        _id_38DA( var_0 );
        _id_38DA( var_0 );
        wait 0.1;
        _id_38DA( var_0 );
        wait 0.1;
        _id_38DA( var_0 );

        foreach ( var_2 in var_0 )
        {
            if ( isdefined( var_2 ) && !_func_294( var_2 ) )
                var_2 delete();
        }
    }
}

_id_73D3()
{
    if ( isarray( level._id_3804._id_783E ) )
    {
        level._id_3804._id_783E = common_scripts\utility::array_remove_duplicates( level._id_3804._id_783E );

        foreach ( var_1 in level._id_3804._id_783E )
        {
            if ( isdefined( var_1 ) && !_func_294( var_1 ) )
                var_1 delete();
        }
    }
}

_id_5F4D()
{
    level endon( "shutdown_hologram" );
    var_0 = randomfloatrange( 0.0, 1 );
    wait(var_0);
    self setmodel( "rec_holo_emitter_floor_on" );
    self moveto( self._id_9A92, 0.25, 0.1, 0.1 );
}

_id_5F4C()
{
    level endon( "start_round" );
    self setmodel( "rec_holo_emitter_floor_off" );
    var_0 = randomfloatrange( 0.0, 1 );
    wait(var_0);
    self moveto( self._id_6388, 0.25, 0.1, 0.1 );
}

_id_854A( var_0, var_1 )
{
    level notify( "shutdown_hologram" );
    level._id_3804._id_51A3 = 1;
    var_1 setclientomnvar( "ui_vlobby_round_state", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_timer", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_damage", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_distance", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_hits", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_fired", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_accuracy", 0 );
    var_1 thread _id_43F7( 1 );
    thread _id_73E1();
    thread _id_2871();
    thread _id_8733( "mp_shooting_range_disappear", var_1 );

    foreach ( var_3 in level._id_3804._id_0A65 )
        var_3 thread _id_5F4C();

    thread _id_8733( "mp_shooting_range_panels_up", var_1 );

    foreach ( var_6 in level._id_3804._id_09EA[var_0] )
    {
        var_6 hide();
        var_6 notsolid();
    }

    if ( level.nextgen )
        thread _id_569E( "lt_shootingrange", 0.25, 6000 );

    thread _id_569D( "lt_shootingrange_bounce", 0.25, 3000 );
    thread _id_569D( "lt_hologram_blue", 0.25, 0.01 );

    foreach ( var_9 in level._id_3804._id_0AB9[var_0] )
    {
        foreach ( var_11 in var_9 )
        {
            if ( var_11._id_09DC == 1 )
            {
                var_12 = var_11.origin;
                var_13 = var_11.angles;
                thread _id_669E( level._id_3804._id_9DFD, var_12, var_13, 3 );
            }

            var_11 dontinterpolate();
            var_11._id_0973 disableaimassist();
            var_11.origin = var_11._id_659E;
            var_11.angles = var_11._id_659C;
            var_11._id_0973 hide();
            var_11._id_0973 notsolid();
            var_11 hide();
            var_11 notsolid();
            var_11 thermaldrawdisable();
            var_11._id_09DC = 0;
        }
    }

    foreach ( var_17 in level._id_3804._id_09E5 )
        var_17 hide();

    level._id_3804._id_5C82 = undefined;
    level._id_3804._id_5A4B = undefined;
    level._id_3804._id_5C83 = undefined;
    level._id_3804._id_6F21 = 0;
    level._id_3804._id_6F22 = 0;
    level._id_3804._id_2597 = 0;
    level._id_3804._id_7131 = 0;
    level._id_3804._id_8445 = 0;
    level._id_3804._id_8446 = 0;
    level._id_3804._id_67C2 = 0;
    level._id_3804._id_764C = 0;
    level._id_3804._id_84B4 = 1;
    var_1 setclientomnvar( "ui_vlobby_round_distance", level._id_3804._id_7131 );
    var_1 setclientomnvar( "ui_vlobby_round_damage", level._id_3804._id_2597 );
    var_1 setclientomnvar( "ui_vlobby_round_hits", level._id_3804._id_8446 );
    var_1 setclientomnvar( "ui_vlobby_round_fired", level._id_3804._id_8445 );
    var_1 setclientomnvar( "ui_vlobby_round_accuracy", level._id_3804._id_67C2 );
    level._id_3804._id_51A3 = 0;
}

_id_8A0A()
{
    level endon( "shutdown_hologram" );
    var_0 = self.origin;
    var_1 = self.angles;
    thread _id_669E( level._id_3804._id_9DFC, var_0, var_1, 3 );
    thread _id_8733( "mp_shooting_range_red_appear", self );
    wait 0.05;
    self show();
    self solid();
    self _meth_8029();
}

_id_7831()
{
    level notify( "ScaleSoundsOnExit" );
    level endon( "ScaleSoundsOnExit" );

    if ( isdefined( level._id_4C00 ) )
    {
        for (;;)
        {
            wait 0.05;

            if ( level._id_4C00 == 1 || getdvarint( "virtualLobbyInFiringRange", 0 ) == 1 )
                continue;
            else
            {
                level._id_3804._id_88A5 = common_scripts\utility::array_remove_duplicates( level._id_3804._id_88A5 );

                foreach ( var_1 in level._id_3804._id_88A5 )
                    var_1 scalevolume( 0, 0.5 );
            }
        }
    }
}

_id_32EF( var_0 )
{
    level._id_4C00 = 1;
    thread _id_9FD9( 0.4, var_0 );
}

_id_9FD9( var_0, var_1 )
{
    var_1 endon( "enter_lobby" );
    wait(var_0);
    var_1 setclientomnvar( "ui_vlobby_round_state", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_timer", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_damage", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_distance", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_hits", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_fired", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_accuracy", 0 );
    var_1 unlink();
    var_1 cameraunlink();
    var_2 = getgroundposition( level._id_3804._id_3A05.origin, 20, 512, 120 );
    var_1 dontinterpolate();
    var_1 setorigin( var_2 );
    var_1 setangles( level._id_3804._id_3A05.angles );
    var_1 setclientdvar( "cg_fovscale", "1.0" );
    level._id_3804._id_51A3 = 0;
    maps\mp\_vl_camera::_id_9E4C( 0, "lobby" + ( var_1._id_2522 + 1 ), 1, 1 );
    var_1 _id_1C92( var_1.loadoutoffhand );
    var_1 _id_1C92( var_1.loadoutequipment );
    maps\mp\_utility::updatesessionstate( "playing" );
    var_1 setclienttriggervisionset( "mp_virtual_lobby_fr", 0 );
    var_1 lightsetforplayer( "mp_vl_firingrange" );
    var_1 thread _id_A75B::_id_30E4();
    level._id_3804._id_88A5 = [];
    var_1 thread _id_7831();

    if ( !var_1 maps\mp\_utility::_hasperk( "specialty_wildcard_dualtacticals" ) && maps\mp\gametypes\_class::isvalidequipment( var_1.loadoutequipment, 0 ) && !_id_50C3( var_1.loadoutequipment ) )
        var_1 thread _id_5DA8( var_1.loadoutequipment, 0 );

    if ( var_1 maps\mp\_utility::_hasperk( "specialty_wildcard_duallethals" ) && maps\mp\gametypes\_class::isvalidequipment( var_1.loadoutoffhand, 0 ) && !_id_50C3( var_1.loadoutoffhand ) )
        var_1 thread _id_5DA8( var_1.loadoutoffhand, 1 );

    if ( var_1.primaryweapon != "specialty_null" && var_1.primaryweapon != "none" && var_1.primaryweapon != "iw5_combatknife_mp" && !issubstr( var_1.primaryweapon, "em1" ) && !issubstr( var_1.primaryweapon, "epm3" ) && !issubstr( var_1.primaryweapon, "dlcgun1_mp" ) && !issubstr( var_1.primaryweapon, "dlcgun1loot" ) && !issubstr( var_1.primaryweapon, "dlcgun9loot6" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot4" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot6" ) )
    {
        var_1 thread _id_5E1A( var_1.primaryweapon );

        if ( issubstr( var_1.primaryweapon, "_gl" ) )
            var_1 thread _id_5E1A( "alt_" + var_1.primaryweapon );
    }

    if ( var_1.secondaryweapon != "specialty_null" && var_1.secondaryweapon != "none" && var_1.secondaryweapon != "iw5_combatknife_mp" && !issubstr( var_1.secondaryweapon, "em1" ) && !issubstr( var_1.secondaryweapon, "epm3" ) && !issubstr( var_1.primaryweapon, "dlcgun1_mp" ) && !issubstr( var_1.primaryweapon, "dlcgun1loot" ) && !issubstr( var_1.primaryweapon, "dlcgun9loot6" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot4" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot6" ) )
    {
        var_1 thread _id_5E1A( var_1.secondaryweapon );

        if ( issubstr( var_1.secondaryweapon, "_gl" ) )
            var_1 thread _id_5E1A( "alt_" + var_1.secondaryweapon );
    }
}

_id_1C92( var_0 )
{
    var_1 = maps\mp\_utility::strip_suffix( var_0, "_lefthand" );

    if ( var_1 != "none" && var_1 != "specialty_null" && maps\mp\gametypes\_class::isvalidoffhand( var_1, 0 ) )
    {
        self batteryfullrecharge( var_1 );
        self batterysetdischargescale( var_1, 1 );
    }
}

_id_50C3( var_0 )
{
    switch ( var_0 )
    {
        case "none":
        case "specialty_null":
        case "exoknife_mp":
        case "exoknife_mp_lefthand":
            return 1;
        default:
            return 0;
    }
}

_id_41F8()
{
    self endon( "enter_lobby" );
    wait 2;
    var_0 = getdvarint( "virtualLobbyInFiringRange", 0 );

    if ( var_0 == 1 && level._id_4C00 == 1 )
        self _meth_8131( 1 );
}

_id_0705( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = self;
    level._id_3804._id_555D = undefined;
    thread _id_5ED4( var_1 );
    thread _id_5EBE( var_1 );
    thread _id_5E6C( var_1 );

    foreach ( var_3 in level._id_3804._id_0AB9[var_0] )
    {
        foreach ( var_5 in var_3 )
            var_5 thread _id_5E3C( var_1 );
    }

    thread _id_2B5A( var_1, var_0 );
    var_8 = level._id_3804._id_0AB9[var_0].size;
    var_9 = level._id_3804._id_0AB9[var_0];

    for ( var_10 = 0; var_10 < var_8; var_10++ )
    {
        thread _id_8D43( var_9[var_10], var_1 );
        level waittill( "wave_done" );
        wait 0.05;
    }

    level notify( "round_done" );
    thread maps\mp\_audio::_id_8730( "mp_shooting_range_panels_bell", level._id_3804._id_10F1.origin );
    level._id_3804._id_764C = 0;
    var_1 setclientomnvar( "ui_vlobby_round_state", 2 );
}

_id_5ED4( var_0 )
{
    level endon( "shutdown_hologram" );
    level endon( "round_done" );
    var_1 = maps\mp\_utility::gettimepassed();

    for (;;)
    {
        var_2 = maps\mp\_utility::gettimepassed();
        var_3 = var_2 - var_1;
        var_4 = maps\mp\_utility::rounddecimalplaces( var_3 / 1000, 1 );

        if ( var_4 > 9999.9 )
        {
            level._id_3804.time = 0;
            var_0 setclientomnvar( "ui_vlobby_round_timer", level._id_3804.time );
            var_0 setclientomnvar( "ui_vlobby_round_state", 0 );
            thread _id_854A( level._id_3804._id_7655, var_0 );
            return;
        }
        else if ( var_4 < 0 )
        {
            level._id_3804.time = 0;
            var_0 setclientomnvar( "ui_vlobby_round_timer", level._id_3804.time );
            var_0 setclientomnvar( "ui_vlobby_round_state", 0 );
            thread _id_854A( level._id_3804._id_7655, var_0 );
            return;
        }
        else
        {
            level._id_3804.time = var_4;
            var_0 setclientomnvar( "ui_vlobby_round_timer", level._id_3804.time );
        }

        wait 0.05;
    }
}

_id_8D43( var_0, var_1 )
{
    level endon( "shutdown_hologram" );
    var_2 = 0;
    thread maps\mp\_audio::_id_8730( "mp_shooting_range_panels_bell", level._id_3804._id_10F1.origin );

    foreach ( var_4 in var_0 )
        var_4 thread _id_91A2( var_1 );

    for (;;)
    {
        level waittill( "target_died" );
        var_2++;

        if ( var_2 == var_0.size )
        {
            level notify( "wave_done" );
            return;
        }
    }
}

_id_91A2( var_0 )
{
    level endon( "shutdown_hologram" );
    self._id_659E = self.origin;
    self._id_659C = self.angles;
    self._id_09DC = 1;
    _id_8A0A();
    thread _id_91A0( var_0 );
    thread _id_91A6();
    thread _id_919E();
    thread _id_919F();
}

_id_669E( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0.0, 0.0, 0.0 );

    if ( !isdefined( var_2 ) )
        var_2 = ( 0.0, 0.0, 0.0 );

    var_5 = spawnfx( var_0, var_1, anglestoforward( var_2 ), anglestoup( var_2 ) );

    if ( isdefined( var_4 ) )
        setwinningteam( var_5, var_4 );

    triggerfx( var_5 );

    if ( isdefined( var_3 ) )
    {
        wait(var_3);

        if ( isdefined( var_5 ) && !_func_294( var_5 ) )
            var_5 delete();
    }
    else
    {
        level waittill( "shutdown_hologram" );

        if ( isdefined( var_5 ) && !_func_294( var_5 ) )
            var_5 delete();
    }
}

_id_91A6()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
    {
        var_0 = self.script_parameters;
        _id_5F8D();

        switch ( var_0 )
        {
            case "stand":
                break;
            case "cover":
                thread _id_6E42();
                break;
            case "move":
                thread _id_5F42();
                break;
        }
    }
}

_id_5F8D()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );

    if ( !isdefined( level._id_3804._id_7655 ) )
        return;

    var_0 = level._id_3804._id_7655;
    var_1 = common_scripts\utility::getclosest( self.origin, level._id_3804._id_0AB6[var_0] );
    self._id_24E0 = var_1;
    self._id_5522 = self._id_24E0;

    for (;;)
    {
        if ( isdefined( self ) )
        {
            var_2 = distance( self._id_24E0.origin, self.origin );
            var_3 = var_2 / level._id_3804._id_7611;

            if ( isdefined( self._id_24E0.script_noteworthy ) && self._id_24E0.script_noteworthy == "jump" )
                self moveto( self._id_24E0.origin, var_3 * 0.5, 0, 0.1 );
            else if ( isdefined( self._id_5522.script_noteworthy ) && self._id_5522.script_noteworthy == "jump" )
                self moveto( self._id_24E0.origin, var_3 * 0.5, 0.1, 0 );
            else
                self moveto( self._id_24E0.origin, var_3 );

            self waittill( "movedone" );

            if ( isdefined( self._id_24E0.target ) )
            {
                var_4 = getent( self._id_24E0.target, "targetname" );
                self._id_5522 = self._id_24E0;
                self._id_24E0 = var_4;
            }
            else
                return;
        }
        else
            return;
    }
}

_id_6E42()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );
    var_0 = 4;
    var_1 = 1;
    var_2 = self._id_24E0.origin;
    var_3 = self._id_5522.origin;

    if ( self._id_24E0 == self._id_5522 )
        var_3 = self._id_659E;

    wait(var_0);

    for (;;)
    {
        if ( isdefined( self ) )
        {
            var_4 = distance( var_3, var_2 );
            var_5 = var_4 / level._id_3804._id_7611;
            self moveto( var_3, var_5 );
            self waittill( "movedone" );
            wait(var_1);
            var_4 = distance( var_3, var_2 );
            var_5 = var_4 / level._id_3804._id_7611;
            self moveto( var_2, var_5 );
            self waittill( "movedone" );
            wait(var_0);
        }
    }
}

_id_5F42()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );
    var_0 = undefined;
    var_1 = undefined;

    if ( isdefined( self._id_5522.script_noteworthy ) && self._id_5522.script_noteworthy == "jump" )
    {
        var_0 = self._id_5522;
        var_1 = var_0.origin;
        self._id_5522 = getent( var_0.targetname, "target" );
    }

    var_2 = self._id_24E0.origin;
    var_3 = self._id_5522.origin;

    if ( self._id_24E0 == self._id_5522 )
        var_3 = self._id_659E;

    for (;;)
    {
        if ( isdefined( self ) )
        {
            if ( isdefined( var_1 ) )
            {
                wait 2;
                var_4 = distance( var_1, var_2 );
                var_5 = var_4 / level._id_3804._id_7611;
                self moveto( var_1, var_5 * 0.5, 0, 0.1 );
                self waittill( "movedone" );
                var_4 = distance( var_1, var_3 );
                var_5 = var_4 / level._id_3804._id_7611;
                self moveto( var_3, var_5 * 0.5, 0.1, 0 );
                self waittill( "movedone" );
                wait 2;
                var_4 = distance( var_1, var_3 );
                var_5 = var_4 / level._id_3804._id_7611;
                self moveto( var_1, var_5 * 0.5, 0, 0.1 );
                self waittill( "movedone" );
                var_4 = distance( var_1, var_2 );
                var_5 = var_4 / level._id_3804._id_7611;
                self moveto( var_2, var_5 * 0.5, 0.1, 0 );
                self waittill( "movedone" );
            }
            else
            {
                var_4 = distance( var_3, var_2 );
                var_5 = var_4 / level._id_3804._id_7611;
                self moveto( var_3, var_5 );
                self waittill( "movedone" );
                var_4 = distance( var_2, var_3 );
                var_5 = var_4 / level._id_3804._id_7611;
                self moveto( var_2, var_5 );
                self waittill( "movedone" );
            }
        }
    }
}

_id_788A()
{
    level endon( "shutdown_hologram" );

    for (;;)
    {
        var_0 = [];

        for ( var_1 = 0; var_1 < self.hits.size; var_1++ )
        {
            self.hits[var_1].time -= 1;

            if ( self.hits[var_1].time > 0 )
                var_0[var_0.size] = self.hits[var_1];
        }

        self.hits = var_0;

        foreach ( var_3 in self.hits )
        {

        }

        wait 0.05;
    }
}

_id_91A0( var_0 )
{
    level endon( "shutdown_hologram" );
    self.hits = [];
    self._id_0973.health = 9999;
    self._id_0973.maxhealth = 9999;
    self.maxhealth = 9999;
    self.health = self.maxhealth;
    self._id_3650 = 100;
    self setcandamage( 1 );
    self._id_0973 show();
    self._id_0973 solid();
    self._id_0973 enableaimassist();

    while ( self.health > 0 )
    {
        var_1 = undefined;
        var_2 = undefined;
        var_3 = undefined;
        var_4 = undefined;
        var_5 = undefined;
        var_6 = undefined;
        var_7 = undefined;
        var_8 = undefined;
        var_9 = undefined;
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
        var_11 = _id_4026( var_10, var_8, var_0 );
        var_12 = self gettagorigin( "tag_head" );
        var_13 = self gettagorigin( "tag_chest" );
        self.health = self.maxhealth;
        var_14 = self._id_3650;
        var_14 = float( var_14 ) - float( var_1 ) * var_11;
        var_14 = maps\mp\_utility::rounddecimalplaces( var_14, 0 );
        self._id_3650 = int( var_14 );

        if ( self._id_3650 <= 0 )
        {
            thread _id_91CF( var_13 );
            self.health = 0;

            if ( isdefined( var_2 ) )
            {
                if ( isdefined( var_8 ) )
                {
                    if ( var_8 == "tag_head" )
                        var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "killshot_headshot" );
                    else if ( var_8 == "tag_chest" )
                        var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "mp_hit_kill" );
                }
            }

            self notify( "death" );
            continue;
        }

        if ( isdefined( var_2 ) )
        {
            if ( isdefined( var_8 ) && var_8 == "tag_head" )
            {
                var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "headshot" );
                continue;
            }

            var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "standard" );
        }
    }
}

_id_91CF( var_0 )
{
    playfx( level._effect["recovery_scoring_target_shutter_enemy"], var_0 );
}

_id_262F()
{
    level notify( "shutdown_hologram" );
}

_id_37FE()
{
    var_0 = getentarray( "firing_range_round_trigger", "targetname" );
    return var_0;
}

_id_37FC()
{
    var_0 = getentarray( "target_logic_point", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_index ) )
        {
            var_4 = int( var_3.script_index );

            if ( !isarray( var_1[var_4] ) )
            {
                var_5 = [ var_3 ];
                var_1[var_4] = var_5;
            }
            else
                var_1[var_4] = common_scripts\utility::add_to_array( var_1[var_4], var_3 );
        }
    }

    return var_1;
}

_id_37F7()
{
    var_0 = getentarray( "round_environment", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_3 hide();
        var_3 notsolid();
        var_4 = undefined;

        if ( isdefined( var_3.script_index ) )
            var_4 = int( var_3.script_index );

        if ( isdefined( var_4 ) )
        {
            if ( !isarray( var_1[var_4] ) )
            {
                var_5 = [ var_3 ];
                var_1[var_4] = var_5;
                continue;
            }

            var_1[var_4] = common_scripts\utility::add_to_array( var_1[var_4], var_3 );
        }
    }

    return var_1;
}

_id_37F8()
{
    var_0 = common_scripts\utility::getstructarray( "round_environment", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = undefined;

        if ( isdefined( var_3.script_index ) )
            var_4 = int( var_3.script_index );

        if ( isdefined( var_4 ) )
        {
            if ( !isarray( var_1[var_4] ) )
            {
                var_5 = [ var_3 ];
                var_1[var_4] = var_5;
                continue;
            }

            var_1[var_4] = common_scripts\utility::add_to_array( var_1[var_4], var_3 );
        }
    }

    return var_1;
}

_id_37FD()
{
    var_0 = getentarray( "target_enemy", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_3._id_09DC = 0;
        var_3.pers["team"] = "axis";
        var_3.team = "axis";
        var_3._id_6590 = getent( var_3.target, "targetname" );
        var_3._id_0973 = getent( var_3._id_6590.target, "targetname" );
        var_3._id_0973 linktosynchronizedparent( var_3 );
        var_3._id_0973.pers["team"] = "axis";
        var_3._id_0973.team = "axis";
        var_3._id_659E = var_3.origin;
        var_3._id_659C = var_3.angles;
        var_3._id_0973 hide();
        var_3._id_0973 notsolid();
        var_3 hide();
        var_3 notsolid();

        if ( isdefined( var_3.script_index ) )
        {
            var_4 = int( var_3.script_index );

            if ( !isarray( var_1[var_4] ) )
            {
                var_5 = [];
                var_1[var_4] = var_5;
            }

            if ( isdefined( var_3._id_7A05 ) )
            {
                var_6 = int( var_3._id_7A05 );

                if ( !isarray( var_1[var_4][var_6] ) )
                {
                    var_7 = [ var_3 ];
                    var_1[var_4][var_6] = var_7;
                }
                else
                    var_1[var_4][var_6] = common_scripts\utility::add_to_array( var_1[var_4][var_6], var_3 );
            }
        }
    }

    return var_1;
}

_id_919E()
{
    level endon( "shutdown_hologram" );
    self waittill( "death" );
    level notify( "target_died" );
    _id_91AE();
}

_id_919F()
{
    self endon( "death" );
    level waittill( "shutdown_hologram" );
    _id_91AE();
}

_id_91AE()
{
    self setcandamage( 0 );
    self hide();
    self notsolid();
    self._id_09DC = 0;

    if ( isdefined( self._id_0973 ) )
        self._id_0973 disableaimassist();
}

_id_569D( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    if ( level.currentgen && isdefined( var_3 ) == 0 )
        return;

    var_4 = var_3 _meth_81DE();
    var_3._id_31B1 = var_2;
    var_5 = 0;

    while ( var_5 < var_1 )
    {
        var_6 = var_4 + ( var_2 - var_4 ) * var_5 / var_1;
        var_5 += 0.05;
        var_3 _meth_81DF( var_6 );
        wait 0.05;
    }

    var_3 _meth_81DF( var_2 );
}

_id_569E( var_0, var_1, var_2 )
{
    var_3 = getentarray( var_0, "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = var_5 _meth_81DE();
        var_5._id_31B1 = var_2;
        var_7 = 0;

        while ( var_7 < var_1 )
        {
            var_8 = var_6 + ( var_2 - var_6 ) * var_7 / var_1;
            var_7 += 0.05;
            var_5 _meth_81DF( var_8 );
            wait 0.05;
        }

        var_5 _meth_81DF( var_2 );
    }
}

_id_5E1A( var_0 )
{
    self endon( "enter_lobby" );

    while ( level._id_4C00 == 1 )
    {
        var_1 = self _meth_8334( var_0 );

        if ( var_1 <= 0.25 )
        {
            self givemaxammo( var_0 );
            continue;
        }

        wait 0.5;
    }
}

_id_754C()
{
    if ( isdefined( self.riotshieldentity ) )
        self.riotshieldentity thread maps\mp\_riotshield::_id_25B0();
}

_id_43F7( var_0 )
{
    if ( isdefined( level.grenades ) && isarray( level.grenades ) )
    {
        foreach ( var_2 in level.grenades )
        {
            if ( isdefined( var_2 ) && !_func_294( var_2 ) )
            {
                if ( !isdefined( self ) || !isdefined( var_2.owner ) || _func_294( var_2.owner ) )
                {
                    if ( !isdefined( var_2.weaponname ) )
                        continue;
                    else if ( maps\mp\_utility::strip_suffix( var_2.weaponname, "_lefthand" ) == "explosive_drone_mp" )
                        var_2 thread maps\mp\_explosive_drone::explosivegrenadedeath();
                    else
                    {
                        var_2 notify( "death" );
                        var_2 thread _id_27D2();
                    }

                    continue;
                }

                if ( var_2.owner == self )
                {
                    if ( !isdefined( var_2.weaponname ) )
                        continue;
                    else
                    {
                        if ( maps\mp\_utility::strip_suffix( var_2.weaponname, "_lefthand" ) == "explosive_drone_mp" )
                        {
                            var_2 thread maps\mp\_explosive_drone::explosivegrenadedeath();
                            continue;
                        }

                        if ( maps\mp\_utility::strip_suffix( var_2.weaponname, "_lefthand" ) == "exoknife_mp" )
                        {
                            if ( isdefined( var_0 ) && var_0 == 1 )
                            {
                                var_3 = getdvarint( "virtualLobbyInFiringRange", 0 );

                                if ( var_3 == 1 && level._id_4C00 == 1 )
                                    var_2 maps\mp\_exoknife::_id_34A0();
                            }
                            else
                            {
                                var_2 notify( "death" );
                                var_2 thread _id_27D2();
                            }

                            continue;
                        }

                        var_2 notify( "death" );
                        var_2 thread _id_27D2();
                    }
                }
            }
        }
    }

    thread _id_2EFA();
}

_id_2EFA()
{
    if ( isdefined( level.trackingdrones ) && isarray( level.trackingdrones ) )
    {
        foreach ( var_1 in level.trackingdrones )
        {
            if ( isdefined( var_1 ) && !_func_294( var_1 ) )
            {
                if ( !isdefined( self ) || !isdefined( var_1.owner ) || _func_294( var_1.owner ) )
                {
                    var_1 thread maps\mp\_tracking_drone::_id_94E7();
                    continue;
                }

                if ( var_1.owner == self )
                    var_1 thread maps\mp\_tracking_drone::_id_94E7();
            }
        }
    }
}

_id_27D2()
{
    wait 0.05;

    if ( isdefined( self ) && !_func_294( self ) )
        self delete();
}

_id_5DA8( var_0, var_1 )
{
    self endon( "enter_lobby" );
    var_2 = 0;
    var_3 = maps\mp\_utility::strip_suffix( var_0, "_lefthand" );

    if ( var_3 == "smoke_grenade_var_mp" || var_3 == "stun_grenade_var_mp" || var_3 == "emp_grenade_var_mp" || var_3 == "paint_grenade_var_mp" )
        var_2 = 1;

    if ( var_3 == "explosive_drone_mp" )
        thread _id_32CE();

    while ( level._id_4C00 == 1 )
    {
        if ( var_2 == 1 )
        {
            wait 1.5;

            if ( !var_1 )
            {
                var_4 = self getammocount( "paint_grenade_var_mp" );
                var_5 = self getammocount( "smoke_grenade_var_mp" );
                var_6 = self getammocount( "emp_grenade_var_mp" );
                var_7 = self getammocount( "stun_grenade_var_mp" );

                if ( var_4 == 0 && var_5 == 0 && var_6 == 0 && var_7 == 0 )
                {
                    self givestartammo( "paint_grenade_var_mp" );
                    self givestartammo( "smoke_grenade_var_mp" );
                    self givestartammo( "emp_grenade_var_mp" );
                    self givestartammo( "stun_grenade_var_mp" );
                }
            }
            else
            {
                var_8 = self getammocount( "paint_grenade_var_mp_lefthand" );
                var_9 = self getammocount( "smoke_grenade_var_mp_lefthand" );
                var_10 = self getammocount( "emp_grenade_var_mp_lefthand" );
                var_11 = self getammocount( "stun_grenade_var_mp_lefthand" );

                if ( var_8 == 0 && var_9 == 0 && var_10 == 0 && var_11 == 0 )
                {
                    self givestartammo( "paint_grenade_var_mp_lefthand" );
                    self givestartammo( "smoke_grenade_var_mp_lefthand" );
                    self givestartammo( "emp_grenade_var_mp_lefthand" );
                    self givestartammo( "stun_grenade_var_mp_lefthand" );
                }
            }

            continue;
        }
        else
        {
            wait 1.5;
            var_12 = self getammocount( var_0 );

            if ( var_12 == 0 )
            {
                maps\mp\gametypes\_class::giveoffhand( var_0 );
                continue;
            }
        }

        wait 0.5;
    }
}

_id_32CE()
{
    self endon( "enter_lobby" );

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        var_2 = maps\mp\_utility::strip_suffix( var_1, "_lefthand" );

        if ( var_2 == "explosive_drone_mp" )
        {
            if ( isdefined( level.grenades ) && isarray( level.grenades ) )
            {
                foreach ( var_0 in level.grenades )
                {
                    if ( isdefined( var_0 ) && !_func_294( var_0 ) && isdefined( self ) && isdefined( var_0.owner ) && isdefined( var_0.weaponname ) )
                    {
                        if ( maps\mp\_utility::strip_suffix( var_0.weaponname, "_lefthand" ) == "explosive_drone_mp" && var_0.owner == self )
                        {
                            if ( isdefined( var_0.explosivedrone ) )
                            {
                                var_0.explosivedrone thread maps\mp\_explosive_drone::_id_357A();
                                continue;
                            }

                            var_0 thread maps\mp\_explosive_drone::explosivegrenadedeath();
                        }
                    }
                }
            }
        }
    }
}

_id_8531( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = 0;
    var_2 = [];

    foreach ( var_4 in level._id_3804._id_09EA[var_0] )
    {
        if ( isdefined( var_4.classname ) && var_4.classname == "script_model" )
        {
            if ( isdefined( var_4.model ) && issubstr( var_4.model, "rec_holo_range" ) )
            {
                var_2[var_1] = var_4.model;

                if ( !issubstr( var_4.model, "trans" ) )
                {
                    var_5 = var_4.model + "_trans";
                    var_4 setmodel( var_5 );
                }

                var_4 show();
            }
            else
                var_2[var_1] = undefined;
        }

        var_1++;
    }

    return var_2;
}

_id_487F( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in level._id_3804._id_09EA[var_0] )
    {
        if ( isdefined( var_4.classname ) && var_4.classname == "script_model" )
        {
            if ( isdefined( var_4.model ) && issubstr( var_4.model, "rec_holo_range" ) )
            {
                if ( isstring( var_1[var_2] ) )
                {
                    var_4 hide();
                    var_4 setmodel( var_1[var_2] );
                }
            }
        }

        var_2++;
    }
}
