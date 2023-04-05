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
    spendingLimit  numeric not null check (spendingLimit > 0) 
);

create table Debates (
    -- Time, Candidate and Moderator is primary key

    -- Manually Check that candidate isn't duplicate

    -- TODO: Figure out the key for this and figure out it's exclusisons
    
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
    amount numeric not null check (amount > 0),
    campaigns varchar(50) references Campaigns (candidateEmail)
);


create table Workers (
    email varchar(50) primary key,
    campaign_candidate varchar(50) references Campaigns (candidateEmail),
    worker_type workerType not null
);

create table ScheduledActivity(
    worker_email varchar(50) references Workers (email),
    schedule time,
    activity campaignActivity,
    primary key (schedule, Activity)
);

-- Assume debates don't overlap if they don't 
-- start at the same date and time.

-- Assuming we won't have update anomalies on
-- shared e-mails between workers and donors
-- since e-mails are the primary keys

-- Assume that