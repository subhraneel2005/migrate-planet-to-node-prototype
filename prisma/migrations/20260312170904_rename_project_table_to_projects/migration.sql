/*
  Warnings:

  - You are about to drop the `Project` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Fork` DROP FOREIGN KEY `Fork_ForkedProjectID_fkey`;

-- DropForeignKey
ALTER TABLE `Fork` DROP FOREIGN KEY `Fork_SourceProjectID_fkey`;

-- DropForeignKey
ALTER TABLE `LikesToProjects` DROP FOREIGN KEY `LikesToProjects_ProjectID_fkey`;

-- DropForeignKey
ALTER TABLE `Project` DROP FOREIGN KEY `Project_UserID_fkey`;

-- DropForeignKey
ALTER TABLE `Reports` DROP FOREIGN KEY `Reports_ProjectID_fkey`;

-- DropForeignKey
ALTER TABLE `Repository` DROP FOREIGN KEY `Repository_ProjectID_fkey`;

-- DropForeignKey
ALTER TABLE `TagsToProjects` DROP FOREIGN KEY `TagsToProjects_ProjectID_fkey`;

-- DropIndex
DROP INDEX `Fork_ForkedProjectID_fkey` ON `Fork`;

-- DropIndex
DROP INDEX `Fork_SourceProjectID_fkey` ON `Fork`;

-- DropTable
DROP TABLE `Project`;

-- CreateTable
CREATE TABLE `Projects` (
    `ProjectID` BIGINT NOT NULL,
    `UserID` BIGINT NOT NULL,
    `ProjectName` VARCHAR(50) NOT NULL,
    `ProjectDescription` VARCHAR(1000) NOT NULL,
    `ProjectSearchKeywords` TEXT NOT NULL,
    `ProjectData` LONGTEXT NOT NULL,
    `ProjectImage` LONGTEXT NULL,
    `ProjectIsMusicBlocks` BOOLEAN NOT NULL,
    `ProjectCreatorName` VARCHAR(50) NOT NULL DEFAULT 'anonymous',
    `ProjectCreatedDate` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `ProjectDownloads` INTEGER NOT NULL DEFAULT 0,
    `ProjectLikes` INTEGER NOT NULL DEFAULT 0,
    `ProjectLastUpdated` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `Projects_UserID_idx`(`UserID`),
    PRIMARY KEY (`ProjectID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `LikesToProjects` ADD CONSTRAINT `LikesToProjects_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Projects`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Projects` ADD CONSTRAINT `Projects_UserID_fkey` FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reports` ADD CONSTRAINT `Reports_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Projects`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TagsToProjects` ADD CONSTRAINT `TagsToProjects_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Projects`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Repository` ADD CONSTRAINT `Repository_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Projects`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Fork` ADD CONSTRAINT `Fork_SourceProjectID_fkey` FOREIGN KEY (`SourceProjectID`) REFERENCES `Projects`(`ProjectID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Fork` ADD CONSTRAINT `Fork_ForkedProjectID_fkey` FOREIGN KEY (`ForkedProjectID`) REFERENCES `Projects`(`ProjectID`) ON DELETE RESTRICT ON UPDATE CASCADE;
