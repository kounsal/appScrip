  import 'package:flutter/material.dart';

Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    bool isLink = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  isLink
                      ? GestureDetector(
                          onTap: () {
                            // Handle link click
                          },
                          child: Text(
                            content,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : Text(
                          content,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
