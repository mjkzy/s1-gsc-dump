// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level.shark_functions ) )
    {
        if ( issubstr( self.model, "shark" ) )
        {
            self [[ level.shark_functions["combat"] ]]();
            return;
        }
    }

    self endon( "killanimscript" );

    if ( !isalive( self.enemy ) )
        combatidle();
    else
    {
        if ( isplayer( self.enemy ) )
        {
            meleebiteattackplayer();
            return;
        }

        meleestrugglevsai();
    }
}

end_script()
{
    self _meth_83FF();
    self.doglastknowngoodpos = undefined;
}

killplayer()
{
    self endon( "pvd_melee_interrupted" );

    if ( !isdefined( self.meleeingplayer.player_view ) )
        return;

    var_0 = self.meleeingplayer.player_view;

    if ( isdefined( var_0.player_killed ) )
        return;

    var_0.player_killed = 1;

    if ( maps\_utility::killing_will_down( self.meleeingplayer ) )
    {
        knock_down_player_coop( self.meleeingplayer, self );
        return;
    }

    self.meleeingplayer.specialdeath = 1;
    self.meleeingplayer _meth_82C0( 1 );

    if ( var_0 _meth_8442( "tag_torso" ) != -1 )
        playfxontag( level._effect["dog_bite_blood"], var_0, "tag_torso" );

    wait 1;

    if ( !isdefined( self ) || !isdefined( self.meleeingplayer ) )
        return;

    var_1 = is_hyena();
    self.meleeingplayer _meth_8132( 0 );

    if ( !isalive( self.meleeingplayer ) )
        return;

    self.meleeingplayer dog_player_kill( self );
    self.meleeingplayer shellshock( "default", 5 );
    waittillframeend;
    setdvar( "ui_deadquote", "" );
    thread dog_death_hud( self.meleeingplayer, var_1 );
}

#using_animtree("dog");

knock_down_player_coop( var_0, var_1 )
{
    var_0.dog_downed_player = 1;
    var_2 = dog_vs_player_anim_rate();
    self _meth_810D( "meleeanim", %german_shepherd_player_getoff, 1, 0.1, var_2 );
    var_0.player_view notify( "pvd_melee_interrupted" );
    var_0.player_view notify( "pvd_melee_done" );
    var_0.player_view playerview_endsequence( var_0 );

    if ( !maps\_utility::killing_will_down( var_0 ) )
        var_0 dog_player_kill( var_1 );
}

dog_player_kill( var_0 )
{
    if ( maps\_utility::laststand_enabled() )
        self _meth_80EC( 0 );

    self _meth_80F0();

    if ( isalive( var_0 ) )
        self _meth_8052( self.origin, var_0 );
    else
        self _meth_8052( self.origin );
}

dog_death_hud( var_0, var_1 )
{
    if ( maps\_utility::is_specialop() )
        return;

    wait 1.5;
    thread dog_deathquote( var_0 );
    var_2 = newclienthudelem( var_0 );
    var_2.x = 0;
    var_2.y = 50;

    if ( var_1 )
        var_2 _meth_80CC( "hud_hyena_melee", 96, 96 );
    else
        var_2 _meth_80CC( "hud_dog_melee", 96, 96 );

    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "center";
    var_2.vertalign = "middle";
    var_2.foreground = 1;
    var_2.alpha = 0;
    var_2 fadeovertime( 1 );
    var_2.alpha = 1;
}

dog_deathquote( var_0 )
{
    var_1 = var_0 maps\_hud_util::createclientfontstring( "default", 1.75 );
    var_1.color = ( 1, 1, 1 );
    var_1 settext( level.dog_death_quote );
    var_1.x = 0;
    var_1.y = -30;
    var_1.alignx = "center";
    var_1.aligny = "middle";
    var_1.horzalign = "center";
    var_1.vertalign = "middle";
    var_1.foreground = 1;
    var_1.alpha = 0;
    var_1 fadeovertime( 1 );
    var_1.alpha = 1;
}

attackmiss()
{
    self _meth_8142( %body, 0.1 );
    var_0 = %german_shepherd_attack_player_miss_b;

    if ( isdefined( self.enemy ) )
    {
        var_1 = anglestoforward( ( 0, self.desiredangle, 0 ) );
        var_2 = vectornormalize( self.enemy.origin - self.origin );
        var_3 = self.enemy.origin - self.origin + var_1 * 40;

        if ( vectordot( var_2, var_1 ) > 0.707 || vectordot( var_3, var_1 ) > 0 )
            thread animscripts\dog\dog_stop::lookattarget( "normal" );
        else
        {
            self.skipstartmove = 1;
            thread attackmisstracktargetthread();

            if ( var_2[0] * var_1[1] - var_2[1] * var_1[0] > 0 )
                var_0 = %german_shepherd_attack_player_miss_turnr;
            else
                var_0 = %german_shepherd_attack_player_miss_turnl;
        }
    }

    self _meth_8113( "miss_anim", var_0, 1, 0, 1 );
    var_4 = getanimlength( var_0 );
    soundscripts\_snd::snd_message( "anml_doberman", "attack_miss" );
    animscripts\notetracks::donotetracksfortime( var_4 - 0.1, "miss_anim" );
    self notify( "stop tracking" );
}

attackmisstracktargetthread()
{
    self endon( "killanimscript" );
    wait 0.6;
    self _meth_818F( "face enemy" );
}

knockoutofads( var_0 )
{
    var_0 endon( "death" );
    var_0 _meth_8300( 0 );
    wait 0.75;
    var_0 _meth_8300( 1 );
}

dogmelee()
{
    if ( isdefined( self.meleeingplayer ) )
    {
        if ( isdefined( self.meleeingplayer.using_uav ) && self.meleeingplayer.using_uav )
            self.meleeingplayer notify( "force_out_of_uav" );

        if ( self.meleeingplayer _meth_8068() )
            return undefined;

        if ( self.meleeingplayer ismantling() )
            return undefined;

        if ( self.meleeingplayer.laststand && self.meleeingplayer.ignoreme )
            return undefined;
    }

    if ( isdefined( self.enemy ) )
    {
        if ( distance2d( self.origin, self.enemy.origin ) < 32 )
            return self _meth_81E9();
    }

    return self _meth_81E9( anglestoforward( self.angles ) );
}

