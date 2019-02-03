CREATE TABLE balance
(
  id     INT auto_increment PRIMARY KEY,
  date   DATE NOT NULL,
  income INT  NOT NULL,
  costs  INT  NOT NULL,
  net    INT  NOT NULL
);

CREATE TABLE client
(
  id          INT auto_increment PRIMARY KEY,
  surname     VARCHAR(40) NOT NULL,
  phone       VARCHAR(20) NOT NULL,
  type        VARCHAR(30) NOT NULL,
  max_payment INT         NOT NULL
);

CREATE TABLE money_flow
(
  id         INT auto_increment PRIMARY KEY,
  date       DATE NOT NULL,
  sum        INT  NOT NULL,
  balance_id INT  NOT NULL,
  CONSTRAINT money_flow_balance_id_fk FOREIGN KEY (balance_id) REFERENCES balance (id)
);

CREATE TABLE owner
(
  id    INT auto_increment PRIMARY KEY,
  phone VARCHAR(20) NOT NULL
);

CREATE TABLE juridical
(
  id            INT          NOT NULL PRIMARY KEY,
  name          VARCHAR(100) NOT NULL,
  business_type VARCHAR(30)  NOT NULL,
  contact_name  VARCHAR(100) NOT NULL,
  CONSTRAINT justice_owner_id_fk FOREIGN KEY (id) REFERENCES owner (id)
);

CREATE TABLE physical
(
  surname VARCHAR(50) NOT NULL,
  id      INT         NOT NULL PRIMARY KEY,
  CONSTRAINT physical_owner_id_fk FOREIGN KEY (id) REFERENCES owner (id)
);

CREATE TABLE worker
(
  id       INT auto_increment PRIMARY KEY,
  surname  VARCHAR(40) NOT NULL,
  phone    VARCHAR(20) NOT NULL,
  position VARCHAR(40) NOT NULL,
  salary   INT         NOT NULL
);

CREATE TABLE building
(
  id        INT auto_increment PRIMARY KEY,
  worker_id INT          NULL,
  owner_id  INT          NOT NULL,
  address   VARCHAR(100) NOT NULL,
  type      VARCHAR(30)  NOT NULL,
  room_num  INT          NOT NULL,
  payment   INT          NOT NULL,
  CONSTRAINT building_owner_id_fk FOREIGN KEY (owner_id) REFERENCES owner (id),
  CONSTRAINT building_worker_id_fk FOREIGN KEY (worker_id) REFERENCES worker (id)
);

CREATE TABLE client_building
(
  client_id   INT NOT NULL,
  building_id INT NOT NULL,
  PRIMARY KEY (building_id, client_id),
  CONSTRAINT client_building_building_id_fk FOREIGN KEY (building_id)
  REFERENCES building (id),
  CONSTRAINT client_building_client_id_fk FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE contract
(
  id              INT auto_increment PRIMARY KEY,
  building_id     INT  NOT NULL,
  worker_id       INT  NOT NULL,
  client_id       INT  NOT NULL,
  monthly_payment INT  NOT NULL,
  rent_start      DATE NOT NULL,
  rent_end        DATE NOT NULL,
  CONSTRAINT contract_building_id_fk FOREIGN KEY (building_id) REFERENCES building (id),
  CONSTRAINT contract_client_id_fk FOREIGN KEY (client_id) REFERENCES client (id),
  CONSTRAINT contract_worker_id_fk FOREIGN KEY (worker_id) REFERENCES worker (id)
);

CREATE TABLE inspection
(
  id          INT auto_increment PRIMARY KEY,
  worker_id   INT          NOT NULL,
  building_id INT          NOT NULL,
  date        DATE         NOT NULL,
  comment     VARCHAR(255) NULL,
  CONSTRAINT inspection_building_id_fk FOREIGN KEY (building_id) REFERENCES building (id),
  CONSTRAINT inspection_worker_id_fk FOREIGN KEY (worker_id) REFERENCES worker (id)
);

CREATE TABLE rent_costs
(
  id          INT NOT NULL PRIMARY KEY,
  building_id INT NOT NULL,
  year        INT NOT NULL,
  month       INT NOT NULL,
  CONSTRAINT rent_costs_building_id_fk FOREIGN KEY (building_id) REFERENCES building (id),
  CONSTRAINT rent_costs_money_flow_id_fk FOREIGN KEY (id) REFERENCES money_flow (id)
);

CREATE TABLE rent_income
(
  id          INT NOT NULL PRIMARY KEY,
  contract_id INT NOT NULL,
  year        INT NOT NULL,
  month       INT NOT NULL,
  CONSTRAINT rent_income_contract_id_fk FOREIGN KEY (contract_id) REFERENCES contract (id),
  CONSTRAINT rent_income_money_flow_id_fk FOREIGN KEY (id) REFERENCES money_flow (id)
);

CREATE TABLE review
(
  id          INT auto_increment PRIMARY KEY,
  client_id   INT          NOT NULL,
  building_id INT          NOT NULL,
  date        DATE         NOT NULL,
  comment     VARCHAR(255) NULL,
  CONSTRAINT review_building_id_fk FOREIGN KEY (building_id) REFERENCES building (id),
  CONSTRAINT review_client_id_fk FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE wage
(
  id        INT NOT NULL PRIMARY KEY,
  worker_id INT NOT NULL,
  year      INT NOT NULL,
  month     INT NOT NULL,
  CONSTRAINT wage_money_flow_id_fk FOREIGN KEY (id) REFERENCES money_flow (id),
  CONSTRAINT wage_worker_id_fk FOREIGN KEY (worker_id) REFERENCES worker (id)
);

CREATE TABLE worker_bonus
(
  id          INT NOT NULL PRIMARY KEY,
  contract_id INT NOT NULL,
  CONSTRAINT worker_bonus_contract_id_fk FOREIGN KEY (contract_id) REFERENCES contract (id),
  CONSTRAINT worker_bonus_money_flow_id_fk FOREIGN KEY (id) REFERENCES money_flow (id)
);