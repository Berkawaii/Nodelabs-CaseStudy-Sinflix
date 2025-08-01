import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class PhotoUploadPage extends StatefulWidget {
  const PhotoUploadPage({super.key});

  @override
  State<PhotoUploadPage> createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final l10n = AppLocalizations.of(context)!;
    
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      _showErrorSnackBar(l10n.photoSelectError);
    }
  }

  Future<void> _uploadPhoto() async {
    final l10n = AppLocalizations.of(context)!;
    
    if (_selectedImage == null) {
      _showErrorSnackBar(l10n.selectPhoto);
      return;
    }

    context.read<ProfileBloc>().add(UploadPhoto(imageFile: _selectedImage!));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is PhotoUploadSuccess) {
              _showSuccessSnackBar(l10n.photoUploadedSuccessfully);
              Navigator.pop(context, true);
            } else if (state is ProfileError) {
              _showErrorSnackBar(l10n.photoUploadError);
            }
          },
          builder: (context, state) {
            final isUploading = state is PhotoUploading;

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // App Bar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        l10n.profileDetail,
                        style: AppTextStyles.h2.copyWith(
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // Title and Description
                  Text(
                    l10n.uploadPhotos,
                    style: AppTextStyles.h2.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    l10n.uploadPhotosDescription,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey, height: 1.5),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 60),

                  // Image Upload Area
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: isUploading ? null : _pickImage,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppColors.grey.withOpacity(0.3),
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: _selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                                )
                              : Icon(Icons.add, size: 48, color: AppColors.grey),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Upload Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: isUploading ? null : _uploadPhoto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: isUploading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              l10n.continueButton,
                              style: AppTextStyles.button.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
