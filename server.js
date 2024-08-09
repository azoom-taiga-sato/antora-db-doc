const express = require('express');
const path = require('path');
const app = express();
const port = 8080;

app.use(express.static(path.join(__dirname, 'outputs')));

app.get('/', (req, res) => {
  const jwt = req.header('X-Goog-IAP-JWT-Assertion');
  res.send(`
    <html>
      <body>
        <code>${jwt ? jwt : "No JWT header"}</code>
      </body>
    </html>
  `);
});

app.get('/index', (req, res) => {
  res.sendFile(path.join(__dirname, 'outputs/index.html'));
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});