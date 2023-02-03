// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_firingrange()
{
    var_0 = spawnstruct();
    var_0.fr_start = getent( "firingrange_start", "targetname" );
    var_0.alltargetsarray = firing_range_setup_targets();
    var_0.allenvarray = firing_range_setup_env();
    var_0.transitionmeshes = [];
    var_0.transitionmeshesrev = [];
    var_0.alltriggerarray = firing_range_setup_triggers();
    var_0.alltargetmin = firing_range_setup_min_range();
    var_0.alltargetmax = firing_range_setup_max_range();
    var_0.allboothdisplays = firing_range_setup_booth_displays();
    var_0.alltargetlogicarray = firing_range_setup_target_logic();
    var_0.allfloorpannels = firing_range_setup_floor_panels();
    var_0.allvfx_struct = firing_range_setup_env_vfx();
    var_0.all3duiscreens = firing_range_setup_3dui_screens();
    var_0.audio_buzzer_struct = common_scripts\utility::getstruct( "audio_buzzer_org", "targetname" );
    var_0.soundents = [];
    var_0.last_target = undefined;
    var_0.target_move_dist = 32;
    var_0.target_units_per_second = 256;
    var_0.pressedup = 0;
    var_0.presseddown = 0;
    var_0.roundnumber = undefined;
    var_0.minpoint = undefined;
    var_0.minpointmodpos = undefined;
    var_0.maxpoint = undefined;
    var_0.buttontimertotal = 0.55;
    var_0.buttontimer = 0;
    var_0.gracedisance = 24;
    var_0.damagedone = 0;
    var_0.rangeinmeters = 0;
    var_0.shotsfired = 0;
    var_0.shotshit = 0;
    var_0.percent = 0;
    var_0.shouldupdateluadisplay = 0;
    var_0.round_target_unit_per_second = 176;
    var_0.time = 0;
    var_0.groupdevider = 5;
    var_0.roundactive = 0;
    var_0.isshuttingdown = 0;
    var_0.vfxtargetspawn = loadfx( "vfx/props/holo_target_red_spawn_in" );
    var_0.vfxtargetspawnout = loadfx( "vfx/props/holo_target_red_spawn_out" );
    var_0.vfxholoedge = loadfx( "vfx/beam/firing_range_edge_glow" );
    common_scripts\utility::array_thread( var_0.alltriggerarray, ::trigger_setup );
    level.target_center_off = ( 1.3, 0, 25 );
    level.target_radius = 12;
    level.hit_off = 18;
    level.firingrange = var_0;
}

firing_range_setup_floor_panels()
{
    var_0 = getentarray( "holo_emitter_floor", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.og_position = var_2.origin;
        var_2.up_position = var_2.origin + ( 0, 0, 4 );
    }

    return var_0;
}

firing_range_setup_3dui_screens()
{
    var_0 = getentarray( "display_3dui_mesh", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();

    return var_0;
}

firing_range_setup_min_range()
{
    var_0 = common_scripts\utility::getstructarray( "target_track_min", "targetname" );
    return var_0;
}

firing_range_setup_max_range()
{
    var_0 = common_scripts\utility::getstructarray( "target_track_max", "targetname" );
    return var_0;
}

firing_range_setup_booth_displays()
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

trigger_setup()
{
    var_0 = self;
    var_0 thread common_scripts\_dynamic_world::triggertouchthink( ::player_enter_round_trigger, ::player_leave_round_trigger );
}

player_enter_round_trigger( var_0 )
{
    level endon( "shutdown_hologram" );

    while ( level.firingrange.isshuttingdown == 1 )
        wait 0.1;

    var_1 = self;

    if ( !isdefined( var_0.script_index ) )
        return;

    var_2 = int( var_0.script_index );
    level.firingrange.roundnumber = var_2;

    if ( !isdefined( level.firingrange.allenvarray[var_2] ) )
        return;

    var_1 thread startround( var_2 );
}

player_leave_round_trigger( var_0 )
{
    var_1 = self;

    if ( !isdefined( var_0.script_index ) )
        return;

    var_2 = int( var_0.script_index );
    level.firingrange.roundnumber = var_2;

    if ( !isdefined( level.firingrange.allenvarray[var_2] ) )
        return;

    thread shutdownround( var_2, var_1 );
}

snd_play_linked_firingrange( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_origin", var_1.origin );
    var_4 vehicle_jetbikesethoverforcescale( var_1 );
    var_4 thread maps\mp\_audio::sndx_play_linked_internal( var_0, var_1, var_2, var_3 );

    if ( !isdefined( level.firingrange.soundents ) )
        level.firingrange.soundents = [];
    else
        level.firingrange.soundents = common_scripts\utility::add_to_array( level.firingrange.soundents, var_4 );

    return var_4;
}

targetspreadshooting( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = self;
    var_2 = level.firingrange.alltargetsarray[var_0][0][0];
    var_2.alive = 1;
    thread maps\mp\_audio::snd_play_in_space( "mp_shooting_range_panels_bell", level.firingrange.audio_buzzer_struct.origin );
    var_2 spawntarget();
    var_2 show();
    var_2 solid();
    var_2 setcandamage( 1 );
    var_2 setdamagecallbackon( 1 );
    var_2.damagecallback = ::monitordamagecallback;
    var_2.health = 9999;
    var_2.maxhealth = 9999;
    var_2 thermaldrawenable();

    foreach ( var_4 in level.firingrange.alltargetmin )
    {
        if ( var_4.script_index == level.firingrange.roundnumber )
        {
            level.firingrange.minpoint = var_4;
            break;
        }
    }

    foreach ( var_4 in level.firingrange.alltargetmax )
    {
        if ( var_4.script_index == level.firingrange.roundnumber )
        {
            level.firingrange.maxpoint = var_4;
            break;
        }
    }

    if ( !isdefined( level.firingrange.minpoint ) || !isdefined( level.firingrange.maxpoint ) )
    {
        thread shutdownround( var_0, var_1 );
        return;
    }

    level.firingrange.minpointmodpos = level.firingrange.minpoint.origin + anglestoforward( level.firingrange.minpoint.angles ) * -64;
    var_2 thread monitordistance( var_1, var_2, level.firingrange.minpoint );
    thread monitorshotsfired( var_1 );
    thread monitorgrenades( var_1 );
    thread monitorhitpercent( var_1 );
    thread displayboothholo( var_1, var_0 );
    var_1 thread notifytracker( var_2 );
}

monitordistance( var_0, var_1, var_2 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );
    self endon( "death" );
    var_3 = 0.0254;

    for (;;)
    {
        if ( !isdefined( var_1 ) || !isdefined( var_2 ) )
        {
            level.firingrange.rangeinmeters = 0;
            var_0 setclientomnvar( "ui_vlobby_round_distance", level.firingrange.rangeinmeters );
        }
        else
        {
            var_4 = distance2d( var_1.origin, var_2.origin );
            var_5 = int( maps\mp\_utility::rounddecimalplaces( var_3 * var_4, 0 ) );

            if ( var_5 != level.firingrange.rangeinmeters )
            {
                if ( var_5 > 100 )
                    var_5 = 100;
                else if ( var_5 < 0 )
                    var_5 = 0;

                level.firingrange.rangeinmeters = var_5;
                var_0 setclientomnvar( "ui_vlobby_round_distance", level.firingrange.rangeinmeters );
            }
        }

        wait 0.05;
    }
}