handlemeleebiteattacknotetracks( var_0 )
{
    switch ( var_0 )
    {
        case "dog_melee":
            var_1 = dogmelee();

            if ( isdefined( var_1 ) )
            {
                if ( isplayer( var_1 ) )
                {
                    var_2 = var_1 _meth_8311();

                    if ( isdefined( var_2 ) && var_2 == "s1_exo_shield_sp" )
                        var_1 shellshock( "dog_bite_hit_shield", 0.5 );
                    else
                        var_1 shellshock( "dog_bite", 1 );

                    soundscripts\_snd::snd_message( "anml_doberman", "attack_hit" );
                    thread knockoutofads( var_1 );
                }
            }
            else
            {
                attackmiss();
                return 1;
            }

            break;
        case "stop_tracking":
            self _meth_818F( "face current" );
            break;
    }
}

addsafetyhealth()
{
    var_0 = self.meleeingplayer _meth_807B();

    if ( var_0 == 0 )
        return 0;

    if ( var_0 < 0.25 )
    {
        self.meleeingplayer _meth_8050( var_0 + 0.25 );
        return 1;
    }

    return 0;
}

removesafetyhealth()
{
    var_0 = self.meleeingplayer _meth_807B();

    if ( var_0 > 0.25 )
        self.meleeingplayer _meth_8050( var_0 - 0.25 );
    else
        self.meleeingplayer _meth_8050( 0.01 );
}

handlemeleefinishattacknotetracks( var_0 )
{
    switch ( var_0 )
    {
        case "dog_melee":
            var_1 = addsafetyhealth();
            var_2 = dogmelee();

            if ( isdefined( var_2 ) && isplayer( var_2 ) && isalive( self.meleeingplayer ) )
            {
                if ( var_1 )
                    removesafetyhealth();

                self.skipstartmove = undefined;
                self.meleeingplayer.player_view = playerview_spawn( self );

                if ( self.meleeingplayer.player_view playerview_startsequence( self ) )
                    self _meth_82C0( 0 );
            }
            else
            {
                if ( var_1 )
                    removesafetyhealth();

                attackmiss();
                return 1;
            }

            break;
        case "dog_early":
            self notify( "dog_early_notetrack" );
            var_3 = 0.45 + 0.8 * level.dog_melee_timing_array[level.dog_melee_index];
            var_3 *= dog_vs_player_anim_rate();
            level.dog_melee_index++;

            if ( level.dog_melee_index >= level.dog_melee_timing_array.size )
            {
                level.dog_melee_index = 0;
                level.dog_melee_timing_array = common_scripts\utility::array_randomize( level.dog_melee_timing_array );
            }

            self _meth_8112( "meleeanim", %german_shepherd_attack_player, 1, 0.2, var_3 );
            self _meth_8112( "meleeanim", %german_shepherd_attack_player_late, 1, 0.2, var_3 );
            self.meleeingplayer.player_view playerview_playknockdownanimlimited( var_3 );
            break;
        case "dog_lunge":
            thread set_melee_timer();
            var_3 = dog_vs_player_anim_rate();
            self _meth_8111( "meleeanim", %german_shepherd_attack_player, 1, 0.2, var_3 );
            self.meleeingplayer.player_view playerview_playknockdownanim( var_3 );
            break;
        case "dogbite_damage":
            thread killplayer();
            break;
        case "stop_tracking":
            self _meth_818F( "face current" );
            break;
    }
}

handle_dogbite_notetrack( var_0 )
{
    switch ( var_0 )
    {
        case "dogbite_damage":
            thread killplayer();
            break;
    }
}

set_melee_timer()
{
    wait 0.1;
    thread dog_hint();
    wait 0.05;
    self.melee_able_timer = gettime();
}

playerdoginit()
{
    self.lastdogmeleeplayertime = 0;
    self.dogmeleeplayercounter = 0;
}

meleebiteattackplayer()
{
    self.meleeingplayer = self.enemy;

    if ( !isdefined( self.meleeingplayer.doginited ) )
        self.meleeingplayer playerdoginit();

    var_0 = 30;
    var_1 = self.meleeattackdist + var_0;

    for (;;)
    {
        if ( !isalive( self.enemy ) )
            break;

        if ( !isplayer( self.enemy ) )
            break;

        if ( maps\_utility::is_player_down( self.enemy ) )
        {
            combatidle();
            continue;
        }

        if ( isdefined( self.meleeingplayer.syncedmeleetarget ) && self.meleeingplayer.syncedmeleetarget != self || isdefined( self.meleeingplayer.player_view ) && isdefined( self.meleeingplayer.player_view.inseq ) )
        {
            if ( checkendcombat( var_1 ) )
                break;
            else
            {
                combatidle();
                continue;
            }
        }

        if ( shouldwaitincombatidle() )
        {
            combatidle();
            continue;
        }

        self _meth_818F( "face enemy" );
        self _meth_818E( "zonly_physics" );
        self.safetochangescript = 0;
        prepareattackplayer();
        self _meth_8142( %body, 0.1 );
        self _meth_81FC();
        self.meleeingplayer setnextdogattackallowtime( 500 );

        if ( dog_cant_kill_in_one_hit() || !isdefined( self.dogallowplayerpairedanim ) )
        {
            self.meleeingplayer.lastdogmeleeplayertime = gettime();
            self.meleeingplayer.dogmeleeplayercounter++;
            self _meth_8113( "meleeanim", %german_shepherd_run_attack_b, 1, 0.2, 1 );
            animscripts\shared::donotetracks( "meleeanim", ::handlemeleebiteattacknotetracks );
        }
        else
        {
            thread dog_melee_death();
            self.meleeingplayer.attacked_by_dog = 1;
            self.meleeingplayer.laststand = 0;
            self.meleeingplayer.achieve_downed_kills = undefined;
            thread clear_player_attacked_by_dog_on_death();
            self _meth_8113( "meleeanim", %german_shepherd_attack_player, 1, 0.2, 1 );
            self _meth_8113( "meleeanim", %german_shepherd_attack_player_late, 1, 0, 1 );
            self _meth_814C( %attack_player, 1, 0, 1 );
            self _meth_814C( %attack_player_late, 0.01, 0, 1 );
            animscripts\shared::donotetracks( "meleeanim", ::handlemeleefinishattacknotetracks );
            self notify( "dog_no_longer_melee_able" );
            self _meth_82C0( 1 );
            self _meth_804F();
        }

        self.safetochangescript = 1;
        wait 0.05;

        if ( checkendcombat( var_1 ) )
            break;
    }

    self.safetochangescript = 1;
    self _meth_818E( "none" );
}

clear_player_attacked_by_dog_on_death()
{
    self waittill( "death" );
    self.meleeingplayer.attacked_by_dog = undefined;
}

