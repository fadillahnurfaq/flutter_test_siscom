import 'package:fadillahnurfaqih_front_end/controllers/list_stok_barang_controller.dart';
import 'package:fadillahnurfaqih_front_end/models/barang/stok_barang_model.dart';
import 'package:fadillahnurfaqih_front_end/utils/app_color.dart';
import 'package:fadillahnurfaqih_front_end/utils/app_text_style.dart';
import 'package:fadillahnurfaqih_front_end/utils/widgets/app_transitions.dart';
import 'package:fadillahnurfaqih_front_end/utils/widgets/widgets.dart';
import 'package:fadillahnurfaqih_front_end/views/stock_barang/tambah_barang_view.dart';
import 'package:fadillahnurfaqih_front_end/views/stock_barang/widgets/stok_barang_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/request_state.dart';

class ListStokBarangView extends StatelessWidget {
  const ListStokBarangView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListStokBarangController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => AppTransitions(
            child: controller.widgetAppbar.value,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.ontapActionIcon(),
            child: Obx(() => AppTransitions(
                  child: Icon(
                    controller.actionIcon.value,
                  ),
                )),
          ),
          const HorizontalGap10(),
        ],
      ),
      body: AppRefresher(
        controller: controller.refreshController,
        onLoading: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          controller.onLoading();
        },
        onRefresh: () => controller.onRefresh(),
        child: Obx(
          () => WidgetAnimator<List<StokBarangModel>>(
            requestState: controller.stateListStokBarang.value,
            successWidget: (result) {
              return ListView(
                padding: const EdgeInsets.all(16.0),
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ExpandedView2Row(
                    flex1: 60,
                    flex2: 40,
                    child1: TextLabel(
                        text:
                            "${result.length} ${controller.keyword.isEmpty ? "Data ditampilkan" : "Data Cocok"}"),
                    child2: GestureDetector(
                      onTap: () => controller.changeIsEdit(),
                      child: Obx(
                        () => TextLabel(
                          text: controller.isEdit.isFalse
                              ? "Edit Data"
                              : "Batal Edit",
                          textStyle: AppTextStyle.regularStyle.copyWith(
                            color: controller.isEdit.isFalse
                                ? AppColors.blue
                                : AppColors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalGap20(),
                  ListView.separated(
                    itemCount: result.length,
                    separatorBuilder: (context, index) => const VerticalGap10(),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final StokBarangModel data = result[index];
                      return StokBarangContent(
                        controller: controller,
                        data: data,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => controller.isEdit.isTrue
            ? const SizedBox()
            : FloatingActionButton.extended(
                onPressed: () => Get.to(const TambahBarangView())?.then(
                  (_) async {
                    await controller.onRefresh();
                  },
                ),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                label: TextLabel(
                  text: "Barang",
                  textStyle: AppTextStyle.regularStyle
                      .copyWith(color: AppColors.backgroundcolor),
                ),
                icon: const Icon(
                  Icons.add,
                  color: AppColors.backgroundcolor,
                ),
              ),
      ),
      bottomNavigationBar: Obx(() => controller.isEdit.isFalse
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => CustomCheckBox(
                          value: controller.stateListStokBarang.value
                                  is RequestStateLoaded<List<StokBarangModel>>
                              ? controller.selectedListStokBarang ==
                                  (controller.stateListStokBarang.value
                                          as RequestStateLoaded<
                                              List<StokBarangModel>>)
                                      .result
                              : false,
                          onPressed: () {
                            controller.choseAll();
                          },
                          content: const TextLabel(text: "Pilih semua"),
                        ),
                      ),
                      Obx(() => controller.selectedListStokBarang.isNotEmpty
                          ? CustomOutlinedButton(
                              onPressed: () async {
                                await CustomDialog.showConfirmation(
                                  message:
                                      "Apakah anda yakin menghapus data stok barang yang anda pilih?",
                                  onTapOk: () async {
                                    await controller.deleteBulk(context);
                                  },
                                );
                              },
                              backgroundColor: AppColors.grey,
                              text: "Hapus Barang",
                              textStyle: AppTextStyle.h4
                                  .copyWith(color: AppColors.red),
                            )
                          : const SizedBox())
                    ],
                  ),
                ],
              ),
            )),
    );
  }
}
