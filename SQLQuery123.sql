
Alter table MVC (intid int primary key identity(1,1), strfirst_name varchar(30), 
strlast_name varchar(30), dtedob varchar(30), strhobbies varchar(30),
strgender varchar(30), strstates varchar(30), strcity varchar(30), uploadimage varchar(30), uploadpdf varchar(30), StateID int,
CityID int,FOREIGN KEY (StateID) REFERENCES States1(StateId),
    FOREIGN KEY (CityID) REFERENCES Cities1(CityId))

	ALTER TABLE MVC
DROP CONSTRAINT FK_States_MVC;
	
	ALTER TABLE MVC
 ADD StateId INT,
    CityId INT,
    FOREIGN KEY (StateId) REFERENCES States1(StateId),
    FOREIGN KEY (CityId) REFERENCES Cities1(CityId);


	ALTER TABLE States
DROP CONSTRAINT FK_States_Cities;

alter table MVC drop column StateID ,CityID

select * from MVC_History

ALTER TABLE MVC_History ADD StateId INT, -- Foreign key to States table
    CityId INT

	ALTER TABLE MVC_History drop column StateID , -- Foreign key to States table
    CityID 

	drop table Cities
	drop table States

ALTER TABLE MVC
ADD StateId INT, -- Foreign key to States table
    CityId INT,  -- Foreign key to Cities table
    FOREIGN KEY (StateID) REFERENCES States1(StateId),
    FOREIGN KEY (CityID) REFERENCES Cities1(CityID);

	ALTER TABLE States
DROP CONSTRAINT FK_States_States;
 FOREIGN KEY (StateId) REFERENCES States1(StateId)
ALTER TABLE Cities DROP CONSTRAINT FK_Cities_StateID;

ALTER TABLE MVC
DROP CONSTRAINT FK__MVC__CityID__3648A49D;

select * from Hobbies1

select * from MVC

alter table MVC add uploadimage varchar(30), uploadpdf varchar(30);



ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(max) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
    @operation VARCHAR(30) = NULL
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN

	

         IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

		  INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);

			Declare 
			@EmployeeId int
			set
			@EmployeeId=SCOPE_IDENTITY();
 
    CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

 
    INSERT INTO #TempHobbies (HobbyName)
    SELECT Value
    FROM dbo.SplitString_Ashwin(@Hobbies, ',');

   
    INSERT INTO UserHobbies ( EmployeeHobbyId, HobbyId)
    SELECT @EmployeeId, H.Hid
    FROM Hobbies1 H
    WHERE EXISTS (
        SELECT 1
        FROM #TempHobbies T
    WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
    );


    DROP TABLE #TempHobbies;
END
      
    ELSE IF @operation = 'Update'
    BEGIN
	 IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

	
        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
            strgender = @Gender,
            strstates = @States,
            strcity = @City,
            uploadimage = @UploadImage,
            uploadpdf = @UploadPdf
			 WHERE intid = @Id;

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
        SELECT 
             strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
            'Updated', GETDATE()
        FROM MVC	
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        
        IF EXISTS (SELECT 1 FROM UserHobbies WHERE EmployeeHobbyId = @Id)
        BEGIN
     
            DELETE FROM UserHobbies WHERE EmployeeHobbyId = @Id;
        END

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
SELECT 
     strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
    'Deleted', GETDATE()
FROM MVC
WHERE intid = @Id;

  
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        SELECT * FROM MVC WHERE intid = @Id;

       
    END

	ELSE IF @operation = 'ValidateUser'
    BEGIN
        
        SELECT * FROM MVC WHERE strfirst_name = @First_name AND strlast_name = @Last_name AND dtedob = TRY_CAST(@Date_of_birth AS DATE);
    END
END




select * from MVC

delete from MVC where intid=8193; 

delete from UserHobbies where UserHobbyId=1090;

select * from Hobbies1

select * from UserHobbies

delete from UserHobbies where UserHobbyId = 3260;




