/* eslint-disable camelcase */
module.exports = (srv) => {
  srv.before("NEW", "Leaves", (req) => {
    req.data.employee_ID = req.user.id;
    req.data.status_ID = "INITIAL";
    req.data.dateFrom = formatDate(Date.now());
  });

  srv.before(["SAVE"], "Leaves", (req) => {
    const { dateFrom, dateTo } = req.data;

    if (dateFrom > dateTo) {
      return req.error(410, "From-Date must no be greater than To-Date.");
    }

    req.data.daysOfLeave = getDaysBetween(dateFrom, dateTo);
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

function formatDate(date) {
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
}
