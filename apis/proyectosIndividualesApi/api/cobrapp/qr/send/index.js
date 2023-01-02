const express = require("express")

const { processCode } = require("../service")

const router = express.Router()

router.all("/cobrapp/qr/send", (request, response) => {
    const { username, token, code } = {
        ...request.query,
        ...(request.body || {})
    }

    try {
        const { product, confirm } = processCode(code, username, token)
        response.send({
            error: false,
            message: `ok <${code}>`,
            product,
            confirm
        })
    } catch(error) {
        response.send({
            error: true,
            message: `${error}`,
            product: null,
            confirm: ""
        })
    }
})

module.exports = router