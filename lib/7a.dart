
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ResumeForm(),
  ));
}

class ResumeForm extends StatefulWidget {
  const ResumeForm({super.key});

  @override
  State<ResumeForm> createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  final nameController = TextEditingController();
  final regnoController = TextEditingController();
  final yearsController = TextEditingController();
  final mailController = TextEditingController();
  final imageController = TextEditingController();
  final tenthController = TextEditingController();
  final interController = TextEditingController();
  final skillsController = TextEditingController();
  final enterNameController = TextEditingController();
  final addressController = TextEditingController();

  String? gender;
  String? college;

  final List<String> colleges = [
    'SVECW',
    'JNTU',
    'Other',
  ];

  @override
  void dispose() {
    nameController.dispose();
    regnoController.dispose();
    yearsController.dispose();
    mailController.dispose();
    imageController.dispose();
    tenthController.dispose();
    interController.dispose();
    skillsController.dispose();
    enterNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void resetForm() {
    nameController.clear();
    regnoController.clear();
    yearsController.clear();
    mailController.clear();
    imageController.clear();
    tenthController.clear();
    interController.clear();
    skillsController.clear();
    enterNameController.clear();
    addressController.clear();

    setState(() {
      gender = null;
      college = null;
    });
  }

  

void submitForm() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Resume Details'),

        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // STEP 4: ADD IMAGE HERE
              Center(
                child: Image.asset(
                  'assets/profile.jpeg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 15),

              // All Resume Details
              Text('Name: ${nameController.text}'),

              Text('Regno: ${regnoController.text}'),

              Text(
                'Years (Section): ${yearsController.text}',
              ),

              Text('Mail ID: ${mailController.text}'),

              Text('Image: ${imageController.text}'),

              Text('10th: ${tenthController.text}'),

              Text('Inter: ${interController.text}'),

              Text('Skills: ${skillsController.text}'),

              Text(
                'Enter Name: ${enterNameController.text}',
              ),

              Text(
                'Gender: ${gender ?? "Not selected"}',
              ),

              Text('Address: ${addressController.text}'),

              Text(
                'College Name: ${college ?? "Not selected"}',
              ),
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
  InputDecoration fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Form'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // Name
            TextField(
              controller: nameController,
              decoration: fieldDecoration('Name'),
            ),

            const SizedBox(height: 15),

            // Regno
            TextField(
              controller: regnoController,
              decoration: fieldDecoration('Regno'),
            ),

            const SizedBox(height: 15),

            // Years (Section)
            TextField(
              controller: yearsController,
              decoration: fieldDecoration('Years'),
            ),

            const SizedBox(height: 15),

            // Mail ID
            TextField(
              controller: mailController,
              keyboardType: TextInputType.emailAddress,
              decoration: fieldDecoration('Mail ID'),
            ),

            const SizedBox(height: 15),

            // Image
            // Profile Image
Column(
  children: [
    const Text(
      'Profile Image',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 10),

    ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: Image.asset(
        'assets/profile.jpeg',
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    ),
  ],
),

            const SizedBox(height: 15),

            // 10th
            TextField(
              controller: tenthController,
              decoration: fieldDecoration('10th'),
            ),

            const SizedBox(height: 15),

            // Inter
            TextField(
              controller: interController,
              decoration: fieldDecoration('Inter'),
            ),

            const SizedBox(height: 20),

            // Skills
            TextField(
              controller: skillsController,
              maxLines: 4,
              decoration: fieldDecoration('Skills'),
            ),

            const SizedBox(height: 20),

            // Enter Name
            TextField(
              controller: enterNameController,
              decoration: fieldDecoration('Enter Name'),
            ),

            const SizedBox(height: 20),

            // Gender
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gender:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),

            const SizedBox(height: 10),

            // Address
            TextField(
              controller: addressController,
              maxLines: 4,
              decoration: fieldDecoration('Address'),
            ),

            const SizedBox(height: 20),

            // College Name
            DropdownButtonFormField<String>(
              value: college,
              decoration: fieldDecoration('College Name'),
              items: colleges.map((collegeName) {
                return DropdownMenuItem<String>(
                  value: collegeName,
                  child: Text(collegeName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  college = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // Submit and Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Submit'),
                ),

                const SizedBox(width: 20),

                ElevatedButton(
                  onPressed: resetForm,
                  child: const Text('Reset'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}