notifytracker( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );
    self notifyonplayercommand( "toggled_up_pressed", "+actionslot 1" );
    self notifyonplayercommand( "toggled_up_released", "-actionslot 1" );
    self notifyonplayercommand( "toggled_down_pressed", "+actionslot 2" );
    self notifyonplayercommand( "toggled_down_released", "-actionslot 2" );
    thread monitoruppressed( var_0 );
    thread monitorupreleased( var_0 );
    thread monitordownpressed( var_0 );
    thread monitordownreleased( var_0 );
    thread movestopper( var_0, self );
}

monitoruppressed( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_up_pressed" );
        level.firingrange.buttontimer = level.firingrange.buttontimertotal;

        if ( level.firingrange.pressedup == 0 )
        {
            level.firingrange.pressedup = 1;
            level.firingrange.presseddown = 0;
            thread movelogic( level.firingrange.maxpoint.origin, var_0, self );
        }
    }
}

monitorupreleased( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_up_released" );
        var_1 = distance2d( level.firingrange.maxpoint.origin, var_0.origin );

        if ( var_1 <= 1 )
            var_0 moveto( var_0.origin, 0.05 );
        else
        {
            var_2 = var_0.origin + anglestoforward( level.firingrange.alltargetmax[0].angles ) * level.firingrange.gracedisance * -1;
            var_1 = distance2d( var_2, var_0.origin );
            var_3 = var_1 / level.firingrange.target_units_per_second;

            if ( var_3 < 0.05 )
                var_3 = 0.05;

            level.firingrange.buttontimer = var_3 + 0.05;
            thread movelogic( var_2, var_0, self );
        }

        var_0 waittill( "movedone" );
        level.firingrange.pressedup = 0;
    }
}

monitordownpressed( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_down_pressed" );
        level.firingrange.buttontimer = level.firingrange.buttontimertotal;

        if ( level.firingrange.presseddown == 0 )
        {
            level.firingrange.presseddown = 1;
            level.firingrange.pressedup = 0;
            thread movelogic( level.firingrange.minpointmodpos, var_0, self );
        }
    }
}

monitordownreleased( var_0 )
{
    self endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        self waittill( "toggled_down_released" );
        var_1 = distance2d( level.firingrange.minpointmodpos, var_0.origin );

        if ( var_1 <= 1 )
            var_0 moveto( var_0.origin, 0.05 );
        else
        {
            var_2 = var_0.origin + anglestoforward( level.firingrange.alltargetmax[0].angles ) * level.firingrange.gracedisance;
            var_1 = distance2d( var_2, var_0.origin );
            var_3 = var_1 / level.firingrange.target_units_per_second;

            if ( var_3 < 0.05 )
                var_3 = 0.05;

            level.firingrange.buttontimer = var_3 + 0.05;
            thread movelogic( var_2, var_0, self );
        }

        var_0 waittill( "movedone" );
        level.firingrange.presseddown = 0;
    }
}

movelogic( var_0, var_1, var_2 )
{
    var_3 = distance2d( var_0, var_1.origin );

    if ( var_3 <= 1 )
    {
        var_1 notify( "movedone" );
        return;
    }
    else
    {
        var_4 = var_3 / level.firingrange.target_units_per_second;

        if ( var_4 < 0.05 )
            var_4 = 0.05;

        var_1 moveto( var_0, var_4 );
    }
}

movestopper( var_0, var_1 )
{
    var_1 endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        wait 0.05;

        if ( level.firingrange.presseddown == 1 || level.firingrange.pressedup == 1 )
        {
            if ( level.firingrange.buttontimer > 0 )
            {
                level.firingrange.buttontimer -= 0.05;
                continue;
            }

            var_0 moveto( var_0.origin, 0.05 );
            level.firingrange.presseddown = 0;
            level.firingrange.pressedup = 0;
        }
    }
}

monitordamage( var_0 )
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

        if ( level.firingrange.roundnumber == 7 )
            self.health = self.maxhealth;

        var_11 = self gettagorigin( "tag_chest" );
        thread maps\mp\_audio::snd_play_in_space( "mp_shooting_range_red_hit", var_11 );
        var_12 = getmodifier( var_10, var_8, var_0 );
        var_1 = maps\mp\_utility::rounddecimalplaces( float( var_1 ) * var_12, 0 );
        var_1 = int( var_1 );

        if ( var_1 > 999 )
            var_1 = 999;

        if ( var_1 < 0 )
            var_1 = 0;

        level.firingrange.damagedone = var_1;
        var_13 = level.firingrange.shotshit + 1;

        if ( var_13 > 9999 )
            level.firingrange.shotshit = 0;
        else if ( var_13 < 0 )
            level.firingrange.shotshit = 0;
        else
            level.firingrange.shotshit = var_13;

        level.firingrange.shouldupdateluadisplay = 1;
    }
}