dog_cant_kill_in_one_hit()
{
    if ( isdefined( self.meleeingplayer.dogs_dont_instant_kill ) )
        return 1;

    if ( maps\_utility::is_player_down( self.meleeingplayer ) )
        return 1;

    if ( isdefined( self.meleeingplayer.slidemodel ) )
        return 1;

    if ( gettime() - self.meleeingplayer.lastdogmeleeplayertime > 8000 )
        self.meleeingplayer.dogmeleeplayercounter = 0;

    return self.meleeingplayer.dogmeleeplayercounter < self.meleeingplayer.gs.dog_hits_before_kill && self.meleeingplayer.health > 25;
}

shouldwaitincombatidle()
{
    return isdefined( self.enemy.dogattackallowtime ) && gettime() < self.enemy.dogattackallowtime;
}

setnextdogattackallowtime( var_0 )
{
    self.dogattackallowtime = gettime() + var_0;
}

isdoingtraversal()
{
    return self _meth_819B() && self.script != "scripted" && self.script != "<custom>";
}

meleestrugglevsai()
{
    if ( !isalive( self.enemy ) || !isdefined( level.allow_dog_paired_melee_vs_ai ) )
        return;

    if ( isdefined( self.enemy.melee ) )
    {
        if ( !isdefined( self.enemy.melee.target ) || self.enemy.melee.target != self )
        {
            combatidle();
            return;
        }
    }

    if ( isdefined( self.enemy.syncedmeleetarget ) || shouldwaitincombatidle() || !isai( self.enemy ) )
        combatidle();
    else
    {
        self.in_melee = 1;
        self.enemy setnextdogattackallowtime( 500 );
        self.enemy.dog_attacking_me = self;
        var_0 = animscripts\battlechatter::getdirectionfacingclock( self.enemy.angles, self.enemy.origin, self.origin );
        var_1 = "F";

        switch ( var_0 )
        {
            case "4":
            case "3":
            case "2":
                var_1 = "R";
                break;
            case "10":
            case "9":
            case "8":
                var_1 = "L";
                break;
            case "7":
            case "6":
            case "5":
                var_1 = "B";
                break;
        }

        self.enemy.dog_attack_dir = var_1;
        level notify( "dog_attacks_ai", self, self.enemy, var_1 );
        self.enemy notify( "dog_attacks_ai", self, var_1 );

        if ( isdefined( level.dog_alt_melee_func ) )
        {
            if ( [[ level.dog_alt_melee_func ]]( var_1 ) )
                return 1;
        }

        self.safetochangescript = 0;
        self _meth_818E( "zonly_physics" );
        self.pushable = 0;
        self _meth_81FC();
        self.meleekilltarget = !isdefined( self.enemy.magic_bullet_shield ) && !isdefined( self.enemy.noragdoll ) && ( isdefined( self.enemy.a.doinglongdeath ) || isdefined( self.meleealwayswin ) || randomint( 100 ) > 50 );
        self.originaltarget = self.enemy;
        self.enemy.battlechatter = 0;
        self.enemy.ignoreall = 1;
        self.enemy _meth_8166();
        self.enemy.diequietly = 1;
        var_2 = 0;

        if ( isdefined( self.enemy.use_old_dog_attack ) )
            var_2 = 1;

        if ( meleestruggle_istraverse() )
            return meleestrugglevsai_traverse( var_1 );

        var_3 = vectortoangles( self.origin - self.enemy.origin );
        var_3 = ( 0, var_3[1], 0 );
        var_4 = [];
        var_4[0] = %body;

        if ( var_2 )
        {
            self.enemy.use_old_dog_attack = 1;
            var_4[1] = %iw6_dog_kill_front_quick_1;
            var_5 = 1;

            if ( isdefined( self.controlling_dog ) && self.controlling_dog )
                thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short" );
            else
                thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short_npc" );
        }
        else if ( isdefined( self.enemy.a.doinglongdeath ) || self.enemy.a.pose == "prone" || self.enemy isdoingtraversal() )
        {
            thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short_npc" );
            return domeleevsai_simple();
        }
        else
        {
            var_4[1] = %iw6_dog_kill_front_long_1;
            var_5 = 1;

            switch ( var_1 )
            {
                case "R":
                    var_4[1] = %iw6_dog_kill_right_quick_1;
                    var_5 = 1;
                    var_3 += ( 0, 90, 0 );

                    if ( isdefined( self.controlling_dog ) && self.controlling_dog )
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short" );
                    else
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short_npc" );

                    break;
                case "L":
                    var_4[1] = %iw6_dog_kill_left_quick_1;
                    var_5 = 1;
                    var_3 += ( 0, -90, 0 );

                    if ( isdefined( self.controlling_dog ) && self.controlling_dog )
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short" );
                    else
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short_npc" );

                    break;
                case "B":
                    var_4[1] = %iw6_dog_kill_back_quick_1;
                    var_5 = 1;
                    var_3 -= ( 0, 180, 0 );

                    if ( isdefined( self.controlling_dog ) && self.controlling_dog )
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_quick_back_plr" );
                    else
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_quick_back_npc" );

                    break;
                default:
                    if ( isdefined( self.controlling_dog ) && self.controlling_dog )
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_front_plr" );
                    else
                        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_front_npc" );

                    break;
            }
        }
    }
}

domeleevsai_simple()
{
    self _meth_819A( ::domeleevsai_simple_animcustom, ::domeleevsai_simple_animcustom_cleanup );
    return 1;
}

domeleevsai_simple_animcustom()
{
    self notify( "stop_pant" );
    self.flashbangimmunity = 1;
    self.enemy meleestrugglevsdog_justdie();
    var_0 = self.enemy.origin - self.origin;
    var_1 = vectortoangles( var_0 );
    self _meth_8142( %body, 0.1 );
    self _meth_818E( "zonly_physics" );
    self _meth_818F( "face angle", var_1[1] );
    animscripts\shared::donotetracks( "meleeanim" );
}

domeleevsai_simple_animcustom_cleanup()
{
    self.pushable = 1;
    self.safetochangescript = 1;
    self.flashbangimmunity = 0;
    self.in_melee = 0;
}

