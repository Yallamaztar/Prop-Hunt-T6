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
  self.blindHunter SetShader("black", 1921, 5000);

  self hunterPreTimer();
  self disableBlindHunter();
}

disableBlindHunter() {
  self.blindHunter Destroy();
}

hunterPreTimer(timer=30) {
  for (i = timer; i > 0; i--) {
    self IprintLn("Starting ^5Prop Hunt ^7In " + i + "s");
    wait 1;
  }
}

hunterLogic() {
  return;
}
