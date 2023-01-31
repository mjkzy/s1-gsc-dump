// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

stealth_behavior_system_main()
{
    stealth_behavior_system_init();
}

stealth_behavior_system_init()
{
    level._stealth.behavior = spawnstruct();
    level._stealth.node_search = spawnstruct();
    level._stealth.behavior.sound = [];
    level._stealth.behavior.sound["huh"] = 0;
    level._stealth.behavior.sound["hmph"] = 0;
    level._stealth.behavior.sound["name"] = 0;
    level._stealth.behavior.sound["wtf"] = 0;
    level._stealth.behavior.sound["spotted"] = [];
    level._stealth.behavior.sound["corpse"] = 0;
    level._stealth.behavior.sound["alert"] = 0;
    level._stealth.behavior.sound["acknowledge"] = 0;
    level._stealth.behavior.sound_reset_time = 3;
}
