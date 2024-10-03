// Placeholder for App Dashboard Page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(child: Text('App Dashboard')),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class AppDashboard extends StatelessWidget {
//   final bool isFreelancer; // Determine user role (true for freelancer, false for client)
//   final String userName; // User's name
//   final String userBio; // User's bio or description
//   final int jobsPosted; // For client users
//   final int proposalsSent; // For freelancer users
//   final int newMessages; // Count of new messages
//
//   AppDashboard({
//     required this.isFreelancer,
//     required this.userName,
//     required this.userBio,
//     this.jobsPosted = 0,
//     this.proposalsSent = 0,
//     this.newMessages = 0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Handle notifications
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildWelcomeSection(),
//             SizedBox(height: 20),
//             _buildQuickActions(context),
//             SizedBox(height: 20),
//             _buildRecentActivity(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWelcomeSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Welcome, $userName!',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//         Text(
//           userBio,
//           style: TextStyle(fontSize: 16),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQuickActions(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildQuickActionCard(
//           context,
//           icon: Icons.work,
//           title: isFreelancer ? 'Available Jobs' : 'Post Job',
//           onTap: () {
//             // Navigate to the respective page
//             Navigator.pushNamed(context, isFreelancer ? '/jobs' : '/postJob');
//           },
//         ),
//         _buildQuickActionCard(
//           context,
//           icon: Icons.assignment,
//           title: isFreelancer ? 'My Proposals' : 'View Proposals',
//           onTap: () {
//             // Navigate to the respective page
//             Navigator.pushNamed(context, isFreelancer ? '/myProposals' : '/viewProposals');
//           },
//         ),
//         _buildQuickActionCard(
//           context,
//           icon: Icons.message,
//           title: 'Messages',
//           onTap: () {
//             // Navigate to messages
//             Navigator.pushNamed(context, '/messages');
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQuickActionCard(BuildContext context,
//       {required IconData icon, required String title, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         child: Container(
//           width: 100,
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 40),
//               SizedBox(height: 8),
//               Text(title, textAlign: TextAlign.center),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecentActivity() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Recent Activity',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         ListTile(
//           title: Text('New Job Posted: 3'),
//           subtitle: Text('View Details'),
//           onTap: () {
//             // Navigate to job details
//           },
//         ),
//         ListTile(
//           title: Text('You have received 2 new messages'),
//           subtitle: Text('View Messages'),
//           onTap: () {
//             // Navigate to messages
//           },
//         ),
//         ListTile(
//           title: Text('Your proposal has been accepted!'),
//           subtitle: Text('View Proposal'),
//           onTap: () {
//             // Navigate to proposal details
//           },
//         ),
//       ],
//     );
//   }
// }
