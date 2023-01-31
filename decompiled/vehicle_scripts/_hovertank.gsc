// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_utility::set_console_status();
    maps\_vehicle::build_template( "hovertank", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_hovertank );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    build_hovertank_death( var_2 );
    common_scripts\utility::flag_init( "hovertank_reload_hint" );

    if ( isdefined( level.trigger_hint_string ) && !isdefined( level.trigger_hint_string["hovertank_reload"] ) )
        maps\_utility::add_hint_string( "hovertank_reload", &"LAB_HOVERTANK_RELOAD_HINT", ::break_hovertank_reload_hint );

    precache_for_hovertank();
}

build_hovertank_death( var_0 )
{

}

add_hovertank_turret( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "hovertank_turret";

    if ( !isdefined( var_2 ) )
        var_2 = "vehicle_mil_hovertank_vm";

    var_3 = spawnturret( "misc_turret", var_0 gettagorigin( "tag_origin" ), var_1 );
    var_3 _meth_804D( var_0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.hovertank_turret = var_3;
    var_3 _meth_8065( "manual" );
    var_3 _meth_80B1( var_2 );
    var_3 hide();
    var_3 _meth_815C();
    var_0.turret = var_3;
    return var_3;
}

hovertank_swap_model( var_0, var_1, var_2 )
{
    if ( var_2 )
    {
        var_0 hide();
        var_1 show();
        var_1 _meth_840F( 1 );
    }
    else
    {
        var_1 hide();
        var_0 show();
    }
}

hovertank_ride( var_0, var_1 )
{
    self setangles( var_0 gettagangles( "tag_turret" ) );
    var_0 hide();
    var_1 show();
    var_1 _meth_840F( 1 );
    self _meth_820B( var_0, 1 );
    self.driving_hovertank = var_0;
    self.drivingvehicle = var_0;
    var_1 _meth_8099( self );
    var_1 makeunusable();
    self _meth_80F4();
    soundscripts\_audio::aud_disable_deathsdoor_audio();
    self.aim_turnrate_pitch = getdvarint( "aim_turnrate_pitch" );
    self.aim_turnrate_pitch_ads = getdvarint( "aim_turnrate_pitch_ads" );
    self.aim_turnrate_yaw = getdvarint( "aim_turnrate_yaw" );
    self.aim_turnrate_yaw_ads = getdvarint( "aim_turnrate_yaw_ads" );
    self.aim_accel_turnrate_lerp = getdvarint( "aim_accel_turnrate_lerp" );
    _func_0D3( "aim_turnrate_pitch", 70 );
    _func_0D3( "aim_turnrate_pitch_ads", 70 );
    _func_0D3( "aim_turnrate_yaw", 125 );
    _func_0D3( "aim_turnrate_yaw_ads", 85 );
    _func_0D3( "aim_accel_turnrate_lerp", 200 );
    var_0 _meth_83F3();
    thread end_ride_on_hovertank_done( var_0, var_1 );
    hovertank_hud_init( self );
    self notify( "noHealthOverlay" );
    level.cover_warnings_disabled = 1;
    maps\_utility::ent_flag_clear( "near_death_vision_enabled" );
    maps\_utility::ent_flag_set( "player_no_auto_blur" );
    var_0.initialhealth = 5000;
    var_0.health = var_0.healthbuffer + var_0.initialhealth;
    var_0.currenthealth = var_0.health;
    var_0 thread trophy_system();
    var_0 thread handle_hovertank_death();
    give_hovertank_weapons( var_1 );
    var_0 thread hovertank_rumble();
    var_0 thread hovertank_physics();
    var_0 thread hovertank_audio();
    var_0 thread handle_hovertank_collisions();
    var_0 thread hovertank_fx();
    var_1 thread hovertank_ride_anims();
}

hovertank_fx()
{
    self endon( "death" );
    var_0 = self;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( self, "tag_origin", ( 10, 0, 10 ), ( -90, 0, 0 ) );

    for (;;)
    {
        var_2 = var_0 _meth_8473();
        var_3 = var_2[0];
        var_4 = var_2[1];
        wait 1;
    }

    var_1 delete();
}

init_hovertank_weapons()
{
    precacheitem( "hovertank_antiair" );
    precacheitem( "hovertank_cannon" );
    precacheitem( "hovertank_missile_small" );
    precacheshellshock( "hovertank_cannon" );
    precacheshader( "reticle_hovertank_cannon" );
    precacheshader( "reticle_hovertank_emp" );
    precacheshader( "reticle_hovertank_missiles" );
    precacheshader( "hud_minimap_tracking_drone_red" );
    precacheshader( "s1_icon_hovertank_missile_small" );
    precacheshader( "s1_icon_hovertank_canon" );
    precacheshader( "s1_icon_hovertank_antiair" );
    precacheshader( "s1_icon_hovertank_missile_small_ps3" );
    precacheshader( "s1_icon_hovertank_canon_ps3" );
    precacheshader( "s1_icon_hovertank_antiair_ps3" );
    precacheshader( "s1_icon_hovertank_missile_small_pc" );
    precacheshader( "s1_icon_hovertank_canon_pc" );
    precacheshader( "s1_icon_hovertank_antiair_pc" );
    setdvarifuninitialized( "ht_missile_start_forward", 0 );
    setdvarifuninitialized( "ht_missile_start_right", 64 );
    setdvarifuninitialized( "ht_missile_start_up", 0 );
    setdvarifuninitialized( "ht_missile_end_min", 0 );
    setdvarifuninitialized( "ht_missile_end_max", 64 );
    setdvarifuninitialized( "ht_missile_end_forward", 128 );
    setdvarifuninitialized( "ht_missile_end_up", 64 );
    setdvarifuninitialized( "ht_missile_end_rad", 16 );
    setdvarifuninitialized( "ht_missile_mode_line", 0 );
    level._effect["hovertank_aa_explosion"] = loadfx( "vfx/explosion/hovertank_aa_explosion" );
    level._effect["trophy_flash"] = loadfx( "vfx/muzzleflash/hovertank_trophy_flash" );
    level._effect["trophy_explosion"] = loadfx( "vfx/explosion/hovertank_trophy_explosion" );
    level._effect["hovertank_anti_pers_muzzle_flash_vm"] = loadfx( "vfx/muzzleflash/hovertank_anti_pers_muzzle_flash_vm" );
    level._effect["hovertank_anti_pers_trail_rocket_2"] = loadfx( "vfx/trail/hovertank_anti_pers_trail_rocket_2" );
    level._effect["hovertank_cannon_flash_view"] = loadfx( "vfx/muzzleflash/hovertank_cannon_flash_view" );
    level._effect["hovertank_cannon_dust_ring"] = loadfx( "vfx/dust/hovertank_cannon_dust_ring" );
    level._effect["hovertank_aa_flash_vm"] = loadfx( "vfx/muzzleflash/hovertank_aa_flash_vm" );
    level.physicssphereradius["hovertank_missile_small"] = 60;
    level.physicssphereradius["hovertank_antiair"] = 600;
    level.physicssphereradius["hovertank_cannon"] = 1000;
    level.physicssphereforce["hovertank_missile_small"] = 3.0;
    level.physicssphereforce["hovertank_antiair"] = 0;
    level.physicssphereforce["hovertank_cannon"] = 6.0;
    level.weapon_reload_time["hovertank_missile_small"] = 0.0;
    level.weapon_reload_time["hovertank_antiair"] = 0.45;
    level.weapon_reload_time["hovertank_cannon"] = 1;
    level.weapon_input_cooldown_active["hovertank_missile_small"] = 0;
    level.weapon_input_cooldown_active["hovertank_antiair"] = 0;
    level.weapon_input_cooldown_active["hovertank_cannon"] = 0;
    level.weapon_ready_to_fire["hovertank_missile_small"] = 1;
    level.weapon_ready_to_fire["hovertank_antiair"] = 1;
    level.weapon_ready_to_fire["hovertank_cannon"] = 1;
    level.weapon_ammo_max["hovertank_missile_small"] = 25;
    level.weapon_ammo_max["hovertank_antiair"] = 1;
    level.weapon_ammo_max["hovertank_cannon"] = 1;
    level.weapon_ammo_count["hovertank_missile_small"] = level.weapon_ammo_max["hovertank_missile_small"];
    level.weapon_ammo_count["hovertank_antiair"] = level.weapon_ammo_max["hovertank_antiair"];
    level.weapon_ammo_count["hovertank_cannon"] = level.weapon_ammo_max["hovertank_cannon"];
    level.weapon_ammo_bar_value["hovertank_missile_small"] = 1;
    level.weapon_ammo_bar_value["hovertank_antiair"] = 1;
    level.weapon_ammo_bar_value["hovertank_cannon"] = 1;
    level.weapon_ammo_bar_color["hovertank_missile_small"] = ( 1, 1, 1 );
    level.weapon_ammo_bar_color["hovertank_antiair"] = ( 1, 1, 1 );
    level.weapon_ammo_bar_color["hovertank_cannon"] = ( 1, 1, 1 );
    level.weapon_cooldown_active["hovertank_missile_small"] = 0;
    level.weapon_cooldown_active["hovertank_antiair"] = 0;
    level.weapon_cooldown_active["hovertank_cannon"] = 0;
    level.weapon_cooldown_time["hovertank_missile_small"] = 0.1;
    level.weapon_cooldown_time["hovertank_antiair"] = 1;
    level.weapon_cooldown_time["hovertank_cannon"] = 1;
    level.hovertank_projectile_callback = ::hovertank_projectile_callback;
    level.hovertank_weapon = [];
    level.hovertank_weapon[0] = spawnstruct();
    level.hovertank_weapon[1] = spawnstruct();
    level.hovertank_weapon[2] = spawnstruct();
    level.weapon_name["missile"] = "hovertank_missile_small";
    level.weapon_name["antiair"] = "hovertank_antiair";
    level.weapon_name["cannon"] = "hovertank_cannon";
    level.hovertank_weapon[0].weapon = "hovertank_cannon";
    level.hovertank_weapon[1].weapon = "hovertank_missile_small";
    level.hovertank_weapon[2].weapon = "hovertank_antiair";
    level.hovertank_weapon[0].overlay = "reticle_hovertank_cannon";
    level.hovertank_weapon[0].fov = "65";
    level.hovertank_weapon[0].name = level.weapon_name["cannon"];
    level.hovertank_weapon[0].hudelem_x = 0;
    level.hovertank_weapon[0].hudelem_y = 0;
    level.hovertank_weapon[0].shader_width = 800;
    level.hovertank_weapon[0].shader_height = 52;
    level.hovertank_weapon[1].overlay = "reticle_hovertank_missiles";
    level.hovertank_weapon[1].fov = "65";
    level.hovertank_weapon[1].name = level.weapon_name["missile"];
    level.hovertank_weapon[1].hudelem_x = 0;
    level.hovertank_weapon[1].hudelem_y = 0;
    level.hovertank_weapon[1].shader_width = 96;
    level.hovertank_weapon[1].shader_height = 96;
    level.hovertank_weapon[2].overlay = "reticle_hovertank_emp";
    level.hovertank_weapon[2].fov = "65";
    level.hovertank_weapon[2].name = level.weapon_name["antiair"];
    level.hovertank_weapon[2].hudelem_x = 0;
    level.hovertank_weapon[2].hudelem_y = 0;
    level.hovertank_weapon[2].shader_width = 16;
    level.hovertank_weapon[2].shader_height = 16;
    level.current_weapon = level.hovertank_weapon[0].name;
}

get_current_weapon_name()
{
    return level.current_weapon;
}

get_weapon_from_index( var_0 )
{
    var_1 = "none";

    switch ( var_0 )
    {
        case 0:
            var_1 = "hovertank_cannon";
            break;
        case 1:
            var_1 = "hovertank_missile_small";
            break;
        case 2:
            var_1 = "hovertank_antiair";
            break;
        default:
            break;
    }

    return var_1;
}

get_index_from_weapon( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "hovertank_cannon":
            var_1 = 0;
            break;
        case "hovertank_missile_small":
            var_1 = 1;
            break;
        case "hovertank_antiair":
            var_1 = 2;
            break;
        default:
            break;
    }

    return var_1;
}

