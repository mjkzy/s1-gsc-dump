// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_3F8C( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
        return level._id_241A[var_0];

    var_1 = [];

    foreach ( var_3 in level._id_2417 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        if ( var_3.v["type"] != "exploder" )
            continue;

        if ( !isdefined( var_3.v["exploder"] ) )
            continue;

        if ( var_3.v["exploder"] == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_8149( var_0 )
{
    var_1 = var_0.script_exploder;

    if ( !isdefined( level._id_353A[var_1] ) )
        level._id_353A[var_1] = [];

    var_2 = var_0.targetname;

    if ( !isdefined( var_2 ) )
        var_2 = "";

    level._id_353A[var_1][level._id_353A[var_1].size] = var_0;

    if ( _id_3530( var_0 ) )
    {
        var_0 hide();
        return;
    }

    if ( _id_352F( var_0 ) )
    {
        var_0 hide();
        var_0 notsolid();

        if ( isdefined( var_0._id_03DB ) && var_0._id_03DB & 1 )
        {
            if ( isdefined( var_0._id_799B ) )
                var_0 connectpaths();
        }

        return;
    }

    if ( _id_352E( var_0 ) )
    {
        var_0 hide();
        var_0 notsolid();

        if ( isdefined( var_0._id_03DB ) && var_0._id_03DB & 1 )
            var_0 connectpaths();

        return;
    }
}

_id_830D()
{
    level._id_353A = [];
    var_0 = getentarray( "script_brushmodel", "classname" );
    var_1 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_0[var_0.size] = var_1[var_2];

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4._id_7AA0 ) )
            var_4.script_exploder = var_4._id_7AA0;

        if ( isdefined( var_4._id_59D3 ) )
            continue;

        if ( isdefined( var_4.script_exploder ) )
            _id_8149( var_4 );
    }

    var_6 = [];
    var_7 = getentarray( "script_brushmodel", "classname" );

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( isdefined( var_7[var_2]._id_7AA0 ) )
            var_7[var_2].script_exploder = var_7[var_2]._id_7AA0;

        if ( isdefined( var_7[var_2].script_exploder ) )
            var_6[var_6.size] = var_7[var_2];
    }

    var_7 = getentarray( "script_model", "classname" );

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( isdefined( var_7[var_2]._id_7AA0 ) )
            var_7[var_2].script_exploder = var_7[var_2]._id_7AA0;

        if ( isdefined( var_7[var_2].script_exploder ) )
            var_6[var_6.size] = var_7[var_2];
    }

    var_7 = getentarray( "script_origin", "classname" );

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( isdefined( var_7[var_2]._id_7AA0 ) )
            var_7[var_2].script_exploder = var_7[var_2]._id_7AA0;

        if ( isdefined( var_7[var_2].script_exploder ) )
            var_6[var_6.size] = var_7[var_2];
    }

    var_7 = getentarray( "item_health", "classname" );

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( isdefined( var_7[var_2]._id_7AA0 ) )
            var_7[var_2].script_exploder = var_7[var_2]._id_7AA0;

        if ( isdefined( var_7[var_2].script_exploder ) )
            var_6[var_6.size] = var_7[var_2];
    }

    var_7 = level.struct;

    for ( var_2 = 0; var_2 < var_7.size; var_2++ )
    {
        if ( !isdefined( var_7[var_2] ) )
            continue;

        if ( isdefined( var_7[var_2]._id_7AA0 ) )
            var_7[var_2].script_exploder = var_7[var_2]._id_7AA0;

        if ( isdefined( var_7[var_2].script_exploder ) )
        {
            if ( !isdefined( var_7[var_2].angles ) )
                var_7[var_2].angles = ( 0.0, 0.0, 0.0 );

            var_6[var_6.size] = var_7[var_2];
        }
    }

    if ( !isdefined( level._id_2417 ) )
        level._id_2417 = [];

    var_8 = [];
    var_8["exploderchunk visible"] = 1;
    var_8["exploderchunk"] = 1;
    var_8["exploder"] = 1;
    thread _id_80FD();

    for ( var_2 = 0; var_2 < var_6.size; var_2++ )
    {
        var_9 = var_6[var_2];
        var_4 = common_scripts\utility::createexploder( var_9._id_79EC );
        var_4.v = [];
        var_4.v["origin"] = var_9.origin;
        var_4.v["angles"] = var_9.angles;
        var_4.v["delay"] = var_9.script_delay;
        var_4.v["delay_post"] = var_9._id_798A;
        var_4.v["firefx"] = var_9._id_79C6;
        var_4.v["firefxdelay"] = var_9._id_79C7;
        var_4.v["firefxsound"] = var_9._id_79C8;
        var_4.v["firefxtimeout"] = var_9._id_79C9;
        var_4.v["earthquake"] = var_9._id_79B0;
        var_4.v["rumble"] = var_9._id_7AB5;
        var_4.v["damage"] = var_9._id_797C;
        var_4.v["damage_radius"] = var_9._id_7AAC;
        var_4.v["soundalias"] = var_9._id_7AC5;
        var_4.v["repeat"] = var_9._id_7AB0;
        var_4.v["delay_min"] = var_9._id_7989;
        var_4.v["delay_max"] = var_9._id_7988;
        var_4.v["target"] = var_9.target;
        var_4.v["ender"] = var_9._id_79B3;
        var_4.v["physics"] = var_9._id_7A9A;
        var_4.v["type"] = "exploder";

        if ( !isdefined( var_9._id_79EC ) )
            var_4.v["fxid"] = "No FX";
        else
            var_4.v["fxid"] = var_9._id_79EC;

        var_4.v["exploder"] = var_9.script_exploder;

        if ( isdefined( level._id_241A ) )
        {
            var_10 = level._id_241A[var_4.v["exploder"]];

            if ( !isdefined( var_10 ) )
                var_10 = [];

            var_10[var_10.size] = var_4;
            level._id_241A[var_4.v["exploder"]] = var_10;
        }

        if ( !isdefined( var_4.v["delay"] ) )
            var_4.v["delay"] = 0;

        if ( isdefined( var_9.target ) )
        {
            var_11 = getentarray( var_4.v["target"], "targetname" )[0];

            if ( isdefined( var_11 ) )
            {
                var_12 = var_11.origin;
                var_4.v["angles"] = vectortoangles( var_12 - var_4.v["origin"] );
            }
            else
            {
                var_11 = common_scripts\utility::get_target_ent( var_4.v["target"] );

                if ( isdefined( var_11 ) )
                {
                    var_12 = var_11.origin;
                    var_4.v["angles"] = vectortoangles( var_12 - var_4.v["origin"] );
                }
            }
        }

        if ( !isdefined( var_9.code_classname ) )
        {
            var_4.model = var_9;

            if ( isdefined( var_4.model._id_7A37 ) )
                precachemodel( var_4.model._id_7A37 );
        }
        else if ( var_9.code_classname == "script_brushmodel" || isdefined( var_9.model ) )
        {
            var_4.model = var_9;
            var_4.model._id_2B33 = var_9._id_799B;
        }

        if ( isdefined( var_9.targetname ) && isdefined( var_8[var_9.targetname] ) )
            var_4.v["exploder_type"] = var_9.targetname;
        else
            var_4.v["exploder_type"] = "normal";

        if ( isdefined( var_9._id_59D3 ) )
        {
            var_4.v["masked_exploder"] = var_9.model;
            var_4.v["masked_exploder_spawnflags"] = var_9._id_03DB;
            var_4.v["masked_exploder_script_disconnectpaths"] = var_9._id_799B;
            var_9 delete();
        }

        var_4 common_scripts\_createfx::_id_6E6A();
    }
}

