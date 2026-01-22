import 'package:flutter/material.dart';
import 'package:green_fields/screens/request_pickup_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ScheduleItem> upcomingPickups = [];
  List<ScheduleItem> completedPickups = [];
  List<ScheduleItem> cancelledPickups = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSampleData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadSampleData() {
    // Sample upcoming pickups
    upcomingPickups = [
      ScheduleItem(
        id: "P-001",
        wasteType: "Recyclables (Paper/Plastic)",
        date: DateTime.now().add(const Duration(days: 1)),
        time: const TimeOfDay(hour: 10, minute: 30),
        location: "Residential - Front Door",
        status: "Scheduled",
        weight: "8 kg",
        specialInstructions: "Please separate paper and plastic",
      ),
      ScheduleItem(
        id: "P-002",
        wasteType: "Organic Waste",
        date: DateTime.now().add(const Duration(days: 3)),
        time: const TimeOfDay(hour: 14, minute: 0),
        location: "Backyard",
        status: "Confirmed",
        weight: "12 kg",
      ),
      ScheduleItem(
        id: "P-003",
        wasteType: "General Waste",
        date: DateTime.now().add(const Duration(days: 5)),
        time: const TimeOfDay(hour: 9, minute: 0),
        location: "Apartment - Lobby",
        status: "Pending",
        weight: "15 kg",
      ),
    ];

    // Sample completed pickups
    completedPickups = [
      ScheduleItem(
        id: "P-004",
        wasteType: "Electronic Waste",
        date: DateTime.now().subtract(const Duration(days: 2)),
        time: const TimeOfDay(hour: 11, minute: 0),
        location: "Loading Dock",
        status: "Completed",
        weight: "25 kg",
        rating: 5,
      ),
      ScheduleItem(
        id: "P-005",
        wasteType: "General Waste",
        date: DateTime.now().subtract(const Duration(days: 5)),
        time: const TimeOfDay(hour: 13, minute: 30),
        location: "Street Side",
        status: "Completed",
        weight: "18 kg",
        rating: 4,
      ),
    ];

    // Sample cancelled pickups
    cancelledPickups = [
      ScheduleItem(
        id: "P-006",
        wasteType: "Hazardous Waste",
        date: DateTime.now().subtract(const Duration(days: 1)),
        time: const TimeOfDay(hour: 10, minute: 0),
        location: "Commercial Area",
        status: "Cancelled",
        weight: "5 kg",
        cancellationReason: "Rescheduled by user",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text(
          "Pickup Schedule",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          tabs: const [
            Tab(icon: Icon(Icons.upcoming), text: "Upcoming"),
            Tab(icon: Icon(Icons.check_circle), text: "Completed"),
            Tab(icon: Icon(Icons.cancel), text: "Cancelled"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(),
          _buildCompletedTab(),
          _buildCancelledTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RequestPickupScreen()),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("New Pickup"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 4,
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Stats Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green.shade100, Colors.green.shade50],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Pickup Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCircle(
                        "${upcomingPickups.length}",
                        "Scheduled",
                        Icons.schedule,
                      ),
                      _buildStatCircle("2", "This Week", Icons.calendar_today),
                      _buildStatCircle("85%", "On Time", Icons.timer),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Upcoming Pickups List
            const Row(
              children: [
                Icon(Icons.upcoming, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  "Upcoming Pickups",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (upcomingPickups.isEmpty)
              _buildEmptyState(
                "No upcoming pickups",
                "Schedule a pickup to get started!",
                Icons.schedule_outlined,
              )
            else
              ...upcomingPickups.map(
                (pickup) => _buildPickupCard(pickup, true),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Completion Stats
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.orange),
                      SizedBox(width: 10),
                      Text(
                        "Your Recycling Impact",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildImpactStat("245", "kg Recycled", Icons.recycling),
                      _buildImpactStat("12", "Trees Saved", Icons.park),
                      _buildImpactStat("45", "Pickups", Icons.local_shipping),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Completed Pickups List
            const Row(
              children: [
                Icon(Icons.history, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  "Pickup History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (completedPickups.isEmpty)
              _buildEmptyState(
                "No completed pickups",
                "Your pickup history will appear here",
                Icons.history_toggle_off,
              )
            else
              ...completedPickups.map(
                (pickup) => _buildPickupCard(pickup, false),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelledTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Cancelled pickups can be rescheduled within 48 hours",
                      style: TextStyle(fontSize: 14, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Cancelled Pickups List
            const Row(
              children: [
                Icon(Icons.cancel, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  "Cancelled Pickups",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (cancelledPickups.isEmpty)
              _buildEmptyState(
                "No cancelled pickups",
                "Great! All your pickups are on track",
                Icons.check_circle_outline,
              )
            else
              ...cancelledPickups.map(
                (pickup) => _buildPickupCard(pickup, false),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickupCard(ScheduleItem pickup, bool isUpcoming) {
    Color statusColor = _getStatusColor(pickup.status);
    IconData statusIcon = _getStatusIcon(pickup.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pickup.wasteType,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "ID: ${pickup.id}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    pickup.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildDetailIcon(Icons.calendar_today, Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      "${pickup.date.day}/${pickup.date.month}/${pickup.date.year}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 16),
                    _buildDetailIcon(Icons.access_time, Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      pickup.time.format(context),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildDetailIcon(Icons.location_on, Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        pickup.location,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildDetailIcon(Icons.scale, Colors.purple),
                    const SizedBox(width: 8),
                    Text(pickup.weight, style: const TextStyle(fontSize: 14)),
                    if (pickup.rating != null) ...[
                      const Spacer(),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              index < pickup.rating!
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                if (pickup.specialInstructions != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailIcon(Icons.note, Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          pickup.specialInstructions!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (pickup.cancellationReason != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Reason: ${pickup.cancellationReason!}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Actions (only for upcoming)
          if (isUpcoming)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showRescheduleDialog(pickup),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Reschedule"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showCancelDialog(pickup),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCircle(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.green),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildImpactStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDetailIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(icon, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
      case 'confirmed':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Icons.schedule;
      case 'confirmed':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'completed':
        return Icons.check_circle_outline;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  void _showRescheduleDialog(ScheduleItem pickup) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reschedule Pickup"),
        content: const Text("Select a new date and time for your pickup."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement reschedule logic
            },
            child: const Text("Reschedule"),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(ScheduleItem pickup) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cancel Pickup"),
        content: const Text("Are you sure you want to cancel this pickup?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                cancelledPickups.add(pickup);
                upcomingPickups.remove(pickup);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Yes, Cancel"),
          ),
        ],
      ),
    );
  }
}

class ScheduleItem {
  final String id;
  final String wasteType;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final String status;
  final String weight;
  final String? specialInstructions;
  final int? rating;
  final String? cancellationReason;

  ScheduleItem({
    required this.id,
    required this.wasteType,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.weight,
    this.specialInstructions,
    this.rating,
    this.cancellationReason,
  });
}
