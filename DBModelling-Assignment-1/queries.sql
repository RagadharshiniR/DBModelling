-- Tenants Table
CREATE TABLE Tenants (
    Tenant_ID INT PRIMARY KEY,
    Tenant_Name VARCHAR(255) NOT NULL
);

-- SubTenant Table
CREATE TABLE SubTenant (
    SubTenant_ID INT PRIMARY KEY,
    TenantID INT NOT NULL,
    Branch VARCHAR(255),
    FOREIGN KEY (TenantID) REFERENCES Tenants(Tenant_ID) ON DELETE CASCADE
);

-- Inventory Table
CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    SubTenant_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Supplier_ID INT NOT NULL,
    Quantity INT CHECK (Quantity >= 0),
    FOREIGN KEY (SubTenant_ID) REFERENCES SubTenant(SubTenant_ID) ON DELETE CASCADE
);

-- Suppliers Table
CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(255) NOT NULL
);

-- Product Table
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2)
);

-- Supplier-Product Mapping Table
CREATE TABLE Supplier_Products (
    Supplier_Product_ID INT PRIMARY KEY,
    Supplier_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE
);

-- Services Table
CREATE TABLE Services (
    Service_ID INT PRIMARY KEY,
    SubTenant_ID INT NOT NULL,
    Service_Name VARCHAR(255),
    Service_Price DECIMAL(10, 2),
    FOREIGN KEY (SubTenant_ID) REFERENCES SubTenant(SubTenant_ID) ON DELETE CASCADE
);

-- Employees Table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    SubTenant_ID INT NOT NULL,
    Employee_Name VARCHAR(255),
    Gender CHAR(1),
    FOREIGN KEY (SubTenant_ID) REFERENCES SubTenant(SubTenant_ID) ON DELETE CASCADE
);

-- Employee-Service Mapping Table
CREATE TABLE EmployeeServices (
    EmployeeService_ID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    ServiceID INT NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(Employee_ID) ON DELETE CASCADE,
    FOREIGN KEY (ServiceID) REFERENCES Services(Service_ID) ON DELETE CASCADE
);

-- Patients Table
CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(255) NOT NULL
);

-- Appointments Table
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    EmployeeService_ID INT NOT NULL,
    Appointment_Timestamp TIMESTAMP,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID) ON DELETE CASCADE,
    FOREIGN KEY (EmployeeService_ID) REFERENCES EmployeeServices(EmployeeService_ID) ON DELETE CASCADE
);

-- SalesRecord Table
CREATE TABLE SalesRecord (
    Sales_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Timestamp TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID) ON DELETE CASCADE
);

-- ServiceRecord Table
CREATE TABLE ServiceRecord (
    Service_Record_ID INT PRIMARY KEY,
    EmployeeServiceID INT NOT NULL,
    Sales_ID INT NOT NULL,
    Timestamp TIMESTAMP,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeServiceID) REFERENCES EmployeeServices(EmployeeService_ID) ON DELETE CASCADE,
    FOREIGN KEY (Sales_ID) REFERENCES SalesRecord(Sales_ID) ON DELETE CASCADE
);

-- ProductRecord Table
CREATE TABLE ProductRecord (
    Product_Record_ID INT PRIMARY KEY,
    Sales_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10, 2),
    FOREIGN KEY (Sales_ID) REFERENCES SalesRecord(Sales_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE
);






-- Insert Tenants
INSERT INTO Tenants (Tenant_ID, Tenant_Name) VALUES (1, 'Tenant A');

-- Insert SubTenants
INSERT INTO SubTenant (SubTenant_ID, TenantID, Branch) VALUES (1, 1, 'Branch A');

-- Insert Employees
INSERT INTO Employee (Employee_ID, SubTenant_ID, Employee_Name, Gender) VALUES (1, 1, 'Alice', 'F');

-- Insert Services
INSERT INTO Services (Service_ID, SubTenant_ID, Service_Name, Service_Price) VALUES (1, 1, 'Consultation', 100.00);

-- Employee-Service Mapping
INSERT INTO EmployeeServices (EmployeeService_ID, EmployeeID, ServiceID) VALUES (1, 1, 1);

-- Insert Patients
INSERT INTO Patients (Patient_ID, Patient_Name) VALUES (1, 'John Doe');

-- Insert Appointments
INSERT INTO Appointment (Appointment_ID, Patient_ID, EmployeeService_ID, Appointment_Timestamp) 
VALUES (1, 1, 1, '2025-01-08 10:00:00');

-- Insert Sales Records
INSERT INTO SalesRecord (Sales_ID, Patient_ID, Timestamp, TotalAmount) 
VALUES (1, 1, '2025-01-08 11:00:00', 500.00);

-- Insert ServiceRecord
INSERT INTO ServiceRecord (Service_Record_ID, EmployeeServiceID, Sales_ID, Timestamp, Amount) 
VALUES (1, 1, 1, '2025-01-08 11:30:00', 100.00);

-- Insert Products and Suppliers
INSERT INTO Suppliers (Supplier_ID, Supplier_Name) VALUES (1, 'Supplier A');
INSERT INTO Product (Product_ID, Product_Name, Description, Price) VALUES (1, 'Product A', 'Description A', 50.00);

-- Supplier-Product Mapping
INSERT INTO Supplier_Products (Supplier_Product_ID, Supplier_ID, Product_ID) VALUES (1, 1, 1);

-- ProductRecord
INSERT INTO ProductRecord (Product_Record_ID, Sales_ID, Product_ID, Quantity, Price) VALUES (1, 1, 1, 2, 100.00);