domeleevsai( var_0, var_1, var_2, var_3 )
{
    self notify( "stop_pant" );
    self _meth_82C0( 0 );
    self.enemy.fndogmeleevictim = var_3;
    self endon( "melee_dog_interrupted" );
    thread meleestrugglevsai_interruptedcheck( self.enemy );
    self _meth_8142( var_0[0], 0.1 );
    self _meth_8140( "meleeanim", self.enemy.origin, var_2, var_0[1] );

    if ( !animhasnotetrack( var_0[1], "ai_attack_start" ) )
        handlestartaipart( "ai_attack_start" );

    animscripts\shared::donotetracks( "meleeanim", ::handlestartaipart );
    self notify( "end_dog_interrupted_check" );
    self _meth_82C0( 1 );
    self _meth_818E( "zonly_physics" );

    for ( var_4 = 1; var_4 < var_1; var_4++ )
    {
        if ( isdefined( level._effect["dog_bite"] ) && isdefined( level._effect["dog_bite"][var_4] ) && isdefined( self.enemy ) )
            playfxontag( level._effect["dog_bite"][var_4], self.enemy, "TAG_EYE" );

        self _meth_8142( var_0[var_4], 0 );

        if ( !insyncmeleewithtarget() )
            break;

        if ( !self.meleekilltarget && var_4 + 1 == var_1 )
            self.health = 1;

        self _meth_8113( "meleeanim", var_0[var_4 + 1], 1, 0, 1 );
        animscripts\shared::donotetracks( "meleeanim" );
    }

    melee_dogcleanup();
    return 1;
}

melee_dogcleanup()
{
    self _meth_804F();

    if ( !self.meleekilltarget )
    {
        if ( !isdefined( self.magic_bullet_shield ) )
            self _meth_8052();
    }
    else
    {
        self.pushable = 1;
        self.safetochangescript = 1;
        self.flashbangimmunity = 0;
    }

    thread ragdoll_corpses();
    self.in_melee = 0;

    if ( isdefined( self.doglastknowngoodpos ) )
    {
        var_0 = self _meth_83E5( self.origin, self.origin + ( 0, 0, 2 ), undefined, undefined, 1, 0, 1 );

        if ( distancesquared( var_0, self.origin ) < 0.001 )
            self _meth_81C6( self.doglastknowngoodpos, self.angles, 60 );

        self.doglastknowngoodpos = undefined;
    }

    self _meth_818E( "none" );
}

meleestruggle_istraverse()
{
    var_0 = self _meth_83CF();
    return isdefined( var_0 );
}

meleestrugglevsai_traverse( var_0 )
{
    self.safetochangescript = 0;
    self _meth_818E( "zonly_physics" );
    self.pushable = 0;
    self _meth_81FC();
    self.meleekilltarget = !isdefined( self.enemy.magic_bullet_shield ) && ( isdefined( self.enemy.a.doinglongdeath ) || isdefined( self.meleealwayswin ) || randomint( 100 ) > 50 );
    self.originaltarget = self.enemy;
    self.enemy.battlechatter = 0;
    var_1 = vectortoangles( self.origin - self.enemy.origin );
    var_1 = ( 0, var_1[1], 0 );
    var_2 = [];
    var_2[0] = %body;
    var_2[1] = %iw6_dog_kill_wall_over_front_1;
    var_3 = 1;

    if ( self.enemy isdoingtraversal() )
        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_short_npc" );
    else if ( isdefined( self.controlling_dog ) && self.controlling_dog )
        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_front_plr" );
    else
        thread maps\_utility::play_sound_on_entity( "scn_nml_dog_attack_front_npc" );

    self.doglastknowngoodpos = self.origin;
    return domeleevsai( var_2, var_3, var_1, ::meleestrugglevsdog_traverse );
}

meleestrugglevsai_interrupted_animcustom()
{
    self _meth_818E( "gravity" );
    self _meth_8142( %body, 0.2 );
    self _meth_8111( "meleeanim", %iw6_dog_kill_breach_end_nml );
    animscripts\shared::donotetracks( "meleeanim" );
}

meleestrugglevsai_interrupted_animcustom_cleanup()
{
    if ( isdefined( self.doglastknowngoodposcustom ) )
        self.doglastknowngoodpos = self.doglastknowngoodposcustom;

    self.doglastknowngoodposcustom = undefined;
    self _meth_818E( "zonly_physics" );
    melee_dogcleanup();
    meleestrugglevsdog_end();
}

meleestrugglevsai_interruptedcheck( var_0 )
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "end_melee_all" );
    self endon( "end_dog_interrupted_check" );
    var_0 waittill( "death" );
    self notify( "melee_dog_interrupted" );
    self _meth_804F();
    self _meth_82C0( 1 );
    self.doglastknowngoodposcustom = self.doglastknowngoodpos;
    self _meth_819A( ::meleestrugglevsai_interrupted_animcustom, ::meleestrugglevsai_interrupted_animcustom_cleanup );
}

combatidle()
{
    self _meth_818F( "face enemy" );
    self _meth_8142( %body, 0.1 );
    self _meth_818E( "zonly_physics" );
    var_0 = [];
    var_0[0] = %iw6_dog_attackidle;
    var_0[1] = %iw6_dog_attackidle_bark;
    var_1 = common_scripts\utility::random( var_0 );
    thread combatidlepreventoverlappingplayer();
    self _meth_8113( "combat_idle", var_1, 1, 0.2, 1 );
    animscripts\shared::donotetracks( "combat_idle" );
    self notify( "combatIdleEnd" );
}

combatidlepreventoverlappingplayer()
{
    self endon( "killanimscript" );
    self endon( "combatIdleEnd" );

    for (;;)
    {
        wait 0.1;
        var_0 = getentarray( "player", "classname" );

        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        {
            var_2 = var_0[var_1];

            if ( !isdefined( var_2.syncedmeleetarget ) || var_2.syncedmeleetarget == self )
                continue;

            var_3 = var_2.origin - self.origin;

            if ( var_3[2] * var_3[2] > 6400 )
                continue;

            var_3 = ( var_3[0], var_3[1], 0 );
            var_4 = length( var_3 );

            if ( var_4 < 1 )
                var_3 = anglestoforward( self.angles );

            if ( var_4 < 30 )
            {
                var_3 *= 3 / var_4;
                self _meth_81C7( self.origin - var_3, ( 0, 30, 0 ) );
            }
        }
    }
}

insyncmeleewithtarget()
{
    return isdefined( self.enemy ) && isdefined( self.enemy.syncedmeleetarget ) && self.enemy.syncedmeleetarget == self;
}

