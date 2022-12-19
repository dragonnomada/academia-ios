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
        self.x = x
        self.y = y
    }
}
