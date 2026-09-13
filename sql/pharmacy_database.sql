-- Pharmacy Database Management System
-- CIS 3400 Group 04
-- SQL documented in the project report


-- ==========================================
-- CREATE TABLE: Patient
-- ==========================================

CREATE TABLE Patient
(
    Patient_ID VARCHAR(20) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Date_of_Birth DATE,
    Address VARCHAR(50),
    Suite VARCHAR(50),
    Postal_Code VARCHAR(20),
    Phone_Number VARCHAR(20),
    Email_Address VARCHAR(100),
    Social_Security_Number VARCHAR(11),
    Allergies VARCHAR(255),
    CONSTRAINT pk_patient
    PRIMARY KEY (Patient_ID)
);


-- ==========================================
-- CREATE TABLE: Prescriber
-- ==========================================

CREATE TABLE Prescriber
(
    Prescriber_ID INTEGER NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    Prescriber_National_Provider_Identifier VARCHAR(20) NOT NULL,
    Street_Address VARCHAR(50),
    Suite VARCHAR(50),
    Postal_Code VARCHAR(20),
    Phone_Number VARCHAR(20),
    Email_Address VARCHAR(100),
    Fax_Number VARCHAR(20),
    CONSTRAINT pk_prescriber
    PRIMARY KEY (Prescriber_ID)
);


-- ==========================================
-- CREATE TABLE: Medication
-- ==========================================

CREATE TABLE Medication
(
    Medication_ID INT NOT NULL,
    Lot_Number VARCHAR(100) NOT NULL,
    Expiration_Date DATE NOT NULL,
    Quantity INT NOT NULL,
    Serial_Number VARCHAR(100),
    National_Drug_Code VARCHAR(20) NOT NULL,
    CONSTRAINT pk_medication
    PRIMARY KEY (Medication_ID)
);


-- ==========================================
-- CREATE TABLE: Insurance Plan
-- ==========================================

CREATE TABLE Insurance_Plan
(
    Insurance_ID INTEGER NOT NULL,
    Date_Of_Issue DATE NOT NULL,
    Plan_Type VARCHAR(50),
    Member_ID VARCHAR(50) NOT NULL,
    BIN VARCHAR(20),
    PCN VARCHAR(20),
    Issuer VARCHAR(100),
    RX_GroupNumber VARCHAR(50),
    Deductible VARCHAR(20),
    Copayment VARCHAR(20),
    CONSTRAINT pk_insurance_plan
    PRIMARY KEY (Insurance_ID)
);


-- ==========================================
-- CREATE TABLE: Pharmacy
-- ==========================================

CREATE TABLE Pharmacy
(
    Pharmacy_ID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(20),
    Street_Address VARCHAR(100),
    Suite VARCHAR(50),
    Postal_Code VARCHAR(20),
    License_Number VARCHAR(50) NOT NULL,
    NPI_Number VARCHAR(20),
    CONSTRAINT pk_pharmacy
    PRIMARY KEY (Pharmacy_ID)
);


-- ==========================================
-- CREATE TABLE: Prescription
-- ==========================================

CREATE TABLE Prescription
(
    Prescription_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    Prescriber_ID INT NOT NULL,
    Medication_ID INT NOT NULL,
    Date_Prescribed DATE,
    Expiration DATE,
    Refills INTEGER,
    Start_Date DATE,
    End_Date DATE,
    Dosage VARCHAR(100) NOT NULL,
    Quantity VARCHAR(20),
    CONSTRAINT pk_prescription
    PRIMARY KEY (Prescription_ID)
);


-- ==========================================
-- CREATE TABLE: Filled Prescription
-- ==========================================

CREATE TABLE Filled_Prescription
(
    FilledPrescription_ID NUMBER NOT NULL,
    Prescription_ID NUMBER NOT NULL,
    Insurance_ID VARCHAR(20) NOT NULL,
    Pharmacy_ID VARCHAR(20) NOT NULL,
    Quantity_Dispensed NUMBER,
    Date_Filled DATE NOT NULL,
    Expiration DATE,
    Instructions VARCHAR(200),
    Refills_Remaining NUMBER,
    CONSTRAINT pk_filled_prescription
    PRIMARY KEY (FilledPrescription_ID)
);


-- ==========================================
-- CREATE TABLE: Drug Codes
-- ==========================================

