import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'package:photo_view/photo_view.dart' as PhotoImgView;

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => PhotoViewPage());
  }

  @override
  State<PhotoViewPage> createState() => _PhotoViewPage();
}

class _PhotoViewPage extends State<PhotoViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    var url = data["url"] ?? "";
    print(data);
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
                appBar: _buildAppBar(),
                backgroundColor: Colors.white,
                body: url.isEmpty
                    ? Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.black26, strokeWidth: 2)),
                      )
                    : Container(
                        child: PhotoImgView.PhotoView(
                        imageProvider: NetworkImage(url),
                      )))));
  }

  AppBar _buildAppBar() {
    return AppBar(
        bottom: PreferredSize(
            child: Container(
              color: AppColors.primaryThreeElementText,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
        title: Text(
          "PhotoView",
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ));
  }
}
