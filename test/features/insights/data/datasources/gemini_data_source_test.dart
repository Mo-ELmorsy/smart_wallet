import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/features/insights/data/datasources/gemini_data_source.dart';

@GenerateMocks([SharedPreferences])
import 'gemini_data_source_test.mocks.dart';

void main() {
  late GeminiDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = GeminiDataSourceImpl(mockSharedPreferences);
  });

  group('GeminiDataSource', () {
    test('should throw Exception when API key is missing', () async {
      // arrange
      when(mockSharedPreferences.getString('gemini_api_key')).thenReturn(null);

      // act
      final call = dataSource.generateInsight;

      // assert
      expect(() => call('test prompt'), throwsA(isA<Exception>()));
    });

    test('should throw Exception when API key is empty', () async {
      // arrange
      when(mockSharedPreferences.getString('gemini_api_key')).thenReturn('');

      // act
      final call = dataSource.generateInsight;

      // assert
      expect(() => call('test prompt'), throwsA(isA<Exception>()));
    });
  });
}
