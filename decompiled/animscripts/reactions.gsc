// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self endon( "killanimscript" );
    animscripts\utility::initialize( "reactions" );
    newenemysurprisedreaction();
}

#using_animtree("generic_human");

init_animset_reactions()
{
    var_0 = [];
    var_0["cover_stand"] = [ %stand_cover_reaction_a, %stand_cover_reaction_b ];
    var_0["cover_crouch"] = [ %stand_cover_reaction_a, %stand_cover_reaction_b ];
    var_0["cover_left"] = [ %stand_cover_reaction_a, %stand_cover_reaction_b ];
    var_0["cover_right"] = [ %stand_cover_reaction_a, %stand_cover_reaction_b ];
    anim.archetypes["soldier"]["cover_reactions"] = var_0;
    var_0 = [];
    var_0[0] = %run_wizby_a;
    var_0[1] = %run_wizby_b;
    anim.archetypes["soldier"]["running_react_to_bullets"] = var_0;
    anim.lastrunningreactanim = 0;
}

reactionscheckloop()
{
    thread bulletwhizbycheckloop();
}

canreactagain()
{
    return !isdefined( self.lastreacttime ) || gettime() - self.lastreacttime > 2000;
}

bulletwhizbyreaction()
{
    self endon( "killanimscript" );
    self.lastreacttime = gettime();
    self.a.movement = "stop";
    var_0 = isdefined( self.whizbyenemy ) && distancesquared( self.origin, self.whizbyenemy.origin ) < 160000;
    self _meth_818E( "gravity" );
    self _meth_818F( "face current" );

    if ( var_0 || common_scripts\utility::cointoss() )
    {
        self _meth_8142( %animscript_root, 0.1 );
        var_1 = [];

        if ( animscripts\utility::usingsmg() )
        {
            var_1[0] = %smg_exposed_idle_reacta;
            var_1[1] = %smg_exposed_idle_reactb;
            var_1[2] = %smg_exposed_idle_twitch;
            var_1[3] = %smg_exposed_idle_twitch_v4;
        }
        else
        {
            var_1[0] = %exposed_idle_reacta;
            var_1[1] = %exposed_idle_reactb;
            var_1[2] = %exposed_idle_twitch;
            var_1[3] = %exposed_idle_twitch_v4;
        }

        var_2 = var_1[randomint( var_1.size )];

        if ( var_0 )
            var_3 = 1 + randomfloat( 0.5 );
        else
            var_3 = 0.2 + randomfloat( 0.5 );

        self _meth_810D( "reactanim", var_2, 1, 0.1, 1 );
        animscripts\notetracks::donotetracksfortime( var_3, "reactanim" );
        self _meth_8142( %animscript_root, 0.1 );

        if ( !var_0 && self.stairsstate == "none" && !isdefined( self.disable_dive_whizby_react ) )
        {
            var_4 = 1 + randomfloat( 0.2 );
            var_5 = animscripts\utility::randomanimoftwo( %exposed_dive_grenade_b, %exposed_dive_grenade_f );
            self _meth_810D( "dive", var_5, 1, 0.1, var_4 );
            animscripts\shared::donotetracks( "dive" );
        }
    }
    else
    {
        wait(randomfloat( 0.2 ));
        var_4 = 1.2 + randomfloat( 0.3 );

        if ( self.a.pose == "stand" )
        {
            self _meth_8142( %animscript_root, 0.1 );
            self _meth_810D( "crouch", %exposed_stand_2_crouch, 1, 0.1, var_4 );
            animscripts\shared::donotetracks( "crouch" );
        }

        var_6 = anglestoforward( self.angles );

        if ( isdefined( self.whizbyenemy ) )
            var_7 = vectornormalize( self.whizbyenemy.origin - self.origin );
        else
            var_7 = var_6;

        if ( vectordot( var_7, var_6 ) > 0 )
        {
            var_8 = animscripts\utility::randomanimoftwo( %exposed_crouch_idle_twitch_v2, %exposed_crouch_idle_twitch_v3 );
            self _meth_8142( %animscript_root, 0.1 );
            self _meth_810D( "twitch", var_8, 1, 0.1, 1 );
            animscripts\shared::donotetracks( "twitch" );
        }
        else
        {
            var_9 = animscripts\utility::randomanimoftwo( %exposed_crouch_turn_180_left, %exposed_crouch_turn_180_right );
            self _meth_8142( %animscript_root, 0.1 );
            self _meth_810D( "turn", var_9, 1, 0.1, 1 );
            animscripts\shared::donotetracks( "turn" );
        }
    }

    self _meth_8142( %animscript_root, 0.1 );
    self.whizbyenemy = undefined;
    self _meth_818E( "normal" );
    self _meth_818F( "face default" );
}

bulletwhizbycheckloop()
{
    self endon( "killanimscript" );

    if ( isdefined( self.disablebulletwhizbyreaction ) )
        return;

    for (;;)
    {
        self waittill( "bulletwhizby", var_0 );

        if ( !isdefined( var_0.team ) || self.team == var_0.team )
            continue;

        if ( isdefined( self.covernode ) || isdefined( self.ambushnode ) )
            continue;

        if ( self.a.pose != "stand" )
            continue;

        if ( !canreactagain() )
            continue;

        self.whizbyenemy = var_0;
        self _meth_819A( ::bulletwhizbyreaction );
    }
}

