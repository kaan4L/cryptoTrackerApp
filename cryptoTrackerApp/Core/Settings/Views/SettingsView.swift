import SwiftUI

struct SettingsView: View 
{
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://github.com/kaan4L")!
    let instagramURL = URL(string: "https://www.instagram.com/playboikaanye/")!
    let twitterURL = URL(string: "https://twitter.com/kaann4L")!
    
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                Color.theme.background
                    .ignoresSafeArea()
                
                List
                {
                    instagramSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    twitterSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    swiftfulthinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("settings")
            .toolbar
            {
                ToolbarItem(placement: .navigationBarLeading)
                {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview 
{
    SettingsView()
}

extension SettingsView
{
    private var swiftfulthinkingSection: some View
    {
        Section(header: Text("github"))
        {
            VStack(alignment: .leading)
            {
                Image("githubpp")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("this app made by kaan4L in github.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("visit github: kaan4L", destination: personalURL)
            
        }
    }
    
    private var coinGeckoSection: some View
    {
        Section(header: Text("coinGecko"))
        {
            VStack(alignment: .leading)
            {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("this is the site where we get the latest datas from.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("visit coingecko", destination: coinGeckoURL)
        }
    }
    
    private var instagramSection: some View
    {
        Section(header: Text("instagram"))
        {
            VStack(alignment: .leading)
            {
                Image("playboikaanye")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("💓Ⓜ️CertifiedMericLover💓Ⓜ️")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("instagram: playboikaanye", destination: instagramURL)
        }
    }
    private var twitterSection: some View
    {
        Section(header: Text("x"))
        {
            VStack(alignment: .leading)
            {
                Image("kaann4Ltw")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("cml")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("twitter: kaann4L", destination: twitterURL)
        }
    }
    
    private var applicationSection: some View
    {
        Section(header: Text("app"))
        {
            Link("terms of service", destination: defaultURL)
            Link("privacy policy", destination: defaultURL)
            Link("company website", destination: defaultURL)
            Link("learn more", destination: defaultURL)
        }
    }
}
