-- FraudStream : base source "bank" (referentiels clients et cartes)
-- Execute automatiquement au PREMIER demarrage de PostgreSQL

CREATE TABLE clients (
    client_id   SERIAL PRIMARY KEY,
    first_name  VARCHAR(100) NOT NULL,
    last_name   VARCHAR(100) NOT NULL,
    gender      CHAR(1),
    street      VARCHAR(255),
    city        VARCHAR(100),
    state       CHAR(2),
    zip         VARCHAR(10),
    lat         NUMERIC(9,6),
    long        NUMERIC(9,6),
    city_pop    INTEGER,
    job         VARCHAR(255),
    dob         DATE,
    created_at  TIMESTAMP NOT NULL DEFAULT now(),
    updated_at  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE cartes (
    card_id     SERIAL PRIMARY KEY,
    cc_num      VARCHAR(19) NOT NULL UNIQUE,
    client_id   INTEGER NOT NULL REFERENCES clients(client_id),
    plafond     NUMERIC(10,2) NOT NULL DEFAULT 5000.00,
    statut      VARCHAR(10) NOT NULL DEFAULT 'active'
                CHECK (statut IN ('active', 'bloquee', 'expiree')),
    created_at  TIMESTAMP NOT NULL DEFAULT now(),
    updated_at  TIMESTAMP NOT NULL DEFAULT now()
);
