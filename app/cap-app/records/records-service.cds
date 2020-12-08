using {TimetrackingService as my} from '../../../srv/timetracking-service';

annotate my.Records with @odata.draft.enabled;
annotate my.Records with @(UI : {
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Admin}',
        Target : '@UI.FieldGroup#Admin'
    },
    ],
    FieldGroup #General : {Data : [
    {Value : title},
    {Value : description},
    {Value : employee_ID},
    {Value : project_ID},
    {Value : date},
    {Value : time},
    {Value : timeUnit},
    ]},
    FieldGroup #Admin   : {Data : [
    {Value : createdBy},
    {Value : createdAt},
    {Value : modifiedBy},
    {Value : modifiedAt}
    ]}
});