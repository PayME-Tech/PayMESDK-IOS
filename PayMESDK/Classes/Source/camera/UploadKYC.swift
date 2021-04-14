//
//  KYCController.swift
//  PayMESDK
//
//  Created by HuyOpen on 1/6/21.
//

import Foundation

public class UploadKYC {
    internal var imageDocument : [UIImage]?
    internal var imageAvatar : UIImage?
    internal var videoKYC : URL?
    internal var active: Int?
    internal var flowKYC: [String: Bool]?
    private var pathFront : String?
    private var pathBack : String?
    private var pathAvatar : String?
    private var pathVideo : String?

    public init(imageDocument : [UIImage]?, imageAvatar : UIImage?, videoKYC : URL?, active: Int?){
        self.imageDocument = imageDocument
        self.imageAvatar = imageAvatar
        self.videoKYC = videoKYC
        self.active = active
        print(imageDocument)
        print(imageAvatar)
        print(videoKYC)
        print(active)
    }
    
    public func upload(){
        PayME.currentVC?.navigationItem.hidesBackButton = true
        PayME.currentVC?.navigationController?.isNavigationBarHidden = true
        PayME.currentVC?.showSpinner(onView: (PayME.currentVC?.view)!)
        uploadDocument()
    }
    
    private func verifyKYC() {
        API.verifyKYC(pathFront: self.pathFront, pathBack: self.pathBack, pathAvatar: self.pathAvatar, pathVideo: self.pathVideo,
          onSuccess: { response in
            print(response)
            if let result = response["Account"]!["KYC"] as? [String: AnyObject]
            {
                let succeeded = result["succeeded"] as? Bool
                if (succeeded != nil) {
                    if (succeeded! == true) {
                        DispatchQueue.main.async {
                            PayME.currentVC?.removeSpinner()
                            guard let navigationController = PayME.currentVC?.navigationController else { return }
                            var navigationArray = navigationController.viewControllers
                            if PayME.isRecreateNavigationController {
                                PayME.currentVC?.navigationController?.viewControllers = [navigationArray[0]]
                                let rootViewController = navigationArray.first
                                (rootViewController as! WebViewController).reload()
                            } else {
                                if (self.imageDocument != nil) {
                                    if (self.active == 2) {
                                        navigationArray.removeLast()
                                        navigationArray.removeLast()
                                    } else {
                                        navigationArray.removeLast()
                                        navigationArray.removeLast()
                                        navigationArray.removeLast()
                                        navigationArray.removeLast()
                                    }
                                }
                                if (self.imageAvatar != nil) {
                                    navigationArray.removeLast()
                                    navigationArray.removeLast()
                                }
                                if (self.videoKYC != nil) {
                                    navigationArray.removeLast()
                                    navigationArray.removeLast()
                                }
                                PayME.currentVC?.navigationController?.viewControllers = navigationArray
                                (PayME.currentVC?.navigationController?.visibleViewController as! WebViewController).reload()
                            }
                        }
                    } else {
                        PayME.currentVC?.removeSpinner()
                        self.toastMess(title: "Lỗi", message: result["message"] as? String ?? "Something went wrong")
                    }
                } else {
                    PayME.currentVC?.removeSpinner()
                    self.toastMess(title: "Lỗi", message: result["message"] as? String ?? "Something went wrong")
                }
            }
        },onError: {error in
            if let extensions = error["extensions"] as? [String:AnyObject] {
                let code = extensions["code"] as? Int
                if (code != nil) {
                    if (code == 401) {
                        PayME.logoutAction()
                        guard let navigationController = PayME.currentVC?.navigationController else { return }
                        let navigationArray = navigationController.viewControllers
                        PayME.currentVC?.navigationController?.viewControllers = [navigationArray[0]]
                    }
                }
                self.toastMess(title: "Lỗi", message: error["message"] as? String ?? "Something went wrong")
                PayME.currentVC?.removeSpinner()
            }
            
        })
    }
    
    private func uploadVideo() {
        if (self.videoKYC != nil) {
            API.uploadVideoKYC(videoURL: self.videoKYC!, onSuccess: {response in
                print(response)
                 let code = response["code"]! as! Int
                 if (code == 1000) {
                    let data = response["data"] as! [[String:Any]]
                    self.pathVideo = data[0]["path"] as? String ?? ""
                    self.verifyKYC()
                 } else {
                    PayME.currentVC?.removeSpinner()
                    self.toastMess(title: "Lỗi", message: response["data"]!["message"] as? String ?? "Something went wrong")
                }
            }, onError: {error in
                PayME.currentVC?.removeSpinner()
                self.toastMess(title: "Lỗi", message: (error["message"] as? String) ?? "Something went wrong")
            })
        } else {
            verifyKYC()
        }
    }
    
    private func uploadAvatar() {
        if (self.imageAvatar != nil) {
            API.uploadImageKYC(imageFront: self.imageAvatar!, imageBack: nil,
            onSuccess: {response in
                 print(response)
                 let code = response["code"]! as! Int
                 if (code == 1000) {
                    let data = response["data"] as! [[String:Any]]
                    self.pathAvatar = data[0]["path"] as? String ?? ""
                    self.uploadVideo()
                 } else {
                    PayME.currentVC?.removeSpinner()
                    self.toastMess(title: "Lỗi", message: response["data"]!["message"] as? String ?? "Something went wrong")
                }
            }, onError: {error in
                PayME.currentVC?.removeSpinner()
                self.toastMess(title: "Lỗi", message: (error["message"] as? String) ?? "Something went wrong")
            })
        } else {
            uploadVideo()
        }
    }
    
    private func uploadDocument() {
        if (self.imageDocument != nil) {
            if (self.active == 2) {
                API.uploadImageKYC(imageFront: self.imageDocument![0], imageBack: nil,
                onSuccess: {response in
                    print(response)
                     let code = response["code"]! as! Int
                     if (code == 1000) {
                        let data = response["data"] as! [[String:Any]]
                        self.pathFront = data[0]["path"] as? String ?? ""
                        self.uploadAvatar()
                     } else {
                        PayME.currentVC?.removeSpinner()
                        self.toastMess(title: "Lỗi", message: response["data"]!["message"] as? String ?? "Something went wrong")
                    }
                    
                }, onError: {error in
                    PayME.currentVC?.removeSpinner()
                    self.toastMess(title: "Lỗi", message: (error["message"] as? String) ?? "Something went wrong")
                })
            } else {
                API.uploadImageKYC(imageFront: self.imageDocument![0], imageBack: self.imageDocument![1], onSuccess: {response in
                     let code = response["code"]! as! Int
                     if (code == 1000) {
                        let data = response["data"] as! [[String:Any]]
                        self.pathFront = data[0]["path"] as? String ?? ""
                        self.pathBack = data[1]["path"] as? String ?? ""
                        self.uploadAvatar()
                     } else {
                        PayME.currentVC?.removeSpinner()
                        self.toastMess(title: "Lỗi", message: response["data"]!["message"] as? String ?? "Something went wrong")
                    }
                    
                }, onError: {error in
                    PayME.currentVC?.removeSpinner()
                    self.toastMess(title: "Lỗi", message: (error["message"] as? String) ?? "Something went wrong")
                })
            }
        }  else {
            uploadAvatar()
        }
    }
    
    private func toastMess(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        PayME.currentVC?.present(alert, animated: true, completion: nil)
    }
    
}
