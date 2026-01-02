import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _MainColors {
  static const background = Color(0xFF0B0B0B);
  static const surface = Color(0xFF161616);
  static const accent = Color(0xFFF07127); // Warm orange
  static const textPrimary = Color(0xFFE0E0E0);
  static const textSecondary = Color(0xFF9E9E9E);
}

class _VaultScreenState extends State<VaultScreen> {
  double _timerProgress = 1.0;
  late Timer _timer;
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_secondsRemaining == 0) {
          _secondsRemaining = 30;
        }
        _timerProgress = (timer.tick % 300) / 300;
        // Inverse for the draining effect
        _timerProgress = 1.0 - _timerProgress;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _MainColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Vault", 
          style: TextStyle(color: _MainColors.textPrimary, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: _MainColors.textSecondary), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: _MainColors.textSecondary), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _MainColors.accent,
        shape: const StadiumBorder(),
        onPressed: () {},
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("Add Account", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: 5, // Mock data
        itemBuilder: (context, index) => _buildAccountCard(),
      ),
    );
  }

  Widget _buildAccountCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _MainColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Code copied to clipboard"), behavior: SnackBarBehavior.floating),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // 1. Accent Strip
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _MainColors.accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 16),
                
                // 2. Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Google", 
                        style: TextStyle(color: _MainColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("lokesh.ram@university.com", 
                        style: TextStyle(color: _MainColors.textSecondary, fontSize: 13)),
                      const SizedBox(height: 12),
                      const Text("482 910", 
                        style: TextStyle(
                          color: _MainColors.accent, 
                          fontSize: 32, 
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        )),
                    ],
                  ),
                ),

                // 3. Timer Section
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: CircularProgressIndicator(
                        value: _timerProgress,
                        strokeWidth: 3,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation<Color>(_MainColors.accent),
                      ),
                    ),
                    Text(
                      "${(30 * _timerProgress).toInt()}",
                      style: const TextStyle(color: _MainColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}