CREATE TABLE DrugCodes
(
    National_Drug_Code NUMBER NOT NULL,
    Manufacturer VARCHAR(100),
    Strength VARCHAR(50),
    Size VARCHAR(50),
    Color VARCHAR(50),
    Imprint VARCHAR(100),
    CONSTRAINT pk_drugcodes
    PRIMARY KEY (National_Drug_Code)
);


-- ==========================================
-- CREATE TABLE: Inventory
-- ==========================================

CREATE TABLE Inventory
(
    Inventory_ID NUMBER NOT NULL,
    Pharmacy_ID NUMBER NOT NULL,
    Medication_ID NUMBER NOT NULL,
    Date_Ordered DATE,
    Date_Received DATE,
    Stock_Keeping_Unit VARCHAR(100),
    Universal_Product_Code VARCHAR(50),
    Serial_Number VARCHAR(100),
    Item_Location VARCHAR(100),
    Invoice_Price VARCHAR(20),
    Point_Of_Sale_Price VARCHAR(30),
    CONSTRAINT pk_inventory
    PRIMARY KEY (Inventory_ID)
);


-- ==========================================
-- FOREIGN KEY CONSTRAINTS
-- ==========================================

ALTER TABLE Patient
ADD CONSTRAINT fk_patient_postal_codes
FOREIGN KEY (Postal_Code)
REFERENCES Postal_Codes (Postal_Code);


ALTER TABLE Prescriber
ADD CONSTRAINT fk_prescriber_postal_codes
FOREIGN KEY (Postal_Code)
REFERENCES Postal_Codes (Postal_Code);


ALTER TABLE Medication
ADD CONSTRAINT fk_National_Drug_Code
FOREIGN KEY (National_Drug_Code)
REFERENCES DrugCodes (National_Drug_Code);


ALTER TABLE Pharmacy
ADD CONSTRAINT fk_pharmacy_postal_codes
FOREIGN KEY (Postal_Code)
REFERENCES Postal_Codes (Postal_Code);


ALTER TABLE Prescription
ADD CONSTRAINT fk_prescription_patient
FOREIGN KEY (Patient_ID)
REFERENCES Patient (Patient_ID);


ALTER TABLE Prescription
ADD CONSTRAINT fk_prescription_prescriber
FOREIGN KEY (Prescriber_ID)
REFERENCES Prescriber (Prescriber_ID);


ALTER TABLE Prescription
ADD CONSTRAINT fk_prescription_medication
FOREIGN KEY (Medication_ID)
REFERENCES Medication (Medication_ID);


ALTER TABLE Filled_Prescription
ADD CONSTRAINT fk_filled_prescription_prescription
FOREIGN KEY (Prescription_ID)
REFERENCES Prescription (Prescription_ID);


ALTER TABLE Filled_Prescription
ADD CONSTRAINT fk_filled_prescription_insurance_plan
FOREIGN KEY (Insurance_ID)
REFERENCES Insurance_Plan (Insurance_ID);


ALTER TABLE Inventory
ADD CONSTRAINT fk_inventory_pharmacy
FOREIGN KEY (Pharmacy_ID)
REFERENCES Pharmacy(Pharmacy_ID);


ALTER TABLE Inventory
ADD CONSTRAINT fk_inventory_medication
FOREIGN KEY (Medication_ID)
REFERENCES Medication(Medication_ID);


-- ==========================================
-- INSERT DATA
-- ==========================================

INSERT INTO Drug_Codes (National_Drug_Code, Manufacturer, Strength, Size, Color, Imprint)
VALUES ('12345', ' Pfizer ', '500mg ', '5mm', 'Blue', 'L5');

INSERT INTO Drug_Codes (National_Drug_Code, Manufacturer, Strength, Size, Color, Imprint)
VALUES ('13345', ' Merck ', '10mg ', '10mm', 'White', 'M7');

INSERT INTO Drug_Codes (National_Drug_Code, Manufacturer, Strength, Size, Color, Imprint)
VALUES ('14345', ' Novartis ', '250mg ', '6mm', ' Yellow ', 'N3');

INSERT INTO Drug_Codes (National_Drug_Code, Manufacturer, Strength, Size, Color, Imprint)
VALUES ('15345', ' Astrazenca ', '50mg ', '2mm', ' Pink ', 'A9');