hovertank_hud_init( var_0 )
{
    var_1 = issplitscreen();
    var_2 = 1;

    if ( !( maps\_utility::is_specialop() || maps\_utility::is_coop() ) )
        var_2 = getdvarint( "widescreen", 1 );

    if ( var_1 )
    {
        foreach ( var_4 in level.hovertank_weapon )
        {
            var_4.hudelem_x *= 0.8;
            var_4.hudelem_y *= 0.8;
            var_4.shader_width = int( var_4.shader_width * 0.8 );
            var_4.shader_height = int( var_4.shader_height * 0.8 );
        }

        level.hovertank_hud_mode_fontscale *= 0.8;
        level.hovertank_hud_misc_fontscale *= 0.8;
        level.hovertank_hud_weapon_fontscale *= 0.8;
        level.hovertank_hud_data_fontscale *= 0.8;
    }

    level.hovertank_hud_mode_fontscale = 2.5;
    level.hovertank_hud_misc_fontscale = 2.0;
    level.hovertank_hud_weapon_fontscale = 1.5;
    level.hovertank_hud_data_fontscale = 1.0;
    level.huditem["crosshairs"][0] = newclienthudelem( var_0 );
    level.huditem["crosshairs"][0].x = level.hovertank_weapon[0].hudelem_x;
    level.huditem["crosshairs"][0].y = level.hovertank_weapon[0].hudelem_y;
    level.huditem["crosshairs"][0].alignx = "center";
    level.huditem["crosshairs"][0].aligny = "middle";
    level.huditem["crosshairs"][0].horzalign = "center";
    level.huditem["crosshairs"][0].vertalign = "middle";
    level.huditem["crosshairs"][0] _meth_80CC( level.hovertank_weapon[0].overlay, level.hovertank_weapon[0].shader_width, level.hovertank_weapon[0].shader_height );
    level.huditem["crosshairs"][0].sort = -2;
    level.huditem["crosshairs"][0].alpha = 0.0;
    level.huditem["crosshairs"][1] = newclienthudelem( var_0 );
    level.huditem["crosshairs"][1].x = level.hovertank_weapon[1].hudelem_x;
    level.huditem["crosshairs"][1].y = level.hovertank_weapon[1].hudelem_y;
    level.huditem["crosshairs"][1].alignx = "center";
    level.huditem["crosshairs"][1].aligny = "middle";
    level.huditem["crosshairs"][1].horzalign = "center";
    level.huditem["crosshairs"][1].vertalign = "middle";
    level.huditem["crosshairs"][1] _meth_80CC( level.hovertank_weapon[1].overlay, level.hovertank_weapon[1].shader_width, level.hovertank_weapon[1].shader_height );
    level.huditem["crosshairs"][1].sort = -2;
    level.huditem["crosshairs"][1].alpha = 0.0;
    var_6 = 24;
    var_7 = 15;
    var_8 = 0.25;
    level.huditem["crosshairs"][2][0] = newclienthudelem( var_0 );
    level.huditem["crosshairs"][2][0].x = level.hovertank_weapon[2].hudelem_x;
    level.huditem["crosshairs"][2][0].y = level.hovertank_weapon[2].hudelem_y;
    level.huditem["crosshairs"][2][0].alignx = "center";
    level.huditem["crosshairs"][2][0].aligny = "middle";
    level.huditem["crosshairs"][2][0].horzalign = "center";
    level.huditem["crosshairs"][2][0].vertalign = "middle";
    level.huditem["crosshairs"][2][0] _meth_80CC( level.hovertank_weapon[2].overlay, level.hovertank_weapon[2].shader_width, level.hovertank_weapon[2].shader_height );
    level.huditem["crosshairs"][2][0].sort = -2;
    level.huditem["crosshairs"][2][0].alpha = 0.0;
    level.huditem["crosshairs"][2][1] = newclienthudelem( var_0 );
    level.huditem["crosshairs"][2][1].x = level.hovertank_weapon[2].hudelem_x + var_6;
    level.huditem["crosshairs"][2][1].y = level.hovertank_weapon[2].hudelem_y - var_7;
    level.huditem["crosshairs"][2][1].alignx = "center";
    level.huditem["crosshairs"][2][1].aligny = "middle";
    level.huditem["crosshairs"][2][1].horzalign = "center";
    level.huditem["crosshairs"][2][1].vertalign = "middle";
    level.huditem["crosshairs"][2][1] _meth_80CC( level.hovertank_weapon[2].overlay, int( level.hovertank_weapon[2].shader_width * ( 1 + var_8 ) ), int( level.hovertank_weapon[2].shader_height * ( 1 + var_8 ) ) );
    level.huditem["crosshairs"][2][1].sort = -2;
    level.huditem["crosshairs"][2][1].alpha = 0.0;
    level.huditem["crosshairs"][2][2] = newclienthudelem( var_0 );
    level.huditem["crosshairs"][2][2].x = level.hovertank_weapon[2].hudelem_x + var_6 * 2;
    level.huditem["crosshairs"][2][2].y = level.hovertank_weapon[2].hudelem_y - var_7 * 2;
    level.huditem["crosshairs"][2][2].alignx = "center";
    level.huditem["crosshairs"][2][2].aligny = "middle";
    level.huditem["crosshairs"][2][2].horzalign = "center";
    level.huditem["crosshairs"][2][2].vertalign = "middle";
    level.huditem["crosshairs"][2][2] _meth_80CC( level.hovertank_weapon[2].overlay, int( level.hovertank_weapon[2].shader_width * ( 1 + var_8 * 2 ) ), int( level.hovertank_weapon[2].shader_height * ( 1 + var_8 * 2 ) ) );
    level.huditem["crosshairs"][2][2].sort = -2;
    level.huditem["crosshairs"][2][2].alpha = 0.0;
    var_9 = common_scripts\utility::ter_op( var_1, 102.4, 128 );
    var_10 = common_scripts\utility::ter_op( var_1, 89.6, 112 );
    var_11 = 50;
    var_12 = var_11;
    var_13 = 0;

    if ( var_1 )
    {
        var_13 = 162;

        if ( !var_2 )
            var_13 *= 0.888889;
    }
    else if ( !var_2 )
        var_13 *= 0.833333;

    var_14 = -60;
    level.huditem["weapon_icon"][0] = newclienthudelem( var_0 );
    level.huditem["weapon_icon"][0].x = var_13;
    level.huditem["weapon_icon"][0].y = var_14;
    level.huditem["weapon_icon"][0].alignx = "center";
    level.huditem["weapon_icon"][0].aligny = "bottom";
    level.huditem["weapon_icon"][0].horzalign = "center";
    level.huditem["weapon_icon"][0].vertalign = "bottom";

    if ( !level.player _meth_834E() )
        level.huditem["weapon_icon"][0] _meth_80CC( "s1_icon_hovertank_canon_pc", var_12, var_11 );
    else if ( level.ps3 || level.ps4 )
        level.huditem["weapon_icon"][0] _meth_80CC( "s1_icon_hovertank_canon_ps3", var_12, var_11 );
    else
        level.huditem["weapon_icon"][0] _meth_80CC( "s1_icon_hovertank_canon", var_12, var_11 );

    level.huditem["weapon_icon"][0].icon_width = var_12;
    level.huditem["weapon_icon"][0].icon_height = var_11;
    level.huditem["weapon_icon"][0].alpha = 0.0;
    level.huditem["weapon_icon"][0].font = "objective";
    level.huditem["weapon_key"][0] = newclienthudelem( var_0 );
    level.huditem["weapon_key"][0].x = var_13;
    level.huditem["weapon_key"][0].y = var_14;
    level.huditem["weapon_key"][0].alignx = "center";
    level.huditem["weapon_key"][0].aligny = "bottom";
    level.huditem["weapon_key"][0].horzalign = "center";
    level.huditem["weapon_key"][0].vertalign = "bottom";
    level.huditem["weapon_key"][0].alpha = 0;
    level.huditem["weapon_key"][0].font = "objective";
    level.huditem["weapon_key"][0] settext( "[{+actionslot 3}]" );
    var_15 = 70;
    var_16 = -45;
    var_13 = var_15 * -1;

    if ( var_1 )
    {
        var_13 = 165;

        if ( !var_2 )
            var_13 *= 0.888889;

        var_13 = ceil( var_13 ) + 1;
    }
    else if ( !var_2 )
    {
        var_13 *= 0.833333;
        var_13 += 3;
    }

    var_14 = var_16;
    level.huditem["weapon_icon"][1] = newclienthudelem( var_0 );
    level.huditem["weapon_icon"][1].x = var_13;
    level.huditem["weapon_icon"][1].y = var_14;
    level.huditem["weapon_icon"][1].alignx = "center";
    level.huditem["weapon_icon"][1].aligny = "bottom";
    level.huditem["weapon_icon"][1].horzalign = "center";
    level.huditem["weapon_icon"][1].vertalign = "bottom";

    if ( !level.player _meth_834E() )
        level.huditem["weapon_icon"][1] _meth_80CC( "s1_icon_hovertank_missile_small_pc", var_12, var_11 );
    else if ( level.ps3 || level.ps4 )
        level.huditem["weapon_icon"][1] _meth_80CC( "s1_icon_hovertank_missile_small_ps3", var_12, var_11 );
    else
        level.huditem["weapon_icon"][1] _meth_80CC( "s1_icon_hovertank_missile_small", var_12, var_11 );

    level.huditem["weapon_icon"][1].icon_width = var_12;
    level.huditem["weapon_icon"][1].icon_height = var_11;
    level.huditem["weapon_icon"][1].alpha = 0.0;
    level.huditem["weapon_icon"][1].font = "objective";
    level.huditem["weapon_key"][1] = newclienthudelem( var_0 );
    level.huditem["weapon_key"][1].x = var_13;
    level.huditem["weapon_key"][1].y = var_14;
    level.huditem["weapon_key"][1].alignx = "center";
    level.huditem["weapon_key"][1].aligny = "bottom";
    level.huditem["weapon_key"][1].horzalign = "center";
    level.huditem["weapon_key"][1].vertalign = "bottom";
    level.huditem["weapon_key"][1].alpha = 0;
    level.huditem["weapon_key"][1].font = "objective";
    level.huditem["weapon_key"][1] settext( "[{weapnext}]" );
    var_13 = var_15;

    if ( var_1 )
    {
        var_13 = 165;

        if ( !var_2 )
            var_13 *= 0.888889;

        var_13 = ceil( var_13 ) + 1;
    }
    else if ( !var_2 )
    {
        var_13 *= 0.833333;
        var_13 += 3;
    }

    var_14 = var_16;
    level.huditem["weapon_icon"][2] = newclienthudelem( var_0 );
    level.huditem["weapon_icon"][2].x = var_13;
    level.huditem["weapon_icon"][2].y = var_14;
    level.huditem["weapon_icon"][2].alignx = "center";
    level.huditem["weapon_icon"][2].aligny = "bottom";
    level.huditem["weapon_icon"][2].horzalign = "center";
    level.huditem["weapon_icon"][2].vertalign = "bottom";

    if ( !level.player _meth_834E() )
        level.huditem["weapon_icon"][2] _meth_80CC( "s1_icon_hovertank_antiair_pc", var_12, var_11 );
    else if ( level.ps3 || level.ps4 )
        level.huditem["weapon_icon"][2] _meth_80CC( "s1_icon_hovertank_antiair_ps3", var_12, var_11 );
    else
        level.huditem["weapon_icon"][2] _meth_80CC( "s1_icon_hovertank_antiair", var_12, var_11 );

    level.huditem["weapon_icon"][2].icon_width = var_12;
    level.huditem["weapon_icon"][2].icon_height = var_11;
    level.huditem["weapon_icon"][2].alpha = 0.0;
    level.huditem["weapon_icon"][2].font = "objective";
    level.huditem["weapon_key"][2] = newclienthudelem( var_0 );
    level.huditem["weapon_key"][2].x = var_13;
    level.huditem["weapon_key"][2].y = var_14;
    level.huditem["weapon_key"][2].alignx = "center";
    level.huditem["weapon_key"][2].aligny = "bottom";
    level.huditem["weapon_key"][2].horzalign = "center";
    level.huditem["weapon_key"][2].vertalign = "bottom";
    level.huditem["weapon_key"][2].alpha = 0;
    level.huditem["weapon_key"][2].font = "objective";
    level.huditem["weapon_key"][2] settext( "[{+actionslot 4}]" );
}

