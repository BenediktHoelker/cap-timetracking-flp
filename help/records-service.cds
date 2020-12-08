using {TimetrackingService as my} from './timetracking-service';

service RecordsService @(requires : 'authenticated-user') {
    @odata.draft.enabled
    entity Records                       @(restrict : [
    {
        grant : ['READ'],
        to    : 'admin'
    },
    {
        grant : ['READ'],
        where : 'username = $user'
    },
    ])                  as projection on my.Records actions {
                                         @(requires : 'admin')
        action settleUp(invoice : String @(
            Common : {
                Text         : {
                    $value                 : title,
                    ![@UI.TextArrangement] : #TextOnly
                },
                FieldControl : #Mandatory,
                ValueList    : {

                entity : 'Invoices'}
            },
            title  : '{i18n>Records.invoice}'
        ))
    };

    entity Projects     as projection on my.Projects

    entity Employees @(restrict : [
    {
        grant : [
            'READ',
            'WRITE'
        ],
        to    : 'admin'
    },
    {
        grant : 'READ',
        where : 'username = $user'
    }
    ])                  as projection on my.Employees

    entity Packages     as projection on my.Packages;
    entity Customers    as projection on my.Customers;
    entity Invoices     as projection on my.Invoices;
    entity InvoiceItems as projection on my.InvoiceItems;

    entity ProjectMembers @(restrict : [
    {
        grant : [
            'READ',
            'WRITE'
        ],
        to    : 'admin'
    },
    {
        grant : 'READ',
        where : 'username = $user'
    }
    ])                  as projection on my.ProjectMembers;
}