monitordamagecallback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( self ) )
        return;

    if ( level.firingrange.roundnumber == 7 )
        self.health = self.maxhealth;

    var_12 = self gettagorigin( "tag_chest" );
    thread maps\mp\_audio::snd_play_in_space( "mp_shooting_range_red_hit", var_12 );
    var_13 = 1;

    if ( isdefined( var_1 ) )
        var_13 = getmodifier( var_5, var_11, var_1 );

    var_2 = maps\mp\_utility::rounddecimalplaces( float( var_2 ) * var_13, 0 );
    var_2 = int( var_2 );

    if ( var_2 > 999 )
        var_2 = 999;

    if ( var_2 < 0 )
        var_2 = 0;

    level.firingrange.damagedone = var_2;

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_0 ) && var_0 != var_1 )
        {
            if ( !isdefined( var_0.damage_counted ) )
            {
                var_0.damage_counted = 1;
                var_14 = level.firingrange.shotshit + 1;

                if ( var_14 > 9999 )
                    level.firingrange.shotshit = 0;
                else if ( var_14 < 0 )
                    level.firingrange.shotshit = 0;
                else
                    level.firingrange.shotshit = var_14;

                level.firingrange.shouldupdateluadisplay = 1;
            }
        }
        else
            var_1 thread countdamagingshots();
    }

    level.firingrange.shouldupdateluadisplay = 1;
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

getmodifier( var_0, var_1, var_2 )
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

            var_4 = var_2 getweapondamagelocationmultiplier( var_6 + "_mp", var_3 );
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
    var_1 = self getcurrentweaponclipammo( "right" );
    var_2 = self getcurrentweaponclipammo( "left" );
    self waittill( "weapon_fired" );
    var_0 = 1;
    var_3 = self getcurrentweaponclipammo( "right" );
    var_4 = self getcurrentweaponclipammo( "left" );
    var_5 = var_1 - var_3 + var_2 - var_4;

    if ( var_5 > 0 )
        var_0 = var_5;

    return var_0;
}

monitorshotsfired( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        var_0.damagingshot = 0;
        var_1 = var_0 waitforweaponfired();

        if ( isdefined( var_1 ) )
        {
            var_2 = level.firingrange.shotsfired + var_1;

            if ( var_2 > 9999 )
            {
                level.firingrange.shotsfired = 0;
                level.firingrange.shotshit = 0;
                level.firingrange.percent = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level.firingrange.shotshit );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level.firingrange.shotsfired );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level.firingrange.percent );
            }
            else if ( var_2 < 0 )
            {
                level.firingrange.shotsfired = 0;
                level.firingrange.shotshit = 0;
                level.firingrange.percent = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level.firingrange.shotshit );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level.firingrange.shotsfired );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level.firingrange.percent );
            }
            else
            {
                level.firingrange.shouldupdateluadisplay = 1;
                level.firingrange.shotsfired = var_2;
            }

            if ( isdefined( var_0.damagingshot ) )
            {
                var_3 = var_0.damagingshot;

                if ( var_1 < var_0.damagingshot )
                    var_3 = var_1;

                var_4 = level.firingrange.shotshit + var_3;

                if ( var_4 > 9999 )
                    level.firingrange.shotshit = 0;
                else if ( var_4 < 0 )
                    level.firingrange.shotshit = 0;
                else
                    level.firingrange.shotshit = var_4;

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

            var_2 = level.firingrange.shotsfired + 1;

            if ( var_2 > 9999 )
            {
                level.firingrange.shotsfired = 0;
                level.firingrange.shotshit = 0;
                level.firingrange.percent = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level.firingrange.shotshit );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level.firingrange.shotsfired );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level.firingrange.percent );
            }
            else if ( var_2 < 0 )
            {
                level.firingrange.shotsfired = 0;
                level.firingrange.shotshit = 0;
                level.firingrange.percent = 0;
                var_0 setclientomnvar( "ui_vlobby_round_hits", level.firingrange.shotshit );
                var_0 setclientomnvar( "ui_vlobby_round_fired", level.firingrange.shotsfired );
                var_0 setclientomnvar( "ui_vlobby_round_accuracy", level.firingrange.percent );
            }
            else
            {
                level.firingrange.shouldupdateluadisplay = 1;
                level.firingrange.shotsfired = var_2;
            }
        }
    }
}

monitorhitpercent( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );

    for (;;)
    {
        if ( level.firingrange.shotsfired > 0 )
        {
            var_1 = level.firingrange.shotshit / level.firingrange.shotsfired * 100;
            var_1 = maps\mp\_utility::rounddecimalplaces( var_1, 0 );

            if ( var_1 != level.firingrange.percent )
            {
                if ( var_1 > 999 )
                    var_1 = 999;
                else if ( var_1 < 0 )
                    var_1 = 0;

                level.firingrange.percent = int( var_1 );
                level.firingrange.shouldupdateluadisplay = 1;
            }
        }

        wait 0.05;
    }
}

displayboothholo( var_0, var_1 )
{
    var_0 endon( "disconnect" );
    level endon( "shutdown_hologram" );
    var_2 = finddisplay( level.firingrange.all3duiscreens, var_1 );

    if ( isdefined( var_2 ) )
        var_2 show();

    for (;;)
    {
        if ( level.firingrange.shouldupdateluadisplay == 1 )
        {
            var_0 setclientomnvar( "ui_vlobby_round_damage", level.firingrange.damagedone );
            var_0 setclientomnvar( "ui_vlobby_round_hits", level.firingrange.shotshit );
            var_0 setclientomnvar( "ui_vlobby_round_fired", level.firingrange.shotsfired );
            var_0 setclientomnvar( "ui_vlobby_round_accuracy", level.firingrange.percent );
            level.firingrange.shouldupdateluadisplay = 0;
        }

        wait 0.2;
    }
}

finddisplay( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.script_index ) && var_3.script_index == var_1 )
            return var_3;
    }
}

