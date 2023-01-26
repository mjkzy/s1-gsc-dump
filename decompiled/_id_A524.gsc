// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

init()
{
    level._id_2E21["neutral"]["stand"]["idle"] = %casual_stand_idle;
    level._id_2E21["neutral"]["stand"]["run"] = %unarmed_scared_run;
    level._id_2E21["neutral"]["stand"]["death"] = %exposed_death;
    level._id_0E0A = animscripts\civilian\civilian_init::_id_0E09;
    _id_A521::initglobals();
}
