#include maps\mp\gametypes\_hud_util;

createPropHuntHud() {
  self.hudTextBottomLeft = createServerFontString("bigfixed", 1);
  self.hudTextBottomLeft SetText("Brow^5nies ^7Prop ^5Hunt");
  self.hudTextBottomLeft SetPoint("BOTTOM_LEFT", "BOTTOM_LEFT", 0, 30);
  self.hudTextBottomLeft.sort = 2;
  
  self.hudTextBottomRight = createServerFontString("bigfixed", 1);
  self.hudTextBottomRight SetText("Press ^5[{+actionslot 3}] ^7& ^5[{+speed_throw}] To Open Menu");
  self.hudTextBottomRight SetPoint("BOTTOM_RIGHT", "BOTTOM_RIGHT", 0, 30);
  self.hudTextBottomRight.sort = 2;

  self.hudBottom = newClientHudElem(self);
  self.hudBottom SetShader("black", 1920, 30);
  self.hudBottom.alignx = "center";
  self.hudBottom.aligny = "bottom";
  self.hudBottom.horzalign = "user_center";
  self.hudBottom.vertalign = "user_bottom";
  self.hudBottom.alpha = 0.7;
  self.hudBottom.sort = 1;
}

createPropHuntMenu() {
  self.hudTextTop = createServerFontString("bigfixed", 1);
  self.hudTextTop SetText("^5Choose ^7Prop With ^5[{+gostand}] ^7- Navigate With ^5[{+actionslot 3}] ^7& ^5[{+actionslot 4}]");
  self.hudTextTop SetPoint("CENTER", "TOP", 0, -22);
  self.hudTextTop.sort = 2;
  self.hudTextTop.alpha = 0;

  self.hudTop = newClientHudElem(self);
  self.hudTop SetShader("black", 1920, 30);
  self.hudTop.y = -30;
  self.hudTop.alignx = "center";
  self.hudTop.aligny = "top";
  self.hudTop.horzalign = "user_center";
  self.hudTop.vertalign = "user_top";
  self.hudTop.alpha = 0.7;
  self.hudTop.sort = 1;
}

animatePropHuntMenu(toggle) {
  if (toggle == "down") {
    for(i = 0; i < 24; i++) {
      self.hudTop.y += 1.25;
      wait .001;
    }
  } 
  else if (toggle == "up") {
    for(i = 0; i < 25; i++) {
      self.hudTop.y -= 1.25;
      wait .001;
    }
  }
}

animatePropHuntMenuText(toggle) {
  if (toggle == "in") {
    for(i = 0; i < 25; i++) {
      self.hudTextTop.alpha += 0.04;
      wait .001;
    }
  } else if (toggle == "out") {
    for(i = 0; i < 25; i++) {
      self.hudTextTop.alpha -= 0.04;
      wait .01;
    }
  }
}

deletePropHuntMenu() {
  wait 1;
  self.hudTop Delete();
  self.hudTextTop Destroy();
}

// init()
// {
// 	level thread onplayerconnect();
// 	game["strings"]["match_begins_in"] = "^1@Brownies ^7Starting In...";
// 	game["strings"]["match_starting_in"] = "^1@Brownies ^7Starting In...";
// }
//
// OnPlayerConnect()
// {
// 	level endon("game_ended");
// 	for (;;)
// 	{
// 		level waittill("connected", player);
// 		player thread customendgame();
// 	}
// }
//
// customendgame()
// {
// 		game[ "strings" ][ "draw" ] = "^1@Brownies";
// 		game[ "strings" ][ "round_draw" ] = "^1@Brownies";
// 		game[ "strings" ][ "round_win" ] = "^1@Brownies ^0(Win)";
// 		game[ "strings" ][ "round_loss" ] = "^1@Brownies ^0(Loss)";
// 		game[ "strings" ][ "victory" ] = "^1@Brownies ^0(Victory)";
// 		game[ "strings" ][ "defeat" ] = "^1@Brownies ^0(Defeat)";
// 		game[ "strings" ][ "game_over" ] = "^1@Brownies";
// 		game[ "strings" ][ "halftime" ] = "^1@Brownies";
// 		game[ "strings" ][ "overtime" ] = "^1@Brownies";
// 		game[ "strings" ][ "roundend" ] = "^1@Brownies";
// 		game[ "strings" ][ "intermission" ] = "^1@Brownies";
// 		game[ "strings" ][ "side_switch" ] = "^1@Brownies";
// 		game[ "strings" ][ "tie" ] = "^1@Brownies";
// 		game[ "strings" ][ "score_limit_reached" ] = "^0FUCK FRENCHIES";
// 		game[ "strings" ][ "time_limit_reached" ] = "^0FUCK FRENCHIES";
// }

