// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    sunflare();
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad" );
    var_0.startdist = 2100;
    var_0.halfwaydist = 3952;
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
    var_0.atmosfogsunfogcolor = ( 0.584312, 0.7015, 1 );
    var_0.atmosfoghazecolor = ( 0.789063, 0.910688, 0.939 );
    var_0.atmosfoghazestrength = 0.2;
    var_0.atmosfoghazespread = 0.170313;
    var_0.atmosfogextinctionstrength = 0.4;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 4569.4;
    var_0.atmosfogstartdistance = -487.813;
    var_0.atmosfogdistancescale = 1.2;
    var_0.atmosfogskydistance = 57605;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 19.3592;
    var_0.atmosfogskyfalloffanglerange = 60;
    var_0.atmosfogsundirection = ( -0.033, -0.722, 0.69 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_cg" );
    var_0.startdist = 1059.3;
    var_0.halfwaydist = 11500.8;
    var_0.red = 0.47335;
    var_0.green = 0.526046;
    var_0.blue = 0.622063;
    var_0.hdrcolorintensity = 16.5031;
    var_0.maxopacity = 0.9;
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
    var_0.atmosfogsunfogcolor = ( 0.584312, 0.7015, 1 );
    var_0.atmosfoghazecolor = ( 1, 0.856, 0.689 );
    var_0.atmosfoghazestrength = 0.2;
    var_0.atmosfoghazespread = 0.170313;
    var_0.atmosfogextinctionstrength = 0.4;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 5130.86;
    var_0.atmosfogstartdistance = -14.5308;
    var_0.atmosfogdistancescale = 0.8625;
    var_0.atmosfogskydistance = 25000;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 17;
    var_0.atmosfogsundirection = ( -0.033, -0.722, 0.69 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_nightvision" );
    var_0.startdist = 0;
    var_0.halfwaydist = 13830;
    var_0.red = 0.24;
    var_0.green = 0.27;
    var_0.blue = 0.32;
    var_0.hdrcolorintensity = 14.7;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 90;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.0055, 0.0193, 0.0292 );
    var_0.atmosfoghazecolor = ( 0.033, 0.0169, 0 );
    var_0.atmosfoghazestrength = 0;
    var_0.atmosfoghazespread = 0.1;
    var_0.atmosfogextinctionstrength = 0.05;
    var_0.atmosfoginscatterstrength = 21.5;
    var_0.atmosfoghalfplanedistance = 7344;
    var_0.atmosfogstartdistance = 536;
    var_0.atmosfogdistancescale = 0;
    var_0.atmosfogskydistance = 35000;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = -5.3;
    var_0.atmosfogskyfalloffanglerange = 15;
    var_0.atmosfogsundirection = ( -0.87, -0.47, 0.07 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_nightvision_cg" );
    var_0.startdist = 0;
    var_0.halfwaydist = 13830;
    var_0.red = 0.24;
    var_0.green = 0.27;
    var_0.blue = 0.32;
    var_0.hdrcolorintensity = 14.7;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 90;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.0055, 0.0193, 0.0292 );
    var_0.atmosfoghazecolor = ( 0.033, 0.0169, 0 );
    var_0.atmosfoghazestrength = 0;
    var_0.atmosfoghazespread = 0.1;
    var_0.atmosfogextinctionstrength = 0.05;
    var_0.atmosfoginscatterstrength = 21.5;
    var_0.atmosfoghalfplanedistance = 7344;
    var_0.atmosfogstartdistance = 536;
    var_0.atmosfogdistancescale = 0;
    var_0.atmosfogskydistance = 19762;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = -5.3;
    var_0.atmosfogskyfalloffanglerange = 15;
    var_0.atmosfogsundirection = ( -0.87, -0.47, 0.07 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_barracks_entrance" );
    var_0.startdist = 0;
    var_0.halfwaydist = 13830;
    var_0.red = 0.24;
    var_0.green = 0.27;
    var_0.blue = 0.32;
    var_0.hdrcolorintensity = 14.7;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 90;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.0055, 0.0193, 0.0292 );
    var_0.atmosfoghazecolor = ( 0.033, 0.0169, 0 );
    var_0.atmosfoghazestrength = 0;
    var_0.atmosfoghazespread = 0.1;
    var_0.atmosfogextinctionstrength = 0.05;
    var_0.atmosfoginscatterstrength = 21.5;
    var_0.atmosfoghalfplanedistance = 1200;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 0;
    var_0.atmosfogskydistance = 19762;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = -5.3;
    var_0.atmosfogskyfalloffanglerange = 15;
    var_0.atmosfogsundirection = ( -0.87, -0.47, 0.07 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_barracks_entrance_cg" );
    var_0.startdist = 0;
    var_0.halfwaydist = 13830;
    var_0.red = 0.24;
    var_0.green = 0.27;
    var_0.blue = 0.32;
    var_0.hdrcolorintensity = 14.7;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 90;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.0055, 0.0193, 0.0292 );
    var_0.atmosfoghazecolor = ( 0.033, 0.0169, 0 );
    var_0.atmosfoghazestrength = 0;
    var_0.atmosfoghazespread = 0.1;
    var_0.atmosfogextinctionstrength = 0.05;
    var_0.atmosfoginscatterstrength = 21.5;
    var_0.atmosfoghalfplanedistance = 1200;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 0;
    var_0.atmosfogskydistance = 19762;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = -5.3;
    var_0.atmosfogskyfalloffanglerange = 15;
    var_0.atmosfogsundirection = ( -0.87, -0.47, 0.07 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_barracks" );
    var_0.startdist = 0;
    var_0.halfwaydist = 13830;
    var_0.red = 0.24;
    var_0.green = 0.27;
    var_0.blue = 0.32;
    var_0.hdrcolorintensity = 14.7;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 90;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.0055, 0.0193, 0.0292 );
    var_0.atmosfoghazecolor = ( 0.033, 0.0169, 0 );
    var_0.atmosfoghazestrength = 0;
    var_0.atmosfoghazespread = 0.1;
    var_0.atmosfogextinctionstrength = 0.05;
    var_0.atmosfoginscatterstrength = 21.5;
    var_0.atmosfoghalfplanedistance = 1200;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 0;
    var_0.atmosfogskydistance = 19762;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = -5.3;
    var_0.atmosfogskyfalloffanglerange = 15;
    var_0.atmosfogsundirection = ( -0.87, -0.47, 0.07 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_barracks_cg" );
    var_0.startdist = 0;
    var_0.halfwaydist = 13830;
    var_0.red = 0.24;
    var_0.green = 0.27;
    var_0.blue = 0.32;
    var_0.hdrcolorintensity = 14.7;
    var_0.maxopacity = 1;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 90;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.0055, 0.0193, 0.0292 );
    var_0.atmosfoghazecolor = ( 0.033, 0.0169, 0 );
    var_0.atmosfoghazestrength = 0;
    var_0.atmosfoghazespread = 0.1;
    var_0.atmosfogextinctionstrength = 0.05;
    var_0.atmosfoginscatterstrength = 21.5;
    var_0.atmosfoghalfplanedistance = 1200;
    var_0.atmosfogstartdistance = 0;
    var_0.atmosfogdistancescale = 0;
    var_0.atmosfogskydistance = 19762;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = -5.3;
    var_0.atmosfogskyfalloffanglerange = 15;
    var_0.atmosfogsundirection = ( -0.87, -0.47, 0.07 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 0;
    var_0.atmosfogheightfoghalfplanedistance = 1000;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_01" );
    var_0.startdist = 2100;
    var_0.halfwaydist = 3952;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.584312, 0.7015, 1 );
    var_0.atmosfoghazecolor = ( 1, 0.856, 0.689 );
    var_0.atmosfoghazestrength = 0.2;
    var_0.atmosfoghazespread = 0.170313;
    var_0.atmosfogextinctionstrength = 0.4;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 2645.64;
    var_0.atmosfogstartdistance = -14.5308;
    var_0.atmosfogdistancescale = 1.5;
    var_0.atmosfogskydistance = 57605;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 19.3592;
    var_0.atmosfogskyfalloffanglerange = 60;
    var_0.atmosfogsundirection = ( -0.033, -0.722, 0.69 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_01_cg" );
    var_0.startdist = 1600;
    var_0.halfwaydist = 12000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 0.757813, 0.728638, 0.734375 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.2;
    var_0.atmosfoghazespread = 0.170313;
    var_0.atmosfogextinctionstrength = 0.4;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 5130.86;
    var_0.atmosfogstartdistance = 261.82;
    var_0.atmosfogdistancescale = 0.8625;
    var_0.atmosfogskydistance = 18544;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 33;
    var_0.atmosfogsundirection = ( -0.033, -0.722, 0.69 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_02" );
    var_0.startdist = 1551.17;
    var_0.halfwaydist = 5887.77;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 1, 1, 1 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.125;
    var_0.atmosfoghazespread = 0.295312;
    var_0.atmosfogextinctionstrength = 0.842188;
    var_0.atmosfoginscatterstrength = 19.2;
    var_0.atmosfoghalfplanedistance = 1000;
    var_0.atmosfogstartdistance = -1000;
    var_0.atmosfogdistancescale = 3.525;
    var_0.atmosfogskydistance = 4981;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 296;
    var_0.atmosfogsundirection = ( 0.0378094, -0.736993, 0.674842 );
    var_0.atmosfogheightfogenabled = 1;
    var_0.atmosfogheightfogbaseheight = 897;
    var_0.atmosfogheightfoghalfplanedistance = 257;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_02_cg" );
    var_0.startdist = 1551.17;
    var_0.halfwaydist = 5887.77;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 1, 1, 1 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.125;
    var_0.atmosfoghazespread = 0.295312;
    var_0.atmosfogextinctionstrength = 0.842188;
    var_0.atmosfoginscatterstrength = 19.2;
    var_0.atmosfoghalfplanedistance = 1000;
    var_0.atmosfogstartdistance = -1000;
    var_0.atmosfogdistancescale = 3.525;
    var_0.atmosfogskydistance = 4981;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 296;
    var_0.atmosfogsundirection = ( 0.0378094, -0.736993, 0.674842 );
    var_0.atmosfogheightfogenabled = 1;
    var_0.atmosfogheightfogbaseheight = 897;
    var_0.atmosfogheightfoghalfplanedistance = 257;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_03" );
    var_0.startdist = 1551.17;
    var_0.halfwaydist = 6000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 1, 1, 1 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.03125;
    var_0.atmosfoghazespread = 1;
    var_0.atmosfogextinctionstrength = 0.953125;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 1451.91;
    var_0.atmosfogstartdistance = 5.56091;
    var_0.atmosfogdistancescale = 8.25611;
    var_0.atmosfogskydistance = 25000;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 14;
    var_0.atmosfogskyfalloffanglerange = 468;
    var_0.atmosfogsundirection = ( 0.0378094, -0.736993, 0.674842 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1921;
    var_0.atmosfogheightfoghalfplanedistance = 2176;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_03_cg" );
    var_0.startdist = 464.122;
    var_0.halfwaydist = 21446.8;
    var_0.red = 0.52159;
    var_0.green = 0.546955;
    var_0.blue = 0.593172;
    var_0.hdrcolorintensity = 16.5031;
    var_0.maxopacity = 0.813998;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 0;
    var_0.atmosfogsunfogcolor = ( 0.584312, 0.7015, 1 );
    var_0.atmosfoghazecolor = ( 1, 0.856, 0.689 );
    var_0.atmosfoghazestrength = 0.2;
    var_0.atmosfoghazespread = 0.170313;
    var_0.atmosfogextinctionstrength = 0.4;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 5130.86;
    var_0.atmosfogstartdistance = -14.5308;
    var_0.atmosfogdistancescale = 0.8625;
    var_0.atmosfogskydistance = 25000;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 17;
    var_0.atmosfogsundirection = ( -0.033, -0.722, 0.69 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_after" );
    var_0.startdist = 1551.17;
    var_0.halfwaydist = 6000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 1, 1, 1 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.03125;
    var_0.atmosfoghazespread = 1;
    var_0.atmosfogextinctionstrength = 0.953125;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 600;
    var_0.atmosfogstartdistance = -231;
    var_0.atmosfogdistancescale = 4.86181;
    var_0.atmosfogskydistance = 26381;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 18;
    var_0.atmosfogskyfalloffanglerange = 356;
    var_0.atmosfogsundirection = ( 0.0378094, -0.736993, 0.674842 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1921;
    var_0.atmosfogheightfoghalfplanedistance = 2176;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_dna_bomb_after_cg" );
    var_0.startdist = 1551.17;
    var_0.halfwaydist = 6000;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 1, 1, 1 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.03125;
    var_0.atmosfoghazespread = 1;
    var_0.atmosfogextinctionstrength = 0.953125;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 600;
    var_0.atmosfogstartdistance = -231;
    var_0.atmosfogdistancescale = 4.86181;
    var_0.atmosfogskydistance = 25000;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 14;
    var_0.atmosfogskyfalloffanglerange = 468;
    var_0.atmosfogsundirection = ( 0.0378094, -0.736993, 0.674842 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1921;
    var_0.atmosfogheightfoghalfplanedistance = 2176;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_captured" );
    var_0.startdist = 1600;
    var_0.halfwaydist = 1;
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
    var_0.atmosfogsunfogcolor = ( 0.757813, 0.728638, 0.734375 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.278125;
    var_0.atmosfoghazespread = 0.00982359;
    var_0.atmosfogextinctionstrength = 0.704687;
    var_0.atmosfoginscatterstrength = 18.7;
    var_0.atmosfoghalfplanedistance = 1213.08;
    var_0.atmosfogstartdistance = -166.315;
    var_0.atmosfogdistancescale = 1.3625;
    var_0.atmosfogskydistance = 199147;
    var_0.atmosfogskyangularfalloffenabled = 1;
    var_0.atmosfogskyfalloffstartangle = 57;
    var_0.atmosfogskyfalloffanglerange = 150;
    var_0.atmosfogsundirection = ( -0.546831, 0.464109, 0.696834 );
    var_0.atmosfogheightfogenabled = 0;
    var_0.atmosfogheightfogbaseheight = 1;
    var_0.atmosfogheightfoghalfplanedistance = 1600;
    var_0 = maps\_utility::create_vision_set_fog( "df_baghdad_captured_cg" );
    var_0.startdist = 1551.17;
    var_0.halfwaydist = 5887.77;
    var_0.red = 0.86477;
    var_0.green = 0.92;
    var_0.blue = 1;
    var_0.hdrcolorintensity = 0;
    var_0.maxopacity = 0;
    var_0.transitiontime = 0;
    var_0.sunfogenabled = 0;
    var_0.sunred = 0.731;
    var_0.sungreen = 0.611;
    var_0.sunblue = 0.4;
    var_0.hdrsuncolorintensity = 12.1;
    var_0.sundir = ( -0.706, -0.702, 0.087 );
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 40;
    var_0.normalfogscale = 1;
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
    var_0.atmosfogenabled = 1;
    var_0.atmosfogsunfogcolor = ( 1, 1, 1 );
    var_0.atmosfoghazecolor = ( 0.570313, 0.570313, 0.570313 );
    var_0.atmosfoghazestrength = 0.125;
    var_0.atmosfoghazespread = 0.295312;
    var_0.atmosfogextinctionstrength = 0.842188;
    var_0.atmosfoginscatterstrength = 19.2;
    var_0.atmosfoghalfplanedistance = 1000;
    var_0.atmosfogstartdistance = -231;
    var_0.atmosfogdistancescale = 3.525;
    var_0.atmosfogskydistance = 8000;
    var_0.atmosfogskyangularfalloffenabled = 0;
    var_0.atmosfogskyfalloffstartangle = 0;
    var_0.atmosfogskyfalloffanglerange = 296;
    var_0.atmosfogsundirection = ( 0.0378094, -0.736993, 0.674842 );
    var_0.atmosfogheightfogenabled = 1;
    var_0.atmosfogheightfogbaseheight = 897;
    var_0.atmosfogheightfoghalfplanedistance = 257;
}

sunflare()
{
    var_0 = maps\_utility::create_sunflare_setting( "default" );
    var_0.position = ( -43, 141, 0 );
    maps\_art::sunflare_changes( "default", 0 );
}