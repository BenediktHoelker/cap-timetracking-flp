module.exports = (srv) => {
  srv.before("UPDATE", "Records", (req) => {
    if (req.data.status_ID !== "INITIAL") {
      req.error(
        410,
        "The record has already been billed => Editing ist not allowed."
      );
    }
  });

  srv.before("NEW", "Records", (req) => {
    req.data.employee_ID = req.user.id;
  });
};
