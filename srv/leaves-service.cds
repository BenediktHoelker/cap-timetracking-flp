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
        where : 'username = $user'
    }
    ])
    entity Leaves    as projection on my.Leaves actions {
        action approve() //Action requires context
    };

    entity Employees as projection on my.Employees;
}
