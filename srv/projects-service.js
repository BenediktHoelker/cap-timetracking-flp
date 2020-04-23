module.exports = (srv) => {
  srv.before(["CREATE", "UPDATE"], "Projects", (req) => {
    const members = req.data.members;

    let seen = new Set();
    // https://stackoverflow.com/questions/30735465/how-can-i-check-if-the-array-of-objects-have-duplicate-property-values
    const hasDuplicateMembers = members.some(
      (member) => seen.size === seen.add(member.employee_ID).size
    );

    if (hasDuplicateMembers) {
      return req.error(410, "Duplicate members are not allowed.");
    }
  });
};
