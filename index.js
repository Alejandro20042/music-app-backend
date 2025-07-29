const express = require('express');
const cors = require('cors');
require('dotenv').config();
const songsRoutes = require('./routes/song_api');
const testRoutes = require('./routes/test_api');

const app = express();
app.use(cors());
app.use(express.json());

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('API funcionando');
});

app.use('/api/songs', songsRoutes);
app.use('/api/test', testRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});