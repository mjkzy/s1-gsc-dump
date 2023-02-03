// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    if ( self.canjumppath )
    {
        var_0 = self getnegotiationstartnode();

        switch ( var_0.script_noteworthy )
        {
            case "boost_jump_128_across_128_down_32_railing":
                rocket_jump_human_railing( %boost_jump_128_across_128_down_32_railing, 1 );
                break;
            case "boost_jump_128_across_140_down_32_railing":
                rocket_jump_human_railing( %boost_jump_128_across_140_down_32_railing, 1 );
                break;
            case "boost_jump_128_across_196_down_32_railing":
                rocket_jump_human_railing( %boost_jump_128_across_196_down_32_railing, 1 );
                break;
            case "boost_jump_128_across_256_down_32_railing":
                rocket_jump_human_railing( %boost_jump_128_across_256_down_32_railing, 1 );
                break;
            case "boost_jump_256_across_128_down_32_railing":
                rocket_jump_human_railing( %boost_jump_256_across_128_down_32_railing, 1 );
                break;
            case "boost_jump_256_across_140_down_32_railing":
                rocket_jump_human_railing( %boost_jump_256_across_140_down_32_railing, 1 );
                break;
            case "boost_jump_256_across_196_down_32_railing":
                rocket_jump_human_railing( %boost_jump_256_across_196_down_32_railing, 1 );
                break;
            case "boost_jump_256_across_256_down_32_railing":
                rocket_jump_human_railing( %boost_jump_256_across_256_down_32_railing, 1 );
                break;
            case "boost_jump_128_across_128_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_128_across_128_up_32_railing, 1 );
                break;
            case "boost_jump_128_across_140_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_128_across_140_up_32_railing, 1 );
                break;
            case "boost_jump_128_across_196_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_128_across_196_up_32_railing, 1 );
                break;
            case "boost_jump_128_across_256_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_128_across_256_up_32_railing, 1 );
                break;
            case "boost_jump_256_across_128_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_256_across_128_up_32_railing, 1 );
                break;
            case "boost_jump_256_across_140_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_256_across_140_up_32_railing, 1 );
                break;
            case "boost_jump_256_across_196_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_256_across_196_up_32_railing, 1 );
                break;
            case "boost_jump_256_across_256_up_32_railing":
                animscripts\traverse\boost::rocket_jump_human( %boost_jump_256_across_256_up_32_railing, 1 );
                break;
            default:
        }
    }
}

rocket_jump_human_railing( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 32;

    var_3 = [];
    var_3["traverseAnim"] = var_0;
    var_3["traverseNotetrackFunc"] = animscripts\traverse\boost::newhandletraversenotetracks;
    var_3["traverseHeight"] = 32.0;
    animscripts\traverse\shared::dotraverse( var_3 );

    if ( isdefined( self ) && isalive( self ) && isdefined( var_1 ) && var_1 )
    {
        soundscripts\_snd::snd_message( "boost_land_npc" );
        self setflaggedanimknoballrestart( "boostJumpLand", %boost_jump_land_2_run_b, %body, 1, 0.2, 1 );
        animscripts\shared::donotetracks( "boostJumpLand", animscripts\traverse\boost::newhandletraversenotetracks );
    }
}
