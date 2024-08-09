const express = require('express');
const path = require('path');
const app = express();
const port = 8080;

app.use(express.static(path.join(__dirname, 'outputs')));

app.get('/index', (req, res) => {
  res.sendFile(path.join(__dirname, 'outputs/index.html'));
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});