alter PROCEDURE SearchItems
    @searchTerm NVARCHAR(50)
AS
BEGIN
    SELECT intid, strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity
    FROM MVC
    WHERE strfirst_name  LIKE '%' + @searchTerm + '%'
END











ALTER PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT,
    @searchData VARCHAR(30)=null
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StartRow INT, @EndRow INT;

    SET @StartRow = (@PageNumber - 1) * @PageSize + 1;
    SET @EndRow = @PageNumber * @PageSize;

    WITH PagedData AS (
        SELECT
            *,
            ROW_NUMBER() OVER (ORDER BY intid) AS RowNum
        FROM
            MVC
        WHERE
            (
                @searchData IS NULL
                OR strfirst_name LIKE '%' + @searchData + '%'
                OR strlast_name LIKE '%' + @searchData + '%'
                OR CONVERT(NVARCHAR, dtedob, 120) LIKE '%' + @searchData + '%'
            )
    )
    
    SELECT * FROM PagedData WHERE RowNum BETWEEN @StartRow AND @EndRow;
END





create table Hobbies1(Hid int primary key identity(1,1), Hobbiesname varchar(30));
drop table Hobbies;
select * from Hobbies1;

SET IDENTITY_INSERT Hobbies ON;


insert into Hobbies1 values( 'Travelling');
insert into Hobbies1 values( 'Cooking');
insert into Hobbies1 values( 'Reading');
insert into Hobbies1 values( 'Playing');
insert into Hobbies1 values( 'Net Surfing');

SET IDENTITY_INSERT Hobbies ON;


drop table UserHobbies;
Create TABLE UserHobbies
(
    UserHobbyId INT PRIMARY KEY IDENTITY(1, 1),
    EmployeeHobbyId INT, 
    HobbyId INT,         
    FOREIGN KEY (EmployeeHobbyId) REFERENCES MVC (intid),
    FOREIGN KEY (HobbyId) REFERENCES Hobbies1 (Hid)
);

Select * from UserHobbies

Select * from Hobbies;

Select * from MVC




INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
VALUES (@Id, @HobbyID);

INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
VALUES (@EmployeeID, @HobbyID);

DECLARE @EmployeeID INT;

ALTER TABLE MVC
DROP COLUMN Hid;



delete from UserHobbies where UserHobbyId = 3387;
delete from MVC where intid = 8274;

select * from MVC;

select * from UserHobbies


drop table MVC_History


CREATE TABLE MVC_History (
    intid INT PRIMARY KEY identity(1,1),
    strfirst_name VARCHAR(30),
    strlast_name VARCHAR(30),
    dtedob VARCHAR(30),
    strhobbies VARCHAR(30),
    strgender VARCHAR(30),
    strstates VARCHAR(30),
    strcity VARCHAR(30),
    uploadimage VARCHAR(30),
    uploadpdf VARCHAR(30),
    action_type VARCHAR(10),  
    action_date DATETIME
);


ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(max) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
    @operation VARCHAR(30) = NULL
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN

	

         IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

		  INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);

			Declare 
			@EmployeeId int
			set
			@EmployeeId=SCOPE_IDENTITY();

 
    CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

 
    INSERT INTO #TempHobbies (HobbyName)
    SELECT Value
    FROM dbo.SplitString_Ashwin(@Hobbies, ',');

   
    INSERT INTO UserHobbies ( EmployeeHobbyId, HobbyId)
    SELECT @EmployeeId, H.Hid
    FROM Hobbies1 H
    WHERE EXISTS (
        SELECT 1
        FROM #TempHobbies T
    WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
    );


    DROP TABLE #TempHobbies;
END
      
    ELSE IF @operation = 'Update'
    BEGIN
	 IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

	
        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
            strgender = @Gender,
            strstates = @States,
            strcity = @City,
            uploadimage = @UploadImage,
            uploadpdf = @UploadPdf
			 WHERE intid = @Id;

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
        SELECT 
             strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
            'Updated', GETDATE()
        FROM MVC	
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        
        IF EXISTS (SELECT 1 FROM UserHobbies WHERE EmployeeHobbyId = @Id)
        BEGIN
     
            DELETE FROM UserHobbies WHERE EmployeeHobbyId = @Id;
        END

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
SELECT 
     strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
    'Deleted', GETDATE()
