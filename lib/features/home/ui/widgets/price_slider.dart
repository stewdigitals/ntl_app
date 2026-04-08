import 'package:flutter/material.dart';

class PriceSlider extends StatefulWidget {
  const PriceSlider({super.key});

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 30));

      if (!_scrollController.hasClients ||
          !_scrollController.position.hasContentDimensions) {
        continue;
      }

      final maxScroll = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;

      final next = current + 1;

      if (next >= maxScroll) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(next);
      }
    }
  }

  Widget _priceItem(String label, String price, bool isUp) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(width: 6),
        Text(
          price,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          isUp ? Icons.trending_up : Icons.trending_down,
          color: isUp ? Colors.green : Colors.red,
          size: 14,
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Container(
        color: const Color(0xFF1E1E1E),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Text("LIVE RATES:", style: TextStyle(color: Colors.white)),

            const SizedBox(width: 10),

            Expanded(
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: [
                  _priceItem("Gold", "₹6234", true),
                  _priceItem("Silver", "₹72", false),
                  _priceItem("Platinum", "₹2450", true),
                  _priceItem("Gold", "₹6234", true),
                  _priceItem("Silver", "₹72", false),
                  _priceItem("Platinum", "₹2450", true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
