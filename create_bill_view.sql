CREATE OR REPLACE VIEW `hcm`.`bill_view` AS 
SELECT `name_ray`,`Date_ray`,`ray`.`Ray_Price`  
	FROM `hcm`.`patient_has_ray`
INNER JOIN `hcm`.`ray` 
	ON `name_ray` = `Ray_Name`
where `rayPatient_ID` =3 
UNION  
SELECT `name_test`,`Date_test`,`test`.`Test_Price` 
	FROM `patient_has_test`
INNER JOIN `test` 
	ON `Test_Name` = `name_test`
where `testPatientID` = 3 