import Foundation
import UIKit
import SnapKit

class 캘린더_스케쥴_등록_셀 : UICollectionViewCell {
    
    let 이미지_백 = {
       let uiView = UIView()
        uiView.layer.cornerRadius = 12
        return uiView
    }()
    let 라벨_백 = {
       let uiView = UIView()
        uiView.layer.cornerRadius = 12
        return uiView
    }()
    
    let 구분선 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "새로구분선")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var 전시_포스터_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "help")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    let 전시명_라벨 = {
        let label = UILabel()
        label.text = "전시 제목"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    } ()
    
    let 장소_라벨 = {
        let label = UILabel()
        label.text = "전시 장소"
        label.textColor =  UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)

        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = .left
        return label
    } ()
    
    let 방문날짜_라벨 = {
        let label = UILabel()
        label.text = "년월일시"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor =  UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)

        label.textAlignment = .left
        return label
    } ()
    let 내후기_버튼 = {
    let button = UIButton()
        button.setImage(UIImage(named: "내후기normal"), for: .normal)
        button.setImage(UIImage(named: "내후기select"), for: .selected)
        button.isSelected = !button.isSelected
        return button
    }()
 
    let 내후기_버튼2 = {
    let button = UIButton()
        button.setImage(UIImage(named: "내후기normal"), for: .normal)
        button.setImage(UIImage(named: "내후기select"), for: .selected)
        button.isSelected = !button.isSelected
        return button
    }()
    let 내후기_수정_버튼 = {
    let button = UIButton()
        button.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 0.7)
        button.setImage(UIImage(named: "내후기edit"), for: .normal)
        button.setImage(UIImage(named: "내후기edit"), for: .selected)
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 20
        button.isEnabled = true
        return button
    }()
 
    let 내후기_삭제_버튼 = {
    let button = UIButton()
        button.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 0.7)
        button.setImage(UIImage(named: "내후기delete"), for: .normal)
        button.setImage(UIImage(named: "내후기delete"), for: .selected)
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 20
        button.isEnabled = true
        return button
    }()
    
  
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        캘린더_스케쥴_등록_셀_레이아웃()
        버튼_클릭()
        
        
        
//        if let 평균색상_추출 = UIColor.이미지_평균색상(from: UIImage(named: "claude")!)
            if let 평균색상_추출 = 전시_포스터_이미지.image?.이미지_평균색상(){
            이미지_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
            라벨_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
          }
    }
    
    
        
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension 캘린더_스케쥴_등록_셀 {
    
    func 버튼_클릭 () {
        내후기_수정_버튼.addTarget(self, action: #selector(내후기_수정_버튼_클릭), for: .touchUpInside)
        내후기_삭제_버튼.addTarget(self, action: #selector(내후기_삭제_버튼_클릭), for: .touchUpInside)

    }
    
    
    @objc func 내후기_수정_버튼_클릭 () {
        print("내후기_수정_버튼_클릭")
        if let 셀_제약_벗어난_뷰_띄우기 = self.findViewController() {
               let 수정_뷰 = 켈린더_수정_뷰컨트롤러()
               셀_제약_벗어난_뷰_띄우기.present(수정_뷰, animated: false, completion: nil)
           }
      }
        
    
    @objc func 내후기_삭제_버튼_클릭 () {
        print("내후기_삭제_버튼_클릭")
        if let 셀_제약_벗어난_뷰_띄우기 = self.findViewController() {
            let 수정_뷰 = 켈린더_삭제_뷰컨트롤러()
            셀_제약_벗어난_뷰_띄우기.present(수정_뷰, animated: false, completion: nil)
        }
    }
}






//셀 애니메이션+영역 재설정관련
extension 캘린더_스케쥴_등록_셀 {
    
    func 셀_클릭_애니메이션_on() {
           UIView.animate(withDuration: 0.3, animations: {
               self.transform = CGAffineTransform(translationX: -self.bounds.width * 5/10, y: 0)

           })
       }
    func 셀_클릭_애니메이션_off() {
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = .identity
            })
        }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
           let convertedPoint = 내후기_수정_버튼.convert(point, from: self)
           if 내후기_수정_버튼.bounds.contains(convertedPoint) {
               return 내후기_수정_버튼
           }
           
           let convertedPoint2 = 내후기_삭제_버튼.convert(point, from: self)
           if 내후기_삭제_버튼.bounds.contains(convertedPoint2) {
               return 내후기_삭제_버튼
           }
           
           return super.hitTest(point, with: event)
       }

}


