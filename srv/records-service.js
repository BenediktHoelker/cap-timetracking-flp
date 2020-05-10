/* eslint-disable camelcase */
const reuse = require("./reuse-functions");
const cds = require("@sap/cds");

module.exports = async (srv) => {
  const db = await cds.connect.to("db"); // connect to database service
  const { Records } = db.entities; // get reflected definitions

  srv.before("UPDATE", "Records", (req) => {
    if (req.data.status !== "INITIAL") {
      req.error(
        410,
        "The record has already been billed => Editing ist not allowed."
      );
    }
  });

  srv.before("NEW", "Records", async (req) => {
    const employee = await reuse.getEmployeeFromRequestUser(req);

    req.data.employee_ID = employee.ID;
    req.data.date = reuse.formatDate(Date.now());
  });

  srv.on("settleUp", "Records", async (req) => {
    const ID = req.params[0];
    const invoice_ID = req.data.invoice;

    await UPDATE(Records).set({ invoice_ID: invoice_ID }).where({ ID: ID });
  });
};