startround( var_0 )
{
    level endon( "shutdown_hologram" );
    level notify( "start_round" );
    level.firingrange.damagedone = 0;
    level.firingrange.rangeinmeters = 0;
    level.firingrange.time = 0;
    level.firingrange.roundactive = 1;
    level.firingrange.shouldupdateluadisplay = 1;
    self setclientomnvar( "ui_vlobby_round_distance", level.firingrange.rangeinmeters );
    self setclientomnvar( "ui_vlobby_round_damage", level.firingrange.damagedone );
    self setclientomnvar( "ui_vlobby_round_hits", level.firingrange.shotshit );
    self setclientomnvar( "ui_vlobby_round_fired", level.firingrange.shotsfired );
    self setclientomnvar( "ui_vlobby_round_accuracy", level.firingrange.percent );

    foreach ( var_2 in level.firingrange.alltargetsarray[var_0] )
    {
        foreach ( var_4 in var_2 )
        {
            var_4.origin = var_4.original_position;
            var_4.angles = var_4.original_orientation;
        }
    }

    foreach ( var_8 in level.firingrange.allfloorpannels )
        var_8 thread movefloorpanelup();

    thread snd_play_linked_firingrange( "mp_shooting_range_panels_up", self );
    thread lerp_spot_intensity( "lt_shootingrange_bounce", 0.25, 0.01 );

    if ( level.nextgen )
    {
        thread lerp_spot_intensity_array( "lt_shootingrange", 0.25, 0.01 );
        thread lerp_spot_intensity( "lt_hologram_blue", 0.25, 3000 );
    }
    else
        thread lerp_spot_intensity( "lt_hologram_blue", 0.25, 60000 );

    wait 0.5;
    var_10 = 0;

    foreach ( var_12 in level.firingrange.allvfx_struct[var_0] )
    {
        if ( level.nextgen )
            thread particlespawn( level.firingrange.vfxholoedge, var_12.origin, var_12.angles, undefined, 1 );
        else if ( var_10 % 2 == 0 )
            thread particlespawn( level.firingrange.vfxholoedge, var_12.origin, var_12.angles, undefined, 1 );

        var_10++;
    }

    if ( level.nextgen )
    {
        showtransition( var_0 );
        wait 0.1;
        flickertransmeshes( level.firingrange.transitionmeshes );
        wait 0.1;
        flickertransmeshes( level.firingrange.transitionmeshes );
        wait 0.1;
        showtransitionrev( level.firingrange.transitionmeshes );
        hidetransitionmeshes();
        wait 0.4;
        showroundmeshmesh( var_0 );
        wait 0.1;
        deletetransrevmeshes();
    }
    else
    {
        var_14 = showtransition_cg( var_0 );
        wait 0.1;
        flickertransmeshes( level.firingrange.allenvarray[var_0] );
        flickertransmeshes( level.firingrange.allenvarray[var_0] );
        wait 0.1;
        flickertransmeshes( level.firingrange.allenvarray[var_0] );
        wait 0.1;
        hidetransitionmeshes_cg( var_0, var_14 );
        wait 0.1;
        showroundmeshmesh( var_0 );
    }

    thread snd_play_linked_firingrange( "mp_shooting_range_appear", self );

    if ( var_0 == 7 )
    {
        self setclientomnvar( "ui_vlobby_round_state", 3 );
        thread targetspreadshooting( var_0 );
    }
    else
    {
        self setclientomnvar( "ui_vlobby_round_state", 1 );
        thread activate_targets( var_0 );
    }
}

showroundmeshmesh( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = maps\mp\_utility::rounddecimalplaces( level.firingrange.allenvarray[var_0].size / level.firingrange.groupdevider, 0, "up" );
    var_2 = 0;

    foreach ( var_4 in level.firingrange.allenvarray[var_0] )
    {
        var_4 show();
        var_4 solid();
    }
}

showtransitionrev( var_0 )
{
    level endon( "shutdown_hologram" );
    level.firingrange.transitionmeshesrev = [];

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !isremovedentity( var_2 ) && isdefined( var_2.classname ) && var_2.classname == "script_model" )
        {
            if ( isdefined( var_2.model ) && issubstr( var_2.model, "_trans" ) )
            {
                var_3 = var_2.model + "_rev";
                var_4 = spawn( "script_model", var_2.origin );
                level.firingrange.transitionmeshesrev[level.firingrange.transitionmeshesrev.size] = var_4;

                if ( isdefined( var_2.angles ) )
                    var_4.angles = var_2.angles;
                else
                    var_4.angles = ( 0, 0, 0 );

                var_4 setmodel( var_3 );
                var_4 notsolid();
            }
        }
    }
}

showtransition( var_0 )
{
    level endon( "shutdown_hologram" );
    level.firingrange.transitionmeshes = [];

    foreach ( var_2 in level.firingrange.allenvarray[var_0] )
    {
        if ( isdefined( var_2.classname ) && var_2.classname == "script_model" )
        {
            if ( isdefined( var_2.model ) && issubstr( var_2.model, "rec_holo_range" ) )
            {
                var_3 = var_2.model + "_trans";
                var_4 = spawn( "script_model", var_2.origin );
                level.firingrange.transitionmeshes[level.firingrange.transitionmeshes.size] = var_4;

                if ( isdefined( var_2.angles ) )
                    var_4.angles = var_2.angles;
                else
                    var_4.angles = ( 0, 0, 0 );

                var_4 setmodel( var_3 );
                var_4 notsolid();
            }
        }
    }
}

flickertransmeshes( var_0 )
{
    level endon( "shutdown_hologram" );

    if ( isdefined( var_0 ) && isarray( var_0 ) )
    {
        hidemodels( var_0 );
        wait 0.05;
        showmodels( var_0 );
        wait 0.05;
    }
}

showmodels( var_0 )
{
    level endon( "shutdown_hologram" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !isremovedentity( var_2 ) )
        {
            var_2 show();
            var_2 notsolid();
        }
    }
}

hidemodels( var_0 )
{
    level endon( "shutdown_hologram" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !isremovedentity( var_2 ) )
        {
            var_2 hide();
            var_2 notsolid();
        }
    }
}

hidetransitionmeshes()
{
    if ( isarray( level.firingrange.transitionmeshes ) )
    {
        level.firingrange.transitionmeshes = common_scripts\utility::array_remove_duplicates( level.firingrange.transitionmeshes );

        foreach ( var_1 in level.firingrange.transitionmeshes )
        {
            if ( isdefined( var_1 ) && !isremovedentity( var_1 ) )
            {
                var_1 hide();
                var_1 notsolid();
            }
        }
    }
}

deletetransrevmeshes()
{
    if ( isarray( level.firingrange.transitionmeshesrev ) )
    {
        level.firingrange.transitionmeshesrev = common_scripts\utility::array_remove_duplicates( level.firingrange.transitionmeshesrev );

        foreach ( var_1 in level.firingrange.transitionmeshesrev )
        {
            if ( isdefined( var_1 ) && !isremovedentity( var_1 ) )
                var_1 delete();
        }
    }

    level.firingrange.transitionmeshesrev = [];
}

