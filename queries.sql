set search_path to election;

revoke all on
Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity
from srikan88;

-- List total organizational donations and 
-- total individual donations for each campaign
grant select (candidateEmail) on Campaigns to srikan88;
grant select (amount, donorType, campaign) on Donors to srikan88;

select campaigns.candidateEmail as candidate,
    individual_contributions,
    organizational_contributions
from campaigns
left join (
    select campaign, sum(amount) as individual_contributions
    from donors
    where donorType='individual'
    group by campaign
    ) as individual on individual.campaign = campaigns.candidateEmail
left join  (
    select campaign, sum(amount) as organizational_contributions
    from donors
    where donorType='organization'
    group by campaign
    ) as organization on organization.campaign = campaigns.candidateEmail;


revoke all on
Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity
from srikan88;

-- Find those Volunteers who offer to work on every campaign in the dataset
grant select (email, workerType) on Workers to srikan88;
grant select (candidateEmail) on Campaigns to srikan88;
grant select (worker, campaignCandidate) on ScheduledActivity to srikan88;

select Volunteer.worker as vol_work_all_campaigns
from (
    select worker, workerType, campaignCandidate
    from ScheduledActivity
    join Workers on ScheduledActivity.worker = Workers.email
    where Workers.workertype = 'volunteer'
    ) as Volunteer
group by Volunteer.worker
having 
count(distinct Volunteer.campaigncandidate) = (select count(*) from campaigns);


revoke all on
Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity
from srikan88;


-- Find candidates who are involved in every debate
grant select (cID, dID) on DebateCandidates to srikan88;
grant select (dID) on Debates to srikan88;

select cID as cand_in_all_debates
from DebateCandidates
group by cID
having count(distinct dID) = (select count(*) from Debates);


revoke all on
Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity
from srikan88;

