import 'package:flutter/material.dart';
import '../widgets/doctor_bottom_nav.dart';

class _ScheduleSlot {
	final String time;
	final String label;
	final bool locked;

	const _ScheduleSlot({
		required this.time,
		required this.label,
		required this.locked,
	});
}

class DoctorScheduleScreen extends StatefulWidget {
	final bool selectionMode;
	final int initialDay;

	const DoctorScheduleScreen({
		super.key,
		this.selectionMode = false,
		this.initialDay = 5,
	});

	@override
	State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
	late int selectedDay;
	int? selectedSlotIndex;
	late List<_ScheduleSlot> _slots;
	late List<_ScheduleSlot> _addedSlots;

	@override
	void initState() {
		super.initState();
		selectedDay = widget.initialDay;
		_slots = [
			const _ScheduleSlot(time: '09:00 ص - 10:00 ص', label: 'فترة الصباح الأولى', locked: false),
			const _ScheduleSlot(time: '10:30 ص - 11:30 ص', label: 'فترة الصباح الثانية', locked: false),
			const _ScheduleSlot(time: '01:00 م - 02:00 م', label: 'محجوز مسبقاً', locked: true),
		];
		_addedSlots = [];
		selectedSlotIndex = _slots.indexWhere((slot) => !slot.locked);
	}

