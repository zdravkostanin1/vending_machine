import 'package:decimal/decimal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vending_machine_task/src/models/product.dart';

class VendingMachine {
  /// counts the total coins inserted into machine
  double totalCoins = 0.0;

  /// used to store our products
  final List<Product> products = [];

  /// used to store the inventory of a SINGLE product
  final int productInventory = 15;

  /// used to store our change (SUM)
  double change = 0.0;

  /// used for iterations in loops & to store preciseChange
  double preciseChange = 0.0;

  /// to store our coinDenominations
  List<double> coinDenominations = [2, 1, 0.5, 0.2, 0.1];

  /// to store the coins Change
  Map<double, int> changeCoins = {};

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
  void editProductPrice(Product product, double newPrice) => product.price = newPrice;

  /// to edit a product's title
  void editProductTitle(Product product, String newTitle) => product.title = newTitle;

  /// returns product at index of choice
  Product getProductData(int index) => products[index];

  /// this method is used to delete a product from the vending machine
  void deleteProduct(int index) => products.removeAt(index);

  /// method accepts the name of the product that has been clicked & price
  void calculateChange(double price, double moneyInserted) {
    if (moneyInserted != 0.0) {
      if (moneyInserted == price) {
        /// there is no change...
      }

      /// coins are more than products price --> return change
      else if (moneyInserted > price) {
        /// calculate the change
        change = moneyInserted - price;
        /// calculate the precise change
        preciseChange = moneyInserted - price;
        for (var coin in coinDenominations) {
          if (preciseChange >= coin) {
            /// a variable which counts each coin's COUNT (e.g. how much times this coin has been used)
            int count = (preciseChange / coin).floor();
            /// add that coin to a map
            changeCoins[coin] = count;
            /// get the precise Decimal of subtracting the doubles
            var preciseDecimalResult = (Decimal.parse(preciseChange.toString()) - Decimal.parse((coin * count).toString()));
            preciseChange = double.parse(preciseDecimalResult.toString());
          }
        }
      }

      /// not enough COINS inserted
      else {
        // TODO: Maybe display SnackBar --> not enough coins
      }
    }
  }
}
