


create table tblstandard_ashwin
(intID int primary key identity(1,1), 
 strName varchar(50));

 select * from tblstandard_ashwin;



 create table tblStudent_ashwin
 ( intId int primary key identity(1,1),
   strFirstName varchar(50), strMiddleName varchar(50),
   strLastName varchar(50), intRollNo int, intStandardId int,
   dtebirthdate date, bitStatus bit, strRemarks varchar(500),
   dteCreatedDate date, dteUpdatedDate date, 
   Id int foreign key references tblStandard_ashwin(intId));

   drop table tblStudent_ashwin;

   select * from tblStudent_ashwin;

   insert into tblstandard_ashwin (strName) values ('Sneha');
   insert into tblstandard_ashwin values ( 'Traun');
   insert into tblstandard_ashwin values ( 'Ankit');
   insert into tblstandard_ashwin values ( 'Varun');
   insert into tblstandard_ashwin values ( 'Nancy');
   insert into tblstandard_ashwin values ( 'Aniket');
   insert into tblstandard_ashwin values ( 'Aditya');
   insert into tblstandard_ashwin values ( 'Aboli');
   insert into tblstandard_ashwin values ( 'Suresh');
   insert into tblstandard_ashwin values ( 'Neha');

    select * from tblstandard_ashwin;


insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Sneha', 'Suresh', 'Mehta', 01, 1, '1998-01-11', 0, 'TRUE', '2016-05-12', 1);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Aditya', 'Ganesh', 'Ghate', 02, 2, '1998-02-12', 1, 'PASS', '2016-07-12',  2);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Aniket', 'Dilip', 'Pihulkar', 03, 3, '1998-03-12', 0, 'FAIL', '2016-05-12',  3);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Sneha', 'Ganesh', 'Satrote', 04, 4, '1998-08-12', 0, 'PASS', '2019-09-12',  4);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Pankaj', 'Dilip', 'Deshmukh', 05, 5, '1997-04-05', 1, 'PASS', '2015-07-18',  5);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Aashu', 'Ravindra', 'Bahad', 06, 6, '1996-07-24', 0, 'FAIL', '2014-10-22',  6);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Radhika', 'Ganesh', 'Harsule', 07, 7, '1995-12-21', 1, 'PASS', '2014-12-23',  7);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Aboli', 'Suresh', 'Ghinmine', 08, 8, '1996-11-22', 0, 'PASS', '2013-12-21',  8);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Pooja', 'Amit', 'Satote', 09, 9, '1998-04-12', 1, 'FAIL', '2015-11-08',  9);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Neha', 'Anup', 'Gorde', 10, 10, '1997-06-13', 0, 'FAIL', '2014-12-08',  10);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Mohini', 'Aatmaram', 'Bhide', 11, 11, '1998-12-20', 0, 'PASS', '2015-11-10',  1);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Ajay', 'Prabhakar', 'Satote', 12, 12, '1997-11-22', 1, 'PASS', '2015-12-08',  2);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Dipak', 'Ajay', 'Mahore', 13, 12, '1995-08-17', 0, 'FAIL', '2012-09-10',  3);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Payal', 'Aditya', 'Tripathi', 14, 10, '1996-10-12', 0, 'PASS', '2014-10-22',  4);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Divya', 'Kartik', 'Khandare', 15, 08, '1996-12-22', 0, 'FAIL', '2015-10-23',  5);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Divya', 'Kartik', 'Khandare', 16, 10, '1997-10-25', 1, 'PASS', '2014-10-12',  6);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Ankit', 'Kumar', 'Sharma', 17, 11, '1996-12-22', 0, 'FAIL', '2016-10-23',  7);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName, intRollNo, intStandardId, dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Shilpa', 'Ankit', 'Hazare', 18, 10, '1996-12-23', 1, 'PASS', '2015-12-23',  8);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Rohan', 'Kartik', 'Satote', 19, 08, '1997-12-23', 0, 'FAIL', '2014-10-23',  5);

insert into tblStudent_ashwin (strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate ) values ( 'Rama', 'Arjun', 'Deshmukh', 20, 10, '1996-10-20', 0, 'PASS', '2015-09-08',  6);




update tblstandard_ashwin set strName = 'Ashwin' where intID = 1;
update tblstandard_ashwin set strName = 'Pooja' where intID = 2;
update tblstandard_ashwin set strName = 'Anup' where intID = 3;


select * from tblstandard_ashwin;

update tblStudent_ashwin set strFirstName = 'Anup', strMiddleName = 'Arun' where intId=4;
update tblStudent_ashwin set strRemarks = 'PASS', bitStatus = '1' where intId=1006;


select * from tblStudent_ashwin;

delete from tblstandard_ashwin where intID='3';
delete from tblstandard_ashwin where strName='Nancy';

delete from tblStudent_ashwin;

ALTER table tblStudent_ashwin  DROP column dteUpdatedDate;  

Alter table tblStudent_ashwin add dteUpdatedDate date;

update tblStudent_ashwin set dteUpdatedDate = GETDATE() where Id=1;

update tblStudent_ashwin set dteUpdatedDate = GETDATE() where Id=5;


