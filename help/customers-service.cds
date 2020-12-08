using {TimetrackingService as my} from './timetracking-service';

service CustomersService @(requires : 'admin') {
    entity Records   as select from my.Records;

    @odata.draft.enabled
    entity Customers as projection on my.Customers;

    entity Projects  as projection on my.Projects;
}
