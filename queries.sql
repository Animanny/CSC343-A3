set search_path to election;

revoke all on Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity from srikan88;


grant select on Donors to srikan88;


select sum(amount), email
from Donors
group by email;


revoke all on Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity from srikan88;

