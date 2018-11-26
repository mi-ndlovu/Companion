//
//  ProfileViewController.swift
//  Companion
//
//  Created by Mbongeni NDLOVU on 2018/10/16.
//  Copyright © 2018 mndlovu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    fileprivate var user : UserInfo = APIController.api42.loggedInUser!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myBarLevel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var points: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func getImage(){
        if let url = URL(string: user.profile.imageUrl)
        {
            imageView.contentMode = .scaleAspectFit
            downloadImage(from: url)
        }
    }
    
    func initUI() {
        profileView.layer.cornerRadius = 7
        detailView.layer.cornerRadius = 7
        imageView.layer.borderWidth = 5
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = imageView.layer.frame.size.height/2
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 6)
        progressBar.setProgress(Float(user.profile.level.truncatingRemainder(dividingBy: 1)), animated: true)
        myBarLevel.text = String(format: "%.2f", user.profile.level)
        username.text = "\(user.profile.login) \(user.profile.firstName) \(user.profile.lastName)"
        email.text = "\(user.profile.email)"
        wallet.text = "\(user.profile.wallet)₳"
        points.text = "\(user.profile.correctionPoint)"
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL)
    {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
    }

}
