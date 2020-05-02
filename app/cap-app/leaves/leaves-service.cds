using {TimetrackingService as my} from '../../common';

annotate my.Leaves with @(UI : {
    FieldGroup #General : {Data : [
    {Value : employee_ID},
    {Value : reason},
    {Value : status_ID}
    ]},
    UI                  : {LineItem : [
    {Value : employee.name},
    {Value : reason},
    {Value : dateFrom},
    {Value : dateTo},
    {Value : daysOfLeave},
    {Value : status.text}
    ]}
}) {
    ID       @UI.Hidden;
    employee @(
        Common    : {
            Text         : {
                $value                 : employee.name,
                ![@UI.TextArrangement] : #TextOnly
            },
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Employees'}
    );
};

annotate my.LeaveStatus with {
    ID @UI.Hidden;
}
