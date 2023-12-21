import SwiftUI

struct DetailLoadingView: View 
{
    @Binding var coin: CoinModel?
    
    var body: some View
    {
        ZStack
        {
            if let coin = coin
            {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View
{
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescripotion: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel)
    {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initializing detail view for \(coin.name)")
    }
    
    var body: some View
    {
        ScrollView
        {
            VStack
            {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20)
                {
                    overViewTitle
                    Divider()
                    descriptionSection
                    overViewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                    }
                .padding()
            }
        }
        .background(Color.theme.background.ignoresSafeArea())
        
        .navigationTitle(vm.coin.name)
        .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing) 
            {
                navigationBarTrailingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider 
{
    static var previews: some View
    {
        NavigationView
        {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView
{
    private var navigationBarTrailingItems: some View
    {
        HStack
        {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overViewTitle: some View
    {
        Text("overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var additionalTitle: some View
    {
        Text("additional details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View
    {
        ZStack
        {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty
            {
                VStack(alignment: .leading)
                {
                    Text(coinDescription)
                        .lineLimit(showFullDescripotion ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    
                    Button(action: {
                        withAnimation(.easeInOut)
                        {
                            showFullDescripotion.toggle()
                        }
                    } ,label: {
                        Text(showFullDescripotion ? "less" : "read more")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overViewGrid: some View
    {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content:
        {
            ForEach(vm.overViewStatistics) { stat in
                StatisticsView(stat: stat)
            }
        })
    }
    
    private var additionalGrid: some View
    {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content:
        {
            ForEach(vm.additionalViewStatistics) { stat in
                StatisticsView(stat: stat)
            }
        })
    }
    
    private var websiteSection: some View
    {
        VStack(alignment: .leading, spacing: 20)
        {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString)
            {
                Link("website", destination: url)
            }
            
            if let redditString = vm.websiteURL,
               let url = URL(string: redditString)
            {
                Link("reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}

    
