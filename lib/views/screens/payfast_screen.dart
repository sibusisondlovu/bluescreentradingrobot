// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../config/theme.dart';
//
// class PayfastScreen extends StatefulWidget {
//   const PayfastScreen({super.key, required this.uri});
//   final dynamic uri;
//   static const id = 'payFast';
//
//   @override
//   State<PayfastScreen> createState() => _PayfastScreenState();
// }
//
// class _PayfastScreenState extends State<PayfastScreen> {
//   bool _isLoading = true;
//   // final _controller = WebViewController();
//   // String pageStatusMessage = 'please wait...';
//   //
//   // _onUrlChange(String url) {
//   //   if (mounted) {
//   //     setState(() {
//   //       if (url.contains("https://www.jaspay.co.za/success")) {
//   //     ;
//   //       } else if (url
//   //           .contains("https://www.jaspay.co.za/cancel")) {
//   //         Navigator.pushNamed(context, "paymentCancelledScreen");
//   //       }
//   //     });
//   //   }
//   // }
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
//   //   _controller.setNavigationDelegate(
//   //     NavigationDelegate(
//   //       onProgress: (int progress) {
//   //         // Update loading bar.
//   //       },
//   //       onUrlChange: (url) {
//   //         _onUrlChange(url.toString());
//   //       },
//   //       onPageStarted: (String url) {
//   //         setState(() {
//   //           _isLoading = false;
//   //         });
//   //       },
//   //       onPageFinished: (String url) {
//   //         setState(() {
//   //           _isLoading = false;
//   //         });
//   //
//   //         if (url == 'https://jaspagroup.co.za/payfast/success.html') {
//   //
//   //         }
//   //       },
//   //       onHttpError: (HttpResponseError error) {
//   //         // AwesomeDialog(
//   //         //   context: context,
//   //         //   dialogType: DialogType.error,
//   //         //   title: 'Error',
//   //         //   desc: error.response?.statusCode.toString(),
//   //         // ).show();
//   //         // setState(() {
//   //         //   _isLoading = false;
//   //         // });
//   //       },
//   //       onNavigationRequest: (NavigationRequest request) {
//   //         // Removed for testing with google.com
//   //         return NavigationDecision.navigate;
//   //       },
//   //       onWebResourceError: (WebResourceError error) {
//   //         AwesomeDialog(
//   //           context: context,
//   //           dialogType: DialogType.error,
//   //           title:"Error Code: ${error.errorCode}",
//   //           desc: error.description,
//   //
//   //         ).show();
//   //         setState(() {
//   //           _isLoading = false;
//   //         });
//   //       },
//   //     ),
//   //   );
//   //   _controller.loadRequest(Uri.parse(widget.uri.toString()));
//   //
//   // }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //
//   //   return Scaffold(
//   //       appBar: AppBar(
//   //         title: const Text('Payment'),
//   //         elevation: 0,
//   //         backgroundColor: AppTheme.mainColor,
//   //       ),
//   //       body: Stack(
//   //         children: [
//   //           Opacity(
//   //               opacity: _isLoading ? 0.0 : 1.0,
//   //               child: WebViewWidget(controller: _controller)),
//   //           Center(
//   //             child: Visibility(
//   //               visible: _isLoading,
//   //               child: const SpinKitFadingCube(
//   //                 color: AppTheme.ascentColor,
//   //                 size: 50,
//   //               ),
//   //             ),
//   //           )
//   //         ],
//   //       ));
//   // }
// }
