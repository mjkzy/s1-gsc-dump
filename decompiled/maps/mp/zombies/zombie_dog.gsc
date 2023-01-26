// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_0897["zombie_dog"]["onAIConnect"] = level._id_0897["zombie"]["onAIConnect"];
    level._id_0897["zombie_dog"]["on_damaged"] = maps\mp\agents\_agents::_id_6436;
    level._id_0897["zombie_dog"]["on_damaged_finished"] = level._id_0897["zombie"]["on_damaged_finished"];
    level._id_0897["zombie_dog"]["on_killed"] = level._id_0897["zombie"]["on_killed"];
    level._id_0897["zombie_dog"]["spawn"] = ::spawn_zombie_dog;
    level._id_0897["zombie_dog"]["think"] = maps\mp\agents\dog\_zombie_dog_think::main;
    var_0[0] = [ "zom_dog_150p" ];
    level._effect["zombie_dog_eye_base"] = loadfx( "vfx/gameplay/mp/zombie/zombie_dog_eye_base" );
    level._effect["zombie_dog_eye_emp"] = loadfx( "vfx/gameplay/mp/zombie/zombie_dog_eye_emp" );
    level._effect["zombie_dog_eye_exploder"] = loadfx( "vfx/gameplay/mp/zombie/zombie_dog_eye_exploder" );
    var_1 = spawnstruct();
    var_1.agent_type = "zombie_dog";
    var_1.animclass = "zombie_dog_animclass";
    var_1.model_bodies = var_0;
    var_1._id_4780 = 1;
    var_1.healthoverridefunc = ::calculatedoghealth;
    var_1._id_5B83 = 45;
    var_1.spawnparameter = "zombie_dog";
    maps\mp\zombies\_util::agentclassregister( var_1, "zombie_dog" );
    level.getspawntypefunc["zombie_dog"] = ::getdogroundspawntype;
    level.candroppickupsfunc["zombie_dog"] = ::dogroundcandroppickups;
    level.numenemiesthisroundfunc["zombie_dog"] = ::dogroundnumenemies;
    level.roundspawndelayfunc["zombie_dog"] = ::dogroundspawndelay;
    level.roundstartfunc["zombie_dog"] = ::dogroundstart;
    level.roundendfunc["zombie_dog"] = ::dogroundend;
    level.movemodefunc["zombie_dog"] = ::dogcaculatemovemode;
    level.moveratescalefunc["zombie_dog"] = ::dogcaculatemoveratescale;
    level.nonmoveratescalefunc["zombie_dog"] = ::dogcalculatenonmoveratescale;
    level.traverseratescalefunc["zombie_dog"] = ::dogcalculatetraverseratescale;
    level.zombiedogondamage = maps\mp\agents\dog\_zombie_dog_think::_id_6461;
}

dogroundstart()
{

}

dogroundend()
{
    maps\mp\gametypes\zombies::createpickuporgive( "ammo", level.lastenemydeathpos, "Dog Round End" );
}

getdogroundspawntype( var_0, var_1 )
{
    return "zombie_dog";
}

dogroundcandroppickups( var_0 )
{
    return 0;
}

dogcaculatemovemode()
{
    return "run";
}

dogcaculatemoveratescale()
{
    return 1.0 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

dogcalculatenonmoveratescale()
{
    return 1.0 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

dogcalculatetraverseratescale()
{
    return 1.0 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

dogroundnumenemies( var_0 )
{
    var_1 = maps\mp\zombies\_util::_id_4056();
    var_2 = var_1 * 6;

    if ( level.specialroundcounter > 3 )
        var_2 = var_1 * 8;

    return var_2;
}

dogroundspawndelay( var_0, var_1 )
{
    var_2 = 1.5;

    switch ( level.specialroundcounter )
    {
        case 0:
        case 1:
            var_2 = 3;
            break;
        case 2:
            var_2 = 2.5;
            break;
        case 3:
            var_2 = 2;
            break;
        default:
            var_2 = 1.5;
    }

    var_2 -= var_0 / var_1;
    return var_2;
}

calculatedoghealth()
{
    var_0 = 400;

    switch ( level.specialroundcounter )
    {
        case 0:
        case 1:
            var_0 = 400;
            break;
        case 2:
            var_0 = 900;
            break;
        case 3:
            var_0 = 1300;
            break;
        default:
            var_0 = 1600;
    }

    return var_0;
}

spawn_zombie_dog( var_0, var_1, var_2 )
{
    self setmodel( "tag_origin" );
    self._id_8A3A = "dog";
    self._id_648D = maps\mp\agents\_scripted_agent_anim_util::_id_648D;

    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_3 = var_0;
        var_4 = var_1;
    }
    else
    {
        var_5 = self [[ level.getspawnpoint ]]();
        var_3 = var_5.origin;
        var_4 = var_5.angles;
    }

    maps\mp\agents\_agent_utility::_id_070B();
    self.spawntime = gettime();
    self.lastspawntime = gettime();
    maps\mp\agents\dog\_zombie_dog_think::init();
    self _meth_838A( var_3, var_4, self.animclass, self.radius, self.height, var_2 );
    level notify( "spawned_agent", self );
    maps\mp\agents\_agent_common::set_agent_health( 100 );

    if ( isdefined( var_2 ) )
        maps\mp\agents\_agent_utility::_id_7DAB( var_2.team, var_2 );

    self setthreatbiasgroup( "Dogs" );
    self takeallweapons();
    self _meth_853E( 1 );
    self _meth_8545( 1 );
    self _meth_8542( 1 );
    self _meth_8543( 0 );
    self _meth_8541( 0 );
    self thread [[ maps\mp\agents\_agent_utility::agentfunc( "think" ) ]]();
}