removetransitionmeshes()
{
    if ( isarray( level.firingrange.transitionmeshes ) )
    {
        var_0 = common_scripts\utility::array_remove_duplicates( level.firingrange.transitionmeshes );
        flickertransmeshes( var_0 );
        flickertransmeshes( var_0 );
        wait 0.1;
        flickertransmeshes( var_0 );
        wait 0.1;
        flickertransmeshes( var_0 );

        foreach ( var_2 in var_0 )
        {
            if ( isdefined( var_2 ) && !isremovedentity( var_2 ) )
                var_2 delete();
        }
    }
}

removerevnmeshes()
{
    if ( isarray( level.firingrange.scanlinemeshes ) )
    {
        level.firingrange.scanlinemeshes = common_scripts\utility::array_remove_duplicates( level.firingrange.scanlinemeshes );

        foreach ( var_1 in level.firingrange.scanlinemeshes )
        {
            if ( isdefined( var_1 ) && !isremovedentity( var_1 ) )
                var_1 delete();
        }
    }
}

movefloorpanelup()
{
    level endon( "shutdown_hologram" );
    var_0 = randomfloatrange( 0.0, 1 );
    wait(var_0);
    self setmodel( "rec_holo_emitter_floor_on" );
    self moveto( self.up_position, 0.25, 0.1, 0.1 );
}

movefloorpaneldown()
{
    level endon( "start_round" );
    self setmodel( "rec_holo_emitter_floor_off" );
    var_0 = randomfloatrange( 0.0, 1 );
    wait(var_0);
    self moveto( self.og_position, 0.25, 0.1, 0.1 );
}

