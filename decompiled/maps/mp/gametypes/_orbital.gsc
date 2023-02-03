// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precacheorbital()
{
    precachemodel( "tag_player" );
    precachemodel( "vehicle_ac130_coop" );
    precachemodel( "vehicle_drop_pod_base" );
    precachemodel( "vehicle_drop_pod_base_enemy" );
    precachempanim( "mp_orbital_pod_base_unfold" );
    game["dialog"]["orbital_pod_destroyed"] = "orbital_pod_destroyed";
    game["dialog"]["orbital_pod_destroyed_enemy"] = "orbital_pod_destroyed_enemy";
    game["dialog"]["orbital_dropin"] = "orbital_dropin";
    game["dialog"]["orbital_notgood_tryhard"] = "orbital_notgood_tryhard";
    level.drop_pod_effect["pod_base_destroyed"] = loadfx( "vfx/explosion/orbital_pod_base_explosion" );
    level.drop_pod_effect["dome_impact_flash"] = loadfx( "vfx/unique/orbital_dome_impact_flash" );
    level.drop_pod_effect["dome_shutdown_friendly"] = loadfx( "vfx/unique/orbital_dome_shutdown_friendly" );
    level.drop_pod_effect["dome_shutdown_enemy"] = loadfx( "vfx/unique/orbital_dome_shutdown_enemy" );
    level.drop_pod_effect["player_spawn_from_pod"] = loadfx( "vfx/ui/drop_pod_spawn_point_active" );
    level.drop_pod_effect["drop_pod_fire_flash"] = loadfx( "vfx/unique/orbital_drop_pod_fire_flash" );
    level.drop_pod_effect["decel_explosion"] = loadfx( "vfx/explosion/orbital_pod_decel_explosion" );
    level.drop_pod_effect["dome_impact"] = loadfx( "vfx/explosion/orbital_pod_impact_dome" );
    level.drop_pod_effect["landing_impact"] = loadfx( "vfx/smoke/drop_pod_landing_impact" );
    level.drop_pod_effect["drop_pod_explode"] = loadfx( "vfx/explosion/orbital_drop_pod_explode" );
    level.drop_pod_effect["drop_pod_spike_impact"] = loadfx( "vfx/weaponimpact/drop_pod_spike_impact" );
    var_0 = getdvar( "mapname" );

    switch ( var_0 )
    {
        case "mp_refraction":
            level.drop_pod_dome["friendly"] = loadfx( "vfx/unique/orbital_dome_friendly_ref" );
            level.drop_pod_dome["enemy"] = loadfx( "vfx/unique/orbital_dome_enemy_ref" );
            level.drop_pod_dome_ground["friendly"] = loadfx( "vfx/unique/orbital_dome_ground_friendly_ref" );
            level.drop_pod_dome_ground["enemy"] = loadfx( "vfx/unique/orbital_dome_ground_enemy_ref" );
            break;
        default:
            level.drop_pod_dome["friendly"] = loadfx( "vfx/unique/orbital_dome_friendly" );
            level.drop_pod_dome["enemy"] = loadfx( "vfx/unique/orbital_dome_enemy" );
            level.drop_pod_dome_ground["friendly"] = loadfx( "vfx/unique/orbital_dome_ground_friendly" );
            level.drop_pod_dome_ground["enemy"] = loadfx( "vfx/unique/orbital_dome_ground_enemy" );
            break;
    }
}