INSERT INTO Drug_Codes (National_Drug_Code, Manufacturer, Strength, Size, Color, Imprint)
VALUES ('16345', ' GSK ', '1000mg ', '8mm', 'Orange', 'G2');

INSERT INTO Filled_Prescription(FilledPrescription_ID, Prescription_ID, Insurance_ID,
Pharmacy_ID, Quantity_Dispensed, Date_Filled, Expiration, Instructions, Refills_Remaining)
VALUES ('5001', '1001 ', '4001 ', '2002', '90', '2/1/2001', '2/2/2003', ' Take with Food ', '2');

INSERT INTO Filled_Prescription(FilledPrescription_ID, Prescription_ID, Insurance_ID,
Pharmacy_ID, Quantity_Dispensed, Date_Filled, Expiration, Instructions, Refills_Remaining)
VALUES ('5002', '1002 ', '4002', '2003', '45', '8/10/2003', '2/5/2004', 'Take before meal ', '4');

INSERT INTO Filled_Prescription(FilledPrescription_ID, Prescription_ID, Insurance_ID,
Pharmacy_ID, Quantity_Dispensed, Date_Filled, Expiration, Instructions, Refills_Remaining)
VALUES ('5003', '1003 ', '4003', '2004', '30', '9/4/2004', '9/8/2006', ' Avoid Alcohol ', '1');

INSERT INTO Filled_Prescription(FilledPrescription_ID, Prescription_ID, Insurance_ID,
Pharmacy_ID, Quantity_Dispensed, Date_Filled, Expiration, Instructions, Refills_Remaining)
VALUES ('5004', '1004 ', '4004', '2005', '60', '10/9/2014', '9/4/2016', ' Take on empty Stomach ', '10');

INSERT INTO Filled_Prescription(FilledPrescription_ID, Prescription_ID, Insurance_ID,
Pharmacy_ID, Quantity_Dispensed, Date_Filled, Expiration, Instructions, Refills_Remaining)
VALUES ('5005', '1004 ', '4005', '2006', '30', '4/7/2011', '11/4/2014', ' As needed for pain ', '5');

INSERT INTO Insurance_Plan(Insurance_ID , Date_Of_Issue, Plan_Type, Member_ID, BIN, PCN,
Issuer, RX_GroupNumber, Deductible Copayment ) 
VALUES ( '4001', '2/2/2004', ' PPO ', 'MEM10001',' 001100 ', ' PCN100', ' Blue Cross ', ' RXGRP01', '$500.00', '$10.00' );

INSERT INTO Insurance(Insurance_ID , Date_Of_Issue, Plan_Type, Member_ID, BIN, PCN, Issuer,
RX_GroupNumber, Deductible Copayment )
VALUES ( '4002', '3/6/2005', ' HMO ', ' MEM10002', '2/2/2003', ' 002200 ', ' PCN101', ' Aetna ', ' RXGRP02', '$1,000.00', '$25.00' );

INSERT INTO Insurance(Insurance_ID , Date_Of_Issue, Plan_Type, Member_ID, BIN, PCN, Issuer,
RX_GroupNumber, Deductible Copayment ) 
VALUES ( '4003', '4/5/2004', ' EPO', ' MEM10003', '003300 ', ' PCN102', ' Cigna ', ' RXGRP03', '$400.00', '$20.00' );

INSERT INTO Insurance(Insurance_ID , Date_Of_Issue, Plan_Type, Member_ID, BIN, PCN, Issuer,
RX_GroupNumber, Deductible Copayment ) 
VALUES ( '4004', '1/1/2010', ' POS', ' MEM10004', '004400 ', ' PCN103', ' United Health ', ' RXGRP04', '$1,200.00', '$30.00' );

INSERT INTO Insurance(Insurance_ID , Date_Of_Issue, Plan_Type, Member_ID, BIN, PCN, Issuer,
RX_GroupNumber, Deductible Copayment )
VALUES ( '4005', '8/8/2018', ' High Deductible ', 'MEM10005',' 005500 ', ' PCN104', ' Kaiser ', ' RXGRP05', '$2,500.00', '$50.00' );

