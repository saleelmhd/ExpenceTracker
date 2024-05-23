// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// // Repository to handle data fetching from Firestore
// class TransactionsRepository {
//   final String customerId;
//
//   TransactionsRepository(this.customerId);
//
//   Stream<QuerySnapshot> fetchTransactions() {
//     return FirebaseFirestore.instance
//         .collection('Customers')
//         .doc(customerId)
//         .collection('youGot')
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }
// }
//
// // Controller to handle business logic
// class TransactionsController extends StateNotifier<List<DocumentSnapshot>> {
//   final TransactionsRepository repository;
//
//   TransactionsController(this.repository) : super([]);
//
//   void fetchTransactions() async {
//     try {
//       final querySnapshot = await repository.fetchTransactions().first;
//       state = querySnapshot.docs;
//     } catch (e) {
//       // Handle error
//     }
//   }
// }
//
// // Provider for TransactionsRepository
// final transactionsRepositoryProvider =
// Provider.autoDispose<TransactionsRepository>((ref) {
//   final customerId = ref.watch(customerIdProvider); // Assuming you have customerIdProvider defined elsewhere
//   return TransactionsRepository(customerId);
// });
//
// // Provider for TransactionsController
// final transactionsControllerProvider =
// StateNotifierProvider.autoDispose<TransactionsController, List<DocumentSnapshot>>((ref) {
//   final repository = ref.watch(transactionsRepositoryProvider);
//   return TransactionsController(repository);
// });
//
// class YourWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final controller = watch(transactionsControllerProvider);
//
//     // Fetch transactions when the widget is built
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       controller.fetchTransactions();
//     });
//
//     return controller.when(
//       data: (transactions) {
//         if (transactions.isEmpty) {
//           return Center(
//             child: Text('No transactions yet.'),
//           );
//         }
//         // Your UI code to display transactions
//         return ListView.builder(
//           itemCount: transactions.length,
//           itemBuilder: (context, index) {
//             var transaction = transactions[index].data() as Map<String, dynamic>?;
//             // Your item UI here
//             return ListTile(
//               title: Text('Transaction: ${transaction?['amount'] ?? ""}'),
//             );
//           },
//         );
//       },
//       loading: () => CircularProgressIndicator(),
//       error: (error, stackTrace) => Text('Error: $error'),
//     );
//   }
// }
