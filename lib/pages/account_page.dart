import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _nameController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile(AuthService authService) async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    final success =
        await authService.updateProfile(displayName: _nameController.text);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Profile updated successfully'
              : authService.errorMessage ?? 'Failed to update profile'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _changePassword(AuthService authService) async {
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all password fields')),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    final success = await authService.changePassword(
      _currentPasswordController.text,
      _newPasswordController.text,
    );

    if (mounted) {
      if (success) {
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Password changed successfully'
              : authService.errorMessage ?? 'Failed to change password'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _signOut(AuthService authService) async {
    await authService.signOut();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    if (user == null) {
      // Redirect to login if not authenticated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    _nameController.text = user.displayName ?? '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/'),
                        child: const Text(
                          'Home',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      const Text(' > ', style: TextStyle(color: Colors.grey)),
                      const Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4d2963),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Account header
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFF4d2963),
                            backgroundImage: user.photoURL != null
                                ? NetworkImage(user.photoURL!)
                                : null,
                            child: user.photoURL == null
                                ? Text(
                                    user.displayName
                                            ?.substring(0, 1)
                                            .toUpperCase() ??
                                        user.email
                                            ?.substring(0, 1)
                                            .toUpperCase() ??
                                        'U',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            user.displayName ?? 'User',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4d2963),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.email ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Profile section
                          _buildSection(
                            'Profile Information',
                            [
                              TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Display Name',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: authService.isLoading
                                      ? null
                                      : () => _updateProfile(authService),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4d2963),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: authService.isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text('Update Profile'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Password section (only for email/password users)
                          if (user.providerData
                              .any((p) => p.providerId == 'password'))
                            _buildSection(
                              'Change Password',
                              [
                                TextField(
                                  controller: _currentPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Current Password',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _newPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'New Password',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Confirm New Password',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: authService.isLoading
                                        ? null
                                        : () => _changePassword(authService),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4d2963),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: authService.isLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text('Change Password'),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 32),

                          // Account actions
                          _buildSection(
                            'Account Actions',
                            [
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () => _signOut(authService),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF4d2963),
                                    side: const BorderSide(
                                        color: Color(0xFF4d2963)),
                                  ),
                                  child: const Text('Sign Out'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
