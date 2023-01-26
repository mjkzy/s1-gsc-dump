// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_8057();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_1647;
}

_id_8057()
{

}

_id_1647()
{
    self notify( "bot_gun_think" );
    self endon( "bot_gun_think" );
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
