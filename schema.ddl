drop schema if exists election cascade;
create schema election;
set search_path to election;

create domain workerType as varchar(10)
    default 'volunteer'
    check(value in ('volunteer', 'staff'));

create domain campaignActivity as varchar(50)
    default 'phone banks'
    check(value in ('phone banks', 'door-to-door canvassing'));

create table Campaigns (
    -- One entry per campaign
    -- Unique id is the candidates email
    candidate_email varchar(50) primary key,
    spending_limit int
);

create table Debates (
    -- Time, Candidate and Moderator is primary key

    -- Manually Check that candidate isn't duplicate

    -- TODO: Figure out the key for this and figure out it's exclusisons
    
    dID integer,
    moderator varchar(50),
    candidate varchar(50) references Campaigns (candidate_email),
    dTime timestamp
);

create table Donors (
    email varchar(50) primary key,
    address varchar(50),
    amount integer,
    campaigns varchar(50) references Campaigns (candidate_email)
);


create table Workers (
    worker varchar(50),
    campaignID varchar(50) references Campaigns,
    wType workerType,
    schedule time,
    Activity campaignActivity,
    primary key(worker, campaignID)
);

-- Assume debates don't overlap if they don't 
-- start at the same date and time.

-- Assuming we won't have update anomalies on
-- shared e-mails between workers and donors
-- since e-mails are the primary keys

-- Assume that