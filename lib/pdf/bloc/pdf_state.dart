part of 'pdf_bloc.dart';

enum PdfStatus {
  initial,
  loading,
  loaded,
  error,
}

class PdfState extends Equatable {
  const PdfState({
    required this.status,
  });

  const PdfState.initial()
      : this(        
          status: PdfStatus.initial,
        );

  final PdfStatus status;

  PdfState copyWith({
    PdfStatus? status,
  }) {
    return PdfState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
