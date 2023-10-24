
select * from MVC;

drop table MVC;
--------------------------------------------------Stored Procedure-----------------------------------------------------
alter PROCEDURE sp_MVC1
    @Id int= null,
    @First_name varchar(30)=null,
    @Last_name varchar(30)=null,
    @Date_of_birth varchar(30)=null,
    @Hobbies varchar(30)=null,
	@Gender varchar (30)=null,
    @States varchar(30)=null,
    @City varchar(30)=null,
	@UploadImage varchar(30)=null,
	@UploadPdf varchar(30)=null,
    @operation varchar(30)=null
AS
BEGIN
    IF @operation = 'Insert' 
    BEGIN
        INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
        VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage,@UploadPdf);
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
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC 
    END
	ELSE IF @operation ='GetById'
	BEGIN
	  select * from MVC where intid = @Id
END
END

Create table MVC (intid int primary key identity(1,1), strfirst_name varchar(30), 
strlast_name varchar(30), dtedob varchar(30), strhobbies varchar(30),
strgender varchar(30), strstates varchar(30), strcity varchar(30), uploadimage varchar(30), uploadpdf varchar(30))
--------------------------------------------------------------------------------------------------------------------------
 drop table MVC;

 select * from MVC;
 SET IDENTITY_INSERT MVC ON;

 -----------------------------------------SP for pagination---------------------------------------------------------------

 alter PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT,
	@searchData varchar(30)=null
	
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
        
    )

    
    SELECT * FROM PagedData WHERE RowNum BETWEEN @StartRow AND @EndRow;
END

------------------------------------------SP for search--------------------------------------------------------
alter PROCEDURE SearchItems
    @searchTerm NVARCHAR(50)
AS
BEGIN
    SELECT intid, strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity
    FROM MVC
    WHERE strfirst_name  LIKE '%' + @searchTerm + '%'
END

---------------------------------------------------------------------------------------------------------------
delete from MVC where 
intid = 5060;
select * from MVC;
---------------------------------------------------------------------------------------------------------------
CREATE TABLE States (
    StateID INT PRIMARY KEY,
    StateName NVARCHAR(50)
);

CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName NVARCHAR(50),
    StateID INT FOREIGN KEY REFERENCES States(StateID)
);


CREATE PROCEDURE GetStatesAndCities
AS
BEGIN
    SELECT StateID, StateName FROM States;
    SELECT CityID, CityName, StateID FROM Cities;
END;

----------------------------------------------------------------------------------------------------------------
CREATE TABLE Images
(
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    ImageData VARBINARY(MAX),
    ImageMimeType NVARCHAR(50)
)
---------------------------------------------------------------------------------------------------------------------------
select * from Images;

alter table MVC add uploadimage varchar(30), uploadpdf varchar(30);





alter table MVC drop column uploadimage, uploadpdf;

delete from MVC;


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

        IF NOT EXISTS (
            SELECT 1
            FROM MVC
            WHERE strfirst_name = @First_name
              AND strlast_name = @Last_name
              AND dtedob = @Date_of_birth
              AND strhobbies = @Hobbies
              AND strgender = @Gender
              AND strstates = @States
              AND strcity = @City
              AND uploadimage = @UploadImage
              AND uploadpdf = @UploadPdf
        )
        BEGIN
     
            INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);
        END
        ELSE
        BEGIN
           
            RAISEERROR('Duplicate record detected. Insertion aborted.');
        END
    END
 
END



alter PROCEDURE sp_MVC1
    @Id int= null,
    @First_name varchar(30)=null,
    @Last_name varchar(30)=null,
    @Date_of_birth varchar(30)=null,
    @Hobbies varchar(30)=null,
	@Gender varchar (30)=null,
    @States varchar(30)=null,
    @City varchar(30)=null,
	@UploadImage varchar(30)=null,
	@UploadPdf varchar(30)=null,
    @operation varchar(30)=null
AS
BEGIN
    IF @operation = 'Insert' 
    BEGIN
       
        IF NOT EXISTS (
            SELECT 1
            FROM MVC
            WHERE strfirst_name = @First_name
              AND strlast_name = @Last_name
              AND dtedob = @Date_of_birth
              AND strhobbies = @Hobbies
              AND strgender = @Gender
              AND strstates = @States
              AND strcity = @City
              AND uploadimage = @UploadImage
              AND uploadpdf = @UploadPdf
        )
        BEGIN

            INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);
        END
        ELSE
        BEGIN
            
            RAISEERROR('Duplicate record detected. Insertion aborted.');
        END
    
    ELSE IF @operation = 'Delete'
    BEGIN
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC 
    END
	ELSE IF @operation ='GetById'
	BEGIN
	  select * from MVC where intid = @Id
