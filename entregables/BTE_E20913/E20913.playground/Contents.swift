class Robot {
    
    var x: Int = 0
    var y: Int = 0
    
    func moverNorte() {
        self.y += 1
    }
    
    func moverSur() {
        self.y -= 1
    }
    
    func moverEste() {
        self.x += 1
    }
    
    func moverOeste() {
        self.x -= 1
    }
    
    init(x: Int, y: Int){
        if x < 0 || y < 0{
            print("Error al iniciar los valores: Valores negativos")
            return
        }
        self.x = x
        self.y = y
    }
}

let robotina =  Robot(x: -1, y: 0)

print("x: \(robotina.x) y: \(robotina.y)")
