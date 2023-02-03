// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

warp_to_start( var_0 )
{
    var_1 = var_0;

    if ( isstring( var_0 ) )
    {
        var_1 = common_scripts\utility::getstruct( var_0, "targetname" );

        if ( !isdefined( var_1 ) )
            var_1 = getent( var_0, "targetname" );
    }

    if ( !isdefined( var_1 ) )
        return;

    if ( self islinked() )
        self unlink();

    if ( self == level.player )
    {
        self setorigin( var_1.origin );
        level.player setangles( var_1.angles );
    }
    else
        self forceteleport( var_1.origin, var_1.angles );
}

warp_allies( var_0, var_1, var_2 )
{
    if ( !isdefined( level.allies ) || !isdefined( level.allies.size ) )
        return;

    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    var_3 = [ "r", "b", "y" ];

    if ( !isdefined( var_2 ) )
        var_2 = level.allies.size;

    for ( var_4 = 0; var_4 < var_2; var_4++ )
    {
        level.allies[var_4] thread warp_to_start( var_0 + "_" + var_4 );

        if ( isdefined( var_1 ) && var_1 )
            level.allies[var_4] maps\_utility::set_force_color( var_3[var_4] );
    }
}

spawn_allies( var_0 )
{
    if ( !isdefined( var_0 ) )
    {
        if ( start_point_is_before( "test_chamber" ) )
            var_0 = 3;
        else if ( start_point_is_between( [ "test_chamber", "mb2" ], 1 ) )
            var_0 = 1;
        else if ( start_point_is_after( "mb2" ) )
            var_0 = 2;
        else
            var_0 = 3;
    }

    if ( !isdefined( level.allies ) )
        level.allies = [];
    else if ( level.allies.size >= var_0 )
        return;

    var_1 = getentarray( "spawner_ally", "script_noteworthy" );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, ::spawnfunc_ally );

    for ( var_2 = 0; var_2 < var_0; var_2++ )
    {
        var_3 = getent( "ally_" + var_2, "targetname" ) maps\_utility::spawn_ai();
        var_3.animname = "ally_" + var_2;
        level.allies[var_2] = var_3;
    }

    if ( isdefined( level.allies[0] ) && isalive( level.allies[0] ) )
        level.ally = level.allies[0];
}

spawnfunc_ally()
{
    maps\_utility::make_hero();
    maps\_utility::magic_bullet_shield();
}

dialogue_nag_loop( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "death" );

    if ( isdefined( var_1 ) )
        level endon( var_1 );

    self notify( "start_nag_loop" );
    self endon( "start_nag_loop" );

    if ( !isdefined( var_2 ) )
        var_2 = 0.0;

    if ( !isdefined( var_3 ) )
        var_3 = 4.0;

    if ( !isdefined( var_4 ) )
        var_4 = 0.0;

    if ( !isdefined( var_5 ) )
        var_5 = 300;

    var_6 = var_3 - var_2;

    for (;;)
    {
        foreach ( var_8 in var_0 )
        {
            thread dialogue_nag_player( var_8 );
            common_scripts\utility::flag_waitopen( "flag_currently_nagging" );
            wait(randomfloatrange( var_2, var_3 ));
            var_3 = min( var_5, var_3 + var_4 );
            var_2 = var_3 - var_6;
        }

        wait 0.05;
        var_0 = common_scripts\utility::array_randomize( var_0 );
    }
}

dialogue_nag_player( var_0 )
{
    common_scripts\utility::flag_set( "flag_currently_nagging" );
    maps\_utility::dialogue_queue( var_0 );
    common_scripts\utility::flag_clear( "flag_currently_nagging" );
}

radio_dialogue_nag_loop( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );

    if ( isdefined( var_1 ) )
        level endon( var_1 );

    self notify( "start_nag_loop" );
    self endon( "start_nag_loop" );

    if ( !isdefined( var_2 ) )
        var_2 = 8;

    if ( !isdefined( var_3 ) )
        var_3 = 12;

    if ( !isdefined( var_4 ) )
        var_4 = 0.0;

    if ( !isdefined( var_5 ) )
        var_5 = 300;

    var_7 = var_3 - var_2;

    for (;;)
    {
        foreach ( var_9 in var_0 )
        {
            if ( isdefined( var_6 ) )
                common_scripts\utility::flag_clear( var_6 );

            maps\_utility::smart_radio_dialogue( var_9 );

            if ( isdefined( var_6 ) )
                common_scripts\utility::flag_set( var_6 );

            wait(randomfloatrange( var_2, var_3 ));
            var_3 = min( var_5, var_3 + var_4 );
            var_2 = var_3 - var_7;
        }

        wait 0.05;
        var_0 = common_scripts\utility::array_randomize( var_0 );
    }
}

delay_retreat( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_2 ) )
        thread opfor_retreat( var_0, var_2, var_3 );

    common_scripts\utility::flag_wait_or_timeout( var_3, var_1 );

    if ( common_scripts\utility::flag( var_3 ) && !isdefined( level.opfor_retreat ) )
    {
        tprintln( "Retreat trigger: " + var_3, 1 );
        thread retreat_proc( var_3, var_4, var_5 );
        return;
    }

    if ( !isdefined( level.opfor_retreat ) )
        tprintln( "Retreat timeout: " + var_1 + " | " + var_3, 1 );

    thread retreat_proc( var_3, var_4, var_5, var_6 );
    level.opfor_retreat = undefined;
}

opfor_retreat( var_0, var_1, var_2 )
{
    level endon( var_2 );

    if ( !isarray( var_1 ) )
        var_1 = [ int( min( 0, var_1 ) ), int( max( -1, var_1 ) ) ];

    if ( var_1[0] < 0 )
    {
        for ( var_3 = var_1[0]; var_3 < 0; var_3++ )
        {
            level waittill( "ai_killed", var_4 );
            tprintln( "kills: " + ( var_3 + 1 ) + " || " + maps\_utility::get_ai_group_sentient_count( var_0 ) );

            if ( !isdefined( var_4.script_aigroup ) || var_4.script_aigroup != var_0 )
                var_3--;
        }
    }

    if ( var_1[1] >= 0 )
    {
        while ( maps\_utility::get_ai_group_sentient_count( var_0 ) > var_1[1] )
            wait 0.1;
    }

    tprintln( "Retreat kills: " + maps\_utility::get_ai_group_sentient_count( var_0 ) + " | " + var_2, 1 );
    level.opfor_retreat = 1;
    common_scripts\utility::flag_set( var_2 );
}

retreat_proc( var_0, var_1, var_2, var_3 )
{
    if ( !common_scripts\utility::flag( var_0 ) )
        common_scripts\utility::flag_set( var_0 );

    if ( isdefined( var_1 ) && !isarray( var_1 ) )
        var_1 = [ var_1 ];

    if ( isdefined( var_1 ) )
    {
        var_4 = [];

        foreach ( var_6 in var_1 )
        {
            var_6 = getent( var_6, "targetname" );

            if ( isdefined( var_6 ) )
                var_4[var_4.size] = var_6;
        }

        if ( var_4.size > 0 )
            var_1 = var_4;
        else
            var_1 = undefined;
    }

    if ( isdefined( var_1 ) )
    {
        var_1[0] notify( "trigger" );
        wait 0.05;

        if ( isdefined( var_2 ) && var_2 )
        {
            foreach ( var_6 in var_1 )
            {
                if ( isdefined( var_6 ) )
                    var_6 delete();
            }
        }
    }

    if ( isdefined( var_3 ) && !isarray( var_3 ) )
        var_3 = [ var_3 ];

    if ( isdefined( var_3 ) )
    {
        foreach ( var_11 in var_3 )
            level notify( var_11 );
    }
}

kt_time( var_0 )
{
    if ( !isdefined( level.killer_tracker ) )
        return var_0;

    if ( level.killer_tracker > 2 )
        return var_0 * clamp( level.killer_tracker - 1, 1, 5 );

    return var_0;
}

