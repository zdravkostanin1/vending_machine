import 'package:flutter/material.dart';
import 'package:vending_machine_task/src/models/vending_machine.dart';

import '../models/product.dart';

/// make a vending machine obj
VendingMachine vMachine = VendingMachine();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const Page(title: 'Vending Machine'),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.title});

  final String title;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  String selectedProductName = "";
  double selectedProductPrice = 0.0;

  /// used to store the edited product's title and price
  String newProductTitle = "";
  double newProductPrice = 0.0;

  /// to display that no money were inserted
  var snackBar = const SnackBar(
    content: Text(
      'No money inserted',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();

    /// get the products
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// wait for our vending machine to retrieve the products
      await vMachine.getProducts();
      setState(() {});
    });
  }

  /// Widget to display a dialog for adding a new product to the vending machine
  Future<void> _addNewProductDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'ADD A NEW PRODUCT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(),
                    // helperText: 'New product name',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black,
                    ),
                  ),
                  onChanged: (String title) {
                    /// save the new product title
                    newProductTitle = title;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'SELECT A PRICE: ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '0.10',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 0.10;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '0.20',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 0.20;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '0.50',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 0.50;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '1',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 1;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '2',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 2;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            /// cancel editing a product
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                /// re-set variables and close window
                newProductTitle = '';
                newProductPrice = 0.0;
                Navigator.of(context).pop();
              },
            ),

            /// save changes made to product
            TextButton(
              child: const Text('ADD'),
              onPressed: () {
                /// if the new product has a title and price
                if (newProductTitle.isNotEmpty && newProductPrice != 0.0 ) {
                  vMachine.addNewProduct(Product(title: newProductTitle, price: newProductPrice));
                } else {
                  /// an empty product cannot be added to vending machine
                }
                setState(() {});

                /// close window
                Navigator.of(context).pop();
                /// re-set variables
                newProductTitle = '';
                newProductPrice = 0.0;
              },
            ),
          ],
        );
      },
    );
  }

  /// Widget to display a dialog for editing a product in vending machine
  Future<void> _editProductDialog(Product product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'EDIT THIS PRODUCT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      labelText: 'Input new product name',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                      border: const OutlineInputBorder(),
                      hintText: selectedProductName,
                      // helperText: 'New product name',
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black)),
                  onChanged: (String newProductName) {
                    /// save the newly inputted product name
                    newProductTitle = newProductName;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'NEW PRICE: ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '0.10',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 0.10;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '0.20',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 0.20;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '0.50',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 0.50;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '1',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 1;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          '2',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          newProductPrice += 2;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            /// cancel editing a product
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                /// re-set variables and close window
                newProductTitle = '';
                newProductPrice = 0.0;
                Navigator.of(context).pop();
              },
            ),

            /// save changes made to product
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                /// if the new name is not empty --> update to the new product name
                if (newProductTitle.isNotEmpty) {
                  vMachine.editProductTitle(product, newProductTitle);
                }

                /// if the new price is not empty --> update to the new product price
                if (newProductPrice != 0.0) {
                  vMachine.editProductPrice(product, newProductPrice);
                }
                setState(() {});

                /// close window
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      /// if our products list is NOT empty --> only then we display the products with our Listview.builder
      body: vMachine.products.isNotEmpty
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: vMachine.products.length,
                      prototypeItem: ListTile(
                        title: Text(vMachine.products.first.title),
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            trailing: IconButton(
                              /// remove product from the vending machine (delete it from list)
                              onPressed: () {
                                vMachine.deleteProduct(index);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xff3D0C11),
                                size: 30.0,
                              ),
                            ),
                            title: Text(
                              vMachine.products[index].title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                              ),
                            ),
                            subtitle: Text(
                              '${vMachine.products[index].price.toStringAsFixed(2)} BGN',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            leading: Text(
                              '${vMachine.products[index].inventory}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            onTap: () {
                              /// assign the selected item's name and price to local variables
                              selectedProductName =
                                  vMachine.products[index].title;
                              selectedProductPrice =
                                  vMachine.products[index].price;

                              /// calculate the change
                              if (vMachine.totalCoins != 0.0) {
                                /// re-set the change
                                vMachine.changeCoins = {};
                                vMachine.change = 0.0;

                                /// calculate the new change
                                vMachine.calculateChange(
                                  vMachine.products[index],
                                  selectedProductPrice,
                                  vMachine.totalCoins,
                                );
                              }

                              /// if no money were inserted --> display a toast message that says no money inserted
                              else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              vMachine.totalCoins = 0.0;
                              setState(() {});
                            },

                            /// update the product you select by long-pressing it
                            onLongPress: () {
                              /// assign the selected item's name and price to local variables
                              selectedProductName =
                                  vMachine.products[index].title;
                              selectedProductPrice =
                                  vMachine.products[index].price;

                              /// show the dialog for editing product
                              _editProductDialog(vMachine.products[index]);
                              /// re-set variables for the newly added title and price
                              newProductPrice = 0.0;
                              newProductTitle = "";
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(
                      thickness: 3.0,
                      color: Colors.black,
                    ),
                    const Text(
                      'FIRSTLY, INSERT COINS IN BULGARIAN LEV',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            child: const Text(
                              '0.10 lv',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              /// sums up to the coins
                              vMachine.insertCoin(double.parse('0.10'));

                              /// re-set the change
                              vMachine.changeCoins = {};
                              vMachine.change = 0.0;
                              setState(() {});
                              // print(0.10.toStringAsFixed(2));
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            child: const Text(
                              '0.20 lv',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              /// sums up to the coins
                              vMachine.insertCoin(double.parse('0.20'));

                              /// re-set the change
                              vMachine.changeCoins = {};
                              vMachine.change = 0.0;
                              setState(() {});
                              // print(0.20.toStringAsFixed(2));
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            child: const Text(
                              '0.50 lv',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              /// sums up to the coins
                              vMachine.insertCoin(double.parse('0.50'));

                              /// re-set the change
                              vMachine.changeCoins = {};
                              vMachine.change = 0.0;
                              setState(() {});
                              // print(0.50.toStringAsFixed(2));
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            child: const Text(
                              '1 lv',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              /// sums up to the coins
                              vMachine.insertCoin(double.parse('1.0'));

                              /// re-set the change
                              vMachine.changeCoins = {};
                              vMachine.change = 0.0;
                              setState(() {});
                              // print(1.toStringAsFixed(2));
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            child: const Text(
                              '2 lv',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              /// sums up to the coins
                              vMachine.insertCoin(double.parse('2.0'));

                              /// re-set the change
                              vMachine.changeCoins = {};
                              vMachine.change = 0.0;
                              setState(() {});
                              // print(2.toStringAsFixed(2));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    /// display the coins that are inserted currently
                    RichText(
                      text: TextSpan(
                        text: "COINS INSERTED: ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: vMachine.totalCoins != 0.0
                                ? vMachine.totalCoins.toStringAsFixed(2)
                                : "",
                            style: const TextStyle(color: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "CHANGE: ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: vMachine.change != 0.0

                                /// displaying the total change --> and the coins that make up the total change
                                ? '${vMachine.change.toStringAsFixed(2)} - ${vMachine.changeCoins}'
                                : "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                        /// resets the process of the vending machine
                        onPressed: () {
                          /// you can only cancel --> if there's no returned change already.
                          if (vMachine.change == 0.0) {
                            /// re-set coins, name and price of product last chosen
                            selectedProductName = "";
                            selectedProductPrice = 0.0;

                            /// re-set total coins, change and map of change coins
                            vMachine.totalCoins = 0.0;
                            vMachine.change = 0.0;
                            vMachine.changeCoins = {};
                            setState(() {});
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'CANCEL & RETURN COINS',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewProductDialog();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
