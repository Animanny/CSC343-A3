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
    -- One entry per campaign
    -- Unique id is the candidates email
    -- Each candidate can only have 1 campaign
    candidateEmail varchar(50) primary key,
    -- EXTRA: constrain spending limits to positive values
    spendingLimit  numeric not null check (spendingLimit > 0) 
);

create table Debates (    
    dID integer primary key,
    moderator varchar(50) not null,
    dTime timestamp not null,
    unique ( moderator, dTime)
);

create table DebateCandidates (
    dID integer references Debates (dID),
    cID varchar(50) references Campaigns (candidateEmail),
    primary key( dID, cID )
);

create table Donors (
    email varchar(50) primary key,
    address varchar(50) not null,
    -- EXTRA: constrain donation amounts to positive values
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
    primary key (worker, schedule)
);

-- Assume debates don't overlap if they don't 
-- start at the same date and time.

-- Assuming we won't have update anomalies on
-- shared e-mails between workers and donors
-- since e-mails are the primary keys

-- Assume that