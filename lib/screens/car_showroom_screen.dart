import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class CarShowroomScreen extends StatefulWidget {
  const CarShowroomScreen({super.key});

  @override
  State<CarShowroomScreen> createState() => _CarShowroomScreenState();
}

class _CarShowroomScreenState extends State<CarShowroomScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC9C9C9),
      body: Stack(
        children: [
          // ── Layer 1: Fade-in Background and Effects ──
          FadeTransition(
            opacity: _fadeAnimation,
            child: Stack(
              children: [
                _buildStudioBackground(),
                _buildSpotlightEffect(),
                _buildCinematicFog(),
                _buildFloorReflection(),
                _buildVignette(),
              ],
            ),
          ),

          // ── Layer 2: 3D Car Model (Top-level to prevent lag) ──
          // Moving this above the transparent layers drastically improves performance
          _buildCarModel(),

          // ── Layer 3: Overlay UI (Fade-in) ──
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _buildOverlayUI(),
            ),
          ),
        ],
      ),
    );
  }

  /// Light studio radial gradient background
  Widget _buildStudioBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.0, -0.3),
          radius: 1.2,
          colors: [
            Color(0xFFFFFFFF), // Bright center
            Color(0xFFE2E2E2), // Light grey mid
            Color(0xFFC9C9C9), // Grey edges
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  /// Soft overhead spotlight cone
  Widget _buildSpotlightEffect() {
    return Positioned(
      top: -80,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 0.8,
              colors: [
                Colors.white.withValues(alpha: 0.4),
                Colors.white.withValues(alpha: 0.1),
                Colors.transparent,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
      ),
    );
  }

  /// Subtle cinematic fog at mid-bottom
  Widget _buildCinematicFog() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0.1),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 1.0],
          ),
        ),
      ),
    );
  }

  /// 3D car model viewer
  Widget _buildCarModel() {
    return Positioned.fill(
      child: ModelViewer(
        src: 'assets/2020_honda_nsx_na1_lbworks.glb',
        alt: 'Honda NSX NA1 LB Works 3D Model',
        autoPlay: true,
        autoRotate: true,
        cameraControls: true,
        disableZoom: true, // Disable zoom to prevent accidental stutters
        backgroundColor: Colors.transparent,
      ),
    );
  }

  /// Glossy floor reflection at bottom
  Widget _buildFloorReflection() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 140,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.white.withValues(alpha: 0.4),
                Colors.white.withValues(alpha: 0.15),
                Colors.transparent,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
      ),
    );
  }

  /// Top and side vignette for depth
  Widget _buildVignette() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.0,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.15),
              ],
              stops: const [0.6, 1.0],
            ),
          ),
        ),
      ),
    );
  }

  /// Minimal overlay UI — car name & branding
  Widget _buildOverlayUI() {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Car Model Name
          Text(
            'HONDA NSX NA1',
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.85),
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 8.0,
            ),
          ),
          const SizedBox(height: 6),
          // Sub-badge
          Text(
            'LB★WORKS',
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.6),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 5.0,
            ),
          ),
          const SizedBox(height: 16),
          // Thin separator line
          Container(
            width: 60,
            height: 1,
            color: Colors.black.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          // Tagline
          Text(
            'PREMIUM SHOWROOM',
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.5),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}
