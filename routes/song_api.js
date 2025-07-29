const express = require('express');
const router = express.Router();
const prisma = require('../prisma/prisma');

router.get('/get_all', async (req, res) => {
  try {
    const songs = await prisma.song.findMany({
      include: {
        artist: true,
        album: true
      }
    });
    res.json(songs);
  } catch (error) {
    res.status(500).json({ error: '❌ Error al obtener canciones', details: error.message });
  }
});


module.exports = router;
