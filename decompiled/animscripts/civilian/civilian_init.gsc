// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    animscripts\init::main();
    _id_1DCF();
}

#using_animtree("generic_human");

_id_1DCF()
{
    self._id_0031 = 1;
    self._id_2AF2 = 1;
    self._id_2B0D = 1;
    self._id_6091 = 1;
    self._id_0B0D = 1;
    self _meth_818F( "face default" );
    self._id_00C8 = "no_cover";
    self _meth_81A3( 0 );
    self._id_0007._id_71CD = 1;

    if ( !isdefined( level._id_4DDB ) )
    {
        level._id_4DDB = 1;
        level._id_78A9["default_civilian"]["run_combat"][0] = %civilian_run_upright;
        level._id_78A9["default_civilian"]["run_hunched_combat"][0] = %civilian_run_hunched_a;
        level._id_78A9["default_civilian"]["run_hunched_combat"][1] = %civilian_run_hunched_c;
        level._id_78A9["default_civilian"]["run_hunched_combat"][2] = %civilian_run_hunched_flinch;
        level._id_78A9["default_civilian"]["run_noncombat"][0] = %civilian_walk_cool;
        var_0 = [];
        var_0[0] = 3;
        var_0[1] = 3;
        var_0[2] = 1;
        level._id_78A9["default_civilian"]["run_hunched_weights"] = common_scripts\utility::get_cumulative_weights( var_0 );
        var_0 = [];
        var_0[0] = 1;
        level._id_78A9["default_civilian"]["run_weights"] = common_scripts\utility::get_cumulative_weights( var_0 );
        level._id_78A9["default_civilian"]["idle_noncombat"][0] = %unarmed_cowerstand_idle;
        level._id_78A9["default_civilian"]["idle_combat"][0] = %casual_crouch_v2_idle;
        level._id_78A9["default_civilian"]["idle_combat"][1] = %unarmed_cowercrouch_idle_duck;
        anim._id_1E0F[0] = %unarmed_cowerstand_react;
        anim._id_1E0F[1] = %unarmed_cowercrouch_react_a;
        anim._id_1E0F[2] = %unarmed_cowercrouch_react_b;
    }

    var_1 = undefined;

    if ( isdefined( self._id_1DFD ) )
    {
        self._id_0C72 = self._id_1DFD;
        _id_0E09( self._id_1DFD );
        self._id_0026 = "noncombat";
        _id_8D2B();
    }
    else
    {
        self._id_0C72 = "default_civilian";
        self._id_0026 = "alert";
        _id_8CFE();
    }

    thread _id_1CF8();
    self._id_0136 = 0;
    animscripts\shared::_id_2F6A();
    self._id_780D = 0;
}

_id_0E09( var_0 )
{
    if ( isdefined( self._id_4718 ) )
        return;

    _id_4D94();
    var_1 = anim._id_1E13[var_0];

    if ( isdefined( var_1 ) )
    {
        self._id_0DF7 = var_1;
        self._id_0DF8 = "tag_inhand";
        self attach( self._id_0DF7, self._id_0DF8, 1 );
        self._id_4718 = 1;
    }
}

_id_2982()
{
    if ( isdefined( self._id_4718 ) )
    {
        self detach( self._id_0DF7, self._id_0DF8 );
        var_0 = spawn( "script_model", self gettagorigin( self._id_0DF8 ) );
        var_0.angles = self gettagangles( self._id_0DF8 );
        var_0 setmodel( self._id_0DF7 );
        var_0 _meth_82C2();
        var_0 thread _id_A010();
        self._id_4718 = undefined;
        self._id_0DF7 = undefined;
        self._id_0DF8 = undefined;
    }
}

_id_A010()
{
    wait 10;
    self delete();
}

