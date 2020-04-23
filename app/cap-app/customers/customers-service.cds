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