setup_player_for_animated_sequence( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( var_0 )
    {
        if ( !isdefined( var_1 ) )
            var_1 = 60;
    }

    if ( !isdefined( var_8 ) )
        var_8 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = level.player.origin;

    if ( !isdefined( var_3 ) )
        var_3 = level.player.angles;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    if ( !isdefined( var_6 ) )
        var_6 = "player_rig";

    var_9 = maps\_utility::spawn_anim_model( var_6, var_2 );
    level.player.rig = var_9;
    var_9.angles = var_3;
    var_9.animname = var_6;

    if ( isdefined( var_7 ) )
        var_10 = maps\_utility::spawn_anim_model( var_7 );
    else
        var_10 = common_scripts\utility::spawn_tag_origin();

    level.player.mover = var_10;
    var_10.origin = var_2;
    var_10.angles = var_3;
    var_9 linkto( var_10 );

    if ( var_0 )
    {
        if ( isarray( var_1 ) )
            level.player playerlinktodelta( var_9, "tag_origin", var_8, var_1[0], var_1[1], var_1[2], var_1[3], 1 );
        else
            level.player playerlinktodelta( var_9, "tag_origin", var_8, var_1, var_1, var_1, var_1, 1 );
    }

    if ( var_4 )
        thread player_animated_sequence_restrictions( var_5 );
}

player_animated_sequence_restrictions( var_0 )
{
    if ( isdefined( var_0 ) && var_0 )
        level.player waittill( "notify_player_animated_sequence_restrictions" );

    level.player.disablereload = 1;
    level.player disableweapons();
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
    level.player allowcrouch( 0 );
    level.player allowjump( 0 );
    level.player allowmelee( 0 );
    level.player allowprone( 0 );
    level.player allowsprint( 0 );
}

player_animated_sequence_cleanup()
{
    if ( !isdefined( level.player.early_weapon_enabled ) || !level.player.early_weapon_enabled )
    {
        level.player.early_weapon_enabled = undefined;
        level.player.disablereload = 0;
        level.player enableweapons();
        level.player enableoffhandweapons();
        level.player enableweaponswitch();
    }

    level.player allowcrouch( 1 );
    level.player allowjump( 1 );
    level.player allowmelee( 1 );
    level.player allowprone( 1 );
    level.player allowsprint( 1 );
    level.player unlink();

    if ( isdefined( level.player.mover ) )
        level.player.mover delete();

    if ( isdefined( level.player.rig ) )
        level.player.rig delete();
}

smooth_player_link( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = [ 0, 0, 0, 0 ];
    else if ( !isarray( var_2 ) )
        var_2 = [ var_2, var_2, var_2, var_2 ];

    level.player playerlinktoblend( var_0, "tag_player", var_1 );
    wait(var_1);
    level.player playerlinktodelta( var_0, "tag_player", 1, var_2[0], var_2[1], var_2[2], var_2[3], 1 );
    var_0 show();
}

anim_set_real_time( var_0, var_1, var_2 )
{
    common_scripts\utility::array_thread( var_0, ::anim_self_set_real_time, var_1, var_2 );
}

anim_self_set_real_time( var_0, var_1 )
{
    var_2 = maps\_utility::getanim( var_0 );
    var_3 = var_1 / getanimlength( var_2 );
    self setanimtime( var_2, var_3 );
}

start_one_handed_gunplay( var_0 )
{
    self endon( "death" );
    self notify( "stop_one_handed_gunplay" );
    self endon( "stop_one_handed_gunplay" );
    self.melee_threat = -1024;
    self.gun_threat = -512;

    if ( !isdefined( var_0 ) )
        var_0 = self getcurrentweapon();

    self disableweaponswitch();
    self setautopickup( 0 );
    self.one_weap = "init";
    self.one_ammo = 15;
    self.one_frac = 1;
    self.one_time = 0;
    self.ot = [];
    self.ot["gun"] = 5000;
    self.ot["aggro"] = 6000;
    self.ot["flash"] = 10000;
    self.ot["gen"] = 15000;
    self.ot["p_kill"] = 15000;
    self.ot["a_kill"] = 15000;
    level one_handed_help_vo_setup();
    level.player thread one_handed_help_flash_ally_tracker( 1000 );
    self giveweapon( "iw5_mahem_sp" );
    thread one_handed_swap_tracking();

    if ( issubstr( var_0, "knife" ) )
        one_handed_switch_to_melee( 1 );
    else
        one_handed_weapon_check_swap( var_0 );

    thread one_handed_pickup_handling();
    thread one_handed_drop_handling();
    thread one_handed_grenade_handling();
    thread one_handed_ammo_tracking();
    thread one_handed_mantle_handling();
    thread one_handed_exododge_handling();
}

one_handed_pickup_handling()
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );
    self notify( "start_one_handed_pickup_handling" );
    self endon( "start_one_handed_pickup_handling" );

    for (;;)
    {
        self waittill( "weapon_change", var_0 );

        if ( isdefined( var_0 ) && var_0 != "none" && var_0 != "iw5_kvahazmatknifeonearm_sp" )
            one_handed_weapon_check_swap( var_0 );
    }
}

one_handed_drop_handling()
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );
    self notify( "start_one_handed_drop_handling" );
    self endon( "start_one_handed_drop_handling" );

    for (;;)
    {
        self waittill( "pickup", var_0, var_1 );

        if ( !isdefined( var_0.dropped ) )
            self notify( "one_handed_weapon_swap", 1.0 );

        if ( !isdefined( var_1 ) )
        {
            tprintln( "Bug this if you didn't just throw a grenade" );
            continue;
        }
        else
        {
            if ( !issubstr( var_1.classname, "knife" ) )
            {
                var_2 = spawn( maps\_utility::string( "weapon_" + one_handed_get_base_weapon( var_1.classname ) ), var_1.origin );
                var_2.angles = var_1.angles;
                var_2.dropped = 1;
                var_2 itemweaponsetammo( self.one_ammo, 0 );
                var_1 delete();

                if ( self.one_frac <= 0.33 )
                    var_2.low_ammo = 1;

                continue;
            }

            self notify( "melee_weapon_dropped" );
            var_1 delete();
        }
    }
}

one_handed_grenade_handling()
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );
    self notify( "start_one_handed_grenade_handling" );
    self endon( "start_one_handed_grenade_handling" );

    for (;;)
    {
        self waittill( "grenade_fire" );
        var_0 = self getweaponammoclip( self getcurrentweapon() );
        var_1 = one_handed_get_base_weapon( self getcurrentweapon() );

        if ( isdefined( var_1 ) && issubstr( var_1, "knife" ) )
            continue;

        if ( isdefined( var_1 ) )
        {
            var_2 = vectornormalize( anglestoforward( self.angles ) );
            var_3 = vectornormalize( anglestoright( self.angles ) );
            var_4 = self.origin + randomfloatrange( 16, 24 ) * var_3 + randomfloatrange( -6, 6 ) * var_2 + ( 0, 0, 4 );
            var_5 = spawn( maps\_utility::string( "weapon_" + var_1 ), var_4 );
            var_5.angles = ( 0, randomint( 360 ), 0 );
            var_5 itemweaponsetammo( var_0, 0 );
        }

        one_handed_switch_to_melee( 1 );
    }
}

one_handed_ammo_tracking()
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );
    self notify( "start_one_handed_ammo_tracking" );
    self endon( "start_one_handed_ammo_tracking" );

    for (;;)
    {
        var_0 = common_scripts\utility::waittill_notify_or_timeout_return( "one_hand_pickup", 0.05 );
        var_1 = gettime();
        self.one_weap = self getcurrentweapon();

        if ( self.one_weap != "none" && self.one_weap != "iw5_kvahazmatknifeonearm_sp" )
        {
            var_2 = self.one_frac;
            self.one_ammo = self getammocount( self.one_weap );
            self.one_frac = self.one_ammo / weaponclipsize( self.one_weap );

            if ( self.one_ammo <= 0 && !isdefined( self.switch_to_melee ) )
            {
                if ( issubstr( self.one_weap, "titan45" ) )
                    soundscripts\_snd::snd_message( "aud_cap_45_onearm_toss" );
                else
                    soundscripts\_snd::snd_message( "aud_cap_sml_onearm_toss" );

                thread one_handed_switch_to_melee();
                continue;
            }

            if ( var_2 > 0.33 && self.one_frac <= 0.33 )
                self.one_time = var_1 + randomintrange( 500, 2000 );

            if ( !isdefined( level.one_handed_help ) )
                continue;

            if ( self.one_frac <= 0.33 && var_1 > self.one_time )
                thread one_handed_help_try( var_1 );

            continue;
        }

        if ( isdefined( level.one_handed_help ) && self.one_weap != "none" && var_1 > self.one_time )
            thread one_handed_help_try( gettime(), 4000 );
    }
}

