import UIKit
import Combine
import PlaygroundSupport

struct FrutaEntity {
    
    let nombre: String
    let cantidad: Double
    
}

enum FrutaServiceError: Error {
    
    case sinFrutas
    case agregarFrutaCantidadNegativaOCero
    case agregarFrutaNombreVacio
    
}

class FrutaService {
    
    private var frutas: [FrutaEntity] = []
    
    let frutasSubject = PassthroughSubject<(frutas: [FrutaEntity]?, error: FrutaServiceError?), Never>()
    
    let frutaAgregadaSubject = PassthroughSubject<(fruta: FrutaEntity?, error: FrutaServiceError?), Never>()
    
    func requestFrutas() {
        
        guard !self.frutas.isEmpty else {
            
            frutasSubject.send((nil, .sinFrutas))
            
            return
            
        }
        
        frutasSubject.send((self.frutas, nil))
        
    }
    
    func agregarFruta(nombre: String, cantidad: Double) {
        
        guard cantidad > 0 else {
            
            frutaAgregadaSubject.send((nil, .agregarFrutaCantidadNegativaOCero))
            
            return
            
        }
        
        guard !nombre.isEmpty else {
            
            frutaAgregadaSubject.send((nil, .agregarFrutaNombreVacio))
            
            return
            
        }
        
        let fruta = FrutaEntity(nombre: nombre, cantidad: cantidad)
        
        frutas.append(fruta)
        
        frutaAgregadaSubject.send((fruta, nil))
        
    }
    
}

class FrutaInteractor {
    
    private lazy var frutaService: FrutaService = {
        
        let service = FrutaService()
        
        service.agregarFruta(nombre: "Manzana", cantidad: 12)
        service.agregarFruta(nombre: "Mango", cantidad: 5)
        
        return service
        
    }()
    
    lazy var frutasSubject: PassthroughSubject<(frutas: [FrutaEntity]?, error: FrutaServiceError?), Never> = {
        
        return self.frutaService.frutasSubject
        
    }()
    
    lazy var frutaAgregadaSubject: PassthroughSubject<(fruta: FrutaEntity?, error: FrutaServiceError?), Never> = {
        
        return self.frutaService.frutaAgregadaSubject
        
    }()
    
    func requestFrutas() {
        self.frutaService.requestFrutas()
    }
    
    func agregarFruta(nombre: String, cantidad: Double) {
        self.frutaService.agregarFruta(nombre: nombre, cantidad: cantidad)
    }
    
}

class FrutaRouter: NSObject, UINavigationControllerDelegate {
    
    lazy var navigationController: UINavigationController = {
        
        let navigationController = UINavigationController()
        
        navigationController.navigationBar.backgroundColor = .gray
        
        navigationController.delegate = self
        
        return navigationController
        
    }()
    
    let frutaInteractor: FrutaInteractor
    
    var lastView: UIViewController?
    
    // TODO: Presenters
    
    lazy var frutasHomePresenter: FrutasHomePresenter = {
        
        let presenter = FrutasHomePresenter(frutaRouter: self, frutaInteractor: self.frutaInteractor)
        
        // TODO: Configurar el presenter
        
        return presenter
        
    }()
    
    lazy var frutasAddPresenter: FrutasAddPresenter = {
        
        let presenter = FrutasAddPresenter(frutaRouter: self, frutaInteractor: self.frutaInteractor)
        
        // TODO: Configurar el presenter
        
        return presenter
        
    }()
    
    init(frutaInteractor: FrutaInteractor) {
        self.frutaInteractor = frutaInteractor
    }
    
    // TODO: Navegaciones
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let _ = lastView as? FrutasAddViewController {
            
            self.frutasAddPresenter.destroyView()
            
            self.lastView = nil
            
        }
        
