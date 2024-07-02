import 'package:fadillahnurfaqih_front_end/controllers/edit_barang_controller.dart';
import 'package:fadillahnurfaqih_front_end/models/barang/kategori_barang_model.dart';
import 'package:fadillahnurfaqih_front_end/models/barang/stok_barang_model.dart';
import 'package:fadillahnurfaqih_front_end/utils/app_text_style.dart';
import 'package:fadillahnurfaqih_front_end/utils/build_context_ext.dart';
import 'package:fadillahnurfaqih_front_end/utils/validator.dart';
import 'package:fadillahnurfaqih_front_end/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBarangView extends StatefulWidget {
  final StokBarangModel data;
  const EditBarangView({
    super.key,
    required this.data,
  });

  @override
  State<EditBarangView> createState() => _EditBarangViewState();
}

class _EditBarangViewState extends State<EditBarangView> {
  final controller = Get.put(EditBarangController());

  @override
  void initState() {
    super.initState();
    controller.init(data: widget.data);
    controller.getAllKategori(data: widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          title: TextLabel(
            text: "Edit Barang",
            textStyle: AppTextStyle.h2,
          ),
        ),
        body: Form(
          key: controller.formState,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            physics: const ScrollPhysics(),
            children: [
              ColumnFormField(
                text: "Nama Barang*",
                hintText: "Masukkan Nama Barang",
                validator: (value) => Validator.required(
                  value,
                  message: "Nama Barang Belum diisi",
                ),
                controller: controller.namaController,
              ),
              const VerticalGap20(),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextLabel(text: "Kategori Barang*"),
                      const VerticalGap5(),
                      CustomDropdown(
                        titleSearch: "Cari Kategori Barang",
                        datas: controller.datasKategori,
                        hintText: "Masukkan Kategori Barang",
                        onChanged: (value) {
                          final KategoriBarangModel data = value.data;
                          controller.changeKategori(data);
                        },
                        controller: TextEditingController(
                          text: controller.selectedKategori.value?.nama,
                        ),
                        validator: (value) => Validator.required(
                          value,
                          message: "Kategori Barang Belum diisi",
                        ),
                        onReset: () {
                          controller.resetKategori();
                        },
                      ),
                    ],
                  )),
              const VerticalGap20(),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextLabel(text: "Kelompok Barang*"),
                      const VerticalGap5(),
                      CustomDropdown(
                        titleSearch: "Cari Kelompok Barang",
                        datas: controller.datasKelompok,
                        hintText: "Masukkan Kelompok Barang",
                        onChanged: (value) {
                          controller.changeKelompok(value);
                        },
                        controller: TextEditingController(
                          text: controller.selectedKelompok.value?.title,
                        ),
                        validator: (value) => Validator.required(
                          value,
                          message: "Kelompok Barang Belum diisi",
                        ),
                        onReset: () {
                          controller.resetKelompok();
                        },
                      ),
                    ],
                  )),
              const VerticalGap20(),
              ColumnFormField(
                text: "Stok*",
                hintText: "Masukkan Stok",
                validator: (value) => Validator.required(
                  value,
                  message: "Stok Belum diisi",
                ),
                controller: controller.stokController,
                isNumberOnly: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                maxLength: 4,
              ),
              const VerticalGap20(),
              ColumnFormField(
                text: "Harga*",
                hintText: "Masukkan Harga",
                styleTextInputAction: TextInputAction.done,
                validator: (value) => Validator.required(
                  value,
                  message: "Harga Belum diisi",
                ),
                controller: controller.hargaController,
                isCurrency: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            height: 54.0,
            onPressed: () async {
              context.hideKeyboard();
              if (!controller.formState.currentState!.validate()) {
                return;
              } else {
                await CustomDialog.showConfirmation(
                  message: "Apakah anda yakin edit barang ini?",
                  onTapOk: () async =>
                      await controller.edit(context, data: widget.data),
                );
              }
            },
            text: "Edit Barang",
          ),
        ),
      ),
    );
  }
}
