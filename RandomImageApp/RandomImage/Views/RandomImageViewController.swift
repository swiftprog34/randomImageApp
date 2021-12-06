//
//  RandomImageViewController.swift
//  RandomImageApp
//
//  Created by Виталий Емельянов on 25.11.2021.
//

import UIKit
import CoreData

class RandomImageViewController: UIViewController {
//MARK: initialize params
    let randomImage: UIImageView = {
        let imageView = UIImageView(image: .none)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
     
    var presenter: RandomImagePresenterProtocol!
    
    var timer: Timer?
    
    var secondsRemaining = 10
    
    let randomImageCreatedAtLabel: UILabel = {
        let randomImageCreatedAtLabel = UILabel()
        randomImageCreatedAtLabel.text = "Created at: pending"
        return randomImageCreatedAtLabel
    }()
    let randomImageWidthLabel: UILabel = {
        let randomImageWidthLabel = UILabel()
        randomImageWidthLabel.text = "Width: pending"
        return randomImageWidthLabel
    }()
    let randomImageHeightLabel: UILabel = {
        let randomImageHeightLabel = UILabel()
        randomImageHeightLabel.text = "Height: pending"
        return randomImageHeightLabel
    }()
    let randomImageColorLabel: UILabel = {
        let randomImageColorLabel = UILabel()
        randomImageColorLabel.text = "Color: pending"
        return randomImageColorLabel
    }()
    let randomImageUserOwnerLabel: UILabel = {
        let randomImageUserOwnerLabel = UILabel()
        randomImageUserOwnerLabel.text = "Owner: pending"
        return randomImageUserOwnerLabel
    }()
    
    let addToFavoriteimagesButton: UIButton = {
        let loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("Add to favorite images", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 5.0
        return loginButton
    }()
    
    let timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textAlignment = .center
        return timerLabel
    }()
    
    var imageInfoId: String? = .none
    
//MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureSecondsRemainingText(secondsRemaining: secondsRemaining)
        
        self.view.addSubview(randomImage)
        self.view.addSubview(timerLabel)
        self.view.addSubview(randomImageCreatedAtLabel)
        self.view.addSubview(randomImageWidthLabel)
        self.view.addSubview(randomImageHeightLabel)
        self.view.addSubview(randomImageColorLabel)
        self.view.addSubview(randomImageUserOwnerLabel)
        self.view.addSubview(addToFavoriteimagesButton)
        
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "favorites", style: .plain, target: self, action: #selector(willOpenFavoriteImages))
        self.navigationItem.backButtonTitle = "Random image"
        self.navigationItem.titleView = timerLabel
        self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        self.addToFavoriteimagesButton.addTarget(self, action: #selector(didTapAddToFavoritesButton), for: .touchUpInside)
        
        getRandomImage()

    }

//MARK: Add to favorites action
    @objc func willOpenFavoriteImages() {
        navigationController?.pushViewController(FavoriteImagesViewController(), animated: true)
    }
    
    @objc func didTapAddToFavoritesButton(sender: UIButton!){
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.context
        let newFavoriteImage = FavoriteImage(context: context)
        
        if let infoId = imageInfoId {
            
            let fetch = NSFetchRequest<FavoriteImage>(entityName: "FavoriteImage")
            let predicate = NSPredicate(format: "id = %@", argumentArray: [infoId]) // Specify your condition here
            fetch.predicate = predicate
            do {
              let result = try context.fetch(fetch)
                if result.isEmpty {
                    newFavoriteImage.id = infoId
                    appDelegate.saveContext()
                    print(infoId)
                    let alert = UIAlertController(title: "Success", message: "Current image has been added to favorites.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Fail", message: "Current image already has been added to favorites.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            } catch {
                print("Fail")
            }
        }
        
        

    }
    
//MARK: View will layout subviews
    override func viewWillLayoutSubviews() {
        anchorsConfiguration()
    }
    
    
//MARK: Anchors configuration
    func anchorsConfiguration() {
        randomImage.translatesAutoresizingMaskIntoConstraints = false
        randomImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        randomImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        randomImage.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        randomImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        
        addToFavoriteimagesButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoriteimagesButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        addToFavoriteimagesButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        addToFavoriteimagesButton.topAnchor.constraint(equalTo: self.randomImage.bottomAnchor, constant: 16).isActive = true
        
        randomImageCreatedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        randomImageCreatedAtLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        randomImageCreatedAtLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        randomImageCreatedAtLabel.topAnchor.constraint(equalTo: self.addToFavoriteimagesButton.bottomAnchor, constant: 8).isActive = true
        
        randomImageWidthLabel.translatesAutoresizingMaskIntoConstraints = false
        randomImageWidthLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        randomImageWidthLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        randomImageWidthLabel.topAnchor.constraint(equalTo: self.randomImageCreatedAtLabel.bottomAnchor, constant: 8).isActive = true
        
        randomImageHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        randomImageHeightLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        randomImageHeightLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        randomImageHeightLabel.topAnchor.constraint(equalTo: self.randomImageWidthLabel.bottomAnchor, constant: 8).isActive = true
        
        randomImageColorLabel.translatesAutoresizingMaskIntoConstraints = false
        randomImageColorLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        randomImageColorLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        randomImageColorLabel.topAnchor.constraint(equalTo: self.randomImageHeightLabel.bottomAnchor, constant: 8).isActive = true
        
        randomImageUserOwnerLabel.translatesAutoresizingMaskIntoConstraints = false
        randomImageUserOwnerLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        randomImageUserOwnerLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        randomImageUserOwnerLabel.topAnchor.constraint(equalTo: self.randomImageColorLabel.bottomAnchor, constant: 8).isActive = true
    }
    
//MARK: Timer functional
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
        secondsRemaining = 11
    }
    
    func createTimer() {
        if timer == nil {
            let timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(updateTimer),
                userInfo: nil,
                repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            self.timer = timer
        }
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            configureSecondsRemainingText(secondsRemaining: secondsRemaining)
        } else {
            cancelTimer()
            getRandomImage()
        }
    }
    
    func configureSecondsRemainingText(secondsRemaining: Int){
        let minutes = Int(secondsRemaining) / 60 % 60
        let seconds = Int(secondsRemaining) % 60
        
        var times: [String] = []
        if minutes > 0 {
          times.append("\(minutes)m")
        }
        times.append("\(seconds)s")
        
        timerLabel.text = times.joined(separator: " ")

        print(times.joined(separator: " "))
    }

}

//MARK: Random image view protocol
extension RandomImageViewController: RandomImageViewProtocol {
    
    func successGetingRandomImage(image: ImageInfo) {
        let url = URL(string: image.urls.regular)!
        if let data = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
                self.randomImage.image = UIImage(data: data)
            }
        }
        self.randomImageUserOwnerLabel.text = "Owner: \(image.user.name)"
        self.randomImageColorLabel.text = "Color: \(image.color)"
        self.randomImageHeightLabel.text = "Height: \(image.height)"
        self.randomImageWidthLabel.text = "Width: \(image.width)"
        self.imageInfoId = image.id
        
        //Получил строку преобразовал ее в дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: image.created_at)

        //Получил преобразованную дату и хочу ее в строку
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE, MMM d, yyyy"
        let dateString = dateFormatter2.string(from: date!)
        self.randomImageCreatedAtLabel.text = "Created at: \(dateString)"
 
    }
    
    func failureGettingrandomImage(error: Error) {
        print(error.localizedDescription)
        
    }
    
    func getRandomImage() {
        presenter.getRandomImage()
        createTimer()
    }
    
}
