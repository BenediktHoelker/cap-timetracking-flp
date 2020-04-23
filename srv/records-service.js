module.exports = (srv) => {
  srv.before(["UPDATE"], "Records", (req) => {
    if (req.data.status !== "INITIAL") {
      return req.error(
        410,
        "The record has already been billed => Editing ist not allowed."
      );
    }
  });
};
