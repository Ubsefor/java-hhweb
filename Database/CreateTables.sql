USE [TestDB]
GO

DROP TABLE IF EXISTS [dbo].[CrossJobs]
DROP TABLE IF EXISTS [dbo].[PlaceJobs]
DROP TABLE IF EXISTS [dbo].[Appliance]
DROP TABLE IF EXISTS [dbo].[Person]
--
DROP TABLE IF EXISTS [dbo].[Vacancies]
DROP TABLE IF EXISTS [dbo].[Companies]
--
DROP TABLE IF EXISTS [dbo].[Logins]
DROP TABLE IF EXISTS [dbo].[educations]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[educations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [sysname] NOT NULL,
  PRIMARY KEY CLUSTERED ( [id] ASC )
)
GO

CREATE TABLE [dbo].[Logins](
	[login] [sysname] NOT NULL,
	[is_Companies] [bit] NOT NULL,
	[is_active] [bit] NOT NULL DEFAULT(0),
	[salt] [varbinary](8000) NULL,
  PRIMARY KEY CLUSTERED (	[login] ASC )
)
GO

CREATE TABLE [dbo].[Companies](
	[login] [sysname] NOT NULL,
	[name] [sysname] NOT NULL,
	[full_name] [nvarchar](4000) NULL,
  PRIMARY KEY CLUSTERED([login] ASC)
)
GO


CREATE TABLE [dbo].[Vacancies](
	[login] [sysname] NOT NULL,
	[job_title] [sysname] NOT NULL,
	[Wage] [money] NULL,
	[education_ID] [int] NOT NULL DEFAULT(1),
	[job_expr] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Person](
	[login] [sysname] NOT NULL,
	[first_name] [sysname] NOT NULL,
	[last_name] [sysname] NOT NULL,
	[sur_name] [sysname] NULL,
	[education_ID] [int] NOT NULL DEFAULT(1),
	[home_address] [nvarchar](1024) NULL,
  PRIMARY KEY CLUSTERED (	[login] ASC )
)
GO

CREATE TABLE [dbo].[Appliance](
	[id] [int] IDENTITY(1,1) NOT NULL,
  [login] [sysname] NOT NULL,
	[desired_job] [sysname] NOT NULL,
	[Wage] [money] NULL,
	[contact_phone] [varchar](20) NULL,
	[job_status] [bit] NOT NULL DEFAULT(0),
  PRIMARY KEY CLUSTERED 
  (
	  [login] ASC, [id] ASC
  )ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PlaceJobs](
	[id] [int] IDENTITY(1,1) NOT NULL,
  [login] [sysname] NOT NULL,
	[company_name] [sysname] NOT NULL,
	[job_title] [sysname] NOT NULL,
	[Duties] [nvarchar](max) NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
  PRIMARY KEY CLUSTERED (	[login] ASC, [id] ASC )
) 
GO

CREATE TABLE [dbo].[CrossJobs](
	[login] [sysname] NOT NULL,
	[appliance_id] [int] NULL,
	[place_job_id] [int] NULL, 
  CONSTRAINT [LA_CrossJobs] UNIQUE ([login], [appliance_id]),
  CONSTRAINT [LP_CrossJobs] UNIQUE ([login], [place_job_id])
)
GO

ALTER TABLE [dbo].[Appliance]  WITH CHECK ADD  CONSTRAINT [FK_Appliance_Person] FOREIGN KEY([login])
REFERENCES [dbo].[Person] ([login])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Appliance] CHECK CONSTRAINT [FK_Appliance_Person]
GO

ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Logins] FOREIGN KEY([login])
REFERENCES [dbo].[Logins] ([login])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_Logins]
GO

ALTER TABLE [dbo].[CrossJobs]  WITH CHECK ADD  CONSTRAINT [FK_CrossJobs_Appliance] FOREIGN KEY([login], [appliance_id])
REFERENCES [dbo].[Appliance] ([login], [id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[CrossJobs] CHECK CONSTRAINT [FK_CrossJobs_Appliance]
GO

ALTER TABLE [dbo].[CrossJobs]  WITH CHECK ADD  CONSTRAINT [FK_CrossJobs_PlaceJobs] FOREIGN KEY([login], [place_job_id])
REFERENCES [dbo].[PlaceJobs] ([login], [id])
GO

ALTER TABLE [dbo].[CrossJobs] CHECK CONSTRAINT [FK_CrossJobs_PlaceJobs]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Education] FOREIGN KEY([education_ID])
REFERENCES [dbo].[educations] ([id])
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Education]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Logins] FOREIGN KEY([login])
REFERENCES [dbo].[Logins] ([login])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Logins]
GO

ALTER TABLE [dbo].[PlaceJobs]  WITH CHECK ADD  CONSTRAINT [FK_PlaceJobs_Person] FOREIGN KEY([login])
REFERENCES [dbo].[Person] ([login])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[PlaceJobs] CHECK CONSTRAINT [FK_PlaceJobs_Person]
GO

ALTER TABLE [dbo].[Vacancies]  WITH CHECK ADD  CONSTRAINT [FK_Vacancies_Companies] FOREIGN KEY([login])
REFERENCES [dbo].[Companies] ([login])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Vacancies] CHECK CONSTRAINT [FK_Vacancies_Companies]
GO

ALTER TABLE [dbo].[Vacancies]  WITH CHECK ADD  CONSTRAINT [FK_Vacancies_Education] FOREIGN KEY([education_ID])
REFERENCES [dbo].[educations] ([id])
GO

ALTER TABLE [dbo].[Vacancies] CHECK CONSTRAINT [FK_Vacancies_Education]
GO


