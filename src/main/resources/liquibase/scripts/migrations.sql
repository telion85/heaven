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
    id         bigint generated by default as identity
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
WHERE NOT EXISTS(
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

UPDATE public.pet
SET id_customer = 1
WHERE name = 'щенок Гав';

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
    id             bigint generated by default as identity
        primary key,
    dialog_context int,
    pet_id         bigint
);

-- changeset starasov:2
ALTER TABLE customer
    ADD customer_context_id bigint;

ALTER TABLE public.customer_context
    ADD customer_id bigint;

UPDATE public.customer
SET customer_context_id = 1,
    id                  = 1
WHERE chat_id = 440401693;

INSERT INTO public.customer_context
    (dialog_context, pet_id, customer_id)
SELECT 0, 0, 1
WHERE NOT EXISTS(
        SELECT id, customer_id FROM public.customer_context WHERE customer_id = 1
    );

UPDATE public.pet
SET id_customer = 1
WHERE name = 'котенок Мурзик';

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
SELECT 1, 440401693, 'Тарасов Сергей'
WHERE NOT EXISTS(
        SELECT chat_id, name FROM public.volunteer WHERE name = 'Тарасов Сергей'
    );

INSERT INTO public.volunteer
    (id, chat_id, name)
SELECT 2, 54204985, 'Репин Алексей'
WHERE NOT EXISTS(
        SELECT chat_id, name FROM public.volunteer WHERE name = 'Репин Алексей'
    );

INSERT INTO public.volunteer
    (id, chat_id, name)
SELECT 3, 302455489, 'Пупкин Василий'
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

-- changeset alrepin:9
alter table customer_context
    add shelter_id bigint default null;

-- changeset telion:3
ALTER TABLE public.customer_context
    DROP COLUMN customer_id;
ALTER TABLE public.customer_context
    RENAME COLUMN pet_id TO current_pet_id;

-- changeset starasov:4
UPDATE public.customer_context
SET shelter_id = 1
WHERE customer_context.id = 1;

ALTER TABLE public.shelter
    ADD description text,
    ADD rules       text;

UPDATE public.shelter
SET address     = 'Baker Street, 22',
    location_map='catspet_map.jpg',
    description='The best shelter for cats. In our shelter you can easily find a pet for yourself. ' ||
                'We have a large number of cats of various breeds, outbreds, as well as tigers, lions, ' ||
                'cheetahs and other representatives of the feline family. Looking for a cute little kitty? ' ||
                'Then you to us! Need a big wild tiger? You again to us. You can arrange a viewing by calling 990-388.',
    rules='There are a lot of wild animals in our cattery, behave so that you are not eaten.'
WHERE id = 1;

UPDATE public.shelter
SET address     = 'Cat Avenue, 77',
    location_map='dogspet_map.jpg',
    description='Our shelter has over 100 dogs of various breeds, mostly adults. They are sterilized, vaccinated and groomed. ' ||
                'Occasionally, puppies end up in the shelter. You can arrange a viewing by calling 388-990. ' ||
                'Also in our shelter there is a staff of cynologists who will help you choose an animal, ' ||
                'equip his life and bring him up as a true friend and protector.',
    rules='Do not approach animals unless accompanied by a shelter employee, some animals may be aggressive. ' ||
          'Do not come to the shelter after active consumption of beer, some animals may be aggressive. ' ||
          'Do not knock on the cages, some animals may be aggressive.'
WHERE id = 2;

-- changeset alrepin:10
alter table customer_context
    add last_in_msg text;
alter table customer_context
    add last_out_msg text;
