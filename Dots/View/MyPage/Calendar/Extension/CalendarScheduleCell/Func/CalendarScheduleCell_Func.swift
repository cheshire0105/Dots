import UIKit

extension 캘린더_스케쥴_등록_셀 {
    func 전시_포스터_이미지(from url: String) {
        guard let imageURL = URL(string: url) else {
            전시_포스터_이미지.image = UIImage(named: "기본프로필사진")
            return
        }
        
        전시_포스터_이미지.sd_setImage(with: imageURL) { [weak self] (image, error, _, _) in
            if let image = image {
                if let 평균색상_추출 = image.이미지_평균색상() {
                    self?.이미지_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
                    self?.라벨_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
                }
            }
        }
    }
}