initializeoribtalmode()
{
    precacheorbital();
    level.drop_pod = spawnstruct();
    level.drop_pod.model = "vehicle_drop_pod_base";
    level.drop_pod.enemy_model = "vehicle_drop_pod_base_enemy";
    level.drop_pod.deploy_delay = 2;
    level.drop_pod_volume_array = getentarray( "drop_pod_volume", "targetname" );
    level.drop_pod_bad_spawn_overlay = getentarray( "orbital_bad_spawn_overlay", "targetname" );
    level.orbital_ships = spawnstruct();
    level.forcerespawn_time = 15;
    var_0 = getdvar( "mapname" );

    switch ( var_0 )
    {
        case "mp_refraction":
            setdvar( "missileRemoteSteerPitchRange", "37 88" );
            level.left_loop_start = getent( "orbital_plane_left_loop_start", "targetname" );
            level.left_big_loop_start = getent( "orbital_plane_left_big_loop_start", "targetname" );
            level.right_loop_start = getent( "orbital_plane_right_loop_start", "targetname" );
            level.right_big_loop_start = getent( "orbital_plane_right_big_loop_start", "targetname" );
            level.left_pivot = getent( "orbital_left_loop_pivot", "targetname" );
            level.left_big_pivot = getent( "orbital_left_big_loop_pivot", "targetname" );
            level.right_pivot = getent( "orbital_right_loop_pivot", "targetname" );
            level.right_big_pivot = getent( "orbital_right_big_loop_pivot", "targetname" );
            level.orbital_ships.missilespawn["target"] = getent( "orbitalMissileTarget", "targetname" );
            level.orbital_ships.cameraview["allies"] = spawn( "script_model", level.left_loop_start.origin );
            level.orbital_ships.cameraview["allies"] setmodel( "tag_player" );
            level.orbital_ships.cameraview["allies"].angles += ( 0, 220, 0 );
            level.orbital_ships.cameraview["allies"].team = "allies";
            level.orbital_ships.cameraview["allies"] vehicle_jetbikesethoverforcescale( level.left_pivot );
            level.orbital_ships.cameraview["allies"].track = "left";
            level.orbital_ships.cameraview["allies"] hide();
            level.orbital_ships.cameraview["axis"] = spawn( "script_model", level.left_big_loop_start.origin );
            level.orbital_ships.cameraview["axis"] setmodel( "tag_player" );
            level.orbital_ships.cameraview["axis"].angles += ( 0, 330, 0 );
            level.orbital_ships.cameraview["axis"].team = "axis";
            level.orbital_ships.cameraview["axis"] vehicle_jetbikesethoverforcescale( level.left_big_pivot );
            level.orbital_ships.cameraview["axis"].track = "left_big";
            level.orbital_ships.cameraview["axis"] hide();
            level.orbital_ships.ship["allies"] = spawn( "script_model", level.left_loop_start.origin );
            level.orbital_ships.ship["allies"] setmodel( "vehicle_ac130_coop" );
            level.orbital_ships.ship["allies"].angles += ( 0, 220, 0 );
            level.orbital_ships.ship["allies"] vehicle_jetbikesethoverforcescale( level.orbital_ships.cameraview["allies"], "", ( 0, 0, 80 ), ( 0, 0, 0 ) );
            level.orbital_ships.ship["axis"] = spawn( "script_model", level.left_big_loop_start.origin );
            level.orbital_ships.ship["axis"] setmodel( "vehicle_ac130_coop" );
            level.orbital_ships.ship["axis"].angles += ( 0, 330, 0 );
            level.orbital_ships.ship["axis"] vehicle_jetbikesethoverforcescale( level.orbital_ships.cameraview["axis"], "", ( 0, 0, 80 ), ( 0, 0, 0 ) );
            thread rotateorbitalshippivots();
            level.orbital_ships.cameraview["allies"] thread monitortrackswitching();
            level.orbital_ships.cameraview["axis"] thread monitortrackswitching();
            break;
        default:
            setdvar( "missileRemoteSteerPitchRange", "47 88" );
            var_1 = getent( "airstrikeheight", "targetname" );
            var_2 = getentarray( "minimap_corner", "targetname" );

            if ( var_2.size == 2 )
                level.orbital_ships.center = maps\mp\gametypes\_spawnlogic::findboxcenter( var_2[0].origin, var_2[1].origin );
            else
            {

            }

            level.orbital_ships.dist_from_center = 3500;
            level.orbital_ships.extra_height = 2000;
            level.orbital_ships.center *= ( 1, 1, 0 );
            level.orbital_ships.center += ( 0, 0, var_1.origin[2] + level.orbital_ships.extra_height );
            var_3 = level.orbital_ships.center;
            var_4 = ( 0, 0, 0 );
            var_5 = ( 0, 180, 0 );
            var_6 = var_3 + anglestoforward( var_4 ) * level.orbital_ships.dist_from_center;
            var_7 = var_3 + anglestoforward( var_5 ) * level.orbital_ships.dist_from_center;
            level.orbital_ships.script_origin = spawn( "script_origin", level.orbital_ships.center );
            level.orbital_ships.cameraview["allies"] = spawn( "script_model", var_6 );
            level.orbital_ships.cameraview["allies"] setmodel( "tag_player" );
            level.orbital_ships.cameraview["allies"].angles += ( 0, 180, 0 );
            level.orbital_ships.cameraview["allies"] vehicle_jetbikesethoverforcescale( level.orbital_ships.script_origin );
            level.orbital_ships.cameraview["allies"] hide();
            level.orbital_ships.cameraview["axis"] = spawn( "script_model", var_7 );
            level.orbital_ships.cameraview["axis"] setmodel( "tag_player" );
            level.orbital_ships.cameraview["axis"].angles += ( 0, 0, 0 );
            level.orbital_ships.cameraview["axis"] vehicle_jetbikesethoverforcescale( level.orbital_ships.script_origin );
            level.orbital_ships.cameraview["axis"] hide();
            level.orbital_ships.missilespawn["target"] = spawn( "script_origin", level.orbital_ships.center - ( 0, 0, 7000 ) );
            level.orbital_ships.missilespawn["target"].targetname = "orbitalMissileTarget";
            level.orbital_ships.ship["allies"] = spawn( "script_model", var_6 );
            level.orbital_ships.ship["allies"] setmodel( "vehicle_ac130_coop" );
            level.orbital_ships.ship["allies"].angles += ( 0, 180, 0 );
            level.orbital_ships.ship["allies"] vehicle_jetbikesethoverforcescale( level.orbital_ships.cameraview["allies"], "", ( 0, 0, 100 ), ( 15, 0, 0 ) );
            level.orbital_ships.ship["axis"] = spawn( "script_model", var_7 );
            level.orbital_ships.ship["axis"] setmodel( "vehicle_ac130_coop" );
            level.orbital_ships.ship["axis"].angles += ( 0, 0, 0 );
            level.orbital_ships.ship["axis"] vehicle_jetbikesethoverforcescale( level.orbital_ships.cameraview["axis"], "", ( 0, 0, 100 ), ( 15, 0, 0 ) );
            level.orbital_ships.script_origin thread rotateorbitalships();
            break;
    }

    thread showdroppodbadspawnoverlay();
    thread spawnplayerinorbital();
}

monitortrackswitching()
{
    level endon( "game_ended" );
    self.started_bank = 0;
    level.ship_pos_wait_delay = 0.5;
    var_0 = 4;
    wait 2;

    for (;;)
    {
        var_1 = "none";
        var_2 = self.track;

        switch ( var_2 )
        {
            case "right":
                var_1 = distance( self.origin, level.left_big_loop_start.origin );

                if ( var_1 <= 200 && self.started_bank == 0 )
                    level.ship_pos_wait_delay = 0.05;

                if ( var_1 <= var_0 )
                {
                    self unlink();
                    self.origin = level.left_big_loop_start.origin;
                    self vehicle_jetbikesethoverforcescale( level.left_big_pivot );
                    self.track = "left_big";
                    level.ship_pos_wait_delay = 0.5;
                }

                break;
            case "left_big":
                var_1 = distance( self.origin, level.left_loop_start.origin );

                if ( var_1 <= 200 && self.started_bank == 0 )
                    level.ship_pos_wait_delay = 0.05;

                if ( var_1 <= var_0 )
                {
                    self unlink();
                    self.origin = level.left_loop_start.origin;
                    self vehicle_jetbikesethoverforcescale( level.left_pivot );
                    self.track = "left";
                    level.ship_pos_wait_delay = 0.5;
                }

                break;
            case "left":
                var_1 = distance( self.origin, level.right_big_loop_start.origin );

                if ( var_1 <= 200 && self.started_bank == 0 )
                    level.ship_pos_wait_delay = 0.05;

                if ( var_1 <= var_0 )
                {
                    self unlink();
                    self.origin = level.right_big_loop_start.origin;
                    self vehicle_jetbikesethoverforcescale( level.right_big_pivot );
                    self.track = "right_big";
                    level.ship_pos_wait_delay = 0.5;
                }

                break;
            case "right_big":
                var_1 = distance( self.origin, level.right_loop_start.origin );

                if ( var_1 <= 200 && self.started_bank == 0 )
                    level.ship_pos_wait_delay = 0.05;

                if ( var_1 <= var_0 )
                {
                    self unlink();
                    self.origin = level.right_loop_start.origin;
                    self vehicle_jetbikesethoverforcescale( level.right_pivot );
                    self.track = "right";
                    level.ship_pos_wait_delay = 0.5;
                }

                break;
            default:
                break;
        }

        level._id_2B71 = var_1;
        wait(level.ship_pos_wait_delay);
    }
}

rotateorbitalships()
{
    level endon( "game_ended" );

    for (;;)
    {
        self rotateyaw( 3600, 1200 );
        wait 1199;
    }
}

