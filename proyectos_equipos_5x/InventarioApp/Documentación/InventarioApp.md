**Controller**
    // let productSelected

    // LoginView
    getUsuario(nombre: String, password: String) // Verifica usuario en el Modelo
    
    // HomeView
    getAllproducts()
    selectProducto(index: Int)
    
    // AddProductView
    addProduct(nombre: String, imagen: Data, precio: Double) // Agrega Producto
    
    // DetailsProductView
    getSelectedProduct()
    filterSelectedProductTransactions()
    
    // EditProductView
    editProduct(nombre: String, imagen: Data, precio: Double)
    
    // AddTransaction
    addSelectedProductTransaccion(entrada: Boolean, unidades: Int, Balance: Int) // Agrega Transaccion
    
    
    
**InventarioLoginDelegate**
    login(usuarioSeleccionado: UsuarioEntity)
    loginError(loginError error: String)

**InventarioHomeDelegate**
    inventario(productos:[(producto: ProductoEntity, transacciones: [TransactionEntity])])
    inventario(loadInvenatarioError error: String)

**InventarioAddProductDelegate**
    inventario(productAdded producto: ProductoEntity)
    inventario(addProductError error: String)

**InventarioDetailsDelegate**
    inventarioDetails(productoSelected: producto: ProductoEntity, transacciones: [TransactionEntity])
    inventario(filterTransactionsError error: String)
    inventario(selectProductError error: String)

**InventarioEditProductDelegate**
    inventario(productEditted: ProductoEntity)
    inventario(editError: String)

**InventarioAddEntradaDelegate**
    inventario(productSelected product: ProductoEntity, transacciones: [TransactionEntity])
    inventario(addTransactionError error: String)

    extension Vista: IndeAppDEle {
        inventario(productAdded producto: ProductoEntity){
          dismiss  
        }
    }