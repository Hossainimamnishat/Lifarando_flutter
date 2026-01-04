class Country {
  final String name;
  final String code;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.flag,
  });
}

class Countries {
  // EU Countries list with Germany first
  static const List<Country> euCountries = [
    Country(name: 'Germany', code: 'DE', flag: '🇩🇪'),
    Country(name: 'Austria', code: 'AT', flag: '🇦🇹'),
    Country(name: 'Belgium', code: 'BE', flag: '🇧🇪'),
    Country(name: 'Bulgaria', code: 'BG', flag: '🇧🇬'),
    Country(name: 'Croatia', code: 'HR', flag: '🇭🇷'),
    Country(name: 'Cyprus', code: 'CY', flag: '🇨🇾'),
    Country(name: 'Czech Republic', code: 'CZ', flag: '🇨🇿'),
    Country(name: 'Denmark', code: 'DK', flag: '🇩🇰'),
    Country(name: 'Estonia', code: 'EE', flag: '🇪🇪'),
    Country(name: 'Finland', code: 'FI', flag: '🇫🇮'),
    Country(name: 'France', code: 'FR', flag: '🇫🇷'),
    Country(name: 'Greece', code: 'GR', flag: '🇬🇷'),
    Country(name: 'Hungary', code: 'HU', flag: '🇭🇺'),
    Country(name: 'Ireland', code: 'IE', flag: '🇮🇪'),
    Country(name: 'Italy', code: 'IT', flag: '🇮🇹'),
    Country(name: 'Latvia', code: 'LV', flag: '🇱🇻'),
    Country(name: 'Lithuania', code: 'LT', flag: '🇱🇹'),
    Country(name: 'Luxembourg', code: 'LU', flag: '🇱🇺'),
    Country(name: 'Malta', code: 'MT', flag: '🇲🇹'),
    Country(name: 'Netherlands', code: 'NL', flag: '🇳🇱'),
    Country(name: 'Poland', code: 'PL', flag: '🇵🇱'),
    Country(name: 'Portugal', code: 'PT', flag: '🇵🇹'),
    Country(name: 'Romania', code: 'RO', flag: '🇷🇴'),
    Country(name: 'Slovakia', code: 'SK', flag: '🇸🇰'),
    Country(name: 'Slovenia', code: 'SI', flag: '🇸🇮'),
    Country(name: 'Spain', code: 'ES', flag: '🇪🇸'),
    Country(name: 'Sweden', code: 'SE', flag: '🇸🇪'),
  ];

  static Country getCountryByCode(String code) {
    return euCountries.firstWhere(
      (country) => country.code == code,
      orElse: () => euCountries.first,
    );
  }
}

