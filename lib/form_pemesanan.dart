import 'package:flutter/material.dart';

class FormPemesanan extends StatefulWidget {
  const FormPemesanan({super.key});

  @override
  State<FormPemesanan> createState() => _FormPemesananState();
}

class _FormPemesananState extends State<FormPemesanan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahTiketController = TextEditingController();
  DateTime? _selectedDate;
  String? _jenisTiket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan Tiket')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Pemesan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Jumlah Tiket
              TextFormField(
                controller: _jumlahTiketController,
                decoration: const InputDecoration(labelText: 'Jumlah Tiket'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah tiket wajib diisi';
                  }
                  final jumlah = int.tryParse(value);
                  if (jumlah == null || jumlah <= 0) {
                    return 'Masukkan jumlah tiket yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Jenis Tiket
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Jenis Tiket'),
                value: _jenisTiket,
                items: const [
                  DropdownMenuItem(value: 'Reguler', child: Text('Reguler')),
                  DropdownMenuItem(value: 'VIP', child: Text('VIP')),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisTiket = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Pilih jenis tiket' : null,
              ),
              const SizedBox(height: 10),

              // Tanggal Pemesanan
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tanggal Event'),
                subtitle: Text(
                  _selectedDate == null
                      ? 'Belum dipilih'
                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
              if (_selectedDate == null)
                const Text(
                  'Tanggal wajib dipilih',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),

              const SizedBox(height: 20),

              // Tombol Submit
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Pemesanan berhasil untuk ${_namaController.text} '
                          '(${_jumlahTiketController.text} tiket $_jenisTiket, '
                          'tanggal ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year})',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    setState(() {});
                  }
                },
                child: const Text('Pesan Tiket'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
