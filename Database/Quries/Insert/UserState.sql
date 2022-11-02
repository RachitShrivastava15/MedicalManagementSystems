USE MedicalManagement
Go

INSERT INTO [dbo].[UserState] VALUES
('Scheduled', 'User appointment is scheduled'),
('Cancelled', 'User appointment is cancelled'),
('UserCheckIn', 'User has checkin in hospital'),
('ToDoctor', 'User is routed doctor'),
('WithDoctor', 'User is with doctor'),
('ToPharmacy', 'User is routed to pharmacy'),
('WithPharmacy', 'User is with Pharmacy'),
('ToTest', 'User is routed for test'),
('WithTest', 'User is with test'),
('Completed', 'User has completed the work in hospital')
