//
//  WelcomePageView.swift
//  MyMusicApp
//
//  Created by Damir Zaripov on 20.06.2023.
//

import UIKit

class WelcomePageView: UIViewController, UIScrollViewDelegate {
    
    let overlayView = UIView(frame: UIScreen.main.bounds)
    let scrollView = UIScrollView()
    let startButton = UIButton()
        
    let images: [UIImage] = [
        
    UIImage(named: "w_image_1")!,
    UIImage(named: "w_image_2")!,
    UIImage(named: "Smoke2")!,
    UIImage(named: "w_image_4")!,
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .neutralBlack
        setupScrollView()
    }
    
    @objc func goToSignInPage() {
        let signInVC = AuthPageView()
        navigationController?.pushViewController(signInVC, animated: true)
    }
        
    private func setupScrollView() {
        
        overlayView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
                
        startButton.setTitle("GET STARTED", for: .normal)
        startButton.titleLabel?.font = UIFont.robotoBold16()
        startButton.setTitleColor(UIColor.brandBlack, for: .normal)
        startButton.backgroundColor = UIColor.brandGreen
        startButton.layer.cornerRadius = 4
        startButton.contentMode = .scaleAspectFit
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(goToSignInPage), for: .touchUpInside)
        
        view.addSubview(scrollView)
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 46),
            startButton.widthAnchor.constraint(equalToConstant: 295),
            
        ])
        
        for (imageIndex, image) in images.enumerated() {
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(imageView)
            
            let pageControl = UIPageControl()
            pageControl.currentPageIndicatorTintColor = .brandGreen
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.numberOfPages = images.count
            pageControl.currentPage = imageIndex
            
            let backgroundView = UIView()
            backgroundView.contentMode = .scaleToFill
            backgroundView.backgroundColor = .neutralBlack
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(backgroundView)
            
            var heightConstraintImageView = NSLayoutConstraint (item: imageView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1.0, constant: 0.0)
            
            var heightConstraintBackgroundView = NSLayoutConstraint (item: backgroundView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1.0, constant: 0.0)

            
            if imageIndex == 0 {

                
                heightConstraintImageView = NSLayoutConstraint (item: imageView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 0.5, constant: 0.0)
                
                heightConstraintBackgroundView = NSLayoutConstraint (item: backgroundView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 0.5, constant: 0.0)
                
                let appLabel = UILabel()
                appLabel.text = "APP UI KIT"
                appLabel.textColor = .brandGreen
                appLabel.font = .montserrat10()
                appLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let welcomeLabel = UILabel()
                welcomeLabel.text = "WELCOME TO MUSIC APP"
                welcomeLabel.numberOfLines = 0
                welcomeLabel.lineBreakMode = .byWordWrapping
                welcomeLabel.textAlignment = .left
                welcomeLabel.textColor = UIColor.white
                welcomeLabel.font = UIFont.robotoBold36()
                welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let informationLabel = UILabel()
                informationLabel.numberOfLines = 0
                informationLabel.lineBreakMode = .byWordWrapping
                informationLabel.text = "Make your design workflow easier and save your time"
                informationLabel.textColor = .neutralWhite
                informationLabel.font = UIFont.montserrat14()
                informationLabel.textAlignment = .left
                informationLabel.translatesAutoresizingMaskIntoConstraints = false

                
                
                backgroundView.addSubview(appLabel)
                backgroundView.addSubview(welcomeLabel)
                backgroundView.addSubview(informationLabel)
                backgroundView.addSubview(pageControl)
                
                NSLayoutConstraint.activate([
                    appLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70),
                    appLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 40),
                    appLabel.widthAnchor.constraint(equalToConstant: 100),
                    appLabel.heightAnchor.constraint(equalToConstant: 17),
                    
                    welcomeLabel.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 10),
                    welcomeLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 40),
                    welcomeLabel.widthAnchor.constraint(equalToConstant: 274),
                    welcomeLabel.heightAnchor.constraint(equalToConstant: 100),
                    
                    informationLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
                    informationLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 40),
                    informationLabel.widthAnchor.constraint(equalToConstant: 310),
                    informationLabel.heightAnchor.constraint(equalToConstant: 44),
                    
                    pageControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                    pageControl.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5),


                ])
            }
            
            if imageIndex == 1 {
                
                let appLabel = UILabel()
                appLabel.text = "APP UI KIT"
                appLabel.textAlignment = .center
                appLabel.textColor = .brandGreen
                appLabel.font = .montserrat10()
                appLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let welcomeLabel = UILabel()
                welcomeLabel.text = "WELCOME TO MUSIC APP"
                welcomeLabel.numberOfLines = 0
                welcomeLabel.lineBreakMode = .byWordWrapping
                welcomeLabel.textAlignment = .center
                welcomeLabel.textColor = UIColor.white
                welcomeLabel.font = UIFont.robotoBold36()
                welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let informationLabel = UILabel()
                informationLabel.numberOfLines = 0
                informationLabel.lineBreakMode = .byWordWrapping
                informationLabel.text = "Make your design workflow easier and save your time"
                informationLabel.textColor = .neutralWhite
                informationLabel.font = UIFont.montserrat14()
                informationLabel.textAlignment = .center
                informationLabel.translatesAutoresizingMaskIntoConstraints = false

                
                
                imageView.addSubview(appLabel)
                imageView.addSubview(welcomeLabel)
                imageView.addSubview(informationLabel)
                imageView.addSubview(pageControl)
                
                NSLayoutConstraint.activate([
                    appLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 287),
                    appLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 150),
                    appLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -150),
                    appLabel.widthAnchor.constraint(equalToConstant: 100),
                    appLabel.heightAnchor.constraint(equalToConstant: 17),
                    
                    welcomeLabel.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 10),
                    welcomeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 53),
                    welcomeLabel.widthAnchor.constraint(equalToConstant: 274),
                    welcomeLabel.heightAnchor.constraint(equalToConstant: 100),
                    
                    informationLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
                    informationLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 40),
                    informationLabel.widthAnchor.constraint(equalToConstant: 310),
                    informationLabel.heightAnchor.constraint(equalToConstant: 44),
                    
                    pageControl.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                    pageControl.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -200)


                ])
            }
            
            if imageIndex == 2 {
                
                let appLabel = UILabel()
                appLabel.text = "APP UI KIT"
                appLabel.textAlignment = .left
                appLabel.textColor = .brandGreen
                appLabel.font = .montserrat10()
                appLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let welcomeLabel = UILabel()
                welcomeLabel.text = "WELCOME TO MUSIC APP"
                welcomeLabel.numberOfLines = 0
                welcomeLabel.lineBreakMode = .byWordWrapping
                welcomeLabel.textAlignment = .left
                welcomeLabel.textColor = UIColor.white
                welcomeLabel.font = UIFont.robotoBold36()
                welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let informationLabel = UILabel()
                informationLabel.numberOfLines = 0
                informationLabel.lineBreakMode = .byWordWrapping
                informationLabel.text = "Make your design workflow easier and save your time"
                informationLabel.textColor = .neutralWhite
                informationLabel.font = UIFont.montserrat14()
                informationLabel.textAlignment = .left
                informationLabel.translatesAutoresizingMaskIntoConstraints = false

                
                
                imageView.addSubview(appLabel)
                imageView.addSubview(welcomeLabel)
                imageView.addSubview(informationLabel)
                imageView.addSubview(pageControl)
                
                NSLayoutConstraint.activate([
                    
                    appLabel.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: -10),
                    appLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 40),
                    appLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -150),
                    appLabel.widthAnchor.constraint(equalToConstant: 100),
                    appLabel.heightAnchor.constraint(equalToConstant: 17),
                    
                    welcomeLabel.bottomAnchor.constraint(equalTo: informationLabel.topAnchor, constant: 2),
                    welcomeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 40),
                    welcomeLabel.widthAnchor.constraint(equalToConstant: 274),
                    welcomeLabel.heightAnchor.constraint(equalToConstant: 100),
                    
                    informationLabel.bottomAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: -24),
                    informationLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 40),
                    informationLabel.widthAnchor.constraint(equalToConstant: 310),
                    informationLabel.heightAnchor.constraint(equalToConstant: 44),
                    
                    pageControl.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
                    pageControl.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5),
                    pageControl.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -114),


                ])

                
            }
            
            if imageIndex == 3 {
                                
                let musicLabel = UILabel()
                musicLabel.text = "MUSIC"
                musicLabel.textAlignment = .center
                musicLabel.textColor = UIColor.white
                musicLabel.font = UIFont.robotoBold64()
                musicLabel.translatesAutoresizingMaskIntoConstraints = false
                
                imageView.addSubview(overlayView)
                imageView.addSubview(musicLabel)
                
                NSLayoutConstraint.activate([
                    
                    musicLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                    musicLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),

                ])

                
            }

            NSLayoutConstraint.activate([
                
                heightConstraintImageView,
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                imageView.topAnchor.constraint(equalTo: view.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(imageIndex) * view.bounds.width),
                
                heightConstraintBackgroundView,
                backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                backgroundView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(imageIndex) * view.bounds.width),
            ])
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(images.count) * view.bounds.width, height: scrollView.bounds.height)
    }
}