_id_80FD()
{
    waittillframeend;
    waittillframeend;
    waittillframeend;
    var_0 = [];

    foreach ( var_2 in level._id_2417 )
    {
        if ( var_2.v["type"] != "exploder" )
            continue;

        var_3 = var_2.v["flag"];

        if ( !isdefined( var_3 ) )
            continue;

        if ( var_3 == "nil" )
            var_2.v["flag"] = undefined;

        var_0[var_3] = 1;
    }

    foreach ( var_7, var_6 in var_0 )
        thread _id_352C( var_7 );
}

_id_352C( var_0 )
{
    if ( !common_scripts\utility::flag_exist( var_0 ) )
        common_scripts\utility::flag_init( var_0 );

    common_scripts\utility::flag_wait( var_0 );

    foreach ( var_2 in level._id_2417 )
    {
        if ( var_2.v["type"] != "exploder" )
            continue;

        var_3 = var_2.v["flag"];

        if ( !isdefined( var_3 ) )
            continue;

        if ( var_3 != var_0 )
            continue;

        var_2 common_scripts\utility::activate_individual_exploder();
    }
}

_id_352F( var_0 )
{
    return isdefined( var_0.targetname ) && var_0.targetname == "exploder";
}

_id_3530( var_0 )
{
    return var_0.model == "fx" && ( !isdefined( var_0.targetname ) || var_0.targetname != "exploderchunk" );
}

