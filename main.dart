import 'package:flutter/material.dart';

void main() {
  runApp(FlipkartCloneApp());
}

class FlipkartCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flipkart Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainPage(),
    CategoriesPage(),
    CartPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _titles = [
    "Home",
    "Categories",
    "Cart",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ----------------- MAIN PAGE -----------------
class MainPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  final List<_IconInfo> iconButtons = [
    _IconInfo("Fashion", Icons.checkroom, Colors.purple),
    _IconInfo("Food & Health", Icons.local_dining, Colors.red),
    _IconInfo("Beauty", Icons.brush, Colors.pink),
    _IconInfo("Electronics", Icons.electrical_services, Colors.blue),
    _IconInfo("Home", Icons.home, Colors.orange),
    _IconInfo("Appliances", Icons.kitchen, Colors.teal),
    _IconInfo("Clothing", Icons.shopping_bag, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Search bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search for products, brands and more",
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),
          ),
          SizedBox(height: 24),

          // Icon grid
          Expanded(
            child: GridView.builder(
              itemCount: iconButtons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final iconInfo = iconButtons[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(title: iconInfo.label),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: iconInfo.color.withOpacity(0.15),
                        child: Icon(iconInfo.icon,
                            color: iconInfo.color, size: 30),
                      ),
                      SizedBox(height: 8),
                      Text(
                        iconInfo.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IconInfo {
  final String label;
  final IconData icon;
  final Color color;
  _IconInfo(this.label, this.icon, this.color);
}

// ----------------- CATEGORIES PAGE -----------------
class CategoriesPage extends StatelessWidget {
  final List<_IconInfo> categories = [
    _IconInfo("Mobiles", Icons.phone_android, Colors.blue),
    _IconInfo("Fashion", Icons.checkroom, Colors.purple),
    _IconInfo("Electronics", Icons.electrical_services, Colors.blueAccent),
    _IconInfo("Home & Furniture", Icons.chair, Colors.brown),
    _IconInfo("Books", Icons.menu_book, Colors.orange),
    _IconInfo("Toys & Baby", Icons.toys, Colors.pink),
    _IconInfo("Groceries", Icons.local_grocery_store, Colors.green),
    _IconInfo("Beauty & Personal Care", Icons.brush, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: categories.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: category.color.withOpacity(0.2),
            child: Icon(category.icon, color: category.color),
          ),
          title: Text(category.label),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(title: category.label),
              ),
            );
          },
        );
      },
    );
  }
}

// ----------------- CART PAGE -----------------
class CartPage extends StatelessWidget {
  final List<String> cartItems = [
    "Men's T-Shirt - Rs 500",
    "Bluetooth Headphones - Rs 1200",
    "Organic Facewash - Rs 300",
  ];

  @override
  Widget build(BuildContext context) {
    return cartItems.isEmpty
        ? Center(child: Text("Your cart is empty"))
        : ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: cartItems.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(cartItems[index]),
                trailing: Icon(Icons.delete_outline),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Remove ${cartItems[index]}')),
                  );
                },
              );
            },
          );
  }
}

// ----------------- PROFILE PAGE -----------------
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://www.gravatar.com/avatar/placeholder.png'),
            ),
            SizedBox(height: 16),
            Text(
              "John Doe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("john.doe@example.com"),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout pressed')),
                );
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- DETAIL SCREEN -----------------
class DetailScreen extends StatelessWidget {
  final String title;
  const DetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Welcome to $title page!',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
