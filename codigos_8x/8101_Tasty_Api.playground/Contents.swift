import Foundation
import UIKit
import PlaygroundSupport

//let viewController = MyViewController()

//PlaygroundPage.current.liveView = viewController
//PlaygroundPage.current.needsIndefiniteExecution = true

let headers = [
    "X-RapidAPI-Key": "95d1af3cbfmshdd155205f6b9189p12f614jsn43739ff11b8e",
    "X-RapidAPI-Host": "tasty.p.rapidapi.com"
]

let request = NSMutableURLRequest(url: NSURL(string: "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes&q=chicken")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
request.httpMethod = "GET"
request.allHTTPHeaderFields = headers

let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
    if (error != nil) {
        print(error)
    } else {
        let httpResponse = response as? HTTPURLResponse
        print(httpResponse)
    }
})

dataTask.resume()
