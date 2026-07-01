##create database
CREATE DATABASE IF NOT EXISTS prestige_crm;   
USE prestige_crm;


CREATE TABLE IF NOT EXISTS customers_c4c (
  customer_id    INT PRIMARY KEY AUTO_INCREMENT,
  first_name     VARCHAR(50) NOT NULL,
  last_name      VARCHAR(50),
  email          VARCHAR(150),
  mobile         VARCHAR(150),
  location       VARCHAR(150),
  city           VARCHAR(80),
  role           VARCHAR(50) CHECK (role IN (
                   'Customer',
                   'Prospect',
                   'Corp Comm Prospect',
                   'RR Projects'
                 )),
  status         VARCHAR(20) CHECK (status IN (
                   'Active',
                   'Blocked',
                   'Obsolete'
                 )),
  created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
  changed_on     DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO customers_c4c
  (first_name, last_name, email, mobile, location, city, role, status)
VALUES
-- ✅ VALID MOBILE + VALID EMAIL
('Priya',    'Sharma',   'priya.sharma@gmail.com',           '9876543210',             'Koramangala',    'Bangalore', 'Customer',          'Active'),
('Rahul',    'Mehta',    'rahul.mehta@outlook.com',          '+91 9123456789',          'Andheri',        'Mumbai',    'Customer',          'Active'),
('Anita',    'Rao',      'anita.rao@yahoo.com',              '+91 8765432109',          'Banjara Hills',  'Hyderabad', 'Customer',          'Active'),
('Vikram',   'Nair',     '01.vikramnair@gmail.com',          '7654321098',             'Anna Nagar',     'Chennai',   'Prospect',          'Active'),
('Deepa',    'Iyer',     'deepa.iyer@rediffmail.com',        '+974 66468255',           'MG Road',        'Bangalore', 'Customer',          'Active'),
('Suresh',   'Kumar',    'suresh.kumar@gmail.com',           '+1 9173923539',           'Whitefield',     'Bangalore', 'Prospect',          'Active'),
('Kavitha',  'Menon',    'kavitha.menon@gmail.com',          '+44 7550247468',          'Indiranagar',    'Bangalore', 'Customer',          'Active'),
('Arjun',    'Pillai',   'arjun.pillai@outlook.com',         '8123338251',             'Powai',          'Mumbai',    'Corp Comm Prospect','Active'),
('Meena',    'Reddy',    'meena.reddy@yahoo.com',            '+91 7766445765',          'Jubilee Hills',  'Hyderabad', 'Customer',          'Active'),
('Sanjay',   'Joshi',    'sanjay.joshi@gmail.com',           '+41 794604094',           'Kalyani Nagar',  'Pune',      'Prospect',          'Active'),
 
-- ✅ VALID MOBILE + CLEANABLE EMAIL (typo domains)
('Ziyad',    'Ahmad',    'ziyadahmad466@gmel.com',           '9845012345',             'HSR Layout',     'Bangalore', 'Customer',          'Active'),
('Farhan',   'Sheikh',   'farhan.sheikh@gmial.com',          '8976543210',             'Bandra',         'Mumbai',    'Prospect',          'Active'),
('Pooja',    'Verma',    'pooja.verma@gmaill.com',           '7890123456',             'Secunderabad',   'Hyderabad', 'RR Projects',       'Active'),
('Rohit',    'Gupta',    'rohit.gupta@yaho.com',             '9012345678',             'Velachery',      'Chennai',   'Customer',          'Active'),
('Sneha',    'Patil',    'sneha.patil@yahooo.com',           '+91 8901234567',          'Kothrud',        'Pune',      'Prospect',          'Active'),
('Manoj',    'Singh',    'manoj.singh@outllok.com',          '7012345678',             'Marathahalli',   'Bangalore', 'Corp Comm Prospect','Active'),
('Divya',    'Nair',     'divya.nair@rediff.com',            '+91 9123456780',          'Vile Parle',     'Mumbai',    'Customer',          'Active'),
('Kiran',    'Kumar',    'ziyadahmada160@maeil.com',         '8234567890',             'Kondapur',       'Hyderabad', 'Prospect',          'Active'),
 
-- ❌ VALID MOBILE + INVALID EMAIL (not cleanable)
('Shree',    'Hotel',    '#shreevenkateshwarahotel@gmail.com','9345678901',            'JP Nagar',       'Bangalore', 'Customer',          'Active'),
('Test',     'User',     '+91-8709019511@NA.com',            '8456789012',             'Goregaon',       'Mumbai',    'Prospect',          'Blocked'),
('Dummy',    'Entry',    '000@gmail.com',                    '7567890123',             'Ameerpet',       'Hyderabad', 'RR Projects',       'Active'),
('Short',    'Email',    'y@x.in',                           '9678901234',             'Adyar',          'Chennai',   'Prospect',          'Active'),
('Temp',     'Mail',     'zuslpit@tmpnator.live',            '8789012345',             'Hadapsar',       'Pune',      'Corp Comm Prospect','Active'),
('Junk',     'Mail',     'junkuser@mailinator.com',          '9890123456',             'Electronic City','Bangalore', 'Prospect',          'Active'),
('No',       'Email',    NULL,                               '7890123457',             'Santacruz',      'Mumbai',    'RR Projects',       'Obsolete'),
 
-- ❌ INVALID MOBILE — various cases
('Basanta',  'Roy',      'basanta.roy@gmail.com',            '6.27E+09',               'Salt Lake',      'Kolkata',   'Customer',          'Active'),
('Subhani',  'SK',       'subhani.sk@gmail.com',             '353',                    'Kukatpally',     'Hyderabad', 'Prospect',          'Active'),
('Nuli',     'Mani',     'nuli.mani@gmail.com',              '44',                     'Mylapore',       'Chennai',   'Customer',          'Active'),
('Abdulkad', 'Ahmed',    'abdulkad@gmail.com',               '+44 447749869496',        'Shivajinagar',   'Pune',      'Corp Comm Prospect','Active'),
('Shuklat',  'Ars',      'shuklat@gmail.com',                '+41 41794604094',         'Rajajinagar',    'Bangalore', 'Prospect',          'Active'),
('Mgonga',   'Ta',       'mgongata@gmail.com',               '44 7766445765',           'Nungambakkam',   'Chennai',   'RR Projects',       'Active'),
('No',       'Mobile',   'nomobile@gmail.com',               NULL,                     'Koramangala',    'Bangalore', 'Prospect',          'Active'),
 
-- ✅ VALID — ext with SHORT extension (valid, extract base)
('James',    'Wilson',   'james.wilson@gmail.com',           '+1 770-675-3661 ext 104', 'Downtown',      'New York',  'Corp Comm Prospect','Active'),
 
-- ❌ INVALID — ext with LONG extension
('Pooja',    'Pod',      'poojapod@gmail.com',               '+1 917-483-2291 ext 7703148168','Powai',   'Mumbai',    'Customer',          'Active'),
 
-- ❌ INVALID MOBILE + INVALID EMAIL
('Kirk',     'Nkum',     'kirankum@NA.com',                  '+353 6641',              'Whitefield',     'Bangalore', 'Customer',          'Blocked'),
('DJ',       'Praveer',  'djpraveer@dummy.com',              '91',                     'Andheri',        'Mumbai',    'Prospect',          'Active'),
 
-- 🔁 DUPLICATES — same mobile only
('Priya',    'S',        'priya.sharma@gmail.com',           '9876543210',             'Koramangala',    'Bangalore', 'Prospect',          'Active'),
('Priya',    'Sharma',   'priya.s@hotmail.com',              '9876543210',             'Koramangala',    'Bangalore', 'RR Projects',       'Obsolete'),
 
-- 🔁 DUPLICATES — same mobile + email
('Rahul',    'M',        'rahul.mehta@outlook.com',          '+91 9123456789',          'Andheri',        'Mumbai',    'Prospect',          'Active'),
('Rahul',    'Mehta',    'rahul.mehta@outlook.com',          '+91 9123456789',          'Andheri',        'Mumbai',    'Corp Comm Prospect','Obsolete'),
 
-- 🔁 DUPLICATE — same mobile different email
('Anita',    'R',        'anita.r@gmail.com',                '+91 8765432109',          'Banjara Hills',  'Hyderabad', 'Prospect',          'Active'),
 
-- ✅ VALID — cleanable special char email
('Venkat',   'Swara',    '_venkat.swara@gmail.com',          '9456789013',             'Begumpet',       'Hyderabad', 'Customer',          'Active'),
('Darshan',  'Patel',    '.darshan.patel@gmail.com',         '8567890124',             'Satellite',      'Ahmedabad', 'Prospect',          'Active'),
('Rajan',    'Krishnan', '-rajan.krishnan@gmail.com',        '7678901235',             'Adyar',          'Chennai',   'Customer',          'Active'),
 
-- ✅ VALID — Qatar + UK
('Ahmed',    'Al Sayed', 'ahmed.alsayed@gmail.com',          '+974 55512345',           'West Bay',       'Doha',      'Customer',          'Active'),
('Sarah',    'Connor',   'sarah.connor@outlook.com',         '+44 7911123456',          'London',         'London',    'Customer',          'Active'),
 
-- ❌ OBSOLETE / BLOCKED
('Old',      'Record',   'old.record@gmail.com',             '9789012346',             'Old City',       'Hyderabad', 'Prospect',          'Obsolete'),
('Blocked',  'User',     'blocked.user@gmail.com',           '8890123457',             'Dharavi',        'Mumbai',    'RR Projects',       'Blocked');

 select * from customers_c4c;
 
 -- now i want to clean mobile number column and add it as new field
 ALTER TABLE customers_c4c add column mobile_cleaned varchar(50) after mobile;
 
 DESCRIBE customers_c4c;
 
 -- mobile cleaned
-- Step 1: SHORT ext (≤5 digits) → keep base number only BEFORE stripping
UPDATE customers_c4c
SET mobile_cleaned = TRIM(SUBSTRING_INDEX(mobile, 'ext', 1))
WHERE mobile LIKE '%ext%'
  AND LENGTH(TRIM(SUBSTRING_INDEX(mobile, 'ext', -1))) <= 5;

-- Step 2: LONG ext (6+ digits) → mark Invalid directly
UPDATE customers_c4c
SET mobile_cleaned = 'Invalid'
WHERE mobile LIKE '%ext%'
  AND LENGTH(TRIM(SUBSTRING_INDEX(mobile, 'ext', -1))) > 5;

-- Step 3: Now clean everything else (non-ext records)
UPDATE customers_c4c
SET mobile_cleaned = REGEXP_REPLACE(mobile, '[^0-9+]', '')
WHERE mobile_cleaned IS NULL;

-- Step 4: Add +91 to valid Indian numbers
UPDATE customers_c4c
SET mobile_cleaned = CONCAT('+91', mobile_cleaned)
WHERE mobile_cleaned REGEXP '^[6-9][0-9]{9}$';

DROP TABLE IF EXISTS country_codes;

SELECT
    customer_id,
    first_name,
    mobile,
    mobile_cleaned
FROM customers_c4c;

-- create country_codes
Create Table country_codes(
country_name VARCHAR(50),
country_code VARCHAR(10),
code_digits INT,
mobile_length INT
);

INSERT INTO country_codes VALUES
('India',       '+91',  2, 10),
('USA',         '+1',   1, 10),
('UK',          '+44',  2, 10),
('Qatar',       '+974', 3,  8),
('Switzerland', '+41',  2,  9),
('Ireland',     '+353', 3,  9),
('UAE',         '+971', 3,  9),
('Singapore',   '+65',  2,  8),
('Australia',   '+61',  2,  9),
('Saudi Arabia','+966', 3,  9);

Select * from country_codes;

ALTER TABLE customers_C4C ADD column mobile_status varchar(50);

UPDATE customers_c4c c
LEFT JOIN country_codes cc
  ON c.mobile_cleaned LIKE CONCAT(cc.country_code, '%')
SET mobile_status =
  CASE
    -- Already marked Invalid from ext logic
    WHEN c.mobile_cleaned = 'Invalid'         THEN 'Invalid'
    -- NULL mobile
    WHEN c.mobile IS NULL                     THEN 'Invalid'
    -- Scientific notation
    WHEN c.mobile LIKE '%E+%'                 THEN 'Invalid'
    -- Matched a country code and length is correct
    WHEN LENGTH(REGEXP_REPLACE(c.mobile_cleaned, '[^0-9]', ''))
         - cc.code_digits = cc.mobile_length  THEN 'Valid'
    -- Matched country code but length is wrong (e.g. doubled code)
    WHEN cc.country_code IS NOT NULL          THEN 'Invalid'
    -- No country code match at all
    ELSE 'Invalid'
  END;

ALTER TABLE customers_c4c
ADD COLUMN email_cleaned VARCHAR(150) AFTER email,
ADD COLUMN email_status VARCHAR(20) AFTER email_cleaned;

-- Email cleaning
UPDATE customers_c4c
SET email_cleaned = LOWER(email);

UPDATE customers_c4c
SET email_cleaned = REGEXP_REPLACE(email_cleaned, '^[#_\\-\\.]+', '')
WHERE email_cleaned REGEXP '^[#_\\-\\.]';

select*from customers_c4c;

UPDATE customers_c4c
SET email_cleaned =
  CASE
    WHEN email_cleaned LIKE '%@gmel.com'    THEN REPLACE(email_cleaned, '@gmel.com',    '@gmail.com')
    WHEN email_cleaned LIKE '%@gmial.com'   THEN REPLACE(email_cleaned, '@gmial.com',   '@gmail.com')
    WHEN email_cleaned LIKE '%@gmaill.com'  THEN REPLACE(email_cleaned, '@gmaill.com',  '@gmail.com')
    WHEN email_cleaned LIKE '%@gamil.com'   THEN REPLACE(email_cleaned, '@gamil.com',   '@gmail.com')
    WHEN email_cleaned LIKE '%@yaho.com'    THEN REPLACE(email_cleaned, '@yaho.com',    '@yahoo.com')
    WHEN email_cleaned LIKE '%@yahooo.com'  THEN REPLACE(email_cleaned, '@yahooo.com',  '@yahoo.com')
    WHEN email_cleaned LIKE '%@yahho.com'   THEN REPLACE(email_cleaned, '@yahho.com',   '@yahoo.com')
    WHEN email_cleaned LIKE '%@outllok.com' THEN REPLACE(email_cleaned, '@outllok.com', '@outlook.com')
    WHEN email_cleaned LIKE '%@outlok.com'  THEN REPLACE(email_cleaned, '@outlok.com',  '@outlook.com')
    WHEN email_cleaned LIKE '%@otlook.com'  THEN REPLACE(email_cleaned, '@otlook.com',  '@outlook.com')
    WHEN email_cleaned LIKE '%@maeil.com'   THEN REPLACE(email_cleaned, '@maeil.com',   '@mail.com')
    WHEN email_cleaned LIKE '%@rediff.com'  THEN REPLACE(email_cleaned, '@rediff.com',  '@rediffmail.com')
    ELSE email_cleaned
  END;

-- Email  Standard validation i,e Status update

UPDATE customers_c4c
SET email_status =
  CASE
    WHEN email IS NULL THEN 'Invalid'
    WHEN email_cleaned REGEXP '^[a-z0-9._%+\\-]+@[a-z0-9.\\-]+\\.[a-z]{2,}$'
      THEN 'Valid'
    ELSE 'Invalid'
  END;

-- Diposable mails to Invalid
UPDATE customers_c4c
SET email_status = 'Invalid'
WHERE email_cleaned REGEXP '@(mailinator\\.com|tmpnator\\.live|yopmail\\.com|guerrillamail\\.com|trashmail\\.com|tempmail\\.com)$';

-- Finding suspicious mail for Review
UPDATE customers_c4c
SET email_status = 'Invalid'
WHERE email_cleaned REGEXP '@(na\\.com|dummy\\.com|test\\.com|noemail\\.com|xyz\\.com|abc\\.com)$';

-- if phone number sbefore @ then invalid
UPDATE customers_c4c
SET email_status = 'Invalid'
WHERE email_cleaned REGEXP '^[+]?[0-9\\-]+@';

-- only numberic part before @
UPDATE customers_c4c
SET email_status = 'Invalid'
WHERE email_cleaned REGEXP '^[0-9]+@';

ALTER TABLE customers_C4C add column record_status varchar(50);

UPDATE customers_c4c
SET record_status =
  CASE
    WHEN mobile_status = 'Valid' AND email_status = 'Valid'
      THEN 'Valid'
	When mobile_status = 'Valid' AND email_status = 'Invalid'
	  THEN 'Valid'
    ELSE 'Invalid'
  END;

SELECT
    customer_id,
    email,
    email_cleaned,
    email_status,
    mobile_status,
    record_status
FROM customers_c4c;


SELECT
  mobile_status,
  email_status,
  record_status,
  COUNT(*) AS total
FROM customers_c4c
GROUP BY mobile_status, email_status, record_status
ORDER BY record_status;