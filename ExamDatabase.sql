USE [master]
GO
/****** Object:  Database [SQME]    Script Date: 13/09/2024 4:14:06 pm ******/
CREATE DATABASE [SQME]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SQME', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SQME.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SQME_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SQME_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SQME] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SQME].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SQME] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SQME] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SQME] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SQME] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SQME] SET ARITHABORT OFF 
GO
ALTER DATABASE [SQME] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SQME] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SQME] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SQME] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SQME] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SQME] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SQME] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SQME] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SQME] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SQME] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SQME] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SQME] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SQME] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SQME] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SQME] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SQME] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SQME] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SQME] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SQME] SET  MULTI_USER 
GO
ALTER DATABASE [SQME] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SQME] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SQME] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SQME] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SQME] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SQME] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SQME] SET QUERY_STORE = OFF
GO
USE [SQME]
GO
/****** Object:  Table [dbo].[CustomerTable]    Script Date: 13/09/2024 4:14:08 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[FullName] [varchar](100) NOT NULL,
	[MobileNumber] [numeric](18, 0) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderListTable]    Script Date: 13/09/2024 4:14:08 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderListTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 0) NULL,
	[TimeStamp] [datetime] NULL,
	[UserID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OrderListTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderTable]    Script Date: 13/09/2024 4:14:08 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[DeliveryDate] [datetime] NULL,
	[Status] [bit] NULL,
	[Amount] [decimal](18, 0) NULL,
	[DateCreated] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[TimeStamp] [datetime] NULL,
	[UserID] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_OrderTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTable]    Script Date: 13/09/2024 4:14:08 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[DateCreated] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[TimeStamp] [datetime] NULL,
	[UserID] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ProductTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CustomerTable] ON 

INSERT [dbo].[CustomerTable] ([ID], [FirstName], [LastName], [FullName], [MobileNumber], [City], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (1, N'Lenard', N'Robenta', N'Robenta, Lenard', CAST(9158315834 AS Numeric(18, 0)), N'Valenzuela', CAST(N'2024-09-12T16:23:50.817' AS DateTime), N'admin', CAST(N'2024-09-12T16:33:11.600' AS DateTime), N'admin', 1)
INSERT [dbo].[CustomerTable] ([ID], [FirstName], [LastName], [FullName], [MobileNumber], [City], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (2, N'Menard', N'Robenta', N'Robenta, Menard', CAST(1233457897 AS Numeric(18, 0)), N'Val', CAST(N'2024-09-12T16:24:21.533' AS DateTime), N'admin', CAST(N'2024-09-12T16:35:08.303' AS DateTime), N'admin', 0)
INSERT [dbo].[CustomerTable] ([ID], [FirstName], [LastName], [FullName], [MobileNumber], [City], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (3, N'test', N'test', N'test, test', CAST(123 AS Numeric(18, 0)), N'test', CAST(N'2024-09-12T16:25:33.747' AS DateTime), N'admin', CAST(N'2024-09-12T16:25:33.747' AS DateTime), N'admin', 1)
SET IDENTITY_INSERT [dbo].[CustomerTable] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderListTable] ON 

INSERT [dbo].[OrderListTable] ([ID], [OrderID], [ProductID], [Quantity], [Price], [TimeStamp], [UserID]) VALUES (7, 1, 3, 3, CAST(3 AS Decimal(18, 0)), CAST(N'2024-09-13T16:03:49.073' AS DateTime), N'admin')
INSERT [dbo].[OrderListTable] ([ID], [OrderID], [ProductID], [Quantity], [Price], [TimeStamp], [UserID]) VALUES (8, 1, 5, 2, CAST(46 AS Decimal(18, 0)), CAST(N'2024-09-13T16:03:49.077' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[OrderListTable] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderTable] ON 

INSERT [dbo].[OrderTable] ([ID], [CustomerID], [DeliveryDate], [Status], [Amount], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (1, 1, CAST(N'2024-09-16T00:00:00.000' AS DateTime), 1, CAST(49 AS Decimal(18, 0)), NULL, N'admin', NULL, N'admin', 1)
SET IDENTITY_INSERT [dbo].[OrderTable] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTable] ON 

INSERT [dbo].[ProductTable] ([ID], [Name], [Code], [UnitPrice], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (1, N'testproduct', N'testing', CAST(1.00 AS Decimal(18, 2)), CAST(N'2024-09-12T17:44:25.057' AS DateTime), N'admin', CAST(N'2024-09-12T23:04:54.620' AS DateTime), N'admin', 0)
INSERT [dbo].[ProductTable] ([ID], [Name], [Code], [UnitPrice], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (2, N'testproductsssss', N't', CAST(1.00 AS Decimal(18, 2)), CAST(N'2024-09-12T18:36:24.180' AS DateTime), N'admin', CAST(N'2024-09-12T18:36:24.180' AS DateTime), N'admin', 1)
INSERT [dbo].[ProductTable] ([ID], [Name], [Code], [UnitPrice], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (3, N'test prod', N'prod', CAST(1.00 AS Decimal(18, 2)), CAST(N'2024-09-12T22:38:50.260' AS DateTime), N'admin', CAST(N'2024-09-12T22:38:50.260' AS DateTime), N'admin', 1)
INSERT [dbo].[ProductTable] ([ID], [Name], [Code], [UnitPrice], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (4, N'prod', N'pr', CAST(3.00 AS Decimal(18, 2)), CAST(N'2024-09-12T22:39:21.923' AS DateTime), N'admin', CAST(N'2024-09-12T22:39:21.923' AS DateTime), N'admin', 1)
INSERT [dbo].[ProductTable] ([ID], [Name], [Code], [UnitPrice], [DateCreated], [CreatedBy], [TimeStamp], [UserID], [IsActive]) VALUES (5, N'testing', N'tes', CAST(23.47 AS Decimal(18, 2)), CAST(N'2024-09-12T22:40:38.373' AS DateTime), N'admin', CAST(N'2024-09-12T23:05:08.633' AS DateTime), N'admin', 1)
SET IDENTITY_INSERT [dbo].[ProductTable] OFF
GO
ALTER TABLE [dbo].[CustomerTable] ADD  CONSTRAINT [DF_CustomerTable_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[CustomerTable] ADD  CONSTRAINT [DF_CustomerTable_TimeStamp]  DEFAULT (getdate()) FOR [TimeStamp]
GO
ALTER TABLE [dbo].[CustomerTable] ADD  CONSTRAINT [DF_CustomerTable_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[OrderListTable] ADD  CONSTRAINT [DF_OrderListTable_TimeStamp]  DEFAULT (getdate()) FOR [TimeStamp]
GO
ALTER TABLE [dbo].[ProductTable] ADD  CONSTRAINT [DF_ProductTable_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ProductTable] ADD  CONSTRAINT [DF_ProductTable_TimeStamp]  DEFAULT (getdate()) FOR [TimeStamp]
GO
/****** Object:  StoredProcedure [dbo].[CustomerCreate]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
CREATE PROCEDURE [dbo].[CustomerCreate]  
  @ID int
 ,@FirstName varchar(50)  
 ,@LastName varchar(50)  
 ,@MobileNumber numeric  
 ,@City varchar(max)  
 ,@IsActive bit  
AS  
BEGIN  
 INSERT INTO CustomerTable(FirstName, LastName, FullName, MobileNumber, City, IsActive, CreatedBy, UserID)  
 VALUES(@FirstName, @LastName, CONCAT(@LastName, ', ', @FirstName), @MobileNumber, @City, @IsActive, 'admin', 'admin')  
   
END  
GO
/****** Object:  StoredProcedure [dbo].[CustomerGet]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE PROCEDURE [dbo].[CustomerGet]

AS
BEGIN
	Select * from CustomerTable

	Select COUNT(*) from CustomerTable
	
END
GO
/****** Object:  StoredProcedure [dbo].[CustomerUpdate]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE PROCEDURE [dbo].[CustomerUpdate]
	 @ID int
	,@FirstName varchar(50)
	,@LastName varchar(50)
	,@MobileNumber numeric
	,@City varchar(max)
	,@IsActive bit
AS
BEGIN
	UPDATE CustomerTable
	SET FirstName = @FirstName
		,LastName = @LastName
		,FullName = CONCAT(@LastName, ', ', @FirstName)
		,MobileNumber = @MobileNumber
		,City = @City
		,IsActive = @IsActive
		,[TimeStamp] = GETDATE()
		,UserID = 'admin'
		WHERE ID = @ID
END


GO
/****** Object:  StoredProcedure [dbo].[OrderCreate]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
            
-- =============================================            
CREATE PROCEDURE [dbo].[OrderCreate]            
  @ID int          
 ,@CustomerID int  
 ,@DeliveryDate datetime  
 ,@Status bit  
 ,@Amount decimal(18,2)     
 ,@OrderID int output
AS            
BEGIN            
 INSERT INTO OrderTable(CustomerID, DeliveryDate, [Status], Amount, CreatedBy, UserID, IsActive)  
 VALUES(@CustomerID, @DeliveryDate, @Status, @Amount, 'admin', 'admin', 1)  

 SET @OrderID = (SELECT MAX(ID) FROM ORDERTABLE)
END   
GO
/****** Object:  StoredProcedure [dbo].[OrderGet]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
-- =============================================      
CREATE PROCEDURE [dbo].[OrderGet]      
      
AS      
BEGIN      
 Select c.ID as CustomerID, c.FullName, o.*  from CustomerTable c    
 JOIN OrderTable o ON c.ID = o.CustomerID    
      
 Select COUNT(*) from OrderTable      
       
END 
GO
/****** Object:  StoredProcedure [dbo].[OrderListCreate]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
          
-- =============================================          
CREATE PROCEDURE [dbo].[OrderListCreate]          
  @OrderID int
 ,@ItemID int
 ,@Quantity int
 ,@Amount decimal(18,2) 
 ,@i int
AS          
BEGIN      
	
	IF @i = 0
	BEGIN
		DELETE FROM OrderListTable WHERE OrderID = @OrderID
	END
	

	INSERT INTO OrderListTable(OrderID, ProductID, Quantity, Price, [TimeStamp], UserID)
	VALUES(@OrderID, @ItemID, @Quantity, @Amount, GETDATE(), 'admin')
END 
GO
/****** Object:  StoredProcedure [dbo].[OrderListGet]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
-- =============================================      
CREATE PROCEDURE [dbo].[OrderListGet]      
    @OrderID int  
AS      
BEGIN      
 SELECT p.ID AS ItemID, p.[Name], o.* FROM OrderListTable o
 JOIN ProductTable p ON o.ProductID = p.ID
 WHERE OrderID = @OrderID  
      
 SELECT COUNT(*) FROM OrderListTable WHERE OrderID = @OrderID  
       
END 
GO
/****** Object:  StoredProcedure [dbo].[OrderUpdate]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
            
-- =============================================            
CREATE PROCEDURE [dbo].[OrderUpdate]            
  @ID int          
 ,@CustomerID int  
 ,@DeliveryDate datetime  
 ,@Status bit  
 ,@Amount decimal(18,2)   
 ,@OrderID int output

AS            
BEGIN        
 UPDATE OrderTable  
 SET DeliveryDate = @DeliveryDate  
  ,[Status] = @Status  
  ,Amount = @Amount  
  WHERE ID = @ID  
  
  SET @OrderID = @ID
   
END   
GO
/****** Object:  StoredProcedure [dbo].[ProductCreate]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
-- =============================================        
CREATE PROCEDURE [dbo].[ProductCreate]        
  @ID int      
 ,@Name varchar(50)        
 ,@Code varchar(50)        
 ,@UnitPrice decimal(18,2)       
 ,@IsActive bit        
 ,@Error bit output    
 ,@ErrorMsg varchar(max) output  
AS        
BEGIN        
 IF EXISTS (SELECT [Name] FROM ProductTable WHERE [Name] = @Name OR Code = @Code)    
  BEGIN    
   SET @Error = 1    
   SET @ErrorMsg = 'Product Name or Code Already Exists'    
  END    
 ELSE    
  BEGIN    
   INSERT INTO ProductTable([Name], Code, UnitPrice, IsActive, CreatedBy, UserID)        
   VALUES(@Name, @Code, @UnitPrice, @IsActive, 'admin', 'admin')        
    
   SET @Error = 0    
   SET @ErrorMsg = ''    
  END    
END 
GO
/****** Object:  StoredProcedure [dbo].[ProductGet]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
CREATE PROCEDURE [dbo].[ProductGet]  
  
AS  
BEGIN  
 Select * from ProductTable  
  
 Select COUNT(*) from ProductTable  
   
END  
GO
/****** Object:  StoredProcedure [dbo].[ProductUpdate]    Script Date: 13/09/2024 4:14:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
-- =============================================      
CREATE PROCEDURE [dbo].[ProductUpdate]      
  @ID int      
 ,@Name varchar(50)      
 ,@Code varchar(50)      
 ,@UnitPrice decimal(18,2) 
 ,@IsActive bit  
 ,@Error bit output  
 ,@ErrorMsg varchar(max) output  
AS      
BEGIN      
  
IF EXISTS (SELECT [Name] FROM ProductTable WHERE ([Name] = @Name OR Code = @Code) AND ID != @ID)  
  BEGIN  
   SET @Error = 1  
   SET @ErrorMsg = 'Product Name or Code Already Exists'  
  END  
 ELSE  
  BEGIN  
   UPDATE ProductTable      
   SET [Name] = @Name    
   ,Code = @Code    
   ,UnitPrice = @UnitPrice    
   ,IsActive = @IsActive      
   ,[TimeStamp] = GETDATE()      
   ,UserID = 'admin'      
   WHERE ID = @ID    
  
   SET @Error = 0  
   SET @ErrorMsg = ''  
  END  
     
END      
 
GO
USE [master]
GO
ALTER DATABASE [SQME] SET  READ_WRITE 
GO
