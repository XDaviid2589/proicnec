import 'package:flutter/material.dart';
import 'package:proicnec/utils/date_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // get auth service
  final authService = AuthService();

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _firstSurnameController = TextEditingController();
  final _secondSurnameController = TextEditingController();
  final _dniController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _birthDate;

  void _showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<bool> _checkIfExists(String column, String value) async {
  final response = await Supabase.instance.client
      .from('User')
      .select(column)
      .eq(column, value)
      .limit(1)
      .maybeSingle();

  return response != null;
}

  void signUp() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();
  final confirmPassword = _confirmPasswordController.text.trim();
  final name = _nameController.text.trim();
  final firstSurname = _firstSurnameController.text.trim();
  final secondSurname = _secondSurnameController.text.trim();
  final dni = _dniController.text.trim();
  final phone = _phoneController.text.trim();

  // Validación básica de campos vacíos
  if ([email, password, confirmPassword, name, firstSurname, secondSurname, dni, phone].any((e) => e.isEmpty) || _birthDate == null) {
    _showError("Please fill in all required fields.");
    return;
  }

  // Validación de contraseñas
  if (password != confirmPassword) {
    _showError("Passwords don't match.");
    return;
  }

  // Validación de email único
  final emailExists = await _checkIfExists('email', email);
  if (emailExists) {
    _showError("This email is already in use.");
    return;
  }

  // Validación de DNI (8 números + 1 letra)
  final dniRegex = RegExp(r'^\d{8}[A-Za-z]$');
  if (!dniRegex.hasMatch(dni)) {
    _showError("DNI must be 8 digits followed by a letter.");
    return;
  }

  final dniExists = await _checkIfExists('dni', dni);
  if (dniExists) {
    _showError("This DNI is already in use.");
    return;
  }

// Validación de teléfono (solo 9 dígitos, sin prefijo)
final phoneRegex = RegExp(r'^[0-9]{9}$');
if (!phoneRegex.hasMatch(phone)) {
  _showError("Phone number must contain exactly 9 digits and no country code.");
  return;
}


  try {
    final response = await authService.signUpWithEmailPassword(email, password);
    final userId = response.user?.id;

    if (userId != null) {
      await Supabase.instance.client.from('User').insert({
        'id_user': userId,
        'email': email,
        'name': name,
        'first_name': firstSurname,
        'last_name': secondSurname,
        'date_birth': _birthDate!.toIso8601String(),
        'dni': dni,
        'phone_number': phone,
        'creation_date': DateTime.now().toIso8601String(),
      });
    }

    if (mounted) {
      Navigator.of(context).pushReplacementNamed("/home");
    }
  } catch (e) {
    _showError("Error: $e");
  }
}



  Future<void> _selectBirthDate() async {
  final picked = await showDatePickerDialog(context: context);
  if (picked != null) {
    setState(() {
      _birthDate = picked;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        children: [
          TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
          TextField(controller: _passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
          TextField(controller: _confirmPasswordController, decoration: const InputDecoration(labelText: "Confirm Password"), obscureText: true),
          const SizedBox(height: 12),

          TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
          TextField(controller: _firstSurnameController, decoration: const InputDecoration(labelText: "First Surname")),
          TextField(controller: _secondSurnameController, decoration: const InputDecoration(labelText: "Second Surname")),
          TextField(controller: _dniController, decoration: const InputDecoration(labelText: "DNI")),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
          ),
         ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: Colors.grey[200],
          title: Text(
            _birthDate == null
              ? "Select Birth Date"
              : "Birth Date: ${_birthDate!.toLocal().toIso8601String().substring(0, 10)}",
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: _selectBirthDate,
        ),
          const SizedBox(height: 35),

          ElevatedButton(onPressed: signUp, child: const Text("Sign Up")),
        ],
      ),
    );
  }
}
