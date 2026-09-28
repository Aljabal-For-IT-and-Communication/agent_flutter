# Shipment and revenue reports

Both reports keep their single Agent / SalePoint selection and accept optional From / To timestamps. Leave both blank for all history, or select both with the end strictly later than the start. Search and refresh load the first page and the total for all matching records. Changing any filter invalidates the old rows and total. PDF Print fetches all matching records without replacing the on-screen list.

## Backend contract

POST `agent/sale_point_recharge_record_list` and `agent/sale_point_collect_record_list`:

```json
{"category":"SalePoint","id":7,"page":0,"start_date":"2026-09-01 00:00:00","end_date":"2026-09-28 23:00:00"}
```

`page` remains a row offset (page size 8); `-1` returns all matching records. Omitted or empty dates mean all history. Timestamp format is `yyyy-MM-dd HH:mm:ss`, interpreted in UTC+2, with start inclusive and end exclusive. The existing `data` array and transaction fields are preserved. Responses add `total_amount`, an exact decimal string computed across all matching records, not just the current page; an empty report returns `data: []` and `total_amount: "0"`.

Rows and totals use the same authenticated-agent, recipient, created-at, and soft-delete filters. Revenue continues to use collection category 2; shipment retains its existing transaction categories, including signed amounts. No schema migration or new endpoint is needed.

## Printing and release order

PDFs use the app's bundled logo and Cairo font, the active Arabic/English language, the selected recipient and period, transaction dates in UTC+2, exact-decimal totals, and collection/recharge type summaries. Type summaries are separate views of the same transactions and must not be added together. Print is guarded against duplicate taps, filter changes, request failures, and incomplete exports.

Deploy the Go update before releasing the Flutter update. Old clients can continue reading the unchanged `data` array. The new app explicitly asks for a server update if `total_amount` is missing, avoiding silently incomplete exports from an older endpoint.

## Verification

- Flutter: `flutter test --no-pub`.
- PDF samples from the actual builder: `flutter test --no-pub --dart-define=REPORT_PDF_QA=true test/recipient_report_test.dart`; samples are written to ignored `tmp/pdfs/`.
- Go: `go test ./internal/controller/agent ./internal/validator/form ./routes`.
- Go query/HTTP integration coverage: supply `SALE_POINT_TEST_MYSQL_DSN` with permission to create a disposable database. Tests create and remove a unique `recipient_report_test_*` database, never application tables.
