# Todo App MVC

## Model

> `TodoEntity`

```swift
struct TodoEntity {
	let title: String?
	let checked: Bool
	let createAt: Date?
	let updateAt: Date?
} 
```

> `TodoModel`

```swift
import CoreData

class TodoModel {

	let container: NSPersistentContainer // = ...

	var todoSelected: TodoEntity?

	var todos: [TodoEntity] // = []

	/// Carga los `todos` desde el CoreData
	func loadTodos() {
		// 1. Recupera el contexto
		// 2. Crea un request de `TodoEntity`
		// 3. Haz un fetch en el contexto
		// 4. Actualiza los `todos`
		// 5. devuélvelos
	}

	/// Devuelve los `todos`
	func getTodos() -> [TodoEntity] {
		// ...
	}

	/// Agrega un nuevo `TodoEntity` con valores
	/// por defecto y guarda el contexto 
	/// del contenedor
	func addTodo(title: String) -> TodoEntity? {
		// ...
	}
	
	/// Busca el `todo` en los `todos` con ese
	/// índice y guárdalo en todoSelected`
	func selectTodo(index: Int) -> TodoEntity? {
		// ...
	}

	/// Recupera el `todoSelected` y actualiza
	/// los valores si no son *nil*
	func editSelectedTodo(title: String?, checked: Bool?) -> TodoEntity? {
		// ...
	} 

}
```

## Controller

> `TodoController`

```swift
class TodoController {
	
	static let shared = TodoController()
	
	let model = TodoModel()
	
	var homeDelegate = TodoHomeDelegate?
	var addDelegate = TodoAddDelegate?
	var detailsDelegate = TodoDetailsDelegate?
	
	func getTodos() 
	func selectTodo(index: Int)
	func addTodo(title: String)
	func editTodo(title: String?, checked: Bool?)
	
}
``` 

> `TodoHomeDelegate`

```swift
protocol TodoHomeDelegate {

	func todo(todosUpdated todos: [TodoEntity])
	func todo(todosLoadError error: String)

}
```

> `TodoAddDelegate`

```swift
protocol TodoAddDelegate {

	func todo(todoCreated todo: TodoEntity
	func todo(todoCreateError error: String)

}
```

> `TodoEditDelegate`

```swift
protocol TodoEditDelegate {

	func todo(todoEdited todo: TodoEntity)
	func todo(todoEditError error: String)

}
```

## Views

> `TodoHomeViewController`

```swift
import UIKit

class TodoHomeViewController: UIViewController {

	var todos: [TodoEntity] // = []

	@IBOutlet weak var todosTableView: UITableView!

	/// Conectar esta vista como delegado
	/// TodoController.shared.homeDelegate = self
	func viewDidLoad()

	/// TodoController.shared.getTodos()
	func viewWillAppear()

}

extension TodoHomeViewController: UITableViewDataSource {

	// TODO: Implementa los métodos del UITableViewDataSource

}

extension TodoHomeViewController: TodoHomeDelegate {
	
	/// Actualiza los `todos` de esta vista
	/// Recarga los datos en la tabla
	func todo(todosUpdated todos: [TodoEntity])
	
}
```