rotateorbitalshippivots()
{
    level endon( "game_ended" );

    for (;;)
    {
        level.left_pivot rotateyaw( -5400, 1200 );
        level.left_big_pivot rotateyaw( -700, 1200 );
        level.right_pivot rotateyaw( 5400, 1200 );
        level.right_big_pivot rotateyaw( 700, 1200 );
        wait 1199;
    }
}

spawnplayerinorbital()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "player_spawned", var_0 );
        var_0 setclientomnvar( "ui_orbital_toggle_hud", 1 );
        var_0 setclientomnvar( "ui_orbital_is_dropping", 1 );

        if ( !isbot( var_0 ) )
        {
            var_0 disableweapons();
            var_0 playerhide();
            var_0 hideviewmodel();
            var_0 thread setfovscale( 1, 0 );
            var_0.isdropping = 1;
            var_0 thread showdroppodfx();
            var_0 thread playerinorbital();
            var_0 thread waitforspawnfinished();
        }
    }
}

showdroppodfx()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );

    for (;;)
    {
        hidepodfx();

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.isdropping ) )
            {
                if ( var_1.isdropping == 1 )
                {
                    var_1 showpoddroppingfxtoplayer();
                    continue;
                }

                var_1 showpodgroundfxtoplayer();
            }
        }

        wait 0.05;
    }
}

hidepodfx()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.drop_pod ) )
        {
            if ( isdefined( var_1.drop_pod.trophyfx_friendly ) )
                var_1.drop_pod.trophyfx_friendly hide();

            if ( isdefined( var_1.drop_pod.trophyfx_enemy ) )
                var_1.drop_pod.trophyfx_enemy hide();

            if ( isdefined( var_1.drop_pod.trophyfx_ground_friendly ) )
                var_1.drop_pod.trophyfx_ground_friendly hide();

            if ( isdefined( var_1.drop_pod.trophyfx_ground_enemy ) )
                var_1.drop_pod.trophyfx_ground_enemy hide();
        }
    }
}

showpoddroppingfxtoplayer()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.drop_pod ) )
        {
            if ( var_1.team == self.team )
            {
                if ( isdefined( var_1.drop_pod.trophyfx_friendly ) )
                    var_1.drop_pod.trophyfx_friendly showtoplayer( self );
            }

            if ( !( var_1.team == self.team ) )
            {
                if ( isdefined( var_1.drop_pod.trophyfx_enemy ) )
                    var_1.drop_pod.trophyfx_enemy showtoplayer( self );
            }
        }
    }
}

showpodgroundfxtoplayer()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.drop_pod ) )
        {
            if ( var_1.team == self.team )
            {
                if ( isdefined( var_1.drop_pod.trophyfx_ground_friendly ) )
                    var_1.drop_pod.trophyfx_ground_friendly showtoplayer( self );
            }

            if ( !( var_1.team == self.team ) )
            {
                if ( isdefined( var_1.drop_pod.trophyfx_ground_enemy ) )
                    var_1.drop_pod.trophyfx_ground_enemy showtoplayer( self );
            }
        }
    }
}

waitforspawnfinished()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "player_drop_pod_spawned", "player_spawned_at_drop_pod" );
    self.isdropping = 0;
    thread setorbitalview( "off", 0 );
    thread hideoverlays();
    thread destroyplayericons();
}

playerinorbital()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );

    if ( !isbot( self ) )
    {
        if ( !isdefined( self.prematch_over ) )
            self.prematch_over = 0;

        if ( !isdefined( self.respawn_mode ) )
            self.respawn_mode = 0;

        if ( !isdefined( self.mode_button_released ) )
            self.mode_button_released = 0;

        self.spawn_button_released = 0;
        self.is_linked_to_pod = 0;
        self.is_linked_to_ship = 0;

        if ( self.prematch_over == 0 )
        {
            self disableweapons();
            self hideviewmodel();

            if ( !self islinked() )
                linkplayerorbitalship();
        }

        maps\mp\_utility::gameflagwait( "prematch_done" );
        self.prematch_over = 1;
        self disableweapons();
        self hideviewmodel();
        self.forcerespawn_timer = level.forcerespawn_time;
        var_0 = level.forcerespawn_time * 1000.0 + gettime();
        self setclientomnvar( "ui_orbital_toggle_color", 0 );
        self setclientomnvar( "ui_orbital_timer_time", var_0 );
        thread droppodforcerespawn();
        self.forcerespawn = 0;

        if ( isdefined( self.drop_pod ) && self.drop_pod.destroyed == 0 )
            self.respawn_mode = 1;

        for (;;)
        {
            if ( isdefined( self.drop_pod ) && self.drop_pod.destroyed == 0 && self.respawn_mode == 1 )
            {
                if ( self.is_linked_to_pod == 0 )
                {
                    if ( self islinked() )
                        self unlink();

                    linkplayerpod();
                }
            }

            if ( !isdefined( self.drop_pod ) || self.drop_pod.destroyed == 1 || self.respawn_mode == 0 )
            {
                if ( self.is_linked_to_ship == 0 )
                {
                    if ( self islinked() )
                        self unlink();

                    linkplayerorbitalship();
                }
            }

            if ( !self adsbuttonpressed() )
                self.mode_button_released = 1;

            if ( !self attackbuttonpressed() )
                self.spawn_button_released = 1;

            if ( self adsbuttonpressed() && self.mode_button_released == 1 )
            {
                self.mode_button_released = 0;

                if ( self.respawn_mode == 0 && isdefined( self.drop_pod ) && self.drop_pod.destroyed == 0 )
                {
                    self.respawn_mode = 1;

                    if ( self.is_linked_to_pod == 0 )
                    {
                        if ( self islinked() )
                            self unlink();

                        linkplayerpod();
                    }
                }
                else if ( self.respawn_mode == 1 )
                {
                    self.respawn_mode = 0;

                    if ( self.is_linked_to_ship == 0 )
                    {
                        if ( self islinked() )
                            self unlink();

                        linkplayerorbitalship();
                    }
                }
            }
            else if ( self attackbuttonpressed() && self.spawn_button_released == 1 || self.forcerespawn )
            {
                self.spawn_button_released = 0;

                if ( isdefined( self.drop_pod ) && self.drop_pod.destroyed == 0 && self.respawn_mode == 1 && self.is_linked_to_pod == 1 )
                {
                    if ( isdefined( self.drop_pod ) )
                    {
                        if ( isdefined( self.drop_pod.spawn_fx ) )
                            self.drop_pod.spawn_fx delete();
                    }

                    var_1 = self getangles();
                    self unlink();
                    self notify( "player_spawned_at_drop_pod" );
                    thread setorbitalview( "off", 0 );
                    self setangles( var_1 );
                    self setorigin( self.drop_pod.origin );
                    self enableweapons();
                    self playershow();
                    self showviewmodel();
                    return;
                }
                else if ( self.respawn_mode == 0 && self.is_linked_to_ship == 1 )
                {
                    var_2 = _fire( self.lifeid, self );
                    return;
                }
            }

            wait 0.05;
        }
    }
    else
    {
        linkplayerorbitalship();
        var_2 = _fire( self.lifeid, self );

        if ( isdefined( var_2 ) )
        {
            self setorigin( var_2.origin );
            createplayerdroppod( var_2.origin );
            self.drop_pod thread drop_pod_handledeath();
            wait 0.05;
        }
    }
}

