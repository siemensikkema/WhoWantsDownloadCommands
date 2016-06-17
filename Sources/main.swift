import Kanna

let url = URL(string: "https://developer.apple.com/videos/wwdc2016/")!
let data = try! Data(contentsOf: url)

guard let doc = Kanna.HTML(html: data, encoding: .utf8) else { fatalError() }

let videoImages = doc.xpath("//section[starts-with(@class, 'all-content')]//img[starts-with(@src, 'http://devstreaming.apple.com/videos/wwdc/2016/')]")

for videoImage in videoImages {
	let title = videoImage.at_xpath("@alt")!.text!
	let src = videoImage.at_xpath("@src")!.text!
	var components = URLComponents(string: src)!
	let basePathComponents = components.path!.components(separatedBy: "/")[0...5]
	let number = basePathComponents[5]
	let videoPathComponents = basePathComponents + ["hls_vod_mvp.m3u8"]
	let videoPath = videoPathComponents.joined(separator: "/")
	components.path = videoPath
	let videoURL = components.url!

	print("ffmpeg -i \(videoURL) -map 0:6 -map 0:7 -c copy \"\(number) \(title).ts\"")
}
