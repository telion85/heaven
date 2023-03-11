-- liquibase formatted sql

-- changeset alrepin:1
create table if not exists customer
(
    id          bigint generated by default as identity
        primary key,
    chat_id     bigint,
    surname     varchar(25),
    name        varchar(25),
    second_name varchar(25),
    phone       varchar(12),
    address     text
);

create table if not exists shelter
(
    id           bigint generated by default as identity (maxvalue 2147483647)
        primary key,
    address      varchar(255),
    location_map text,
    name         varchar(255)
);

create table if not exists volunteer
(
    id          bigint generated by default as identity
        primary key,
    address     varchar(255),
    chat_id     bigint not null,
    name        varchar(255),
    phone       varchar(255),
    second_name varchar(255),
    surname     varchar(255)
);

create table if not exists info
(
    id           bigint generated by default as identity
        primary key,
    area         varchar(255),
    instructions varchar(255)
);

create table if not exists databasechangeloglock
(
    id          integer not null
        primary key,
    locked      boolean not null,
    lockgranted timestamp,
    lockedby    varchar(255)
);

create table if not exists databasechangelog
(
    id            varchar(255) not null,
    author        varchar(255) not null,
    filename      varchar(255) not null,
    dateexecuted  timestamp    not null,
    orderexecuted integer      not null,
    exectype      varchar(10)  not null,
    md5sum        varchar(35),
    description   varchar(255),
    comments      varchar(255),
    tag           varchar(255),
    liquibase     varchar(20),
    contexts      varchar(255),
    labels        varchar(255),
    deployment_id varchar(10)
);

create table if not exists breed
(
    id                    bigint generated by default as identity
        primary key,
    adult_pet_from_age    integer not null,
    breed                 varchar(255),
    recommendations_adult varchar(255),
    recommendations_child varchar(255)
);

create table if not exists pet
(
    id            bigint generated by default as identity
        primary key,
    age_in_months integer not null,
    decision_date timestamp,
    file_path     varchar(255),
    file_size     bigint,
    media_type    varchar(255),
    name          varchar(255),
    photo         bytea,
    id_customer   bigint
        constraint fkomkj6md9m4nle48xek4gnp07s
            references customer,
    id_shelter    bigint
        constraint fk1cdg3ffovmtyr208f6q0ectxs
            references shelter,
    id_breed      bigint
        constraint fk750ldhvrm3f5uo0kw0qjinvv
            references breed
);

create table if not exists report
(
    id            bigint generated by default as identity
        primary key,
    date       timestamp,
    file_path  varchar(255),
    file_size  bigint,
    media_type varchar(255),
    pet_report varchar(255),
    photo      bytea,
    id_pet     bigint
        constraint fk1kk5qc2sk2cc71fibvnto90ax
            references pet
);

-- changeset alrepin:2
INSERT INTO public.info
(area, instructions)
SELECT 'common_info', 'Common info about bot'
    WHERE
    NOT EXISTS (
        SELECT area FROM public.info WHERE area = 'common_info'
    );

-- changeset alrepin:3
INSERT INTO public.pet
(age_in_months, name)
SELECT 5, 'кот Васька'
WHERE NOT EXISTS(
        SELECT id, name FROM public.pet WHERE name = 'кот Васька'
    );

-- changeset alrepin:4
INSERT INTO public.pet
(age_in_months, name)
SELECT 1, 'котенок Мурзик'
WHERE NOT EXISTS(
        SELECT id, name FROM public.pet WHERE name = 'котенок Мурзик'
    );

INSERT INTO public.pet
(age_in_months, name)
SELECT 24, 'пес Барбос'
WHERE NOT EXISTS(
        SELECT id, name FROM public.pet WHERE name = 'пес Барбос'
    );

INSERT INTO public.pet
(age_in_months, name)
SELECT 24, 'щенок Гав'
WHERE NOT EXISTS(
        SELECT id, name FROM public.pet WHERE name = 'щенок Гав'
    );

-- changeset Alex Turaev:1

INSERT INTO public.info
(area, instructions)
SELECT 'dating_rules', 'Treat pets well'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'dating_rules'
    );

-- changeset starasov:1

INSERT INTO public.customer
(chat_id, name)
SELECT 440401693, 'Тарасов Сергей'
WHERE NOT EXISTS(
        SELECT id, chat_id FROM public.customer WHERE chat_id = 440401693
    );

UPDATE public.pet SET id_customer = 1 WHERE name='щенок Гав';

INSERT INTO public.report
(date, id_pet, pet_report)
SELECT '2023-02-28 17:44:50.000000', 1, 'текст отчета 1'
WHERE NOT EXISTS(
        SELECT id, pet_report FROM public.report WHERE pet_report = 'текст отчета 1'
    );

INSERT INTO public.report
(date, id_pet, pet_report)
SELECT '2023-03-01 17:44:50.000000', 1, 'текст отчета 2'
WHERE NOT EXISTS(
        SELECT id, pet_report FROM public.report WHERE pet_report = 'текст отчета 2'
    );

INSERT INTO public.report
(date, id_pet, pet_report)
SELECT '2023-03-02 17:44:50.000000', 1, 'текст отчета 3'
WHERE NOT EXISTS(
        SELECT id, pet_report FROM public.report WHERE pet_report = 'текст отчета 3'
    );

create table if not exists customer_context
(
    id                    bigint generated by default as identity
        primary key,
    dialog_context        int,
    pet_id                bigint
);

-- changeset starasov:2
ALTER TABLE customer
    ADD customer_context_id bigint;

ALTER TABLE public.customer_context
    ADD customer_id bigint;