FROM MVC
WHERE intid = @Id;

  
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        SELECT * FROM MVC WHERE intid = @Id;

       
    END

	ELSE IF @operation = 'ValidateUser'
    BEGIN
        
        SELECT * FROM MVC WHERE strfirst_name = @First_name AND strlast_name = @Last_name AND dtedob = TRY_CAST(@Date_of_birth AS DATE);
    END
END













select * from MVC_History

drop trigger tr_MVCAudit
select * from MVCAudit

-- Create an audit table to store changes
CREATE TABLE MVCAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Operation VARCHAR(10), -- Operation type (INSERT, UPDATE, DELETE)
    RecordID INT, -- The ID of the modified record
    Timestamp DATETIME DEFAULT GETDATE() -- Timestamp of the change
);

-- Create an AFTER INSERT, UPDATE, DELETE trigger
CREATE TRIGGER tr_MVCAudit
ON MVC
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Insert audit records for INSERT operations
    INSERT INTO MVCAudit (Operation, RecordID)
    SELECT 'INSERT', intid
    FROM inserted;

    -- Insert audit records for UPDATE operations
    INSERT INTO MVCAudit (Operation, RecordID)
    SELECT 'UPDATE', intid
    FROM updated;

    -- Insert audit records for DELETE operations
    INSERT INTO MVCAudit (Operation, RecordID)
    SELECT 'DELETE', intid
    FROM deleted;
END;





ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(max) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
    @operation VARCHAR(30) = NULL,
    @TotalRecords INT OUTPUT -- Add an output parameter for total records
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN
        IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

        INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
        VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);

        -- Calculate the total records count
        SELECT @TotalRecords = COUNT(*) FROM MVC;

        Declare @EmployeeId int;
        set @EmployeeId = SCOPE_IDENTITY();

        CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

        INSERT INTO #TempHobbies (HobbyName)
        SELECT Value
        FROM dbo.SplitString_Ashwin(@Hobbies, ',');

        INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
        SELECT @EmployeeId, H.Hid
        FROM Hobbies1 H
        WHERE EXISTS (
            SELECT 1
            FROM #TempHobbies T
            WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
        );

        DROP TABLE #TempHobbies;
    END

    -- Rest of your code

    -- Return the updated total records count
    SELECT @TotalRecords;
END





select * from MVC_Audit;

























































































CREATE FUNCTION dbo.SplitString_Ashwin
(
    @InputString NVARCHAR(MAX),
    @Delimiter CHAR(1)
)
RETURNS @ResultTable Table (Value NVARCHAR(MAX))
AS
BEGIN
    DECLARE @StartPosition INT = 1;
    DECLARE @EndPosition INT = 1;

    WHILE @EndPosition > 0
    BEGIN
        SET @EndPosition = CHARINDEX(@Delimiter, @InputString, @StartPosition);

        IF @EndPosition > 0
        BEGIN
            INSERT INTO @ResultTable (Value)
            VALUES (SUBSTRING(@InputString, @StartPosition, @EndPosition - @StartPosition));
            SET @StartPosition = @EndPosition + 1;
        END
        ELSE
        BEGIN
            INSERT INTO @ResultTable (Value)
            VALUES (SUBSTRING(@InputString, @StartPosition, LEN(@InputString) - @StartPosition + 1));
        END
    END

    RETURN;
END;























































































CREATE PROCEDURE InsertUserHobbies
    @Id INT,
    @HobbiesString NVARCHAR(MAX)
