List<int> numbers = [12, 6, 34, 22, 41, 9];

void main() {
  List<int> ticket1 = [45, 2, 9, 18, 12, 33];
  List<int> ticket2 = [41, 17, 26, 32, 7, 35];

  checkNumbers(ticket2);
}

void checkNumbers(List<int> myNumbers) {
  int value = 0;
  for (int numbers1 in myNumbers) {
    for (int numbers2 in numbers) {
      if (numbers1 == numbers2) {
        value++;
      }
    }
  }

  print('You have $value matches');
}
