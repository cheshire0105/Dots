import UIKit
import SnapKit

class 회원가입_네번째_뷰컨트롤러 : UIViewController {
    
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "회원가입이 완료되었습니다!"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    } ()
    private let D = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "morningStar")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true

        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return imageView
    }()
    private let O = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "van")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true

        
        return imageView
    }()
    private let T = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "claude")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true

      
        let combinedMaskLayer = CALayer()

        let maskLayer1 = CAShapeLayer()
        maskLayer1.bounds = CGRect(x: 0, y: 0, width: 94, height: 94)
        let maskPath1 = UIBezierPath(rect: maskLayer1.bounds).cgPath
        maskLayer1.path = maskPath1
        maskLayer1.position = CGPoint(x: 47 , y: 0)

        let maskLayer2 = CAShapeLayer()
        maskLayer2.bounds = CGRect(x: 0, y: 0, width: 47, height: 188)
        let maskPath2 = UIBezierPath(rect: maskLayer2.bounds).cgPath
        maskLayer2.path = maskPath2

        maskLayer2.position = CGPoint(x: 47 , y: 0)

        combinedMaskLayer.addSublayer(maskLayer1)
        combinedMaskLayer.addSublayer(maskLayer2)

        imageView.layer.mask = combinedMaskLayer

        
        
        return imageView
    }()
    private let S = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banksy")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true

        let combinedMaskLayer = CALayer()

           let maskLayer1 = CAShapeLayer()
           maskLayer1.bounds = CGRect(x: 0, y: 0, width: 94, height: 47)
        let maskPath1 = UIBezierPath(roundedRect: maskLayer1.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
           maskLayer1.path = maskPath1
           maskLayer1.position = CGPoint(x: 47, y: 23.5)

           let maskLayer2 = CAShapeLayer()
           maskLayer2.bounds = CGRect(x: 0, y: 0, width: 94, height: 47)
        let maskPath2 = UIBezierPath(roundedRect: maskLayer2.bounds, byRoundingCorners: [.topLeft,.topRight, .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
           maskLayer2.path = maskPath2
           maskLayer2.position = CGPoint(x: 47, y: 70.5)

           combinedMaskLayer.addSublayer(maskLayer1)
           combinedMaskLayer.addSublayer(maskLayer2)

           imageView.layer.mask = combinedMaskLayer
        return imageView
    }()
    
    private let 로그인페이지로_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("이제 로그인을 해주세요", for: .normal)
        button.setTitle("이제 로그인을 해주세요", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        UI레이아웃()
        버튼_클릭()
    }
    
}

extension 회원가입_네번째_뷰컨트롤러 {
    func UI레이아웃 () {
        view.addSubview(제목_라벨)
        view.addSubview(D)
        view.addSubview(O)
        view.addSubview(T)
        view.addSubview(S)
        view.addSubview(로그인페이지로_버튼)
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(238)
            make.leading.equalToSuperview().offset(57)
        }
        D.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(72)
            make.leading.equalToSuperview().offset(90)
            make.height.equalTo(94)
            make.width.equalTo(94)
        }
        O.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(72)
            make.trailing.equalToSuperview().offset(-90)
            make.height.equalTo(94)
            make.width.equalTo(94)
        }
        T.snp.makeConstraints { make in
            make.top.equalTo(D.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(90)
            make.height.equalTo(94)
            make.width.equalTo(94)
        }
        S.snp.makeConstraints { make in
            make.top.equalTo(O.snp.bottom).offset(6)
            make.trailing.equalToSuperview().offset(-90)
            make.height.equalTo(94)
            make.width.equalTo(94)
        }
        로그인페이지로_버튼.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-126)
            make.leading.equalToSuperview().offset(102)
            make.trailing.equalToSuperview().offset(-103)
            make.height.equalTo(64)
        }
    }
}

extension 회원가입_네번째_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        로그인페이지로_버튼.addTarget(self, action: #selector(로그인_버튼_클릭), for: .touchUpInside)
    }
    @objc func 로그인_버튼_클릭() {
        print("로그인 하러가시죠")
        let 로그인하러가기 = 로그인_뷰컨트롤러()
        self.navigationController?.pushViewController(로그인하러가기, animated: true)
        navigationItem.hidesBackButton = true
        
        
    }
}
