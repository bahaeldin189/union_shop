import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_provider.dart';
import '../services/auth_service.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchExpanded = false;

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToSale(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  void navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/search',
        arguments: {'query': query},
      );
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
      if (!_isSearchExpanded) {
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'FREE DELIVERY ON ORDERS OVER £50',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Main header
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () {
                      navigateToHome(context);
                    },
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Search Bar (expandable on mobile, always visible on desktop)
                  Expanded(
                    child: _isSearchExpanded ||
                            MediaQuery.of(context).size.width > 600
                        ? Container(
                            height: 28,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: Colors.grey[200]!, width: 0.5),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                suffixIcon: _isSearchExpanded &&
                                        MediaQuery.of(context).size.width <= 600
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        onPressed: _toggleSearch,
                                      )
                                    : null,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                              ),
                              style: const TextStyle(fontSize: 12),
                              onSubmitted: _performSearch,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  // Navigation icons (right-aligned)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Search toggle button (mobile only)
                      if (MediaQuery.of(context).size.width <= 600 &&
                          !_isSearchExpanded)
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: _toggleSearch,
                        ),
                      // Account/Login icon
                      Consumer<AuthService>(
                        builder: (context, authService, child) {
                          return IconButton(
                            icon: Icon(
                              authService.isAuthenticated
                                  ? Icons.person
                                  : Icons.person_outline,
                              size: 18,
                              color: authService.isAuthenticated
                                  ? const Color(0xFF4d2963)
                                  : Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: () {
                              if (authService.isAuthenticated) {
                                Navigator.pushNamed(context, '/account');
                              } else {
                                navigateToLogin(context);
                              }
                            },
                          );
                        },
                      ),
                      // Cart icon with badge
                      Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return Stack(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () => navigateToCart(context),
                              ),
                              if (cartProvider.itemCount > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4d2963),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '${cartProvider.itemCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      // Menu icon
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          size: 18,
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed: () => _showNavigationMenu(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNavigationMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Menu items
              _buildMenuItem(
                context,
                'Home',
                Icons.home_outlined,
                () => navigateToHome(context),
              ),
              _buildMenuItem(
                context,
                'Collections',
                Icons.category_outlined,
                () => navigateToCollections(context),
              ),
              _buildMenuItem(
                context,
                'Sale',
                Icons.local_offer_outlined,
                () => navigateToSale(context),
              ),
              _buildMenuItem(
                context,
                'About Us',
                Icons.info_outline,
                () => navigateToAbout(context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4d2963)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
