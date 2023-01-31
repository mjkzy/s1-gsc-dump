// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precacheitem( "foam_bomb" );
    precachemodel( "weapon_c4" );
    precachemodel( "weapon_c4_obj" );
    level.player thread place_foam_bomb();
    level.player.grenadetimers["foam_bomb"] = 5;
    thread handle_foam_behavior();
    level.c4_weaponname = "foam_bomb";
    level.spawnedfoamglobs = undefined;
}

playc4effects()
{
    self endon( "death" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "c4_light_blink" ), self, "tag_fx" );
}

place_foam_bomb()
{
    self endon( "death" );
    var_0 = getentarray( "foam_bomb_location", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 monitor_place_foam_bomb();
}

monitor_place_foam_bomb()
{
    var_0 = spawn( "script_model", self.origin );
    var_0 _meth_80B1( "weapon_c4_obj" );
    var_0.angles = self.angles;
    var_0 makeusable();
    var_0 _meth_80DB( "Press ^3 &&1 ^7to Plant Foam" );
    var_0 waittill( "trigger" );
    level.player _meth_830E( "foam_bomb" );
    level.player _meth_8308( 2, "weapon", "foam_bomb" );
    var_0 _meth_80B1( "weapon_c4" );
    var_0 playc4effects();
    level.player thread handle_detonator();
    level.player waittill( "detonate" );
    var_0 detonate_foam_grenade();
}

handle_detonator()
{
    var_0 = undefined;

    if ( !isdefined( self.old_weapon ) )
        self.old_weapon = self _meth_8311();

    var_1 = self _meth_830B();

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2] != level.c4_weaponname )
            continue;

        var_0 = var_1[var_2];
    }

    if ( !isdefined( var_0 ) )
    {
        self _meth_830E( level.c4_weaponname );
        self _meth_82F6( level.c4_weaponname, 0 );
        self _meth_8308( 2, "weapon", level.c4_weaponname );
    }

    _func_0D3( "actionSlotsHide", 1 );
    self _meth_8321();
    self _meth_831F();
    self _meth_82CB();
    self _meth_8130( 0 );
    self _meth_8315( level.c4_weaponname );
    self waittill( "detonate" );
    wait 0.15;
    self _meth_8322();
    self _meth_8320();
    self _meth_82CC();
    self _meth_8130( 1 );
    self _meth_8315( self.old_weapon );
    self _meth_830F( level.c4_weaponname );
    self waittill( "weapon_change" );
    wait 1;
    _func_0D3( "actionSlotsHide", 0 );
}

handle_foam_behavior()
{
    level endon( "missionfailed" );
}

delete_auto()
{
    if ( !isdefined( self ) )
        return;

    self delete();
}

detonate_foam_grenade( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.edge = common_scripts\utility::spawn_tag_origin();
    var_1.origin += ( 0, 0, 5 );
    var_2 = create_foam_matrix( var_0 );

    if ( isdefined( level.spawnedfoamglobs ) )
        common_scripts\utility::array_thread( level.spawnedfoamglobs, ::delete_auto );

    level.spawnedfoamglobs = [];
    var_2 = sortbydistance( var_2, var_1.origin );
    level notify( "foam_bomb_begin" );
    var_1 soundscripts\_snd::snd_message( "aud_detonate_foam_grenade" );
    var_3 = 1;
    var_4 = 1;
    var_5 = undefined;
    level notify( "foam_bomb_complete" );
}

expand_foam( var_0, var_1, var_2 )
{
    var_3 = randomintrange( 50, 55 );
    var_4 = distance( var_0, self.origin );
    var_5 = var_4 / var_3;
    var_6 = undefined;

    if ( var_5 <= 0 )
        var_5 = 0.1;

    self.neighbors = 0;

    foreach ( var_8 in level.foambombfoams )
    {
        if ( distance( self.origin, var_8 ) < 32 )
            self.neighbors++;
    }

    var_6 = spawn( "script_model", var_0 + ( 0, 0, -18 ) );
    var_6 _meth_82AE( self.origin, var_5, var_5 / 10, var_5 / 2 );
    level.spawnedfoamglobs[level.spawnedfoamglobs.size] = var_6;
    wait(var_5);
    level notify( "new_foam_glob", self.layer, self.ring, self );

    while ( isdefined( self.layer ) )
    {
        level waittill( "new_foam_glob", var_10, var_11 );

        if ( isdefined( var_6 ) && self.layer < var_10 - 1 && self.ring < var_11 - 1 && self.neighbors > 16 || isgroundfoam( self, var_11 ) )
        {
            var_6 delete();
            break;
        }

        waitframe();
    }
}

isgroundfoam( var_0, var_1 )
{
    if ( isdefined( var_0 ) && var_0.layer == 1 && var_0.ring < var_1 - 1 && var_0.neighbors > 8.0 )
        return 1;

    return 0;
}

debug_foam_tag()
{
    self endon( "death" );

    for (;;)
        waitframe();
}

create_foam_matrix( var_0 )
{
    var_1 = 960;

    if ( var_0 != 1 && var_0 < 1 )
        var_1 = 960 * var_0;
    else if ( var_0 > 1 )
        var_1 = 960 * ( var_0 * 0.01 );

    var_2 = [];
    var_3 = spawnstruct();
    var_3.origin = self.origin;
    var_2[var_2.size] = var_3;
    var_4 = common_scripts\utility::spawn_tag_origin();
    level.foambombfoams = [ var_3.origin ];
    var_5 = 16;
    var_6 = 20;
    var_4.angles = ( 0, randomfloatrange( -180, 180 ), 0 );

    for ( var_7 = 0; var_7 < 16; var_7++ )
    {
        var_8 = 0;
        var_9 = 0;
        var_10 = 1;
        var_11 = 0;

        for ( var_12 = var_1 / 8 - var_1 * 0.01 * var_7; var_8 < var_12; var_10++ )
        {
            var_13 = var_6 * var_10 * 2 * 3.14159;
            var_14 = 25.2;
            var_15 = 360 * var_14 / var_13;

            for ( var_16 = 0; var_16 < 360; var_16 += var_15 )
            {
                var_4.angles += ( 0, var_16, 0 );
                var_17 = var_4.origin + anglestoforward( var_4.angles ) * ( var_6 * var_10 );
                var_18 = bullettrace( var_4.origin, var_17, 0, undefined, 0 );

                if ( var_18["fraction"] >= 1 && isvalidfoamspace( var_17 ) )
                {
                    var_3 = spawnstruct();
                    var_3.origin = var_18["position"];

                    if ( var_10 > 1 )
                        var_3.origin += ( randomfloatrange( -6, 6 ), randomfloatrange( -6, 6 ), randomfloatrange( -6, 6 ) );

                    level.foambombfoams[level.foambombfoams.size] = var_3.origin;
                    var_8++;

                    if ( var_8 < var_12 * 0.4 )
                        var_3.delete_ok = 1;

                    var_3.ring = var_10;
                    var_3.layer = var_7;
                    var_2[var_2.size] = var_3;

                    if ( var_2.size > var_1 )
                        return var_2;

                    level notify( "new_foam_layer", var_7 );
                }

                if ( var_9 > 300 )
                {
                    waitframe();
                    var_9 = 0;
                    continue;
                }

                var_9++;
            }
        }

        if ( bullettracepassed( var_4.origin, var_4.origin + ( 0, 0, var_5 ), 0, undefined, 0 ) )
            var_4.origin += ( 0, 0, var_5 );
    }

    return var_2;
}

isvalidfoamspace( var_0 )
{
    return 1;
}
