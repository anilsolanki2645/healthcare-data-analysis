-- -----------------------------------------------------------------------------------------
				-- Aggregate functions along with the GROUP BY and HAVING clauses.
-- -----------------------------------------------------------------------------------------

/* NOTE : 1. Result can be change according to data
		  2. also you can change queries according to your need */

-- [1] Total Number of Appointments per Doctor

SELECT 
    doctor_key,
    COUNT(appointment_key) AS total_appointments
FROM 
    fact_appointment
GROUP BY 
    doctor_key;

/*
+------------+--------------------+
| doctor_key | total_appointments |
+------------+--------------------+
|          1 |                  1 |
|          2 |                  1 |
|          3 |                  1 |
|          4 |                  1 |
|          5 |                  1 |
|          6 |                  1 |
|          7 |                  1 |
|          8 |                  1 |
|          9 |                  1 |
|         10 |                  1 |
|         11 |                  1 |
|         12 |                  1 |
|         13 |                  1 |
|         14 |                  1 |
|         15 |                  1 |
|         16 |                  1 |
|         17 |                  1 |
|         18 |                  1 |
|         19 |                  1 |
|         20 |                  1 |
|         21 |                  1 |
|         22 |                  1 |
|         23 |                  1 |
|         24 |                  1 |
|         25 |                  1 |
|         26 |                  1 |
|         27 |                  1 |
|         28 |                  1 |
|         29 |                  1 |
|         30 |                  1 |
+------------+--------------------+  */

-- [2] Average Appointment Duration by Facility

SELECT 
    facility_key,
    AVG(appointment_duration) AS avg_appointment_duration
FROM 
    fact_appointment
GROUP BY 
    facility_key;

/* 
+--------------+--------------------------+
| facility_key | avg_appointment_duration |
+--------------+--------------------------+
|            1 |                  47.5000 |
|            2 |                  40.0000 |
|            3 |                  42.5000 |
|            4 |                  42.5000 |
|            5 |                  50.0000 |
+--------------+--------------------------+  */

-- [3] Total Appointments per Month

SELECT 
    month,
    COUNT(appointment_key) AS total_appointments
FROM 
    fact_appointment
JOIN 
    dim_time ON fact_appointment.time_key = dim_time.time_key
GROUP BY 
    month;

/*
+---------+--------------------+
| month   | total_appointments |
+---------+--------------------+
| January |                 30 |
+---------+--------------------+	*/

-- [4] Number of Appointments by Patient with at Least 1 Appointments

SELECT 
    patient_key,
    COUNT(appointment_key) AS appointment_count
FROM 
    fact_appointment
GROUP BY 
    patient_key
HAVING 
    COUNT(appointment_key) >= 5;

-- Empty set (0.00 sec)

-- [5] Average Age of Patients by Blood Type

SELECT 
    blood_type,
    AVG(age) AS avg_age
FROM 
    dim_patient
GROUP BY 
    blood_type;

/*
+------------+---------+
| blood_type | avg_age |
+------------+---------+
| O+         | 34.1667 |
| A-         | 40.6667 |
| AB+        | 42.8571 |
| B+         | 40.3333 |
| O-         | 41.6000 |
| A+         | 44.3333 |
| B-         | 45.3333 |
+------------+---------+	*/

-- [6] Number of Doctors by Specialization with More Than 10 Years of Experience

SELECT 
    specialization,
    COUNT(doctor_key) AS number_of_doctors
FROM 
    dim_doctor
GROUP BY 
    specialization
HAVING 
    AVG(experience_years) > 10;

/*
+--------------------+-------------------+
| specialization     | number_of_doctors |
+--------------------+-------------------+
| Cardiologist       |                 2 |
| Dermatologist      |                 2 |
| Orthopedic Surgeon |                 2 |
| Gynecologist       |                 2 |
| Neurologist        |                 2 |
| Oncologist         |                 2 |
| ENT Specialist     |                 2 |
| Urologist          |                 2 |
| Psychiatrist       |                 2 |
| Ophthalmologist    |                 2 |
| Dentist            |                 2 |
| Endocrinologist    |                 2 |
| General Surgeon    |                 2 |
| Rheumatologist     |                 1 |
+--------------------+-------------------+	*/

-- [7] Total Appointments by Facility Type