give_hovertank_weapons( var_0 )
{
    maps\_utility::add_global_spawn_function( "axis", ::set_up_target );
    level.hovertank_player = self;
    level.last_hovertank_weapon_anim = "";
    level.last_hovertank_weapon_anim_complete_time = gettime();
    var_1 = self;
    var_1 _meth_831D();
    var_1 _meth_80EF();
    var_1 _meth_823C();
    var_1 maps\_utility::ent_flag_clear( "player_has_red_flashing_overlay" );
    var_1 notify( "noHealthOverlay" );
    thread shotfired();
    thread change_weapons( var_0 );
    thread missile_reload_system();
    thread missile_fire_audio();
    thread weapon_fire( var_0 );
    maps\_utility::delaythread( 1, ::hud_blink_current_weapon_name, 0 );
    level.huditem["crosshairs"][0].alpha = 0.6;
}

remove_hovertank_weapons()
{
    level notify( "hovertank_end" );
    maps\_utility::remove_global_spawn_function( "axis", ::set_up_target );
    var_0 = self;
    level.huditem = common_scripts\utility::array_removeundefined( level.huditem );
    maps\_utility::deep_array_thread( level.huditem, maps\_hud_util::destroyelem );
    var_0 _meth_80F0();
    level.hovertank_player = undefined;
}

hovertank_rumble()
{
    level endon( "hovertank_end" );
    level.player endon( "death" );
    var_0 = 12.0;
    var_1 = 0.2;
    var_2 = 0.0001;
    var_3 = 0.6;
    var_4 = 0.0;
    self.rumble_entity = maps\_utility::get_rumble_ent( "steady_rumble" );
    self.rumble_entity.intensity = 0.0;

    for (;;)
    {
        var_5 = var_4;
        var_4 = self _meth_8286();
        var_6 = var_1 * clamp( var_4 / var_0, 0.0, 1.0 );
        var_6 *= randomfloat( 1.0 );
        var_7 = 0.0;
        var_8 = var_4 - var_5;

        if ( var_8 > 0.0 )
            var_7 = var_3 * ( clamp( 1.0 - var_5 / var_4, var_2, 1.0 ) - var_2 );

        self.rumble_entity.intensity = clamp( var_6 + var_7, 0.0, 1.0 );
        wait 0.1;
    }
}

get_hovertank_shake_value()
{
    var_0 = 0;
    var_1 = 12;
    return self _meth_8286() / var_1;
}

hovertank_rumble_stop()
{
    level waittill( "hovertank_end" );
    stopallrumbles();
}

hovertank_physics()
{
    self endon( "death" );

    for (;;)
    {
        _func_244( self.origin, 200 );
        wait 0.05;
    }
}

end_ride_on_hovertank_done( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 waittill( "hovertank_done" );
    endride( var_0, var_1 );
}

endride( var_0, var_1 )
{
    self _meth_820C( var_0 );
    var_1 _meth_8099( self );
    level notify( "hovertank_cannon_reload_hint" );
    common_scripts\utility::flag_clear( "hovertank_reload_hint" );
    remove_hovertank_weapons();
    maps\_utility::remove_damage_function( ::track_health_damage_function );
    maps\_utility::remove_damage_function( ::trophy_system_backup );
    level.cover_warnings_disabled = undefined;
    maps\_utility::ent_flag_set( "near_death_vision_enabled" );
    maps\_utility::ent_flag_clear( "player_no_auto_blur" );
    thread maps\_gameskill::healthoverlay();
    soundscripts\_audio::aud_enable_deathsdoor_audio();
    _func_0D3( "aim_turnrate_pitch", self.aim_turnrate_pitch );
    _func_0D3( "aim_turnrate_pitch_ads", self.aim_turnrate_pitch_ads );
    _func_0D3( "aim_turnrate_yaw", self.aim_turnrate_yaw );
    _func_0D3( "aim_turnrate_yaw_ads", self.aim_turnrate_yaw_ads );
    _func_0D3( "aim_accel_turnrate_lerp", self.aim_accel_turnrate_lerp );
    self.driving_hovertank = undefined;
    self.drivingvehicle = undefined;
    self notify( "hovertank_dismounted" );
}

hoverscreen_reveal( var_0 )
{
    if ( isdefined( level.use_hovertank_chromatic_aberration ) && level.use_hovertank_chromatic_aberration )
        level.chromo_offset = 30;

    var_1 = level.hovertank_turret gettagorigin( "tag_aim_animated" );
    thread hoverscreen_turnon_movie();
    level.player common_scripts\utility::delaycall( var_0, ::freezecontrols, 0 );
    _func_0D3( "r_hudoutlineenable", 1 );

    if ( isdefined( level.use_hovertank_chromatic_aberration ) && level.use_hovertank_chromatic_aberration )
    {
        _func_0D3( "r_chromaticAberrationTweaks", 1 );
        _func_0D3( "r_chromaticAberration", 0 );
        _func_0D3( "r_chromaticSeparationG", -10 );
        _func_0D3( "r_chromaticSeparationR", 10 );
    }

    level.player freezecontrols( 1 );
    wait 0.05;
    setomnvar( "ui_labtank", 1 );
    _func_23F( &"qflash01" );
    level.hovertank_turret _meth_846C( "mtl_hovertank_body_gun", "mtl_hovertank_body_gun_no_z" );
    level.hovertank_turret _meth_8048( "TAG_AIM_HIDE" );
    level.hovertank_turret _meth_8048( "TAG_AIM_UNHIDE" );
}

hoverscreen_turnon_movie()
{
    wait 0.05;
    level.hovertank_turret _meth_804B( "TAG_BOOT" );
    _func_05C();
    level.hovertank_turret _meth_846C( "mtl_hovertank_int_screen02", "m/mtl_hovertank_int_screen01" );
    _func_0D3( "cg_cinematicFullScreen", "0" );
    _func_059( "lab_tank_bootup" );
    wait 1.26;
    level.hovertank_turret _meth_846D();
    wait 0.74;
    level.hovertank_turret _meth_8048( "TAG_BOOT" );
    _func_05C();
}