_id_352E( var_0 )
{
    return isdefined( var_0.targetname ) && var_0.targetname == "exploderchunk";
}

_id_84C9( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
    {
        var_1 = level._id_241A[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( !_id_3530( var_3.model ) && !_id_352F( var_3.model ) && !_id_352E( var_3.model ) )
                    var_3.model show();

                if ( isdefined( var_3._id_1820 ) )
                    var_3.model show();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._id_2417.size; var_5++ )
        {
            var_3 = level._id_2417[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3.v["exploder"] ) )
                continue;

            if ( var_3.v["exploder"] + "" != var_0 )
                continue;

            if ( isdefined( var_3.model ) )
            {
                if ( !_id_3530( var_3.model ) && !_id_352F( var_3.model ) && !_id_352E( var_3.model ) )
                    var_3.model show();

                if ( isdefined( var_3._id_1820 ) )
                    var_3.model show();
            }
        }
    }
}

_id_8E79( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
    {
        var_1 = level._id_241A[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( !isdefined( var_3._id_5878 ) )
                    continue;

                var_3._id_5878 delete();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._id_2417.size; var_5++ )
        {
            var_3 = level._id_2417[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3.v["exploder"] ) )
                continue;

            if ( var_3.v["exploder"] + "" != var_0 )
                continue;

            if ( !isdefined( var_3._id_5878 ) )
                continue;

            var_3._id_5878 delete();
        }
    }
}

_id_3D5E( var_0 )
{
    var_0 += "";
    var_1 = [];

    if ( isdefined( level._id_241A ) )
    {
        var_2 = level._id_241A[var_0];

        if ( isdefined( var_2 ) )
            var_1 = var_2;
    }
    else
    {
        foreach ( var_4 in level._id_2417 )
        {
            if ( var_4.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_4.v["exploder"] ) )
                continue;

            if ( var_4.v["exploder"] + "" != var_0 )
                continue;

            var_1[var_1.size] = var_4;
        }
    }

    return var_1;
}

_id_484D( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
    {
        var_1 = level._id_241A[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( isdefined( var_3.model ) )
                    var_3.model hide();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._id_2417.size; var_5++ )
        {
            var_3 = level._id_2417[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3.v["exploder"] ) )
                continue;

            if ( var_3.v["exploder"] + "" != var_0 )
                continue;

            if ( isdefined( var_3.model ) )
                var_3.model hide();
        }
    }
}

_id_280D( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
    {
        var_1 = level._id_241A[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( isdefined( var_3.model ) )
                    var_3.model delete();
            }
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._id_2417.size; var_5++ )
        {
            var_3 = level._id_2417[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3.v["exploder"] ) )
                continue;

            if ( var_3.v["exploder"] + "" != var_0 )
                continue;

            if ( isdefined( var_3.model ) )
                var_3.model delete();
        }
    }

    level notify( "killexplodertridgers" + var_0 );
}

