import 'package:app/common/entities/transfer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('shipping operation response parses numeric money fields', () {
    final response = ShippingOperationResponseEntity.fromJson({
      'code': 0,
      'msg': 'success',
      'data': [
        {
          'amount': 125.50,
          'profit': 3,
          'created_at': '2026-06-24T10:15:00+02:00',
          'business_name': 'Test POS',
          'first_name': 'Test',
          'phone': '0910000000',
          'recharge_type_name': 'Cash',
          'collect_type_name': null,
        }
      ],
    });

    expect(response.code, 0);
    expect(response.data, hasLength(1));
    expect(response.data!.first.amount, '125.5');
    expect(response.data!.first.profit, '3');
    expect(response.data!.first.businessName, 'Test POS');
    expect(response.data!.first.collectTypeName, isNull);
  });
}
