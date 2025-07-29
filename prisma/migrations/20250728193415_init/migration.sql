-- CreateTable
CREATE TABLE "Artista" (
    "id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "nacionalidad" TEXT NOT NULL,
    "genero" TEXT NOT NULL,
    "añoFormacion" INTEGER NOT NULL,
    "biografia" TEXT NOT NULL,
    "imagen" TEXT NOT NULL,

    CONSTRAINT "Artista_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Album" (
    "id" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "artistaId" INTEGER NOT NULL,
    "añoLanzamiento" INTEGER NOT NULL,
    "genero" TEXT NOT NULL,
    "duracionTotal" TEXT NOT NULL,
    "numeroTracks" INTEGER NOT NULL,
    "portada" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "sello" TEXT NOT NULL,
    "productor" TEXT NOT NULL,

    CONSTRAINT "Album_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cancion" (
    "id" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "albumId" INTEGER NOT NULL,
    "artistaId" INTEGER NOT NULL,
    "duracion" TEXT NOT NULL,
    "pista" INTEGER NOT NULL,
    "letra" TEXT NOT NULL,
    "compositor" TEXT NOT NULL,
    "año" INTEGER NOT NULL,

    CONSTRAINT "Cancion_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Album" ADD CONSTRAINT "Album_artistaId_fkey" FOREIGN KEY ("artistaId") REFERENCES "Artista"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cancion" ADD CONSTRAINT "Cancion_albumId_fkey" FOREIGN KEY ("albumId") REFERENCES "Album"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cancion" ADD CONSTRAINT "Cancion_artistaId_fkey" FOREIGN KEY ("artistaId") REFERENCES "Artista"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