shutdownround( var_0, var_1 )
{
    level notify( "shutdown_hologram" );
    level.firingrange.isshuttingdown = 1;
    var_1 setclientomnvar( "ui_vlobby_round_state", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_timer", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_damage", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_distance", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_hits", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_fired", 0 );
    var_1 setclientomnvar( "ui_vlobby_round_accuracy", 0 );
    var_1 thread grenadecleanup( 1 );
    thread removetransitionmeshes();
    thread deletetransrevmeshes();
    thread snd_play_linked_firingrange( "mp_shooting_range_disappear", var_1 );

    foreach ( var_3 in level.firingrange.allfloorpannels )
        var_3 thread movefloorpaneldown();

    thread snd_play_linked_firingrange( "mp_shooting_range_panels_up", var_1 );

    foreach ( var_6 in level.firingrange.allenvarray[var_0] )
    {
        var_6 hide();
        var_6 notsolid();
    }

    if ( level.nextgen )
        thread lerp_spot_intensity_array( "lt_shootingrange", 0.25, 6000 );

    thread lerp_spot_intensity( "lt_shootingrange_bounce", 0.25, 3000 );
    thread lerp_spot_intensity( "lt_hologram_blue", 0.25, 0.01 );

    foreach ( var_9 in level.firingrange.alltargetsarray[var_0] )
    {
        foreach ( var_11 in var_9 )
        {
            if ( var_11.alive == 1 )
            {
                var_12 = var_11.origin;
                var_13 = var_11.angles;
                thread particlespawn( level.firingrange.vfxtargetspawnout, var_12, var_13, 3 );
            }

            var_11 dontinterpolate();
            var_11.aimassist_target disableaimassist();
            var_11.origin = var_11.original_position;
            var_11.angles = var_11.original_orientation;
            var_11.aimassist_target hide();
            var_11.aimassist_target notsolid();
            var_11 hide();
            var_11 notsolid();
            var_11 thermaldrawdisable();
            var_11.alive = 0;
        }
    }

    foreach ( var_17 in level.firingrange.all3duiscreens )
        var_17 hide();

    level.firingrange.minpoint = undefined;
    level.firingrange.maxpoint = undefined;
    level.firingrange.minpointmodpos = undefined;
    level.firingrange.presseddown = 0;
    level.firingrange.pressedup = 0;
    level.firingrange.damagedone = 0;
    level.firingrange.rangeinmeters = 0;
    level.firingrange.shotsfired = 0;
    level.firingrange.shotshit = 0;
    level.firingrange.percent = 0;
    level.firingrange.roundactive = 0;
    level.firingrange.shouldupdateluadisplay = 1;
    var_1 setclientomnvar( "ui_vlobby_round_distance", level.firingrange.rangeinmeters );
    var_1 setclientomnvar( "ui_vlobby_round_damage", level.firingrange.damagedone );
    var_1 setclientomnvar( "ui_vlobby_round_hits", level.firingrange.shotshit );
    var_1 setclientomnvar( "ui_vlobby_round_fired", level.firingrange.shotsfired );
    var_1 setclientomnvar( "ui_vlobby_round_accuracy", level.firingrange.percent );
    level.firingrange.isshuttingdown = 0;
}

spawntarget()
{
    level endon( "shutdown_hologram" );
    var_0 = self.origin;
    var_1 = self.angles;
    thread particlespawn( level.firingrange.vfxtargetspawn, var_0, var_1, 3 );
    thread snd_play_linked_firingrange( "mp_shooting_range_red_appear", self );
    wait 0.05;
    self show();
    self solid();
    self thermaldrawenable();
}

scalesoundsonexit()
{
    level notify( "ScaleSoundsOnExit" );
    level endon( "ScaleSoundsOnExit" );

    if ( isdefined( level.in_firingrange ) )
    {
        for (;;)
        {
            wait 0.05;

            if ( level.in_firingrange == 1 || getdvarint( "virtualLobbyInFiringRange", 0 ) == 1 )
                continue;
            else
            {
                level.firingrange.soundents = common_scripts\utility::array_remove_duplicates( level.firingrange.soundents );

                foreach ( var_1 in level.firingrange.soundents )
                    var_1 scalevolume( 0, 0.5 );
            }
        }
    }
}

enter_firingrange( var_0 )
{
    level.in_firingrange = 1;
    thread wait_start_firingrange( 0.4, var_0 );
}

wait_start_firingrange( var_0, var_1 )
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
    var_2 = getgroundposition( level.firingrange.fr_start.origin, 20, 512, 120 );
    var_1 dontinterpolate();
    var_1 setorigin( var_2 );
    var_1 setangles( level.firingrange.fr_start.angles );
    var_1 setclientdvar( "cg_fovscale", "1.0" );
    level.firingrange.isshuttingdown = 0;
    maps\mp\_vl_camera::virtual_lobby_set_class( 0, "lobby" + ( var_1.currentselectedclass + 1 ), 1, 1 );
    var_1 chargebattery( var_1.loadoutoffhand );
    var_1 chargebattery( var_1.loadoutequipment );
    maps\mp\_utility::updatesessionstate( "playing" );
    var_1 setclienttriggervisionset( "mp_virtual_lobby_fr", 0 );
    var_1 lightsetforplayer( "mp_vl_firingrange" );
    var_1 thread maps\mp\_vl_base::enable_player_controls();
    level.firingrange.soundents = [];
    var_1 thread scalesoundsonexit();

    if ( !var_1 maps\mp\_utility::_hasperk( "specialty_wildcard_dualtacticals" ) && maps\mp\gametypes\_class::isvalidequipment( var_1.loadoutequipment, 0 ) && !isbadequipment( var_1.loadoutequipment ) )
        var_1 thread monitor_grenade_count( var_1.loadoutequipment, 0 );

    if ( var_1 maps\mp\_utility::_hasperk( "specialty_wildcard_duallethals" ) && maps\mp\gametypes\_class::isvalidequipment( var_1.loadoutoffhand, 0 ) && !isbadequipment( var_1.loadoutoffhand ) )
        var_1 thread monitor_grenade_count( var_1.loadoutoffhand, 1 );

    if ( var_1.primaryweapon != "specialty_null" && var_1.primaryweapon != "none" && var_1.primaryweapon != "iw5_combatknife_mp" && !issubstr( var_1.primaryweapon, "em1" ) && !issubstr( var_1.primaryweapon, "epm3" ) && !issubstr( var_1.primaryweapon, "dlcgun1_mp" ) && !issubstr( var_1.primaryweapon, "dlcgun1loot" ) && !issubstr( var_1.primaryweapon, "dlcgun9loot6" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot4" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot6" ) )
    {
        var_1 thread monitor_weapon_ammo_count( var_1.primaryweapon );

        if ( issubstr( var_1.primaryweapon, "_gl" ) )
            var_1 thread monitor_weapon_ammo_count( "alt_" + var_1.primaryweapon );
    }

    if ( var_1.secondaryweapon != "specialty_null" && var_1.secondaryweapon != "none" && var_1.secondaryweapon != "iw5_combatknife_mp" && !issubstr( var_1.secondaryweapon, "em1" ) && !issubstr( var_1.secondaryweapon, "epm3" ) && !issubstr( var_1.primaryweapon, "dlcgun1_mp" ) && !issubstr( var_1.primaryweapon, "dlcgun1loot" ) && !issubstr( var_1.primaryweapon, "dlcgun9loot6" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot4" ) && !issubstr( var_1.primaryweapon, "dlcgun10loot6" ) )
    {
        var_1 thread monitor_weapon_ammo_count( var_1.secondaryweapon );

        if ( issubstr( var_1.secondaryweapon, "_gl" ) )
            var_1 thread monitor_weapon_ammo_count( "alt_" + var_1.secondaryweapon );
    }
}

chargebattery( var_0 )
{
    var_1 = maps\mp\_utility::strip_suffix( var_0, "_lefthand" );

    if ( var_1 != "none" && var_1 != "specialty_null" && maps\mp\gametypes\_class::isvalidoffhand( var_1, 0 ) )
    {
        self batteryfullrecharge( var_1 );
        self batterysetdischargescale( var_1, 1 );
    }
}

isbadequipment( var_0 )
{
    switch ( var_0 )
    {
        case "exoknife_mp_lefthand":
        case "exoknife_mp":
        case "specialty_null":
        case "none":
            return 1;
        default:
            return 0;
    }
}

giveplayerconroldelayed()
{
    self endon( "enter_lobby" );
    wait 2;
    var_0 = getdvarint( "virtualLobbyInFiringRange", 0 );

    if ( var_0 == 1 && level.in_firingrange == 1 )
        self allowfire( 1 );
}

activate_targets( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = self;
    level.firingrange.last_target = undefined;
    thread monitortime( var_1 );
    thread monitorshotsfired( var_1 );
    thread monitorhitpercent( var_1 );

    foreach ( var_3 in level.firingrange.alltargetsarray[var_0] )
    {
        foreach ( var_5 in var_3 )
            var_5 thread monitordamage( var_1 );
    }

    thread displayboothholo( var_1, var_0 );
    var_8 = level.firingrange.alltargetsarray[var_0].size;
    var_9 = level.firingrange.alltargetsarray[var_0];

    for ( var_10 = 0; var_10 < var_8; var_10++ )
    {
        thread startwave( var_9[var_10], var_1 );
        level waittill( "wave_done" );
        wait 0.05;
    }

    level notify( "round_done" );
    thread maps\mp\_audio::snd_play_in_space( "mp_shooting_range_panels_bell", level.firingrange.audio_buzzer_struct.origin );
    level.firingrange.roundactive = 0;
    var_1 setclientomnvar( "ui_vlobby_round_state", 2 );
}

monitortime( var_0 )
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
            level.firingrange.time = 0;
            var_0 setclientomnvar( "ui_vlobby_round_timer", level.firingrange.time );
            var_0 setclientomnvar( "ui_vlobby_round_state", 0 );
            thread shutdownround( level.firingrange.roundnumber, var_0 );
            return;
        }
        else if ( var_4 < 0 )
        {
            level.firingrange.time = 0;
            var_0 setclientomnvar( "ui_vlobby_round_timer", level.firingrange.time );
            var_0 setclientomnvar( "ui_vlobby_round_state", 0 );
            thread shutdownround( level.firingrange.roundnumber, var_0 );
            return;
        }
        else
        {
            level.firingrange.time = var_4;
            var_0 setclientomnvar( "ui_vlobby_round_timer", level.firingrange.time );
        }

        wait 0.05;
    }
}

