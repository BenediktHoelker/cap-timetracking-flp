const cds = require("@sap/cds");
const { Leaves } = cds.entities;

module.exports = (srv) => {
  srv.before(["CREATE", "UPDATE"], "Employees", (req) => {
    req.data.leaves.forEach(
      (leave) => (leave.daysOfLeave = getDaysBetween(leave))
    );

    req.data.travels.forEach(
      (travel) => (travel.daysOfTravel = getDaysBetween(travel))
    );

    // req.data.daysOfLeave = req.data.leaves.reduce(
    //   (acc, curr) => acc + curr.daysOfLeave,
    //   0
    // );

    // req.data.daysOfTravel = req.data.travels.reduce(
    //   (acc, curr) => acc + curr.daysOfTravel,
    //   0
    // );
  });
};

function getDaysBetween({ dateFrom, dateTo }) {
  const oneDay = 24 * 60 * 60 * 1000;
  const firstDate = new Date(dateFrom);
  const secondDate = new Date(dateTo);
  const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));

  return Number.isInteger(diffDays) ? diffDays : 0;
}
