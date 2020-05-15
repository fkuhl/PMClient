//
//  Transactions.swift
//  PMClient
//
//  Created by Frederick Kuhl on 5/15/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct Transactions: View {
    var member: Member
    
    var body: some View {
        List {
            ForEach(member.transactions, id: \.self) { transaction in
                TransactionRowView(item: transaction)
            }
        }
    }
}

struct TransactionRowView: View {
    var item: PMDataTypes.Transaction
    
    var body: some View {
        NavigationLink(destination: TransactionView(transaction: item)) {
            Text("\(dateForDisplay(item.date))  \(item.type.rawValue)")
                .font(.body)
        }
    }
}

struct TransactionView: View {
    var transaction: PMDataTypes.Transaction
    var body: some View {
        List {
            MemberTextAttributeView(caption: "date", text: dateForDisplay(transaction.date))
            MemberTextAttributeView(caption: "type", text: transaction.type.rawValue)
            if transaction.authority != nil {
                MemberTextAttributeView(caption: "authority", text: transaction.authority)
            }
            if transaction.church != nil {
                MemberTextAttributeView(caption: "authority", text: transaction.church)
            }
            if transaction.comment != nil {
                MemberTextAttributeView(caption: "authority", text: transaction.comment)
            }
        }
    }
}

//struct Transactions_Previews: PreviewProvider {
//    static var previews: some View {
//        Transactions()
//    }
//}
