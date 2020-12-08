using {TimetrackingService as my} from '../../../srv/timetracking-service';


annotate my.InvoiceItems with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>InvoiceItem}',
        TypeNamePlural : '{i18n>InvoiceItems}',
        Title          : {Value : record.title}
    },
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [{Value : record_ID}]},
    LineItem            : [
    {Value : record.title},
    {Value : record.description},
    {
        Value : record.project.title,
        Label : '{i18n>Invoices.project}'
    },
    {
        Value : record.employee.name,
        Label : '{i18n>Invoices.employee}'
    }
    ]
});

annotate my.InvoiceItems with {
    ID     @UI.Hidden;
    record @(Common : {
        Text             : {
            $value                 : record.title,
            ![@UI.TextArrangement] : #TextOnly
        },
        ValueList.entity : 'Records',
        FieldControl     : #Mandatory
    })
}