	void _handleSave() {
		if (widget.selectionMode) {
			if (selectedSlotIndex == null) {
				ScaffoldMessenger.of(
					context,
				).showSnackBar(const SnackBar(content: Text('اختر فترة متاحة أولاً')));
				return;
			}

			final selectedSlot = _slots[selectedSlotIndex!];
			final timeValue = selectedSlot.time.split('-').first.trim();
			Navigator.pop(context, {
				'date': 'اليوم، $selectedDay أكتوبر 2023',
				'time': timeValue,
			});
			return;
		}

		ScaffoldMessenger.of(
			context,
		).showSnackBar(const SnackBar(content: Text('تم حفظ التغييرات')));
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: const Color(0xFFF5F6F8),
			appBar: AppBar(
				backgroundColor: Colors.white,
				elevation: 0,
				centerTitle: true,
				automaticallyImplyLeading: false,
				leading: widget.selectionMode
						? IconButton(
								onPressed: () => Navigator.pop(context),
								icon: const Icon(Icons.arrow_back, color: Color(0xFF334155)),
							)
						: const Icon(Icons.notifications, color: Color(0xFF334155)),
				title: const Text(
					'إدارة الجدول الزمني',
					style: TextStyle(
						fontSize: 22,
						fontWeight: FontWeight.w900,
						color: Color(0xFF0F172A),
					),
				),
				actions: const [
					Padding(
						padding: EdgeInsets.all(10),
						child: CircleAvatar(
							radius: 20,
							backgroundColor: Color(0xFF14B8A6),
							child: Icon(Icons.person, color: Colors.white),
						),
					),
				],
			),
			body: SafeArea(
				child: ListView(
					padding: const EdgeInsets.all(16),
					children: [
						Container(
							padding: const EdgeInsets.all(16),
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.circular(24),
								border: Border.all(color: const Color(0xFFE6EDF5)),
							),
							child: Column(
								children: [
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: const [
											Icon(Icons.chevron_left, color: Color(0xFF475569), size: 30),
											Text(
												'أكتوبر 2023',
												style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900),
											),
											Icon(Icons.chevron_right, color: Color(0xFF475569), size: 30),
										],
									),
									const SizedBox(height: 18),
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceAround,
										children: const [
											Text('ح', style: TextStyle(color: Color(0xFF9AA5B1), fontWeight: FontWeight.w700)),
											Text('ن', style: TextStyle(color: Color(0xFF9AA5B1), fontWeight: FontWeight.w700)),
											Text('ث', style: TextStyle(color: Color(0xFF9AA5B1), fontWeight: FontWeight.w700)),
											Text('ر', style: TextStyle(color: Color(0xFF9AA5B1), fontWeight: FontWeight.w700)),
											Text('خ', style: TextStyle(color: Color(0xFF9AA5B1), fontWeight: FontWeight.w700)),
											Text('ج', style: TextStyle(color: Color(0xFF9AA5B1), fontWeight: FontWeight.w700)),
											Text('س', style: TextStyle(color: Color(0xFF9AA5B1), fontWeight: FontWeight.w700)),
										],
									),
									const SizedBox(height: 14),
									Wrap(
										alignment: WrapAlignment.center,
										spacing: 20,
										runSpacing: 16,
										children: List.generate(14, (index) {
											final day = index + 1;
											final selected = day == selectedDay;
											final outlined = day == 10;

											return GestureDetector(
												onTap: () => setState(() => selectedDay = day),
												child: Container(
													width: 48,
													height: 48,
													decoration: BoxDecoration(
														color: selected ? const Color(0xFF1D9BF0) : Colors.transparent,
														borderRadius: BorderRadius.circular(24),
														border: Border.all(
															color: outlined ? const Color(0xFFD8EAFB) : Colors.transparent,
														),
														boxShadow: selected
																? [
																		BoxShadow(
																			color: const Color(0xFF1D9BF0).withValues(alpha: 0.25),
																			blurRadius: 10,
																			offset: const Offset(0, 4),
																		),
																	]
																: null,
													),
													child: Center(
														child: Text(
															'$day',
															style: TextStyle(
																color: selected ? Colors.white : const Color(0xFF0F172A),
																fontSize: 16,
																fontWeight: FontWeight.w800,
															),
														),
													),
												),
											);
										}),
									),
								],
							),
						),
						const SizedBox(height: 16),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: [
								ElevatedButton.icon(
									onPressed: () {
										if (selectedSlotIndex == null) {
											ScaffoldMessenger.of(context).showSnackBar(
												const SnackBar(content: Text('اختر فترة أولاً')),
											);
											return;
										}
										setState(() {
											_addedSlots.add(_slots[selectedSlotIndex!]);
										});
										ScaffoldMessenger.of(context).showSnackBar(
											const SnackBar(content: Text('تم إضافة الموعد')),
										);
									},
									style: ElevatedButton.styleFrom(
										backgroundColor: const Color(0xFFE7F4FF),
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
										elevation: 0,
									),
									icon: const Icon(Icons.add, color: Color(0xFF1D9BF0)),
									label: const Text(
										'إضافة',
										style: TextStyle(color: Color(0xFF0369A1), fontWeight: FontWeight.w800),
									),
								),
								Text(
									'الفترات المتاحة ليوم $selectedDay أكتوبر',
									style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
								),
							],
						),
						const SizedBox(height: 10),
						..._slots.asMap().entries.map((entry) => _slotCard(entry.key, entry.value)),
						if (_addedSlots.isNotEmpty) ...[
							const SizedBox(height: 24),
							const Text(
								'الفترات المضافة',
								style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
							),
							const SizedBox(height: 10),
							..._addedSlots.asMap().entries.map((entry) => _addedSlotCard(entry.key, entry.value)),
						],
						const SizedBox(height: 14),
						SizedBox(
							height: 56,
							child: ElevatedButton.icon(
								onPressed: _handleSave,
								icon: const Icon(Icons.save, color: Colors.white),
								label: const Text(
									'حفظ التغييرات',
									style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
								),
								style: ElevatedButton.styleFrom(
									backgroundColor: const Color(0xFF1D9BF0),
									shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
								),
							),
						),
					],
				),
			),
			bottomNavigationBar: widget.selectionMode ? null : doctorBottomBar(context, 2),
		);
	}

	Widget _slotCard(int index, _ScheduleSlot slot) {
		final selected = selectedSlotIndex == index;
		final locked = slot.locked;

		return Container(
			margin: const EdgeInsets.only(bottom: 12),
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
			decoration: BoxDecoration(
				color: locked ? const Color(0xFFF3F5F8) : Colors.white,
				borderRadius: BorderRadius.circular(22),
				border: Border.all(
					color: selected ? const Color(0xFF1D9BF0) : const Color(0xFFE7EEF6),
					width: selected ? 2 : 1,
				),
			),
			child: InkWell(
				borderRadius: BorderRadius.circular(22),
				onTap: locked
						? null
						: () {
								setState(() {
									selectedSlotIndex = index;
								});
							},
				child: Row(
					children: [
						IconButton(
							onPressed: locked ? null : () {},
							icon: Icon(
								locked ? Icons.lock : Icons.delete,
								color: locked ? const Color(0xFFCBD5E1) : const Color(0xFFE11D48),
							),
						),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.end,
								children: [
									Text(
										slot.time,
										style: TextStyle(
											color: locked ? const Color(0xFF94A3B8) : const Color(0xFF0F172A),
											fontSize: 18,
											fontWeight: FontWeight.w900,
											decoration: locked ? TextDecoration.lineThrough : TextDecoration.none,
										),
									),
									const SizedBox(height: 2),
									Text(
										slot.label,
										style: TextStyle(
											color: locked ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
											fontWeight: FontWeight.w600,
										),
									),
								],
							),
						),
						const SizedBox(width: 12),
						CircleAvatar(
							radius: 23,
							backgroundColor: locked ? const Color(0xFFE8ECF2) : const Color(0xFFE7F4FF),
							child: Icon(
								locked ? Icons.event_busy : Icons.access_time,
								color: locked ? const Color(0xFF94A3B8) : const Color(0xFF1D9BF0),
							),
						),
					],
				),
			),
		);
	}

	Widget _addedSlotCard(int index, _ScheduleSlot slot) {
		return Container(
			margin: const EdgeInsets.only(bottom: 12),
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(22),
				border: Border.all(color: const Color(0xFFE7EEF6)),
			),
			child: Row(
				children: [
					IconButton(
						onPressed: () {
							setState(() {
								_addedSlots.removeAt(index);
							});
							ScaffoldMessenger.of(context).showSnackBar(
								const SnackBar(content: Text('تم حذف الموعد')),
							);
						},
						icon: const Icon(
							Icons.delete,
							color: Color(0xFFE11D48),
						),
					),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.end,
							children: [
								Text(
									slot.time,
									style: const TextStyle(
										color: Color(0xFF0F172A),
										fontSize: 18,
										fontWeight: FontWeight.w900,
									),
								),
								const SizedBox(height: 2),
								Text(
									slot.label,
									style: const TextStyle(
										color: Color(0xFF64748B),
										fontWeight: FontWeight.w600,
									),
								),
							],
						),
					),
					const SizedBox(width: 12),
					const CircleAvatar(
						radius: 23,
						backgroundColor: Color(0xFFE7F4FF),
						child: Icon(
							Icons.access_time,
							color: Color(0xFF1D9BF0),
						),
					),
				],
			),
		);
	}
}
