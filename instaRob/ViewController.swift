//
//  ViewController.swift
//  instaRob
//
//  Created by Дмитрий Станкевич on 1.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - View
    
    let imageView = UIImageView()
    let infoLable = UILabel()
    let randomButton = UIButton()
    
    var refreshCount = 0 {
        willSet {
            self.infoLable.text = "Refresh count: " + String(self.refreshCount)
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray4
        self.imageView.backgroundColor = .white
        
        self.setupImageView()
        self.setupRandomButton()
        self.setupInfoLable()
        self.setupConstraits()
        // Do any additional setup after loading the view.
    }

    
    //MARK: - Setup
    
    private func setupImageView() {
        self.view.addSubview(imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.backgroundColor = .white
        self.imageView.layer.cornerRadius = 15
    }
    
    
    private func setupInfoLable() {
        self.view.addSubview(infoLable)
        self.infoLable.translatesAutoresizingMaskIntoConstraints = false
        self.infoLable.text = "Refresh count: 0"
        self.infoLable.textAlignment = .center
        self.infoLable.font = UIFont.boldSystemFont(ofSize: 20)
        self.infoLable.lineBreakMode = .byWordWrapping
        self.infoLable.numberOfLines = 0
    }
    
    private func setupRandomButton() {
        self.view.addSubview(randomButton)
        self.randomButton.translatesAutoresizingMaskIntoConstraints = false
        self.randomButton.backgroundColor = .systemBlue
        self.randomButton.setTitle("Refresh", for: .normal)
        self.randomButton.setTitleColor(.white, for: .normal)
        self.randomButton.layer.cornerRadius = 15
        
        self.randomButton.addTarget(buttonTupped(), action: #selector(buttonTupped), for: .touchUpInside)
    }
    
    //MARK: - Network
    
    private func takeImage (apiUrl: String) {
        
        var apiImage = UIImage()
        
        let session = URLSession.shared
        let url1 = URL(string: apiUrl + String(refreshCount) + "jpg?set=set4")!
        session.dataTask(with: url1) {data, response, error in
            guard let tempData = data else {return}
            
            apiImage = UIImage(data: tempData)!
            
            DispatchQueue.main.async {
                self.imageView.image = apiImage
            }
            
        }.resume()
        
     
        
    }
    
    //MARK: - Constrains
    
    private func setupConstraits () {
        
        NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
                                     imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                                     infoLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70),
                                     infoLable.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                                     randomButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                                     randomButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                                     randomButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70)
                                    ])
    }
    
    //MARK: - Actions
    
    @objc private func buttonTupped() {
        refreshCount += 1
        self.takeImage(apiUrl: "https://robohash.org/")
        
        
    }

}