linkplayerpod()
{
    self.is_linked_to_pod = 1;
    self.is_linked_to_ship = 0;
    self.isdropping = 0;
    destroyplayericons();
    showplayericons( "friendly" );
    self notify( "switched_to_pod_view" );
    thread setorbitalview( "pod", 0 );
    self dontinterpolate();
    self playerlinkto( self.drop_pod.camera, "tag_player", 0 );
    self.drop_pod.spawn_fx = spawnfx( level.drop_pod_effect["player_spawn_from_pod"], self.drop_pod.origin, self.drop_pod.forward );
    triggerfx( self.drop_pod.spawn_fx );
    thread centerpodspawnview();
}

linkplayerorbitalship()
{
    self.is_linked_to_pod = 0;
    self.is_linked_to_ship = 1;
    self.isdropping = 1;
    destroyplayericons();
    thread showplayericons( "both" );

    if ( !isdefined( self.is_first_drop ) )
        self.is_first_drop = 0;
    else
        thread maps\mp\_utility::leaderdialogonplayer( "orbital_dropin", undefined, undefined, self.origin );

    if ( isdefined( self.drop_pod ) )
    {
        self setclientomnvar( "ui_orbital_toggle_switch", 0 );

        if ( isdefined( self.drop_pod.spawn_fx ) )
            self.drop_pod.spawn_fx delete();
    }
    else
        self setclientomnvar( "ui_orbital_toggle_switch", 1 );

    var_0 = 0.3;
    thread setorbitalview( "ship", 0 );
    var_1 = getdvar( "mapname" );
    self dontinterpolate();

    switch ( var_1 )
    {
        case "mp_refraction":
            self playerlinkto( level.orbital_ships.cameraview[self.pers["team"]], "tag_player", 0, 180, 180, -40, 80, 0 );
            break;
        default:
            self playerlinkto( level.orbital_ships.cameraview[self.pers["team"]], "tag_player", 1, 90, 90, -50, 80, 0 );
            break;
    }

    thread centerorbitalview();
    self setclientomnvar( "ui_orbital_collision_warn", 0 );
    thread tracecollisionwarn();
}

unlinkplayer()
{
    self dontinterpolate();
    self controlsunlink();
    self cameraunlink();
    self unlink();
    self freezecontrols( 1 );
    self enableweapons();
    self showviewmodel();
}

centerorbitalview()
{
    var_0 = level.orbital_ships.cameraview[self.pers["team"]].origin;
    var_1 = level.orbital_ships.missilespawn["target"].origin;
    var_2 = vectortoangles( var_1 - var_0 );
    self setangles( var_2 );
}

centerpodspawnview()
{
    var_0 = self.drop_pod.camera.origin;
    var_1 = level.orbital_ships.missilespawn["target"].origin;
    var_2 = vectortoangles( var_1 - var_0 );
    var_2 *= ( 0, 1, 0 );
    self setangles( var_2 );
}

setorbitalview( var_0, var_1 )
{
    self setclientomnvar( "ui_orbital_toggle_ship_view", 2 );
    self setclientomnvar( "ui_orbital_toggle_pod_view", 2 );
    self setclientomnvar( "ui_orbital_toggle_drop_view", 2 );
    wait(var_1);

    switch ( var_0 )
    {
        case "ship":
            self setclientomnvar( "ui_orbital_toggle_ship_view", 1 );
            break;
        case "pod":
            self setclientomnvar( "ui_orbital_collision_warn", 0 );
            self setclientomnvar( "ui_orbital_toggle_pod_view", 1 );
            break;
        case "drop":
            self setclientomnvar( "ui_orbital_toggle_drop_view", 1 );
            break;
        case "off":
            self setclientomnvar( "ui_orbital_is_dropping", 0 );
            break;
        default:
            break;
    }
}

tracecollisionwarn()
{
    self endon( "player_drop_pod_spawned" );
    self endon( "disconnect" );
    self endon( "player_spawned_at_drop_pod" );
    self endon( "joined_team" );
    self endon( "death" );
    self endon( "switched_to_pod_view" );

    for (;;)
    {
        var_0 = self getangles();
        var_1 = self geteye() + anglestoforward( var_0 ) * 20;
        var_2 = var_1 + anglestoforward( var_0 ) * 30000;
        var_3 = playerphysicstraceinfo( var_1, var_2 );
        var_3["position"] += ( 0, 0, 10 );
        level.trace = var_3;

        if ( isdefined( var_3["position"] ) )
        {
            var_4 = var_3["position"];
            var_5 = 0;
            var_6 = spawn( "script_origin", var_4 );
            var_6.targetname = "orbital_trace_position";

            foreach ( var_8 in level.drop_pod_volume_array )
            {
                var_9 = var_6 istouching( var_8 );
                var_10 = canspawn( var_4 );

                if ( var_9 && var_10 )
                {
                    var_5 = 1;
                    break;
                }
            }

            var_6 delete();

            if ( var_5 == 1 )
                self setclientomnvar( "ui_orbital_collision_warn", 0 );
            else
                self setclientomnvar( "ui_orbital_collision_warn", 1 );
        }

        wait 0.15;
    }
}

