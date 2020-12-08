using {my.timetracking as my} from '../db/schema';

service TimetrackingService {
  entity Records                     @(restrict : [
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

  @(restrict : [
  {
    grant : [
      'READ',
      'WRITE'
    ],
    to    : 'admin'
  },
  {
    grant : ['READ'],
    to    : 'project_manager',
    where : 'managerUserName = $user'
  }
  ])
  entity Projects     as
    select from my.Projects {
      key ID,
          title,
          description,
          billingFactor,
          count(
            records.ID
          ) as recordsCount @(title : '{i18n>Projects.recordsCount}') : Integer,
          sum(
            records.time
          ) as totalTime    @(title : '{i18n>Projects.totalTime}')    : Decimal(13, 2),
          createdAt,
          createdBy,
          modifiedAt,
          modifiedBy,
          customer,
          manager,
          managerUserName,
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
      Projects.managerUserName,
      Projects.customer;

  entity Employees      @(restrict : [
  {
    grant : [
      'READ',
      'WRITE',
      'CREATE'
    ],
    to    : 'admin'
  },
  {
    grant : 'READ',
    where : 'username = $user'
  },
  ])                  as
    select from my.Employees {
      ID,
      name,
      username,
      createdAt,
      createdBy,
      modifiedAt,
      modifiedBy,
      daysOfLeave,
      daysOfTravel,
      round(
        sum(
          records.time
        ), 2
      ) as billingTime  @(title : '{i18n>Employees.billingTime}')  : Double,
      count(
        records.ID
      ) as recordsCount @(title : '{i18n>Employees.recordsCount}') : Integer,
      round(
        sum(
          (
            records.time
          ) / 1440
        ), 2
      ) as bonus        @(title : '{i18n>Employees.bonus}')        : Double,
      manager,
      projects,
      travels                                                      : redirected to Travels,
      // travelAggr,
      leaves                                                       : redirected to Leaves,
    // leaveAggr
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

  entity Packages     as projection on my.Packages;

  entity Customers    as
    select from my.Customers {
      createdAt,
      createdBy,
      ID,
      modifiedAt,
      modifiedBy,
      name,
      projects,
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

  entity Invoices     as projection on my.Invoices;

  entity InvoiceItems as projection on my.InvoiceItems {
    * , invoice : redirected to Invoices
  };

  entity Leaves @(restrict : [
  {
    grant : ['READ'],
    to    : 'admin'
  },
  {
    grant : ['READ'],
    where : 'username = $user'
  }
  ])                  as projection on my.Leaves;

  // entity LeaveAggregations  as projection on my.LeaveAggregations;
  entity LeaveStatus  as projection on my.LeaveStatus;
  entity Travels      as projection on my.Travels;
  // entity TravelAggregations as projection on my.TravelAggregations;

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
  ])                  as
    select from my.EmployeesToProjects {
      *,
      project.title,
      employee.name,
      employee.username
    };
}