AS
BEGIN

    CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));


    INSERT INTO #TempHobbies (HobbyName)
    SELECT value
    FROM STRING_SPLIT(@HobbiesString, ',');

    INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
    SELECT @Id, H.HobbyId
    FROM Hobbies H
    WHERE EXISTS (
        SELECT 1
        FROM #TempHobbies T
        WHERE H.HobbyName = T.HobbyName
    );

    DROP TABLE #TempHobbies;
END










delete from MVC where StateId is null;





ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(30) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
    @operation VARCHAR(30) = NULL
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN


        
		  INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);

			Declare 
			@EmployeeId int
			set
			@EmployeeId=SCOPE_IDENTITY();
 
    CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

 
    INSERT INTO #TempHobbies (HobbyName)
    SELECT Value
    FROM dbo.SplitString_Ashwin(@Hobbies, ',');



   
    INSERT INTO UserHobbies ( EmployeeHobbyId, HobbyId)
    SELECT @EmployeeId, H.Hid
    FROM Hobbies1 H
    WHERE EXISTS (
        SELECT 1
        FROM #TempHobbies T
    WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
    );


    DROP TABLE #TempHobbies;
END
      
    ELSE IF @operation = 'Update'
    BEGIN
        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
            strgender = @Gender,
            strstates = @States,
            strcity = @City,
            uploadimage = @UploadImage,
            uploadpdf = @UploadPdf
			 WHERE intid = @Id;

		INSERT INTO MVC_History (intid, strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
        SELECT 
            intid, strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
            'Updated', GETDATE()
        FROM MVC	
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        
        IF EXISTS (SELECT 1 FROM UserHobbies WHERE EmployeeHobbyId = @Id)
        BEGIN
     
            DELETE FROM UserHobbies WHERE EmployeeHobbyId = @Id;
        END

		INSERT INTO MVC_History (intid, strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
SELECT 
    intid, strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
    'Deleted', GETDATE()
FROM MVC
WHERE intid = @Id;

  
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        SELECT * FROM MVC WHERE intid = @Id;

       
    END

	ELSE IF @operation = 'ValidateUser'
    BEGIN
        
        SELECT * FROM MVC WHERE strfirst_name = @First_name AND strlast_name = @Last_name AND dtedob = TRY_CAST(@Date_of_birth AS DATE);
    END
END



select * from MVC

select * from UserHobbies


delete from MVC where intid = 9217;

delete from UserHobbies where UserHobbyId= 4306;





ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(max) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
	@searchData varchar(30) = NULL,
    @operation VARCHAR(30) = NULL
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN

	

         IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

		  INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);

			Declare 
			@EmployeeId int
			set
			@EmployeeId=SCOPE_IDENTITY();
 
    CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

 
    INSERT INTO #TempHobbies (HobbyName)
    SELECT Value
    FROM dbo.SplitString_Ashwin(@Hobbies, ',');

   
    INSERT INTO UserHobbies ( EmployeeHobbyId, HobbyId)
    SELECT @EmployeeId, H.Hid
    FROM Hobbies1 H
    WHERE EXISTS (
        SELECT 1
        FROM #TempHobbies T
    WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
    );


    DROP TABLE #TempHobbies;
END
      
    ELSE IF @operation = 'Update'
    BEGIN
	 IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

	
        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
            strgender = @Gender,
            strstates = @States,
            strcity = @City,
            uploadimage = @UploadImage,
            uploadpdf = @UploadPdf
			 WHERE intid = @Id;

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
        SELECT 
             strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
            'Updated', GETDATE()
        FROM MVC	
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        
        IF EXISTS (SELECT 1 FROM UserHobbies WHERE EmployeeHobbyId = @Id)
        BEGIN
     
            DELETE FROM UserHobbies WHERE EmployeeHobbyId = @Id;
        END

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date)
SELECT 
     strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,
    'Deleted', GETDATE()