_fire( var_0, var_1 )
{
    var_1 endon( "death" );
    var_2 = 0.3;
    var_1 thread setorbitalview( "drop", 0 );
    thread setfovscale( 4.333, 0.1 );
    var_1 destroyplayericons();
    var_1 showplayericons( "friendly" );

    if ( !isbot( var_1 ) )
    {
        var_1.orbital_location = var_1 geteye();
        var_1.orbital_viewangles = var_1 getangles();
        var_1.orbital_forward = anglestoforward( var_1.orbital_viewangles );
        var_1.orbital_endpoint = var_1.orbital_location + var_1.orbital_forward * 5000;
        var_3 = magicbullet( "orbital_drop_pod_mp", var_1.orbital_location, self.orbital_endpoint, var_1 );
        var_3 thread aud_drop_pod_fire( var_1 );
        var_3 thread aud_play_rocket_travel_loops( var_1 );
    }
    else
    {
        var_1.orbital_location = level.orbital_ships.cameraview[self.pers["team"]].origin;
        var_4 = level.orbital_ships.cameraview[self.pers["team"]].origin;
        var_5 = level.orbital_ships.missilespawn["target"].origin;
        var_1.orbital_viewangles = vectortoangles( var_5 - var_4 );
        var_1.orbital_forward = anglestoforward( var_1.orbital_viewangles );
        var_1.orbital_endpoint = var_4 + var_1.orbital_forward * 5000;
        var_3 = magicbullet( "orbital_drop_pod_mp", var_4, self.orbital_endpoint, var_1 );
        var_3 thread aud_drop_pod_fire( var_1 );
        var_3 thread aud_play_rocket_travel_loops( var_1 );
    }

    playfx( level.drop_pod_effect["drop_pod_fire_flash"], var_1.orbital_location, var_1.orbital_forward );
    thread destroyplayerdroppod();
    self notify( "drop_pod_spawned" );

    if ( !isdefined( var_3 ) )
        return;

    var_3.trigger = spawn( "trigger_radius", var_3.origin, 0, 128, 256 );

    if ( var_1 islinked() )
    {
        var_1 unlink();
        var_1 dontinterpolate();
        var_1 playerlinkto( var_3 );
    }

    var_3.owner = var_1;
    var_3.lifeid = var_0;
    var_3.type = "orbital_drop_pod_mp";
    var_3.team = var_1.team;
    level.remotemissileinprogress = 1;
    var_3 thread createkillcamentity();
    var_1.rocket = var_3;
    wait 0.1;
    var_6 = missileeyes( var_1, var_3 );
    return var_6;
}

setfovscale( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);

    self setclientdvar( "cg_fovScale", var_0 );
}

missileeyes( var_0, var_1 )
{
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    var_0 endon( "death" );
    var_1 thread rocket_cleanupondeath();
    var_0 thread player_cleanupongameended( var_1 );
    var_0 thread player_cleanuponteamchange( var_1 );
    var_1 thread waitforrocketimpact( var_0 );
    var_1 thread waitforrocketdeath( var_0 );
    var_2 = getdvar( "mapname" );
    var_0 visionsetmissilecamforplayer( var_2, 0 );
    var_0 endon( "disconnect" );
    var_0.spawn_was_good = 0;
    var_3 = undefined;
    var_4 = ( 0, 0, 0 );

    if ( isdefined( var_1 ) )
    {
        var_0 cameralinkto( var_1, "tag_origin" );
        var_0 controlslinkto( var_1 );
        var_1 thread trackrocket( var_0 );
        var_1 thread droppodtrophysystem();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::setthirdpersondof( 0 );

        var_0 common_scripts\utility::waittill_any( "rocket_impacted", "rocket_destroyed" );
        var_1 thread aud_play_pod_impact( var_0 );
        var_0 destroyplayericons();
        var_0 notify( "player_drop_pod_spawned" );
        var_0 unlinkplayer();

        if ( !level.gameended || isdefined( var_0.finalkill ) )
            thread setfovscale( 1, 0 );

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::setthirdpersondof( 1 );
    }
    else
    {

    }

    var_5 = 0.3;

    if ( var_0.spawn_was_good == 1 && isdefined( var_0.nearest_node ) )
    {
        var_0 createplayerdroppod( var_0.nearest_node.origin );
        var_0 setorigin( var_0.drop_pod.origin );
        var_0 setangles( ( 0, var_0.angles[1], 0 ) );
        var_0 thread unfreezecontrolsdelay( var_5 );
        var_0 playershow();
        var_0.nearest_node = undefined;
        var_0 thread droppodbaseunfold();
        var_0.drop_pod thread drop_pod_handledeath();
        var_0.drop_pod thread aud_drop_pod_land_success( var_0 );
    }
    else
    {
        var_0 setorigin( var_0.impact_info["rocket_position"] );
        var_0 thread droppodbadspawndeathfx();
        var_0 maps\mp\gametypes\_damage::addattacker( var_0, var_0, var_0.rocket.killcament, "orbital_drop_pod_mp", 999999, ( 0, 0, 0 ), var_0.origin, "none", 0, "MOD_EXPLOSIVE" );
        var_0 thread unfreezecontrolsdelay( var_5 );
        thread aud_drop_pod_land_fail( var_0 );
        var_0 thread maps\mp\gametypes\_damage::finishplayerdamagewrapper( var_0.rocket.killcament, var_0, 999999, 0, "MOD_EXPLOSIVE", "orbital_drop_pod_mp", var_0.origin, var_0.origin, "none", 0, 0 );
        var_0 thread maps\mp\_utility::leaderdialogonplayer( "orbital_notgood_tryhard", undefined, undefined, self.origin );
    }

    return var_3;
}

waitforrocketimpact( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    var_0 endon( "death" );

    for (;;)
    {
        var_0 waittill( "projectile_impact", var_1, var_2, var_3, var_4 );

        if ( var_1 == "orbital_drop_pod_mp" )
            break;
    }

    var_0.spawn_was_good = 1;
    var_0 notify( "rocket_impacted" );
}

waitforrocketdeath( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    var_0 endon( "death" );
    self waittill( "death" );

    if ( isdefined( self ) )
        self delete();

    var_0 cameraunlink();
    var_0 controlsunlink();
    var_0 setfovscale( 1, 0 );
    var_0 notify( "rocket_destroyed" );
}

vmlandingimpact()
{
    wait 0.5;
    self stunplayer( 0.3 );
}

droppodbaseunfold()
{
    wait(level.drop_pod.deploy_delay - 1);
    self.drop_pod thread droppodspikeimpacts();
    self.drop_pod_enemy_model thread droppodspikeimpacts();
    self.drop_pod scriptmodelplayanimdeltamotion( "mp_orbital_pod_base_unfold" );
    self.drop_pod_enemy_model scriptmodelplayanimdeltamotion( "mp_orbital_pod_base_unfold" );
}

