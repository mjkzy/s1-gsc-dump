// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level thread setup_audio();
}

setup_audio()
{
    ambientplay( "amb_ext_urban_front" );
}

aud_lockdown_siren()
{
    playsoundatpos( ( -142, 6, 2550 ), "lockdown_siren" );
    wait 3;
    playsoundatpos( ( -142, 6, 2550 ), "lockdown_siren" );
    wait 3;
    playsoundatpos( ( -142, 6, 2550 ), "lockdown_siren" );
}
