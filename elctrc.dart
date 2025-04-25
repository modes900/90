import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';

// ignore: camel_case_types
class elctrc extends StatefulWidget {
  const elctrc({super.key});

  @override
  State<elctrc> createState() => _elctrcState();
}

// ignore: camel_case_types
class _elctrcState extends State<elctrc> {
  int selectedIndex = 0; // Default to فني تكييف
  int _currentImageIndex = 0;
  final List<String> _images = [
    'images/image 7.png',
    'images/image 8.png',
    'images/image 9.png',
    'images/image 10.png',
    'images/image 11.png',
  ];

  // Service provider lists for each category
  final List<Map<String, dynamic>> _electricians = [
    {
      'name': 'محمد عادل',
      'rating': 4.8,
      'experience': '5 سنوات',
      'jobs': '120',
      'image': 'images/tech1.jpg',
      'available': true,
    },
    {
      'name': 'أحمد محمود',
      'rating': 4.7,
      'experience': '3 سنوات',
      'jobs': '80',
      'image': 'images/tech2.jpg',
      'available': true,
    },
  ];

  final List<Map<String, dynamic>> _plumbers = [
    {
      'name': 'عمر خالد',
      'rating': 4.9,
      'experience': '7 سنوات',
      'jobs': '200',
      'image': 'images/plumb1.jpg',
      'available': true,
    },
    {
      'name': 'حسن علي',
      'rating': 4.6,
      'experience': '4 سنوات',
      'jobs': '150',
      'image': 'images/plumb2.jpg',
      'available': true,
    },
  ];

  final List<Map<String, dynamic>> _painters = [
    {
      'name': 'كريم سعيد',
      'rating': 4.7,
      'experience': '6 سنوات',
      'jobs': '180',
      'image': 'images/paint1.jpg',
      'available': true,
    },
    {
      'name': 'محمود رامي',
      'rating': 4.8,
      'experience': '5 سنوات',
      'jobs': '160',
      'image': 'images/paint2.jpg',
      'available': true,
    },
  ];

  final List<Map<String, dynamic>> _acTechs = [
    {
      'name': 'سامح وليد',
      'rating': 4.9,
      'experience': '8 سنوات',
      'jobs': '250',
      'image': 'images/ac1.jpg',
      'available': true,
    },
    {
      'name': 'رامي حسام',
      'rating': 4.7,
      'experience': '4 سنوات',
      'jobs': '130',
      'image': 'images/ac2.jpg',
      'available': true,
    },
  ];

  // Add new service provider lists
  final List<Map<String, dynamic>> _carpenters = [
    {
      'name': 'ياسر محمد',
      'rating': 4.8,
      'experience': '6 سنوات',
      'jobs': '190',
      'image': 'images/carp1.jpg',
      'available': true,
    },
    {
      'name': 'طارق احمد',
      'rating': 4.6,
      'experience': '3 سنوات',
      'jobs': '100',
      'image': 'images/carp2.jpg',
      'available': true,
    },
  ];

  final List<Map<String, dynamic>> _cleaners = [
    {
      'name': 'سمير حسن',
      'rating': 4.9,
      'experience': '5 سنوات',
      'jobs': '220',
      'image': 'images/clean1.jpg',
      'available': true,
    },
    {
      'name': 'فريد عمر',
      'rating': 4.7,
      'experience': '4 سنوات',
      'jobs': '140',
      'image': 'images/clean2.jpg',
      'available': true,
    },
  ];