extension 캘린더_스케쥴_등록_셀{
    func 캘린더_스케쥴_등록_셀_레이아웃() {
        contentView.addSubview(이미지_백)
        contentView.addSubview(라벨_백)
        contentView.addSubview(구분선)
        
        contentView.addSubview(전시_포스터_이미지)
        contentView.addSubview(전시명_라벨)
        contentView.addSubview(장소_라벨)
        contentView.addSubview(방문날짜_라벨)
        
        contentView.addSubview(내후기_버튼)
        
        contentView.addSubview(내후기_수정_버튼)
        contentView.addSubview(내후기_삭제_버튼)
        
        이미지_백.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(이미지_백.snp.height)
        }
        
        전시_포스터_이미지.snp.makeConstraints { make in
            make.edges.equalTo(이미지_백).inset(5)
        }
        
        라벨_백.snp.makeConstraints { make in
            make.top.bottom.equalTo(이미지_백)
            make.leading.equalTo(이미지_백.snp.trailing)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        구분선.snp.makeConstraints { make in
            make.centerY.equalTo(이미지_백)
            make.leading.equalTo(이미지_백.snp.trailing).offset(-40)
            make.size.equalTo(80)
        }
        
        전시명_라벨.snp.makeConstraints { make in
            make.top.equalTo(전시_포스터_이미지)
            make.leading.equalTo(라벨_백).offset(12)
            make.trailing.equalTo(내후기_버튼.snp.leading)
        }
        
        내후기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(전시명_라벨)
            make.trailing.equalTo(라벨_백).offset(-12)
            make.size.equalTo(24)
        }
        
        장소_라벨.snp.makeConstraints { make in
            make.top.equalTo(전시명_라벨.snp.bottom).offset(8)
            make.leading.equalTo(전시명_라벨)
        }
        
        방문날짜_라벨.snp.makeConstraints { make in
            make.leading.equalTo(전시명_라벨)
            make.bottom.equalTo(전시_포스터_이미지)
        }
        
        내후기_수정_버튼.snp.makeConstraints { make in
            make.top.bottom.equalTo(라벨_백)
            make.leading.equalTo(라벨_백.snp.trailing).offset(15)
            make.width.equalTo(80)
        }

        내후기_삭제_버튼.snp.makeConstraints { make in
            make.top.bottom.equalTo(라벨_백)
            make.leading.equalTo(내후기_수정_버튼.snp.trailing).offset(10)
            make.width.equalTo(80)
        }
    }
    
   
}


extension UIImage {
    func 이미지_평균색상() -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }
        let 입력_이미지 = CIImage(cgImage: cgImage)
        
        let 범위_벡터 = CIVector(x: 입력_이미지.extent.origin.x, y: 입력_이미지.extent.origin.y, z: 입력_이미지.extent.size.width, w: 입력_이미지.extent.size.height)
        let 필터 = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: 입력_이미지, kCIInputExtentKey: 범위_벡터])
        
        guard let 출력_이미지 = 필터?.outputImage else { return nil }
        
        var 비트맵 = [UInt8](repeating: 0, count: 4)
        let 컨텍스트 = CIContext(options: [.workingColorSpace: kCFNull ?? "" as AnyObject])
        컨텍스트.render(출력_이미지, toBitmap: &비트맵, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(비트맵[0]) / 255.0, green: CGFloat(비트맵[1]) / 255.0, blue: CGFloat(비트맵[2]) / 255.0, alpha: CGFloat(비트맵[3]) / 255.0)
    }
}


extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}