/* eslint-disable camelcase */
const reuse = require("./reuse-functions");
const cds = require("@sap/cds");

module.exports = async (srv) => {
  const db = await cds.connect.to("db"); // connect to database service
  const { Leaves } = db.entities; // get reflected definitions

  srv.before("NEW", "Leaves", async (req) => {
    const employee = await reuse.getEmployeeFromRequestUser(req);

    req.data.employee_ID = employee.ID;
    req.data.status_ID = "INITIAL";
    req.data.dateFrom = reuse.formatDate(Date.now());
  });

  srv.before(["SAVE"], "Leaves", (req) => {
    const { dateFrom, dateTo } = req.data;

    if (dateFrom > dateTo) {
      return req.error(410, "From-Date must no be greater than To-Date.");
    }

    req.data.daysOfLeave = getDaysBetween(dateFrom, dateTo);
  });

  srv.on("approve", "Leaves", async (req) => {
    const ID = req.params[0];

    await UPDATE(Leaves).set({ status_ID: "APPROVED" }).where({ ID: ID });
  });
};

function getDaysBetween(dateFrom, dateTo) {
  if (!dateFrom) {
    return 0;
  } else if (!dateTo) {
    return 1;
  } else if (dateFrom === dateTo) {
    return 1;
  }

  const oneDay = 24 * 60 * 60 * 1000;
  const firstDate = new Date(dateFrom);
  const secondDate = new Date(dateTo);
  const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));

  return Number.isInteger(diffDays) ? diffDays : 0;
}
