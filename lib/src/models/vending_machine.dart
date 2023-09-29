import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:vending_machine_task/src/models/product.dart';

// TODO: for testing
double totalCoins = 0.0;

// TODO: for testing
List<double> changeOptions = [0.10, 0.20, 0.50, 1, 2];

// TODO: for testing
List<double> minimumCoins = [0.5, 0.10, 0.20];

// TODO: for testing
List<double> returnedCoins = [];

class VendingMachine {
  /// used to store our products
  final List<Product> products = [];

  /// used to store the inventory of a SINGLE product
  final int productInventory = 15;

  /// used to store our change
  double change = 0.0;

  /// used to get products from firebase database
  getProducts() async {
    /// create a new database ref for firebase
    DatabaseReference ref = FirebaseDatabase.instance.ref("Products");

    /// read data using once
    final event = await ref.once(DatabaseEventType.value);

    /// loop through existing products in db
    for (var product in event.snapshot.children) {
      /// add the retrieved products to our list
      products.add(
        Product(
          title: product.child('title').value.toString(),
          price: double.parse(product.child('price').value.toString()),
        ),
      );
    }
  }

  // TODO: Implement
  /// method accepts the name of the product that has been clicked & price
  void calculateChange(String product, double price, double coinsInserted) {
    if (coinsInserted != 0.0) {
      if (coinsInserted == price) {
        /// there is no change...
      }

      /// coins are more than products price --> return change
      else if (coinsInserted >= price) {
        change = coinsInserted - price;
        double i = (change / 2);
        // print(i.toStringAsFixed(2));
        // double howMuchMultipliedIForChange;
        /// returns 0.10 until equal to change
        for (double s = 0.0; s <= change; s += i) {
          if (s != 0.0) {
            print(s.toStringAsFixed(2));
          }
        }
        // print((change / 3).toStringAsFixed(2));
      }

      /// not enough COINS inserted
      else {
        // TODO: Maybe include how much coins MORE the user needs to input
      }
    } else {
      print("NO COINS");
    }
  }

  // TODO: Test
  void insertCoin(double coin) {
    totalCoins += coin;
    print(totalCoins.toStringAsFixed(2));
  }

  // static int minCoins(List<int> coins, int m, int V) {
  //   // Base case
  //   if (V == 0) return 0;
  //
  //   // Initialize result
  //   int res = 2147483647; // Equivalent to int.MaxValue in C#
  //
  //   // Try every coin that has
  //   // smaller value than V
  //   for (int i = 0; i < m; i++) {
  //     if (coins[i] <= V) {
  //       int subRes = minCoins(coins, m, V - coins[i]);
  //
  //       // Check for 2147483647 (INT_MAX in C#) to
  //       // avoid overflow and see if the result can be minimized
  //       if (subRes != 2147483647 && subRes + 1 < res) {
  //         res = subRes + 1;
  //       }
  //     }
  //   }
  //   return res;
  // }

  void returnCoin(double coinsInputted, double priceOfProduct) {
    double c = (coinsInputted - priceOfProduct);
    double coinsUsed = 0;
    double totalChange = 0.0;

    while (totalChange <= c) {
      for (double i in changeOptions) {
        if (totalChange + i > c) {
          // break;
          // print(totalChange);
        } else {
          coinsUsed++;
          totalChange += i;
          returnedCoins.add(i);
        }
        if (totalChange == c) {
          break;
        }
        // break;
      }
      if (totalChange == c) {
        break;
      }
    }
    print(totalChange);
    print("COINS USED $coinsUsed");
  }
}
