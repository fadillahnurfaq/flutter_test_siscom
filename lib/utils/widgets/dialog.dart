part of "widgets.dart";

class CustomDialog {
  static showLoading(BuildContext context, {String? message}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primary,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  message ?? "Mohon Tunggu",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static hideLoading(BuildContext context) {
    return Navigator.pop(context);
  }

  static showMessage({required final String message}) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static Future<void> showBottomSheet({required final Widget child}) async {
    return await showModalBottomSheet(
      context: Get.context!,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundcolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const VerticalGap10(),
            Divider(
              thickness: 4,
              indent: Get.width * 0.35,
              endIndent: Get.width * 0.35,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 16.0,
                left: 16.0,
                bottom: 10.0,
              ),
              child: child,
            ),
          ],
        );
      },
    );
  }

  static Future<void> showConfirmation(
      {required final String message, required VoidCallback onTapOk}) async {
    return await showModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundcolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalGap10(),
              Divider(
                thickness: 4,
                indent: Get.width * 0.35,
                endIndent: Get.width * 0.35,
              ),
              const VerticalGap10(),
              TextLabel(
                text: message,
                textStyle: AppTextStyle.h4,
              ),
              const VerticalGap10(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onTapOk();
                      },
                      text: "Ok",
                    ),
                  ),
                  const HorizontalGap15(),
                  Expanded(
                    child: CustomButton(
                      backgroundColor: AppColors.red,
                      onPressed: () {
                        Get.back();
                      },
                      text: "Batal",
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
