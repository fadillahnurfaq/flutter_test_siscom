import 'package:fadillahnurfaqih_front_end/models/dropdown/select_data_model.dart';
import 'package:fadillahnurfaqih_front_end/services/barang_service.dart';
import 'package:fadillahnurfaqih_front_end/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/barang/kategori_barang_model.dart';
import '../models/barang/stok_barang_model.dart';

class TambahBarangController extends GetxController {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  RxList<SelectDataModel> datasKategori = RxList<SelectDataModel>([]);
  Rx<KategoriBarangModel?> selectedKategori = Rx<KategoriBarangModel?>(null);

  final List<SelectDataModel> datasKelompok = [
    SelectDataModel(id: "0", title: "Kelompok 1", subTitle: ""),
    SelectDataModel(id: "1", title: "Kelompok 2", subTitle: ""),
  ];

  Rx<SelectDataModel?> selectedKelompok = Rx<SelectDataModel?>(null);

  Future<void> getAllKategori() async {
    try {
      final List<KategoriBarangModel> results =
          await BarangService.getAllKategori();
      datasKategori.value = results
          .map(
            (e) => e.asSelectData(),
          )
          .toList();
      datasKategori.refresh();
    } catch (e) {
      CustomDialog.showMessage(message: e.toString());
    }
  }

  void changeKategori(KategoriBarangModel value) {
    selectedKategori.value = value;
    selectedKategori.refresh();
  }

  void resetKategori() {
    selectedKategori.value = null;
    selectedKategori.refresh();
  }

  void changeKelompok(SelectDataModel value) {
    selectedKelompok.value = value;
    selectedKelompok.refresh();
  }

  void resetKelompok() {
    selectedKelompok.value = null;
    selectedKelompok.refresh();
  }

  Future<void> save(BuildContext context) async {
    try {
      CustomDialog.showLoading(context);
      final StokBarangModel? result = await BarangService.saveStokBarang(
        nama: namaController.text.trim(),
        kategoriId: selectedKategori.value?.id ?? 0,
        stok: int.tryParse(stokController.text.trim()) ?? 0,
        kelompok: selectedKelompok.value?.title ?? "",
        harga:
            double.tryParse(hargaController.text.replaceAll("Rp. ", "")) ?? 0.0,
      );
      CustomDialog.hideLoading(context);
      if (result != null) {
        Get.back();
        CustomDialog.showMessage(message: "Berhasil tambah barang");
      }
    } catch (e) {
      CustomDialog.hideLoading(context);
      CustomDialog.showMessage(message: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllKategori();
  }
}
