import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:vending_machine_task/src/models/product.dart';

/// to store our coinDenominations
List<double> coinDenominations = [2, 1, 0.5, 0.2, 0.1];

/// to store the used coins for returning a change
List<double> usedCoins = [];

class VendingMachine {
  /// counts the total coins inserted into machine
  double totalCoins = 0.0;

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

  /// insert coins into the vending machine using this method
  void insertCoin(double coin) => totalCoins += coin;

  /// to edit a product's price
  void editProductPrice(int index, double newPrice) => products[index].price = newPrice;

  /// to edit a product's title
  void editProductTitle(int index, String newTitle) => products[index].title = newTitle;

  // TODO: Implement CRUD - Read operation
  void getProductData(Product product) {
    print(product.title);
    print(product.price);
  }

  /// this method is used to delete a product from the vending machine
  void deleteProduct(int index) => products.removeAt(index);

  // TODO: Implement
  /// method accepts the name of the product that has been clicked & price
  void calculateChange(String product, double price, double coinsInserted) {
    if (coinsInserted != 0.0) {
      if (coinsInserted == price) {
        /// there is no change...
      }

      /// coins are more than products price --> return change
      else if (coinsInserted > price) {
        /// calculate the change
        change = coinsInserted - price;
        // usedCoins
        for (double coin in coinDenominations) {
          if (change >= coin) {
            int count = (change / coin).floor();
            if (count > 0) {
              usedCoins.add(coin);
              change -= coin * count;
              // print(coin);
            }
          }
        }
        print(usedCoins);
      }

      /// not enough COINS inserted
      else {
        // TODO: Maybe include how much coins MORE the user needs to input
      }
    } else {
      print("NO COINS");
    }
  }

}