hoverscreen_turnoff_movie()
{
    wait 0.05;
    level.hovertank_turret _meth_804B( "TAG_BOOT" );
    _func_05C();
    _func_0D3( "cg_cinematicFullScreen", "0" );
    _func_059( "lab_tank_shutdown" );
    wait 0.5;
    level.hovertank_turret _meth_846C( "mtl_hovertank_int_screen02", "m/mtl_hovertank_int_screen01" );
    wait 0.5;
    level.hovertank_turret _meth_8048( "TAG_BOOT" );
    _func_05C();
}

hoverscreen_turnoff( var_0, var_1 )
{
    if ( isdefined( level.use_hovertank_chromatic_aberration ) && level.use_hovertank_chromatic_aberration )
        level.chromo_offset = 30;

    var_2 = level.hovertank_turret gettagorigin( "tag_aim_animated" );
    thread hoverscreen_turnoff_movie();
    wait(var_1);
    _func_0D3( "r_hudoutlineenable", 1 );

    if ( isdefined( level.use_hovertank_chromatic_aberration ) && level.use_hovertank_chromatic_aberration )
    {
        _func_0D3( "r_chromaticAberrationTweaks", 1 );
        _func_0D3( "r_chromaticAberration", 0 );
        _func_0D3( "r_chromaticSeparationG", -10 );
        _func_0D3( "r_chromaticSeparationR", 10 );
    }

    wait 0.05;
    level.hovertank_turret _meth_846C( "mtl_hovertank_body_gun", "mtl_hovertank_body_gun_no_z" );
    wait 0.05;
}

hoverscreen_hit( var_0, var_1 )
{
    level notify( "hoverscreen_hit_" + var_0 );
    level endon( "hoverscreen_hit_" + var_0 );
    level endon( "hovertank_end" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 1.0;

    var_2 = int( 900.2 );
    var_3 = int( 521.5 );

    if ( !isdefined( level.huditem["hovertank_hit01"] ) || !isdefined( level.huditem["hovertank_hit01"][var_0] ) )
    {
        level.huditem["hovertank_hit01"][var_0] = newclienthudelem( level.player );
        level.huditem["hovertank_hit01"][var_0].x = 0;
        level.huditem["hovertank_hit01"][var_0].y = 10;
        level.huditem["hovertank_hit01"][var_0].alignx = "center";
        level.huditem["hovertank_hit01"][var_0].aligny = "bottom";
        level.huditem["hovertank_hit01"][var_0].horzalign = "center";
        level.huditem["hovertank_hit01"][var_0].vertalign = "bottom";
        var_4 = "mtl_hovertank_screen_hit_0" + var_0;
        level.huditem["hovertank_hit01"][var_0] _meth_80CC( var_4, var_2, var_3 );
        level.huditem["hovertank_hit01"][var_0].alpha = 0.0;
        level.huditem["hovertank_hit01"][var_0].color = ( 1, 1, 1 );
    }

    var_5 = 0;

    if ( isdefined( level.use_hovertank_chromatic_aberration ) && level.use_hovertank_chromatic_aberration )
        thread hoverscreen_chromo_anim2( 0.5, var_1 );

    for ( var_5 = 0; var_5 < 5; var_5++ )
    {
        level.huditem["hovertank_hit01"][var_0].alpha = abs( var_5 / 5.0 );
        level.huditem["hovertank_hit01"][var_0].alpha *= var_1;
        wait 0.05;
    }

    for ( var_5 = 0; var_5 < 5; var_5++ )
    {
        level.huditem["hovertank_hit01"][var_0].color = ( 1, 0.97, 0.85 );
        level.huditem["hovertank_hit01"][var_0].alpha = 1 - abs( var_5 / 5.0 * 2 - 1 );
        level.huditem["hovertank_hit01"][var_0].alpha *= var_1;
        wait 0.05;
    }

    level.huditem["hovertank_hit01"][var_0] destroy();
}

hoverscreen_chromo_anim2( var_0, var_1 )
{
    var_2 = 1.0;

    if ( var_1 )
        var_2 = var_1;

    _func_0D3( "r_chromaticAberration", 1 );
    var_3 = var_0 * 20;
    var_4 = 0;
    level.chromo_offset = 20 * var_2;
    var_5 = level.chromo_offset;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_6 = 1.0 / var_3 * var_5;
        level.chromo_offset -= var_6;
        _func_0D3( "r_chromaticSeparationG", level.chromo_offset * -1 );
        _func_0D3( "r_chromaticSeparationR", level.chromo_offset );
        wait 0.05;
    }

    level.chromo_offset = 0;
    _func_0D3( "r_chromaticSeparationG", 0 );
    _func_0D3( "r_chromaticSeparationR", 0 );
}

hoverscreen_chromo_anim( var_0, var_1 )
{
    _func_0D3( "r_chromaticAberration", 2 );
    var_2 = var_0 * 20;
    var_3 = 0;
    var_1 _meth_83FA( 0 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = ( var_2 + 1 - var_3 ) / 60 * 5;
        _func_0D3( "r_chromaticSeparationG", var_4 * -1 );
        _func_0D3( "r_chromaticSeparationR", var_4 );
        wait 0.05;
    }
}

hoverscreen_chromo_anim_turnoff( var_0, var_1 )
{
    _func_0D3( "r_chromaticAberration", 2 );
    var_2 = var_0 * 20;
    var_3 = 0;
    var_1 _meth_83FA( 0 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = ( var_2 + 1 - var_3 ) / 60 * 5;
        _func_0D3( "r_chromaticSeparationG", var_4 * -1 );
        _func_0D3( "r_chromaticSeparationR", var_4 );
        wait 0.05;
    }
}

#using_animtree("vehicles");

change_weapons( var_0 )
{
    level endon( "hovertank_end" );
    var_1 = 0;
    var_2 = "cannon";
    level.current_weapon = level.hovertank_weapon[var_1].name;
    level.player thread change_weapons_listener();
    wait 0.05;

    for (;;)
    {
        var_3 = level.hovertank_player common_scripts\utility::waittill_any_return( "antiair_button", "cannon_button", "missiles_button" );

        if ( issubstr( var_3, "cannon" ) )
        {
            if ( issubstr( level.current_weapon, "cannon" ) )
                continue;

            var_1 = 0;
        }
        else if ( issubstr( var_3, "missile" ) )
        {
            if ( issubstr( level.current_weapon, "missile" ) )
                continue;

            var_1 = 1;
        }
        else if ( issubstr( var_3, "antiair" ) )
        {
            if ( issubstr( level.current_weapon, "antiair" ) )
                continue;

            var_1 = 2;
        }
        else
        {

        }

        level.hovertank_player notify( "shot weapon" );
        level.current_weapon = level.hovertank_weapon[var_1].name;

        if ( !issubstr( level.current_weapon, "missile" ) )
            level.hovertank_player notify( "stop_missile_fire_audio" );

        if ( isdefined( var_0 ) )
        {
            var_4 = 0.3;

            if ( issubstr( level.current_weapon, "cannon" ) && var_2 == "antiair" )
            {
                var_0 _meth_8145( %lab_htank_emp_to_cannon_vmhtank, 1, var_4 );
                level.last_hovertank_weapon_anim = "emp_to_cannon";
                level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength( %lab_htank_emp_to_cannon_vmhtank );
                soundscripts\_snd::snd_message( "hovertank_switch_to_cannon" );
                var_2 = "cannon";
            }
            else if ( issubstr( level.current_weapon, "antiair" ) && var_2 == "cannon" )
            {
                if ( gettime() >= level.last_hovertank_weapon_anim_complete_time )
                    var_0 _meth_8145( %lab_htank_cannon_to_emp_vmhtank, 1, 0.0 );
                else
                    var_0 _meth_8145( %lab_htank_cannon_to_emp_vmhtank, 1, var_4 );

                level.last_hovertank_weapon_anim = "cannon_to_emp";
                level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength( %lab_htank_cannon_to_emp_vmhtank );
                soundscripts\_snd::snd_message( "hovertank_switch_to_emp" );
                var_2 = "antiair";
            }
            else
                soundscripts\_snd::snd_message( "hovertank_switch_to_missile" );
        }

        foreach ( var_10, var_6 in level.huditem["crosshairs"] )
        {
            if ( var_10 != var_1 )
            {
                if ( isarray( var_6 ) )
                {
                    foreach ( var_8 in var_6 )
                    {
                        var_8 fadeovertime( 0.0166667 );
                        var_8.alpha = 0.0;
                    }

                    continue;
                }

                var_6 fadeovertime( 0.0166667 );
                var_6.alpha = 0.0;
            }
        }

        thread hud_blink_current_weapon_name( var_1 );
        level.hovertank_player thread maps\_utility::play_sound_on_entity( "ac130_weapon_switch" );
        wait 0.05;

        if ( isarray( level.huditem["crosshairs"][var_1] ) )
        {
            foreach ( var_10, var_8 in level.huditem["crosshairs"][var_1] )
            {
                if ( var_10 == 0 )
                {
                    var_8.alpha = 1.0;
                    continue;
                }

                if ( var_10 == 1 )
                {
                    var_8.alpha = 0.25;
                    continue;
                }

                var_8.alpha = 0.1;
            }

            continue;
        }

        level.huditem["crosshairs"][var_1].alpha = 0.6;
    }
}

change_weapons_listener()
{
    level endon( "hovertank_end" );
    self _meth_82DD( "antiair_button", "+stance" );
    self _meth_82DD( "cannon_button", "weapnext" );
    self _meth_82DD( "missiles_button", "+usereload" );
    notifyoncommand( "LISTEN_attack_button_pressed", "+attack" );
    notifyoncommand( "LISTEN_attack_button_pressed", "+attack_akimbo_accessible" );
    var_0 = "default";

    for (;;)
    {
        if ( !level.player common_scripts\utility::is_player_gamepad_enabled() )
        {
            self _meth_82DD( "antiair_button", "+actionslot 4" );
            self _meth_82DD( "cannon_button", "+actionslot 3" );
            self _meth_82DD( "missiles_button", "weapnext" );
        }
        else
        {
            self _meth_849C( "antiair_button", "+actionslot 4" );
            self _meth_849C( "cannon_button", "+actionslot 3" );
            self _meth_849C( "missiles_button", "weapnext" );
        }

        if ( issubstr( _func_2C6(), "nomad_tactical" ) )
        {
            if ( var_0 != "nomad" )
            {
                self _meth_849C( "antiair_button", "+stance" );
                self _meth_849C( "antiair_button", "+melee_zoom" );
                self _meth_82DD( "antiair_button", "+melee_breath" );
                var_0 = "nomad_tactical";
            }
        }
        else if ( issubstr( _func_2C6(), "tactical" ) )
        {
            if ( var_0 != "tactical" )
            {
                self _meth_849C( "antiair_button", "+stance" );
                self _meth_849C( "antiair_button", "+melee_breath" );
                self _meth_82DD( "antiair_button", "+melee_zoom" );
                var_0 = "tactical";
            }
        }
        else
        {
            self _meth_849C( "antiair_button", "+melee_zoom" );
            self _meth_849C( "antiair_button", "+melee_breath" );
            self _meth_82DD( "antiair_button", "+stance" );
            var_0 = "default";
        }

        wait 0.1;
    }
}

