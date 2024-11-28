const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');

const app = express();

app.use(cors({
    origin: 'http://localhost:3000',
    methods: ['POST'],
    credentials: true
}));

app.use(express.json());

app.post('/convertQuery', (req, res) => {
    const jpaQuery = req.body.jpaQuery;

    exec('./parser', { input: jpaQuery }, (error, stdout, stderr) => {
        if (error) {
            console.error('Parser Error:', stderr || error.message);
            return res.status(500).json({ error: 'Parser execution failed' });
        }

        res.json({ sqlQuery: stdout.trim() });
    });
});

const PORT = 5000;
app.listen(PORT, '192.168.25.201', () => {
    console.log(`Backend server is running on http://192.168.25.201:${PORT}`);
});