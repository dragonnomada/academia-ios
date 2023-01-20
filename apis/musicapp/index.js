const http = require("http")
const express = require("express")
const cors = require("cors")

const app = express()

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.get("/api/musicapp/songs", (request, response) => {
    response.send(require("./songs.json"))
})

const server = http.createServer(app)

server.listen(80, "0.0.0.0", () => {
    console.log("Server started at http://0.0.0.0:80/")
})