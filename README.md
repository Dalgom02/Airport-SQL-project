Admin login - user: implemented  password: 123
Rep login - user: rep password: 123
users - user: david password: asdf         
user: Dhruv password: password
user: test password: 123 

Airports in the dataset - ('EWR', 'Newark Liberty International Airport', 'Newark');, ('LGA', 'LaGuardia Airport', 'New York');, ('JFK', 'John F. Kennedy International Airport', 'New York');
Airlines in the dataset - ('AA', 'American Airlines'), ('UA', 'United Airlines')

Flights in the table
('AA100', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-07-01', 'Monday, Wednesday, Friday', 180, 5, 150.00, '01:30:00', 'Domestic');
('UA200', 'UA', '1UA', 'JFK', 'EWR', '17:00:00', '18:30:00', '2023-07-02', 'Tuesday, Thursday', 200, 3, 200.00, '01:30:00', 'Domestic');
('AA101', 'AA', '1AA', 'LGA', 'JFK', '10:00:00', '11:30:00', '2023-07-03', 'Saturday, Sunday', 150, 0, 160.00, '01:30:00', 'Domestic');
('UA201', 'UA', '1UA', 'JFK', 'EWR', '19:00:00', '20:30:00', '2023-12-14', 'Friday, Saturday', 190, 1, 180.00, '01:30:00', 'Domestic');
('AA102', 'AA', '1AA', 'EWR', 'JFK', '14:00:00', '15:30:00', '2023-07-05', 'Monday, Thursday', 170, 4, 140.00, '01:30:00', 'Domestic');
('UA202', 'UA', '1UA', 'LGA', 'EWR', '16:00:00', '17:30:00', '2023-07-06', 'Wednesday, Sunday', 160, 2, 170.00, '04:30:00', 'Domestic');
('AA180', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-07-01', 'Monday, Wednesday, Friday', 180, 0, 120.00, '03:30:00', 'Domestic');
('AA320', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-07-02', 'Monday, Wednesday, Friday', 180, 5, 120.00, '02:30:00', 'Domestic');
('AA740', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-12-15', 'Monday, Wednesday, Friday', 180, 5, 120.00, '02:30:00', 'Domestic');



Flights to search for one way

Departure Airport: EWR
Arrival Airport: JFK
Departure Date: 2023-07-01
Trip Type: One-Way


In the round-trip functionality, flights are matched based on the selected departure and arrival airports


Flights to search for round way

Departure Airport for Outbound Flight: LGA
Arrival Airport for Outbound Flight: EWR
Departure Date for Outbound Flight: 2023-07-03
Departure Airport for Return Flight: EWR
Arrival Airport for Return Flight: LGA
Departure Date for Return Flight: 2023-07-06


If the query does not exist the page will be empty
For reservations it uses the current date, so if you reserve flights from the past it will go under past reservations in the profile section and those in the future will go to upcoming flights
For waitlist if user 2 is on waitlisted on flight 1 and user 1 deletes their reservation for flight1, user 2 will get a notification on the welcome screen that their waitlisted flight has been reserved and you can check your profile to see the details