one_handed_swap_tracking()
{
    self endon( "death" );
    self notify( "stop_one_handed_swap_tracking" );
    self endon( "stop_one_handed_swap_tracking" );

    if ( !isdefined( level.swap_num ) )
        level.swap_num = 0;

    for (;;)
    {
        self waittill( "one_handed_weapon_swap", var_0 );

        if ( isdefined( var_0 ) )
            level.swap_num += var_0;
        else
            level.swap_num += 1;

        if ( level.swap_num >= 20 )
        {
            maps\_utility::giveachievement_wrapper( "LEVEL_14A" );
            self notify( "stop_one_handed_swap_tracking" );
        }
    }
}

one_handed_mantle_handling()
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );
    self notify( "stop_one_handed_mantle_handling" );
    self endon( "stop_one_handed_mantle_handling" );

    for (;;)
    {
        self waittill( "foley", var_0 );
        var_1 = self getcurrentweapon();

        if ( issubstr( var_0, "mantle" ) && isdefined( self.switch_to_melee ) && !issubstr( var_1, "knife" ) )
            self takeweapon( self getcurrentweapon() );
    }
}

one_handed_exododge_handling()
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );
    self notify( "stop_one_handed_exododge_handling" );
    self endon( "stop_one_handed_exododge_handling" );

    for (;;)
    {
        self waittill( "exo_dodge" );
        var_0 = self getcurrentweapon();

        if ( isdefined( self.switch_to_melee ) && !issubstr( var_0, "knife" ) )
            self takeweapon( self getcurrentweapon() );
    }
}

one_handed_modify_threatbias( var_0 )
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );

    if ( isstring( var_0 ) )
    {
        var_0 = tolower( var_0 );

        switch ( var_0 )
        {
            case "stand":
                self.threat_stance = "stand";
                var_0 = -128;
                break;
            case "crouch":
                self.threat_stance = "crouch";
                var_0 = -512;
                break;
            case "prone":
                self.threat_stance = "prone";
                var_0 = -1024;
                break;
            case "none":
                self.threat_stance = "none";
                var_0 = 0;
                break;
            case "standard":
                var_0 = int( 1024 );
                break;
            case "aggro":
                var_0 = 2048;
                break;
            default:
                var_0 = 0;
                break;
        }
    }

    self.melee_threat = -1024 + var_0;
    self.gun_threat = -512 + var_0;

    if ( self.one_weap != "none" && self.one_weap != "iw5_kvahazmatknifeonearm_sp" )
        setthreatbias( "axis", "player", self.gun_threat );
    else
        setthreatbias( "axis", "player", self.melee_threat );
}

one_handed_weapon_check_swap( var_0, var_1 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) && ( !issubstr( var_0, "onearm_sp" ) || var_0 != self.one_weap ) )
    {
        var_2 = self getweaponammoclip( var_0 );

        if ( !isdefined( var_1 ) || var_1 )
            self takeweapon( self getcurrentweapon() );

        var_3 = "iw5_titan45onearm_sp_xmags";

        if ( issubstr( tolower( var_0 ), "pbw" ) )
            var_3 = "iw5_pbwonearm_sp_xmags";
        else if ( issubstr( tolower( var_0 ), "hmr9" ) )
            var_3 = "iw5_hmr9onearm_sp_xmags";
        else if ( issubstr( tolower( var_0 ), "sn6" ) )
            var_3 = "iw5_sn6onearm_sp_xmags";

        if ( var_2 <= 0 )
            var_2 = weaponclipsize( var_3 );

        if ( !isdefined( var_1 ) || var_1 )
        {
            setthreatbias( "axis", "player", self.gun_threat );
            self notify( "stop_switch_to_melee" );
            self.switch_to_melee = undefined;
            self giveweapon( var_3 );
            soundscripts\_snd::snd_message( "aud_onearm_weapon_swap", var_3 );
            self switchtoweapon( var_3 );
            self setweaponammostock( var_3, 0 );
            self setweaponammoclip( var_3, var_2 );
            self enablealternatemelee();
        }

        return var_3;
    }

    if ( !isdefined( var_1 ) || var_1 )
    {
        setthreatbias( "axis", "player", self.gun_threat );
        self notify( "stop_switch_to_melee" );
        self.switch_to_melee = undefined;
        self setweaponammostock( var_0, 0 );
    }

    return var_0;
}

one_handed_get_base_weapon( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        var_0 = self getcurrentweapon();

    var_0 = tolower( var_0 );
    var_3 = var_2;

    if ( issubstr( var_0, "titan45" ) )
        var_3 = "iw5_titan45pickup_sp_xmags";
    else if ( issubstr( var_0, "hmr9" ) )
        var_3 = "iw5_hmr9pickup_sp_xmags";
    else if ( issubstr( var_0, "sn6" ) )
        var_3 = "iw5_sn6pickup_sp_xmags";
    else if ( issubstr( var_0, "knife" ) && ( !isdefined( var_1 ) || !var_1 ) )
        var_3 = "iw5_kvahazmatknife_sp";

    return var_3;
}

one_handed_switch_to_melee( var_0 )
{
    self endon( "death" );
    self endon( "stop_switch_to_melee" );
    self notify( "start_one_handed_switch_to_melee" );
    self endon( "start_one_handed_switch_to_melee" );

    if ( isdefined( var_0 ) && !var_0 )
        var_0 = undefined;

    self notify( "bullet_weapon_dropped" );
    setthreatbias( "axis", "player", self.melee_threat );
    self giveweapon( "iw5_kvahazmatknifeonearm_sp" );
    self switchtoweapon( "iw5_kvahazmatknifeonearm_sp" );
    self.switch_to_melee = 1;

    while ( !isdefined( var_0 ) && !issubstr( self getcurrentweapon(), "knife" ) )
        wait 0.05;

    self.switch_to_melee = undefined;
    var_1 = self getweaponslistall();

    foreach ( var_3 in var_1 )
    {
        if ( var_3 != "iw5_kvahazmatknifeonearm_sp" && var_3 != "iw5_mahem_sp" && var_3 != "flash_grenade" )
            self takeweapon( var_3 );
    }
}

one_handed_melee_take_weapon( var_0 )
{
    self endon( "death" );
    self notify( "stop_switch_to_melee" );
    wait 0.5;
    var_1 = one_handed_weapon_check_swap( var_0, 0 );
    setthreatbias( "axis", "player", self.gun_threat );
    self.switch_to_melee = undefined;
    self takeweapon( "iw5_kvahazmatknifeonearm_sp" );
    self giveweapon( var_1 );
    self switchtoweapon( var_1 );
    self setweaponammostock( var_1, 0 );
    self setweaponammoclip( var_1, int( randomfloatrange( 0.5, 1 ) * weaponclipsize( var_1 ) ) );
    self notify( "one_handed_weapon_swap", 1.0 );
}

one_handed_help_try( var_0, var_1 )
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );

    if ( !common_scripts\utility::flag( "flag_one_handed_help_try" ) )
        common_scripts\utility::flag_set( "flag_one_handed_help_try" );
    else
        return 0;

    if ( !isdefined( var_0 ) )
        var_0 = gettime();

    if ( !isdefined( var_1 ) )
        var_1 = 6000;

    if ( var_0 > self.ot["gun"] && common_scripts\utility::cointoss() && level.ally one_handed_help_gun() )
    {
        self.one_time = var_0 + var_1;
        self.ot["gun"] = var_0 + 10000;
        common_scripts\utility::flag_clear( "flag_one_handed_help_try" );
        return 1;
    }

    if ( var_0 > self.ot["aggro"] && common_scripts\utility::cointoss() && level.ally one_handed_help_aggro() )
    {
        self.one_time = var_0 + var_1;
        self.ot["aggro"] = var_0 + 12000;
        common_scripts\utility::flag_clear( "flag_one_handed_help_try" );
        return 1;
    }

    if ( var_0 > self.ot["flash"] && common_scripts\utility::cointoss() && level.ally one_handed_help_flash() )
    {
        self.one_time = var_0 + var_1;
        self.ot["flash"] = var_0 + 20000;
        common_scripts\utility::flag_clear( "flag_one_handed_help_try" );
        return 1;
    }

    if ( var_0 > self.ot["gen"] && common_scripts\utility::cointoss() && level.ally one_handed_help_gen() )
    {
        self.one_time = var_0 + var_1 / 2;
        self.ot["gen"] = var_0 + 15000;
        common_scripts\utility::flag_clear( "flag_one_handed_help_try" );
        return 1;
    }

    common_scripts\utility::flag_clear( "flag_one_handed_help_try" );
    return 0;
}

