propAlert() {
  self maps\mp\gametypes\_hud_message::oldNotifyMessage(
    "You are a ^5Prop^7!",
    "Change your prop model and ^5hide  somewhere^7!",
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
  // let player play a taunt like a sound fx or some
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

detachModelOnDisconnect() {
  self endon("death");
  self endon("killed_player");
  
  self waittill("disconnect");
  self Delete();
}

initPropConfig() {
  self.pers["prop"] = Spawn("script_model", self.origin);
  self.pers["prop"].health = 1000;
  self.pers["prop"].owner  = self;
  self.pers["prop"].index  = RandomInt(level.available_models.size);
  self.pers["prop"] SetModel(level.available_models[self.pers["prop"].index);

  self.pers["prop"].rotate_attack             = SpawnStruct();
  self.pers["prop"].rotate_attack.value       = 0;
  self.pers["prop"].rotate_attack.check       = ::checkYawAttack;
  self.pers["prop"].rotate_attack.max         = -50;
  self.pers["prop"].rotate_attack.change_rate = 1;
  self.pers["prop"].rotate_attack.reset_rate  = 50;
  
  self.pers["prop"].rotate_ads             = SpawnStruct();
  self.pers["prop"].rotate_ads.value       = 0;
  self.pers["prop"].rotate_ads.check       = ::checkYawAds;
  self.pers["prop"].rotate_ads.max         = 50;
  self.pers["prop"].rotate_ads.change_rate = 1;
  self.pers["prop"].rotate_ads.reset_rate  = 50;

  self.pers["prop"].angles = self.angles;

  self.pers["prop"] SetCanDamage(true);
  self.pers["prop"] self thread detachModelOnDisconnect();
  self.pers["prop"] self thread attachModel();
}
