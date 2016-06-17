import Kanna

guard let
	url = URL(string: "https://developer.apple.com/videos/wwdc2016/"),
	data = try? Data(contentsOf: url),
	doc = Kanna.HTML(html: data, encoding: .utf8) else {
		fatalError("Could not load WWDC page")
}

let videoImages = doc.xpath("//section[starts-with(@class, 'all-content')]//img[starts-with(@src, 'http://devstreaming.apple.com/videos/wwdc/2016/')]")

struct VideoLink {
	let number: String
	let title: String
	let url: URL

	init?(xmlElement: XMLElement) {
		guard
			let title = xmlElement.at_xpath("@alt")?.text,
			let src = xmlElement.at_xpath("@src")?.text,
			var components = URLComponents(string: src),
			let basePathComponents = components.path?.components(separatedBy: "/")[0...5] else {
				return nil
		}

		let videoPathComponents = basePathComponents + ["hls_vod_mvp.m3u8"]
		let videoPath = videoPathComponents.joined(separator: "/")

		self.title = title
		number = basePathComponents[5]

		components.path = videoPath
		if let url = components.url {
			self.url = url
		} else {
			return nil
		}
	}
}

videoImages.flatMap(VideoLink.init).forEach {
	let channels = [6, 7]
	let mappedChannels = channels
		.map { "-map 0:\($0)" }
		.joined(separator: " ")
	print("ffmpeg -i \($0.url) \(mappedChannels) -c copy \"\($0.number) \($0.title).ts\"")
}
