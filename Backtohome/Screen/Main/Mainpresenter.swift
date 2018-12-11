import Foundation
import Alamofire
import Firebase

protocol MainPresenterProtocol {
    func compare(_ image: UIImage)
    func searchToFirebase()
}

class MainPresenter {
    
    var view: MainVCProtocol?
    var database: DatabaseReference?
    
    init(_ view: MainVCProtocol) {
        self.view = view
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func compare(_ image: UIImage) {
        let imageSearch = UIImageJPEGRepresentation(image, 0.6)?.base64EncodedString()
        guard let imgSearch = imageSearch else { return }
        
        let urlCompare = "https://api-us.faceplusplus.com/facepp/v3/search"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgSearch.data(using: .utf8)!, withName: "image_base64")
            multipartFormData.append("33ba61e6cc9c49628f452b3869344a56".data(using: .utf8)!, withName: "faceset_token")
            multipartFormData.append("ty0l5GTF5Dllxt5qtmoXkLxBHtKrckIZ".data(using: .utf8)!, withName: "api_key")
            multipartFormData.append("-OLAkqud-QrK2fkpyU17YKiK5EfAexxu".data(using: .utf8)!, withName: "api_secret")
        }, to:urlCompare)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        print(JSON)
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
            
        }
    }
    
    func searchToFirebase() {
        
    }
}