SELECT 
    type,
    COUNT(appointment_key) AS total_appointments
FROM 
    fact_appointment
JOIN 
    dim_medical_facility ON fact_appointment.facility_key = dim_medical_facility.facility_key
GROUP BY 
    type;

/*
+----------+--------------------+
| type     | total_appointments |
+----------+--------------------+
| Hospital |                 30 |
+----------+--------------------+	*/

-- [8] Number of Appointments on Holidays

SELECT 
    holiday_flag,
    COUNT(appointment_key) AS total
FROM fact_appointment
JOIN DIM_TIME ON fact_appointment.time_key = dim_time.time_key
	GROUP BY holiday_flag;

/*
+--------------+-------+
| holiday_flag | total |
+--------------+-------+
|            1 |     2 |
|            0 |    28 |
+--------------+-------+	*/

-- [9] Total Appointments and Unique Patients per Doctor

SELECT 
    dd.doctor_name,
    COUNT(fa.appointment_key) AS total_appointments,
    COUNT(DISTINCT fa.patient_key) AS unique_patients
FROM 
    fact_appointment fa
JOIN 
    dim_doctor dd ON fa.doctor_key = dd.doctor_key
GROUP BY 
    dd.doctor_name;

/*
+---------------------+--------------------+-----------------+
| doctor_name         | total_appointments | unique_patients |
+---------------------+--------------------+-----------------+
| Dr. Amit Kumar      |                  1 |               1 |
| Dr. Ananya Singh    |                  1 |               1 |
| Dr. Anil Tiwari     |                  1 |               1 |
| Dr. Anjali Verma    |                  1 |               1 |
| Dr. Ankit Gupta     |                  1 |               1 |
| Dr. Arjun Gupta     |                  1 |               1 |
| Dr. Ashish Singh    |                  1 |               1 |
| Dr. Kartik Singh    |                  1 |               1 |
| Dr. Mohan Sharma    |                  1 |               1 |
| Dr. Mohit Patel     |                  1 |               1 |
| Dr. Neha Gupta      |                  1 |               1 |
| Dr. Nidhi Singh     |                  1 |               1 |
| Dr. Nisha Patel     |                  1 |               1 |
| Dr. Pooja Sharma    |                  1 |               1 |
| Dr. Preeti Sharma   |                  1 |               1 |
| Dr. Priya Gupta     |                  1 |               1 |
| Dr. Priyanka Tiwari |                  1 |               1 |
| Dr. Rahul Gupta     |                  1 |               1 |
| Dr. Rahul Verma     |                  1 |               1 |
| Dr. Rajesh Kumar    |                  1 |               1 |
| Dr. Reena Patel     |                  1 |               1 |
| Dr. Ritu Sharma     |                  1 |               1 |
| Dr. Rohan Verma     |                  1 |               1 |
| Dr. Rohit Kumar     |                  1 |               1 |
| Dr. Ruchi Verma     |                  1 |               1 |
| Dr. Sanjay Verma    |                  1 |               1 |
| Dr. Sonal Gupta     |                  1 |               1 |
| Dr. Sunita Reddy    |                  1 |               1 |
| Dr. Tanvi Singh     |                  1 |               1 |
| Dr. Vikas Singh     |                  1 |               1 |
+---------------------+--------------------+-----------------+	*/

-- [10] Monthly Appointment Count per Facility for the Current Year

SELECT 
    dmf.facility_name,
    dt.month,
    COUNT(fa.appointment_key) AS total_appointments
FROM 
    fact_appointment fa
JOIN 
    dim_time dt ON fa.time_key = dt.time_key
JOIN 
    dim_medical_facility dmf ON fa.facility_key = dmf.facility_key
WHERE 
    dt.year = YEAR(CURRENT_DATE)
GROUP BY 
    dmf.facility_name, dt.month;

/*
+------------------------+---------+--------------------+
| facility_name          | month   | total_appointments |
+------------------------+---------+--------------------+
| Apollo Hospitals       | January |                  6 |
| Fortis Hospital        | January |                  6 |
| Max Hospital           | January |                  6 |
| Columbia Asia Hospital | January |                  6 |
| Medanta - The Medicity | January |                  6 |
+------------------------+---------+--------------------+	*/

