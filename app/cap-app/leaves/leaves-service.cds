using {LeavesService as my} from '../../../srv/leaves-service';

annotate my.Leaves with @(UI : {
    FieldGroup #General : {Data : [
    {Value : employee_ID},
    {Value : reason},
    {Value : status_ID}
    ]},
    LineItem            : [
    {Value : employee.name},
    {Value : reason},
    {Value : daysOfLeave},
    {Value : dateFrom},
    {Value : dateTo},
    {Value : status.text},
    {
        $Type  : 'UI.DataFieldForAction',
        Value  : ID,
        Label  : 'Approve',
        Action : 'LeavesService.approve'
    },
    ]
}) {
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
