// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    self.a.movement = "stop";
    var_0 = self getturret();
    var_1 = 0;

    if ( issubstr( var_0.model, "_left" ) )
        var_1 = 1;

    if ( var_1 )
        self.primaryturretanim = %ziplinegunnerleft_aim;
    else
        self.primaryturretanim = %ziplinegunnerright_aim;

    self clearanim( %body, 0.2 );
    self setturretanim( self.primaryturretanim );
    self setanimknobrestart( self.primaryturretanim, 1, 0.2, 1 );
}
