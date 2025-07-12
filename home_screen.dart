import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/ai_service.dart';
import '../widgets/feature_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;
  final picker = ImagePicker();
  bool isLoading = false;

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => imageFile = File(pickedFile.path));
  }

  void applyAI(String type) async {
    if (imageFile == null) return;

    setState(() => isLoading = true);

    final result = await AIService().applyEffect(imageFile!, type);

    if (result != null) {
      setState(() => imageFile = result);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AT Editor')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: pickImage, child: const Text('Pick Image')),
            const SizedBox(height: 10),
            if (imageFile != null)
              Expanded(
                child: Image.file(imageFile!, fit: BoxFit.contain),
              ),
            const SizedBox(height: 10),
            if (isLoading) const CircularProgressIndicator(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FeatureButton(label: "Background Remove", onTap: () => applyAI("background")),
                FeatureButton(label: "Face Retouch", onTap: () => applyAI("face_retouch")),
                FeatureButton(label: "Auto Enhance", onTap: () => applyAI("enhance")),
                FeatureButton(label: "Cartoonify", onTap: () => applyAI("cartoon")),
                FeatureButton(label: "Style Transfer", onTap: () => applyAI("style")),
                FeatureButton(label: "Sketch", onTap: () => applyAI("sketch")),
                FeatureButton(label: "8K Upscale", onTap: () => applyAI("upscale")),
                FeatureButton(label: "Object Remove", onTap: () => applyAI("object")),
                FeatureButton(label: "Face Swap", onTap: () => applyAI("face_swap")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
