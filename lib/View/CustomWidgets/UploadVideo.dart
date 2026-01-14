import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UploadVideoCard extends StatefulWidget {
  final String text;
  final String title;
  final Function(File video) onVideoSelected;
  final String? initialVideoUrl;

  const UploadVideoCard({
    super.key,
    required this.text,
    required this.title,
    required this.onVideoSelected,
    this.initialVideoUrl,
  });

  @override
  State<UploadVideoCard> createState() => _UploadVideoCardState();
}

class _UploadVideoCardState extends State<UploadVideoCard> {
  File? _selectedVideo;
  VideoPlayerController? _videoController;
  final ImagePicker _picker = ImagePicker();

  @override
void initState() {
  super.initState();

  if (widget.initialVideoUrl != null && widget.initialVideoUrl!.isNotEmpty) {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.initialVideoUrl!))
      ..initialize().then((_) {
        setState(() {});
       
        _videoController!.play();
      });
  }
}

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      _videoController?.dispose();

      _videoController = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {
            _videoController!.play(); 
          });
        });

      setState(() {
        _selectedVideo = file;
      });

      widget.onVideoSelected(file);
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickVideo,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: _buildVideoContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoContent() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: VideoPlayer(_videoController!),
      );
    }
    

    return _uploadPlaceholder();
  }

  Widget _uploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Icon(Icons.video_call, color: Color(0xFF01ABAB), size: 40),
        SizedBox(height: 10),
        Text(
          'Upload your video in mp4 format.',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ],
    );
  }
}
