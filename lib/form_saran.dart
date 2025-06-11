import 'package:flutter/material.dart';

class FormSaran extends StatefulWidget {
  const FormSaran({super.key});

  @override
  State<FormSaran> createState() => _FormSaranState();
}

class _FormSaranState extends State<FormSaran> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _saranController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Saran & Masukan')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _saranController,
                decoration: const InputDecoration(labelText: 'Saran / Masukan'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Saran tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Terima kasih atas masukan, ${_namaController.text}!',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
