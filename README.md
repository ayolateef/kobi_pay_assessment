# KobiPay Frontend Engineer Assessment

A two-screen Flutter app built for KobiPay's Round 2 technical assessment.

## Features

- **Transaction Summary Screen**  
  Displays Netflix logo, total payments, a month filter (Jan–Dec), pie chart, and transaction list.
- **Transaction Detail Screen**  
  Shows transaction details with a refund option.

## Setup

```bash
git clone  https://github.com/ayolateef/kobi_pay_assessment.git
cd kobipay_assessment
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```


## Tech Stack

- **State Management**: Riverpod
- **Charts**: fl_chart
- **Date Formatting**: intl
- **Animations**: fade-in for transactions
- **Data**: Local `transactions.json` simulates API

## Highlights

- Clean modular architecture (`lib/screens`, `widgets`, `models`, `providers`, etc.)
- Dynamic filtering and pie chart updates by month
- Refund simulation (client-side only)
- Responsive layout and custom dropdown UI

## Time Spent

Approx. 8 hours (UI design, filtering logic, date formatting, animations, and documentation).