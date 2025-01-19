import 'package:flutter/material.dart';
import 'package:machine_test1/MVVM/model/service/firebaseAuthservices.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String dropdown = "Flutter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: widget.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: widget.nameController,
                  decoration: InputDecoration(
                    hintText: "Enter your Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  "Place",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: widget.placeController,
                  decoration: InputDecoration(
                    hintText: "Enter your Place",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Place is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  "Technology",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: dropdown,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Flutter", child: Text("Flutter")),
                    DropdownMenuItem(value: "MERN", child: Text("MERN")),
                    DropdownMenuItem(value: "UI/UX", child: Text("UI/UX")),
                    DropdownMenuItem(
                        value: "Digital Marketing", child: Text("Digital Marketing")),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdown = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: widget.emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: widget.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Create your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                Center(
                  child: TextButton(
                    onPressed: ()async {
                      if (widget.formkey.currentState!.validate()) {
                        await Firebaceservices().createUser(context, widget.emailController.text,widget.passwordController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup Successful!")),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 10, 10, 10)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 246, 246, 246)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      ),
                    ),
                    child: const Text(
                      "SignUp",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
