import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController otp = TextEditingController();
  final TextEditingController user = TextEditingController();
  final TextEditingController pass = TextEditingController();

  bool verified = false;
  String msg = "";

  void show(String m) {
    setState(() => msg = m);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify & Create Account")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Verify OTP sent to your email",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Demo OTP: 1234",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: otp,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: "4 Digit OTP",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pin),
                counterText: "",
              ),
            ),
            const SizedBox(height: 15),
            if (msg.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: msg.contains("Verified")
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  msg,
                  style: TextStyle(
                    color: msg.contains("Verified")
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (otp.text.isEmpty) {
                    show("Please enter OTP ❌");
                    return;
                  }
                  if (AuthService.verifyOTP(otp.text)) {
                    setState(() {
                      verified = true;
                      msg = "OTP Verified ✅";
                    });
                  } else {
                    show("Wrong OTP ❌");
                  }
                },
                child: const Text("Verify OTP"),
              ),
            ),
            if (verified) ...[
              const SizedBox(height: 20),
              const Text(
                "Create Username & Password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: user,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (user.text.isEmpty || pass.text.isEmpty) {
                      show("Fill all fields");
                      return;
                    }
                    if (AuthService.createAccount(
                        AuthService.email ?? "", user.text, pass.text)) {
                      Navigator.popUntil(context, (r) => r.isFirst);
                    } else {
                      show("Account creation failed");
                    }
                  },
                  child: const Text("Create Account"),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    otp.dispose();
    user.dispose();
    pass.dispose();
    super.dispose();
  }
}
