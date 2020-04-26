using {TimetrackingService as my} from '../../common';

annotate my.Leaves with @(UI : {
    FieldGroup #General : {Data : [
    {Value : employee_ID},
    {Value : reason},
    {Value : status_status}
    ]},
    UI                  : {LineItem : [
    {Value : employee.name},
    {Value : reason},
    {Value : dateFrom},
    {Value : dateTo},
    {Value : daysOfLeave},
    {Value : status.title}
    ]}
}) {
    ID       @UI.Hidden;
    employee @(
        Common    : {
            Text         : employee.name,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Employees'}
    )
};

annotate my.LeaveStatus with {
    status @UI.Hidden;
}