one_handed_help_flash_ally_tracker( var_0 )
{
    self endon( "death" );
    self endon( "stop_one_handed_gunplay" );
    self notify( "start_one_handed_help_flash_ally_tracker" );
    self endon( "start_one_handed_help_flash_ally_tracker" );
    self.ot["ally_seen"] = gettime();
    self.ot["vis_delay"] = var_0;

    for (;;)
    {
        wait 0.1;
        var_1 = gettime();
        var_2 = self.ot["flash"] - self.ot["vis_delay"];

        if ( var_2 > var_1 )
        {
            wait(( var_2 - var_1 ) / 1000.0);
            continue;
        }

        if ( isdefined( level.ally ) )
        {
            if ( maps\_utility::player_can_see_ai( level.ally ) )
                self.ot["ally_seen"] = var_1;
        }
    }
}

one_handed_help_gun()
{
    self endon( "death" );
    var_0 = [];

    foreach ( var_2 in getweaponarray() )
    {
        if ( !isdefined( var_2.low_ammo ) )
            var_0[var_0.size] = var_2;
    }

    var_4 = common_scripts\utility::getclosest( level.player.origin, var_0, 128 );

    if ( isdefined( var_4 ) && level.player get_player_speed() < 24 )
    {
        var_5 = weaponclass( getsubstr( var_4.classname, 7 ) );
        var_6 = level.player get_relative_direction( var_4 );
        var_7 = randomint( level.one_vo[var_5][var_6].size );
        maps\_utility::smart_dialogue( level.one_vo[var_5][var_6][var_7] );
        return 1;
    }

    var_4 = common_scripts\utility::getclosest( self.origin, var_0, 128 );

    if ( isdefined( var_4 ) && self.a.state != "move" && maps\_utility::player_can_see_ai( self ) )
    {
        var_5 = weaponclass( getsubstr( var_4.classname, 7 ) );
        var_7 = randomint( level.one_vo[var_5]["ally"].size );
        maps\_utility::smart_dialogue( level.one_vo[var_5]["ally"][var_7] );
        return 1;
    }

    return 0;
}

one_handed_help_gen()
{
    self endon( "death" );

    if ( !maps\_utility::player_can_see_ai( self ) && randomint( 10 ) < 7 )
        return 0;

    var_0 = [];

    if ( level.player.one_weap != "none" && level.player.one_weap != "iw5_kvahazmatknifeonearm_sp" )
        var_0 = [ "cap_gdn_goodonammo", "cap_gdn_goodonammo", "cap_gdn_checkyourammo", "cap_gdn_checkyourammo", "cap_gdn_checkyourammo" ];

    if ( distancesquared( level.ally.origin, level.player.origin ) < 65536 )
        var_0 = [ "cap_gdn_hangintheremitchell", "cap_gdn_weregonnamakeit" ];

    if ( self cansee( level.player ) && level.player.one_weap == "iw5_kvahazmatknifeonearm_sp" )
        var_0 = common_scripts\utility::array_combine( var_0, [ "cap_gdn_youreouttimeto" ] );

    if ( var_0.size > 0 )
    {
        level.ally maps\_utility::smart_dialogue( common_scripts\utility::random( var_0 ) );
        return 1;
    }

    return 0;
}

one_handed_help_flash()
{
    if ( animscripts\combat::waitforstancechange() )
        return 0;

    var_0 = common_scripts\utility::get_array_of_closest( level.player.origin, getaiarray( "axis" ), undefined, undefined, 1024, 192 );

    if ( self.grenadeammo < 1 )
        maps\_utility::set_grenadeammo( 100 );

    var_1 = undefined;

    if ( !isdefined( self.a ) || !isdefined( self.a.array ) )
        return 0;
    else if ( isdefined( self.a.array["grenade_exposed"] ) )
        var_1 = self.a.array["grenade_exposed"];
    else if ( isdefined( self.a.array["exposed_grenade"] ) )
        var_1 = self.a.array["exposed_grenade"];
    else
        return 0;

    if ( isarray( var_1 ) )
        var_1 = var_1[randomint( var_1.size )];

    var_2 = animscripts\combat_utility::getgrenadethrowoffset( var_1 );

    if ( level.player.ot["ally_seen"] + level.player.ot["vis_delay"] > gettime() )
        return 0;

    var_3 = undefined;
    self.script_forcegrenade = 1;

    foreach ( var_5 in var_0 )
    {
        if ( self cansee( var_5 ) )
            var_3 = self magicgrenade( self.origin + var_2, var_5 getshootatpos(), 2 );

        if ( isdefined( var_3 ) )
            break;
    }

    self.script_forcegrenade = 0;

    if ( self.grenadeammo > 10 )
        maps\_utility::set_grenadeammo( 0 );

    if ( !isdefined( var_3 ) )
        return 0;

    thread animscripts\door::teamflashbangimmune();
    thread maps\_utility::smart_dialogue( common_scripts\utility::random( [ "cap_gdn_flashouttakecover", "cap_gdn_throwingflash" ] ) );
    return 1;
}

getappropanim( var_0 )
{

}

ally_one_handed_grenade_proc()
{
    level.player endon( "stop_one_handed_gunplay" );
    self endon( "death" );
    self notify( "stop_ally_grenade_help" );
    self endon( "stop_ally_grenade_help" );

    for (;;)
    {
        level.player common_scripts\utility::waittill_notify_or_timeout( "bullet_weapon_dropped", randomfloat( 1.0 ) );

        if ( getthreatbias( "axis", "player" ) > -1024 )
            continue;

        var_0 = common_scripts\utility::get_array_of_closest( level.player.origin, getaiarray( "axis" ), undefined, undefined, 1024, 192 );

        if ( self.grenadeammo < 1 )
            maps\_utility::set_grenadeammo( 1 );

        var_1 = undefined;

        if ( isdefined( self.a.array["grenade_exposed"] ) )
            var_1 = self.a.array["grenade_exposed"];
        else if ( isdefined( self.a.array["exposed_grenade"] ) )
            var_1 = self.a.array["exposed_grenade"];

        if ( isdefined( var_1 ) && isarray( var_1 ) )
            var_1 = var_1[randomint( var_1.size )];

        var_2 = animscripts\combat_utility::getgrenadethrowoffset( var_1 );
        var_3 = 0;
        self.script_forcegrenade = 1;

        foreach ( var_5 in var_0 )
        {
            animscripts\combat_utility::setactivegrenadetimer( var_5 );
            var_3 = animscripts\combat_utility::trygrenadethrow( var_5, var_5 getshootatpos(), var_1, var_2, 1, 0, 1 );

            if ( var_3 )
            {
                if ( self.grenadeweapon == "flash_grenade" )
                    self notify( "flashbang_thrown" );

                self.teamflashbangimmunity = 1;
                maps\_utility::anim_stopanimscripted();
                self notify( "move_interrupt" );
                self.update_move_anim_type = undefined;
                self.a.movement = "stop";
                common_scripts\utility::waittill_any( "done_grenade_throw", "killanimscript" );
                thread animscripts\move::restartmoveloop( 1 );
                maps\_utility::set_force_color( "r" );
                break;
            }
        }

        self.script_forcegrenade = 0;

        if ( var_3 )
        {
            wait(randomfloatrange( 8.0, 10.0 ));
            self.teamflashbangimmunity = undefined;
            continue;
        }

        wait 0.25;
    }
}

one_handed_help_aggro()
{
    self endon( "death" );
    var_0 = [];

    foreach ( var_2 in common_scripts\utility::get_array_of_closest( level.player.origin, getaiarray( "axis" ), undefined, undefined, 384 ) )
    {
        if ( isplayer( var_2.enemy ) )
            var_0[var_0.size] = var_2;
    }

    foreach ( var_2 in var_0 )
    {
        if ( self cansee( var_2 ) )
        {
            self.aggressivemode = 1;
            maps\_utility::set_favoriteenemy( var_2 );
            var_2 thread opfor_help_aggro();
            return 1;
        }
    }

    return 0;
}

