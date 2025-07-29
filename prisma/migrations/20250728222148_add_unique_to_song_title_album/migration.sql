/*
  Warnings:

  - A unique constraint covering the columns `[title,albumId]` on the table `song` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "song_title_albumId_key" ON "song"("title", "albumId");