        // TODO: Destruir otras vistas
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        self.lastView = viewController
        
    }
    
    func openFrutasHome() {
        
        self.frutasHomePresenter.createView()
        
        if let viewController = self.frutasHomePresenter.view as? FrutasHomeViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func openFrutasAdd() {
        
        self.frutasAddPresenter.createView()
        
        if let viewController = self.frutasAddPresenter.view as? FrutasAddViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    /*func closeFrutasAdd() {
        
        self.frutasAddPresenter.destroyView()
        
        self.navigationController.popViewController(animated: true)
        
    }*/
    
}

class FrutasHomePresenter {
    
    let frutaRouter: FrutaRouter
    
    let frutaInteractor: FrutaInteractor
    
    var view: FrutasHomeView?
    
    var frutasSubcriber: AnyCancellable?
    
    init(frutaRouter: FrutaRouter, frutaInteractor: FrutaInteractor) {
        self.frutaRouter = frutaRouter
        self.frutaInteractor = frutaInteractor
    }
    
    func createView() {
        
        self.view = FrutasHomeViewController()
        
        self.view?.presenter = self
        
        self.frutasSubcriber = frutaInteractor.frutasSubject.sink(receiveValue: {
            
            [unowned self] frutas, error in
            
            if let error = error {
                
                self.view?.frutas(frutasError: error)
                
            }
            
            if let frutas = frutas {
                
                self.view?.frutas(frutas)
                
            }
            
        })
        
    }
    
    func destroyView() {
        
        self.view = nil
        
        self.frutasSubcriber?.cancel()
        self.frutasSubcriber = nil
        
    }
    
    func requestFrutas() {
        
        self.frutaInteractor.requestFrutas()
        
    }
    
    func goToAddFrutas() {
        
        self.frutaRouter.openFrutasAdd()
        
    }
    
}

protocol FrutasHomeView: NSObject {
    
    var presenter: FrutasHomePresenter? { get set }
    
    func frutas(frutasError: FrutaServiceError)
    
    func frutas(_ frutas: [FrutaEntity])
    
}

class FrutasHomeViewController: UIViewController {
    
    weak var presenter: FrutasHomePresenter?
    
    var addFrutaButton: UIButton!
    var tableView: UITableView!
    
    var frutas: [FrutaEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Conformar la vista
        
        self.title = "Frutas Home"
        
        let view = UIView()
        
        self.addFrutaButton = UIButton(frame: CGRect(x: 200, y: 50, width: 200, height: 20))
        
        self.addFrutaButton.setTitle("Agregar fruta", for: .normal)
        self.addFrutaButton.backgroundColor = .black
        self.addFrutaButton.addTarget(self, action: #selector(self.agregarFrutaAction), for: .touchUpInside)
        
        self.tableView = UITableView(frame: CGRect(x: 200, y: 100, width: 250, height: 300))
        
        view.addSubview(self.addFrutaButton)
        view.addSubview(self.tableView)
        
        self.view = view
        
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter?.requestFrutas()
        
    }
    
    @objc func agregarFrutaAction() {
        
        self.presenter?.goToAddFrutas()
        
    }
    
}

extension FrutasHomeViewController: FrutasHomeView {
    
    func frutas(frutasError: FrutaServiceError) {
        print("Error: \(frutasError)")
    }
    
    func frutas(_ frutas: [FrutaEntity]) {
        
        self.frutas = frutas
        
        self.tableView.reloadData()
        
    }
    
}

extension FrutasHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Frutas"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.frutas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
        
        let fruta = self.frutas[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        config.text = fruta.nombre
        config.secondaryText = "\(fruta.cantidad) KG"
        
        cell.contentConfiguration = config
        
        return cell
        
    }
    
}

class FrutasAddPresenter {
    
    let frutaRouter: FrutaRouter
    
    let frutaInteractor: FrutaInteractor
    
    var view: FrutasAddView?
    
    var frutaAgregadaSubscriber: AnyCancellable?
    
    init(frutaRouter: FrutaRouter, frutaInteractor: FrutaInteractor) {
        self.frutaRouter = frutaRouter
        self.frutaInteractor = frutaInteractor
    }
    
    func createView() {
        
        print("Creando FrutasAddViewController")
        
        self.view = FrutasAddViewController()
        
        self.view?.presenter = self
        
        self.frutaAgregadaSubscriber = frutaInteractor.frutaAgregadaSubject.sink(receiveValue: {
            
            [unowned self] fruta, error in
            
            if let error = error {
                
                self.view?.frutas(frutaAgregadaError: error)
                
            }
            
            if let fruta = fruta {
                
                self.view?.frutas(frutaAgregada: fruta)
                
            }
            
        })
        
    }
    
    func destroyView() {
        
        print("Destruyendo FrutasAddViewController")
        
        self.view = nil
        
        self.frutaAgregadaSubscriber?.cancel()
        self.frutaAgregadaSubscriber = nil
        
    }
    
    func agregarFruta(nombre: String, cantidad: Double) {
        
        self.frutaInteractor.agregarFruta(nombre: nombre, cantidad: cantidad)
        
    }
    
}

protocol FrutasAddView: NSObject {
    
    var presenter: FrutasAddPresenter? { get set }
    
    func frutas(frutaAgregadaError: FrutaServiceError)
    
    func frutas(frutaAgregada fruta: FrutaEntity)
    
}

class FrutasAddViewController: UIViewController {
    
    weak var presenter: FrutasAddPresenter?
    
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Conformar la vista
        self.title = "Frutas Add"
        
        let view = UIView()
        
        self.backButton = UIButton(frame: CGRect(x: 200, y: 50, width: 200, height: 20))
        
        self.backButton.setTitle("Regresar", for: .normal)
        self.backButton.backgroundColor = .systemPink
        
        self.backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        view.addSubview(self.backButton)
        
        self.view = view
    }
    
    @objc func backAction() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension FrutasAddViewController: FrutasAddView {
    
    func frutas(frutaAgregadaError: FrutaServiceError) {
        
    }
    
    func frutas(frutaAgregada fruta: FrutaEntity) {
        
    }
    
}

let frutaInteractor = FrutaInteractor()
let frutaRouter = FrutaRouter(frutaInteractor: frutaInteractor)

frutaRouter.openFrutasHome()

PlaygroundPage.current.liveView = frutaRouter.navigationController