handlestartaipart( var_0 )
{
    if ( var_0 != "ai_attack_start" )
    {
        handlevxnotetrack( var_0 );
        return undefined;
    }

    if ( !isdefined( self.enemy ) )
        return 1;

    if ( self.enemy != self.originaltarget )
        return 1;

    if ( isdefined( self.enemy.syncedmeleetarget ) )
        return 1;

    self.flashbangimmunity = 1;
    self.enemy.syncedmeleetarget = self;

    if ( self.enemy isdoingtraversal() )
        self.enemy meleestrugglevsdog_justdie();
    else if ( isdefined( self.enemy.fndogmeleevictim ) )
        self.enemy _meth_819A( self.enemy.fndogmeleevictim );
    else
        self.enemy _meth_819A( ::meleestrugglevsdog );
}

checkendcombat( var_0 )
{
    if ( !isdefined( self.enemy ) )
        return 0;

    var_1 = distancesquared( self.origin, self.enemy.origin );
    return var_1 > var_0 * var_0;
}

prepareattackplayer()
{
    if ( is_hyena() )
    {
        level.dog_death_quote = &"NEW_HYENA_DEATH_DO_NOTHING_ALT";
        level.so_dog_death_quote = "@NEW_HYENA_DEATH_DO_NOTHING_ALT";
    }
    else
    {
        level.dog_death_quote = &"NEW_DOG_DEATH_DO_NOTHING_ALT";
        level.so_dog_death_quote = "@NEW_DOG_DEATH_DO_NOTHING_ALT";
    }

    level.dog_death_type = "nothing";
    var_0 = distance( self.origin, self.enemy.origin );

    if ( var_0 > self.meleeattackdist )
    {
        var_1 = self.enemy.origin - self.origin;
        var_2 = ( var_0 - self.meleeattackdist ) / var_0;
        var_1 = ( var_1[0] * var_2, var_1[1] * var_2, var_1[2] * var_2 );
        thread attackteleportthread( var_1 );
    }
}

attackteleportthread( var_0 )
{
    self endon( "death" );
    self endon( "killanimscript" );
    var_1 = 5;
    var_2 = ( var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1 );

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        self _meth_81C5( self.origin + var_2 );
        wait 0.05;
    }
}

player_attacked()
{
    return isalive( self.meleeingplayer ) && self.meleeingplayer meleebuttonpressed();
}

dog_hint()
{
    var_0 = self.meleeingplayer.gs.dog_presstime / 1000 / dog_vs_player_anim_rate();
    level endon( "clearing_dog_hint" );

    if ( isdefined( self.meleeingplayer.doghintelem ) )
        self.meleeingplayer.doghintelem maps\_hud_util::destroyelem();

    self.meleeingplayer.doghintelem = self.meleeingplayer maps\_hud_util::createclientfontstring( "default", 3 );
    self.meleeingplayer.doghintelem.color = ( 1, 1, 1 );
    self.meleeingplayer.doghintelem settext( &"SCRIPT_PLATFORM_DOG_HINT" );
    self.meleeingplayer.doghintelem.x = 0;
    self.meleeingplayer.doghintelem.y = 20;
    self.meleeingplayer.doghintelem.alignx = "center";
    self.meleeingplayer.doghintelem.aligny = "middle";
    self.meleeingplayer.doghintelem.horzalign = "center";
    self.meleeingplayer.doghintelem.vertalign = "middle";
    self.meleeingplayer.doghintelem.foreground = 1;
    self.meleeingplayer.doghintelem.alpha = 1;
    self.meleeingplayer.doghintelem.hidewhendead = 1;
    self.meleeingplayer.doghintelem.sort = -1;
    self.meleeingplayer.doghintelem endon( "death" );
    wait(var_0);
    thread dog_hint_fade();
}

dog_hint_fade()
{
    level notify( "clearing_dog_hint" );

    if ( isdefined( self ) && isdefined( self.meleeingplayer.doghintelem ) )
    {
        var_0 = self.meleeingplayer.doghintelem;

        if ( isdefined( self.meleeingplayer.player_view.necksnapped ) && self.meleeingplayer.player_view.necksnapped )
        {
            var_1 = 0.5;
            var_0 _meth_808B( var_1 );
            var_0.fontscale *= 1.5;
            var_0.glowcolor = ( 0.3, 0.6, 0.3 );
            var_0.glowalpha = 1;
            var_0 fadeovertime( var_1 );
            var_0.color = ( 0, 0, 0 );
            var_0.alpha = 0;
            wait(var_1);
            var_0 maps\_hud_util::destroyelem();
        }
        else
            var_0 maps\_hud_util::destroyelem();
    }
}

dog_delayed_unlink()
{
    wait 0.7;

    if ( isdefined( self ) )
        self _meth_804F();
}

dog_delayed_allow_damage()
{
    self endon( "death" );
    wait 1.5;

    if ( isdefined( self ) )
        self _meth_82C0( 1 );
}

dog_melee_death()
{
    self endon( "killanimscript" );
    self endon( "dog_no_longer_melee_able" );
    var_0 = 0;
    var_1 = self.meleeingplayer.gs.dog_presstime / dog_vs_player_anim_rate();
    self waittill( "dog_early_notetrack" );

    while ( player_attacked() )
        wait 0.05;

    var_2 = 0;

    for (;;)
    {
        if ( !var_0 )
        {
            if ( player_attacked() )
            {
                var_0 = 1;

                if ( isdefined( self.melee_able_timer ) && isalive( self.meleeingplayer ) )
                {
                    if ( gettime() - self.melee_able_timer <= var_1 )
                    {
                        self.meleeingplayer set_melee_early( var_2 );
                        self.meleeingplayer.player_view.necksnapped = 1;
                        self notify( "melee_stop" );
                        self _meth_810D( "dog_death_anim", %german_shepherd_player_neck_snap, 1, 0.2, 1 );
                        thread dog_delayed_allow_damage();
                        self _meth_82C0( 0 );
                        self waittillmatch( "dog_death_anim", "dog_death" );
                        thread common_scripts\utility::play_sound_in_space( "dog_neckbreak", self _meth_80A8() );
                        self _meth_82C0( 1 );
                        self.a.nodeath = 1;
                        self.dog_neck_snapped = 1;
                        var_3 = self.meleeingplayer.origin - self.origin;
                        var_3 = ( var_3[0], var_3[1], 0 );
                        thread dog_delayed_unlink();
                        self _meth_8052( self _meth_80A8() - var_3, self.meleeingplayer );
                        self notify( "killanimscript" );
                    }
                    else
                    {
                        self.meleeingplayer set_melee_early( var_2 );
                        self.meleeingplayer.player_view playerview_knockdownlate();
                        self _meth_814C( %attack_player, 0.01, 0.2, 1 );
                        self _meth_814C( %attack_player_late, 1, 0.2, 1 );

                        if ( is_hyena() )
                        {
                            level.dog_death_quote = &"NEW_HYENA_DEATH_TOO_LATE_ALT";
                            level.so_dog_death_quote = "@NEW_HYENA_DEATH_TOO_LATE_ALT";
                        }
                        else
                        {
                            level.dog_death_quote = &"NEW_DOG_DEATH_TOO_LATE_ALT";
                            level.so_dog_death_quote = "@NEW_DOG_DEATH_TOO_LATE_ALT";
                        }

                        level.dog_death_type = "late";
                    }

                    return;
                }

                var_2 = 1;

                if ( self.meleeingplayer can_early_melee() )
                {
                    if ( is_hyena() )
                    {
                        level.dog_death_quote = &"NEW_HYENA_DEATH_TOO_SOON_ALT";
                        level.so_dog_death_quote = "@NEW_HYENA_DEATH_TOO_SOON_ALT";
                    }
                    else
                    {
                        level.dog_death_quote = &"NEW_DOG_DEATH_TOO_SOON_ALT";
                        level.so_dog_death_quote = "@NEW_DOG_DEATH_TOO_SOON_ALT";
                    }

                    level.dog_death_type = "soon";
                    var_4 = dog_vs_player_anim_rate();
                    self _meth_810D( "meleeanim", %german_shepherd_player_neck_miss, 1, 0.2, var_4 );
                    self.meleeingplayer.player_view playerview_playmissanim( var_4 );
                    return;
                }
            }
        }
        else if ( !player_attacked() )
            var_0 = 0;

        wait 0.05;
    }
}

