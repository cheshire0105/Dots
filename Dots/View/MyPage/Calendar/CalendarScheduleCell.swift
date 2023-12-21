import Foundation
import UIKit
import SnapKit

class 캘린더_스케쥴_등록_셀 : UITableViewCell {
    
    var 셀_데이터: 셀_데이터? {
          didSet {
              guard let 데이터 = 셀_데이터 else { return }

              전시_포스터_이미지(from: 데이터.포스터이미지URL)
              전시명_라벨.text = 데이터.전시명
              장소_라벨.text = 데이터.장소
              방문날짜_라벨.text = 데이터.방문날짜
          }
      }
    func 전시_포스터_이미지(from url: String) {
           guard let imageURL = URL(string: url) else {
               전시_포스터_이미지.image = UIImage(named: "기본프로필사진")
               return
           }

           전시_포스터_이미지.sd_setImage(with: imageURL, completed: nil)
       }
   
    
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
        label.text = "2022년 2월 2일"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           self.isUserInteractionEnabled = true
           backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)

           캘린더_스케쥴_등록_셀_레이아웃()
           
           
           if let 평균색상_추출 = 전시_포스터_이미지.image?.이미지_평균색상(){
               이미지_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
               라벨_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
           }
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.selectionStyle = .none
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


