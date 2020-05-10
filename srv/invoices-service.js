/* eslint-disable camelcase */
const cds = require("@sap/cds");

module.exports = async (srv) => {
  const db = await cds.connect.to("db"); // connect to database service
  const { Projects, Records, Customers, InvoiceItems } = db.entities; // get reflected definitions

  srv.before("CREATE", "Invoices", async (req) => {
    const tx = db.tx(req); //> ensure tenant isolation & transaction mgmt
    const { customer_ID } = req.data;

    const projects = await tx.read(Projects).where({ customer_ID });

    const records = await tx
      .read(Records)
      .where(projects.map((p) => `project_ID = '${p.ID}'`).join(" or "));

    // records.forEach((record) => srv.insert({}) .into (entity));
  });
};
