import Vapor

struct Device: NodeRepresentable {
    var name: String
    var date: String
    var url: String

    func makeNode(in context: Context?) throws -> Node {
        return try Node(node: ["name":self.name, "date":self.date, "url":self.url])
    }
}

var devices: [Device] = []

func initData() {
    var datePosted: String {
        return String(Int(Date().timeIntervalSince1970))
    }
    
    let tvInKitchen = Device(name: "TV in Kitchen", date: datePosted, url: "https://multimedia.bbycastatic.ca/multimedia/products/1500x1500/103/10317/10317673.jpg")
    let tvInHallway = Device(name: "TV in Hallway", date: datePosted, url: "https://thegoodguys.sirv.com/products/50046771/50046771_506402.PNG?scale.height=505&scale.width=773&canvas.height=505&canvas.width=773&canvas.opacity=0&format=png&png.optimize=true")
    let tvInLivingRoom = Device(name: "TV in Living Room", date: datePosted, url: "https://cdn2.harveynorman.com.au/media/wysiwyg/buying-guides/tvs-blue-ray-home-theatre/tv/3d-tv/3d-tv-entery-level.jpg")
    let tvInBedroom = Device(name: "TV in Bedroom", date: datePosted, url: "https://www.thegoodguys.com.au/wcsstore/TGGCAS/idcplg?IdcService=GET_FILE&RevisionSelectionMethod=LatestReleased&noSaveAs=1&dDocName=50044402_483423&Rendition=ZOOMIMAGE")
    let tvInRestroom_1 = Device(name: "TV in Restroom №1", date: datePosted, url: "https://images.kogan.com/image/fetch/s--r23MaKmN--/b_white,c_pad,f_auto,h_400,q_auto:good,w_600/https://assets.kogan.com/files/product/TV_Update/KALED49SUHDZA_2_V2.jpg")
    let tvInRestroom_2 = Device(name: "TV in Restroom №2", date: datePosted, url: "https://cdn2.harveynorman.com.au/media/wysiwyg/group-pages/tvs-blue-ray-home-theatre/tvs.jpg")
    let tvInRestroom_3 = Device(name: "TV in Restroom №3", date: datePosted, url: "https://i5.walmartimages.com/asr/c5188693-d149-4408-8d20-3c6fd41cbd53_1.2aa78ff45c4835c675afdb5635522d5d.jpeg")
    let tvInRestroom_4 = Device(name: "TV in Restroom №4", date: datePosted, url: "https://ph-live-01.slatic.net/p/2/ace-32-slim-led-tv-black-led-808-dn4-1480588404-6470273-f633976de5e3472d41cac94343cd8078.jpg")
    let tvInRestroom_5 = Device(name: "TV in Restroom №5", date: datePosted, url: "https://www.zabilo.com/2098/tv-hisense-55-smart-tv-fhd-55k3110.jpg")
    
    devices = [tvInKitchen, tvInHallway, tvInLivingRoom, tvInBedroom, tvInRestroom_1, tvInRestroom_2, tvInRestroom_3, tvInRestroom_4, tvInRestroom_5]
}

extension Droplet {
    func setupRoutes() throws {
        
        get("devices") { req in
            initData()
            
            let jsonOut = try JSON(node: devices)
            let json = JSON(dictionaryLiteral: ("devices", jsonOut))
            
            return json
        }
        
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
