// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

#using_animtree("dog");

main()
{
    if ( isdefined( level.shark_functions ) )
    {
        if ( issubstr( self.model, "shark" ) )
        {
            self [[ level.shark_functions["pain"] ]]();
            return;
        }
    }

    self endon( "killanimscript" );

    if ( isdefined( self.enemy ) && isdefined( self.enemy.syncedmeleetarget ) && self.enemy.syncedmeleetarget == self && ( !isdefined( self.disablepain ) || !self.disablepain ) )
    {
        self unlink();
        self.enemy.syncedmeleetarget = undefined;
    }

    self animmode( "zonly_physics" );
    self clearanim( %body, 0.2 );

    if ( self.prevscript == "dog_stop" )
        var_0 = "idle_pain";
    else
        var_0 = "run_pain";

    self setflaggedanimrestart( "dog_pain_anim", getdogpainanim( var_0 ), 1, 0.2, 1 );

    if ( self isdogbeingdriven() )
        self playsound( "bullet_large_flesh" );
    else
        self playsound( "bullet_large_flesh_npc" );

    soundscripts\_snd::snd_message( "anml_doberman", "pain" );
    animscripts\shared::donotetracks( "dog_pain_anim" );
}

getdogpainanim( var_0 )
{
    var_1 = animscripts\utility::lookupdoganim( "reaction", var_0 );

    if ( isarray( var_1 ) )
        return var_1[randomint( var_1.size )];

    return var_1;
}

initdogarchetype_reaction()
{
    var_0 = [];
    var_0["flash_long"] = [ %iw6_dog_run_pain_4, %iw6_dog_run_pain_6 ];
    var_0["flash_short"] = %german_shepherd_run_flashbang_b;
    var_0["run_pain"] = [ %iw6_dog_run_pain_4, %iw6_dog_run_pain_6 ];
    var_0["idle_pain"] = [ %iw6_dog_alertidle_pain_4, %iw6_dog_alertidle_pain_6 ];
    anim.archetypes["dog"]["reaction"] = var_0;
}
