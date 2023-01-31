// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_0 = getarraykeys( level.anim_prop_models );

    foreach ( var_2 in var_0 )
    {
        var_3 = getarraykeys( level.anim_prop_models[var_2] );

        foreach ( var_5 in var_3 )
            map_restart( level.anim_prop_models[var_2][var_5] );
    }

    waittillframeend;
    level.init_animatedmodels = [];
    var_8 = getentarray( "animated_model", "targetname" );
    common_scripts\utility::array_thread( var_8, ::animatemodel );
    level.init_animatedmodels = undefined;
}

animatemodel()
{
    if ( isdefined( self.animation ) )
        var_0 = self.animation;
    else
    {
        var_1 = getarraykeys( level.anim_prop_models[self.model] );
        var_2 = var_1[randomint( var_1.size )];
        var_0 = level.anim_prop_models[self.model][var_2];
    }

    self _meth_8279( var_0 );
    self _meth_80E1();
}
