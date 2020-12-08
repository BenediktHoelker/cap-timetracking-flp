using {TimetrackingService as my} from './timetracking-service';

service LeavesService @(requires : 'authenticated-user') {
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
    // entity Leaves      as projection on my.Leaves actions {
    //     action approve(status : String @(
    //         Common : {
    //             Text      : {
    //                 $value                 : text,
    //                 ![@UI.TextArrangement] : #TextOnly
    //             },
    //             ValueList : {
    //                 entity : 'LeaveStatus',
    //                 type   : #fixed
    //             }
    //         },
    //         title  : '{i18n>Leaves.approve}'
    //     ))
    // };

    // entity Employees   as projection on my.Employees;
    entity LeaveStatus as projection on my.LeaveStatus;
}
