//
//  News.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI
import Kingfisher

struct News: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    @ObservedObject var postsapicall = PostsAPICall()
    
    var body: some View {
                    NavigationStack(path: $routerManager.routes){
                        VStack {
                            NavBar(title: "News")
                            ScrollView(showsIndicators: false){
                                VStack {
                                    ScrollView{
                                        VStack {
                                                ForEach(postsapicall.posts, id: \.id) { posts in
                                                    NavigationLink(destination: NewsDetail(post: posts)) {
                                                        //CardView
                                                        VStack(alignment: .leading, spacing: 6){
                                                            KFImage(URL(string: (posts.jetpack_featured_media_url )) ?? URL(string: EMPTY_IMAGE_URL)!)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                            HStack {
                                                                VStack(alignment: .leading) {
                                                                    Text("1 drużyna")
                                                                        .font(.system(size: 12))
                                                                        .foregroundColor(.white)
                                                                    Text(posts.title.rendered)
                                                                        .multilineTextAlignment(.leading)
                                                                        .font(.system(size: 22))
                                                                        .fontWeight(.black)
                                                                        .foregroundColor(.white)
                                                                        .lineLimit(3)
                                                                    Text("Kornel Krużewski")
                                                                        .padding(.top, 2)
                                                                        .font(.caption)
                                                                        .foregroundColor(.white)
                                                                }
                                                                .layoutPriority(100)
                                                         
                                                                Spacer()
                                                            }
                                                            .padding()
                                                        }
                                                        //CardView
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                            .onAppear {
                                postsapicall.getPosts()
                            }
                        }
                        .navigationDestination(for: Route.self) { $0 }
                        .navigationBarHidden(true)
                        .background(Color.black)
                    }
                    .onAppear {
                        print("News view appeared")
                    }
    }
}

struct News_Previews: PreviewProvider {
    static var previews: some View {
        News()
            .environmentObject(NavigationRouter())
            .environmentObject(PostsAPICall())
    }
}