scale_missile_reticle_with_dist( var_0 )
{
    var_1 = 3000;
    var_2 = 600;
    var_3 = 0.1;
    level endon( "hovertank_end" );

    for (;;)
    {
        if ( issubstr( level.current_weapon, "missile" ) )
        {
            var_4 = [];
            var_5 = level.hovertank_player _meth_80A8() + 15000 * anglestoforward( level.hovertank_player getangles() );

            if ( isdefined( var_0 ) )
                var_4 = bullettrace( level.hovertank_player _meth_80A8() + anglestoforward( var_0 gettagangles( "tag_flash" ) ) * 32, var_5, 1, var_0 );
            else
                var_4 = bullettrace( level.player _meth_80A8() + anglestoforward( level.player _meth_8036() ) * 32, var_5, 1, level.player );

            var_6 = distance( level.player.origin, var_4["position"] );

            if ( var_6 > var_1 )
                var_6 = var_1;
            else if ( var_6 < var_2 )
                var_6 = var_2;

            var_7 = 1 - ( var_6 - var_2 ) / ( var_1 - var_2 );

            if ( var_7 < 0.3 )
                var_7 = 0.3;

            level.huditem["crosshairs"][1] scaleovertime( var_3, int( level.hovertank_weapon[1].shader_width * var_7 ), int( level.hovertank_weapon[1].shader_height * var_7 ) );
        }

        wait(var_3);
    }
}

missile_reload_system()
{
    level endon( "hovertank_end" );
    var_0 = "hovertank_missile_small";
    var_1 = 0.1;

    for (;;)
    {
        var_2 = level.weapon_ammo_count[var_0] / level.weapon_ammo_max[var_0];
        level.weapon_ammo_bar_value[var_0] = clamp( level.weapon_ammo_count[var_0] / level.weapon_ammo_max[var_0], 0.04, 1 );

        if ( level.weapon_ammo_count[var_0] < level.weapon_ammo_max[var_0] )
            level.weapon_ammo_count[var_0]++;

        if ( var_2 < 0.3 )
            level.weapon_ammo_bar_color[var_0] = ( 1, 1, 0 );
        else
            level.weapon_ammo_bar_color[var_0] = ( 1, 1, 1 );

        wait(var_1);
    }
}

weapon_fire_notify()
{
    level endon( "hovertank_end" );

    for (;;)
    {
        if ( level.hovertank_player attackbuttonpressed() )
        {
            level.hovertank_player notify( "LISTEN_attack_button_pressed" );
            level.hovertank_player.firingweapons = 1;
        }
        else
        {
            level.hovertank_player.firingweapons = 0;
            level.hovertank_player waittill( "LISTEN_attack_button_pressed" );
        }

        wait 0.05;
    }
}

weapon_fire( var_0 )
{
    level endon( "hovertank_end" );
    thread weapon_fire_notify();
    var_1 = 0;
    var_2 = 0.2;
    var_3 = 1;
    var_4 = level.hovertank_player _meth_80A8()[2];
    var_5 = 1.5;
    var_6 = 0;

    for (;;)
    {
        level.hovertank_player waittill( "LISTEN_attack_button_pressed" );
        level.time_of_hovertank_fire = gettime();
        level.player_angles_at_last_hovertank_fire = level.hovertank_player getangles();
        var_7 = undefined;

        if ( !level.weapon_ready_to_fire[level.current_weapon] || level.weapon_cooldown_active[level.current_weapon] || level.weapon_input_cooldown_active[level.current_weapon] )
            continue;
        else
        {
            if ( issubstr( level.current_weapon, "missile" ) )
                var_6 = ( var_6 + 1 ) % 2;

            var_8 = ( 0, 0, 0 );

            if ( isdefined( var_0 ) )
                var_8 = var_0 get_weapon_fire_pos( level.current_weapon, var_6 );
            else
                var_8 = level.player _meth_80A8();

            var_9 = level.hovertank_player _meth_80A8() + 15000 * anglestoforward( level.hovertank_player getangles() );

            if ( level.time_of_hovertank_fire - var_1 > var_2 * 1000 )
                var_3 = 1;

            if ( level.time_of_hovertank_fire - var_1 > var_5 * 1000 )
                var_4 = level.hovertank_player _meth_80A8()[2];

            if ( issubstr( level.current_weapon, "missile" ) )
            {
                var_7 = [];

                if ( isdefined( var_0 ) )
                    var_7 = bullettrace( level.hovertank_player _meth_80A8() + anglestoforward( var_0 gettagangles( "tag_flash" ) ) * 32, var_9, 1, var_0 );
                else
                    var_7 = bullettrace( level.player _meth_80A8() + anglestoforward( level.player _meth_8036() ) * 32, var_9, 1, level.player );

                var_10 = 0;
                var_11 = 0;
                var_9 = ( 0, 0, 0 );

                if ( getdvarint( "ht_missile_mode_line" ) )
                {
                    var_12 = ( 0, 0, 0 );

                    if ( isdefined( var_0 ) )
                        var_12 = var_0 gettagangles( "tag_flash" );
                    else
                        var_12 = level.player _meth_8036();

                    if ( var_6 == 0 )
                        var_10 = anglestoright( var_12 ) * randomintrange( -1 * getdvarint( "ht_missile_end_max" ), getdvarint( "ht_missile_end_min" ) );
                    else
                        var_10 = anglestoright( var_12 ) * randomintrange( getdvarint( "ht_missile_end_min" ), getdvarint( "ht_missile_end_max" ) );

                    var_9 = var_8 + anglestoforward( var_12 ) * getdvarint( "ht_missile_end_forward" ) + anglestoup( var_12 ) * getdvarint( "ht_missile_end_up" ) + var_10;
                }
                else
                {
                    if ( var_6 == 0 )
                        var_11 = randomintrange( 90, 180 );
                    else
                        var_11 = randomintrange( 0, 90 );

                    var_12 = ( 0, 0, 0 );

                    if ( isdefined( var_0 ) )
                        var_12 = var_0 gettagangles( "tag_flash" );
                    else
                        var_12 = level.player _meth_8036();

                    var_9 = var_8 + anglestoforward( ( 0, var_12[1], 0 ) ) * getdvarint( "ht_missile_end_forward" ) + anglestoup( ( 0, var_12[1], 0 ) ) * getdvarint( "ht_missile_end_rad" ) * sin( var_11 ) + anglestoright( ( 0, var_12[1], 0 ) ) * getdvarint( "ht_missile_end_rad" ) * cos( var_11 );
                }
            }
            else
            {
                var_1 = level.time_of_hovertank_fire;
                var_7 = bullettrace( level.hovertank_player _meth_80A8() + 150 * anglestoforward( level.hovertank_player getangles() ), var_9, 1, var_0 );

                if ( isdefined( var_7["position"] ) )
                {
                    var_9 = var_7["position"];
                    var_4 = level.hovertank_player _meth_80A8()[2] - var_7["position"][2];
                    var_4 = common_scripts\utility::ter_op( var_4 > 0, var_4, 0 );
                }
                else
                    var_9 = level.hovertank_player _meth_80A8() + var_4 / cos( 90 - level.hovertank_player getangles()[0] ) * anglestoforward( level.hovertank_player getangles() );
            }

            var_13 = magicbullet( level.current_weapon, var_8, var_9, level.hovertank_player );

            if ( isdefined( level.hovertank_projectile_callback ) )
            {
                var_14 = [ level.current_weapon, var_7 ];
                var_13 thread [[ level.hovertank_projectile_callback ]]( var_14 );
            }

            level.hovertank_player notify( "missile_fire", var_13, level.current_weapon );
            level.hovertank_player notify( "LISTEN_hovertank_weapon_fired" );
            var_15 = ( 0, 0, 0 );
            var_12 = ( 0, 0, 0 );

            if ( isdefined( var_0 ) )
            {
                var_15 = var_0.origin;
                var_12 = var_0 gettagangles( "tag_flash" );
            }
            else
            {
                var_15 = level.player.origin;
                var_12 = level.player _meth_8036();
            }

            var_16 = 0.5;

            if ( issubstr( level.current_weapon, "cannon" ) )
            {
                if ( isdefined( var_0 ) )
                    playfxontag( common_scripts\utility::getfx( "hovertank_cannon_flash_view" ), var_0, "tag_flash" );

                playfxontag( common_scripts\utility::getfx( "hovertank_cannon_dust_ring" ), var_0, "tag_flash_animated" );
                earthquake( 1, 0.5, level.hovertank_player.origin, 500 );
                level.hovertank_player shellshock( "hovertank_cannon", 2 );
                level.hovertank_player _meth_80AD( "heavygun_fire" );
                soundscripts\_snd::snd_message( "hovertank_cannon_fire" );

                if ( isdefined( var_0 ) )
                {
                    if ( level.last_hovertank_weapon_anim == "cannon_fire" || gettime() >= level.last_hovertank_weapon_anim_complete_time )
                        var_0 _meth_8145( %lab_htank_cannon_fire_vmhtank, 1, 0.0 );
                    else
                        var_0 _meth_8145( %lab_htank_cannon_fire_vmhtank, 1, var_16 );

                    level.last_hovertank_weapon_anim = "cannon_fire";
                    level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength( %lab_htank_cannon_fire_vmhtank );
                    var_0 _meth_814D( %lab_htank_cannon_cylinder_vmhtank, 1, 0.0 );
                    soundscripts\_snd::snd_message( "hovertank_barrel_turn" );
                }

                physicsjolt( var_15, 300, 250, anglestoforward( var_12 ) * -0.1 );
            }
            else if ( issubstr( level.current_weapon, "antiair" ) )
            {
                playfxontag( common_scripts\utility::getfx( "hovertank_aa_flash_vm" ), var_0, "tag_flash_2" );
                level.hovertank_player shellshock( "hovertank_cannon", 1 );
                level.hovertank_player _meth_80AD( "heavygun_fire" );
                soundscripts\_snd::snd_message( "hovertank_antiair_fire" );
                physicsjolt( var_15, 300, 250, anglestoforward( var_12 ) * -0.01 );

                if ( isdefined( var_0 ) )
                {
                    if ( level.last_hovertank_weapon_anim == "emp_fire" || gettime() >= level.last_hovertank_weapon_anim_complete_time )
                        var_0 _meth_8145( %lab_htank_emp_fire_vmhtank, 1, 0.0 );
                    else
                        var_0 _meth_8145( %lab_htank_emp_fire_vmhtank, 1, var_16 );

                    level.last_hovertank_weapon_anim = "emp_fire";
                    level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength( %lab_htank_emp_fire_vmhtank );
                    soundscripts\_snd::snd_message( "hovertank_antiair_recoil" );
                }
            }
            else if ( issubstr( level.current_weapon, "missile" ) )
            {
                level.hovertank_player shellshock( "hovertank_cannon", 0.1 );
                level.hovertank_player _meth_80AD( "silencer_fire" );
                physicsjolt( var_15, 300, 250, anglestoforward( var_12 ) * -0.01 );
            }
        }

        thread weapon_reload( level.current_weapon );
    }
}

