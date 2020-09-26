//
//  PlacesViewController.swift
//  PlacesApp
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController {
    
    let placeFetcher = PlaceFetcher() // model
    let placesTableView = UITableView() // view

    private var places:[PlaceInfo] = [PlaceInfo]()
    private var imageLoader = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()

        //Fetch all the feeds and update tableview once the list is received.
        placeFetcher.fetchallPlaces { [weak self] (placeInfo, title) in
            //Filter the feeds if any title comes as null
            self?.places = placeInfo.filter({$0.title != nil})
            DispatchQueue.main.async {
                self?.navigationItem.title = title
                self?.placesTableView.reloadData()
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(placesTableView)
        
        placesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        placesTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
        placesTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
        placesTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
        placesTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        placesTableView.estimatedRowHeight = 44.0

        placesTableView.dataSource = self
        placesTableView.delegate = self
        placesTableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "placeCell")

    }
}

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return places.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
        
        cell.placeInfo = places[indexPath.row]
        //set the default placeholder image
        cell.titleImageView.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
        cell.titleImageView.tintColor = .label

        if let imageUrlString = cell.placeInfo?.imageHref{
            let imageUrl:URL = URL(string: imageUrlString)!
            
            imageLoader.loadTitleImage(imageUrl) { result in
                do {
                    let image = try result.get()
                    // Update the titleImageview
                    DispatchQueue.main.async{
                        cell.titleImageView.image = image
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        return cell
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }

}
