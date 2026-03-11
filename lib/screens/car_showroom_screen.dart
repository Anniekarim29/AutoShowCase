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
      backgroundColor: const Color(0xFF0A0A0A),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            // ── Layer 1: Studio Background Gradient ──
            _buildStudioBackground(),

            // ── Layer 2: Top Spotlight Effect ──
            _buildSpotlightEffect(),

            // ── Layer 3: Cinematic Fog ──
            _buildCinematicFog(),

            // ── Layer 4: 3D Car Model ──
            _buildCarModel(),

            // ── Layer 5: Floor Reflection / Glossy Surface ──
            _buildFloorReflection(),

            // ── Layer 6: Top Vignette ──
            _buildVignette(),

            // ── Layer 7: Overlay UI ──
            _buildOverlayUI(),
          ],
        ),
      ),
    );
  }

  /// Dark studio radial gradient background
  Widget _buildStudioBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.0, -0.3),
          radius: 1.2,
          colors: [
            Color(0xFF1A1A1A), // Dark charcoal center
            Color(0xFF111111),
            Color(0xFF0A0A0A), // Near-black edges
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
                Colors.white.withValues(alpha: 0.06),
                Colors.white.withValues(alpha: 0.02),
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
              Colors.white.withValues(alpha: 0.03),
              Colors.white.withValues(alpha: 0.015),
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
                Colors.white.withValues(alpha: 0.04),
                Colors.white.withValues(alpha: 0.015),
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
                Colors.black.withValues(alpha: 0.5),
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
    return Positioned(
      bottom: 40,
      left: 24,
      right: 24,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Car Model Name
            Text(
              'HONDA NSX NA1',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 22,
                fontWeight: FontWeight.w300,
                letterSpacing: 8.0,
              ),
            ),
            const SizedBox(height: 6),
            // Sub-badge
            Text(
              'LB★WORKS',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 5.0,
              ),
            ),
            const SizedBox(height: 16),
            // Thin separator line
            Container(
              width: 60,
              height: 1,
              color: Colors.white.withValues(alpha: 0.15),
            ),
            const SizedBox(height: 12),
            // Tagline
            Text(
              'PREMIUM SHOWROOM',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.25),
                fontSize: 9,
                fontWeight: FontWeight.w500,
                letterSpacing: 4.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
