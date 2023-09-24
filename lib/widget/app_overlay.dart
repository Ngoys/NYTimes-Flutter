import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/config/stylesheet/app_color.dart';
import 'package:nytimes/config/stylesheet/app_font.dart';
import 'package:nytimes/utils/constants.dart';
import 'package:nytimes/widget/app_container.dart';

class AppOverlay extends StatelessWidget {
  AppOverlay({
    required this.child,
    required this.blocProviderList,
    super.key,
  })  : _isLoadingNotifier = ValueNotifier<bool>(false),
        _isAlertDialogVisibleNotifier = ValueNotifier<bool>(false),
        _isNotificationVisibleNotifier = ValueNotifier<bool>(false),
        _overlayMessage = ValueNotifier<String>(''),
        _isNotificationOnTop = ValueNotifier<bool>(true),
        _notificationColor = ValueNotifier<Color>(AppColor.kellyGreen),
        _notificationMessage = ValueNotifier<String>(''),
        _dialogContext = ValueNotifier<BuildContext?>(null);

  final ValueNotifier<bool> _isLoadingNotifier;
  final ValueNotifier<bool> _isAlertDialogVisibleNotifier;
  final ValueNotifier<bool> _isNotificationVisibleNotifier;
  final ValueNotifier<bool> _isNotificationOnTop;
  final ValueNotifier<Color> _notificationColor;
  final ValueNotifier<String> _overlayMessage;
  final ValueNotifier<String> _notificationMessage;
  final Widget child;
  final List<BlocProvider<dynamic>> blocProviderList;
  final ValueNotifier<BuildContext?> _dialogContext;

  static AppOverlay? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AppOverlay>();
  }

  void showLoadingOverlay({String? overlayMessage}) {
    hideAllOverlays();
    _overlayMessage.value = overlayMessage ?? '';
    _isLoadingNotifier.value = true;
  }

  void hideLoadingOverlay() {
    _isLoadingNotifier.value = false;
  }

  void showAlertDialog({
    required BuildContext context,
    required String title,
    required String body,
    List<Widget>? actions,
    bool dismissible = true,
    Key? alertDialogKey,
  }) {
    hideAllOverlays();

    _isAlertDialogVisibleNotifier.value = true;

    showDialog<Widget>(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext buildContext) {
          _dialogContext.value = buildContext;
          return WillPopScope(
            onWillPop: () async => dismissible,
            child: AlertDialog(
                key: alertDialogKey ?? appOverlayKeyAlertDialog,
                title: Text(
                  title,
                  key: appOverlayKeyTitle,
                ),
                content: Text(
                  body,
                  key: appOverlayKeyMessage,
                ),
                actions: actions),
          );
        });
  }

  void hideAlertDialog() {
    if (_isAlertDialogVisibleNotifier.value && _dialogContext.value != null) {
      if (_dialogContext.value!.mounted) {
        _isAlertDialogVisibleNotifier.value = false;
        Navigator.of(_dialogContext.value!).pop();
      }
    }
  }

  void hideAllOverlays() {
    _overlayMessage.value = '';
    _isLoadingNotifier.value = false;
    _isNotificationVisibleNotifier.value = false;
    hideAlertDialog();
  }

  void showSuccessSnackBar(
      {required BuildContext context, required String snackBarMessage}) {
    showCustomSnackBar(
        context: context,
        snackBarMessage: snackBarMessage,
        color: AppColor.kellyGreen);
  }

  void showInfoSnackBar(
      {required BuildContext context, required String snackBarMessage}) {
    showCustomSnackBar(
        context: context,
        snackBarMessage: snackBarMessage,
        color: AppColor.primaryBlue);
  }

  void showErrorSnackBar(
      {required BuildContext context, required String snackBarMessage}) {
    showCustomSnackBar(
        context: context,
        snackBarMessage: snackBarMessage,
        color: AppColor.uaRed);
  }

  void showCustomSnackBar({
    required BuildContext context,
    required String snackBarMessage,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color ?? AppColor.kellyGreen,
        content: Text(snackBarMessage)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<ValueNotifier<dynamic>>[
        _isLoadingNotifier,
        _isAlertDialogVisibleNotifier
      ]),
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: <Widget>[
            if (child != null) AppContainer(child: child),
            if (_isLoadingNotifier.value)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.black,
                ),
              ),
            if (_isLoadingNotifier.value)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      key: appOverlayKeyLoadingIndicator,
                      color: AppColor.babyBlueEyes,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        _overlayMessage.value,
                        key: appOverlayKeyLoadingMessage,
                        style: AppFont.bodySmall.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            if (_isNotificationVisibleNotifier.value)
              Positioned(
                bottom: _isNotificationOnTop.value ? null : 10,
                top: _isNotificationOnTop.value ? 35 : null,
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: _notificationColor.value,
                        ),
                        height: 50,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _notificationMessage.value,
                                style: AppFont.bodySmall
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
          ],
        );
      },
      child: blocProviderList.isNotEmpty
          ? MultiBlocProvider(
              providers: blocProviderList,
              child: child,
            )
          : child,
    );
  }
}