can_early_melee()
{
    if ( self.gameskill == 3 )
        return 1;

    if ( isdefined( self.dogmeleeearly ) && self.dogmeleeearly )
        return 1;

    return 0;
}

set_melee_early( var_0 )
{
    if ( !var_0 )
        return;

    if ( level.gameskill > 1 && !isdefined( self.dogmeleeearly ) )
        self.dogmeleeearly = 1;
}

#using_animtree("generic_human");

meleestrugglevsdog()
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "end_melee_all" );

    if ( !isdefined( self.syncedmeleetarget ) )
        return;

    self _meth_80AC();
    var_0 = vectortoangles( self.syncedmeleetarget.origin - self.origin );
    var_1 = var_0[1];

    if ( isdefined( self.use_old_dog_attack ) && self.use_old_dog_attack )
    {
        var_2 = [];
        var_2[0] = %body;
        var_2[1] = %iw6_dog_kill_front_quick_guy_1;
        var_3 = 1;
        maps\_utility::gun_remove();
    }
    else
    {
        var_2 = [];
        var_2[0] = %body;

        switch ( self.dog_attack_dir )
        {
            case "F":
                var_2[1] = %iw6_dog_kill_front_long_guy_1;
                var_3 = 1;
                playsound_victim( "dogdeathlong" );
                break;
            case "R":
                var_2[1] = %iw6_dog_kill_right_quick_guy_1;
                var_3 = 1;
                var_1 = var_0[1] + 90;
                playsound_victim( "dogdeathshort" );
                break;
            case "L":
                var_2[1] = %iw6_dog_kill_left_quick_guy_1;
                var_3 = 1;
                var_1 = var_0[1] - 90;
                playsound_victim( "dogdeathshort" );
                break;
            case "B":
                var_2[1] = %iw6_dog_kill_back_quick_guy_1;
                var_3 = 1;
                var_1 = var_0[1] - 180;
                playsound_victim( "dogdeathshort" );
                break;
            default:
                break;
        }
    }

    domeleevsdog( var_2, var_1 );
}

playsound_victim( var_0 )
{
    if ( isdefined( self.syncedmeleetarget.controlling_dog ) )
        var_0 += "plr";

    thread animscripts\face::saygenericdialogue( var_0 );
}

meleestrugglevsdog_interruptedcheck()
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "end_melee_all" );
    var_0 = [];
    var_0[1] = %ai_attacked_german_shepherd_02_getup_a;
    var_0[2] = %ai_attacked_german_shepherd_02_getup_a;

    if ( self.syncedmeleetarget.meleekilltarget )
        var_0[4] = %ai_attacked_german_shepherd_04_getup_a;

    for (;;)
    {
        if ( !isdefined( self.syncedmeleetarget ) || !isalive( self.syncedmeleetarget ) )
            break;

        wait 0.1;
    }

    self.ragdoll_immediate = undefined;

    if ( self.meleeseq > 0 )
    {
        if ( !isdefined( var_0[self.meleeseq] ) )
            return;

        self _meth_8142( %melee_dog, 0.1 );
        self _meth_8113( "getupanim", var_0[self.meleeseq], 1, 0.1, 1 );
        animscripts\shared::donotetracks( "getupanim" );
    }

    meleestrugglevsdog_end();
}

meleestrugglevsdog_end()
{
    self _meth_818F( "face default" );
    self.syncedmeleetarget = undefined;
    self.meleeseq = undefined;
    self.allowpain = 1;
    self.battlechatter = 1;
    self.use_old_dog_attack = undefined;
    self.dog_attacking_me = undefined;
    setnextdogattackallowtime( 1000 );

    if ( isdefined( self.olddontattackme ) )
    {
        self.dontattackme = self.olddontattackme;
        self.olddontattackme = undefined;
    }

    self notify( "end_melee_all" );
}

meleestrugglevsdog_collision( var_0 )
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "end_melee_all" );
    var_1 = self.syncedmeleetarget;
    var_1 endon( "death" );
    var_1 endon( "killanimscript" );

    if ( isdefined( var_0 ) && var_0 > 0 )
        wait(var_0);

    var_1.doglastknowngoodpos = var_1.origin;

    for (;;)
    {
        var_2 = var_1 _meth_83E5( self.origin, var_1.origin, undefined, undefined, 1, 1, 1 );

        if ( var_2["fraction"] >= 1 )
        {
            var_1.doglastknowngoodpos = var_1.origin;
            wait 0.05;
            continue;
        }

        if ( var_2["normal"][2] >= 0 )
        {
            var_3 = var_2["position"] - var_1.origin;
            var_4 = vectordot( var_3, var_2["normal"] );

            if ( var_4 > 0 )
            {
                var_5 = self.origin + ( var_4 + 1 ) * var_2["normal"];
                var_6 = var_5 + ( 0, 0, 9 );
                var_7 = var_5 + ( 0, 0, -9 );
                var_8 = self _meth_83E5( var_6, var_7 );

                if ( var_8[2] > var_5[2] )
                    var_5 = var_8;

                self _meth_81C6( var_5, self.angles, 60 );
            }
        }

        wait 0.05;
    }
}

