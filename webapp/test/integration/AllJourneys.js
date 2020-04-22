sap.ui.define([
  "sap/ui/test/Opa5",
  "iot/cap-timetracking/test/integration/arrangements/Startup",
  "iot/cap-timetracking/test/integration/BasicJourney"
], function(Opa5, Startup) {
  "use strict";

  Opa5.extendConfig({
    arrangements: new Startup(),
    pollingInterval: 1
  });

});
