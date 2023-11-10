import UIKit
import SnapKit

class 회원가입_첫번째_뷰컨트롤러 : UIViewController, UINavigationControllerDelegate {
    
    //페이지 제목
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "기본 정보를 입력해주세요"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    } ()
    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
    var 회원가입_이미지_선택_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 75
        imageButton.backgroundColor = .darkGray
        imageButton.clipsToBounds = true
        imageButton.setTitle("사진", for: .normal)
        imageButton.setTitle("사진", for: .selected)
        imageButton.setTitleColor(UIColor.white, for: .selected)
        imageButton.setTitleColor(UIColor.darkGray, for: .normal)
        imageButton.setImage(UIImage(named: ""), for: .selected)
        imageButton.setImage(UIImage(named: ""), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
    private let 회원가입_닉네임_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    private let 회원가입_이메일_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    private let 회원가입_중복확인_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        //button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("중복확인", for: .normal)
        button.setTitle("중복확인", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 회원가입_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    private let 회원가입_다음_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.setTitle("다음", for: .normal)
        button.setTitle("다음", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 닉네임_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 이메일_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        UI레이아웃()
        버튼_클릭()
    }
    
}

extension 회원가입_첫번째_뷰컨트롤러 {
    
    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(닉네임_백)
        view.addSubview(이메일_백)
        view.addSubview(비밀번호_백)
        view.addSubview(회원가입_이미지_선택_버튼)
        view.addSubview(회원가입_닉네임_텍스트필드)
        view.addSubview(회원가입_이메일_텍스트필드)
        view.addSubview(회원가입_중복확인_버튼)
        view.addSubview(회원가입_비밀번호_텍스트필드)
        view.addSubview(회원가입_다음_버튼)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(149)
            make.leading.equalToSuperview().offset(24)
            
        }
        회원가입_이미지_선택_버튼.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨).offset(83)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        닉네임_백.snp.makeConstraints { make in
            make.top.equalTo(회원가입_이미지_선택_버튼.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        회원가입_닉네임_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(닉네임_백)
            make.leading.equalTo(닉네임_백).offset(30)
            make.trailing.equalTo(닉네임_백).offset(-80)
            make.height.equalTo(58)
            
        }
        이메일_백.snp.makeConstraints { make in
            make.top.equalTo(회원가입_닉네임_텍스트필드.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        회원가입_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(이메일_백)
            make.leading.equalTo(이메일_백).offset(30)
            make.trailing.equalTo(이메일_백).offset(-80)
            make.height.equalTo(58)
        }
        비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(회원가입_이메일_텍스트필드.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        회원가입_중복확인_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(이메일_백.snp.centerY)
            make.trailing.equalTo(이메일_백.snp.trailing).offset(-30)
        }
        회원가입_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(비밀번호_백)
            make.leading.equalTo(비밀번호_백).offset(30)
            make.trailing.equalTo(비밀번호_백).offset(-80)
            make.height.equalTo(58)
        }
        회원가입_다음_버튼.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
            
        }
    }
}

//버튼클릭
extension 회원가입_첫번째_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        회원가입_다음_버튼.addTarget(self, action: #selector(회원가입_다음_버튼_클릭), for: .touchUpInside)
        회원가입_이미지_선택_버튼.addTarget(self, action: #selector(회원가입_이미지_선택_버튼_클릭), for: .touchUpInside)
        
    }
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
        
    }
    @objc func 회원가입_다음_버튼_클릭() {
        print("다음 페이지로 이동")
        let 다음화면_이동 = 회원가입_두번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
    @objc func 회원가입_이미지_선택_버튼_클릭() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}





extension 회원가입_첫번째_뷰컨트롤러: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            회원가입_이미지_선택_버튼.setImage(selectedImage, for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



//extension 회원가입_첫번째_뷰컨트롤러 {
//    
//    @objc func presentModalViewController() {
//        // 상세 내용을 담은 뷰 컨트롤러를 생성하고 모달로 표시합니다.
//        let detailViewController = DetailViewController()
//        presentDetailViewController(detailViewController)
//    }
//    
//    private func presentDetailViewController(_ detailViewController: DetailViewController) {
//        if let sheetController = detailViewController.presentationController as? UISheetPresentationController {
//            // 사용자 정의 detent 생성
//            let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
//            let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
//                // safe area bottom을 구하기 위한 선언.
//                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0
//                
//                // 모든 기기에서 항상 높이가 700인 detent를 만들어낼 수 있다.
//                return 700 - safeAreaBottom
//            }
//            
//            // 중간 높이와 사용자 정의 높이를 포함하는 detent 설정
//            sheetController.detents = [.medium(), customDetent]
//            sheetController.largestUndimmedDetentIdentifier = detentIdentifier // 최대 높이를 커스텀 detent로 설정합니다.
//            sheetController.prefersScrollingExpandsWhenScrolledToEdge = true // 스크롤할 때 시트가 확장되도록 설정합니다.
//            sheetController.preferredCornerRadius = 30 // 둥근 모서리 설정을 유지합니다.
//        }
//        
//        // 모달 표시 설정
//        detailViewController.modalPresentationStyle = .pageSheet
//        self.present(detailViewController, animated: true, completion: nil)
//    }
//    
//    
//}

class 사진_라이브: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 여기에 상세 내용을 나타내는 UI 구성 요소를 추가합니다.
    }
}
