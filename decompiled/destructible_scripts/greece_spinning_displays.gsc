// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    var_0 = spawnstruct();
    var_0.cardfx = loadfx( "vfx/destructible/greece_spinning_display_flying_cards_01" );
    init_displays( var_0 );
}

get_num_card_tags( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "greece_spinning_display_stand_01":
            var_1 = 14;
            break;
        case "greece_spinning_display_stand_02":
            var_1 = 43;
            break;
    }

    return var_1;
}

get_num_visible_card_tags()
{
    var_0 = 0;

    for ( var_1 = 0; var_1 < self.numcardtags; var_1++ )
    {
        if ( self.cardtagvisible[var_1] )
            var_0++;
    }

    return var_0;
}

#using_animtree("destructibles");

init_displays( var_0 )
{
    var_0.displays = getentarray( "spinningDisplayStand", "targetname" );

    if ( !isdefined( var_0.displays ) )
        return;

    if ( var_0.displays.size == 0 )
        return;

    for ( var_1 = 0; var_1 < var_0.displays.size; var_1++ )
    {
        var_2 = var_0.displays[var_1];
        var_2 init_card_tags();

        if ( !isdefined( var_2.origin ) )
            var_2.origin = ( 0, 0, 0 );

        var_2 _meth_8115( #animtree );
        var_2 _meth_82C0( 1 );
        var_2.displayhealth = 50;
        var_2 thread display_update( var_0 );
    }
}

init_card_tags()
{
    self.numcardtags = get_num_card_tags( self.model );
    self.cardtagvisible = [];
    self.cardtagnames = [];

    for ( var_0 = 0; var_0 < self.numcardtags; var_0++ )
    {
        self.cardtagnames[self.cardtagnames.size] = "tag_card_" + ( var_0 + 1 );
        self.cardtagvisible[self.cardtagvisible.size] = 1;
    }
}

get_spin_snd_alias( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "greece_spinning_display_stand_01":
            var_1 = "postcard_carousel_spin_sm_01";
            break;
        case "greece_spinning_display_stand_02":
            var_1 = "postcard_carousel_spin_lrg_01";
            break;
    }

    return var_1;
}

get_crash_snd_alias( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "greece_spinning_display_stand_01":
            var_1 = "postcard_carousel_crash_sm_01";
            break;
        case "greece_spinning_display_stand_02":
            var_1 = "postcard_carousel_crash_lrg_01";
            break;
    }

    return var_1;
}

display_update( var_0 )
{
    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5 );
        var_6 = var_4 - self.origin;
        var_6 = vectornormalize( ( var_6[0], var_6[1], 0 ) );
        var_7 = vectorcross( var_6, ( 0, 0, 1 ) );
        var_8 = vectornormalize( ( var_3[0], var_3[1], 0 ) );
        var_9 = vectordot( var_7, var_8 );
        var_10 = %greece_spinning_display_01_spin_ccw;

        if ( var_9 > 0 )
            var_10 = %greece_spinning_display_01_spin_cw;

        thread maps\_utility::play_sound_on_entity( get_spin_snd_alias( self.model ) );
        var_11 = getanimlength( var_10 );
        self _meth_8145( var_10, 1.0, 0.05 );
        var_12 = get_num_visible_card_tags();

        if ( var_12 == 0 )
        {
            self.displayhealth -= var_1;

            if ( self.displayhealth <= 0 )
            {
                self _meth_82C2( var_4, var_3 * var_1 * 0.75 );
                thread maps\_utility::play_sound_on_entity( get_crash_snd_alias( self.model ) );
                return;
            }
        }
        else
        {
            var_13 = 0;

            for ( var_14 = 0; var_14 < self.numcardtags; var_14++ )
            {
                if ( !self.cardtagvisible[var_14] )
                    continue;

                if ( var_12 <= self.numcardtags * 0.25 || randomfloat( 1.0 ) <= 0.5 )
                {
                    playfxontag( var_0.cardfx, self, self.cardtagnames[var_14] );
                    wait 0.05;
                    self _meth_8048( self.cardtagnames[var_14] );
                    self.cardtagvisible[var_14] = 0;
                    var_13 = 1;
                }
            }

            if ( var_13 )
                thread maps\_utility::play_sound_on_entity( "postcard_debris_scatter_01" );
        }

        wait(var_11 * 0.3);
    }
}
