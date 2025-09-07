ensureGamemode() {
  if (GetDvar(#"g_gametype") != "tdm")
    return false;

  return true;
}

changeTeam(team) {
  self.pers["team"] = team;
  self.team = team;
  self maps\mp\gametypes\_globallogic_ui::updateObjectiveText();
  if (level.teamBased) {
    self.sessionteam = team;
  } else {
    self.sessionteam = "none";
    self.ffateam = team;
  }

  if (!isAlive(self)) {
    self.statusicon = "hud_status_dead";
  }

  self notify("joined_team");
  level notify("joined_team");

  self setClientDvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}