create table if not exists navigation
(
    id              bigint generated by default as identity
        primary key,
    endpoint        varchar(255),
    level_view      bigint,
    text            varchar(255),
    shelter_id      bigint
        constraint fkt2mfcica53rwqjq4473ygb1q6
            references shelter,
    level_reference bigint,
    rules           text
);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (2, '/shelter/0', 1, 'Select shelter', null, null, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (15, '/main', 4, 'Main menu', null, 1, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (3, '/shelter', 1, 'Shelter info', null, 3, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (1, '/main', 3, 'Main menu', null, 1, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (6, '/call-valunteer', 1, 'Need help', null, 1, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (7, '/shelter-info', 3, 'Shelter info', null, 3, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (9, '/security-contact', 3, 'Security contact info', null, 3, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (8, '/address', 3, 'Shedule a visit', null, 3, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (10, '/call-valunteer', 3, 'Need help', null, 3, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (14, '/dating_rules', 4, 'Cats dating rules', 1, 4, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 1 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (13, '/dating_rules', 4, 'Dogs dating rules', 2, 4, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 2 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (4, '/how-adopt', 1, 'Get a pet', null, 4, null);
insert into public.navigation (id, endpoint, level_view, text, shelter_id, level_reference, rules) values (5, '/submit_report', 1, 'Evaluate period', null, 5, null);

-- changeset alrepin:11
alter table navigation
    drop column if exists shelter_id;

-- changeset alrepin:12
alter table customer_context
    add cur_level bigint;

-- changeset alrepin:13
insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (18, '/documents', 4, 'Bureaucracy', null, null);

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (19, '/transport', 4, 'How to transport', null, null);

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (20, '/comfort-young', 4, 'Kittens specific', null, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 1 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (21, '/comfort-young', 4, 'Puppies specific', null, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 2 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (22, '/comfort-adult', 4, 'Adult dogs specific', null, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 2 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (23, '/comfort-adult', 4, 'Adult cats specific', null, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 1 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (24, '/comfort_handicapped', 4, 'Handicapped pets', null, null);

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (25, '/cynologist_advice', 4, 'Professionals advices', null, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 2 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (26, '/cynologists_list', 4, 'Cynologists contacts', null, '{ "and" : [
{ "or" : [
  {"==" : [ { "var" : "shelterId" }, 2 ]},
  {"==" : [ { "var" : "shelterId" }, null ] }
] },
{ "or" : [
  {"==" : [ { "var" : "dialogContext" }, "FREE" ] },
  {"==" : [ { "var" : "dialogContext" }, "WAIT_REPORT" ] }
] }
] }');

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (27, '/reasons_refusal', 4, 'Why refusal', null, null);

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (28, '/leave_contact', 4, 'Send contact for adoption', null, null);

insert into public.navigation (id, endpoint, level_view, text, level_reference, rules)
values (29, '/call-valunteer', 4, 'Need human help', null, null);

-- changeset starasov:5
CREATE TABLE IF NOT EXISTS report_photo
(
    id          bigint generated by default as identity
        primary key,
    media_type  varchar(255),
    photo       bytea,
    id_report   bigint
);

ALTER TABLE report
    DROP COLUMN IF EXISTS file_path,
    DROP COLUMN IF EXISTS file_size,
    DROP COLUMN IF EXISTS media_type,
    DROP COLUMN IF EXISTS photo;

INSERT INTO public.navigation (id, endpoint, level_view, text, level_reference, rules)
    VALUES (30, '/main', 5, 'Main menu', 1, null);
INSERT INTO public.navigation (id, endpoint, level_view, text, level_reference, rules)
    VALUES (31, '/call-valunteer', 5, 'Need help', 5, null);
INSERT INTO public.navigation (id, endpoint, level_view, text, level_reference, rules)
    VALUES (32, '/leave_contact', 3, 'Leave contact', 3, null);
UPDATE public.navigation SET endpoint = '/security_contact' WHERE endpoint = '/security-contact';
UPDATE public.navigation SET endpoint = '/shelter_info' WHERE endpoint = '/shelter-info';
UPDATE public.navigation SET endpoint = '/comfort_adult' WHERE endpoint = '/comfort-adult';
UPDATE public.navigation SET endpoint = '/comfort_young' WHERE endpoint = '/comfort-young';
UPDATE public.navigation SET id = 34 WHERE id = 10;
UPDATE public.navigation SET level_reference = 4 WHERE id BETWEEN 18 AND 29;
UPDATE public.info SET area = 'comfort_young' WHERE area = 'comfort_pet';
UPDATE public.info SET area = 'comfort_adult' WHERE area = 'comfort_dog';

-- changeset alrepin:14
UPDATE public.navigation
SET text = 'Need human help'
WHERE text = 'Need help';

-- changeset alrepin:15
UPDATE public.navigation
SET level_reference = 2
WHERE endpoint = '/shelter/0';

-- changeset alrepin:16
UPDATE public.navigation
SET endpoint = '/call_volunteer'
WHERE endpoint = '/call-valunteer';