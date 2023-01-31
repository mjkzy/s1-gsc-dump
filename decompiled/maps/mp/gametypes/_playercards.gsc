// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level thread onplayerconnect();
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );

        if ( !isai( var_0 ) )
        {

        }
    }
}
