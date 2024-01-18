import SwiftUI

struct ContentView: View {
    @State private var showForm: Bool = true
    @State private var orderItems: [OrderItem] = []
    @State private var userCustomerList: [String] = []
    @State private var newSelectedCustomer = "入力してください"
    @State private var newCustomerName = ""
    @State private var newBentoName = ""
    @State private var selectedBentoIndex = 0
    @State private var newSize = "普通"
    @State private var newCustomValue = 0
    @State private var recordedDate: String = "None"
    @State private var recordedDateSmall: String = "None"
    @State private var newQuantity = 1
    @State private var eatin: Bool = false
    @State private var newTaxRate = 8
    @State private var newTax = 0
    @State private var newPrice = 0
    @State private var newTotalPrice = 0
    @State private var newNote = ""
    @State private var tax10: Double = 0.0
    @State private var tax10include = 0
    @State private var tax10notInclude = 0
    @State private var tax8: Double = 0.0
    @State private var tax8include = 0
    @State private var tax8notInclude = 0
    @AppStorage("viewStyle") var addViewStyle = 1
    @State private var selectedBentoMenu = "ランチ" //MenuViewOnly
    
    @State private var showSettings: Bool = false
    
    
    let bentoList: [BentoItem] = [
        BentoItem(name: "ランチ", abbreviation: "ランチ", basePrice: 380),
        BentoItem(name: "その他", abbreviation: "その他", basePrice: 0),
        BentoItem(name: "特上幕の内弁当(五目弁当)", abbreviation: "特上幕の内", basePrice: 600),
        BentoItem(name: "DX幕の内弁当", abbreviation: "DX幕の内", basePrice: 500),
        BentoItem(name: "幕の内弁当", abbreviation: "幕の内", basePrice: 400),
        BentoItem(name: "幕の外弁当", abbreviation: "幕の外", basePrice: 350),
        BentoItem(name: "DXくっく弁当", abbreviation: "DXくっく", basePrice: 600),
        BentoItem(name: "くっく弁当", abbreviation: "くっく", basePrice: 500),
        BentoItem(name: "うなぎ弁当", abbreviation: "うなぎ", basePrice: 700),
        BentoItem(name: "DXのり弁当", abbreviation: "DXのり弁", basePrice: 380),
        BentoItem(name: "のり弁", abbreviation: "のり弁", basePrice: 330),
        BentoItem(name: "DXてりやき弁当", abbreviation: "DXてり", basePrice: 480),
        BentoItem(name: "DXエビ＆ハンバーグ弁当", abbreviation: "DXえびハン", basePrice: 500),
        BentoItem(name: "エビ＆ハンバーグ弁当", abbreviation: "エビハン", basePrice: 480),
        BentoItem(name: "DXハンバーグ弁当", abbreviation: "DXハン", basePrice: 430),
        BentoItem(name: "ハンバーグ弁当", abbreviation: "ハンバーグ", basePrice: 380),
        BentoItem(name: "SPハンバーグ弁当", abbreviation: "SPハン", basePrice: 580),
        BentoItem(name: "ロコモコハンバーグ", abbreviation: "ロコモコ", basePrice: 400),
        BentoItem(name: "鮭弁当", abbreviation: "鮭弁当", basePrice: 330),
        BentoItem(name: "コロッケ弁当", abbreviation: "コロッケ", basePrice: 300),
        BentoItem(name: "酢豚弁当", abbreviation: "酢豚", basePrice: 600),
        BentoItem(name: "エビフライ弁当", abbreviation: "エビフライ", basePrice: 500),
        BentoItem(name: "カキフライ弁当", abbreviation: "カキフライ", basePrice: 400),
        BentoItem(name: "唐揚げ弁当", abbreviation: "唐揚げ", basePrice: 400),
        BentoItem(name: "とり天弁当", abbreviation: "とり天", basePrice: 400),
        BentoItem(name: "野菜炒め弁当", abbreviation: "野菜炒め" ,basePrice: 400),
        BentoItem(name: "サバ弁当", abbreviation: "さば", basePrice: 400),
        BentoItem(name: "カニクリームコロッケ弁当", abbreviation: "カニクリ", basePrice: 40),
        BentoItem(name: "ヒレカツ", abbreviation: "ヒレカツ", basePrice: 680),
        BentoItem(name: "お好み弁当", abbreviation: "お好み", basePrice: 500),
        BentoItem(name: "みそ串カツ弁当", abbreviation: "味噌串", basePrice: 450),
        BentoItem(name: "（味噌）ロースカツ弁当", abbreviation: "味噌ロース", basePrice: 500),
        BentoItem(name: "（ソース）ロースカツ弁当", abbreviation: "ソースロース", basePrice: 500),
        BentoItem(name: "（味噌）プレミアムロースカツ弁当", abbreviation: "味噌プレロース", basePrice: 680),
        BentoItem(name: "（ソース）プレミアムロースカツ弁当", abbreviation: "ソースプレロー", basePrice: 680),
        BentoItem(name: "お子様弁当", abbreviation: "お子様", basePrice: 350),
        BentoItem(name: "シューマイ弁当", abbreviation: "シューマイ", basePrice: 500),
        BentoItem(name: "チキンカツ弁当", abbreviation: "チキンカツ", basePrice: 500),
        BentoItem(name: "DX焼きうどん弁当", abbreviation: "DXうどん", basePrice: 450),
        BentoItem(name: "焼きうどん弁当", abbreviation: "焼きうどん", basePrice: 380),
        BentoItem(name: "DX焼きそば弁当", abbreviation: "DXそば", basePrice: 450),
        BentoItem(name: "焼きそば弁当", abbreviation: "焼きそば", basePrice: 380),
        BentoItem(name: "DX焼肉弁当", abbreviation: "DX焼肉", basePrice: 500),
        BentoItem(name: "焼肉弁当", abbreviation: "焼肉", basePrice: 400),
        BentoItem(name: "牛肉スタミナ弁当", abbreviation: "牛スタ", basePrice: 550),
        BentoItem(name: "豚肉生姜焼き弁当", abbreviation: "生姜焼き", basePrice: 500),
        BentoItem(name: "牛モツ元気弁当", abbreviation: "牛モツ", basePrice: 550),
        BentoItem(name: "チキン南蛮弁当", abbreviation: "チキン南蛮", basePrice: 500),
        BentoItem(name: "カレーうどん", abbreviation: "カレーうどん", basePrice: 480),
        BentoItem(name: "カレーライス", abbreviation: "カレー", basePrice: 380),
        BentoItem(name: "カツカレー", abbreviation: "カツカレー", basePrice: 600),
        BentoItem(name: "エビカレー", abbreviation: "エビカレー", basePrice: 550),
        BentoItem(name: "ハンバーグカレー", abbreviation: "ハンカレー", basePrice: 550),
        BentoItem(name: "コロッケカレー", abbreviation: "コロカレー", basePrice: 400),
        BentoItem(name: "唐揚げカレー", abbreviation: "唐揚カレー", basePrice: 580),
        BentoItem(name: "四川麻婆豆腐丼", abbreviation: "麻婆豆腐", basePrice: 450),
        BentoItem(name: "玉子丼", abbreviation: "玉子丼", basePrice: 400),
        BentoItem(name: "カツ丼", abbreviation: "カツ丼", basePrice: 580),
        BentoItem(name: "天丼", abbreviation: "天丼", basePrice: 550),
        BentoItem(name: "親子丼", abbreviation: "親子丼", basePrice: 450),
        BentoItem(name: "カルビ丼", abbreviation: "カルビ丼", basePrice: 500),
        BentoItem(name: "中華丼", abbreviation: "中華丼", basePrice: 550),
        BentoItem(name: "天津丼", abbreviation: "天津丼", basePrice: 500),
        BentoItem(name: "牛丼", abbreviation: "牛丼", basePrice: 480),
        BentoItem(name: "豚メンマ丼",  abbreviation: "豚メンマ丼",basePrice: 450),
        BentoItem(name: "エビピラフ", abbreviation: "エビピラフ", basePrice: 400),
        BentoItem(name: "高菜ピラフ", abbreviation: "高菜ピラフ", basePrice: 400),
        BentoItem(name: "チキンピラフ",  abbreviation: "チキンピラフ",basePrice: 400),
        BentoItem(name: "ドライカレーピラフ", abbreviation: "ドライカレー", basePrice: 400),
        BentoItem(name: "鮭ご飯",  abbreviation: "鮭ご飯",basePrice: 350),
        BentoItem(name: "五目ご飯", abbreviation: "五目ご飯", basePrice: 380),
        BentoItem(name: "（鮭）おにぎり", abbreviation: "鮭", basePrice: 100),
        BentoItem(name: "（昆布）おにぎり", abbreviation: "昆布", basePrice: 100),
        BentoItem(name: "（しぐれ）おにぎり", abbreviation: "しぐれ", basePrice: 100),
        BentoItem(name: "（うめ）おにぎり", abbreviation: "うめ", basePrice: 100),
        BentoItem(name: "（たらこ）おにぎり", abbreviation: "たらこ", basePrice: 100),
        BentoItem(name: "（おかか）おにぎり", abbreviation: "おかか", basePrice: 100)
    ]
    
