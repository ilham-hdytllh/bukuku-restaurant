import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UtilsRepository extends GetxController {
  static UtilsRepository get instance => Get.find();

  Future<List<Map<String, String>>> fetchCurrencyCodeData() async {
    // Baca file JSON dari assets
    final currencyCodeData =
        await rootBundle.loadString('assets/json/currency-code.json');

    // Ubah JSON menjadi objek Dart
    final List<dynamic> jsonList = json.decode(currencyCodeData);

    // Map untuk menyimpan data yang sudah digrouping
    Map<String, Map<String, dynamic>> groupedData = {};

    // Proses setiap entri dalam jsonList
    for (var data in jsonList) {
      final String currencyCode = data['currency_code'];

      // Periksa apakah currencyCode sudah ada dalam groupedData
      if (!groupedData.containsKey(currencyCode)) {
        // Jika belum, tambahkan dengan data baru
        groupedData[currencyCode] = {
          'currency_code': currencyCode,
          'countries': [data['country']]
        };
      } else {
        // Jika sudah ada, tambahkan nama negara ke dalam daftar yang ada
        groupedData[currencyCode]!['countries'].add(data['country']);
      }
    }

    // Konversi hasil grouping menjadi List<Map<String, String>>
    List<Map<String, String>> resultList = [];

    // Ubah Map ke dalam bentuk yang diinginkan
    for (var group in groupedData.values) {
      resultList.add({
        'currency_code': group['currency_code'],
        'countries':
            group['countries'].join(', '), // Gabungkan nama negara dengan koma
      });
    }

    // Urutkan berdasarkan currency_code secara ascending
    // resultList
    //     .sort((a, b) => a['currency_code']!.compareTo(b['currency_code']!));

    return resultList;
  }

  Future<List<Map<String, String>>> fetchPhoneCodeData() async {
    // Baca file JSON dari assets
    final phoneCodeData =
        await rootBundle.loadString('assets/json/phone_code.json');

    // Ubah JSON menjadi objek Dart
    final List<dynamic> jsonList = json.decode(phoneCodeData);

    // Map untuk menyimpan data yang sudah digrouping
    Map<String, Map<String, dynamic>> groupedData = {};

    // Proses setiap entri dalam jsonList
    for (var data in jsonList) {
      final String dialCode = data['dial_code'];

      // Periksa apakah dialCode sudah ada dalam groupedData
      if (!groupedData.containsKey(dialCode)) {
        // Jika belum, tambahkan dengan data baru
        groupedData[dialCode] = {
          'dial_code': dialCode,
          'countries': [data['name']]
        };
      } else {
        // Jika sudah ada, tambahkan nama negara ke dalam daftar yang ada
        groupedData[dialCode]!['countries'].add(data['name']);
      }
    }

    // Konversi hasil grouping menjadi List<Map<String, String>>
    List<Map<String, String>> resultList = [];

    // Ubah Map ke dalam bentuk yang diinginkan
    for (var group in groupedData.values) {
      resultList.add({
        'dial_code': group['dial_code'],
        'countries':
            group['countries'].join(', '), // Gabungkan nama negara dengan koma
      });
    }

    // Urutkan berdasarkan dial_code secara ascending
    // resultList.sort((a, b) => a['dial_code']!.compareTo(b['dial_code']!));

    return resultList;
  }

  Future<List<dynamic>> fetchProvinceData() async {
    // Baca file JSON dari assets
    final provinceData = await rootBundle
        .loadString('assets/json/provinsi/province_indonesia.json');

    // Ubah JSON menjadi objek Dart
    final List<dynamic> jsonList = json.decode(provinceData);

    // Urutkan berdasarkan dial_code secara ascending
    // resultList.sort((a, b) => a['dial_code']!.compareTo(b['dial_code']!));

    return jsonList;
  }

  Future<List<dynamic>> fetchCityData(String id) async {
    // Baca file JSON dari assets
    final cityData =
        await rootBundle.loadString('assets/json/kabupaten/$id.json');

    // Ubah JSON menjadi objek Dart
    final List<dynamic> jsonList = json.decode(cityData);

    // Urutkan berdasarkan dial_code secara ascending
    // resultList.sort((a, b) => a['dial_code']!.compareTo(b['dial_code']!));

    return jsonList;
  }

  Future<List<dynamic>> fetchDistrictData(String id) async {
    // Baca file JSON dari assets
    final districtData =
        await rootBundle.loadString('assets/json/kecamatan/$id.json');

    // Ubah JSON menjadi objek Dart
    final List<dynamic> jsonList = json.decode(districtData);

    // Urutkan berdasarkan dial_code secara ascending
    // resultList.sort((a, b) => a['dial_code']!.compareTo(b['dial_code']!));

    return jsonList;
  }

  init() {}
}