startwave( var_0, var_1 )
{
    level endon( "shutdown_hologram" );
    var_2 = 0;
    thread maps\mp\_audio::snd_play_in_space( "mp_shooting_range_panels_bell", level.firingrange.audio_buzzer_struct.origin );

    foreach ( var_4 in var_0 )
        var_4 thread target_lifetime( var_1 );

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

target_lifetime( var_0 )
{
    level endon( "shutdown_hologram" );
    self.original_position = self.origin;
    self.original_orientation = self.angles;
    self.alive = 1;
    spawntarget();
    thread target_handler( var_0 );
    thread target_logic();
    thread target_handle_death();
    thread target_handle_stop();
}

particlespawn( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    if ( !isdefined( var_2 ) )
        var_2 = ( 0, 0, 0 );

    var_5 = spawnfx( var_0, var_1, anglestoforward( var_2 ), anglestoup( var_2 ) );

    if ( isdefined( var_4 ) )
        setfxkillondelete( var_5, var_4 );

    triggerfx( var_5 );

    if ( isdefined( var_3 ) )
    {
        wait(var_3);

        if ( isdefined( var_5 ) && !isremovedentity( var_5 ) )
            var_5 delete();
    }
    else
    {
        level waittill( "shutdown_hologram" );

        if ( isdefined( var_5 ) && !isremovedentity( var_5 ) )
            var_5 delete();
    }
}

target_logic()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );

    if ( isdefined( self.script_parameters ) )
    {
        var_0 = self.script_parameters;
        movetargettodest();

        switch ( var_0 )
        {
            case "stand":
                break;
            case "cover":
                thread popinpopout();
                break;
            case "move":
                thread movebackforth();
                break;
        }
    }
}

movetargettodest()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );

    if ( !isdefined( level.firingrange.roundnumber ) )
        return;

    var_0 = level.firingrange.roundnumber;
    var_1 = common_scripts\utility::getclosest( self.origin, level.firingrange.alltargetlogicarray[var_0] );
    self.current_ent = var_1;
    self.last_ent = self.current_ent;

    for (;;)
    {
        if ( isdefined( self ) )
        {
            var_2 = distance( self.current_ent.origin, self.origin );
            var_3 = var_2 / level.firingrange.round_target_unit_per_second;

            if ( isdefined( self.current_ent.script_noteworthy ) && self.current_ent.script_noteworthy == "jump" )
                self moveto( self.current_ent.origin, var_3 * 0.5, 0, 0.1 );
            else if ( isdefined( self.last_ent.script_noteworthy ) && self.last_ent.script_noteworthy == "jump" )
                self moveto( self.current_ent.origin, var_3 * 0.5, 0.1, 0 );
            else
                self moveto( self.current_ent.origin, var_3 );

            self waittill( "movedone" );

            if ( isdefined( self.current_ent.target ) )
            {
                var_4 = getent( self.current_ent.target, "targetname" );
                self.last_ent = self.current_ent;
                self.current_ent = var_4;
            }
            else
                return;
        }
        else
            return;
    }
}

popinpopout()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );
    var_0 = 4;
    var_1 = 1;
    var_2 = self.current_ent.origin;
    var_3 = self.last_ent.origin;

    if ( self.current_ent == self.last_ent )
        var_3 = self.original_position;

    wait(var_0);

    for (;;)
    {
        if ( isdefined( self ) )
        {
            var_4 = distance( var_3, var_2 );
            var_5 = var_4 / level.firingrange.round_target_unit_per_second;
            self moveto( var_3, var_5 );
            self waittill( "movedone" );
            wait(var_1);
            var_4 = distance( var_3, var_2 );
            var_5 = var_4 / level.firingrange.round_target_unit_per_second;
            self moveto( var_2, var_5 );
            self waittill( "movedone" );
            wait(var_0);
        }
    }
}

movebackforth()
{
    level endon( "shutdown_hologram" );
    self endon( "death" );
    var_0 = undefined;
    var_1 = undefined;

    if ( isdefined( self.last_ent.script_noteworthy ) && self.last_ent.script_noteworthy == "jump" )
    {
        var_0 = self.last_ent;
        var_1 = var_0.origin;
        self.last_ent = getent( var_0.targetname, "target" );
    }

    var_2 = self.current_ent.origin;
    var_3 = self.last_ent.origin;

    if ( self.current_ent == self.last_ent )
        var_3 = self.original_position;

    for (;;)
    {
        if ( isdefined( self ) )
        {
            if ( isdefined( var_1 ) )
            {
                wait 2;
                var_4 = distance( var_1, var_2 );
                var_5 = var_4 / level.firingrange.round_target_unit_per_second;
                self moveto( var_1, var_5 * 0.5, 0, 0.1 );
                self waittill( "movedone" );
                var_4 = distance( var_1, var_3 );
                var_5 = var_4 / level.firingrange.round_target_unit_per_second;
                self moveto( var_3, var_5 * 0.5, 0.1, 0 );
                self waittill( "movedone" );
                wait 2;
                var_4 = distance( var_1, var_3 );
                var_5 = var_4 / level.firingrange.round_target_unit_per_second;
                self moveto( var_1, var_5 * 0.5, 0, 0.1 );
                self waittill( "movedone" );
                var_4 = distance( var_1, var_2 );
                var_5 = var_4 / level.firingrange.round_target_unit_per_second;
                self moveto( var_2, var_5 * 0.5, 0.1, 0 );
                self waittill( "movedone" );
            }
            else
            {
                var_4 = distance( var_3, var_2 );
                var_5 = var_4 / level.firingrange.round_target_unit_per_second;
                self moveto( var_3, var_5 );
                self waittill( "movedone" );
                var_4 = distance( var_2, var_3 );
                var_5 = var_4 / level.firingrange.round_target_unit_per_second;
                self moveto( var_2, var_5 );
                self waittill( "movedone" );
            }
        }
    }
}

score_handler()
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

