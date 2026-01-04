import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/constants/countries.dart';
import '../../../core/theme/app_colors.dart';

class CountrySelectionView extends StatelessWidget {
  final String? selectedCountryCode;

  const CountrySelectionView({
    Key? key,
    this.selectedCountryCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        itemCount: Countries.euCountries.length,
        itemBuilder: (context, index) {
          final country = Countries.euCountries[index];
          final isSelected = country.code == selectedCountryCode;

          return ListTile(
            leading: Text(
              country.flag,
              style: const TextStyle(fontSize: 32),
            ),
            title: Text(
              country.name,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
            trailing: isSelected
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                  )
                : null,
            onTap: () => Get.back(result: country),
          );
        },
      ),
    );
  }
}

