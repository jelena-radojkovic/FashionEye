//
//  MainViewModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

// MARK: - Models

struct MainModel {
    let title: LabelStateModel
    let description: LabelStateModel
    let imageView: ImageViewStateModel
    let orLabel: LabelStateModel
    let explanationLabel: LabelStateModel
    let captureButton: ButtonStateModel
}

// MARK: - MainViewModel

class MainViewModel {
    lazy var currentState: BehaviorSubject<MainModel> = BehaviorSubject(value: prepareInitialState())
    var isLoaded = false
    var lastLoadedImage: UIImage = UIImage(named: "woman")!
    
}

// MARK: - Utils

extension MainViewModel {
    
    private func prepareInitialState() -> MainModel {
        let titleLabel = LabelStateModel(text:"Hello there!",
                                         textColor: .black,
                                         font: UIFont.boldSystemFont(ofSize: 32))
        let descriptionLabel = LabelStateModel(text: "Find your article \neither by uploading it",
                                               textColor: .black,
                                               font: UIFont.boldSystemFont(ofSize: 24),
                                               numberOfLines: 2)
        let image = ImageViewStateModel(image: UIImage(named: "imagePlaceholder"),
                                        contentMode: .scaleAspectFit)
        let orLabel = LabelStateModel(text:"or by taking a pic! :)",
                                      textColor: .black,
                                      font: UIFont.boldSystemFont(ofSize: 20))
        let explanationLabel = LabelStateModel(text:"Tap on the \nimage to \nupload",
                                               textColor: .gray,
                                               font: UIFont.systemFont(ofSize: 14),
                                               numberOfLines: 3)
        let captureButton = ButtonStateModel(title: LabelStateModel(text: "Start capturing",
                                                                    textColor: .black,
                                                                    font: UIFont.systemFont(ofSize: 14)),
                                             cornerRadius: 16, isEnabled: true,
                                             borderColor: UIColor.black.cgColor, borderWidth: 2)
        return MainModel(title: titleLabel,
                         description: descriptionLabel,
                         imageView: image,
                         orLabel: orLabel,
                         explanationLabel: explanationLabel,
                         captureButton: captureButton)
    }
    
    func navigateToListScreen() {
        NetworkManager.shared.getLastFetchedItems() { foundClasses in
            var foundClothing: [Clothing] = []
            var headlines: [String] = []
            for class_ in foundClasses.name {
                NetworkManager.shared.getItems(item: class_) { clothing in
                    foundClothing.append(clothing)
                    headlines.append(class_)
                    if foundClothing.count == foundClasses.name.count { // uslov ispunjen za dalje
                        let vc = ListViewController()
                        vc.headlines = headlines
                        vc.clothingToBePresented = foundClothing
                        RoutingService.shared.currentNavigationStackRoot?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    func prepareTitleLabel() -> LabelStateModel {
        return LabelStateModel(text: "Find your favourite clothes", textColor: .white, font: .m20)
    }
    
    func preparePhotoMainCell(image: UIImage) -> PhotoMainCellModel {
        return PhotoMainCellModel(title: LabelStateModel(text:"Upload your photo below👇",
                                                         textColor: .primaryTextColor,
                                                         font: .m24, numberOfLines: 0, textAlignment: .center),
                                  imageView: ImageViewStateModel(image: image, contentMode: .scaleAspectFill),
                                  descriptionLabel: LabelStateModel(text: "(tap on the image.. )", textColor: .gray, font: .l18, textAlignment: .center),
                                  backgroundColor: nil)
    }
    
    func prepareLoadedPhoto() -> PhotoMainCellModel {
        return PhotoMainCellModel(title: LabelStateModel(text:"This is what we found🥳🥳",
                                                         textColor: .primaryTextColor,
                                                         font: .m24, numberOfLines: 0, textAlignment: .center),
                                  imageView: ImageViewStateModel(image: self.lastLoadedImage, contentMode: .scaleAspectFill),
                                  descriptionLabel: nil,
                                  backgroundColor: .white)
    }
    
    func prepareHeaderCell() -> HeaderMainCellModel {
        return HeaderMainCellModel(button1: ThemeComponents.customEnabledButton(title: "History", color: .tertiaryBrandColor),
                                   button2: ThemeComponents.customDisabledButton(title: "Main", color: .primaryBrandColor),
                                   button3: ThemeComponents.customEnabledButton(title: "Search", color: .tertiaryBrandColor))
    }
    
    func prepareButtonCell() -> ButtonCommonCellModel {
        return ButtonCommonCellModel(title: "Discover these items")
    }
}

// MARK: - Network

extension MainViewModel {
    
    func uploadPhoto(_ imageData: Data, completion: @escaping (() -> Void)) {
        let api_url = NetworkManager.urlToServer + "/upload"
        guard let url = URL(string: api_url) else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Now Executef
        AF.upload(multipartFormData: { multiPart in
            multiPart.append(imageData, withName: "file", fileName: "file.png", mimeType: "image/png")
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
            if let imageData = data.data {
                if let image = UIImage(data: imageData) {
                    self.lastLoadedImage = image
                    self.isLoaded = true
                    completion()
                } else {
                    print("❌❌❌")
                }
            }
        })
    }
    
    func uploadPhotoToServer(_ imageData: Data, completion: @escaping (() -> Void)) {
        NetworkManager.shared.uploadPhotoToServer(imageData) { image in
            self.lastLoadedImage = image
            self.isLoaded = true
            completion()
        }
    }
}
