/*
  Warnings:

  - You are about to drop the column `artistaId` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `añoLanzamiento` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `descripcion` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `duracionTotal` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `genero` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `numeroTracks` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `portada` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `productor` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `sello` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `titulo` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the `Artista` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Cancion` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `artistId` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cover` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `genere` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `launch_year` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `producer` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `seal` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total_duration` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tracks_number` to the `Album` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Album" DROP CONSTRAINT "Album_artistaId_fkey";

-- DropForeignKey
ALTER TABLE "Cancion" DROP CONSTRAINT "Cancion_albumId_fkey";

-- DropForeignKey
ALTER TABLE "Cancion" DROP CONSTRAINT "Cancion_artistaId_fkey";

-- AlterTable
ALTER TABLE "Album" DROP COLUMN "artistaId",
DROP COLUMN "añoLanzamiento",
DROP COLUMN "descripcion",
DROP COLUMN "duracionTotal",
DROP COLUMN "genero",
DROP COLUMN "numeroTracks",
DROP COLUMN "portada",
DROP COLUMN "productor",
DROP COLUMN "sello",
DROP COLUMN "titulo",
ADD COLUMN     "artistId" INTEGER NOT NULL,
ADD COLUMN     "cover" TEXT NOT NULL,
ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "genere" TEXT NOT NULL,
ADD COLUMN     "launch_year" INTEGER NOT NULL,
ADD COLUMN     "producer" TEXT NOT NULL,
ADD COLUMN     "seal" TEXT NOT NULL,
ADD COLUMN     "title" TEXT NOT NULL,
ADD COLUMN     "total_duration" TEXT NOT NULL,
ADD COLUMN     "tracks_number" INTEGER NOT NULL;

-- DropTable
DROP TABLE "Artista";

-- DropTable
DROP TABLE "Cancion";

-- CreateTable
CREATE TABLE "Artist" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "nacionality" TEXT NOT NULL,
    "genere" TEXT NOT NULL,
    "formation_year" INTEGER NOT NULL,
    "biography" TEXT NOT NULL,
    "image_url" TEXT NOT NULL,

    CONSTRAINT "Artist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Song" (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "albumId" INTEGER NOT NULL,
    "artistId" INTEGER NOT NULL,
    "duration" TEXT NOT NULL,
    "track" INTEGER NOT NULL,
    "lyrics" TEXT NOT NULL,
    "composer" TEXT NOT NULL,
    "year" INTEGER NOT NULL,

    CONSTRAINT "Song_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Album" ADD CONSTRAINT "Album_artistId_fkey" FOREIGN KEY ("artistId") REFERENCES "Artist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Song" ADD CONSTRAINT "Song_albumId_fkey" FOREIGN KEY ("albumId") REFERENCES "Album"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Song" ADD CONSTRAINT "Song_artistId_fkey" FOREIGN KEY ("artistId") REFERENCES "Artist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
