using {TimetrackingService as my} from './timetracking-service';

service LeavesService {
    @odata.draft.enabled
    entity Leaves    as projection on my.Leaves;

    entity Employees as projection on my.Employees;
}
