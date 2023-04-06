-- Elections Schema
-- Sophia Mazzonna, Anirudha Srikanth

-- COULD NOT:
--      - Cannot eliminate overlapping time
--      - Prevent new entries with dates in 
--        the past to be added (Requires Trigger)
-- DID NOT:
--      - N/A
-- EXTRA:
--      - no value in the data is nullable
--      - constrain campaigns to only 1 campaign per candidate
--      - constrain spending limits to positive values
--      - constrain donation amounts to positive values
--      - constrain debates so only one can happen at a time
--        such that moderators and candidates cannot be double booked
-- ASSUMPTIONS:
--      - Assume each campaign is uniquely identified by
--        the candidate's e-mail (only one candidate per campaign)
--      - Assume debates don't overlap if they don't 
--        start at the same date and time.
--      - Assume we won't have update anomalies on
--        shared e-mails between workers and donors
--        since e-mails are the primary keys
--      - Two debates cannot happen at the same time

drop schema if exists election cascade;
create schema election;
set search_path to election;

create domain workerType as varchar(10)
    default 'volunteer'
    check(value in ('volunteer', 'staff'));

create domain donatorType as varchar(10)
    default 'individual'
    check(value in ('individual', 'organization'));

create domain campaignActivity as varchar(50)
    default 'phone banks'
    check(value in ('phone banks', 'door-to-door canvassing'));

create table Campaigns (
    candidateEmail varchar(50) primary key,
    spendingLimit  numeric not null check (spendingLimit > 0) 
);

create table Debates (    
    dID integer primary key,
    moderator varchar(50) not null,
    dTime timestamp not null unique
);

create table DebateCandidates (
    dID integer references Debates (dID),
    cID varchar(50) references Campaigns (candidateEmail),
    primary key ( dID, cID )
);

create table Donors (
    email varchar(50) primary key,
    address varchar(50) not null,
    amount numeric not null check (amount > 0),
    campaigns varchar(50) references Campaigns (candidateEmail)
);


create table Workers (
    email varchar(50) primary key,
    workerType workerType not null
);

create table ScheduledActivity(
    worker varchar(50) references Workers (email),
    campaignCandidate varchar(50) references Campaigns (candidateEmail),
    schedule timestamp,
    activity campaignActivity,
    primary key ( worker, schedule )
);