get_weapon_fire_pos( var_0, var_1 )
{
    if ( issubstr( var_0, "missile" ) )
    {
        var_2 = 1;

        if ( var_1 == 0 )
            var_2 = -1;

        var_3 = self gettagangles( "tag_aim_animated" );
        var_4 = self gettagorigin( "tag_aim_animated" );
        var_5 = getdvarint( "ht_missile_start_forward", 64 );
        var_6 = getdvarint( "ht_missile_start_up", 32 );
        var_7 = getdvarint( "ht_missile_start_right", 32 );
        var_8 = var_4 + anglestoforward( var_3 ) * var_5 + anglestoup( var_3 ) * var_6 + anglestoright( var_3 ) * var_7 * var_2;
        return var_8;
    }
    else if ( issubstr( var_0, "antiair" ) )
        return self gettagorigin( "tag_flash_2" );
    else if ( issubstr( var_0, "cannon" ) )
        return self gettagorigin( "tag_flash" );
    else
        return level.hovertank_player _meth_80A8();
}

hovertank_projectile_callback( var_0 )
{
    var_1 = var_0[0];
    var_2 = var_0[1];
    self.team = "allies";

    if ( issubstr( var_1, "missile" ) )
    {
        playfx( common_scripts\utility::getfx( "hovertank_anti_pers_muzzle_flash_vm" ), self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
        var_3 = -64;
        var_4 = 64;
        var_5 = _func_0A2();
        var_6 = [];

        for ( var_7 = 0; var_7 < var_5.size; var_7++ )
        {
            if ( !isdefined( var_5[var_7].missile_targetting ) )
            {
                if ( _func_09F( var_5[var_7], level.hovertank_player, 75, 60 ) )
                    var_6[var_6.size] = var_5[var_7];
            }
        }

        var_8 = undefined;
        var_9 = undefined;

        if ( var_6.size == 0 )
        {
            var_8 = spawn( "script_origin", var_2["position"] + ( randomintrange( var_3, var_4 ), randomintrange( var_3, var_4 ), randomintrange( var_3, var_4 ) ) );
            var_8.missile_targetting = 1;
        }
        else
        {
            var_9 = var_6[0];
            var_8 = var_9;
            var_9.missile_targetting = 1;
        }

        _func_09A( var_8 );
        _func_0A6( var_8, level.hovertank_player );
        self _meth_81D9( var_8 );
        thread missile_delayed_trail();
        self waittill( "death" );

        if ( isdefined( var_9 ) )
            var_9.missile_targetting = undefined;

        if ( isdefined( var_8 ) && var_8.classname == "script_origin" )
        {
            var_8 delete();
            return;
        }
    }
    else if ( issubstr( var_1, "antiair" ) )
    {
        self endon( "death" );
        var_10 = [];

        if ( isdefined( level.emp_vulnerable_list ) )
            var_10 = level.emp_vulnerable_list;

        var_11 = var_10;
        var_12 = 512;
        var_13 = var_12 * var_12;
        thread detonate_hovertank_aa_projectile_on_death( var_12 * 2 );

        for (;;)
        {
            var_10 = var_11;

            foreach ( var_15 in var_10 )
            {
                if ( !isdefined( var_15 ) || !isalive( var_15 ) )
                {
                    var_11 = common_scripts\utility::array_remove( var_11, var_15 );
                    continue;
                }

                if ( distancesquared( self.origin, var_15.origin ) < var_13 )
                {
                    self notify( "death" );
                    waittillframeend;
                    self delete();
                }
            }

            wait 0.05;
        }
    }
    else
    {
        if ( issubstr( var_1, "cannon" ) )
            return;

        return;
    }
}

missile_delayed_trail()
{
    var_0 = 0.5;
    wait(var_0);

    if ( isdefined( self ) )
    {
        playfxontag( common_scripts\utility::getfx( "hovertank_anti_pers_trail_rocket_2" ), self, "tag_origin" );
        self waittill( "death" );
    }
}

detonate_hovertank_aa_projectile_on_death( var_0 )
{
    self waittill( "death" );

    if ( isdefined( self ) )
    {
        radiusdamage( self.origin, var_0, 1, 1, level.hovertank_player, "MOD_ENERGY", "hovertank_antiair" );
        playfx( common_scripts\utility::getfx( "hovertank_aa_explosion" ), self.origin );
    }
}

manual_cannon_reload()
{
    level endon( "hovertank_end" );
    var_0 = "hovertank_cannon";

    for (;;)
    {
        var_1 = 0;

        while ( !var_1 )
        {
            var_2 = 0.3;

            while ( level.hovertank_player usebuttonpressed() && !level.weapon_cooldown_active[var_0] )
            {
                var_2 -= 0.05;

                if ( var_2 < 0 )
                {
                    var_1 = 1;
                    break;
                }

                wait 0.05;
            }

            wait 0.05;
        }

        if ( !level.weapon_cooldown_active[var_0] )
            thread weapon_reload( var_0, 1 );

        wait 0.05;
    }
}

weapon_reload( var_0, var_1 )
{
    level endon( "hovertank_end" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    level.weapon_ready_to_fire[var_0] = 0;

    if ( !var_1 )
        level.weapon_ammo_count[var_0]--;

    if ( !issubstr( var_0, "missile" ) )
        level.weapon_ammo_bar_value[var_0] = level.weapon_ammo_count[var_0] / level.weapon_ammo_max[var_0];

    if ( issubstr( var_0, "cannon" ) && level.weapon_ammo_count[var_0] == 0 || var_1 )
    {
        level notify( "hovertank_cannon_reload_hint" );
        common_scripts\utility::flag_clear( "hovertank_reload_hint" );
    }

    if ( !var_1 )
    {
        if ( level.weapon_reload_time[var_0] > 0 )
            wait(level.weapon_reload_time[var_0]);
    }

    if ( level.weapon_ammo_count[var_0] <= 0 || var_1 )
    {
        if ( issubstr( var_0, "antiair" ) )
            level.hovertank_player thread maps\_utility::play_sound_on_entity( "ac130_40mm_reload" );
        else if ( issubstr( var_0, "missile" ) )
            level.hovertank_player thread maps\_utility::play_sound_on_entity( "ac130_25mm_reload" );
        else
            soundscripts\_snd::snd_message( "ht_cannon_reload" );

        level.weapon_cooldown_active[var_0] = 1;

        if ( level.weapon_cooldown_time[var_0] > 0 )
        {
            weapon_ammo_bar_reload( var_0, var_1 );

            if ( issubstr( var_0, "cannon" ) )
                level notify( "kill_reload_sound" );
        }

        if ( !issubstr( var_0, "missile" ) )
            level.weapon_ammo_count[var_0] = level.weapon_ammo_max[var_0];

        level.weapon_cooldown_active[var_0] = 0;
    }
    else if ( issubstr( var_0, "cannon" ) && level.weapon_ammo_count[var_0] == 1 )
        thread hovertank_cannon_reload_hint();

    level.weapon_ready_to_fire[var_0] = 1;
}

weapon_ammo_bar_reload( var_0, var_1 )
{
    level endon( "hovertank_end" );

    if ( issubstr( var_0, "missile" ) )
    {
        wait(level.weapon_cooldown_time[var_0]);
        return;
    }

    var_2 = level.weapon_ammo_count[var_0];
    var_3 = level.weapon_ammo_max[var_0];

    if ( var_2 == var_3 )
        return;

    level.weapon_ammo_bar_color[var_0] = ( 1, 0, 0 );
    var_4 = 0.05;
    var_5 = 0.05;
    var_6 = 0;
    var_7 = 0;

    if ( var_1 )
    {
        var_7 = level.weapon_cooldown_time[var_0] * ( 1 - level.weapon_ammo_bar_value[var_0] );
        var_5 = var_4 / var_7 * ( var_3 - var_2 ) / var_3;
    }
    else
    {
        var_7 = level.weapon_cooldown_time[var_0];
        var_5 = var_4 / var_7;
    }

    while ( var_6 < var_7 )
    {
        level.weapon_ammo_bar_value[var_0] += var_5;
        var_6 += var_4;
        wait(var_4);
    }

    level.weapon_ammo_bar_value[var_0] = 1;
    level.weapon_ammo_bar_color[var_0] = ( 1, 1, 1 );
}

hovertank_cannon_reload_hint()
{
    level notify( "hovertank_cannon_reload_hint" );
    level endon( "hovertank_cannon_reload_hint" );
    wait 5;
    common_scripts\utility::flag_set( "hovertank_reload_hint" );
    maps\_utility::display_hint_timeout( "hovertank_reload", 10 );
}

break_hovertank_reload_hint()
{
    return !common_scripts\utility::flag( "hovertank_reload_hint" );
}

shotfired()
{
    level endon( "hovertank_end" );

    for (;;)
    {
        level.hovertank_player waittill( "projectile_impact", var_0, var_1, var_2 );

        if ( is_hovertank_weapon( var_0, "cannon" ) )
        {

        }
        else if ( is_hovertank_weapon( var_0, "antiair" ) )
            earthquake( 0.2, 0.5, var_1, 2000 );

        if ( is_hovertank_weapon( var_0 ) )
            thread shotfiredphysicssphere( var_1, var_0 );

        wait 0.05;
    }
}

is_hovertank_weapon( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        return issubstr( tolower( var_0 ), var_1 );
    else
        return issubstr( tolower( var_0 ), "cannon" ) || issubstr( tolower( var_0 ), "antiair" ) || issubstr( tolower( var_0 ), "missile" );
}

missile_fire_audio()
{
    level endon( "hovertank_end" );
    var_0 = 0;
    var_1 = "stopped";
    var_2 = "stopped";
    level.gun_state = var_1;
    thread missile_fire_audio_end();
    var_3 = 0;
    var_4 = 100;

    for (;;)
    {
        if ( gettime() - var_3 > var_4 )
        {
            if ( !issubstr( level.current_weapon, "missile" ) )
                var_2 = "stopped";
            else if ( level.hovertank_player.firingweapons )
            {
                if ( level.weapon_ammo_count[level.current_weapon] > 2 )
                    var_2 = "full_loop";
                else
                    var_2 = "slow_loop";
            }
            else
                var_2 = "stopped";

            if ( var_2 != var_1 )
            {
                switch ( var_2 )
                {
                    case "stopped":
                        soundscripts\_snd::snd_message( "hovertank_missile_small_stop" );
                        var_1 = "stopped";
                        level.gun_state = var_1;
                        break;
                    case "full_loop":
                        soundscripts\_snd::snd_message( "hovertank_missile_small_start" );
                        var_1 = "full_loop";
                        level.gun_state = var_1;
                        break;
                    case "slow_loop":
                        soundscripts\_snd::snd_message( "hovertank_missile_small_slow" );
                        var_1 = "slow_loop";
                        level.gun_state = var_1;
                        break;
                    default:
                        break;
                }

                var_3 = gettime();
            }

            wait 0.05;
            continue;
        }

        wait 0.05;
    }
}

missile_fire_audio_end()
{
    level waittill( "hovertank_end" );

    if ( level.gun_state != "stopped" )
        soundscripts\_snd::snd_message( "hovertank_missile_small_stop" );
}

shotfiredphysicssphere( var_0, var_1 )
{
    wait 0.1;
}

hud_blink_current_weapon_name( var_0 )
{
    level notify( "LISTEN_end_hud_blink_current_weapon_name" );
    level endon( "LISTEN_end_hud_blink_current_weapon_name" );
    level endon( "hovertank_end" );

    if ( !isdefined( level.huditem["weapon_icon"] ) )
        return;

    foreach ( var_2 in level.huditem["weapon_icon"] )
    {
        var_2.alpha = 1;
        var_2.color = ( 0.3, 0.3, 0.3 );
    }

    level.huditem["weapon_icon"][var_0].alpha = 1;

    for (;;)
    {
        update_hovertank_icons();
        level.huditem["weapon_icon"][var_0] fadeovertime( 0.2 );
        level.huditem["weapon_icon"][var_0].color = ( 1, 1, 1 );
        wait 0.25;
        level.huditem["weapon_icon"][var_0] fadeovertime( 0.2 );
        level.huditem["weapon_icon"][var_0].color = ( 0.5, 0.5, 0.5 );
        wait 0.25;
    }
}

hovertank_ride_anims()
{
    self endon( "death" );
    self _meth_8115( #animtree );
    self _meth_814B( %lab_htank_idle_vm );
    self _meth_814B( %lab_htank_idle_vmhtank );

    for (;;)
    {
        self waittill( "large_hit_react" );
        var_0 = getanimlength( %lab_htank_react_large_vmhtank );
        self _meth_8145( %lab_htank_react_large_vmhtank, 1, 0 );
        wait(var_0);
        self _meth_8143( %lab_htank_idle_vmhtank, 1, 0.5 );
    }
}

init_hovertank()
{
    if ( isdefined( self ) && self != level )
    {
        self _meth_8115( #animtree );

        if ( self.vehicletype != "hovertank_npc_physics_tank" )
            self _meth_8456( 0.7 );

        self.script_bulletshield = 1;
        self.script_grenadeshield = 1;
        self.script_badplace = 1;
    }
}

precache_for_hovertank()
{
    precacheturret( "hovertank_turret" );
    precachemodel( "vehicle_mil_hovertank_vm" );
    precachemodel( "vehicle_mil_hovertank_simple_vm" );
    precachemodel( "viewbody_sentinel_covert" );
    precacherumble( "steady_rumble" );
    precacherumble( "heavygun_fire" );
    precacherumble( "damage_heavy" );
    precacherumble( "damage_light" );
    precacherumble( "silencer_fire" );
    precachemodel( "vehicle_mil_hovertank_screen01" );
    precachestring( "LAB_TROPHY_SYSTEM" );
    precache_lui_hovertank_screens();
    init_hovertank_weapons();
}

precache_lui_hovertank_screens()
{
    precachestring( &"flash01" );
    precachestring( &"qflash01" );
    precachestring( &"flash02" );
    precachestring( &"flash03" );
    precachestring( &"flash04" );
    precachestring( &"qflash05" );
    precachestring( &"flash05" );
    precachestring( &"flash06" );
    precachestring( &"hit01" );
    precachestring( &"hit02" );
    precachestring( &"hit03" );
    precachestring( &"hit04" );
    precachestring( &"hit05" );
    precachestring( &"hit06" );
    precachestring( &"off01" );
    precachestring( &"off02" );
    precachestring( &"off03" );
    precachestring( &"off04" );
    precachestring( &"off05" );
    precachestring( &"off06" );
    precacheshader( "mtl_hovertank_screen_hit_01" );
    precacheshader( "mtl_hovertank_screen_hit_02" );
    precacheshader( "mtl_hovertank_screen_hit_03" );
    precacheshader( "mtl_hovertank_screen_hit_04" );
    precacheshader( "mtl_hovertank_screen_hit_05" );
    precacheshader( "mtl_hovertank_screen_hit_06" );
}

hovertank_audio()
{
    self endon( "death" );
    var_0 = spawnstruct();
    var_0.player_mode = 1;
    var_0.preset_name = "hovertank";
    var_1 = vehicle_scripts\_hovertank_aud::hovertank_constructor;
    soundscripts\_snd::snd_message( "snd_register_vehicle", var_0.preset_name, var_1 );

    if ( var_0.player_mode == 1 )
        soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );

    level.player waittill( "hovertank_dismounted" );
    soundscripts\_snd::snd_message( "snd_stop_vehicle" );
}

handle_hovertank_collisions()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "veh_contact", var_0, var_1, var_2, var_3, var_4 );

        if ( isdefined( self.last_collision_time ) && self.last_collision_time == gettime() )
            continue;

        self.last_collision_time = gettime();
        var_5 = [];
        var_5["vehicle"] = self;
        var_5["hit_entity"] = var_0;
        var_5["pos"] = var_1;
        var_5["impulse"] = var_2;
        var_5["relativeVel"] = var_3;
        var_5["surface"] = var_4;
        soundscripts\_snd::snd_message( "aud_impact_system_hovertank", var_5 );
    }
}

