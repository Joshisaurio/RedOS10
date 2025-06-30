import express from 'express';
import path, { dirname } from 'path';
import { fileURLToPath } from 'url';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';

const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
const port = 3000;

//just setting up stuff here
dotenv.config({ path: './private.env' });
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

app.get("/", (req, res) => {
    res.sendFile(`${__dirname}/public/index.html`);
});

app.post("/check", (req, res) => {
    if (String(req.body.password) == String(process.env.PASSWORD)) {
        res.sendFile(`${__dirname}/public/member.html`);
    } else {
        res.redirect("/");
    }
});

app.listen(port, () => {
    console.log("worked");
});