END
END


------------------------------------------------------------------------------------------------------------------------



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
        IF NOT EXISTS (
            SELECT 1 FROM MVC
            WHERE strfirst_name = @First_name
            AND strlast_name = @Last_name
            AND dtedob = @Date_of_birth
        )
        BEGIN
            INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);
        END
        ELSE
        BEGIN
        END
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
    END
    ELSE IF @operation = 'Delete'
    BEGIN
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
END




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
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN


		SELECT * FROM MVC


    END
END


select * from Hobbies;

INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
VALUES (@Id, @HobbyID);

INSERT INTO UserHobbies (EmployeeHobbyId, HobbyId)
VALUES (@EmployeeID, @HobbyID);

DECLARE @EmployeeID INT;

ALTER TABLE MVC
DROP COLUMN Hid;

----------------------------------------------------------------------------------------------------------------------------

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

----------------------------------------------------------------------------------------------------------------------------


CREATE TABLE EmployeeHistory (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,

    DeletedOn varchar(50)
);

select * from EmployeeHistory

alter PROCEDURE DeleteEmployeeAndStoreInHistory
    @EmployeeID INT
AS
BEGIN

    DECLARE @FirstName VARCHAR(50);
    DECLARE @LastName VARCHAR(50);
    DECLARE @DateOfBirth DATE;


    SELECT
        @FirstName = strfirst_name,
        @LastName =  strlast_name,
        @DateOfBirth =dtedob
    FROM MVC
    WHERE intid = @Id;


    DELETE FROM MVC
    WHERE intid = @Id;

    INSERT INTO EmployeeHistory (EmployeeID, FirstName, LastName, DateOfBirth, DeletedOn)
    VALUES (@EmployeeID, @FirstName, @LastName, @DateOfBirth, GETDATE());
END;




------------------------------------------------------------------------------------------------------------------------------------------------------








----------------------------------------------------------------------------------------------------------------------------

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
----------------------------------------------------------------------------------------------------------------------------

select * from Hobbies1;


select * from UserHobbies;


----------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE DeleteEmployeeAndStoreInHistory
    @Id INT
AS
BEGIN

    DECLARE @FirstName VARCHAR(50);
    DECLARE @LastName VARCHAR(50);
    DECLARE @DateOfBirth DATE;

    SELECT
        @FirstName = strfirst_name,
        @LastName =  strlast_name,
        @DateOfBirth = dtedob
    FROM MVC
    WHERE intid = @Id;


    DELETE FROM MVC
    WHERE intid = @Id;

 
    INSERT INTO EmployeeHistory (EmployeeID, FirstName, LastName, DateOfBirth, DeletedOn)
    VALUES (@Id, @FirstName, @LastName, @DateOfBirth, GETDATE());
END;





ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30),
    @Last_name VARCHAR(30),
    @Date_of_birth VARCHAR(30),
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
    END
    ELSE IF @operation = 'Delete'
    BEGIN

        DELETE FROM MVC WHERE intid = @Id;

        INSERT INTO EmployeeHistory (EmployeeID, FirstName, LastName, DateOfBirth, DeletedOn)
        SELECT @Id, @First_name, @Last_name, @Date_of_birth, GETDATE();
    END
    ELSE IF @operation = 'Select'
    BEGIN

        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN

        SELECT * FROM MVC
       
        WHERE intid = @Id;
    END
END


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
  
    SET @First_name = ISNULL(@First_name, '');
    SET @Last_name = ISNULL(@Last_name, '');    
    SET @Date_of_birth = ISNULL(@Date_of_birth, '');  

    IF @operation = 'Insert'
    BEGIN
        
        INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
        VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);

  
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
    END
    ELSE IF @operation = 'Delete'
    BEGIN
     
        DELETE FROM MVC WHERE intid = @Id;

        INSERT INTO EmployeeHistory (EmployeeID, FirstName, LastName, DateOfBirth, DeletedOn)
        SELECT @Id, @First_name, @Last_name, @Date_of_birth, GETDATE();
    END
    ELSE IF @operation = 'Select'
    BEGIN
       
        SELECT * FROM MVC;
    END
    ELSE IF @operation = 'GetById'
    BEGIN
        
        SELECT * FROM MVC
       
        WHERE intid = @Id;
    END
END


select * from EmployeeHistory





CREATE TRIGGER MVC_DeleteTrigger
ON MVC
AFTER DELETE
AS
BEGIN
    INSERT INTO MVC_History
    SELECT d.intid, d.strfirst_name, d.strlast_name, d.dtedob, d.strhobbies, d.strgender, d.strstates, d.strcity, d.uploadimage, d.uploadpdf, 'Deleted', GETDATE()
    FROM deleted d;
