using {CustomersService as my} from '../../../srv/customers-service';

annotate my.Customers with @(UI : {
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
    }
    ],
    FieldGroup #General : {Data : [
    {Value : name},
    {Value : projectsCount}
    ]}
});

annotate my.Customers with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Customer}',
        TypeNamePlural : '{i18n>Customers}',
        Title          : {Value : name}
    },
    Identification  : [{Value : name}],
    SelectionFields : [name],
    LineItem        : [
    {Value : name},
    {Value : projectsCount}
    ]
});
