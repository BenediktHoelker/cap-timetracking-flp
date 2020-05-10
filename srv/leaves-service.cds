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
    entity Leaves      as projection on my.Leaves actions {
        action approve()
    // (status : LeaveStatus @(
    //     Common : {
    //         Text      : {
    //             $value                 : text,
    //             ![@UI.TextArrangement] : #TextOnly
    //         },
    //         ValueList : {entity : 'LeaveStatus'}
    //     },
    //     title  : '{i18n>Leaves.approve}'
    // ))
    };

    entity Employees   as projection on my.Employees;
    entity LeaveStatus as projection on my.LeaveStatus;
}
