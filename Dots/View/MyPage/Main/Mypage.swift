// 최신화 - 12.28
import UIKit
import SnapKit
import FSCalendar
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import SDWebImage

class Mypage: UIViewController {
    let sdOptions: SDWebImageOptions = [.retryFailed, .avoidDecodeImage]

    var 특정날짜: [(date: String, imageURL: String?)] = []
    func printUserVisitedDates() {
        print("유저_다녀옴_날짜: \(유저_다녀옴_날짜)")
    }
    
    let 배경_백 = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
               let visualEffectView = UIVisualEffectView(effect: blurEffect)
               return visualEffectView
       }()
    var 마이페이지_프로필_이미지_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 38
        imageButton.clipsToBounds = true
        //        imageButton.setImage(UIImage(named: "cabanel"), for: .selected)
        //        imageButton.setImage(UIImage(named: "cabanel"), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
    
    let 버튼_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.black
        return uiView
    } ()
    
    let 마이페이지_설정_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "setting" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_알림_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "알림" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_프로필_닉네임: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let 마이페이지_프로필_이메일: UILabel = {
        let label = UILabel()
        label.text = "유저 이메일"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let 마이페이지_전시_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_전시_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "전시")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 마이페이지_전시_라벨 = {
        let label = UILabel()
        label.text = "전시"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 마이페이지_후기_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_후기_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "후기")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 마이페이지_후기_라벨 = {
        let label = UILabel()
        label.text = "리뷰"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 마이페이지_보관함_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_보관함_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "보관함")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 마이페이지_보관함_라벨 = {
        let label = UILabel()
        label.text = "보관함"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 구분선 = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    /*
     
     
     캘 린 더
     
     
     */
    
    lazy var 캘린더 = {
        let calendar = FSCalendar()
        calendar.backgroundColor = UIColor.clear
        calendar.layer.cornerRadius = 15
        calendar.layer.borderWidth = 0.3
        //        calendar.layer.borderColor = UIColor(named: "neon")?.cgColor
        
        
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.headerTitleColor = UIColor.white
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 20)
        calendar.appearance.weekdayTextColor = UIColor.darkGray
        calendar.appearance.todayColor = UIColor.white
        
        calendar.appearance.todaySelectionColor = UIColor.white
//        calendar.appearance.titleTodayColor = UIColor(named: "neon")
        calendar.appearance.titleTodayColor = UIColor.black
        
        
        calendar.appearance.selectionColor = UIColor.clear
        calendar.appearance.titleDefaultColor = UIColor.white
        calendar.appearance.titleSelectionColor = UIColor.white
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        calendar.allowsMultipleSelection = false
        
        
        return calendar
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        캐시된_유저_데이터_마이페이지_적용하기()
        특정날짜방문_캘린더_적용()
        포스터이미지URL업데이트_파이어스토어()

        tabBarController?.tabBar.isHidden = false

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Page")
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.isNavigationBarHidden = true
        
        버튼_클릭()
        UI레이아웃()
        버튼_백_레이아웃 ()
        캘린더_레이아웃()
        캘린더.dataSource = self
        캘린더.delegate = self
        캘린더.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        포스터이미지URL업데이트_파이어스토어()
        캐시된_유저_데이터_마이페이지_적용하기()
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleOutsideTap))
//        tapGestureRecognizer.delegate = self
//        view.addGestureRecognizer(tapGestureRecognizer)
        
        특정날짜방문_캘린더_적용()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

          // InteractivePopGestureRecognizer의 Delegate 설정
          self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
 
//
//    @objc private func handleOutsideTap() {
//        if presentedViewController != nil {
//            dismiss(animated: true, completion: nil)
//        }
//    }
    
}
extension UIImage {
    func resized(to 사이즈: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: 사이즈).image { _ in
            draw(in: CGRect(origin: .zero, size: 사이즈))
        }
    }
}

//
extension Mypage: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if presentedViewController != nil && touch.view == view {
            return true
        }
        return false
    }
}
