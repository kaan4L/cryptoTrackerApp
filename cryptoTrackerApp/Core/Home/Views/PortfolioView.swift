import SwiftUI

struct PortfolioView: View 
{
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View
    {
        NavigationView
        {
            ScrollView
            {
                VStack(alignment: .leading, spacing: 0)
                {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil
                    {
                        VStack(spacing: 20)
                        {
                            HStack
                            {
                                Text("current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                                Spacer()
                                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                            }
                            Divider()
                            
                            HStack
                            {
                                Text("amount holding: ")
                                Spacer()
                                TextField("ex: 1.4", text: $quantityText)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            Divider()
                            
                            HStack
                            {
                                Text("current value:")
                                Spacer()
                                Text(getCurrentValue().asCurrencyWith2Decimals())
                            }
                        }
                        .animation(.none)
                        .padding()
                        .font(.headline)
                    }
                }
            }
            .background(Color.theme.background)
            .navigationTitle("edit portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) 
                {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    trailingNavBarButtons
                }
            })
            .onChange(of: vm.searchText, perform: { value in
                if value == ""
                {
                    removeSelectedCoin()
                }
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView
{
    private var coinLogoList: some View
    {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10)
            {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins)
                {   coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn)
                            {
                               updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private var trailingNavBarButtons: some View
    {
        HStack(spacing: 10)
        {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            
            Button(action:
            {
                saveButtonPressed()
            }, label:
            {
                Text("save".uppercased())
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ?
                1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func updateSelectedCoin(coin: CoinModel)
    {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings
        {
            quantityText = "\(amount)"
        }
        else
        {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double
    {
        if let quantity = Double(quantityText)
        {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View
    {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10)
            {
                ForEach(vm.allCoins)
                {   coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn)
                            {
                                selectedCoin = coin
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        })
    }
    
    private func saveButtonPressed()
    {
        guard 
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn)
        {
            showCheckMark = true
            removeSelectedCoin()
            
            UIApplication.shared.endEditing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
            {
                withAnimation(.easeOut)
                {
                    showCheckMark = false
                }
            }
        }
    }
    
    private func removeSelectedCoin()
    {
        selectedCoin = nil
        vm.searchText = ""
    }
    
}

