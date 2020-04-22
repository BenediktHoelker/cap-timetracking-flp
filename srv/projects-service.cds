using {TimetrackingService as my} from './timetracking-service';

service ProjectsService @(requires : 'admin') {
    entity Customers      as projection on my.Customers;
    entity Employees      as projection on my.Employees;
    entity Records        as projection on my.Records;
    entity ProjectMembers as projection on my.ProjectMembers;

    @odata.draft.enabled
    entity Projects       as projection on my.Projects;
}
