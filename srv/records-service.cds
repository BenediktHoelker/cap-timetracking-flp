using {TimetrackingService as my} from './timetracking-service';

service RecordsService {
    @odata.draft.enabled
    entity Records @(restrict : [
    {
        grant : ['READ'],
        to    : 'admin'
    },
    {
        grant : ['READ'],
        where : 'ID = $user'
    },
    ])                  as projection on my.Records actions {
        // bound actions/functions
        action createInvoice()
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
        where : 'ID = $user'
    }
    ])                  as projection on my.Employees

    entity Packages     as projection on my.Packages;
    entity Customers    as projection on my.Customers;
    entity Invoices     as projection on my.Invoices;
    entity InvoiceItems as projection on my.InvoiceItems;
    entity InvoicesView as projection on my.InvoicesView;

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
        where : 'ID = $user'
    }
    ])                  as projection on my.ProjectMembers;
}
