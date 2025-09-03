hunterAlert() {
  self maps\mp\gametypes\_hud_message::oldNotifyMessage(
    "You are a ^1hunter^7!", 
    "Wait till the props are hidden, then ^1find and kill ^7them!",
    undefined, undefined, undefined,
    7.5
  );
}

enableBlindHunter() {
  self.blindHunter = newClientHudElem(self);
  self.blindHunter SetShader( "black", 1920, 5000 );

  self hunterPreTimer();
  self disableBlindHunter();
}

disableBlindHunter() {
  self.blindHunter Destroy();
}

hunterPreTimer(j=10) {
  for (i = j; i > 0; i--) {
    self IprintLn("Starting ^5Prop Hunt ^7In " + i + "s");
    wait 1;
  }
}

hunterLogic() {
  return;
}
