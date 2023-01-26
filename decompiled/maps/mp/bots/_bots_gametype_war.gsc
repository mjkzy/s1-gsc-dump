// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_805C();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_1731;
}

_id_805C()
{

}

_id_1731()
{
    self notify( "bot_war_think" );
    self endon( "bot_war_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );

    for (;;)
    {
        self [[ self._id_67DE ]]();
        wait 0.05;
    }
}
