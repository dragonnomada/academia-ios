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
    var imangen: Data?
    var id: Int?
    var nombre: String?
    var precio: Double?
    var existencia: Int?
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
    login(usuarioSeleccionado: UsuarioEntity)
    loginError(loginError error: String)
```
## **InventarioHomeDelegate**

```Swift
    /// HomeView
    inventario(productos:[(producto: ProductoEntity, transacciones: [TransaccionEntity])])
    inventario(loadInvenatarioError error: String)
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
    inventarioDetails(productoSelected: producto: ProductoEntity, transacciones: [TransaccionEntity])
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