-- [11] Doctors with Average Appointment Duration Greater than 30 Minutes

SELECT 
    dd.doctor_name,
    AVG(appointment_duration) AS avg_appointment_duration_minutes
FROM 
    fact_appointment fa
JOIN 
    dim_doctor dd ON fa.doctor_key = dd.doctor_key
GROUP BY 
    dd.doctor_name
HAVING 
    AVG(appointment_duration) > 30;

/*
+---------------------+----------------------------------+
| doctor_name         | avg_appointment_duration_minutes |
+---------------------+----------------------------------+
| Dr. Mohan Sharma    |                          60.0000 |
| Dr. Rahul Verma     |                          45.0000 |
| Dr. Amit Kumar      |                          60.0000 |
| Dr. Sunita Reddy    |                          60.0000 |
| Dr. Reena Patel     |                          45.0000 |
| Dr. Neha Gupta      |                          60.0000 |
| Dr. Pooja Sharma    |                          45.0000 |
| Dr. Ananya Singh    |                          60.0000 |
| Dr. Arjun Gupta     |                          45.0000 |
| Dr. Sanjay Verma    |                          60.0000 |
| Dr. Nisha Patel     |                          45.0000 |
| Dr. Priyanka Tiwari |                          60.0000 |
| Dr. Ankit Gupta     |                          45.0000 |
| Dr. Mohit Patel     |                          60.0000 |
| Dr. Preeti Sharma   |                          45.0000 |
| Dr. Sonal Gupta     |                          60.0000 |
| Dr. Anjali Verma    |                          45.0000 |
| Dr. Tanvi Singh     |                          60.0000 |
| Dr. Rahul Gupta     |                          45.0000 |
+---------------------+----------------------------------+	*/

-- [12] Facilities with More Than 100 Appointments in the Last Year

SELECT 
    dmf.facility_name,
    COUNT(fa.appointment_key) AS total_appointments
FROM 
    fact_appointment fa
JOIN 
    dim_medical_facility dmf ON fa.facility_key = dmf.facility_key
JOIN 
    dim_time dt ON fa.time_key = dt.time_key
WHERE 
    dt.year = YEAR(CURRENT_DATE) - 1
GROUP BY 
    dmf.facility_name
HAVING 
    COUNT(fa.appointment_key) > 100;

-- Empty set (0.00 sec)

-- [13] Average Age of Patients for Each Blood Type

SELECT 
    dp.blood_type,
    AVG(dp.age) AS avg_age
FROM 
    dim_patient dp
GROUP BY 
    dp.blood_type;

/*
+------------+---------+
| blood_type | avg_age |
+------------+---------+
| O+         | 34.1667 |
| A-         | 40.6667 |
| AB+        | 42.8571 |
| B+         | 40.3333 |
| O-         | 41.6000 |
| A+         | 44.3333 |
| B-         | 45.3333 |
+------------+---------+	*/

-- [14] Total Appointments by Day of the Week and Facility Type

SELECT 
    dt.day_of_week,
    dmf.type,
    COUNT(fa.appointment_key) AS total_appointments
FROM 
    fact_appointment fa
JOIN 
    dim_time dt ON fa.time_key = dt.time_key
JOIN 
    dim_medical_facility dmf ON fa.facility_key = dmf.facility_key
GROUP BY 
    dt.day_of_week, dmf.type;

/*
+-------------+----------+--------------------+
| day_of_week | type     | total_appointments |
+-------------+----------+--------------------+
| Sunday      | Hospital |                  5 |
| Monday      | Hospital |                  5 |
| Tuesday     | Hospital |                  4 |
| Wednesday   | Hospital |                  4 |
| Thursday    | Hospital |                  4 |
| Friday      | Hospital |                  4 |
| Saturday    | Hospital |                  4 |
+-------------+----------+--------------------+		*/

-- [15] Average Number of Appointments per Day for Each Doctor

SELECT 
    dd.doctor_name,
    AVG(daily_appointments) AS avg_daily_appointments
FROM 
    (
        SELECT 
            doctor_key,
            COUNT(appointment_key) AS daily_appointments,
            appointment_date
        FROM 
            fact_appointment
        GROUP BY 
            doctor_key, appointment_date
    ) AS daily_counts
JOIN 
    dim_doctor dd ON daily_counts.doctor_key = dd.doctor_key
