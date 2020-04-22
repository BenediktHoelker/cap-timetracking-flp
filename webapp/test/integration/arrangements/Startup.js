sap.ui.define([
  "sap/ui/test/Opa5"
], function(Opa5) {
  "use strict";

  return Opa5.extend("iot.cap-timetracking.test.integration.arrangements.Startup", {

    iStartMyApp: function () {
      this.iStartMyUIComponent({
        componentConfig: {
          name: "iot.cap-timetracking",
          async: true,
          manifest: true
        }
      });
    }

  });
});
