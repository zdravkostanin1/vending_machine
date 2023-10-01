/// This is a class used to represent a product in our vending machine.
/// A product has a title (name) and a price tag.
class Product {
  /// title and price of product
  String title;
  double price;
  /// each product has an inventory by default - 15
  int inventory = 15;

  Product({required this.title, required this.price});
}