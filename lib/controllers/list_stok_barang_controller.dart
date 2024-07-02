import 'package:fadillahnurfaqih_front_end/services/barang_service.dart';
import 'package:fadillahnurfaqih_front_end/utils/app_text_style.dart';
import 'package:fadillahnurfaqih_front_end/utils/request_state.dart';
import 'package:fadillahnurfaqih_front_end/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/barang/stok_barang_model.dart';
import '../utils/app_color.dart';

class ListStokBarangController extends GetxController {
  Rx<RequestState> stateListStokBarang = Rx(RequestStateInitial());
  Rx<IconData> actionIcon = Rx(
    Iconsax.search_normal_1,
  );
  Rx<Widget> widgetAppbar = Rx(
    TextLabel(
      text: "List Stok Barang",
      textStyle: AppTextStyle.h2,
    ),
  );
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxInt page = RxInt(10);

  RxString keyword = RxString("");
  RxBool isEdit = RxBool(false);
  RxList<StokBarangModel> selectedListStokBarang = RxList<StokBarangModel>([]);
  void changeIsEdit() {
    isEdit.toggle();
    isEdit.refresh();
    selectedListStokBarang.value = [];
    selectedListStokBarang.refresh();
  }

  void addForDelete({required final StokBarangModel data}) {
    if (selectedListStokBarang.contains(data)) {
      selectedListStokBarang.remove(data);
      selectedListStokBarang.refresh();
    } else {
      selectedListStokBarang.add(data);
      selectedListStokBarang.refresh();
    }
  }

  void choseAll() {
    if (stateListStokBarang.value
        is RequestStateLoaded<List<StokBarangModel>>) {
      final loadedData = (stateListStokBarang.value
              as RequestStateLoaded<List<StokBarangModel>>)
          .result;
      if (selectedListStokBarang == loadedData) {
        selectedListStokBarang.value = [];
        selectedListStokBarang.refresh();
      } else {
        selectedListStokBarang.value = loadedData;
        selectedListStokBarang.refresh();
      }
    }
  }

  Future<void> ontapActionIcon() async {
    if (actionIcon.value == Iconsax.search_normal_1) {
      actionIcon.value = Icons.close;
      actionIcon.refresh();
      widgetAppbar.value = CustomFormField(
        hintText: "Cari data...",
        onSubmit: (value) async {
          keyword.value = value;
          keyword.refresh();
          await onRefresh();
        },
        styleTextInputAction: TextInputAction.search,
        prefix: const Icon(
          Iconsax.search_normal_1,
          color: AppColors.grey,
        ),
      );
      widgetAppbar.refresh();
    } else {
      keyword.value = "";
      keyword.refresh();
      actionIcon.value = Iconsax.search_normal_1;
      actionIcon.refresh();
      widgetAppbar.value = TextLabel(
        text: "List Stok Barang",
        textStyle: AppTextStyle.h2,
      );
      widgetAppbar.refresh();
      await onRefresh();
    }
  }

  Future<void> onRefresh() async {
    page.value = 10;
    page.refresh();
    await getList();
    refreshController.refreshCompleted();
  }

  void onLoading() {
    page.value = page.value + 5;
    page.refresh();
    refreshController.loadComplete();
  }

  Future<void> getList() async {
    try {
      stateListStokBarang.value = RequestStateLoading();
      stateListStokBarang.refresh();
      final List<StokBarangModel> results =
          await BarangService.getAllStokBarang(
        keyword: keyword.value.trim(),
      );
      if (results.isEmpty) {
        isEdit.value = false;
        isEdit.refresh();
      }
      stateListStokBarang.value = results.isEmpty
          ? RequestStateEmpty()
          : RequestStateLoaded(result: results);
      stateListStokBarang.refresh();
    } catch (e) {
      stateListStokBarang.value = RequestStateError(message: e.toString());
      stateListStokBarang.refresh();
    } finally {
      refreshController.refreshCompleted();
    }
  }

  Future<void> deleteBulk(BuildContext context) async {
    try {
      CustomDialog.showLoading(context);
      final List<StokBarangModel> results =
          await BarangService.deleteBulkStokBarang(
        datas: selectedListStokBarang,
      );
      CustomDialog.hideLoading(context);
      if (results.isNotEmpty) {
        selectedListStokBarang.removeWhere((item) => results.contains(item));
        selectedListStokBarang.refresh();
        CustomDialog.showMessage(
            message: "Berhasil hapus data barang yang dipilih");
        await onRefresh();
      }
    } catch (e) {
      CustomDialog.hideLoading(context);
      CustomDialog.showMessage(message: e.toString());
    }
  }

  Future<void> delete(BuildContext context,
      {required final StokBarangModel data}) async {
    try {
      final String namaBarang = data.nama;

      final bool result = await BarangService.deleteStokBarang(data: data);

      if (result) {
        if (selectedListStokBarang.contains(data)) {
          selectedListStokBarang.remove(data);
          selectedListStokBarang.refresh();
        }
        await onRefresh();
        CustomDialog.showMessage(message: "Berhasil hapus $namaBarang");
      }
    } catch (e) {
      CustomDialog.showMessage(message: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getList();
  }
}
