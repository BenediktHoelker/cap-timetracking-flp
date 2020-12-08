using {TimetrackingService as my} from './timetracking-service';

service InvoicesService @(requires : 'admin') {
    entity Customers      as projection on my.Customers;
    // entity Employees      as projection on my.Employees;
    entity Records        as projection on my.Records;
    // entity Projects       as projection on my.Projects;
    entity ProjectMembers as projection on my.ProjectMembers;

    @odata.draft.enabled
    entity Invoices       as projection on my.Invoices;

    entity InvoiceItems   as projection on my.InvoiceItems;
}
