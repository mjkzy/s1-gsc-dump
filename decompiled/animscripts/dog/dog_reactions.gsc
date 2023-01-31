// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level.shark_functions ) )
    {
        if ( issubstr( self.model, "shark" ) )
        {
            self [[ level.shark_functions["reactions"] ]]();
            return;
        }
    }
}