FROM MVC
WHERE intid = @Id;

  
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        SELECT * FROM MVC WHERE intid = @Id;

       
    END

	ELSE IF @operation = 'ValidateUser'
    BEGIN
        
        SELECT * FROM MVC WHERE strfirst_name = @First_name AND strlast_name = @Last_name AND dtedob = TRY_CAST(@Date_of_birth AS DATE);
		END

		ELSE IF @operation = 'GetAllUsers'
		BEGIN
		SELECT * FROM MVC WHERE 
		(
                @searchData IS NULL
                OR strfirst_name LIKE '%' + @searchData + '%'
                OR strlast_name LIKE '%' + @searchData + '%'
                OR CONVERT(NVARCHAR, dtedob, 120) LIKE '%' + @searchData + '%'
          )
    END

END



CREATE TRIGGER trg_MVC_Audit
ON MVC
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
    
        INSERT INTO MVC_Audit (Operation, OperationDate, FirstName, LastName, DateOfBirth, Hobbies, Gender, States, City, UploadImage, UploadPdf)
        SELECT 'INSERT', GETDATE(), i.strfirst_name, i.strlast_name, i.dtedob, i.strhobbies, i.strgender, i.strstates, i.strcity, i.uploadimage, i.uploadpdf
        FROM inserted i;
    END


    IF EXISTS (SELECT * FROM deleted) AND EXISTS (SELECT * FROM inserted)
    BEGIN
   
        INSERT INTO MVC_Audit (Operation, OperationDate, FirstName, LastName, DateOfBirth, Hobbies, Gender, States, City, UploadImage, UploadPdf)
        SELECT 'UPDATE', GETDATE(), i.strfirst_name, i.strlast_name, i.dtedob, i.strhobbies, i.strgender, i.strstates, i.strcity, i.uploadimage, i.uploadpdf
        FROM inserted i;
    END

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
   
        INSERT INTO MVC_Audit (Operation, OperationDate, FirstName, LastName, DateOfBirth, Hobbies, Gender, States, City, UploadImage, UploadPdf)
        SELECT 'DELETE', GETDATE(), d.strfirst_name, d.strlast_name, d.dtedob, d.strhobbies, d.strgender, d.strstates, d.strcity, d.uploadimage, d.uploadpdf
        FROM deleted d;
    END
END;




CREATE TABLE MVC_Audit (
    AuditId INT PRIMARY KEY IDENTITY(1,1),
    Operation NVARCHAR(10),
    OperationDate DATETIME,
    FirstName NVARCHAR(30),
    LastName NVARCHAR(30),
    DateOfBirth NVARCHAR(30),
    Hobbies NVARCHAR(max),
    Gender NVARCHAR(30),
    States NVARCHAR(30),
    City NVARCHAR(30),
    UploadImage NVARCHAR(30),
    UploadPdf NVARCHAR(30)
);

select * from MVC_Audit





CREATE TABLE States1 (
    StateId INT PRIMARY KEY IDENTITY(1,1),
    StateName NVARCHAR(50)
);


CREATE TABLE Cities1 (
    CityId INT PRIMARY KEY IDENTITY(1,1) not null,
    CityName NVARCHAR(50),
    StateId INT , 
    FOREIGN KEY (StateId) REFERENCES States1(StateId)
);

INSERT INTO States1(StateName) 
VALUES('Maharashtra'),('Gujarat'),('Rajasthan'),('Bihar')

INSERT INTO Cities1(StateID,CityName)
VALUES(1,'Mumbai'),(1,'Pune'),(1,'Nagpur'),
(2,'Ahmedabad'),(2,'Surat'),(2,'Palanpur'),(3,'Abu'),
(3,'Bikaner'),(3,'Ajmer'),(4,'Dehari'),(4,'Patna'),(4,'Gaya')

