const express = require("express")

const router = express.Router()

const videos = [
    {
        title: "¿Cómo girar una flor?",
        duration: 105,
        url: "https://www.pexels.com/es-es/video/8927748/download/"
    },
    {
        title: "¿Cómo prender una luz?",
        duration: 89,
        url: "https://www.pexels.com/es-es/video/8035714/download/"
    },
    {
        title: "¿Cómo caminar con tu pareja?",
        duration: 72,
        url: "https://www.pexels.com/es-es/video/9871249/download/"
    },
]

router.get("/tutoriapp/videos", (request, response) => {
    response.send(videos)
})

module.exports = router