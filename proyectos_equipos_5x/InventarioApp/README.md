# InventarioAPP

## Login View

![Login View](https://github.com/dragonnomada/academia-ios/blob/main/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Login%20Vista%201.png)

---


## Home View

![Home View](https://github.com/dragonnomada/academia-ios/blob/main/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Home.png)

## Add Product View 

![Add Product View](https://github.com/dragonnomada/academia-ios/blob/main/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Agregar%20Producto.png)

## Show Gallery

![Show Gallery](https://github.com/dragonnomada/academia-ios/blob/inventariapp-dev-eduardo/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Galleria.png)

---

## Add Image Gallery 

![Add Image Gallery](https://github.com/dragonnomada/academia-ios/blob/inventariapp-dev-eduardo/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Agregar%20Producto%20Galeria.png)

---



## Details Product View 

![Detail Product View](https://github.com/dragonnomada/academia-ios/blob/main/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Detalles%20del%20producto.png)

---



## Edit Product View

![Edit Product View](https://github.com/dragonnomada/academia-ios/blob/main/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Editar%20Producto.png)

---



## Add Transaction View

![Add Transaction View](https://github.com/dragonnomada/academia-ios/blob/main/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Agregar%20Transacción.png)

---



## Alert Error add Transaction

![alert Error](https://github.com/dragonnomada/academia-ios/blob/inventariapp-dev-eduardo/proyectos_equipos_5x/InventarioApp/viewInventarioApp/Alert.png)

---


# **Inventario App MVC**
## **Model**
```Swift
// Usuario
struct UsuarioEntity {
    var nombre: String?
    var password: String?
}
```
```Swift
// Producto
struct ProductoEntity {
    var imange: Data?
    var id: Int?
    var nombre: String?
    var precio: Double?
    var existencias: Int?
}
```
```Swift
//Transaccion
struct TransaccionEntity {
    var producto: ProductoEntity?
    var entrada: Bool?
    var unidades: Int?
    var balance: Int?
}
```

```Swift
// Usuario
class InventarioAppModel {
    let container: NSPersistentContainer
    var productSelected: ProductEntity?
    var ...
}
```



## **Controller**

```Swift
    /// LoginView
    getUsuario(nombre: String, password: String) 
    
    /// HomeView
    getAllproducts()
    selectProducto(index: Int)
    
    /// AddProductView
    addProduct(nombre: String, imagen: Data, precio: Double) 
    
    /// DetailsProductView
    getSelectedProduct()
    filterSelectedProductTransactions()
    
    /// EditProductView
    editProduct(nombre: String, imagen: Data, precio: Double)
    
    /// AddTransaction
    addSelectedProductTransaccion(entrada: Bool, unidades: Int, Balance: Int) 
```

    
    
## **InventarioDelegate**

```Swift

 /// LoginView
protocol InventarioLoginDelegate {
    
    func login(usuarioIniciado: UsuarioEntity)
    
    func loginError(loginError error: String)
    
}

/// HomeView
protocol InventarioHomeDelegate {
    
    func inventario(productos:[(producto: ProductoEntity, transacciones: [TransaccionEntity])])
    
    func inventario(inventarioError error: String)
    
    func inventario(productoSeleccionado producto: ProductoEntity)
    
}

 /// AddProductView
protocol InventarioAddProductDelegate {
    func inventario(productAdded producto: ProductoEntity)
    func inventario(addProductError error: String)
}

 /// DetailsProductView
protocol InventarioDetailsDelegate {
    func inventario (productoSelected producto: ProductoEntity, transacciones: [TransaccionEntity])
    func inventario(filterTransactionsError error: String)
    func inventario(selectProductError error: String)
}

 /// EditProductView
protocol InventarioEditProductDelegate {
    func inventario(productLoaded: ProductoEntity)
    func inventario(productEditted: ProductoEntity)
    func inventario(editError: String)
}

/// AddTransaction
protocol InventarioAddEntradaDelegate {
    func inventario(transaccionCreada transaccion: TransaccionEntity)
    func inventario(productSelected product: ProductoEntity)
    func inventario(addTransaccionError error: String)
}

   
```

