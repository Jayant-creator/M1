class AuthService {
  static bool isLoggedIn = false;
  static String? email;
  static String? username;
  static String? profilePic;
  static String generatedOTP = "1234";

  // ===== OTP SEND =====
  static Future<void> sendOTP(String mail) async {
    email = mail;
    generatedOTP = "1234"; // demo OTP
  }

  // ===== OTP VERIFY =====
  static bool verifyOTP(String otp) {
    return otp == generatedOTP;
  }

  // ===== CREATE ACCOUNT =====
  static bool createAccount(String email_, String user, String pass) {
    if (email_.isEmpty || user.isEmpty || pass.isEmpty) {
      return false;
    }
    email = email_;
    username = user;
    isLoggedIn = true;
    return true;
  }

  // ===== LOGIN =====
  static bool login(String email_, String user) {
    if (email_.isEmpty || user.isEmpty) {
      return false;
    }
    email = email_;
    username = user;
    isLoggedIn = true;
    return true;
  }

  // ===== LOGOUT =====
  static void logout() {
    isLoggedIn = false;
    email = null;
    username = null;
    profilePic = null;
  }

  // ===== VALIDATION =====
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}