droppodspikeimpacts()
{
    wait 0.68;
    var_0 = 2;
    var_1 = [];
    var_2 = [];
    var_1[0] = self gettagorigin( "J_spike_FL" );
    var_2[0] = self gettagangles( "J_spike_FL" );
    var_1[1] = self gettagorigin( "J_spike_BL" );
    var_2[1] = self gettagangles( "J_spike_BL" );
    var_1[2] = self gettagorigin( "J_spike_BR" );
    var_2[2] = self gettagangles( "J_spike_BR" );
    var_1[3] = self gettagorigin( "J_spike_FR" );
    var_2[3] = self gettagangles( "J_spike_FR" );

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_4 = var_1[var_3] - 8 * anglestoforward( var_2[var_3] );
        var_5 = var_1[var_3] + var_0 * anglestoforward( var_2[var_3] );
        var_6 = bullettrace( var_4, var_5, 0, self );

        if ( isdefined( var_6["position"] ) )
            playfx( level.drop_pod_effect["drop_pod_spike_impact"], var_6["position"], anglestoforward( ( 270, 0, 0 ) ) );
    }
}

trackrocket( var_0 )
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );

    for (;;)
    {
        var_0.impact_info["rocket_position"] = self.origin;
        var_1 = self.origin;
        var_2 = self.angles;
        var_3 = anglestoforward( var_2 );
        var_4 = var_1 + var_3 * 512;
        var_5 = playerphysicstraceinfo( var_1, var_4 );
        self.trigger dontinterpolate();
        self.trigger.origin = var_5["position"] + ( 0, 0, -128 );
        var_6 = self.trigger thread getnearestpathnode();

        if ( isdefined( var_6 ) )
        {
            self.owner.nearest_node = var_6;
            self hide();
            playfxontag( level.drop_pod_effect["decel_explosion"], self, "tag_origin" );
            var_1 = self.origin;
            var_4 = var_6.origin;
            var_2 = vectortoangles( var_4 - var_1 );
            self.angles = var_2;
            self.trigger delete();
            break;
        }

        wait 0.05;
    }
}

unfreezecontrolsdelay( var_0 )
{
    wait(var_0);
    self freezecontrols( 0 );
}

droppodbadspawndeathfx()
{
    self endon( "disconnect" );
    self waittill( "death" );
    playfx( level.drop_pod_effect["drop_pod_explode"], self.origin + ( 0, 0, 10 ) );
}

getnearestpathnode()
{
    var_0 = getnodesintrigger( self );

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        var_1 = 0;
        var_2 = distancesquared( self.origin, var_0[0].origin );

        for ( var_3 = 0; var_3 < var_0.size; var_3++ )
        {
            switch ( var_0[var_3].type )
            {
                case "Cover Right":
                case "Cover Left":
                case "Begin":
                case "Cover Stand":
                case "End":
                    var_0[var_3] = undefined;
                    continue;
                default:
                    break;
            }

            if ( isdefined( var_0[var_3].script_noteworthy ) )
            {
                if ( var_0[var_3].script_noteworthy == "orbital_no_spawn" )
                {
                    var_0[var_3] = undefined;
                    continue;
                }
            }

            var_4 = distancesquared( self.origin, var_0[var_3].origin );

            if ( var_4 < var_2 )
            {
                var_2 = var_4;
                var_1 = var_3;
            }
        }

        return var_0[var_1];
    }
    else
        return undefined;
}

rocket_cleanupondeath()
{
    var_0 = self getentitynumber();
    level.rockets[var_0] = self;
    self waittill( "death" );
    level.rockets[var_0] = undefined;
    level.remotemissileinprogress = undefined;
}

player_cleanupongameended( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    level waittill( "game_ended" );
    self controlsunlink();
    self cameraunlink();

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::setthirdpersondof( 1 );
}

player_cleanuponteamchange( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );

    if ( self.team != "spectator" )
    {
        self controlsunlink();
        self cameraunlink();

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::setthirdpersondof( 1 );
    }

    setfovscale( 1, 0 );
    level.remotemissileinprogress = undefined;
}

droppod_cleanuponteamchange()
{
    self.drop_pod endon( "death" );
    common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    deleteplayerdroppod();
}

droppod_cleanupondisconnect()
{
    self.drop_pod endon( "death" );
    self waittill( "disconnect" );
    deleteplayerdroppod();
}

createplayerdroppod( var_0 )
{
    deleteplayerdroppod();

    if ( !isdefined( var_0 ) )
    {

    }

    var_1 = var_0 + ( 0, 0, 32 );
    var_2 = var_0 + ( 0, 0, -1024 );
    var_3 = playerphysicstraceinfo( var_1, var_2 );
    var_4 = var_3["position"];
    var_5 = vectortoangles( var_3["normal"] );
    var_6 = anglestoforward( var_5 );
    var_5 += ( 180, 0, 0 );
    playfx( level.drop_pod_effect["landing_impact"], var_4, var_3["normal"] );
    self.drop_pod = spawn( "script_model", var_4 );
    self.drop_pod.angles = var_5;
    self.drop_pod.forward = var_6;
    self.drop_pod setmodel( level.drop_pod.model );
    self.drop_pod solid();
    self.drop_pod setcandamage( 1 );
    self.drop_pod setcanradiusdamage( 1 );
    self.drop_pod.hidden = 0;
    self.drop_pod.owner = self;
    self.drop_pod.destroyed = 0;
    self.drop_pod.health = 999999;
    self.drop_pod.maxhealth = 100;
    self.drop_pod.damagetaken = 0;
    self.drop_pod hide();
    self.drop_pod_enemy_model = spawn( "script_model", self.drop_pod.origin );
    self.drop_pod_enemy_model setmodel( level.drop_pod.enemy_model );
    self.drop_pod_enemy_model.angles = self.drop_pod.angles;
    self.drop_pod_enemy_model.owner = self;
    self.drop_pod_enemy_model hide();
    self.drop_pod_enemy_model notsolid();

    foreach ( var_8 in level.players )
    {
        if ( var_8.team == self.team )
        {
            self.drop_pod showtoplayer( var_8 );
            continue;
        }

        self.drop_pod_enemy_model showtoplayer( var_8 );
    }

    self.drop_pod thread aud_setup_drop_pod_loop();
    self.drop_pod.camera = spawn( "script_model", self.drop_pod.origin );
    self.drop_pod.camera setmodel( "tag_player" );
    self.drop_pod.camera.angles = ( 0, 0, 0 );
    self.drop_pod.camera hide();
    self.isdropping = 0;
    self.drop_pod thread podsetuptrophyfx( self );
    thread droppod_cleanupondisconnect();
    thread droppod_cleanuponteamchange();
}

