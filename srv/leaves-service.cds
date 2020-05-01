using {TimetrackingService as my} from './timetracking-service';

service LeavesService {
    @odata.draft.enabled

    @(restrict : [
    {
        grant : ['READ'],
        to    : 'admin'
    },
    {
        grant : ['READ'],
        where : 'ID = $user'
    }
    ])
    entity Leaves    as projection on my.Leaves;

    entity Employees as projection on my.Employees;
}
