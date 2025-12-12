import 'package:KGlam/View/user_side/Saloon_Details.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'Selected_Date.dart';

class Selected_Service extends StatefulWidget {
  final String imagePath;
  final String Servicename;
  final String description;
  final int imageheight;

  const Selected_Service({
    super.key,
    required this.imagePath,
    required this.Servicename,
    required this.imageheight,
    required this.description,
  });

  @override
  State<Selected_Service> createState() => _Selected_ServiceState();
}

class _Selected_ServiceState extends State<Selected_Service> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  late VideoPlayerController _videoController;

  List<Map<String, dynamic>> mediaList = [];

  @override
  void initState() {
    super.initState();

    mediaList = [
      {"type": "image", "path": widget.imagePath},
      {"type": "image", "path": "assets/images/wet.jpg"},
      {"type": "image", "path": "assets/images/STRAIGHT.jpg"},
      {"type": "video", "path": "assets/video/BlackVideo.mp4"},
    ];

    _videoController =
        VideoPlayerController.asset("assets/video/BlackVideo.mp4")
          ..initialize().then((_) {
            setState(() {});
          });

    _videoController.play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget buildMediaItem(Map item) {
    if (item["type"] == "image") {
      return Image.asset(
        item["path"],
        width: double.infinity,
        height: widget.imageheight.toDouble(),
        fit: BoxFit.cover,
      );
    } else {
      return _videoController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoController),
                  IconButton(
                    icon: Icon(
                      _videoController.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    },
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SalonDetailScreen()),
              ModalRoute.withName('/'),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xFF01ABAB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Browse Service",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: widget.imageheight.toDouble(),
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: mediaList.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return buildMediaItem(mediaList[index]);
              },
            ),
          ),

          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.8),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 14,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          Positioned(
            top: 430,
            left: 5,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                mediaList.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: widget.imageheight - 30),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.Servicename,
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Hairstyling service is designed to transform your look with precision and creativity. Our expert stylists craft styles that perfectly suit your face shape, personality, and lifestyle — whether it’s a sleek modern cut, soft curls, or a bold new trend.',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
