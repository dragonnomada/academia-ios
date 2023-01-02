const users = require("./users")

function signIn(username, password) {
    let user = users.find(user => 
        user.username === username && 
        user.password === password
    )

    if (!user) throw `Invalid user credentials for <${username}>`

    return {
        ...user,
        password: "******"
    }
}

function validateUserAndToken(username, token) {
    let user = users.find(user => 
        user.username === username && 
        user.token === token
    )

    if (!user) throw `Invalid user token for ${username}`
}

module.exports = {
    signIn,
    validateUserAndToken
}