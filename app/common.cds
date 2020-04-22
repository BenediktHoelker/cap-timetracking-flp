/*
  Common Annotations shared by all apps
*/

using {TimetrackingService as my} from '../srv/timetracking-service';

annotate my.Records with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Record}',
        TypeNamePlural : '{i18n>Records}',
        Title          : {Value : title},
        Description    : {Value : description}
    },
    Identification  : [{Value : title}],
    SelectionFields : [
    title,
    description,
    projectMember.title,
    projectMember.name,
    date
    ],
    LineItem        : [
    {Value : title},
    {
        Value : projectMember.title,
        Label : '{i18n>Project}'
    },
    {
        Value : projectMember.name,
        Label : '{i18n>Employee}'
    },
    {Value : description},
    {Value : date},
    {Value : time},
    {Value : status},
    ]
});

annotate my.Records with {
    ID            @UI.Hidden;
    description   @UI.MultiLineText;
    projectMember @(Common : {
        Text             : projectMember.projectMember,
        FieldControl     : #Mandatory,
        ValueList.entity : 'ProjectMembers'
    });
}

annotate my.Projects with {
    ID       @UI.Hidden;
    ID       @(
        Common : {
            Text         : title,
            FieldControl : #Mandatory
        },
        title  : '{i18n>ProjectID}',
    );
    customer @(Common : {
        Text             : customer.name,
        FieldControl     : #Mandatory,
        ValueList.entity : 'Customers'
    });
}

annotate my.Projects with @(UI : {
    Identification  : [{Value : title}],
    SelectionFields : [title],
    LineItem        : [
    {Value : title},
    {Value : description}
    ]
});

annotate my.Employees with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Employee}',
        TypeNamePlural : '{i18n>Employees}',
        Title          : {Value : name}
    },
    Identification  : [{Value : name}],
    SelectionFields : [name],
    LineItem        : [
    {Value : name},
    {Value : recordsCount},
    {Value : billingTime},
    {Value : bonus},
    {Value : leaveAggr.daysOfLeave},
    {Value : travelAggr.daysOfTravel}
    ]
});
