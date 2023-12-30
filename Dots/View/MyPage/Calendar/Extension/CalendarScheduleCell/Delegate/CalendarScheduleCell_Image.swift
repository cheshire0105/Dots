import UIKit


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


