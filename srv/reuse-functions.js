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

  formatDate: function (date) {
    // https://stackoverflow.com/questions/23593052/format-javascript-date-as-yyyy-mm-dd
    var d = new Date(date),
      month = "" + (d.getMonth() + 1),
      day = "" + d.getDate(),
      year = d.getFullYear();

    if (month.length < 2) {
      month = `0${month}`;
    }
    if (day.length < 2) day = "0" + day;

    return [year, month, day].join("-");
  },
};
