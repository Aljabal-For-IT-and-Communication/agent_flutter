# App Store Review Fix Implementation Notes

## Implemented

- Removed unused iOS Bluetooth, microphone, location, photo-add, and background-mode declarations.
- Rewrote camera and photo library purpose strings with app-specific reasons.
- Removed manual full photo-library permission request before gallery picking.
- Restored default HTTPS certificate validation for API and upload clients.
- Removed sensitive production logs for tokens, auth headers, chat payloads, websocket payloads, and raw API responses.
- Moved notification permission prompting out of app startup and into the Settings notification toggle.
- Added an in-app Privacy Policy route using `PRIVACY_POLICY_URL`.
- Added an in-app account deletion request flow through the existing support chat channel.

## Still Required Before App Store Submission

- Confirm `PRIVACY_POLICY_URL` points to a live public policy page.
- Add a true backend account deletion endpoint if Apple requires immediate self-service deletion.
- Verify Push Notifications capability and APNs entitlement in Xcode.
- Archive the iOS app and inspect Xcode's generated privacy report for missing third-party SDK manifests.
- Test permission prompts on a real iOS device.