select * from States1
drop table Cities1

 drop table Cities;

 drop table States;



ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(max) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
	@StateId int NULL='',
	@CityId int  NULL='',
	@searchData varchar(30) = NULL,
    @operation VARCHAR(30) = NULL
	
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN

	

         IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

		  INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, StateId, CityId)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf, @StateId, @CityId);

			Declare 
			@EmployeeId int
			set
			@EmployeeId=SCOPE_IDENTITY();
 
    CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

 
    INSERT INTO #TempHobbies (HobbyName)
    SELECT Value
    FROM dbo.SplitString_Ashwin(@Hobbies, ',');

   
    INSERT INTO UserHobbies ( EmployeeHobbyId, HobbyId)
    SELECT @EmployeeId, H.Hid
    FROM Hobbies1 H
    WHERE EXISTS (
        SELECT 1
        FROM #TempHobbies T
    WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
    );


    DROP TABLE #TempHobbies;
END
      
    ELSE IF @operation = 'Update'
    BEGIN
	 IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

	
        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
            strgender = @Gender,
            strstates = @States,
            strcity = @City,
            uploadimage = @UploadImage,
            uploadpdf = @UploadPdf,
			StateId = @StateId ,
			CityId = @CityId,
			 WHERE intid = @Id;

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date, StateId, CityId)
        SELECT 
             strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf,StateId, CityId,
            'Updated', GETDATE()
        FROM MVC	
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        
        IF EXISTS (SELECT 1 FROM UserHobbies WHERE EmployeeHobbyId = @Id)
        BEGIN
     
            DELETE FROM UserHobbies WHERE EmployeeHobbyId = @Id;
        END

		INSERT INTO MVC_History ( strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date, StateId, CityId)
SELECT 
     strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, StateId, CityId,
    'Deleted', GETDATE()
FROM MVC
WHERE intid = @Id;

  
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        SELECT * FROM MVC WHERE intid = @Id;

       
    END

	ELSE IF @operation = 'ValidateUser'
    BEGIN
        
        SELECT * FROM MVC WHERE strfirst_name = @First_name AND strlast_name = @Last_name AND dtedob = TRY_CAST(@Date_of_birth AS DATE);
		END

		ELSE IF @operation = 'GetAllUsers'
		BEGIN
		SELECT * FROM MVC WHERE 
		(
                @searchData IS NULL
                OR strfirst_name LIKE '%' + @searchData + '%'
                OR strlast_name LIKE '%' + @searchData + '%'
                OR CONVERT(NVARCHAR, dtedob, 120) LIKE '%' + @searchData + '%'
          )
    END
	ELSE IF @operation = 'GetAllStates'
    BEGIN
        SELECT * FROM States1;
    END
    ELSE IF @operation = 'GetCitiesByState'
   BEGIN
    SELECT * FROM Cities1 WHERE StateId =  @StateId;
END

END


delete from Cities1 where CityId = 25

