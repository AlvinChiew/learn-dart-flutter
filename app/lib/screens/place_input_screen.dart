import 'dart:io';

import 'package:app/components/photo_input.dart';
import 'package:app/components/location_input.dart';
import 'package:app/models/place_model.dart';
import 'package:app/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceInputScreen extends ConsumerStatefulWidget {
  const PlaceInputScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return PlaceInputState();
  }
}

class PlaceInputState extends ConsumerState<PlaceInputScreen> {
  final formKey = GlobalKey<FormState>();
  String _name = '';
  File? _photo;
  PlaceLocation? _location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid input';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onSaved: (value) {
                  _name = value!;
                },
              ),
            ),
            const SizedBox(height: 16),
            PhotoInput((photo) {
              _photo = photo;
            }),
            const SizedBox(height: 16),
            LocationInput((location) {
              _location = location;
            }),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  if (_location == null || _photo == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please provide all inputs')));
                    return;
                  }

                  ref
                      .read(placeProvider.notifier)
                      .modifyPlaces(_name, _location!, _photo!);
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
