const products = require("./products")
const { validateUserAndToken } = require("../login/service")

function getProducts() {
    return products
}

function getProductByBrandAndId(brand, id) {
    if (!products[brand]) throw new Error(`Invalid brand <${brand}>`)

    const product = products[brand].find(product => `${product.id}` === id)

    if (!product) throw new Error(`Invalid product <${brand}-${id}>`)

    product.brand = brand

    return product
}

function validateCode(code) {
    if (!(/^[a-z0-9]+\-\d+$/.test(code || ""))) throw new Error(`Invalid code format for <${code}>`)
}

function parseCodeAsBrandAndId(code) {
    validateCode(code)

    const [_, brand, id] = code.match(/^([a-z0-9]+)\-(\d+)$/)
    console.log({ brand, id })
    return { brand, id }
}

function processCode(code, username, token) {
    validateUserAndToken(username, token)

    const { brand, id } = parseCodeAsBrandAndId(code)

    const product = getProductByBrandAndId(brand, id)

    const confirm = "xxxx"

    return {
        product,
        confirm 
    }
}

module.exports = {
    getProducts,
    getProductByBrandAndId,
    validateCode,
    parseCodeAsBrandAndId,
    processCode
}