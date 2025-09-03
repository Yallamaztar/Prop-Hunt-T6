init() {
  level.started   = false;
  level.client_id = 0;
  
  level.prop_hunt       = SpawnStruct();
  level.prop_hunt.teams = SpawnStruct();
  level.prop_hunt.teams.props      = "allies";
  level.prop_hunt.teams.hunters    = "axis";
  level.prop_hunt.teams.spectators = "spectator";
  
  level.prematchPeriod = 5;
  level.isKillBoosting = false;

  if (!scripts\prop_hunt\_utils::ensureGamemode()) {
    PrintLn("^7Gamemode ^1must be ^3TDM ^7for ^3prop hunt");
    IPrintLnBold("Gamemode ^1must be ^3TDM ^7for ^3prop hunt");
    return;
  }

  // precaching models
  level scripts\prop_hunt\_models::getModels();
  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    
    player.client_id      = level.client_id;
    player.prop_hunt.team = undefined;  
    level.client_id++;

    PrintLn("^7[^4Prop Hunt^7] Player connected: ^3" + player.name + " ^7clientId: ^3" + player.client_id);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  level endon("game_ended");
  self endon("disconnect");
  
  first_spawn = true;

  for(;;) {
    self waittill("spawned_player");
    if (first_spawn) {
      // self FreezeControls(false);
      // self IPrintLn("^5Weclome ^7to Brow^5nies ^7Prop Hunt");
      
      if (level.started && isAlive(self)) {
        self Suicide();
        self scripts\prop_hunt\utils::changeTeam(
          level.prop_hunt.teams.spectator
        );
      }
    }
    first_spawn = false; 
  }
}
