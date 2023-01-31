// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "s19_player", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_mig29" );
    maps\_vehicle::build_deathmodel( "vehicle_mig29_low" );
    maps\_vehicle::build_treadfx();
    level._effect["s19_engineeffect"] = loadfx( "vfx/map/baghdad/bagh_sentinel_jet_mainengines" );
    level._effect["s19_afterburner"] = loadfx( "fx/fire/jet_afterburner_ignite" );
    level._effect["s19_contrail"] = loadfx( "vfx/trail/jet_contrail_cheap" );
    maps\_vehicle::build_deathfx( "vfx/map/baghdad/bagh_aircraft_explosion_midair", undefined, "explo_metal_rand" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    var_3 = randomfloatrange( 0, 1 );
    maps\_vehicle::build_light( var_2, "wingtip_green", "tag_left_wingtip", "fx/misc/aircraft_light_wingtip_green", "running", var_3 );
    maps\_vehicle::build_light( var_2, "wingtip_red", "tag_right_wingtip", "fx/misc/aircraft_light_wingtip_red", "running", var_3 );
    maps\_vehicle::build_is_airplane();
    maps\_vehicle::build_death_jolt_delay( 9999 );
}

init_local()
{
    thread playengineeffects();
    thread fx_contrail_handler();
    thread landing_gear_up();
}

#using_animtree("vehicles");

landing_gear_up()
{
    self _meth_8115( #animtree );
    self _meth_814B( %mig_landing_gear_up );
}

playengineeffects()
{
    self endon( "death" );
    self endon( "stop_engineeffects" );
    maps\_utility::ent_flag_init( "engineeffects" );
    maps\_utility::ent_flag_set( "engineeffects" );
    var_0 = common_scripts\utility::getfx( "s19_engineeffect" );

    for (;;)
    {
        maps\_utility::ent_flag_wait( "engineeffects" );
        playfxontag( var_0, self, "tag_engine_left" );
        maps\_utility::ent_flag_waitopen( "engineeffects" );
        stopfxontag( var_0, self, "tag_engine_left" );
    }
}

playafterburner()
{
    playfxontag( level._effect["s19_afterburner"], self, "tag_engine_right" );
    playfxontag( level._effect["s19_afterburner"], self, "tag_engine_left" );
}

playcontrail()
{
    playfxontag( level._effect["s19_contrail"], self, "tag_right_wingtip" );
    playfxontag( level._effect["s19_contrail"], self, "tag_left_wingtip" );
}

stopcontrail()
{
    stopfxontag( level._effect["s19_contrail"], self, "tag_right_wingtip" );
    stopfxontag( level._effect["s19_contrail"], self, "tag_left_wingtip" );
}

fx_contrail_handler()
{
    level endon( "death" );
    var_0 = 45;
    var_1 = 0;

    while ( isdefined( self ) )
    {
        var_2 = self.angles;
        var_3 = var_2[0];
        var_4 = var_2[2];
        var_5 = 0;

        if ( var_4 > var_0 && var_4 < 360 - var_0 || var_4 < -1 * var_0 && var_4 > -1 * ( 360 - var_0 ) )
            var_5 = 1;

        if ( var_3 > var_0 && var_3 < 360 - var_0 || var_3 < -1 * var_0 && var_3 > -1 * ( 360 - var_0 ) )
            var_5 = 1;

        if ( var_5 && !var_1 )
        {
            playcontrail();
            var_1 = 1;
        }
        else if ( !var_5 && var_1 )
        {
            stopcontrail();
            var_1 = 0;
        }

        waitframe();
    }
}
