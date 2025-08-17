import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class TagModal extends StatelessWidget {
  const TagModal({super.key, required this.station, required this.comment});

  final double station;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          PointerInterceptor(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 300,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Text('Comment at Station $station:', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    comment,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
