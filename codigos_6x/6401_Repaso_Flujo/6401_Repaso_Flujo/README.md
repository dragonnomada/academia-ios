# Flujo MVVM (sin singletones)

## Paso 1 - Definir el Modelo

El modelo es una clase retiene los datos que serán utilizados por diferentes vistas.

> Ejemplo

```swift
import CoreData
import Combine

class FrutasModel {

    lazy var container: NSPersistentContainer = { ... }()

    @Published var frutas: [FrutaEntity] = []
    @Published var frutaSeleccionada: FrutaEntity?
    ...

    func addFruta(fruta: FrutaEntity) { ... }
    func updateFruta(name: String?, ...) { ... }
    func selectFruta(byId id: Int) { ... }
    ...

}
``` 

## Paso 2 - Definir la Vista

La vista es un protocolo que notifica datos que provienen desde el vista-modelo.

> Ejemplo

```swift
protocol FrutasHomeView: NSObject {

    func frutas(frutas: [FrutaEntity])
    func frutas(frutaSeleccionada fruta: FrutaEntity)
    func frutas(frutaAgregada fruta: FrutaEntity)
    ...

}
```

## Paso 3 - Definir la Vista-Modelo

La vista-modelo es una clase que permite comunicar uno o más modelos a una **única** vista.

> Ejemplo

```swift
import Combine

class FrutasHomeViewModel {

    weak var model: FrutasModel?
    weak var view: FrutasHomeView?
    
    var frutasSubscriber: AnyCancellable?
    ...
    
    init(model: FrutasModel) {
        
        self.model = model
        
        self.frutasSubscriber = model.$frutas.sink {
            [weak self] frutas in
            
            self?.view?.frutas(frutas: frutas)
            
        }
        
        // (otros suscriptores)
        
    }
    
    func seleccionarFruta(id: Int) {
        self.model?.selectFruta(byId: id)
    }

}
```

## Paso 4 - Enlazar el ViewController al Vista-Modelo

El *ViewController* es una clase que representa una pantalla con controles como labels, botones, tablas, etc. Es encargado de configurar los @IBOutlets e @IBActions de los controles y garantizar la vista final al usuario.

> Ejemplo

```swift
class FrutasHomeViewController: UIViewController {

    weak var viewModel: FrutasHomeViewModel?

    @IBOutlet weak var frutasTableView: UITableView!
    
    var frutas: [FrutaEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = self.viewModel {
            viewModel.view = self
        }
        
        self.frutasTableView.dataSource = self
        self.frutasTableView.delegate = self
        
    }

}

extension FrutasHomeViewController: FrutaHomeView {

    func frutas(frutas: [FrutaEntity]) {
        self.frutas = frutas
        self.frutasTableView.reloadData()
    }
    
    ...

}

extension FrutasHomeViewController: UITableViewDataSource {
    ...
}

extension FrutasHomeViewController: UITableViewDelegate {
    ...
}
```

## Paso 5 - Creamos una instancia del Modelo y la Vista-Modelo en SceneDelegate

El SceneDelegate es una clase que controla la ventana principal y todas sus pantallas. A través de la ventana podemos asignarle/crearle/proporcionale una pantalla principal o podemos recuperar/obtener alguna pantalla ya creada desde el *storyboard*.

En el *SceneDelegate* podremos instanciar un modelo, un vista-modelo, o lo que haga falta que utilice alguna pantalla. Entonces, podemos recuperar la pantalla para configurar su vista-modelo (es decir, pasarle la instancia al vista-modelo).

> Ejemplo

```swift

class SceneDelegate: ..., UINavigationControllerDelegate {

    var window: UIWindow?
    
    private lazy var model: FrutasModel() = {
        let model = FrutasModel()
        // TODO: Configurar el modelo
        model.loadFrutas()
        return model
    }()
    
    private lazy var homeViewModel: FrutasHomeViewModel = {
        let viewModel = FrutasHomeViewModel(model: self.model)
        // TODO: Configurar el vista-modelo
        if let primerFruta = self.model.frutas.first {
            viewModel.seleccionarFruta(byId: primerFruta.id)
        }
        return viewModel
    }() 
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let frutasHomeViewController = viewController as? FrutasHomeViewController {
            frutasHomeViewController.viewModel = self.homeViewModel
        }
        
        /*if let frutasHomeViewController = viewController as? FrutasHomeViewController {
            frutasHomeViewController.viewModel = self.homeViewModel
        }*/
        
        ...
        
    }

    func scene(_ scene: UIScene, ...) {
    
        guard ...
        
        // TODO: Recuperar la pantalla (el ViewController)
        if let frutasHomeViewController = self.window?.rootViewController as? FrutasHomeViewController {
        
            // TODO: Configurar a la pantalla su vista-modelo
            frutasHomeViewController.viewModel = self.homeViewModel 
        
        }
        
        // TODO: Alternativamente si tenemos UINavigationController
        if let navigationController = self.window?.rootViewController as? UINavigationController {
            
            navigationController.delegate = self
            
        }
    
    }

}

```
