const http = require("http")

const express = require("express")
const cors = require("cors")

const app = express()

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.use("/api/", require("./api/tutoriapp/videos"))
app.use("/api/", require("./api/cobrapp/login"))

const server = http.createServer(app)

server.listen(80, () => {
    console.log("Academia IOS - API de Proyecto Individuales")
})