opfor_help_aggro()
{
    self endon( "aggro_cleanup" );
    thread opfor_help_aggro_cleanup( 5 );
    self.aggro_target = 1;
    self.health = 1;
    self waittill( "death", var_0 );
    level.ally.aggressivemode = undefined;

    if ( !isdefined( var_0 ) || isplayer( var_0 ) )
        return;

    wait(randomfloatrange( 0.25, 0.75 ));
    level.ally maps\_utility::smart_dialogue( common_scripts\utility::random( [ "cap_gdn_gotyourback", "cap_gdn_igotchamitchell", "cap_gdn_thankmelater" ] ) );
}

opfor_help_aggro_cleanup( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self.aggro_target = undefined;
    self.health = 100;
    level.player.ot["aggro"] = 0;
    level.ally.aggressivemode = undefined;
    level.ally maps\_utility::set_favoriteenemy( undefined );
    self notify( "aggro_cleanup" );
}

get_player_speed()
{
    self endon( "death" );
    var_0 = self getentityvelocity();
    return sqrt( squared( var_0[0] ) + squared( var_0[1] ) );
}

get_relative_direction( var_0 )
{
    var_1 = vectortoangles( vectornormalize( anglestoforward( animscripts\battlechatter::getrelativeangles( self ) ) ) );
    var_2 = vectortoangles( var_0.origin - self.origin );
    var_3 = int( var_1[1] - var_2[1] + 360 ) % 360;

    if ( var_3 > 315 || var_3 < 45 )
        return "twelve";

    if ( var_3 > 225 )
        return "nine";

    if ( var_3 > 135 )
        return "six";

    return "three";
}

one_handed_help_vo_setup()
{
    if ( isdefined( level.one_vo ) )
        return;

    var_0 = [];
    var_0["smg"] = [];
    var_0["pistol"] = [];
    var_0["pistol"]["twelve"] = [ "cap_gdn_pistolatyour12", "cap_gdn_weaponatyour12" ];
    var_0["pistol"]["nine"] = [ "cap_gdn_pistolatyour9", "cap_gdn_weaponatyour9" ];
    var_0["pistol"]["six"] = [ "cap_gdn_pistolatyour6", "cap_gdn_weaponatyour6" ];
    var_0["pistol"]["three"] = [ "cap_gdn_pistolatyour3", "cap_gdn_weaponatyour3" ];
    var_0["smg"]["twelve"] = [ "cap_gdn_smgatyour12", "cap_gdn_weaponatyour12" ];
    var_0["smg"]["nine"] = [ "cap_gdn_smgatyour9", "cap_gdn_weaponatyour9" ];
    var_0["smg"]["six"] = [ "cap_gdn_smgatyour6", "cap_gdn_weaponatyour6" ];
    var_0["smg"]["three"] = [ "cap_gdn_smgatyour3", "cap_gdn_weaponatyour3" ];
    var_0["pistol"]["ally"] = [ "cap_gdn_foundapistol", "cap_gdn_pistolhere", "cap_gdn_weaponsoverhere", "cap_gdn_extragunsheremitchell" ];
    var_0["smg"]["ally"] = [ "cap_gdn_foundansmg", "cap_gdn_smghere", "cap_gdn_weaponsoverhere", "cap_gdn_extragunsheremitchell" ];
    level.one_vo = var_0;
}

opfor_death_mod()
{
    self endon( "stop_opfor_one_handed" );
    level.player endon( "stop_one_handed_gunplay" );
    self waittill( "death", var_0, var_1, var_2 );
    var_3 = self.enemy;

    if ( !isdefined( var_3 ) )
        var_3 = self;

    if ( isremovedentity( self ) )
        return;

    maps\_utility::place_weapon_on( one_handed_get_base_weapon( self.weapon, 1, "iw5_titan45onearmgundown_sp_xmags" ), "right" );

    if ( isplayer( var_0 ) && var_2 == "iw5_kvahazmatknifeonearm_sp" )
    {
        self notify( "opfor_melee_kill" );
        self.dropweapon = 0;
        level.player one_handed_melee_take_weapon( self.weapon );
    }

    if ( !isdefined( level.one_handed_help ) )
        return 0;

    wait(randomfloatrange( 0.25, 0.75 ));
    var_4 = gettime();

    if ( var_4 > level.player.ot["p_kill"] && isplayer( var_0 ) && var_3 == level.ally && common_scripts\utility::cointoss() )
    {
        level.player.ot["p_kill"] = var_4 + 15000;
        level.ally maps\_utility::smart_dialogue( common_scripts\utility::random( [ "cap_gdn_goodshot", "cap_gdn_thanksforthesave" ] ) );
    }
    else if ( var_4 > level.player.ot["a_kill"] && var_4 > level.player.one_time && isplayer( var_3 ) && var_0 == level.ally && common_scripts\utility::cointoss() )
    {
        level.player.ot["a_kill"] = var_4 + 15000;
        level.ally maps\_utility::smart_dialogue( common_scripts\utility::random( [ "cap_gdn_thankmelater", "cap_gdn_gotyourback", "cap_gdn_igotchamitchell" ] ) );
    }
}

opfor_ammo_drop_mod()
{
    self endon( "stop_opfor_one_handed" );
    level.player endon( "stop_one_handed_gunplay" );
    self endon( "opfor_melee_kill" );
    self waittill( "weapon_dropped", var_0 );
    wait 0.05;

    if ( !isdefined( var_0 ) )
        return;

    var_1 = getsubstr( var_0.classname, 7 );

    if ( isdefined( self.dropweapon ) && !self.dropweapon )
        var_0 delete();
    else if ( weaponclass( var_1 ) == "pistol" || weaponclass( var_1 ) == "smg" )
        var_0 itemweaponsetammo( int( randomfloatrange( 0.7, 1 ) * weaponclipsize( var_1 ) ), 0 );
    else
        var_0 delete();
}

door_setup( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isstring( var_0 ) )
        var_3 = getent( var_0, "targetname" );
    else
        var_3 = var_0;

    if ( var_3.classname != "script_model" && var_3.classname != "script_brushmodel" )
    {

    }

    var_4 = undefined;

    if ( isdefined( var_3.target ) )
    {
        var_5 = getentarray( var_3.target, "targetname" );

        foreach ( var_7 in var_5 )
        {
            if ( var_7.classname == "script_brushmodel" )
            {
                var_4 = var_7;
                continue;
            }

            if ( var_7.classname == "script_origin" )
            {
                if ( !isdefined( var_2 ) )
                {
                    var_3.hinge = var_7;
                    var_3.hinge.tag_name = var_2;
                    var_3 linkto( var_3.hinge );
                }
            }
        }
    }

    if ( isdefined( var_2 ) )
    {
        var_3.hinge = common_scripts\utility::spawn_tag_origin();
        var_3.hinge.origin = var_3 gettagorigin( var_2 );
        var_3.hinge.angles = var_3 gettagangles( var_2 );

        if ( !isdefined( var_1 ) )
            var_3 linkto( var_3.hinge );
    }

    if ( isdefined( var_4 ) )
    {
        var_3.col_brush = var_4;

        if ( isdefined( var_2 ) )
            var_3.col_brush linkto( var_3, var_2 );
        else
            var_3.col_brush linkto( var_3 );
    }
    else if ( var_3.classname == "script_brushmodel" )
        var_3.col_brush = var_3;

    var_3.original_angles = var_3.angles;

    if ( isdefined( var_1 ) )
        var_3 maps\_utility::assign_animtree( var_1 );

    return var_3;
}

door_close( var_0, var_1, var_2 )
{
    var_3 = self;

    if ( isdefined( self._lastanimtime ) )
    {
        self._lastanimtime = undefined;
        self stopuseanimtree();
    }

    var_4 = undefined;

    if ( isdefined( var_3.hinge ) )
    {
        if ( !var_3 islinked() )
            var_3 linkto( var_3.hinge );

        var_4 = var_3.hinge;
    }
    else
        var_4 = var_3;

    var_5 = 0.05;

    if ( isdefined( var_1 ) )
        var_5 = var_1;

    if ( isdefined( var_0 ) )
        var_4 rotateyaw( var_0, var_5 );
    else
        var_4 rotateto( var_3.original_angles, var_5 );

    if ( isdefined( var_2 ) )
        wait(var_2);
    else
        wait(var_5);

    if ( isdefined( var_3.col_brush ) )
        var_3.col_brush disconnectpaths();
}

