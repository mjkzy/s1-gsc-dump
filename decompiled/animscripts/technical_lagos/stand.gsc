// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    self.desired_anim_pose = "stand";
    animscripts\utility::updateanimpose();
    self.a.movement = "stop";
    var_0 = self _meth_8194();
    var_0 thread turretinit( self );
    self.primaryturretanim = %technicalgunner_aim;
    self.additiveturretidle = %technical_turret_driveidle;
    self.additiveturretfire = %technical_turret_firing;
    self.painfunction = ::technical_pain;
    self.deathanim = %technical_turret_death;
    thread animscripts\technical_lagos\common::main( var_0 );
}

technical_pain()
{
    self _meth_8110( "painanim", %technical_turret_pain, %body, 1, 0.1, 1 );
    animscripts\shared::donotetracks( "painanim" );
}

#using_animtree("mg42");

turretinit( var_0 )
{
    self.leftarc = 115;
    self.rightarc = 115;
    self _meth_8115( #animtree );
    self.additiveturretidle = %saw_gunner_idle_mg;
    self.additiveturretfire = %saw_gunner_firing_mg_add;
    self endon( "death" );
    var_0 waittill( "killanimscript" );
    self _meth_8116();
}