_id_3529()
{
    if ( isdefined( self.v["delay"] ) )
        var_0 = self.v["delay"];
    else
        var_0 = 0;

    if ( isdefined( self.v["damage_radius"] ) )
        var_1 = self.v["damage_radius"];
    else
        var_1 = 128;

    var_2 = self.v["damage"];
    var_3 = self.v["origin"];
    wait(var_0);

    if ( isdefined( level._id_254E ) )
        [[ level._id_254E ]]( var_3, var_1, var_2 );
    else
        radiusdamage( var_3, var_1, var_2, var_2 );
}

activate_individual_exploder_proc()
{
    if ( isdefined( self.v["firefx"] ) )
        thread _id_37AB();

    if ( isdefined( self.v["fxid"] ) && self.v["fxid"] != "No FX" )
        thread _id_1AD3();
    else if ( isdefined( self.v["soundalias"] ) && self.v["soundalias"] != "nil" )
        thread _id_8896();

    if ( isdefined( self.v["loopsound"] ) && self.v["loopsound"] != "nil" )
        thread _id_301B();

    if ( isdefined( self.v["damage"] ) )
        thread _id_3529();

    if ( isdefined( self.v["earthquake"] ) )
        thread _id_352B();

    if ( isdefined( self.v["rumble"] ) )
        thread _id_3534();

    if ( self.v["exploder_type"] == "exploder" )
        thread _id_181F();
    else if ( self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible" )
        thread _id_1821();
    else
        thread _id_181E();
}

_id_181E()
{
    var_0 = self.v["exploder"];

    if ( isdefined( self.v["delay"] ) && self.v["delay"] >= 0 )
        wait(self.v["delay"]);
    else
        wait 0.05;

    if ( !isdefined( self.model ) )
        return;

    if ( isdefined( self.model.classname ) )
    {
        if ( common_scripts\utility::issp() && self.model._id_03DB & 1 )
            self.model call [[ level._id_214E ]]();
    }

    if ( level.createfx_enabled )
    {
        if ( isdefined( self._id_3525 ) )
            return;

        self._id_3525 = 1;
        self.model hide();
        self.model notsolid();
        wait 3;
        self._id_3525 = undefined;
        self.model show();
        self.model solid();
        return;
    }

    if ( !isdefined( self.v["fxid"] ) || self.v["fxid"] == "No FX" )
        self.v["exploder"] = undefined;

    waittillframeend;

    if ( isdefined( self.model ) && isdefined( self.model.classname ) )
        self.model delete();
}

_id_1821()
{
    if ( isdefined( self.v["delay"] ) )
        wait(self.v["delay"]);

    var_0 = undefined;

    if ( isdefined( self.v["target"] ) )
        var_0 = common_scripts\utility::get_target_ent( self.v["target"] );

    if ( !isdefined( var_0 ) )
    {
        self.model delete();
        return;
    }

    self.model show();

    if ( isdefined( self.v["delay_post"] ) )
        wait(self.v["delay_post"]);

    var_1 = self.v["origin"];
    var_2 = self.v["angles"];
    var_3 = var_0.origin;
    var_4 = var_3 - self.v["origin"];
    var_5 = var_4[0];
    var_6 = var_4[1];
    var_7 = var_4[2];
    var_8 = isdefined( self.v["physics"] );

    if ( var_8 )
    {
        var_9 = undefined;

        if ( isdefined( var_0.target ) )
            var_9 = var_0 common_scripts\utility::get_target_ent();

        if ( !isdefined( var_9 ) )
        {
            var_10 = var_1;
            var_11 = var_0.origin;
        }
        else
        {
            var_10 = var_0.origin;
            var_11 = ( var_9.origin - var_0.origin ) * self.v["physics"];
        }

        self.model _meth_82C2( var_10, var_11 );
        return;
    }
    else
    {
        self.model rotatevelocity( ( var_5, var_6, var_7 ), 12 );
        self.model _meth_82B2( ( var_5, var_6, var_7 ), 12 );
    }

    if ( level.createfx_enabled )
    {
        if ( isdefined( self._id_3525 ) )
            return;

        self._id_3525 = 1;
        wait 3;
        self._id_3525 = undefined;
        self.v["origin"] = var_1;
        self.v["angles"] = var_2;
        self.model hide();
        return;
    }

    self.v["exploder"] = undefined;
    wait 6;
    self.model delete();
}

_id_181F()
{
    if ( isdefined( self.v["delay"] ) )
        wait(self.v["delay"]);

    if ( !isdefined( self.model._id_7A37 ) )
    {
        self.model show();
        self.model solid();
    }
    else
    {
        var_0 = self.model common_scripts\utility::spawn_tag_origin();

        if ( isdefined( self.model.script_linkname ) )
            var_0.script_linkname = self.model.script_linkname;

        var_0 setmodel( self.model._id_7A37 );
        var_0 show();
    }

    self._id_1820 = 1;

    if ( common_scripts\utility::issp() && !isdefined( self.model._id_7A37 ) && self.model._id_03DB & 1 )
    {
        if ( !isdefined( self.model._id_2B33 ) )
            self.model call [[ level._id_214E ]]();
        else
            self.model call [[ level._id_2B38 ]]();
    }

    if ( level.createfx_enabled )
    {
        if ( isdefined( self._id_3525 ) )
            return;

        self._id_3525 = 1;
        wait 3;
        self._id_3525 = undefined;

        if ( !isdefined( self.model._id_7A37 ) )
        {
            self.model hide();
            self.model notsolid();
        }
    }
}

_id_3534()
{
    if ( !common_scripts\utility::issp() )
        return;

    _id_352A();
    level.player playrumbleonentity( self.v["rumble"] );
}

_id_352A()
{
    if ( !isdefined( self.v["delay"] ) )
        self.v["delay"] = 0;

    var_0 = self.v["delay"];
    var_1 = self.v["delay"] + 0.001;

    if ( isdefined( self.v["delay_min"] ) )
        var_0 = self.v["delay_min"];

    if ( isdefined( self.v["delay_max"] ) )
        var_1 = self.v["delay_max"];

    if ( var_0 > 0 )
        wait(randomfloatrange( var_0, var_1 ));
}

_id_301B()
{
    if ( isdefined( self.loopsound_ent ) )
        self.loopsound_ent delete();

    var_0 = self.v["origin"];
    var_1 = self.v["loopsound"];
    _id_352A();
    self.loopsound_ent = common_scripts\utility::play_loopsound_in_space( var_1, var_0 );
}

_id_8896()
{
    _id_301C();
}

_id_301C()
{
    var_0 = self.v["origin"];
    var_1 = self.v["soundalias"];
    _id_352A();
    common_scripts\utility::play_sound_in_space( var_1, var_0 );
}

_id_352B()
{
    _id_352A();
    common_scripts\utility::do_earthquake( self.v["earthquake"], self.v["origin"] );
}

_id_3533()
{
    if ( !isdefined( self.v["soundalias"] ) || self.v["soundalias"] == "nil" )
        return;

    common_scripts\utility::play_sound_in_space( self.v["soundalias"], self.v["origin"] );
}

_id_37AB()
{
    var_0 = self.v["forward"];
    var_1 = self.v["up"];
    var_2 = undefined;
    var_3 = self.v["firefxsound"];
    var_4 = self.v["origin"];
    var_5 = self.v["firefx"];
    var_6 = self.v["ender"];

    if ( !isdefined( var_6 ) )
        var_6 = "createfx_effectStopper";

    var_7 = 0.5;

    if ( isdefined( self.v["firefxdelay"] ) )
        var_7 = self.v["firefxdelay"];

    _id_352A();

    if ( isdefined( var_3 ) )
        common_scripts\utility::loop_fx_sound_with_angles( var_3, var_4, ( 0.0, 0.0, 0.0 ), 1, var_6 );

    playfx( level._effect[var_5], self.v["origin"], var_0, var_1 );
}

_id_1AD3()
{
    if ( isdefined( self.v["repeat"] ) )
    {
        thread _id_3533();

        for ( var_0 = 0; var_0 < self.v["repeat"]; var_0++ )
        {
            playfx( level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"] );
            _id_352A();
        }

        return;
    }

    if ( !isdefined( self.v["delay"] ) )
        self.v["delay"] = 0;

    if ( self.v["delay"] >= 0 )
    {
        _id_352A();
        var_1 = 0;
    }
    else
        var_1 = self.v["delay"];

    if ( isdefined( self._id_5878 ) )
        self._id_5878 delete();

    self._id_5878 = spawnfx( common_scripts\utility::getfx( self.v["fxid"] ), self.v["origin"], self.v["forward"], self.v["up"] );

    if ( level.createfx_enabled )
        setwinningteam( self._id_5878, 1 );

    if ( self.v["delay"] >= 0 )
        triggerfx( self._id_5878 );
    else
        triggerfx( self._id_5878, var_1 );

    _id_3533();
}

_id_06F9( var_0, var_1, var_2 )
{
    var_0 += "";
    level notify( "exploding_" + var_0 );
    var_3 = 0;

    if ( isdefined( level._id_241A ) && !level.createfx_enabled )
    {
        var_4 = level._id_241A[var_0];

        if ( isdefined( var_4 ) )
        {
            foreach ( var_6 in var_4 )
            {
                if ( !var_6 _id_1CB9() )
                    continue;

                var_6 common_scripts\utility::activate_individual_exploder();
                var_3 = 1;
            }
        }
    }
    else
    {
        for ( var_8 = 0; var_8 < level._id_2417.size; var_8++ )
        {
            var_6 = level._id_2417[var_8];

            if ( !isdefined( var_6 ) )
                continue;

            if ( var_6.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_6.v["exploder"] ) )
                continue;

            if ( var_6.v["exploder"] + "" != var_0 )
                continue;

            if ( !var_6 _id_1CB9() )
                continue;

            var_6 common_scripts\utility::activate_individual_exploder();
            var_3 = 1;
        }
    }

    if ( !_id_84A2() && !var_3 )
        _id_06F5( var_0, var_1, var_2 );
}

exploder( var_0, var_1, var_2 )
{
    [[ level._id_05B2._id_3537 ]]( var_0, var_1, var_2 );
}

_id_5306( var_0 )
{
    var_1 = _id_3F8C( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3._id_5878 ) )
                setwinningteam( var_3._id_5878, 1 );
        }

        waitframe();

        foreach ( var_3 in var_1 )
            var_3 common_scripts\utility::pauseeffect();
    }
}

