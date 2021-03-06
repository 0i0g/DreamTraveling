USE [master]
GO
/****** Object:  Database [DreamTraveling]    Script Date: 6/24/2020 12:18:27 AM ******/
CREATE DATABASE [DreamTraveling]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DreamTraveling', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DreamTraveling.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DreamTraveling_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DreamTraveling_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DreamTraveling] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DreamTraveling].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DreamTraveling] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DreamTraveling] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DreamTraveling] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DreamTraveling] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DreamTraveling] SET ARITHABORT OFF 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DreamTraveling] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DreamTraveling] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DreamTraveling] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DreamTraveling] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DreamTraveling] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DreamTraveling] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DreamTraveling] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DreamTraveling] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DreamTraveling] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DreamTraveling] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DreamTraveling] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DreamTraveling] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DreamTraveling] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DreamTraveling] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DreamTraveling] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DreamTraveling] SET  MULTI_USER 
GO
ALTER DATABASE [DreamTraveling] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DreamTraveling] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DreamTraveling] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DreamTraveling] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DreamTraveling] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DreamTraveling]
GO
/****** Object:  UserDefinedFunction [dbo].[func_Split]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- split string function
CREATE FUNCTION [dbo].[func_Split]
    (
      @DelimitedString VARCHAR(8000) ,
      @Delimiter VARCHAR(100)
    )
RETURNS @tblArray TABLE
    (
      ElementID INT IDENTITY(1, 1) ,  -- Array index
      Element VARCHAR(1000) -- Array element contents
    )
AS
    BEGIN

    -- Local Variable Declarations
    -- ---------------------------
        DECLARE @Index SMALLINT ,
            @Start SMALLINT ,
            @DelSize SMALLINT;

        SET @DelSize = LEN(@Delimiter);

    -- Loop through source string and add elements to destination table array
    -- ----------------------------------------------------------------------
        WHILE LEN(@DelimitedString) > 0
            BEGIN

                SET @Index = CHARINDEX(@Delimiter, @DelimitedString);

                IF @Index = 0
                    BEGIN

                        INSERT  INTO @tblArray
                                ( Element )
                        VALUES  ( LTRIM(RTRIM(@DelimitedString)) );

                        BREAK;
                    END;
                ELSE
                    BEGIN

                        INSERT  INTO @tblArray
                                ( Element
                                )
                        VALUES  ( LTRIM(RTRIM(SUBSTRING(@DelimitedString, 1,
                                                        @Index - 1)))
                                );

                        SET @Start = @Index + @DelSize;
                        SET @DelimitedString = SUBSTRING(@DelimitedString,
                                                         @Start,
                                                         LEN(@DelimitedString)
                                                         - @Start + 1);

                    END;
            END;

        RETURN;
    END;

GO
/****** Object:  Table [dbo].[tblBooking]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBooking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [varchar](20) NOT NULL,
	[dateOrder] [date] NOT NULL,
	[disCountCode] [varchar](20) NULL,
	[totalPrice] [int] NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBookingDetails]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBookingDetails](
	[bookingId] [int] NULL,
	[tourId] [int] NULL,
	[amount] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDiscount]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDiscount](
	[code] [varchar](20) NOT NULL,
	[discount] [int] NOT NULL,
	[isPercent] [bit] NOT NULL,
	[expiryDate] [datetime] NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTour]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTour](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[review] [ntext] NOT NULL,
	[fromDate] [date] NOT NULL,
	[toDate] [date] NOT NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[image] [varchar](255) NOT NULL,
	[dateImport] [datetime] NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[username] [varchar](20) NOT NULL,
	[password] [varchar](64) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[role] [varchar](10) NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUserUsedDiscount]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUserUsedDiscount](
	[userId] [varchar](20) NOT NULL,
	[discountCode] [varchar](20) NOT NULL,
UNIQUE NONCLUSTERED 
(
	[userId] ASC,
	[discountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tblBooking]  WITH CHECK ADD FOREIGN KEY([disCountCode])
REFERENCES [dbo].[tblDiscount] ([code])
GO
ALTER TABLE [dbo].[tblBooking]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[tblUser] ([username])
GO
ALTER TABLE [dbo].[tblBookingDetails]  WITH CHECK ADD FOREIGN KEY([bookingId])
REFERENCES [dbo].[tblBooking] ([id])
GO
ALTER TABLE [dbo].[tblBookingDetails]  WITH CHECK ADD FOREIGN KEY([tourId])
REFERENCES [dbo].[tblTour] ([id])
GO
ALTER TABLE [dbo].[tblUserUsedDiscount]  WITH CHECK ADD FOREIGN KEY([discountCode])
REFERENCES [dbo].[tblDiscount] ([code])
GO
ALTER TABLE [dbo].[tblUserUsedDiscount]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[tblUser] ([username])
GO
/****** Object:  StoredProcedure [dbo].[AddTour]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
-- PROC
---- Tour
CREATE PROC [dbo].[AddTour]
    @name AS NVARCHAR(20) ,
    @review AS NTEXT ,
    @price AS INT ,
    @quantity AS INT ,
    @image AS VARCHAR(255) ,
    @fromDate AS DATE ,
    @toDate AS DATE
AS
    BEGIN
        INSERT  INTO dbo.tblTour
                ( name ,
                  review ,
                  fromDate ,
                  toDate ,
                  price ,
                  quantity ,
                  image ,
                  dateImport ,
                  status
	            )
        VALUES  ( @name , -- name - nvarchar(20)
                  @review , -- review - ntext
                  @fromDate , -- fromDate - datetime
                  @toDate , -- toDate - datetime
                  @price , -- price - int
                  @quantity , -- quantity - int
                  @image , -- image - varchar(255)
                  GETDATE() , -- dateImport - datetime
                  'active'  -- status - varchar(10)
	            );
    END;

GO
/****** Object:  StoredProcedure [dbo].[CheckDiscount]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CheckDiscount]
    @userId AS VARCHAR(20) ,
    @code AS VARCHAR(20)
AS
    BEGIN
        SELECT  discount ,
                isPercent
        FROM    dbo.tblDiscount
        WHERE   code = @code
                AND status = 'active'
                AND CAST(expiryDate AS DATE) >= CAST(CURRENT_TIMESTAMP AS DATE)
                AND @code NOT IN ( SELECT   discountCode
                                   FROM     dbo.tblUserUsedDiscount
                                   WHERE    userId = @userId );
    END;

GO
/****** Object:  StoredProcedure [dbo].[CheckLogin]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---- User
CREATE PROC [dbo].[CheckLogin]
    @username AS VARCHAR(20) ,
    @password AS VARCHAR(64)
AS
    BEGIN
        SELECT  username ,
                password ,
                name ,
                role
        FROM    dbo.tblUser
        WHERE   username = @username
                AND password = @password
                AND status = 'active';
    END;


GO
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CreateUser]
    @username AS VARCHAR(20) ,
    @password AS VARCHAR(64) ,
    @name AS NVARCHAR(30)
AS
    BEGIN
        INSERT  INTO dbo.tblUser
                ( username ,
                  password ,
                  name ,
                  role ,
                  status
	            )
        VALUES  ( @username , -- username - varchar(20)
                  @password , -- password - varchar(64)
                  @name , -- name - nvarchar(30)
                  'user' , -- role - varchar(10)
                  'active'  -- status - varchar(10)
	            );
    END;


GO
/****** Object:  StoredProcedure [dbo].[DeactiveTourByID]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[DeactiveTourByID] @id AS INT
AS
    BEGIN
        UPDATE  dbo.tblTour
        SET     status = 'inactive'
        WHERE   id = @id;
    END;

GO
/****** Object:  StoredProcedure [dbo].[getImageOfTour]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[getImageOfTour] @id AS INT
AS
    BEGIN
        SELECT  image
        FROM    dbo.tblTour
        WHERE   id = @id;
    END;

GO
/****** Object:  StoredProcedure [dbo].[GetTourByID]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetTourByID] @id AS INT
AS
    BEGIN
        SELECT  id ,
                name ,
                review ,
                fromDate ,
                toDate ,
                price ,
                quantity ,
                image
        FROM    dbo.tblTour
        WHERE   id = @id
                AND status = 'active';
    END;

GO
/****** Object:  StoredProcedure [dbo].[GetTourInfoForViewCart]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROC [dbo].[GetTourInfoForViewCart] @ids AS VARCHAR(100)
AS
    BEGIN
        SELECT  id ,
                name ,
                fromDate ,
                toDate ,
                price ,
                quantity ,
                image
        FROM    dbo.tblTour
        WHERE   id IN ( SELECT  Element AS id
                        FROM    func_Split(@ids, ',') )
                AND status = 'active';
    END;

GO
/****** Object:  StoredProcedure [dbo].[GetToursInfoForHome]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROC [dbo].[GetToursInfoForHome]
    @name AS NVARCHAR(20) ,
    @fromDate AS DATE ,
    @toDate AS DATE ,
    @fromPrice AS INT ,
    @toPrice AS INT ,
    @minQuantity AS INT ,
    @fromNowOn AS BIT ,
    @page AS INT ,
    @rpp AS INT
AS
    BEGIN
		-- get data of result
        SELECT  id ,
                name ,
                review ,
                fromDate ,
                toDate ,
                price ,
                quantity ,
                image
        FROM    dbo.tblTour
        WHERE   status = 'active'
                AND ( @name IS NULL
                      OR name LIKE N'%' + @name + '%'
                    )
                AND ( @fromDate IS NULL
                      OR fromDate <= @fromDate
                      AND toDate >= @toDate
                    )
                AND ( @fromPrice IS NULL
                      OR price >= @fromPrice
                      AND price <= @toPrice
                    )
                AND quantity >= @minQuantity
                AND ( @fromNowOn = 1
                      OR fromDate >= CAST(CURRENT_TIMESTAMP AS DATE)
                    )
        ORDER BY dateImport DESC
                OFFSET ( ( @page - 1 ) * @rpp ) ROWS FETCH NEXT @rpp ROW ONLY;
    END;

GO
/****** Object:  StoredProcedure [dbo].[GetToursInfoForHomeLength]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetToursInfoForHomeLength]
    @name AS NVARCHAR(20) ,
    @fromDate AS DATE ,
    @toDate AS DATE ,
    @fromPrice AS INT ,
    @toPrice AS INT ,
    @minQuantity AS INT ,
    @fromNowOn AS BIT
AS
    BEGIN
	-- get number of result
        SELECT  COUNT(*) AS length
        FROM    dbo.tblTour
        WHERE   status = 'active'
                AND ( @name IS NULL
                      OR name LIKE N'%' + @name + '%'
                    )
                AND ( @fromDate IS NULL
                      OR fromDate <= @fromDate
                      AND toDate >= @toDate
                    )
                AND ( @fromPrice IS NULL
                      OR price >= @fromPrice
                      AND price <= @toPrice
                    )
                AND quantity >= @minQuantity
                AND ( @fromNowOn = 1
                      OR fromDate >= CAST(CURRENT_TIMESTAMP AS DATE)
                    );
    END;

GO
/****** Object:  StoredProcedure [dbo].[NewBooking]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[NewBooking]
    (
      @userId VARCHAR(20) ,
      @discountCode VARCHAR(10) ,
      @totalPrice INT,
	  @bookingId int out
    )
AS
    BEGIN
        INSERT  INTO dbo.tblBooking
                ( userId ,
                  dateOrder ,
                  disCountCode ,
                  totalPrice ,
                  status
	            )
        VALUES  ( @userId , -- userId - varchar(20)
                  GETDATE() , -- dateOrder - date
                  @discountCode , -- disCountCode - varchar(20)
                  @totalPrice , -- totalPrice - int
                  'waiting'  -- status - varchar(10)
	            );
        SET @bookingId = @@IDENTITY
    END;

GO
/****** Object:  StoredProcedure [dbo].[SaveBookingDetails]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SaveBookingDetails]
    (
      @bookingId INT ,
      @tourId INT ,
      @tourAmount INT,
	  @newQuantity INT OUT
    )
AS
    BEGIN
        UPDATE  dbo.tblTour
        SET     quantity = ( SELECT quantity
                             FROM   dbo.tblTour
                             WHERE  id = @tourId
                           ) - @tourAmount
        WHERE   id = @tourId;

		INSERT INTO dbo.tblBookingDetails
		        ( bookingId, tourId, amount )
		VALUES  ( @bookingId, -- bookingId - int
		          @tourId, -- tourId - int
		          @tourAmount  -- amount - int
		          )

        SELECT  @newQuantity = quantity
        FROM    dbo.tblTour
        WHERE   id = @tourId;
    END;

GO
/****** Object:  StoredProcedure [dbo].[UpdateTour]    Script Date: 6/24/2020 12:18:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UpdateTour]
    @id AS INT ,
    @name AS NVARCHAR(20) ,
    @review AS NTEXT ,
    @price AS INT ,
    @quantity AS INT ,
    @image AS VARCHAR(255) ,
    @fromDate AS DATE ,
    @toDate AS DATE
AS
    BEGIN
        UPDATE  dbo.tblTour
        SET     name = @name ,
                review = @review ,
                fromDate = @fromDate ,
                toDate = @toDate ,
                price = @price ,
                quantity = @quantity ,
                image = CASE WHEN @image IS NOT NULL THEN @image
                             ELSE image
                        END
        WHERE   id = @id
                AND status = 'active';
    END;

GO
USE [master]
GO
ALTER DATABASE [DreamTraveling] SET  READ_WRITE 
GO
