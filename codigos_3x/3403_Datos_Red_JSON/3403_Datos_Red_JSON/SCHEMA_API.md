#  Schema API swapi.dev

## https://swapi.dev/api/people

> `SCHEMA JSON`

```json
{
    "count": <<Int>>,
    "next": <<String ~> URL>>,
    "previous": <<String? ~> URL>>,
    "results": [
        {
            "name": <<String>>,
            "height": <<String>>,
            "mass": <<String>>,
            "hair_color": <<String>>,
            "skin_color": <<String>>,
            "eye_color": <<String>>,
            "birth_year": <<String>>,
            "gender": <<String>>,
            "homeworld": <<String ~> URL api/planets/:id>>,
            "films": [
                <<String ~> URL api/films/:id>>
            ],
            "species": [
                <<String ~> URL api/species/:id>>
            ],
            "vehicles": [
                <<String ~> URL api/vehicles/:id>>
            ],
            "starships": [
                <<String ~> URL api/starships/:id>>
            ],
            "created": <<String ~> Date ISO>>,
            "edited": <<String ~> Date ISO>>,
            "url": <<String ~> URL api/people/:id>>
        }
    ]
}
```

> `struct People`

```swift
struct People: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
}
```

> `struct PeopleResponse`

```swift
struct PeopleResponse: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [People]
}
```