meleestrugglevsdog_justdie()
{
    thread animscripts\face::saygenericdialogue( "dogdeathlong" );
    self.ragdoll_immediate = 1;

    if ( !isdefined( self.magic_bullet_shield ) )
    {
        self.forceragdollimmediate = 1;
        animscripts\shared::dropallaiweapons();
        self _meth_8052( self.dog_attacking_me.origin, self.dog_attacking_me );
    }

    thread ragdoll_corpses();
    setnextdogattackallowtime( 1000 );
}

meleestrugglevsdog_traverse()
{
    if ( !isdefined( self.syncedmeleetarget ) )
        return;

    var_0 = vectortoangles( self.syncedmeleetarget.origin - self.origin );
    var_1 = var_0[1];
    var_2 = [];
    var_2[0] = %body;
    var_2[1] = %iw6_dog_kill_wall_over_front_guy_1;
    playsound_victim( "dogdeathlong" );
    domeleevsdog( var_2, var_1, 0.15 );
}

domeleevsdog( var_0, var_1, var_2 )
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "end_melee_all" );

    if ( !isdefined( self.syncedmeleetarget ) )
        return;

    self _meth_818F( "face angle", var_1 );
    self _meth_818E( "gravity" );
    self.olddontattackme = self.dontattackme;
    self.dontattackme = 1;
    self.health = 1;
    self.battlechatter = 0;
    self.a.pose = "stand";
    self.a.special = "none";

    if ( animscripts\utility::usingsidearm() )
        animscripts\shared::placeweaponon( self.primaryweapon, "right" );

    self.ragdoll_immediate = 1;
    self.meleeseq = 0;
    thread meleestrugglevsdog_interruptedcheck();
    self _meth_8142( var_0[0], 0.1 );
    self _meth_8113( "aianim", var_0[1], 1, 0.1, 1 );
    thread animscripts\shared::donotetracks( "aianim" );
    wait 0.15;
    self.syncedmeleetarget _meth_804D( self, "tag_sync", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread meleestrugglevsdog_collision( var_2 );
    self waittillmatch( "aianim", "end" );
    self.syncedmeleetarget notify( "end_dog_interrupted_check" );

    if ( !isdefined( self.magic_bullet_shield ) )
    {
        self.forceragdollimmediate = 1;
        self.a.nodeath = 1;
        animscripts\shared::dropallaiweapons();
        self _meth_8052( self.dog_attacking_me.origin, self.dog_attacking_me );
    }

    meleestrugglevsdog_end();
}

#using_animtree("player_3rd_person");

playerdrone_create( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1 [[ var_0.last_modelfunc ]]();
    var_1 _meth_8115( #animtree );
    return var_1;
}

playerdrone_anim_knockdown( var_0 )
{
    self endon( "death" );
    var_1 = getanimlength( %player_3rd_dog_knockdown );
    self _meth_814B( %player_3rd_dog_knockdown, 1, 0, var_0 );
}

playerdone_anim_neck_snap()
{
    self _meth_8145( %player_3rd_dog_knockdown_neck_snap, 1, 0, 1 );
}

playerdone_anim_saved()
{
    self _meth_8145( %player_3rd_dog_knockdown_saved, 1, 0, 1 );
}

playerdone_anim_laststand()
{
    self _meth_8145( %player_3rd_dog_knockdown_laststand, 1, 0, 1 );
}

#using_animtree("player");

playerview_spawn( var_0 )
{
    var_1 = spawn( "script_model", var_0.meleeingplayer.origin );
    var_1.angles = var_0.meleeingplayer.angles;
    var_1 _meth_80B1( level.player_viewhand_model );
    var_1 _meth_8115( #animtree );
    var_1 hide();
    return var_1;
}

handleplayerknockdownnotetracks( var_0 )
{
    switch ( var_0 )
    {
        case "allow_player_save":
            if ( isdefined( self.dog ) )
            {
                wait 1;
                self.dog _meth_82C0( 1 );
            }

            break;
        case "blood_pool":
            if ( !isdefined( self.dog.meleeingplayer ) )
                break;

            if ( maps\_utility::killing_will_down( self.dog.meleeingplayer ) )
                break;

            var_1 = self gettagorigin( "tag_torso" );
            var_2 = self gettagangles( "tag_torso" );
            var_3 = anglestoforward( var_2 );
            var_4 = anglestoup( var_2 );
            var_5 = anglestoright( var_2 );
            var_1 = var_1 + var_3 * -8.5 + var_4 * 5 + var_5 * 0;
            playfx( level._effect["deathfx_bloodpool"], var_1, var_3, var_4 );
            break;
    }
}

playerview_knockdownanim( var_0 )
{
    self endon( "pvd_melee_interrupted" );
    var_1 = var_0.meleeingplayer;
    self.dog = var_0;
    thread playerview_checkinterrupted( var_1 );
    self _meth_8113( "viewanim", %player_view_dog_knockdown );
    self _meth_8113( "viewanim", %player_view_dog_knockdown_late );
    self _meth_814C( %knockdown, 1, 0, 1 );
    self _meth_814C( %knockdown_late, 0.01, 0, 1 );
    animscripts\shared::donotetracks( "viewanim", ::handleplayerknockdownnotetracks );
    self _meth_8092();
    self.dog = undefined;
    playerview_endsequence( var_1 );
    self notify( "pvd_melee_done" );
}

playerview_checkinterrupted( var_0 )
{
    self endon( "pvd_melee_done" );
    self.dog common_scripts\utility::waittill_any( "death", "pain", "melee_stop" );

    if ( !isdefined( var_0.specialdeath ) && isalive( var_0 ) )
    {
        self notify( "pvd_melee_interrupted" );
        self.dog notify( "pvd_melee_interrupted" );
        playerview_endsequence( var_0 );
    }
}

playerview_startsequence( var_0 )
{
    if ( isdefined( self.inseq ) )
        return 0;

    var_1 = var_0.meleeingplayer;

    if ( isdefined( var_1 ) && isdefined( var_1.placingsentry ) )
        var_1 notify( "sentry_placement_canceled" );

    var_1 notify( "dog_attacks_player" );
    self.inseq = 1;

    if ( isalive( var_1 ) )
        var_1 _meth_80FA();

    var_1 _meth_817D( "stand" );
    var_1.syncedmeleetarget = var_0;
    var_1.player_view playerview_show( var_1 );
    var_2 = var_0.origin - var_1.origin;
    self.angles = vectortoangles( var_2 );
    self.angles = ( 0, self.angles[1], 0 );
    self.startangles = self.angles;
    var_3 = var_1.origin;
    var_4 = var_1 _meth_813C( var_1.origin );

    if ( isdefined( var_4 ) )
        self.origin = var_4;
    else
        self.origin = var_1.origin;

    thread playerview_knockdownanim( var_0 );
    self _meth_8092();
    var_1 _meth_807F( self, "tag_player" );
    var_0 _meth_804D( self, "tag_sync", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_5 = self gettagangles( "tag_sync" );
    var_0 _meth_818F( "face angle", var_5[1] );
    var_0 _meth_818F( "face default" );
    var_1 _meth_8118( 1 );
    var_1 _meth_811B( 0 );
    var_1 _meth_8119( 0 );
    var_1 _meth_811A( 0 );
    var_1 freezecontrols( 1 );
    var_1 _meth_82C0( 0 );
    return 1;
}

savednotify( var_0 )
{
    wait 0.5;
    var_0 playsound( "saved_from_dog" );
}

player_gets_weapons_back()
{
    self endon( "death" );
    self _meth_8481();
    self _meth_831E();
}

playerview_endsequence( var_0 )
{
    var_0 _meth_80FB();

    if ( isalive( var_0 ) )
    {
        self _meth_8142( %player_view_dog_knockdown, 0.1 );

        if ( isdefined( self.necksnapped ) )
        {
            self _meth_8113( "viewanim", %player_view_dog_knockdown_neck_snap, 1, 0.2, 1 );

            if ( isdefined( self.playerdrone ) )
                self.playerdrone playerdone_anim_neck_snap();
        }
        else if ( isdefined( var_0.dog_downed_player ) )
        {
            self _meth_810D( "viewanim", %player_view_dog_knockdown_laststand, 1, 0.1, 1 );

            if ( isdefined( self.playerdrone ) )
                self.playerdrone playerdone_anim_laststand();
        }
        else
        {
            thread savednotify( var_0 );
            self _meth_8113( "viewanim", %player_view_dog_knockdown_saved );

            if ( isdefined( self.playerdrone ) )
                self.playerdrone playerdone_anim_saved();
        }

        if ( !isdefined( var_0.dog_downed_player ) )
        {
            var_0 maps\_utility::delaythread( 2.5, ::player_gets_weapons_back );
            animscripts\shared::donotetracks( "viewanim" );
            var_0 notify( "player_saved_from_dog" );
        }
        else
        {
            animscripts\shared::donotetracks( "viewanim" );
            var_0 notify( "deathshield", 1000000, self.dog );
            var_0 _meth_8481();
        }

        playerview_unlinkplayeranddelete( var_0 );
    }
    else
        _func_0D3( "compass", 0 );

    var_0.syncedmeleetarget = undefined;
    var_0.dog_downed_player = undefined;
    restoreplayercontrols( var_0 );
}

playerview_unlinkplayeranddelete( var_0 )
{
    var_0 show();
    var_0 _meth_804F();
    var_0 setorigin( self.origin );
    var_0 setangles( self.startangles );
    var_0 _meth_82C0( 1 );
    var_1 = var_0.player_view;

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_1.playerdrone ) )
            var_1.playerdrone delete();

        var_1 delete();
        var_0.player_view = undefined;
    }
}