door_open( var_0, var_1, var_2 )
{
    var_3 = self;

    if ( isdefined( self._lastanimtime ) )
    {
        self._lastanimtime = undefined;
        self stopuseanimtree();
    }

    var_4 = undefined;

    if ( isdefined( var_3.hinge ) )
    {
        if ( !var_3 islinked() )
            var_3 linkto( var_3.hinge );

        var_4 = var_3.hinge;
    }
    else
        var_4 = var_3;

    var_5 = undefined;
    var_6 = undefined;

    if ( isarray( var_0 ) )
    {
        var_5 = var_0[0];
        var_6 = var_0[1];
    }
    else
        var_5 = var_0;

    var_7 = 0.05;

    if ( isdefined( var_1 ) )
        var_7 = var_1;

    var_4 rotateyaw( var_5, var_7 );

    if ( isdefined( var_2 ) )
        wait(var_2);
    else
        wait(var_7);

    if ( isdefined( var_3.col_brush ) )
        var_3.col_brush connectpaths();

    if ( isdefined( var_2 ) && var_2 < var_7 )
        wait(var_7 - var_2);

    wait 0.05;

    if ( isdefined( var_6 ) )
        var_4 rotateyaw( var_6, 2.5, 0.05, 2.45 );
}

door_lower( var_0, var_1, var_2 )
{
    self moveto( var_0, var_1 );

    if ( isdefined( var_2 ) )
        wait(var_2);
    else
        wait(var_1);

    self.col_brush disconnectpaths();
}

door_raise( var_0, var_1, var_2 )
{
    self moveto( var_0, var_1 );

    if ( isdefined( var_2 ) )
        wait(var_2);
    else
        wait(var_1);

    self.col_brush connectpaths();
}

captured_caravan_spawner( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "stop_caravan_spawner" );

    if ( level.currentgen )
    {
        if ( isdefined( var_4 ) )
        {
            var_5 = tff_get_zone_cleanup_notify( var_4 );

            if ( var_5 != "" )
                level endon( var_5 );
        }
    }

    var_6 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 2.0;

    if ( !isdefined( var_3 ) )
        var_3 = 3.0;

    for (;;)
    {
        var_7 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );

        if ( level.currentgen )
        {
            if ( isdefined( var_4 ) )
                var_7 thread tff_cleanup_vehicle( var_4 );
        }

        var_7 thread captured_caravan_truck_remover();
        wait(randomfloatrange( var_2, var_3 ));

        if ( var_0 == "intro_drive_trucks" )
            thread soundscripts\_snd::snd_message( "aud_intro_caravan_passby" );

        if ( isdefined( var_1 ) )
        {
            if ( var_6 >= var_1 )
                break;

            var_6 += 1;
        }
    }
}

captured_caravan_truck_remover( var_0 )
{
    self waittill( "reached_end_node" );
    self delete();
}

debug_show_pos( var_0, var_1, var_2, var_3 )
{
    self notify( "stop_debug_show_pos" );
    self endon( "stop_debug_show_pos" );
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = 8;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    for (;;)
    {
        self notify( "stop_circle" );
        maps\_utility::draw_circle_until_notify( self.origin, var_0, var_1, var_2, var_3, self, "stop_circle" );
        wait 0.05;
    }
}

debug_text( var_0, var_1 )
{
    self notify( "stop_debug_show_pos" );
    self endon( "stop_debug_show_pos" );
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = ( 1, 1, 1 );

    if ( isdefined( var_1 ) )
        thread maps\_utility::notify_delay( "stop_debug_show_pos", var_1 );

    for (;;)
        wait 0.05;
}

debug_show_pos_once( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 8;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    maps\_utility::draw_circle_until_notify( var_0, var_1, var_2, var_3, var_4, level, var_5 );
    wait 0.05;
}

debug_show_vec( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_2 ) )
        var_2 = ( 1, 0, 0 );

    if ( !isdefined( var_3 ) )
        var_7 = 100;

    if ( isdefined( var_4 ) )
        thread maps\_debug::print3ddraw( var_0, var_4, var_2, var_5, var_6 );

    thread maps\_debug::drawarrow( var_0, var_1, var_2, var_3 );
    wait(0.05 * var_3);
    self notify( "stop_print3ddraw" );
}

mission_timer()
{
    if ( !getdvarint( "timer_enabled" ) )
        return;

    var_0 = 1;
    level.time_array = [];
    level.location_array = [];
    level.display_array = [];
    level.time_display_array = [];
    var_1 = mission_timer_hud_creator( 10, 420 );
    var_1 settimerstatic( var_0 );

    for (;;)
    {
        var_2 = level.location_array.size;

        for (;;)
        {
            wait 1.0;
            var_1 settimerstatic( var_0 );

            if ( var_2 != level.location_array.size )
            {
                level.time_array[level.time_array.size] = var_0;
                var_0 += 1;
                break;
            }

            var_0 += 1;
        }

        if ( level.location_array[level.location_array.size - 1] == "end" )
            break;
    }

    level notify( "new_event_message" );
    var_3 = mission_timer_hud_creator( 380, 30 );
    var_3 settext( "Event Timings" );
    var_4 = 0;

    foreach ( var_6 in level.display_array )
    {
        var_6 settext( level.location_array[var_4] + " " + "=" );
        var_4 += 1;
    }

    var_4 = 0;

    foreach ( var_9 in level.time_display_array )
    {
        var_9 settimerstatic( level.time_array[var_4] );
        var_4 += 1;
    }
}

mission_timer_event( var_0 )
{
    if ( !getdvarint( "timer_enabled" ) )
        return;

    level.location_array[level.location_array.size] = var_0;
    var_1 = level.location_array.size;
    var_2 = var_1 * 20;
    var_2 += 50;

    while ( level.time_array.size != level.location_array.size )
        wait 0.05;

    var_3 = mission_timer_hud_creator( 300, var_2 );
    level.display_array[level.display_array.size] = var_3;
    var_3 = mission_timer_hud_creator( 400, var_2 );
    level.time_display_array[level.time_display_array.size] = var_3;
}

mission_timer_hud_creator( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = var_0;
    var_2.y = var_1;
    var_2.sort = 0;
    var_2.alignx = "right";
    var_2.aligny = "middle";
    var_2.fontscale = 2;
    var_2.font = "objective";
    var_2.color = ( 1, 1, 1 );
    return var_2;
}