_id_4D94()
{
    if ( isdefined( anim._id_1E13 ) )
        return;

    anim._id_1E13 = [];
    anim._id_1E13["civilian_briefcase_walk"] = "com_metal_briefcase";
    anim._id_1E13["civilian_crazy_walk"] = "electronics_pda";
    anim._id_1E13["civilian_cellphone_walk"] = "com_cellphone_on";
    anim._id_1E13["sit_lunch_A"] = "com_cellphone_on";
    anim._id_1E13["civilian_soda_walk"] = "ma_cup_single_closed";
    anim._id_1E13["civilian_paper_walk"] = "paper_memo";
    anim._id_1E13["civilian_coffee_walk"] = "cs_coffeemug02";
    anim._id_1E13["civilian_pda_walk"] = "electronics_pda";
    anim._id_1E13["reading1"] = "open_book";
    anim._id_1E13["reading2"] = "open_book";
    anim._id_1E13["texting_stand"] = "electronics_pda";
    anim._id_1E13["texting_sit"] = "electronics_pda";
    anim._id_1E13["smoking1"] = "prop_cigarette";
    anim._id_1E13["smoking2"] = "prop_cigarette";
}

_id_8D2B()
{
    self._id_04CB = 0.2;

    if ( isdefined( self._id_1DFD ) )
    {
        var_0 = %civilian_briefcase_walk_dodge_l;
        var_1 = %civilian_briefcase_walk_dodge_r;

        if ( isdefined( level._id_78A9[self._id_0C72]["dodge_left"] ) )
            var_0 = level._id_78A9[self._id_0C72]["dodge_left"];

        if ( isdefined( level._id_78A9[self._id_0C72]["dodge_right"] ) )
            var_1 = level._id_78A9[self._id_0C72]["dodge_right"];

        animscripts\move::_id_7F4D( var_0, var_1 );
    }

    if ( isdefined( level._id_78A9[self._id_0C72]["turn_left_90"] ) )
    {
        self._id_66F2 = animscripts\civilian\civilian_move::_id_1DDA;
        self._id_66F1 = 0.1;
        _id_A59A::_id_3101();
    }
    else
        _id_A59A::_id_2AE9();

    self._id_76AC = level._id_78A9[self._id_0C72]["run_noncombat"];
    self._id_A0FF = self._id_76AC;
    self._id_76AE = undefined;

    if ( self._id_0C72 == "default_civilian" )
    {
        self._id_76AB = level._id_78A9[self._id_0C72]["run_weights_noncombat"];
        self._id_A0FE = self._id_76AB;
    }
}

_id_8CFE()
{
    self notify( "combat" );
    animscripts\move::_id_1EE8();
    self._id_66F1 = undefined;
    _id_A59A::_id_3101();
    self._id_04CB = 0.3;
    var_0 = randomint( 3 ) < 1;

    if ( isdefined( self._id_398D ) )
        var_0 = 1;
    else if ( isdefined( self._id_398C ) )
        var_0 = 0;

    if ( var_0 )
    {
        self._id_66F2 = animscripts\civilian\civilian_move::_id_1DA5;
        self._id_76AC = level._id_78A9["default_civilian"]["run_combat"];
        self._id_76AB = level._id_78A9["default_civilian"]["run_weights"];
    }
    else
    {
        self._id_66F2 = animscripts\civilian\civilian_move::_id_1DA4;
        self._id_76AC = level._id_78A9["default_civilian"]["run_hunched_combat"];
        self._id_76AB = level._id_78A9["default_civilian"]["run_hunched_weights"];
    }

    self._id_76AE = [];
    self._id_76AE[0] = %run_react_stumble;
    self._id_A0FF = self._id_76AC;
    self._id_A0FE = self._id_76AB;
}

_id_1CF8()
{
    self endon( "death" );
    self endon( "disable_combat_state_check" );
    var_0 = self._id_0027 > 1;

    for (;;)
    {
        var_1 = self._id_0027 > 1;

        if ( var_0 && !var_1 )
            _id_8D2B();
        else if ( !var_0 && var_1 )
            _id_8CFE();

        var_0 = var_1;
        wait 0.05;
    }
}
