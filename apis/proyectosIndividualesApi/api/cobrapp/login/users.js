const crypto = require("crypto")

module.exports = [
    {
        username: "batman",
        password: "robin123",
        token: crypto.randomUUID()
    },
    {
        username: "superman",
        password: "kriptonita",
        token: crypto.randomUUID()
    },
    {
        username: "spiderman",
        password: "meriyein",
        token: crypto.randomUUID()
    },
]