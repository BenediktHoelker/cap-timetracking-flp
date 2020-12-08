using {TimetrackingService as my} from './timetracking-service';

service ProjectsService @(requires : 'authenticated-user') {
    entity Customers      as projection on my.Customers;
    // entity Employees      as projection on my.Employees;
    entity Records        as projection on my.Records;
    entity ProjectMembers as projection on my.ProjectMembers;

    @odata.draft.enabled
    @(restrict : [
    {
        grant : [
            'READ',
            'WRITE'
        ],
        to    : 'admin'
    },
    {
        grant : ['READ'],
        to    : 'project_manager',
        where : 'managerUserName = $user'
    }
    ])
    entity Projects       as projection on my.Projects;
}
