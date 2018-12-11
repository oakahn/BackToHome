import Foundation
import Alamofire
import FirebaseDatabase
import ObjectMapper

protocol MainPresenterProtocol {
    func compare(_ image: UIImage)
    func searchToFirebase(child: String)
}

class MainPresenter {
    
    var view: MainVCProtocol?
    var dbReference: DatabaseReference?
    
    init(_ view: MainVCProtocol) {
        self.view = view
        dbReference = Database.database().reference()
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
                        guard let detail = Mapper<FaceSearch>().map(JSONObject: JSON) else { return }
                        guard let results = detail.results else {
                            return
                        }
                        self.searchToFirebase(child: results[0].face_token ?? "")
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
            
        }
    }
    
    func searchToFirebase(child: String) {
        dbReference?.child(child).observeSingleEvent(of: .value, with: { (snapshot) in
            guard var dictionary = snapshot.value as? [String] else {
                return
            }
            self.view?.redirectToResultPage(listData: dictionary[0])
//            self.dbReference?.child("e73189e5fea7f0084021e68320a4e958").setValue(["Ice", "xx/xx/2538"])
        })
    }
}