target_handler( var_0 )
{
    level endon( "shutdown_hologram" );
    self.hits = [];
    self.aimassist_target.health = 9999;
    self.aimassist_target.maxhealth = 9999;
    self.maxhealth = 9999;
    self.health = self.maxhealth;
    self.fakehealth = 100;
    self setcandamage( 1 );
    self.aimassist_target show();
    self.aimassist_target solid();
    self.aimassist_target enableaimassist();

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
        var_11 = getmodifier( var_10, var_8, var_0 );
        var_12 = self gettagorigin( "tag_head" );
        var_13 = self gettagorigin( "tag_chest" );
        self.health = self.maxhealth;
        var_14 = self.fakehealth;
        var_14 = float( var_14 ) - float( var_1 ) * var_11;
        var_14 = maps\mp\_utility::rounddecimalplaces( var_14, 0 );
        self.fakehealth = int( var_14 );

        if ( self.fakehealth <= 0 )
        {
            thread targetplaydeath( var_13 );
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

targetplaydeath( var_0 )
{
    playfx( level._effect["recovery_scoring_target_shutter_enemy"], var_0 );
}

deactivate_targets()
{
    level notify( "shutdown_hologram" );
}

firing_range_setup_triggers()
{
    var_0 = getentarray( "firing_range_round_trigger", "targetname" );
    return var_0;
}

firing_range_setup_target_logic()
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

firing_range_setup_env()
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

firing_range_setup_env_vfx()
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

firing_range_setup_targets()
{
    var_0 = getentarray( "target_enemy", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_3.alive = 0;
        var_3.pers["team"] = "axis";
        var_3.team = "axis";
        var_3.origin_ent = getent( var_3.target, "targetname" );
        var_3.aimassist_target = getent( var_3.origin_ent.target, "targetname" );
        var_3.aimassist_target vehicle_jetbikesethoverforcescale( var_3 );
        var_3.aimassist_target.pers["team"] = "axis";
        var_3.aimassist_target.team = "axis";
        var_3.original_position = var_3.origin;
        var_3.original_orientation = var_3.angles;
        var_3.aimassist_target hide();
        var_3.aimassist_target notsolid();
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

            if ( isdefined( var_3.script_group ) )
            {
                var_6 = int( var_3.script_group );

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

target_handle_death()
{
    level endon( "shutdown_hologram" );
    self waittill( "death" );
    level notify( "target_died" );
    target_reset();
}

target_handle_stop()
{
    self endon( "death" );
    level waittill( "shutdown_hologram" );
    target_reset();
}

target_reset()
{
    self setcandamage( 0 );
    self hide();
    self notsolid();
    self.alive = 0;

    if ( isdefined( self.aimassist_target ) )
        self.aimassist_target disableaimassist();
}

lerp_spot_intensity( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    if ( level.currentgen && isdefined( var_3 ) == 0 )
        return;

    var_4 = var_3 getlightintensity();
    var_3.endintensity = var_2;
    var_5 = 0;

    while ( var_5 < var_1 )
    {
        var_6 = var_4 + ( var_2 - var_4 ) * var_5 / var_1;
        var_5 += 0.05;
        var_3 setlightintensity( var_6 );
        wait 0.05;
    }

    var_3 setlightintensity( var_2 );
}

lerp_spot_intensity_array( var_0, var_1, var_2 )
{
    var_3 = getentarray( var_0, "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_6 = var_5 getlightintensity();
        var_5.endintensity = var_2;
        var_7 = 0;

        while ( var_7 < var_1 )
        {
            var_8 = var_6 + ( var_2 - var_6 ) * var_7 / var_1;
            var_7 += 0.05;
            var_5 setlightintensity( var_8 );
            wait 0.05;
        }

        var_5 setlightintensity( var_2 );
    }
}

monitor_weapon_ammo_count( var_0 )
{
    self endon( "enter_lobby" );

    while ( level.in_firingrange == 1 )
    {
        var_1 = self getfractionmaxammo( var_0 );

        if ( var_1 <= 0.25 )
        {
            self givemaxammo( var_0 );
            continue;
        }

        wait 0.5;
    }
}

riotshieldcleanup()
{
    if ( isdefined( self.riotshieldentity ) )
        self.riotshieldentity thread maps\mp\_riotshield::damagethendestroyriotshield();
}

grenadecleanup( var_0 )
{
    if ( isdefined( level.grenades ) && isarray( level.grenades ) )
    {
        foreach ( var_2 in level.grenades )
        {
            if ( isdefined( var_2 ) && !isremovedentity( var_2 ) )
            {
                if ( !isdefined( self ) || !isdefined( var_2.owner ) || isremovedentity( var_2.owner ) )
                {
                    if ( !isdefined( var_2.weaponname ) )
                        continue;
                    else if ( maps\mp\_utility::strip_suffix( var_2.weaponname, "_lefthand" ) == "explosive_drone_mp" )
                        var_2 thread maps\mp\_explosive_drone::explosivegrenadedeath();
                    else
                    {
                        var_2 notify( "death" );
                        var_2 thread delaydelete();
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

                                if ( var_3 == 1 && level.in_firingrange == 1 )
                                    var_2 maps\mp\_exoknife::exo_knife_restock();
                            }
                            else
                            {
                                var_2 notify( "death" );
                                var_2 thread delaydelete();
                            }

                            continue;
                        }

                        var_2 notify( "death" );
                        var_2 thread delaydelete();
                    }
                }
            }
        }
    }

    thread dronecleanup();
}

dronecleanup()
{
    if ( isdefined( level.trackingdrones ) && isarray( level.trackingdrones ) )
    {
        foreach ( var_1 in level.trackingdrones )
        {
            if ( isdefined( var_1 ) && !isremovedentity( var_1 ) )
            {
                if ( !isdefined( self ) || !isdefined( var_1.owner ) || isremovedentity( var_1.owner ) )
                {
                    var_1 thread maps\mp\_tracking_drone::trackingdroneexplode();
                    continue;
                }

                if ( var_1.owner == self )
                    var_1 thread maps\mp\_tracking_drone::trackingdroneexplode();
            }
        }
    }
}

delaydelete()
{
    wait 0.05;

    if ( isdefined( self ) && !isremovedentity( self ) )
        self delete();
}

monitor_grenade_count( var_0, var_1 )
{
    self endon( "enter_lobby" );
    var_2 = 0;
    var_3 = maps\mp\_utility::strip_suffix( var_0, "_lefthand" );

    if ( var_3 == "smoke_grenade_var_mp" || var_3 == "stun_grenade_var_mp" || var_3 == "emp_grenade_var_mp" || var_3 == "paint_grenade_var_mp" )
        var_2 = 1;

    if ( var_3 == "explosive_drone_mp" )
        thread enforceexplosivedronelimit();

    while ( level.in_firingrange == 1 )
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

enforceexplosivedronelimit()
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
                    if ( isdefined( var_0 ) && !isremovedentity( var_0 ) && isdefined( self ) && isdefined( var_0.owner ) && isdefined( var_0.weaponname ) )
                    {
                        if ( maps\mp\_utility::strip_suffix( var_0.weaponname, "_lefthand" ) == "explosive_drone_mp" && var_0.owner == self )
                        {
                            if ( isdefined( var_0.explosivedrone ) )
                            {
                                var_0.explosivedrone thread maps\mp\_explosive_drone::explosiveheaddeath();
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

showtransition_cg( var_0 )
{
    level endon( "shutdown_hologram" );
    var_1 = 0;
    var_2 = [];

    foreach ( var_4 in level.firingrange.allenvarray[var_0] )
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

hidetransitionmeshes_cg( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in level.firingrange.allenvarray[var_0] )
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
