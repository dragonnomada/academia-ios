const express = require("express")

const { signIn } = require("./service")

const router = express.Router()

router.all("/cobrapp/login", (request, response) => {
    const { username, password } = {
        ...request.query,
        ...(request.body || {})
    }

    try { 
        const user = signIn(username, password)
        response.send({
            error: false,
            message: "ok",
            user
        })
    } catch (error) {
        response.send({
            error: true,
            message: `${error}`,
            user: null
        })
    }
})

module.exports = router