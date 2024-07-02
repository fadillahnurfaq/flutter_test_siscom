part of "widgets.dart";

class CustomDropdown extends StatelessWidget {
  final String? hintText;
  final String titleSearch;
  final List<SelectDataModel> datas;
  final Function(SelectDataModel) onChanged;
  final String? Function(String?)? validator;
  final VoidCallback onReset;
  final TextEditingController controller;
  final bool withSearch;
  final bool fullScreen;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;
  const CustomDropdown({
    super.key,
    required this.titleSearch,
    required this.datas,
    required this.onChanged,
    required this.controller,
    required this.onReset,
    this.hintText,
    this.validator,
    this.withSearch = true,
    this.fullScreen = false,
    this.fontSize,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      readOnly: true,
      validator: validator,
      controller: controller,
      hintText: hintText,
      suffix: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.primary,
      ),
      fillColor: AppColors.backgroundcolor,
      contentPadding: contentPadding,
      onTap: () {
        CustomSelect.single(
          titleSearch: titleSearch,
          controller: controller,
          context: context,
          withSearch: withSearch,
          datas: datas,
          onChanged: onChanged,
          onReset: onReset,
          fullScreen: fullScreen,
          fontSize: fontSize,
        );
      },
    );
  }
}

class CustomSelect {
  static Future<void> single(
      {required List<SelectDataModel> datas,
      required TextEditingController controller,
      required titleSearch,
      required context,
      required Function(SelectDataModel) onChanged,
      final VoidCallback? onReset,
      bool withReset = true,
      bool withSearch = false,
      bool onlySelect = false,
      double? fontSize,
      bool fullScreen = true}) async {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    await Future.delayed(Duration.zero, () async {
      return showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => _SelectBase(
          fontSize: fontSize,
          withSearch: withSearch,
          datas: datas,
          controller: controller,
          titleSearch: titleSearch,
          fullScreen: fullScreen,
          onChanged: onChanged,
          onReset: onReset,
          withReset: withReset,
        ),
      );
    });
  }
}

class _SelectBase extends StatefulWidget {
  final List<SelectDataModel> datas;
  final String titleSearch;
  final TextEditingController controller;
  final bool withSearch;
  final double? fontSize;
  final bool fullScreen;
  final Function(SelectDataModel) onChanged;
  final VoidCallback? onReset;
  final bool withReset;
  const _SelectBase({
    required this.datas,
    required this.titleSearch,
    required this.onChanged,
    required this.controller,
    this.onReset,
    this.withReset = true,
    this.withSearch = true,
    this.fontSize,
    this.fullScreen = true,
  });

  @override
  State<_SelectBase> createState() => _SelectBaseState();
}

class _SelectBaseState extends State<_SelectBase> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisSize:
                    widget.fullScreen ? MainAxisSize.max : MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 4,
                    indent: MediaQuery.of(context).size.width * 0.35,
                    endIndent: MediaQuery.of(context).size.width * 0.35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextLabel(
                            text: '${widget.titleSearch} ',
                            textStyle: AppTextStyle.h1.copyWith(
                                color: AppColors.black,
                                fontSize: widget.fontSize ?? 20.0),
                          ),
                        ),
                        if (widget.withReset)
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              if (widget.onReset != null) {
                                widget.onReset!();
                              }
                            },
                            child: TextLabel(
                              text: "Reset",
                              textStyle: AppTextStyle.regularStyle
                                  .copyWith(color: AppColors.red),
                            ),
                          )
                      ],
                    ),
                  ),
                  widget.withSearch
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: CustomFormField(
                                onChanged: (value) {
                                  searchController.text = value;
                                  setState(() {});
                                },
                                prefix: const Icon(
                                  Icons.search,
                                  color: AppColors.grey,
                                ),
                                hintText: "Search",
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  widget.fullScreen
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.datas
                                .where((SelectDataModel value) =>
                                    "${value.title} ${value.subTitle}"
                                        .toUpperCase()
                                        .contains(searchController.text
                                            .toUpperCase()))
                                .length,
                            itemBuilder: (c, i) {
                              final SelectDataModel data = widget.datas
                                  .where((SelectDataModel value) =>
                                      "${value.title} ${value.subTitle}"
                                          .toUpperCase()
                                          .contains(searchController.text
                                              .toUpperCase()))
                                  .toList()[i];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  tileColor:
                                      widget.controller.text == data.title
                                          ? Colors.black
                                          : Colors.transparent,
                                  trailing: Icon(
                                    Icons.check,
                                    color: widget.controller.text == data.title
                                        ? AppColors.primary
                                        : Colors.transparent,
                                  ),
                                  title: TextLabel(
                                    text: "${data.title} ${data.subTitle}",
                                    textStyle: AppTextStyle.regularStyle
                                        .copyWith(
                                            fontWeight:
                                                widget.controller.text ==
                                                        data.title
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    widget.onChanged(data);
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.6,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.datas
                                  .where((SelectDataModel value) =>
                                      "${value.title} ${value.subTitle}"
                                          .toUpperCase()
                                          .contains(searchController.text
                                              .toUpperCase()))
                                  .length,
                              itemBuilder: (c, i) {
                                final SelectDataModel data = widget.datas
                                    .where((SelectDataModel value) =>
                                        "${value.title} ${value.subTitle}"
                                            .toUpperCase()
                                            .contains(searchController.text
                                                .toUpperCase()))
                                    .toList()[i];

                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    tileColor:
                                        widget.controller.text == data.title
                                            ? Colors.black
                                            : Colors.transparent,
                                    trailing: Icon(
                                      Icons.check,
                                      color:
                                          widget.controller.text == data.title
                                              ? AppColors.primary
                                              : Colors.transparent,
                                    ),
                                    title: TextLabel(
                                      text: "${data.title} ${data.subTitle}",
                                      textStyle: AppTextStyle.regularStyle
                                          .copyWith(
                                              fontWeight:
                                                  widget.controller.text ==
                                                          data.title
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      widget.onChanged(data);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
