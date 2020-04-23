using {ProjectsService as my} from '../../../srv/projects-service';

annotate my.Projects with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : title},
        Description    : {Value : description}
    },
    Identification      : [{Value : title}],
    SelectionFields     : [
    title,
    description
    ],
    LineItem            : [
    {Value : title},
    {Value : description},
    {Value : customer.name},
    {Value : totalTime},
    {Value : recordsCount}
    ],
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Members}',
        Target : 'members/@UI.LineItem'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Admin}',
        Target : '@UI.FieldGroup#Admin'
    }
    ],
    FieldGroup #General : {Data : [
    {Value : title},
    {Value : description},
    {Value : customer_ID},
    {Value : billingFactor}
    ]},
    FieldGroup #Admin   : {Data : [
    {Value : createdBy},
    {Value : createdAt},
    {Value : modifiedBy},
    {Value : modifiedAt}
    ]}
});

annotate my.ProjectMembers with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Member}',
        TypeNamePlural : '{i18n>Members}',
        Title          : {Value : employee.name}
    },
    Identification      : [{Value : employee.name}],
    SelectionFields     : [employee.name],
    LineItem            : [{
        Value : employee.name,
        Label : '{i18n>Employee}'
    }],
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [{Value : employee_ID}]}
});

annotate my.ProjectMembers with {
    ID       @UI.Hidden;
    employee @(
        Common    : {
            Text         : employee.name,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Employees'},
        title     : '{i18n>Employee}'
    );
}
