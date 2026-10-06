MUTHA QUALITY PORTAL - REGISTRATION / NOTIFICATION UPGRADE

New registration fields:
- Employee ID
- Employee Name
- Department (dropdown)
- Designation
- Plant / Unit dropdown: MFPL, MEPL-U3, MEPL-H21, MEPL-H25, DI, MSL
- Official Email
- WhatsApp / Mobile No.
- Reporting Manager
- WhatsApp notification opt-in
- Email notification opt-in

Admin history:
- User profile changes
- Role/status changes
- View/Add/Edit permission changes
- Drawing/WLS/Master Part/Scanning changes
- Notification queue/status

Automatic notifications:
The database now creates notification queue records for profile/access changes and scanning task updates.
For REAL outbound email/WhatsApp, connect a provider:
- Email: Resend, SendGrid, SMTP or another approved email provider.
- WhatsApp: Meta WhatsApp Business Cloud API or Twilio WhatsApp.
Never put provider API tokens in the browser/frontend.

The current portal can still use Open WhatsApp as a fallback from the Admin Audit Log.

SQL order:
1. PORTAL_ACCESS_MASTERPART_AUDIT.sql
2. SCANNING_DWM_OEE_UPGRADE.sql
3. PORTAL_REGISTRATION_NOTIFICATION_UPGRADE.sql

Edge Function template:
supabase/functions/send-portal-notifications/index.ts

Example provider secrets:
SUPABASE_SERVICE_ROLE_KEY
RESEND_API_KEY
MAIL_FROM
META_WHATSAPP_TOKEN
META_WHATSAPP_PHONE_NUMBER_ID
META_WHATSAPP_TEMPLATE_NAME
META_WHATSAPP_LANGUAGE

Deploy the Edge Function and call it from a secure scheduler/database webhook. Do not expose SUPABASE_SERVICE_ROLE_KEY or provider tokens in the frontend.
