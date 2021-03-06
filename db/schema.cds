namespace my.timetracking;

using {
  managed,
  cuid
} from '@sap/cds/common';

entity Records : cuid, managed {
  title       : String                          @mandatory  @title : '{i18n>Records.title}';
  description : String                          @title :             '{i18n>Records.description}';
  time        : Decimal(4, 2)                   @mandatory  @title : '{i18n>Records.time}';
  timeUnit    : String default 'h'              @readonly  @title  : '{i18n>Records.timeUnit}';
  date        : Date                            @mandatory  @title : '{i18n>Records.date}';
  status      : String                          @title :             '{i18n>Records.status}';
  invoiceItem : Association to InvoiceItems
                  on invoiceItem.record = $self @title :             '{i18n>Records.invoiceItem}';
  username    : String                          @title :             '{i18n>Records.username}';
  employee    : Association to Employees        @title :             '{i18n>Records.employee}';
  project     : Association to Projects         @title :             '{i18n>Records.project}';
}

@cds.odata.valuelist
@cds.autoexpose
entity RecordStatus {
  key ID   : String           @title : '{i18n>RecordStatus.key}';
      text : localized String @title : '{i18n>RecordStatus.title}';
}

entity Projects : cuid, managed {
  title           : String                   @title : '{i18n>Projects.title}';
  description     : String                   @title : '{i18n>Projects.description}';
  billingFactor   : Decimal(5, 2)            @title : '{i18n>Projects.billingFactor}';
  recordsCount    : Integer                  @title : '{i18n>Projects.recordsCount}';
  totalTime       : Integer                  @title : '{i18n>Projects.totalTime}';
  customer        : Association to Customers @title : '{i18n>Projects.customer}';
  manager         : Association to Employees @title : '{i18n>Projects.manager}';
  managerUserName : String                   @title : '{i18n>Projects.managerUserName}';
  packages        : Association to many Packages
                      on packages.project = $self;
  records         : Association to many Records
                      on records.project = $self;
  members         : Composition of many EmployeesToProjects
                      on members.project = $self;
}

entity Employees : cuid, managed {
  username      : String  @mandatory  @title : '{i18n>Employees.username}';
  name          : String  @mandatory  @title : '{i18n>Employees.name}';
  projectsCount : Integer @title :             '{i18n>Employees.projectsCount}';
  recordsCount  : Integer @title :             '{i18n>Employees.recordsCount}';
  daysOfTravel  : Integer @title :             '{i18n>Employees.daysOfTravel}';
  daysOfLeave   : Integer @title :             '{i18n>Employees.daysOfLeave}';
  billingTime   : Integer @title :             '{i18n>Employees.billingTime}';
  bonus         : Integer @title :             '{i18n>Employees.bonus}';
  manager       : Association to Employees;
  @title                         :             '{i18n>Employees.manager}'
  travels       : Association to many Travels
                    on travels.employee = $self;
  travelAggr    : Association to one TravelAggregations
                    on travelAggr.employee = $self;
  leaves        : Association to many Leaves
                    on leaves.employee = $self;
  leaveAggr     : Association to one LeaveAggregations
                    on leaveAggr.employee = $self;
  projects      : Composition of many EmployeesToProjects
                    on projects.employee = $self;
  records       : Association to many Records
                    on records.employee = $self;
}

entity EmployeesToProjects : cuid, managed {
  title    : String                   @title : '{i18n>EmployeesToProjects.title}';
  name     : String                   @title : '{i18n>EmployeesToProjects.name}';
  username : String                   @title : '{i18n>EmployeesToProjects.username}';
  project  : Association to Projects  @title : '{i18n>EmployeesToProjects.project}';
  employee : Association to Employees @title : '{i18n>EmployeesToProjects.employee}';
}

entity Customers : cuid, managed {
  name          : String  @title : '{i18n>Customers.name}';
  projectsCount : Integer @title : '{i18n>Customers.projectsCount}';
  projects      : Association to many Projects
                    on projects.customer = $self;
  invoices      : Association to many Invoices
                    on invoices.customer = $self;
}

