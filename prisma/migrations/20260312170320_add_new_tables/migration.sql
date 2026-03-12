-- CreateTable
CREATE TABLE `LikesToProjects` (
    `RowID` BIGINT NOT NULL,
    `ProjectID` BIGINT NOT NULL,
    `UserID` BIGINT NOT NULL,

    INDEX `LikesToProjects_ProjectID_idx`(`ProjectID`),
    INDEX `LikesToProjects_UserID_idx`(`UserID`),
    PRIMARY KEY (`RowID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `NewUserInvitations` (
    `Token` VARCHAR(50) NOT NULL,
    `TokenCreatedDate` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`Token`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Project` (
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

    INDEX `Project_UserID_idx`(`UserID`),
    PRIMARY KEY (`ProjectID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Reports` (
    `ReportID` INTEGER NOT NULL,
    `ProjectID` BIGINT NOT NULL,
    `UserID` BIGINT NOT NULL,
    `Description` VARCHAR(1000) NOT NULL,

    INDEX `Reports_ProjectID_idx`(`ProjectID`),
    INDEX `Reports_UserID_idx`(`UserID`),
    PRIMARY KEY (`ReportID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Tags` (
    `TagID` INTEGER NOT NULL,
    `TagName` VARCHAR(50) NOT NULL,
    `IsTagUserAddable` BOOLEAN NOT NULL,
    `IsDisplayTag` BOOLEAN NOT NULL,

    PRIMARY KEY (`TagID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TagsToProjects` (
    `RowID` INTEGER NOT NULL,
    `TagID` INTEGER NOT NULL,
    `ProjectID` BIGINT NOT NULL,

    INDEX `TagsToProjects_TagID_idx`(`TagID`),
    INDEX `TagsToProjects_ProjectID_idx`(`ProjectID`),
    PRIMARY KEY (`RowID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `UserID` BIGINT NOT NULL,
    `Username` VARCHAR(50) NOT NULL,
    `Email` VARCHAR(50) NOT NULL,
    `Phash` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`UserID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Repository` (
    `RepoID` INTEGER NOT NULL AUTO_INCREMENT,
    `ProjectID` BIGINT NOT NULL,
    `Reponame` VARCHAR(191) NOT NULL,
    `GithubRepoID` INTEGER NOT NULL,
    `DefaultBranch` VARCHAR(191) NOT NULL DEFAULT 'main',
    `RepoURL` VARCHAR(191) NOT NULL,
    `CreatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Repository_ProjectID_key`(`ProjectID`),
    PRIMARY KEY (`RepoID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Fork` (
    `ForkID` INTEGER NOT NULL AUTO_INCREMENT,
    `SourceProjectID` BIGINT NOT NULL,
    `ForkedProjectID` BIGINT NOT NULL,
    `ForkedByUserID` BIGINT NOT NULL,
    `ForkedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`ForkID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Commit` (
    `CommitID` INTEGER NOT NULL AUTO_INCREMENT,
    `RepoID` INTEGER NOT NULL,
    `CommitSHA` VARCHAR(191) NOT NULL,
    `CommitMessage` VARCHAR(191) NOT NULL,
    `CommitedBy` BIGINT NOT NULL,
    `CommitedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`CommitID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PullRequest` (
    `PRID` INTEGER NOT NULL AUTO_INCREMENT,
    `SourceRepoID` INTEGER NOT NULL,
    `TargetRepoID` INTEGER NOT NULL,
    `PRNumber` INTEGER NOT NULL,
    `Title` VARCHAR(191) NOT NULL,
    `Status` ENUM('OPEN', 'CLOSED', 'MERGED') NOT NULL DEFAULT 'OPEN',
    `CreatedByUserID` BIGINT NOT NULL,
    `CreatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`PRID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `LikesToProjects` ADD CONSTRAINT `LikesToProjects_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Project`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LikesToProjects` ADD CONSTRAINT `LikesToProjects_UserID_fkey` FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Project` ADD CONSTRAINT `Project_UserID_fkey` FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reports` ADD CONSTRAINT `Reports_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Project`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reports` ADD CONSTRAINT `Reports_UserID_fkey` FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TagsToProjects` ADD CONSTRAINT `TagsToProjects_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Project`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TagsToProjects` ADD CONSTRAINT `TagsToProjects_TagID_fkey` FOREIGN KEY (`TagID`) REFERENCES `Tags`(`TagID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Repository` ADD CONSTRAINT `Repository_ProjectID_fkey` FOREIGN KEY (`ProjectID`) REFERENCES `Project`(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Fork` ADD CONSTRAINT `Fork_SourceProjectID_fkey` FOREIGN KEY (`SourceProjectID`) REFERENCES `Project`(`ProjectID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Fork` ADD CONSTRAINT `Fork_ForkedProjectID_fkey` FOREIGN KEY (`ForkedProjectID`) REFERENCES `Project`(`ProjectID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Commit` ADD CONSTRAINT `Commit_RepoID_fkey` FOREIGN KEY (`RepoID`) REFERENCES `Repository`(`RepoID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PullRequest` ADD CONSTRAINT `PullRequest_SourceRepoID_fkey` FOREIGN KEY (`SourceRepoID`) REFERENCES `Repository`(`RepoID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PullRequest` ADD CONSTRAINT `PullRequest_TargetRepoID_fkey` FOREIGN KEY (`TargetRepoID`) REFERENCES `Repository`(`RepoID`) ON DELETE RESTRICT ON UPDATE CASCADE;