select * from Cities1

ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(30) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
    @StateId INT = NULL,
    @CityId INT = NULL,
    @searchData VARCHAR(30) = NULL,
    @operation VARCHAR(30) = NULL
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN
        IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

        INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, StateId, CityId)
        VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf, @StateId, @CityId);

        DECLARE @EmployeeId INT;
        SET @EmployeeId = SCOPE_IDENTITY();

        CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

        INSERT INTO #TempHobbies (HobbyName)
        SELECT Value
        FROM dbo.SplitString_Ashwin(@Hobbies, ',');

        INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
        SELECT @EmployeeId, H.Hid
        FROM Hobbies1 H
        WHERE EXISTS (
            SELECT 1
            FROM #TempHobbies T
            WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
        );

        DROP TABLE #TempHobbies;
    END
    ELSE IF @operation = 'Update'
    BEGIN
        IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
            strgender = @Gender,
            strstates = @States,
            strcity = @City,
            uploadimage = @UploadImage,
            uploadpdf = @UploadPdf,
            StateId = @StateId,
            CityId = @CityId
        WHERE intid = @Id;

        INSERT INTO MVC_History (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date, StateId, CityId)
        SELECT
            strfirst_name,
            strlast_name,
            dtedob,
            strhobbies,
            strgender,
            strstates,
            strcity,
            uploadimage,
            uploadpdf,
            'Updated',
            GETDATE(),
            StateId,
            CityId
        FROM MVC
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        IF EXISTS (SELECT 1 FROM UserHobbies WHERE EmployeeHobbyId = @Id)
        BEGIN
            DELETE FROM UserHobbies WHERE EmployeeHobbyId = @Id;
        END

        INSERT INTO MVC_History (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date, StateId, CityId)
        SELECT
            strfirst_name,
            strlast_name,
            dtedob,
            strhobbies,
            strgender,
            strstates,
            strcity,
            uploadimage,
            uploadpdf,
            'Deleted',
            GETDATE(),
            StateId,
            CityId
        FROM MVC
        WHERE intid = @Id;

        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        SELECT * FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'ValidateUser'
    BEGIN
        SELECT * FROM MVC WHERE strfirst_name = @First_name AND strlast_name = @Last_name AND dtedob = TRY_CAST(@Date_of_birth AS DATE);
    END
    ELSE IF @operation = 'GetAllUsers'
    BEGIN
        SELECT * FROM MVC WHERE
        (
            @searchData IS NULL
            OR strfirst_name LIKE '%' + @searchData + '%'
            OR strlast_name LIKE '%' + @searchData + '%'
            OR CONVERT(NVARCHAR, dtedob, 120) LIKE '%' + @searchData + '%'
        );
    END
    ELSE IF @operation = 'GetAllStates'
    BEGIN
        SELECT * FROM States1;
    END
    ELSE IF @operation = 'GetCitiesByState'
    BEGIN
        SELECT * FROM Cities1 
    END
END



ALTER PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT,
    @searchData VARCHAR(30) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StartRow INT, @EndRow INT;

    SET @StartRow = (@PageNumber - 1) * @PageSize + 1;
    SET @EndRow = @PageNumber * @PageSize;

    WITH PagedData AS (
        SELECT
            MVC.*,
            States1.StateName AS StateName,  -- Replace with your actual column name
            Cities1.CityName AS CityName      -- Replace with your actual column name
            ROW_NUMBER() OVER (ORDER BY intid) AS RowNum
        FROM
            MVC
        LEFT JOIN
            State ON MVC.StateId = States1.StateId  -- Adjust column names as per your schema
        LEFT JOIN
            City ON MVC.CityId = Cities1.CityId     -- Adjust column names as per your schema
        WHERE
            (
                @searchData IS NULL
                OR strfirst_name LIKE '%' + @searchData + '%'
                OR strlast_name LIKE '%' + @searchData + '%'
                OR CONVERT(NVARCHAR, dtedob, 120) LIKE '%' + @searchData + '%'
            )
    )
    
    SELECT * FROM PagedData WHERE RowNum BETWEEN @StartRow AND @EndRow;
END




select * from MVC_Audit


delete from UserHobbies where UserHobbyId=3397;


select * from UserHobbies


select * from MVC
delete from MVC where intid=8278;








ALTER PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT,
    @searchData VARCHAR(30) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StartRow INT, @EndRow INT;

    SET @StartRow = (@PageNumber - 1) * @PageSize + 1;
    SET @EndRow = @PageNumber * @PageSize;

    WITH PagedData AS (
        SELECT
            MVC.*,
            States1.StateName AS StateName,
            Cities1.CityName AS CityName,
            ROW_NUMBER() OVER (ORDER BY intid) AS RowNum
        FROM
            MVC
        LEFT JOIN
            States1 ON MVC.StateId = States1.StateId
        LEFT JOIN
            Cities1 ON MVC.CityId = Cities1.CityId
        WHERE
            (
                @searchData IS NULL
                OR strfirst_name LIKE '%' + @searchData + '%'
                OR strlast_name LIKE '%' + @searchData + '%'
                OR CONVERT(NVARCHAR, dtedob, 120) LIKE '%' + @searchData + '%'
            )
    )
    
    SELECT * FROM PagedData WHERE RowNum BETWEEN @StartRow AND @EndRow;
END



select * from UserHobbies;

select * from MVC

