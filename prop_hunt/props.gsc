// Ideas:
// - prop is able to play a taunt (soundFx) 

propAlert() {
  self maps\mp\gametypes\_hud_message::oldNotifyMessage(
    "You are a ^5Prop^7!",
    "Change your prop model and ^5hide somewhere^7!",
    undefined, undefined, undefined,
    7.5
  );
}

propLogic() {
  self Hide();
  self AllowADS(false);
  self DisableWeapons();
  self TakeAllWeapons();

  self SetClientDvar("cg_thirdPerson", true);
  self scripts\prop_hunt\utils::changeTeam("axis");
}

undoPropLogic() {
  self Show();
  self AllowADS(true);
  self EnableWeapons();
  self SetClientDvar("cg_thirdPerson", false);
}

attachModel() {
  self endon("killed_player");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self MoveTo(player.origin, 0.1);
    wait .05;  
  }
}

detachModel() {
  self endon("death");
  self endon("killed_player");
  
  self waittill("disconnect");
  self Delete();
}
