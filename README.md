# Healthcare Data Analysis with SQL

This repository contains SQL scripts for analyzing healthcare data, focusing on appointments, doctors, patients, medical facilities, and time dimensions. The objective is to derive meaningful insights using various SQL queries.

## Table Structure

### Fact Table: fact_appointment
- Contains quantitative information about healthcare appointments.
- **Attributes**:
  - `appointment_key`
  - `doctor_key`
  - `patient_key`
  - `facility_key`
  - `time_key`
  - `appointment_duration`
  
- **Foreign Keys**:
  - Connect to dimension tables (`dim_doctor`, `dim_patient`, `dim_medical_facility`, `dim_time`) to provide context to appointments.

### Dimension Tables

1. **dim_doctor**
   - **Attributes**:
     - `doctor_id`
     - `doctor_name`
     - `specialization`
     - `years_of_experience`
     - `facility_key`
     
2. **dim_patient**
   - **Attributes**:
     - `patient_id`
     - `patient_name`
     - `age`
     - `gender`
     - `blood_type`
     
3. **dim_medical_facility**
   - **Attributes**:
     - `facility_id`
     - `facility_name`
     - `facility_type`
     - `city`
     - `state`
     
4. **dim_time**
   - **Attributes**:
     - `date`
     - `day_of_week`
     - `month`
     - `quarter`
     - `year`

## Queries for Data Analysis

## Key Insights and Queries

We have executed various SQL queries to extract insights from the dataset, including:

1. **Total Number of Appointments per Doctor**
2. **Average Appointment Duration by Facility**
3. **Total Appointments per Month**
4. **Number of Appointments by Patient with at Least 1 Appointment**
5. **Average Age of Patients by Blood Type**
6. **Number of Doctors by Specialization with More Than 10 Years of Experience**
7. **Total Appointments by Facility Type**
8. **Number of Appointments on Holidays**
9. **Total Appointments and Unique Patients per Doctor**
10. **Monthly Appointment Count per Facility for the Current Year**
11. **Doctors with Average Appointment Duration Greater than 30 Minutes**
12. **Facilities with More Than 100 Appointments in the Last Year**
13. **Total Appointments by Day of the Week and Facility Type**
14. **Average Number of Appointments per Day for Each Doctor**
15. **Number of Appointments by Gender and Age Group**
16. **Average Appointment Duration by Day of the Week for Each Facility (where average duration > 30 minutes)**
17. **Total Appointments for Patients with Blood Type 'O' in the Last Six Months**
18. **Percentage of Appointments by Specialization for the Current Year**

For detailed SQL queries, please refer to the `Healthcare_Queries.sql` file.

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/anilsolanki2645/healthcare-data-analysis.git
   cd healthcare-data-analysis