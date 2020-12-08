/* eslint-disable camelcase */
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

  srv.before(["PATCH"], "Projects", async (req) => {
    const manager = await getManagerEmployee(req, req.data.manager_ID);

    req.data.managerUserName = manager.username || "";
  });
};

const getManagerEmployee = async (req, manager_ID) => {
  //Get transaction of the request
  const tx = cds.transaction(req);

  const employees = await tx
    .read("my.timetracking.Employees")
    .where({ ID: manager_ID });

  return employees.length > 0 ? employees[0] : {};
};