    let customList: [Custom] = [
        Custom(name: "普通", value: 0),
        Custom(name: "大盛り", value: 50),
        Custom(name: "小盛り", value: -50),
        Custom(name: "おかず大盛り", value: 100),
        Custom(name: "両大", value: 150)
    ]
    
    var selectedBento: BentoItem {
        return bentoList[selectedBentoIndex]
    }
    
    var menuButtons: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    
    
    var body: some View {
        NavigationView {
            HStack {
                if showForm == true {
                    VStack {
                        Picker("カスタム", selection: $addViewStyle) {
                            Text("Form").tag(1)
                            Text("Menu").tag(2)
                        }.pickerStyle(.segmented)
                        if addViewStyle == 1 {
                            VStack {
                                Form {
                                    Section(header: Text("Order")) {
                                        Picker("Customer", selection: $newSelectedCustomer) {
                                            ForEach(userCustomerList, id: \.self) { index in
                                                Text(index)
                                            }
                                        }
                                        if newSelectedCustomer == "入力してください" {
                                            TextField("顧客", text: $newCustomerName)
                                        }
                                        
                                        Picker("弁当", selection: $selectedBentoIndex) {
                                            ForEach(0..<bentoList.count, id: \.self) { index in
                                                Text(bentoList[index].name)
                                            }
                                        }
                                        if selectedBento.name == "その他" {
                                            TextField("品名", text: $newBentoName)
                                            TextField("Price", value: $newPrice, formatter: NumberFormatter())
                                        }
                                        if selectedBento.name.contains("おにぎり") {
                                        } else {
                                            Picker("カスタム", selection: $newSize) {
                                                ForEach(customList, id: \.name) { custom in
                                                    Text(custom.name)
                                                }
                                            }.pickerStyle(.segmented)
                                        }
                                        if newSelectedCustomer == "店内"    {
                                            Text("イートイン　消費税率10％")
                                        } else if newSelectedCustomer == "持ち帰り" {
                                            Text("お持ち帰り　消費税率8％")
                                        } else {
                                            Toggle("イートイン", isOn: $eatin)
                                        }
                                        HStack {
                                            Stepper("Quantity", value: $newQuantity)
                                            TextField("",value: $newQuantity, formatter: NumberFormatter()).frame(maxWidth: 50).textFieldStyle(RoundedBorderTextFieldStyle())
                                        }
                                        HStack {
                                            TextField("Note", text: $newNote)
                                            if newNote != "" {
                                                Button {
                                                    newNote = ""
                                                } label: {
                                                    Image(systemName: "xmark.circle.fill")
                                                }.buttonStyle(.plain)
                                            }
                                        }
                                        Button("Add") {
                                            let currentDate = Date()
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yyyy-MM-dd"
                                            recordedDate = dateFormatter.string(from: currentDate)
                                            recordedDateSmall = dateFormatter.string(from: currentDate)
                                            if newSelectedCustomer != "入力してください" {
                                                newCustomerName = newSelectedCustomer
                                            } else if newCustomerName == "" {
                                                newCustomerName = "名前なし"
                                            }
                                            if newCustomerName == "店内" {
                                                self.eatin = true
                                            } else if newCustomerName == "持ち帰り" {
                                                self.eatin = false
                                            }
                                            
                                            if selectedBento.name != "その他" {
                                                newBentoName = selectedBento.name
                                                newPrice = selectedBento.basePrice
                                            }
                                            if eatin == true {
                                                newTaxRate = 10
                                            } else {
                                                newTaxRate = 8
                                            }
                                            if let selectedCustom = customList.first(where: { $0.name == newSize }) {
                                                newCustomValue = selectedCustom.value
                                                newPrice += newCustomValue
                                            }
                                            newTotalPrice = newPrice * newQuantity
                                            let newItem = OrderItem(date: recordedDate, customer: newCustomerName, name: newBentoName, size: newSize, quantity: newQuantity, price: newPrice, taxRate: newTaxRate, tax: newTax, totalPrice: newTotalPrice, note: newNote)
                                            saveOrderItem(orderItem: newItem)
                                            selectedBentoIndex = 0
                                            newCustomerName = ""
                                            newSelectedCustomer = "入力してください"
                                            newBentoName = ""
                                            newPrice = 0
                                            newQuantity = 1
                                            newTotalPrice = 0
                                            newSize = "普通"
                                            newCustomValue = 0
                                            eatin = false
                                        }.keyboardShortcut(.defaultAction)
                                    }
                                }
                                Button("Delete All Userdefaults") {
                                    orderItems.removeAll()
                                    if let newData = try? JSONEncoder().encode(orderItems) {
                                        UserDefaults.standard.set(newData, forKey: "orderItems")
                                    }
                                }
                            }
                        } else {
                            ScrollView {
                                HStack {
                                    Picker("Customer", selection: $newSelectedCustomer) {
                                        ForEach(userCustomerList, id: \.self) { index in
                                            Text(index).font(.title)
                                        }
                                    }
                                    if newSelectedCustomer == "入力してください" {
                                        TextField("顧客", text: $newCustomerName).textFieldStyle(RoundedBorderTextFieldStyle())
                                    } else {
                                        Spacer()
                                    }
                                }.font(.title)
                                LazyVGrid(columns: menuButtons) {
                                    ForEach((bentoList), id: \.name) { bento in
                                        if selectedBentoMenu == bento.name {
                                            Button {
                                                selectedBentoMenu = "ランチ"
                                                newPrice = 380
                                            } label: {
                                                ZStack {
                                                    Capsule().stroke(Color.red, lineWidth: 5).frame(height: 70)
                                                    Text(bento.abbreviation).font(.title3).padding()
                                                }
                                            }
                                        } else {
                                            Button {
                                                selectedBentoMenu = bento.name
                                                newPrice = bento.basePrice
                                            } label: {
                                                ZStack {
                                                    Capsule().stroke(Color.yellow, lineWidth: 5).frame(height: 70)
                                                    Text(bento.abbreviation).font(.title3).padding()
                                                }
                                            }
                                        }
                                    }
                                }.font(.largeTitle).onAppear {
                                    selectedBentoMenu = "ランチ"
                                    newPrice = 380
                                }.padding()
                                if selectedBentoMenu == "その他" {
                                    TextField("品名", text: $newBentoName)
                                    TextField("Price", value: $newPrice, formatter: NumberFormatter())
                                }
                                Divider()
                                LazyVGrid(columns: menuButtons) {
                                    ForEach(customList, id: \.name) { custom in
                                        if newSize == custom.name {
                                            Button {
                                                newSize = "普通"
                                            } label: {
                                                ZStack {
                                                    Capsule().stroke(Color.red, lineWidth: 5).frame(height: 70)
                                                    Text(custom.name).font(.title3).padding()
                                                }
                                            }
                                        } else {
                                            Button {
                                                newSize = custom.name
                                            } label: {
                                                ZStack {
                                                    Capsule().stroke(Color.blue, lineWidth: 5).frame(height: 70)
                                                    Text(custom.name).font(.title3).padding()
                                                }
                                            }
                                        }
                                    }
                                }.padding()
                                Divider()
                                HStack {
                                    if newSelectedCustomer == "お持ち帰り" {
                                        ZStack {
                                            Capsule().stroke(Color.red, lineWidth: 5).frame(height: 70)
                                            Text("お持ち帰り 8％").font(.title3).padding()
                                        }
                                        ZStack {
                                            Capsule().stroke(Color.gray, lineWidth: 5).frame(height: 70)
                                            Text("店内 10%").font(.title3).padding()
                                        }
                                    } else if newSelectedCustomer == "店内" {
                                        ZStack {
                                            Capsule().stroke(Color.gray, lineWidth: 5).frame(height: 70)
                                            Text("お持ち帰り 8％").font(.title3).padding()
                                        }
                                        ZStack {
                                            Capsule().stroke(Color.red, lineWidth: 5).frame(height: 70)
                                            Text("店内 10%").font(.title3).padding()
                                        }
                                    } else {
                                        HStack {
                                            Button {
                                                eatin = false
                                            } label: {
                                                ZStack {
                                                    if eatin == false {
                                                        Capsule().stroke(Color.red, lineWidth: 5).frame(height: 70)
                                                    } else {
                                                        Capsule().stroke(Color.blue, lineWidth: 5).frame(height: 70)
                                                    }
                                                    Text("お持ち帰り 8％").font(.title3).padding()
                                                }
                                            }
                                            Button {
                                                eatin = true
                                            } label: {
                                                ZStack {
                                                    if eatin == true {
                                                        Capsule().stroke(Color.red, lineWidth: 5).frame(height: 70)
                                                    } else {
                                                        Capsule().stroke(Color.blue, lineWidth: 5).frame(height: 70)
                                                    }
                                                    Text("店内 10%").font(.title3).padding()
                                                }
                                            }
                                        }
                                    }
                                }.padding()
                                HStack {
                                    Button {
                                        newQuantity += 1
                                    } label: {
                                        Image(systemName: "plus")
                                    }
                                    TextField("",value: $newQuantity, formatter: NumberFormatter()).frame(maxWidth: 50).textFieldStyle(RoundedBorderTextFieldStyle()).minimumScaleFactor(0.5)
                                    Button {
                                        newQuantity += -1
                                    } label: {
                                        Image(systemName: "minus")
                                    }
                                }.font(.largeTitle)
                                HStack {
                                    TextField("Note", text: $newNote).textFieldStyle(RoundedBorderTextFieldStyle())
                                    if newNote != "" {
                                        Button {
                                            newNote = ""
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                        }.buttonStyle(.plain)
                                    }
                                }
                                Button("追加") {
                                    let currentDate = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd"
                                    recordedDate = dateFormatter.string(from: currentDate)
                                    recordedDateSmall = dateFormatter.string(from: currentDate)
                                    if newSelectedCustomer != "入力してください" {
                                        newCustomerName = newSelectedCustomer
                                    } else if newCustomerName == "" {
                                        newCustomerName = "名前なし"
                                    }
                                    
                                    if newCustomerName == "店内" {
                                        self.eatin = true
                                    } else if newCustomerName == "持ち帰り" {
                                        self.eatin = false
                                    }
                                    if selectedBentoMenu != "その他" {
                                        newBentoName = selectedBentoMenu
                                    }
                                    if eatin == true {
                                        newTaxRate = 10
                                    } else {
                                        newTaxRate = 8
                                    }
                                    if let selectedCustom = customList.first(where: { $0.name == newSize }) {
                                        newCustomValue = selectedCustom.value
                                        newPrice += newCustomValue
                                    }
                                    newTotalPrice = newPrice * newQuantity
                                    let newItem = OrderItem(date: recordedDate, customer: newCustomerName, name: newBentoName, size: newSize, quantity: newQuantity, price: newPrice, taxRate: newTaxRate, tax: newTax, totalPrice: newTotalPrice, note: newNote)
                                    saveOrderItem(orderItem: newItem)
                                    selectedBentoIndex = 0
                                    newCustomerName = ""
                                    newBentoName = ""
                                    newQuantity = 1
                                    newTotalPrice = 0
                                    newSize = "普通"
                                    newCustomValue = 0
                                    eatin = false
                                    selectedBentoMenu = "ランチ"
                                    newPrice = 380
                                }.buttonStyle(.bordered)
                                    .bold()
                                    .font(.largeTitle)
                                    .keyboardShortcut(.defaultAction)
                            }
                        }
                    }.padding()
                }
                VStack {
                    HStack {
                        Toggle(isOn: $showForm) {
                            Text(showForm ? Image(systemName: "arrow.left.to.line") : Image(systemName: "arrow.right.to.line"))
                        }.toggleStyle(.button)
                        Text("Order")
                        Spacer()
                        Button {
                            self.showSettings = true
                        } label: {
                            Image(systemName: "gear")
                        }
                        
                    }.padding()
                    Table(orderItems) {
                        TableColumn("Date") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.date)").font(.title2).bold()
                                    }
                                    Table(orderItems.filter {$0.date == order.date}) {
                                        TableColumn("Customer") { order in
                                            Text(order.customer).bold()
                                        }
                                        TableColumn("Name") { order in
                                            Text(order.name).bold()
                                        }
                                        TableColumn("カスタム") { order in
                                            Text("\(order.size)")
                                        }
                                        TableColumn("Price") { order in
                                            Text("\(order.price)")
                                        }
                                        TableColumn("Quantity") { order in
                                            Text("\(order.quantity)")
                                        }
                                        TableColumn("Total") { order in
                                            Text("\(order.totalPrice)")
                                        }
                                        TableColumn("Tax") { order in
                                            Text("\(order.taxRate)")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                }
                            } label: {
                                Text(order.date)
                            }
                        }
                        TableColumn("Customer") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.customer)").font(.title2).bold()
                                    }
                                    Table(orderItems.filter {$0.customer == order.customer}) {
                                        TableColumn("Date") { oeder in
                                            Text(order.date)
                                        }
                                        TableColumn("Name") { order in
                                            Text(order.name).bold()
                                        }
                                        TableColumn("カスタム") { order in
                                            Text("\(order.size)")
                                        }
                                        TableColumn("Price") { order in
                                            Text("\(order.price)")
                                        }
                                        TableColumn("Quantity") { order in
                                            Text("\(order.quantity)")
                                        }
                                        TableColumn("Total") { order in
                                            Text("\(order.totalPrice)")
                                        }
                                        TableColumn("Tax") { order in
                                            Text("\(order.taxRate)%")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                    Grid {
                                        GridRow {
                                            Text("税率")
                                            Text("税抜価格")
                                            Text("税金")
                                            Text("税込価格")
                                        }
                                        if tax8include != 0 {
                                            GridRow {
                                                Text("8%")
                                                Text("\(tax8notInclude)")
                                                Text(String(format: "%.1f", tax8))
                                                Text("\(tax8include)")
                                            }
                                        }
                                        if tax10include != 0 {
                                            GridRow {
                                                Text("10%")
                                                Text("\(tax10notInclude)")
                                                Text(String(format: "%.1f", tax10))
                                                Text("\(tax10include)")
                                            }
                                        }
                                    }.padding().font(.title3)
                                }.onAppear {
                                    tax8include = orderItems.filter { $0.taxRate == 8 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax8 = Double(tax8include) * 1.08 - Double(tax8include)
                                    tax8notInclude = tax8include - Int(tax8)
                                    tax10include = orderItems.filter { $0.taxRate == 10 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax10 = Double(tax10include) * 1.1 - Double(tax10include)
                                    tax10notInclude = tax10include - Int(tax10)
                                }
                            } label: {
                                Text(order.customer).bold()
                            }
                        }
                        TableColumn("Name") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.name)").font(.title2).bold()
                                        Text("￥\(order.price)").bold()
                                    }
                                    Table(orderItems.filter {$0.name == order.name}) {
                                        TableColumn("Date") { oeder in
                                            Text(order.date)
                                        }
                                        TableColumn("Customer") { order in
                                            Text(order.customer).bold()
                                        }
                                        TableColumn("カスタム") { order in
                                            Text("\(order.size)")
                                        }
                                        TableColumn("Price") { order in
                                            Text("\(order.price)")
                                        }
                                        TableColumn("Quantity") { order in
                                            Text("\(order.quantity)")
                                        }
                                        TableColumn("Total") { order in
                                            Text("\(order.totalPrice)")
                                        }
                                        TableColumn("Tax") { order in
                                            Text("\(order.taxRate)")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                    Grid {
                                        GridRow {
                                            Text("税率")
                                            Text("税抜価格")
                                            Text("税金")
                                            Text("税込価格")
                                        }
                                        if tax8include != 0 {
                                            GridRow {
                                                Text("8%")
                                                Text("\(tax8notInclude)")
                                                Text(String(format: "%.1f", tax8))
                                                Text("\(tax8include)")
                                            }
                                        }
                                        if tax10include != 0 {
                                            GridRow {
                                                Text("10%")
                                                Text("\(tax10notInclude)")
                                                Text(String(format: "%.1f", tax10))
                                                Text("\(tax10include)")
                                            }
                                        }
                                    }.padding().font(.title3)
                                }.onAppear {
                                    tax8include = orderItems.filter { $0.taxRate == 8 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax8 = Double(tax8include) * 1.08 - Double(tax8include)
                                    tax8notInclude = tax8include - Int(tax8)
                                    tax10include = orderItems.filter { $0.taxRate == 10 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax10 = Double(tax10include) * 1.1 - Double(tax10include)
                                    tax10notInclude = tax10include - Int(tax10)
                                }
                            } label: {
                                Text(order.name).bold()
                            }
                        }
                        TableColumn("カスタム") { order in
                            Text("\(order.size)")
                        }
                        TableColumn("Price") { order in
                            Text("\(order.price)")
                        }
                        TableColumn("Quantity") { order in
                            Text("\(order.quantity)")
                        }
                        TableColumn("Total") { order in
                            Text("\(order.totalPrice)")
                        }
                        TableColumn("Tax") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.taxRate)%").font(.title2).bold()
                                        if order.taxRate == 8 {Text("配達・テイクアウト")} else { Text("イートイン") }
                                    }
                                    Table(orderItems.filter {$0.taxRate == order.taxRate}) {
                                        TableColumn("Date") { oeder in
                                            Text(order.date)
                                        }
                                        TableColumn("Customer") { order in
                                            Text("\(order.customer)")
                                        }
                                        TableColumn("商品名") { order in
                                            Text("\(order.name)")
                                        }
                                        TableColumn("Price") { order in
                                            Text("\(order.price)")
                                        }
                                        TableColumn("Quantity") { order in
                                            Text("\(order.quantity)")
                                        }
                                        TableColumn("Total") { order in
                                            Text("\(order.totalPrice)")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                    Grid {
                                        GridRow {
                                            Text("税率")
                                            Text("税抜価格")
                                            Text("税金")
                                            Text("税込価格")
                                        }
                                        GridRow {
                                            Text("\(order.taxRate)")
                                            if order.taxRate == 8 {
                                                Text("\(tax8notInclude)")
                                                Text(String(format: "%.1f", tax8))
                                                Text("\(tax8include)")
                                            } else {
                                                Text("\(tax10notInclude)")
                                                Text(String(format: "%.1f", tax10))
                                                Text("\(tax10include)")
                                            }
                                        }
                                    }.padding().font(.title3)
                                }.onAppear {
                                    tax8include = orderItems.filter { $0.taxRate == 8 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax8 = Double(tax8include) * 1.08 - Double(tax8include)
                                    tax8notInclude = tax8include - Int(tax8)
                                    tax10include = orderItems.filter { $0.taxRate == 10 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax10 = Double(tax10include) * 1.1 - Double(tax10include)
                                    tax10notInclude = tax10include - Int(tax10)
                                }
                            } label: {
                                Text("\(order.taxRate)%").bold()
                            }
                        }
                        TableColumn("Note") { order in
                            Text("\(order.note)")
                        }
                        TableColumn("Edit") { order in
                            Button("Delete") {
                                deleteOrderItem(order)
                            }
                        }.width(70)
                    }
                }
                
            }.onAppear {
                if userCustomerList == [] {
                    userCustomerList.append("入力してください")
                    userCustomerList.append("店内")
                    userCustomerList.append("お持ち帰り")
                    UserDefaults.standard.set(userCustomerList, forKey: "userCustomerList")
                }
                loadUserCustomer()
                loadOrderItems()
            }
        }.navigationViewStyle(.stack).navigationTitle("Order")
            .sheet(isPresented: $showSettings) {
                SettingsView(userCustomerList: $userCustomerList)
            }
    }
    
    //MARK: Func
    func saveOrderItem(orderItem: OrderItem) {
        do {
            if let data = UserDefaults.standard.data(forKey: "orderItems") {
                var savedOrderItems = try JSONDecoder().decode([OrderItem].self, from: data)
                savedOrderItems.append(orderItem)
                if let newData = try? JSONEncoder().encode(savedOrderItems) {
                    UserDefaults.standard.set(newData, forKey: "orderItems")
                }
            } else {
                let newOrderItems = [orderItem]
                if let newData = try? JSONEncoder().encode(newOrderItems) {
                    UserDefaults.standard.set(newData, forKey: "orderItems")
                }
            }
        } catch {
            print("Error saving order item: \(error)")
        }
        loadOrderItems()
        
    }
    func loadOrderItems() {
        if let data = UserDefaults.standard.data(forKey: "orderItems") {
            if let savedOrderItems = try? JSONDecoder().decode([OrderItem].self, from: data) {
                orderItems = savedOrderItems
            }
        }
    }
    func deleteOrderItem(_ item: OrderItem) {
        if let index = orderItems.firstIndex(where: { $0.id == item.id }) {
            orderItems.remove(at: index)
            if let newData = try? JSONEncoder().encode(orderItems) {
                UserDefaults.standard.set(newData, forKey: "orderItems")
            }
            
        }
    }
    
    func loadUserCustomer() {
        userCustomerList = UserDefaults.standard.stringArray(forKey: "userCustomerList") ?? []
    }
}