waittill_entity_activate_looking_at( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = 0.5;

    if ( isdefined( var_4 ) )
        var_10 = var_4;

    var_11 = 64;

    if ( isdefined( var_3 ) )
        var_11 = var_3;

    if ( !isdefined( var_5 ) )
        var_5 = 1;
    else
        var_5 = 0;

    var_12 = var_0;

    if ( isdefined( var_6 ) )
    {
        var_12 = var_0 common_scripts\utility::spawn_tag_origin();
        var_12 linkto( var_0, var_6, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }

    if ( !isdefined( var_7 ) )
        var_7 = 5;

    if ( isdefined( var_2 ) )
        var_13 = var_2;
    else
        var_13 = "flag_waittill_entity_activate_looking_at";

    if ( !common_scripts\utility::flag_exist( var_13 ) )
        common_scripts\utility::flag_init( var_13 );

    var_14 = 0;
    var_15 = 0;

    for (;;)
    {
        if ( isdefined( var_9 ) )
            common_scripts\utility::flag_wait( var_9 );

        if ( isdefined( var_1 ) && var_1 != "melee" && level.player meleebuttonpressed() || level.player isthrowinggrenade() || !level.player isonground() || level.player getstance() == "prone" )
        {
            common_scripts\utility::flag_clear( var_13 );
            var_15 = 0;
            level.player enableweaponpickup();
        }
        else if ( level.player maps\_utility::player_looking_at( var_12.origin, var_10, 1 ) )
        {
            var_16 = undefined;

            if ( var_5 )
                var_16 = level.player geteye();
            else
                var_16 = level.player.origin;

            if ( isdefined( var_8 ) )
            {
                if ( common_scripts\utility::flag( var_8 ) )
                {
                    if ( !common_scripts\utility::flag( var_13 ) )
                        var_14 = 1;
                }
                else
                {
                    common_scripts\utility::flag_clear( var_13 );
                    var_15 = 0;
                    level.player enableweaponpickup();
                }
            }
            else if ( distance( var_16, var_12.origin ) <= var_11 )
            {
                if ( !common_scripts\utility::flag( var_13 ) )
                    var_14 = 1;
            }
            else
            {
                common_scripts\utility::flag_clear( var_13 );
                var_15 = 0;
                level.player enableweaponpickup();
            }
        }
        else
        {
            common_scripts\utility::flag_clear( var_13 );
            var_15 = 0;
            level.player enableweaponpickup();
        }

        if ( isdefined( var_1 ) )
        {
            if ( var_1 == "melee" && level.player meleebuttonpressed() )
                var_15++;
        }
        else if ( level.player usebuttonpressed() )
            var_15++;

        if ( common_scripts\utility::flag( var_13 ) && var_15 >= var_7 )
            break;

        if ( var_14 )
        {
            common_scripts\utility::flag_set( var_13 );

            if ( isdefined( var_2 ) )
                maps\_utility::display_hint_timeout( var_2 );

            var_14 = 0;
            level.player disableweaponpickup();
        }

        wait 0.05;
    }

    level.player enableweaponpickup();
    common_scripts\utility::flag_clear( var_13 );

    if ( isdefined( var_6 ) )
        var_12 delete();
}

ignore_everything()
{
    if ( isdefined( self.script_drone ) )
        return;

    if ( isdefined( self._ignore_settings_old ) )
        unignore_everything();

    self._ignore_settings_old = [];
    self.disableplayeradsloscheck = save_ignore_setting( self.disableplayeradsloscheck, "disableplayeradsloscheck", 1 );
    self.ignoreall = save_ignore_setting( self.ignoreall, "ignoreall", 1 );
    self.ignoreme = save_ignore_setting( self.ignoreme, "ignoreme", 1 );
    self.grenadeawareness = save_ignore_setting( self.grenadeawareness, "grenadeawareness", 0 );
    self.ignoreexplosionevents = save_ignore_setting( self.ignoreexplosionevents, "ignoreexplosionevents", 1 );
    self.ignorerandombulletdamage = save_ignore_setting( self.ignorerandombulletdamage, "ignorerandombulletdamage", 1 );
    self.ignoresuppression = save_ignore_setting( self.ignoresuppression, "ignoresuppression", 1 );
    self.dontavoidplayer = save_ignore_setting( self.dontavoidplayer, "dontavoidplayer", 1 );
    self.newenemyreactiondistsq = save_ignore_setting( self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0 );
    self.disablebulletwhizbyreaction = save_ignore_setting( self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", 1 );
    self.disablefriendlyfirereaction = save_ignore_setting( self.disablefriendlyfirereaction, "disableFriendlyFireReaction", 1 );
    self.dontmelee = save_ignore_setting( self.dontmelee, "dontMelee", 1 );
    self.flashbangimmunity = save_ignore_setting( self.flashbangimmunity, "flashBangImmunity", 1 );
    self.dodangerreact = save_ignore_setting( self.dodangerreact, "doDangerReact", 0 );
    self.neversprintforvariation = save_ignore_setting( self.neversprintforvariation, "neverSprintForVariation", 1 );
    self.a.disablepain = save_ignore_setting( self.a.disablepain, "a.disablePain", 1 );
    self.allowpain = save_ignore_setting( self.allowpain, "allowPain", 0 );
    self.ignoresonicaoe = save_ignore_setting( self.ignoresonicaoe, "IgnoreSonicAoE", 1 );
    self pushplayer( 1 );
}

save_ignore_setting( var_0, var_1, var_2 )
{
    if ( isdefined( var_0 ) )
        self._ignore_settings_old[var_1] = var_0;
    else
        self._ignore_settings_old[var_1] = "none";

    return var_2;
}

unignore_everything( var_0 )
{
    if ( isremovedentity( self ) )
        return;

    if ( isdefined( self.script_drone ) )
        return;

    if ( isdefined( var_0 ) && var_0 )
    {
        if ( isdefined( self._ignore_settings_old ) )
            self._ignore_settings_old = undefined;
    }

    self.disableplayeradsloscheck = restore_ignore_setting( "disableplayeradsloscheck", 0 );
    self.ignoreall = restore_ignore_setting( "ignoreall", 0 );
    self.ignoreme = restore_ignore_setting( "ignoreme", 0 );
    self.grenadeawareness = restore_ignore_setting( "grenadeawareness", 1 );
    self.ignoreexplosionevents = restore_ignore_setting( "ignoreexplosionevents", 0 );
    self.ignorerandombulletdamage = restore_ignore_setting( "ignorerandombulletdamage", 0 );
    self.ignoresuppression = restore_ignore_setting( "ignoresuppression", 0 );
    self.dontavoidplayer = restore_ignore_setting( "dontavoidplayer", 0 );
    self.newenemyreactiondistsq = restore_ignore_setting( "newEnemyReactionDistSq", 262144 );
    self.disablebulletwhizbyreaction = restore_ignore_setting( "disableBulletWhizbyReaction", undefined );
    self.disablefriendlyfirereaction = restore_ignore_setting( "disableFriendlyFireReaction", undefined );
    self.dontmelee = restore_ignore_setting( "dontMelee", undefined );
    self.flashbangimmunity = restore_ignore_setting( "flashBangImmunity", undefined );
    self.dodangerreact = restore_ignore_setting( "doDangerReact", 1 );
    self.neversprintforvariation = restore_ignore_setting( "neverSprintForVariation", undefined );
    self.a.disablepain = restore_ignore_setting( "a.disablePain", 0 );
    self.allowpain = restore_ignore_setting( "allowPain", 1 );
    self._ignore_settings_old = undefined;
}

restore_ignore_setting( var_0, var_1 )
{
    if ( isdefined( self._ignore_settings_old ) )
    {
        if ( isstring( self._ignore_settings_old[var_0] ) && self._ignore_settings_old[var_0] == "none" )
            return var_1;
        else
            return self._ignore_settings_old[var_0];
    }

    return var_1;
}

cap_civilian_damage_proc( var_0 )
{
    level endon( "start_autopsy_enter" );
    level.captured_mission_failed = "";
    self.no_friendly_fire_penalty = 1;

    if ( isdefined( var_0 ) )
        self.health = var_0;
    else
        self.health = 300;

    for (;;)
    {
        self waittill( "damage", var_1, var_2 );

        if ( isplayer( var_2 ) )
        {
            if ( self.health - var_1 <= 0 )
            {
                if ( level.captured_mission_failed != "true" )
                {
                    level.captured_mission_failed = "true";

                    if ( !level.missionfailed )
                    {
                        setdvar( "ui_deadquote", &"CAPTURED_FAIL_UNARMED" );
                        maps\_utility::missionfailedwrapper();
                    }
                }
            }

            continue;
        }

        self kill( var_2 geteye(), var_2 );
    }
}

kill_no_react()
{
    if ( !isalive( self ) )
        return;

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    self.allowdeath = 1;
    self.a.nodeath = 1;
    maps\_utility::set_battlechatter( 0 );
    self kill();
}

start_point_is_after( var_0, var_1 )
{
    return start_point_check( "after", var_0, var_1 );
}

start_point_is_before( var_0, var_1 )
{
    return start_point_check( "before", var_0, var_1 );
}

start_point_is_between( var_0, var_1 )
{
    return start_point_check( "between", var_0, var_1 );
}

start_point_check( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = [];

    if ( !isarray( var_1 ) )
        var_4[0] = var_1;
    else
        var_4 = var_1;

    var_5 = var_4.size;

    for ( var_6 = 0; var_6 < var_4.size; var_6++ )
        var_4[var_6] = tolower( var_4[var_6] );

    var_7 = getarraykeys( level.start_arrays );
    var_8 = [];

    for ( var_6 = 0; var_6 < var_7.size; var_6++ )
    {
        for ( var_9 = 0; var_9 < var_4.size; var_9++ )
        {
            if ( var_7[var_6] == var_4[var_9] )
            {
                var_8 = common_scripts\utility::array_add( var_8, var_6 );
                var_4 = maps\_utility::array_remove_index( var_4, var_9 );
                break;
            }
        }

        if ( var_7[var_6] == level.start_point )
            var_3 = var_6;
    }

    switch ( var_0 )
    {
        case "before":
            if ( isdefined( var_2 ) && var_2 && var_3 <= var_8[0] )
                return 1;
            else if ( var_3 < var_8[0] )
                return 1;

            break;
        case "between":
            if ( isdefined( var_2 ) && var_2 && var_3 >= var_8[0] && var_3 <= var_8[1] )
                return 1;
            else if ( var_3 > var_8[0] && var_3 < var_8[1] )
                return 1;

            break;
        case "after":
            if ( isdefined( var_2 ) && var_2 && var_3 >= var_8[0] )
                return 1;
            else if ( var_3 > var_8[0] )
                return 1;

            break;
    }

    return 0;
}

waittill_notify_func( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self waittill( var_0 );

    if ( isdefined( var_5 ) )
        self [[ var_1 ]]( var_2, var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        self [[ var_1 ]]( var_2, var_3, var_4 );
    else if ( isdefined( var_3 ) )
        self [[ var_1 ]]( var_2, var_3 );
    else if ( isdefined( var_2 ) )
        self [[ var_1 ]]( var_2 );
    else
        self [[ var_1 ]]();
}

waittill_notify_func_ent( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_0 waittill( var_1 );

    if ( isdefined( var_6 ) )
        self [[ var_2 ]]( var_3, var_4, var_5, var_6 );
    else if ( isdefined( var_5 ) )
        self [[ var_2 ]]( var_3, var_4, var_5 );
    else if ( isdefined( var_4 ) )
        self [[ var_2 ]]( var_3, var_4 );
    else if ( isdefined( var_3 ) )
        self [[ var_2 ]]( var_3 );
    else
        self [[ var_2 ]]();
}

ambient_fan_rotate()
{
    self rotatepitch( randomint( 360 ), 0.1 );

    for (;;)
    {
        self rotatepitch( 360, 3 );
        wait 3;
    }
}

physics_bodies_on( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstructarray( var_0, "script_noteworthy" );

    if ( isdefined( var_1 ) )
    {
        if ( var_1 > 0 )
            wait(var_1);
    }

    if ( !isdefined( level.hanging_bodies ) )
        level.hanging_bodies = [];

    if ( isdefined( var_2 ) )
        var_4 = [ "cap_hanging_bodybag_clean", "cap_hanging_bodybag_clean_b", "cap_hanging_bodybag_clean_c", "cap_hanging_bodybag_02_clean", "cap_hanging_bodybag_02_clean_b", "cap_hanging_bodybag_02_clean_c" ];
    else
        var_4 = [ "cap_hanging_bodybag", "cap_hanging_bodybag_02", "cap_hanging_bodybag_b", "cap_hanging_bodybag_c", "cap_hanging_bodybag_02_b", "cap_hanging_bodybag_02_c" ];

    foreach ( var_6 in var_3 )
    {
        var_7 = common_scripts\utility::random( var_4 );
        var_8 = spawn( "script_model", var_6.origin );
        var_8 setmodel( var_7 );
        var_8.angles = var_6.angles;
        level.hanging_bodies = common_scripts\utility::array_add( level.hanging_bodies, var_8 );
    }
}

physics_bodies_off()
{
    if ( isdefined( level.hanging_bodies ) )
    {
        var_0 = [];

        foreach ( var_2 in level.hanging_bodies )
        {
            var_2 physicsstop();
            var_2 delete();
            level.hanging_bodies = common_scripts\utility::array_remove( level.hanging_bodies, var_2 );
        }
    }
}

captured_hint_radius( var_0, var_1, var_2, var_3 )
{

}

tprintln( var_0, var_1 )
{
    if ( !isdefined( level.debugging_on ) )
        return 0;

    return 1;
}

jkuprint( var_0, var_1, var_2 )
{
    setdvarifuninitialized( "jkudebug", 0 );

    if ( !isdefined( var_1 ) )
        var_1 = "onscreen";

    if ( !isdefined( var_2 ) )
        var_2 = 100;

    if ( getdvarint( "jkudebug" ) == 1 )
    {
        switch ( var_1 )
        {
            case "onscreen":
                iprintln( var_0 );
                break;
            case "3d":
                if ( !isdefined( self.origin ) )
                    break;

                break;
            case "3dattached":
                thread jkuprint3dattached( var_0, var_2 );
                break;
            case "console":
                break;
            case "bold":
                iprintlnbold( var_0 );
                break;
            default:
                break;
        }
    }
}

jkuprint3dattached( var_0, var_1 )
{
    if ( !isdefined( self ) )
    {

    }

    self endon( "death" );
    self endon( "jkuprint_stop" );

    for ( var_2 = 0; var_2 < var_1; var_2++ )
        waitframe();
}

jkupoint( var_0, var_1, var_2 )
{
    setdvarifuninitialized( "jkudebug", 0 );

    if ( getdvarint( "jkudebug" ) == 1 )
    {
        if ( !isdefined( self.origin ) )
            return;
        else
            var_3 = self.origin;

        if ( !isdefined( var_0 ) )
            var_0 = 6;

        if ( !isdefined( var_1 ) )
            var_1 = ( 1, 1, 1 );

        if ( !isdefined( var_2 ) )
            var_2 = 400;
    }
}

jkuline( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    setdvarifuninitialized( "jkudebug", 0 );

    if ( getdvarint( "jkudebug" ) == 1 )
    {
        if ( !isdefined( var_2 ) )
            var_2 = ( 1, 1, 1 );

        if ( !isdefined( var_3 ) )
            var_3 = 1;

        if ( !isdefined( var_4 ) )
            var_4 = 0;

        if ( !isdefined( var_5 ) )
            var_5 = 200;

        if ( isdefined( var_6 ) )
        {
            if ( isdefined( var_7 ) )
            {
                var_8 = 40;
                var_1 = self.origin + anglestoforward( self.angles ) * var_8;
            }
            else
                var_8 = distance2d( var_0, var_1 );

            var_9 = var_8 * 0.2;
            var_10 = var_8 * 0.5;
            var_11 = var_8 * 0.175;
            var_12 = var_0 - var_1;
            var_13 = var_1 + anglestoforward( vectortoangles( var_12 ) ) * var_9;
            var_14 = var_1 + anglestoforward( vectortoangles( var_12 ) ) * var_10;
        }
        else
        {

        }
    }
}

tff_get_zone_cleanup_notify( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "intro_drive":
            var_1 = "tff_pre_intro_drive_to_s2walk";
            break;
        case "s2walk":
            var_1 = "tff_pre_s2walk_to_interrogate";
            break;
        case "helipad":
            var_1 = "tff_pre_helipad_to_mechbattle";
            break;
    }

    return var_1;
}

tff_cleanup_vehicle( var_0 )
{
    var_1 = tff_get_zone_cleanup_notify( var_0 );

    if ( var_1 == "" )
        return;

    level waittill( var_1 );

    if ( isarray( self ) )
    {
        foreach ( var_3 in self )
        {
            if ( !isdefined( var_3 ) )
                return;

            if ( isremovedentity( var_3 ) )
                return;

            if ( var_3 maps\_vehicle::isvehicle() )
                var_3 maps\_vehicle_code::_freevehicle();

            var_3 delete();
        }
    }
    else
    {
        if ( !isdefined( self ) )
            return;

        if ( isremovedentity( self ) )
            return;

        if ( maps\_vehicle::isvehicle() )
            maps\_vehicle_code::_freevehicle();

        self delete();
    }
}

captured_player_cuffs()
{
    var_0 = self;
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 setmodel( "s1_vm_handcuffs" );
    var_1 linkto( var_0, "tag_weapon_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    return var_1;
}

captured_worker_weapons()
{
    var_0 = self;
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "npc_titan45_nocamo" );
    var_1 linkto( var_0, "tag_stowed_hip_rear", ( -12, 10, -2 ), ( 30, 150, 0 ) );
    var_0.no_friendly_fire_penalty = 1;
    var_0 waittill( "death" );
    var_1 delete();
}
