import 'package:fadillahnurfaqih_front_end/models/dropdown/select_data_model.dart';
import 'package:fadillahnurfaqih_front_end/services/barang_service.dart';
import 'package:fadillahnurfaqih_front_end/utils/utils.dart';
import 'package:fadillahnurfaqih_front_end/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/barang/kategori_barang_model.dart';
import '../models/barang/stok_barang_model.dart';

class EditBarangController extends GetxController {
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
  void init({required final StokBarangModel data}) {
    namaController.text = data.nama;
    stokController.text = data.stok.toString();
    hargaController.text = Utils.formatCurrency(data.harga);
    selectedKelompok.value = datasKelompok.firstWhereOrNull(
      (e) => e.title == data.kelompok,
    );
    selectedKelompok.refresh();
  }

  Future<void> getAllKategori({required final StokBarangModel data}) async {
    try {
      final List<KategoriBarangModel> results =
          await BarangService.getAllKategori();
      datasKategori.value = results
          .map(
            (e) => e.asSelectData(),
          )
          .toList();
      datasKategori.refresh();
      selectedKategori.value = results.firstWhereOrNull(
        (e) => e.id == data.kategoriId,
      );
      selectedKategori.refresh();
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

  Future<void> edit(BuildContext context,
      {required final StokBarangModel data}) async {
    try {
      CustomDialog.showLoading(context);
      final StokBarangModel dataBarang = StokBarangModel(
        data.id,
        namaController.text.trim(),
        selectedKategori.value?.id ?? 0,
        int.tryParse(stokController.text.trim()) ?? 0,
        selectedKelompok.value?.title ?? "",
        double.tryParse(hargaController.text.replaceAll("Rp. ", "")) ?? 0.0,
      );
      final StokBarangModel? result = await BarangService.editStokBarang(
        data: dataBarang,
      );
      CustomDialog.hideLoading(context);
      if (result != null) {
        Get.back();
        CustomDialog.showMessage(message: "Berhasil edit barang");
      }
    } catch (e) {
      CustomDialog.hideLoading(context);
      CustomDialog.showMessage(message: e.toString());
    }
  }
}
