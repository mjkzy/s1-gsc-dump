// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    sunflare();
    var_0 = maps\_utility::create_vision_set_fog( "df_fly" );
    var_0.startdist = 6412;
    var_0.halfwaydist = 120000;
    var_0.red = 0.95;
    var_0.green = 0.96;
    var_0.blue = 0.97;
    var_0.hdrcolorintensity = 17;
    var_0.maxopacity = 0.6;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.96;
    var_0.sungreen = 0.89;
    var_0.sunblue = 0.76;
    var_0.hdrsuncolorintensity = 17.5;
    var_0.sundir = ( 0.11, 0.84, 0.53 );
    var_0.sunbeginfadeangle = 4;
    var_0.sunendfadeangle = 76;
    var_0.normalfogscale = 0.56;
    var_0.skyfogintensity = 0.89;
    var_0.skyfogminangle = -12;
    var_0.skyfogmaxangle = 62;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_cg" );
    var_0.startdist = 2154.79;
    var_0.halfwaydist = 267244;
    var_0.red = 0.671387;
    var_0.green = 0.722188;
    var_0.blue = 0.778682;
    var_0.hdrcolorintensity = 15.9244;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.5;
    var_0.sungreen = 0.5;
    var_0.sunblue = 0.5;
    var_0.hdrsuncolorintensity = -8;
    var_0.sundir = ( 0, 0, 0 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 1;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.492075, 0.613846, 0.72373 );
    var_0.atmosfoghazecolor = ( 1, 0.975644, 0.952128 );
    var_0.atmosfoghazestrength = 0.106;
    var_0.atmosfoghazespread = 0.115127;
    var_0.atmosfogextinctionstrength = 0.813859;
    var_0.atmosfoginscatterstrength = 22.8883;
    var_0.atmosfoghalfplanedistance = 25415.7;
    var_0.atmosfogstartdistance = 800;
    var_0.atmosfogdistancescale = 0.158192;
    var_0.atmosfogskydistance = 7549;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 100;
    var_0.atmosfogsundirection = ( 0.023316, -0.503496, 0.863683 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_intro" );
    var_0.startdist = 6412;
    var_0.halfwaydist = 120000;
    var_0.red = 0.95;
    var_0.green = 0.96;
    var_0.blue = 0.97;
    var_0.hdrcolorintensity = 17;
    var_0.maxopacity = 0.6;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.96;
    var_0.sungreen = 0.89;
    var_0.sunblue = 0.76;
    var_0.hdrsuncolorintensity = 17.5;
    var_0.sundir = ( 0.11, 0.84, 0.53 );
    var_0.sunbeginfadeangle = 4;
    var_0.sunendfadeangle = 76;
    var_0.normalfogscale = 0.56;
    var_0.skyfogintensity = 0.89;
    var_0.skyfogminangle = -12;
    var_0.skyfogmaxangle = 62;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_intro_cg" );
    var_0.startdist = 2154.79;
    var_0.halfwaydist = 267244;
    var_0.red = 0.671387;
    var_0.green = 0.722188;
    var_0.blue = 0.778682;
    var_0.hdrcolorintensity = 15.9244;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.5;
    var_0.sungreen = 0.5;
    var_0.sunblue = 0.5;
    var_0.hdrsuncolorintensity = -8;
    var_0.sundir = ( 0, 0, 0 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 1;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.492075, 0.613846, 0.72373 );
    var_0.atmosfoghazecolor = ( 1, 0.975644, 0.952128 );
    var_0.atmosfoghazestrength = 0.106;
    var_0.atmosfoghazespread = 0.115127;
    var_0.atmosfogextinctionstrength = 0.813859;
    var_0.atmosfoginscatterstrength = 22.8883;
    var_0.atmosfoghalfplanedistance = 25415.7;
    var_0.atmosfogstartdistance = 800;
    var_0.atmosfogdistancescale = 0.158192;
    var_0.atmosfogskydistance = 7549;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 100;
    var_0.atmosfogsundirection = ( 0.023316, -0.503496, 0.863683 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_canyon" );
    var_0.startdist = 6412;
    var_0.halfwaydist = 106497;
    var_0.red = 0.95;
    var_0.green = 0.96;
    var_0.blue = 0.97;
    var_0.hdrcolorintensity = 17;
    var_0.maxopacity = 0.6;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.96;
    var_0.sungreen = 0.89;
    var_0.sunblue = 0.76;
    var_0.hdrsuncolorintensity = 17.5;
    var_0.sundir = ( 0.11, 0.84, 0.53 );
    var_0.sunbeginfadeangle = 4;
    var_0.sunendfadeangle = 76;
    var_0.normalfogscale = 0.56;
    var_0.skyfogintensity = 0.89;
    var_0.skyfogminangle = -12;
    var_0.skyfogmaxangle = 62;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.742188, 0.830811, 1 );
    var_0.atmosfoghazecolor = ( 0.53125, 0.52029, 0.477295 );
    var_0.atmosfoghazestrength = 0.374997;
    var_0.atmosfoghazespread = 0.0234375;
    var_0.atmosfogextinctionstrength = 0.6875;
    var_0.atmosfoginscatterstrength = 21.25;
    var_0.atmosfoghalfplanedistance = 67585;
    var_0.atmosfogstartdistance = 6656;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 253952;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0.110346, 0.843158, 0.526221 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_canyon_cg" );
    var_0.startdist = 2154.79;
    var_0.halfwaydist = 267244;
    var_0.red = 0.671387;
    var_0.green = 0.722188;
    var_0.blue = 0.778682;
    var_0.hdrcolorintensity = 15.9244;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.96;
    var_0.sungreen = 0.89;
    var_0.sunblue = 0.76;
    var_0.hdrsuncolorintensity = 17.5;
    var_0.sundir = ( 0.11, 0.84, 0.53 );
    var_0.sunbeginfadeangle = 4;
    var_0.sunendfadeangle = 76;
    var_0.normalfogscale = 0.56;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.439929, 0.56001, 0.653418 );
    var_0.atmosfoghazecolor = ( 0.960938, 0.898438, 0.842753 );
    var_0.atmosfoghazestrength = 0.132813;
    var_0.atmosfoghazespread = 0.153802;
    var_0.atmosfogextinctionstrength = 0.610734;
    var_0.atmosfoginscatterstrength = 22.8883;
    var_0.atmosfoghalfplanedistance = 33307.8;
    var_0.atmosfogstartdistance = 4045.31;
    var_0.atmosfogdistancescale = 0.137142;
    var_0.atmosfogskydistance = 45124;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = -16;
    var_0.atmosfogskyfalloffanglerange = 40;
    var_0.atmosfogsundirection = ( 0.205344, 0.587297, 0.782889 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 2561;
    var_0.atmosfogheightfoghalfplanedistance = 577;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_canyon_finale" );
    var_0.startdist = 6412;
    var_0.halfwaydist = 106497;
    var_0.red = 0.95;
    var_0.green = 0.96;
    var_0.blue = 0.97;
    var_0.hdrcolorintensity = 17;
    var_0.maxopacity = 0.6;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.96;
    var_0.sungreen = 0.89;
    var_0.sunblue = 0.76;
    var_0.hdrsuncolorintensity = 17.5;
    var_0.sundir = ( 0.11, 0.84, 0.53 );
    var_0.sunbeginfadeangle = 4;
    var_0.sunendfadeangle = 76;
    var_0.normalfogscale = 0.56;
    var_0.skyfogintensity = 0.89;
    var_0.skyfogminangle = -12;
    var_0.skyfogmaxangle = 62;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.742188, 0.830811, 1 );
    var_0.atmosfoghazecolor = ( 0.53125, 0.52029, 0.477295 );
    var_0.atmosfoghazestrength = 0.374997;
    var_0.atmosfoghazespread = 0.0234375;
    var_0.atmosfogextinctionstrength = 0.6875;
    var_0.atmosfoginscatterstrength = 21;
    var_0.atmosfoghalfplanedistance = 67585;
    var_0.atmosfogstartdistance = 6656;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 499712;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0.110346, 0.843158, 0.526221 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_canyon_finale_cg" );
    var_0.startdist = 2154.79;
    var_0.halfwaydist = 267244;
    var_0.red = 0.671387;
    var_0.green = 0.722188;
    var_0.blue = 0.778682;
    var_0.hdrcolorintensity = 15.9244;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.5;
    var_0.sungreen = 0.5;
    var_0.sunblue = 0.5;
    var_0.hdrsuncolorintensity = -8;
    var_0.sundir = ( 0, 0, 0 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 1;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.562387, 0.621659, 0.72373 );
    var_0.atmosfoghazecolor = ( 1, 0.936003, 0.913065 );
    var_0.atmosfoghazestrength = 0.106;
    var_0.atmosfoghazespread = 0.115127;
    var_0.atmosfogextinctionstrength = 0.813859;
    var_0.atmosfoginscatterstrength = 22.8883;
    var_0.atmosfoghalfplanedistance = 40903.6;
    var_0.atmosfogstartdistance = 1730.72;
    var_0.atmosfogdistancescale = 0.102166;
    var_0.atmosfogskydistance = 18016;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 1;
    var_0.atmosfogskyfalloffanglerange = 100;
    var_0.atmosfogsundirection = ( -0.6464, -0.00939985, 0.762941 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 2561;
    var_0.atmosfogheightfoghalfplanedistance = 577;
    var_0 = maps\_utility::create_vision_set_fog( "df_fly_canyon_end_pod_cg" );
    var_0.startdist = 2154.79;
    var_0.halfwaydist = 267244;
    var_0.red = 0.671387;
    var_0.green = 0.722188;
    var_0.blue = 0.778682;
    var_0.hdrcolorintensity = 15.9244;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.5;
    var_0.sungreen = 0.5;
    var_0.sunblue = 0.5;
    var_0.hdrsuncolorintensity = -8;
    var_0.sundir = ( 0, 0, 0 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 1;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.562387, 0.621659, 0.72373 );
    var_0.atmosfoghazecolor = ( 1, 0.936003, 0.913065 );
    var_0.atmosfoghazestrength = 0.106;
    var_0.atmosfoghazespread = 0.115127;
    var_0.atmosfogextinctionstrength = 0.813859;
    var_0.atmosfoginscatterstrength = 22.8883;
    var_0.atmosfoghalfplanedistance = 40903.6;
    var_0.atmosfogstartdistance = 1730.72;
    var_0.atmosfogdistancescale = 0.102166;
    var_0.atmosfogskydistance = 18016;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 1;
    var_0.atmosfogskyfalloffanglerange = 100;
    var_0.atmosfogsundirection = ( -0.6464, -0.00939985, 0.762941 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 2561;
    var_0.atmosfogheightfoghalfplanedistance = 577;
}

sunflare()
{
    var_0 = maps\_utility::create_sunflare_setting( "default" );
    var_0.position = ( -30, 85, 0 );
    maps\_art::sunflare_changes( "default", 0 );
}