
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: const Color(0xfffdf5fc),
      ),
      home: const RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() =>
      _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  String? gender;
  String? month;

  bool wifi = false;
  bool sunday = false;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;

  bool hidePassword = true;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void submitForm() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Submitted Resume Data'),

        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Name: ${nameController.text}'),

              Text('Email: ${emailController.text}'),

              Text('Phone No: ${phoneController.text}'),

              Text('Password: ${passwordController.text}'),

              Text('Address: ${addressController.text}'),

              Text('Gender: ${gender ?? "Not selected"}'),

              Text('WiFi: ${wifi ? "ON" : "OFF"}'),

              Text('Sunday: ${sunday ? "Selected" : "Not Selected"}'),

              Text('Monday: ${monday ? "Selected" : "Not Selected"}'),

              Text('Tuesday: ${tuesday ? "Selected" : "Not Selected"}'),

              Text('Wednesday: ${wednesday ? "Selected" : "Not Selected"}'),

              Text('Month: ${month ?? "Not selected"}'),

            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

  void loginForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login Button Pressed'),
      ),
    );
  }

  InputDecoration boxDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffdf5fc),
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: const Text(
          'Welcome to Registration Form',
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Search the Name
            const Text(
              'Search the Name',
              style: TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 10),

            // Enter Name
            const Text(
              'Enter Name',
              style: TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 5),

            TextField(
              controller: nameController,
              maxLength: 20,
              decoration: boxDecoration('Enter Name'),
            ),

            const SizedBox(height: 5),

            // Password
            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              maxLength: 20,
              decoration: boxDecoration('Password').copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Enter Email
            const Center(
              child: Text(
                'Enter Email',
                style: TextStyle(fontSize: 12),
              ),
            ),

            const SizedBox(height: 5),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: boxDecoration('Enter Email Address'),
            ),

            const SizedBox(height: 15),

            // Enter Phone Number
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: boxDecoration('Enter Phone No').copyWith(
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Colors.red,
                ),
                suffixIcon: const Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Address
            TextField(
              controller: addressController,
              maxLines: 4,
              decoration: boxDecoration('Enter Address'),
            ),

            const SizedBox(height: 25),

            // Gender
            const Text(
              'Gender',
              style: TextStyle(fontSize: 12),
            ),

            RadioListTile<String>(
              title: const Text(
                'Male',
                style: TextStyle(fontSize: 12),
              ),
              subtitle: const Text(
                'Select for Male',
                style: TextStyle(fontSize: 10),
              ),
              value: 'Male',
              groupValue: gender,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text(
                'Female',
                style: TextStyle(fontSize: 12),
              ),
              subtitle: const Text(
                'Select for Female',
                style: TextStyle(fontSize: 10),
              ),
              value: 'Female',
              groupValue: gender,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),

            const SizedBox(height: 10),

            // WiFi Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wifi on/off',
                  style: TextStyle(fontSize: 12),
                ),

                Switch(
                  value: wifi,
                  activeColor: Colors.deepPurple,
                  onChanged: (value) {
                    setState(() {
                      wifi = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Sunday
            CheckboxListTile(
              title: const Text(
                'Sunday',
                style: TextStyle(fontSize: 12),
              ),
              value: sunday,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  sunday = value ?? false;
                });
              },
            ),

            // Monday
            CheckboxListTile(
              title: const Text(
                'Monday',
                style: TextStyle(fontSize: 12),
              ),
              value: monday,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  monday = value ?? false;
                });
              },
            ),

            // Tuesday
            CheckboxListTile(
              title: const Text(
                'Tuesday',
                style: TextStyle(fontSize: 12),
              ),
              value: tuesday,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  tuesday = value ?? false;
                });
              },
            ),

            // Wednesday
            CheckboxListTile(
              title: const Text(
                'Wednesday',
                style: TextStyle(fontSize: 12),
              ),
              value: wednesday,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  wednesday = value ?? false;
                });
              },
            ),

            const SizedBox(height: 10),

            // Select Month
            DropdownButtonFormField<String>(
              value: month,
              decoration: boxDecoration('Select Month'),
              items: months.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  month = value;
                });
              },
            ),

            const SizedBox(height: 25),

            // Submit and Login Buttons
            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: submitForm,
                    icon: const Icon(Icons.login),
                    label: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: loginForm,
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}