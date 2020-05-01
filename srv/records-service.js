/* eslint-disable camelcase */
const reuse = require("./reuse-functions");

module.exports = (srv) => {
  srv.before("UPDATE", "Records", (req) => {
    if (req.data.status_ID !== "INITIAL") {
      req.error(
        410,
        "The record has already been billed => Editing ist not allowed."
      );
    }
  });

  srv.before("NEW", "Records", async (req) => {
    const employee = await reuse.getEmployeeFromRequestUser(req);

    req.data.employee_ID = employee.ID;
  });
};