update tblStudent_ashwin set dteUpdatedDate = GETDATE() where Id=7;


update tblStudent_ashwin set dteUpdatedDate = GETDATE() where Id=2;

select * from tblStudent_ashwin;


delete from tblStudent_ashwin where intId = '1003';
delete from tblStudent_ashwin where intId = '1006';

delete from tblStudent_ashwin where intId = '1008';









update tblstandard_ashwin set strName = 'Ashwin' where intID = 1;


update tblstandard_ashwin set strName = 'Prajyot' where intID = 5;


select strFirstName, strMiddleName, strLastName,intRollNo, intStandardId,dtebirthdate, bitStatus, strRemarks,
   dteCreatedDate, dteUpdatedDate from tblStudent_ashwin;


   ###SQL task 3###
3.1) Please insert 3 colums Maths, English, Science as int in Student table
3.2)
Select record of student
Sr. No., Full Name (First name + middle name + lastname), BirthDate (dd/MM/yyyy), Status (If 1 then show Yes, If 0 then show No), Maths, English, Science, Total, Percentage (ex. 65.32%)

update  tblStudent_ashwin set Maths= '45', English = '90' , Science = '50' where intRollNo = 2;



select concat(strFirstName,' ' , strMiddleName,' ' , strLastName) as dteBirthDate,  CASE WHEN bitStatus = 1 
THEN 'Yes' ELSE 'No' END AS bitStatus, (Maths + English + Science) as Total,
format(Round((Maths + English +Science ) / 3.0, 2),'N2' )+'%' as averageMarks from tblStudent_ashwin;






alter table tblStudent_ashwin add Maths int, English int, Science int;

select * from tblStudent_ashwin;


create procedure spSQLTASK1
AS
BEGIN
select * from tblStudent_ashwin;
END

create procedure spSQLTASK1
AS
BEGIN
 @new_strFirstName varchar(50), @strMiddleName varchar(50), @strLastName varchar(50),
@intRollNo int, @intStandardId int, @dtebirthdate date, @bitStatus bit,
@strRemarks varchar(500), @dteCreatedDate date, @UpdatedDate date, @Maths int, @English int,
@Science int
AS
BEGIN 
insert into tblStudent_ashwin ( intId  , strFirstName , @strMiddleName, @strLastName ,
intRollNo, intStandardId , dtebirthdate , bitStatus,
strRemarks , dteCreatedDate, UpdatedDate, Maths , English, Science) values  ( 07, 'Amit', 'Suresh', 'Deshmukh', 07,7, '1998-11-09', 0 , 'PASS', '2012-05-06', 'getdata()', 45, 60, 70 )
END;



@new_strFirstName varchar(50), @strMiddleName varchar(50), @strLastName varchar(50),
@intRollNo int, @intStandardId int, @dtebirthdate date, @bitStatus bit,
@strRemarks varchar(500), @dteCreatedDate date, @UpdatedDate date, @Maths int, @English int,


alter PROCEDURE SqlTasks(
  @Id int, @FirstName varchar(50)null='', @MiddleName varchar(50), @LastName varchar(50),
@RollNo int, @StandardId int, @birthdate date, @Status bit,
@Remarks varchar(500), @CreatedDate date, @UpdatedDate date, @Maths int, @English int,
@Science int,@operation varchar(50)
)
AS
BEGIN
--1012 ,'Sneha','Ranjat', 'Sahare', 23, 10, '2022-09-22', '0', 'PASS', '2012-10-23', GETDATE(), 35, 40, 70,'Insert'; 
    IF @operation = 'Insert' 
    BEGIN
        INSERT INTO tblStudents_ashwin (strFirstName, strMiddleName , strLastName ,
intRollNo , intStandardId , dtebirthdate , bitStatus,
strRemarks , dteCreatedDate , dteUpdatedDate , Maths , English ,
Science, operation)  
        VALUES (@FirstName , @MiddleName , @LastName ,
@RollNo , @StandardId , @birthdate , @Status ,
@Remarks, @CreatedDate , @UpdatedDate , @Maths , @English,
@Science, @operation);
    END
    ELSE IF @operation = 'Update'
    BEGIN
        UPDATE tblStudents_ashwin
        SET FirstName = 'Ashwin' 
        WHERE Id = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        DELETE FROM tblStudents_ashwin WHERE Id = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM tblStudents_ashwin WHERE Id = @Id;
    END
END







SELECT * FROM tblStudent_ashwin WHERE strFirstName LIKE 'a%o'


SELECT * FROM tblStudent_ashwin
WHERE dteCreatedDate BETWEEN '2023-08-01' AND '2023-08-08';
	




SELECT * FROM tblStudent_ashwin
WHERE (Maths + English + Science) >= 150;




SELECT TOP 3 * FROM tblStudent_ashwin
ORDER BY dteCreatedDate DESC;



alter table tblStudent_ashwin add Age int;


SELECT *
FROM tblStudent_ashwin
WHERE Age BETWEEN 20 AND 30;




alter table tblStudent_ashwin add Sr_no int;

update 


select * from tblStudent_ashwin;