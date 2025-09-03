#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  level.started   = false;
  level.client_id = 0;
  
  level.prop_hunt.teams = SpawnStruct();
  level.prop_hunt.teams.props      = "allies";
  level.prop_hunt.teams.hunters    = "axis";
  level.prop_hunt.teams.spectators = "spectator";
}

init() {
  if (!scripts\prop_hunt\_utils::ensureGamemode()) {
    PrintLn("^7Gamemode ^1must be ^3TDM ^7for ^3prop hunt");
    IPrintLnBold("Gamemode ^1must be ^3TDM ^7for ^3prop hunt");
    return;
  }
  
  // scripts\prop_hunt\_models::clearAvailableModels(); // clearing older models
  // scripts\prop_hunt\_models::getModels(); // precaching models from current map

  level.prematchPeriod = 5;
  level.isKillBoosting = false;

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    
    player.client_id      = level.client_id;
    player.prop_hunt.team = undefined;  
    level.client_id++;

    PrintLn("^7[^4Prop Hunt^7] Player connected: ^3" + player.name + " ^7clientId: ^3" + player.client_id);
    player thread scripts\prop_hunt\_hud::createPropHuntHud();
    player thread scripts\prop_hunt\_hud::createPropHuntMenu();
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  level endon("game_ended");
  self endon("disconnect");

  first_spawn = true;

  for(;;) {
    self waittill("spawned_player");
    self setclientuivisibilityflag("hud_visible", 0);
    self scripts\prop_hunt\props::initPropConfig();
    self thread monitorKeyPress();
    if (first_spawn) {
      // self FreezeControls(false);
      if (level.started && isAlive(self)) {
        self Suicide();
        self scripts\prop_hunt\utils::changeTeam(
          level.prop_hunt.teams.spectators
        );
      }
      first_spawn = false; 
    }
  }
}

monitorKeyPress() {
  level endon("game_ended");
  self endon("killed_player");
  self endon("build_mode");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    if (self adsbuttonpressed() && self meleebuttonpressed()) {
      player thread scripts\prop_hunt\_hud::animatePropHuntMenu();
      player thread scripts\prop_hunt\_hud::animatePropHuntMenuText();
      // open menu
    }
    if (self ActionSlotThreeButtonPressed() && IsDefined(self.pers["prop"]) && self.pers["mode"] == "normal") {
      self.pers["prop"].index += 1;
      PrintLn("prop index: " + self.pers["prop"].index);
    }

    wait .01;
  }
}
