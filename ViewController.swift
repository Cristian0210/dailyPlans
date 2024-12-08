//
//  ViewController.swift
//  AppNews
//
//  Created by Cristian Vangheli on 2/2/23.
//

import UIKit

// MARK: - Creamos la structura

struct NoticiasModelo: Codable {
    var articles: [Noticia]
    
}
    struct Noticia: Codable {
        let title: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        
    }
 
// MARK: - Creamos las clase y la variable

class ViewController: UIViewController {
    
    var articuloNoticias: [Noticia] = []
    
    

// MARK: - Conectamos el UItableView y le damos las funciones
    
    
    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        buscarNoticias()
        
    }

//MARK: - Creamos la funcion para conectar la URL con la informacion
    
    
    func buscarNoticias() {
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        if let url = URL(string: urlString) {
            if let data = try? Data( contentsOf: url){
                let decodificador = JSONDecoder()
                
                if let datosDecodificados = try? decodificador.decode(NoticiasModelo.self, from: data){
                    
                    articuloNoticias = datosDecodificados.articles
                    tablaNoticias.reloadData()
                }
            }
        }
    }
}

//MARK: - Creamos la extencion y la funcion


extension ViewController: UITableViewDelegate,  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articuloNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celdaNoticia", for: indexPath)
        celda.textLabel?.text = articuloNoticias[indexPath.row].title
        celda.detailTextLabel?.text = articuloNoticias[indexPath.row].description
        
        return celda
        
    }
    
    
}

