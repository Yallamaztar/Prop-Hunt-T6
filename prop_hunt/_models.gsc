getModels() {
  brushes  = GetEntArray("script_brushmodel", "classname");
  smodels = GetEntArray("script_model", "classname");
  for (i = 0; i < brushes.size; i++) {
    addModel(brushes[i].model);
    wait .01;
  }

  for (i = 0; i < smodels.size; i++) {
    addModel(smodels[i].model);
    wait .01;
  }

  precacheModels()
}

addModel(model) {
  if (!IsDefined(level.available_models)) {
    level.available_models = [];
  }

  if (!IsDefined(level.available_models[model])) {
    level.available_models[model] = model;
  }

  PrintLn("Added Model: " + model);
}

precacheModels() {
  foreach (model in level.available_models) {
    precachemodel(model);
  }
}