set_up_target()
{
    if ( isdefined( self ) )
    {
        if ( isdefined( self.script_parameters ) && self.script_parameters == "no_target" )
            return;

        _func_09A( self, get_npc_center_offset() );
        _func_0A6( self, level.hovertank_player );
    }
}

get_npc_center_offset()
{
    if ( isai( self ) && isalive( self ) )
    {
        var_0 = self _meth_80A8()[2];
        var_1 = self.origin[2];
        var_2 = ( var_0 - var_1 ) / 2;
        return ( 0, 0, var_2 );
    }
    else
        return ( 0, 0, 0 );
}

monitor_player_damage()
{
    level.player endon( "end_monitor_player_damage" );
    level.player.death_invulnerable_activated = 0;
    var_0 = 1;

    switch ( level.gameskill )
    {
        case 2:
            var_0 = 1.5;
            break;
        case 3:
            var_0 = 1.5;
            break;
        default:
            var_0 = 1;
            break;
    }

    level.player_ugv_health = 600 * var_0;
    level.player_ugv_health_max_health = 600 * var_0;

    for (;;)
    {
        level.player waittill( "damage", var_1, var_2, var_3, var_4, var_5 );
        level.player_ugv_health_hurtagain = 1;

        if ( !level.player.death_invulnerable_activated )
            level.player_ugv_health -= var_1;
    }
}

pass_hovertank_damage_to_player()
{
    level endon( "hovertank_end" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        var_10 = var_3;

        if ( isdefined( var_1 ) )
        {
            if ( isdefined( var_1.team ) && var_1.team == level.player.team )
                continue;

            var_11 = distance( self.origin, var_1.origin );
            var_10 = var_3 + var_2 * var_11 * -1;
        }

        level.player _meth_8051( 0.1, var_10, var_1 );
    }
}

handle_hovertank_death()
{
    level endon( "hovertank_end" );
    self waittill( "death" );
    level.player freezecontrols( 1 );
    setdvar( "ui_deadquote", &"LAB_MISSION_FAILED_TANK_DESTROYED" );
    maps\_utility::missionfailedwrapper();
}

health_monitor()
{
    level.huditem["health_text"] = level.player maps\_hud_util::createclientfontstring( "default", 1.2 );
    level.huditem["health_text"] maps\_hud_util::setpoint( "LEFT", undefined, 60, -50 );
    level.huditem["health_text"] settext( "Armor Status" );
    level.huditem["health_text"].alpha = 0.6;
    level.huditem["health_bar"] = level.player maps\_hud_util::createclientprogressbar( level.player, 60, "white", "black", 100, 10 );
    level.huditem["health_bar"] maps\_hud_util::setpoint( "LEFT", undefined, 65, -38 );
    level.huditem["health_bar"] maps\_hud_util::updatebar( 1 );
    level.huditem["health_bar"].alpha = 0.6;
    level.huditem["health_bar"].bar.alpha = 0.6;
    maps\_utility::add_damage_function( ::track_health_damage_function );
}

