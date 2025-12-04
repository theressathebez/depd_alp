part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Key form untuk validasi
  final _formKey = GlobalKey<FormState>();

  // Role Selection
  String _selectedRole = 'Student'; // Options: Student, Department, Company

  // Controllers - Student
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController(); // Date Picker
  final _domicileController = TextEditingController();
  final _nimController = TextEditingController();
  final _majorController = TextEditingController();
  final _batchController = TextEditingController();
  final _studentEmailController = TextEditingController();
  final _studentPasswordController = TextEditingController();

  // Controllers - Department
  final _deptNameController = TextEditingController();
  final _deptEmailController = TextEditingController();
  final _deptPasswordController = TextEditingController();

  // Controllers - Company
  final _companyNameController = TextEditingController();
  final _companyEmailController = TextEditingController();
  final _picNameController = TextEditingController();
  final _picPositionController = TextEditingController();
  final _picPhoneController = TextEditingController();
  final _companyPasswordController = TextEditingController();

  // Common State
  bool _isObscured = true;
  bool _agreedToTerms = false;

  // Colors Palette
  final Color _primaryColor = const Color(0xFFFF512F);
  final Color _secondaryColor = const Color(0xFFDD2476);

  @override
  void dispose() {
    // Dispose all controllers
    _fullNameController.dispose();
    _dobController.dispose();
    _domicileController.dispose();
    _nimController.dispose();
    _majorController.dispose();
    _batchController.dispose();
    _studentEmailController.dispose();
    _studentPasswordController.dispose();
    _deptNameController.dispose();
    _deptEmailController.dispose();
    _deptPasswordController.dispose();
    _companyNameController.dispose();
    _companyEmailController.dispose();
    _picNameController.dispose();
    _picPositionController.dispose();
    _picPhoneController.dispose();
    _companyPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Tampilan Web / Desktop (Split Screen)
            return Row(
              children: [
                // Panel Kiri (Dekorasi)
                Expanded(flex: 1, child: _buildLeftPanel()),
                // Panel Kanan (Form Register)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: _buildRegisterForm(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Tampilan Mobile
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildRegisterForm(),
              ),
            );
          }
        },
      ),
    );
  }

  // --- WIDGETS BUILDER ---

  Widget _buildLeftPanel() {
    return Container(
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
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 40,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.school, color: Colors.white, size: 40),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            "Join the\nCommunity",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Create an account to start your journey. Connect, grow, and achieve your career goals with Universitas Ciputra.",
            style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
          ),
          const Spacer(),
          Center(
            child: Icon(
              Icons.app_registration_rounded,
              size: 200,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Register",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // Role Selection Tabs
          _buildRoleSelector(),
          const SizedBox(height: 30),

          // Dynamic Form Fields based on Role
          if (_selectedRole == 'Student') _buildStudentFields(),
          if (_selectedRole == 'Department') _buildDepartmentFields(),
          if (_selectedRole == 'Company') _buildCompanyFields(),

          const SizedBox(height: 20),

          // Terms and Conditions
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: _agreedToTerms,
                  activeColor: _primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _agreedToTerms = val ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: "I agree to the ",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                    children: [
                      TextSpan(
                        text: "Terms & Conditions",
                        style: TextStyle(
                          color: _primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: _primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Register Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!_agreedToTerms) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please agree to terms and conditions'),
                      ),
                    );
                    return;
                  }
                  // TODO: Perform Registration Logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registering as $_selectedRole...')),
                  );
                }
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
                "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Login Link
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Login here",
                    style: TextStyle(
                      color: _secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: ['Student', 'Department', 'Company'].map((role) {
          final isSelected = _selectedRole == role;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRole = role;
                  _formKey.currentState
                      ?.reset(); // Reset validation errors on switch
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    role,
                    style: TextStyle(
                      color: isSelected ? _primaryColor : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- FIELD GROUPS ---

  Widget _buildStudentFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Personal Info"),
        _buildTextField(
          "Nama Lengkap",
          _fullNameController,
          icon: Icons.person,
        ),
        _buildDatePickerField("Tanggal Lahir", _dobController),
        _buildTextField(
          "Domisili",
          _domicileController,
          icon: Icons.location_on,
        ),

        const SizedBox(height: 20),
        _buildSectionHeader("Academic Info"),
        Row(
          children: [
            Expanded(
              child: _buildTextField("NIM", _nimController, icon: Icons.badge),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                "Angkatan",
                _batchController,
                icon: Icons.calendar_today,
                isNumber: true,
              ),
            ),
          ],
        ),
        _buildTextField("Major", _majorController, icon: Icons.school),

        const SizedBox(height: 20),
        _buildSectionHeader("Account"),
        _buildTextField(
          "Email UC",
          _studentEmailController,
          hint: "example@student.ciputra.ac.id",
          icon: Icons.email,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Email required';
            if (!value.endsWith('@student.ciputra.ac.id')) {
              return 'Must use @student.ciputra.ac.id';
            }
            return null;
          },
        ),
        _buildPasswordField(_studentPasswordController),
      ],
    );
  }

  Widget _buildDepartmentFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Department Info"),
        _buildTextField(
          "Nama Departemen",
          _deptNameController,
          icon: Icons.business,
        ),
        _buildTextField(
          "Email Departemen",
          _deptEmailController,
          hint: "dept@ciputra.ac.id",
          icon: Icons.email,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Email required';
            if (!value.endsWith('@ciputra.ac.id')) {
              return 'Must use @ciputra.ac.id';
            }
            return null;
          },
        ),
        _buildPasswordField(_deptPasswordController),
      ],
    );
  }

  Widget _buildCompanyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Company Info"),
        _buildTextField(
          "Nama Perusahaan",
          _companyNameController,
          icon: Icons.apartment,
        ),
        _buildTextField(
          "Email Perusahaan",
          _companyEmailController,
          hint: "hr@company.com",
          icon: Icons.email,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Email required';
            // Simple regex for standard email
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),

        const SizedBox(height: 20),
        _buildSectionHeader("PIC Info"),
        _buildTextField(
          "Nama PIC",
          _picNameController,
          icon: Icons.person_outline,
        ),
        _buildTextField(
          "Jabatan PIC",
          _picPositionController,
          icon: Icons.work_outline,
        ),
        _buildTextField(
          "Nomor Telepon PIC",
          _picPhoneController,
          icon: Icons.phone,
          isNumber: true,
        ),

        const SizedBox(height: 20),
        _buildSectionHeader("Account"),
        _buildPasswordField(_companyPasswordController),
      ],
    );
  }

  // --- COMPONENT HELPERS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _secondaryColor,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    IconData? icon,
    bool isNumber = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            validator:
                validator ??
                (val) {
                  if (val == null || val.isEmpty)
                    return '$label cannot be empty';
                  return null;
                },
            decoration: _inputDecoration(
              hint: hint ?? "Enter $label",
              icon: icon,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: _isObscured,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Password required';
              if (val.length < 6) return 'Min 6 characters';
              return null;
            },
            decoration: _inputDecoration(
              hint: "Create password",
              icon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _isObscured = !_isObscured),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            readOnly: true,
            validator: (val) =>
                val == null || val.isEmpty ? 'Date required' : null,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                // Format simple: DD/MM/YYYY
                controller.text =
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              }
            },
            decoration: _inputDecoration(
              hint: "DD/MM/YYYY",
              icon: Icons.calendar_month,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    IconData? icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      prefixIcon: icon != null
          ? Icon(icon, color: Colors.grey, size: 20)
          : null,
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