  late Timer _timer;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _startImageTimer();
    // Check if user is authenticated
    _checkAuthStatus();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startImageTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _images.length;
      });
    });
  }

  void _onButtonTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    // Scroll to the service providers list
    Future.delayed(const Duration(milliseconds: 100), () {
      Scrollable.ensureVisible(
        context,
        alignment: 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _images.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + _images.length) % _images.length;
    });
  }

  // Method to get current service providers based on selected index
  List<Map<String, dynamic>> _getCurrentProviders() {
    switch (selectedIndex) {
      case 0:
        return _acTechs;
      case 1:
        return _painters;
      case 2:
        return _plumbers;
      case 3:
        return _electricians;
      case 4:
        return _carpenters;
      case 5:
        return _cleaners;
      default:
        return _electricians;
    }
  }

  // Method to get service title based on selected index
  String _getServiceTitle() {
    switch (selectedIndex) {
      case 0:
        return 'فنيين التكييف';
      case 1:
        return 'النقاشين';
      case 2:
        return 'السباكين';
      case 3:
        return 'الكهربائيين';
      case 4:
        return 'النجارين';
      case 5:
        return 'خدمات النظافة';
      default:
        return 'الكهربائيين';
    }
  }

  Widget _buildServiceProvidersList() {
    final providers = _getCurrentProviders();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Slide view replacing the title
        Container(
          height: 250,
          margin: const EdgeInsets.only(bottom: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  _getServiceTitle(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: providers.length,
                  itemBuilder: (context, index) {
                    final provider = providers[index];
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 45,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            provider['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber[600],
                                size: 16,
                              ),
                              Text(
                                ' ${provider['rating']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // Existing list view
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: providers.length,
          itemBuilder: (context, index) {
            final provider = providers[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          provider['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (provider['available'])
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'متاح',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber[600],
                              size: 20,
                            ),
                            Text(
                              ' ${provider['rating']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Icon(Icons.work, color: Colors.blue[600], size: 20),
                            Text(
                              ' ${provider['experience']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Icon(
                              Icons.handyman,
                              color: Colors.purple[600],
                              size: 20,
                            ),
                            Text(
                              ' ${provider['jobs']} مهمة',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    ReservationPage(provider: provider),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('حجز موعد'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFB71C1C),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              _services.map<Widget>((service) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ServiceButton(
                    title: service['title'],
                    isSelected: selectedIndex == service['index'],
                    onTap: () => _onButtonTap(service['index']),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated ? _buildMainApp() : const LoginPage();
  }

  Widget _buildMainApp() {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReservationsViewPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const Text(
                    'الحجوزات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isAuthenticated = false;
                      });
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const Text(
                    'العاشر من رمضان',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'هنلف مصر كلها',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Image.asset(
                                  _images[_currentImageIndex],
                                  key: ValueKey<int>(_currentImageIndex),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Left scroll button
                              Positioned(
                                left: 10,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                      ),
                                      onPressed: _previousImage,
                                    ),
                                  ),
                                ),
                              ),
                              // Right scroll button
                              Positioned(
                                right: 10,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                      onPressed: _nextImage,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _images.length,
                                    (index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            _currentImageIndex == index
                                                ? const Color(0xFFB71C1C)
                                                : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            _buildServiceButtons(),
                          ],
                        ),
                      ),
                      _buildServiceProvidersList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkAuthStatus() {
    // TODO: Implement actual authentication check
    setState(() {
      _isAuthenticated = false; // Set to false to show login page
    });
  }
}

// ignore: camel_case_types
final List<Map<String, dynamic>> _services = [
  {'title': 'فني تكييف', 'index': 0},
  {'title': 'نقاش', 'index': 1},
  {'title': 'سباك', 'index': 2},
  {'title': 'كهربائي', 'index': 3},
  {'title': 'نجار', 'index': 4},
  {'title': 'نظافة', 'index': 5},
];

class ServiceButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        // Scroll to the service providers list with animation
        Future.delayed(const Duration(milliseconds: 100), () {
          Scrollable.ensureVisible(
            context,
            alignment: 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
      child: SizedBox(
        width: 100, // Fixed width for all buttons
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFFB71C1C) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFFB71C1C) : Colors.grey,
                  width: 1,
                ),
              ),
              child: Icon(
                _getIconForService(title),
                color: isSelected ? Colors.white : Colors.black87,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFFB71C1C) : Colors.black87,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForService(String service) {
    switch (service) {
      case 'فني تكييف':
        return Icons.ac_unit;
      case 'نقاش':
        return Icons.format_paint;
      case 'سباك':
        return Icons.plumbing;
      case 'كهربائي':
        return Icons.electrical_services;
      case 'نجار':
        return Icons.handyman;
      case 'نظافة':
        return Icons.cleaning_services;
      default:
        return Icons.home_repair_service;
    }
  }
}

// Reservation Page
class ReservationPage extends StatefulWidget {
  final Map<String, dynamic> provider;

  const ReservationPage({super.key, required this.provider});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _submitReservation() {
    if (_formKey.currentState!.validate()) {
      // Create new reservation with all details
      final newReservation = {
        'id': DateTime.now().millisecondsSinceEpoch % 10000,
        'name': _nameController.text,
        'service': widget.provider['name'],
        'serviceType': _getServiceType(),
        'status': 'مؤكد',
        'isActive': true,
        'date': _selectedDate,
        'time': _selectedTime.format(context),
        'phone': _phoneController.text,
        'location': _locationController.text,
        'provider': {
          'name': widget.provider['name'],
          'rating': widget.provider['rating'],
          'experience': widget.provider['experience'],
          'jobs': widget.provider['jobs'],
        },
      };

      // Find the ReservationsViewPage state and add the new reservation
      final reservationsViewState =
          context.findAncestorStateOfType<_ReservationsViewPageState>();
      if (reservationsViewState != null) {
        // Add the new reservation to the list
        reservationsViewState.addReservation(newReservation);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حجز الموعد بنجاح'),
            backgroundColor: Color(0xFFB71C1C),
          ),
        );

        // Clear form fields
        _nameController.clear();
        _phoneController.clear();
        _locationController.clear();
        _selectedDate = DateTime.now();
        _selectedTime = TimeOfDay.now();

        // Navigate back to reservations list
        Navigator.pop(context);
      } else {
        // Show error if ReservationsViewPage state is not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ في حفظ الحجز'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Helper method to get service type
  String _getServiceType() {
    switch (widget.provider['name']) {
      case 'محمد عادل':
      case 'أحمد محمود':
        return 'كهربائي';
      case 'عمر خالد':
      case 'حسن علي':
        return 'سباك';
      case 'كريم سعيد':
      case 'محمود رامي':
        return 'نقاش';
      case 'سامح وليد':
      case 'رامي حسام':
        return 'فني تكييف';
      case 'ياسر محمد':
      case 'طارق احمد':
        return 'نجار';
      case 'سمير حسن':
      case 'فريد عمر':
        return 'نظافة';
      default:
        return 'خدمة أخرى';
    }
  }

  void _showClearConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تأكيد المسح',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'هل أنت متأكد من مسح جميع بيانات الحجز؟',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'رجوع',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _clearForm();
                  },
                  child: const Text(
                    'تأكيد المسح',
                    style: TextStyle(
                      color: Color(0xFFB71C1C),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectLocation() async {
    // Show location selection dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFB71C1C), width: 2),
              ),
            ),
            child: const Column(
              children: [
                Text(
                  'اختر المنطقة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB71C1C),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'قم باختيار المنطقة التي تريد الخدمة فيها',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLocationOption('العاشر من رمضان'),
                _buildLocationOption('الرحاب'),
                _buildLocationOption('مدينة السلام'),
                _buildLocationOption('مدينة الشروق'),
                _buildLocationOption('مدينة العبور'),
                _buildLocationOption('مدينة بدر'),
                _buildLocationOption('مدينة العاصمة الإدارية'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationOption(String location) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Color(0xFFB71C1C)),
      title: Text(
        location,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        setState(() {
          _locationController.text = location;
        });
        Navigator.pop(context);
      },
    );
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _phoneController.clear();
      _locationController.clear();
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم مسح بيانات الحجز'),
        backgroundColor: Color(0xFFB71C1C),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حجز موعد',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: const Color(0xFFB71C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _showClearConfirmationDialog,
            tooltip: 'مسح البيانات',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Provider Info
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.provider['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber[600],
                              size: 20,
                            ),
                            Text(
                              ' ${widget.provider['rating']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Form Fields
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء إدخال رقم الهاتف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Location Field
              TextFormField(
                controller: _locationController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'المنطقة',
                  hintText: 'اختر المنطقة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Color(0xFFB71C1C),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: _selectLocation,
                    color: const Color(0xFFB71C1C),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء اختيار المنطقة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Date and Time Selection
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        'التاريخ: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _selectTime(context),
                      icon: const Icon(Icons.access_time),
                      label: Text('الوقت: ${_selectedTime.format(context)}'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Submit and Clear buttons row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitReservation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB71C1C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'تأكيد الحجز',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _showClearConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete_outline),
                        SizedBox(width: 8),
                        Text('مسح', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reservations View Page
class ReservationsViewPage extends StatefulWidget {
  const ReservationsViewPage({super.key});

  @override
  State<ReservationsViewPage> createState() => _ReservationsViewPageState();
}

class _ReservationsViewPageState extends State<ReservationsViewPage> {
  List<Map<String, dynamic>> reservations = [];

  @override
  void initState() {
    super.initState();
    // Load saved reservations when the page is initialized
    _loadReservations();
  }

  void _loadReservations() {
    // Here you would typically load from a database or storage
    // For now, we'll keep them in memory
    setState(() {
      // Initialize with empty list or load from storage
      reservations = [];
    });
  }

  void addReservation(Map<String, dynamic> reservation) {
    setState(() {
      // Add timestamp for sorting
      reservation['timestamp'] = DateTime.now().millisecondsSinceEpoch;
      // Insert new reservation at the beginning of the list
      reservations.insert(0, reservation);
    });
    // Here you would typically save to a database or storage
    _saveReservations();
  }

  void _saveReservations() {
    // Here you would typically save to a database or storage
    // For now, we'll just keep them in memory
    print('Saving ${reservations.length} reservations');
  }

  void _clearAllReservations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تأكيد المسح',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'هل أنت متأكد من مسح جميع الحجوزات؟',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'رجوع',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      reservations.clear();
                    });
                    _saveReservations(); // Save after clearing
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم مسح جميع الحجوزات'),
                        backgroundColor: Color(0xFFB71C1C),
                      ),
                    );
                  },
                  child: const Text(
                    'تأكيد المسح',
                    style: TextStyle(
                      color: Color(0xFFB71C1C),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تأكيد الإلغاء',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'هل أنت متأكد من إلغاء هذا الحجز؟',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'رجوع',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      reservations[index]['status'] = 'ملغي';
                      reservations[index]['isActive'] = false;
                    });
                    _saveReservations(); // Save after updating
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إلغاء الحجز بنجاح'),
                        backgroundColor: Color(0xFFB71C1C),
                      ),
                    );
                  },
                  child: const Text(
                    'تأكيد الإلغاء',
                    style: TextStyle(
                      color: Color(0xFFB71C1C),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
        title: const Text(
          'الحجوزات',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: const Color(0xFFB71C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (reservations.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: _clearAllReservations,
              tooltip: 'مسح جميع الحجوزات',
            ),
        ],
      ),
      body:
          reservations.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'لا توجد حجوزات',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'قم بإضافة حجز جديد',
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  final isNewReservation =
                      index == 0; // Check if it's the newest reservation

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border:
                          isNewReservation
                              ? Border.all(
                                color: const Color(0xFFB71C1C),
                                width: 2,
                              )
                              : null,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ReservationDetailsPage(
                                      reservation: reservation,
                                    ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: const Color(0xFFB71C1C),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'حجز رقم #${reservation['id']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        if (isNewReservation) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFB71C1C),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Text(
                                              'جديد',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${reservation['name']} - ${reservation['serviceType']}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'الفني: ${reservation['provider']['name']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        reservation['status'] == 'مؤكد'
                                            ? Colors.green[100]
                                            : Colors.red[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    reservation['status'],
                                    style: TextStyle(
                                      color:
                                          reservation['status'] == 'مؤكد'
                                              ? Colors.green
                                              : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: [
                                    _buildInfoRow(
                                      Icons.calendar_today,
                                      'التاريخ',
                                      '${reservation['date'].day}/${reservation['date'].month}/${reservation['date'].year}',
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.access_time,
                                      'الوقت',
                                      reservation['time'],
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.phone,
                                      'رقم الهاتف',
                                      reservation['phone'],
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.location_on,
                                      'العنوان',
                                      reservation['location'],
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.person,
                                      'الفني',
                                      reservation['provider']['name'],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber[600],
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${reservation['provider']['rating']}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 15),
                                        Icon(
                                          Icons.work,
                                          color: Colors.blue[600],
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          reservation['provider']['experience'],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (reservation['isActive'])
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () => _showCancelDialog(index),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cancel, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'إلغاء الحجز',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

// Add ReservationDetailsPage
class ReservationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> reservation;

  const ReservationDetailsPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفاصيل الحجز',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: const Color(0xFFB71C1C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFFB71C1C),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    reservation['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    reservation['service'],
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInfoCard('معلومات الحجز', [
                    _buildInfoRow(
                      Icons.confirmation_number,
                      'رقم الحجز',
                      '#${reservation['id']}',
                    ),
                    _buildInfoRow(
                      Icons.calendar_today,
                      'التاريخ',
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    ),
                    _buildInfoRow(Icons.access_time, 'الوقت', '02:30 PM'),
                    _buildInfoRow(
                      Icons.check_circle,
                      'الحالة',
                      reservation['status'],
                      color:
                          reservation['status'] == 'مؤكد'
                              ? Colors.green
                              : Colors.red,
                    ),
                  ]),
                  const SizedBox(height: 20),
                  _buildInfoCard('معلومات العميل', [
                    _buildInfoRow(Icons.phone, 'رقم الهاتف', '01234567890'),
                    _buildInfoRow(
                      Icons.location_on,
                      'العنوان',
                      reservation['location'],
                    ),
                  ]),
                  if (reservation['isActive']) const SizedBox(height: 30),
                  if (reservation['isActive'])
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text(
                          'تعديل الحجز',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB71C1C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
