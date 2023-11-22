// 23. 11.21  10:01 pm dev에서 풀 완료 - 최신화 커밋 - > 최신화 완료

import UIKit
import SnapKit

class 로그인_회원가입_뷰컨트롤러: UIViewController {
    
    private let D = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        imageView.alpha = 0
        return imageView
    }()
    private let O = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.alpha = 0
        return imageView
    }()
    private let T = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        let combinedMaskLayer = CALayer()
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        let maskPath1 = UIBezierPath(rect: maskLayer1.bounds).cgPath
        maskLayer1.path = maskPath1
        maskLayer1.position = CGPoint(x: 20 , y: 0)
        
        let maskLayer2 = CAShapeLayer()
        maskLayer2.bounds = CGRect(x: 0, y: 0, width: 20, height: 80)
        let maskPath2 = UIBezierPath(rect: maskLayer2.bounds).cgPath
        maskLayer2.path = maskPath2
        
        maskLayer2.position = CGPoint(x: 20 , y: 0)
        
        combinedMaskLayer.addSublayer(maskLayer1)
        combinedMaskLayer.addSublayer(maskLayer2)
        
        imageView.layer.mask = combinedMaskLayer
        
        
        imageView.alpha = 0
        
        return imageView
    }()
    private let S = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        
        let combinedMaskLayer = CALayer()
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.bounds = CGRect(x: 0, y: 0, width: 40, height: 20)
        let maskPath1 = UIBezierPath(roundedRect: maskLayer1.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        maskLayer1.path = maskPath1
        maskLayer1.position = CGPoint(x: 20, y: 10)
        
        let maskLayer2 = CAShapeLayer()
        maskLayer2.bounds = CGRect(x: 0, y: 0, width: 40, height: 20)
        let maskPath2 = UIBezierPath(roundedRect: maskLayer2.bounds, byRoundingCorners: [.topLeft,.topRight, .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        maskLayer2.path = maskPath2
        maskLayer2.position = CGPoint(x: 20, y: 30)
        
        combinedMaskLayer.addSublayer(maskLayer1)
        combinedMaskLayer.addSublayer(maskLayer2)
        
        imageView.layer.mask = combinedMaskLayer
        imageView.alpha = 0
        
        return imageView
    }()
    
    
    private let 슬로건_라벨 = {
        let label = UILabel()
        label.text = """
전시의 시작은 당신의 눈길,
깊이는 우리의 목소리
"""
        label.numberOfLines = 2
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = UIColor.white
        label.textAlignment = .justified
        label.alpha = 0
        return label
    } ()
    
   
    //회원가입 -
    private let 회원가입_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("회원가입", for: .normal)
        button.setTitle("회원가입", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.alpha = 0
        return button
    }()
    
    //로그인 _
    private let 로그인_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.setTitle("로그인", for: .normal)
        button.setTitle("로그인", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.alpha = 0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        UI레이아웃()
        버튼_클릭()
        로고_페이드_인아웃()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.버튼_페이드_인아웃()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.슬로건_페이드_인아웃()
        }
    }
}

// 버튼 클릭
extension 로그인_회원가입_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        회원가입_버튼.addTarget(self, action: #selector(회원가입_버튼_클릭), for: .touchUpInside)
        로그인_버튼.addTarget(self, action: #selector(로그인_버튼_클릭), for: .touchUpInside)
    }
    @objc func 회원가입_버튼_클릭() {
        print("회원가입 페이지로 이동")
        let 인기리뷰페이지_디테일_화면 = 회원가입_첫번째_뷰컨트롤러()
        self.navigationController?.pushViewController(인기리뷰페이지_디테일_화면, animated: true)
    }
    @objc func 로그인_버튼_클릭() {
        print("로그인 페이지로 이동")
        let 로그인_뷰컨트롤러_이동 = 로그인_뷰컨트롤러()
        self.navigationController?.pushViewController(로그인_뷰컨트롤러_이동, animated: true)
        
    }
}



// 레이아웃
extension 로그인_회원가입_뷰컨트롤러 {
    func UI레이아웃() {
        
        view.addSubview(D)
        view.addSubview(O)
        view.addSubview(T)
        view.addSubview(S)
        view.addSubview(슬로건_라벨)
        view.addSubview(회원가입_버튼)
        view.addSubview(로그인_버튼)
        
        D.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(258)
            make.trailing.equalTo(로그인_버튼.snp.centerX).offset(-50)
            
        }
        O.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(258)
            make.trailing.equalTo(로그인_버튼.snp.centerX).offset(-4)
            
        }
        T.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(258)
            make.leading.equalTo(로그인_버튼.snp.centerX).offset(4)
            
            
        }
        S.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(258)
            make.leading.equalTo(로그인_버튼.snp.centerX).offset(50)
            
        }
        
        슬로건_라벨.snp.makeConstraints { make in
            make.top.equalTo(D.snp.bottom).offset(32)
            make.leading.equalTo(D.snp.leading).offset(18)
            
        }
        
        회원가입_버튼.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.top.equalTo(슬로건_라벨.snp.bottom).offset(127)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-44)
        }
        
        로그인_버튼.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.top.equalTo(회원가입_버튼.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-44)
        }
    }
}

//효과
extension 로그인_회원가입_뷰컨트롤러 {
    private func 로고_페이드_인아웃() {
        let 총시간 = 2.5
        let 딜레이 = 0.9
        
        // D
        UIView.animate(withDuration: 총시간, delay: 딜레이 * 0, options: [], animations: {
            self.D.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 총시간, delay: 1, options: [], animations: {
                self.D.alpha = 1
            }, completion: nil)
        })
        
        // O
        UIView.animate(withDuration: 총시간, delay: 딜레이 * 1, options: [], animations: {
            self.O.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 총시간, delay: 2, options: [], animations: {
                self.O.alpha = 1
            }, completion: nil)
        })
        
        // T
        UIView.animate(withDuration: 총시간, delay: 딜레이 * 2, options: [], animations: {
            self.T.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 총시간, delay: 3, options: [], animations: {
                self.T.alpha = 1
            }, completion: nil)
        })
        
        // S
        UIView.animate(withDuration: 총시간, delay: 딜레이 * 3, options: [], animations: {
            self.S.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 총시간, delay: 4, options: [], animations: {
                self.S.alpha = 1
            }, completion: nil)
        })
    }
    private func 슬로건_페이드_인아웃() {
        let duration = 2.5
        let delay = 0.9
        
        UIView.animate(withDuration: duration, delay: delay * 0, options: [], animations: {
            self.슬로건_라벨.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                self.슬로건_라벨.alpha = 1
            }, completion: nil)
        })
    }
    private func 버튼_페이드_인아웃() {
        let duration = 3.5
        let delay = 0.9
        
        UIView.animate(withDuration: duration, delay: delay * 0, options: [], animations: {
            self.회원가입_버튼.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: duration, delay: 1, options: [], animations: {
                self.회원가입_버튼.alpha = 1
            }, completion: nil)
        })
        
        UIView.animate(withDuration: duration, delay: delay * 0, options: [], animations: {
            self.로그인_버튼.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: duration, delay: 2, options: [], animations: {
                self.로그인_버튼.alpha = 1
            }, completion: nil)
        })
    }
    
}
