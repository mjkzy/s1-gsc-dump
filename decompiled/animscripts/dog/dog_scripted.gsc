// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("dog");

main()
{
    if ( isdefined( level.shark_functions ) )
    {
        if ( issubstr( self.model, "shark" ) )
        {
            self [[ level.shark_functions["scripted"] ]]();
            return;
        }
    }

    self endon( "death" );
    self notify( "killanimscript" );
    self.codescripted["root"] = %body;
    self endon( "end_sequence" );
    self _meth_8241( self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["animMode"], self.codescripted["root"], self.codescripted["goalTime"] );
    self.codescripted = undefined;

    if ( isdefined( self.deathstring_passed ) )
        self.deathstring = self.deathstring_passed;

    self waittill( "killanimscript" );
}

init( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( level.shark_functions ) )
    {
        if ( issubstr( self.model, "shark" ) )
        {
            self [[ level.shark_functions["scripted_init"] ]]( var_0, var_1, var_2, var_3, var_4, var_5 );
            return;
        }
    }

    self.codescripted["notifyName"] = var_0;
    self.codescripted["origin"] = var_1;
    self.codescripted["angles"] = var_2;
    self.codescripted["anim"] = var_3;

    if ( isdefined( var_4 ) )
        self.codescripted["animMode"] = var_4;
    else
        self.codescripted["animMode"] = "normal";

    if ( isdefined( var_5 ) )
        self.codescripted["root"] = var_5;
    else
        self.codescripted["root"] = %body;

    self.codescripted["goalTime"] = var_6;
}
