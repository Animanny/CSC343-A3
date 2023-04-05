set search_path to election;

revoke all on Campaigns, Debates, DebateCandidates, Donors, Workers, ScheduledActivity from srikan88;


grant SELECT ON Donors to srikan88;
SELECT sum(amount), email
FROM Donors
GROUP BY email;