//MARK: 設定
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newCustomerName = ""
    @Binding var userCustomerList: [String]
    @FocusState var input: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink {
                        VStack {
                            HStack {
                                TextField("名前を入力", text: $newCustomerName).focused($input).textFieldStyle(RoundedBorderTextFieldStyle())
                                Button("保存") {
                                    saveCustomer()
                                }.keyboardShortcut(.defaultAction).onSubmit {
                                    self.input = true
                                }
                            }.onAppear {
                                self.input = true
                            }
                            List {
                                ForEach(userCustomerList, id: \.self) { customer in
                                    HStack {
                                        Text(customer)
                                        Spacer()
                                        if customer == "入力してください" {
                                            Text("削除").foregroundStyle(Color.gray)
                                        } else if customer == "店内" {
                                            Text("削除").foregroundStyle(Color.gray)
                                        } else if customer == "お持ち帰り" {
                                            Text("削除").foregroundStyle(Color.gray)
                                        } else {
                                            Button("削除") {
                                                deleteCustomer(customer)
                                            }.foregroundColor(.red)
                                        }
                                        
                                    }
                                }
                            }
                            Button("リセットする") {
                                userCustomerList.removeAll()
                                userCustomerList.append("入力してください")
                                userCustomerList.append("店内")
                                userCustomerList.append("お持ち帰り")
                                UserDefaults.standard.set(userCustomerList, forKey: "userCustomerList")
                            }
                        }.padding()
                        
                    } label: {
                        Text("顧客リスト")
                    }
                }
            }
            .padding()
            .navigationTitle("情報")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }.bold()
                }
            }
        }
    }
    func saveCustomer() {
        guard !newCustomerName.isEmpty else { return }
        userCustomerList.append(newCustomerName)
        UserDefaults.standard.set(userCustomerList, forKey: "userCustomerList")
        
        newCustomerName = ""
    }
    
    func deleteCustomer(_ name: String) {
        if userCustomerList.count == 1 {
            userCustomerList.append("入力してください")
            userCustomerList.append("店内")
            userCustomerList.append("お持ち帰り")
            UserDefaults.standard.set(userCustomerList, forKey: "userCustomerList")
            if let index = userCustomerList.firstIndex(of: name) {
                userCustomerList.remove(at: index)
                UserDefaults.standard.set(userCustomerList, forKey: "userCustomerList")
            }
        } else {
            if let index = userCustomerList.firstIndex(of: name) {
                userCustomerList.remove(at: index)
                UserDefaults.standard.set(userCustomerList, forKey: "userCustomerList")
            }
        }
    }
}

struct OrderItem: Identifiable, Decodable, Encodable {
    var id = UUID()
    var date: String
    var customer: String
    var name: String
    var size: String
    var quantity: Int
    var price: Int
    var taxRate: Int
    var tax: Int
    var totalPrice: Int
    var note: String
}

struct BentoItem {
    var name: String
    var abbreviation: String
    var basePrice: Int
}

struct Custom {
    var name: String
    var value: Int
}

