class LabelValue<T> {
  final String label;
  final T value;

  LabelValue({required this.label, required this.value});

  @override
  String toString() {
    return 'Instance of LabelValue(name:$label, value:$value)';
  }
}
