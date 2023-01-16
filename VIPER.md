# Flujo VIPER

## 1. Definir la clase del *Servicio* (`Entity`)

La entidades generalmente provienen de *CoreData*, *Estructuras* o consumo de *APIs* y se integran en una clase de *servicios* para consumir todas las transacciones posibiles al sistema.

> Ejemplo `TodoEntity`

```swift
struct TodoEntity {

    // Attributes

    var title: String
    var checked: Bool

}
```

Los *servicios* proveen las operaciones hacía los datos y notifican eventos de datos esperados, mediante sujetos de *Combine*.

> Ejemplo `TodoService`

```swift
class TodoService {

    // State

    // TODO: Define propiedades para retener los datos de todas las pantallas

    // Notificators (Subjects)

    // TODO: Define sujetos de Combine para enviar datos y errores del estado a los suscriptores

    // Loaders

    // TODO: Define funciones útiles para cargar los datos iniciales

    // Transactions

    // TODO: Define funciones para hacer operaciones sobre el estado

}
```

## 2. Definir la clase del *Interactor* del servicio (`Interactor`)

El *Interactor* se encarga de consumir los servicios de forma segura, por ejemplo, si hay alguna lógica para consumir una o más transacciones.

> Ejemplo `TodoInteractor`

```swift
class TodoInteractor {

    // Configure Service

    lazy var service: TodoService = {

        let service = TodoService()

        // TODO: Configurar el servicio inicial (cargar datos iniciales)

        return service

    }()

    // Propagate Notificators (Subjects)

    // TODO: Define instancias tipo lazy que propague los notificadores del servicio

    // Operations

    // TODO: Define funciones que propaguen las transacciones del servicio

}
```

## 3. Definir las clases para los *Presentadores* de cada servicio (`Presenter`)

Los *presentadores* contienen una referencia al *ruteador*, una al *interactor*, una la *vista* y una *vista-controlador*. 

Contiene todas las operaciones que puede hacer la vista con el *interactor* y todas las suscripciones de interés para mandarle datos a la vista.

> Ejemplo `TodoHomePresenter`

```swift
class TodoHomePresenter {

    // Router

    weak var router: TodoRouter?

    // Interactor

    weak var interactor: TodoInteractor?

    // View & ViewController

    weak var todoHomeView: TodoHomeView?

    lazy var todoHomeViewController: TodoHomeViewController = {

        let viewController = TodoHomeViewController()

        viewController.presenter = self

        self.view = viewController

        return viewController

    }()

    // Subscribers

    // TODO: Definir los suscriptores (`AnyCancellable?`) que sean de interés en esta pantalla

    // Connect & Disconnect

    // TODO: Define una función `connectInteractor(interactor: TodoInteractor)` y crea las suscripciones (`sink`)

    // TODO: Define una función `disconnectInteractor()` que cancele las suscripciones

    // Operations

    // TODO: Define las funciones para operar con el interactor

}
```

## 4. Definir los protocolos para las *vistas* de cada presentador (`View`)

Las *vistas* son modelos abstractos que definen en un protocolo las funciones usadas por la *vista-controlador* para recibir los datos desde el presenter.

> Ejemplo `TodoHomeView`

```swift
protocol TodoHomeView: NSObject {

    func todos(todosCargados todos: [TodoEntity])

    func todos(todosSeleccionado todo: TodoEntity, index: Int)

}
```

## 5. Definir las clases para los *vista-controlador* de cada presentador (`View`)

Los *vista-controlador* son los `UIViewController` que depliegan la vista `.xib` y conectan los controles finales que verá el usuario.

```swift
class TodoHomeViewController: UIViewConroller {

    // Presenter

    weak var presenter: TodoHomePresenter?

    // Outlets

    // TODO: Configura los `@IBOutlet` necesarios

    // Actions

    // TODO: Configura los `@IBActions` necesarios

}

extension TodoHomeViewController: TodoHomeView {

    // TODO: Implementa los métodos del protocolo

    func todos(todosCargados todos: [TodoEntity]) {
        ...
    }

    func todos(todosSeleccionado todo: TodoEntity, index: Int) {
        ...
    }

}
```

## 6. Definir la clase del *Ruteador* (`Router`)

El *ruteador* es responsable de las instancias para las vistas, el interactor y los métodos de navegación.

> Ejemplo `TodoRouter`

```swift
class TodoRouter {

    // NavigationController

    lazy var navigationController: UINavigationController = {
        
        // TODO: Define una instancia tipo lazy de `UINavigationController` ya configurada y devuélvela
    
    }()

    // Interactor

    // TODO: Define una instancia tipo lazy de `TodoInteractor`, ya configurada y devuélvela

    // Presenters

    // TODO: Define una instancia del tipo lazy para cada `Presenter`

    // Navigations methods

    // TODO: Define las funciones para la navegación entre pantallas

}
```

## 7. Consumir el el *Ruteador* en `SceneDelegate` y cargar la pantalla principal

El *SceneDelegate* retendrá una instancia del *ruteador* y abrirá la pantalla principal

> Ejemplo `SceneDelegate`

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var router: TodoRouter = {
        
        // TODO: Crea una instancia de `TodoRouter`, ya configurada y devuélvela
        
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        ...
        
        self.window?.rootViewController = self.router.navigationController
        
        self.window?.makeKeyAndVisible()
        
        // TODO: Abre la pantalla principal desde el router
        self.router.openHome()
        
    }

    ...

}
```
