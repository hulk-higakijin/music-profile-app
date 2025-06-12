-- AlterTable
ALTER TABLE "User" ADD COLUMN     "username" TEXT NOT NULL,
ADD COLUMN     "lastfmUsername" TEXT,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateTable
CREATE TABLE "MusicProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "bio" TEXT,
    "backgroundColor" TEXT NOT NULL DEFAULT '#000000',
    "textColor" TEXT NOT NULL DEFAULT '#ffffff',
    "layout" TEXT NOT NULL DEFAULT '4x4',
    "isPublic" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MusicProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MusicItem" (
    "id" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "artist" TEXT,
    "imageUrl" TEXT,
    "spotifyUrl" TEXT,
    "lastfmUrl" TEXT,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MusicItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "MusicProfile_userId_key" ON "MusicProfile"("userId");

-- AddForeignKey
ALTER TABLE "MusicProfile" ADD CONSTRAINT "MusicProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MusicItem" ADD CONSTRAINT "MusicItem_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "MusicProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;