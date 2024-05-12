const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
  res.send('Server is up and runing');
});


// Start the server
app.listen(port, () => {
  console.log(`Server is listening at http://localhost:${port}`);
});
