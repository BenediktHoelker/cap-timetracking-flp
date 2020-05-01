module.exports = (srv) => {
  srv.before(["CREATE", "UPDATE"], "Employees", (req) => {
    const employeesProjects = req.data.projects;

    let seen = new Set();
    // https://stackoverflow.com/questions/30735465/how-can-i-check-if-the-array-of-objects-have-duplicate-property-values
    const hasDuplicateProjects = employeesProjects.some(
      (member) => seen.size === seen.add(member.project_ID).size
    );

    if (hasDuplicateProjects) {
      return req.error(410, "Duplicate projects are not allowed.");
    }
  });
};
