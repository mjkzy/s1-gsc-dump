// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level thread _id_804D();
}

_id_804D()
{
    ambientplay( "amb_ext_urban_front" );
}

aud_lockdown_siren()
{
    playsoundatpos( ( -142.0, 6.0, 2550.0 ), "lockdown_siren" );
    wait 3;
    playsoundatpos( ( -142.0, 6.0, 2550.0 ), "lockdown_siren" );
    wait 3;
    playsoundatpos( ( -142.0, 6.0, 2550.0 ), "lockdown_siren" );
}
