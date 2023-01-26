// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

playerprocesstaggedassist( var_0 )
{
    if ( level.teambased && isdefined( var_0 ) )
        thread maps\mp\_events::processassistevent( var_0 );
}
