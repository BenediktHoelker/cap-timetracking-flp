module.exports = (srv) => {
  srv.before(["CREATE", "UPDATE"], "Leaves", (req) => {
    req.data.daysOfLeave = getDaysBetween(req.data);
  });
};

function getDaysBetween({ dateFrom, dateTo }) {
  const oneDay = 24 * 60 * 60 * 1000;
  const firstDate = new Date(dateFrom);
  const secondDate = new Date(dateTo);
  const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));

  return Number.isInteger(diffDays) ? diffDays : 0;
}
