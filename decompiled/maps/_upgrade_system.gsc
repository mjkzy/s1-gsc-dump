// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    maps\_upgrade_challenge::init();
    maps\_upgrade_perks::init();
}

upgrade_is_purchased( var_0 )
{
    var_1 = self getlocalplayerprofiledata( "sp_upgradePurchased", var_0 ) == "1";
    return var_1;
}
