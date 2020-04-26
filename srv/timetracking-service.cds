using {my.timetracking as my} from '../db/schema';

service TimetrackingService {
    entity Records            as
        select from my.Records {
            *,
            case
                when
                    invoiceItem.ID is null
                then
                    'INITIAL'
                else
                    'BILLED'
            end as status @(title : '{i18n>Records.status}') : String
        }
        order by
            Records.createdAt desc;

    entity Projects           as
        select from my.Projects {
            key ID,
                title,
                description,
                billingFactor,
                count(
                    members.records.ID
                ) as recordsCount @(title : '{i18n>Projects.recordsCount}') : Integer,
                sum(
                    members.records.time
                ) as totalTime    @(title : '{i18n>Projects.totalTime}')    : Decimal(13, 2),
                createdAt,
                createdBy,
                modifiedAt,
                modifiedBy,
                customer,
                manager,
                members                                                     : redirected to ProjectMembers
        }
        group by
            Projects.ID,
            Projects.title,
            Projects.description,
            Projects.createdAt,
            Projects.createdBy,
            Projects.modifiedAt,
            Projects.modifiedBy,
            Projects.billingFactor,
            Projects.manager,
            Projects.customer;

    entity Employees          as
        select from my.Employees {
            key ID,
                createdAt,
                createdBy,
                modifiedAt,
                modifiedBy,
                name,
                username,
                daysOfLeave,
                daysOfTravel,
                round(
                    sum(
                        projects.records.time
                    ), 2
                ) as billingTime  @(title : '{i18n>Employees.billingTime}')  : Double,
                count(
                    projects.records.ID
                ) as recordsCount @(title : '{i18n>Employees.recordsCount}') : Integer,
                round(
                    sum(
                        (
                            projects.records.time
                        ) / 1440
                    ), 2
                ) as bonus        @(title : '{i18n>Employees.bonus}')        : Double,
                manager,
                projects                                                     : redirected to ProjectMembers,
                travels                                                      : redirected to Travels,
                travelAggr,
                leaves                                                       : redirected to Leaves,
                leaveAggr
        }
        group by
            Employees.ID,
            Employees.createdAt,
            Employees.createdBy,
            Employees.modifiedAt,
            Employees.modifiedBy,
            Employees.name,
            Employees.username,
            Employees.manager,
            Employees.daysOfLeave,
            Employees.daysOfTravel;


    entity Packages           as projection on my.Packages;

    entity Customers          as
        select from my.Customers {
            *,
            count(
                projects.ID
            ) as projectsCount @(title : '{i18n>Customers.projectsCount}') : Integer,
            invoices                                                       : redirected to Invoices
        }
        group by
            Customers.ID,
            Customers.createdAt,
            Customers.createdBy,
            Customers.modifiedAt,
            Customers.modifiedBy,
            Customers.name;


    entity Invoices           as projection on my.Invoices;

    entity InvoiceItems       as projection on my.InvoiceItems {
        * , invoice : redirected to Invoices
    };

    entity Leaves             as projection on my.Leaves;
    entity LeaveAggregations  as projection on my.LeaveAggregations;
    entity Travels            as projection on my.Travels;
    entity TravelAggregations as projection on my.TravelAggregations;
    entity InvoicesView       as projection on my.InvoicesView;

    entity ProjectMembers     as
        select from my.EmployeesToProjects {
            *,
            project.title,
            project.title || ' - ' || employee.name as projectMember @(title : '{i18n>ProjectMembers.projectMember}') : String,
            employee.username,
            employee.name
        };
}
