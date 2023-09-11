//
//  NewsDetail.swift
//  AMP
//
//  Created by Kornel Krużewski on 04/09/2023.
//

import SwiftUI
import SwiftSoup
import Kingfisher

struct NewsDetail: View {
    let post: Posts
    @State private var decodedText: String? = nil
    @State private var webViewHeight: CGFloat = .zero
    
    var body: some View {
            VStack {
                NavBarNews(share_url: post.slug)
                GeometryReader { geo in
                    ScrollView(.vertical, showsIndicators: false, content: {
                                if let imageUrl = URL(string: post.jetpack_featured_media_url), post.jetpack_featured_media_url != nil {
                                    KFImage(imageUrl)
                                        .loadImmediately()
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geo.size.width, height: geo.size.height / 3)
                                        .clipped()
                                } else {
                                    KFImage(URL(string: EMPTY_IMAGE_URL))
                                        .loadImmediately()
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geo.size.width, height: geo.size.height / 3)
                                        .clipped()
                                }
                        VStack(alignment: .leading, spacing: 8.0, content: {
                            WebView(dynamicHeight: $webViewHeight,htmlContent: post.content.rendered)
                                .font(Font.custom("Roboto-Italic", size: 12))
                                .frame(height: webViewHeight)
                        })
                        .padding(12)
                    })
                }
                .padding(.top, -7)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.black)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(post: Posts.default)
    }
}
