const users = require("./users")

function signIn(username, password) {
    let user = users.find(user => 
        user.username === username && 
        user.password === password
    )

    if (user) return {
        ...user,
        password: "******"
    }

    return null
}

module.exports = {
    signIn
}