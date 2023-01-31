// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("dog");

main()
{
    if ( isdefined( level.shark_functions ) )
    {
        if ( issubstr( self.model, "shark" ) )
        {
            self [[ level.shark_functions["death"] ]]();
            return;
        }
    }

    self endon( "killanimscript" );

    if ( isdefined( self.a.nodeath ) )
    {
        wait 1.1;
        var_0 = self _meth_813C();

        if ( isdefined( var_0 ) )
        {
            var_1 = common_scripts\utility::spawn_tag_origin();
            var_1.origin = self.origin;
            var_1.angles = self.angles;
            self _meth_804D( var_1 );
            var_1 _meth_82AE( var_0, 0.5 );
            wait 0.5;
            self _meth_804F();
            var_1 delete();
        }
        else
            wait 0.5;

        return;
    }

    self _meth_804F();

    if ( isdefined( self.enemy ) && isdefined( self.enemy.syncedmeleetarget ) && self.enemy.syncedmeleetarget == self )
        self.enemy.syncedmeleetarget = undefined;

    self _meth_8142( %body, 0.2 );
    var_2 = getdogdeathanim( "front" );

    if ( isdefined( self.deathanim ) )
        var_2 = self.deathanim;

    if ( isdefined( self.custom_deathsound ) )
        self playsound( self.custom_deathsound );
    else if ( self _meth_83CD() )
        soundscripts\_snd::snd_message( "anml_doberman", "death" );
    else
        soundscripts\_snd::snd_message( "anml_doberman", "death" );

    self _meth_8113( "dog_anim", var_2, 1, 0.2, 1 );
    animscripts\shared::donotetracks( "dog_anim" );
}

getdogdeathanim( var_0 )
{
    var_1 = animscripts\utility::lookupdoganim( "death", var_0 );

    if ( isarray( var_1 ) )
        return var_1[randomint( var_1.size )];

    return var_1;
}

initdogarchetype_death()
{
    var_0 = [];
    var_0["front"] = [ %iw6_dog_death_4, %iw6_dog_death_6 ];
    anim.archetypes["dog"]["death"] = var_0;
}
