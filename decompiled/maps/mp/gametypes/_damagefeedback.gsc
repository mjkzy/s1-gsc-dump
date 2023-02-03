// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{

}

updatedamagefeedback( var_0, var_1 )
{
    if ( !isplayer( self ) || !isdefined( var_0 ) )
        return;

    switch ( var_0 )
    {
        case "scavenger":
            self playlocalsound( "scavenger_pack_pickup" );

            if ( !level.hardcoremode )
                setdamagefeedbackclientomnvar( var_0 );

            break;
        case "hitspecialarmor":
            setdamagefeedbackclientomnvar( "hitspecialarmor" );
            break;
        case "hitjuggernaut":
        case "hitlightarmor":
        case "hitblastshield":
            self playlocalsound( "mp_hit_armor" );
            setdamagefeedbackclientomnvar( var_0 );
            break;
        case "mp_solar":
            if ( !isdefined( self.shouldloopdamagefeedback ) )
            {
                if ( isdefined( level.mapkillstreakdamagefeedbacksound ) )
                    self thread [[ level.mapkillstreakdamagefeedbacksound ]]();
            }
            else
                self.damagefeedbacktimer = 10;

            break;
        case "laser":
            if ( isdefined( level.sentrygun ) )
            {
                if ( !isdefined( self.shouldloopdamagefeedback ) )
                {
                    if ( isdefined( level.mapkillstreakdamagefeedbacksound ) )
                        self thread [[ level.mapkillstreakdamagefeedbacksound ]]( level.sentrygun );
                }
            }

            break;
        case "headshot":
            self playlocalsound( "mp_hit_headshot" );
            setdamagefeedbackclientomnvar( "headshot" );
            break;
        case "hitmorehealth":
            self playlocalsound( "mp_hit_armor" );
            setdamagefeedbackclientomnvar( "hitmorehealth" );
            break;
        case "killshot":
            self playlocalsound( "mp_hit_kill" );
            setdamagefeedbackclientomnvar( "killshot" );
            break;
        case "killshot_headshot":
            self playlocalsound( "mp_hit_kill_headshot" );
            setdamagefeedbackclientomnvar( "killshot_headshot" );
            break;
        case "nosound":
            setdamagefeedbackclientomnvar( "standard" );
            break;
        case "none":
            break;
        default:
            self playlocalsound( "mp_hit_default" );
            setdamagefeedbackclientomnvar( "standard" );
            break;
    }
}

setdamagefeedbackclientomnvar( var_0 )
{
    var_1 = gettime();

    if ( isdefined( self.damagefeedbacktime ) )
        var_2 = self.damagefeedbacktime;
    else
        var_2 = 0;

    if ( var_1 - var_2 < 300 && self getclientomnvar( "damage_feedback" ) == var_0 )
        return;

    self.damagefeedbacktime = var_1;
    self setclientomnvar( "damage_feedback", var_0 );
}
