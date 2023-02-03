// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("dog");

main()
{
    if ( isdefined( level.shark_functions ) )
    {
        if ( issubstr( self.model, "shark" ) )
        {
            self [[ level.shark_functions["init"] ]]();
            return;
        }
    }

    self useanimtree( #animtree );
    initdoganimations();
    initdogarchetype();
    animscripts\init::firstinit();
    self.ignoresuppression = 1;
    self.newenemyreactiondistsq = 0;
    self.chatinitialized = 0;
    self.nododgemove = 1;
    self.root_anim = %body;
    self.meleeattackdist = 0;
    thread setmeleeattackdist();
    self.a = spawnstruct();
    self.a.pose = "stand";
    self.a.nextstandinghitdying = 0;
    self.a.movement = "run";
    animscripts\init::set_anim_playback_rate();
    self.suppressionthreshold = 1;
    self.disablearrivals = 0;
    self.stopanimdistsq = anim.dogstoppingdistsq;
    self.usechokepoints = 0;
    self.turnrate = 0.2;
    thread animscripts\combat_utility::monitorflash();
    self.pathenemyfightdist = 512;
    self settalktospecies( "dog" );
    self.health = int( anim.dog_health * self.health );
}

setmeleeattackdist()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.enemy ) && isplayer( self.enemy ) )
            self.meleeattackdist = anim.dogattackplayerdist;
        else
            self.meleeattackdist = anim.dogattackaidist;

        self waittill( "enemy" );
    }
}

initdoganimations()
{
    if ( !isdefined( level.dogsinitialized ) )
    {
        level.dogsinitialized = 1;
        precachestring( &"SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING" );
        precachestring( &"SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE" );
        precachestring( &"SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON" );
        precachestring( &"SCRIPT_PLATFORM_DOG_HINT" );
        precachestring( &"NEW_DOG_DEATH_DO_NOTHING_ALT" );
        precachestring( &"NEW_DOG_DEATH_TOO_LATE_ALT" );
        precachestring( &"NEW_DOG_DEATH_TOO_SOON_ALT" );
    }

    if ( isdefined( anim.notfirsttimedogs ) )
        return;

    precacheshader( "hud_dog_melee" );
    precacheshader( "hud_hyena_melee" );
    anim.notfirsttimedogs = 1;
    anim.dogstoppingdistsq = lengthsquared( getmovedelta( %iw6_dog_attackidle_runin_8, 0, 1 ) * 3 );
    anim.dogstartmovedist = length( getmovedelta( %iw6_dog_attackidle_runout_8, 0, 1 ) );
    anim.dogattackplayerdist = 102;
    var_0 = getstartorigin( ( 0, 0, 0 ), ( 0, 0, 0 ), %iw6_dog_kill_front_quick_1 );
    anim.dogattackaidist = length( var_0 );
    anim.dogtraverseanims = [];
    anim.dogtraverseanims["wallhop"] = %iw6_dog_traverse_over_24;
    anim.dogtraverseanims["window_40"] = %iw6_dog_traverse_over_36;
    anim.dogtraverseanims["jump_down_40"] = %iw6_dog_traverse_down_40;
    anim.dogtraverseanims["jump_down_24"] = %iw6_dog_traverse_down_24;
    anim.dogtraverseanims["jump_up_24"] = %iw6_dog_traverse_up_24;
    anim.dogtraverseanims["jump_up_40"] = %iw6_dog_traverse_up_40;
    anim.dogtraverseanims["jump_up_80"] = %iw6_dog_traverse_up_70;
    anim.dogtraverseanims["jump_down_70"] = %iw6_dog_traverse_down_70;
    anim.doglookpose["attackIdle"][2] = %german_shepherd_attack_look_down;
    anim.doglookpose["attackIdle"][4] = %german_shepherd_attack_look_left;
    anim.doglookpose["attackIdle"][6] = %german_shepherd_attack_look_right;
    anim.doglookpose["attackIdle"][8] = %german_shepherd_attack_look_up;
    anim.doglookpose["normal"][2] = %german_shepherd_look_down;
    anim.doglookpose["normal"][4] = %german_shepherd_look_left;
    anim.doglookpose["normal"][6] = %german_shepherd_look_right;
    anim.doglookpose["normal"][8] = %german_shepherd_look_up;
    level._effect["dog_bite_blood"] = loadfx( "fx/impacts/deathfx_dogbite" );
    level._effect["deathfx_bloodpool"] = loadfx( "fx/impacts/deathfx_bloodpool_view" );
    var_1 = 5;
    var_2 = [];

    for ( var_3 = 0; var_3 <= var_1; var_3++ )
        var_2[var_2.size] = var_3 / var_1;

    level.dog_melee_index = 0;
    level.dog_melee_timing_array = common_scripts\utility::array_randomize( var_2 );
    setdvar( "friendlySaveFromDog", "0" );
}

initdogarchetype()
{
    animscripts\animset::init_anim_sets();

    if ( animscripts\animset::archetypeexists( "dog" ) )
        return;

    anim.archetypes["dog"] = [];
    animscripts\dog\dog_stop::initdogarchetype_stop();
    animscripts\dog\dog_move::initdogarchetype_move();
    animscripts\dog\dog_pain::initdogarchetype_reaction();
    animscripts\dog\dog_death::initdogarchetype_death();
}
