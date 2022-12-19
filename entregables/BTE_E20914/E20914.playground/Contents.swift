struct Producto {
    private let id: Int
    init(id: Int){
        self.id = id
    }
}
let galleta = Producto(id: 10)

// NO ES POSIBLE ACCEDER A LA PROPIEDAD ID
print(galleta.id)
