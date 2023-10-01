import 'package:flutter/material.dart';
import 'package:vending_machine_task/src/models/vending_machine.dart';

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
  TextEditingController coinsController = TextEditingController();
  String selectedProductName = "";
  double selectedProductPrice = 0.0;

  /// used to store the edited product's title and price
  String newProductTitle = "";
  double newProductPrice = 0.0;

  // int selectedProductInventory = 0;
  double coins = 0.0;
  var snackBar = const SnackBar(
    content: Text(
      'No coins inserted',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// get the products
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// wait for our vending machine to retrieve the products
      await vMachine.getProducts();
      setState(() {});
    });
  }

  /// Widget to display a dialog for editing a product in vending machine
  Future<void> _editProductDialog() async {
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
                  // TODO: Implement
                  onChanged: (String newProductName) {},
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
                          // TODO: Maybe compose a new method for newProductPrice inside VendingMachine class input?
                          newProductPrice += 0.10;
                          // print(0.10.toStringAsFixed(2));
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
                          // print(0.20.toStringAsFixed(2));
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
                          // vMachine.insertCoin(double.parse('0.50'));
                          // print(0.50.toStringAsFixed(2));
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
                          // print(1.toStringAsFixed(2));
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
                        // print(2.toStringAsFixed(2));
                      },
                    )),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                // TODO: Implement
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                // TODO: Implement

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
                            // TODO: Display each product's LEFTOVER inventory on the leading:
                            // TODO: When user makes a purchase --> one ITEM goes OFF the INVENTORY
                            // leading: ,
                            onTap: () {
                              /// assign the selected item's name and price to local variables
                              selectedProductName =
                                  vMachine.products[index].title;
                              selectedProductPrice =
                                  vMachine.products[index].price;

                              /// calculate the change
                              vMachine.calculateChange(
                                selectedProductName,
                                selectedProductPrice,
                                vMachine.totalCoins,
                              );
                              // vMachine.returnCoin(totalCoins, selectedProductPrice);
                              // selectedProductInventory = vMachine.products[index].inventory;
                            },
                            // TODO: implement --> updating of a product
                            onLongPress: () {
                              /// assign the selected item's name and price to local variables
                              selectedProductName =
                                  vMachine.products[index].title;
                              selectedProductPrice =
                                  vMachine.products[index].price;

                              /// show the dialog for editing product
                              _editProductDialog();
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
                              vMachine.insertCoin(double.parse('0.10'));
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
                              vMachine.insertCoin(double.parse('0.20'));
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
                              vMachine.insertCoin(double.parse('0.50'));
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
                              vMachine.insertCoin(double.parse('1.0'));
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
                              vMachine.insertCoin(double.parse('2.0'));
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
                                ? vMachine.change.toStringAsFixed(2)
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
                          /// clear the inputted coins
                          coinsController.clear();

                          /// re-set coins, name and price of product last chosen
                          coins = 0.0;
                          selectedProductName = "";
                          selectedProductPrice = 0.0;
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
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
