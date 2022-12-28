const express = require("express")

const { signIn } = require("./service")

const router = express.Router()

router.all("/cobrapp/login", (request, response) => {
    const { username, password } = {
        ...request.query,
        ...(request.body || {})
    }

    const user = signIn(username, password)

    if (user) {
        response.send({
            error: false,
            message: "ok",
            user
        })
    } else {
        response.send({
            error: true,
            message: `Invalid user credentials for <${username}>`,
            user: null
        })
    }
})

module.exports = router