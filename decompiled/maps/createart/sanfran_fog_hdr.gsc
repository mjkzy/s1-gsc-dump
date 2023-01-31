// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    sunflare();
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_flyover" );
    var_0.startdist = 1600;
    var_0.halfwaydist = 12000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 6207.61;
    var_0.atmosfogstartdistance = 2128.97;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0.0785, 0.863, 0.498 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran" );
    var_0.startdist = 234.375;
    var_0.halfwaydist = 104309;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.646781, 0.796645, 0.97 );
    var_0.atmosfoghazecolor = ( 0.999997, 0.999947, 0.873559 );
    var_0.atmosfoghazestrength = 0.295783;
    var_0.atmosfoghazespread = 0.031778;
    var_0.atmosfogextinctionstrength = 0.625467;
    var_0.atmosfoginscatterstrength = 18.2912;
    var_0.atmosfoghalfplanedistance = 2841.17;
    var_0.atmosfogstartdistance = 1048;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 65536;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 18;
    var_0.atmosfogskyfalloffanglerange = 88;
    var_0.atmosfogsundirection = ( -0.5552, 0.726239, 0.405376 );
    var_0.atmosfogheightfogenabled = 1;
    var_0.atmosfogheightfogbaseheight = -572.469;
    var_0.atmosfogheightfoghalfplanedistance = 832.711;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_neutral" );
    var_0.startdist = 234.375;
    var_0.halfwaydist = 104309;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.646781, 0.796645, 0.97 );
    var_0.atmosfoghazecolor = ( 0.999997, 0.999947, 0.873559 );
    var_0.atmosfoghazestrength = 0.295783;
    var_0.atmosfoghazespread = 0.031778;
    var_0.atmosfogextinctionstrength = 0.625467;
    var_0.atmosfoginscatterstrength = 18.2912;
    var_0.atmosfoghalfplanedistance = 9906.11;
    var_0.atmosfogstartdistance = 1048;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 65536;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 18;
    var_0.atmosfogskyfalloffanglerange = 88;
    var_0.atmosfogsundirection = ( -0.5552, 0.726239, 0.405376 );
    var_0.atmosfogheightfogenabled = 1;
    var_0.atmosfogheightfogbaseheight = -572.469;
    var_0.atmosfogheightfoghalfplanedistance = 832.711;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_oncoming" );
    var_0.startdist = 234.375;
    var_0.halfwaydist = 104309;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.646781, 0.796645, 0.97 );
    var_0.atmosfoghazecolor = ( 0.999997, 0.999947, 0.873559 );
    var_0.atmosfoghazestrength = 0.295783;
    var_0.atmosfoghazespread = 0.031778;
    var_0.atmosfogextinctionstrength = 0.625467;
    var_0.atmosfoginscatterstrength = 18.2912;
    var_0.atmosfoghalfplanedistance = 9906.11;
    var_0.atmosfogstartdistance = 1048;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 65536;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 18;
    var_0.atmosfogskyfalloffanglerange = 88;
    var_0.atmosfogsundirection = ( -0.5552, 0.726239, 0.405376 );
    var_0.atmosfogheightfogenabled = 1;
    var_0.atmosfogheightfogbaseheight = -572.469;
    var_0.atmosfogheightfoghalfplanedistance = 832.711;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_boost_desat" );
    var_0.startdist = 2600;
    var_0.halfwaydist = 19000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 18478.6;
    var_0.atmosfogstartdistance = 33187;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( -0.543, 0.726, 0.415 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_boost_warm_1" );
    var_0.startdist = 2600;
    var_0.halfwaydist = 19000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 18478.6;
    var_0.atmosfogstartdistance = 33187;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( -0.543, 0.726, 0.415 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_boost_warm_2" );
    var_0.startdist = 2600;
    var_0.halfwaydist = 19000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 18478.6;
    var_0.atmosfogstartdistance = 33187;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( -0.543, 0.726, 0.415 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_vanexplosion" );
    var_0.startdist = 2600;
    var_0.halfwaydist = 19000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 18478.6;
    var_0.atmosfogstartdistance = 33187;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( -0.543, 0.726, 0.415 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_drone_view" );
    var_0.startdist = 1600;
    var_0.halfwaydist = 12000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.59, 0.836, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 23;
    var_0.atmosfoghalfplanedistance = 155355;
    var_0.atmosfogstartdistance = 20501;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 30823;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0.0785, 0.863, 0.498 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_drone_view_1" );
    var_0.startdist = 1600;
    var_0.halfwaydist = 12000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.836, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 25738.6;
    var_0.atmosfogstartdistance = 16413;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0.0785, 0.863, 0.498 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_tunnel" );
    var_0.startdist = 1600;
    var_0.halfwaydist = 12000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 6207.61;
    var_0.atmosfogstartdistance = 19001;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( -0.683, 0.542, 0.488 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_collapse" );
    var_0.startdist = 2600;
    var_0.halfwaydist = 19000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 18478.6;
    var_0.atmosfogstartdistance = 33187;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( -0.543, 0.726, 0.415 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_flyover_cg" );
    var_0.startdist = 1600;
    var_0.halfwaydist = 12000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
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
    var_0.atmosfogsunfogcolor = ( 0.571, 0.756, 0.97 );
    var_0.atmosfoghazecolor = ( 1, 1, 0.897 );
    var_0.atmosfoghazestrength = 0.069;
    var_0.atmosfoghazespread = 0.0169;
    var_0.atmosfogextinctionstrength = 0.1558;
    var_0.atmosfoginscatterstrength = 20.945;
    var_0.atmosfoghalfplanedistance = 6207.61;
    var_0.atmosfogstartdistance = 2128.97;
    var_0.atmosfogdistancescale = 1.028;
    var_0.atmosfogskydistance = 138458;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 7.91;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0.0785, 0.863, 0.498 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_cg" );
    var_0.startdist = 50;
    var_0.halfwaydist = 50000;
    var_0.red = 0.933333;
    var_0.green = 0.819608;
    var_0.blue = 0.709804;
    var_0.hdrcolorintensity = 14.0905;
    var_0.maxopacity = 0.507907;
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
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_cops_end_cg" );
    var_0.startdist = 1000;
    var_0.halfwaydist = 74000;
    var_0.red = 0.661;
    var_0.green = 0.686;
    var_0.blue = 0.668;
    var_0.hdrcolorintensity = 15.375;
    var_0.maxopacity = 0.574;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_oncoming_cg" );
    var_0.startdist = 1000;
    var_0.halfwaydist = 74000;
    var_0.red = 0.661;
    var_0.green = 0.686;
    var_0.blue = 0.668;
    var_0.hdrcolorintensity = 15.375;
    var_0.maxopacity = 0.574;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_boost_desat_cg" );
    var_0.startdist = 1000;
    var_0.halfwaydist = 74000;
    var_0.red = 0.661;
    var_0.green = 0.686;
    var_0.blue = 0.668;
    var_0.hdrcolorintensity = 15.375;
    var_0.maxopacity = 0.574;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_boost_warm_1_cg" );
    var_0.startdist = 1000;
    var_0.halfwaydist = 74000;
    var_0.red = 0.661;
    var_0.green = 0.686;
    var_0.blue = 0.668;
    var_0.hdrcolorintensity = 15.375;
    var_0.maxopacity = 0.574;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_boost_warm_2_cg" );
    var_0.startdist = 1000;
    var_0.halfwaydist = 74000;
    var_0.red = 0.661;
    var_0.green = 0.686;
    var_0.blue = 0.668;
    var_0.hdrcolorintensity = 15.375;
    var_0.maxopacity = 0.574;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_vanexplosion_cg" );
    var_0.startdist = 1000;
    var_0.halfwaydist = 74000;
    var_0.red = 0.661;
    var_0.green = 0.686;
    var_0.blue = 0.668;
    var_0.hdrcolorintensity = 15.375;
    var_0.maxopacity = 0.574;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_drone_view_cg" );
    var_0.startdist = 13169;
    var_0.halfwaydist = 85836.4;
    var_0.red = 0.816273;
    var_0.green = 0.947483;
    var_0.blue = 0.997797;
    var_0.hdrcolorintensity = 14.9345;
    var_0.maxopacity = 0.5;
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
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_drone_view_1_cg" );
    var_0.startdist = 400;
    var_0.halfwaydist = 12000;
    var_0.red = 0.816273;
    var_0.green = 0.947483;
    var_0.blue = 0.997797;
    var_0.hdrcolorintensity = 13;
    var_0.maxopacity = 0.5;
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
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_tunnel_cg" );
    var_0.startdist = 775;
    var_0.halfwaydist = 27430.5;
    var_0.red = 0.119106;
    var_0.green = 0.202035;
    var_0.blue = 0.188213;
    var_0.hdrcolorintensity = 13.8989;
    var_0.maxopacity = 0.05;
    var_0.transitiontime = 0.2;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "sanfran_collapse_cg" );
    var_0.startdist = 1000;
    var_0.halfwaydist = 74000;
    var_0.red = 0.661;
    var_0.green = 0.686;
    var_0.blue = 0.668;
    var_0.hdrcolorintensity = 15.375;
    var_0.maxopacity = 0.574;
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
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazecolor = ( 0.5, 0.5, 0.5 );
    var_0.atmosfoghazestrength = 0.5;
    var_0.atmosfoghazespread = 0.25;
    var_0.atmosfogextinctionstrength = 1;
    var_0.atmosfoginscatterstrength = 0;
    var_0.atmosfoghalfplanedistance = 5000;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 1;
    var_0.atmosfogskydistance = 100000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 90;
    var_0.atmosfogsundirection = ( 0, 0, 1 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
}

sunflare()
{
    var_0 = maps\_utility::create_sunflare_setting( "default" );
    var_0.position = ( -30, 85, 0 );
    maps\_art::sunflare_changes( "default", 0 );
}
