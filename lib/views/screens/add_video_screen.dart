import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  PickVideo(ImageSource src,BuildContext context)async{
    final video = await ImagePicker().pickVideo(source: src);
    if(video!=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmScreen(
        videoFile: File(video.path),videoPath: video.path,)));
    }else{

    }
  }

  showOptionsDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () => PickVideo(ImageSource.gallery,context) ,
              child: Row(
                children: const [
                  Icon(Icons.image),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Gallary',style: TextStyle(fontSize: 20),),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => PickVideo(ImageSource.gallery,context),
              child: Row(
                children: const [
                  Icon(Icons.camera_alt),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('camera',style: TextStyle(fontSize: 20),),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  Icon(Icons.cancel_outlined),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('cancel',style: TextStyle(fontSize: 20),),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(12)
            ),
            child: const Center(
              child: Text('Add Video',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ),
    );
  }
}
