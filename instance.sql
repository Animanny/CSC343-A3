INSERT INTO Campaigns
VALUES
('isaac.newton@toronto.ca', 100000),
('rene.descarte@toronto.ca', 5000),
('leo.davinci@toronto.ca', 250000);

INSERT INTO Debates
VALUES
(1, 'albert.einstein@toronto.ca', date'2023-05-02 12:00:00'),
(2, 'marie.curie@toronto.ca', date'2023-05-02 13:00:00');

INSERT INTO DebateCandidates
VALUES
(1, 'isaac.newton@toronto.ca'),
(1, 'leo.davinci@toronto.ca'),
(2, 'isaac.newton@toronto.ca'),
(2, 'rene.descarte@toronto.ca');

INSERT INTO Donors
VALUES
('betty.white@toronto.ca', '100 Maple Lane', 100, 'isaac.newton@toronto.ca'),
('will.smith@toronto.ca', '100 Maple Lane', 250, 'rene.descarte@toronto.ca'),
('julia.roberts@toronto.ca', '100 Maple Lane', 50, 'leo.davinci@toronto.ca');

INSERT INTO Workers
VALUES
('denzel.washington@toronto.ca','isaac.newton@toronto.ca', 'volunteer'),
('leo.dicaprio@toronto.ca','isaac.newton@toronto.ca', 'volunteer'),
('james.earl.jones@toronto.ca','isaac.newton@toronto.ca', 'volunteer');

INSERT INTO ScheduledActivity
VALUES
('denzel.washington@toronto.ca', time'2023-04-07 14:00:00', 'phone banks' ),
('leo.dicaprio@toronto.ca', time'2023-04-08 17:00:00', 'phone banks' ),
('james.earl.jones@toronto.ca', time'2023-04-08 08:00:00', 'phone banks' );