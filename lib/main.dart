import 'package:fadillahnurfaqih_front_end/services/barang_service.dart';
import 'package:fadillahnurfaqih_front_end/utils/app_color.dart';
import 'package:fadillahnurfaqih_front_end/views/stock_barang/list_stok_barang_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await BarangService.saveInitialKategori();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FadillahNurFaqih_Front_End',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundcolor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundcolor,
          shadowColor: AppColors.grey2,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const ListStokBarangView(),
    );
  }
}