GROUP BY 
    dd.doctor_name;

/*
+---------------------+------------------------+
| doctor_name         | avg_daily_appointments |
+---------------------+------------------------+
| Dr. Mohan Sharma    |                 1.0000 |
| Dr. Nidhi Singh     |                 1.0000 |
| Dr. Rahul Verma     |                 1.0000 |
| Dr. Priya Gupta     |                 1.0000 |
| Dr. Amit Kumar      |                 1.0000 |
| Dr. Sunita Reddy    |                 1.0000 |
| Dr. Anil Tiwari     |                 1.0000 |
| Dr. Reena Patel     |                 1.0000 |
| Dr. Vikas Singh     |                 1.0000 |
| Dr. Neha Gupta      |                 1.0000 |
| Dr. Rohan Verma     |                 1.0000 |
| Dr. Pooja Sharma    |                 1.0000 |
| Dr. Rajesh Kumar    |                 1.0000 |
| Dr. Ananya Singh    |                 1.0000 |
| Dr. Arjun Gupta     |                 1.0000 |
| Dr. Ritu Sharma     |                 1.0000 |
| Dr. Sanjay Verma    |                 1.0000 |
| Dr. Nisha Patel     |                 1.0000 |
| Dr. Ashish Singh    |                 1.0000 |
| Dr. Priyanka Tiwari |                 1.0000 |
| Dr. Ankit Gupta     |                 1.0000 |
| Dr. Ruchi Verma     |                 1.0000 |
| Dr. Mohit Patel     |                 1.0000 |
| Dr. Preeti Sharma   |                 1.0000 |
| Dr. Kartik Singh    |                 1.0000 |
| Dr. Sonal Gupta     |                 1.0000 |
| Dr. Anjali Verma    |                 1.0000 |
| Dr. Rohit Kumar     |                 1.0000 |
| Dr. Tanvi Singh     |                 1.0000 |
| Dr. Rahul Gupta     |                 1.0000 |
+---------------------+------------------------+	*/

-- [16] Number of Appointments by Gender and Age Group

SELECT 
    dp.gender,
    CASE 
        WHEN dp.age BETWEEN 0 AND 17 THEN '0-17'
        WHEN dp.age BETWEEN 18 AND 35 THEN '18-35'
        WHEN dp.age BETWEEN 36 AND 55 THEN '36-55'
        ELSE '56+'
    END AS age_group,
    COUNT(fa.appointment_key) AS total_appointments
FROM 
    fact_appointment fa
JOIN 
    dim_patient dp ON fa.patient_key = dp.patient_key
GROUP BY 
    dp.gender, age_group;

/*
+--------+-----------+--------------------+
| gender | age_group | total_appointments |
+--------+-----------+--------------------+
| Male   | 36-55     |                  9 |
| Female | 18-35     |                 10 |
| Male   | 56+       |                  4 |
| Female | 36-55     |                  5 |
| Male   | 18-35     |                  2 |
+--------+-----------+--------------------+	*/

-- [17] Average Appointment Duration by Day of the Week for Each Facility WHERE Avarage appointment_duration > 30

SELECT 
    dmf.facility_name,
    dt.day_of_week,
    AVG(appointment_duration) AS avg_duration_minutes
FROM 
    fact_appointment fa
JOIN 
    dim_medical_facility dmf ON fa.facility_key = dmf.facility_key
JOIN 
    dim_time dt ON fa.time_key = dt.time_key
GROUP BY 
    dmf.facility_name, dt.day_of_week
HAVING 
	AVG(appointment_duration) > 30;

