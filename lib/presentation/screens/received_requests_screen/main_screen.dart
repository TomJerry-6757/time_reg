import 'package:flutter/material.dart';
import 'package:time_reg/models/request_Item.dart';
import 'package:time_reg/presentation/customs/custom_floating_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class ReceivedRequestsScreen extends StatefulWidget {
  const ReceivedRequestsScreen({super.key});

  @override
  State<ReceivedRequestsScreen> createState() => _ReceivedRequestsScreenState();
}

class _ReceivedRequestsScreenState extends State<ReceivedRequestsScreen> {
  final ValueNotifier<String> selectedButton = ValueNotifier("Чөлөө");

  List<RequestItem> leaveRequests = [
    RequestItem(title: "Чөлөө", description: "Эмнэлэг орно", time: "12:30 - 13:00 May 21", status: 'Approved'),
    RequestItem(title: "Чөлөө", description: "Эморно", time: "10:00 - 12:00 May 20", status: 'Declined'),
    RequestItem(title: "Чөлөө", description: "Эмнэлэг орно", time: "12:30 - 13:00 May 19", status: 'Waiting'),
  ];

  List<RequestItem> vacationRequests = [RequestItem(title: "Амралт", description: "Амралтаар явах", time: "09:00 - 18:00 May 18", status: 'Approved')];

  List<RequestItem> remoteRequests = [RequestItem(title: "Remote", description: "Гэрээс ажиллана", time: "10:00 - 17:00 May 17", status: 'Declined')];

  List<bool> _animatedFlags = [];

  @override
  void initState() {
    super.initState();
    _runStaggeredAnimation();
  }

  void _runStaggeredAnimation() {
    final currentList =
        selectedButton.value == "Чөлөө"
            ? leaveRequests
            : selectedButton.value == "Амралт"
            ? vacationRequests
            : remoteRequests;

    _animatedFlags = List.generate(currentList.length, (_) => false);

    for (int i = 0; i < currentList.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          setState(() {
            _animatedFlags[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Ирсэн хүсэлтүүд",
      body: SingleChildScrollView(
        child: ValueListenableBuilder<String>(
          valueListenable: selectedButton,
          builder: (context, value, _) {
            final displayedList =
                value == "Чөлөө"
                    ? leaveRequests
                    : value == "Амралт"
                    ? vacationRequests
                    : remoteRequests;

            if (_animatedFlags.length != displayedList.length) {
              _animatedFlags = List.generate(displayedList.length, (_) => false);
              _runStaggeredAnimation();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildButton("Чөлөө", value), _buildButton("Амралт", value), _buildButton("Remote", value)]),
                const SizedBox(height: 32),
                CustomText(text: "Ирсэн хүсэлтүүд", fontSize: 14, fontWeight: FontWeight.w600),
                const SizedBox(height: 12),
                ...displayedList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return _animatedListItem(item, index);
                }).toList(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        color: AppColors.darkGray,
        ontap: () {
          Navigator.pushNamed(context, '/createRequestScreen');
        },
      ),
    );
  }

  Widget _buildButton(String text, String selectedValue) {
    final bool isSelected = text == selectedValue;
    return GestureDetector(
      onTap: () {
        selectedButton.value = text;
        _runStaggeredAnimation();
      },
      child: Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(color: isSelected ? AppColors.darkGray : Colors.transparent, border: Border.all(width: 2, color: isSelected ? AppColors.darkGray : AppColors.lightGray), borderRadius: BorderRadius.circular(20)),
        child: Center(child: CustomText(text: text, fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? AppColors.white : AppColors.lightGray)),
      ),
    );
  }

  Widget _animatedListItem(RequestItem item, int index) {
    final isVisible = _animatedFlags.length > index && _animatedFlags[index];

    return AnimatedOpacity(duration: const Duration(milliseconds: 500), opacity: isVisible ? 1.0 : 0.0, curve: Curves.easeOut, child: Transform.translate(offset: isVisible ? Offset(0, 0) : Offset(0, 20), child: Padding(padding: const EdgeInsets.only(bottom: 10), child: _listItem(item, index))));
  }

  Widget _listItem(RequestItem item, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.symmetric(horizontal: 20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Icon(Icons.delete_rounded, color: AppColors.red, size: 30)),
      onDismissed: (_) {
        setState(() {
          leaveRequests.removeAt(index);
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/requestDetailScreen');
        },
        child: Container(
          decoration: BoxDecoration(color: AppColors.lightBackgroundGray, borderRadius: BorderRadius.circular(15), border: Border.all(width: 2, color: AppColors.lightGray)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: item.title, fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.darkGray),
                    CustomText(text: item.description, fontSize: 14, color: AppColors.darkGray),
                    const SizedBox(height: 15),
                    CustomText(text: item.time, fontSize: 14, color: AppColors.darkGray),
                  ],
                ),
                Icon(Icons.arrow_right_rounded, size: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
