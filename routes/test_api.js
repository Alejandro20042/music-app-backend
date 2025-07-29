const express = require('express');
const router = express.Router();
const prisma = require('../prisma/prisma');
const axios = require('axios');

// Función para obtener las canciones desde la API externa
async function fetchSongs() {
  const { data } = await axios.get('https://api-musica.netlify.app/api/canciones');
  return data.data; // Array de canciones
}

router.get('/fill_tables', async (req, res) => {
  try {
    const data = await fetchSongs();

    const artistasMap = new Map();
    const albumsMap = new Map();
    const cancionesData = [];

    data.forEach(item => {
      const artista = item.artistaCompleto;
      const album = item.albumCompleto;

      // Insertar artista si no está ya mapeado
      if (!artistasMap.has(artista.nombre)) {
        artistasMap.set(artista.nombre, {
          name: artista.nombre,
          nacionality: artista.nacionalidad || '',
          genere: artista.genero || '',
          formation_year: artista.añoFormacion || 0,
          biography: artista.biografia || '',
          image_url: artista.imagen || ''
        });
      }

      // Insertar álbum si no está ya mapeado
      if (!albumsMap.has(album.titulo)) {
        albumsMap.set(album.titulo, {
          title: album.titulo,
          // artistId lo agregamos después porque necesitamos el ID generado
          launch_year: album.añoLanzamiento || 0,
          genere: album.genero || '',
          total_duration: album.duracionTotal || '',
          tracks_number: album.numeroTracks || 0,
          cover: album.portada || '',
          description: album.descripcion || '',
          seal: album.sello || '',
          producer: album.productor || '',
          artistName: artista.nombre // Temporal, para hacer el match luego
        });
      }

      // Guardar datos para canción (relaciones se completan después)
      cancionesData.push({
        title: item.titulo,
        duration: item.duracion,
        track: item.pista,
        lyrics: item.letra,
        composer: item.compositor,
        year: item.año,
        albumTitle: album.titulo,     // temporal
        artistName: artista.nombre    // temporal
      });
    });

    // Insertar artistas
    const insertedArtists = await Promise.all(
      Array.from(artistasMap.values()).map(artista =>
        prisma.artist.upsert({
          where: { name: artista.name },
          update: {},
          create: artista
        })
      )
    );

    // Relacionar artistaId con nombre
    const artistIdMap = new Map();
    insertedArtists.forEach(a => artistIdMap.set(a.name, a.id));

    // Insertar álbumes con el artistId correcto
    const insertedAlbums = await Promise.all(
      Array.from(albumsMap.values()).map(album => {
        const { artistName, ...albumData } = album; // 👈 quitar artistName

        return prisma.album.upsert({
          where: { title: album.title },
          update: {},
          create: {
            ...albumData,
            artistId: artistIdMap.get(artistName)
          }
        });
      })
    );


    // Relacionar albumId con título
    const albumIdMap = new Map();
    insertedAlbums.forEach(al => albumIdMap.set(al.title, al.id));

    // Insertar canciones con albumId y artistId correctos
    await Promise.all(
      cancionesData.map(cancion =>
        prisma.song.upsert({
          where: {
            title_albumId: {
              title: cancion.title,
              albumId: albumIdMap.get(cancion.albumTitle)
            }
          },
          update: {},
          create: {
            title: cancion.title,
            duration: cancion.duration,
            track: cancion.track,
            lyrics: cancion.lyrics,
            composer: cancion.composer,
            year: cancion.year,
            albumId: albumIdMap.get(cancion.albumTitle),
            artistId: artistIdMap.get(cancion.artistName)
          }
        })
      )
    );

    res.status(200).json({
      message: '✅ Tablas llenadas correctamente',
      artists: insertedArtists.length,
      albums: insertedAlbums.length,
      songs: cancionesData.length
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: '❌ Error al llenar las tablas', details: error.message });
  }
});

module.exports = router;
