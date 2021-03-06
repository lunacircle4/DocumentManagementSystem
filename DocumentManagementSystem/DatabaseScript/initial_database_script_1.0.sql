USE [Documents]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DocumentView'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DocumentView'
GO
/****** Object:  StoredProcedure [dbo].[selectCategorizedDocument]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP PROCEDURE [dbo].[selectCategorizedDocument]
GO
/****** Object:  StoredProcedure [dbo].[selectCategorized]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP PROCEDURE [dbo].[selectCategorized]
GO
/****** Object:  StoredProcedure [dbo].[deleteDocument]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP PROCEDURE [dbo].[deleteDocument]
GO
/****** Object:  StoredProcedure [dbo].[createDocument]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP PROCEDURE [dbo].[createDocument]
GO
ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK__Documents__subje__398D8EEE]
GO
/****** Object:  View [dbo].[DocumentView]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP VIEW [dbo].[DocumentView]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP TABLE [dbo].[Document]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP TABLE [dbo].[Category]
GO
USE [master]
GO
/****** Object:  Database [Documents]    Script Date: 2019-02-18 오후 10:45:45 ******/
DROP DATABASE [Documents]
GO
/****** Object:  Database [Documents]    Script Date: 2019-02-18 오후 10:45:45 ******/
CREATE DATABASE [Documents]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Documents', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Documents.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Documents_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Documents_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Documents] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Documents].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Documents] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Documents] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Documents] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Documents] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Documents] SET ARITHABORT OFF 
GO
ALTER DATABASE [Documents] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Documents] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Documents] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Documents] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Documents] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Documents] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Documents] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Documents] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Documents] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Documents] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Documents] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Documents] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Documents] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Documents] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Documents] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Documents] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Documents] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Documents] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Documents] SET  MULTI_USER 
GO
ALTER DATABASE [Documents] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Documents] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Documents] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Documents] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Documents] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Documents] SET QUERY_STORE = OFF
GO
USE [Documents]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2019-02-18 오후 10:45:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[categoryId] [int] NOT NULL,
	[categoryName] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 2019-02-18 오후 10:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document](
	[documentId] [int] NOT NULL,
	[categoryId] [int] NOT NULL,
	[content] [varchar](50) NULL,
	[url] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[documentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DocumentView]    Script Date: 2019-02-18 오후 10:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DocumentView]
AS
SELECT  dbo.[Document].documentId, dbo.Category.categoryName, dbo.[Document].[content], dbo.[Document].url
FROM     dbo.Category INNER JOIN
               dbo.[Document] ON dbo.Category.categoryId = dbo.[Document].categoryId
GO
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (1, N'MVC')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (2, N'MSDB')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (3, N'C#')
INSERT [dbo].[Document] ([documentId], [categoryId], [content], [url]) VALUES (1, 1, N'testMVC', N'testmvc')
INSERT [dbo].[Document] ([documentId], [categoryId], [content], [url]) VALUES (2, 2, N'testDB', N'testdbs')
INSERT [dbo].[Document] ([documentId], [categoryId], [content], [url]) VALUES (3, 3, N'testC#', N'test.com')
ALTER TABLE [dbo].[Document]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([categoryId])
GO
/****** Object:  StoredProcedure [dbo].[createDocument]    Script Date: 2019-02-18 오후 10:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[createDocument] 
@categoryName as varchar(20),
@content as varchar(50),
@url as varchar(50)
AS
BEGIN
DECLARE @categoryId INT
DECLARE @newDocumentId INT

SELECT @categoryId = categoryId FROM Category WHERE category.categoryName = @categoryName
SELECT TOP 1 @newDocumentId = documentId FROM Document ORDER BY documentId DESC

INSERT INTO Document VALUES (
	@newDocumentId + 1,
	@categoryId,
	@content,
	@url
)

END



/*
exec createDocument @subjectName = 'MVC', @content = 'testInsert', @url = 'testInsert';
*/
GO
/****** Object:  StoredProcedure [dbo].[deleteDocument]    Script Date: 2019-02-18 오후 10:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[deleteDocument]
@documentId as int
AS
BEGIN
DELETE
FROM Document
WHERE documentId = @documentId
END


/*
exec selectSubject @subjectName = 'DDD';
*/
GO
/****** Object:  StoredProcedure [dbo].[selectCategorized]    Script Date: 2019-02-18 오후 10:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[selectCategorized] 
@categoryName as varchar(20)
AS
BEGIN
SELECT *
FROM DocumentsView
WHERE categoryName = @categoryName
END


/*
exec selectSubject @subjectName = 'DDD';
*/
GO
/****** Object:  StoredProcedure [dbo].[selectCategorizedDocument]    Script Date: 2019-02-18 오후 10:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[selectCategorizedDocument]
@categoryName as varchar(20)
AS
BEGIN
SELECT *
FROM DocumentView
WHERE categoryName = @categoryName
END


/*
exec selectSubject @subjectName = 'DDD';
*/
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Category"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Document"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 136
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DocumentView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DocumentView'
GO
USE [master]
GO
ALTER DATABASE [Documents] SET  READ_WRITE 
GO