entity Packages : cuid, managed {
  title       : String                  @title : '{i18n>Packages.title}';
  description : String                  @title : '{i18n>Packages.description}';
  project     : Association to Projects @title : '{i18n>Packages.project}';
}

entity Travels : cuid, managed {
  daysOfTravel  : Integer                  @readonly  @title  : '{i18n>Travels.daysOfTravel}';
  dateFrom      : Date                     @mandatory  @title : '{i18n>Travels.dateFrom}';
  dateTo        : Date                     @title    :          '{i18n>Travels.dateTo}';
  journey       : Decimal(4, 2)            @Measures :          durationUnit  @mandatory  @title : '{i18n>Travels.journey}';
  returnJourney : Decimal(4, 2)            @mandatory  @title : '{i18n>Travels.returnJourney}';
  durationUnit  : String default 'h'       @readonly  @title  : '{i18n>Travels.durationUnit}';
  project       : Association to Projects  @title    :          '{i18n>Travels.project}';
  employee      : Association to Employees @title    :          '{i18n>Travels.employee}';
}

@cds.autoexpose
entity TravelAggregations as
  select from Travels {
    key employee,
        sum(
          daysOfTravel
        ) as daysOfTravel @(title : '{i18n>Travels.daysOfTravel}') : Integer
  }
  group by
    employee;

entity Leaves : cuid, managed {
  reason      : String                     @title :             '{i18n>Leaves.reason}';
  dateFrom    : Date                       @mandatory  @title : '{i18n>Leaves.dateFrom}';
  dateTo      : Date                       @title :             '{i18n>Leaves.dateTo}';
  daysOfLeave : Integer                    @readonly  @title  : '{i18n>Leaves.daysOfLeave}';
  status      : Association to LeaveStatus @(
                  title  : '{i18n>Leaves.status}',
                  Common : {
                    Text         : {
                      $value                 : status.text,
                      ![@UI.TextArrangement] : #TextOnly
                    },
                    ValueList    : {
                      entity : 'LeaveStatus',
                      type   : #fixed
                    },
                    FieldControl : #Mandatory
                  }
                );
  username    : String                     @title :             '{i18n>Leaves.username}';
  employee    : Association to Employees   @title :             '{i18n>Leaves.employee}';
}

@cds.odata.valuelist
entity LeaveStatus {
  key ID   : String           @title : '{i18n>LeaveStatus.key}';
      text : localized String @title : '{i18n>LeaveStatus.title}';
}

@cds.autoexpose
entity LeaveAggregations  as
  select from Leaves {
    key employee,
        sum(
          daysOfLeave
        ) as daysOfLeave @(title : '{i18n>Leaves.daysOfLeave}') : Integer
  }
  group by
    employee;

view CustomersView as
  select from timetracking.Customers {
    *,
    count(
      projects.ID
    ) as projectsCount : Integer
  }
  group by
    Customers.ID,
    Customers.createdAt,
    Customers.createdBy,
    Customers.modifiedAt,
    Customers.modifiedBy,
    Customers.name;

entity Invoices : cuid, managed {
  title       : String                   @title : '{i18n>Invoices.title}';
  description : String                   @title : '{i18n>Invoices.description}';
  customer    : Association to Customers @title : '{i18n>Invoices.customer}';
  items       : Composition of many InvoiceItems
                  on items.invoice = $self;
}

entity InvoiceItems : cuid, managed {
  invoice : Association to Invoices;
  record  : Association to Records;
}

entity InvoicesView       as
  select from timetracking.Invoices {
    *,
    sum(
      items.record.time
    ) as amount : Double
  }
  group by
    Invoices.createdAt,
    Invoices.createdBy,
    Invoices.customer,
    Invoices.description,
    Invoices.ID,
    Invoices.modifiedAt,
    Invoices.modifiedBy,
    Invoices.title;