clearlookatthread()
{
    self endon( "killanimscript" );
    wait 0.3;
    self _meth_81FF();
}

getnewenemyreactionanim()
{
    var_0 = undefined;

    if ( self _meth_8163() )
    {
        var_1 = animscripts\utility::lookupanimarray( "cover_reactions" );

        if ( isdefined( var_1[self.prevscript] ) )
        {
            var_2 = anglestoforward( self.node.angles );
            var_3 = vectornormalize( self.reactiontargetpos - self.origin );

            if ( vectordot( var_2, var_3 ) < -0.5 )
            {
                self _meth_818F( "face current" );
                var_4 = randomint( var_1[self.prevscript].size );
                var_0 = var_1[self.prevscript][var_4];
            }
        }
    }

    if ( !isdefined( var_0 ) )
    {
        var_5 = [];

        if ( animscripts\utility::usingsmg() )
        {
            var_5[0] = %smg_exposed_backpedal;
            var_5[1] = %smg_exposed_idle_reactb;
        }
        else if ( isdefined( self.animarchetype ) && self.animarchetype == "s1_soldier" )
        {
            var_5[0] = %s1_exposed_backpedal;
            var_5[1] = %s1_exposed_idle_alert_v5;
        }
        else
        {
            var_5[0] = %exposed_backpedal;
            var_5[1] = %exposed_idle_reactb;
        }

        if ( isdefined( self.enemy ) && distancesquared( self.enemy.origin, self.reactiontargetpos ) < 65536 )
            self _meth_818F( "face enemy" );
        else
            self _meth_818F( "face point", self.reactiontargetpos );

        if ( self.a.pose == "crouch" )
        {
            var_3 = vectornormalize( self.reactiontargetpos - self.origin );
            var_6 = anglestoforward( self.angles );

            if ( vectordot( var_6, var_3 ) < -0.5 )
            {
                self _meth_818F( "face current" );
                var_5[0] = %crouch_cover_reaction_a;
                var_5[1] = %crouch_cover_reaction_b;
            }
        }

        var_0 = var_5[randomint( var_5.size )];
    }

    return var_0;
}

stealthnewenemyreactanim()
{
    self _meth_8142( %animscript_root, 0.2 );

    if ( randomint( 4 ) < 3 )
    {
        self _meth_818F( "face enemy" );
        var_0 = %exposed_idle_reactb;

        if ( animscripts\utility::usingsmg() )
            var_0 = %smg_exposed_idle_reactb;

        self _meth_810D( "reactanim", var_0, 1, 0.2, 1 );
        var_1 = getanimlength( var_0 );
        animscripts\notetracks::donotetracksfortime( var_1 * 0.8, "reactanim" );
        self _meth_818F( "face current" );
    }
    else
    {
        self _meth_818F( "face enemy" );
        var_2 = %exposed_backpedal;
        var_3 = %exposed_backpedal_v2;

        if ( animscripts\utility::usingsmg() )
        {
            var_2 = %smg_exposed_backpedal;
            var_3 = %smg_exposed_backpedal_v2;
        }

        self _meth_810D( "reactanim", var_2, 1, 0.2, 1 );
        var_1 = getanimlength( var_2 );
        animscripts\notetracks::donotetracksfortime( var_1 * 0.8, "reactanim" );
        self _meth_818F( "face current" );
        self _meth_8142( %animscript_root, 0.2 );
        self _meth_810D( "reactanim", var_3, 1, 0.2, 1 );
        animscripts\shared::donotetracks( "reactanim" );
    }
}

newenemyreactionanim()
{
    self endon( "death" );
    self endon( "endNewEnemyReactionAnim" );
    self.lastreacttime = gettime();
    self.a.movement = "stop";
    self.playing_new_enemy_reaction_anim = 1;

    if ( isdefined( self._stealth ) && self.alertlevel != "combat" )
        stealthnewenemyreactanim();
    else
    {
        var_0 = getnewenemyreactionanim();
        self _meth_8142( %animscript_root, 0.2 );
        self _meth_810D( "reactanim", var_0, 1, 0.2, 1 );
        animscripts\shared::donotetracks( "reactanim" );
    }

    self notify( "newEnemyReactionDone" );
    self.playing_new_enemy_reaction_anim = undefined;
}

newenemysurprisedreaction()
{
    self endon( "death" );

    if ( isdefined( self.disablereactionanims ) )
        return;

    if ( !canreactagain() )
        return;

    if ( self.a.pose == "prone" || isdefined( self.a.onback ) )
        return;

    self _meth_818E( "gravity" );

    if ( isdefined( self.enemy ) )
        newenemyreactionanim();
}

end_script()
{
    if ( isdefined( self.playing_new_enemy_reaction_anim ) )
    {
        self notify( "newEnemyReactionDone" );
        self.playing_new_enemy_reaction_anim = undefined;
    }
}
