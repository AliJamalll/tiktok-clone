import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  bool _isLoading = false;
  late VideoPlayerController controller;
  TextEditingController _songController = TextEditingController();
  TextEditingController _captioncController = TextEditingController();

  UploadVideoController uploadVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin:const EdgeInsets.only(left: 10,right: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(
                      controller: _songController,
                      labelText: 'song name',
                      icon: Icons.music_note,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin:const EdgeInsets.only(left: 10,right: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(
                      controller: _captioncController,
                      labelText: 'caption',
                      icon: Icons.music_note,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => uploadVideoController.uploadVideo(_songController.text,_captioncController.text,widget.videoPath),
                      child:_isLoading ?  Center(child: CircularProgressIndicator() ):Text(

                        'share',style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