INSERT INTO Inventory (Inventory_ID, Pharmacy_ID, Medication_ID, Date_Ordered, Date_Received , Stock_Keeping_Unit, Universal_Product_Code, Serial_Number, Item_Location,
Invoice_Price, Point_Of_Sale_Price)
VALUES ( '3001', '2001', '1111', '12/1/2015 ','12/3/2015', 'SKU123', 'UPC001', ' SN1001', 'Aisle4-
Shelf2', '$50.00', '$75.00', ); 

INSERT INTO Inventory (Inventory_ID, Pharmacy_ID, Medication_ID, Date_Ordered, Date_Received , Stock_Keeping_Unit, Universal_Product_Code, Serial_Number, Item_Location, Invoice_Price, Point_Of_Sale_Price) 
VALUES ('3002', '2002', '2222', ' 6/4/2005','8/10/2005 ', 'SKU456', ' UPC002', ' SN1002', 'Aisle2-Shelf3', '$30.00', '$75.00');

INSERT INTO Inventory (Inventory_ID, Pharmacy_ID, Medication_ID, Date_Ordered, Date_Received , Stock_Keeping_Unit, Universal_Product_Code, Serial_Number, Item_Location,
Invoice_Price, Point_Of_Sale_Price) 
VALUES ('3003', '2003', '3333', '1/1/2000 ','5/5/2000 ', 'SKU789', ' UPC003', ' SN1003', ' Aisle3-Shelf1', '$100.00', '$150.00');

INSERT INTO Inventory (Inventory_ID, Pharmacy_ID, Medication_ID, Date_Ordered,
Date_Received , Stock_Keeping_Unit, Universal_Product_Code, Serial_Number, Item_Location,
Invoice_Price, Point_Of_Sale_Price) 
VALUES ('3004', '2004', '4444', ' 2/4/2010','6/4/2014', ' SKU987', ' UPC004', ' SN1004', ' Aisle8-Shelf3', '$60.00', '$85.00');

INSERT INTO Inventory (Inventory_ID, Pharmacy_ID, Medication_ID, Date_Ordered,
Date_Received , Stock_Keeping_Unit, Universal_Product_Code, Serial_Number, Item_Location,
Invoice_Price, Point_Of_Sale_Price) 
VALUES ('3005', '2005', '5555', ' 6/7/2012', ' 9/9/2015', ' SKU654 ', ' UPC005', ' SN1005 ', ' Aisle1-
Shelf4', '$25.00', '$40.00');

INSERT INTO Medication (Medication_ID, Lot_Number, Expiration_Date, Quantity, Serial_Number,
National_Drug_Code) 
VALUES ('1111', ' LOT123', '1/1/2006', '500',' SN101', '12345');

INSERT INTO Medication (Medication_ID, Lot_Number, Expiration_Date, Quantity, Serial_Number,
National_Drug_Code) 
VALUES ('2222', 'LOT456', '5/15/2016', '250',' SN102', '13345');

INSERT INTO Medication (Medication_ID, Lot_Number, Expiration_Date, Quantity, Serial_Number,
National_Drug_Code) 
VALUES ('3333', ' LOT789', '4/25/1999', '200',' SN103', '14345');

INSERT INTO Medication (Medication_ID, Lot_Number, Expiration_Date, Quantity, Serial_Number,
National_Drug_Code)
VALUES ('4444', ' LOT001', '6/19/2015', '300',' SN104', '15345');

INSERT INTO Medication (Medication_ID, Lot_Number, Expiration_Date, Quantity, Serial_Number,
National_Drug_Code)
VALUES ('5555', ' LOT002', '9/3/2005', '700',' SN105', '16345');

INSERT INTO Patient_ID(Patient_ID, FirstName, LastName, Date_of_Birth, Address, Suite,
Postal_Code, Phone_Number, Email_Address, Social_Security_Number, Allergies) 
VALUES ('01', ' John ', ' Doe ', '8/2/1925', '123 Main ST ','2D ', '11001', ' (718) 123-4567', ' john.doe@email.com
', '123-45-6789', ' Penicillin ');

INSERT INTO Patient_ID(Patient_ID, FirstName, LastName, Date_of_Birth, Address, Suite,
Postal_Code, Phone_Number, Email_Address, Social_Security_Number, Allergies) 
VALUES ('02', ' Rose ', ' Smith', '5/20/1945', '456 Oak Ave ','1st FL ', '11011', '(917) 987-6543',
'rose.smith@email.com', '987-65-4032', 'Latex');

INSERT INTO Patient_ID(Patient_ID, FirstName, LastName, Date_of_Birth, Address, Suite,
Postal_Code, Phone_Number, Email_Address, Social_Security_Number, Allergies) 
VALUES ('03', ' Dowsen', 'Robert', '3/10/1930', '789 Pine RD', '8A ', '21001', ' (888) 989-8777', '
dowsen.robert@email.com', '098-65-4321', 'Sulfa');

INSERT INTO Patient_ID(Patient_ID, FirstName, LastName, Date_of_Birth, Address, Suite,
Postal_Code, Phone_Number, Email_Address, Social_Security_Number, Allergies) 
VALUES('04', ' Maria', 'Garcia', '4/24/1976', '321 Elm ST ',' Unit 7', '21002', '(917) 345-6789',
'maria.gracia@email.com', '123-45-5678', ' Peanuts');

INSERT INTO Patient_ID(Patient_ID, FirstName, LastName, Date_of_Birth, Address, Suite,
Postal_Code, Phone_Number, Email_Address, Social_Security_Number, Allergies) 
VALUES ('05', ' David', ' Lee', '1/5/1987', '654 Cedar Ln ',' Null ', '21002', '(888) 098-7654',
'davis.lee@email.com', '876-09-8765', 'Null');

INSERT INTO Pharmacy(Pharmacy_ID, Name, Phone_Number , Street_Address, Suite, Postal_Code,
License_Number, NPI_Number) 
VALUES ('2001', 'CVS', ' (718) 101-2000', '10 Main ST ',' Suite 2', '11001', ' LIC201', '1122334455');

INSERT INTO Pharmacy(Pharmacy_ID, Name, Phone_Number , Street_Address, Suite, Postal_Code,
License_Number, NPI_Number) 
VALUES ('2002', ' Duane Reade', '(888) 101-2100', '20 Oak Ave ','1D', '11011', ' LIC202', '2233445566');

INSERT INTO Pharmacy(Pharmacy_ID, Name, Phone_Number , Street_Address, Suite, Postal_Code,
License_Number, NPI_Number) 
VALUES ('2003', ' Rite Aid', '(855) 345-6789', '30 Pine Rd ',' Ste B',
'21001', ' LIC203', '3344556677');

INSERT INTO Pharmacy(Pharmacy_ID, Name, Phone_Number , Street_Address, Suite, Postal_Code,
License_Number, NPI_Number) 
VALUES ('2004', ' Walmart ', ' (888) 424-0400', '40 Cedan Dr ','2B',
'21002', ' LIC204', '4455667788');

INSERT INTO Pharmacy(Pharmacy_ID, Name, Phone_Number , Street_Address, Suite, Postal_Code,
License_Number, NPI_Number) 
VALUES ('2005', 'Costo', '(917) 876-5432', '50 Rodeo Drive','5R',
'220021', ' LIC205', '5566778899');

INSERT INTO Prescriber_Data(Prescriber_ID, FirstName, Prescriber_National_Provider_Identifier,
Street_Address, Suite, Postal_Code, Phone_Number, Email_Address, Fax_Number) 
VALUES ('101', 'Sarah', '0102030405', '100 Medical Dr ','4E', '11001', ' (718) 098-0987', ' dr.sarah@medical.com ', '
(718) 098-0978');

INSERT INTO Prescriber_Data(Prescriber_ID, FirstName, Prescriber_National_Provider_Identifier,
Street_Address, Suite, Postal_Code, Phone_Number, Email_Address, Fax_Number) 
VALUES ('102', 'Saulius', '9192939495', '345 Health Ln ',' FL 12', '11011', '(845) 333-4545', 'saulius.md@health.com', '
(800) 234-5689');

INSERT INTO Prescriber_Data(Prescriber_ID, FirstName, Prescriber_National_Provider_Identifier,
Street_Address, Suite, Postal_Code, Phone_Number, Email_Address, Fax_Number)
VALUES ('103', 'Linda', '8283848586', '876 Care Ave ',' suite 400', '21001', '(855) 987-3456', 'linda12@care.com', ' (855)
987-3276');

INSERT INTO Prescriber_Data(Prescriber_ID, FirstName, Prescriber_National_Provider_Identifier,
Street_Address, Suite, Postal_Code, Phone_Number, Email_Address, Fax_Number) 
VALUES ('104', 'Aiden', '7172737475', '550 Recovery ST ','Null', '21002', ' (877) 567-5432', 'aiden.dr@recovery.com
', '(718) 102-0400');

INSERT INTO Prescriber_Data(Prescriber_ID, FirstName, Prescriber_National_Provider_Identifier,
Street_Address, Suite, Postal_Code, Phone_Number, Email_Address, Fax_Number) 
VALUES ('105', 'Joseph', '6162636465', '678 Wellness RD', ' Ste 10', '21002', ' (917) 876-5432', '
joseph.md@wellness.com', '(917) 876-5443');

INSERT INTO Prescription (Prescription_ID, Patient_ID, Prescriber_ID, Medication_ID,
Date_Prescribed, Expiration, Refills, Start_Date, End_Date, Dosage, Quantity) 
VALUES ('1001', ' 01','101', '1111', '2/1/2000', '4/1/2005', '2', '2/3/2000', '6/19/2000', 'Once daily', '90');

INSERT INTO Prescription (Prescription_ID, Patient_ID, Prescriber_ID, Medication_ID,
Date_Prescribed, Expiration, Refills, Start_Date, End_Date, Dosage, Quantity) 
VALUES ('1002', ' 02', '102', '2222', '3/2/2000', '7/23/2000', '5', '3/5/2000', '3/23/2000', ' As Needed', '14');

INSERT INTO Prescription (Prescription_ID, Patient_ID, Prescriber_ID, Medication_ID,
Date_Prescribed, Expiration, Refills, Start_Date, End_Date, Dosage, Quantity) 
VALUES ('1003', ' 03','103', '3333', '8/20/2000', '6/27/2004', '0', '8/22/2026', '9/15/2026', ' Twice daily at Bedtime ', '45');

INSERT INTO Prescription (Prescription_ID, Patient_ID, Prescriber_ID, Medication_ID,
Date_Prescribed, Expiration, Refills, Start_Date, End_Date, Dosage, Quantity) 
VALUES ('1004', ' 04','104', '4444', '12/10/2000', '11/6/2002', '4', '12/14/2002', '4/9/2003', '1 tablet with juice', '30');

INSERT INTO Prescription (Prescription_ID, Patient_ID, Prescriber_ID, Medication_ID,
Date_Prescribed, Expiration, Refills, Start_Date, End_Date, Dosage, Quantity) 
VALUES ('1005', ' 05', '105', '5555', '10/9/2000', '4/15/2001', '1', '6/1/2001', '8/2/2001', ' Half tablet at night ', '60');


-- ==========================================
-- SELECT QUERIES
-- ==========================================

-- Prescriber with the Most Prescriptions

SELECT Prescriber_Data.Prescriber_ID,
       Prescriber_Data.FirstName,
       Prescriber_Data.LastName,
       Count(Prescription.Prescription_ID) AS Total_Prescriptions
FROM Prescriber_Data
INNER JOIN Prescription
ON Prescriber_Data.Prescriber_ID = Prescription.Prescriber_ID
GROUP BY Prescriber_Data.Prescriber_ID,
         Prescriber_Data.FirstName,
         Prescriber_Data.LastName
ORDER BY Count(Prescription.Prescription_ID) DESC;


-- Most Prescribed Medication

SELECT Medication.Medication_ID,
       Medication.Medication_Name,
       Count(Prescription.Prescription_ID) AS Times_Prescribed
FROM Medication
INNER JOIN Prescription
ON Medication.Medication_ID = Prescription.Medication_ID
GROUP BY Medication.Medication_ID,
         Medication.Medication_Name
ORDER BY Count(Prescription.Prescription_ID) DESC;


-- Pharmacy with the Most Filled Prescriptions

SELECT Pharmacy.Pharmacy_ID,
       Pharmacy.Name,
       Count(Filled_Prescription.Prescription_ID) AS Total_Filled
FROM Pharmacy
INNER JOIN Filled_Prescription
ON Pharmacy.Pharmacy_ID = Filled_Prescription.Pharmacy_ID
GROUP BY Pharmacy.Pharmacy_ID,
         Pharmacy.Name
ORDER BY Count(Filled_Prescription.Prescription_ID) DESC;
