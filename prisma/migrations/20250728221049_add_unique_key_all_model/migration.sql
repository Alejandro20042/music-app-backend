/*
  Warnings:

  - A unique constraint covering the columns `[title]` on the table `album` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `artist` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[title]` on the table `song` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "song_title_albumId_key";

-- CreateIndex
CREATE UNIQUE INDEX "album_title_key" ON "album"("title");

-- CreateIndex
CREATE UNIQUE INDEX "artist_name_key" ON "artist"("name");

-- CreateIndex
CREATE UNIQUE INDEX "song_title_key" ON "song"("title");
