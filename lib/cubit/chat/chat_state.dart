
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final List<Map<String, dynamic>> messages; // List of messages
  final bool isLoading; // Indicates if data is being loaded
  final String? errorMessage; // Optional error message

  const ChatState({
    required this.messages,
    this.isLoading = false,
    this.errorMessage,
  });

  // Initial state with no messages
  factory ChatState.initial() {
    return const ChatState(messages: []);
  }

  // Copy with method to create a new instance with modified values
  ChatState copyWith({
    List<Map<String, dynamic>>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, errorMessage];
}
