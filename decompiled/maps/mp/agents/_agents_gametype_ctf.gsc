// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
}

setup_callbacks()
{
    level.agent_funcs["player"]["think"] = maps\mp\bots\_bots_gametype_ctf::bot_ctf_think;
}
