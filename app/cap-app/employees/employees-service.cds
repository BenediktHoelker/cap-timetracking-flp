using {TimetrackingService as my} from '../../../srv/timetracking-service';

annotate my.Employees with @odata.draft.enabled;
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
    FieldGroup #General : {Data : [
    {Value : name},
    {Value : username},
    {
        Value : manager_ID,
        Label : '{i18n>Manager}'
    }
    ]}
}) {
    manager @(
        Common    : {
            Text         : {
                $value                 : manager.name,
                ![@UI.TextArrangement] : #TextOnly
            },
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Employees'}
    );
};

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

annotate my.Travels with {
    ID      @UI.Hidden;
    project @(
        Common    : {
            Text         : {
                $value                 : project.title,
                ![@UI.TextArrangement] : #TextOnly
            },
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Projects'},
        title     : '{i18n>Project}'
    );
}