END;


CREATE TRIGGER MVC_UpdateTrigger
ON MVC
AFTER UPDATE
AS
BEGIN
    INSERT INTO MVC_History
    SELECT i.intid, i.strfirst_name, i.strlast_name, i.dtedob, i.strhobbies, i.strgender, i.strstates, i.strcity, i.uploadimage, i.uploadpdf, 'Updated', GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.intid = d.intid
    WHERE
        i.strfirst_name <> d.strfirst_name OR
        i.strlast_name <> d.strlast_name OR
        i.dtedob <> d.dtedob OR
        i.strhobbies <> d.strhobbies OR
        i.strgender <> d.strgender OR
        i.strstates <> d.strstates OR
        i.strcity <> d.strcity OR
        i.uploadimage <> d.uploadimage OR
        i.uploadpdf <> d.uploadpdf;
END;


CREATE TABLE MVC_History (
    intid INT PRIMARY KEY,
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

select * from MVC_History

drop table EmployeeHistory




CREATE TRIGGER MVC_DeleteTrigger
ON MVC
AFTER DELETE
AS
BEGIN
    INSERT INTO MVC_History
    SELECT d.intid, d.strfirst_name, d.strlast_name, d.dtedob, d.strhobbies, d.strgender, d.strstates, d.strcity, d.uploadimage, d.uploadpdf, 'Deleted', GETDATE()
    FROM deleted d;
END;


CREATE TRIGGER MVC_UpdateTrigger
ON MVC
AFTER UPDATE
AS
BEGIN
    INSERT INTO MVC_History
    SELECT i.intid, i.strfirst_name, i.strlast_name, i.dtedob, i.strhobbies, i.strgender, i.strstates, i.strcity, i.uploadimage, i.uploadpdf, 'Updated', GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.intid = d.intid
    WHERE
        i.strfirst_name <> d.strfirst_name OR
        i.strlast_name <> d.strlast_name OR
        i.dtedob <> d.dtedob OR
        i.strhobbies <> d.strhobbies OR
        i.strgender <> d.strgender OR
        i.strstates <> d.strstates OR
        i.strcity <> d.strcity OR
        i.uploadimage <> d.uploadimage OR
        i.uploadpdf <> d.uploadpdf;
END;


CREATE TABLE Hobbies1_History (
    Hid int,
    Hobbiesname varchar(30),
    action varchar(10),
    change_date datetime
);



CREATE TRIGGER Hobbies1_DeleteTrigger
ON Hobbies1
AFTER DELETE
AS
BEGIN
    INSERT INTO Hobbies1_History
    SELECT *, 'Deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER Hobbies1_UpdateTrigger
ON Hobbies1
AFTER UPDATE
AS
BEGIN
    INSERT INTO Hobbies1_History
    SELECT *, 'Updated', GETDATE()
    FROM inserted;
END;

select * from Hobbies1_History



CREATE TRIGGER MVC_DeleteTrigger
ON MVC
AFTER DELETE
AS
BEGIN

    DELETE FROM Hobbies1
    WHERE Hid IN (
        SELECT DISTINCT H.Hid
        FROM deleted D
        JOIN UserHobbies UH ON D.intid = UH.EmployeeHobbyId
        JOIN Hobbies1 H ON UH.HobbyId = H.Hid
    );


    INSERT INTO MVC_History
    SELECT d.intid, d.strfirst_name, d.strlast_name, d.dtedob, d.strhobbies, d.strgender, d.strstates, d.strcity, d.uploadimage, d.uploadpdf, 'Deleted', GETDATE()
    FROM deleted d;
END;


drop trigger MVC_DeleteTrigger




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
END







ALTER PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT,
	@searchData int,
    @FilterText NVARCHAR(50)
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
            @FilterText = '' OR
            (LEFT(strfirst_name, 3) LIKE @FilterText + '%' OR LEFT(strlast_name, 3) LIKE @FilterText + '%')
    )

    SELECT * FROM PagedData WHERE RowNum BETWEEN @StartRow AND @EndRow;
END



EXEC GetPagedData @PageNumber = 1, @PageSize = 10;





ALTER PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT,
	@searchData int,
    @FilterText varchar(30) -- Optional parameter for filtering by first 3 letters of first name or last name
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
            (@FilterText IS NULL OR @FilterText = '')
            OR (LEFT(strfirst_name, 3) = @FilterText OR LEFT(strlast_name, 3) = @FilterText)
    )

    SELECT * FROM PagedData WHERE RowNum BETWEEN @StartRow AND @EndRow;
END


select * from MVC_History

select * from UserHobbies





ALTER PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT,
    @searchData VARCHAR(30)
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
