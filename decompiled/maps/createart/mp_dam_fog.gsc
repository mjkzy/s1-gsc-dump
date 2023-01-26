// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    var_0 = maps\mp\_art::create_vision_set_fog( "mp_dam" );
    var_0.startdist = 1050;
    var_0.halfwaydist = 34000;
    var_0.red = 0.8;
    var_0.green = 0.86;
    var_0.blue = 0.97;
    var_0.maxopacity = 0.17;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0 = maps\mp\_art::create_vision_set_fog( "mp_dam_underground" );
    var_0.startdist = 500;
    var_0.halfwaydist = 5000;
    var_0.red = 0.83;
    var_0.green = 0.72;
    var_0.blue = 0.58;
    var_0.maxopacity = 0.4;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0 = maps\mp\_art::create_vision_set_fog( "mp_dam_interior" );
    var_0.startdist = 1050;
    var_0.halfwaydist = 34000;
    var_0.red = 0.76;
    var_0.green = 0.89;
    var_0.blue = 0.88;
    var_0.maxopacity = 0.19;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
}

_id_8311()
{

}
