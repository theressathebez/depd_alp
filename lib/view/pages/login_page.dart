part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk input text
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State untuk checkbox dan visibility password
  bool _isObscured = true;
  bool _rememberMe = false;

  final Color _primaryColor = const Color(0xFFFF512F);
  // Warna sekunder untuk gradasi (Pink)
  final Color _secondaryColor = const Color(0xFFDD2476);

  // ignore: unused_field
  final Color _backgroundColor = const Color(0xFFF5F5F9);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                // Bagian Kiri (Dekorasi Web Version)
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_primaryColor, _secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Headline
                        const Text(
                          "Build Your\nDream Career",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Subtext (Updated Description)
                        const Text(
                          "The centralized platform for Universitas Ciputra students to find internships & jobs, connect with top companies, and develop your dream career.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                        // Illustration Placeholder (Icon Roket Karir)
                        Center(
                          child: Icon(
                            Icons.rocket_launch_rounded,
                            size: 200,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bagian Kanan (Form Login)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: _buildLoginForm(),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Jika layar kecil (Mobile)
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildLoginForm(),
              ),
            );
          }
        },
      ),
    );
  }

  // Widget Form Login yang bisa dipakai ulang
  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo / Brand
        Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Row(
                    children: [
                      const Icon(Icons.broken_image, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        "Logo Asset Missing",
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    ],
                  );
                },
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),

        // Input Email
        _buildLabel("Email"),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          decoration: _inputDecoration(hint: "Enter your email"),
        ),
        const SizedBox(height: 20),

        // Input Password
        _buildLabel("Password"),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: _isObscured,
          decoration: _inputDecoration(
            hint: "Enter your password",
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Remember Me & Forgot Password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    activeColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _rememberMe = val ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Remember me", style: TextStyle(color: Colors.grey)),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot password?",
                style: TextStyle(color: _primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),

        // Login Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: _primaryColor.withOpacity(0.4),
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Footer Text
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                },
                child: Text(
                  "Register now",
                  style: TextStyle(
                    color:
                        _secondaryColor, // Menggunakan warna Pink agar kontras
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper untuk membuat Label di atas input field
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }

  // Helper untuk style input decoration
  InputDecoration _inputDecoration({required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF8F9FA), // Warna background input abu-abu muda
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _primaryColor, width: 1.5),
      ),
      suffixIcon: suffixIcon,
    );
  }

  // Helper untuk tombol sosial media
  Widget _socialButton(IconData icon, Color color, {double iconSize = 24}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: iconSize),
      ),
    );
  }
}