destroyplayerdroppod()
{
    if ( !isdefined( self.drop_pod ) )
        return;

    self endon( "player_drop_pod_spawned" );
    var_0 = self.drop_pod;
    var_1 = level.drop_pod_effect["pod_base_destroyed"];
    var_2 = level.drop_pod_effect["dome_shutdown_friendly"];
    var_3 = level.drop_pod_effect["dome_shutdown_enemy"];
    playfx( var_1, var_0.origin, var_0.forward );
    var_0 hide();
    self.drop_pod_enemy_model hide();
    var_0.shutdown_fx_friendly = spawnfx( var_2, var_0.origin, var_0.forward );
    var_0.shutdown_fx_enemy = spawnfx( var_3, var_0.origin, var_0.forward );
    triggerfx( var_0.shutdown_fx_friendly );
    var_0.shutdown_fx_friendly hide();
    triggerfx( var_0.shutdown_fx_enemy );
    var_0.shutdown_fx_enemy hide();
    var_0 thread aud_destroy_deployed_pod();

    foreach ( var_5 in level.players )
    {
        if ( var_5.team == self.team )
        {
            var_0.shutdown_fx_friendly showtoplayer( var_5 );
            continue;
        }

        var_0.shutdown_fx_enemy showtoplayer( var_5 );
    }

    wait 0.7;
    deleteplayerdroppod();
}

deleteplayerdroppod()
{
    if ( isdefined( self.drop_pod_enemy_model ) )
        self.drop_pod_enemy_model delete();

    if ( isdefined( self.drop_pod ) )
    {
        deleteplayerdroppodvfx();

        if ( isdefined( self.drop_pod.camera ) )
            self.drop_pod.camera delete();

        self.drop_pod delete();
    }
}

deleteplayerdroppodvfx()
{
    if ( isdefined( self.drop_pod ) )
    {
        if ( isdefined( self.drop_pod.trophyfx_friendly ) )
            self.drop_pod.trophyfx_friendly delete();

        if ( isdefined( self.drop_pod.trophyfx_enemy ) )
            self.drop_pod.trophyfx_enemy delete();

        if ( isdefined( self.drop_pod.trophyfx_ground_friendly ) )
            self.drop_pod.trophyfx_ground_friendly delete();

        if ( isdefined( self.drop_pod.trophyfx_ground_enemy ) )
            self.drop_pod.trophyfx_ground_enemy delete();

        if ( isdefined( self.drop_pod.shutdown_fx_enemy ) )
            self.drop_pod.shutdown_fx_enemy delete();

        if ( isdefined( self.drop_pod.shutdown_fx_enemy ) )
            self.drop_pod.shutdown_fx_enemy delete();

        if ( isdefined( self.drop_pod.spawn_fx ) )
            self.drop_pod.spawn_fx delete();
    }
}

createkillcamentity()
{
    var_0 = ( -512, 0, 128 );
    self.killcament = spawn( "script_model", self.origin );
    self.killcament setscriptmoverkillcam( "explosive" );
    self.killcament linkto( self, "tag_origin", var_0, ( 0, 0, 0 ) );
    self.killcament setcontents( 0 );
    self.killcament.starttime = gettime();
    self.killcament.isorbitalcam = 1;
}

removekillcamentity()
{
    if ( isdefined( self.killcament ) )
        self.killcament delete();
}

drop_pod_handledeath()
{
    var_0 = self getentitynumber();
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    self.owner thread maps\mp\_utility::leaderdialogonplayer( "orbital_pod_destroyed_enemy", undefined, undefined, self.owner.origin );
    self.owner destroyplayerdroppod();
}

droppodtrophysystem()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );

    while ( isdefined( self ) )
    {
        foreach ( var_1 in level.players )
        {
            if ( var_1.team != self.owner.team )
            {
                if ( isdefined( var_1.drop_pod ) )
                {
                    if ( distancesquared( self.origin, var_1.drop_pod.origin ) < 40000 && self.owner.health > 0 )
                        var_1.drop_pod thread droppodtrophykill( self, var_1 );
                }
            }
        }

        foreach ( var_4 in level.trophies )
        {
            if ( isdefined( var_4 ) )
            {
                if ( distancesquared( self.origin, var_4.origin ) < 40000 && var_4.owner.health > 0 )
                {
                    var_4 thread droppodtrophykill( self, var_4.owner );
                    var_4.ammo--;

                    if ( var_4.ammo <= 0 )
                        var_4 thread maps\mp\gametypes\_equipment::trophybreak();
                }
            }
        }

        wait 0.05;
    }
}

droppodtrophykill( var_0, var_1 )
{
    var_0 notify( "destroyed" );
    playfx( level.sentry_fire, self.origin + ( 0, 0, 0 ), var_0.origin - self.origin, anglestoup( self.angles ) );
    self playsound( "trophy_detect_projectile" );

    if ( isdefined( var_0.classname ) && var_0.classname == "rocket" && ( isdefined( var_0.type ) && var_0.type == "remote" ) )
    {
        if ( isdefined( var_0.type ) && var_0.type == "remote" )
        {
            level thread maps\mp\gametypes\_missions::vehiclekilled( var_0.owner, var_1, undefined, var_1, undefined, "MOD_EXPLOSIVE", "trophy_mp" );
            level thread maps\mp\_utility::teamplayercardsplash( "callout_destroyed_predator_missile", var_1 );
            level thread maps\mp\gametypes\_rank::awardgameevent( "kill", var_1, "trophy_mp", undefined, "MOD_EXPLOSIVE" );
        }

        thread aud_drop_pod_trophy_kill();
    }

    var_1 thread projectileexplode( var_0, self );
}

