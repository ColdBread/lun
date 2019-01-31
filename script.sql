create table balance
(
  id     int auto_increment
    primary key,
  date   date    not null,
  income decimal not null,
  costs  decimal not null,
  net    decimal not null
);

create table client
(
  id          int auto_increment
    primary key,
  surname     varchar(40) not null,
  phone       varchar(20) not null,
  type        varchar(30) not null,
  max_payment decimal     not null
);

create table money_flow
(
  id         int auto_increment
    primary key,
  date       date    not null,
  sum        decimal not null,
  balance_id int     not null,
  constraint money_flow_balance_id_fk
  foreign key (balance_id) references balance (id)
);

create table owner
(
  id    int auto_increment
    primary key,
  phone varchar(20) not null
);

create table juridical
(
  id            int          not null
    primary key,
  name          varchar(100) not null,
  business_type varchar(30)  not null,
  contact_name  varchar(100) not null,
  constraint justice_owner_id_fk
  foreign key (id) references owner (id)
);

create table physical
(
  surname varchar(50) not null,
  id      int         not null
    primary key,
  constraint Physical_owner_id_fk
  foreign key (id) references owner (id)
);

create table worker
(
  id       int auto_increment
    primary key,
  surname  varchar(40) not null,
  phone    varchar(20) not null,
  position varchar(40) not null,
  salary   decimal     not null
);

create table building
(
  id        int auto_increment
    primary key,
  worker_id int          null,
  owner_id  int          not null,
  address   varchar(100) not null,
  type      varchar(30)  not null,
  room_num  int          not null,
  payment   decimal      not null,
  constraint building_owner_id_fk
  foreign key (owner_id) references owner (id),
  constraint building_worker_id_fk
  foreign key (worker_id) references worker (id)
);

create table client_building
(
  client_id   int not null,
  building_id int not null,
  primary key (building_id, client_id),
  constraint client_building_building_id_fk
  foreign key (building_id) references building (id),
  constraint client_building_client_id_fk
  foreign key (client_id) references client (id)
);

create table contract
(
  id              int auto_increment
    primary key,
  building_id     int     not null,
  worker_id       int     not null,
  client_id       int     not null,
  monthly_payment decimal not null,
  rent_start      date    not null,
  rent_end        date    not null,
  constraint contract_building_id_fk
  foreign key (building_id) references building (id),
  constraint contract_client_id_fk
  foreign key (client_id) references client (id),
  constraint contract_worker_id_fk
  foreign key (worker_id) references worker (id)
);

create table inspection
(
  id          int auto_increment
    primary key,
  worker_id   int          not null,
  building_id int          not null,
  date        date         not null,
  comment     varchar(255) null,
  constraint inspection_building_id_fk
  foreign key (building_id) references building (id),
  constraint inspection_worker_id_fk
  foreign key (worker_id) references worker (id)
);

create table rent_costs
(
  id          int not null
    primary key,
  building_id int not null,
  year        int not null,
  month       int not null,
  constraint rent_costs_building_id_fk
  foreign key (building_id) references building (id),
  constraint rent_costs_money_flow_id_fk
  foreign key (id) references money_flow (id)
);

create table rent_income
(
  id          int not null
    primary key,
  contract_id int not null,
  year        int not null,
  month       int not null,
  constraint rent_income_contract_id_fk
  foreign key (contract_id) references contract (id),
  constraint rent_income_money_flow_id_fk
  foreign key (id) references money_flow (id)
);

create table review
(
  id          int auto_increment
    primary key,
  client_id   int          not null,
  building_id int          not null,
  date        date         not null,
  comment     varchar(255) null,
  constraint review_building_id_fk
  foreign key (building_id) references building (id),
  constraint review_client_id_fk
  foreign key (client_id) references client (id)
);

create table wage
(
  id        int not null
    primary key,
  worker_id int not null,
  year      int not null,
  month     int not null,
  constraint wage_money_flow_id_fk
  foreign key (id) references money_flow (id),
  constraint wage_worker_id_fk
  foreign key (worker_id) references worker (id)
);

create table worker_bonus
(
  id          int not null
    primary key,
  contract_id int not null,
  constraint worker_bonus_contract_id_fk
  foreign key (contract_id) references contract (id),
  constraint worker_bonus_money_flow_id_fk
  foreign key (id) references money_flow (id)
);

