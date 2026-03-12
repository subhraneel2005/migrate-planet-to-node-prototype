-- DDL for MySQL
-- Generated from Prisma schema

CREATE TABLE `User` (
  `UserID` BIGINT NOT NULL,
  `Username` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Phash` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`UserID`)
);

CREATE TABLE `NewUserInvitations` (
  `Token` VARCHAR(50) NOT NULL,
  `TokenCreatedDate` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Token`)
);

CREATE TABLE `Project` (
  `ProjectID` BIGINT NOT NULL,
  `UserID` BIGINT NOT NULL,
  `ProjectName` VARCHAR(50) NOT NULL,
  `ProjectDescription` VARCHAR(1000) NOT NULL,
  `ProjectSearchKeywords` TEXT NOT NULL,
  `ProjectData` LONGTEXT NOT NULL,
  `ProjectImage` LONGTEXT NULL,
  `ProjectIsMusicBlocks` TINYINT(1) NOT NULL,
  `ProjectCreatorName` VARCHAR(50) NOT NULL DEFAULT 'anonymous',
  `ProjectCreatedDate` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ProjectDownloads` INT NOT NULL DEFAULT 0,
  `ProjectLikes` INT NOT NULL DEFAULT 0,
  `ProjectLastUpdated` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ProjectID`),
  INDEX `idx_project_userid` (`UserID`),
  CONSTRAINT `fk_project_user` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE
);

CREATE TABLE `LikesToProjects` (
  `RowID` BIGINT NOT NULL,
  `ProjectID` BIGINT NOT NULL,
  `UserID` BIGINT NOT NULL,
  PRIMARY KEY (`RowID`),
  INDEX `idx_likestoprojects_projectid` (`ProjectID`),
  INDEX `idx_likestoprojects_userid` (`UserID`),
  CONSTRAINT `fk_likestoprojects_project` FOREIGN KEY (`ProjectID`) REFERENCES `Project` (`ProjectID`) ON DELETE CASCADE,
  CONSTRAINT `fk_likestoprojects_user` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE
);

CREATE TABLE `Reports` (
  `ReportID` INT NOT NULL,
  `ProjectID` BIGINT NOT NULL,
  `UserID` BIGINT NOT NULL,
  `Description` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`ReportID`),
  INDEX `idx_reports_projectid` (`ProjectID`),
  INDEX `idx_reports_userid` (`UserID`),
  CONSTRAINT `fk_reports_project` FOREIGN KEY (`ProjectID`) REFERENCES `Project` (`ProjectID`) ON DELETE CASCADE,
  CONSTRAINT `fk_reports_user` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE
);

CREATE TABLE `Tags` (
  `TagID` INT NOT NULL,
  `TagName` VARCHAR(50) NOT NULL,
  `IsTagUserAddable` TINYINT(1) NOT NULL,
  `IsDisplayTag` TINYINT(1) NOT NULL,
  PRIMARY KEY (`TagID`)
);

CREATE TABLE `TagsToProjects` (
  `RowID` INT NOT NULL,
  `TagID` INT NOT NULL,
  `ProjectID` BIGINT NOT NULL,
  PRIMARY KEY (`RowID`),
  INDEX `idx_tagstoprojects_tagid` (`TagID`),
  INDEX `idx_tagstoprojects_projectid` (`ProjectID`),
  CONSTRAINT `fk_tagstoprojects_project` FOREIGN KEY (`ProjectID`) REFERENCES `Project` (`ProjectID`) ON DELETE CASCADE,
  CONSTRAINT `fk_tagstoprojects_tag` FOREIGN KEY (`TagID`) REFERENCES `Tags` (`TagID`) ON DELETE CASCADE
);