_id_1CB9()
{
    var_0 = self;

    if ( isdefined( var_0.v["platform"] ) && isdefined( level.currentgen ) )
    {
        var_1 = var_0.v["platform"];

        if ( var_1 == "cg" && !level.currentgen || var_1 == "ng" && !level.nextgen )
            return 0;
    }

    return 1;
}

_id_06F5( var_0, var_1, var_2 )
{
    if ( !_id_5097( var_0 ) )
        return;

    var_3 = int( var_0 );
    _func_222( var_3, var_1, var_2 );
}

_id_262A( var_0, var_1, var_2 )
{
    if ( !_id_5097( var_0 ) )
        return;

    var_3 = int( var_0 );
    _func_292( var_3, var_1, var_2 );
}

_id_5097( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = var_0;

    if ( isstring( var_0 ) )
    {
        var_1 = int( var_0 );

        if ( var_1 == 0 && var_0 != "0" )
            return 0;
    }

    return var_1 >= 0;
}

_id_84A2()
{
    if ( common_scripts\utility::issp() )
        return 1;

    if ( !isdefined( level.createfx_enabled ) )
        level.createfx_enabled = getdvar( "createfx" ) != "";

    if ( level.createfx_enabled )
        return 1;
    else
        return getdvar( "clientSideEffects" ) != "1";
}

_id_3528( var_0, var_1, var_2 )
{
    waittillframeend;
    waittillframeend;
    _id_06F9( var_0, var_1, var_2 );
}

_id_3527( var_0, var_1, var_2 )
{
    _id_06F9( var_0, var_1, var_2 );
}
