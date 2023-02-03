// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("dog");

init_dog_anims()
{
    if ( isdefined( level.dog_anims_initialized ) )
        return;

    level.dog_anims_initialized = 1;
    level.scr_anim["generic"]["dog_sniff_idle"][0] = %iw6_dog_sniff_idle;
    level.scr_anim["generic"]["dog_sniff_walk"] = %iw6_dog_sniff_walk;
    level.scr_anim["generic"]["dog_sneak_idle"][0] = %iw6_dog_sneakidle;
    level.scr_anim["generic"]["dog_sneak_walk"] = %iw6_dog_sneak_walk_forward;
}

dog_follow_path_func( var_0, var_1 )
{
    init_dog_anims();

    if ( self.type != "dog" )
        return;

    switch ( var_0 )
    {
        case "enable_sniff":
            dyn_sniff_disable();
            enable_dog_sniff();
            break;
        case "disable_sniff":
            dyn_sniff_disable();
            disable_dog_sniff();
            break;
        case "enable_dyn_sniff":
            dyn_sniff_enable();
            break;
        case "disable_dyn_sniff":
            dyn_sniff_disable();
            break;
        case "enable_sneak":
            dyn_sniff_disable();
            enable_dog_sneak();
            break;
        case "disable_sneak":
            dyn_sniff_disable();
            disable_dog_sneak();
            break;
    }
}

enable_dog_sniff()
{
    self.old_moveplaybackrate = self.moveplaybackrate;
    self.moveplaybackrate = 1;
    self.movementtype = "sniff";
    maps\_utility::disable_arrivals();
    self notify( "stop_pant" );
}

disable_dog_sniff()
{
    if ( isdefined( self.old_moveplaybackrate ) )
        self.moveplaybackrate = self.old_moveplaybackrate;

    self.movementtype = "run";
    maps\_utility::enable_arrivals();
}

enable_dog_sneak()
{
    init_dog_anims();
    self.run_overridesound = undefined;
    self.customidlesound = undefined;
    self.old_moveplaybackrate = self.moveplaybackrate;
    self.moveplaybackrate = 1;
    self.script_noturnanim = 1;
    self.script_nostairs = 1;
    maps\_utility::disable_arrivals();
    maps\_utility::disable_exits();
    maps\_utility::set_generic_idle_anim( "dog_sneak_idle" );
    maps\_utility::set_generic_run_anim( "dog_sneak_walk" );
}

disable_dog_sneak()
{
    if ( isdefined( self.old_moveplaybackrate ) )
        self.moveplaybackrate = self.old_moveplaybackrate;

    self.run_overridesound = undefined;
    self.customidlesound = undefined;
    self.script_noturnanim = undefined;
    self.script_nostairs = undefined;
    maps\_utility::enable_arrivals();
    maps\_utility::enable_exits();
    maps\_utility::clear_generic_idle_anim();
    maps\_utility::clear_generic_run_anim();
}

dog_lower_camera( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.75;

    self setanim( %camera, 1, var_0, 1 );
    self setanimknob( %iw6_dog_camera_down_add, 1, var_0, 1 );
}

dog_raise_camera( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.75;

    self setanim( %camera, 1, var_0, 1 );
    self setanimknob( %iw6_dog_camera_up_add, 1, var_0, 1 );
}

dyn_sniff_enable( var_0, var_1 )
{
    self endon( "death" );
    self endon( "dynsniff_off" );

    if ( isdefined( self.dyn_sniff ) )
        return;

    self.dyn_sniff = 1;

    if ( !isdefined( var_0 ) )
        var_0 = 400;

    if ( !isdefined( var_1 ) )
        var_1 = 200;

    self.old_moveplaybackrate = self.moveplaybackrate;

    for (;;)
    {
        var_2 = player_is_behind_me();
        var_3 = distance( self.origin, level.player.origin );

        if ( var_2 && var_3 > var_0 )
        {
            enable_dog_sniff();
            wait 4;

            while ( player_is_behind_me() && distance( self.origin, level.player.origin ) > var_1 )
                wait 0.1;

            disable_dog_sniff();
            wait 6;
        }

        wait 0.3;
    }
}

dyn_sniff_disable()
{
    self notify( "dynsniff_off" );
    disable_dog_sniff();
    self.dyn_sniff = undefined;
}

player_is_behind_me()
{
    var_0 = ( self.angles[0], self.angles[1], 0 );
    var_1 = anglestoforward( var_0 );
    var_2 = self.origin - ( 0, 0, self.origin[2] );
    var_3 = level.player.origin - ( 0, 0, level.player.origin[2] );
    var_4 = vectornormalize( var_3 - var_2 );
    var_5 = vectordot( var_4, var_1 );
    return var_5 < -0.1;
}

dog_bark( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "anml_dog_bark_attention_npc";

    self setanimrestart( %iw6_dog_attackidle_bark_add, 1, 0.1, 1 );
    maps\_utility::play_sound_on_entity( var_0 );
}

dog_pant_think()
{
    self notify( "stop_panting" );
    self endon( "stop_panting" );
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( self.run_overridesound ) && !isdefined( self.customidlesound ) && self.script != "dog_combat" )
            dog_pant();

        wait(randomfloatrange( 15, 25 ));
    }
}

dog_pant( var_0 )
{
    self endon( "stop_panting" );
    self endon( "stop_pant" );
    self endon( "death" );
    var_1 = self isdogbeingdriven() || isdefined( self.controlling_dog );
    var_2 = undefined;

    if ( self.script == "dog_stop" )
    {
        if ( var_1 )
            var_2 = "anml_dog_pants_med_plr";
        else
            var_2 = "anml_dog_pants_med";
    }
    else
    {
        if ( self.movemode == "walk" || isdefined( self.movementtype ) && ( self.movementtype == "walk_fast" || self.movementtype == "sniff" || self.movementtype == "sneak" ) )
            var_2 = "anml_dog_pants_med";
        else
            var_2 = "anml_dog_pants_fast";

        if ( var_1 )
            var_2 += "_plr";
    }

    maps\_utility::play_sound_on_entity( var_2 );
}

enable_dog_walk( var_0 )
{
    self.old_movementtype = self.movementtype;

    if ( isdefined( var_0 ) )
        self.movementtype = "walk_fast";
    else
        self.movementtype = "walk";
}

disable_dog_walk()
{
    self.movementtype = "run";
}
