/* eslint-disable camelcase */
module.exports = {
  getEmployeeFromRequestUser: async (req) => {
    //Get transaction of the request
    const tx = cds.transaction(req);

    const employees = await tx
      .read("my.timetracking.Employees")
      .where({ username: req.user.id });

    // Commented out because not working with Fiori Elements

    // if (employees.length === 0) {
    //   return req.error(410, `User ${req.user.id} could not be found.`);
    // }

    // if (employees.length > 1) {
    //   return req.error(
    //     410,
    //     `More than one users with username ${req.user.id} found.`
    //   );
    // }

    return employees.length > 0 ? employees[0] : {};
  },
};
