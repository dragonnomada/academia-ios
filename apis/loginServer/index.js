const http = require("http")
const express = require("express")
const cors = require("cors")

const app = express()

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const usuarios = [
    {
        id: 1,
        correo: "batman@ligajusticia.com",
        contraseña: "robin123"
    },
    {
        id: 2,
        correo: "superman@ligajustica.com",
        contraseña: "kriptonita123"
    },
    {
        id: 3,
        correo: "guason@gotica.com",
        contraseña: "joker123"
    }
]

app.get("/login", (request, response) => {
    const { email, password } = request.query

    console.log(request.query)

    const [usuario] = usuarios.filter(usuario => usuario.correo === email && usuario.contraseña === password)

    if (usuario) {
        response.send({
            error: false,
            mensaje: "ok",
            usuario
        })
    } else {
        response.send({
            error: true,
            mensaje: `Credenciales no válidas para el usuario con correo ${email}`,
            usuario: null
        })
    }
})

const server = http.createServer(app)

server.listen(80, "0.0.0.0", () => {
    console.log("Servidor iniciado en http://0.0.0.0:80/")
})