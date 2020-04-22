using {EmployeesService as my} from '../../../srv/employees-service';

annotate my.Employees with @(UI : {
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Projects}',
        Target : 'projects/@UI.LineItem'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Travels}',
        Target : 'travels/@UI.LineItem'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Leaves}',
        Target : 'leaves/@UI.LineItem'
    }
    ],
    FieldGroup #General : {Data : [{Value : name}]}
});

annotate my.Leaves with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Leave}',
        TypeNamePlural : '{i18n>Leaves}',
        Title          : {Value : reason}
    },
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Leaves.Dates}',
        Target : '@UI.FieldGroup#Dates'
    }
    ],
    FieldGroup #General : {Data : [
    {Value : reason},
    {Value : daysOfLeave},
    ]},
    FieldGroup #Dates   : {Data : [
    {Value : dateFrom},
    {Value : dateTo},
    ]},
    LineItem            : [
    {Value : reason},
    {Value : daysOfLeave},
    {Value : dateFrom},
    {Value : dateTo}
    ]
});

annotate my.Travels with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Travel}',
        TypeNamePlural : '{i18n>Travels}',
        Title          : {Value : dateFrom}
    },
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Travels.Dates}',
        Target : '@UI.FieldGroup#Dates'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Travels.Times}',
        Target : '@UI.FieldGroup#Times'
    }
    ],
    FieldGroup #General : {Data : [{Value : project_ID}]},
    FieldGroup #Dates   : {Data : [
    {Value : daysOfTravel},
    {Value : dateFrom},
    {Value : dateTo},
    ]},
    FieldGroup #Times   : {Data : [
    {Value : journey},
    {Value : returnJourney},
    {Value : durationUnit}
    ]},
    LineItem            : [
    {Value : project.title},
    {Value : daysOfTravel},
    {Value : dateFrom},
    {Value : dateTo},
    {Value : journey},
    {Value : returnJourney}
    ]
});

annotate my.ProjectMembers with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : project.title}
    },
    Identification      : [{Value : project_ID}],
    SelectionFields     : [project_ID],
    LineItem            : [{
        Value : project.title,
        Label : '{i18n>Project}'
    }],
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [{Value : project_ID}]}
});

annotate my.ProjectMembers with {
    ID      @UI.Hidden;
    project @(
        Common    : {
            Text         : project.title,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Projects'},
        title     : '{i18n>Project}'
    );
}

annotate my.Travels with {
    ID      @UI.Hidden;
    project @(
        Common    : {
            Text         : project.title,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Projects'},
        title     : '{i18n>Project}'
    );
}
