import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_quran/Componen/colors.dart';


class VerseTile extends StatefulWidget {
  final int number;
  final String arabic;
  final String translation;
  final String audioUrl;

  const VerseTile({
    super.key,
    required this.number,
    required this.arabic,
    required this.translation,
    required this.audioUrl,
  });

  @override
  State<VerseTile> createState() => _VerseTileState();
}

class _VerseTileState extends State<VerseTile> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // LISTENER SAAT AUDIO SELESAI
    player.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  void togglePlay() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(UrlSource(widget.audioUrl));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: mainColor,
                    child: Text("${widget.number}",
                        style: const TextStyle(color: Colors.white)),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.share_outlined,
                          color: mainColor),
                      const SizedBox(width: 14),

                      // BUTTON PLAY MP3
                      GestureDetector(
                        onTap: togglePlay,
                        child: Icon(
                          isPlaying
                              ? Icons.pause_circle_outline
                              : Icons.play_arrow_outlined,
                          color: mainColor,
                        ),
                      ),

                      const SizedBox(width: 14),
                      const Icon(Icons.bookmark_border,
                          color:mainColor),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            widget.arabic,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 26),
          ),
        ),
        const SizedBox(height: 12),
        Text(widget.translation),
      ],
    );
  }
}