delete from MVC where intid = 9232;
delete from UserHobbies where UserHobbyId = 4330;




ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(30) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
    @StateId INT = NULL,
    @CityId INT = NULL,
    @searchData VARCHAR(30) = NULL,
    @operation VARCHAR(30) = NULL
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN
        IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

        -- Fetch the actual state and city names based on provided IDs
        DECLARE @StateName VARCHAR(30);
        DECLARE @CityName VARCHAR(30);

        SELECT @StateName = StateName FROM States1 WHERE StateId = @StateId;
        SELECT @CityName = CityName FROM Cities1 WHERE CityId = @CityId;

        -- Then insert into MVC table with the actual state and city names
        INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, StateId, CityId)
        VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @StateName, @CityName, @UploadImage, @UploadPdf, @StateId, @CityId);

        DECLARE @EmployeeId INT;
        SET @EmployeeId = SCOPE_IDENTITY();

        CREATE TABLE #TempHobbies (HobbyName NVARCHAR(255));

        INSERT INTO #TempHobbies (HobbyName)
        SELECT Value
        FROM dbo.SplitString_Ashwin(@Hobbies, ',');

        INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
        SELECT @EmployeeId, H.Hid
        FROM Hobbies1 H
        WHERE EXISTS (
            SELECT 1
            FROM #TempHobbies T
            WHERE H.Hobbiesname COLLATE DATABASE_DEFAULT = T.HobbyName COLLATE DATABASE_DEFAULT
        );

        DROP TABLE #TempHobbies;
    END
	ELSE IF @operation = 'Update'
    BEGIN
        IF @UploadImage IS NULL
            SET @UploadImage = '';
        IF @UploadPdf IS NULL
            SET @UploadPdf = '';

        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
            strgender = @Gender,
            strstates = @States,
            strcity = @City,
            uploadimage = @UploadImage,
            uploadpdf = @UploadPdf,
            StateId = @StateId,
            CityId = @CityId
        WHERE intid = @Id;

        INSERT INTO MVC_History (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date, StateId, CityId)
        SELECT
            strfirst_name,
            strlast_name,
            dtedob,
            strhobbies,
            strgender,
            strstates,
            strcity,
            uploadimage,
            uploadpdf,
            'Updated',
            GETDATE(),
            StateId,
            CityId
        FROM MVC
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        IF EXISTS (SELECT 1 FROM UserHobbies WHERE EmployeeHobbyId = @Id)
        BEGIN
            DELETE FROM UserHobbies WHERE EmployeeHobbyId = @Id;
        END

        INSERT INTO MVC_History (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf, action_type, action_date, StateId, CityId)
        SELECT
            strfirst_name,
            strlast_name,
            dtedob,
            strhobbies,
            strgender,
            strstates,
            strcity,
            uploadimage,
            uploadpdf,
            'Deleted',
            GETDATE(),
            StateId,
            CityId
        FROM MVC
        WHERE intid = @Id;

        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        SELECT * FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'ValidateUser'
    BEGIN
        SELECT * FROM MVC WHERE strfirst_name = @First_name AND strlast_name = @Last_name AND dtedob = TRY_CAST(@Date_of_birth AS DATE);
    END
    ELSE IF @operation = 'GetAllUsers'
    BEGIN
        SELECT * FROM MVC WHERE
        (
            @searchData IS NULL
            OR strfirst_name LIKE '%' + @searchData + '%'
            OR strlast_name LIKE '%' + @searchData + '%'
            OR CONVERT(NVARCHAR, dtedob, 120) LIKE '%' + @searchData + '%'
        );
    END
    ELSE IF @operation = 'GetAllStates'
    BEGIN
        SELECT * FROM States1;
    END
    ELSE IF @operation = 'GetCitiesByState'
    BEGIN
        SELECT * FROM Cities1 
    END
    -- Rest of your operations...
END



delete from UserHobbies where UserHobbyId = 4356;

select * from UserHobbies;

delete from MVC where intid = 9257;


select * from MVC_Audit;