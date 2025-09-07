#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  level.started   = false;
  level.client_id = 0;
  
  level.prop_hunt.teams = SpawnStruct();
  level.prop_hunt.teams.props      = "allies";
  level.prop_hunt.teams.hunters    = "axis";
  level.prop_hunt.teams.spectators = "spectator";

  level thread scripts\prop_hunt\_models::getModels();
}

init() {
  if (!scripts\prop_hunt\_utils::ensureGamemode()) {
    PrintLn("^7Gamemode ^1must be ^3TDM ^7for ^3prop hunt");
    IPrintLnBold("Gamemode ^1must be ^3TDM ^7for ^3prop hunt");
    return;
  }

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
    
    if (self.pers["team"] == level.prop_hunt.teams.props) {
      scripts\prop_hunt\props::propLogic();
    }

    self scripts\prop_hunt\props::initPropConfig();
    self setclientuivisibilityflag("hud_visible", 0);
    self FreezeControls(false);

    if (first_spawn) {
      if (level.started && isAlive(self)) {
        self Suicide();
        self scripts\prop_hunt\_utils::changeTeam(
          level.prop_hunt.teams.spectators
        );
      }
      first_spawn = false; 
    }
    self thread monitorKeyPress();
  }
}

monitorKeyPress() {
    level endon("game_ended");
    self endon("killed_player");
    self endon("disconnect");
    self endon("death");

    if (!IsDefined(self.menu_active)) {
        self.menu_active = 0;
    }

    pressed = false;

    for (;;) {
      if (self.pers["team"] == level.prop_hunt.teams.hunters) { 
        return; 
      }

      if (self AdsButtonPressed() && self ActionSlotThreeButtonPressed()) {
        if (!pressed) {
          pressed = true;

          if (self.menu_active == 0) {
            self scripts\prop_hunt\_hud::createPropHuntMenu();
            self thread scripts\prop_hunt\_hud::animatePropHuntMenu("down");
            self thread scripts\prop_hunt\_hud::animatePropHuntMenuText("in");
            self.menu_active = 1;

          } else {
            self thread scripts\prop_hunt\_hud::animatePropHuntMenu("up");
            self thread scripts\prop_hunt\_hud::animatePropHuntMenuText("out");
            self scripts\prop_hunt\_hud::deletePropHuntMenu();
            self.menu_active = 0;
          }
        }
    } else {
        pressed = false; 
    }
    if (self.menu_active) {
      if (self ActionSlotThreeButtonPressed()) {
        self.pers["prop"].index += 1;
        PrintLn("Current Index: " + self.pers["prop"].index);
        wait 0.2;

        } else if (self ActionSlotFourButtonPressed()) {
          self.pers["prop"].index -= 1;

          PrintLn("Current Index: " + self.pers["prop"].index);
          wait 0.2;
        }
    }
  wait 0.05;
  }
}


// monitorKeyPress() {
//   level endon("game_ended");
//   self endon("killed_player");
//   self endon("build_mode");
//   self endon("disconnect");
//   self endon("death");
//
//   if (!IsDefined(self.menu_active)) {
//       self.menu_active = false;
//   }
//
//   for (;;) {
//     if (self ActionSlotThreeButtonPressed() && self AdsButtonPressed()) {
//       if (self.menu_active == false) {
//         self.menu_active = true;
//
//         self scripts\prop_hunt\_hud::createPropHuntMenu();
//         self thread scripts\prop_hunt\_hud::animatePropHuntMenu("down");
//         self scripts\prop_hunt\_hud::animatePropHuntMenuText("in");
//
//         // open menu
//
//         wait 1;
//
//       } else {
//         self.menu_active = false;
//
//         self thread scripts\prop_hunt\_hud::animatePropHuntMenu("up");
//         self scripts\prop_hunt\_hud::animatePropHuntMenuText("out");
//         self scripts\prop_hunt\_hud::deletePropHuntMenu();
//
//         wait 1;
//       }
//
//       wait 0.05;
//     }
//   }
//
//   if (self.menu_active) {
//     if (self ActionSlotThreeButtonPressed()) {
//       self.pers["prop"].index += 1;
//       PrintLn("Current Index: " + self.pers["prop"].index);
//       wait .5;
//     } else if (self ActionSlotFourButtonPressed()) {
//       self.pers["prop"].index -= 1;
//       PrintLn("Current Index: " + self.pers["prop"].index);
//       wait .5;
//     }
//     wait 0.05;
//   }
//   wait 0.05;
// }

// monitorKeyPress() {
//   level endon("game_ended");
//   self endon("killed_player");
//   self endon("build_mode");
//   self endon("disconnect");
//   self endon("death");
//
//   if (!IsDefined(self.menu_active)) {
//     self.menu_active = false;
//   }
//
//   for(;;) {
//     if (self AdsButtonPressed() && self MeleeButtonPressed()) {
//       if (!self.menu_active) {
//         self scripts\prop_hunt\_hud::createPropHuntMenu();
//         self thread scripts\prop_hunt\_hud::animatePropHuntMenu("down");
//         self thread scripts\prop_hunt\_hud::animatePropHuntMenuText();
//         // open menu
//         self.menu_active = true;
//       } else {
//         self thread scripts\prop_hunt\_hud::deletePropHuntMenu();
//         self.menu_active = false;
//       }
//       wait .05;
//     }
//
//     // if (self ActionSlotThreeButtonPressed() && IsDefined(self.pers["prop"]) && self.menu_active) {
//     //   self.pers["prop"].index += 1;
//     //   PrintLn("prop index: " + self.pers["prop"].index);
//     // }
//     //
//     // if (self ActionSlotFourButtonPressed() && IsDefined(self.pers["prop"]) && self.menu_active) {
//     //   self.pers["prop"].index -= 1;
//     //   PrintLn("prop index: " + self.pers["prop"].index);
//     // }
//
//     wait .05;
//   }
// }
