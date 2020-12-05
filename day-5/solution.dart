import 'dart:io';
import 'dart:math';

Future<List<String>> readInput() async => (await new File('./day-5/input.txt').readAsString()).split('\r\n');

int ascending(int left, int right) => left - right;
bool includes<T>(List<T> collection, T value) => collection.indexOf(value) >= 0;

class BoardingPass {
  int row;
  int column;

  int get seatId => (row * 8) + column;

  BoardingPass(this.row, this.column);

  factory BoardingPass.fromInput(String input) {
    final rowInBinary = input.substring(0, 7).replaceAll('F', '0').replaceAll('B', '1');
    final row = int.parse(rowInBinary, radix: 2);

    final columnInBinary = input.substring(7, 10).replaceAll('L', '0').replaceAll('R', '1');
    final column = int.parse(columnInBinary, radix: 2);

    return BoardingPass(row, column);
  }
}

void main() async {
  final fileContent = await readInput();

  final passes = fileContent.map((input) => BoardingPass.fromInput(input));
  final highestSeatId = passes.map((pass) => pass.seatId).reduce(max);

  print('Highest seat id: ${highestSeatId}');

  final seatIds = passes.map((pass) => pass.seatId).toList();
  seatIds.sort(ascending);

  final mySeatId = seatIds.firstWhere((seatId) => !includes(seatIds, seatId - 1) && includes(seatIds, seatId - 2)) - 1;

  print('My seat: ${mySeatId}');
  
}
