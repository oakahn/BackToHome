import UIKit

protocol MainVCProtocol: BaseVCProtocol {
    
}

class MainVC: BaseVC {
    
    lazy var presenter = MainPresenter(self)
    @IBOutlet weak var imageShow: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openCamera(_ sender: UIButton) {
        getCamera()
    }
    
    @IBAction func compareButton(_ sender: UIButton) {
        presenter.compare(imageShow.image ?? UIImage())
//        presenter.searchToFirebase()
    }
    
    func getCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension MainVC: MainVCProtocol {
    
}

extension MainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageShow.image = image
        dismiss(animated:true, completion: nil)
    }
    
}
