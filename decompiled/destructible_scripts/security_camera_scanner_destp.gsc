// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\_destructible::destructible_create( "security_camera_scanner_destp", "tag_origin", 10 );
    common_scripts\_destructible::destructible_fx_spawn_immediate( "tag_fx", "vfx/destructible/security_cam_scanner", 1, undefined, undefined, undefined, 1 );
    common_scripts\_destructible::destructible_fx( "tag_fx", "vfx/destructible/security_cam_scanner_xplod", 1 );
    common_scripts\_destructible::destructible_state( "tag_origin", "security_camera_01" );
}
