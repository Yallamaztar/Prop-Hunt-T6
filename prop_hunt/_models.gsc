getModels() {
  smodels = GetEntArray("script_model", "classname");
  for (i = 0; i < smodels.size; i++) {
    if (smodels[i] != undefined || smodels[i] != "") {
      addModel(smodels[i].model);
    }
  }
  precacheModels();
}

addModel(model) {
  if (!IsDefined(level.available_models)) {
    level.available_models = [];
  }

  if (!IsDefined(level.available_models[model])) {
    level.available_models[model] = model;
    PrintLn("Added Model: " + model);
  }
}

precacheModels() {
  foreach (model in level.available_models) {
    precachemodel(model);
  }
}

clearAvailableModels() {
  if (IsDefined(level.available_models)) {
    level.available_models = [];
    PrintLn("available_models cleared");
  }
}