track_health_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = get_tank_health_percent();

    if ( var_7 < 0 )
        var_7 = 0;

    level.huditem["health_bar"] maps\_hud_util::updatebar( var_7 );
}

get_tank_health_percent()
{
    if ( isdefined( self ) )
    {
        var_0 = self.health - self.healthbuffer;
        var_1 = var_0 / ( self.maxhealth - self.healthbuffer );
        var_2 = int( ceil( var_1 * 100 ) ) / 100;
        return var_2;
    }
    else
        return 0;
}

update_health_bar( var_0 )
{
    var_1 = 5;
    var_2 = 20 * var_1;
    var_3 = 0;

    while ( var_3 < var_2 && isdefined( self ) )
    {
        maps\_hud_util::updatebar( var_3 / var_2 );
        var_3++;
        wait 0.05;
    }
}

trophy_system()
{
    level endon( "hovertank_end" );
    level.missiles = [];
    thread trackmissiles();
    self.trophytags = [ "TAG_VFX_TROPHY_RT", "TAG_VFX_TROPHY_LT" ];
    var_0 = self;
    var_1 = 450;
    var_2 = var_1 * var_1;
    self.trophyammomax = 100;
    self.trophyammo = self.trophyammomax;
    self.trophy_cost = 1;
    thread trophy_ammo_counter();
    thread trophy_reload_bar();
    maps\_utility::add_damage_function( ::trophy_system_backup );

    for (;;)
    {
        if ( level.missiles.size < 1 )
        {
            wait 0.05;
            continue;
        }

        if ( self.trophyammo < self.trophy_cost )
        {
            wait 0.05;
            continue;
        }

        var_3 = level.missiles;

        foreach ( var_5 in var_3 )
        {
            wait 0.05;

            if ( !has_trophy_ammo() )
                break;

            if ( !isdefined( var_5 ) )
                continue;

            if ( var_5 == self )
                continue;

            if ( isdefined( var_5.team ) && var_5.team == "allies" )
                continue;

            var_6 = distancesquared( var_5.origin, self.origin );

            if ( var_6 < var_2 )
                deploy_trophy( var_5 );
        }
    }
}

trophy_system_backup( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( has_trophy_ammo() && var_4 == "MOD_PROJECTILE" )
    {
        deploy_trophy( undefined, var_3 );
        self.health = self.currenthealth;
    }
    else if ( var_4 == "MOD_PROJECTILE" )
        soundscripts\_snd::snd_message( "defenseless_tank_impact" );
}

set_trophy_ammo( var_0 )
{
    self.trophyammo = var_0;
    level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar( self.trophyammo / self.trophyammomax );
}

get_trophy_ammo()
{
    return self.trophyammo;
}

has_trophy_ammo()
{
    return self.trophyammo >= self.trophy_cost;
}

fires_explosives( var_0 )
{
    if ( issubstr( self.classname, "rpg" ) )
        return 1;

    if ( issubstr( self.classname, "tank" ) )
        return 1;

    if ( isdefined( self.model ) && issubstr( self.model, "warbird" ) )
        return 1;

    if ( isdefined( var_0 ) && issubstr( var_0, "rpg" ) )
        return 1;

    if ( isdefined( var_0 ) && issubstr( var_0, "ft101" ) )
        return 1;

    return 0;
}

deploy_trophy( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = spawn( "script_origin", var_1 );

    self notify( "trophy_deployed", var_0.origin );
    var_2 = get_closest_tag( var_0.origin, self.trophytags );

    if ( !isdefined( self.last_trophy_time ) )
        self.last_trophy_time = 0;

    var_3 = 0.2;

    if ( gettime() - self.last_trophy_time > var_3 * 1000 )
    {
        playfx( common_scripts\utility::getfx( "trophy_flash" ), var_2, var_0.origin - var_2 );
        var_4 = common_scripts\utility::spawn_tag_origin();
        var_4.origin = var_0.origin;

        if ( isdefined( var_0.angles ) )
            var_4.angles = var_0.angles;
        else
            var_4.angles = vectortoangles( var_0.origin - level.player.origin );

        playfxontag( common_scripts\utility::getfx( "trophy_explosion" ), var_4, "tag_origin" );
        soundscripts\_snd::snd_message( "hovertank_trophy_system", var_0 );
        var_5 = vectornormalize( var_4.origin - level.hovertank.turret.origin );
        var_6 = anglestoright( level.hovertank.turret gettagangles( "tag_aim_animated" ) );
        var_7 = vectordot( var_6, var_5 );
        var_8 = anglestoforward( level.hovertank.turret gettagangles( "tag_aim_animated" ) );
        var_9 = vectorcross( var_5, var_8 );
        var_10 = 0.2;
        var_11 = 0.05;

        if ( var_9[2] >= 0.4 )
        {
            thread hoverscreen_hit( 3, var_10 );
            thread hoverscreen_hit( 4, var_10 );
            thread hoverscreen_hit( 2, var_11 );
            thread hoverscreen_hit( 5, var_11 );
        }
        else if ( var_9[2] <= -0.4 )
        {
            thread hoverscreen_hit( 1, var_10 );
            thread hoverscreen_hit( 6, var_10 );
            thread hoverscreen_hit( 2, var_11 );
            thread hoverscreen_hit( 5, var_11 );
        }
        else if ( var_9[2] > -0.4 && var_9[2] < 0.4 )
        {
            thread hoverscreen_hit( 2, var_10 );
            thread hoverscreen_hit( 5, var_10 );
            thread hoverscreen_hit( 3, var_11 );
            thread hoverscreen_hit( 4, var_11 );
            thread hoverscreen_hit( 1, var_11 );
            thread hoverscreen_hit( 6, var_11 );
        }

        var_4 common_scripts\utility::delaycall( 0.05, ::delete );
    }

    self.last_trophy_time = gettime();
    self.trophyammo -= self.trophy_cost;

    if ( isdefined( level.huditem["trophy_reload_bar"] ) )
        level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar( self.trophyammo / self.trophyammomax );

    var_0 delete();
}

trophy_reload_bar()
{
    level.huditem["trophy_reload_bar"] = level.player maps\_hud_util::createclientprogressbar( level.player, 60, "white", "black", 100, 10 );
    level.huditem["trophy_reload_bar"] maps\_hud_util::setpoint( "LEFT", undefined, 65, -3 );
    level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar( 1 );
    level.huditem["trophy_reload_bar"].alpha = 0.6;
    level.huditem["trophy_reload_bar"].bar.alpha = 0.6;
    level.huditem["trophy_reload_bar_split"] = [];
}

trophy_reload()
{
    update_trophy_reload_progress_bar();
}

update_trophy_reload_progress_bar()
{
    level endon( "hovertank_end" );
    var_0 = 5;
    var_1 = 20 * var_0;
    var_2 = 0;
    var_3 = 0.05;

    while ( var_2 < var_0 && isdefined( self ) )
    {
        level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar( self.trophyammo / 100 );
        self.trophyammo += self.trophy_cost / var_0 * var_3;
        var_2 += var_3;
        wait(var_3);
    }

    level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar( self.trophyammo / 100 );
}

trophy_ammo_counter()
{
    level endon( "hovertank_end" );
    level.huditem["trophy_ammo_counter_text"] = level.player maps\_hud_util::createclientfontstring( "default", 1.2 );
    level.huditem["trophy_ammo_counter_text"] maps\_hud_util::setpoint( "LEFT", undefined, 60, -15 );
    level.huditem["trophy_ammo_counter_text"] settext( &"LAB_TROPHY_SYSTEM" );
    level.huditem["trophy_ammo_counter_text"].alpha = 0.6;
}

get_closest_tag( var_0, var_1 )
{
    var_2 = 1000000000;
    var_3 = ( 0, 0, 0 );

    foreach ( var_5 in var_1 )
    {
        var_6 = self.turret gettagorigin( var_5 );
        var_7 = distancesquared( var_6, var_0 );

        if ( var_7 < var_2 )
        {
            var_2 = var_7;
            var_3 = var_6;
        }
    }

    return var_3;
}

trackmissiles()
{
    level endon( "hovertank_end" );

    for (;;)
    {
        var_0 = getentarray( "rocket", "classname" );
        var_1 = [];

        foreach ( var_3 in var_0 )
        {
            if ( isdefined( var_3.team ) && var_3.team == "allies" )
                continue;
            else
                var_1[var_1.size] = var_3;
        }

        level.missiles = var_1;
        wait 0.05;
    }
}

weapon_ammo_bar()
{
    level endon( "hovertank_end" );

    for (;;)
    {
        for ( var_0 = 0; var_0 < 3; var_0++ )
            var_1 = level.hovertank_weapon[var_0].weapon;

        wait 0.05;
    }
}

missile_tracking_hud()
{
    level endon( "hovertank_end" );
    self.tracked = 1;
    _func_09A( self );
    _func_09C( self, "hud_minimap_tracking_drone_red" );
}

update_hovertank_icons()
{
    update_hovertank_icons_proc( 0, "s1_icon_hovertank_canon" );
    update_hovertank_icons_proc( 1, "s1_icon_hovertank_missile_small" );
    update_hovertank_icons_proc( 2, "s1_icon_hovertank_antiair" );
}

update_hovertank_icons_proc( var_0, var_1 )
{
    if ( !level.player _meth_834E() )
    {
        level.huditem["weapon_icon"][var_0] _meth_80CC( var_1 + "_pc", get_icon_width( var_0 ), get_icon_height( var_0 ) );
        level.huditem["weapon_key"][var_0].alpha = 1;
    }
    else if ( level.ps3 || level.ps4 )
    {
        level.huditem["weapon_icon"][var_0] _meth_80CC( var_1 + "_ps3", get_icon_width( var_0 ), get_icon_height( var_0 ) );
        level.huditem["weapon_key"][var_0].alpha = 0;
    }
    else
    {
        level.huditem["weapon_icon"][var_0] _meth_80CC( var_1, get_icon_width( var_0 ), get_icon_height( var_0 ) );
        level.huditem["weapon_key"][var_0].alpha = 0;
    }
}

get_icon_width( var_0 )
{
    return level.huditem["weapon_icon"][var_0].icon_width;
}

get_icon_height( var_0 )
{
    return level.huditem["weapon_icon"][var_0].icon_height;
}
