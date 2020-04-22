/* global QUnit */

QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function() {
  "use strict";

  sap.ui.require([
    "iot/cap-timetracking/test/integration/AllJourneys"
  ], function() {
    QUnit.start();
  });
});