/*
+------------------------+-------------+----------------------+
| facility_name          | day_of_week | avg_duration_minutes |
+------------------------+-------------+----------------------+
| Apollo Hospitals       | Sunday      |              60.0000 |
| Max Hospital           | Tuesday     |              45.0000 |
| Medanta - The Medicity | Thursday    |              60.0000 |
| Apollo Hospitals       | Friday      |              60.0000 |
| Max Hospital           | Sunday      |              45.0000 |
| Medanta - The Medicity | Tuesday     |              60.0000 |
| Fortis Hospital        | Thursday    |              45.0000 |
| Columbia Asia Hospital | Saturday    |              60.0000 |
| Medanta - The Medicity | Sunday      |              45.0000 |
| Fortis Hospital        | Tuesday     |              60.0000 |
| Max Hospital           | Wednesday   |              45.0000 |
| Medanta - The Medicity | Friday      |              60.0000 |
| Apollo Hospitals       | Saturday    |              45.0000 |
| Max Hospital           | Monday      |              60.0000 |
| Columbia Asia Hospital | Tuesday     |              45.0000 |
| Apollo Hospitals       | Thursday    |              60.0000 |
| Fortis Hospital        | Friday      |              45.0000 |
| Columbia Asia Hospital | Sunday      |              60.0000 |
| Medanta - The Medicity | Monday      |              45.0000 |
+------------------------+-------------+----------------------+	*/

-- [18] Monthly Appointment Growth Rate for Each Doctor

WITH MonthlyCounts AS (
    SELECT 
        doctor_key,
        dt.year,
        dt.month,
        COUNT(appointment_key) AS monthly_appointments
    FROM 
        fact_appointment fa
    JOIN 
        dim_time dt ON fa.time_key = dt.time_key
    GROUP BY 
        doctor_key, dt.year, dt.month
),
PreviousMonth AS (
    SELECT 
        doctor_key,
        year,
        month,
        monthly_appointments,
        LAG(monthly_appointments, 1) OVER (PARTITION BY doctor_key ORDER BY year, month) AS previous_month_appointments
    FROM 
        MonthlyCounts
)
SELECT 
    dd.doctor_name,
    pm.year,
    pm.month,
    pm.monthly_appointments,
    pm.previous_month_appointments,
    ROUND((pm.monthly_appointments - pm.previous_month_appointments) / pm.previous_month_appointments * 100, 2) AS growth_rate_percentage
FROM 
    PreviousMonth pm
JOIN 
    dim_doctor dd ON pm.doctor_key = dd.doctor_key
WHERE 
    pm.previous_month_appointments IS NOT NULL;

-- Empty set (0.00 sec)

-- [19] Average Age of Patients per Doctor

SELECT 
    dd.doctor_name,
    AVG(dp.age) AS avg_patient_age
FROM 
    fact_appointment fa
JOIN 
    dim_doctor dd ON fa.doctor_key = dd.doctor_key
JOIN 
    dim_patient dp ON fa.patient_key = dp.patient_key
GROUP BY 
    dd.doctor_name;

/*
+---------------------+-----------------+
| doctor_name         | avg_patient_age |
+---------------------+-----------------+
| Dr. Mohan Sharma    |         45.0000 |
| Dr. Nidhi Singh     |         28.0000 |
| Dr. Rahul Verma     |         60.0000 |
| Dr. Priya Gupta     |         35.0000 |
| Dr. Amit Kumar      |         50.0000 |
| Dr. Sunita Reddy    |         22.0000 |
| Dr. Anil Tiwari     |         40.0000 |
| Dr. Reena Patel     |         55.0000 |
| Dr. Vikas Singh     |         32.0000 |
| Dr. Neha Gupta      |         48.0000 |
| Dr. Rohan Verma     |         25.0000 |
| Dr. Pooja Sharma    |         38.0000 |
| Dr. Rajesh Kumar    |         42.0000 |
| Dr. Ananya Singh    |         30.0000 |
| Dr. Arjun Gupta     |         57.0000 |
| Dr. Ritu Sharma     |         33.0000 |
| Dr. Sanjay Verma    |         47.0000 |
| Dr. Nisha Patel     |         29.0000 |
| Dr. Ashish Singh    |         63.0000 |
| Dr. Priyanka Tiwari |         36.0000 |
| Dr. Ankit Gupta     |         51.0000 |
| Dr. Ruchi Verma     |         27.0000 |
| Dr. Mohit Patel     |         44.0000 |
| Dr. Preeti Sharma   |         31.0000 |
| Dr. Kartik Singh    |         56.0000 |
| Dr. Sonal Gupta     |         39.0000 |
| Dr. Anjali Verma    |         53.0000 |
| Dr. Rohit Kumar     |         34.0000 |
| Dr. Tanvi Singh     |         49.0000 |
| Dr. Rahul Gupta     |         26.0000 |
+---------------------+-----------------+ 	*/

-- [20] 


