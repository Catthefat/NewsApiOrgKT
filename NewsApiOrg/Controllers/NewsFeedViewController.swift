//
//  NewsFeedViewController.swift
//  NewsApiOrg
//
//  Created by Arkadijs Makarenko on 19/11/2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var newsItems: [NewsItem] = []
    var searchResult = "apple"
    //#warning("put your newsapi.org apikey here:")
    var apiKey = "3863329280d340fbad3120059c7dc5c4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Apple News"
        handleGetData()
    }

    func handleGetData(){
        let jsonUrl = "https://newsapi.org/v2/everything?q=\(searchResult)&from=2021-11-19&to=2021-11-05&sortBy=popularity&apiKey=\(apiKey)"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: urlRequest) { (dataNews, response, err)  in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            guard let data = dataNews else {
                print(String(describing: err))
                return
            }
            do{
                let jsonData = try JSONDecoder().decode(Articles.self, from: data)
                self.newsItems = jsonData.articles
                DispatchQueue.main.async {
                    print("jsonData", jsonData)
                }
            }catch{
                print("err:", error)
            }
        }.resume()
     //   #warning("complete URLSession(configuration: to print(jsonData of Articles)")
    }
}


