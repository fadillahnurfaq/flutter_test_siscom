import 'package:fadillahnurfaqih_front_end/controllers/list_stok_barang_controller.dart';
import 'package:fadillahnurfaqih_front_end/utils/utils.dart';
import 'package:fadillahnurfaqih_front_end/views/stock_barang/edit_barang_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/barang/stok_barang_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/widgets/widgets.dart';

class StokBarangContent extends StatelessWidget {
  final ListStokBarangController controller;
  final StokBarangModel data;
  const StokBarangContent(
      {super.key, required this.controller, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await CustomDialog.showBottomSheet(child: _contentBottomSheet(context));
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => controller.isEdit.isTrue
                    ? Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: CustomCheckBox(
                          value:
                              controller.selectedListStokBarang.contains(data),
                          onPressed: () {
                            controller.addForDelete(data: data);
                          },
                        ),
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(text: data.nama),
                    ExpandedView2Row(
                      flex1: 40,
                      flex2: 60,
                      child1: TextLabel(
                        text: "Stok : ${data.stok}",
                        textStyle: AppTextStyle.regularStyle.copyWith(
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                      child2: TextLabel(
                        text: Utils.formatCurrency(data.harga),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VerticalGap10(),
          const Underline(
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget _content1({required final String title, required final String value}) {
    return ExpandedView2Row(
      flex1: 40,
      flex2: 60,
      child1: TextLabel(text: title),
      child2: TextLabel(
        text: value,
        textStyle: AppTextStyle.regularStyle.copyWith(
          color: AppColors.grey,
        ),
      ),
    );
  }

  Widget _contentBottomSheet(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: AppColors.grey2,
            ),
          ),
          child: Column(
            children: [
              _content1(
                title: "Nama barang",
                value: data.nama,
              ),
              const VerticalGap5(),
              const Underline(
                width: double.infinity,
              ),
              _content1(
                title: "Kategori",
                value: data.kategoriId.toString(),
              ),
              const VerticalGap5(),
              const Underline(
                width: double.infinity,
              ),
              _content1(
                title: "Kelompok",
                value: data.kelompok,
              ),
              const VerticalGap5(),
              const Underline(
                width: double.infinity,
              ),
              _content1(
                title: "Stok",
                value: data.stok.toString(),
              ),
            ],
          ),
        ),
        const VerticalGap10(),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.grey2,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ExpandedView2Row(
            flex1: 40,
            flex2: 60,
            child1: const TextLabel(text: "Harga"),
            child2: TextLabel(
              text: Utils.formatCurrency(data.harga),
              textStyle: AppTextStyle.regularStyle.copyWith(),
            ),
          ),
        ),
        const VerticalGap20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomOutlinedButton(
                onPressed: () async {
                  Get.back();
                  await CustomDialog.showConfirmation(
                    message: "Apakah anda yakin menghapus ${data.nama}?",
                    onTapOk: () async =>
                        await controller.delete(context, data: data),
                  );
                },
                backgroundColor: AppColors.grey,
                text: "Hapus Barang",
                textStyle: AppTextStyle.h4.copyWith(color: AppColors.red),
              ),
            ),
            const HorizontalGap10(),
            Expanded(
              child: CustomButton(
                radius: 10.0,
                onPressed: () {
                  Get.back();
                  Get.to(EditBarangView(data: data));
                },
                text: "Edit Barang",
              ),
            ),
          ],
        )
      ],
    );
  }
}
