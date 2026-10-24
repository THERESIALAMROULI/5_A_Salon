class ApiConfig {
  /// Alamat host server Laravel di cloud Render
  static String get host => 'laravel-tubes-atmabarber.onrender.com';

  /// Base URL utama untuk seluruh endpoint API
  static String get baseUrl => 'https://laravel-tubes-atmabarber.onrender.com/api';

  /// Authority dan base path untuk pemanggilan berbasis Uri.https()
  static String get authority => host;
  static String get basePath => '/api';
}

