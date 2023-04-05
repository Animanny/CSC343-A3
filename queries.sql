set search_path to election;

revoke all on Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity from srikan88;

-- List total organizational donations and total individual donations for each campaign
grant select on Donors to srikan88;

select sum(amount), email
from Donors
group by email;


revoke all on Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity from srikan88;

-- Find those Volunteers who offer to work on every campaign in the dataset
grant select on Workers, Campaigns, ScheduledActivity to srikan88;

select Volunteer.email
from (
    select *
    from ScheduledActivity join Workers on ScheduledActivity.worker = Workers.email
    where Workers.workertype = 'volunteer'
    ) as Volunteer
group by Volunteer.email
having count(Volunteer.email) = (select count(*) from campaigns );


revoke all on Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity from srikan88;


-- Find candidates who are involved in every debate
grant select on DebateCandidates, Debates to srikan88;

select cID
from DebateCandidates
group by cID
having count(distinct dID) = (select count(*) from Debates);


revoke all on Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity from srikan88;