restoreplayercontrols( var_0 )
{
    var_0 _meth_811B( 1 );
    var_0 _meth_8119( 1 );
    var_0 _meth_811A( 1 );
    var_0 freezecontrols( 0 );
    var_0.attacked_by_dog = undefined;
}

playerview_show( var_0 )
{
    self _meth_8055( var_0 );

    if ( maps\_utility::is_coop() )
    {
        var_1 = playerdrone_create( var_0 );
        var_1 _meth_804D( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_1 thread playerdrone_anim_knockdown( 1 );
        self.playerdrone = var_1;

        if ( level.player == var_0 && isdefined( level.player2 ) )
        {
            var_0 _meth_8056( level.player2 );
            var_1 _meth_8056( level.player );
        }
        else
        {
            var_0 _meth_8056( level.player );
            var_1 _meth_8056( level.player2 );
        }
    }

    var_0 _meth_8482();
    var_0 _meth_831D();
}

playerview_playknockdownanimlimited( var_0 )
{
    self _meth_8112( "viewanim", %player_view_dog_knockdown, 1, 0.2, var_0 );
    self _meth_8112( "viewanim", %player_view_dog_knockdown_late, 1, 0.2, var_0 );

    if ( isdefined( self.playerdrone ) )
        self.playerdrone playerdrone_anim_knockdown( var_0 );
}

playerview_playknockdownanim( var_0 )
{
    self _meth_8112( "viewanim", %player_view_dog_knockdown, 1, 0.2, var_0 );
    self _meth_8112( "viewanim", %player_view_dog_knockdown_late, 1, 0.2, var_0 );

    if ( isdefined( self.playerdrone ) )
        self.playerdrone playerdrone_anim_knockdown( var_0 );
}

playerview_playmissanim( var_0 )
{
    self _meth_810D( "viewanim", %player_view_dog_knockdown_neck_miss, 1, 0.2, var_0 );
}

playerview_knockdownlate()
{
    self _meth_814C( %knockdown, 0.01, 0.2, 1 );
    self _meth_814C( %knockdown_late, 1, 0.2, 1 );
}

dog_vs_player_anim_rate()
{
    return 1;
}

is_hyena()
{
    if ( issubstr( self.classname, "hyena" ) )
        return 1;

    return 0;
}

ragdoll_corpses()
{
    wait 0.1;
    var_0 = _func_0D9();

    foreach ( var_2 in var_0 )
    {
        if ( var_2 _meth_81E0() == 0 )
            var_2 _meth_8023();
    }
}

handlevxnotetrack( var_0 )
{
    if ( common_scripts\utility::string_starts_with( var_0, "vfx" ) )
    {
        if ( isdefined( level._effect[var_0] ) )
            playfxontag( common_scripts\utility::getfx( var_0 ), self, "TAG_MOUTH_FX" );
    }
    else if ( common_scripts\utility::string_starts_with( var_0, "screen_blood" ) )
    {
        if ( isdefined( self.controlling_dog ) )
        {
            var_1 = "bottom";

            if ( issubstr( var_0, "right" ) )
                var_1 = "right";
            else if ( issubstr( var_0, "left" ) )
                var_1 = "left";

            self notify( "screen_blood", var_1 );
        }
    }
}
