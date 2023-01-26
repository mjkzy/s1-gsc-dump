main()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    model_keys = getarraykeys( level.anim_prop_models );

    foreach ( model_key in model_keys )
    {
        anim_keys = getarraykeys( level.anim_prop_models[model_key] );

        foreach ( anim_key in anim_keys )
            map_restart( level.anim_prop_models[model_key][anim_key] );
    }

    waittillframeend;
    level.init_animatedmodels = [];
    animated_models = getentarray( "animated_model", "targetname" );
    common_scripts\utility::array_thread( animated_models, ::animateModel );
    level.init_animatedmodels = undefined;
}

animateModel()
{
    keys = getarraykeys( level.anim_prop_models[self.model] );
    animkey = keys[randomint( keys.size )];
    anim = level.anim_prop_models[self.model][animkey];

    self scriptmodelplayanim( anim );
    self willneverchange();
}
