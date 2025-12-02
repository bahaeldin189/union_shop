import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void placeholderCallbackForButtons() {
    // Placeholder for footer links that don't have functionality yet
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Footer content for wider screens
          if (MediaQuery.of(context).size.width > 600) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Links column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Links',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4d2963),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildFooterLink('Home'),
                      _buildFooterLink('Collections'),
                      _buildFooterLink('Sale Items'),
                      _buildFooterLink('About Us'),
                    ],
                  ),
                ),
                // Customer Service column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Customer Service',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4d2963),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildFooterLink('Contact Us'),
                      _buildFooterLink('Delivery Information'),
                      _buildFooterLink('Returns Policy'),
                      _buildFooterLink('Size Guide'),
                    ],
                  ),
                ),
                // Contact Info column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4d2963),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'University House',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'Winston Churchill Avenue',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'Portsmouth PO1 2UP',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'shop@upsu.net',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        '023 9284 3962',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
          ] else ...[
            // Mobile footer layout
            const Text(
              'University of Portsmouth Students\' Union Shop',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'University House, Winston Churchill Avenue, Portsmouth PO1 2UP',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                const Text(
                  'shop@upsu.net',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                const Text(
                  '023 9284 3962',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.grey),
            const SizedBox(height: 12),
          ],

          // Footer bottom
          Row(
            children: [
              const Expanded(
                child: Text(
                  '© 2025 University of Portsmouth Students\' Union',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Social media icons (placeholder)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook_outlined),
                    onPressed: placeholderCallbackForButtons,
                    iconSize: 20,
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(Icons.alternate_email),
                    onPressed: placeholderCallbackForButtons,
                    iconSize: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return GestureDetector(
      onTap: placeholderCallbackForButtons,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
