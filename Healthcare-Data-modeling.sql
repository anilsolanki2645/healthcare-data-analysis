-- **Title: Healthcare Data Warehouse Schema with Appointment Analytics**

-- **Summary:**
-- This healthcare data warehouse schema is designed to facilitate comprehensive analysis and management of healthcare-related data. It includes dimension tables for patients, doctors, medical facilities, and time, along with a fact table specifically tailored for appointment data. The schema enables tracking patient appointments across different medical facilities, with details such as appointment type, date, duration, and involved doctors. This structured approach allows healthcare organizations to gain insights into appointment scheduling, patient demographics, doctor availability, and facility utilization, ultimately enhancing operational efficiency and patient care delivery.

CREATE DATABASE IF NOT EXISTS healthcare;

USE healthcare;

CREATE TABLE IF NOT EXISTS dim_time (
    time_key INT PRIMARY KEY,
    date DATE,
    day_of_week VARCHAR(20),
    month VARCHAR(20),
    quarter VARCHAR(5),
    year INT,
    holiday_flag BOOLEAN
);


CREATE TABLE IF NOT EXISTS dim_patient (
    patient_key INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    medical_history TEXT
);


CREATE TABLE IF NOT EXISTS dim_doctor (
    doctor_key INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100),
    hospital VARCHAR(100),
    experience_years INT,
    contact_number VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS dim_medical_facility (
    facility_key INT PRIMARY KEY,
    facility_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    type VARCHAR(50)
);

-- REMAINS
CREATE TABLE IF NOT EXISTS fact_appointment (
    appointment_key INT PRIMARY KEY,
    time_key INT  REFERENCES dim_time(time_key),
    patient_key INT  REFERENCES dim_patient(patient_key),
    doctor_key INT  REFERENCES dim_doctor(doctor_key),
    facility_key INT REFERENCES dim_medical_facility(facility_key),
    appointment_type VARCHAR(50),
    appointment_date DATE,
    appointment_duration INTERVAL
);
