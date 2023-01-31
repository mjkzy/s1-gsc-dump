// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    self.a.movement = "stop";
    var_0 = self _meth_8194();
    var_1 = 0;

    if ( issubstr( var_0.model, "_left" ) )
        var_1 = 1;

    if ( var_1 )
        self.primaryturretanim = %ziplinegunnerleft_aim;
    else
        self.primaryturretanim = %ziplinegunnerright_aim;

    self _meth_8142( %body, 0.2 );
    self _meth_8193( self.primaryturretanim );
    self _meth_8145( self.primaryturretanim, 1, 0.2, 1 );
}
