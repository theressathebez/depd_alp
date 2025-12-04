part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _jobsKey = GlobalKey();
  final GlobalKey _candidatesKey = GlobalKey();
  final GlobalKey _testimonyKey = GlobalKey();

  int _selectedIndex = 0; // 0: Home, 1: Jobs, 2: Candidates, 3: Testimony
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Tambahkan listener untuk mendeteksi scroll
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // List keys sesuai urutan tampilan (Home -> Jobs -> Candidates -> Testimony)
    final keys = [_homeKey, _jobsKey, _candidatesKey, _testimonyKey];

    for (int i = keys.length - 1; i >= 0; i--) {
      final key = keys[i];
      final context = key.currentContext;
      if (context != null) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        // Dapatkan posisi Y widget relatif terhadap layar
        final offset = box.localToGlobal(Offset.zero);

        if (offset.dy < 150) {
          if (_selectedIndex != i) {
            setState(() {
              _selectedIndex = i;
            });
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(GlobalKey key, int index) {
    setState(() {
      _selectedIndex = index;
    });

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 70,
        title: Row(
          children: [
            // LOGO
            Expanded(
              flex: 2,
              child: Row(
                children: [Image.asset('assets/images/logo.png', height: 40)],
              ),
            ),

            // MENU NAVBAR
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navItem("Home", 0, _homeKey),
                  _navItem("Find Jobs", 1, _jobsKey),
                  _navItem("Our Candidates", 2, _candidatesKey),
                  _navItem("Testimony", 3, _testimonyKey),
                ],
              ),
            ),

            // SIGN UP BUTTON
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF8A34), // orange
                          Color(0xFFFF6FAF), // pink
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        "Sign Up Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // ───────────────────────────────
            // 1. HERO SECTION (Index 0)
            // ───────────────────────────────
            Container(
              key: _homeKey,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: -50,
                    child: Image.asset(
                      "assets/images/orang.png",
                      height: 800,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 120,
                    child: SizedBox(
                      width: 650,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "UC HUB —",
                            style: TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                const LinearGradient(
                                  colors: [
                                    Color(0xFFFF8A34),
                                    Color(0xFFFF6FAF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(
                                  Rect.fromLTWH(
                                    0,
                                    0,
                                    bounds.width,
                                    bounds.height,
                                  ),
                                ),
                            child: const Text(
                              "Find Your Best",
                              style: TextStyle(
                                fontSize: 65,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Opportunity Now.",
                            style: TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "The centralized platform for Universitas Ciputra students to find internships & jobs, connect with top companies, and develop your dream career.",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ───────────────────────────────
            // 2. WHO CAN USE
            // ───────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Column(
                children: [
                  const Text(
                    "Who Can Use UC HUB?",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "A platform designed for everyone in the Universitas Ciputra ecosystem",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(
                        title: "Student",
                        subtitle: "Job Seeker",
                        description:
                            "Find the best internships &\njob opportunities",
                        icon: Icons.person_outline,
                        bgColor: const Color(0xFFFFF8E7),
                        gradientColors: [
                          const Color(0xFFFF8A34),
                          const Color(0xFFFF6FAF),
                        ],
                      ),
                      const SizedBox(width: 30),
                      _buildInfoCard(
                        title: "Company",
                        subtitle: "Employer",
                        description: "Recruit top talents from\nUC students",
                        icon: Icons.apartment,
                        bgColor: const Color(0xFFF3EFFF),
                        gradientColors: [
                          const Color(0xFFA594F9),
                          const Color(0xFF6F86FF),
                        ],
                      ),
                      const SizedBox(width: 30),
                      _buildInfoCard(
                        title: "UC Department",
                        subtitle: "Internal Unit",
                        description: "Manage internal\ninternship programs",
                        icon: Icons.business_center_outlined,
                        bgColor: const Color(0xFFE3F2FD),
                        gradientColors: [
                          const Color(0xFF4FC3F7),
                          const Color(0xFF00B0FF),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ───────────────────────────────
            // 3. COMPANIES HIRING (Index 1 - Find Jobs)
            // ───────────────────────────────
            Container(
              key: _jobsKey,
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0E3),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFFFCCBC)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.business,
                          color: Color(0xFFFF8A34),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Trusted by Top Companies",
                          style: TextStyle(
                            color: Color(0xFFFF8A34),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Companies Hiring Now",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Leading companies are looking for talents like you.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 60),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        _buildCompanyCard(
                          companyName: "Gojek Indonesia",
                          industry: "Technology & Transportation",
                          description:
                              "Indonesia's leading multi-service platform",
                          logoColor: Colors.pink,
                          logoIcon: Icons.motorcycle,
                          activeJobs: 12,
                          pillColor: const Color(0xFF00AA5B),
                        ),
                        const SizedBox(width: 30),
                        _buildCompanyCard(
                          companyName: "Tokopedia",
                          industry: "E-commerce & Technology",
                          description: "Empowering millions of merchants",
                          logoColor: Colors.green,
                          logoIcon: Icons.shopping_bag,
                          activeJobs: 8,
                          pillColor: const Color(0xFF42B549),
                        ),
                        const SizedBox(width: 30),
                        _buildCompanyCard(
                          companyName: "Bank Central Asia",
                          industry: "Banking & Finance",
                          description: "Leading financial institution in Asia",
                          logoColor: Colors.blue[900]!,
                          logoIcon: Icons.account_balance,
                          activeJobs: 15,
                          pillColor: const Color(0xFF2979FF),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                      side: const BorderSide(color: Color(0xFFFF8A34)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "View All Companies",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFFFF8A34),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ───────────────────────────────
            // 3.5. UC IN NUMBERS (NEW SECTION)
            // ───────────────────────────────
            Container(
              key: _candidatesKey,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 40,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  const Text(
                    "Our Candidates",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem("Unggul", "Akreditasi"),
                      _buildStatItem("6500+", "Mahasiswa Aktif"),
                      _buildStatItem("8", "Fakultas"),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // Divider Line
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Divider(color: Colors.black12, thickness: 2),
                  ),

                  const SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem("2006", "Didirikan"),
                      _buildStatItem("10400+", "Alumni"),
                      _buildStatItem("26", "Program"),
                    ],
                  ),
                ],
              ),
            ),

            // ───────────────────────────────
            // 4. TESTIMONIALS (Index 3 - Testimony)
            // ───────────────────────────────
            Container(
              key: _testimonyKey,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFBFF), // Whiteish Pink top
                    Color(0xFFFFF0EC), // Very light orange bottom
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "What Students Say",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Heard what they say about this platform",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 60),

                  Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildTestimonialCard(
                        name: "Sarah Wijaya",
                        major: "Business Student '22",
                        quote:
                            "\"UC HUB helped me land my dream internship at a multinational company!\"",
                        avatarColor: Colors.orange.shade200,
                        initials: "SW",
                      ),
                      _buildTestimonialCard(
                        name: "Michael Tan",
                        major: "Tech Student '21",
                        quote:
                            "\"The profile builder feature made my CV stand out. Got 3 interview calls in a week!\"",
                        avatarColor: Colors.blue.shade200,
                        initials: "MT",
                      ),
                      _buildTestimonialCard(
                        name: "Priscilla Chen",
                        major: "Design Student '23",
                        quote:
                            "\"Simple, professional, and effective platform. Highly recommended for UC students!\"",
                        avatarColor: Colors.purple.shade200,
                        initials: "PC",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ───────────────────────────────
            // 5. FOOTER
            // ───────────────────────────────
            Container(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 30,
                left: 60,
                right: 60,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 40,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Job & internship platform\nfor Universitas Ciputra\nstudents.",
                              style: TextStyle(color: Colors.grey, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Resources",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _footerLink("Help Center"),
                            _footerLink("Career Guide"),
                            _footerLink("Blog"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Legal",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _footerLink("Privacy"),
                            _footerLink("Terms"),
                            _footerLink("Contact"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const Divider(),
                  const SizedBox(height: 20),
                  Text(
                    "© 2025 UC HUB — Universitas Ciputra. All rights reserved.",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- NAVBAR ITEM HELPER ---
  Widget _navItem(String text, int index, GlobalKey key) {
    final bool isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _scrollToSection(key, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            style: TextStyle(
              fontSize: 16,
              color: isActive ? const Color(0xFFFF8A34) : Colors.black87,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              fontFamily: 'Noto Sans',
            ),
            child: Text(text),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 3,
            width: isActive ? 20 : 0,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8A34),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER UNTUK STATISTIK (BARU) ---
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 50, // Font besar untuk angka
            fontWeight: FontWeight.w900,
            color: Color(0xFFD98736), // Warna oranye/emas
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3E50), // Warna gelap untuk label
          ),
        ),
      ],
    );
  }

  // --- OTHER WIDGET HELPERS ---

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color bgColor,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyCard({
    required String companyName,
    required String industry,
    required String description,
    required Color logoColor,
    required IconData logoIcon,
    required int activeJobs,
    required Color pillColor,
  }) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: logoColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(logoIcon, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      industry,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: pillColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.work_outline, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  "$activeJobs Active Jobs",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8A34), Color(0xFFFF6FAF)],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "View Openings",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String major,
    required String quote,
    required Color avatarColor,
    required String initials,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: avatarColor,
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(major, style: TextStyle(fontSize: 14, color: Colors.grey[500])),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) =>
                  const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            quote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {},
        child: Text(
          text,
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
        ),
      ),
    );
  }
}