projectileexplode( var_0, var_1 )
{
    var_2 = var_0.origin;
    var_3 = var_0.model;
    var_4 = var_0.angles;
    var_5 = var_0.owner;
    var_6 = var_1.owner;
    var_7 = var_6.drop_pod;
    var_8 = level.drop_pod_effect["dome_impact_flash"];
    var_9 = level.drop_pod_effect["dome_impact"];
    var_10 = var_1.origin;
    var_11 = var_2;
    var_12 = vectortoangles( var_11 - var_10 );
    var_13 = anglestoforward( var_12 );
    var_14 = anglestoup( var_12 );
    playfx( var_9, var_2, var_13, var_14 );
    playfxontag( var_8, var_7, "tag_origin" );
    waittillframeend;

    if ( var_5.health <= 0 )
        return;

    var_5 thread setfovscale( 1, 0 );
    var_5 unlink();
    var_5 cameraunlink();
    var_5 setorigin( var_2 );
    var_5 maps\mp\gametypes\_damage::addattacker( var_5, var_5, var_5.rocket.killcament, "orbital_drop_pod_mp", 999999, ( 0, 0, 0 ), var_5.origin, "none", 0, "MOD_EXPLOSIVE" );
    var_5 thread maps\mp\gametypes\_damage::finishplayerdamagewrapper( var_5.rocket.killcament, var_5, 999999, 0, "MOD_EXPLOSIVE", "orbital_drop_pod_mp", var_5.origin, var_5.origin, "none", 0, 0 );

    if ( isdefined( var_0 ) )
        var_0 delete();

    var_1 thread aud_play_trophy_fire();
    radiusdamage( var_2, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp" );
    var_5 thread maps\mp\_utility::leaderdialogonplayer( "orbital_pod_destroyed", undefined, undefined, var_5.origin );
}

podsetuptrophyfx( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    self.trophyfx_friendly = spawnfx( level.drop_pod_dome["friendly"], self.origin, self.forward );
    triggerfx( self.trophyfx_friendly );
    self.trophyfx_friendly hide();
    self.trophyfx_enemy = spawnfx( level.drop_pod_dome["enemy"], self.origin, self.forward );
    triggerfx( self.trophyfx_enemy );
    self.trophyfx_enemy hide();
    wait(level.drop_pod.deploy_delay - 0.5);
    self.trophyfx_ground_friendly = spawnfx( level.drop_pod_dome_ground["friendly"], self.origin, self.forward );
    triggerfx( self.trophyfx_ground_friendly );
    self.trophyfx_ground_enemy = spawnfx( level.drop_pod_dome_ground["enemy"], self.origin, self.forward );
    triggerfx( self.trophyfx_ground_enemy );
    self.trophyfx_ground_enemy hide();
    thread deletepodtrophyfxondeath( var_0 );
    thread deletepodtrophyfxondisconnect( var_0 );
    thread deletepodtrophyfxonteamchange( var_0 );
}

showplayericons( var_0 )
{
    self endon( "death" );

    foreach ( var_2 in level.players )
    {
        if ( var_2 == self || isdefined( var_2.isdropping ) )
            continue;

        switch ( var_0 )
        {
            case "friendly":
                if ( var_2.team == self.team )
                    var_2 maps\mp\_entityheadicons::setheadicon( self, "ac130_hud_friendly_vehicle_target", ( 0, 0, 0 ), 4, 4, undefined, undefined, undefined, undefined, undefined, 0 );

                break;
            case "enemy":
                if ( !( var_2.team == self.team ) )
                    var_2 maps\mp\_entityheadicons::setheadicon( self, "hud_fofbox_hostile", ( 0, 0, 0 ), 4, 4, undefined, undefined, undefined, undefined, undefined, 0 );

                break;
            case "both":
                if ( var_2.team == self.team )
                    var_2 maps\mp\_entityheadicons::setheadicon( self, "ac130_hud_friendly_vehicle_target", ( 0, 0, 0 ), 4, 4, undefined, undefined, undefined, undefined, undefined, 0 );
                else
                    var_2 maps\mp\_entityheadicons::setheadicon( self, "hud_fofbox_hostile", ( 0, 0, 0 ), 4, 4, undefined, undefined, undefined, undefined, undefined, 0 );

                break;
            default:
                break;
        }
    }
}

destroyplayericons()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.entityheadicons ) )
        {
            if ( isdefined( var_1.entityheadicons[self.guid] ) )
            {
                var_1.entityheadicons[self.guid] destroy();
                var_1.entityheadicons[self.guid] = undefined;
            }
        }
    }
}

showdroppodbadspawnoverlay()
{
    level endon( "game_ended" );

    for (;;)
    {
        hideoverlays();

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.isdropping ) )
            {
                if ( var_1.isdropping )
                    var_1 showoverlaystoplayer();
            }
        }

        wait 0.05;
    }
}

showoverlaystoplayer()
{
    foreach ( var_1 in level.drop_pod_bad_spawn_overlay )
        var_1 showtoplayer( self );
}

hideoverlays()
{
    foreach ( var_1 in level.drop_pod_bad_spawn_overlay )
        var_1 hide();
}

deletepodtrophyfxondeath( var_0 )
{
    var_0 endon( "disconnect" );
    self waittill( "death" );
    deletepodtrophyfx();
}

deletepodtrophyfxondisconnect( var_0 )
{
    self endon( "death" );
    var_0 waittill( "disconnect" );
    deletepodtrophyfx();
}

deletepodtrophyfxonteamchange( var_0 )
{
    self endon( "death" );
    var_0 common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    deletepodtrophyfx();
}

deletepodtrophyfx()
{
    if ( isdefined( self.trophyfx_friendly ) )
        self.trophyfx_friendly delete();

    if ( isdefined( self.trophyfx_enemy ) )
        self.trophyfx_enemy delete();
}

droppodforcerespawn()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self endon( "player_drop_pod_spawned" );
    self endon( "player_spawned_at_drop_pod" );
    level endon( "game_ended" );
    self.forcerespawn = 0;

    if ( !isdefined( self.forcerespawn_timer ) )
        self.forcerespawn_timer = level.forcerespawn_time;

    while ( self.forcerespawn_timer > 0 )
    {
        if ( self.forcerespawn_timer <= 5 )
            self setclientomnvar( "ui_orbital_toggle_color", 1 );

        self.forcerespawn_timer--;
        wait 1;
    }

    self.forcerespawn = 1;
}

aud_play_rocket_travel_loops( var_0 )
{
    var_1 = self;
    thread maps\mp\_audio::snd_play_linked_loop( "orbital_drop_pod_proj", var_1 );
}

aud_play_pod_impact( var_0 )
{
    var_1 = self;
}

aud_drop_pod_fire( var_0 )
{
    var_1 = self;
    var_0 playlocalsound( "orbital_drop_pod_fire_plr" );
}

aud_drop_pod_land_success( var_0 )
{
    var_1 = self;
    thread maps\mp\_audio::snd_play_linked( "orbital_drop_pod_impact", var_1 );
    var_0 playlocalsound( "orbital_drop_pod_impact" );
}

aud_drop_pod_land_fail( var_0 )
{
    var_1 = self;
    thread maps\mp\_audio::snd_play_linked( "orbital_drop_pod_impact", var_1 );
    var_0 playlocalsound( "orbital_drop_pod_impact" );
}

aud_destroy_deployed_pod()
{
    var_0 = self;
    var_0 playsound( "orbital_drop_pod_platform_exp" );
}

aud_drop_pod_trophy_kill()
{
    var_0 = self;
}

aud_play_trophy_fire()
{
    var_0 = self;
}

aud_setup_drop_pod_loop()
{
    thread maps\mp\_audio::snd_play_linked_loop( "orbital_drop_pod_platform_lp", self );
    self waittill( "Death" );

    if ( isdefined( self ) )
        self stopsounds();
}