UPDATE public.customer SET customer_context_id = 1, id = 1 WHERE chat_id = 440401693;

INSERT INTO public.customer_context
(dialog_context, pet_id, customer_id)
SELECT 0, 0, 1
WHERE NOT EXISTS(
        SELECT id, customer_id FROM public.customer_context WHERE customer_id = 1
    );

UPDATE public.pet SET id_customer = 1 WHERE name='котенок Мурзик';

-- changeset alrepin:5
create table if not exists volunteer_shelter
(
    volunteer_id bigint not null
        constraint fkqrvk2bpwvmh2yk294x3axk4g2
            references volunteer,
    shelter_id   bigint not null
        constraint fkckt4cnpt40qwri82e2y8g1s7h
            references shelter,
    primary key (volunteer_id, shelter_id)
);

-- changeset alrepin:6
alter table volunteer
    alter column chat_id drop not null;

-- changeset Alex Turaev:2

INSERT INTO public.info
(area, instructions)
SELECT 'documents', 'Required documents: doc1, doc2, doc3'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'documents'
    );

-- changeset Alex Turaev:3

INSERT INTO public.info
(area, instructions)
SELECT 'transport', 'Transportation rules: transport animals carefully'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'transport'
    );

-- changeset Alex Turaev:4

INSERT INTO public.info
(area, instructions)
SELECT 'comfort_pet', 'The house for pet should be clean'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'comfort_pet'
    );

-- changeset Alex Turaev:5

INSERT INTO public.info
(area, instructions)
SELECT 'comfort_dog', 'The house for dog should be clean'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'comfort_dog'
    );

-- changeset Alex Turaev:6

INSERT INTO public.info
(area, instructions)
SELECT 'comfort_handicapped', 'The house for handicapped pet should be clean'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'comfort_handicapped'
    );

-- changeset Alex Turaev:7

INSERT INTO public.info
(area, instructions)
SELECT 'cynologist_advice', 'Tips from a dog handler: take care of the dog, feed it properly'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'cynologist_advice'
    );

-- changeset Alex Turaev:8

INSERT INTO public.info
(area, instructions)
SELECT 'cynologists_list', 'List of dog handlers: Ivan, Petr'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'cynologists_list'
    );

-- changeset Alex Turaev:9

INSERT INTO public.info
(area, instructions)
SELECT 'reasons_refusal', 'The list of reasons for refusal: reason1, reason2'
WHERE NOT EXISTS(
        SELECT area FROM public.info WHERE area = 'reasons_refusal'
    );

-- changeset alrepin:7
INSERT INTO public.shelter
(id, name)
SELECT 1, 'Cat''s shelter'
WHERE NOT EXISTS(
        SELECT id, name FROM public.shelter WHERE name = 'Cat''s shelter'
    );

INSERT INTO public.shelter
(id, name)
SELECT 2, 'Dog''s shelter'
WHERE NOT EXISTS(
        SELECT id, name FROM public.shelter WHERE name = 'Dog''s shelter'
    );

INSERT INTO public.volunteer
(id, chat_id, name)
SELECT 1, 440401693,'Тарасов Сергей'
WHERE NOT EXISTS(
        SELECT chat_id, name FROM public.volunteer WHERE name = 'Тарасов Сергей'
    );

INSERT INTO public.volunteer
(id, chat_id, name)
SELECT 2, 54204985,'Репин Алексей'
WHERE NOT EXISTS(
        SELECT chat_id, name FROM public.volunteer WHERE name = 'Репин Алексей'
    );

INSERT INTO public.volunteer
(id, chat_id, name)
SELECT 3, 302455489,'Пупкин Василий'
WHERE NOT EXISTS(
        SELECT chat_id, name FROM public.volunteer WHERE name = 'Пупкин Василий'
    );

INSERT INTO public.volunteer_shelter
(volunteer_id, shelter_id)
SELECT 1, 1
WHERE NOT EXISTS(
        SELECT volunteer_id, shelter_id FROM public.volunteer_shelter WHERE volunteer_id = 1 AND shelter_id = 1
    );

INSERT INTO public.volunteer_shelter
(volunteer_id, shelter_id)
SELECT 2, 2
WHERE NOT EXISTS(
        SELECT volunteer_id, shelter_id FROM public.volunteer_shelter WHERE volunteer_id = 2 AND shelter_id = 2
    );

INSERT INTO public.volunteer_shelter
(volunteer_id, shelter_id)
SELECT 3, 1
WHERE NOT EXISTS(
        SELECT volunteer_id, shelter_id FROM public.volunteer_shelter WHERE volunteer_id = 3 AND shelter_id = 1
    );

INSERT INTO public.volunteer_shelter
(volunteer_id, shelter_id)
SELECT 3, 2
WHERE NOT EXISTS(
        SELECT volunteer_id, shelter_id FROM public.volunteer_shelter WHERE volunteer_id = 3 AND shelter_id = 2
    );

-- changeset alrepin:8
UPDATE public.pet
SET id_shelter = 2::bigint
WHERE id = 4::bigint;

UPDATE public.pet
SET id_shelter = 1::bigint
WHERE id = 2::bigint;

UPDATE public.pet
SET id_shelter = 1::bigint
WHERE id = 1::bigint;

UPDATE public.pet
SET id_shelter = 2::bigint
WHERE id = 3::bigint;

-- changeset telion:3
ALTER TABLE public.customer ADD CONSTRAINT FK_Customers FOREIGN KEY(customer_context_id) REFERENCES customer(id);
ALTER TABLE public.customer_context DROP COLUMN customer_id;
ALTER TABLE public.customer_context RENAME COLUMN pet_id TO current_pet_id;
