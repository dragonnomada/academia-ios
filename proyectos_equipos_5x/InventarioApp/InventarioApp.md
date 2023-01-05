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

    
    
## **InventarioLoginDelegate**

```Swift
    /// LoginView
    login(usuarioIniciado: UsuarioEntity)
    loginError(loginError error: String)
```
## **InventarioHomeDelegate**

```Swift
    /// HomeView
    inventario(productos:[(producto: ProductoEntity, transacciones: [TransaccionEntity])])
    inventario(inventarioError error: String)
    inventario(productoSeleccionado producto: ProductoEntity)
```

## **InventarioAddProductDelegate**

```Swift
    /// AddProductView
    inventario(productAdded producto: ProductoEntity)
    inventario(addProductError error: String)
```


## **InventarioDetailsDelegate**

```Swift
    /// DetailsProductView
    inventario(productoSelected producto: ProductoEntity, transacciones: [TransaccionEntity])
    inventario(filterTransactionsError error: String)
    inventario(selectProductError error: String)
```
## **InventarioEditProductDelegate**

```Swift
    /// EditProductView
    inventario(productEditted: ProductoEntity)
    inventario(editError: String)
```

## **InventarioAddEntradaDelegate**

```Swift
    /// AddTransaction
    inventario(productSelected product: ProductoEntity, transacciones: [TransaccionEntity])
    inventario(addTransaccionError error: String)
```
